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

BRPVP_holeMissionIndex = 0;
BRPVP_holeMissionMainCode = {
	_place = [];
	_rad = BRPVP_holeMissionAreaRadius;
	_tries = 0;
	while {_place isEqualTo [] && _tries < 250} do {
		_randPos = BRPVP_mapaDimensoes apply {random _x};
		_randPos pushBack 0;
		_best = _randPos findEmptyPosition [0,50,"C_Hatchback_01_F"];
		if !(_best isEqualTo []) then {
			if !(surfaceIsWater _best || isOnRoad _best) then {
				_nearFlag = count (_best nearObjects ["FlagCarrier",500]) > 0;
				_nearMan = count (_best nearEntities ["CAManBase",250]) > 0;
				_onWater = {surfaceIsWater ([_best,_rad,_x] call BIS_fnc_relPos)} count [0,45,90,135,180,225,270,315] > 0;
				if !(_nearFlag || _nearMan || _onWater) then {
					_lis = lineIntersectsSurfaces [AGLToASL _best vectorAdd [0,0,0.25],AGLToASL _best vectorAdd [0,0,10]];
					if (_lis isEqualTo []) then {_place = _best;};
				};
			};
		};
		_tries = _tries+1;
	};
	if (_place isEqualTo []) exitWith {};

	_box = createVehicle ["Box_Syndicate_Ammo_F",BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
	[_box,0,1,true,true] call BRPVP_createCompleteLootBox;
	for "_i" from 1 to BRPVP_holeMissionSpecialLootQtt do {[_box,0,1,false,true] call BRPVP_createCompleteLootBox;};
	_inventory = _box call BRPVP_getCargoArray;
	_hole1 = createVehicle ["Land_ClutterCutter_medium_F",_place,[],0,"CAN_COLLIDE"];
	_hole1 setVariable ["brpvp_box",typeOf _box,true];
	_hole1 setVariable ["brpvp_box_inventory",_inventory,true];
	_hole2 = createVehicle ["Land_ClutterCutter_medium_F",_place,[],0,"CAN_COLLIDE"];
	_hole2 setVariable ["mny",BRPVP_holeMissionMoney*BRPVP_missionValueMult,true];
	deleteVehicle _box;

	_units = [];
	_center = [_place,random _rad,random 360] call BIS_fnc_relPos;
	for "_i1" from 1 to 2 do {
		_grp = createGroup [BLUFOR,true];
		_spawn = (_center getPos [15,random 360]) findEmptyPosition [0,35,"B_Soldier_F"];
		_squad = selectRandom BRPVP_missionWestGroups;
		for "_i2" from 1 to 6 do {
			_unit = _grp createUnit [selectRandom _squad,_spawn,[],0,"NONE"];
			[_unit] joinSilent _grp;
			_unit setSkill (BRPVP_AISkill select 10 select 0);
			_unit setSkill ["aimingAccuracy",BRPVP_AISkill select 10 select 1];
			_unit addEventHandler ["HandleDamage",{call BRPVP_hdeh}];
			_unit addEventHandler ["Killed",{call BRPVP_botDaExp;}];
			_units pushBack _unit;
		};
		_heading = random 360;
		_pos1 = [_center,150,_heading] call BIS_fnc_relPos;
		_pos2 = [_center,150,_heading+180] call BIS_fnc_relPos;
		_pos1FEP = _pos1 findEmptyPosition [0,35,"C_man_1"];
		_pos2FEP = _pos2 findEmptyPosition [0,35,"C_man_1"];
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

	BRPVP_holeMissionInfo pushBack [_center,_rad,[_hole1,_hole2],BRPVP_holeMissionIndex];
	publicVariable "BRPVP_holeMissionInfo";
	BRPVP_holeMissionIndex = BRPVP_holeMissionIndex+1;
};