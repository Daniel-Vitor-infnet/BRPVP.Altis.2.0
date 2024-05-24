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

_nAvaliable = [];
{if (count _x > 6 && !((_x select 3) in BRPVP_deniedVehiclesVehMission)) then {_nAvaliable pushBackUnique (_x select 6);};} forEach BRPVP_tudoA3;
_del = [];
{if !((_x select 0) in _nAvaliable) then {_del pushBack _forEachIndex;};} forEach BRPVP_vehMissionCfg;
_del sort false;
{BRPVP_vehMissionCfg deleteAt _x;} forEach _del;

BRPVP_vehicleMissionQtt = 0;
BRPVP_vehicleMissionCode = {
	private _canStart = BRPVP_vehicleMissionQtt < BRPVP_vehMissionMaxMissions;
	if (_canStart) then {
		_total = 0;
		{_total = _total+(_x select 1);} forEach BRPVP_vehMissionCfg;
		_rnd = random _total;
		_sum = 0;
		_type = -1;
		_turr = [];
		{
			_sum = _sum+(_x select 1);
			if (_sum > _rnd) exitWith {_type = _x select 0;_turr = _x select 2;};
		} forEach BRPVP_vehMissionCfg;
		_chance = [];
		{if (count _x > 6 && !((_x select 3) in BRPVP_deniedVehiclesVehMission)) then {if ((_x select 6) isEqualTo _type) then {_chance pushBack (_x select 3);};};} forEach BRPVP_tudoA3;
		_veh = selectRandom _chance;
		_placeIsOk = {
			_nearFlagsOk = (_this nearObjects ["FlagCarrier",500]) isEqualTo [];
			_nearPlayersOk = (_this nearEntities [BRPVP_playerModel,250]) isEqualTo [];
			_noMissVehicle = (_this nearEntities [["Tank","Air","Car","Motorcycle","Ship"],20]) isEqualTo [];
			_noSafezone = {(_x select 0) distanceSqr _this <= (_x select 1)+50} count BRPVP_safeZonesOtherMethodQuad isEqualTo 0;
			_nearFlagsOk && _nearPlayersOk && _noMissVehicle && _noSafezone
		};
		_pos = [];
		_road = objNull;
		_roads = [];
		_i = 0;
		while {_pos isEqualTo []} do {
			_try = if (_veh isKindOf "Plane") then {
				selectRandom BRPVP_airportRoadPlaces
			} else {
				if (_i mod 20 isEqualTo 0) then {_roads = (selectRandom BRPVP_busServiceStopPoints select 0) nearRoads 800;};
				while {isNull _road || {count roadsConnectedTo _road < 2}} do {_road = selectRandom _roads;};
				private _pr = getPosASL _road;
				private _lis = lineIntersectsSurfaces [_pr vectorAdd [0,0,10],_pr vectorAdd [0,0,-15]];
				if (_lis isEqualTo []) then {ASLToAGL _pr} else {ASLToAGL (_lis select 0 select 0)};
			};
			if (_try call _placeIsOk || _i > 200) exitWith {_pos = _try;};
			_i = _i+1;
		};
		if (_pos isNotEqualTo []) then {
			BRPVP_vehicleMissionQtt = BRPVP_vehicleMissionQtt+1;
			[_pos,_type,_veh,_turr,_road] spawn {
				params ["_pos","_type","_veh","_turr","_road"];
				_sum = 0;
				{_sum = _sum+_x;} forEach _turr;
				_hmgs = [];
				if (_veh isKindOf "Plane") then {
					_order = [];
					for "_i" from 1 to (_turr select 0) do {_order pushBack "I_HMG_01_high_F";};
					for "_i" from 1 to (_turr select 1) do {_order pushBack "I_static_AT_F";};
					for "_i" from 1 to (_turr select 2) do {_order pushBack "I_static_AA_F";};
					if (count _order > 0) then {
						_step = 360/_sum;
						_angle = 0;
						{
							_posT = [_pos,25,_angle] call BIS_fnc_relPos;
							_hmgs pushBack [_x,_posT,[_pos,_posT] call BIS_fnc_dirTo];
							_angle = _angle+_step;
						} forEach (_order call BIS_fnc_arrayShuffle);
					};
				} else {
					//CLEAN ARROUND
					{
						_obj = _x;
						_isRemove = {str _obj find _x > -1} count BRPVP_removeFromMap > 0;
						_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
						if (_isRemove && _noOwner) then {[_x,true] remoteExecCall ["hideObjectGlobal",2];};
					} forEach nearestTerrainObjects [_pos,[],25,false];

					_found = [_road];
					_new = [_road];
					private _connRem = [];
					while {count _found < (_sum+1+count _connRem) && count _new > 0} do {
						private ["_conn"];
						_conn = [];
						{_conn append roadsConnectedTo _x;} forEach _new;
						{if (_road distance _x < 10) then {_connRem pushBack _x;};} forEach _conn;
						_new = _conn-_found;
						_found append _new;
					};
					_found = _found-([_road]+_connRem);
					for "_i" from 1 to ((_turr select 0) min count _found) do {
						_r = _found deleteAt 0;
						_hmgs pushBack ["I_HMG_01_high_F",ASLToAGL getPosASL _r,([_road,_r] call BIS_fnc_dirTo)+selectRandom [0,90,-90,180]];
					};
					for "_i" from 1 to ((_turr select 1) min count _found) do {
						_r = _found deleteAt 0;
						_hmgs pushBack ["I_static_AT_F",ASLToAGL getPosASL _r,([_road,_r] call BIS_fnc_dirTo)+selectRandom [0,90,-90,180]];
					};
					for "_i" from 1 to ((_turr select 2) min count _found) do {
						_r = _found deleteAt 0;
						_hmgs pushBack ["I_static_AA_F",ASLToAGL getPosASL _r,([_road,_r] call BIS_fnc_dirTo)+selectRandom [0,90,-90,180]];
					};
				};
				_hmgObjs = [];
				{
					_x params ["_class","_posT","_dir"];
					_hmg = createVehicle [_class,_posT,[],0,"CAN_COLLIDE"];
					_hmg setDir _dir;
					_hmg setVariable ["own",-2,true];
					_hmg setVariable ["stp",4,true];
					_hmg setVariable ["amg",[[],[],false],true];
					_hmg remoteExecCall ["BRPVP_setTurretOperator",2];
					waitUntil {count crew _hmg > 0};
					_operator = (crew _hmg) select 0;
					_operator setVariable ["brpvp_dead_delete",true,2];
					_hmgObjs pushBack _hmg;
				} forEach _hmgs;
				_vehObj = createVehicle [_veh,_pos,[],0,"NONE"];

				_vehObj allowDamage false;
				[_vehObj,false] remoteExecCall ["allowDamage",-clientOwner,true];
				_vehObj setVariable ["brpvp_veh_godmode",true,true];
				_vehObj setVariable ["brpvp_veh_miss_lvl",_type,true];

				_isDrone = _veh in BRPVP_vantVehiclesClass;
				if (_isDrone) then {
					if (BRPVP_dronesMakeAllUnarmed) then {
						{
							_vehObj setPylonLoadout [configName _x,""];
						} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehObj >> "Components" >> "TransportPylonsComponent" >> "pylons"));
					};
				};
				_rct = (roadsConnectedTo _road) select [0,2];
				_vehObj setDir (_rct call BIS_fnc_dirTo);
				_vehObj setVariable ["brpvp_no_tow",true,true];
				_vehObj setVariable ["brpvp_cant_heli_town",true,true];
				_owner = objNull;
				clearWeaponCargoGlobal _vehObj;
				clearMagazineCargoGlobal _vehObj;
				clearItemCargoGlobal _vehObj;
				clearBackpackCargoGlobal _vehObj;
				_units = [];
				_qUnits = _type;
				for "_i" from 1 to (round(BRPVP_vehMissionAIMult*sqrt(_qUnits)*3/2) max 1) do {
					_squad = selectRandom BRPVP_missionWestGroups;
					_grp = createGroup [BLUFOR,true];
					for "_u" from 1 to selectRandom [3,4] do {
						_unit = _grp createUnit [selectRandom _squad,_pos,[],10,"NONE"];
						[_unit] joinSilent _grp;
						_unit addEventHandler ["Killed",{call BRPVP_botDaExp;}];
						_unit addEventHandler ["HandleDamage",{if (side (_this select 3) isEqualTo BLUFOR) then {call BRPVP_hdeh;0} else {call BRPVP_hdeh};}];
						_units pushBack _unit;
						_unit setSkill 1;
						_unit setSkill ["aimingAccuracy",0.3];
					};
					_heading = random 360;
					_pos1 = _vehObj getPos [45,_heading];
					_pos2 = _vehObj getPos [45,_heading+180];
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
				};
				_vehObj lock true;
				
				//CHG
				[] remoteExecCall ["BRPVP_AIRemoveNull",2];
				_units remoteExecCall ["BRPVP_updateAIUnitsArray",2];

				BRPVP_vehicleMissionIcons pushBack _vehObj;
				publicVariable "BRPVP_vehicleMissionIcons";
				
				//ADD PVP AREA IF IN PVE
				private _pvpPos = getPosWorld _vehObj;
				private _inPve = {_vehObj distance (_x select 0) < _x select 1} count BRPVP_pveMainAreas > 0;
				private _inPvp = {_vehObj distance (_x select 0) < _x select 1} count BRPVP_PVPAreas > 0;
				private _key = "VEH_MISS_PVP_"+str round random 1000000;
				if (_inPve && !_inPvp) then {
					[_pvpPos,500,{"PVP"},_key] remoteEXecCall ["BRPVP_addPvpArea",2];
					[_pvpPos,500,_key,12] remoteExecCall ["BRPVP_addNewPosCheckLayer",0];
				};
				
				_init = time;
				_dead = false;
				waitUntil {
					if (time-_init > 3) then {
						_init = time;
						_dead = ({alive _x && _vehObj distanceSqr _x < 40000} count _units) <= 2;
					};
					if (_isDrone && {count crew _vehObj > 0}) then {{deleteVehicle _x;} forEach crew _vehObj;};
					_dead
				};
				_vehObj setVariable ["brpvp_from_vg_time",serverTime+100000,true];
				_arrow = createVehicle ["Sign_Arrow_Large_Green_F",[0,0,0],[],100,"NONE"];
				_arrow attachTo [_vehObj,[0,0,3]];
				[_vehObj,["granted",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
				[_vehObj,false] remoteExecCall ["lock",_vehObj];
				_joiner = objNull;
				_cycle = if (_isDrone) then {0.25} else {0.1};
				_init = time;
				waitUntil {
					if (time-_init > _cycle) then {
						_init = time;
						if (_isDrone) then {
							_joiner = ((_vehObj nearEntities [BRPVP_playerModel,10])+[objNull]) select 0;
						} else {
							_joiner = objNull;
							{if (_x call BRPVP_isPlayer) exitWith {_joiner = _x;};} forEach crew _vehObj;
						};
					};
					(!isNull _joiner && {_joiner getVariable ["sok",false]}) || !alive _vehObj
				};
				"ugranted" remoteExecCall ["playSound",_joiner];
				detach _arrow;
				deleteVehicle _arrow;
				_hmgObjs spawn {
					sleep 300;
					{
						if (isNull (_x getVariable "brpvp_operator")) then {
							deleteVehicle _x;
						} else {
							_x remoteExecCall ["BRPVP_destroyTurret",2];
							_x setPosWorld BRPVP_posicaoFora;
						};
					} forEach _this;
				};
				if (alive _vehObj) then {
					_vehObj setVariable ["own",_joiner getVariable "id_bd",true];
					_vehObj setVariable ["stp",_joiner getVariable "dstp",true];
					_vehObj setVariable ["amg",[_joiner getVariable ["amg",[]],[],true],true];
					_vehObj setVariable ["brpvp_locked",false,true];
					if (_isDrone) then {
						createVehicleCrew _vehObj;
						_vehObj setVariable ["brpvp_from_vg_time",0,true];
					} else {
						_vehObj setVariable ["brpvp_from_vg_time",serverTime+300,true];
						_vehObj setVariable ["brpvp_cant_safe_time",serverTime+300,true];
					};
					_estadoCons = [
						[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],
						[getPosWorld _vehObj,[vectorDir _vehObj,vectorUp _vehObj]],
						typeOf _vehObj,
						_vehObj getVariable "own",
						_vehObj getVariable "stp",
						_vehObj getVariable ["amg",[[],[],true]],
						"",
						[0,0,0,0,0,0],
						_vehObj call BRPVP_getVehicleAmmo,
						_vehObj call BRPVP_getHitpointsDamage
					];
					[false,_vehObj,_estadoCons] remoteExecCall ["BRPVP_adicionaConstrucaoBd",2];
					_vehObj setVariable ["brpvp_no_tow",false,true];
					_vehObj setVariable ["brpvp_cant_heli_town",false,true];
					uiSleep 60;
					_vehObj setVariable ["brpvp_veh_godmode",false,true];
					_vehObj remoteExecCall ["BRPVP_setAirGodMode",_vehObj];
				};
				BRPVP_vehicleMissionIcons = BRPVP_vehicleMissionIcons-[_vehObj,objNull];
				publicVariable "BRPVP_vehicleMissionIcons";
				BRPVP_vehicleMissionQtt = BRPVP_vehicleMissionQtt-1;

				//REMOVE MISSION PVP AREA
				if (_inPve && !_inPvp) then {
					_key remoteExecCall ["BRPVP_removePvpArea",2];
					_key remoteExecCall ["BRPVP_removePosCheckLayer",0];
				};
			};
		};
	};
	_canStart
};