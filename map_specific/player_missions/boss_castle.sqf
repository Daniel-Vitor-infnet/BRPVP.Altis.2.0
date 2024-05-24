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

BRPVP_pmissEndCheckObjects = [];

//MISSION
_pmissGroups = [
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_ard_F",[3202.5,13101.3,5.4],65,[1],"STAND",[]],
			["I_Soldier_AR_F",[3215.9,13094.7,0],0,[],"STAND",[["LMG_Mk200_LP_BI_F","","acc_pointer_IR","",["200Rnd_65x39_cased_Box",200],[],"bipod_03_F_blk"],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["9Rnd_45ACP_Mag",2,9],["HandGrenade",1,1],["SmokeShell",1,1]]],["V_PlateCarrierIA2_dgtl",[["200Rnd_65x39_cased_Box",2,200],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA_camo","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[
			["I_HMG_02_high_F",[3196,13105.2,40],[[-0.31,-0.94,-0.17],[0.56,-0.32,0.77]],[],[["I_soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_ard_F",[3195.4,13091.3,21.4],177,[1],"STAND",[]],
			["I_ghillie_lsh_F",[3204.1,13097.5,25.5],0,[1],"STAND",[]],
			["I_ghillie_ard_F",[3206.2,13118,22.6],68,[1],"STAND",[]],
			["I_ghillie_lsh_F",[3199.9,13110,24.5],206,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_ard_F",[3066.2,13171,16.9],138,[1],"STAND",[]],
			["I_Soldier_AR_F",[3058.1,13175.1,15.3],99,[1],"STAND",[["LMG_Mk200_LP_BI_F","","acc_pointer_IR","",["200Rnd_65x39_cased_Box",200],[],"bipod_03_F_blk"],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["9Rnd_45ACP_Mag",2,9],["HandGrenade",1,1],["SmokeShell",1,1]]],["V_PlateCarrierIA2_dgtl",[["200Rnd_65x39_cased_Box",2,200],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA_camo","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_AR_F",[3069.1,13177.8,15.2],212,[1],"STAND",[]],
			["I_E_soldier_M_F",[3060.2,13172.3,12.3],91,[1],"STAND",[["arifle_MSBS65_Mark_SOS_LP_BI_F","","acc_pointer_IR","optic_SOS",["30Rnd_65x39_caseless_msbs_mag",30],[],"bipod_01_F_blk"],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",5,30],["11Rnd_45ACP_Mag",2,11],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],[],"H_HelmetHBK_F","G_Lowprofile",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_E_soldier_M_F",[3058.2,13176.5,12.8],45,[1],"STAND",[]],
			["I_E_Soldier_AR_F",[3069.1,13178.3,12.7],248,[1],"STAND",[]],
			["I_ghillie_ard_F",[3060,13181.2,18.5],323,[1],"STAND",[]]
		],
		[
			["I_HMG_02_high_F",[3068.4,13177.4,67.4],[[0.87,0.49,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_static_AA_F",[3058.5,13172.9,66.7],[[-0.31,-0.95,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_F",[3058.7,13173.3,61.9],[[0.79,0.61,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_E_Soldier_F",[2989.1,13150.2,0.6],105,[1],"STAND",[]]
		],
		[
			["I_HMG_02_high_F",[3075.5,13086.9,70.1],[[0.44,0.9,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_HMG_02_high_F",[2978.2,13154.8,58.7],[[1,-0.01,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]]
		],
		[]
		],
	[
		INDEPENDENT,
		[],
		[
			["I_support_MG_F",[2998.8,13285.5,3.6],0,[1],"STAND",[]],
			["I_support_AMG_F",[2988.8,13285.5,4.4],0,[1],"STAND",[["arifle_Mk20C_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_tshirt",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_Chestrig_oli",[["30Rnd_556x45_Stanag",4,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["I_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["I_HMG_01_support_F",[]],"H_HelmetIA","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[
			["I_HMG_02_high_F",[2963,13245.8,43.1],[[1,0.03,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_HMG_02_high_F",[2989.3,13294.2,35.9],[[0.24,-0.97,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_E_APC_tracked_03_cannon_F",[2977.8,13249.5,41.4],[[0.98,-0.19,-0.03],[0.07,0.22,0.97]],[],[["I_E_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_Sharpshooter_F",[3183.9,13150.5,0.3],270,[1],"STAND",[["srifle_DMR_06_camo_khs_F","","","optic_KHS_old",["20Rnd_762x51_Mag",20],[],""],[],[],["U_IG_leader",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["SmokeShell",1,1],["SmokeShellGreen",1,1],["HandGrenade",1,1]]],["V_BandollierB_oli",[["20Rnd_762x51_Mag",6,20],["Chemlight_blue",2,1]]],[],"H_Booniehat_oli","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_G_HMG_02_high_F",[3158.7,13161.9,50.8],[[-0.78,-0.62,-0.13],[-0.14,-0.04,0.99]],[],[["I_G_Soldier_F",["turret",[0]],[],[]]]],
			["I_static_AA_F",[3184.9,13152.9,54.9],[[0,1,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_static_AA_F",[3189.1,13147.4,54.9],[[0.55,-0.83,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_HMG_02_high_F",[3118.3,13176.8,50.4],[[0.96,-0.27,0],[0.01,0.02,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_E_SAM_System_03_F",[3064.8,13164.2,53.9],[[-0.94,0.33,-0.07],[0.03,0.28,0.96]],[],[["I_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_Boat_Armed_01_minigun_F",[3037.1,13374.3,2.3],[[0,1,0.02],[0.04,-0.02,1]],[],[["I_soldier_F",["driver"],[],[]],["I_soldier_F",["turret",[0]],[],[]],["I_soldier_F",["turret",[1]],[],[]]]]
		],
		[
			[[3036.98,13374.4,3.36139],"MOVE"],
			[[2773.05,13542.4,-0.0576979],"MOVE"],
			[[3096.84,13916.4,-0.00850187],"MOVE"],
			[[3313.6,13524.1,0.0219767],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_Boat_Armed_01_minigun_F",[2942.5,12925.9,2.5],[[0,1,0.02],[0.02,-0.02,1]],[],[["I_soldier_F",["driver"],[],[]],["I_soldier_F",["turret",[0]],[],[]],["I_soldier_F",["turret",[1]],[],[]]]]
		],
		[
			[[2942.41,12926,3.27071],"MOVE"],
			[[3185.08,12743.7,0.1284],"MOVE"],
			[[2616.89,12895.7,0.0108484],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_APC_tracked_03_cannon_F",[3109.6,13204.6,48.7],[[0.97,-0.24,-0.07],[0.11,0.15,0.98]],[],[["I_crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_TL_F",[3060.9,13134.8,0],0,[],"STAND",[["arifle_Mk20_GL_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,9],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["1Rnd_SmokePurple_Grenade_shell",1,1]]],[],"H_HelmetIA","G_Shades_Blue",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_AT_F",[3065.9,13129.8,0],0,[],"STAND",[]],
			["I_Soldier_AT_F",[3055.9,13129.8,0],0,[],"STAND",[]]
		],
		[],
		[
			[[3060.88,13134.8,0.0121155],"MOVE"],
			[[3143.88,13155.2,0.242641],"MOVE"],
			[[3024.58,13157.8,0.000469208],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_SL_F",[3128.7,13207.1,0],0,[],"STAND",[["arifle_Mk20_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA2_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["I_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA","G_Lowprofile",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_soldier_F",[3133.7,13202.1,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA1_dgtl",[["30Rnd_556x45_Stanag",6,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_LAT_F",[3123.7,13202.1,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA2_dgtl",[["30Rnd_556x45_Stanag",2,30],["9Rnd_45ACP_Mag",2,9],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["I_Fieldpack_oli_LAT",[["NLAW_F",2,1]]],"H_HelmetIA","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_M_F",[3138.7,13197.1,0],0,[],"STAND",[]],
			["I_Soldier_TL_F",[3118.7,13197.1,0],0,[],"STAND",[["arifle_Mk20_GL_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,9],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["1Rnd_SmokePurple_Grenade_shell",1,1]]],[],"H_HelmetIA","G_Lowprofile",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[3128.66,13207.1,0.00257874],"MOVE"],
			[[3030.45,13139.5,0],"MOVE"],
			[[3163.34,13153.7,-3.8147e-006],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_E_Soldier_TL_F",[3168.7,13156.3,0],209,[],"STAND",[]],
			["I_E_Soldier_AR_F",[3166.7,13163.1,0],203,[],"STAND",[]],
			["I_E_Soldier_GL_F",[3175.5,13158.2,0],209,[],"STAND",[["arifle_MSBS65_GL_ico_pointer_f","","acc_pointer_IR","optic_ico_01_f",["30Rnd_65x39_caseless_msbs_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1],["SmokeShell",1,1],["SmokeShellBlue",1,1]]],["V_CarrierRigKBT_01_heavy_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",3,30],["11Rnd_45ACP_Mag",2,11],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["Chemlight_blue",1,1]]],[],"H_HelmetHBK_chops_F","G_Squares_Tinted",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_E_RadioOperator_F",[3171.8,13160.8,0],209,[],"STAND",[["arifle_MSBS65_ico_pointer_f","","acc_pointer_IR","optic_ico_01_f",["30Rnd_65x39_caseless_msbs_mag",30],[],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_shortsleeve_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",3,30],["11Rnd_45ACP_Mag",2,11],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],["B_RadioBag_01_eaf_F",[]],"H_HelmetHBK_ear_F","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_E_Soldier_GL_F",[3190.8,13121.1,0],167,[],"STAND",[]],
			["I_E_Soldier_F",[3188.9,13121.7,0],167,[],"STAND",[["arifle_MSBS65_ico_pointer_f","","acc_pointer_IR","optic_ico_01_f",["30Rnd_65x39_caseless_msbs_mag",30],[],""],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",7,30],["11Rnd_45ACP_Mag",2,11],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],[],"H_HelmetHBK_F","G_Sport_Blackred",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[3190.76,13121.1,-0.000934601],"MOVE"],
			[[3193.11,13102.9,8.01086e-005],"MOVE"],
			[[3181.35,13122.3,0.174896],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_E_Soldier_GL_F",[3134.8,13238.2,1.9],0,[],"STAND",[]],
			["I_E_Soldier_F",[3139.8,13233.2,0],0,[],"STAND",[]]
		],
		[
			["I_HMG_02_high_F",[3138.2,13244.2,51],[[-0.03,-1,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_G_Offroad_01_armed_F",[3120.3,13234.7,46.7],[[0.4,-0.92,0],[-0.09,-0.04,0.99]],[],[["I_G_Soldier_F",["turret",[0]],[],[]]]]
		],
		[
			[[3134.77,13238.2,1.87607],"MOVE"],
			[[3065.32,13246.5,0],"MOVE"],
			[[3087.56,13269.4,4.57764e-005],"MOVE"],
			[[3110.79,13221.7,-3.8147e-006],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_SL_F",[3046.4,13175,0],0,[],"STAND",[["arifle_Mk20_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA2_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["I_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_soldier_F",[3051.4,13170,0],0,[],"STAND",[]],
			["I_Soldier_LAT_F",[3041.4,13170,0],0,[],"STAND",[]],
			["I_Soldier_A_F",[3054,13178.7,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA1_dgtl",[["30Rnd_556x45_Stanag",8,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["I_Fieldpack_oli_Ammo",[["FirstAidKit",4],["30Rnd_556x45_Stanag",8,30],["200Rnd_65x39_cased_Box",1,200],["NLAW_F",1,1],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",6,1],["20Rnd_762x51_Mag",3,20]]],"H_HelmetIA_net","G_Lowprofile",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[3046.35,13175,0.0151367],"MOVE"],
			[[2999.18,13179.3,0.000141144],"MOVE"],
			[[3012.71,13125.6,0],"MOVE"],
			[[3091.86,13117.3,-0.000389099],"MOVE"],
			[[3057.18,13152.7,-0.000267029],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_Sharpshooter_F",[3141.1,13145,0.1],316,[1],"STAND",[["srifle_DMR_06_camo_khs_F","","","optic_KHS_old",["20Rnd_762x51_Mag",20],[],""],[],[],["U_IG_leader",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["SmokeShell",1,1],["SmokeShellGreen",1,1],["HandGrenade",1,1]]],["V_BandollierB_oli",[["20Rnd_762x51_Mag",6,20],["Chemlight_blue",2,1]]],[],"H_Booniehat_khk_hs","G_Bandanna_beast",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_G_Offroad_01_armed_F",[3125.1,13145.3,52.1],[[0.68,0.71,-0.17],[0.09,0.15,0.98]],[],[["I_G_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_ard_F",[3084,13283.9,18.6],270,[1],"STAND",[]],
			["I_ghillie_ard_F",[3093.6,13275.9,16],121,[1],"STAND",[]]
		],
		[
			["I_HMG_02_high_F",[3085,13273.5,50.9],[[-0.39,-0.92,-0.04],[0.04,-0.06,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_E_HMG_02_high_F",[3147.5,13080.9,102.6],[[-0.5,-0.87,-0.05],[0.03,-0.08,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[3152.6,13084,102.6],[[1,-0.05,0],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_E_Officer_Parade_Veteran_F",[3049.4,13202.3,18.4],92,[1,2],"STAND",[]],
			["I_Officer_Parade_F",[3050.4,13200.1,18.4],0,[1,2],"STAND",[]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_HMG_02_high_F",[3205.7,13186.7,82],[[0.96,0.28,0.02],[-0.02,-0.01,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_HMG_02_high_F",[3202.1,13182.3,82],[[0.33,-0.95,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_HMG_01_F",[3178.8,13185,51.6],[[0,1,-0.01],[-0.13,0.01,0.99]],[],[["I_soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_TL_F",[3015.3,13137.1,0],0,[],"STAND",[["arifle_Mk20_GL_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,9],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["1Rnd_SmokePurple_Grenade_shell",1,1]]],[],"H_HelmetIA","G_Sport_Checkered",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_support_MG_F",[3020.3,13132.1,0],0,[],"STAND",[]],
			["I_support_AMG_F",[3010.3,13132.1,0],0,[],"STAND",[]]
		],
		[],
		[
			[[3015.35,13137.1,0.00980759],"MOVE"],
			[[3145.66,13170,0],"MOVE"],
			[[3063.8,13117.6,0.000118256],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_E_Heli_light_03_dynamicLoadout_F",[3069.1,13109.3,65.1],[[-0.94,0.34,-0.06],[-0.06,0.02,1]],[],[["I_E_Helipilot_F",["driver"],[],[]],["I_E_Helipilot_F",["turret",[0]],[],[]]]]
		],
		[
			[[3069.26,13109.4,0.00157166],"MOVE"],
			[[3294.04,13596.2,218.368],"MOVE"],
			[[3055.58,12760.4,218.359],"MOVE"],
			[[2817.15,13501.9,203.025],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [];
_doors = [];
_delete = [];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["Land_Castle_01_tower_F",[3049.72,13201.9,56.1261],[[-0.942189,0.335078,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_PortableDesk_01_sand_F",[3051.78,13202.6,64.41],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_DeskChair_01_sand_F",[3050.82,13203.4,64.29],[[0.95,-0.3,0],[0,0,1]],false],
	["Land_Laptop_Intel_02_F",[3051.66,13202.5,65.02],[[-0.95,0.32,0],[0,0,1]],false],
	["Land_Communication_F",[3087.81,13175.8,65.1],[[-0.31,-0.95,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",200,true];}],
	["Land_HBarrierTower_F",[2962.76,13245.8,41.3],[[1,0.04,0],[0,0,1]],false],
	["Land_Castle_01_tower_ruins_F",[2996.89,13134.6,60.02],[[0,1,0],[0,0,1]],false],
	["Land_HBarrierTower_F",[2978.12,13154.9,56.89],[[1,0,0],[0,0,1]],false],
	["Land_MedicalTent_01_NATO_generic_open_F",[2992.98,13276.4,31.88],[[-0.99,-0.15,0.04],[0.02,0.08,1]],true],
	["Land_HBarrierTower_F",[2989.53,13295,34.11],[[0.21,-0.98,0],[0,0,1]],false],
	["Land_i_Stone_HouseSmall_V3_F",[3028.31,13215.6,45.53],[[0,1,0],[0,0,1]],false],
	["Land_i_Stone_Shed_V1_F",[3015.46,13203.8,44.38],[[-1,0,0],[0,0,1]],false],
	["Land_Wreck_BRDM2_F",[3018.35,13274.7,30.89],[[0.99,-0.14,-0.01],[0.02,0.08,1]],false],
	["Land_HBarrier_5_F",[3049.87,13153.8,52.96],[[0.28,0.9,-0.34],[0.04,0.34,0.94]],false],
	["Land_HBarrier_5_F",[3045.2,13167.5,49.63],[[0.85,-0.51,0.14],[0.01,0.29,0.96]],false],
	["Land_HBarrier_5_F",[3050.99,13150.1,54.07],[[-0.96,0.28,-0.06],[0.04,0.34,0.94]],false],
	["Land_HBarrier_5_F",[3042.78,13163,51.01],[[-0.92,0.34,-0.19],[-0.09,0.27,0.96]],false],
	["Land_HBarrier_5_F",[3046.45,13157.4,52.24],[[0.94,0.33,-0.1],[0.04,0.18,0.98]],false],
	["Land_HBarrier_3_F",[3044.28,13160.2,51.78],[[-0.38,-0.92,0.14],[-0.09,0.18,0.98]],false],
	["Land_HBarrier_5_F",[3059.12,13184.6,47.59],[[-0.33,-0.94,0.13],[-0.02,0.15,0.99]],false],
	["Land_HBarrier_5_F",[3046.16,13191.2,46.22],[[0.99,0.11,0.1],[-0.11,0.05,0.99]],false],
	["Land_HBarrier_5_F",[3053.86,13186.4,47.16],[[-0.33,-0.94,0.03],[-0.02,0.04,1]],false],
	["Land_HBarrier_5_F",[3048.45,13187.8,46.62],[[0.16,0.99,-0.03],[-0.11,0.05,0.99]],false],
	["Land_TentHangar_V1_F",[3030.6,13182.6,48.65],[[1,-0.02,0],[0,0,1]],true],
	["Land_MultiScreenComputer_01_closed_sand_F",[3051.88,13204,64.96],[[0.53,0.22,-0.82],[0.09,0.94,0.31]],false],
	["Land_HBarrierTower_F",[3075.28,13087.1,68.29],[[0.39,0.92,0],[0,0,1]],true],
	["Land_HBarrier_5_F",[3080.89,13138.7,55.73],[[0.4,-0.9,0.18],[0.25,0.29,0.92]],false],
	["Land_HBarrier_5_F",[3075.99,13138.6,57.21],[[0.39,0.86,-0.32],[0.21,0.26,0.94]],false],
	["Land_Pallet_F",[3089.06,13166.9,49.59],[[-0.18,-0.98,0.03],[-0.05,0.04,1]],false],
	["Land_GarbageBags_F",[3069.21,13168.6,49.73],[[0,-1,0.05],[0.01,0.05,1]],false],
	["Land_WaterTank_F",[3071.33,13161.2,50.85],[[-0.92,0.39,0.02],[0.12,0.23,0.97]],true],
	["Land_HBarrier_5_F",[3072.38,13142.5,56.25],[[0.9,0.36,-0.25],[0.1,0.39,0.92]],false],
	["Land_HBarrier_5_F",[3069.05,13146.8,54.7],[[0.71,0.64,-0.3],[0.07,0.36,0.93]],false],
	["Land_HBarrier_5_F",[3064.68,13149.7,54.06],[[-0.35,-0.88,0.31],[0.07,0.31,0.95]],false],
	["Land_HBarrier_5_F",[3086.88,13147.5,53.28],[[0.92,-0.39,0.05],[0.02,0.16,0.99]],false],
	["Land_HBarrier_5_F",[3062.37,13147.4,54.76],[[-0.99,0.14,0.01],[0.07,0.39,0.92]],false],
	["Land_HBarrier_5_F",[3077.21,13169.7,49.83],[[-0.92,0.39,-0.03],[0,0.06,1]],false],
	["Land_HBarrier_5_F",[3084.57,13142.3,54.39],[[0.9,-0.43,0.02],[0.08,0.22,0.97]],false],
	["Land_HBarrier_5_F",[3089.78,13152,52.1],[[0.75,-0.66,0.11],[0.08,0.25,0.96]],false],
	["Land_HBarrier_5_F",[3075.48,13159.4,50.92],[[-0.91,0.42,-0.07],[0.03,0.23,0.97]],false],
	["Land_BarrelEmpty_F",[3068.73,13159.3,51.51],[[0.25,-0.94,0.24],[0.19,0.29,0.94]],false],
	["Land_BarrelSand_grey_F",[3067.87,13158.7,51.85],[[-0.66,-0.67,0.34],[0.19,0.29,0.94]],false],
	["Land_PaperBox_open_empty_F",[3076.01,13149.1,53.43],[[-0.15,-0.95,0.27],[0.09,0.26,0.96]],false],
	["Land_PaperBox_closed_F",[3078.14,13149.5,53.17],[[0.67,0.7,-0.25],[0.09,0.26,0.96]],false],
	["Land_Pallets_stack_F",[3089.68,13168.7,49.88],[[0.77,-0.63,0.06],[-0.05,0.04,1]],false],
	["Land_PortableLight_double_F",[3080.31,13140.2,55.89],[[-0.45,0.89,0],[0,0,1]],true],
	["Land_PortableLight_double_F",[3066.24,13166,50.89],[[0.32,0.95,0],[0,0,1]],true],
	["Land_HBarrier_5_F",[3076.54,13173.8,49.57],[[-0.38,-0.92,0.1],[0,0.11,0.99]],false],
	["Land_HBarrier_5_F",[3072.9,13177.3,49.06],[[-0.95,-0.31,0],[-0.03,0.11,0.99]],false],
	["Land_HBarrier_5_F",[3064.48,13182.8,48.07],[[-0.33,-0.94,0.13],[-0.03,0.14,0.99]],false],
	["Land_HBarrier_5_F",[3069.67,13181,48.46],[[-0.33,-0.94,0.13],[-0.03,0.14,0.99]],false],
	["Land_ToiletBox_F",[3075.81,13171.5,50.06],[[0.35,0.93,-0.1],[0,0.11,0.99]],false],
	["Land_ToiletBox_F",[3073.42,13172.4,49.91],[[0.35,0.93,-0.09],[-0.03,0.11,0.99]],false],
	["Land_Tyres_F",[3080.33,13170.3,49.42],[[-0.7,-0.71,0.07],[0,0.11,0.99]],false],
	["Land_Cargo_Tower_V3_F",[3063.02,13175.1,60.73],[[0.28,0.96,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_PortableLight_double_F",[3071.43,13175.7,49.53],[[-0.94,-0.35,0],[0,0,1]],true],
	["Land_Cargo_Tower_V3_F",[3088.72,13279,44.28],[[-0.03,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;BRPVP_pmissBossCastleTower = _this;}],
	["Land_HBarrier_5_F",[3091.5,13156.8,51.09],[[-0.99,-0.13,0.04],[0.03,0.09,1]],false],
	["Land_HBarrier_5_F",[3092.59,13167.4,50.53],[[-0.96,-0.29,0.02],[0,0.07,1]],false],
	["Land_HBarrier_5_F",[3092.2,13162.1,50.71],[[-0.93,0.38,-0.05],[-0.04,0.03,1]],false],
	["Land_Sacks_heap_F",[3100.31,13180.7,48.9],[[-0.73,-0.68,-0.01],[-0.02,0.01,1]],false],
	["Land_CratesShabby_F",[3098.9,13181.3,49.23],[[-0.31,-0.95,0.01],[-0.02,0.01,1]],false],
	["Land_WoodenBox_F",[3099.57,13183.2,48.47],[[1,0,0.03],[-0.03,0.01,1]],false],
	["Land_WoodenBox_F",[3101.15,13183.7,48.51],[[0.76,-0.65,0.03],[-0.03,0.01,1]],false],
	["Land_CanisterPlastic_F",[3116.86,13178.8,49.06],[[0.77,0.64,-0.01],[0.01,0.01,1]],false],
	["Land_Garbage_square3_F",[3109.46,13181.7,48.74],[[0.63,0.78,0],[-0.01,0.01,1]],false],
	["Land_Axe_fire_F",[3111.26,13181.1,48.74],[[-0.43,-0.9,0],[-0.01,0.01,1]],false],
	["Land_Bandage_F",[3116.46,13178,48.75],[[0.71,-0.7,0],[0.01,0.01,1]],false],
	["Land_Bandage_F",[3116.56,13178.1,48.74],[[-0.72,-0.7,0.01],[0.01,0.01,1]],false],
	["Land_PainKillers_F",[3105.88,13179.7,48.7],[[-0.42,-0.91,0],[-0.01,0.01,1]],false],
	["Land_BakedBeans_F",[3109.5,13182.6,48.74],[[-0.77,-0.64,0],[-0.01,0.01,1]],false],
	["Land_BakedBeans_F",[3109.65,13182.6,48.75],[[0.11,-0.99,0.01],[-0.01,0.01,1]],false],
	["Land_GasCanister_F",[3116.64,13177.9,48.77],[[-0.86,-0.5,0.01],[0.01,0.01,1]],false],
	["Land_DuctTape_F",[3111.04,13179.8,48.74],[[-0.8,-0.6,0],[-0.01,0.01,1]],false],
	["Land_Canteen_F",[3105.85,13180,48.79],[[-0.89,-0.45,-0.01],[-0.01,0.01,1]],false],
	["Land_Canteen_F",[3111.34,13179.6,48.85],[[-1,0.06,-0.01],[-0.01,0.01,1]],false],
	["Land_ButaneCanister_F",[3116.68,13178.2,48.82],[[-0.41,-0.91,0.01],[0.01,0.01,1]],false],
	["Land_Matches_F",[3108.94,13178.9,48.71],[[-0.42,-0.91,0],[-0.01,0.01,1]],false],
	["Land_Ammobox_rounds_F",[3108.75,13176.3,48.85],[[-0.84,-0.55,0.01],[-0.01,0.04,1]],false],
	["Land_Ammobox_rounds_F",[3109.11,13176.2,48.86],[[-0.98,0.18,-0.02],[-0.01,0.04,1]],false],
	["Land_WoodPile_F",[3111.03,13182.2,48.96],[[-0.64,0.77,-0.01],[-0.01,0.01,1]],false],
	["Land_Campfire_F",[3108.69,13179.9,48.91],[[-0.74,-0.68,-0.01],[-0.01,0.01,1]],false],
	["Land_Sleeping_bag_F",[3107.31,13176.7,48.74],[[0.38,0.92,-0.03],[-0.01,0.04,1]],false],
	["Land_Sleeping_bag_F",[3108.41,13183.3,48.69],[[0.05,-1,0.01],[-0.01,0.01,1]],false],
	["Land_Sleeping_bag_F",[3105.45,13178.7,48.68],[[0.94,0.34,0.01],[-0.01,0.01,1]],false],
	["Land_Sleeping_bag_brown_F",[3111.82,13178.7,48.76],[[-0.93,0.36,-0.01],[-0.01,0.01,1]],false],
	["Land_Sleeping_bag_brown_F",[3105.67,13181.7,48.67],[[0.83,-0.56,0.01],[-0.01,0.01,1]],false],
	["Land_Sleeping_bag_brown_F",[3110.13,13176.7,48.78],[[-0.42,0.91,-0.04],[-0.01,0.04,1]],false],
	["Land_BagFence_Short_F",[3118.29,13178.8,49.12],[[-0.37,-0.93,0.01],[0.01,0.01,1]],false],
	["Land_BagFence_Short_F",[3117.09,13175.4,49.19],[[-0.32,-0.95,0.02],[0.01,0.02,1]],false],
	["Land_BagFence_Round_F",[3119.88,13177.5,49.12],[[-0.9,-0.44,0.01],[0.01,0.01,1]],false],
	["Land_BagFence_Round_F",[3119.16,13175.3,49.18],[[-0.48,0.88,-0.02],[0.01,0.02,1]],false],
	["Land_Mi8_wreck_F",[3091.64,13209.5,49.18],[[0.79,-0.62,-0.02],[0.06,0.04,1]],false],
	["Land_ReservoirTower_F",[3149.59,13084.4,88.55],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_GuardBox_01_smooth_F",[3140.36,13145.3,49.36],[[-0.65,0.76,0],[0,0,1]],false],
	["Land_BagFence_Short_F",[3143.32,13198,47.18],[[0.75,-0.66,0.07],[-0.07,0.03,1]],false],
	["Land_BagFence_Short_F",[3141.81,13197.2,47.09],[[0.01,-1,0.03],[-0.08,0.03,1]],false],
	["Land_BagFence_Short_F",[3143.76,13199.4,47.15],[[-0.98,-0.19,-0.04],[-0.05,0.05,1]],false],
	["Land_Sacks_heap_F",[3137.7,13216.6,45.88],[[0.38,0.92,0.13],[-0.14,-0.08,0.99]],false],
	["Land_WoodenBox_F",[3133.96,13208.7,45.71],[[0.7,-0.7,0.11],[-0.03,0.12,0.99]],false],
	["Land_Sack_F",[3140.53,13201.9,46.84],[[0.31,0.95,0.01],[-0.08,0.02,1]],false],
	["Land_Basket_F",[3139.53,13201.7,46.72],[[0.31,-0.95,0.05],[-0.08,0.02,1]],false],
	["Land_CanisterPlastic_F",[3131.72,13216.5,45.2],[[-0.9,-0.44,-0.02],[-0.03,0.01,1]],false],
	["Land_CanisterPlastic_F",[3131.25,13215.6,45.2],[[-0.28,-0.96,0],[-0.03,0.01,1]],false],
	["Land_BottlePlastic_V2_F",[3134.94,13216.4,45.21],[[0.95,0.27,0.14],[-0.13,-0.08,0.99]],false],
	["Land_CerealsBox_F",[3135.46,13216.3,45.31],[[0.92,0.37,0.16],[-0.14,-0.08,0.99]],false],
	["Land_CerealsBox_F",[3135.64,13216.2,45.32],[[0.99,-0.05,0.14],[-0.14,-0.08,0.99]],false],
	["Land_GasCooker_F",[3137.21,13215.8,45.46],[[0.75,-0.66,0.05],[-0.14,-0.08,0.99]],false],
	["Land_Camping_Light_F",[3135.56,13205.1,46.04],[[0.78,-0.55,0.29],[0.57,0.82,0.03]],false],
	["Land_BagFence_Long_F",[3133.84,13217.5,45.45],[[-0.03,1,0.07],[-0.12,-0.08,0.99]],false],
	["Land_BagFence_Long_F",[3136.76,13217.5,45.85],[[-0.03,1,0.07],[-0.14,-0.08,0.99]],false],
	["Land_TinContainer_F",[3136.24,13205.9,46.04],[[0.08,-0.02,-1],[-0.38,-0.93,-0.01]],false],
	["Land_RiceBox_F",[3134.7,13216.4,45.15],[[0.77,0.62,0.14],[-0.12,-0.08,0.99]],false],
	["Land_RiceBox_F",[3134.89,13216.2,45.15],[[-0.13,0.99,0.06],[-0.12,-0.08,0.99]],false],
	["Land_CanisterFuel_F",[3132.19,13203.2,46.03],[[0.58,0.81,0.03],[-0.08,0.02,1]],false],
	["Land_Shovel_F",[3132.48,13216.1,44.93],[[0.6,0.8,-0.1],[0.03,0.1,0.99]],false],
	["Land_Axe_F",[3132.24,13204.3,45.76],[[-0.92,-0.38,-0.07],[-0.08,0.02,1]],false],
	["Land_WoodenLog_F",[3135.95,13205.5,46.28],[[0.93,0.36,0.07],[-0.06,-0.04,1]],false],
	["Land_TentA_F",[3141.01,13207.2,46.97],[[1,0.05,0.08],[-0.08,0.02,1]],false],
	["Land_TentA_F",[3140.01,13210.8,46.54],[[0.84,0.54,0.09],[-0.14,0.06,0.99]],false],
	["Land_TentA_F",[3140.54,13203.3,47],[[0.88,-0.47,0.08],[-0.08,0.02,1]],false],
	["Land_BakedBeans_F",[3134.68,13216.2,45.09],[[0.61,0.78,0.14],[-0.12,-0.08,0.99]],false],
	["Land_DuctTape_F",[3131.91,13215.8,44.9],[[0.99,-0.17,0.03],[-0.03,0.01,1]],false],
	["Land_Canteen_F",[3138.87,13203.1,46.42],[[0.29,0.96,0],[-0.08,0.02,1]],false],
	["Land_Canteen_F",[3136.52,13216.3,45.43],[[-0.33,0.94,0.03],[-0.14,-0.08,0.99]],false],
	["Land_WoodPile_F",[3131.36,13204.1,45.93],[[0.02,1,-0.02],[-0.08,0.02,1]],false],
	["Land_Campfire_F",[3135.66,13207,46.17],[[0.45,0.89,0.02],[-0.08,0.02,1]],true],
	["Land_BagFence_Round_F",[3139.26,13216.9,46.16],[[-0.67,-0.72,-0.15],[-0.14,-0.08,0.99]],false],
	["Land_BagFence_Round_F",[3131.22,13216.8,45.26],[[0.69,-0.72,0.03],[-0.03,0.01,1]],false],
	["Land_HBarrierTower_F",[3138.18,13244.3,49.18],[[-0.02,-1,0],[0,0,1]],false],
	["Land_CanisterPlastic_F",[3160.69,13163.5,49.71],[[0.65,-0.75,0.1],[-0.14,0.01,0.99]],false],
	["Land_Axe_fire_F",[3162.88,13169.1,49.53],[[-0.91,0.41,-0.12],[-0.11,0.03,0.99]],false],
	["Land_Bandage_F",[3160.02,13163.7,49.29],[[-0.71,0.7,-0.1],[-0.14,0.01,0.99]],false],
	["Land_Bandage_F",[3159.91,13163.8,49.27],[[-0.67,-0.73,-0.09],[-0.14,0.01,0.99]],false],
	["Land_GasCanister_F",[3159.87,13163.7,49.3],[[-0.52,0.85,-0.08],[-0.14,0.01,0.99]],false],
	["Land_DuctTape_F",[3161.57,13169.3,49.38],[[-0.61,0.78,-0.1],[-0.11,0.03,0.99]],false],
	["Land_Canteen_F",[3161.42,13169,49.48],[[0.03,1,-0.03],[-0.11,0.03,0.99]],false],
	["Land_ButaneCanister_F",[3160.09,13163.6,49.38],[[-0.91,0.38,-0.13],[-0.14,0.01,0.99]],false],
	["Land_WoodPile_F",[3164.02,13169.4,49.89],[[0.74,0.66,0.06],[-0.11,0.03,0.99]],false],
	["Land_Sleeping_bag_brown_F",[3160.49,13168.5,49.28],[[0.33,0.94,0.01],[-0.11,0.03,0.99]],false],
	["Land_BagFence_Short_F",[3160.81,13162,49.77],[[-0.93,0.35,-0.11],[-0.14,-0.05,0.99]],false],
	["Land_BagFence_Short_F",[3157.32,13163.1,49.33],[[-0.95,0.3,-0.04],[-0.04,0.01,1]],false],
	["Land_BagFence_Round_F",[3159.53,13160.4,49.51],[[-0.47,0.88,-0.03],[-0.11,-0.03,0.99]],false],
	["Land_BagFence_Round_F",[3157.3,13161.1,49.29],[[0.86,0.5,0.05],[-0.04,-0.03,1]],false],
	["Land_Sacks_heap_F",[3162.17,13180,49.58],[[-0.7,0.71,-0.09],[-0.05,0.07,1]],false],
	["Land_CratesShabby_F",[3162.69,13181.4,49.87],[[-0.96,0.28,-0.07],[-0.05,0.07,1]],false],
	["Land_WoodenBox_F",[3164.64,13180.9,49.25],[[0.03,-1,0.07],[-0.05,0.07,1]],false],
	["Land_WoodenBox_F",[3165.18,13179.3,49.39],[[-0.62,-0.78,0.03],[-0.05,0.07,1]],false],
	["Land_Garbage_square3_F",[3163.4,13170.9,49.63],[[0.79,-0.61,0.07],[-0.11,-0.04,0.99]],false],
	["Land_PainKillers_F",[3161.33,13174.5,49.47],[[-0.92,0.4,-0.05],[-0.05,0.03,1]],false],
	["Land_BakedBeans_F",[3164.38,13170.9,49.72],[[-0.66,0.75,-0.05],[-0.05,0.03,1]],false],
	["Land_BakedBeans_F",[3164.32,13170.8,49.73],[[-0.99,-0.14,-0.04],[-0.05,0.03,1]],false],
	["Land_Canteen_F",[3161.61,13174.5,49.57],[[-0.48,0.88,-0.05],[-0.05,0.03,1]],false],
	["Land_Matches_F",[3160.63,13171.4,49.29],[[-0.91,0.4,-0.09],[-0.11,-0.04,0.99]],false],
	["Land_Ammobox_rounds_F",[3157.89,13171.1,49.06],[[0.15,0.99,0.06],[-0.11,-0.04,0.99]],false],
	["Land_Campfire_F",[3161.6,13171.7,49.62],[[-0.69,0.72,-0.05],[-0.11,-0.04,0.99]],true],
	["Land_Sleeping_bag_F",[3160.36,13174.9,49.39],[[0.36,-0.93,0.04],[-0.05,0.03,1]],false],
	["Land_Sleeping_bag_F",[3165.07,13172,49.69],[[-1,-0.08,-0.05],[-0.05,0.03,1]],false],
	["Land_Sleeping_bag_F",[3158.37,13172.9,49.11],[[0.93,-0.36,0.09],[-0.11,-0.04,0.99]],false],
	["Land_Sleeping_bag_brown_F",[3163.39,13174.7,49.54],[[-0.54,-0.84,0],[-0.05,0.03,1]],false],
	["Land_Sleeping_bag_brown_F",[3158.42,13170.1,49],[[0.89,0.44,0.12],[-0.11,-0.04,0.99]],false],
	["Land_ControlTower_01_F",[3199.86,13093.7,56.92],[[-1,0.03,0],[0,0,1]],true],
	["Land_GuardTower_02_F",[3201.21,13101.3,40.02],[[0.99,-0.1,0],[0,0,1]],true],
	["Land_HBarrierWall4_F",[3196.99,13106.4,38.86],[[0.98,-0.17,-0.07],[0.06,-0.05,1]],false],
	["Land_HBarrierWall4_F",[3203.31,13102.2,36.86],[[0.99,-0.16,0.02],[-0.03,-0.02,1]],false],
	["Land_ControlTower_01_F",[3202.17,13114.1,57.7],[[0,1,0],[0,0,1]],true],
	["Land_GuardHouse_02_grey_F",[3186.09,13149.9,52.41],[[0.03,1,0],[0,0,1]],false],
	["Land_ReservoirTower_F",[3202.2,13185.8,67.99],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}]
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
			[_x,false] remoteExecCall ["allowDamage",0];
			[_x,true] remoteExecCall ["hideObjectGlobal",2];
			_hide pushBack _x;
		};
	} forEach nearestObjects [ASLToAGL _pw,[],_rad,true];
	uiSleep _noLagWait;
} forEach [
	[[3024.67,13189.6,44.9236],10],
	[[3049.72,13201.9,56.1261],02]
];

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
					_suitCase setVariable ["mny",round (7000000*BRPVP_missionValueMult),true];
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
	[[3034.18,13187.1,44.3373],36,15],
	[[3038.6,13178.9,44.9043],104,15],
	[[3058.64,13170.9,63.3463],17,50]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,_hide,{true}];


//SPECIAL BOSS CASTLE
private _options = [];
private _sel = selectRandom [5,6,7,8,9];
private _denied = ["O_T_VTOL_02_infantry_dynamicLoadout_F","B_T_VTOL_01_vehicle_F","B_T_VTOL_01_armed_F","RHS_TU95MS_vvs_old","rhs_9k79"];
{
	_x params ["_label","_menu1","_menu2","_class","_name","_value",["_missNumber",-1]];
	if (_missNumber isEqualTo _sel && !(_class in _denied)) then {_options pushBack [_value,_class];};
} forEach BRPVP_tudoA3;
_options sort true;
_options = _options apply {_x select 1};
if (_options isNotEqualTo []) then {
	uiSleep 5;
	private _toSpawn = selectRandom _options;
	private _vehObj = createVehicle [_toSpawn,[0,0,0],[],200,"CAN_COLLIDE"];
	uiSleep 0.001;
	_vehObj allowDamage false;
	[_vehObj,false] remoteExecCall ["allowDamage",-clientOwner];
	_vehObj lock true;
	_vehObj setVectorUp [-0.0397903,0.0941705,0.994761];
	_vehObj setDir 40;
	_vehObj setPosASL [3146.86,13172.9,48.1735];
	_vehObj setVariable ["brpvp_veh_godmode",true,true];
	_vehObj setVariable ["brpvp_veh_miss_lvl",_sel,true];
	private _isDrone = _toSpawn in BRPVP_vantVehiclesClass;
	if (_isDrone) then {
		if (BRPVP_dronesMakeAllUnarmed) then {
			{
				_vehObj setPylonLoadout [configName _x,""];
			} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _vehObj >> "Components" >> "TransportPylonsComponent" >> "pylons"));
		};
	};
	_vehObj setVariable ["brpvp_no_tow",true,true];
	_vehObj setVariable ["brpvp_cant_heli_town",true,true];
	clearWeaponCargoGlobal _vehObj;
	clearMagazineCargoGlobal _vehObj;
	clearItemCargoGlobal _vehObj;
	clearBackpackCargoGlobal _vehObj;
	waitUntil {
		uiSleep 1;
		{alive _x} count BRPVP_pmissActualAiUnits <= 5;
	};
	[_vehObj,false] remoteExecCall ["lock",_vehObj];
	private _joiner = objNull;
	private _cycle = if (_isDrone) then {0.25} else {0.1};
	private _init = time;
	waitUntil {
		if (time-_init > _cycle) then {
			_init = time;
			if (_isDrone) then {
				_joiner = ((_vehObj nearEntities [BRPVP_playerModel,10])+[objNull]) select 0;
			} else {
				_joiner = objNull;
				{if (_x call BRPVP_isPlayer) exitWith {_joiner = _x;};} forEach crew _vehObj;
			};
		};
		(!isNull _joiner && {_joiner getVariable ["sok",false]}) || !alive _vehObj || isNull BRPVP_pmissBossCastleTower
	};
	"ugranted" remoteExecCall ["BRPVP_playSound",_joiner];
	if (alive _vehObj && (!isNull _joiner && {_joiner getVariable ["sok",false]})) then {
		_vehObj setVariable ["own",_joiner getVariable "id_bd",true];
		_vehObj setVariable ["stp",_joiner getVariable "dstp",true];
		_vehObj setVariable ["amg",[_joiner getVariable "amg",[],true],true];
		_vehObj setVariable ["brpvp_locked",false,true];
		if (!_isDrone) then {
			_vehObj setVariable ["brpvp_from_vg_time",serverTime+180,true];
			_vehObj setVariable ["brpvp_cant_safe_time",serverTime+180,true];
		};
		private _estadoCons = [
			[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],
			[getPosWorld _vehObj,[vectorDir _vehObj,vectorUp _vehObj]],
			typeOf _vehObj,
			_vehObj getVariable "own",
			_vehObj getVariable "stp",
			_vehObj getVariable "amg",
			"",
			[0,0,0,0,0,0],
			_vehObj call BRPVP_getVehicleAmmo,
			_vehObj call BRPVP_getHitpointsDamage
		];
		[false,_vehObj,_estadoCons] remoteExecCall ["BRPVP_adicionaConstrucaoBd",2];
		_vehObj setVariable ["brpvp_no_tow",false,true];
		_vehObj setVariable ["brpvp_cant_heli_town",false,true];
		_vehObj spawn {
			uiSleep 60;
			[_this,true] remoteExecCall ["allowDamage",0];
			_this setVariable ["brpvp_veh_godmode",false,true];
			_this remoteExecCall ["BRPVP_setAirGodMode",_this];
		};
	} else {
		if (isNull BRPVP_pmissBossCastleTower) then {deleteVehicle _vehObj;};
	};
};
BRPVP_pmissSpawning = false;