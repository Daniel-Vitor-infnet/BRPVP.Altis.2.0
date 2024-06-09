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

if (isNil "BRPVP_carrierMissPositions") then {
	private _found = [];
	private _brd = BRPVP_carrierMissPosBorder;	
	while {count _found < 100} do {
		private _pos = [_brd+random ((BRPVP_mapaDimensoes select 0)-2*_brd),_brd+random ((BRPVP_mapaDimensoes select 1)-2*_brd),0];
		if (surfaceIsWater _pos) then {
			private _nearMin = [_pos,BRPVP_carrierMissPosLim select 0] call BRPVP_checkIfLandNear;
			private _nearMax = [_pos,BRPVP_carrierMissPosLim select 1] call BRPVP_checkIfLandNear;
			if (!_nearMin && _nearMax) then {_found pushBack _pos;};
		};
	};
	BRPVP_carrierMissPositions = _found;
	diag_log "=============== BRPVP_carrierMissPositions: BEGIN ==================";
	{
		diag_log str (_x apply {(round (_x*10))/10});
		_mn = format ["XXX_CMP_%1",_forEachIndex];
		deleteMarker _mn;
		createMarker [_mn,_x];
		_mn setMarkerShape "ICON";
		_mn setMarkerType "mil_dot";
		_mn setMarkerColor "ColorBlue";
	} forEach BRPVP_carrierMissPositions;
	diag_log "=============== BRPVP_carrierMissPositions: END ====================";
};
BRPVP_carrierMissMainCodeRunning = false;
BRPVP_carrierMissMainCode = {
	if !(BRPVP_carrierMissMainCodeRunning) then {
		BRPVP_carrierMissMainCodeRunning = true;
		private _found = [];
		private _count = 0;
		while {_found isEqualTo [] && _count <= 200} do {
			private _pos = selectRandom BRPVP_carrierMissPositions;
			private _objs = nearestObjects [_pos,["FlagCarrier","Land_Carrier_01_base_F","Land_Destroyer_01_base_F"],1500,true];
			if (_objs isEqualTo []) then {_found = _pos;};
			_count = _count+1;
		};
		if (_found isEqualTo []) then {_found = selectRandom BRPVP_carrierMissPositions;};

		//CREATE CARRIER
		BRPVP_carrierMissCreateObj = nil;
		[_found,clientOwner] remoteExecCall ["BRPVP_carrierMissCreate",2];
		waitUntil {!isNil "BRPVP_carrierMissCreateObj"};
		uiSleep 10;
		private _carrier = BRPVP_carrierMissCreateObj;
		BRPVP_carrierMissActive pushBack _carrier;
		publicVariable "BRPVP_carrierMissActive";

		//SPAWN AI
		private _ata = [];
		private _cPositions = [
			[27.4727,146.189,24],
			[34.0078,103.525,24],
			[34.4277,71.209,24],
			[6.44336,170.728,24],
			[10.9453,130.003,24],
			[15.5293,89.0449,24],
			[22.5488,35.7432,24],
			[33.7402,-44.1338,24],
			[-16.5645,153.383,24],
			[-8.17188,85.124,24],
			[1.11914,15.1035,24],
			[14.7871,-69.418,24],
			[-30.6074,139.046,24],
			[-25.3516,50.8906,24],
			[-19.8379,-11.2334,24],
			[-6.85352,-86.8516,24],
			[-3.91016,-131.82,24],
			[4.65039,-170.924,24]
		] apply {_carrier modelToWorld _x};
		private _classes = [];
		private _q1 = 5;
		private _q2 = 3;
		while {count _classes < _q1*_q2} do {_classes append selectRandom BRPVP_missionWestGroups;};
		private _ataWait = [];
		for "_i" from 1 to _q1 do {
			private _cPositionsNow = +_cPositions;
			private _cPos1 = _cPositionsNow deleteAt (floor random count _cPositionsNow);
			private _cPos2 = _cPositionsNow deleteAt (floor random count _cPositionsNow);
			private _cPos3 = _cPositionsNow deleteAt (floor random count _cPositionsNow);
			private _grp = createGroup [BLUFOR,true];
			for "_i2" from 1 to _q2 do {
				private _class = _classes deleteAt (floor random count _classes);
				private _u = _grp createUnit [_class,_cPos1 vectorAdd [-5+random 10,-5+random 10,0],[],0,"CAN_COLLIDE"];
				[_u] joinSilent _grp;
				_u addEventHandler ["Killed",{
					private _pos = getPosASL (_this select 0) vectorAdd [0,0,1.25];
					private _suitCase = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
					_suitCase setPosASL _pos;
					_suitCase setVariable ["mny",round (700000*BRPVP_missionValueMult),true];
					_this call BRPVP_botDaExp;
				}];
				_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				_u disableAI "PATH";
				_u setDir random 360;
				_u setVariable ["brpvp_extra_chance",5];
				[_u,false] remoteEXecCall ["enableSimulationGlobal",2];
				_ata pushBack _u;
				_ataWait pushBack _u;
			};
			uiSleep BRPVP_simpleMissSpawnWait;
		};

		//SPAWN TURRETS
		{
			_x params ["_class","_pos","_dir"];
			_pos = _carrier modelToWorld _pos;
			private _hmg = createVehicle [_class,BRPVP_spawnAIFirstPos,[],10,"CAN_COLLIDE"];
			_hmg setPosASL AGLToASL _pos;
			_hmg setDir _dir;
			_hmg setVariable ["own",-2,true];
			_hmg setVariable ["stp",4,true];
			_hmg setVariable ["amg",[[],[],false],true];
			_hmg remoteExecCall ["BRPVP_setTurretOperator",2];
			uiSleep BRPVP_simpleMissSpawnWait;
		} forEach [
			["I_HMG_01_high_F",[37.6338,148.984,23.5143],random 360],
			["I_HMG_01_high_F",[-37.3237,166.315,23.5435],random 360],
			["I_HMG_01_high_F",[-32.4136,-11.7041,23.54],random 360],
			["I_HMG_01_high_F",[-30.6934,74.1504,23.5299],random 360],
			["I_HMG_01_high_F",[-31.3384,-76.6904,23.5308],random 360],
			["I_static_AA_F",[-29,-101,19.4],[_found,_carrier modelToWorld [-29,-101,19.4]] call BIS_fnc_dirTo],
			["I_static_AA_F",[30.2,174.8,19.7],[_found,_carrier modelToWorld [30.2,174.8,19.7]] call BIS_fnc_dirTo]
		];

		//RARE LOOT
		private _rarePosRelative = [-30.2,104.7,23.6];
		private _posRL = _carrier modelToWorld _rarePosRelative;
		private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
		_box setPosASL AGLToASL _posRL;
		_box setDir getDir _carrier;
		[_box,0,1,true,50] call BRPVP_createCompleteLootBox;

		//SPAWN JETS
		private _start1 = selectRandom [[2000,2000,1000],[-2000,2000,1000],[2000,-2000,1000],[-2000,-2000,1000]];
		private _start2 = [-(_start1 select 0),-(_start1 select 1),_start1 select 2];
		{
			_x params ["_extraRad","_placeVec","_class","_h"];
			private _grp = createGroup BLUFOR;
			private _return = [_found vectorAdd _placeVec,0,_class,_grp] call BIS_fnc_spawnVehicle;
			private _veh = _return select 0;
			_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
			_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
			_veh setVariable ["brpvp_coll_prot",true];
			private _units = _return select 1;
			_ata append _units;
			{
				_x addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
				_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				_x removeWeapon primaryWeapon _x;
				_x setSkill 1;
			} forEach _units;
			_veh flyInHeight _h;

			private _wpPos = _found vectorAdd _extraRad;
			_wpPos set [2,_h];
			private _wp = _grp addWayPoint [_wpPos,0];
			_wp setWayPointType "LOITER";
			_wp setWaypointLoiterRadius 100;
			_wp setWaypointLoiterType "CIRCLE";
			uiSleep BRPVP_simpleMissSpawnWait;
		} forEach [
			[[250,0,0],_start1,"B_Plane_CAS_01_dynamicLoadout_F",350]
		];

		//SPAWN BOATS
		{
			_x params ["_rad","_class"];
			private _aRnd = random 360;
			private _grp = createGroup BLUFOR;
			private _return = [[0,0,0],0,_class,_grp] call BIS_fnc_spawnVehicle;
			private _veh = _return select 0;
			_veh setVariable ["brpvp_can_disable",true,2];
			private _posI = _found getPos [_rad,300+_aRnd];
			_posI set [2,0];
			_veh setPosASL AGLToASL _posI;
			_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
			_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
			_veh setVariable ["brpvp_coll_prot",true];
			private _units = _return select 1;
			_ata append _units;
			{
				_x addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
				_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				_x removeWeapon primaryWeapon _x;
				_x setSkill 1;
			} forEach _units;
			for "_a" from 0 to 270 step 90 do {
				private _wpPos = _found getPos [_rad,_a+_aRnd];
				_wpPos set [2,0];
				private _wp = _grp addWayPoint [_wpPos,0];
				_wp setWaypointCompletionRadius 30;
				_wp setWayPointType "MOVE";
			};
			_wpPos = _found getPos [_rad,360+_aRnd];
			_wpPos set [2,0];
			_wp = _grp addWayPoint [_wpPos,0];
			_wp setWaypointCompletionRadius 30;
			_wp setWayPointType "CYCLE";
			_veh setDir ([_posI,_wpPos] call BIS_fnc_dirTo);
			uiSleep BRPVP_simpleMissSpawnWait;
		} forEach [
			[350,"B_T_Boat_Armed_01_minigun_F"],
			[400,"B_T_Boat_Armed_01_minigun_F"]
		];
		
		//FURNITURE
		private _dirC = getDir _carrier;
		{
			_x params ["_class","_posRel","_dir"];
			private _fur = createVehicle [_class,BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
			_fur setPosASL (_carrier modelToWorldWorld _posRel);
			_fur setDir _dir;
			uiSleep BRPVP_simpleMissSpawnWait;
		} forEach [
			["B_Plane_Fighter_01_F",[38.1172,74.3496,24],_dirC+175],
			["O_Plane_CAS_02_dynamicLoadout_F",[-22.4434,-50.8281,24],_dirC+175],
			["B_Heli_Attack_01_dynamicLoadout_F",[-24.2217,38.2773,24],_dirC+85]
		];

		BRPVP_carrierMissMainCodeRunning = false;

		[_ataWait,_ata] spawn {
			params ["_ataWait","_ata"];
			sleep 15;
			{[_x,true] remoteEXecCall ["enableSimulationGlobal",2];} forEach _ataWait;
			remoteExecCall ["BRPVP_AIRemoveNull",2];
			_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];
			BRPVP_smallMissionsAIObjs append _ata;

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
	};
};