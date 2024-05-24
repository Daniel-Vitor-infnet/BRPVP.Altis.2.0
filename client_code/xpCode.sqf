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

BRPVP_xpPerksIndividualOrder = 102;
BRPVP_xpPerks = [
	//EXTRA VAULT
	[
		format [localize "str_xp_perks_many_vaults",BRPVP_vaultNumberCfg+1],
		200000,
		{player setVariable ["brpvp_vaults_xp",BRPVP_vaultNumberCfg+1,true];},
		true,
		1,
		[0,[]],
		[1,1],
		[true,{player setVariable ["brpvp_vaults_xp",BRPVP_vaultNumberCfg,true];}]
	],
	[
		format [localize "str_xp_perks_many_vaults",BRPVP_vaultNumberCfg+2],
		525000,
		{player setVariable ["brpvp_vaults_xp",BRPVP_vaultNumberCfg+2,true];},
		true,
		2,
		[0,[1]],
		[1,2],
		[true,{player setVariable ["brpvp_vaults_xp",BRPVP_vaultNumberCfg+1,true];}]
	],
	[
		format [localize "str_xp_perks_many_vaults",BRPVP_vaultNumberCfg+3],
		700000,
		{player setVariable ["brpvp_vaults_xp",BRPVP_vaultNumberCfg+3,true];},
		true,
		3,
		[0,[1,2]],
		[1,3],
		[true,{player setVariable ["brpvp_vaults_xp",BRPVP_vaultNumberCfg+2,true];}]
	],
	[
		localize "str_xp_perks_vault_anywhere",
		700000,
		{BRPVP_openPersonalVaultAnywhere = true;},
		true,
		14,
		[800000,[1,2,3]],
		[1,4],
		[true,{BRPVP_openPersonalVaultAnywhere = false;}]
	],
	[
		localize "str_xp_perks_vault_bigger",
		1000000,
		{BRPVP_personalVaultCargoSize = BRPVP_personalVaultCargoSize*2;},
		true,
		60,
		[1250000,[1,2,3,14]],
		[1,5],
		[false,{BRPVP_personalVaultCargoSize = BRPVP_personalVaultCargoSize/2;}]
	],
	//EXTRA TRADER ITEMS
	[
		localize "str_xp_perks_trader_arifle",
		300000,
		{[[4,1,0]] call BRPVP_xpAddTraderITems;},
		true,
		4,
		[0,[]],
		[2,1],
		[true,{[[4,1,0]] call BRPVP_xpAddTraderITemsRemove;}]
	],
	[
		localize "str_xp_perks_trader_mg",
		400000,
		{[[5,0,0]] call BRPVP_xpAddTraderITems;},
		true,
		5,
		[0,[4]],
		[2,2],
		[true,{[[5,0,0]] call BRPVP_xpAddTraderITemsRemove;}]
	],
	[
		localize "str_xp_perks_trader_srifle",
		600000,
		{[[6,0,0],[6,1,0],[6,2,0]] call BRPVP_xpAddTraderITems;},
		true,
		6,
		[350000,[4,5]],
		[2,3],
		[true,{[[6,0,0],[6,1,0],[6,2,0]] call BRPVP_xpAddTraderITemsRemove;}]
	],
	[
		localize "str_xp_perks_trader_launcher",
		800000,
		{[[9,0,0]] call BRPVP_xpAddTraderITems;},
		true,
		7,
		[500000,[4,5,6]],
		[2,4],
		[true,{[[9,0,0]] call BRPVP_xpAddTraderITemsRemove;}]
	],
	[
		localize "str_xp_perks_trader_rocket",
		1000000,
		{[[9,2,0]] call BRPVP_xpAddTraderITems;},
		true,
		8,
		[650000,[4,5,6,7]],
		[2,5],
		[true,{[[9,2,0]] call BRPVP_xpAddTraderITemsRemove;}]
	],
	//JUMP
	[
		localize "str_xp_perks_jump",
		100000,
		{BRPVP_perkJump = 1;},
		true,
		9,
		[0,[]],
		[3,1],
		[true,{BRPVP_perkJump = 0;}]
	],
	[
		localize "str_xp_perks_small_climb",
		375000,
		{BRPVP_perkJump = 2;},
		true,
		10,
		[0,[9]],
		[3,2],
		[true,{BRPVP_perkJump = 1;}]
	],
	[
		localize "str_xp_perks_climb",
		575000,
		{BRPVP_perkJump = 3;},
		true,
		11,
		[2000000,[9,10]],
		[3,3],
		[true,{BRPVP_perkJump = 2;}]
	],
	[
		localize "str_special_climb_action",
		1000000,
		{
			BRPVP_specialClimbOn = true;
			if (BRPVP_pathClimbAction isNotEqualTo -1) then {player removeAction BRPVP_pathClimbAction;};
			BRPVP_pathClimbAction = player addAction ["<t color='#FF6000'>"+localize "str_special_climb_action"+"</t>",{call BRPVP_pathClimbActionCode;},objNull,2,false,true,"","!BRPVP_pathClimbTrying && !BRPVP_pathClimbOn && isNull objectParent _originalTarget"];
		},
		true,
		68,
		[2500000,[9,10,11]],
		[3,4],
		[true,{
			BRPVP_specialClimbOn = false;
			if (BRPVP_pathClimbAction isNotEqualTo -1) then {player removeAction BRPVP_pathClimbAction;};
		}]
	],
	[
		localize "str_extra_sjump_perk",
		1000000,
		{BRPVP_superJumpBoostCfg = 4;},
		true,
		74,
		[2500000,[9,10,11,68]],
		[3,5],
		[true,{BRPVP_superJumpBoostCfg = 1;}]
	],
	//OBSCURE TRADER
	[
		localize "str_thief_obsc_trader",
		275000,
		{BRPVP_xpAllowObscureITems = true;},
		true,
		21,
		[0,[]],
		[4,1],
		[true,{BRPVP_xpAllowObscureITems = false;}]
	],
	[
		localize "str_xp_perks_contracts",
		550000,
		{BRPVP_killContractsShowAction = true;},
		true,
		22,
		[0,[21]],
		[4,2],
		[true,{BRPVP_killContractsShowAction = false;}]
	],
	[
		localize "str_carrier_item",
		825000,
		{BRPVP_xpAllowCarrier = true;},
		true,
		23,
		[0,[21,22]],
		[4,3],
		[true,{BRPVP_xpAllowCarrier = false;}]
	],
	//FOOD HABILITIES
	[
		localize "str_xp_perks_half_hungry",
		50000,
		{BRPVP_foodEatCycle = BRPVP_foodEatCycle*2;},
		true,
		24,
		[0,[]],
		[5,1],
		[true,{BRPVP_foodEatCycle = BRPVP_foodEatCycle/2;}]
	],
	[
		localize "str_xp_perks_35_hungry",
		325000,
		{BRPVP_foodEatCycle = round (BRPVP_foodEatCycle*10/7);},
		true,
		25,
		[0,[24]],
		[5,2],
		[true,{BRPVP_foodEatCycle = round (BRPVP_foodEatCycle*7/10);}]
	],
	[
		localize "str_xp_perks_light_eater",
		650000,
		{BRPVP_foodEatLightEater = true;},
		true,
		26,
		[1000000,[24,25]],
		[5,3],
		[true,{BRPVP_foodEatLightEater = false;}]
	],
	[
		format [localize "str_perk_more_healthy",50,"%"], //50% MORE PLAYER HEALTY
		1000000,
		{BRPVP_playerLifeMultiplier = BRPVP_playerLifeMultiplier*1.5;},
		true,
		41,
		[1000000,[24,25,26]],
		[5,4],
		[true,{BRPVP_playerLifeMultiplier = BRPVP_playerLifeMultiplier/1.5;}]
	],
	//BOB TOW
	[
		localize "str_xp_perks_tow_2",
		300000,
		{BRPVP_towLandNumber = 2;},
		true,
		27,
		[0,[]],
		[6,1],
		[true,{BRPVP_towLandNumber = 1;}]
	],
	[
		localize "str_xp_perks_tow_3",
		600000,
		{BRPVP_towLandNumber = 3;},
		true,
		28,
		[500000,[27]],
		[6,2],
		[true,{BRPVP_towLandNumber = 2;}]
	],
	//VIRTUAL GARAGE
	[
		localize "str_xp_perks_vg_half_delay",
		150000,
		{BRPVP_virtualGarageTimeToStore = round (BRPVP_virtualGarageTimeToStoreCfg*0.5);},
		true,
		29,
		[0,[]],
		[7,1],
		[true,{BRPVP_virtualGarageTimeToStore = round (BRPVP_virtualGarageTimeToStoreCfg);}]
	],
	[
		localize "str_xp_perks_vg_35_delay",
		350000,
		{BRPVP_virtualGarageTimeToStore = round (BRPVP_virtualGarageTimeToStoreCfg*0.5*0.7);},
		true,
		30,
		[0,[29]],
		[7,2],
		[true,{BRPVP_virtualGarageTimeToStore = round (BRPVP_virtualGarageTimeToStoreCfg*0.5);}]
	],
	[
		localize "str_xp_perks_vg_no_delay",
		850000,
		{BRPVP_virtualGarageTimeToStore = 0;},
		true,
		31,
		[500000,[29,30]],
		[7,3],
		[true,{BRPVP_virtualGarageTimeToStore = BRPVP_virtualGarageTimeToStoreCfg*0.5*0.7;}]
	],
	[
		localize "str_xp_perks_vg_anywhere",
		950000,
		{BRPVP_virtualGarageEverywhere = true;},
		true,
		32,
		[1000000,[29,30,31]],
		[7,4],
		[true,{BRPVP_virtualGarageEverywhere = false;}]
	],
	[
		format [localize "str_xp_perks_vg_x_slots",1],
		250000,
		{[[0,1/*CAR*/],[6,1/*SHIP*/],[7,4/*LIGHT DRONE*/]] call BRPVP_addVgSlots;},
		true,
		33,
		[0,[]],
		[8,1],
		[true,{[[0,-1/*CAR*/],[6,-1/*SHIP*/],[7,-4/*LIGHT DRONE*/]] call BRPVP_addVgSlots;}]
	],
	[
		format [localize "str_xp_perks_vg_x_slots",2],
		500000,
		{[[1,1/*CAR ARMORED*/],[2,1/*APC*/]] call BRPVP_addVgSlots;},
		true,
		34,
		[0,[33]],
		[8,2],
		[true,{[[1,-1/*CAR ARMORED*/],[2,-1/*APC*/]] call BRPVP_addVgSlots;}]
	],
	[
		format [localize "str_xp_perks_vg_x_slots",3],
		725000,
		{[[3,2/*TANK*/],[4,1/*HELI*/]] call BRPVP_addVgSlots;},
		true,
		35,
		[0,[33,34]],
		[8,3],
		[true,{[[3,-2/*TANK*/],[4,-1/*HELI*/]] call BRPVP_addVgSlots;}]
	],
	[
		format [localize "str_xp_perks_vg_x_slots",4],
		975000,
		{[[5,1/*JET*/],[8,1/*ATTACK DRONE*/]] call BRPVP_addVgSlots;},
		true,
		36,
		[0,[33,34,35]],
		[8,4],
		[true,{[[5,-1/*JET*/],[8,-1/*ATTACK DRONE*/]] call BRPVP_addVgSlots;}]
	],
	[
		format [localize "str_xp_perks_vg_x_slots",5],
		1000000,
		{[[0,1/*CAR*/],[6,1/*SHIP*/],[7,2/*LIGHT DRONE*/],[1,1/*CAR ARMORED*/],[2,1/*APC*/],[3,1/*TANK*/],[4,1/*HELI*/],[5,1/*JET*/],[8,1/*ATTACK DRONE*/]] call BRPVP_addVgSlots;},
		true,
		40,
		[2000000,[33,34,35,36]],
		[8,5],
		[true,{[[0,-1/*CAR*/],[6,-1/*SHIP*/],[7,-2/*LIGHT DRONE*/],[1,-1/*CAR ARMORED*/],[2,-1/*APC*/],[3,-1/*TANK*/],[4,-1/*HELI*/],[5,-1/*JET*/],[8,-1/*ATTACK DRONE*/]] call BRPVP_addVgSlots;}]
	],
	//BANK LIMIT
	[
		format [localize "str_xp_perks_bank_limit",40],
		225000,
		{
			BRPVP_totalMoneyInBank = BRPVP_totalMoneyInBank+40000000;
			player setVariable ["brpvp_max_in_bank",BRPVP_totalMoneyInBank,true];
		},
		true,
		37,
		[0,[]],
		[9,1],
		[
			true,
			{
				BRPVP_totalMoneyInBank = BRPVP_totalMoneyInBank-40000000;
				player setVariable ["brpvp_max_in_bank",BRPVP_totalMoneyInBank,true];
			}
		]
	],
	[
		format [localize "str_xp_perks_bank_limit",60],
		925000,
		{
			BRPVP_totalMoneyInBank = BRPVP_totalMoneyInBank+60000000;
			player setVariable ["brpvp_max_in_bank",BRPVP_totalMoneyInBank,true];
		},
		true,
		38,
		[250000,[37]],
		[9,2],
		[
			true,
			{
				BRPVP_totalMoneyInBank = BRPVP_totalMoneyInBank-60000000;
				player setVariable ["brpvp_max_in_bank",BRPVP_totalMoneyInBank,true];
			}
		]
	],
	//FASTER DUKE NUKEM SERVICE
	[
		localize "str_xp_less_dnukem_delay_50",
		250000,
		{BRPVP_dukeNukemServiceDelay = BRPVP_dukeNukemServiceDelayCfg*0.5;},
		true,
		46,
		[250000,[]],
		[10,1],
		[true,{BRPVP_dukeNukemServiceDelay = BRPVP_dukeNukemServiceDelayCfg;}]
	],
	[
		localize "str_xp_less_dnukem_delay_25",
		500000,
		{BRPVP_dukeNukemServiceDelay = BRPVP_dukeNukemServiceDelayCfg*0.5*0.5;},
		true,
		47,
		[500000,[46]],
		[10,2],
		[true,{BRPVP_allowLandAutoPilot = BRPVP_allowLandAutoPilotCfg*0.5;}]
	],
	//AURA ILLUMINATION
	[
		localize "str_xp_aura_light_lvl1",
		300000,
		{[300,200] call BRPVP_auraCreateLights;},
		true,
		48,
		[250000,[]],
		[11,1],
		[true,{[0,0] call BRPVP_auraCreateLights;}]
	],
	[
		localize "str_xp_aura_light_lvl2",
		600000,
		{[1500,1000] call BRPVP_auraCreateLights;},
		true,
		49,
		[500000,[48]],
		[11,2],
		[true,{[600,400] call BRPVP_auraCreateLights;}]
	],
	//SUPER AUTOMATIC RUN
	[
		format [localize "str_xp_super_auto_run",1],
		250000,
		{BRPVP_superRunSpeed = BRPVP_superRunSpeedsArray select 2;BRPVP_superRunSpeedSelected = BRPVP_superRunSpeed;},
		true,
		56,
		[0,[]],
		[12,1],
		[true,{
			BRPVP_superRunSpeed = BRPVP_superRunSpeedsArray select 1;
			if (BRPVP_superRunSpeedSelected > BRPVP_superRunSpeed) then {BRPVP_superRunSpeedSelected = BRPVP_superRunSpeed;};
		}]
	],
	[
		format [localize "str_xp_super_auto_run",2],
		500000,
		{BRPVP_superRunSpeed = BRPVP_superRunSpeedsArray select 3;BRPVP_superRunSpeedSelected = BRPVP_superRunSpeed;},
		true,
		57,
		[0,[56]],
		[12,2],
		[true,{
			BRPVP_superRunSpeed = BRPVP_superRunSpeedsArray select 2;
			if (BRPVP_superRunSpeedSelected > BRPVP_superRunSpeed) then {BRPVP_superRunSpeedSelected = BRPVP_superRunSpeed;};
		}]
	],
	[
		format [localize "str_xp_super_auto_run",3],
		750000,
		{BRPVP_superRunSpeed = BRPVP_superRunSpeedsArray select 5;BRPVP_superRunSpeedSelected = BRPVP_superRunSpeed;},
		true,
		58,
		[0,[56,57]],
		[12,3],
		[true,{
			BRPVP_superRunSpeed = BRPVP_superRunSpeedsArray select 3;
			if (BRPVP_superRunSpeedSelected > BRPVP_superRunSpeed) then {BRPVP_superRunSpeedSelected = BRPVP_superRunSpeed;};
		}]
	],
	//SIXTH SENSE
	[
		format [localize "str_xp_perks_sixth_sense",1],
		400000,
		{BRPVP_sixthSenseOn = true;},
		true,
		61,
		[1000000,[]],
		[13,1],
		[true,{BRPVP_sixthSenseOn = false;}]
	],
	[
		format [localize "str_xp_perks_sixth_sense",2],
		700000,
		{
			BRPVP_sixthSensePower = BRPVP_sixthSensePower*10;
			BRPVP_sixthSenseRange = 300;
		},
		true,
		62,
		[2000000,[61]],
		[13,2],
		[true,{
			BRPVP_sixthSensePower = BRPVP_sixthSensePower/10;
			BRPVP_sixthSenseRange = 200;
		}]
	],
	[
		format [localize "str_xp_perks_sixth_sense",3],
		1000000,
		{
			BRPVP_sixthSenseSeePlayer = true;
			BRPVP_sixthSenseRange = 400;
		},
		true,
		63,
		[4000000,[61,62]],
		[13,3],
		[true,{
			BRPVP_sixthSenseSeePlayer = false;
			BRPVP_sixthSenseRange = 300;
		}]
	],
	//NITRO FLY
	[
		format [localize "str_xp_nitro_fly_lvl",1],
		300000,
		{BRPVP_nitroFlyFeatureOn = true;},
		true,
		64,
		[250000,[]],
		[14,1],
		[true,{BRPVP_nitroFlyFeatureOn = false;}]
	],
	[
		format [localize "str_xp_nitro_fly_lvl",2],
		600000,
		{BRPVP_nitroFlyCruiseTime = 10;BRPVP_nitroFlyCoolDown = 5;},
		true,
		65,
		[750000,[64]],
		[14,2],
		[true,{BRPVP_nitroFlyCruiseTime = 2;BRPVP_nitroFlyCoolDown = 10;}]
	],
	[
		format [localize "str_xp_nitro_fly_lvl",3],
		900000,
		{BRPVP_nitroFlyCruiseTime = 20;BRPVP_nitroFlyCoolDown = 0;},
		true,
		66,
		[1500000,[64,65]],
		[14,3],
		[true,{BRPVP_nitroFlyCruiseTime = 10;BRPVP_nitroFlyCoolDown = 5;}]
	],
	//FRANTA DISARM HELP
	[
		(localize "str_xp_perks_franta_alert")+" LVL 1",
		1000000,
		{BRPVP_fradeOn = true;BRPVP_fradeDistance = 11;},
		true,
		55,
		[2000000,[]],
		[15,1],
		[true,{BRPVP_fradeOn = false;BRPVP_fradeDistance = 4;}]
	],
	[
		(localize "str_xp_perks_franta_alert")+" LVL 2",
		1500000,
		{BRPVP_fradeBigOn = true;BRPVP_fradeDistance = 16;},
		true,
		71,
		[3000000,[55]],
		[15,1],
		[true,{BRPVP_fradeBigOn = false;BRPVP_fradeDistance = 11;}]
	],
	//VOODOO RESISTENCE
	[
		localize "str_xp_perks_voodoo_resistence",
		500000,
		{BRPVP_voodooMinEffectTime = (BRPVP_voodooMinEffectTime max 30)/3;},
		true,
		77,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_voodooMinEffectTime = BRPVP_voodooMinEffectTime*3;}]
	],
	[
		localize "str_xp_perks_fast_sabotage_fix",
		500000,
		{
			BRPVP_vehSabotageFixChanceEachTry = BRPVP_vehSabotageFixChanceEachTry+0.1;
			BRPVP_vehSabotageFixMaxTries = BRPVP_vehSabotageFixMaxTries-5;
		},
		true,
		76,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[
			true,
			{
				BRPVP_vehSabotageFixChanceEachTry = BRPVP_vehSabotageFixChanceEachTry-0.1;
				BRPVP_vehSabotageFixMaxTries = BRPVP_vehSabotageFixMaxTries+5;
			}
		]
	],
	[
		localize "str_xp_perks_weather_predict",
		300000,
		{BRPVP_weatherPredict = true;},
		true,
		72,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_weatherPredict = false;}]
	],
	[
		localize "str_xp_perks_better_magnet",
		500000,
		{BRPVP_magnetBetterAttraction = true;},
		true,
		73,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_magnetBetterAttraction = false;}]
	],
	[
		localize "str_aopen_door_perk",
		250000,
		{BRPVP_autoOpenDoorPerk = true;},
		true,
		75,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_autoOpenDoorPerk = false;}]
	],
	[
		format [localize "str_xp_perks_bigger_map_circle","+25%"],
		350000,
		{
			BRPVP_mapVisibleCircleSizeMultiplier = BRPVP_mapVisibleCircleSizeMultiplier*1.25;
			BRPVP_mapVisibleRadiusCfg = BRPVP_mapVisibleCircleSizeMultiplier*((BRPVP_mapaDimensoes select 0) max (BRPVP_mapaDimensoes select 1))/(2*2.5);
			BRPVP_mapVisibleRadiusGlow = BRPVP_mapVisibleRadiusCfg*0.02;
			BRPVP_mapVisibleRadius = BRPVP_mapVisibleRadiusCfg;
		},
		true,
		67,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{
			BRPVP_mapVisibleCircleSizeMultiplier = BRPVP_mapVisibleCircleSizeMultiplier/1.25;
			BRPVP_mapVisibleRadiusCfg = BRPVP_mapVisibleCircleSizeMultiplier*((BRPVP_mapaDimensoes select 0) max (BRPVP_mapaDimensoes select 1))/(2*2.5);
			BRPVP_mapVisibleRadiusGlow = BRPVP_mapVisibleRadiusCfg*0.02;
			BRPVP_mapVisibleRadius = BRPVP_mapVisibleRadiusCfg;
		}]
	],
	[
		localize "str_xp_perks_parachute_anywhere",
		800000,
		{BRPVP_minHeightParachuteOpenUse = BRPVP_minHeightParachuteOpenPerk;},
		true,
		69,
		[1000000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_minHeightParachuteOpenUse = BRPVP_minHeightParachuteOpenNormal;}]
	],
	[
		localize "str_xp_perks_double_smoke",
		800000,
		{BRPVP_doubleSmokeOn = true;},
		true,
		70,
		[2000000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_doubleSmokeOn = false;}]
	],
	[
		localize "str_xp_perks_better_sky_dive",
		750000,
		{
			BRPVP_skyDiveVelocity = [0.025*1.05*1.125,-0.004/(1.05*1.125)];
			BRPVP_skyDiveUp = [0.00725*1.05*1.125,0.01925*1.05*1.125];
			BRPVP_skyDiveMaxFlyTime = BRPVP_skyDiveMaxFlyTimeLevels select 1;
		},
		true,
		59,
		[1000000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{
			BRPVP_skyDiveVelocity = [0.025*1.05,-0.004/1.05];
			BRPVP_skyDiveUp = [0.00725*1.05,0.01925*1.05];
			BRPVP_skyDiveMaxFlyTime = BRPVP_skyDiveMaxFlyTimeLevels select 0;
		}]
	],
	[
		localize "str_xp_perks_autolanding",
		1000000,
		{BRPVP_allowLandAutoPilot = true;},
		true,
		45,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_allowLandAutoPilot = BRPVP_allowLandAutoPilotCfg;}]
	],
	[
		localize "str_xp_perks_no_atm_rate",
		500000,
		{BRPVP_personalAtmRate = 0;},
		true,
		44,
		[200000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_personalAtmRate = BRPVP_personalAtmRateCfg;}]
	],
	[
		localize "str_xp_perks_faster_master_key",
		800000,
		{
			BRPVP_specialItemsRemoveTime set [36,[1]];
			BRPVP_specialItemsRemoveTime set [37,[2]];
			BRPVP_specialItemsRemoveTime set [38,[3]];
		},
		true,
		43,
		[300000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{
			BRPVP_specialItemsRemoveTime set [36,[3]];
			BRPVP_specialItemsRemoveTime set [37,[4]];
			BRPVP_specialItemsRemoveTime set [38,[5]];
		}]
	],
	[
		localize "str_xp_perks_sell_25",
		800000,
		{BRPVP_sellPricesMultiplier = BRPVP_sellPricesMultiplier*1.25;},
		true,
		42,
		[300000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_sellPricesMultiplier = BRPVP_sellPricesMultiplier/1.25;}]
	],
	[
		localize "str_xp_perks_see_ai",
		900000,
		{BRPVP_perkSeeAllAI = true;},
		true,
		12,
		[1000000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_perkSeeAllAI = false;}]
	],
	[
		localize "str_xp_perks_radio",
		750000,
		{BRPVP_xpRadioProtection = 0.4;},
		true,
		13,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_xpRadioProtection = 1;}]
	],
	[
		format [localize "str_menu30_ammo_repack",4], //REPACK AMMO
		125000,
		{BRPVP_xpRepackAmmoOk = true;},
		true,
		15,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_xpRepackAmmoOk = false;}]
	],
	[
		localize "str_xp_perks_half_bus", //50% BUS TICKET
		25000,
		{BRPVP_xpBusPriceMult = 0.5;},
		true,
		16,
		[0,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_xpBusPriceMult = 1;}]
	],
	[
		localize "str_xp_perks_arty_range", //ARTY RANGE
		775000,
		{
			private _fei = -1;
			BRPVP_artilleryLimit set [1,(BRPVP_artilleryLimit select 1) apply {_fei = _fei+1;_x+(BRPVP_artilleryLimit select 2 select _fei)}];
		},
		true,
		17,
		[1250000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[
			true,
			{
				private _fei = -1;
				BRPVP_artilleryLimit set [1,(BRPVP_artilleryLimit select 1) apply {_fei = _fei+1;_x-(BRPVP_artilleryLimit select 2 select _fei)}];
			}
		]		
	],
	[
		localize "str_xp_perks_half_farm_time", //FARM AND CRAFT TIMES
		475000,
		{BRPVP_farmAndCraftTime = BRPVP_farmAndCraftTime*0.5;},
		true,
		18,
		[250000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_farmAndCraftTime = BRPVP_farmAndCraftTime/0.5;}]
	],
	[
		localize "str_xp_perks_less_fuel_consume", //LESS FUEL CONSUME
		450000,
		{BRPVP_extraFuelConsume = BRPVP_extraFuelConsume apply {_x*1.5};},
		true,
		19,
		[150000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_extraFuelConsume = BRPVP_extraFuelConsume apply {_x/1.5};}]
	],
	[
		localize "str_xp_perks_shield", //STRONGER PERSONAL SHIELD
		625000,
		{BRPVP_personalShieldLife = 10;},
		true,
		20,
		[350000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_personalShieldLife = 1;}]
	],
	[
		format [localize "str_xp_perks_rise_spot_limit","+5.0KK"],
		800000,
		{BRPVP_moneyOnHandToSpot = BRPVP_moneyOnHandToSpot+5000000;},
		true,
		50,
		[500000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_moneyOnHandToSpot = BRPVP_moneyOnHandToSpot-5000000;}]
	],
	[
		format [localize "str_xp_perks_air_veh_resistence",BRPVP_airVehLifeMultPerk],
		800000,
		{
			BRPVP_airVehicleResistence = BRPVP_airVehicleResistence*BRPVP_airVehLifeMultPerk;
			BRPVP_airVehicleResistenceCollision = BRPVP_airVehicleResistenceCollision*BRPVP_airVehLifeMultPerkCollision;
		},
		true,
		51,
		[500000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{
			BRPVP_airVehicleResistence = BRPVP_airVehicleResistence/BRPVP_airVehLifeMultPerk;
			BRPVP_airVehicleResistenceCollision = BRPVP_airVehicleResistenceCollision/BRPVP_airVehLifeMultPerkCollision;
		}]
	],
	[
		localize "str_xp_perks_see_zombies",
		900000,
		{BRPVP_zedsMapViewDistance = 1000000;},
		true,
		52,
		[1000000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_zedsMapViewDistance = BRPVP_zedsMapViewDistanceCfg;}]
	],
	[
		localize "str_xp_perks_double_farm",
		475000,
		{BRPVP_farmDoubleChance = 0.35;},
		true,
		53,
		[500000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_farmDoubleChance = 0;}]
	],
	[
		localize "str_xp_perks_ufast_descent",
		500000,
		{BRPVP_ubberFastDescent = true;},
		true,
		54,
		[200000,[]],
		[BRPVP_xpPerksIndividualOrder,1],
		[true,{BRPVP_ubberFastDescent = false;}]
	],
	[
		"100% XP TO ALL",
		0,
		{},
		false,
		39,
		[0,[]],
		[999,1],
		[true,{}]
	]
];
private _historicalMaxXp = 5000000;
private _multMinLim = BRPVP_xpToBuyAllPerks/_historicalMaxXp;
BRPVP_xpPerks = BRPVP_xpPerks apply {
	private _step = 25000 min _historicalMaxXp;
	private _val = (_x select 5 select 0) min _historicalMaxXp;
	private _minLim = (round(_val*_multMinLim/_step))*_step;
	[
		_x select 0,
		_x select 1,
		_x select 2,
		_x select 3,
		_x select 4,
		[_minLim,_x select 5 select 1],
		_x select 6,
		_x select 7		
	]
};
{
	_x params ["_id","_state"];
	{if (_x select 4 isEqualTo _id) then {_x set [3,_state];};} forEach BRPVP_xpPerks;
} forEach BRPVP_habilitiesState;
private _totalCost = 0;
{_totalCost = _totalCost+(_x select 1);} forEach BRPVP_xpPerks;
BRPVP_xpToBuyAllPerks = BRPVP_xpPriceStep*round (BRPVP_xpToBuyAllPerks/BRPVP_xpPriceStep);
private _pcMult = BRPVP_xpToBuyAllPerks/_totalCost;
{
	private _nValor = if (_x select 1 isEqualTo 0) then {0} else {BRPVP_xpPriceStep*(round ((_x select 1)*_pcMult/BRPVP_xpPriceStep) max 1)};
	BRPVP_xpPerks select _forEachIndex set [1,_nValor];
} forEach BRPVP_xpPerks;
private _totalCost = 0;
{_totalCost = _totalCost+(_x select 1);} forEach BRPVP_xpPerks;
_diffQ = (_totalCost-BRPVP_xpToBuyAllPerks)/BRPVP_xpPriceStep;
_diffQAbs = abs(_diffQ);
_diffQSignal = if (BRPVP_xpToBuyAllPerks > _totalCost) then {-1} else {1};
BRPVP_xpPerks = BRPVP_xpPerks apply {[_x select 1,_x]};
BRPVP_xpPerks sort false;
BRPVP_xpPerks = BRPVP_xpPerks apply {_x select 1};
for "_i" from 0 to (_diffQAbs-1) do {BRPVP_xpPerks select _i set [1,(BRPVP_xpPerks select _i select 1)-_diffQSignal*BRPVP_xpPriceStep];};
private _totalCost = 0;
{_totalCost = _totalCost+(_x select 1);} forEach BRPVP_xpPerks;
BRPVP_xpToBuyAllPerks = _totalCost;
BRPVP_xpPerks = BRPVP_xpPerks apply {(_x select 6)+[_x select 1]+[_x]};
BRPVP_xpPerks sort true;
BRPVP_xpPerks = BRPVP_xpPerks apply {_x select 3};
BRPVP_xpCalc = {
	private _p = _this;
	private _isAdmin = ((_p isEqualTo player && (_p getVariable ["brpvp_player_mode",""]) isEqualTo "admin") && BRPVP_adminsStartsWithAllPerks) || BRPVP_allXpOn;
	private _exp = _p getVariable ["exp",BRPVP_experienciaZerada];
	private _xpSpecial = [
		[
			localize "str_explist_admin_xp", //ADMIN XP
			(_exp select 27)/BRPVP_xpToBuyAllPerks min 1,
			BRPVP_xpToBuyAllPerks,
			BRPVP_xpToBuyAllPerks,
			_exp select 27,
			1
		],
		[
			localize "str_explist_double_xp", //DOUBLE XP
			(_exp select 25)/BRPVP_xpToBuyAllPerks min 1,
			BRPVP_xpToBuyAllPerks,
			BRPVP_xpToBuyAllPerks,
			_exp select 25,
			1
		]
	];
	private _xpArray = [
		[
			localize "str_explist_2", //AI KILLED
			-1,
			100000,
			BRPVP_xpLimits select 0,
			_exp select 2,
			1
		],
		[
			localize "str_explist_turrets", //TURRETS KILLED
			-1,
			100000,
			BRPVP_xpLimits select 19,
			_exp select 28,
			1
		],
		[
			localize "str_explist_0", //PLAYERS KILLED
			-1,
			100000,
			BRPVP_xpLimits select 1,
			_exp select 0,
			1
		],
		[
			localize "str_explist_10", //CONSTRUCTION
			-1,
			100000,
			BRPVP_xpLimits select 6,
			_exp select 10,
			1
		],
		[
			localize "str_farm_craft", //FARM AND CRAFT
			-1,
			50000,
			BRPVP_xpLimits select 5,
			_exp select 17,
			1
		],
		[
			localize "str_mounted_kills", //MOUNTED KILLS
			-1,
			50000,
			BRPVP_xpLimits select 9,
			_exp select 18,
			1
		],
		[
			localize "str_exp_zumbi", //ZEDS KILLED
			-1,
			50000,
			BRPVP_xpLimits select 7,
			_exp select 14,
			1
		],
		[
			localize "str_exp_vendeu", //VALUE SOLD
			-1,
			50000,
			BRPVP_xpLimits select 3,
			_exp select 16,
			1
		],
		[
			localize "str_exp_comprou", //VALUE PURCHASED
			-1,
			50000,
			BRPVP_xpLimits select 2,
			_exp select 15,
			1
		],
		[
			localize "str_exp_headshots", //HEAD SHOTS
			-1,
			50000,
			BRPVP_xpLimits select 8,
			(_exp select 7)+(_exp select 9),
			1
		],
		[
			localize "str_radio_man", //RADIOACTIVE
			-1,
			50000,
			BRPVP_xpLimits select 12,
			_exp select 19,
			1
		],
		[
			localize "str_suitcase", //SUITCASE GET
			-1,
			25000,
			BRPVP_xpLimits select 13,
			_exp select 20,
			1
		],
		[
			localize "str_perk_cure_and_repair", //CURE AND REPAIR
			-1,
			25000,
			BRPVP_xpLimits select 20,
			_exp select 29,
			1
		],
		[
			localize "str_explist_4", //WALK
			-1,
			25000,
			BRPVP_xpLimits select 10,
			_exp select 4,
			1
		],
		[
			localize "str_explist_5", //FOOD USE
			-1,
			25000,
			BRPVP_xpLimits select 11,
			_exp select 5,
			1
		],
		[
			localize "str_played_days", //DAYS YOU LOGGED
			-1,
			25000,
			BRPVP_xpLimits select 4,
			_p getVariable ["brpvp_days_played",1],
			1
		],
		[
			localize "str_xp_hours_played", //PLAYED HOURS
			-1,
			25000,
			BRPVP_xpLimits select 18,
			_exp select 26,
			10
		],
		[
			localize "str_xp_veh_landvehicle", //LAND VEHICLE
			-1,
			20000,
			BRPVP_xpLimits select 14,
			_exp select 21,
			1
		],
		[
			localize "str_xp_veh_helicopter", //HELICOPTER
			-1,
			20000,
			BRPVP_xpLimits select 15,
			_exp select 22,
			1
		],
		[
			localize "str_xp_veh_plane", //PLANE
			-1,
			20000,
			BRPVP_xpLimits select 16,
			_exp select 23,
			1
		],
		[
			localize "str_xp_veh_ship", //SHIP
			-1,
			20000,
			BRPVP_xpLimits select 17,
			_exp select 24,
			1
		],
		[
			localize "str_xp_atomic_bomb", //ATOMIC BOMB
			-1,
			20000,
			BRPVP_xpLimits select 21,
			_exp select 30,
			1
		]
	];
	private _totalXpCan = 0;
	{_totalXpCan = _totalXpCan+(_x select 2);} forEach _xpArray;
	private _xpCanMult = BRPVP_xpToBuyAllPerks/_totalXpCan;
	{
		_xpArray select _forEachIndex set [2,(_x select 2)*_xpCanMult];
		_xpArray select _forEachIndex set [3,(_x select 3)*_xpCanMult];
		_xpArray select _forEachIndex set [1,(_x select 4)/(_x select 3) min 1];
	} forEach _xpArray;
	
	_xpArray = if (_isAdmin) then {
		(_xpSpecial+_xpArray) apply {[_x select 0,1,_x select 2,_x select 2,_x select 3,(round ((_x select 4)*(_x select 5)))/(_x select 5)]}
	} else {
		(_xpSpecial+_xpArray) apply {[_x select 0,_x select 1,round ((_x select 2)*(_x select 1)),_x select 2,_x select 3,(round ((_x select 4)*(_x select 5)))/(_x select 5)]}
	};
	private _sum = 0;
	{_sum = _sum+(_x select 2);} forEach _xpArray;
	[_sum,_xpArray]
};
BRPVP_xpSetPerksOnStart = {
	{if (_x select 4 isEqualTo 39) exitWith {BRPVP_allXpOn = _x select 3;};} forEach BRPVP_xpPerks;
	private _isAdmin = (player getVariable ["brpvp_player_mode",""]) isEqualTo "admin" && BRPVP_adminsStartsWithAllPerks;
	private _xpData = player call BRPVP_xpCalc;
	_xpData params ["_xpTotal","_xpArray"];
	private _activePerks = player getVariable ["brpvp_active_perks",[]];
	_xpConsumed = 0;
	{
		if ((_x select 4 in _activePerks || BRPVP_allXpOn || _isAdmin) && _x select 3) then {
			call (_x select 2);
			_xpConsumed = _xpConsumed+(_x select 1);
			_activePerks pushBackUnique (_x select 4);
		};
	} forEach BRPVP_xpPerks;
	if (BRPVP_allXpOn || _isAdmin) then {player setVariable ["brpvp_active_perks",_activePerks,true];};
	BRPVP_xpLastTotal = _xpTotal;
	BRPVP_xpConsumed = _xpConsumed;
};
BRPVP_xpSetPerksAfterExp = {
	private _isADM = _this;
	private _xpData = player call BRPVP_xpCalc;
	_xpData params ["_xpTotal","_xpArray"];
	if (BRPVP_xpIsDoubleDay && !_isADM) then {
		private _delta = _xpTotal-BRPVP_xpLastTotal;
		_xpTotal = _xpTotal+_delta;
		[["double",_delta]] call BRPVP_mudaExp;
	};
	if (player getVariable ["brpvp_is_newer",false] && _xpTotal > BRPVP_newerXPToLeave) then {player setVariable ["brpvp_is_newer",false,true]};
	BRPVP_xpLastTotal = _xpTotal;
};

//ACTIVATE PERKS
BRPVP_xpAddTraderITems = {
	{
		_x params ["_i1","_i2","_tn"];
		(BRPVP_mercadoNomesNomesFilter select _i1 select _i2) pushBackUnique _tn;
	} forEach _this;
};
BRPVP_xpAddTraderITemsRemove = {
	{
		_x params ["_i1","_i2","_tn"];
		(BRPVP_mercadoNomesNomesFilter select _i1 select _i2) deleteAt ((BRPVP_mercadoNomesNomesFilter select _i1 select _i2) find _tn);
	} forEach _this;
};
BRPVP_addVgSlots = {
	{
		_x params ["_idx","_add"];
		BRPVP_virtualGarageLimit select _idx set [2,(BRPVP_virtualGarageLimit select _idx select 2)+_add];
	} forEach _this;
};
BRPVP_auraScriptHandle = scriptNull;
BRPVP_auraCreateLights = {
	BRPVP_auraConfig = _this;
	terminate BRPVP_auraScriptHandle;
	deleteVehicle BRPVP_auraLight;
	deleteVehicle BRPVP_auraFlare;
	if (_this isNotEqualTo [0,0]) then {
		BRPVP_auraScriptHandle = _this spawn {
			params ["_start","_pulseMax"];
			private _light = "#lightpoint" createVehicleLocal [0,0,0];
			private _pulseTime = 2;
			private _pulseAngle = 0;
			//CREATE LIGHT
			_light setLightColor [1,1,1];
			_light setLightAmbient [1,1,1];
			_light setLightUseFlare false;
			_light setLightIntensity 15;
			_light setLightDayLight true;
			_light setLightAttenuation [_start,0,0.01,0];
			BRPVP_auraLight = _light;
			//MAKE LIGHT PULSE
			private _lastVeh = [objectParent player,BRPVP_myUAVNow] select isNull objectParent player;
			private _lastSpec = BRPVP_spectateOn;
			if (isNull _lastVeh) then {_light attachTo [player,[0,0,2.5]];} else {_light attachTo [_lastVeh,[0,0,2+2.5]];};
			_lastVeh = str _lastVeh;
			waitUntil {
				private _veh = [objectParent player,BRPVP_myUAVNow] select isNull objectParent player;
				if (str _veh isNotEqualTo _lastVeh) then {
					if (isNull _veh) then {_light attachTo [player,[0,0,2.5]];} else {_light attachTo [_veh,[0,0,2+2.5]];};
					_lastVeh = str _veh;
				};
				if (BRPVP_spectateOn isNotEqualTo _lastSpec) then {
					_lastSpec = BRPVP_spectateOn;
					if (BRPVP_spectateOn) then {
						_start = 0;
						_pulseMax = 0;
						_light setLightIntensity 0;
					} else {
						_start = _this select 0;
						_pulseMax = _this select 1;
						_light setLightIntensity 15;
					};
				};
				private _dDamMult = 1-(((BRPVP_disabledDamage min 0.5)*2) max BRPVP_playerDamageForCalc)^(1/3);
				private _stepAngle = 360*(1/diag_fps)/_pulseTime;
				_pulseAngle = (_pulseAngle+_stepAngle) mod 360;
				_light setLightAttenuation [_start*_dDamMult+sin(_pulseAngle)*_pulseMax*_dDamMult/2+_pulseMax*_dDamMult/2,0,0.01,0];
				false
			};
		};
	};
};