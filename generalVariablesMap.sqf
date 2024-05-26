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
//= GENERAL VARIABLES - MAP SPECIFIC
//============================================

BRPVP_skyDiveMaxFlyTimeLevels = [60,120]; //IN SECONDS

BRPVP_specificMapCustomPlaces = [
	[[8446.06,2657.45,0],500,localize "str_saint_conrad_airport",16,"map_specific\icons\saint_conrad.paa",localize "str_saint_conrad_welcome"]
];

BRPVP_atomicBombNoDestroyBuildings = [
	"Land_Stadium_",
	"Land_GH_MainBuilding_",
	"Land_Airport_",
	"Land_Hospital_",
	"Land_Carrier_01_",
	"Land_Destroyer_01_"
];

BRPVP_raidTrainingMapPosition = [12299.9,19200,0];

BRPVP_randomBoxCitiesQtt = 10;  //V139: 32
BRPVP_randomBoxMilitarAreasQtt = 20; //V139: 28
BRPVP_randomBoxCustomPlacesQtt = 10;  //V139: 20
BRPVP_randomBoxCustomPlaces = [
	[16025.9,16960.9,13.5991],
	[16090.8,16915.6,13.3301],
	[16151.7,16968,13.3582],
	[16149.8,17047,13.5789],
	[16080.2,17081.6,13.5891],
	[16020,17042.4,13.3182],
	[16086.8,16993,15.7031],
	[14608.3,16795.5,18.0114],
	[14576.4,16777.2,18.0364],
	[14627.1,16825.6,18.0364],
	[4915.67,21898.8,342.739],
	[4819.31,21955.8,337.9],
	[4880.34,21882,334],
	[10681.2,12271.1,16.7564],
	[10732.1,12231.5,17.8849],
	[10635.3,12305.2,15.6638],
	[10565.8,12335.3,15.4342],
	[10625.2,12255,15.8707],
	[10658.3,12225.8,16.6332],
	[10696.2,12357.7,15.0076],
	[10769.6,12249,19.3942],
	[10236.5,8644.88,65.7691],
	[10340.6,8746.13,66.7391],
	[10446.2,8754.46,64.4988],
	[10386.4,8760.81,66.0249],
	[10286.2,8683.57,68.6594],
	[11223.7,8613.14,178.633],
	[11266.4,8611.23,176.224],
	[11306.4,8580.12,167.777],
	[10491.9,7663.75,210.22],
	[10553.5,7649.95,221.568],
	[10686.9,7607.78,239.802],
	[10805.4,7602.21,235.259],
	[10973.2,7643,238.733],
	[11079.5,7668.72,213.077],
	[11579,11944.6,23.7004],
	[5531.93,14956.8,22.2285],
	[5549.88,15057.1,27.1097],
	[5423.05,14943,27.3088],
	[5415.37,15035.6,34.2177]
];

BRPVP_trenchDepth = 3;

BRPVP_specialForcesMissionsNumber = 1; //MAXIMUM NUMER OF SPECIAL FORCES MISSION (BY MASKE) ATT THE SAME TIME

BRPVP_insideStoneFixCases = [];
BRPVP_useJetsConvoys = true;

BRPVP_aiSimuOn = true;
BRPVP_aiSimuDist = 2000;
BRPVP_aiSimuDistOnFoot = 1750;
BRPVP_aiSimuDistAir = 2500;
BRPVP_aiSimuEqualDist = 100;

//SUPER RUN COLLISION
BRPVP_srunCollisionOk = [": wired_fence_",": bw_Set",": b_",": mound01_8m_f.p3d",": mound02_8m_f.p3d"];
BRPVP_srunCollisionOff = [": b_arundod"];
BRPVP_srunCollisionSound = [": wired_fence_"];

//TEMP WEAK AI
BRPVP_tAiMaxLocals = 30;
BRPVP_tAiGroupChance = [1,1,1,2,2];
BRPVP_tAiPlaces = [
	[16993.1,15272.3,0],
	[16836.8,15458.5,0],
	[19321.5,16532.4,0],
	[21754.3,18568.7,0],
	[21011.3,19436.8,0],
	[20594.8,20118.6,0],
	[22433.2,20174.9,0],
	[22348.7,20228.9,0],
	[24545.8,21185.9,0],
	[25306.1,21810.3,0],
	[25337.3,21991.5,0],
	[27057.0,22695.5,0],
	[28324.6,25776.6,0],
	[4413.01,20658.4,0],
	[4056.88,19336.1,0],
	[5780.36,13947.4,0],
	[05426.4,13465.0,0],
	[5096.36,10836.7,0],
	[07262.3,11050.2,0],
	[7802.96,11011.6,0],
	[11200.6,8718.45,0],
	[11836.6,14152.4,0],
	[14687.2,18081.8,0],
	[14885.9,18680.2,0],
	[11017.0,19049.0,0],
	[10245.2,19319.9,0],
	[9929.19,19388.1,0],
	[9749.58,19422.5,0],
	[9213.75,19269.1,0],
	[06618.4,20072.7,0],
	[5233.48,13536.5,0],
	[19951.0,11444.7,0],
	[18704.5,10221.2,0],
	[19793.3,6110.91,0],
	[21214.7,8816.67,0],
	[21600.1,8604.46,0],
	[22662.5,7800.24,0],
	[23006.7,7260.77,0],
	[22711.1,6917.27,0],
	[21752.7,6275.24,0],
	[19370.4,14311.9,0],
	[11687.2,15932.1,0],
	[12683.5,16340.8,0],
	[12558.6,16398.6,0],
	[14228.2,17123.4,0],
	[6024.32,19129.9,0],
	[08459.8,14382.9,0],
	[7049.29,18031.6,0],
	[08976.3,17045.4,0],
	[10770.9,07607.4,0],
	[9228.51,8058.24,0],
	[12688.4,6953.75,0],
	[13794.6,6387.33,0],
	[11872.9,9462.91,0],
	[13888.7,21124.8,0],
	[11845.7,21781.0,0],
	[11411.0,20617.5,0],
	[10063.5,20978.0,0],
	[9960.87,21191.4,0],
	[6885.29,22165.6,0],
	[6145.12,19812.1,0],
	[8441.29,12749.7,0],
	[10120.2,11649.6,0],
	[9993.02,13642.8,0],
	[10232.1,14856.7,0],
	[6996.42,11634.1,0],
	[6680.33,13205.8,0],
	[5344.44,17405.8,0],
	[5410.93,17912.2,0],
	[22508.3,16052.0,0],
	[22491.6,16051.6,0],
	[22224.5,15351.4,0],
	[17382.3,12050.7,0],
	[19059.6,18468.3,0]
];

//HOLE MISSION
BRPVP_holeMissionNumber = 1;
BRPVP_holeMissionMoney = 4000000;
BRPVP_holeMissionSpecialLootQtt = 20;

BRPVP_loadedMap = "altis";
BRPVP_ubberSafeH = 15;
BRPVP_mapAISM = 1;

BRPVP_pmiss2Active = (([0,1,2,3,4] call BIS_fnc_arrayShuffle) select [0,3])+[5];
BRPVP_pmiss2MaxPerRestart = count BRPVP_pmiss2Active;
BRPVP_pmiss2Order = true;
BRPVP_pmiss2Data = [
	[
		"map_specific\player_missions_2\charlie_outpost_1.sqf",
		"map_specific\player_missions_2\charlie_outpost_x.paa",
		100,
		[[8910.19,7483.68,0]],
		[[8910.19,7483.68,0]],
		"scheduled",
		"str_pmiss2_charlie_outpost",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions_2\charlie_outpost_2.sqf",
		"map_specific\player_missions_2\charlie_outpost_x.paa",
		100,
		[[5401.83,17905.3,0]],
		[[5401.83,17905.3,0]],
		"scheduled",
		"str_pmiss2_charlie_outpost",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions_2\charlie_outpost_3.sqf",
		"map_specific\player_missions_2\charlie_outpost_x.paa",
		125,
		[[27602.2,24592.8,0]],
		[[27602.2,24592.8,0]],
		"scheduled",
		"str_pmiss2_charlie_outpost",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions_2\charlie_outpost_4.sqf",
		"map_specific\player_missions_2\charlie_outpost_x.paa",
		100,
		[[13889.617,21639.652,0]],
		[[13889.617,21639.652,0]],
		"scheduled",
		"str_pmiss2_charlie_outpost",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions_2\charlie_outpost_5.sqf",
		"map_specific\player_missions_2\charlie_outpost_x.paa",
		100,
		[[19352.3,9682.71,0]],
		[[19352.3,9682.71,0]],
		"scheduled",
		"str_pmiss2_charlie_outpost",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions_2\charlie_outpost_final.sqf",
		"map_specific\player_missions_2\charlie_outpost_final.paa",
		125,
		[[15372.2,16078,0]],
		[[15372.2,16078,0]],
		"scheduled",
		"str_pmiss2_charlie_outpost_final",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	]
];

BRPVP_carGraveyardPlaces = [
	[4242.61,13948.9,0],
	[5021.08,14372.6,0],
	[6760.95,15828.2,0],
	[16995.6,15275.1,0],
	[12375.6,14802.5,0]
];

BRPVP_maxAiOnSmallMissions = 100;

BRPVP_classAdTraders = [
	[[10310.2,17965.2,0],157]
];

BRPVP_pmissActive = [0,1,2,3,4,5,6,7,8,9,10];
BRPVP_pmissMaxPerRestart = 11;
BRPVP_pmissOrder = false;
BRPVP_pmissData = [
	[
		"map_specific\player_missions\militar_base.sqf",
		"map_specific\player_missions\militar_base.paa",
		200,
		[[13835,17776,0]],
		[[13835,17776,0]],
		"scheduled",
		"str_pmiss_militar_base",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Novalkoski", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\super_road_block.sqf",
		"map_specific\player_missions\super_road_block.paa",
		120,
		[[23804,20091,0],[16737.3,17691.4,0],[4753.75,14260.8,0]],
		[[23804,20091,0],[16737.3,17691.4,0],[4753.75,14260.8,0]],
		"unscheduled",
		"str_pmiss_sroad_block",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Ucrinha", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\crime_hotel.sqf",
		"map_specific\player_missions\crime_hotel.paa",
		150,
		[[21970,21024,0]],
		[[21970,21024,0]],
		"scheduled",
		"str_pmiss_crime_hotel",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Ucrinha", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\aegis.sqf",
		"map_specific\player_missions\aegis.paa",
		200,
		[[7006,8994,0],[18492,19995,0]],
		[[7006,8994,0],[18492,19995,0]],
		"scheduled",
		"str_pmiss_aegis",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Ucrinha", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\bravo_fleet.sqf",
		"map_specific\player_missions\bravo_fleet.paa",
		400,
		[[22525,9998,0],[3204,16509,0]],
		[[22525,9998,0],[3204,16509,0]],
		"scheduled",
		"str_pmiss_bravo_fleet",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Ucrinha", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\training_center.sqf",
		"map_specific\player_missions\training_center.paa",
		200,
		[[11781,8822,0]],
		[[11781,8822,0]],
		"scheduled",
		"str_pmiss_training_center",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Maske", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\nuclear_island.sqf",
		"map_specific\player_missions\nuclear_island.paa",
		450,
		[[13474,12006,0]],
		[[13474,12006,0]],
		"scheduled",
		"str_pmiss_nuclear_island",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\cartel.sqf",
		"map_specific\player_missions\cartel.paa",
		200,
		[[23396.3,24288,0]],
		[[23396.3,24288,0]],
		"scheduled",
		"str_pmiss_cartel",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\olympic_base.sqf",
		"map_specific\player_missions\olympic_base.paa",
		150,
		[[5478.75,14996.5,0]],
		[[5478.75,14996.5,0]],
		"scheduled",
		"str_pmiss_olympic_base",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Price", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\boss_castle.sqf",
		"map_specific\player_missions\boss_castle.paa",
		150,
		[[3087.81,13175.8,0]],
		[[3087.81,13175.8,0]],
		"scheduled",
		"str_pmiss_boss_castle",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Maske", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	],
	[
		"map_specific\player_missions\war_ruins.sqf",
		"map_specific\player_missions\war_ruins.paa",
		150,
		[[4854,21939,0]],
		[[4854,21939,0]],
		"scheduled",
		"str_pmiss_war_ruins",
		[1,0.25], //[AI GENERAL SKILL (0-1),AI AIMING SKILL (0-1)]
		"Conrado", //AUTHOR
		true //IGNORE MISSION IF BASE EXISTS
	]
];

BRPVP_xpSanctuaryClass = "Land_Church_01_V1_F";

//TRAVELING AID PLACES
BRPVP_travelingAidPlaces = [
	[[13623,20571,0],100,"A",/*MUST BE 4*/4],
	[[27243,22063,0],100,"B",/*MUST BE 4*/4],
	[[10845,09267,0],100,"C",/*MUST BE 4*/4],
	[[07456,11298,0],100,"D",/*MUST BE 4*/4],
	[[02711,10042,0],100,"E",/*MUST BE 4*/4],
	[[19623,14918,0],100,"F",/*MUST BE 4*/4],
	[[21549,19132,0],100,"G",/*MUST BE 4*/4],
	[[20144,08200,0],100,"H",/*MUST BE 4*/4],
	[[10021,17154,0],100,"I",/*MUST BE 4*/4],
	[[05201,20190,0],100,"J",/*MUST BE 4*/4]
];

BRPVP_carrierMissPosLim = [750,1250];
BRPVP_carrierMissPosBorder = 1000;

//RANDOM RESPAWN spawn
BRPVP_useRandomRespawnAllways = false;
BRPVP_useRandomRespawnWhenSuicide = false;
BRPVP_useRandomRespawnPlacesToChoose = 10;
BRPVP_useRandomRespawnPlacesToChooseBotKill = 15;
BRPVP_useRandomRespawnCanInBase = true;
BRPVP_useRandomRespawnPlacesDistance = 4500;
BRPVP_useRandomRespawnPlacesDistanceBotKill = 3000;

//AI SKILL IS [ALL OTHER SKILLS,AIMING ACURRACY]
BRPVP_AISkill = [
	[1.0,0.30], //BRAVO MISSIONS
	[1.0,0.30], //SIEGE MISSIONS
	[1.0,0.30], //CONVOYS
	[1.0,0.25], //WALKING GROUPS
	[1.0,0.25], //CIVIL AI INSIDE CITY HOUSES
	[1.0,0.25], //CIVIL AI IN MILITAR AREAS
	[1.0,0.25], //BOMB MISSION
	[1.0,0.30], //TRANSPORT MISSION
	[1.0,0.30], //WALL GUARDS
	[1.0,0.30], //EV MISSIONS
	[1.0,0.30]  //HOLE MISSIONS
];

//TERRAIN GRID QUALITY
BRPVP_terrainGridConfig = [["Low",[30,30,15]],["Normal",[25,25,12.5]],["High",[12.5,12.5,6.25]],["Super",[6.25,6.25,6.25]],["Are you Crazy?",[3.125,3.125,3.125]]];

//DISTÂNCIAS A PÉ (visão)
BRPVP_viewDist = 1500;
BRPVP_viewObjsDist = 1500;
BRPVP_viewDistList =     [500,750,1000,1250,1500,2000,2500,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000];
BRPVP_viewObjsDistList = [500,750,1000,1250,1500,2000,2500,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000];

//DISTÂNCIAS DE VÔO (visão)
BRPVP_viewDistFly = 3000;
BRPVP_viewObjsDistFly = 3000;
BRPVP_viewDistListFly =     [1000,1500,2000,2500,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000];
BRPVP_viewObjsDistListFly = [1000,1500,2000,2500,3000,4000,5000,6000,7000,8000,9000,10000,11000,12000,13000,14000,15000];

//Dinheiro Spot
BRPVP_moneyOnHandToSpot = 50000;
BRPVP_spotPositionError = 500; //Em metros
BRPVP_spotPositionErrorService = 750; //Em metros

//BOMB MISSION
BRPVP_bombMissionAmount = 1; // bomba Missão Valor (Eu acho)
BRPVP_bombMissionMoneyForLoot = 100000;
BRPVP_bombMissionMoneyForLootTry = [3,4,5];
BRPVP_bombMissionSpecialLootQtt = 15;
BRPVP_bombMissionSuitCases = [100000,100000];
BRPVP_bombMissionClasses = ["Land_i_Barracks_V2_F","Land_u_Barracks_V2_F","Land_dp_bigTank_F","Land_i_House_Small_03_V1_F","Land_FuelStation_01_shop_F"];
BRPVP_bombMissionClassesTurrets = [
	[
		[[0.0507813,-4.96973,7.51883],134.203],
		[[-5.11719,-5.0166,7.51883],220.254],
		[[-11.4043,2.7998,7.73769],-54.7073],
		[[12.707,2.98926,7.71544],43.8523]
	],
	[
		[[-8.21875,-3.56445,5.10203],-139.287],
		[[-3.62305,-3.57422,5.10104],-220.815],
		[[8.93945,3.80078,5.32301],49.9657],
		[[-15.0771,3.84766,5.31806],-44.7129]	
	],
	[
		[[2.36035,-5.13,3.59794],332.598-167.438],
		[[2.99121,3.15637,3.59794],210.652-167.438],
		[[-4.72314,-0.785156,3.59794],77.5308-167.438],
		[[0.485352,-0.22876,3.59794],251.665-167.438]
	],
	[
		[[3.40149,-4.35938,3.30574],35.0523-262.49],
		[[-3.73596,2.44287,3.30574],223.771-262.49],
		[[3.28418,3.25586,3.30574],307.942-262.49],
		[[-3.75806,-0.456543,3.30574],87.2484-262.49]
	],
	[
		[[-0.154297,-2.52441,-2.01157],179.793-0],
		[[-0.435059,-3.9126,3.72464],181.839-0],
		[[4.44678,-0.553223,3.63138],90.9579-0],
		[[-4.46338,-0.303711,3.62459],273.142-0]		
	]
];

//REVOLTERS BUILDINGS
BRPVP_revoltersBuildings = ["Land_i_House_Big_01_V2_F","Land_i_House_Big_02_V1_F"];

//BLACK TRADERS
BRPVP_blackTradersPlaces = [
	[[11858,10480,0],141,"Mafum",["ADMIN"]],
	[[16938,21879,0],120,"Beretus",["ADMIN"]]
];

//PVE
BRPVP_pveNoPveInRaidDaysFull = false;
BRPVP_pveDaysWithNoSuperJumpWhenHack = 1;
BRPVP_pveAllowSuperJump = false; // Pulo da área PVE
BRPVP_pveMakeAllMapPve = false; // Tornar o mapa PVE por completo
BRPVP_pveMainAreasAll = [
	[[[08529,12963,0],5000,"PVE1",10/*MUST BE 10*/]],
	[[[12198,19523,0],5000,"PVE2",10/*MUST BE 10*/]],
	[[[22883,19222,0],5000,"PVE3",10/*MUST BE 10*/]],
	[[[19169,10710,0],5000,"PVE4",10/*MUST BE 10*/]]
];

//FARM
BRPVP_farmSpecialAreasOre = [];
BRPVP_farmPrivateMines = [
	[[17148,11329,0],300,193],
	[[08086,14596,0],300,077],
	[[11547,20399,0],300,167],
	[[18603,12052,0],300,250],
	[[17678,15265,0],300,130],
	[[06414,12320,0],300,130]
];

//VEHICLE MISSION PLACES
BRPVP_airportRoadPlaces = [
	[14714,16345,0],
	[09139,21481,0],
	[11528,11696,0],
	[21129,07361,0],
	[26987,24713,0],
	[23146,18684,0]
];

//BUS SERVICE
BRPVP_busServiceStopPoints = [
	[[3616.32,12935.0,0],302.37],
	[[7160.57,16047.6,0],335.62],
	[[9227.28,15825.0,0],339.74],
	[[12294.5,15851.8,0],353.71],
	[[16196.2,17374.9,0],303.71],
	[[18863.4,16629.0,0],007.38],
	[[20940.3,16931.8,0],315.67],
	[[23883.6,20143.0,0],317.99],
	[[25817.3,21454.6,0],318.10],
	[[26806.2,23072.6,0],297.89],
	[[16444.5,15865.4,0],041.28],
	[[17044.3,12901.7,0],135.61],
	[[20002.8,11407.2,0],059.10],
	[[21600.5,7739.02,0],069.47],
	[[8579.41,18100.9,0],089.07],
	[[4619.95,21317.7,0],148.61],
	[[14065.8,18551.1,0],210.76],
	[[14548.3,20742.7,0],127.61],
	[[5064.83,11303.8,0],247.35],
	[[8975.90,12104.1,0],016.46],
	[[11131.9,12168.6,0],178.84],
	[[4192.98,11799.0,0],187.86],
	[[11087.9,14568.2,0],163.83],
	[[9522.45,20322.4,0],254.07],
	[[11800.0,18379.0,0],149.13],
	[[10415.1,17190.6,0],307.54],
	[[19365.2,13311.4,0],059.21],
	[[20510.5,8931.57,0],066.74],
	[[17006.0,10053.3,0],135.99],
	[[17867.8,18045.2,0],085.69],
	[[3928.06,17306.0,0],255.18],
	[[4906.56,16150.1,0],183.62],
	[[12745.4,19674.3,0],046.64],
	[[19538.5,15446.7,0],147.08],
	[[12539.1,14347.3,0],159.53]
];
BRPVP_busServiceMaximumDistPrice = 50000; //Ônibus, Distância máxima Preço

//LEST WEST WALL SEGMENTS
BRPVP_lestWestWallSegments = [
	[[17482.9,18277.6,0],[17283.4,17919.8,0]],
	[[17270.6,17896.8,0],[17036.2,17476.3,0]],
	[[17027.8,17460.9,0],[16631.6,16750.5,0]],
	[[16624.5,16738.3,0],[16378.3,16296.7,0]],
	[[16372.0,16285.5,0],[16237.4,16043.8,0]],
	[[16230.7,16031.9,0],[16086.3,15768.3,0]]
];

//INSURANCE TRADERS
BRPVP_insurancePerc = 0.5; //PRICE OF INSURANCE IN PERCENTAGE OF VEHICLE PRICE
BRPVP_insurancePlaces = [
	[[10567.1,10013.6,0],100,"Insurance 1",9],
	[[16205.7,20740.3,0],100,"Insurance 2",9],
	[[21426.7,15102.3,0],100,"Insurance 3",9],
	[[15090.1,16734.2,0],100,"Insurance 4",9]	 
];

BRPVP_removeFromTrader = [];
//BRPVP_removeFromTrader = ["BRP_kitFlags200"];

//WATER MISSION PLACES
BRPVP_waterMissionAmount = 1;
BRPVP_waterMissionSuitCaseMoney = 2500000;
BRPVP_waterMissionMoneyforLoot = 2000000;
BRPVP_waterMissionMoneyforLootTry = [3,4,5];
BRPVP_waterMissionSpecialLoot = 15;
BRPVP_waterMissionPlaces = [
	[10070.1,10813.2,0], //20-30m
	[18702.8,19055.7,0], //40-50m
	[12701.3,12005.5,0], //40-50m
	[03079.8,11086.1,0], //40-50m
	[09850.4,22840.1,0], //40-50m
	[17527.0,08142.4,0], //40-50m
	[05652.8,23038.9,0], //40-50m
	[21843.9,10354.5,0], //40-50m
	[15811.6,22718.3,0], //40-50m
	[06985.0,10318.9,0], //60-80m
	[25016.9,24884.9,0], //60-80m
	[15899.2,14005.3,0], //60-80m
	[22932.9,14872.4,0], //60-80m
	[22212.9,12494.7,0], //60-80m
	[03481.0,16509.3,0]  //60-80m
];

//TRANSPORT MISSION
BRPVP_transMoneyFixed = 1000000;
BRPVP_transMoneyBase = 5000000;
BRPVP_transNormalLootMoney = 1250000;
BRPVP_transSpecialLootQtt = 15;
BRPVP_transAmount = 1;
BRPVP_transDistanceMaxPrize = 15000;
BRPVP_transPlaces = [
	[08850,22615,0],
	[09967,09128,0],
	[04669,16576,0],
	[15441,17014,0],
	[12475,18490,0],
	[08470,15909,0],
	[09403,13079,0],
	[07651,19185,0],
	[12130,16171,0],
	[18089,16613,0],
	[16678,15016,0],
	[19279,19303,0],
	[15311,21927,0],
	[18415,14500,0],
	[10336,18133,0],
	[04509,20657,0],
	[17145,12129,0],
	[12124,13828,0],
	[05894,13347,0]
];

//FORT DEFEND MISSION
BRPVP_defendFortRun = true; //RUN OR NOT RUN THE FORT DEFEND MISSION?
BRPVP_defendFortCenter = [13319.7,17375.9,0];
BRPVP_defendFortSpawns = [[13428.7,17424.2,0],[13165,17382,0],[13334.4,17220.6,0],[13446.2,17278.2,0]];
BRPVP_defendFortZombieReward = 2500;
BRPVP_defendFortAIReward = 5000;

//REMOVE FROM MAP ITEM
BRPVP_removeFromMap = [": t_",": bw_Set",": b_",": bluntstone_",": sharpstones_",": sharpstone_",": stone_small_f",": stone_medium_f",": w_sharpstone_",": mound01_8m_f.p3d",": mound02_8m_f.p3d"];
BRPVP_treesAndBushs = [": t_",": bw_Set",": b_"];
BRPVP_removeFromBigWall = [": t_",": bw_Set",": b_",": bluntstone_",": sharpstones_",": sharpstone_",": stone_small_f",": stone_medium_f",": w_sharpstone_",": mound01_8m_f.p3d",": mound02_8m_f.p3d"];

//ROAD BLOCKS
BRPVP_numberOfRoadBlocks = 2; //V139: 3
BRPVP_blockMoneyForLoot = 2000000;
BRPVP_blockMoneyForLootTry = [4,5];
BRPVP_blockSpecialLootQtt = 10;
BRPVP_blockFlareMoney = 3000000;
BRPVP_blockPlaces = [
	[[4068.82,12201,0],93.22],
	[[4685.82,13340.3,0],31.11],
	[[6434.24,15224.6,0],58.34],
	[[7172.91,16061.5,0],66.63],
	[[9891.02,15980,0],106.1],
	[[11253.5,15713.1,0],70.28],
	[[12704.8,15913,0],85.05],
	[[14330.9,16721.9,0],44.2],
	[[15705.7,17463.8,0],105.56],
	[[16703.2,17669.2,0],57.43],
	[[17641,17857.2,0],99.73],
	[[19148.7,16580.3,0],102.47],
	[[20469.5,16761.8,0],96.62],
	[[21273.6,17181.7,0],55.92],
	[[21753.9,17889.8,0],13.38],
	[[23637.5,19965.6,0],53.35],
	[[18952.3,15050,0],240.25],
	[[20344.2,16227.5,0],230.29],
	[[16468.8,16020.6,0],82.96],
	[[8417.7,11141.8,0],237.82],
	[[6623.51,11027.8,0],247.86],
	[[3041.61,21623.6,0],116.9],
	[[8071.41,21070.2,0],315.3],
	[[14447.1,20394,0],203.81],
	[[10095.5,15224.7,0],131.72],
	[[19381.1,8071.58,0],316.36],
	[[19647.6,12577.4,0],313.07],
	[[21097.4,8444.5,0],327.28]
];

//AIRPORTS
BRPVP_airportAreas = [
	[[14714,16345,0],700],
	[[09139,21481,0],200],
	[[11528,11696,0],325],
	[[21129,07361,0],400],
	[[26987,24713,0],300],
	[[23146,18684,0],400]
];

//EVENT MISSIONS
BRPVP_eventDataSpawnWait = 0.05;
BRPVP_eventsData = [
	[[06053,12610,0],200,localize "str_junky_incident","map_specific\events\i_junkyard.paa"],
	[[16707,13580,0],200,localize "str_chelonisi_alert","map_specific\events\i_chelonisi.paa"],
	[[23357,18630,0],300,localize "str_fort_of_light","map_specific\events\i_fort_of_light.paa"],
	[[24101,18683,0],175,localize "str_fear_refinery","map_specific\events\i_refinery.paa"]
];
BRPVP_eventsDataCodeOn = [
	"BRPVP_eventJunkyIncidentOn",
	"BRPVP_eventChelonisiAlertOn",
	"BRPVP_eventFortOfLightOn",
	"BRPVP_eventFearRefineryOn"
];
BRPVP_eventsDataCodeOff = [
	"BRPVP_eventJunkyIncidentOff",
	"BRPVP_eventChelonisiAlertOff",
	"BRPVP_eventFortOfLightOff",
	"BRPVP_eventFearRefineryOff"
];
BRPVP_eventsDataSQF = [
	"map_specific\events\ev_mission_1.sqf",
	"map_specific\events\ev_mission_2.sqf",
	"map_specific\events\ev_mission_3.sqf",
	"map_specific\events\ev_mission_4.sqf"
];
BRPVP_eventsObjsSQF = [
	"map_specific\events\ev_objs_mission_1.sqf",
	"map_specific\events\ev_objs_mission_2.sqf",
	"map_specific\events\ev_objs_mission_3.sqf",
	"map_specific\events\ev_objs_mission_4.sqf"
];
BRPVP_eventsDataStartRandomAtBegin = true;

BRPVP_radioAreasRemoveDeniedItems = false;
BRPVP_radioAreasNormalXpRadio = 0.25;
BRPVP_radioAreas = [
	[[10673,12264,0],280,"Radio1",8,0.25,["Box_NATO_Wps_F","Box_IND_Wps_F","Box_East_Wps_F"],6],
	[[10676,12243,0],140,"Radio1_1",8,0.25,["Box_NATO_Wps_F","Box_IND_Wps_F","Box_East_Wps_F"],5],
	[[10679,12218,0],70,"Radio1_2",8,0.25,["Box_East_WpsSpecial_F","Box_IND_WpsSpecial_F","Box_NATO_WpsSpecial_F"],4]
];
BRPVP_radioAreasMapIcons = [
	[[10679,12218,0],300,"Radio1_2",8]
];
BRPVP_noBuildDistInOtherAreas = [
	/*CITIES*/-1000,
	/*ITEM TRADERS*/400,
	/*COLLECTORS*/400,
	/*VEHICLE TRADERS*/400,
	/*TRAVEL AID AREAS*/400,
	/*DISMANTLE AREAS*/400,
	/*OBSCURE TRADER*/400,
	/*EV EVENTS*/750,
	/*PVP AREAS*/100,
	/*INSURANCE AREAS*/400,
	/*BLACK TRADERS*/400,
	/*PRIVATE MINES*/0,
	/*PLAYER MISSIONS*/0,
	/*CLASS AD TRADERS*/100
];
BRPVP_PVPAreas = [
	[[3458.95,12966.4,0],650,{"ARENA X"+str ({_x distance2D [3458.95,12966.4,0] < 650} count call BRPVP_playersList)}]
];
BRPVP_thiefAreas = [
	[[02311.14,22391.80,00.38],50,"Thief_Trader_1",6]
];
BRPVP_thiefAreasTrader = [
	[[02311.14,22391.80,00.38],274]
];
BRPVP_dismantleAreas = [
	[[10153.9,15044.7,0.00],80,"Dismantle_01",5],
	[[24662.3,23171.0,0.00],80,"Dismantle_02",5],
	[[10049.3,10195.0,0.00],80,"Dismantle_03",5],
	[[06512.8,20011.2,0.00],80,"Dismantle_04",5],
	[[20262.5,12982.6,0.00],80,"Dismantle_05",5],
	[[15297.1,20622.2,0.00],80,"Dismantle_06",5], //NEW V140
	[[05172.6,13561.9,0.63],80,"Dismantle_07",5], //NEW V140
	[[18611.6,06756.9,0.00],80,"Dismantle_08",5], //NEW V140
	[[22581.8,18069.3,0.00],80,"Dismantle_09",5], //NEW V140
	[[16659.6,17270.5,0.00],80,"Dismantle_10",5], //NEW V140
	[[10940.7,18947.7,0.25],80,"Dismantle_11",5]  //NEW V140
];
BRPVP_dismantleAreasTrader = [
	[[10153.9,15044.7,0.00],188],
	[[24662.3,23171.0,0.00],142],
	[[10049.3,10195.0,0.00],220],
	[[06512.8,20011.2,0.00],136],
	[[20262.5,12982.6,0.00],228],
	[[15297.1,20622.2,0.00],185], //NEW V140
	[[05172.6,13561.9,0.63],000], //NEW V140
	[[18611.6,06756.9,0.00],000], //NEW V140
	[[22581.8,18069.3,0.00],000], //NEW V140
	[[16659.6,17270.5,0.00],000], //NEW V140
	[[10940.7,18947.7,0.25],305]  //NEW V140
];
BRPVP_distanceToRespawnWaitZero = 3000; //Em metros RESPAWN
BRPVP_distanceToRespawnWaitZeroIfPlayerKill = 6000; //Em metros
BRPVP_personalSpawnCountLimit = 5; // limite De Contagem De Reaparecimento Pessoal de corpos (eu acho)
BRPVP_autoTurretFireRange = [200,400,800,1500]; //MAXIMUM FIRE DISTANCES ON FOOT, ON LAND VEHICLE, ON HELIS OR SHIPS AND ON JETS/PLANES
BRPVP_autoTurretFireRangeForgive = [600,1000,2000,2500]; //FORGIVE DISTANCE
BRPVP_sellTerrainPlaces = [
	[
		[[11573.2,07043.6,2.63],292.62],
		[[04586.0,10291.4,2.31],034.74],
		[[07272.2,13948.9,2.35],087.34],
		[[05171.4,21052.5,2.19],254.17],
		[[13545.5,20053.5,2.57],178.27],
		[[25371.6,19305.6,2.20],044.07],
		[[18439.7,16854.6,2.17],087.84],
		[[21285.1,10447.6,1.13],018.80]
	],
	[1,2,3,4,5,6,7,8]
];
BRPVP_mapaDimensoes = [30720,30720];
BRPVP_randomRespawnSquare = [[3007,27115],[5280,24025]];
BRPVP_centroMapa = [15360,15360,0];
BRPVP_centroMapaRadius = 20000;
BRPVP_mapGoodSize = 3000;
BRPVP_spawnAIFirstPos = [28338,23909,0];
BRPVP_spawnVehicleFirstPos = [-25000,40000,1000];
BRPVP_posicaoFora = [-25000,40000,0];
BRPVP_gridPosDiff = [0,0,0];

//MORE CONFIGURATION
_amountPublicVehicles = 45;
_amountHelis = 15;
_amountHelisAirport = 10;
_amountOnFootAI = 10; //GROUPS
_onFootAIGroupSize = [2,3,4];
_amountRevolters = 30; //UNITS
_amountRevoltersMilitarArea = 25; //UNITS
_amountBravoPoint = 1;
_amountSiege = 1;
_amountConvoy = 4; //V139: 5
_planeCrashCycle = 60; //MINUTES

//BIG VAR CONFIG
BRPVP_mapaRodando = [
	//MAP
	"altis",
	//HEAL PLACES
	["Land_Chapel_V2_F"],
	//ITEM TRADERS AMOUNT
	22,
	//PERCENTAGE OF THE CITIES WHERE THE PLAYER CAN SPAWN
	1,
	//LAND VEHICLES
	_amountPublicVehicles,
	//HELIS
	[_amountHelis,["Land_Hangar_F","Land_TentHangar_V1_F"],_amountHelisAirport],
	//ON FOOT AI
	[true,_amountOnFootAI,_onFootAIGroupSize],
	//REVOLTERS AI
	[true,_amountRevolters],
	//REVOLTERS AI IN MILITAR AREA
	[true,_amountRevoltersMilitarArea],
	//FREE INDEX POSITION
	"free to use",
	//MIN WAYPOINT DISTANCE
	650,
	//BRAVO POINT MISSIONS
	[true,["Land_MilOffices_V1_F","Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Dome_Big_F","Land_Airport_left_F","Land_Airport_right_F","Land_dp_bigTank_F","Land_i_Shed_Ind_F","Land_Factory_Main_F","Land_i_Barracks_V2_F","Land_Chapel_V1_F","Land_Cargo_HQ_V3_F"],[false,false,false,false,false,false,false,false,false,false,false,false],_amountBravoPoint,1250000,2,1250000,2],
	//EXTDB3 DATABASE ENTRY (NOT THE SCHEMA NAME IN MYSQL)
	"brpvp_altis",
	//FREE INDEX POSITION
	"free to use",
	//FREE INDEX POSITION
	"free to use",
	//FREE INDEX POSITION
	"free to use",
	//LAND AND AIR VEHICLES TRADERS
	[
		[[11886.30,09464.60,0.00],["MILITAR","CIV-MIL","CIVIL"],[],"shop_car.paa"],
		[[04326.63,14528.70,0.00],["MILITAR","CIV-MIL","CIVIL"],[],"shop_car.paa"],
		[[11376.00,14232.00,0.00],["MILITAR","CIV-MIL","CIVIL"],[],"shop_car.paa"],
		[[11631.00,19510.10,0.00],["MILITAR","CIV-MIL","CIVIL"],[],"shop_car.paa"],
		[[25438.60,20346.40,0.00],["MILITAR","CIV-MIL","CIVIL"],[],"shop_car.paa"],
		[[20121.60,20013.40,0.00],["MILITAR","CIV-MIL","CIVIL"],[],"shop_car.paa"],
		[[17657.30,10580.70,0.00],["MILITAR","CIV-MIL","CIVIL"],[],"shop_car.paa"],
		[[26780.50,24646.10,0.00],["AIRPORT"],[],"shop_air.paa"],
		[[11732.30,11847.30,0.00],["AIRPORT"],[],"shop_air.paa"],
		[[09158.78,21637.60,0.00],["AIRPORT"],[],"shop_air.paa"],
		[[20797.50,07191.50,0.00],["AIRPORT"],[],"shop_air.paa"],
		[[12529.30,12749.60,4.30],["BOATS"],[["big",[12537.0,12854.2,0],118],["sbig",[12824.0,12744.2,0],191]],"shop_ship.paa"],
		[[12199.30,22977.80,0.00],["BOATS"],[["big",[12105.4,23015.4,0],287],["sbig",[11994.3,23186.8,0],027]],"shop_ship.paa"]
	],
	//FREE INDEX POSITION
	"free to use",
	//FREE INDEX POSITION
	"free to use",
	//SIEGE MISSIONS
	[true,_amountSiege,4500000,1500000],
	//CONVOY MISSIONS
	[
		true,
		_amountConvoy,
		[
			[
				1,
				[
					[[02858,21938,0],25],
					[[03443,10193,0],25],
					[[10125,12015,0],25],
					[[08415,22410,0],25],
					[[16088,21893,0],25],
					[[08978,16313,0],25],
					[[15795,17910,0],25],
					[[13590,13185,0],25],
					[[03443,18113,0],25],
					[[12578,19913,0],25],
					[[04613,14783,0],25],
					[[23535,18360,0],25],
					[[23828,23693,0],25],
					[[27450,25065,0],25],
					[[26933,20903,0],25],
					[[20093,19823,0],25],
					[[17010,13185,0],25],
					[[14918,11138,0],25],
					[[18833,06728,0],25],
					[[22433,07088,0],25],
					[[21668,05288,0],25],
					[[20273,15683,0],25],
					[[24300,18585,0],25],
					[[10350,10170,0],25],
					[[11858,10328,0],25],
					[[12443,09608,0],25],
					[[08708,07403,0],25],
					[[13410,06570,0],25],
					[[11228,07088,0],25],
					[[10508,08123,0],25]
				]
			]
		]
	],
	//CIVIL PLANE CRASH MISSION - FIND THE CORRUPT POLITICIAN
	[true,[[[9315,17280,0],4500],[[19850,16000,0],1500],[[18876,11163,0],1500],[[11012,8152,0],1500]],3,_planeCrashCycle,1500000]
];

//CANT BUILD NEAR THOSE BUILDINGS
BRPVP_cantBuildNearDistance = 125;
BRPVP_cantBuildNearLimit = 5;
BRPVP_cantBuildNearBuildings = [
	"Land_Medevac_house_V1_F",
	"Land_Medevac_HQ_V1_F",
	"Land_Radar_F",
	"Land_i_Barracks_V1_F",
	"Land_i_Barracks_V2_F",
	"Land_u_Barracks_V2_F",
	"Land_MilOffices_V1_F",
	"Land_Research_HQ_F",
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_HQ_V2_F",
	"Land_Cargo_HQ_V3_F",
	"Land_Cargo_Tower_V1_F",
	"Land_Cargo_Tower_V2_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_House_V2_F",
	"Land_Cargo_House_V3_F",
	"Land_Dome_Big_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_Patrol_V2_F",
	"Land_Cargo_Patrol_V3_F"
];

//MAP EXTRA BUILDINGS
BRP_kitExtraBuildingsI = [];
BRPVP_specialItemsExtra = [];
BRPVP_specialItemsGroupExtra = [];
BRPVP_specialItemsFreeOfFlagExtra = [];
BRPVP_specialItemsExtraRemoveTime = [];
BRPVP_specialItemsNamesExtra = [];
BRPVP_specialItemsImagesExtra = [];
BRPVP_mercadoItensExtra = [];
BRPVP_mercadoNomesNomesConstructionExtra = [];
BRPVP_buildingHaveDoorListExtra = [];
BRPVP_doNotDisableBuildingClassExtra = [];

BRPVP_farmCustomCfg = [
	//BLUNTSTONE
	[": bluntstone_01.p3d",[2,3]],
	[": bluntstone_02.p3d",[2,3]],
	[": bluntstone_03.p3d",[2,3]],
	[": bluntstone_01_lc.p3d",[2,3]],
	[": bluntstone_02_lc.p3d",[2,3]],
	[": bluntstone_03_lc.p3d",[1]],
	//SHARPSTONE
	[": sharpstone_01.p3d",[2,3]],
	[": sharpstone_02.p3d",[2,3]],
	[": sharpstone_03.p3d",[1]],
	[": sharpstone_01_lc.p3d",[2,3]],
	[": sharpstone_02_lc.p3d",[2,3]],
	[": sharpstone_03_lc.p3d",[1]],
	[": w_sharpstone_01.p3d",[2,3]],
	[": w_sharpstone_02.p3d",[2,3]],
	[": w_sharpstone_03.p3d",[1]],
	//STONESHARP
	[": stonesharp_medium.p3d",[6,7,8]],
	[": stonesharp_medium_w.p3d",[6,7,8]],
	[": stonesharp_small.p3d",[4,5,6]],
	[": stonesharp_small_w.p3d",[4,5,6]],
	//STONE
	[": stone_big_f.p3d",[6,7,8]],
	[": stone_big_w.p3d",[6,7,8]],
	[": stone_medium_f.p3d",[4,5,6]],
	[": stone_medium_w.p3d",[4,5,6]],
	[": stone_small_f.p3d",[3,4]],
	[": stone_small_w.p3d",[3,4]],
	//SHARPSTONES EROSION
	[": shardstones_erosion.p3d",[1,1,2]],
	[": c_sharpstones_erosion.p3d",[1,1,2]],
	[": w_sharpstones_erosion.p3d",[1,1,2]],
	[": c_sharpstones_erosion_v2.p3d",[1]],
	[": bluntstones_erosion.p3d",[1,1,2]],
	//STONE WALL
	[": stone_4m_f.p3d",[2,3]],
	[": stone_8m_f.p3d",[4,5]],
	[": stone_8md_f.p3d",[2,3]],
	[": stone_pillar_f.p3d",[1]]
];

//FARMS
BRPVP_farms = [
	[
		["BRPVP_farm_wood","BRPVP_farm_metal_trash","BRPVP_craft_cement","BRPVP_farm_sand"],
		[5,3,1,1],
		"BRPVP_equip_pickaxe",
		{[": vergepost_f.p3d"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_craft_wooden_board","BRPVP_farm_metal_trash","BRPVP_craft_cement","BRPVP_farm_sand"],
		[5,3,1,1],
		"BRPVP_equip_axe",
		{[": bench_01_f.p3d",": bench_02_f.p3d",": bench_f.p3d",": workstand_f.p3d"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_foodApple","BRPVP_foodCanned","BRPVP_foodBread","BRPVP_foodWater","BRPVP_foodCake","BRPVP_foodBurger"],
		[1,1,1,1,1,5],
		"",
		{[": sacks_goods_f.p3d",": sacks_heap_f.p3d",": sack_f.p3d",": basket_f.p3d"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_farm_metal_trash","BRPVP_craft_cement","BRPVP_farm_sand"],
		[8,1,1],
		"BRPVP_equip_pickaxe",
		{[": signt_",": signs_",": signc_"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_farm_metal_trash","BRPVP_farm_wood"],
		[7,3],
		"BRPVP_equip_cutter",
		{[": slums02_4m.p3d",": wired_fence_8m_f.p3d"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_farm_stone","BRPVP_craft_cement","BRPVP_craft_brick","BRPVP_farm_metal_trash","BRPVP_farm_limestone","BRPVP_farm_clay"],
		[8,7,6,5,4,3],
		"BRPVP_equip_pickaxe",
		{[": stone_4m_f",": stone_8m_f",": stone_pillar_f",": stone_8md_f",": city_8md_f.p3d",": city2_8md_f.p3d"] call BRPVP_checkIfObjIs},
		"",
		2
	],
	[
		["BRPVP_farm_limestone","BRPVP_farm_clay","BRPVP_farm_coal","BRPVP_farm_stone","BRPVP_farm_iron"],
		[3,3,4,8,3],
		"BRPVP_equip_pickaxe",
		{call BRPVP_checkIfObjIsStone},
		localize "str_ores"
	],
	[
		["BRPVP_farm_wood","BRPVP_farm_latex"],
		[7,3],
		"BRPVP_equip_axe",
		{[": t_"] call BRPVP_checkIfObjIs},
		localize "str_trees"
	],
	[
		["BRPVP_craft_cement"],
		[10],
		"BRPVP_equip_cutter",
		{[": cinderblocks_f"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_farm_wood"],
		[10],
		"BRPVP_equip_axe",
		{[": crateswooden_f"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_craft_wooden_board"],
		[10],
		"BRPVP_equip_axe",
		{[": rowboat_v"] call BRPVP_checkIfObjIs},
		""
	],
	[
		["BRPVP_farm_leaves","BRPVP_farm_cotton"],
		[6,4],
		"BRPVP_equip_axe",
		{[": bw_Set",": b_"] call BRPVP_checkIfObjIs},
		localize "str_bushes"
	],
	[
		["BRPVP_farm_sand"],
		[10],
		"BRPVP_equip_shovel",
		{["#GdtBeach","#Sand"] call BRPVP_checkIfSand},
		localize "str_sand"
	],
	[
		["BRPVP_farm_metal_trash","BRPVP_farm_eletronic_trash"],
		[6,4],
		"BRPVP_equip_cutter",
		{[": wreck_",": garbagewashingmachine_"] call BRPVP_checkIfObjIs},
		localize "str_eletronics",
		2
	],
	[
		["BRPVP_farm_metal_trash","BRPVP_farm_eletronic_trash","BRPVP_craft_rubber"],
		[8,3,3],
		"BRPVP_equip_cutter",
		{[{_this call BRPVP_isMotorized && !alive _this}] call BRPVP_checkIfObjIs},
		localize "str_eletronics",
		3
	],
	//NEW
	[
		["BRPVP_farm_metal_trash"],
		[10],
		"BRPVP_equip_cutter",
		{[": pipes_small_f",": pipes_large_f",": wall_tin_4_2.p3d"] call BRPVP_checkIfObjIs},
		"",
		2
	],
	//NEW
	[
		["BRPVP_farm_metal_trash","BRPVP_craft_rubber","BRPVP_foodWater","BRPVP_foodEnergyDrink"],
		[3,3,2,2],
		"",
		{[": garbagebags_f",": garbagebin_01_f.p3d",": garbagepallet_f.p3d"] call BRPVP_checkIfObjIs},
		localize "str_junk_pile",
		2
	],
	[
		["BRPVP_craft_brick"],
		[10],
		"",
		{[": bricks_v"] call BRPVP_checkIfObjIs},
		localize "str_brick",
		2
	],
	[
		["BRPVP_craft_rubber"],
		[10],
		"BRPVP_equip_cutter",
		{[": tyres_f"] call BRPVP_checkIfObjIs},
		localize "str_rubber"
	],
	[
		["BRPVP_craft_rubber","BRPVP_craft_brick","BRPVP_farm_metal_trash","BRPVP_craft_wooden_board","BRPVP_material_bolt_nail","BRPVP_craft_steel_rebar","BRP_kitConcreto","BRP_kitMovement"],
		[5,5,5,5,4,4,1,1],
		"",
		{[": junkpile_f"] call BRPVP_checkIfObjIs},
		localize "str_junk_pile"
	],
	[
		["BRPVP_farm_sand"],
		[10],
		"",
		{[": barrelsand_f"] call BRPVP_checkIfObjIs},
		localize "str_sand"
	],
	[
		["BRPVP_craft_wooden_board","BRPVP_farm_wood"],
		[9,1],
		"BRPVP_equip_cutter",
		{[": woodenbox_f.p3d",": pallet_f.p3d",": woodentable_large_f.p3d",": rack_f.p3d"] call BRPVP_checkIfObjIs},
		""
	]
];

//PLAYER MISSION MAP OBJECTS GOD MODE