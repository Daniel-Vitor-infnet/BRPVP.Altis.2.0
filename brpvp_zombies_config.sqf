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

BRPVP_defaultZombieStyle = [0];

BRPVP_extraJumpPlayer = [0,0,0,0,0,0,0,0,0,1];
BRPVP_extraJumpPlayerAi = [0,0,0,0,0,0,0,0,1,2];

BRPVP_noZombiesDays = []; //WEEK DAYS FROM 0 TO 6: 0 IS SUNDAY, 6 IS SATURDAY

BRPVP_applyForceSize = 800;
BRPVP_zedsMapViewDistanceCfg = 250;
BRPVP_zombiesClasses = [
	"C_man_p_shorts_1_F_afro",
	"C_man_p_shorts_1_F_euro",
	"C_man_p_shorts_1_F_asia"
];
BRPVP_zombieMotherClass = "C_man_p_shorts_1_F";
BRPVP_zombiesUniforms = [
	"U_IG_Guerilla2_1",
	"U_IG_Guerilla2_2",
	"U_IG_Guerilla2_3",
	"U_IG_Guerilla3_1",
	"U_IG_Guerilla3_2",
	"U_IG_leader",
	"U_BG_Guerilla1_1",
	"U_I_G_resistanceLeader_F",
	"U_B_survival_uniform",
	"U_B_CTRG_2",
	"U_I_OfficerUniform",
	"U_I_CombatUniform_shortsleeve",
	"U_I_pilotCoveralls",
	"U_B_CTRG_3",
	"U_OrestesBody",
	"U_I_Wetsuit",
	"U_C_Poor_1",
	"U_NikosAgedBody",
	"U_C_HunterBody_grn",
	"U_C_WorkerCoveralls",
	"U_B_GhillieSuit",
	//CUP ZOMBIES
	"CUP_U_C_Labcoat_03",
	"CUP_U_C_Tracksuit_04",
	"CUP_U_C_Citizen_03",
	"CUP_U_C_Labcoat_01",
	"CUP_U_C_Suit_01",
	"CUP_U_C_Mechanic_01",
	"CUP_U_C_Priest_01",
	"CUP_U_C_racketeer_01",
	"CUP_U_C_Rocker_01",
	["CUP_C_C_Policeman_01","CUP_U_C_Policeman_01","CUP_H_C_Policecap_01"],
	["CUP_C_C_Fireman_01","CUP_U_C_Fireman_01","CUP_H_C_Fireman_Helmet_01"],
	["CUP_C_C_Villager_01","CUP_U_C_Villager_01","CUP_H_C_Beret_01"],
	["CUP_C_C_Woodlander_02","CUP_U_C_Woodlander_02","CUP_H_C_Ushanka_02"],
	["CUP_C_C_Worker_03","CUP_U_C_Worker_03","CUP_H_C_Beanie_03"],
	["CUP_C_TK_Man_04","CUP_O_TKI_Khet_Partug_04","CUP_H_TKI_Lungee_Open_02"],
	["CUP_C_TK_Man_04_Jack","CUP_O_TKI_Khet_Partug_04","CUP_H_TKI_Lungee_Open_02"],
	["CUP_C_TK_Man_06_Coat","CUP_O_TKI_Khet_Partug_06","CUP_H_TKI_Pakol_1_01"],
	["CUP_C_TK_Man_02","CUP_O_TKI_Khet_Partug_02","CUP_H_TKI_SkullCap_01"],
	["CUP_C_TK_Man_06_Waist","CUP_O_TKI_Khet_Partug_06","CUP_H_TKI_SkullCap_01"]
];

//PERCENTAGE OF ZOMBIES ATTACKING PLAYERS HOSTED ON SERVER, FROM 0 TO 1
//ZOMBIES ATTACKING AI UNITS ARE ALLWAYS HOSTED ON SERVER
BRPVP_zombiePercOnServer = 0;

BRPVP_zombiesCaughByCarChanceToExplode = 0.35;
BRPVP_zombiesResistence = 2.5; //DEFAULT IS 2.5
BRPVP_zombiesExplosionDamageAttenuation = 1; //2 DOUBLES THE ATTENUATION, CAN'T BE ZERO BUT CAN BE 0.4, 0.5, ETC
BRPVP_zombiesJumpOverHouseWithPlayerPercentage = 0.5;

//ZOMBIE ITEMS LOOT
BRPVP_zombieGiveItemsItems = [
	[0.125/1.5,["SmokeShellOrange"],[1,1,1,1,2]],
	[0.080/1.5,["FirstAidKit"],[1,1,1,1,2]],
	[0.050/1.5,["C_Bergen_blu","C_Bergen_blu","B_Carryall_oli"],[1]],
	[0,050/1.5,["ItemWatch","ItemCompass","ItemGPS","Rangefinder","H_Shemag_olive"],[1]]
];

//JUMPING ZOMBIES
BRPVP_kneelingJumpZombiesPercentage = 0.25;
BRPVP_percentageOfJumpWhenHit = 0.35;

//MOBIUS ZOMBIES
BRPVP_mobiusZombiesPercentage = 0.025; //DEFAULT: 25 IN EACH 1000 ZOMBIES ARE MOBIUS
BRPVP_mobiusZombiesLife = 15;
BRPVP_mobiusZombiesAmmoRepeat = 20;

BRPVP_zombieKillRewardBase = 10; //ESSA É A RECOMPENSA BÁSICA (PARA ZUMBIS DE NÍVEL 1). REWARD = ZOMBIE LEVEL * BRPVP_zombieKillRewardBase.

//ZUMBIS MÁXIMOS AO REDOR
BRPVP_zombieMaxLocalPerPlayer = 5; // Zumbie Máximo local por jogador
BRPVP_zombieMaxLocal = 15; // Zumbie Max Local

//DISTRAÇÃO DE ZUMBIS
BRPVP_zombieDistanceFromSmokeToCatchAttention = 50;
BRPVP_zombieDistractAmmo = [
	//SLUG
	"G_40mm_Smoke",
	"G_40mm_SmokeRed",
	"G_40mm_SmokeGreen",
	"G_40mm_SmokeYellow",
	"G_40mm_SmokePurple",
	"G_40mm_SmokeBlue",
	"G_40mm_SmokeOrange",
	//SMOKE
	"SmokeShell",
	"SmokeShellRed",
	"SmokeShellGreen",
	"SmokeShellYellow",
	"SmokeShellPurple",
	"SmokeShellBlue",
	"SmokeShellOrange",
	//GRENADE
	"GrenadeHand",
	"mini_Grenade",
	//AP MINES
	"APERSMine_Range_Ammo",
	"APERSBoundingMine_Range_Ammo",
	//"SLAMDirectionalMine_Wire_Ammo",
	"APERSTripMine_Wire_Ammo",
	"ClaymoreDirectionalMine_Remote_Ammo",
	//CHARGES
	"SatchelCharge_Remote_Ammo",
	"DemoCharge_Remote_Ammo"
];
BRPVP_maxZombiesPerSmokeShell = [/*SLUG*/10,10,10,10,10,10,10,/*SMOKE*/10,10,10,10,10,10,10,/*GRENADE*/10,10,/*AP MINES*/10,10,10,10,/*CHARGES*/20,20];
BRPVP_maxZombiesPerSmokeShellUniqueMult = 2; //UNIQUE ZOMBIES CATCH BY SMOKE IS: BRPVP_maxZombiesPerSmokeShell * BRPVP_maxZombiesPerSmokeShellUniqueMult

//ZOMBIE SPAWN
BRPVP_zombieFactorLimit = 25;
BRPVP_zombieCoolDown = 600;
BRPVP_zombieSpawnTemplate = [
	[2,[1,2]],
	[3,[1,2]],
	[3,[1,2]],
	[4,[1,2]]
];

//SUPER SPAWN ZOMBIES CONFIG
BRPVP_zombieNumberOfSuperSpawnCities = 2; //NUMBER OF INFECTED CITIES
BRPVP_defaultZombieStyleB = [0,0,1,1,1,2,2,2,2];
BRPVP_kneelingJumpZombiesPercentageB = 0.3;
BRPVP_percentageOfJumpWhenHitB = 0.5;
BRPVP_zombieKillRewardBaseB = 1500;
BRPVP_zombieMaxLocalPerPlayerB = 10;
BRPVP_zombieMaxLocalB = 25;
BRPVP_zombieFactorLimitB = 2;
BRPVP_zombieCoolDownB = 5;
BRPVP_zombieSpawnTemplateB = [
	[3,[5]],
	[4,[5]],
	[5,[5]]
];

//RYAN ZONBIES CONFIGURATION (IF YOU IS USING ZOMBIES AND DEMONS MOD)
BRPVP_rZedsCfgLastSpawnTime = diag_tickTime;
BRPVP_rZedsCfgCoolDown = 250;
BRPVP_rZedsCfgCoolDownIfFail = 60;
BRPVP_rZedsCfgCoolDownArray = [900,1200,1500];
BRPVP_rZedsCfgNoCombatTime = 300;
BRPVP_rZedsCfgBoneBreakSounds = ["bone_break_1","bone_break_2","bone_break_3","bone_break_4","bone_break_5","bone_break_6","bone_break_7","bone_break_8","bone_break_9","bone_break_10"];
BRPVP_rZedsCfgMaxHousesArround = 4;
BRPVP_rZedsCfgMaxHousesArroundDist = 200;
BRPVP_rZedsCfgDirtCheckDistance = 200;
BRPVP_rZedsCfgDirtCheckStep = 25;
BRPVP_rZedsCfgDirtCheckPercentage = 0.8;
BRPVP_rZedsCfgKillReward = 35000;

//SPAWN ZOMBIES ITEM
BRPVP_spawnZombiesItemOnPve = true;
BRPVP_spawnZombiesItemCoolDown = 10; //SECONDS
BRPVP_spawnZombiesItemMaxNearZombies = 50;

//================================================
//= DON'T CHANGE THE CODE BELLOW
//================================================

BRPVP_rZedsCfgBoneBreakSeq = BRPVP_rZedsCfgBoneBreakSounds call BIS_fnc_arrayShuffle;
private _count = 0;
while {_count < 10} do {
	private _try = BRPVP_rZedsCfgBoneBreakSounds call BIS_fnc_arrayShuffle;
	if (count BRPVP_rZedsCfgBoneBreakSounds >= 5) then {
		private _first1 = _try select 0;
		private _first2 = _try select 1;
		private _cs = count BRPVP_rZedsCfgBoneBreakSeq;
		private _last1 = BRPVP_rZedsCfgBoneBreakSeq select (_cs-2);
		private _last2 = BRPVP_rZedsCfgBoneBreakSeq select (_cs-1);
		if (_first1 isNotEqualTo _last1 && _first1 isNotEqualTo _last2 && _first2 isNotEqualTo _last2) then {
			BRPVP_rZedsCfgBoneBreakSeq append _try;
			_count = _count+1;
		};
	} else {
		BRPVP_rZedsCfgBoneBreakSeq append _try;
		_count = _count+1;
	};
};
BRPVP_rZedsCfgBoneBreakSeqCnt = count BRPVP_rZedsCfgBoneBreakSeq;
BRPVP_rZedsCfgBoneBreakSeqIdx = 0;