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

//============================================
//= IMPORTANT VARIABLES
//============================================

//VERSION
BRPVP_buildVersion = "V141 B7";

//ADMINS Lista
BRPVP_admins = [
	"76561198339254954", 
	"76561197975554637"  //DONNOVAN (Não remover)
];
BRPVP_moderators = [];
BRPVP_adminsModeratorsCanKillPlayersWithWeapons = true;
BRPVP_showAdminInfo = false; // Mostrar lista de adm (eu acho)
BRPVP_adminsStartsWithAllPerks = true;
BRPVP_useMySqlDatabase = false;

//HC
BRPVP_useHC = false;

//RAID
BRPVP_raidWeekDays = [0,1,2,3,4,5,6]; //WEEK DAYS RAID IS ON: 0 IS SUNDAY, 6 IS SATURDAY
//ON RAID DAYS YOU CAN RAID FROM 0 HOUR TO 24 HOUR. EXAMPLE: [[4,8],[16,20]] FOR 4 AM TO 8 AM AND 4 PM TO 8 PM
//NO MATTER HOW MANY RAID DAYS YOU HAVE THE ARRAY BELLOW NEED TO HAVE 7 LINES (ONE FOR EACH WEEK DAY)
BRPVP_raidWeekDaysDayHours = [
	[[0,24]], //DAY 0 SUNDAY
	[[0,24]], //DAY 1
	[[0,24]], //DAY 2
	[[0,24]], //DAY 3
	[[0,24]], //DAY 4
	[[0,24]], //DAY 5
	[[0,24]]  //DAY 6 SATURDAY
];
BRPVP_raidWeekDaysDisableConstruction = false; //DESATIVAR A CONSTRUÇÃO EM DIAS DE RAID
BRPVP_raidNoConstructionOnBaseIfRaidStarted = true; //Nenhuma construção na base se o raid for iniciado
BRPVP_raidNoConstructionOnBaseIfRaidStartedTime = 1800; //TEMPO EM SEGUNDOS QUE OS JOGADORES NÃO PODEM CONSTRUIR OU VOAR NA BASE DESDE A ÚLTIMA AÇÃO DE ATAQUE

//RAID CONFIG EXAMPLE: RAID OS SATURDAY AND SUNDAY FROM 20H TO 24H (8PM TO 12AM). BUILD DISABLED ON RAID DAYS.
//BRPVP_raidWeekDays = [0,6];
//BRPVP_raidWeekDaysDayHours = [[[20,24]],[[0,24]],[[0,24]],[[0,24]],[[0,24]],[[0,24]],[[20,24]]];
//BRPVP_raidWeekDaysDisableConstruction = true;

//ON NO-RAID DAYS PLAYERS INSIDE BASE+EXTENSION CAN'T HURT PLAYER OUTSIDE AND VICE VERSA
BRPVP_noRaidDayBaseExtension = 25;

//MAXIMUM BUILD HEIGHT
BRPVP_maxBuildHeight = 350; //MIN ALTITUDE IS 100 METERS

//PERSONAL VAULT OPEN AREA
BRPVP_openPersonalVaultAnywhere = false; //TRUE: OPEN ANYWHERE, FALSE: OPEN ONLY IN BASES (ANY BASE) AND SAFEZONES
BRPVP_vaultNumberCfg = 1; //DEFAULT NUMBER OF VAULTS: MIN 1 AND MAX 10

//============================================
//= GENERAL VARIABLES
//============================================

//BRPVP_deadBodyMantainMoreExpensive = true; //PREFERENCE TO MANTAIN MORE EXPENSIVE PLAYERS DEAD BODY
//BRPVP_deadBodyMantainMoreExpensiveQantity = 2;
//BRPVP_perksForceOn = [];

BRPVP_voodooCollDown = 60; //IN MINUTES
BRPVP_voodooMinEffectTime = 60; //IN SECONDS

BRPVP_vrObjectsClasses = ["Land_VR_Block_01_F","Land_VR_Block_02_F","Land_VR_Block_03_F","Land_VR_Block_04_F","Land_VR_Block_05_F","Land_VR_Slope_01_F"];
BRPVP_vrObjectsColors = ["br","green","militar","jail","orange","brown","yellow","void_black","black","dark_gray","gray","white","heaven_white","niponic","radiation","red","pink","usa","purple","blue","confort"];
BRPVP_vrObjectsPaintPrice = 125000;
BRPVP_vrObjectsPaintTasteTime = 10; //IN MINUTES

BRPVP_flagSearchForMoneyInBoxToPayMaxDist = 10;

BRPVP_vehSabotagePrice = 500000;
BRPVP_vehSabotageFixChanceEachTry = 0.1;
BRPVP_vehSabotageFixMaxTries = 10;

BRPVP_ammoNoAutoTracer = ["B_12Gauge_Pellets_Submunition","B_12Gauge_Slug_NoCartridge"];

BRPVP_fuelGallonCanExplodeOnPVE = true;

BRPVP_aiWithLauncherHaveMinervaPerc = 0.05;
BRPVP_aiWithLauncherHaveMinervaHealth = 3;
BRPVP_aiWithLauncherHaveMinervaRearmTime = 25; //SECONDS
BRPVP_aiWithLauncherHaveMinervaCheck = {random 1 <= BRPVP_aiWithLauncherHaveMinervaPerc};
BRPVP_aiWithLauncherHaveMinervaReward = 750000;
BRPVP_aiWithLauncherHaveMinervaIconMaxDist = 1250;
BRPVP_aiWithLauncherHaveMinervaLoadout = [
	[["arifle_AK12_arid_F","","acc_flashlight","optic_Arco_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],"bipod_02_F_arid"],["launch_RPG32_F","","","",["RPG32_F",1],[],""],[],["U_I_E_CBRN_Suit_01_EAF_F",[["30rnd_762x39_AK12_Arid_Mag_F",3,30]]],["V_PlateCarrierGL_wdl",[]],["B_Carryall_eaf_F",[["FirstAidKit",4],["75rnd_762x39_AK12_Arid_Mag_F",3,75]]],"","G_Blindfold_01_white_F",[],["ItemMap","","","","",""]]
];

BRPVP_suicideCoolDownTime = 300; //IN SECONDS

BRPVP_deleteAtomicVehiclesAfterUse = true;

//DEAD VEHICLE SMOKE/FIRE DELETION TIME (LANDVEHICLE ONLY)
BRPVP_deadVehicleSmokeChanceToZeroEffects = 0.2;
BRPVP_deadVehicleSmokeTime = [30,40,50];

//WEATHER CHANGE CONFIGURATION
BRPVP_useDynamicWeather = true;
BRPVP_weatherInitialOvercast = 0.35;
BRPVP_minOvercast = 0; //MINIMUM OVERCAST (0-1)
BRPVP_maxOvercast = 1; //MAXIMUM OVERCAST THAT WILL BE REACHED (0-1)
BRPVP_weatherFogOnOvercastZero = 0;
BRPVP_weatherFogOnOvercastOne = 0.05;
BRPVP_minChange = 0.25;
BRPVP_maxChange = 1;
BRPVP_chanceToChangeWeather = 0.5; //DEFAULT IS 0.5 (50%)
BRPVP_waitIfNotChange = 600; //IN SECONDS
BRPVP_waitAfterChangeDone = 1200; //IN SECONDS
BRPVP_weatherDegug = false; //SHOW FULL CHANGE TIME PREDICTION
BRPVP_weatherMaxDiffToChange = 0.05;
BRPVP_weatherChanceOfRainMin = 0;
BRPVP_weatherChanceOfRainMax = 0.6;
BRPVP_weatherWindMin = 0; //IN METER/SECONS
BRPVP_weatherWindMinWithClouds = 2; //IN METER/SECONS
BRPVP_weatherwindMax = 6; //IN METER/SECONS
BRPVP_weatherwindMaxNoClouds = 4; //IN METER/SECONS

//GOOD PETER (ANTI-LAZARUS) CONFIGURATION
BRPVP_peterLife = 350;
BRPVP_peterReward = 25000000;
BRPVP_peterRewardRedKripto = 17500000;
BRPVP_peterChanceOfSlowTeleport = 0.20; //PERCENTAGE CHANCE OF LAZARUS PERFORM A SLOW TELEPORT (GREATER CHANCE OF DAMAGE)
BRPVP_peterChanceOfSlowTeleportTime = 0.25; //DELAY IN SECONDS BEFORE LAZARUS TELEPORT TO AVOID A BULLET
BRPVP_peterAtomicBombInit = 0.10;
BRPVP_peterAtomicBombEnd = 0.20;
BRPVP_peterDelayBetweenSmallTeleports = 15;
BRPVP_peterSpeedInit = 1.25;
BRPVP_peterSpeedFinal = 2.0;
BRPVP_peterHitToChangeCity = 0.25;

BRPVP_GX_M82A2000_PlasmaRifleModRestartChance = 0.1;
BRPVP_GX_M82A2000_NumberOfAiWithTheWeapon = 2;
BRPVP_GX_M82A2000_RandomSpawnTime = 7200;

BRPVP_atomicShotDisabled = false;
BRPVP_atomicShotBreakDomeProtectionChance = 0.75;

BRPVP_turretDeathExplosionDelay = 0.5; //EXPLOSION DELAY IN SECONDS

//LAZARUS CONFIGURATION
BRPVP_larsLife = 130;
BRPVP_larsReward = 25000000;
BRPVP_larsRewardRedKripto = 17500000; //REWARD IF KILLED BY RED KRIPTONITE
BRPVP_larsNoMoveOnReloadChance = 0.35; //CHANCE OF RELOADING WITHOUT MOVING
BRPVP_larsNoMoveOnReloadTime = 5; //HOW MANY SECONDS LAZARUS WITH STOP TO MOVE WHILE RELOADING
BRPVP_larsDelayBetweenSmallTeleports = 7.5;
BRPVP_larsChanceOfSlowTeleport = 0.2; //PERCENTAGE CHANCE OF LAZARUS PERFORM A SLOW TELEPORT (GREATER CHANCE OF DAMAGE)
BRPVP_larsChanceOfSlowTeleportTime = 0.25; //DELAY IN SECONDS BEFORE LAZARUS TELEPORT TO AVOID A BULLET
BRPVP_larsHitToChangeCity = 0.25;
BRPVP_larsAmmoTimeLimit = 12;

//ALIEN SOLDIER CONFIGURATION
BRPVP_ulfanSoldierPercentage = 0.05;
BRPVP_ulfanSoldier3DIconMaxDistance = 1250;
BRPVP_ulfanSoldierSpeed = 1.75; //ULFAN SOLDIER MOVEMENT SPEED
BRPVP_ulfanSoldierSpeedHunt = 2; //ULFAN SOLDIER MOVEMENT SPEED ON PLAYER HUNT
BRPVP_ulfanSoldierHuntChance = 0.5;
BRPVP_ulfanSoldierExtraLife = 7.5;
BRPVP_ulfanSoldierMoneyReward = 750000;
BRPVP_ulfanSoldierSkill = [0.2,0.75]; //[AIMING SKILL,ALL OTHER SKILLS]
BRPVP_ulfanSoldierLoadouts = [
	[["arifle_MXC_Black_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_65x39_caseless_black_mag",30],[],""],[],[],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_65x39_caseless_black_mag",3,30]]],["V_PlateCarrierSpec_blk",[["MiniGrenade",5,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1]]],["B_CivilianBackpack_01_Sport_Red_F",[["30Rnd_65x39_caseless_black_mag",10,30]]],"H_Beret_EAF_01_F","G_Spectacles",[],["ItemMap","ItemGPS","","","",""]],
	[["arifle_MXC_Black_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_65x39_caseless_black_mag",30],[],""],[],[],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_65x39_caseless_black_mag",3,30]]],["V_PlateCarrierSpec_blk",[["MiniGrenade",5,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1]]],["B_CivilianBackpack_01_Sport_Green_F",[["30Rnd_65x39_caseless_black_mag",10,30]]],"H_Beret_EAF_01_F","G_Spectacles",[],["ItemMap","ItemGPS","","","",""]],
	[["arifle_MXC_Black_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_65x39_caseless_black_mag",30],[],""],[],[],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_65x39_caseless_black_mag",3,30]]],["V_PlateCarrierSpec_blk",[["MiniGrenade",5,1],["SmokeShellRed",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1]]],["B_CivilianBackpack_01_Sport_Blue_F",[["30Rnd_65x39_caseless_black_mag",10,30]]],"H_Beret_EAF_01_F","G_Spectacles",[],["ItemMap","ItemGPS","","","",""]]
];

BRPVP_minHeightParachuteOpenNormal = 100;
BRPVP_minHeightParachuteOpenPerk = 4;

BRPVP_bigFloorHoles = [30,57];

BRPVP_modsPrefixes = [
	[["CUP_"],"CUP"],
	[["rhs_","RHS_","rhsusf_","RHSUSF_"],"RHS"],
	[["rhsusaf_","RHSUSAF_"],"RHS"],
	[["GX_M82A2"],"GX Weapons"]
];

BRPVP_superBoxClass = "O_supplyCrate_F";
BRPVP_superBoxCargoSize = 65000;
BRPVP_superBoxMoneySize = 150000000;
BRPVP_superBoxScale = 1.5;

BRPVP_grassCutTime = 1200; //TIME IN SECONDS

BRPVP_hackCycleTime = 0.75; //CYCLE IN SECONDS

BRPVP_sixthSenseAiImmunePerc = 0.25; //PERCENTAGE OF AI UNITS IMMUNE TO SIXTH SENSE PERK
BRPVP_sixthSenseAiFeelObserverPerc = 0.25; //PERCENTAGE OF AI UNITS THAT FEEL THE OBSERVER
BRPVP_sixthSenseAiFeelDistance = 125;

BRPVP_raidTrainingMissionRun = true;
BRPVP_raidTrainingMaxMoneyInBoxes = [/*200M FLAG*/1500000,/*100M FLAG*/1000000,/*50M FLAG*/750000,/*25M FLAG*/500000];
BRPVP_raidTrainingMaxMoneyInBoxesAllBase = [/*200M FLAG*/30000000,/*100M FLAG*/20000000,/*50M FLAG*/10000000,/*25M FLAG*/5000000];

//PLAYER MISSIONS AI PERCENTUAL (0-1)
BRPVP_pmissAiPerc = 0.625;
//PLAYER MISSIONS 2 AI PERCENTUAL (0-1)
BRPVP_pmiss2AiPerc = 0.625;

BRPVP_safezoneProtectionOnExitTime = 10;

BRPVP_playerIdListNoAutomaticMessages = [];

BRPVP_tastingAbilitiesEnabled = true;
BRPVP_tastingAbilitiesRenewDays = 5;

BRPVP_forceTracersToAllPlayers = true;
BRPVP_forceTracersToAllAiUnits = true;

BRPVP_CbrnMasks = [
	"G_AirPurifyingRespirator_01_F",
	"G_RegulatorMask_F",
	"G_AirPurifyingRespirator_02_black_F",
	"G_AirPurifyingRespirator_02_olive_F",
	"G_AirPurifyingRespirator_02_sand_F"
];
BRPVP_CbrnSuits = [
	"U_B_CBRN_Suit_01_MTP_F",
	"U_B_CBRN_Suit_01_Tropic_F",
	"U_B_CBRN_Suit_01_Wdl_F",
	"U_I_CBRN_Suit_01_AAF_F",
	"U_I_E_CBRN_Suit_01_EAF_F",
	"U_C_CBRN_Suit_01_Blue_F",
	"U_C_CBRN_Suit_01_White_F"
];

BRPVP_personalVaultCargoSize = 7500;
BRPVP_baseTurretNoSeeSearchTime = 25;

BRPVP_lostMoneyWhenDieUse = false; // Morrer perde dinheiro no banco
//PERCENTAGE OF THE BANK MONEY TO LOST WHEN DIE MIN
BRPVP_lostMoneyWhenDieMinPercentage = 0.0025;
//PERCENTAGE OF THE BANK MONEY TO LOST WHEN DIE MAX
BRPVP_lostMoneyWhenDieMaxPercentage = 0.015;
//TIME TO STAY ALIVE IN SECONDS TO USE MIN PERCENTAGE
BRPVP_lostMoneyWhenDieAliveTimeForMin = 900;
//MAX VALUE TO LOST, BRPVP_lostMoneyWhenDieMaxValor, MUST BE MULTIPLE OF BRPVP_lostMoneyWhenDieStep
BRPVP_lostMoneyWhenDieMaxValor = 750000;
//LOST VALUES ARE MULTIPLE OF BRPVP_lostMoneyWhenDieStep: 50000, 100000, 150000, 200000, 250000...
BRPVP_lostMoneyWhenDieStep = 50000;

BRPVP_mapVisibleCircleSizeMultiplier = 0.9;
BRPVP_MinervaCraterPerc = 0.5;
BRPVP_minervaShotDisabled = false;
BRPVP_minervaShotBreakDomeProtectionChance = 0.5;

//LIST OF VEHICLES WITH CUSTOM CARGO SIZE: [VEHICLE CLASS, VEHICLE NAME (NOT USED), CUSTOM CARGO SIZE]
BRPVP_customCargoVehiclesCfg = [
	//NORMAL VEHICLES
	["C_Van_01_transport_F","Truck Transport",6000],
	["C_Van_01_box_F","Truck Box",6000],
	["C_Van_02_transport_F","Van Transport",6000],
	["I_C_Van_01_transport_brown_F","Truck (Brown)",6000],
	["I_C_Van_01_transport_olive_F","Truck (Olive)",6000],
	["C_Truck_02_box_F","Civil Repair Truck",10000],
	//TRUCKS
	["B_Truck_01_transport_F","HEMTT Transport",25000],
	["I_Truck_02_transport_F","Zamak Transport",25000],
	["O_Truck_03_transport_F","Tempest Transport",25000],
	["B_Truck_01_covered_F","HEMTT Transport (Covered)",25000],
	["I_Truck_02_covered_F","Zamak Transport (Covered)",25000],
	["O_Truck_03_covered_F","Tempest Transport (Covered)",25000],
	["B_Truck_01_fuel_F","HEMTT Fuel",8000],
	["O_Truck_02_fuel_F","Zamak Fuel",8000],
	["O_Truck_03_fuel_F","Tempest Fuel",8000],
	["B_Truck_01_ammo_F","HEMTT Ammo",8000],
	["I_Truck_02_ammo_F","Zamak Ammo",8000],
	["O_Truck_03_ammo_F","Tempest Ammo",8000],
	["B_Truck_01_repair_F","HEMTT Repair",8000],
	["O_Truck_03_repair_F","Tempest Repair",8000],
	//HELIS
	["B_Heli_Transport_03_unarmed_F","CH-67 Huron (Unarmed)",8000],
	["B_Heli_Transport_03_unarmed_green_F","CH-67 Huron (Unarmed)",8000],
	["I_Heli_Transport_02_F","CH-49 Mohawk",8000],
	["O_Heli_Transport_04_covered_black_F","Mi-280 Taru (Transport, Black)",6000],
	["O_Heli_Light_02_unarmed_F","PO-30 Orca (Unarmed)",8000],
	["I_Heli_light_03_unarmed_F","WY-55 Hellcat (Unarmed)",6000],
	["CUP_I_SA330_Puma_HC2_RACS","SA-330 Puma HC2",6000],
	["CUP_B_CH53E_USMC","CH-53E Super Stallion",10000],
	//RHS
	["rhs_gaz66o_vdv","GAZ-66 (Open)",10000],
	["rhs_gaz66_ap2_vdv","GAZ-66-AP-2",10000],
	["rhs_gaz66_vdv","GAZ-66",10000],
	["rhs_kamaz5350_open_vdv","KamAZ-5350 (Open)",25000],
	["rhs_kamaz5350_vdv","KamAZ-5350",25000],
	["rhs_kraz255b1_flatbed_vdv","KrAZ-255B1 (Flatbed)",20000],
	["rhs_zil131_flatbed_cover_vdv","ZiL-131 (Flatbed)",20000],
	["RHS_Ural_Ammo_VDV_01","Ural-4320 (Ammo)",8000],
	["RHS_Ural_Fuel_VDV_01","Ural-4320 (Fuel)",8000],
	["RHS_Ural_Repair_VDV_01","Ural-4320 (Repair)",8000],
	["rhs_gaz66_zu23_msv","GAZ-66 (Flatbed)",6000],
	["RHS_Ural_Zu23_MSV_01","Ural-4320 (ZU-23-2)",6000],
	//X-66 MAMMOTH TANK
	["HTNK_Snow","X-66 Mammoth",25000],
	["HTNK_us_snow","X-66 Mammoth",25000],
	["HTNK_Grey","X-66 Mammoth",25000]
];

BRPVP_customBaseBoxSizeUse = true;
BRPVP_customBaseBoxSize = 10000;
BRPVP_customBaseBoxSizeUpgradeUse = true;
BRPVP_customBaseBoxSizeUpgradePrice = 500000;
BRPVP_customBaseBoxSizeUpgrade = 15000;

BRPVP_foodPlayerStart = 10; //NUMBER OF FOODS PLAYER START WITH
BRPVP_randomSpecialItemsPlayerStart = 25; //NUMBER OF RANDOM ALT+I ITEMS PLAYER START WITH
BRPVP_randomConstructionItemsPlayerStart = 15; //NUMBER OF RANDOM CONSTRUCTIONS ITEMS PLAYER START WITH
BRPVP_randomFarmCraftItemsPlayerStart = 30; //NUMBER OF RANDOM FARM & CRAFT ITEMS PLAYER START WITH

BRPVP_showMyBasesOnMap = true;
BRPVP_trenchMaxQuantity = 80;
BRPVP_holeMissionAreaRadius = 180; //HOLE MISSION RADIUS IN METERS

BRPVP_secCamViewDistance = 750;
BRPVP_secCamExistenceLimit = 5; //LIFE TIME IN DAYS OF A SECURITY CAMERA PLACED OUT OF YOU BASE(S)
BRPVP_secCamBaseExtensionDistance = 100; //EXTRA FLAG DISTANCE IN METERS TO CONSIDER THE SECURITY CAMERA INSIDE A BASE

BRPVP_serverCommandRestart = "#shutdown";

BRPVP_playersFaces = [
	"players_icon_01.paa", //DONNOVAN
	"players_icon_02.paa", //JOSEF STALIN
	"players_icon_03.paa", //ABRAHAM LINCOLN
	"players_icon_04.paa", //EDDIE MURPHY
	"players_icon_05.paa", //MICHAEL JACKSON
	"players_icon_06.paa", //GABE NEWELL
	"players_icon_07.paa", //MAHATMA GANDHI
	"players_icon_08.paa", //BARACK OBAMA
	"players_icon_09.paa", //KIM JONG-UN
	"players_icon_10.paa", //WILL SMITH
	"players_icon_11.paa", //VLADIMIR PUTIN
	"players_icon_13.paa", //TUPAC SHAKUR
	"players_icon_14.paa", //DONALD TRUMP
	"players_icon_15.paa", //MR BEAN
	"players_icon_17.paa", //NICHOLAS CAGE
	"players_icon_18.paa", //ELON MUSK
	"players_icon_19.paa", //JESUS
	"players_icon_20.paa", //XI JINPING
	"players_icon_21.paa", //BOLSONARO
	"players_icon_22.paa", //LULA
	"players_icon_23.paa", //CHICO XAVIER
	"players_icon_24.paa", //MARTIN LUTER KING
	"players_icon_25.paa", //BUDA
	"players_icon_26.paa", //JOHN LENNON
	"players_icon_27.paa", //KURIRIM
	"players_icon_28.paa", //T-1000
	"players_icon_29.paa", //CHUCK NORIS
	"players_icon_30.paa"  //SLOTH
];

BRPVP_superRunInertiaStart = 0.5; //LOWER VALUES MAKE PLAYER SUPER RUN SPEED UP FASTER
BRPVP_superRunInertiaStop = 0.25; //LOWER VALUES MAKE PLAYER SUPER RUN SPEED DOWN FASTER
BRPVP_superRunSpeedsArray = [1,1.5,2,3,4,5]; //SUPER RUN SPEEDS MODES
BRPVP_bornFearSoundRunTimes = 1; //USE -1 TO NEVER PLAY THE PARACHUTE BORN FEAR SOUND

BRPVP_svFpsIndicatorGreen = 25;
BRPVP_svFpsIndicatorRed = 10;

BRPVP_vehTotalLifeToFixDb = 4; //DB VEHICLES CAN BE FIXED X LIFES BEFORE PERMANENT DAMAGE REACH BRPVP_vehTotalLifeLimXxxx
BRPVP_vehTotalLifeToFixNoDb = 2; //NO DB VEHICLES CAN BE FIXED X LIFES BEFORE PERMANENT DAMAGE REACH BRPVP_vehTotalLifeLimXxxx
BRPVP_vehTotalLifeLimLand = 0.5; //PERMANENT DAMAGE AFTER X LIFES FIX ON LAND VEHICLES
BRPVP_vehTotalLifeLimHeli = 0.4; //PERMANENT DAMAGE AFTER X LIFES FIX ON HELICOPTERS
BRPVP_vehTotalLifeLimPlane = 0.33; //PERMANENT DAMAGE AFTER X LIFES FIX ON PLANES AND JETS
BRPVP_vehTotalLifeLimShip = 0.5; //PERMANENT DAMAGE AFTER X LIFES FIX BOATS AND SHIPS

//SET INFANTRY DAYS (ONLY SIMPLE VEHICLES ARE AVALIABLE) - BRPVP_useTireVehiclesOnStart MUST BE TRUE TO THIS TO WORK
BRPVP_disableVehUseDays = [1]; //0 IS SUNDAY, 6 IS SATURDAY

BRPVP_perkSeeAllAiTerrainCanBlock = true;

BRPVP_uberAttackUse = true;
BRPVP_uberAttackPercentage = 0.05;
BRPVP_uberAttackSuicidePercentage = 0.2;

//LIMIT BUY OF ALT+I ITEMS (DOES NOT LIMIT IF ITEM IS FOUND ON LOOT)
BRPVP_specialItemsBuyLimit = [
	["BRPVP_selfRevive",10]
];
BRPVP_specialItemsGiveLimit = [
	["BRPVP_selfRevive",15]
];

BRPVP_aiAttackUnconsciousPlayer = true;
BRPVP_aiAttackUnconsciousPlayerDelay = 60; //SECONDS
BRPVP_aiDamageOnUnconsciousPlayer = 0.05; //DEFAULT 0.05

//AI BASE ATTACK CONFIGURATION
BRPVP_aiAttackBaseEnabled = true;
BRPVP_aiAttackBaseAttLim = 1800; //MUST BE MULTIPLE OF 300
BRPVP_aiAttackBaseCycle = 900;
BRPVP_aiAttackBaseEptLim = 600;
BRPVP_aiAttackBaseHelis = [
	//VANILLA HELIS
	"B_Heli_Transport_03_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F",
	"B_CTRG_Heli_Transport_01_sand_F",
	"B_CTRG_Heli_Transport_01_tropic_F",
	"O_Heli_Light_02_dynamicLoadout_F",
	"B_Heli_Light_01_dynamicLoadout_F",
	"I_Heli_light_03_dynamicLoadout_F",
	//CUP HELIS
	"CUP_B_UH60S_USN",
	"CUP_B_UH1Y_Gunship_Dynamic_USMC",
	"CUP_B_UH1D_armed_GER_KSK",
	"CUP_B_Mi171Sh_ACR",
	"CUP_O_Mi8_RU",
	"CUP_O_Ka50_DL_RU",
	"CUP_B_Mi35_Dynamic_CZ",
	"CUP_B_Mi35_Dynamic_CZ_Tiger"
];

BRPVP_useMapCrashTestAtLogin = false;
BRPVP_turnAiIntoZombiesAfterDiePercentage = 0.2;

BRPVP_useTerrainDynamicResolution = true;

BRPVP_iSizeMilDot = 7;
BRPVP_iSizeMilTriangle = 12;
BRPVP_iSizeGeneral = 10;

BRPVP_vehShopBigVehicles = [
	["CUP_B_ZUBR_CDF","big"],
	["CUP_I_Frigate_AAF","sbig"]
];

BRPVP_insuranceTimesLimit = 5;
BRPVP_insuranceTimesLimitHeli = 6;
BRPVP_insuranceTimesLimitPlane = 10;
BRPVP_bannedMagazines = ["CBA_FakeLauncherMagazine"];

//TO USE WITH IMMERSION CIGS MOD (CIGARS)
BRPVP_iCigsAIUseCigsChance = 0.15;

BRPVP_simpleMissSpawnWait = 0.05;

BRPVP_vehLvlMaxKills = 10;
BRPVP_vehLvlMaxMult = 2;

BRPVP_specialItemsKitSizeClassAd = [1];
BRPVP_specialItemsKitsPerRestart = [20,25,30];
BRPVP_specialItemsKitPriceMult = 1;

BRPVP_airVehicleResistence = 1;
BRPVP_airVehLifeMultPerk = 2;
BRPVP_airVehicleResistenceCollision = 1;
BRPVP_airVehLifeMultPerkCollision = 5;

BRPVP_domeProtectFromArty = true;
BRPVP_antiMissileEfficiency = 0.35;
BRPVP_antiMissileEfficiencyBase = 0.25;
BRPVP_antiArtyEfficiency = 0.3;
BRPVP_antiArtyEfficiencyBase = 0.2;

BRPVP_customNoBuildAreas = [];
//EXAMPLE BEGIN
/*
BRPVP_customNoBuildAreas = [
	[
		[
			[position,radius,name],
			[position,radius,name],
			[position,radius,name],
			[position,radius,name],
		],
		extra_radius
	],
	[
		[
			[[34344.7,12323,0],500,"Special Point 1"],
			[[56366.7,45645,0],300,"Special Point 2"],
			[[74235.7,34634,0],500,"Special Point 3"],
			[[16456.7,13453,0],200,"Special Point 4"]
		],
		500
	],
	[
		[
			[[16456.7,13453,0],200,"Place A"],
			[[34344.7,12323,0],500,"Place B"],
			[[56366.7,45645,0],300,"Place C"],
			[[74235.7,34634,0],500,"Place D"]
		],
		250
	]
];
*/
//EXAMPLE END

BRPVP_magnetHolderCargoLimitAllPoolsCfg = 30000;
BRPVP_magnetHolderCargoLimitCfg = 9900; //MAXIMUM IS 9999
BRPVP_magnetHolderCargoLimitOnGroundCfg = 9900; //MAXIMUM IS 9999

BRPVP_classAdErrorsInFalseAd = 2;
BRPVP_classAdItemsMultForFalse = 3;

BRPVP_turretSpawnMinTime = 350; //V139: 600
BRPVP_turretsSpawnDespawnBomb = false;

//CUSTOM TEXTURES
BRPVP_extraTextures = [
	//[
	//	BRPVP_vrObjectsClasses,
	//	"BRP_imagens\textures\concrete.paa",
	//	0
	//]
];

BRPVP_dukeNukemServiceDelay = 200; //V139: 240
BRPVP_numberOfPublicCraftWorkbenchs = 5;
BRPVP_banditCanSeePvePlayers = false;

BRPVP_autoTurretTypesTitanAA = ["I_static_AA_F"];
BRPVP_autoTurretTypesTitan = ["I_static_AT_F","I_static_AA_F"];
BRPVP_autoTurretSkillTitan = 1;
BRPVP_autoTurretSkillTitanBase = 1;
BRPVP_autoTurretHmgBlastEachXShots = 10;
BRPVP_autoTurretUpgradePrice = 750000;
BRPVP_autoTurretHmgLvl2Damage = 0.25;
BRPVP_autoTurretHmgLvl2Rocket = "R_PG32V_F";
BRPVP_autoTurretHmgLvl2Penetrator = "ammo_Penetrator_RPG32V";

BRPVP_allPlayersOnFlagHaveAccessToAllBase = false;

BRPVP_newerPlayerKillPenalt = 500000;
BRPVP_newerXPToLeave = 100000;
BRPVP_newerKillsToLeave = 1;
BRPVP_newerDaysPlayedToLeave = 11;
BRPVP_newerDiscoveredTimeToMantain = 90; //IN SECONDS

BRPVP_saveGroundItemsForOneRestart = true;
BRPVP_shutdownServerOnRestartTimes = true;

BRPVP_carrierMissDelayTime = 1800; //SECONDS - TIME TO WAIT BEFORE RANDOM CHANCE OF CARRIER MISSION SPAWNS
BRPVP_carrierMissRandomTime = 3600; //SECONDS - THE CARRIER MISSION WILL SPAWN A RANDOM TIME FROM 0 TO 3600 SECONDS AFTER BRPVP_carrierMissDelayTime

BRPVP_allowLandAutoPilot = false;

BRPVP_artySpotOnShot = true;
BRPVP_artySpotOnShotTime = 180; //TIME THE ARTILLERY SHOT POSITION GET SPOTED

//VEHICLES RADAR AND TERMAL
BRPVP_vehRadarEnabled = true;
BRPVP_vehThermalEnabled = true;
BRPVP_vehThermalExcludeList = ["O_UAV_01_F"];

//PVE
BRPVP_pveAllowBandit = true;
BRPVP_pveBanditPrice = 10000000;
BRPVP_pveFrantaBombExplode = true;

//FANTA MINES
BRPVP_fantaMinesBigAlertSize = 3.5;
BRPVP_fantaMinesShotChanceToHit = 1;
BRPVP_fantaMinesSize = 1.35; //1 - NORMAL SIZE
BRPVP_fantaMinesTerrainLimit = [[25,5],[50,10],[100,15],[200,20]]; //FRANTA MINES LIMIT ON FLAGS
BRPVP_fantaMinesOutTerrainLimitPerPlayer = 20; //FRANTA MINES LIMIT OUT OF FLAG, PER PLAYER
BRPVP_fantaMinesExplosionDelay = 2; //WAIT BEFORE DETONATE, 2 SECONDS (ORIGINAL WAS 1.7 SECONDS)

//CUSTOM PLAYERS
BRPVP_cloneCustomNames = [
	"BRPVP_Navid_guillie_F",
	"BRPVP_Navid_AMS_guillie_F",
	"BRPVP_SPMG_guillie_F",
	"BRPVP_SPMG_blk_guillie_F",
	"BRPVP_Mar10_AMS_guillie_F",
	"BRPVP_M320_AMS_guillie_F",
	"BRPVP_Navid_guillie_Bergen_F",
	"BRPVP_Navid_AMS_guillie_Bergen_F",
	"BRPVP_SPMG_guillie_Bergen_F",
	"BRPVP_SPMG_blk_guillie_Bergen_F",
	"BRPVP_Mar10_AMS_guillie_Bergen_F",
	"BRPVP_M320_AMS_guillie_Bergen_F",
	"BRPVP_Zafir_guillie_F"
];
BRPVP_cloneCustomData = [
	[["MMG_01_hex_ARCO_LP_F","muzzle_snds_93mmg","acc_pointer_IR","optic_Arco",["150Rnd_93x64_Mag",150],[],"bipod_02_F_hex"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Carryall_oucamo",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["150Rnd_93x64_Mag",2,150]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["MMG_01_hex_ARCO_LP_F","muzzle_snds_93mmg","acc_pointer_IR","optic_AMS_snd",["150Rnd_93x64_Mag",150],[],"bipod_02_F_hex"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Carryall_oucamo",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["150Rnd_93x64_Mag",2,150]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["MMG_02_camo_F","muzzle_snds_338_green","acc_pointer_IR","optic_Arco",["130Rnd_338_Mag",130],[],"bipod_01_F_mtp"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Carryall_oucamo",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["130Rnd_338_Mag",2,130]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["MMG_02_black_F","muzzle_snds_338_black","acc_pointer_IR","optic_Arco_blk_F",["130Rnd_338_Mag",130],[],"bipod_01_F_mtp"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Carryall_oucamo",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["130Rnd_338_Mag",2,130]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["srifle_DMR_02_camo_F","muzzle_snds_338_black","acc_pointer_IR","optic_AMS",["10Rnd_338_Mag",10],[],"bipod_02_F_arid"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Carryall_oucamo",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["10Rnd_338_Mag",10,10]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["srifle_LRR_camo_F","","","optic_AMS",["7Rnd_408_Mag",7],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Carryall_oucamo",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["7Rnd_408_Mag",10,7]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["MMG_01_hex_ARCO_LP_F","muzzle_snds_93mmg","acc_pointer_IR","optic_Arco",["150Rnd_93x64_Mag",150],[],"bipod_02_F_hex"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Bergen_dgtl_F",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["150Rnd_93x64_Mag",2,150]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["MMG_01_hex_ARCO_LP_F","muzzle_snds_93mmg","acc_pointer_IR","optic_AMS_snd",["150Rnd_93x64_Mag",150],[],"bipod_02_F_hex"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Bergen_dgtl_F",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["150Rnd_93x64_Mag",2,150]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["MMG_02_camo_F","muzzle_snds_338_green","acc_pointer_IR","optic_Arco",["130Rnd_338_Mag",130],[],"bipod_01_F_mtp"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Bergen_dgtl_F",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["130Rnd_338_Mag",2,130]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["MMG_02_black_F","muzzle_snds_338_black","acc_pointer_IR","optic_Arco_blk_F",["130Rnd_338_Mag",130],[],"bipod_01_F_mtp"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Bergen_dgtl_F",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["130Rnd_338_Mag",2,130]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["srifle_DMR_02_camo_F","muzzle_snds_338_black","acc_pointer_IR","optic_AMS",["10Rnd_338_Mag",10],[],"bipod_02_F_arid"],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Bergen_dgtl_F",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["10Rnd_338_Mag",10,10]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["srifle_LRR_camo_F","","","optic_AMS",["7Rnd_408_Mag",7],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Bergen_dgtl_F",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["7Rnd_408_Mag",10,7]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]],
	[["LMG_Zafir_F","","acc_pointer_IR","optic_AMS",["150Rnd_762x54_Box",150],[],""],[],["hgun_Rook40_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_FullGhillie_sard",[["16Rnd_9x21_Mag",5,16]]],["V_TacVest_blk_POLICE",[["DemoCharge_Remote_Mag",2,1],["ClaymoreDirectionalMine_Remote_Mag",2,1]]],["B_Carryall_oucamo",[["Medikit",1],["HandGrenade",4,1],["MiniGrenade",4,1],["150Rnd_762x54_Box",3,150]]],"H_HelmetLeaderO_ghex_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]
];

//PLAYER XP
BRPVP_xpDoubleDays = [0,6]; //WEEK DAYS WITH DOUBLE XP: 0 IS SUNDAY, 6 IS SATURDAY
BRPVP_xpToBuyAllPerks = 2000000;
BRPVP_xpPriceStep = 5000;
BRPVP_priceToCancelPerk = 500000;
BRPVP_xpLimits = [
	650, //AI Killed
	50, //Players Killed
	150000000, //Value Purchased
	150000000, //Value Sold
	30, //Play Days
	250, //Farm and Craft
	150, //Construction
	500, //Zeds Killed
	125, //Headshots
	125, //Mounted Kills
	200000, //Walk
	100, //Food Use
	60*30, //Radioactive
	100, //Suitcases
	10800, //Land Vehicle
	7200, //Helicopter
	3600, //Plane
	1800, //Ship
	72, //Played Hours
	100, //Base Turrets Killed
	200, //Cure and Repair
	1 //World Destroyer
];

//AIRCRAFT CARRIER
BRPVP_carrierPrice = 100000000;
BRPVP_carrierRefund = 75000000;
BRPVP_carrierPriceMove = 7500000;
BRPVP_carrierObtainInTrader = true; //IF TRUE CARRIER CAN BE BUYED IN OBSCURE TRADER AND NOT JUST AS A ADMIN ITEM

BRPVP_noDamageVehDays = []; //0 IS SUNDAY, 6 IS SATURDAY
BRPVP_noDamageVehListCfg = [
	//DRONES
	"B_T_UAV_03_dynamicLoadout_F",
	"O_UAV_02_dynamicLoadout_F",
	"B_UAV_05_F",
	"O_T_UAV_04_CAS_F",
	//CUP DRONES
	"CUP_B_USMC_DYN_MQ9",
	//ARTY
	"B_MBT_01_arty_F",
	"O_MBT_02_arty_F",
	"B_MBT_01_mlrs_F",
	"I_E_Truck_02_MRL_F",
	//CUP ARTY
	"CUP_B_BM21_CDF",
	"CUP_B_RM70_CZ",
	//JETS
	"O_T_VTOL_02_infantry_dynamicLoadout_F",
	"I_Plane_Fighter_03_dynamicLoadout_F",
	"O_Plane_CAS_02_dynamicLoadout_F",
	"I_Plane_Fighter_04_F",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_F",
	"O_Plane_Fighter_02_F",
	//JETS CUP
	"CUP_B_Su25_Dyn_CDF",
	"CUP_B_JAS39_HIL",
	"CUP_B_F35B_USMC",
	"CUP_B_AV8B_DYN_USMC",
	"CUP_B_A10_DYN_USA",
	"CUP_B_SU34_CDF",
	//TANKS
	"B_APC_Tracked_01_rcws_F",
	"I_APC_tracked_03_cannon_F",
	"B_APC_Tracked_01_AA_F",
	"O_APC_Tracked_02_AA_F",
	"O_APC_Tracked_02_cannon_F",
	"O_MBT_02_cannon_F",
	"I_MBT_03_cannon_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_TUSK_F",
	"O_MBT_04_command_F",
	"O_MBT_02_railgun_F",
	//TANKS CUP 1
	"CUP_B_Challenger2_2CD_BAF",
	"CUP_B_Leopard2A6DST_GER",
	"CUP_B_ZSU23_CDF",
	"CUP_O_T90_RU",
	"CUP_B_M1A1_DES_US_Army",
	"CUP_B_M1A2_TUSK_MG_US_Army",
	//TANKS CUP 2
	"CUP_B_Ural_ZU23_CDF",
	"CUP_O_BMP2_RU",
	"CUP_O_BMP3_RU",
	"CUP_I_M163_AAF",
	"CUP_O_T55_CHDKZ",
	"CUP_B_MCV80_GB_D",
	"CUP_B_FV510_GB_D",
	"CUP_O_2S6M_RU",
	//ATTACK HELIS
	"B_Heli_Attack_01_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_black_F",
	//ATTACK HELIS CUP
	"CUP_O_Ka52_RU",
	"CUP_B_AH1Z_Dynamic_USMC",
	"CUP_B_AH1_DL_BAF",
	"CUP_B_Mi24_D_Dynamic_CDF",
	"CUP_B_AH64D_DL_USA",
	"CUP_B_Mi35_Dynamic_CZ_Tiger",
	//APC
	"B_APC_Wheeled_01_cannon_F",
	"O_APC_Wheeled_02_rcws_F",
	"B_AFV_Wheeled_01_up_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	//APC CUP
	"CUP_B_BRDM2_ATGM_CDF",
	"CUP_B_LAV25M240_green",
	"CUP_B_Boxer_HMG_GER_DES",
	"CUP_O_GAZ_Vodnik_BPPU_RU",
	"CUP_B_AAV_USMC",
	"CUP_O_T34_TKA",
	"CUP_B_M1128_MGS_Desert",
	//CUP FRIGATE
	"CUP_I_Frigate_AAF",
	//RHS RUSSIA TANK
	"rhs_zsu234_aa","ZSU-23-4",
	"rhs_t72ba_tv",
	"rhs_t80um",
	"rhs_t80bvk",
	"rhs_t72be_tv",
	"rhs_t90_tv",
	"rhs_t90sab_tv",
	"rhs_t14_tv","T-14",
	//RHS RUSSIA ATTACK HELI
	"RHS_Mi24V_vdv","Mi-24V",
	"RHS_Mi24V_vvs","Mi-24V",
	"RHS_Ka52_vvsc","Ka-52",
	"RHS_Ka52_vvs","Ka-52",
	"rhs_mi28n_vvsc","Mi-28N",
	"rhs_mi28n_vvs","Mi-28N",
	"HELPER"
]; //LIST OF VEHICLES TO DISABLE DAMAGE ON PLAYER ON BRPVP_noDamageVehDays

BRPVP_lootTypeChance = [
	[0,100], //CLOTHING
	[1,100], //BACK PACKS
	[2,100], //EQUIPMENTS
	[3,100], //PISTOLS
	[4,120], //ASSAULT RIFLES
	[5,110], //MACHINE GUNS
	[6,110], //SNIPERS
    [7,100], //OPTICS
    [8,100], //WEAPON ACESSORIES
    [9,110], //LAUNCHERS
    [10,100], //EXPLOSIVES
    [11,100], //CONSTRUCTION
    [12,100], //EXTRA ITEMS
	[13,100], //ILLEGAL ITEMS
	[14,100], //FOOD ITEMS
	[15,100] //SPECIAL BOX LOOT
];

BRPVP_kitGroupsCanDestroyCfg = [
	[{BRP_kitLight},3],
	[{BRP_kitAreia},4],
	[{BRP_kitCidade},4],
	[{BRP_kitStone},4],
	[{BRP_kitConcreto},5],
	[{BRP_kitGates},15],
	[{BRP_kitPedras},10],
	[{BRP_kitMilitarSign},5],
	[{BRP_kitLamp},6],
	[{BRP_kitContainers},4],
	[{BRP_kitWrecks},5],
	[{BRP_kitMovement},5],
	[{BRP_kitCamuflagem},6],
	[{BRP_kitBunkers},20]
];

//DRONES
BRPVP_dronesMakeAllUnarmed = false;
BRPVP_dronesPriceMultiply = 1;

//MAGUS WORLD
BRPVP_useTireAutoMoveToTime = 900; //V139: 1200
BRPVP_useTireAutoMoveToTimeLastVeh = 1800; //V139: 3600
BRPVP_useTireVehiclesOnStart = true;
BRPVP_useTireCanMoveToMagus = true;
BRPVP_tireExtraGetTime = [
	["CUP_B_ZUBR_CDF",4],
	["CUP_I_Frigate_AAF",5]
];

BRPVP_baseRespawnDelay = 60; //DELAY IN SECONDS

//COMBINATION OF FLAGS ALLOWED
BRPVP_flagCombinationAllowed = [
	[25],
	[50],
	[100],
	[200],
	[25,25],
	[50,25],
	[100,25],
	[200,25],
	[50,50],
	[100,50],
	[200,50],
	[25,25,25],
	[50,25,25],
	[100,25,25],
	[200,25,25],
	[25,50,25],
	[50,50,25],
	[100,50,25],
	[200,50,25]
];

//FOOD
BRPVP_foodCycle = 10; //ONE IN EACH X LOOTS WILL HAVE FOOD
BRPVP_foodEatCycle = 1800; //MAXIMUM TIME (IN SECONDS) BETWEEN EATS TO STAY ALIVE
BRPVP_foodEnergeticTime = 3600; //ENERGETIC EFFECT TIME
BRPVP_foodClassArray = ["BRPVP_foodApple","BRPVP_foodCanned","BRPVP_foodBread","BRPVP_foodWater","BRPVP_foodCake","BRPVP_foodBurger"];
BRPVP_foodAiUnitChance = 0.1; //FROM 0 (0%) to 1 (100%)

//FUEL CONSUME
BRPVP_extraFuelConsumeClass = ["Motorcycle","Car","Tank","Ship","Helicopter","Plane"];
BRPVP_extraFuelConsume = [20,20,20,20,30,30]; //TIME TO LAST IN MINUTES

//BANDIT NO VEH TIME
BRPVP_banditNoVehTime = 20; //V139: 45

//MASTER KEY EFFECT DURATION
BRPVP_masterKeyDuration = 10800; //3 HOURS

//KILL MAP
BRPVP_killMapCalculateEachFiveMinutes = true;

//BRPVP TRACERS
BRPVP_tracerModel = "a3\weapons_f\data\bullettracer\shell_tracer_green.p3d";
BRPVP_tracerModelForced = "a3\weapons_f\data\bullettracer\shell_tracer_red.p3d";
BRPVP_tracerModelAI = "a3\weapons_f\data\bullettracer\shell_tracer_yellow.p3d";

//REMOVE VEHICLES FROM TRADERS AND VEHICLE MISSION
//STILL ACESSIBLE BY ADMINS
BRPVP_deniedVehiclesVehMission = [
	//DRONES
	//"B_T_UAV_03_dynamicLoadout_F",
	//"O_UAV_02_dynamicLoadout_F",
	//"B_UAV_05_F",
	//"O_T_UAV_04_CAS_F",
	//CUP DRONES
	//"CUP_B_USMC_DYN_MQ9",
	//ARTY
	//"B_MBT_01_arty_F",
	//"O_MBT_02_arty_F",
	//"B_MBT_01_mlrs_F",
	//"I_E_Truck_02_MRL_F",
	//CUP ARTY
	//"CUP_B_BM21_CDF",
	//"CUP_B_RM70_CZ",
	//JETS
	//"O_T_VTOL_02_infantry_dynamicLoadout_F",
	//"I_Plane_Fighter_03_dynamicLoadout_F",
	//"O_Plane_CAS_02_dynamicLoadout_F",
	//"I_Plane_Fighter_04_F",
	//"B_Plane_CAS_01_dynamicLoadout_F",
	//"B_Plane_Fighter_01_F",
	//"O_Plane_Fighter_02_F",
	//JETS CUP
	//"CUP_B_Su25_Dyn_CDF",
	//"CUP_B_JAS39_HIL",
	//"CUP_B_F35B_USMC",
	//"CUP_B_AV8B_DYN_USMC",
	//"CUP_B_A10_DYN_USA",
	//"CUP_B_SU34_CDF",
	//TANKS
	//"B_APC_Tracked_01_rcws_F",
	//"I_APC_tracked_03_cannon_F",
	//"B_APC_Tracked_01_AA_F",
	//"O_APC_Tracked_02_AA_F",
	//"O_APC_Tracked_02_cannon_F",
	//"O_MBT_02_cannon_F",
	//"I_MBT_03_cannon_F",
	//"B_MBT_01_cannon_F",
	//"B_MBT_01_TUSK_F",
	//"O_MBT_04_command_F",
	//TANKS CUP
	//"CUP_B_Challenger2_2CD_BAF",
	//"CUP_B_Leopard2A6DST_GER",
	//"CUP_B_ZSU23_CDF",
	//"CUP_O_T90_RU",
	//"CUP_B_M1A1_DES_US_Army",
	//"CUP_B_M1A2_TUSK_MG_US_Army",
	//ATTACK HELIS
	//"B_Heli_Attack_01_dynamicLoadout_F",
	//"O_Heli_Attack_02_dynamicLoadout_F",
	//"O_Heli_Attack_02_dynamicLoadout_black_F",
	//ATTACK HELIS CUP
	//"CUP_O_Ka52_RU",
	//"CUP_B_AH1Z_Dynamic_USMC",
	//"CUP_B_AH1_DL_BAF",
	//"CUP_B_Mi24_D_Dynamic_CDF",
	//"CUP_B_AH64D_DL_USA",
	//RHS RUSSIA TANK
	//"rhs_zsu234_aa","ZSU-23-4",
	//"rhs_t72ba_tv",
	//"rhs_t80um",
	//"rhs_t80bvk",
	//"rhs_t72be_tv",
	//"rhs_t90_tv",
	//"rhs_t90sab_tv",
	//"rhs_t14_tv","T-14",
	////RHS RUSSIA ATTACK HELI
	//"RHS_Mi24V_vdv","Mi-24V",
	//"RHS_Mi24V_vvs","Mi-24V",
	//"RHS_Ka52_vvsc","Ka-52",
	//"RHS_Ka52_vvs","Ka-52",
	//"rhs_mi28n_vvsc","Mi-28N",
	//"rhs_mi28n_vvs","Mi-28N",
	"HELPER"
];
BRPVP_deniedVehiclesBlackTrader = [
	//DRONES
	//"B_T_UAV_03_dynamicLoadout_F",
	//"O_UAV_02_dynamicLoadout_F",
	//"B_UAV_05_F",
	//"O_T_UAV_04_CAS_F",
	//CUP DRONES
	//"CUP_B_USMC_DYN_MQ9",
	//ARTY
	//"B_MBT_01_arty_F",
	//"O_MBT_02_arty_F",
	//"B_MBT_01_mlrs_F",
	//"I_E_Truck_02_MRL_F",
	//CUP ARTY
	//"CUP_B_BM21_CDF",
	//"CUP_B_RM70_CZ",
	//JETS
	//"O_T_VTOL_02_infantry_dynamicLoadout_F",
	//"I_Plane_Fighter_03_dynamicLoadout_F",
	//"O_Plane_CAS_02_dynamicLoadout_F",
	//"I_Plane_Fighter_04_F",
	//"B_Plane_CAS_01_dynamicLoadout_F",
	//"B_Plane_Fighter_01_F",
	//"O_Plane_Fighter_02_F",
	//JETS CUP
	//"CUP_B_Su25_Dyn_CDF",
	//"CUP_B_JAS39_HIL",
	//"CUP_B_F35B_USMC",
	//"CUP_B_AV8B_DYN_USMC",
	//"CUP_B_A10_DYN_USA",
	//"CUP_B_SU34_CDF",
	//TANKS
	//"B_APC_Tracked_01_rcws_F",
	//"I_APC_tracked_03_cannon_F",
	//"B_APC_Tracked_01_AA_F",
	//"O_APC_Tracked_02_AA_F",
	//"O_APC_Tracked_02_cannon_F",
	//"O_MBT_02_cannon_F",
	//"I_MBT_03_cannon_F",
	//"B_MBT_01_cannon_F",
	//"B_MBT_01_TUSK_F",
	//"O_MBT_04_command_F",
	//TANKS CUP
	//"CUP_B_Challenger2_2CD_BAF",
	//"CUP_B_Leopard2A6DST_GER",
	//"CUP_B_ZSU23_CDF",
	//"CUP_O_T90_RU",
	//"CUP_B_M1A1_DES_US_Army",
	//"CUP_B_M1A2_TUSK_MG_US_Army",
	//ATTACK HELIS
	//"B_Heli_Attack_01_dynamicLoadout_F",
	//"O_Heli_Attack_02_dynamicLoadout_F",
	//"O_Heli_Attack_02_dynamicLoadout_black_F",
	//ATTACK HELIS CUP
	//"CUP_O_Ka52_RU",
	//"CUP_B_AH1Z_Dynamic_USMC",
	//"CUP_B_AH1_DL_BAF",
	//"CUP_B_Mi24_D_Dynamic_CDF",
	//"CUP_B_AH64D_DL_USA",
	"HELPER"
];

BRPVP_spcItemsClass = "Land_GasTank_01_blue_F";

//SPECIAL ITEM ON LOOT: CHANCE PER AI KILLED, DROPED BY AI
BRPVP_weaponTestLootChance = 0.0025;
BRPVP_baseBombDropChance = 0.01; //CHANCE TO EACH KILLED BOT TO DROP A BASE BOMB
BRPVP_antiBaseBombDropChance = 0.0025; //CHANCE TO EACH KILLED BOT TO DROP A ANTI BASE BOMB
BRPVP_masterKeyDropChance = 0.03; //CHANCE TO EACH KILLED BOT TO DROP A MASTER KEY
BRPVP_rearmVehDropChance = 0.01;
BRPVP_xrayDropChance = 0.0025;
BRPVP_upackDropChance = 0.0125;
BRPVP_atmFixDropChance = 0.0025;
BRPVP_selfReviveDropChance = 0.01;
BRPVP_plusTorqueDropChance = 0.01;
BRPVP_possessionDropChance = 0.0025;
BRPVP_possessionDropChanceArray = ["BRPVP_possession","BRPVP_possession","BRPVP_possession","BRPVP_possession","BRPVP_possession","BRPVP_possession","BRPVP_possessionStrong","BRPVP_possessionStrong","BRPVP_possessionStrong","BRPVP_possessionPlayer"];
BRPVP_trenchChance = 0.01;
BRPVP_baseBoxUpgradeChance = 0.005;
BRPVP_minervaShotChance = 0.00625;
BRPVP_atomicShotChance = 0.00005;
BRPVP_prideAtomicShotChance = 0.00005;
BRPVP_baseMineChance = 0.0025;
BRPVP_playerLaunchSuperChance = 0.005;
BRPVP_miraculousEyeDropChance = 0.0025;

//FARM
BRPVP_farmAndCraftTime = 4; //TIME TO FARM OR TO CRAFT IN SECONDS
BRPVP_farmRewardNumberItems = [1,2,2,3,3,3];
BRPVP_farmPrivateItemPrice = 5000;
BRPVP_farmItemPricePlayerWork = 1000;

//ARMED VEHICLES TO PLAYERS MISSION
BRPVP_vehMissionEnable = true;
BRPVP_vehMissionMaxMissions = 3; //V139: 5
BRPVP_vehMissionAIMult = 1;
BRPVP_vehMissionCycle = 3600; //IN SECONDS
BRPVP_vehMissionCycleRandom = 900; //IN SECONDS
//[VEHICLE TYPE,CHANCE,[HMG TURRET,AT TURRET,AA TURRET]]
BRPVP_vehMissionCfg = [
	[1,40,[0,0,0]], //1 - QILIN, STRIDER
	[2,25,[1,0,0]], //2 - NYX, GORGON
	[3,15,[2,0,0]], //3 - MEDIUM TANKS
	[4,07,[2,1,0]],	//4 - HELIS
	[5,03,[2,2,0]], //5 - HEAVY TANKS
	[6,03,[2,2,0]], //6 - ATTACK HELIS
	[7,03,[2,2,1]], //7 - JETS
	[8,02,[2,2,1]], //8 - ATTACK DRONES
	[9,02,[2,2,2]]	//9 - ARTILLERY
];

//RARE ITENS
BRPVP_rareItemsChance = 0.4;
BRPVP_missionLootChanceOfRareItems = [
	15.0,//LAUNCHERS I
	15.0,//LAUNCHERS II
	15.0,//SNIPERS
	15.0,//MMG
	10.0,//NVGS
	10.0,//GUILLIES
	10.0,//PROTECTION
	10.0//OTHERS
];
BRPVP_rareExtraLootInBoxA = [
	"Titan_AA",
	"Titan_AT",
	//CUP
	"CUP_Dragon_EP1_M",
	"CUP_NLAW_M",
	"CUP_M136_M",
	"CUP_Javelin_M",
	"CUP_Igla_M",
	"CUP_Stinger_M",
	"CUP_Strela_2_M"
];

//FIRST PERSON AREAS
BRPVP_firstPersonAreas = [
	//[position,distance]
];

//BRPVP CARRY VEH HELIS
BRPVP_carryHelisPrice = 75000;
BRPVP_carryHelis = [
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Transport_03_unarmed_green_F",
	"I_Heli_Transport_02_F",
	"O_Heli_Transport_04_covered_black_F",
	"O_Heli_Light_02_unarmed_F",
	"I_Heli_light_03_unarmed_F",
	"CUP_B_CH53E_USMC",
	"CUP_I_SA330_Puma_HC2_RACS",
	"rhsusf_CH53E_USMC_GAU21_D"
];
BRPVP_carryHelisOffset = [
	[0,0,-6],
	[0,0,-6],
	[0,0,-7],
	[0,0,-5],
	[0,0,-5],
	[0,0,-5],
	[0,0,-7],
	[0,0,-5],
	[0,0,-7] //CHECK IF -7 IS OK
];

//MISSION VALUE MULTIPLIER
BRPVP_missionValueMult = 1;

//SIDE CHANNEL
BRPVP_enableSideVoice = false;

//LINKS
BRPVP_linksUrls = [
	["BRPVP World Site:","http://www.brpvp.com","http://www.brpvp.com"],
	["Creator's Steam:","https://steamcommunity.com/profiles/76561197975554637/","https://steamcommunity.com/profiles/76561197975554637/"]
];
BRPVP_linksUrlsAccess = [
	["Acesso:","http://www.brpvp.com.br","http://www.brpvp.com.br"]
];

//REMOTE CONTROL
BRPVP_remoteControlUsesToFinish = 200;

//VIRTUAL GARAGE
if (hasInterface) then {
	BRPVP_virtualGarageTimeToStore = 600; //TIME IN SECONDS
	BRPVP_virtualGarageEverywhere = false; //IF TRUE, PLAYERS CAN PULL VEHICLES FROM VIRTUAL GARAGE EVERYWHERE
	BRPVP_virtualGarageLimit = [
		//CARS (ARMOR < 100)
		[
			{(_this isKindOf "Car" || _this isKindOf "Motorcycle") && !(_this isKindOf "Wheeled_APC_F") && !(typeOf _this in BRPVP_vantVehiclesClass) && {getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "armor") < 100}},
			{(_this isKindOf ["Car",configFile >> "CfgVehicles"] || _this isKindOf ["Motorcycle",configFile >> "CfgVehicles"]) && !(_this isKindOf ["Wheeled_APC_F",configFile >> "CfgVehicles"]) && !(_this in BRPVP_vantVehiclesClass) && {getNumber (configFile >> "CfgVehicles" >> _this >> "armor") < 100}},
			1,
			localize "str_vg_car",
			[[BRPVP_centroMapa,BRPVP_centroMapaRadius]],
			localize "str_vg_area_anywere",
			15000, //PRICE
			false
		],
		//CARS BLINDED (ARMOR >= 100)
		[
			{(_this isKindOf "Car" || _this isKindOf "Motorcycle") && !(_this isKindOf "Wheeled_APC_F") && !(typeOf _this in BRPVP_vantVehiclesClass) && {getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "armor") >= 100}},
			{(_this isKindOf ["Car",configFile >> "CfgVehicles"] || _this isKindOf ["Motorcycle",configFile >> "CfgVehicles"]) && !(_this isKindOf ["Wheeled_APC_F",configFile >> "CfgVehicles"]) && !(_this in BRPVP_vantVehiclesClass) && {getNumber (configFile >> "CfgVehicles" >> _this >> "armor") >= 100}},
			1,
			localize "str_vg_car_strong",
			BRPVP_travelingAidPlaces,
			localize "str_vg_area_travel_aid",
			50000, //PRICE
			false
		],
		//APCS
		[
			{_this isKindOF "Wheeled_APC_F" && !(typeOf _this in BRPVP_vantVehiclesClass)},
			{_this isKindOF ["Wheeled_APC_F",configFile >> "CfgVehicles"] && !(_this in BRPVP_vantVehiclesClass)},
			1,
			localize "str_vg_apc",
			BRPVP_travelingAidPlaces,
			localize "str_vg_area_travel_aid",
			100000, //PRICE
			false
		],
		//TANKS
		[
			{_this isKindOf "Tank" && !(typeOf _this in BRPVP_vantVehiclesClass)},
			{_this isKindOF ["Tank",configFile >> "CfgVehicles"] && !(_this in BRPVP_vantVehiclesClass)},
			1,
			localize "str_vg_tank",
			BRPVP_travelingAidPlaces,
			localize "str_vg_area_travel_aid",
			150000,  //PRICE
			false
		],
		//HELIS
		[
			{_this isKindOf "Helicopter" && !(typeOf _this in BRPVP_vantVehiclesClass)},
			{_this isKindOF ["Helicopter",configFile >> "CfgVehicles"] && !(_this in BRPVP_vantVehiclesClass)},
			1,
			localize "str_vg_heli",
			BRPVP_travelingAidPlaces+BRPVP_airportAreas,
			"("+localize "str_vg_area_travel_aid"+", "+localize "str_vg_area_airport"+")",
			125000, //PRICE
			false
		],
		//PLANES AND JETS
		[
			{_this isKindOf "Plane" && !(typeOf _this in BRPVP_vantVehiclesClass)},
			{_this isKindOF ["Plane",configFile >> "CfgVehicles"] && !(_this in BRPVP_vantVehiclesClass)},
			0,
			localize "str_vg_plane",
			BRPVP_airportAreas,
			localize "str_vg_area_airport",
			200000, //PRICE
			true
		],
		//SHIP
		[
			{_this isKindOf "Ship" && !(typeOf _this in BRPVP_vantVehiclesClass)},
			{_this isKindOF ["Ship",configFile >> "CfgVehicles"] && !(_this in BRPVP_vantVehiclesClass)},
			2,
			localize "str_vg_ship",
			[[BRPVP_centroMapa,BRPVP_centroMapaRadius]],
			localize "str_vg_area_anywere",
			50000, //PRICE
			false
		],
		//LIGHT DRONES
		[
			{typeOf _this in BRPVP_vantVehiclesClass && !(typeOf _this in BRPVP_vantVehiclesClassAttack)},
			{_this in BRPVP_vantVehiclesClass && !(_this in BRPVP_vantVehiclesClassAttack)},
			1,
			localize "str_vg_uav",
			[[BRPVP_centroMapa,BRPVP_centroMapaRadius]],
			localize "str_vg_area_anywere",
			25000, //PRICE
			false
		],
		//ATTACK DRONES
		[
			{typeOf _this in BRPVP_vantVehiclesClassAttack},
			{_this in BRPVP_vantVehiclesClassAttack},
			0,
			localize "str_vg_attack_uav",
			BRPVP_travelingAidPlaces+BRPVP_airportAreas,
			"("+localize "str_vg_area_travel_aid"+", "+localize "str_vg_area_airport"+")",
			200000, //PRICE
			true
		]
	];
};

//HACK A PLAYER VARS
BRPVP_hackPercentage = 0.1;
BRPVP_hackMoneyLimit = 10000000;
BRPVP_hackTimeNoMoveToComplete = 20; //IN SECONDS
BRPVP_hackLineTimeWait = 15; //IN SECONDS
BRPVP_hackOnHackMoveLimit = 20; //IN METERS

//BASE CONSTRUCTION CONFIGURATION
BRPVP_flagsMinimumDistance = -1; //MIN DISTANCE BETWEEN FLAG AREAS BORDERS
BRPVP_flagsAreasIntersectionAllowed = 0.6; //DEFAULT IF 60% INTERSECTION ALLOWED (TO WORK, BRPVP_flagsMinimumDistance MUST BE -1)
BRPVP_flagsMinimumDistanceEnemy = 750;
BRPVP_daysWithoutMantainToFlagDisapears = 20;
BRPVP_daysWithoutMantainToFlagDisapearsPrice = [/*25M FLAG*/2500000,/*50M FLAG*/5000000,/*100M FLAG*/10000000,/*200M FLAG*/20000000];
BRPVP_constructionObjectsMustBeGrounded = false;

//CONFIGURATION
BRPVP_terrainGrid = 25;
BRPVP_terrainGridLook = 25;
BRPVP_terrainGridOnZoom = 8;
BRPVP_pylonChangePrice = 50000;
BRPVP_waterBasesLimitUse = true;
BRPVP_waterBasesLimitDistance = 2500; //V139: 1500
BRPVP_baseSignHackPrice = 350000;
BRPVP_baseSignPrice = 200000;
BRPVP_baseSignClass = "Land_InfoStand_V1_F";
BRPVP_hulkPillsTime = 60;
BRPVP_hulkPillsTimeOutBase = 120;
BRPVP_distanceToSpawnLoot = 5;
BRPVP_vehOwnerityChangePrice = 750000;
BRPVP_missionSleepTime = 900; //IN SECONDS
BRPVP_freezeFloorTime = 15; //FREEZE TIME IN SECONDS
BRPVP_freezeFloorCollDown = 180; //COOL DOWN ON VEHICLE AFTER FREEZE
BRPVP_showZombieSpawnHint = false;
BRPVP_bornWithItems = true;
BRPVP_killAIReward = 2500;
BRPVP_maxAlignedGates = 4;
BRPVP_coverPrice = 500000;
BRPVP_killPercToLiberateBox = 0.7; //WORKS FOR SIEGE AND BRAVO POINT MISSIONS
BRPVP_hackObjectsOneTimeOnly = true;
BRPVP_artilleryLimit = [["I_E_Truck_02_MRL_F","B_MBT_01_mlrs_F","B_MBT_01_arty_F","O_MBT_02_arty_F","CUP_B_BM21_CDF","CUP_B_RM70_CZ"],[5,5,1,1,0,0],[2,2,1,1,1,1]];
BRPVP_lootDeniedItemsFromTraders = [[2,2],[2,3],[3,2],[3,4],[4,4],5,6,[9,0],[9,2],11,12,13,14,15];
BRPVP_deniedItems = [
	//TITAN LAUNCHERS
	"launch_Titan_F",
	"launch_B_Titan_F",
	"launch_I_Titan_F",
	"launch_O_Titan_F",
	"launch_B_Titan_tna_F",
	"launch_O_Titan_ghex_F",
	"launch_Titan_short_F",
	"launch_B_Titan_short_F",
	"launch_I_Titan_short_F",
	"launch_O_Titan_short_F",
	"launch_B_Titan_short_tna_F",
	"launch_O_Titan_short_ghex_F",	
	//THERMAL WEAPONS
	"arifle_Katiba_GL_Nstalker_pointer_F",
	//THERMAL
	"optic_Nightstalker",
	"optic_tws",
	"optic_tws_mg"
];
BRPVP_AIMagazinesRemove = []; //TO REMOVE TITAN MISSILES FROM AI USE: ["Titan_AT","Titan_AA"]
BRPVP_defaultBipodWeapons = [
	"arifle_MX_SW_F",
	"arifle_MX_SW_Black_F",
	"arifle_MX_SW_khk_F",
	"arifle_SPAR_02_blk_F",
	"arifle_SPAR_02_khk_F",
	"arifle_SPAR_02_snd_F",
	"MMG_01_hex_F",
	"MMG_01_tan_F",
	"MMG_02_camo_F",
	"MMG_02_black_F",
	"MMG_02_sand_F"
];
BRPVP_classRemoveTurret = [];
BRPVP_personalSmartTvPrice = 85000;
BRPVP_personalShieldPrice = 50000;
BRPVP_personalShieldLife = 1;
BRPVP_personalTowerPrice = 100000;
BRPVP_personalBushPrice = 50000;
BRPVP_vaultClassNames = ["Box_IDAP_Equip_F","Box_NATO_Equip_F","Box_CSAT_Equip_F","Box_AAF_Equip_F","Box_GEN_Equip_F","Box_NATO_Uniforms_F","Box_CSAT_Uniforms_F","Box_AAF_Uniforms_F","Box_IDAP_Uniforms_F","Box_EAF_Uniforms_F"];
BRPVP_vaultPrice = 5000;
BRPVP_vaultPriceOutPlace = 75000;
BRPVP_vaultPriceOutPlaceNoPerk = 500000;
BRPVP_gateTerrainLimit = [[25,10],[50,20],[100,30],[200,50]];
BRPVP_AIDeadTimeToDeletionElegible = 1200; //HOW MUCH SECONDS AFTER DIE THE AI BODY WILL BE ELEGIBLE TO BE DELETED. DEFAULT: 20 MINUTES/1200 SECONDS
BRPVP_AIGroupDeadTimeBodies = 300;
BRPVP_deadAiForceDeletionTime = 5400; //FORCE DEAD AI TO BE DELETED AFTER 1.5 HOURS EVEN IF THERE ARE PLAYERS NEAR. MUST BE EQUAL OR GREATER THAN BRPVP_AIDeadTimeToDeletionElegible.
BRPVP_spotPlayersOnMap = true;
BRPVP_headPriceSpotConsumePerMinute = 12000000;
BRPVP_headPriceSpotMaxFundsPerPlayer = 5*12000000;
BRPVP_bulletDistanceToAlertAI = 10; //IN METERS. MAX IS 30.
BRPVP_bulletDistanceToAlertAIOptimize = 1.5;
BRPVP_whiteNameVisionLimit = 35;
BRPVP_moneyItems = [["FlareWhite_F","FlareYellow_F","FlareGreen_F","FlareRed_F","UGL_FlareWhite_F","UGL_FlareYellow_F","UGL_FlareGreen_F","UGL_FlareRed_F"],[2000,10000,50000,200000,500000,1000000,2500000,5000000]]; //STILL CAN USE "UGL_FlareCIR_F"
BRPVP_moneyItemsStoreLimit = 25000000;
BRPVP_totalMoneyInBank = 100000000;
BRPVP_lockPickChanceOfSuccess = 0.98;
BRPVP_personalAtmRate = 0.025;
BRPVP_showKonvoyMapIcons = true;
BRPVP_transferDistanceLimit = 75;
BRPVP_squadInviteExpirationTime = 180; //SQUAD INVITE EXPIRATION TIME IN SECONDS
BRPVP_objRemoveOriginalPricePercentage = 0.05;
BRPVP_objRemoveOriginalPricePercentageAditionalForFastRemove = 0.05;
BRPVP_travelingAidPriceLevel = 0.8;
BRPVP_playerLifeMultiplier = 1.5;
BRPVP_playerCurePlacesCoolDown = 300;
BRPVP_killedVehicleLootSavePercentage = [0.6,0.5,0.5,0.5]; //[weapons,mags,items,bags]
BRPVP_maxDistanceToGiveHandMoney = 5; //IN METERS
BRPVP_maxPlayerDeadBodyCount = 4;
BRPVP_maxPlayerDeadBodyTime = 5400; //IN SECONDS
BRPVP_combatTimeLengthNormal = 30; //IN SECONDS - COMBAT MODE TIME WHEN SHOTHING
BRPVP_combatTimeLengthStrong = 150; //IN SECONDS - COMBAT MODE TIME WHEN YOU HIT AN ENEMY PLAYER
BRPVP_afterDieMaxSpawnCounterInSeconds = 30;
BRPVP_afterDieMaxSpawnCounterInSecondsIfPlayerKill = 120;
BRPVP_binocularToIgnoreAsWeapon = ["Binocular","Rangefinder","Laserdesignator","Laserdesignator_01_khk_F","Laserdesignator_02","Laserdesignator_02_ghex_F","Laserdesignator_03"];
BRPVP_dismantleRespawnPrice = 100000;
BRPVP_rulesRequireAccept = false;
BRPVP_rulesList = [
	"1) Rule 1",
	"2) Rule 2",
	"3) Rule 3",
	"4) Rule 4",
	"5) Rule 5"
];
BRPVP_turretHeadDamageToDie = 45;
BRPVP_turretHeadDamageToDieLvl2 = 60;
BRPVP_turretTerrainLimit = [[25,10],[50,20],[100,35],[200,50]];
BRPVP_autoTurretTypes = ["I_HMG_01_high_F","I_HMG_01_F","I_static_AT_F","I_static_AA_F"];
BRPVP_autoTurretOnMan = ["I_HMG_01_high_F","I_HMG_01_F"];
BRPVP_autoTurretOnLandVehicle = ["I_HMG_01_high_F","I_HMG_01_F","I_static_AT_F"];
BRPVP_autoTurretOnAirVehicle = ["I_HMG_01_high_F","I_HMG_01_F","I_static_AA_F"];
BRPVP_autoTurretOnFlyLandVehicle = ["I_HMG_01_high_F","I_HMG_01_F","I_static_AT_F","I_static_AA_F"];
BRPVP_autoTurretOnFlyLandVehicleHeavyArmor = ["I_static_AT_F"];
BRPVP_autoTurretSkill = 0.3;
BRPVP_autoTurretSkillBase = 0.3;
BRPVP_stayOnlineMoneyRewardValor = 200000;
BRPVP_stayOnlineMoneyRewardInterval = 3600; //IN SECONDS
BRPVP_stayOnlineMoneyRewardExtraCycle = 3;
BRPVP_stayOnlineMoneyRewardExtraValor = 300000;
BRPVP_sellPricesMultiplier = 0.15; //PLAYER SELL PRICES CUT
BRPVP_sellMultVeh = 0.4; //SELL PERCENTAGE OF TRADER VEHICLES AND UNPRICED FEDIDEX VEHICLES
BRPVP_sellMultVehPricedFedidex = 0.6; //SELL PERCENTAGE OF PRICED FEDIDEX VEHICLES
BRPVP_restartTimes = [6,12,18,24]; //REINICIAR AS HORAS NO FORMATO 24H
BRPVP_restartWarnings = [60,30,20,10,5,3,2,1]; //AVISOS DE REINICIALIZAÇÃO A SEREM EXIBIDOS X MINUTOS ANTES DA REINICIALIZAÇÃO (X <= 30)
BRPVP_tempoDeVeiculoTemporarioNascimento = 3600; // Tempo de veiculo temporario nascimento em segundos 
BRPVP_veiculoTemporarioNascimento = "CUP_C_Golf4_kitty_Civ"; // Carro de nascimento
BRPVP_renewLootTime = 900;
BRPVP_fullMoonNights = true;
BRPVP_fullMoonNightsChance = 0.5;
BRPVP_timeMultiplier = 12;
BRPVP_fasterNights = true;
BRPVP_patrolAIGroups = [
	(configFile >> "CfgGroups" >> "West" >> "Guerilla" >> "Infantry"),
	(configFile >> "CfgGroups" >> "West" >> "Guerilla" >> "Support"),
	(configFile >> "CfgGroups" >> "Indep" >> "IND_C_F" >> "Infantry")
];

//Configurações para entrada inicial no servidor
BRPVP_startingMoney = 15000;
BRPVP_startingMoneyOnBank = 115000;
BRPVP_towLandVehiclePrice = 5000;
BRPVP_marketPricesMultiply = 1;
BRPVP_marketPricesMultiplyVeh = [1,0];

//RADAR SPOTS
BRPVP_antennasObjs = ["Land_TTowerSmall_1_F","Land_TTowerSmall_2_F","Land_TTowerBig_1_F","Land_TTowerBig_2_F","I_LT_01_scout_F"];
BRPVP_antennasObjsForce = [[600,0.2,5],[400,0.1,2],[1200,0.25,5],[900,0.1,2],[1500,0.05,1.5]];


//SHOW PORTUGUESE IMAGES ONLY IF LANGUAGE IS PORTUGUESE
if (localize "str_language_is_portuguese" isEqualTo "true") then {BRPVP_showTutorialFlag = false;} else {BRPVP_showTutorialFlag = false;};

//BAG SOLDIER GEAR OPTIONS
BRPVP_bagSoldierClasses = [
	"C_Nikos",
	"C_Protagonist_VR_F",
	"C_Story_EOD_01_F",
	"B_G_Soldier_A_F",
	"B_GEN_Commander_F",
	"B_Diver_F",
	"B_Fighter_Pilot_F",
	"B_Soldier_TL_F",
	"B_sniper_F",
	"B_ghillie_ard_F",
	"B_Captain_Pettka_F",
	"B_W_Soldier_SL_F",
	"B_CTRG_Soldier_AR_tna_F",
	"B_CTRG_Soldier_Exp_tna_F",
	"O_V_Soldier_Exp_hex_F",
	"B_W_Soldier_CBRN_F"
];

//CONSTRUCTION BUILDINGS THAT CAN'T BE SIMPLE OBJECTS
BRPVP_buildingHaveDoorList = [
	"Land_Hangar_F",
	"Land_MultistoryBuilding_03_F",
	"Land_Billboard_F",
	//SUPER BIG BOX
	BRPVP_superBoxClass,
	//CONTAINER
	"Land_Cargo40_red_F",
	"Land_Cargo40_light_green_F",
	"Land_Cargo20_blue_F",
	"Land_Cargo20_red_F",
	"Land_Cargo20_light_green_F",
	"Land_Cargo40_blue_F",
	//CONRADO
	"Land_FuelStation_01_shop_F",
	"Land_FuelStation_01_workshop_F",
	"Land_ControlTower_01_F",
	"Land_Lighthouse_03_red_F",
	"Land_Lighthouse_03_green_F",
	"Land_RoadBarrier_01_F",
	//MANY
	"Land_Pier_addon",
	"Land_ReservoirTower_F",
	"Land_spp_Tower_F",
	"Land_GarageRow_01_large_F",
	"Land_CementWorks_01_brick_F",
	"Land_Communication_F",
	"Land_LightHouse_F",
	"Land_BagBunker_Tower_F",
	"Land_RaiStone_01_F",
	//SMALL LIGHTS (AIRPORT)
	"Land_Flush_Light_green_F",
	"Land_Flush_Light_red_F",
	"Land_Flush_Light_yellow_F",
	"Land_runway_edgelight",
	"Land_runway_edgelight_blue_F",
	"Land_PortableHelipadLight_01_F",
	"PortableHelipadLight_01_blue_F",
	"PortableHelipadLight_01_red_F",
	"PortableHelipadLight_01_white_F",
	"PortableHelipadLight_01_green_F",
	"PortableHelipadLight_01_yellow_F",	
	"Land_Runway_PAPI",
	//BRPVP MALDEN
	"Land_Shed_02_F",
	"Land_Shed_05_F",
	//NEW GATES
	"Land_WoodenWall_02_s_gate_F",
	"Land_WiredFence_01_gate_F",
	"Land_PipeFence_01_m_gate_v2_closed_F",
	"Land_PipeFence_01_m_gate_v1_F",
	"Land_BackAlley_01_l_gate_F",
	"Land_NetFence_02_m_gate_v1_closed_F",	
	//ARENA OBJECTS
	"Land_WallCity_01_gate_grey_F",
	"Land_PierConcrete_01_4m_ladders_F",
	"Land_Kiosk_redburger_F",
	"Land_Shed_04_F",
	"Land_House_Big_01_F",
	"Land_Shed_01_F",
	//OTHERS
	"Sign_Sphere200cm_F",
	//NOVOS
	"Land_Airport_Tower_F",
	"Land_QuayConcrete_01_outterCorner_F",
	"Land_Airport_01_controlTower_F",
	"Land_Airport_02_controlTower_F",
	"Land_Airport_02_hangar_left_F",
	"Land_Airport_02_hangar_right_F",	
	"Land_Airport_01_hangar_F",
	"Land_Dome_Big_F",
	"Land_Shop_Town_03_F",
	"Land_Hotel_01_F",
	"Land_Warehouse_03_F",
	"Land_Hospital_side1_F",
	"Land_Hospital_main_F",
	"Land_Hospital_side2_F",
	"Land_GH_MainBuilding_entry_F",
	"Land_GH_MainBuilding_left_F",
	"Land_GH_MainBuilding_middle_F",
	"Land_GH_MainBuilding_right_F",
	"Land_Airport_center_F",
	"Land_Airport_left_F",
	"Land_Airport_right_F",
	"Land_Medevac_HQ_V1_F",
	"Land_i_Shed_Ind_F",
	"Land_Chapel_V1_F",
	"Land_Offices_01_V1_F",
	"Land_Barracks_01_camo_F",
	"Land_i_Barracks_V1_F",
	"Land_i_Barracks_V2_F",
	"Land_u_Barracks_V2_F",
	"Land_MilOffices_V1_F",
	"Land_GH_House_1_F",
	"Land_Medevac_house_V1_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_House_V3_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_HQ_V1_F",	
	//ORIGINAL GATES
	"Land_BarGate_F",
	"Land_Net_Fence_Gate_F",
	"Land_ConcreteWall_01_m_gate_F",
	"Land_ConcreteWall_01_l_gate_F",
	"Land_City_Gate_F",
	"Land_Stone_Gate_F",
	//ORIGINAL BUILDINGS
	"Land_Slum_House01_F",
	"Land_Slum_House02_F",
	"Land_Slum_House03_F",
	"Land_cmp_Shed_F",
	"Land_FuelStation_Build_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Dome_Small_F",
	"Land_Church_01_V1_F",
	"Land_Offices_01_V1_F",
	"Land_WIP_F",
	"Land_dp_mainFactory_F",
	"Land_i_Barracks_V1_F",
	//STORAGE AND FUEL OBJECTS
	"C_IDAP_supplyCrate_F",
	"Box_NATO_AmmoVeh_F",
	"Box_East_AmmoVeh_F",
	"Box_IND_AmmoVeh_F",
	"Box_T_East_WpsSpecial_F",
	"C_T_supplyCrate_F",
	"Box_Syndicate_Ammo_F",
	"Box_Syndicate_WpsLaunch_F",
	"BRPVP_C_IDAP_supplyCrate_F",
	"BRPVP_Box_NATO_AmmoVeh_F",
	"BRPVP_Box_East_AmmoVeh_F",
	"BRPVP_Box_IND_AmmoVeh_F",
	"BRPVP_Box_T_East_WpsSpecial_F",
	"BRPVP_C_T_supplyCrate_F",
	"BRPVP_Box_Syndicate_Ammo_F",
	"BRPVP_Box_Syndicate_WpsLaunch_F",
	//SMALL VANILLA HOUSES
	"Land_i_Addon_02_V1_F",
	"Land_i_House_Small_02_V1_F",
	"Land_i_House_Small_02_V2_F",
	"Land_i_House_Small_02_V3_F",
	"Land_GH_House_1_F",
	"Land_GH_House_2_F",
	"Land_i_House_Small_01_V1_F",
	"Land_i_House_Small_01_V2_F",
	"Land_i_Windmill01_F",
	//BIG VANILLA HOUSES
	"Land_i_House_Big_01_V1_F",
	"Land_i_House_Big_01_V2_F",
	"Land_i_House_Big_01_V3_F",
	"Land_i_House_Big_02_V1_F",
	"Land_i_House_Big_02_V2_F",
	"Land_i_House_Big_02_V3_F",
	"Land_i_Shop_01_V1_F",
	"Land_i_Shop_01_V2_F",
	"Land_i_Shop_02_V1_F",
	"Land_i_Shop_02_V2_F",
	"Land_i_Shop_02_V3_F",
	//KIT MOVEMENT
	"Land_PierLadder_F",
	//KIT LAMP
	"Land_LampStreet_02_triple_F",
	"Land_LampStreet_small_F",
	"Land_LampStreet_F",
	"Land_LampSolar_F",
	"Land_LampDecor_F",
	"Land_LampHalogen_F",
	"Land_LampHarbour_F",
	"Land_LampStadium_F",
	"Land_LampAirport_F",
	"Land_LampShabby_F",
	//RELIGIOUS KIT - ANTI ZOMBIE
	"Land_BellTower_01_V1_F",
	"Land_BellTower_02_V1_F",
	"Land_BellTower_02_V2_F",
	"Land_Calvary_01_V1_F",
	"Land_Calvary_02_V1_F",
	"Land_Calvary_02_V2_F",
	"Land_Grave_obelisk_F",
	"Land_Grave_memorial_F",
	"Land_Grave_monument_F",
	//AUTO DEFENCE TURRET
	"I_HMG_01_high_F",
	"I_HMG_01_F",
	"I_GMG_01_high_F",
	"I_GMG_01_F",
	"I_static_AA_F",
	"I_static_AT_F",
	//TARGET
	"TargetP_Inf_F",
	//ADMIN
	"Land_JumpTarget_F",
	"Land_FloodLight_F",
	"Land_Atm_01_F",
	"Land_Atm_02_F",
	"Land_PortableLight_single_F",
	"Land_PortableLight_double_F",
	"Land_Stadium_p9_F",
	"Land_Kiosk_papers_F",
	"Land_FuelStation_01_shop_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Airport_02_controlTower",
	"Land_Airport_Tower_F",
	//FLAGS
	"Flag_BI_F",
	"Flag_Blue_F",
	"Flag_Green_F",
	"Flag_Red_F",
	"Flag_RedCrystal_F",
	"Flag_White_F",
	"HELPER"
];
BRPVP_useComplexLocalBuildings = false;
BRPVP_buildingHaveDoorListCVL = [
	"Land_Hangar_F",
	//"Land_MultistoryBuilding_03_F",
	//"Land_Billboard_F",
	//SUPER BIG BOX
	//BRPVP_superBoxClass,
	//CONTAINER
	//"Land_Cargo40_red_F",
	//"Land_Cargo40_light_green_F",
	//"Land_Cargo20_blue_F",
	//"Land_Cargo20_red_F",
	//"Land_Cargo20_light_green_F",
	//"Land_Cargo40_blue_F",
	//CONRADO
	//"Land_FuelStation_01_shop_F",
	//"Land_FuelStation_01_workshop_F",
	//"Land_ControlTower_01_F",
	//"Land_Lighthouse_03_red_F",
	//"Land_Lighthouse_03_green_F",
	//"Land_RoadBarrier_01_F",
	//MANY
	//"Land_Pier_addon",
	//"Land_ReservoirTower_F",
	"Land_spp_Tower_F",
	"Land_GarageRow_01_large_F",
	"Land_CementWorks_01_brick_F",
	//"Land_Communication_F",
	//"Land_LightHouse_F",
	"Land_BagBunker_Tower_F",
	//"Land_RaiStone_01_F",
	//SMALL LIGHTS (AIRPORT)
	"Land_Flush_Light_green_F",
	"Land_Flush_Light_red_F",
	"Land_Flush_Light_yellow_F",
	"Land_runway_edgelight",
	"Land_runway_edgelight_blue_F",
	"Land_PortableHelipadLight_01_F",
	"PortableHelipadLight_01_blue_F",
	"PortableHelipadLight_01_red_F",
	"PortableHelipadLight_01_white_F",
	"PortableHelipadLight_01_green_F",
	"PortableHelipadLight_01_yellow_F",	
	"Land_Runway_PAPI",
	//BRPVP MALDEN
	"Land_Shed_02_F",
	"Land_Shed_05_F",
	//NEW GATES
	//"Land_WoodenWall_02_s_gate_F",
	//"Land_WiredFence_01_gate_F",
	//"Land_PipeFence_01_m_gate_v2_closed_F",
	//"Land_PipeFence_01_m_gate_v1_F",
	//"Land_BackAlley_01_l_gate_F",
	//"Land_NetFence_02_m_gate_v1_closed_F",	
	//ARENA OBJECTS
	"Land_WallCity_01_gate_grey_F",
	"Land_PierConcrete_01_4m_ladders_F",
	"Land_Kiosk_redburger_F",
	"Land_Shed_04_F",
	"Land_House_Big_01_F",
	"Land_Shed_01_F",
	//OTHERS
	//"Sign_Sphere200cm_F",
	//NOVOS
	"Land_Airport_Tower_F",
	"Land_QuayConcrete_01_outterCorner_F",
	"Land_Airport_01_controlTower_F",
	"Land_Airport_02_controlTower_F",
	"Land_Airport_02_hangar_left_F",
	"Land_Airport_02_hangar_right_F",	
	//"Land_Airport_01_hangar_F",
	"Land_Dome_Big_F",
	"Land_Shop_Town_03_F",
	"Land_Hotel_01_F",
	"Land_Warehouse_03_F",
	//"Land_Hospital_side1_F",
	//"Land_Hospital_main_F",
	//"Land_Hospital_side2_F",
	//"Land_GH_MainBuilding_entry_F",
	//"Land_GH_MainBuilding_left_F",
	//"Land_GH_MainBuilding_middle_F",
	//"Land_GH_MainBuilding_right_F",
	//"Land_Airport_center_F",
	//"Land_Airport_left_F",
	//"Land_Airport_right_F",
	"Land_Medevac_HQ_V1_F",
	"Land_i_Shed_Ind_F",
	"Land_Chapel_V1_F",
	"Land_Offices_01_V1_F",
	"Land_Barracks_01_camo_F",
	"Land_i_Barracks_V1_F",
	"Land_i_Barracks_V2_F",
	"Land_u_Barracks_V2_F",
	"Land_MilOffices_V1_F",
	"Land_GH_House_1_F",
	"Land_Medevac_house_V1_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_House_V3_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_HQ_V1_F",	
	//ORIGINAL GATES
	//"Land_BarGate_F",
	//"Land_Net_Fence_Gate_F",
	//"Land_ConcreteWall_01_m_gate_F",
	//"Land_ConcreteWall_01_l_gate_F",
	//"Land_City_Gate_F",
	//"Land_Stone_Gate_F",
	//ORIGINAL BUILDINGS
	"Land_Slum_House01_F",
	"Land_Slum_House02_F",
	"Land_Slum_House03_F",
	"Land_cmp_Shed_F",
	"Land_FuelStation_Build_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Dome_Small_F",
	"Land_Church_01_V1_F",
	"Land_Offices_01_V1_F",
	"Land_WIP_F",
	"Land_dp_mainFactory_F",
	"Land_i_Barracks_V1_F",
	//STORAGE AND FUEL OBJECTS
	//"C_IDAP_supplyCrate_F",
	//"Box_NATO_AmmoVeh_F",
	//"Box_East_AmmoVeh_F",
	//"Box_IND_AmmoVeh_F",
	//"Box_T_East_WpsSpecial_F",
	//"C_T_supplyCrate_F",
	//"Box_Syndicate_Ammo_F",
	//"Box_Syndicate_WpsLaunch_F",
	//"BRPVP_C_IDAP_supplyCrate_F",
	//"BRPVP_Box_NATO_AmmoVeh_F",
	//"BRPVP_Box_East_AmmoVeh_F",
	//"BRPVP_Box_IND_AmmoVeh_F",
	//"BRPVP_Box_T_East_WpsSpecial_F",
	//"BRPVP_C_T_supplyCrate_F",
	//"BRPVP_Box_Syndicate_Ammo_F",
	//"BRPVP_Box_Syndicate_WpsLaunch_F",
	//SMALL VANILLA HOUSES
	"Land_i_Addon_02_V1_F",
	"Land_i_House_Small_02_V1_F",
	"Land_i_House_Small_02_V2_F",
	"Land_i_House_Small_02_V3_F",
	"Land_GH_House_1_F",
	"Land_GH_House_2_F",
	"Land_i_House_Small_01_V1_F",
	"Land_i_House_Small_01_V2_F",
	"Land_i_Windmill01_F",
	//BIG VANILLA HOUSES
	"Land_i_House_Big_01_V1_F",
	"Land_i_House_Big_01_V2_F",
	"Land_i_House_Big_01_V3_F",
	"Land_i_House_Big_02_V1_F",
	"Land_i_House_Big_02_V2_F",
	"Land_i_House_Big_02_V3_F",
	"Land_i_Shop_01_V1_F",
	"Land_i_Shop_01_V2_F",
	"Land_i_Shop_02_V1_F",
	"Land_i_Shop_02_V2_F",
	"Land_i_Shop_02_V3_F",
	//KIT MOVEMENT
	"Land_PierLadder_F",
	//KIT LAMP
	"Land_LampStreet_02_triple_F",
	"Land_LampStreet_small_F",
	"Land_LampStreet_F",
	"Land_LampSolar_F",
	"Land_LampDecor_F",
	"Land_LampHalogen_F",
	"Land_LampHarbour_F",
	"Land_LampStadium_F",
	"Land_LampAirport_F",
	"Land_LampShabby_F",
	//RELIGIOUS KIT - ANTI ZOMBIE
	"Land_BellTower_01_V1_F",
	"Land_BellTower_02_V1_F",
	"Land_BellTower_02_V2_F",
	"Land_Calvary_01_V1_F",
	"Land_Calvary_02_V1_F",
	"Land_Calvary_02_V2_F",
	"Land_Grave_obelisk_F",
	"Land_Grave_memorial_F",
	"Land_Grave_monument_F",
	//AUTO DEFENCE TURRET
	//"I_HMG_01_high_F",
	//"I_HMG_01_F",
	//"I_GMG_01_high_F",
	//"I_GMG_01_F",
	//"I_static_AA_F",
	//"I_static_AT_F",
	//TARGET
	//"TargetP_Inf_F",
	//ADMIN
	"Land_JumpTarget_F",
	"Land_FloodLight_F",
	"Land_Atm_01_F",
	"Land_Atm_02_F",
	"Land_PortableLight_single_F",
	"Land_PortableLight_double_F",
	"Land_Stadium_p9_F",
	"Land_Kiosk_papers_F",
	"Land_FuelStation_01_shop_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Airport_02_controlTower",
	"Land_Airport_Tower_F",
	//FLAGS
	//"Flag_BI_F",
	//"Flag_Blue_F",
	//"Flag_Green_F",
	//"Flag_Red_F",
	//"Flag_RedCrystal_F",
	//"Flag_White_F",
	"HELPER"
];
//CONSTRUCTION BUILDINGS THAT CAN'T BE DISABLED (SUBLIST OF BRPVP_buildingHaveDoorList)
BRPVP_doNotDisableBuildingClass = [
	"Land_Billboard_F",
	"Land_Hospital_side2_F",
	"Land_LightHouse_F",
	//FLAGS
	"Flag_BI_F",
	"Flag_Blue_F",
	"Flag_Green_F",
	"Flag_Red_F",
	"Flag_RedCrystal_F",
	"Flag_White_F",
	//TARGET
	"TargetP_Inf_F",
	//KIT LAMP
	"Land_LampStreet_02_triple_F",
	"Land_LampStreet_small_F",
	"Land_LampStreet_F",
	"Land_LampSolar_F",
	"Land_LampDecor_F",
	"Land_LampHalogen_F",
	"Land_LampHarbour_F",
	"Land_LampStadium_F",
	"Land_LampAirport_F",
	"Land_LampShabby_F",
	//SMALL LIGHTS (AIRPORT)
	"Land_Flush_Light_green_F",
	"Land_Flush_Light_red_F",
	"Land_Flush_Light_yellow_F",
	"Land_runway_edgelight",
	"Land_runway_edgelight_blue_F",
	"Land_PortableHelipadLight_01_F",
	"PortableHelipadLight_01_blue_F",
	"PortableHelipadLight_01_red_F",
	"PortableHelipadLight_01_white_F",
	"PortableHelipadLight_01_green_F",
	"PortableHelipadLight_01_yellow_F",	
	"Land_Runway_PAPI",
	"HELPER"
];

BRPVP_tempBaseGround = [];
BRPVP_tempBaseGroundH = [];

//ELEVATORS
BRPVP_elevatorBuildingsClass = [
	"Land_MultistoryBuilding_01_F",
	"Land_MultistoryBuilding_03_F",
	"Land_MultistoryBuilding_04_F"
];
BRPVP_elevatorBuildingsFloor = [
	[
		[-17.3647,-17.9082,-21.0173],
		[-17.7739,-12.1587,-21.0165],
		[-18.2437,6.92236,-21.0165],
		[18.1953,4.4751,-21.0165],
		[10.1387,-11.748,-21.0165],
		[-12.5479,-17.6934,-14.6502]
	],
	[
		[-7.67725,-1.60107,-24.2182],
		[-8.32666,13.4375,-25.9038],
		[2.31885,17.7363,-25.906],
		[12.2695,12.4956,-25.9038],
		[12.1987,-0.518555,-25.9038],
		[-0.0625,-13.084,-25.9038],
		[-1.9165,5.0708,-25.9038]
		
	],
	[
		[-9.66895,-4.19971,-36.3137],
		[-9.54688,9.77246,-36.3137],
		[1.04443,14.2793,-36.4427],
		[4.32617,14.3979,-36.559],
		[13.7227,3.07422,-36.3137],
		[6.97803,-9.78027,-36.3137]		
	]
];
BRPVP_elevatorBuildingsTop = [
	[[2.93311,12.7397,19.2671]],
	[[-1.10156,11.2075,25.919]],
	[[5.67969,2.18164,22.3974]]
];

BRPVP_menuAutoSelectStringsToIgnore = ["(On)","(Off)","(   )","[   ]","(X)","[X]","(Adm)","(Адм)","[管理]"];