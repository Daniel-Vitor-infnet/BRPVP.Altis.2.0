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
diag_log "[SCRIPT] clientOnlyFunctions.sqf BEGIN";

call compile preProcessFileLineNumbers "client_code\spectatorConstruction.sqf";
BRPVP_voodooSetPlayerToBlindRecoveryRunning = false;
BRPVP_voodooSetPlayerToBlind = {
	(player getVariable "id_bd") remoteExecCall ["BRPVP_blindPlayersIdAdd",2];
	player setVariable ["brpvp_blind",true,true];

	if (BRPVP_lightBlindRunning isEqualTo 0) then {
		[player,["voodoo_use",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
		private _init = time;
		waitUntil {time-_init >= 1 || !(player call BRPVP_pAlive) || !(player getVariable ["brpvp_blind",false]) || BRPVP_miraculousEyeDropUsing};
		if (time-_init >= 1) then {
			[player,["blind",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
			private _priority = 1500;
			while {BRPVP_blindHandle = ppEffectCreate ["ColorCorrections",_priority];BRPVP_blindHandle < 0} do {_priority = _priority+1;};
			BRPVP_blindHandle ppEffectEnable true;
			BRPVP_blindHandle ppEffectAdjust [0.0625,1.75,-0.75,[0.25,0,0,0.25],[1,1,1,1],[0.299,0.587,0.114,1],[-1,-1,0,0,0,0,0]];
			BRPVP_blindHandle ppEffectCommit 4;
		};
	} else {
		[player,["blind",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
		[player,["voodoo_use",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
		BRPVP_atomicBombInitBlind = true;
	};

	private _init = time;
	waitUntil {time-_init > BRPVP_voodooMinEffectTime || !(player call BRPVP_pAlive) || !(player getVariable ["brpvp_blind",false]) || BRPVP_miraculousEyeDropUsing};

	if (time-_init > BRPVP_voodooMinEffectTime) then {
		BRPVP_voodooSetPlayerToBlindRecoveryRunning = true;
		waitUntil {BRPVP_lightBlindRunning isEqualTo 0 || !(player call BRPVP_pAlive && !(player getVariable ["brpvp_blind",false]) && !BRPVP_miraculousEyeDropUsing)};
		if (player call BRPVP_pAlive && (player getVariable ["brpvp_blind",false]) && !BRPVP_miraculousEyeDropUsing) then {
			if (BRPVP_blindHandle isEqualTo -1) then {
					player setVariable ["brpvp_blind",false,true];
			} else {
				(player getVariable "id_bd") remoteExecCall ["BRPVP_blindPlayersIdRemove",2];
				BRPVP_blindHandle ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,1],[-1,-1,0,0,0,0,0]];
				BRPVP_blindHandle ppEffectCommit 3;
				waitUntil {ppEffectCommitted BRPVP_blindHandle || BRPVP_lightBlindRunning isNotEqualTo 0};
				BRPVP_blindHandle ppEffectEnable false;
				ppEffectDestroy BRPVP_blindHandle;
				BRPVP_blindHandle = -1;
				player setVariable ["brpvp_blind",false,true];
			};
		};
		BRPVP_voodooSetPlayerToBlindRecoveryRunning = false;
	};
};
BRPVP_sabotageVehicle = {
	private _mny = player getVariable ["mny",0];
	if (_mny >= BRPVP_vehSabotagePrice) then {
		private _veh = _this select 3;
		private _vehSabo = _veh getVariable ["brpvp_veh_saboted",false];
		private _dist = player distance _veh;
		if (_vehSabo) then {
			[localize "str_already_saboted",-5] call BRPVP_hint;
			"erro" call BRPVP_playSound;
		} else {
			private _init = time;
			[_veh,["veh_sabotage",350]] remoteExecCall ["say3D",0];
			waitUntil {
				time-_init > 1.5 || !alive _veh || !(player call BRPVP_pAlive) || player distance _veh > (_dist+2.5)
			};
			if (time-_init > 1.5) then {
				private _mny = player getVariable ["mny",0];
				if (_mny >= BRPVP_vehSabotagePrice) then {
					player setVariable ["mny",_mny-BRPVP_vehSabotagePrice,true];
					_veh setVariable ["brpvp_veh_saboted",true,true];
					[localize "str_veh_saboted_ok",-4] call BRPVP_hint;
					"negocio" call BRPVP_playSound;
				} else {
					"erro" call BRPVP_playSound;
				};
			} else {
				"erro" call BRPVP_playSound;
			};
		};
	} else {
		"erro" call BRPVP_playSound;
	};
};
BRPVP_sendTurretsOnSpected = {
	params ["_allTurretsOnMeRedSpec","_allTurretsOnMeRedSeeSpec"];
	BRPVP_allTurretsOnMeRedSpec = _allTurretsOnMeRedSpec;
	BRPVP_allTurretsOnMeRedSeeSpec = _allTurretsOnMeRedSeeSpec;
};
BRPVP_turretShotOn = [objNull,objNull,objNull];
BRPVP_turretShotOnTime = [0,0,0];
BRPVP_setTurretShotOn = {
	private _turret = _this;
	if ((BRPVP_turretShotOn find _turret) isEqualTo -1) then {
		private _op = _turret getVariable ["brpvp_operator",objNull];
		private _isFriendOficial = _turret call BRPVP_checaAcesso || {[_turret,player] call BRPVP_checkIfTurretIsFriendByFlag};
		private _otherStops = isNull _op || _op getVariable ["brpvp_dead",true] || !(player call BRPVP_pAlive);
		private _isBaseTest = (player getVariable ["brpvp_base_test",0]) isEqualTo 1;
		if ((!_isFriendOficial || _isBaseTest) && !_otherStops) then {
			BRPVP_turretShotOn = [_turret]+BRPVP_turretShotOn;
			BRPVP_turretShotOn deleteAt (count BRPVP_turretShotOn-1);
			BRPVP_turretShotOnTime = [diag_tickTime]+BRPVP_turretShotOnTime;
			BRPVP_turretShotOnTime deleteAt (count BRPVP_turretShotOnTime-1);
		};
	};
};
BRPVP_playerIsBusyForRyanZeds = {
	private _inVeh = !isNull objectPArent player;
	BRPVP_uPackUsing || BRPVP_uberAttackUsing || (BRPVP_constantRunOn && BRPVP_superRunSpeedSelected > 2) || BRPVP_playerLaunchUsing || _inVeh || BRPVP_myBaseState > 1
};
BRPVP_baseFlyCodeAdminOnOff = {
	if (BRPVP_flyOnOff) then {
		"erro" call BRPVP_playSound;
	} else {
		if (BRPVP_flyOnOffAdmin || {player call BRPVP_pAlive && (animationState player find "halofreefall_") isEqualTo -1}) then {
			BRPVP_flyOnOffAdmin = !BRPVP_flyOnOffAdmin;
			if (BRPVP_flyOnOffAdmin) then {
				player setUnitFreefallHeight 3000;
				private _h = getPos player select 2;
				if (_h < 1) then {player setPosASL (getPosASL player vectorAdd [0,0,1.2-_h]);};
				player setVariable ["brpvp_no_colision_cam_base",true];
			} else {
				BRPVP_flyAcell = false;
				BRPVP_flyA1 = false;
				BRPVP_flyA2 = false;
				BRPVP_flyB1 = false;
				BRPVP_flyB2 = false;
				BRPVP_flyC1 = false;
				BRPVP_flyC2 = false;
				player setVariable ["brpvp_no_colision_cam_base",false];
				player setUnitFreefallHeight 100;
			};
		} else {
			"erro" call BRPVP_playSound;
		};
	};
};
BRPVP_bigFrantaSpectatorObjs = [];
BRPVP_bigFrantaSpectatorCode = {
	params ["_add","_leave"];
	private _sizeMult = BRPVP_fantaMinesBigAlertSize;
	BRPVP_bigFrantaSpectatorObjs = (BRPVP_bigFrantaSpectatorObjs+_add)-_leave;
	BRPVP_bigFrantaSpectatorObjs = BRPVP_bigFrantaSpectatorObjs arrayIntersect BRPVP_bigFrantaSpectatorObjs;
	{
		private _fbo = createSimpleObject ["Land_Can_V2_F",getPosASL _x,true];
		private _dh = (getPosWorld _fbo select 2)-(getPosASL _fbo select 2);
		_fbo setObjectScale _sizeMult;
		_fbo setPosWorld (getPosWorld _fbo vectorAdd [0,0,(_sizeMult-1)*_dh]);
		_fbo setVariable ["brpvp_fbo_ifm",true];
		_x setVariable ["brpvp_fbo",_fbo];
	} forEach _add;
	{deleteVehicle (_x getVariable "brpvp_fbo");} forEach _leave;
};
BRPVP_removeActionBeforeVehDel = {
	if (hasInterface) then {
		private _ruins = _this;
		if (objectParent player isEqualTo _ruins) then {
			if (BRPVP_carryHeliAction > -1) then {
				player removeAction BRPVP_carryHeliAction;
				BRPVP_carryHeliAction = -1;
			};
		};
	};
};
BRPVP_spotServicePlayerFoundMessage = {
	BRPVP_spotServiceLocalFoundMessage = serverTime;
};
BRPVP_addSpotBackInformation = {
	params ["_mid","_value"];
	private _idx = -1;
	{if ((_x select 0) isEqualTo _mid) exitWith {_idx = _forEachIndex;};} forEach BRPVP_spotServiceBackInformationList;
	if (_idx isEqualTo -1) then {
		BRPVP_spotServiceBackInformationList pushBack [_mid,serverTime,_value];
	} else {
		(BRPVP_spotServiceBackInformationList select _idx) set [2,(BRPVP_spotServiceBackInformationList select _idx select 2)+_value];
	};
};
BRPVP_raidTrainingGetMagusVeh = {
	[_this,player,player getVariable "id_bd",player getVariable "dstp",player getVariable "amg"] remoteExecCall ["BRPVP_raidTRainingSpawnMagusVehicle",2];
};
BRPVP_carryBoxSetScaleOnMeAdd = {
	BRPVP_carryBoxSetScaleOnMe pushBack _this;
};
BRPVP_sixthSenseReceiveSpecVars = {
	params ["_sixthSensePower","_sixthSensePowerPlayer","_sixthSenseOn","_sixthSenseSeePlayer","_sixthSenseRange"];
	BRPVP_sixthSensePowerSpec = _sixthSensePower;
	BRPVP_sixthSensePowerPlayerSpec = _sixthSensePowerPlayer;
	BRPVP_sixthSenseOnSpec = _sixthSenseOn;
	BRPVP_sixthSenseSeePlayerSpec = _sixthSenseSeePlayer;
	BRPVP_sixthSenseRangeSpec = _sixthSenseRange;
};
BRPVP_pathClimbActionCode =	{
	private _h = getPosASL player select 2;
	if (BRPVP_pathClimbTrying || BRPVP_pathClimbOn || !isNull objectParent player || _h < -2.25 || stance player isEqualTo "PRONE") then {
		"erro" call BRPVP_playSound;
	} else {
		private _run = false;
		if (_h >= -2.25 && _h < 0) then {
			private _lis = lineIntersectsSurfaces [eyePos player,eyePos player vectorAdd [0,0,2.25-(2.25+_h)],player,objNull,true,1,"GEOM","NONE",true];
			if (_lis isEqualTo []) then {
				player setPosASL ((getPosASL player select [0,2])+[0]);
				_run = true;
			} else {
				"erro" call BRPVP_playSound;
			};
		} else {
			_run = true;
		};
		if (_run) then {
			BRPVP_pathClimbTrying = true;
			["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\special_climb_off.paa'/><br /><t size='0.8'>"+format [localize "str_special_climb_start",4]+"</t>",0,0.25,36000,0,0,5357] call BRPVP_fnc_dynamicText;
			diag_tickTime spawn {
				waitUntil {diag_tickTime-_this >= 1};
				for "_i" from 3 to 1 step -1 do {
					if (BRPVP_pathClimbOn) exitWith {};
					["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\special_climb_off.paa'/><br /><t size='0.8'>"+format [localize "str_special_climb_start",_i]+"</t>",0,0.25,36000,0,0,5357] call BRPVP_fnc_dynamicText;
					uiSleep 1;
				};
			};
			player setUnitFreefallHeight 5000;
			call BRPVP_pathClimb;
		};		
	};
};
BRPVP_pathClimbStart = {
	_sndStarted = true;
	["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\special_climb.paa'/><br /><t size='0.8'>"+localize "str_special_climb_look_up"+"</t><br /><t size='0.8'>"+localize "str_special_climb_press_space"+"</t>",0,0.25,36000,0,0,5357] call BRPVP_fnc_dynamicText;
	[player,["special_climb_jump",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
	BRPVP_pathClimbTrying = false;
	BRPVP_pathClimbOn = true;
	0 spawn {
		private _init = diag_tickTime;
		private _sounder = "Land_HelipadEmpty_F" createVehicle [0,0,0];
		_sounder attachTo [player,[0,0,0]];
		[_sounder,["special_climb",120]] remoteExecCall ["say3D",BRPVP_allNoServer];
		waitUntil {
			if (diag_tickTime-_init > 22.5) then {
				[_sounder,["special_climb",120]] remoteExecCall ["say3D",BRPVP_allNoServer];
				_init = diag_tickTime;
			};
			!BRPVP_pathClimbOn
		};
		detach _sounder;
		deleteVehicle _sounder;
	};
};
BRPVP_pathClimb = {
	private _init = diag_tickTime;
	private _initV = 0;
	private _lis = [];
	private _ok = false;
	private _sndStarted = false;
	private _lastLis = [];
	private _attachDist = 3;
	private _subCeilJumpDone = false;
	waitUntil {
		for "_z" from 5 to 0 step -0.25 do {
			private _extraClimbObjsNoClass = ["castle_01_house_","castle_01_wall_","castle_01_church_","powerpole","part_0.p3d","part_1_a.p3d","part_1_b.p3d","part_2.p3d","part_3_a.p3d","part_3_b.p3d","part_4_a.p3d","part_4_b.p3d"];
			_lis = lineIntersectsSurfaces [eyePos player,AGLToASL positionCameraToWorld [0,_z,15],player,objNull,true,1,"GEOM","NONE",true];
			if (_lis isNotEqualTo [] && {!isNull (_lis select 0 select 2) && (typeOf (_lis select 0 select 2) isNotEqualTo "" || {str (_lis select 0 select 2) find _x > -1} count _extraClimbObjsNoClass > 0)}) then {
				private _pos = _lis select 0 select 0;
				private _distEyeOk = ASLToAGL _pos distance ASLToAGL eyePos player <= _attachDist;
				private _distFootOk = ASLToAGL _pos distance ASLToAGL getPosASL player <= _attachDist;
				_ok = _distEyeOk || _distFootOk;
			};
			if (_ok) exitWith {};
		};
		if (_ok) then {
			_ok = false;
			private _pos = _lis select 0 select 0;
			private _normal = (_lis select 0 select 1) vectorMultiply 0.75;
			private _pop = eyePos player;
			private _pnp = _pos vectorAdd _normal;
			private _velocity = vectorNormalized (_pnp vectorDiff _pop) vectorMultiply 3;
			private _angle = acos (_normal vectorCos [0,0,1]);
			private _nof = _angle < 20;
			private _pif = getPosASL player vectorAdd [-0.3*sin getDir player,-0.3*cos getDir player,0];
			private _ltf = lineIntersectsSurfaces [_pif,_pif vectorAdd [0,0,-1.25],player,objNull,true,1,"GEOM","NONE",true];
			private _upVel = 1.25*((_angle max 90)-90)/90;
			private _wait = if (_nof && _ltf isNotEqualTo []) then {0.5} else {0.25};
			drawIcon3D [BRPVP_missionRoot+"BRP_imagens\spec_mouse.paa",[1,1,1,1],ASLToAGL _pos,1,1,0,""];
			//drawLine3D [ASLToAGL _pos,ASLToAGL (_pos vectorAdd (_normal vectorMultiply 0.5)),[1,0,0,1]];
			_attachDist = 3+2*((_angle max 90)-90)/90;
			if (diag_tickTime-_initV > _wait || BRPVP_pathClimbBigJump || _lastLis isEqualTo []) then {
				_subCeilJumpDone = false;
				_lastLis = _lis;
				_initV = diag_tickTime;
				if (_velocity select 2 < 0) then {
					_velocity set [2,-1];
					if (!_sndStarted && getPos player select 2 > 0.5) then {call BRPVP_pathClimbStart;};
				} else {
					if (!_sndStarted) then {call BRPVP_pathClimbStart;};
				};
				if (BRPVP_pathClimbBigJump) then {
					if (_angle < 125) then {
						player setVelocity [0,0,7.5];
						BRPVP_pathClimbBigJump = false;
						[player,["special_climb_jump",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
						_initV = _initV+0.575;
					} else {
						BRPVP_pathClimbBigJump = false;
						[player,["special_climb_jump",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
						player setVelocity (_velocity vectorAdd [0,0,_upVel]);
					};
				} else {
					player setVelocity (_velocity vectorAdd [0,0,_upVel]);
				};
			};
		} else {
			if (_lastLis isNotEqualTo []) then {
				private _lastNormal = _lastLis select 0 select 1;
				if (acos (_lastNormal vectorCos [0,0,-1]) < 20) then {
					if (BRPVP_pathClimbBigJump) then {
						BRPVP_pathClimbBigJump = false;
						private _lastPos = _lastLis select 0;
						player setVelocity [0,0,7.5];
						BRPVP_pathClimbBigJumpLast = 0;
					} else {
						if (!_subCeilJumpDone) then {
							private _pd = getDir player;
							private _vel = [5*sin _pd,5*cos _pd,1.25];
							player setVelocity _vel;
							_subCeilJumpDone = true;
						};
					};
				} else {
					if (!_subCeilJumpDone) then {
						_subCeilJumpDone = true;
						BRPVP_pathClimbBigJumpLast = 0;
					};
					if (BRPVP_pathClimbBigJump) then {
						BRPVP_pathClimbBigJump = false;
						private _pd = getDir player;
						private _vel = [5*sin _pd,5*cos _pd,1];
						player setVelocity _vel;
					};
				};
			};
		};
		(diag_tickTime-_init > 4 && getPos player select 2 < 0.25) || !(player call BRPVP_pAlive) || !isNull objectParent player
	};
	["",0,0.25,36000,0,0,5357] call BRPVP_fnc_dynamicText;
	[player,["special_climb_end",120]] remoteExecCall ["say3D",BRPVP_allNoServer];
	uiSleep 0.5;
	BRPVP_pathClimbTrying = false;
	BRPVP_pathClimbOn = false;
	player setUnitFreefallHeight 100;
};
BRPVP_useBuildingElevator = {
	(_this select 3) params ["_building","_elevatorPlaceIn","_floorOrTop","_elevatorIdx","_actionVar"];
	BRPVP_usingElevatorDoorSelected = nil;
	BRPVP_usingElevator = true;
	BRPVP_walkDisabled = true;
	private _end = -1;
	private _doors = if (_floorOrTop isEqualTo "floor") then {BRPVP_elevatorBuildingsTop select _elevatorIdx} else {BRPVP_elevatorBuildingsFloor select _elevatorIdx};
	private _doorsQtt = count _doors;
	private _doorsImg = format ["<img shadow='0' size='2' image='%1BRP_imagens\elevator_door_1.paa'/>",BRPVP_imagePrefix];
	private _playerPos = ASLToAGL getPosASL player;
	for "_i" from 2 to _doorsQtt do {_doorsImg = format ["%1   <img shadow='0' size='2' image='%2BRP_imagens\elevator_door_%3.paa'/>",_doorsImg,BRPVP_imagePrefix,[_i,"x"] select (_i > 10)];};
	["<t>"+localize "str_elevator_select_a_door"+"</t><br /><br /><t>"+_doorsImg+"</t>",0,0,50000,0,0,29472] call BRPVP_fnc_dynamicText;
	waitUntil {(!isNil "BRPVP_usingElevatorDoorSelected" && {BRPVP_usingElevatorDoorSelected <= _doorsQtt}) || !(player call BRPVP_pAlive) || player distance _playerPos > 1};
	if (player call BRPVP_pAlive && player distance _playerPos <= 1 && (!isNil "BRPVP_usingElevatorDoorSelected" && {BRPVP_usingElevatorDoorSelected isNotEqualTo -1})) then {_end = _doors select (BRPVP_usingElevatorDoorSelected-1);};
	["",0,0,50000,0,0,29472] call BRPVP_fnc_dynamicText;

	if (_end isEqualTo -1) then {
		BRPVP_walkDisabled = false;
		BRPVP_usingElevator = false;
		"erro" call BRPVP_playSound;
	} else {
		_end = _building modelToworld _end;

		player allowDamage false;
		[player,true] remoteExecCall ["hideObjectGlobal",2];

		private _sounder = "Land_HelipadEmpty_F" createVehicle _end;
		_sounder setPosASL AGLToASL _end;
		[_sounder,["elevator",200]] remoteExecCall ["say3D",BRPVP_allNoServer];

		_cam = "camera" camCreate (_end vectorAdd [0.1,0.1,4]);
		_cam camSetFocus [-1,-1];
		_cam camSetTarget _sounder;
		_cam cameraEffect ["INTERNAL","BACK"];
		_cam camCommit 0;
		
		private _init = diag_tickTime;
		waitUntil {diag_tickTime-_init > 5};
		uiSleep 0.75;
		
		BRPVP_walkDisabled = false;
		player setPosASL AGLToASL _end;
		uiSleep 0.001;
		player removeAction (_building getVariable [_actionVar,-1]);
		_building setVariable [_actionVar,-1];
		player hideObject false;
		[player,player getVariable ["brpvp_invisible",false]] remoteExecCall ["hideObjectGlobal",2];
		uiSleep 0.25;
		_cam cameraEffect ["TERMINATE","BACK"];
		camDestroy _cam;
		player allowDamage true;
		deleteVehicle _sounder;
		BRPVP_usingElevator = false;
	};
};
BRPVP_checkCraneFinishedSet = {
	BRPVP_checkCraneFinished = _this;
};
BRPVP_vehicleFlyNitroLocalEffect = {
	params ["_player","_veh"];
	private _sizeMult = (sizeOf typeOf _veh)/10;
	private _fuSize = [_sizeMult*2,_sizeMult*5];
	private _pModel = getCenterOfMass _veh vectorAdd [0,-1,0];
	private _init = diag_tickTime;
	waitUntil {
		private _perc = (diag_tickTime-_init)*2 min 1;
		private _velMag = vectorMagnitude velocity _veh;
		private _disAlign = (acos (velocity _veh vectorCos vectorDir _veh))/90;
		drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,0.5,_pModel,[0,-7.5*_perc-_disAlign*_velMag,0],-15+random 30,0.005,0.003925,0.1,_fuSize,[[0.8,0.8,0.8,_perc*0.8],[0.8,0.8,0.8,0]],[1],0.01,0.5,"","",_veh];
		_perc isEqualTo 1
	};
	waitUntil {
		private _perc = 1;
		private _velMag = vectorMagnitude velocity _veh;
		private _disAlign = (acos (velocity _veh vectorCos vectorDir _veh))/90;
		drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,0.5,_pModel,[0,-7.5*_perc-_disAlign*_velMag,0],-15+random 30,0.005,0.003925,0.1,_fuSize,[[0.8,0.8,0.8,_perc*0.8],[0.8,0.8,0.8,0]],[1],0.01,0.5,"","",_veh];
		!(_veh getVariable ["brpvp_fly_nitro",false]) || isNull _veh
	};
	_init = diag_tickTime;
	waitUntil {
		private _perc = (1-(diag_tickTime-_init)*2) max 0;
		private _velMag = vectorMagnitude velocity _veh;
		private _disAlign = (acos (velocity _veh vectorCos vectorDir _veh))/90;
		drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,0.5,_pModel,[0,-7.5*_perc-_disAlign*_velMag,0],-15+random 30,0.005,0.003925,0.1,_fuSize,[[0.8,0.8,0.8,_perc*0.8],[0.8,0.8,0.8,0]],[1],0.01,0.5,"","",_veh,0];
		_perc isEqualTo 0
	};
};
BRPVP_drawMissileLaserRotateParams = ["_obj","_ray","_angle"];
BRPVP_drawMissileLaserRotate = {
	params BRPVP_drawMissileLaserRotateParams;
	_ray = _obj vectorWorldToModel _ray;
	_obj vectorModelToWorld [(_ray#2)*sin _angle+(_ray#0)*cos _angle,_ray#1,(_ray#2)*cos _angle-(_ray#0)*sin _angle]
};
BRPVP_drawAtomicMissileLaser = {
	params ["_missile","_posOld","_sound"];
	private _sm = getText (configFile >> "CfgAmmo" >> typeOf _missile >> "submunitionAmmo");
	private _posNew = getPosWorld _missile;
	private _init = diag_tickTime;
	private _snd = createSimpleObject ["Land_Matches_F",[0,0,0],true];
	_snd setPosWorld (_posNew vectorAdd (_missile vectorModelToWorld [0,0,5]));
	_snd say3D [_sound,7500];
	waitUntil {
		if (isNull _missile && _sm isNotEqualTo "") then {
			private _smFound = nearestObjects [ASLToAGL _posNew,[_sm],75];
			if (_smFound isNotEqualTo []) then {_missile = selectRandom _smFound;};
		};
		if (!isNull _missile) then {_posNew = getPosWorld _missile;};
		private _dist = _missile distance player;
		private _opacityInit = (_dist min 100)/100;
		private _opacityNormal = sqrt(1-(1 min (_dist/1700)));
		private _opacity = _opacityNormal*_opacityInit;
		private _vec = _posNew vectorDiff _posOld;
		private _vecBack = (vectorNormalized (_posOld vectorDiff _posNew)) vectorMultiply 0.75;
		private _ray1 = vectorNormalized (_vec vectorCrossProduct [0,0,1]);
		private _ray2 = vectorNormalized (_vec vectorCrossProduct _ray1);
		private _ray3 = vectorNormalized ([0,0,1] vectorCrossProduct _vec);
		private _ray4 = vectorNormalized (_ray1 vectorCrossProduct _vec);
		private _ray5 = vectorNormalized (_ray1 vectorAdd _ray2);
		private _ray6 = vectorNormalized (_ray2 vectorAdd _ray3);
		private _ray7 = vectorNormalized (_ray3 vectorAdd _ray4);
		private _ray8 = vectorNormalized (_ray4 vectorAdd _ray1);
		private _dltTime = diag_tickTime-_init;
		private _angle = _dltTime*540*sqrt(_dltTime min 1);
		private _raysA = ([_ray1,_ray2,_ray3,_ray4] apply {[_missile,_x,_angle] call BRPVP_drawMissileLaserRotate}) apply {_x vectorAdd _vecBack};
		private _raysB = ([_ray5,_ray6,_ray7,_ray8] apply {[_missile,_x,_angle] call BRPVP_drawMissileLaserRotate}) apply {_x vectorAdd _vecBack};
		if (_opacity > 0) then {
			{drawLaser [_posNew,_x,[0,0,1000],[],0,11*_opacity,_opacity*(25+10*sin(diag_tickTime*4*360)),false];} forEach _raysA;
			{drawLaser [_posNew,_x,[750,0,0],[],0,11*_opacity,_opacity*(25+10*sin(180+diag_tickTime*4*360)),false];} forEach _raysB;
		};
		_snd setPosWorld (_posNew vectorAdd (_missile vectorModelToWorld [0,0,5]));
		_posOld = _posNew;
		isNull _missile
	};
	deleteVehicle _snd;
};
BRPVP_drawMissileLaser = {
	params ["_missile","_posOld"];
	private _sm = getText (configFile >> "CfgAmmo" >> typeOf _missile >> "submunitionAmmo");
	private _posNew = getPosWorld _missile;
	private _init = diag_tickTime;
	private _snd = createSimpleObject ["Land_Matches_F",[0,0,0],true];
	_snd setPosWorld (_posNew vectorAdd (_missile vectorModelToWorld [0,0,5]));
	_snd say3D ["minerva_sound",5000];
	waitUntil {
		if (isNull _missile && _sm isNotEqualTo "") then {
			private _smFound = nearestObjects [ASLToAGL _posNew,[_sm],75];
			if (_smFound isNotEqualTo []) then {_missile = selectRandom _smFound;};
		};
		if (!isNull _missile) then {_posNew = getPosWorld _missile;};
		private _dist = _missile distance player;
		private _opacityInit = (_dist min 100)/100;
		private _opacityNormal = sqrt(1-(1 min (_dist/1700)));
		private _opacity = _opacityNormal*_opacityInit;
		private _vec = _posNew vectorDiff _posOld;
		private _vecBack = (vectorNormalized (_posOld vectorDiff _posNew)) vectorMultiply 0.75;
		private _ray1 = vectorNormalized (_vec vectorCrossProduct [0,0,1]);
		private _ray2 = vectorNormalized (_vec vectorCrossProduct _ray1);
		private _ray3 = vectorNormalized ([0,0,1] vectorCrossProduct _vec);
		private _ray4 = vectorNormalized (_ray1 vectorCrossProduct _vec);
		private _ray5 = vectorNormalized (_ray1 vectorAdd _ray2);
		private _ray6 = vectorNormalized (_ray2 vectorAdd _ray3);
		private _ray7 = vectorNormalized (_ray3 vectorAdd _ray4);
		private _ray8 = vectorNormalized (_ray4 vectorAdd _ray1);
		private _dltTime = diag_tickTime-_init;
		private _angle = _dltTime*180*sqrt(_dltTime min 1);
		private _raysA = ([_ray1,_ray2,_ray3,_ray4] apply {[_missile,_x,_angle] call BRPVP_drawMissileLaserRotate}) apply {_x vectorAdd _vecBack};
		private _raysB = ([_ray5,_ray6,_ray7,_ray8] apply {[_missile,_x,_angle] call BRPVP_drawMissileLaserRotate}) apply {_x vectorAdd _vecBack};
		if (_opacity > 0) then {
			{drawLaser [_posNew,_x,[0,0,1000],[],0,11*_opacity,_opacity*(25+10*sin(diag_tickTime*360)),false];} forEach _raysA;
			{drawLaser [_posNew,_x,[750,0,0],[],0,11*_opacity,_opacity*(25+10*sin(180+diag_tickTime*360)),false];} forEach _raysB;
		};
		_snd setPosWorld (_posNew vectorAdd (_missile vectorModelToWorld [0,0,5]));
		_posOld = _posNew;
		isNull _missile
	};
	deleteVehicle _snd;
};
BRPVP_specReceiveNIP = {
	params ["_nearIdentifiedPlayers","_newersDiscovered"];
	BRPVP_nearIdentifiedPlayers = _nearIdentifiedPlayers;
	BRPVP_newersDiscovered = _newersDiscovered;
};
BRPVP_boxCarryJoinItemsCode = {
	params ["_nwo","_b","_model"];
	private _p = player;
	if (!local _nwo) then {
		[_nwo,clientOwner] remoteExecCall ["setOwner",2];
		private _init = time;
		waitUntil {local _nwo || time-_init > 2.5 || !(_p call BRPVP_pAlive)};
	};
	if (!local _nwo || !(_p call BRPVP_pAlive)) exitWith {"erro" call BRPVP_playSound;};
	private _wh = createVehicle ["GroundWeaponHolder",ASLToATL getPosASL _b,[],50,"CAN_COLLIDE"];
	[_b,_wh,ASLToATL getPosASL _p] call BRPVP_transferCargoCargoB;
	[_nwo,_wh,ASLToATL getPosASL _p] call BRPVP_transferCargoCargoB;

	//FINALIZE
	_b setPosASL (BRPVP_posicaoFora vectorAdd [-200+random 400,-200+random 400,0]);
	_nwo setPosASL (BRPVP_posicaoFora vectorAdd [-200+random 400,-200+random 400,0]);
	[_b,_nwo] spawn {
		params ["_b","_nwo"];
		uiSleep 1.25;
		deleteVehicle _b;
		deleteVehicle _nwo;

		private _wh = BRPVP_carryUsedObjs select 0;
		private _mass = _wh call BRPVP_getContainerMass;
		private _mass100 = round (_mass/100);
		if (_mass100 > 96) then {_mass100 = 100;};
		private _val = [_mass,_mass100,if (_mass100 >= 95) then {"#FF0000"} else {"#FFFFFF"}];
		if (player getVariable ["brpvp_vault_perc",-1] isNotEqualTo _val) then {
			player setVariable ["brpvp_vault_perc",_val,BRPVP_specOnMeMachines];
			remoteExecCall ["BRPVP_atualizaDebug",BRPVP_specOnMeMachines];
		};
	};
	player setVariable ["brpvp_box_carry",_wh,[clientOwner,2] arrayIntersect [clientOwner,2]];
	BRPVP_carryUsedObjs set [0,_wh];
	[_wh,true] remoteExecCall ["hideObjectGlobal",2];
	_wh setPosASL (BRPVP_posicaoFora vectorAdd [-200+random 400,-200+random 400,0]);
	private _mass = _wh call BRPVP_getContainerMass;
	private _mass100 = round (_mass/100);
	if (_mass100 > 96) then {_mass100 = 100;};
	player setVariable ["brpvp_vault_perc",[_mass,_mass100,if (_mass100 >= 95) then {"#FF0000"} else {"#FFFFFF"}],BRPVP_specOnMeMachines];
	remoteExecCall ["BRPVP_atualizaDebug",BRPVP_specOnMeMachines];
};
BRPVP_revealOrHideSmartTv = {
	params ["_stv","_state"];
	_stv hideObject _state;
};
BRPVP_disconnectDeathSignalCamera = {
	params ["_wait","_cams"];
	uiSleep _wait;
	private _secCamBbsMyPlayerSave = +BRPVP_secCamBbsMyPlayerSave;
	private _allBb = allMissionObjects "Land_Billboard_F";
	private _secCamAll = _cams;
	private _allBbId = _allBb apply {_x getVariable ["id_bd",-1]};
	private _secCamAllId = _secCamAll apply {_x getVariable ["brpvp_cam_id",-1]};
	{
		_x params ["_bbId","_fCamId"];
		if !(_bbId isEqualTo -1 || _fCamId isEqualTo -1) then {
			private _idxBb = _allBbId find _bbId;
			private _idxFc = _secCamAllId find _fCamId;
			if !(_idxBb isEqualTo -1 || _idxFc isEqualTo -1) then {
				private _bb = _allBb select _idxBb;
				private _fc = _secCamAll select _idxFc;
				private _camReal = _bb getVariable ["brpvp_bb_camera",objNull];
				if (!isNull _camReal) then {
					private _camKey = format ["seccam%1",_bb getVariable "id_bd"];
					private _camFake = _bb getVariable ["brpvp_bb_camera_fake",objNull];
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_bb,_camKey] remoteExecCall ["BRPVP_smartTvToNullSpec",BRPVP_specOnMeMachinesNoMe];};
					_camReal cameraEffect ["Terminate","Back",_camKey];
					BRPVP_secCamBbsMy = BRPVP_secCamBbsMy-[[_bb,_camReal,_camKey]];
					BRPVP_secCamBbsMyPlayerSave = BRPVP_secCamBbsMyPlayerSave-[[_bb getVariable ["id_bd",-1],_camFake getVariable ["brpvp_cam_id",-1]]];
					camDestroy _camReal;
				};
				_bb setVariable ["brpvp_bb_camera_fake",objNull];
			};
		};
	} forEach _secCamBbsMyPlayerSave;
	player setVariable ["brpvp_seccam_connections",BRPVP_secCamBbsMyPlayerSave,2];
};
BRPVP_useSmartTvSendDeathSignal = {
	if (205 call BRPVP_iniciaMenuExtra) then {BRPVP_menuVar1 = _this select 3;};
};
BRPVP_checkIfSecCamAmgChangeAffect = {
	if (!BRPVP_trataseDeAdmin) then {
		uiSleep 1;
		isNil {
			private _secCamBbsMyPlayerSave = +BRPVP_secCamBbsMyPlayerSave;
			private _allBb = allMissionObjects "Land_Billboard_F";
			private _secCamAll = _this;
			private _allBbId = _allBb apply {_x getVariable ["id_bd",-1]};
			private _secCamAllId = _secCamAll apply {_x getVariable ["brpvp_cam_id",-1]};
			{
				_x params ["_bbId","_fCamId"];
				if !(_bbId isEqualTo -1 || _fCamId isEqualTo -1) then {
					private _idxBb = _allBbId find _bbId;
					private _idxFc = _secCamAllId find _fCamId;
					if !(_idxBb isEqualTo -1 || _idxFc isEqualTo -1) then {
						private _bb = _allBb select _idxBb;
						private _fc = _secCamAll select _idxFc;
						private _fcOwn = _fc getVariable ["brpvp_cam_own",-1];
						private _fcAmg = _fc getVariable ["brpvp_cam_amg",[]];
						private _pId = player getVariable "id_bd";
						if !(_pId isEqualTo _fcOwn || _pId in _fcAmg) then {
							private _camReal = _bb getVariable ["brpvp_bb_camera",objNull];
							if (!isNull _camReal) then {
								private _camKey = format ["seccam%1",_bb getVariable "id_bd"];
								private _camFake = _bb getVariable ["brpvp_bb_camera_fake",objNull];
								if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_bb,_camKey] remoteExecCall ["BRPVP_smartTvToNullSpec",BRPVP_specOnMeMachinesNoMe];};
								_camReal cameraEffect ["Terminate","Back",_camKey];
								BRPVP_secCamBbsMy = BRPVP_secCamBbsMy-[[_bb,_camReal,_camKey]];
								BRPVP_secCamBbsMyPlayerSave = BRPVP_secCamBbsMyPlayerSave-[[_bb getVariable ["id_bd",-1],_camFake getVariable ["brpvp_cam_id",-1]]];
								camDestroy _camReal;
							};
							_bb setVariable ["brpvp_bb_camera_fake",objNull];
						};
					};
				};
			} forEach _secCamBbsMyPlayerSave;
			player setVariable ["brpvp_seccam_connections",BRPVP_secCamBbsMyPlayerSave,2];
		};
	};
};
BRPVP_connectSmartTvs = {
	if (isNil "BRPVP_getSmartTvConnectionsFromSvAnswer") then {
		[player getVariable "id",clientOwner] remoteExecCall ["BRPVP_getSmartTvConnectionsFromSv",2];
		waitUntil {!isNil "BRPVP_getSmartTvConnectionsFromSvAnswer"};
		if (BRPVP_getSmartTvConnectionsFromSvAnswer isNotEqualTo []) then {
			private _allBb = allMissionObjects "Land_Billboard_F";
			private _secCamAll = +BRPVP_secCamAll;
			private _allBbId = _allBb apply {_x getVariable ["id_bd",-1]};
			private _secCamAllId = _secCamAll apply {_x getVariable ["brpvp_cam_id",-1]};
			private _allOkConnections = [];
			BRPVP_secCamBbsMy = [];
			{
				_x params ["_bbId","_fCamId"];
				if !(_bbId isEqualTo -1 || _fCamId isEqualTo -1) then {
					private _idxBb = _allBbId find _bbId;
					private _idxFc = _secCamAllId find _fCamId;
					if !(_idxBb isEqualTo -1 || _idxFc isEqualTo -1) then {
						private _bb = _allBb select _idxBb;
						private _fc = _secCamAll select _idxFc;
						private _fcOwn = _fc getVariable ["brpvp_cam_own",-1];
						private _fcAmg = _fc getVariable ["brpvp_cam_amg",[]];
						private _pId = player getVariable "id_bd";
						if (_pId isEqualTo _fcOwn || _pId in _fcAmg || BRPVP_trataseDeAdmin) then {
							private _camKey = format ["seccam%1",_bbId];
							private _camReal = "camera" camCreate (ASLToAGL getPosASL _fc vectorAdd (vectorDir _fc vectorMultiply -0.2));
							_bb setObjectTexture [0,format ["#(argb,512,512,1)r2t(%1,1)",_camKey]];
							_camReal cameraEffect ["Internal","Back",_camKey];
							_camKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
							_bb setVariable ["brpvp_bb_camera",_camReal];
							BRPVP_secCamBbsMy pushBack [_bb,_camReal,_camKey];
							_allOkConnections pushBack [_bbId,_fCamId];
							_camReal setVectorDirAndUp [vectorDir _fc vectorMultiply -1,vectorUp _fc];
							_bb setVariable ["brpvp_bb_camera_fake",_fc];
							player setPosASL AGLToASL (_bb modelToWorld [0,-2,0]);
							player setDir ([player,_bb] call BIS_fnc_dirTo);
							uiSleep 0.001;
						};
					};
				};
			} forEach BRPVP_getSmartTvConnectionsFromSvAnswer;
			player setVariable ["brpvp_seccam_connections",_allOkConnections,2];
			BRPVP_secCamBbsMyPlayerSave = _allOkConnections;
			BRPVP_secCamBbsMyPlayerSaveLast = _allOkConnections;
		};
	};
};
BRPVP_setLookingBbSyncSpec = {
	params ["_camFake","_oldCamKey",["_newCamKey",""]];
	player setVariable ["brpvp_my_looking_seccam",_camFake,[clientOwner,2]];
	if (_oldCamKey isNotEqualTo "seccam0") then {_oldCamKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];};
	if (_newCamKey isNotEqualTo "") then {_newCamKey setPiPEffect [3,0,1,1,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];};	
};
BRPVP_setSpecSecCams = {
	params ["_specPip","_mlsc","_currentCamKey"];
	{
		_x params ["_bb","_pASL","_vd","_vu","_camKey"];
		if !(isNull _bb || _pASL isEqualTo [0,0,0]) then {
			private _texture = format ["#(argb,512,512,1)r2t(%1,1)",_camKey];
			private _camReal = "camera" camCreate ASLToAGL _pASL;
			if (getObjectTextures _bb select 0 isNotEqualTo _texture) then {_bb setObjectTexture [0,_texture];};
			_camReal cameraEffect ["Internal","Back",_camKey];
			_camReal setVectorDirAndUp [_vd,_vu];
			_camKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
			BRPVP_secCamBbsMySpec pushBack [_bb,_camReal,_camKey];
		};
	} forEach _specPip;
	player setVariable ["brpvp_my_looking_seccam",_mlsc,[clientOwner,2]];
	if (_currentCamKey isNotEqualto "") then {_currentCamKey setPiPEffect [3,0,1,1,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];};
};
BRPVP_smartTvToNullSpec = {
	params ["_bb","_camKeyChange"];
	{
		_x params ["_bb","_camReal","_camKey"];
		if (_camKey isEqualTo _camKeyChange) then {
			_camReal cameraEffect ["Terminate","Back",_camKey];
			BRPVP_secCamBbsMySpec set [_forEachIndex,-1];
			camDestroy _camReal;
		};
	} forEach BRPVP_secCamBbsMySpec;
	BRPVP_secCamBbsMySpec = BRPVP_secCamBbsMySpec-[-1];
};
BRPVP_smartTvSetNewCameraSyncSpec = {
	params ["_camKeyChange","_camFake","_bb"];
	private _camReal = objNull;
	{
		_x params ["_bbArray","_camRealArray","_camKeyArray"];
		if (_camKeyArray isEqualTo _camKeyChange) then {_camReal = _camRealArray;};
	} forEach BRPVP_secCamBbsMySpec;
	private _texture = format ["#(argb,512,512,1)r2t(%1,1)",_camKeyChange];
	if (getObjectTextures _bb select 0 isNotEqualTo _texture) then {_bb setObjectTexture [0,_texture];};
	if (isNull _camReal) then {
		_camReal = "camera" camCreate (ASLToAGL getPosASL _camFake vectorAdd (vectorDir _camFake vectorMultiply -0.2));
		_camReal cameraEffect ["Internal","Back",_camKeyChange];
		_camKeyChange setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
		BRPVP_secCamBbsMySpec pushBack [_bb,_camReal,_camKeyChange];
	} else {
		_camReal setPosASL (getPosASL _camFake vectorAdd (vectorDir _camFake vectorMultiply -0.2));
	};
	_camReal setVectorDirAndUp [vectorDir _camFake vectorMultiply -1,vectorUp _camFake];
};
BRPVP_useSmartTv = {
	if (204 call BRPVP_iniciaMenuExtra) then {BRPVP_menuVar1 = _this select 3;};
};
BRPVP_hauntHouseMusicPlay = {
	if (BRPVP_spectateOn) then {
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_this remoteExecCall ["BRPVP_hauntHouseMusicPlaySpec",BRPVP_specOnMeMachinesNoMe];};
	} else {
		_this say3D ["haunt_house",200];
		_this say3D ["haunt_house_sinister",85];
		_this say3D ["haunt_house_sinister",50];
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_this remoteExecCall ["BRPVP_hauntHouseMusicPlaySpec",BRPVP_specOnMeMachinesNoMe];};
	};
};
BRPVP_hauntHouseJesusOk = {
	if (BRPVP_spectateOn) then {
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_hauntHouseJesusOkSpec",BRPVP_specOnMeMachinesNoMe];};
	} else {
		"756856" cutText ["","WHITE IN",6];
		player say3D ["cry",100];
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_hauntHouseJesusOkSpec",BRPVP_specOnMeMachinesNoMe];};
	};
};
BRPVP_hauntHouseMusicPlaySpec = {
	_this say3D ["haunt_house",200];
	_this say3D ["haunt_house_sinister",85];
	_this say3D ["haunt_house_sinister",50];
};
BRPVP_hauntHouseJesusOkSpec = {
	"756856" cutText ["","WHITE IN",6];
	player say3D ["cry",100];
};
BRPVP_hauntHouseDeath = {
	"128856" cutText ["","BLACK FADED",10];
	BRPVP_hauntDeath = true;
	[objNull,"Ghost_F",true] call BRPVP_pehKilledFakeHandleDamage;
	player setPosASL _this;
	[player,["revive_thunder",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
	uiSleep 1;
	"128856" cutText ["","BLACK IN",2];
};
BRPVP_recalcMyFrantaMines = {
	BRPVP_frantaAllObjs = BRPVP_frantaAllObjs-[objNull];
	BRPVP_frantaAllObjsMy = BRPVP_frantaAllObjs select {_x getVariable "brpvp_mine_base_owner" isEqualTo (player getVariable "id_bd")};
	BRPVP_frantaAllObjsMyFriends = if (BRPVP_vePlayers) then {BRPVP_frantaAllObjs-BRPVP_frantaAllObjsMy} else {(BRPVP_frantaAllObjs-BRPVP_frantaAllObjsMy) select {player getVariable "id_bd" in (_x getVariable "brpvp_mine_base_friends")};};
};
BRPVP_ammoRepackLocalPlayer = {
	player playMoveNow "AmovPercMstpSnonWnonDnon_exercisekneeBendB";
	player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendB";
	waitUntil {animationState player isEqualTo "amovpercmstpsnonwnondnon_exercisekneebendb"};
	waitUntil {animationState player != "amovpercmstpsnonwnondnon_exercisekneebendb"};
	_allMags = [];
	_allMagsCount = [];
	{
		_x params ["_mag","_count"];
		_index = _allMags find _mag;
		if (_index isEqualTo -1) then {
			_allMags pushBack _mag;
			_allMagsCount pushBack _count;
		} else {
			_allMagsCount set [_index,(_allMagsCount select _index) + _count];
		};
	} forEach magazinesAmmo player;
	{
		player removeMagazines _x;
		_countMax = getNumber (configFile >> "CfgMagazines" >> _x >> "count");
		_count = _allMagsCount select _forEachIndex;
		player addMagazines [_x,floor (_count/_countMax)];
		_remains = _count mod _countMax;
		if (_remains > 0) then {player addMagazine [_x,_remains];};
	} forEach _allMags;
	"granted" call BRPVP_playSound;
	sleep 1;
	BRPVP_ammoRepackRunning = false;
};
BRPVP_insideStoneFix = {
	private _asl = getPosASL player;
	private _lis = lineIntersectsSurfaces [_asl vectorAdd [0,0,1],_asl vectorAdd [0,0,25],vehicle player];
	if (_lis isNotEqualTo []) then {
		private _isBadCases = {str (_lis select 0 select 2) find _x isNotEqualTo -1} count BRPVP_insideStoneFixCases > 0;
		if (_isBadCases) then {
			private _isStuck = true;
			{
				private _found = false;
				{
					private _case = _x;
					private _isBadCases = {str (_case select 2) find _x isNotEqualTo -1} count BRPVP_insideStoneFixCases > 0;
					if (_isBadCases || isNull (_case select 2)) exitWith {_found = true;};
				} forEach lineIntersectsSurfaces [_asl vectorAdd [0,0,1],_asl vectorAdd _x,vehicle player,objNull,true,-1];
				if (!_found) exitWith {_isStuck = false;};
			} forEach [[+50,+00,+00],[-50,+00,+00],[+00,+50,+00],[+00,-50,+00],[+35,+35,+00],[-35,+35,+00],[+35,-35,+00],[-35,-35,+00],[+30,+00,+30],[-30,+00,+30],[+00,+30,+30],[+00,-30,+30],[+30,+30,+30],[-30,+30,+30],[+30,-30,+30],[-30,-30,+30],[+30,+00,-30],[-30,+00,-30],[+00,+30,-30],[+00,-30,-30],[+30,+30,-30],[-30,+30,-30],[+30,-30,-30],[-30,-30,-30]];
			if (_isStuck) then {
				private _obj = _lis select 0 select 2;
				private _isInsideBB = [player,_obj] call PDTH_pointIsInBox;
				if (_isInsideBB) then {
					private _bbr = boundingBoxReal _obj;
					private _dso = vectorMagnitude ((_bbr select 0) vectorDiff (_bbr select 1));
					private _oRad = 0.7*_dso/2;
					if (ASLToAGL eyePos player distance _obj < _oRad) then {
						private _plim = _lis select 0 select 0;
						private _lis = lineIntersectsSurfaces [_plim vectorAdd [0,0,4],_plim vectorAdd [0,0,-1],vehicle player];
						if (_lis isNotEqualTo []) then {
							private _spos = _lis select 0 select 0;
							player setPosASL (_spos vectorAdd [0,0,0.5]);
							0 spawn {
								uisleep 0.001;
								call BRPVP_insideStoneFix;
							};
						};
					};
				};
			};
		};
	};
};
//PLAYER UBER ATTACK ITEM
BRPVP_uberAttackPlayerSelectTarget = {
	params ["_error","_instructions"];
	private _posOriginal = ASLToAGL getPosASL player;
	private _iTxt = diag_tickTime;
	private _distNotOkTime = 0;
	private _img = BRPVP_specialItemsImages select (BRPVP_specialItems find "BRPVP_uberAttack");
	private _cnt = 35;
	["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+_img+"'/><br /><t>"+localize "str_move_to_cancel"+": "+str _cnt+"<br/>"+localize _instructions+"</t>",0,0,1,0,0,19472] call BRPVP_fnc_dynamicText;
	BRPVP_uberAttackPlayerTarget = objNull;
	BRPVP_uberAttackPlayerSelectPosition = true;
	waitUntil {
		private _co = cursorObject;
		private _dist = _co distance player;
		if (_dist > 50 && _instructions isEqualTo "str_uattack_instructions") then {
			if (_co isKindOf "CaManBase" && alive _co) then {
				BRPVP_uberAttackPlayerTarget = _co;
			} else {
				if (_co call BRPVP_isMotorized && ((ASLToAGL getPosASL _co) select 2) < 35 && alive _co) then {BRPVP_uberAttackPlayerTarget = _co;};
			};
		};
		if (diag_tickTime-_iTxt >= 1) then {
			_iTxt = diag_tickTime;
			_cnt = _cnt-1;
			if (_cnt > 0) then {["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+_img+"'/><br /><t>"+localize "str_move_to_cancel"+": "+str _cnt+"<br/>"+localize _instructions+"</t>",0,0,1,0,0,19472] call BRPVP_fnc_dynamicText;};
		};
		if (!isNull BRPVP_uberAttackPlayerTarget) then {
			private _limDist = if ([getPosWorld BRPVP_uberAttackPlayerTarget,250] call BRPVP_checkIfLandNear) then {1250} else {3500};
			if (player distance BRPVP_uberAttackPlayerTarget > _limDist) then {
				if (typeOf BRPVP_uberAttackPlayerTarget isEqualTo "Sign_Arrow_Large_Cyan_F") then {deleteVehicle BRPVP_uberAttackPlayerTarget;};
				BRPVP_uberAttackPlayerTarget = objNull;
				if (diag_tickTime-_distNotOkTime > 1) then {
					_distNotOkTime = diag_tickTime;
					[localize "str_trans_far_destination",-3.5] call BRPVP_hint;
				};
			};
		};
		_cnt isEqualTo 0 || !isNull BRPVP_uberAttackPlayerTarget || player distance _posOriginal > 0.25 || !(player call BRPVP_pAlive)
	};
	BRPVP_uberAttackPlayerSelectPosition = false;
	["",0,0,1,0,0,19472] call BRPVP_fnc_dynamicText;
	if (_cnt isEqualTo 0 || isNull BRPVP_uberAttackPlayerTarget || player distance _posOriginal > 0.25 || !(player call BRPVP_pAlive)) then {
		"erro" call BRPVP_playSound;
		["BRPVP_uberAttack",1] call BRPVP_sitAddItem;
		[player,objNull] call BRPVP_uberAttackAddPlayerCancel;
		BRPVP_uberAttackUsing = false;
	} else {
		private _usingBino = {currentWeapon player isKindOf [_x,configFile >> "CfgWeapons"]} count ["Binocular","RangeFinder","Laserdesignator"] > 0;
		if (_usingBino) then {
			private _wepsToUse = [primaryWeapon player,handgunWeapon player];
			if (_wepsToUse isEqualTo ["",""]) then {
				player action ["SwitchWeapon",player,player,100];
			} else {
				{
					if (_x isNotEqualTo "") exitWith {
						private _ok = player selectWeapon [_x,_x,"FullAuto"];
						if (!isNil "_ok" && {!_ok}) then {player selectWeapon _x;};
					};
				} forEach _wepsToUse;
			};
		};
		[player,BRPVP_uberAttackPlayerTarget,_error] call BRPVP_doUberAttackPlayer;
	};
};
BRPVP_moveBombJetPackPlayer = {
	params ["_player","_tgt","_playerP","_tgtP","_init","_dist","_tm","_isS","_ctn","_sizeOf","_sounder","_maxFix","_percFix"];
	private _setup = 1;
	if (diag_tickTime-_init >= _setup) then {
		if !(_player call BRPVP_pAlive) then {
			true
		} else {
			private _initS = _player getVariable "brpvp_init_jet_sound";
			if (diag_tickTime-_initS >= 6.25) then {
				_player setVariable ["brpvp_init_jet_sound",diag_tickTime];
				[_sounder,["uber_pack",2000]] remoteExecCall ["say3D",BRPVP_allNoServer];
			};
			private _dtt = diag_tickTime-_setup;
			private _pPlayerNow = getPosASL _player;
			private _pTgtNow = if (isNull _tgt) then {
				_player getVariable ["brpvp_ltgt",_tgtP vectorAdd _ctn]
			} else {
				_player setVariable ["brpvp_ltgt",getPosASL _tgt vectorAdd _ctn];
				getPosASL _tgt vectorAdd _ctn
			};
			private _elapsed = (_dtt-_init) min _tm;
			private _itv = (_elapsed/_tm)^1.5;
			private _maxMag = _maxFix min vectorMagnitude (_pTgtNow vectorDiff (_tgtP vectorAdd _ctn) vectorMultiply _percFix);
			private _tgtFix = vectorNormalized (_pTgtNow vectorDiff (_tgtP vectorAdd _ctn)) vectorMultiply _maxMag;
			private _tgtFixed = (_tgtP vectorAdd _ctn) vectorAdd _tgtFix;
			private _jPos = (_playerP vectorMultiply (1-_itv)) vectorAdd (_tgtFixed vectorMultiply _itv);
			private _jAGL = ASLToAGL _jPos;
			if (_jAGL select 2 < 0) then {_jAGL = (_jAGL select [0,2])+[0];};
			_jAGL = _jAGL vectorAdd [0,0,(-2*abs(_itv-0.5)+1)^0.75*50];
			private _hFix = (_jAGL select 2) max 0;
			if (_hFix > 50) then {_hFix = 50+sqrt(_hFix-50);};
			_jPos set [2,_hFix];
			_jPos = AGLToASL _jPos;
			private _toRun = _jPos vectorDiff _pPlayerNow;
			private _le = _player getVariable "brpvp_jet_attack_error";
			private _en = vectorMagnitude _toRun;
			private _frameVec = if (_le isEqualTo 0) then {_toRun} else {_toRun vectorMultiply (_en^2/_le)};
			_player setVariable ["brpvp_jet_attack_error",_en];
			_player setVelocity _frameVec;
			if (_elapsed >= _tm-2.2) then {
				private _uAlarmOk = _player getVariable "brpvp_jetat_alarm_ok";
				if (!_uAlarmOk) then {
					[_player,["upack_alarm",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
					_player setVariable ["brpvp_jetat_alarm_ok",true];
				};
			};
			_dtt-_init > 1.2*_tm || _player distance ASLToAGL _tgtFixed < _sizeOf+1
		};
	} else {
		!(_player call BRPVP_pAlive)
	};
};
BRPVP_doUberAttackPlayer = {
	params ["_player","_tgt","_err"];
	if (stance _player isEqualTo "PRONE") then {[_player,""] remoteExecCall ["switchMove",0];};
	_player setVariable ["brpvp_jet_attack_error",0];
	_player setVariable ["brpvp_init_jet_sound",0];
	_player setVariable ["brpvp_jetat_alarm_ok",false];
	_player setVariable ["brpvp_no_possession",true,true];
	[_player,_player getVariable "brpvp_uber_attack_tank"] remoteExec ["BRPVP_jetAttackSmokePlayer",BRPVP_allNoServer];
	private _isPlayer = if (_tgt isKindOf "CaManBase") then {_tgt call BRPVP_isPlayerC} else {if (_tgt call BRPVP_isMotorized) then {(crew _tgt select {_x call BRPVP_isPlayerC}) isNotEqualTo []} else {false};};
	private _isS = _player getVariable "brpvp_ua_iss";
	private _div = (if (_isS) then {17.5} else {25})*(if (_isPlayer) then {1.25} else {1.75});
	private _maxFix = if (_isPlayer) then {60} else {150};
	private _percFix = if (_isPlayer) then {0.6} else {0.8};
	private _errQ = _err/sqrt(2);
	private _ctn = selectRandom [[_err,0,0],[-_err,0,0],[0,_err,0],[0,-_err,0],[_errQ,_errQ,0],[-_errQ,_errQ,0],[_errQ,-_errQ,0],[-_errQ,-_errQ,0]];
	private _sounder = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],10,"CAN_COLLIDE"];
	_sounder attachTo [player,[0,0,1.25]];
	[_sounder,["uber_pack_init",2000]] remoteExecCall ["say3D",BRPVP_allNoServer];
	BRPVP_jetBombDoPlayer pushBack [_player,_tgt,getPosASL _player,getPosASL _tgt,diag_tickTime,_tgt distance _player,(_tgt distance _player)/_div,_isS,_ctn,(sizeOf typeOf _tgt)/2 max 2,_sounder,_maxFix,_percFix];
};
BRPVP_uberAttackAddPlayer = {
	private _player = _this;
	private _atT = attachedObjects player select {typeOf _x isEqualTo "Land_GasTank_01_khaki_F"};
	private _tank = if (_atT isEqualTo []) then {"Land_GasTank_01_khaki_F" createVehicle [0,0,0]} else {_atT select 0};
	_tank attachTo [_player,[0,-0.325,-0.15],"spine3",true];
	_tank setVectorUp [0,-0.125,-1];
	_player setVariable ["brpvp_uber_attack_tank",_tank,true];
	private _kehId = _player addEventHandler ["Killed",{
		private _tank = (_this select 0) getVariable ["brpvp_uber_attack_tank",objNull];
		if (!isNull _tank) then {
			if (!isNull attachedTo _tank) then {detach _tank;};
			("APERSTripMine_Wire_Ammo" createVehicle (_tank modelToWorld [0,0,0])) setDamage 1;
			deleteVehicle _tank;
		};
		(_this select 0) removeEventHandler ["Killed",_thisEventHandler];
		(_this select 0) setVariable ["brpvp_uber_attack_killedeh",-1];
	}];
	_player setVariable ["brpvp_uber_attack_killedeh",_kehId];
};
BRPVP_uberAttackAddPlayerCancel = {
	params ["_player","_sounder"];
	if (!isNull _sounder) then {
		detach _sounder;
		_sounder setDamage 1;
		deleteVehicle _sounder;
	};
	private _tank = _player getVariable "brpvp_uber_attack_tank";
	private _kehId = _player getVariable "brpvp_uber_attack_killedeh";
	detach _tank;
	deleteVehicle _tank;
	_player removeEventHandler ["Killed",_kehId];
	BRPVP_uberAttackUsing = false;
};
BRPVP_uberAttackAddPlayerCancelNoTank = {
	params ["_player","_sounder"];
	if (!isNull _sounder) then {
		detach _sounder;
		_sounder setDamage 1;
		deleteVehicle _sounder;
	};
	private _kehId = _player getVariable "brpvp_uber_attack_killedeh";
	_player removeEventHandler ["Killed",_kehId];
	BRPVP_uberAttackUsing = false;
};
BRPVP_uberAttackMonitorPlayer = {
	private _jbdDel = [];
	{if (_x call BRPVP_moveBombJetPackPlayer) then {_jbdDel pushBack _forEachIndex;};} forEach BRPVP_jetBombDoPlayer;
	_jbdDel sort false;
	{
		private _params = BRPVP_jetBombDoPlayer deleteAt _x;
		private _player = _params select 0;
		private _sounder = _params select 10;
		if (_player call BRPVP_pAlive) then {
			private _tgt = _params select 1;
			private _isS = _params select 7;
			//private _sizeOf = _params select 9;
			if (_isS && _tgt distance _player < 20 && _tgt call BRPVP_pAlive) then {
				private _tank = _player getVariable "brpvp_uber_attack_tank";
				("APERSTripMine_Wire_Ammo" createVehicle (_tank modelToWorld [0,0,0])) setDamage 1;
				if (getPos _player select 2 < 7.5) then {["Sh_105mm_HEAT_MP",_player modelToWorld [0,0,0],200] call BRPVP_trowBomb;};
				detach _tank;
				deleteVehicle _tank;
				[_player,_sounder] call BRPVP_uberAttackAddPlayerCancelNoTank;
			} else {
				[_player,_sounder] spawn {
					params ["_player","_sounder"];
					private _init = diag_tickTime;
					private _delta = 0;
					waitUntil {
						_delta = diag_tickTime-_init;
						_player setVelocity [0,0,-7.5 max (0 min (velocity _player select 2)-(_delta min 7.5))];
						_delta > 10 || getPos _player select 2 < 1 || !(_player call BRPVP_pAlive)
					};
					if (_player call BRPVP_pAlive) then {
						_player setVariable ["brpvp_no_possession",false,true];
						[_player,_sounder] call BRPVP_uberAttackAddPlayerCancel;
					} else {
						[_player,_sounder] call BRPVP_uberAttackAddPlayerCancelNoTank;
					};
				};
			};
		} else {
			[_player,_sounder] call BRPVP_uberAttackAddPlayerCancelNoTank;
		};
		if (!isNull BRPVP_uberAttackPlayerTarget) then {
			private _toDel = BRPVP_uberAttackPlayerTarget getVariable ["brpvp_del_on_end",false];
			if (_toDel) then {deleteVehicle BRPVP_uberAttackPlayerTarget;};
		};
	} forEach _jbdDel;
};
/*
BRPVP_droneAccessFix = {
	if (!isNull findDisplay 160 || (isNull objectParent player && typeOf cursorObject in BRPVP_vantVehiclesClass && cursorObject distance player < 10)) then {
		if (rating player < 2000) then {player addRating (10000-rating player);};
	} else {
		if (rating player > -2000) then {player addRating (-10000-rating player);};
	};
};
*/
BRPVP_setPlayerDamaged = {
	BRPVP_playerDamaged = true;
};
BRPVP_doScannerArrowSpectator = {
	params ["_menuVar3","_sObj","_player","_myPlayerOrUAV"];
	private _arrow = createSimpleObject ["Sign_Arrow_Direction_Green_F",[0,0,0],true];
	private _isMan = _sObj isKindOf "CaManBase";
	waitUntil {
		private _err = (((_myPlayerOrUAV distance _sObj)-0.7*_menuVar3)/(0.5*_menuVar3)) max 0 min 2;
		private _pp = getPosASLVisual _myPlayerOrUAV;
		private _dir = getDirVisual _myPlayerOrUAV;
		private _onFoot = _myPlayerOrUAV isKindOf "CaManBase";
		private _front = if (_onFoot) then {if (isNull objectParent _myPlayerOrUAV) then {[(_pp select 0)+2.5*sin _dir,(_pp select 1)+2.5*cos _dir,(_pp select 2)+1]} else {BRPVP_posicaoFora};} else {[(_pp select 0)+5*sin _dir,(_pp select 1)+5*cos _dir,(_pp select 2)+1]};
		_arrow setPosASL _front;
		private _oPos = (getPosWorldVisual _sObj) vectorAdd (if (_isMan) then {[0,0,1]} else {[0,0,0]});
		private _vecDir = vectorNormalized (_oPos vectorDiff _front);
		private _vecUp = _vecDir vectorCrossProduct [0,0,1];
		private _eDir = [random (2*_err)-_err,random (2*_err)-_err,random (2*_err)-_err];
		private _eUp = [random (2*_err)-_err,random (2*_err)-_err,random (2*_err)-_err];
		_arrow setVectorDirAndUp [_vecDir vectorAdd _eDir,_vecUp vectorAdd _eUp];
		isNull (_myPlayerOrUAV getVariable ["brpvp_spect_scanner_on",objNull]) || !(_player call BRPVP_pAlive) || !alive _myPlayerOrUAV || isNull _sObj || !BRPVP_spectateOn
	};
	deleteVehicle _arrow;
};
BRPVP_checkForRaidState = {
	private _recentRaidAction = false;
	if (BRPVP_raidNoConstructionOnBaseIfRaidStarted && !BRPVP_vePlayers) then {
		private _flags = [];
		{
			private _rad = _x getVariable ["brpvp_flag_radius",0];
			private _dist = _x distance2D player;
			if (_dist <= _rad) then {_flags pushBack _x;};
		} forEach nearestObjects [player,["FlagCarrier"],200,true];
		{
			private _lra = _x getVariable ["brpvp_last_intrusion",-BRPVP_raidNoConstructionOnBaseIfRaidStartedTime];
			if (serverTime-_lra < BRPVP_raidNoConstructionOnBaseIfRaidStartedTime) exitWith {_recentRaidAction = true;};
		} forEach _flags;
	};
	_recentRaidAction || !([player,0] call BRPVP_insideFlagWithAccessExtraRadius)
};
BRPVP_waterWalkRemoteObjs = [];
BRPVP_waterWalkRemote = {
	if (_this getVariable ["brpvp_constant_run_on",false] && !(_this in BRPVP_waterWalkRemoteObjs)) then {
		BRPVP_waterWalkRemoteObjs pushBack _this;
		_this spawn {
			private _player = _this;
			private _onWaterLast = false;
			private _nearWaterLast = false;
			private _emitter = objNull;
			waitUntil {
				private _agl = ASLToAGL getPosASL _player;
				private _atl = ASLToATL getPosASL _player;
				private _onWaterNow = abs ((_agl select 2)-(_atl select 2)) > 0.01;
				private _h = _agl select 2;
				private _nearWaterNow = _onWaterNow && _h < 0.5;
				if (!_onWaterLast && _onWaterNow) then {
					_emitter = "#particlesource" createVehicleLocal ASLToAGL getPosASL _player;
					_emitter setPosATL [0,0,0];
					_emitter setParticleClass "WaterSplash";
					_emitter setDropInterval 0.025;
				};
				if (_onWaterLast && !_onWaterNow) then {deleteVehicle _emitter;};
				if (!_nearWaterLast && _nearWaterNow) then {_emitter attachTo [_player,_player worldToModel ASLToAGL getPosASL _player];};
				if (_nearWaterLast && !_nearWaterNow) then {detach _emitter;_emitter setPosATL [0,0,0];};
				_nearWaterLast = _nearWaterNow;
				_onWaterLast = _onWaterNow;
				!(_player getVariable ["brpvp_constant_run_on",false])
			};
			BRPVP_waterWalkRemoteObjs = BRPVP_waterWalkRemoteObjs-[_player,objNull];
			_emitter spawn {
				_this setDropInterval 1000;
				uiSleep 3;
				detach _this;
				uiSleep 0.001;
				deleteVehicle _this;
			};
		};
	};
};
BRPVP_waterWalk = {
	BRPVP_srunBeachDamage = false;
	player setVariable ["brpvp_constant_run_on",true,true];
	private _onWaterLast = false;
	private _nearWaterLast = false;
	private _wVelMag = 0;
	private _emitter = objNull;
	private _sounder1 = objNull;
	private _sounder2 = objNull;
	private _initS1 = -100;
	private _initS2 = -100;
	private _initAjVel = diag_tickTime;
	private _pl = (call BRPVP_playersList)-[player];
	if (_pl isNotEqualTo []) then {player remoteExecCall ["BRPVP_waterWalkRemote",_pl];};
	waitUntil {
		private _agl = ASLToAGL getPosASL player;
		private _atl = ASLToATL getPosASL player;
		private _onWaterNow = abs ((_agl select 2)-(_atl select 2)) > 0.01;
		private _angle = getDir player;
		private _h = _agl select 2;
		private _nearWaterNow = _onWaterNow && _h < 0.5;
		if (!_onWaterLast && _onWaterNow) then {
			if (_agl select 2 < 0.25) then {
				if (_agl select 2 < 0) then {
					player setPosASL AGLToASL [_agl select 0,_agl select 1,0.25];
					[player,"amovpercmevasnonwnondf"] remoteExecCall ["switchMove",0];
				} else {
					player setVelocity [0,0,3];
				};
			};
			_wVelMag = vectorMagnitude ((velocity player select [0,2])+[0]);
			_emitter = "#particlesource" createVehicleLocal ASLToAGL getPosASL player;
			_emitter setPosATL [0,0,0];
			_emitter setParticleClass "WaterSplash";
			_emitter setDropInterval 0.025;
		};
		if (_onWaterLast && !_onWaterNow) then {{deleteVehicle _x;} forEach (_emitter nearObjects 0);};
		if (_onWaterNow) then {
			if (_h < 0.25) then {
				private _vz = (0.25-_h)*2;
				private _dir = getDir player;
				private _wVelMagAj = _wVelMag+(((diag_tickTime-_initAjVel) min 5)/5)*((26-_wVelMag) max 0);
				player setVelocity [_wVelMagAj*sin _dir,_wVelMagAj*cos _dir,0];
			};
		};
		if (!_nearWaterLast && _nearWaterNow) then {
			_sounder1 = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],100,"NONE"];
			_sounder1 attachTo [player,[0,0,0.75]];
			_sounder2 = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],100,"NONE"];
			_sounder2 attachTo [player,[0,0,1.25]];
			_emitter attachTo [player,player worldToModel ASLToAGL getPosASL player];
			_initS1 = -100;
			_initS2 = -100;
			BRPVP_isJesusRun = true;
		};
		if (_nearWaterLast && !_nearWaterNow) then {
			detach _sounder1;
			deleteVehicle _sounder1;
			detach _sounder2;
			deleteVehicle _sounder2;
			[player,["water_sound_off",300]] remoteExecCall ["say3D",BRPVP_allNoServer];
			detach _emitter;
			_emitter setPosATL [0,0,0];
			BRPVP_isJesusRun = false;
		};
		if (_nearWaterNow) then {
			if (diag_tickTime-_initS1 > 2.3) then {
				_initS1 = diag_tickTime;
				[_sounder1,["wet_walk",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
			};
			if (diag_tickTime-_initS2 > 9) then {
				_initS2 = diag_tickTime;
				[_sounder2,["water_sound",300]] remoteExecCall ["say3D",BRPVP_allNoServer];
			};
		};
		_nearWaterLast = _nearWaterNow;
		_onWaterLast = _onWaterNow;
		!BRPVP_constantRunOn
	};
	player setVariable ["brpvp_constant_run_on",false,true];
	deleteVehicle _sounder1;
	deleteVehicle _sounder2;
	if (BRPVP_isJesusRun) then {[player,["water_sound_off",300]] remoteExecCall ["say3D",BRPVP_allNoServer];};
	BRPVP_isJesusRun = false;
	[_emitter] spawn {
		params ["_emitter"];
		_emitter setDropInterval 1000;
		uiSleep 3;
		detach _emitter;
		uiSleep 0.001;
		{deleteVehicle _x;} forEach (_emitter nearObjects 0);
	};
	0 spawn {
		uiSleep 3;
		if (!BRPVP_constantRunOn) then {BRPVP_srunBeachDamage = true;};
	};
};
/*
BRPVP_openVehicleInventory = {
	player action ["Gear",_this];
};
BRPVP_getInVehicle = {
	player moveInAny _this;
};
*/
BRPVP_possRemovePlayerCaptive = {
	call _this;
	if !(call BRPVP_playerCaptiveState) then {player setCaptive false;};
};
BRPVP_playerCaptiveState = {
	BRPVP_safeZone || BRPVP_playerIsCaptive || BRPVP_possCaptive
};
BRPVP_uberAttackAddPlayer = {
	private _p = _this;
	private _tank = "Land_GasTank_01_khaki_F" createVehicle [0,0,0];
	_tank attachTo [_p,[0,-0.325,-0.15],"spine3",true];
	_tank setVectorUp [0,-0.125,-1];
	_p setVariable ["brpvp_uber_attack_tank",_tank,true];
	private _kehId = _p addEventHandler ["Killed",{
		private _tank = (_this select 0) getVariable ["brpvp_uber_attack_tank",objNull];
		if (!isNull _tank) then {
			if (!isNull attachedTo _tank) then {detach _tank;};
			("APERSTripMine_Wire_Ammo" createVehicle (_tank modelToWorld [0,0,0])) setDamage 1;
			deleteVehicle _tank;
		};
		(_this select 0) removeEventHandler ["Killed",_thisEventHandler];
		(_this select 0) setVariable ["brpvp_uber_attack_killedeh",-1];
	}];
	_p setVariable ["brpvp_uber_attack_killedeh",_kehId];
};
BRPVP_uberAttackRemovePlayer = {
	private _p = _this;
	private _kehId = _p getVariable ["brpvp_uber_attack_killedeh",-1];
	private _tank = _p getVariable ["brpvp_uber_attack_tank",objNull];
	if (!isNull _tank) then {detach _tank;deleteVehicle _tank;};
	if (_kehId isNotEqualTo -1) then {_p removeEventHandler ["Killed",_kehId];};
};
BRPVP_changeSoulCodeAskerPossessionBack = {
	params ["_pD","_loadoutMe","_loadoutPd"];
	//BLACK SCREEN
	"revive_thunder" call BRPVP_playSound;
	9837 cutText ["","BLACK IN",2.5];
	if (_pD call BRPVP_isPlayerC) then {
		"revive_thunder" remoteExecCall ["playSound",_pD];
		[9837,["","BLACK IN",2.5]] remoteExecCall ["cutText",_pD];
	};
	//DATA
	_pdveh = objectParent player;
	_meveh = objectParent _pD;
	_pdnp = getPosASL player;
	_menp = getPosASL _pD;
	_pdani = animationState player;
	_meani = animationState _pD;
	_pddr = getDir player;
	_medr = getDir _pD;
	//MOVE OUT
	moveOut player;
	[_pD] allowGetIn false;
	moveOut _pD;
	waitUntil {isNull objectParent player && isNull objectParent _pD};
	//CHANGE 1
	_pD setUnitLoadout _loadoutMe;
	if (isNull _pdveh) then {
		_pD setPosASL _pdnp;
		[_pD,_pdani] remoteExecCall ["switchMove",0];
		[_pD,_pddr] remoteExecCall ["setDir",0];
		_pD setPosASL _pdnp;
	} else {
		[_pD] allowGetIn true;
		_pD moveInAny _pdveh;
		[_pdveh,false] remoteExecCall ["lock",_pdveh];
		_pdveh setVariable ["brpvp_no_possession",false,true];
	};
	//CHANGE 2
	player setUnitLoadout _loadoutPd;
	if (isNull _meveh) then {
		player setPosASL _menp;
		[player,_meani] remoteExecCall ["switchMove",0];
		player setDir _medr;
		player setPosASL _menp;
	} else {
		{_x remoteExecCall ["moveOut",_x];} forEach (crew _meveh select {side _x isNotEqualTo opfor});
		player moveInAny _meveh;
	};
};
BRPVP_changeSoulCodeAskerPossession = {
	params ["_pD","_loadoutMe","_loadoutPd"];
	//DATA
	_pdveh = objectParent player;
	_meveh = objectParent _pD;
	_pdnp = getPosASL player;
	_menp = getPosASL _pD;
	_pdani = animationState player;
	_meani = animationState _pD;
	_pddr = getDir player;
	_medr = getDir _pD;
	//MOVE OUT
	moveOut player;
	[_pD] allowGetIn false;
	moveOut _pD;
	waitUntil {isNull objectParent player && isNull objectParent _pD};
	//CHANGE 1
	_pD setUnitLoadout _loadoutMe;
	if (isNull _pdveh) then {
		_pD setPosASL _pdnp;
		[_pD,_pdani] remoteExecCall ["switchMove",0];
		[_pD,_pddr] remoteExecCall ["setDir",0];
		_pD setPosASL _pdnp;
	} else {
		[_pD] allowGetIn true;
		_pD moveInAny _pdveh;
	};
	//CHANGE 2
	player setUnitLoadout _loadoutPd;
	if (isNull _meveh) then {
		player setPosASL _menp;
		[player,_meani] remoteExecCall ["switchMove",0];
		player setDir _medr;
		player switchCamera "INTERNAL";
	} else {
		BRPVP_possessionVeh = _meveh;
		_meveh setVariable ["brpvp_no_possession",true,true];
		{_x remoteExecCall ["moveOut",_x];} forEach (crew _meveh select {side _x isNotEqualTo opfor});
		player moveInAny _meveh;
		[_meveh,true] remoteExecCall ["lock",_meveh];
	};
};
BRPVP_changeSoulCodeInviterPossession = {
	private _sounder = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],100,"NONE"];
	_sounder attachTo [player,[0,0,0]];
	[_sounder,["possession",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
	private _init = diag_tickTime;
	waitUntil {_this getVariable ["brpvp_pposs_status",-1] > -1};
	if (_this getVariable ["brpvp_pposs_status",-1] isEqualTo 0) then {
		_this setVariable ["brpvp_pposs_status",-1];
		deleteVehicle _sounder;
	};
	if (_this getVariable ["brpvp_pposs_status",-1] isEqualTo 1) then {
		BRPVP_possOtherPlayer = true;
		_this setVariable ["brpvp_pposs_status",-1];
		9837 cutText ["","BLACK FADED",100];
		uiSleep 0.25;
		9837 cutText ["","BLACK IN",1];
		uiSleep 5;
		deleteVehicle _sounder;
	};
};
BRPVP_possOtherPlayerSet = {BRPVP_possOtherPlayer = _this;};
BRPVP_possPlayerRevert = {
	private _controled = _this select 3;
	private _pAlive = player call BRPVP_pAlive;
	if (_pAlive && BRPVP_possBadAction > -1) then {
		private _totalWait = 30;
		private _remain = _totalWait-(time-BRPVP_possBadAction);
		while {_remain > 0} do {
			if (round _remain isEqualto 0) exitWith {};
			[format ["<img shadow='0' size='1.75' image='"+BRPVP_imagePrefix+"BRP_imagens\access_clock.paa'/><br /><t size='1'>"+localize "str_poss_slow_back"+"</t>",round _remain],0,0.3,1,0,0,47035] call BRPVP_fnc_dynamicText;
			private _init = diag_tickTime;
			waitUntil {diag_tickTime-_init >= 1 || BRPVP_possFinalType > -1};
			if (BRPVP_possFinalType > -1) exitWith {};
			_remain = _totalWait-(time-BRPVP_possBadAction);
		};
		["",0,0.3,1,0,0,47035] call BRPVP_fnc_dynamicText;
	};
	if (BRPVP_possFinalType > -1) exitWith {};
	player removeAction BRPVP_possActionId;
	BRPVP_possActionId = -1;
	[_controled,getUnitLoadOut player,getUnitLoadOut _controled] call BRPVP_changeSoulCodeAskerPossessionBack;
	BRPVP_possOtherPlayer = false;
	player setVariable ["brpvp_possessing_other",false];
	player setVariable ["brpvp_no_extra_safe",false];
	player setVariable ["brpvp_no_custom_eject",false];
	player setVariable ["brpvp_no_possession",false,true];
	player setVariable ["brpvp_my_possessed",objNull,2];
	_controled setVariable ["brpvp_no_possession",false,true];
	if (!isNull BRPVP_possessionVeh) then {[BRPVP_possessionVeh,false] remoteExecCall ["lock",BRPVP_possessionVeh];};
	[player,_controled] call BRPVP_possSetUberTankExchange;
	if (_controled call BRPVP_isPlayerC) then {
		false remoteExecCall ["BRPVP_possOtherPlayerSet",_controled];
	} else {
		player setVariable ["brpvp_possessed",-1,2];
		BRPVP_possCaptive = false;
		if !(call BRPVP_playerCaptiveState) then {player setCaptive false;};
		[_controled,(-rating _controled)] remoteExecCall ["addRating",_controled];
		[_controled,"ALL"] remoteExecCall ["enableAI",_controled];
	};
	BRPVP_possFinalType = 1;
};
BRPVP_jetAttackSmokePlayer = {
	params ["_player","_tank"];
	private _array = [0,0,0,0,0];
	waitUntil {
		if (_tank distance BRPVP_myCenter < viewDistance) then {
			private _vm = vectorMagnitude velocity _tank;
			private _sum = 0;
			_array pushBack _vm;
			_array deleteAt 0;
			{_sum = _sum+_x;} count _array;
			_vm = _sum/5;
			private _m = if (isNull attachedTo _tank) then {1} else {(_vm/5) min 1};
			drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,1.2/diag_fps,[0,0,0.3+0.2*_m],[0,0,5],-10+random 20,0.005,0.003925,0.1,[0.25+0.5*_m,0.25+0.5*_m],[[0.2,0.2,0.2,0.25+_m*0.5]],[1],0.01,0.5,"","",_tank];
			drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,1.2/diag_fps,[0,0,0.3+0.2*_m],[0,0,5],-10+random 20,0.005,0.003925,0.1,[0.25+0.5*_m,0.25+0.5*_m],[[0.2,0.2,0.2,0.25+_m*0.5]],[1],0.01,0.5,"","",_tank];
		};
		isNull _tank
	};
};
BRPVP_jetAttackAlert = {
	"jattack_alarm" call BRPVP_playSound;
	["<img shadow='0' size='1.75' image='"+BRPVP_imagePrefix+"BRP_imagens\jetpack_alert.paa'/><br /><t size='0.6'>Uber Attack!</t>",0,0.25,2,0,0,93245] call BRPVP_fnc_dynamicText;
};
BRPVP_jetAttackSmoke = {
	params ["_ai","_tank"];
	private _array = [0,0,0,0,0];
	waitUntil {
		if (_tank distance BRPVP_myCenter < viewDistance) then {
			private _vm = vectorMagnitude velocity _tank;
			private _sum = 0;
			_array pushBack _vm;
			_array deleteAt 0;
			{_sum = _sum+_x;} count _array;
			_vm = _sum/5;
			private _m = if (isNull attachedTo _tank) then {1} else {(_vm/5) min 1};
			drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,1.2/diag_fps,[0,0,0.3+0.2*_m],[0,0,5],-10+random 20,0.005,0.003925,0.1,[0.25+0.5*_m,0.25+0.5*_m],[[0.2,0.2,0.2,0.25+_m*0.5]],[1],0.01,0.5,"","",_tank];
			drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,1.2/diag_fps,[0,0,0.3+0.2*_m],[0,0,5],-10+random 20,0.005,0.003925,0.1,[0.25+0.5*_m,0.25+0.5*_m],[[0.2,0.2,0.2,0.25+_m*0.5]],[1],0.01,0.5,"","",_tank];
		};
		isNull _tank || _ai getVariable "brpvp_uber_attack"
	};
};
BRPVP_frantaAllObjsAdd = {
	BRPVP_frantaAllObjs = BRPVP_frantaAllObjs-[objNull];
	BRPVP_frantaAllObjs pushBack _this;
};
BRPVP_specDoBus = {
	params ["_player","_pASL","_pDir","_bCnt","_bestWayPair","_bestWayMin","_tme","_vel","_dirOld","_timeSegSum","_moveSum"];
	private _agnt = createAgent [typeOf player,[0,0,0],[],100,"NONE"];
	player setVariable ["brpvp_bus_agnt",_agnt,[2,clientOwner]];
	_agnt disableAI "ALL";
	_agnt hideObject true;
	[_agnt,true] remoteExecCall ["hideObjectGlobal",2];
	_agnt setPosASL _pASL;
	_agnt setDir _pDir;
	{
		_x params ["_start","_end"];
		_start = _start+[1];
		_end = _end+[1];
		private _s2 = if (_forEachIndex+1 <= _bCnt-1) then {(_bestWayPair select (_forEachIndex+1) select 1)+[1]} else {_end vectorAdd (_end vectorDiff _start)};
		private _move = _end distance _start;
		private _timeSeg = _move/_vel;
		private _asl1 = AGLToASL _start;
		private _asl2 = AGLToASL _end;
		private _lis1 = lineIntersectsSurfaces [_asl1 vectorAdd [0,0,50],_asl1 vectorAdd [0,0,-5],_agnt,objNull];
		private _lis2 = lineIntersectsSurfaces [_asl2 vectorAdd [0,0,50],_asl2 vectorAdd [0,0,-5],_agnt,objNull];
		_asl1 = if (_lis1 isEqualTo [] || {str (_lis1 select 0 select 2) find ": bridge_" isEqualTo -1}) then {_asl1} else {(_lis1 select 0 select 0) vectorAdd [0,0,1]};
		_asl2 = if (_lis2 isEqualTo [] || {str (_lis2 select 0 select 2) find ": bridge_" isEqualTo -1}) then {_asl2} else {(_lis2 select 0 select 0) vectorAdd [0,0,1]};
		private _dirNew = [_end,_s2] call BIS_fnc_dirTo;
		private _delta = 0;
		private _init = diag_tickTime;
		private _vda = [sin _dirOld,cos _dirOld,0];
		private _vdd = [sin _dirNew,cos _dirNew,0];
		waitUntil {
			_delta = diag_tickTime-_init;
			private _perc = (_delta/_timeSeg) min 1;
			_agnt setPosASL ((_asl1 vectorMultiply (1-_perc)) vectorAdd (_asl2 vectorMultiply _perc));
			_agnt setVectorDir ((_vda vectorMultiply (1-_perc)) vectorAdd (_vdd vectorMultiply _perc));
			_delta >= _timeSeg;
		};
		_timeSegSum = _timeSegSum+_delta;
		_moveSum = _moveSum+_move;
		_remainDist = _bestWayMin-_moveSum;
		_remainTime = _tme-_timeSegSum;
		if (_remainDist > 0 && _remainTime > 0) then {
			_newVel = _remainDist/_remainTime;
			_vel = _newVel;
		};
		_dirOld = _dirNew;
		if (!BRPVP_spectateOn || !(_player getVariable "brpvp_on_bus")) exitWith {};
	} forEach _bestWayPair;
	deleteVehicle _agnt;
};
BRPVP_clientRealPing = {
	player setVariable ["brpvp_real_ping",(diag_tickTime-BRPVP_realPingInit)*1000];
	BRPVP_realPingInit = -1;
};
BRPVP_specReceiveVars = {
	params ["_meusAmigosObj","_pveFriends","_viewDist","_viewDistFly","_xpLastTotal","_specNascendoParaQuedas","_specXrayOn","_artyTargetPos","_playersMarksEnabled","_meuAllDead","_radioAreasInside"];
	BRPVP_specMeusAmigosObj = _meusAmigosObj;
	BRPVP_specPveFriends = _pveFriends;
	//VIEW DISTANCE
	if (!BRPVP_spectUseMyViewDistance && [_viewDist,_viewDistFly] isNotEqualTo [BRPVP_viewDist,BRPVP_viewDistFly]) then {
		BRPVP_viewDist = _viewDist;
		BRPVP_viewDistFly = _viewDistFly;
		BRPVP_viewDistState = 0;
	};
	//XP
	BRPVP_specXpLastTotal = _xpLastTotal;
	//SKY DIVE
	BRPVP_specNascendoParaQuedas = _specNascendoParaQuedas;
	//XRAY
	BRPVP_specXrayOn = _specXrayOn;
	//ARTY TARGET POS
	BRPVP_specArtyTargetPos = _artyTargetPos;
	//PLAYERS MARKS
	BRPVP_playersMarksEnabled = _playersMarksEnabled;
	//PLAYER DEAD BOXES
	BRPVP_meuAllDeadSpec = _meuAllDead;
	["geral"] call BRPVP_updateMapIconsRemove;
	["geral"] call BRPVP_updateMapIconsAdd;
	//RADIO EFFECT
	BRPVP_radioAreasInsideSpec = _radioAreasInside;
};
BRPVP_changeSoulCancelAsker = {
	if (!isNull _this) then {
		_this cameraEffect ["TERMINATE","BACK"];
		camDestroy _this;
		uiSleep 0.001;
		player switchCamera "INTERNAL";
	};
	player enableCollisionWith _pD;
	[_pD,player] remoteExecCall ["enableCollisionWith",_pD];
	player setUnconscious false;
	player switchMove "UnconsciousOutProne";
	player setVariable ["brpvp_specting",objNull,2];
	BRPVP_bodyChangeTrying = false;
};
BRPVP_changeSoulCancelInviter = {
	if (!isNull _this) then {
		_this cameraEffect ["TERMINATE","BACK"];
		camDestroy _this;
		uiSleep 0.001;
		player switchCamera "INTERNAL";
	};
	player enableCollisionWith _pD;
	[_pD,player] remoteExecCall ["enableCollisionWith",_pD];
	player setUnconscious false;
	player switchMove "UnconsciousOutProne";
	player setVariable ["brpvp_specting",objNull,2];
	BRPVP_bodyChangeInvited = false;
	BRPVP_bodyChangeAsker = objNull;
	BRPVP_bodyChangeAskerMid = -1;
};
BRPVP_changeSoulCodeInviter = {
	//VARS
	params ["_pD"];
	private _walked = 0;
	private _walkPos = [0,0,0];
	private _steps = 0;
	private _sTime = 0;
	private _notOk = false;
	private _notOkCode = {!(player call BRPVP_pAlive) || !(_pD call BRPVP_pAlive) || !isNull objectParent player || !isNull objectParent _pD || !(player getVariable ["sok",false]) || !(_pD getVariable ["sok",false]) || isNull player || isNull _pD};
	private _init = 0;
	private _velInit = 0;

	//ENABLE DESTINE AREA
	player setVariable ["brpvp_specting",_pD,2];

	//SET UNCONSCIOUS
	[player,["body_change_moan",350]] remoteExecCall ["say3D",BRPVP_allNoServer];
	player setUnconscious true;
	_init = diag_tickTime;
	waitUntil {
		_notOk = call _notOkCode;
		diag_tickTime-_init >= 2 || _notOk
	};
	if (_notOk) exitWith {objNull call BRPVP_changeSoulCancelInviter;};

	//TIME SPEED DIST AND POS
	private _pos1t = ASLToAGL eyePos player;
	private _pos3t = ASLToAGL eyePos _pD;
	private _pos1 = _pos1t vectorAdd [1,1,2.5];
	private _pos3 = _pos3t vectorAdd [-1,-1,2.5];
	private _vDist = _pos3 vectorDiff _pos1;
	private _vMag = vectorMagnitude _vDist;
	private _pos2 = _pos1 vectorAdd (_vDist vectorMultiply (((_vMag-750) max (0.75*_vMag))/_vMag));
	_pos2 set [2,(0.4*(_pos3 distance _pos1)) min 5000 max 500];
	private _dist1 = _pos2 distance _pos1;
	private _dist2 = _pos3 distance _pos2;
	private _speed = ((_dist1+_dist2)/10) max 350;
	private _time1 = _dist1/_speed;
	private _time2 = _dist2/_speed;
	private _tt = _time1+_time2;

	//LIGHT
	"revive_thunder" call BRPVP_playSound;
	cutText ["","WHITE IN",1];

	//INIT CAMERA
	showCinemaBorder false;
	private _cam = "camera" camCreate _pos1;
	_cam camSetTarget _pD;
	_cam cameraEffect ["INTERNAL","BACK"];

	//ASCEND
	_steps = round (_time1/0.2);
	_sTime = _time1/_steps;
	_vec = vectorNormalized (AGLToASL _pos2 vectorDiff AGLToASL _pos1);
	_walkPos = AGLToASL _pos1;
	_walked = 0;
	_velInit = ((_sTime/2)/_time1)*(_speed*2);
	_init = diag_tickTime;
	for "_i" from 1 to _steps do {
		private _vel = _velInit+((_i-1)/_steps)*(_speed*2);
		private _dv = _vec vectorMultiply (_vel*_sTime);
		_walked = _walked+vectorMagnitude _dv;
		_walkPos = _walkPos vectorAdd _dv;
		_cam camSetPos ASLToAGL _walkPos;
		_cam camCommit _sTime;
		waitUntil {
			_notOk = call _notOkCode;
			camCommitted _cam || _notOk
		};
		//systemChat str [_vel,_sTime,[_dist1,_walked],[_time1,diag_tickTime-_init]];
		if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelInviter;};
	};
	if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelInviter;};

	//LIGHT
	"revive_thunder" call BRPVP_playSound;
	cutText ["","WHITE IN",1.25];

	//DESCEND
	_steps = round (_time2/0.2);
	_sTime = _time2/_steps;
	_vec = vectorNormalized (AGLToASL _pos3 vectorDiff AGLToASL _pos2);
	_walkPos = AGLToASL _pos2;
	_walked = 0;
	_velInit = (_speed*2)-((_sTime/2)/_time2)*(_speed*2);
	_init = diag_tickTime;
	for "_i" from 1 to _steps do {
		private _vel = _velInit-((_i-1)/_steps)*(_speed*2);
		private _dv = _vec vectorMultiply (_vel*_sTime);
		_walked = _walked+vectorMagnitude _dv;
		_walkPos = _walkPos vectorAdd _dv;
		_cam camSetPos ASLToAGL _walkPos;
		_cam camCommit _sTime;
		waitUntil {
			_notOk = call _notOkCode;
			camCommitted _cam || _notOk
		};
		//systemChat str [_vel,_sTime,[_dist2,_walked],[_time2,diag_tickTime-_init]];
		if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelInviter;};
	};
	if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelInviter;};
	_cam camSetTarget objNull;

	//CONCLUDE
	_init = diag_tickTime;
	waitUntil {
		_notOk = call _notOkCode;
		(player getVariable "brpvp_bodyc_ok") || diag_tickTime-_init > 5 || _notOk
	};
	if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelInviter;};

	//LIGHT
	"revive_thunder" call BRPVP_playSound;
	cutText ["","WHITE IN",1.5];

	_cam call BRPVP_changeSoulCancelInviter;
	"body_change" call BRPVP_playSound;
};
BRPVP_changeSoulCodeAsker = {
	//VARS
	params ["_pD","_loadoutMe","_loadoutPd"];
	private _walked = 0;
	private _walkPos = [0,0,0];
	private _steps = 0;
	private _sTime = 0;
	private _notOk = false;
	private _notOkCode = {!(player call BRPVP_pAlive) || !(_pD call BRPVP_pAlive) || !isNull objectParent player || !isNull objectParent _pD || !(player getVariable ["sok",false]) || !(_pD getVariable ["sok",false]) || isNull player || isNull _pD};
	private _init = 0;
	private _velInit = 0;

	//ENABLE DESTINE AREA
	player setVariable ["brpvp_specting",_pD,2];

	//ASKER EXTRA: DISABLE COLLISION
	player disableCollisionWith _pD;
	[_pD,player] remoteExecCall ["disableCollisionWith",_pD];

	//SET UNCONSCIOUS
	[player,["body_change_moan",350]] remoteExecCall ["say3D",BRPVP_allNoServer];
	player setUnconscious true;
	_init = diag_tickTime;
	waitUntil {
		_notOk = call _notOkCode;
		diag_tickTime-_init >= 2 || _notOk
	};
	if (_notOk) exitWith {objNull call BRPVP_changeSoulCancelAsker;};

	//TIME SPEED DIST AND POS
	private _pos1t = ASLToAGL eyePos player;
	private _pos3t = ASLToAGL eyePos _pD;
	private _pos1 = _pos1t vectorAdd [1,1,2.5];
	private _pos3 = _pos3t vectorAdd [-1,-1,2.5];
	private _vDist = _pos3 vectorDiff _pos1;
	private _vMag = vectorMagnitude _vDist;
	private _pos2 = _pos1 vectorAdd (_vDist vectorMultiply (((_vMag-750) max (0.75*_vMag))/_vMag));
	_pos2 set [2,(0.4*(_pos3 distance _pos1)) min 5000 max 500];
	private _dist1 = _pos2 distance _pos1;
	private _dist2 = _pos3 distance _pos2;
	private _speed = ((_dist1+_dist2)/10) max 350;
	private _time1 = _dist1/_speed;
	private _time2 = _dist2/_speed;
	private _tt = _time1+_time2;

	//LIGHT
	"revive_thunder" call BRPVP_playSound;
	cutText ["","WHITE IN",1];

	//INIT CAMERA
	showCinemaBorder false;
	private _cam = "camera" camCreate _pos1;
	_cam camSetTarget _pD;
	_cam cameraEffect ["INTERNAL","BACK"];

	//ASCEND
	_steps = round (_time1/0.2);
	_sTime = _time1/_steps;
	_vec = vectorNormalized (AGLToASL _pos2 vectorDiff AGLToASL _pos1);
	_walkPos = AGLToASL _pos1;
	_walked = 0;
	_velInit = ((_sTime/2)/_time1)*(_speed*2);
	_init = diag_tickTime;
	for "_i" from 1 to _steps do {
		private _vel = _velInit+((_i-1)/_steps)*(_speed*2);
		private _dv = _vec vectorMultiply (_vel*_sTime);
		_walked = _walked+vectorMagnitude _dv;
		_walkPos = _walkPos vectorAdd _dv;
		_cam camSetPos ASLToAGL _walkPos;
		_cam camCommit _sTime;
		waitUntil {
			_notOk = call _notOkCode;
			camCommitted _cam || _notOk
		};
		//systemChat str [_vel,_sTime,[_dist1,_walked],[_time1,diag_tickTime-_init]];
		if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelAsker;};
	};
	if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelAsker;};

	//LIGHT
	"revive_thunder" call BRPVP_playSound;
	cutText ["","WHITE IN",1.25];

	//DESCEND
	_steps = round (_time2/0.2);
	_sTime = _time2/_steps;
	_vec = vectorNormalized (AGLToASL _pos3 vectorDiff AGLToASL _pos2);
	_walkPos = AGLToASL _pos2;
	_walked = 0;
	_velInit = (_speed*2)-((_sTime/2)/_time2)*(_speed*2);
	_init = diag_tickTime;
	for "_i" from 1 to _steps do {
		private _vel = _velInit-((_i-1)/_steps)*(_speed*2);
		private _dv = _vec vectorMultiply (_vel*_sTime);
		_walked = _walked+vectorMagnitude _dv;
		_walkPos = _walkPos vectorAdd _dv;
		_cam camSetPos ASLToAGL _walkPos;
		_cam camCommit _sTime;
		waitUntil {
			_notOk = call _notOkCode;
			camCommitted _cam || _notOk
		};
		//systemChat str [_vel,_sTime,[_dist2,_walked],[_time2,diag_tickTime-_init]];
		if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelAsker;};
	};
	if (_notOk) exitWith {_cam call BRPVP_changeSoulCancelAsker;};
	_cam camSetTarget objNull;

	//LIGHT
	uiSleep 1;
	"revive_thunder" call BRPVP_playSound;
	cutText ["","WHITE IN",1.5];

	//CONCLUDE
	[_pD,["brpvp_bodyc_ok",true]] remoteExecCall ["setVariable",_pD];
	uiSleep 0.001;
	isNil {
		_pdnp = getPosASL player;
		_menp = getPosASL _pD;
		_pdnv = [vectorDir player,vectorUp player];
		_menv = [vectorDir _pD,vectorUp _pD];

		player hideObject true;
		[_pD,true] remoteExecCall ["hideObject",_pD];

		_pD setUnitLoadout _loadoutMe;
		_pD setPosASL _pdnp;
		_pD setVectorDirAndUp _pdnv;

		player setUnitLoadout _loadoutPd;
		player setPosASL _menp;
		player setVectorDirAndUp _menv;

		player hideObject false;
		[_pD,false] remoteExecCall ["hideObject",_pD];
	};

	_cam call BRPVP_changeSoulCancelAsker;
	"body_change" call BRPVP_playSound;
};
BRPVP_askForBodyExchange = {
	params ["_aid","_player","_name"];
	if (!BRPVP_bodyChangeInvited && !BRPVP_bodyChangeTrying && !BRPVP_spectateOn) then {
		BRPVP_bodyChangeInvited = true;
		BRPVP_bodyChangeAsker = _player;
		BRPVP_bodyChangeAskerMid = _aid;
		player setVariable ["brpvp_bodyc_answer","waiting"];
		["<img shadow='0' size='4' color='#FFFFFF' image='"+BRPVP_imagePrefix+"BRP_imagens\body_change.paa'/><br/>"+format [localize "str_bodyc_player_asking",_name],-8] call BRPVP_hint;
		0 spawn {
			private _init = diag_tickTime;
			private _others = false;
			private _decided = false;
			waitUntil {
				private _askerOk = !isNull BRPVP_bodyChangeAsker && BRPVP_bodyChangeAsker call BRPVP_pAlive && BRPVP_bodyChangeAsker getVariable ["sok",false] && isNull objectParent BRPVP_bodyChangeAsker;
				private _meOk = !isNull player && player call BRPVP_pAlive && player getVariable ["sok",false] && isNull objectParent player;
				_others = diag_tickTime-_init > 8 || !_askerOk || !_meOk;
				_decided = (player getVariable ["brpvp_bodyc_answer","waiting"]) isEqualTo "ok";
				_decided || _others
			};
			if (_decided) then {
				player setVariable ["brpvp_bodyc_ok",false];
			} else {
				BRPVP_bodyChangeInvited = false;
				BRPVP_bodyChangeAsker = objNull;
				BRPVP_bodyChangeAskerMid = -1;
			};
		};
	} else {
		player setVariable ["brpvp_bodyc_answer","not_free",_aid];
	};	
};
BRPVP_specTakePutItem = {
	if (BRPVP_spectateOn) then {
		params ["_act","_img","_qt"];
		if (_act isEqualTo "take") then {
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\spec_gear.paa'/><br/><img shadow='0' size='1.6' image='"+BRPVP_imagePrefix+"BRP_imagens\take_eh.paa'/> <img shadow='0' size='1.6' image='"+_img+"'/><br/><t>"+_qt+"</t>",0,0.25,2,0,0,2985745] spawn BIS_fnc_dynamicText;
		} else {
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\spec_gear.paa'/><br/><img shadow='0' size='1.6' image='"+BRPVP_imagePrefix+"BRP_imagens\put_eh.paa'/> <img shadow='0' size='1.6' image='"+_img+"'/><br/><t>"+_qt+"</t>",0,0.25,2,0,0,2985745] spawn BIS_fnc_dynamicText;
		};
		"buttom_off" call BRPVP_playSound;
	};
};
BRPVP_specMapAnimeLast = [];
BRPVP_specMapAnime = {
	if (BRPVP_spectateOn) then {
		params ["_mouse","_anim"];
		if (!isNull (findDisplay 12 displayCtrl 51)) then {
			BRPVP_specMapMouseLast = _mouse;
			if (ctrlMapAnimDone (findDisplay 12 displayCtrl 51)) then {
				(findDisplay 12 displayCtrl 51) ctrlMapAnimAdd _anim;
				ctrlMapAnimCommit (findDisplay 12 displayCtrl 51);
				_this spawn {
					waitUntil {!isNull (findDisplay 12 displayCtrl 51) && {ctrlMapAnimDone (findDisplay 12 displayCtrl 51)}};
					if (!isNull (findDisplay 12 displayCtrl 51)) then {
						private _continue = BRPVP_specMapAnimeLast isNotEqualTo [] && BRPVP_specMapAnimeLast isNotEqualTo _this;
						if (_continue) then {BRPVP_specMapAnimeLast call BRPVP_specMapAnime;};
					};
				};
			} else {
				BRPVP_specMapAnimeLast = _this;
			};
		};
	};
};
BRPVP_specMapShow = {
	params ["_action","_mState","_mouse"];
	if (_action isEqualTo "open") then {
		openMap [true,true];
		(findDisplay 12 displayCtrl 51) ctrlMapAnimAdd _mState;
		ctrlMapAnimCommit (findDisplay 12 displayCtrl 51);
		BRPVP_specMapMouseLast = _mouse;
		BRPVP_specMapMouseMovement = _mouse;
	} else {
		(findDisplay 12 displayCtrl 51) ctrlMapAnimAdd _mState;
		ctrlMapAnimCommit (findDisplay 12 displayCtrl 51);
		private _mapPos = findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld [0.5,0.5];
		openMap [false,true];
		BRPVP_specMapMouseLast = _mapPos;
		BRPVP_specMapMouseMovement = _mapPos;
	};
};
BRPVP_specMenuShow = {
	BRPVP_specMenuShowTxt = _this;
	hintSilent parseText BRPVP_specMenuShowTxt;
	BRPVP_specMenuShowLast = diag_tickTime;
};
BRPVP_setSpectedDinaMsgsBack = {
	private _my = [];
	private _mia = [];
	{
		_x params ["_start","_tm","_maxTm","_msg"];
		private _remain = if (_tm >= 36000) then {_tm} else {_tm-(serverTime-_start)};
		if (_remain > 0) then {_my pushBack ((_msg select [0,3])+[_remain]+(_msg select [4,3]))};
	} forEach BRPVP_fnc_dynamicTextDataArray;
	{_mia pushBack (_x select 6);} forEach _my;
	{["",0,0,0,0,0,_x] spawn BIS_fnc_dynamicText;} forEach (BRPVP_setSpectedDinaMsgsIds-_mia);
	{
		private _msg = if (_x select 1 isEqualType 0) then {_x} else {(_x select [0,1])+((_x select [1,2]) apply {call _x})+(_x select [3,4])};
		_msg spawn BIS_fnc_dynamicText;
	} forEach _my;
	BRPVP_setSpectedDinaMsgsIds = [];
};
BRPVP_setSpectedDinaMsgs = {
	private _send = _this;
	private _sia = [];
	{_sia pushBack (_x select 6);} forEach _send;
	{["",0,0,0,0,0,_x] spawn BIS_fnc_dynamicText;} forEach (BRPVP_fnc_dynamicTextDataId-_sia);
	{
		private _msg = if (_x select 1 isEqualType 0) then {_x} else {(_x select [0,1])+((_x select [1,2]) apply {call _x})+(_x select [3,4])};
		_msg spawn BIS_fnc_dynamicText;
	} forEach _send;
	BRPVP_setSpectedDinaMsgsIds append _sia;
};
BRPVP_specRemovedInfrom = {
	BRPVP_specIRemovedYou = true;
	BRPVP_menuExtraLigado = false;
	hintSilent "";
};
BRPVP_changeSpectOnMe = {
	params ["_data","_action"];
	private _som = player getVariable ["brpvp_spected_by",[]];
	if (_action isEqualTo "add") then {
		_som pushBack _data;
		player setVariable ["brpvp_vault_perc",player getVariable "brpvp_vault_perc",_data select 0];
		BRPVP_specOnMeMachines pushBack (_data select 0);
		BRPVP_specOnMeMachinesNoMe pushBack (_data select 0);
		private _send = [];
		{
			_x params ["_start","_tm","_maxTm","_msg"];
			private _remain = if (_tm >= 36000) then {_tm} else {_tm-(serverTime-_start)};
			if (_remain > 0) then {_send pushBack ((_msg select [0,3])+[_remain]+(_msg select [4,3]))};
		} forEach BRPVP_fnc_dynamicTextDataArray;
		_send remoteExecCall ["BRPVP_setSpectedDinaMsgs",_data select 0];
		if (BRPVP_inventoryBoxes isNotEqualTo []) then {["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\spec_gear.paa'/>",0,0.25,36000,0,0,1983745] remoteExecCall ["BRPVP_fnc_dynamicTextSpec",_data select 0];};
		(_data select 0) call BRPVP_specInitMapOpenClose;
		if (BRPVP_artyMapOn) then {BRPVP_specAddArtyMap pushBack (_data select 0);};
		if (BRPVP_construindo) then {BRPVP_specAddBuilding pushBack (_data select 0);};
		call BRPVP_atualizaDebugMenu;
		
		//SPEC VARS TO SEND
		[BRPVP_meusAmigosObj,BRPVP_pveFriends,BRPVP_viewDist,BRPVP_viewDistFly,BRPVP_xpLastTotal,BRPVP_nascendoParaQuedas,BRPVP_xrayOn,BRPVP_artyTargetPos,BRPVP_playersMarksEnabled,BRPVP_meuAllDead,BRPVP_radioAreasInside] remoteExecCall ["BRPVP_specReceiveVars",_data select 0];
		player setVariable ["brpvp_ping",player getVariable "brpvp_ping",_data select 0];
		player setVariable ["brpvp_real_ping",player getVariable "real_brpvp_ping",_data select 0];
		
		//PERSONAL BUSH
		if (!isNull BRPVP_personalBush) then {
			if (BRPVP_personalBushFakeOn) then {
				[0,["missionintel1","PLAIN"]] remoteExecCall ["cutRsc",_data select 0];
				[BRPVP_personalBush,true] remoteExecCall ["hideObject",_data select 0];
			};
		};

		//SEND CURRENT VISION MODE
		player setVariable ["brpvp_vision_mode",player getVariable "brpvp_vision_mode",_data select 0];

		//BUS TRAVEL HAPPENING
		if (!isNil "BRPVP_busReData") then {BRPVP_busReData remoteExec ["BRPVP_specDoBus",_data select 0];};

		//SCANNER HAPPENING
		private _sObj = player getVariable ["brpvp_spect_scanner_on",objNull];
		if (!isNull _sObj) then {
			player setVariable ["brpvp_spect_scanner_on",_sObj,_data select 0];
			private _params = [
				player getVariable ["brpvp_scanner_menu_var_3",300],
				_sObj,
				player,
				player getVariable ["brpvp_spect_scanner_my_drone",BRPVP_myPlayerOrUAV]
			];
			_params remoteExec ["BRPVP_doScannerArrowSpectator",_data select 0];
		};

		//SEND SMART TV CHANNELS
		private _scbm = BRPVP_secCamBbsMy apply {[_x select 0,getPosASL (_x select 1),vectorDir (_x select 1),vectorUp (_x select 1),_x select 2]};
		private _mlsc = player getVariable ["brpvp_my_looking_seccam",objNull];
		[_scbm,_mlsc,BRPVP_secCamCurrentCamKey] remoteExecCall ["BRPVP_setSpecSecCams",_data select 0];

		//UNHIDE PERSONAL SMART TV
		private _stv = player getVariable ["brpvp_personal_stv",objNull];
		if (!isNull _stv) then {[_stv,false] remoteExecCall ["BRPVP_revealOrHideSmartTv",_data select 0];};
		
		//SEND NEAR PLAYERS ICONS
		[BRPVP_nearIdentifiedPlayers,BRPVP_newersDiscovered] remoteExecCall ["BRPVP_specReceiveNIP",_data select 0];

		//SEND SIXTH SENS VARS
		private _sixthSenseCfgNow = [BRPVP_sixthSensePower,BRPVP_sixthSensePowerPlayer,BRPVP_sixthSenseOn,BRPVP_sixthSenseSeePlayer,BRPVP_sixthSenseRange];
		_sixthSenseCfgNow remoteExecCall ["BRPVP_sixthSenseReceiveSpecVars",_data select 0];

		//SEND LEVEL 2 BIG FRANTAS
		[BRPVP_fradeBigOnRad,[]] remoteExecCall ["BRPVP_bigFrantaSpectatorCode",_data select 0];
		
		//SEND RED TURRETS ON ME
		[BRPVP_allTurretsOnMeRed,BRPVP_allTurretsOnMeRedSee] remoteExecCall ["BRPVP_sendTurretsOnSpected",_data select 0];
	} else {
		_som = _som-[_data];
		BRPVP_specOnMeMachines = BRPVP_specOnMeMachines-[_data select 0];
		BRPVP_specOnMeMachinesNoMe = BRPVP_specOnMeMachinesNoMe-[_data select 0];
		remoteExecCall ["BRPVP_specRemovedInfrom",_data select 0];

		//HIDE PERSONAL SMART TV
		private _stv = player getVariable ["brpvp_personal_stv",objNull];
		if (!isNull _stv) then {[_stv,true] remoteExecCall ["BRPVP_revealOrHideSmartTv",_data select 0];};
	};
	player setVariable ["brpvp_spected_by",_som];
};
BRPVP_aiAttackBaseMessage = {
	"c4_destroy" call BRPVP_playSound;
	["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\"+_this+"'/><br/>"+localize "str_ai_attack_base_begin",0,0,5,1,0,82336] call BRPVP_fnc_dynamicText;
};
BRPVP_ppathReset = {
	BRPVP_ppathPath = [];
	BRPVP_ppathRedundant = [];
	BRPVP_ppathRedundantCount = 0;
	BRPVP_ppathLastCountMsg = 0;
};
BRPVP_returnBot = {
	if (isNull _this) then {
		objNull
	} else {
		if (_this isKindOf "CaManBase" && {(_this getVariable ["id_bd",-1]) isEqualTo -1 && alive _this && !(typeOf _this in ["B_Soldier_VR_F","O_Soldier_VR_F","C_Soldier_VR_F"]) && simulationEnabled _this}) then {
			_this
		} else {
			private _driver = driver _this;
			_driver = if (isNull _driver) then {gunner _this} else {_driver};
			if (_driver isKindOf "CaManBase" && {(_driver getVariable ["id_bd",-1]) isEqualTo -1 && alive _driver && !(typeOf _driver in ["B_Soldier_VR_F","O_Soldier_VR_F","C_Soldier_VR_F"]) && simulationEnabled _driver}) then {_driver} else {objNull};
		};
	};
};
BRPVP_setTurretTypesBot = {
	_veiculo = _this;
	if (isNull _veiculo) then {
		_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 0;
		_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 0;
		_actualAutoTurrets = BRPVP_autoTurretOnMan;
	} else {
		if (_veiculo isKindOf "LandVehicle") then {
			_armor = getNumber (configFile >> "CfgVehicles" >> typeOf _veiculo >> "armor");
			_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 1;
			_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 1;
			_actualAutoTurrets = BRPVP_autoTurretOnLandVehicle;
			if (_armor >= 100 && _armor <= 200) then {
				if (!(_veiculo getVariable ["brpvp_to_turret",false]) && _veiculo isKindOf "MRAP_03_base_F") then {_veiculo setVariable ["brpvp_to_turret",true,true];};
			} else {
				if !(_veiculo getVariable ["brpvp_to_turret",false]) then {_veiculo setVariable ["brpvp_to_turret",true,true];};
				if !(_veiculo getVariable ["brpvp_use_texplode",false]) then {_veiculo setVariable ["brpvp_use_texplode",true,true];};
			};
		} else {
			if (_veiculo isKindOf "Plane") then {
				_actualAutoTurrets = BRPVP_autoTurretOnAirVehicle;
				_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 3;
				_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 3;
			} else {
				if (_veiculo isKindOf "Air" || _veiculo isKindOf "Ship") then {
					_actualAutoTurrets = BRPVP_autoTurretOnAirVehicle;
					_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 2;
					_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 2;
				};
			};
		};
	};
};
BRPVP_upackSmoke = {
	private _tank = _this;
	waitUntil {
		if (_tank distance BRPVP_myCenter < viewDistance) then {
			private _vm = vectorMagnitude velocity _tank;
			private _m = if (isNull attachedTo _tank) then {1} else {(_vm/100) min 1};
			drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,1.2/diag_fps,[0,0,0.3+0.2*_m],[0,0,5],-10+random 20,0.005,0.003925,0.1,[0.25+0.5*_m,0.25+0.5*_m],[[0.2,0.2,0.2,0.25+_m*0.5]],[1],0.01,0.5,"","",_tank];
			drop [["\A3\Data_F\ParticleEffects\Universal\Universal",16,7,1],"","Billboard",1,1.2/diag_fps,[0,0,0.3+0.2*_m],[0,0,5],-10+random 20,0.005,0.003925,0.1,[0.25+0.5*_m,0.25+0.5*_m],[[0.2,0.2,0.2,0.25+_m*0.5]],[1],0.01,0.5,"","",_tank];
		};
		isNull _tank;
	};
};
BRPVP_vehKillXpMessage = {
	if (_this <= BRPVP_vehLvlMaxKills) then {
		["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\veh_xp.paa'/><br/>LVL "+str _this,0,0,2,0,0,53463] call BRPVP_fnc_dynamicText;
	} else {
		["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\veh_xp.paa'/><br/>LVL "+str _this+"(MAX: "+str BRPVP_vehLvlMaxKills+")",0,0,2,0,0,53463] call BRPVP_fnc_dynamicText;
	};
	"veh_xp" call BRPVP_playSound;
};
BRPVP_cantHurtFromBaseMsgLast = 0;
BRPVP_cantHurtFromBaseMsg = {
	params ["_inBase","_attacker"];
	if (diag_tickTime-BRPVP_cantHurtFromBaseMsgLast > 1.5) then {
		BRPVP_cantHurtFromBaseMsgLast = diag_tickTime;
		"erro" call BRPVP_playSound;
		if (_inBase && _attacker) then {
			["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\no_dam.paa'/><br/>"+localize "str_bdam_inbase_attacker",0,0,2,0,0,34793] call BRPVP_fnc_dynamicText;
		} else {
			if (_inBase && !_attacker) then {
				["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\no_dam.paa'/><br/>"+localize "str_bdam_inbase_victim",0,0,2,0,0,34793] call BRPVP_fnc_dynamicText;
			} else {
				if (!_inBase && _attacker) then {
					["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\no_dam.paa'/><br/>"+localize "str_bdam_outbase_attacker",0,0,2,0,0,34793] call BRPVP_fnc_dynamicText;
				} else {
					if (!_inBase && !_attacker) then {
						["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\no_dam.paa'/><br/>"+localize "str_bdam_outbase_victim",0,0,2,0,0,34793] call BRPVP_fnc_dynamicText;
					};
				};
			};
		};
	};
};
BRPVP_domeDrawLines = {
	params ["_pa","_bala","_pwb","_limit"];
	private _paw = AGLToASL _pa;
	private _init = diag_tickTime;
	waitUntil {
		private _bPos = if (isNull _bala) then {_pwb} else {getPosWorld _bala};
		_pwb = +_bPos;
		drawLaser [_paw,_bPos vectorDiff _paw,[50,0,0],[],0,15,vectorMagnitude (_bPos vectorDiff _paw),false];
		diag_tickTime-_init > _limit
	};
};
BRPVP_isDomeFriend = {
	if (_this getVariable ["id_bd",-1] isEqualTo -1) then {
		false
	} else {
		if (_this call BRPVP_checaAcesso) then {true} else {[player,_this call BRPVP_nearestFlagInside] call BRPVP_checaAcessoRemotoFlag};
	};
};
BRPVP_activateDomeOnArty = {
	params ["_bala","_pos"];
	private _end = false;
	private _ammoClass = typeOf _bala;
	private _amExclude = _bala nearObjects ["Land_Communication_F",300];
	_amExclude = _amExclude apply {if (_bala distance _x < _x getVariable ["brpvp_dome_radius",100000000] || _x call BRPVP_isDomeFriend) then {_x} else {-1};};
	_amExclude = _amExclude-[-1];
	waitUntil {velocity _bala select 2 <= 0};
	waitUntil {
		private ["_nPos"];
		private _limit = (((ASLToAGL getPosASL _bala) select 2)-800) max 50;
		private _init = diag_tickTime;
		waitUntil {
			_nPos = getPosWorld _bala;
			vectorMagnitude (_nPos vectorDiff _pos) > _limit || isNull _bala || (diag_tickTime-_init > 2 && _limit isEqualTo 50)
		};
		if (isNull _bala) then {
			private _exc = (ASLToAGL _pos) nearObjects ["Land_Communication_F",1500];
			_exc = _exc apply {if (_x call BRPVP_isDomeFriend) then {_x} else {-1};};
			_exc = _exc-[-1];
			if (isText (configFile >> "CfgAmmo" >> _ammoClass >> "submunitionAmmo")) then {
				private _smTxt = getText (configFile >> "CfgAmmo" >> _ammoClass >> "submunitionAmmo");
				if (_smTxt isNotEqualTo "") then {
					{
						if (typeOf _x isEqualTo _smTxt) then {if (random 1 < 0.45) then {[_x,getPosWorld _x,random 0.1,_exc] spawn BRPVP_activateDomeOnArtySM;};};
					} forEach nearestObjects [ASLToAGL _pos,[],75];
				};
			} else {
				if (isArray (configFile >> "CfgAmmo" >> _ammoClass >> "submunitionAmmo")) then {
					private _mix = getArray (configFile >> "CfgAmmo" >> _ammoClass >> "submunitionAmmo");
					{
						if (typeOf _x in _mix) then {if (random 1 < 0.45) then {[_x,getPosWorld _x,random 0.1,_exc] spawn BRPVP_activateDomeOnArtySM;};};
					} forEach nearestObjects [ASLToAGL _pos,[],75];
				};
			};
		} else {
			_pos = +_nPos;
			private _power = 0;
			private _near = (_bala nearObjects ["Land_Communication_F",400])-_amExclude;
			_near = _near apply {if (_x call BRPVP_isDomeFriend) then {_amExclude pushBack _x;-1} else {private _d = _bala distance _x;private _dr = _x getVariable ["brpvp_dome_radius",0];if (_d < _dr && {lineIntersectsSurfaces [getPosWorld _bala,getPosWorld _x vectorAdd [0,0,13.6],_bala,_x] isEqualTo []}) then {_power = _power+1;_x} else {if (_d < _dr+50) then {_power = _power+1;-1} else {-1};};};};
			_near = _near-[-1];
			if (_near isNotEqualTo []) then {
				_near = _near apply {[_x distance _bala,_x]};
				_near sort true;
				private _one = _near select 0 select 1;
				private _oneIsBase = _one getVariable ["id_bd",-1] > -1;
				private _protectionEff = [BRPVP_antiMissileEfficiency,BRPVP_antiMissileEfficiencyBase] select _oneIsBase;
				private _protectionWorked = false;
				for "_i" from 1 to _power do {
					if (random 1 <= _protectionEff) exitWith {
						_protectionWorked = [true,[random 1 > BRPVP_atomicShotBreakDomeProtectionChance,random 1 > BRPVP_minervaShotBreakDomeProtectionChance] select (_bala isEqualTo BRPVP_minervaShotObj)] select (_bala in [BRPVP_minervaShotObj,BRPVP_atomicShotObj]);
					};
				};
				private _pwb = getPosWorld _bala;
				private _init = diag_tickTime;
				private _pa = ASLToAGL getPosWorld _one vectorAdd [0,0,13.6];
				private _nearP = call BRPVP_playersList apply {if (_x distance _one < 3000) then {_x} else {-1};};
				private _effect = createVehicle ["Sign_Sphere200cm_F",[0,0,0],[],0,"NONE"];
				_effect attachTo [_bala,[0,0,0]];
				_nearP = _nearP-[-1];
				_nearP pushBackUnique player;
				if (_protectionWorked) then {
					[_one,["dome_ray",2000,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					[_pa,_bala,getPosWorld _bala,0.25] remoteExec ["BRPVP_domeDrawLines",_nearP];
					uiSleep 0.25;
					private _haveSM1 = isText (configFile >> "CfgAmmo" >> _ammoClass >> "submunitionAmmo") && {getText (configFile >> "CfgAmmo" >> _ammoClass >> "submunitionAmmo") isNotEqualTo ""};
					private _haveSM2 = isArray (configFile >> "CfgAmmo" >> _ammoClass >> "submunitionAmmo");
					if (_haveSM1 || _haveSM2) then {
						triggerAmmo ("APERSTripMine_Wire_Ammo" createVehicle ASLToAGL getPosASL _bala);
						deleteVehicle _bala;
					} else {
						triggerAmmo _bala;
					};
				} else {
					[_one,["spark_super",2500,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					[_pa,_bala,getPosWorld _bala,0.1] remoteExec ["BRPVP_domeDrawLines",_nearP];
					uiSleep 0.1;
				};
				detach _effect;
				deleteVehicle _effect;
				_end = true;
			};
		};
		isNull _bala || _end
	};
};
BRPVP_activateDomeOnArtySM = {
	params ["_bala","_pos","_wait","_exc"];
	private _end = false;
	private _limit = 0;
	uiSleep _wait;
	waitUntil {
		private ["_nPos"];
		private _init = diag_tickTime;
		waitUntil {
			_nPos = getPosWorld _bala;
			vectorMagnitude (_nPos vectorDiff _pos) > _limit || isNull _bala || diag_tickTime-_init > (1+_wait*5)
		};
		_limit = 50;
		if (!isNull _bala) then {
			_pos = +_nPos;
			private _power = 0;
			private _near = (_bala nearObjects ["Land_Communication_F",375])-_exc;
			_near = _near apply {private _d = _bala distance _x;private _dr = _x getVariable ["brpvp_dome_radius",0];if (_d < _dr && {lineIntersectsSurfaces [getPosWorld _bala,getPosWorld _x vectorAdd [0,0,13.6],_bala,_x] isEqualTo []}) then {_power = _power+1;_x} else {if (_d < _dr+50) then {_power = _power+1;-1} else {-1};};};
			_near = _near-[-1];
			if (_near isNotEqualTo []) then {
				_near = _near apply {[_x distance _bala,_x]};
				_near sort true;
				private _one = _near select 0 select 1;
				private _oneIsBase = _one getVariable ["id_bd",-1] > -1;
				private _protectionEff = [BRPVP_antiMissileEfficiency,BRPVP_antiMissileEfficiencyBase] select _oneIsBase;
				private _protectionWorked = false;
				for "_i" from 1 to _power do {if (random 1 <= _protectionEff) exitWith {_protectionWorked = true;};};
				private _pwb = getPosWorld _bala;
				private _init = diag_tickTime;
				private _pa = ASLToAGL getPosWorld _one vectorAdd [0,0,13.6];
				private _nearP = call BRPVP_playersList apply {if (_x distance _one < 3000) then {_x} else {-1};};
				private _effect = createVehicle ["Sign_Sphere200cm_F",[0,0,0],[],0,"NONE"];
				_effect attachTo [_bala,[0,0,0]];
				_nearP = _nearP-[-1];
				_nearP pushBackUnique player;
				if (_protectionWorked) then {
					[_one,["dome_ray",2000,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					[_pa,_bala,getPosWorld _bala,0.25] remoteExec ["BRPVP_domeDrawLines",_nearP];
					uiSleep 0.25;
					triggerAmmo ("APERSTripMine_Wire_Ammo" createVehicle ASLToAGL getPosASL _bala);
					deleteVehicle _bala;
				} else {
					[_one,["spark_super",2500,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					[_pa,_bala,getPosWorld _bala,0.1] remoteExec ["BRPVP_domeDrawLines",_nearP];
					uiSleep 0.1;
				};
				detach _effect;
				deleteVehicle _effect;
				_end = true;
			};
		};
		isNull _bala || _end
	};
};
BRPVP_activateDomeOnMissileRockets = {
	params ["_bala","_pos"];
	private _end = false;
	private _amExclude = _bala nearObjects ["Land_Communication_F",300];
	_amExclude = _amExclude apply {if (_bala distance _x < _x getVariable ["brpvp_dome_radius",100000000] || _x call BRPVP_isDomeFriend) then {_x} else {-1};};
	_amExclude = _amExclude-[-1];
	waitUntil {
		private ["_nPos"];
		private _limit = (((ASLToAGL getPosASL _bala) select 2)-350) max 50;
		waitUntil {
			_nPos = getPosWorld _bala;
			vectorMagnitude (_nPos vectorDiff _pos) > _limit
		};
		_pos = +_nPos;
		if (!isNull _bala) then {
			private _power = 0;
			private _near = (_bala nearObjects ["Land_Communication_F",375])-_amExclude;
			_near = _near apply {if (_x call BRPVP_isDomeFriend) then {_amExclude pushBack _x;-1} else {private _d = _bala distance _x;private _dr = _x getVariable ["brpvp_dome_radius",0];if (_d < _dr && {lineIntersectsSurfaces [getPosWorld _bala,getPosWorld _x vectorAdd [0,0,13.6],_bala,_x] isEqualTo []}) then {_power = _power+1;_x} else {if (_d < _dr+50) then {_power = _power+1;-1} else {-1};};};};
			_near = _near-[-1];
			if (_near isNotEqualTo []) then {
				_near = _near apply {[_x distance _bala,_x]};
				_near sort true;
				private _one = _near select 0 select 1;
				private _oneIsBase = _one getVariable ["id_bd",-1] > -1;
				private _protectionEff = [BRPVP_antiMissileEfficiency,BRPVP_antiMissileEfficiencyBase] select _oneIsBase;
				private _protectionWorked = false;
				for "_i" from 1 to _power do {
					if (random 1 <= _protectionEff) exitWith {
						_protectionWorked = [true,[random 1 > BRPVP_atomicShotBreakDomeProtectionChance,random 1 > BRPVP_minervaShotBreakDomeProtectionChance] select (_bala isEqualTo BRPVP_minervaShotObj)] select (_bala in [BRPVP_minervaShotObj,BRPVP_atomicShotObj]);
					};
				};
				private _pwb = getPosWorld _bala;
				private _init = diag_tickTime;
				private _pa = ASLToAGL getPosWorld _one vectorAdd [0,0,13.6];
				private _nearP = call BRPVP_playersList apply {if (_x distance _one < 3000) then {_x} else {-1};};
				private _effect = createVehicle ["Sign_Sphere200cm_F",[0,0,0],[],0,"NONE"];
				_effect attachTo [_bala,[0,0,0]];
				_nearP = _nearP-[-1];
				_nearP pushBackUnique player;
				if (_protectionWorked) then {
					[_one,["dome_ray",2000,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					[_pa,_bala,getPosWorld _bala,0.25] remoteExec ["BRPVP_domeDrawLines",_nearP];
					uiSleep 0.25;
					triggerAmmo _bala;
				} else {
					[_one,["spark_super",2500,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					[_pa,_bala,getPosWorld _bala,0.1] remoteExec ["BRPVP_domeDrawLines",_nearP];
					uiSleep 0.1;
				};
				detach _effect;
				deleteVehicle _effect;
				_end = true;
			};
		};
		isNull _bala || _end
	};
};
BRPVP_alertAiAboutNearBullets = {
	params ["_bullet","_lastPos"];
	private _didUberAttack = false;
	waitUntil {
		private _pos = getPosWorld _bullet;
		private _vecDiff = _pos vectorDiff _lastPos;
		private _distance = vectorMagnitude _vecDiff;
		private _steps = ceil (_distance/(BRPVP_bulletDistanceToAlertAI*BRPVP_bulletDistanceToAlertAIOptimize));
		private _delta = _distance/(_steps max 1);
		private _unitVec = vectorNormalized _vecDiff;
		private _found = false;
		for "_i" from 1 to _steps do {
			private _checkPos = _lastPos vectorAdd (_unitVec vectorMultiply _i*_delta);
			private _nearUnits = (ASLToAGL _checkPos) nearEntities ["CaManBase",BRPVP_bulletDistanceToAlertAI];
			{
				if !(_x getVariable ["sok",false]) then {_x reveal [player,4];};
				if (_x getVariable ["brpvp_lars",false]) then {
					private _lastTeleport = _x getVariable "brpvp_teleport_time";
					if (serverTime-_lastTeleport > BRPVP_larsDelayBetweenSmallTeleports) then {
						_x setVariable ["brpvp_teleport_time",serverTime,true];
						if (random 1 < BRPVP_larsChanceOfSlowTeleport) then {uiSleep BRPVP_larsChanceOfSlowTeleportTime;};
						[_x,player] remoteExecCall ["BRPVP_larsTeleport",_x];
					};
				} else {
					if (_x getVariable ["brpvp_peter",false]) then {
						private _lastTeleport = _x getVariable "brpvp_teleport_time";
						if (serverTime-_lastTeleport > BRPVP_peterDelayBetweenSmallTeleports) then {
							_x setVariable ["brpvp_teleport_time",serverTime,true];
							if (random 1 < BRPVP_peterChanceOfSlowTeleport) then {uiSleep BRPVP_peterChanceOfSlowTeleportTime;};
							[_x,player] remoteExecCall ["BRPVP_peterTeleport",_x];
						};
					};
				};
				if (!_didUberAttack && _x getVariable ["brpvp_uber_attack",false]) then {
					if (isNull objectParent _x) then {
						private _uaDist = _x distance2D player;
						if (_uaDist > 125 && _uaDist < 3500) then {
							private _ha = getPosASL _x select 2;
							private _hp = getPosASL player select 2;
							if (abs(_ha-_hp) < (300 min (_uaDist*0.45))) then {
								private _ai = _x;
								private _dir = [_ai,player] call BIS_fnc_dirTo;
								private _vec = [0,15,25];
								private _lis = _vec apply {lineIntersectsSurfaces [eyePos _ai,eyePos _ai vectorAdd [_x*sin _dir,_x*cos _dir,35],_ai,objNull,true,1,"GEOM","NONE"]};
								private _ok = {_x isNotEqualTo [] && {!((_x select 0 select 2) call BRPVP_isMotorized)}} count _lis isEqualTo 0;
								if (_ok) then {
									_didUberAttack = true;
									_ai setVariable ["brpvp_uber_attack",false];
									[_ai,player] remoteExecCall ["BRPVP_doUberAttack",2];
								};
							};
						};
					};
				};
				if (!_found) then {
					call BRPVP_ligaModoCombate;
					_found = true;
				};
			} forEach _nearUnits;
		};
		_lastPos = +_pos;
		vectorMagnitude velocity _bullet < 10 || isNull _bullet
	};
};
BRPVP_openItemAltIClassAdCreation = {
	params ["_ii","_qtt"];
	BRPVP_tempAdAltI = _this;
	private _defDescr = "";
	{
		private _name = BRPVP_specialItemsNames select _x;
		_defDescr = _defDescr+_name+" X "+str (_qtt select _forEachIndex)+".";
		if (_forEachIndex+1 isNotEqualTo count _ii) then {_defDescr = _defDescr+" ";};
	} forEach _ii;
	disableSerialization;
	private _display = findDisplay 46 createDisplay "BRPVP_CAD";
	
	private _input1 = _display ctrlCreate ["RscEdit",97310];
	_input1 ctrlSetPosition [0,0,1,0.065];
	_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input1 ctrlSetText localize "str_class_ad_item_name";
	_input1 ctrlCommit 0;
	_input1 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_item_name") then {_c ctrlSetText "";};}];
	_input1 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_item_name";};}];
	_input1 ctrlAddEventHandler ["Char",{params ["_c","_cc"];if (count ctrlText _c > 50) then {"erro" call BRPVP_playSound;_c ctrlSetText (ctrlText _c select [0,50]);};}];
	
	private _input2 = _display ctrlCreate ["RscEditMulti",97311];
	_input2 ctrlSetPosition [0,0.1,1,0.26];
	_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input2 ctrlSetText _defDescr;
	_input2 ctrlCommit 0;
	_input2 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_item_descr") then {_c ctrlSetText "";};}];
	_input2 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_item_descr";};}];
	_input2 ctrlAddEventHandler ["Char",{params ["_c","_cc"];if (count ctrlText _c > 500) then {"erro" call BRPVP_playSound;_c ctrlSetText (ctrlText _c select [0,500]);};}];

	private _defPrice = 0;
	{
		private _class = _x;
		private _q = _qtt select _forEachIndex;
		if (_class isEqualType "" || {_class > -1}) then {
			_class = if (_class isEqualType 1) then {BRPVP_specialItems select _class} else {_class};
			_defPrice = _defPrice+(_class call BRPVP_itemGetPrice)*_q;
		};
	} forEach _ii;
	private _input3 = _display ctrlCreate ["RscEdit",97312];
	_input3 ctrlSetPosition [0,0.395,1,0.065];
	_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input3 ctrlSetText ([_defPrice call BRPVP_formatNumber," ",""] call BRPVP_stringReplace);
	_input3 ctrlCommit 0;

	private _bOk = _display ctrlCreate ["RscButton",97313];
	_bOk ctrlSetPosition [0,0.495,0.15,0.065];
	_bOk ctrlSetText localize "str_ok";
	_bOk ctrlAddEventHandler ["ButtonClick",{
		private _txt = ctrlText (findDisplay 20813 displayCtrl 97312);
		private _tc = _txt;
		{_tc = [_tc,_x,""] call BRPVP_stringReplace;} forEach ["0","1","2","3","4","5","6","7","8","9"];
		if (_tc isEqualTo "") then {
			private _name = ctrlText (findDisplay 20813 displayCtrl 97310) select [0,50];
			private _descr = ctrlText (findDisplay 20813 displayCtrl 97311) select [0,500];
			private _price = call compile _txt;
			if (_name isNotEqualTo "" && _name isNotEqualTo localize "str_class_ad_item_name") then {
				if (_descr isEqualTo localize "str_class_ad_item_descr") then {_descr = "";};
				_descr = [[_descr,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
				_name = [[_name,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
				private _cargo = [];
				{_cargo pushBack [_x,(BRPVP_tempAdAltI select 1) select _forEachIndex];} forEach (BRPVP_tempAdAltI select 0);
				private _params = [
					_cargo,
					"alt+i",
					_price,
					player getVariable ["id_bd",-1],
					player getVariable ["nm","no_name"],
					BRPVP_xpLastTotal,
					_name,
					_descr
				];
				{_x call BRPVP_sitRemoveItem;} forEach _cargo;
				_params remoteExecCall ["BRPVP_addClassAdItem",2];
				findDisplay 20813 closeDisplay 1;
				[localize "str_ad_anounced_item",-5] call BRPVP_hint;
			} else {
				"erro" call BRPVP_playSound;
				[localize "str_ad_need_name",-4] call BRPVP_hint;
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_only_numbers",-4] call BRPVP_hint;
		};
	}];
	_bOk ctrlCommit 0;
	
	private _bCancel = _display ctrlCreate ["RscButton",97314];
	_bCancel ctrlSetPosition [0.175,0.495,0.15,0.065];
	_bCancel ctrlSetText localize "str_menu12_opt2";
	_bCancel ctrlAddEventHandler ["ButtonClick",{findDisplay 20813 closeDisplay 1;}];
	_bCancel ctrlCommit 0;
	
	0 spawn {
		waitUntil {isNull findDisplay 20813 || !(player call BRPVP_pAlive) || BRPVP_menuExtraLigado};
		if (!isNull findDisplay 20813) then {findDisplay 20813 closeDisplay 1;};
	};
};
BRPVP_tireClientMoveBarrier = {
	private _tire = _this select 3;
	private _tirePos = getPosWorld _tire;
	private _tireVdu = [vectorDir _tire,vectorUp _tire];
	private _pos = ASLToAGL getPosASL player;
	private _owner = _tire getVariable "brpvp_tire_owner";
	if ((player getVariable "id_bd") isEqualTo _owner || BRPVP_vePlayers) then {
		[localize "str_tire_veh_enter_release",-5] call BRPVP_hint;
		private _id = _tire getVariable "brpvp_tire_idbd";
		private _spawned = false;
		_tire attachTo [player,[0,1.2,0.8]];
		waitUntil {
			uiSleep 0.001;
			_spawned = ({_x getVariable ["id_bd",-1] isEqualTo _id} count nearestObjects [_pos,["LandVehicle","Air","Ship"],30]) > 0;
			_spawned || !(player call BRPVP_pAlive) || isNull attachedTo _tire
		};
		if (_spawned) then {
			detach _tire;
		} else {
			if !(player call BRPVP_pAlive) then {
				detach _tire;
				_tire setVectorDirAndUp _tireVdu;
				_tire setPosWorld _tirePos;
			};
		};
	};
};
BRPVP_classAdItemDone = {
	params ["_name","_adName","_price"];
	[format [localize "str_class_ad_item_done",_name,_adName,_price call BRPVP_numberSetSufix],10] call BRPVP_hint;
	player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0])+_price,true];
};
BRPVP_classAdVehicleDone = {
	params ["_name","_adName","_price","_fake"];
	[format [localize "str_class_ad_vehicle_done",_name,_adName,_price call BRPVP_numberSetSufix,[localize "str_false",localize "str_true"] select _fake],10] call BRPVP_hint;
	player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0])+_price,true];
};
BRPVP_openItemClassAdCreation = {
	disableSerialization;
	private _display = findDisplay 46 createDisplay "BRPVP_CAD";
	
	private _input1 = _display ctrlCreate ["RscEdit",97310];
	_input1 ctrlSetPosition [0,0,1,0.065];
	_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input1 ctrlSetText localize "str_class_ad_item_name";
	_input1 ctrlCommit 0;
	_input1 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_item_name") then {_c ctrlSetText "";};}];
	_input1 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_item_name";};}];
	_input1 ctrlAddEventHandler ["Char",{params ["_c","_cc"];if (count ctrlText _c > 50) then {"erro" call BRPVP_playSound;_c ctrlSetText (ctrlText _c select [0,50]);};}];
	
	private _input2 = _display ctrlCreate ["RscEditMulti",97311];
	_input2 ctrlSetPosition [0,0.1,1,0.26];
	_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input2 ctrlSetText localize "str_class_ad_item_descr";
	_input2 ctrlCommit 0;
	_input2 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_item_descr") then {_c ctrlSetText "";};}];
	_input2 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_item_descr";};}];
	_input2 ctrlAddEventHandler ["Char",{params ["_c","_cc"];if (count ctrlText _c > 500) then {"erro" call BRPVP_playSound;_c ctrlSetText (ctrlText _c select [0,500]);};}];

	private _defPrice = (player getVariable ["brpvp_box_carry",objNull] call BRPVP_getCargoArray) call BRPVP_getCargoArrayValor;
	_defPrice = (_defPrice select 0)+(_defPrice select 1);
	private _input3 = _display ctrlCreate ["RscEdit",97312];
	_input3 ctrlSetPosition [0,0.395,1,0.065];
	_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input3 ctrlSetText ([_defPrice call BRPVP_formatNumber," ",""] call BRPVP_stringReplace);
	_input3 ctrlCommit 0;
	//_input3 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_item_price") then {_c ctrlSetText "";};}];
	//_input3 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_item_price";};}];

	private _bOk = _display ctrlCreate ["RscButton",97313];
	_bOk ctrlSetPosition [0,0.495,0.15,0.065];
	_bOk ctrlSetText localize "str_ok";
	_bOk ctrlAddEventHandler ["ButtonClick",{
		private _txt = ctrlText (findDisplay 20813 displayCtrl 97312);
		private _tc = _txt;
		{_tc = [_tc,_x,""] call BRPVP_stringReplace;} forEach ["0","1","2","3","4","5","6","7","8","9"];
		if (_tc isEqualTo "") then {
			private _name = ctrlText (findDisplay 20813 displayCtrl 97310) select [0,50];
			private _descr = ctrlText (findDisplay 20813 displayCtrl 97311) select [0,500];
			private _price = call compile _txt;
			private _wh = player getVariable ["brpvp_box_carry",objNull];
			if (_name isNotEqualTo "" && _name isNotEqualTo localize "str_class_ad_item_name") then {
				if (_descr isEqualTo localize "str_class_ad_item_descr") then {_descr = "";};
				_descr = [[_descr,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
				_name = [[_name,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
				private _params = [
					_wh call BRPVP_getCargoArray,
					typeOf _wh,
					_price,
					player getVariable ["id_bd",-1],
					player getVariable ["nm","no_name"],
					BRPVP_xpLastTotal,
					_name,
					_descr
				];
				_params remoteExecCall ["BRPVP_addClassAdItem",2];
				_wh call BRPVP_emptyBox;
				BRPVP_carryUsedObjs spawn BRPVP_boxCarryReleaseActionCode;
				findDisplay 20813 closeDisplay 1;
				[localize "str_ad_anounced_item",-5] call BRPVP_hint;
			} else {
				"erro" call BRPVP_playSound;
				[localize "str_ad_need_name",-4] call BRPVP_hint;
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_only_numbers",-4] call BRPVP_hint;
		};
	}];
	_bOk ctrlCommit 0;
	
	private _bCancel = _display ctrlCreate ["RscButton",97314];
	_bCancel ctrlSetPosition [0.175,0.495,0.15,0.065];
	_bCancel ctrlSetText localize "str_menu12_opt2";
	_bCancel ctrlAddEventHandler ["ButtonClick",{findDisplay 20813 closeDisplay 1;}];
	_bCancel ctrlCommit 0;
	
	0 spawn {
		waitUntil {isNull findDisplay 20813 || !(player call BRPVP_pAlive) || BRPVP_menuExtraLigado || isNull (player getVariable ["brpvp_box_carry",objNull])};
		if (!isNull findDisplay 20813) then {findDisplay 20813 closeDisplay 1;};
	};
};
BRPVP_openVehicleClassAdCreation = {
	BRPVP_classAdVehicle = _this select 0;
	BRPVP_classAdIsFake = _this select 1;
	
	disableSerialization;
	private _display = findDisplay 46 createDisplay "BRPVP_CAD";
	
	private _input1 = _display ctrlCreate ["RscEdit",97310];
	_input1 ctrlSetPosition [0,0,1,0.065];
	_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input1 ctrlSetText localize "str_class_ad_veh_name";
	_input1 ctrlCommit 0;
	_input1 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_veh_name") then {_c ctrlSetText "";};}];
	_input1 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_veh_name";};}];
	_input1 ctrlAddEventHandler ["Char",{params ["_c","_cc"];if (count ctrlText _c > 50) then {"erro" call BRPVP_playSound;_c ctrlSetText (ctrlText _c select [0,50]);};}];
	
	private _input2 = _display ctrlCreate ["RscEditMulti",97311];
	_input2 ctrlSetPosition [0,0.1,1,0.26];
	_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input2 ctrlSetText localize "str_class_ad_veh_descr";
	_input2 ctrlCommit 0;
	_input2 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_veh_descr") then {_c ctrlSetText "";};}];
	_input2 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_veh_descr";};}];
	_input2 ctrlAddEventHandler ["Char",{params ["_c","_cc"];if (count ctrlText _c > 500) then {"erro" call BRPVP_playSound;_c ctrlSetText (ctrlText _c select [0,500]);};}];

	private _input3 = _display ctrlCreate ["RscEdit",97312];
	_input3 ctrlSetPosition [0,0.395,1,0.065];
	_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
	_input3 ctrlSetText localize "str_class_ad_veh_price";
	_input3 ctrlCommit 0;
	_input3 ctrlAddEventHandler ["SetFocus",{params ["_c"];if (ctrlText _c isEqualTo localize "str_class_ad_veh_price") then {_c ctrlSetText "";};}];
	_input3 ctrlAddEventHandler ["KillFocus",{params ["_c"];if (ctrlText _c isEqualTo "") then {_c ctrlSetText localize "str_class_ad_veh_price";};}];

	private _bOk = _display ctrlCreate ["RscButton",97313];
	_bOk ctrlSetPosition [0,0.495,0.15,0.065];
	_bOk ctrlSetText localize "str_ok";
	_bOk ctrlAddEventHandler ["ButtonClick",{
		private _txt = ctrlText (findDisplay 20813 displayCtrl 97312);
		private _tc = _txt;
		{_tc = [_tc,_x,""] call BRPVP_stringReplace;} forEach ["0","1","2","3","4","5","6","7","8","9"];
		if (alive BRPVP_classAdVehicle) then {
			if (_tc isEqualTo "") then {
				private _price = call compile _txt;
				private _descr = ctrlText (findDisplay 20813 displayCtrl 97311) select [0,500];
				private _name = ctrlText (findDisplay 20813 displayCtrl 97310) select [0,50];
				if (_name isNotEqualTo "" && _name isNotEqualTo localize "str_class_ad_veh_name") then {
					if (_descr isEqualTo localize "str_class_ad_veh_descr") then {_descr = "";};
					_descr = [[_descr,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
					_name = [[_name,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
					private _params = [
						BRPVP_classAdVehicle getVariable ["id_bd",-1],
						typeOf BRPVP_classAdVehicle,
						_price,
						player getVariable ["id_bd",-1],
						player getVariable ["nm","no_name"],
						BRPVP_xpLastTotal,
						_name,
						_descr,
						if (BRPVP_classAdIsFake) then {[20+round random 100,30+round random 100]} else {[]}
					];
					_params remoteExecCall ["BRPVP_addClassAdVehicle",2];
					if (!BRPVP_classAdIsFake) then {
						(BRPVP_classAdVehicle call BRPVP_salvaVeiculoData) remoteExecCall ["BRPVP_salvaVeiculoOnlySql",2];
						[BRPVP_classAdVehicle,false,true] call BRPVP_removeObject;
					};
					findDisplay 20813 closeDisplay 1;
					[localize "str_ad_anounced",-5] call BRPVP_hint;
				} else {
					"erro" call BRPVP_playSound;
					[localize "str_ad_need_name",-4] call BRPVP_hint;
				};
			} else {
				"erro" call BRPVP_playSound;
				[localize "str_only_numbers",-4] call BRPVP_hint;
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_ad_vehicle_not_ok",-5] call BRPVP_hint;
			findDisplay 20813 closeDisplay 1;
		};
	}];
	_bOk ctrlCommit 0;
	
	private _bCancel = _display ctrlCreate ["RscButton",97314];
	_bCancel ctrlSetPosition [0.175,0.495,0.15,0.065];
	_bCancel ctrlSetText localize "str_menu12_opt2";
	_bCancel ctrlAddEventHandler ["ButtonClick",{findDisplay 20813 closeDisplay 1;}];
	_bCancel ctrlCommit 0;
	
	0 spawn {
		waitUntil {isNull findDisplay 20813 || !alive BRPVP_classAdVehicle || !(player call BRPVP_pAlive) || BRPVP_menuExtraLigado};
		if (!isNull findDisplay 20813) then {findDisplay 20813 closeDisplay 1;};
	};
};
BRPVP_radioAreasAddArea = {
	BRPVP_radioAreas pushBack _this;
	private _place = _this select [0,4];
	_place call BRPVP_addNewPosCheckLayer;

	//ICON
	_place params ["_iPos","_raio","_iName","_tipo"];
	_icon = createMarkerLocal [_iName,_iPos];
	_icon setMarkerShapeLocal "ELLIPSE";
	_icon setMarkerSizeLocal [_raio,_raio];
	_icon setMarkerColorLocal "ColorGreen";
	_icon setMarkerAlphaLocal 0.65;
};
BRPVP_radioAreasRemoveArea = {
	private _key = _this;
	private _idx = -1;
	{if (_x select 2 isEqualTo _key) exitWith {_idx = _forEachIndex;};} forEach BRPVP_radioAreas;
	if (_idx isNotEqualTo -1) then {BRPVP_radioAreas deleteAt _idx;};
	_key call BRPVP_removePosCheckLayer;
	deleteMarkerLocal _key;
};
BRPVP_disableNearServiceAction = {
	BRPVP_vehRearmNear = objNull;
	BRPVP_vehRefuelNear = objNull;
	BRPVP_vehRepairNear = objNull;
	if (BRPVP_vehRearmAction > -1) then {
		private _param = (_this actionParams BRPVP_vehRearmAction) select 1;
		private _txt = "call BRPVP_reamrVehCode;";
		if (_param isEqualTo _txt) then {
			_this removeAction BRPVP_vehRearmAction;
			BRPVP_vehRearmAction = -1;
		};
	};
	if (BRPVP_vehRefuelAction > -1) then {
		private _param = (_this actionParams BRPVP_vehRefuelAction) select 1;
		private _txt = "call BRPVP_refuelVehCode;";
		if (_param isEqualTo _txt) then {
			_this removeAction BRPVP_vehRefuelAction;
			BRPVP_vehRefuelAction = -1;
		};
	};
	if (BRPVP_vehRepairAction > -1) then {
		private _param = (_this actionParams BRPVP_vehRepairAction) select 1;
		private _txt = "call BRPVP_repairVehCode;";
		if (_param isEqualTo _txt) then {
			_this removeAction BRPVP_vehRepairAction;
			BRPVP_vehRepairAction = -1;
		};
	};
};
BRPVP_checkForNearServicesLastVeh = objNull;
BRPVP_checkForNearServices = {
	private _isUAV = false;
	private _veh = BRPVP_myUAVNow;
	if (isNull _veh) then {_veh = objectParent player;} else {_isUAV = true;};
	if (!isNull BRPVP_checkForNearServicesLastVeh && _veh isNotEqualTo BRPVP_checkForNearServicesLastVeh) then {BRPVP_checkForNearServicesLastVeh call BRPVP_disableNearServiceAction;};
	if (!isNull _veh && {_isUAV || driver _veh isEqualTo player}) then {
		private _foundAmmo = objNull;
		private _foundFuel = objNull;
		private _foundRepair = objNull;
		{
			if (getAmmoCargo _x >= 0) then {_foundAmmo = _x;};
			if (getFuelCargo _x >= 0) then {_foundFuel = _x;};
			if (getRepairCargo _x >= 0) then {_foundRepair = _x;};
		} forEach ((_veh nearEntities ["LandVehicle",25])-[_veh]);
		private _rearmNew = _foundAmmo isNotEqualTo BRPVP_vehRearmNear;
		private _refuelNew = _foundFuel isNotEqualTo BRPVP_vehRefuelNear;
		private _repairNew = _foundRepair isNotEqualTo BRPVP_vehRepairNear;
		BRPVP_vehRearmNear = _foundAmmo;
		BRPVP_vehRefuelNear = _foundFuel;
		BRPVP_vehRepairNear = _foundRepair;
		
		//REARM
		if (isNull BRPVP_vehRearmNear || _rearmNew) then {
			if (BRPVP_vehRearmAction > -1) then {
				_veh removeAction BRPVP_vehRearmAction;
				BRPVP_vehRearmAction = -1;
			};
		};
		if (!isNull BRPVP_vehRearmNear) then {
			if (BRPVP_vehRearmAction isEqualTo -1) then {
				private _name = getText (configFile >> "CfgVehicles" >> typeOf BRPVP_vehRearmNear >> "displayName") call BRPVP_escapeForStructuredTextFast;
				BRPVP_vehRearmAction = _veh addAction [format ["<t color='#FF0000'>%1</t>",format [localize "str_rearm_veh",_name]],{call BRPVP_reamrVehCode;},BRPVP_vehRearmNear,2.3,false,false];
			};
		};
		
		//REFUEL
		if (isNull BRPVP_vehRefuelNear || _refuelNew) then {
			if (BRPVP_vehRefuelAction > -1) then {
				_veh removeAction BRPVP_vehRefuelAction;
				BRPVP_vehRefuelAction = -1;
			};
		};
		if (!isNull BRPVP_vehRefuelNear) then {
			if (BRPVP_vehRefuelAction isEqualTo -1) then {
				private _name = getText (configFile >> "CfgVehicles" >> typeOf BRPVP_vehRefuelNear >> "displayName") call BRPVP_escapeForStructuredTextFast;
				BRPVP_vehRefuelAction = _veh addAction [format ["<t color='#FF0000'>%1</t>",format [localize "str_refuel_veh",_name]],{call BRPVP_refuelVehCode;},BRPVP_vehRefuelNear,2.1,false,false];
			};
		};
		
		//REPAIR
		if (isNull BRPVP_vehRepairNear || _repairNew) then {
			if (BRPVP_vehRepairAction > -1) then {
				_veh removeAction BRPVP_vehRepairAction;
				BRPVP_vehRepairAction = -1;
			};
		};
		if (!isNull BRPVP_vehRepairNear) then {
			if (BRPVP_vehRepairAction isEqualTo -1) then {
				private _name = getText (configFile >> "CfgVehicles" >> typeOf BRPVP_vehRepairNear >> "displayName") call BRPVP_escapeForStructuredTextFast;
				BRPVP_vehRepairAction = _veh addAction [format ["<t color='#FF0000'>%1</t>",format [localize "str_repair_veh",_name]],{call BRPVP_repairVehCode;},BRPVP_vehRepairNear,2.2,false,false];
			};
		};
	};
	BRPVP_checkForNearServicesLastVeh = _veh;
};
BRPVP_reamrVehCode = {
	private _sVeh = _this select 3;
	private _veh = BRPVP_myUAVNow;
	if (isNull _veh) then {_veh = objectParent player;};
	if (isNull _veh) then {
		"erro" call BRPVP_playSound;
	} else {
		private _uvt = _sVeh getVariable ["brpvp_rearm_time",[]];
		private _idx = -1;
		{if (_veh isEqualTo (_x select 0)) exitWith {_idx = _forEachIndex;};} forEach _uvt;
		if (_idx isEqualTo -1 || {serverTime-(_uvt select _idx select 1) > BRPVP_dukeNukemServiceDelay}) then {
			private _beforeAmmo = magazinesAllTurrets _veh;
			_veh setVehicleAmmo 1;
			private _afterAmmo = magazinesAllTurrets _veh;
			if (_afterAmmo isEqualTo _beforeAmmo) then {
				"erro" call BRPVP_playSound;
			} else {
				"duke_rearm" call BRPVP_playSound;
				["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\duke_rearm.paa'/><br/>"+localize "str_service_done",0,0.25,1.25,0,0,793] call BRPVP_fnc_dynamicText;
				_uvt = (_uvt apply {if (serverTime-(_x select 1) > BRPVP_dukeNukemServiceDelayCfg) then {-1} else {_x}})-[-1];
				if (_idx isEqualTo -1) then {_uvt pushBack [_veh,serverTime];} else {(_uvt select _idx) set [1,serverTime];};
				_sVeh setVariable ["brpvp_rearm_time",_uvt,true];
			};
		} else {
			private _txt = format [localize "str_cant_dnukem_wait_rearm",round (BRPVP_dukeNukemServiceDelay-(serverTime-(_uvt select _idx select 1)))];
			"erro" call BRPVP_playSound;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\duke_rearm.paa'/><br/>"+_txt,0,0.25,1.5,0,0,793] call BRPVP_fnc_dynamicText;
		};
	};
};
BRPVP_refuelVehCode = {
	private _sVeh = _this select 3;
	private _veh = BRPVP_myUAVNow;
	if (isNull _veh) then {_veh = objectParent player;};
	if (isNull _veh) then {
		"erro" call BRPVP_playSound;
	} else {
		private _uvt = _sVeh getVariable ["brpvp_refuel_time",[]];
		private _idx = -1;
		{if (_veh isEqualTo (_x select 0)) exitWith {_idx = _forEachIndex;};} forEach _uvt;
		if (_idx isEqualTo -1 || {serverTime-(_uvt select _idx select 1) > BRPVP_dukeNukemServiceDelay}) then {
			if (fuel _veh isEqualTo 1) then {
				"erro" call BRPVP_playSound;
			} else {
				"duke_rearm" call BRPVP_playSound;
				[_veh,1] remoteExecCall ["setFuel",_veh];
				["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\duke_rearm.paa'/><br/>"+localize "str_service_done",0,0.25,1.25,0,0,793] call BRPVP_fnc_dynamicText;
				_uvt = (_uvt apply {if (serverTime-(_x select 1) > BRPVP_dukeNukemServiceDelayCfg) then {-1} else {_x}})-[-1];
				if (_idx isEqualTo -1) then {_uvt pushBack [_veh,serverTime];} else {(_uvt select _idx) set [1,serverTime];};
				_sVeh setVariable ["brpvp_refuel_time",_uvt,true];
			};
		} else {
			private _txt = format [localize "str_cant_dnukem_wait_refuel",round (BRPVP_dukeNukemServiceDelay-(serverTime-(_uvt select _idx select 1)))];
			"erro" call BRPVP_playSound;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\duke_rearm.paa'/><br/>"+_txt,0,0.25,1.5,0,0,793] call BRPVP_fnc_dynamicText;
		};
	};
};
BRPVP_repairVehCode = {
	private _sVeh = _this select 3;
	private _veh = BRPVP_myUAVNow;
	if (isNull _veh) then {_veh = objectParent player;};
	if (isNull _veh) then {
		"erro" call BRPVP_playSound;
	} else {
		private _uvt = _sVeh getVariable ["brpvp_repair_time",[]];
		private _idx = -1;
		{if (_veh isEqualTo (_x select 0)) exitWith {_idx = _forEachIndex;};} forEach _uvt;
		if (_idx isEqualTo -1 || {serverTime-(_uvt select _idx select 1) > BRPVP_dukeNukemServiceDelay}) then {
			if (damage _veh isEqualTo 0) then {
				"erro" call BRPVP_playSound;
			} else {
				"duke_rearm" call BRPVP_playSound;
				_veh call BRPVP_fixVehicleDuke;
				["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\duke_rearm.paa'/><br/>"+localize "str_service_done",0,0.25,1.25,0,0,793] call BRPVP_fnc_dynamicText;
				_uvt = (_uvt apply {if (serverTime-(_x select 1) > BRPVP_dukeNukemServiceDelayCfg) then {-1} else {_x};})-[-1];
				if (_idx isEqualTo -1) then {_uvt pushBack [_veh,serverTime];} else {(_uvt select _idx) set [1,serverTime];};
				_sVeh setVariable ["brpvp_repair_time",_uvt,true];
			};
		} else {
			private _txt = format [localize "str_cant_dnukem_wait_repair",round (BRPVP_dukeNukemServiceDelay-(serverTime-(_uvt select _idx select 1)))];
			"erro" call BRPVP_playSound;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\duke_rearm.paa'/><br/>"+_txt,0,0.25,1.5,0,0,793] call BRPVP_fnc_dynamicText;
		};
	};
};
BRPVP_enableVehiclesBuildingsChanged = {
	params ["_obj","_rad","_timeOn"];
	private _cars = [];
	{
		if (!simulationEnabled _x && (_x getVariable ["id_bd",-1] isNotEqualTo -1 || _x getVariable ["brpvp_fedidex",false])) then {
			private _lis = lineIntersectsSurfaces [getPosASL _x vectorAdd [0,0,1],getPosASL _x vectorAdd [0,0,-10],_x,objNull];
			if (_lis isNotEqualTo [] && {_lis select 0 select 2 isEqualTo _obj}) then {
				_x setVariable ["brpvp_time_can_disable",serverTime+_timeOn,2];
				if (!simulationEnabled _x) then {[_x,true] remoteExecCall ["enableSimulationGlobal",2];};
				_cars pushBack _x;
			};
		};
	} forEach (_obj nearEntities [["Motorcycle","Car","Tank","Air","Ship"],_rad max 50]);
	{
		_x setVariable ["slv",true,2];
		if (local _x) then {[_x,2] remoteExecCall ["setOwner",2];};
	} forEach _cars;
	_cars spawn {
		sleep 10;
		{_x setVariable ["slv",true,2];} forEach _this;
	};
};
BRPVP_virtualGarageSpawnSpaceCheck = {
	params ["_class","_paint","_cover","_ammo","_life"];
	private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
	_veiculo = _CVL;
	_veiculo allowDamage false;
	_veiculo addEventHandler ["EpeContactStart",{
		params ["_object1","_object2","_selection1","_selection2","_force"];
		if (!isNull _object2) then {
			[_object2,getPosWorld _object2,[vectorDir _object2,vectorUp _object2]] spawn {
				params ["_obj","_pw","_vdu"];
				_obj setPosWorld _pw;
				_obj setVectorDirAndUp _vdu;
				private _init = time;
				waitUntil {
					_obj setPosWorld _pw;
					_obj setVectorDirAndUp _vdu;
					time-_init > 0.25
				};
			};
		};
		BRPVP_vgSpaceCheckFail = true;
	}];
	if (_class isEqualTo "B_UAV_05_F") then {
		_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
		{_veiculo animateSource [_x,1,true];} forEach _wingAnimations;
	};
	_veiculo setDir (getDir player+180);
	if ((ASLToAGL getPosASL player) select 2 > 0.5) then {
		private _vehPos = [getPosASL player vectorAdd [0,0,0.5],0.55*sizeOf _class,getDir player] call BIS_fnc_relPos;
		{if (local _x) then {_x setVariable ["brpvp_coll_prot_time",time+1];};} forEach nearestObjects [ASLToAGL _vehPos,["Air","Ship"],20];
		_veiculo setPosASL _vehPos;
	} else {
		private _vehPos = AGLToASL ([ASLToAGL getPosASL player,0.55*sizeOf _class,getDir player] call BIS_fnc_relPos);
		private _vu = surfaceNormal _vehPos;
		private _angle = acos (_vu vectorCos [0,0,1]);
		private _h = 0.3/cos _angle;
		_vehPos = _vehPos vectorAdd [0,0,_h];
		{if (local _x) then {_x setVariable ["brpvp_coll_prot_time",time+1];};} forEach nearestObjects [ASLToAGL _vehPos,["Air","Ship"],20];
		_veiculo setPosASL _vehPos;
		_veiculo setVectorUp _vu;
	};
	
	//VEHICLE COVER
	if !(_cover isEqualTo []) then {[_veiculo,false,_cover,false] call BIS_fnc_initVehicle;};

	//SET VEHICLE LIFE
	[_veiculo,_life] call BRPVP_setVehicleDamage;

	//SET AMMO
	[_veiculo,_ammo] call BRPVP_setVehicleAmmo;

	//PAINT GREY
	{_veiculo setObjectTexture [_forEachIndex,"#(argb,8,8,3)color(0.1,0.1,0.1,1)"];} forEach getObjectTextures _veiculo;

	_veiculo lock true;
	_veiculo setVariable ["brpvp_no_tow",true];
	_veiculo call BRPVP_emptyBox;

	private _drawCoords = [[_veiculo],2,[1,0,0,1]] call BRPVP_getCubeDrawCoords;
	[_veiculo,_drawCoords]
};
BRPVP_setTurretTypes = {
	_veiculo = _this;
	if (isNull _veiculo) then {
		BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 0;
		BRPVP_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 0;
		BRPVP_actualAutoTurrets = BRPVP_autoTurretOnMan;
		BRPVP_autoTurretExtraCode = {["man",_this] call BRPVP_checkTurretType};
	} else {
		if (_veiculo isKindOf "LandVehicle") then {
			private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _veiculo >> "armor");
			if (BRPVP_nitroFlyOn) then {
				BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 2;
				BRPVP_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 2;
				BRPVP_actualAutoTurrets = BRPVP_autoTurretOnFlyLandVehicle;
				BRPVP_autoTurretExtraCode = {["air",_this] call BRPVP_checkTurretType};
				if (_armor >= 100 && _armor <= 200) then {
					if (!(_veiculo getVariable ["brpvp_to_turret",false]) && _veiculo isKindOf "MRAP_03_base_F") then {_veiculo setVariable ["brpvp_to_turret",true,true];};
				} else {
					if (_armor > 200) then {
						BRPVP_actualAutoTurrets = BRPVP_autoTurretOnFlyLandVehicleHeavyArmor;
						if !(_veiculo getVariable ["brpvp_to_turret",false]) then {_veiculo setVariable ["brpvp_to_turret",true,true];};
						if !(_veiculo getVariable ["brpvp_use_texplode",false]) then {_veiculo setVariable ["brpvp_use_texplode",true,true];};
					};
				};
			} else {
				BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 1;
				BRPVP_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 1;
				BRPVP_actualAutoTurrets = BRPVP_autoTurretOnLandVehicle;
				if (_armor < 100) then {
					BRPVP_autoTurretExtraCode = {["car",_this] call BRPVP_checkTurretType};
				} else {
					if (_armor >= 100 && _armor <= 200) then {
						BRPVP_autoTurretExtraCode = {["armor",_this] call BRPVP_checkTurretType};
						if (!(_veiculo getVariable ["brpvp_to_turret",false]) && _veiculo isKindOf "MRAP_03_base_F") then {_veiculo setVariable ["brpvp_to_turret",true,true];};
					} else {
						BRPVP_autoTurretExtraCode = {["harmor",_this] call BRPVP_checkTurretType && (typeOf _this in BRPVP_autoTurretTypesTitan || (_this getVariable ["brpvp_tlevel",1]) isEqualTo 2)};
						if !(_veiculo getVariable ["brpvp_to_turret",false]) then {_veiculo setVariable ["brpvp_to_turret",true,true];};
						if !(_veiculo getVariable ["brpvp_use_texplode",false]) then {_veiculo setVariable ["brpvp_use_texplode",true,true];};
					};
				};
			};
		} else {
			if (_veiculo isKindOf "Plane") then {
				BRPVP_actualAutoTurrets = BRPVP_autoTurretOnAirVehicle;
				BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 3;
				BRPVP_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 3;
				BRPVP_autoTurretExtraCode = {["plane",_this] call BRPVP_checkTurretType};
			} else {
				if (_veiculo isKindOf "Air" || _veiculo isKindOf "Ship") then {
					BRPVP_actualAutoTurrets = BRPVP_autoTurretOnAirVehicle;
					BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 2;
					BRPVP_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 2;
					BRPVP_autoTurretExtraCode = {["air",_this] call BRPVP_checkTurretType};
				};
			};
		};
	};
};
BRPVP_ccAccTypeCheck = {
	if (BRPVP_allPlayersOnFlagHaveAccessToAllBase) then {[player,BRPVP_stuff] call BRPVP_checaAcessoRemotoFlag} else {BRPVP_stuff getVariable ["own",-1] isEqualTo (player getVariable "id_bd")};
};
BRPVP_aiNoSimuMsg = {
	["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\simu_dist.paa'/><br/>"+localize "str_move_near",0,0.25,2,0,0,9732] call BRPVP_fnc_dynamicText;
	"error3" call BRPVP_playSound;
};
BRPVP_trowAttractZombie = {
	params ["_find","_smoke"];
	sleep 0.25;
	_init = time;
	_uniqueZombies = 0;
	_maxPerAmmo = (BRPVP_maxZombiesPerSmokeShell select _find);
	_maxUnique = round (_maxPerAmmo*BRPVP_maxZombiesPerSmokeShellUniqueMult);
	waitUntil {
		_smokePos = (getPosWorld _smoke) vectorAdd [0,0,0.5];
		_smokePosAGL = ASLToAGL _smokePos;
		_nearZombies = _smoke nearEntities [BRPVP_zombieMotherClass,BRPVP_zombieDistanceFromSmokeToCatchAttention];
		_smokeZombies = [];
		_zombieCount = {
			_is = alive _x && !isNull _x && _x getVariable ["brpvp_my_distract_object",objNull] == _smoke;
			if (_is) then {_smokeZombies pushBack _x};
			_is
		} count _nearZombies;
		{
			if (moveToCompleted _x) then {
				[_x,[_smokePosAGL,2,random 360] call BIS_fnc_RelPos] remoteExecCall ["moveTo",_x];
			};
		} forEach _smokeZombies;
		if (_zombieCount < _maxPerAmmo && _uniqueZombies < _maxUnique) then {
			_nearZombies = _nearZombies-_smokeZombies;
			_nearZombiesCanSee = [];
			{
				if (isNull (_x getVariable ["brpvp_my_distract_object",objNull])) then {
					if ([_x,"GEOM"] checkVisibility [eyePos _x,_smokePos] > 0.1) then {
						_nearZombiesCanSee pushBack _x;
					};
				};
			} forEach _nearZombies;
			_nearZombiesCanSee = _nearZombiesCanSee apply {[_x distance _smokePosAGL,_x]};
			_nearZombiesCanSee sort true;
			_nearZombiesCanSee resize ((_maxPerAmmo-_zombieCount) min (count _nearZombiesCanSee) min (_maxUnique-_uniqueZombies));
			_nearZombiesCanSee = _nearZombiesCanSee apply {_x select 1};
			{
				[_x,ASLToAGL getPosASL _x] remoteExecCall ["moveTo",_x];
				[_x,_smokePosAGL] remoteExecCall ["moveTo",_x];
				[_x,_smokePosAGL] remoteExecCall ["doWatch",_x];
				_x setVariable ["brpvp_my_distract_object",_smoke,true];
				_x setVariable ["brpvp_my_distract_object_init",time,true];
				_uniqueZombies = _uniqueZombies+1;
			} forEach _nearZombiesCanSee;
		};
		sleep 0.5;
		isNull _smoke
	};
};
BRPVP_xpSeeInfoCloseSpec = {
	findDisplay 10710 closeDisplay _this;
};
BRPVP_xpSeeInfoSpec = {
	params ["_normalThis","_extra"];
	_normalThis params ["_type","_player","_back","_canEdit","_page"];
	_extra params ["_xpInSanctuarySpec","_xpLastTotalSpec","_xpConsumedSpec","_tastingAbilitiesEnabledSpec","_tastingAbilitiesDeniedSpec","_tastingAbilitiesOnSpec"];

	disableSerialization;
	_display = findDisplay 46 createDisplay "BRPVP_XP";
	private _xpData = _player call BRPVP_xpCalc;
	_xpData params ["_xpTotal","_xpArray"];
	_xpTotal = round _xpTotal;
	if (_type isEqualTo 1) then {
		private _lines = 1+count _xpArray;
		private _ls = 1/_lines;
		private _lsb = _ls*0.1;
		//TOTAL
		private _c = _display ctrlCreate ["RscStructuredText",-1];
		_c ctrlSetPosition [0,0*_ls+_lsb,0.5,_ls-_lsb];
		_c ctrlSetBackgroundColor [1,1,1,0];
		_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='1.1' align='left'>%1 %2</t>",localize "str_xp_total",_xpTotal call BRPVP_formatNumber];
		_c ctrlCommit 0;
		//ESC
		private _c = _display ctrlCreate ["RscStructuredText",-1];
		_c ctrlSetPosition [0.5,0*_ls+_lsb,0.5,_ls-_lsb];
		_c ctrlSetBackgroundColor [1,1,1,0];
		_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='1.1' align='right'>%1</t>",localize "str_xp_esc_to_leave"];
		_c ctrlCommit 0;
		{
			private _n = _foreachIndex+1;
			//TITTLE
			private _c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0,_n*_ls+_lsb,0.485,_ls-_lsb];
			_c ctrlSetBackgroundColor [0.5,0.5,0.5,0.6];
			_c ctrlSetStructuredText parseText format ["<t size='0.9' align='left'>%1</t><t size='1' align='right'>%2/%3</t>",_x select 0,round (_x select 5) call BRPVP_formatNumber,round (_x select 4) call BRPVP_formatNumber];
			_c ctrlCommit 0;
			//BAR - BLACK BACKGROUND
			_c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0,_ls-_lsb];
			_c ctrlSetBackgroundColor [0.7,0.7,0.7,0.8];
			_c ctrlCommit 0;
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlCommit 0.5;
			//BAR - WHITE DATA
			_c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0,_ls-_lsb];
			_c ctrlSetBackgroundColor [1,1,1,1];
			_c ctrlCommit 0;
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0.5*(_x select 1),_ls-_lsb];
			_c ctrlCommit 0.5;
			//BAR - PERCENTAGE
			_c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlSetBackgroundColor [0,0,0,0];
			_c ctrlSetStructuredText parseText format ["<t color='#808080' size='0.9' align='center'>%1 XP / %2 XP</t>",round (_x select 2) call BRPVP_formatNumber,round (_x select 3) call BRPVP_formatNumber];
			_c ctrlCommit 0;
		} forEach _xpArray;
	} else {
		if (_type isEqualTo 2) then {
			private _perPage = 34;
			private _activePerks = _player getVariable ["brpvp_active_perks",[]];
			if (_xpInSanctuarySpec) then {["",0,0,0,0,0,13856] call BRPVP_fnc_dynamicText;};
			private _xpPerks = BRPVP_xpPerks apply {if (_x select 3 && !(_x select 4 in [39])) then {(_x select 6)+[_x select 1,_x]} else {-1}};
			_xpPerks = _xpPerks-[-1];
			_xpPerks sort true;
			_xpPerks = _xpPerks apply {_x select 3};
			_xpConsumed = 0;
			{if ((_x select 4) in _activePerks && !((_x select 4) in _tastingAbilitiesOnSpec)) then {_xpConsumed = _xpConsumed+(_x select 1);};} forEach _xpPerks;
			private _maxPages = ceil ((count _xpPerks)/_perPage);
			private _ls = (1/((ceil ((_perPage+2)/2))+1)) min 0.1;
			private _lsb = _ls*0.1;
			BRPVP_habilityIS1 = str (0.55*28*(_ls-_lsb));
			BRPVP_habilityTS1 = str (0.75*28*(_ls-_lsb));
			BRPVP_habilityTS2 = str (1.02*28*(_ls-_lsb));
			//TOTAL
			private _c = _display ctrlCreate ["RscStructuredText",2937];
			_c ctrlSetPosition [0,0*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlSetBackgroundColor [1,1,1,0];
			_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='"+BRPVP_habilityTS2+"' align='left'>%1 %2K</t><t color='#FFCB15' size='"+BRPVP_habilityTS2+"' align='right'>%3 %4K </t>",localize "str_xp_remaining_to_use",round ((_xpTotal-_xpConsumed)/1000) call BRPVP_formatNumber,localize "str_xp_used",round (_xpConsumed/1000) call BRPVP_formatNumber];
			_c ctrlCommit 0;
			//ESC
			private _c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,0*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlSetBackgroundColor [1,1,1,0];
			_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='"+BRPVP_habilityTS2+"' align='right'>%1</t>",localize "str_xp_esc_to_leave"];
			_c ctrlCommit 0;
			private _colA = _xpPerks select [(_page-1)*_perPage,_perPage/2];
			private _colB = _xpPerks select [(_page-1)*_perPage+_perPage/2,_perPage/2];
			private _idc = 5000;
			{
				private _n = _forEachIndex+1;
				(_x select 5) params ["_xpNeed","_perksNeed"];
				private _cost = _x select 1;
				private _remain = _xpLastTotalSpec-_xpConsumedSpec;
				private _canNormal = _xpLastTotalSpec >= _xpNeed && _remain >= _cost;
				private _canTaste = _tastingAbilitiesEnabledSpec && !((_x select 4) in _tastingAbilitiesDeniedSpec) && !(_x select 4 in _activePerks) && !_canNormal;
				private _canCancel = _x select 7 select 0;
				private _color = if (_x select 4 in _activePerks) then {"#DFDFDF"} else {"#DFDFDF"};
				private _ok = if (_x select 4 in _activePerks) then {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\ok.paa'/>"} else {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\not_ok.paa'/>"};
				private _bcc = if (_xpInSanctuarySpec && _canEdit) then {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.5,0.25,0.35,0.7]} else {[0.25,0.25,0.5,0.7]};
				} else {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.6,0.6,0.6,0.7]} else {[0.4,0.4,0.4,0.7]};
				};
				//PERK
				private _c = _display ctrlCreate ["RscStructuredText",_idc];
				_idc = _idc+1;
				_c ctrlSetBackgroundColor _bcc;
				private _rNeed = _x select 5 select 0;
				private _rNeedTxt = if (_rNeed > 0) then {format [" (%1K)",(_rNeed/1000) call BRPVP_formatNumber]} else {""};
				_c ctrlSetStructuredText parseText format ["%2 <t color='%1' size='"+BRPVP_habilityTS1+"' align='left'>%3 (%4K)%5%6%7</t>",_color,_ok,_x select 0,((_x select 1)/1000) call BRPVP_formatNumber,_rNeedTxt,[" <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\perk_locked.paa'/>",""] select _canCancel,[""," <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_tasting.paa'/>"] select _canTaste];
				_c ctrlSetPosition [0,_n*_ls+_lsb,0.49,_ls-_lsb];
				_c ctrlCommit 0;
			} forEach _colA;

			//BUTTON PREVIOUS PAGE
			private _b1 = _display ctrlCreate ["RscButton",_idc];
			_b1 ctrlSetPosition [0.30,((_perPage/2)+1)*_ls+_lsb,0.09,_ls-_lsb];
			_b1 ctrlSetText "<<";
			_b1 ctrlCommit 0;
			_idc = _idc+1;

			{
				private _n = _forEachIndex+1;
				(_x select 5) params ["_xpNeed","_perksNeed"];
				private _cost = _x select 1;
				private _remain = _xpLastTotalSpec-_xpConsumedSpec;
				private _canNormal = _xpLastTotalSpec >= _xpNeed && _remain >= _cost;
				private _canTaste = _tastingAbilitiesEnabledSpec && !((_x select 4) in _tastingAbilitiesDeniedSpec) && !(_x select 4 in _activePerks) && !_canNormal;
				private _canCancel = _x select 7 select 0;
				private _color = if (_x select 4 in _activePerks) then {"#DFDFDF"} else {"#DFDFDF"};
				private _ok = if (_x select 4 in _activePerks) then {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\ok.paa'/>"} else {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\not_ok.paa'/>"};
				private _bcc = if (_xpInSanctuarySpec && _canEdit) then {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.5,0.25,0.35,0.7]} else {[0.25,0.25,0.5,0.7]};
				} else {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.6,0.6,0.6,0.7]} else {[0.4,0.4,0.4,0.7]};
				};
				//PERK
				private _c = _display ctrlCreate ["RscStructuredText",_idc];
				_idc = _idc+1;
				_c ctrlSetBackgroundColor _bcc;
				private _rNeed = _x select 5 select 0;
				private _rNeedTxt = if (_rNeed > 0) then {format [" (%1K)",(_rNeed/1000) call BRPVP_formatNumber]} else {""};
				_c ctrlSetStructuredText parseText format ["%2 <t color='%1' size='"+BRPVP_habilityTS1+"' align='left'>%3 (%4K)%5%6%7</t>",_color,_ok,_x select 0,((_x select 1)/1000) call BRPVP_formatNumber,_rNeedTxt,[" <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\perk_locked.paa'/>",""] select _canCancel,[""," <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_tasting.paa'/>"] select _canTaste];
				_c ctrlSetPosition [0.51,_n*_ls+_lsb,0.49,_ls-_lsb];
				_c ctrlCommit 0;
			} forEach _colB;

			//BUTTON NEXT PAGE
			private _b2 = _display ctrlCreate ["RscButton",_idc];
			_b2 ctrlSetPosition [0.61,((_perPage/2)+1)*_ls+_lsb,0.09,_ls-_lsb];
			_b2 ctrlSetText ">>";
			_b2 ctrlCommit 0;
			_idc = _idc+1;

			//PAGE
			private _b3 = _display ctrlCreate ["RscButton",_idc];
			_b3 ctrlSetPosition [0.457,((_perPage/2)+1)*_ls+_lsb,0.05,_ls-_lsb];
			_b3 ctrlSetText str _page;
			_b3 ctrlCommit 0;
			_idc = _idc+1;
		};
	};
};
BRPVP_perkClickDeleteSpec = {
	ctrlDelete (findDisplay 10710 displayCtrl 780);
	ctrlDelete (findDisplay 10710 displayCtrl 781);
	ctrlDelete (findDisplay 10710 displayCtrl 782);
};
BRPVP_perkClickSpec = {
	params ["_txt","_txtCTC","_confirmButtom"];
	disableSerialization;
	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,_txtCTC];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
	if (_confirmButtom) then {
		_bYes = findDisplay 10710 ctrlCreate ["RscStructuredText",781];
		_bYes ctrlSetBackgroundColor [0.2,0.2,0.2,1];
		_bYes ctrlSetStructuredText parseText localize "str_confirm";
		_bYes ctrlSetPosition [0.01,0.06,0.09,0.04];
		_bYes ctrlCommit 0;
		ctrlSetFocus _bYes;
		_bNo = findDisplay 10710 ctrlCreate ["RscStructuredText",782];
		_bNo ctrlSetBackgroundColor [0.2,0.2,0.2,1];
		_bNo ctrlSetStructuredText parseText localize "str_menu12_opt2";
		_bNo ctrlSetPosition [0.12,0.06,0.09,0.04];
		_bNo ctrlCommit 0;
	};
};
BRPVP_perkClickCantSpec = {
	params ["_txt"];
	disableSerialization;
	"erro" call BRPVP_playSound;
	_txt = format ["<img shadow='0' size='3' image='map_specific\sanctuary.paa'/><br/><t>%1</t>",localize "str_xp_must_be_in_sanct"];
	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
};
BRPVP_perkClickConfirmSpec = {
	params ["_name","_txt","_isTaste"];
	ctrlDelete (findDisplay 10710 displayCtrl 780);
	ctrlDelete (findDisplay 10710 displayCtrl 781);
	ctrlDelete (findDisplay 10710 displayCtrl 782);
	"box_upgrade" call BRPVP_playSound;
	_txt = format ["<br/><t color='#FFCB15'>%1</t><t> %2</t>",localize "str_xp_new_habilitie",_name];
	_txt = format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>%1",_txt];
	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
	if (_isTaste) then {"hamburger" call BRPVP_playSound;};
};
BRPVP_perkClickConfirmRemoveSpec = {
	params ["_name","_txt","_isTaste"];
	ctrlDelete (findDisplay 10710 displayCtrl 780);
	ctrlDelete (findDisplay 10710 displayCtrl 781);
	ctrlDelete (findDisplay 10710 displayCtrl 782);
	"negocio" call BRPVP_playSound;
	"xp_change" call BRPVP_playSound;
	_txt = format ["<br/><t color='#FFCB15'>%1</t><t> %2</t>",localize "str_xp_habilitie_canceled",_name];
	_txt = format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>%1",_txt];
	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
};
BRPVP_xpSeeInfo = {
	BRPVP_xpSeeInfoLastParams = _this;
	params ["_type","_player","_back",["_canEdit",true],["_page",BRPVP_perkPageSet]];

	BRPVP_xpInSanctuary = false;
	{if (player distance _x < 50 || BRPVP_vePlayers) exitWith {BRPVP_xpInSanctuary = true;};} forEach BRPVP_xpSanctuaryBuildings;

	//SEND TO SPEC
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
		private _normal = [_type,_player,_back,_canEdit,_page];
		private _extra = [BRPVP_xpInSanctuary,BRPVP_xpLastTotal,BRPVP_xpConsumed,BRPVP_tastingAbilitiesEnabled,BRPVP_tastingAbilitiesDenied,BRPVP_tastingAbilitiesOn];
		[_normal,_extra] remoteExecCall ["BRPVP_xpSeeInfoSpec",BRPVP_specOnMeMachinesNoMe];
	};

	disableSerialization;
	_display = findDisplay 46 createDisplay "BRPVP_XP";
	if (_back > -1) then {
		BRPVP_xpSeeInfoBack = _back;
		_display displayAddEventHandler ["KeyDown",{
			//SEND TO SPEC
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {1 remoteExecCall ["BRPVP_xpSeeInfoCloseSpec",BRPVP_specOnMeMachinesNoMe];};

			(_this select 0) displayRemoveAllEventHandlers "KeyDown";
			(_this select 0) closeDisplay 1;
			BRPVP_xpSeeInfoBack call BRPVP_iniciaMenuExtra;
			true
		}];
	};
	private _xpData = _player call BRPVP_xpCalc;
	_xpData params ["_xpTotal","_xpArray"];
	_xpTotal = round _xpTotal;
	if (_type isEqualTo 1) then {
		private _lines = 1+count _xpArray;
		private _ls = 1/_lines;
		private _lsb = _ls*0.1;
		//TOTAL
		private _c = _display ctrlCreate ["RscStructuredText",-1];
		_c ctrlSetPosition [0,0*_ls+_lsb,0.5,_ls-_lsb];
		_c ctrlSetBackgroundColor [1,1,1,0];
		_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='1.1' align='left'>%1 %2</t>",localize "str_xp_total",_xpTotal call BRPVP_formatNumber];
		_c ctrlCommit 0;
		//ESC
		private _c = _display ctrlCreate ["RscStructuredText",-1];
		_c ctrlSetPosition [0.5,0*_ls+_lsb,0.5,_ls-_lsb];
		_c ctrlSetBackgroundColor [1,1,1,0];
		_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='1.1' align='right'>%1</t>",localize "str_xp_esc_to_leave"];
		_c ctrlCommit 0;
		{
			private _n = _foreachIndex+1;
			//TITTLE
			private _c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0,_n*_ls+_lsb,0.485,_ls-_lsb];
			_c ctrlSetBackgroundColor [0.5,0.5,0.5,0.6];
			_c ctrlSetStructuredText parseText format ["<t size='1' align='left'>%1</t><t size='0.9' align='right'>%2/%3</t>",_x select 0,round (_x select 5) call BRPVP_formatNumber,round (_x select 4) call BRPVP_formatNumber];
			_c ctrlCommit 0;
			//BAR - BLACK BACKGROUND
			_c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0,_ls-_lsb];
			_c ctrlSetBackgroundColor [0.7,0.7,0.7,0.8];
			_c ctrlCommit 0;
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlCommit 0.5;
			//BAR - WHITE DATA
			_c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0,_ls-_lsb];
			_c ctrlSetBackgroundColor [1,1,1,1];
			_c ctrlCommit 0;
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0.5*(_x select 1),_ls-_lsb];
			_c ctrlCommit 0.5;
			//BAR - PERCENTAGE
			_c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,_n*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlSetBackgroundColor [0,0,0,0];
			_c ctrlSetStructuredText parseText format ["<t color='#808080' size='0.9' align='center'>%1 XP / %2 XP</t>",round (_x select 2) call BRPVP_formatNumber,round (_x select 3) call BRPVP_formatNumber];
			_c ctrlCommit 0;
		} forEach _xpArray;
	} else {
		if (_type isEqualTo 2) then {
			private _perPage = 34;
			private _activePerks = _player getVariable ["brpvp_active_perks",[]];
			if (BRPVP_xpInSanctuary) then {["",0,0,0,0,0,13856] call BRPVP_fnc_dynamicText;};
			private _xpPerks = BRPVP_xpPerks apply {if (_x select 3 && !(_x select 4 in [39])) then {(_x select 6)+[_x select 1,_x]} else {-1}};
			_xpPerks = _xpPerks-[-1];
			_xpPerks sort true;
			_xpPerks = _xpPerks apply {_x select 3};
			_xpConsumed = 0;
			{if ((_x select 4) in _activePerks && !((_x select 4) in BRPVP_tastingAbilitiesOn)) then {_xpConsumed = _xpConsumed+(_x select 1);};} forEach _xpPerks;
			private _maxPages = ceil ((count _xpPerks)/_perPage);
			private _ls = (1/((ceil ((_perPage+2)/2))+1)) min 0.1;
			private _lsb = _ls*0.1;
			BRPVP_habilityIS1 = str (0.55*28*(_ls-_lsb));
			BRPVP_habilityTS1 = str (0.75*28*(_ls-_lsb));
			BRPVP_habilityTS2 = str (1.02*28*(_ls-_lsb));
			//TOTAL
			private _c = _display ctrlCreate ["RscStructuredText",2937];
			_c ctrlSetPosition [0,0*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlSetBackgroundColor [1,1,1,0];
			_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='"+BRPVP_habilityTS2+"' align='left'>%1 %2K</t><t color='#FFCB15' size='"+BRPVP_habilityTS2+"' align='right'>%3 %4K </t>",localize "str_xp_remaining_to_use",round ((_xpTotal-_xpConsumed)/1000) call BRPVP_formatNumber,localize "str_xp_used",round (_xpConsumed/1000) call BRPVP_formatNumber];
			_c ctrlCommit 0;
			//ESC
			private _c = _display ctrlCreate ["RscStructuredText",-1];
			_c ctrlSetPosition [0.5,0*_ls+_lsb,0.5,_ls-_lsb];
			_c ctrlSetBackgroundColor [1,1,1,0];
			_c ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='"+BRPVP_habilityTS2+"' align='right'>%1</t>",localize "str_xp_esc_to_leave"];
			_c ctrlCommit 0;
			private _colA = _xpPerks select [(_page-1)*_perPage,_perPage/2];
			private _colB = _xpPerks select [(_page-1)*_perPage+_perPage/2,_perPage/2];
			private _idc = 5000;
			{
				private _n = _forEachIndex+1;
				(_x select 5) params ["_xpNeed","_perksNeed"];
				private _cost = _x select 1;
				private _remain = BRPVP_xpLastTotal-BRPVP_xpConsumed;
				private _canNormal = BRPVP_xpLastTotal >= _xpNeed && _remain >= _cost;
				private _canTaste = BRPVP_tastingAbilitiesEnabled && !((_x select 4) in BRPVP_tastingAbilitiesDenied) && !(_x select 4 in _activePerks) && !_canNormal;
				private _canCancel = _x select 7 select 0;
				private _color = if (_x select 4 in _activePerks) then {"#DFDFDF"} else {"#DFDFDF"};
				private _ok = if (_x select 4 in _activePerks) then {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\ok.paa'/>"} else {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\not_ok.paa'/>"};
				private _bcc = if (BRPVP_xpInSanctuary && _canEdit) then {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.5,0.25,0.35,0.7]} else {[0.25,0.25,0.5,0.7]};
				} else {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.6,0.6,0.6,0.7]} else {[0.4,0.4,0.4,0.7]};
				};
				//PERK
				private _c = _display ctrlCreate ["RscStructuredText",_idc];
				_idc = _idc+1;
				_c setVariable ["brpvp_perk_data",_x];
				if (_canEdit) then {_c ctrlAddEventHandler ["MouseButtonUp",{call BRPVP_perkClick;}];};
				_c ctrlSetBackgroundColor _bcc;
				private _rNeed = _x select 5 select 0;
				private _rNeedTxt = if (_rNeed > 0) then {format [" (%1K)",(_rNeed/1000) call BRPVP_formatNumber]} else {""};
				_c ctrlSetStructuredText parseText format ["%2 <t color='%1' size='"+BRPVP_habilityTS1+"' align='left'>%3 (%4K)%5%6%7</t>",_color,_ok,_x select 0,((_x select 1)/1000) call BRPVP_formatNumber,_rNeedTxt,[" <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\perk_locked.paa'/>",""] select _canCancel,[""," <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_tasting.paa'/>"] select _canTaste];
				_c ctrlSetPosition [0,_n*_ls+_lsb,0.49,_ls-_lsb];
				_c ctrlCommit 0;
			} forEach _colA;

			//BUTTON PREVIOUS PAGE
			private _b1 = _display ctrlCreate ["RscButton",_idc];
			_b1 ctrlSetPosition [0.30,((_perPage/2)+1)*_ls+_lsb,0.09,_ls-_lsb];
			_b1 ctrlSetText "<<";
			_b1 ctrlCommit 0;
			_b1 setVariable ["brpvp_command",[_type,_player,_back,_canEdit,if (_page-1 > 0) then {_page-1} else {-1}]];
			_b1 ctrlAddEventHandler ["ButtonClick",{
				private _data = (_this select 0) getVariable "brpvp_command";
				if (_data select 4 > 0) then {
					//SEND TO SPEC
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {2 remoteExecCall ["BRPVP_xpSeeInfoCloseSpec",BRPVP_specOnMeMachinesNoMe];};

					_data spawn {_this call BRPVP_xpSeeInfo;};
					(ctrlParent (_this select 0)) closeDisplay 2;
					"hint2" call BRPVP_playSound;
				};
			}];
			_idc = _idc+1;

			{
				private _n = _forEachIndex+1;
				(_x select 5) params ["_xpNeed","_perksNeed"];
				private _cost = _x select 1;
				private _remain = BRPVP_xpLastTotal-BRPVP_xpConsumed;
				private _canNormal = BRPVP_xpLastTotal >= _xpNeed && _remain >= _cost;
				private _canTaste = BRPVP_tastingAbilitiesEnabled && !((_x select 4) in BRPVP_tastingAbilitiesDenied) && !(_x select 4 in _activePerks) && !_canNormal;
				private _canCancel = _x select 7 select 0;
				private _color = if (_x select 4 in _activePerks) then {"#DFDFDF"} else {"#DFDFDF"};
				private _ok = if (_x select 4 in _activePerks) then {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\ok.paa'/>"} else {"<img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\not_ok.paa'/>"};
				private _bcc = if (BRPVP_xpInSanctuary && _canEdit) then {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.5,0.25,0.35,0.7]} else {[0.25,0.25,0.5,0.7]};
				} else {
					if ((_x select 6 select 0) mod 2 isEqualTo 0) then {[0.6,0.6,0.6,0.7]} else {[0.4,0.4,0.4,0.7]};
				};
				//PERK
				private _c = _display ctrlCreate ["RscStructuredText",_idc];
				_idc = _idc+1;
				_c setVariable ["brpvp_perk_data",_x];
				if (_canEdit) then {_c ctrlAddEventHandler ["MouseButtonUp",{call BRPVP_perkClick;}];};
				_c ctrlSetBackgroundColor _bcc;
				private _rNeed = _x select 5 select 0;
				private _rNeedTxt = if (_rNeed > 0) then {format [" (%1K)",(_rNeed/1000) call BRPVP_formatNumber]} else {""};
				_c ctrlSetStructuredText parseText format ["%2 <t color='%1' size='"+BRPVP_habilityTS1+"' align='left'>%3 (%4K)%5%6%7</t>",_color,_ok,_x select 0,((_x select 1)/1000) call BRPVP_formatNumber,_rNeedTxt,[" <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\perk_locked.paa'/>",""] select _canCancel,[""," <img size='"+BRPVP_habilityIS1+"' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_tasting.paa'/>"] select _canTaste];
				_c ctrlSetPosition [0.51,_n*_ls+_lsb,0.49,_ls-_lsb];
				_c ctrlCommit 0;
			} forEach _colB;

			//BUTTON NEXT PAGE
			private _b2 = _display ctrlCreate ["RscButton",_idc];
			_b2 ctrlSetPosition [0.61,((_perPage/2)+1)*_ls+_lsb,0.09,_ls-_lsb];
			_b2 ctrlSetText ">>";
			_b2 ctrlCommit 0;
			_b2 setVariable ["brpvp_command",[_type,_player,_back,_canEdit,if (_page+1 > _maxPages) then {-1} else {_page+1}]];
			_b2 ctrlAddEventHandler ["ButtonClick",{
				private _data = (_this select 0) getVariable "brpvp_command";
				if (_data select 4 > 0) then {
					//SEND TO SPEC
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {2 remoteExecCall ["BRPVP_xpSeeInfoCloseSpec",BRPVP_specOnMeMachinesNoMe];};

					_data spawn {_this call BRPVP_xpSeeInfo;};
					(ctrlParent (_this select 0)) closeDisplay 2;
					"hint2" call BRPVP_playSound;
				};
			}];
			_idc = _idc+1;

			//PAGE
			private _b3 = _display ctrlCreate ["RscButton",_idc];
			_b3 ctrlSetPosition [0.457,((_perPage/2)+1)*_ls+_lsb,0.05,_ls-_lsb];
			_b3 ctrlSetText str _page;
			_b3 ctrlCommit 0;
			_idc = _idc+1;
			
			BRPVP_perkPageSet = _page;
		};
	};
};
BRPVP_perkClick = {
	params ["_control","_button","_xPos","_yPos","_shift","_ctrl","_alt"];
	if (BRPVP_xpInSanctuary) then {
		private _idc = ctrlIdc _control;
		if (_button isEqualTo 0) then {
			private _activePerks = player getVariable ["brpvp_active_perks",[]];
			(_control getVariable "brpvp_perk_data") params ["_name","_cost","_code","_active","_id","_need","_order","_uncode"];
			if (_id in _activePerks) then {
				if (_uncode select 0) then {
					disableSerialization;
					private _isTaste = _id in BRPVP_tastingAbilitiesOn;
					private _priceToCancelPerk = [BRPVP_priceToCancelPerk,round (BRPVP_priceToCancelPerk/5)] select _isTaste;
					private _confirmButtom = false;
					private _txt = "";
					private _txtCTC = localize "str_click_to_close";
					{if (_id in (_x select 5 select 1) && _x select 4 in _activePerks) then {_txt = _txt+"<br/>"+(_x select 0);};} forEach BRPVP_xpPerks;
					if (_txt isEqualTo "") then {
						private _mny = player getVariable ["brpvp_mny_bank",0];
						if (_mny < _priceToCancelPerk) then {
							_txt = format [localize "str_no_money_bank",(round (_priceToCancelPerk/1000) call BRPVP_formatNumber)+"K"];
						} else {
							_txt = format [localize "str_xp_cancel_perk",round (_priceToCancelPerk/1000) call BRPVP_formatNumber];
							_txtCTC = "";
							_confirmButtom = true;
						};
					} else {
						_txt = format ["<t color='#FFCB15'>%1</t>%2",localize "str_xp_cancel_before",_txt];
					};

					//SEND TO SPEC
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_txt,_txtCTC,_confirmButtom] remoteExecCall ["BRPVP_perkClickSpec",BRPVP_specOnMeMachinesNoMe];};

					_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
					_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
					_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,_txtCTC];
					_msg ctrlSetPosition [0,0,1,1];
					_msg ctrlCommit 0;
					_msg ctrlAddEventHandler ["MouseButtonUp",{
						//SEND TO SPEC
						if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_perkClickDeleteSpec",BRPVP_specOnMeMachinesNoMe];};

						(_this select 0) ctrlRemoveAllEventHandlers "MouseButtonUp";
						ctrlDelete (_this select 0);
						ctrlDelete (findDisplay 10710 displayCtrl 781);
						ctrlDelete (findDisplay 10710 displayCtrl 782);
						true
					}];
					ctrlSetFocus _msg;
					if (_confirmButtom) then {
						_bYes = findDisplay 10710 ctrlCreate ["RscStructuredText",781];
						_bYes ctrlSetBackgroundColor [0.2,0.2,0.2,1];
						_bYes ctrlSetStructuredText parseText localize "str_confirm";
						_bYes ctrlSetPosition [0.01,0.06,0.09,0.04];
						_bYes ctrlCommit 0;
						ctrlSetFocus _bYes;
						_bYes setVariable ["brpvp_perk_data",_control getVariable "brpvp_perk_data"];
						_bYes setVariable ["brpvp_perk_idc",_idc];
						if (_id in BRPVP_tastingAbilitiesOn) then {
							_bYes ctrlAddEventHandler ["MouseButtonUp",{call BRPVP_perkClickConfirmRemoveTaste;}];
						} else {
							_bYes ctrlAddEventHandler ["MouseButtonUp",{call BRPVP_perkClickConfirmRemove;}];
						};
						_bNo = findDisplay 10710 ctrlCreate ["RscStructuredText",782];
						_bNo ctrlSetBackgroundColor [0.2,0.2,0.2,1];
						_bNo ctrlSetStructuredText parseText localize "str_menu12_opt2";
						_bNo ctrlSetPosition [0.12,0.06,0.09,0.04];
						_bNo ctrlCommit 0;
						_bNo ctrlAddEventHandler ["MouseButtonUp",{
							//SEND TO SPEC
							if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_perkClickDeleteSpec",BRPVP_specOnMeMachinesNoMe];};

							ctrlDelete (findDisplay 10710 displayCtrl 780);
							ctrlDelete (findDisplay 10710 displayCtrl 781);
							ctrlDelete (findDisplay 10710 displayCtrl 782);
						}];
					};
				} else {
					"erro" call BRPVP_playSound;
					//["<t size='1.25 color='#FF0000'>"+localize "str_perk_cant_undo"+"<t/>",0,0.25,5,0,0,9757] call BRPVP_fnc_dynamicText;
				};
			} else {
				disableSerialization;
				_need params ["_xpNeed","_perksNeed"];
				private _remain = BRPVP_xpLastTotal-BRPVP_xpConsumed;
				private _txt = "";
				private _txtCTC = localize "str_click_to_close";
				private _confirmButtom = false;
				private _taste = false;
				private _canNormal = BRPVP_xpLastTotal >= _xpNeed && _remain >= _cost;
				private _canTaste = BRPVP_tastingAbilitiesEnabled && !(_id in BRPVP_tastingAbilitiesDenied) && !(_id in _activePerks) && !_canNormal;
				if (!_canNormal && _canTaste) then {
					if (_perksNeed-_activePerks isEqualTo []) then {
						"hint" call BRPVP_playSound;
						_txt = localize "str_perk_add_confirm_taste";
						_txtCTC = "";
						_confirmButtom = true;
						_taste = true;
					} else {
						"hint" call BRPVP_playSound;
						private _missing = _perksNeed-_activePerks;
						private _missingTxt = "<br/>";
						{if ((_x select 4) in _missing) then {_missingTxt = _missingTxt+(_x select 0)+"<br/>"};} forEach BRPVP_xpPerks;
						_txt = format ["<t color='#FFCB15'>%1</t>%2",(localize "str_perk_cant_no_perk"),_missingTxt];
					};
				} else {
					if (BRPVP_xpLastTotal >= _xpNeed) then {
						if (_perksNeed-_activePerks isEqualTo []) then {
							if (_remain >= _cost) then {
								"hint" call BRPVP_playSound;
								_txt = format [localize "str_perk_add_confirm",_cost/1000];
								_txtCTC = "";
								_confirmButtom = true;
							} else {
								"hint" call BRPVP_playSound;
								_txt = format [localize "str_perk_cant_no_remain",round (_cost/1000),round (_remain/1000)];
							};
						} else {
							"hint" call BRPVP_playSound;
							private _missing = _perksNeed-_activePerks;
							private _missingTxt = "<br/>";
							{if ((_x select 4) in _missing) then {_missingTxt = _missingTxt+(_x select 0)+"<br/>"};} forEach BRPVP_xpPerks;
							_txt = format ["<t color='#FFCB15'>%1</t>%2",(localize "str_perk_cant_no_perk"),_missingTxt];
						};
					} else {
						"hint" call BRPVP_playSound;
						_txt = format [localize "str_perk_cant_no_xp",round (_xpNeed/1000)];
					};
				};

				//SEND TO SPEC
				if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_txt,_txtCTC,_confirmButtom] remoteExecCall ["BRPVP_perkClickSpec",BRPVP_specOnMeMachinesNoMe];};

				_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
				_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
				_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,_txtCTC];
				_msg ctrlSetPosition [0,0,1,1];
				_msg ctrlCommit 0;
				_msg ctrlAddEventHandler ["MouseButtonUp",{
					//SEND TO SPEC
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_perkClickDeleteSpec",BRPVP_specOnMeMachinesNoMe];};

					(_this select 0) ctrlRemoveAllEventHandlers "MouseButtonUp";
					ctrlDelete (_this select 0);
					ctrlDelete (findDisplay 10710 displayCtrl 781);
					ctrlDelete (findDisplay 10710 displayCtrl 782);
					true
				}];
				ctrlSetFocus _msg;
				if (_confirmButtom) then {
					_bYes = findDisplay 10710 ctrlCreate ["RscStructuredText",781];
					_bYes ctrlSetBackgroundColor [0.2,0.2,0.2,1];
					_bYes ctrlSetStructuredText parseText localize "str_confirm";
					_bYes ctrlSetPosition [0.01,0.06,0.09,0.04];
					_bYes ctrlCommit 0;
					ctrlSetFocus _bYes;
					_bYes setVariable ["brpvp_perk_data",_control getVariable "brpvp_perk_data"];
					_bYes setVariable ["brpvp_perk_idc",_idc];
					if (_taste) then {
						_bYes ctrlAddEventHandler ["MouseButtonUp",{call BRPVP_perkClickConfirmTaste;}];
					} else {
						_bYes ctrlAddEventHandler ["MouseButtonUp",{call BRPVP_perkClickConfirm;}];
					};
					_bNo = findDisplay 10710 ctrlCreate ["RscStructuredText",782];
					_bNo ctrlSetBackgroundColor [0.2,0.2,0.2,1];
					_bNo ctrlSetStructuredText parseText localize "str_menu12_opt2";
					_bNo ctrlSetPosition [0.12,0.06,0.09,0.04];
					_bNo ctrlCommit 0;
					_bNo ctrlAddEventHandler ["MouseButtonUp",{
						//SEND TO SPEC
						if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_perkClickDeleteSpec",BRPVP_specOnMeMachinesNoMe];};

						ctrlDelete (findDisplay 10710 displayCtrl 780);
						ctrlDelete (findDisplay 10710 displayCtrl 781);
						ctrlDelete (findDisplay 10710 displayCtrl 782);
					}];
				};
			};
			(findDisplay 10710 displayCtrl 2937) ctrlSetStructuredText parseText format ["<t color='#FF4F4F' size='"+BRPVP_habilityTS2+"' align='left'>%1 %2K</t><t color='#FFCB15' size='"+BRPVP_habilityTS2+"' align='right'>%3 %4K </t>",localize "str_xp_remaining_to_use",((BRPVP_xpLastTotal-BRPVP_xpConsumed)/1000) call BRPVP_formatNumber,localize "str_xp_used",(BRPVP_xpConsumed/1000) call BRPVP_formatNumber];
		};
	} else {
		"erro" call BRPVP_playSound;
		_txt = format ["<img shadow='0' size='3' image='map_specific\sanctuary.paa'/><br/><t>%1</t>",localize "str_xp_must_be_in_sanct"];

		//SEND TO SPEC
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_txt] remoteExecCall ["BRPVP_perkClickCantSpec",BRPVP_specOnMeMachinesNoMe];};

		_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
		_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
		_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
		_msg ctrlSetPosition [0,0,1,1];
		_msg ctrlCommit 0;
		_msg ctrlAddEventHandler ["MouseButtonUp",{
			//SEND TO SPEC
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_perkClickDeleteSpec",BRPVP_specOnMeMachinesNoMe];};

			(_this select 0) ctrlRemoveAllEventHandlers "MouseButtonUp";
			ctrlDelete (_this select 0);
			ctrlDelete (findDisplay 10710 displayCtrl 781);
			ctrlDelete (findDisplay 10710 displayCtrl 782);
			true
		}];
		ctrlSetFocus _msg;
	};
};
BRPVP_perkClickConfirmTaste = {
	params ["_control","_button","_xPos","_yPos","_shift","_ctrl","_alt"];
	(_control getVariable "brpvp_perk_data") params ["_name","_cost","_code","_active","_id","_need","_order","_uncode"];
	private _perkIdc = _control getVariable "brpvp_perk_idc";
	private _activePerks = player getVariable ["brpvp_active_perks",[]];
	_activePerks pushBackUnique _id;
	player setVariable ["brpvp_active_perks",_activePerks,true];
	//[player getVariable "id_bd",_activePerks] remoteExecCall ["BRPVP_updatePlayerActivePerks",2];
	ctrlDelete (findDisplay 10710 displayCtrl 780);
	ctrlDelete (findDisplay 10710 displayCtrl 781);
	ctrlDelete (findDisplay 10710 displayCtrl 782);
	"box_upgrade" call BRPVP_playSound;
	call _code;
	_txt = format ["<br/><t color='#FFCB15'>%1</t><t> %2</t>",localize "str_xp_new_habilitie",_name];
	_txt = format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>%1",_txt];

	//SEND TO SPEC
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_name,_txt,true] remoteExecCall ["BRPVP_perkClickConfirmSpec",BRPVP_specOnMeMachinesNoMe];};

	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
	_msg ctrlAddEventHandler ["MouseButtonUp",{
		//SEND TO SPEC
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {2 remoteExecCall ["BRPVP_xpSeeInfoCloseSpec",BRPVP_specOnMeMachinesNoMe];};

		(_this select 0) ctrlRemoveAllEventHandlers "MouseButtonUp";
		BRPVP_xpSeeInfoLastParams spawn {_this call BRPVP_xpSeeInfo;};
		(ctrlParent (_this select 0)) closeDisplay 2;
		"hint2" call BRPVP_playSound;
		true
	}];
	//BRPVP_xpConsumed = BRPVP_xpConsumed+_cost;
	BRPVP_tastingAbilitiesOn pushBack _id;
	[player getVariable "id_bd",player getVariable "nm",_id] remoteExecCall ["BRPVP_recordUseOfTantingXp",2];
	"hamburger" call BRPVP_playSound;
};
BRPVP_perkClickConfirm = {
	params ["_control","_button","_xPos","_yPos","_shift","_ctrl","_alt"];
	(_control getVariable "brpvp_perk_data") params ["_name","_cost","_code","_active","_id","_need","_order","_uncode"];
	private _perkIdc = _control getVariable "brpvp_perk_idc";
	private _activePerks = player getVariable ["brpvp_active_perks",[]];
	_activePerks pushBackUnique _id;
	player setVariable ["brpvp_active_perks",_activePerks,true];
	[player getVariable "id_bd",_activePerks-BRPVP_tastingAbilitiesOn] remoteExecCall ["BRPVP_updatePlayerActivePerks",2];
	ctrlDelete (findDisplay 10710 displayCtrl 780);
	ctrlDelete (findDisplay 10710 displayCtrl 781);
	ctrlDelete (findDisplay 10710 displayCtrl 782);
	"box_upgrade" call BRPVP_playSound;
	call _code;
	_txt = format ["<br/><t color='#FFCB15'>%1</t><t> %2</t>",localize "str_xp_new_habilitie",_name];
	_txt = format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>%1",_txt];

	//SEND TO SPEC
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_name,_txt,false] remoteExecCall ["BRPVP_perkClickConfirmSpec",BRPVP_specOnMeMachinesNoMe];};

	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
	_msg ctrlAddEventHandler ["MouseButtonUp",{
		//SEND TO SPEC
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {2 remoteExecCall ["BRPVP_xpSeeInfoCloseSpec",BRPVP_specOnMeMachinesNoMe];};

		(_this select 0) ctrlRemoveAllEventHandlers "MouseButtonUp";
		BRPVP_xpSeeInfoLastParams spawn {_this call BRPVP_xpSeeInfo;};
		(ctrlParent (_this select 0)) closeDisplay 2;
		"hint2" call BRPVP_playSound;
		true
	}];
	BRPVP_xpConsumed = BRPVP_xpConsumed+_cost;
};
BRPVP_perkClickConfirmRemoveTaste = {
	params ["_control","_button","_xPos","_yPos","_shift","_ctrl","_alt"];
	(_control getVariable "brpvp_perk_data") params ["_name","_cost","_code","_active","_id","_need","_order","_uncode"];
	private _perkIdc = _control getVariable "brpvp_perk_idc";
	private _activePerks = player getVariable ["brpvp_active_perks",[]];
	_activePerks = _activePerks-[_id];
	player setVariable ["brpvp_active_perks",_activePerks,true];
	//[player getVariable "id_bd",_activePerks] remoteExecCall ["BRPVP_updatePlayerActivePerks",2];
	ctrlDelete (findDisplay 10710 displayCtrl 780);
	ctrlDelete (findDisplay 10710 displayCtrl 781);
	ctrlDelete (findDisplay 10710 displayCtrl 782);
	private _isTaste = _id in BRPVP_tastingAbilitiesOn;
	private _priceToCancelPerk = [BRPVP_priceToCancelPerk,round (BRPVP_priceToCancelPerk/5)] select _isTaste;
	player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0])-_priceToCancelPerk,true];
	"negocio" call BRPVP_playSound;
	"xp_change" call BRPVP_playSound;
	call (_unCode select 1);
	_txt = format ["<br/><t color='#FFCB15'>%1</t><t> %2</t>",localize "str_xp_habilitie_canceled",_name];
	_txt = format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>%1",_txt];

	//SEND TO SPEC
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_name,_txt,true] remoteExecCall ["BRPVP_perkClickConfirmSpec",BRPVP_specOnMeMachinesNoMe];};

	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
	_msg ctrlAddEventHandler ["MouseButtonUp",{
		//SEND TO SPEC
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {2 remoteExecCall ["BRPVP_xpSeeInfoCloseSpec",BRPVP_specOnMeMachinesNoMe];};

		(_this select 0) ctrlRemoveAllEventHandlers "MouseButtonUp";
		BRPVP_xpSeeInfoLastParams spawn {_this call BRPVP_xpSeeInfo;};
		(ctrlParent (_this select 0)) closeDisplay 2;
		"hint2" call BRPVP_playSound;
		true
	}];
	//BRPVP_xpConsumed = BRPVP_xpConsumed-_cost;
};
BRPVP_perkClickConfirmRemove = {
	params ["_control","_button","_xPos","_yPos","_shift","_ctrl","_alt"];
	(_control getVariable "brpvp_perk_data") params ["_name","_cost","_code","_active","_id","_need","_order","_uncode"];
	private _perkIdc = _control getVariable "brpvp_perk_idc";
	private _activePerks = player getVariable ["brpvp_active_perks",[]];
	_activePerks = _activePerks-[_id];
	player setVariable ["brpvp_active_perks",_activePerks,true];
	[player getVariable "id_bd",_activePerks-BRPVP_tastingAbilitiesOn] remoteExecCall ["BRPVP_updatePlayerActivePerks",2];
	ctrlDelete (findDisplay 10710 displayCtrl 780);
	ctrlDelete (findDisplay 10710 displayCtrl 781);
	ctrlDelete (findDisplay 10710 displayCtrl 782);
	player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0])-BRPVP_priceToCancelPerk,true];
	"negocio" call BRPVP_playSound;
	"xp_change" call BRPVP_playSound;
	call (_unCode select 1);
	_txt = format ["<br/><t color='#FFCB15'>%1</t><t> %2</t>",localize "str_xp_habilitie_canceled",_name];
	_txt = format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>%1",_txt];

	//SEND TO SPEC
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_name,_txt,false] remoteExecCall ["BRPVP_perkClickConfirmSpec",BRPVP_specOnMeMachinesNoMe];};

	_msg = findDisplay 10710 ctrlCreate ["RscStructuredText",780];
	_msg ctrlSetBackgroundColor [0.5,0.5,0.5,0.9];
	_msg ctrlSetStructuredText parseText format ["<t>%1</t><br/><t color='#FF2222'>%2</t>",_txt,localize "str_click_to_close"];
	_msg ctrlSetPosition [0,0,1,1];
	_msg ctrlCommit 0;
	ctrlSetFocus _msg;
	_msg ctrlAddEventHandler ["MouseButtonUp",{
		//SEND TO SPEC
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {2 remoteExecCall ["BRPVP_xpSeeInfoCloseSpec",BRPVP_specOnMeMachinesNoMe];};

		(_this select 0) ctrlRemoveAllEventHandlers "MouseButtonUp";
		BRPVP_xpSeeInfoLastParams spawn {_this call BRPVP_xpSeeInfo;};
		(ctrlParent (_this select 0)) closeDisplay 2;
		"hint2" call BRPVP_playSound;
		true
	}];
	BRPVP_xpConsumed = BRPVP_xpConsumed-_cost;
};
BRPVP_carrierMapClickSetPos = {
	params ["_pos","_alt","_shift"];
	if (BRPVP_carrierUseStatus isEqualTo 1) then {
		if (BRPVP_carrierPutPos isEqualTo []) then {
			private _landNear = [_pos,85] call BRPVP_checkIfLandNear;
			private _okLimit = true;
			if (BRPVP_waterBasesLimitUse) then {_okLimit = [_pos,BRPVP_waterBasesLimitDistance] call BRPVP_checkIfLandNear;};
			if (_landNear) exitWith {
				"erro" call BRPVP_playSound;
				[localize "str_carr_msg_cant_near_land",-6] call BRPVP_hint;
			};
			if (!_okLimit) exitWith {
				"erro" call BRPVP_playSound;
				[format [localize "str_carr_coast_limit_msg",BRPVP_waterBasesLimitDistance],-6] call BRPVP_hint;
			};
			private _nearC = nearestObjects [_pos,["Land_Carrier_01_base_F"],500,true]-[BRPVP_carrierHaveObj];
			private _eFlag = {!([player,_x] call BRPVP_checaAcessoRemotoFlag)} count nearestObjects [_pos,["Flag_Carrier"],600,true] > 0;
			if (!(_nearC isEqualTo []) || _eFlag) exitWith {[localize "str_carr_msg_cant_carr_near",-6] call BRPVP_hint;};
			"granted" call BRPVP_playSound;
			BRPVP_carrierPutPos = [_pos select 0,_pos select 1,0];
		};
	} else {
		if (BRPVP_carrierUseStatus isEqualTo 2) then {
			if (BRPVP_carrierPutDir isEqualTo -1) then {BRPVP_carrierPutDir = [_pos,BRPVP_carrierPutPos] call BIS_fnc_dirTo;};
		};
	};
	true
};
BRPVP_checkVehicleVirtualGarageSlot = {
	private _veh = _this select 3;
	private _type = "[Not Found]";
	{
		private _code = _x select 0;
		if (_veh call _code) exitWith {_type = _x select 3;};
	} forEach BRPVP_virtualGarageLimit;
	[format [localize "str_say_vg_slot",_type],-6] call BRPVP_hint;
};
BRPVP_tireClientPutVeh = {
	BRPVP_actionRunning pushBack 37;
	_veh = _this select 3;
	if (_veh getVariable ["brpvp_delete_when_possible",false]) then {
		"erro" call BRPVP_playSound;
	} else {
		if (_veh getVariable ["id_bd",-1] isNotEqualTo -1 && (_veh getVariable ["own",-1] isNotEqualTo -1 || BRPVP_vePlayers)) then {
			_veh setVariable ["brpvp_to_magus",true,true];
			[player,["to_magus",300]] remoteExecCall ["say3D",BRPVP_allNoServer];
			sleep 1.25;
			{if (typeOf _x isEqualTo "Land_CUP_Frigate_Ladders") then {deleteVehicle _x;};} forEach attachedObjects _veh;
			private _params = [_veh,vectorUp _veh,vectorDir _veh,getPos _veh select 2,getPosASL _veh];
			_params remoteExecCall ["BRPVP_tireServerPutVeh",2];
		} else {
			"erro" call BRPVP_playSound;
		};
	};
	BRPVP_actionRunning = BRPVP_actionRunning-[37];
};
BRPVP_tireClientGetVeh = {
	BRPVP_actionRunning pushBack 37;
	_tire = _this select 3;
	_idBd = _tire getVariable ["brpvp_tire_idbd",-1];
	_kills = _tire getVariable ["brpvp_tire_kills",0];
	_VGTime = _tire getVariable ["brpvp_from_vg_time",0];
	_cantSafeTime = _tire getVariable ["brpvp_tire_cantSafeTime",0];
	_isRaidTraining = _tire getVariable ["brpvp_rto_real_vehicle",false];
	if (_idBd isNotEqualTo -1) then {
		_class = configName (_tire getVariable "brpvp_tire_nameCFG");
		if (_class in BRPVP_disableVehUseList && !BRPVP_vePlayers) then {
			"erro" call BRPVP_playSound;
			[localize "str_veh_disabled_day",-6] call BRPVP_hint;
			sleep 1;
		} else {
			private _t = 2;
			{if (_class isEqualTo (_x select 0)) exitWith {_t = _x select 1;};} forEach BRPVP_tireExtraGetTime;
			[player,["from_magus",300]] remoteExecCall ["say3D",BRPVP_allNoServer];
			sleep _t;
			[_idBd,_VGTime,_kills,_cantSafeTime,_isRaidTraining,clientOwner,player,_t] remoteExecCall ["BRPVP_tireServerGetVeh",2];
		};
	} else {
		"erro" call BRPVP_playSound;
		sleep 1;
	};
	BRPVP_actionRunning = BRPVP_actionRunning-[37];
};
BRPVP_avoidTurretCollision = {
	private _min = 30/3.6;
	private _max = 60/3.6;
	waitUntil {
		private _veh = objectParent player;
		private _nearVehs = [];
		private _draw = false;
		if (!isNull _veh && {currentPilot _veh isEqualTo player}) then {
			private _vel = velocity _veh;
			private _mag = vectorMagnitude _vel;
			private _vPts = _veh call BRPVP_getPlaneVertices;
			private _mult = 1-((_mag max _min min _max)-_min)/(_max-_min);
			_nearVehs = nearestObjects [_veh,["StaticWeapon"],15-7.5*_mult]-[_veh];
			_nearVehs = (_nearVehs apply {if (_x call BRPVP_checaAcesso || [_x,player] call BRPVP_checkIfTurretIsFriendByFlag || count crew _x isEqualTo 0) then {-1} else {_x};})-[-1];
			private _near = false;
			{
				private _obj = _x;
				{if ([_x,_obj] call PDTH_distance2BoxPos < 3) exitWith {_near = true;};} forEach _vPts;
				if (_near) exitWith {
					_vec = getPosWorld _veh vectorDiff getPosWorld _obj;
					_vec set [2,0];
					_vec = vectorNormalized _vec vectorMultiply 4;
					_vec set [2,2];
					[_veh,_vec] remoteExecCall ["setVelocity",0];
				};
			} forEach _nearVehs;
			if (_nearVehs isEqualTo []) then {
				if (_veh getVariable ["brpvp_stop",false]) then {_veh setVariable ["brpvp_stop",false];};
			} else {
				if !(_veh getVariable ["brpvp_stop",false]) then {
					_veh setPosASL getPosASL _veh;
					_veh engineOn false;
					_veh setVariable ["brpvp_stop",true];
				} else {
					if (_mag > 35/3.6) then {
						_t = 1/diag_fps;
						[_veh,vectorNormalized _vel vectorMultiply (0.7*35/3.6)] remoteExecCall ["setVelocity",0];
					};
				};
				private _oToDraw = _nearVehs+[_veh];
				private _drawCoords = [_oToDraw,2,[1,1,0,1]] call BRPVP_getCubeDrawCoords;
				{{drawLine3D _x;} forEach (_x select 1);} forEach _drawCoords;
			};
		};
		isNull _veh
	};
};
BRPVP_clientStillSurrendedCheck = {
	BRPVP_walkDisabled = true;
	BRPVP_menuExtraLigado = false;
	hintSilent "";
	if (!isNull findDisplay 602) then {closeDialog 602;};
	[player,"AmovPercMstpSsurWnonDnon"] remoteExec ["switchMove",0];
	BRPVP_actionDropItems = player addAction ["<t color='#CC0000'>"+localize "str_surr_drop_items"+"</t>","client_code\actions\actionSurrenderDropItems.sqf","",50,true,true];
	waitUntil {isNull (player getVariable ["brpvp_surrendedBy",objNull])};
	player removeAction BRPVP_actionDropItems;
	[player,""] remoteExecCall ["switchMove",0];
	BRPVP_walkDisabled = false;
};
BRPVP_rapel = {
	_heli = _this select 3;
	moveOut player;
	waitUntil {isNull objectParent player};
	if (ASLToAGL getPosASL player select 2 < 105) then {
		player setPosASL (getPosASL player vectorAdd [0,0,1000]);
		sleep 0.001;
		player setPosASL (getPosASL player vectorAdd [0,0,-1000]);
	};
	_a = random 360;
	_can = "Land_Can_V3_F" createVehicle [0,0,0];
	_can setPosASL AGLToASL (player modelToWorld [0,0,0]);
	player attachTo [_can,[0,0,-0.25]];
	_rope = ropeCreate [_heli,[0.8*sin _a,0.8*cos _a,-0.8],_can,[0,0,0.25],10];
	player setVariable ["brpvp_rapel_rope",_rope,[clientOwner,2]];
	player setVariable ["brpvp_rapel_can",_can,[clientOwner,2]];
	[localize "str_heli_rapel_warning",-5] call BRPVP_hint;
	[localize "str_a_player_is_rapelling",-5] remoteExecCall ["BRPVP_hint",_heli];
	[_heli,_rope,_can,_actId] spawn {
		params ["_heli","_rope","_can","_actId"];
		[[_rope,5,50,true]] remoteExecCall ["ropeUnwind",0];
		waitUntil {isNull ropeAttachedTo _can || vectorMagnitude velocity _heli > 10 || !alive _heli || position player select 2 < 0.5 || !(player call BRPVP_pAlive)};
		ropeDestroy _rope;
		deleteVehicle _can;
	};
};
BRPVP_checkIfNewFlagAllowed = {
	params ["_player","_flag"];
	private _id = _player getVariable ["id_bd",-1];
	private _found = [];
	{if ((_x getVariable "own") isEqualTo _id) then {_found pushBack _x;};} forEach BRPVP_allFlags;
	_found = _found apply {_x getVariable ["brpvp_flag_radius",0]};
	_found pushBack (_flag call BRPVP_getFlagRadius);
	_found sort true;
	_found in BRPVP_flagCombinationAllowed
};
BRPVP_labSpotNoMovePlayers = {
	if (BRPVP_labNoThirdPerson isEqualTo [] || {player distance (BRPVP_labNoThirdPerson select 0 select 0) > (BRPVP_labNoThirdPerson select 0 select 1)}) then {
		if (_labIsOn) then {
			{
				private _arrow = _x getVariable ["brpvp_lab_arrow",objNull];
				detach _arrow;
				deleteVehicle _arrow;
				_x setVariable ["brpvp_last_pos",[]];
			} forEach _labSpoted;
			_labSpoted = [];
			_labIsOn = false;
		};
	} else {
		_labIsOn = true;
		(BRPVP_labNoThirdPerson select 0) params ["_pos","_rad"];
		private _inside = _pos nearEntities [BRPVP_playerModel,_rad];
		_inside = _inside apply {if (isObjectHidden _x) then {-1} else {_x};};
		_inside = _inside-[-1];
		{
			private _pLast = _x getVariable ["brpvp_last_pos",[]];
			private _pNow = getPosWorld _x;
			private _count = 0;
			{if (vectorMagnitude (_pNow vectorDiff _x) < 5) then {_count = _count+1};} forEach _pLast;
			if (_count >= 10) then {
				if !(_x in _labSpoted) then {
					private _arrow = createSimpleobject ["Sign_Arrow_Large_Green_F",[0,0,0],true];
					_arrow attachTo [_x,[0,0,12.5]];
					_labSpoted pushBack _x;
					_x setVariable ["brpvp_lab_arrow",_arrow];
				};
			} else {
				if (_x in _labSpoted) then {
					private _arrow = _x getVariable ["brpvp_lab_arrow",objNull];
					detach _arrow;
					deleteVehicle _arrow;
					_x setVariable ["brpvp_last_pos",[]];
					_labSpoted deleteAt (_labSpoted find _x);
				};
			};
			_pLast pushBack _pNow;
			if (count _pLast > 20) then {_pLast deleteAt 0;};
			_x setVariable ["brpvp_last_pos",_pLast];
		} forEach _inside;
		{
			if !(_x in _inside) then {
				private _arrow = _x getVariable ["brpvp_lab_arrow",objNull];
				detach _arrow;
				deleteVehicle _arrow;
				_x setVariable ["brpvp_last_pos",[]];
				_labSpoted deleteAt (_labSpoted find _x);
			}; 
		} forEach +_labSpoted;
	};
};
BRPVP_showPatrimonyCloseSpec = {
	findDisplay 10710 closeDisplay 2;
};
BRPVP_showPatrimonySpec = {
	params ["_typeIdx","_rulesPageNow"];
	if (!isNull findDisplay 10710) then {findDisplay 10710 closeDisplay 2;};
	disableSerialization;
	_display = findDisplay 46 createDisplay "BRPVP_XP";
	_patrimonyRank = BRPVP_playersPatrimony apply {[_x select _typeIdx,_x]};
	_patrimonyRank sort false;
	_count = 0;
	_patrimonyRank = _patrimonyRank apply {_count=_count+1;format ["<t color='#FF6060'>TOP %1</t> - <t color='#D0D040'>$%2</t> - %3",_count,(_x select 1 select _typeIdx) call BRPVP_formatNumber,_x select 1 select 1]};
	private _c = count _patrimonyRank;
	private _cNew = 20*ceil ((_c max 1)/20);
	private _rulesList = _patrimonyRank;
	for "_i" from _c to (_cNew-1) do {_rulesList set [_i,""];};			
	_rulesList = _rulesList select [_rulesPageNow*20,20];
	private _lines = count _rulesList;
	{
		_id = 79866+_forEachIndex;
		_display ctrlCreate ["RscStructuredText",_id];
		(_display displayCtrl _id) ctrlSetPosition [0,_forEachIndex * 0.95/_lines,1,0.85/_lines];
		(_display displayCtrl _id) ctrlSetBackgroundColor ([[0.5,0.5,0.5,0.8],[0.7,0.7,0.7,0.8]] select (_forEachIndex mod 2));
		(_display displayCtrl _id) ctrlSetStructuredText parseText ("<t color='#FFFFFF' align='center'>"+_x+"</t>");
		(_display displayCtrl _id) ctrlCommit 0;

	} forEach _rulesList;
	_id1 = 79866+_lines;
	_id2 = _id1+1;
	_display ctrlCreate ["RscButton",_id1];
	(_display displayCtrl _id1) ctrlSetPosition [0,0.95,0.2,0.05];
	(_display displayCtrl _id1) ctrlSetText "Ok";
	(_display displayCtrl _id1) ctrlCommit 0;
	_display ctrlCreate ["RscButton",_id2];
	(_display displayCtrl _id2) ctrlSetPosition [0,0,0,0];
	(_display displayCtrl _id2) ctrlSetText localize "str_rules_not_accept";
	(_display displayCtrl _id2) ctrlCommit 0;
	_id3 = _id2+1;
	_id4 = _id3+1;
	_id5 = _id4+1;
	_display ctrlCreate ["RscButton",_id3];
	(_display displayCtrl _id3) ctrlSetPosition [0.37,0.95,0.1,0.05];
	(_display displayCtrl _id3) ctrlSetText "<<";
	(_display displayCtrl _id3) ctrlCommit 0;
	_display ctrlCreate ["RscButton",_id4];
	(_display displayCtrl _id4) ctrlSetPosition [0.53,0.95,0.1,0.05];
	(_display displayCtrl _id4) ctrlSetText ">>";
	(_display displayCtrl _id4) ctrlCommit 0;
	_display ctrlCreate ["RscStructuredText",_id5];
	(_display displayCtrl _id5) ctrlSetPosition [0.475,0.95,0.05,0.05];
	(_display displayCtrl _id5) ctrlSetBackgroundColor [0,0,0,0.6];
	(_display displayCtrl _id5) ctrlSetStructuredText parseText format ["<t align='center'>%1</t>",_rulesPageNow+1];
	(_display displayCtrl _id5) ctrlCommit 0;
};
BRPVP_showPatrimony = {
	"admin_msg" call BRPVP_playSound;
	BRPVP_rulesPage = 0;
	BRPVP_rulesOk = nil;
	disableSerialization;
	_display = findDisplay 46 createDisplay "RscDisplayEmpty";
	while {isNil "BRPVP_rulesOk" && !isNull _display && (player call BRPVP_pAlive && player getVariable ["sok",false])} do {
		["",0,0,0,0,0,9959] call BRPVP_fnc_dynamicText;
		_patrimonyRank = BRPVP_playersPatrimony apply {[_x select _this,_x]};
		_patrimonyRank sort false;
		_count = 0;
		_patrimonyRank = _patrimonyRank apply {_count=_count+1;format ["<t color='#FF6060'>TOP %1</t> - <t color='#D0D040'>$%2</t> - %3",_count,(_x select 1 select _this) call BRPVP_formatNumber,_x select 1 select 1]};
		private _c = count _patrimonyRank;
		private _cNew = 20*ceil ((_c max 1)/20);
		private _rulesList = _patrimonyRank;
		for "_i" from _c to (_cNew-1) do {_rulesList set [_i,""];};			
		BRPVP_rulesPage = (BRPVP_rulesPage max 0) min ((_cNew/20)-1);
		_rulesPageNow = BRPVP_rulesPage;
		_rulesList = _rulesList select [BRPVP_rulesPage*20,20];
		private _lines = count _rulesList;
		{
			_id = 79866+_forEachIndex;
			_display ctrlCreate ["RscStructuredText",_id];
			(_display displayCtrl _id) ctrlSetPosition [0,_forEachIndex * 0.95/_lines,1,0.85/_lines];
			(_display displayCtrl _id) ctrlSetBackgroundColor ([[0.5,0.5,0.5,0.8],[0.7,0.7,0.7,0.8]] select (_forEachIndex mod 2));
			(_display displayCtrl _id) ctrlSetStructuredText parseText ("<t color='#FFFFFF' align='center'>"+_x+"</t>");
			(_display displayCtrl _id) ctrlCommit 0;

		} forEach _rulesList;
		_id1 = 79866+_lines;
		_id2 = _id1+1;
		_display ctrlCreate ["RscButton",_id1];
		(_display displayCtrl _id1) ctrlSetPosition [0,0.95,0.2,0.05];
		(_display displayCtrl _id1) ctrlSetText "Ok";
		(_display displayCtrl _id1) ctrlCommit 0;
		(_display displayCtrl _id1) ctrlAddEventHandler ["ButtonClick",{BRPVP_rulesOk = true;}];
		_display ctrlCreate ["RscButton",_id2];
		(_display displayCtrl _id2) ctrlSetPosition [0,0,0,0];
		(_display displayCtrl _id2) ctrlSetText localize "str_rules_not_accept";
		(_display displayCtrl _id2) ctrlCommit 0;
		(_display displayCtrl _id2) ctrlAddEventHandler ["ButtonClick",{BRPVP_rulesOk = false;}];
		_id3 = _id2+1;
		_id4 = _id3+1;
		_id5 = _id4+1;
		_display ctrlCreate ["RscButton",_id3];
		(_display displayCtrl _id3) ctrlSetPosition [0.37,0.95,0.1,0.05];
		(_display displayCtrl _id3) ctrlSetText "<<";
		(_display displayCtrl _id3) ctrlCommit 0;
		(_display displayCtrl _id3) ctrlAddEventHandler ["ButtonClick",{BRPVP_rulesPage = BRPVP_rulesPage-1;}];
		_display ctrlCreate ["RscButton",_id4];
		(_display displayCtrl _id4) ctrlSetPosition [0.53,0.95,0.1,0.05];
		(_display displayCtrl _id4) ctrlSetText ">>";
		(_display displayCtrl _id4) ctrlCommit 0;
		(_display displayCtrl _id4) ctrlAddEventHandler ["ButtonClick",{BRPVP_rulesPage = BRPVP_rulesPage+1;}];
		_display ctrlCreate ["RscStructuredText",_id5];
		(_display displayCtrl _id5) ctrlSetPosition [0.475,0.95,0.05,0.05];
		(_display displayCtrl _id5) ctrlSetBackgroundColor [0,0,0,0.6];
		(_display displayCtrl _id5) ctrlSetStructuredText parseText format ["<t align='center'>%1</t>",BRPVP_rulesPage+1];
		(_display displayCtrl _id5) ctrlCommit 0;

		//SEND TO SPEC
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_this,_rulesPageNow] remoteExec ["BRPVP_showPatrimonySpec",BRPVP_specOnMeMachinesNoMe];};

		waitUntil {!isNil "BRPVP_rulesOk" || !(BRPVP_rulesPage isEqualTo _rulesPageNow) || isNull _display || !(player call BRPVP_pAlive && player getVariable ["sok",false])};
		for "_i" from 79866 to _id5 do {ctrlDelete (_display displayCtrl _i);};
	};
	if (!isNull _display) then {_display closeDisplay 1;};

	//SEND TO SPEC
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_showPatrimonyCloseSpec",BRPVP_specOnMeMachinesNoMe];};

	if (player call BRPVP_pAlive && player getVariable ["sok",false]) then {
		hintSilent parseText "<t align='center' size='1.65'>PLEASE WAIT...</t>";
		sleep 0.5;
		148 call BRPVP_iniciaMenuExtra;
	};
};
BRPVP_pilotCoPilotEject = {
	_veh = objectParent player;
	_locked = _veh getVariable ["brpvp_locked",false];
	if (!isNull _veh && !_locked) then {
		if (player getVariable ["brpvp_no_custom_eject",false]) then {"erro" call BRPVP_playSound;} else {moveOut player;};
	} else {
		[localize "str_no_access_locked",3,10,677,"erro"] call BRPVP_hint;
	};
};
BRPVP_baseTestTurnOff = {
	player removeAction (_this select 2);
	BRPVP_baseTestAction = -1;
	player setVariable ["brpvp_base_test",2,true];
	sleep 5;
	player setVariable ["brpvp_base_test",0,true];
};
BRPVP_uniformCheck = {
	_uniform = uniform player;
	if !(_uniform isEqualTo "") then {
		_gear = uniformContainer player call BRPVP_getCargoArray;
		removeUniform player;
		player addUniform _uniform;
		[uniformContainer player,_gear] call BRPVP_putItemsOnCargo;
	};
};
BRPVP_linksShowAccess = {
	if (isNil "BRPVP_LinkDisplayOpen" || {!BRPVP_LinkDisplayOpen}) then {
		private _id = player getVariable ["id_bd",""];
		disableSerialization;
		BRPVP_LinkDisplayOpen = true;
		_display = findDisplay 46 createDisplay "RscDisplayEmpty";
		_display displayAddEventHandler ["keyDown",{
			_key = _this select 1;
			!(_key in BRPVP_notBlockedKeys || _key in [0x39])
		}];
		_ctrl = _display ctrlCreate ["RscStructuredText",-1];
		_q = count BRPVP_linksUrlsAccess;
		_ctrl ctrlSetPosition [0,0,1,(_q+1)*0.1225/3];
		_ctrl ctrlSetBackgroundColor [0,0,0,0.5];
		_colors = ["#FF0000","#00FF00","#0000FF","#FFFF00","#FF00FF","#00FFFF"];
		_txt = "<t>Seu tempo de jogo acabou, anote seu BRPVP-ID abaixo e adquira mais tempo neste link:</t><br/>";
		{
			_linkPure = _x select 1;
			_link = if (_linkPure isEqualType {}) then {call _linkPure} else {_linkPure};
			_txt = _txt+format ["<t color='%1'>%2</t> <a href='%3'>%4</a><br/>",_colors select (_forEachIndex mod count _colors),_x select 0,_link,_x select 2];
		} forEach BRPVP_linksUrlsAccess;
		_ctrl ctrlSetStructuredText parseText _txt;
		_ctrl ctrlCommit 0;
		_okButton = _display ctrlCreate ["RscButton",-1];
		_okButton ctrlSetPosition [0,(_q+1)*0.1225/3+0.03,0.15,0.065];
		_okButton ctrlSetText "Ok";
		_okButton ctrlAddEventHandler ["ButtonClick",{BRPVP_LinkDisplayOpen = false;}];
		_okButton ctrlCommit 0;
		_init = time;
		waitUntil {!BRPVP_LinkDisplayOpen || isNull _ctrl || time-_init > 60};
		BRPVP_LinkDisplayOpen = false;
		if (!isNull _display) then {_display closeDisplay 1;};
		endMission "NoPlayTime";
	};
};
BRPVP_noVehCollisionCode = {
	waitUntil {
		if (!BRPVP_nitroFlyOn) then {
			private _veh = objectParent player;
			private _nearVehs = [];
			if (!isNull _veh && {_veh isKindOf "LandVehicle"}) then {
				private _vPts = _veh call BRPVP_getPlaneVertices;
				_nearVehs = nearestObjects [_veh,["Air","Car","Motorcycle","Tank"],15]-[_veh];
				_vel = velocity _veh;
				_mag = vectorMagnitude _vel;
				if (_mag > 10/3.6) then {
					private _near = false;
					{
						private _obj = _x;
						{if ([_x,_obj] call PDTH_distance2BoxPos < 1.5) exitWith {_near = true;};} forEach _vPts;
						if (_near) exitWith {
							_vec = getPosWorld _veh vectorDiff getPosWorld _obj;
							_vec set [2,0];
							_vec = vectorNormalized _vec vectorMultiply 4;
							_vec set [2,2];
							[_veh,_vec] remoteExecCall ["setVelocity",0];
						};
					} forEach _nearVehs;
				};
				if (_mag > 35/3.6) then {
					_t = 1/diag_fps;
					[_veh,_vel vectorMultiply 0.7] remoteExecCall ["setVelocity",0];
				};
			};
			private _oToDraw = if (_nearVehs isEqualTo []) then {[]} else {_nearVehs+[_veh]};
			private _drawCoords = [_oToDraw,2,[0,0,1,1]] call BRPVP_getCubeDrawCoords;
			{{drawLine3D _x;} forEach (_x select 1);} forEach _drawCoords;
		};
		!BRPVP_safeZone
	};
};
BRPVP_showDrawPlayer = {
	for "_i" from 1 to 6 do {systemChat _this;};
	"achou_loot" call BRPVP_playSound;
};
BRPVP_nearIdentifiedPlayersLoop = {
	private _nearIdentifiedPlayers = [];
	private _fovTest = getObjectFov BRPVP_myPlayerOrSpecOrDrone;
	private _distNP = 25*0.75/([_fovTest,0.75] select (_fovTest isEqualTo 0));
	private _toCheck = [];
	if (BRPVP_spectateOn) then {
		private _newersInside = ((BRPVP_newerPlayers-[BRPVP_spectedPlayer]) apply {if (_x distance BRPVP_myPlayerOrSpecOrDrone < _distNP) then {_x} else {-1}})-[-1];
		_toCheck = ((((BRPVP_myPlayerOrSpecOrDrone nearEntities [BRPVP_playerModel,_distNP])-BRPVP_newersDiscovered)+BRPVP_newersDiscovered)-_newersInside)+_newersInside;
		_toCheck = _toCheck-((units group BRPVP_spectedPlayer)+BRPVP_specMeusAmigosObj+BRPVP_specPveFriends);
	} else {
		private _newersInside = ((BRPVP_newerPlayers-[player]) apply {if (_x distance BRPVP_myPlayerOrSpecOrDrone < _distNP) then {_x} else {-1}})-[-1];
		_toCheck = ((((BRPVP_myPlayerOrSpecOrDrone nearEntities [BRPVP_playerModel,_distNP])-BRPVP_newersDiscovered)+BRPVP_newersDiscovered)-_newersInside)+_newersInside;
		_toCheck = _toCheck-((units group player)+BRPVP_meusAmigosObj+BRPVP_pveFriends);
	};
	{
		private _np = _x;
		private _protected = (headGear _np in BRPVP_headGearNoIdentify || {goggles _np find _x isNotEqualTo -1} count BRPVP_gogglesNoIdentifyStrings > 0 || isObjectHidden _np) && !(_np in BRPVP_newerPlayers);
		if (!_protected) then {_nearIdentifiedPlayers pushBack _np;};
	} forEach _toCheck;
	BRPVP_nearIdentifiedPlayers = +_nearIdentifiedPlayers;
};
BRPVP_baseBombCalcVisibleLines = {
	private _baseBombDrawLines = [];
	private _baseBombDrawLinesGreen = [];
	private _visPos = positionCameraToWorld [0,0,0];
	{
		if ((_x select 0) distanceSqr _visPos < 5625) then {
			if ((_x select 3) isEqualTo "red") exitWith {_baseBombDrawLines append (_x select 1);};
			_baseBombDrawLinesGreen append (_x select 1);
		};
	} forEach BRPVP_baseBombDestroyedLinesSemiFar;
	BRPVP_baseBombDrawLines = _baseBombDrawLines;
	BRPVP_baseBombDrawLinesGreen = _baseBombDrawLinesGreen;
};
BRPVP_baseBombCalcVisibleLinesSemiFar = {
	private _visPos = positionCameraToWorld [0,0,0];
	BRPVP_baseBombDestroyedLinesSemiFar = BRPVP_baseBombDestroyedLinesFar select {(_x select 0) distanceSqr _visPos < 22500};
};
BRPVP_baseBombCalcVisibleLinesFar = {
	private _visPos = positionCameraToWorld [0,0,0];
	BRPVP_baseBombDestroyedLinesFar = BRPVP_baseBombDestroyedLines select {(_x select 0) distanceSqr _visPos < 250000};
};
BRPVP_spcItemsGet = {
	BRPVP_menuVar1 = _this select 3;
	BRPVP_menuVar2 = false;
	134 call BRPVP_iniciaMenuExtra;
};
BRPVP_showGoodLootOnMapPut = {
	{if (!isNull _x) then {BRPVP_extraIcons pushBack ["GLB",_x,"GLOOT",[0.5,0,0,1],"mil_dot.paa","",BRPVP_iSizeMilDot];};} forEach BRPVP_goodLootBuildingList;
	BRPVP_showGoodLootOnMap = true;
};
BRPVP_showGoodLootOnMapRemove = {
	{if ((_x select 0) isEqualTo "GLB") then {BRPVP_extraIcons set [_forEachIndex,-1];};} forEach BRPVP_extraIcons;
	BRPVP_extraIcons = BRPVP_extraIcons-[-1];
	BRPVP_showGoodLootOnMap = false;
};
BRPVP_applyPlayerConfig = {
	params ["_viewDist","_viewDistAir","_c4On3d","_terrainQuality","_nature","_crosshair","_hotKeys","_cfg8"];

	//CROSSHAIR
	if (_crosshair isEqualTo true) then {BRPVP_crosshairOn = true;} else {BRPVP_crosshairOn = false;};

	//NATURE EFFECTS
	if (_nature isEqualTo 0 || _nature isEqualTo true) then {enableEnvironment true;} else {enableEnvironment false;};

	//ON FOOT VIEW DISTANCE
	_idx = BRPVP_viewDistList find _viewDist;
	_idx = if (_idx isEqualTo -1) then {5} else {_idx};
	BRPVP_viewDist = BRPVP_viewDistList select _idx;
	BRPVP_viewObjsDist = BRPVP_viewObjsDistList select _idx;
	setViewDistance BRPVP_viewDist;
	setObjectViewDistance BRPVP_viewObjsDist;
	player setVariable ["brpvp_vd",BRPVP_viewDist,2];

	//FLYING VIEW DISTANCE
	_idx = BRPVP_viewDistListFly find _viewDistAir;
	_idx = if (_idx isEqualTo -1) then {5} else {_idx};
	BRPVP_viewDistFly = BRPVP_viewDistListFly select _idx;
	BRPVP_viewObjsDistFly = BRPVP_viewObjsDistListFly select _idx;

	//CTRL+4 ON 3D SCREEN
	BRPVP_ctrl4On3dDistance = _c4On3d;
	
	//TERRAIN QUALITY
	if (_terrainQuality isEqualType "") then {_terrainQuality = [_terrainQuality,BRPVP_useTerrainDynamicResolution];};
	if (_terrainQuality isEqualType []) then {
		_terrainQuality params ["_quality","_dynamic"];
		private _cfgQuality = BRPVP_terrainGridConfig select 1 select 1;
		{if (_x select 0 isEqualTo _quality) exitWith {_cfgQuality = _x select 1;};} forEach BRPVP_terrainGridConfig;
		BRPVP_useTerrainDynamicResolution = _dynamic;
		if (_dynamic) then {
			BRPVP_terrainGrid = _cfgQuality select 0;
			BRPVP_terrainGridLook = _cfgQuality select 1;
			BRPVP_terrainGridOnZoom = _cfgQuality select 2;
		} else {
			BRPVP_terrainGrid = _cfgQuality select 0;
			BRPVP_terrainGridLook = _cfgQuality select 0;
			BRPVP_terrainGridOnZoom = _cfgQuality select 0;
		};
	};

	//HOTKEYS
	if (_hotKeys isEqualType []) then {BRPVP_itemsHotkeys = _hotKeys;};
};
BRPVP_giveZombieMoneyLocal = {
	player setVariable ["mny",(player getVariable "mny")+BRPVP_zombieKillRewardBase*BRPVP_missionValueMult*_this,true];
};
BRPVP_groups2DIcons = [];
BRPVP_groups2DIconsTime = 0;
BRPVP_groupArrayByDistanceMultiple2D = {
	params ["_center","_scale","_data"];
	private _t = time;
	if (_t-BRPVP_groups2DIconsTime > 1) then {
		BRPVP_groups2DIconsTime = _t;
		BRPVP_groups2DIcons = [];
		private _mainArray = [];
		{
			_x params ["_enabled","_joinDist","_objs","_condition","_iconInfo"];
			if (_enabled) then {
				private _distRef = (_joinDist*_scale)^2;
				{if (_x call _condition) then {_mainArray pushBack [_x,_iconInfo,_distRef];};} forEach (_objs-[objNull]);
			};
		} forEach _data;
		if (count _mainArray > 0) then {
			private _first = _mainArray select 0 select 0;
			private _firstDR = _mainArray select 0 select 2;
			private _group = [];
			private _remove = [];
			while {count _mainArray > 0} do {
				if (_firstDR isEqualTo 0) then {
					_group pushBack (_mainArray deleteAt 0);
				} else {
					{
						_x params ["_obj","_iconInfo","_distRef"];
						if (_obj distanceSqr _first <= _distRef || isNull _obj) then {
							_group pushBack _x;
							_remove pushBack _x;
						};
					} forEach _mainArray;
					_mainArray = _mainArray-_remove;
				};
				BRPVP_groups2DIcons pushBack [_first,_group];
				if (count _mainArray > 0) then {
					_first = _mainArray select 0 select 0;
					_firstDR = _mainArray select 0 select 2;
					_group = [];
					_remove = [];
				};
			};
		};
	};
	private _return = [];
	{
		_x params ["_obj","_group"];
		if !(isNull _obj || _group isEqualTo []) then {
			private _count = count _group;
			(_group select (BRPVP_countSecs mod _count)) params ["_objName","_iconInfo"];
			private _iconInfo2 = +_iconInfo;
			_iconInfo2 set [2,getPosWorldVisual _obj];
			_iconInfo2 set [6,if (_iconInfo2 select 6 isEqualTo "xOff") then {""} else {[_count,_objName getVariable ["nm","(...)"],_obj distance _center] call BRPVP_txtIconCreate}];
			_return pushBack _iconInfo2;
		};
	} forEach BRPVP_groups2DIcons;
	_return
};
BRPVP_groups3DIcons = [];
BRPVP_groups3DIconsTime = 0;
BRPVP_groupArrayByDistanceMultiple3D = {
	params ["_center","_data"];
	private _fov = getObjectFov _center;
	private _tm = diag_tickTime;
	if (_tm-BRPVP_groups3DIconsTime > 1) then {
		BRPVP_groups3DIconsTime = _tm;
		BRPVP_groups3DIcons = [];
		private _mainArray = [];
		{
			_x params ["_enabled","_joinMult","_objs","_condition","_iconInfo","_showBui"];
			if (_enabled) then {
				private _fovDistMult = ((_fov/0.75)*_joinMult)^2;
				if (_showBui) then {
					{if (_x call _condition) then {_mainArray pushBack [_x,_iconInfo,_fovDistMult,_x getVariable ["bdg",false]];};} forEach (_objs-[objNull]);
				} else {
					{if (_x call _condition) then {_mainArray pushBack [_x,_iconInfo,_fovDistMult,false];};} forEach (_objs-[objNull]);
				};
			};
		} forEach _data;
		if (_mainArray isNotEqualTo []) then {
			private _first = _mainArray select 0 select 0;
			private _firstFDM = _mainArray select 0 select 2;
			private _distRef = (_first distance _center)^2;
			private _group = [];
			private _remove = [];
			while {_mainArray isNotEqualTo []} do {
				if (_firstFDM isEqualTo 0) then {
					_group pushBack (_mainArray deleteAt 0);
				} else {
					{
						_x params ["_obj","_iconInfo","_fovDistMult","_isBdg"];
						private _distRefToJoin = _distRef*_fovDistMult;
						if (_obj distanceSqr _first <= _distRefToJoin || isNull _obj) then {
							_group pushBack _x;
							_remove pushBack _x;
						};
					} forEach _mainArray;
					_mainArray = _mainArray-_remove;
				};
				BRPVP_groups3DIcons pushBack [_first,_group];
				if (_mainArray isNotEqualTo []) then {
					_first = _mainArray select 0 select 0;
					_firstFDM = _mainArray select 0 select 2;
					_distRef = (_first distance _center)^2;
					_group = [];
					_remove = [];
				};
			};
		};
	};
	{
		_x params ["_obj","_group"];
		if !(isNull _obj || _group isEqualTo []) then {
			private _count = count _group;
			private _fTxt = "";
			(_group select (BRPVP_countSecs mod _count)) params ["_objName","_iconInfo","_fovDistMult","_isBdg"];
			private _iconInfo2 = +_iconInfo;
			if (_iconInfo2 select 6 isEqualTo "xOff") then {
				_iconInfo2 set [2,(_obj modelToWorldVisual (_obj selectionPosition "head")) vectorAdd [0,0,0.75+(_obj distance _center)*0.015*(_fov/0.75)]];
				_iconInfo2 set [6,""];
				if (_isBdg) then {_iconInfo2 set [0,BRPVP_missionRoot+"BRP_imagens\icones3d\working.paa"];};
			} else {
				_iconInfo2 set [2,(_obj modelToWorldVisual (_obj selectionPosition "head")) vectorAdd [0,0,0.50+(_obj distance _center)*0.035*(_fov/0.75)]];
				_fTxt = [_count,_objName getVariable ["nm","(...)"],_obj distance _center] call BRPVP_txtIconCreate;
				if (_isBdg) then {_iconInfo2 set [0,BRPVP_missionRoot+"BRP_imagens\icones3d\working.paa"];};
			};
			drawIcon3D _iconInfo2;
			_iconInfo2 set [0,""];
			_iconInfo2 set [1,[0,0.8,0,1]];
			_iconInfo2 set [6,_fTxt];
			drawIcon3D _iconInfo2;
		};
	} forEach BRPVP_groups3DIcons;
};
BRPVP_groupArrayByDistanceArray = [[],[],[],[],[],[],[],[]];
BRPVP_groupArrayByDistanceLast = [[],[],[],[],[],[],[],[]];
BRPVP_groupArrayByDistanceCycle = [2,2,2,2,2,2,2,2];
BRPVP_groupArrayByDistanceTime = [0,0,0,0,0,0,0,0];
BRPVP_groupArrayByDistance = {
	params ["_idx","_array","_percDist","_center",["_check",{true}],["_get",{_this}]];
	private ["_arrayGrp","_o1","_distToGroup","_group","_fov","_u","_dist","_name","_pos","_c","_vec"];
	_timeOk = time-(BRPVP_groupArrayByDistanceTime select _idx) > (BRPVP_groupArrayByDistanceCycle select _idx);
	_arrayChanged = (BRPVP_groupArrayByDistanceLast select _idx) isNotEqualTo _array;
	_fov = getObjectFov BRPVP_myPlayerOrSpec;
	if (_timeOk || _arrayChanged) then {
		if (_arrayChanged) then {BRPVP_groupArrayByDistanceLast set [_idx,_array];};
		BRPVP_groupArrayByDistanceTime set [_idx,time+random 0.1];
		if (_check isNotEqualTo {true}) then {
			_array = _array apply {if (_x call _check) then {_x} else {-1}};
			_array = _array-[-1];
		};
		_percDist = _percDist*(_fov/0.75);
		_arrayGrp = [];
		if (_get isEqualTo {_this}) then {
			while {_array isNotEqualTo []} do {
				_o1 = _array select 0;
				_distToGroup = (_percDist*(_o1 distance _center))^2;
				_group = [];
				{if (_o1 distanceSqr _x <= _distToGroup) then {_group pushBack _x};} forEach _array;
				_array = _array-_group;
				_arrayGrp pushBack _group;
			};
		} else {
			while {_array isNotEqualTo []} do {
				_o1 = (_array select 0) call _get;
				_distToGroup = (_percDist*(_o1 distance _center))^2;
				_group = [];
				{if (_o1 distanceSqr (_x call _get) < _distToGroup) then {_group pushBack _x;};} forEach _array;
				_array = _array-_group;
				_arrayGrp pushBack _group;
			};
		};
		BRPVP_groupArrayByDistanceArray set [_idx,_arrayGrp-[[]]];
	};
	if (_get isEqualTo {_this}) then {
		(BRPVP_groupArrayByDistanceArray select _idx) apply {
			if (count _x isEqualTo 1) then {
				_u = _x select 0;
				_dist = _u distance _center;
				_pos = _u modelToWorldVisual (_u selectionPosition "head");
				[1,_dist,_u getVariable ["nm",""],_pos vectorAdd [0,0,0.50+_dist*0.035*(_fov/0.75)],_u]
			} else {
				_c = count _x;
				_vec = [0,0,0];
				{_vec = _vec vectorAdd getPosWorldVisual _x;} forEach _x;
				_vec = ASLToAGL (_vec vectorMultiply (1/_c));
				_dist = _vec distance _center;
				_u = _x select (BRPVP_countSecs mod _c);
				[_c,_dist,_u getVariable ["nm",""],_vec vectorAdd [0,0,1.80+(0.20+_dist*0.035*(_fov/0.75))],_u]
			};
		};
	} else {
		(BRPVP_groupArrayByDistanceArray select _idx) apply {
			if (count _x isEqualTo 1) then {
				_u = _x select 0;
				_pos = _u call _get;
				_dist = _pos distance _center;
				[1,_dist,_u getVariable ["nm",""],_pos,_u]
			} else {
				_c = count _x;
				_vec = [0,0,0];
				{_vec = _vec vectorAdd AGLToASL (_x call _get);} forEach _x;
				_vec = ASLToAGL (_vec vectorMultiply (1/_c));
				_dist = _vec distance _center;
				_u = _x select (BRPVP_countSecs mod _c);
				[_c,_dist,_u getVariable ["nm",""],_vec,_u]
			};
		};
	};
};
BRPVP_txtIconCreate = {
	params ["_q","_name","_dist"];
	if (_q isEqualTo 1) then {
		if (_dist < 1000) then {
			if (_name isEqualTo "") then {format ["%1m",round _dist]} else {format ["%1 %2m",_name,round _dist]};
		} else {
			if (_name isEqualTo "") then {format ["%1km",(round (_dist/100))/10]} else {format ["%1 %2km",_name,(round (_dist/100))/10]};
		};
	} else {
		if (_dist < 1000) then {
			if (_name isEqualTo "") then {format ["%1X %2m",_q,round _dist]} else {format ["%1X %2 %3m",_q,_name,round _dist]};
		} else {
			if (_name isEqualTo "") then {format ["%1X %2km",_q,(round (_dist/100))/10]} else {format ["%1X %2 %3km",_q,_name,(round (_dist/100))/10]};
		};
	};
};
BRPVP_calcPveFriends = {
	if (player getVariable ["brpvp_pve_inside",0] isEqualTo 0) then {
		BRPVP_pveFriends = [];
	} else {
		private _pveFriends = [];
		{
			private _p = _x;
			private _isBandit = _p in BRPVP_pveBanditObjList;
			private _inPve = (_p getVariable ["brpvp_pve_inside",0]) > 0;
			if (!_isBandit && _inPve) then {_pveFriends pushBack _x};
		} forEach (call BRPVP_playersList-[player]);
		BRPVP_pveFriends = +_pveFriends;
	};
};
BRPVP_superJump = {
	params ["_pa1","_pa2"];
	if (player getVariable ["brpvp_half_bandit",false] && player getVariable ["brpvp_pve_inside",0] > 0) then {
		"erro" call BRPVP_playSound;
		[format [localize "str_pve_cant_sjump_hack",BRPVP_pveDaysWithNoSuperJumpWhenHack],-6] call BRPVP_hint;
		BRPVP_superJumpRunning = false;
	} else {
		if (player call BRPVP_checkOnFlagState > 0) then {
			"erro" call BRPVP_playSound;
			[localize "str_cant_sjump_flag_area",-6] call BRPVP_hint;
			BRPVP_superJumpRunning = false;
		} else {
			private _cd1 = getDir player;
			private _found = false;
			{
				private _cd2 = [player,_x] call BIS_fnc_dirTo;
				private _aLim = 90-60*(player distance _x)/5;
				if ([_cd1,_cd2] call BRPVP_angleBetween < _aLim) exitWith {_found = true;};
			} forEach ((player nearEntities [BRPVP_playerModel,5])-[player]);
			if (_found) then {
				"erro" call BRPVP_playSound;
				BRPVP_superJumpRunning = false;
			} else {
				player setVariable ["brpvp_no_colision",true];
				private _flags = nearestObjects [player,["FlagCarrier"],400,true] apply {[_x,_x getVariable ["brpvp_flag_radius",0]]};
				private _lis = [];
				private _lastFlag = objNull;
				private _horizontalVel = [player,0.65*_pa1,getDir player] call BIS_fnc_relPos vectorDiff getPosASL player;
				_horizontalVel set [2,0];
				[player,["jump_player",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
				player setVelocity (_horizontalVel vectorAdd [0,0,0.65*_pa2]);
				waitUntil {
					_lis = lineIntersectsSurfaces [eyePos player,eyePos player vectorAdd [0,0,0.5],player,objNull,true,1,"GEOM","NONE",true];
					private _vel = velocity player;
					{
						_x params ["_flag","_rad"];
						if (player distance2D _flag < _rad) exitWith {
							if !(_lastFlag isEqualTo _flag) then {
								private _vec = getPosWorld player vectorDiff getPosWorld _flag;
								_vec set [2,0];
								_vec = vectorNormalized _vec vectorMultiply 3;
								private _vel2 = [-(_vel select 0),-(_vel select 1),_vel select 2];
								player setVelocity (_vec vectorAdd _vel2);
								_lastFlag = _flag;
								"erro" call BRPVP_playSound;
							};
						};
					} forEach _flags;
					private _velZ = _vel select 2;
					(position player select 2 < 5 && _velZ <= 0) || _lis isNotEqualTo []
				};
				if (_lis isNotEqualTo []) then {
					_vel = velocity player;
					_vz = _vel select 2;
					_vel set [2,-abs _vz];
					player setVelocity _vel;
				};
				waitUntil {position player select 2 < 0.15};
				[player,["jump_hit_ground",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
				BRPVP_superJumpBoost = 0;
				BRPVP_superJumpRunning = false;
				_init = time;
				_doOff = true;
				waitUntil {
					if (BRPVP_superJumpRunning) then {_doOff = false;};
					!_doOff || time-_init > 5
				};
				if (!BRPVP_superJumpRunning && _doOff) then {player setVariable ["brpvp_no_colision",false];};
			};
		};
	};
};
BRPVP_boxCarryActionCode = {
	params ["_wh","_box"];
	if (!local _wh) then {
		[_wh,clientOwner] remoteExecCall ["setOwner",2];
		_init = time;
		waitUntil {local _wh || time-_init > 2.5 || !(player call BRPVP_pAlive)};
	};
	if (!local _wh || !(player call BRPVP_pAlive)) exitWith {
		"erro" call BRPVP_playSound;
		deleteVehicle _box;
		BRPVP_carryingBox = false;
	};
	_box setVectorUp [0,0,1];
	_box attachTo [player,[0,0,2+0.25]];
	_box spawn {
		private _box = _this;
		private _lastSize = -1;
		waitUntil {
			private _perc = ((player getVariable ["brpvp_vault_perc",[0,0,"#FFFFFF"]]) select 1)/100;
			private _size = 0.3+0.40*_perc;
			private _pulse = sin ((time*(240+480*_perc)) mod 360)*_size*(2/90);
			_box setObjectScale (_size+_pulse);
			if (_size isNotEqualTo _lastSize) then {
				BRPVP_carryBoxSetScaleOnMe = [];
				[_box,_size] remoteExecCall ["setObjectScale",0];
				_lastSize = _size;
			} else {
				private _carryBoxSetScaleOnMe = (BRPVP_carryBoxSetScaleOnMe arrayIntersect BRPVP_carryBoxSetScaleOnMe)-[objNull];
				if (_carryBoxSetScaleOnMe isNotEqualTo []) then {
					BRPVP_carryBoxSetScaleOnMe = [];
					[_box,_size] remoteExecCall ["setObjectScale",_carryBoxSetScaleOnMe];
				};
			};

			isNull _box
		};
	};
	player setVariable ["brpvp_box_carry",_wh,[clientOwner,2] arrayIntersect [clientOwner,2]];
	player setVariable ["brpvp_box_carry_model",_box,[clientOwner,2] arrayIntersect [clientOwner,2]];
	[_wh,true] remoteExecCall ["hideObjectGlobal",2];
	_wh setPosATL [50+random 200,50+random 200,5];
	BRPVP_boxCarryAction = true;

	private _mass = _wh call BRPVP_getContainerMass;
	private _mass100 = round (_mass/100);
	if (_mass100 > 96) then {_mass100 = 100;};
	player setVariable ["brpvp_vault_perc",[_mass,_mass100,if (_mass100 >= 95) then {"#FF0000"} else {"#FFFFFF"}],BRPVP_specOnMeMachines];
	call BRPVP_atualizaDebug;
};
BRPVP_boxCarryReleaseActionCode = {
	params ["_b","_model"];
	private ["_wh","_posSafe","_p","_dir","_isBase","_nearWhs","_nearWh"];
	_p = player;
	_dir = getDir _p;
	_posSafe = if (getPosATL _p select 2 > 0.05) then {getPosASL _p vectorAdd [1.5*sin _dir,1.5*cos _dir,0.15]} else {AGLToASL ([_p,1.5,_dir] call BIS_fnc_relPos vectorAdd [0,0,0.15])};
	_nearWhs = (nearestObjects [ASLToAGL getPosASL _p,["GroundWeaponHolder","WeaponHolderSimulated"],3])-[_b];
	_localOk = true;
	if (count _nearWhs > 0) then {
		private _nwo = _nearWhs select 0;
		if (!local _nwo) then {
			[_nwo,clientOwner] remoteExecCall ["setOwner",2];
			_init = time;
			waitUntil {local _nwo || time-_init > 2.5 || !(_p call BRPVP_pAlive)};
		};
		if (!local _nwo || !(_p call BRPVP_pAlive)) exitWith {
			_localOk = false;
			"erro" call BRPVP_playSound;
			if (_p call BRPVP_pAlive) then {BRPVP_boxCarryAction = true;};
		};
		_wh = createVehicle ["GroundWeaponHolder",ASLToATL _posSafe,[],0,"CAN_COLLIDE"];
		_wh setPosATL ASLToATL _posSafe;
		[_b,_wh,ASLToATL getPosASL _p] remoteExecCall ["BRPVP_transferCargoCargoB",_b];
		[_nwo,_wh,ASLToATL getPosASL _p] remoteExecCall ["BRPVP_transferCargoCargoB",_nwo];
	} else {
		_wh = createVehicle ["GroundWeaponHolder",ASLToATL _posSafe,[],0,"CAN_COLLIDE"];
		_wh setPosATL ASLToATL _posSafe;
		[_b,_wh,ASLToATL getPosASL _p] remoteExecCall ["BRPVP_transferCargoCargoB",_b];
	};
	if (_localOk) then {
		detach _model;
		deleteVehicle _model;
		BRPVP_carryingBox = false;
	};
	player setVariable ["brpvp_vault_perc",[0,0,"#FFFFFF"],BRPVP_specOnMeMachines];
	call BRPVP_atualizaDebug;
};
BRPVP_teleUseCode = {
	_teleDeviceOrigin = _this select 3;
	_isRaidTraining = _teleDeviceOrigin getVariable ["brpvp_rto",false];
	_haveAccess = [_teleDeviceOrigin call BRPVP_checaAcesso || player call BRPVP_checkOnFlagState isEqualTo 2,_teleDeviceOrigin getVariable ["brpvp_hacked",false]] select _isRaidTraining;
	_ok = false;
	_allowError = true;
	if (_haveAccess) then {
		_ok = true;
	} else {
		//TRY TO USE LOCK PICK IF HOUSE AND NEEDED AND EQUIPED IN PLAYER
		_object = _teleDeviceOrigin;
		if (BRPVP_equipedIllegalItem isEqualTo "BRP_doorThief") then {
			_remove = false;
			_allowError = false;
			if (random 1 < BRPVP_lockPickChanceOfSuccess) then {
				_lpObj = BRPVP_equipedIllegalItemPatern select 2;
				if (isNull _lpObj) then {
					BRPVP_equipedIllegalItemPatern set [2,_object];
					_lpObj = _object;
				};
				if (_object isEqualTo _lpObj) then {
					if (BRPVP_equipedIllegalItemPatern select 1 >= 8) then {
						if (BRPVP_equipedIllegalItemPatern select 0 isEqualTo 1) then {
							_ok = true;
							"lock_pick_ok_music" call BRPVP_playSound;
							[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];

							//HINT PEOPLE ABOUT THE INVASION
							[player,getPosWorld _lpObj,serverTime] remoteExecCall ["BRPVP_lockPickedBuildingsServerAdd",2];

							_object setVariable ["brpvp_hacked_time",serverTime,true];

							if (_isRaidTraining) then {
								if (BRPVP_hackObjectsOneTimeOnly) then {_object setVariable ["brpvp_hacked",true,true];};
								_remove = true;
							} else {
								if (BRPVP_hackObjectsOneTimeOnly) then {
									_object call BRPVP_turnIntoBandit;
									_object setVariable ["brpvp_hacked",true,true];
								};
								[_object getVariable "own",player getVariable "id_bd",player getVariable "nm",typeOf _object,getPosWorld _object] remoteExecCall ["BRPVP_logBaseInvasion",2];

								//SET FLAG TO NO CONSTRUCTION
								if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
									private _flag = _object call BRPVP_nearestFlagInsideWithAccess;
									if (isNull _flag) then {_flag = _object call BRPVP_nearestFlagInside;};
									if (!isNull _flag) then {
										_flag setVariable ["brpvp_last_intrusion",serverTime,true];
										if (BRPVP_useDiscordEmbedBuilder) then {_flag remoteExecCall ["BRPVP_messageDiscordRaid",2];};
									};
								};

								_remove = true;
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
		};
	};
	if (_ok) then {
		_destineId = [_teleDeviceOrigin getVariable ["brpvp_tele_destine_id",-1],_teleDeviceOrigin getVariable ["brpvp_rto_tele_destine_id",-1]] select _isRaidTraining;
		if (_destineId isEqualTo -1) then {
			[localize "str_tele_destine_not_cfg",-6,200,0,"erro"] call BRPVP_hint;
		} else {
			_flag = _teleDeviceOrigin call BRPVP_nearestFlagInside;
			_flagOwner = _flag getVariable ["own",-1];
			_friendFlags = [];
			{
				_xAmg = (_x getVariable ["amg",[[],[],true]]) select 1;
				_xOwner = _x getVariable "own";
				_ownerOk = _flagOwner in _xAmg || _flagOwner isEqualTo _xOwner;
				if (_ownerOk) then {_friendFlags pushBack [_teleDeviceOrigin distance2D _x,_x];};
			} forEach BRPVP_allFlags;
			_friendFlags sort true;
			_friendFlags = _friendFlags apply {_x select 1};
			_friendFlags deleteAt (_friendFlags find _flag);
			_friendFlags = [_flag]+_friendFlags;
			_teleDeviceDestine = objNull;
			if (_isRaidTraining) then {
				_rad = 200;
				{
					_isRai = typeOf _x isEqualTo "Land_RaiStone_01_F";
					if (_isRai && {(_x getVariable ["brpvp_rto_id_bd",-1]) isEqualTo _destineId}) exitWith {_teleDeviceDestine = _x;};
				} forEach nearestObjects [BRPVP_raidTrainingMapPosition,["Land_RaiStone_01_F"],_rad,true];
				if (!isNull _teleDeviceDestine) exitWith {};
			} else {
				{
					_rad = _x getVariable ["brpvp_flag_radius",0];
					{
						_isRai = typeOf _x isEqualTo "Land_RaiStone_01_F";
						if (_isRai && {(_x getVariable ["id_bd",-1]) isEqualTo _destineId}) exitWith {_teleDeviceDestine = _x;};
					} forEach nearestObjects [_x,["Land_RaiStone_01_F"],_rad,true];
					if (!isNull _teleDeviceDestine) exitWith {};
				} forEach _friendFlags;
			};
			if (isNull _teleDeviceDestine) then {
				[format [localize "str_tele_device_not_found",_destineId],-6] call BRPVP_hint;
			} else {
				[player,["teleport",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
				sleep 0.3125;
				_dir = getDir _teleDeviceDestine;
				_pos = ASLToAGL getPosASL _teleDeviceDestine;
				_pos = [_pos,1,_dir] call BIS_fnc_relPos;
				if (player call BRPVP_pAlive) then {
					player setPosASL AGLToASL _pos;
					player setDir _dir;
					BRPVP_teleCancelTravel = [_teleDeviceOrigin,_teleDeviceDestine];
					BDW_forceUpdate = true;
				};
			};
		};
	} else {
		if (_allowError) then {[localize "str_no_access",-3] call BRPVP_hint;};
	};
};
BRPVP_carryBody = {
	_id = _this select 2;
	_body = _this select 3;
	BRPVP_actionRunning pushBack 29;
	player removeAction _id;
	BRPVP_carryBodyReleaseFlag = false;
	_action = player addAction ["<t color='#F04020'>"+localize "str_body_release_body"+"</t>",{BRPVP_carryBodyReleaseFlag = true;},_body,1.5,true,false];
	player action ["SwitchWeapon",player,player,100];
	_init = time;
	waitUntil {currentWeapon player isEqualTo "" || time - _init > 5};
	waitUntil {BRPVP_carryBodyReleaseFlag || !(currentWeapon player isEqualTo "") || !(player call BRPVP_pAlive) || player distance _body > 35};
	if (!(currentWeapon player isEqualTo "") || !(player call BRPVP_pAlive) || player distance _body > 35) then {
		"erro" call BRPVP_playSound;
		if (player distance _body > 35) then {[format [localize "str_body_too_far",35],-4.5] call BRPVP_hint;};
		if (!(currentWeapon player isEqualTo "")) then {[localize "str_body_cant_hold_weap",-4.5] call BRPVP_hint;};
	} else {
		[_body,getPosASL player vectorAdd [0,0,0.25]] remoteExecCall ["setPosASL",0];
	};
	player removeAction _action;
	BRPVP_actionRunning = BRPVP_actionRunning-[29];
};
BRPVP_busServiceRunning = false;
BRPVP_busServiceActionCode = {
	_stop = _this select 3;
	BRPVP_busServiceRunning = true;
	player removeAction BRPVP_busStopAction;
	BRPVP_busStopAction = -1;
	if ((player call BRPVP_pAlive) && !BRPVP_menuExtraLigado) then {
		player setVariable ["brpvp_zombie_can_see_player",(player getVariable ["brpvp_zombie_can_see_player",0])+1,true];
		114 call BRPVP_iniciaMenuExtra;
	} else {
		BRPVP_busServiceRunning = false;
	};
};
BRPVP_insuranceGetVehicle = {112 spawn BRPVP_iniciaMenuExtra;};
BRPVP_insuranceTraderMenuDrone = {
	BRPVP_stuff = objNull;
	{
		_ok = !isNull _x && alive _x && _x distance player < 100 && !(_x getVariable ["brpvp_no_insurance",false]) && (_x getVariable ["own",-1]) isEqualTo (player getVariable "id_bd");
		if (_ok) exitWith {
			BRPVP_stuff = _x;
			111 call BRPVP_iniciaMenuExtra;
		};
	} forEach nearestObjects [player,BRPVP_vantVehiclesClass,100];
	if (isNull BRPVP_stuff) then {[localize "str_insurance_no_car",-5] call BRPVP_hint;};
};
BRPVP_insuranceTraderMenu = {
	_caller = _this select 1;
	_veh = assignedVehicle _caller;
	if (!isNull _veh && alive _veh && _veh distance player < 100) then {
		if !(_veh getVariable ["brpvp_no_insurance",false]) then {
			if ((_veh getVariable ["own",-1]) isEqualTo (player getVariable "id_bd")) then {
				BRPVP_stuff = _veh;
				111 call BRPVP_iniciaMenuExtra;
			} else {
				[localize "str_insurance_not_owner",-5] call BRPVP_hint;
			};
		} else {
			[localize "str_insurance_black_veh_cant",-5] call BRPVP_hint;
		};
	} else {
		[localize "str_insurance_no_car",-5] call BRPVP_hint;
	};
};
BRPVP_randomBornClick = {
	params ["_pos","_alt","_shift"];
	if (_shift && !_alt) exitWith {
		_oldPd = player getVariable ["pd",BRPVP_posicaoFora];
		if (_oldPd isEqualTo BRPVP_posicaoFora) then {player setVariable ["pd",_pos,true];} else {player setVariable ["pd",BRPVP_posicaoFora,true];};
		true
	};
	if (!_shift && !_alt) then {
		_respawnSpots = +BRPVP_thisLifeBaseSpawns;
		if ({_pos distance2D _x < 75} count _respawnSpots > 0 && BRPVP_useRandomRespawnCanInBase) then {
			_arr = _respawnSpots apply {[_x distance2D _pos,_x]};
			_arr sort true;
			_rp = _arr select 0 select 1;
			_rpTime = _rp getVariable ["brpvp_spawn_time",0];
			_rpRemain = ceil ((_rpTime+BRPVP_baseRespawnDelay)-(call BRPVP_getSyncTime)) max 0;
			if (_rpRemain > 0) then {
				[format [localize "str_cant_base_respawn",_rpRemain],-6,200,0,"erro"] call BRPVP_hint;
			} else {
				_pw = getPosWorld _rp;
				_lis = lineIntersectsSurfaces [_pw,_pw vectorAdd [0,0,1],_rp,objNull];
				if (count _lis > 0 && {vectorMagnitude ((_lis select 0 select 0) vectorDiff _pw) < 0.01}) then {
					"erro" call BRPVP_playSound;
					[localize "str_irregular_respawn",-6] call BRPVP_hint;
				} else {
					_bb = boundingBoxReal _rp;
					_soh = (_bb select 0) distance2D (_bb select 1);
					_rad = _soh/2+1;
					_pw1 = getPosASL _rp;
					_posFinal = ASLToAGL getPosASL _rp;
					for "_a" from 0 to 345 step 15 do {
						_ok1 = false;
						_ok2 = false;
						_lis = [];
						{
							_pLis = _pw1 vectorAdd _x;
							_lis append lineIntersectsSurfaces [_pLis,_pLis vectorAdd [_rad*sin _a,_rad*cos _a,0],_rp,objNull];
						} forEach [[0,0,0.5],[0,0,1],[0,0,1.5],[0,0,2]];
						if (_lis isEqualTo []) then {
							_ok1 = true;
							_pw2 = _pw1 vectorAdd [_rad*sin _a,_rad*cos _a,0];
							_ok2 = true;
							for "_a2" from 0 to 315 step 45 do {
								_lis = [];
								{
									_pLis = _pw2 vectorAdd _x;
									_lis append lineIntersectsSurfaces [_pLis,_pLis vectorAdd [0.5*sin _a2,0.5*cos _a2,0],_rp,objNull];
								} forEach [[0,0,0.5],[0,0,1],[0,0,1.5],[0,0,2]];
								if (count _lis > 0) exitWith {_ok2 = false;};
							};
							if (_ok2) then {_posFinal = ASLToAGL _pw2;};
						};
						if (_ok1 && _ok2) exitWith {};
					};				
					BRPVP_posicaoDeNascimento = ["ground",_posFinal];
				};
			};
		} else {
			_selectedPos = [];
			_array = BRPVP_randomRespawnPlaces apply {[_pos distance _x,_x]};
			_array sort true;
			if (_array select 0 select 0 < 250) then {_selectedPos = _array select 0 select 1;};
			if (_selectedPos isEqualTo []) then {[localize "str_not_a_random_place",-4,200,0,"erro"] call BRPVP_hint;} else {BRPVP_posicaoDeNascimento = ["ground",_selectedPos];};
		};
	};
	false
};
BRPVP_updateBlockInfo = {
	BRPVP_roadBlockBots = _this select 0;
	BRPVP_blockPlacesSelected = _this select 1;
	BRPVP_mapDrawReset = true;
};
BRPVP_carryHelisCode = {
	_heli = _this select 3;
	_cars = (nearestObjects [_heli,["Motorcycle","Car","Tank","Air","Ship"],20])-[_heli];
	_cars = _cars apply {if (_x getVariable ["brpvp_cant_heli_town",false]) then {-1} else {_x};};
	_cars = _cars-[-1];
	if (count _cars > 0) then {
		_veh = _cars select 0;
		if (_veh call BRPVP_checaAcesso) then {
			_offset = BRPVP_carryHelisOffset select (BRPVP_carryHelis find typeOf _heli);
			if ((getPosASL _heli select 2)-(getPosASL _veh select 2) > -(_offset select 2)) then {
				if (isNull (_heli getVariable ["brpvp_carry_heli_veh",objNull])) then {
					_mny = player getVariable ["brpvp_mny_bank",0];
					if (_mny >= BRPVP_carryHelisPrice) then {
						player setVariable ["brpvp_mny_bank",_mny-BRPVP_carryHelisPrice,true];
						[_veh,15] call BRPVP_enableVehOnInteraction;
						call BRPVP_atualizaDebug;
						"negocio" call BRPVP_playSound;
						_veh setDir getDir _heli;
						_veh attachTo [_heli,_offset];
						_heli setVariable ["brpvp_carry_heli_veh",_veh,true];
						sleep 8;
						[_heli,_veh] remoteExec ["BRPVP_carryHeliCheckUnload",2];
					} else {
						"erro" call BRPVP_playSound;
						[format [localize "str_no_money_bank",BRPVP_carryHelisPrice call BRPVP_formatNumber],-5] call BRPVP_hint;
					};
				};
			} else {
				"erro" call BRPVP_playSound;
				[format [localize "str_carry_heli_must_be_above",-(_offset select 2)],-5] call BRPVP_hint;
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_carry_heli_no_access",-5] call BRPVP_hint;
		};
	} else {
		"erro" call BRPVP_playSound;
	};	
};
BRPVP_ceilCreateLocalObjs = [];
BRPVP_ceilCreateLocal = {
	params ["_flag","_h","_holeRad",["_radialOpen",0],["_rotation",0]];
	{deleteVehicle _x;} forEach BRPVP_ceilCreateLocalObjs;
	BRPVP_ceilCreateLocalObjs = [];
	_blockClass = "Land_Canal_Dutch_01_plate_F";
	_size = 12.8-0.8;
	_sizeHalf = _size/2;
	_flagRad = _flag getVariable ["brpvp_flag_radius",0];
	_q1 = floor ((_flagRad-_holeRad)/_size)-1;
	_center = getPosASL _flag;
	_angFix = -1;
	for "_c" from 1 to _q1 do {
		_rad = _holeRad+_sizeHalf+(_c-1)*_size;
		_rad2 = _rad+_sizeHalf;
		_hipo = sqrt (_sizeHalf^2+_rad2^2);
		_sin = _sizeHalf/_hipo;
		_ang = 2*asin _sin;
		_initQ2 = 1;
		_q2 = ceil (360/_ang);
		_angStep = 360/_q2;
		if (_rad > _flagRad/2) then {
			_initQ2 = if (_radialOpen > 0) then {0} else {1};
			if (_angFix isEqualTo -1) then {_angFix = _ang;};
			_round = if (_radialOpen > 0) then {360-_radialOpen-_angFix} else {360-_radialOpen};
			_q2 = ceil (_round/_ang);
			_angStep = _round/_q2;
		};
		for "_i" from _initQ2 to _q2 do {
			_a = _rotation+_i*_angStep;
			_pos = [_center,_rad,_a] call BIS_fnc_relPos;
			_dir = [_pos,_center] call BIS_fnc_dirTo;
			_pos set [2,(_center select 2)+_h];
			_b1 = createSimpleObject [_blockClass,BRPVP_posicaoFora,true];
			_b2 = createSimpleObject [_blockClass,BRPVP_posicaoFora,true];
			_b1 setPosASL _pos;
			_b2 setPosASL _pos;
			BRPVP_ceilCreateLocalObjs append [_b1,_b2];
			_b1 setDir _dir;
			_b2 setDir _dir;
			_b2 setDir (getDir _b2-90);
			_b2 setVectorUp [0,0,-1];
			_b2 setPosWorld (getPosWorld _b2 vectorAdd [0,0,-1]);
		};
	};
};
BRPVP_fortDefendRearmAction = {
	private _p = _this select 1;
	private _cwp = currentWeapon player;
	private _ok = false;
	{
		if (_cwp isEqualTo (_x select 0)) exitWith {
			if (_x select 4 isNotEqualTo [] && {(_x select 4 select 1) <= 0.25*(_x select 4 select 3)}) exitWith {
				private _t = _this select 0;
				_t setVariable ['brpvp_used_in',time+15];
				_p addWeaponItem [_cwp,_x select 4 select 0];
				"achou_loot" call BRPVP_playSound;
				_ok = true;
			};
		};
	} forEach weaponsItems [_p,true];
	if (!_ok) then {"erro" call BRPVP_playSound};
};
BRPVP_waterMissionAction = {
	_sub = _this select 3;
	_AIList = _sub getVariable "brpvp_subAI";
	if ({!alive _x} count _AIList >= 0.7*count _AIList) then {
		_sub setVariable ["brpvp_can_explode",false,true];
		for "_i" from 1 to 25 do {
			"sub_count" cutText ["<img size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\mission\sub_bomb.paa'/> <t size='2.0' color='#FF4444'>"+str(26-_i)+"</t>","PLAIN",-1,true,true];
			"remote_control" call BRPVP_playSound;
			sleep 1;
		};
		"sub_count" cutText ["","PLAIN",-1,true,true];
		_pos = ASLToAGL getPosWorld _sub;
		_n = 10+floor random 10;
		for "_i" from 1 to _n do {
			createVehicle ["HelicopterExploBig",_sub modelToWorld [0,-35+60*_i/_n,0],[],10,"CAN_COLLIDE"];
			sleep random 0.3;
		};
		sleep random 2;
		if (!isNull _sub) then {
			deleteVehicle _sub;
			for "_i" from 1 to 3 do {
				_suitCase = createVehicle ["Land_Suitcase_F",BRPVP_spawnAIFirstPos,[],5,"NONE"];
				_suitCase setVariable ["mny",round (BRPVP_waterMissionSuitCaseMoney*BRPVP_missionValueMult),true];
				_suitCase setPosASL AGLToASL (_pos vectorAdd [-5+random 10,-5+random 10,5+random 5]);
			};
			_box = createVehicle ["Box_NATO_Wps_F",ASLToATL AGLToASL (_pos vectorAdd [0,0,5+random 5]),[],10,"CAN_COLLIDE"];
			_box setVariable ["brpvp_del_when_empty",true,true];
			[_box,BRPVP_waterMissionMoneyforLoot,selectRandom BRPVP_waterMissionMoneyforLootTry,true,BRPVP_waterMissionSpecialLoot] call BRPVP_createCompleteLootBox;
			for "_ci" from 1 to BRPVP_waterMissionSpecialLoot do {[_box,0,1,false,true] call BRPVP_createCompleteLootBox;};
		};
	} else {
		[localize "str_water_mission_cant_explode",-5] call BRPVP_hint;
		"erro" call BRPVP_playSound;
	};
};
BRPVP_linksShow = {
	if (isNil "BRPVP_LinkDisplayOpen" || {!BRPVP_LinkDisplayOpen}) then {
		private _id = player getVariable ["id_bd",""];
		disableSerialization;
		BRPVP_LinkDisplayOpen = true;
		_display = findDisplay 46 createDisplay "RscDisplayEmpty";
		_ctrl = _display ctrlCreate ["RscStructuredText",-1];
		_q = count BRPVP_linksUrls;
		_ctrl ctrlSetPosition [0,0,1,(_q+1)*0.1225/3];
		_ctrl ctrlSetBackgroundColor [0,0,0,0.5];
		_colors = ["#FF0000","#00FF00","#0000FF","#FFFF00","#FF00FF","#00FFFF"];
		_txt = format ["<t>%1</t><br/>",localize "str_links_msg_1"];
		{
			_linkPure = _x select 1;
			_link = if (_linkPure isEqualType {}) then {call _linkPure} else {_linkPure};
			_txt = _txt+format ["<t color='%1'>%2</t> <a href='%3'>%4</a><br/>",_colors select (_forEachIndex mod count _colors),_x select 0,_link,_x select 2];
		} forEach BRPVP_linksUrls;
		_ctrl ctrlSetStructuredText parseText _txt;
		_ctrl ctrlCommit 0;
		_okButton = _display ctrlCreate ["RscButton",-1];
		_okButton ctrlSetPosition [0,(_q+1)*0.1225/3+0.03,0.15,0.065];
		_okButton ctrlSetText "Ok";
		_okButton ctrlAddEventHandler ["ButtonClick",{BRPVP_LinkDisplayOpen = false;}];
		_okButton ctrlCommit 0;
		waitUntil {!BRPVP_LinkDisplayOpen || isNull _ctrl};
		BRPVP_LinkDisplayOpen = false;
		if (!isNull _display) then {_display closeDisplay 1;};
	};
};
BRPVP_remoteControl = {
	private _horn = _this;
	private _obj = objNull;
	if (_horn) then {
		private _eyePos = eyePos player;
		private _veh = objectParent player;
		private _dir = getDir _veh;
		private _h = getPosASL _veh select 2;
		private _hDiff = (_eyePos select 2)-_h;
		for "_mag" from 10 to 50 step 5 do {
			private _target = [(_eyePos select 0)+_mag*sin _dir,(_eyePos select 1)+_mag*cos _dir,_h+_hDiff*(_mag/50)];
			_lis = lineIntersectsSurfaces [_eyePos,_target,player,_veh,true,-1,"GEOM","NONE"];
			{
				private _try = _lis select 0 select 2;
				private _isWall = _try isKindOf "Wall";
				private _haveDoor = isClass (configFile >> "CfgVehicles" >> typeOf _try >> "AnimationSources") && {isClass (configFile >> "CfgVehicles" >> typeOf _try >> "AnimationSources" >> "Door_1_sound_source")};
				private _haveAccess = _try call BRPVP_checaAcesso;
				if (_isWall && _haveDoor && _haveAccess) exitWith {_obj = _try;};
				private _isBuilding = _try isKindOf "Building";
				if (_isBuilding) exitWith {};
			} forEach _lis;
			if (!isNull _obj) exitWith {};
		};
	} else {
		private _eyePos = eyePos player;
		private _target = _eyePos vectorAdd (getCameraViewDirection player vectorMultiply 50);
		private _lis = lineIntersectsSurfaces [_eyePos,_target,player,objectParent player,true,-1,"GEOM","NONE"];
		{
			private _try = _lis select 0 select 2;
			private _isWall = _try isKindOf "Wall";
			private _haveDoor = isClass (configFile >> "CfgVehicles" >> typeOf _try >> "AnimationSources") && {isClass (configFile >> "CfgVehicles" >> typeOf _try >> "AnimationSources" >> "Door_1_sound_source")};
			private _haveAccess = _try call BRPVP_checaAcesso;
			if (_isWall && _haveDoor && _haveAccess) exitWith {_obj = _try;};
		} forEach _lis;
	};
	_success = false;
	if (!isNull _obj) then {
		_success = true;
		_dirObj = getDir _obj;
		_angleLimit = 25;
		_found = [_obj];
		_searchNext = [_obj];
		_exclude = [];
		while {count _searchNext > 0} do {
			_foundNew = [];
			{_foundNew = _foundNew + ((((_x nearObjects ["Wall",5])-_found)-_exclude)-_foundNew);} forEach _searchNext;
			_foundNew = _foundNew apply {
				_dirToA = [_obj,_x] call BIS_fnc_dirTo;
				_dirToB = [_x,_obj] call BIS_fnc_dirTo;
				_dirToOk = [_dirToA,_dirObj] call BRPVP_angleBetween < _angleLimit || [_dirToB,_dirObj] call BRPVP_angleBetween < _angleLimit;
				_2dOk = _obj distance2D _x < 0.65;
				_dirA = getDir _x;
				_dirB = (_dirA+180) mod 360;
				_dirOk = [_dirA,_dirObj] call BRPVP_angleBetween < _angleLimit || [_dirB,_dirObj] call BRPVP_angleBetween < _angleLimit;
				_haveDoor = isClass (configFile >> "CfgVehicles" >> typeOf _x >> "AnimationSources") && {isClass (configFile >> "CfgVehicles" >> typeOf _x >> "AnimationSources" >> "Door_1_sound_source")};
				_haveAccess = _x call BRPVP_checaAcesso;
				if ((_dirToOk || _2dOk) && _dirOk && _haveDoor && _haveAccess) then {_x} else {_exclude pushBack _x;-1};
			};
			_foundNew = _foundNew - [-1];
			_found = _found + _foundNew;
			_searchNext = +_foundNew;
		};
		_generalState = 0;
		_casesCount = 0;
		_valid = 0;
		_repeat = [];
		{
			_gate = _x;
			{
				if (isClass (configFile >> "CfgVehicles" >> typeOf _gate >> "AnimationSources") && {isClass (configFile >> "CfgVehicles" >> typeOf _gate >> "AnimationSources" >> _x)}) then {
					_state = _gate animationSourcePhase _x;
					_valid = _valid+(if (_state in [0,1]) then {1} else {0});
					_generalState = _generalState+round _state;
					_casesCount = _casesCount+1;
					_repeat pushBack [_gate,_x,_state];
				};
			} forEach ["Door_1_sound_source","Door_2_sound_source"];
		} forEach _found;
		if (_valid isEqualTo _casesCount) then {
			_newState = 1-round (_generalState/_casesCount);
			{
				[_x select 0,true] remoteExecCall ["enableSimulationGlobal",2];
				_x select 0 animateSource [_x select 1,_newState];
			} forEach _repeat;
			_rcUses = (player getVariable ["brpvp_rc_uses",0])+1;
			if (_rcUses >= BRPVP_remoteControlUsesToFinish) then {
				[player,["remote_control_off",125]] remoteExecCall ["say3D",BRPVP_allNoServer];
				[43,1] call BRPVP_sitRemoveItem;
				player setVariable ["brpvp_rc_uses",0,true];
				[localize "str_remote_control_expired",-4] call BRPVP_hint;
			} else {
				[player,["remote_control",125]] remoteExecCall ["say3D",BRPVP_allNoServer];
				player setVariable ["brpvp_rc_uses",_rcUses,true];
				[format [localize "str_remote_control_uses",_rcUses,BRPVP_remoteControlUsesToFinish],-3] call BRPVP_hint;
			};
			if (_horn && _newState isEqualTo 1) then {
				["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\horn_open.paa'/><br/>"+format [localize "str_gate_will_close_in",30],0,0.25,5,0,0,34793] call BRPVP_fnc_dynamicText;
				_repeat spawn {
					uiSleep 30;
					{
						[_x select 0,true] remoteExecCall ["enableSimulationGlobal",2];
						_x select 0 animateSource [_x select 1,0];
					} forEach _this;
				};
			};
		} else {
			[player,["remote_control_cant",125]] remoteExecCall ["say3D",BRPVP_allNoServer];
		};
	};
	if (!_success && !_horn) then {"erro" call BRPVP_playSound;};
};
BRPVP_controlCenterStart = {
	_cc = _this select 3;
	_flag = objNull;
	{
		_inRad = _cc distance2D _x <= _x getVariable ["brpvp_flag_radius",0];
		_haveAccess = [player,_x] call BRPVP_checaAcessoRemotoFlag;
		if (_inRad && _haveAccess) exitWith {_flag = _x;};
	} forEach nearestObjects [_cc,["FlagCarrier"],200,true]; //(FIO)
	if (isNull _flag) then {
		[localize "str_control_center_no_flag",-5] call BRPVP_hint;
	} else {
		BRPVP_stuff = _flag;
		if !(97 call BRPVP_iniciaMenuExtra) then {"erro" call BRPVP_playSound;};
	};
};
BRPVP_createWallAroundClientObjs = [];
BRPVP_createWallAroundClient = {
	params ["_flag","_class","_wallLen","_rotateWall","_hShift","_terrainFit","_opensCount","_opensSize","_rotate"];
	{deleteVehicle _x;} forEach BRPVP_createWallAroundClientObjs;
	BRPVP_createWallAroundClientObjs = [];
	_rad = _flag getVariable ["brpvp_flag_radius",0];
	if (_rad isEqualTo 0) exitWith {};
	_segments = _opensCount;
	_opensAngle = _opensCount*_opensSize*2.5;
	_segAngle = (360-_opensAngle)/_segments;
	_radExtra = 0;
	{if (_class isEqualTo (_x select 0)) exitWith {_radExtra = _x select 6;};} forEach BRPVP_wallAroundOptions;
	_wallCount = ceil (_segAngle/(2*asin(_wallLen/(2*_rad))));
	_rad = _rad-_radExtra;
	_angleStep = _segAngle/_wallCount;
	_posZeroASL = AGLToASL BRPVP_posicaoFora;
	for "_o" from 0 to (_segments-1) do {
		_start = _rotate+_opensSize*2.5/2+_o*(_segAngle+_opensAngle/_opensCount);
		for "_i" from 0 to (_wallCount-1) do {
			_a = _start+_i*_angleStep+_angleStep/2;
			_posPure = _flag getPos [_rad,_a];
			_posPure set [2,(_posPure select 2) max -1];
			_posWall = _posPure vectorAdd [0,0,_hShift];
			_wall = createSimpleObject [_class,_posZeroASL,true];
			BRPVP_createWallAroundClientObjs pushBack _wall;
			_wall setDir (([_posWall,_flag] call BIS_fnc_dirTo)+_rotateWall);
			if (_terrainFit) then {
				private ["_hNoHoles"];
				_p1 = _flag getPos [_rad,_a-_angleStep/2];
				_p2 = _flag getPos [_rad,_a+_angleStep/2];
				_p1 set [2,(_p1 select 2) max 0];
				_p2 set [2,(_p2 select 2) max 0];
				_h1 = AGLToASL _p1 select 2;
				_h2 = AGLToASL _p2 select 2;
				_hNoHoles = -(abs (_h2-_h1))/2;
				_wall setPosASL AGLToASL (_posWall vectorAdd [0,0,_hNoHoles]);
			} else {
				_h = getPosASL _flag select 2;
				_posWall set [2,_h+_hShift];
				_wall setPosASL _posWall;
			};
		};
	};
};
BRPVP_getPlayerDataAndSendServerToSave = {
	if (player call BRPVP_pAlive && player getVariable "sok") then {[player call BRPVP_pegaEstadoPlayer,[]] remoteExecCall ["BRPVP_salvaPlayerVault",2];};
};
BRPVP_getSyncTime = {
	BRPVP_syncedTime+diag_tickTime-BRPVP_syncedTimeMark
};
BRPVP_getSellVehicle = {
	private _vehicle = getConnectedUAV player;
	if (isNull _vehicle || {_vehicle distance player > 100}) then {_vehicle = assignedVehicle player;};
	_vehicle
};
BRPVP_sellVehicleCode = {
	private ["_price","_vehicle"];
	_price = call BRPVP_getVehicleSellPrice;
	if (_price > 0) then {
		_vehicle = call BRPVP_getSellVehicle;
		[_vehicle,true] call BRPVP_removeObject;
		"negocio" call BRPVP_playSound;
		player setVariable ["mny",(player getVariable ["mny",0])+_price,true];
		[format [localize "str_psellveh_sold",_price call BRPVP_formatNumber],0] call BRPVP_hint;
		[["vendeu",_price]] call BRPVP_mudaExp;
		true
	} else {
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_getVehicleSellPrice = {
	private ["_vehicle","_price","_class","_priceMult","_role","_allDamage","_damage","_return","_excludeSell"];
	_price = -1;
	_vehicle = call BRPVP_getSellVehicle;
	if (!isNull _vehicle && _vehicle getVariable ["brpvp_trans_mission",-1] isEqualTo -1) then {
		if (alive _vehicle) then {
			if (_vehicle distance player < 100) then {
				_allDamage = getAllHitPointsDamage _vehicle;
				_allDamage = if (_allDamage isEqualTo []) then {[0]} else {_allDamage select 2};
				_damage = 0;
				{_damage = _damage+_x;} forEach _allDamage;
				_damage = _damage/(count _allDamage);
				_class = typeOf _vehicle;
				_priceMult = if (_vehicle getVariable ["brpvp_fedidex",false]) then {
					_excludeSell = [];
					_return = BRPVP_sellMultVeh;
					{if (_x select 0 isEqualTo "FEDIDEX" && _x select 3 isEqualTo _class) exitWith {_return = BRPVP_sellMultVehPricedFedidex;};} forEach BRPVP_tudoA3;
					_return
				} else {
					_excludeSell = ["FEDIDEX"];
					BRPVP_sellMultVeh
				};
				private _extraMult1 = _vehicle getVariable ["brpvp_extra_sell_mult",1];
				_priceMult = _priceMult*BRPVP_marketPricesMultiply*(1-_damage)*_extraMult1;
				{if ((_x select 3) isEqualTo _class && {!(_x select 0 in _excludeSell)}) exitWith {_price = (_x select 5)*_priceMult;};} forEach BRPVP_tudoA3;
			};
		};
	};
	round _price
};
BRPVP_identifyShopType = {
	_alowed = _this;
	_shopType = localize "str_shop_some";
	if ( ("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_msm";};
	if (!("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_sm"; };
	if ( ("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_sc"; };
	if (!("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_sc"; };
	if (!("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_mnm";};
	if (!("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_sma";};
	if ( ("CIVIL" in _alowed) &&  ("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_scp";};
	if ( ("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) &&  ("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_se"; };
	if (!("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) &&  ("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_fe"; };
	if (!("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) &&  ("AIRPORT" in _alowed) && !("BOATS" in _alowed)) then {_shopType = localize "str_shop_air";};
	if (!("CIVIL" in _alowed) && !("CIV-MIL" in _alowed) && !("MILITAR" in _alowed) && !("FEDIDEX" in _alowed) && !("AIRPORT" in _alowed) &&  ("BOATS" in _alowed)) then {_shopType = localize "str_shop_boat";};
	_shopType
};
BRPVP_statusBarFps = {
	_fps = "";
	_fpsRound = round _this;
	if (_fpsRound >= 60) then {
		_fps = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\fps_veryhigh.paa'/><t> "+str _fpsRound+"</t>";
	} else {
		if (_fpsRound >= 45) then {
			_fps = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\fps_high.paa'/><t> "+str _fpsRound+"</t>";
		} else {
			if (_fpsRound >= 30) then {
				_fps = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\fps_normal.paa'/><t> "+str _fpsRound+"</t>";
			} else {
				if (_fpsRound >= 15) then {
					_fps = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\fps_low.paa'/><t> "+str _fpsRound+"</t>";
				} else {
					if (_fpsRound >= 5) then {
						_fps = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\fps_lowest.paa'/><t> "+str _fpsRound+"</t>";
					} else {
						_fps = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\fps_crap.paa'/><t> "+str _fpsRound+"</t>";
					};
				};
			};
		};
	};
	_fps
};
BRPVP_statusBarHealth = {
	_health = "";
	if (_this < 0.1) then {
		_health = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_todie.paa'/> <img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_empty.paa'/> <img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_empty.paa'/> <img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_empty.paa'/> <img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_empty.paa'/>";
	} else {
		{
			if (_this >= _x select 0) then {
				_health = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_full.paa'/>"+(_x select 2)+_health;
			} else {
				if (_this >= _x select 1) then {
					_health = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_half.paa'/>"+(_x select 2)+_health;
				} else {
					_health = "<img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\heart_empty.paa'/>"+(_x select 2)+_health;
				};
			};
		} forEach [[1,0.9,""],[0.8,0.7," "],[0.6,0.5," "],[0.4,0.3," "],[0.2,0.1," "]];
	};
	_health
};
BRPVP_spawnZombieCalcHouses = {
	_nearBuildings = nearestObjects [player,BRPVP_loot_buildings_class,100];
	_nearBuildingsAway = [];
	{
		if (_x distanceSqr player > 2500) then {_nearBuildingsAway pushBack _x;};
	} forEach _nearBuildings;
	_nearPlayers = player nearEntities [BRPVP_playerModel,120];
	_excludedBuildings = [];
	{
		_bui = _x getVariable ["bui",objNull];
		if (!isNull _bui) then {_excludedBuildings pushBack _bui;};
	} forEach _nearPlayers;
	_nearBuildingsAway - _excludedBuildings
};
BRPVP_radarAdd = {
	BRPVP_radarConfigPool pushBack _this;
	BRPVP_radarConfigPool sort false;
};
BRPVP_radarRemove = {
	_index = 0;
	while {_index > -1} do {
		_index = -1;
		{if (_this isEqualTo (_x select 4)) exitWith {_index = _forEachIndex;};} forEach BRPVP_radarConfigPool;
		if !(_index isEqualTo -1) then {BRPVP_radarConfigPool deleteAt _index;};
	};
};
LOL_fnc_showNotification = {
	params ["_endType","_mess"];
	if (_endType == "BRPVP_morreu_1") then {
		_mess params ["_name","_ofensor","_ammo","_dist"];
		[format [localize "str_killmsg_main",_name,_ofensor,_ammo,_dist],10,20,1414,"kill_msg"] call BRPVP_hint;
	};
	if (_endType == "BRPVP_morreu_2") then {
		_mess params ["_name","_last","_time"];
		[format [localize "str_killmsg_hurt",_name,_last,_time],6,20,1414,"kill_msg"] call BRPVP_hint;
	};
	if (_endType == "BRPVP_morreu_3") then {
		_mess params ["_name"];
		[format [localize "str_killmsg_puf",_name],4,15,1414,"kill_msg"] call BRPVP_hint;
	};
	if (_endType == "BRPVP_morreu_4") then {
		_mess params ["_name"];
		[format [localize "str_brpvp_died_no_food",_name],5,15,1414,"radarbip"] call BRPVP_hint;
	};
};
BRPVP_actionSellClose = {
	{
		detach _x;
		deleteVehicle _x;
	} forEach (attachedObjects BRPVP_sellReceptacle);
	deleteVehicle BRPVP_sellReceptacle;
	BRPVP_sellStage = 5;
};
BRPVP_buyersPlaceRunning = false;
BRPVP_buyersPlace = {
	waitUntil {!BRPVP_buyersPlaceRunning};
	BRPVP_buyersPlaceRunning = true;
	private _hs = [];
	{if (_x getVariable ["bidx",-1] isNotEqualTo -1) then {_hs pushBack _x;};} forEach (player nearEntities ["C_man_sport_1_F_afro",200]);
	private _h = _hs select 0;
	private _actBuyers1 = -1;
	private _actBuyers2 = -1;
	BRPVP_sellInCourtyard = false;
	BRPVP_sellStage = 0;
	waitUntil {
		waitUntil {
			BRPVP_sellInCourtyard = [player,_h] call PDTH_pointIsInBox;
			!(BRPVP_inBuyersPlace isEqualTo _this) || BRPVP_sellInCourtyard
		};
		if (BRPVP_sellInCourtyard) then {
			BRPVP_sellStage = 1;
			_v = vehicle player;
			if (_v != player && {driver _v isEqualTo player && {fuel _v < 0.9 && {_v call BRPVP_checaAcesso}}}) then {
				_v setFuel 1;
				[localize "str_fuel_100",0] call BRPVP_hint;
			};
			_actBuyers1 = player addAction [("<t color='#00BB00'>"+localize "str_coll_open_receptacle"+"</t>"),"client_code\actions\actionSell.sqf",[],100,true,true,"","_this isEqualTo _originalTarget"];
			waitUntil {
				BRPVP_sellInCourtyard = [player,_h] call PDTH_pointIsInBox;
				!BRPVP_sellInCourtyard || BRPVP_sellStage isEqualTo 2
			};
			player removeAction _actBuyers1;
			if (BRPVP_sellStage isEqualTo 2) then {
				_actBuyers2 = player addAction [("<t color='#FF0000'>"+localize "str_coll_apply_sell"+"</t>"),"client_code\actions\actionSellApply.sqf",[],100,true,true,"","_this isEqualTo _originalTarget"];
				waitUntil {!(BRPVP_inBuyersPlace isEqualTo _this) || BRPVP_sellStage in [3,4,5]};
				player removeAction _actBuyers2;
				if (BRPVP_sellStage in [3,4,5]) then {
					if (BRPVP_sellStage isEqualTo 3) then {
						waitUntil {BRPVP_sellStage isEqualTo 4};
						BRPVP_sellStage = 0;
					} else {
						BRPVP_sellStage = 0;
					};
				} else {
					call BRPVP_actionSellClose;
					waitUntil {BRPVP_sellStage isEqualTo 5};
					BRPVP_sellStage = 0;
				};
			} else {
				BRPVP_sellStage = 0;
			};
		};
		!(BRPVP_inBuyersPlace isEqualTo _this)
	};
	BRPVP_buyersPlaceRunning = false;
};
BRPVP_playSoundAllCli = {_this remoteExecCall ["BRPVP_tocaSom",0];};
BRPVP_mudaExp = {
	private _atual = player getVariable "exp";
	private _mudanca = +BRPVP_experienciaZerada;
	private _mudou = false;
	private _isDXP = (_this select 0 select 0) isEqualTo "double";
	private _isADM = (_this select 0 select 0) isEqualTo "admin";
	{
		private _tipo = _x select 0;
		private _valor = _x select 1;
		private _idc = BRPVP_expLegendaSimples find _tipo;
		if (_idc >= 0 && _valor != 0) then {
			_mudanca set [_idc,(_mudanca select _idc)+_valor];
			_mudou = true;
			
			//NO MORE NEWER IF KILLED A PLAYER
			if (_tipo isEqualTo "matou_player" && {(_atual select 0)+_valor >= BRPVP_newerKillsToLeave && player getVariable ["brpvp_is_newer",false]}) then {
				player setVariable ["brpvp_is_newer",false,true];
			};
		};
	} forEach _this;
	if (_mudou) then {
		{_atual set [_forEachIndex,(_atual select _forEachIndex)+_x];} forEach _mudanca;
		player setVariable ["exp",_atual,true];
		if (!_isDXP) then {_isADM call BRPVP_xpSetPerksAfterExp;};
	};
};
BRPVP_hintHistoricShow = [];
BRPVP_hint = {
	params ["_msg",["_t",0],["_limitPlus",200],["_mshare",0],["_snd","hint"],["_force",false]];
	if (BRPVP_allowBrpvpHint || (_force && isNull BRPVP_spectedPlayer)) then {
		//SEND TO SPECTATORS
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_this remoteExecCall ["BRPVP_hintSpec",BRPVP_specOnMeMachinesNoMe];};

		if (_msg isEqualType []) then {_msg = format ([localize (_msg select 0)]+(_msg select 1));};
		if (_snd isEqualTo "hint") then {_snd = "hint2";};
		if (_t <= 0) then {
			_t = if (_t isEqualTo 0) then {5} else {abs _t};
			5 cutText ["<br/><br/><br/><br/><t size='1.5' color='#FFF0B0'>"+([_msg,"\n","<br/>"] call BRPVP_stringReplace)+"</t>","PLAIN",_t/10,true,true];
			if (_snd != "") then {_snd call BRPVP_playSound;};
		} else {
			_limit = time + _limitPlus;
			_t = _t/10;
			BRPVP_hintHistorico pushBack [["<br/><t size='1.5' color='#FFF0B0'>"+([_msg,"\n","<br/>"] call BRPVP_stringReplace)+"</t>","PLAIN DOWN",_t,true,true],_snd,_limit,_mshare];
		};
	};
};
BRPVP_hintSpec = {
	if (BRPVP_spectateOn) then {
		params ["_msg",["_t",0],["_limitPlus",200],["_mshare",0],["_snd","hint"],["_force",false]];
		if (_snd isEqualTo "hint") then {_snd = "hint2";};
		if (_msg isEqualType []) then {_msg = format ([localize (_msg select 0)]+(_msg select 1));};
		if (_t <= 0) then {
			_t = if (_t isEqualTo 0) then {5} else {abs _t};
			5 cutText ["<br/><br/><br/><br/><t size='1.5' color='#FFF0B0'>"+([_msg,"\n","<br/>"] call BRPVP_stringReplace)+"</t>","PLAIN",_t/10,true,true];
			if (_snd != "") then {_snd call BRPVP_playSound;};
		} else {
			_limit = time + _limitPlus;
			_t = _t/10;
			BRPVP_hintHistorico pushBack [["<br/><t size='1.5' color='#FFF0B0'>"+([_msg,"\n","<br/>"] call BRPVP_stringReplace)+"</t>","PLAIN DOWN",_t,true,true],_snd,_limit,_mshare];
		};
	};
};
[] spawn {
	_timeLock = 0;
	_lmshare = 0;
	waitUntil {
		if (count BRPVP_hintHistorico > 0) then {
			_timeNow = time;
			_case = BRPVP_hintHistorico select 0;
			_mshare = _case select 3;
			if (_timeNow >= _timeLock || (_mshare isEqualTo _lmshare && _mshare != 0)) then {
				_msg = _case select 0;
				_snd = _case select 1;
				_limit = _case select 2;
				_lmshare = _mshare;
				if (_timeNow <= _limit) then {
					_timeLock = _timeNow + (_msg select 2) * 10;
					10 cutText _msg;
					if (_snd != "") then {_snd call BRPVP_playSound;};
				};
				BRPVP_hintHistorico deleteAt 0;
			};
		};
		false
	};
};
BRPVP_adicionaIconeLocalArea = {
	params ["_ambito","_iName","_iObj","_iColor","_raio"];
	if (_ambito isEqualTo "geral") then {BRPVP_iconesLocais pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
	if (_ambito isEqualTo "geralshow") then {BRPVP_iconesLocaisShow pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
	if (_ambito isEqualTo "amigos") then {BRPVP_iconesLocaisAmigos pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
	if (_ambito isEqualTo "bots") then {BRPVP_iconesLocaisBots pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
	if (_ambito isEqualTo "veiculi") then {BRPVP_iconesLocaisVeiculi pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
	if (_ambito isEqualTo "mastuff") then {BRPVP_iconesLocaisStuff pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
	if (_ambito isEqualTo "in_out") then {BRPVP_iconesLocaisInOut pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
	if (_ambito isEqualTo "trader") then {BRPVP_iconesLocaisTrader pushBack [_iName,_iObj,"AREA",_iColor,"circle.paa","",_raio];};
};
BRPVP_adicionaIconeLocal = {
	params ["_ambito","_iName","_iObj","_iColor","_iText","_iType",["_size",BRPVP_iSizeGeneral]];
	_iName = format ["CN%1_%2",BRPVP_iconsCounterName,_iName];
	if (_ambito isEqualTo "geral") then {BRPVP_iconesLocais pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
	if (_ambito isEqualTo "geralshow") then {BRPVP_iconesLocaisShow pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
	if (_ambito isEqualTo "amigos") then {BRPVP_iconesLocaisAmigos pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
	if (_ambito isEqualTo "bots") then {BRPVP_iconesLocaisBots pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
	if (_ambito isEqualTo "veiculi") then {BRPVP_iconesLocaisVeiculi pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
	if (_ambito isEqualTo "mastuff") then {BRPVP_iconesLocaisStuff pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
	if (_ambito isEqualTo "in_out") then {BRPVP_iconesLocaisInOut pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
	if (_ambito isEqualTo "trader") then {BRPVP_iconesLocaisTrader pushBack [_iName,_iObj,"ICON",_iColor,_iType,_iText,_size];};
};
BRPVP_removeTodosIconesLocais = {
	//REMOVE ICONES DE TODOS OS TIPOS
	if (_this isEqualTo "geral") then {BRPVP_iconesLocais = [];};
	if (_this isEqualTo "geralshow") then {BRPVP_iconesLocaisShow = [];};
	if (_this isEqualTo "amigos") then {BRPVP_iconesLocaisAmigos = [];};
	if (_this isEqualTo "bots") then {BRPVP_iconesLocaisBots = [];};
	if (_this isEqualTo "veiculi") then {BRPVP_iconesLocaisVeiculi = [];};
	if (_this isEqualTo "mastuff") then {BRPVP_iconesLocaisStuff = [];};
	if (_this isEqualTo "in_out") then {BRPVP_iconesLocaisInOut = [];};
	if (_this isEqualTo "trader") then {BRPVP_iconesLocaisTrader = [];};
};
BRPVP_escolheModaPlayer = {
	//NUDA PLAYER (TIRA TUDO DELE)
	{player removeMagazine _x;} forEach  magazines player;
	{player removeWeapon _x;} forEach weapons player;
	{player removeItem _x;} forEach items player;
	removeAllAssignedItems player;
	removeBackpackGlobal player;
	removeUniform player;
	removeVest player;
	removeHeadGear player;
	removeGoggles player;
	
	//VESTE PLAYER CASO PARAMETRO SEJA TRUE
	if (_this) then {
		private _uniformes = [
			"U_C_Man_casual_1_F",
			"U_C_Man_casual_2_F",
			"U_C_Man_casual_3_F",
			"U_C_Man_casual_4_F",
			"U_C_Man_casual_5_F",
			"U_C_Man_casual_6_F",
			"U_I_C_Soldier_Bandit_1_F",
			"U_I_C_Soldier_Bandit_2_F",
			"U_I_C_Soldier_Bandit_3_F",
			"U_I_C_Soldier_Bandit_4_F",
			"U_I_C_Soldier_Bandit_5_F",
			"U_B_GEN_Soldier_F",
			"U_I_C_Soldier_Para_4_F",
			"U_I_C_Soldier_Para_5_F",
			"U_C_ArtTShirt_01_v1_F",
			"U_C_ArtTShirt_01_v2_F",
			"U_C_ArtTShirt_01_v3_F",
			"U_C_ArtTShirt_01_v4_F",
			"U_C_ArtTShirt_01_v5_F",
			"U_C_ArtTShirt_01_v6_F",
			"U_C_FormalSuit_01_Black_F",
			"U_C_FormalSuit_01_Blue_F",
			"U_C_FormalSuit_01_Gray_F",
			"U_C_FormalSuit_01_Khaki_F",
			"U_C_FormalSuit_01_tshirt_gray_F",
			"CUP_U_C_Labcoat_03",
			"CUP_U_C_Tracksuit_04",
			"CUP_U_C_Citizen_03",
			"CUP_U_C_Labcoat_01",
			"CUP_U_C_Suit_01",
			"CUP_U_C_Mechanic_01",
			"CUP_U_C_Priest_01",
			"CUP_U_C_racketeer_01",
			"CUP_U_C_Rocker_01"
		] select {_x call BRPVP_classExists};
		private _caps = [
			"H_Bandanna_mcamo",
			"H_Bandanna_surfer",
			"H_Hat_blue",
			"H_Hat_tan",
			"H_StrawHat_dark",
			"H_Bandanna_surfer_grn",
			"H_Cap_surfer",
			"CUP_H_C_Policecap_01",
			"CUP_H_C_Fireman_Helmet_01",
			"CUP_H_C_Beret_01",
			"CUP_H_C_Ushanka_02",
			"CUP_H_C_Beanie_03",
			"CUP_H_TKI_Lungee_Open_02",
			"CUP_H_TKI_Lungee_Open_02",
			"CUP_H_TKI_Pakol_1_01",
			"CUP_H_TKI_SkullCap_01",
			"CUP_H_TKI_SkullCap_01"
		] select {_x call BRPVP_classExists};
		private _oculosTipos = ["G_Diving"];
		
		//ESCOLHE MODA
		private _moda = floor random 1000;
		private _uniforme = _uniformes select (_moda mod count _uniformes);
		private _cap = _caps select (_moda mod count _caps);
		private _oculos = _oculosTipos select (_moda mod count _oculosTipos);
		
		//APLICA MODA
		player forceAddUniform _uniforme;
		if (_moda mod 5 isNotEqualTo 0) then {player addHeadGear _cap;};
		if (_moda mod 4 isEqualTo 0) then {player addGoggles _oculos;};
	};
};
BRPVP_pegaEstadoPlayer = {
	//ARMAS (P,S,G)
	_armaPriNome = primaryWeapon _this;
	_armaSecNome = secondaryWeapon _this;
	_armaGunNome = handGunWeapon _this;

	//ARMAS ASSIGNED
	_aPI = primaryWeaponItems _this;
	_aSI = secondaryWeaponItems _this;
	_aGI = handGunItems _this;

	//CONTAINERS
	_backPackName = backpack _this;
	_vestName = vest _this;
	_uniformName = uniform _this;

	//APETRECHOS
	_capacete = headGear _this;
	_oculos = goggles _this;

	//SAUDE
	_hpd = getAllHitPointsDamage _this;

	//PLAYERS CONTAINERS
	_bpc = backpackContainer _this;
	_vtc = vestContainer _this;
	_ufc = uniformContainer _this;

	//PLAYERS CONTAINERS MAGAZINES AMMO
	if (!isNull _bpc) then {_bpc = magazinesAmmoCargo _bpc;} else {_bpc = [];};
	if (!isNull _vtc) then {_vtc = magazinesAmmoCargo _vtc;} else {_vtc = [];};
	if (!isNull _ufc) then {_ufc = magazinesAmmoCargo _ufc;} else {_ufc = [];};

	//ESTADO PLAYER
	_salvaPlayer = [
		//ID DO PLAYER
		_this getVariable "id",
		//ARMAS E ASSIGNED ITEMS
		[
			assignedItems _this,
			[_armaPriNome,_aPI,primaryWeaponMagazine _this],
			[_armaSecNome,_aSI,secondaryWeaponMagazine _this],
			[_armaGunNome,_aGI,handGunMagazine _this],
			_this getVariable ["owt",[]]
		],
		//CONTAINERS (BACKPACK, VEST, UNIFORME)
		[
			[_backpackName,[getWeaponCargo backpackContainer _this,getItemCargo backpackContainer _this,_bpc]],
			[_vestName,[getWeaponCargo vestContainer _this,getItemCargo vestContainer _this,_vtc]],
			[_uniformName,[getWeaponCargo uniformContainer _this,getItemCargo uniformContainer _this,_ufc]]
		],
		//DIRECAO E POSICAO
		[getDir _this,getPosWorld _this],
		//SAUDE
		[[_hpd select 1,_hpd select 2],[BRPVP_alimentacao,100],damage _this],
		//MODELO E APETRECHOS
		[typeOf _this,_capacete,_oculos],
		//ARMA NA MAO
		currentWeapon _this,
		//AMIGOS
		_this getVariable ["amg",[]],
		//VIVO OU MORTO
		if (_this call BRPVP_pAlive) then {1} else {0},
		//EXPERIENCIA
		_this getVariable ["exp",BRPVP_experienciaZerada],
		//DEFAULT SHARE TYPE
		_this getVariable ["stp",1],
		//ID BD
		_this getVariable "id_bd",
		//MONEY
		_this getVariable ["mny",0],
		//SPECIAL ITEMS
		_this getVariable ["sit",[]],
		//MONEY ON BANK
		_this getVariable ["brpvp_mny_bank",0],
		//HEAD HUNTER SERVICES BALANCE
		_this getVariable ["brpvp_hh_balance",0],
		//HEAD PRICE
		_this getVariable ["brpvp_head_price",0],
		//REMOTE CONTROL USES
		_this getVariable ["brpvp_rc_uses",0],
		//PLAYER CONFIG
		_this getVariable ["brpvp_player_config",[1500,2500,0,0,0,0,0,0]],
		//PLAYER WEAPON 4
		_this getVariable ["brpvp_weapon_4",[]]
	];
	_salvaPlayer
};
BRPVP_safeZoneCount = 0;
BRPVP_safeZoneInExtraCode = {
	BRPVP_safeZone = true;
	player setVariable ["god",true,true];
	player setCaptive true;
	if (BRPVP_safeZoneCount isEqualTo 0) then {
		0 spawn BRPVP_noVehCollisionCode;
		[localize "str_safezone_in",-3] call BRPVP_hint;
		player setVariable ["brpvp_safe_no_collision",[]];

		//PROTECT PUBLIC VEHICLE
		_veh = objectParent player;
		if (!isNull _veh) then {if (_veh getVariable ["own",-1] isEqualTo -1 && driver _veh isEqualTo player) then {_veh setVariable ["brpvp_safe_owner",crew _veh,true];};};
		if (local _veh && {_veh isKindOf "Air"}) then {[_veh,true] call BRPVP_setAirGodModeForce;};
		if (local BRPVP_myUAVNow && {BRPVP_myUAVNow isKindOf "Air"}) then {[BRPVP_myUAVNow,true] call BRPVP_setAirGodModeForce;};

		//SET EXTRA PROTECTION
		if (player in BRPVP_safezoneProtectionOnExitObjs || player getVariable "brpvp_extra_protection") then {
			player setVariable ["brpvp_extra_protection",false,true];
			player remoteExecCall ["BRPVP_safezoneProtectionOnExitRemoveObj",0];
		};
	};
	BRPVP_safeZoneCount = BRPVP_safeZoneCount+1;
	BRPVP_superJumpCount = BRPVP_superJumpCount+1;
};
BRPVP_safeZoneOutExtraCode = {
	BRPVP_superJumpCount = BRPVP_superJumpCount-1;
	BRPVP_safeZoneCount = BRPVP_safeZoneCount-1;
	if (BRPVP_safeZoneCount isEqualTo 0) then {
		BRPVP_safeZone = false;
		player setVariable ["god",false,true];
		{_x enableCollisionWith player;} forEach (player getVariable ["brpvp_safe_no_collision",[]]);
		if !(call BRPVP_playerCaptiveState) then {
			player setCaptive false;
			{if !(_x call BRPVP_isPlayerC) then {_x reveal [player,1.5];};} forEach (player nearEntities ["CAManBase",200]);
		};
		[localize "str_safezone_out",-3] call BRPVP_hint;

		//UNPROTECT PUBLIC VEHICLE
		_veh = objectParent player;
		if (!isNull _veh) then {if (_veh getVariable ["own",-1] isEqualTo -1 && driver _veh isEqualTo player) then {_veh setVariable ["brpvp_safe_owner",[],true];};};
		if (local _veh && {_veh isKindOf "Air"}) then {[_veh,false] call BRPVP_setAirGodModeForce;};
		if (local BRPVP_myUAVNow && {BRPVP_myUAVNow isKindOf "Air"}) then {[BRPVP_myUAVNow,false] call BRPVP_setAirGodModeForce;};

		//SET EXTRA PROTECTION
		if !(player getVariable ["brpvp_no_extra_safe",false]) then {
			private _extraStart = serverTime;
			player setVariable ["brpvp_extra_protection",true,true];
			[player,_extraStart] remoteExecCall ["BRPVP_safezoneProtectionOnExitAddObj",0];
			_extraStart spawn {
				private _countState = 0;
				waitUntil {
					private _delta = serverTime-_this;
					if (_delta >= _countState) then {
						private _num = BRPVP_safezoneProtectionOnExitTime-_countState;
						if (_num isEqualTo 0) then {
							["",0,0,0,0,0,6423] call BRPVP_fnc_dynamicText;
						} else {
							["<img size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\sz_exit_protection.paa'/><br /><t>"+str _num+"</t>",0,0,2,0,0,6423] call BRPVP_fnc_dynamicText;
						};
						_countState = _countState+1;
					};
					_delta >= BRPVP_safezoneProtectionOnExitTime || BRPVP_safeZone
				};
				if (!BRPVP_safeZone) then {
					player setVariable ["brpvp_extra_protection",false,true];
					player remoteExecCall ["BRPVP_safezoneProtectionOnExitRemoveObj",0];
				};
			};
		};
	};
};
/*
BRPVP_safeZoneInExtraCode = {
	BRPVP_safeZone = true;
	if (BRPVP_safeZoneCount isEqualTo 0) then {0 spawn BRPVP_noVehCollisionCode;};
	BRPVP_safeZoneCount = BRPVP_safeZoneCount+1;
	player setVariable ["brpvp_safe_no_collision",[]];
	player setVariable ["god",true,true];
	player setCaptive true;
	[localize "str_safezone_in",-3] call BRPVP_hint;
	BRPVP_superJumpCount = BRPVP_superJumpCount+1;
	
	//PROTECT PUBLIC VEHICLE
	_veh = objectParent player;
	if (!isNull _veh) then {if (_veh getVariable ["own",-1] isEqualTo -1 && driver _veh isEqualTo player) then {_veh setVariable ["brpvp_safe_owner",crew _veh,true];};};

	if (local _veh && {_veh isKindOf "Air"}) then {[_veh,true] call BRPVP_setAirGodModeForce;};
	if (local BRPVP_myUAVNow && {BRPVP_myUAVNow isKindOf "Air"}) then {[BRPVP_myUAVNow,true] call BRPVP_setAirGodModeForce;};
};
BRPVP_safeZoneOutExtraCode = {
	player setVariable ["god",false,true];
	{_x enableCollisionWith player;} forEach (player getVariable ["brpvp_safe_no_collision",[]]);
	player setCaptive false;
	{if !(_x call BRPVP_isPlayer) then {_x reveal [player,1.5];};} forEach (player nearEntities ["CAManBase",200]);
	[localize "str_safezone_out",-3] call BRPVP_hint;
	BRPVP_superJumpCount = BRPVP_superJumpCount-1;

	//UNPROTECT PUBLIC VEHICLE
	_veh = objectParent player;
	if (!isNull _veh) then {if (_veh getVariable ["own",-1] isEqualTo -1 && driver _veh isEqualTo player) then {_veh setVariable ["brpvp_safe_owner",[],true];};};
	
	if (local _veh && {_veh isKindOf "Air"}) then {[_veh,false] call BRPVP_setAirGodModeForce;};
	if (local BRPVP_myUAVNow && {BRPVP_myUAVNow isKindOf "Air"}) then {[BRPVP_myUAVNow,false] call BRPVP_setAirGodModeForce;};

	BRPVP_safeZoneCount = BRPVP_safeZoneCount-1;
	if (BRPVP_safeZoneCount isEqualTo 0) then {BRPVP_safeZone = false;};
};
*/
BRPVP_playerCureLastTime = -BRPVP_playerCurePlacesCoolDown;
BRPVP_curaPlayer = {
	_noCoolDown = time - BRPVP_playerCureLastTime >= BRPVP_playerCurePlacesCoolDown;
	if (player call BRPVP_pAlive && _noCoolDown && damage player >= 0.025) then {
		BRPVP_playerCureLastTime = time;
		player setDamage 0;
		BRPVP_alimentacao = 110;
		player setVariable ["sud",[round BRPVP_alimentacao,100],true];
		[localize "str_healed",2,6.5] call BRPVP_hint;
		"heal" call BRPVP_playSound;
	};
};
BRPVP_padMapaClique = {
	params ["_pos","_alt","_shift"];
	if (_shift && !_alt) exitWith {
		_oldPd = player getVariable ["pd",BRPVP_posicaoFora];
		if (_oldPd isEqualTo BRPVP_posicaoFora) then {player setVariable ["pd",_pos,true];} else {player setVariable ["pd",BRPVP_posicaoFora,true];};
		true
	};

	//SET UBER PACK DESTINE
	if (BRPVP_uPackUsing) then {
		if (isNil "BRPVP_uPackSelected") then {
			private _mPos = getMousePosition;
			private _mpw = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld _mPos;
			_mpw pushBack 0;
			BRPVP_uPackSelected = _mpw;
		} else {
			"erro" call BRPVP_playSound;
		};
	};

	//SET BOB TOW DESTINE BEGIN
	_isTow = objNull;
	if (!_shift && !_alt && {!isNull _x} count BRPVP_landVehicleOnTow > 0 && isNull BRPVP_bobToSetDestine) then {
		private _mPos = getMousePosition;
		private _pts = [];
		{
			if (!isNull _x) then {
				private _pos = getPosWorld _x;
				private _pUI = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen _pos;
				private _d = _pUI distance2D _mPos;
				_pts pushBack [_d,_x];
			};
		} forEach BRPVP_landVehicleOnTow;
		_pts sort true;
		if (count _pts > 0 && {_pts select 0 select 0 < 0.05}) then {_isTow = _pts select 0 select 1;};
	};
	if (!isNull _isTow) exitWith {
		BRPVP_bobToSetDestine = _isTow;
		BRPVP_bobToSetDestine spawn {
			[format ["<t><img size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\compass.paa'/><br />%1<br />%2</t>",localize "str_select_bob_destine",localize "str_select_bob_destine_b"],0,0.35,36000,0,0,3841] call BRPVP_fnc_dynamicText;
			waitUntil {!visibleMap || !(player call BRPVP_pAlive) || !(_this in BRPVP_landVehicleOnTow) || isNull BRPVP_bobToSetDestine || !canMove _this || !alive _this};
			BRPVP_bobToSetDestine = objNull;
			["",0,0,0,0,0,3841] call BRPVP_fnc_dynamicText;
		};
		true
	};
	if (!_shift && !_alt && !isNull BRPVP_bobToSetDestine) then {
		private _mPos = getMousePosition;
		private _pos = getPosWorld player;
		private _pUI = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen _pos;
		private _d = _pUI distance2D _mPos;
		private _agnt = driver BRPVP_bobToSetDestine;
		if (typeOf _agnt isEqualTo "C_Driver_1_F") then {_agnt moveTo ASLToAGL getPosASL vehicle _agnt;};
		if (_d < 0.05) then {
			BRPVP_bobToSetDestine setVariable ["brpvp_tow_destine",[]];
			[localize "str_bob_follow_you",-5] call BRPVP_hint;
		} else {
			private _mpw = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld _mPos;
			_mpw pushBack 0;
			BRPVP_bobToSetDestine setVariable ["brpvp_tow_destine",_mpw];
		};
		"granted" call BRPVP_playSound;
		BRPVP_bobToSetDestine = objNull;
	};
	//SET BOB TOW DESTINE END

	false
};
BRPVP_adminMapaClique = {
	params ["_pos","_alt","_shift"];
	if (_shift && !_alt) exitWith {
		_oldPd = player getVariable ["pd",BRPVP_posicaoFora];
		if (_oldPd isEqualTo BRPVP_posicaoFora) then {player setVariable ["pd",_pos,true];} else {player setVariable ["pd",BRPVP_posicaoFora,true];};
		true
	};
	if (_alt && !_shift) exitWith {
		if (BRPVP_flyC) then {
			_pos2 = AGLToASL [_pos select 0,_pos select 1,(ASLToAGL BRPVP_flyRecord) select 2];
			BRPVP_flyRecord = _pos2;
			player setPosASL _pos2;
		} else {
			vehicle player setPos _pos;
		};
		openMap false;
		BRPVP_forceObjectsUpdate = true;
		BDW_forceUpdate = true;
		call BRPVP_baseBombCalcVisibleLinesFar;
		call BRPVP_baseBombCalcVisibleLinesSemiFar;
		call BRPVP_baseBombCalcVisibleLines;
		true
	};

	//SET UBER PACK DESTINE
	if (BRPVP_uPackUsing) then {
		if (isNil "BRPVP_uPackSelected") then {
			private _mPos = getMousePosition;
			private _mpw = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld _mPos;
			_mpw pushBack 0;
			BRPVP_uPackSelected = _mpw;
		} else {
			"erro" call BRPVP_playSound;
		};
	};

	//SET BOB TOW DESTINE BEGIN
	_isTow = objNull;
	if (!_shift && !_alt && {!isNull _x} count BRPVP_landVehicleOnTow > 0 && isNull BRPVP_bobToSetDestine) then {
		private _mPos = getMousePosition;
		private _pts = [];
		{
			if (!isNull _x) then {
				private _pos = getPosWorld _x;
				private _pUI = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen _pos;
				private _d = _pUI distance2D _mPos;
				_pts pushBack [_d,_x];
			};
		} forEach BRPVP_landVehicleOnTow;
		_pts sort true;
		if (count _pts > 0 && {_pts select 0 select 0 < 0.05}) then {_isTow = _pts select 0 select 1;};
	};
	if (!isNull _isTow) exitWith {
		BRPVP_bobToSetDestine = _isTow;
		BRPVP_bobToSetDestine spawn {
			[format ["<t><img size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\compass.paa'/><br />%1<br />%2</t>",localize "str_select_bob_destine",localize "str_select_bob_destine_b"],0,0.35,36000,0,0,3841] call BRPVP_fnc_dynamicText;
			waitUntil {!visibleMap || !(player call BRPVP_pAlive) || !(_this in BRPVP_landVehicleOnTow) || isNull BRPVP_bobToSetDestine || !canMove _this || !alive _this};
			BRPVP_bobToSetDestine = objNull;
			["",0,0,0,0,0,3841] call BRPVP_fnc_dynamicText;
		};
		true
	};
	if (!_shift && !_alt && !isNull BRPVP_bobToSetDestine) then {
		private _mPos = getMousePosition;
		private _pos = getPosWorld player;
		private _pUI = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen _pos;
		private _d = _pUI distance2D _mPos;
		private _agnt = driver BRPVP_bobToSetDestine;
		if (typeOf _agnt isEqualTo "C_Driver_1_F") then {_agnt moveTo ASLToAGL getPosASL vehicle _agnt;};
		if (_d < 0.05) then {
			BRPVP_bobToSetDestine setVariable ["brpvp_tow_destine",[]];
			[localize "str_bob_follow_you",-5] call BRPVP_hint;
		} else {
			private _mpw = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld _mPos;
			_mpw pushBack 0;
			BRPVP_bobToSetDestine setVariable ["brpvp_tow_destine",_mpw];
		};
		"granted" call BRPVP_playSound;
		BRPVP_bobToSetDestine = objNull;
	};
	//SET BOB TOW DESTINE END

	false
};
BRPVP_nascMapaClique = {
	params ["_pos","_alt","_shift"];
	private ["_respawnPos"];
	if (_shift && !_alt) exitWith {
		_oldPd = player getVariable ["pd",BRPVP_posicaoFora];
		if (_oldPd isEqualTo BRPVP_posicaoFora) then {player setVariable ["pd",_pos,true];} else {player setVariable ["pd",BRPVP_posicaoFora,true];};
		true
	};
	if (!_shift && !_alt) then {
		_respawnSpots = +BRPVP_thisLifeBaseSpawns;
		if ({_pos distance2D _x < 75} count _respawnSpots > 0) then {
			_arr = _respawnSpots apply {[_x distance2D _pos,_x]};
			_arr sort true;
			_rp = _arr select 0 select 1;
			_rpTime = _rp getVariable ["brpvp_spawn_time",0];
			_rpRemain = ceil ((_rpTime+BRPVP_baseRespawnDelay)-(call BRPVP_getSyncTime)) max 0;
			if (_rpRemain > 0) then {
				[format [localize "str_cant_base_respawn",_rpRemain],-6,200,0,"erro"] call BRPVP_hint;
			} else {
				_pw = getPosWorld _rp;
				_lis = lineIntersectsSurfaces [_pw,_pw vectorAdd [0,0,1],_rp,objNull];
				if (count _lis > 0 && {vectorMagnitude ((_lis select 0 select 0) vectorDiff _pw) < 0.01}) then {
					"erro" call BRPVP_playSound;
					[localize "str_irregular_respawn",-6] call BRPVP_hint;
				} else {
					_bb = boundingBoxReal _rp;
					_soh = (_bb select 0) distance2D (_bb select 1);
					_rad = _soh/2+1;
					_pw1 = getPosASL _rp;
					_posFinal = ASLToAGL getPosASL _rp;
					for "_a" from 0 to 345 step 15 do {
						_ok1 = false;
						_ok2 = false;
						_lis = [];
						{
							_pLis = _pw1 vectorAdd _x;
							_lis append lineIntersectsSurfaces [_pLis,_pLis vectorAdd [_rad*sin _a,_rad*cos _a,0],_rp,objNull];
						} forEach [[0,0,0.5],[0,0,1],[0,0,1.5],[0,0,2]];
						if (_lis isEqualTo []) then {
							_ok1 = true;
							_pw2 = _pw1 vectorAdd [_rad*sin _a,_rad*cos _a,0];
							_ok2 = true;
							for "_a2" from 0 to 315 step 45 do {
								_lis = [];
								{
									_pLis = _pw2 vectorAdd _x;
									_lis append lineIntersectsSurfaces [_pLis,_pLis vectorAdd [0.5*sin _a2,0.5*cos _a2,0],_rp,objNull];
								} forEach [[0,0,0.5],[0,0,1],[0,0,1.5],[0,0,2]];
								if (count _lis > 0) exitWith {_ok2 = false;};
							};
							if (_ok2) then {_posFinal = ASLToAGL _pw2;};
						};
						if (_ok1 && _ok2) exitWith {};
					};				
					BRPVP_posicaoDeNascimento = ["ground",_posFinal];
				};
			};
		} else {
			if (BRPVP_vePlayers) then {
				BRPVP_posicaoDeNascimento = ["ground",_pos];
			} else {
				_posOk = false;
				_liberado = false;
				{
					_bdi = _x select 0;
					_raio = _x select 1;
					_posOk = _pos distance2D _bdi < _raio;
					if (_posOk) exitWith {
						_respawnPos = _bdi;
						_liberado = time > (BRPVP_temposLocais select _forEachIndex select 1);
					};
				} forEach BRPVP_respawnPlaces;
				cutText ["","PLAIN",1];
				if (!_posOk) then {
					"erro" call BRPVP_playSound;
					15 cutText [localize "str_spawn_not_orange","PLAIN",0.5,true];
				} else {
					if (_liberado) then {
						BRPVP_posicaoDeNascimento = ["air",_respawnPos];
					} else {
						"erro" call BRPVP_playSound;
						15 cutText [localize "str_spawn_wait_count","PLAIN",0.5,true];
					};
				};
			};
		};
	};
	false
};
BRPVP_ligaModoCombateForteRemoto = {
	if !(player getVariable ["cmb",false]) then {call BRPVP_ligaModoCombate;};
	BRPVP_combatTimeLength = BRPVP_combatTimeLengthStrong;
};
BRPVP_ligaModoCombate = {
	BRPVP_ultimoCombateTempo = time;
	if !(player getVariable ["cmb",false]) then {
		player setVariable ["cmb",true,true];
		call BRPVP_atualizaDebug;
		0 spawn {
			waitUntil {
				BRPVP_ligaModoCombateLastEnd = time;
				time >= BRPVP_ultimoCombateTempo+BRPVP_combatTimeLength || !(player call BRPVP_pAlive)
			};
			player setVariable ["cmb",false,true];
			BRPVP_combatTimeLength = BRPVP_combatTimeLengthNormal;
			call BRPVP_atualizaDebug;
		};
	};
};
BRPVP_updateMapIconsRemove = {
	if ("veiculimastuff" in _this || _this isEqualTo []) then {
		"veiculi" call BRPVP_removeTodosIconesLocais;
		"mastuff" call BRPVP_removeTodosIconesLocais;		
		BRPVP_iconsVehicles = [];
		BRPVP_iconsFlags = [];
	};
	if ("bots" in _this || _this isEqualTo []) then {
		"bots" call BRPVP_removeTodosIconesLocais;
		BRPVP_iconsBots = [];
	};
	if ("geral" in _this || _this isEqualTo []) then {
		"geral" call BRPVP_removeTodosIconesLocais;
		BRPVP_iconsBody = [];
		BRPVP_iconsPlayer = [];
		BRPVP_iconsRespawn = [];
	};
	if ("geralshow" in _this || _this isEqualTo []) then {
		"geralshow" call BRPVP_removeTodosIconesLocais;
		BRPVP_iconsBotsSee = [];
		BRPVP_iconsWalkers = [];
	};
};
BRPVP_iconsVehicles = [];
BRPVP_iconsBots = [];
BRPVP_iconsFlags = [];
BRPVP_iconsBody = [];
BRPVP_iconsPlayer = [];
BRPVP_iconsRespawn = [];
BRPVP_iconsBotsSee = [];
BRPVP_iconsWalkers = [];
BRPVP_iconsCounterName = 0;
BRPVP_updateMapIconsAdd = {
	//ICONES VEICULOS: CARROS PLAYER, HELIS PLAYER, BARCOS PLAYER E FLAGS
	if ("veiculimastuff" in _this || _this isEqualTo []) then {
		_idbd = player getVariable "id_bd";
		_iconsVehicles = entities [["LandVehicle","Air","Ship"],[]];
		{
			if (_x getVariable ["own",-1] isEqualTo _idbd) then {
				["mastuff","STUFF_" + str _forEachIndex,_x,[1,1,0,1],"","mil_box.paa"] call BRPVP_adicionaIconeLocal;
			} else {
				["veiculi","PVEH_"+str _forEachIndex,_x,[0,1,0,1],"","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
			};
		} forEach (_iconsVehicles-BRPVP_iconsVehicles);
		BRPVP_iconsVehicles = +_iconsVehicles;

		_iconsFlags = if (BRPVP_vePlayers) then {BRPVP_allFlags} else {BRPVP_myStuffOthers};
		{
			if (!isNull _x) then {
				_color = if (_idbd isEqualTo (_x getVariable "own")) then {[0,1,0,0.2]} else {if (_idbd in ((_x getVariable ["amg",[[],[],true]]) select 1)) then {[0,0,1,0.2]} else {[1,0,0,0.2]}};
				["mastuff","STUFF_OTHERS_DOT_" + str _forEachIndex,_x,(_color select [0,3])+[1],localize "str_flag","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
				["mastuff","STUFF_OTHERS_" + str _forEachIndex,_x,_color,_x getVariable ["brpvp_flag_radius",0]] call BRPVP_adicionaIconeLocalArea;
			};
		} forEach (_iconsFlags-BRPVP_iconsFlags);
		BRPVP_iconsFlags = +_iconsFlags;
	};
	//ICONES BOTS: SOLDADOS, REVOLTOSOS, BLINDADOS, WALKERS, HELIS
	if ("bots" in _this || _this isEqualTo []) then {
		private _playersList = call BRPVP_playersList;
		_playersList = _playersList apply {if (isObjectHidden _x) then {-1} else {_x};};
		_playersList = _playersList-[-1];
		_iconsBots = if (BRPVP_perkSeeAllAI) then {_playersList} else {BRPVP_missBotsEm+_playersList};
		{
			if (alive _x) then {
				["bots","BOT_" + str _forEachIndex,_x,[1,0,0,1],"","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
			} else {
				["bots","BOT_" + str _forEachIndex,_x,[0.5,0,0.75,1],"","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
			};
		} forEach (_iconsBots-BRPVP_iconsBots);
		BRPVP_iconsBots = +_iconsBots;
	};
	//ICONES GERAL: PLAYER, CORPO
	if ("geral" in _this || _this isEqualTo []) then {
		_iconsBody = if (BRPVP_spectateOn) then {BRPVP_meuAllDeadSpec} else {BRPVP_meuAllDead};
		_iconsPlayer = [player];
		_iconsRespawn = call BRPVP_findMySpawns;
		{["geral","PMORTO_" + str _forEachIndex,_x,[1,0,0,1],localize "str_body","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;} forEach (_iconsBody-BRPVP_iconsBody);
		{["geral","RESPAWN_SPOT_" + str _forEachIndex,_x,[1,140/255,0,1],"","mil_end.paa",20] call BRPVP_adicionaIconeLocal;} forEach (_iconsRespawn-BRPVP_iconsRespawn);
		BRPVP_iconsBody = +_iconsBody;
		BRPVP_iconsPlayer = +_iconsPlayer;
		BRPVP_iconsRespawn = +_iconsRespawn;
	};
	if ("geralshow" in _this || _this isEqualTo []) then {
		_init = diag_tickTime;
		_iconsBotsSee = if (BRPVP_vePlayers || !BRPVP_perkSeeAllAiTerrainCanBlock) then {if (BRPVP_perkSeeAllAI) then {BRPVP_roadBlockBots+BRPVP_missBotsEm} else {BRPVP_roadBlockBots};} else {if (BRPVP_perkSeeAllAI) then {(BRPVP_roadBlockBots+BRPVP_missBotsEm) select {!terrainIntersectASL [eyePos BRPVP_myPlayerOrUAVOrVehicle,eyePos _x]}} else {BRPVP_roadBlockBots select {!terrainIntersectASL [eyePos BRPVP_myPlayerOrUAVOrVehicle,eyePos _x]}};};
		_iconsWalkers = if (BRPVP_vePlayers || BRPVP_zedsMapViewDistance isEqualTo 1000000) then {+BRPVP_walkersObj} else {((BRPVP_walkersObj apply {if (player distance2D _x < BRPVP_zedsMapViewDistance) then {_x} else {objNull}})-[objNull]);};
		{
			if (alive _x) then {
				["geralshow","BLOCK_AI",_x,[1,0,0,1],"","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
			} else {
				["geralshow","BLOCK_AI",_x,[0.5,0,0.75,1],"","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
			};
		} forEach (_iconsBotsSee-BRPVP_iconsBotsSee);
		{["geralshow","WKR_AI",_x,[1,140/255,0,1],"","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;} forEach (_iconsWalkers-BRPVP_iconsWalkers);
		BRPVP_iconsBotsSee = +_iconsBotsSee;
		BRPVP_iconsWalkers = +_iconsWalkers;
	};
	BRPVP_iconsCounterName = BRPVP_iconsCounterName+1;
};
//ATUALIZA AMIGOS (NA TELA 3D E NO MAPA)
BRPVP_daUpdateNosAmigos = {
	[] spawn {
		sleep 0.5;
		_meusAmigosObj = [];
		_meusAmigosObjAll = [];
		{
			if (_x getVariable ["sok",false]) then {
				if (_x call BRPVP_checaAcesso) then {
					_meusAmigosObj pushBack _x;
					_meusAmigosObjAll pushBack _x;
				};
			} else {
				if (_x call BRPVP_checaAcesso) then {_meusAmigosObjAll pushBack _x;};
			};
		} forEach ((call BRPVP_playersList)-[player]);
		if !((BRPVP_meusAmigosObj-_meusAmigosObj) isEqualTo [] && (_meusAmigosObj-BRPVP_meusAmigosObj) isEqualTo []) then {
			BRPVP_meusAmigosObj = +_meusAmigosObj;
			"amigos" call BRPVP_removeTodosIconesLocais;
			{["amigos","AMIGO_"+str _forEachIndex,_x,if ((_x getVariable ["stp",1]) isEqualTo 3) then {[1,105/255,180/255,1]} else {[1,1,0,1]},_x getVariable "nm","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;} forEach BRPVP_meusAmigosObj;
		};
		if !((BRPVP_meusAmigosObjAll-_meusAmigosObjAll) isEqualTo [] && (_meusAmigosObjAll-BRPVP_meusAmigosObjAll) isEqualTo []) then {
			BRPVP_meusAmigosObjAll = +_meusAmigosObjAll;
			call BRPVP_calcPveFriends;
		};
	};
};
//FUNCAO PARA PROCESSAR ICONES NO MAPA
BRPVP_mapDrawPrecisao = -10;
BRPVP_addAllwaysIconNoBinocle = {
	params ["_mark","_obj","_shape","_iColor","_iType","_iText","_size"];
	private ["_pos","_dir"];
	if (_obj isEqualType []) then {
		_pos = _obj;
		_dir = 0;
	} else {
		_pos = getPosWorld _obj;
		_dir = if (_obj isEqualTo player) then {getDir _obj} else {0};
	};
	if (_visibleMap || {_obj distance2D BRPVP_myPlayerOrUAV < _gpsViewDist}) then {
		private _data = [BRPVP_missionRoot+"BRP_imagens\draw_map\"+_iType,_iColor,_pos,_size,_size,_dir,_iText];
		if (_shape isEqualTo "AREA") then {BRPVP_iconesTotaisFullOnAreaNoBinocle pushBack _data;} else {BRPVP_iconesTotaisFullOnNoBinocle pushBack _data;};
	};
};
BRPVP_addAllwaysIcon = {
	params ["_mark","_obj","_shape","_iColor","_iType","_iText","_size"];
	private ["_pos","_dir"];
	if (_obj isEqualType []) then {
		_pos = _obj;
		_dir = 0;
	} else {
		_pos = getPosWorld _obj;
		_dir = if (_obj isEqualTo player) then {getDir _obj} else {0};
	};
	if (_visibleMap || {_obj distance2D BRPVP_myPlayerOrUAV < _gpsViewDist}) then {
		private _data = [BRPVP_missionRoot+"BRP_imagens\draw_map\"+_iType,_iColor,_pos,_size,_size,_dir,_iText];
		if (_shape isEqualTo "AREA") then {BRPVP_iconesTotaisFullOnArea pushBack _data;} else {BRPVP_iconesTotaisFullOn pushBack _data;};
	};
};
BRPVP_addAllwaysIconOpt = {
	params ["_mark","_obj","_shape","_iColor","_iType","_iText","_size"];
	if (_visibleMap || {_obj distance2D BRPVP_myPlayerOrUAV < _gpsViewDist}) then {
		private _data = [BRPVP_missionRoot+"BRP_imagens\draw_map\"+_iType,_iColor,getPosWorld _obj,_size,_size,0,_iText];
		if (_shape isEqualTo "AREA") then {BRPVP_iconesTotaisFullOnArea pushBack _data;} else {BRPVP_iconesTotaisFullOn pushBack _data;};
	};
};
BRPVP_addBlinkIconMan = {
	private _obj = _this select 1;
	if (_visibleMap || {_obj distance2D BRPVP_myPlayerOrUAV < _gpsViewDist}) then {
		if (isNull objectParent _obj && !(_obj in BRPVP_meusAmigosObj) && _obj isNotEqualTo player) then {
			if (BRPVP_vePlayers) then {
				BRPVP_iconesTotaisOnBeep pushBack _this;
				BRPVP_iconesTotaisOnBeepDist pushBack 0;
				BRPVP_iconesTotaisOnBeepError pushBack getPosWorld _obj;
			} else {
				_pos = getPosWorld _obj;
				_dist = _obj distance2D BRPVP_radarCenter;
				if (_dist < BRPVP_radarDist*1.25 && {isNull objectParent _obj && !(terrainIntersectASL [AGLToASL BRPVP_radarCenter,_pos])}) then {
					BRPVP_iconesTotaisOnBeep pushBack _this;
					BRPVP_iconesTotaisOnBeepDist pushBack _dist;
					BRPVP_iconesTotaisOnBeepError pushBack (_obj getPos [random (BRPVP_radarDistErr*_dist),random 360]);
				};
			};
		};
	};
};
BRPVP_addBlinkIconVeh = {
	private _obj = _this select 1;
	if (_visibleMap || {_obj distance2D BRPVP_myPlayerOrUAV < _gpsViewDist}) then {
		_crew = crew _obj;
		if (alive _obj && (_crew-BRPVP_meusAmigosObj) isEqualTo _crew) then {
			if (BRPVP_vePlayers) then {
				BRPVP_iconesTotaisOnBeep pushBack _this;
				BRPVP_iconesTotaisOnBeepDist pushBack 0;
				BRPVP_iconesTotaisOnBeepError pushBack getPosWorld _obj;
			} else {
				_pos = getPosWorld _obj;
				_dist = _obj distance2D BRPVP_radarCenter;
				if (_dist < BRPVP_radarDist*1.25 && {isNull objectParent _obj && !(terrainIntersectASL [AGLToASL BRPVP_radarCenter,_pos])}) then {
					BRPVP_iconesTotaisOnBeep pushBack _this;
					BRPVP_iconesTotaisOnBeepDist pushBack _dist;
					BRPVP_iconesTotaisOnBeepError pushBack (_obj getPos [random (BRPVP_radarDistErr*_dist),random 360]);
				};
			};
		};
	};
};
BRPVP_mapIconTypes = ["veiculimastuff","geral","geralshow","bots"];
BRPVP_mapIconTypesIdc = 0;
BRPVP_mapDrawReset = false;
BRPVP_mapDraw = {
	disableSerialization;
	private _mapCtrl = _this select 0;
	private _visibleMap = _this select 1;
	_time = time;
	_passou = _time-BRPVP_mapDrawPrecisao;
	if (_passou >= BRPVP_radarBeepInterval || BRPVP_mapDrawReset) then {
		if (BRPVP_mapDrawReset) then {
			[] call BRPVP_updateMapIconsRemove;
			[] call BRPVP_updateMapIconsAdd;
			BRPVP_mapDrawReset = false;
		} else {
			if (random 1 < 0.25 && visibleGPS && !_visibleMap) then {
				[] call BRPVP_updateMapIconsRemove;
				[] call BRPVP_updateMapIconsAdd;
			} else {
				if (random 1 < 0.5) then {[] call BRPVP_updateMapIconsAdd;};
			};
		};
		_radarConfig = if (BRPVP_vePlayers) then {[0,0,1,[0,0,0]]} else {BRPVP_radarConfigPool select 0};
		BRPVP_radarDist = _radarConfig select 0;
		BRPVP_radarDistErr = _radarConfig select 1;
		BRPVP_radarBeepInterval = _radarConfig select 2;
		BRPVP_radarCenter = _radarConfig select 3;
		if (BRPVP_radarCenter isEqualType objNull) then {
			_pWLD = getPosWorld BRPVP_radarCenter;
			_pASL = getPosASL BRPVP_radarCenter;
			BRPVP_radarCenter = ASLToAGL (_pWLD vectorAdd (_pWLD vectorDiff _pASL));
		};
		BRPVP_mapDrawPrecisao = _time;
		BRPVP_iconesTotaisOnBeep = [];
		BRPVP_iconesTotaisOnBeepDist = [];
		BRPVP_iconesTotaisOnBeepError = [];
		if (BRPVP_radarDist > 0 && !BRPVP_vePlayers) then {"ciclo" call BRPVP_playSound;};
		if (BRPVP_radarDist > 0 || BRPVP_vePlayers) then {
			if (BRPVP_mapShowUnits) then {{_x call BRPVP_addBlinkIconMan;} forEach BRPVP_iconesLocaisBots;};
			if (BRPVP_mapShowVehicles) then {{_x call BRPVP_addBlinkIconVeh;} forEach BRPVP_iconesLocaisVeiculi;};
		};
	};
	if (_stepNow) then {
		BRPVP_iconesTotaisFullOn = [];
		BRPVP_iconesTotaisFullOnArea = [];
		BRPVP_iconesTotaisFullOnNoBinocle = [];
		BRPVP_iconesTotaisFullOnAreaNoBinocle = [];
		if (BRPVP_mapShowUnits) then {{_x call BRPVP_addAllwaysIconOpt;} forEach BRPVP_iconesLocaisShow;};
		if (BRPVP_mapShowPlayerStuff) then {{_x call BRPVP_addAllwaysIconNoBinocle;} forEach BRPVP_iconesLocaisStuff;};
		if (BRPVP_mapShowTraders) then {{_x call BRPVP_addAllwaysIcon;} forEach BRPVP_iconesLocaisTrader;};
		{_x call BRPVP_addAllwaysIcon;} forEach BRPVP_extraIcons;
		{_x call BRPVP_addAllwaysIcon;} forEach BRPVP_iconesLocaisInOut;
		if (BRPVP_mapShowPlayerStuff) then {{_x call BRPVP_addAllwaysIcon;} forEach BRPVP_iconesLocais;};
	};
	_loss = 0.8+BRPVP_radarBeepInterval*(_passou/BRPVP_radarBeepInterval)^2;
	if (BRPVP_vePlayers) then {
		{
			_x params ["_mark","_obj","_shape","_iColor","_iType","_iText","_size"];
			private _dist = _obj distance2D BRPVP_mapMousePosBinocle;
			if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder) then {
				if (_dist < BRPVP_mapVisibleRadiusMinLimit) then {
					_mapCtrl drawIcon [BRPVP_missionRoot+"BRP_imagens\draw_map\"+_iType,_iColor,getPosWorld _obj,_size,_size,0,_iText];
				} else {
					private _alpha = _iColor select 3;
					private _factor = ((BRPVP_mapVisibleRadiusCompare-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
					_mapCtrl drawIcon [BRPVP_missionRoot+"BRP_imagens\draw_map\"+_iType,(_iColor select [0,3])+[_alpha*_factor],getPosWorld _obj,_size,_size,0,_iText];
				};
			};
		} forEach BRPVP_iconesTotaisOnBeep;
	} else {
		if (BRPVP_radarDist > 0) then {
			{
				_x params ["_mark","_obj","_shape","_iColor","_iType","_iText","_size"];
				private _dist = BRPVP_iconesTotaisOnBeepDist select _forEachIndex;
				private _posError = BRPVP_iconesTotaisOnBeepError select _forEachIndex;
				private _signal = ((BRPVP_radarDist-_dist*_loss)/BRPVP_radarDist) min 1 max 0;
				if (random 1 < _signal) then {
					if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder) then {
						if (_dist < BRPVP_mapVisibleRadiusMinLimit) then {
								_mapCtrl drawIcon [BRPVP_missionRoot+"BRP_imagens\draw_map\"+_iType,_iColor,_posError,_size,_size,0,_iText];
						} else {
							private _alpha = _iColor select 3;
							private _factor = ((BRPVP_mapVisibleRadiusCompare-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
							_mapCtrl drawIcon [BRPVP_missionRoot+"BRP_imagens\draw_map\"+_iType,(_iColor select [0,3])+[_alpha*_signal*sqrt(_factor)],_posError,_size,_size,0,_iText];
						};
					};
				};
			} forEach BRPVP_iconesTotaisOnBeep;
		};
	};
	{
		private _dist = (_x select 2) distance2D BRPVP_mapMousePosBinocle;
		if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder) then {
			if (_dist < BRPVP_mapVisibleRadiusMinLimit) then {
				_mapCtrl drawIcon _x;
			} else {
				private _case = +_x;
				private _alpha = _x select 1 select 3;
				private _factor = ((BRPVP_mapVisibleRadiusCompare-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
				(_case select 1) set [3,_factor*_alpha];
				_mapCtrl drawIcon _case;
			};
		};
	} forEach BRPVP_iconesTotaisFullOn;
	{
		private _dist = (_x select 2) distance2D BRPVP_mapMousePosBinocle;
		if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder+(_x select 3)) then {
			if (_dist < BRPVP_mapVisibleRadiusMinLimit) then {
				_mapCtrl drawIcon ((_x select [0,3])+[BRPVP_mapAISM*(_x select 3)/(24*_scale)]+[BRPVP_mapAISM*(_x select 4)/(24*_scale)]+(_x select [5,2]));
			} else {
				private _case = +(_x select [0,3]);
				private _alpha = _case select 1 select 3;
				private _factor = ((BRPVP_mapVisibleRadiusCompare+(_x select 3)-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
				(_case select 1) set [3,_factor*_alpha];
				_mapCtrl drawIcon (_case+[BRPVP_mapAISM*(_x select 3)/(24*_scale)]+[BRPVP_mapAISM*(_x select 4)/(24*_scale)]+(_x select [5,2]));
			};
		};
	} forEach BRPVP_iconesTotaisFullOnArea;
	{_mapCtrl drawIcon _x;} forEach BRPVP_iconesTotaisFullOnNoBinocle;
	{_mapCtrl drawIcon ((_x select [0,3])+[BRPVP_mapAISM*(_x select 3)/(24*_scale)]+[BRPVP_mapAISM*(_x select 4)/(24*_scale)]+(_x select [5,2]));} forEach BRPVP_iconesTotaisFullOnAreaNoBinocle;
};

//ATUALIZAR INFORMACOES DO DEBUG
BRPVP_atualizaDebugCpu = format ["<img size='1.3' color='%1' image='"+BRPVP_imagePrefix+"BRP_imagens\cpu.paa'/>",[0,1,0] call BIS_fnc_colorRGBtoHTML];
BRPVP_atualizaDebugDam = 1 call BRPVP_statusBarHealth;
BRPVP_atualizaDebugBoo = true;
BRPVP_atualizaDebug = {
	private _isLoop = if (isNil "_this" || {!(_this isEqualType true)}) then {false} else {_this};
	if (!_isLoop && BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_atualizaDebug",BRPVP_specOnMeMachinesNoMe]}; //SEND EXTRA DEBUG TO SPECTATORS
	private _player = [BRPVP_spectedPlayer,player] select isNull BRPVP_spectedPlayer;
	private _moneyBankDebug = if (isNull (_player getVariable ["brpvp_hack_on_me",objNull])) then {(_player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber} else {"### ### ###"};
	private _pVaultPerc = _player getVariable ["brpvp_vault_perc",[0,0,"#FFFFFF"]];
	private _ping = _player getVariable ["brpvp_ping",player getVariable "brpvp_ping"];
	private _pingReal = round (_player getVariable ["brpvp_real_ping",player getVariable "brpvp_real_ping"]);
	private _ping = format ["%1ms (+%2)",_ping,(_pingReal-_ping) max 0 min 999];
	private _xp = [BRPVP_xpLastTotal,BRPVP_specXpLastTotal] select BRPVP_spectateOn;
	if (BRPVP_playerDamaged || BRPVP_atualizaDebugBoo) then {
		//PLAYER HEALTH
		BRPVP_playerDamageForCalc = (_player getHitPointDamage "hithead") max (_player getHitPointDamage "hitbody") max (damage _player);
		BRPVP_atualizaDebugDam = ((1-BRPVP_playerDamageForCalc/BRPVP_pDamLim) max 0) call BRPVP_statusBarHealth;
	};
	if (BRPVP_atualizaDebugBoo) then {
		//ZOMBIES COUNT
		private _walkersObj = BRPVP_walkersObj-[objNull];
		player setVariable ["brpvp_debug_zombies",format ["<img size='1.15' image='"+BRPVP_imagePrefixNoModWIP+"zed_icon.paa'/><t> X%1/%2</t>",{_x getVariable ["brpvp_agntsTarget",objNull] isEqualTo player} count _walkersObj,count _walkersObj],BRPVP_specOnMeMachines];

		//SERVER CPU STATE
		private _sQPS = BRPVP_servidorQPS min BRPVP_svFpsIndicatorGreen max BRPVP_svFpsIndicatorRed;
		private _hWay = (BRPVP_svFpsIndicatorGreen-BRPVP_svFpsIndicatorRed)/2;
		private _ylw = BRPVP_svFpsIndicatorRed+_hWay;
		private _red = 0.5*(1-((_sQPS-_ylw) max 0)/_hWay)+0.5*(((_ylw-_sQPS) max 0)/_hWay);
		private _green = 0.5*((_sQPS-_ylw) max 0)/_hWay+0.5*(1-((_ylw-_sQPS) max 0)/_hWay);
		private _cMult = if (_red isEqualTo 0 || _green isEqualTo 0) then {1} else {(1/_red) min (1/_green)};
		private _cpuRGB = [_cMult*_red,_cMult*_green,0];
		BRPVP_atualizaDebugCpu = format ["<img size='1.3' color='%1' image='"+BRPVP_imagePrefix+"BRP_imagens\cpu.paa'/>",_cpuRGB call BIS_fnc_colorRGBtoHTML];
	};
	BRPVP_ultimoDebugDoHint = format [
		BRPVP_indiceDebugItens select BRPVP_indiceDebug,
		BRPVP_atualizaDebugDam,
		"<img size='1.2' image='"+BRPVP_imagePrefix+"BRP_imagens\"+(_player getVariable ["brpvp_player_count_icon",BRPVP_atualizaDebugPlayerIcon])+"'/><t> "+(str count call BRPVP_playersList)+"</t>",
		"%",
		"<img size='1.15' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\"+(BRPVP_remaningTime select 1)+"'/><t> "+(BRPVP_remaningTime select 0)+"</t>",
		"<img size='1' image='"+BRPVP_imagePrefix+"BRP_imagens\food.paa'/><t> "+str ceil ((_player getVariable ["sud",[100,100]]) select 0)+" %</t>",
		if (BRPVP_raidServerIsRaidDay) then {"<img size='1.45' image='"+BRPVP_imagePrefix+"BRP_imagens\raid_on.paa'/>"} else {"<img size='1.45' image='"+BRPVP_imagePrefix+"BRP_imagens\raid_off.paa'/>"},
		if (_player isEqualTo player) then {diag_fps call BRPVP_statusBarFps} else {format ["%1 (%2)",(_player getVariable ["brpvp_fps",-1]) call BRPVP_statusBarFps,round diag_fps]},
		BRPVP_servidorQPS,
		BRPVP_HCFps,
		"<img size='1' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\wallet.paa'/><t> "+((_player getVariable ["mny",0]) call BRPVP_formatNumber)+"</t><t color='#55DD55'> $</t>",
		"<img size='1' image='"+BRPVP_imagePrefix+"BRP_imagens\days_continous.paa'/><t> "+(str ((_player getVariable ["brpvp_access_days",[0,0]]) select 0))+"</t>",
		"<img size='1' image='"+BRPVP_imagePrefix+"BRP_imagens\days_use.paa'/><t> "+(str ((_player getVariable ["brpvp_access_days",[0,0]]) select 1))+"</t>",
		"vago",
		"<img size='1.2' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\bank.paa'/><t> "+_moneyBankDebug+"</t><t color='#55DD55'> $</t>",
		if (_player getVariable ["cmb",false]) then {"<img size='0.85' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\combat_on.paa'/><t color='#FF0000'> "+localize "str_sbar_combat_on"+"</t>"} else {"<img size='0.85' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\combat_off.paa'/><t color='#00FF00'> "+localize "str_sbar_combat_off"+"</t>"},
		if (_player getVariable ["brpvp_weapon_4",[]] isEqualTo []) then {"<img size='1.5' image='"+BRPVP_imagePrefix+"BRP_imagens\no_weapon_4.paa'/>"} else {"<img size='1.5' image='"+getText (configFile >> "CfgWeapons" >> ((_player getVariable "brpvp_weapon_4") select 0 select 0) >> "picture")+"'/>"},
		if (!BRPVP_raidServerIsRaidDay || (BRPVP_raidServerIsRaidDay && !BRPVP_raidWeekDaysDisableConstruction)) then {"<img size='1.45' image='"+BRPVP_imagePrefix+"BRP_imagens\build_on.paa'/>"} else {"<img size='1.45' image='"+BRPVP_imagePrefix+"BRP_imagens\build_off.paa'/>"},
		if (BRPVP_missionNearDist isEqualTo -1) then {"<img size='1.35' image='"+BRPVP_imagePrefix+"BRP_imagens\miss_near_off.paa'/>"} else {"<img size='1.35' image='"+BRPVP_imagePrefix+"BRP_imagens\miss_near_on.paa'/><t> "+str round BRPVP_missionNearDist+"m</t>"},
		format ["<img size='1.35' image='"+BRPVP_imagePrefix+"BRP_imagens\%2.paa'/> %1K",round (_xp/1000),if (BRPVP_xpIsDoubleDay) then {"xp_2x_icon"} else {"xp_icon"}],
		format ["<img size='1.25' image='"+BRPVP_imagePrefix+"BRP_imagens\calendar.paa'/> %1",BRPVP_dateHourTxt],
		if (_player getVariable ["brpvp_is_newer",false]) then {"<img size='1.35' image='"+BRPVP_imagePrefix+"BRP_imagens\novato.paa'/>"} else {"<img size='1.35' image='"+BRPVP_imagePrefix+"BRP_imagens\no_novato.paa'/>"},
		BRPVP_atualizaDebugCpu,
		"<img shadow='0' size='1.75' image='"+BRPVP_imagePrefix+"BRP_imagens\"+(if (_pVaultPerc select 0 > 0) then {"se_box.paa"} else {"se_box_off.paa"})+"'/><t size='1.25' color='"+(_pVaultPerc select 2)+"'> "+str (_pVaultPerc select 1)+"%</t>",
		_ping,
		format ["<img size='1' image='"+BRPVP_imagePrefix+"BRP_imagens\vd_eye.paa'/><t> %1m</t>",viewDistance],
		_player getVariable ["brpvp_debug_zombies","<img size='1.15' image='"+BRPVP_imagePrefixNoModWIP+"zed_icon.paa'/><t> X0/0</t>"]
	];
	if (!visibleMap && player getVariable ["sok",false]) then {(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetStructuredText parseText BRPVP_ultimoDebugDoHint;} else {(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetStructuredText parseText "";};
	BRPVP_atualizaDebugBoo = !BRPVP_atualizaDebugBoo;
};
BRPVP_atualizaDebugMenu = {
	if (BRPVP_construindo) then {
		private _doc = call BRPVP_construcaoHint;
		hintSilent parseText _doc;
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_doc remoteExecCall ["BRPVP_specMenuShow",BRPVP_specOnMeMachinesNoMe];};
	} else {
		if (BRPVP_menuExtraLigado) then {
			if (call BRPVP_menuForceExit) then {
				"erro" call BRPVP_playSound;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				call BRPVP_atualizaDebug;
			} else {
				private _doc = call BRPVP_menuHtml;
				hintSilent parseText _doc;
				if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
					private _oldLin = BRPVP_cfgMenuLines;
					BRPVP_cfgMenuLines = 2;
					call BRPVP_menuHtml remoteExecCall ["BRPVP_specMenuShow",BRPVP_specOnMeMachinesNoMe];
					BRPVP_cfgMenuLines = _oldLin;
				};
			};
		};
	};
};

//PLAYER COMPROU ITEM
BRPVP_comprouItem = {
	params ["_item","_preco","_q"];
	private _lr = false;
	private _lrQ = 0;
	if (_item in BRPVP_specialItems) then {
		{
			_x params ["_i","_qi"];
			if (_item isEqualTo _i) exitWith {
				private _qitA = _item call BRPVP_sitCountItem;
				private _qitB = 0;
				{if (_x isEqualType "" && {_x isEqualTo _item}) then {_qitB = _qitB+1;}  else {if (_x isEqualType [] && {(_x select 0) isEqualTo _item}) then {_qitB = _qitB+(_x select 1);};};} forEach BRPVP_compraItensTotal;
				_lr = (_qitA+_qitB) >= _qi;
				_lrQ = _qi;
			};
		} forEach BRPVP_specialItemsBuyLimit;
	};
	if (_lr && !BRPVP_vePlayers) then {
		"erro" call BRPVP_playSound;
		[format [localize "str_cant_buy_try_alti_lr",_lrQ],0] call BRPVP_hint;
	} else {
		if ((BRPVP_compraPrecoTotal+_preco)*BRPVP_marketPrecoMult <= player call BRPVP_qjsValorDoPlayer) then {
			BRPVP_compraPrecoTotal = BRPVP_compraPrecoTotal+_preco;
			if (_q isEqualTo 1) then {BRPVP_compraItensTotal pushBack _item;} else {BRPVP_compraItensTotal pushBack [_item,_q];};
			BRPVP_compraItensPrecos pushBack _preco;
			"negocio" call BRPVP_playSound;
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_cant_buy_try_remove",0] call BRPVP_hint;
		};
	};
};
BRPVP_comprouItemFinaliza = {
	diag_log "[BRPVP TRADER] BRPVP_comprouItemFinaliza STARTED!";
	if (BRPVP_compraItensTotal isNotEqualTo []) then {
		private _money = player getVariable ["mny",0];
		private _price = BRPVP_compraPrecoTotal*BRPVP_marketPrecoMult;
		if (_money < _price) then {
			[format [localize "str_need_more",_price-_money],4,5] call BRPVP_hint;
			"erro" call BRPVP_playSound;
		} else {
			if (BRPVP_marketDeployMode isEqualTo "default") then {
				private _minhasComprasWH = createVehicle ["GroundWeaponHolder",[0,0,0],[],0,"CAN_COLLIDE"];
				_minhasComprasWH setPosASL getPosASL player;
				_minhasComprasWH setVariable ["own",player getVariable ["id_bd",-1],true];
				_minhasComprasWH setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
				_minhasComprasWH setVariable ["stp",if (BRPVP_marketPrecoMult isEqualTo 0) then {3} else {1},true];
				player setVariable ["mny",(player getVariable ["mny",0])-_price,true];
				call BRPVP_atualizaDebug;
				_onGround = [player,BRPVP_compraItensTotal,_minhasComprasWH] call BRPVP_addLoot;
				if (_onGround) then {[localize "str_items_ground",4,15] call BRPVP_hint;} else {[localize "str_items_have_all",3,10] call BRPVP_hint;};
				"negocio" call BRPVP_playSound;
				"ugranted" call BRPVP_playSound;

				//ITEM TRADERS LOG
				[player,_price,BRPVP_compraItensTotal,"items"] remoteExecCall ["BRPVP_addTraderLog",2];
				[["comprou",_price]] call BRPVP_mudaExp;
			};
			if (BRPVP_marketDeployMode isEqualTo "fedidex") then {
				_price spawn {
					_fedidexPos = getPosASL player;
					_fedidexPos set [2,(_fedidexPos select 2)+1000];
					_fedidexBox = "Box_NATO_WpsSpecial_F" createVehicle BRPVP_posicaoFora;
					[_fedidexBox,10000] remoteExecCall ["setMaxLoad",2];
					_fedidexBox allowDamage false;
					clearWeaponCargoGlobal _fedidexBox;
					clearMagazineCargoGlobal _fedidexBox;
					clearItemCargoGlobal _fedidexBox;
					clearBackpackCargoGlobal _fedidexBox;
					_fedidexBox setPosASL _fedidexPos;
					_fedidexBox setVectorUp [-1 + random 2,-1+random 2,2];
					_fedidexBox allowDamage false;
					[_fedidexBox,[0,0,-10]] remoteExecCall ["setVelocity",0];
					_lastPos = getPosASL _fedidexBox;
					_countNoMove = 0;
					_init = time;
					"fedidex_start" call BRPVP_playSound;
					["<img shadow='0' size='4' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\delivery.paa'/>",0,0,3,0,0,7757] call BRPVP_fnc_dynamicText;
					sleep 1;
					waitUntil {position _fedidexBox select 2 < 20};
					[_fedidexBox,[0,0,0]] remoteExecCall ["setVelocity",0];
					waitUntil {position _fedidexBox select 2 < 5};
					[_fedidexBox,[0,0,0]] remoteExecCall ["setVelocity",0];
					player setVariable ["mny",(player getVariable ["mny",0])-_this,true];
					call BRPVP_atualizaDebug;
					"negocio" call BRPVP_playSound;
					"fedidex" call BRPVP_playSound;

					//ITEM TRADERS LOG
					[player,_this,BRPVP_compraItensTotal,"items"] remoteExecCall ["BRPVP_addTraderLog",2];
					[["comprou",_this]] call BRPVP_mudaExp;

					waitUntil {position _fedidexBox select 2 < 0.75};
					[_fedidexBox,"delivered",400] call BRPVP_playSoundAllCli;
					{
						_isM = isClass (configFile >> "CfgMagazines" >> _x);
						if (_isM) then {
							_fedidexBox addMagazineCargoGlobal [_x,1];
						} else {
							_isW = isClass (configFile >> "CfgWeapons" >> _x);
							if (_isW) then {
								_isItem = _x isKindOf ["ItemCore",configFile >> "CfgWeapons"];
								_isBino = _x isKindOf ["Binocular",configFile >> "CfgWeapons"];
								if (_isItem || _isBino) then {_fedidexBox addItemCargoGlobal [_x,1];} else {_fedidexBox addWeaponCargoGlobal [_x,1];};
							} else {
								_isV = isClass (configFile >> "CfgVehicles" >> _x);
								if (_isV) then {
									_fedidexBox addBackpackCargoGlobal [_x,1];
								} else {
									_isG = isClass (configFile >> "CfgGlasses" >> _x);
									if (_isG) then {_fedidexBox addItemCargoGlobal [_x,1];};
								};
							};
						};
					} forEach BRPVP_compraItensTotal;
					[format [localize "str_fedidex_time",round (time-_init)]] call BRPVP_hint;

					//DELETE BOX
					private _init = diag_tickTime;
					waitUntil {
						uiSleep 10;
						private _cargo = magazineCargo _fedidexBox+weaponCargo _fedidexBox+itemCargo _fedidexBox+backPackCargo _fedidexBox;
						diag_tickTime-_init > 1800 || _cargo isEqualTo []
					};
					_fedidexBox setDamage 1;
				};
			};
		};
	};
};
BRPVP_vaultAbre = {
	_posPlayer = getPosASL player;
	_posPlayer set [2,(_posPlayer select 2)+1];
	_ang = getDir player;
	_posVaultA = [(_posPlayer select 0)+3*sin _ang,(_posPlayer select 1)+3*cos _ang,_posPlayer select 2];
	_posVaultB = [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,_posPlayer select 2];
	_lis = lineIntersectsSurfaces [_posPlayer,_posVaultA,player,objNull];
	_ok = true;
	if (_lis isEqualTo []) then {
		for "_i" from 1 to 6 do {
			_a = _i*60;
			_p = [(_posVaultB select 0)+sin _a,(_posVaultB select 1)+cos _a,_posVaultB select 2];
			_lis = lineIntersectsSurfaces [_posVaultB,_p];
			if (count _lis > 0) exitWith {_ok = false;};
		};
	} else {
		_ok = false;
	};
	if (_ok) then {
		BRPVP_vaultLigada = true;
		BRPVP_holderVault = objNull;
		[player,player getVariable "id",_this] remoteExecCall ["BRPVP_pegaVaultPlayerBd",2];
	} else {
		"erro" call BRPVP_playSound;		
	};
	_ok
};
BRPVP_vaultRecolhe = {
	[player,["fechavault",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
	private _estadoVault = [
		player getVariable "id",
		BRPVP_holderVault call BRPVP_getCargoArray,
		1,
		round(100*load BRPVP_holderVault)
	];
	BRPVP_holderVault call BRPVP_emptyBox;
	diag_log ("[BRPVP VAULT] SAVING VAULT: "+str _estadoVault);
	player setVariable ["wh",objNull,true];
	private _bidx = BRPVP_holderVault getVariable "bidx";
	[[],[_estadoVault,_bidx]] remoteExecCall ["BRPVP_salvaPlayerVault",2];
	if (BRPVP_holderVault in BRPVP_inventoryBoxes && !isNull findDisplay 602) then {(findDisplay 602) closeDisplay 1;};
	deleteVehicle BRPVP_holderVault;
	BRPVP_vaultLigada = false;
};
BRPVP_incluiPlayerBd = {
	_hpd = getAllHitPointsDamage player;
	_estado = [
		player getVariable "id",
		[[],["",["","","",""],[]],["",["","","",""],[]],["",["","","",""],[]],[]],
		[["",[[[],[]],[[],[]],[[],[]]]],["",[[[],[]],[[],[]],[[],[]]]],["",[[[],[]],[[],[]],[[],[]]]]],
		[0,[0,0,0]],
		[[_hpd select 1,_hpd select 2],[100,100],damage player],
		[typeOf player,"",""],
		"",
		player getVariable ["nm","sem_nome"],
		BRPVP_experienciaZerada,
		BRPVP_startingMoney,
		[],
		BRPVP_startingMoneyOnBank
	];
	[player,_estado] remoteExecCall ["BRPVP_incluiPlayerNoBd",2];
};
BRPVP_drawSetas = {
	params ["_obj","_txt"];
	{
		if !(_x isEqualTo []) then {
			_count = count _x;
			if (_count isEqualTo 2) then {
				BRPVP_drawIcon3D pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\setacha"+str _forEachIndex+".paa",[1,1,1,1],_x+[0],0.65,0.65,0,"",0,0.025];
				BRPVP_drawIcon3D pushBack ["",[0,0.8,0,1],_x+[0],0.65,0.65,0,[1,_txt,(_x+[0]) distance BRPVP_myCenter] call BRPVP_txtIconCreate,0,0.025];
			};
			if (_count isEqualTo 3) then {
				BRPVP_drawIcon3D pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\setabu"+str _forEachIndex+".paa",[1,1,1,1],_x,0.65,0.65,0,"",0,0.025];
				BRPVP_drawIcon3D pushBack ["",[0,0.8,0,1],_x,0.65,0.65,0,[1,_txt,_x distance BRPVP_myCenter] call BRPVP_txtIconCreate,0,0.025];
			};
		};
	} forEach (_obj getVariable ["sts",[]]);
};
BRPVP_checaAcessoPlayer = {
	params ["_player","_obj"];
	private ["_id_bd","_amg","_oOwn","_oAmg","_oShareT","_retorno","_oAmgCustom","_oAmgCustomUse"];
	//MINHAS RELACOES
	_id_bd = _player getVariable ["id_bd",-1];
	_amg = _player getVariable ["amg",[]];

	//RELACOES OBJ CHECADO
	private _safeOwner = (_obj getVariable ["brpvp_safe_owner",[]])-[objNull];
	if (_safeOwner isEqualTo []) then {
		_oOwn = _obj getVariable ["own",-1];
		_oAmg = _obj getVariable ["amg",[[],[]]];
		_oShareT = _obj getVariable ["stp",1];
	} else {
		_oOwn = if (objectParent _player isEqualTo _obj) then {-1} else {-2};
		_oAmg = [];
		{_oAmg append ((_x getVariable ["amg",[]])+[_x getVariable ["id_bd",-1]]);} forEAch _safeOwner;
		_oShareT = 1;
	};
	if (count _oAmg isEqualTo 0 || {typeName (_oAmg select 0) isEqualTo "SCALAR"}) then {
		_oAmg = [_oAmg,[],_oShareT in [1,2]];
	} else {
		if (count _oAmg isEqualTo 2 && typeName (_oAmg select 0) isEqualTo "ARRAY") then {
			_oAmg pushBack (_oShareT in [1,2]);
		};
	};
	_oAmgCustom = _oAmg select 1;
	_oAmgCustomUse = _oAmg select 2;
	_oAmg = _oAmg select 0;

	_retorno = false;
	private _hacked = if (_obj getVariable ["brpvp_hacked",false]) then {
		private _places = _obj getVariable ["brpvp_hacked_places",[]];
		private _hackOk1 = if (_places isEqualTo []) then {
			true
		} else {
			_posASL = getPosASL _player;
			_inHackPlace = false;
			{if (_posASL distanceSqr _x < 8) exitWith {_inHackPlace = true;};} forEach _places;
			_inHackPlace
		};
		private _st = serverTime;
		private _time = _obj getVariable ["brpvp_hacked_time",_st];
		private _hackOk2 = _st-_time <= BRPVP_masterKeyDuration;
		_hackOk1 && _hackOk2
	} else {
		false
	};
	if !(_oShareT isEqualTo 4 && !BRPVP_vePlayers && !_hacked) then {
		if (BRPVP_vePlayers || _hacked || _oOwn isEqualTo -1 || _id_bd isEqualTo _oOwn || _oShareT isEqualTo 3) then {
			_retorno = true;
		} else {
			if (_oShareT != 0) then {
				if (_oShareT isEqualTo 1) then {
					if (_id_bd in _oAmg) then {_retorno = true;};
				} else {
					if (_oShareT isEqualTo 2) then {
						if (_id_bd in _oAmg && _oOwn in _amg) then {_retorno = true;};
					};
				};
			};
		};
	};
	if (!_retorno && _oAmgCustomUse) then {if (_id_bd in _oAmgCustom) then {_retorno = true;};};
	
	//CHECK ACCESS TROUGHT SQUAD PALS
	_grpUnits = units group _player-[_player];
	if !(_retorno || _grpUnits isEqualTo []) then {
		_isLv = _obj isKindOf "LandVehicle";
		_isSw = _obj isKindOf "StaticWeapon";
		_isA = _obj isKindOf "Air";
		_isB = _obj isKindOf "Building";
		{
			_sharePal = _x getVariable ["brpvp_my_squad_share",[]];
			_idbdPal = _x getVariable ["id_bd",-1];
			if (_idbdPal isEqualTo _oOwn) then {
				if ((0 in _sharePal && _isLv && !_isSw) || (1 in _sharePal && _isA) || (2 in _sharePal && _isB) || (3 in _sharePal && _isSw)) exitWith {_retorno = true;};
			};
		} forEach _grpUnits;
	};
	
	_retorno
};
BRPVP_checaAcesso = {
	private ["_id_bd","_amg","_oOwn","_oAmg","_oShareT","_retorno","_oAmgCustom","_oAmgCustomUse"];
	//MINHAS RELACOES
	_id_bd = player getVariable ["id_bd",-1];
	_amg = player getVariable ["amg",[]];

	//RELACOES OBJ CHECADO
	private _safeOwner = (_this getVariable ["brpvp_safe_owner",[]])-[objNull];
	if (_safeOwner isEqualTo []) then {
		_oOwn = _this getVariable ["own",-1];
		_oAmg = _this getVariable ["amg",[[],[]]];
		_oShareT = _this getVariable ["stp",1];
	} else {
		_oOwn = if (objectParent player isEqualTo _this) then {-1} else {-2};
		_oAmg = [];
		{_oAmg append ((_x getVariable ["amg",[]])+[_x getVariable ["id_bd",-1]]);} forEAch _safeOwner;
		_oShareT = 1;
	};
	if (count _oAmg isEqualTo 0 || {typeName (_oAmg select 0) isEqualTo "SCALAR"}) then {
		_oAmg = [_oAmg,[],_oShareT in [1,2]];
	} else {
		if (count _oAmg isEqualTo 2 && typeName (_oAmg select 0) isEqualTo "ARRAY") then {
			_oAmg pushBack (_oShareT in [1,2]);
		};
	};
	_oAmgCustom = _oAmg select 1;
	_oAmgCustomUse = _oAmg select 2;
	_oAmg = _oAmg select 0;

	_retorno = false;
	private _hacked = if (_this getVariable ["brpvp_hacked",false]) then {
		private _places = _this getVariable ["brpvp_hacked_places",[]];
		private _hackOk1 = if (_places isEqualTo []) then {
			true
		} else {
			_posASL = getPosASL player;
			_inHackPlace = false;
			{if (_posASL distanceSqr _x < 8) exitWith {_inHackPlace = true;};} forEach _places;
			_inHackPlace
		};
		private _st = serverTime;
		private _time = _this getVariable ["brpvp_hacked_time",_st];
		private _hackOk2 = _st-_time <= BRPVP_masterKeyDuration;
		_hackOk1 && _hackOk2
	} else {
		false
	};
	if !(_oShareT isEqualTo 4 && !BRPVP_vePlayers && !_hacked) then {
		if (BRPVP_vePlayers || _hacked || _oOwn isEqualTo -1 || _id_bd isEqualTo _oOwn || _oShareT isEqualTo 3) then {
			_retorno = true;
		} else {
			if (_oShareT != 0) then {
				if (_oShareT isEqualTo 1) then {
					if (_id_bd in _oAmg) then {_retorno = true;};
				} else {
					if (_oShareT isEqualTo 2) then {
						if (_id_bd in _oAmg && _oOwn in _amg) then {_retorno = true;};
					};
				};
			};
		};
	};
	if (!_retorno && _oAmgCustomUse) then {if (_id_bd in _oAmgCustom) then {_retorno = true;};};
	
	//CHECK ACCESS TROUGHT SQUAD PALS
	_grpUnits = units group player-[player];
	if !(_retorno || _grpUnits isEqualTo []) then {
		_isLv = _this isKindOf "LandVehicle";
		_isSw = _this isKindOf "StaticWeapon";
		_isA = _this isKindOf "Air";
		_isB = _this isKindOf "Building";
		{
			_sharePal = _x getVariable ["brpvp_my_squad_share",[]];
			_idbdPal = _x getVariable ["id_bd",-1];
			if (_idbdPal isEqualTo _oOwn) then {
				if ((0 in _sharePal && _isLv && !_isSw) || (1 in _sharePal && _isA) || (2 in _sharePal && _isB) || (3 in _sharePal && _isSw)) exitWith {_retorno = true;};
			};
		} forEach _grpUnits;
	};
	
	_retorno
};
BRPVP_atualizaMeuStuffAmg = {
	private _amgPlayer = player getVariable ["amg",[]];
	private _stuffDouble = call BRPVP_findMyStuff;
	{
		if (!isNull _x) then {
			_amg = _x getVariable ["amg",[[],[],true]];
			_tempCst = (_x getVariable ["stp",-1]) in [1,2];
			_amg = if (count _amg isEqualTo 3) then {_amg} else {if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};};
			_amg set [0,_amgPlayer];
			_x setVariable ["amg",_amg,true];
			_setToSave = _x getVariable ["slv_amg",false] || _x getVariable ["slv",false];
			_isBdObj = _x getVariable ["id_bd",-1] isNotEqualTo -1;
			if (_isBdObj && !_setToSave) then {_x setVariable ["slv_amg",true,true];};
			if (_isBdObj && typeOf _x in BRP_kitAutoTurret) then {_x setVariable ["brpvp_tupdated",true,2];};
		};
	} forEach (_stuffDouble select 0);
	private _objsSoClass = [];
	private _objsSoIds = [];
	{
		if (!isNull _x) then {
			private _class = typeOf _x;
			private _id = _x getVariable ["id_bd",-1];
			private _idx = _objsSoClass find _class;
			if (_idx isEqualTo -1) then {
				_objsSoClass pushBack _class;
				_objsSoIds pushBack [_id];
			} else {
				(_objsSoIds select _idx) pushBack _id;
			};
		};
	} forEach (_stuffDouble select 1);
	private _objsSoClassCVL = [];
	private _objsSoIdsCVL = [];
	{
		if (!isNull _x) then {
			private _class = typeOf _x;
			private _id = _x getVariable ["id_bd",-1];
			private _idx = _objsSoClassCVL find _class;
			if (_idx isEqualTo -1) then {
				_objsSoClassCVL pushBack _class;
				_objsSoIdsCVL pushBack [_id];
			} else {
				(_objsSoIdsCVL select _idx) pushBack _id;
			};
		};
	} forEach (_stuffDouble select 2);
	{
		if (!isNull _x) then {
			private _amg = _x getVariable ["amg",[[],[],true]];
			private _tempCst = (_x getVariable ["stp",-1]) in [1,2];
			_amg = if (count _amg isEqualTo 3) then {_amg} else {if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};};
			_amg set [0,_amgPlayer];
			_x setVariable ["amg",_amg,true];
			private _setToSave = _x getVariable ["slv_amg",false];
			private _isGodHouseObj = _x getVariable ["brpvp_map_god_mode_house_id",-1] isNotEqualTo -1;
			if (_isGodHouseObj && !_setToSave) then {_x setVariable ["slv_amg",true,true];};
		};
	} forEach (_stuffDouble select 3);

	[_objsSoClass,_objsSoIds,_amgPlayer] remoteExecCall ["BRPVP_atualizaMeuStuffAmgSimpleObject",0];
	[_objsSoClassCVL,_objsSoIdsCVL,_amgPlayer] remoteExecCall ["BRPVP_atualizaMeuStuffAmgSimpleObjectCVL",0];
	if (!isNull BRPVP_holderVault) then {BRPVP_holderVault setVariable ["amg",[_amgPlayer,[],false],true];};
	if (!isNull BRPVP_sellReceptacle) then {BRPVP_sellReceptacle setVariable ["amg",[_amgPlayer,[],false],true];};

	//UPDATE TURRET ARRAY ON SERVER/HC AND CLIENTS
	[player getVariable "id_bd",_amgPlayer] remoteExecCall ["BRPVP_turretsAddRemoveFriend",0];
};
BRPVP_compEstado = {
	private ["_estado","_amg","_customShare","_result"];
	_estado = _this getVariable ["stp",-1];
	_amg = _this getVariable ["amg",[[],[],_estado in [1,2]]];
	_customShare = if (count _amg isEqualTo 3 && {typeName (_amg select 0) == "ARRAY"}) then {_amg select 2} else {_estado in [1,2]};
	_result = "Unknow Share Type";
	if (_estado isEqualTo -1) then {
		_result = localize "str_menu23_opt3";
	} else {
		_sufix = if (_customShare) then {"_cst"} else {""};
		if (_estado isEqualTo 0) then {
			_result = localize ("str_menu23_opt0" + _sufix);
		} else {
			if (_estado isEqualTo 1) then {
				_result = localize ("str_menu23_opt1" + _sufix);
			} else {
				if (_estado isEqualTo 2) then {
					_result = localize ("str_menu23_opt2" + _sufix);
				} else {
					if (_estado isEqualTo 3) then {
						_result = localize ("str_menu23_opt3" + _sufix);
					} else {
						if (_estado isEqualTo 4) then {
							_result = localize ("str_menu23_opt4" + _sufix);
						};
					};
				};
			};
		};
	};
	_result
};
BRPVP_findMyStuff = {
	_id_bd = player getVariable ["id_bd",-1];
	_myStuff = [];
	_myStuffSo = [];
	_myStuffSoCVL = [];
	_myStuffGodModeHouse = [];
	if (_id_bd != -1) then {
		{if (_x getVariable ["own",-1] isEqualTo _id_bd) then {_myStuff pushBack _x;};} forEach (entities [["LandVehicle","Air","Ship","Land_Suitcase_F","Box_T_East_Wps_F"],[]]+BRPVP_ownedHouses);
		{if (_x getVariable ["own",-1] isEqualTo _id_bd) then {_myStuffSo pushBack _x;};} forEach allSimpleObjects [];
		{if (_x getVariable ["own",-1] isEqualTo _id_bd) then {_myStuffSoCVL pushBack _x;};} forEach BRPVP_allMissionObjectsCVL;
		{if (_x getVariable ["own",-1] isEqualTo _id_bd) then {_myStuffGodModeHouse pushBack _x;};} forEach BRPVP_godModeHouseObjects;
		[_myStuff,_myStuffSo,_myStuffSoCVL,_myStuffGodModeHouse]
	};
};
BRPVP_fixAmgIfNeeded = {
	private _id_bd = player getVariable ["id_bd",-1];
	private _pAmg = player getVariable ["amg",[]];
	if (_id_bd isNotEqualTo -1) then {
		{
			if (_x getVariable ["own",-1] isEqualTo _id_bd || _x getVariable ["brpvp_map_god_mode_house_id",-1] isEqualTo _id_bd) then {
				if (!isSimpleObject _x) then {
					private _xAmg = _x getVariable ["amg",[[],[],true]];
					if !((_xAmg select 0) isEqualTo _pAmg) then {
						_xAmg set [0,_pAmg];
						_x setVariable ["amg",_xAmg,true];
						if !(_x getVariable ["slv_amg",false]) then {_x setVariable ["slv_amg",true,true];};
					};
				};					
			};
		} forEach (entities [["LandVehicle","Air","Ship"],[]]+BRPVP_ownedHouses+BRPVP_godModeHouseObjects);
	};
};
BRPVP_findMySpawns = {
	_id_bd = player getVariable ["id_bd",-1];
	_respawnSpot = [];
	_kitsRespawn = BRP_kitRespawnA+BRP_kitRespawnB;
	if (_id_bd != -1) then {
		{if (_x getVariable ["own",-1] isEqualTo _id_bd && {typeOf _x in _kitsRespawn}) then {_respawnSpot pushBack _x;};} forEach (BRPVP_ownedHouses+allSimpleObjects _kitsRespawn);
	};
	_respawnSpot
};
BRPVP_findMyFlags = {
	private _myStuffOthers = [];
	{if (_x getVariable ["id_bd",-1] isNotEqualTo -1 && ([player,_x] call BRPVP_checaAcessoRemotoFlag || BRPVP_vePlayers)) then {_myStuffOthers pushBack _x;};} forEach BRPVP_allFlags;
	BRPVP_myStuffOthers = +_myStuffOthers;

	private _myFlagsSeeBuildingsOnMap = [];
	private _allObjs = [];	
	{
		private _flag = _x;
		private _radius = _flag getVariable ["brpvp_flag_radius",0];
		private _tryObjs = (nearestObjects [_flag,[],_radius,true])-_allObjs;
		private _fObjs = _tryObjs select {(_x getVariable ["id_bd",-1] isNotEqualTo -1 || _x getVariable ["brpvp_map_god_mode_house_id",-1] isNotEqualTo -1) && {_x call BRPVP_isBaseMapDraw}};
		_allObjs append _fObjs;
		_myFlagsSeeBuildingsOnMap pushBack [_flag,_radius,_fObjs];
	} forEach BRPVP_myStuffOthers;
	BRPVP_myFlagsSeeBuildingsOnMap = +_myFlagsSeeBuildingsOnMap;
};
BRPVP_mudaDonoPropriedade = {
	params ["_obj","_newOwner"];
	if (isNull _newOwner) then {
		_obj setVariable ["own",-1,true];
		_obj setVariable ["amg",[[],[],true],true];
		_obj setVariable ["stp",1,true];
	} else {
		_obj setVariable ["own",_newOwner getVariable "id_bd",true];
		_amg = _obj getVariable ["amg",[[],[],true]];
		_amgCst = if (count _amg > 1) then {_amg select 1} else {[]};
		_amgCstBoo = if (count _amg > 2) then {_amg select 2} else {true};
		_obj setVariable ["amg",[_newOwner getVariable ["amg",[]],_amgCst,_amgCstBoo],true];

		//UPDATE INSURANCE IF VEHICLE
		if (_obj call BRPVP_isMotorizedNoTurret) then {
			_vehIdBd = _obj getVariable ["id_bd",-1];
			_newOwnerIdBd = _newOwner getVariable "id_bd";
			if (_vehIdBd > -1) then {[_vehIdBd,_newOwnerIdBd] remoteExecCall ["BRPVP_updateInsuranceOwner",2];};
		};
	};
	
	//GENERAL OBJECT UPDATES
	if !(_obj getVariable ["slv_amg",false] || _obj getVariable ["slv",false]) then {_obj setVariable ["slv_amg",true,true];};
	if (typeOf _obj in BRP_kitAutoTurret) then {_obj setVariable ["brpvp_tupdated",true,2];};

	//MY UPDATES RELATIVE TO THE OBJECT
	if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
	
	//OBJECT RECEIVER UPDATES RELATIVE TO THE OBJECT
	if (!isNull _newOwner) then {
		[
			_obj,
			{
				sleep 0.25;
				if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
				[localize "str_props_received",-4] call BRPVP_hint;
			}
		] remoteExec ["spawn",_newOwner];
	};
};
BRPVP_changePropsOwnerMany = {
	params ["_objs","_newOwner"];
	if (!isNull _newOwner) then {
		{
			_obj = _x;
			_obj setVariable ["own",_newOwner getVariable "id_bd",true];
			_amg = _obj getVariable ["amg",[[],[],true]];
			_amgCst = if (count _amg > 1) then {_amg select 1} else {[]};
			_amgCstBoo = if (count _amg > 2) then {_amg select 2} else {true};
			_obj setVariable ["amg",[_newOwner getVariable ["amg",[]],_amgCst,_amgCstBoo],true];
			if !(_obj getVariable ["slv_amg",false] || _obj getVariable ["slv",false]) then {_obj setVariable ["slv_amg",true,true];};

			//UPDATE INSURANCE IF VEHICLE
			if (_obj call BRPVP_isMotorizedNoTurret) then {
				_vehIdBd = _obj getVariable ["id_bd",-1];
				_newOwnerIdBd = _newOwner getVariable "id_bd";
				if (_vehIdBd > -1) then {[_vehIdBd,_newOwnerIdBd] remoteExecCall ["BRPVP_updateInsuranceOwner",2];};
			};
		} forEach _objs;

		//MY UPDATES RELATIVE TO THE OBJECT
		if (BRPVP_stuff in _objs) then {BRPVP_stuff = objNull;};
		if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
		call BRPVP_findMyFlags;

		//OBJECT RECEIVER UPDATES RELATIVE TO THE OBJECT
		[
			_objs,
			{
				sleep 0.25;
				if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
				call BRPVP_findMyFlags;
			}
		] remoteExec ["spawn",_newOwner];
	};
};

diag_log ("[SCRIPT] clientOnlyFunctions.sqf END: " + str round (diag_tickTime - _scriptStart));