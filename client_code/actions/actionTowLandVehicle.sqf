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

if (isNil "BRPVP_towBobLand") then {
	BRPVP_towBobSetCaptiveObjs = [];
	BRPVP_towBobSetCaptive = {
		params ["_unit","_vehicle"];
		BRPVP_towBobSetCaptiveObjs = BRPVP_towBobSetCaptiveObjs-[objNull];
		if !(_unit in BRPVP_towBobSetCaptiveObjs) then {
			_this spawn {
				params ["_unit","_vehicle"];
				private ["_cap","_tm","_pin"];
				private _init = time;
				waitUntil {
					_cap = captive _unit;
					_tm = time-_init >= 60;
					_pin = crew vehicle _unit isNotEqualto [_unit];
					_cap || _tm || _pin
				};
				if (_tm && !_cap && !_pin) then {_unit setCaptive true;};
			};
		};
	};
	BRPVP_towBobLand = {
		params ["_pr0","_pr1","_pr2","_vehicle",["_retry",false],["_beha","CARELESS"]];
		private _dcp = driver _vehicle;
		private _distToNear = 25;
		private _price = BRPVP_towLandVehiclePrice;
		if (isNull _dcp) then {
			if (!isNull _vehicle && alive _vehicle && fuel _vehicle > 0 && canMove _vehicle) then {
				private _mny = player getVariable "mny";
				if (_mny >= _price || _retry) then {
					[_vehicle,15] call BRPVP_enableVehOnInteraction;
					BRPVP_landVehicleOnTow pushBack _vehicle;
					if (!_retry) then {
						BRPVP_actionRunning pushBack 10;
						player setVariable ["mny",_mny-_price,true];
						call BRPVP_atualizaDebug;
						"negocio" call BRPVP_playSound;
					};
					private _agnt = createAgent ["C_Driver_1_F",[0,0,0],[],20,"NONE"];
					_agnt setBehaviour _beha;
					_agnt disableAI "FSM";
					_agnt disableAI "LIGHTS";
					uiSleep 0.2;

					_agnt allowDamage false;
					_agnt moveInDriver _vehicle;

					//REMOVE AUTO MAGUS TIME
					if !(typeOf _vehicle in BRPVP_vantVehiclesClass) then {if (_vehicle getVariable ["id_bd",-1] isNotEqualTo -1) then {_vehicle setVariable ["brpvp_auto_magus_time",-1,2];};};

					waitUntil {driver _vehicle isEqualTo _agnt};
					if (_vehicle getVariable ["id_bd",-1] isNotEqualTo -1) then {_vehicle setVariable ["slv",true,true];};
					private _bobs = ((player getVariable ["brpvp_towners",[]])+[_agnt])-[objNull];
					player setVariable ["brpvp_towners",_bobs,[clientOwner,2]];
					private _notNull = true;
					private _playerWant = true;
					private _init = 0;
					private _initEngine = time;
					private _stopTime = 0;
					private _reset = false;
					private _lastPin = crew vehicle _agnt isNotEqualTo [_agnt];
					if (_lastPin) then {_agnt setCaptive false;} else {_agnt setCaptive true;};
					waitUntil {
						uiSleep 0.25;
						_vehicle engineOn true;
						isEngineOn _vehicle || time-_initEngine > 2
					};
					_agnt moveTo ASLToAGL getPosASL _agnt;
					waitUntil {
						private _tm = time;
						_playerWant = _vehicle in BRPVP_landVehicleOnTow;
						if (_tm-_init > 1) then {
							_init = _tm;
							_notNull = !isNull _vehicle;
							private _isAlive = alive _vehicle;
							private _haveFuel = fuel _vehicle > 0;
							private _canMove = canMove _vehicle;
							private _isDriver = driver _vehicle isEqualTo _agnt;
							private _chiefAlive = (player call BRPVP_pAlive);
							private _finalDest = _vehicle getVariable ["brpvp_tow_destine",[]];
							private _isFollowPlayer = _finalDest isEqualTo [];
							_finalDest = if (_isFollowPlayer) then {ASLToAGL getPosASL vehicle player} else {_finalDest};
							private _distance = _vehicle distance _finalDest;
							private _hasAccess = _vehicle call BRPVP_checaAcesso;
							private _pin = crew vehicle _agnt isNotEqualTo [_agnt];
							private _lastMoveTo = 0;
							if (_pin isNotEqualTo _lastPin) then {
								if (_pin) then {_agnt setCaptive false;} else {[_agnt,_vehicle] call BRPVP_towBobSetCaptive;};
								_lastPin = _pin;
							};
							if (_distance > _distToNear) then {
								if (moveToCompleted _agnt || time-_lastMoveTo > 7.5) then {
									_agnt moveTo _finalDest;
									_lastMoveTo = time;
									_stopTime = 0;
								} else {
									if (speed _vehicle < 0.1) then {
										_stopTime = _stopTime+1;
										if (_stopTime isEqualTo 15 && _distance > 50) then {
											_reset = true;
											_stopTime = 0;
										};
									} else {
										_stopTime = 0;
									};
								};
							} else {
								private _vel = vectorMagnitude velocity _vehicle;
								if (_vel > 1) then {
									_agnt moveTo ASLToAGL getPosASL _agnt;
									uiSleep 5;
								};
							};
							!(_notNull && _isAlive && _haveFuel && _canMove && _isDriver && _playerWant && _chiefAlive && _hasAccess && !_reset)
						} else {
							!_playerWant
						};
					};
					BRPVP_landVehicleOnTow = BRPVP_landVehicleOnTow-[_vehicle,objNull];
					if (!_reset) then {if (_playerWant) then {[localize "str_tow_fail"] call BRPVP_hint;} else {[localize "str_tow_ok"] call BRPVP_hint;};};
					if (_notNull) then {
						//SET AUTO MAGUS TIME
						if !(typeOf _vehicle in BRPVP_vantVehiclesClass) then {
							if (crew _vehicle-[_agnt] isEqualTo [] && _vehicle getVariable ["id_bd",-1] > -1 && _vehicle getVariable ["own",-1] > -1) then {
								_vehicle setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
							};
						};
						_vehicle deleteVehicleCrew _agnt;
						_vehicle engineOn false;
					} else {
						deleteVehicle _agnt;
					};
					if (_reset) then {
						[localize "str_tow_stuck",-5] call BRPVP_hint;
						[0,0,0,_vehicle,true,_beha] call BRPVP_towBobLand;
					} else {
						_vehicle setVariable ["brpvp_tow_destine",[]];

						//SET AUTO MAGUS TIME
						if !(typeOf _vehicle in BRPVP_vantVehiclesClass) then {
							if (crew _vehicle in [[],[_agnt]] && _vehicle getVariable ["id_bd",-1] > -1 && _vehicle getVariable ["own",-1] > -1) then {
								_vehicle setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
							};
						};
					};
				} else {
					[localize "str_no_money"] call BRPVP_hint;
				};
			} else {
				[localize "str_tow_cant"] call BRPVP_hint;
			};
		} else {
			[localize "str_tow_driver_pos"] call BRPVP_hint;
		};
	};
	BRPVP_towBobHeli = {
		params ["_pr0","_pr1","_pr2","_vehicle",["_retry",false],["_beha","CARELESS"]];
		private _dcp = currentPilot _vehicle;
		private _price = BRPVP_towLandVehiclePrice;
		if (isNull _dcp) then {
			if (!isNull _vehicle && alive _vehicle && fuel _vehicle > 0 && canMove _vehicle) then {
				private _mny = player getVariable "mny";
				if (_mny >= _price || _retry) then {
					[_vehicle,15] call BRPVP_enableVehOnInteraction;
					BRPVP_landVehicleOnTow pushBack _vehicle;
					if (!_retry) then {
						BRPVP_actionRunning pushBack 10;
						player setVariable ["mny",_mny-_price,true];
						call BRPVP_atualizaDebug;
						"negocio" call BRPVP_playSound;
					};
					private _bobGrp = createGroup [OPFOR,true];
					private _ai = _bobGrp createUnit ["C_Driver_1_F",[0,0,0],[],20,"NONE"];
					_ai setBehaviour _beha;
					_ai disableAI "TARGET";
					_ai disableAI "AUTOTARGET";
					_ai disableAI "AUTOCOMBAT";
					_ai disableAI "LIGHTS";
					//_ai disableAI "FIREWEAPON";
					//_ai disableAI "WEAPONAIM";
					uiSleep 0.2;

					_ai allowDamage false;
					_ai moveInDriver _vehicle;

					//REMOVE AUTO MAGUS TIME
					if !(typeOf _vehicle in BRPVP_vantVehiclesClass) then {if (_vehicle getVariable ["id_bd",-1] isNotEqualTo -1) then {_vehicle setVariable ["brpvp_auto_magus_time",-1,2];};};

					waitUntil {currentPilot _vehicle isEqualTo _ai};
					if (_vehicle getVariable ["id_bd",-1] isNotEqualTo -1) then {_vehicle setVariable ["slv",true,true];};
					private _bobs = ((player getVariable ["brpvp_towners",[]])+[_ai])-[objNull];
					player setVariable ["brpvp_towners",_bobs,[clientOwner,2]];
					private _notNull = true;
					private _playerWant = true;
					private _init = 0;
					private _initEngine = time;
					private _delta = 1;
					private _landOn = isTouchingGround _vehicle;
					private _lastPin = crew vehicle _ai isNotEqualTo [_ai];
					if (_lastPin) then {_ai setCaptive false;} else {_ai setCaptive true;};
					if (_landOn) then {
						_vehicle land "LAND";
					} else {
						_vehicle land "NONE";
						waitUntil {
							uiSleep 0.25;
							_vehicle engineOn true;
							isEngineOn _vehicle || time-_initEngine > 2
						};
					};
					waitUntil {
						private _tm = time;
						_playerWant = _vehicle in BRPVP_landVehicleOnTow;
						if (_tm-_init > _delta) then {
							_init = _tm;
							_notNull = !isNull _vehicle;
							private _isAlive = alive _vehicle;
							private _isAliveAi = alive _ai;
							private _haveFuel = fuel _vehicle > 0;
							private _canMove = canMove _vehicle;
							private _isDriver = driver _vehicle isEqualTo _ai;
							private _chiefAlive = (player call BRPVP_pAlive);
							private _finalDest = _vehicle getVariable ["brpvp_tow_destine",[]];
							_finalDest = if (_finalDest isEqualTo []) then {ASLToAGL getPosASL vehicle player} else {_finalDest};
							private _distance = _vehicle distance2D _finalDest;
							private _hasAccess = _vehicle call BRPVP_checaAcesso;
							private _pin = crew vehicle _ai isNotEqualTo [_ai];
							if (_pin isNotEqualTo _lastPin) then {
								if (_pin) then {_ai setCaptive false;} else {[_ai,_vehicle] call BRPVP_towBobSetCaptive;};
								_lastPin = _pin;
							};
							if ((_distance > 150 && !_landOn) || (_landOn && _distance > 500)) then {
								if (!isEngineOn _vehicle) then {_vehicle engineOn true;};
								_vehicle land "NONE";
								uiSleep 0.001;
								_ai doMove _finalDest;
								_delta = 5;
								_landOn = false;
							} else {
								_vehicle land "LAND";
								_delta = 1;
								_landOn = true;
							};
							!(_notNull && _isAlive && _isAliveAi && _haveFuel && _canMove && _isDriver && _playerWant && _chiefAlive && _hasAccess)
						} else {
							!_playerWant
						};
					};
					BRPVP_landVehicleOnTow = BRPVP_landVehicleOnTow-[_vehicle,objNull];
					if (_playerWant) then {[localize "str_tow_fail"] call BRPVP_hint;} else {[localize "str_tow_ok"] call BRPVP_hint;};
					if (_notNull) then {
						//SET AUTO MAGUS TIME
						if !(typeOf _vehicle in BRPVP_vantVehiclesClass) then {
							if (crew _vehicle-[_ai] isEqualTo [] && _vehicle getVariable ["id_bd",-1] > -1 && _vehicle getVariable ["own",-1] > -1) then {
								_vehicle setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
							};
						};
						_vehicle deleteVehicleCrew _ai;
						_vehicle engineOn false;
					} else {
						deleteVehicle _ai;
					};
					_vehicle setVariable ["brpvp_tow_destine",[]];

					//SET AUTO MAGUS TIME
					if !(typeOf _vehicle in BRPVP_vantVehiclesClass) then {
						if (crew _vehicle in [[],[_ai]] && _vehicle getVariable ["id_bd",-1] > -1 && _vehicle getVariable ["own",-1] > -1) then {
							_vehicle setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
						};
					};

					[_vehicle,60] call BRPVP_enableVehOnInteraction;
				} else {
					[localize "str_no_money"] call BRPVP_hint;
				};
			} else {
				[localize "str_tow_cant"] call BRPVP_hint;
			};
		} else {
			[localize "str_tow_driver_pos"] call BRPVP_hint;
		};
	};
};
if ((_this select 3) isKindOf "LandVehicle") then {call BRPVP_towBobLand;} else {call BRPVP_towBobHeli;};