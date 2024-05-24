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

_place = _this select 0;
_rad = _this select 1;
_skill = _this select 2;

_pFix = [0,0,0];
_pFix2D = [0,0,0];

BRPVP_pmissEndCheckObjects = [];

_pmissGroups = [
	[
		WEST,
		[],
		[
			["B_W_Soldier_SL_F",[11681.3,8771.4,0.2],355,[1],"STAND",[["arifle_MX_Black_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_black_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_vest_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_wdl",[["30Rnd_65x39_caseless_black_mag",1,30],["30Rnd_65x39_caseless_black_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetSpecB_wdl","G_Combat",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["B_W_Officer_F",[11678.9,8767.8,0.2],153,[1],"STAND",[]],
			["B_W_Soldier_AR_F",[11678.7,8774,0.2],355,[1],"STAND",[["arifle_MX_SW_Black_Pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_black_mag",100],[],"bipod_01_F_blk"],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_tshirt_mcam_wdL_f",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_wdl",[["100Rnd_65x39_caseless_black_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_plain_wdl","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["B_W_Soldier_LAT_F",[11681,8763,0.2],33,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_wdl",[["30Rnd_65x39_caseless_black_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_wdl_BWLAT_F",[["NLAW_F",2,1]]],"H_HelmetB_plain_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["B_W_Soldier_LAT2_F",[11681.3,8760.3,0.2],79,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],["launch_MRAWS_green_F","","","",["MRAWS_HEAT_F",1],[],""],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_wdl",[["30Rnd_65x39_caseless_black_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_wdl_BWLAT2_F",[["MRAWS_HEAT_F",2,1],["MRAWS_HE_F",1,1]]],"H_HelmetB_plain_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_Sniper_F",[11664.4,8836.6,4.4],0,[1],"STAND",[]],
			["B_T_ghillie_tna_F",[11664.6,8833.1,4.2],252,[1],"STAND",[]],
			["B_T_Recon_F",[11669.3,8835.1,0],0,[1],"STAND",[["arifle_MX_khk_ACO_Pointer_Snds_F","muzzle_snds_H_khk_F","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_SL_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_khaki_mag",7,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_Watchcap_camo","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Officer_Parade_F",[11727.4,8760.4,17.6],0,[1,2],"STAND",[]]
		],
		[
			["B_T_HMG_01_F",[11726.2,8751.8,74.9],[[0,1,-0.03],[0,0.03,1]],[],[["B_T_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_Engineer_F",[11825.7,8786.8,0],0,[],"STAND",[["arifle_MXC_khk_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_SL_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_khaki_mag",3,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_Kitbag_rgr_BTEng_F",[["ToolKit",1],["MineDetector",1],["SatchelCharge_Remote_Mag",1,1],["DemoCharge_Remote_Mag",2,1]]],"H_HelmetB_tna_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]],
			["B_T_Soldier_SL_F",[11821.6,8786.6,0],0,[],"STAND",[["arifle_MX_khk_Hamr_Pointer_F","","acc_pointer_IR","optic_Hamr_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_tna_F",[["30Rnd_65x39_caseless_khaki_mag",1,30],["30Rnd_65x39_caseless_khaki_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_Enh_tna_F","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]],
			["B_T_Soldier_GL_F",[11824.2,8789.9,0],0,[],"STAND",[["arifle_MX_GL_khk_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_tna_F",[["30Rnd_65x39_caseless_khaki_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetB_Enh_tna_F","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]]
		],
		[],
		[
			[[11821.6,8786.56,0.0115089],"MOVE"],
			[[11819.1,8785.97,0],"MOVE"],
			[[11770.8,8777.54,0],"MOVE"],
			[[11785,8848.42,0],"MOVE"],
			[[11825.8,8793.71,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[11786.3,8795.3,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AT_F",[11792.4,8798.7,0],0,[],"STAND",[["arifle_MXC_Holo_pointer_F","","acc_pointer_IR","optic_Holosight",["30Rnd_65x39_caseless_mag",30],[],""],["launch_B_Titan_short_F","","","",["Titan_AT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_mcamo_AT",[["Titan_AT",2,1]]],"H_HelmetB_light_desert","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AT_F",[11786.7,8803,0],0,[],"STAND",[["arifle_MXC_Holo_pointer_F","","acc_pointer_IR","optic_Holosight",["30Rnd_65x39_caseless_mag",30],[],""],["launch_B_Titan_short_F","","","",["Titan_AT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_mcamo_AT",[["Titan_AT",2,1]]],"H_HelmetB_light_desert","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AAT_F",[11797.4,8793.7,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Carryall_mcamo_AAT",[["Titan_AT",2,1],["Titan_AP",2,1]]],"H_HelmetB_light","G_Tactical_Clear",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[11786.3,8795.28,0.00808334],"MOVE"],
			[[11782.6,8793.25,0],"MOVE"],
			[[11765.8,8731.26,0],"MOVE"],
			[[11766.5,8857.89,0.000312805],"MOVE"],
			[[11782,8796.09,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[11787.6,8856.7,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_F",[11792.6,8851.7,0],0,[],"STAND",[]],
			["B_soldier_LAT_F",[11782.6,8851.7,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_M_F",[11797.6,8846.7,0],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_TL_F",[11777.6,8846.7,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[11787.6,8856.67,0.00782013],"MOVE"],
			[[11788.3,8849.89,0],"MOVE"],
			[[11706.4,8690.33,3.8147e-006],"MOVE"],
			[[11791,8847.86,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_AAA_F",[11796.5,8909.5,3.5],261,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_black_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Carryall_wdl_BWAAA_F",[["Titan_AA",3,1]]],"H_HelmetB_light_wdl","G_Combat",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["B_W_Soldier_LAT_F",[11802.5,8911.3,3.3],0,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_wdl",[["30Rnd_65x39_caseless_black_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_wdl_BWLAT_F",[["NLAW_F",2,1]]],"H_HelmetB_plain_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[
			["B_T_Static_AA_F",[11797.6,8903.8,38.3],[[0,1,0],[0,0,1]],[],[["B_T_Soldier_F",["turret",[0]],[],[["arifle_MX_khk_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_tna_F",[["30Rnd_65x39_caseless_khaki_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB_tna_F","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_Mortar_01_F",[11763.8,8798.5,47.6],[[0.99,-0.07,-0.1],[0.1,0.1,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_Mortar_01_F",[11763.8,8795.9,47.8],[[0.99,-0.14,-0.09],[0.1,0.1,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_GL_F",[11758.8,8760.6,0],0,[],"STAND",[]],
			["B_W_Engineer_F",[11754,8761.3,0],0,[],"STAND",[["arifle_MXC_Black_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_65x39_caseless_black_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_vest_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_black_mag",3,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_Kitbag_rgr_BTEng_F",[["ToolKit",1],["MineDetector",1],["SatchelCharge_Remote_Mag",1,1],["DemoCharge_Remote_Mag",2,1]]],"H_HelmetB_plain_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[
			["B_MRAP_01_gmg_F",[11757.6,8756.8,53.4],[[0.97,-0.23,-0.01],[0.03,0.09,1]],[4],[["B_Soldier_F",["driver"],[],[]],["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_AR_F",[11790.8,8924.2,4.4],0,[1],"STAND",[]],
			["B_W_Soldier_AR_F",[11794.2,8924.4,4.2],0,[1],"STAND",[["arifle_MX_SW_Black_Pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_black_mag",100],[],"bipod_01_F_blk"],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_tshirt_mcam_wdL_f",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_wdl",[["100Rnd_65x39_caseless_black_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_plain_wdl","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[
			["B_HMG_01_high_F",[11776.4,8922.5,37.4],[[0,1,-0.03],[0.01,0.03,1]],[],[["B_Soldier_F",["turret",[0]],[],[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_F",[11759.7,8726,4.2],202,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_wdl",[["30Rnd_65x39_caseless_black_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB_plain_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["B_W_Soldier_LAT_F",[11756.3,8726.7,4.2],177,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_wdl",[["30Rnd_65x39_caseless_black_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_wdl_BWLAT_F",[["NLAW_F",2,1]]],"H_HelmetB_plain_wdl","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[
			["B_HMG_01_high_F",[11774,8724.3,58.2],[[-0.22,-0.97,0.09],[0.01,0.09,1]],[],[["B_Soldier_F",["turret",[0]],[],[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_GMG_01_high_F",[11819.2,8883.3,55.3],[[-0.14,-0.99,-0.04],[0.09,-0.06,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_GMG_01_high_F",[11820.9,8893.4,55.3],[[-0.32,0.95,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_F",[11823.3,8856.9,0],0,[],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_wdl",[["30Rnd_65x39_caseless_black_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB_plain_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[11823.3,8856.94,-0.000408173],"MOVE"],
			[[11860.5,8841.88,3.8147e-006],"MOVE"],
			[[11824.9,8933.41,0],"MOVE"],
			[[11822,8860.2,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_W_Soldier_F",[11849.9,8823.7,0],22,[1],"STAND",[["arifle_MX_Black_ACO_Pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_black_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["30Rnd_65x39_caseless_black_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_wdl",[["30Rnd_65x39_caseless_black_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB_plain_wdl","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_ghillie_tna_F",[11796,8740.4,4.3],195,[1],"STAND",[]],
			["B_T_Spotter_F",[11797.8,8743.3,4.6],41,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[11723.9,8777.3,0],0,[],"STAND",[]],
			["B_soldier_AR_F",[11728.9,8772.3,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_GL_F",[11718.9,8772.3,0],0,[],"STAND",[]],
			["B_soldier_LAT_F",[11734,8776.4,0],0,[],"STAND",[]]
		],
		[],
		[
			[[11723.9,8777.27,0.0040741],"MOVE"],
			[[11768,8861.78,4.57764e-005],"MOVE"],
			[[11809.3,8777.67,0.000171661],"MOVE"],
			[[11736.1,8763.88,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_SAM_System_02_F",[11818.4,8888.6,64.6],[[-0.54,0.84,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_AAA_System_01_F",[11788.5,8817.9,52.7],[[-0.97,0.23,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	//[
	//	WEST,
	//	[],
	//	[],
	//	[
	//		["B_Radar_System_01_F",[11796.2,8803.1,47.3],[[0.29,0.95,-0.13],[0.1,0.1,0.99]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
	//	],
	//	[]
	//],
	[
		WEST,
		[],
		[],
		[
			["I_APC_Wheeled_03_cannon_F",[11772.4,8817.7,46.2],[[0.45,-0.89,0.1],[0.07,0.15,0.99]],[1,2,4],[["B_crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["O_Heli_Attack_02_dynamicLoadout_F",[11799.5,8862.3,40.5],[[-0.99,-0.1,-0.13],[-0.13,0.04,0.99]],[],[["B_Pilot_F",["driver"],[],[]],["B_Pilot_F",["turret",[0]],[],[]]]]
		],
		[
			[[11800,8862.34,0.0034523],"MOVE"],
			[[11334.9,8935.86,159.769],"MOVE"],
			[[11665,8468.8,151.589],"MOVE"],
			[[12314.7,8948.74,171.346],"MOVE"],
			[[11598.3,9278.84,172.692],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	//["O_MRAP_02_F",[13764.7,17752.7,17.4],[[0.34,0.94,-0.03],[0.05,0.01,1]]]
]; 
_doors = [];
_delete = [];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["Land_Communication_F",[11769.4,8804.53,62.24],[[0.97,-0.23,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",150,true];}],
	["Land_Target_Line_01_F",[11586.5,8717,81.21],[[0.9,0.43,0],[0,0,1]],false],
	["Land_Target_Line_PaperTargets_01_F",[11585.2,8777.53,77.67],[[0.98,-0.18,0],[0,0,1]],false],
	["Land_Target_Line_01_F",[11626.4,8753.06,70.07],[[-0.99,-0.14,0],[0,0,1]],false],
	["Land_Target_Line_01_F",[11618.7,8761.33,71.42],[[1,-0.01,0],[0,0,1]],false],
	["Land_Target_Pistol_01_F",[11636.3,8781.65,66.19],[[-0.95,0.3,0],[0,0,1]],false],
	["Land_Target_Line_PaperTargets_01_F",[11614.3,8766.72,72.43],[[-1,0.02,0],[0,0,1]],false],
	["Land_Target_Line_PaperTargets_01_F",[11634.3,8768.56,67.14],[[-1,-0.05,0],[0,0,1]],false],
	["Land_Target_Pistol_01_F",[11659.4,8752.73,63.54],[[-0.92,-0.39,0],[0,0,1]],false],
	["Land_Target_Line_PaperTargets_01_F",[11649.2,8756.33,64.65],[[-0.98,-0.18,0],[0,0,1]],false],
	["Land_Target_Line_01_F",[11654.2,8766.51,63.4],[[-0.99,0.13,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V4_F",[11665.5,8834.61,60.01],[[1,0.05,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_BagBunker_01_large_green_F",[11678.5,8760.93,60.42],[[0.99,0.09,-0.13],[0.13,0.05,0.99]],false],
	["Land_BagBunker_01_large_green_F",[11677.9,8770.7,60.03],[[0.99,0.05,-0.13],[0.13,0.05,0.99]],false],
	["Land_Cargo_Tower_V1_No1_F",[11725.7,8753.41,66.1],[[0.43,-0.9,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Snake_random_F",[11712.5,8742.7,55.92],[[0,1,0],[0,0,1]],false],
	["Land_PillboxBunker_01_big_F",[11702.2,8763.92,57.32],[[-0.99,-0.04,0.16],[0.16,0.07,0.99]],false],
	["Land_Campfire_F",[11716,8802.27,52.12],[[0,0.99,-0.13],[0.09,0.13,0.99]],true],
	["Land_CzechHedgehog_01_new_F",[11757.4,8720.44,56.09],[[-0.63,-0.76,0.15],[0.05,0.15,0.99]],false],
	["Land_CzechHedgehog_01_new_F",[11759.3,8720.42,55.99],[[-0.63,-0.76,0.15],[0.05,0.15,0.99]],false],
	["Land_CzechHedgehog_01_new_F",[11755.4,8720.89,56.13],[[-0.63,-0.76,0.15],[0.05,0.15,0.99]],false],
	["Land_Mil_WallBig_4m_F",[11755.5,8723.2,56.64],[[0.09,1,0],[0,0,1]],false],
	["Land_Mil_WallBig_4m_F",[11759.4,8722.89,56.48],[[0.09,1,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V1_F",[11758.3,8727.46,59.14],[[0.2,0.98,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Razorwire_F",[11741.6,8723.3,56.2],[[0,0.99,-0.11],[0.05,0.11,0.99]],false],
	["Land_Razorwire_F",[11749.5,8723.1,55.96],[[0,0.99,-0.13],[0.02,0.13,0.99]],false],
	["CamoNet_BLUFOR_F",[11736.7,8789.64,52.48],[[0,1,0.03],[0.11,-0.03,0.99]],true],
	["Land_Device_assembled_F",[11734.8,8789.05,52.13],[[0,1,0.03],[0.11,-0.03,0.99]],false],
	["Land_TankEngine_01_F",[11738,8788.46,51.78],[[0,1,0.03],[0.12,-0.03,0.99]],false],
	["Land_Bomb_Trolley_01_F",[11732.3,8788.2,52.39],[[0,1,0.01],[0.15,-0.01,0.99]],false],
	["Land_HBarrierBig_F",[11755.8,8789.9,49.84],[[-0.95,0.27,0.13],[0.15,0.07,0.99]],false],
	["Land_HBarrier_5_F",[11758.8,8785.64,49.23],[[0.23,0.97,-0.11],[0.15,0.07,0.99]],false],
	["Land_Pallets_stack_F",[11754.9,8814.94,47.45],[[0.22,0.97,-0.13],[0.29,0.06,0.95]],false],
	["Land_PaperBox_closed_F",[11755.5,8812.83,47.59],[[0.63,-0.77,-0.14],[0.29,0.06,0.95]],false],
	["Land_PaperBox_closed_F",[11753.9,8810.37,48.33],[[-0.93,0.31,0.2],[0.23,0.05,0.97]],false],
	["Land_PortableLight_double_F",[11758.1,8794.5,49.05],[[-0.96,-0.27,0],[0,0,1]],true],
	["Land_WaterTank_F",[11756.5,8800.69,48.5],[[0.2,0.97,-0.11],[0.2,0.07,0.98]],true],
	["Land_WaterTank_F",[11757.3,8803.83,48.01],[[0.2,0.97,-0.14],[0.23,0.1,0.97]],true],
	["Land_HBarrierBig_F",[11754.1,8797.41,49.74],[[-0.75,-0.62,0.21],[0.2,0.09,0.98]],false],
	["Land_HBarrierBig_F",[11752.3,8805.31,49.52],[[-0.96,0.27,0.09],[0.11,0.05,0.99]],false],
	["Land_HBarrierBig_F",[11758.1,8807.28,48.04],[[0.22,0.96,-0.19],[0.29,0.12,0.95]],false],
	["Land_HBarrier_5_F",[11748.7,8815.77,48.7],[[-0.96,0.28,0.07],[0.11,0.11,0.99]],false],
	["Land_HBarrier_5_F",[11747.2,8810.3,49.34],[[-0.96,0.25,0.09],[0.11,0.05,0.99]],false],
	["Land_PortableLight_double_F",[11756,8827.04,46.6],[[-0.54,0.84,0],[0,0,1]],true],
	["Land_Cargo_Tower_V2_ruins_F",[11732.5,8842.06,52.64],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_HBarrierBig_F",[11750.5,8822.61,48.34],[[0.97,-0.23,0.01],[0.02,0.13,0.99]],false],
	["Land_HBarrierBig_F",[11755,8829.03,46.79],[[0.49,-0.87,-0.05],[0.28,0.1,0.96]],false],
	["CamoNet_BLUFOR_F",[11743.1,8874.57,44.16],[[-0.95,0.31,0.06],[0.07,0.03,1]],true],
	["Land_HBarrier_5_F",[11757.6,8863.92,41.94],[[0.95,-0.17,-0.28],[0.29,0.07,0.95]],false],
	["Land_HBarrier_5_F",[11756.7,8858.34,42.4],[[-0.97,0.15,0.21],[0.21,-0.02,0.98]],false],
	["Land_HBarrier_5_F",[11758.3,8869.32,41.16],[[0.97,-0.15,-0.19],[0.2,0.06,0.98]],false],
	["Land_HBarrier_5_F",[11757.7,8853.56,42.7],[[-0.83,-0.51,0.24],[0.21,0.12,0.97]],false],
	["Land_HBarrier_3_F",[11755.4,8875.06,41.52],[[-0.68,0.73,0.09],[0.2,0.07,0.98]],false],
	["Land_HBarrier_1_F",[11751.4,8870.09,42.83],[[0.11,0.98,-0.17],[0.19,0.15,0.97]],false],
	["Land_HBarrier_1_F",[11758.9,8872.18,40.9],[[0.79,0.59,-0.2],[0.2,0.06,0.98]],false],
	["Land_HBarrier_1_F",[11750.4,8860.66,43.64],[[0.11,0.99,0],[0.15,-0.02,0.99]],false],
	["Land_Razorwire_F",[11750.8,8865.33,43.8],[[-0.99,0.11,0],[0,0,1]],false],
	["CamoNet_BLUFOR_open_F",[11751.5,8893.95,41.07],[[-0.99,0.07,0.12],[0.13,0.11,0.99]],true],
	["Land_HBarrier_5_F",[11745.3,8891.75,41.82],[[-0.98,0.06,0.17],[0.17,0.15,0.97]],false],
	["Land_HBarrier_5_F",[11745.6,8897.41,41.11],[[-0.99,0.04,0.13],[0.13,0.09,0.99]],false],
	["Land_HBarrier_5_F",[11745,8886.34,42.65],[[-0.97,0.06,0.23],[0.23,0.11,0.97]],false],
	["Land_HBarrierTower_F",[11774.3,8725.23,56.37],[[0.08,0.99,-0.09],[0.01,0.09,1]],true],
	["Land_Razorwire_F",[11774.7,8718.87,55.69],[[0.13,0.98,-0.14],[0.04,0.13,0.99]],false],
	["Land_Razorwire_F",[11780.9,8721.14,54.93],[[0,1,-0.08],[0.06,0.08,1]],false],
	["Land_BarGate_01_open_F",[11765.6,8722.66,58.77],[[0.05,-1,0],[0,0,1]],true],
	["Land_PortableLight_double_F",[11761.4,8786.3,49.29],[[0.23,0.97,0],[0,0,1]],true],
	["Land_HBarrierBig_F",[11789.5,8786.3,48.11],[[0.23,0.96,-0.15],[0.07,0.13,0.99]],false],
	["Land_HBarrier_5_F",[11764.2,8784.36,48.98],[[0.23,0.97,-0.08],[0.04,0.08,1]],false],
	["Land_HBarrier_5_F",[11767.1,8787.36,48.41],[[-0.96,0.26,0.05],[0.09,0.13,0.99]],false],
	["Land_Cargo_Patrol_V1_F",[11761.8,8789.28,52.85],[[0.22,0.97,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_BarrelTrash_grey_F",[11766.2,8802.02,46.59],[[0.33,0.93,-0.14],[0.11,0.11,0.99]],false],
	["Land_BarrelEmpty_grey_F",[11765.5,8802.35,46.63],[[0.23,0.96,-0.13],[0.11,0.11,0.99]],false],
	["Land_WaterBarrel_F",[11766.8,8803.57,46.51],[[-0.38,-0.92,0.14],[0.11,0.11,0.99]],false],
	["Land_MetalBarrel_F",[11766.7,8802.52,46.49],[[-0.76,0.65,0.01],[0.11,0.11,0.99]],false],
	["Land_HBarrier_5_F",[11777.5,8798.18,46.96],[[-0.84,-0.54,0.08],[0.01,0.13,0.99]],false],
	["Land_HBarrier_5_F",[11777.8,8792.9,47.47],[[-0.97,0.26,-0.01],[0.01,0.09,1]],false],
	["Land_HBarrier_5_F",[11765.1,8805.5,46.66],[[0.23,0.96,-0.15],[0.11,0.12,0.99]],false],
	["Land_HBarrier_5_F",[11774.9,8819.02,44.02],[[-0.88,-0.46,0.13],[0.07,0.14,0.99]],false],
	["Land_HBarrier_5_F",[11788.1,8812.1,44.63],[[0.23,0.96,-0.14],[0.03,0.14,0.99]],false],
	["Land_Cargo20_military_green_F",[11788.7,8799.73,46.72],[[0.56,-0.83,0.02],[0.1,0.09,0.99]],false],
	["CargoPlaftorm_01_green_F",[11789,8817.85,46.46],[[-0.98,0.2,0],[0,0,1]],false],
	["Land_HBarrierBig_F",[11763.3,8830.55,44.38],[[-0.19,-0.97,0.17],[0.22,0.12,0.97]],false],
	["Land_HBarrier_5_F",[11774.7,8824.38,43.3],[[-0.97,0.23,0.03],[0.07,0.13,0.99]],false],
	["Land_HBarrier_5_F",[11789.3,8833.29,41.84],[[-0.2,-0.97,0.12],[0.03,0.12,0.99]],false],
	["Land_HBarrier_5_F",[11772.2,8849.52,40.53],[[-0.16,-0.97,0.19],[0.16,0.16,0.97]],false],
	["Land_PaperBox_closed_F",[11762.4,8866.92,40.47],[[0.97,0.16,-0.2],[0.19,0.06,0.98]],false],
	["Land_PaperBox_closed_F",[11760.6,8867.97,40.74],[[-0.59,0.8,0.07],[0.19,0.06,0.98]],false],
	["Land_PortableLight_double_F",[11776.1,8851.51,40.16],[[0.54,-0.84,0],[0,0,1]],true],
	["Land_PortableLight_double_F",[11763.2,8852.21,42.1],[[-0.15,0.99,0],[0,0,1]],true],
	["Land_GarbageBarrel_01_F",[11776.6,8855.4,39.05],[[0.09,-0.99,0.12],[0.05,0.12,0.99]],false],
	["Land_ToiletBox_F",[11777.4,8856.72,39.39],[[0.98,-0.17,-0.08],[0.11,0.16,0.98]],true],
	["Land_ToiletBox_F",[11777.8,8859.26,38.99],[[0.98,-0.17,-0.09],[0.11,0.13,0.99]],true],
	["Land_WaterTank_F",[11761.2,8854.46,41.69],[[0.16,0.98,-0.15],[0.18,0.13,0.98]],false],
	["Land_HBarrier_5_F",[11765.3,8874.11,40.12],[[0.13,0.99,0],[0,0,1]],false],
	["Land_HBarrier_5_F",[11770.9,8873.31,38.61],[[-0.16,-0.99,0.08],[0.26,0.03,0.96]],false],
	["Land_HBarrier_5_F",[11761.4,8851.23,42.22],[[-0.16,-0.98,0.15],[0.18,0.12,0.98]],false],
	["Land_HBarrier_5_F",[11776.9,8850.48,39.79],[[0.55,-0.83,0.06],[0.07,0.12,0.99]],false],
	["Land_HBarrier_5_F",[11779.3,8854.13,39.21],[[-0.98,0.16,0.09],[0.11,0.16,0.98]],false],
	["Land_HBarrier_5_F",[11776.2,8872.47,37.25],[[-0.16,-0.98,0.12],[0.12,0.11,0.99]],false],
	["Land_HBarrier_5_F",[11780.8,8865.22,37.52],[[0.98,-0.16,-0.09],[0.11,0.09,0.99]],false],
	["Land_HBarrier_5_F",[11780.1,8869.78,37.05],[[0.84,0.52,-0.16],[0.12,0.11,0.99]],false],
	["Land_HBarrier_5_F",[11780.1,8859.72,38.29],[[0.98,-0.16,-0.09],[0.11,0.13,0.99]],false],
	["Land_HBarrier_3_F",[11760.9,8879.06,40.23],[[-0.41,0.91,0.01],[0.15,0.06,0.99]],false],
	["Land_HBarrier_1_F",[11762.4,8874.38,40.19],[[0.85,0.51,-0.16],[0.15,0.06,0.99]],false],
	["Land_TTowerSmall_2_F",[11774.5,8861.76,46.46],[[0.17,0.99,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Patrol_V1_F",[11770.6,8871.89,42.83],[[-0.16,-0.99,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[11762.4,8859.45,41.33],[[-0.99,0.15,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[11775.3,8864.42,38.05],[[0.99,-0.15,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_WaterTower_02_F",[11774.8,8894.81,51.24],[[0,1,0],[0,0,1]],true],
	["Land_HBarrier_1_F",[11767.3,8881.71,39.16],[[0.98,-0.14,-0.11],[0.13,0.09,0.99]],false],
	["Land_HBarrier_1_F",[11776.8,8880.47,36.8],[[0.99,-0.14,-0.1],[0.11,0.07,0.99]],false],
	["Land_Razorwire_F",[11771.8,8881.06,37.9],[[-0.13,-0.98,0.13],[0.29,0.09,0.95]],false],
	["Land_HBarrierTower_F",[11776.5,8922,35.69],[[0.14,-0.99,0.03],[0.01,0.03,1]],false],
	["Land_Razorwire_F",[11774.7,8928.13,34.07],[[0.08,-1,0.03],[0.1,0.04,0.99]],false],
	["Land_BarGate_01_open_F",[11784.4,8926.33,37.5],[[-0.26,0.97,0],[0,0,1]],true],
	["Land_Cargo_Patrol_V4_F",[11795.7,8742.58,54.84],[[-0.88,0.47,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_MedicalTent_01_brownhex_closed_F",[11815.4,8772.33,48.7],[[-0.59,0.8,-0.09],[0.05,0.15,0.99]],true],
	["Land_HBarrierBig_F",[11797.8,8787.66,47.3],[[-0.48,0.87,-0.08],[0.11,0.15,0.98]],false],
	["Land_Cargo_House_V1_F",[11798.4,8764.5,49.5],[[0.69,-0.72,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[11805.7,8769.17,48.81],[[0.69,-0.72,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["CamoNet_ghex_open_F",[11819.5,8809.41,42.67],[[0,0.98,-0.18],[0.08,0.18,0.98]],true],
	["O_supplyCrate_F",[11794.9,8797.93,45.85],[[0,1,-0.08],[0.08,0.08,0.99]],false],
	["Land_ToiletBox_F",[11796.8,8814.3,44.45],[[0.97,-0.23,0],[0.02,0.12,0.99]],true],
	["Land_ToiletBox_F",[11797.4,8816.44,44.19],[[0.97,-0.24,-0.08],[0.11,0.12,0.99]],true],
	["Land_Pallets_F",[11792.3,8813.89,43.78],[[0.13,0.98,-0.15],[0.05,0.14,0.99]],false],
	["Land_HBarrierBig_F",[11801.2,8812.89,44.17],[[0.97,-0.24,-0.08],[0.11,0.12,0.99]],false],
	["Land_HBarrierBig_F",[11802.6,8794.09,46],[[-0.95,0.29,0.08],[0.15,0.22,0.96]],false],
	["Land_HBarrierBig_F",[11795.2,8810.75,44.88],[[-0.2,-0.98,0.09],[0.05,0.08,1]],false],
	["Land_HBarrier_5_F",[11805.6,8806.68,43.7],[[0.97,-0.24,-0.08],[0.1,0.08,0.99]],false],
	["Land_HBarrier_5_F",[11804.2,8801.15,44.24],[[0.97,-0.24,-0.1],[0.12,0.07,0.99]],false],
	["Land_HBarrier_5_F",[11805.6,8815.01,42.86],[[0.25,0.95,-0.18],[0.15,0.14,0.98]],false],
	["Land_Cargo20_military_green_F",[11791,8792.22,47.37],[[0.55,0.82,-0.17],[0.1,0.14,0.99]],false],
	["Land_Cargo20_military_green_F",[11800.4,8798.88,45.68],[[0.97,-0.2,-0.11],[0.14,0.14,0.98]],false],
	["Land_Cargo20_military_green_F",[11790,8808.25,45.7],[[-0.23,-0.96,0.16],[0.1,0.14,0.99]],false],
	["Land_PortableLight_double_F",[11790.9,8831.19,42.35],[[-0.2,-0.98,0],[0,0,1]],true],
	["I_E_CargoNet_01_ammo_F",[11801,8848.53,39.12],[[0,1,-0.08],[-0.03,0.08,1]],false],
	["I_E_CargoNet_01_ammo_F",[11803.5,8848.51,39.19],[[0,1,-0.08],[-0.03,0.08,1]],false],
	["Land_i_Barracks_V1_F",[11818.7,8841.6,37.71],[[-0.98,0.2,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_HBarrierBig_F",[11799.1,8820.77,43.37],[[0.74,0.64,-0.21],[0.13,0.16,0.98]],false],
	["Land_HBarrierBig_F",[11796.9,8828.2,42.44],[[0.97,-0.23,-0.05],[0.08,0.13,0.99]],false],
	["Land_HBarrier_5_F",[11793.7,8832.31,41.67],[[-0.2,-0.97,0.15],[0.08,0.13,0.99]],false],
	["Land_Cargo_Patrol_V1_F",[11790.8,8828.33,46.52],[[-0.2,-0.98,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["I_E_CargoNet_01_ammo_F",[11801,8850.63,38.94],[[0,0.99,-0.1],[-0.03,0.1,0.99]],false],
	["Land_DragonsTeeth_01_4x2_new_F",[11796.7,8877.59,36.76],[[1,-0.03,0.07],[-0.07,0.07,1]],false],
	["PortableHelipadLight_01_red_F",[11794.7,8857.38,37.52],[[0,0.99,-0.1],[0.03,0.1,0.99]],true],
	["PortableHelipadLight_01_red_F",[11805.6,8857.56,38.46],[[0,1,-0.02],[-0.01,0.02,1]],true],
	["PortableHelipadLight_01_red_F",[11794.3,8868.54,36.65],[[0,1,-0.06],[-0.08,0.06,0.99]],true],
	["PortableHelipadLight_01_red_F",[11805.5,8868.55,38.17],[[0,1,-0.04],[0.01,0.04,1]],true],
	["Land_HelipadSquare_F",[11799.9,8863.13,37.44],[[0,1,-0.02],[-0.16,0.02,0.99]],true],
	["Land_Cargo_HQ_V1_F",[11798.7,8908.4,38.05],[[-0.18,0.98,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_No2_F",[11819.1,8888.82,48.69],[[-0.52,0.85,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
	["CargoPlaftorm_01_green_F",[11818.2,8889.06,58.85],[[-0.53,0.85,0],[0,0,1]],false],
	["Land_CzechHedgehog_01_new_F",[11793.9,8930.41,34.98],[[0.45,0.89,0.04],[-0.08,-0.01,1]],false],
	["Land_CzechHedgehog_01_new_F",[11791.9,8930.37,34.83],[[0.45,0.89,0.04],[-0.07,-0.01,1]],false],
	["Land_CzechHedgehog_01_new_F",[11790,8929.99,34.7],[[0.45,0.89,0.05],[-0.1,0,0.99]],false],
	["Land_Mil_WallBig_4m_F",[11794.3,8927.93,35.88],[[0.12,-0.99,0],[0,0,1]],false],
	["Land_Mil_WallBig_4m_F",[11790.5,8927.42,35.6],[[0.12,-0.99,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V1_F",[11792.5,8923.18,38.89],[[0.01,-1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["CamoNet_BLUFOR_big_F",[11835.9,8782.15,47.26],[[0.52,-0.84,0.12],[-0.07,0.1,0.99]],true],
	["Box_NATO_AmmoVeh_F",[11839.9,8784.18,46.13],[[0,1,-0.08],[-0.07,0.08,0.99]],false],
	["CamoNet_INDP_big_F",[11843.4,8800.38,44.88],[[0.98,-0.2,0.02],[0.01,0.14,0.99]],true],
	["Box_EAF_AmmoVeh_F",[11843.3,8795.82,44.33],[[0,0.99,-0.17],[0.02,0.17,0.99]],false],
	["VirtualReammoBox_camonet_F",[11825.3,8809.72,42.64],[[0,0.99,-0.16],[0.01,0.16,0.99]],false],
	["Campfire_burning_F",[11848,8846.51,37.12],[[0,0.98,-0.17],[0.16,0.17,0.97]],true],
	["Land_TTowerBig_1_F",[11835.4,8825.61,57.66],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_PillboxBunker_01_hex_F",[11834.7,8872.6,36.59],[[0.04,-1,-0.01],[0.08,-0.01,1]],false],
	["Land_BagBunker_Tower_F",[11850.1,8824.51,41.8],[[0.25,-0.97,0],[0,0,1]],true]
];

private _ata = [];
private _nos = [];
private _ts = [];
private _vd = [];
private _noLagWait = 0.1;
{
	_x params ["_class","_pw","_vdu","_complete",["_code",{}]];
	private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_obj call _code;
	_nos pushBack _obj;
	uiSleep _noLagWait;
	if (_complete && isDamageAllowed _obj) then {_obj setVariable ["brpvp_yes_minerva",true,true];};
} forEach _pmissBuildings;
{
	_x addEventHandler ["HandleDamage",{
		params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
		private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
		private _deltaDam = _dam-_damNow;
		_damNow+_deltaDam*0.25
	}];
} forEach _pmissBuildingsEh;
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
		if (random 1 <= BRPVP_pmissAiPerc || 2 in _flags) then {
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
					_suitCase setVariable ["mny",round (15000000*BRPVP_missionValueMult),true];
					_this call BRPVP_botDaExp;
				}];
			} else {
				_u setVariable ["brpvp_extra_chance",2];
				_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			};
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			BRPVP_pmissActualAiUnits pushBack _u;
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
				_u disableAI "FSM";
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
				BRPVP_pmissActualAiUnits pushBack _u;
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
				_wp setWaypointCompletionRadius 10;
			} forEach _wps;
			_wp = _grp addWayPoint [(_wps select 0) vectorAdd _pFix2D,0];
			_wp setWayPointType "CYCLE";
			_wp setWaypointCompletionRadius 5;
		} else {
			if (_wps2 isNotEqualTo []) then {
				{
					_wp = _grp addWayPoint [(_x select 0) vectorAdd _pFix2D,0];
					_wp setWayPointType (_x select 1);
					_wp setWaypointCompletionRadius 10;
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
	_box setPosWorld (_posW vectorAdd _pFix);
	_box setDir _dir;
	[_box,0,1,true,_q] call BRPVP_createCompleteLootBox;
	uiSleep _noLagWait;
} forEach [
	[[11821.9,8838.24,38.3192],102.7,40],
	[[11759.1,8859.16,41.3696],098.1,20],
	[[11778.1,8863.14,38.0919],279.4,20]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,[],{true}];
BRPVP_pmissSpawning = false;