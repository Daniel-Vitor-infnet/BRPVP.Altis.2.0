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
		INDEPENDENT,
		[],
		[
			["I_E_Soldier_lite_F",[5364.8,17920.4,4.3],61,[1],"STAND",[["arifle_AK12_GL_lush_F","muzzle_snds_B_lush_F","acc_pointer_IR","optic_ERCO_khk_F",["30rnd_762x39_AK12_Lush_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["30rnd_762x39_AK12_Lush_Mag_F",3,30]]],["V_PlateCarrier2_blk",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_Colonel","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Officer_Parade_Veteran_F",[5367.2,17918.6,4.5],0,[1,2],"STAND",[]],
			["I_E_Soldier_lite_F",[5367.8,17924.4,4.2],156,[1],"STAND",[["arifle_AK12_GL_lush_F","muzzle_snds_B_lush_F","acc_pointer_IR","optic_ERCO_khk_F",["30rnd_762x39_AK12_Lush_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["30rnd_762x39_AK12_Lush_Mag_F",3,30]]],["V_PlateCarrier2_blk",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_Colonel","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[5369.7,17924.8,4.3],151,[1],"STAND",[["arifle_AK12_GL_lush_F","muzzle_snds_B_lush_F","acc_pointer_IR","optic_ERCO_khk_F",["30rnd_762x39_AK12_Lush_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["30rnd_762x39_AK12_Lush_Mag_F",3,30]]],["V_PlateCarrier2_blk",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_Colonel","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[5369.9,17912.1,4.7],10,[1],"STAND",[["arifle_AK12_GL_lush_F","muzzle_snds_B_lush_F","acc_pointer_IR","optic_ERCO_khk_F",["30rnd_762x39_AK12_Lush_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["30rnd_762x39_AK12_Lush_Mag_F",3,30]]],["V_PlateCarrier2_blk",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_Colonel","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[5370.3,17914,0.6],98,[1],"STAND",[["arifle_AK12_GL_lush_F","muzzle_snds_B_lush_F","acc_pointer_IR","optic_ERCO_khk_F",["30rnd_762x39_AK12_Lush_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["30rnd_762x39_AK12_Lush_Mag_F",3,30]]],["V_PlateCarrier2_blk",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_Colonel","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[5371.8,17924.7,0.2],193,[1],"STAND",[["arifle_AK12_GL_lush_F","muzzle_snds_B_lush_F","acc_pointer_IR","optic_ERCO_khk_F",["30rnd_762x39_AK12_Lush_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["30rnd_762x39_AK12_Lush_Mag_F",3,30]]],["V_PlateCarrier2_blk",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_Colonel","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_E_HMG_02_high_F",[5365.7,17911.3,87.7],[[0.63,-0.78,0.01],[0,0.01,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_Static_AA_F",[5375.8,17912.6,87],[[0.91,-0.42,0.01],[0,0.01,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[5365.9,17924.9,87.5],[[-0.89,0.46,0.01],[0.02,0.01,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_Static_AT_F",[5375.8,17922.9,86.9],[[1,-0.05,0.02],[-0.02,0.01,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[5371.087,17911.887,79.3],[[1,0.09,0],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[5371.932,17912.469,83.4],[[-0.04,1,0],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_E_HMG_02_high_F",[5380.1,17938.1,85],[[0.7,-0.71,0],[0,0.01,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_lsh_F",[5436.2,17916.6,12.4],0,[1],"STAND",[["srifle_GM6_F","","","optic_tws",["5Rnd_127x108_Mag",5],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_ACPC2_F","muzzle_snds_acp","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_FullGhillie_lsh",[["FirstAidKit",1],["5Rnd_127x108_Mag",2,5],["SmokeShell",1,1]]],["V_Chestrig_oli",[["5Rnd_127x108_Mag",3,5],["9Rnd_45ACP_Mag",2,9],["APERSTripMine_Wire_Mag",1,1],["ClaymoreDirectionalMine_Remote_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],[],"H_HelmetO_ViperSP_ghex_F","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_AT_F",[5434.4,17918.2,0],72,[],"STAND",[["arifle_MSBS65_F","","acc_pointer_IR","optic_ico_01_f",["30Rnd_65x39_caseless_msbs_mag",30],[],""],["launch_I_Titan_short_F","","","",[],[],""],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",3,30],["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],["B_RadioBag_01_eaf_F",[]],"H_HelmetHBK_ear_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_ghillie_lsh_F",[5428.8,17909.1,12.4],207,[1],"STAND",[["srifle_GM6_F","","","optic_tws",["5Rnd_127x108_Mag",5],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_ACPC2_F","muzzle_snds_acp","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_FullGhillie_lsh",[["FirstAidKit",1],["5Rnd_127x108_Mag",2,5],["SmokeShell",1,1]]],["V_Chestrig_oli",[["5Rnd_127x108_Mag",3,5],["9Rnd_45ACP_Mag",2,9],["APERSTripMine_Wire_Mag",1,1],["ClaymoreDirectionalMine_Remote_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],[],"H_HelmetO_ViperSP_ghex_F","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_ghillie_lsh_F",[5435.6,17908.5,12.5],128,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_E_Soldier_AR_F",[5435.8,17932.2,0],92,[1],"STAND",[["LMG_Mk200_black_F","","acc_pointer_IR","optic_Aco",["200Rnd_65x39_cased_Box_Red",200],[],"bipod_01_F_blk"],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_shortsleeve_F",[["FirstAidKit",1],["11Rnd_45ACP_Mag",2,11],["HandGrenade",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["200Rnd_65x39_cased_Box_Red",2,200],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",2,1]]],["B_Carryall_eaf_F",[]],"H_HelmetHBK_ear_F","G_Lowprofile",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_E_Soldier_AR_F",[5380.5,17881.1,0],174,[1],"STAND",[["LMG_Mk200_black_F","","acc_pointer_IR","optic_Aco",["200Rnd_65x39_cased_Box_Red",200],[],"bipod_01_F_blk"],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_shortsleeve_F",[["FirstAidKit",1],["11Rnd_45ACP_Mag",2,11],["HandGrenade",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["200Rnd_65x39_cased_Box_Red",2,200],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",2,1]]],["B_RadioBag_01_black_F",[]],"H_HelmetHBK_ear_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_G_Offroad_01_armed_F",[5451.4,17924.7,78.2],[[0.41,-0.91,-0.1],[0.03,-0.1,0.99]],[4],[["I_G_Soldier_F",["turret",[0]],[],[]]]],
			["I_MRAP_03_hmg_F",[5395.85,17925.7,79.0723],[[0.75,-0.65,-0.1],[0.06,-0.08,1]],[4],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_G_Offroad_01_AT_F",[5366.6,17884,77.8],[[0.83,-0.56,-0.02],[0,-0.03,1]],[4],[["I_G_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_TL_F",[5400.1,17912.3,0],0,[],"STAND",[["arifle_Mk20_GL_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,9],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["1Rnd_SmokePurple_Grenade_shell",1,1]]],[],"H_HelmetIA","G_Sport_Greenblack",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_AR_F",[5405.1,17907.3,0],0,[],"STAND",[["LMG_Mk200_LP_BI_F","","acc_pointer_IR","",["200Rnd_65x39_cased_Box",200],[],"bipod_03_F_blk"],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["9Rnd_45ACP_Mag",2,9],["HandGrenade",1,1],["SmokeShell",1,1]]],["V_PlateCarrierIA2_dgtl",[["200Rnd_65x39_cased_Box",2,200],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA_camo","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_GL_F",[5395.1,17907.3,0],0,[],"STAND",[["arifle_Mk20_GL_ACO_F","","","optic_ACO_grn",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30],["1Rnd_SmokePurple_Grenade_shell",1,1]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag",2,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetIA_net","G_Sport_Checkered",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_LAT_F",[5410.1,17902.3,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA2_dgtl",[["30Rnd_556x45_Stanag",2,30],["9Rnd_45ACP_Mag",2,9],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["I_Fieldpack_oli_LAT",[["NLAW_F",2,1]]],"H_HelmetIA","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_E_Soldier_AAA_F",[5414.4,17896.9,0],0,[],"STAND",[["arifle_MSBS65_ico_pointer_f","","acc_pointer_IR","optic_ico_01_f",["30Rnd_65x39_caseless_msbs_mag",30],[],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_shortsleeve_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",5,30],["11Rnd_45ACP_Mag",2,11],["HandGrenade",2,1],["I_E_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],["B_Carryall_eaf_IEAAA_F",[["Titan_AA",3,1]]],"H_HelmetHBK_ear_F","G_Shades_Red",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[5400.06,17912.3,0.00104523],"MOVE"],
			[[5443.27,17934.2,0],"MOVE"],
			[[5461.65,17885.1,0],"MOVE"],
			[[5383.7,17835.4,0.499321],"MOVE"],
			[[5355.79,17889,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_GL_F",[5428.3,17969.1,0],0,[],"STAND",[]],
			["I_soldier_F",[5433.3,17964.1,0],0,[],"STAND",[]]
		],
		[],
		[
			[[5428.28,17969.1,-0.0207748],"MOVE"],
			[[5373.85,17972.1,6.86646e-005],"MOVE"],
			[[5342.97,17945,-0.000312805],"MOVE"],
			[[5395.16,17920.2,0],"MOVE"],
			[[5443.78,17920.1,-7.62939e-006],"MOVE"],
			[[5428.28,17969.1,0.5],"MOVE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_SL_F",[5401.1,17857.6,0],0,[],"STAND",[]],
			["I_Soldier_AR_F",[5406.1,17852.6,0],0,[],"STAND",[]],
			["I_Soldier_GL_F",[5396.1,17852.6,0],0,[],"STAND",[["arifle_Mk20_GL_ACO_F","","","optic_ACO_grn",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30],["1Rnd_SmokePurple_Grenade_shell",1,1]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag",2,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetIA_net","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_M_F",[5411.1,17847.6,0],0,[],"STAND",[["srifle_EBR_MRCO_LP_BI_F","","acc_pointer_IR","optic_MRCO",["20Rnd_762x51_Mag",20],[],"bipod_03_F_blk"],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["Chemlight_green",1,1]]],["V_PlateCarrierIA1_dgtl",[["20Rnd_762x51_Mag",6,20],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetIA","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_AT_F",[5391.1,17847.6,0],0,[],"STAND",[]],
			["I_Soldier_AAT_F",[5416.1,17842.6,0],0,[],"STAND",[]],
			["I_Soldier_A_F",[5386.1,17842.6,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA1_dgtl",[["30Rnd_556x45_Stanag",8,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["I_Fieldpack_oli_Ammo",[["FirstAidKit",4],["30Rnd_556x45_Stanag",8,30],["200Rnd_65x39_cased_Box",1,200],["NLAW_F",1,1],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",6,1],["20Rnd_762x51_Mag",3,20]]],"H_HelmetIA_net","G_Lowprofile",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_medic_F",[5421.1,17837.6,0],0,[],"STAND",[["arifle_Mk20_pointer_F","","acc_pointer_IR","",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA2_dgtl",[["30Rnd_556x45_Stanag",2,30],["9Rnd_45ACP_Mag",2,9],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],["I_Fieldpack_oli_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetIA","G_Shades_Red",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_E_Soldier_AAA_F",[5383.7,17835.4,0],0,[],"STAND",[["arifle_MSBS65_ico_pointer_f","","acc_pointer_IR","optic_ico_01_f",["30Rnd_65x39_caseless_msbs_mag",30],[],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_shortsleeve_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",5,30],["11Rnd_45ACP_Mag",2,11],["HandGrenade",2,1],["I_E_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],["B_Carryall_eaf_IEAAA_F",[["Titan_AA",3,1]]],"H_HelmetHBK_ear_F","G_Sport_Red",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[5401.09,17857.6,-0.0142822],"MOVE"],
			[[5330.23,17875.8,0],"MOVE"],
			[[5341.21,17967.8,0],"MOVE"],
			[[5450.83,17961.3,7.62939e-006],"MOVE"],
			[[5448.75,17866,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_GL_F",[5328,17929.8,0],0,[],"STAND",[]],
			["I_soldier_F",[5333,17924.8,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA1_dgtl",[["30Rnd_556x45_Stanag",6,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA","G_Squares",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[5327.98,17929.8,-0.0139313],"MOVE"],
			[[5359.09,17845.2,-0.000350952],"MOVE"],
			[[5421.24,17857.2,4.57764e-005],"MOVE"],
			[[5442.37,17925.6,-2.28882e-005],"MOVE"],
			[[5350.04,17927.9,0],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["I_E_Offroad_01_comms_F",[5411.8,17894.4,77.9],[[0.03,1,0.04],[0.01,-0.04,1]]],
	["I_E_Truck_02_F",[5430.2,17901.7,78.5],[[-1,0.06,0.01],[0.01,-0.02,1]]],
	["I_E_Truck_02_fuel_F",[5429.7,17893.8,78.4],[[-1,0.07,0.02],[0.02,-0.01,1]]],
	["I_E_Quadbike_01_F",[5401.8,17894.3,77.9],[[0,1,0.05],[0.02,-0.05,1]]],
	["I_E_Quadbike_01_F",[5399.9,17894.4,77.9],[[0,1,0.02],[0.04,-0.02,1]]]
];
_doors = [];
_delete =[];
_pmissBuildings = [
	["Land_Barracks_06_F",[5373.66,17910.4,82.62],[[1,0.02,0],[0,0,1]],true,{},[1,7]],
	["Land_LampAirport_F",[5369.97,17936.2,89.94],[[0,1,0],[0,0,1]],true],
	["Land_LampAirport_F",[5388.22,17875.5,88.77],[[0,1,0],[0,0,1]],true],
	["Land_BagBunker_01_small_green_F",[5380.65,17881.8,77.5],[[0,1,-0.02],[-0.01,0.02,1]],false],
	["Land_Barracks_03_F",[5393.99,17890.9,78.32],[[-1,-0.03,0],[0,0,1]],true],

	["Land_TableDesk_F",[5367.95,17919.6,82.12+0.2],[[0.01,-1,0],[0,0,1]],true],
	["Land_OfficeCabinet_01_F",[5368.57,17925,82.49+0.2],[[1,0.02,0],[0,0,1]],true],
	["Land_PCSet_01_keyboard_F",[5368.25,17919.6,82.54+0.2],[[0,1,0],[0,0,1]],true],
	["Land_PCSet_Intel_01_F",[5368.39,17919.8,82.78+0.2],[[0,1,0],[0.03,0,1]],true],
	["Land_IPPhone_01_black_F",[5367.24,17919.7,82.57+0.2],[[0,1,0],[0,0,1]],true],
	["Land_OfficeChair_01_F",[5368.4,17918.7,82.38+0.2],[[0.77,-0.64,0],[0,0,1]],true],
	["MapBoard_altis_F",[5364.93,17918.8,82.68+0.2],[[-0.66,-0.75,-0.01],[0,0,1]],true],
	["Fridge_01_closed_F",[5364.57,17921.8,82.23+0.2],[[-1,-0.02,0],[0,0,1]],true],
	["Land_TripodScreen_01_dual_v1_black_F",[5364.92,17924.9,82.52+0.2],[[0.42,-0.91,0],[0,0,1]],true],
	["Land_Router_01_black_F",[5367.72,17919.8,82.64+0.2],[[0,1,-0.01],[-0.01,0.01,1]],true],
	["Land_PortableLongRangeRadio_F",[5367.58,17919.5,82.54+0.2],[[0,1,-0.01],[-0.01,0.01,1]],true],
	["Land_PCSet_01_mouse_F",[5368.68,17919.5,82.55+0.2],[[0,1,0],[-0.02,0,1]],true],

	["Land_LampHalogen_F",[5379.05,17906.1,82.83],[[0,-1,0],[0,0,1]],true],
	["Land_BagFence_Short_F",[5373.561,17911.545,78.06],[[-1,-0.01,0],[0,0,1]],false],
	//["Land_BagFence_Short_F",[5371.79,17914.232,82.13],[[0.02,-1,0],[0,0,1]],false],
	["Land_WaterTank_02_F",[5386.27,17936.5,79.46],[[-0.04,1,0],[0,0,1]],true],
	["Land_MobileRadar_01_radar_F",[5396.41,17941,84.22],[[0,1,0],[0,0,1]],false],
	["Land_MedicalTent_01_wdl_generic_inner_F",[5418.05,17885.5,77.44],[[0,1,0.03],[-0.06,-0.03,1]],true],
	["Land_MedicalTent_01_wdl_generic_inner_F",[5406.06,17884.7,77.43],[[0,1,0],[0.05,0,1]],true],
	["Land_AirConditioner_04_F",[5408.1,17891.8,76.71],[[-0.74,0.67,0.04],[0.01,-0.05,1]],false],
	["WaterPump_01_forest_F",[5427.29,17909.4,77.65],[[0,1,0.03],[0.01,-0.03,1]],true],
	["Land_LampShabby_F",[5412.38,17889.4,79.82],[[0,1,0],[0,0,1]],true],
	["Land_Communication_F",[5401.83,17905.3,93.35],[[0,1,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",100,true];}],
	["CargoNet_01_barrels_F",[5405.75,17934.1,77.76],[[0,1,0.02],[-0.05,-0.02,1]],false],
	["B_CargoNet_01_ammo_F",[5405.99,17937.7,77.98],[[0,1,-0.02],[0,0.02,1]],false],
	["FlexibleTank_01_forest_F",[5403.32,17934.1,77.64],[[0,1,0.02],[-0.05,-0.02,1]],false],
	["FlexibleTank_01_forest_F",[5402.69,17933.3,77.59],[[0,1,0.02],[-0.05,-0.02,1]],false],
	["Land_PowerGenerator_F",[5407.36,17934.8,78.02],[[0.01,-1,0.02],[0,0.02,1]],false],
	["Land_MedicalTent_01_wdl_generic_inner_F",[5414.03,17938.1,78.5],[[0,1,-0.04],[0.01,0.04,1]],true],
	["Land_AirConditioner_03_F",[5409.93,17931.9,77.79],[[0.06,-1,-0.02],[-0.01,-0.03,1]],false],
	["Land_LampHalogen_F",[5405.88,17941,83.36],[[-1,-0.01,0],[0,0,1]],true],
	["Land_LampAirport_F",[5423.61,17940.6,89.87],[[0,1,0],[0,0,1]],true],
	["Land_LampAirport_F",[5431.79,17876.6,88.21],[[0,1,0],[0,0,1]],true],
	["Land_ScrapHeap_1_F",[5430.81,17884.7,76.54],[[0,1,0.03],[0.01,-0.03,1]],false],
	["Land_TankEngine_01_used_F",[5430.35,17889.2,76.9],[[1,-0.06,-0.03],[0.03,-0.01,1]],false],
	["Land_BagBunker_01_small_green_F",[5435.07,17932.4,78.17],[[-1,0.03,0.02],[0.02,-0.02,1]],false],
	["Land_ControlTower_01_F",[5431.75,17912.9,84.09],[[0.07,1,0],[0,0,1]],true],
	["Land_BarGate_01_open_F",[5436.31,17923.9,80.91],[[1,0,0],[0,0,1]],true],
	["Land_LampShabby_F",[5436.25,17917,80.33],[[0,1,0],[0,0,1]],true]
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
	[[5379.50,17892.40,76.3136],15],
	[[5374.54,17873.00,74.5840],05],
	[[5405.22,17886.30,76.0924],05],
	[[5441.50,17912.60,75.9943],05],
	[[5456.22,17929.70,76.3055],05],
	[[5406.09,17924.40,76.7721],20],
	[[5377.80,17895.10,83.1478],02],
	[[5365.22,17906.50,80.2393],02],
	[[5390.69,17907.00,80.6757],02]
];

//CHARLIE 2 SPECIFIC
{
	_x hideObject true;
	[_x,false] remoteExecCall ["allowDamage",0];
	[_x,true] remoteExecCall ["hideObjectGlobal",2];
	_hide pushBack _x;
} forEach nearestObjects [_place,["Land_Factory_Main_F"],_rad,true];

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
	[[5392.09,17881.5,77.2519],359.043,20],
	[[5418.44,17885.3,76.0804],356.87,10]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmiss2Objects = [_place,_rad,_nos,_ts,[],[],_vd,_hide];
BRPVP_pmiss2Spawning = false;