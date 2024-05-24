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

//TURRETS FUNCTIONS
BRPVP_autoDefenseTurretList = [];
BRPVP_totalTurretGroups = 0;
BRPVP_turretCycleTime = 2;
BRPVP_autoTurretDied = [];
BRPVP_tehGetOutMan = {
	_operator = _this select 0;
	_turret = _this select 2;
	BRPVP_autoDefenseTurretList deleteAt (BRPVP_autoDefenseTurretList find _operator);
	_bomb = createVehicle ["B_20mm",_operator modelToWorld [0,0,0],[],0,"CAN_COLLIDE"];
	_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
	_bomb setVelocity [0,0,-1000];
	_operator removeAllEventHandlers "HandleDamage";
	_operator removeAllEventHandlers "GetOutMan";
	deleteVehicle _operator;
	_turret spawn {
		waitUntil {vectorMagnitude velocity _this < 0.25};
		sleep 5;
		if (crew _this isEqualTo []) then {[_this,false] remoteExecCall ["enableSimulationGlobal",2];};
	};
};
BRPVP_tehFired = {
	_turret = _this select 0;
	_operator = _turret getVariable "brpvp_operator";
	_level = _turret getVariable ["brpvp_tlevel",1];
	if (!isNull _operator) then {
		_turretShots = (_turret getVariable "brpvp_shots")+1;
		_turret setVariable ["brpvp_shots",_turretShots];
		_isRocket = typeOf _turret in BRPVP_autoTurretTypesTitan;
		if (_isRocket) then {
			if (_level isEqualTo 1) then {
				if (_turretShots >= 4) then {
					_turret setVariable ["brpvp_shots",0];
					_turret setVehicleAmmoDef 1;
				};
			} else {
				if (_turretShots >= 1) then {
					_turret setVariable ["brpvp_shots",0];
					_turret setVehicleAmmoDef 0.25;
				};
			};
		} else {
			if (_turretShots >= 90) then {
				_turret setVariable ["brpvp_shots",0];
				_turret setVehicleAmmoDef 1;
			};
		};
	};
};
BRPVP_tehHandleDamage = {
	_operator = _this select 0;
	if !(_operator getVariable "brpvp_dead") then {
		_attacker = _this select 6;
		if (_attacker call BRPVP_isPlayer) then {
			_simulationOn = simulationEnabled _operator;
			//SET DAMAGE ON TURRET
			if (_simulationOn) then {
				private _part = _this select 1;
				private _hitPoint = _this select 7;

				//CHECK IF CONTROLED AI TO SET UNCAPTIVE
				if (_hitPoint isEqualTo "hithead" || _part isEqualTo "") then {
					private _source = _this select 3;
					private _calcOfensor = if (isNull _attacker) then {effectiveCommander _source} else {_attacker};
					if (typeOf _calcOfensor isNotEqualTo "O_UAV_AI") then {
						if (_calcOfensor call BRPVP_isPlayer) then {
							private _poss = _calcOfensor getVariable ["brpvp_possessed",-1];
							if (_poss isNotEqualTo -1) then {
								private _newPoss = _poss+1;
								_calcOfensor setVariable ["brpvp_possessed",_newPoss];
								if (_newPoss isEqualTo 4) then {
									{BRPVP_possCaptive = false;} remoteExecCall ["BRPVP_possRemovePlayerCaptive",_calcOfensor];
									{if !(_x call BRPVP_isPlayerC) then {_x addRating -10000;};} forEach crew vehicle _calcOfensor;
									"bush_reveal" remoteExecCall ["playSound",_calcOfensor];
									_calcOfensor spawn {
										uiSleep 1;
										{if (_x distance _this < 500) then {_x reveal [_this,4];};} forEach allUnits;
									};
								};
							};
						};
					};
				};

				if (_hitPoint in ["hithead","hitabdomen","hitchest"]) then {
					private _level = vehicle _operator getVariable ["brpvp_tlevel",1];
					private _turretHeadDamageToDie = [BRPVP_turretHeadDamageToDieLvl2,BRPVP_turretHeadDamageToDie] select (_level isEqualTo 1);
					private _isHead = _hitPoint isEqualTo "hithead";
					private _damage = _this select 2;
					private _projectile = _this select 4;
					private _explosivePercentage = getNumber (configFile >> "CfgAmmo" >> _projectile >> "explosive");
					_damage = if (_damage < 1 || _explosivePercentage > 0) then {0} else {if (_isHead) then {_damage min 20} else {sqrt _damage min _turretHeadDamageToDie/25};};
					if (_damage > 0) then {
						private _dmgOld = _operator getVariable "brpvp_damage";
						private _dmg = (_dmgOld+_damage) min _turretHeadDamageToDie;
						private _dLim = 0.75*_turretHeadDamageToDie;
						_operator setVariable ["brpvp_damage",_dmg];
						vehicle _operator setVariable ["brpvp_tupdated",true];
						if (_dmgOld <= _dLim && _dmg > _dLim) then {
							private _emitter = "#particlesource" createVehicle [0,0,0];
							_emitter setParticleClass "MediumSmoke";
							_emitter attachTo [vehicle _operator,(vehicle _operator worldToModelVisual ASLtoAGL getPosASL vehicle _operator) vectorAdd [0,0,2.5]];
							[600,[_emitter]] remoteExecCall ["BRPVP_deleteAfterTime",2];
						};
						if (_isHead) then {
							_hintEmMassa = [["str_turret_brain_damage",[round (100*_dmg/_turretHeadDamageToDie)]],0,200,0,"eletric_spark"];
							[_attacker,_hintEmMassa] remoteExecCall ["BRPVP_hintEmMassaFromHC",2];
							if (_damage >= 5) then {
								private _emitter = "#particlesource" createVehicle [0,0,0];
								_emitter setParticleClass "MediumSmoke";
								_emitter attachTo [vehicle _operator,(vehicle _operator worldToModelVisual ASLtoAGL getPosASL vehicle _operator) vectorAdd [0,0,2.5]];
								[1,[_emitter]] remoteExecCall ["BRPVP_deleteAfterTimeSmall",2];
							};
						};
						if (_dmg isEqualTo _turretHeadDamageToDie) then {
							{
								if (typeOf _x isEqualTo "#particlesource") then {
									detach _x;
									{deleteVehicle _x;} forEach (_x nearObjects 0);
								};
							} forEach attachedObjects vehicle _operator;
							_operator setVariable ["brpvp_dead",true,true];
							[["turret",1]] remoteExecCall ["BRPVP_mudaExp",_attacker];

							//SET RAID ON
							if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
								if (_attacker distance2D _operator < 450 && (vehicle _operator) getVariable ["id_bd",-1] >= 0) then {
									private _aAllFlags = [_attacker,25] call BRPVP_flagsInside;
									private _oAllFlags = [_operator,25] call BRPVP_flagsInside;
									private _sharedFlags = _aAllFlags arrayIntersect _oAllFlags;
									if (_sharedFlags isNotEqualTo []) then {
										if (isServer) then {
											private _operatorArray = [ASLToAGL getPosASL vehicle _operator,vehicle _operator getVariable "own",(vehicle _operator getVariable "amg") select 0];
											private _aFlags = [_attacker,_aAllFlags] call BRPVP_isFlagsFriendRelaxedServer;
											private _oFlags = [_operatorArray,_oAllFlags] call BRPVP_isFlagsFriendRelaxedServer;
											if ((_aFlags arrayIntersect _sharedFlags) isEqualTo [] || (_oFlags arrayIntersect _sharedFlags) isEqualTo []) then {
												{_x setVariable ["brpvp_last_intrusion",serverTime,true];} forEach _aFlags;
												{
													_x setVariable ["brpvp_last_intrusion",serverTime,true];
													if (BRPVP_useDiscordEmbedBuilder) then {_x call BRPVP_messageDiscordRaid;};
												} forEach _oFlags;
											};
										} else {
											private _operatorArray = [ASLToAGL getPosASL vehicle _operator,vehicle _operator getVariable "own",(vehicle _operator getVariable "amg") select 0];
											[_attacker,_operatorArray,_aAllFlags,_oAllFlags,_sharedFlags] spawn {
												params ["_attacker","_operatorArray","_aAllFlags","_oAllFlags","_sharedFlags"];
												private _aFlags = [_attacker,_aAllFlags] call BRPVP_isFlagsFriendRelaxed;
												private _oFlags = [_operatorArray,_oAllFlags] call BRPVP_isFlagsFriendRelaxed;
												if ((_aFlags arrayIntersect _sharedFlags) isEqualTo [] || (_oFlags arrayIntersect _sharedFlags) isEqualTo []) then {
													{_x setVariable ["brpvp_last_intrusion",serverTime,true];} forEach _aFlags;
													{
														_x setVariable ["brpvp_last_intrusion",serverTime,true];
														if (BRPVP_useDiscordEmbedBuilder) then {_x remoteExecCall ["BRPVP_messageDiscordRaid",2];};
													} forEach _oFlags;
												};
											};
										};
									};
								};
							};

							BRPVP_autoTurretDied pushBack _operator;
						};
					};
				};
			} else {
				//SET WAKE UP PROTECTION
				private _level = vehicle _operator getVariable ["brpvp_tlevel",1];
				private _turretHeadDamageToDie = [BRPVP_turretHeadDamageToDieLvl2,BRPVP_turretHeadDamageToDie] select (_level isEqualTo 1);
				private _projectile = _this select 4;
				private _explosivePercentage = getNumber (configFile >> "CfgAmmo" >> _projectile >> "explosive");
				if (_explosivePercentage > 0.125) then {
					private _t = objectParent _operator;
					if (!isNull _t) then {
						private _inpulse = _t getVariable ["brpvp_inpulse",false];
						if (!_inpulse) then {_t setVariable ["brpvp_inpulse",true,2];};
					};
				};

				_ricoTime = _operator getVariable ["brpvp_ricochet_sound_time",0];
				_tickTime = diag_tickTime;
				if !(_ricoTime isEqualTo _tickTime) then {
					_operator setVariable ["brpvp_ricochet_sound_time",_tickTime];
					_projectile = _this select 4;
					_explosivePercentage = getNumber (configFile >> "CfgAmmo" >> _projectile >> "explosive");
					if (_explosivePercentage isEqualTo 0) then {
						_hintEmMassa = [["str_turret_brain_damage",[round (100*(_operator getVariable "brpvp_damage")/_turretHeadDamageToDie)]],0,200,0,"ricochet_turret"];
						[_attacker,_hintEmMassa] remoteExecCall ["BRPVP_hintEmMassaFromHC",2];
					};
				};
			};
			//GIVE ATTACKED TURRET PREFERENCE
			if !(_operator getVariable "brpvp_dead") then {
				_time = time;
				if (_time-(_operator getVariable "brpvp_hurtTime") > 5) then {
					private _turretShotOn = _operator getVariable "brpvp_turret";
					_turretShotOn remoteExecCall ["BRPVP_setTurretShotOn",_attacker];
					_operator setVariable ["brpvp_hurtTime",_time];
				};
			};
		};
	};
	0
};
BRPVP_manualTurretDie = {
	params ["_operator",["_dieExplosion",true],["_wait",0]];

	//WAIT
	if (_wait > 0) then {uiSleep _wait;};

	//SET TOTAL DAMAGE
	private _level = vehicle _operator getVariable ["brpvp_tlevel",1];
	private _turretHeadDamageToDie = [BRPVP_turretHeadDamageToDieLvl2,BRPVP_turretHeadDamageToDie] select (_level isEqualTo 1);
	_operator setVariable ["brpvp_damage",_turretHeadDamageToDie];

	//DELETE PARTICLES
	{
		if (typeOf _x isEqualTo "#particlesource") then {
			detach _x;
			{deleteVehicle _x;} forEach (_x nearObjects 0);
		};
	} forEach attachedObjects vehicle _operator;
	_operator setVariable ["brpvp_dead",true,true];

	//SET DIE EXPLOSION
	if (!_dieExplosion) then {(vehicle _operator) setVariable ["brpvp_die_explosion",false];};

	//ADD TO DEATH ARRAY
	BRPVP_autoTurretDied pushBack _operator;
};
BRPVP_setTurretOperatorHC = {
	private ["_group"];
	_this addEventHandler ["HandleDamage",{0}];
	_typeOf = typeOf _this;

	//CREATE GROUP
	_array = BRPVP_autoDefenseTurretList apply {[_this distance _x,_x]};
	_array sort true;
	if (count _array > 0 && {_array select 0 select 0 < 125}) then {
		_group = group (_array select 0 select 1);
	} else {
		_group = createGroup [INDEPENDENT,true];
		BRPVP_totalTurretGroups = BRPVP_totalTurretGroups+1;
		if (BRPVP_totalTurretGroups mod 5 isEqualTo 0) then {diag_log ("[BRPVP Turret Groups] T-Groups = " + str BRPVP_totalTurretGroups);};
	};

	//CREATE TURRET OPERATOR
	_level = _this getVariable ["brpvp_tlevel",1];
	_class = if (_level isEqualTo 1) then {"B_Soldier_VR_F"} else {"C_Soldier_VR_F"};
	_operator = _group createUnit [_class,BRPVP_spawnAIFirstPos,[],10,"CAN_COLLIDE"];
	if (_typeOf in BRPVP_autoTurretTypesTitan) then {
		if (_level isEqualTo 1) then {_this setVehicleAmmoDef 1;} else {_this setVehicleAmmoDef 0.25;};
		_operator setSkill 1;
		if (_this getVariable ["id_bd",-1] isEqualTo -1) then {_operator setSkill ["aimingAccuracy",BRPVP_autoTurretSkillTitan];} else {_operator setSkill ["aimingAccuracy",BRPVP_autoTurretSkillTitanBase];};
	} else {
		_operator setSkill 1;
		if (_this getVariable ["id_bd",-1] isEqualTo -1) then {_operator setSkill ["aimingAccuracy",BRPVP_autoTurretSkill];} else {_operator setSkill ["aimingAccuracy",BRPVP_autoTurretSkillBase];};
	};
	_operator moveInGunner _this;
	_operator setCaptive true;
	_this setVariable ["brpvp_operator",_operator,true];

	//DISABLE AI FEATURES
	_operator disableAI "AUTOTARGET";
	_operator disableAI "FSM";
	_operator disableAI "SUPPRESSION";
	_operator disableAI "COVER";
	_operator disableAI "AUTOCOMBAT";
	_operator disableAI "PATH";
	_operator disableAI "TARGET";
	_operator disableAI "MOVE";
	_operator disableAI "ANIM";

	//HANDLE DAMAGE ON TURRET OPERATOR
	_operator setVariable ["brpvp_hurtTime",0];
	_operator addEventHandler ["HandleDamage",{call BRPVP_tehHandleDamage;}];

	//TURRET REARM PROCESS
	_this setVariable ["brpvp_shots",0];
	_this addEventHandler ["Fired",{call BRPVP_tehFired;}];
	
	//PLAYER OR AI ENTERS TURRET AFTER DEACTIVED
	_this addEventHandler ["GetIn",{
		_t = _this select 0;
		_u = _this select 2;
		if !(_u isEqualTo (_t getVariable "brpvp_operator")) then {[_t,true] remoteExecCall ["enableSimulationGlobal",2];};
	}];

	//TURRET DIE IF RUN OVER BY A VEHICLE OR IF FALL TO SIDE
	_operator addEventHandler ["GetOutMan",{call BRPVP_tehGetOutMan;}];

	//OPERATOR VARS
	_operator setVariable ["brpvp_init",time-random BRPVP_turretCycleTime];
	_operator setVariable ["brpvp_disableTime",-1];
	_operator setVariable ["brpvp_target",objNull,true];
	_operator setVariable ["brpvp_points",0,true];
	_operator setVariable ["brpvp_dead",false,true];
	_operator setVariable ["brpvp_damage",0];
	_operator setVariable ["brpvp_last_target",objNull];
	_operator setVariable ["brpvp_turret",_this,true];

	//DISABLE SIMULATION
	[_operator,false] remoteExecCall ["enableSimulationGlobal",2];
	[_this,false] remoteExecCall ["enableSimulationGlobal",2];

	//ADD TO TURRET SERVER ARRAY
	BRPVP_autoDefenseTurretList pushBack _operator;
};
BRPVP_setTurretOperatorHCNoUnit = {
	_this addEventHandler ["HandleDamage",{0}];
	_typeOf = typeOf _this;
	_this setVariable ["brpvp_operator",objNull,true];
	_this setVariable ["brpvp_shots",0];
	_this addEventHandler ["GetIn",{
		_t = _this select 0;
		_u = _this select 2;
		if !(_u isEqualTo (_t getVariable "brpvp_operator")) then {[_t,true] remoteExecCall ["enableSimulationGlobal",2];};
	}];
	[_this,false] remoteExecCall ["enableSimulationGlobal",2];
};
BRPVP_destroyTurret = {
	_operator = _this getVariable "brpvp_operator";
	if (!isNull _operator) then {
		_operator setVariable ["brpvp_dead_delete",true];
		_operator setVariable ["brpvp_dead",true,true];
		BRPVP_autoTurretDied pushBack _operator;
	};
};
BRPVP_moveActionBoxBackTurret = {
	params ["_turret","_vdu","_posW"];
	private _op = _turret getVariable ["brpvp_operator",objNull];

	//CODE FROM TURRET LOOP
	_op setVariable ["brpvp_disableTime",-1];
	_op remoteExecCall ["BRPVP_enableSimulationGlobalTurret",2];
	_op forceAddUniform "U_I_Soldier_VR";

	_op setVariable ["brpvp_target",objNull,true];
	_op setVariable ["brpvp_last_target_isNull",false,true];
	_op setVariable ["brpvp_points",0,true];
	
	(_turret getVariable ["id_bd",-1]) remoteExecCall ["BRPVP_removeAddTurretInfo",2];
};
BRPVP_EVOffRemoveTurret = {
	{
		if (!isNull _x) then {
			_operator = _x getVariable "brpvp_operator";
			BRPVP_autoDefenseTurretList deleteAt (BRPVP_autoDefenseTurretList find _operator);
			_operator removeAllEventHandlers "HandleDamage";
			_operator removeAllEventHandlers "GetOutMan";
			_x removeAllEventHandlers "HandleDamage";
			_x removeAllEventHandlers "Fired";
			deleteVehicle _operator;
			deleteVehicle _x;
		};
	} forEach _this;
};
BRPVP_setVehAmmoDef = {
	params ["_t","_n"];
	_t setVehicleAmmoDef _n;
};

//TURRET LOOP
BRPVP_turretDisableSimulation = [];
BRPVP_turretInitA = time;
BRPVP_turretInitB = time;
BRPVP_turretInitC = time;
BRPVP_turretsHmgSpecial = [];
addMissionEventHandler ["EachFrame",{call BRPVP_eachFrameTurretMain;}];
BRPVP_eachFrameTurretMain = {
	private _time = time;
	if (_time-BRPVP_turretInitA > 0.5) then {
		BRPVP_turretInitA = _time;
		{
			private _initTurret = _x getVariable "brpvp_init";
			if (_time-_initTurret >= BRPVP_turretCycleTime) then {
				_x setVariable ["brpvp_init",_time];
				private _player = _x getVariable "brpvp_target";
				private _isNullTgt = isNull _player;
				private _deadEnd = _isNullTgt && ((_x getVariable "brpvp_points") > 0 || !(_x getVariable ["brpvp_last_target_isNull",true]));
				if (!(_player isEqualTo (_x getVariable "brpvp_last_target")) || _deadEnd) then {
					if (_deadEnd) then {_x setVariable ["brpvp_points",0,true];};
					_x setVariable ["brpvp_last_target",_player];
					_x setVariable ["brpvp_last_target_isNull",_isNullTgt];
					if (isNull _player) then {
						private _t = _x getVariable "brpvp_turret";
						_x doWatch objNull;
						_x doWatch (getPosWorld _t vectorAdd [100*sin getDir _t,100*cos getDir _t,eyePos _x select 2]);
						BRPVP_turretDisableSimulation pushBack _x;
						_x setVariable ["brpvp_disableTime",_time+5];
					} else {
						private _disableTime = _x getVariable "brpvp_disableTime";
						private _t = _x getVariable "brpvp_turret";
						if (_disableTime isEqualTo -1) then {
							_t remoteExecCall ["BRPVP_enableSimulationGlobalTurret",2];
							_x remoteExecCall ["BRPVP_enableSimulationGlobalTurret",2];
							_x forceAddUniform "U_I_Soldier_VR";
						} else {
							_x setVariable ["brpvp_disableTime",-1];
						};
						private _flyCarDriver = _player getVariable ["brpvp_my_car_fly_key",[]];
						private _playerEff = [[_flyCarDriver select 0,_player] select isNull (_flyCarDriver select 0),_player] select (_flyCarDriver isEqualTo [] || !(typeOf _t in BRPVP_autoTurretTypesTitanAA));
						_x doWatch eyePos _playerEff;
						_x doTarget vehicle _playerEff;
						_x reveal [vehicle _playerEff,4];
					};
				} else {
					if (!isNull _player) then {
						private _t = _x getVariable "brpvp_turret";
						private _flyCarDriver = _player getVariable ["brpvp_my_car_fly_key",[]];
						private _playerEff = [[_flyCarDriver select 0,_player] select isNull (_flyCarDriver select 0),_player] select (_flyCarDriver isEqualTo [] || !(typeOf _t in BRPVP_autoTurretTypesTitanAA));
						_x doTarget vehicle _playerEff;
					};
				};
				
				//SPECIAL CODE IF TARGET IS A STRIDER
				private _ieNow = false;
				if (!isNull _player && {objectParent _player getVariable ["brpvp_to_turret",false]}) then {
					private _tIsHmg = typeOf (_x getVariable "brpvp_turret") in ["I_HMG_01_high_F","I_HMG_01_F"];
					private _tIsLvl2 = (_x getVariable "brpvp_turret") getVariable ["brpvp_tlevel",-1] isEqualTo 2;
					private _is50Explo = objectParent _player getVariable ["brpvp_use_texplode",false];
					private _pointsOk = (_x getVariable "brpvp_points") > 0.8*5/6;
					if (_pointsOk && _tIsHmg && (_tIsLvl2 || !_is50Explo)) then {_ieNow = true;};
				};
				private _ieLast = _x getVariable ["brpvp_is_special",false];
				if (_ieNow isNotEqualTo _ieLast) then {
					_x setVariable ["brpvp_is_special",_ieNow];
					if (_ieNow) then {BRPVP_turretsHmgSpecial pushBackUnique _x;} else {BRPVP_turretsHmgSpecial deleteAt (BRPVP_turretsHmgSpecial find _x);};
				};
			};
		} forEach BRPVP_autoDefenseTurretList;
		if (BRPVP_autoTurretDied isNotEqualTo []) then {
			{
				BRPVP_autoDefenseTurretList deleteAt (BRPVP_autoDefenseTurretList find _x);
				_explosionPos = _x modelToWorld [0,0,0];
				_t = _x getVariable "brpvp_turret";
				if (_x getVariable ["brpvp_dead_delete",false] || _t getVariable ["brpvp_dead_delete",false]) then {
					_x doWatch objNull;
					if (_t getVariable ["id_bd",-1] > -1) then {
						if (_t getVariable ["brpvp_die_explosion",true]) then {
							[_t,["turret_die",1000,1.15]] remoteExecCall ["say3D",BRPVP_allNoServer];
							[_x,_t,_explosionPos] spawn {
								params ["_o","_t","_explosionPos"];
								uiSleep BRPVP_turretDeathExplosionDelay;
								triggerAmmo ("mini_Grenade" createVehicle _explosionPos);
								[_o,_t] remoteExecCall ["BRPVP_veiculoMorreuTurret",2];
							};
						} else {
							[_x,_t] remoteExecCall ["BRPVP_veiculoMorreuTurret",2];
						};
					} else {
						if (_t getVariable ["brpvp_die_explosion",true]) then {
							[_t,["turret_die",1000,1.15]] remoteExecCall ["say3D",BRPVP_allNoServer];
							[_x,_t,_explosionPos] spawn {
								params ["_o","_t","_explosionPos"];
								uiSleep BRPVP_turretDeathExplosionDelay;
								triggerAmmo ("mini_Grenade" createVehicle _explosionPos);
								deleteVehicle _o;
								deleteVehicle _t;
							};
						} else {
							deleteVehicle _x;
							deleteVehicle _t;
						};
					};
				} else {
					if (_t getVariable ["brpvp_die_explosion",true]) then {
						[_t,["turret_die",1000,1.15]] remoteExecCall ["say3D",BRPVP_allNoServer];
						[_x,_t,_explosionPos] spawn {
							params ["_o","_t","_explosionPos"];
							uiSleep BRPVP_turretDeathExplosionDelay;
							triggerAmmo ("mini_Grenade" createVehicle _explosionPos);
							deleteVehicle _o;
						};
					} else {
						deleteVehicle _x;
					};
				};
			} forEach BRPVP_autoTurretDied;
			BRPVP_autoTurretDied = [];
		};
		if (BRPVP_turretDisableSimulation isNotEqualTo []) then {
			BRPVP_turretDisableSimulation = BRPVP_turretDisableSimulation-[objNull];
			_delIndex = [];
			{
				_disableTime = _x getVariable "brpvp_disableTime";
				if (_disableTime isEqualTo -1) then {
					_delIndex pushBack _forEachIndex;
				} else {
					if (_time >= _disableTime) then {
						_x setVariable ["brpvp_disableTime",-1];
						_delIndex pushBack _forEachIndex;
						_t = _x getVariable "brpvp_turret";
						_uniform = if (_t getVariable ["brpvp_tlevel",1] isEqualTo 1) then {"U_B_Soldier_VR"} else {"U_C_Soldier_VR"};
						_x forceAddUniform _uniform;
						[_x,false] remoteExecCall ["enableSimulationGlobal",2];
						[_t,false] remoteExecCall ["enableSimulationGlobal",2];
						_t setVariable ["brpvp_inpulse",false,2];
					};
				};
			} forEach BRPVP_turretDisableSimulation;
			if (count _delIndex > 0) then {
				_delIndex sort false;
				{BRPVP_turretDisableSimulation deleteAt _x;} forEach _delIndex;
			};
		};
		if (_time-BRPVP_turretInitC > 30) then {
			BRPVP_turretInitC = time;
			BRPVP_turretsHmgSpecial = BRPVP_turretsHmgSpecial-[objNull];
		};
	};
	if (_time-BRPVP_turretInitB > 0.2) then {
		BRPVP_turretInitB = time;
		{objectParent _x fireAtTarget [objNull];} forEach BRPVP_turretsHmgSpecial;
	};

	//CHECK AND DO UBER ATTACK
	if (BRPVP_jetBombDo isNotEqualTo []) then {call BRPVP_uberAttackMonitor;};
};
BRPVP_turretsActive = [];
BRPVP_turretsFlagsMessing = [];
BRPVP_turretsSpawn = {
	params ["_turrets","_wait"];
	uiSleep _wait;
	isNil {
		private _t1 = [];
		private _t2 = [];
		{
			_x params ["_modelo","_vVDU","_vPWD","_veiculoId","_owner","_comp","_amigos","_exec","_damage"];
			if !(_veiculoId in BRPVP_turretsActive) then {
				private _veiculo = createVehicle [_modelo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
				_veiculo setVectorDirAndUp _vVDU;
				_veiculo setPosWorld _vPWD;
				_veiculo setVariable ["id_bd",_veiculoId,true];
				_veiculo setVariable ["own",_owner,true];
				_veiculo setVariable ["stp",_comp,true];
				_veiculo setVariable ["amg",_amigos,true];
				_veiculo setVariable ["brpvp_exec",_exec];
				if (_exec isNotEqualTo "_this call BRPVP_setTurretOperator;") then {_veiculo call compile _exec;};
				private _level = _veiculo getVariable ["brpvp_tlevel",1];
				private _turretHeadDamageToDie = [BRPVP_turretHeadDamageToDieLvl2,BRPVP_turretHeadDamageToDie] select (_level isEqualTo 1);
				if (_damage isEqualTo _turretHeadDamageToDie) then {_t1 pushBack _veiculo;} else {_t2 pushBack [_veiculo,_damage];};
				if (BRPVP_turretsSpawnDespawnBomb) then {
					_bomb = createVehicle ["B_20mm",_veiculo modelToWorld [0,0,0],[],0,"CAN_COLLIDE"];
					_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
					_bomb setVelocity [0,0,-200];
				};
			};
			BRPVP_turretsActive pushBack _veiculoId;
		} forEach _turrets;

		{_x call BRPVP_setTurretOperatorHCNoUnit;} forEach _t1;
		{
			_x params ["_t","_d"];
			_t call BRPVP_setTurretOperatorHC;
			(_t getVariable "brpvp_operator") setVariable ["brpvp_damage",_d];
		} forEach _t2;
	};
};
BRPVP_turretsDespawn = {
	params ["_pTurrets","_wait"];
	private _updateAll = [];
	private _os = [];
	private _ts = [];
	{
		_x params ["_t","_id"];
		BRPVP_turretsActive deleteAt (BRPVP_turretsActive find _id);
		if !(_id in BRPVP_turretsActive) then {
			private _op = _t getVariable ["brpvp_operator",objNull];
			if (isNull _op) then {
				if (_t getVariable ["slv",false] || _t getVariable ["slv_amg",false] || _t getVariable ["brpvp_tupdated",false]) then {
					private _modelo = typeOf _t;
					private _vVDU = [vectorDir _t,vectorUp _t];
					private _vPWD = getPosWorld _t;
					private _veiculoId = _t getVariable "id_bd";
					private _owner = _t getVariable "own";
					private _comp = _t getVariable "stp";
					private _amigos = _t getVariable ["amg",[[],[],true]];
					private _exec = _t getVariable "brpvp_exec";
					private _level = _t getVariable ["brpvp_tlevel",1];
					private _turretHeadDamageToDie = [BRPVP_turretHeadDamageToDieLvl2,BRPVP_turretHeadDamageToDie] select (_level isEqualTo 1);
					private _damage = _turretHeadDamageToDie;
					_updateAll pushBack [_modelo,_vVDU,_vPWD,_veiculoId,_owner,_comp,_amigos,_exec,_damage];
					(_t call BRPVP_salvaVeiculoData) remoteExecCall ["BRPVP_salvaVeiculoOnlySql",2];
				};
			} else {
				if (_t getVariable ["slv",false] || _t getVariable ["slv_amg",false] || _t getVariable ["brpvp_tupdated",false]) then {
					private _modelo = typeOf _t;
					private _vVDU = [vectorDir _t,vectorUp _t];
					private _vPWD = getPosWorld _t;
					private _veiculoId = _t getVariable "id_bd";
					private _owner = _t getVariable "own";
					private _comp = _t getVariable "stp";
					private _amigos = _t getVariable ["amg",[[],[],true]];
					private _exec = _t getVariable "brpvp_exec";
					private _damage = _op getVariable "brpvp_damage";
					_updateAll pushBack [_modelo,_vVDU,_vPWD,_veiculoId,_owner,_comp,_amigos,_exec,_damage];
					(_t call BRPVP_salvaVeiculoData) remoteExecCall ["BRPVP_salvaVeiculoOnlySql",2];
				};
				BRPVP_autoDefenseTurretList deleteAt (BRPVP_autoDefenseTurretList find _op);
				_os pushBack _op;
			};
			_ts pushBack _t;
		};
	} forEach _pTurrets;
	if (_updateAll isNotEqualTo []) then {_updateAll remoteExecCall ["BRPVP_updateTurretInfo",0];};
	[_os,_ts,_wait] spawn {
		params ["_os","_ts","_wait"];
		uiSleep _wait;
		{
			_x removeAllEventHandlers "HandleDamage";
			_x removeAllEventHandlers "GetInMan";
			deleteVehicle _x;
		} forEach _os;
		{
			_x removeAllEventHandlers "HandleDamage";
			_x removeAllEventHandlers "Fired";
			_x removeAllEventHandlers "GetIn";
			deleteVehicle _x;
			if (BRPVP_turretsSpawnDespawnBomb) then {
				_bomb = createVehicle ["B_20mm",_x modelToWorld [0,0,0],[],0,"CAN_COLLIDE"];
				_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
				_bomb setVelocity [0,0,-200];
			};
		} forEach _ts;
	};	
};
BRPVP_turretInitiateDefenses = {
	params ["_mid","_iFlagsId","_cases"];
	if (BRPVP_turretsFlagsMessing arrayIntersect _iFlagsId isEqualTo []) then {
		BRPVP_turretsFlagsMessing append _iFlagsId;
		private _spawnIds = [];
		private _turretSpawnPerThread = if (BRPVP_turretsSpawnDespawnBomb) then {1} else {5};
		private _cc = count _cases;
		private _cct = ((if (BRPVP_turretsSpawnDespawnBomb) then {20} else {12.5})*_cc/300) max 1;
		for "_i" from 0 to (_cc-1) step _turretSpawnPerThread do {
			_spawnIds pushBack ([_cases select [_i,_turretSpawnPerThread],_cct*_i/_cc] spawn BRPVP_turretsSpawn);
		};
		[_mid,_iFlagsId,_spawnIds] spawn {
			params ["_mid","_iFlagsId","_spawnIds"];
			waitUntil {{!scriptDone _x} count _spawnIds isEqualTo 0};
			BRPVP_turretsFlagsMessing = BRPVP_turretsFlagsMessing-_iFlagsId;
			false remoteExecCall ["BRPVP_sleepRoundsSet",_mid];
		};
	} else {
		"add_not_ready" remoteExecCall ["BRPVP_sleepRoundsSet",_mid];
	};
};
BRPVP_turretStopDefenses = {
	params ["_mid","_iFlags","_iFlagsId","_cases","_casesId"];
	if (BRPVP_turretsFlagsMessing arrayIntersect _iFlagsId isEqualTo [] || _mid isEqualTo -1) then {
		BRPVP_turretsFlagsMessing append _iFlagsId;
		private _turrets = [];
		private _notFound = [];
		{_turrets append nearestObjects [_x,["StaticWeapon"],(_x call BRPVP_getFlagRadius)+10,true];} forEach _iFlags;
		_turrets = _turrets arrayIntersect _turrets;
		_notFound = _casesId-(_turrets apply {_x getVariable ["id_bd",-1]});
		_turrets = (_turrets apply {if ((_x getVariable ["id_bd",-1]) in _casesId) then {[_x,_x getVariable ["id_bd",-1]]} else {-1};})-[-1];
		{
			private _id = _x;
			{
				if (_x getVariable ["id_bd",-1] isEqualTo _id) then {_turrets pushBack [_x,_x getVariable ["id_bd",-1]];};
			} forEach entities [["StaticWeapon"],[]];
		} forEach _notFound;
		private _spawnIds = [];
		private _turretDespawnPerThread = if (BRPVP_turretsSpawnDespawnBomb) then {1} else {10};
		private _q = count _turrets;
		private _cct = ((if (BRPVP_turretsSpawnDespawnBomb) then {15} else {6})*_q/300) max 1;
		for "_i" from 0 to (count _turrets-1) step _turretDespawnPerThread do {
			_spawnIds pushBack ([_turrets select [_i,_turretDespawnPerThread],_cct*_i/_q] call BRPVP_turretsDespawn);
		};
		[_mid,_iFlagsId,_spawnIds] spawn {
			params ["_mid","_iFlagsId","_spawnIds"];
			waitUntil {{!scriptDone _x} count _spawnIds isEqualTo 0};
			BRPVP_turretsFlagsMessing = BRPVP_turretsFlagsMessing-_iFlagsId;
			if (_mid isNotEqualTo -1) then {false remoteExecCall ["BRPVP_sleepRoundsSet",_mid];};
		};
	} else {
		"remove_not_ready" remoteExecCall ["BRPVP_sleepRoundsSet",_mid];
	};
};