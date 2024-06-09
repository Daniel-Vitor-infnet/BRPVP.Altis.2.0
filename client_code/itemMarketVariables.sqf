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
diag_log "[SCRIPT] itemMarketVariables.sqf BEGIN";

//INDICES DE VENDA
BRPVP_mercadorIdc1 = -1;
BRPVP_mercadorIdc2 = -1;
BRPVP_mercadorIdc3 = -1;

//DEPARTAMENTOS
BRPVP_mercadoNomes = [
	localize "str_mkt_main1", //CLOTHING
	localize "str_mkt_main0", //BACK PACKS
	localize "str_mkt_main11", //EQUIPMENTS
	localize "str_mkt_main5", //PISTOLS
	localize "str_mkt_main3", //ASSAULT RIFLES
	localize "str_mkt_main6", //MACHINE GUN
	localize "str_mkt_main4", //SNIPERS
	localize "str_mkt_main10", //OPTICS
	localize "str_mkt_main12", //WEAPON ACESSORIES
	localize "str_mkt_main13", //LAUNCHERS
	localize "str_mkt_main14", //EXPLOSIVES
	localize "str_mkt_main16", //CONSTRUCTION
	localize "str_mkt_main17", //EXTRA ITEMS
	localize "str_mkt_main18", //ILLEGAL ITEMS
	localize "str_spec_itm_group_food", //FOOD ITEMS
	"Special Loot" //SPECIAL BOX LOOT
];
BRPVP_mercadoNomesNomes = [
	[localize "str_mkt_sub1_0",localize "str_mkt_sub1_2",localize "str_mkt_sub_hide",localize "str_mkt_sub_goggles",localize "str_mkt_main2"], //CLOTHING
	[localize "str_mkt_sub0_0",localize "str_mkt_sub0_1",localize "str_mkt_sub0_2",localize "str_apex_dlc"], //BACK PACKS
	[localize "str_mkt_sub11_0",localize "str_mkt_sub11_1",localize "str_mkt_sub11_2_alt_i",localize "str_spec_itm_group_farm"], //EQUIPMENT
	[localize "str_a3_vanilla",localize "str_mkt_sub7_0"], //PISTOLS
	[localize "str_a3_vanilla",localize "str_mkt_sub12_1",localize "str_mkt_main15"], //ASSAULT RIFLES
	[localize "str_a3_vanilla",localize "str_mkt_main8"], //MACHINE GUN
	[localize "str_a3_vanilla",localize "str_marksman",localize "str_apex_dlc",localize "str_mkt_main9"], //SNIPERS
	[localize "str_mkt_sub10_0",localize "str_mkt_sub10_1"], //OPTICS
	[localize "str_mkt_sub12_1",localize "str_bipods"], //WEAPON ACESSORIES
	[localize "str_mkt_sub13_0",localize "str_mkt_sub13_1",localize "str_super_rockets"], //LAUNCHERS
	[localize "str_mkt_sub14_0",localize "str_mkt_sub14_1",localize "str_mkt_sub14_2"], //EXPLOSIVES
	[localize "str_mkt_sub16_0",localize "str_mkt_sub16_1",localize "str_mkt_sub16_2",localize "str_mkt_sub16_3",localize "str_mkt_sub16_4",localize "str_mkt_sub16_5",localize "str_mkt_sub16_6",localize "str_mkt_sub16_7"], //CONSTRUCTION
	[localize "str_all_itens"], //EXTRA ITEMS
	[localize "str_all_itens"], //ILLEGAL ITEMS
	[localize "str_mkt_sub10_0",localize "str_mkt_sub1_1"], //FOOD ITEMS
	["Admin Items"] //SPECIAL BOX LOOT
];

//  ==================
//	CATEGORIES ACCESS:
//  ==================
//
//	0 - Access through normal traders (pink triangles on map)
//	1 - Access through Fedidex Menu
//	2 - Access through Traveler Aid trader places
//	3 - Admins access (everything, 3 is everywere)
//	4 - Access through Obscure Market (need Obscure Market abilitie)
BRPVP_mercadoNomesNomesFilter = [
	[[0,3],[0,3],[0,3],[0,3],[0,3]], //CLOTHING
	[[0,1,2,3],[0,1,2,3],[0,3],[3]], //BACK PACKS
	[[0,1,2,3],[0,2,3],[0,3],[0,3]], //EQUIPMENTS
	[[0,1,2,3],[0,1,2,3]], //PISTOLS
	[[0,3],[3],[0,1,2,3]], //ASSAULT RIFLES
	[[3],[0,3]], //MACHINE GUNS
	[[3],[3],[3],[0,3]], //SNIPERS
	[[0,1,2,3],[0,3]], //OPTICS
	[[0,2,3],[0,2,3],[0,2,3],[0,2,3]], //WEAPON ACESSORIES
	[[3],[0,3],[3]], //LAUNCHERS
	[[0,3],[0,2,3],[0,1,2,3]], //EXPLOSIVES
	[[0,3],[0,3],[0,3],[0,2,3],[0,3],[0,3],[0,3],[0,3]], //CONSTRUCTION
	[[3]], //EXTRA ITEMS
	[[3,4]], //ILLEGAL ITEMS
	[[0,2,3],[0,3]], //FOOD ITEMS
	[[3]] //SPECIAL BOX LOOT
];

//LOJA PADRAO
BRPVP_mercadoresEstoque = [
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Brogda"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Dazos"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Lamaul"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Soros"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Balior"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Baiano's"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Norberg"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Famus"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Silva"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Bob"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Tarkov"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Ginard"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Mr. Butt"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Darjna"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Kerk"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Fantasia"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Millard"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Tortein"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Grazza"],
	[[0,1,2,3,4,5,6,7,8,9,10,11,14],"Sonderj"],
	[[1,2,3,4,7,8,10,11,14],"Pipo's"]
];
BRPVP_mercadoPrecos = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
BRPVP_mercadoPrecos = BRPVP_mercadoPrecos apply {_x*BRPVP_marketPricesMultiply};

BRPVP_specialItemsOrder = [
	"BRPVP_bodyChange", //0
	"BRPVP_selfRevive",
	"BRP_kitLight",
	"BRP_kitCamuflagem",
	"BRP_kitAreia",
	"BRP_kitGates",
	"BRP_kitCidade",
	"BRP_kitStone",
	"BRP_kitConcreto",
	"BRP_kitMovement",
	"BRP_kitPedras", //10
	"BRP_kitBunkers",
	"BRP_kitTorres",
	"BRP_kitEspecial",
	"BRP_kitContainers",
	"BRP_kitTableChair",
	"BRP_kitBeach",
	"BRP_kitReligious",
	"BRP_kitStuffo1",
	"BRP_kitStuffo2",
	"BRP_kitLamp", //20
	"BRP_kitRecreation",
	"BRP_kitMilitarSign",
	"BRP_kitFuelStorage",
	"BRP_kitSmallLights",
	"BRP_kitWrecks",
	"BRP_kitTrees",
	"BRP_kitCasebres",
	"BRP_kitSmallHouse",
	"BRP_kitAverageHouse",
	"BRP_kitBigHouse", //30
	"BRP_kitGiantHouse",
	"BRP_kitAntennaA",
	"BRP_kitAntennaB",
	"BRP_kitRespawnA",
	"BRP_kitRespawnB",
	"BRP_kitHelipad",
	"BRP_kitAutoTurret",
	"BRP_kitAutoTurretLvl2",
	"BRP_kitFlags25",
	"BRP_kitFlags50", //40
	"BRP_kitFlags100",
	"BRP_kitFlags200",
	"BRPVP_minervaShot",
	"BRPVP_boxeItem",
	"BRP_boxThief",
	"BRP_vehicleThief",
	"BRP_doorThief",
	"BRP_hackTool",
	"BRP_identifier",
	"BRP_remoteControl", //50
	"BRP_zombieSpawn",
	"BRPVP_turnInBandit",
	"BRPVP_possession",
	"BRPVP_possessionStrong",
	"BRPVP_possessionPlayer",
	"BRPVP_vehicleTorque",
	"BRPVP_atmFix",
	"BRPVP_bigFloor200",
	"BRPVP_bigFloorRemove",
	"BRPVP_uberPack", //60
	"BRPVP_uberAttack",
	"BRPVP_itemMagnet",
	"BRPVP_newsPaper",
	"BRPVP_turretUpgrade",
	"Mag_BRPVP_hydraulic_jack",
	"Mag_BRPVP_z_blood_bag",
	"Mag_BRPVP_scanner_100",
	"Mag_BRPVP_scanner_200",
	"Mag_BRPVP_scanner_300",
	"Mag_BRPVP_fuel_gallon", //70
	"BRPVP_vehicleAmmo",
	"Mag_BRPVP_veh_ownerity",
	"BRPVP_hulk_pills",
	"BRPVP_drone_finder",
	"BRPVP_baseBomb",
	"BRPVP_xrayItem",
	"BRPVP_antiBaseBomb",
	"BRPVP_personalTracer",
	"BRPVP_houseGodMode",
	"BRPVP_baseTest", //80
	"BRPVP_noGrass",
	"BRPVP_itemPaintVehicle",
	"BRPVP_itemPaintThinner",
	"BRPVP_itemClimb",
	"BRPVP_playerLaunch",
	"BRPVP_playerLaunchSuper",
	"BRPVP_bagSoldier",
	"BRPVP_carrier",
	"BRPVP_baseMine",
	"BRPVP_baseMineDefuse",
	"BRPVP_baseBoxUpgrade", //90
	"BRPVP_equip_axe",
	"BRPVP_equip_shovel",
	"BRPVP_equip_cutter",
	"BRPVP_equip_pickaxe",
	"BRPVP_farm_limestone",
	"BRPVP_farm_clay",
	"BRPVP_farm_coal",
	"BRPVP_farm_stone",
	"BRPVP_farm_iron",
	"BRPVP_farm_leaves", //100
	"BRPVP_farm_cotton",
	"BRPVP_farm_wood",
	"BRPVP_farm_latex",
	"BRPVP_farm_sand",
	"BRPVP_farm_metal_trash",
	"BRPVP_farm_eletronic_trash",
	"BRPVP_craft_cement",
	"BRPVP_craft_brick",
	"BRPVP_craft_circuits",
	"BRPVP_craft_steel_plate", //110
	"BRPVP_craft_steel_rebar",
	"BRPVP_craft_wooden_board",
	"BRPVP_craft_reinforced_concrete",
	"BRPVP_craft_fabric",
	"BRPVP_craft_wooden_wall",
	"BRPVP_craft_brick_wall",
	"BRPVP_craft_steel_wall",
	"BRPVP_craft_stone_x10",
	"BRPVP_craft_rubber",
	"BRPVP_craft_foundations", //120
	"BRPVP_craft_steel_structure",
	"BRPVP_material_seam_kit",
	"BRPVP_material_bolt_nail",
	"BRPVP_foodApple",
	"BRPVP_foodCanned",
	"BRPVP_foodBread",
	"BRPVP_foodWater",
	"BRPVP_foodCake",
	"BRPVP_foodBurger",
	"BRPVP_foodEnergyDrink", //130
	"BRP_vodka",
	"BRPVP_secCam",
	"BRPVP_trench",
	"BRPVP_kriptonite",
	"BRPVP_kriptoniteRed",
	"BRPVP_divineFire",
	"BRPVP_atomicShot",
	"BRPVP_prideAtomicShot",
	"BRPVP_miraculousEyeDrop",
	"BRPVP_antiAtomicBomb", //140
	"BRPVP_mammothAmmo",
	"BRPVP_voodooDoll",
	"BRPVP_goldBars"
];

//SPECIAL ITEMS GROUP
BRPVP_specialItemsGroup = [
	localize "str_spec_itm_group_cons", //0
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons", //10
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons", //20
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons", //30
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_food", //40
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip", //50
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm", //60
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_farm",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft", //70
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft", //80
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_craft",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip", //90
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_food",
	localize "str_spec_itm_group_food", //100
	localize "str_spec_itm_group_food",
	localize "str_spec_itm_group_food",
	localize "str_spec_itm_group_food",
	localize "str_spec_itm_group_food",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip", //110
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_cons",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_food",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip", //120
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip", //130
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_equip", //140
	localize "str_spec_itm_group_equip",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_thief",
	localize "str_spec_itm_group_craft"
];

BRPVP_specialItemsFreeOfFlag = [
	true, //0
	true,
	true,
	true,
	true,
	true,
	true,
	false,
	false,
	false,
	true, //10
	true,
	false,
	true,
	true,
	true,
	true,
	true,
	false,
	true,
	true, //20
	false,
	false,
	false,
	true,
	false,
	false,
	true,
	false,
	true,
	true, //30
	true,
	true,
	false,
	false,
	false,
	true,
	true,
	true,
	true,
	true, //40
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //50
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //60
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //70
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //80
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	false, //90
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //100
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //110
	false,
	false,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //120
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //130
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true, //140
	true,
	true,
	true,
	true
];

//SPECIAL ITEMS REMOVE TIME
BRPVP_specialItemsRemoveTime = [
	10, //0
	10,
	10,
	10,
	10,
	15,
	15,
	20,
	30,
	40,
	5, //10
	5,
	10,
	5,
	5,
	10,
	10,
	5,
	10,
	10,
	20, //20
	30,
	15,
	30,
	10,
	15,
	20,
	10,
	30,
	30,
	40, //30
	50,
	50,
	60,
	100,
	15,
	[3],
	[4],
	[5],
	10,
	-1, //40
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0, //50
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0, //60
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0, //70
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0, //80
	0,
	0,
	0,
	0,
	0,
	0,
	30,
	0,
	0,
	0, //90
	0,
	0,
	0,
	0,
	10,
	0,
	0,
	0,
	0,
	0, //100
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0, //110
	25,
	40,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0, //120
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	20,
	0, //130
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0, //140
	0,
	0,
	0,
	0
];
//SPECIAL ITEMS NAMES
BRPVP_specialItemsNames = [
	localize "str_mkt_cons0", //0
	localize "str_mkt_cons1",
	localize "str_mkt_cons2",
	localize "str_mkt_cons3",
	localize "str_mkt_cons4",
	localize "str_mkt_cons5",
	localize "str_mkt_cons6",
	localize "str_mkt_cons7",
	localize "str_mkt_cons8",
	localize "str_mkt_cons9",
	localize "str_mkt_cons10", //10
	localize "str_mkt_cons11",
	localize "str_mkt_cons12",
	localize "str_mkt_cons13",
	localize "str_mkt_cons14",
	localize "str_mkt_cons15",
	localize "str_mkt_cons16",
	localize "str_mkt_cons17",
	localize "str_mkt_cons18",
	localize "str_mkt_cons19",
	localize "str_mkt_cons20", //20
	localize "str_mkt_cons21",
	localize "str_mkt_cons22",
	localize "str_mkt_cons23",
	localize "str_mkt_cons24",
	localize "str_mkt_cons25",
	localize "str_mkt_cons26",
	localize "str_mkt_cons27",
	localize "str_mkt_cons28",
	localize "str_mkt_cons29",
	localize "str_mkt_cons30", //30
	localize "str_mkt_cons31",
	localize "str_mkt_cons32",
	localize "str_mkt_cons33",
	localize "str_mkt_cons34",
	localize "str_mkt_cons35",
	localize "str_thief_key_box",
	localize "str_thief_key_veh",
	localize "str_thief_key_door",
	localize "str_mkt_cons36",
	localize "str_mkt_vodka", //40
	localize "str_hack_tool",
	localize "str_identifier",
	localize "str_remote_control",
	localize "str_zombie_spawn",
	localize "str_brpvp_hydraulic_jack_displayname",
	localize "str_brpvp_z_blood_bag_displayname",
	localize "str_brpvp_scanner_100_displayname",
	localize "str_brpvp_scanner_200_displayname",
	localize "str_brpvp_scanner_300_displayname",
	localize "str_brpvp_fuel_gallon_displayname", //50
	localize "str_brpvp_veh_ownerity_displayname",
	localize "str_brpvp_equip_axe_displayname",
	localize "str_brpvp_equip_shovel_displayname",
	localize "str_brpvp_equip_cutter_displayname",
	localize "str_brpvp_equip_pickaxe_displayname",
	localize "str_brpvp_farm_limestone_displayname",
	localize "str_brpvp_farm_clay_displayname",
	localize "str_brpvp_farm_coal_displayname",
	localize "str_brpvp_farm_stone_displayname",
	localize "str_brpvp_farm_iron_displayname", //60
	localize "str_brpvp_farm_leaves_displayname",
	localize "str_brpvp_farm_cotton_displayname",
	localize "str_brpvp_farm_wood_displayname",
	localize "str_brpvp_farm_latex_displayname",
	localize "str_brpvp_farm_sand_displayname",
	localize "str_brpvp_farm_metal_trash_displayname",
	localize "str_brpvp_farm_eletronic_trash_displayname",
	localize "str_brpvp_craft_cement_displayname",
	localize "str_brpvp_craft_brick_displayname",
	localize "str_brpvp_craft_circuits_displayname", //70
	localize "str_brpvp_craft_steel_plate_displayname",
	localize "str_brpvp_craft_steel_rebar_displayname",
	localize "str_brpvp_craft_wooden_board_displayname",
	localize "str_brpvp_craft_reinforced_concrete_displayname",
	localize "str_brpvp_craft_fabric_displayname",
	localize "str_brpvp_craft_wooden_wall_displayname",
	localize "str_brpvp_craft_brick_wall_displayname",
	localize "str_brpvp_craft_steel_wall_displayname",
	localize "str_brpvp_craft_stone_x10_displayname",
	localize "str_brpvp_craft_rubber_displayname", //80
	localize "str_brpvp_craft_foundations_displayname",
	localize "str_brpvp_craft_steel_structure_displayname",
	localize "str_brpvp_material_seam_kit_displayname",
	localize "str_brpvp_material_bolt_nail_displayname",
	localize "str_brpvp_hulk_pills_displayname",
	localize "str_brpvp_drone_finder_displayname",
	localize "str_cons_gates",
	localize "str_name_base_bomb",
	localize "str_personal_tracer",
	localize "str_god_mode_house", //90
	localize "str_name_anti_base_bomb",
	localize "str_name_into_bandit",
	localize "str_base_test_item",
	localize "str_item_no_grass",
	localize "str_small_lights_kit",
	localize "str_item_paint_vehicle",
	localize "str_item_paint_thinner",
	localize "str_item_climb",
	localize "str_food_apple",
	localize "str_food_canned", //100
	localize "str_food_bread",
	localize "str_food_water",
	localize "str_food_cake",
	localize "str_food_energy_drink",
	localize "str_player_launch",
	localize "str_bag_soldier",
	localize "str_carrier_item",
	localize "str_base_mine",
	localize "str_base_mine_defuse",
	localize "str_rearm_vehicle_item_name", //110
	localize "str_kit_bunkers",
	localize "str_kit_turret_lvl2",
	localize "str_turret_upgrade_item",
	localize "str_food_burger",
	localize "str_xray_item_name",
	localize "str_item_magnet",
	localize "str_item_newspaper",
	localize "str_item_uber_pack",
	localize "str_item_big_floor_200",
	localize "str_item_big_floor_remove", //120
	localize "str_item_atm_fix",
	localize "str_item_boxe",
	localize "str_item_self_revive",
	localize "str_item_body_change",
	localize "str_alti_item_torque",
	localize "str_item_possession",
	localize "str_item_possession_strong",
	localize "str_item_possession_player",
	localize "str_item_uber_attack",
	localize "str_item_sec_cam", //130
	localize "str_item_trench",
	localize "str_item_base_box_upgrade",
	localize "str_item_minerva_shot",
	localize "str_item_kriptonite",
	localize "str_item_kriptonite_red",
	localize "str_item_divine_fire",
	localize "str_item_atomic_bomb",
	localize "str_item_pride_atomic_bomb",
	localize "str_item_miraculous_eye_drop",
	localize "str_item_anti_atomic_bomb", //140
	localize "str_item_mammoth_ammo",
	localize "str_player_launch_super",
	localize "str_voodoo_doll",
	localize "str_item_gold_bars"
];

//SPECIAL ITEMS IMAGES
BRPVP_specialItemsImages = [
	"BRP_imagens\items\BRP_kitLight.paa", //0
	"BRP_imagens\items\BRP_kitCamuflagem.paa",
	"BRP_imagens\items\BRP_kitAreia.paa",
	"BRP_imagens\items\BRP_kitCidade.paa",
	"BRP_imagens\items\BRP_kitStone.paa",
	"BRP_imagens\items\BRP_kitCasebres.paa",
	"BRP_imagens\items\BRP_kitConcreto.paa",
	"BRP_imagens\items\BRP_kitPedras.paa",
	"BRP_imagens\items\BRP_kitTorres.paa",
	"BRP_imagens\items\BRP_kitEspecial.paa",
	"BRP_imagens\items\BRP_kitTableChair.paa", //10
	"BRP_imagens\items\BRP_kitBeach.paa",
	"BRP_imagens\items\BRP_kitReligious.paa",
	"BRP_imagens\items\BRP_kitStuffo1.paa",
	"BRP_imagens\items\BRP_kitStuffo2.paa",
	"BRP_imagens\items\BRP_kitLamp.paa",
	"BRP_imagens\items\BRP_kitRecreation.paa",
	"BRP_imagens\items\BRP_kitMilitarSign.paa",
	"BRP_imagens\items\BRP_kitFuelStorage.paa",
	"BRP_imagens\items\BRP_kitWrecks.paa",
	"BRP_imagens\items\BRP_kitSmallHouse.paa", //20
	"BRP_imagens\items\BRP_kitAverageHouse.paa",
	"BRP_imagens\items\BRP_kitAntennaA.paa",
	"BRP_imagens\items\BRP_kitAntennaB.paa",
	"BRP_imagens\items\BRP_kitMovement.paa",
	"BRP_imagens\items\BRP_kitRespawnA.paa",
	"BRP_imagens\items\BRP_kitRespawnB.paa",
	"BRP_imagens\items\BRP_kitHelipad.paa",
	"BRP_imagens\items\BRP_kitAutoTurret.paa",
	"BRP_imagens\items\BRP_kitFlags25.paa",
	"BRP_imagens\items\BRP_kitFlags50.paa", //30
	"BRP_imagens\items\BRP_kitFlags100.paa",
	"BRP_imagens\items\BRP_kitFlags200.paa",
	"BRP_imagens\items\BRP_kitAdmin.paa",
	"BRP_imagens\items\BRP_kitAdmin.paa",
	"BRP_imagens\items\BRP_kitContainers.paa",
	"BRP_imagens\items\BRP_masterKeyBox.paa",
	"BRP_imagens\items\BRP_masterKeyVehicle.paa",
	"BRP_imagens\items\BRP_masterKeyDoor.paa",
	"BRP_imagens\items\BRP_kitTrees.paa",
	"BRP_imagens\items\BRP_vodka.paa", //40
	"BRP_imagens\items\BRP_hackTool.paa",
	"BRP_imagens\items\BRP_identifier.paa",
	"BRP_imagens\items\BRP_remoteControl.paa",
	"BRP_imagens\items\BRP_zombieSpawn.paa",
	"BRP_imagens\hydraulic_jack.paa",
	"BRP_imagens\z_blood_bag.paa",
	"BRP_imagens\scanner.paa",
	"BRP_imagens\scanner.paa",
	"BRP_imagens\scanner.paa",
	"BRP_imagens\fuel_gallon.paa", //50
	"BRP_imagens\vehicle_ownerity.paa",
	"BRP_imagens\axe.paa",
	"BRP_imagens\shovel.paa",
	"BRP_imagens\cutter.paa",
	"BRP_imagens\pickaxe.paa",
	"BRP_imagens\ore.paa",
	"BRP_imagens\clay.paa",
	"BRP_imagens\coal.paa",
	"BRP_imagens\ore.paa",
	"BRP_imagens\iron.paa", //60
	"BRP_imagens\leaves.paa",
	"BRP_imagens\cotton.paa",
	"BRP_imagens\wood.paa",
	"BRP_imagens\latex.paa",
	"BRP_imagens\sand.paa",
	"BRP_imagens\metal_trash.paa",
	"BRP_imagens\eletronic_trash.paa",
	"BRP_imagens\cement.paa",
	"BRP_imagens\brick.paa",
	"BRP_imagens\circuits.paa", //70
	"BRP_imagens\steel_plate.paa",
	"BRP_imagens\steel_rebar.paa",
	"BRP_imagens\wooden_board.paa",
	"BRP_imagens\reinforced_concrete.paa",
	"BRP_imagens\fabric.paa",
	"BRP_imagens\wooden_wall.paa",
	"BRP_imagens\brick_wall.paa",
	"BRP_imagens\steel_wall.paa",
	"BRP_imagens\ore.paa",
	"BRP_imagens\rubber.paa", //80
	"BRP_imagens\foundations.paa",
	"BRP_imagens\steel_structure.paa",
	"BRP_imagens\material_seam_kit.paa",
	"BRP_imagens\material_bolt_nail.paa",
	"BRP_imagens\hulk_pills.paa",
	"BRP_imagens\drone_finder.paa",
	"BRP_imagens\items\BRP_kitGates.paa",
	"BRP_imagens\base_bomb.paa",
	"BRP_imagens\tracer.paa",
	"BRP_imagens\god_mode_house.paa", //90
	"BRP_imagens\anti_base_bomb.paa",
	"BRP_imagens\bandit_item.paa",
	"BRP_imagens\base_test.paa",
	"BRP_imagens\no_grass_item.paa",
	"BRP_imagens\items\BRP_kitSmallLights.paa",
	"BRP_imagens\paint_vehicle.paa",
	"BRP_imagens\paint_thinner.paa",
	"BRP_imagens\climb.paa",
	"BRP_imagens\apple.paa",
	"BRP_imagens\canned_food.paa", //100
	"BRP_imagens\crispy_bread.paa",
	"BRP_imagens\water_bottle.paa",
	"BRP_imagens\piece_of_cake.paa",
	"BRP_imagens\energy_drink.paa",
	"BRP_imagens\player_launch.paa",
	"BRP_imagens\bag_soldier.paa",
	"BRP_imagens\acarrier_item.paa",
	"BRP_imagens\base_mine.paa",
	"BRP_imagens\base_mine_defuse.paa",
	"BRP_imagens\vehicle_ammo.paa", //110
	"BRP_imagens\items\BRP_kitBunkers.paa",
	"BRP_imagens\items\BRP_kitAutoTurretLvl2.paa",
	"BRP_imagens\turret_upgrade.paa",
	"BRP_imagens\anti_burger.paa",
	"BRP_imagens\xray.paa",
	"BRP_imagens\magnet.paa",
	"BRP_imagens\newspaper.paa",
	"BRP_imagens\uber_pack.paa",
	"BRP_imagens\big_floor.paa",
	"BRP_imagens\big_floor_remove.paa", //120
	"BRP_imagens\interface\atm_fix.paa",
	"BRP_imagens\boxe.paa",
	"BRP_imagens\self_revive.paa",
	"BRP_imagens\body_change.paa",
	"BRP_imagens\torque.paa",
	"BRP_imagens\possession.paa",
	"BRP_imagens\possession_strong.paa",
	"BRP_imagens\possession_player.paa",
	"BRP_imagens\uber_attack_item.paa",
	"BRP_imagens\sec_cam.paa", //130
	"BRP_imagens\trench.paa",
	"BRP_imagens\box_upgrade.paa",
	"BRP_imagens\minerva_shot.paa",
	"BRP_imagens\kriptonite.paa",
	"BRP_imagens\kriptonite_red.paa",
	"BRP_imagens\divine_fire.paa",
	"BRP_imagens\atomic_bomb.paa",
	"BRP_imagens\pride_atomic_bomb.paa",
	"BRP_imagens\miraculous_eye_drop.paa",
	"BRP_imagens\anti_atomic_bomb.paa", //140
	"BRP_imagens\mammoth_ammo.paa",
	"BRP_imagens\player_launch_super.paa",
	"BRP_imagens\voodoo_doll.paa",
	"BRP_imagens\gold_bars.paa"
];

BRPVP_traderWeaponItemsName = [];
BRPVP_traderWeaponItemsIdcs = [];
_wi = [[3,1],[4,2],[5,1],[6,3],[7,0],[7,1],[8,0],[8,1],[9,1],[9,2],[10,2]];
{
	if ([_x select 0,_x select 1] in _wi) then {
		BRPVP_traderWeaponItemsName pushBack (_x select 3);
		BRPVP_traderWeaponItemsIdcs pushBack [_x select 0,_x select 1,_x select 4];
	};
} forEach BRPVP_mercadoItens;
diag_log ("[BRPVP] count BRPVP_mercadoItens: "+str count BRPVP_mercadoItens+" | count BRPVP_traderWeaponItemsName: "+str count BRPVP_traderWeaponItemsName);

//REMOVE TRADER ITEMS
if (!BRPVP_pveAllowBandit) then {BRPVP_removeFromTrader pushBack "BRPVP_turnInBandit";};
_del = [];
{
	if ((_x select 3) in BRPVP_removeFromTrader) then {_del pushBack _forEachIndex;};
} forEach BRPVP_mercadoItens;
_del sort false;
{BRPVP_mercadoItens deleteAt _x;} forEach _del;

//LOOT ARRAY
BRPVP_mercadoItensLoot = +BRPVP_mercadoItens;
_del = [];
{
	_remove = (_x select 0) in BRPVP_lootDeniedItemsFromTraders || [_x select 0,_x select 1] in BRPVP_lootDeniedItemsFromTraders;
	if (_remove) then {_del pushBack _forEachIndex;};
} forEach BRPVP_mercadoItensLoot;
_del sort false;
{BRPVP_mercadoItensLoot deleteAt _x;} forEach _del;

//ONLY ITEM CLASSES
BRPVP_mercadoItensClass = [];
{BRPVP_mercadoItensClass pushBack (_x select 3);} forEach BRPVP_mercadoItens;
diag_log ("[BRPVP MARKET] BRPVP_mercadoItensClass = "+str BRPVP_mercadoItensClass+".");

//ITEMS CFG TYPE AND PARENTS
BRPVP_mercadoItensParents = [];
{
    private ["_item","_ic","_ip"];
    _item = _x select 3;
	_ic = 0;
	_ip = [];
	if (isClass (configFile >> "CfgMagazines" >> _item)) then {
		_ic = 0;
		_ip = [configfile >> "CfgMagazines" >> _item,true] call BIS_fnc_returnParents;
	} else {
		if (isClass (configFile >> "CfgWeapons" >> _item)) then {
			_ic = 1;
			_ip = [configfile >> "CfgWeapons" >> _item,true] call BIS_fnc_returnParents;
		} else {
			if (isClass (configFile >> "CfgVehicles" >> _item)) then {
				_ic = 2;
				_ip = [configfile >> "CfgVehicles" >> _item,true] call BIS_fnc_returnParents;
			};
		};
	};
    BRPVP_mercadoItensParents pushBack [_item,_ic,_ip];
} forEach BRPVP_mercadoItens;
diag_log ("[BRPVP MARKET] BRPVP_mercadoItensParents = "+str BRPVP_mercadoItensParents+".");

diag_log ("[SCRIPT] itemMarketVariables.sqf END: "+str round (diag_tickTime-_scriptStart));