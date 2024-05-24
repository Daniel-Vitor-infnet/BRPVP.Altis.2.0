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

BRPVP_aiAttackBaseExec = {
	params ["_points","_pASL","_players","_fRad"];
	private ["_aiQ","_hQ","_scm","_img"];
	private _pAGL = +_pASL;
	private _lPerc = 0;
	private _pExtra = [0,BRPVP_aiAttackBaseFactor] select (random 1 < 0.25);
	_pAGL set [2,0];
	for "_i" from 30 to 360 step 30 do {
		private _vec = [(_fRad+100)*sin _i,(_fRad+100)*cos _i,0];
		private _pCheck = _pAGL vectorAdd _vec;
		if (!surfaceIsWater _pCheck) then {_lPerc = _lPerc+1;};
	};
	_lPerc = _lPerc/12;
	if (_points+_pExtra <= BRPVP_aiAttackBaseFactor*1.5) then {
		if (_lPerc < 0.4) then {_aiQ = 0;_hQ = 1;} else {_aiQ = 6;_hQ = 0;};
		_scm = 200000;
		_img = "ai_attack_base_1.paa";
	} else {
		if (_points+_pExtra <= BRPVP_aiAttackBaseFactor*2.5) then {
			if (_lPerc < 0.4) then {_aiQ = 0;_hQ = 2;} else {_aiQ = 9;_hQ = 1;};
			_scm = 200000;
			_img = "ai_attack_base_2.paa";
		} else {
			if (_points+_pExtra <= BRPVP_aiAttackBaseFactor*3.5) then {
				if (_lPerc < 0.4) then {_aiQ = 0;_hQ = 3;} else {_aiQ = 12;_hQ = 2;};
				_scm = 200000;
				_img = "ai_attack_base_3.paa";
			} else {
				if (_lPerc < 0.4) then {_aiQ = 0;_hQ = 3;} else {_aiQ = 15;_hQ = 2;};
				_scm = 200000;
				_img = "ai_attack_base_3.paa";
			};
		};
	};
	_img remoteExecCall ["BRPVP_aiAttackBaseMessage",_players];
	private _grps = [];
	if (_aiQ > 0) then {
		for "_i" from 1 to 200 do {
			private _dt = _fRad+500;
			private _a = random 360;
			private _pb = _pAGL vectorAdd [_dt*sin _a,_dt*cos _a,0];
			private _pbOk = _pb findEmptyPosition [0,200,"C_Offroad_01_F"];
			if (_pbOk isNotEqualTo []) exitWith {
				private _grp = createGroup [BLUFOR,true];
				_grps pushBack _grp;
				for "_i2" from 1 to _aiQ do {
					private _class = selectRandom selectRandom BRPVP_missionWestGroups;
					private _ai = _grp createUnit [_class,_pbOk,[],6,"NONE"];
					[_ai] joinSilent _grp;
					_ai addEventHandler ["HandleDamage",{call BRPVP_hdEhNormal}];
					_ai setVariable ["brpvp_scm",_scm];
					_ai addEventHandler ["Killed",{
						if (random 1 < 0.5) then {
							private _ai = _this select 0;
							private _sp = ASLToAGL getPosASL _ai vectorAdd [0,0,1.25];
							private _sc = createVehicle ["Land_Suitcase_F",_sp,[],1.25,"CAN_COLLIDE"];
							_sc setVariable ["mny",round ((_ai getVariable "brpvp_scm")*BRPVP_missionValueMult),true];
						};
						call BRPVP_botDaExp;
					}];
					_ai call BRPVP_setNewAiUnitOutOfAiArray;
					uiSleep 0.05;
				};
				private _lastOk = true;
				private _pCycle = -1;
				private _pCycleRad = -1;
				for "_i3" from 1 to 8 do {
					private _bRad = _fRad+75+random 25;
					private _a = _i3*45;
					private _bPos = _pAGL vectorAdd [_bRad*sin _a,_bRad*cos _a,0];
					if (!surfaceIsWater _bPos) then {
						private _bPosOk = _bPos findEmptyPosition [0,50,"C_Quadbike_01_F"];
						if (_bPosOk isEqualTo []) then {
							if (_lastOk) then {
								_lastOk = false;
							} else {
								_bPosOk = _bPos;
								private _wp = _grp addWayPoint [_bPosOk,0];
								_wp setWaypointCompletionRadius 20;
								_wp setWayPointType "MOVE";
								if (_pCycle isEqualTo -1) then {_pCycle = +_bPosOk;_pCycleRad = 20;};
								_lastOk = true;
							};
						} else {
							private _wp = _grp addWayPoint [_bPosOk,0];
							_wp setWaypointCompletionRadius 5;
							_wp setWayPointType "MOVE";
							if (_pCycle isEqualTo -1) then {_pCycle = +_bPosOk;_pCycleRad = 5;};
							_lastOk = true;
						};
						uiSleep 0.001;
					};
				};
				private _wp = _grp addWayPoint [_pCycle,0];
				_wp setWaypointCompletionRadius _pCycleRad;
				_wp setWayPointType "CYCLE";
			};
			uiSleep 0.001;
		};
	};
	for "_i" from 1 to _hQ do {
		private _dt = _fRad+1250;
		private _a = random 360;
		private _pb = _pAGL vectorAdd [_dt*sin _a,_dt*cos _a,500];
		private _return = [_pb,_a+180,selectRandom BRPVP_aiAttackBaseHelis,BLUFOR] call BIS_fnc_spawnVehicle;
		_return params ["_veh","_crew","_grp"];
		_grps pushBack _grp;
		_veh setVariable ["mmny",round (300000*BRPVP_missionValueMult),true];
		_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
		_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
		_veh addEventHandler ["Killed",{
			private _veh = _this select 0;
			private _money = _veh getVariable "mmny";
			_veh removeAllEventHandlers "HandleDamage";
			_veh removeAllEventHandlers "GetIn";
			_veh removeAllEventHandlers "Killed";
			private _box1 = createVehicle ["Box_NATO_Grenades_F",(ASLToAGL getPosWorld _veh vectorAdd [0,0,3]) getPos [5,random 360],[],0,"NONE"];
			_box1 addEventHandler ["HandleDamage",{0}];
			_box1 setVariable ["brpvp_del_when_empty",true,true];
			_box1 call BRPVP_emptyBox;
			{_box1 addMagazineCargoGlobal [_x,1]} forEach (_money call BRPVP_itemMoneyCreate);
		}];
		{
			_x addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			_x addEventHandler ["HandleDamage",{_this call BRPVP_hdehNormal}];
		} forEach _crew;
		private _ag = random 360;
		_veh flyInHeight 150;
		private _wp1 = _grp addWayPoint [_pAGL vectorAdd [100*sin _ag,100*cos _ag,150],0];
		_wp1 setWayPointType "MOVE";
		_wp1 setWayPointCompletionRadius 10;
		private _wp2 = _grp addWayPoint [_pAGL vectorAdd [-100*sin _ag,-100*cos _ag,150],0];
		_wp2 setWayPointType "MOVE";
		_wp2 setWayPointCompletionRadius 10;
		private _wp3 = _grp addWayPoint [_pAGL vectorAdd [100*sin _ag,100*cos _ag,150],100];
		_wp3 setWayPointType "CYCLE";
		_wp3 setWayPointCompletionRadius 10;
		uiSleep 0.25;
	};
	for "_i" from 1 to 10 do {
		uiSleep 120;
		private _pBase = _pAGL nearEntities [BRPVP_playerModel,_fRad+100+50]; //,true]
		{
			private _player = _x;
			if (_player call BRPVP_isPlayer && _player call BRPVP_pAlive) then {{_x reveal [_player,4];} forEach _grps;};
		} forEach _pBase;
		if ((_grps select {!isNull _x}) isEqualTo []) exitWith {};
	};
};