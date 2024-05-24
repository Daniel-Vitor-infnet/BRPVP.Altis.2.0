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

//SELECT ORIGIM
_places = BRPVP_transPlaces apply {if (_x nearObjects ["FlagCarrier",500] isEqualTo []) then {_x} else {-1};};
_places = _places-[-1];
_places = _places apply {
	_place = _x;
	_used = false;
	{if (_place distanceSqr (_x select 3) < 100 || _place distanceSqr (_x select 4) < 100) exitWith {_used = true;};} forEach BRPVP_transActives;
	if (_used) then {-1} else {_place};
};
_places = _places-[-1];
if (count _places < 2) exitWith {};
_origin = _places deleteAt floor random count _places;

//SELECT DESTINE
_placesDestine = _places apply {[_x distanceSqr _origin,_x]};
_placesDestine sort false;
_destine = ([_placesDestine,1.45] call LOL_fnc_selectRandomFator) select 1;

//CREATE ORIGIM: VEHICLE AND DRIVER
_vehicle = createVehicle ["C_Hatchback_01_sport_F",_origin,[],0,"NONE"];
_vehicle setVariable ["brpvp_trans_mission",BRPVP_transCount,true];
_vehicle setVariable ["brpvp_cant_safe",true,true];
_vehicle setVariable ["brpvp_cant_heli_town",true,true];
[_vehicle,false] remoteExecCall ["allowDamage",0];
{
	_box = createSimpleObject ["Box_T_NATO_WpsSpecial_F",AGLToASL BRPVP_posicaoFora];
	_box attachTo [_vehicle,_x];
} forEach [
	//[0,-1.25,0.13+1.20],
	//[0,-0.60,0.13+1.20],
	//[0,+0.05,0.13+1.20],
	//[0,+0.70,0.13+1.20],
	[0,-1.25,0.13+0.85],
	[0,-0.60,0.13+0.85],
	[0,+0.05,0.13+0.85],
	[0,+0.70,0.13+0.85],
	[0,-1.25,0.13+0.50],
	[0,-0.60,0.13+0.50],
	[0,+0.05,0.13+0.50],
	[0,+0.70,0.13+0.50]
];
_driver = createAgent ["B_Soldier_F",BRPVP_spawnAIFirstPos,[],30,"NONE"];
_driver call BRPVP_dressAsSurvivor;
_driver moveInDriver _vehicle;
_driver setDamage 1;
_copilot = createAgent ["B_Soldier_F",ASLToAGL getPosASL _vehicle,[],10,"NONE"];
_coPilot call BRPVP_dressAsSurvivor;
_coPilot setDamage 1;

//CREATE ORIGIM: ENEMY AI
_units = [];
for "_i1" from 1 to 2 do {
	_grp = createGroup [BLUFOR,true];
	_spawn = (_vehicle getPos [15,random 360]) findEmptyPosition [0,30,"B_Soldier_F"];
	_squad = selectRandom BRPVP_missionWestGroups;
	for "_i2" from 1 to 4 do {
		_unit = _grp createUnit [selectRandom _squad,_spawn,[],0,"NONE"];
		[_unit] joinSilent _grp;
		_unit setSkill (BRPVP_AISkill select 7 select 0);
		_unit setSkill ["aimingAccuracy",BRPVP_AISkill select 7 select 1];
		_unit addEventHandler ["HandleDamage",{call BRPVP_hdeh}];
		_unit addEventHandler ["Killed",{call BRPVP_botDaExp;}];
		_units pushBack _unit;
	};
	_heading = random 360;
	_pos1 = _vehicle getPos [20,_heading];
	_pos2 = _vehicle getPos [20,_heading+180];
	_pos1FEP = _pos1 findEmptyPosition [0,15,"C_man_1"];
	_pos2FEP = _pos2 findEmptyPosition [0,15,"C_man_1"];
	_pos1 = if (_pos1FEP isEqualTo []) then {_pos1} else {_pos1FEP};
	_pos2 = if (_pos2FEP isEqualTo []) then {_pos2} else {_pos2FEP};
	_wp = _grp addWayPoint [_pos1,0];
	_wp setWaypointCompletionRadius 5;
	_wp setWayPointType "MOVE";
	_wp = _grp addWayPoint [_pos2,0];
	_wp setWaypointCompletionRadius 5;
	_wp setWayPointType "MOVE";
	_wp = _grp addWayPoint [_pos1,0];
	_wp setWaypointCompletionRadius 5;
	_wp setWayPointType "CYCLE";
	uiSleep BRPVP_simpleMissSpawnWait;
};

//CHG
remoteExecCall ["BRPVP_AIRemoveNull",2];
_units remoteExecCall ["BRPVP_updateAIUnitsArray",2];
BRPVP_smallMissionsAIObjs append _units;

//CREATE DESTINE: PLANE AND AGENTS
_plane = createSimpleObject ["B_T_VTOL_01_vehicle_F",AGLToASL _destine];
_plane setVectorUp surfaceNormal getPosWorld _plane;
_owner = createAgent ["B_Soldier_F",ASLToAGL getPosASL _plane,[],15,"NONE"];
_owner call BRPVP_dressAsSurvivor;
_owner setDir ([_plane,_owner] call BIS_fnc_dirTo);
_owner addWeapon "LMG_Mk200_MRCO_F";
_owner disableAI "FSM";
_owner allowDamage false;
_soldats = [];
for "_i" from 1 to 8 do {
	_soldat = createAgent ["B_Soldier_F",ASLToAGL getPosASL _plane,[],15,"NONE"];
	_soldat call BRPVP_dressAsSurvivor;
	[_soldat,"amovpsitmstpsnonwpstdnon_ground"] remoteExecCall ["switchMove",0];
	_soldat allowDamage false;
	_soldat setDir ([_plane,_soldat] call BIS_fnc_dirTo);
	_soldats pushBack _soldat;
	_soldat enableSimulationGlobal false;
	uiSleep BRPVP_simpleMissSpawnWait;
};

//MONITORE COMPLETION
[_vehicle,_plane,_owner,_soldats,BRPVP_transCount,_destine distance _origin] spawn {
	params ["_vehicle","_plane","_owner","_soldats","_transCount","_dist"];
	waitUntil {_vehicle distanceSqr _plane < 900};
	{
		deleteVehicle _x;
		sleep 0.2;
	} forEach attachedObjects _vehicle;
	_pos = ASLToAGL getPosASL _vehicle;
	{if ((_x select 2) isEqualTo _transCount) exitWith {BRPVP_transActives deleteAt _forEachIndex};} forEach BRPVP_transActives;
	publicVariable "BRPVP_transActives";
	deleteVehicle _vehicle;
	[_plane,["transport_win",400]] remoteExecCall ["say3D",BRPVP_allNoServer];
	_owner moveTo _pos;
	waitUntil {moveToCompleted _owner};
	sleep 1.5;
	_suitCase = createVehicle ["Land_Suitcase_F",(_owner getPos [0.8,getDir _owner]) vectorAdd [0,0,1],[],0,"CAN_COLLIDE"];
	_extra = round (((_dist min BRPVP_transDistanceMaxPrize)/BRPVP_transDistanceMaxPrize)*BRPVP_transMoneyBase);
	_sMoney = 100000*ceil (((BRPVP_transMoneyFixed+_extra)*BRPVP_missionValueMult)/100000);
	_suitCase setVariable ["mny",_sMoney,true];
	_box = createVehicle ["Box_Syndicate_Ammo_F",(_owner getPos [1.8,getDir _owner]) vectorAdd [0,0,1],[],0,"CAN_COLLIDE"];
	_box setVariable ["brpvp_del_when_empty",true,true];
	[_box,BRPVP_transNormalLootMoney,selectRandom [3,4,5],true,BRPVP_transSpecialLootQtt,1] call BRPVP_createCompleteLootBox;
	BRPVP_transMissionNext = serverTime+BRPVP_missionSleepTime;
	_init = time;
	waitUntil {
		_time = time;
		if (_time-_init > 5) then {
			_init = _time;
			if (_plane nearEntities [BRPVP_playerModel,800] isEqualTo []) then {true} else {false};
		} else {
			false
		};
	};
	deleteVehicle _plane;
	deleteVehicle _owner;
	{deleteVehicle _x;} forEach _soldats;
};

//SEND MAP ICONS TO CLIENTS
BRPVP_transActives pushBack [_vehicle,_plane,BRPVP_transCount,_origin,_destine];
publicVariable "BRPVP_transActives";
BRPVP_transCount = BRPVP_transCount+1;