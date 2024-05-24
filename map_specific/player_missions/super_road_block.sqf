/*
==========================================================
THIS FILE WAS MADE BY DONNOVAN FROM BRAZIL
check BRPVP_lisence.txt FOR THE LISENCE

MORE INFORMATION:
http://www.brpvp.com
http://www.brpvp.com.br

DONNOVAN ON STEAM: 
https://steamcommunity.com/profiles/76561197975554637/
==========================================================
*/

_place = _this select 0;
_rad = _this select 1;
_skill = _this select 2;

_pFix = (AGLToASL _place) vectorDiff (AGLToASL [23804,20091,0]) vectorAdd [0,0,1];
_pFix2D = _place vectorDiff [23804,20091,0];

BRPVP_pmissEndCheckObjects = [];

//REMOVE STUFF
{
	_obj = _x;
	_noOwner = (_obj getVariable ["own",-2]) isEqualTo -2;
	if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {[_x,true] remoteExecCall ["hideObjectGlobal",2];};
} forEach nearestObjects [_place,[],50];

_pmissGroups = [
	[
		INDEPENDENT,
		[[23781.1,20073.5,0],[23837.5,20116.8,0]],
		[
			["I_soldier_F",[23790.7,20081.2,0],231,false],
			["I_Soldier_LAT2_F",[23797.2,20084.2,0],305,false],
			["I_Soldier_LAT2_F",[23796.7,20084.7,0],216,false],
			["I_soldier_F",[23790.7,20083.5,0],81,false],
			["I_soldier_F",[23789.3,20083.1,0],27,false]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_AR_F",[23791.5,20071.5,0.1],235,true,[1,2,3]],
			["I_Soldier_AR_F",[23793.9,20069.7,0.1],61,true,[1,2,3]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_AR_F",[23822.5,20116.5,0.2],51,true,[1,2,3]],
			["I_Soldier_AR_F",[23821.3,20117.3,0.2],158,true,[1,2,3]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_HMG_02_high_F",[23800.7,20113.2,34.3],[[-0.57,0.82,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],false]]],
			["I_HMG_02_high_F",[23807.5,20108.4,34.5],[[0.82,0.58,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],false]]],
			["I_HMG_02_high_F",[23801.2,20103.7,34.3],[[-0.8,-0.59,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],false]]],
			["I_HMG_02_high_F",[23831.6,20099.7,20.1],[[0.8,0.6,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],false]]],
			["I_HMG_02_high_F",[23782.1,20088.3,20.7],[[-0.83,-0.55,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],false]]]
		]
	],
	[
		INDEPENDENT,
		[[23873.4,20094.0,0],[23811.5,20141.8,0],[23746.8,20102.3,0],[23801.3,20037.8,0]],
		[
			["I_Soldier_TL_F",[23776.1,20123,0],333,false],
			["I_Soldier_GL_F",[23772.5,20116.7,0],107,false],
			["I_Soldier_LAT_F",[23790.2,20129.9,0],348,false]
		],
		[]
	],
	[
		INDEPENDENT,
		[[23746.8,20102.3,0],[23801.3,20037.8,0],[23873.4,20094.0,0],[23811.5,20141.8,0]],
		[
			["I_Soldier_TL_F",[23824.4,20054.2,0],143,false],
			["I_Soldier_GL_F",[23817.2,20052.1,0],222,false],
			["I_Soldier_LAT_F",[23829.4,20059.1,0],260,false]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_LT_01_AA_F",([23801.4,20076,16.2] vectorAdd [2*sin 60,2*cos 60,0]),[[-0.61,0.79,0.05],[0.03,-0.04,1]],[1,2,4],[["I_crew_F",["turret",[0]],false]]],
			["I_LT_01_AA_F",[23813.5,20110.4,16.8],[[0.58,-0.82,0],[0,0,1]],[1,2,4],[["I_crew_F",["turret",[0]],false]]],
			["I_LT_01_AT_F",[23785,20110.1,16.7],[[-0.82,-0.58,0],[0,0,1]],[1,2,4],[["I_crew_F",["turret",[0]],false]]],
			["I_LT_01_AT_F",[23830,20077.9,15.5],[[0.82,0.58,0.01],[0.01,-0.04,1]],[1,2,4],[["I_crew_F",["turret",[0]],false]]],
			["I_LT_01_cannon_F",[23810.3,20067.5,15.7],[[-0.22,-0.97,-0.02],[0.03,-0.03,1]],[1,2,4],[["I_crew_F",["turret",[0]],false]]],
			["I_LT_01_cannon_F",[23803.7,20119.7,16.7],[[0.08,1,0],[-0.01,0,1]],[1,2,4],[["I_crew_F",["turret",[0]],false]]],
			["I_APC_Wheeled_03_cannon_F",[23803.6,20085.6,17],[[0.15,0.99,0.02],[0.01,-0.02,1]],[1,2,4],[["I_crew_F",["turret",[0]],false]]],
			["I_MRAP_03_hmg_F",[23784.7,20085.6,16.9],[[-0.81,-0.59,0],[0.01,0,1]],[1,2,4],[["I_soldier_F",["turret",[0]],false]]],
			["I_MRAP_03_hmg_F",[23829.5,20102.6,16.6],[[0.79,0.61,-0.01],[0.04,-0.04,1]],[1,2,4],[["I_soldier_F",["turret",[0]],false]]]
		]
	],
	[
		INDEPENDENT,
		[[23837.5,20116.8,0],[23781.1,20073.5,0]],
		[
			["I_soldier_F",[23822,20105.6,0],49,false],
			["I_Soldier_LAT2_F",[23819.5,20099.7,0],119,false],
			["I_soldier_F",[23817.5,20105.1,0],288,false],
			["I_soldier_F",[23823.7,20105.6,0],214,false],
			["I_Soldier_LAT2_F",[23816.5,20102.8,0],334,false]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_medic_F",[23805.5,20108,12.8],229,true,[10]],
			["I_Officer_Parade_Veteran_F",[23806.9,20107.6,12.8],251,true,[10]],
			["I_soldier_F",[23807.2,20106.1,12.8],224,true,[10]]
		],
		[]
	]
];
_pmissEmptyVehs = [];
_pmissBuildings = [
	//["Land_Communication_F",[23791,20092.2,31.2],[[0.63,-0.78,0],[0,0,1]],true,[2],{_this setVariable ["brpvp_dome_radius",100,true];}],
	["Land_HBarrierBig_F",[23782.7,20099.9,15.86],[[-1,0.01,0],[0,-0.01,1]],false,[2]],
	["Land_HBarrierBig_F",[23779.3,20092.9,15.83],[[-0.57,0.82,0],[0,0,1]],false,[2]],
	["Land_HBarrier_5_F",[23782.1,20083.3,15.33],[[0.81,0.59,0],[0,-0.01,1]],false,[2]],
	["Land_HBarrier_5_F",[23786.2,20083.7,15.32],[[-0.57,0.82,0.01],[0,-0.01,1]],false,[2]],
	["Land_HBarrier_5_F",[23778.8,20087.7,15.34],[[0.81,0.59,0],[0,0,1]],false,[2]],
	["Land_Cargo_Patrol_V1_F",[23782.5,20090.1,19.53],[[0.8,0.6,0],[0,0,1]],true,[1]],
	["Land_PortableLight_double_F",[23781.3,20086.6,15.69],[[0.81,0.59,0],[0,0,1]],true,[2]],
	["Land_PortableLight_double_F",[23784.1,20095,15.72],[[-0.91,0.42,0],[0,0,1]],true,[2]],
	["Land_HBarrierBig_F",[23786.5,20107.1,15.89],[[-0.57,0.82,0],[-0.01,0,1]],false,[2]],
	["Land_HBarrier_5_F",[23785.9,20114.1,15.42],[[-0.58,0.81,0],[0,0,1]],false,[2]],
	["Land_HBarrier_5_F",[23781.5,20108.3,15.4],[[-0.84,-0.55,0],[0,0,1]],false,[2]],
	["Land_WaterTank_F",[23789.4,20102.6,15.37],[[0.79,0.62,0.01],[-0.01,0,1]],true,[2]],
	["Land_WaterTank_F",[23786.8,20100.7,15.35],[[0.79,0.62,0],[0,0,1]],true,[2]],
	["Land_HBarrierBig_F",[23817.7,20065.8,14.69],[[-0.56,0.83,0.04],[0.03,-0.03,1]],false,[2]],
	["Land_HBarrierBig_F",[23802.5,20068.3,15.17],[[0.81,0.59,0],[0.02,-0.03,1]],false,[2]],
	["Land_HBarrier_5_F",[23807,20064.6,14.47],[[-0.24,-0.97,-0.03],[0.02,-0.03,1]],false,[2]],
	["Land_HBarrier_5_F",[23812.4,20063.7,14.31],[[-0.08,-1,-0.03],[0.03,-0.03,1]],false,[2]],
	["Land_HBarrier_5_F",[23818.3,20088.9,14.97],[[0.81,0.59,0],[0.03,-0.04,1]],false,[2]],
	["Land_HBarrier_5_F",[23798,20080.9,15.18],[[-0.57,0.82,0.03],[0.02,-0.02,1]],false,[2]],
	["Land_HBarrier_5_F",[23796.5,20098.8,15.43],[[0.81,0.59,0.01],[0,-0.01,1]],false,[2]],
	["Land_HBarrier_5_F",[23801.1,20085.2,15.25],[[-0.99,0.13,0.01],[0.01,-0.01,1]],false,[2]],
	["Land_WaterBarrel_F",[23796.6,20096.2,15.23],[[-0.89,-0.46,-0.01],[0,-0.01,1]],false,[2]],
	["Land_MetalBarrel_F",[23795.8,20095.4,15.08],[[-0.16,0.99,0.01],[0,-0.01,1]],false,[2]],
	["Land_Cargo20_military_green_F",[23818.8,20070.8,14.92],[[0.61,-0.79,-0.05],[0.03,-0.03,1]],false,[2]],
	["Land_Cargo20_military_green_F",[23814.8,20083.1,15.47],[[-0.81,-0.59,0.01],[0.03,-0.04,1]],false,[2]],
	["Land_Cargo20_military_green_F",[23804.8,20070.6,15.31],[[-0.82,-0.58,0],[0.02,-0.03,1]],false,[2]],
	["Land_Cargo20_military_green_F",[23817.1,20084.7,15.45],[[-0.81,-0.59,0],[0.03,-0.04,1]],false,[2]],
	["Land_BarrelTrash_grey_F",[23795.1,20095.4,15.06],[[0.87,0.5,0.01],[0,-0.01,1]],false,[2]],
	["Land_BarrelEmpty_grey_F",[23794.8,20096.1,15.06],[[0.81,0.59,0.01],[0,-0.01,1]],false,[2]],
	["Land_BagBunker_Large_F",[23794.8,20073.6,15.18],[[0.81,0.59,0.01],[0.02,-0.03,1]],false],
	["Land_HBarrierBig_F",[23811.2,20119.2,16.01],[[-0.79,-0.62,-0.01],[-0.01,0,1]],false,[2]],
	["Land_HBarrierBig_F",[23792.2,20104.7,15.91],[[0.81,0.59,0],[0,0,1]],false,[2]],
	["Land_HBarrierBig_F",[23796.4,20121.3,15.92],[[0.59,-0.81,0.01],[0,0,1]],false,[2]],
	["Land_HBarrier_5_F",[23806.3,20123,15.52],[[0.22,0.97,0],[-0.01,0,1]],false,[2]],
	["Land_HBarrier_5_F",[23790.6,20117.3,15.43],[[-0.56,0.83,0],[-0.01,0,1]],false,[2]],
	["Land_HBarrier_5_F",[23812.7,20102.7,15.45],[[-0.98,0.21,0.02],[0.02,-0.01,1]],false,[2]],
	["Land_HBarrier_5_F",[23816,20107,15.47],[[-0.6,0.8,0.02],[0.01,-0.02,1]],false,[2]],
	["Land_HBarrier_5_F",[23801,20123.5,15.47],[[-0.03,1,0],[-0.01,0,1]],false,[2]],
	["Land_Cargo_Tower_V1_F",[23803,20108.7,27.63],[[-0.8,-0.59,0],[0,0,1]],true,[1]],
	["Land_Pallets_stack_F",[23801.1-1,20117.7-1,15.17],[[0.81,0.59,0],[0,0,1]],false,[2]],
	["Land_PaperBox_closed_F",[23800.2,20115.8,15.39],[[0.01,-1,0],[0,0,1]],false,[2]],
	["Land_PaperBox_closed_F",[23798.4,20117.2,15.38],[[-0.53,0.85,-0.01],[0,0,1]],false,[2]],
	["Land_PortableLight_double_F",[23799.5,20121.7,15.81],[[-0.46,0.89,0],[0,0,1]],true,[2]],
	["Land_PortableLight_double_F",[23808.4,20120.4,15.87],[[0.83,0.57,0],[0,0,1]],true,[2]],
	["Land_BagBunker_Large_F",[23819.1,20114.2,15.7],[[-0.79,-0.62,-0.01],[0,-0.01,1]],false],
	["Land_HBarrierBig_F",[23822.8,20083.2,15.08],[[-0.79,-0.62,0.01],[0.04,-0.03,1]],false,[2]],
	["Land_HBarrierBig_F",[23832.1,20088.3,14.91],[[1,0.03,-0.04],[0.04,-0.03,1]],false,[2]],
	["Land_HBarrierBig_F",[23828.6,20081,14.8],[[0.6,-0.8,-0.04],[0.01,-0.03,1]],false,[2]],
	["Land_HBarrierBig_F",[23835.3,20095.5,15.03],[[0.6,-0.8,-0.05],[0.03,-0.04,1]],false,[2]],
	["Land_HBarrier_5_F",[23828,20073.4,14.12],[[0.59,-0.81,-0.04],[0.02,-0.03,1]],false,[2]],
	["Land_HBarrier_5_F",[23823.4,20070.1,14.16],[[0.59,-0.81,-0.04],[0.03,-0.03,1]],false,[2]],
	["Land_HBarrier_5_F",[23832.3,20076.5,14.12],[[0.59,-0.81,-0.04],[0.01,-0.04,1]],false,[2]],
	["Land_HBarrier_5_F",[23833.5,20079.8,14.2],[[0.82,0.58,-0.02],[0.03,-0.01,1]],false,[2]],
	["Land_ToiletBox_F",[23828.1,20086.2,14.99],[[0.6,-0.8,-0.05],[0.04,-0.04,1]],true,[2]],
	["Land_ToiletBox_F",[23826.3,20084.8,15],[[0.59,-0.8,-0.05],[0.04,-0.03,1]],true,[2]],
	["Land_Pallets_F",[23822.6,20087.6,14.35],[[0.74,0.67,-0.01],[0.04,-0.04,1]],false,[2]],
	["Land_Cargo_Patrol_V1_F",[23831.9,20098.4,18.98],[[-0.79,-0.62,0],[0,0,1]],true,[1]],
	["Land_HBarrier_5_F",[23832.1,20105.1,15.05],[[-0.79,-0.62,0],[0.03,-0.04,1]],false,[2]],
	["Land_HBarrier_5_F",[23828,20104.5,15.18],[[0.6,-0.8,-0.05],[0.04,-0.03,1]],false,[2]],
	["Land_HBarrier_5_F",[23835.5,20100.7,14.76],[[-0.79,-0.62,0],[0.04,-0.04,1]],false,[2]],
	["Land_PortableLight_double_F",[23832.8,20101.7,15.23],[[-0.79,-0.62,0],[0,0,1]],true,[2]]
];

private _ata = [];
private _nos = [];
private _ts = [];
private _vd = [];
private _allObjs = [];
private _movFix1 = [];
private _movFix2 = [];
private _noLagWait = 0.1;
private _movFixCode = {
	private _lis = lineIntersectsSurfaces [getPosASL _this vectorAdd [0,0,0.3],getPosASL _this vectorAdd [0,0,-50],_this,objNull,true,1,"GEOM","NONE"];
	if (_lis isNotEqualTo []) then {
		private _ground = _lis select 0 select 2;
		if (isNull _ground) then {
			_movFix1 pushBack [_this,_movFixCodeToGround];
		} else {
			_movFix2 pushBack [[_this,_ground,_ground worldToModel (ASLToAGL getPosASL _this)],_movFixCodeToBellowObj];
		};
	};
};
_movFixCodeToGround = {
	private _pos = getPosWorld _this;
	_pos set [2,0];
	if (vectorUp _this isNotEqualTo [0,0,1]) then {_this setVectorUp surfaceNormal _pos;};
	if (_this call BRPVP_isMotorizedNoTurret) then {_this setPosASL (AGLToASL _pos vectorAdd [0,0,0.5]);} else {_this setPosASL AGLToASL _pos;};
};
_movFixCodeToBellowObj = {
	params ["_obj","_ground","_relative"];
	_obj setPosASL AGLToASL (_ground modelToWorld _relative);
};
{
	_x params ["_class","_pw","_vdu","_complete",["_flags",[]],["_code",{}]];
	private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_obj call _code;
	if (1 in _flags) then {
		_obj addEventHandler ["HandleDamage",{
			params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
			private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
			private _deltaDam = _dam-_damNow;
			_damNow+_deltaDam*0.25
		}];
	};
	if (2 in _flags) then {
		_movFix1 pushBack [_obj,_movFixCodeToGround];
	} else {
		_allObjs pushBack _obj;
	};
	_nos pushBack _obj;
	if (_complete && isDamageAllowed _obj) then {_obj setVariable ["brpvp_yes_minerva",true,true];};
} forEach _pmissBuildings;
{
	_x params ["_class","_pw","_vdu"];
	//private _obj = createSimpleObject [_class,[0,0,0]];
	private _obj = createVehicle [_class,BRPVP_posicaoFora,[],100,"NONE"];
	_obj call BRPVP_emptyBox;
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_allObjs pushBack _obj;
	_vd pushBack _obj;
	_obj call BRPVP_initPlayerMissionSceneryVehicles;
} forEach _pmissEmptyVehs;
{
	_x params ["_side","_wps","_onFoot","_onVeh"];
	private _grp = createGroup [_side,true];
	{
		_x params ["_class","_AGL","_dir","_noPath",["_flags",[]]];
		if (random 1 <= BRPVP_pmissAiPerc || _class isEqualTo "I_Officer_Parade_Veteran_F") then {
			private _u = _grp createUnit [_class,[0,0,0],[],0,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_u setPosASL ((AGLToASL _AGL) vectorAdd _pFix);
			_ata pushBack _u;
			_u setDir _dir;
			if (_noPath) then {_u disableAI "PATH";};
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			if (_class isEqualTo "I_Officer_Parade_Veteran_F") then {
				_u setVariable ["brpvp_can_ulfanize",false,2];
				_u setVariable ["brpvp_extra_chance",10];
				_u addEventHandler ["Killed",{
					private _pos = getPosASL (_this select 0) vectorAdd [0,0,1.25];
					private _suitCase = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
					_suitCase setPosASL _pos;
					_suitCase setVariable ["mny",round (8000000*BRPVP_missionValueMult),true];
					_this call BRPVP_botDaExp;
				}];
			} else {
				_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			};
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			if (_wps isEqualto [] && primaryWeapon _u isNotEqualTo "") then {
				//[_u,selectRandom ["STAND","STAND_IA","WATCH","WATCH1","WATCH2"]] call BIS_fnc_ambientAnimCombat;
			};
			BRPVP_pmissActualAiUnits pushBack _u;
			if (2 in _flags) then {_u disableAI "FSM";};
			if (3 in _flags) then {_u setUnitPos "UP";};
			if !(10 in _flags) then {_allObjs pushBack _u;};
		};
	} forEach _onFoot;
	{
		_x params ["_class","_pw","_vdu","_flags","_crew"];
		private _veh = createVehicle [_class,[0,0,0],[],10,"CAN_COLLIDE"];
		_veh setVectorDirAndUp _vdu;
		_veh setPosWorld (_pw vectorAdd _pFix);
		_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
		_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
		{
			_x params ["_class","_roleArray","_noPath"];
			_roleArray params ["_role",["_path",[]]];
			private _u = _grp createUnit [_class,[0,0,0],[],10,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			if (_noPath) then {_u disableAI "PATH";};
			if (_role isEqualTo "driver") then {_u moveInDriver _veh;};
			if (_role isEqualTo "turret") then {_u moveInTurret [_veh,_path];};
			if (_role isEqualTo "cargo") then {_u moveInCargo _veh;};
			if (_veh isKindOf "StaticWeapon") then {
				private _dir = [[0,0,0],_vdu select 0] call BIS_fnc_dirTo;
				_u doWatch (getPosASL _veh vectorAdd [100*sin _dir,100*cos _dir,3]);
			};
		} forEach _crew;
		if (1 in _flags) then {_veh lock true;};
		if (2 in _flags) then {_veh setVariable ["brpvp_cant_heli_town",true,true];};
		if (4 in _flags) then {_veh setUnloadInCombat [true,false];};
		_allObjs pushBack _veh;
		_vd pushBack _veh;
	} forEach _onVeh;
	if (count units _grp > 0) then {
		if (_wps isNotEqualTo []) then {
			{
				_wp = _grp addWayPoint [_x vectorAdd _pFix2D,0];
				_wp setWayPointType "MOVE";
				_wp setWaypointCompletionRadius 5;
			} forEach _wps;
			_wp = _grp addWayPoint [(_wps select 0) vectorAdd _pFix2D,0];
			_wp setWayPointType "CYCLE";
			_wp setWaypointCompletionRadius 5;
		};
	};
} forEach _pmissGroups;

//RARE LOOT
private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
_box allowDamage false;
_box setPosASL ([23803.1,20104.6,27.52] vectorAdd _pFix);
_box setDir 143.4;
[_box,0,1,true,40] call BRPVP_createCompleteLootBox;
_allObjs pushBack _box;

//FIX HEIGHT
{_x call _movFixCode;} forEach _allObjs;
{(_x select 0) call (_x select 1);} forEach _movFix1;
{(_x select 0) call (_x select 1);} forEach _movFix2;
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,[],{true}];
BRPVP_pmissSpawning = false;