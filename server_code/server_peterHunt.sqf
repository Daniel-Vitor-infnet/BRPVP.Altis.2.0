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

BRPVP_peterLocoDamage = [0.025,0.025,0.050,0.050,0.075,0.100];
BRPVP_peterTeleport = {
	params ["_peter","_ply",["_sDist",5],["_useMoveTo",true]];
	private _noDam = _peter getVariable ["brpvp_no_dam",false];
	if (!_noDam) then {
		private _peterVel = velocity _peter;
		private _peterVelOk = vectorMagnitude _peterVel > 0.125;
		private _pwl = getPosWorld _peter vectorAdd [0,0,0.5];
		private _vec1 = _pwl vectorDiff ((if (_ply isEqualType []) then {_ply} else {getPosWorld _ply}) vectorAdd [0,0,0.5]);
		private _vec2 = surfaceNormal _pwl;
		private _vec3A = _vec1 vectorCrossProduct _vec2;
		private _vec3B = _vec2 vectorCrossProduct _vec1;
		_vec3A = (vectorNormalized _vec3A) vectorMultiply _sDist;
		_vec3B = (vectorNormalized _vec3B) vectorMultiply _sDist;
		private _lis3A = lineIntersectsSurfaces [_pwl,_pwl vectorAdd _vec3A,_peter,objNull];
		private _lis3B = lineIntersectsSurfaces [_pwl,_pwl vectorAdd _vec3B,_peter,objNull];
		private _sides = [];
		if (_lis3A isEqualTo []) then {_sides pushBack [_vec3A,0];};
		if (_lis3B isEqualTo []) then {_sides pushBack [_vec3B,1];};
		if (_sides isEqualTo []) then {
			if (_sDist > 0) then {[_peter,_ply,_sDist-1.5 max 0] call BRPVP_peterTeleport;};
		} else {
			_peter moveTo ASLToAGL getPosASL _peter;
			private _side = if (count _sides isEqualTo 2) then {
				if (_peterVelOk) then {
					private _angleA = aCos (_vec3A vectorCos _peterVel);
					private _angleB = aCos (_vec3B vectorCos _peterVel);
					if (_angleA < 70) then {
						_peter setVariable ["brpvp_side_tele",1];
						_vec3A
					} else {
						if (_angleB < 70) then {
							_peter setVariable ["brpvp_side_tele",0];
							_vec3B
						} else {
							private _pref = _peter getVariable "brpvp_side_tele";
							_peter setVariable ["brpvp_side_tele",1-_pref];
							_sides select _pref select 0
						};
					};
				} else {
					private _pref = _peter getVariable "brpvp_side_tele";
					_peter setVariable ["brpvp_side_tele",1-_pref];
					_sides select _pref select 0
				};
			} else {
				_peter setVariable ["brpvp_side_tele",1-(_sides select 0 select 1)];
				_sides select 0 select 0
			};
			private _nd = [_peter,_pwl vectorAdd _side vectorAdd [0,0,-0.5]] call BIS_fnc_dirTo;
			_peter setPosWorld (_pwl vectorAdd _side vectorAdd [0,0,-0.5]);
			_peter setDir _nd;
			_peter remoteExec ["BRPVP_peterLocoTeleportEffect",BRPVP_allNoServer];
			[_peter,["laser",500]] remoteExecCall ["say3D",BRPVP_allNoServer];

			//MOVE TO
			if (_useMoveTo) then {
				private _runTo = [];
				private _center = _peter getVariable "brpvp_center";
				for "_i1" from 1 to 5 do {
					private _a = random 360;
					private _d = sqrt (random (350^2)) max 50;
					private _try = _center vectorAdd [_d*sin _a,_d*cos _a,0];
					if (!surfaceIsWater _try) exitWith  {_runTo = _try;};
				};
				if (_runTo isNotEqualTo []) then {
					{
						private _best = [_runTo,_x*10,_x*10+25,5,0,0,0,[],[]] call BIS_fnc_findSafePos;
						if (_best isNotEqualTo []) exitWith {_peter moveTo (_best+[0]);};
					} forEach [0,1,2];
				};
			};
		};
	};
};
BRPVP_peterCityMove = {
	params ["_instigator","_unit"];
	if (alive _unit) then {
		_unit setVariable ["brpvp_no_dam",true];
		_unit setVariable ["brpvp_stop_times",-5];
		_unit moveTo ASLToAGL getPosASL _unit;
		private _abs = _unit getVariable "brpvp_ab_size";
		private _uPos = getPosASL _unit;
		[_uPos,_instigator,selectRandom [2,2,3],[500*_abs,1000*_abs,300],[4000*_abs,1000*_abs,[300,15000*_abs],_abs]] spawn BRPVP_peterSpawnAtomicBomb;
		uiSleep 3;
		ASLToAGL getPosASL _unit remoteExec ["BRPVP_larsSmallTeleportEffectPosAGL",BRPVP_allNoServer];
		[_unit,true] remoteExecCall ["hideObjectGlobal",2];

		//CHANGE CITY
		private _peterCities = _unit getVariable "brpvp_last_city";
		private _peterLeaving = _peterCities select (count _peterCities-1);
		BRPVP_peterCities deleteAt (BRPVP_peterCities find _peterLeaving);
		private _peterCity = [_peterCities,_peterLeaving] call BRPVP_peterSelectCity;
		[_peterCity,_unit] call BRPVP_peterOnCity;

		uiSleep 2;
		_unit remoteExec ["BRPVP_larsSmallTeleportEffect",BRPVP_allNoServer];
		_unit setVariable ["brpvp_stop_times",0];
		uiSleep 0.25;
		[_unit,false] remoteExecCall ["hideObjectGlobal",2];
		_unit setVariable ["brpvp_no_dam",false];
		uiSleep 4.75;
		private _sounder = "Land_HelipadEmpty_F" createVehicle (ASLToAGL _uPos vectorAdd [0,0,30]);
		[_sounder,["it_is_what_it_is",1500]] remoteExecCall ["say3D",BRPVP_allNoServer];
		uiSleep 4;
		deleteVehicle _sounder;
	};
};
BRPVP_peterCreateShield = {
	private _unit = _this;
	private _shield = createVehicle ["Sign_Sphere200cm_F",[0,0,0],[],0,"NONE"];
	_shield attachTo [_unit,[0,0.25,0.7]];
	[_unit,["lars_shield_on",1000]] remoteExecCall ["say3D",BRPVP_allNoServer];
	[_unit,diag_tickTime] spawn {
		params ["_unit","_init"];
		waitUntil {!alive _unit || isObjectHidden _unit || diag_tickTime-_init > 2};
		{
			if (typeOf _x isEqualTo "Sign_Sphere200cm_F") then {
				[_unit,["lars_shield_off",1000]] remoteExecCall ["say3D",BRPVP_allNoServer];
				detach _x;
				deleteVehicle _x;
			};
		} forEach attachedObjects _unit;
	};
};
BRPVP_peterSlowDownKriptos = {
	params ["_peter","_changeTime","_remain","_toSpeed",["_step",0.5]];
	private _init = diag_tickTime;
	private _mult = 8/_changeTime;
	private _initO = _peter getVariable "brpvp_speed_init";
	private _finalO = _peter getVariable "brpvp_speed_final";
	[_peter,["slow_down",1500,_mult]] remoteExecCall ["say3D",BRPVP_allNoServer];
	waitUntil {
		private _delta = (diag_tickTime-_init) min _changeTime;
		private _perc = _delta/_changeTime;
		private _dam = _peter getVariable "brpvp_peter_damage";
		_peter setVariable ["brpvp_speed_init",_initO-_perc*_initO*(1-_toSpeed)];
		_peter setVariable ["brpvp_speed_final",_finalO-_perc*_finalO*(1-_toSpeed)];
		[_peter,(_peter getVariable "brpvp_speed_init")+((_peter getVariable "brpvp_speed_final")-(_peter getVariable "brpvp_speed_init"))*_dam] remoteExecCall ["setAnimSpeedCoef",0];
		uiSleep _step;
		_perc isEqualTo 1 || !alive _peter
	};
	_init = diag_tickTime;
	waitUntil {diag_tickTime-_init >= _remain || !alive _peter};
	[_peter,["fast_up",1500,_mult]] remoteExecCall ["say3D",BRPVP_allNoServer];
	waitUntil {
		private _delta = (diag_tickTime-_init) min _changeTime;
		private _perc = _delta/_changeTime;
		private _dam = _peter getVariable "brpvp_peter_damage";
		_peter setVariable ["brpvp_speed_init",_initO-_initO*(1-_toSpeed)+_perc*_initO*(1-_toSpeed)];
		_peter setVariable ["brpvp_speed_final",_finalO-_finalO*(1-_toSpeed)+_perc*_finalO*(1-_toSpeed)];
		[_peter,(_peter getVariable "brpvp_speed_init")+((_peter getVariable "brpvp_speed_final")-(_peter getVariable "brpvp_speed_init"))*_dam] remoteExecCall ["setAnimSpeedCoef",0];
		uiSleep _step;
		_perc isEqualTo 1 || !alive _peter
	};
	_peter setVariable ["brpvp_peter_kripto",false,true];
};
BRPVP_peterLocoCode = {
	params ["_peter","_player","_dlt"];
	private _lDam = _peter getVariable "brpvp_loco_damage";
	_peter setVariable ["brpvp_loco_damage",_lDam-_dlt];
	if (_lDam-_dlt <= 0) then {
		_peter setVariable ["brpvp_loco_damage",selectRandom BRPVP_peterLocoDamage];
		[_peter,_player] spawn {
			params ["_peter","_player"];
			for "_i" from 1 to 10 do {
				private _okToLoco = alive _peter && !(_peter getVariable "brpvp_on_tele") && _peter getVariable "brpvp_was_hit" < BRPVP_peterHitToChangeCity;
				if (!_okToLoco) exitWith {};
				private _rndAngle = random 360;
				private _randVec = [15*sin _rndAngle,15*cos _rndAngle,0];
				[_peter,getPosWorld _peter vectorAdd _randVec,2.5+_i/4,_i isEqualTo 10] call BRPVP_peterTeleport;
				uiSleep random 0.1;
			};
		};
	};
};
BRPVP_peterHandleDamage = {
	params ["_unit","_selection","_damage","_source","_projectile","_hitIndex","_instigator","_hitPoint"];
	if (_instigator call BRPVP_isPlayer) then {
		private _lastShotTime = _unit getVariable "brpvp_lst";
		if (diag_tickTime-_lastShotTime > 0.02) then {
			_unit setVariable ["brpvp_no_head_hit",1];
			_unit setVariable ["brpvp_lst",diag_tickTime];
			_unit setVariable ["brpvp_wrong_player",_instigator];
		};
	};
	if (_selection isEqualTo "head") then {
		if (_projectile isEqualTo "" && (isNull _instigator || !isNull objectParent _instigator)) then {
			_unit getHit "head"
		} else {
			private _isBot = _instigator getVariable ["brpvp_lars",false] || _instigator getVariable ["brpvp_ai",false];
			private _exploPerc = getNumber (configFile >> "CfgAmmo" >> _projectile >> "explosive");
			private _oldDamHead = _unit getHit "head";
			private _delta = if (_isBot) then {(_damage-_oldDamHead)*(1-_exploPerc) min 3} else {(_damage-_oldDamHead)*(1-_exploPerc) min 20};
			private _noShield = {typeOf _x isEqualTo "Sign_Sphere200cm_F"} count attachedObjects _unit isEqualTo 0;
			if (_exploPerc >= 0.5 && _delta <= 5 && _noShield) then {_unit call BRPVP_peterCreateShield;};
			private _noDam = _unit getVariable ["brpvp_no_dam",false];
			private _minDam = [7.5,3] select _isBot;
			if (_delta > _minDam && !_noDam) then {
				if (_instigator call BRPVP_isPlayer) then {
					_unit setVariable ["brpvp_no_head_hit",2];
					_unit setVariable ["brpvp_wrong_player",objNull];
				};
				[_unit,[selectRandom ["lars_hit1","lars_hit2","lars_hit3","lars_hit4"],1000]] remoteExecCall ["say3D",BRPVP_allNoServer];

				private _finalDam = ((_unit getVariable "brpvp_peter_damage")+_delta/BRPVP_peterLife) min 1;
				private _gDam = 16*ceil (_finalDam*128/16);
				private _isDead = _finalDam isEqualTo 1;
				_unit setVariable ["brpvp_peter_damage",_finalDam];
				_unit setVariable ["brpvp_peter_gdam","peter_life_"+str _gDam+".paa",true];
				_unit setVariable ["brpvp_life_changed",true];
				[_unit,_instigator,_delta/BRPVP_peterLife] call BRPVP_peterLocoCode;

				private _nearBomb = (BRPVP_peterHitToChangeCity-(_finalDam mod BRPVP_peterHitToChangeCity))/BRPVP_peterHitToChangeCity <= 0.25;
				if (_nearBomb isNotEqualTo (_unit getVariable "brpvp_bomb_near")) then {_unit setVariable ["brpvp_bomb_near",_nearBomb,true];};

				private _oldHit = _unit getVariable "brpvp_was_hit";
				private _newHit = _oldHit+_delta/BRPVP_peterLife;
				_unit setVariable ["brpvp_was_hit",_newHit];

				if (_isDead) then {
					_unit setVariable ["brpvp_peter_killer",_instigator];
				} else {
					[_unit,(_unit getVariable "brpvp_speed_init")+((_unit getVariable "brpvp_speed_final")-(_unit getVariable "brpvp_speed_init"))*_finalDam] remoteExecCall ["setAnimSpeedCoef",0];
					if (_newHit >= BRPVP_peterHitToChangeCity) then {[_instigator,_unit] spawn BRPVP_peterCityMove;};
				};
				[_finalDam,1] select _isDead
			} else {
				if (_delta <= 5 && _delta >= 1 && !_noDam && _instigator call BRPVP_isPlayer) then {_unit setVariable ["brpvp_no_head_hit",3];};
				_oldDamHead
			};
		};
	} else {
		if (_hitPoint isEqualTo "hitchest") then {
			if (_projectile isEqualTo "" && (isNull _instigator || !isNull objectParent _instigator)) then {
				_unit getHitPointDamage "hitchest"
			} else {
				private _isBot = _instigator getVariable ["brpvp_lars",false] || _instigator getVariable ["brpvp_ai",false];
				private _exploPerc = getNumber (configFile >> "CfgAmmo" >> _projectile >> "explosive");
				private _oldDamChest = _unit getHitPointDamage "hitchest";
				private _deltaFull = (_damage-_oldDamChest)*(1-_exploPerc);
				private _delta = if (_isBot) then {_deltaFull min 2} else {_deltaFull min 3};
				private _noDam = _unit getVariable ["brpvp_no_dam",false];
				private _minDam = [7.5,5] select _isBot;
				if (_deltaFull > _minDam && !_noDam) then {
					[_unit,["peter_low_hurt",750,1.1+random 0.15]] remoteExecCall ["say3D",BRPVP_allNoServer];

					private _finalDam = ((_unit getVariable "brpvp_peter_damage")+_delta/BRPVP_peterLife) min 1;
					private _gDam = 16*ceil (_finalDam*128/16);
					private _isDead = _finalDam isEqualTo 1;
					_unit setVariable ["brpvp_peter_damage",_finalDam];
					_unit setVariable ["brpvp_peter_gdam","peter_life_"+str _gDam+".paa",true];
					_unit setVariable ["brpvp_life_changed",true];
					[_unit,_instigator,_delta/BRPVP_peterLife] call BRPVP_peterLocoCode;

					private _nearBomb = (BRPVP_peterHitToChangeCity-(_finalDam mod BRPVP_peterHitToChangeCity))/BRPVP_peterHitToChangeCity <= 0.25;
					if (_nearBomb isNotEqualTo (_unit getVariable "brpvp_bomb_near")) then {_unit setVariable ["brpvp_bomb_near",_nearBomb,true];};

					private _oldHit = _unit getVariable "brpvp_was_hit";
					private _newHit = _oldHit+_delta/BRPVP_peterLife;
					_unit setVariable ["brpvp_was_hit",_newHit];

					if (_isDead) then {
						_unit setVariable ["brpvp_peter_killer",_instigator];
					} else {
						[_unit,(_unit getVariable "brpvp_speed_init")+((_unit getVariable "brpvp_speed_final")-(_unit getVariable "brpvp_speed_init"))*_finalDam] remoteExecCall ["setAnimSpeedCoef",0];
						if (_newHit >= BRPVP_peterHitToChangeCity) then {[_instigator,_unit] spawn BRPVP_peterCityMove;};
					};
					[_finalDam,1] select _isDead
				} else {
					_oldDamChest
				};
			};
		} else {
			0
		};
	};
};
BRPVP_peterKilled = {
	private _peter = _this select 0;
	private _killer = _peter getVariable "brpvp_peter_killer";
	_peter setDamage 1;
	_peter removeAllEventHandlers "HandleDamage";
	_peter removeAllEventHandlers "Killed";
	_peter setVariable ["brpvp_no_dam",true];
	_peterCities = _peter getVariable "brpvp_last_city";
	_peterLastCity = _peterCities select (count _peterCities-1);
	BRPVP_peterCities deleteAt (BRPVP_peterCities find _peterLastCity);
	publicVariable "BRPVP_peterCities";
	private _abs = _peter getVariable "brpvp_ab_size";
	[getPosASL _peter,_killer,selectRandom [4,4,5],[500*_abs,1000*_abs,300],[4000*_abs,1000*_abs,[300,15000*_abs],_abs]] spawn BRPVP_peterSpawnAtomicBomb;
	_peter spawn {
		uiSleep 5;
		private _redKripto = _this getVariable ["brpvp_peter_kripto",false];
		private _mny = [BRPVP_peterReward,BRPVP_peterRewardRedKripto] select _redKripto;
		(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL _this vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (_mny*BRPVP_missionValueMult),true];
		uiSleep 5;
		private _sounder = "Land_HelipadEmpty_F" createVehicle (ASLToAGL getPosASL _this vectorAdd [0,0,30]);
		[_sounder,["it_is_what_it_is",1500]] remoteExecCall ["say3D",BRPVP_allNoServer];
		uiSleep 4;
		deleteVehicle _sounder;
	};
};
BRPVP_peterSelectCity = {
	params ["_exclude","_lastCity"];
	private _locaisImportantes = [];
	private _lastCityCenter = if (_lastCity isEqualTo -1) then {selectRandom BRPVP_locaisImportantes select 0} else {BRPVP_locaisImportantes select _lastCity select 0};
	{if !(_forEachIndex in (_exclude+BRPVP_zombieSuperSpawnCitiesIdx+BRPVP_radioCities)) then {_locaisImportantes pushBack (_x+[_forEachIndex]);};} forEach BRPVP_locaisImportantes;
	private _peterBeginCity = _locaisImportantes apply {[count ((_x select 0) nearEntities [BRPVP_playerModel,(_x select 1)+250+50]),(_x select 0) distance _lastCityCenter,_x]}; //,true]
	_peterBeginCity sort true;
	_peterBeginCity select 0 select 2
};
BRPVP_peterOnCity = {
	params ["_city","_peter"];
	_city params ["_center","_rad","_name","_codeId","_cityIdx"];
	_peter setVariable ["brpvp_last_city",(_peter getVariable "brpvp_last_city")+[_cityIdx]];
	_peter setVariable ["brpvp_center",_center];
	BRPVP_peterCities pushBack _cityIdx;
	[_peter,_name,+BRPVP_peterCities] spawn {
		params ["_peter","_name","_peterCities"];
		uiSleep (20+random 20);
		if (_peterCities isEqualTo BRPVP_peterCities) then {publicVariable "BRPVP_peterCities";};
	};
	private _pic = _center nearEntities [BRPVP_playerModel,2000];
	private _d = sqrt (random (_rad^2));
	private _a = random 360;
	private _spawnPos = _center vectorAdd [_d*sin _a,_d*cos _a,0];
	for "_i" from 1 to 200 do {
		private _d = sqrt (random (_rad^2));
		private _a = random 360;
		private _pos = _center vectorAdd [_d*sin _a,_d*cos _a,0];
		if (!surfaceIsWater _pos) then {
			_pos = _pos findEmptyPosition [0,150,"C_Hatchback_01_F"];
			if (_pos isNotEqualTo []) then {
				private _seeCount = {lineIntersectsSurfaces [getPosWorld _peter vectorAdd [0,0,2.5],getPosWorld _x vectorAdd [0,0,2.5],_peter,_x] isEqualTo [];} count _pic;
				if (_seeCount isEqualTo 0) then {
					_spawnPos = _pos;
					break
				};
			};
		};
	};
	_peter setPosASL AGLToASL _spawnPos;
	[_peter,["laser",400]] remoteExecCall ["say3D",BRPVP_allNoServer];

	private _pDamReal = _peter getVariable "brpvp_peter_damage";
	private _pDamStep = BRPVP_peterHitToChangeCity*round(_pDamReal/BRPVP_peterHitToChangeCity);
	_peter setVariable ["brpvp_peter_damage",_pDamStep+(_pDamReal-_pDamStep)/2];
	_peter setVariable ["brpvp_was_hit",(((_peter getVariable "brpvp_was_hit")-BRPVP_peterHitToChangeCity) max 0)/2];
	_peter setVariable ["brpvp_bomb_near",false,true];
};
BRPVP_peterToDieTele = {
	params ["_peter","_best"];
	_peter moveTo ASLToAGL getPosASL _peter;
	uiSleep 0.5;
	_peter remoteExecCall ["BRPVP_larsToDieTeleportEffect",BRPVP_allNoServer];
	[_peter,true] remoteExecCall ["hideObjectGlobal",2];
	[_peter,["peter_far_tele",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
	uiSleep 0.5;
	_peter setDir random 360;
	private _oPos = ASLToAGL getPosASL _peter;
	private _dist = _best distance _oPos;
	private _dlt = 5*((1/0.075)/diag_fps) min 12 max 5;
	private _max = ceil ((_dist/_dlt)/2);
	private _pFinal = ((((_oPos vectorMultiply (_max-_max)) vectorAdd (_best vectorMultiply _max)) vectorMultiply (1/_max)) vectorAdd [0,0,0.1]);
	for "_i" from 1 to _max do {
		_peter setPos ((((_oPos vectorMultiply (_max-_i)) vectorAdd (_best vectorMultiply _i)) vectorMultiply (1/_max)) vectorAdd [0,0,0.1]);
		uiSleep 0.15;
	};
	_peter moveTo _pFinal;
	_peter remoteExecCall ["BRPVP_larsToDieTeleportEffect",BRPVP_allNoServer];
	[_peter,false] remoteExecCall ["hideObjectGlobal",2];
	[_peter,["peter_far_tele",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
	uiSleep 0.25;
	_peter setVariable ["brpvp_on_tele",false];
};
BRPVP_peterLoopCode = {
	if (alive _peter && !(_peter getVariable "brpvp_on_tele")) then {
		private _tickTime = diag_tickTime;

		//SET NEW PETER BOMB SIZE
		if (_peter getVariable "brpvp_life_changed") then {
			private _pDam = _peter getVariable "brpvp_peter_damage";
			private _newABS = BRPVP_peterAtomicBombInit+(BRPVP_peterAtomicBombEnd-BRPVP_peterAtomicBombInit)*((_pDam-BRPVP_peterHitToChangeCity) max 0)/(1-BRPVP_peterHitToChangeCity);
			_peter setVariable ["brpvp_ab_size",_newABS,true];
			_peter setVariable ["brpvp_life_changed",false];
		};

		if (_tickTime-_init >= 1) then {
			_init = _tickTime;
			private _center = _peter getVariable "brpvp_center";

			//INFORM PLAYER TO SHOT THE HEAD
			private _hitInfo = _peter getVariable "brpvp_no_head_hit";
			private _shotTime = _peter getVariable "brpvp_lst";
			if (_hitInfo isEqualTo 3 || (_hitInfo isEqualTo 1 && _tickTime-_shotTime > 0.02)) then {
				private _var = format ["brpvp_last_info_time_%1",_hitInfo];
				private _p = _peter getVariable "brpvp_wrong_player";
				if (!isNull _p) then {
					private _lastInfoTime = _p getVariable [_var,-30];
					if (diag_tickTime-_lastInfoTime > 30) then {
						_p setVariable [_var,diag_tickTime];
						if (_hitInfo isEqualTo 1) then {
							[format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\head_shot_peter.paa'/><br /><t>%1",localize "str_lars_shot_head"+"</t>"],0,0,2.5,0,0,39214] remoteExecCall ["BRPVP_fnc_dynamicText",_p];
						} else {
							[format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\head_shot_weak_peter.paa'/><br /><t>%1",localize "str_lars_weak_shot"+"</t>"],0,0,2.5,0,0,39214] remoteExecCall ["BRPVP_fnc_dynamicText",_p];
						};
					};
					_peter setVariable ["brpvp_no_head_hit",0];
					_peter setVariable ["brpvp_wrong_player",objNull];
				};
			};

			//==================================
			//RUN TO A SAFE PLACE
			//==================================
			private _stopTimes = _peter getVariable "brpvp_stop_times";
			if (speed _peter isEqualTo 0) then {
				_peter setVariable ["brpvp_stop_times",_stopTimes+1];
			} else {
				if (_stopTimes > 0) then {
					_peter setVariable ["brpvp_stop_times",0];
				};
			};
			if (!(_peter getVariable "brpvp_on_tele") && _peter getVariable "brpvp_stop_times" >= 1) then {
				private _np = _center nearEntities [BRPVP_playerModel,500];
				private _runTo = [];
				private _peterPos = getPosWorld _peter;
				_peterPos set [2,0];

				//FIND BEST SAFE PLACE TO RUN
				if (_np isEqualTo []) then {
					for "_i1" from 1 to 10 do {
						private _a = random 360;
						private _d = sqrt (random (350^2));
						if (_d isEqualTo 0) then {_d = 125;};
						private _try = _center vectorAdd [_d*sin _a,_d*cos _a,0];
						if (!surfaceIsWater _try) exitWith  {_runTo = _try;};
					};
				} else {
					private _maxDist = 0;
					for "_i1" from 1 to 5 do {
						private _pos = [];
						private _posDist = 0;
						for "_i2" from 1 to 5 do {
							private _a = random 360;
							private _d = sqrt (random (350^2)) max 50;
							private _try = _center vectorAdd [_d*sin _a,_d*cos _a,0];
							if (!surfaceIsWater _try) exitWith  {
								_pos = _try;
								_posDist = _d;
							};
						};
						if (_pos isNotEqualTo []) then {
							private _peterPosASL = AGLToASL _peterPos;
							private _vec = AGLToASL _pos vectorDiff _peterPosASL;
							private _segNumber = (ceil (_posDist/25)) min 5;
							private _maxDistMultiLine = 0;
							for "_i2" from 1 to _segNumber do {
								private _posNow = _peterPosASL vectorAdd (_vec vectorMultiply (_i2/5));
								private _allPlayersDist = _np apply {_x distance2D _posNow};
								_allPlayersDist sort true;
								private _result = _allPlayersDist select 0;
								if (_result > _maxDistMultiLine) then {_maxDistMultiLine = _result;};
							};
							if (_maxDistMultiLine > _maxDist) then {
								_maxDist = _maxDistMultiLine;
								_runTo = _pos;
							};
						};
					};
				};

				//MOVE TO SAFE PLACE IF FOUND
				if (_runTo isNotEqualTo []) then {
					{
						private _best = [_runTo,_x*10,_x*10+25,5,0,0,0,[],[]] call BIS_fnc_findSafePos;
						if (_best isNotEqualTo []) exitWith {_peter moveTo (_best+[0]);};
					} forEach [0,1,2,3,4,5];
				};
			};
			//==================================
			//==================================

			//TELEPORT AWAY FROM PLAYERS
			if (_countA isEqualTo _loopA || moveToFailed _peter) then {
				_countA = 0;
				_loopA = selectRandom [35,40,45,50];

				private _sinceLastSmallTele = serverTime-(_peter getVariable "brpvp_teleport_time");
				if (_sinceLastSmallTele < 2.5) exitWith {_loopA = ceil (4-_sinceLastSmallTele);};

				private _onKripto = _peter getVariable ["brpvp_peter_kripto",false];
				if (_peter getVariable "brpvp_was_hit" < BRPVP_peterHitToChangeCity && !_onKripto) then {
					//VARS
					private _np = _peter nearEntities [BRPVP_playerModel,200];
					private _safe = [];
					private _teleDist = 55;
					private _angles = [0,45,90,135,180,225,270,315] call BIS_fnc_arrayShuffle;
					private _pPos = getPosWorld _peter;
					_pPos set [2,0];

					//FIND BEST SAFE PLACE TO TELEPORT
					if (_np isEqualTo []) then {
						{
							private _pos = _pPos vectorAdd [_teleDist*sin _x,_teleDist*cos _x,0];
							if (!surfaceIsWater _pos) exitWith {_safe = _pos;};
						} forEach _angles;
					} else {
						private _maxDist = 0;
						{
							private _pos = _pPos vectorAdd [_teleDist*sin _x,_teleDist*cos _x,0];
							if (!surfaceIsWater _pos) then {
								private _allPlayersDist = _np apply {_x distance2D _pos};
								_allPlayersDist sort true;
								private _result = _allPlayersDist select 0;
								if (_result > _maxDist) then {
									_maxDist = _result;
									_safe = _pos;
								};
							};
						} forEach _angles;
					};

					//TELEPORT IF SAFE PLACE FOUND
					if (_safe isNotEqualTo []) then {
						{
							private _best = [_safe,_x*10,_x*10+25,5,0,0,0,[],[]] call BIS_fnc_findSafePos;
							if (_best isNotEqualTo []) exitWith {
								_peter setVariable ["brpvp_on_tele",true];
								[_peter,_best] spawn BRPVP_peterToDieTele;
							};
						} forEach [0,1,2,3,4,5];
					};
				};
			};

			//5 SECONDS LOOP
			if (_countB isEqualTo _loopB) then {
				_countB = 0;
				if (unitPos _peter isNotEqualTo "Up") then {_peter setUnitPos "UP";};
			};
			_countA = _countA+1;
			_countB = _countB+1;
		};
	};
};
BRPVP_peterBrain = {
	private _peter = _this;
	private _loopA = selectRandom [35,40,45,50];
	private _loopB = 5;
	private _countA = 0;
	private _countB = 0;
	private _center = _peter getVariable "brpvp_center";
	private _target = objNull;
	private _init = diag_tickTime;
	private _initRF = diag_tickTime;

	//FIRST MOVE
	{
		private _best = [_center,_x*10,_x*10+25,5,0,0,0,[],[]] call BIS_fnc_findSafePos;
		if (_best isNotEqualTo []) exitWith {_peter moveTo (_best+[0]);};
	} forEach [0,1,2,3,4,5,6,7,8,9,10];

	waitUntil {
		call BRPVP_peterLoopCode;
		!alive _peter
	};
};
BRPVP_peterCreateMission = {
	private _peter = createAgent ["B_HeavyGunner_F",[0,0,0],[],100,"CAN_COLLIDE"];
	_peter setVariable ["brpvp_no_possession",true,true];
	_peter setVariable ["brpvp_peter_gdam","peter_life_0.paa",true];
	BRPVP_peterModel pushBack _peter;
	BRPVP_peterModel = BRPVP_peterModel-[objNull];
	publicVariable "BRPVP_peterModel";
	_peter setUnitLoadout "C_Man_Fisherman_01_F";
	_peter setVariable ["brpvp_peter",true,true];
	_peter setVariable ["brpvp_teleport_time",0,true];
	_peter setVariable ["brpvp_last_city",[]];
	_peter setVariable ["brpvp_was_hit",0];
	_peter setVariable ["brpvp_can_punch",false,true];
	_peter setVariable ["brpvp_side_tele",0];
	_peter setVariable ["brpvp_on_tele",false];
	_peter setVariable ["brpvp_ss_immune_mult",0,true];
	_peter setVariable ["brpvp_lst",0];
	_peter setVariable ["brpvp_no_head_hit",0];
	_peter setVariable ["brpvp_wrong_player",objNull];
	_peter setVariable ["brpvp_stop_times",0];
	_peter setVariable ["brpvp_speed_init",BRPVP_peterSpeedInit];
	_peter setVariable ["brpvp_speed_final",BRPVP_peterSpeedFinal];
	_peter setVariable ["brpvp_peter_damage",0];
	_peter setVariable ["brpvp_ab_size",BRPVP_peterAtomicBombInit,true];
	_peter setVariable ["brpvp_life_changed",false];
	_peter setVariable ["brpvp_bomb_near",false,true];
	_peter setVariable ["brpvp_loco_damage",selectRandom BRPVP_peterLocoDamage];	
	_peter addEventHandler ["HandleDamage",{call BRPVP_peterHandleDamage;}];
	_peter addEventHandler ["Killed",{call BRPVP_peterKilled;}];

	_peter setCombatMode "BLUE";
	_peter setBehaviour "CARELESS";
	_peter disableAI "ALL";
	_peter enableAI "MOVE";
	_peter enableAI "ANIM";
	_peter enableAI "TEAMSWITCH";
	_peter enableAI "PATH";
	_peter setUnitPos "UP";
	_peter addRating -10000;
	[_peter,BRPVP_peterSpeedInit] remoteExecCall ["setAnimSpeedCoef",0];

	_peterCity = [[],-1] call BRPVP_peterSelectCity;
	[_peterCity,_peter] call BRPVP_peterOnCity;
	_peter spawn BRPVP_peterBrain;
};