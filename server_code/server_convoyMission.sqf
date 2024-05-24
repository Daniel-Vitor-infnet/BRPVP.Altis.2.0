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

BRPVP_convoyMissionIdc = 0;
BRPVP_kvyKilledCount = 0;
BRPVP_kvyKilled = {
	_veh = _this select 0;
	_isAir = _veh isKindOf "Air";
	_veh removeAllEventHandlers "HandleDamage";
	_veh removeAllEventHandlers "GetIn";
	_money = _veh getVariable "mmny";
	_allBoxClass = ["Box_NATO_Grenades_F","Box_NATO_AmmoOrd_F","Box_NATO_Grenades_F","Box_NATO_Support_F"];
	_pos = ASLToAGL (getPosWorld _veh vectorAdd [0,0,3]);
	_box1 = createVehicle ["Box_NATO_Grenades_F",_pos getPos [5,random 360],[],0,"NONE"];
	_box1 addEventHandler ["HandleDamage",{0}];
	_box1 setVariable ["brpvp_del_when_empty",true,true];
	_box1 call BRPVP_emptyBox;
	{_box1 addMagazineCargoGlobal [_x,1]} forEach (_money call BRPVP_itemMoneyCreate);
	if (_isAir) then {
		_box1 spawn {
			private _box = _this;
			for "_i" from 1 to 20 do {
				private _init = diag_tickTime;
				private _smoke = createVehicle ["SmokeShellRed",[0,0,0],[],0,"NONE"];
				_smoke attachTo [_box,[0,0,0]];
				[_smoke,true] remoteExecCall ["hideObjectGlobal",2];
				waitUntil {diag_tickTime-_init > 60 || isNull _box};
				if (isNull _box) exitWith {deleteVehicle _smoke;};
			};
		};
	};
	if (random 1 < 0.5) then {
		_box2 = createVehicle [_allBoxClass select (BRPVP_kvyKilledCount mod count _allBoxClass),_pos getPos [5,random 360],[],0,"NONE"];
		_box2 addEventHandler ["HandleDamage",{0}];
		_box2 setVariable ["brpvp_del_when_empty",true,true];
		if (_isAir) then {
			_box2 spawn {
				private _box = _this;
				for "_i" from 1 to 20 do {
					private _init = diag_tickTime;
					private _smoke = createVehicle ["SmokeShellRed",[0,0,0],[],0,"NONE"];
					_smoke attachTo [_box,[0,0,0]];
					[_smoke,true] remoteExecCall ["hideObjectGlobal",2];
					waitUntil {diag_tickTime-_init > 60 || isNull _box};
					if (isNull _box) exitWith {deleteVehicle _smoke;};
				};
			};
		};
	};
	BRPVP_kvyKilledCount = BRPVP_kvyKilledCount+1;
};
BRPVP_convoyMission = {
	if (BRPVP_convoyMissionIdc isEqualTo -1) exitWith {};
	_convoyMissionIdc = BRPVP_convoyMissionIdc;
	BRPVP_convoyMissionIdc = -1;
	for "_t" from 0 to 30 do {
		_islands = BRPVP_mapaRodando select 20 select 2;
		_island = [];
		_rnd = random 1;
		_num = 0;
		{
			_add = _x select 0;
			if (_rnd >= _num && _rnd < _num + _add) exitWith {
				_island = _x select 1;
			};
			_num = _num + _add;
		} forEach _islands;
		if (count _island isEqualTo 0) then {
			diag_log "[BRPVP ERROR] Convoy Islands percentual must sum 1. Choosing island randonly!";
			_island = selectRandom _islands;
		};
		_msPlaces = [];
		{
			_p = _x select 0;
			_ms = _p nearEntities ["CAManBase",1000];
			if (nearestObjects [_p,["FlagCarrier"],300,true] isEqualTo []) then {
				_msPlaces pushBack [{_x call BRPVP_isPlayer} count _ms,_x];
			};
		} forEach _island;
		_msPlaces sort true;
		_msPlace = [_msPlaces,2.5-_t*0.05 ] call LOL_fnc_selectRandomFator;
		_p1 = _msPlace select 1 select 0;
		_d1 = _msPlace select 1 select 1;
		_convoys = [
			[["I_G_Offroad_01_armed_F","I_Heli_light_03_dynamicLoadout_F"],BLUFOR,[1,0,0,1],[2,3],"LIMITED",[350000,600000],2,"konvoyYellow.paa"],
			[["I_G_Offroad_01_armed_F","I_G_Offroad_01_armed_F"],BLUFOR,[1,0,0,1],[2,2],"LIMITED",[350000,350000],2,"konvoyYellow.paa"],
			[["I_MRAP_03_F","I_Heli_light_03_dynamicLoadout_F"],BLUFOR,[1,0,0,1],[2,3],"LIMITED",[350000,600000],3,"konvoyRed.paa"],
			[["I_APC_Wheeled_03_cannon_F","I_Heli_light_03_dynamicLoadout_F"],BLUFOR,[1,0,0,1],[2,3],"LIMITED",[500000,600000],3,"konvoyRed.paa"],
			[["I_APC_tracked_03_cannon_F","I_Heli_light_03_dynamicLoadout_F"],BLUFOR,[1,0,0,1],[2,3],"LIMITED",[500000,600000],3,"konvoyRed.paa"],
			[["I_Heli_light_03_dynamicLoadout_F","I_Heli_light_03_dynamicLoadout_F"],BLUFOR,[1,0,0,1],[3,3],"LIMITED",[500000,500000],4,"konvoyRed.paa"],
			[["I_APC_tracked_03_cannon_F"],BLUFOR,[1,0,0,1],[3],"LIMITED",[500000],2,"konvoyYellow.paa"],
			[["I_APC_Wheeled_03_cannon_F"],BLUFOR,[1,0,0,1],[3],"LIMITED",[500000],2,"konvoyYellow.paa"],
			[["I_G_Offroad_01_armed_F"],BLUFOR,[1,0,0,1],[2],"LIMITED",[350000],2,"konvoyBlue.paa"],
			[["O_MBT_04_command_F"],BLUFOR,[1,0,0,1],[5],"LIMITED",[800000],3,"konvoyRed.paa"]
		];
		if (BRPVP_useJetsConvoys) then {
			_convoys append [
				[["O_Plane_Fighter_02_F"],BLUFOR,[1,0,0,1],[0],"NORMAL",[1250000],6,"konvoyJets.paa"],
				[["B_Plane_CAS_01_dynamicLoadout_F"],BLUFOR,[1,0,0,1],[0],"NORMAL",[1250000],6,"konvoyJets.paa"]
			];
		};
		_convoy = selectRandom _convoys;
		_arr = [];
		{
			_dist = _p1 distance (_x select 0);
			_arr pushBack [_dist,_x];
		} forEach _island;
		_arr sort false;
		_arrSel = [_arr,_convoy select 6] call LOL_fnc_selectRandomFator;
		_p2 = _arrSel select 1 select 0;
		_d2 = _arrSel select 1 select 1;
		_blackList = [];
		_grp = createGroup [(_convoy select 1),true];
		_crewCvy = [];
		_composition = [];
		{
			_pos = getPos _x;
			_so = sizeOf typeOf _x;
			_so = _so/1.65;
			_pTL = _pos vectorAdd [-_so,_so,0];
			_pBR = _pos vectorAdd [_so,-_so,0];
			_pTL resize 2;
			_pBR resize 2;
			_blackList pushBack [_pTL,_pBR];
		} forEach (nearestObjects [_p1,["LandVehicle","Air","Man","Ship"],_d1]);
		_rst1 = [_p1,0,_d1,20,0,0.5,0,_blackList,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		_rst2 = [_p2,0,_d2,12,0,0.5,0,[],[_p2,_p2]] call BIS_fnc_findSafePos;
		_ok = false;
		if (_rst1 distance [0,0,0] > 0 && _rst2 distance [0,0,0] > 0) then {
			_ok = true;
			BRPVP_convoyMissionIdc = _convoyMissionIdc + 1;
			{
				_return = [_rst1,180,_x,_grp] call BIS_fnc_spawnVehicle;
				_veh = _return select 0;
				if (_veh isKindOf "Plane") then {
					private _newPos = _rst1 vectorAdd [-150 random 300,-150 random 300,1200];
					_veh setPosASL AGLToASL _newPos;
				} else {
					_veh setVehiclePosition [_rst1,[],20,"NONE"];
				};
				_veh setVariable ["mmny",round ((_convoy select 5 select _forEachIndex)*BRPVP_missionValueMult),true];
				_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
				_veh addEventHandler ["GetIn",{call BRPVP_carroBotGetIn;}];
				_veh addEventHandler ["Killed",{call BRPVP_kvyKilled;}];
				_composition pushBack _veh;
				_crew = _return select 1;
				_cgq = _convoy select 3 select _forEachIndex;
				_ep = _veh emptyPositions "Cargo";
				for "_i" from 1 to (_ep min _cgq) do {
					_unit = _grp createUnit [typeOf selectRandom _crew,BRPVP_spawnAIFirstPos,[],20,"FORM"];
					[_unit] joinSilent _grp;
					_unit assignAsCargo _veh;
					_unit moveInCargo _veh;
					_crew pushBack _unit;
				};
				_crewCvy append _crew;
			} forEach (_convoy select 0);
			{
				_x setSkill (BRPVP_AISkill select 2 select 0);
				_x setSkill ["aimingAccuracy",BRPVP_AISkill select 2 select 1];
			} forEach _crewCvy;
			BRPVP_konvoyCompositions pushBack [_composition,_crewCvy,_convoy select 7,_convoy select 2];
			publicVariable "BRPVP_konvoyCompositions";
			{
				_x addEventHandler ["Killed",{_this call BRPVP_botDaExp;_this call BRPVP_rolaMotorista;}];
				_x addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			} forEach _crewCvy;
			_speed = _convoy select 4;
			_wp = _grp addWayPoint [_rst2,0];
			_wp setWayPointType "MOVE";
			_wp setWayPointSpeed _speed;
			_wp setWayPointCompletionRadius 80;
			_wp = _grp addWayPoint [_rst1,0];
			_wp setWayPointType "MOVE";
			_wp setWayPointSpeed _speed;
			_wp setWayPointCompletionRadius 80;
			_wp = _grp addWayPoint [_rst2,0];
			_wp setWayPointType "CYCLE";
			_wp setWayPointSpeed _speed;
			_wp setWayPointCompletionRadius 80;
			_grp setBehaviour "COMBAT";
			_grp setCombatMode "RED";
			[] remoteExecCall ["BRPVP_AIRemoveNull",2];
			_crewCvy remoteExecCall ["BRPVP_updateAIUnitsArray",2];
		};
		if (_ok) exitWith {};
	};
};