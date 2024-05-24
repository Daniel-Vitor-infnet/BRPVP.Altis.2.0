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

BRPVP_larsSpreadInitTime = 0;
BRPVP_larsLastReloadTime = 0;
BRPVP_larsLastShot = 0;
BRPVP_larsTeleport = {
	params ["_lars","_player"];
	private _noDam = _lars getVariable ["brpvp_no_dam",false];
	if (!_noDam) then {
		private _larsVel = velocity _lars;
		private _larsVelOk = vectorMagnitude _larsVel > 0.125;
		private _pwl = getPosWorld _lars vectorAdd [0,0,0.5];
		private _vec1 = _pwl vectorDiff (getPosWorld _player vectorAdd [0,0,0.5]);
		private _vec2 = surfaceNormal _pwl;
		private _vec3A = _vec1 vectorCrossProduct _vec2;
		private _vec3B = _vec2 vectorCrossProduct _vec1;
		_vec3A = (vectorNormalized _vec3A) vectorMultiply 5;
		_vec3B = (vectorNormalized _vec3B) vectorMultiply 5;
		private _lis3A = lineIntersectsSurfaces [_pwl,_pwl vectorAdd _vec3A,_lars,objNull];
		private _lis3B = lineIntersectsSurfaces [_pwl,_pwl vectorAdd _vec3B,_lars,objNull];
		private _sides = [];
		if (_lis3A isEqualTo []) then {_sides pushBack [_vec3A,0];};
		if (_lis3B isEqualTo []) then {_sides pushBack [_vec3B,1];};
		if (_sides isNotEqualTo []) then {
			private _side = if (count _sides isEqualTo 2) then {
				if (_larsVelOk) then {
					private _angleA = aCos (_vec3A vectorCos _larsVel);
					private _angleB = aCos (_vec3B vectorCos _larsVel);
					if (_angleA < 70) then {
						_lars setVariable ["brpvp_side_tele",1];
						_vec3A
					} else {
						if (_angleB < 70) then {
							_lars setVariable ["brpvp_side_tele",0];
							_vec3B
						} else {
							private _pref = _lars getVariable "brpvp_side_tele";
							_lars setVariable ["brpvp_side_tele",1-_pref];
							_sides select _pref select 0
						};
					};
				} else {
					private _pref = _lars getVariable "brpvp_side_tele";
					_lars setVariable ["brpvp_side_tele",1-_pref];
					_sides select _pref select 0
				};
			} else {
				_lars setVariable ["brpvp_side_tele",1-(_sides select 0 select 1)];
				_sides select 0 select 0
			};
			_lars setPosWorld (_pwl vectorAdd _side vectorAdd [0,0,-0.5]);
			_lars remoteExec ["BRPVP_larsSmallTeleportEffect",BRPVP_allNoServer];
			[_lars,["laser",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
		};
	};
};
BRPVP_larsFiredMan = {
	_unit = _this select 0;
	_weapon = _this select 1; 
	_muzzle = _this select 2; 
	private _tickTime = diag_tickTime;
	if (BRPVP_larsSpreadInitTime isEqualTo 0) then {
		BRPVP_larsSpreadInitTime = _tickTime;
	} else {
		if (_tickTime-BRPVP_larsLastShot > 3) then {BRPVP_larsSpreadInitTime = _tickTime;};
	};
	if (_tickTime-BRPVP_larsSpreadInitTime > BRPVP_larsAmmoTimeLimit) then {
		BRPVP_larsSpreadInitTime = 0;
		_unit setAmmo [_weapon,0];
		_unit addMagazine "150Rnd_762x54_Box";
		BRPVP_larsLastReloadTime = _tickTime;
		if (random 1 < BRPVP_larsNoMoveOnReloadChance) then {
			_unit disableAI "PATH";
			_unit spawn {
				uiSleep BRPVP_larsNoMoveOnReloadTime;
				_this enableAI "PATH";
			};
		};
	} else {
		_unit setAmmo [_weapon,(_unit ammo _weapon)+1];
		_unit setWeaponReloadingTime [_unit,_muzzle,0];
	};
	BRPVP_larsLastShot = _tickTime;
};
BRPVP_larsJumpOnShot = {
	params ["_instigator","_unit"];
	private _ts = 2+random 2;
	private _init = diag_tickTime;
	waitUntil {diag_tickTime-_init > _ts || _unit getVariable "brpvp_was_hit" >= BRPVP_larsHitToChangeCity};
	if (alive _unit) then {
		_unit setVariable ["brpvp_no_dam",true];
		_unit disableAI "MOVE";
		_unit setUnitPos "MIDDLE";
		private _ts = 0.5;
		private _init = diag_tickTime;
		waitUntil {diag_tickTime-_init > _ts || _unit getVariable "brpvp_was_hit" >= BRPVP_larsHitToChangeCity};
		private _center = _unit getVariable "brpvp_center";
		private _vec = vectorNormalized ((AGLToASL _center) vectorDiff (getPosWorld _unit)) vectorMultiply 30;
		_vec set [2,0];
		if (surfaceIsWater ([_unit,80,[[0,0,0],_vec] call BIS_fnc_dirTo] call BIS_fnc_relPos)) then {_vec = _vec vectorMultiply -0.5;};
		private _lis = lineIntersectsSurfaces [getPosWorld _unit vectorAdd [0,0,0.5],getPosWorld _unit vectorAdd [0,0,25],_unit,objNull,true,-1,"GEOM","NONE",true];
		private _lisObjs = _lis apply {if ((_x select 2) isKindOf "Building") then {_x select 2} else {objNull};};
		_lisObjs = _lisObjs-[objNull];
		{
			_x hideObject true;
			if (!(_x getVariable ["brpvp_no_lars",false]) && (_x getVariable ["id_bd",-1]) isEqualTo -1) then {_x setDamage 1};
		} forEach _lisObjs;
		if (_unit getVariable "brpvp_was_hit" >= BRPVP_larsHitToChangeCity) then {_unit setVelocity [0,0,35];} else {_unit setVelocity [0,0,30];};
		waitUntil {(velocity _unit select 2) < 0};
		{_x hideObject false;} forEach _lisObjs;
		[_unit,[selectRandom ["lars_hit1","lars_hit2","lars_hit3","lars_hit4"],1000]] remoteExecCall ["say3D",BRPVP_allNoServer];
		[_unit,["laser",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
		_unit setDir ([[0,0,0],_vec] call BIS_fnc_dirTo);
		_unit setVelocity _vec;
		private _init = time;
		waitUntil {getPos _unit select 2 < 0.25 || time-_init > 10};
		_unit setVariable ["brpvp_no_dam",false];
		_unit enableAI "MOVE";
		_unit setUnitPos "AUTO";
		_unit setVariable ["brpvp_jump_set",false];
	};
};
BRPVP_larsCreateShield = {
	private _lars = _this;
	private _shield = createVehicle ["Sign_Sphere200cm_F",[0,0,0],[],0,"NONE"];
	_shield attachTo [_lars,[0,0.25,0.7]];
	[_lars,["lars_shield_on",1000]] remoteExecCall ["say3D",BRPVP_allNoServer];
	_lars spawn {
		private _lars = _this;
		private _init = diag_tickTime;
		waitUntil {diag_tickTime-_init > 2 || !alive _lars || isObjectHidden _lars};
		{
			if (typeOf _x isEqualTo "Sign_Sphere200cm_F") then {
				[_lars,["lars_shield_off",1000]] remoteExecCall ["say3D",BRPVP_allNoServer];
				detach _x;
				deleteVehicle _x;
			};
		} forEach attachedObjects _lars;
	};
};
BRPVP_larsHandleDamage = {
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
			private _exploPerc = getNumber (configFile >> "CfgAmmo" >> _projectile >> "explosive");
			private _oldDam = _unit getHit "head";
			private _delta = (_damage-_oldDam)*(1-_exploPerc) min 15;
			private _noDam = _unit getVariable ["brpvp_no_dam",false];
			private _noShield = {typeOf _x isEqualTo "Sign_Sphere200cm_F"} count attachedObjects _unit isEqualTo 0;
			if (_exploPerc >= 0.5 && _delta <= 5 && _noShield) then {_unit call BRPVP_larsCreateShield;};
			if (_delta > 5 && !_noDam) then {
				if (_instigator call BRPVP_isPlayer) then {
					_unit setVariable ["brpvp_no_head_hit",2];
					_unit setVariable ["brpvp_wrong_player",objNull];
				};
				[_unit,[selectRandom ["lars_hit1","lars_hit2","lars_hit3","lars_hit4"],1000]] remoteExecCall ["say3D",BRPVP_allNoServer];
				private _larsJumpSet = _unit getVariable "brpvp_jump_set";
				if (!_larsJumpSet) then {
					_unit setVariable ["brpvp_jump_set",true];
					[_instigator,_unit] spawn BRPVP_larsJumpOnShot;
				};
				private _finalDam = _oldDam+_delta/BRPVP_larsLife;
				private _isDead = _finalDam > 0.975;
				private _oldHit = _unit getVariable "brpvp_was_hit";
				private _newHit = _oldHit+_delta/BRPVP_larsLife;
				_unit setVariable ["brpvp_was_hit",_newHit];
				if (_oldHit < BRPVP_larsHitToChangeCity && _newHit >= BRPVP_larsHitToChangeCity && !_isDead) then {
					private _psm = (allPlayers apply {if (_x distance2D _unit < 3500) then {_x} else {-1};})-[-1];
					[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\reporter.paa'/><br />%1",localize "str_lars_scape"],0,0,2.5,0,0,13214] remoteExecCall ["BRPVP_fnc_dynamicText",_psm];
					"news" remoteExecCall ["playSound",_psm];
				};
				_unit setVariable ["brpvp_lars_gdam","lars_life_"+str (16*ceil(_finalDam*128/16))+".paa",true];
				[_finalDam,1] select _isDead
			} else {
				if (_delta <= 5 && _delta >= 1 && !_noDam && _instigator call BRPVP_isPlayer) then {_unit setVariable ["brpvp_no_head_hit",3];};
				_oldDam
			};
		};
	} else {
		0
	};
};
BRPVP_larsKilled = {
	private _lars = _this select 0;
	_lars removeAllEventHandlers "HandleDamage";
	_lars removeAllEventHandlers "FiredMan";
	_lars removeAllEventHandlers "Killed";
	_lars setVariable ["brpvp_no_dam",true];
	_larsCities = _lars getVariable "brpvp_last_city";
	_larsLastCity = _larsCities select (count _larsCities-1);
	BRPVP_larsCities deleteAt (BRPVP_larsCities find _larsLastCity);
	publicVariable "BRPVP_larsCities";

	//LAZARUS EXPLOSION
	_lars spawn {
		private _lars = _this;
		private _redKripto = _lars getVariable ["brpvp_lars_red_kripto_kill",false];
		private _lp = (ASLToATL getPosASL _lars) vectorAdd [0,0,3.5];
		for "_i" from 1 to 3 do {
			private _dist = random 8;
			private _a = random 360;
			private _pos = [(_lp select 0)+_dist*sin _a,(_lp select 1)+_dist*cos _a,_lp select 2];
			createVehicle ["HelicopterExploBig",_pos,[],0,"CAN_COLLIDE"];
			uiSleep 0.15;
		};
		uiSleep 3;
		private _mny = [BRPVP_larsReward,BRPVP_larsRewardRedKripto] select _redKripto;
		(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL _lars vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (_mny*BRPVP_missionValueMult),true];
	};
	"lars_dead" remoteExecCall ["playSound",BRPVP_allNoServer];
	[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\reporter.paa'/><br />%1",localize "str_lars_is_dead"],0,0,2.5,0,0,13214] remoteExecCall ["BRPVP_fnc_dynamicText",BRPVP_allNoServer];

	private _emitter = "#particlesource" createVehicle (getPos _lars);
	_emitter setParticleClass "MediumSmoke";
	_emitter setParticleFire [0.3,1.0,0.1];
	_emitter attachTo [_lars,[0,0,0]];
	_emitter = "#particlesource" createVehicle (getPos _lars);
	_emitter setParticleClass "MediumSmoke";
	_emitter setParticleFire [0.3,1.0,0.1];
	_emitter attachTo [_lars,[0,0,0]];
};
BRPVP_larsSelectCity = {
	params ["_exclude","_lastCity"];
	private _locaisImportantes = [];
	private _lastCityCenter = if (_lastCity isEqualTo -1) then {selectRandom BRPVP_locaisImportantes select 0} else {BRPVP_locaisImportantes select _lastCity select 0};
	{if !(_forEachIndex in (_exclude+BRPVP_zombieSuperSpawnCitiesIdx+BRPVP_radioCities)) then {_locaisImportantes pushBack (_x+[_forEachIndex]);};} forEach BRPVP_locaisImportantes;
	private _larsBeginCity = _locaisImportantes apply {[count ((_x select 0) nearEntities [BRPVP_playerModel,(_x select 1)+250+50]),(_x select 0) distance _lastCityCenter,_x]}; //,true]
	_larsBeginCity sort true;
	_larsBeginCity select 0 select 2
};
BRPVP_larsOnCity = {
	params ["_city","_lars"];
	_city params ["_center","_rad","_name","_codeId","_cityIdx"];
	_lars setVariable ["brpvp_last_city",(_lars getVariable "brpvp_last_city")+[_cityIdx]];
	_lars setVariable ["brpvp_center",_center];
	BRPVP_larsCities pushBack _cityIdx;
	[_lars,_name,+BRPVP_larsCities] spawn {
		params ["_lars","_name","_larsCities"];
		uiSleep (20+random 20);
		if (_larsCities isEqualTo BRPVP_larsCities) then {
			publicVariable "BRPVP_larsCities";
			private _psm = (allPlayers apply {if (_x distance2D _lars < 3500) then {_x} else {-1};})-[-1];
			[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\reporter.paa'/><br />%1",format [localize "str_lars_found_in_city",_name]],0,0,2.5,0,0,13214] remoteExecCall ["BRPVP_fnc_dynamicText",_psm];
			"news" remoteExecCall ["playSound",_psm];
		};
	};
	private _wPosAll = [];
	private _hr = _rad/2;
	for "_i" from 1 to 200 do {
		private _pos = _center vectorAdd [-_hr+random _rad,-_hr+random _rad,0];
		if (!surfaceIsWater _pos) then {_wPosAll pushBack _pos;};
		if (count _wPosAll isEqualTo 4) exitWith {};
	};
	if (count _wPosAll < 2) then {for "_i" from 1 to 4 do {_wPosAll pushBack (_center vectorAdd [-_hr+random _rad,-_hr+random _rad,0]);};};
	private ["_posInit"];
	private _pic = _center nearEntities [BRPVP_playerModel,2000];
	private _spawnPos = _center vectorAdd [-_hr+random _rad,-_hr+random _rad,0];
	for "_i" from 1 to 200 do {
		private _pos = _center vectorAdd [-_hr+random _rad,-_hr+random _rad,0];
		if (!surfaceIsWater _pos) then {
			_pos = _pos findEmptyPosition [0,150,"C_Hatchback_01_F"];
			if (_pos isNotEqualTo []) then {
				private _seeCount = {lineIntersectsSurfaces [getPosWorld _lars vectorAdd [0,0,2.5],getPosWorld _x vectorAdd [0,0,2.5],_lars,_x] isEqualTo [];} count _pic;
				if (_seeCount isEqualTo 0) then {
					_spawnPos = _pos;
					break
				};
			};
		};
	};
	ASLToAGL getPosASL _lars remoteExec ["BRPVP_larsSmallTeleportEffectPosAGL",BRPVP_allNoServer];
	_lars setPosASL AGLToASL _spawnPos;
	_lars remoteExec ["BRPVP_larsSmallTeleportEffect",BRPVP_allNoServer];
	[_lars,["laser",400]] remoteExecCall ["say3D",BRPVP_allNoServer];
	_lars setVariable ["brpvp_was_hit",0];
	{
		private _pos = _x findEmptyPosition [0,125,BRPVP_playerModel]; 
		_pos = if (_pos isEqualTo []) then {_x} else {_pos};
		if (_forEachIndex isEqualTo 0) then {_posInit = _pos;};
		private _wp = group _lars addWayPoint [_pos,0];
		_wp setWaypointCompletionRadius 15;
		_wp setWayPointType "MOVE";
	} forEach _wPosAll;
	private _wp = group _lars addWayPoint [_posInit,0];
	_wp setWaypointCompletionRadius 15;
	_wp setWayPointType "CYCLE";
};
BRPVP_larsToDieTele = {
	params ["_lars","_toDie","_best","_target"];
	_lars disableAI "PATH";
	uiSleep 0.5;
	_lars remoteExecCall ["BRPVP_larsToDieTeleportEffect",BRPVP_allNoServer];
	[_lars,true] remoteExecCall ["hideObjectGlobal",2];
	[_lars,["peter_far_tele",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
	uiSleep 0.5;
	_lars setDir random 360;
	private _oPos = ASLToAGL getPosASL _lars;
	private _dist = _best distance _oPos;
	private _dlt = 5*((1/0.075)/diag_fps) min 12 max 5;
	private _max = ceil ((_dist/_dlt)/2);
	for "_i" from 1 to _max do {
		_lars setPos ((((_oPos vectorMultiply (_max-_i)) vectorAdd (_best vectorMultiply _i)) vectorMultiply (1/_max)) vectorAdd [0,0,0.1]);
		uiSleep 0.15;
	};
	_lars remoteExecCall ["BRPVP_larsToDieTeleportEffect",BRPVP_allNoServer];
	[_lars,false] remoteExecCall ["hideObjectGlobal",2];
	[_lars,["peter_far_tele",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
	_lars reveal [_toDie,4];
	uiSleep 0.25;
	_lars enableAI "PATH";
	_lars setVariable ["brpvp_on_tele",false];
	if (_target getVariable ["brpvp_peter",false]) then {_lars doMove ASLToAGL getPosASL _target;};
};
BRPVP_larsLoopCode = {
	if (alive _lars && !(_lars getVariable "brpvp_on_tele")) then {
		private _center = _lars getVariable "brpvp_center";
		private _tickTime = diag_tickTime;
		if (!isNull _target && _tickTime-_initRF >= _lars getVariable "brpvp_fire_rate" && _tickTime-BRPVP_larsLastReloadTime > 10) then {
			_initRF = _tickTime;
			private _veh = objectParent _target;
			if (isNull _veh) then {
				private _vec1 = _lars weaponDirection currentWeapon _lars;
				private _vec2 = (eyePos _target) vectorDiff (eyePos _lars);
				private _a = acos (_vec1 vectorCos _vec2);
				private _dist = _target distance _lars;
				private _pin = 2*pi*_dist*(_a/360);
				if (_pin < 5) then {_lars forceWeaponFire ["LMG_Zafir_F","fullAuto"];};
			} else {
				private _vec1 = _lars weaponDirection currentWeapon _lars;
				private _vec2 = (getPosWorld _veh) vectorDiff (eyePos _lars);
				private _a = acos (_vec1 vectorCos _vec2);
				private _dist = _target distance _lars;
				private _pin = 2*pi*_dist*(_a/360);
				if (_pin < 10) then {_lars forceWeaponFire ["LMG_Zafir_F","fullAuto"];};
			};
		};
		if (_tickTime-_init >= 1) then {
			_init = _tickTime;
			if (unitPos _lars isNotEqualTo "Up") then {_lars setUnitPos "UP";};

			//INFORM PLAYER TO SHOT THE HEAD
			private _hitInfo = _lars getVariable "brpvp_no_head_hit";
			private _shotTime = _lars getVariable "brpvp_lst";
			if (_hitInfo isEqualTo 3 || (_hitInfo isEqualTo 1 && _tickTime-_shotTime > 0.02)) then {
				private _var = format ["brpvp_last_info_time_%1",_hitInfo];
				private _p = _lars getVariable "brpvp_wrong_player";
				if (!isNull _p) then {
					private _lastInfoTime = _p getVariable [_var,-30];
					if (diag_tickTime-_lastInfoTime > 30) then {
						_p setVariable [_var,diag_tickTime];
						if (_hitInfo isEqualTo 1) then {
							[format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\head_shot.paa'/><br /><t>%1",localize "str_lars_shot_head"+"</t>"],0,0,2.5,0,0,39214] remoteExecCall ["BRPVP_fnc_dynamicText",_p];
						} else {
							[format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\head_shot_weak.paa'/><br /><t>%1",localize "str_lars_weak_shot"+"</t>"],0,0,2.5,0,0,39214] remoteExecCall ["BRPVP_fnc_dynamicText",_p];
						};
					};
					_lars setVariable ["brpvp_no_head_hit",0];
					_lars setVariable ["brpvp_wrong_player",objNull];
				};
			};

			//NEAR PLAYERS FOR DEATH ATTACK
			if (_countA isEqualTo _loopA) then {
				_countA = 0;
				_loopA = selectRandom [35,40,45,50];

				if (_lars getVariable "brpvp_was_hit" < BRPVP_larsHitToChangeCity) then {
					private _np = BRPVP_peterModel select {alive _x && !isObjectHidden _x && _x distance _lars < 500};
					if (_np isEqualTo []) then {					
						_np = _lars nearEntities [BRPVP_playerModel,200];
						_np = _np select {!isObjectHidden _x && getPos _x select 2 < 0.25 && lineIntersectsSurfaces [getPosWorld _lars vectorAdd [0,0,2],getPosWorld _x vectorAdd [0,0,2],_lars,_x] isNotEqualTo []};
					};
					if (count _np > 0) then {
						private _toDie = _np select 0;
						private _found = false;
						private _bestAll = [];
						for "_i1" from 1 to 2 do {
							for "_i2" from 1 to 5 do {
								private _best = [_toDie,_i1*10,10+_i1*10,5,0,0,0,[],[]] call BIS_fnc_findSafePos;
								if (_best isEqualTo []) then {
									break;
								} else {
									_best pushBack 0;
									_bestAll pushBack _best;
									private _bASL = AGLToASL _best;
									if (lineIntersectsSurfaces [_bASL vectorAdd [0,0,2],eyePos _toDie,_lars,_toDie] isNotEqualTo []) then {
										_found = true;
										_lars setVariable ["brpvp_on_tele",true];
										[_lars,_toDie,_best,_target] spawn BRPVP_larsToDieTele;
										break;
									};
								};
							};
							if (_found) then {break;};
						};
						if (!_found && count _bestAll > 0) then {
							_lars setVariable ["brpvp_on_tele",true];
							[_lars,_toDie,selectRandom _bestAll,_target] spawn BRPVP_larsToDieTele;
						};
					};
				};

				if (currentWeapon _lars isEqualTo "") then {_lars setUnitLoadout [["LMG_Zafir_F","","","",["150Rnd_762x54_Box",150],[],""],[],[],["U_C_E_LooterJacket_01_F",[]],[],["B_AssaultPack_blk",[["150Rnd_762x54_Box",1,150]]],"H_HeadBandage_bloody_F","",[],["","","","ItemCompass","ItemWatch",""]];};
			};
			if (_countB isEqualTo _loopB) then {
				_countB = 0;
				if !(_lars getVariable "brpvp_on_tele") then {
					//SET TARGET
					if (isNull _target || _target distance _lars > 500 || _target distance _center > 500 || random 1 < 0.1) then {
						private _pl = (BRPVP_peterModel select {alive _x}) apply {[_x distance _lars,isObjectHidden _x,_x]};
						_pl = _pl select {_x select 0 < 500 && !(_x select 1)};
						if (_pl isEqualTo []) then {
							_pl = call BRPVP_playersList apply {[_x distance _lars,isObjectHidden _x,_x]};
							_pl = _pl select {_x select 0 < 500 && (_x select 2) distance _center < 500 && !(_x select 1)};
						};
						if (_pl isEqualTo []) then {
							_target = objNull;
						} else {
							_pl sort true;
							_target = _pl select 0 select 2;
							_lars doTarget vehicle _target;
							_lars doWatch vehicle _target;
							_lars reveal [vehicle _target,4];
							_lars setVariable ["brpvp_fire_rate",[2/30,1.25/30] select (_target getVariable ["brpvp_peter",false])];
						};
					};

					//CHANGE CITY
					if (_lars getVariable "brpvp_was_hit" >= BRPVP_larsHitToChangeCity) then {
						private _pic = _center nearEntities [BRPVP_playerModel,2000];
						private _seeCount = {!isObjectHidden _x && lineIntersectsSurfaces [getPosWorld _lars vectorAdd [0,0,2.5],getPosWorld _x vectorAdd [0,0,2.5],_lars,_x] isEqualTo []} count _pic;
						if (_seeCount isEqualTo 0) then {
							private _larsCities = _lars getVariable "brpvp_last_city";
							private _larsLeaving = _larsCities select (count _larsCities-1);
							BRPVP_larsCities deleteAt (BRPVP_larsCities find _larsLeaving);
							private _larsCity = [_larsCities,_larsLeaving] call BRPVP_larsSelectCity;
							[_larsCity,_lars] call BRPVP_larsOnCity;
						};
					};
				};
			};
			if (_countC isEqualTo _loopC) then {
				_countC = 0;

				if (isNull _target) then {
					_loopC = 5;
				} else {
					_loopC = 5;
					private _runTo = ASLToaGL getPosASL _target;
					{
						private _best = [_runTo,_x*10,_x*10+25,5,0,0,0,[],[]] call BIS_fnc_findSafePos;
						if (_best isNotEqualTo []) exitWith {
							private _best3D = _best+[0];
							private _dist = _best3D distance _lars;
							private _timeToGo = round(_dist/5) max 5 min 10;
							_lars doMove _best3D;
							_loopC = _timeToGo;
						};
					} forEach [2,3,4,5,6];
				};
			};

			_countA = _countA+1;
			_countB = _countB+1;
			_countC = _countC+1;
		};
	};
};
BRPVP_larsBrain = {
	private _lars = _this;
	private _loopA = selectRandom [35,40,45,50];
	private _loopB = 5;
	private _loopC = 5;
	private _countA = 0;
	private _countB = 0;
	private _countC = 0;
	private _center = _lars getVariable "brpvp_center";
	private _target = objNull;
	private _init = diag_tickTime;
	private _initRF = diag_tickTime;
	waitUntil {
		call BRPVP_larsLoopCode;
		!alive _lars
	};
};
BRPVP_larsCreateMission = {
	private _grp = createGroup [BLUFOR,true];
	private _lars = _grp createUnit ["B_HeavyGunner_F",[0,0,0],[],100,"CAN_COLLIDE"];
	[_lars] joinSilent _grp;
	_lars setVariable ["brpvp_no_possession",true,true];
	_lars setVariable ["brpvp_lars_gdam","lars_life_0.paa",true];
	BRPVP_larsModel pushBack _lars;
	BRPVP_larsModel = BRPVP_larsModel-[objNull];
	publicVariable "BRPVP_larsModel";
	_lars setUnitLoadout [["LMG_Zafir_F","","","",["150Rnd_762x54_Box",150],[],""],[],[],["U_C_E_LooterJacket_01_F",[]],[],["B_AssaultPack_blk",[["150Rnd_762x54_Box",1,150]]],"H_HeadBandage_bloody_F","",[],["","","","ItemCompass","ItemWatch",""]];

	_lars setVariable ["brpvp_lars",true,true];
	_lars setVariable ["brpvp_teleport_time",0,true];
	_lars setVariable ["brpvp_jump_set",false];
	_lars setVariable ["brpvp_last_city",[]];
	_lars setVariable ["brpvp_was_hit",0];
	_lars setVariable ["brpvp_can_punch",false,true];
	_lars setVariable ["brpvp_side_tele",0];
	_lars setVariable ["brpvp_on_tele",false];
	_lars setVariable ["brpvp_ss_immune_mult",0,true];
	_lars setVariable ["brpvp_lst",0];
	_lars setVariable ["brpvp_no_head_hit",0];
	_lars setVariable ["brpvp_wrong_player",objNull];
	_lars setVariable ["brpvp_fire_rate",2/30];

	_lars addEventHandler ["FiredMan",{call BRPVP_larsFiredMan;}];
	_lars addEventHandler ["HandleDamage",{call BRPVP_larsHandleDamage;}];
	_lars addEventHandler ["Killed",{call BRPVP_larsKilled;}];

	_lars allowFleeing 0;
	_lars setSkill 1;
	_lars setUnitPos "UP";

	_larsCity = [[],-1] call BRPVP_larsSelectCity;
	[_larsCity,_lars] call BRPVP_larsOnCity;
	_lars spawn BRPVP_larsBrain;
};