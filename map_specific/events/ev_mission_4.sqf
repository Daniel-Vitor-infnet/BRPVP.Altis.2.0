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

BRPVP_eventFearRefineryOn = {
	params ["_idx","_svcObjs"];
	diag_log ("[CHECK FOR NULL EV_Null] "+str ({isNull _x} count _svcObjs));
	waitUntil {{isNull _x} count _svcObjs isEqualTo 0};
	_state = BRPVP_eventsDataCodeIsOn select _idx;
	if (_state isEqualTo 0) then {
		BRPVP_eventsDataCodeIsOn set [_idx,1];
		publicVariable "BRPVP_eventsDataCodeIsOn";
		_center = BRPVP_eventsData select _idx select 0;
		_radius = BRPVP_eventsData select _idx select 1;
		BRPVP_eventFearRefineryObjects = _svcObjs;
		BRPVP_eventFearRefineryObjectsHide = [];
		BRPVP_eventFearRefineryGroups = [];
		BRPVP_eventFearRefineryDead = [];
		BRPVP_eventFearRefineryWayPoints = [];
		BRPVP_eventFearRefineryTurrets = [];

		//SPAWN AI AND VEHICLES
		//130 METERS FROM CENTER
		_referenceRoute = [
			[24190.9,18760.5,0],
			[24007.8,18759.0,0],
			[24013.3,18570.4,0],
			[24191.4,18575.8,0]
		];
		_vehicleRoute = _referenceRoute apply {_center vectorAdd (_x vectorDiff _center vectorMultiply 1)};
		_vehicleRouteTanks = _referenceRoute apply {_center vectorAdd (_x vectorDiff _center vectorMultiply 1.6)};
		_vehicleRouteAIOnFoot = _referenceRoute apply {_center vectorAdd (_x vectorDiff _center vectorMultiply 0.8)};
		_AICheckPoints = [
			[24069.3,18702.9,0],
			[24144.1,18720.1,0],
			[24154.0,18670.0,0],
			[24086.4,18623.9,0]
		];
		_vehicles = [
			["B_MRAP_01_gmg_F",80000,[]]
		];
		_vehiclesTanks = [
			["O_APC_Tracked_02_cannon_F",120000,[]],
			["I_MBT_03_cannon_F",180000,[]]
		];

		//SPAWN VEHICLES
		_addToarray = [];
		{
			_x params ["_class","_money","_AI"];
			_grp = createGroup [BLUFOR,true];
			_grpAI = createGroup [BLUFOR,true];
			BRPVP_eventFearRefineryGroups pushBack _grp;
			BRPVP_eventFearRefineryGroups pushBack _grpAI;
			_pos = _vehicleRoute select 0;
			_posOnFoot = _vehicleRouteAIOnFoot select 0;
			_return = [_pos,[_vehicleRoute select 0,_vehicleRoute select 1] call BIS_fnc_dirTo,_class,_grp] call BIS_fnc_spawnVehicle;
			_veh = _return select 0;
			BRPVP_eventFearRefineryObjects pushBack _veh;
			_veh setVariable ["mmny",_money];
			_veh setVariable ["brpvp_can_disable",true,2];
			_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
			_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
			_veh addEventHandler ["Killed",{_this call BRPVP_kvyKilled;}];
			_units = _return select 1;
			{
				_unit = _grpAI createUnit [_x,_posOnFoot,[],10,"NONE"];
				[_unit] joinSilent _grpAI;
				_units pushBack _unit;
			} forEach _AI;
			{
				_x addEventHandler ["Killed",{BRPVP_eventFearRefineryDead pushBack (_this select 0);_this call BRPVP_botDaExp;_this call BRPVP_rolaMotorista;}];
				_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				_x setSkill 1;
			} forEach _units;
			_addToarray append _units;
			{
				_wp = _grp addWayPoint [_x,0];
				BRPVP_eventFearRefineryWayPoints pushBack _wp;
				_wp setWaypointCompletionRadius 20;
				_wp setWayPointType "MOVE";
				_wp = _grpAI addWayPoint [_vehicleRouteAIOnFoot select _forEachIndex,0];
				BRPVP_eventFearRefineryWayPoints pushBack _wp;
				_wp setWaypointCompletionRadius 20;
				_wp setWayPointType "MOVE";
			} forEach _vehicleRoute;
			_wp = _grp addWayPoint [_vehicleRoute select 0,0];
			BRPVP_eventFearRefineryWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 20;
			_wp setWayPointType "CYCLE";
			_wp = _grpAI addWayPoint [_vehicleRouteAIOnFoot select 0,0];
			BRPVP_eventFearRefineryWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 20;
			_wp setWayPointType "CYCLE";
			_grp setSpeedMode "FULL";
			_vehicleRoute pushBack (_vehicleRoute select 0);
			_vehicleRoute deleteAt 0;
			_vehicleRouteAIOnFoot pushBack (_vehicleRouteAIOnFoot select 0);
			_vehicleRouteAIOnFoot deleteAt 0;
			uiSleep BRPVP_eventDataSpawnWait;
		} forEach _vehicles;

		//SPAWN VEHICLES TANKS
		{
			_x params ["_class","_money","_AI"];
			_grp = createGroup [BLUFOR,true];
			_grpAI = createGroup [BLUFOR,true];
			BRPVP_eventFearRefineryGroups pushBack _grp;
			BRPVP_eventFearRefineryGroups pushBack _grpAI;
			_pos = _vehicleRouteTanks select 0;
			_posOnFoot = _vehicleRouteAIOnFoot select 0;
			_return = [_pos,[_vehicleRouteTanks select 0,_vehicleRouteTanks select 1] call BIS_fnc_dirTo,_class,_grp] call BIS_fnc_spawnVehicle;
			_veh = _return select 0;
			BRPVP_eventFearRefineryObjects pushBack _veh;
			_veh setVariable ["mmny",_money];
			_veh setVariable ["brpvp_can_disable",true,2];
			_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
			_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
			_veh addEventHandler ["Killed",{_this call BRPVP_kvyKilled;}];
			_units = _return select 1;
			{
				_unit = _grpAI createUnit [_x,_posOnFoot,[],10,"NONE"];
				[_unit] joinSilent _grpAI;
				_units pushBack _unit;
			} forEach _AI;
			{
				_x addEventHandler ["Killed",{BRPVP_eventFearRefineryDead pushBack (_this select 0);_this call BRPVP_botDaExp;_this call BRPVP_rolaMotorista;}];
				_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				_x setSkill 1;
			} forEach _units;
			_addToarray append _units;
			{
				_wp = _grp addWayPoint [_x,0];
				BRPVP_eventFearRefineryWayPoints pushBack _wp;
				_wp setWaypointCompletionRadius 20;
				_wp setWayPointType "MOVE";
				_wp = _grpAI addWayPoint [_vehicleRouteAIOnFoot select _forEachIndex,0];
				BRPVP_eventFearRefineryWayPoints pushBack _wp;
				_wp setWaypointCompletionRadius 20;
				_wp setWayPointType "MOVE";
			} forEach _vehicleRouteTanks;
			_wp = _grp addWayPoint [_vehicleRouteTanks select 0,0];
			BRPVP_eventFearRefineryWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 20;
			_wp setWayPointType "CYCLE";
			_wp = _grpAI addWayPoint [_vehicleRouteAIOnFoot select 0,0];
			BRPVP_eventFearRefineryWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 20;
			_wp setWayPointType "CYCLE";
			_grp setSpeedMode "FULL";
			_vehicleRouteTanks pushBack (_vehicleRouteTanks select 0);
			_vehicleRouteTanks deleteAt 0;
			_vehicleRouteAIOnFoot pushBack (_vehicleRouteAIOnFoot select 0);
			_vehicleRouteAIOnFoot deleteAt 0;
			uiSleep BRPVP_eventDataSpawnWait;
		} forEach _vehiclesTanks;

		//SPAWN AI GROUPS
		for "_i" from 1 to 2 do {
			_grp = createGroup [BLUFOR,true];
			BRPVP_eventFearRefineryGroups pushBack _grp;
			_squad = selectRandom BRPVP_missionWestGroups;
			_spawn = _AICheckPoints select 0;
			{
				_unit = _grp createUnit [_x,_spawn,[],10,"NONE"];
				[_unit] joinSilent _grp;
				_unit addEventHandler ["Killed",{BRPVP_eventFearRefineryDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
				_unit addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				_addToarray pushBack _unit;
			} forEach _squad;
			_AICheckPoints pushBack (_AICheckPoints select 0);
			_AICheckPoints deleteAt 0;
			{
				_wp = _grp addWayPoint [_x,0];
				BRPVP_eventFearRefineryWayPoints pushBack _wp;
				_wp setWaypointCompletionRadius 10;
				_wp setWayPointType "MOVE";
				_wp setWayPointFormation "STAG COLUMN";
			} forEach _AICheckPoints;
			_wp = _grp addWayPoint [_AICheckPoints select 0,0];
			BRPVP_eventFearRefineryWayPoints pushBack _wp;
			_wp setWaypointCompletionRadius 10;
			_wp setWayPointType "CYCLE";
			uiSleep BRPVP_eventDataSpawnWait;
		};

		//BASE TURRETS
		_HMGS = [
			[[24041.2,18716.0,22.39],268.68],
			[[24156.3,18668.6,22.51],89.46],
			[[24083.8,18637.7,10.11],2.06],
			[[24130.3,18623.7,0],186.82],
			[[24093.0,18665.2,22.42],0]
		];
		{
			_x params ["_pos","_dir"];
			_hmg = createVehicle ["I_HMG_01_high_F",_pos,[],0,"CAN_COLLIDE"];
			_hmg setDir _dir;
			_hmg setVariable ["own",-2,true];
			_hmg setVariable ["stp",4,true];
			_hmg setVariable ["amg",[[],[],false],true];

			//CHG
			_hmg remoteExecCall ["BRPVP_setTurretOperator",2];

			BRPVP_eventFearRefineryTurrets pushBack _hmg;
			_hmg setVariable ["brpvp_dead_delete",true,2];
			
			uiSleep BRPVP_eventDataSpawnWait;
		} forEach _HMGS;

		//SPAWN MONEY REWARD
		_houses = [];
		_housesUsed = [];
		{if (count (_x buildingPos -1) > 0) then {_houses pushBack _x;};} forEach (_center nearObjects ["House",_radius]);
		for "_i" from 1 to selectRandom [1] do {
			_class = selectRandom ["Box_T_East_WpsSpecial_F","Box_East_WpsSpecial_F","Box_IND_WpsSpecial_F","Box_T_NATO_WpsSpecial_F","Box_NATO_WpsSpecial_F"];
			_box = createVehicle [_class,BRPVP_posicaoFora,[],20,"NONE"];
			_box call BRPVP_removeDeniedItems;
			BRPVP_eventFearRefineryObjects pushBack _box;
			_used = selectRandom (_houses - _housesUsed);
			_box setPosASL AGLToASL (ASLtoAGL getPosASL _used findEmptyPosition [0,50,_class]);
			_housesUsed pushBack _used;
		};

		//MOUNTED BOX WITH RARE CHANCE
		_used = selectRandom (_houses - _housesUsed);
		_housesUsed pushBack _used;
		_posBox = (ASLtoAGL getPosASL _used findEmptyPosition [0,100,"B_Heli_Light_01_armed_F"]) vectorAdd [0,0,1.5];
		_args = ["Box_NATO_Equip_F",_posBox,1,2000000,30];
		{BRPVP_eventFearRefineryObjects pushBack _x;} forEach (_args call BRPVP_spawnSpecialBox);

		{
			_class = selectRandom ["Box_NATO_Wps_F","Box_IND_Wps_F","Box_East_Wps_F"];
			_box = createVehicle [_class,BRPVP_posicaoFora,[],20,"NONE"];
			BRPVP_eventFearRefineryObjects pushBack _box;
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearBackPackCargoGlobal _box;
			clearItemCargoGlobal _box;
			{_box addMagazineCargoGlobal [_x,1];} forEach (round (_x*BRPVP_missionValueMult) call BRPVP_itemMoneyCreate);
			_house = selectRandom _houses;
			_box setPosASL AGLToASL selectRandom (_house buildingPos -1);
		} forEach [1000000];
		uiSleep BRPVP_eventDataSpawnWait;
		_allSuitCase = [];
		{
			_case = createVehicle ["Land_Suitcase_F",BRPVP_posicaoFora,[],20,"NONE"];
			BRPVP_eventFearRefineryObjects pushBack _case;
			_allSuitCase pushBack _case;
			_house = selectRandom _houses;
			_case setPosASL AGLToASL selectRandom (_house buildingPos -1);
			_case setVariable ["mny",round (_x*BRPVP_missionValueMult),true];
		} forEach [4000000,4000000];

		//CHG
		_addToarray remoteExecCall ["BRPVP_updateAIUnitsArray",2];

		BRPVP_eventsDataCodeIsOn set [_idx,2];
		publicVariable "BRPVP_eventsDataCodeIsOn";
		[_idx,_allSuitCase] spawn {
			scriptName "EV4 MISSION WAITUNTIL";

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
					count BRPVP_eventFearRefineryDead >= _toKill || {isNull _x} count _allSuitCase > 0 || !_running
				};
				if (!_running) exitWith {};
				_grp = createGroup BLUFOR;
				BRPVP_eventFearRefineryGroups pushBack _grp;
				_return = [_center vectorAdd _placeVec,0,_class,_grp] call BIS_fnc_spawnVehicle;
				_veh = _return select 0;
				_units = _return select 1;
				BRPVP_eventFearRefineryObjects pushBack _veh;
				{
					_x addEventHandler ["Killed",{BRPVP_eventFearRefineryDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
					_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
					_x removeWeapon primaryWeapon _x;
					_x setSkill 1;
				} forEach _units;

				//CHG
				_units remoteExecCall ["BRPVP_updateAIUnitsArray",2];

				_veh flyInHeight 150;
				for "_a" from 0 to 240 step 120 do {
					_wp = _grp addWayPoint [_center vectorAdd _extraRad getPos [100,_a],0];
					BRPVP_eventFearRefineryWayPoints pushBack _wp;
					_wp setWayPointType "MOVE";
				};
				_wp = _grp addWayPoint [_center vectorAdd _extraRad getPos [100,360],0];
				BRPVP_eventFearRefineryWayPoints pushBack _wp;
				_wp setWayPointType "CYCLE";
			} forEach [
				[5,[200,0,0],_start1,selectRandom ["B_Heli_Light_01_armed_F","I_Heli_light_03_F"]],
				[15,[-200,0,0],_start2,selectRandom ["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F"]]
			];
			waitUntil {
				_running = BRPVP_eventsDataCodeIsOn select _idx isEqualTo 2;
				{isNull _x} count _allSuitCase > 0 || !_running
			};
			if (!_running) exitWith {};

			//CREATE PILOT
			_grpP = createGroup [WEST,true];
			BRPVP_eventFearRefineryGroups pushBack _grpP;
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
			BRPVP_eventFearRefineryObjects pushBack _heli;
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
				BRPVP_eventFearRefineryGroups pushBack _grp;
				_grps pushBack _grp;
				_caras = selectRandom BRPVP_missionWestGroups;
				for "_j" from 1 to 5 do {
					_unidade = _grp createUnit [_caras select (_j - 1),BRPVP_spawnAIFirstPos,[],0,"NONE"];
					[_unidade] joinSilent _grp;
					_invsAI pushBack [backPack _unidade,backpackItems _unidade];
					removeBackpack _unidade;
					_unidade assignAsCargo _heli;
					_unidade moveInCargo _heli;
					_unidade setSkill (BRPVP_AISkill select 1 select 0);
					_unidade setSkill ["aimingAccuracy",BRPVP_AISkill select 1 select 1];
					_unidade addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
					_unidade addEventHandler ["Killed",{BRPVP_eventFearRefineryDead pushBack (_this select 0);_this call BRPVP_botDaExp;}];
					_soldiers pushBack _unidade;
				};
			};
			
			//CHOOPER PATH: INSERTION
			_wp = _grpP addWayPoint [_center,0];
			BRPVP_eventFearRefineryWayPoints pushBack _wp;
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
					BRPVP_eventFearRefineryWayPoints pushBack _wp;
					_wp setWaypointCompletionRadius 10;
					_wp setWayPointType "MOVE";
					_wp setWayPointFormation "STAG COLUMN";
					
					//WAYPOINT 2
					_wp = _grp addWayPoint [_pos1 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
					BRPVP_eventFearRefineryWayPoints pushBack _wp;
					_wp setWaypointCompletionRadius 10;
					_wp setWayPointType "MOVE";
					_wp setWayPointFormation "STAG COLUMN";

					//WAYPOINT 3
					_wp = _grp addWayPoint [_pos2 findEmptyPosition [0,25,BRPVP_zombieMotherClass],0];
					BRPVP_eventFearRefineryWayPoints pushBack _wp;
					_wp setWaypointCompletionRadius 10;
					_wp setWayPointType "CYCLE";
					_wp setWayPointFormation "STAG COLUMN";
				} forEach _grps;
				
				if (canMove _heli) then {
					_wp = _grpP addWayPoint [_start,0];
					BRPVP_eventFearRefineryWayPoints pushBack _wp;
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
				{_aliveU append units _x;} forEach BRPVP_eventFearRefineryGroups;
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
BRPVP_eventFearRefineryOff = {
	_idx = _this;
	_state = BRPVP_eventsDataCodeIsOn select _idx;
	if (_state isEqualTo 2) then {
		BRPVP_eventsDataCodeIsOn set [_idx,1];
		publicVariable "BRPVP_eventsDataCodeIsOn";
		{deleteWayPoint _x} forEach BRPVP_eventFearRefineryWayPoints;
		{
			_units = units _x;
			{
				_x removeAllEventHandlers "HandleDamage";
				_x removeAllEventHandlers "Killed";
				deleteVehicle _x;
			} forEach _units;
			deleteGroup _x;
		} forEach BRPVP_eventFearRefineryGroups;
		{
			_x removeAllEventHandlers "HandleDamage";
			_x removeAllEventHandlers "Killed";
			_toDel = _x getVariable ["brpvp_del_on_clean",objNull];

			//CHG 2
			if (!isNull _toDel && {_toDel distance _x < 5}) then {deleteVehicle _toDel;};

			_car = objectParent _x;
			if (isNull _car) then {deleteVehicle _x;} else {_car deleteVehicleCrew _x;};
		} forEach BRPVP_eventFearRefineryDead;
		{deleteVehicle _x;} forEach BRPVP_eventFearRefineryObjects;

		//DELETE DESTROYED HOUSES
		private _pos = BRPVP_eventsData select _idx select 0;
		private _rad = BRPVP_eventsData select _idx select 1;
		{if (_x getVariable ["brpvp_yes_minerva",false]) then {deleteVehicle _x;};} forEach ((nearestObjects [_pos,["Building","Wall"],_rad,true])-BRPVP_eventFearRefineryObjects);

		//DELETE MINES
		private _mines = nearestObjects [_pos,BRPVP_zombieDistractAmmo,_rad];
		if (_mines isNotEqualTo []) then {_mines spawn {{_x remoteExecCall ["BRPVP_missionStartEndExplodeLocalMines",2];uiSleep random 0.25;} forEach _this;};};

		[_idx,+BRPVP_eventFearRefineryObjects] spawn BRPVP_eventRepositioneObjectsAtEnd;

		//CHG
		[] remoteExecCall ["BRPVP_AIRemoveNull",2];
		[] remoteExecCall ["BRPVP_updateAIUnitsArray",2];

		{_x hideObjectGlobal false;} forEach BRPVP_eventFearRefineryObjectsHide;

		//CHG
		BRPVP_eventFearRefineryTurrets remoteExecCall ["BRPVP_EVOffRemoveTurret",2];

		BRPVP_eventsDataCodeIsOn set [_idx,0];
		publicVariable "BRPVP_eventsDataCodeIsOn";
	};
};