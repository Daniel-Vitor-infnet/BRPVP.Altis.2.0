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

BRPVP_eventJunkyIncidentOn = {
	params ["_idx","_svcObjs"];
	diag_log ("[CHECK FOR NULL EV_Null] "+str ({isNull _x} count _svcObjs));
	waitUntil {{isNull _x} count _svcObjs isEqualTo 0};
	_state = BRPVP_eventsDataCodeIsOn select _idx;
	if (_state isEqualTo 0) then {
		BRPVP_eventsDataCodeIsOn set [_idx,1];
		publicVariable "BRPVP_eventsDataCodeIsOn";
		_center = BRPVP_eventsData select _idx select 0;
		_radius = BRPVP_eventsData select _idx select 1;
		BRPVP_eventJunkyIncidentGroups = [];
		BRPVP_eventJunkyIncidentDead = [];
		BRPVP_eventJunkyIncidentWayPoints = [];
		BRPVP_eventJunkyIncidentObjects = _svcObjs;
		_AIUnits = [];
		for "_i1" from 1 to 3 do {
			private ["_pos1"];
			_grp = createGroup BLUFOR;
			BRPVP_eventJunkyIncidentGroups pushBack _grp;
			if (_i1 <= 2) then {
				{
					_unit = _grp createUnit [_x,BRPVP_spawnAIFirstPos,[],10,"NONE"];
					[_unit] joinSilent _grp;
					_AIUnits pushBack _unit;
					_unit addEventHandler ["Killed",{BRPVP_eventJunkyIncidentDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
					_unit addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				} forEach [selectRandom selectRandom BRPVP_missionWestGroups,"B_soldier_AA_F","B_soldier_AT_F"];
			} else {
				for "_i2" from 1 to 4 do {
					_unit = _grp createUnit [selectRandom selectRandom BRPVP_missionWestGroups,BRPVP_spawnAIFirstPos,[],10,"NONE"];
					[_unit] joinSilent _grp;
					_AIUnits pushBack _unit;
					_unit addEventHandler ["Killed",{BRPVP_eventJunkyIncidentDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
					_unit addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				};
			};
			for "_i2" from 1 to 200 do {
				_pos1 = _center getPos [random _radius,random 360];
				if (not surfaceIsWater _pos1) exitWith {};
			};
			_pos2Array = [];
			for "_i2" from 1 to 3 do {
				for "_i3" from 1 to 200 do {
					_pos = _center getPos [random _radius,random 360];
					if (not surfaceIsWater _pos) exitWith {_pos2Array pushBack _pos;};
				};
			};
			_pos2Array = _pos2Array apply {[_x distanceSqr _pos1,_x]};
			_pos2Array sort false;
			_pos2 = _pos2Array select 0 select 1;
			{_x setVehiclePosition [_pos1,[],10,"NONE"];} forEach units _grp;
			
			//WAYPOINT 1
			_wp = _grp addWayPoint [_pos2 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
			BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 10;
			_wp setWayPointType "MOVE";
			_wp setWayPointFormation "STAG COLUMN";
			
			//WAYPOINT 2
			_wp = _grp addWayPoint [_pos1 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
			BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 10;
			_wp setWayPointType "MOVE";
			_wp setWayPointFormation "STAG COLUMN";

			//WAYPOINT 3
			_wp = _grp addWayPoint [_pos2 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
			BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 10;
			_wp setWayPointType "CYCLE";
			_wp setWayPointFormation "STAG COLUMN";

			uiSleep BRPVP_eventDataSpawnWait;
		};
		_houses = [];
		_housesUsed = [];
		{if (count (_x buildingPos -1) > 0) then {_houses pushBack _x;};} forEach (_center nearObjects ["House",_radius]);
		for "_i" from 1 to selectRandom [1] do {
			_class = selectRandom ["Box_T_East_WpsSpecial_F","Box_East_WpsSpecial_F","Box_IND_WpsSpecial_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsSpecial_F"];
			_box = createVehicle [_class,BRPVP_posicaoFora,[],20,"NONE"];
			_box call BRPVP_removeDeniedItems;
			BRPVP_eventJunkyIncidentObjects pushBack _box;
			_used = selectRandom (_houses-_housesUsed);
			_box setPosASL AGLToASL (ASLtoAGL getPosASL _used findEmptyPosition [0,30,_class]);
			_housesUsed pushBack _used;
		};

		//MOUNTED BOX WITH RARE CHANCE
		_used = selectRandom (_houses-_housesUsed);
		_housesUsed pushBack _used;
		_posBox = (ASLtoAGL getPosASL _used findEmptyPosition [0,100,"B_Heli_Light_01_armed_F"]) vectorAdd [0,0,1.5];
		_args = ["Box_NATO_Equip_F",_posBox,1,2000000,30];
		{BRPVP_eventJunkyIncidentObjects pushBack _x;} forEach (_args call BRPVP_spawnSpecialBox);

		{
			_class = selectRandom ["Box_NATO_Wps_F","Box_IND_Wps_F","Box_East_Wps_F"];
			_box = createVehicle [_class,BRPVP_posicaoFora,[],20,"NONE"];
			BRPVP_eventJunkyIncidentObjects pushBack _box;
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearBackPackCargoGlobal _box;
			clearItemCargoGlobal _box;
			{_box addMagazineCargoGlobal [_x,1];} forEach (round (_x*BRPVP_missionValueMult) call BRPVP_itemMoneyCreate);
			_house = selectRandom _houses;
			_box setPosASL AGLToASL selectRandom (_house buildingPos -1);
		} forEach [1000000];
		_allSuitCase = [];
		uiSleep BRPVP_eventDataSpawnWait;
		{
			_case = createVehicle ["Land_Suitcase_F",BRPVP_posicaoFora,[],20,"NONE"];
			BRPVP_eventJunkyIncidentObjects pushBack _case;
			_allSuitCase pushBack _case;
			_house = selectRandom _houses;
			_case setPosASL AGLToASL selectRandom (_house buildingPos -1);
			_case setVariable ["mny",round (_x*BRPVP_missionValueMult),true];
		} forEach [2000000,2000000];
		{
			_x params ["_class","_pos","_dir"];
			_grp = createGroup [BLUFOR,true];
			BRPVP_eventJunkyIncidentGroups pushBack _grp;
			_return = [[random 100,0,0],0,_class,_grp] call BIS_fnc_spawnVehicle;
			_hmg = _return select 0;
			_hmg setVariable ["brpvp_can_disable",true,2];
			_hmg setPosASL AGLToASL _pos;
			_hmg setDir _dir;
			_hmg remoteExecCall ["BRPVP_veiculoEhReset",2];
			BRPVP_eventJunkyIncidentObjects pushBack _hmg;
			_unit = _return select 1 select 0;
			_unit addEventHandler ["Killed",{BRPVP_eventJunkyIncidentDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
			_unit addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_unit removeWeapon primaryWeapon _unit;
			_AIUnits pushBack _unit;
			uiSleep BRPVP_eventDataSpawnWait;
		} forEach [
			["B_HMG_01_high_F",[6053.67,12610.5,0],328.67],
			["B_HMG_01_high_F",[5965.93,12541.8,2.82],109.14],
			["B_HMG_01_high_F",[5967.19,12563.4,2.71],46.47],
			["B_HMG_01_high_F",[5959.58,12572.8,2.98],219.24]
		];		

		//CHG
		_AIUnits remoteExecCall ["BRPVP_updateAIUnitsArray",2];

		BRPVP_eventsDataCodeIsOn set [_idx,2];
		publicVariable "BRPVP_eventsDataCodeIsOn";
		[_idx,_allSuitCase] spawn {
			scriptName "EV1 MISSION WAITUNTIL";

			params ["_idx","_allSuitCase"];
			_center = BRPVP_eventsData select _idx select 0;
			_radius = BRPVP_eventsData select _idx select 1;
			_callA = 10;
			_running = true;
			_start1 = selectRandom [[2000,2000,1000],[-2000,2000,1000],[2000,-2000,1000],[-2000,-2000,1000]];
			_start2 = [-(_start1 select 0),-(_start1 select 1),_start1 select 2];
			{
				_x params ["_toKill","_extraRad","_placeVec","_class"];
				waitUntil {
					_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
					count BRPVP_eventJunkyIncidentDead >= _toKill || {isNull _x} count _allSuitCase > 0 || !_running
				};
				if (!_running) exitWith {};
				_grp = createGroup BLUFOR;
				BRPVP_eventJunkyIncidentGroups pushBack _grp;
				_return = [_center vectorAdd _placeVec,0,_class,_grp] call BIS_fnc_spawnVehicle;
				_veh = _return select 0;
				_units = _return select 1;
				BRPVP_eventJunkyIncidentObjects pushBack _veh;
				{
					_x addEventHandler ["Killed",{BRPVP_eventJunkyIncidentDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
					_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
					_x removeWeapon primaryWeapon _x;
					_x setSkill 1;
				} forEach _units;

				//CHG
				_units remoteExecCall ["BRPVP_updateAIUnitsArray",2];

				_veh flyInHeight 150;
				for "_a" from 0 to 240 step 120 do {
					_wp = _grp addWayPoint [_center vectorAdd _extraRad getPos [100,_a],0];
					BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
					_wp setWayPointType "MOVE";
				};
				_wp = _grp addWayPoint [_center vectorAdd _extraRad getPos [100,360],0];
				BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
				_wp setWayPointType "CYCLE";
			} forEach [[5,[150,0,0],_start1,selectRandom ["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F"]]];
			waitUntil {
				_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
				{isNull _x} count _allSuitCase > 0 || !_running
			};
			if (!_running) exitWith {};

			//CREATE PILOT
			_grpP = createGroup [WEST,true];
			BRPVP_eventJunkyIncidentGroups pushBack _grpP;
			_pilot = _grpP createUnit [BRPVP_missionWestGroups select 0 select 0,BRPVP_spawnAIFirstPos,[],0,"NONE"];
			[_pilot] joinSilent _grpP;
			_pilot setSkill 1;
			_pilot disableAI "TARGET";
			_pilot disableAI "AUTOTARGET";
			_pilot disableAI "AUTOCOMBAT";

			//CREATE CHOPPER
			_placeVec = selectRandom [[1200,1200,500],[-1200,1200,500],[1200,-1200,500],[-1200,-1200,500]];
			_start = _center vectorAdd _placeVec;
			_dir = [_start,_center] call BIS_fnc_dirTo;
			_heli = createVehicle ["B_Heli_Transport_03_F",_start,[],50,"FLY"];
			[_heli,["GetOut",{call BRPVP_AIGetOutVehTimerToDisable;}]] remoteExecCall ["addEventHandler",2];
			BRPVP_eventJunkyIncidentObjects pushBack _heli;
			_heli setPos _start;
			_heli setDir _dir;
			_heli flyInHeight 500;
			_pilot moveInDriver _heli;
			_pilot assignAsDriver _heli;
			
			//PUT SIEGE SOLDIERS IN CHOOPER CARGO AND SET THEIR OBJECTIVE
			_soldiers = [];
			_grps = [];
			_invsAI = [];
			for "_i" from 1 to 3 do {
				_grp = createGroup [WEST,true];
				BRPVP_eventJunkyIncidentGroups pushBack _grp;
				_grps pushBack _grp;
				_caras = selectRandom BRPVP_missionWestGroups;
				for "_j" from 1 to 5 do {
					_unidade = _grp createUnit [_caras select (_j - 1),BRPVP_spawnAIFirstPos,[],0,"NONE"];
					[_unidade] joinSilent _grp;
					[_unidade] call BRPVP_fillUnitWeapons;
					_invsAI pushBack [backPack _unidade,backpackItems _unidade];
					removeBackpack _unidade;
					_unidade assignAsCargo _heli;
					_unidade moveInCargo _heli;
					_unidade setSkill (BRPVP_AISkill select 1 select 0);
					_unidade setSkill ["aimingAccuracy",BRPVP_AISkill select 1 select 1];
					_unidade addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
					_unidade addEventHandler ["Killed",{BRPVP_eventJunkyIncidentDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
					_soldiers pushBack _unidade;
				};
			};
			
			//CHOOPER PATH: INSERTION
			_wp = _grpP addWayPoint [_center,0];
			BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
			_wp setWayPointType "MOVE";
			_wp setWayPointSpeed "FULL";

			//CHG
			(_soldiers+[_pilot]) remoteExecCall ["BRPVP_updateAIUnitsArray",2];

			waitUntil {
				_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
				_heli distance2D _center <= _radius * 1.15 || !canMove _heli || !_running
			};
			if (!_running) exitWith {};
			if (canMove _heli) then {
				_h = [];
				{_h pushBack (100 + (_forEachIndex * 10) mod 110);} forEach _soldiers;
				[_soldiers,_h,_invsAI,_idx] spawn {
					params ["_soldiers","_h","_invsAI","_idx"];
					_cnt = count _soldiers;
					_okPara = [];
					_okGround = [];
					_running = true;
					waitUntil {
						{
							_unit = _x;
							if !(_unit in _okPara) then {
								if ((getPosATL _unit) select 2 <= _h select _forEachIndex) then {
									_unit addBackpack "B_Parachute";
									_okPara pushBack _unit;
								};
							};
							if !(_unit in _okGround) then {
								if (vehicle _unit isEqualTo _unit) then {
									_okGround pushBack _unit;
								};
							};
						} forEach _soldiers;
						_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
						(count _okPara isEqualTo _cnt && count _okGround isEqualTo _cnt) || !_running
					};
					if (!_running) exitWith {};
					{
						_backPack = _invsAI select _forEachIndex select 0;
						if (_backPack != "" && alive _x) then {
							_items = _invsAI select _forEachIndex select 1;
							_x addBackPack _backPack;
							[backPackContainer _x,_items] call BRPVP_addLoot;
						};
					} forEach _soldiers;
				};
				{
					unassignVehicle _x;
					moveOut _x;
					[_x] allowGetIn false;
					_init = time;
					_sleep = 0.3 + random 0.2;
					waitUntil {
						_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
						time - _init >= _sleep || !_running
					};
					if (!canMove _heli || !_running) exitWith {};
				} forEach _soldiers;
				if (!_running) exitWith {};

				_init = time;
				_sleep = 2.5;
				waitUntil {
					_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
					time - _init >= _sleep || !_running
				};
				if (!_running) exitWith {};

				{
					private ["_pos1"];
					_grp = _x;
					for "_i2" from 1 to 200 do {
						_pos1 = _center getPos [random _radius,random 360];
						if (not surfaceIsWater _pos1) exitWith {};
					};
					_pos2Array = [];
					for "_i2" from 1 to 3 do {
						for "_i3" from 1 to 200 do {
							_pos = _center getPos [random _radius,random 360];
							if (not surfaceIsWater _pos) exitWith {_pos2Array pushBack _pos;};
						};
					};
					_pos2Array = _pos2Array apply {[_x distanceSqr _pos1,_x]};
					_pos2Array sort false;
					_pos2 = _pos2Array select 0 select 1;
					
					//WAYPOINT 1
					_wp = _grp addWayPoint [_pos2 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
					BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
					_wp setWaypointCompletionRadius 10;
					_wp setWayPointType "MOVE";
					_wp setWayPointFormation "STAG COLUMN";
					
					//WAYPOINT 2
					_wp = _grp addWayPoint [_pos1 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
					BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
					_wp setWaypointCompletionRadius 10;
					_wp setWayPointType "MOVE";
					_wp setWayPointFormation "STAG COLUMN";

					//WAYPOINT 3
					_wp = _grp addWayPoint [_pos2 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
					BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
					_wp setWaypointCompletionRadius 10;
					_wp setWayPointType "CYCLE";
					_wp setWayPointFormation "STAG COLUMN";
				} forEach _grps;
				
				if (canMove _heli) then {
					_wp = _grpP addWayPoint [_start,0];
					BRPVP_eventJunkyIncidentWayPoints pushBack _wp;
					_wp setWayPointType "MOVE";
					_wp setWayPointSpeed "FULL";
					
					//DELETE RETURNED CHOOPER AND PILOT
					waitUntil {
						_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
						currentWayPoint _grpP isEqualTo 3 || !alive _heli || !alive _pilot || !_running
					};
					if (alive _pilot && alive _heli && _running) then {
						deleteVehicle _heli;
						deleteVehicle _pilot;
					};
				};
			};

			//RESTART ANOTHER EV MISSION
			waitUntil {
				_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
				{not isNull _x} count _allSuitCase isEqualTo 0 || !_running
			};
			if (!_running) exitWith {};
			waitUntil {
				_aliveU = [];
				{_aliveU append units _x;} forEach BRPVP_eventJunkyIncidentGroups;
				_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
				count _aliveU <= 10 || !_running
			};
			if (!_running) exitWith {};
			_init = time;
			waitUntil {
				_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
				time - _init > 20*60 || !_running
			};
			if (!_running) exitWith {};
			
			//CHG
			_idx remoteExecCall [BRPVP_eventsDataCodeOff select _idx,2];
			
			waitUntil {BRPVP_eventsDataCodeIsOn select _idx isEqualTo 0};
			_eventIdxToRun = [];
			{if (_x isEqualTo 0 && _forEachIndex != _idx) then {_eventIdxToRun pushBack _forEachIndex;};} forEach BRPVP_eventsDataCodeIsOn;
			if (count _eventIdxToRun > 0) then {
				_idxNew = selectRandom _eventIdxToRun;
				
				//CHG
				_idxNew remoteExec ["BRPVP_eventsInitiateFromServer",2];
			};
		};
	};
};
BRPVP_eventJunkyIncidentOff = {
	_idx = _this;
	_state = BRPVP_eventsDataCodeIsOn select _idx;
	if (_state isEqualTo 2) then {
		BRPVP_eventsDataCodeIsOn set [_idx,1];
		publicVariable "BRPVP_eventsDataCodeIsOn";
		{deleteWayPoint _x;} forEach BRPVP_eventJunkyIncidentWayPoints;
		{
			_units = units _x;
			{
				_x removeAllEventHandlers "HandleDamage";
				_x removeAllEventHandlers "Killed";
				deleteVehicle _x;
			} forEach _units;
			deleteGroup _x;
		} forEach BRPVP_eventJunkyIncidentGroups;
		{
			_x removeAllEventHandlers "HandleDamage";
			_x removeAllEventHandlers "Killed";
			_toDel = _x getVariable ["brpvp_del_on_clean",objNull];

			//CHG 2
			if (!isNull _toDel && {_toDel distance _x < 5}) then {deleteVehicle _toDel;};

			_car = objectParent _x;
			if (isNull _car) then {deleteVehicle _x;} else {_car deleteVehicleCrew _x;};
		} forEach BRPVP_eventJunkyIncidentDead;
		{deleteVehicle _x;} forEach BRPVP_eventJunkyIncidentObjects;

		//DELETE DESTROYED HOUSES
		private _pos = BRPVP_eventsData select _idx select 0;
		private _rad = BRPVP_eventsData select _idx select 1;
		{if (_x getVariable ["brpvp_yes_minerva",false]) then {deleteVehicle _x;};} forEach ((nearestObjects [_pos,["Building","Wall"],_rad,true])-BRPVP_eventJunkyIncidentObjects);

		//DELETE MINES
		private _mines = nearestObjects [_pos,BRPVP_zombieDistractAmmo,_rad];
		if (_mines isNotEqualTo []) then {_mines spawn {{_x remoteExecCall ["BRPVP_missionStartEndExplodeLocalMines",2];uiSleep random 0.25;} forEach _this;};};

		[_idx,+BRPVP_eventJunkyIncidentObjects] spawn BRPVP_eventRepositioneObjectsAtEnd;

		//CHG
		[] remoteExecCall ["BRPVP_AIRemoveNull",2];
		[] remoteExecCall ["BRPVP_updateAIUnitsArray",2];

		BRPVP_eventsDataCodeIsOn set [_idx,0];
		publicVariable "BRPVP_eventsDataCodeIsOn";
	};
};