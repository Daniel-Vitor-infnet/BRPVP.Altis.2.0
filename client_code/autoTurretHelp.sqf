//SET UAV TURRET TYPE AND DISTANCE
BRPVP_actualAutoTurretsDistUAV = BRPVP_autoTurretFireRange select 1;
BRPVP_actualAutoTurretsForgiveDistUAV = BRPVP_autoTurretFireRangeForgive select 1;
BRPVP_actualAutoTurretsUAV = BRPVP_autoTurretOnLandVehicle;
BRPVP_autoTurretExtraCodeUAV = {["car",_this] call BRPVP_checkTurretType};
BRPVP_allTurretsOnMeRedLast = [];
BRPVP_allTurretsOnMeRed = [];
BRPVP_allTurretsOnMeRedSeeLast = [];
BRPVP_allTurretsOnMeRedSee = [];
BRPVP_setTurretTypesUAV = {
	private _veiculo = _this;
	if (_veiculo isKindOf "LandVehicle") then {
		private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _veiculo >> "armor");
		BRPVP_actualAutoTurretsDistUAV = BRPVP_autoTurretFireRange select 1;
		BRPVP_actualAutoTurretsForgiveDistUAV = BRPVP_autoTurretFireRangeForgive select 1;
		BRPVP_actualAutoTurretsUAV = BRPVP_autoTurretOnLandVehicle;
		if (_armor < 100) then {
			BRPVP_autoTurretExtraCodeUAV = {["car",_this] call BRPVP_checkTurretType};
		} else {
			if (_armor >= 100 && _armor <= 200) then {
				BRPVP_autoTurretExtraCodeUAV = {["armor",_this] call BRPVP_checkTurretType};
				if (!(_veiculo getVariable ["brpvp_to_turret",false]) && _veiculo isKindOf "MRAP_03_base_F") then {_veiculo setVariable ["brpvp_to_turret",true,true];};
			} else {
				BRPVP_autoTurretExtraCodeUAV = {["harmor",_this] call BRPVP_checkTurretType && (typeOf _this in BRPVP_autoTurretTypesTitan || (_this getVariable ["brpvp_tlevel",1]) isEqualTo 2)};
				if !(_veiculo getVariable ["brpvp_to_turret",false]) then {_veiculo setVariable ["brpvp_to_turret",true,true];};
				if !(_veiculo getVariable ["brpvp_use_texplode",false]) then {_veiculo setVariable ["brpvp_use_texplode",true,true];};
			};
		};
	} else {
		if (_veiculo isKindOf "Plane") then {
			BRPVP_actualAutoTurretsUAV = BRPVP_autoTurretOnAirVehicle;
			BRPVP_actualAutoTurretsDistUAV = BRPVP_autoTurretFireRange select 3;
			BRPVP_actualAutoTurretsForgiveDistUAV = BRPVP_autoTurretFireRangeForgive select 3;
			BRPVP_autoTurretExtraCodeUAV = {["plane",_this] call BRPVP_checkTurretType};
		} else {
			if (_veiculo isKindOf "Air" || _veiculo isKindOf "Ship") then {
				BRPVP_actualAutoTurretsUAV = BRPVP_autoTurretOnAirVehicle;
				BRPVP_actualAutoTurretsDistUAV = BRPVP_autoTurretFireRange select 2;
				BRPVP_actualAutoTurretsForgiveDistUAV = BRPVP_autoTurretFireRangeForgive select 2;
				BRPVP_autoTurretExtraCodeUAV = {["air",_this] call BRPVP_checkTurretType};
			};
		};
	};
};
BRPVP_turretIsGroundedArray1 = [0,0,-0.3];
BRPVP_turretIsGrounded = {
	if ((_this getVariable ["own",-1]) isEqualTo -2) exitWith {true};
	private _pos = getPosASL _this;
	private _lis = lineIntersectsSurfaces [_pos,_pos vectorAdd BRPVP_turretIsGroundedArray1,_this,objNull,true,1,"GEOM","NONE"];
	_lis isNotEqualTo [] && !((_lis select 0 select 2) getVariable ["brpvp_construction_helper",false])
};

//SET TURRET VARIABLES
BRPVP_turretSetVariablesParams1 = ["_op","_tgt","_pts"];
BRPVP_turretSetVariables = {
	params BRPVP_turretSetVariablesParams1;
	_op setVariable ["brpvp_target",_tgt,true];
	_op setVariable ["brpvp_points",_pts,true];
	_op setVariable ["brpvp_missing",0];
};

//PLAYER CODE
BRPVP_turretsLast = [];
BRPVP_autoTurretHelpPlayer = {
	private _tPlayer = player;
	private _vtPlayer = vehicle player;

	//GET TURRETS
	BRPVP_turretsLast = BRPVP_turretsLast select {typeOf _x in BRPVP_actualAutoTurrets};
	private _shotTurrets = BRPVP_turretShotOn select {typeOf _x in BRPVP_actualAutoTurrets};
	private _fncTurrets = _vtPlayer nearEntities [BRPVP_actualAutoTurrets,BRPVP_actualAutoTurretsDist] select {_x call BRPVP_turretIsGrounded};
	private _allTurrets = BRPVP_turretsLast+_fncTurrets+_shotTurrets;
	private _turrets = (_allTurrets arrayIntersect _allTurrets) select {_x call BRPVP_autoTurretExtraCode};

	//REMOVE FRIEND AND NOT OK TURRETS
	private _turretsRemove = [];
	private _turretsNoFear = BRPVP_turretsLast+_shotTurrets;
	{
		private _op = _x getVariable ["brpvp_operator",objNull];
		private _isFriendOficial = _x call BRPVP_checaAcesso || {[_x,_tPlayer] call BRPVP_checkIfTurretIsFriendByFlag};
		private _isFriendByFear = !(_x in _turretsNoFear) && {!([_x,_vtPlayer] call BRPVP_checkIfTurretFlagIsOnRaidOrPlayerInReach)};
		private _isFriend = _isFriendOficial || _isFriendByFear;
		private _otherStops = !(_x call BRPVP_turretIsGrounded) || _x distance _vtPlayer > BRPVP_actualAutoTurretsForgiveDist || isNull _op || _op getVariable ["brpvp_dead",true] || BRPVP_safeZone || !(_tPlayer call BRPVP_pAlive) || (!isNull objectParent _tPlayer && !(alive objectParent _tPlayer));
		private _isBaseTest = (_tPlayer getVariable ["brpvp_base_test",0]) isEqualTo 1;
		if ((_isFriend && !_isBaseTest) || _otherStops) then {_turretsRemove pushBack (_turrets deleteAt _forEachIndex);};
	} forEachReversed _turrets;

	//REMOVE TARGET FROM OUT TURRETS
	{
		private _op = _x getVariable ["brpvp_operator",objNull];
		private _tgt = _op getVariable "brpvp_target";
		private _isActNull = isNull _tgt && (_op getVariable "brpvp_points" > 0 || _op getVariable ["brpvp_missing",0] > 0);
		if (_tgt isEqualTo _tPlayer || _isActNull) then {[_op,objNull,0] call BRPVP_turretSetVariables;};
	} forEach _turretsRemove;

	//SET ME AS TARGET IF I'M THE BEST OPTION
	private _noSeeRemove = [];
	{
		private _operator = _x getVariable ["brpvp_operator",objNull];
		private _eyePosGunner = eyePos _operator;
		private _eyePosPlayer = if (_vtPlayer isEqualTo _tPlayer) then {eyePos _tPLayer} else {aimPos _vtPlayer};
		private _vis = [_x,"VIEW",_vtPlayer] checkVisibility [_eyePosGunner,_eyePosPlayer];
		private _turretAinVec = _x weaponDirection ((weapons _x) select 0);
		private _turretToTargetVec = _eyePosPlayer vectorDiff _eyePosGunner;
		private _angle = (acos (_turretAinVec vectorCos _turretToTargetVec))/180;
		private _dist = ((_x distance _vtPlayer)/BRPVP_actualAutoTurretsForgiveDist) min 1;
		private _points = (_vis*3+(1-_angle)*2+(1-_dist)*1)/6;
		private _actualPoints = _operator getVariable "brpvp_points";
		if ((_operator getVariable "brpvp_target") isEqualTo _tPlayer) then {
			private _fromZero = _actualPoints isEqualTo 0 && _points isNotEqualTo 0;
			private _pChanged = _actulPoints isNotEqualTo 0 && {abs (1-_points/_actualPoints) >= 0.1};
			if (_fromZero || _pChanged) then {_operator setVariable ["brpvp_points",_points,true];};
			if (_vis < 0.35 || _angle > 0.65) then {
				private _newMis = (_operator getVariable ["brpvp_missing",0])+_delta;
				if (_newMis > BRPVP_baseTurretNoSeeSearchTime) then {
					[_operator,objNull,0] call BRPVP_turretSetVariables;
					_noSeeRemove pushBack _x;
				} else {
					BRPVP_allTurretsOnMeRed pushBackUnique _x;
					_operator setVariable ["brpvp_missing",_newMis,false];
				};
			} else {
				BRPVP_allTurretsOnMeRed pushBackUnique _x;
				BRPVP_allTurretsOnMeRedSee pushBackUnique _x;
				_operator setVariable ["brpvp_missing",0,false];
			};
		} else {
			private _canFocus = (_angle <= 0.65 && _vis > 0.7) || _x in _shotTurrets;
			if (_x call BRPVP_turretIsGrounded && _canFocus && (_actualPoints isEqualTo 0 || {_points/_actualPoints >= 1.1})) then {
				BRPVP_allTurretsOnMeRed pushBackUnique _x;
				BRPVP_allTurretsOnMeRedSee pushBackUnique _x;
				[_operator,_tPlayer,_points] call BRPVP_turretSetVariables;
			};
		};
	} forEach _turrets;
	BRPVP_turretsLast = _turrets-_noSeeRemove;
};

//UAV CODE
BRPVP_turretProcSleepUAV = true;
BRPVP_turretsLastUAV = [];
BRPVP_turretLastObjUAV = objNull;
BRPVP_autoTurretHelpUAV = {
	private _tUAV = BRPVP_myUAVNow;
	if (isNull _tUAV) then {
		if (!BRPVP_turretProcSleepUAV) then {
			//REMOVE TARGET FROM TURRETS
			{
				private _op = _x getVariable ["brpvp_operator",objNull];
				if ((_op getVariable "brpvp_target") isEqualTo BRPVP_turretLastObjUAV) then {[_op,objNull,0] call BRPVP_turretSetVariables;};
			} forEach BRPVP_turretsLastUAV;
			BRPVP_turretProcSleepUAV = true;
			BRPVP_turretsLastUAV = [];
			BRPVP_turretLastObjUAV = objNull;
		};
	} else {
		BRPVP_turretProcSleepUAV = false;
		private _tUAVChanged = _tUAV isNotEqualTo BRPVP_turretLastObjUAV;
		if (_tUAVChanged) then {
			//REMOVE TARGET FROM TURRETS
			{
				private _op = _x getVariable ["brpvp_operator",objNull];
				private _tgt = _op getVariable "brpvp_target";
				private _isActNull = isNull _tgt && (_op getVariable "brpvp_points" > 0 || _op getVariable ["brpvp_missing",0] > 0);
				if (_tgt isEqualTo BRPVP_turretLastObjUAV || _isActNull) then {[_op,objNull,0] call BRPVP_turretSetVariables;};
			} forEach BRPVP_turretsLastUAV;
			BRPVP_turretsLastUAV = [];

			_tUAV call BRPVP_setTurretTypesUAV;
		};

		//GET TURRETS
		//BRPVP_turretsLastUAV = BRPVP_turretsLastUAV select {typeOf _x in BRPVP_actualAutoTurretsUAV};
		private _shotTurrets = BRPVP_turretShotOn select {typeOf _x in BRPVP_actualAutoTurretsUAV};
		private _fncTurrets = _tUAV nearEntities [BRPVP_actualAutoTurretsUAV,BRPVP_actualAutoTurretsDistUAV] select {_x call BRPVP_turretIsGrounded};
		private _allTurrets = BRPVP_turretsLastUAV+_fncTurrets+_shotTurrets;
		private _turrets = (_allTurrets arrayIntersect _allTurrets) select {_x call BRPVP_autoTurretExtraCodeUAV};

		//REMOVE FRIEND AND NOT OK TURRETS
		private _tsRemove = [];
		private _tsNoFear = BRPVP_turretsLastUAV+_shotTurrets;
		{
			private _op = _x getVariable ["brpvp_operator",objNull];
			private _isFriendOficial = _x call BRPVP_checaAcesso || {[_x,player] call BRPVP_checkIfTurretIsFriendByFlag};
			private _isFriendByFear = !(_x in _tsNoFear) && {!([_x,_tUAV] call BRPVP_checkIfTurretFlagIsOnRaidOrPlayerInReach)};
			private _isFriend = _isFriendOficial || _isFriendByFear;
			private _otherStops = !(_x call BRPVP_turretIsGrounded) || x distance _tUAV > BRPVP_actualAutoTurretsForgiveDistUAV || isNull _op || _op getVariable ["brpvp_dead",true] || !(_tUAV call BRPVP_pAlive) || !(player call BRPVP_pAlive);
			private _isBaseTest = (player getVariable ["brpvp_base_test",0]) isEqualTo 1;
			if ((_isFriend && !_isBaseTest) || _otherStops) then {_tsRemove pushBack (_turrets deleteAt _forEachIndex);};
		} forEachReversed _turrets;

		//REMOVE TARGET FROM OUT TURRETS
		if (!_tUAVChanged) then {
			{
				private _op = _x getVariable ["brpvp_operator",objNull];
				if ((_op getVariable "brpvp_target") isEqualTo _tUAV) then {[_op,objNull,0] call BRPVP_turretSetVariables;};
			} forEach _tsRemove;
		};

		//SET ME AS TARGET IF I'M THE BEST OPTION
		private _noSeeRemove = [];
		{
			private _operator = _x getVariable ["brpvp_operator",objNull];
			private _eyePosGunner = eyePos _operator;
			private _eyePosPlayer = aimPos _tUAV;
			private _vis = [_x,"VIEW",_tUAV] checkVisibility [_eyePosGunner,_eyePosPlayer];
			private _turretAinVec = _x weaponDirection ((weapons _x) select 0);
			private _turretToTargetVec = _eyePosPlayer vectorDiff _eyePosGunner;
			private _angle = (acos (_turretAinVec vectorCos _turretToTargetVec))/180;
			private _dist = ((_x distance _tUAV)/BRPVP_actualAutoTurretsForgiveDistUAV) min 1;
			private _points = (_vis*3+(1-_angle)*2+(1-_dist)*1)/6;
			private _actualPoints = _operator getVariable "brpvp_points";
			if ((_operator getVariable "brpvp_target") isEqualTo _tUAV) then {
				private _fromZero = _actualPoints isEqualTo 0 && _points isNotEqualTo 0;
				private _pChanged = _actulPoints isNotEqualTo 0 && {abs (1-_points/_actualPoints) >= 0.1};
				if (_fromZero || _pChanged) then {_operator setVariable ["brpvp_points",_points,true];};
				if (_vis < 0.35 || _angle > 0.65) then {
					private _newMis = (_operator getVariable ["brpvp_missing",0])+_delta;
					if (_newMis > BRPVP_baseTurretNoSeeSearchTime) then {
						[_operator,objNull,0] call BRPVP_turretSetVariables;
						_noSeeRemove pushBack _x;
					} else {
						BRPVP_allTurretsOnMeRed pushBackUnique _x;
						_operator setVariable ["brpvp_missing",_newMis,false];
					};
				} else {
					BRPVP_allTurretsOnMeRed pushBackUnique _x;
					BRPVP_allTurretsOnMeRedSee pushBackUnique _x;
					_operator setVariable ["brpvp_missing",0,false];
				};
			} else {
				private _canFocus = (_angle <= 0.65 && _vis > 0.7) || _x in _shotTurrets;
				if (_x call BRPVP_turretIsGrounded && _canFocus && (_actualPoints isEqualTo 0 || {_points/_actualPoints >= 1.1})) then {
					BRPVP_allTurretsOnMeRed pushBackUnique _x;
					BRPVP_allTurretsOnMeRedSee pushBackUnique _x;
					[_operator,_tUAV,_points] call BRPVP_turretSetVariables;
				};
			};
		} forEach _turrets;
		BRPVP_turretsLastUAV = _turrets-_noSeeRemove;
		BRPVP_turretLastObjUAV = _tUAV;
	};
};

//TURRET ON BOT CODE
BRPVP_turretProcSleepBot = true;
BRPVP_turretsLastBot = [];
BRPVP_tBotLast = objNull;
BRPVP_autoTurretHelpBot = {
	private _tBot = BRPVP_tBot;
	if (isNull _tBot) then {
		if (!BRPVP_turretProcSleepBot) then {
			//REMOVE TARGET FROM TURRETS
			{
				private _op = _x getVariable ["brpvp_operator",objNull];
				if ((_op getVariable "brpvp_target") isEqualTo BRPVP_tBotLast) then {[_op,objNull,0] call BRPVP_turretSetVariables;};
			} forEach BRPVP_turretsLastBot;
			BRPVP_turretProcSleepBot = true;
			BRPVP_turretsLastBot = [];
			BRPVP_tBotLast = objNull;
		};
	} else {
		BRPVP_turretProcSleepBot = false;
		private _vtBot = vehicle _tBot;
		private _tBotChanged = _tBot isNotEqualTo BRPVP_tBotLast;
		if (_tBotChanged) then {
			//REMOVE TARGET FROM TURRETS
			{
				private _op = _x getVariable ["brpvp_operator",objNull];
				private _tgt = _op getVariable "brpvp_target";
				private _isActNull = isNull _tgt && (_op getVariable "brpvp_points" > 0 || _op getVariable ["brpvp_missing",0] > 0);
				if (_tgt isEqualTo BRPVP_tBotLast || _isActNull) then {[_op,objNull,0] call BRPVP_turretSetVariables;};
			} forEach BRPVP_turretsLastBot;
			BRPVP_turretsLastBot = [];
		};

		//GET TURRET CFG VARIABLES
		private _actualAutoTurrets = [];
		private _actualAutoTurretsDist = 0;
		private _actualAutoTurretsForgiveDist = 0;
		objectParent _tBot call BRPVP_setTurretTypesBot;
		_actualAutoTurretsDist = _actualAutoTurretsForgiveDist;

		//GET TURRETS
		BRPVP_turretsLastBot = BRPVP_turretsLastBot select {typeOf _x in _actualAutoTurrets};
		private _fncTurrets = _vtBot nearEntities [_actualAutoTurrets,_actualAutoTurretsDist] select {_x call BRPVP_turretIsGrounded};
		private _turrets = BRPVP_turretsLastBot+_fncTurrets;
		_turrets = _turrets arrayIntersect _turrets;

		//REMOVE NOT MINE AND NOT OK TURRETS
		private _tsRemove = [];
		{
			private _op = _x getVariable ["brpvp_operator",objNull];
			if (_x call BRPVP_checaAcesso || {[_x,player] call BRPVP_checkIfTurretIsFriendByFlag}) then {
				if (_x distance _vtBot > _actualAutoTurretsForgiveDist || isNull _op || _op getVariable ["brpvp_dead",true] || !alive _tBot || !alive _vtBot) then {_tsRemove pushBack (_turrets deleteAt _forEachIndex);};
			} else {
				_tsRemove pushBack (_turrets deleteAt _forEachIndex);
			};
		} forEachReversed _turrets;

		//REMOVE TARGET FROM OUT TURRETS
		if (!_tBotChanged) then {
			{
				private _op = _x getVariable ["brpvp_operator",objNull];
				private _tgt = _op getVariable "brpvp_target";
				private _isActNull = isNull _tgt && (_op getVariable "brpvp_points" > 0 || _op getVariable ["brpvp_missing",0] > 0);
				if (_tgt isEqualTo _tBot || _isActNull) then {[_op,objNull,0] call BRPVP_turretSetVariables;};
			} forEach _tsRemove;
		};

		//SET BOT AS TARGET IF HE IS THE BEST OPTION
		{
			private _operator = _x getVariable ["brpvp_operator",objNull];
			private _eyePosGunner = eyePos _operator;
			private _eyePosBot = aimPos _vtBot;
			private _vis = [_x,"VIEW",_vtBot] checkVisibility [_eyePosGunner,_eyePosBot];
			private _turretToTargetVec = _eyePosBot vectorDiff _eyePosGunner;
			private _angle = (acos ((_x weaponDirection (weapons _x select 0)) vectorCos _turretToTargetVec))/180;
			private _dist = ((_x distance _vtBot)/_actualAutoTurretsForgiveDist) min 1;
			private _points = (_vis*3+(1-_angle)*2+(1-_dist)*1)/6;
			private _actualPoints = _operator getVariable "brpvp_points";
			if ((_operator getVariable "brpvp_target") isEqualTo _tBot) then {
				private _fromZero = _actualPoints isEqualTo 0 && _points isNotEqualTo 0;
				private _pChanged = _actulPoints isNotEqualTo 0 && {abs (1-_points/_actualPoints) >= 0.1};
				if (_fromZero || _pChanged) then {_operator setVariable ["brpvp_points",_points,true];};
				if (_vis < 0.35) then {
					private _newMis = (_operator getVariable ["brpvp_missing",0])+1.25;
					if (_newMis > 15) then {
						[_operator,objNull,0] call BRPVP_turretSetVariables;
					} else {
						_operator setVariable ["brpvp_missing",_newMis];
					};
				} else {
					_operator setVariable ["brpvp_missing",0];
				};
			} else {
				if (_x call BRPVP_turretIsGrounded && _vis > 0.7 && {_actualPoints isEqualTo 0 || {_points/_actualPoints >= 1.1}}) then {
					[_operator,_tBot,_points] call BRPVP_turretSetVariables;
				};
			};
		} forEach _turrets;
		BRPVP_turretsLastBot = _turrets;
		BRPVP_tBotLast = _tBot;
	};
};

//MESSAGES CODE
BRPVP_alarmLastTime = 0;
BRPVP_lastDangerLevel = 0;
BRPVP_autoTurretHelpMsg = {
	//SET DANGER LEVEL
	if (BRPVP_allTurretsOnMeRed isEqualTo []) then {BRPVP_autoTurretDangerLevel = 0;} else {BRPVP_autoTurretDangerLevel = 2;};
	if (BRPVP_autoTurretDangerLevel isNotEqualTo BRPVP_lastDangerLevel) then {
		BRPVP_lastDangerLevel = BRPVP_autoTurretDangerLevel;
		BRPVP_alarmLastTime = 0;
		if (BRPVP_autoTurretDangerLevel isEqualTo 0) then {["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\turret_warning_0.paa'/> X0 (0)",0,0,2,0,0,7757] call BRPVP_fnc_dynamicText;};
	};
	//SHOW DANGER MESSAGE
	if (BRPVP_autoTurretDangerLevel isEqualTo 2) then {
		if (_cTime - BRPVP_alarmLastTime > 5) then {
			BRPVP_alarmLastTime = _cTime;
			private _xSee = format [" (%1)",count BRPVP_allTurretsOnMeRedSee];
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\turret_warning_2.paa'/> X"+str count BRPVP_allTurretsOnMeRed+_xSee,0,0,1,0,0,7757] call BRPVP_fnc_dynamicText;
			"turret_alert" call BRPVP_playSound;
		};
	} else {
		BRPVP_alarmLastTime = 0;
	};
};

//MAIN LOOP
BRPVP_turretInit = -1;
BRPVP_autoTurretAllCodes = {
	private _cTime = time;
	private _delta = _cTime-BRPVP_turretInit;
	private _dLim = if (BRPVP_aTurretHelpSpecialCycle > 0) then {BRPVP_aTurretHelpSpecialCycle = BRPVP_aTurretHelpSpecialCycle-1;0.25} else {1};
	if (_delta > _dLim) then {
		BRPVP_allTurretsOnMeOrange = [];
		BRPVP_allTurretsOnMeRed = [];
		BRPVP_allTurretsOnMeRedSee = [];
		BRPVP_turretInit = _cTime;
		call BRPVP_autoTurretHelpPlayer;
		call BRPVP_autoTurretHelpUAV;
		call BRPVP_autoTurretHelpBot;
		call BRPVP_autoTurretHelpMsg;
		if (BRPVP_allTurretsOnMeRed isNotEqualTo BRPVP_allTurretsOnMeRedLast || BRPVP_allTurretsOnMeRedSee isNotEqualto BRPVP_allTurretsOnMeRedSeeLast) then {
			BRPVP_allTurretsOnMeRedLast = +BRPVP_allTurretsOnMeRed;
			BRPVP_allTurretsOnMeRedSeeLast = +BRPVP_allTurretsOnMeRedSee;
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[BRPVP_allTurretsOnMeRed,BRPVP_allTurretsOnMeRedSee] remoteExecCall ["BRPVP_sendTurretsOnSpected",BRPVP_specOnMeMachinesNoMe];};
		};
	};
};
addMissionEventHandler ["EachFrame",{call BRPVP_autoTurretAllCodes;}];