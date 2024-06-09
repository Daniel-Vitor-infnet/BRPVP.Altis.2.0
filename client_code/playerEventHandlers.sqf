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
diag_log "[SCRIPT] playerEventHandlers.sqf BEGIN";

//RECORD CURRENT PLAYER VISION MODE
player addEventHandler ["VisionModeChanged",{call BRPVP_visionModeChanged;}];
BRPVP_visionModeChanged = {
	private _data = (_this select [1,2])+(_this select [5,2]); //VISION MODE, TI_INDEX, VEHICLE, TURRET
	player setVariable ["brpvp_vision_mode",_data,BRPVP_specOnMeMachines];
};

//PLAYER RESPAWN EH
player addEventHandler ["Respawn",{call BRPVP_pehRespawn;}];
BRPVP_pehRespawn = {
	params ["_unit","_corpse"];
	diag_log "[BRPVP RESPAWN] PLAYER RESPAWNED";
	if (BRPVP_gogglesSaveError isEqualTo "") then {removeGoggles _corpse;} else {_corpse addGoggles BRPVP_gogglesSaveError};
	if !(goggles _unit isEqualTo "") then {removeGoggles _unit;};
	_corpse removeAllEventHandlers "Killed";
	_corpse removeAllEventHandlers "HandleDamage";
	_corpse removeAllEventHandlers "FiredMan";
	_corpse removeAllEventHandlers "GetInMan";
	_corpse removeAllEventHandlers "GetOutMan";
	_corpse removeAllEventHandlers "SeatSwitchedMan";
	_corpse removeAllEventHandlers "Put";
	_corpse removeAllEventHandlers "Take";
	_corpse removeAllEventHandlers "InventoryOpened";
	_corpse removeAllEventHandlers "InventoryClosed";
	_corpse removeAllEventHandlers "AnimDone";
	//_unit setVariable ["dd",-1,true];
	_unit setVariable ["sok",false,true];
	call BRPVP_atualizaDebug;
	cutText ["","BLACK FADED",10];
	BRPVP_playerDisabled = false;
	if (BRPVP_baseTestAction > -1) then {
		_corpse removeAction BRPVP_baseTestAction;
		BRPVP_baseTestAction = -1;
	};
	_unit call BRPVP_pelaUnidade;
	BRPVP_deathInVehTime = -1;
	if (_corpse getVariable "dd" isEqualTo 1) then {
		diag_log "[BRPVP RESPAWN] GOING NEXT LIFE (DD IS 1)";
		BRPVP_wpBox1 setVariable ["hrm",call BRPVP_getSyncTime,true];
		deleteVehicle _corpse;

		//NEXT LIFE
		_unit allowDamage false;
		0 spawn {
			["",0,0,0,0,0,3090] call BRPVP_fnc_dynamicText;
			cutText ["","BLACK FADED",10];
			sleep 1.5;
			[player,true] remoteExecCall ["hideObjectGlobal",2];
			player setVariable ["god",false,true];
			player setVariable ["brpvp_god_admin",false,true];
			player setVariable ["cmb",false,true];
			player setVariable ["veh",objNull,true];
			player setVariable ["cmv",cameraView,true];
			player setVariable ["dstp",1,true];
			player setVariable ["bui",objNull,true];
			player setVariable ["owt",[],true];
			player setVariable ["brpvp_fps",diag_fps,true];
			player linkItem "ItemMap";
			["",0,0,0,0,0,3091] call BRPVP_fnc_dynamicText; //EAR PLUGS IMAGE OFF (3091)
			if (player getVariable ["brpvp_base_test",0] > 0) then {player setVariable ["brpvp_base_test",0,true];};
			call BRPVP_variavies;
			call BRPVP_nascimento_player;
		};
	};
	_corpse spawn BRPVP_monitoreForUnderground;
};

BRPVP_putProtectionIfPVE = {
	private _insidePVE = player getVariable ["brpvp_pve_inside",0];
	private _insidePVP = player getVariable ["brpvp_in_pvp_zone",0];
	private _isBandit = player in BRPVP_pveBanditObjList;
	if (!_isBandit && _insidePVP isEqualTo 0 && _insidePVE > 0) then {
		_this setVariable ["own",player getVariable ["own",-1],true];
		_this setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
		_this setVariable ["stp",1,true];
		_this setVariable ["brpvp_can_use_master_key",false,true];
	};
};
BRPVP_createDeadPlayerBox = {
	BRPVP_wpBox1 = createVehicle ["Box_T_East_Wps_F",[0,0,0],[],0,"CAN_COLLIDE"];
	if (BRPVP_bornWithDeadItemsThisRound) then {[BRPVP_wpBox1,true] remoteExecCall ["hideObjectGlobal",2];};
	BRPVP_wpBox1 setPosASL (getPosASL player vectorAdd [0,0,0.3]);
	BRPVP_wpBox1 call BRPVP_emptyBox;
	BRPVP_wpBox1 setVariable ["brpvp_del_when_empty",true,true];
	BRPVP_wpBox1 allowDamage false;
	BRPVP_wpBox1 call BRPVP_putProtectionIfPVE;
	BRPVP_deadWWHS pushBack BRPVP_wpBox1;
};

//PLAYER KILLED EH
player addEventHandler ["Killed",{call BRPVP_pehKilled;}];
BRPVP_deathInVehTime = 0;
BRPVP_pehKilled = {
	params ["_unit","_killer","_instigator","_useEffects"];
	private _uncoDeath = player getVariable ["brpvp_uncoDeath",false];
	if (_uncoDeath) then {player setVariable ["brpvp_uncoDeath",false];} else {[_instigator,"Unknow_Projectile_F"] call BRPVP_pehKilledFakeHandleDamage;};
};
BRPVP_pehKilledFakeHandleDamage = {
	params ["_ofensor","_projectile",["_allowRevive",false]];

	BRPVP_lastOfensor = _ofensor;
	BRPVP_diedGun = [handGunWeapon player,handGunItems player,handGunMagazine player];

	//DEATH MESSAGE ARRAY
	BRPVP_mensagemDeKillArray = [
		time,
		if (isNull _ofensor) then {"Unknow_Soldier_F"} else {_ofensor getVariable ["nm",if (_ofensor getVariable ["ifz",-1] isEqualTo -1) then {localize "str_bots"} else {"Zeds"}]},
		if (_projectile isEqualTo "BRPVP_Punch") then {localize "str_punch"} else {_projectile},
		if (isNull _ofensor) then {"Unknow_Distance_F"} else {str round (player distance _ofensor)},
		_ofensor
	];

	//REMOVE PERSONAL BUSH
	if (!isNull BRPVP_personalBush) then {if (_projectile isNotEqualTo "") then {BRPVP_personalBushFired = true;};};

	//SET STRONG COMBAT MODE ON ATTACKER IF DAMAGED
	if (_ofensor call BRPVP_isPlayer && !BRPVP_safeZone && !((_ofensor getVariable "id_bd") in (player getVariable "amg")) && _projectile isNotEqualTo "" && _ofensor isNotEqualTo _atacado) then {
		remoteExecCall ["BRPVP_ligaModoCombateForteRemoto",_ofensor];
	};

	player setDamage BRPVP_pDamLim;
	player setVariable ["brpvp_allowRevive",_allowRevive];
	call BRPVP_doInconcious;
};

BRPVP_inPVPArea = {
	{_this distance2D (_x select 0) <= (_x select 1)} count BRPVP_PVPAreas > 0
};

BRPVP_doInconcious = {
	player setVariable ["brpvp_uncoDeath",true];

	if (player getVariable ["brpvp_atomic_bomb_death_sound",false]) then {
		playSound3D [BRPVP_playSound3dPrefix+"BRP_sons\disabled14.ogg",player,false,eyePos player,1,1,300];
	} else {
		playSound3D [BRPVP_playSound3dPrefix+"BRP_sons\"+(BRPVP_disabledSounds select (BRPVP_disabledSoundsIdc mod (count BRPVP_disabledSounds))),player,false,eyePos player,1,1,250];
	};
	private _ivh = (ASLToAGL getPosASL vehicle player) select 2 > 100;
	if (!isNull attachedTo player) then {detach player;};

	//=============================
	//OLD KILLED EH - HALF - BEGIN
	//=============================

	diag_log "[BRPVP] PLAYER UNCONSIOUS";

	//REMOVE DUKE NUKEM ACTIONS
	private _UAV = player call BRPVP_controlingUAV;
	if (isNull _UAV) then {objectParent player call BRPVP_disableNearServiceAction;} else {_UAV call BRPVP_disableNearServiceAction;};

	//CLOSE INVENTORY
	if (!isNull findDisplay 602) then {(findDisplay 602) closeDisplay 1;};

	//RELEASE CARRYING BOX
	private _b = player getVariable ["brpvp_box_carry",objNull];
	if (!isNull _b) then {
		BRPVP_boxCarryAction = false;
		player setVariable ["brpvp_box_carry",objNull,[clientOwner,2]];
		private _cargo = createVehicle ["WeaponHolderSimulated",getPosATL player,[],0,"CAN_COLLIDE"];
		[_b,_cargo,ASLToATL getPosASL player] remoteExecCall ["BRPVP_transferCargoCargoB",_b];
		_cargo setPosASL getPosASL player;
	};
	private _model = player getVariable ["brpvp_box_carry_model",objNull];
	if (!isNull _model) then {
		detach _model;
		deleteVehicle _model;
	};
	BRPVP_carryingBox = false;
	player setVariable ["brpvp_vault_perc",[0,0,"#FFFFFF"],BRPVP_specOnMeMachines];

	//SAVE INVENTORY BOXES
	{
		if (_x getVariable ["id_bd",-1] >= 0 && !(_x isKindOf "CAManBase")) then {
			if !(_x getVariable ["slv",false]) then {_x setVariable ["slv",true,true];};
		};
	} forEach BRPVP_inventoryBoxes;

	//REMOVE CARRY HELI AND BUS STOP ACTIONS
	if (BRPVP_carryHeliAction > -1) then {player removeAction BRPVP_carryHeliAction;};
	if (BRPVP_busStopAction > -1) then {
		player removeAction BRPVP_busStopAction;
		BRPVP_busStopAction = -1;
	};
	
	//STOP ADMIN FLY
	if (BRPVP_flyA || BRPVP_flyB || BRPVP_flyC) then {
		BRPVP_flyA = false;
		BRPVP_flyB = false;
		BRPVP_flyC = false;
		player setVelocity [0,0,1];
	};

	//TURN OFF ITEM MAGNET
	if (BRPVP_itemMagnetOn) then {player spawn BRPVP_itemMagnetOff;};

	//REMOVE DEAD BODY FROM VEHICLE
	private _vehicle = objectParent player;
	if (!isNull _vehicle) then {
		if (BRPVP_deathInVehTime isEqualTo -1) then {BRPVP_deathInVehTime = time;};
		if (ASLToAGL getPosASL _vehicle select 2 < 0.35) then {
			player setVehiclePosition [ASLToAGL getPosASL _vehicle vectorAdd [0,0,1],[],2,"NONE"];
		} else {
			private _angle = random 360;
			player setPosASL AGLToASL ((ASLToAGL getPosASL _vehicle) vectorAdd [5*cos _angle,5*sin _angle,0]);
		};
	};

	//CHECK IF RANDOM RESPAWN
	if (player isEqualTo BRPVP_lastOfensor || BRPVP_suicidou || BRPVP_starvedToDeath) then {
		BRPVP_randomSpawnPlayers pushBackUnique (player getVariable ["id_bd",-1]);
		publicVariable "BRPVP_randomSpawnPlayers";
	};
	
	//RECORD TURRET KILL
	private _turret = BRPVP_lastOfensor getVariable ["brpvp_turret",objNull];
	if (!isNull _turret && typeOf BRPVP_lastOfensor in ["B_Soldier_VR_F","C_Soldier_VR_F"] && _turret getVariable ["id_bd",-1] >= 0) then {
		private _flag = _turret call BRPVP_nearestFlagInside; //(FIO)
		private _line = [
			player getVariable ["id_bd",-1],
			player getVariable ["nm","no_name_found"],
			_turret getVariable ["id_bd",-1],
			_turret getVariable ["own",-1],
			_flag getVariable ["id_bd",-1],
			_flag getVariable ["own",-1]
		];
		_line remoteExecCall ["BRPVP_recordTurretKill",2];
	};

	//DISABLE GENERAL MESSAGE
	private _killer = BRPVP_mensagemDeKillArray select 4;
	if (!BRPVP_starvedToDeath) then {
		if (player isEqualTo _killer || isNull _killer) then {
			[player getVariable ["nm","no_name"],{systemChat format [localize "str_disable_message_alone",_this];}] remoteExecCall ["call",BRPVP_allNoServer];
			BRPVP_lastKillIsPlayer = false;
		} else {
			if (time-(BRPVP_mensagemDeKillArray select 0) < 2) then {
				private _pIdBd = player getVariable ["id_bd",-1];
				private _kPastFriends = _killer getVariable ["brpvp_past_friends",[]];
				private _friendKill = _pIdBd in _kPastFriends;

				private _mensagemDeKillArray = [player getVariable ["nm","no_name"]]+BRPVP_mensagemDeKillArray;
				if (_friendKill) then {
					[_mensagemDeKillArray,{systemChat format ([localize "str_disable_message_no_xp"]+_this);}] remoteExecCall ["call",BRPVP_allNoServer];
				} else {
					[_mensagemDeKillArray,{systemChat format ([localize "str_disable_message"]+_this);}] remoteExecCall ["call",BRPVP_allNoServer];
				};
				_mensagemDeKillArray = [player]+_mensagemDeKillArray+[getPosWorld player];
				_mensagemDeKillArray remoteExecCall ["BRPVP_killMsgRecordDisabled",2];
				BRPVP_lastKillIsPlayer = _killer getVariable ["brpvp_player_mode",""] != "";

				//STATISTICS
				if (!_friendKill) then {
					[["player_matou",1]] call BRPVP_mudaExp;
					private _expList = [["matou_player",1]];
					if (!isNull objectParent _killer) then {_expList pushBack ["mounted_kills",1];};
					_expList remoteExecCall ["BRPVP_mudaExp",_killer];
				};
			} else {
				[player getVariable ["nm","no_name"],{systemChat format [localize "str_disable_message_alone",_this];}] remoteExecCall ["call",BRPVP_allNoServer];
				BRPVP_lastKillIsPlayer = false;
			};
		};
	};
	
	//CHECK IF IS BOT KILL
	BRPVP_wasBotKill = _killer getVariable ["ifz",-1] isEqualTo -1 && _killer isKindOf "CaManBase" && _killer getVariable ["id_bd",-1] isEqualTo -1 && !(typeOf _killer in ["B_Soldier_VR_F","C_Soldier_VR_F"]);
	
	//SET PENALT ON KILLER IF NEWER PLAYER
	private _newerKilledByPlayer = false;
	if (_killer call BRPVP_isPlayer) then {
		private _isMyGroup = _killer in units group player;
		private _iTrustHin = (_killer getVariable ["id_bd",-1]) in (player getVariable ["amg",[]]);
		private _killerInBaseDistOk = (_killer call BRPVP_checkOnFlagState) isEqualTo 2 && _killer distance player < 1500;
		if !(_isMyGroup || _iTrustHin || _killerInBaseDistOk) then {
			if (player getVariable ["brpvp_is_newer",false] && !(player getVariable ["cmb",false]) && BRPVP_missionNearDist isEqualTo -1) then {
				private _nearKonvoy = false;
				{
					_x params ["_composition","_crew","_kPaa","_color"];
					private _compositionOk = [];
					{if (canMove _x) then {_compositionOk pushBack _x;};} forEach _composition;
					if ({player distanceSqr _x < 40000} count _compositionOk > 0) exitWith {_nearKonvoy = true;};
				} forEach BRPVP_konvoyCompositions;
				if (!_nearKonvoy) then {
					private _mb = _killer getVariable ["brpvp_mny_bank",0];
					private _mw = _killer getVariable ["mny",0];
					if (_mb+_mw >= BRPVP_newerPlayerKillPenalt*2/5) then {
						private _rfb = _mb min BRPVP_newerPlayerKillPenalt;
						private _pmb = player getVariable ["brpvp_mny_bank",0];
						_killer setVariable ["brpvp_mny_bank",_mb-_rfb,true];
						private _gain = 0;
						if (_rfb < BRPVP_newerPlayerKillPenalt && _mw > 0) then {
							private _rfw = (BRPVP_newerPlayerKillPenalt-_rfb) min _mw;
							_gain = _rfb+_rfw;
							_killer setVariable ["mny",_mw-_rfw,true];
						} else {
							_gain = _rfb;
						};
						player setVariable ["brpvp_mny_bank",_pmb+_gain,true];
						_gain remoteExecCall ["BRPVP_newerKillerMsg",_killer];
						["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\novato.paa'/><br/>+"+(_gain call BRPVP_formatNumber)+" $",0,0,2,0,0,82573] call BRPVP_fnc_dynamicText;
						"negocio" call BRPVP_playSound;
					} else {
						[player,"Rookie_Protection_F",true] call ["BRPVP_pehKilledFakeHandleDamage",_killer];
						0 remoteExecCall ["BRPVP_newerKillerMsg",_killer];
					};
					_newerKilledByPlayer = true;
				};
			};
		};
	};

	//TURN OFF HACK EVENTS
	player setVariable ["brpvp_hack_on_me",objNull,true];
	player setVariable ["brpvp_my_hack",[]];
	BRPVP_hackLines = [];

	//RUN MULT MOVE INVENTORY EXIT CODE
	if (BRPVP_menuIdc in [207,208,209,210,211]) then {
		private _u1 = BRPVP_menuVar1 getVariable ["brpvp_mm_using",objNull];
		private _u2 = BRPVP_menuVar2 getVariable ["brpvp_mm_using",objNull];
		if (_u1 isEqualTo player) then {BRPVP_menuVar1 setVariable ["brpvp_mm_using",objNull,true];};
		if (_u2 isEqualTo player) then {BRPVP_menuVar2 setVariable ["brpvp_mm_using",objNull,true];};
		BRPVP_menuVar1 = objNull;
		BRPVP_menuVar2 = objNull;
	};

	player removeAction BRPVP_actionFedidex;

	//IF MENU IS ON, PRESS A UNTIL MENU CLOSES
	if (BRPVP_menuExtraLigado) then {
		for "_i" from 1 to 20 do {
			if (BRPVP_menuVoltar isEqualType 0) then {BRPVP_menuVoltar spawn BRPVP_menuMuda;} else {call BRPVP_menuVoltar;};
			if (!BRPVP_menuExtraLigado) exitWith {};
		};
		BRPVP_menuExtraLigado = false;
		hintSilent "";
	};

	BRPVP_disabledSoundsIdc = BRPVP_disabledSoundsIdc+1;
	player setVariable ["dd",0,true];

	//BURY MONEY
	BRPVP_buryMoneyActionOn = false;	

	//STOP BUS SERVICE
	BRPVP_busServiceRunning = false;

	BRPVP_bornWithDeadItemsThisRound = BRPVP_bornWithDeadItems || _newerKilledByPlayer;
	if (BRPVP_bornWithDeadItemsThisRound) then {BRPVP_myBodyDeadItems = [getUnitLoadout player];};		

	//TURN ON RAID MODE
	if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
		private _kit = typeOf _killer in ["B_Soldier_VR_F","C_Soldier_VR_F"];
		if (_kit) then {
			if (vehicle _killer distance2D player < 450) then {
				if !([player,vehicle _killer] call BRPVP_checkRemoteAccessPlayerObject) then {
					private _kAllFlags = [vehicle _killer,25] call BRPVP_flagsInside;
					private _pAllFlags = [player,25] call BRPVP_flagsInside;
					private _sharedFlags = _kAllFlags arrayIntersect _pAllFlags;
					if (_sharedFlags isNotEqualTo []) then {
						private _killerArray = [ASLToAGL getPosASL vehicle _killer,vehicle _killer getVariable "own",vehicle _killer getVariable "amg"];
						private _playerArray = [ASLToAGL getPosASL player,player getVariable "id_bd",player getVariable "amg"];
						[_killerArray,_playerArray,_kAllFlags,_pAllFlags,_sharedFlags] spawn {
							params ["_killerArray","_playerArray","_kAllFlags","_pAllFlags","_sharedFlags"];
							private _kFlags = [_killerArray,_kAllFlags] call BRPVP_isFlagsFriendRelaxed;
							private _pFlags = [_playerArray,_pAllFlags] call BRPVP_isFlagsFriendRelaxed;
							if ((_kFlags arrayIntersect _sharedFlags) isEqualTo [] || (_pFlags arrayIntersect _sharedFlags) isEqualTo []) then {
								{_x setVariable ["brpvp_last_intrusion",serverTime,true];} forEach _kFlags;
								{_x setVariable ["brpvp_last_intrusion",serverTime,true];} forEach _pFlags;
							};
						};
					};
				};
			};
		} else {
			if (_killer call BRPVP_isPlayer && _killer isNotEqualTo player) then {
				if (_killer distance2D player < 450) then {
					if !((_killer getVariable "id_bd") in (player getVariable "amg")) then {
						private _kAllFlags = [_killer,25] call BRPVP_flagsInside;
						private _pAllFlags = [player,25] call BRPVP_flagsInside;
						private _sharedFlags = _kAllFlags arrayIntersect _pAllFlags;
						if (_sharedFlags isNotEqualTo []) then {
							private _playerArray = [ASLToAGL getPosASL player,player getVariable "id_bd",player getVariable "amg"];
							[_killer,_playerArray,_kAllFlags,_pAllFlags,_sharedFlags] spawn {
								params ["_killer","_playerArray","_kAllFlags","_pAllFlags","_sharedFlags"];
								private _kFlags = [_killer,_kAllFlags] call BRPVP_isFlagsFriendRelaxed;
								private _pFlags = [_playerArray,_pAllFlags] call BRPVP_isFlagsFriendRelaxed;
								if ((_kFlags arrayIntersect _sharedFlags) isEqualTo [] || (_pFlags arrayIntersect _sharedFlags) isEqualTo []) then {
									{_x setVariable ["brpvp_last_intrusion",serverTime,true];} forEach _kFlags;
									{_x setVariable ["brpvp_last_intrusion",serverTime,true];} forEach _pFlags;
								};
							};
						};
					};
				};
			};
		};
	};

	//===========================
	//OLD KILLED EH - HALF - END
	//===========================

	[_ivh,BRPVP_possOtherPlayer && BRPVP_possItemUsed in ["BRPVP_possession","BRPVP_possessionStrong"],BRPVP_uberBadEnd,BRPVP_hauntDeath,weaponsItems player] spawn {
		params ["_ivh","_possOtherAi","_uberBadEnd","_hauntDeath","_allWeapons"];
		private _dd = 0;
		if (BRPVP_starvedToDeath) then {
			if (_possOtherAi) then {
				waitUntil {!BRPVP_possOtherPlayer};
				_dd = 2;
				player setVariable ["dd",2,true];
			} else {
				_dd = 1;
				player setVariable ["dd",1,true];
			};
			player setUnconscious true;
			player setCaptive true;
		} else {
			private _autoRevive = false;
			if (_possOtherAi) then {_autoRevive = true;waitUntil {!BRPVP_possOtherPlayer};};
			if (_uberBadEnd) then {_autoRevive = true;BRPVP_uberBadEnd = false;};
			if (_hauntDeath) then {_autoRevive = true;BRPVP_hauntDeath = false;};
			player setUnconscious true;
			player setCaptive true;
			if (_autoRevive) then {
				_dd = 2;
				player setVariable ["dd",2,true];
			} else {
				private _canRevive = player getVariable ["brpvp_allowRevive",true];
				if (!_canRevive) then {
					player setVariable ["brpvp_allowRevive",true];
					_dd = 1;
					player setVariable ["dd",1,true];
				} else {
					BRPVP_allowBrpvpHint = false;
					private _disabledBleed = 0;
					private _disabledZombieDamage = 0;
					private _step = 0.5/300;
					private _initA = time;
					private _initB = time;
					private _initC = time;
					private _zombieDistance = if (isNull objectParent player) then {2.5} else {3.5};
					private _rMsg = if ("BRPVP_selfRevive" call BRPVP_sitCountItem > 0) then {"<br/>"+localize "str_press_to_revive"} else {""};
					[format [localize "str_revive_count"+_rMsg,round (((0.5-BRPVP_disabledDamage)*200) max 0),"%"],0] call BRPVP_hint;
					waitUntil {
						private _t = time;
						if (_t-_initA >= 1) then {
							_initA = _t;
							_disabledBleed = _disabledBleed+_step;
							private _ll = str (round (((0.5-(BRPVP_disabledDamage+_disabledBleed+_disabledZombieDamage))*200) max 0));
							[format [localize "str_revive_count"+_rMsg,_ll,"%"],0,200,0,"ciclo",true] call BRPVP_hint;
							private _attackingAmount = {animationState _x in ["awoppercmstpsgthwnondnon_end","awoppercmstpsgthwnondnon_throw"]} count (player nearEntities [BRPVP_zombieMotherClass,_zombieDistance]);
							_disabledZombieDamage = _disabledZombieDamage+_attackingAmount*0.01;
						};
						if (_t-_initB >= 0.5) then {
							_initB = _t;
							if (BRPVP_disabledDamage+_disabledBleed+_disabledZombieDamage >= 0.5) then {player setVariable ["dd",1,true];};
						};
						if (_ivh && {animationState player in ["unconsciousfacedown","unconsciousoutprone"] && getPos player select 2 > 10}) then {[player,"halofreefall_non"] remoteExecCall ["switchMove",0];};
						if (BRPVP_aiAttackUnconsciousPlayer) then {
							if (getPos player select 2 < 0.2) then {
								if (animationState player isNotEqualTo "unconsciousrevivedefault") then {[player,"unconsciousrevivedefault"] remoteExecCall ["switchMove",0];};
								if (time-_initC > BRPVP_aiAttackUnconsciousPlayerDelay) then {if (!BRPVP_playerIsCaptive && captive player && !BRPVP_safeZone) then {player setCaptive false;};};
							} else {
								_initC = time;
							};
						};
						if (!alive player) then {player setVariable ["dd",1,true];};
						_dd = player getVariable ["dd",0];
						_dd > 0
					};
					BRPVP_allowBrpvpHint = true;
					["",0,200,0,""] call BRPVP_hint;
				};
			};
		};
		if (!BRPVP_playerIsCaptive && captive player && !BRPVP_safeZone && !BRPVP_autoReviveUsing) then {player setCaptive false;};
		if (_dd isEqualTo 1 || !alive player) then {
			diag_log "[BRPVP] UNCONSCIOUS PLAYER WAS KILLED";

			if (_dd isNotEqualTo 1) then {
				player setVariable ["dd",1,true];
				_dd = 1;
			};
			
			//DECREASE AURA LIGHT FORCE
			0 spawn {
				private _init = diag_tickTime;
				private _hNow = BRPVP_disabledDamage min 0.5;
				private _hLeft = 0.5-BRPVP_disabledDamage;
				waitUntil {
					private _dlt = diag_tickTime-_init;
					BRPVP_disabledDamage = (_hNow+_hLeft*(_dlt/2)) min 0.5;
					BRPVP_disabledDamage isEqualTo 0.5 || _dlt > 2
				};
			};

			//MONEY PENALTY
			if (BRPVP_lostMoneyWhenDieUse) then {
				private _alivePerc = (diag_tickTime-BRPVP_aliveStartTime)/BRPVP_lostMoneyWhenDieAliveTimeForMin min 1;
				private _perc = (1-_alivePerc)*BRPVP_lostMoneyWhenDieMaxPercentage+_alivePerc*BRPVP_lostMoneyWhenDieMinPercentage;
				private _bank = player getVariable ["brpvp_mny_bank",0];
				private _pMny = (BRPVP_lostMoneyWhenDieStep*floor(_bank*_perc/BRPVP_lostMoneyWhenDieStep)) min BRPVP_lostMoneyWhenDieMaxValor;
				if (_pMny > 0) then {
					player setVariable ["brpvp_mny_bank",_bank-_pMny,true];
					["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\fly_money.paa'/><br /><t>Bank: -$"+(_pMny call BRPVP_formatNumber)+"</t>",0,0,2.5,0,0,6237] call BRPVP_fnc_dynamicText;
					"money_penalty" call BRPVP_playSound;
				};
			};

			//REMOVE PERSONAL BUSH
			if (!isNull BRPVP_personalBush) then {deleteVehicle BRPVP_personalBush;};

			//PUT PLAYER MAIN WEAPONS ON BOX
			player setDamage 1;
			playSound3D [BRPVP_playSound3dPrefix+"BRP_sons\nobreath.ogg",player,false,eyePos player,1,1,50];
			BRPVP_deadWWHS = [];
			BRPVP_wpBox1 = objNull;

			//private _pws = (weaponsItems player select [0,3])-[[]];
			//if (_pws isNotEqualTo []) then {
			//	call BRPVP_createDeadPlayerBox;
			//	{BRPVP_wpBox1 addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _pws;
			//};

			//PUT WEAPON 4 ON BOX
			private _wep4 = player getVariable ["brpvp_weapon_4",[]];
			player setVariable ["brpvp_weapon_4",[],true];
			if (_wep4 isNotEqualTo []) then {
				if (isNull BRPVP_wpBox1) then {call BRPVP_createDeadPlayerBox;};
				BRPVP_wpBox1 addWeaponWithAttachmentsCargoGlobal [_wep4 select 0,1];
			};
			if (BRPVP_bornWithDeadItemsThisRound) then {BRPVP_myBodyDeadItems pushBack _wep4;};

			//TURN OFF BOXE GLOOVES
			BRPVP_boxeItemOn = false;

			//UPDATE STATISTICS
			if (!BRPVP_starvedToDeath) then {
				private _matador = BRPVP_lastOfensor;
				if (_matador isKindOf "CAManBase") then {
					if (_matador call BRPVP_isPlayer) then {
						if (_matador isEqualTo player) then {
							if (BRPVP_suicidou) then {
								//MOREU SOZINHO: CONTROL + K (JA ESTATISTICOU)
								BRPVP_suicidou = false;
							} else {
								//MOREU SOZINHO: QUEDA OU CHOQUE FISICO
								[["queda",1]] call BRPVP_mudaExp;
							};
						};
					} else {
						//FOI MORTO POR BOT
						[["bot_matou",1]] call BRPVP_mudaExp;
					};
				};
			};

			//KILL MESSAGES
			if (BRPVP_starvedToDeath) then {
				BRPVP_mensagemDeKillTxt = ["BRPVP_morreu_4",[player getVariable ["nm","sem_nome"]]];
				BRPVP_starvedToDeath = false;
			} else {
				private _pNome = player getVariable ["nm","sem_nome"];
				private _tempoTiro = BRPVP_mensagemDeKillArray select 0;
				if (_tempoTiro > 0) then {
					private _tempoSangra = time-_tempoTiro;
					if (_tempoSangra < 2) then {
						private _aNome = BRPVP_mensagemDeKillArray select 2;
						BRPVP_mensagemDeKillTxt = ["BRPVP_morreu_1",[_pNome,BRPVP_mensagemDeKillArray select 1,_aNome,BRPVP_mensagemDeKillArray select 3]];
						([player,_pNome]+BRPVP_mensagemDeKillArray) remoteExecCall ["BRPVP_killMsgRecordKilled",2];
					} else {
						if (_tempoSangra < 10) then {
							BRPVP_mensagemDeKillTxt = ["BRPVP_morreu_2",[_pNome,BRPVP_mensagemDeKillArray select 1,str round _tempoSangra]];
						} else {
							BRPVP_mensagemDeKillTxt = ["BRPVP_morreu_3",[_pNome]];
						};
					};
				} else {
					BRPVP_mensagemDeKillTxt = ["BRPVP_morreu_3",[_pNome]];
				};
			};
			BRPVP_mensagemDeKillTxt call LOL_fnc_showNotification;

			//ENVIA MENSAGEM DE KILL PARA OUTROS PLAYERS
			BRPVP_mensagemDeKillTxtSend = BRPVP_mensagemDeKillTxt;
			publicVariable "BRPVP_mensagemDeKillTxtSend";

			//DELETA QUADRICICLO SE ELE ESTIVER VAZIO
			private _qdcl = player getVariable ["qdcl",objNull];
			if (!isNull _qdcl) then {if (crew _qdcl isEqualTo []) then {deleteVehicle _qdcl;};};

			//PUT HAND MONEY IN SUITCASE
			private _mny = player getVariable ["mny",0];
			if (_mny > 0) then {
				player setVariable ["mny",0,true];
				private _suitCase = "Land_Suitcase_F" createVehicle BRPVP_posicaoFora;
				_suitCase setVariable ["mny",_mny,true];
				_suitCase setPosWorld ((getPosWorld player) vectorAdd [0,0,1.5]);
				_suitCase call BRPVP_putProtectionIfPVE;
			};

			//FECHA VAULT SE ESTIVER ABERTA
			private _vault = player getVariable ["wh",objNull];
			if (!isNull _vault) then {call BRPVP_vaultRecolhe;};

			//SALVA AMIGOS, ESTATISTICAS ETC DO PLAYER NO BANCO DE DADOS PARA A PROXIMA VIDA
			private _salvaPlayer = player call BRPVP_pegaEstadoPlayer;
			_salvaPlayer set [8,0];
			_salvaPlayer remoteExecCall ["BRPVP_salvaPlayer",2];

			//REMOVE ANTI ZOMBIE BLOOD BAG
			if (player getVariable ["brpvp_z_blood_bag_on",false]) then {
				[false,player getVariable "id_bd"] remoteExecCall ["BRPVP_zombieBloodBagActiveAdd",2];
				player setVariable ["brpvp_z_blood_bag_on",false,true];
				["",0,0,0,0,0,3195] call BRPVP_fnc_dynamicText;
			};

			//REMOVE CLIMB ABILITY
			if (BRPVP_climbOn) then {
				[false,player getVariable "id_bd"] remoteExecCall ["BRPVP_climbActivePlayersAdd",2];
				BRPVP_climbOn = false;
			};

			//TURN OFF TRACERS
			if (BRPVP_tracerUse || player getVariable ["brpvp_tracer_on",false]) then {
				player setVariable ["brpvp_tracer_on",false,true];
				BRPVP_tracerUse = false;
			};

			if (BRPVP_bornWithDeadItemsThisRound) then {
				deleteVehicle BRPVP_wpBox1;
			} else {
				//PUT PLAYER ITEMS ON BOX
				if (isNull BRPVP_wpBox1) then {call BRPVP_createDeadPlayerBox;};
				[player,BRPVP_wpBox1,_allWeapons] call BRPVP_playerItemsToCargo;
				BRPVP_wpBox1 setVariable ["brpvp_owner_id",player getVariable ["id","0"],true];
			};

			//RESET NEWER DISCOVERED
			BRPVP_newersDiscovered = [];
			
			//RESET PLAYER PATH
			call BRPVP_ppathReset;

			BRPVP_gogglesSaveError = goggles player;
			if (BRPVP_bornWithDeadItemsThisRound) then {BRPVP_myBodyDeadItems pushBack getUnitLoadout player;};

			uiSleep 3;
			if (!isNull BRPVP_wpBox1) then {[player,BRPVP_wpBox1] call BRPVP_playerUniformToCargo;};
			uiSleep 0.125;
			setPlayerRespawnTime 0;
		} else {
			if (_dd isEqualTo 2) then {diag_log "[BRPVP] UNCONSCIOUS PLAYER WAS REVIVED";} else {diag_log "[BRPVP] ERROR 5578X";};

			//FROM RESPAW EH
			BRPVP_playerDisabled = false;
			BRPVP_deathInVehTime = -1;
			BRPVP_playerLastCorpse = objNull;

			//REVIVE
			playSound3D [BRPVP_playSound3dPrefix+"BRP_sons\wakeup.ogg",player,false,getPosASL player,1,1,100];
			player setUnconscious false;
			[player,"UnconsciousOutProne"] remoteExecCall ["switchMove",0];

			//DAMAGE
			player setDamage (BRPVP_averageDamageGeneral min 0.85);
			{player setHitIndex [_forEachIndex,_x min 0.85,false];} forEach (BRPVP_averageDamage select 2);
			player setVariable ["dd",-1,true];
			if (BRPVP_playerIsCaptive) then {player setCaptive true;};

			call BRPVP_atualizaDebug;
			setPlayerRespawnTime 1000;
			BRPVP_actionFedidex = player addAction ["<t color='#AAAAFF'>Fedidex Express</t>",{49 call BRPVP_iniciaMenuExtra;},"",1.5,false,true,"","isNull objectParent player"];
			if (player getVariable ["brpvp_base_test",0] isEqualTo 1) then {BRPVP_baseTestAction = player addAction ["<t color='#CC5555'>"+localize "str_stop_base_test"+"</t>",{call BRPVP_baseTestTurnOff;},nil,1.5,false];};

			//INCREASE AURA LIGHT FORCE
			0 spawn {
				private _init = diag_tickTime;
				BRPVP_disabledDamage = BRPVP_disabledDamage min 0.5;
				waitUntil {
					private _dlt = diag_tickTime-_init;
					BRPVP_disabledDamage = (BRPVP_disabledDamage*(1-(_dlt/5))) max 0;
					BRPVP_disabledDamage isEqualTo 0 || _dlt > 10 || (player getVariable ["dd",-1]) isEqualTo 0
				};
			};

			player setVariable ["brpvp_uncoDeath",false];
		};
	};
};

player addEventHandler ["HandleHeal",{call BRPVP_handleHeal;}];
BRPVP_handleHeal = {
	params ["_unit","_healer","_isMedic"];
	if (_healer call BRPVP_isPlayer) then {[["cure_repair",1]] remoteExecCall ["BRPVP_mudaExp",_healer];};
};

//VISION MODE CHANGE
/*
player addEventHandler ["VisionModeChanged",{call BRPVP_visionModeChanged;}];
BRPVP_visionModeChanged = {
	params ["_person","_visionMode","_TIindex","_visionModePrev","_TIindexPrev","_vehicle","_turret"];
	private _helperVar = player getVariable ["brpvp_my_car_fly_key",[objNull,objNull]];
	private _nitroFlyHelper = _helperVar select 1;
	if (!isNull _nitroFlyHelper) then {
		private _veh = objectParent player;
		if (!isNull _veh && _nitroFlyHelper in attachedObjects _veh) then {
			private _nitroAgntHelper = _helperVar select 2;
			detach _nitroFlyHelper;
			[_nitroFlyHelper,true] remoteExecCall ["hideObjectGlobal",2];
			[_nitroAgntHelper,true] remoteExecCall ["hideObjectGlobal",2];
			[_nitroFlyHelper,_veh] spawn {
				params ["_nitroFlyHelper","_veh"];
				_nitroFlyHelper attachTo [_veh,[0,0,0]];
			};
		};
	};
};
*/

//PLAYER HANDLEDAMAGE EH
player addEventHandler ["HandleDamage",{call BRPVP_pehHandleDamage;}];
BRPVP_damageMultEh = 1;
BRPVP_pehHandleDamage = {
	params ["_atacado","_parte","_dano","_ofensor","_projectile","_hitIndex","_instigator","_hitPoint"];
	private _fd = player getHitPointDamage _hitPoint;
	if (_atacado getVariable ["dd",-1] <= 0) then {
		//FRANTA TREATMENT
		private _isFranta = typeOf _ofensor isEqualTo "Land_Can_V2_F" && _projectile isEqualTo "HelicopterExploBig";
		if (_isFranta) then {_ofensor = _instigator;};

		//ATOMIC BOMB TREATMENT
		if (_atacado getVariable ["brpvp_atomic_bomb_death",false] && _projectile isEqualto "") then {
			_projectile = "Atomic_Bomb";
			_atacado setVariable ["brpvp_atomic_bomb_death",false];
		};

		private _dTime = diag_tickTime;
		private _damTokem = player getVariable ["brpvp_dam_tokem",0];
		if (_dTime-_damTokem > 0.02) then {
			player setVariable ["brpvp_dam_tokem",_dTime];

			//CHECK IF RUNNING OVER IN SAFEZONE			
			if (isNull _instigator && {!isNull _ofensor && _ofensor call BRPVP_isPlayer && !(_ofensor isEqualTo _atacado) && _projectile isEqualTo ""}) then {
				private _ofensorId = _ofensor getVariable ["id_bd",-1];
				private _atacadoAmg = _atacado getVariable ["amg",[]];
				private _trust = _ofensorId in _atacadoAmg;
				if (_atacado getVariable "god" && !_trust) then {
					private _noColl = _atacado getVariable ["brpvp_safe_no_collision",[]];
					private _vehOfensor = vehicle _ofensor;
					_noColl pushBack _vehOfensor;
					_atacado setVariable ["brpvp_safe_no_collision",_noColl];
					_vehOfensor disableCollisionWith _atacado;
				};
			};

			private _fromMoto = _ofensor call BRPVP_isMotorizedNoTurret;
			private _typeMoto = typeOf _ofensor;
			private _moto = _ofensor;
			_ofensor = if (isNull _instigator) then {
				private _ec = effectiveCommander _ofensor;
				if (isNull _ec) then {_ofensor} else {_ec};
			} else {
				_instigator
			};
			
			private _oIsBob = typeOf _ofensor isEqualto "C_Driver_1_F";
			private _selfAttack = _ofensor isEqualTo _atacado;
			private _veh = objectParent player;

			//DAMAGE MULT
			private _pIsPVE = player getVariable ["brpvp_pve_inside",0] > 0 && player getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0;
			private _oIsPVE = if (_fromMoto) then {
				{_moto distance2D (_x select 0) < _x select 1} count BRPVP_pveMainAreas > 0 && {_moto distance2D (_x select 0) < _x select 1} count BRPVP_pvpAreas isEqualTo 0
			} else {
				if (_oIsBob) then {
					{_ofensor distance2D (_x select 0) < _x select 1} count BRPVP_pveMainAreas > 0 && {_ofensor distance2D (_x select 0) < _x select 1} count BRPVP_pvpAreas isEqualTo 0
				} else {
					_ofensor getVariable ["brpvp_pve_inside",0] > 0 && _ofensor getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0
				};
			};
			private _pveMult = if (_pIsPVE || _oIsPVE) then {
				_isPlayer = _ofensor getVariable ["id_bd",-1] > -1 || _oIsBob;
				if (!_isPlayer || _selfAttack || (player in BRPVP_pveBanditObjList && _pIsPVE) || (_ofensor in BRPVP_pveBanditObjList && _oIsPVE) || _isFranta) then {
					1
				} else {
					if (_typeMoto in (BRPVP_artilleryLimit select 0)) then {player setVariable ["brpvp_no_arty_damage",diag_tickTime];};
					0
				};
			} else {
				1
			};

			//ARTY DELAYED NO DAMAGE
			private _delayedArtyMult = 1;
			if (diag_tickTime-(player getVariable ["brpvp_no_arty_damage",0]) < 1) then {
				private _case1 = _selfAttack && _hitPoint isEqualTo "hithead";
				private _case2 = isNull _ofensor;
				private _case3 = _moto isEqualTo vehicle player && isNull _instigator && _projectile isEqualTo "";
				if (_case1 || _case2 || _case3) then {_delayedArtyMult = 0;};
			};
			
			//DAMAGE FROM VEH WITH DAMAGE OFF DAY
			private _voUAV = _ofensor call BRPVP_controlingUAV;
			private _vo = if (isNull _voUAV) then {objectParent _ofensor} else {_voUAV};
			private _vehDamOffDay = if (typeOf _vo in BRPVP_noDamageVehList) then {
				0
			} else {
				if (typeOf objectParent _atacado in BRPVP_noDamageVehList && _ofensor call BRPVP_isPlayerC) then {0} else {1};
			};
			
			//FROM BASE NO RAID DAY
			private _baseMult = 1;
			if (!isNull _ofensor && isNull (_ofensor getVariable ["brpvp_turret",objNull])) then {
				if (!BRPVP_raidServerIsRaidDay) then {
					private _aInBase = [_atacado,BRPVP_noRaidDayBaseExtension] call BRPVP_checkOnFlagStateExtraRadius > 0 && ASLToAGL getPosASL _atacado select 2 <= BRPVP_maxBuildHeight+75;
					private _oInBase = [_ofensor,BRPVP_noRaidDayBaseExtension] call BRPVP_checkOnFlagStateExtraRadius > 0 && ASLToAGL getPosASL _ofensor select 2 <= BRPVP_maxBuildHeight+75;
					if !((_aInBase && _oInBase) || !(_aInBase || _oInBase)) then {
						[_aInBase,false] call BRPVP_cantHurtFromBaseMsg;
						if (_ofensor call BRPVP_isPlayer) then {[_oInBase,true] remoteExecCall ["BRPVP_cantHurtFromBaseMsg",_ofensor];};
						_baseMult = 0;
					};
				};
			};

			//IS TURRET BASE TEST
			private _vehOfensor = vehicle _ofensor;
			private _vehOfensorId = _vehOfensor getVariable ["id_bd",-1];
			private _baseTestMult = 1;
			if (_vehOfensor isKindOf "StaticWeapon" && _vehOfensorId > 0 && (player getVariable ["brpvp_base_test",0]) > 0) then {_baseTestMult = if (_vehOfensor call BRPVP_checaAcesso) then {0} else {1};};
			
			private _t50Lvl2Mult = [1,0] select (typeOf _instigator in ["B_Soldier_VR_F","C_Soldier_VR_F"] && _projectile in [BRPVP_autoTurretHmgLvl2Rocket,BRPVP_autoTurretHmgLvl2Penetrator] && !isNull _veh);
			private _colisionMult = [1,[1,0] select (_projectile isEqualTo "")] select (BRPVP_constantRunOn || !BRPVP_srunBeachDamage || player getVariable ["brpvp_halo_no_coll",false] || player getVariable ["brpvp_no_colision",false] || player getVariable ["brpvp_no_colision_ubadend",false] || player getVariable ["brpvp_no_colision_cam_base",false]);
			private _adminMult = [1,0] select ((_ofensor getVariable ["brpvp_player_mode",""]) in ["admin","moderator"] && !BRPVP_adminsModeratorsCanKillPlayersWithWeapons && !(_ofensor isEqualTo _atacado));
			private _godModeMult = [1,0] select (player getVariable "god" || player getVariable "brpvp_god_admin" || player getVariable "brpvp_extra_protection");
			private _adminFlyMult = [1,0] select ((BRPVP_flyA || BRPVP_flyB || BRPVP_flyC || BRPVP_flyOnOffAdmin) && !BRPVP_flyOnOff);
			private _PVPAreaMult = [1,0] select (_atacado call BRPVP_inPVPArea && {!(_ofensor call BRPVP_inPVPArea)});
			private _vehCollisionMult = [1,0] select (!isNull _veh && _veh isKindOF "LandVehicle" && _projectile isEqualTo "");
			private _baseFriendsMult = [1,[0,1] select ((((_atacado getVariable "brpvp_mafiwao") select 0) arrayIntersect ((_ofensor getVariable "brpvp_mafiwao") select 0)) isEqualTo [])] select (typeOf _ofensor isEqualTo BRPVP_playerModel);
			BRPVP_damageMultEh = (player getVariable ["brpvp_no_col_safe_repel",1])*_baseFriendsMult*_t50Lvl2Mult*_delayedArtyMult*_vehDamOffDay*_baseTestMult*_adminMult*_pveMult*_baseMult*_adminFlyMult*_godModeMult*_PVPAreaMult*_vehCollisionMult*_colisionMult/BRPVP_playerLifeMultiplier;
			//diag_log str [BRPVP_damageMultEh,_baseFriendsMult,_t50Lvl2Mult,_delayedArtyMult,_vehDamOffDay,_baseTestMult,_adminMult,_pveMult,_baseMult,_adminFlyMult,_godModeMult,_PVPAreaMult,_vehCollisionMult,_colisionMult,BRPVP_playerLifeMultiplier];

			//SHOW IS_PVP_AREA MESSAGE
			if (_PVPAreaMult isEqualTo 0 && _ofensor call BRPVP_isPlayer) then {[["str_pvparea_cant_hurt",[]],-6] remoteExecCall ["BRPVP_hint",_ofensor];};

			//RECORD LAST OFENSOR (MAN)
			if (isNull _ofensor) then {
				if (_projectile in ["HelicopterExploBig","Sh_105mm_HEAT_MP","B_25mm"]) then {
					if (ZB_agnts isEqualTo []) then {
						private _zombies = player nearEntities [BRPVP_zombieMotherClass,125];
						if !(_zombies isEqualTo []) then {BRPVP_lastOfensor = _zombies select 0;};
					} else {
						BRPVP_lastOfensor = ZB_agnts select 0;
					};
				};
			} else {
				BRPVP_lastOfensor = _ofensor;
			};
			
			//RECORD HAND GUN
			BRPVP_diedGun = [handGunWeapon player,handGunItems player,handGunMagazine player];

			if !(isNull _ofensor || _selfAttack) then {
				if (_projectile isNotEqualTo "") then {
					BRPVP_mensagemDeKillArray = [
						time,
						_ofensor getVariable ["nm",localize "str_bots"],
						if (_projectile isEqualTo "BRPVP_Punch") then {localize "str_punch"} else {_projectile},
						str round ((ASLToAGL getPosWorld vehicle player) distance (ASLToAGL getPosWorld vehicle _ofensor)),
						_ofensor
					];
				};
			};

			//REMOVE PERSONAL BUSH
			if (!isNull BRPVP_personalBush) then {if (_projectile isNotEqualTo "") then {BRPVP_personalBushFired = true;};};

			//SET STRONG COMBAT MODE ON ATTACKER IF DAMAGED
			if (_instigator call BRPVP_isPlayer && {!BRPVP_safeZone && !((_instigator getVariable "id_bd") in (_atacado getVariable "amg")) && _projectile isNotEqualTo "" && BRPVP_damageMultEh isNotEqualTo 0 && _instigator isNotEqualTo _atacado}) then {remoteExecCall ["BRPVP_ligaModoCombateForteRemoto",_instigator];};
			if (!(_instigator call BRPVP_isPlayer) && {!BRPVP_safeZone && _projectile isNotEqualTo "" && BRPVP_damageMultEh isNotEqualTo 0}) then {call BRPVP_ligaModoCombate;};
		} else {
			_ofensor = if (isNull _instigator) then {effectiveCommander _ofensor} else {_instigator};
			_selfAttack = _ofensor isEqualTo _atacado;
		};
		private _partIsGeneral = _hitPoint isEqualTo "";
		private _partIsHead = _hitPoint isEqualTo "hithead";

		//ALL TIME DAMAGE ADJUST
		if (!(player call BRPVP_pAlive) && BRPVP_deathInVehTime isEqualTo -1 && {!isNull objectParent player}) then {BRPVP_deathInVehTime = time;};
		private _deathInVeh = if (time-BRPVP_deathInVehTime < 0.5) then {0} else {1};

		//ADJUST DAMAGE
		private _damageNow = if (_partIsGeneral) then {damage _atacado} else {_atacado getHitPointDamage _hitPoint};
		private _dltDano = (_dano-_damageNow)*BRPVP_damageMultEh*_deathInVeh;
		_dano = _damageNow+_dltDano;

		//RECORD HEAD SHOT
		if (_partIsHead) then {
			if !(isNull _ofensor || _selfAttack) then {
				if (_atacado call BRPVP_pAlive && _dltDano > 0.9) then {
					if (_ofensor call BRPVP_isPlayer) then {
						[["levou_tiro_cabeca_player",1]] call BRPVP_mudaExp;
						[_ofensor,[["deu_tiro_cabeca_player",1]]] remoteExecCall ["BRPVP_mudaExpOutroPlayer",2];
					} else {
						[["levou_tiro_cabeca_bot",1]] call BRPVP_mudaExp;
					};
				};
			};
		};

		//UPDATE DISABLED PLAYER HEALTH
		if (_partIsGeneral) then {
			remoteExecCall ["BRPVP_setPlayerDamaged",BRPVP_specOnMeMachines];
			if (_atacado getVariable ["dd",-1] isEqualTo 0) then {
				if (!BRPVP_playerDisabled) then {
					BRPVP_playerDisabled = true;
					//BRPVP_disabledDamage = 0;
				};
				private _isPlayer = _ofensor call BRPVP_isPlayer;
				private _isBaseTurret = typeOf _ofensor in ["B_Soldier_VR_F","C_Soldier_VR_F"] && objectParent _ofensor isKindOf "StaticWeapon";
				if (_isPlayer || _isBaseTurret) then {BRPVP_disabledDamage = BRPVP_disabledDamage+(_dltDano max 0);} else {BRPVP_disabledDamage = BRPVP_disabledDamage+(_dltDano max 0 min BRPVP_aiDamageOnUnconsciousPlayer);};
			};
		};

		if (player getVariable ["dd",0] isEqualTo -1) then {
			private _isUnco = _hitPoint in ["hithead","hitbody",""] && _dano >= BRPVP_pDamLim;
			if (_isUnco) then {call BRPVP_doInconcious;_fd = BRPVP_pDamLim;} else {_fd = _dano min BRPVP_pDamLim;};
		} else {
			_fd = _damageNow min BRPVP_pDamLim;
		};
	};
	_fd
};

//PLAYER FIREDMAN EH
BRPVP_artyShotLast = [objNull,-1000];
BRPVP_lastShotTime = 0;
BRPVP_lastShotTimeDome = 0;
BRPVP_newerLastShot = 0;
BRPVP_firedLastAmmo = "";
BRPVP_firedFlyingBullets = [];
BRPVP_shotFrantaHit = {
	params ["_mine","_wait","_posPlayer"];
	if (_mine getVariable ["brpvp_mine_base",false]) then {
		_mine setVariable ["brpvp_mine_base",false,true];
		private _mineNew = createVehicle ["Land_Can_V2_F",BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
		{_mineNew setVariable [_x,_mine getVariable _x,true];} forEach allVariables _mine;
		(_this+[_mineNew]) spawn {
			params ["_mine","_wait","_posPlayer","_mineNew"];
			private _pMineBase = getPosWorld _mine;

			_mineNew setVectorDirAndUp [vectorDir _mine,vectorUp _mine];
			_mineNew setPosWorld _pMineBase;
			_mine setPosWorld BRPVP_posicaoFora;

			private _sm = createVehicle ["SmokeShell",ASLtoAGL (getPosASL _mine vectorAdd [0,0,20]),[],0,"NONE"];
			_sm hideObject true;
			[_sm,true] remoteExecCall ["hideObjectGlobal",2];
			_sm attachTo [_mineNew,[0,0,0]];
			private _vec = (vectorNormalized (_pMineBase vectorDiff _posPlayer)) vectorMultiply 10;
			_mineNew setPosWorld ((getPosWorld _mineNew) vectorAdd [0,0,0.025]);
			_mineNew setVelocity (_vec vectorAdd [-1.5+random 3,-1.5+random 3,6.5]);
			[_mineNew,["base_bomb_hit",200,0.95+random 0.1]] remoteExecCall ["say3D",BRPVP_allNoServer];
			_mineNew addForce [[0,+0.125,0],[0,0,+1]];
			_mineNew addForce [[0,-0.125,0],[0,0,-1]];
			uiSleep (6+random 2);
			private _owner = _mine getVariable "brpvp_mine_base_owner";
			private _found = objNull;
			{if (_x getVariable ["sok",false] && _x getVariable ["id_bd",-1] isEqualTo _owner) exitWith {_found = _x;};} forEach call BRPVP_playersList;
			[_mine,_mineNew,_found] remoteExec ["BRPVP_fantaMineExplodeHit",2];
			deleteVehicle _sm;
		};
		_mineNew
	} else {
		objNull
	};
};
BRPVP_followBullet = {
	params ["_lastPos","_ammo","_bullet","_posPlayer","_bPosLast"];
	private _vecCo = (player weaponDirection currentWeapon player) vectorMultiply 50;
	private _coObjs = ((lineIntersectsSurfaces [_lastPos,_lastPos vectorAdd _vecCo,vehicle player,objNull,true,-1]) apply {_x select 2})-[objNull];
	private _didSomething = [];
	private _velMagOriginal = vectorMagnitude velocity _bullet;
	private _dist = _bullet distance player;
	private _distBack = _dist;
	waitUntil {
		private _continue = !isNull _bullet;
		if (_continue) then {
			private _velMag = vectorMagnitude velocity _bullet;
			private _bPos = getPosWorld _bullet;
			private _dMult = _velMag/_velMagOriginal;
			private _co = cursorObject;
			_lastPos = _bPos;
			{
				if (typeOf _x isEqualTo BRPVP_spcItemsClass) then {
					private _blueTank = _x;
					private _dbt = _blueTank distance _bullet;
					uiSleep (_dbt/_velMag);
					["Sh_105mm_HEAT_MP",ASLToAGL getPosASL _blueTank,200] call BRPVP_trowBomb;			
					_didSomething pushBack _blueTank;
					deleteVehicle _blueTank;
				} else {
					if (typeOf _x isEqualTo "Land_Can_V2_F" && {random 1 <= BRPVP_fantaMinesShotChanceToHit}) then {
						private _mine = _x;
						private _wait = (_mine distance _bullet)/_velMag;
						private _newMine = [_mine,_wait,_posPlayer] call BRPVP_shotFrantaHit;
						_didSomething pushBack _mine;
						_didSomething pushBack _newMine;
					};
				};
			} forEach (((lineIntersectsSurfaces [_bPos vectorAdd (_bullet vectorModelToWorld [0,-_distBack,0]),_bPos vectorAdd (_bullet vectorModelToWorld [0,_dist*_dMult,0]),objNull,objNull,true,-1,"VIEW","FIRE",true]) apply {_x select 2})+_coObjs);
			_coObjs = [];
			_distBack = 0;
		} else {
			private _nearFrantas = (nearestObjects [ASLToAGL _lastPos,["Land_Can_V2_F"],0.5])-_didSomething;
			if (_nearFrantas isNotEqualTo [] && {random 1 <= BRPVP_fantaMinesShotChanceToHit}) then {
				private _franta = _nearFrantas select 0;
				[_franta,0,_posPlayer] call BRPVP_shotFrantaHit;
			};
			private _nearBlueGasTanks = (nearestObjects [ASLToAGL _lastPos,[BRPVP_spcItemsClass],0.8])-_didSomething;
			if (_nearBlueGasTanks isNotEqualTo []) then {
				private _blueTank = _nearBlueGasTanks select 0;
				["Sh_105mm_HEAT_MP",ASLToAGL getPosASL _blueTank,200] call BRPVP_trowBomb;
				deleteVehicle _blueTank;
			};
		};
		!_continue
	};
};
player addEventHandler ["FiredMan",{call BRPVP_pehFiredMan;}];
BRPVP_pehFiredMan = {
	private _weapon = _this select 1;
	private _muzzle = _this select 2;
	private _ammo = _this select 4;
	private _magazine = _this select 5;
	private _bala = _this select 6;
	private _balaDeleted = false;
	private _veh = objectParent player;

	BRPVP_shotTime = time;

	//DELETE AMMO/BULLET
	if (player getVariable "god" || player getVariable "brpvp_extra_protection") then {
		//DELETE BULLET IF IN SAFEZONE OR CAN'T SHOT
		deleteVehicle _bala;
		_balaDeleted = true;
	} else {
		if (_ammo in (_veh getVariable ["brpvp_cant_shoot_anymore",[]])) then {
			//DELETE AMMO IF CANT SHOOT ANYMORE
			"erro" call BRPVP_playSound;
			deleteVehicle _bala;
			_balaDeleted = true;
		};
	};

	//RELOAD BULLET IF IN SAFEZONE OR ADMIN GOD MODE
	if (player getVariable "god" || player getVariable "brpvp_extra_protection" || player getVariable "brpvp_god_admin") then {
		if (_weapon isEqualTo secondaryWeapon player) then {
			player addSecondaryWeaponItem _magazine;
		} else {
			if (_weapon isEqualTo primaryWeapon player) then {
				if (_muzzle isEqualTo _weapon) then {
					player setAmmo [_weapon,(player ammo _weapon)+1];
					if (BRPVP_rapidFire) then {vehicle player setWeaponReloadingTime [vehicle player,_muzzle,0];};
				} else {
					if (getText (configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "cursorAim") isEqualTo "gl") then {
						player addWeaponItem [_weapon,[_magazine,1,_muzzle]];
						if (BRPVP_rapidFire) then {
							_muzzle spawn {
								if (inputAction "defaultAction" > 0) then {
									sleep 0.2;
									if (inputAction "defaultAction" > 0) then {player fire _this;};
								};
							};
						};
					} else {
						player setAmmo [_muzzle,(player ammo _muzzle)+1];
						if (BRPVP_rapidFire) then {
							_muzzle spawn {
								if (inputAction "defaultAction" > 0) then {
									sleep 0.2;
									if (inputAction "defaultAction" > 0) then {player fire _this;};
								};
							};
						};
					};
				};
			} else {
				if (_weapon isEqualTo handGunWeapon player) then {
					player setAmmo [_weapon,(player ammo _weapon)+1];
					if (BRPVP_rapidFire) then {
						_muzzle spawn {
							if (inputAction "defaultAction" > 0) then {
								sleep 0.1;
								if (inputAction "defaultAction" > 0) then {player fire _this;};
							};
						};
					};
				};
			};
		};
	};

	//TV GUIDED MISSILE MOD
	if (_magazine in ["Titan_MIL_AP","Titan_MIL_AT"]) then {
		//[localize "str_tv_guided_missile_info",0,0,5,0,0,9518] call BRPVP_fnc_dynamicText;
		[_bala,0.65,[],"D37_seeker"] spawn D37AT_fnc_handleMissile;
	};

	//MORE CODE IF BULLET NOT NULL
	if (!_balaDeleted) then {
		//HOLD XRAY INSTANTLY
		if (BRPVP_xrayOn) then {BRPVP_xrayObj hideObject false;};

		//SET COMBAT MODE
		if (!BRPVP_safeZone) then {
			if (time-BRPVP_newerLastShot > 0.5) then {
				BRPVP_newerLastShot = time;
				{
					private _dist = _x distance player;
					if (_dist < 2000 && alive _x) then {
						private _lis = lineIntersectsSurfaces [eyePos player,eyePos _x,vehicle player,vehicle _x,true,1,"GEOM","NONE"];
						private _canSeeOrNear = if (_lis isEqualTo []) then {true} else {ASLToAGL (_lis select 0 select 0) distance _x < 20};
						if (_canSeeOrNear) then {
							private _vec1 = if (isNull _veh) then {
								player weaponDirection currentWeapon player
							} else {
								private _role = assignedVehicleRole player;
								if (count _role isEqualTo 2) then {
									if ((_role select 0) isEqualTo "turret") then {
										private _wInfo = __veh weaponsTurret (_role select 1);
										if (_wInfo isEqualTo []) then {[0,0,0]} else {[_veh,_wInfo select 0] call BIS_fnc_weaponDirectionRelative};
									} else {
										player weaponDirection currentWeapon player
									};
								} else {
									[0,0,0]
								};
							};
							if (_vec1 isNotEqualTo [0,0,0]) then {
								private _vec2 = (eyePos _x) vectorDiff (eyePos player);
								private _angle = acos (_vec1 vectorCos _vec2);
								private _arc = (2*pi*_dist)*(_angle/360);
								if (_arc < 15) then {
									call BRPVP_ligaModoCombate;
									break;
								};
							};
						};
					};
				} forEach ((call BRPVP_playersList)-[player]);
			};
		};

		//USE DOUBLE SMOKE IF IS SMOKE GRENADE
		if (BRPVP_doubleSmokeOn && {_bala isKindOf "SmokeShell" && BRPVP_doubleSmokeSpeed isNotEqualTo 1.25}) then {
			private _newVelocity = velocity _bala vectorMultiply (BRPVP_doubleSmokeSpeed max 0.1);
			[typeOf _bala,ASLToAGL getPosASL _bala,_newVelocity] spawn {
				params ["_class","_pos","_vel"];
				uiSleep 0.125;
				private _newSmoke = createVehicle [_class,_pos,[],0,"CAN_COLLIDE"];
				[_newSmoke,_vel] remoteExecCall ["setVelocity",BRPVP_allNoServer];
			};
		};

		//SPECIAL IF C4
		if (_ammo isEqualTo "DemoCharge_Remote_Ammo") then {
			private _objs = [];
			private _pw = getPosWorld _bala vectorAdd [0,0,0.25];
			{
				private _lis = [_pw,_pw vectorAdd _x,_bala,player,"GEOM","FIRE"] call BRPVP_lis;
				if (_lis isNotEqualTo []) then {
					private _obj = _lis select 0 select 2;
					if (_obj getVariable ["brpvp_c4_to_destroy",0] > 0) then {_objs pushBackUnique _obj;};
				};
			} forEach [[0,0,+2],[0,0,-2],[+2,0,0],[-2,0,0],[0,+2,0],[0,-2,0],[+2,+2,0],[+2,-2,0],[-2,+2,0],[-2,-2,0],[+2,0,2],[-2,0,2],[0,+2,2],[0,-2,2],[+2,+2,2],[+2,-2,2],[-2,+2,2],[-2,-2,2]];
			BRPVP_c4Monitore pushBack [_bala,_objs];
		};

		//ZOMBIE DISTRACT OBJECTS
		private _find = BRPVP_zombieDistractAmmo find (typeOf _bala);
		if (_find > -1) then {[_find,_bala] spawn BRPVP_trowAttractZombie;};

		//DETECT MINERVA SHOT
		if (BRPVP_minervaShotItemOn && {!BRPVP_safeZone && !(player getVariable "brpvp_extra_protection")}) then {BRPVP_minervaShotObj = _bala;};

		//DETECT ATOMIC SHOT
		if (BRPVP_atomicShotItemOn && {!BRPVP_safeZone && !(player getVariable "brpvp_extra_protection")}) then {BRPVP_atomicShotObj = _bala;};

		//SPOT ARTY
		if (BRPVP_artySpotOnShot) then {
			if (typeOf _veh in (BRPVP_artilleryLimit select 0)) then {
				if (!(_veh in BRPVP_artyShotLast) || {serverTime-(BRPVP_artyShotLast select 1) > 15}) then {
					private _dir = getDir _bala;
					[_veh,_dir,getPosWorld _veh] remoteExecCall ["BRPVP_artySpotInfoAdd",0];
					BRPVP_artyShotLast = [_veh,serverTime];
				};
			};
		};

		//FOLLOW AMMO CODE
		if (_bala isKindOF "RocketBase" || _bala isKindOf "MissileBase") then {
			//SEARCH FOR ANTI MISSILE DOME
			if (random 1 < (time-BRPVP_lastShotTimeDome)*2) then {
				BRPVP_lastShotTimeDome = time;
				[_bala,getPosWorld _bala] spawn BRPVP_activateDomeOnMissileRockets;
			};
			if (!isNull BRPVP_personalBush) then {BRPVP_personalBushFired = true;};
		} else {
			if (typeOf objectParent player in (BRPVP_artilleryLimit select 0)) then {
				//SEARCH FOR ANTI ARTY DOME
				if (BRPVP_domeProtectFromArty) then {
					if (random 1 < (time-BRPVP_lastShotTimeDome)*2) then {
						BRPVP_lastShotTimeDome = time;
						[_bala,getPosWorld _bala] spawn BRPVP_activateDomeOnArty;
					};
				};
				if (!isNull BRPVP_personalBush) then {BRPVP_personalBushFired = true;};
			} else {
				if (vectorMagnitude velocity _bala > 250 && time-BRPVP_lastShotTime > 1.25) then {
					//ALERT AI ABOUT NEAR FIRE
					BRPVP_lastShotTime = time;
					[_bala,getPosWorld _bala] spawn BRPVP_alertAiAboutNearBullets;
					if (!isNull BRPVP_personalBush) then {BRPVP_personalBushFired = true;};
					
					//FOLLOW BULLET EXPLODE THINGS
					if (random 1 <= 0.5) then {[getPosWorld _bala,_ammo,_bala,getPosWorld player,getPosWorld _bala] spawn BRPVP_followBullet;};
				};
			};
		};

		//RESET VIRTUAL GARAGE TIME
		if (!isNull _veh) then {
			private _last = _veh getVariable ["brpvp_last_vg_reset",0];
			if (time-_last > 30) then {
				_veh setVariable ["brpvp_last_vg_reset",time];
				_newTime = serverTime+120;
				if (_newTime > _veh getVariable ["brpvp_from_vg_time",0]) then {_veh setVariable ["brpvp_from_vg_time",_newTime,true];};
			};
		};

		//STOP ATOMIC BOMB PLANE
		if (BRPVP_deleteAtomicVehiclesAfterUse) then {
			if (_ammo in ["rhs_ammo_kh55sm","rhs_ammo_kh55sm_nocamo"] && !isNull _veh && _veh isKindOf "Plane") then {
				_veh setVariable ["brpvp_delete_when_possible",true,true];
				_veh setVariable ["brpvp_cant_shoot_anymore",["rhs_ammo_kh55sm","rhs_ammo_kh55sm_nocamo"],true];
			};

			//DELETE RHS ATOMIC BOMB VEHICLE
			if (typeOf _veh isEqualTo "rhs_9k79_B") then {
				_veh setVariable ["brpvp_delete_when_possible",true,true];
				_veh setVariable ["brpvp_cant_shoot_anymore",[_ammo],true];
			};
		};
	};
};

//PLAYER GETINMAN EH
BRPVP_slingEventHandlerOn = false;
player addEventHandler ["GetInMan",{call BRPVP_pehGetInMan;}];
BRPVP_pehGetInMan = {
	params ["_player","_ocup","_veiculo","_turret"];
	if (player isEqualTo currentPilot _veiculo) then {_ocup = "driver";};
	player setVariable ["brpvp_veh_pos",_veiculo worldToModel ASLToAGL getPosASL player];

	//SHOW VEH LEVEL
	private _hasWeapons = {_w = _x;{_w find _x > -1} count ["horn","Horn","HORN"] isEqualTo 0} count weapons _veiculo > 0;
	private _vehKills = _veiculo getVariable ["brpvp_kills",0];
	if (_hasWeapons) then {
		if (_vehKills <= BRPVP_vehLvlMaxKills) then {
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\veh_xp.paa'/><br/>LVL "+str _vehKills,0,0,2,0,0,53463] call BRPVP_fnc_dynamicText;
		} else {
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\veh_xp.paa'/><br/>LVL "+str _vehKills+"(MAX: "+str BRPVP_vehLvlMaxKills+")",0,0,2,0,0,53463] call BRPVP_fnc_dynamicText;
		};
	};

	//REMOVE RAID TRAINING VEHICLE LABEL
	if (_veiculo getVariable ["brpvp_rto_real_vehicle",false] && {_veiculo distance2D BRPVP_raidTrainingMapPosition >= 400}) then {_veiculo setVariable ["brpvp_rto_real_vehicle",false,true];};

	//SHOW IF HAVE PLUS TORQUE
	if (_veiculo getVariable ["brpvp_original_mass",-1] > -1 && player isEqualTo currentPilot _veiculo) then {"plus_torque" call BRPVP_playSound;};

	//DISABLE RADAR
	_veiculo call BRPVP_turnOffVehRadar;

	//HIDE MAGNET ITEMS
	{[_x,true] remoteExecCall ["hideObjectGlobal",2];} forEach (player getVariable "brpvp_carry_objs");

	//INFORM ABOUT NO PLAYER DAMAGE DAY ON THIS VEHICLE
	if (typeOf _veiculo in BRPVP_noDamageVehList) then {
		["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\no_veh_damage.paa'/><br/>"+localize "str_no_veh_damage_day",0,0,5,0,0,2683] call BRPVP_fnc_dynamicText;
	};
	
	//ANTI COLLISION TURRET
	if (_veiculo isKindOf "Motorcycle" || _veiculo isKindOf "Car" || _veiculo isKindOf "Tank") then {0 spawn BRPVP_avoidTurretCollision;};

	//CAN'T ENTER WHILE HULKING
	private _hlk = player getVariable ["brpvp_hulk_objs",[]];
	if !(_hlk isEqualTo []) then {
		[localize "str_cant_while_hulking",-5] call BRPVP_hint;
		moveOut player;
	};

	//HIDE SHIFT+E BOX
	private _box = player getVariable ["brpvp_box_carry",objNull];
	private _model = player getVariable ["brpvp_box_carry_model",objNull];
	if (!isNull _box) then {[_box,true] remoteExecCall ["hideObjectGlobal",2];};
	if (!isNull _model) then {[_model,true] remoteExecCall ["hideObjectGlobal",2];};

	//PUT EJECT ACTION ON PILOTS AND COPILOTS
	if (_veiculo isKindOf "Air" && (_ocup isEqualTo "driver" || (_ocup isEqualTo "gunner" && _turret isEqualTo [0]))) then {
		BRPVP_pilotCopilotEjectAction = player addAction [localize "str_act_eject",{call BRPVP_pilotCoPilotEject;},0,1.5,false];
	};

	//BRPVP WATERMARK FIXED POSITION
	if (_ocup isEqualTo "driver" || _ocup isEqualTo "gunner") then {
		["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.315},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;
	};

	//CAR ALARM
	if !(_veiculo call BRPVP_checaAcesso) then {
		private _alarmIsOn = _veiculo getVariable ["brpvp_alarm_is_on",false];
		if (!_alarmIsOn) then {
			_veiculo setVariable ["brpvp_alarm_is_on",true,true];
			_veiculo spawn {
				private _veiculo = _this;
				private _alarmCount = 0;
				waitUntil {
					private _sample = [selectRandom ["car_alarm_01","car_alarm_02","car_alarm_03"],600];
					[_veiculo,_sample] remoteExecCall ["say3d",BRPVP_allNoServer];
					_alarmCount = _alarmCount+1;
					sleep 1;
					_alarmCount isEqualTo 4
				};
				_veiculo setVariable ["brpvp_alarm_is_on",false,true];
			};
		};
	};

	//SET TURRET TYPE TO ATTACK PLAYER IN VEHICLE
	_veiculo call BRPVP_setTurretTypes;

	//SET TO SAVE ON DB IF DB VEHICLE
	if (_veiculo getVariable ["id_bd",-1] >= 0) then {
		if !(_veiculo getVariable ["slv",false]) then {_veiculo setVariable ["slv",true,true];};
	};
	
	//ADD SLING LOAD EVENT HANDLER
	if (_ocup isEqualTo "driver") then {
		private _typeOf = typeOf _veiculo;
		if (isNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass")) then {
			private _sligLimit = getNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass");
			if (_sligLimit > 0) then {
				BRPVP_slingEventHandlerOn = true;
				_veiculo addEventHandler ["RopeAttach",{
					params ["_heli","_rope","_cargo"];
					[_cargo,15] call BRPVP_enableVehOnInteraction;
				}];
				_veiculo addEventHandler ["RopeBreak",{
					params ["_heli","_rope","_cargo"];
					if (_cargo getVariable ["id_bd",-1] > -1 || _cargo getVariable ["brpvp_fedidex",false]) then {
						_cargo spawn {
							waitUntil {getPos _this select 2 < 0.25};
							sleep 1;
							if !(_this getVariable ["slv",false]) then {_this setVariable ["slv",true,true];};
						};
					};
				}];
			};
		};
	};
	if (_veiculo call BRPVP_checaAcesso) then {BRPVP_assignedVehicle = _veiculo;} else {BRPVP_assignedVehicle = objNull;};
	
	//UPDATE VEHICLES WITH PLAYERS ARRAY
	player setVariable ["veh",_veiculo,true];
	
	//SHOW MESSAGE FOR NOT-DB VEHICLES
	if (_veiculo getVariable ["brpvp_fedidex",false]) then {[localize "str_fedidex_del_alert"] call BRPVP_hint;};

	//MESSAGE IF TRANSPORT MISSION VEHICLE
	private _transVeh = _veiculo getVariable ["brpvp_trans_mission",0];
	if (_transVeh > 0) then {[format [localize "str_trans_veh_msg",_transVeh],-6] call BRPVP_hint;};

	//DISABLE ADMIN FLY
	BRPVP_flyA = false;
	BRPVP_flyB = false;
	BRPVP_flyC = false;

	//ENABLE BRPVP VEH CARRIER
	if (typeOf _veiculo in BRPVP_carryHelis && _ocup isEqualTo "driver") then {BRPVP_carryHeliAction = player addAction ["<t color='#5588FF'>"+localize "str_carry_heli_action"+"</t>",{call BRPVP_carryHelisCode;},_veiculo,1.5];};

	//PROTECT AIR VEHICLE
	if (_ocup isEqualTo "driver" && {_veiculo isKindOf "Air"}) then {
		_veiculo spawn {
			private _init = time;
			waitUntil {local _this || time-_init > 2};
			if (local _this) then {_this call BRPVP_setAirGodMode;};
		};
	};

	//SET ACTUAL POS VAR
	_veiculo setVariable ["brpvp_record_pos",getPosWorld _veiculo];

	//ADD REARM VEHICLE OPTION
	if (_ocup isEqualTo "driver") then {call BRPVP_checkForNearServices;};

	//REMOVE AUTO MAGUS TIME
	if !(typeOf _veiculo in BRPVP_vantVehiclesClass) then {
		if (_veiculo getVariable ["id_bd",-1] > -1) then {
			private _havePlayer = false;
			{if (_x call BRPVP_isPlayer) exitWith {_havePlayer = true;};} forEach (crew _veiculo-[player]);
			if (!_havePlayer) then {_veiculo setVariable ["brpvp_auto_magus_time",-1,2];};
		};
	};

	//HIDE MAGUS BARRIERS
	{if (typeOf _x in ["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"] && _x getVariable ["brpvp_tire_idbd",-1] > -1) then {_x hideObject true;};} forEach attachedObjects player;
	
	//REMOVE PERSONAL BUSH
	if (!isNull BRPVP_personalBush) then {deleteVehicle BRPVP_personalBush;};

	//SET AI SIMU DIST
	if (_veiculo isKindOf "LandVehicle" || _veiculo isKindOf "Ship" || _veiculo isKindOf "Motorcycle") then {player setVariable ["brpvp_ai_simu_dist",BRPVP_aiSimuDist,2];} else {player setVariable ["brpvp_ai_simu_dist",BRPVP_aiSimuDistAir,2];};
	
	//REMOVE LAST VEH 3D ICON
	BRPVP_lastVehicleInObj = objNull;
	BRPVP_lastVehicleInPos = [];
	BRPVP_lastVehicleInTi = false;
	
	//SHIP HELP CODE
	if (_veiculo isKindOf "Ship") then {call BRPVP_shipHelpOnShipVehicle;} else {call BRPVP_shipHelpOnNoShipVehicle;};

	//ALLOW JET AND HELI LOCK ON OTHER PLAYERS
	if (_veiculo isKindOf "Plane" || _veiculo isKindOf "Helicopter") then {
		[player,_veiculo] spawn {
			params ["_player","_veh"];
			waitUntil {
				waitUntil {getPos _veh select 2 > 5 && !(_player in crew _veh)};
				_player addRating (-10000-rating _player);
				waitUntil {getPos _veh select 2 < 5 && !(_player in crew _veh)};
				_player addRating (-rating _player);
				_player in crew _veh;
			};
		};
	};
};

//PLAYER GETOUTMAN EH
BRPVP_carryHeliAction = -1;
player addEventHandler ["GetOutMan",{call BRPVP_pehGetOutMan;}];
BRPVP_pehGetOutMan = {
	params ["_unit","_role","_vehicle","_turret"];

	//SHOW SHIFT+E BOX
	private _box = player getVariable ["brpvp_box_carry",objNull];
	private _model = player getVariable ["brpvp_box_carry_model",objNull];
	if (!isNull _box) then {[_box,false] remoteExecCall ["hideObjectGlobal",2];};
	if (!isNull _model) then {[_model,false] remoteExecCall ["hideObjectGlobal",2];};

	//BRPVP WATERMARK, BACK TO NORMAL POSITION
	["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.020},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;

	//REMOVE EJECT ACTION ON PILOTS AND COPILOTS
	if (BRPVP_pilotCopilotEjectAction > -1) then {
		player removeAction BRPVP_pilotCopilotEjectAction;
		BRPVP_pilotCopilotEjectAction = -1;
	};

	//REMOVE RAID TRAINING VEHICLE LABEL
	if (_vehicle getVariable ["brpvp_rto_real_vehicle",false] && {_vehicle distance2D BRPVP_raidTrainingMapPosition >= 400}) then {_vehicle setVariable ["brpvp_rto_real_vehicle",false,true];};

	//SET ATTACK TURRETS TO ANTI PERSONEL TURRETS
	BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 0;
	BRPVP_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 0;
	BRPVP_actualAutoTurrets = BRPVP_autoTurretOnMan;
	BRPVP_autoTurretExtraCode = {["man",_this] call BRPVP_checkTurretType};

	if (BRPVP_slingEventHandlerOn) then {
		_vehicle removeAllEventHandlers "RopeAttach";
		_vehicle removeAllEventHandlers "RopeBreak";
		BRPVP_slingEventHandlerOn = false;
	};

	//UPDATE VEHICLES WITH PLAYERS ARRAY
	player setVariable ["veh",objNull,true];

	//UNHIDE MAGNET ITEMS
	{[_x,false] remoteExecCall ["hideObjectGlobal",2];} forEach (player getVariable "brpvp_carry_objs");

	//FIX EXIT VEHICLE GO INTO WALL BUG
	if (_vehicle isKindOf "LandVehicle" && !(_vehicle isKindOf "StaticWeapon")) then {
		private _p1 = _vehicle modelToWorldWorld ((player getVariable "brpvp_veh_pos") vectorAdd [0,0,1.65]);
		private _p2 = (getPosASL player vectorMultiply 0.4) vectorAdd (eyePos player vectorMultiply 0.6);
		private _lis = lineIntersectsSurfaces [_p2,_p1,_vehicle,player,true,-1,"GEOM","NONE",true];
		private _bug = {(_x select 2) isKindOf "Building" || (_x select 2) isKindOf "Wall"} count _lis > 0;
		if (_bug) then {
			"erro" call BRPVP_playSound;
			[localize "str_back_away_from_buildings",-4] call BRPVP_hint;
			if (_role isEqualTo "driver") then {
				player moveInDriver _vehicle;
			} else {
				if (_role isEqualTo "cargo") then {
					player moveInCargo _vehicle;
				} else {
					if (_role isEqualTo "gunner") then {
						player moveInTurret [_vehicle,_turret];
					} else {
						if (_role isEqualTo "commander") then {
							player moveInCommander _vehicle;
						} else {
							player moveInAny _vehicle;
						};
					};
				};
			};
		};
	};

	//DISABLE BRPVP VEH CARRIER
	if (typeOf _vehicle in BRPVP_carryHelis && _role isEqualTo "driver") then {
		player removeAction BRPVP_carryHeliAction;
		BRPVP_carryHeliAction = -1;
	};

	//SET SIMULATION DISABLE TIME IF EMPTY
	private _havePlayer = false; 
	{if (_x call BRPVP_isPlayer) exitWith {_havePlayer = true;};} forEach (crew _vehicle-[player]);
	if (!_havePlayer) then {
		if (_vehicle getVariable ["brpvp_delete_when_possible",false]) then {
			[_vehicle,false] remoteExecCall ["allowDamage",_vehicle];
			[_vehicle,true] remoteExecCall ["lock",_vehicle];
			_vehicle remoteExecCall ["BRPVP_reduceAndDeleteSv",2];
		} else {
			if (_vehicle isKindOf "Helicopter") then {
				_vehicle setVariable ["brpvp_time_can_disable",serverTime+40,2];
			} else {
				_vehicle setVariable ["brpvp_time_can_disable",serverTime+5,2];
			};
		};
	};

	//SET AUTO MAGUS TIME
	if !(typeOf _vehicle in BRPVP_vantVehiclesClass) then {
		if (crew _vehicle-[player] isEqualTo [] && _vehicle getVariable ["id_bd",-1] > -1 && _vehicle getVariable ["own",-1] > -1) then {
			_vehicle setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
			private _lv = player getVariable ["brpvp_player_last_vehicle",objNull];
			if (_vehicle isNotEqualTo _lv) then {
				if (!isNull _lv && alive _lv) then {[player getVariable "id_bd",_lv,"remove"] remoteExecCall ["BRPVP_setVehLastPlayers",2];};
				player setVariable ["brpvp_player_last_vehicle",_vehicle];
				[player getVariable "id_bd",_vehicle,"add"] remoteExecCall ["BRPVP_setVehLastPlayers",2];
			};
		};
	};

	//PROTECT AIR VEHICLE DURING ALONE PARKING
	if (local _vehicle && {_vehicle isKindOf "Air"}) then {
		_vehicle call BRPVP_setAirGodMode;
		_vehicle spawn {
			private _veh = _this;
			private _init = time;
			waitUntil {
				sleep 0.5;
				private _exit = vectorMagnitude velocity _veh < 0.25 || time-_init > 30 || !local _veh;
				if (!_exit) then {_veh call BRPVP_setAirGodMode;};
				_exit
			};
		};
	};

	//DISABLE SERVICES ACTIONS
	_vehicle call BRPVP_disableNearServiceAction;

	//UNHIDE MAGUS BARRIERS
	{if (typeOf _x in ["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"] && _x getVariable ["brpvp_tire_idbd",-1] > -1) then {_x hideObject false;};} forEach attachedObjects player;

	//SET AI SIMU DIST
	player setVariable ["brpvp_ai_simu_dist",BRPVP_aiSimuDistOnFoot,2];

	if (_vehicle isKindOf "ParachuteBase") then {
		//CODE IF MOVING OUT A PARACHUTE
		player action ["SwitchWeapon",player,player,100];
	} else {
		//SET PLAYER LAST VEHICLE
		BRPVP_lastVehicleInObj = _vehicle;
		BRPVP_lastVehicleInPos = ASLToAGL getPosWorld _vehicle;
	};

	//SHIP HELP CODE
	call BRPVP_shipHelpOnNoShipVehicle;
};

//PLAYER SEATSWITCHEDMAN EH
player addEventHandler ["SeatSwitchedMan",{call BRPVP_pehSeatSwitchedMan;}];
BRPVP_pehSeatSwitchedMan = {
	private _ocup = assignedVehicleRole player select 0;
	private _veiculo = _this select 2;
	if (currentPilot _veiculo isEqualTo player) then {_ocup = "driver";};

	player setVariable ["brpvp_veh_pos",_veiculo worldToModel ASLToAGL getPosASL player];

	//PUT OR REMOVE EJECT ACTION ON PILOTS AND COPILOTS
	if (_veiculo isKindOf "Air" && (_ocup isEqualTo "driver" || (_ocup isEqualTo "turret" && {(assignedVehicleRole player select 1) isEqualTo [0]}))) then {
		BRPVP_pilotCopilotEjectAction = player addAction [localize "str_act_eject",{call BRPVP_pilotCoPilotEject;},0,1.5,false];
	} else {
		if (BRPVP_pilotCopilotEjectAction > -1) then {
			player removeAction BRPVP_pilotCopilotEjectAction;
			BRPVP_pilotCopilotEjectAction = -1;
		};
	};

	//SHOW IF HAVE PLUS TORQUE
	if (_veiculo getVariable ["brpvp_original_mass",-1] > -1 && player isEqualTo currentPilot _veiculo) then {"plus_torque" call BRPVP_playSound;};

	if (_ocup isEqualTo "driver") then {
		//ADD SLING LOAD EVENT HANDLER
		private _typeOf = typeOf _veiculo;
		if (isNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass")) then {
			private _sligLimit = getNumber (configFile >> "CfgVehicles" >> _typeOf >> "slingLoadMaxCargoMass");
			if (_sligLimit > 0) then {
				BRPVP_slingEventHandlerOn = true;
				_veiculo addEventHandler ["RopeAttach",{
					params ["_heli","_rope","_cargo"];
					[_cargo,15] call BRPVP_enableVehOnInteraction;
				}];
				_veiculo addEventHandler ["RopeBreak",{
					params ["_heli","_rope","_cargo"];
					if (_cargo getVariable ["id_bd",-1] > -1 || _cargo getVariable ["brpvp_fedidex",false]) then {
						_cargo spawn {
							waitUntil {getPos _this select 2 < 0.25};
							sleep 1;
							if !(_this getVariable ["slv",false]) then {_this setVariable ["slv",true,true];};
						};
					};
				}];
			};
		};
		["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.315},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;
	} else {
		if (BRPVP_slingEventHandlerOn) then {
			_veiculo removeAllEventHandlers "RopeAttach";
			_veiculo removeAllEventHandlers "RopeBreak";
			BRPVP_slingEventHandlerOn = false;
		};
		if (_ocup isEqualTo "turret") then {
			if (typeOf _veiculo in BRPVP_classRemoveTurret) then {moveOut player;};
			["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.315},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;
		} else {
			["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.020},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;
		};
	};

	//ENABLE BRPVP VEH CARRIER
	if (typeOf _veiculo in BRPVP_carryHelis && _ocup isEqualTo "driver") then {BRPVP_carryHeliAction = player addAction ["<t color='#5588FF'>"+localize "str_carry_heli_action"+"</t>",{call BRPVP_carryHelisCode;},_veiculo,1.5];};

	//DISABLE BRPVP VEH CARRIER
	if (typeOf _veiculo in BRPVP_carryHelis && !(_role isEqualTo "driver")) then {
		if (BRPVP_carryHeliAction > -1) then {
			player removeAction BRPVP_carryHeliAction;
			BRPVP_carryHeliAction = -1;
		};
	};
	
	//PROTECT AIR VEHICLE
	if (_ocup isEqualTo "driver" && {_veiculo isKindOf "Air"}) then {
		_veiculo spawn {
			private _init = time;
			waitUntil {local _this || time-_init > 2};
			if (local _this) then {_this call BRPVP_setAirGodMode;};
		};
	};

	//DISABLE SERVICES ACTIONS
	if (_ocup isEqualTo "driver") then {call BRPVP_checkForNearServices;} else {_veiculo call BRPVP_disableNearServiceAction;};
};

//PLAYER PUT EH
BRPVP_takePutLastTime = 0;
BRPVP_putLast = "";
BRPVP_putRepeat = 0;
player addEventHandler ["Put",{call BRPVP_pehPut;}];
BRPVP_pehPut = {
	private _cont = _this select 1;
	private _item = _this select 2;
	BRPVP_takePutLastTime = time;
	
	//DISABLE DELETE ON RESTART
	if (_cont getVariable ["brpvp_how_old",-1] > 0) then {_cont setVariable ["brpvp_how_old",0,true];};

	//TO SPEC MESSING ITEM
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
		if (BRPVP_inventoryBoxes isNotEqualTo []) then {
			private _image = BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa";
			private _isM = isClass (configFile >> "CfgMagazines" >> _item);
			if (_isM) then {
				_image = getText (configFile >> "CfgMagazines" >> _item >> "picture");
			} else {
				private _isW = isClass (configFile >> "CfgWeapons" >> _item);
				if (_isW) then {
					_image = getText (configFile >> "CfgWeapons" >> _item >> "picture");
				} else {
					private _isV = isClass (configFile >> "CfgVehicles" >> _item);
					if (_isV) then {
						_image = getText (configFile >> "CfgVehicles" >> _item >> "picture");
					} else {
						private _isG = isClass (configFile >> "CfgGlasses" >> _item);
						if (_isG) then {
							_image = getText (configFile >> "CfgGlasses" >> _item >> "picture");
						};
					};
				};
			};
			if (_item isEqualTo BRPVP_putLast) then {BRPVP_putRepeat = BRPVP_putRepeat+1;} else {BRPVP_putRepeat = 0;};
			["put",_image,format["X%1",BRPVP_putRepeat+1]] remoteExecCall ["BRPVP_specTakePutItem",BRPVP_specOnMeMachinesNoMe];
			BRPVP_putLast = _item;
		};
	};
};

//PLAYER TACK EH
BRPVP_takeLast = "";
BRPVP_takeRepeat = 0;
player addEventHandler ["Take",{call BRPVP_pehTake;}];
BRPVP_pehTake = {
	private _cont = _this select 1;
	private _item = _this select 2;
	BRPVP_takePutLastTime = time;

	if (_item in (BRPVP_moneyItems select 0)) then {
		private _addMny = (BRPVP_moneyItems select 1) select (BRPVP_moneyItems select 0 find _item);
		player setVariable ["mny",(player getVariable "mny")+_addMny,true];
		"negocio" call BRPVP_playSound;
		_item spawn {
			sleep 0.001;
			player removeMagazines _this;
		};
		call BRPVP_atualizaDebug;
	};

	private _wh_usos = _cont getVariable ["ml_takes",-1];
	if (_wh_usos >= 0) then {_cont setVariable ["ml_takes",_wh_usos+1,true];};

	//DISABLE DELETE ON RESTART
	if (_cont getVariable ["brpvp_how_old",-1] > 0) then {_cont setVariable ["brpvp_how_old",0,true];};

	//TO SPEC MESSING ITEM
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
		if (BRPVP_inventoryBoxes isNotEqualTo []) then {
			private _image = BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa";
			private _isM = isClass (configFile >> "CfgMagazines" >> _item);
			if (_isM) then {
				_image = getText (configFile >> "CfgMagazines" >> _item >> "picture");
			} else {
				private _isW = isClass (configFile >> "CfgWeapons" >> _item);
				if (_isW) then {
					_image = getText (configFile >> "CfgWeapons" >> _item >> "picture");
				} else {
					private _isV = isClass (configFile >> "CfgVehicles" >> _item);
					if (_isV) then {
						_image = getText (configFile >> "CfgVehicles" >> _item >> "picture");
					} else {
						private _isG = isClass (configFile >> "CfgGlasses" >> _item);
						if (_isG) then {
							_image = getText (configFile >> "CfgGlasses" >> _item >> "picture");
						};
					};
				};
			};
			if (_item isEqualTo BRPVP_takeLast) then {BRPVP_takeRepeat = BRPVP_takeRepeat+1;} else {BRPVP_takeRepeat = 0;};
			["take",_image,format["X%1",BRPVP_takeRepeat+1]] remoteExecCall ["BRPVP_specTakePutItem",BRPVP_specOnMeMachinesNoMe];
			BRPVP_takeLast = _item;
		};
	};
};

//PLAYER INVENTORYOPENED EH
BRPVP_inventoryOpenID = 0;
BRPVP_inventoryBoxes = [];
BRPVP_inventoryBoxesSetToLocal = [];
player addEventHandler ["InventoryOpened",{call BRPVP_pehInventoryOpened;}];
BRPVP_pehInventoryOpened = {
	private _c = _this select 1;
	private _c2 = _this select 2;
	private _retorno = false;

	//BLOCK IF MISSION BOX AND CANT OPEN
	(_c getVariable ["brpvp_mbots",[[0,0,0],0,[]]]) params ["_pos","_rad","_ais"];
	private _dead = {!alive _x || _x distance _pos > _rad} count _ais;
	if (_dead < round (BRPVP_killPercToLiberateBox*count _ais) && !BRPVP_vePlayers) then {
		[localize "str_lock_box_message",-5] call BRPVP_hint;
		_retorno = true;
	};

	if (!_retorno) then {
		//CONTAINER 1
		private _canAccess = _c call BRPVP_checaAcesso;
		private _isLockUnlock = _c call BRPVP_isMotorizedNoTurret && _c getVariable ["own",-1] isNotEqualTo -1 && _c getVariable ["id_bd",-1] isNotEqualTo -1;
		private _locked = _c getVariable ["brpvp_locked",false];

		//TRY TO USE LOCK PICK IF NEEDED AND EQUIPED
		private _forceAccess = false;
		private _allowError = true;
		private _lockPickBox = _c iskindOf "ReammoBox_F" && !_canAccess && BRPVP_equipedIllegalItem isEqualTo "BRP_boxThief";
		if (_lockPickBox) then {
			private _remove = false;
			_allowError = false;
			if (_c getVariable ["brpvp_can_use_master_key",true]) then {
				if (random 1 < BRPVP_lockPickChanceOfSuccess) then {
					private _lpObj = BRPVP_equipedIllegalItemPatern select 2;
					if (isNull _lpObj) then {
						BRPVP_equipedIllegalItemPatern set [2,_c];
						_lpObj = _c;
					};
					if (_c isEqualTo _lpObj) then {
						if (BRPVP_equipedIllegalItemPatern select 1 >= 8) then {
							if (BRPVP_equipedIllegalItemPatern select 0 isEqualTo 1) then {
								_forceAccess = true;
								"lock_pick_ok_music" call BRPVP_playSound;
								[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
								_remove = true;
								if (_c getVariable ["brpvp_rto",false]) then {
									if (BRPVP_hackObjectsOneTimeOnly) then {_c setVariable ["brpvp_hacked",true,true];};
								} else {
									if (BRPVP_hackObjectsOneTimeOnly) then {
										_c call BRPVP_turnIntoBandit;
										_c setVariable ["brpvp_hacked",true,true];
									};
									[_c getVariable "own",player getVariable "id_bd",player getVariable "nm",typeOf _c,getPosWorld _c] remoteExecCall ["BRPVP_logBaseInvasion",2];

									//SET FLAG TO NO CONSTRUCTION
									if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
										private _flag = _c call BRPVP_nearestFlagInsideWithAccess;
										if (isNull _flag) then {_flag = _c call BRPVP_nearestFlagInside;};
										if (!isNull _flag) then {
											_flag setVariable ["brpvp_last_intrusion",serverTime,true];
											if (BRPVP_useDiscordEmbedBuilder) then {_flag remoteExecCall ["BRPVP_messageDiscordRaid",2];};
										};
									};
								};
							} else {
								[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
								BRPVP_equipedIllegalItemPatern set [0,(BRPVP_equipedIllegalItemPatern select 0)-1];
								BRPVP_equipedIllegalItemPatern set [1,0];
							};
						} else {
							[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
							BRPVP_equipedIllegalItem = "";
						};
					} else {
						[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
						BRPVP_equipedIllegalItem = "";
					};
				} else {
					[player,["lock_pick_not_ok",100]] remoteExecCall ["say3D",BRPVP_allNoServer];
					_remove = true;
				};
				if (_remove) then {
					[BRPVP_specialItems find BRPVP_equipedIllegalItem,1] call BRPVP_sitRemoveItem;
					BRPVP_equipedIllegalItem = "";
				};
			} else {
				[localize "str_obj_super_protected",-5] call BRPVP_hint;
			};
		};

		_retorno = !((_isLockUnlock && !_locked) || (!_isLockUnlock && ((_canAccess || (_c isKindOf "CAManBase")) && !(_c isKindOf BRPVP_zombieMotherClass))) || _forceAccess);

		//CONTAINER 2
		if (!isNull _c2) then {
			_canAccess = _c2 call BRPVP_checaAcesso;
			_retorno = _retorno || !(_canAccess || _c2 isKindOf "CAManBase");
		};

		if (_retorno) then  {
			if (_allowError) then {if (_isLockUnlock) then {[localize "str_no_access_locked",0] call BRPVP_hint;} else {[localize "str_no_access",0] call BRPVP_hint;};};
		} else {
			BRPVP_inventoryBoxes = [_c,_c2];
			player setVariable ["brpvp_inv_opened_boxes",BRPVP_inventoryBoxes,[clientOwner,2]];

			//GET LAST ACESSED BASE BOX
			{if (_x getVariable ["id_bd",-1] isNotEqualTo -1 && _x isKindOf "ReammoBox_F") exitWith {BRPVP_lastBaseBox = _x;};} forEach BRPVP_inventoryBoxes;

			//AVOID SIMU DISABLED
			{
				private _isInv = false;
				if (_x call BRPVP_isMotorizedNoTurret) then {
					[_x,15] call BRPVP_enableVehOnInteraction;
					_isInv = true;
				} else {
					if (_x in BRPVP_ownedHouses) then {
						_x setVariable ["brpvp_time_can_disable",serverTime+15,2];
						if (!simulationEnabled _x) then {[_x,true] remoteEXecCall ["enableSimulationGlobal",2];};
						_isInv = true;
					};
				};
				if (_isInv) then {
					_x spawn {
						waitUntil {
							_this setVariable ["brpvp_time_can_disable",serverTime+15,2];
							sleep 12;
							BRPVP_inventoryBoxes isEqualTo []
						};
					};
				};
			} forEach BRPVP_inventoryBoxes;

			//AVOID FLARE TO BE MOVED TO GROUP
			private _floor = if (_c isKindOf "GroundWeaponHolder") then {_c} else {_c2};
			[_floor,BRPVP_inventoryOpenID] spawn {
				params ["_floor","_id"];

				//ANTI-DUPE FOR VIRTUAL WEAPON SLOT
				waitUntil {!isNull findDisplay 602};
				findDisplay 602 displayCtrl 610 ctrlAddEventHandler ["MouseButtonUp",{if (_this select 1 isEqualTo 1) then {BRPVP_weaponPrivateSlotTime = time;};}];

				private _moneyMags = BRPVP_moneyItems select 0;
				private _moneyMagsValor = BRPVP_moneyItems select 1;
				waitUntil {
					private _magazinesNoFlare = [];
					private _flares = [];
					{if (_moneyMags find (_x select 0) isEqualTo -1) then {_magazinesNoFlare pushBack _x;} else {_flares pushBack _x;};} forEach magazinesAmmoCargo _floor;
					if (count _flares > 0) then {
						clearMagazineCargoGlobal _floor;
						{_floor addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach _magazinesNoFlare;
						private _valor = 0;
						{_valor = _valor + (_moneyMagsValor select (_moneyMags find (_x select 0)));} forEach _flares;
						player setVariable ["mny",(player getVariable "mny")+_valor,true];
						call BRPVP_atualizaDebug;
						"negocio" call BRPVP_playSound;
					};
					_id isNotEqualTo BRPVP_inventoryOpenID
				};
			};

			//CHECK FOR DUPLICATE PLAYER CONTAINERS
			0 spawn {
				waitUntil {
					sleep 0.001;
					private _pContainers = [];
					{_pContainers append ([backPackContainer _x,vestContainer _x,uniformContainer _x]-[objNull]);} forEach (player nearEntities [BRPVP_playerModel,20]);
					while {_pContainers isNotEqualTo []} do {
						private _bag = _pContainers deleteAt 0;
						if (_pContainers find _bag isNotEqualTo -1) then {
							_pContainers = _pContainers-[_bag];
							deleteVehicle _bag;
						};
					};
					BRPVP_inventoryBoxes isEqualTo []
				};
			};

			//CHECK IF INVENTORY GOING TO MAGUS
			0 spawn {
				waitUntil {
					private _ok = {_x getVariable ["brpvp_to_magus",false]} count BRPVP_inventoryBoxes isEqualTo 0;
					BRPVP_inventoryBoxes isEqualTo [] || !_ok
				};
				if (BRPVP_inventoryBoxes isNotEqualTo []) then {if (!isNull findDisplay 602) then {(findDisplay 602) closeDisplay 1;};};
			};

			//REVEAL IF POSSESSING
			private _haveBox = (BRPVP_inventoryBoxes select {_x isKindOf "ReammoBox_F"}) isNotEqualTo [];
			if (_haveBox && player getVariable ["brpvp_possessing_other",false]) then {BRPVP_possBadAction = time;};

			//SPEC SEND GEAR ON
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\spec_gear.paa'/>",0,0.25,36000,0,0,1983745] remoteExecCall ["BRPVP_fnc_dynamicTextSpec",BRPVP_specOnMeMachinesNoMe];};

			//SET LOCALITY TO PLAYER IF POSSIBLE AND HAVE CARGO (FOR FASTER ITEM TRANSFER)
			{
				private _notMan = !(_x isKindOf "CaManBase");
				private _notLocal = !local _x;
				private	_emptyVeh = if (_x call BRPVP_isMotorized) then {crew _x isEqualTo []} else {true};
				private _hasCargo = maxLoad _x > 0;
				if (_notMan && _notLocal && _emptyVeh && _hasCargo) then {BRPVP_inventoryBoxesSetToLocal pushBack _x;};
			} forEach BRPVP_inventoryBoxes;
			[BRPVP_inventoryBoxesSetToLocal,clientOwner] remoteExecCall ["BRPVP_setOwnerForFasterItemTransfer",2];
		};
	};
	_retorno
};

//PLAYER INVENTORYCLOSED EH
player addEventHandler ["InventoryClosed",{call BRPVP_pehInventoryClosed;}];
BRPVP_pehInventoryClosed = {
	//REMOVE SET LOCALITY TO PLAYER IF POSSIBLE AND HAVE CARGO (FOR FASTER ITEM TRANSFER)
	private _setAgainToServer = [];
	{if (local _x) then {_setAgainToServer pushBack _x;};} forEach BRPVP_inventoryBoxesSetToLocal;
	_setAgainToServer remoteExecCall ["BRPVP_setOwnerForFasterItemTransferBackToSv",2];
	BRPVP_inventoryBoxesSetToLocal = [];

	//GIVE ALT+I ITEMS TO PLAYER
	private _principal = BRPVP_inventoryBoxes select 0;
	private _altItems = _principal getVariable ["brpvp_alt_i_items",[]];
	if (_altItems isNotEqualTo []) then {
		private _txt = "<t align='center' size='1.0'>"+(localize "str_found_alti_items")+"</t><br /><br />";
		{
			_x params ["_item","_q"];
			_x call BRPVP_sitAddItem;
			private _img = BRPVP_imagePrefix+(BRPVP_specialItemsImages select _item);
			_txt = _txt+format ["<img align='center' size='1.25' shadow='0' image='%1' /><t align='center' size='1.0'> X %2</t><br />",_img,_q];
		} forEach _altItems;
		_principal setVariable ["brpvp_alt_i_items",[],true];
		[_txt,0,0,6,0,0,1756] call BRPVP_fnc_dynamicText;
	};

	//SET VEHICLES OR BOXES TO SAVE ON DB
	{
		if (_x getVariable ["id_bd",-1] >= 0 && !(_x isKindOf "CAManBase")) then {
			if !(_x getVariable ["slv",false]) then {_x setVariable ["slv",true,true];};
		} else {
			if (_x getVariable ["brpvp_del_when_empty",false]) then {
				_cargo = magazineCargo _x+weaponCargo _x+itemCargo _x+backPackCargo _x;
				if (_cargo isEqualTo []) then {deleteVehicle _x;};
			};
		};
	} forEach BRPVP_inventoryBoxes;

	BRPVP_inventoryOpenID = BRPVP_inventoryOpenID+1;
	BRPVP_inventoryBoxes = [];
	player setVariable ["brpvp_inv_opened_boxes",[],[clientOwner,2]];

	//SPEC SEND GEAR OFF
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {["",0,0,0,0,0,1983745] remoteExecCall ["BRPVP_fnc_dynamicTextSpec",BRPVP_specOnMeMachinesNoMe];};
	BRPVP_takeLast = "";
	BRPVP_takeRepeat = 0;
};

//ANTI DUPE
player addEventHandler ["GetOutMan",{
	params ["_unit","_role","_vehicle","_turret"];
	_items = [];
	{
		_items pushBack (_x call BRPVP_getCargoArrayNoNumber);
	} forEach [uniformContainer _unit,vestContainer _unit, backPackContainer _unit];
	_items = _items call BRPVP_joinCargos;
	_playerLastInvOnCar = BRPVP_playerLastInvOnCar call BRPVP_joinCargos;
	{
		_idx = _items find _x;
		if (_idx > -1) then {_items deleteAt _idx;};
	} forEach _playerLastInvOnCar;
	if (count _items > 0) then {[_items,[player]] call BRPVP_cargosRemoveItems;};
}];
player addEventHandler ["GetInMan",{
	params ["_unit","_role","_vehicle","_turret"];
	_items = [];
	{
		_items pushBack (_x call BRPVP_getCargoArrayNoNumber);
	} forEach [uniformContainer _unit,vestContainer _unit, backPackContainer _unit];
	BRPVP_playerLastInvOnCar = _items;
	_unit spawn {
		waitUntil {
			sleep 0.001;
			if (!isNull objectParent _this) then {
				_items = [];
				{
					_items pushBack (_x call BRPVP_getCargoArrayNoNumber);
				} forEach [uniformContainer _this,vestContainer _this, backPackContainer _this];
				BRPVP_playerLastInvOnCar = _items;
			};
			isNull objectParent _this
		};
	};
}];

diag_log ("[SCRIPT] playerEventHandlers.sqf END: " + str round (diag_tickTime-_scriptStart));