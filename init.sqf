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
private _isHc = !isServer && !hasInterface;
BRPVP_HCFps = -1;

if (isServer && hasInterface) then {
	waitUntil {!isNull player && time > 0};
	BRPVP_isPlayerHosted = true;
	publicVariable "BRPVP_isPlayerHosted";
	BRPVP_playerServerUID = getPlayerUID player;
	publicVariable "BRPVP_playerServerUID";
	player setUnitFreefallHeight 10000;
	player allowDamage false;
	//[player,true] remoteExecCall ["hideObjectGlobal",2];
	BRPVP_playerSpawnedPosition = getPosASL player;
	call compile preprocessFileLineNumbers "playerServerLoby.sqf";
	player switchMove "";
};
if (isServer && !hasInterface) then {
	BRPVP_isPlayerHosted = false;
	publicVariable "BRPVP_isPlayerHosted";
	BRPVP_playerServerUID = "0";
	publicVariable "BRPVP_playerServerUID";
	//call compile preprocessFileLineNumbers "playerServerLoby.sqf";
};

//EARLY USED VARS
BRPVP_specialItems = [
	"BRP_kitLight",
	"BRP_kitCamuflagem",
	"BRP_kitAreia",
	"BRP_kitCidade",
	"BRP_kitStone",
	"BRP_kitCasebres",
	"BRP_kitConcreto",
	"BRP_kitPedras",
	"BRP_kitTorres",
	"BRP_kitEspecial",
	"BRP_kitTableChair", //10
	"BRP_kitBeach",
	"BRP_kitReligious",
	"BRP_kitStuffo1",
	"BRP_kitStuffo2",
	"BRP_kitLamp",
	"BRP_kitRecreation",
	"BRP_kitMilitarSign",
	"BRP_kitFuelStorage",
	"BRP_kitWrecks",
	"BRP_kitSmallHouse", //20
	"BRP_kitAverageHouse",
	"BRP_kitAntennaA",
	"BRP_kitAntennaB",
	"BRP_kitMovement",
	"BRP_kitRespawnA",
	"BRP_kitRespawnB",
	"BRP_kitHelipad",
	"BRP_kitAutoTurret",
	"BRP_kitFlags25",
	"BRP_kitFlags50", //30
	"BRP_kitFlags100",
	"BRP_kitFlags200",
	"BRP_kitBigHouse",
	"BRP_kitGiantHouse",
	"BRP_kitContainers",
	"BRP_boxThief",
	"BRP_vehicleThief",
	"BRP_doorThief",
	"BRP_kitTrees",
	"BRP_vodka", //40
	"BRP_hackTool",
	"BRP_identifier",
	"BRP_remoteControl",
	"BRP_zombieSpawn",
	"Mag_BRPVP_hydraulic_jack",
	"Mag_BRPVP_z_blood_bag",
	"Mag_BRPVP_scanner_100",
	"Mag_BRPVP_scanner_200",
	"Mag_BRPVP_scanner_300",
	"Mag_BRPVP_fuel_gallon", //50
	"Mag_BRPVP_veh_ownerity",
	"BRPVP_equip_axe",
	"BRPVP_equip_shovel",
	"BRPVP_equip_cutter",
	"BRPVP_equip_pickaxe",
	"BRPVP_farm_limestone",
	"BRPVP_farm_clay",
	"BRPVP_farm_coal",
	"BRPVP_farm_stone",
	"BRPVP_farm_iron", //60
	"BRPVP_farm_leaves",
	"BRPVP_farm_cotton",
	"BRPVP_farm_wood",
	"BRPVP_farm_latex",
	"BRPVP_farm_sand",
	"BRPVP_farm_metal_trash",
	"BRPVP_farm_eletronic_trash",
	"BRPVP_craft_cement",
	"BRPVP_craft_brick",
	"BRPVP_craft_circuits", //70
	"BRPVP_craft_steel_plate",
	"BRPVP_craft_steel_rebar",
	"BRPVP_craft_wooden_board",
	"BRPVP_craft_reinforced_concrete",
	"BRPVP_craft_fabric",
	"BRPVP_craft_wooden_wall",
	"BRPVP_craft_brick_wall",
	"BRPVP_craft_steel_wall",
	"BRPVP_craft_stone_x10",
	"BRPVP_craft_rubber", //80
	"BRPVP_craft_foundations",
	"BRPVP_craft_steel_structure",
	"BRPVP_material_seam_kit",
	"BRPVP_material_bolt_nail",
	"BRPVP_hulk_pills",
	"BRPVP_drone_finder",
	"BRP_kitGates",
	"BRPVP_baseBomb",
	"BRPVP_personalTracer",
	"BRPVP_houseGodMode", //90
	"BRPVP_antiBaseBomb",
	"BRPVP_turnInBandit",
	"BRPVP_baseTest",
	"BRPVP_noGrass",
	"BRP_kitSmallLights",
	"BRPVP_itemPaintVehicle",
	"BRPVP_itemPaintThinner",
	"BRPVP_itemClimb",
	"BRPVP_foodApple",
	"BRPVP_foodCanned", //100
	"BRPVP_foodBread",
	"BRPVP_foodWater",
	"BRPVP_foodCake",
	"BRPVP_foodEnergyDrink",
	"BRPVP_playerLaunch",
	"BRPVP_bagSoldier",
	"BRPVP_carrier",
	"BRPVP_baseMine",
	"BRPVP_baseMineDefuse",
	"BRPVP_vehicleAmmo",  //110
	"BRP_kitBunkers",
	"BRP_kitAutoTurretLvl2",
	"BRPVP_turretUpgrade",
	"BRPVP_foodBurger",
	"BRPVP_xrayItem",
	"BRPVP_itemMagnet",
	"BRPVP_newsPaper",
	"BRPVP_uberPack",
	"BRPVP_bigFloor200",
	"BRPVP_bigFloorRemove",  //120
	"BRPVP_atmFix",
	"BRPVP_boxeItem",
	"BRPVP_selfRevive",
	"BRPVP_bodyChange",
	"BRPVP_vehicleTorque",
	"BRPVP_possession",
	"BRPVP_possessionStrong",
	"BRPVP_possessionPlayer",
	"BRPVP_uberAttack",
	"BRPVP_secCam", //130
	"BRPVP_trench",
	"BRPVP_baseBoxUpgrade",
	"BRPVP_minervaShot",
	"BRPVP_kriptonite",
	"BRPVP_kriptoniteRed",
	"BRPVP_divineFire",
	"BRPVP_atomicShot",
	"BRPVP_prideAtomicShot",
	"BRPVP_miraculousEyeDrop",
	"BRPVP_antiAtomicBomb", //140
	"BRPVP_mammothAmmo",
	"BRPVP_playerLaunchSuper",
	"BRPVP_voodooDoll",
	"BRPVP_goldBars"
];

if (isServer) then {
	BRPVP_allNoServer = [-2,0] select hasInterface;
	publicVariable "BRPVP_allNoServer";
	
	call compile preprocessFileLineNumbers "generalVariablesMap.sqf";
	call compile preprocessFileLineNumbers "noChangeVars.sqf";
	call compile preprocessFileLineNumbers "generalVariables.sqf";

	BRPVP_useTireAutoMoveToTimeLastVeh = BRPVP_useTireAutoMoveToTime max BRPVP_useTireAutoMoveToTimeLastVeh;

	//EARLY USED FUNCTIONS
	call compile preprocessFileLineNumbers "earlyUsedFunctions.sqf";

	BRPVP_allMissionObjectsCVL = [];
	BRPVP_allMissionObjectsCVLSegClass = [];
	BRPVP_allMissionObjectsCVLSegObjs = [];

	//CHECK FOR USE OF BRPVP MOD
	BRPVP_usingBrpvpMod = "BRPVP_C_T_supplyCrate_F" call BRPVP_classExists;
	BRPVP_modNoModRelation = [
		["C_IDAP_supplyCrate_F","BRPVP_C_IDAP_supplyCrate_F"],
		["Box_NATO_AmmoVeh_F","BRPVP_Box_NATO_AmmoVeh_F"],
		["Box_East_AmmoVeh_F","BRPVP_Box_East_AmmoVeh_F"],
		["Box_IND_AmmoVeh_F","BRPVP_Box_IND_AmmoVeh_F"],
		["Box_T_East_WpsSpecial_F","BRPVP_Box_T_East_WpsSpecial_F"],
		["C_T_supplyCrate_F","BRPVP_C_T_supplyCrate_F"],
		["Box_Syndicate_Ammo_F","BRPVP_Box_Syndicate_Ammo_F"],
		["Box_Syndicate_WpsLaunch_F","BRPVP_Box_Syndicate_WpsLaunch_F"]
	];

	//FILE PATHS
	if (BRPVP_usingBrpvpMod) then {
		BRPVP_missionRoot = "\BRPVP\";
		BRPVP_imagePrefix = "\BRPVP\";
		BRPVP_playSound3dPrefix = "BRPVP\";
	} else {
		BRPVP_missionRoot = str missionConfigFile select [0,count str missionConfigFile-15];
		BRPVP_imagePrefix = "";
		BRPVP_playSound3dPrefix = str missionConfigFile select [0,count str missionConfigFile-15];
	};
	BRPVP_missionRootNoMod = str missionConfigFile select [0,count str missionConfigFile-15];
	BRPVP_imagePrefixNoMod = "";
	BRPVP_playSound3dPrefixNoMod = str missionConfigFile select [0,count str missionConfigFile-15];
	BRPVP_missionRootNoModWIP = BRPVP_missionRootNoMod;
	BRPVP_imagePrefixNoModWIP = BRPVP_imagePrefixNoMod;
	BRPVP_playSound3dPrefixNoModWIP = BRPVP_playSound3dPrefixNoMod;

	//CHECK FOR RYAN ZOMBIES MOD
	BRPVP_rZedsRunning = "RyanZM_ModuleSpawn" call BRPVP_classExists;
	BRPVP_rZedsMainModel = "RyanZombieCivilian_F";
	if (BRPVP_rZedsRunning) then {
		{
			_x spawn {
				private _fncName = _this;
				private _init = time;
				waitUntil {!isNil _fncName || time-_init > 600};
				call compile preprocessfilelinenumbers format ["mods_fixes\RyanZombies\%1.sqf",_fncName];
			};
		} forEach [
			"RZ_fnc_zombie_canAttackVehicle",
			"RZ_fnc_NeutralizeVehicle",
			"RZ_fnc_zombie_attackVehicle",
			"RZ_fnc_zombie_throwVehicleAtTarget",
			"RZ_fnc_zombie_engageTarget"
		];
	};

	//CHECK FOR IMERSION CIGS MOD
	BRPVP_iCigsRunning = "murshun_cigs_cigpack" call BRPVP_classExists;
	if (BRPVP_iCigsRunning) then {
		BRPVP_iCigsAIObjects = [];
		{
			_x params ["_q","_c"];
			for "_i" from 1 to ceil _q do {BRPVP_iCigsAIObjects pushBack _c;};
		} forEach [
			[2,"murshun_cigs_matches"],
			[1,"murshun_cigs_cigpack"],
			[1,"murshun_cigs_lighter"],
			[2,"immersion_pops_poppack"],
			[2,"immersion_cigs_cigar0"],
			[10,"murshun_cigs_cig0"]
		];
		BRPVP_iCigsAIUse = [];
		{
			_x params ["_q","_c"];
			for "_i" from 1 to ceil _q do {BRPVP_iCigsAIUse pushBack _c;};
		} forEach [
			[2,"immersion_cigs_cigar0"],
			[1,"immersion_pops_pop0"],
			[10,"murshun_cigs_cig0"]
		];
	} else {
		BRPVP_iCigsAIObjects = [];
		BRPVP_iCigsAIUse = [];
	};

	BRPVP_atmClasses = ["Land_Atm_01_F","Land_Atm_02_F"];

	//CHECK AND REMOVE THOSE VARS, DONT CHANGE IT
	BRPVP_allowBuildingsAwayFromFlags = false; //ALLOW BUILDINGS AWAY FROM FLAGS, THEY WILL BE DELETED ON SERVER RESTART
	BRPVP_buildingAwayFromFlagEasyDestroy = false; //BUILDINGS AWAY FROM FLAG CAN BE DESTROYED WITH JUST A CLICK

	call compile preprocessFileLineNumbers "brpvp_zombies_config.sqf";
	call compile preprocessFileLineNumbers "brpvp_loot_config.sqf";
	call compile preprocessFileLineNumbers "map_specific\precalculated.sqf";
	call compile preprocessFileLineNumbers "server_specific\configurationsChanges.sqf";

	if (isServer && hasInterface) then {
		BRPVP_adminsStartsWithAllPerks = false;
		BRPVP_disableVehUseDays = [];
		BRPVP_usePaydAccess = false;
		BRPVP_admins pushBackUnique getPlayerUid player;
		BRPVP_restartTimes = [];
		BRPVP_xpToBuyAllPerks = 1000000;

		private _ss = player say3D "server_loading";
		BRPVP_stopElevatorSound = false;
		_ss spawn {
			private _svSound = ["mine_detector_01","mine_detector_02","mine_detector_03","mine_detector_04","mine_detector_05"];
			private _wList = [0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.2500,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.2500,0.5000];
			private _wait = selectRandom _wList;
			private _init = diag_tickTime;
			private _img = "none";
			["<img shadow='0' size='3.5' image='server_loading_1.paa'/>",0,0.25,120,0,0,482] spawn BIS_fnc_dynamicText;
			waitUntil {
				if (diag_tickTime-_init > _wait) then {
					_init = diag_tickTime;
					_wait = selectRandom _wList;
					_img = selectRandom (["server_loading_1.paa","server_loading_2.paa","server_loading_3.paa"]-[_img]);
					playSound selectRandom _svSound;
					["<img shadow='0' size='3.5' image='"+_img+"'/>",0,0.25,1,0,0,485] spawn BIS_fnc_dynamicText;
				};
				BRPVP_stopElevatorSound
			};
			["",0,0.25,600,0,0,485] spawn BIS_fnc_dynamicText;
			["",0,0.25,120,0,0,482] spawn BIS_fnc_dynamicText;
			deleteVehicle _this;

			waitUntil {player getVariable ["sok",false]};
			BRPVP_serverPlayerPrimeiroSokOk = true;
		};
	};

	if (!BRPVP_useComplexLocalBuildings) then {BRPVP_buildingHaveDoorListCVL = [];};

	if (!BRPVP_raidTrainingMissionRun) then {BRPVP_raidTrainingMapPosition = [];};
	if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {
		BRPVP_PVPAreas pushBack [BRPVP_raidTrainingMapPosition,500,{""}];
	};

	BRPVP_skyDiveMaxFlyTime = BRPVP_skyDiveMaxFlyTimeLevels select 0;

	BRPVP_combatTimeLength = BRPVP_combatTimeLengthNormal;

	BRPVP_AIMagazinesRemove append (BRPVP_moneyItems select 0);
	BRPVP_AIMagazinesRemove = BRPVP_AIMagazinesRemove arrayIntersect BRPVP_AIMagazinesRemove;

	BRPVP_customBaseBoxSizeUpgrade = BRPVP_customBaseBoxSizeUpgrade max BRPVP_customBaseBoxSize;
	BRPVP_maxBuildHeight = BRPVP_maxBuildHeight max 100;

	BRPVP_atualizaDebugPlayerIcon = selectRandom BRPVP_playersFaces;
	player setVariable ["brpvp_player_count_icon",BRPVP_atualizaDebugPlayerIcon,true];

	//ZOMBIES CLOTHES CODE
	BRPVP_zombiesUniforms = BRPVP_zombiesUniforms apply {
		if (_x isEqualType "") then {
			if (_x call BRPVP_classExists) then {_x} else {-1};
		} else {
			private _exist = (_x select 1) call BRPVP_classExists && (_x select 2) call BRPVP_classExists;
			if (_exist) then {[_x select 1,_x select 2]} else {-1};
		};
	};
	BRPVP_zombiesUniforms = BRPVP_zombiesUniforms-[-1];

	BRPVP_zedsMapViewDistance = BRPVP_zedsMapViewDistanceCfg;
	BRPVP_farmDoubleChance = 0;

	BRPVP_lostMoneyWhenDieMaxValor = (round(BRPVP_lostMoneyWhenDieMaxValor/BRPVP_lostMoneyWhenDieStep))*BRPVP_lostMoneyWhenDieStep;
	BRPVP_lostMoneyWhenDieMinPercentage = BRPVP_lostMoneyWhenDieMaxPercentage min BRPVP_lostMoneyWhenDieMinPercentage;
	BRPVP_lostMoneyWhenDieAliveTimeForMin = BRPVP_lostMoneyWhenDieAliveTimeForMin max 1;

	call compile preprocessFileLineNumbers "map_specific\traveler_aid.sqf";
	call compile preprocessFileLineNumbers "map_specific\custom_constructions.sqf";

	//REMOVE MISSING CLASSES FROM RARE LOOT
	{if !(_x call BRPVP_classExists) then {BRPVP_rareExtraLootInBoxA set [_forEachIndex,-1];};} forEach BRPVP_rareExtraLootInBoxA;
	BRPVP_rareExtraLootInBoxA = BRPVP_rareExtraLootInBoxA-[-1];
	BRPVP_vaultNumberCfg = (BRPVP_vaultNumberCfg max 0) min 10;
	BRPVP_vaultNumber = BRPVP_vaultNumberCfg;
	BRPVP_magnetHolderCargoLimitAllPools = BRPVP_magnetHolderCargoLimitAllPoolsCfg;
	BRPVP_magnetHolderCargoLimit = BRPVP_magnetHolderCargoLimitCfg;
	BRPVP_magnetHolderCargoLimitOnGround = BRPVP_magnetHolderCargoLimitOnGroundCfg max BRPVP_magnetHolderCargoLimitCfg;
	BRPVP_defendFortZombieReward = BRPVP_defendFortZombieReward*BRPVP_missionValueMult;
	BRPVP_defendFortAIReward = BRPVP_defendFortAIReward*BRPVP_missionValueMult;
	BRPVP_aiAttackBaseAttLim = (300*round (BRPVP_aiAttackBaseAttLim/300)) max 300;
	BRPVP_aiAttackBaseFactor = BRPVP_aiAttackBaseAttLim/300;
	BRPVP_pDamLim = 0.975;
	BRPVP_aiDamLim = 0.975;
	if (BRPVP_useRandomRespawnAllways) then {BRPVP_respawnPlaces = [];};
	if (BRPVP_pveMakeAllMapPve) then {BRPVP_pveMainAreasAll = [[[BRPVP_centroMapa,BRPVP_centroMapaRadius,"",10]]];};
	{_x sort true;} forEach BRPVP_flagCombinationAllowed;

	call compile preprocessFileLineNumbers "serverAndClientFunctions.sqf";
	call compile preprocessFileLineNumbers "brpvp_fpsBoost.sqf";
	call compile preprocessFileLineNumbers "server_code\server_insurancePlaces.sqf";
	setViewDistance BRPVP_viewDist;
	setObjectViewDistance BRPVP_viewObjsDist;
	if (isNil "BRPVP_setTerrainGridClient") then {setTerrainGrid BRPVP_terrainGrid;} else {setTerrainGrid BRPVP_setTerrainGridClient;};

	//IS SERVER BEGIN
	_serverInitStartTime = diag_tickTime;
	BRPVP_playerIgnitionFailCount = 20;
	publicVariable "BRPVP_playerIgnitionFailCount";
	EAST setFriend [EAST,1];
	EAST setFriend [CIVILIAN,1];
	EAST setFriend [WEST,0];
	EAST setFriend [INDEPENDENT,0];
	WEST setFriend [WEST,1];
	WEST setFriend [CIVILIAN,0];
	WEST setFriend [EAST,0];
	WEST setFriend [INDEPENDENT,0];
	INDEPENDENT setFriend [INDEPENDENT,1];
	INDEPENDENT setFriend [CIVILIAN,0];
	INDEPENDENT setFriend [EAST,0];
	INDEPENDENT setFriend [WEST,0];
	CIVILIAN setFriend [INDEPENDENT,0];
	CIVILIAN setFriend [CIVILIAN,1];
	CIVILIAN setFriend [EAST,1];
	CIVILIAN setFriend [WEST,0];
	BRPVP_timeMultiplier = (BRPVP_timeMultiplier max 1) min 48;
	setTimeMultiplier BRPVP_timeMultiplier;
	call compile preProcessFileLineNumbers "map_specific\server_buildings.sqf";
	call compile preProcessFileLineNumbers "BRPVP_server_code\servidor_init.sqf";
	enableEnvironment [false,false];

	//REPEAT IN 3 CASES (CLIENT, SERVER, HC)
	BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission+BRPVP_disableVehUseList;
	BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader+BRPVP_disableVehUseList;
	BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission arrayIntersect BRPVP_deniedVehiclesVehMission;
	BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader arrayIntersect BRPVP_deniedVehiclesBlackTrader;

	diag_log ("[BRPVP] SERVER STUFF LOADED IN "+str round (diag_tickTime-_serverInitStartTime)+" SECONDS! NOW STARTING CLIENTS...");
	sleep 10;

	//REMOTE TREES AND ROCKS FROM TRAVELING AID
	{
		_x params ["_pos","_rad","_label","_idx"];
		{
			_obj = _x;
			_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
			if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {_x hideObjectGlobal true;};
		} forEach nearestTerrainObjects [_pos,[],_rad,false];
	} forEach BRPVP_travelingAidPlaces;

	BRPVP_serverBelezinha = true;
	publicVariable "BRPVP_serverBelezinha";

	call compile preprocessFileLineNumbers "pmiss_off.sqf";
	if (BRPVP_useHC) then {call compile preprocessFileLineNumbers "hc_code\sv.sqf";} else {call compile preprocessFileLineNumbers "hc_code\hc_init.sqf";};
	//IS SERVER END
};

if (_isHc) then {
	//NOVO CODIGO
	waitUntil {!isNil "BRPVP_serverBelezinha"};
	BRPVP_lastScriptedQuakeTime = -10;
	
	//BRPVP_allNoServer = [-2,0] select hasInterface;
	//publicVariable "BRPVP_allNoServer";
	
	call compile preprocessFileLineNumbers "generalVariablesMap.sqf";
	call compile preprocessFileLineNumbers "noChangeVars.sqf";
	call compile preprocessFileLineNumbers "generalVariables.sqf";

	//BRPVP_useTireAutoMoveToTimeLastVeh = BRPVP_useTireAutoMoveToTime max BRPVP_useTireAutoMoveToTimeLastVeh;

	//EARLY USED FUNCTIONS
	call compile preprocessFileLineNumbers "earlyUsedFunctions.sqf";

	//BRPVP_allMissionObjectsCVL = [];
	//BRPVP_allMissionObjectsCVLSegClass = [];
	//BRPVP_allMissionObjectsCVLSegObjs = [];

	//CHECK FOR USE OF BRPVP MOD
	BRPVP_usingBrpvpMod = "BRPVP_C_T_supplyCrate_F" call BRPVP_classExists;
	BRPVP_modNoModRelation = [
		["C_IDAP_supplyCrate_F","BRPVP_C_IDAP_supplyCrate_F"],
		["Box_NATO_AmmoVeh_F","BRPVP_Box_NATO_AmmoVeh_F"],
		["Box_East_AmmoVeh_F","BRPVP_Box_East_AmmoVeh_F"],
		["Box_IND_AmmoVeh_F","BRPVP_Box_IND_AmmoVeh_F"],
		["Box_T_East_WpsSpecial_F","BRPVP_Box_T_East_WpsSpecial_F"],
		["C_T_supplyCrate_F","BRPVP_C_T_supplyCrate_F"],
		["Box_Syndicate_Ammo_F","BRPVP_Box_Syndicate_Ammo_F"],
		["Box_Syndicate_WpsLaunch_F","BRPVP_Box_Syndicate_WpsLaunch_F"]
	];

	//FILE PATHS
	if (BRPVP_usingBrpvpMod) then {
		BRPVP_missionRoot = "\BRPVP\";
		BRPVP_imagePrefix = "\BRPVP\";
		BRPVP_playSound3dPrefix = "BRPVP\";
	} else {
		BRPVP_missionRoot = str missionConfigFile select [0,count str missionConfigFile-15];
		BRPVP_imagePrefix = "";
		BRPVP_playSound3dPrefix = str missionConfigFile select [0,count str missionConfigFile-15];
	};
	BRPVP_missionRootNoMod = str missionConfigFile select [0,count str missionConfigFile-15];
	BRPVP_imagePrefixNoMod = "";
	BRPVP_playSound3dPrefixNoMod = str missionConfigFile select [0,count str missionConfigFile-15];
	BRPVP_missionRootNoModWIP = BRPVP_missionRootNoMod;
	BRPVP_imagePrefixNoModWIP = BRPVP_imagePrefixNoMod;
	BRPVP_playSound3dPrefixNoModWIP = BRPVP_playSound3dPrefixNoMod;

	//CHECK FOR RYAN ZOMBIES MOD
	BRPVP_rZedsRunning = "RyanZM_ModuleSpawn" call BRPVP_classExists;
	BRPVP_rZedsMainModel = "RyanZombieCivilian_F";
	if (BRPVP_rZedsRunning) then {
		{
			_x spawn {
				private _fncName = _this;
				private _init = time;
				waitUntil {!isNil _fncName || time-_init > 600};
				call compile preprocessfilelinenumbers format ["mods_fixes\RyanZombies\%1.sqf",_fncName];
			};
		} forEach [
			"RZ_fnc_zombie_canAttackVehicle",
			"RZ_fnc_NeutralizeVehicle",
			"RZ_fnc_zombie_attackVehicle",
			"RZ_fnc_zombie_throwVehicleAtTarget",
			"RZ_fnc_zombie_engageTarget"
		];
	};

	//CHECK FOR IMERSION CIGS MOD
	BRPVP_iCigsRunning = "murshun_cigs_cigpack" call BRPVP_classExists;
	if (BRPVP_iCigsRunning) then {
		BRPVP_iCigsAIObjects = [];
		{
			_x params ["_q","_c"];
			for "_i" from 1 to ceil _q do {BRPVP_iCigsAIObjects pushBack _c;};
		} forEach [
			[2,"murshun_cigs_matches"],
			[1,"murshun_cigs_cigpack"],
			[1,"murshun_cigs_lighter"],
			[2,"immersion_pops_poppack"],
			[2,"immersion_cigs_cigar0"],
			[10,"murshun_cigs_cig0"]
		];
		BRPVP_iCigsAIUse = [];
		{
			_x params ["_q","_c"];
			for "_i" from 1 to ceil _q do {BRPVP_iCigsAIUse pushBack _c;};
		} forEach [
			[2,"immersion_cigs_cigar0"],
			[1,"immersion_pops_pop0"],
			[10,"murshun_cigs_cig0"]
		];
	} else {
		BRPVP_iCigsAIObjects = [];
		BRPVP_iCigsAIUse = [];
	};

	BRPVP_atmClasses = ["Land_Atm_01_F","Land_Atm_02_F"];

	//CHECK AND REMOVE THOSE VARS, DONT CHANGE IT
	BRPVP_allowBuildingsAwayFromFlags = false; //ALLOW BUILDINGS AWAY FROM FLAGS, THEY WILL BE DELETED ON SERVER RESTART
	BRPVP_buildingAwayFromFlagEasyDestroy = false; //BUILDINGS AWAY FROM FLAG CAN BE DESTROYED WITH JUST A CLICK

	call compile preprocessFileLineNumbers "brpvp_zombies_config.sqf";
	call compile preprocessFileLineNumbers "brpvp_loot_config.sqf";
	call compile preprocessFileLineNumbers "map_specific\precalculated.sqf";
	call compile preprocessFileLineNumbers "server_specific\configurationsChanges.sqf";

	if (!BRPVP_useHC) exitWith {};

	/*
	if (isServer && hasInterface) then {
		BRPVP_adminsStartsWithAllPerks = false;
		BRPVP_disableVehUseDays = [];
		BRPVP_usePaydAccess = false;
		BRPVP_admins pushBackUnique getPlayerUid player;
		BRPVP_restartTimes = [];

		private _ss = player say3D "server_loading";
		BRPVP_stopElevatorSound = false;
		_ss spawn {
			private _svSound = ["mine_detector_01","mine_detector_02","mine_detector_03","mine_detector_04","mine_detector_05"];
			private _wList = [0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.2500,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.2500,0.5000];
			private _wait = selectRandom _wList;
			private _init = diag_tickTime;
			private _img = "none";
			["<img shadow='0' size='3.5' image='server_loading_1.paa'/>",0,0.25,120,0,0,482] spawn BIS_fnc_dynamicText;
			waitUntil {
				if (diag_tickTime-_init > _wait) then {
					_init = diag_tickTime;
					_wait = selectRandom _wList;
					_img = selectRandom (["server_loading_1.paa","server_loading_2.paa","server_loading_3.paa"]-[_img]);
					playSound selectRandom _svSound;
					["<img shadow='0' size='3.5' image='"+_img+"'/>",0,0.25,1,0,0,485] spawn BIS_fnc_dynamicText;
				};
				BRPVP_stopElevatorSound
			};
			["",0,0.25,600,0,0,485] spawn BIS_fnc_dynamicText;
			["",0,0.25,120,0,0,482] spawn BIS_fnc_dynamicText;
			deleteVehicle _this;

			waitUntil {player getVariable ["sok",false]};
			BRPVP_serverPlayerPrimeiroSokOk = true;
		};
	};
	*/

	if (!BRPVP_useComplexLocalBuildings) then {BRPVP_buildingHaveDoorListCVL = [];};

	if (!BRPVP_raidTrainingMissionRun) then {BRPVP_raidTrainingMapPosition = [];};
	if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {
		BRPVP_PVPAreas pushBack [BRPVP_raidTrainingMapPosition,500,{""}];
	};

	BRPVP_skyDiveMaxFlyTime = BRPVP_skyDiveMaxFlyTimeLevels select 0;

	BRPVP_combatTimeLength = BRPVP_combatTimeLengthNormal;

	BRPVP_AIMagazinesRemove append (BRPVP_moneyItems select 0);
	BRPVP_AIMagazinesRemove = BRPVP_AIMagazinesRemove arrayIntersect BRPVP_AIMagazinesRemove;

	BRPVP_customBaseBoxSizeUpgrade = BRPVP_customBaseBoxSizeUpgrade max BRPVP_customBaseBoxSize;
	BRPVP_maxBuildHeight = BRPVP_maxBuildHeight max 100;

	BRPVP_atualizaDebugPlayerIcon = selectRandom BRPVP_playersFaces;
	player setVariable ["brpvp_player_count_icon",BRPVP_atualizaDebugPlayerIcon,true];

	//ZOMBIES CLOTHES CODE
	BRPVP_zombiesUniforms = BRPVP_zombiesUniforms apply {
		if (_x isEqualType "") then {
			if (_x call BRPVP_classExists) then {_x} else {-1};
		} else {
			private _exist = (_x select 1) call BRPVP_classExists && (_x select 2) call BRPVP_classExists;
			if (_exist) then {[_x select 1,_x select 2]} else {-1};
		};
	};
	BRPVP_zombiesUniforms = BRPVP_zombiesUniforms-[-1];

	BRPVP_zedsMapViewDistance = BRPVP_zedsMapViewDistanceCfg;
	BRPVP_farmDoubleChance = 0;

	BRPVP_lostMoneyWhenDieMaxValor = (round(BRPVP_lostMoneyWhenDieMaxValor/BRPVP_lostMoneyWhenDieStep))*BRPVP_lostMoneyWhenDieStep;
	BRPVP_lostMoneyWhenDieMinPercentage = BRPVP_lostMoneyWhenDieMaxPercentage min BRPVP_lostMoneyWhenDieMinPercentage;
	BRPVP_lostMoneyWhenDieAliveTimeForMin = BRPVP_lostMoneyWhenDieAliveTimeForMin max 1;

	//call compile preprocessFileLineNumbers "map_specific\traveler_aid.sqf";
	//call compile preprocessFileLineNumbers "map_specific\custom_constructions.sqf";

	//REMOVE MISSING CLASSES FROM RARE LOOT
	{if !(_x call BRPVP_classExists) then {BRPVP_rareExtraLootInBoxA set [_forEachIndex,-1];};} forEach BRPVP_rareExtraLootInBoxA;
	BRPVP_rareExtraLootInBoxA = BRPVP_rareExtraLootInBoxA-[-1];
	BRPVP_vaultNumberCfg = (BRPVP_vaultNumberCfg max 0) min 50;
	BRPVP_vaultNumber = BRPVP_vaultNumberCfg;
	BRPVP_magnetHolderCargoLimitAllPools = BRPVP_magnetHolderCargoLimitAllPoolsCfg;
	BRPVP_magnetHolderCargoLimit = BRPVP_magnetHolderCargoLimitCfg;
	BRPVP_magnetHolderCargoLimitOnGround = BRPVP_magnetHolderCargoLimitOnGroundCfg max BRPVP_magnetHolderCargoLimitCfg;
	BRPVP_defendFortZombieReward = BRPVP_defendFortZombieReward*BRPVP_missionValueMult;
	BRPVP_defendFortAIReward = BRPVP_defendFortAIReward*BRPVP_missionValueMult;
	BRPVP_aiAttackBaseAttLim = (300*round (BRPVP_aiAttackBaseAttLim/300)) max 300;
	BRPVP_aiAttackBaseFactor = BRPVP_aiAttackBaseAttLim/300;
	BRPVP_pDamLim = 0.975;
	BRPVP_aiDamLim = 0.975;
	if (BRPVP_useRandomRespawnAllways) then {BRPVP_respawnPlaces = [];};
	if (BRPVP_pveMakeAllMapPve) then {BRPVP_pveMainAreasAll = [[[BRPVP_centroMapa,BRPVP_centroMapaRadius,"",10]]];};
	{_x sort true;} forEach BRPVP_flagCombinationAllowed;

	call compile preprocessFileLineNumbers "serverAndClientFunctions.sqf";
	//call compile preprocessFileLineNumbers "brpvp_fpsBoost.sqf";
	//call compile preprocessFileLineNumbers "server_code\server_insurancePlaces.sqf";
	//setViewDistance BRPVP_viewDist;
	//setObjectViewDistance BRPVP_viewObjsDist;
	//if (isNil "BRPVP_setTerrainGridClient") then {setTerrainGrid BRPVP_terrainGrid;} else {setTerrainGrid BRPVP_setTerrainGridClient;};

	//IS SERVER BEGIN
	/*
	_serverInitStartTime = diag_tickTime;
	BRPVP_playerIgnitionFailCount = 20;
	publicVariable "BRPVP_playerIgnitionFailCount";
	EAST setFriend [EAST,1];
	EAST setFriend [CIVILIAN,1];
	EAST setFriend [WEST,0];
	EAST setFriend [INDEPENDENT,0];
	WEST setFriend [WEST,1];
	WEST setFriend [CIVILIAN,0];
	WEST setFriend [EAST,0];
	WEST setFriend [INDEPENDENT,0];
	INDEPENDENT setFriend [INDEPENDENT,1];
	INDEPENDENT setFriend [CIVILIAN,0];
	INDEPENDENT setFriend [EAST,0];
	INDEPENDENT setFriend [WEST,0];
	CIVILIAN setFriend [INDEPENDENT,0];
	CIVILIAN setFriend [CIVILIAN,1];
	CIVILIAN setFriend [EAST,1];
	CIVILIAN setFriend [WEST,0];
	BRPVP_timeMultiplier = (BRPVP_timeMultiplier max 1) min 48;
	setTimeMultiplier BRPVP_timeMultiplier;
	call compile preProcessFileLineNumbers "map_specific\server_buildings.sqf";
	call compile preProcessFileLineNumbers "BRPVP_server_code\servidor_init.sqf";
	enableEnvironment [false,false];
	*/

	//FROM server_init.sqf
	call compile preprocessFileLineNumbers "client_code\itemMarketVariables.sqf";

	//REPEAT IN 3 CASES (CLIENT, SERVER, HC)
	BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission+BRPVP_disableVehUseList;
	BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader+BRPVP_disableVehUseList;
	BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission arrayIntersect BRPVP_deniedVehiclesVehMission;
	BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader arrayIntersect BRPVP_deniedVehiclesBlackTrader;

	//diag_log ("[BRPVP] SERVER STUFF LOADED IN "+str round (diag_tickTime-_serverInitStartTime)+" SECONDS! NOW STARTING CLIENTS...");
	//sleep 10;

	//REMOTE TREES AND ROCKS FROM TRAVELING AID
	/*
	{
		_x params ["_pos","_rad","_label","_idx"];
		{
			_obj = _x;
			_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
			if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {_x hideObjectGlobal true;};
		} forEach nearestTerrainObjects [_pos,[],_rad,false];
	} forEach BRPVP_travelingAidPlaces;
	*/

	//BRPVP_serverBelezinha = true;
	//publicVariable "BRPVP_serverBelezinha";

	call compile preprocessFileLineNumbers "pmiss_off.sqf";
	call compile preprocessFileLineNumbers "hc_code\hc.sqf";
	//IS SERVER END
};

if (hasInterface) then {
	if (isServer) then {
		//==================================================================================
		//SET F2 AND F3 MENU SIZE
		BRPVP_cfgMenuLinesData = [[47,55,70,85,100],[5,4,3,2,1]];
		private _mlIdx = (BRPVP_cfgMenuLinesData select 0) find round (100*(getResolution select 5));
		BRPVP_cfgMenuLines = if (_mlIdx isEqualTo -1) then {3} else {BRPVP_cfgMenuLinesData select 1 select _mlIdx};

		//DISCONNECT IF BANNED
		private _playerOk = true;
		[player,getPlayerUID player] remoteExecCall ["BRPVP_checkForBan",2];
		waitUntil {!isNil "BRPVP_playerNotBaned"};
		if (!BRPVP_playerNotBaned) exitWith {
			endMission "YouIsBanned";
			diag_log "[BRPVP] PLAYER IS BANNED!";
			_playerOk = false;
		};
		if (!_playerOk) exitWith {};

		//CREATE LOGIN CAM
		uiSleep 0.5;
		showCinemaBorder false;
		private _cPos = AGLToASL [0,0,750];
		private _cTarget = [100,100,_cPos select 2];
		if ((BRPVP_allFlags-[objNull]) isNotEqualTo []) then {
			private _allFlags = [];
			{_allFlags pushBack [{_x getVariable ["id_bd",-1] > -1} count nearestObjects [_x,["Building"],200,true],_x];} forEach (BRPVP_allFlags-[objNull]);
			_allFlags sort false;
			private _flag = _allFlags select floor ((random ((count _allFlags)^(1/1.5)))^1.5) select 1;
			private _a = random 360;
			_cPos = getPosASL _flag vectorAdd [50*sin _a,50*sin _a,500];
			_cTarget = ASLToAGL getPosASL _flag;
		};

		//CREATE LOGIN CAM
		player setUnitFreefallHeight -1;
		[player,true] remoteExecCall ["hideObjectGlobal",2];
		BRPVP_stopElevatorSound = true;
		playSound "hackFail";
		player setPosASL BRPVP_playerSpawnedPosition;
		BRPVP_loginCam = "camera" camCreate ASLToAGL _cPos;
		BRPVP_loginCam camSetFocus [-1,-1];
		BRPVP_loginCam camSetTarget _cTarget;
		BRPVP_loginCam cameraEffect ["INTERNAL","BACK"];
		BRPVP_loginCam camCommit 0;

		cutText ["","BLACK IN",1];
		uiSleep 1;
		playSound "logo_01";
		["<img shadow='0' size='6' image='brpvp_loading.paa'/>",0,0.2,1000000,0,0,1173] spawn BIS_fnc_dynamicText;
		uiSleep 1.5;

		waitUntil {!isNil "BRPVP_disableVehUseList"};
		waitUntil {!isNil "BRPVP_noDamageVehList"};

		enableEnvironment [true,true];
		//==================================================================================

		//=======================================================================
		BRPVP_minHeightParachuteOpenUse = BRPVP_minHeightParachuteOpenNormal;

		//SET EXTRA BANK SPACE
		BRPVP_getExtraBankReturn = nil;
		[clientOwner,getPlayerUID player] remoteExecCall ["BRPVP_getExtraBankSV",2];
		waitUntil {!isNil "BRPVP_getExtraBankReturn"};
		BRPVP_totalMoneyInBank = BRPVP_totalMoneyInBank+BRPVP_getExtraBankReturn;

		//SET SPECIAL CITY RESPAWN
		BRPVP_getForceCityRespawnReturn = nil;
		[clientOwner,getPlayerUID player] remoteExecCall ["BRPVP_getForceCityRespawnSV",2];
		waitUntil {!isNil "BRPVP_getForceCityRespawnReturn"};
		if (BRPVP_getForceCityRespawnReturn) then {
			BRPVP_useRandomRespawnAllways = false;
			BRPVP_useRandomRespawnWhenSuicide = false;
			BRPVP_respawnPlaces = +BRPVP_respawnPlacesSpecial;
			BRPVP_afterDieMaxSpawnCounterInSeconds = 30;
			BRPVP_afterDieMaxSpawnCounterInSecondsIfPlayerKill = 60;
		} else {
			BRPVP_respawnPlaces = +BRPVP_respawnPlacesNormal;
		};

		//GET CUSTOM SPOT LIMIT
		BRPVP_getForceSpotLimitReturn = nil;
		[clientOwner,getPlayerUID player] remoteExecCall ["BRPVP_getForceSpotLimitSV",2];
		waitUntil {!isNil "BRPVP_getForceSpotLimitReturn"};
		if (BRPVP_getForceSpotLimitReturn > 0) then {BRPVP_moneyOnHandToSpot = BRPVP_getForceSpotLimitReturn;};
		//=======================================================================

		//=================================================================
		//REPEAT IN 3 CASES (CLIENT, SERVER, HC)
		BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission+BRPVP_disableVehUseList;
		BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader+BRPVP_disableVehUseList;
		BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission arrayIntersect BRPVP_deniedVehiclesVehMission;
		BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader arrayIntersect BRPVP_deniedVehiclesBlackTrader;

		BRPVP_virtualGarageTimeToStoreCfg = BRPVP_virtualGarageTimeToStore;
		BRPVP_personalAtmRateCfg = BRPVP_personalAtmRate;
		BRPVP_allowLandAutoPilotCfg = BRPVP_allowLandAutoPilot;
		BRPVP_dukeNukemServiceDelayCfg = BRPVP_dukeNukemServiceDelay;

		player setVariable ["nm",name player,true];
		player setVariable ["sok",false,true];
		player setVariable ["id",getPlayerUID player,true];
		player setVariable ["god",false,true];
		player setVariable ["brpvp_god_admin",false,true];
		player setVariable ["cmb",false,true];
		player setVariable ["veh",objNull,true];
		player setVariable ["cmv",cameraView,true];
		player setVariable ["dstp",1,true];
		player setVariable ["bui",objNull,true];
		player setVariable ["owt",[],true];
		player setVariable ["brpvp_fps",diag_fps,true];
		player setVariable ["brpvp_vd",BRPVP_viewDist,2];
		player setVariable ["brpvp_machine_id",clientOwner,true];
		player setVariable ["brpvp_my_flag_state",0,true];
		player setVariable ["brpvp_carry_objs",[],[clientOwner,2]];
		player setVariable ["brpvp_specting",objNull,2];
		player setVariable ["brpvp_spected_by",[]];
		player setVariable ["brpvp_vault_perc",[0,0,"#FFFFFF"],true];
		player setVariable ["brpvp_ping",-1];
		player setVariable ["brpvp_real_ping",-1];
		player setVariable ["brpvp_vision_mode",[0,0,objNull,[]]];
		player setVariable ["brpvp_on_bus",false,true];
		player setVariable ["brpvp_ai_simu_dist",BRPVP_aiSimuDistOnFoot,2];
		player setVariable ["brpvp_mafiwao",[[],false],true];
		player setVariable ["brpvp_extra_protection",false,true];
		player setVariable ["brpvp_is_master",false,true];
		enableRadio false;
		enableSentences false;

		//CONFIGURE CHANNELS
		0 enableChannel [false,false];
		1 enableChannel [true,BRPVP_enableSideVoice];
		2 enableChannel [false,false];
		3 enableChannel [true,true];
		4 enableChannel [true,true];
		5 enableChannel [true,true];
		//=================================================================

		//=================================================================
		player setVariable ["brpvp_snOk",call BRPVP_checkIfOk,true];
		player call BRPVP_pelaUnidade;
		player linkItem "ItemMap";
		if (isNil "BRPVP_usePaydAccess") then {BRPVP_usePaydAccess = false;};
		if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {{_x hideObject true;} forEach BRPVP_raidTrainingObjsToClean;};
		//call compile preprocessFileLineNumbers "pmiss_off.sqf";
		call compile preprocessFileLineNumbers "client_code\playerInit.sqf";
		//=================================================================
	} else {
		waitUntil {
			diag_log "[BRPVP] Wait for time > 0.";
			time > 0
		};

		call compile preprocessFileLineNumbers "generalVariablesMap.sqf";
		call compile preprocessFileLineNumbers "noChangeVars.sqf";
		call compile preprocessFileLineNumbers "generalVariables.sqf";

		BRPVP_useTireAutoMoveToTimeLastVeh = BRPVP_useTireAutoMoveToTime max BRPVP_useTireAutoMoveToTimeLastVeh;

		_playerOk = true;

		//==================================================================================
		//SET F2 AND F3 MENU SIZE
		BRPVP_cfgMenuLinesData = [[47,55,70,85,100],[5,4,3,2,1]];
		private _mlIdx = (BRPVP_cfgMenuLinesData select 0) find round (100*(getResolution select 5));
		BRPVP_cfgMenuLines = if (_mlIdx isEqualTo -1) then {3} else {BRPVP_cfgMenuLinesData select 1 select _mlIdx};

		//DISCONNECT IF SERVER LOADING
		BRPVP_playerSpawnedPosition = getPosASL player;
		if (isNil "BRPVP_serverBelezinha" || isNil "BRPVP_HC1ClientOk" || isNil "BRPVP_ServerMissionsOk") then {
			waitUntil {!isNil "BRPVP_isPlayerHosted" && !isNil "BRPVP_playerServerUID"};
			if (BRPVP_isPlayerHosted || true) then {
				player setUnitFreefallHeight 10000;
				player allowDamage false;
				call compile preprocessFileLineNumbers "playerServerLoby.sqf";
				player switchMove "";

				private _ss = player say3D "server_loading";
				private _svSound = ["mine_detector_01","mine_detector_02","mine_detector_03","mine_detector_04","mine_detector_05"];
				private _wList = [0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.2500,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.0125,0.0250,0.0375,0.0500,0.0635,0.0750,0.0875,0.1000,0.2500,0.5000];
				private _wait = selectRandom _wList;
				private _init = diag_tickTime;
				private _img = "none";
				["<img shadow='0' size='3.5' image='server_loading_1.paa'/>",0,0.25,120,0,0,482] spawn BIS_fnc_dynamicText;
				waitUntil {
					if (diag_tickTime-_init > _wait) then {
						_init = diag_tickTime;
						_wait = selectRandom _wList;
						_img = selectRandom (["server_loading_1.paa","server_loading_2.paa","server_loading_3.paa"]-[_img]);
						playSound selectRandom _svSound;
						["<img shadow='0' size='3.5' image='"+_img+"'/>",0,0.25,1,0,0,485] spawn BIS_fnc_dynamicText;
					};
					!(isNil "BRPVP_serverBelezinha" || isNil "BRPVP_HC1ClientOk" || isNil "BRPVP_ServerMissionsOk")
				};
				["",0,0.25,600,0,0,485] spawn BIS_fnc_dynamicText;
				["",0,0.25,120,0,0,482] spawn BIS_fnc_dynamicText;
				deleteVehicle _ss;
			} else {
				endMission "WaitServer";
				diag_log "[BRPVP] SERVER LOADING!";
				_playerOk = false;
			};
		};
		if (!_playerOk) exitWith {};

		//DISCONNECT IF PLAYER IGNITION FAIL
		private _count = 0;
		waitUntil {!isNil "BRPVP_playerIgnitionFailCount"};
		waitUntil {
			private _isNull = isNull player;
			diag_log ("[BRPVP ISNULL PLAYER A] "+str _isNull);
			if (_isNull) then {_count = _count+1;};
			if (_count >= BRPVP_playerIgnitionFailCount) exitWith {
				endMission "PlayerNotOk";
				diag_log "[BRPVP] PLAYER IGNITION FAIL!";
				_playerOk = false;
				true
			};
			uiSleep 0.2;
			!_isNull
		};
		if (!_playerOk) exitWith {};
		player allowDamage false;
		[player,true] remoteExecCall ["hideObjectGlobal",2];
		player setCaptive true;

		//DISCONNECT IF BANNED
		[player,getPlayerUID player] remoteExecCall ["BRPVP_checkForBan",2];
		waitUntil {!isNil "BRPVP_playerNotBaned"};
		if (!BRPVP_playerNotBaned) exitWith {
			endMission "YouIsBanned";
			diag_log "[BRPVP] PLAYER IS BANNED!";
			_playerOk = false;
		};
		if (!_playerOk) exitWith {};

		//DISCONNECT IF MISSION END
		if (!isNil "BRPVP_terminaMissao" && {BRPVP_terminaMissao}) exitWith {
			endMission "ServerRestart";
			diag_log "[BRPVP] SERVER MISSION OFF (RESTARTING)!";
			_playerOk = false;
		};
		if (!_playerOk) exitWith {};

		//CREATE LOGIN CAM
		uiSleep 0.5;
		showCinemaBorder false;
		private _cPos = AGLToASL [0,0,750];
		private _cTarget = [100,100,_cPos select 2];
		if ((BRPVP_allFlags-[objNull]) isNotEqualTo []) then {
			private _allFlags = [];
			{_allFlags pushBack [{_x getVariable ["id_bd",-1] > -1} count nearestObjects [_x,["Building"],200,true],_x];} forEach (BRPVP_allFlags-[objNull]);
			_allFlags sort false;
			private _flag = _allFlags select floor ((random ((count _allFlags)^(1/1.5)))^1.5) select 1;
			private _a = random 360;
			_cPos = getPosASL _flag vectorAdd [50*sin _a,50*sin _a,500];
			_cTarget = ASLToAGL getPosASL _flag;
		};

		//CREATE LOGIN CAM
		if (BRPVP_isPlayerHosted || true) then {
			player setUnitFreefallHeight -1;
			playSound "hackFail";
			player setPosASL BRPVP_playerSpawnedPosition;
		};
		BRPVP_loginCam = "camera" camCreate ASLToAGL _cPos;
		BRPVP_loginCam camSetFocus [-1,-1];
		BRPVP_loginCam camSetTarget _cTarget;
		BRPVP_loginCam cameraEffect ["INTERNAL","BACK"];
		BRPVP_loginCam camCommit 0;

		cutText ["","BLACK IN",1];
		uiSleep 1;
		playSound "logo_01";
		["<img shadow='0' size='6' image='brpvp_loading.paa'/>",0,0.2,1000000,0,0,1173] spawn BIS_fnc_dynamicText;
		uiSleep 1;

		waitUntil {!isNil "BRPVP_disableVehUseList"};
		waitUntil {!isNil "BRPVP_noDamageVehList"};

		enableEnvironment [true,true];
		//==================================================================================

		if (!_playerOk) exitWith {};

		//EARLY USED FUNCTIONS
		call compile preprocessFileLineNumbers "earlyUsedFunctions.sqf";

		BRPVP_allMissionObjectsCVL = [];
		BRPVP_allMissionObjectsCVLSegClass = [];
		BRPVP_allMissionObjectsCVLSegObjs = [];

		//CHECK FOR USE OF BRPVP MOD
		BRPVP_usingBrpvpMod = "BRPVP_C_T_supplyCrate_F" call BRPVP_classExists;
		BRPVP_modNoModRelation = [
			["C_IDAP_supplyCrate_F","BRPVP_C_IDAP_supplyCrate_F"],
			["Box_NATO_AmmoVeh_F","BRPVP_Box_NATO_AmmoVeh_F"],
			["Box_East_AmmoVeh_F","BRPVP_Box_East_AmmoVeh_F"],
			["Box_IND_AmmoVeh_F","BRPVP_Box_IND_AmmoVeh_F"],
			["Box_T_East_WpsSpecial_F","BRPVP_Box_T_East_WpsSpecial_F"],
			["C_T_supplyCrate_F","BRPVP_C_T_supplyCrate_F"],
			["Box_Syndicate_Ammo_F","BRPVP_Box_Syndicate_Ammo_F"],
			["Box_Syndicate_WpsLaunch_F","BRPVP_Box_Syndicate_WpsLaunch_F"]
		];

		//FILE PATHS
		if (BRPVP_usingBrpvpMod) then {
			BRPVP_missionRoot = "\BRPVP\";
			BRPVP_imagePrefix = "\BRPVP\";
			BRPVP_playSound3dPrefix = "BRPVP\";
		} else {
			BRPVP_missionRoot = str missionConfigFile select [0,count str missionConfigFile-15];
			BRPVP_imagePrefix = "";
			BRPVP_playSound3dPrefix = str missionConfigFile select [0,count str missionConfigFile-15];
		};
		BRPVP_missionRootNoMod = str missionConfigFile select [0,count str missionConfigFile-15];
		BRPVP_imagePrefixNoMod = "";
		BRPVP_playSound3dPrefixNoMod = str missionConfigFile select [0,count str missionConfigFile-15];
		BRPVP_missionRootNoModWIP = BRPVP_missionRootNoMod;
		BRPVP_imagePrefixNoModWIP = BRPVP_imagePrefixNoMod;
		BRPVP_playSound3dPrefixNoModWIP = BRPVP_playSound3dPrefixNoMod;

		//CHECK FOR RYAN ZOMBIES MOD
		BRPVP_rZedsRunning = "RyanZM_ModuleSpawn" call BRPVP_classExists;
		BRPVP_rZedsMainModel = "RyanZombieCivilian_F";
		if (BRPVP_rZedsRunning) then {
			{
				_x spawn {
					private _fncName = _this;
					private _init = time;
					waitUntil {!isNil _fncName || time-_init > 600};
					call compile preprocessfilelinenumbers format ["mods_fixes\RyanZombies\%1.sqf",_fncName];
				};
			} forEach [
				"RZ_fnc_zombie_canAttackVehicle",
				"RZ_fnc_NeutralizeVehicle",
				"RZ_fnc_zombie_attackVehicle",
				"RZ_fnc_zombie_throwVehicleAtTarget",
				"RZ_fnc_zombie_engageTarget"
			];
		};

		//CHECK FOR IMERSION CIGS MOD
		BRPVP_iCigsRunning = "murshun_cigs_cigpack" call BRPVP_classExists;
		if (BRPVP_iCigsRunning) then {
			BRPVP_iCigsAIObjects = [];
			{
				_x params ["_q","_c"];
				for "_i" from 1 to ceil _q do {BRPVP_iCigsAIObjects pushBack _c;};
			} forEach [
				[2,"murshun_cigs_matches"],
				[1,"murshun_cigs_cigpack"],
				[1,"murshun_cigs_lighter"],
				[2,"immersion_pops_poppack"],
				[2,"immersion_cigs_cigar0"],
				[10,"murshun_cigs_cig0"]
			];
			BRPVP_iCigsAIUse = [];
			{
				_x params ["_q","_c"];
				for "_i" from 1 to ceil _q do {BRPVP_iCigsAIUse pushBack _c;};
			} forEach [
				[2,"immersion_cigs_cigar0"],
				[1,"immersion_pops_pop0"],
				[10,"murshun_cigs_cig0"]
			];
		} else {
			BRPVP_iCigsAIObjects = [];
			BRPVP_iCigsAIUse = [];
		};

		BRPVP_atmClasses = ["Land_Atm_01_F","Land_Atm_02_F"];

		//CHECK AND REMOVE THOSE VARS, DONT CHANGE IT
		BRPVP_allowBuildingsAwayFromFlags = false; //ALLOW BUILDINGS AWAY FROM FLAGS, THEY WILL BE DELETED ON SERVER RESTART
		BRPVP_buildingAwayFromFlagEasyDestroy = false; //BUILDINGS AWAY FROM FLAG CAN BE DESTROYED WITH JUST A CLICK

		call compile preprocessFileLineNumbers "brpvp_zombies_config.sqf";
		call compile preprocessFileLineNumbers "brpvp_loot_config.sqf";
		call compile preprocessFileLineNumbers "map_specific\precalculated.sqf";
		call compile preprocessFileLineNumbers "server_specific\configurationsChanges.sqf";

		if (BRPVP_isPlayerHosted) then {
			BRPVP_disableVehUseDays = [];
			BRPVP_usePaydAccess = false;
			BRPVP_admins pushBackUnique BRPVP_playerServerUID;
			BRPVP_restartTimes = [];
			BRPVP_xpToBuyAllPerks = 1000000;
		};

		if (!BRPVP_useComplexLocalBuildings) then {BRPVP_buildingHaveDoorListCVL = [];};

		if (!BRPVP_raidTrainingMissionRun) then {BRPVP_raidTrainingMapPosition = [];};
		if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {
			BRPVP_PVPAreas pushBack [BRPVP_raidTrainingMapPosition,500,{""}];
		};

		BRPVP_skyDiveMaxFlyTime = BRPVP_skyDiveMaxFlyTimeLevels select 0;

		BRPVP_combatTimeLength = BRPVP_combatTimeLengthNormal;

		BRPVP_AIMagazinesRemove append (BRPVP_moneyItems select 0);
		BRPVP_AIMagazinesRemove = BRPVP_AIMagazinesRemove arrayIntersect BRPVP_AIMagazinesRemove;

		BRPVP_customBaseBoxSizeUpgrade = BRPVP_customBaseBoxSizeUpgrade max BRPVP_customBaseBoxSize;
		BRPVP_maxBuildHeight = BRPVP_maxBuildHeight max 100;

		BRPVP_atualizaDebugPlayerIcon = selectRandom BRPVP_playersFaces;
		player setVariable ["brpvp_player_count_icon",BRPVP_atualizaDebugPlayerIcon,true];

		//ZOMBIES CLOTHES CODE
		BRPVP_zombiesUniforms = BRPVP_zombiesUniforms apply {
			if (_x isEqualType "") then {
				if (_x call BRPVP_classExists) then {_x} else {-1};
			} else {
				private _exist = (_x select 1) call BRPVP_classExists && (_x select 2) call BRPVP_classExists;
				if (_exist) then {[_x select 1,_x select 2]} else {-1};
			};
		};
		BRPVP_zombiesUniforms = BRPVP_zombiesUniforms-[-1];

		BRPVP_zedsMapViewDistance = BRPVP_zedsMapViewDistanceCfg;
		BRPVP_farmDoubleChance = 0;

		BRPVP_lostMoneyWhenDieMaxValor = (round(BRPVP_lostMoneyWhenDieMaxValor/BRPVP_lostMoneyWhenDieStep))*BRPVP_lostMoneyWhenDieStep;
		BRPVP_lostMoneyWhenDieMinPercentage = BRPVP_lostMoneyWhenDieMaxPercentage min BRPVP_lostMoneyWhenDieMinPercentage;
		BRPVP_lostMoneyWhenDieAliveTimeForMin = BRPVP_lostMoneyWhenDieAliveTimeForMin max 1;

		//=======================================================================
		BRPVP_minHeightParachuteOpenUse = BRPVP_minHeightParachuteOpenNormal;

		//SET EXTRA BANK SPACE
		BRPVP_getExtraBankReturn = nil;
		[clientOwner,getPlayerUID player] remoteExecCall ["BRPVP_getExtraBankSV",2];
		waitUntil {!isNil "BRPVP_getExtraBankReturn"};
		BRPVP_totalMoneyInBank = BRPVP_totalMoneyInBank+BRPVP_getExtraBankReturn;

		//SET SPECIAL CITY RESPAWN
		BRPVP_getForceCityRespawnReturn = nil;
		[clientOwner,getPlayerUID player] remoteExecCall ["BRPVP_getForceCityRespawnSV",2];
		waitUntil {!isNil "BRPVP_getForceCityRespawnReturn"};
		if (BRPVP_getForceCityRespawnReturn) then {
			BRPVP_useRandomRespawnAllways = false;
			BRPVP_useRandomRespawnWhenSuicide = false;
			BRPVP_respawnPlaces = +BRPVP_respawnPlacesSpecial;
			BRPVP_afterDieMaxSpawnCounterInSeconds = 30;
			BRPVP_afterDieMaxSpawnCounterInSecondsIfPlayerKill = 60;
		} else {
			BRPVP_respawnPlaces = +BRPVP_respawnPlacesNormal;
		};

		//GET CUSTOM SPOT LIMIT
		BRPVP_getForceSpotLimitReturn = nil;
		[clientOwner,getPlayerUID player] remoteExecCall ["BRPVP_getForceSpotLimitSV",2];
		waitUntil {!isNil "BRPVP_getForceSpotLimitReturn"};
		if (BRPVP_getForceSpotLimitReturn > 0) then {BRPVP_moneyOnHandToSpot = BRPVP_getForceSpotLimitReturn;};
		//=======================================================================

		call compile preprocessFileLineNumbers "map_specific\traveler_aid.sqf";
		call compile preprocessFileLineNumbers "map_specific\custom_constructions.sqf";

		//REMOVE MISSING CLASSES FROM RARE LOOT
		{if !(_x call BRPVP_classExists) then {BRPVP_rareExtraLootInBoxA set [_forEachIndex,-1];};} forEach BRPVP_rareExtraLootInBoxA;
		BRPVP_rareExtraLootInBoxA = BRPVP_rareExtraLootInBoxA-[-1];
		BRPVP_vaultNumberCfg = (BRPVP_vaultNumberCfg max 0) min 10;
		BRPVP_vaultNumber = BRPVP_vaultNumberCfg;
		BRPVP_magnetHolderCargoLimitAllPools = BRPVP_magnetHolderCargoLimitAllPoolsCfg;
		BRPVP_magnetHolderCargoLimit = BRPVP_magnetHolderCargoLimitCfg;
		BRPVP_magnetHolderCargoLimitOnGround = BRPVP_magnetHolderCargoLimitOnGroundCfg max BRPVP_magnetHolderCargoLimitCfg;
		BRPVP_defendFortZombieReward = BRPVP_defendFortZombieReward*BRPVP_missionValueMult;
		BRPVP_defendFortAIReward = BRPVP_defendFortAIReward*BRPVP_missionValueMult;
		BRPVP_aiAttackBaseAttLim = (300*round (BRPVP_aiAttackBaseAttLim/300)) max 300;
		BRPVP_aiAttackBaseFactor = BRPVP_aiAttackBaseAttLim/300;
		BRPVP_pDamLim = 0.975;
		BRPVP_aiDamLim = 0.975;
		if (BRPVP_useRandomRespawnAllways) then {BRPVP_respawnPlaces = [];};
		if (BRPVP_pveMakeAllMapPve) then {BRPVP_pveMainAreasAll = [[[BRPVP_centroMapa,BRPVP_centroMapaRadius,"",10]]];};
		{_x sort true;} forEach BRPVP_flagCombinationAllowed;

		//=================================================================
		//REPEAT IN 3 CASES (CLIENT, SERVER, HC)
		BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission+BRPVP_disableVehUseList;
		BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader+BRPVP_disableVehUseList;
		BRPVP_deniedVehiclesVehMission = BRPVP_deniedVehiclesVehMission arrayIntersect BRPVP_deniedVehiclesVehMission;
		BRPVP_deniedVehiclesBlackTrader = BRPVP_deniedVehiclesBlackTrader arrayIntersect BRPVP_deniedVehiclesBlackTrader;

		BRPVP_virtualGarageTimeToStoreCfg = BRPVP_virtualGarageTimeToStore;
		BRPVP_personalAtmRateCfg = BRPVP_personalAtmRate;
		BRPVP_allowLandAutoPilotCfg = BRPVP_allowLandAutoPilot;
		BRPVP_dukeNukemServiceDelayCfg = BRPVP_dukeNukemServiceDelay;

		player setVariable ["nm",name player,true];
		player setVariable ["sok",false,true];
		player setVariable ["id",getPlayerUID player,true];
		player setVariable ["god",false,true];
		player setVariable ["brpvp_god_admin",false,true];
		player setVariable ["cmb",false,true];
		player setVariable ["veh",objNull,true];
		player setVariable ["cmv",cameraView,true];
		player setVariable ["dstp",1,true];
		player setVariable ["bui",objNull,true];
		player setVariable ["owt",[],true];
		player setVariable ["brpvp_fps",diag_fps,true];
		player setVariable ["brpvp_vd",BRPVP_viewDist,2];
		player setVariable ["brpvp_machine_id",clientOwner,true];
		player setVariable ["brpvp_my_flag_state",0,true];
		player setVariable ["brpvp_carry_objs",[],[clientOwner,2]];
		player setVariable ["brpvp_specting",objNull,2];
		player setVariable ["brpvp_spected_by",[]];
		player setVariable ["brpvp_vault_perc",[0,0,"#FFFFFF"],true];
		player setVariable ["brpvp_ping",-1];
		player setVariable ["brpvp_real_ping",-1];
		player setVariable ["brpvp_vision_mode",[0,0,objNull,[]]];
		player setVariable ["brpvp_on_bus",false,true];
		player setVariable ["brpvp_ai_simu_dist",BRPVP_aiSimuDistOnFoot,2];
		player setVariable ["brpvp_mafiwao",[[],false],true];
		player setVariable ["brpvp_extra_protection",false,true];
		player setVariable ["brpvp_is_master",false,true];
		enableRadio false;
		enableSentences false;

		//CONFIGURE CHANNELS
		0 enableChannel [false,false];
		1 enableChannel [true,BRPVP_enableSideVoice];
		2 enableChannel [false,false];
		3 enableChannel [true,true];
		4 enableChannel [true,true];
		5 enableChannel [true,true];
		//=================================================================

		call compile preprocessFileLineNumbers "serverAndClientFunctions.sqf";
		call compile preprocessFileLineNumbers "brpvp_fpsBoost.sqf";
		call compile preprocessFileLineNumbers "server_code\server_insurancePlaces.sqf";
		setViewDistance BRPVP_viewDist;
		setObjectViewDistance BRPVP_viewObjsDist;
		if (isNil "BRPVP_setTerrainGridClient") then {setTerrainGrid BRPVP_terrainGrid;} else {setTerrainGrid BRPVP_setTerrainGridClient;};

		//=================================================================
		player setVariable ["brpvp_snOk",call BRPVP_checkIfOk,true];
		player call BRPVP_pelaUnidade;
		player linkItem "ItemMap";
		if (isNil "BRPVP_usePaydAccess") then {BRPVP_usePaydAccess = false;};
		if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {{_x hideObject true;} forEach BRPVP_raidTrainingObjsToClean;};
		call compile preprocessFileLineNumbers "pmiss_off.sqf";
		call compile preprocessFileLineNumbers "client_code\playerInit.sqf";
		//=================================================================
	};
};

//VR PAINT COLORS NAMES
if (localize "str_language_using" isEqualTo "portuguese") then {
	BRPVP_vrObjectsColorsNames = ["Lima","Verde","Militar","Prisão","Laranja","Café","Amarelo","Limbo","Preto","Cinza Escuro","Cinza","Branco","Paraíso","Nipônico","Radiação","Vermelho","Rosa","Usa","Roxo","Azul","Conforto"];
} else {
	BRPVP_vrObjectsColorsNames = ["Lime","Green","Militar","Jail","Orange","Coffee","Yellow","Void Black","Black","Dark Gray","Gray","White","Heaven White","Niponic","Radiation","Red","Pink","Usa","Purple","Blue","Confort"];
};