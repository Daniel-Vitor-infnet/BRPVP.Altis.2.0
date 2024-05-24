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

_pFix = (AGLToASL _place) vectorDiff (AGLToASL [15332.7,14378.2,0]);
_pFix2D = _place vectorDiff [15332.7,14378.2,0];

BRPVP_pmissEndCheckObjects = [];

_pmissGroups = [
	[
		WEST,
		[[15427.2,14570.2,0],[15191.6,14433.8,0],[15232.6,14178.6,0],[15531.6,14290.6,0]],
		[],
		[
			["B_T_Boat_Armed_01_minigun_F",[15531.6,14290.6,0],[vectorNormalized ([15427.2,14570.2,0] vectorDiff [15531.6,14290.6,0]),[0,0,1]],[],[["B_T_Soldier_F",["driver"],[]],["B_T_Soldier_F",["turret",[0]],[]],["B_T_Soldier_F",["turret",[1]],[]]]]
		]
	],
	[
		WEST,
		[[15232.6,14178.6,0],[15531.6,14290.6,0],[15427.2,14570.2,0],[15191.6,14433.8,0]],
		[],
		[
			["B_T_Boat_Armed_01_minigun_F",[15191.6,14433.8,0],[vectorNormalized ([15232.6,14178.6,0] vectorDiff [15191.6,14433.8,0]),[0,0,1]],[],[["B_T_Soldier_F",["driver"],[]],["B_T_Soldier_F",["turret",[0]],[]],["B_T_Soldier_F",["turret",[1]],[]]]]
		]
	],
	[
		WEST,
		[[15232.6,14178.6,0],[15427.2,14570.2,0]],
		[],
		[
			["B_Heli_Light_01_dynamicLoadout_F",[15287.5,14239.1,250],[[0.4,0.92,0],[0,0,1]],[3],[["B_Helipilot_F",["driver"],[]],["B_Helipilot_F",["turret",[0]],[]]]]
		]
	],
	[
		WEST,
		[],
		[
			["B_Officer_Parade_Veteran_F",[15351.2,14416.8,19.1],205,[1]],
			["B_CTRG_Soldier_AR_tna_F",[15348.3,14417.5,19.3],198,[1]],
			["B_CTRG_Soldier_AR_tna_F",[15349.6,14416.6,19.2],200,[1]],
			["B_CTRG_Soldier_AR_tna_F",[15351.7,14415.2,19.1],200,[1]],
			["B_CTRG_Soldier_AR_tna_F",[15353.5,14414.4,18.9],208,[1]]
		],
		[
			["I_HMG_02_high_F",[15341.7,14419.3,20.5],[[-0.9,0.43,0],[0,0,1]],[],[["B_W_Soldier_F",["turret",[0]],[]]]],
			["I_HMG_02_high_F",[15359.5,14409.6,20.5],[[0.89,-0.45,0],[0,0,1]],[],[["B_W_Soldier_F",["turret",[0]],[]]]],
			["I_HMG_02_high_F",[15362.7,14419.7,12.1],[[0.38,0.92,0.01],[0,-0.01,1]],[],[["B_W_Soldier_F",["turret",[0]],[]]]],
			["I_HMG_02_high_F",[15345.9,14427.7,12.1],[[0.48,0.88,0.01],[0,-0.01,1]],[],[["B_W_Soldier_F",["turret",[0]],[]]]]
		]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_F",[15316.4,14339.6,8.7],176,[1]],
			["B_W_Soldier_F",[15302.8,14333.3,8.5],125,[1]],
			["B_W_Soldier_F",[15303.9,14336.5,8.5],132,[1]],
			["B_W_Soldier_F",[15317.7,14327.4,8.6],207,[1]],
			["B_W_Helicrew_F",[15314.7,14333.8,8.5],107,[1]],
			["B_W_Helipilot_F",[15315.1,14335.6,8.5],122,[1]],
			["B_W_Soldier_F",[15311.1,14345.3,9],166,[1]],
			["B_W_Soldier_F",[15313.9,14352.2,8.8],129,[1]],
			["B_W_Soldier_CBRN_F",[15318.5,14353.2,8.6],180,[1]],
			["B_W_Officer_F",[15322.7,14357.7,9],200,[1]],
			["B_W_Soldier_GL_F",[15329.8,14354.3,8.6],224,[1]],
			["B_W_Soldier_SL_F",[15319.2,14338.5,8.9],166,[1]],
			["B_W_Soldier_F",[15319.1,14343.8,8.9],171,[1]],
			["B_W_Soldier_AR_F",[15321.5,14335.7,11.4],204,[1]],
			["B_W_Soldier_F",[15325.6,14345.1,11],263,[1]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_F",[15326.4,14369.4,7.2],186,[1]],
			["B_W_Soldier_AA_F",[15343,14367.9,7.2],121,[1]],
			["B_W_Soldier_AT_F",[15338.8,14358.7,7.1],120,[1]],
			["B_W_Soldier_F",[15329.2,14366.7,7.1],222,[1]],
			["B_W_Soldier_F",[15328.2,14371,7],197,[1]],
			["B_W_Soldier_GL_F",[15331,14372.5,7],209,[1]],
			["B_W_Soldier_AT_F",[15313.4,14370.9,7.4],298,[1]],
			["B_W_Soldier_AA_F",[15318,14379.4,7],298,[1]]
		],
		[
			["I_HMG_02_high_F",[15340.9,14363.4,9],[[0.92,-0.38,0],[0,0,1]],[],[["B_W_Soldier_F",["turret",[0]],[]]]],
			["I_HMG_02_high_F",[15315.7,14375.3,9],[[-0.89,0.45,0],[0,0,1]],[],[["B_W_Soldier_F",["turret",[0]],[]]]]
		]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_F",[15338.1,14392,7.5],198,[1]],
			["B_W_Soldier_F",[15337.9,14386,7.4],211,[1]],
			["B_W_Officer_F",[15336.4,14385.2,7.5],208,[1]],
			["B_W_Soldier_SL_F",[15335.6,14386.7,7.5],195,[1]],
			["B_W_Soldier_AT_F",[15340.4,14396,7.3],198,[1]],
			["B_W_Soldier_AAA_F",[15340.1,14401.8,10.3],117,[1]],
			["B_W_Soldier_F",[15340,14402.8,10.2],117,[1]],
			["B_CTRG_Soldier_tna_F",[15342.9,14404.6,16.6],328,[1]],
			["B_W_Officer_F",[15341.5,14409.5,13.3] vectorAdd [2.8,1.1,0],57,[1]],
			["B_CTRG_Soldier_tna_F",[15344.1,14409.3,16.6],227,[1]],
			["B_CTRG_Soldier_TL_tna_F",[15346.2,14411.1,19.2],208,[1]]
		],
		[
			["I_HMG_02_high_F",[15340.3,14393.2,9],[[-0.48,-0.88,0],[0,0,1]],[],[["B_W_Soldier_F",["turret",[0]],[]]]]
		]
	]
];
_pmissEmptyVehs = [
	["B_Heli_Attack_01_dynamicLoadout_F",[15314,14339.3,10.8],[[-0.43,-0.9,0],[0,0,1]]],
	["B_Heli_Light_01_dynamicLoadout_F",[15323.3,14352.2,10.6],[[-0.83,-0.56,0],[0,0,1]]]
];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["ShipFlag_US_F",[15294.7,14299.1,8.76],[[-0.43,-0.9,0],[0,0,1]],false],
	["Land_HelipadEmpty_F",[15300,14310.2,8.76],[[-0.43,-0.9,0],[0,0,1]],false],
	["Land_DeckTractor_01_F",[15318.5,14340.4,9.47],[[-0.43,-0.9,0],[0,0,1]],false],
	["Land_Bomb_Trolley_01_F",[15320.3,14344.2,9.51],[[-0.42,-0.91,0],[0,0,1]],false],
	["Land_BagFence_01_long_green_F",[15327.8,14370.3,7.69],[[-0.48,-0.88,0],[0,0,1]],false],
	["Land_SignM_WarningMilAreaSmall_english_F",[15331,14374.3,8.31],[[0.38,0.93,0],[0,0,1]],true],
	["Land_BagFence_01_round_green_F",[15340.2,14392.3,7.69],[[0.58,0.82,0],[0,0,1]],false],
	["Land_BagFence_01_round_green_F",[15340.7,14401.6,10.78],[[-0.91,0.42,0],[0,0,1]],false],
	["Land_MultiScreenComputer_01_black_F",[15351.5,14417.5,20.47],[[0.42,0.91,0],[0,0,1]],false],
	["Land_TripodScreen_01_large_black_F",[15346.8,14419.2,20.25],[[0,-1,0],[0,0,1]],false],
	["Land_BriefingRoomScreen_01_F",[15348.9,14412.6,19.04],[[0.44,0.9,-0.02],[0.01,0.02,1]],false]
];

_pmissDefences = [
	["B_SAM_System_02_F",[15312.6,14336.1,17.8],[[-0.44,-0.9,0],[0,0,1]],true],
	["B_SAM_System_02_F",[15380.4,14477.9,14.8],[[0.44,0.9,0.02],[-0.01,-0.02,1]],true],
	["B_AAA_System_01_F",[15355,14425.1,17.6],[[0.42,0.91,0],[0,0,1]],true],
	["B_AAA_System_01_F",[15318.9,14349.3,21.7],[[-0.42,-0.91,0],[0,0,1]],true],
	["B_Ship_MRLS_01_F",[15361.3,14438.1,11.9],[[0.44,0.9,0.01],[0,-0.01,1]],true],
	["B_Ship_Gun_01_F",[15368.6,14453.6,14.8],[[0.44,0.9,0.03],[-0.01,-0.02,1]],true]
];

//CREATE DESTROYER
_pFix remoteExecCall ["BRPVP_pmissCreateDestroyer",2];
sleep 10;
{deleteVehicle _x;} forEach nearestObjects [ASLToAGL ([15334.4,14381.8,0] vectorAdd _pFix),["ShipFlag_US_F"],250];

private _ata = [];
private _nos = [];
private _vd = [];
private _noLagWait = 0.1;
{
	_x params ["_class","_pw","_vdu","_complete"];
	private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_nos pushBack _obj;
	uiSleep _noLagWait;
	if (_complete && isDamageAllowed _obj) then {_obj setVariable ["brpvp_yes_minerva",true,true];};
} forEach _pmissBuildings;
{
	_x addEventHandler ["HandleDamage",{
		params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
		private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
		private _deltaDam = _dam-_damNow;
		_damNow+_deltaDam*0.25
	}];
} forEach _pmissBuildingsEh;
{
	_x params ["_class","_pw","_vdu","_complete"];
	private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	createVehicleCrew _obj;
	_obj addEventHandler ["HandleDamage",{
		params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
		private _sameSide = side _instigator isEqualTo side _veh;
		if (_sameSide) then {if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};} else {_dam};
	}];
	_nos pushBack _obj;
	uiSleep _noLagWait;
} forEach _pmissDefences;
{
	_x params ["_class","_pw","_vdu"];
	//private _obj = createSimpleObject [_class,[0,0,0]];
	private _obj = createVehicle [_class,BRPVP_posicaoFora,[],100,"NONE"];
	_obj call BRPVP_emptyBox;
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_vd pushBack _obj;
	_obj call BRPVP_initPlayerMissionSceneryVehicles;
	uiSleep _noLagWait;
} forEach _pmissEmptyVehs;

_capitain = "B_Officer_Parade_Veteran_F";
{
	_x params ["_side","_wps","_onFoot","_onVeh"];
	private _grp = createGroup [_side,true];
	{
		_x params ["_class","_AGL","_dir","_flags"];
		if (random 1 <= BRPVP_pmissAiPerc || _class isEqualTo _capitain) then {
			private _u = _grp createUnit [_class,_AGL vectorAdd _pFix2D,[],0,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u setDir _dir;
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			if (_class isEqualTo _capitain) then {
				_u setVariable ["brpvp_can_ulfanize",false,2];
				_u setVariable ["brpvp_extra_chance",10];
				_u addEventHandler ["Killed",{
					private _pos = getPosASL (_this select 0) vectorAdd [0,0,1.25];
					private _suitCase = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
					_suitCase setPosASL _pos;
					_suitCase setVariable ["mny",round (20000000*BRPVP_missionValueMult),true];
					_this call BRPVP_botDaExp;
				}];
			} else {
				_u setVariable ["brpvp_extra_chance",2];
				_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			};
			if (_wps isEqualto [] && primaryWeapon _u isNotEqualTo "") then {
				[_u,selectRandom ["STAND","STAND_IA","WATCH","WATCH1","WATCH2"]] call BIS_fnc_ambientAnimCombat;
			};
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			BRPVP_pmissActualAiUnits pushBack _u;
			if (1 in _flags) then {_u disableAI "PATH";};
			if (2 in _flags) then {_u disableAI "FSM";};
			if (3 in _flags) then {_u setUnitPos "UP";};
			uiSleep _noLagWait;
		};
	} forEach _onFoot;
	{
		_x params ["_class","_pw","_vdu","_flags","_crew"];
		private _st = if (3 in _flags) then {"FLY"} else {"CAN_COLLIDE"};
		private _veh = createVehicle [_class,[0,0,0],[],10,_st];
		_veh setVectorDirAndUp _vdu;
		_veh setPosWorld (_pw vectorAdd _pFix);
		_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
		_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
		{
			_x params ["_class","_roleArray","_flags"];
			_roleArray params ["_role",["_path",[]]];
			private _u = _grp createUnit [_class,[0,0,0],[],10,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			if (_role isEqualTo "driver") then {_u moveInDriver _veh;};
			if (_role isEqualTo "turret") then {_u moveInTurret [_veh,_path];};
			if (_role isEqualTo "cargo") then {_u moveInCargo _veh;};
			if (1 in _flags) then {_u disableAI "PATH";};
			if (_veh isKindOf "StaticWeapon") then {
				private _dir = [[0,0,0],_vdu select 0] call BIS_fnc_dirTo;
				_u doWatch (getPosASL _veh vectorAdd [100*sin _dir,100*cos _dir,3]);
			};
		} forEach _crew;
		if (1 in _flags) then {_veh lock true;};
		if (2 in _flags) then {_veh setVariable ["brpvp_cant_heli_town",true,true];};
		if (4 in _flags) then {_veh setUnloadInCombat [true,false];};
		_vd pushBack _veh;
		uiSleep _noLagWait;
	} forEach _onVeh;
	if (count units _grp > 0) then {
		if (_wps isNotEqualTo []) then {
			{
				_wp = _grp addWayPoint [_x vectorAdd _pFix2D,0];
				_wp setWayPointType "MOVE";
				_wp setWaypointCompletionRadius 10;
			} forEach _wps;
			_wp = _grp addWayPoint [(_wps select 0) vectorAdd _pFix2D,0];
			_wp setWayPointType "CYCLE";
			_wp setWaypointCompletionRadius 10;
		};
	};
	uiSleep _noLagWait;
} forEach _pmissGroups;

//RARE LOOT
private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
_box allowDamage false;
_box setPosASL ([15356.2,14415.7,19.35] vectorAdd _pFix);
_box setDir 28;
[_box,0,1,true,50] call BRPVP_createCompleteLootBox;

_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

_dty = nearestObjects [[15334.4,14381.8,0] vectorAdd _pFix,["Land_Destroyer_01_base_F"],350,true];
BRPVP_pmissObjects = [_place,_rad,_nos,[],[],_dty,_vd,[],{true}];
BRPVP_pmissSpawning = false;