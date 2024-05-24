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

//PARAMS
_place = _this select 0;
_rad = _this select 1;
_skill = _this select 2;

_pFix = [0,0,0];
_pFix2D = [0,0,0];

//MISSION
_pmissGroups = [
	[
		WEST,
		[],
		[],
		[
			["B_T_MRAP_01_gmg_F",[13829.2,21656.9,107.3],[[0,1,-0.01],[-0.04,0.01,1]],[4],[["B_T_Soldier_F",["turret",[0]],[],[]]]],
			["B_T_APC_Wheeled_01_cannon_F",[13899.2,21625.9,107.9],[[-0.69,-0.73,0],[0.01,0,1]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]],
			["B_T_LSV_01_armed_F",[13925.2,21628.1,107.3],[[0.86,-0.51,-0.03],[0.03,-0.01,1]],[4],[["B_T_Soldier_F",["turret",[0]],[],[]],["B_T_Soldier_F",["driver"],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13912.3,21609.9,106.9],[[0.33,-0.95,-0.01],[0.01,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_GMG_01_high_F",[13813.2,21649,106],[[-0.92,-0.39,-0.06],[-0.06,-0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_AR_F",[13936.7,21643,0],87,[1],"STAND",[]],
			["B_W_soldier_M_F",[13935.1,21628.6,0],92,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_GL_F",[13927.2,21686.3,0],56,[1],"STAND",[["arifle_MX_GL_Black_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_wdl",[["30Rnd_65x39_caseless_black_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_AAR_F",[13870.7,21590.2,0],223,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_tshirt_mcam_wdL_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_black_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Kitbag_rgr_BWAAR",[["optic_tws_mg",1],["bipod_01_F_blk",1],["muzzle_snds_338_black",1],["muzzle_snds_H",1],["100Rnd_65x39_caseless_black_mag",2,100],["100Rnd_65x39_caseless_black_mag_tracer",2,100],["130Rnd_338_Mag",2,130]]],"H_HelmetB_light_wdl","G_Combat",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["B_ghillie_lsh_F",[13890.7,21610.5,12.4],245,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_ghillie_lsh_F",[13900.6,21610.6,12.4],77,[1],"STAND",[["srifle_LRR_tna_F","","","optic_Nightstalker",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_T_FullGhillie_tna_F",[["FirstAidKit",1],["SmokeShell",1,1],["7Rnd_408_Mag",3,7]]],["V_Chestrig_rgr",[["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[13861.9,21672.6,0],333,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_Officer_F",[13887.1,21674.3,4.7],77,[1],"STAND",[["arifle_SPAR_01_GL_khk_F","muzzle_snds_m_khk_F","acc_pointer_IR","optic_ERCO_khk_F",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag",1,30]]],["V_CarrierRigKBT_01_light_EAF_F",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",1,1]]],[],"","G_Balaclava_blk",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_Officer_F",[13899.6,21678,0.5],253,[1],"STAND",[["arifle_SPAR_01_GL_khk_F","muzzle_snds_m_khk_F","acc_pointer_IR","optic_ERCO_khk_F",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag",1,30]]],["V_CarrierRigKBT_01_light_EAF_F",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",1,1]]],[],"","G_Balaclava_blk",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_Officer_F",[13898.9,21680.1,4.5],209,[1],"STAND",[["arifle_SPAR_01_GL_khk_F","muzzle_snds_m_khk_F","acc_pointer_IR","optic_ERCO_khk_F",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag",1,30]]],["V_CarrierRigKBT_01_light_EAF_F",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",1,1]]],[],"","G_Balaclava_blk",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_Officer_F",[13898,21681.4,4.5],229,[1],"STAND",[["arifle_SPAR_01_GL_khk_F","muzzle_snds_m_khk_F","acc_pointer_IR","optic_ERCO_khk_F",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag",1,30]]],["V_CarrierRigKBT_01_light_EAF_F",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",1,1]]],[],"","G_Balaclava_blk",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_Officer_F",[13893,21682.6,4.6],128,[1],"STAND",[["arifle_SPAR_01_GL_khk_F","muzzle_snds_m_khk_F","acc_pointer_IR","optic_ERCO_khk_F",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag",1,30]]],["V_CarrierRigKBT_01_light_EAF_F",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",1,1]]],[],"","G_Balaclava_blk",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_Officer_F",[13889.2,21674.9,0.6],167,[1],"STAND",[["arifle_SPAR_01_GL_khk_F","muzzle_snds_m_khk_F","acc_pointer_IR","optic_ERCO_khk_F",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag",1,30]]],["V_CarrierRigKBT_01_light_EAF_F",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",1,1]]],[],"","G_Balaclava_blk",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Officer_Parade_F",[13892.2,21679.6,4.7],62,[1,2],"STAND",[[],[],[],["U_B_ParadeUniform_01_US_F",[]],[],[],"H_ParadeDressCap_01_US_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["B_T_Static_AA_F",[13889.9,21668.8,115.7],[[-0.22,-0.97,0.01],[0.01,0.01,1]],[],[["B_T_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13902.1,21674.7,116.2],[[0.71,-0.7,0.01],[0,0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13885.1,21678,116.4],[[-0.93,0.36,0.01],[0.01,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13887.5,21673,108],[[0.45,-0.89,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13889,21673,112.1],[[0.82,0.57,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_T_Static_AA_F",[13897.4,21683.6,115.6],[[0,1,0.01],[0.02,-0.01,1]],[],[["B_T_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[13894.3,21701.1,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AR_F",[13899.3,21696.1,0],0,[],"STAND",[]],
			["B_Soldier_GL_F",[13889.3,21696.1,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[13904.3,21691.1,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_T_Soldier_AAA_F",[13884.4,21690.3,0],0,[],"STAND",[["arifle_MX_khk_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_AR_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_khaki_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Carryall_oli_BTAAA_F",[["Titan_AA",3,1]]],"H_HelmetB_Light_tna_F","G_Tactical_Clear",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]]
		],
		[],
		[
			[[13894.3,21701.1,0.00437927],"MOVE"],
			[[13787.2,21668.3,0.000175476],"MOVE"],
			[[13795.5,21632.3,-0.00012207],"MOVE"],
			[[13870.7,21645.2,-1.52588e-005],"MOVE"],
			[[13881,21618.2,-2.28882e-005],"MOVE"],
			[[13915,21638.9,7.62939e-006],"MOVE"],
			[[13900.2,21682.9,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[13902.1,21640.4,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AR_F",[13907.1,21635.4,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_HeavyGunner_F",[13897.1,21635.4,0],0,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AAR_F",[13912.1,21630.4,0],0,[],"STAND",[]],
			["B_soldier_M_F",[13892.1,21630.4,0],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Sharpshooter_F",[13917.1,21625.4,0],0,[],"STAND",[["srifle_DMR_03_tan_AMS_LP_F","","acc_pointer_IR","optic_AMS_snd",["20Rnd_762x51_Mag",20],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["20Rnd_762x51_Mag",6,20],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[13887.1,21625.4,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[13922.1,21620.4,0],0,[],"STAND",[["arifle_MX_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetB_light_desert","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13902.1,21640.4,0.0015564],"MOVE"],
			[[13851.2,21588.9,-0.000114441],"MOVE"],
			[[13791.7,21646.1,-5.34058e-005],"MOVE"],
			[[13872.6,21652.2,-2.28882e-005],"MOVE"],
			[[13926.1,21677.8,0.000190735],"MOVE"],
			[[13946.2,21635.4,-7.62939e-006],"MOVE"],
			[[13915.1,21591.4,0.000183105],"MOVE"],
			[[13906.5,21625.5,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_GL_F",[13870.2,21613.1,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_F",[13875.2,21608.1,0],0,[],"STAND",[]],
			["B_T_Soldier_AAT_F",[13872.2,21601,0],0,[],"STAND",[]]
		],
		[],
		[
			[[13870.2,21613.1,0.00117493],"MOVE"],
			[[13843.6,21582.6,-0.00012207],"MOVE"],
			[[13809.9,21611.1,-5.34058e-005],"MOVE"],
			[[13838.4,21673.6,8.39233e-005],"MOVE"],
			[[13900.9,21702.9,-7.62939e-006],"MOVE"],
			[[13939.6,21655.6,0],"MOVE"],
			[[13884.2,21622.8,0.5],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["B_T_Truck_01_flatbed_F",[13844,21632,107.3],[[0.91,0.41,0.01],[-0.01,-0.01,1]]],
	["B_T_Truck_01_covered_F",[13882.9,21636.2,107.4],[[0.43,-0.9,0],[-0.01,-0.01,1]]],
	["C_Van_02_service_F",[13884.1,21659.1,107.1],[[0.43,-0.9,-0.03],[0,-0.03,1]]],
	["C_Offroad_01_comms_F",[13888.3,21661.7,107.1],[[0.46,-0.89,-0.02],[0,-0.03,1]]],
	["C_Offroad_01_comms_F",[13880.1,21657.4,107],[[0.43,-0.9,-0.02],[-0.01,-0.02,1]]],
	["B_T_LSV_01_armed_F",[13858.4,21618.6,106.9],[[-0.79,-0.61,-0.02],[-0.03,0,1]]],
	["B_T_Quadbike_01_F",[13855.9,21623.1,106.2],[[0.72,-0.7,0.01],[-0.02,-0.01,1]]],
	["B_T_Truck_01_transport_F",[13886,21601.8,107.4],[[0.71,0.7,0.01],[0,0,1]]],
	["B_T_LSV_01_armed_F",[13890,21639.1,107.5],[[0.4,-0.92,0],[0,-0.01,1]]],
	["B_Heli_Light_01_dynamicLoadout_F",[13831.3,21628.7,106.2],[[0.7,0.72,0.02],[-0.02,-0.01,1]]],
	["B_Heli_Light_01_F",[13835,21639.6,106.4],[[-0.94,-0.34,-0.02],[-0.01,-0.02,1]]]
];
_doors = [];
_delete =[];
_pmissBuildings = [
	["Land_Barracks_06_F",[13887.6,21670.3,111.36],[[0.44,-0.9,0],[0,0,1]],true,{},[1,7]],
	["Land_BagBunker_01_small_green_F",[13813.8,21649,105.41],[[0.92,0.38,0.06],[-0.06,-0.02,1]],false],
	["CamoNet_BLUFOR_big_F",[13854.8,21619.5,107.66],[[-0.9,-0.45,0],[0,0,1]],true],
	["Land_RepairDepot_01_green_F",[13849.5,21659.1,107.45],[[-0.91,-0.4,-0.02],[-0.01,-0.01,1]],true],
	["B_Slingload_01_Fuel_F",[13842,21658.4,106.3],[[-0.92,-0.38,-0.01],[-0.01,-0.01,1]],true],
	["Land_TentHangar_V1_F",[13833.5,21634.1,108.65],[[0.92,0.38,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_open_F",[13858.5,21660.5,106.55],[[-0.41,0.91,0],[-0.02,-0.01,1]],true],
	["Land_BagBunker_01_small_green_F",[13871.3,21590.8,106.04],[[0.72,0.69,-0.01],[-0.01,0.02,1]],false],
	["Land_RoadBarrier_01_F",[13865.1,21593.7,108.52],[[0.72,0.69,0],[0,0,1]],true],
	["Land_BagBunker_01_small_green_F",[13861.3,21601.9,105.97],[[0.76,0.65,0.01],[-0.01,0,1]],false],
	["Land_PowerGenerator_F",[13866.5,21616,105.83],[[0.89,0.46,0.02],[-0.02,0,1]],false],
	["FlexibleTank_01_sand_F",[13865.3,21616.9,105.52],[[0,1,0],[-0.02,0,1]],false],
	["FlexibleTank_01_forest_F",[13866.7,21617.5,105.55],[[0,1,0],[-0.02,0,1]],false],
	["Land_MedicalTent_01_NATO_tropic_generic_outer_F",[13889.6,21639.7,106.78],[[-0.43,0.9,-0.01],[-0.01,0,1]],true],
	["O_CargoNet_01_ammo_F",[13872.1,21660.3,106.21],[[0,1,0.01],[-0.01,-0.01,1]],false],
	["I_E_CargoNet_01_ammo_F",[13870.5,21663.1,106.22],[[0,1,0.01],[-0.01,-0.01,1]],false],
	["Land_BagBunker_01_small_green_F",[13862.2,21672.1,106.39],[[0.38,-0.92,0],[-0.02,0,1]],false],
	["CargoNet_01_barrels_F",[13869.9,21660.2,105.88],[[0,1,0.01],[-0.01,-0.01,1]],false],
	["Land_BagBunker_01_small_green_F",[13912,21610.4,106.35],[[-0.38,0.93,0.01],[0.01,0,1]],false],
	["Land_ControlTower_01_F",[13895,21611.1,112.89],[[0.72,0.69,0],[0,0,1]],true],
	["Land_AirConditioner_03_F",[13914.4,21656.4,106.08],[[-0.94,-0.35,0],[0,-0.01,1]],false],
	["Land_Cargo_House_V1_F",[13907.2,21648.9,106.19],[[-0.43,0.9,0],[0,0,1]],true],
	["Land_Cargo_House_V1_F",[13897.5,21644.3,106.14],[[-0.43,0.9,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13916.2,21666,107.01],[[0.89,0.46,-0.01],[0.01,-0.01,1]],true],
	
	["Land_TableDesk_F",[13893.5,21679.4,110.95],[[-0.9,-0.44,0],[0,0,1]],true],
	["Land_IPPhone_01_olive_F",[13893.3,21680,111.5],[[0.9,0.44,0],[0,0,1]],true],
	["Land_Laptop_Intel_01_F",[13893.7,21678.8,111.63],[[-0.97,0.24,0.04],[0.04,0.01,1]],true],
	["Land_FlowerPot_01_Flower_F",[13893.8,21683.4,111.35],[[0,1,0],[0,0,1]],true],
	["Land_OfficeCabinet_01_F",[13891.1,21681.7,111.33],[[-0.9,-0.43,0],[0,0,1]],true],
	["MapBoard_altis_F",[13896.8,21684.2,111.51],[[0.56,0.83,-0.01],[0,0,1]],true],
	["Land_File_research_F",[13893.3,21679.5,111.47],[[0,1,-0.01],[0.01,0.01,1]],true],
	["Land_OfficeChair_01_F",[13892.8,21678.6,111.22],[[-0.16,-0.99,0],[0,0,1]],true],
	["Land_WaterCooler_01_old_F",[13891.3,21681.1,111.28],[[-0.9,-0.44,0],[0,0,1]],true],
	
	["Land_AirConditioner_04_F",[13908.6,21664.8,106.16],[[-0.3,-0.95,-0.01],[0,-0.01,1]],false],
	["Land_BagBunker_01_small_green_F",[13934.5,21628.6,106.11],[[-1,0.08,0.02],[0.02,0,1]],false],
	["Land_PoleWall_01_6m_F",[13923.1,21610.1,105.38],[[0,1,0],[0,0,1]],false],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13921.9,21655.3,106.88],[[0.89,0.46,-0.01],[0.02,-0.01,1]],true],
	["Land_BagBunker_01_small_green_F",[13935.8,21642.9,106.14],[[-1,0.07,0.03],[0.03,-0.01,1]],false],
	["Land_RoadBarrier_01_F",[13937.6,21635.2,108.65],[[1,-0.09,0],[0,0,1]],true],
	["Land_WaterTank_02_F",[13925.6,21648.7,107.59],[[-0.44,0.9,0],[0,0,1]],true],
	["Land_BagBunker_01_small_green_F",[13926.3,21686,105.91],[[-0.91,-0.39,0.09],[0.07,0.05,1]],false]
];

private _ata = [];
private _nos = [];
private _ts = [];
private _vd = [];
private _hide = [];
private _noLagWait = 0.1;

{
	_x params ["_pw","_rad"];
	{
		private _isHide = _x in _hide;
		private _noClass = typeOf _x isEqualTo "";
		private _isBuilding = _x isKindOf "Building";
		private _isWall = _x isKindOf "Wall";
		private _isFurniture = _x isKindOf "Furniture_base_F";
		if (!_isHide && (_noClass || _isBuilding || _isWall || _isFurniture)) then {
			_x hideObject true;
			[_x,false] remoteExecCall ["allowDamage",2];
			[_x,true] remoteExecCall ["hideObjectGlobal",2];
			_hide pushBack _x;
		};
	} forEach nearestObjects [ASLToAGL _pw,[],_rad,true];
	uiSleep _noLagWait;
} forEach [
	[[13871.1,21631.1,105.115],10]
];

{
	_x params ["_class","_pw","_vdu","_complete",["_code",{}],["_flags",[]]];
	private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_obj call _code;
	_nos pushBack _obj;
	if (_complete && isDamageAllowed _obj && !(7 in _flags)) then {_obj setVariable ["brpvp_yes_minerva",true,true];};
	if (1 in _flags) then {
		_obj addEventHandler ["HandleDamage",{
			params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
			private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
			private _deltaDam = _dam-_damNow;
			_damNow+_deltaDam*0.5
		}];
	};
	uiSleep _noLagWait;
} forEach _pmissBuildings;

{
	_x params ["_class","_posW","_vdu"];
	private _hmg = createVehicle [_class,[0,0,0],[],0,"CAN_COLLIDE"];
	_hmg setVectorDirAndUp _vdu;
	_hmg setposWorld _posW;
	_hmg setVariable ["own",-2,true];
	_hmg setVariable ["stp",4,true];
	_hmg setVariable ["amg",[[],[],false],true];
	_hmg remoteExecCall ["BRPVP_setTurretOperator",2];
	_hmg setVariable ["brpvp_dead_delete",true,2];
	_ts pushBack _hmg;
	uiSleep _noLagWait;
} forEach _pmissBaseTurrets;

{
	_x params ["_class","_pw","_vdu",["_flags",[]]];
	//private _obj = createSimpleObject [_class,[0,0,0]];
	private _obj = createVehicle [_class,BRPVP_posicaoFora,[],100,"NONE"];
	_obj call BRPVP_emptyBox;
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_vd pushBack _obj;
	_obj call BRPVP_initPlayerMissionSceneryVehicles;
	uiSleep _noLagWait;
} forEach _pmissEmptyVehs;

{
	_x params ["_side","_wps","_onFoot","_onVeh","_wps2"];
	private _grp = createGroup [_side,true];
	{
		_x params ["_class","_AGL","_dir","_flags","_stance","_gear"];
		if (random 1 <= BRPVP_pmiss2AiPerc || 2 in _flags) then {
			private _u = _grp createUnit [_class,_AGL vectorAdd _pFix2D,[],0,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u setDir _dir;
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			if (2 in _flags) then {
				_u setVariable ["brpvp_can_ulfanize",false,2];
				_u setVariable ["brpvp_extra_chance",10];
				_u addEventHandler ["Killed",{
					private _pos = getPosASL (_this select 0) vectorAdd [0,0,1.25];
					private _suitCase = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
					_suitCase setPosASL _pos;
					_suitCase setVariable ["mny",round (4000000*BRPVP_missionValueMult),true];
					_this call BRPVP_botDaExp;
				}];
			} else {
				_u setVariable ["brpvp_extra_chance",2];
				_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			};
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			BRPVP_pmiss2ActualAiUnits pushBack _u;
			if (_gear isNotEqualTo []) then {_u setUnitLoadout _gear;};
			if (primaryWeapon _u isEqualTo "" || _wps isNotEqualTo [] || _wps2 isNotEqualTo []) then {
				_u setUnitPos _stance;
			} else {
				private _anim = if (_stance isEqualTo "STAND") then {
					selectRandom ["STAND","STAND_IA","WATCH","WATCH1","WATCH2"]
				} else {
					if (_stance isEqualTo "CROUCH") then {
						selectRandom ["KNEEL","KNEEL","SIT_LOW"]
					} else {
						if (_stance isEqualTo "PRONE") then {"LEAN"} else {"STAND_IA"};
					};
				};
				[_u,_anim] call BIS_fnc_ambientAnimCombat;
			};
			if (1 in _flags) then {
				_u disableAI "PATH";
				//_u disableAI "FSM";
			};
			uiSleep _noLagWait;
		};
	} forEach _onFoot;
	{
		_x params ["_class","_pw","_vdu","_flags","_crew"];
		private _st = if (3 in _flags) then {"FLY"} else {"CAN_COLLIDE"};
		private _veh = createVehicle [_class,[0,0,0],[],10,_st];
		_veh setVectorDirAndUp _vdu;
		_veh setPosWorld (_pw vectorAdd _pFix);
		_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
		if (_veh isKindOf "StaticWeapon") then {
			_veh addEventHandler ["HandleDamage",{
				params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
				private _sameSide = side _instigator isEqualTo side _veh;
				if (_sameSide) then {if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};} else {_dam};
			}];
		} else {
			_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
		};
		{
			_x params ["_class","_roleArray","_flags",["_gear",[]]];
			_roleArray params ["_role",["_path",[]]];
			private _u = _grp createUnit [_class,[0,0,0],[],10,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			if (_gear isNotEqualTo []) then {_u setUnitLoadout _gear;};
			if (_role isEqualTo "driver") then {_u moveInDriver _veh;};
			if (_role isEqualTo "turret") then {_u moveInTurret [_veh,_path];};
			if (_role isEqualTo "cargo") then {_u moveInCargo _veh;};
			if (1 in _flags) then {_u disableAI "PATH";};
			if (_veh isKindOf "StaticWeapon") then {
				private _dir = [[0,0,0],_vdu select 0] call BIS_fnc_dirTo;
				_u doWatch (getPosASL _veh vectorAdd [100*sin _dir,100*cos _dir,3]);
				BRPVP_pmiss2ActualAiUnits pushBack _u;
			};
		} forEach _crew;
		if (1 in _flags) then {_veh lock true;};
		if (2 in _flags) then {_veh setVariable ["brpvp_cant_heli_town",true,true];};
		if (4 in _flags) then {_veh setUnloadInCombat [true,false];};
		_vd pushBack _veh;
		uiSleep _noLagWait;
	} forEach _onVeh;
	if (count units _grp > 0) then {
		if (_wps isNotEqualTo []) then {
			{
				_wp = _grp addWayPoint [_x vectorAdd _pFix2D,0];
				_wp setWayPointType "MOVE";
				_wp setWaypointCompletionRadius 5;
			} forEach _wps;
			_wp = _grp addWayPoint [(_wps select 0) vectorAdd _pFix2D,0];
			_wp setWayPointType "CYCLE";
			_wp setWaypointCompletionRadius 5;
		} else {
			if (_wps2 isNotEqualTo []) then {
				{
					_wp = _grp addWayPoint [(_x select 0) vectorAdd _pFix2D,0];
					_wp setWayPointType (_x select 1);
					_wp setWaypointCompletionRadius 5;
				} forEach _wps2;
			};
		};
	};
	uiSleep _noLagWait;
} forEach _pmissGroups;

//RARE LOOT
{
	_x params ["_posW","_dir","_q"];
	private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
	_box allowDamage false;
	_box setPosASL (_posW vectorAdd _pFix);
	_box setDir _dir;
	[_box,0,1,true,_q] call BRPVP_createCompleteLootBox;
	uiSleep _noLagWait;
} forEach [
	[[13916.5,21665.8,105.634],245.461,20],
	[[13858.9,21661.1,105.191],161.164,10]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmiss2Objects = [_place,_rad,_nos,_ts,[],[],_vd,_hide];
BRPVP_pmiss2Spawning = false;