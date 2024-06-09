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
diag_log "[SCRIPT] playerInit.sqf BEGIN";

//CODIGO A SER RODADO APENAS UMA VEZ
if (isNil "BRPVP_primeiraRodadaOk") then {
	//SET CORRECT WEATHER TRANSITION
	if (BRPVP_useDynamicWeather && !isServer) then {
		player remoteExecCall ["BRPVP_askServerForSyncWeatherProcess",2];
		waitUntil {!isNil "BRPVP_weatherOvercastJoingPlayerNow"};
		
		private _syncOk = true;
		private _totalTries = 0;

		//TRY TO SYNC 1
		private _minError1 = 1;
		private _error = 1;
		private _count = 1;
		while {_error > 0.025 && _count <= 5} do {
			isNil {skipTime -24;skipTime 24;simulWeatherSync;0 setFog 0;};
			_error = abs (overcast-BRPVP_weatherOvercastJoingPlayerNow);
			if (_error < _minError1) then {_minError1 = _error;};
			_totalTries = _totalTries+1;
			_count = _count+1;
		};
		if (_count isEqualTo 6) then {
			//TRY TO SYNC 2
			private _minError2 = 1;
			private _error = 1;
			private _count = 1;
			while {_error > 0.050 && _count <= 5} do {
				isNil {skipTime -48;skipTime 48;simulWeatherSync;0 setFog 0;};
				_error = abs (overcast-BRPVP_weatherOvercastJoingPlayerNow);
				if (_error < _minError2) then {_minError2 = _error;};
				_totalTries = _totalTries+1;
				_count = _count+1;
			};
			if (_count isEqualTo 6) then {
				//TRY TO SYNC 3
				private _minError3 = 1;
				private _error = 1;
				private _count = 1;
				while {_error > (_minError1+_minError2)/2 && _count <= 5} do {
					isNil {skipTime -24;skipTime 24;simulWeatherSync;0 setFog 0;};
					_error = abs (overcast-BRPVP_weatherOvercastJoingPlayerNow);
					if (_error < _minError3) then {_minError3 = _error;};
					_totalTries = _totalTries+1;
					_count = _count+1;
				};
				if (_minError3 > 0.2) then {
					1000 cutText ["Initial Weather Sync not possible!\nYour initial weather may not match other players.","PLAIN DOWN"];
					_syncOk = false;
				};
			};
		};
		if (_syncOk) then {systemChat format ["Weather Sync ok after %1 tries.",_totalTries];} else {systemChat format ["Weather Sync failed after %1 tries.",_totalTries];};
		private _mIds = BRPVP_weatherDebugMachinesOn+[2];
		_mIds pushBackUnique clientOwner;
		player setVariable ["brpvp_client_overcast",overcast,_mIds];
		publicVariableServer "BRPVP_iAskForInitialVarsJoiningRemove";
	};

	mapAnimAdd [0,0.25,BRPVP_centroMapa];
	mapAnimCommit;

	BRPVP_thiefToEquip = [
		"BRP_zombieSpawn",
		"Mag_BRPVP_veh_ownerity",
		"BRPVP_hulk_pills",
		"BRPVP_drone_finder",
		"Mag_BRPVP_z_blood_bag",
		"BRPVP_turnInBandit",
		"BRPVP_playerLaunch",
		"BRPVP_baseMine",
		"BRPVP_uberPack",
		"BRPVP_boxeItem",
		"BRPVP_bodyChange",
		"BRPVP_possession",
		"BRPVP_possessionStrong",
		"BRPVP_possessionPlayer",
		"BRPVP_uberAttack",
		"BRPVP_kriptonite",
		"BRPVP_kriptoniteRed",
		"BRPVP_divineFire",
		"BRPVP_atomicShot",
		"BRPVP_prideAtomicShot",
		"BRPVP_playerLaunchSuper",
		"BRPVP_voodooDoll"
	];

	BRPVP_specialItemsforHotkeys = [
		"BRPVP_playerLaunch",
		"BRPVP_uberPack",
		"BRPVP_kriptonite",
		"BRPVP_kriptoniteRed",
		"BRPVP_itemMagnet",
		"BRPVP_vehicleTorque",
		"BRPVP_baseMine",
		"BRP_boxThief",
		"BRP_vehicleThief",
		"BRP_doorThief",
		"BRPVP_minervaShot",
		"BRPVP_noGrass",
		"BRPVP_hulk_pills",
		"BRPVP_vehicleAmmo",
		"BRPVP_possession",
		"BRPVP_possessionStrong",
		"BRPVP_possessionPlayer",
		"BRPVP_trench",
		"Mag_BRPVP_fuel_gallon",
		"BRPVP_uberAttack",
		"BRPVP_secCam",
		"BRP_hackTool",
		"BRP_identifier",
		"BRP_remoteControl",
		"BRP_zombieSpawn",
		"Mag_BRPVP_scanner_100",
		"Mag_BRPVP_scanner_200",
		"Mag_BRPVP_scanner_300",
		"BRPVP_baseBomb",
		"BRPVP_antiBaseBomb",
		"BRPVP_foodApple",
		"BRPVP_foodCanned",
		"BRPVP_foodBread",
		"BRPVP_foodWater",
		"BRPVP_foodCake",
		"BRPVP_foodBurger",
		"BRPVP_foodEnergyDrink",
		"BRP_vodka",
		"BRPVP_xrayItem",
		"BRPVP_miraculousEyeDrop"
	];

	//SHIP HELP CODE
	call compileFinal preprocessFileLineNumbers "map_specific\shipHelp.sqf";
	call BRPVP_shipHelpOnNoShipVehicle;

	BRPVP_specialItemsforHotkeys = BRPVP_specialItemsforHotkeys-(BRPVP_specialItemsforHotkeys-BRPVP_specialItems);

	BRPVP_allowBrpvpHint = false;
	
	//MONEY MACHINES
	BRPVP_moneyMachines = nearestObjects [BRPVP_centroMapa,["Land_Atm_01_F","Land_Atm_02_F"],BRPVP_centroMapaRadius,true];

	//GET SIMPLE OBJECTS FROM SERVER
	_initSO = time;
	BRPVP_tireAllTiresGlobal = [];
	clientOwner remoteExecCall ["BRPVP_initialSimpleObjectsToClient",2];

	//IMPEDE QUE O CODIGO RODE DE NOVO
	BRPVP_primeiraRodadaOk = 1;

	//CORRECT VAR LIMIT
	BRPVP_bulletDistanceToAlertAI = BRPVP_bulletDistanceToAlertAI min 30;
	
	//CHANGE PLAYER GROUP TO PREVENT WRONG USE OF OLD SQUAD GROUP
	if (count units group player > 1) then {
		_newPlayerGroup = createGroup [EAST,true];
		[player] joinSilent _newPlayerGroup;
	};

	//RULES
	if (BRPVP_rulesRequireAccept) then {
		BRPVP_seeRules = {
			disableSerialization;
			private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
			playSound "admin_msg";
			BRPVP_rulesPage = 0;
			BRPVP_rulesOk = nil;
			while {isNil "BRPVP_rulesOk"} do {
				private _c = count BRPVP_rulesList;
				private _cNew = 10*ceil (_c/10);
				private _rulesList = BRPVP_rulesList;
				for "_i" from _c to (_cNew-1) do {_rulesList set [_i,""];};			
				BRPVP_rulesPage = (BRPVP_rulesPage max 0) min ((_cNew/10)-1);
				_rulesPageNow = BRPVP_rulesPage;
				_rulesList = _rulesList select [BRPVP_rulesPage*10,10];
				private _lines = count _rulesList;
				{
					_id = 79866+_forEachIndex;
					_display ctrlCreate ["RscStructuredText",_id];
					(_display displayCtrl _id) ctrlSetPosition [0,_forEachIndex * 0.95/_lines,1,0.85/_lines];
					(_display displayCtrl _id) ctrlSetBackgroundColor ([[0.5,0.5,0.5,0.5],[0.25,0.25,0.25,0.5]] select (_forEachIndex mod 2));
					(_display displayCtrl _id) ctrlSetStructuredText parseText _x;
					(_display displayCtrl _id) ctrlCommit 0;

				} forEach _rulesList;
				_id1 = 79866+_lines;
				_id2 = _id1+1;
				_display ctrlCreate ["RscButton",_id1];
				(_display displayCtrl _id1) ctrlSetPosition [0,0.95,0.2,0.05];
				(_display displayCtrl _id1) ctrlSetText localize "str_rules_accept";
				(_display displayCtrl _id1) ctrlCommit 0;
				(_display displayCtrl _id1) ctrlAddEventHandler ["ButtonClick",{BRPVP_rulesOk = true;}];
				_display ctrlCreate ["RscButton",_id2];
				(_display displayCtrl _id2) ctrlSetPosition [0.8,0.95,0.2,0.05];
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
				cutText ["","PLAIN"];
				waitUntil {!isNil "BRPVP_rulesOk" || BRPVP_rulesPage isNotEqualTo _rulesPageNow || isNull _display};
				if (isNil "BRPVP_rulesOk") then {
					if (isNull _display) then {endMission "END1";} else {for "_i" from 79866 to _id5 do {ctrlDelete (_display displayCtrl _i);};};
				} else {
					if (BRPVP_rulesOk) then {_display closeDisplay 1;} else {endMission "END1";};
				};
			};
		};
		["",0,0,0,0,0,1173] spawn BIS_fnc_dynamicText;
		true call BRPVP_seeRules;
	};

	//ADMIN OR MODERATOR OR PLAYER MODE
	BRPVP_moderators = BRPVP_moderators-BRPVP_admins;
	BRPVP_trataseDeAdmin = (player getVariable "id") in BRPVP_admins;
	BRPVP_isModerator = (player getVariable "id") in BRPVP_moderators;
	BRPVP_isAdminOrModerator = BRPVP_trataseDeAdmin || BRPVP_isModerator;
	if (BRPVP_isAdminOrModerator) then {
		["",0,0,0,0,0,1173] spawn BIS_fnc_dynamicText;
		disableSerialization;
		BRPVP_playerModeOk = nil;
		private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
		playSound "admin_msg";
		["<img shadow='0' align='center' size='5' image='"+BRPVP_imagePrefix+"BRP_imagens\robo.paa'/><br/><t shadow='0' align='center'>"+localize "str_mode_select"+"</t>",0,0,36000,0,0,6237] spawn BIS_fnc_dynamicText;
		_id1 = 79866;
		_id2 = _id1+1;
		_display ctrlCreate ["RscButton",_id1];
		(_display displayCtrl _id1) ctrlSetPosition [0,0.5,0.3,0.05];
		(_display displayCtrl _id1) ctrlSetText localize "str_mode_player";
		(_display displayCtrl _id1) ctrlCommit 0;
		(_display displayCtrl _id1) ctrlAddEventHandler ["ButtonClick",{BRPVP_playerModeOk = true;}];
		_display ctrlCreate ["RscButton",_id2];
		(_display displayCtrl _id2) ctrlSetPosition [0.7,0.5,0.3,0.05];
		if (BRPVP_trataseDeAdmin) then {(_display displayCtrl _id2) ctrlSetText localize "str_mode_admin";} else {(_display displayCtrl _id2) ctrlSetText localize "str_mode_moderator";};
		(_display displayCtrl _id2) ctrlCommit 0;
		(_display displayCtrl _id2) ctrlAddEventHandler ["ButtonClick",{BRPVP_playerModeOk = false;}];
		cutText ["","PLAIN"];
		waitUntil {!isNil "BRPVP_playerModeOk" || isNull _display};
		if (isNull _display) then {
			BRPVP_playerModeOk = false;
		} else {
			for "_i" from 79866 to _id2 do {ctrlDelete (_display displayCtrl _i);};
			_display closeDisplay 1;
		};
		if (BRPVP_playerModeOk) then {
			BRPVP_trataseDeAdmin = false;
			BRPVP_isModerator = false;
			BRPVP_isAdminOrModerator = false;
			player setVariable ["brpvp_player_mode","player",true];
		} else {
			if (BRPVP_trataseDeAdmin) then {
				if (BRPVP_showAdminInfo) then {[format [localize "str_admin_is_online",player getVariable "nm"],5] remoteExec ["BRPVP_specialMessageShow",BRPVP_allNoServer];};
				player setVariable ["brpvp_player_mode","admin",true];
			} else {
				[format [localize "str_moderator_is_online",player getVariable "nm"],5] remoteExec ["BRPVP_specialMessageShow",BRPVP_allNoServer];
				player setVariable ["brpvp_player_mode","moderator",true];
			};
			player setVariable ["id",(player getVariable "id")+"_ADM",true];
			1 enableChannel [true,true];
			BRPVP_terrainGridConfig = [["Lowest",[50,50,50]]]+BRPVP_terrainGridConfig;
		};
		["",0,0,0,0,0,6237] spawn BIS_fnc_dynamicText;
	} else {
		player setVariable ["brpvp_player_mode","player",true];
	};

	//GET CUSTOM MARKS
	BRPVP_myCustomMarks = nil;
	[player getVariable ["id","0"],player] remoteExecCall ["BRPVP_getCustomMarksSv",2];
	waitUntil {!isNil "BRPVP_myCustomMarks"};
	BRPVP_myCustomMarks = BRPVP_myCustomMarks apply {[_x select 0,_x select 1,[_x select 2,"@#$2_points$#@",":"] call BRPVP_stringReplace]};

	//GET PLAYED DAYS
	BRPVP_statsDaysPlayed = nil;
	[player getVariable ["id","0"],player] remoteExecCall ["BRPVP_getDaysPlayedSV",2];
	waitUntil {!isNil "BRPVP_statsDaysPlayed"};
	//systemChat format [localize "str_you_played_x_days",BRPVP_statsDaysPlayed];
	player setVariable ["brpvp_days_played",BRPVP_statsDaysPlayed,true];

	//GET PAST FRIENDS
	BRPVP_myPastFriendsAnswer = nil;
	[player getVariable ["id","0"],player] remoteExecCall ["BRPVP_getPastFriendsSV",2];
	waitUntil {!isNil "BRPVP_myPastFriendsAnswer"};
	private _myPastFriends = [];
	{_myPastFriends append (_x select 0);} forEach BRPVP_myPastFriendsAnswer;
	player setVariable ["brpvp_past_friends",_myPastFriends arrayIntersect _myPastFriends];

	//GET INITIAL SERVER VARS
	"BRPVP_syncedTime" addPublicVariableEventHandler {BRPVP_syncedTimeMark = diag_tickTime;};
	player remoteExecCall ["BRPVP_iAskForInitialVars",2];
	waitUntil {!isNil "BRPVP_walkersObj" && !isNil "BRPVP_allFlags" && !isNil "BRPVP_syncedTimeMark" && !isNil "BRPVP_zombieBloodBagActive" && !isNil "BRPVP_climbActivePlayers" && !isNil "BRPVP_carrierObjsList" && !isNil "BRPVP_systemExtra" && !isNil "BRPVP_artySpotInfo" && !isNil "BRPVP_habilitiesState" && !isNil "BRPVP_extraPosCheckSv" && !isNil "BRPVP_radioAreasExtra" && !isNil "BRPVP_allTurretsInfo" && !isNil "BRPVP_bigFloorsAll" && !isNil "BRPVP_atmOldActivated" && !isNil "BRPVP_frantaAllObjs" && !isNil "BRPVP_secCamAll" && !isNil "BRPVP_terrainVertexChanges" && !isNil "BRPVP_godModeHouseObjects" && !isNil "BRPVP_safezoneProtectionOnExitObjs" && !isNil "BRPVP_atomicBombHiddenBigFloors"};

	//CREATE BIG FLOORS
	{_x call BRPVP_creatBigFloor200;} forEach BRPVP_bigFloorsAll;

	//HIDE BIG FLOOR PIECES (DESTROYED BY ATOMIC BOMB)
	{
		_x params ["_bfid","_pos"];
		private _obj = nearestObject _pos;
		if (_obj getVariable ["brpvp_bf_bfid",-1] isEqualTo _bfid) then {_obj hideObject true;};
	} forEach BRPVP_atomicBombHiddenBigFloors;

	//ENABLE CARRIERS CATAPULT
	(BRPVP_carrierObjsList+BRPVP_carrierMissActive) spawn {
		sleep 5;
		{_x call BRPVP_aircraftFixPositions;} forEach _this;
		sleep 2;
		{[_x] call BIS_fnc_Carrier01Init;} forEach _this;
	};

	//DEFINE VARIAVEIS
	BRPVP_variavies = compileFinal preprocessFileLineNumbers "client_code\perSpawnVariables.sqf";
	call BRPVP_variavies;

	//VARIAVEIS ONE TIME SET
	BRPVP_superRunCollisionDestroyHouse = false;
	BRPVP_extraSecJumpForceOnSuperRun = 1;
	BRPVP_personalShieldNeutrine = false;
	BRPVP_autoOpenDoorSpeed = 1;
	BRPVP_voodooHandle = -1;
	BRPVP_autoOpenDoorPerk = false;
	BRPVP_srunBeachDamage = true;
	BRPVP_minervaBotAllUnitsObjsNearSee = [];
	BRPVP_minervaBotAllUnitsObjsNear = [];
	BRPVP_allTurretsOnMeRedSpec = [];
	BRPVP_allTurretsOnMeRedSeeSpec = [];
	BRPVP_skyDiveInitTime = 0;
	BRPVP_represedHungryCycles = 0;
	BRPVP_ligaModoCombateLastEnd = -10000;
	BRPVP_flyOnOffAdmin = false;
	BRPVP_lastScriptedQuakeTime = -10;
	BRPVP_magnetBetterAttraction = false;
	BRPVP_radioAreasInsideSpec = [];
	BRPVP_weatherPredict = false;
	BRPVP_itemsHotkeys = ["BRPVP_playerLaunch","BRPVP_uberPack","BRPVP_itemMagnet","BRPVP_minervaShot"];
	BRPVP_superJumpBoostCfg = 1;
	BRPVP_superJumpBoost = 0;
	ZBL_hasAntiZombie = 0;
	BRPVP_godModeLifeState = [];
	BRPVP_ultimoCombateTempo = 0;
	BRPVP_fradeBigOn = false;
	BRPVP_ABombLightObjs = [];
	BRPVP_blindHandle = -1;
	BRPVP_crosshairOn = false;
	BRPVP_doubleSmokeSpeed = 0.25;
	BRPVP_doubleSmokeOn = false;
	BRPVP_spotServiceLocalFoundMessage = 0;
	BRPVP_spotServiceBackInformationList = [];
	BRPVP_sBotAllUnitsObjsNearSee = [];
	BRPVP_sBotAllUnitsObjsNear = [];
	BRPVP_maxHeightSinceNoGround = 0;
	BRPVP_radioAreasTotalIntensity = 0;
	BRPVP_playerDamageForCalc = 0;
	BRPVP_tireCursorObject = objNull;
	BRPVP_spectUseMyViewDistance = true;
	BRPVP_tastingAbilitiesDenied = [];
	BRPVP_tastingAbilitiesOn = [];
	BRPVP_myAllFlagInsideWithAccessObjs = [];
	BRPVP_myAllFlagInsideWithAccessRaidOn = false;
	BRPVP_specialClimbOn = false;
	BRPVP_carryBoxSetScaleOnMe = [];
	BRPVP_vePlayersSixthSense = false;
	BRPVP_perkPageSet = 1;
	BRPVP_nitroFlyFeatureOn = false;
	BRPVP_nitroFlyCruiseTime = 2;
	BRPVP_nitroFlyCoolDown = 10;
	BRPVP_nitroFlyCoolDownLastEnd = -BRPVP_nitroFlyCoolDown;
	BRPVP_sixthSenseRangeSpec = 200;
	BRPVP_sixthSenseSeePlayerSpec = false;
	BRPVP_sixthSensePowerPlayerSpec = 0.025;
	BRPVP_sixthSensePowerSpec = 0.04;
	BRPVP_sixthSenseOnSpec = false;
	BRPVP_sixthSenseRange = 200;
	BRPVP_sixthSenseSeePlayer = false;
	BRPVP_sixthSensePowerPlayer = 0.025;
	BRPVP_sixthSensePower = 0.04;
	BRPVP_sixthSenseOn = false;
	BRPVP_sixthSenseObjectsFoundPlayer = [];
	BRPVP_sixthSenseObjectsFound = [];
	BRPVP_lastVehicleInTi = false;
	BRPVP_lastVehicleInObj = objNull;
	BRPVP_lastVehicleInPos = [];
	BRPVP_allowSecondJump = true;
	BRPVP_pathClimbAction = -1;
	BRPVP_pathClimbTrying = false;
	BRPVP_pathClimbOn = false;
	BRPVP_pathClimbBigJump = false;
	BRPVP_pathClimbBigJumpLast = 0;
	BRPVP_usingElevator = false;
	BRPVP_nitroFlyOn = false;
	BRPVP_meuAllDeadSpec = [];
	BRPVP_mapMousePosBinocle = [0,0,0];
	BRPVP_mapVisibleRadius = 1000;
	BRPVP_mapVisibleRadiusBorder = 100;
	BRPVP_mapVisibleRadiusHalfBorder = 50;
	BRPVP_mapVisibleRadiusCompare = 1050;
	BRPVP_mapVisibleRadiusMinLimit = 950;
	BRPVP_mapVisibleRadiusBorderPercentage = 0.25;
	BRPVP_mapVisibleRadiusPercAlpha = 0.9;
	BRPVP_secCamCurrentCamKey = "";
	BRPVP_secCamBbsMyPlayerSave = [];
	BRPVP_secCamBbsMyPlayerSaveLast = [];
	BRPVP_secCamBbsMySpec = [];
	BRPVP_secCamBbsMy = [];
	BRPVP_hauntDeath = false;
	BRPVP_playerIsHealing = false;
	BRPVP_uberBadEnd = false;
	BRPVP_uberAttackPlayerSelectPosition = false;
	BRPVP_jetBombDoPlayer = [];
	BRPVP_meusAmigosObj = [];
	BRPVP_spectedPlayer = objNull;
	BRPVP_construindoItem = "";
	BRPVP_possBadAction = -1;
	BRPVP_possItemUsed = "";
	BRPVP_possCaptive = false;
	BRPVP_possOtherPlayer = false;
	BRPVP_possActionId = -1;
	BRPVP_possControled = objNull;
	BRPVP_specAddBuilding = [];
	BRPVP_specAddArtyMap = [];
	BRPVP_artyTargetPos = [];
	BRPVP_specArtyTargetPos = [];
	BRPVP_mapShowFrantaMines = true;
	BRPVP_frantaAllObjsMyFriends = [];
	BRPVP_frantaAllObjsMy = [];
	BRPVP_specXrayOn = false;
	BRPVP_specNascendoParaQuedas = false;
	BRPVP_auraLightObjSpec = objNull;
	BRPVP_specXpLastTotal = 0;
	BRPVP_personalBushFakeOn = false;
	BRPVP_personalBush = objNull;
	BRPVP_personalBushFired = false;
	BRPVP_realPingInit = -1;
	BRPVP_specMeusAmigosObj = [];
	BRPVP_specPveFriends = [];
	BRPVP_constantRunOn = false;
	BRPVP_superRunSpeed = BRPVP_superRunSpeedsArray select 1;
	BRPVP_superRunSpeedSelected = BRPVP_superRunSpeed;
	BRPVP_bodyChangeInvited = false;
	BRPVP_bodyChangeAsker = objNull;
	BRPVP_bodyChangeAskerMid = -1;
	BRPVP_bodyChangeTrying = false;
	BRPVP_specMapScaleAny = 1;
	BRPVP_specMapPosAny = [0.5,0.5];
	BRPVP_mapMouseMovementAny = [worldSize/2,worldSize/2];
	BRPVP_specMapMouseMovement = [worldSize/2,worldSize/2];
	BRPVP_specMapMouseLast = [worldSize/2,worldSize/2];
	BRPVP_setSpectedDinaMsgsIds = [];
	BRPVP_specCamOn = false;
	BRPVP_specMenuShowTxt = "";
	BRPVP_specMenuShowLast = -100;
	BRPVP_autoReviveUsing = false;
	BRPVP_unconsciousCaptive = false;
	BRPVP_mapIconsPerc = 1;
	BRPVP_droneMapOn = false;
	BRPVP_artyMapOn = false;
	BRPVP_playerBuilding = objNull;
	BRPVP_ppathBoo = true;
	BRPVP_ppathLastHouse = "<NULL-object>";
	BRPVP_ppathRedundantCount = 0;
	BRPVP_ppathRedundantLimit = 5;
	BRPVP_ppathMaxHigh = 1250;
	BRPVP_ppathIgAngle = 15;
	BRPVP_ppathDeltaPos = 10;
	BRPVP_ppathIsOn = false;
	BRPVP_ppathShowMap = true;
	BRPVP_ppathShow3D = false;
	BRPVP_ppathPath = [];
	BRPVP_ppathSize = 500;
	BRPVP_ppathLastCountMsg = 0;
	BRPVP_fradeOn = false;
	BRPVP_fradeDistance = 4;
	BRPVP_ubberFastDescent = false;
	BRPVP_bFlyFixTime = 0;
	BRPVP_bFlyFixLastAni = "";
	BRPVP_bFlyFixOn = -1;
	BRPVP_bFlyFixV = 0;
	BRPVP_busCanPressStop = false;
	BRPVP_tBot = objNull;
	BRPVP_boxeItemOn = false;
	BRPVP_mapShowMagus = true;
	BRPVP_mapShowTraders = true;
	BRPVP_mapShowVehicles = true;
	BRPVP_mapShowUnits = true;
	BRPVP_mapShowMissions = true;
	BRPVP_mapShowPlayerStuff = true;
	BRPVP_mapShowCtrl4Marks = true;
	BRPVP_mapShowOtherStuff = true;
	BRPVP_myUAVNow = objNull;
	BRPVP_mySpecUAVNow = objNull;
	BRPVP_myPlayerOrUAV = player;
	BRPVP_myPlayerOrUAVOrVehicle = vehicle player;
	BRPVP_myPlayerOrSpec = player;
	BRPVP_myPlayerOrSpecOrDrone = player;
	BRPVP_ctrl4On3dDistance = 0;
	BRPVP_c4Monitore = [];
	BRPVP_nearBigShips = false;
	BRPVP_itemMagnetAllMass = 0;
	BRPVP_itemMagnetOnAction1 = -1;
	BRPVP_itemMagnetOnAction2 = -1;
	BRPVP_itemMagnetOn = false;
	BRPVP_classAdInside = false;
	BRPVP_aTurretHelpSpecialCycle = 0;
	BRPVP_xrayObj = objNull;
	BRPVP_xrayOn = false;
	BRPVP_wasBotKill = false;
	BRPVP_auraConfig = [0,0];
	BRPVP_auraLight = objNull;
	BRPVP_auraFlare = objNull;
	BRPVP_allXpOn = false;
	BRPVP_vehRearmAction = -1;
	BRPVP_vehRearmNear = objNull;
	BRPVP_vehRefuelAction = -1;
	BRPVP_vehRefuelNear = objNull;
	BRPVP_vehRepairAction = -1;
	BRPVP_vehRepairNear = objNull;
	BRPVP_vgCheckVehicle = objNull;
	BRPVP_craftLastCraftName = "";
	BRPVP_autoTurretExtraCode = {["man",_this] call BRPVP_checkTurretType};
	BRPVP_flyA1 = false;
	BRPVP_flyA2 = false;
	BRPVP_flyB1 = false;
	BRPVP_flyB2 = false;
	BRPVP_flyC1 = false;
	BRPVP_flyC2 = false;
	BRPVP_flyOnOff = false;
	BRPVP_flyAcell = false;
	BRPVP_newersDiscovered = [];
	BRPVP_newerPlayers = [];
	BRPVP_bornWithDeadItemsThisRound = false;
	BRPVP_myBodyDeadItems = [];
	BRPVP_myBaseState = 0;
	BRPVP_teleCancelTravel = [objNull,objNull];
	BRPVP_bobToSetDestine = objNull;
	BRPVP_towLandNumber = 1;
	BRPVP_baseMineDefuse = objNull;
	BRPVP_inPIconsArea = false;
	BRPVP_lastTimeEat = time;
	BRPVP_xpBusPriceMult = 1;
	BRPVP_radioEnterTime = -1;
	BRPVP_xpConsumed = 0;
	BRPVP_xpLastTotal = 0;
	BRPVP_xpAllowObscureITems = false;
	BRPVP_xpAllowCarrier = false;
	BRPVP_xpRepackAmmoOk = false;
	BRPVP_foodEatLightEater = false;
	BRPVP_xpRadioProtection = 1;
	BRPVP_killContractsShowAction = false;
	BRPVP_perkSeeAllAI = false;
	BRPVP_perkJump = 1;
	BRPVP_carrierUseStatus = 0;
	BRPVP_missionNearDist = -1;
	BRPVP_missionsPos = [];
	BRPVP_accessAllNear = -10;
	BRPVP_myTires = [];
	BRPVP_tiresNearTires = [];
	BRPVP_superJumpRunning = false;
	BRPVP_carryingBox = false;
	BRPVP_deathInVehTime = -1;
	BRPVP_starvedToDeath = false;
	BRPVP_heliEventCenter = [];
	BRPVP_climbOn = false;
	BRPVP_weaponPrivateSlotTime = 0;
	BRPVP_baseTestAction = -1;
	BRPVP_playersMarksEnabled = [];
	BRPVP_usePlayerIconBandit = true;
	BRPVP_usePlayerIconPve = true;
	BRPVP_usePlayerIconSquad = true;
	BRPVP_usePlayerIconFriends = true;
	BRPVP_lastBaseBox = objNull;
	BRPVP_myDLCList = getDLCs 1;
	BRPVP_viewDistState = 0;
	BRPVP_killMapOn = false;
	BRPVP_tracerUse = false;
	BRPVP_baseBombDrawLinesGreen = [];
	BRPVP_baseBombDrawLines = [];
	BRPVP_baseBombStage = 0;
	BRPVP_showGoodLootOnMap = false;	
	BRPVP_personalShieldTime = 0;
	BRPVP_spotedDroneOperators = [];
	BRPVP_spotedDroneOperatorsTime = 120;
	BRPVP_spotedDroneOperatorsIdx = 1;
	BRPVP_pveFriends = [];
	BRPVP_superJumpCount = 0;
	BRPVP_mineDetectorOn = false;
	BRPVP_mineDetectorObj = objNull;
	BRPVP_boxCarryAction = false;
	BRPVP_busDestine = [];
	BRPVP_nearFreezeFloor = 0;
	BRPVP_hydraulicJackDoing = false;
	BRPVP_hydraulicJackUseTime = 0;
	BRPVP_hydraulicJackTime = 0;
	BRPVP_pilotCopilotEjectAction = -1;
	BRPVP_randomRespawnPlaces = [];
	BRPVP_randomRespawnPlacesShow = false;
	BRPVP_lastSuicideTime = -300;
	BRPVP_diedGun = ["",["","","",""],[]];
	BRPVP_flyA = false;
	BRPVP_flyB = false;
	BRPVP_flyC = false;
	BRPVP_flyD = false;
	BRPVP_lastKillIsPlayer = false;
	BRPVP_paraParamH = 1500;
	BRPVP_nascendoParaQuedas = false;
	BRPVP_deadWWHS = [];
	BRPVP_hackLines = [];
	BRPVP_holderVault = objNull;
	BRPVP_vaultLigada = false;
	BRPVP_vaultAcaoTempo = 0;
	BRPVP_canBuildPointsOn = false;
	BRPVP_radioAreasInside = [];
	BRPVP_myFlagsSeeBuildingsOnMap = [];
	BRPVP_vePlayers = false;
	BRPVP_playerDisabled = false;
	BRPVP_nearIdentifiedPlayers = [];
	BRPVP_headGearNoIdentify = ["H_Shemag_khk","H_Shemag_tan","H_Shemag_olive","H_Shemag_olive_hs","H_ShemagOpen_khk","H_ShemagOpen_tan"];
	BRPVP_gogglesNoIdentifyStrings = ["Balaclava","Bandanna"];
	BRPVP_equipedIllegalItem = "";
	BRPVP_construindoIsMapObject = false;
	BRPVP_rapidFire = false;
	BRPVP_averageDamage = getAllHitPointsDamage player;
	BRPVP_averageDamageGeneral = 0;
	BRPVP_playerIsRemovingObject = false;
	BRPVP_barControlId = 552793;
	BRPVP_motorizedToLockUnlock = objNull;
	BRPVP_myStuffOthers = [];
	BRPVP_antiWeaponDupeBoolean = false;
	BRPVP_monitoreGroups = false;
	BRPVP_spectateHeadOffset = [0,0.1,0.1];
	BRPVP_actualAutoTurrets = BRPVP_autoTurretOnMan;
	BRPVP_actualAutoTurretsDist = BRPVP_autoTurretFireRange select 0;
	BRPVP_actualAutoTurretsForgiveDist = BRPVP_autoTurretFireRangeForgive select 0;
	BRPVP_autoTurretDangerLevel = 0;
	BRPVP_landVehicleOnTow = [];
	BRPVP_achaMeuStuffRodou = false;
	BRPVP_spectateOn = false;
	BRPVP_connectionOn = false;
	BRPVP_radarDist = 0;
	BRPVP_radarDistErr = 0;
	BRPVP_radarBeepInterval = 5;
	BRPVP_radarCenter = [0,0,0];
	BRPVP_notBlockedKeys = (actionKeys "Chat")+(actionKeys "ShowMap")+(actionKeys "HideMap")+(actionKeys "NextChannel")+(actionKeys "PrevChannel")+(actionKeys "PushToTalk")+(actionKeys "PushToTalkAll")+(actionKeys "PushToTalkCommand")+(actionKeys "PushToTalkDirect")+(actionKeys "PushToTalkGroup")+(actionKeys "PushToTalkSide")+(actionKeys "PushToTalkVehicle")+[0x32,0x01,0xD2];
	BRPVP_assignedVehicle = objNull;
	BRPVP_sellReceptacle = objNull;
	BRPVP_disabledDamage = 0;
	BRPVP_playerLastCorpse = objNull;
	BRPVP_playerIsCaptive = false;
	BRPVP_playerDamaged = false;
	BRPVP_ganchoDesvira = [];
	BRPVP_tempoUltimaAtuAmigos = 0;
	BRPVP_objetoMarcado = objNull;
	BRPVP_idcIconesAntes = -1;
	BRPVP_idcIcones = 0;
	BRPVP_extraIcons = [];
	BRPVP_iconesLocaisTrader = [];
	BRPVP_iconesLocaisInOut = [];
	BRPVP_iconesLocais = [];
	BRPVP_iconesLocaisShow = [];
	BRPVP_iconesLocaisAmigos = [];
	BRPVP_iconesLocaisBots = [];
	BRPVP_iconesLocaisVeiculi = [];
	BRPVP_iconesLocaisStuff = [];
	BRPVP_iconesLocaisSempre = [];
	BRPVP_expLegenda = [localize "str_explist_0",localize "str_explist_1",localize "str_explist_2",localize "str_explist_3",localize "str_explist_4",localize "str_explist_5",localize "str_explist_6",localize "str_explist_7",localize "str_explist_8",localize "str_explist_9",localize "str_explist_10",localize "str_explist_11",localize "str_explist_12",localize "str_explist_13",localize "str_exp_zumbi",localize "str_exp_comprou",localize "str_exp_vendeu",localize "str_farm_craft",localize "str_mounted_kills",localize "str_radio_man",localize "str_suitcase",localize "str_xp_veh_landvehicle",localize "str_xp_veh_helicopter",localize "str_xp_veh_plane",localize "str_xp_veh_ship",localize "str_explist_double_xp",localize "str_xp_hours_played",localize "str_explist_admin_xp",localize "str_explist_turrets",localize "str_perk_cure_and_repair",localize "str_world_destroyer"];
	BRPVP_expLegendaSimples = ["matou_player","player_matou","matou_bot","bot_matou","andou","comeu","levou_tiro_cabeca_player","deu_tiro_cabeca_player","levou_tiro_cabeca_bot","deu_tiro_cabeca_bot","itens_construidos","queda","suicidou","matou_veiculo","zumbi","comprou","vendeu","farm_craft","mounted_kills","radio","maleta","landvehicle","helicopter","plane","ship","double","hours_played","admin","turret","cure_repair","world_destroyer"];
	BRPVP_acoesClick = [];
	_sep = "<t> <img size='0.8' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\separator.paa'/> </t>";
	_lineOne = if (BRPVP_usePaydAccess) then {"<t align='center'>%23</t><br/><t align='center'>%25"+_sep+"%26"+_sep+"%22"+_sep+BRPVP_buildVersion+_sep+"%21"+_sep+"%20"+_sep+"%19"+_sep+"%18"+_sep+"%17"+_sep+"%6"+_sep+"%11"+_sep+"%12"+_sep+"%16"+_sep+"%24</t><br/>"} else {"<t align='center'>%23</t><br/><t align='center'>%25"+_sep+"%26"+_sep+"%22"+_sep+BRPVP_buildVersion+_sep+"%21"+_sep+"%20"+_sep+"%19"+_sep+"%18"+_sep+"%17"+_sep+"%6"+_sep+"%16"+_sep+"%24</t><br/>"};
	BRPVP_indiceDebugItens = [
		_lineOne+"<t align='center'>%2"+_sep+"%7"+_sep+"%1"+_sep+"%15"+_sep+"%10"+_sep+"%14"+_sep+"%4"+_sep+"%5"+_sep+"<img size='0.95' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\F2.paa'/><t> "+localize "str_sbar_f2"+"</t>"+(if (BRPVP_isAdminOrModerator) then {_sep+"<img size='0.95' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\F3.paa'/><t> "+localize "str_sbar_f3"+"</t>"+_sep+"<img size='0.95' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\sfps.paa'/><t> %8</t>"+(if (BRPVP_useHC) then {_sep+"<img size='0.95' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\hcfps.paa'/><t> %9</t>"} else {""})} else {""})+"</t>",
		"<br/><br/><br/><t align='center'>%2"+_sep+"%7"+_sep+"%1"+_sep+"%15"+_sep+"%10"+_sep+"%14"+_sep+"%5"+_sep+"%19</t>",
		"<br/><br/><br/><t align='center'>%2"+_sep+"%7"+_sep+"%1"+_sep+"%15"+_sep+"%10"+_sep+"%14</t>",
		"<br/><br/><br/><t align='center'>%2"+_sep+"%7"+_sep+"%1"+_sep+"%15</t>",
		"<br/><br/><br/><t align='center'>%1"+_sep+"%15</t>",
		"<br/><br/><br/><t align='center'>%1</t>",
		"<br/><br/><br/><t align='center'><img align='center' size='1.25' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' /> BRPVP</t>",
		""
	];
	player setVariable ["dd",-1,true];
	player setVariable ["fov",0.75/(getObjectFov player),true];
	player setVariable ["cmv",if (cameraView isEqualTo "EXTERNAL") then {"EXTERNAL"} else {"INTERNAL"},true];
	setPlayerRespawnTime 1000;
	BRPVP_stuff = objNull;

	//DISABLED SOUNDS
	BRPVP_disabledSoundsIdc = 0;
	BRPVP_disabledSounds = ["disabled1.ogg","disabled12.ogg","disabled13.ogg","disabled2.ogg","disabled3.ogg","disabled4.ogg","disabled5.ogg","disabled6.ogg","disabled7.ogg","disabled8.ogg","disabled9.ogg","disabled10.ogg","disabled11.ogg","disabled14.ogg"];
	BRPVP_disabledSounds = BRPVP_disabledSounds apply {[random 1000,_x]};
	BRPVP_disabledSounds sort true;
	BRPVP_disabledSounds = BRPVP_disabledSounds apply {_x select 1};

	//GET LAST BRPVP_ownedHouses AND BRPVP SIMPLE OBJECTS VARIABLES
	if (!isServer) then {
		BRPVP_ownedHouses = nil;
		player remoteExecCall ["BRPVP_ownedHousesSolicita",2];
		waitUntil {!isNil "BRPVP_ownedHouses"};
	};
	diag_log ("[BRPVP] count BRPVP_ownedHouses = "+str count BRPVP_ownedHouses+".");

	//SCRIPTS
	call compile preprocessFileLineNumbers "client_code\farmAndCraft.sqf";
	call compile preprocessFileLineNumbers "client_code\itemMarketVariables.sqf";
	call compile preprocessFileLineNumbers "client_code\constructionFunctionsAndVars.sqf";
	call compile preprocessFileLineNumbers "client_code\clientOnlyFunctions.sqf";
	call compile preprocessFileLineNumbers "client_code\clientPublicVariableEventHandler.sqf";
	call compile preprocessFileLineNumbers "client_code\playerCustomKeys.sqf";
	call compile preprocessFileLineNumbers "client_code\playerMenuSystem.sqf";
	call compile preprocessFileLineNumbers "client_code\clientLoop.sqf";
	call compile preprocessFileLineNumbers "client_code\playerEventHandlers.sqf";
	call compile preprocessFileLineNumbers "client_code\xpCode.sqf";
	call compile preprocessFileLineNumbers "zombieMotherBrain.sqf";
	call compile preprocessFileLineNumbers "client_code\wakeUpBaseDefenses.sqf";
	execVM "client_code\client_loot.sqf";
	execVM "client_code\A3ZombiesLoop.sqf";
	execVM "client_code\autoTurretHelp.sqf";
	execVM "client_code\limitArtillery.sqf";
	execVM "client_code\inventoryItemUses.sqf";

	//SET WATER WALK SPLASH ON WATER WALKING PLAYERS
	{_x call BRPVP_waterWalkRemote} forEach (call BRPVP_playersList-[player]);

	//MAP LEGEND
	//execVM "client_code\mapLegend.sqf";

	//NASCIMENTO
	BRPVP_nascimento_player = compileFinal preprocessFileLineNumbers "client_code\playerFillAndSpawnInit.sqf";

	//SIEGE ICONS
	BRPVP_closedCityRunning call BRPVP_processSiegeIcons;

	//MapSingleClick MISSION EH
	BRPVP_onMapSingleClick = BRPVP_padMapaClique;
	onMapSingleClick {[_pos,_alt,_shift] call BRPVP_onMapSingleClick};
	
	BRPVP_fixVehicleFull = {
		if ("ToolKit" in items player) then {
			private _init = diag_tickTime;
			private _sInit = diag_tickTime;
			private _sDelay = 0;
			private _oPos = ASLToAGL getPosASL player;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\toolkit_full_fix.paa'/><br/><t>"+localize "str_dont_move"+"</t>",0,0,15,0,0,3425] call BRPVP_fnc_dynamicText;
			waitUntil {
				if (diag_tickTime-_sInit > _sDelay) then {
					_sInit = diag_tickTime;
					_sDelay = 0.25+random 0.5;
					[_this,[selectRandom ["drill_small","drill_small_b"],200]] remoteExecCall ["say3D",BRPVP_allNoServer];
				};
				diag_tickTime-_init > 12 || !(player call BRPVP_pAlive) || player distance _oPos > 2 || !("ToolKit" in items player) || !alive _this
			};
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\toolkit_full_fix.paa'/><br/><t>"+localize "str_dont_move"+"</t>",0,0,0,0,0,3425] call BRPVP_fnc_dynamicText;
			if (player call BRPVP_pAlive && player distance _oPos < 2 && "ToolKit" in items player && alive _this) then {
				[_this,5] call BRPVP_enableVehOnInteraction;
				player removeItem "ToolKit";
				private _damBefore = getAllHitPointsDamage _this select 2;
				_this setDamage 0;
				[_this,0] remoteExecCall ["setDamage",-clientOwner];
				private _damAfter = getAllHitPointsDamage _this select 2;
				_this setVariable ["brpvp_lifesfix",0,true];
				private _idBd = _this getVariable ["id_bd",-1];
				if (_idBd > -1) then {[_idBd,0] remoteExecCall ["BRPVP_vehConsumeLifesFixDb",2];};
				if (_damAfter isNotEqualTo _damBefore) then {[["cure_repair",1]] call BRPVP_mudaExp;};
				[player,["woohoo",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
			} else {
				"erro" call BRPVP_playSound;
			};
			BRPVP_reparingVehicle = false;
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_need_toolkit",-4] call BRPVP_hint;
		};
	};
	BRPVP_fixVehicle = {
		if ("ToolKit" in items player) then {
			private _init = diag_tickTime;
			private _sInit = diag_tickTime;
			private _sDelay = 0;
			private _oPos = ASLToAGL getPosASL player;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\toolkit_fix.paa'/><br/><t>"+localize "str_dont_move"+"</t>",0,0,7.5,0,0,3425] call BRPVP_fnc_dynamicText;
			waitUntil {
				if (diag_tickTime-_sInit > _sDelay) then {
					_sInit = diag_tickTime;
					_sDelay = 0.75+random 0.25;
					[_this,[selectRandom ["drill_small","drill_small_b"],200]] remoteExecCall ["say3D",BRPVP_allNoServer];
				};
				diag_tickTime-_init > 6 || !(player call BRPVP_pAlive) || player distance _oPos > 2 || !("ToolKit" in items player)
			};
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\toolkit_fix.paa'/><br/><t>"+localize "str_dont_move"+"</t>",0,0,0,0,0,3425] call BRPVP_fnc_dynamicText;
			if (player call BRPVP_pAlive && player distance _oPos < 2 && "ToolKit" in items player) then {
				[_this,5] call BRPVP_enableVehOnInteraction;
				private _AHD = getAllHitPointsDamage _this;
				private _xLifeConAll = [];
				private _permDam = _this call BRPVP_getLifesFixPermanentDamage;
				private _gDamNow = damage _this;
				private _fixed = false;
				if (_gDamNow > _permDam) then {
					_this setDamage _permDam;
					_fixed = true;
					_xLifeConAll pushBack (_gDamNow-_permDam);
				};
				{
					private _dam = if (_x > _permDam) then {_fixed = true;_xLifeConAll pushBack (_x-_permDam);_permDam} else {_xLifeConAll pushBack 0;_x};
					//[_this,[_forEachIndex,_dam]] remoteExecCall ["setHitIndex",_this];
					[_this,[_forEachIndex,_dam]] remoteExecCall ["setHitIndex",0];
				} forEach (_AHD select 2);
				private _sum = 0;
				{_sum = _sum+_x;} forEach _xLifeConAll;
				if (_sum isNotEqualTo 0) then {
					private _idBd = _this getVariable ["id_bd",-1];
					_xLifeToDb = (_this getVariable ["brpvp_lifesfix",0])+_sum/count _xLifeConAll;
					_this setVariable ["brpvp_lifesfix",_xLifeToDb,true];
					if (_idBd > -1) then {[_idBd,_xLifeToDb] remoteExecCall ["BRPVP_vehConsumeLifesFixDb",2];};
				};
				if (_fixed) then {[["cure_repair",1]] call BRPVP_mudaExp;};
			} else {
				"erro" call BRPVP_playSound;
			};
			BRPVP_reparingVehicle = false;
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_need_toolkit",-4] call BRPVP_hint;
		};
	};
	BRPVP_fixVehicleDuke = {
		if (player call BRPVP_pAlive) then {
			[_this,5] call BRPVP_enableVehOnInteraction;
			private _AHD = getAllHitPointsDamage _this;
			private _xLifeConAll = [];
			private _permDam = _this call BRPVP_getLifesFixPermanentDamage;
			private _gDamNow = damage _this;
			private _fixed = false;
			if (_gDamNow > _permDam) then {
				_this setDamage _permDam;
				_fixed = true;
				_xLifeConAll pushBack (_gDamNow-_permDam);
			};
			{
				private _dam = if (_x > _permDam) then {_fixed = true;_xLifeConAll pushBack (_x-_permDam);_permDam} else {_xLifeConAll pushBack 0;_x};
				//[_this,[_forEachIndex,_dam]] remoteExecCall ["setHitIndex",_this];
				[_this,[_forEachIndex,_dam]] remoteExecCall ["setHitIndex",0];
			} forEach (_AHD select 2);
			private _sum = 0;
			{_sum = _sum+_x;} forEach _xLifeConAll;
			if (_sum isNotEqualTo 0) then {
				private _idBd = _this getVariable ["id_bd",-1];
				_xLifeToDb = (_this getVariable ["brpvp_lifesfix",0])+_sum/count _xLifeConAll;
				_this setVariable ["brpvp_lifesfix",_xLifeToDb,true];
				if (_idBd > -1) then {[_idBd,_xLifeToDb] remoteExecCall ["BRPVP_vehConsumeLifesFixDb",2];};
			};
			if (_fixed) then {[["cure_repair",1]] call BRPVP_mudaExp;};
		} else {
			"erro" call BRPVP_playSound;
		};
	};
	BRPVP_reparingVehicle = false;
	BRPVP_onAction = {
		private _object = _this select 0;
		private _action = _this select 3;
		private _isVeh = _object call BRPVP_isMotorizedNoTurret;
		private _canAccess = _object call BRPVP_checaAcesso;
		private _idBd = _object getVariable ["id_bd",-1];

		//AVOID EXPLOSION OF DEACTIVED MINES
		if (_action isEqualTo "DeactivateMine") then {
			private _mines = nearestObjects [player,[],5] select {str _x find "c4_charge_small.p3d" isNotEqualTo -1};
			private _removeTemp = [];
			{
				private _mine = _x;
				{
					private _aMine = _x select 0;
					if (_aMine isEqualTo _mine) then {_removeTemp pushBack (BRPVP_c4Monitore deleteAt _forEachIndex)};
				} forEachReversed BRPVP_c4Monitore;
			} forEach _mines;
			if (_removeTemp isNotEqualTo []) then {
				_removeTemp spawn {
					private _removeTemp = _this;
					private _count = count _removeTemp;
					private _remIdx = -1;
					waitUntil {{!isNull (_x select 0)} count _removeTemp < _count};
					{if (isNull (_x select 0)) exitWith {_remIdx = _forEachIndex;};} forEach _removeTemp;
					_removeTemp deleteAt _remIdx;
					BRPVP_c4Monitore append _removeTemp;
				};
			};
		};
		
		//SEND CVL BUILDINGS DOORS OPEN/CLOSE TO OTHER CLIENTS
		if (_action isEqualTo "UserType" && netId _object isEqualTo "0:0" && _idBd isNotEqualTo -1) then {
			private _class = typeOf _object;
			if (isClass (configFile >> "CfgVehicles" >> _class >> "AnimationSources")) then {
				private _currState = [];
				{
					private _aName = configName _x;
					if (_aName select [0,5] isEqualTo "Door_" && _aName select [count _aName-13,13] isEqualTo "_sound_source") then {
						private _phase = _object animationSourcePhase _aName;
						_currState pushBack [_aName,_phase];
					};
				} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _class >> "AnimationSources"));
				if (_currState isNotEqualTo []) then {
					[_class,_object,_idBd,_currState] spawn {
						params ["_class","_object","_idBd","_currState"];
						private _changed = [];
						private _cnt = 0;
						waitUntil {
							private _remoteInteraction = _object getVariable ["brpvp_remote_interaction",[]];
							_currState = _currState select {!((_x select 0) in _remoteInteraction)};
							{
								_x params ["_aName","_phase"];
								private _pNow = _object animationSourcePhase _aName;
								if (_pNow isNotEqualTo _phase) exitWith {
									private _direction = [0,1] select (_pNow > _phase);
									_changed = [_aName,_direction];
								};
							} forEach _currState;
							if (_changed isNotEqualTo []) exitWith {[_class,_idBd,_changed] remoteExecCall ["BRPVP_animeSourceDoorCVL",-clientOwner];};
							_cnt = _cnt+1;
							uiSleep 0.001;
							_cnt isEqualTo 5
						};
					};
				};
			};
		};

		//DISABLE PUNCH IF HEALING
		if (_action isEqualTo "HealSoldierSelf") then {
			BRPVP_playerIsHealing = true;
			0 spawn {uiSleep 6.5;BRPVP_playerIsHealing = false;};
		};

		//CANCEL IF DENIED PLAYER POSITION
		private _deniPosAll = _object getVariable ["brpvp_door_off",[]];
		private _posPlayer = ASLToAGL getPosASL player;
		if ({_posPlayer distance (_object modelToWorld _x) < 2.5} count _deniPosAll > 0) exitWith {
			[localize "str_near_denied_door",-5] call BRPVP_hint;
			true
		};

		//CANCEL IF OTHER PLAYER BACKPACK
		if (_action isEqualTo "OpenBag" && _object call BRPVP_isPlayer) exitWith {
			"erro" call BRPVP_playSound;
			true
		};

		//CHECK IF ON SAFE AND USER NEAR
		private _safeAndUserNear = false;
		if (BRPVP_safeZone && _isVeh && !_canAccess) then {
			{if ([_x,_object] call BRPVP_checaAcessoPlayer) exitWith {_safeAndUserNear = true;};} forEach (_object nearEntities [BRPVP_playerModel,200]);
		};
		if (_safeAndUserNear) exitWith {
			[localize "str_vehicle_user_is_near",-5,200,0,"erro"] call BRPVP_hint;
			true
		};

		//CAN'T ENTER VEHICLE IF BANDIT AND VEHICLE HAVE GOOD PERSONS
		if (_isVeh && {isNull objectParent player && player getVariable ["brpvp_pve_inside",0] > 0 && player in BRPVP_pveBanditObjList && {_x call BRPVP_isPlayer && !(_x in BRPVP_pveBanditObjList)} count crew _object > 0}) exitWith {
			[localize "str_bandit_cant_enter_good_car",-6] call BRPVP_hint;
			true
		};

		//CAN'T ENTER VEHICLE IF GOOD PERSON AND VEHICLE HAVE BANDIT
		if (_isVeh && {isNull objectParent player && player getVariable ["brpvp_pve_inside",0] > 0 && !(player in BRPVP_pveBanditObjList) && {_x call BRPVP_isPlayer && _x in BRPVP_pveBanditObjList} count crew _object > 0}) exitWith {
			[localize "str_good_cant_enter_bandit_car",-6] call BRPVP_hint;
			true
		};

		//OK IF LADDER
		if (_action in ["LadderOnUp","LadderOnDown"]) exitWith {false};

		//BLOCK IF MISSION BOX AND CANT OPEN
		(_object getVariable ["brpvp_mbots",[[0,0,0],0,[]]]) params ["_pos","_rad","_ais"];
		_dead = {!alive _x || _x distance _pos > _rad} count _ais;
		if (_dead < round (BRPVP_killPercToLiberateBox*count _ais) && !BRPVP_vePlayers) exitWith {
			[localize "str_lock_box_message",-5] call BRPVP_hint;
			true
		};

		//BLOCK ACTION IF ALIVE AI UNITS 2
		private _params = _object getVariable ["brpvp_mbots2",-1];
		private _mb2Ok = true;
		if (_params isNotEqualTo -1) then {
			_params params ["_pos","_rad","_ais","_limit","_localization","_fnc"];
			private _alive = {alive _x && _x distance _pos < _rad} count _ais;
			if (_alive > _limit) exitWith {
				[format [localize _localization,_alive-_limit],-5] call BRPVP_hint;
				_mb2Ok = false;
			};
			(_fnc select 0) call (_fnc select 1);
			_object setVariable ["brpvp_mbots2",-1,true];
		};
		if (!_mb2Ok) exitWith {true};

		//BLOCK IF ZOMBIE
		if (_object isKindOf BRPVP_zombieMotherClass) exitWith {
			"erro" call BRPVP_playSound;
			true
		};

		//OK IF LADDER
		if (!BRPVP_allowLandAutoPilot && _action isEqualTo "Land") exitWith {
			[localize "str_land_autopilot_off",-5] call BRPVP_hint;
			true
		};

		//PLAYER DOING OTHER ACTIONS CAN'T DO UI ACTIONS
		if (BRPVP_reparingVehicle || BRPVP_construindo || animationState player isEqualTo "ainvpknlmstpslaywrfldnon_medic") exitWith {true};

		//UAV TERMINAL
		if (_action isEqualTo "UAVTerminalOpen") exitWith {
			[getConnectedUAV player,str getConnectedUAV player] spawn {
				params ["_UAV","_UAVStr"];
				waitUntil {!isNull findDisplay 160};
				waitUntil {
					{if (_x call BRPVP_checaAcesso) then {player enableUAVConnectability [_x,false];} else {player disableUAVConnectability [_x,false];};} forEach allUnitsUAV;
					private _UAVNew = getConnectedUAV player;
					private _UAVNewStr = str getConnectedUAV player;
					if (_UAVNewStr isNotEqualTo _UAVStr) then {
						_UAV = _UAVNew;
						_UAVStr = _UAVNewStr;
						if (_UAV getVariable ["brpvp_auto_first",false]) then {
							_UAV setAutonomous false;
							_UAV setVariable ["brpvp_auto_first",false,true];
						};
					};
					isNull findDisplay 160
				};
				{player enableUAVConnectability [_x,false];} forEach allUnitsUAV;
				_init = time;
				_UAV = objNull;
				waitUntil {
					_UAV = getConnectedUAV player;
					!isNull _UAV || time-_init > 0.25
				};
				if (!isNull _UAV) then {
					player setVariable ["brpvp_my_looking_uav",_UAV,2];
					private _init = diag_tickTime;
					waitUntil {
						if (isAutonomous _UAV) then {
							if (_UAV getVariable ["brpvp_auto_first",false]) then {
								_UAV setAutonomous false;
								_UAV setVariable ["brpvp_auto_first",false,true];
							};
						};
						diag_tickTime-_init > 0.25
					};
				};
			};
			false
		};

		//LET THE INVENTORY EH TAKE CARE OF THE CHECKS
		if (_action isEqualTo "Gear") exitWith {false};
		
		//CANCEL SOME ACTIONS
		if (_action in ["Assemble","DisAssemble"]) exitWith {
			"erro" call BRPVP_playSound;
			true
		};

		//UAV TERMINAL DIRECT CONNECT
		//if (typeOf _object in BRPVP_vantVehiclesClass) exitWith {false};

		//RUN CUSTOM REPAIR PROCESS ON REPAIR VEHICLE
		if (_action isEqualTo "RepairVehicle") exitWith {
			if !(BRPVP_reparingVehicle) then {
				BRPVP_reparingVehicle = true;
				_object spawn BRPVP_fixVehicle;
			};
			true			
		};

		//ANTI-DUPE FOR TAKE WEAPON ACTION
		if (_action isEqualTo "TakeWeapon") then {
			0 spawn {
				BRPVP_antiWeaponDupeBoolean = true;
				sleep 1.5;
				BRPVP_antiWeaponDupeBoolean = false;
			};
		};

		//CONNECT TO DRONE BY ACTION MENU
		if (_action isEqualTo "UAVTerminalMakeConnection") then {
			if (_object getVariable ["brpvp_auto_first",false]) then {
				_object spawn {
					private _init = diag_tickTime;
					waitUntil {
						if (isAutonomous _this) then {
							if (_this getVariable ["brpvp_auto_first",false]) then {
								_this setAutonomous false;
								_this setVariable ["brpvp_auto_first",false,true];
							};
						};
						diag_tickTime-_init > 0.25
					};
				};
			};
		};

		//TURN DRONE AUTONOMOUS OFF
		if (_action isEqualTo "UAVTerminalHackConnection") then {
			if (_object getVariable ["brpvp_auto_first",false]) then {
				_object spawn {
					private _init = diag_tickTime;
					waitUntil {
						if (isAutonomous _this) then {
							if (_this getVariable ["brpvp_auto_first",false]) then {_this setVariable ["brpvp_auto_first",false,true];};
							_this setAutonomous false;
						};
						diag_tickTime-_init > 5
					};
				};
			};
			//SAVE ON DATABASE IF PERMANENT MISSION RAID DRONE
			if (_object getVariable ["brpvp_raid_mission_real_drone",false]) then {
				_object setVariable ["brpvp_raid_mission_real_drone",false,true];
				[_object,"",player,""] remoteExecCall ["BRPVP_raidTrainingEhToRealVeh",2];
			};
		};

		//GENERAL CHECK
		_isLockUnlock = _isVeh && _object getVariable ["own",-1] isNotEqualTo -1 && _object getVariable ["id_bd",-1] isNotEqualTo -1;
		_locked = _object getVariable ["brpvp_locked",false];

		//TRY TO USE LOCK PICK IF HOUSE AND NEEDED AND EQUIPED IN PLAYER
		_forceAccess = false;
		_allowError = true;
		_isHouse = _object iskindOf "House";
		_isWall = _object iskindOf "Wall";
		_isContainer = _object isKindOf "Cargo_base_F";
		if ((_isHouse || _isWall || _isContainer) && !(_object call BRPVP_checaAcesso) && BRPVP_equipedIllegalItem isEqualTo "BRP_doorThief") then {
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
							_forceAccess = true;
							"lock_pick_ok_music" call BRPVP_playSound;
							[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];

							//HINT PEOPLE ABOUT THE INVASION
							[player,getPosWorld _lpObj,serverTime] remoteExecCall ["BRPVP_lockPickedBuildingsServerAdd",2];

							if (_object getVariable ["brpvp_rto",false]) then {
								//ONE TIME HERE
								if (_isHouse) then {
									_arrow = createSimpleObject ["Sign_Arrow_F",getPosASL player];
									_arrow setVariable ["brpvp_hack_arrow",true,true];
								};
								_remove = true;

								//LOCAL ON ALL MACHINES
								_object setVariable ["brpvp_hacked",true,true];
								if (_isWall) then {_object setVariable ["brpvp_hacked_time",serverTime,true];};
								if (_isHouse) then {
									_places = _object getVariable ["brpvp_hacked_places",[]];
									_places pushBack getPosASL player;
									_object setVariable ["brpvp_hacked_places",_places,true];
								};
							} else {
								//ONE TIME HERE
								if (_isHouse) then {
									_arrow = createSimpleObject ["Sign_Arrow_F",getPosASL player];
									_arrow setVariable ["brpvp_hack_arrow",true,true];
								};
								_object call BRPVP_turnIntoBandit;
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

								//LOCAL ON ALL MACHINES
								if (netId _object isEqualTo "0:0") then {
									private _params = [_object getVariable ["id_bd",-1],typeOf _object,_isWall,_isHouse,getPosASL player,typeOf _object in BRPVP_buildingHaveDoorListCVL];
									_params remoteExecCall ["BRPVP_hackHouseOkSimpleObject",0];
								} else {
									_object setVariable ["brpvp_hacked",true,true];
									if (_isWall) then {_object setVariable ["brpvp_hacked_time",serverTime,true];};
									if (_isHouse) then {
										_places = _object getVariable ["brpvp_hacked_places",[]];
										_places pushBack getPosASL player;
										_object setVariable ["brpvp_hacked_places",_places,true];
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
		};

		_isOpActObj = objectParent player isEqualTo _object || (player call BRPVP_controlingUAV) isEqualTo _object ; //IS OPERATING ACTION OBJECT
		if ((_isLockUnlock && (!_locked || (_locked && _isOpActObj && !(_action in ["GetOut","Eject"])))) || (!_isLockUnlock && (_canAccess || _object isEqualTo player)) || _forceAccess) then {
			//CANCEL TURRET ENTRANCE IN PRIVATE WHELEED APC
			if (_action in ["GetInTurret","MoveToTurret"] && typeOf _object in BRPVP_classRemoveTurret && _object getVariable ["id_bd",-1] isNotEqualTo -1) then {
				[localize "str_apc_turret_off",3,10,677] call BRPVP_hint;
				true
			} else {
				//AVOID IF BANDIT ON COOL DOWN TIME
				_deltaSince = serverTime-(player getVariable ["brpvp_no_veh_time",-BRPVP_banditNoVehTime]);
				if (_isVeh && _deltaSince < BRPVP_banditNoVehTime) then {
					[format [localize "str_bandit_cant_enter_car",round (BRPVP_banditNoVehTime-_deltaSince)],-6] call BRPVP_hint;
					true
				} else {
					//SWITCH TO UAV DRIVER OR GUNNER
					if (_action in ["SwitchToUAVDriver","SwitchToUAVGunner"]) then {
						0 spawn {
							_init = time;
							_UAV = objNull;
							waitUntil {
								_UAV = player call BRPVP_controlingUAV;
								!isNull _UAV || time-_init > 0.5
							};
							if (!isNull _UAV) then {player setVariable ["brpvp_my_looking_uav",_UAV,2];};
						};
					};
					if (_action isEqualTo "BackFromUAV") then {
						player setVariable ["brpvp_my_looking_uav",objNull,2];
						_object call BRPVP_disableNearServiceAction;
					};
					if (_object call BRPVP_isMotorized) then {
						_object enableSimulation true;
						[_object,10] call BRPVP_enableVehOnInteractionNoCheck;
					};
					if (_object in BRPVP_ownedHouses) then {
						_object setVariable ["brpvp_time_can_disable",serverTime+15,2];
						if (!simulationEnabled _object) then {[_object,true] remoteEXecCall ["enableSimulationGlobal",2];};
					};
					false
				};
			};
		} else {
			if (_allowError) then {
				if (_isLockUnlock) then {
					[localize "str_no_access_locked",3,10,677,"erro"] call BRPVP_hint;
				} else {
					[localize "str_no_access",3,10,677,"erro"] call BRPVP_hint;
				};
			};
			true
		};
	};
	inGameUISetEventHandler ["Action","_this call BRPVP_onAction"];

	BRPVP_buildAdminGroups = [
		"Tanoa Bridge (Ponte de Tanoa)",
		"Player Construction Items",
		"MRX - All",
		"VR Blocks",
		"Nature - Trees",
		"Nature - Bushs",
		"Nature - Rocks",
		"Fences - City",
		"Fences - Industrial",
		"Fences - Military",
		"Fences - Sport and Recreation",
		"Structures - Airport",
		"Structures - Beach",
		"Structures - Cemetery",
		"Structures - City",
		"Structures - Construction Sites",
		"Structures - Historical",
		"Structures - Industrial",
		"Structures - Lamps",
		"Structures - Market",
		"Structures - Military",
		"Structures - Obstacles",
		"Structures - Railways",
		"Structures - Religious",
		"Structures - Seaport",
		"Structures - Services",
		"Structures - Sport and Recreation",
		"Structures - Storage",
		"Structures - Transportation",
		"Structures - Utilities",
		"Structures - Village",
		"Walls - City",
		"Walls - Historical",
		"Walls - Industrial",
		"Walls - Military",
		"Walls - Obstacles",
		"Walls - Shoot House",
		"Walls - Transportation",
		"Walls - Village"
	];
	BRPVP_buildAdminClasses = [
		["Tanoa Bridge (Ponte de Tanoa)","a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_down_f.p3d"],
		["Tanoa Bridge (Ponte de Tanoa)","a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_f.p3d"],
		["Tanoa Bridge (Ponte de Tanoa)","a3\structures_f_exp\infrastructure\bridges\bridgesea_01_ramp_up_f.p3d"],
		["Tanoa Bridge (Ponte de Tanoa)","a3\structures_f_exp\infrastructure\bridges\bridgesea_01_f.p3d"],
		["Tanoa Bridge (Ponte de Tanoa)","a3\structures_f_exp\infrastructure\bridges\bridgesea_01_pillar_f.p3d"],
		["Player Construction Items","Land_GuardTower_01_F"],
		["Player Construction Items","Land_MultistoryBuilding_01_F"],
		["Player Construction Items","Land_MultistoryBuilding_03_F"],
		["Player Construction Items","Land_MultistoryBuilding_04_F"],
		["Player Construction Items","Land_Flush_Light_green_F"],
		["Player Construction Items","Land_Flush_Light_red_F"],
		["Player Construction Items","Land_Flush_Light_yellow_F"],
		["Player Construction Items","Land_runway_edgelight"],
		["Player Construction Items","Land_runway_edgelight_blue_F"],
		["Player Construction Items","Land_PortableHelipadLight_01_F"],
		["Player Construction Items","PortableHelipadLight_01_blue_F"],
		["Player Construction Items","PortableHelipadLight_01_red_F"],
		["Player Construction Items","PortableHelipadLight_01_white_F"],
		["Player Construction Items","PortableHelipadLight_01_green_F"],
		["Player Construction Items","PortableHelipadLight_01_yellow_F"],
		["Player Construction Items","Land_Runway_PAPI"],
		["Player Construction Items","Land_WoodenWall_02_s_gate_F"],
		["Player Construction Items","Land_WiredFence_01_gate_F"],
		["Player Construction Items","Land_PipeFence_01_m_gate_v2_closed_F"],
		["Player Construction Items","Land_PipeFence_01_m_gate_v1_F"],
		["Player Construction Items","Land_BackAlley_01_l_gate_F"],
		["Player Construction Items","Land_NetFence_02_m_gate_v1_closed_F"],
		["Player Construction Items","Land_Net_Fence_Gate_F"],
		["Player Construction Items","Land_City_Gate_F"],
		["Player Construction Items","Land_Stone_Gate_F"],
		["Player Construction Items","Land_ConcreteWall_01_m_gate_F"],
		["Player Construction Items","Land_ConcreteWall_01_l_gate_F"],
		["Player Construction Items","Land_BarGate_F"],
		["Player Construction Items","Land_RoadBarrier_01_F"],
		["Player Construction Items","Land_Razorwire_F"],
		["Player Construction Items","Land_Net_Fence_4m_F"],
		["Player Construction Items","Land_Net_Fence_8m_F"],
		["Player Construction Items","Land_Net_Fence_Pole_F"],
		["Player Construction Items","Land_Pipe_fence_4m_F"],
		["Player Construction Items","CamoNet_BLUFOR_big_F"],
		["Player Construction Items","CamoNet_BLUFOR_F"],
		["Player Construction Items","CamoNet_BLUFOR_open_F"],
		["Player Construction Items","CamoNet_OPFOR_big_F"],
		["Player Construction Items","CamoNet_OPFOR_F"],
		["Player Construction Items","CamoNet_OPFOR_open_F"],
		["Player Construction Items","CamoNet_INDP_big_F"],
		["Player Construction Items","CamoNet_INDP_F"],
		["Player Construction Items","CamoNet_INDP_open_F"],
		["Player Construction Items","Land_BagFence_Long_F"],
		["Player Construction Items","Land_BagFence_Short_F"],
		["Player Construction Items","Land_HBarrier_1_F"],
		["Player Construction Items","Land_HBarrier_3_F"],
		["Player Construction Items","Land_HBarrier_5_F"],
		["Player Construction Items","Land_City_4m_F"],
		["Player Construction Items","Land_City2_4m_F"],
		["Player Construction Items","Land_City_8m_F"],
		["Player Construction Items","Land_City_8mD_F"],
		["Player Construction Items","Land_City2_8m_F"],
		["Player Construction Items","Land_City_Pillar_F"],
		["Player Construction Items","Land_Stone_4m_F"],
		["Player Construction Items","Land_Stone_8m_F"],
		["Player Construction Items","Land_Stone_8mD_F"],
		["Player Construction Items","Land_Stone_Pillar_F"],
		["Player Construction Items","Land_Slum_House01_F"],
		["Player Construction Items","Land_Slum_House02_F"],
		["Player Construction Items","Land_Slum_House03_F"],
		["Player Construction Items","Land_cmp_Shed_F"],
		["Player Construction Items","Land_cargo_house_slum_F"],
		["Player Construction Items","Land_FuelStation_Build_F"],
		["Player Construction Items","Land_CncWall1_F"],
		["Player Construction Items","Land_CncWall4_F"],
		["Player Construction Items","Land_Concrete_SmallWall_4m_F"],
		["Player Construction Items","Land_Concrete_SmallWall_8m_F"],
		["Player Construction Items","Land_Wall_IndCnc_4_F"],
		["Player Construction Items","Land_PipeWall_concretel_8m_F"],
		["Player Construction Items","Land_AncientPillar_fallen_F"],
		["Player Construction Items","Land_Pier_F"],
		["Player Construction Items","Land_nav_pier_m_F"],
		["Player Construction Items","Land_Pier_Box_F"],
		["Player Construction Items","Land_Mound01_8m_F"],
		["Player Construction Items","Land_Mound02_8m_F"],
		["Player Construction Items","Land_Castle_01_church_a_ruin_F"],
		["Player Construction Items","Land_AirstripPlatform_01_F"],
		["Player Construction Items","Land_PierConcrete_01_16m_F"],
		["Player Construction Items","Land_Breakwater_02_F"],
		["Player Construction Items","Land_QuayConcrete_01_20m_F"],
		["Player Construction Items","Land_QuayConcrete_01_outterCorner_F"],
		["Player Construction Items","Land_Rail_ConcreteRamp_F"],
		["Player Construction Items","Land_ControlTower_01_F"],
		["Player Construction Items","Land_Cargo_HQ_V1_F"],
		["Player Construction Items","Land_Castle_01_tower_F"],
		["Player Construction Items","Land_Cargo_Tower_V1_F"],
		["Player Construction Items","Land_Cargo_Patrol_V1_F"],
		["Player Construction Items","Land_Airport_01_controlTower_F"],
		["Player Construction Items","Land_Airport_02_controlTower_F"],
		["Player Construction Items","Land_Airport_Tower_F"],
		["Player Construction Items","Land_WoodenCounter_01_F"],
		["Player Construction Items","Sign_Sphere200cm_F"],
		["Player Construction Items","Land_RaiStone_01_F"],
		["Player Construction Items","Land_GarbageBin_02_F"],
		["Player Construction Items","Land_CashDesk_F"],
		["Player Construction Items","Land_Communication_F"],
		["Player Construction Items","Land_Church_01_V1_F"],
		["Player Construction Items","Land_Offices_01_V1_F"],
		["Player Construction Items","Land_WIP_F"],
		["Player Construction Items","Land_dp_mainFactory_F"],
		["Player Construction Items","Land_i_Barracks_V1_F"],
		["Player Construction Items","Land_WoodenTable_large_F"],
		["Player Construction Items","Land_WoodenTable_small_F"],
		["Player Construction Items","Land_ChairWood_F"],
		["Player Construction Items","Land_Bench_F"],
		["Player Construction Items","Land_Bench_01_F"],
		["Player Construction Items","Land_Bench_02_F"],
		["Player Construction Items","Land_CampingTable_F"],
		["Player Construction Items","Land_CampingTable_small_F"],
		["Player Construction Items","Land_CampingChair_V1_F"],
		["Player Construction Items","Land_CampingChair_V2_F"],
		["Player Construction Items","Land_Sunshade_F"],
		["Player Construction Items","Land_Sunshade_01_F"],
		["Player Construction Items","Land_Sunshade_02_F"],
		["Player Construction Items","Land_Sunshade_03_F"],
		["Player Construction Items","Land_Sunshade_04_F"],
		["Player Construction Items","Land_BeachBooth_01_F"],
		["Player Construction Items","Land_LifeguardTower_01_F"],
		["Player Construction Items","Land_TablePlastic_01_F"],
		["Player Construction Items","Land_ChairPlastic_F"],
		["Player Construction Items","Land_Sun_chair_F"],
		["Player Construction Items","Land_Sun_chair_green_F"],
		["Player Construction Items","Land_BellTower_01_V1_F"],
		["Player Construction Items","Land_BellTower_02_V1_F"],
		["Player Construction Items","Land_BellTower_02_V2_F"],
		["Player Construction Items","Land_Calvary_01_V1_F"],
		["Player Construction Items","Land_Calvary_02_V1_F"],
		["Player Construction Items","Land_Calvary_02_V2_F"],
		["Player Construction Items","Land_Grave_obelisk_F"],
		["Player Construction Items","Land_Grave_memorial_F"],
		["Player Construction Items","Land_Grave_monument_F"],
		["Player Construction Items","Land_Bucket_F"],
		["Player Construction Items","Land_Bucket_clean_F"],
		["Player Construction Items","Land_Bucket_painted_F"],
		["Player Construction Items","Land_BucketNavy_F"],
		["Player Construction Items","Land_Basket_F"],
		["Player Construction Items","Land_cargo_addon02_V1_F"],
		["Player Construction Items","Land_cargo_addon02_V2_F"],
		["Player Construction Items","Land_GarbageBin_01_F"],
		["Player Construction Items","RoadCone_F"],
		["Player Construction Items","Land_GarbageBarrel_01_F"],
		["Player Construction Items","Land_WoodenLog_F"],
		["Player Construction Items","TargetP_Inf_F"],
		["Player Construction Items","Land_LampStreet_02_triple_F"],
		["Player Construction Items","Land_LampStreet_small_F"],
		["Player Construction Items","Land_LampStreet_F"],
		["Player Construction Items","Land_LampSolar_F"],
		["Player Construction Items","Land_LampDecor_F"],
		["Player Construction Items","Land_LampHalogen_F"],
		["Player Construction Items","Land_LampHarbour_F"],
		["Player Construction Items","Land_LampAirport_F"],
		["Player Construction Items","Land_LampShabby_F"],
		["Player Construction Items","Land_Cargo20_red_F"],
		["Player Construction Items","Land_Cargo20_blue_F"],
		["Player Construction Items","Land_Cargo20_light_green_F"],
		["Player Construction Items","Land_Cargo40_red_F"],
		["Player Construction Items","Land_Cargo40_blue_F"],
		["Player Construction Items","Land_Cargo40_light_green_F"],
		["Player Construction Items","Land_PartyTent_01_F"],
		["Player Construction Items","Land_Hedge_01_s_2m_F"],
		["Player Construction Items","Land_Hedge_01_s_4m_F"],
		["Player Construction Items","Land_SlideCastle_F"],
		["Player Construction Items","Land_Carousel_01_F"],
		["Player Construction Items","Land_Swing_01_F"],
		["Player Construction Items","Land_Kiosk_redburger_F"],
		["Player Construction Items","Land_Kiosk_papers_F"],
		["Player Construction Items","Land_Kiosk_gyros_F"],
		["Player Construction Items","Land_Kiosk_blueking_F"],
		["Player Construction Items","Land_TouristShelter_01_F"],
		["Player Construction Items","Land_Slide_F"],
		["Player Construction Items","Land_BC_Basket_F"],
		["Player Construction Items","Land_BC_Court_F"],
		["Player Construction Items","Land_Goal_F"],
		["Player Construction Items","Land_Tribune_F"],
		["Player Construction Items","Land_Sign_WarningMilitaryArea_F"],
		["Player Construction Items","Land_Sign_WarningMilAreaSmall_F"],
		["Player Construction Items","Land_Sign_WarningMilitaryVehicles_F"],
		["Player Construction Items","ArrowDesk_L_F"],
		["Player Construction Items","ArrowDesk_R_F"],
		["Player Construction Items","RoadBarrier_F"],
		["Player Construction Items","TapeSign_F"],
		["Player Construction Items",["BRPVP_C_IDAP_supplyCrate_F","C_IDAP_supplyCrate_F"]],
		["Player Construction Items",["BRPVP_Box_NATO_AmmoVeh_F","Box_NATO_AmmoVeh_F"]],
		["Player Construction Items",["BRPVP_Box_East_AmmoVeh_F","Box_East_AmmoVeh_F"]],
		["Player Construction Items",["BRPVP_Box_IND_AmmoVeh_F","Box_IND_AmmoVeh_F"]],
		["Player Construction Items",["BRPVP_Box_T_East_WpsSpecial_F","Box_T_East_WpsSpecial_F"]],
		["Player Construction Items",["BRPVP_C_T_supplyCrate_F","C_T_supplyCrate_F"]],
		["Player Construction Items",["BRPVP_Box_Syndicate_Ammo_F","Box_Syndicate_Ammo_F"]],
		["Player Construction Items",["BRPVP_Box_Syndicate_WpsLaunch_F","Box_Syndicate_WpsLaunch_F"]],
		["Player Construction Items","Land_HistoricalPlaneWreck_01_F"],
		["Player Construction Items","Land_HistoricalPlaneWreck_03_F"],
		["Player Construction Items","Land_UWreck_MV22_F"],
		["Player Construction Items","Land_Wreck_BMP2_F"],
		["Player Construction Items","Land_Wreck_BRDM2_F"],
		["Player Construction Items","Land_Wreck_Heli_Attack_01_F"],
		["Player Construction Items","Land_Wreck_Heli_Attack_02_F"],
		["Player Construction Items","Land_Wreck_HMMWV_F"],
		["Player Construction Items","Land_Wreck_Hunter_F"],
		["Player Construction Items","Land_Wreck_Skodovka_F"],
		["Player Construction Items","Land_Wreck_Slammer_F"],
		["Player Construction Items","Land_Wreck_Slammer_hull_F"],
		["Player Construction Items","Land_Wreck_Slammer_turret_F"],
		["Player Construction Items","Land_Wreck_T72_hull_F"],
		["Player Construction Items","Land_Scrap_MRAP_01_F"],
		["Player Construction Items","Land_Wreck_Ural_F"],
		["Player Construction Items","Land_Wreck_UAZ_F"],
		["Player Construction Items","Land_MetalShelter_01_F"],
		["Player Construction Items","Land_Cargo_House_V1_F"],
		["Player Construction Items","Land_Cargo_House_V3_F"],
		["Player Construction Items","Land_Cargo_House_V2_F"],
		["Player Construction Items","Land_i_Addon_02_V1_F"],
		["Player Construction Items","Land_i_Addon_03_V1_F"],
		["Player Construction Items","Land_i_Addon_03mid_V1_F"],
		["Player Construction Items","Land_i_House_Small_02_V1_F"],
		["Player Construction Items","Land_i_House_Small_02_V2_F"],
		["Player Construction Items","Land_i_House_Small_02_V3_F"],
		["Player Construction Items","Land_GH_House_2_F"],
		["Player Construction Items","Land_i_House_Small_01_V1_F"],
		["Player Construction Items","Land_i_House_Small_01_V2_F"],
		["Player Construction Items","Land_Lighthouse_small_F"],
		["Player Construction Items","Land_i_Windmill01_F"],
		["Player Construction Items","Land_HBarrierTower_F"],
		["Player Construction Items","Land_HBarrierWall_corridor_F"],
		["Player Construction Items","Land_Chapel_Small_V1_F"],
		["Player Construction Items","Land_FireEscape_01_short_F"],
		["Player Construction Items","Land_FireEscape_01_tall_F"],
		["Player Construction Items","Land_MetalShelter_02_F"],
		["Player Construction Items","Land_Pier_addon"],
		["Player Construction Items","Land_GH_House_1_F"],
		["Player Construction Items","Land_i_House_Big_01_V1_F"],
		["Player Construction Items","Land_i_House_Big_01_V2_F"],
		["Player Construction Items","Land_i_House_Big_01_V3_F"],
		["Player Construction Items","Land_i_House_Big_02_V1_F"],
		["Player Construction Items","Land_i_House_Big_02_V2_F"],
		["Player Construction Items","Land_i_House_Big_02_V3_F"],
		["Player Construction Items","Land_u_House_Big_01_V1_F"],
		["Player Construction Items","Land_u_House_Big_02_V1_F"],
		["Player Construction Items","Land_i_Shop_01_V1_F"],
		["Player Construction Items","Land_i_Shop_01_V2_F"],
		["Player Construction Items","Land_i_Shop_02_V1_F"],
		["Player Construction Items","Land_i_Shop_02_V2_F"],
		["Player Construction Items","Land_i_Shop_02_V3_F"],
		["Player Construction Items","Land_dp_smallTank_F"],
		["Player Construction Items","Land_Medevac_house_V1_F"],
		["Player Construction Items","Land_GH_MainBuilding_entry_F"],
		["Player Construction Items","Land_Shed_Big_F"],
		["Player Construction Items","Land_ContainerLine_01_F"],
		["Player Construction Items","Land_ContainerLine_02_F"],
		["Player Construction Items","Land_ContainerLine_03_F"],
		["Player Construction Items","Land_FuelStation_01_shop_F"],
		["Player Construction Items","Land_FuelStation_01_workshop_F"],
		["Player Construction Items","Land_Lighthouse_03_red_F"],
		["Player Construction Items","Land_Lighthouse_03_green_F"],
		["Player Construction Items","Land_StorageTank_01_small_F"],
		["Player Construction Items","Land_GarageRow_01_large_F"],
		["Player Construction Items","Land_LightHouse_F"],
		["Player Construction Items","Land_Rail_Bridge_40_F"],
		["Player Construction Items","Land_Dome_Small_F"],
		["Player Construction Items","Land_TentHangar_V1_F"],
		["Player Construction Items","Land_i_Barracks_V1_F"],
		["Player Construction Items","Land_i_Barracks_V2_F"],
		["Player Construction Items","Land_u_Barracks_V2_F"],
		["Player Construction Items","Land_Barracks_01_camo_F"],
		["Player Construction Items","Land_Airport_01_hangar_F"],
		["Player Construction Items","Land_Shop_Town_03_F"],
		["Player Construction Items","Land_Warehouse_03_F"],
		["Player Construction Items","Land_Hospital_main_F"],
		["Player Construction Items","Land_Hospital_side1_F"],
		["Player Construction Items","Land_Hospital_side2_F"],
		["Player Construction Items","Land_GH_MainBuilding_middle_F"],
		["Player Construction Items","Land_GH_MainBuilding_left_F"],
		["Player Construction Items","Land_GH_MainBuilding_right_F"],
		["Player Construction Items","Land_Airport_center_F"],
		["Player Construction Items","Land_Airport_left_F"],
		["Player Construction Items","Land_Airport_right_F"],
		["Player Construction Items","Land_Medevac_HQ_V1_F"],
		["Player Construction Items","Land_i_Shed_Ind_F"],
		["Player Construction Items","Land_Chapel_V1_F"],
		["Player Construction Items","Land_ReservoirTower_F"],
		["Player Construction Items","Land_SCF_01_shed_F"],
		["Player Construction Items","Land_Hangar_F"],
		["Player Construction Items","Land_spp_Tower_F"],
		["Player Construction Items","Land_CementWorks_01_brick_F"],
		["Player Construction Items","Land_Offices_01_V1_F"],
		["Player Construction Items","Land_Airport_02_hangar_left_F"],
		["Player Construction Items","Land_Airport_02_hangar_right_F"],
		["Player Construction Items","Land_WIP_F"],
		["Player Construction Items","Land_Hotel_01_F"],
		["Player Construction Items","Land_Dome_Big_F"],
		["Player Construction Items","Land_MilOffices_V1_F"],
		["Player Construction Items","Land_TTowerSmall_1_F"],
		["Player Construction Items","Land_TTowerSmall_2_F"],
		["Player Construction Items","Land_TTowerBig_1_F"],
		["Player Construction Items","Land_TTowerBig_2_F"],
		["Player Construction Items","Land_Canal_Dutch_01_15m_F"],
		["Player Construction Items","Land_Canal_Dutch_01_corner_F"],
		["Player Construction Items","Land_CobblestoneSquare_01_8m_F"],
		["Player Construction Items","Land_GH_Stairs_F"],
		["Player Construction Items","Land_VR_Block_01_F"],
		["Player Construction Items","Land_VR_Block_02_F"],
		["Player Construction Items","Land_VR_Block_03_F"],
		["Player Construction Items","Land_VR_Block_04_F"],
		["Player Construction Items","Land_VR_Block_05_F"],
		["Player Construction Items","Land_VR_Slope_01_F"],
		["Player Construction Items","Land_Pier_small_F"],
		["Player Construction Items","Land_PierLadder_F"],
		["Player Construction Items","Land_Castle_01_step_F"],
		["Player Construction Items","Land_RampConcrete_F"],
		["Player Construction Items","Land_RampConcreteHigh_F"],
		["Player Construction Items","Land_Obstacle_Ramp_F"],
		["Player Construction Items","Land_Obstacle_RunAround_F"],
		["Player Construction Items","Land_Obstacle_Climb_F"],
		["Player Construction Items","Land_Obstacle_Bridge_F"],
		["Player Construction Items","BlockConcrete_F"],
		["Player Construction Items","Land_Razorwire_F"],
		["Player Construction Items","Land_CncShelter_F"],
		["Player Construction Items","Land_Canal_Dutch_01_plate_F"],
		["Player Construction Items","Land_PhoneBooth_01_F"],
		["Player Construction Items","Land_PhoneBooth_02_F"],
		["Player Construction Items","Land_GarbageContainer_closed_F"],
		["Player Construction Items","Land_FieldToilet_F"],
		["Player Construction Items","Land_WaterBarrel_F"],
		["Player Construction Items","Land_Pallets_stack_F"],
		["Player Construction Items","Land_PaperBox_closed_F"],
		["Player Construction Items","Land_Laptop_unfolded_F"],
		["Player Construction Items","Land_Ground_sheet_folded_blue_F"],
		["Player Construction Items","Land_Ground_sheet_folded_khaki_F"],
		["Player Construction Items","Land_Ground_sheet_folded_yellow_F"],
		["Player Construction Items","Land_Tyre_F"],
		["Player Construction Items","Land_BarrelEmpty_F"],
		["Player Construction Items","Land_MetalBarrel_empty_F"],
		["Player Construction Items","Land_BarrelEmpty_grey_F"],
		["Player Construction Items","Land_Ketchup_01_F"],
		["Player Construction Items","Land_HelipadCircle_F"],
		["Player Construction Items","Land_HelipadCivil_F"],
		["Player Construction Items","Land_HelipadRescue_F"],
		["Player Construction Items","Land_HelipadSquare_F"],
		["Player Construction Items","Land_TreeBin_F"],
		["Player Construction Items","a3\plants_f\tree\t_broussonetiap1s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_ficusb1s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_ficusb2s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_fraxinusav2s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_oleae1s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_oleae2s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_phoenixc1s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_phoenixc3s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_pinusp3s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_pinuss1s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_pinuss2s_b_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_pinuss2s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_poplar2f_dead_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_populusn3s_f.p3d"],
		["Player Construction Items","a3\plants_f\tree\t_quercusir2s_f.p3d"],
		["Player Construction Items","Land_Shovel_F"],
		//["Player Construction Items","Flag_BI_F"],
		//["Player Construction Items","Flag_Green_F"],
		//["Player Construction Items","Flag_Blue_F"],
		//["Player Construction Items","Flag_White_F"],
		//["Player Construction Items","Flag_Red_F"],
		//["Player Construction Items","I_HMG_01_high_F"],
		//["Player Construction Items","I_HMG_01_F"],
		//["Player Construction Items","I_static_AT_F"],
		//["Player Construction Items","I_static_AA_F"],
		["Player Construction Items","Land_Bunker_01_big_F"],
		["Player Construction Items","Land_BagBunker_Small_F"],
		["Player Construction Items","Land_BagBunker_01_large_green_F"],
		["Player Construction Items","Land_BagBunker_Large_F"],
		["Player Construction Items","Land_Bunker_01_HQ_F"],
		["Player Construction Items","Land_Bunker_02_light_double_F"],
		["Player Construction Items","Land_BagBunker_01_small_green_F"],
		["Player Construction Items","Land_PillboxBunker_01_hex_F"],
		["Player Construction Items","Land_Bunker_01_small_F"],
		["Player Construction Items","Land_PillboxBunker_01_big_F"],
		["Player Construction Items","Land_BagBunker_Tower_F"],
		["Player Construction Items","Land_HBarrier_01_tower_green_F"],
		["Player Construction Items","Land_PillboxBunker_01_rectangle_F"],
		//["Player Construction Items","I_HMG_01_high_F"],
		//["Player Construction Items","I_HMG_01_F"],
		//["Player Construction Items","I_static_AT_F"],
		//["Player Construction Items","I_static_AA_F"],
		["MRX - All","Land_BarGate_F"],
		["MRX - All","Land_JumpTarget_F"],
		["MRX - All","ArrowDesk_L_F"],
		["MRX - All","ArrowDesk_R_F"],
		["MRX - All","ArrowMarker_R_F"],
		["MRX - All","ArrowMarker_L_F"],
		["MRX - All","RoadBarrier_F"],
		["MRX - All","Land_PartyTent_01_F"],
		["MRX - All","Land_GymBench_01_F"],
		["MRX - All","Land_GymRack_01_F"],
		["MRX - All","Land_GymRack_02_F"],
		["MRX - All","Land_GymRack_03_F"],
		["MRX - All","Land_PlasticBarrier_01_F"],
		["MRX - All","Land_PlasticBarrier_01_line_x2_F"],
		["MRX - All","Land_PlasticBarrier_01_line_x4_F"],
		["MRX - All","Land_PlasticBarrier_01_line_x6_F"],
		["MRX - All","Land_PlasticBarrier_02_F"],
		["MRX - All","PlasticBarrier_02_grey_F"],
		["MRX - All","PlasticBarrier_02_yellow_F"],
		["MRX - All","Land_PlasticBarrier_03_F"],
		["MRX - All","PlasticBarrier_03_blue_F"],
		["MRX - All","Land_PalletTrolley_01_khaki_F"],
		["MRX - All","Land_PalletTrolley_01_yellow_F"],
		["MRX - All","Land_EngineCrane_01_F"],
		["MRX - All","WaterPump_01_sand_F"],
		["MRX - All","WaterPump_01_forest_F"],
		["MRX - All","Land_FloodLight_F"],
		["MRX - All","Land_PortableLight_single_F"],
		["MRX - All","Land_PortableLight_double_F"],
		["MRX - All","Land_Tyre_01_line_x5_F"],
		["MRX - All","Land_Bench_03_F"],
		["MRX - All","Land_Bench_04_F"],
		["MRX - All","Land_Bench_05_F"],
		["MRX - All","Land_CinderBlocks_01_F"],
		["MRX - All","Land_GarbageHeap_01_F"],
		["MRX - All","Land_GarbageHeap_02_F"],
		["MRX - All","Land_GarbageHeap_03_F"],
		["MRX - All","Land_GarbageHeap_04_F"],
		["MRX - All","Land_Volleyball_01_F"],
		["VR Blocks","Land_VR_Block_01_F"],
		["VR Blocks","Land_VR_Block_02_F"],
		["VR Blocks","Land_VR_Block_03_F"],
		["VR Blocks","Land_VR_Block_04_F"],
		["VR Blocks","Land_VR_Block_05_F"],
		["VR Blocks","Land_VR_Slope_01_F"],
		["Nature - Trees","a3\plants_f\Tree\t_BroussonetiaP1s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_FicusB1s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_FicusB2s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_FraxinusAV2s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_OleaE1s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_OleaE2s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_PhoenixC1s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_PhoenixC3s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_PinusP3s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_PinusS1s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_PinusS2s_b_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_PinusS2s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_poplar2f_dead_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_PopulusN3s_F.p3d"],
		["Nature - Trees","a3\plants_f\Tree\t_QuercusIR2s_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\bw_SetBig_Brains_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\bw_SetBig_corals_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\bw_SetBig_TubeG_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\bw_SetBig_TubeY_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\bw_SetSmall_Brains_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\bw_SetSmall_TubeG_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\bw_SetSmall_TubeY_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_ArundoD2s_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_ArundoD3s_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_FicusC1s_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_ficusC2d_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_FicusC2s_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_NeriumO2d_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_NeriumO2s_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_NeriumO2s_white_F.p3d"],
		["Nature - Bushs","a3\plants_f\Bush\b_Thistle_Thorn_Green.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntRock_apart.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntRock_monolith.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntRock_spike.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntRock_wallH.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntRock_wallV.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntStones_erosion.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntStone_01.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntStone_01_LC.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntStone_02.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntStone_02_LC.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntStone_03.p3d"],
		["Nature - Rocks","a3\rocks_f\Blunt\BluntStone_03_LC.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpRock_apart.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpRock_monolith.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpRock_spike.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpRock_wallH.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpRock_wallV.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpStones_erosion.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpStone_01.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpStone_01_LC.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpStone_02.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpStone_02_LC.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpStone_03.p3d"],
		["Nature - Rocks","a3\rocks_f\Sharp\sharpStone_03_LC.p3d"],
		["Nature - Rocks","a3\rocks_f\Small_Stone_01_F.p3d"],
		["Nature - Rocks","a3\rocks_f\Small_Stone_02_F.p3d"],
		["Nature - Rocks","a3\rocks_f\StoneSharp_big.p3d"],
		["Nature - Rocks","a3\rocks_f\StoneSharp_medium.p3d"],
		["Nature - Rocks","a3\rocks_f\StoneSharp_small.p3d"],
		["Nature - Rocks","a3\rocks_f\StoneSharp_Wall.p3d"],
		["Nature - Rocks","a3\rocks_f\Stone_big_F.p3d"],
		["Nature - Rocks","a3\rocks_f\Stone_medium_F.p3d"],
		["Nature - Rocks","a3\rocks_f\Stone_small_F.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\StoneSharp_big_W.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\StoneSharp_medium_W.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\StoneSharp_small_W.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\StoneSharp_Wall_W.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\Stone_big_W.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\Stone_medium_W.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\Stone_small_W.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpRock_apart.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpRock_monolith.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpRock_spike.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpRock_wallH.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpRock_wallV.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpStones_erosion.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpStone_01.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpStone_02.p3d"],
		["Nature - Rocks","a3\rocks_f\Water\W_sharpStone_03.p3d"],
		["Fences - City","Land_Net_Fence_4m_F"],
		["Fences - City","Land_Net_Fence_8m_F"],
		["Fences - City","Land_Net_Fence_Gate_F"],
		["Fences - City","Land_Net_Fence_pole_F"],
		["Fences - City","Land_Net_FenceD_8m_F"],
		["Fences - City","Land_Pipe_fence_4m_F"],
		["Fences - City","Land_Pipe_fence_4mNoLC_F"],
		["Fences - City","Land_PipeWall_concretel_8m_F"],
		["Fences - City","Land_BackAlley_01_l_1m_F"],
		["Fences - City","Land_BackAlley_01_l_gap_F"],
		["Fences - City","Land_BackAlley_01_l_gate_F"],
		["Fences - City","Land_BackAlley_02_l_1m_F"],
		["Fences - Industrial","Land_IndFnc_3_D_F"],
		["Fences - Industrial","Land_IndFnc_3_F"],
		["Fences - Industrial","Land_IndFnc_3_Hole_F"],
		["Fences - Industrial","Land_IndFnc_9_F"],
		["Fences - Industrial","Land_IndFnc_Corner_F"],
		["Fences - Industrial","Land_IndFnc_Pole_F"],
		["Fences - Industrial","Land_NetFence_01_m_4m_F"],
		["Fences - Industrial","Land_NetFence_01_m_4m_noLC_F"],
		["Fences - Industrial","Land_NetFence_01_m_8m_F"],
		["Fences - Industrial","Land_NetFence_01_m_8m_noLC_F"],
		["Fences - Industrial","Land_NetFence_01_m_d_F"],
		["Fences - Industrial","Land_NetFence_01_m_d_noLC_F"],
		["Fences - Industrial","Land_NetFence_01_m_gate_F"],
		["Fences - Industrial","Land_NetFence_01_m_pole_F"],
		["Fences - Industrial","Land_VineyardFence_01_F"],
		["Fences - Military","Land_BagFence_Corner_F"],
		["Fences - Military","Land_BagFence_End_F"],
		["Fences - Military","Land_BagFence_Long_F"],
		["Fences - Military","Land_BagFence_Round_F"],
		["Fences - Military","Land_BagFence_Short_F"],
		["Fences - Military","Land_Razorwire_F"],
		["Fences - Military","Land_Mil_WiredFence_F"],
		["Fences - Military","Land_Mil_WiredFence_Gate_F"],
		["Fences - Military","Land_Mil_WiredFenceD_F"],
		["Fences - Military","Land_New_WiredFence_5m_F"],
		["Fences - Military","Land_New_WiredFence_10m_Dam_F"],
		["Fences - Military","Land_New_WiredFence_10m_F"],
		["Fences - Military","Land_New_WiredFence_pole_F"],
		["Fences - Military","Land_Wired_Fence_4m_F"],
		["Fences - Military","Land_Wired_Fence_4mD_F"],
		["Fences - Military","Land_Wired_Fence_8m_F"],
		["Fences - Military","Land_Wired_Fence_8mD_F"],
		["Fences - Sport and Recreation","Land_SportGround_fence_F"],
		["Fences - Sport and Recreation","Land_SportGround_fence_noLC_F"],
		["Structures - Airport","Land_NavigLight"],
		["Structures - Airport","Land_NavigLight_3_F"],
		["Structures - Airport","Land_Flush_Light_green_F"],
		["Structures - Airport","Land_Flush_Light_red_F"],
		["Structures - Airport","Land_Flush_Light_yellow_F"],
		["Structures - Airport","Land_runway_edgelight"],
		["Structures - Airport","Land_runway_edgelight_blue_F"],
		["Structures - Airport","Land_Runway_PAPI"],
		["Structures - Airport","Land_Runway_PAPI_2"],
		["Structures - Airport","Land_Runway_PAPI_3"],
		["Structures - Airport","Land_Runway_PAPI_4"],
		["Structures - Airport","Land_Airport_center_F"],
		["Structures - Airport","Land_Airport_left_F"],
		["Structures - Airport","Land_Airport_right_F"],
		["Structures - Airport","Land_Airport_Tower_F"],
		["Structures - Airport","Land_Airport_Tower_dam_F"],
		["Structures - Airport","Land_Hangar_F"],
		["Structures - Airport","Land_Radar_F"],
		["Structures - Airport","Land_Radar_Small_F"],
		["Structures - Airport","Land_TentHangar_V1_F"],
		["Structures - Airport","Land_TentHangar_V1_dam_F"],
		["Structures - Airport","Windsock_01_F"],
		["Structures - Airport","Land_Airport_01_controlTower_F"],
		["Structures - Airport","Land_Airport_01_hangar_F"],
		["Structures - Airport","Land_Airport_01_terminal_F"],
		["Structures - Airport","Land_Airport_02_controlTower_F"],
		["Structures - Airport","Land_Airport_02_hangar_left_F"],
		["Structures - Airport","Land_Airport_02_hangar_right_F"],
		["Structures - Airport","Land_Airport_02_terminal_F"],
		["Structures - Airport","Land_Airport_02_sign_aeroport_F"],
		["Structures - Airport","Land_Airport_02_sign_arrivees_F"],
		["Structures - Airport","Land_Airport_02_sign_de_F"],
		["Structures - Airport","Land_Airport_02_sign_departs_F"],
		["Structures - Airport","Land_Airport_02_sign_tanoa_F"],
		["Structures - Airport","Land_AirstripPlatform_01_F"],
		["Structures - Airport","Land_AirstripPlatform_01_footer_F"],
		["Structures - Airport","Land_NavigLight_3_short_F"],
		["Structures - Beach","Land_BeachBooth_01_F"],
		["Structures - Beach","Land_LifeguardTower_01_F"],
		["Structures - Cemetery","Land_Grave_memorial_F"],
		["Structures - Cemetery","Land_Grave_monument_F"],
		["Structures - Cemetery","Land_Grave_obelisk_F"],
		["Structures - Cemetery","Land_Grave_soldier_F"],
		["Structures - Cemetery","Land_Grave_V1_F"],
		["Structures - Cemetery","Land_Grave_V2_F"],
		["Structures - Cemetery","Land_Grave_V3_F"],
		["Structures - Cemetery","Land_Grave_dirt_F"],
		["Structures - Cemetery","Land_Grave_forest_F"],
		["Structures - Cemetery","Land_Grave_rocks_F"],
		["Structures - Cemetery","Land_Grave_01_F"],
		["Structures - Cemetery","Land_Grave_02_F"],
		["Structures - Cemetery","Land_Grave_03_F"],
		["Structures - Cemetery","Land_Grave_04_F"],
		["Structures - Cemetery","Land_Grave_05_F"],
		["Structures - Cemetery","Land_Grave_06_F"],
		["Structures - Cemetery","Land_Grave_07_F"],
		["Structures - Cemetery","Land_Tomb_01_F"],
		["Structures - Cemetery","Land_Tombstone_01_F"],
		["Structures - Cemetery","Land_Tombstone_02_F"],
		["Structures - Cemetery","Land_Tombstone_03_F"],
		["Structures - City","Land_TreeBin_F"],
		["Structures - City","Land_Water_source_F"],
		["Structures - City","Land_Offices_01_V1_F"],
		["Structures - City","Land_WIP_F"],
		["Structures - City","Land_i_House_Big_01_V1_F"],
		["Structures - City","Land_i_House_Big_01_V1_dam_F"],
		["Structures - City","Land_i_House_Big_01_V2_F"],
		["Structures - City","Land_i_House_Big_01_V2_dam_F"],
		["Structures - City","Land_i_House_Big_01_V3_F"],
		["Structures - City","Land_i_House_Big_01_V3_dam_F"],
		["Structures - City","Land_u_House_Big_01_V1_F"],
		["Structures - City","Land_u_House_Big_01_V1_dam_F"],
		["Structures - City","Land_d_House_Big_01_V1_F"],
		["Structures - City","Land_i_House_Big_02_V1_F"],
		["Structures - City","Land_i_House_Big_02_V1_dam_F"],
		["Structures - City","Land_i_House_Big_02_V2_F"],
		["Structures - City","Land_i_House_Big_02_V2_dam_F"],
		["Structures - City","Land_i_House_Big_02_V3_F"],
		["Structures - City","Land_i_House_Big_02_V3_dam_F"],
		["Structures - City","Land_u_House_Big_02_V1_F"],
		["Structures - City","Land_u_House_Big_02_V1_dam_F"],
		["Structures - City","Land_d_House_Big_02_V1_F"],
		["Structures - City","Land_i_Shop_01_V1_F"],
		["Structures - City","Land_i_Shop_01_V1_dam_F"],
		["Structures - City","Land_i_Shop_01_V2_F"],
		["Structures - City","Land_i_Shop_01_V2_dam_F"],
		["Structures - City","Land_i_Shop_01_V3_F"],
		["Structures - City","Land_i_Shop_01_V3_dam_F"],
		["Structures - City","Land_u_Shop_01_V1_F"],
		["Structures - City","Land_u_Shop_01_V1_dam_F"],
		["Structures - City","Land_d_Shop_01_V1_F"],
		["Structures - City","Land_i_Shop_02_V1_F"],
		["Structures - City","Land_i_Shop_02_V1_dam_F"],
		["Structures - City","Land_i_Shop_02_V2_F"],
		["Structures - City","Land_i_Shop_02_V2_dam_F"],
		["Structures - City","Land_i_Shop_02_V3_F"],
		["Structures - City","Land_i_Shop_02_V3_dam_F"],
		["Structures - City","Land_u_Shop_02_V1_F"],
		["Structures - City","Land_u_Shop_02_V1_dam_F"],
		["Structures - City","Land_d_Shop_02_V1_F"],
		["Structures - City","Land_i_House_Small_03_V1_F"],
		["Structures - City","Land_i_House_Small_03_V1_dam_F"],
		["Structures - City","Land_Unfinished_Building_01_F"],
		["Structures - City","Land_Unfinished_Building_02_F"],
		["Structures - City","Land_FireEscape_01_short_F"],
		["Structures - City","Land_FireEscape_01_tall_F"],
		["Structures - City","Land_Pot_01_F"],
		["Structures - City","Land_Pot_02_F"],
		["Structures - City","Land_House_Big_03_F"],
		["Structures - City","Land_House_Big_04_F"],
		["Structures - City","Land_House_Big_05_F"],
		["Structures - City","Land_House_Small_04_F"],
		["Structures - City","Land_House_Small_05_F"],
		["Structures - City","Land_School_01_F"],
		["Structures - City","Land_Addon_01_F"],
		["Structures - City","Land_Addon_02_F"],
		["Structures - City","Land_Addon_03_F"],
		["Structures - City","Land_Addon_04_F"],
		["Structures - City","Land_Addon_05_F"],
		["Structures - City","Land_SignMonolith_01_F"],
		["Structures - City","Land_MultistoryBuilding_01_F"],
		["Structures - City","Land_MultistoryBuilding_03_F"],
		["Structures - City","Land_MultistoryBuilding_04_F"],
		["Structures - City","Land_Shop_City_01_F"],
		["Structures - City","Land_Shop_City_02_F"],
		["Structures - City","Land_Shop_City_03_F"],
		["Structures - City","Land_Shop_City_04_F"],
		["Structures - City","Land_Shop_City_05_F"],
		["Structures - City","Land_Shop_City_06_F"],
		["Structures - City","Land_Shop_City_07_F"],
		["Structures - Construction Sites","Land_Timbers_F"],
		["Structures - Construction Sites","Land_Bricks_V1_F"],
		["Structures - Construction Sites","Land_Bricks_V2_F"],
		["Structures - Construction Sites","Land_Bricks_V3_F"],
		["Structures - Construction Sites","Land_Bricks_V4_F"],
		["Structures - Construction Sites","Land_CinderBlocks_F"],
		["Structures - Construction Sites","Land_Coil_F"],
		["Structures - Construction Sites","Land_ConcretePipe_F"],
		["Structures - Construction Sites","Land_Pallet_F"],
		["Structures - Construction Sites","Land_Pallet_vertical_F"],
		["Structures - Construction Sites","Land_Pipes_large_F"],
		["Structures - Construction Sites","Land_Pipes_small_F"],
		["Structures - Construction Sites","Land_WorkStand_F"],
		["Structures - Construction Sites","Land_Crane_F"],
		["Structures - Construction Sites","Land_MobileCrane_01_F"],
		["Structures - Construction Sites","Land_MobileCrane_01_hook_F"],
		["Structures - Historical","Land_AncientPillar_F"],
		["Structures - Historical","Land_AncientPillar_damaged_F"],
		["Structures - Historical","Land_AncientPillar_fallen_F"],
		["Structures - Historical","Land_Maroula_base_F"],
		["Structures - Historical","Land_Maroula_F"],
		["Structures - Historical","Land_MolonLabe_F"],
		["Structures - Historical","Land_Amphitheater_F"],
		["Structures - Historical","Land_Castle_01_wall_01_F"],
		["Structures - Historical","Land_Castle_01_wall_02_F"],
		["Structures - Historical","Land_Castle_01_wall_03_F"],
		["Structures - Historical","Land_Castle_01_wall_04_F"],
		["Structures - Historical","Land_Castle_01_wall_05_F"],
		["Structures - Historical","Land_Castle_01_wall_06_F"],
		["Structures - Historical","Land_Castle_01_wall_07_F"],
		["Structures - Historical","Land_Castle_01_wall_08_F"],
		["Structures - Historical","Land_Castle_01_wall_09_F"],
		["Structures - Historical","Land_Castle_01_wall_10_F"],
		["Structures - Historical","Land_Castle_01_wall_11_F"],
		["Structures - Historical","Land_Castle_01_wall_12_F"],
		["Structures - Historical","Land_Castle_01_wall_13_F"],
		["Structures - Historical","Land_Castle_01_wall_14_F"],
		["Structures - Historical","Land_Castle_01_wall_15_F"],
		["Structures - Historical","Land_Castle_01_wall_16_F"],
		["Structures - Historical","Land_Castle_01_house_ruin_F"],
		["Structures - Historical","Land_Castle_01_church_a_ruin_F"],
		["Structures - Historical","Land_Castle_01_church_b_ruin_F"],
		["Structures - Historical","Land_Castle_01_church_ruin_F"],
		["Structures - Historical","Land_Castle_01_step_F"],
		["Structures - Historical","Land_Castle_01_tower_F"],
		["Structures - Historical","Land_d_Windmill01_F"],
		["Structures - Historical","Land_i_Windmill01_F"],
		["Structures - Historical","Land_House_Native_01_F"],
		["Structures - Historical","Land_House_Native_02_F"],
		["Structures - Historical","Land_AncientHead_01_F"],
		["Structures - Historical","Land_AncientStatue_01_F"],
		["Structures - Historical","Land_AncientStatue_02_F"],
		["Structures - Historical","Land_PetroglyphWall_01_F"],
		["Structures - Historical","Land_PetroglyphWall_02_F"],
		["Structures - Historical","Land_RaiStone_01_F"],
		["Structures - Historical","Land_StoneTanoa_01_F"],
		["Structures - Historical","Land_BasaltKerb_01_2m_F"],
		["Structures - Historical","Land_BasaltKerb_01_2m_d_F"],
		["Structures - Historical","Land_BasaltKerb_01_4m_F"],
		["Structures - Historical","Land_BasaltKerb_01_pile_F"],
		["Structures - Historical","Land_BasaltKerb_01_platform_F"],
		["Structures - Historical","Land_BasaltWall_01_4m_F"],
		["Structures - Historical","Land_BasaltWall_01_8m_F"],
		["Structures - Historical","Land_BasaltWall_01_d_left_F"],
		["Structures - Historical","Land_BasaltWall_01_d_right_F"],
		["Structures - Historical","Land_BasaltWall_01_gate_F"],
		["Structures - Historical","Land_Fortress_01_5m_F"],
		["Structures - Historical","Land_Fortress_01_10m_F"],
		["Structures - Historical","Land_Fortress_01_bricks_v1_F"],
		["Structures - Historical","Land_Fortress_01_bricks_v2_F"],
		["Structures - Historical","Land_Fortress_01_cannon_F"],
		["Structures - Historical","Land_Fortress_01_d_L_F"],
		["Structures - Historical","Land_Fortress_01_d_R_F"],
		["Structures - Historical","Land_Fortress_01_innerCorner_70_F"],
		["Structures - Historical","Land_Fortress_01_innerCorner_90_F"],
		["Structures - Historical","Land_Fortress_01_innerCorner_110_F"],
		["Structures - Historical","Land_Fortress_01_outterCorner_50_F"],
		["Structures - Historical","Land_Fortress_01_outterCorner_80_F"],
		["Structures - Historical","Land_Fortress_01_outterCorner_90_F"],
		["Structures - Historical","Land_Temple_Native_01_F"],
		["Structures - Historical","Land_EmplacementGun_01_mossy_F"],
		["Structures - Historical","Land_EmplacementGun_01_rusty_F"],
		["Structures - Historical","Land_EmplacementGun_01_d_mossy_F"],
		["Structures - Historical","Land_EmplacementGun_01_d_rusty_F"],
		["Structures - Industrial","Land_cmp_Hopper_F"],
		["Structures - Industrial","Land_cmp_Shed_F"],
		["Structures - Industrial","Land_cmp_Shed_dam_F"],
		["Structures - Industrial","Land_cmp_Tower_F"],
		["Structures - Industrial","Land_dp_bigTank_F"],
		["Structures - Industrial","Land_dp_mainFactory_F"],
		["Structures - Industrial","Land_dp_smallFactory_F"],
		["Structures - Industrial","Land_dp_smallTank_F"],
		["Structures - Industrial","Land_dp_transformer_F"],
		["Structures - Industrial","Land_Factory_Conv1_10_F"],
		["Structures - Industrial","Land_Factory_Conv1_End_F"],
		["Structures - Industrial","Land_Factory_Conv1_Main_F"],
		["Structures - Industrial","Land_Factory_Conv2_F"],
		["Structures - Industrial","Land_Factory_Hopper_F"],
		["Structures - Industrial","Land_Factory_Main_F"],
		["Structures - Industrial","Land_Factory_Tunnel_F"],
		["Structures - Industrial","Land_Shed_Big_F"],
		["Structures - Industrial","Land_Shed_Small_F"],
		["Structures - Industrial","Land_i_Shed_Ind_F"],
		["Structures - Industrial","Land_u_Shed_Ind_F"],
		["Structures - Industrial","Land_Tank_rust_F"],
		["Structures - Industrial","Land_Warehouse_03_F"],
		["Structures - Industrial","Land_DPP_01_mainFactory_F"],
		["Structures - Industrial","Land_DPP_01_smallFactory_F"],
		["Structures - Industrial","Land_DPP_01_transformer_F"],
		["Structures - Industrial","Land_DPP_01_waterCooler_F"],
		["Structures - Industrial","Land_DPP_01_waterCooler_ladder_F"],
		["Structures - Industrial","Land_Walkover_01_F"],
		["Structures - Industrial","Land_SY_01_block_F"],
		["Structures - Industrial","Land_SY_01_conveyor_end_F"],
		["Structures - Industrial","Land_SY_01_conveyor_chute_F"],
		["Structures - Industrial","Land_SY_01_conveyor_junction_F"],
		["Structures - Industrial","Land_SY_01_conveyor_long_F"],
		["Structures - Industrial","Land_SY_01_conveyor_reclaimer_F"],
		["Structures - Industrial","Land_SY_01_conveyor_short_F"],
		["Structures - Industrial","Land_SY_01_conveyor_slope_F"],
		["Structures - Industrial","Land_SY_01_crusher_F"],
		["Structures - Industrial","Land_SY_01_reclaimer_F"],
		["Structures - Industrial","Land_SY_01_shiploader_arm_F"],
		["Structures - Industrial","Land_SY_01_shiploader_F"],
		["Structures - Industrial","Land_SY_01_stockpile_01_F"],
		["Structures - Industrial","Land_SY_01_stockpile_02_F"],
		["Structures - Industrial","Land_SY_01_tripper_F"],
		["Structures - Industrial","Land_SCF_01_boilerBuilding_F"],
		["Structures - Industrial","Land_SCF_01_clarifier_F"],
		["Structures - Industrial","Land_SCF_01_condenser_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_8m_high_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_16m_high_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_16m_slope_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_columnBase_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_end_high_F"],
		["Structures - Industrial","Land_SCF_01_conveyor_hole_F"],
		["Structures - Industrial","Land_SCF_01_crystallizer_F"],
		["Structures - Industrial","Land_SCF_01_crystallizerTowers_F"],
		["Structures - Industrial","Land_SCF_01_diffuser_F"],
		["Structures - Industrial","Land_SCF_01_feeder_F"],
		["Structures - Industrial","Land_SCF_01_generalBuilding_F"],
		["Structures - Industrial","Land_SCF_01_heap_bagasse_F"],
		["Structures - Industrial","Land_SCF_01_heap_sugarcane_F"],
		["Structures - Industrial","Land_SCF_01_chimney_F"],
		["Structures - Industrial","Land_SCF_01_pipe_24m_high_F"],
		["Structures - Industrial","Land_SCF_01_pipe_24m_F"],
		["Structures - Industrial","Land_SCF_01_pipe_8m_high_F"],
		["Structures - Industrial","Land_SCF_01_pipe_8m_F"],
		["Structures - Industrial","Land_SCF_01_pipe_curve_high_F"],
		["Structures - Industrial","Land_SCF_01_pipe_curve_F"],
		["Structures - Industrial","Land_SCF_01_pipe_end_F"],
		["Structures - Industrial","Land_SCF_01_pipe_up_F"],
		["Structures - Industrial","Land_SCF_01_shed_F"],
		["Structures - Industrial","Land_SCF_01_shredder_F"],
		["Structures - Industrial","Land_SCF_01_storageBin_big_F"],
		["Structures - Industrial","Land_SCF_01_storageBin_medium_F"],
		["Structures - Industrial","Land_SCF_01_storageBin_small_F"],
		["Structures - Industrial","Land_SCF_01_warehouse_F"],
		["Structures - Industrial","Land_SCF_01_washer_F"],
		["Structures - Industrial","Land_SM_01_shed_F"],
		["Structures - Industrial","Land_SM_01_shed_unfinished_F"],
		["Structures - Industrial","Land_SM_01_shelter_narrow_F"],
		["Structures - Industrial","Land_SM_01_shelter_wide_F"],
		["Structures - Lamps","Land_LampAirport_F"],
		["Structures - Lamps","Land_LampDecor_F"],
		["Structures - Lamps","Land_LampHalogen_F"],
		["Structures - Lamps","Land_LampHarbour_F"],
		["Structures - Lamps","Land_LampShabby_F"],
		["Structures - Lamps","Land_LampSolar_F"],
		["Structures - Lamps","Land_LampStadium_F"],
		["Structures - Lamps","Land_LampStreet_F"],
		["Structures - Lamps","Land_LampStreet_small_F"],
		["Structures - Market","Land_WheelCart_F"],
		["Structures - Market","Land_MarketShelter_F"],
		["Structures - Market","Land_StallWater_F"],
		["Structures - Market","Land_ClothShelter_01_F"],
		["Structures - Market","Land_ClothShelter_02_F"],
		["Structures - Market","Land_MetalShelter_01_F"],
		["Structures - Market","Land_MetalShelter_02_F"],
		["Structures - Market","Land_WoodenShelter_01_F"],
		["Structures - Military","Land_BagBunker_Large_F"],
		["Structures - Military","Land_BagBunker_Small_F"],
		["Structures - Military","Land_BagBunker_Tower_F"],
		["Structures - Military","Land_i_Barracks_V1_F"],
		["Structures - Military","Land_i_Barracks_V1_dam_F"],
		["Structures - Military","Land_i_Barracks_V2_F"],
		["Structures - Military","Land_i_Barracks_V2_dam_F"],
		["Structures - Military","Land_u_Barracks_V2_F"],
		["Structures - Military","Land_Bunker_F"],
		["Structures - Military","Land_Cargo_House_V1_F"],
		["Structures - Military","Land_Cargo_House_V2_F"],
		["Structures - Military","Land_Cargo_House_V3_F"],
		["Structures - Military","Land_Cargo_HQ_V1_F"],
		["Structures - Military","Land_Cargo_HQ_V2_F"],
		["Structures - Military","Land_Cargo_HQ_V3_F"],
		["Structures - Military","Land_Cargo_Patrol_V1_F"],
		["Structures - Military","Land_Cargo_Patrol_V2_F"],
		["Structures - Military","Land_Cargo_Patrol_V3_F"],
		["Structures - Military","Land_Cargo_Tower_V1_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No1_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No2_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No3_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No4_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No5_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No6_F"],
		["Structures - Military","Land_Cargo_Tower_V1_No7_F"],
		["Structures - Military","Land_Cargo_Tower_V2_F"],
		["Structures - Military","Land_Cargo_Tower_V3_F"],
		["Structures - Military","Land_Medevac_house_V1_F"],
		["Structures - Military","Land_Medevac_HQ_V1_F"],
		["Structures - Military","Land_MilOffices_V1_F"],
		["Structures - Military","CamoNet_BLUFOR_F"],
		["Structures - Military","CamoNet_OPFOR_F"],
		["Structures - Military","CamoNet_INDP_F"],
		["Structures - Military","CamoNet_BLUFOR_open_F"],
		["Structures - Military","CamoNet_OPFOR_open_F"],
		["Structures - Military","CamoNet_INDP_open_F"],
		["Structures - Military","CamoNet_BLUFOR_big_F"],
		["Structures - Military","CamoNet_OPFOR_big_F"],
		["Structures - Military","CamoNet_INDP_big_F"],
		["Structures - Military","CamoNet_BLUFOR_Curator_F"],
		["Structures - Military","CamoNet_OPFOR_Curator_F"],
		["Structures - Military","CamoNet_INDP_Curator_F"],
		["Structures - Military","CamoNet_BLUFOR_open_Curator_F"],
		["Structures - Military","CamoNet_OPFOR_open_Curator_F"],
		["Structures - Military","CamoNet_INDP_open_Curator_F"],
		["Structures - Military","CamoNet_BLUFOR_big_Curator_F"],
		["Structures - Military","CamoNet_OPFOR_big_Curator_F"],
		["Structures - Military","CamoNet_INDP_big_Curator_F"],
		["Structures - Military","Land_Dome_Big_F"],
		["Structures - Military","Land_Dome_Small_F"],
		["Structures - Military","Land_Research_house_V1_F"],
		["Structures - Military","Land_Research_HQ_F"],
		["Structures - Military","ShootingPos_F"],
		["Structures - Military","Land_ShootingPos_F"],
		["Structures - Military","Bomb"],
		["Structures - Military","Land_StorageBladder_01_F"],
		["Structures - Military","StorageBladder_01_fuel_forest_F"],
		["Structures - Military","StorageBladder_01_fuel_sand_F"],
		["Structures - Military","Land_StorageBladder_02_F"],
		["Structures - Military","StorageBladder_02_water_forest_F"],
		["Structures - Military","StorageBladder_02_water_sand_F"],
		["Structures - Military","Land_ContainmentArea_01_F"],
		["Structures - Military","ContainmentArea_01_forest_F"],
		["Structures - Military","ContainmentArea_01_sand_F"],
		["Structures - Military","Land_ContainmentArea_02_F"],
		["Structures - Military","ContainmentArea_02_forest_F"],
		["Structures - Military","ContainmentArea_02_sand_F"],
		["Structures - Military","Land_IRMaskingCover_01_F"],
		["Structures - Military","Land_IRMaskingCover_02_F"],
		["Structures - Military","Land_Barracks_01_camo_F"],
		["Structures - Military","Land_Barracks_01_grey_F"],
		["Structures - Military","Land_Barracks_01_dilapidated_F"],
		["Structures - Military","CamoNet_ghex_F"],
		["Structures - Military","CamoNet_ghex_open_F"],
		["Structures - Military","CamoNet_ghex_big_F"],
		["Structures - Military","CamoNet_ghex_Curator_F"],
		["Structures - Military","CamoNet_ghex_open_Curator_F"],
		["Structures - Military","CamoNet_ghex_big_Curator_F"],
		["Structures - Military","Land_Cargo_House_V4_F"],
		["Structures - Military","Land_Cargo_HQ_V4_F"],
		["Structures - Military","Land_Cargo_Patrol_V4_F"],
		["Structures - Military","Land_Cargo_Tower_V4_F"],
		["Structures - Military","Land_BagBunker_01_large_green_F"],
		["Structures - Military","Land_BagBunker_01_small_green_F"],
		["Structures - Military","Land_BagFence_01_corner_green_F"],
		["Structures - Military","Land_BagFence_01_end_green_F"],
		["Structures - Military","Land_BagFence_01_long_green_F"],
		["Structures - Military","Land_BagFence_01_round_green_F"],
		["Structures - Military","Land_BagFence_01_short_green_F"],
		["Structures - Military","Land_HBarrier_01_big_4_green_F"],
		["Structures - Military","Land_HBarrier_01_big_tower_green_F"],
		["Structures - Military","Land_HBarrier_01_line_1_green_F"],
		["Structures - Military","Land_HBarrier_01_line_3_green_F"],
		["Structures - Military","Land_HBarrier_01_line_5_green_F"],
		["Structures - Military","Land_HBarrier_01_tower_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_4_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_6_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_corner_green_F"],
		["Structures - Military","Land_HBarrier_01_wall_corridor_green_F"],
		["Structures - Military","Land_PillboxBunker_01_big_F"],
		["Structures - Military","Land_PillboxBunker_01_hex_F"],
		["Structures - Military","Land_PillboxBunker_01_rectangle_F"],
		["Structures - Military","Land_PillboxWall_01_3m_F"],
		["Structures - Military","Land_PillboxWall_01_3m_round_F"],
		["Structures - Military","Land_PillboxWall_01_6m_F"],
		["Structures - Military","Land_PillboxWall_01_6m_round_F"],
		["Structures - Military","Land_TrenchFrame_01_F"],
		["Structures - Military","Land_Trench_01_forest_F"],
		["Structures - Military","Land_Trench_01_grass_F"],
		["Structures - Military","Land_Mil_WallBig_debris_F"],
		["Structures - Obstacles","BlockConcrete_F"],
		["Structures - Obstacles","Dirthump_1_F"],
		["Structures - Obstacles","Dirthump_2_F"],
		["Structures - Obstacles","Dirthump_3_F"],
		["Structures - Obstacles","Dirthump_4_F"],
		["Structures - Obstacles","Land_Obstacle_Bridge_F"],
		["Structures - Obstacles","Land_Obstacle_Climb_F"],
		["Structures - Obstacles","Land_Obstacle_Crawl_F"],
		["Structures - Obstacles","Land_Obstacle_Cross_F"],
		["Structures - Obstacles","Land_Obstacle_Pass_F"],
		["Structures - Obstacles","Land_Obstacle_Ramp_F"],
		["Structures - Obstacles","Land_Obstacle_RunAround_F"],
		["Structures - Obstacles","Land_Obstacle_Saddle_F"],
		["Structures - Obstacles","Land_RampConcrete_F"],
		["Structures - Obstacles","Land_RampConcreteHigh_F"],
		["Structures - Obstacles","Land_CncShelter_F"],
		["Structures - Railways","Land_Track_01_3m_F"],
		["Structures - Railways","Land_Track_01_7deg_F"],
		["Structures - Railways","Land_Track_01_10m_F"],
		["Structures - Railways","Land_Track_01_15deg_F"],
		["Structures - Railways","Land_Track_01_20m_F"],
		["Structures - Railways","Land_Track_01_30deg_F"],
		["Structures - Railways","Land_Track_01_bridge_F"],
		["Structures - Railways","Land_Track_01_bumper_F"],
		["Structures - Railways","Land_Track_01_crossing_F"],
		["Structures - Railways","Land_Track_01_switch_F"],
		["Structures - Railways","Land_Track_01_turnout_left_F"],
		["Structures - Railways","Land_Track_01_turnout_right_F"],
		["Structures - Religious","Land_BellTower_01_V1_F"],
		["Structures - Religious","Land_BellTower_01_V2_F"],
		["Structures - Religious","Land_BellTower_02_V1_F"],
		["Structures - Religious","Land_BellTower_02_V2_F"],
		["Structures - Religious","Land_Calvary_01_V1_F"],
		["Structures - Religious","Land_Calvary_02_V1_F"],
		["Structures - Religious","Land_Calvary_02_V2_F"],
		["Structures - Religious","Land_Chapel_V1_F"],
		["Structures - Religious","Land_Chapel_V2_F"],
		["Structures - Religious","Land_Chapel_Small_V1_F"],
		["Structures - Religious","Land_Chapel_Small_V2_F"],
		["Structures - Religious","Land_Church_01_V1_F"],
		["Structures - Religious","Land_Cathedral_01_F"],
		["Structures - Religious","Land_Mausoleum_01_F"],
		["Structures - Religious","Land_Church_01_F"],
		["Structures - Religious","Land_Church_02_F"],
		["Structures - Religious","Land_Church_03_F"],
		["Structures - Seaport","Land_LightHouse_F"],
		["Structures - Seaport","Land_Lighthouse_small_F"],
		["Structures - Seaport","Land_BuoyBig_F"],
		["Structures - Seaport","Land_nav_pier_m_F"],
		["Structures - Seaport","Land_Pier_addon"],
		["Structures - Seaport","Land_Pier_Box_F"],
		["Structures - Seaport","Land_Pier_F"],
		["Structures - Seaport","Land_Pier_small_F"],
		["Structures - Seaport","Land_Pier_wall_F"],
		["Structures - Seaport","Land_PierLadder_F"],
		["Structures - Seaport","Land_Pillar_Pier_F"],
		["Structures - Seaport","Land_Sea_Wall_F"],
		["Structures - Seaport","C_Boat_Civil_04_F"],
		["Structures - Seaport","Submarine_01_F"],
		["Structures - Seaport","Land_ContainerCrane_01_F"],
		["Structures - Seaport","Land_ContainerCrane_01_arm_F"],
		["Structures - Seaport","Land_ContainerCrane_01_arm_lowered_F"],
		["Structures - Seaport","Land_CraneRail_01_F"],
		["Structures - Seaport","Land_DryDock_01_end_F"],
		["Structures - Seaport","Land_DryDock_01_middle_F"],
		["Structures - Seaport","Land_GantryCrane_01_F"],
		["Structures - Seaport","Land_GuardHouse_01_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_15m_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_bridge_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_corner_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_plate_F"],
		["Structures - Seaport","Land_Canal_Dutch_01_stairs_F"],
		["Structures - Seaport","Land_Breakwater_01_F"],
		["Structures - Seaport","Land_Breakwater_02_F"],
		["Structures - Seaport","Land_QuayConcrete_01_5m_ladder_F"],
		["Structures - Seaport","Land_QuayConcrete_01_20m_F"],
		["Structures - Seaport","Land_QuayConcrete_01_20m_wall_F"],
		["Structures - Seaport","Land_QuayConcrete_01_innerCorner_F"],
		["Structures - Seaport","Land_QuayConcrete_01_outterCorner_F"],
		["Structures - Seaport","Land_QuayConcrete_01_pier_F"],
		["Structures - Seaport","Land_PierConcrete_01_4m_ladders_F"],
		["Structures - Seaport","Land_PierConcrete_01_16m_F"],
		["Structures - Seaport","Land_PierConcrete_01_30deg_F"],
		["Structures - Seaport","Land_PierConcrete_01_end_F"],
		["Structures - Seaport","Land_PierConcrete_01_steps_F"],
		["Structures - Seaport","Land_PierWooden_01_10m_noRails_F"],
		["Structures - Seaport","Land_PierWooden_01_16m_F"],
		["Structures - Seaport","Land_PierWooden_01_dock_F"],
		["Structures - Seaport","Land_PierWooden_01_hut_F"],
		["Structures - Seaport","Land_PierWooden_01_ladder_F"],
		["Structures - Seaport","Land_PierWooden_01_platform_F"],
		["Structures - Seaport","Land_PierWooden_02_16m_F"],
		["Structures - Seaport","Land_PierWooden_02_30deg_F"],
		["Structures - Seaport","Land_PierWooden_02_barrel_F"],
		["Structures - Seaport","Land_PierWooden_02_hut_F"],
		["Structures - Seaport","Land_PierWooden_02_ladder_F"],
		["Structures - Seaport","Land_PierWooden_03_F"],
		["Structures - Services","Land_Hospital_main_F"],
		["Structures - Services","Land_Hospital_side1_F"],
		["Structures - Services","Land_Hospital_side2_F"],
		["Structures - Services","Land_CarService_F"],
		["Structures - Services","Land_FuelStation_Build_F"],
		["Structures - Services","Land_FuelStation_Feed_F"],
		["Structures - Services","Land_FuelStation_Shed_F"],
		["Structures - Services","Land_FuelStation_Sign_F"],
		["Structures - Services","Land_fs_feed_F"],
		["Structures - Services","Land_fs_price_F"],
		["Structures - Services","Land_fs_roof_F"],
		["Structures - Services","Land_fs_sign_F"],
		["Structures - Services","Land_PhoneBooth_01_F"],
		["Structures - Services","Land_PhoneBooth_02_F"],
		["Structures - Services","Land_Atm_01_F"],
		["Structures - Services","Land_Atm_02_F"],
		["Structures - Services","Land_Kiosk_blueking_F"],
		["Structures - Services","Land_Kiosk_gyros_F"],
		["Structures - Services","Land_Kiosk_papers_F"],
		["Structures - Services","Land_Kiosk_redburger_F"],
		["Structures - Services","Land_TouristShelter_01_F"],
		["Structures - Services","Land_GH_Gazebo_F"],
		["Structures - Services","Land_GH_House_1_F"],
		["Structures - Services","Land_GH_House_2_F"],
		["Structures - Services","Land_GH_MainBuilding_entry_F"],
		["Structures - Services","Land_GH_MainBuilding_left_F"],
		["Structures - Services","Land_GH_MainBuilding_middle_F"],
		["Structures - Services","Land_GH_MainBuilding_right_F"],
		["Structures - Services","Land_GH_Platform_F"],
		["Structures - Services","Land_GH_Pool_F"],
		["Structures - Services","Land_GH_Stairs_F"],
		["Structures - Services","Land_GarbageBin_02_F"],
		["Structures - Services","Land_FuelStation_01_arrow_F"],
		["Structures - Services","Land_FuelStation_01_prices_F"],
		["Structures - Services","Land_FuelStation_01_pump_F"],
		["Structures - Services","Land_FuelStation_01_roof_F"],
		["Structures - Services","Land_FuelStation_01_shop_F"],
		["Structures - Services","Land_FuelStation_01_workshop_F"],
		["Structures - Services","Land_FuelStation_02_prices_F"],
		["Structures - Services","Land_FuelStation_02_pump_F"],
		["Structures - Services","Land_FuelStation_02_roof_F"],
		["Structures - Services","Land_FuelStation_02_sign_F"],
		["Structures - Services","Land_FuelStation_02_workshop_F"],
		["Structures - Services","Land_Hotel_01_F"],
		["Structures - Services","Land_Hotel_02_F"],
		["Structures - Services","Land_Supermarket_01_F"],
		["Structures - Sport and Recreation","Land_Slide_F"],
		["Structures - Sport and Recreation","Land_BC_Basket_F"],
		["Structures - Sport and Recreation","Land_BC_Court_F"],
		["Structures - Sport and Recreation","Land_Goal_F"],
		["Structures - Sport and Recreation","Land_Tribune_F"],
		["Structures - Sport and Recreation","Land_SlideCastle_F"],
		["Structures - Sport and Recreation","Land_Carousel_01_F"],
		["Structures - Sport and Recreation","Land_Swing_01_F"],
		["Structures - Sport and Recreation","Land_Stadium_p1_F"],
		["Structures - Sport and Recreation","Land_Stadium_p2_F"],
		["Structures - Sport and Recreation","Land_Stadium_p3_F"],
		["Structures - Sport and Recreation","Land_Stadium_p4_F"],
		["Structures - Sport and Recreation","Land_Stadium_p5_F"],
		["Structures - Sport and Recreation","Land_Stadium_p6_F"],
		["Structures - Sport and Recreation","Land_Stadium_p7_F"],
		["Structures - Sport and Recreation","Land_Stadium_p8_F"],
		["Structures - Sport and Recreation","Land_Stadium_p9_F"],
		["Structures - Sport and Recreation","Land_FinishGate_01_narrow_F"],
		["Structures - Sport and Recreation","Land_FinishGate_01_wide_F"],
		["Structures - Sport and Recreation","Land_TyreBarrier_01_F"],
		["Structures - Sport and Recreation","TyreBarrier_01_black_F"],
		["Structures - Sport and Recreation","TyreBarrier_01_white_F"],
		["Structures - Sport and Recreation","Land_TyreBarrier_01_line_x4_F"],
		["Structures - Sport and Recreation","Land_TyreBarrier_01_line_x6_F"],
		["Structures - Sport and Recreation","Land_WinnersPodium_01_F"],
		["Structures - Sport and Recreation","Land_RugbyGoal_01_F"],
		["Structures - Storage","Land_WoodenBox_F"],
		["Structures - Storage","Land_ContainerLine_01_F"],
		["Structures - Storage","Land_ContainerLine_02_F"],
		["Structures - Storage","Land_ContainerLine_03_F"],
		["Structures - Storage","Land_StorageTank_01_large_F"],
		["Structures - Storage","Land_StorageTank_01_small_F"],
		["Structures - Storage","Land_Warehouse_01_F"],
		["Structures - Storage","Land_Warehouse_01_ladder_F"],
		["Structures - Storage","Land_Warehouse_02_F"],
		["Structures - Storage","Land_Warehouse_02_ladder_F"],
		["Structures - Storage","Land_WarehouseShelter_01_F"],
		["Structures - Transportation","Land_BridgeSea_01_pillar_F"],
		["Structures - Transportation","Land_BridgeWooden_01_pillar_F"],
		["Structures - Transportation","Land_ConcreteKerb_01_2m_F"],
		["Structures - Transportation","Land_ConcreteKerb_01_4m_F"],
		["Structures - Transportation","Land_ConcreteKerb_01_8m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_1m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_2m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_4m_F"],
		["Structures - Transportation","Land_ConcreteKerb_02_8m_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BW_long_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BW_short_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BY_long_F"],
		["Structures - Transportation","Land_ConcreteKerb_03_BY_short_F"],
		["Structures - Transportation","Land_GardenPavement_01_F"],
		["Structures - Transportation","Land_GardenPavement_02_F"],
		["Structures - Transportation","Land_KerbIsland_01_start_F"],
		["Structures - Transportation","Land_KerbIsland_01_end_F"],
		["Structures - Transportation","Land_Sidewalk_01_4m_F"],
		["Structures - Transportation","Land_Sidewalk_01_8m_F"],
		["Structures - Transportation","Land_Sidewalk_01_corner_F"],
		["Structures - Transportation","Land_Sidewalk_01_narrow_2m_F"],
		["Structures - Transportation","Land_Sidewalk_01_narrow_4m_F"],
		["Structures - Transportation","Land_Sidewalk_01_narrow_8m_F"],
		["Structures - Transportation","Land_Sidewalk_02_4m_F"],
		["Structures - Transportation","Land_Sidewalk_02_8m_F"],
		["Structures - Transportation","Land_Sidewalk_02_corner_F"],
		["Structures - Transportation","Land_Sidewalk_02_narrow_2m_F"],
		["Structures - Transportation","Land_Sidewalk_02_narrow_4m_F"],
		["Structures - Transportation","Land_Sidewalk_02_narrow_8m_F"],
		["Structures - Utilities","Land_Loudspeakers_F"],
		["Structures - Utilities","Land_IndPipe1_20m_F"],
		["Structures - Utilities","Land_IndPipe1_90degL_F"],
		["Structures - Utilities","Land_IndPipe1_90degR_F"],
		["Structures - Utilities","Land_IndPipe1_ground_F"],
		["Structures - Utilities","Land_IndPipe1_Uup_F"],
		["Structures - Utilities","Land_IndPipe1_valve_F"],
		["Structures - Utilities","Land_IndPipe2_big_9_F"],
		["Structures - Utilities","Land_IndPipe2_big_18_F"],
		["Structures - Utilities","Land_IndPipe2_big_18ladder_F"],
		["Structures - Utilities","Land_IndPipe2_big_ground1_F"],
		["Structures - Utilities","Land_IndPipe2_big_ground2_F"],
		["Structures - Utilities","Land_IndPipe2_big_support_F"],
		["Structures - Utilities","Land_IndPipe2_bigL_L_F"],
		["Structures - Utilities","Land_IndPipe2_bigL_R_F"],
		["Structures - Utilities","Land_IndPipe2_Small_9_F"],
		["Structures - Utilities","Land_IndPipe2_Small_ground1_F"],
		["Structures - Utilities","Land_IndPipe2_Small_ground2_F"],
		["Structures - Utilities","Land_IndPipe2_SmallL_L_F"],
		["Structures - Utilities","Land_IndPipe2_SmallL_R_F"],
		["Structures - Utilities","Land_HighVoltageColumn_F"],
		["Structures - Utilities","Land_HighVoltageColumnWire_F"],
		["Structures - Utilities","Land_HighVoltageEnd_F"],
		["Structures - Utilities","Land_HighVoltageTower_dam_F"],
		["Structures - Utilities","Land_HighVoltageTower_F"],
		["Structures - Utilities","Land_HighVoltageTower_large_F"],
		["Structures - Utilities","Land_HighVoltageTower_largeCorner_F"],
		["Structures - Utilities","Land_PowerCable_submarine_F"],
		["Structures - Utilities","Land_PowerLine_distributor_F"],
		["Structures - Utilities","Land_PowerLine_part_F"],
		["Structures - Utilities","Land_PowerPoleConcrete_F"],
		["Structures - Utilities","Land_PowerPoleWooden_F"],
		["Structures - Utilities","Land_PowerPoleWooden_L_off_F"],
		["Structures - Utilities","Land_PowerPoleWooden_L_F"],
		["Structures - Utilities","Land_PowerPoleWooden_small_F"],
		["Structures - Utilities","Land_PowerWireBig_direct_F"],
		["Structures - Utilities","Land_PowerWireBig_direct_short_F"],
		["Structures - Utilities","Land_PowerWireBig_end_F"],
		["Structures - Utilities","Land_PowerWireBig_left_F"],
		["Structures - Utilities","Land_PowerWireBig_right_F"],
		["Structures - Utilities","Land_PowerWireSmall_damaged_F"],
		["Structures - Utilities","Land_PowerWireSmall_direct_F"],
		["Structures - Utilities","Land_PowerWireSmall_Left_F"],
		["Structures - Utilities","Land_PowerWireSmall_Right_F"],
		["Structures - Utilities","Land_PowLines_Transformer_F"],
		["Structures - Utilities","Land_ReservoirTank_Airport_F"],
		["Structures - Utilities","Land_ReservoirTank_Rust_F"],
		["Structures - Utilities","Land_ReservoirTank_V1_F"],
		["Structures - Utilities","Land_ReservoirTower_F"],
		["Structures - Utilities","Land_SolarPanel_1_F"],
		["Structures - Utilities","Land_SolarPanel_2_F"],
		["Structures - Utilities","Land_SolarPanel_3_F"],
		["Structures - Utilities","Land_spp_Mirror_Broken_F"],
		["Structures - Utilities","Land_spp_Mirror_F"],
		["Structures - Utilities","Land_spp_Panel_Broken_F"],
		["Structures - Utilities","Land_spp_Panel_F"],
		["Structures - Utilities","Land_spp_Tower_F"],
		["Structures - Utilities","Land_spp_Tower_dam_F"],
		["Structures - Utilities","Land_spp_Transformer_F"],
		["Structures - Utilities","Land_Communication_anchor_F"],
		["Structures - Utilities","Land_Communication_F"],
		["Structures - Utilities","Land_TBox_F"],
		["Structures - Utilities","Land_TTowerBig_1_F"],
		["Structures - Utilities","Land_TTowerBig_2_F"],
		["Structures - Utilities","Land_TTowerSmall_1_F"],
		["Structures - Utilities","Land_TTowerSmall_2_F"],
		["Structures - Utilities","Land_WavePowerPlant_F"],
		["Structures - Utilities","Land_WavePowerPlantBroken_F"],
		["Structures - Utilities","Land_PowerGenerator_F"],
		["Structures - Utilities","Land_wpp_Turbine_V1_F"],
		["Structures - Utilities","Land_wpp_Turbine_V2_F"],
		["Structures - Utilities","Land_ConcreteWell_01_F"],
		["Structures - Utilities","Land_SM_01_reservoirTower_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_end_v1_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_end_v2_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_junction_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_lamp_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_lamp_off_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_small_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_tall_F"],
		["Structures - Utilities","Land_PowerLine_01_pole_transformer_F"],
		["Structures - Utilities","Land_PowerLine_01_wire_50m_F"],
		["Structures - Utilities","Land_PowerLine_01_wire_50m_main_F"],
		["Structures - Utilities","Land_SewerCover_01_F"],
		["Structures - Utilities","Land_SewerCover_02_F"],
		["Structures - Utilities","Land_SewerCover_03_F"],
		["Structures - Utilities","Land_WaterTank_01_F"],
		["Structures - Utilities","Land_WaterTank_02_F"],
		["Structures - Utilities","Land_WaterTank_03_F"],
		["Structures - Utilities","Land_WaterTank_04_F"],
		["Structures - Utilities","Land_WaterTower_01_F"],
		["Structures - Utilities","Land_WindmillPump_01_F"],
		["Structures - Village","Land_Pavement_narrow_corner_F"],
		["Structures - Village","Land_Pavement_narrow_F"],
		["Structures - Village","Land_Pavement_wide_corner_F"],
		["Structures - Village","Land_Pavement_wide_F"],
		["Structures - Village","Land_u_Addon_01_V1_F"],
		["Structures - Village","Land_u_Addon_01_V1_dam_F"],
		["Structures - Village","Land_d_Addon_02_V1_F"],
		["Structures - Village","Land_u_Addon_02_V1_F"],
		["Structures - Village","Land_i_Addon_02_V1_F"],
		["Structures - Village","Land_i_Addon_03_V1_F"],
		["Structures - Village","Land_i_Addon_03mid_V1_F"],
		["Structures - Village","Land_i_Addon_04_V1_F"],
		["Structures - Village","Land_i_Garage_V1_F"],
		["Structures - Village","Land_i_Garage_V1_dam_F"],
		["Structures - Village","Land_i_Garage_V2_F"],
		["Structures - Village","Land_i_Garage_V2_dam_F"],
		["Structures - Village","Land_Metal_Shed_F"],
		["Structures - Village","Land_i_House_Small_01_V1_F"],
		["Structures - Village","Land_i_House_Small_01_V1_dam_F"],
		["Structures - Village","Land_i_House_Small_01_V2_F"],
		["Structures - Village","Land_i_House_Small_01_V2_dam_F"],
		["Structures - Village","Land_i_House_Small_01_V3_F"],
		["Structures - Village","Land_i_House_Small_01_V3_dam_F"],
		["Structures - Village","Land_u_House_Small_01_V1_F"],
		["Structures - Village","Land_u_House_Small_01_V1_dam_F"],
		["Structures - Village","Land_d_House_Small_01_V1_F"],
		["Structures - Village","Land_i_House_Small_02_V1_F"],
		["Structures - Village","Land_i_House_Small_02_V1_dam_F"],
		["Structures - Village","Land_i_House_Small_02_V2_F"],
		["Structures - Village","Land_i_House_Small_02_V2_dam_F"],
		["Structures - Village","Land_i_House_Small_02_V3_F"],
		["Structures - Village","Land_i_House_Small_02_V3_dam_F"],
		["Structures - Village","Land_u_House_Small_02_V1_F"],
		["Structures - Village","Land_u_House_Small_02_V1_dam_F"],
		["Structures - Village","Land_d_House_Small_02_V1_F"],
		["Structures - Village","Land_cargo_addon01_V1_F"],
		["Structures - Village","Land_cargo_addon01_V2_F"],
		["Structures - Village","Land_cargo_addon02_V1_F"],
		["Structures - Village","Land_cargo_addon02_V2_F"],
		["Structures - Village","Land_cargo_house_slum_F"],
		["Structures - Village","Land_Slum_House01_F"],
		["Structures - Village","Land_Slum_House02_F"],
		["Structures - Village","Land_Slum_House03_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V1_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V1_dam_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V2_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V2_dam_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V3_F"],
		["Structures - Village","Land_i_Stone_HouseBig_V3_dam_F"],
		["Structures - Village","Land_d_Stone_HouseBig_V1_F"],
		["Structures - Village","Land_i_Stone_Shed_V1_F"],
		["Structures - Village","Land_i_Stone_Shed_V1_dam_F"],
		["Structures - Village","Land_i_Stone_Shed_V2_F"],
		["Structures - Village","Land_i_Stone_Shed_V2_dam_F"],
		["Structures - Village","Land_i_Stone_Shed_V3_F"],
		["Structures - Village","Land_i_Stone_Shed_V3_dam_F"],
		["Structures - Village","Land_d_Stone_Shed_V1_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V1_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V1_dam_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V2_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V2_dam_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V3_F"],
		["Structures - Village","Land_i_Stone_HouseSmall_V3_dam_F"],
		["Structures - Village","Land_d_Stone_HouseSmall_V1_F"],
		["Structures - Village","Land_Boat_03_abandoned_cover_F"],
		["Structures - Village","Land_ClothesLine_01_F"],
		["Structures - Village","Land_ClothesLine_01_full_F"],
		["Structures - Village","Land_ClothesLine_01_short_F"],
		["Structures - Village","Land_ConcreteBlock_01_F"],
		["Structures - Village","Land_PicnicTable_01_F"],
		["Structures - Village","Land_GarageShelter_01_F"],
		["Structures - Village","Land_House_Big_01_F"],
		["Structures - Village","Land_House_Big_02_F"],
		["Structures - Village","Land_House_Small_01_F"],
		["Structures - Village","Land_House_Small_02_F"],
		["Structures - Village","Land_House_Small_03_F"],
		["Structures - Village","Land_House_Small_06_F"],
		["Structures - Village","Land_Shed_01_F"],
		["Structures - Village","Land_Shed_02_F"],
		["Structures - Village","Land_Shed_03_F"],
		["Structures - Village","Land_Shed_04_F"],
		["Structures - Village","Land_Shed_05_F"],
		["Structures - Village","Land_Shed_06_F"],
		["Structures - Village","Land_Shed_07_F"],
		["Structures - Village","Land_Slum_01_F"],
		["Structures - Village","Land_Slum_02_F"],
		["Structures - Village","Land_Slum_03_F"],
		["Structures - Village","Land_Slum_04_F"],
		["Structures - Village","Land_Slum_05_F"],
		["Structures - Village","Land_Shop_Town_01_F"],
		["Structures - Village","Land_Shop_Town_02_F"],
		["Structures - Village","Land_Shop_Town_03_F"],
		["Structures - Village","Land_Shop_Town_04_F"],
		["Structures - Village","Land_Shop_Town_05_F"],
		["Structures - Village","Land_Shop_Town_05_addon_F"],
		["Walls - City","Land_Canal_Wall_10m_F"],
		["Walls - City","Land_Canal_Wall_D_center_F"],
		["Walls - City","Land_Canal_Wall_D_left_F"],
		["Walls - City","Land_Canal_Wall_D_right_F"],
		["Walls - City","Land_Canal_Wall_Stairs_F"],
		["Walls - City","Land_Canal_WallSmall_10m_F"],
		["Walls - City","Land_City_4m_F"],
		["Walls - City","Land_City_8m_F"],
		["Walls - City","Land_City_8mD_F"],
		["Walls - City","Land_City_Gate_F"],
		["Walls - City","Land_City_Pillar_F"],
		["Walls - City","Land_City2_4m_F"],
		["Walls - City","Land_City2_8m_F"],
		["Walls - City","Land_City2_8mD_F"],
		["Walls - City","Land_City2_PillarD_F"],
		["Walls - City","Land_Mil_ConcreteWall_F"],
		["Walls - City","Land_ConcreteWall_01_l_4m_F"],
		["Walls - City","Land_ConcreteWall_01_l_8m_F"],
		["Walls - City","Land_ConcreteWall_01_l_d_F"],
		["Walls - City","Land_ConcreteWall_01_l_gate_F"],
		["Walls - City","Land_ConcreteWall_01_l_pole_F"],
		["Walls - City","Land_ConcreteWall_01_m_4m_F"],
		["Walls - City","Land_ConcreteWall_01_m_8m_F"],
		["Walls - City","Land_ConcreteWall_01_m_d_F"],
		["Walls - City","Land_ConcreteWall_01_m_gate_F"],
		["Walls - City","Land_ConcreteWall_01_m_pole_F"],
		["Walls - City","Land_ConcreteWall_02_m_2m_F"],
		["Walls - City","Land_ConcreteWall_02_m_4m_F"],
		["Walls - City","Land_ConcreteWall_02_m_8m_F"],
		["Walls - City","Land_ConcreteWall_02_m_d_F"],
		["Walls - City","Land_ConcreteWall_02_m_gate_F"],
		["Walls - City","Land_ConcreteWall_02_m_pole_F"],
		["Walls - City","Land_Hedge_01_s_2m_F"],
		["Walls - City","Land_Hedge_01_s_4m_F"],
		["Walls - City","Land_NetFence_02_m_2m_F"],
		["Walls - City","Land_NetFence_02_m_4m_F"],
		["Walls - City","Land_NetFence_02_m_8m_F"],
		["Walls - City","Land_NetFence_02_m_d_F"],
		["Walls - City","Land_NetFence_02_m_gate_v1_F"],
		["Walls - City","Land_NetFence_02_m_gate_v2_F"],
		["Walls - City","Land_NetFence_02_m_pole_F"],
		["Walls - City","Land_PipeFence_01_m_2m_F"],
		["Walls - City","Land_PipeFence_01_m_4m_F"],
		["Walls - City","Land_PipeFence_01_m_8m_F"],
		["Walls - City","Land_PipeFence_01_m_d_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v1_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v2_F"],
		["Walls - City","Land_PipeFence_01_m_pole_F"],
		["Walls - City","Land_WallCity_01_4m_blue_F"],
		["Walls - City","Land_WallCity_01_4m_grey_F"],
		["Walls - City","Land_WallCity_01_4m_pink_F"],
		["Walls - City","Land_WallCity_01_4m_whiteblue_F"],
		["Walls - City","Land_WallCity_01_4m_yellow_F"],
		["Walls - City","Land_WallCity_01_4m_plain_blue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_grey_F"],
		["Walls - City","Land_WallCity_01_4m_plain_pink_F"],
		["Walls - City","Land_WallCity_01_4m_plain_whiteblue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_yellow_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_blue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_grey_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_pink_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_whiteblue_F"],
		["Walls - City","Land_WallCity_01_4m_plain_dmg_yellow_F"],
		["Walls - City","Land_WallCity_01_8m_blue_F"],
		["Walls - City","Land_WallCity_01_8m_grey_F"],
		["Walls - City","Land_WallCity_01_8m_pink_F"],
		["Walls - City","Land_WallCity_01_8m_whiteblue_F"],
		["Walls - City","Land_WallCity_01_8m_yellow_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_blue_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_grey_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_pink_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_whiteblue_F"],
		["Walls - City","Land_WallCity_01_8m_dmg_yellow_F"],
		["Walls - City","Land_WallCity_01_8m_plain_blue_F"],
		["Walls - City","Land_WallCity_01_8m_plain_grey_F"],
		["Walls - City","Land_WallCity_01_8m_plain_pink_F"],
		["Walls - City","Land_WallCity_01_8m_plain_whiteblue_F"],
		["Walls - City","Land_WallCity_01_8m_plain_yellow_F"],
		["Walls - City","Land_WallCity_01_gate_blue_F"],
		["Walls - City","Land_WallCity_01_gate_grey_F"],
		["Walls - City","Land_WallCity_01_gate_pink_F"],
		["Walls - City","Land_WallCity_01_gate_whiteblue_F"],
		["Walls - City","Land_WallCity_01_gate_yellow_F"],
		["Walls - City","Land_WallCity_01_pillar_blue_F"],
		["Walls - City","Land_WallCity_01_pillar_grey_F"],
		["Walls - City","Land_WallCity_01_pillar_pink_F"],
		["Walls - City","Land_WallCity_01_pillar_whiteblue_F"],
		["Walls - City","Land_WallCity_01_pillar_yellow_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_blue_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_grey_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_pink_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_whiteblue_F"],
		["Walls - City","Land_WallCity_01_pillar_plain_dmg_yellow_F"],
		["Walls - City","Land_ConcreteWall_01_l_gate_closed_F"],
		["Walls - City","Land_ConcreteWall_01_m_gate_closed_F"],
		["Walls - City","Land_NetFence_02_m_gate_v1_closed_F"],
		["Walls - City","Land_NetFence_02_m_gate_v2_closed_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v1_closed_F"],
		["Walls - City","Land_PipeFence_01_m_gate_v2_closed_F"],
		["Walls - Historical","Land_Ancient_Wall_4m_F"],
		["Walls - Historical","Land_Ancient_Wall_8m_F"],
		["Walls - Industrial","Land_Wall_IndCnc_2deco_F"],
		["Walls - Industrial","Land_Wall_IndCnc_4_D_F"],
		["Walls - Industrial","Land_Wall_IndCnc_4_F"],
		["Walls - Industrial","Land_Wall_IndCnc_End_2_F"],
		["Walls - Industrial","Land_Wall_IndCnc_Pole_F"],
		["Walls - Industrial","Land_Wall_Tin_4"],
		["Walls - Industrial","Land_Wall_Tin_4_2"],
		["Walls - Industrial","Land_Wall_Tin_Pole"],
		["Walls - Industrial","Land_TinWall_02_l_4m_F"],
		["Walls - Industrial","Land_TinWall_02_l_8m_F"],
		["Walls - Industrial","Land_TinWall_02_l_pole_F"],
		["Walls - Industrial","Land_WiredFence_01_4m_F"],
		["Walls - Industrial","Land_WiredFence_01_8m_d_F"],
		["Walls - Industrial","Land_WiredFence_01_8m_F"],
		["Walls - Industrial","Land_WiredFence_01_16m_F"],
		["Walls - Industrial","Land_WiredFence_01_gate_F"],
		["Walls - Industrial","Land_WiredFence_01_pole_45_F"],
		["Walls - Industrial","Land_WiredFence_01_pole_F"],
		["Walls - Military","Land_HBarrier_1_F"],
		["Walls - Military","Land_HBarrier_3_F"],
		["Walls - Military","Land_HBarrier_5_F"],
		["Walls - Military","Land_HBarrierBig_F"],
		["Walls - Military","Land_HBarrier_Big_F"],
		["Walls - Military","Land_HBarrierTower_F"],
		["Walls - Military","Land_HBarrierWall_corner_F"],
		["Walls - Military","Land_HBarrierWall_corridor_F"],
		["Walls - Military","Land_HBarrierWall4_F"],
		["Walls - Military","Land_HBarrierWall6_F"],
		["Walls - Military","Land_BarGate_F"],
		["Walls - Military","Land_Mil_WallBig_4m_F"],
		["Walls - Military","Land_Mil_WallBig_Corner_F"],
		["Walls - Military","Land_Mil_WallBig_Gate_F"],
		["Walls - Military","Land_BarGate_01_open_F"],
		["Walls - Military","Land_Mil_WallBig_4m_battered_F"],
		["Walls - Military","Land_Mil_WallBig_corner_battered_F"],
		["Walls - Military","Land_Mil_WallBig_4m_damaged_center_F"],
		["Walls - Military","Land_Mil_WallBig_4m_damaged_left_F"],
		["Walls - Military","Land_Mil_WallBig_4m_damaged_right_F"],
		["Walls - Obstacles","Land_CncBarrier_F"],
		["Walls - Obstacles","Land_CncBarrier_stripes_F"],
		["Walls - Obstacles","Land_CncBarrierMedium_F"],
		["Walls - Obstacles","Land_CncBarrierMedium4_F"],
		["Walls - Obstacles","Land_CncWall1_F"],
		["Walls - Obstacles","Land_CncWall4_F"],
		["Walls - Obstacles","Land_Concrete_SmallWall_4m_F"],
		["Walls - Obstacles","Land_Concrete_SmallWall_8m_F"],
		["Walls - Obstacles","Land_Rampart_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Wall_Long_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Corner_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Prone_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Vault_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Window_F"],
		["Walls - Shoot House","Land_Shoot_House_Panels_Windows_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_Stand_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_Crouch_F"],
		["Walls - Shoot House","Land_Shoot_House_Tunnel_Prone_F"],
		["Walls - Transportation","Land_Crash_barrier_F"],
		["Walls - Transportation","Land_CrashBarrier_01_end_L_F"],
		["Walls - Transportation","Land_CrashBarrier_01_end_R_F"],
		["Walls - Transportation","Land_CrashBarrier_01_4m_F"],
		["Walls - Transportation","Land_CrashBarrier_01_8m_F"],
		["Walls - Transportation","Land_PipeFence_02_s_4m_F"],
		["Walls - Transportation","Land_PipeFence_02_s_4m_noLC_F"],
		["Walls - Transportation","Land_PipeFence_02_s_8m_F"],
		["Walls - Transportation","Land_PipeFence_02_s_8m_noLC_F"],
		["Walls - Transportation","Land_GuardRailing_01_F"],
		["Walls - Village","Land_Mound01_8m_F"],
		["Walls - Village","Land_Mound02_8m_F"],
		["Walls - Village","Land_Slums01_8m"],
		["Walls - Village","Land_Slums01_pole"],
		["Walls - Village","Land_Slums02_4m"],
		["Walls - Village","Land_Slums02_pole"],
		["Walls - Village","Land_Stone_4m_F"],
		["Walls - Village","Land_Stone_8m_F"],
		["Walls - Village","Land_Stone_8mD_F"],
		["Walls - Village","Land_Stone_Gate_F"],
		["Walls - Village","Land_Stone_pillar_F"],
		["Walls - Village","Land_BambooFence_01_s_4m_F"],
		["Walls - Village","Land_BambooFence_01_s_8m_F"],
		["Walls - Village","Land_BambooFence_01_s_d_F"],
		["Walls - Village","Land_BambooFence_01_s_pole_F"],
		["Walls - Village","Land_PoleWall_01_pole_F"],
		["Walls - Village","Land_PoleWall_01_3m_F"],
		["Walls - Village","Land_PoleWall_01_6m_F"],
		["Walls - Village","Land_SlumWall_01_s_2m_F"],
		["Walls - Village","Land_SlumWall_01_s_4m_F"],
		["Walls - Village","Land_StoneWall_01_s_10m_F"],
		["Walls - Village","Land_StoneWall_01_s_d_F"],
		["Walls - Village","Land_TinWall_01_m_4m_v1_F"],
		["Walls - Village","Land_TinWall_01_m_4m_v2_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v1_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v2_F"],
		["Walls - Village","Land_TinWall_01_m_pole_F"],
		["Walls - Village","Land_WoodenWall_01_m_4m_F"],
		["Walls - Village","Land_WoodenWall_01_m_8m_F"],
		["Walls - Village","Land_WoodenWall_01_m_d_F"],
		["Walls - Village","Land_WoodenWall_01_m_pole_F"],
		["Walls - Village","Land_WoodenWall_02_s_2m_F"],
		["Walls - Village","Land_WoodenWall_02_s_4m_F"],
		["Walls - Village","Land_WoodenWall_02_s_8m_F"],
		["Walls - Village","Land_WoodenWall_02_s_d_F"],
		["Walls - Village","Land_WoodenWall_02_s_gate_F"],
		["Walls - Village","Land_WoodenWall_02_s_pole_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v1_closed_F"],
		["Walls - Village","Land_TinWall_01_m_gate_v2_closed_F"],
		["Walls - Village","Land_WoodenWall_02_s_gate_closed_F"]
	];
	BRPVP_buildAdminClasses = BRPVP_buildAdminClasses apply {
		_x params ["_tittle","_cls"];
		if (_cls isEqualType "") then {
			if (_cls find "\" isEqualTo -1) then {
				if (_cls call BRPVP_classExists) then {_x} else {-1};
			} else {
				_x
			};
		} else {
			private _cFound = "";
			{if (_x call BRPVP_classExists) exitWith {_cFound = _x;};} forEach _cls;
			if (_cFound isEqualTo "") then {-1} else {[_tittle,_cFound]};
		};
	};
	BRPVP_buildAdminClasses = BRPVP_buildAdminClasses-[-1];

	BRPVP_specInitMapOpenClose = {
		private _mouse = findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld getMousePosition;
		private _mapPos = findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld [0.5,0.5];
		private _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
		if (visibleMap) then {["open",[0,_scale,_mapPos],_mouse] remoteExecCall ["BRPVP_specMapShow",_this];} else {["close",[0,_scale,_mapPos],_mouse] remoteExecCall ["BRPVP_specMapShow",_this];};
	};
	BRPVP_mapOpenCloseCode = {
		params ["_mapIsOpened","_mapIsForced"];
		private _mouse = findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld getMousePosition;
		private _mapPos = findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld [0.5,0.5];
		private _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
		if (_mapIsOpened) then {
			["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.020},{safeZoneY+0.31},1000000,0,0,3090] call BRPVP_fnc_dynamicText;
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {["open",[0,_scale,_mapPos],_mouse] remoteExecCall ["BRPVP_specMapShow",BRPVP_specOnMeMachinesNoMe];};
		} else {
			_veh = objectParent player;
			if (!isNull _veh && {player isEqualTo driver _veh}) then {
				["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.315},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;
			} else {
				["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.020},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;
			};
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {["close",[0,_scale,_mapPos],_mouse] remoteExecCall ["BRPVP_specMapShow",BRPVP_specOnMeMachinesNoMe];};
		};
	};
	addMissionEventHandler ["Map",{call BRPVP_mapOpenCloseCode;}];

	//EACH FRAME MISSION EH
	BRPVP_draw3DCount = 1;
	BRPVP_drawIcon3D = [];
	BRPVP_friendsIconCache = [];
	BRPVP_changedZoom = false;
	BRPVP_eachFrameBinaryA = true;
	BRPVP_eachFrameBinaryB = true;
	BRPVP_hackBeepLast = 0;
	BRPVP_myCenter = player;
	BRPVP_lastBbLooking = objNull;
	BRPVP_playerLastSafePosBeforeBug = getPosASL player;
	addMissionEventHandler ["EachFrame",{call BRPVP_eachFrameEH;}];
	BRPVP_tempCode4 = {
		private ["_player","_xMeusAmigosObj","_xPveFriends"];
		if (BRPVP_spectateOn) then {
			_player = BRPVP_spectedPlayer;
			_xMeusAmigosObj = BRPVP_specMeusAmigosObj;
			_xPveFriends = BRPVP_specPveFriends;
		} else {
			_player = player;
			_xMeusAmigosObj = BRPVP_meusAmigosObj;
			_xPveFriends = BRPVP_pveFriends;
		};
		private _myGroup = (units group _player)-[_player];
		private _pveBanditObjList = [];
		if (_player getVariable ["brpvp_pve_inside",0] > 0 && _player getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0) then {
			{
				if (_x getVariable ["dd",-1] <= 0 && _x getVariable ["brpvp_pve_inside",0] > 0 && _x getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0) then {
					_pveBanditObjList pushBack _x;
				};
			} forEach BRPVP_pveBanditObjList;
		};
		private _squad = _myGroup-_pveBanditObjList;
		private _trustInMe = _xMeusAmigosObj-(_pveBanditObjList+_squad);
		private _pveFriends = if (_player getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0 && _player getVariable "brpvp_my_flag_state" isNotEqualTo 1) then {
			if (!BRPVP_banditCanSeePvePlayers && _player in BRPVP_pveBanditObjList) then {
				[]
			} else {
				((_xPveFriends apply {if (_x getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0 && (_x getVariable "brpvp_my_flag_state") isNotEqualTo 2) then {_x} else {-1}})-[-1])-(_pveBanditObjList+_squad+_trustInMe)
			};
		} else {
			[]
		};
		if (!BRPVP_inPIconsArea || BRPVP_vePlayers) then {
			[
				BRPVP_myCenter,
				[
					[BRPVP_usePlayerIconBandit,0.15,_pveBanditObjList,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\interface\bandit.paa",[1,1,1,1],[0,0,0],0.65,0.65,0,"",0,0.03],false],
					[BRPVP_usePlayerIconSquad,0.15,_squad,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\squad.paa",[1,1,1,1],[0,0,0],0.65,0.65,0,"",0,0.03],true],
					[BRPVP_usePlayerIconFriends,0.15,_trustInMe,{!isObjectHidden _this && _this getVariable ["sok",false] && _this getVariable ["dd",-1] <= 0},[BRPVP_missionRoot+"BRP_imagens\icones3d\amigo32.paa",[1,1,0.2,1],[0,0,0],0.65,0.65,0,"",0,0.03],true],
					[BRPVP_usePlayerIconPve,0.15,_pveFriends,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\interface\pve_friends.paa",[1,1,1,1],[0,0,0],0.65,0.65,0,"",0,0.03],false],
					[!BRPVP_usePlayerIconBandit,0,_pveBanditObjList,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\player_off.paa",[0.1,0.37,0.51,1],[0,0,0],0.2,0.2,0,"xOff",0,0.03],false],
					[!BRPVP_usePlayerIconSquad,0,_squad,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\player_off_squad.paa",[1,1,1,1],[0,0,0],0.2,0.2,0,"xOff",0,0.03],false],
					[!BRPVP_usePlayerIconFriends,0,_trustInMe,{!isObjectHidden _this && _this getVariable ["sok",false] && _this getVariable ["dd",-1] <= 0},[BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,1,0.2,1],[0,0,0],0.2,0.2,0,"xOff",0,0.03],false],
					[!BRPVP_usePlayerIconPve,0,_pveFriends,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,1,1,1],[0,0,0],0.2,0.2,0,"xOff",0,0.03],false]
				]
			] call BRPVP_groupArrayByDistanceMultiple3D;
		};

		//DRAW AMIGOS MARKS
		{
			_x params ["_q","_dist","_name","_pos","_u"];
			if (BRPVP_posicaoFora distance2D _pos > 100) then {
				private ["_img","_size"];
				if (_u isEqualTo BRPVP_myCenter) then {
					_img = BRPVP_missionRoot+"BRP_imagens\icones3d\marca_dest.paa";
					_size = 0.625;
				} else {
					_img = BRPVP_missionRoot+"BRP_imagens\icones3d\marca_dest_amigo.paa";
					_size = 0.525;
				};
				drawIcon3D [_img,[1,1,1,1],_pos,_size,_size,0,"",0,0.03];
				drawIcon3D ["",[0,0.8,0,1],_pos,_size,_size,0,[_q,_name,_dist] call BRPVP_txtIconCreate,0,0.03];
			};
		} forEach ([4,BRPVP_playersMarksEnabled,0.15,BRPVP_myCenter,{true},{_this getVariable ["pd",BRPVP_posicaoFora]}] call BRPVP_groupArrayByDistance);
	};
	BRPVP_tempCode7 = {
		if (BRPVP_myPlayerOrSpecOrDrone isKindOf "CaManBase") then {
			_fm = getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75;
			{
				_np = _x;
				_eyePos = eyepos BRPVP_myPlayerOrSpecOrDrone;
				_eyePosNp = eyepos _np;
				_visible = [vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",vehicle _np] checkVisibility [_eyePos,_eyePosNp] >= 0.5;
				if (_visible) then {
					_onTheHead = if (_np in BRPVP_newersDiscovered) then {
						true
					} else {
						_v1 = _eyePosNp vectorDiff _eyePos;
						_v2 = getCameraViewDirection BRPVP_myPlayerOrSpecOrDrone;
						_v3 = _v1 vectorCrossproduct [0,0,1];
						_v4 = _v3 vectorCrossProduct _v1;
						_v4 = vectorNormalized _v4 vectorMultiply 2;
						_v5 = (_eyePosNp vectorAdd _v4) vectorDiff _eyePos;
						_a1 = acos (_v5 vectorCos _v1);
						_a2 = acos (_v2 vectorCos _v1);
						_a2 <= _a1
					};
					if (_onTheHead) then {
						private _d = BRPVP_myPlayerOrSpecOrDrone distance _np;
						private _pos = _np modelToWorldVisual (_np selectionPosition "head");
						if (_np in BRPVP_newerPlayers) then {
							_img = if (_np getVariable ["brpvp_is_newer",false]) then {
								if (_np getVariable ["cmb",false]) then {BRPVP_missionRoot+"BRP_imagens\novato_combat.paa"} else {BRPVP_missionRoot+"BRP_imagens\novato.paa"};
							} else {
								BRPVP_missionRoot+"BRP_imagens\icones3d\working.paa"
							};
							drawIcon3D [_img,[1,1,1,0.65],_pos vectorAdd [0,0,0.50+_d*0.035*_fm],0.7,0.7,0,_np getVariable ["nm","no_name"],0,0.03];
							if (!BRPVP_spectateOn) then {
								if !(_np in BRPVP_newersDiscovered) then {
									BRPVP_newersDiscovered pushBack _np;
									_np setVariable ["brpvp_n_discovered_time",time];
								};
							};
						} else {
							drawIcon3D ["",[1,1,1,0.65],_pos vectorAdd [0,0,0.50+_d*0.035*_fm],0.625,0.625,0,_np getVariable ["nm","no_name"],0,0.03];
						};
					};
				};
			} forEach BRPVP_nearIdentifiedPlayers;
		} else {
			private _eyePos = if (BRPVP_eachFrameBinaryA) then {BRPVP_myPlayerOrSpecOrDrone modelToWorldWorld (BRPVP_myPlayerOrSpecOrDrone selectionPosition "PiP0_pos")} else {BRPVP_myPlayerOrSpecOrDrone modelToWorldWorld (BRPVP_myPlayerOrSpecOrDrone selectionPosition "PiP1_pos")};
			private _end = if (BRPVP_eachFrameBinaryA) then {BRPVP_myPlayerOrSpecOrDrone modelToWorldWorld (BRPVP_myPlayerOrSpecOrDrone selectionPosition "PiP0_dir")} else {BRPVP_myPlayerOrSpecOrDrone modelToWorldWorld (BRPVP_myPlayerOrSpecOrDrone selectionPosition "PiP1_dir")};
			private _fm = getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75;
			if (_eyePos isNotEqualTo [0,0,0]) then {
				{
					_np = _x;
					_eyePosNp = eyepos _np;
					_visible = [vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",vehicle _np] checkVisibility [_eyePos,_eyePosNp] >= 0.5;
					if (_visible) then {
						_onTheHead = if (_np in BRPVP_newersDiscovered) then {
							true
						} else {
							_v1 = _eyePosNp vectorDiff _eyePos;
							_v2 = _eyePos vectorFromTo _end;
							_v3 = _v1 vectorCrossproduct [0,0,1];
							_v4 = _v3 vectorCrossProduct _v1;
							_v4 = vectorNormalized _v4 vectorMultiply 2;
							_v5 = (_eyePosNp vectorAdd _v4) vectorDiff _eyePos;
							_a1 = acos (_v5 vectorCos _v1);
							_a2 = acos (_v2 vectorCos _v1);
							_a2 <= _a1
						};
						if (_onTheHead) then {
							private _d = BRPVP_myPlayerOrSpecOrDrone distance _np;
							private _pos = _np modelToWorldVisual (_np selectionPosition "head");
							if (_np in BRPVP_newerPlayers) then {
								_img = if (_np getVariable ["brpvp_is_newer",false]) then {
									if (_np getVariable ["cmb",false]) then {BRPVP_missionRoot+"BRP_imagens\novato_combat.paa"} else {BRPVP_missionRoot+"BRP_imagens\novato.paa"};
								} else {
									BRPVP_missionRoot+"BRP_imagens\icones3d\working.paa"
								};
								drawIcon3D [_img,[1,1,1,0.65],_pos vectorAdd [0,0,0.50+_d*0.035*_fm],0.7,0.7,0,_np getVariable ["nm","no_name"],0,0.03];
								if (!BRPVP_spectateOn) then {
									if !(_np in BRPVP_newersDiscovered) then {
										BRPVP_newersDiscovered pushBack _np;
										_np setVariable ["brpvp_n_discovered_time",time];
									};
								};
							} else {
								drawIcon3D ["",[1,1,1,0.65],_pos vectorAdd [0,0,0.50+_d*0.035*_fm],0.625,0.625,0,_np getVariable ["nm","no_name"],0,0.03];
							};
						};
					};
				} forEach BRPVP_nearIdentifiedPlayers;
			};
		};
	};
	BRPVP_heliEventDirection = {
		if (BRPVP_heliEventCenter isEqualTo []) then {
			private _arrow = player getVariable ["brpvp_heve_arrow",objNull];
			if (!isNull _arrow) then {
				player setVariable ["brpvp_heve_arrow",objNull];
				deleteVehicle _arrow;
			};
		} else {
			_veh = objectParent player;
			if (!isNull _veh) then {
				_dist = _veh distance2D BRPVP_heliEventCenter;
				if (_dist > 1000) then {
					private _arrow = player getVariable ["brpvp_heve_arrow",objNull];
					if (isNull _arrow) then {
						_arrow = createSimpleObject ["Sign_Arrow_Direction_F",[0,0,0],true];
						player setVariable ["brpvp_heve_arrow",_arrow];
						player setVariable ["brpvp_heve_limit",time+30];
					};
					private _pFront = _veh modelToWorldVisual [0,10,-1];
					_arrow setPosASL AGLToASL _pFront;
					_arrow setDir ([player,BRPVP_heliEventCenter] call BIS_fnc_dirTo);
					if (time > player getVariable "brpvp_heve_limit") then {_veh setDamage 1;};
				} else {
					private _arrow = player getVariable ["brpvp_heve_arrow",objNull];
					if (!isNull _arrow) then {
						player setVariable ["brpvp_heve_arrow",objNull];
						deleteVehicle _arrow;
					};
				};
				for "_i" from 1 to 4 do {
					private _a = _i*(360/4);
					private _pos = [(BRPVP_heliEventCenter select 0)+10*sin _a,(BRPVP_heliEventCenter select 1)+10*cos _a,0];
					drawLine3D [_pos,_pos vectorAdd [0,0,1000],[1,0,0,1]];
				};
			};
		};
	};
	BRPVP_xrayCodeAngles = [];
	for "_a" from 0 to 315 step 45 do {BRPVP_xrayCodeAngles pushBack [sin _a,cos _a,0];};
	BRPVP_xrayCode = {
		if (isNull BRPVP_xrayObj) then {
			private _asl = getPosASL BRPVP_myPlayerOrSpec;
			private _eye = eyePos BRPVP_myPlayerOrSpec;

			//CHECK VELOCITY FRONT
			private _velObjs = [];
			private _vec = (vectorNormalized _velocity) vectorMultiply 0.75;
			private _dh = (_eye select 2)-(_asl select 2);
			private _step = [-0.6,0.6] select (_dh >= 0);
			for "_i" from 0 to _dh step _step do {
				private _tPos = _asl vectorAdd [0,0,_i];
				{
					private _lisFront = lineIntersectsSurfaces [_tPos,_tPos vectorAdd _x,vehicle BRPVP_myPlayerOrSpec,objNull,true,1,"GEOM","NONE"];
					private _objFront = [_lisFront select 0 select 2,objNull] select (_lisFront isEqualTo []);
					_velObjs pushBackUnique _objFront;
				} forEach BRPVP_xrayCodeAngles;
			};
			_velObjs = _velObjs-[objNull];

			//CHECK BELLOW
			private _objBellow1 = lineIntersectsSurfaces [_asl vectorAdd [0,0,1],_asl vectorAdd [0,0,-0.5],vehicle BRPVP_myPlayerOrSpec,objNull,true,1,"GEOM","NONE"];
			private _objBellow2 = lineIntersectsSurfaces [_eye vectorAdd [0,0,0],_eye vectorAdd [0,0,-1.0],vehicle BRPVP_myPlayerOrSpec,objNull,true,1,"GEOM","NONE"];
			private _objsBellow = ((_objBellow1+_objBellow2) apply {_x select 2})-[objNull];
			BRPVP_xrayObj = cursorObject;
			if (!isNull BRPVP_xrayObj && !(BRPVP_xrayObj isKindOf "CaManBase") && !(BRPVP_xrayObj isKindOf "FlagCarrier") && !(BRPVP_xrayObj in (_velObjs+_objsBellow)) && time-BRPVP_shotTime > 1) then {
				BRPVP_xrayObj hideObject true;
			} else {
				BRPVP_xrayObj = objNull;
			};
		} else {
			BRPVP_xrayObj hideObject false;
			BRPVP_xrayObj = objNull;
		};
	};
	BRPVP_fixBigShipsWalkBugMark = objNull;
	BRPVP_fixBigShipsWalkBug = {
		private _pw = getPosWorld player vectorAdd [0,0,1];
		private _lisPw = lineIntersectsSurfaces [_pw,_pw vectorAdd [0,0,-6],player,objNull,true,1,"GEOM","NONE"];
		private _onShip = count _lisPw > 0 && {typeOf (_lisPw select 0 select 2) in BRPVP_aircraftClasses};
		if (_onShip) then {
			private _dir = getDir player;
			private _front = [(_pw select 0)+6.25*sin _dir,(_pw select 1)+6.25*cos _dir,_pw select 2];
			for "_i" from 0 to 25 do {
				private _pos = (_pw vectorMultiply (20-_i)) vectorAdd (_front vectorMultiply _i) vectorMultiply (1/20);
				private _lis = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,-15],objNull,objNull,true,1,"GEOM","NONE"];
				if (_lis isEqualTo []) exitWith {
					if (isNull BRPVP_fixBigShipsWalkBugMark) then {
						BRPVP_fixBigShipsWalkBugMark = createSimpleObject ["Sign_Arrow_Green_F",[0,0,0],true];
						BRPVP_fixBigShipsWalkBugMark setPosASL (_pos vectorAdd [0,0,-1]);
						["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\fall_danger.paa'/>",0,0.25,1,0,0,91734] call BRPVP_fnc_dynamicText;
					} else {
						BRPVP_fixBigShipsWalkBugMark setPosASL (_pos vectorAdd [0,0,-1]);
					};
				};
				if (_i isEqualTo 20) then {if (!isNull BRPVP_fixBigShipsWalkBugMark) then {deleteVehicle BRPVP_fixBigShipsWalkBugMark;};};
			};			
		} else {
			if (!isNull BRPVP_fixBigShipsWalkBugMark) then {deleteVehicle BRPVP_fixBigShipsWalkBugMark;};
		};
	};
	{_x setFeatureType 0;} forEach nearestObjects [BRPVP_centroMapa,["All"],30000,true];
	{_x setFeatureType 0;} forEach allSimpleObjects [];
	BRPVP_nf500List = [];
	BRPVP_nfTime = 0;
	BRPVP_nfTimePos = 0;
	BRPVP_nfCountFlag = 0;
	BRPVP_nfCode = {
		private _tickTime = diag_tickTime;
		if (_tickTime-BRPVP_nfTime > 1) then {
			BRPVP_nfTime = _tickTime;
			BRPVP_nfBase = [];
			private _cFlag = 0;
			private _cAtf = 0;
			private _fCalc = false;
			if (viewDistance > 2500) then {
				private _posNow = getPosWorld player;
				private _lastPos = player getVariable ["brpvp_nf_lp",BRPVP_posicaoFora];
				private _allFlags = [];
				private _camPlayer = getCameraViewDirection player;
				if (_posNow distance2D _lastPos > 100 || _tickTime-BRPVP_nfTimePos >= 15 || BRPVP_nfCountFlag > 1) then {
					_fCalc = true;
					BRPVP_nfTimePos = _tickTime;
					player setVariable ["brpvp_nf_lp",_posNow];
					_allFlags = (BRPVP_allFlags-[objNull]) apply {
						private _dist = _x distance2D BRPVP_myPlayerOrUAV;
						[round (_dist/500),acos (getPosWorld _x vectorDiff getPosWorld BRPVP_myPlayerOrUAV vectorCos _camPlayer),[_dist,_x getVariable ["brpvp_flag_radius",0],_x]]
					};
					_allFlags sort true;
					player setVariable ["brpvp_nf_allflags",_allFlags];
				} else {
					_allFlags = player getVariable "brpvp_nf_allflags";
				};
				BRPVP_nfCountFlag = 0;
				{
					_x params ["_distStep","_angle","_data"];
					_data params ["_dist","_fRad","_flag"];
					if (_dist < (viewDistance+750) && _dist < 15000 && {_dist > (2500-_fRad) && !isNull _flag}) then {
						BRPVP_nfCountFlag = BRPVP_nfCountFlag+1;
						private _fvOk = if (_angle >= 65) then {
							false
						} else {
							private _fPos = getPosWorld _flag;
							private _cVec = vectorNormalized (_posNow vectorDiff _fPos vectorCrossProduct [0,0,1]) vectorMultiply (_fRad+200);
							private _sides = [_fPos vectorAdd _cVec,_fPos vectorAdd (_cVec vectorMultiply -1)] apply {worldToScreen _x+[-1000,-1000]};
							{_x select 0 > safeZoneX && _x select 0 < safezoneX+safezoneW && _x select 1 > safezoneY && _x select 1 < safezoneY+safezoneH} count _sides > 0;
						};
						if (_fvOk) then {
							private _aMin = 45+((((_dist-2500) max 0)/5000) min 1)*15;
							private _atf = [player,_flag] call BIS_fnc_dirTo;
							private _lastAtf = _flag getVariable ["brpvp_nf_atf",(_atf+180) mod 360];
							private _atfChanged = [_atf,_lastAtf] call BRPVP_angleBetween > 15;
							private _vtf = [sin _atf,cos _atf,0];
							private _base = [];
							if (_atfChanged) then {_cAtf = _cAtf+1;_flag setVariable ["brpvp_nf_atf",_atf];};
							_cFlag = _cFlag+1;
							_varBase = _flag getVariable ["brpvp_nf_base",[-35,[]]];
							if (_tickTime-(_varBase select 0) >= 60) then {
								{
									if (_x getVariable ["id_bd",-1] > -1 && {_x isKindOf "Building"}) then {
										private _so = sizeOf typeOf _x;
										private _fdRatio = ((_x distance2D _flag) max 25)/_fRad;
										if (_so > 45 && _fdRatio > 0.25) then {
											private _fRadX = _fRad+5;
											private _lis = lineIntersectsSurfaces [getPosWorld _x,getPosWorld _x vectorAdd [_fRadX*sin _ori,_fRadX*cos _ori,0],_x,objNull,true,1,"GEOM","NONE"];
											private _okVis = if (_lis isEqualTo []) then {true} else {private _objFront = _lis select 0 select 2;if (isNull _objFront) then {true} else {private _objFrontSo = sizeOf typeOf _objFront;_objFrontSo/_so < 0.65 || _objFront distance _x < _so/3};};
											if (_okVis) then {
												private _ori = [_flag,_x] call BIS_fnc_dirTo;
												_base pushBack [[sin _ori,cos _ori,0],_x];
											};
										};
									};
								} forEach nearestObjects [_flag,[],_fRad,true];
								_flag setVariable ["brpvp_nf_base",[_tickTime-2.5+random 5,_base]];
								_base = _base apply {[ceil acos (_x select 0 vectorCos _vtf),_x select 1]};
								_base sort false;
								_base = (_base apply {[objNull,_x select 1] select (_x select 0 > _aMin);})-[objNull];
								_flag setVariable ["brpvp_nf_base_calc",_base];
								BRPVP_nfBase append _base;
							} else {
								if (_atfChanged) then {
									_base = _varBase select 1 apply {[ceil acos (_x select 0 vectorCos _vtf),_x select 1]};
									_base sort false;
									_base = (_base apply {[objNull,_x select 1] select (_x select 0 > _aMin);})-[objNull];
									_flag setVariable ["brpvp_nf_base_calc",_base];
									BRPVP_nfBase append _base;
								} else {
									_base = _flag getVariable "brpvp_nf_base_calc";
									BRPVP_nfBase append _base;
								};
							};
						};
					};
					if (count BRPVP_nfBase >= 195) exitWith {BRPVP_nfBase = BRPVP_nfBase select [0,195];};
				} forEach _allFlags;
			};
			if (BRPVP_nfBase isNotEqualTo BRPVP_nf500List) then {
				{_x setFeatureType 0;} forEach (BRPVP_nf500List-BRPVP_nfBase); //OUT
				{_x setFeatureType 2;} forEach (BRPVP_nfBase-BRPVP_nf500List); //NEW
				BRPVP_nf500List = +BRPVP_nfBase;
			};
		};
	};
	BRPVP_paraFixLOA = "";
	BRPVP_paraFix = {
		private _aniP = animationState player;
		if (_aniP find "halofreefall_" isEqualTo 0) then {
			if (isNull objectParent player && isTouchingGround player) then {[player,BRPVP_paraFixLOA] remoteExecCall ["switchMove",0];};
		} else {
			if (isNull objectParent player) then {BRPVP_paraFixLOA = _aniP;} else {BRPVP_paraFixLOA = "";};
		};
	};
	BRPVP_ppathMaxInside = [];
	BRPVP_ppathLoopCode = {
		if (BRPVP_ppathIsOn) then {
			if (BRPVP_ppathBoo) then {
				if (str BRPVP_playerBuilding isNotEqualTo BRPVP_ppathLastHouse) then {
					private _nbp = ASLToAGL getPosASL player vectorAdd [0,0,0.5];

					//ADD MAX INSIDE
					private _maxInside = false;
					if (isNull BRPVP_playerBuilding) then {
						private _lp = BRPVP_ppathPath select (count BRPVP_ppathPath-1) select 0;
						if (_lp distance2D BRPVP_ppathMaxInside > 1.5) then {
							private _h = (BRPVP_ppathMaxInside select 2) max 0 min BRPVP_ppathMaxHigh;
							BRPVP_ppathPath pushBack [BRPVP_ppathMaxInside,[(1000-_h)/1000,0,_h/1000,1],false];
							_maxInside = true;
						};
					};

					//CHECK IF NEAR LASTS HOUSE POINTS
					if (!_maxInside) then {
						private _if = count BRPVP_ppathPath-1;
						private _pl = BRPVP_ppathPath select _if select 0;
						if (_nbp distance _pl < 5) then {BRPVP_ppathPath deleteAt _if;};
					};

					private _h = (_nbp select 2) max 0 min BRPVP_ppathMaxHigh;
					BRPVP_ppathPath pushBack [_nbp,[(1000-_h)/1000,0,_h/1000,1],false];
					BRPVP_ppathRedundantCount = 0;
					BRPVP_ppathLastHouse = str BRPVP_playerBuilding;
					BRPVP_ppathMaxInside = _nbp;
				} else {
					private _lp = BRPVP_ppathPath select (count BRPVP_ppathPath-1) select 0;
					private _np = ASLToAGL getPosASL player vectorAdd [0,0,0.5];
					private _dist = _np distance _lp;
					if (!isNull BRPVP_playerBuilding) then {
						private _lp = BRPVP_ppathPath select (count BRPVP_ppathPath-1) select 0;
						private _np = ASLToAGL getPosASL player vectorAdd [0,0,0.5];
						private _dist = _np distance2D _lp;
						if (_dist > BRPVP_ppathMaxInside distance2D _lp && _dist > 1.5) then {BRPVP_ppathMaxInside = _np;};
					} else {
						if (_dist > BRPVP_ppathDeltaPos) then {
							private _h = (_np select 2) max 0 min BRPVP_ppathMaxHigh;
							BRPVP_ppathPath pushBack [_np,[(1000-_h)/1000,0,_h/1000,1],true];
							
							//REMOVE BY ANGLE
							private _cm = count BRPVP_ppathPath;
							if (_cm >= 3) then {
								private _p1 = BRPVP_ppathPath select (_cm-2) select 0;
								private _p2 = BRPVP_ppathPath select (_cm-3) select 0;
								private _isLowAngle = acos ((_np vectorDiff _p1) vectorCos (_np vectorDiff _p2)) < BRPVP_ppathIgAngle;
								private _canDel = BRPVP_ppathPath select (_cm-2) select 2;
								if (_isLowAngle && BRPVP_ppathRedundantCount < BRPVP_ppathRedundantLimit && _canDel) then {
									BRPVP_ppathPath deleteAt (_cm-2);
									BRPVP_ppathRedundantCount = BRPVP_ppathRedundantCount+1;
								} else {
									BRPVP_ppathRedundantCount = 0;
								};
							} else {
								BRPVP_ppathRedundantCount = 0;
							};
							
							//REMOVE BY TWIST
							private _cm = count BRPVP_ppathPath;
							if (_cm >= 3) then {
								private _p1 = BRPVP_ppathPath select (_cm-2) select 0;
								private _p2 = BRPVP_ppathPath select (_cm-3) select 0;
								private _valid = _p2 distance _p1 < BRPVP_ppathDeltaPos*1.5;
								private _isNear = _np distance _p2 < BRPVP_ppathDeltaPos;
								private _canDel = BRPVP_ppathPath select (_cm-2) select 2;
								if (_valid && _isNear && _canDel) then {BRPVP_ppathPath deleteAt (_cm-2);};
							};
							
							BRPVP_ppathMaxInside = [];
						};
					};
				};
				private _cMsg = count BRPVP_ppathPath;
				private _cmod = _cMsg mod 250;
				if (_cMsg > BRPVP_ppathLastCountMsg && _cmod isEqualTo 0) then {
					private _y = if (BRPVP_menuExtraLigado) then {0.4} else {0};
					"achou_loot" call BRPVP_playSound;
					["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\path.paa'/><br/>"+str (round (100*_cMsg/BRPVP_ppathSize) min 100)+"%",0,_y,1.5,0,0,467] call BRPVP_fnc_dynamicText;
					BRPVP_ppathLastCountMsg = _cMsg;
				};
			};
			BRPVP_ppathBoo = !BRPVP_ppathBoo;
			if (BRPVP_ppathShow3D) then {
				private _if = count BRPVP_ppathPath-1;
				for "_i1" from ((_if-(BRPVP_ppathSize-1)) max 0) to (_if-1) do {
					drawLine3D [BRPVP_ppathPath select _i1 select 0,BRPVP_ppathPath select (_i1+1) select 0,BRPVP_ppathPath select _i1 select 1];
				};
				drawLine3D [BRPVP_ppathPath select _if select 0,ASLToAGL getPosASL player vectorAdd [0,0,0.5],BRPVP_ppathPath select _if select 1];
			};
		};
	};
	BRPVP_sixthSenseCodeShow = {
		if (BRPVP_vePlayersSixthSense) then {
			private _pFov = getObjectFov BRPVP_myPlayerOrSpecOrDrone;
			_pFov = [_pFov,0.75] select (_pFov isEqualTo 0);
			{
				private _d = (_x distance positionCameraToWorld [0,0,0])^0.975 max 5;
				private _alpha = [1-(1-_d/10)*0.9,1] select (_d > 10);
				if (_x getVariable ["ifz",-1] isNotEqualTo -1) then {
					if (lifeState _x in ["INCAPACITATED","DEAD"]) then {
						drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_zed_dead.paa",[0,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
					} else {
						if (_x getVariable ["jpg",false]) then {
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_zed_jump.paa",[0,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(10/_d)/_pFov,(20/_d)/_pFov,0,""];
						} else {
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_zed.paa",[0,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(10/_d)/_pFov,(20/_d)/_pFov,0,""];
						};
					};
				} else {
					private _rdt = ["_180",""] select (_x getRelDir BRPVP_myPlayerOrSpecOrDrone <= 180);
					if (lifeState _x in ["INCAPACITATED","DEAD"]) then {
						drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_dead.paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
					} else {
						if (stance _x isEqualTo "STAND") then {
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
						} else {
							if (stance _x isEqualTo "CROUCH") then {
								drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_knee"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
							} else {
								if (stance _x isEqualTo "PRONE") then {
									drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_prone"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
								} else {
									drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
								};
							};
						};
					};
				};
			} forEach BRPVP_sixthSenseObjectsFound;
			{
				private _d = (_x distance positionCameraToWorld [0,0,0])^0.975 max 5;
				private _alpha = [1-(1-_d/10)*0.9,1] select (_d > 10);
				private _rdt = ["_180",""] select (_x getRelDir BRPVP_myPlayerOrSpecOrDrone <= 180);
				if (lifeState _x in ["INCAPACITATED","DEAD"]) then {
					drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_dead.paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
				} else {
					if (stance _x isEqualTo "STAND") then {
						drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
					} else {
						if (stance _x isEqualTo "CROUCH") then {
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_knee"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
						} else {
							if (stance _x isEqualTo "PRONE") then {
								drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_prone"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
							} else {
								drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
							};
						};
					};
				};
			} forEach BRPVP_sixthSenseObjectsFoundPlayer;
		} else {
			private ["_sixthSensePower","_sixthSensePowerPlayer"];
			private _pFov = getObjectFov BRPVP_myPlayerOrSpecOrDrone;
			if (_pFov isEqualTo 0) then {_pFov = 0.75;};
			if (BRPVP_spectateOn) then {
				_sixthSensePower = BRPVP_sixthSensePowerSpec;
				_sixthSensePowerPlayer = BRPVP_sixthSensePowerPlayerSpec;
			} else {
				_sixthSensePower = BRPVP_sixthSensePower;
				_sixthSensePowerPlayer = BRPVP_sixthSensePowerPlayer;
			};
			{
				if (random 1 <= _sixthSensePower*100/(diag_fps min 100 max 20)) then {
					private _d = (_x distance positionCameraToWorld [0,0,0])^0.95 max 5;
					private _alpha = [1-(1-_d/10)*0.9,1] select (_d > 10);
					if (_x getVariable ["ifz",-1] isNotEqualTo -1 && _sixthSensePower > 0.2) then {
						if (lifeState _x in ["INCAPACITATED","DEAD"]) then {
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_zed_dead.paa",[0,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
						} else {
							if (_x getVariable ["jpg",false]) then {
								drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_zed_jump.paa",[0,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(10/_d)/_pFov,(20/_d)/_pFov,0,""];
							} else {
								drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_zed.paa",[0,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(10/_d)/_pFov,(20/_d)/_pFov,0,""];
							};
						};
					} else {
						private _rdt = ["_180",""] select (_x getRelDir BRPVP_myPlayerOrSpecOrDrone <= 180);
						if (lifeState _x in ["INCAPACITATED","DEAD"]) then {
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_dead.paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
						} else {
							if (stance _x isEqualTo "STAND") then {
								drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
							} else {
								if (stance _x isEqualTo "CROUCH") then {
									drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_knee"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
								} else {
									if (stance _x isEqualTo "PRONE") then {
										drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_prone"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
									} else {
										drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,1,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
									};
								};
							};
						};
					};
				};
			} forEach BRPVP_sixthSenseObjectsFound;
			{
				if (random 1 <= _sixthSensePowerPlayer*100/(diag_fps min 100 max 20)) then {
					private _d = (_x distance positionCameraToWorld [0,0,0])^0.95 max 5;
					private _alpha = [1-(1-_d/10)*0.9,1] select (_d > 10);
					private _rdt = ["_180",""] select (_x getRelDir BRPVP_myPlayerOrSpecOrDrone <= 180);
					if (lifeState _x in ["INCAPACITATED","DEAD"]) then {
						drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_dead.paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
					} else {
						if (stance _x isEqualTo "STAND") then {
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
						} else {
							if (stance _x isEqualTo "CROUCH") then {
								drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_knee"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
							} else {
								if (stance _x isEqualTo "PRONE") then {
									drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon_prone"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
								} else {
									drawIcon3D [BRPVP_missionRoot+"BRP_imagens\ai_sixthsense_icon"+_rdt+".paa",[1,0,0,_alpha],_x modelToWorldVisual [0,0,0.8],(20/_d)/_pFov,(20/_d)/_pFov,0,""];
								};
							};
						};
					};
				};
			} forEach BRPVP_sixthSenseObjectsFoundPlayer;
		};
	};
	BRPVP_onMeTurretIconsTime = time;
	BRPVP_mapWasOn = false;
	BRPVP_gpsWasOn = false;
	BRPVP_zoomRunning = false;
	BRPVP_eachFrameEH = {
		if (BRPVP_mapWasOn && !visibleMap) then {
			[] call BRPVP_updateMapIconsRemove;
			BRPVP_mapWasOn = false;
		};
		if (!BRPVP_mapWasOn && visibleMap) then {
			[] call BRPVP_updateMapIconsAdd;
			BRPVP_mapDrawTime = 0;
			BRPVP_mapWasOn = true;
		};
		if (BRPVP_gpsWasOn && !visibleGps) then {
			[] call BRPVP_updateMapIconsRemove;
			BRPVP_gpsWasOn = false;
		};
		if (!BRPVP_gpsWasOn && visibleGps) then {
			[] call BRPVP_updateMapIconsAdd;
			BRPVP_mapDrawTime = 0;
			BRPVP_gpsWasOn = true;
		};
		if (!visibleMap) then {
			if (BRPVP_draw3DCount isEqualTo 8) then {
				BRPVP_drawIcon3D = [];

				//SETAS PARA AMIGOS
				{[_x,_x getVariable ["nm","no_name"]] call BRPVP_drawSetas;} forEach BRPVP_playersMarksEnabled;
			};
			{drawIcon3D _x;} forEach BRPVP_drawIcon3D;
			if (BRPVP_draw3DCount isEqualTo 8) then {BRPVP_draw3DCount = 1;} else {BRPVP_draw3DCount = BRPVP_draw3DCount+1;};

			//FOV & ANTI ZOOM
			_fov = player getVariable "fov";
			_fovNew = 0.75/(if (getObjectFov player isEqualTo 0) then {0.75} else {getObjectFov player});
			_antiZoom = 1/_fovNew;
			if (!isNull (player getVariable "veh")) then {_fovNew = 1;};
			if (abs((_fovNew-_fov)/_fov) > 0.001) then {
				player setVariable ["fov",_fovNew,false];
				BRPVP_changedZoom = true;
			} else {
				if (BRPVP_changedZoom) then {
					player setVariable ["fov",_fovNew,true];
					call BRPVP_nearIdentifiedPlayersLoop;
					BRPVP_changedZoom = false;
				};
			};

			//GANCHO DESVIRA VEICULO
			{
				_pos = (_x select 0) vectorAdd [0,0,1];
				_dist = player distance _pos;
				if (_dist < 2500) then {
					_size = (40/_dist min 2)*(_x select 1);
					drawIcon3D [BRPVP_missionRoot+"BRP_imagens\icones3d\gancho.paa",[1,1,1,1],_pos,2*_size,_size,0,""];
				};
			} forEach BRPVP_ganchoDesvira;

			//TOW VEHICLE 3D ICON
			{
				if (!isNull _x) then {
					_posTowVeh = (ASLToAGL (getPosASLVisual _x)) vectorAdd [0,0,1.5];
					_dist = player distance _x;
					_div = 1;
					_decimal = 1;
					_unid = "m";
					if (_dist > 1000) then {
						_div = 1000;
						_decimal = 10;
						_unid = "km";
					};
					drawIcon3D ["",[1,0.5,1,1],_posTowVeh,0,0,0,format [localize "str_tow_land_tow_bob",str (round (_decimal*_dist/_div)/_decimal)+" "+_unid]];
				};
			} forEach BRPVP_landVehicleOnTow;

			call BRPVP_tempCode4;

			//3D ICON FOR IDENTIFIED NEAR PLAYERS
			call BRPVP_tempCode7;

			//BOMB MISSION
			{
				if (!isObjectHidden _x) then {
					_top = _x getVariable ["brpvp_explode_icon",[]];
					_smult = _x getVariable ["brpvp_explode_icon_smult",1];
					if (_top isNotEqualTo []) then {
						_lis = lineIntersectsSurfaces [AGLToASL _top,eyePos BRPVP_myPlayerOrSpecOrDrone,BRPVP_myPlayerOrSpecOrDrone,objNull];
						_dist = _top distance BRPVP_myPlayerOrSpecOrDrone;
						if (_lis isEqualTo [] && _dist < 1200) then {
							_size = if (_dist < 500) then {0.8+1.7*(500-_dist)/500} else {0.8};
							_size = _size*_smult;
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\mission\explosion.paa",[1,1,1,1],_top,_size,_size,0,"",0,0.0325];
						};
					};
				};
			} forEach (BRPVP_bombMissionObjs+BRPVP_c4ToExplode);

			//DRAW BUS DESTINE
			if !(BRPVP_busDestine isEqualTo []) then {
				_txt = str round (player distance BRPVP_busDestine)+" m";
				drawIcon3D [BRPVP_missionRoot+"BRP_imagens\interface\bus_service.paa",[1,1,1,1],BRPVP_busDestine,0.8,0.8,0,_txt];
			};

			//GOOD PETER (ANTI-LAZARUS) ICON
			{
				private _dist = BRPVP_myPlayerOrSpecOrDrone distance _x;
				if (alive _x && !isObjectHidden _x && _dist < 1500) then {
					private _safeLimit = (_x getVariable ["brpvp_ab_size",BRPVP_peterAtomicBombInit])*500;
					private _danger = _dist < _safeLimit;
					private _color = if (_danger) then {private _w = (1.25+sin(time*360))/2.25;[1,_w,_w,1]} else {[1,1,1,1]};
					private _bombNear = if (_x getVariable "brpvp_bomb_near") then {private _w = (1.25+sin(time*1440))/2.25;[1,_w,_w,1]} else {[1,1,1,1]};
					private _imgSize = if (_x getVariable "brpvp_bomb_near") then {0.85+sin(time*1800)*(0.2+sin(time*900)*0.15)} else {0.85};
					private _lifeImg = _x getVariable "brpvp_peter_gdam";
					drawIcon3D [BRPVP_missionRoot+"BRP_imagens\"+_lifeImg,_bombNear,(_x modelToWorldVisual (_x selectionPosition "head")) vectorAdd [0,0,0.35+(_x distance BRPVP_myPlayerOrSpecOrDrone)*0.035*(getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75)],_imgSize,_imgSize,0,"",0,((((safezoneW/safezoneH) min 1.2)/1.2)/25)*0.8,"RobotoCondensedBold","center",true];
					drawIcon3D ["",_color,(_x modelToWorldVisual [0,0,0]) vectorAdd [0,0,-0.35+(_x distance BRPVP_myPlayerOrSpecOrDrone)*0.035*(getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75)],1,1,0,[1,"Good Peter",_dist] call BRPVP_txtIconCreate,0,0.03];
				};
			} forEach BRPVP_peterModel;

			//LAZARUS ICON
			{
				private _dist = BRPVP_myPlayerOrSpecOrDrone distance _x;
				if (alive _x && !isObjectHidden _x && _dist < 1500) then {
					private _color = if (_dist < 200) then {[1,0.5,0.25,1]} else {[1,1,1,1]};
					private _lifeImg = _x getVariable "brpvp_lars_gdam";
					drawIcon3D [BRPVP_missionRoot+"BRP_imagens\"+_lifeImg,[1,1,1,1],(_x modelToWorldVisual (_x selectionPosition "head")) vectorAdd [0,0,0.35+(_x distance BRPVP_myPlayerOrSpecOrDrone)*0.035*(getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75)],0.85,0.85,0,"",0,((((safezoneW/safezoneH) min 1.2)/1.2)/25)*0.8,"RobotoCondensedBold","center",true];
					drawIcon3D ["",_color,(_x modelToWorldVisual [0,0,0]) vectorAdd [0,0,-0.35+(_x distance BRPVP_myPlayerOrSpecOrDrone)*0.035*(getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75)],1,1,0,[1,"Lazarus",_dist] call BRPVP_txtIconCreate,0,0.03];
				};
			} forEach BRPVP_larsModel;

			//MINERVA SOLDIER 3D ICONS
			{
				private _dist = BRPVP_myPlayerOrSpecOrDrone distance _x;
				drawIcon3D [BRPVP_missionRoot+"BRP_imagens\mbot_insignea.paa",[1,1,1,1],(_x modelToWorldVisual (_x selectionPosition "head")) vectorAdd [0,0,0.35+(_x distance BRPVP_myPlayerOrSpecOrDrone)*0.035*(getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75)],0.675,0.675,0,[1,"",_dist] call BRPVP_txtIconCreate,0,0.03];
			} forEach BRPVP_minervaBotAllUnitsObjsNearSee;

			//ULFAN SOLDIER 3D ICONS
			{
				private _dist = BRPVP_myPlayerOrSpecOrDrone distance _x;
				drawIcon3D [BRPVP_missionRoot+"BRP_imagens\sbot_insignea.paa",[1,1,1,1],(_x modelToWorldVisual (_x selectionPosition "head")) vectorAdd [0,0,0.35+(_x distance BRPVP_myPlayerOrSpecOrDrone)*0.035*(getObjectFov BRPVP_myPlayerOrSpecOrDrone/0.75)],0.675,0.675,0,[1,"",_dist] call BRPVP_txtIconCreate,0,0.03];
			} forEach BRPVP_sBotAllUnitsObjsNearSee;

			//DRAW TIRES INFO
			if (!isNull BRPVP_tireCursorObject) then {
				private _cfg = BRPVP_tireCursorObject getVariable "brpvp_tire_nameCFG";
				private _txt = format ["(%1) %2",BRPVP_tireCursorObject getVariable "brpvp_tire_idbd",getText (_cfg >> "displayName")];
				drawIcon3D ["",[1,0.5,0,1],ASLToAGL getPosWorld BRPVP_tireCursorObject,0,0,0,_txt,0,0.03];
			};
			{
				if (_x distance BRPVP_myPlayerOrSpecOrDrone < 10) then {
					private _cfg = _x getVariable "brpvp_tire_nameCFG";
					private _txt = format ["(%1) %2",_x getVariable "brpvp_tire_idbd",getText (_cfg >> "displayName")];
					drawIcon3D ["",[1,0.5,0,1],ASLToAGL getPosWorld _x,0,0,0,_txt,0,0.03];
				} else {
					private _cfg = _x getVariable "brpvp_tire_nameCFG";
					private _txt = getText (_cfg >> "displayName")+" ";
					_txt = _txt select [0,_txt find " "];
					drawIcon3D ["",[1,0.5,0,1],ASLToAGL getPosWorld _x,0,0,0,_txt,0,0.03];
				};
			} forEach (BRPVP_tiresNearTires-[BRPVP_tireCursorObject]);
		
			//XRAY
			if (BRPVP_xrayOn || BRPVP_specXrayOn || !isNull BRPVP_xrayObj) then {call BRPVP_xrayCode;};

			//CTRL+4 MARKS ON 3D SCREEN
			if (BRPVP_ctrl4On3dDistance isNotEqualTo 0) then {
				if (BRPVP_ctrl4On3dDistance isEqualTo -1) then {
					{
						_x params ["_id","_pos","_txt"];
						private _dist = _pos distance2D player;
						private _color = if (_dist > viewDistance || {terrainIntersectASL [eyePos player,AGLToASL (_pos vectorAdd [0,0,3.5])]}) then {"BRP_imagens\mark_bw.paa"} else {"BRP_imagens\mark.paa"};
						drawIcon3D [BRPVP_missionRoot+_color,[1,1,1,1],_pos,0.45,0.45,0,[1,_txt,_dist] call BRPVP_txtIconCreate];
					} forEach BRPVP_myCustomMarks;
				} else {
					{
						_x params ["_id","_pos","_txt"];
						private _dist = _pos distance2D player;
						if (_dist < BRPVP_ctrl4On3dDistance) then {
							private _color = if (_dist > viewDistance || {terrainIntersectASL [eyePos player,AGLToASL (_pos vectorAdd [0,0,3.5])]}) then {"BRP_imagens\mark_bw.paa"} else {"BRP_imagens\mark.paa"};
							drawIcon3D [BRPVP_missionRoot+_color,[1,1,1,1],_pos,0.45,0.45,0,[1,_txt,_dist] call BRPVP_txtIconCreate];
						};
					} forEach BRPVP_myCustomMarks;
				};
			};
			
			//SET TERRAIN GRID ON ZOOM
			private _fovPlayer = [player,BRPVP_spectedPlayer] select BRPVP_spectateOn;
			if (!isNull _fovPlayer) then {
				private _cvCode = [{cameraView},{BRPVP_spectedPlayer getVariable ["cmv","INTERNAL"]}] select BRPVP_spectateOn;
				private _fov100 = round ((0.75/(getObjectFov _fovPlayer))*100)/100;
				if (call _cvCode isEqualTo "GUNNER" && _fov100 > 3) then {
					if (!BRPVP_zoomRunning) then {
						BRPVP_zoomRunning = true;
						[_cvCode,_fovPlayer,getObjectFov _fovPlayer] spawn {
							params ["_cvCode","_fovPlayer","_fov"];
							private _lastFov = _fov;
							private _cnt = 0;
							private _fpOk = true;
							private _fpOkCode = {([player,BRPVP_spectedPlayer] select BRPVP_spectateOn isEqualTo _fovPlayer) && _fovPlayer call BRPVP_pAlive && !isNull _fovPlayer};
							waitUntil {
								private _fov = getObjectFov _fovPlayer;
								if (_fov isEqualTo _lastFov) then {_cnt = _cnt+1;} else {_cnt = 0;_lastFov = _fov;};
								_fpOk = call _fpOkCode;
								_cnt isEqualTo 3 || !_fpOk
							};
							if (_fpOk) then {
								if (getTerrainGrid isNotEqualTo BRPVP_terrainGridOnZoom) then {setTerrainGrid BRPVP_terrainGridOnZoom;};
								private _od = if (BRPVP_viewDistState in [1,3,6,8]) then {15000 min BRPVP_viewDistFly} else {15000 min BRPVP_viewDist};
								if (getObjectViewDistance select 0 isNotEqualTo _od) then {setObjectViewDistance _od;};
								waitUntil {
									_fpOk = call _fpOkCode;
									!(call _cvCode isEqualTo "GUNNER" && getObjectFov _fovPlayer < 0.25) || !_fpOk
								};
							};
							BRPVP_zoomRunning = false;
						};
					};
				} else {
					if (_fov100 isEqualTo 3) then {
						if (getTerrainGrid isNotEqualTo BRPVP_terrainGridLook) then {setTerrainGrid BRPVP_terrainGridLook;};
						private _od = if (BRPVP_viewDistState in [1,3,6,8]) then {7500 min BRPVP_viewDistFly} else {5000 min BRPVP_viewDist};
						if (getObjectViewDistance select 0 isNotEqualTo _od) then {setObjectViewDistance _od;};
					} else {
						if (getTerrainGrid isNotEqualTo BRPVP_terrainGrid) then {setTerrainGrid BRPVP_terrainGrid;};
						private _od = if (BRPVP_viewDistState in [1,3,6,8]) then {4000 min BRPVP_viewDistFly} else {3000 min BRPVP_viewDist};
						if (getObjectViewDistance select 0 isNotEqualTo _od) then {setObjectViewDistance _od;};
					};
				};
			};

			//DRAW LAST VEHICLE ICON
			if (BRPVP_lastVehicleInPos isNotEqualTo [] && {player distance BRPVP_lastVehicleInPos < 2000}) then {
				private _color = if (BRPVP_lastVehicleInTi) then {"BRP_imagens\last_veh_bw.paa"} else {"BRP_imagens\last_veh.paa"};
				private _size = if (BRPVP_lastVehicleInTi) then {0.4} else {0.5};
				private _sizeFnt = if (BRPVP_lastVehicleInTi) then {0.02} else {0.025};
				drawIcon3D [BRPVP_missionRoot+_color,[1,1,1,1],BRPVP_lastVehicleInPos,_size,_size,0,[1,"",player distance BRPVP_lastVehicleInPos] call BRPVP_txtIconCreate,0,_sizeFnt];
			};
			
			//DRAW SAFEZONE EXIT PROTECTION ICON
			{
				private _d = (_x distance BRPVP_myPlayerOrSpecOrDrone) max 15;
				if (_d < 1250) then {
					private _size = (8/_d^0.9)/getObjectFov BRPVP_myPlayerOrSpecOrDrone;
					if (_size >= 0.1) then {
						private _attachedUse = (attachedObjects player+attachedObjects _x+[_x]) select 0;
						private _camPos = AGLToASL positionCameraToWorld [0,0,0];
						if ([vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [_camPos,eyePos _x] >= 0.5 && {[vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [_camPos,_x modelToWorldWorld (_x selectionPosition "rightleg")] >= 0.4 && [vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [_camPos,_x modelToWorldWorld (_x selectionPosition "leftleg")] >= 0.5}) then {
							private _reTime = ceil (15-(serverTime-(_x getVariable ["brpvp_extra_protection_start",0])));
							private _color = [[1,0.25,0.25,1],[1,1,1,1]] select (_reTime > 0);
							drawIcon3D [BRPVP_missionRoot+"BRP_imagens\sz_exit_protection.paa",_color,_x modelToWorldVisual (_x selectionPosition "spine1"),_size,_size,0,str (_reTime max 1),0,0.04];
						};
					};
				};
			} forEach ((BRPVP_safezoneProtectionOnExitObjs-[BRPVP_myPlayerOrSpec]) select {!isObjectHidden _x});

			//DRAW TURRETS ON ME
			if (time-BRPVP_onMeTurretIconsTime < 0.125) then {
				private _allTurretsOnMeRed = [BRPVP_allTurretsOnMeRed,BRPVP_allTurretsOnMeRedSpec] select BRPVP_spectateOn;
				private _allTurretsOnMeRedSee = [BRPVP_allTurretsOnMeRedSee,BRPVP_allTurretsOnMeRedSeeSpec] select BRPVP_spectateOn;
				{
					private _iEye = _x in _allTurretsOnMeRedSee;
					private _img = ["BRP_imagens\turret_warning_2_icon.paa","BRP_imagens\vd_eye.paa"] select _iEye;
					private _mSize = [3,1.5] select _iEye;
					private _mult = [1,0.75] select _iEye;
					private _d = (_x distance BRPVP_myPlayerOrSpecOrDrone) max 15;
					private _size = _mult*(8/_d^0.85)/getObjectFov BRPVP_myPlayerOrSpecOrDrone min _mSize;
					private _zFix = 0.75*_d/_d^0.85;
					drawIcon3D [BRPVP_missionRoot+_img,[1,1,1,1],ASLToAGL eyePos (_x getVariable ["brpvp_operator",objNull]) vectorAdd [0,0,0.6],_size,_size,0,"",0,0.04];
				} forEach _allTurretsOnMeRed;
			} else {
				if (time-BRPVP_onMeTurretIconsTime > 0.25) then {BRPVP_onMeTurretIconsTime = time;};
			};
		};

		//PLAYER UBER ATTACK
		call BRPVP_uberAttackMonitorPlayer;

		//FIX PARA MOVE
		call BRPVP_paraFix;

		//CODE FOR setFeatureType
		call BRPVP_nfCode;

		//FIX BIG SHIPS WALK BUG
		if (BRPVP_nearBigShips) then {call BRPVP_fixBigShipsWalkBug;};
		
		//DELETE TRACERS WITH NO VELOCITY
		{if (vectorMagnitude velocity (_x select 0) < 75) then {deleteVehicle (_x select 1);};} forEach BRPVP_firedFlyingBullets;

		//HACK A PLAYER
		if (count BRPVP_hackLines > 0) then {
			_myHack = player getVariable ["brpvp_my_hack",[]];
			_inDelivery = if (_myHack isEqualTo []) then {false} else {(_myHack select 3) isEqualTo BRPVP_hackTimeNoMoveToComplete};
			_obj = BRPVP_hackLines select 0 select 3;
			_puttingLines = _obj call BRPVP_pAlive && _myHack isEqualTo [];
			_hacking = count _myHack > 0 && !_inDelivery;
			if (_puttingLines || _hacking) then {
				_signal = 1;
				if (_hacking) then {
					_myHack params ["_obj","_id","_hackMoney","_timeNoMove","_center"];
					_signal = ((BRPVP_hackOnHackMoveLimit-(_center distance player)) max 0)/BRPVP_hackOnHackMoveLimit;
					_txt = "Hacking: "+str round (100*_timeNoMove/BRPVP_hackTimeNoMoveToComplete)+"% - Signal: "+str round (_signal*100)+"%";
					drawIcon3D ["",[0.25,0.25,1,1],ASLToAGL eyePos _obj,0,0,0,_txt,0,0.0325];
				};
				{
					_x params ["_color","_shift","_timeLimit","_obj","_objPos"];
					_colorFinal = if (time > _timeLimit) then {_color} else {[1,1,0,1]};
					if (random 1 < _signal) then {
						_posPlayer = getPosWorld player;
						_posHacked = _objPos;
						_posSky = _posHacked vectorAdd [0,0,1000];
						_vecPlayer = _posPlayer vectorDiff _posHacked;
						_vecShift = vectorNormalized (_vecPlayer vectorCrossProduct [0,0,1]) vectorMultiply _shift;
						drawLine3D [ASLToAGL (_posSky vectorAdd _vecShift),ASLToAGL _posHacked,_colorFinal];
					};
				} forEach (BRPVP_hackLines call BIS_fnc_arrayShuffle);
				if (_hacking && random 1 < _signal && time-BRPVP_hackBeepLast > 0.125) then {
					BRPVP_hackBeepLast = time;
					"hackBeep" call BRPVP_playSound;
				};
			} else {
				if (!_inDelivery) then {BRPVP_hackLines = [];};
			};
		};
		_hackOnMe = player getVariable ["brpvp_hack_on_me",objNull];
		if (!isNull _hackOnMe) then {
			if (_hackOnMe call BRPVP_pAlive) then {
				drawIcon3D ["",[0.25,0.25,1,1],ASLToAGL eyePos _hackOnMe,0,0,0,"01010101 "+(_hackOnMe getVariable ["nm","???"]),0,0.0325];
			} else {
				player setVariable ["brpvp_hack_on_me",objNull,true];
			};
		};
		
		//SKY DIVE
		if (BRPVP_nascendoParaQuedas) then {
			private _dlt = time-BRPVP_skyDiveInitTime;
			private _tmFactor = 1-(_dlt/BRPVP_skyDiveMaxFlyTime min 1);
			private _exp = 1/(_tmFactor*48+2);
			private _endFactor = (_tmFactor^_exp)*0.6+0.4;
			//systemChat str round (_endFactor*100);
			private _paraParam = BRPVP_paraParam vectorMultiply _endFactor;
			_h = ASLToAGL getPosASL player select 2;
			if (_h < BRPVP_paraParamH) then {BRPVP_paraParamH = _h;};
			_hP1 = BRPVP_paraParamH;
			_hP2 = BRPVP_paraParamH+600;
			_hFactor = (600-((_h max _hP1 min _hP2)-_hP1))/600;
			_qps = diag_fps;
			_qpsFator = 15/_qps;
			_vel = velocity player;
			_velMag = vectorMagnitude _vel;
			_dir2D = vectorDir player;
			_dir2D set [2,0];
			_dir2DNrm = vectorNormalized _dir2D;
			_vel2D = +_vel;
			_vel2D set [2,0];
			_vel2DMag = vectorMagnitude _vel2D;
			_ang = acos (_dir2D vectorCos [0,1,0]);
			if (_dir2D select 0 < 0) then {_ang = 360-_ang;};
			_velAmigo = [_vel2DMag*sin _ang,_vel2DMag*cos _ang,_vel select 2];
			_aVecDir = _dir2DNrm vectorMultiply ((_paraParam select 0)*_hFactor*_velMag*_qpsFator);
			_aVecZ = (vectorNormalized [0,0,_paraParam select 1]) vectorMultiply abs((_paraParam select 1)*_hFactor*_velMag*_qpsFator);
			_velNovo = (_velAmigo vectorAdd _aVecDir) vectorAdd _aVecZ;
			player setVelocity _velNovo;
		};

		//FLY
		if (BRPVP_flyOnOff || BRPVP_flyOnOffAdmin) then {
			//CONSTRUCTION FLY
			private _vecA = [0,0,0];
			private _vecB = [0,0,0];
			private _vecC = [0,0,0];
			private _cVec = [0,0,0];
			_cVec = getCameraViewDirection player;
			if (BRPVP_flyA2) then {_vecA = _cVec vectorMultiply -15;};
			if (BRPVP_flyA1) then {_vecA = _cVec vectorMultiply +15;};
			if (BRPVP_flyB2) then {_vecB = [0,0,-8];};
			if (BRPVP_flyB1) then {_vecB = [0,0,+8];};
			if (BRPVP_flyC2) then {_vecC = player vectorModelToWorld [-8,0,0];};
			if (BRPVP_flyC1) then {_vecC = player vectorModelToWorld [+8,0,0];};
			if (BRPVP_flyA1 || BRPVP_flyA2 || BRPVP_flyB1 || BRPVP_flyB2 || BRPVP_flyC1 || BRPVP_flyC2) then {
				private _h1 = ASLToAGL getPosASL player select 2;
				private _h2 = getPos player select 2;
				private _vecAC = _vecA vectorAdd _vecC;
				if (_h1 > BRPVP_maxBuildHeight-2) then {
					_normal = if (surfaceIsWater getPosASL player) then {[0,0,1]} else {surfaceNormal getPosASL player};
					_vec = _vecAC vectorCrossProduct _normal;
					_cross = vectorNormalized (_normal vectorCrossProduct _vec);
					_vecA = _cross vectorMultiply (vectorMagnitude _vecAC*cos(_vecAC vectorCos _vec));
					_vecB = [0,0,-5];
					_vecC = [0,0,0];
				} else {
					if (_h2 < 1) then {
						_lis = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-5],player,objNull,true,1,"GEOM","NONE"];
						_normal = if (_lis isEqualTo []) then {[0,0,1]} else {_lis select 0 select 1};
						_vec = _vecAC vectorCrossProduct _normal;
						_cross = vectorNormalized (_normal vectorCrossProduct _vec);
						_hCheck = vectorNormalized _vecAC select 2 > _cross select 2;
						_vecA = if (_hCheck) then {_vecAC} else {_cross vectorMultiply (vectorMagnitude _vecAC*cos(_vecAC vectorCos _vec))};
						if (_vecB isEqualTo [0,0,-8]) then {_vecB = [0,0,0];};
						_vecC = [0,0,0];
					};
				};
				player setVelocity (((_vecA vectorAdd _vecB) vectorAdd _vecC) vectorMultiply ([1,2] select BRPVP_flyAcell));
			} else {
				player setVelocity [0,0,0];
			};
		} else {
			if (BRPVP_isAdminOrModerator) then {
				//ADMIN FLY
				if (BRPVP_flyA || BRPVP_flyB) then {
					if ((getUnitFreefallInfo player select 2) isEqualTo 100) then {player setUnitFreefallHeight 20000;};
				} else {
					if (getPos player select 2 < 0.01 && (getUnitFreefallInfo player select 2) isEqualTo 20000) then {player setUnitFreefallHeight 100;};
				};
				if (BRPVP_flyA) then {
					player setPosASL BRPVP_flyRecord;
					_h = ((ASLToAGL getPosASL player select 2) max 30 min 190)-10;
					_hf = _h/180;
					_dist = (25+_hf*160)/diag_fps;
					_vec = getCameraViewDirection player vectorMultiply _dist;
					BRPVP_flyRecord = BRPVP_flyRecord vectorAdd _vec;
					_dlt = ((([0,0,0] getDir _vec)-getDir player)+360) mod 360;
					_dlt = if (_dlt > 180) then {_dlt-360} else {_dlt};
					player setDir (getDir player+_dlt/60);
				};
				if (BRPVP_flyB) then {
					private ["_ppa"];
					if (!BRPVP_flyA) then {player setPosASL BRPVP_flyRecord;};
					_h = ((ASLToAGL BRPVP_flyRecord select 2) max 30 min 190)-10;
					_hf = _h/180;
					_dist = (10+_hf*120)/diag_fps;
					BRPVP_flyRecord = BRPVP_flyRecord vectorAdd [0,0,_dist];
				};
				if (BRPVP_flyA || BRPVP_flyB) then {
					_h = 0;
					_h1 = ASLToATL BRPVP_flyRecord select 2;
					if (_h1 < 1.5) then {_h = -(_h1-1.5);};
					if (BRPVP_flyD) then {
						_h2 = ASLToAGL BRPVP_flyRecord select 2;
						if (_h2 > 98) then {_h = -(_h2-98);};
					};
					BRPVP_flyRecord set [2,(BRPVP_flyRecord select 2)+_h];
					player setPosASL BRPVP_flyRecord;
				} else {
					if (BRPVP_flyC) then {player setVelocity [0,0,0];};
				};
			};
		};
		
		//CANCEL THIRD PERSON VIEW IF IN FIRST PERSON AREA
		{
			if ((_x select 0) distance player < (_x select 1)) exitWith {
				if !(cameraView in ["INTERNAL","GUNNER"]) then {
					(vehicle player) switchCamera "INTERNAL";
				};
			};			
		} forEach (BRPVP_firstPersonAreas+BRPVP_labNoThirdPerson);
		
		//FREEZE SPHERE
		_veh = objectParent player;
		if (BRPVP_nearFreezeFloor > 0 && !isNull _veh && alive _veh && local _veh) then {
			_array = _veh getVariable ["brpvp_freeze_time",[]];
			_stuck = false;
			{if (_x select 0 > serverTime) exitWith {_stuck = true;};} forEach _array;
			if (_stuck) then {
				_veh setVelocity [0,0,0];
			} else {
				_floorOut = [];
				_newVar = [];
				{
					if (serverTime-(_x select 0) < BRPVP_freezeFloorCollDown) then {
						_floorOut pushBack (_x select 1);
						_newVar pushBack _x;
					};
				} forEach _array;
				if !(_array isEqualTo _newVar) then {_veh setVariable ["brpvp_freeze_time",_newVar,true];};
				_floors = nearestObjects [_veh,["Sign_Sphere200cm_F"],3];
				if (count _floors > 0) then {
					_floor = _floors select 0;
					if (!(_floor call BRPVP_checaAcesso || _floor in _floorOut) || _floor getVariable ["brpvp_rto",false]) then {
						_newVar pushBack [serverTime+BRPVP_freezeFloorTime,_floor];
						_veh setVariable ["brpvp_freeze_time",_newVar,true];
						[_veh,["freeze_floor",300]] remoteExecCall ["say3D",BRPVP_allNoServer];
					};
				};
			};
		};

		//DETECT HOLE
		if (!isNull BRPVP_mineDetectorObj) then {
			_dist = (player distance BRPVP_mineDetectorObj) min 80;
			_perc = (80-_dist)^3/80^3;
			if (_perc > 0.875) then {
				"mine_detector_01" call BRPVP_playSound;
			} else {
				if (random 1 < _perc) then {
					selectRandom ["mine_detector_01","mine_detector_02","mine_detector_03","mine_detector_04","mine_detector_05"] call BRPVP_playSound;
				};
			};
		};
		
		//DRAW DESTROYED LINES
		{drawLine3D _x;} forEach BRPVP_baseBombDrawLines;
		{drawLine3D _x;} forEach BRPVP_baseBombDrawLinesGreen;
		
		//SET VIEW DISTANCE
		BRPVP_myUAVNow = player call BRPVP_controlingUAV;
		BRPVP_myPlayerOrUAV = [BRPVP_myUAVNow,player] select isNull BRPVP_myUAVNow;
		BRPVP_myPlayerOrUAVOrVehicle = [BRPVP_myUAVNow,vehicle player] select isNull BRPVP_myUAVNow;
		if (BRPVP_eachFrameBinaryA && BRPVP_eachFrameBinaryB) then {
			if (BRPVP_spectateOn) then {
				BRPVP_mySpecUAVNow = BRPVP_spectedPlayer call BRPVP_controlingUAV;
				_UAV = BRPVP_mySpecUAVNow;
				BRPVP_myPlayerOrSpec = BRPVP_spectedPlayer;
				BRPVP_myPlayerOrSpecOrDrone = [_UAV,BRPVP_spectedPlayer] select isNull _UAV;
				if (isNull _UAV) then {
					if (objectParent BRPVP_spectedPlayer isKindOf "Air" || BRPVP_specNascendoParaQuedas) then {
						if !(BRPVP_viewDistState isEqualTo 6) then {
							BRPVP_viewDistState = 6;
							setViewDistance BRPVP_viewDistFly;
							player setVariable ["brpvp_vd",BRPVP_viewDistFly,2];
						};
					} else {
						if !(BRPVP_viewDistState isEqualTo 7) then {
							BRPVP_viewDistState = 7;
							setViewDistance BRPVP_viewDist;
							player setVariable ["brpvp_vd",BRPVP_viewDist,2];
						};
					};
					BRPVP_myCenter = BRPVP_spectedPlayer;
				} else {
					if (_UAV isKindOf "Air") then {
						if !(BRPVP_viewDistState isEqualTo 8) then {
							BRPVP_viewDistState = 8;
							setViewDistance BRPVP_viewDistFly;
							player setVariable ["brpvp_vd",BRPVP_viewDistFly,2];
						};
					} else {
						if !(BRPVP_viewDistState isEqualTo 9) then {
							BRPVP_viewDistState = 9;
							setViewDistance BRPVP_viewDist;
							player setVariable ["brpvp_vd",BRPVP_viewDist,2];
						};
					};
					BRPVP_myCenter = _UAV;
				};
			} else {
				BRPVP_myPlayerOrSpec = player;
				BRPVP_myPlayerOrSpecOrDrone = BRPVP_myPlayerOrUAV;
				if (BRPVP_busDestine isEqualTo []) then {
					_UAV = BRPVP_myUAVNow;
					if (isNull _UAV) then {
						if (objectParent player isKindOf "Air" || BRPVP_nascendoParaQuedas) then {
							if !(BRPVP_viewDistState isEqualTo 3) then {
								BRPVP_viewDistState = 3;
								setViewDistance BRPVP_viewDistFly;
								player setVariable ["brpvp_vd",BRPVP_viewDistFly,2];
							};
						} else {
							if !(BRPVP_viewDistState isEqualTo 4) then {
								BRPVP_viewDistState = 4;
								setViewDistance BRPVP_viewDist;
								player setVariable ["brpvp_vd",BRPVP_viewDist,2];
							};
						};
						BRPVP_myCenter = player;
					} else {
						if (_UAV isKindOf "Air") then {
							if !(BRPVP_viewDistState isEqualTo 1) then {
								BRPVP_viewDistState = 1;
								setViewDistance BRPVP_viewDistFly;
								player setVariable ["brpvp_vd",BRPVP_viewDistFly,2];
								_UAV call BRPVP_turnOffVehRadar;
							};
						} else {
							if !(BRPVP_viewDistState isEqualTo 2) then {
								BRPVP_viewDistState = 2;
								setViewDistance BRPVP_viewDist;
								player setVariable ["brpvp_vd",BRPVP_viewDist,2];
							};
						};
						BRPVP_myCenter = _UAV;
					};
				} else {
					if !(BRPVP_viewDistState isEqualTo 5) then {
						BRPVP_viewDistState = 5;
						setViewDistance 1250;
						player setVariable ["brpvp_vd",500,2];
					};
				};

				//CHECK IF LOOKING TO A SINTONIZED SMART TV
				private _co = cursorObject;
				private _mlsc = player getVariable ["brpvp_my_looking_seccam",objNull];
				if (typeOf _co isEqualTo "Land_Billboard_F") then {
					private _distOk = player distance _co < 200;
					private _cam = _co getVariable ["brpvp_bb_camera_fake",objNull];
					if (_co getVariable ["id_bd",-1] > -1 && _distOk && !isNull _cam) then {
						private _changed = _cam isNotEqualTo _mlsc || _co isNotEqualTo BRPVP_lastBbLooking;
						if (_changed) then {
							private _camKey = "seccam"+str (_co getVariable "id_bd");
							player setVariable ["brpvp_my_looking_seccam",_cam,[clientOwner,2]];
							if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
								private _oldCamKey = "seccam"+str (BRPVP_lastBbLooking getVariable ["id_bd",0]);
								[_cam,_oldCamKey,_camKey] remoteExecCall ["BRPVP_setLookingBbSyncSpec",BRPVP_specOnMeMachinesNoMe];
							};
							if (!isNull BRPVP_lastBbLooking) then {
								private _oldCamKey = "seccam"+str (BRPVP_lastBbLooking getVariable "id_bd");
								_oldCamKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
							};
							_camKey setPiPEffect [3,0,1,1,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
							BRPVP_secCamCurrentCamKey = _camKey;
							BRPVP_lastBbLooking = _co;
						};
					} else {
						if (!isNull _mlsc) then {
							player setVariable ["brpvp_my_looking_seccam",objNull,[clientOwner,2]];
							if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
								private _oldCamKey = "seccam"+str (BRPVP_lastBbLooking getVariable ["id_bd",0]);
								[objNull,_oldCamKey] remoteExecCall ["BRPVP_setLookingBbSyncSpec",BRPVP_specOnMeMachinesNoMe];
							};
						};
						if (!isNull BRPVP_lastBbLooking) then {
							private _oldCamKey = "seccam"+str (BRPVP_lastBbLooking getVariable ["id_bd",0]);
							_oldCamKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
							BRPVP_secCamCurrentCamKey = "";
							BRPVP_lastBbLooking = objNull;
						};
					};
				} else {
					if (!isNull _mlsc) then {
						player setVariable ["brpvp_my_looking_seccam",objNull,[clientOwner,2]];
						if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
							private _oldCamKey = "seccam"+str (BRPVP_lastBbLooking getVariable "id_bd");
							[objNull,_oldCamKey] remoteExecCall ["BRPVP_setLookingBbSyncSpec",BRPVP_specOnMeMachinesNoMe];
						};
					};
					if (!isNull BRPVP_lastBbLooking) then {
						private _oldCamKey = "seccam"+str (BRPVP_lastBbLooking getVariable "id_bd");
						_oldCamKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
						BRPVP_secCamCurrentCamKey = "";
						BRPVP_lastBbLooking = objNull;
					};
				};
			};

			//DRONE ACCESS FIX
			//call BRPVP_droneAccessFix;

			//SET DEFAULT PIP DISTANCE
			if (isPiPEnabled) then {if (getPipViewDistance isNotEqualTo BRPVP_secCamViewDistance) then {setPipViewDistance BRPVP_secCamViewDistance;};};
		};

		//HELI EVENT BACK ARROW
		call BRPVP_heliEventDirection;

		//DRAW ROUTE
		call BRPVP_ppathLoopCode;

		//DRAW SIXTH SENSE AI UNITS
		if ((BRPVP_spectateOn && BRPVP_sixthSenseOnSpec) || (!BRPVP_spectateOn && BRPVP_sixthSenseOn) || BRPVP_vePlayersSixthSense) then {call BRPVP_sixthSenseCodeShow;};

		//FLASH PERSONAL BUSH
		if (!isNull BRPVP_personalBush) then {
			if (BRPVP_personalBushFired) then {
				detach BRPVP_personalBush;
				deleteVehicle BRPVP_personalBush;
				[player,["bush_reveal",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
				BRPVP_personalBushFired = false;
			};
		};

		//FIX SENT TO INFINITY ARMA 3 BUG
		private _bugPosNow = getPosASL player;
		if (ASLToAGL _bugPosNow select 2 > 99990) then {
			if (isDamageAllowed player) then {
				player allowDamage false;
				player setPosASL BRPVP_playerLastSafePosBeforeBug;
				0 spawn {uiSleep 0.001;player allowDamage true;};
			} else {
				player setPosASL BRPVP_playerLastSafePosBeforeBug;
			};
		} else {
			BRPVP_playerLastSafePosBeforeBug = _bugPosNow;
		};

		BRPVP_eachFrameBinaryA = !BRPVP_eachFrameBinaryA;
		if (BRPVP_eachFrameBinaryA) then {BRPVP_eachFrameBinaryB = !BRPVP_eachFrameBinaryB;};
	};
	
	//LEST WEST WALL ARRAY
	BRPVP_lestWestWallRectangles = [];
	{
		_x params ["_p1","_p2"];
		_center = (_p1 vectorAdd _p2) vectorMultiply 0.5;
		_sideX = _p1 distance2D _center;
		_sideY = 8;
		_dir = ([_p1,_p2] call BIS_fnc_dirTo)+90;
		BRPVP_lestWestWallRectangles pushBack [_center,_sideX,_sideY,_dir,[1,1,1,1],"#(rgb,8,8,3)color(1,0.7,0.4,0.5)"];
	} forEach BRPVP_lestWestWallSegments;

	BRPVP_mapVisibleRadiusCfg = BRPVP_mapVisibleCircleSizeMultiplier*((BRPVP_mapaDimensoes select 0) max (BRPVP_mapaDimensoes select 1))/(2*2.5);
	BRPVP_mapVisibleRadiusGlow = BRPVP_mapVisibleRadiusCfg*0.02;
	BRPVP_mapVisibleRadius = BRPVP_mapVisibleRadiusCfg;
	BRPVP_mapDrawTimeStep = 1;
	BRPVP_mapDrawTime = -BRPVP_mapDrawTimeStep;
	BRPVP_iconsArrayNoBinocle = [];
	BRPVP_iconsArray = [];
	BRPVP_convoyIcons = [];
	BRPVP_rectangleArray = [];
	BRPVP_rectangleArrayBinocle = [];
	BRPVP_lineArray = [];
	BRPVP_mapDrawEH = {
		if (BRPVP_mapWasOn || BRPVP_gpsWasOn || BRPVP_artyMapOn || BRPVP_droneMapOn) then {
			private _scale = ctrlMapScale (_this select 0);
			private _gpsViewDist = 1.5*100*(_scale/0.0233707);
			private _iconsArrayAllways = [];
			private _iconsArrayAllwaysNoBinocle = [];
			private _stepNow = time-BRPVP_mapDrawTime >= BRPVP_mapDrawTimeStep;
			private _visibleMap = visibleMap || BRPVP_artyMapOn || BRPVP_droneMapOn;

			[_this select 0,_visibleMap] call BRPVP_mapDraw;

			if (_stepNow) then {
				private _convoyIcons = [];
				private _iconsArray = [];
				private _iconsArrayNoBinocle = [];
				private _rectangleArray = [];
				private _rectangleArrayBinocle = [];
				private _lineArray = [];
				BRPVP_mapDrawTime = time;

				//======================
				//MAGUS
				//======================

				if (BRPVP_mapShowMagus) then {
					//MAGUS BARRIERS
					private _magusToShow = if (BRPVP_vePlayers) then {BRPVP_tireAllTiresGlobal} else {BRPVP_myTires};
					if (BRPVP_infantryDay) then {
						{if (!isNull _x) then {if (typeOf _x isEqualTo "PlasticBarrier_02_grey_F") then {_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\magus_tire.paa",[1,1,1,1],getPosWorld _x,20,20,0,"",false,0.06,"puristaMedium","right"];} else {_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\magus_tire.paa",[1,0.8,0.6,1],getPosWorld _x,20,20,0,"",false,0.06,"puristaMedium","right"];};};} forEach _magusToShow;
					} else {
						{if (!isNull _x) then {_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\magus_tire.paa",[1,1,1,1],getPosWorld _x,20,20,0,"",false,0.06,"puristaMedium","right"];};} forEach _magusToShow;
					};
				};

				//======================
				//FRANTA MINES
				//======================

				if (BRPVP_mapShowFrantaMines) then {
					//FRANTA MINES
					{_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\base_mine.paa",[1,1,1,1],getPosWorld _x,17,17,0,"",false,0.06,"puristaMedium","right"];} forEach BRPVP_frantaAllObjsMy;
					{_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\base_mine.paa",[0.25,1,0.25,1],getPosWorld _x,17,17,0,"",false,0.06,"puristaMedium","right"];} forEach BRPVP_frantaAllObjsMyFriends;
				};

				//======================
				//TRADERS
				//======================
				if (BRPVP_mapShowTraders) then {
					//CLASSIFIED AD TRADERS
					{_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\class_ad.paa",[1,1,1,1],_x select 0,25,25,0,localize "str_class_ads",false,0.05,"puristaMedium","right"];} forEach BRPVP_classAdTraders;
				};

				//======================
				//MISSIONS
				//======================

				if (BRPVP_mapShowMissions) then {
					//INFECTED CITIES 1
					if (BRPVP_countSecs mod 2 isEqualTo 0) then {
						{
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\super_zombies.paa",[1,1,1,1],_x select 0,30,30,0,_x select 4,false,0.05,"puristaMedium","right"];
						} forEach BRPVP_zombieSuperSpawnCities;
					};

					//BRAVO MISSION ICON
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\icones3D\missao1.paa",[1,1,1,1],getPosASL _x,20,20,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_missPrediosEm;

					//EV EVENTS ICON
					{
						if (BRPVP_eventsDataCodeIsOn select _forEachIndex isEqualTo 2) then {
							_iconsArray pushBack [BRPVP_missionRootNoMod+(_x select 3),[1,1,1,1],_x select 0,35,35,0,_x select 2,false,0.06,"puristaMedium","right"];
						};
					} forEach BRPVP_eventsData;

					//ROAD BLOCK ICONS
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\block.paa",[1,1,1,1],_x select 0,25,25,((_x select 1)+270) mod 360+(if (_x select 1 > 180 && _x select 1 < 360) then {180} else {0}),"",false,0.05,"puristaMedium","center"];
					} forEach BRPVP_blockPlacesSelected;

					//FORT DEFEND ICON
					if (BRPVP_defendFortRun) then {
						private _sufix = [" (Off)",""] select BRPVP_isZombieDay;
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\defend_mission.paa",[1,1,1,1],BRPVP_defendFortCenter,25,25,0,localize "str_fort_defend"+_sufix,false,0.06,"puristaMedium","center"];
					};

					//SIEGE MISSION ICON
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\siege.paa",[1,1,1,1],_x,30,30,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_onSiegeIcons;

					//FALL PLANE MISSION
					{
						if (!isNull _x) then {
							private _ciCase = [[],[],[]];
							(_ciCase select 0) append [getPosWorld _x,_x getVariable "brpvp_jump_pos"];
							(_ciCase select 1) append [[BRPVP_missionRoot+"BRP_imagens\icones3d\corrupt.paa",[1,1,1,1],getPosWorld _x,35,35,_x getVariable ["dir",0],"",false,0.05,"puristaMedium","right"],[BRPVP_missionRoot+"BRP_imagens\icones3d\parapoint.paa",[1,1,1,1],_x getVariable "brpvp_jump_pos",25,25,0,"",false,0.05,"puristaMedium","right"]];
							(_ciCase select 2) pushBack [getPosWorld _x,_x getVariable "brpvp_jump_pos",[1,0.65,0,1]];
							_convoyIcons pushBack _ciCase;
						};
					} forEach BRPVP_corruptMissIcon;

					//BOMB MISSON ICON
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\bomb.paa",[1,1,1,1],getPosWorld _x,27,27,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_bombMissionObjs;

					//HOLE MISSION ICON
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\hole_mission_icon.paa",[1,1,1,1],_x select 0,30,30,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_holeMissionInfo;

					//WATER MISSION ICON
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\sub_map_icon.paa",[1,1,1,1],_x getVariable ["brpvp_icon_pos",[0,0,0]],27,27,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_waterMissionSubs;

					//TRANSPORT MISSION ICON
					{
						_x params ["_vehicle","_plane","_key"];
						if (!isNull _vehicle) then {
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\trans_origin.paa",[1,1,1,1],getPosASLVisual _vehicle,27,27,0,"#"+str _key,false,0.06,"puristaMedium","right"];
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\trans_destine.paa",[1,1,1,1],getPosWorld _plane,27,27,0,"#"+str _key,false,0.06,"puristaMedium","right"];
						};
					} forEach BRPVP_transActives;

					//VEHICLE MISSION ICON (WHITE KEY)
					{
						if (!isNull _x) then {
							private _lvl = _x getVariable ["brpvp_veh_miss_lvl","?"];
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mission\vehicle_miss.paa",[1,1,1,1],getPosASLVisual _x,25,25,0,format ["Lvl %1",_lvl],false,0.05,"puristaMedium","right"];
						};
					} forEach BRPVP_vehicleMissionIcons;

					//MARINHA DO BRASIL MISSION ICON
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\marinha.paa",[1,1,1,1],getPosWorld _x,45,45,0,"",false,0.06,"puristaMedium","right"];
					} forEach BRPVP_carrierMissActive;

					if (BRPVP_countSecs mod 2 isEqualTo 0) then {
						//GOOD PETER CITY
						{_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\peter_life_0.paa",[1,1,1,1],BRPVP_locaisImportantes select _x select 0,25,25,0,"Good Peter",false,0.05,"puristaMedium","right"];} forEach BRPVP_peterCities;
						//LAZARUS CITY
						{_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\lars_icon.paa",[1,1,1,1],BRPVP_locaisImportantes select _x select 0,25,25,0,"Lazarus",false,0.05,"puristaMedium","right"];} forEach BRPVP_larsCities;
					} else {
						//LAZARUS CITY
						{_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\lars_icon.paa",[1,1,1,1],BRPVP_locaisImportantes select _x select 0,25,25,0,"Lazarus",false,0.05,"puristaMedium","right"];} forEach BRPVP_larsCities;
						//GOOD PETER CITY
						{_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\peter_life_0.paa",[1,1,1,1],BRPVP_locaisImportantes select _x select 0,25,25,0,"Good Peter",false,0.05,"puristaMedium","right"];} forEach BRPVP_peterCities;
					};

					//GOOD PETER ROSE GRAVE
					{
						if (!alive _x && !isNull _x) then {
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\peter_grave.paa",[1,1,1,1],getPosWorld _x,22,22,0,"",false,0.05,"puristaMedium","right"];
						};
					} forEach BRPVP_peterModel;

					//LAZARUS ROSE GRAVE
					{
						if (!alive _x && !isNull _x) then {
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\lars_grave.paa",[1,1,1,1],getPosWorld _x,22,22,0,"",false,0.05,"puristaMedium","right"];
						};
					} forEach BRPVP_larsModel;
					
					//PLAYER MISSIONS ICONS
					{
						private _name = _x select 2;
						_iconsArray pushBack [BRPVP_missionRootNoMod+(_x select 1),[1,1,1,1],_x select 0,40,40,0,format ["%1 (by %2)",if (_name select [0,4] isEqualTo "str_") then {localize _name} else {_name},_x select 3],false,0.05,"puristaMedium","right"];
					} forEach (BRPVP_pmissIcons+BRPVP_pmiss2Icons);

					//KONVOY ICONS
					if (BRPVP_showKonvoyMapIcons || BRPVP_vePlayers) then {
						{
							_x params ["_composition","_crew","_kPaa","_color"];
							private _cvThis = [[],[],[]];
							private _compositionOk = [];
							{if (canMove _x) then {_compositionOk pushBack _x;};} forEach _composition;
							_center = [0,0,0];
							{_center = _center vectorAdd getPosWorld _x;} forEach _compositionOk;
							_cntC = count _compositionOk;
							if (_cntC > 0) then {_center = _center vectorMultiply (1/_cntC);};
							if (_scale < 0.3 && _cntC > 1) then {
								{
									_pos = getPosWorld _x;
									(_cvThis select 0) pushBack _pos;
									(_cvThis select 1) pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\kveh.paa",[1,1,1,1],_pos,20,20,0,"",false,0.05,"puristaMedium","right"];
									(_cvThis select 2) pushBack [_center,_pos,[1,0,0,1]];
								} forEach _compositionOk;
							};
							if (_center isNotEqualTo [0,0,0]) then {
								(_cvThis select 0) pushBack _center;
								(_cvThis select 1) pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\"+_kPaa,[1,1,1,1],_center,25,25,0,"Destroy",false,0.06,"puristaMedium","right"];
							};
							_convoyIcons pushBack _cvThis;
						} forEach BRPVP_konvoyCompositions;
					};

					//INFECTED CITIES 2
					if (BRPVP_countSecs mod 2 isEqualTo 1) then {
						{
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\super_zombies.paa",[1,1,1,1],_x select 0,30,30,0,_x select 4,false,0.05,"puristaMedium","right"];
						} forEach BRPVP_zombieSuperSpawnCities;
					};

					//SPECIAL FORCES BY MASKE
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\special_forces.paa",[1,1,1,1],getPosWorld _x,35,35,0,localize "str_sforces_by_maske",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_specialForcesMissionsOn;
				
					//HAUNT HOUSE
					{
						if (!isNull _x) then {
							_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\haunt_house.paa",[1,1,1,1],getPosWorld _x,28,28,0,localize "str_haunt_house",false,0.05,"puristaMedium","right"];
						};
					} forEach BRPVP_hauntHouseIcons;

					//RAID TRAINING
					if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {
						private _img = ["BRP_imagens\raid_training.paa","BRP_imagens\raid_training_off.paa"] select (BRPVP_raidTrainingMissionFlagSize isEqualTo -1);
						_iconsArray pushBack [BRPVP_missionRoot+_img,[1,1,1,1],BRPVP_raidTrainingMapPosition,35,35,0,localize "str_raidt_tittle",false,0.05,"puristaMedium","right"];
					};
				};

				//======================
				//OTHER STUFF
				//======================

				if (BRPVP_mapShowOtherStuff) then {
					//RADIOACTIVE AREAS ICON
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\interface\radiation.paa",[1,1,1,1],_x select 0,25,25,0,"",false,0.05,"puristaMedium","center"];
					} forEach BRPVP_radioAreasMapIcons;

					//CAR GRAVEYARD ICONS
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\car_grave.paa",[1,1,1,1],_x,27,27,0,localize "str_car_graveyard",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_carGraveyardPlaces;
					
					//ATM MONEY MACHINES
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\interface\atm.paa",[1,1,1,1],getPosWorld _x,20,20,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_moneyMachines;

					//PUBLIC CRAFT WORKBENCHS
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\craft_bench.paa",[1,1,1,1],getPosWorld _x,25,25,0,"",false,0.06,"puristaMedium","right"];
					} forEach BRPVP_publicBenchs;
					
					//XP SANCTUARY PLACES
					if (!BRPVP_allXpOn) then {
						{
							_iconsArray pushBack [BRPVP_missionRootNoMod+"map_specific\sanctuary.paa",[1,1,1,1],getPosWorld _x,35,35,0,localize "str_xp_sanctuary",false,0.05,"puristaMedium","right"];
						} forEach BRPVP_xpSanctuaryBuildings;
					};

					//BUS SERVICE POINTS
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\interface\bus_service.paa",[1,1,1,1],_x select 0,16,16,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_busServiceStopPoints;

					//SPECIFIC MAP CUSTOM PLACES
					{
						_iconsArray pushBack [BRPVP_missionRootNoMod+(_x select 4),[1,1,1,1],_x select 0,30,30,0,_x select 2,false,0.05,"puristaMedium","right"];
					} forEach BRPVP_specificMapCustomPlaces;
				};

				//======================
				//CTRL+4 MARKS
				//======================

				if (BRPVP_mapShowCtrl4Marks) then {
					//CTRL+4 CUSTOM MARKS
					_extra = 0.01*(1-(_scale max 0.3))/0.7;
					{
						_x params ["_id","_pos","_txt"];
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\mark.paa",[1,1,1,1],_pos,13.5,13.5,0,_txt,false,0.05+_extra,"puristaMedium","right"];
					} forEach BRPVP_myCustomMarks;
				};

				//======================
				//PLAYER STUFF
				//======================

				if (BRPVP_mapShowPlayerStuff) then {
					//PLAYER ICONS
					private ["_player","_xMeusAmigosObj","_xPveFriends"];
					if (BRPVP_spectateOn) then {
						_player = BRPVP_spectedPlayer;
						_xMeusAmigosObj = BRPVP_specMeusAmigosObj;
						_xPveFriends = BRPVP_specPveFriends;
					} else {
						_player = player;
						_xMeusAmigosObj = BRPVP_meusAmigosObj;
						_xPveFriends = BRPVP_pveFriends;
					};

					private _myGroup = (units group _player)-[_player];
					private _pveBanditObjList = [];
					if (_player getVariable ["brpvp_pve_inside",0] > 0 && _player getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0) then {
						{
							if (_x getVariable ["dd",-1] <= 0 && _x getVariable ["brpvp_pve_inside",0] > 0 && _x getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0) then {
								_pveBanditObjList pushBack _x;
							};
						} forEach BRPVP_pveBanditObjList;
					};
					private _squad = _myGroup-_pveBanditObjList;
					private _trustInMe = _xMeusAmigosObj-(_pveBanditObjList+_squad);
					private _pveFriends = if (_player getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0 && _player getVariable "brpvp_my_flag_state" isNotEqualTo 1) then {
						if (!BRPVP_banditCanSeePvePlayers && player in BRPVP_pveBanditObjList) then {
							[]
						} else {
							((_xPveFriends apply {if (_x getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0 && (_x getVariable "brpvp_my_flag_state") isNotEqualTo 2) then {_x} else {-1}})-[-1])-(_pveBanditObjList+_squad+_trustInMe)
						};
					} else {
						[]
					};
					if (!BRPVP_inPIconsArea || BRPVP_vePlayers) then {
						_array = [
							BRPVP_myCenter,
							_scale,
							[
								[BRPVP_usePlayerIconBandit,300,_pveBanditObjList,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\interface\bandit.paa",[1,1,1,1],[0,0,0],20,20,0,"",false,0.06,"puristaMedium","right"]],
								[BRPVP_usePlayerIconSquad,300,_squad,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\squad.paa",[1,1,1,1],[0,0,0],20,20,0,"",false,0.06,"puristaMedium","right"]],
								[BRPVP_usePlayerIconFriends,300,_trustInMe,{!isObjectHidden _this && _this getVariable ["sok",false] && _this getVariable ["dd",-1] <= 0},[BRPVP_missionRoot+"BRP_imagens\icones3d\amigo32.paa",[1,1,0,1],[0,0,0],20,20,0,"",false,0.06,"puristaMedium","right"]],
								[BRPVP_usePlayerIconPve,300,_pveFriends,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\interface\pve_friends.paa",[1,1,1,1],[0,0,0],20,20,0,"",false,0.06,"puristaMedium","right"]],
								[!BRPVP_usePlayerIconBandit,0,_pveBanditObjList,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\player_off.paa",[0.1,0.37,0.51,1],[0,0,0],6,6,0,"xOff",false,0.06,"puristaMedium","right"]],
								[!BRPVP_usePlayerIconSquad,0,_squad,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\player_off_squad.paa",[1,1,1,1],[0,0,0],6,6,0,"xOff",false,0.06,"puristaMedium","right"]],
								[!BRPVP_usePlayerIconFriends,0,_trustInMe,{!isObjectHidden _this && _this getVariable ["sok",false] && _this getVariable ["dd",-1] <= 0},[BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,1,0,1],[0,0,0],6,6,0,"xOff",false,0.06,"puristaMedium","right"]],
								[!BRPVP_usePlayerIconPve,0,_pveFriends,{!isObjectHidden _this},[BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,1,1,1],[0,0,0],6,6,0,"xOff",false,0.06,"puristaMedium","right"]]
							]
						];
						{_iconsArrayNoBinocle pushBack _x;} forEach (_array call BRPVP_groupArrayByDistanceMultiple2D);
					};

					//DRAW BASE OBJECTS
					if (BRPVP_showMyBasesOnMap) then {
						{
							_x params ["_flag","_radius","_objs"];
							private _cases = [];
							{
								private _fmr = _x getVariable ["brpvp_fmr_user",[]];
								if (_fmr isEqualTo []) then {
									private _bBox = 0 boundingBoxReal _x;
									private _xHSide = abs((_bBox select 0 select 0)-(_bBox select 1 select 0))/2;
									private _yHSide = abs((_bBox select 0 select 1)-(_bBox select 1 select 1))/2;
									private _rectangle = [getPosWorld _x,_xHSide,_yHSide,getDir _x,[1,1,1,0],""];
									_x setVariable ["brpvp_fmr_user",_rectangle];
									_fmr = _rectangle;
								};
								if ((_x getVariable "own") isEqualTo (player getVariable ["id_bd",-1])) then {_fmr set [4,[0,1,0,1]];} else {_fmr set [4,[0,0,1,1]];};
								_cases pushBack _fmr;
							} forEach _objs;
							_rectangleArrayBinocle pushBack [_flag,_radius,_cases];
						} forEach BRPVP_myFlagsSeeBuildingsOnMap;
					};

					//DRAW LAST VEHICLE ICON
					if (BRPVP_lastVehicleInPos isNotEqualTo []) then {
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\last_veh.paa",[1,1,1,1],BRPVP_lastVehicleInPos,13.5,13.5,0,[1,"",player distance BRPVP_lastVehicleInPos] call BRPVP_txtIconCreate,false,0.05,"puristaMedium","right"];
					};
				};

				//======================
				//NO ON/OFF
				//======================

				//KILLE MAP
				if (BRPVP_killMapOn) then {
					{
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\kill_mark.paa",[1,1,1,1],_x,10,10,0,"",false,0.05,"puristaMedium","right"];
					} forEach BRPVP_killMapKillPos;
				};

				//BIG WALL
				{_rectangleArray pushBack _x;} forEach BRPVP_lestWestWallRectangles;

				//ARTY SPOT INFO
				{
					_x params ["_veh","_dir","_pos","_svTime"];
					if (serverTime-_svTime < BRPVP_artySpotOnShotTime) then {
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\arty_spot.paa",[1,1,1,1],_pos,35,35,0,"",false,0.06,"puristaMedium","right"];
						_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\arty_spot_dir.paa",[1,1,1,1],_pos,60,60,_dir+180,"",false,0.06,"puristaMedium","right"];
					};
				} forEach BRPVP_artySpotInfo;			

				//RAID ACTION OPEN LOCK
				{
					_iconsArray pushBack [BRPVP_missionRoot+"BRP_imagens\interface\open_lock.paa",[1,1,1,1],_x select 0,25,25,0,"",false,0.05,"puristaMedium","right"];
				} forEach BRPVP_lockPickedBuildings;
				
				if (_visibleMap) then {
					BRPVP_iconsArrayNoBinocle = _iconsArrayNoBinocle;
					BRPVP_iconsArray = _iconsArray;
					BRPVP_convoyIcons = _convoyIcons;
					BRPVP_rectangleArray = _rectangleArray;
					BRPVP_rectangleArrayBinocle = _rectangleArrayBinocle;
				} else {
					BRPVP_iconsArrayNoBinocle = (_iconsArrayNoBinocle apply {if ((_x select 2) distance2D BRPVP_myPlayerOrUAV < _gpsViewDist) then {_x} else {-1};})-[-1];
					BRPVP_iconsArray = (_iconsArray apply {if ((_x select 2) distance2D BRPVP_myPlayerOrUAV < _gpsViewDist) then {_x} else {-1};})-[-1];
					BRPVP_convoyIcons = _convoyIcons;
					//BRPVP_rectangleArray = (_rectangleArray apply {if ((_x select 0) distance2D BRPVP_myPlayerOrUAV < _gpsViewDist) then {_x} else {-1};})-[-1];
					BRPVP_rectangleArray = _rectangleArray;
					BRPVP_rectangleArrayBinocle = _rectangleArrayBinocle select {(_x select 0) distance2D BRPVP_myPlayerOrUAV < _gpsViewDist+(_x select 1);};
				};
				
				//PATH DRAW ON MAP
				if (BRPVP_ppathIsOn && BRPVP_ppathShowMap) then {
					private _if = count BRPVP_ppathPath-1;
					for "_i1" from ((_if-(BRPVP_ppathSize-1)) max 0) to (_if-1) do {
						_lineArray pushBack [BRPVP_ppathPath select _i1 select 0,BRPVP_ppathPath select (_i1+1) select 0,BRPVP_ppathPath select _i1 select 1];
					};
					_lineArray pushBack [BRPVP_ppathPath select _if select 0,ASLToAGL getPosASL player vectorAdd [0,0,0.5],BRPVP_ppathPath select _if select 1];
				};

				BRPVP_lineArray = _lineArray;
				//BRPVP_iconsArray = BRPVP_iconsArray call BIS_fnc_arrayShuffle;
			};

			//======================
			//RUN EACH FRAME
			//======================

			if (BRPVP_specArtyTargetPos isNotEqualTo []) then {_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\arty_x.paa",[1,1,1,1],BRPVP_specArtyTargetPos,50,50,0,"",false,0.05,"puristaMedium","right"];};

			if (BRPVP_mapShowMissions) then {
				//HOLE MISSION ICON AREA
				{
					_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\draw_map\circle.paa",[0,1,0,0.25],_x select 0,BRPVP_mapAISM*(_x select 1)/(24*_scale),BRPVP_mapAISM*(_x select 1)/(24*_scale),0,"",false,0.05,"puristaMedium","right"];
				} forEach BRPVP_holeMissionInfo;
			};

			if (BRPVP_mapShowPlayerStuff) then {
				//PLAYER MARKS
				{
					_txt = _x getVariable ["nm","no_name"];
					{
						if !(_x isEqualTo []) then {
							_count = count _x;
							_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\setabu"+str _forEachIndex+".paa",[1,1,1,1],_x,20,20,0,_txt,false,0.06,"puristaMedium","center"];
						};
					} forEach (_x getVariable ["sts",[]]);
					_pd = _x getVariable ["pd",[]];
					if (_pd isNotEqualTo []) then {
						if (_x isEqualTo player) then {
							_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\marca_dest.paa",[1,1,1,1],_pd,22,22,0,_txt,false,0.06,"puristaMedium","center"];
						} else {
							_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\icones3d\marca_dest_amigo.paa",[1,1,1,1],_pd,20,20,0,_txt,false,0.06,"puristaMedium","center"];
						};
					};
				} forEach BRPVP_playersMarksEnabled;
			};

			//FIND DRONE ITEM ICON
			{
				_x params ["_time","_pos","_idx"];
				if (time-_time < BRPVP_spotedDroneOperatorsTime) then {
					_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\drone_finder.paa",[1,1,1,1],_pos,30,30,0,format [localize "str_drone_operator",_idx,ceil (BRPVP_spotedDroneOperatorsTime-(time-_time))],false,0.06,"puristaMedium","right"];
				};
			} forEach BRPVP_spotedDroneOperators;

			//PLACING CARRIER ICONS
			if (BRPVP_carrierUseStatus > 0) then {
				if (BRPVP_carrierUseStatus isEqualTo 1) then {
					private _pos = (_this select 0) ctrlMapScreenToWorld getMousePosition;
					private _size = 75*(0.1079/_scale) max 25;
					_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\acarrier_icon.paa",[1,1,1,1],_pos,_size,_size,0,"",false,0.06,"puristaMedium","right"];
				} else {
					if (BRPVP_carrierUseStatus isEqualTo 2) then {
						private _pos = (_this select 0) ctrlMapScreenToWorld getMousePosition;
						private _size = 75*(0.1079/_scale) max 25;
						_dir = [_pos,BRPVP_carrierPutPos] call BIS_fnc_dirTo;
						_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\acarrier_icon.paa",[1,1,1,1],BRPVP_carrierPutPos,_size,_size,_dir,"",false,0.06,"puristaMedium","right"];
					};
				};
			};

			//TOW VEHICLES ICONS
			{
				_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,0.5,1,1],getPosWorld _x,8,8,0,"Bob",false,0.05,"puristaMedium","right"];
			} forEach BRPVP_landVehicleOnTow;

			//OTHER EVENTS FANCY ICON
			{
				_x params ["_pos1","_dist"];
				private _angle1 = (time*180) mod 360;
				private _angle2 = (time*720) mod 360;
				private _pos2_1 = _pos1 getPos [_dist+_dist*0.35*sin _angle2,_angle1];
				private _pos2_2 = _pos1 getPos [_dist+_dist*0.35*sin _angle2,_angle1+120];
				private _pos2_3 = _pos1 getPos [_dist+_dist*0.35*sin _angle2,_angle1+240];
				_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\other_event.paa",[1,1,1,1],_pos1,40,40,0,"",false,0.06,"puristaMedium","right"];
				_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,0,0,1],_pos2_1,10,10,0,"",false,0.06,"puristaMedium","right"];
				_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,0,0,1],_pos2_2,10,10,0,"",false,0.06,"puristaMedium","right"];
				_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\player_off.paa",[1,0,0,1],_pos2_3,10,10,0,"",false,0.06,"puristaMedium","right"];
			} forEach (BRPVP_labNoThirdPerson+BRPVP_fastSpawnPlacesFugitive+(BRPVP_snipersFightObjs select 0)+(BRPVP_heliEventObjs select 2));

			//RANDOM SPAWN PLACES ICONS
			if (BRPVP_randomRespawnPlacesShow) then {
				{_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\interface\random_respawn.paa",[1,1,1,1],_x,35,35,0,"#"+str _forEachIndex,false,0.06,"puristaMedium","right"];} forEach BRPVP_randomRespawnPlaces;
			};

			//PLAYER POS
			_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\draw_map\mil_start.paa",[1,1,0,1],getPosWorldVisual BRPVP_myPlayerOrSpec,20,20,getDirVisual BRPVP_myPlayerOrSpec,"",false,0.06,"puristaMedium","right"];

			//SPEC MAP MOUSE POS
			if (BRPVP_spectateOn) then {
				private _vec = BRPVP_specMapMouseLast vectorDiff BRPVP_specMapMouseMovement;
				private _dm = (1/diag_fps)/0.25;
				BRPVP_specMapMouseMovement = BRPVP_specMapMouseMovement vectorAdd (_vec vectorMultiply _dm);
				(_this select 0) drawIcon [BRPVP_missionRoot+"BRP_imagens\spec_mouse.paa",[1,1,1,1],BRPVP_specMapMouseMovement,25,25,0,"",false,0.06,"puristaMedium","right"];
			};

			//CITY SPAWN COUNTER
			{
				_x params ["_pos","_tmOff","_tm"];
				private _numLetters = count toArray str _tm;
				private _lSpace= 660/BRPVP_mapAISM;
				private _eff = 1+0.2*sin (diag_tickTime*360*2);
				private _dEff = 12.5*sin (diag_tickTime*360);
				if (_tm isEqualTo -1) then {
					_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\veh_unlocked.paa",[1,1,1,1],_pos,30/sqrt(_scale)*_eff,30/sqrt(_scale)*_eff,_dEff,"",false,0.065,"puristaMedium","left"];
				} else {
					{
						private _pl = _pos vectorAdd [_eff*(-_lSpace*_numLetters/2+(_lSpace*_forEachIndex))*_scale/sqrt(_scale),0,0];
						_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\n0"+(toString [_x])+".paa",[1,1,1,1],_pl,15/sqrt(_scale)*_eff,30/sqrt(_scale)*_eff,_dEff,"",false,0.065,"puristaMedium","left"];
					} forEach toArray str _tm;
					_iconsArrayAllwaysNoBinocle pushBack [BRPVP_missionRoot+"BRP_imagens\veh_locked.paa",[1,1,1,1],_pos vectorAdd [_eff*(-_lSpace*_numLetters/2+(_lSpace*_numLetters))*_scale/sqrt(_scale),0,0],20/sqrt(_scale)*_eff,20/sqrt(_scale)*_eff,_dEff,"",false,0.065,"puristaMedium","left"];
				};
			} forEach BRPVP_temposLocais;

			//======================
			//END
			//======================

			BRPVP_mapVisibleRadius = (BRPVP_mapVisibleRadiusCfg+BRPVP_mapVisibleRadiusGlow*sin(360*time))*(_scale*(1+1.25*(1-_scale)));
			BRPVP_mapVisibleRadiusBorder = BRPVP_mapVisibleRadius*BRPVP_mapVisibleRadiusBorderPercentage;
			BRPVP_mapVisibleRadiusHalfBorder = BRPVP_mapVisibleRadiusBorder/2;
			BRPVP_mapVisibleRadiusCompare = BRPVP_mapVisibleRadius*BRPVP_mapVisibleRadiusPercAlpha+BRPVP_mapVisibleRadiusHalfBorder;
			BRPVP_mapVisibleRadiusMinLimit = BRPVP_mapVisibleRadius*BRPVP_mapVisibleRadiusPercAlpha-BRPVP_mapVisibleRadiusHalfBorder;
			BRPVP_mapMousePosBinocle = if (BRPVP_spectateOn) then {BRPVP_specMapMouseMovement} else {if (BRPVP_artyMapOn || BRPVP_droneMapOn) then {BRPVP_mapMouseMovementAny} else {findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld getMousePosition};};
			_iconsArrayAllways pushBack [BRPVP_missionRoot+"BRP_imagens\draw_map\circle_empty.paa",[0.5,1,0.5,0.5],BRPVP_mapMousePosBinocle,BRPVP_mapAISM*BRPVP_mapVisibleRadius/(24*_scale),BRPVP_mapAISM*BRPVP_mapVisibleRadius/(24*_scale),0,"",false,0.05,"puristaMedium","right"];
			if (BRPVP_mapIconsPerc isEqualTo 1) then {
				{(_this select 0) drawIcon _x;} forEach BRPVP_iconsArrayNoBinocle;
				{
					private _dist = _x select 2 distance2D BRPVP_mapMousePosBinocle;
					if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder) then {
						if (_dist <= BRPVP_mapVisibleRadiusMinLimit) then {
							(_this select 0) drawIcon _x;
						} else {
							private _case = +_x;
							private _alpha = _x select 1 select 3;
							private _factor = ((BRPVP_mapVisibleRadiusCompare-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
							(_case select 1) set [3,_alpha*_factor];
							(_this select 0) drawIcon _case;
						};
					};
				} forEach BRPVP_iconsArray;
				if (_visibleMap) then {
					{(_this select 0) drawIcon _x;} forEach _iconsArrayAllwaysNoBinocle;
					{
						private _dist = _x select 2 distance2D BRPVP_mapMousePosBinocle;
						if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder) then {
							if (_dist <= BRPVP_mapVisibleRadiusMinLimit) then {
								(_this select 0) drawIcon _x;
							} else {
								private _case = +_x;
								private _alpha = _x select 1 select 3;
								private _factor = ((BRPVP_mapVisibleRadiusCompare-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
								(_case select 1) set [3,_alpha*_factor];
								(_this select 0) drawIcon _case;
							};
						};
					} forEach _iconsArrayAllways;
				} else {
					{if ((_x select 2) distance2D BRPVP_myPlayerOrUAV < _gpsViewDist) then {(_this select 0) drawIcon _x;};} forEach _iconsArrayAllways;
				};
				{(_this select 0) drawRectangle _x;} forEach BRPVP_rectangleArray;
				{
					private _dist = ((_x select 0) distance2D BRPVP_mapMousePosBinocle)+BRPVP_mapVisibleRadius*0.75;
					if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder+(_x select 1)) then {
						if (_dist <= BRPVP_mapVisibleRadiusMinLimit) then {
							{(_this select 0) drawRectangle _x;} forEach (_x select 2);
						} else {
							private _factor = ((BRPVP_mapVisibleRadiusCompare+(_x select 1)-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
							{
								private _case = _x;
								(_case select 4) set [3,_factor];
								(_this select 0) drawRectangle _case;
							} forEach (_x select 2);
						};
					};
				} forEach BRPVP_rectangleArrayBinocle;
				//PLAYER PATH
				{(_this select 0) drawLine _x;} forEach BRPVP_lineArray;
				//CONVOY
				{
					_x params ["_allPos","_icons","_lines"];
					private _allDist = _allPos apply {_x distance2D BRPVP_mapMousePosBinocle};
					_allDist sort true;
					private _dist = _allDist select 0;
					if (_dist < BRPVP_mapVisibleRadius+BRPVP_mapVisibleRadiusHalfBorder) then {
						if (_dist <= BRPVP_mapVisibleRadiusMinLimit) then {
							{(_this select 0) drawIcon _x;} forEach _icons;
							{(_this select 0) drawLine _x;} forEach _lines;
						} else {
							private _factor = ((BRPVP_mapVisibleRadiusCompare-_dist) max 0 min BRPVP_mapVisibleRadiusBorder)/BRPVP_mapVisibleRadiusBorder;
							{(_x select 1) set [3,_factor];(_this select 0) drawIcon _x;} forEach _icons;
							{(_x select 2) set [3,_factor];(_this select 0) drawline _x;} forEach _lines;
						};
					};
				} forEach BRPVP_convoyIcons;
			} else {
				{if (random 1 < BRPVP_mapIconsPerc) then {(_this select 0) drawIcon _x;};} forEach (BRPVP_iconsArray+BRPVP_iconsArrayNoBinocle);
				if (_visibleMap) then {{if (random 1 < BRPVP_mapIconsPerc) then {(_this select 0) drawIcon _x;};} forEach (_iconsArrayAllways+_iconsArrayAllwaysNoBinocle);} else {{if ((_x select 2) distance2D BRPVP_myPlayerOrUAV < _gpsViewDist) then {if (random 1 < BRPVP_mapIconsPerc) then {(_this select 0) drawIcon _x;};};} forEach (_iconsArrayAllways+_iconsArrayAllwaysNoBinocle);};
				{if (random 1 < BRPVP_mapIconsPerc) then {(_this select 0) drawRectangle _x;};} forEach BRPVP_rectangleArray;
				{if (random 1 < BRPVP_mapIconsPerc) then {(_this select 0) drawLine _x;};} forEach BRPVP_lineArray;
			};
		};
	};

	0 spawn {
		waitUntil {
			waitUntil {!isNull (findDisplay 160 displayCtrl 51)};
			BRPVP_droneMapOn = true;
			findDisplay 160 displayCtrl 51 ctrlAddEventHandler ["Draw",{call BRPVP_mapDrawEH;}];
			waitUntil {
				BRPVP_mapMouseMovementAny = findDisplay 160 displayCtrl 51 ctrlMapScreenToWorld getMousePosition;
				BRPVP_specMapPosAny = findDisplay 160 displayCtrl 51 ctrlMapScreenToWorld [0.5,0.5];
				BRPVP_specMapScaleAny = ctrlMapScale (findDisplay 160 displayCtrl 51);
				isNull (findDisplay 160 displayCtrl 51)
			};
			BRPVP_droneMapOn = false;
			false
		};
	};
	0 spawn {
		disableSerialization;
		private _displays = uiNameSpace getVariable "igui_displays";
		private _ctrlGPS = _displays select (_displays findIf {!isNull (_x displayCtrl 101)}) displayCtrl 101;
		_ctrlGPS ctrlAddEventHandler ["Draw",{call BRPVP_mapDrawEH;}];
	};
	0 spawn {
		waitUntil {
			waitUntil {!isNull findDisplay 24};
			BRPVP_pressedKeys = [];
			waitUntil {isNull findDisplay 24};
			false
		};
	};
	0 spawn {
		waitUntil {
			waitUntil {!isNull findDisplay 49};
			BRPVP_pressedKeys = [];
			waitUntil {isNull findDisplay 49};
			false
		};
	};

	execVM "client_code\find_places_by_buildings.sqf";
	simulWeatherSync;
	["",0,0,0,0,0,1173] spawn BIS_fnc_dynamicText;
	if !(getPlayerUID player in BRPVP_openingPlayers) then {
		//if (localize "str_language_using" isEqualTo "portuguese") then {"welcome_portuguese" call BRPVP_playSound;};
		"welcome_portuguese" call BRPVP_playSound;
		call BRPVP_linksShow;
	};

	//ICONES SEMPRE: TRADERS, COLLECTORS
	{
		["trader","MERCADORES",_x,[1,105/255,180/255,1],BRPVP_mercadoresEstoque select ((_x getVariable ["mcdr",-1]) mod (count BRPVP_mercadoresEstoque)) select 1,"mil_triangle.paa",BRPVP_iSizeMilTriangle] call BRPVP_adicionaIconeLocal;
	} forEach BRPVP_mercadorObjs;
	{
		["trader","VENDAVE",_x,[1,1,1,1],((_x getVariable "vndv") call BRPVP_identifyShopType)+" "+str (_forEachIndex+1),"mil_triangle.paa",BRPVP_iSizeMilTriangle] call BRPVP_adicionaIconeLocal;
	} forEach BRPVP_vendaveObjs;
	{
		["trader","BUYERS",_x,[0,0,1,1],format [localize "str_coll_collectors",_forEachIndex+1],"mil_triangle.paa",BRPVP_iSizeMilTriangle] call BRPVP_adicionaIconeLocal;
	} forEach BRPVP_buyersObjs;
	{
		["trader","DISMANTLE",_x,[0.659,0.549,0.376,1],format [localize "str_psellveh_dismantle_x",_forEachIndex+1],"mil_triangle.paa",BRPVP_iSizeMilTriangle] call BRPVP_adicionaIconeLocal;
	} forEach BRPVP_dismantleManObjs;
	{
		["trader","THIEF_TRADER",_x,[0,0,0,1],format [localize "str_thief_obsc_trader_n",_forEachIndex+1],"mil_triangle.paa",BRPVP_iSizeMilTriangle] call BRPVP_adicionaIconeLocal;
	} forEach BRPVP_thiefAreasManObjs;
	{
		["trader","BLACK_TRADER",_x,[0,0,0,1],format [localize "str_black_trader_n",_forEachIndex+1],"mil_triangle.paa",BRPVP_iSizeMilTriangle] call BRPVP_adicionaIconeLocal;
	} forEach BRPVP_blackTradersObjs;

	//GET HALF BANDIT STATE
	[player,player getVariable "id"] remoteExecCall ["BRPVP_getAndSetHalfBanditState",2];

	//MAP CRASH TEST
	if (BRPVP_useMapCrashTestAtLogin) then {
		//MAP INSTANT CENTER AND MAX ZOOM
		BRPVP_mapIconsPerc = 0;
		waitUntil {openMap [true,true];visibleMap};
		showCompass false;
		private _bimg = (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{
			private _scale = ctrlMapScale (_this select 0);
			private _wsh = worldSize/2;
			private _dist = 0.02*_wsh+0.04*_scale*_wsh;
			private _angle = (diag_tickTime*180) mod 360;
			//BRPVP_mapIconsPerc = _scale^1.25;
			BRPVP_mapIconsPerc = 1;
			(_this select 0) drawIcon [(str missionConfigFile select [0,count str missionConfigFile-15])+"a3_crash_test.paa",[1,1,1,(0.5+(_scale*0.5))^(1/1.25)],[_wsh+_dist*sin _angle,_wsh+_dist*cos _angle],200,100,0,"",false,0.05,"puristaMedium","right"];
		}];
		(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{call BRPVP_mapDrawEH;}];
		private _cntr = [worldSize/2,worldSize/2];
		(findDisplay 12 displayCtrl 51) ctrlMapAnimAdd [0,0.001,_cntr];
		ctrlMapAnimCommit (findDisplay 12 displayCtrl 51);
		waitUntil {ctrlMapAnimDone (findDisplay 12 displayCtrl 51)};

		//MAP ZOOM OUT DRAMA
		playSound "intro_champion";
		(findDisplay 12 displayCtrl 51) ctrlMapAnimAdd [5,1,_cntr];
		ctrlMapAnimCommit (findDisplay 12 displayCtrl 51);
		256 cutText ["","BLACK IN",2.5];
		waitUntil {ctrlMapAnimDone (findDisplay 12 displayCtrl 51)};
		for "_i" from 1 to 10 do {
			uisleep (0.2*_i/10);
			openMap false;
			uisleep (0.2*_i/10);
			openMap true;
		};
		openMap [false,true];
		256 cutText ["","BLACK OUT",0.5];
		uiSleep 0.5;
		(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw",_bimg];
		showCompass true;
		BRPVP_mapIconsPerc = 1;
	} else {
		0 spawn {
			waitUntil {!isNull (findDisplay 12 displayCtrl 51)};
			(findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["Draw",{call BRPVP_mapDrawEH;}];
		};
	};

	//GET SHIFT+E BOXES SCALE STATE
	player remoteExecCall ["BRPVP_joiningPlayerSetOthersCarryBoxScale",2];

	uiSleep ((3-(time-_initSO)) max 0);
	BRPVP_allowBrpvpHint = true;
	
	//SET GERAL TRACERS
	if (BRPVP_forceTracersToAllPlayers) then {
		[player,["FiredMan",{call BRPVP_forcedTracerOnPlayer;}]] remoteExecCall ["addEventHandler",BRPVP_allNoServer,true];
	};

	//SET MEISTER LIGHTS
	private _meisters = (call BRPVP_playersList-[player]) select {_x getVariable ["brpvp_is_master",false]};
	{([_x]+BRPVP_meisterLightData) spawn BRPVP_shinePlayerCode;} forEach _meisters;
} else {
	//REDEFINE VARIAVEIS	
	call BRPVP_variavies;
};

//INICIA PROCESSO DE NASCIMENTO/SPAWN DO PLAYER
["",0,0,0,0,0,1173] spawn BIS_fnc_dynamicText;
call BRPVP_nascimento_player;

//LISTEN SERVER CLIENT OK
if (isServer) then {BRPVP_listenServerCliOk = true;};

diag_log ("[SCRIPT] playerInit.sqf END: "+str round (diag_tickTime-_scriptStart));