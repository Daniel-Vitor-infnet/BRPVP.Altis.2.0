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
		WEST,
		[],
		[],
		[
			["B_MRAP_01_hmg_F",[5540.4,15035.7,30.1],[[1,0.07,0],[0,0,1]],[4],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_MRAP_01_gmg_F",[5425.6,14954.5,30.1],[[0.84,-0.54,0],[0,0,1]],[4],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_LSV_01_AT_F",[5495.7,14990.5,29.2],[[0.88,-0.47,0],[0,0,1]],[4],[["B_Soldier_F",["turret",[0]],[],[]],["B_Soldier_F",["turret",[1]],[],[]]]],
			["B_APC_Wheeled_01_cannon_F",[5467.3,14961.9,29.8],[[0.93,-0.37,0],[0,0,1]],[1,2,4],[["B_crew_F",["turret",[0]],[],[]]]],
			["B_APC_Tracked_01_AA_F",[5495.7,15062.6,30.3],[[0.76,-0.65,0],[0,0,1]],[1,2,4],[["B_crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[5514.3,14979.2,27.4],[[0.74,-0.67,-0.11],[0.05,-0.12,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5482.8,14949.3,29],[[0.9,-0.43,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[5421.2,14944.3,29],[[0.78,-0.63,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[5438.1,15032.2,11.6],131,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_ghillie_lsh_F",[5440.2,15034.8,11.6],124,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_ghillie_lsh_F",[5397.3,15021.4,4.4],205,[1],"STAND",[]]
		],
		[
			["B_static_AA_F",[5440.4,15034.5,42.1],[[0.84,-0.54,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[5438.9,15031.5,42.1],[[0.94,-0.35,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5460.5,15047,31.9],[[0.76,-0.65,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5415.8,15017.8,35.9],[[0.76,-0.65,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5434.4,15015.7,31.9],[[0.76,-0.65,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[5545.9,15043.5,28.6],[[0.76,-0.65,-0.1],[0.06,-0.08,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[5462.2,14935.7,46.9],[[-0.68,0.73,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5469.1,14929.8,46.8],[[0.76,-0.65,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5467.5,14941,46.6],[[-0.06,1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[5531.6,15021.4,46.5],[[-0.82,0.57,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5542.1,15022.1,46.5],[[0.99,0.1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_AFV_Wheeled_01_up_cannon_F",[5627.1,15184,30.8],[[0.79,-0.61,-0.05],[0.01,-0.07,1]],[],[["B_crew_F",["driver"],[],[]],["B_crew_F",["turret",[0]],[],[]],["B_crew_F",["turret",[0,0]],[],[]]]]
		],
		[
			[[5627.06,15184.2,-0.00204277],"MOVE"],
			[[5701.11,15139.8,-1.90735e-006],"MOVE"],
			[[5365.68,14734.6,-3.05176e-005],"MOVE"],
			[[5215.78,14770.3,3.8147e-006],"MOVE"],
			[[5268.81,15094,-0.000205994],"MOVE"],
			[[5537.8,15278.4,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_Heli_Light_01_dynamicLoadout_F",[5490.9,15011.8,29.1],[[0.74,-0.67,0],[0,0,1]],[],[["B_Helipilot_F",["driver"],[],[]],["B_Helipilot_F",["turret",[0]],[],[]]]]
		],
		[
			[[5490.93,15011.9,0.00143814],"MOVE"],
			[[5596.83,14879.1,128.506],"MOVE"],
			[[5318.25,14890.1,115.932],"MOVE"],
			[[5381.13,15159,107.195],"MOVE"],
			[[5731.63,15089.5,157.605],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[5512.8,15020.9,32.1],[[-0.65,-0.76,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[5317.3,15114.9,0],131,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[5505.9,15067.7,4.9],131,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[5642.2,14710.8,7.8],348,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[5410.8,15051,35.9],[[-0.12,-0.99,0.01],[0.01,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Captain_Jay_F",[5440.1,15073.8,8.8],186,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Officer_Parade_F",[5440.3,15063.7,12.7],309,[1,2],"STAND",[[],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_O_ParadeUniform_01_CSAT_F",[["11Rnd_45ACP_Mag",2,11]]],[],[],"H_ParadeDressCap_01_US_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Officer_Parade_Veteran_F",[5445.8,15065.3,12.8],209,[1,2],"STAND",[]],
			["B_ghillie_lsh_F",[5451.6,15069.7,17.9],131,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Captain_Jay_F",[5447,15067.9,1],155,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Captain_Jay_F",[5439.7,15074,0.9],107,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Captain_Jay_F",[5437.5,15066.9,0.9],66,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Captain_Jay_F",[5439.5,15064.4,4.9],352,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Captain_Jay_F",[5443.6,15072.2,4.9],209,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Captain_Jay_F",[5434.8,15067.4,8.8],48,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Captain_Jay_F",[5439.7,15064.4,8.9],355,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Captain_Jay_F",[5442.3,15066.9,12.7],271,[1],"STAND",[["LMG_Mk200_F","muzzle_snds_65_TI_blk_F","acc_pointer_IR","optic_Holosight",["200Rnd_65x39_cased_Box",200],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["16Rnd_9x21_Mag",3,16]]],["V_PlateCarrierH_CTRG",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["200Rnd_65x39_cased_Box",2,200]]],[],"H_Cap_khaki_specops_UK","G_Aviator",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["B_LSV_01_armed_F",[5432.7,15061.4,36.3],[[-0.32,-0.95,0],[0,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]],["B_Soldier_F",["turret",[1]],[],[]]]],
			["B_HMG_01_high_F",[5455.2,15064.8,35.9],[[0.76,-0.65,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5422.5,15076.2,53.7],[[-0.99,0.13,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5445,15064.8,36.7],[[-0.58,-0.82,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5450.5,15070.7,36.7],[[-0.61,-0.79,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5439.5,15065.5,36.7],[[0.67,0.75,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5442.3,15077,36.7],[[0.68,-0.74,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5435,15067.4,40.6],[[0.65,0.76,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5445,15070,40.6],[[-0.89,-0.45,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[5444,15070.1,44.6],[[-0.75,-0.66,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[5549.4,14928.7,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AR_F",[5554.4,14923.7,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_GL_F",[5544.4,14923.7,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[5559.4,14918.7,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[5549.36,14928.7,0.00244522],"MOVE"],
			[[5624.43,15015.7,0.754433],"MOVE"],
			[[5423.42,15134.6,0.720036],"MOVE"],
			[[5340.06,14973.5,0.693123],"MOVE"],
			[[5463.33,14867.6,0.808001],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[5439.6,14962.4,0],352,[],"STAND",[]],
			["B_soldier_AR_F",[5444.6,14957.4,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_HeavyGunner_F",[5434.6,14957.4,0],0,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AAR_F",[5449.6,14952.4,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Kitbag_rgr_AAR",[["optic_tws_mg",1],["bipod_01_F_snd",1],["muzzle_snds_338_sand",1],["muzzle_snds_H",1],["100Rnd_65x39_caseless_mag",2,100],["100Rnd_65x39_caseless_mag_Tracer",2,100],["130Rnd_338_Mag",2,130]]],"H_HelmetB_light","G_Combat",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_M_F",[5429.6,14952.4,0.1],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Sharpshooter_F",[5454.6,14947.4,0],0,[],"STAND",[]],
			["B_soldier_LAT_F",[5424.6,14947.4,0.2],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[5459.6,14942.4,0],0,[],"STAND",[]]
		],
		[],
		[
			[[5439.62,14962.4,0.00143814],"MOVE"],
			[[5525.94,15017.1,0.486942],"MOVE"],
			[[5486.73,15061,2.07647],"MOVE"],
			[[5424.72,14986.1,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_GL_F",[5489.9,15060.4,1.4],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_F",[5494.9,15055.4,0.1],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[5489.91,15060.4,1.42226],"MOVE"],
			[[5422.12,14984.2,3.2701],"MOVE"],
			[[5467.84,14946.6,0.489315],"MOVE"],
			[[5530.66,15025.5,2.013],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_recon_TL_F",[5548.2,15057.1,0],0,[],"STAND",[]],
			["B_recon_M_F",[5553.2,15052.1,0],0,[],"STAND",[]],
			["B_recon_medic_F",[5543.2,15052.1,0],0,[],"STAND",[["arifle_MXC_ACO_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_ReconMedic",[["Medikit",1],["FirstAidKit",5],["SmokeShellRed",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1]]],"H_HelmetB_light","G_Tactical_Clear",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_recon_F",[5558.2,15047.1,0],0,[],"STAND",[["arifle_MX_ACO_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_Watchcap_camo","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[5548.23,15057.1,-0.000274658],"MOVE"],
			[[5601.26,15005,0],"MOVE"],
			[[5472.9,14858.2,0],"MOVE"],
			[[5331.25,14971,0],"MOVE"],
			[[5480.67,15126.3,0],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["B_Truck_01_fuel_F",[5460.5,14989.2,29.2],[[0.65,0.76,0],[0,0,1]]],
	["B_LSV_01_unarmed_F",[5445.5,14981.9,29.5],[[0.93,-0.36,0],[0,0,1]]],
	["B_LSV_01_unarmed_F",[5448.1,14986.2,29.5],[[0.72,-0.69,0],[0,0,1]]],
	["B_Quadbike_01_F",[5453.1,14994.4,28.9],[[0,1,0],[0,0,1]]],
	["B_Quadbike_01_F",[5455.8,14996.3,28.9],[[0,1,0],[0,0,1]]],
	["B_Quadbike_01_F",[5455.4,14999.6,28.9],[[1,0,0],[0,0,1]]],
	["B_Truck_01_transport_F",[5414.6,14965.3,29.6],[[0.66,0.75,0],[0,0,1]]],
	["B_Truck_01_transport_F",[5418.4,14962,29.6],[[0.66,0.75,0],[0,0,1]]],
	["B_Truck_01_covered_F",[5528.4,15010.5,29.3],[[0.62,0.79,0],[0,0,1]]],
	["B_Truck_01_covered_F",[5521.9,15001.4,30.2],[[0.62,0.79,0],[0,0,1]]],
	["B_Truck_01_flatbed_F",[5439.9,14975.3,30],[[0.87,-0.48,0],[0,0,1]]],
	["B_LSV_01_unarmed_F",[5490.4,14983.9,29.5],[[-0.75,0.67,0],[0,0,1]]],
	["B_MRAP_01_F",[5497.8,15041.7,29.5],[[0,1,0],[0,0,1]]],
	["C_Offroad_01_comms_F",[5423.2,15064.5,35.9],[[-0.65,-0.76,0],[0,0,1]]],
	["C_Offroad_01_comms_F",[5425.9,15062.4,35.9],[[-0.65,-0.76,0],[0,0,1]]],
	["C_Offroad_01_comms_F",[5468.1,14973.8,29],[[-0.65,-0.76,0],[0,0,1]]],
	["C_Offroad_01_comms_F",[5464.9,14976.3,29],[[-0.65,-0.76,0],[0,0,1]]],
	["C_Offroad_01_comms_F",[5516.5,15017.1,29],[[-0.65,-0.76,0],[0,0,1]]],
	["C_Van_02_medevac_F",[5465.3,15024.8,29.1],[[0.63,0.77,0],[0,0,1]]]
];
_doors = [];
_delete = [];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["Land_ConcreteWall_01_l_gate_F",[5398.5,15015.8,34.9],[[-0.61,-0.79,0],[0,0,1]],true],
	["Land_Cargo_Patrol_V3_F",[5396.68,15023,38.94],[[0.6,0.8,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Wall_IndCnc_4_F",[5389.04,15029.7,35.18],[[0.97,0.25,0],[0,0,1]],false],
	["Land_Wall_IndCnc_4_F",[5388.44,15031.8,35.42],[[0.97,0.25,0],[0,0,1]],false],
	["Land_BagBunker_Small_F",[5421.09,14944.6,28.27],[[-0.77,0.64,0],[0,0,1]],false],
	["Land_PipeFence_02_s_8m_F",[5422.44,14940.1,27.59],[[0.64,0.76,0],[0,0,1]],false],
	["Land_RoadBarrier_01_F",[5428.14,14940.3,30.54],[[0.77,-0.63,0],[0,0,1]],true],
	["Land_LampAirport_F",[5422.26,14951.6,39.76],[[-0.79,0.61,0],[0,0,1]],true],
	["Land_LampAirport_F",[5408.23,15010,46.66],[[-0.79,0.61,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_generic_inner_F",[5457.28,14956,28.67],[[0.01,1,0],[0,0,1]],true],
	["Land_AirConditioner_04_F",[5453.68,14963.3,27.81],[[-0.73,0.68,0],[0,0,1]],false],
	["CamoNet_INDP_big_F",[5445.1,14986.7,29.94],[[-0.76,0.65,0],[0,0,1]],true],
	["CamoNet_INDP_big_F",[5452.26,14998,29.94],[[-0.76,0.65,0],[0,0,1]],true],
	["Land_EngineCrane_01_F",[5458.59,14994.8,28.32],[[0,1,0],[0,0,1]],false],
	["Land_PortableGenerator_01_sand_F",[5459.05,14998.6,27.68],[[-0.76,-0.66,0],[0,0,1]],false],
	["Land_TripodScreen_01_large_sand_F",[5458.54,15000.9,28.34],[[0.8,-0.6,0],[0,0,1]],false],
	["Land_WaterTank_02_F",[5459.24,15006.7,29.5],[[0.77,-0.64,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampAirport_F",[5454.82,15007.1,39.72],[[-0.79,0.61,0],[0,0,1]],true],
	["MapBoard_altis_F",[5443.26,15059.4,47.77],[[-0.21,-0.98,0],[0,0,1]],false],
	["Land_PortableServer_01_olive_F",[5442.26,15060,47.32],[[-0.66,-0.75,0],[0,0,1]],false],
	["Land_Tablet_02_F",[5441.49,15064.8,47.68],[[0,1,0],[0,0,1]],false],
	["Land_TripodScreen_01_large_black_F",[5441.51,15060.5,47.84],[[0.67,0.74,0],[0,0,1]],false],
	["Land_Router_01_black_F",[5441.18,15065.1,47.76],[[0.66,0.75,0],[0,0,1]],false],
	["Land_PCSet_01_mouse_F",[5440.78,15065.5,47.67],[[0,1,0],[0,0,1]],false],
	["Land_PCSet_01_mouse_F",[5439.9,15064.6,47.67],[[0,1,0],[0,0,1]],false],
	["Land_PCSet_01_keyboard_F",[5440.33,15065,47.65],[[-0.69,0.72,0],[0,0,1]],false],
	["Land_PCSet_01_keyboard_F",[5439.67,15064.3,47.65],[[-0.85,0.52,0],[0,0,1]],false],
	["Land_PCSet_Intel_02_F",[5439.18,15064.1,47.9],[[-0.97,0.24,0],[0,0,1]],false],
	["Land_PCSet_Intel_02_F",[5440.4,15065.5,47.9],[[-0.47,0.88,0],[0,0,1]],false],
	["Land_Laptop_Intel_Oldman_F",[5444.03,15065.5,47.78],[[0.84,0.54,0],[0,0,1]],false],
	["OfficeTable_01_new_F",[5439.48,15064.3,47.22],[[-0.75,0.66,0],[0,0,1]],false],
	["OfficeTable_01_new_F",[5440.37,15065.3,47.22],[[-0.75,0.66,0],[0,0,1]],false],
	["OfficeTable_01_new_F",[5441.34,15064.9,47.22],[[0.66,0.75,0],[0,0,1]],false],
	["Land_OfficeChair_01_F",[5443.32,15064.5,47.47],[[-1,0.03,0],[0,0,1]],false],
	["Land_OfficeChair_01_F",[5440.8,15064.3,47.47],[[0.87,-0.49,0],[0,0,1]],false],
	["Land_OfficeChair_01_F",[5444.85,15066,47.47],[[0,1,0],[0,0,1]],false],
	["Land_OfficeCabinet_01_F",[5447.04,15064.7,47.58],[[0.67,0.74,0],[0,0,1]],false],
	["Land_OfficeCabinet_01_F",[5447.71,15064.1,47.58],[[0.67,0.74,0],[0,0,1]],false],
	["Land_TableDesk_F",[5444.43,15065.1,47.21],[[0.66,0.75,0],[0,0,1]],false],
	["Land_WaterCooler_01_new_F",[5442.49,15068.8,47.53],[[0.68,0.73,0],[0,0,1]],false],
	["Land_FlowerPot_01_Flower_F",[5445.48,15061.5,47.6],[[0,1,0],[0,0,1]],false],
	["Land_FlowerPot_01_Flower_F",[5442.27,15065.2,47.6],[[0,1,0],[0,0,1]],false],
	["Land_File_research_F",[5444.46,15064.9,47.66],[[0,1,0],[0,0,1]],false],
	["Land_PortableServer_01_olive_F",[5442.3,15060,46.97],[[-0.66,-0.75,0],[0,0,1]],false],
	["Land_IPPhone_01_black_F",[5444.89,15064.7,47.65],[[-0.64,-0.77,0.01],[0,0.01,1]],false],

	//["Land_ConcreteWall_03_m_6m_F",[5445.44,15060,48.52],[[-0.75,0.66,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5434.22,15066.5,35.81],[[0.67,0.74,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5446.84,15061.6,48.53],[[-0.75,0.66,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5441.83,15063.6,35.81],[[-0.75,0.66,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5437.59,15063.4,35.81],[[-0.66,-0.75,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5434.25,15066.4,37.27],[[-0.66,-0.75,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5442.92,15064.8,37.29],[[-0.75,0.66,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5442.82,15064.8,35.81],[[-0.75,0.66,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5437.56,15063.4,37.47],[[-0.66,-0.75,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5440.56,15077.5,37.27],[[-0.75,0.66,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5440.46,15077.4,35.81],[[-0.75,0.66,0],[0,0,1]],false],
	//["Land_ConcreteWall_03_m_6m_F",[5441.82,15063.5,37.2],[[-0.75,0.66,0],[0,0,1]],false],
	["Land_ConcreteWall_03_m_6m_F",[5442.83,15069.2,47.53],[[-0.66,-0.75,0],[0,0,1]],false],
	
	//["Land_ConcreteWall_01_l_8m_F",[5435.95,15064.7,40.42],[[-0.64,-0.77,0],[0,0,1]],false],
	//["Land_ConcreteWall_01_l_8m_F",[5435.95,15064.7,44.36],[[-0.64,-0.77,0],[0,0,1]],false],
	//["Land_ConcreteWall_01_l_8m_F",[5435.94,15064.7,35.98],[[-0.64,-0.77,0],[0,0,1]],false],
	//["Land_ConcreteWall_01_l_8m_F",[5441.9,15064.7,35.98],[[0.74,-0.68,0],[0,0,1]],false],

	["Land_PortableLight_double_F",[5444.43,15073.2,36.16],[[-0.91,0.42,0],[0,0,1]],true],
	["Land_PortableLight_double_F",[5452.27,15069.8,36.16],[[0.78,0.63,0],[0,0,1]],true],
	["Land_CampingChair_V2_F",[5439.55,15067.8,47.3],[[-0.74,0.67,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[5439.01,15067.2,47.3],[[-0.74,0.67,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[5440.11,15068.6,47.3],[[-0.74,0.67,0],[0,0,1]],false],
	["Land_CampingChair_V2_F",[5438.47,15066.6,47.3],[[-0.74,0.67,0],[0,0,1]],false],
	["Land_Offices_01_V1_F",[5438.61,15072.3,42.13],[[0.66,0.75,0],[0,0,1]],true],
	["Land_Wall_IndCnc_4_F",[5441.67,15083.7,34.89],[[0.66,0.75,0],[0,0,1]],false],
	["Land_Cargo_Tower_V3_F",[5467.5,14935.3,40.23],[[-0.79,0.62,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_MedicalTent_01_NATO_generic_inner_F",[5474.68,14968.3,28.67],[[-0.77,0.64,0],[0,0,1]],true],
	["Land_WoodenTable_02_large_F",[5470.29,14982.6,27.78],[[0.67,0.74,0],[0,0,1]],false],
	["Land_WoodenTable_02_large_F",[5472.11,14984.6,27.78],[[0.67,0.74,0],[0,0,1]],false],
	["Land_WoodenTable_02_large_F",[5473.95,14986.7,27.78],[[0.67,0.74,0],[0,0,1]],false],
	["Land_MedicalTent_01_NATO_generic_inner_F",[5481.8,14977,28.67],[[-0.76,0.65,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_generic_outer_F",[5488.95,14984.8,28.67],[[-0.76,0.65,0],[0,0,1]],true],
	["Land_AirConditioner_04_F",[5474.16,14979.3,27.81],[[-1,0.08,0],[0,0,1]],false],
	["Land_Communication_F",[5478.75,14996.5,43.86],[[0.75,-0.66,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",125,true];}],
	["Land_MedicalTent_01_NATO_generic_inner_F",[5481.67,15027.3,28.67],[[-0.77,0.64,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_generic_inner_F",[5474.72,15018.6,28.67],[[-0.77,0.64,0],[0,0,1]],true],
	["Land_RepairDepot_01_tan_F",[5463.5,15011.3,29.72],[[-0.64,-0.77,0],[0,0,1]],true],
	["WaterPump_01_sand_F",[5463.35,15002.7,28.37],[[-0.03,-1,0],[0,0,1]],false],
	["Land_AirConditioner_04_F",[5478.68,15012.1,27.81],[[1,0.06,0],[0,0,1]],false],
	["Land_AirConditioner_04_F",[5489.59,15025.3,27.81],[[1,0.06,0],[0,0,1]],false],
	["B_Slingload_01_Fuel_F",[5486.78,15038.3,28.66],[[-0.78,0.62,0],[0,0,1]],true],
	["Land_BagBunker_Small_F",[5513.95,14979.8,26.78],[[-0.74,0.66,0.11],[0.05,-0.12,0.99]],false],
	["Land_RoadBarrier_01_F",[5516.72,14985.1,29.58],[[0.8,-0.6,0],[0,0,1]],true],
	["Land_RoadBarrier_01_F",[5509.4,14975.5,29.45],[[0.78,-0.62,0],[0,0,1]],true],
	["Land_LampAirport_F",[5505.89,14970.1,36.08],[[-0.79,0.61,0],[0,0,1]],true],
	["Land_WoodenTable_02_large_F",[5498.03,15026.4,27.78],[[0.67,0.74,0],[0,0,1]],false],
	["Land_WoodenTable_02_large_F",[5496.08,15024.1,27.78],[[0.67,0.74,0],[0,0,1]],false],
	["Land_HelipadRescue_F",[5490.56,15011.8,27.3],[[-0.75,0.66,0],[0,0,1]],true],
	["Land_Cargo_HQ_V3_F",[5511.14,15025.3,31.18],[[-0.77,0.64,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V3_F",[5509.47,15008.2,27.99],[[-0.72,0.69,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V3_F",[5504.02,15002.5,27.99],[[-0.72,0.69,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["CamoNet_INDP_big_F",[5497.79,15043,29.37],[[-0.1,1,0],[0,0,1]],true],
	["I_E_CargoNet_01_ammo_F",[5491.65,15034.5,28.13],[[0,1,0],[0,0,1]],false],
	["I_E_CargoNet_01_ammo_F",[5502.8,15040.1,28.13],[[0,1,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V3_F",[5503.7,15067.6,32.24],[[-0.65,-0.76,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V3_F",[5537.07,15020.7,39.88],[[-0.77,0.64,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_BagBunker_Small_F",[5545.9,15043.8,27.96],[[-0.74,0.66,0.1],[0.06,-0.08,1]],false],
	["Land_RoadBarrier_01_F",[5534.99,15048.4,30.89],[[0.65,0.76,0],[0,0,1]],true],
	["Land_RoadBarrier_01_F",[5540.04,15044.8,30.9],[[-0.63,-0.78,0],[0,0,1]],true],
	["Land_LampAirport_F",[5534.37,15055.8,39.6],[[-0.79,0.61,0],[0,0,1]],true]
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
	[[5550.23,15003.2,22.5638],10],
	[[5438.37,15072.1,37.8759],10],
	[[5419.46,15063.2,37.8404],10],
	[[5404.88,15036.2,38.0172],10],
	[[5499.74,15027.6,31.0140],10],
	[[5453.60,14973.3,31.0140],10]
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
					_suitCase setVariable ["mny",round (6500000*BRPVP_missionValueMult),true];
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
	[[5457.21,14956.1,27.3014],0.539171,30],
	[[5475.03,14967.5,27.3014],311.651,30],
	[[5444.17,15060.8,46.7957],312.443,20]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,_hide,{true}];
BRPVP_pmissSpawning = false;