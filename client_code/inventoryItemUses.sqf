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

BRPVP_usedFuelGallonRunning = false;
BRPVP_usedFuelGallon = {
	if (BRPVP_usedFuelGallonRunning) then {
		"erro" call BRPVP_playSound;		
		false
	} else {
		0 spawn {
			waitUntil {!BRPVP_menuExtraLigado};
			uiSleep 0.001;
			121 call BRPVP_iniciaMenuExtra;
		};
		true
	};
};
BRPVP_usedScannerRunning = false;
BRPVP_usedScanner = {
	private ["_dist"];
	if (BRPVP_usedScannerRunning) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_usedScannerRunning = true;
		if (_this isEqualTo "Mag_BRPVP_scanner_100") then {_dist = 100;} else {if (_this isEqualTo "Mag_BRPVP_scanner_200") then {_dist = 200;} else {_dist = 300;};};
		_dist spawn {
			private _sounder = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],100,"NONE"];
			_sounder attachTo [BRPVP_myPlayerOrUAV,[0,0,0]];
			[_sounder,["scanner",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
			_init = time;
			_p = player;
			_myPlayerOrUAV = BRPVP_myPlayerOrUAV;
			waitUntil {time-_init > 3 || !(_p call BRPVP_pAlive) || (!alive _myPlayerOrUAV) || BRPVP_menuExtraLigado};
			deleteVehicle _sounder;
			if (_p call BRPVP_pAlive && alive _myPlayerOrUAV && !BRPVP_menuExtraLigado) then {
				_vehicles = BRPVP_myPlayerOrUAV nearEntities [["Motorcycle","Car","Tank","Air","Ship"],_this];
				_pAlive = 0;
				_pDead = 0;
				_pCalc = (BRPVP_myPlayerOrUAV nearEntities [BRPVP_playerModel,_this])+(BRPVP_playerVehicles select {_x distance BRPVP_myPlayerOrUAV <= _this});
				{if (_x getVariable "sok") then {if (_x call BRPVP_pAlive) then {_pAlive = _pAlive+1;} else {_pDead = _pDead+1};};} forEach (_pCalc arrayIntersect _pCalc);
				_deadBoxes = nearestObjects [BRPVP_myPlayerOrUAV,["Box_T_East_Wps_F"],_this];
				_otherBoxes = [];
				{
					private _box = _x;
					private _idOk = (_box getVariable ["id_bd",-1]) isEqualTo -1;
					private _ownOk = (_box getVariable ["own",-1]) isEqualTo -1;
					private _visible = !isObjectHidden _box;
					if (_idOk && _ownOk && _visible) then {_otherBoxes pushBack _box;};
				} forEach (nearestObjects [BRPVP_myPlayerOrUAV,["ReammoBox_F"],_this]-_deadBoxes);
				_suitCases = nearestObjects [BRPVP_myPlayerOrUAV,["Land_Suitcase_F"],_this];
				_itemsOnGround = (nearestObjects [BRPVP_myPlayerOrUAV,["GroundWeaponHolder","WeaponHolderSimulated"],_this]) select {!isObjectHidden _x && isNull attachedTo _x};
				_AI = [];
				{
					if (BRPVP_myPlayerOrUAV distance _x <= _this) then {_AI pushBack _x;};
				} forEach entities [["CaManBase"],[BRPVP_playerModel,BRPVP_zombieMotherClass,"B_Soldier_VR_F","C_Soldier_VR_F","C_man_sport_1_F_afro"],true,true];
				_zombies = count (BRPVP_myPlayerOrUAV nearEntities [BRPVP_zombieMotherClass,_this]);
				BRPVP_menuVar1 = [
					[_pAlive,[],{"off"}],
					[_pDead,[],{"off"}],
					[count _deadBoxes,_deadBoxes,{format ["$ %1",(_this call {_mny = (_this call BRPVP_getCargoArray) call BRPVP_getCargoArrayValor;((_mny select 0)+(_mny select 1))}) call BRPVP_formatNumber]}],
					[count _otherBoxes,_otherBoxes,{format ["$ %1",(_this call {_mny = (_this call BRPVP_getCargoArray) call BRPVP_getCargoArrayValor;((_mny select 0)+(_mny select 1))}) call BRPVP_formatNumber]}],
					[count _itemsOnGround,_itemsOnGround,{format ["$ %1",(_this call {_mny = (_this call BRPVP_getCargoArray) call BRPVP_getCargoArrayValor;((_mny select 0)+(_mny select 1))}) call BRPVP_formatNumber]}],
					[count _suitCases,_suitCases,{format ["$ %1",(_this getVariable ["mny",0]) call BRPVP_formatNumber]}],
					[count _AI,_AI,{format ["%1 %2",round (BRPVP_myPlayerOrUAV distance _this),localize "str_meters"]}],
					[_zombies,[],{"off"}],
					[count _vehicles,_vehicles,{getText (configFile >> "CfgVehicles" >> typeOf _this >> "displayName") call BRPVP_escapeForStructuredTextFast}]
				];
				BRPVP_menuVar3 = _this;
				120 call BRPVP_iniciaMenuExtra;
			} else {
				"erro" call BRPVP_playSound;
				[format ["Mag_BRPVP_scanner_%1",_this],1] call BRPVP_sitAddItem;
				BRPVP_usedScannerRunning = false;
			};
		};
		true
	};
};
BRPVP_useZBloodBag = {
	if (player getVariable ["brpvp_z_blood_bag_on",false]) then {
		"erro" call BRPVP_playSound;
		[localize "str_zbb_used_cant",-6] call BRPVP_hint;
		false
	} else {
		[true,player getVariable "id_bd"] remoteExecCall ["BRPVP_zombieBloodBagActiveAdd",2];
		[player,["z_blood_bag_use",150]] remoteExec ["say3D",BRPVP_allNoServer];
		player setVariable ["brpvp_z_blood_bag_on",true,true];
		[localize "str_zbb_used_msg",-6] call BRPVP_hint;
		["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\anti_zombie_on.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.17},1000000,0,0,3195] call BRPVP_fnc_dynamicText;
		true
	};
};
BRPVP_usedHydraulic = {
	if ({player distanceSqr (_x select 0) <= _x select 1} count BRPVP_safeZonesOtherMethodQuad > 0) then {
		[localize "str_hydrajack_cant_on_safe",-6] call BRPVP_hint;
		false
	} else {
		if (BRPVP_hydraulicJackTime > time) then {
			"erro" call BRPVP_playSound;
			false
		} else {
			BRPVP_hydraulicJackTime = time+60;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\hydraulic_jack.paa'/><br />shift+3",0,0,60,0,0,2798] call BRPVP_fnc_dynamicText;
			[localize "str_hydrajack_used",10] call BRPVP_hint;
			true
		};
	};
};
BRPVP_usedVehOwnerity = {
	private _isUAV = false;
	private _veh = player call BRPVP_controlingUAV;
	if (isNull _veh) then {_veh = objectParent player;} else {_isUAV = true;};
	if (isNull _veh) then {
		"erro" call BRPVP_playSound;
		[localize "str_veh_ownerity_cant1",-5] call BRPVP_hint;
		false
	} else {
		if (driver _veh isEqualTo player || _isUAV) then {
			_idBd = _veh getVariable ["id_bd",-1];
			_own = _veh getVariable ["own",-1];
			if (_idBd > -1 && _own > -1) then {
				_mny = player getVariable ["mny",0];
				if (_mny >= BRPVP_vehOwnerityChangePrice) then {
					player setVariable ["mny",_mny-BRPVP_vehOwnerityChangePrice,true];
					call BRPVP_atualizaDebug;
					_veh setVariable ["own",player getVariable "id_bd",true];
					_amg = _veh getVariable ["amg",[[],[],true]];
					_amgCst = if (count _amg > 1) then {_amg select 1} else {[]};
					_amgCstBoo = if (count _amg > 2) then {_amg select 2} else {true};
					_veh setVariable ["amg",[player getVariable ["amg",[]],_amgCst,_amgCstBoo],true];
					if !(_veh getVariable ["slv",false]) then {_veh setVariable ["slv",true,true];};
					if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
					_oldOwner = objNull;
					{if (_x getVariable ["own",-1] isEqualTo _own) exitWith {_oldOwner = _x;};} forEach call BRPVP_playersList;
					if (!isNull _oldOwner) then {
						[
							_veh,
							{
								sleep 0.25;
								if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
							}
						] remoteExec ["spawn",_oldOwner];
					};
					[_idBd,player getVariable "id_bd"] remoteExecCall ["BRPVP_updateInsuranceOwner",2];
					"ugranted" call BRPVP_playSound;
					[format [localize "str_veh_ownerity_conclude",BRPVP_vehOwnerityChangePrice call BRPVP_formatNumber,getText (configFile >> "CfgVehicles" >> typeOf _veh >> "displayName")],-5] call BRPVP_hint;
					true
				} else {
					"erro" call BRPVP_playSound;
					[format [localize "str_mny_need_x_in_wallet",BRPVP_vehOwnerityChangePrice call BRPVP_formatNumber],-5] call BRPVP_hint;
					false
				};
			} else {
				"erro" call BRPVP_playSound;
				[localize "str_veh_ownerity_cant2",-5] call BRPVP_hint;
				false
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_veh_ownerity_cant1",-5] call BRPVP_hint;
			false
		};
	};
};
BRPVP_usedHulkPillsRunning = false;
BRPVP_usedHulkPillsRelease = {
	BRPVP_hulkPillsActUsed = true;
	(_this select 3) params ["_box","_co"];
	_dir = getDir player;
	detach _box;
	[player,["hulk_release",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
	[_box,[10*sin _dir,10*cos _dir,0]] remoteExecCall ["setVelocity",0];
	
	player setVariable ["brpvp_hulk_objs",[],[clientOwner,2]];
	BRPVP_usedHulkPillsRunning = false;
	
	if (!BRPVP_hulkBoxExploded) then {
		uiSleep 1;
		_pw = getPosWorld _box;
		_count = 0;
		waitUntil {
			_pwn = getPosWorld _box;
			if (_pwn isEqualTo _pw) then {_count = _count+1;};
			_pw = +_pwn;
			_count isEqualTo 5 || BRPVP_hulkBoxExploded
		};
		uiSleep 1;
		if (!BRPVP_hulkBoxExploded) then {
			_boxPW = getPosWorld _box;
			_lis = lineIntersectsSurfaces [_boxPW,_boxPW vectorAdd [0,0,-5],_box,objNull,true,1,"GEOM","NONE"];
			_vu = if (_lis isEqualTo []) then {[0,0,1]} else {_lis select 0 select 1};
			_box setVectorUp _vu;
			_pos = (getPosASL _box) vectorAdd [0,0,0.75];
			_box setPosATL [0,0,0];;
			[_co,10] call BRPVP_enableVehOnInteraction;
			[_co,_pos] remoteExecCall ["setPosASL",_co];
			[_co,_dir] remoteExecCall ["setDir",_co];
			[_co,_vu] remoteExecCall ["setVectorUp",_co];
			[_co,false] remoteExecCall ["hideObjectGlobal",2];
			private _init = diag_tickTime;
			waitUntil {
				if (vectorMagnitude velocity _co > 0.125) then {_init = diag_tickTime;};
				diag_tickTime-_init > 1.25
			};
			[_co,true] remoteExecCall ["allowDamage",_co];
			_co setVariable ["brpvp_time_can_disable",0,2];
			if !(_co getVariable ["slv",false]) then {_co setVariable ["slv",true,true];};
			deleteVehicle _box;
		};
	};
};
BRPVP_usedHulkPills = {
	if (BRPVP_usedHulkPillsRunning || !isNull objectParent player) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		_vec = (getCameraViewDirection player) vectorMultiply 7.5;
		_posCam = eyePos player;
		_lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,1,"GEOM","NONE"];
		_co = if (_lis isEqualTo []) then {objNull} else {_lis select 0 select 2};
		if (!isNull _co && {_co call BRPVP_isMotorizedNoTurret && alive _co}) then {
			if ({_co distanceSqr (_x select 0) <= (_x select 1)} count BRPVP_safeZonesOtherMethodQuad isEqualTo 0) then {
				private _crew = crew _co;
				if ({!(typeOf _x isEqualTo "O_UAV_AI")} count _crew isEqualTo 0) then {
					if (_co getVariable ["brpvp_no_tow",false] || _co getVariable ["brpvp_cant_heli_town",false]) then {
						"erro" call BRPVP_playSound;
						[localize "str_hulk_pills_cant_special_veh",-4] call BRPVP_hint;
						false
					} else {
						BRPVP_usedHulkPillsRunning = true;
						_flagState = player call BRPVP_checkOnFlagState;
						_hulkPillsTime = if (_flagState isEqualTo 0) then {BRPVP_hulkPillsTimeOutBase} else {BRPVP_hulkPillsTime};
						_box = createVehicle ["Box_NATO_AmmoVeh_F",BRPVP_posicaoFora,[],100,"CAN_COLLIDE"];
						_box setVariable ["brpvp_veh",_co];
						_box addEventHandler ["HandleDamage",{
							params ["_box","_selection","_damage","_source","_projectile","_hitIndex","_instigator","_hitPoint"];
							if (_projectile isNotEqualTo "" && _projectile isNotEqualTo "HelicopterExploBig") then {
								private _toDie = [0.075,5] select isNull attachedTo _box;
								if (_damage > _toDie) then {
									_veh = _box getVariable "brpvp_veh";
									if (!isNull _veh) then {
										private _vehPos = getPosASL _box;
										detach _box;
										deleteVehicle _box;
										_veh setPosAsl _vehPos;
										[_veh,[0,0,1]] remoteExecCall ["setVectorUp",_veh];
										[_veh,false] remoteExecCall ["hideObjectGlobal",2];
										[_veh,true] remoteExecCall ["allowDamage",_veh];
										_veh setDamage 1;
										BRPVP_hulkBoxExploded = true;
									};
								};
							};
							0
						}];
						BRPVP_hulkBoxExploded = false;
						clearWeaponCargoGlobal _box;
						clearMagazineCargoGlobal _box;
						clearItemCargoGlobal _box;
						clearBackpackCargoGlobal _box;
						player setVariable ["brpvp_hulk_objs",[_box,_co],[clientOwner,2]];
						[_co,true] remoteExecCall ["hideObjectGlobal",2];
						[_co,false] remoteExecCall ["allowDamage",_co];
						[_co,true] remoteExecCall ["enableSimulationGlobal",2];
						_co setVariable ["brpvp_time_can_disable",serverTime+_hulkPillsTime+30,2];
						if (typeOf _co in BRPVP_vantVehiclesClass) then {
							_co spawn {
								waitUntil {
									_control = UAVControl _this;
									if (_control isNotEqualTo [objNull,""]) then {{if (_x isEqualType objNull) then {_x connectTerminalToUAV objNull;};} forEach _control;};
									!BRPVP_usedHulkPillsRunning
								};
							};
						};
						_hW = getPosWorld _box select 2;
						_hA = getPosASL _box select 2;
						_dH = (_hW-_hA)+0.5;
						_box attachTo [player,[0,0,_dH],"head"];
						player disableCollisionWith _box;
						[player,["hulk_get_veh",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
						[player,["hulk_drink",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
						BRPVP_hulkPillsActUsed = false;
						_actIdx = player addAction ["<t color='#F0C080'>"+localize "str_hulk_pills_release"+"</t>",{call BRPVP_usedHulkPillsRelease;},[_box,_co],2,true,true];
						[_box,_co,_actIdx,_hulkPillsTime] spawn {
							params ["_box","_co","_actIdx","_hulkPillsTime"];
							_init = time-1;
							waitUntil {
								_time = time;
								if (_time-_init >= 1) then {
									_init = _time;
									[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\hulk_pills_half.paa'/><br />%1",_hulkPillsTime],0,0,1,0,0,26528] call BRPVP_fnc_dynamicText;
									"ciclo" call BRPVP_playSound;
									_hulkPillsTime = _hulkPillsTime-1;
								};
								!(player call BRPVP_pAlive) || BRPVP_hulkPillsActUsed || _hulkPillsTime isEqualTo 0 || BRPVP_hulkBoxExploded
							};
							player removeAction _actIdx;
							if (!BRPVP_hulkPillsActUsed) then {
								_dir = getDir player;
								if (player call BRPVP_pAlive) then {
									[player,["hulk_sucumbed",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
									player setUnconscious true;
								};
								detach _box;
								[_box,[10*sin _dir,10*cos _dir,0]] remoteExecCall ["setVelocity",0];

								player setVariable ["brpvp_hulk_objs",[],[clientOwner,2]];
								BRPVP_usedHulkPillsRunning = false;

								if (!BRPVP_hulkBoxExploded) then {
									uiSleep 1;
									_pw = getPosWorld _box;
									_count = 0;
									waitUntil {
										_pwn = getPosWorld _box;
										if (_pwn isEqualTo _pw) then {_count = _count+1;};
										_pw = +_pwn;
										_count isEqualTo 5 || BRPVP_hulkBoxExploded
									};
									uiSleep 1;
									if (!BRPVP_hulkBoxExploded) then {
										_boxPW = getPosWorld _box;
										_lis = lineIntersectsSurfaces [_boxPW,_boxPW vectorAdd [0,0,-5],_box,objNull,true,1,"GEOM","NONE"];
										_vu = if (_lis isEqualTo []) then {[0,0,1]} else {_lis select 0 select 1};
										_box setVectorUp _vu;
										_pos = (getPosASL _box) vectorAdd [0,0,0.75];
										_box setPosATL [0,0,0];;
										[_co,10] call BRPVP_enableVehOnInteraction;
										[_co,_pos] remoteExecCall ["setPosASL",_co];
										[_co,_dir] remoteExecCall ["setDir",_co];
										[_co,_vu] remoteExecCall ["setVectorUp",_co];
										[_co,false] remoteExecCall ["hideObjectGlobal",2];
										private _init = diag_tickTime;
										waitUntil {
											if (vectorMagnitude velocity _co > 0.125) then {_init = diag_tickTime;};
											diag_tickTime-_init > 1.25
										};
										[_co,true] remoteExecCall ["allowDamage",_co];
										_co setVariable ["brpvp_time_can_disable",0,2];
										if !(_co getVariable ["slv",false]) then {_co setVariable ["slv",true,true];};
										deleteVehicle _box;
									};
								};
								if (lifeState player isEqualTo "INCAPACITATED") then {
									waitUntil {animationState player isEqualTo "unconsciousrevivedefault"};
									uiSleep (1.5+random 1.5);
									player setUnconscious false;
									uiSleep 0.001;
									[player,"UnconsciousOutProne"] remoteExecCall ["switchMove",0];
								};
							};
						};
						true
					};
				} else {
					"erro" call BRPVP_playSound;
					[localize "str_hulk_pills_cant_crew",-5] call BRPVP_hint;
					false
				};
			} else {
				"erro" call BRPVP_playSound;
				[localize "str_hulk_pills_cant_safezone",-5] call BRPVP_hint;
				false
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_hulk_pills_must_be_looking",-5] call BRPVP_hint;
			false
		};
	};
};
BRPVP_usedDroneFinder = {
	0 spawn {
		waitUntil {!BRPVP_menuExtraLigado};
		uiSleep 0.001;
		129 call BRPVP_iniciaMenuExtra;
	};
	true
};
BRPVP_usedBaseBomb = {
	if (BRPVP_baseBombStage isEqualTo 0) then {
		BRPVP_baseBombStage = 1;
		0 spawn {
			_lastObj = objNull;
			_toExplode = false;
			_objs = [];
			_obj = objNull;
			_drawCoords = [];
			_qttBomb = 1;
			_israidTraining = false;
			[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\base_bomb.paa'/><br />%1",localize "str_base_bomb_cancel"],0,0.25,36000,0,0,3318] call BRPVP_fnc_dynamicText;
			waitUntil {
				_stop = false;
				_vec = (AGLToASL positionCameraToWorld [0,0,1]) vectorDiff (AGLToASL positionCameraToWorld [0,0,0]) vectorMultiply 5;
				_posCam = AGLToASL positionCameraToWorld [0,0,0];
				_lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,BRPVP_myPlayerOrUAV,(attachedObjects BRPVP_myPlayerOrUAV+[objNull]) select 0,true,1,"VIEW","GEOM"];
				_foundObj = false;
				if (count _lis > 0) then {
					_obj = _lis select 0 select 2;
					_typeOf = typeOf _obj;
					_idx = BRPVP_kitGroupsCanDestroy find _typeOf;
					_classOk = _idx > -1;
					_idOk = (_obj getVariable ["id_bd",-1]) > -1;
					_exploId = _obj getVariable ["id_bd",-2];
					_notAgain = {(_x select 2) isEqualTo _exploId} count BRPVP_baseBombDestroyedLines isEqualTo 0;
					_israidTraining = _obj getVariable ["brpvp_rto",false];
					if (_classOk && ((_idOk && _notAgain) || _israidTraining)) then {
						_foundObj = true;
						_qttBomb = BRPVP_kitGroupsCanDestroyQtt select _idx;
						if (isNull _lastObj || _obj isNotEqualTo _lastObj) then {
							uiSleep 0.001;
							[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\base_bomb.paa'/><br />%1",format [localize "str_base_bomb_space",_qttBomb]],0,0.25,36000,0,0,3318] call BRPVP_fnc_dynamicText;
						};
						_objs = [];
						{if (typeOf _x isEqualTo _typeOf && !isObjectHidden _x) then {_objs pushBack _x;};} forEach nearestObjects [_obj,[],1];
						_drawCoords = [_objs,2,[1,0,0,1]] call BRPVP_getCubeDrawCoords;
						{{drawLine3D _x;} forEach (_x select 1);} forEach _drawCoords;
						if (BRPVP_baseBombStage isEqualTo 2) then {
							if (BRPVP_vePlayers) then {
								_stop = true;
								_toExplode = true;
							} else {
								_have = "BRPVP_baseBomb" call BRPVP_sitCountItem;
								if (_have >= _qttBomb-1) then {
									["BRPVP_baseBomb",_qttBomb-1] call BRPVP_sitRemoveItem;
									_stop = true;
									_toExplode = true;
								} else {
									BRPVP_baseBombStage = 1;
									[format [localize "str_bbomb_need_x",_qttBomb,_have+1],-4] call BRPVP_hint;
								};
							};
						};
						_lastObj = _obj;
					};
				};
				if (!_foundObj) then {
					if (BRPVP_baseBombStage isEqualTo 2) then {
						["",0,0,0,0,0,3318] call BRPVP_fnc_dynamicText;
						["BRPVP_baseBomb",1] call BRPVP_sitAddItem;
						_stop = true;
					} else {
						if (!isNull _lastObj) then {
							uiSleep 0.001;
							[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\base_bomb.paa'/><br />%1",localize "str_base_bomb_cancel"],0,0.25,36000,0,0,3318] call BRPVP_fnc_dynamicText;
						};
					};
					_lastObj = objNull;
				};
				_stop
			};
			if (_toExplode) then {
				for "_i" from 10 to 1 step -1 do {
					[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\base_bomb.paa'/><br /><t size='2.0'>%1</t>",_i],0,0.25,36000,0,0,3318] call BRPVP_fnc_dynamicText;
					"ciclo" call BRPVP_playSound;
					_init = time;
					waitUntil {
						{{drawLine3D _x;} forEach (_x select 1);} forEach _drawCoords;
						time-_init >= 1
					};
				};
				["",0,0,0,0,0,3318] call BRPVP_fnc_dynamicText;

				//EXPLOSION
				private _bb = boundingBoxReal _obj;
				private _bp1 = _bb select 0;
				private _bp2 = _bb select 1;
				private _sizeX = abs((_bp2 select 0)-(_bp1 select 0));
				private _sizeY = abs((_bp2 select 1)-(_bp1 select 1));
				private _sizeZ = abs((_bp2 select 2)-(_bp1 select 2));
				private _XYSize = _sizeX*_sizeY;
				private _XZSize = _sizeX*_sizeZ;
				private _YZSize = _sizeY*_sizeZ;
				private _sides = [_YZSize,_XZSize,_XYSize];
				private _halfArea = _YZSize+_XZSize+_XYSize;
				private _qtt = ceil (_sizeX*_sizeY*_sizeZ/10^3) max 3;
				for "_i" from 1 to _qtt do {
					private _randVec = [random _sizeX,random _sizeY,random _sizeZ];
					private _random = random _halfArea;
					private _sum = 0;
					{
						_sum = _sum+_x;
						if (_random < _sum) exitWith {_randVec set [_forEachIndex,([_sizeX,_sizeY,_sizeZ] select _forEachIndex)*selectRandom [0,1]];};
					} forEach _sides;
					private _posBomb = ASLToATL AGLToASL (_obj modelToWorld (_bp1 vectorAdd _randVec));
					createVehicle ["HelicopterExploBig",_posBomb,[],0,"CAN_COLLIDE"] setPosATL _posBomb;
					uiSleep random 0.125;
				};

				sleep 0.125;
				if (_israidTraining) then {
					{[_x,true] remoteExecCall ["hideObjectGlobal",2];} forEach _objs;
					//{deleteVehicle _x;} forEach _objs;
				} else {
					if (netId _obj isEqualTo "0:0") then {
						if (typeOf _obj in BRPVP_buildingHaveDoorListCVL) then {
							[[typeOf _obj],[_objs apply {_x getVariable ["id_bd",-1]}],true] remoteExecCall ["BRPVP_hideGlobalSimpleObjectCVL",0];
						} else {
							[[typeOf _obj],[_objs apply {_x getVariable ["id_bd",-1]}],true] remoteExecCall ["BRPVP_hideGlobalSimpleObject",0];
						};
					} else {
						{[_x,true] remoteExecCall ["hideObjectGlobal",2];} forEach _objs;
					};

					{
						private _exec = "_this call BRPVP_serverHideBombedObject;";
						private _vrColors = _x getVariable ["brpvp_vr_colors",[]];
						if (_vrColors isNotEqualTo []) then {_exec = _exec+format ["[_this,'%1','%2'] call BRPVP_vrObjectSetTextures;",_vrColors#0,_vrColors#1];};
						[_x getVariable ["id_bd",-1],_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
					} forEach _objs;

					//TURN INTO BANDIT IF IN PVE ZONE AND LOG INVASION
					_obj call BRPVP_turnIntoBandit;
					[_obj getVariable "own",player getVariable "id_bd",player getVariable "nm",typeOf _obj,getPosWorld _obj] remoteExecCall ["BRPVP_logBaseInvasion",2];

					//SET FLAG TO NO CONSTRUCTION
					if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
						private _flag = _obj call BRPVP_nearestFlagInsideWithAccess;
						if (isNull _flag) then {_flag = _obj call BRPVP_nearestFlagInside;};
						if (!isNull _flag) then {
							_flag setVariable ["brpvp_last_intrusion",serverTime,true];
							if (BRPVP_useDiscordEmbedBuilder) then {_flag remoteExecCall ["BRPVP_messageDiscordRaid",2];};
						};
					};
				};
				_drawCoords remoteExecCall ["BRPVP_baseBombAddLines",0];
				_players = _obj nearEntities [BRPVP_playerModel,300];
				if (_players isNotEqualTo []) then {remoteExecCall ["BRPVP_baseBombCalcVisibleLines",_players];};

				//HINT PEOPLE ABOUT THE INVASION
				[player,getPosWorld _obj,serverTime] remoteExecCall ["BRPVP_lockPickedBuildingsServerAdd",2];
			};
			BRPVP_baseBombStage = 0;
		};
		true
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_personalTracerUsedOneTime = false;
BRPVP_usePersonalTracer = {
	if (BRPVP_tracerUse) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_tracerUse = true;
		player setVariable ["brpvp_tracer_on",true,true];
		if (!BRPVP_personalTracerUsedOneTime) then {
			[player,["FiredMan",{call BRPVP_tracerOtherPlayers;}]] remoteExecCall ["addEventHandler",BRPVP_allNoServer,true];
			BRPVP_personalTracerUsedOneTime = true;
		};
		[localize "str_tracer_used",-6] call BRPVP_hint;
		true
	};
};
BRPVP_useHouseGodMode = {
	_vec = (getCameraViewDirection player) vectorMultiply 5;
	_posCam = AGLToASL positionCameraToWorld [0,0,0];
	_lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,1,"GEOM","FIRE"];
	if (count _lis > 0) then {
		_obj = _lis select 0 select 2;
		if (_obj getVariable ["brpvp_map_god_mode_house_id",-1] isEqualTo -1) then {
			_isMap = (_obj getVariable ["id_bd",-1]) isEqualTo -1;
			_isInterior = count (_obj buildingPos -1) > 0;
			_isHouse = _obj isKindOf "House";
			_isUp = damage _obj < 0.5;
			_isMyFlag = BRPVP_myBaseState isEqualTo 2;
			_isExtra = typeOf _obj in BRPVP_extraGodModeHouse;
			_haveDoors = {_x find "door_" isEqualTo 0 || _x find "Door_" isEqualTo 0} count animationNames _obj > 0;
			if (_isMap && (_isInterior || _isExtra) && (_isHouse || (_isExtra && _haveDoors)) && _isUp && _isMyFlag) then {
				private _own = player getVariable "id_bd";
				private _stp = player getVariable "dstp";
				private _amg = [player getVariable ["amg",[]],[],true];
				_obj setVariable ["own",_own,true];
				_obj setVariable ["stp",_stp,true];
				_obj setVariable ["amg",_amg,true];
				_obj remoteExecCall ["BRPVP_godModeHouseAddObj",0];
				[typeOf _obj,getPosWorld _obj,_obj,_own,_stp,_amg] remoteExecCall ["BRPVP_addGodModHouseInDb",2];
				[_obj,false] remoteExecCall ["allowDamage",0,true];
				"ugranted" call BRPVP_playSound;
				[localize "str_house_set_to_gm",-6] call BRPVP_hint;
				true
			} else {
				[localize "str_cant_gm_this_house",-5] call BRPVP_hint;
				"erro" call BRPVP_playSound;
				false
			};
		} else {
			[localize "str_map_house_have_gm",-6] call BRPVP_hint;
			"erro" call BRPVP_playSound;
			false
		};
	} else {
		[localize "str_cant_gm_must_look_house",-5] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_useAntiBaseBomb = {
	private _near = [];
	private _vecLimit = 5;
	private _posCam = AGLToASL positionCameraToWorld [0,0,0];
	private _posCamAGL = positionCameraToWorld [0,0,0];
	private _nearRuineds = (nearestObjects [BRPVP_myPlayerOrUAV,[],50]) select {_x getVariable ["id_bd",-1] isNotEqualTo -1 && _posCamAGL distance _x < 0.5*(boundingBoxReal _x select 2)+_vecLimit};
	private _nearRuinedsId = _nearRuineds apply {_x getVariable "id_bd"};
	{
		private _idx = _nearRuinedsId find (_x select 2);
		if (_idx isNotEqualTo -1) then {if ((_x select 3) isEqualTo "red") then {_near pushBack (_nearRuineds select _idx);};};
	} forEach BRPVP_baseBombDestroyedLines;
	if (_near isEqualTo []) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		private _lis = [];
		private _vec = (AGLToASL positionCameraToWorld [0,0,1]) vectorDiff _posCam vectorMultiply _vecLimit;
		private _nearInside = _near select {[_posCamAGL,_x] call PDTH_pointIsInBox};
		private _nearNotInside = _near-_nearInside;
		if (_nearNotInside isNotEqualTo []) then {
			for "_i" from 0 to 100 step 2 do {
				private _pntTest = ASLToAGL (_posCam vectorAdd (_vec vectorMultiply (_i/100)));
				{if ([_pntTest,_x] call PDTH_pointIsInBox) exitWith {_lis = [[0,0,_x]];};} forEach _nearNotInside;
				if (_lis isNotEqualTo []) exitWith {};
			};
		};
		if (_lis isEqualTo [] && _nearInside isNotEqualTo []) then {
			_nearInside = _nearInside apply {[boundingBoxReal _x select 2,_x]};
			_nearInside sort true;
			_nearInside = _nearInside apply {_x select 1};
			_lis = [[0,0,_nearInside select 0]];
		};
		if (_lis isNotEqualTo []) then {
			private _obj = _lis select 0 select 2;
			if (_obj in _near) then {
				_oId = _obj getVariable ["id_bd",-1];
				if (netId _obj isEqualTo "0:0") then {
					if (typeOf _obj in BRPVP_buildingHaveDoorListCVL) then {
						[[typeOf _obj],[[_oId]],false] remoteExecCall ["BRPVP_hideGlobalSimpleObjectCVL",0];
					} else {
						[[typeOf _obj],[[_oId]],false] remoteExecCall ["BRPVP_hideGlobalSimpleObject",0];
					};
				} else {
					[_obj,false] remoteExecCall ["hideObjectGlobal",2];
				};
				private _vrColors = _obj getVariable ["brpvp_vr_colors",[]];
				if (_vrColors isEqualTo []) then {
					[_oId,""] remoteExecCall ["BRPVP_updateTurretExec",2];
				} else {
					private _exec = format ["[_this,'%1','%2'] call BRPVP_vrObjectSetTextures;",_vrColors#0,_vrColors#1];
					[_oId,_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
				};
				_oId remoteExecCall ["BRPVP_baseBombChangeToGreen",0];
				remoteExecCall ["BRPVP_baseBombCalcVisibleLines",BRPVP_allNoServer];

				//SET FLAG TO NO CONSTRUCTION
				if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
					private _flag = _obj call BRPVP_nearestFlagInsideWithAccess;
					if (isNull _flag) then {_flag = _obj call BRPVP_nearestFlagInside;};
					if (!isNull _flag) then {
						if ([_flag] call BRPVP_isFlagsInRaidMode) then {_flag setVariable ["brpvp_last_intrusion",serverTime,true];};
					};
				};

				true
			} else {
				"erro" call BRPVP_playSound;
				false
			};
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	};
};
BRPVP_useIntoBanditTime = -15;
BRPVP_useIntoBandit = {
	if (BRPVP_pveAllowBandit) then {
		if (player getVariable ["brpvp_pve_inside",0] isEqualTo 0) then {
			[localize "str_must_be_in_pve",-5] call BRPVP_hint;
			false
		} else {
			if (player in BRPVP_pveBanditObjList) then {
				[localize "str_already_bandit",-5] call BRPVP_hint;
				false
			} else {
				objNull call BRPVP_turnIntoBandit;
				true
			};
		};
	} else {
		if (time-BRPVP_useIntoBanditTime > 15) then {
			[localize "str_bandit_use_again_to_money",-6] call BRPVP_hint;
			BRPVP_useIntoBanditTime = time;
			false
		} else {
			player setVariable ["mny",(player getVariable ["mny",0])+BRPVP_pveBanditPrice,true];
			"negocio" call BRPVP_playSound;
			call BRPVP_atualizaDebug;
			BRPVP_useIntoBanditTime = time;
			true
		};
	};
};
BRPVP_useBaseTest = {
	_state = player getVariable ["brpvp_base_test",0];
	if (_state in [1,2]) then {
		[localize "str_base_test_already",-5] call BRPVP_hint;
		false
	} else {
		player setVariable ["brpvp_base_test",1,true];
		[localize "str_base_test_used",-8] call BRPVP_hint;
		BRPVP_baseTestAction = player addAction ["<t color='#CC5555'>"+localize "str_stop_base_test"+"</t>",{call BRPVP_baseTestTurnOff;},nil,1.5,false];
		true
	};
};
BRPVP_useNoGrass = {
	if (getPosATL player select 2 < 0.05) then {
		if (isOnRoad ASLToAGL getPosASL player) then {
			"erro" call BRPVP_playSound;
			false
		} else {
			if (isNull objectParent player) then {
				private _dir = getDir player;
				private _vec = [10*sin _dir,10*cos _dir,0];
				private _gCutter = createSimpleObject ["Land_Dome_Big_F",BRPVP_posicaoFora];
				_gCutter hideObject true;
				[_gCutter,true] remoteExecCall ["hideObjectGlobal",2];
				_gCutter setPosASL (getPosASL player vectorAdd _vec);
				[_gCutter] remoteExecCall ["BRPVP_grassCutObjsAdd",2];
				[localize "str_grass_removed",-3,200,0,"garden_shears"] call BRPVP_hint;
				true
			} else {
				"erro" call BRPVP_playSound;
				false
			};
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_useItemPaintVehicle = {
	_co = cursorObject;
	if (_co call BRPVP_isMotorizedNoTurret && isNull objectParent player && _co distance player < 15 && alive _co) then {
		_isPaint = _co getVariable ["brpvp_paint_enabled",false];
		_textures = getObjectTextures _co;
		_idP = player getVariable ["id_bd",-1];
		_ownV = _co getVariable ["own",-1];
		if (_idP isEqualTo _ownV && !_isPaint && count _textures > 0) then {
			_co setVariable ["brpvp_paint_enabled",true,true];
			[_co getVariable ["id_bd",-1],getObjectTextures _co] remoteExecCall ["BRPVP_paintVehicleSaveChange",2];
			[localize "str_paint_enabled",-6,200,0,"granted"] call BRPVP_hint;
			true
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_useItemPaintThinner = {
	_co = cursorObject;
	if (_co call BRPVP_isMotorizedNoTurret && isNull objectParent player && _co distance player < 15 && alive _co) then {
		_isPaint = _co getVariable ["brpvp_paint_enabled",false];
		_idP = player getVariable ["id_bd",-1];
		_ownV = _co getVariable ["own",-1];
		if (_idP isEqualTo _ownV && _isPaint) then {
			_veh = createVehicle [typeOf _co,[0,0,2000],[],150,"CAN_COLLIDE"];
			{_co setObjectTextureGlobal [_forEachIndex,_x];} forEach getObjectTextures _veh;
			deleteVehicle _veh;
			_co setVariable ["brpvp_paint_enabled",false,true];
			[_co getVariable ["id_bd",-1],[]] remoteExecCall ["BRPVP_paintVehicleSaveChange",2];
			"granted" call BRPVP_playSound;
			true
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_useItemClimb = {
	if (BRPVP_climbOn) then {
		[localize "str_base_test_already",-5] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		false
	} else {
		[true,player getVariable "id_bd"] remoteExecCall ["BRPVP_climbActivePlayersAdd",2];
		BRPVP_climbOn = true;
		[localize "str_climb_you_can",-5] call BRPVP_hint;
		"ugranted" call BRPVP_playSound;
		true
	};
};
BRPVP_usedFood = {
	if (BRPVP_alimentacao <= 95 || time-BRPVP_lastTimeEat > 300) then {
		private _new = 100;
		if (_this isEqualTo "BRPVP_foodWater") then {[player,["BRPVP_drinking",150]] remoteExecCall ["say3D",BRPVP_allNoServer];} else {[player,["BRPVP_eating",150]] remoteExecCall ["say3D",BRPVP_allNoServer];};
		if (_this isEqualTo "BRPVP_foodBurger") then {player setDamage 0;_new = 125;};
		BRPVP_alimentacao = _new max BRPVP_alimentacao;
		player setVariable ["sud",[BRPVP_alimentacao,100],[clientOwner,2]];
		[["comeu",1]] call BRPVP_mudaExp;
		BRPVP_lastTimeEat = time;
		true
	} else {
		[localize "str_brpvp_not_hungry",-5] call BRPVP_hint;
		false
	};
};
BRPVP_usedEnergetic = {
	_timeLeft = BRPVP_energeticEndTime-time;
	if (_timeLeft <= 0) then {
		BRPVP_alimentacao = 110;
		player setVariable ["sud",[BRPVP_alimentacao,100],[clientOwner,2]];
		[player,["BRPVP_drinking",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
		BRPVP_energeticEndTime = time+BRPVP_foodEnergeticTime;
		[["comeu",1]] call BRPVP_mudaExp;
		true
	} else {
		_timeLeftTxt = if (_timeLeft <= 60) then {str (round _timeLeft)+" "+localize "str_seconds"} else {str round (_timeLeft/60)+" "+localize "str_minutes"};
		[format [localize "str_brpvp_energetic_left",_timeLeftTxt],-6] call BRPVP_hint;
		false
	};
};
BRPVP_playerLaunchUsing = false;
BRPVP_usedPlayerLaunch = {
	private _floorNotWater = !surfaceIsWater getPosWorld player && position player select 2 < 0.25;
	private _floorOnWater = surfaceIsWater getPosWorld player && position player select 2 < 0.25 && (ASLToAGL getPosASL player select 2) > 0.25;
	if (!BRPVP_playerLaunchUsing && player call BRPVP_pAlive && (_floorNotWater || _floorOnWater) && !BRPVP_safeZone && !BRPVP_possOtherPlayer) then {
		private _pos = getPosWorld player vectorAdd [0,0,0.5];
		private _lis = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,500],player,objNull];
		if (_lis isEqualTo []) then {
			BRPVP_playerLaunchUsing = true;
			0 spawn {
				private _sg1 = createVehicle ["SmokeShellYellow",[0,0,0],[],0,"NONE"];
				private _sg2 = createVehicle ["SmokeShellOrange",[0,0,0],[],0,"NONE"];
				_sg1 attachTo [player,[0,0.3,0]];
				_sg2 attachTo [player,[0,0.3,0]];
				uiSleep 2;
				if (player call BRPVP_pAlive) then {
					BRPVP_allowSecondJump = false;
					player allowDamage false;
					BRPVP_plauncherExplodeBombOk = false;
					private _dir = getDir player;
					[player,[0,0,0]] remoteExecCall ["BRPVP_plauncherExplodeBomb",2];
					waitUntil {BRPVP_plauncherExplodeBombOk};
					_sg1 attachTo [player,[0,0,0],"lefthand"];
					_sg2 attachTo [player,[0,0,0],"righthand"];
					[_sg1,true] remoteExecCall ["hideObjectGlobal",2];
					[_sg2,true] remoteExecCall ["hideObjectGlobal",2];

					private _init = diag_tickTime;
					private _velocity = [50*sin _dir,50*cos _dir,550];
					waitUntil {
						player setVelocity (_velocity vectorAdd [0,0,-(diag_tickTime-_init)*10]);
						diag_tickTime-_init > 0.4
					}; 
					player allowDamage true;
					waitUntil {
						player setVelocity (_velocity vectorAdd [0,0,-(diag_tickTime-_init)*10]);
						diag_tickTime-_init > 1.5
					}; 

					waitUntil {
						BRPVP_paraParamH = 1500;
						velocity player select 2 < 0 || !(player call BRPVP_pAlive)
					};
					waitUntil {getPos player select 2 < 0.25 || !(player call BRPVP_pAlive)};
					deleteVehicle _sg1;
					deleteVehicle _sg2;
					BRPVP_allowSecondJump = true;
				} else {
					[player,[0,0,0]] remoteExecCall ["BRPVP_plauncherExplodeBomb",2];
					deleteVehicle _sg1;
					deleteVehicle _sg2;
				};
				BRPVP_playerLaunchUsing = false;
			};
			true
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_usedPlayerLaunchSuper = {
	private _floorNotWater = !surfaceIsWater getPosWorld player && position player select 2 < 0.25;
	private _floorOnWater = surfaceIsWater getPosWorld player && position player select 2 < 0.25 && (ASLToAGL getPosASL player select 2) > 0.25;
	if (!BRPVP_playerLaunchUsing && player call BRPVP_pAlive && (_floorNotWater || _floorOnWater) && !BRPVP_safeZone && !BRPVP_possOtherPlayer) then {
		private _pos = getPosWorld player vectorAdd [0,0,0.5];
		private _lis = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,500],player,objNull];
		if (_lis isEqualTo []) then {
			BRPVP_playerLaunchUsing = true;
			0 spawn {
				private _sg1 = createVehicle ["SmokeShellYellow",[0,0,0],[],0,"NONE"];
				private _sg2 = createVehicle ["SmokeShellOrange",[0,0,0],[],0,"NONE"];
				_sg1 attachTo [player,[0,0.3,0]];
				_sg2 attachTo [player,[0,0.3,0]];
				uiSleep 2;
				if (player call BRPVP_pAlive) then {
					BRPVP_allowSecondJump = false;
					player allowDamage false;
					BRPVP_plauncherExplodeBombOk = false;
					private _dir = getDir player;
					[player,[0,0,0]] remoteExecCall ["BRPVP_plauncherExplodeBomb",2];
					waitUntil {BRPVP_plauncherExplodeBombOk};
					_sg1 attachTo [player,[0,0,0],"lefthand"];
					_sg2 attachTo [player,[0,0,0],"righthand"];
					[_sg1,true] remoteExecCall ["hideObjectGlobal",2];
					[_sg2,true] remoteExecCall ["hideObjectGlobal",2];

					private _init = diag_tickTime;
					private _velocity = [50*sin _dir,50*cos _dir,550];
					waitUntil {
						player setVelocity (_velocity vectorAdd [0,0,-(diag_tickTime-_init)*10]);
						diag_tickTime-_init > 0.4
					}; 
					player allowDamage true;
					waitUntil {
						player setVelocity (_velocity vectorAdd [0,0,-(diag_tickTime-_init)*10]);
						diag_tickTime-_init > 1.5
					}; 

					waitUntil {
						BRPVP_paraParamH = 1500;
						velocity player select 2 < 0 || !(player call BRPVP_pAlive)
					};

					//SECOND EXPLOSION
					private _init = 0;
					private _cnt = 5;
					waitUntil {
						if (diag_tickTime-_init > 5 && _cnt > 0) then {
							_cnt = _cnt-1;
							_init = diag_tickTime;

							private _dir = getDir player;
							BRPVP_plauncherExplodeBombOk = false;
							player allowDamage false;
							[player,[17.5*sin (_dir+180),17.5*cos (_dir+180),0]] remoteExecCall ["BRPVP_plauncherExplodeBomb",2];
							waitUntil {BRPVP_plauncherExplodeBombOk};
							[player,["explosion_recharge",800]] remoteExecCall ["say3D",0];
							uiSleep 0.15;
							[player,[1500*sin _dir,1500*cos _dir,25]] remoteExecCall ["setVelocity",0];
							uiSleep 0.25;
							player allowDamage true;
						};
						getPos player select 2 < 0.25 || !(player call BRPVP_pAlive) || !isNull objectParent player
					};
					deleteVehicle _sg1;
					deleteVehicle _sg2;
					BRPVP_allowSecondJump = true;
				} else {
					[player,[0,0,0]] remoteExecCall ["BRPVP_plauncherExplodeBomb",2];
					deleteVehicle _sg1;
					deleteVehicle _sg2;
				};
				BRPVP_playerLaunchUsing = false;
			};
			true
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_usedBagSoldier = {
	private _d = getDir player;
	private _p = getPosASL player;
	private _onBuilding = getPosATL player select 2 > 0.25;
	private _front = if (_onBuilding) then {[(_p select 0)+2*sin _d,(_p select 1)+2*cos _d,_p select 2]} else {AGLToASL ([player,2,getDir player] call BIS_fnc_relPos);};
	private _agnt = createAgent ["C_Nikos",[0,0,0],[],0,"CAN_COLLIDE"];
	_agnt setPosASL _front;
	_agnt setDir (getDir player-180);
	_agnt disableAI "ALL";
	_agnt setVariable ["brpvp_can_punch",false,true];
	_agnt setVariable ["brpvp_bag_soldier",true,true];
	_agnt setVariable ["brpvp_key",0,[clientOwner,2]];
	[_agnt,["HandleDamage",{call BRPVP_bagSoldierDamage;}]] remoteExecCall ["addEventHandler",[clientOwner,2]];
	true
};
BRPVP_usedCarrier = {
	0 spawn {
		waitUntil {!BRPVP_menuExtraLigado};
		BRPVP_carrierByTrader = false;
		uiSleep 0.001;
		155 call BRPVP_iniciaMenuExtra;
	};
	true
};
BRPVP_baseMineIdx = 0;
BRPVP_usedBaseMine = {
	if (isNull objectParent player) then {
		private _pm = getPosASL player vectorAdd [0,0,1.65];
		private _pd = getDir player;
		_pm = [(_pm select 0)+0.5*sin _pd,(_pm select 1)+0.5*cos _pd,_pm select 2];
		private _lis = lineIntersectsSurfaces [_pm,_pm vectorAdd [0,0,-2.5],player];
		if (_lis isEqualTo [] || (count _lis > 0 && {vectorMagnitude ((_lis select 0 select 0) vectorDiff _pm) < 0.01})) then {
			"erro" call BRPVP_playSound;
			false
		} else {
			private _nm = nearestObjects [ASLToAGL _pm,["Land_Can_V2_F"],10] apply {if (_x getVariable ["brpvp_mine_base",false]) then {_x} else {-1};};
			_nm = _nm-[-1];
			if (_nm isEqualTo []) then {
				_pm = _lis select 0 select 0;
				private _flag = ASLToAGL _pm call BRPVP_nearestFlagInside;
				private _flagOk = if (isNull _flag) then {
					true
				} else {
					if ([player,_flag] call BRPVP_checaAcessoRemotoFlag) then {
						private _rad = _flag getVariable ["brpvp_flag_radius",0];
						private _mof = nearestObjects [_flag,["Land_Can_V2_F"],_rad,true] apply {if (_x getVariable ["brpvp_mine_base",false]) then {_x} else {-1};};
						_mof = _mof-[-1];
						private _limit = 0;
						{if (_x select 0 isEqualTo _rad) exitWith {_limit = _x select 1;};} forEach BRPVP_fantaMinesTerrainLimit;
						count _mof < _limit
					} else {
						false
					};
				};
				private _limOk = if (isNull _flag) then {
					private _noFlag = 0;
					{if !(_x getVariable ["brpvp_mine_base_in_flag",false]) then {_noFlag = _noFlag+1;};} forEach (BRPVP_frantaAllObjsMy-[objNull]);
					_noFlag < BRPVP_fantaMinesOutTerrainLimitPerPlayer
				} else {
					true
				};
				if (_flagOk && _limOk) then {
					private _mine = createVehicle ["Land_Can_V2_F",[0,0,0],[],10,"CAN_COLLIDE"];
					_mine setPosASL _pm;
					_mine setVectorUp [0,0,1];
					"granted" call BRPVP_playSound;
					private _id = player getVariable "id_bd";
					private _fantaAmg = (player getVariable ["amg",[]])+[_id];
					_mine setVariable ["brpvp_mine_base",true,true];
					_mine setVariable ["brpvp_mine_base_owner",_id,true];
					_mine setVariable ["brpvp_mine_base_friends",_fantaAmg,true];
					_mine setVariable ["brpvp_mine_base_in_flag",!isNull _flag,true];
					[_mine,false] remoteExecCall ["enableSimulationGlobal",2];
					[_mine,_id,_fantaAmg,getPosWorld _mine,!isNull _flag] remoteExecCall ["BRPVP_fantaMineAddDb",2];
					_mine remoteExecCall ["BRPVP_frantaAllObjsAdd",BRPVP_allNoServer];
					call BRPVP_recalcMyFrantaMines;
					BRPVP_baseMineIdx = BRPVP_baseMineIdx+1;
					true
				} else {
					if (!isNull _flag && !_flagOk) then {[localize "str_base_mine_cant_flag_limit",-6,200,0,"erro"] call BRPVP_hint;};
					if (isNull _flag && !_limOk) then {[localize "str_base_mine_cant_no_flag_limit",-6,200,0,"erro"] call BRPVP_hint;};
					"erro" call BRPVP_playSound;
					false
				};
			} else {
				private _dist = round (ASLToAGL _pm distance (_nm select 0)) max 0.5;
				[format [localize "str_bmine_cant_have_near",_dist],-5,200,0,"erro"] call BRPVP_hint;
				[BRPVP_baseMineIdx,_nm select 0] spawn {
					params ["_idx","_obj"];
					sleep 0.1;
					waitUntil {
						private _p1 = getPosASL player vectorAdd [0,0,0.8];
						private _pd = getDir player;
						_p1 = ASLToAGL [(_p1 select 0)+1*sin _pd,(_p1 select 1)+1*cos _pd,_p1 select 2];
						private _p2 = ASLToAGL getPosASL _obj;
						private _dist = _p1 distance _p2;
						drawLine3D [_p1,_p2,if (_dist <= 10) then {[1,0,0,1]} else {[0,1,0,1]}];
						isNull _obj || _dist > 35 || BRPVP_baseMineIdx > _idx || !(player call BRPVP_pAlive) || !isNull objectParent player
					};
				};
				false
			};
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_usedBaseMineDefuse = {
	[localize "str_base_mine_info",-8] call BRPVP_hint;
	false
};
BRPVP_usedVehicleAmmo = {
	private _veh = objectParent player;
	_veh = if (isNull _veh) then {
		private _obj = cursorObject;
		if (_obj call BRPVP_isMotorized && _obj distanceSqr player < 64) then {_obj} else {objNull}; 
	} else {
		_veh
	};
	if (isNull _veh) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		if (_veh isKindOf "HTNK") then {
			"hackFail" call BRPVP_playSound;
			false
		} else {
			private _beforeAmmo = magazinesAllTurrets _veh;
			_veh setVehicleAmmo 1;
			private _afterAmmo = magazinesAllTurrets _veh;
			if (_afterAmmo isEqualTo _beforeAmmo) then {
				"erro" call BRPVP_playSound;
				false
			} else {
				"granted" call BRPVP_playSound;
				true
			};
		};
	};
};
BRPVP_usedTurretUpgrade = {
	[localize "str_up_turret_item_descr",-6] call BRPVP_hint;
	false
};
BRPVP_usedXrayItem = {
	if (BRPVP_xrayOn) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_xrayOn = true;
		0 spawn {
			private _colors = ["#000000","#FFFFFF"];
			private _colorIdx = 0;
			private _init = time;
			private _initSnd = time;
			private _count = 90;
			[format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xray.paa'/><br /><t size='1.5'>%1</t>",_count],0,0,36000,0,0,2518] call BRPVP_fnc_dynamicText;
			if (!BRPVP_crosshairOn) then {["<img color='"+(_colors select _colorIdx)+"' shadow='0' size='0.2' image='"+BRPVP_imagePrefix+"BRP_imagens\draw_map\mil_dot.paa'/>",0,0.4945,1.25,0,0,2527] call BRPVP_fnc_dynamicText;};
			"ciclo" call BRPVP_playSound;
			private _action = player addAction [format ["<t color='#FF0000'>%1</t>",localize "str_stop_xray"],{BRPVP_xrayOn = false;},objNull,2,false,true];
			_count = _count-1;
			_sounder = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],10,"CAN_COLLIDE"];
			_sounder attachTo [player,[0,0,0]];
			[_sounder,["xray",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
			waitUntil {
				if (time-_initSnd > 5) then {
					[_sounder,["xray",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
					_initSnd = time;
				};
				if (time-_init > 1) then {
					_init = time;
					_colorIdx = 1-_colorIdx;
					[format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xray.paa'/><br /><t size='1.5'>%1</t>",_count],0,0,36000,0,0,2518] call BRPVP_fnc_dynamicText;
					if (!BRPVP_crosshairOn) then {["<img color='"+(_colors select _colorIdx)+"' shadow='0' size='0.2' image='"+BRPVP_imagePrefix+"BRP_imagens\draw_map\mil_dot.paa'/>",0,0.4945,1.25,0,0,2527] call BRPVP_fnc_dynamicText;};
					"ciclo" call BRPVP_playSound;
					_count = _count-1;
				};
				!(player call BRPVP_pAlive) || _count isEqualTo -1 || !BRPVP_xrayOn || (currentWeapon player isNotEqualTo "" && false)
			};
			deleteVehicle _sounder;
			["",0,0,0,0,0,2518] call BRPVP_fnc_dynamicText;
			if (!BRPVP_crosshairOn) then {["",0,0,0,0,0,2527] call BRPVP_fnc_dynamicText;};
			player removeAction _action;
			if (currentWeapon player isNotEqualTo "") then {"erro" call BRPVP_playSound;};
			BRPVP_xrayOn = false;
		};
		true
	};
};
BRPVP_usedItemMagnet = {
	if (BRPVP_itemMagnetOn || BRPVP_carryingBox) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_itemMagnetOn = true;
		BRPVP_itemMagnetOnAction1 = player addAction ["<t color='#FF0000'>"+localize "str_item_magnet_recharge"+"</t>",{player call BRPVP_itemMagnetRecharge;},-1,2.1,false,true];
		BRPVP_itemMagnetOnAction2 = player addAction ["<t color='#FF0000'>"+localize "str_item_magnet_off"+"</t>",{player call BRPVP_itemMagnetOff;},-1,2.0,false,true];
		true
	};
};
BRPVP_usedNewsPaper = {
	private _discount = selectRandom [0.95,0.95,0.95,0.95,0.9,0.9,0.9,0.85,0.85,0.8];
	if (random 1 < 0.75 && _discount < BRPVP_specialItemsKitPriceMult) then {
		BRPVP_specialItemsKitPriceMult = _discount;
		"granted" call BRPVP_playSound;
		["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\coupon.paa'/><br/>"+format [localize "str_cad_alti_journal_discount",100*(1-BRPVP_specialItemsKitPriceMult),"%"],0,0.4,5.5,0,0,32457] call BRPVP_fnc_dynamicText;
	} else {
		["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\coupon_no.paa'/><br/>"+localize "str_no_coupon_found",0,0.4,3.5,0,0,32457] call BRPVP_fnc_dynamicText;
	};
	0 spawn {
		waitUntil {!BRPVP_menuExtraLigado};
		BRPVP_classAdVehicleListReturn = nil;
		BRPVP_classAdItemListReturn = nil;
		uiSleep 0.001;
		193 call BRPVP_iniciaMenuExtra;
	};
	true
};
BRPVP_spawnZombiesTimer = 0;
BRP_usedZombieSpawn = {
	private _inPVE = player getVariable ["brpvp_pve_inside",0] isNotEqualTo 0;
	private _inPVP = player getVariable ["brpvp_in_pvp_zone",0] isNotEqualTo 0;
	if (!(_inPVP || _inPVE) || _inPVP || BRPVP_spawnZombiesItemOnPve) then {
		private _tickTime = diag_tickTime;
		if (_tickTime < BRPVP_spawnZombiesTimer) then {
			[format [localize "str_spawn_zombie_cant_time",ceil (BRPVP_spawnZombiesTimer-_tickTime)],-5] call BRPVP_hint;
			"erro" call BRPVP_playSound;
			false
		} else {
			private _nearZombies = BRPVP_myPlayerOrUAV nearEntities ["C_man_p_shorts_1_F",250];
			if (count _nearZombies >= BRPVP_spawnZombiesItemMaxNearZombies) then {
				[localize "str_spawn_zombie_cant_much",-5] call BRPVP_hint;
				false
			} else {
				BRPVP_spawnZombiesTimer = _tickTime+BRPVP_spawnZombiesItemCoolDown;
				private _nearMans1 = BRPVP_myPlayerOrUAV nearEntities [["SoldierWB","SoldierGB"],375];
				private _nearMans2 = BRPVP_myPlayerOrUAV nearEntities [[BRPVP_playerModel],250];
				private _nearMans = _nearMans1+_nearMans2;
				private _nearMans = _nearMans arrayIntersect _nearMans;
				private _deny = [player];
				{if (_x distance BRPVP_myPlayerOrUAV < 75) then {_deny pushBack _x;};} forEach BRPVP_meusAmigosObj;
				_nearMans = _nearMans-_deny;
				if (_nearMans isEqualTo []) then {_nearMans = _deny;};
				_ps1 = "#particlesource" createVehicle ASLToAGL getPosASL BRPVP_myPlayerOrUAV;
				_ps2 = "#particlesource" createVehicle ASLToAGL getPosASL BRPVP_myPlayerOrUAV;
				_ps1 setParticleClass "HouseDestrSmokeLongSmall";
				_ps2 setParticleClass "HouseDestrSmokeLongSmall";
				[4,[_ps1,_ps2]] remoteExecCall ["BRPVP_deleteAfterTime",2];
				[_nearMans,ASLtoAGL getPosASL BRPVP_myPlayerOrUAV] spawn {
					params ["_nearMans","_pos"];
					sleep 3;
					[[_pos,10,6.5,[2,3,3,4],_nearMans]] remoteExecCall ["BRPVP_spawnZombiesServerFromClientInFront",2];
				};
				true
			};
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_uPackUsing = false;
BRPVP_upackCancel = {
	"erro" call BRPVP_playSound;
	["BRPVP_uberPack",1] call BRPVP_sitAddItem;
	private _bpc = backPackContainer player;
	if (!isNull _bpc) then {[_bpc,false] remoteExecCall ["hideObjectGlobal",2];};
	detach _tank;
	deleteVehicle _tank;
	BRPVP_uPackUsing = false;
	BRPVP_walkDisabled = false;
	if (visibleMap && BRPVP_uPackSelected isEqualTo [0,0,0]) then {openMap false;};
};
BRPVP_usedUberPack = {
	if (BRPVP_uPackUsing || BRPVP_possOtherPlayer) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		if (getPos player select 2 < 0.25 && (ASLToAGL getPosASL player) select 2 >= 0) then {
			BRPVP_uPackUsing = true;
			BRPVP_walkDisabled = true;
			BRPVP_uPackSelected = nil;

			//CREATE TANK
			private _bpc = backPackContainer player;
			if (!isNull _bpc) then {[_bpc,true] remoteExecCall ["hideObjectGlobal",2];};
			private _tank = "Land_GasTank_01_khaki_F" createVehicle [0,0,0];
			_tank attachTo [player,[0,-0.325,-0.15],"spine3",true];
			_tank setVectorUp [0,-0.125,-1];

			_tank spawn {
				private _landReached = false;
				private _tank = _this;
				private _mdId = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{
					private _scale = ctrlMapScale (_this select 0);
					private _img = BRPVP_missionRoot+"BRP_imagens\uber_pack_destine.paa";
					private _mpw = _this select 0 ctrlMapScreenToWorld getMousePosition;
					private _dir = [player,_mpw+[0]] call BIS_fnc_dirTo;
					private _dist = _mpw distance2D player;
					private _step = (worldSize/30720)*2000*_scale;
					for "_i" from 0 to _dist step _step do {
						private _tPos = ((getPosWorld player) vectorMultiply (1-_i/_dist)) vectorAdd (_mpw vectorMultiply (_i/_dist));
						_this select 0 drawIcon [_img,[1,1,1,1],_tPos,20,20,_dir,"",false,0.05,"puristaMedium","right"];
					};
				}];
				waitUntil {
					if (!visibleMap) then {
						openMap true;
						[localize "str_upack_select_destine",-8] call BRPVP_hint;
					};
					if (!isNil "BRPVP_uPackSelected" && {BRPVP_uPackSelected distance2D player < 500}) then {
						BRPVP_uPackSelected = nil;
						"erro" call BRPVP_playSound;
					};
					!isNil "BRPVP_uPackSelected" || !(player call BRPVP_pAlive)
				};
				(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw",_mdId];
				if (player call BRPVP_pAlive) then {
					if (BRPVP_uPackSelected isEqualTo [0,0,0]) then {
						call BRPVP_upackCancel;
					} else {
						private _jpVolume = 2500;

						//CALC PATH
						BRPVP_uPackSelected = AGLToASL BRPVP_uPackSelected;
						private _pTest = (BRPVP_uPackSelected select [0,2])+[0];
						private _lis = lineIntersectsSurfaces [_pTest vectorAdd [0,0,BRPVP_maxBuildHeight+100],_pTest vectorAdd [0,0,-10],objNull,objNull,true,-1,"GEOM","VIEW"];
						if (_lis isNotEqualTo []) then {
							{
								private _obj = _x select 2;
								private _pos = _x select 0;
								if !(_obj call BRPVP_isMotorized || _obj isKindOf "Man") exitWith {BRPVP_uPackSelected = _pos;};
							} forEach _lis;
						};
						private _posInit = getPosASL player;
						private _hTvl = 45;
						private _pathOk = false;
						while {!_pathOk} do {
							_hTvl = _hTvl+5;
							_pathOk = true;
							private _midA = (_posInit vectorAdd BRPVP_uPackSelected) vectorMultiply 0.5;
							private _midB = (_posInit vectorAdd _midA) vectorMultiply 0.5;
							private _midC = (_midA vectorAdd BRPVP_uPackSelected) vectorMultiply 0.5;
							{
								_x params ["_p1","_p2"];
								if (terrainIntersectASL [_p1 vectorAdd [0,0,_hTvl],_p2 vectorAdd [0,0,_hTvl]]) exitWith {_pathOk = false;};
							} forEach [[_posInit,_midB],[_midB,_midA],[_midA,_midC],[_midC,BRPVP_uPackSelected]];
						};
						_hTvl = (_hTvl+BRPVP_ubberSafeH) max 50;
						_posInit set [2,(_posInit select 2)+_hTvl];
						BRPVP_uPackSelected set [2,(BRPVP_uPackSelected select 2)+_hTvl];
						private _vecUnit = vectorNormalized (BRPVP_uPackSelected vectorDiff _posInit);
						private _hInit = _posInit select 2;
						private _hEnd = BRPVP_uPackSelected select 2;
						private _dt2D = BRPVP_uPackSelected distance2D _posInit;

						//CHECK FREE ABOVE
						private _lis = [];
						{
							private _e = eyePos player vectorAdd _x;
							_lis append ([_e,_e vectorAdd [0,0,_hInit],player,objNull,"FIRE","GEOM"] call BRPVP_lis);
						} forEach [[0,0,0],[0.5,0,0],[-0.5,0,0],[0,0.5,0],[0,-0.5,0]];

						if (_lis isEqualTo []) then {
							BRPVP_walkDisabled = false;
							player setUnitFreefallHeight 5000;

							//ASCEND
							player setDir ([player,BRPVP_uPackSelected] call BIS_fnc_dirTo);
							openMap false;
							_tank remoteExec ["BRPVP_upackSmoke",BRPVP_allNoServer];
							[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
							uiSleep 1.523;
							[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
							private _initA = diag_tickTime;
							private _vz = 0;
							waitUntil {
								private _lt = 1/diag_fps;
								if (diag_tickTime-_initA >= 7.238) then {
									_initA = diag_tickTime;
									[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
								};
								player setVelocity [0,0,_vz];
								_vz = (_vz+15*(_lt/5)) min 15;
								private _hAGLS = getPos player select 2;
								private _hASL = getPosASL player select 2;
								private _hAGL = ASLToAGL getPosASL player select 2;
								(_hAGL > 100 && _hAGLS > 25 && _hASL > _hInit) || !(player call BRPVP_pAlive) || player distance2D BRPVP_uPackSelected < 1.5
							};

							//HORIZONTAL TRAVEL
							if (player distance2D BRPVP_uPackSelected > 1.5) then {
								[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
								private _vm = 0;
								private _lis = [];
								private _lastAlarm = 0;
								waitUntil {
									_lis = [];
									private _d = [player,BRPVP_uPackSelected] call BIS_fnc_dirTo;
									private _if = 1 min (player distance2D BRPVP_uPackSelected)/_dt2D;
									private _hd = (getPosASL player select 2)-(_hInit*_if+_hEnd*(1-_if));
									private _v = [_vm*sin _d,_vm*cos _d,-_hd*(_vm/200)];
									private _vFront = vectorNormalized _v vectorMultiply (300 min (player distance2D BRPVP_uPackSelected));
									{
										_lis append ([getPosASL player,getPosASL player vectorAdd (vectorNormalized _x vectorMultiply 35),player,objNull,"GEOM","FIRE"] call BRPVP_lis);
									} forEach [[35*sin _d,35*cos _d,0],[35*sin (_d+5),35*cos (_d+5),0],[35*sin (_d-5),35*cos (_d-5),0],[35*sin _d,35*cos _d,5],[35*sin _d,35*cos _d,-5]];
									private _lt = 1/diag_fps;
									if (diag_tickTime-_initA >= 7.238) then {
										_initA = diag_tickTime;
										[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									player setVelocity _v;
									_vm = (_vm+200*(_lt/10)) min 200;
									if (diag_tickTime-_lastAlarm > 2.15 && (ASLToAGL (getPosASL player vectorAdd _vFront)) select 2 < 30) then {
										_lastAlarm = diag_tickTime;
										[_tank,["upack_alarm",750]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									player distance2D BRPVP_uPackSelected < 250 || !(player call BRPVP_pAlive) || count _lis > 0
								};
								if (count _lis > 0) then {
									if (diag_tickTime-_lastAlarm > 2.15) then {
										_lastAlarm = diag_tickTime;
										[_tank,["upack_alarm",750]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									private _vec = vectorNormalized (BRPVP_uPackSelected vectorDiff getPosASL player) vectorMultiply 20;
									BRPVP_uPackSelected = getPosASL player vectorAdd _vec;
								};
							};

							//DESCENT
							if (BRPVP_ubberFastDescent) then {
								//STOP
								if (player distance2D BRPVP_uPackSelected > 1.5) then {
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									private _vm = 0;
									private _magMark = vectorMagnitude velocity player;
									private _distMark = player distance2D BRPVP_uPackSelected;
									private _lis = [];
									waitUntil {
										_lis = [];
										private _dist = player distance2D BRPVP_uPackSelected;
										private _d = [player,BRPVP_uPackSelected] call BIS_fnc_dirTo;
										private _mag = _magMark*sqrt(_dist/_distMark);
										private _v = [_mag*sin _d,_mag*cos _d,0];
										{
											_lis append ([getPosASL player,getPosASL player vectorAdd (vectorNormalized _x vectorMultiply 35),player,objNull,"GEOM","FIRE"] call BRPVP_lis);
										} forEach [[35*sin _d,35*cos _d,0],[35*sin (_d+5),35*cos (_d+5),0],[35*sin (_d-5),35*cos (_d-5),0],[35*sin _d,35*cos _d,5],[35*sin _d,35*cos _d,-5]];
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										player setVelocity _v;
										_dist < 5 || !(player call BRPVP_pAlive) || count _lis > 0
									};
								};
								if (count _lis > 0) then {
									if (diag_tickTime-_lastAlarm > 2.15) then {
										_lastAlarm = diag_tickTime;
										[_tank,["upack_alarm",750]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									private _vec = vectorNormalized (BRPVP_uPackSelected vectorDiff getPosASL player) vectorMultiply 20;
									BRPVP_uPackSelected = getPosASL player vectorAdd _vec;

									//STOP 2
									private _vm = 0;
									private _magMark = vectorMagnitude velocity player;
									private _distMark = player distance2D BRPVP_uPackSelected;
									waitUntil {
										private _dist = player distance2D BRPVP_uPackSelected;
										private _d = [player,BRPVP_uPackSelected] call BIS_fnc_dirTo;
										private _mag = _magMark*sqrt(_dist/_distMark);
										private _v = [_mag*sin _d,_mag*cos _d,0];
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										player setVelocity _v;
										_dist < 5 || !(player call BRPVP_pAlive)
									};
								};

								//DESCENT TO 30
								private _vz = 0;
								private _ih = getPos player select 2;
								private _hCalc = 0;
								private _stuck = false;
								[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
								waitUntil {
									private _lt = 1/diag_fps;
									if (diag_tickTime-_initA >= 7.238) then {
										_initA = diag_tickTime;
										[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									_vz = (_vz-60*(_lt/2)) max -60;
									player setVelocity [0,0,_vz];
									_hCalc = _hCalc+_lt*_vz;
									_stuck = abs _hCalc > _ih*1.5;
									private _hNow = getPos player select 2;
									(_hNow < 30 && _vz < -15) || (_hNow < 10 && _vz < -5) || _hNow < 5 || !(player call BRPVP_pAlive) || _stuck
								};
								if (_stuck) then {BRPVP_uberBadEnd = true;[objNull,"Stuck_Uber_F",true] call BRPVP_pehKilledFakeHandleDamage;};

								//LAND
								if (player call BRPVP_pAlive) then {
									_landReached = true;
									private _ih = getPos player select 2;
									private _vzi = velocity player select 2;
									private _hCalc = 0;
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									waitUntil {
										private _lt = 1/diag_fps;
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										private _hNow = (getPos player select 2) max 0;
										private _m = ((1-_hNow/_ih) min 1 max 0)^2.5;
										private _vz = _vzi*(1-_m*0.95);
										player setVelocity [0,0,_vz];
										_hCalc = _hCalc+_lt*_vz;
										_stuck = abs _hCalc > _ih*1.75;
										getPos player select 2 < 0.25 || !(player call BRPVP_pAlive) || _stuck
									};
									if (_stuck) then {BRPVP_uberBadEnd = true;[objNull,"Stuck_Uber_F",true] call BRPVP_pehKilledFakeHandleDamage;};
								};
							} else {
								//STOP
								if (player distance2D BRPVP_uPackSelected > 1.5) then {
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									private _vm = 0;
									private _magMark = vectorMagnitude velocity player;
									private _distMark = player distance2D BRPVP_uPackSelected;
									private _lis = [];
									waitUntil {
										_lis = [];
										private _dist = player distance2D BRPVP_uPackSelected;
										private _d = [player,BRPVP_uPackSelected] call BIS_fnc_dirTo;
										private _mag = _magMark*_dist/_distMark;
										private _v = [_mag*sin _d,_mag*cos _d,0];
										{
											_lis append ([getPosASL player,getPosASL player vectorAdd (vectorNormalized _x vectorMultiply 35),player,objNull,"GEOM","FIRE"] call BRPVP_lis);
										} forEach [[35*sin _d,35*cos _d,0],[35*sin (_d+5),35*cos (_d+5),0],[35*sin (_d-5),35*cos (_d-5),0],[35*sin _d,35*cos _d,5],[35*sin _d,35*cos _d,-5]];
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										player setVelocity _v;
										_dist < 5 || !(player call BRPVP_pAlive) || count _lis > 0
									};
								};
								if (count _lis > 0) then {
									if (diag_tickTime-_lastAlarm > 2.15) then {
										_lastAlarm = diag_tickTime;
										[_tank,["upack_alarm",750]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									private _vec = vectorNormalized (BRPVP_uPackSelected vectorDiff getPosASL player) vectorMultiply 20;
									BRPVP_uPackSelected = getPosASL player vectorAdd _vec;

									//STOP 2
									private _vm = 0;
									private _magMark = vectorMagnitude velocity player;
									private _distMark = player distance2D BRPVP_uPackSelected;
									waitUntil {
										private _dist = player distance2D BRPVP_uPackSelected;
										private _d = [player,BRPVP_uPackSelected] call BIS_fnc_dirTo;
										private _mag = _magMark*sqrt(_dist/_distMark);
										private _v = [_mag*sin _d,_mag*cos _d,0];
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										player setVelocity _v;
										_dist < 5 || !(player call BRPVP_pAlive)
									};
								};

								//DESCENT TO 60
								if (getPos player select 2 > 60) then {
									private _vz = 0;
									waitUntil {
										private _lt = 1/diag_fps;
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										player setVelocity [0,0,_vz];
										_vz = (_vz-20*(_lt/3.5)) max -20;
										getPos player select 2 < 60 || !(player call BRPVP_pAlive)
									};

									//VELOCITY TO 5
									private _ib = diag_tickTime;
									private _vzi = velocity player select 2;
									waitUntil {
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										private _m = 1 min (diag_tickTime-_ib);
										player setVelocity [0,0,_vzi*(1-_m)+-5*_m];
										_m >= 1 || !(player call BRPVP_pAlive)
									};
								};

								//DESCENT TO 2.5
								if (player call BRPVP_pAlive) then {_landReached = true;};
								[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
								private _vz = -5;
								private _ht = getPosASL player select 2;
								private _stuck = false;
								waitUntil {
									private _lt = 1/diag_fps;
									if (diag_tickTime-_initA >= 7.238) then {
										_initA = diag_tickTime;
										[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									player setVelocity [0,0,_vz];
									_vz = (_vz-5*(_lt/2.5)) max -5;
									_stuck = if (_vz isEqualTo -5) then {
										_ht = _ht-_lt*5;
										(getPosASL player select 2)-_ht > 25
									} else {
										_ht = getPosASL player select 2;
										false
									};
									getPos player select 2 < 2.5 || !(player call BRPVP_pAlive) || _stuck
								};
								if (_stuck) then {BRPVP_uberBadEnd = true;[objNull,"Stuck_Uber_F",true] call BRPVP_pehKilledFakeHandleDamage;};

								//LAND
								[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
								private _vm = 0;
								private _magMark = vectorMagnitude velocity player;
								private _distMark = getPos player select 2;
								waitUntil {
									private _dist = getPos player select 2;
									private _mag = (_magMark*_dist/_distMark) max 2.5;
									private _v = [0,0,-_mag];
									if (diag_tickTime-_initA >= 7.238) then {
										_initA = diag_tickTime;
										[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									player setVelocity _v;
									getPos player select 2 < 0.25 || !(player call BRPVP_pAlive)
								};
							};

							player setUnitFreefallHeight 100;

							//FINISH
							BRPVP_uPackUsing = false;
							if (player call BRPVP_pAlive) then {
								[player,["uber_pack_end",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
								private _initB = diag_tickTime;
								waitUntil {
									if (diag_tickTime-_initA >= 7.238) then {
										_initA = diag_tickTime;
										[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
									diag_tickTime-_initB > 1
								};
								if (BRPVP_ubberFastDescent) then {
									_tank attachTo [player,[0,-0.75,-0.15],"spine3",true];
									detach _tank;
									_tank setVectorUp [selectRandom [-0.5,0.5],selectRandom [-0.5,0.5],-1];
								} else {
									_tank attachTo [player,[0,-0.45,-0.15],"spine3",true];
									detach _tank;
									_tank setVectorUp [0,0,-1];
								};
								_tank disableCollisionWith player;
								private _bpc = backPackContainer player;
								if (!isNull _bpc) then {[_bpc,false] remoteExecCall ["hideObjectGlobal",2];};
								if (BRPVP_ubberFastDescent) then {
									private _initC = diag_tickTime;
									waitUntil {
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										private _dt = diag_tickTime-_initC;
										getPos _tank select 2 < 0.25 || _dt > 10
									};
									uiSleep 1.5;
									private _mark = diag_tickTime-_initC;
									if (_mark < 10) then {
										waitUntil {
											private _dt = diag_tickTime-_initC;
											private _dtf = _dt-_mark;
											if (diag_tickTime-_initA >= 7.238) then {
												_initA = diag_tickTime;
												[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
											};
											_tank setVelocity (vectorUp _tank vectorMultiply -(1.5+_dtf*2));
											_dt > 10
										};
									};
									private _bomb = "APERSTripMine_Wire_Ammo" createVehicle ASLToAGL getPosASL _tank;
									_bomb setdamage 1;
								} else {
									private _vel = vectorUp _tank vectorMultiply -10;
									private _initC = diag_tickTime;
									waitUntil {
										private _dt = diag_tickTime-_initC;
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_tank,["uber_pack",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};
										_tank setVelocity (_vel vectorAdd [0,0,_dt]);
										_dt > 5
									};
								};
								private _bomb = "APERSTripMine_Wire_Ammo" createVehicle ASLToAGL getPosASL _tank;
								_bomb setdamage 1;
							} else {
								if (_landReached) then {player setVariable ["brpvp_no_colision_ubadend",true];};
								private _bomb = "APERSTripMine_Wire_Ammo" createVehicle ASLToAGL getPosASL _tank;
								_bomb setdamage 1;
								detach _tank;
								private _bpc = backPackContainer player;
								if (!isNull _bpc) then {[_bpc,false] remoteExecCall ["hideObjectGlobal",2];};
								private _iFinal = diag_tickTime;
								waitUntil {getPos player select 2 < 0.25 || diag_tickTime-_iFinal > 15 || !alive player};
								uiSleep 1;
								if (_landReached) then {player setVariable ["brpvp_no_colision_ubadend",false];};
							};
							deleteVehicle _tank;
						} else {
							[localize "str_upack_cant_above",-5] call BRPVP_hint;
							call BRPVP_upackCancel;
							openMap false;
						};
					};
				} else {
					call BRPVP_upackCancel;
				};
			};
			true
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	};
};
BRPVP_usedBigFloor200 = {
	private _flag = player call BRPVP_nearestFlagInside;
	private _rad = _flag getVariable ["brpvp_flag_radius",0];
	if ([player,_flag] call BRPVP_checaAcessoRemotoFlag && _rad isEqualTo 200) then {
		private _menuVar1 = getPosASL _flag;
		_menuVar1 set [2,(getPosASL player select 2)-0.25];
		private _menuVar2 = [-1,_menuVar1,BRPVP_bigFloorHoles,-1] call BRPVP_creatBigFloor200;
		[_menuVar1,_menuVar2] spawn {
			waitUntil {!BRPVP_menuExtraLigado};
			uiSleep 0.001;
			BRPVP_menuVar1 = _this select 0;
			BRPVP_menuVar2 = _this select 1;
			196 call BRPVP_iniciaMenuExtra;
		};
		true
	} else {
		[localize "str_cons_cant_flag",-5] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_usedBigFloorRemove = {
	private _lis = [eyePos player,eyePos player vectorAdd [0,0,-3.5],player,objNull,"GEOM","FIRE"] call BRPVP_lis;
	if (_lis isEqualTo []) then {
		[localize "str_remove_big_floor",-6] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		false
	} else {
		private _obj = _lis select 0 select 2;
		if (typeOf _obj isEqualTo "" && str _obj find ": part_" > -1) then {
			private _bfId = _obj getVariable ["brpvp_bf_bfid",-1];
			private _owner = _obj getVariable ["brpvp_bf_id",-1];
			private _pId = player getVariable "id_bd";
			if (_bfId isNotEqualTo -1) then {
				if (_owner isEqualTo _pId) then {
					private _allObjs = [];
					[ASLToAGL getPosASL _obj,_bfId,_pId] remoteExecCall ["BRPVP_removeBigFloorObjectsOriginItem",0];
					_bfId remoteExecCall ["BRPVP_removeBigFloorEntry",0];
					_bfId remoteExecCall ["BRPVP_removeBigFloorFromDb",2];
					["BRPVP_bigFloor200",1] call BRPVP_sitAddItem;
					true
				} else {
					[localize "str_remove_big_floor_must_own",-6] call BRPVP_hint;
					"erro" call BRPVP_playSound;
					false
				};
			} else {
				[localize "str_remove_big_floor",-6] call BRPVP_hint;
				"erro" call BRPVP_playSound;
				false
			};
		} else {
			[localize "str_remove_big_floor",-6] call BRPVP_hint;
			"erro" call BRPVP_playSound;
			false
		};
	};
};
BRPVP_usedAtmFix = {
	private _found = objNull;
	{
		private _objStr = str _x;
		if (typeOf _x isEqualTo "" && {{_objStr find _x isNotEqualTo -1} count [": atm_01_f.p3d",": atm_02_f.p3d"] > 0 && !(_x in BRPVP_atmOldActivated)}) exitWith {_found = _x;};
	} forEach nearestObjects [player,[],15];
	if (isNull _found) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		private _class = BRPVP_atmClasses select (str _found find ": atm_02_f.p3d" > -1);
		private _newAtm = createSimpleObject [_class,[0,0,0]];
		_newAtm setVectorDirAndUp [vectorDir _found,vectorUp _found];
		_newAtm setPosWorld getPosWorld _found;
		private _emitters = [];
		for "_i" from 1 to 2 do {
			private _emitter = "#particlesource" createVehicle (getPos _found);
			_emitter setParticleClass "MediumSmoke";
			_emitter setParticleFire [0.3,1.0,0.1];
			_emitter attachTo [_found,[0,0,0]];
			_emitters pushBack _emitter;
		};
		[5,_emitters select 0] remoteExecCall ["BRPVP_deleteAfterTime",2];
		[10,_emitters select 1] remoteExecCall ["BRPVP_deleteAfterTime",2];
		[_found,["eletric_spark",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
		_newAtm remoteExecCall ["BRPVP_atmOldActivatedAdd",0];
		_found spawn {
			uiSleep 2.5;
			[_this,true] remoteExecCall ["hideObjectGlobal",2];
		};
		true
	};
};
BRPVP_usedBoxeItem = {
	if (BRPVP_boxeItemOn) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_boxeItemOn = true;
		"boxe" call BRPVP_playSound;
		["<img shadow='0' size='5.0' image='"+BRPVP_imagePrefix+"BRP_imagens\rock.paa'/>",0,0.25,2.5,0,0,32657] call BRPVP_fnc_dynamicText;
		true
	};
};
BRPVP_usedSelfRevive = {
	"erro" call BRPVP_playSound;
	false
};
BRPVP_usedBodyChange = {
	private _playerOk = isNull objectParent player && player call BRPVP_pAlive && getPos player select 2 < 0.25;
	if (BRPVP_bodyChangeTrying || BRPVP_bodyChangeInvited || BRPVP_spectateOn || !_playerOk || BRPVP_possOtherPlayer) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_bodyChangeTrying = true;
		0 spawn {
			waitUntil {!BRPVP_menuExtraLigado};
			uiSleep 0.001;
			199 call BRPVP_iniciaMenuExtra;
		};
		true
	};
};
BRPVP_usedVehicleTorque = {
	private _co = objectParent player;
	if (isNull _co) then {
		private _vec = (getCameraViewDirection player) vectorMultiply 2.5;
		private _posCam = eyePos player;
		private _lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,1,"GEOM","NONE"];
		_co = if (_lis isEqualTo []) then {objNull} else {_lis select 0 select 2};
	};
	if (alive _co && {_co isKindOf "Car" || _co isKindOf "Tank" || _co isKindOf "Motorcycle"}) then {
		if (_co getVariable ["brpvp_original_mass",-1] isEqualTo -1) then {
			_co spawn {
				private _co = _this;
				BRPVP_torqueAddResult = nil;
				[player,_co] remoteExecCall ["BRPVP_torqueSetBetter",2];
				waitUntil {!isNil "BRPVP_torqueAddResult"};
				if (BRPVP_torqueAddResult) then {
					"plus_torque" call BRPVP_playSound;
					[localize "str_tq_torque_doubled",-5] call BRPVP_hint;
				} else {
					["BRPVP_vehicleTorque",1] call BRPVP_sitAddItem;
					"erro" call BRPVP_playSound;
					[localize "str_tq_already_have",-5] call BRPVP_hint;
				};
			};
			true
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_tq_already_have",-5] call BRPVP_hint;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		[localize "str_tq_must_look_car_tank",-5] call BRPVP_hint;
		false
	};
};
BRPVP_possCanUseItem = true;
BRPVP_possSetUberTankExchange = {
	params ["_player","_controled"];
	private _uaC = _controled getVariable ["brpvp_uber_attack_tank",objNull];
	private _uaP = _player getVariable ["brpvp_uber_attack_tank",objNull];
	if (isNull _uaC) then {if (!isNull _uaP) then {_player call BRPVP_uberAttackRemovePlayer;};};
	if (isNull _uaP) then {if (!isNull _uaC) then {_controled remoteExecCall ["BRPVP_uberAttackRemoveAi",_controled];};};
	if (!isNull _uaC) then {if (isNull _uaP) then {_player call BRPVP_uberAttackAddPlayer;};};
	if (!isNull _uaP) then {if (isNull _uaC) then {_controled remoteExecCall ["BRPVP_uberAttackAddAi",_controled];};};
};
BRPVP_stuckRobberDied = {["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\stuck_in_body.paa'/><br /><t>"+localize "str_poss_stuck_in_body"+"</t>",0,0,5,0,0,19472] call BRPVP_fnc_dynamicText;};
BRPVP_possessionVeh = objNull;
BRPVP_usedPossession = {
	if (BRPVP_construindo || BRPVP_menuExtraLigado || BRPVP_possOtherPlayer || !BRPVP_possCanUseItem) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_possCanUseItem = false;
		BRPVP_possItemUsed = _this select 0;
		_this spawn {
			params ["_item","_force"];
			private _posOriginal = ASLToAGL getPosASL player;
			private _iTxt = diag_tickTime;
			private _controled = objNull;
			private _img = BRPVP_specialItemsImages select (BRPVP_specialItems find _item);
			private _cnt = 60;
			["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+_img+"'/><br /><t>"+localize "str_move_to_cancel"+": "+str _cnt+"</t>",0,0,1,0,0,19472] call BRPVP_fnc_dynamicText;
			waitUntil {
				private _co = cursorObject;
				if (_force <= 0.5) then {
					//UNIT AND STATIC WEAPON POSSESSION
					private _isCanMan = _co isKindOf "CaManBase" && {!(_co isKindOf "C_man_p_shorts_1_F") && !(typeOf _co in ["B_Soldier_VR_F","O_Soldier_VR_F","I_Soldier_VR_F","C_Soldier_VR_F","C_Driver_1_F"]) && !(_co getVariable ["brpvp_no_possession",false]) && serverTime-(_co getVariable ["brpvp_out_veh_time",-100]) > 40};
					private _isCanManStatic = _co isKindOf "StaticWeapon" && !isNull gunner _co && {!(gunner _co isKindOf "C_man_p_shorts_1_F") && !(typeOf gunner _co in ["B_Soldier_VR_F","O_Soldier_VR_F","I_Soldier_VR_F","C_Soldier_VR_F","C_Driver_1_F"]) && !(_co getVariable ["brpvp_no_possession",false])};
					if (_isCanMan && {alive _co && (isNull objectParent _co || objectParent _co isKindOf "StaticWeapon") && _co getVariable ["id_bd",-1] isEqualTo -1 && simulationEnabled _co}) exitWith {_controled = _co;};
					if (_isCanManStatic && {alive _co && alive gunner _co && gunner _co getVariable ["id_bd",-1] isEqualTo -1 && simulationEnabled _co && simulationEnabled gunner _co}) exitWith {_controled = gunner _co;};
				} else {
					if (_force <= 0.75) then {
						//VEHICLE POSSESSION
						if ((_co isKindOf "Car" || _co isKindOf "Tank" || _co isKindOf "Air" || _co isKindOf "Ship" || _co isKindOf "Motorcycle") && {alive _co && alive currentPilot _co && currentPilot _co getVariable ["id_bd",-1] isEqualTo -1 && simulationEnabled _co && simulationEnabled currentPilot _co && !(_co getVariable ["brpvp_no_possession",false])}) exitWith {_controled = currentPilot _co;};
					} else {
						if (_force <= 1) then {
							//PLAYER POSSESSION
							if (_co isKindOf BRPVP_playerModel && {_co call BRPVP_pAlive && isNull objectParent _co && _co getVariable ["sok",false] && simulationEnabled _co && !(_co getVariable ["brpvp_no_possession",false])}) then {
								private _playerOk = player call BRPVP_pAlive && player getVariable ["sok",false] && !isNull player && isNull objectParent player && getPos player select 2 < 0.25;
								private _coOk = _co call BRPVP_pAlive && _co getVariable ["sok",false] && !isNull _co && isNull objectParent _co && getPos _co select 2 < 0.25;
								if (_playerOk && _coOk) then {_controled = _co;};
							};
						};
					};
				};
				if (diag_tickTime-_iTxt >= 1) then {
					_iTxt = diag_tickTime;
					_cnt = _cnt-1;
					if (_cnt > 0) then {["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+_img+"'/><br /><t>"+localize "str_move_to_cancel"+": "+str _cnt+"</t>",0,0,1,0,0,19472] call BRPVP_fnc_dynamicText;};
				};
				_cnt isEqualTo 0 || !isNull _controled || player distanceSqr _posOriginal > 100 || !(player call BRPVP_pAlive)
			};
			["",0,0,1,0,0,19472] call BRPVP_fnc_dynamicText;
			if (_cnt isEqualTo 0 || isNull _controled || player distanceSqr _posOriginal > 100 || !(player call BRPVP_pAlive)) then {
				"erro" call BRPVP_playSound;
				[_item,1] call BRPVP_sitAddItem;
				BRPVP_possCanUseItem = true;
			} else {
				private _isPlayerAlive = _controled getVariable ["id_bd",-1] > -1 && _controled getVariable ["sok",false] && _controled call BRPVP_pAlive;
				private _isAiAlive = _controled getVariable ["id_bd",-1] isEqualTo -1 && alive _controled;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				BRPVP_possessionVeh = objNull;
				if (_isAiAlive) then {
					if (stance player isEqualTo "STAND") then {player playAction "PlayerCrouch";};
					"possession" call BRPVP_playSound;
					[player,["possession",200]] remoteExecCall ["say3D",-clientOwner];
					9837 cutText ["","BLACK FADED",100];
					private _init = diag_tickTime;
					waitUntil {!alive _controled || !(player call BRPVP_pAlive) || player getVariable ["brpvp_no_possession",false] || _controled getVariable ["brpvp_no_possession",false] || diag_tickTime-_init >= 1.35};
					if (!alive _controled || !(player call BRPVP_pAlive) || player getVariable ["brpvp_no_possession",false] || _controled getVariable ["brpvp_no_possession",false]) exitWith {
						deleteVehicle _sounder;
						9837 cutText ["","PLAIN",1];
						[_item,1] call BRPVP_sitAddItem;
						BRPVP_possCanUseItem = true;
					};
					private _playerOk = player call BRPVP_pAlive && player getVariable ["sok",false] && !isNull player && !(player getVariable ["brpvp_no_possession",false]);
					private _controledOk = alive _controled && !isNull _controled && !(_controled getVariable ["brpvp_no_possession",false]);
					if (_playerOk && _controledOk) then {
						BRPVP_possBadAction = -1;
						BRPVP_possFinalType = -1;
						player setVariable ["brpvp_possessing_other",true];
						player setVariable ["brpvp_no_extra_safe",true];
						player setVariable ["brpvp_no_custom_eject",true];
						player setVariable ["brpvp_no_possession",true,true];
						_controled setVariable ["brpvp_no_possession",true,true];
						[_controled,"ANIM"] remoteExecCall ["disableAI",_controled];
						[_controled,"PATH"] remoteExecCall ["disableAI",_controled];
						[_controled,"MOVE"] remoteExecCall ["disableAI",_controled];
						[_controled,"TARGET"] remoteExecCall ["disableAI",_controled];
						
						BRPVP_possCaptive = true;
						player setCaptive true;

						[_controled,getUnitLoadOut player,getUnitLoadOut _controled] call BRPVP_changeSoulCodeAskerPossession;
						[player,_controled] call BRPVP_possSetUberTankExchange;
						player setVariable ["brpvp_possessed",0,2];
						player setVariable ["brpvp_my_possessed",_controled,2];
						BRPVP_possOtherPlayer = true;
						uiSleep 0.25;
						9837 cutText ["","BLACK IN",1];
						[_controled,(-rating _controled-10000)] remoteExecCall ["addRating",_controled];
						BRPVP_possActionId = player addAction ["<t color='#0E55AB'>"+localize "str_poss_cancel_bot"+"</t>",{call BRPVP_possPlayerRevert;},_controled,2,false,true];
						[player,_controled] spawn {
							params ["_player","_controled"];
							private _init = diag_tickTime;
							private _wait = selectRandom [45,50,55,60];
							private _iWar = diag_tickTime;
							waitUntil {
								if (diag_TickTime-_init > (_wait-10)) then {
									if (diag_tickTime-_iWar > 2) then {
										_iWar = diag_tickTime;
										["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\bush_view_half_warning.paa'/>",0,0,0.5,0,0,39482] call BRPVP_fnc_dynamicText;
									};
								};
								(diag_tickTime-_init > _wait || BRPVP_possBadAction > -1) || BRPVP_possFinalType > -1 || !BRPVP_possCaptive
							};
							if (BRPVP_possFinalType isNotEqualTo 1) then {
								"bush_reveal" call BRPVP_playSound;
								["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\bush_view_warning.paa'/>",0,0,1,0,0,39482] call BRPVP_fnc_dynamicText;
							};
							if (BRPVP_possCaptive) then {
								BRPVP_possCaptive = false;
								if !(call BRPVP_playerCaptiveState) then {
									player setCaptive false;
									uiSleep 0.25;
									{if (leader _x distance player < 500) then {[_x,[player,4]] remoteExecCall ["reveal",leader _x];};} forEach allGroups;
								};
							};
							waitUntil {BRPVP_possFinalType > -1};
							BRPVP_possCanUseItem = true;
							BRPVP_possBadAction = -1;
						};						
						waitUntil {BRPVP_possActionId isEqualTo -1 || !alive _controled || !(player call BRPVP_pAlive)};
						if (BRPVP_possActionId isNotEqualTo -1) then {
							"zed_death" call BRPVP_playSound;
							private _aiAlive = player call BRPVP_pAlive;
							private _pAlive = alive _controled;
							if ((!_pAlive && _aiAlive) || (!_pAlive && !_aiAlive)) then {
								["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\stuck_in_body.paa'/><br /><t>"+localize "str_poss_stuck_in_body"+"</t>",0,0,5,0,0,19472] call BRPVP_fnc_dynamicText;
								player removeAction BRPVP_possActionId;
								BRPVP_possActionId = -1;
								BRPVP_possOtherPlayer = false;
								player setVariable ["brpvp_possessing_other",false];
								player setVariable ["brpvp_no_extra_safe",false];
								player setVariable ["brpvp_no_custom_eject",false];
								player setVariable ["brpvp_no_possession",false,true];
								[_controled,(-rating _controled)] remoteExecCall ["addRating",_controled];
								[_controled,"TEAMSWITCH"] remoteExecCall ["enableAI",_controled];
								player setVariable ["brpvp_my_possessed",objNull,2];
								if (!isNull BRPVP_possessionVeh) then {[BRPVP_possessionVeh,false] remoteExecCall ["lock",BRPVP_possessionVeh];};
								BRPVP_possFinalType = 2;
							} else {
								if (_pAlive && !_aiAlive) then {
									[0,0,0,_controled] call BRPVP_possPlayerRevert;
									[_controled,(-rating _controled)] remoteExecCall ["addRating",_controled];
									[_controled,"",1,objNull,"",0,objNull,""] remoteExecCall ["BRPVP_hdEh",_controled];
								};
							};
						};
					} else {
						"erro" call BRPVP_playSound;
						[_item,1] call BRPVP_sitAddItem;
						9837 cutText ["","PLAIN",1];
						BRPVP_possCanUseItem = true;
					};
				} else {
					if (_isPlayerAlive) then {
						private _sounder = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],100,"NONE"];
						_sounder attachTo [player,[0,0,0]];
						[_sounder,["possession",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
						player remoteExec ["BRPVP_changeSoulCodeInviterPossession",_controled];
						9837 cutText ["","BLACK FADED",100];
						private _init = diag_tickTime;
						waitUntil {!(_controled call BRPVP_pAlive) || !(player call BRPVP_pAlive) || player getVariable ["brpvp_no_possession",false] || _controled getVariable ["brpvp_no_possession",false] || diag_tickTime-_init >= 2.7};
						if (!(_controled call BRPVP_pAlive) || !(player call BRPVP_pAlive) || player getVariable ["brpvp_no_possession",false] || _controled getVariable ["brpvp_no_possession",false]) exitWith {
							player setVariable ["brpvp_pposs_status",0,_controled getVariable ["brpvp_machine_id",0]];
							deleteVehicle _sounder;
							[_item,1] call BRPVP_sitAddItem;
							9837 cutText ["","PLAIN",1];
							BRPVP_possCanUseItem = true;
						};
						private _playerOk = player call BRPVP_pAlive && player getVariable ["sok",false] && !isNull player && isNull objectParent player && getPos player select 2 < 0.25;
						private _controledOk = _controled call BRPVP_pAlive && _controled getVariable ["sok",false] && !isNull _controled && isNull objectParent _controled && getPos _controled select 2 < 0.25;
						if (_playerOk && _controledOk) then {
							BRPVP_possFinalType = -1;
							player setVariable ["brpvp_possessing_other",true];
							player setVariable ["brpvp_no_extra_safe",true];
							player setVariable ["brpvp_no_custom_eject",true];
							player setVariable ["brpvp_no_possession",true,true];
							_controled setVariable ["brpvp_no_possession",true,true];
							player setVariable ["brpvp_pposs_status",1,_controled getVariable ["brpvp_machine_id",0]];
							[_controled,getUnitLoadOut player,getUnitLoadOut _controled] call BRPVP_changeSoulCodeAskerPossession;
							[player,_controled] call BRPVP_possSetUberTankExchange;
							player setVariable ["brpvp_my_possessed",_controled,2];
							BRPVP_possOtherPlayer = true;
							uiSleep 0.25;
							9837 cutText ["","BLACK IN",1];
							BRPVP_possActionId = player addAction ["<t color='#0E55AB'>"+localize "str_poss_cancel_player"+"</t>",{call BRPVP_possPlayerRevert;},_controled,2,false,true];
							[player,_controled] spawn {
								params ["_player","_controled"];
								waitUntil {BRPVP_possFinalType > -1};
								BRPVP_possCanUseItem = true;
							};	
							waitUntil {BRPVP_possActionId isEqualTo -1 || !(_controled call BRPVP_pAlive) || !(player call BRPVP_pAlive)};
							if (BRPVP_possActionId isNotEqualTo -1) then {
								"zed_death" call BRPVP_playSound;
								"zed_death" remoteExecCall ["playSound",_controled];
								if (player call BRPVP_pAlive) then {["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\stuck_in_body.paa'/><br /><t>"+localize "str_poss_stuck_in_body"+"</t>",0,0,5,0,0,19472] call BRPVP_fnc_dynamicText;} else {remoteExecCall ["BRPVP_stuckRobberDied",_controled];};
								player removeAction BRPVP_possActionId;
								player setVariable ["brpvp_possessing_other",false];
								player setVariable ["brpvp_no_extra_safe",false];
								player setVariable ["brpvp_no_custom_eject",false];
								player setVariable ["brpvp_no_possession",false,true];
								player setVariable ["brpvp_my_possessed",objNull,2];
								_controled setVariable ["brpvp_no_possession",false,true];
								false remoteExecCall ["BRPVP_possOtherPlayerSet",_controled];
								if (!isNull BRPVP_possessionVeh) then {[BRPVP_possessionVeh,false] remoteExecCall ["lock",BRPVP_possessionVeh];};
								BRPVP_possActionId = -1;
								BRPVP_possOtherPlayer = false;
								BRPVP_possCanUseItem = true;
								BRPVP_possFinalType = 2;
							};
						} else {
							player setVariable ["brpvp_pposs_status",0,_controled getVariable ["brpvp_machine_id",0]];
							deleteVehicle _sounder;
							"erro" call BRPVP_playSound;
							[_item,1] call BRPVP_sitAddItem;
							9837 cutText ["","PLAIN",1];
							BRPVP_possCanUseItem = true;
						};
					} else {
						"erro" call BRPVP_playSound;
						[_item,1] call BRPVP_sitAddItem;
						BRPVP_possCanUseItem = true;
					};
				};
			};	
		};
		true
	};
};
BRPVP_uberAttackUsing = false;
BRPVP_usedUberAttack = {
	if (BRPVP_uberAttackUsing || !(player call BRPVP_pAlive) || !isNull objectParent player || getPos player select 2 > 1.5 || (ASLToAGL getPosASL player) select 2 > 35 || BRPVP_possOtherPlayer) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		BRPVP_uberAttackUsing = true;
		0 spawn {
			waitUntil {!BRPVP_menuExtraLigado};
			uiSleep 0.001;
			202 call BRPVP_iniciaMenuExtra;
		};
		true
	};	
};
BRPVP_usedSecCam = {
	private _epDown = eyePos player vectorAdd [0,0,-0.045];
	private _posAslCheck = _epDown vectorAdd (getCameraViewDirection player vectorMultiply 0.6);
	private _lis = lineIntersectsSurfaces [_epDown,_posAslCheck,player,objNull,true,1,"GEOM","NONE"];
	if (_lis isEqualTo []) then {
		private _posASL = _epDown vectorAdd (getCameraViewDirection player vectorMultiply 0.25);
		private _cam = createSimpleObject ["Land_HandyCam_F",_posASL];
		private _vd = getCameraViewDirection player vectorMultiply -1;
		private _vu = (_vd vectorCrossProduct [0,0,1]) vectorCrossProduct _vd;
		private _own = player getVariable "id_bd";
		private _amg = player getVariable "amg";
		_cam setVectorDirAndUp [_vd,_vu];
		_cam setVariable ["brpvp_cam_own",_own,true];
		_cam setVariable ["brpvp_cam_amg",_amg,true];
		_cam setVariable ["brpvp_cam_id",-1,true];
		[_cam,_posASL,[_vd,_vu],_own,_amg] remoteExecCall ["BRPVP_secCamAddDb",2];
		true
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_usedTrench = {
	if (count BRPVP_terrainVertexChanges < BRPVP_trenchMaxQuantity) then {
		private _playerASL = getPosASL BRPVP_myPlayerOrUAV;
		if (ASLToAGL _playerASL select 2 < 0.75) then {
			private _size = getTerrainInfo select 2;
			private _rad = _size*sqrt(2);
			private _vertex = (_playerASL select [0,2]) apply {_size*round (_x/_size)};
			private _isNew = true;
			{if (_vertex isEqualTo (_x select 0)) exitWith {_isNew = false;};} forEach BRPVP_terrainVertexChanges;
			if (_isNew) then {
				private _vPosAGL = _vertex+[0];
				private _chckCenter = AGLToASL _vPosAGL;
				private _hNow = _chckCenter select 2;
				private _okToDig = true;
				for "_z" from 0.1 to 1.6 step 0.5 do {
					private _forCenter = _chckCenter vectorAdd [0,0,_z];
					for "_a" from 15 to 360 step 15 do {
						private _destine = AGLToASL [(_forCenter select 0)+_rad*sin _a,(_forCenter select 1)+_rad*cos _a,_z];
						private _lis = lineIntersectsSurfaces [_forCenter,_destine,BRPVP_myPlayerOrUAV,objNull,true,-1];
						private _denied = _lis select {(_x select 2) isKindOf "Building" || (_x select 2) isKindOf "Wall" || (_x select 2) getVariable ["id_bd",-1] isNotEqualTo -1};
						private _isOk = !surfaceIsWater _destine && !isOnRoad (_destine select [0,2]);
						if !(_denied isEqualTo [] && _isOk) exitWith {_okToDig = false;};
					};
					if (!_okToDig) exitWith {};
				};
				if (_okToDig) then {
					private _vPos = _vertex+[_hNow];
					private _newH = _hNow-BRPVP_trenchDepth;
					[_vertex,_newH,_hNow] remoteExecCall ["BRPVP_terrainVertexChangesAdd",0];
					[player,_vertex,_hNow,_newH] remoteExec ["BRPVP_trenchDigServer",2];
					true
				} else {
					"erro" call BRPVP_playSound;
					false
				};
			} else {
				"erro" call BRPVP_playSound;
				false
			};
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		[localize "str_item_trench_cant_too_many",-5] call BRPVP_hint;
		false
	};
};
BRPVP_usedBaseBoxUpgrade = {
	private _vec = (getCameraViewDirection player) vectorMultiply 5;
	_posCam = AGLToASL positionCameraToWorld [0,0,0];
	_lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,1,"GEOM","NONE"];
	if (_lis isEqualTo [] || {typeOf (_lis select 0 select 2) isEqualTo BRPVP_superBoxClass}) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		private _obj = _lis select 0 select 2;
		if (_obj isKindOf "ReammoBox_F" && (_obj getVariable ["id_bd",-1]) isNotEqualTo -1) then {
			if (_obj getVariable ["brpvp_box_level",1] isEqualTo 2) then {
				"erro" call BRPVP_playSound;
				[localize "str_base_box_max_upgrade_reached",-5] call BRPVP_hint;
				false
			} else {
				private _exec = "_this setVariable ['brpvp_box_level',2,true];[_this,BRPVP_customBaseBoxSizeUpgrade] remoteExecCall ['setMaxLoad',2];";
				[_obj getVariable "id_bd",_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
				_obj setVariable ["brpvp_box_level",2,true];
				[_obj,BRPVP_customBaseBoxSizeUpgrade] remoteExecCall ["setMaxLoad",2];
				["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\box_upgrade.paa'/>",0,0.25,1.5,0,0,473245] call BRPVP_fnc_dynamicText;
				"box_upgrade" call BRPVP_playSound;
				true
			};
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	};
};
BRPVP_minervaShotItemOn = false;
BRPVP_minervaShotObj = objNull;
BRPVP_useMinervaShot = {
	if (BRPVP_minervaShotDisabled) exitWith {
		[localize "str_mishot_disabled",-6] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		false
	};
	if (!BRPVP_minervaShotItemOn && !BRPVP_safeZone && !(player getVariable "brpvp_extra_protection")) then {
		private _inVeh = !isNull objectParent player;
		private _inArmedVeh = [false,count allTurrets [objectParent player,false] > 0 || objectParent player isKindOf "Plane"] select _inVeh;
		if ((!_inVeh && currentWeapon player isEqualTo secondaryWeapon player) || _inArmedVeh) then {
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\minerva_shot.paa'/>",0,0.25,300,0,0,5343245] call BRPVP_fnc_dynamicText;
			[player,["danger",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
			BRPVP_minervaShotObj = objNull;
			BRPVP_minervaShotItemOn = true;
			diag_tickTime spawn {
				waitUntil {diag_tickTime-_this > 300 || !isNull BRPVP_minervaShotObj || (isNull objectParent player && currentWeapon player isNotEqualTo secondaryWeapon player) || (!isNull objectParent player && {!(objectParent player isKindOf "Plane") && count allTurrets [objectParent player,false] isEqualTo 0}) || !(player call BRPVP_pAlive) || !BRPVP_minervaShotItemOn};
				private _isMissile = BRPVP_minervaShotObj isKindOF "RocketBase" || BRPVP_minervaShotObj isKindOf "MissileBase" || BRPVP_minervaShotObj isKindOf "SubmunitionBase";
				if (isNull BRPVP_minervaShotObj || {!_isMissile}) then {
					BRPVP_minervaShotItemOn = false;
					BRPVP_minervaShotObj = objNull;
					["",0,0.25,1,0,0,5343245] call BRPVP_fnc_dynamicText;
					["BRPVP_minervaShot",1] call BRPVP_sitAddItem;
					"erro" call BRPVP_playSound;
				} else {
					[BRPVP_minervaShotObj,getPosWorld BRPVP_minervaShotObj] remoteExec ["BRPVP_drawMissileLaser",call BRPVP_playersList];
					["",0,0.25,1,0,0,5343245] call BRPVP_fnc_dynamicText;
					private _sm = getText (configFile >> "CfgAmmo" >> typeOf BRPVP_minervaShotObj >> "submunitionAmmo");
					private _lastMiPos = getPosWorld BRPVP_minervaShotObj;
					private _dangerOk = false;
					private _init = diag_tickTime;
					waitUntil {
						if (isNull BRPVP_minervaShotObj && _sm isNotEqualTo "") then {
							private _smFound = nearestObjects [ASLToAGL _lastMiPos,[_sm],75];
							if (_smFound isNotEqualTo []) then {BRPVP_minervaShotObj = selectRandom _smFound;};
						};
						if (!isNull BRPVP_minervaShotObj) then {
							private _newMiPos = getPosWorld BRPVP_minervaShotObj;
							if (!_dangerOk) then {
								private _vec = ((_newMiPos vectorDiff _lastMiPos) vectorMultiply 50) vectorAdd [0,0,-((diag_tickTime-_init) min 5)];
								private _lis = lineIntersectsSurfaces [_newMiPos,_newMiPos vectorAdd _vec,BRPVP_minervaShotObj,objNull,true,1,"GEOM","NONE",true];
								if (_lis isNotEqualTo []) then {
									[player,["child_danger",400]] remoteExecCall ["say3D",BRPVP_allNoServer];
									_dangerOk = true;
								};
							};
							_lastMiPos = _newMiPos;
						};
						isNull BRPVP_minervaShotObj
					};
					_lastMiPos = _lastMiPos vectorAdd [0,0,7.5];
					private _lastMiPosAGL = ASLToAGL _lastMiPos;
					private _limit = 10;
					private _init = diag_tickTime;
					private _bombTime = 8;
					private _bombMinRad = 10;
					private _thick = 10;
					private _bombFinalRad = 70;
					private _bombs = 100;
					private _stuffProtect = [];
					private _hideIdx = 0;
					private _radStep = 0;
					private _areaAI = _lastMiPosAGL nearEntities [["SoldierWB","SoldierGB"],_bombFinalRad+25];
					private _objsToProtect = nearestObjects [_lastMiPosAGL,["Building","Wall"],_bombFinalRad+50];
					_objsToProtect append nearestTerrainObjects [_lastMiPosAGL,["HOUSE","WALL","FENCE"],_bombFinalRad+50,false];
					_objsToProtect = _objsToProtect arrayIntersect _objsToProtect;
					_objsToProtect = _objsToProtect apply {[_x distance _lastMiPosAGL,_x]};
					_objsToProtect sort true;
					_objsToProtect = _objsToProtect apply {_x select 1};
					{if (_x getVariable ["own",-2] isEqualTo -2 && isDamageAllowed _x && !(_x getVariable ["brpvp_yes_minerva",false])) then {_stuffProtect pushBack _x;};} forEach _objsToProtect;
					private _spCount = count _stuffProtect;
					for "_i" from 1 to _bombs do {
						private _perc = _i/_bombs;
						private _radLimMax = _bombMinRad+(_bombFinalRad-_bombMinRad)*_perc;
						private _radLimMin= (_radLimMax-_thick) max 0;
						private _rad = sqrt((_radLimMin+random _thick)^2);
						private _angle = random 360;
						private _pos = _lastMiPos vectorAdd [_rad*sin _angle,_rad*cos _angle,0];
						private _maxSide = 0;
						private _radPart = _rad*0.25;
						if (_radLimMax > _radStep) then {
							private _nad = [];
							_radStep = _radLimMax+15;
							{if (_x distance _lastMiPosAGL < _radLimMax+50) then {_nad pushBack _x;} else {_hideIdx = _hideIdx+_forEachIndex;break};} forEach (_stuffProtect select [_hideIdx,_spCount-_hideIdx]);
							[_nad,false] remoteExecCall ["BRPVP_minervaShotServerAllowDamage",2];
						};
						for "_h" from -_radPart to _radPart step (_radPart min 10) do {
							private _local = _lastMiPos vectorAdd [_rad*sin _angle,_rad*cos _angle,_h];
							private _lis = lineIntersectsSurfaces [_lastMiPos,_local,objNull,objNull,true,2,"GEOM","NONE",true];
							if (_lis isEqualTo [] || {({(_x select 2) in _stuffProtect} count _lis) isEqualTo count _lis}) exitWith {_pos = _local;};
							private _dist = (_lis select 0 select 0) distance2D _lastMiPos;
							if (_dist > _maxSide) then {_pos = _lis select 0 select 0;};
						};
						private _lisD = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,-_limit],objNull,objNull,true,1,"GEOM","NONE",true];
						private _lisU = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,+_limit],objNull,objNull,true,1,"GEOM","NONE",true];
						private _bomb = selectRandom ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","ATMine_Range_Ammo"];
						if (_lisD isEqualTo []) then {
							if (_lisU isEqualTo []) then {
								private _z = (selectRandom [-1,1])*random (_rad*(1-_rad/_bombFinalRad));
								if (abs _z <= _limit) then {
									[_bomb,ASLToAGL _pos vectorAdd [0,0,_z],player,player] remoteExecCall ["BRPVP_explodeBombServer",2];
								} else {
									private _lis = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,_z],objNull,objNull,true,1,"GEOM","NONE",true];
									if (_lis isEqualTo []) then {
										[_bomb,ASLToAGL _pos vectorAdd [0,0,_z],player,player] remoteExecCall ["BRPVP_explodeBombServer",2];
									} else {
										[_bomb,ASLToAGL (_lis select 0 select 0),player,player] remoteExecCall ["BRPVP_explodeBombServer",2];
									};
								};
							} else {
								private _ePos = ASLToAGL (_lisU select 0 select 0);
								if (_ePos select 2 < 0) then {_ePos set [2,0];};
								[_bomb,_ePos,player,player] remoteExecCall ["BRPVP_explodeBombServer",2];
							};
						} else {
							private _ePos = ASLToAGL (_lisD select 0 select 0);
							if (_ePos select 2 < 0) then {_ePos set [2,0];};
							[_bomb,_ePos,player,player] remoteExecCall ["BRPVP_explodeBombServer",2];
						};
						private _elapsed = diag_tickTime-_init;
						uisleep (_bombTime/_bombs);
					};
					private _aiAlive = [];
					{
						private _dead = _x getVariable ["brpvp_tai_dead",false];
						private _trauma = _x getVariable ["brpvp_trauma",false];
						private _hasPath = _x checkAIFeature "PATH";
						if (!_dead && !_trauma && _hasPath) then {_aiAlive pushBack _x;};
					} forEach _areaAI;
					{
						private _ai = _x;
						if (random 1 < 0.4) then {
							//REMOVE AND SAVE WEAPON ON HOLDER
							private _bn = binocular _ai;
							private _hg = handgunWeapon _ai;
							if (_bn isNotEqualTo "") then {[_ai,_bn] remoteExecCall ["removeWeapon",_ai];};
							if (_hg isNotEqualTo "") then {[_ai,_hg] remoteExecCall ["removeWeapon",_ai];};
							private _wps = [primaryWeapon _ai,secondaryWeapon _ai]-[""];
							if (_wps isNotEqualTo []) then {
								private _wh = createVehicle ["WeaponHolderSimulated",ASLToAGL getPosASL _ai,[],0,"NONE"];
								{
									_wh addWeaponCargoGlobal [_x,1];
									_wh addMagazineCargoGlobal [selectRandom getArray (configFile >> "CfgWeapons" >> _x >> "magazines"),1];
									[_ai,_x] remoteExecCall ["removeWeapon",_ai];
								} forEach _wps;

								//POSITIONE WEAPON HOLDER
								private _asl = getPosASL _wh;
								private _h = (ASLToAGL _asl select 2)+10;
								{
									private _obj = _x select 2;
									if ({_obj isKindOf _x} count ["Motorcycle","Air","LandVehicle","Ship","CaManBase","WeaponHolder"] isEqualTo 0 && {str _obj find _x isNotEqualTo -1} count BRPVP_treesAndBushs isEqualTo 0) exitWith {
										_wh setPosASL (_x select 0);
										_wh setVectorUp (_x select 1);
									};
								} forEach lineIntersectsSurfaces [_asl,_asl vectorAdd [0,0,-_h],_wh,objectParent _ai,true,-1,"GEOM","NONE"];
							};
							if (random 1 < 0.4) then {[_ai,["legs",1]] remoteExecCall ["setHit",_ai];};
						};
						_ai setVariable ["brpvp_trauma",true,true];
					} forEach _aiAlive;
					uiSleep 0.75;
					[_stuffProtect,true] remoteExecCall ["BRPVP_minervaShotServerAllowDamage",2];
					BRPVP_minervaShotItemOn = false;
					BRPVP_minervaShotObj = objNull;
				};
			};
			true
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_mishot_need_launcher",-5] call BRPVP_hint;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_useKriptoniteEffects = {
	params ["_sounder","_ulfan"];
	uiSleep 2;
	private _posATL = _ulfan modelToWorld [0,0,0];
	private _ps1 = "#particlesource" createVehicleLocal _posATL;
	_ps1 setParticleParams [["\A3\Data_F\ParticleEffects\Universal\Universal",16,10,32],"","Billboard",1,1,[0,0,0],[0,0,0.5],0,1,1,3,[0.5,1.5],[[1,1,1,0.4],[1,1,1,0.2],[1,1,1,0]],[0.25,1],1,1,"","",_ps1];
	_ps1 setParticleRandom [0.2,[0.5,0.5,0.25],[0.125,0.125,0.125],0.2,0.2,[0,0,0,0],0,0];
	_ps1 setDropInterval 0.025;
	uiSleep 2.5;
	private _ps2 = "#particlesource" createVehicleLocal _posATL;
	_ps2 setParticleParams [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1,1],"","Billboard",1,5,[0,0,1],[0,0,1.5],0,1,1,0.5,[1.75,2,3,4.5],[[1,1,1,0],[1,1,1,0.5],[1,1,1,0.4],[1,1,1,0.2],[1,1,1,0]],[0.5,0.5],0,0,"","",_ps2];
	_ps2 setParticleRandom [0.5,[1,1,0.4],[0,0,0.5],0,0.125,[0,0,0,0],rad 30,0];
	_ps2 setDropInterval 0.075;
	uiSleep 5;
	{{deleteVehicle _x;} forEach ((nearestObjects [_x,[],0.001])-[_ulfan]);} forEach [_ps1,_ps2];
	private _ps3 = "#particlesource" createVehicleLocal _posATL;
	_ps3 setParticleParams [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1,1],"","Billboard",1,5,[0,0,1],[0,0,1.5],0,1,1,0.5,[1.75,2,3,4.5],[[1,1,1,0],[1,1,1,0.5],[1,1,1,0.4],[1,1,1,0.2],[1,1,1,0]],[0.5,0.5],0,0,"","",_ps3];
	_ps3 setParticleRandom [0.5,[1,1,0.4],[0,0,0.5],0,0.125,[0,0,0,0],rad 30,0];
	_ps3 setDropInterval 0.1;
	uiSleep 3.5;
	{deleteVehicle _x;} forEach ((nearestObjects [_ps3,[],0.001])-[_ulfan]);
	if (!isNull _sounder) then {deleteVehicle _sounder;};
};
BRPVP_useKriptonite = {
	private _nearPeter = (BRPVP_peterModel select {!isObjectHidden _x && alive _x && _x distance BRPVP_myPlayerOrUAV < 150 && !(_x getVariable ["brpvp_peter_kripto",false])}) apply {[_x distance BRPVP_myPlayerOrUAV,_x]};
	if (_nearPeter isEqualTo []) then {
		private _nearBots = (BRPVP_myPlayerOrUAV nearEntities ["CaManBase",125]) select {!isObjectHidden _x && isNull objectParent _x};
		private _nearUlfans = ((_nearBots arrayIntersect BRPVP_sBotAllUnitsObjs) select {alive _x}) apply {[_x distance BRPVP_myPlayerOrUAV,_x]};
		_nearUlfans sort true;
		if (_nearUlfans isEqualTo []) then {
			private _nearMinervaBots = ((_nearBots arrayIntersect BRPVP_minervaBotAllUnitsObjs) select {alive _x}) apply {[_x distance BRPVP_myPlayerOrUAV,_x]};
			_nearMinervaBots sort true;
			if (_nearMinervaBots isEqualTo []) then {
				"erro" call BRPVP_playSound;
				false
			} else {
				private _mBot = _nearMinervaBots select 0 select 1;
				private _sounder = "Land_HelipadEmpty_F" createVehicle [0,0,0];
				_sounder attachTo [_mBot,[0,0,1.5]];
				[_mBot,["head",BRPVP_ulfanSoldierExtraLife,true,player,player]] remoteExecCall ["setHit",_mBot];
				[_sounder,["sbot_death",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
				[_sounder,_mBot] remoteExec ["BRPVP_useKriptoniteEffects",BRPVP_allNoServer];
				true
			};
		} else {
			private _ulfan = _nearUlfans select 0 select 1;
			private _sounder = "Land_HelipadEmpty_F" createVehicle [0,0,0];
			_sounder attachTo [_ulfan,[0,0,1.5]];
			[_ulfan,["head",BRPVP_ulfanSoldierExtraLife,true,player,player]] remoteExecCall ["setHit",_ulfan];
			[_sounder,["sbot_death",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
			[_sounder,_ulfan] remoteExec ["BRPVP_useKriptoniteEffects",BRPVP_allNoServer];
			true
		};
	} else {
		_nearPeter sort true;
		private _peter = _nearPeter select 0 select 1;
		_peter setVariable ["brpvp_peter_kripto",true,true];
		[_peter,2,10,0.3] remoteExec ["BRPVP_peterSlowDownKriptos",_peter];
		true
	};
};
BRPVP_useKriptoniteRedEffects = {
	params ["_sounder","_lars"];
	private _posATL = _lars modelToWorld [0,0,0];
	private _ps1 = "#particlesource" createVehicleLocal _posATL;
	_ps1 setParticleParams [["\A3\Data_F\ParticleEffects\Universal\Universal",16,10,32],"","Billboard",1,1,[0,0,0],[0,0,0.5],0,1,1,3,[0.5,1.5],[[1,1,1,0.4],[1,1,1,0.2],[1,1,1,0]],[0.25,1],1,1,"","",_ps1];
	_ps1 setParticleRandom [0.2,[0.5,0.5,0.25],[0.125,0.125,0.125],0.2,0.2,[0,0,0,0],0,0];
	_ps1 setDropInterval 0.03;
	_ps1 attachTo [_lars,[0,0,0]];
	uiSleep 7.5;
	[_sounder,["lars_kripto",750]] remoteExecCall ["say3D",BRPVP_allNoServer];
	{deleteVehicle _x;} forEach ((nearestObjects [_ps1,[],0.001])-[_lars]);
	uiSleep 15;
	if (!isNull _sounder) then {deleteVehicle _sounder;};
};
BRPVP_useKriptoniteRed = {
	private _nearLars = (BRPVP_larsModel select {!isObjectHidden _x && alive _x && _x distance BRPVP_myPlayerOrUAV < 150}) apply {[_x distance BRPVP_myPlayerOrUAV,_x]};
	if (_nearLars isEqualTo []) then {
		private _nearPeter = (BRPVP_peterModel select {!isObjectHidden _x && alive _x && _x distance BRPVP_myPlayerOrUAV < 150 && !(_x getVariable ["brpvp_peter_kripto",false])}) apply {[_x distance BRPVP_myPlayerOrUAV,_x]};
		if (_nearPeter isEqualTo []) then {
			"erro" call BRPVP_playSound;
			false
		} else {
			_nearPeter sort true;
			private _peter = _nearPeter select 0 select 1;
			private _sounder = "Land_HelipadEmpty_F" createVehicle [0,0,0];
			_sounder attachTo [_peter,[0,0,1.5]];
			_peter setVariable ["brpvp_peter_kripto",true,true];
			[_peter,2.5,90,0.25] remoteExec ["BRPVP_peterSlowDownKriptos",_peter];
			[_sounder,_peter] remoteExec ["BRPVP_useKriptoniteRedEffects",BRPVP_allNoServer];
			true
		};
	} else {
		_nearLars sort true;
		private _lars = _nearLars select 0 select 1;
		private _sounder = "Land_HelipadEmpty_F" createVehicle [0,0,0];
		_sounder attachTo [_lars,[0,0,1.5]];
		_lars setVariable ["brpvp_lars_red_kripto_kill",true,true];
		private _hDam = _lars getHit "head";
		private _finalDam = (_hDam+0.60) min 1;
		[_lars,["head",_finalDam,true,player,player]] remoteExecCall ["setHit",_lars];
		_lars setVariable ["brpvp_lars_gdam","lars_life_"+str (16*ceil(_finalDam*128/16))+".paa",true];
		[_sounder,_lars] remoteExec ["BRPVP_useKriptoniteRedEffects",BRPVP_allNoServer];
		[_lars,["zombie_snd_50",1000]] remoteExecCall ["say3D",BRPVP_allNoServer];
		true
	};
};
BRPVP_useDivineFire = {
	"erro" call BRPVP_playSound;
	false
};
BRPVP_atomicShotItemOn = false;
BRPVP_atomicShotObj = objNull;
BRPVP_useAtomicShot = {
	if (BRPVP_atomicShotDisabled) exitWith {
		[localize "str_atshot_disabled",-6] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		false
	};
	if (!BRPVP_atomicShotItemOn && !BRPVP_minervaShotItemOn && !BRPVP_safeZone && !(player getVariable "brpvp_extra_protection")) then {
		private _img = ["BRP_imagens\pride_atomic_bomb.paa'/>","BRP_imagens\atomic_bomb.paa'/>"] select (_this isEqualTo "normal");
		private _inVeh = !isNull objectParent player;
		private _inArmedVeh = [false,count allTurrets [objectParent player,false] > 0 || objectParent player isKindOf "Plane"] select _inVeh;
		if ((!_inVeh && currentWeapon player isEqualTo secondaryWeapon player) || _inArmedVeh) then {
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+_img,0,0.25,300,0,0,43245] call BRPVP_fnc_dynamicText;
			[player,["atomic_bomb_preparing",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
			BRPVP_atomicShotObj = objNull;
			BRPVP_atomicShotItemOn = true;
			[diag_tickTime,_this] spawn {
				params ["_tickTime","_type"];
				waitUntil {diag_tickTime-_tickTime > 300 || !isNull BRPVP_atomicShotObj || (isNull objectParent player && currentWeapon player isNotEqualTo secondaryWeapon player) || (!isNull objectParent player && {!(objectParent player isKindOf "Plane") && count allTurrets [objectParent player,false] isEqualTo 0}) || !(player call BRPVP_pAlive) || !BRPVP_atomicShotItemOn};
				private _isMissile = BRPVP_atomicShotObj isKindOF "RocketBase" || BRPVP_atomicShotObj isKindOf "MissileBase" || BRPVP_atomicShotObj isKindOf "SubmunitionBase";
				if (isNull BRPVP_atomicShotObj || {!_isMissile}) then {
					BRPVP_atomicShotItemOn = false;
					BRPVP_atomicShotObj = objNull;
					["",0,0.25,1,0,0,43245] call BRPVP_fnc_dynamicText;
					["BRPVP_atomicShot",1] call BRPVP_sitAddItem;
					"erro" call BRPVP_playSound;
				} else {
					[BRPVP_atomicShotObj,getPosWorld BRPVP_atomicShotObj,["atomic_bomb_travel_1","atomic_bomb_travel_2"] select (_type isEqualTo "normal")] remoteExec ["BRPVP_drawAtomicMissileLaser",call BRPVP_playersList];
					["",0,0.25,1,0,0,43245] call BRPVP_fnc_dynamicText;
					private _sm = getText (configFile >> "CfgAmmo" >> typeOf BRPVP_atomicShotObj >> "submunitionAmmo");
					private _lastMiPos = getPosWorld BRPVP_atomicShotObj;
					private _dangerOk = false;
					private _init = diag_tickTime;
					waitUntil {
						if (isNull BRPVP_atomicShotObj && _sm isNotEqualTo "") then {
							private _smFound = nearestObjects [ASLToAGL _lastMiPos,[_sm],75];
							if (_smFound isNotEqualTo []) then {BRPVP_atomicShotObj = selectRandom _smFound;};
						};
						if (!isNull BRPVP_atomicShotObj) then {
							private _newMiPos = getPosWorld BRPVP_atomicShotObj;
							if (!_dangerOk) then {
								private _vec = ((_newMiPos vectorDiff _lastMiPos) vectorMultiply 50) vectorAdd [0,0,-((diag_tickTime-_init) min 5)];
								private _lis = lineIntersectsSurfaces [_newMiPos,_newMiPos vectorAdd _vec,BRPVP_atomicShotObj,objNull,true,1,"GEOM","NONE",true];
								if (_lis isNotEqualTo []) then {
									//[player,["child_danger",400]] remoteExecCall ["say3D",BRPVP_allNoServer];
									_dangerOk = true;
								};
							};
							_lastMiPos = _newMiPos;
						};
						isNull BRPVP_atomicShotObj
					};
					_lastMiPos = _lastMiPos vectorAdd [0,0,0.75];
					private _lastMiPosAGL = ASLToAGL _lastMiPos;
					private _ab = createSimpleObject ["Box_NATO_AmmoVeh_F",_lastMiPos];
					_ab setObjectScale 0.8;
					private _nearPlayers = call BRPVP_playersList select {_x distance _lastMiPosAGL < 4500};
					"atomic_bomb_sign" remoteExecCall ["BRPVP_playSound",_nearPlayers];
					[["world_destroyer",1]] call BRPVP_mudaExp;
					[_lastMiPos,player,5,_type] spawn BRPVP_spawnAtomicBomb;

					uiSleep 5;
					deleteVehicle _ab;
					uiSleep 5;

					private _aiAlive = [];
					{
						private _dead = _x getVariable ["brpvp_tai_dead",false];
						private _trauma = _x getVariable ["brpvp_trauma",false];
						private _hasPath = _x checkAIFeature "PATH";
						if (!_dead && !_trauma && _hasPath) then {_aiAlive pushBack _x;};
					} forEach (_lastMiPosAGL nearEntities [["SoldierWB","SoldierGB"],1000]);
					{
						private _ai = _x;
						if (random 1 < 0.5) then {
							//REMOVE AND SAVE WEAPON ON HOLDER
							private _bn = binocular _ai;
							private _hg = handgunWeapon _ai;
							if (_bn isNotEqualTo "") then {[_ai,_bn] remoteExecCall ["removeWeapon",_ai];};
							if (_hg isNotEqualTo "") then {[_ai,_hg] remoteExecCall ["removeWeapon",_ai];};
							private _wps = [primaryWeapon _ai,secondaryWeapon _ai]-[""];
							if (_wps isNotEqualTo []) then {
								private _wh = createVehicle ["WeaponHolderSimulated",ASLToAGL getPosASL _ai,[],0,"NONE"];
								{
									_wh addWeaponCargoGlobal [_x,1];
									_wh addMagazineCargoGlobal [selectRandom getArray (configFile >> "CfgWeapons" >> _x >> "magazines"),1];
									[_ai,_x] remoteExecCall ["removeWeapon",_ai];
								} forEach _wps;

								//POSITIONE WEAPON HOLDER
								private _asl = getPosASL _wh;
								private _h = (ASLToAGL _asl select 2)+10;
								{
									private _obj = _x select 2;
									if ({_obj isKindOf _x} count ["Motorcycle","Air","LandVehicle","Ship","CaManBase","WeaponHolder"] isEqualTo 0 && {str _obj find _x isNotEqualTo -1} count BRPVP_treesAndBushs isEqualTo 0) exitWith {
										_wh setPosASL (_x select 0);
										_wh setVectorUp (_x select 1);
									};
								} forEach lineIntersectsSurfaces [_asl,_asl vectorAdd [0,0,-_h],_wh,objectParent _ai,true,-1,"GEOM","NONE"];
							};
							if (random 1 < 0.5) then {[_ai,["legs",1]] remoteExecCall ["setHit",_ai];};
						};
						_ai setVariable ["brpvp_trauma",true,true];
					} forEach _aiAlive;

					uiSleep 5;
					BRPVP_atomicShotItemOn = false;
					BRPVP_atomicShotObj = objNull;
				};
			};
			true
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_mishot_need_launcher",-5] call BRPVP_hint;
			false
		};
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_miraculousEyeDropUsing = false;
BRPVP_useMiraculousEyeDrop = {
	if (BRPVP_voodooSetPlayerToBlindRecoveryRunning) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		if (player getVariable ["brpvp_blind",false]) then {
			if (BRPVP_lightBlindRunning isNotEqualTo 0) then {
				"erro" call BRPVP_playSound;
				false
			} else {
				0 spawn {
					if (BRPVP_lightBlindRunning isNotEqualTo 0) then {
						"erro" call BRPVP_playSound;
						["BRPVP_miraculousEyeDrop",1] call BRPVP_sitAddItem;
					} else {
						if (BRPVP_blindHandle isNotEqualTo -1) then {
							"eye_drop" call BRPVP_playSound;
							["<img shadow='0' size='3.0' image='"+BRPVP_imagePrefix+"BRP_imagens\eye_drop_begin.paa'/>",0,0.25,3,2.2,0,32657] call BRPVP_fnc_dynamicText;
							uiSleep 2.5;
							if (BRPVP_lightBlindRunning isNotEqualTo 0) then {
								["",0,0.25,3,2.2,0,32657] call BRPVP_fnc_dynamicText;
								"erro" call BRPVP_playSound;
								["BRPVP_miraculousEyeDrop",1] call BRPVP_sitAddItem;
							} else {
								BRPVP_miraculousEyeDropUsing = true;
								BRPVP_blindHandle ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,1],[-1,-1,0,0,0,0,0]];
								BRPVP_blindHandle ppEffectCommit 3;
								["<img shadow='0' size='3.0' image='"+BRPVP_imagePrefix+"BRP_imagens\eye_drop_end.paa'/>",0,0.25,1,3,0,32658] call BRPVP_fnc_dynamicText;
								waitUntil {ppEffectCommitted BRPVP_blindHandle || BRPVP_lightBlindRunning isNotEqualTo 0};
								if (BRPVP_lightBlindRunning isNotEqualTo 0) then {
									["",0,0.25,3,2.2,0,32657] call BRPVP_fnc_dynamicText;
									["",0,0.25,3,2.2,0,32658] call BRPVP_fnc_dynamicText;
									"erro" call BRPVP_playSound;
									["BRPVP_miraculousEyeDrop",1] call BRPVP_sitAddItem;
								} else {
									BRPVP_blindHandle ppEffectEnable false;
									ppEffectDestroy BRPVP_blindHandle;
									BRPVP_blindHandle = -1;
									player setVariable ["brpvp_blind",false,true];
									(player getVariable "id_bd") remoteExecCall ["BRPVP_blindPlayersIdRemove",2];
								};
								BRPVP_miraculousEyeDropUsing = false;
							};
						} else {
							player setVariable ["brpvp_blind",false,true];
						};
					};
				};
				true
			};
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	};
};
BRPVP_useAntiAtomicBomb = {
	private _flags = nearestObjects [player,["FlagCarrier"],10] select {!(_x getVariable ["brpvp_anti_abomb_in_use",false]) && _x getVariable ["id_bd",-1] isNotEqualTo -1 && (lineIntersectsSurfaces [eyePos player,getPosWorld _x,player,_x,true,1,"GEOM","NONE"] isEqualTo [] || lineIntersectsSurfaces [eyePos player,getPosASL _x,player,_x,true,1,"GEOM","NONE"] isEqualTo [] || lineIntersectsSurfaces [eyePos player,getPosWorld _x vectorAdd [0,0,1.5],player,_x,true,1,"GEOM","NONE"] isEqualTo [])};
	if (_flags isEqualTo []) then {
		["<t>"+localize "str_antia_need_flag_near"+"</t>",0,0.3,5,0,0,67628] call BRPVP_fnc_dynamicText;
		false
	} else {
		private _flag = _flags select 0;
		if (serverTime-(_flag getVariable ["brpvp_last_intrusion",-BRPVP_raidNoConstructionOnBaseIfRaidStartedTime]) < BRPVP_raidNoConstructionOnBaseIfRaidStartedTime) then {
			"erro" call BRPVP_playSound;
			["<t>"+localize "str_anti_atomic_bomb_cant"+"</t>",0,0.3,5,0,0,21568] call BRPVP_fnc_dynamicText;
			false
		} else {
			_flag setVariable ["brpvp_anti_abomb_in_use",true,true];
			private _minToUse = 5;
			private _rad = _flag getVariable "brpvp_flag_radius";
			private _objs = nearestObjects [_flag,[],_rad,true] select {isObjectHidden _x && _x getVariable ["id_bd",-1] isNotEqualTo -1};
			private _floorObjs = BRPVP_atomicBombHiddenBigFloors select {(_x select 1) distance2D _flag <= _rad};
			private _count = count _objs+count _floorObjs;
			if (_count < _minToUse) then {
				["<t>"+format [localize "str_antia_need_more_objs",_minToUse]+"</t>",0,0.3,5,0,0,67628] call BRPVP_fnc_dynamicText;
				_flag setVariable ["brpvp_anti_abomb_in_use",false,true];
				false
			} else {
				private _price = 120000*count _floorObjs;
				{
					private _ip = (typeOf _x) call BRPVP_getConstructionPrice;
					if (_ip isEqualTo 0) then {_price = _price+100000;} else {_price = _price+_ip/1.6;};
				} forEach _objs;
				private _mny = player getVariable ["mny",0];
				if (_mny >= _price) then {
					[_flag,ASLToAGL getPosASL player,_objs,_floorObjs,_count,_price] spawn {
						params ["_flag","_pos","_objs","_floorObjs","_count","_price"];
						private _loopWait = 0.1;
						["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\fly_money.paa'/><br /><t>"+format [localize "str_antia_confirm",_count,_price call BRPVP_formatNumber,7]+"</t>",0,0.25,2,0,0,67628] call BRPVP_fnc_dynamicText;
						"hackBeep" call BRPVP_playSound;
						private _distToOff = 0.25;
						private _init = diag_tickTime;
						waitUntil {diag_tickTime-_init >= 1.4 || player distance _pos > _distToOff};
						if (player distance _pos <= _distToOff) then {
							for "_i" from 6 to 1 step -1 do {
								["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\fly_money.paa'/><br /><t>"+format [localize "str_antia_confirm",_count,_price call BRPVP_formatNumber,_i]+"</t>",0,0.25,2,0,0,67628] call BRPVP_fnc_dynamicText;
								"hackBeep" call BRPVP_playSound;
								_init = diag_tickTime;
								waitUntil {diag_tickTime-_init >= 1.4 || player distance _pos > _distToOff};
								if (player distance _pos > _distToOff) exitWith {};
							};
							["",0,0.25,0,2,0,67628] call BRPVP_fnc_dynamicText;
							if (player distance _pos <= _distToOff) then {
								private _mny = player getVariable ["mny",0];
								if (_mny >= _price) then {
									player setVariable ["brpvp_flag_anti_abomb",_flag,[clientOwner,2]];
									player setVariable ["mny",_mny-_price,true];
									"negocio" call BRPVP_playSound;

									private _cfo = count _floorObjs;
									[_floorObjs,_loopWait] remoteExec ["BRPVP_showBigFloorPiecesMany",-clientOwner];
									BRPVP_atomicBombHiddenBigFloors = BRPVP_atomicBombHiddenBigFloors-_floorObjs;
									{
										_x params ["_bfid","_pos"];
										private _obj = nearestObject _pos;
										if (_obj getVariable ["brpvp_bf_bfid",-1] isEqualTo _bfid) then {
											_obj hideObject false;
											["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\anti_atomic_bomb_work.paa'/><br /><t>"+format [localize "str_antia_work_perc",_forEachIndex+1,_count]+"</t>",0,0.25,1.5,0,0,82650] call BRPVP_fnc_dynamicText;
											player say3D ["ciclo",125,0.6+0.8*(_forEachIndex+1)/_count];
										};
										if (1/diag_fps <= _loopWait) then {uiSleep _loopWait;} else {if (random 1 < (1/((1/diag_fps)/_loopWait))) then {uiSleep 0.001;};};
									} forEach _floorObjs;
									private _toGreen = [];
									{
										private _obj = _x;
										if (!isNull _obj && isObjectHidden _obj) then {
											private _oId = _obj getVariable "id_bd";
											if (netId _obj isEqualTo "0:0") then {
												if (typeOf _obj in BRPVP_buildingHaveDoorListCVL) then {
													[[typeOf _obj],[[_oId]],false] remoteExecCall ["BRPVP_hideGlobalSimpleObjectCVL",0];
												} else {
													[[typeOf _obj],[[_oId]],false] remoteExecCall ["BRPVP_hideGlobalSimpleObject",0];
												};
											} else {
												[_obj,false] remoteExecCall ["hideObjectGlobal",2];
											};
											private _vrColors = _obj getVariable ["brpvp_vr_colors",[]];
											if (_vrColors isEqualTo []) then {
												[_oId,""] remoteExecCall ["BRPVP_updateTurretExec",2];
											} else {
												private _exec = format ["[_this,'%1','%2'] call BRPVP_vrObjectSetTextures;",_vrColors#0,_vrColors#1];
												[_oId,_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
											};
											_toGreen pushBack _oId;
											if (count _toGreen isEqualTo 5) then {
												_toGreen remoteExecCall ["BRPVP_baseBombChangeToGreenMany",0];
												_toGreen = [];
											};
										};
										["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\anti_atomic_bomb_work.paa'/><br /><t>"+format [localize "str_antia_work_perc",_cfo+_forEachIndex+1,_count]+"</t>",0,0.25,1.5,0,0,82650] call BRPVP_fnc_dynamicText;
										player say3D ["ciclo",125,0.6+0.8*(_cfo+_forEachIndex+1)/_count];
										if (1/diag_fps <= _loopWait) then {uiSleep _loopWait;} else {if (random 1 < (1/((1/diag_fps)/_loopWait))) then {uiSleep 0.001;};};
									} forEach _objs;
									if (_toGreen isNotEqualTo []) then {_toGreen remoteExecCall ["BRPVP_baseBombChangeToGreenMany",0];};
									remoteExecCall ["BRPVP_baseBombCalcVisibleLines",call BRPVP_playersList select {_x distance _pos < 500}];

									//SET FLAG TO NO CONSTRUCTION
									if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
										if (!isNull _flag) then {
											if ([_flag] call BRPVP_isFlagsInRaidMode) then {_flag setVariable ["brpvp_last_intrusion",serverTime,true];};
										};
									};

									player setVariable ["brpvp_flag_anti_abomb",objNull,[clientOwner,2]];
									_flag setVariable ["brpvp_anti_abomb_in_use",false,true];
								} else {
									["<t>"+format [localize "str_antia_need_money_for_x_items",_price call BRPVP_formatNumber,_count]+"</t>",0,0.3,5,0,0,67628] call BRPVP_fnc_dynamicText;
									false
								};
							} else {
								"erro" call BRPVP_playSound;
								["BRPVP_antiAtomicBomb",1] call BRPVP_sitAddItem;
							};
						} else {
							["",0,0.25,0,2,0,67628] call BRPVP_fnc_dynamicText;
							"erro" call BRPVP_playSound;
							["BRPVP_antiAtomicBomb",1] call BRPVP_sitAddItem;
						};
					};
					true
				} else {
					_flag setVariable ["brpvp_anti_abomb_in_use",false,true];
					["<t>"+format [localize "str_antia_need_money_for_x_items",_price call BRPVP_formatNumber,_count]+"</t>",0,0.3,5,0,0,67628] call BRPVP_fnc_dynamicText;
					false
				};
			};
		};
	};
};
BRPVP_useMammothAmmo = {
	private _veh = objectParent player;
	_veh = if (isNull _veh) then {
		private _obj = cursorObject;
		if (_obj call BRPVP_isMotorized && _obj distanceSqr player < 64) then {_obj} else {objNull}; 
	} else {
		_veh
	};
	if (isNull _veh) then {
		"erro" call BRPVP_playSound;
		false
	} else {
		if (_veh isKindOf "HTNK") then {
			private _beforeAmmo = magazinesAllTurrets _veh;
			_veh setVehicleAmmo 1;
			private _afterAmmo = magazinesAllTurrets _veh;
			if (_afterAmmo isEqualTo _beforeAmmo) then {
				"erro" call BRPVP_playSound;
				false
			} else {
				[_veh,["mammoth_rearm",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
				true
			};
		} else {
			"erro" call BRPVP_playSound;
			false
		};
	};
};
BRPVP_usedVoodooDoll = {
	0 spawn {
		waitUntil {!BRPVP_menuExtraLigado};
		uiSleep 0.001;
		220 call BRPVP_iniciaMenuExtra;
	};
	true
};
BRPVP_useClassAll = [
	"Mag_BRPVP_hydraulic_jack",
	"Mag_BRPVP_z_blood_bag",
	"Mag_BRPVP_scanner_100",
	"Mag_BRPVP_scanner_200",
	"Mag_BRPVP_scanner_300",
	"Mag_BRPVP_fuel_gallon",
	"Mag_BRPVP_veh_ownerity",
	"BRPVP_hulk_pills",
	"BRPVP_drone_finder",
	"BRPVP_baseBomb",
	"BRPVP_personalTracer",
	"BRPVP_houseGodMode",
	"BRPVP_antiBaseBomb",
	"BRPVP_turnInBandit",
	"BRPVP_baseTest",
	"BRPVP_noGrass",
	"BRPVP_itemPaintVehicle",
	"BRPVP_itemPaintThinner",
	"BRPVP_itemClimb",
	"BRPVP_foodApple",
	"BRPVP_foodCanned",
	"BRPVP_foodBread",
	"BRPVP_foodWater",
	"BRPVP_foodCake",
	"BRPVP_foodBurger",
	"BRPVP_foodEnergyDrink",
	"BRPVP_playerLaunch",
	"BRPVP_bagSoldier",
	"BRPVP_carrier",
	"BRPVP_baseMine",
	"BRPVP_baseMineDefuse",
	"BRPVP_vehicleAmmo",
	"BRPVP_turretUpgrade",
	"BRPVP_xrayItem",
	"BRPVP_itemMagnet",
	"BRPVP_newsPaper",
	"BRP_zombieSpawn",
	"BRPVP_uberPack",
	"BRPVP_bigFloor200",
	"BRPVP_bigFloorRemove",
	"BRPVP_atmFix",
	"BRPVP_boxeItem",
	"BRPVP_selfRevive",
	"BRPVP_bodyChange",
	"BRPVP_vehicleTorque",
	"BRPVP_possession",
	"BRPVP_possessionStrong",
	"BRPVP_possessionPlayer",
	"BRPVP_uberAttack",
	"BRPVP_secCam",
	"BRPVP_trench",
	"BRPVP_baseBoxUpgrade",
	"BRPVP_minervaShot",
	"BRPVP_kriptonite",
	"BRPVP_kriptoniteRed",
	"BRPVP_divineFire",
	"BRPVP_atomicShot",
	"BRPVP_prideAtomicShot",
	"BRPVP_miraculousEyeDrop",
	"BRPVP_antiAtomicBomb",
	"BRPVP_mammothAmmo",
	"BRPVP_playerLaunchSuper",
	"BRPVP_voodooDoll"
];
BRPVP_useCodeAll = [
	{call BRPVP_usedHydraulic},
	{call BRPVP_useZBloodBag},
	{call BRPVP_usedScanner},
	{call BRPVP_usedScanner},
	{call BRPVP_usedScanner},
	{call BRPVP_usedFuelGallon},
	{call BRPVP_usedVehOwnerity},
	{call BRPVP_usedHulkPills},
	{call BRPVP_usedDroneFinder},
	{call BRPVP_usedBaseBomb},
	{call BRPVP_usePersonalTracer},
	{call BRPVP_useHouseGodMode},
	{call BRPVP_useAntiBaseBomb},
	{call BRPVP_useIntoBandit},
	{call BRPVP_useBaseTest},
	{call BRPVP_useNoGrass},
	{call BRPVP_useItemPaintVehicle},
	{call BRPVP_useItemPaintThinner},
	{call BRPVP_useItemClimb},
	{call BRPVP_usedFood},
	{call BRPVP_usedFood},
	{call BRPVP_usedFood},
	{call BRPVP_usedFood},
	{call BRPVP_usedFood},
	{call BRPVP_usedFood},	
	{call BRPVP_usedEnergetic},
	{call BRPVP_usedPlayerLaunch},
	{call BRPVP_usedBagSoldier},
	{call BRPVP_usedCarrier},
	{call BRPVP_usedBaseMine},
	{call BRPVP_usedBaseMineDefuse},
	{call BRPVP_usedVehicleAmmo},
	{call BRPVP_usedTurretUpgrade},
	{call BRPVP_usedXrayItem},
	{call BRPVP_usedItemMagnet},
	{call BRPVP_usedNewsPaper},
	{call BRP_usedZombieSpawn},
	{call BRPVP_usedUberPack},
	{call BRPVP_usedBigFloor200},
	{call BRPVP_usedBigFloorRemove},
	{call BRPVP_usedAtmFix},
	{call BRPVP_usedBoxeItem},
	{call BRPVP_usedSelfRevive},
	{call BRPVP_usedBodyChange},
	{call BRPVP_usedVehicleTorque},
	{[_this,0.25] call BRPVP_usedPossession},
	{[_this,0.75] call BRPVP_usedPossession},
	{[_this,1.00] call BRPVP_usedPossession},
	{call BRPVP_usedUberAttack},
	{call BRPVP_usedSecCam},
	{call BRPVP_usedTrench},
	{call BRPVP_usedBaseBoxUpgrade},
	{call BRPVP_useMinervaShot},
	{call BRPVP_useKriptonite},
	{call BRPVP_useKriptoniteRed},
	{call BRPVP_useDivineFire},
	{"normal" call BRPVP_useAtomicShot},
	{"pride" call BRPVP_useAtomicShot},
	{call BRPVP_useMiraculousEyeDrop},
	{call BRPVP_useAntiAtomicBomb},
	{call BRPVP_useMammothAmmo},
	{call BRPVP_usedPlayerLaunchSuper},
	{call BRPVP_usedVoodooDoll}
];