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

BRPVP_waterMissionRunning sort false;
_waterMissionPlaces = +BRPVP_waterMissionPlaces;
{_waterMissionPlaces deleteAt _x;} forEach BRPVP_waterMissionRunning;
if (count _waterMissionPlaces > 0) then {
	_idx = floor random count _waterMissionPlaces;
	BRPVP_waterMissionRunning pushBack _idx;
	_site = _waterMissionPlaces select _idx;
	_maxSpawnRad = 80;
	_rad = sqrt random(_maxSpawnRad^2);
	_dir = random 360;
	_sub = createVehicle ["Submarine_01_F",BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
	_subPos = [_site,_rad,_dir] call BIS_fnc_relPos;
	_sub setVectorUp surfaceNormal _subPos;
	_sub setPosATL (_subPos vectorAdd [0,0,10]);
	_sub enableSimulation false;
	_sub setVariable ["brpvp_can_explode",true,true];
	_sub setVariable ["brpvp_icon_pos",_site,true];
	BRPVP_waterMissionSubs pushBack _sub;
	publicVariable "BRPVP_waterMissionSubs";	
	[
		_sub,
		{_this addAction [("<t color='#FFEE00'>"+localize "str_water_mission_action"+"</t>"),{call BRPVP_waterMissionAction;},_this,1.5,true,true,"","(_target getVariable 'brpvp_can_explode') && [player,_target] call PDTH_distance2Box < 2 && cursorObject isEqualTo _target"]}
	] remoteExecCall ["call",BRPVP_allNoServer,true];
	_AIUnits = [];
	_vehicles = [];
	{
		_x params ["_class","_vehicleRoute"];
		_grp = createGroup [BLUFOR,true];
		_pos = _vehicleRoute select 0;
		_return = [_pos,[_vehicleRoute select 0,_vehicleRoute select 1] call BIS_fnc_dirTo,_class,_grp] call BIS_fnc_spawnVehicle;
		_veh = _return select 0;
		_veh setVariable ["brpvp_can_disable",true,2];
		_vehicles pushBack _veh;
		_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
		_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
		_units = _return select 1;
		{
			_x addEventHandler ["Killed",{_this call BRPVP_botDaExp;_this call BRPVP_rolaMotorista;}];
			_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_x setSkill 0.8;
			_x setSkill ["aimingAccuracy",0.25];
		} forEach _units;
		_AIUnits append _units;
		{
			_wp = _grp addWayPoint [_x,0];
			_wp setWaypointCompletionRadius 20;
			_wp setWayPointType "MOVE";
		} forEach _vehicleRoute;
		_wp = _grp addWayPoint [_vehicleRoute select 0,0];
		_wp setWaypointCompletionRadius 20;
		_wp setWayPointType "CYCLE";
		_grp setSpeedMode "FULL";
		uiSleep BRPVP_simpleMissSpawnWait;
	} forEach [
		["B_T_Boat_Armed_01_minigun_F",[[_subPos,100,0] call BIS_fnc_relPos,[_subPos,100,90] call BIS_fnc_relPos,[_subPos,100,180] call BIS_fnc_relPos,[_subPos,100,270] call BIS_fnc_relPos]]
	];
	
	{
		_x params ["_q","_route"];
		_grp = createGroup [BLUFOR,true];
		_pos = ASLToAGL ATLToASL (_route select 0);
		for "_i" from 1 to _q do {
			_diver = _grp createUnit ["B_diver_F",_pos,[],6,"NONE"];
			[_diver] joinSilent _grp;
			_diver addEventHandler ["Killed",{_this call BRPVP_botDaExp}];
			_diver addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_diver setSkill 0.8;
			_diver setSkill ["aimingAccuracy",0.2];
			_diver setVariable ["brpvp_can_ulfanize",false,2];
			_AIUnits pushBack _diver;
		};
		{
			_wp = _grp addWayPoint [ASLToAGL ATLToASL _x,0];
			_wp setWaypointCompletionRadius 10;
			_wp setWayPointType "MOVE";
		} forEach _route;
		_wp = _grp addWayPoint [ASLToAGL ATLToASL (_route select 0),0];
		_wp setWaypointCompletionRadius 10;
		_wp setWayPointType "CYCLE";
		_grp setSpeedMode "FULL";
		uiSleep BRPVP_simpleMissSpawnWait;
	} forEach [
		[4,[[_subPos,10,random 360] call BIS_fnc_relPos,[_subPos,35,000] call BIS_fnc_relPos]],
		[4,[[_subPos,10,random 360] call BIS_fnc_relPos,[_subPos,35,120] call BIS_fnc_relPos]],
		[2,[[_subPos,10,random 360] call BIS_fnc_relPos,[_subPos,35,240] call BIS_fnc_relPos]]
	];
	_sub setVariable ["brpvp_subAI",_AIUnits,true];

	remoteExecCall ["BRPVP_AIRemoveNull",2];
	_AIUnits remoteExecCall ["BRPVP_updateAIUnitsArray",2];
	BRPVP_smallMissionsAIObjs append _AIUnits;

	//BRPVP_missBotsEm = BRPVP_missBotsEm-[objNull];
	//BRPVP_missBotsEm append _AIUnits;
	//publicVariable "BRPVP_missBotsEm";
	
	[_sub,_idx,_subPos,_AIUnits,_vehicles,_subPos] spawn {
		params ["_sub","_runningId","_subPos","_AIUnits","_vehicles","_subPos"];

		//REFORCE POSITION
		[_sub,_subPos] remoteExecCall ["BRPVP_forceSubPos",2];

		waitUntil {isNull _sub};
		BRPVP_waterMissionNext = serverTime+BRPVP_missionSleepTime;
		BRPVP_waterMissionSubs = BRPVP_waterMissionSubs-[objNull];
		publicVariable "BRPVP_waterMissionSubs";
		BRPVP_waterMissionRunning = BRPVP_waterMissionRunning-[_runningId];
		_init = time;
		waitUntil {
			_t = time;
			_ok = false;
			if (_t-_init > 20) then {
				_init = _t;
				if (_subPos nearEntities [BRPVP_playerModel,1000] isEqualTo []) then {
					{
						_car = objectParent _x;
						if (isNull _car) then {deleteVehicle _x;} else {_car deleteVehicleCrew _x;};
					} forEach _AIUnits;
					sleep 0.25;
					{deleteVehicle _x;} forEach _vehicles;
					_ok = true;
				};
			};
			_ok
		};
	};
};