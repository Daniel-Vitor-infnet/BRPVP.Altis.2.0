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

_scriptStart = diag_tickTime;
diag_log "[SCRIPT] servidor_bots_ape.sqf BEGIN";

BRPVP_fazRotaAPe = {
	params ["_origin","_group","_speed"];
	private ["_origin","_group","_speed","_posBefore","_posNow","_wp","_posNext"];
	_botQuantiaDestinos = 3;
	_posBefore = _origin;
	_posNow = _origin;
	_wp = _group addWaypoint [_posNow,0,0];
	_wp setWaypointCompletionRadius 15;
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed _speed;
	_posNext = [];
	for "_c" from 1 to _botQuantiaDestinos do {
		private ["_distToBefore","_distToNext","_found"];
		_distToBefore = 0;
		_distToNext = 0;
		_found = false;
		for "_x" from 1 to 100 do {
			private ["_otherIsland"];
			_posNext = selectRandom BRPVP_isecs;
			_distToNext = _posNow distance _posNext;
			_distToBefore = _posNext distance _posBefore;
			_otherIsland = false;
			if (_distToNext > 1000 && _distToNext < 5000 && _distToBefore > 1000) then {
				private ["_otherIsland","_distUnits","_dltX","_dltY"];
				_found = true;
				_distUnits = _distToNext/20;
				_dltX = ((_posNext select 0) - (_posNow select 0))/_distUnits;
				_dltY = ((_posNext select 1) - (_posNow select 1))/_distUnits;
				for "_i" from 1 to _distUnits do {
					private ["_travelPos"];
					_travelPos = [(_posNow select 0)+_i*_dltX,(_posNow select 1)+_i*_dltX];
					if (surfaceIsWater _travelPos) exitWith {_found = false;};
				};
			};
			if (_found) exitWith {};
		};
		if (!_found) then {_posNext = selectRandom BRPVP_isecs;};
		_wp = _group addWaypoint [_posNext,0,_c];
		_wp setWaypointCompletionRadius 15;
		_wp setWaypointType "MOVE";
		_wp setWaypointSpeed _speed;
		_posNow = _posNext;
	};
	_wp = _group addWaypoint [_origin,0,_botQuantiaDestinos+1];
	_wp setWaypointCompletionRadius 15;
	_wp setWaypointType "CYCLE";
	_wp setWaypointSpeed _speed;
};
BRPVP_spawnOnRoadBotsObjs = [];
BRPVP_spawnOnRoadBots = {
	params ["_amount","_groupSizes"];
	_groupSizes sort false;
	_groupSizesMax = _groupSizes select 0;
	_bots = [];
	for "_i" from 1 to _amount do {
		private ["_rua","_grupo"];
		_rua = [BRPVP_ruas,["Building"],[": t_",": b_"],100,-1,6,false] call BRPVP_achaCentroPrincipal;
		_posicaoBot = position _rua;
		
		//SET CHOOPER START AND END POSITION
		_xSize = BRPVP_mapaDimensoes select 0;
		_ySize = BRPVP_mapaDimensoes select 1;
		_rad = (_xSize*sqrt(2)/2) max (_ySize*sqrt(2)/2);
		_start = [[_xSize/2,_ySize/2,500],_rad,random 360] call BIS_fnc_relPos;
		_end = +_start;
		diag_log ("[BRPVP AI ON FOOT HELI] _start = " + str _start);
		
		//CREATE PILOT
		_grpP = createGroup [WEST,true];
		_pilot = _grpP createUnit ["B_T_Helipilot_F",BRPVP_spawnAIFirstPos,[],5,"NONE"];
		[_pilot] joinSilent _grpP;
		_pilot setSkill 0.35;
		_bots pushBack _pilot;
		
		//CREATE CHOPPER
		_dir = [_start,_posicaoBot] call BIS_fnc_dirTo;
		_heli = createVehicle ["B_Heli_Transport_03_F",_start,[],0,"FLY"];
		_heli setVariable ["iii",_i,false];
		_heli setVariable ["brpvp_no_possession",true,true];
		_heli addEventHandler ["Killed",{diag_log ("[*****] HELI KILLED "+str ((_this select 0) getVariable "iii")+" !");}];
		[_heli,["GetOut",{call BRPVP_AIGetOutVehTimerToDisable;}]] remoteExecCall ["addEventHandler",2];
		_heli setPos _start;
		_heli setDir _dir;
		_heli flyInHeight 200;
		_pilot moveInDriver _heli;
		_pilot assignAsDriver _heli;
		
		_grupo = createGroup [WEST,true];
		_grupoInfant = [];
		while {count _grupoInfant isEqualTo 0} do {
			_tenta = selectRandom BRPVP_gruposDeInfantaria;
			_unid = _tenta select 0 select 0;
			if (_unid find "B_" isEqualTo 0) then {_grupoInfant = _tenta;};
		};
		while {count _grupoInfant < _groupSizesMax} do {_grupoInfant append _grupoInfant;};
		_groupSize = selectRandom _groupSizes;
		while {count _grupoInfant > _groupSize} do {_grupoInfant deleteAt floor (random count _grupoInfant);};
		uiSleep BRPVP_simpleMissSpawnWait;
		private _haveTank = random 1 < 0.75;
		private _haveTankQtt = selectRandom [1,1,1,2,2,3];
		{
			_unidade = _grupo createUnit [_x select 0,BRPVP_spawnAIFirstPos,[],0,"FORM"];
			[_unidade] joinSilent _grupo;
			_unidade addEventHandler ["Killed",{
				if (random 1 < 0.25) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (100000*BRPVP_missionValueMult),true];};
				call BRPVP_botDaExp;
			}];
			_unidade addEventHandler ["handleDamage",{_this call BRPVP_hdeh}];
			_unidade setUnitRank (_x select 1);
			_unidade setSkill (BRPVP_AISkill select 3 select 0);
			_unidade setSkill ["aimingAccuracy",BRPVP_AISkill select 3 select 1];
			_bots pushBack _unidade;
			BRPVP_spawnOnRoadBotsObjs pushBack _unidade;
			_unidade moveInCargo _heli;

			//GAS TANK
			if (_haveTank && _forEachIndex < _haveTankQtt && BRPVP_uberAttackUse) then {
				_unidade addEventHandler ["Killed",{
					if (random 1 < 0.5) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (125000*BRPVP_missionValueMult),true];};
					call BRPVP_botDaExp;
				}];
				_unidade call BRPVP_uberAttackAddAi;
			} else {
				_unidade addEventHandler ["Killed",{
					if (random 1 < 0.25) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (100000*BRPVP_missionValueMult),true];};
					call BRPVP_botDaExp;
				}];
			};
		} forEach _grupoInfant;
		[_posicaoBot,_grpP,_grupo,_end,_pilot,_heli] spawn {
			params ["_posicaoBot","_grpP","_grupo","_end","_pilot","_heli"];
			_heli setVariable ["brpvp_no_refuel",true,2];
			
			//CHOOPER PATH: INSERTION
			_wp = _grpP addWayPoint [_posicaoBot vectorAdd [0,0,100],0];
			_wp setWayPointType "MOVE";
			_wp setWayPointSpeed "FULL";

			waitUntil {currentWayPoint _grpP isEqualTo 2};
			_wp = _grpP addWayPoint [_posicaoBot,0];
			_wp setWayPointType "TR UNLOAD";
			_wp setWayPointSpeed "FULL";

			_heli setFuel 0.0025;
			_heli addEventHandler ["HandleDamage",{
				params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
				if (_proj isEqualTo "") then {if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};} else {_dam};
			}];

			waitUntil {currentWayPoint _grpP isEqualTo 3};
			_heli setFuel 1;
			
			_wp = _grpP addWayPoint [_end,0];
			_wp setWayPointType "MOVE";
			_wp setWayPointSpeed "FULL";
			
			_grupo setBehaviour "SAFE";
			[_posicaoBot,_grupo,"LIMITED"] call BRPVP_fazRotaAPe;
			
			waitUntil {currentWayPoint _grpP isEqualTo 4 || !alive _heli || !alive _pilot};
			if (alive _pilot && alive _heli) then {
				deleteVehicle _heli;
				deleteVehicle _pilot;
			};
		};
		uiSleep BRPVP_simpleMissSpawnWait;
	};

	//CHG
	remoteExecCall ["BRPVP_AIRemoveNull",2];
	_bots remoteExecCall ["BRPVP_updateAIUnitsArray",2];
	BRPVP_smallMissionsAIObjs append _bots;
};
if (BRPVP_mapaRodando select 6 select 0) then {[BRPVP_mapaRodando select 6 select 1,BRPVP_mapaRodando select 6 select 2] call BRPVP_spawnOnRoadBots;};

diag_log ("[SCRIPT] servidor_bots_ape.sqf END: " + str round (diag_tickTime - _scriptStart));