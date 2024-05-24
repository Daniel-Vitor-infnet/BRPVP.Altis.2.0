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

BRPVP_pmissEndCheckObjects = [];

_pFix = (AGLToASL _place) vectorDiff (AGLToASL [15808.5,3116,0]);
_pFix2D = _place vectorDiff [15808.5,3116,0];
_pmissGroups = [
	[
		WEST,
		[[15808.5,3216+150,0],[15808.5,3216-150,0]],
		[],
		[
			["B_Heli_Light_01_dynamicLoadout_F",[15890.2,3192,84.6],[[0.16,-0.99,0],[0,0,1]],[3],[["B_Helipilot_F",["driver"],[]]]],
			["B_Heli_Light_01_dynamicLoadout_F",[15728.2,3165,82],[[0.1,-0.99,0],[0,0,1]],[3],[["B_Helipilot_F",["driver"],[]]]]
		]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_TL_F",[15793.9,3036.8,23.8],179,[]],
			["B_W_Soldier_AR_F",[15788.8,3041.7,23.7],179,[]],
			["B_W_Soldier_GL_F",[15798.8,3041.9,23.7],179,[]],
			["B_W_Soldier_TL_F",[15833.6,3045.2,23.7],178,[]],
			["B_W_Soldier_AR_F",[15828.4,3050,23.5],178,[]],
			["B_W_Soldier_LAT_F",[15823.2,3054.9,23.5],178,[]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_TL_F",[15793.7,3105.8,23.7],0,[]],
			["B_W_Soldier_AR_F",[15798.7,3100.8,23.5],0,[]],
			["B_W_Soldier_GL_F",[15788.7,3100.8,23.6],0,[]],
			["B_W_Soldier_TL_F",[15823.7,3102,23.5],0,[]],
			["B_W_Soldier_AR_F",[15828.7,3097,23.6],0,[]],
			["B_W_Soldier_GL_F",[15818.7,3097,23.6],0,[]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_TL_F",[15792.4,3163.3,23.8],179,[]],
			["B_W_Soldier_AR_F",[15787.4,3168.2,23.9],179,[]],
			["B_W_Soldier_GL_F",[15797.4,3168.3,23.7],179,[]],
			["B_W_Soldier_TL_F",[15835.2,3151.1,23.4],239,[]],
			["B_W_Soldier_AR_F",[15836.9,3158,23.5],239,[]],
			["B_W_Soldier_LAT_F",[15838.6,3164.9,23.7],239,[]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_TL_F",[15841.3,3213.3,23.5],188,[]],
			["B_W_Soldier_AR_F",[15837,3218.9,23.9],188,[]],
			["B_W_Soldier_GL_F",[15846.9,3217.6,23.6],188,[]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_TL_F",[15790.2,3263.5,24.2],92,[]],
			["B_W_Soldier_AA_F",[15785,3258.7,24.3],92,[]],
			["B_W_Soldier_AA_F",[15785.3,3268.7,24.2],92,[]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_SL_F",[15810.1,3262.8,23.8],178,[]],
			["B_W_Soldier_LAT_F",[15813.1,3271,23.6],178,[]],
			["B_W_soldier_M_F",[15803.2,3266.6,24.4],178,[]],
			["B_W_Soldier_TL_F",[15821.6,3264.2,24],178,[]],
			["B_W_Soldier_SL_F",[15812.5,3234.2,23.7],177,[]],
			["B_W_Soldier_AR_F",[15807.2,3239,24.1],177,[]],
			["B_W_Soldier_GL_F",[15817.2,3239.5,23.8],177,[]],
			["B_W_soldier_M_F",[15800.6,3247.7,24],177,[]],
			["B_W_Soldier_AT_F",[15823.1,3250.3,23.7],177,[]]
		],
		[]
	]
];
_pmissEmptyVehs = [
	["B_Plane_Fighter_01_F",[15814.3,3065.5,26],[[0.04,-1,0],[0,0,1]]],
	["B_Plane_Fighter_01_F",[15786,3066.7,26],[[0.1,-1,0],[0,0,1]]],
	["B_Plane_Fighter_01_Stealth_F",[15775.1,3104.1,26],[[0.58,-0.81,0],[0,0,1]]],
	["B_Plane_Fighter_01_Stealth_F",[15774.2,3189.7,26],[[0.63,-0.78,0],[0,0,1]]],
	["B_Plane_Fighter_01_Stealth_F",[15845.1,3186.5,26],[[0,-1,0],[0,0,1]]],
	["B_Heli_Attack_01_dynamicLoadout_F",[15774.6,3246.6,25.4],[[1,0.05,0],[0,0,1]]],
	["B_Heli_Attack_01_dynamicLoadout_F",[15774.6,3259.4,25.5],[[1,0.02,0],[0,0,1]]],
	["B_Heli_Attack_01_dynamicLoadout_F",[15774.4,3273.6,25.5],[[1,0.01,0],[0,0,1]]],
	["B_UAV_05_F",[15843.6,3233.7,25.4],[[-0.02,-1,0],[0,0,1]]],
	["B_UAV_05_F",[15840.8,3263.2,25.4],[[-0.84,-0.55,0],[0,0,1]]],
	["B_Heli_Transport_03_F",[15778.4,3147.7,26.9],[[0.87,-0.49,0],[0,0,1]]],
	["B_Heli_Transport_01_F",[15777.1,3166,25.7],[[0.93,-0.36,0],[0,0,1]]],
	["B_Heli_Transport_01_F",[15775.6,3130.3,25.7],[[0.9,-0.44,0],[0,0,1]]]
];
_pmissBuildings = [
	//["Land_Carrier_01_hull_08_2_F",[15783.2,3235.86,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_09_2_F",[15783,3280.86,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_03_1_F",[15824.2,3011.12,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_04_1_F",[15833.4,3056.18,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_05_1_F",[15833.1,3101.18,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_06_1_F",[15832.8,3146.17,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_07_1_F",[15832.5,3191.17,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_08_1_F",[15832.2,3236.17,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_09_1_F",[15832,3281.17,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_island_01_F",[15777.8,3220.83,25],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_island_02_F",[15777.8,3220.83,25],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_island_03_F",[15762.7,3245.73,25],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_01_F",[15809.5,2951.02,0],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_02_F",[15809.4,2976.02,0],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_03_2_F",[15794.2,3010.93,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_04_2_F",[15784.4,3055.87,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_05_2_F",[15784.1,3100.86,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_06_2_F",[15783.8,3145.86,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Carrier_01_hull_07_2_F",[15783.5,3190.86,5],[[-0.01,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_05_F",[15629.1,3214.97,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_01_F",[15640.6,3050.37,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_02_F",[15637.8,3090.27,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_interior_02_F",[15637.8,3090.27,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_interior_03_F",[15634.7,3135.16,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_03_F",[15634.7,3135.16,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_04_F",[15631.5,3180.05,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_interior_04_F",[15631.5,3180.05,-0.65],[[-0.07,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_01_F",[15982.9,3061.35,-0.65],[[0,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_02_F",[15982.9,3101.35,-0.65],[[0,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_interior_02_F",[15982.9,3101.35,-0.65],[[0,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_interior_03_F",[15982.9,3146.35,-0.65],[[0,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_03_F",[15982.9,3146.35,-0.65],[[0,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_04_F",[15982.9,3191.35,-0.65],[[0,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_interior_04_F",[15982.9,3191.35,-0.65],[[0,1,0],[0,0,1]],false],
	//["Land_Destroyer_01_hull_05_F",[15982.9,3226.35,-0.65],[[0,1,0],[0,0,1]],false],
	["Land_HelipadEmpty_F",[15629.2,3214.37,8.76],[[-0.07,1,0],[0,0,1]],false],
	["Submarine_01_F",[15726.2,2879.47,-1.31],[[-0.08,1,0],[0,0,1]],false],
	["Land_Bomb_Trolley_01_F",[15777.8,3104.31,24.27],[[0.55,-0.83,0],[0,0,1]],false],
	["Land_Missle_Trolley_02_F",[15773.8,3100.64,24.27],[[0.68,-0.74,0],[0,0,1]],false],
	["Land_Missle_Trolley_02_F",[15777.1,3191.55,24.26],[[-0.29,-0.96,0],[0,0,1]],false],
	["Land_Bomb_Trolley_01_F",[15776,3207.14,24.26],[[0,-1,0],[0,0,1]],false],
	["Land_Bomb_Trolley_01_F",[15778.3,3207.15,24.26],[[-0.02,-1,0],[0,0,1]],false],
	["Land_Missle_Trolley_02_F",[15773.8,3207.25,24.26],[[-0.02,-1,0],[0,0,1]],false],
	["Land_BriefingRoomDesk_01_F",[15776.7,3227.31,23.63],[[1,-0.02,0],[0,0,1]],false],
	["Land_BriefingRoomScreen_01_F",[15776.5,3223.91,23.62],[[0,1,0],[0,0,1]],false],
	//["DynamicAirport_01_F",[15808.9,3114.85,23.69],[[-0.01,1,0],[0,0,1]],false],
	["Land_DeckTractor_01_F",[15781.4,3095.47,24.21],[[0.63,-0.78,0],[0,0,1]],false],
	["Land_DeckTractor_01_F",[15781.4,3181.02,24.2],[[0.66,-0.76,0],[0,0,1]],false],
	["Land_Bomb_Trolley_01_F",[15781,3206.96,24.26],[[0.02,-1,0],[0,0,1]],false],
	["Land_Missle_Trolley_02_F",[15783.7,3207.18,24.26],[[-0.02,-1,0],[0,0,1]],false],
	["Land_DeckTractor_01_F",[15834.9,3271.64,24.18],[[0.02,-1,0],[0,0,1]],false],
	["Land_DeckTractor_01_F",[15832.7,3271.68,24.18],[[0.02,-1,0],[0,0,1]],false],
	["Land_DeckTractor_01_F",[15842.4,3175.99,24.21],[[-0.33,-0.94,0],[0,0,1]],false],
	["Land_Missle_Trolley_02_F",[15846.8,3184.92,24.28],[[-0.21,-0.98,0],[0,0,1]],false],
	["Land_Missle_Trolley_02_F",[15843.3,3184.74,24.28],[[0.33,-0.95,0],[0,0,1]],false],
	["Submarine_01_F",[15889.9,2881.87,-1.34],[[-0.03,1,0],[0,0,1]],false],
	["Land_HelipadEmpty_F",[15982.9,3225.75,8.76],[[0,1,0],[0,0,1]],false]
];
_pmissDefences = [
	["B_AAA_System_01_F",[15778.1,3010.4,20.1+0.2],[[-1,0,0],[0,0,1]],true],
	["B_AAA_System_01_F",[15856.3,3115.96,20.6+0.2],[[1,0,0],[0,0,1]],true],
	["B_AAA_System_01_F",[15834.9-1,3001.1,19.2+0.2],[[1,0,0],[0,0,1]],true],
	["B_AAA_System_01_F",[15769.1,3294.8,22.5+0.2],[[0,1,0],[0,0,1]],true],
	["B_AAA_System_01_F",[15791.7,3304.03,13.8+0.2],[[0,1,0],[0,0,1]],true],
	["B_SAM_System_01_F",[15779.8-1,3014.9,21.2+0.2],[[-1,0,0],[0,0,1]],true],
	["B_SAM_System_01_F",[15838.7,3290.9,21.5+0.2],[[0,1,0],[0,0,1]],true]
];

//CREATE CARRIER AND DESTROYERS
[_pFix,[15808.5,3116.00,0],[[0,1,0],[0,0,1]],[]] remoteExecCall ["BRPVP_pmissCreateCarrierCfg",2];
[_pFix,[15634.7,3135.16,0],[[0,1,0],[0,0,1]],[]] remoteExecCall ["BRPVP_pmissCreateDestroyerCfg",2];
[_pFix,[15982.9,3146.35,0],[[0,1,0],[0,0,1]],[]] remoteExecCall ["BRPVP_pmissCreateDestroyerCfg",2];
sleep 15;
{deleteVehicle _x;} forEach nearestObjects [ASLToAGL ([15634.7,3135.16,0] vectorAdd _pFix),["ShipFlag_US_F"],250];
{deleteVehicle _x;} forEach nearestObjects [ASLToAGL ([15982.9,3146.35,0] vectorAdd _pFix),["ShipFlag_US_F"],250];

private _ata = [];
private _ataFoot = [];
private _nos = [];
private _ts = [];
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
{
	_x params ["_side","_wps","_onFoot","_onVeh"];
	private _grp = createGroup [_side,true];
	{
		_x params ["_class","_AGL","_dir","_flags"];
		private _u = _grp createUnit [_class,_AGL vectorAdd _pFix2D,[],0,"CAN_COLLIDE"];
		[_u] joinSilent _grp;
		_ata pushBack _u;
		_ataFoot pushBack _u;
		_u setDir _dir;
		_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
		if (true) then {
			_u setVariable ["brpvp_extra_chance",3];
			_u addEventHandler ["Killed",{
				private _pos = getPosASL (_this select 0) vectorAdd [0,0,1.25];
				private _suitCase = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
				_suitCase setPosASL _pos;
				_suitCase setVariable ["mny",round (500000*BRPVP_missionValueMult),true];
				_this call BRPVP_botDaExp;
			}];
		} else {
			_u setVariable ["brpvp_extra_chance",3];
			_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
		};
		if (_wps isEqualto []) then {[_u,selectRandom ["STAND","STAND_IA","WATCH","WATCH1","WATCH2"]] call BIS_fnc_ambientAnimCombat;};
		_u setSkill (_skill select 0);
		_u setSkill ["aimingAccuracy",_skill select 1];
		BRPVP_pmissActualAiUnits pushBack _u;
		if (1 in _flags || true) then {_u disableAI "PATH";};
		if (2 in _flags) then {_u disableAI "FSM";};
		if (3 in _flags) then {_u setUnitPos "UP";};
		[_u,false] remoteEXecCall ["enableSimulationGlobal",2];
		uiSleep _noLagWait;
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
	uiSleep _noLagWait;
} forEach _pmissGroups;

//RARE LOOT
private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
_box allowDamage false;
_box setPosASL ([15774.4,3273.6+4,25.5+0.25] vectorAdd _pFix);
_box setDir 0;
[_box,0,1,true,50] call BRPVP_createCompleteLootBox;

_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

_carr = nearestObjects [[15808.5,3116.00,0] vectorAdd _pFix,["Land_Carrier_01_base_F"],100,true];
BRPVP_pmissObjects = [_place,_rad,_nos,_ts,_carr,[],_vd,[],{true}];

//SPECIAL BRAVO FLEET
[_ataFoot,_ata] spawn {
	params ["_ataWait","_ata"];
	sleep 15;
	{[_x,true] remoteEXecCall ["enableSimulationGlobal",2];} forEach _ataWait;

	//FIX AI INSIDE CARRIER
	private _init = diag_tickTime;
	private _end = false;
	waitUntil {
		if (diag_tickTime-_init > 20) then {
			_init = diag_tickTime;
			_end = true;
			{
				if (alive _x) then {
					private _pos = getPosASL _x;
					private _h = _pos select 2;
					if (_h < 22) then {
						_pos set [2,50];
						private _lis = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,-50],_x,objNull];
						if (_lis isNotEqualTo []) then {_x setPosASL [_pos select 0,_pos select 1,24];};
					};
					_end = false;
				};
			} forEach _ataWait;
		};
		_end
	};
};
BRPVP_pmissSpawning = false;