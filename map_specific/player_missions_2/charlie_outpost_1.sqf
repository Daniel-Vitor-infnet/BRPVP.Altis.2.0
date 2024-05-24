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
			["I_E_Soldier_AR_F",[8929.4,7476.2,0.3],0,[1],"STAND",[["LMG_Mk200_black_LP_BI_F","","acc_pointer_IR","optic_Aco",["200Rnd_65x39_cased_Box_Red",200],[],"bipod_01_F_blk"],[],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_shortsleeve_F",[["FirstAidKit",1],["11Rnd_45ACP_Mag",2,11],["HandGrenade",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["200Rnd_65x39_cased_Box_Red",2,200],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",2,1]]],[],"H_HelmetHBK_ear_F","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_E_Soldier_lite_F",[8936.2,7480.8,4.7],237,[1],"STAND",[["SMG_03_black","muzzle_snds_570","","",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_PlateCarrierH_CTRG",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",1,50]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[8933.1,7476.7,4.4],351,[1],"STAND",[["SMG_03_black","muzzle_snds_570","","",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_PlateCarrierH_CTRG",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",1,50]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[8931.4,7476.2,4.4],331,[1],"STAND",[["SMG_03_black","muzzle_snds_570","","",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_PlateCarrierH_CTRG",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",1,50]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[8925.7,7484,0.5],328,[1],"STAND",[["SMG_03_black","muzzle_snds_570","","",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_PlateCarrierH_CTRG",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",1,50]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[8929.9,7486.5,0.6],281,[1],"STAND",[["SMG_03_black","muzzle_snds_570","","",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_PlateCarrierH_CTRG",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",1,50]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Soldier_lite_F",[8930.2,7488.9,4.9],183,[1],"STAND",[["SMG_03_black","muzzle_snds_570","","",["50Rnd_570x28_SMG_03",50],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_PlateCarrierH_CTRG",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1],["50Rnd_570x28_SMG_03",1,50]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_E_Officer_Parade_Veteran_F",[8933.6,7482.4,4.6],171,[1,2],"STAND",[]]
		],
		[
			["I_E_Static_AT_F",[8931,7488.4,77.2],[[0.45,0.89,0.01],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[8935.3,7476.9,77.8],[[0.99,-0.11,0.02],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[8928.439,7487.839,73.6+0.25],[[0.24,-0.97,0],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[8928.81,7488.89,69.5406],[[-0.94,-0.33,0],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_E_Static_AA_F",[8928.2,7522.2,69.9],[[0.96,0.29,0],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]],
			["I_E_HMG_02_high_F",[8924.8,7526.1,67.6],[[0.62,0.78,0],[0,0,1]],[],[["I_E_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
	INDEPENDENT,
		[],
		[],
		[
			["I_MRAP_03_hmg_F",[8897.7,7497.5,68.6],[[0.87,-0.49,-0.01],[0.03,0.03,1]],[4],[["I_soldier_F",["turret",[0]],[],[]]]],
			["I_G_Offroad_01_armed_F",[8905.4,7515,68.3],[[-0.32,0.95,-0.04],[-0.05,0.03,1]],[4],[["I_G_Soldier_F",["turret",[0]],[],[]]]],
			["I_G_Offroad_01_AT_F",[8990.9,7490.7,72.1],[[0.9,0.44,-0.01],[0.02,0,1]],[4],[["I_G_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_lsh_F",[8915.8,7537.6,4.5],31,[1],"STAND",[["srifle_GM6_F","","","optic_tws",["5Rnd_127x108_Mag",5],[],""],[],["hgun_ACPC2_F","muzzle_snds_acp","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_FullGhillie_lsh",[["FirstAidKit",1],["5Rnd_127x108_Mag",2,5],["SmokeShell",1,1]]],["V_Chestrig_oli",[["5Rnd_127x108_Mag",3,5],["9Rnd_45ACP_Mag",2,9],["APERSTripMine_Wire_Mag",1,1],["ClaymoreDirectionalMine_Remote_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1]]],[],"H_HelmetO_ViperSP_ghex_F","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_lsh_F",[8998.3,7482.6,4.3],76,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_ghillie_lsh_F",[8899.9,7460,4.7],165,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_TL_F",[8906.3,7491.7,0],360,[],"STAND",[]],
			["I_Soldier_AR_F",[8911.3,7486.7,0],0,[],"STAND",[]],
			["I_Soldier_GL_F",[8901.3,7486.7,0],0,[],"STAND",[["arifle_Mk20_GL_ACO_F","","","optic_ACO_grn",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30],["1Rnd_SmokePurple_Grenade_shell",1,1]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag",2,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetIA_net","G_Shades_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_LAT_F",[8916.3,7481.7,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA2_dgtl",[["30Rnd_556x45_Stanag",2,30],["9Rnd_45ACP_Mag",2,9],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["I_Fieldpack_oli_LAT",[["NLAW_F",2,1]]],"H_HelmetIA","G_Lowprofile",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_E_Soldier_AT_F",[8913.2,7493,0],0,[],"STAND",[["arifle_MSBS65_ico_pointer_f","","acc_pointer_IR","optic_ico_01_f",["30Rnd_65x39_caseless_msbs_mag",30],[],""],["launch_I_Titan_short_F","","","",["Titan_AT",1],[],""],["hgun_Pistol_heavy_01_green_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_I_E_Uniform_01_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_msbs_mag",2,30],["Chemlight_blue",1,1]]],["V_CarrierRigKBT_01_light_EAF_F",[["30Rnd_65x39_caseless_msbs_mag",3,30],["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",1,1]]],["B_Fieldpack_green_IEAT_F",[["Titan_AT",2,1]]],"H_HelmetHBK_ear_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[],
		[
			[[8906.27,7491.71,0.00357056],"MOVE"],
			[[8946.69,7547.9,3.8147e-006],"MOVE"],
			[[8913.33,7582.28,3.8147e-006],"MOVE"],
			[[8873.13,7529.61,0],"MOVE"],
			[[8922.07,7470.3,3.05176e-005],"MOVE"],
			[[8947.97,7474.77,0],"MOVE"],
			[[8942.4,7516.3,0],"MOVE"],
			[[8915.64,7497.52,7.62939e-006],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Sniper_F",[8910.1,7521.8,0],0,[],"STAND",[]],
			["I_Spotter_F",[8915.1,7516.8,0],0,[],"STAND",[]]
		],
		[],
		[
			[[8910.06,7521.81,0.00469971],"MOVE"],
			[[8920.12,7472.65,7.62939e-006],"MOVE"],
			[[8985.63,7495.97,0],"MOVE"],
			[[8937.66,7559.26,3.8147e-006],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_TL_F",[8881.5,7465.1,0],0,[],"STAND",[]],
			["I_Soldier_AR_F",[8886.5,7460.1,0],0,[],"STAND",[["LMG_Mk200_LP_BI_F","","acc_pointer_IR","",["200Rnd_65x39_cased_Box",200],[],"bipod_03_F_blk"],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_shortsleeve",[["FirstAidKit",1],["9Rnd_45ACP_Mag",2,9],["HandGrenade",1,1],["SmokeShell",1,1]]],["V_PlateCarrierIA2_dgtl",[["200Rnd_65x39_cased_Box",2,200],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA_camo","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_soldier_F",[8876.5,7460.1,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIA1_dgtl",[["30Rnd_556x45_Stanag",6,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],"H_HelmetIA","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_LAT2_F",[8891.5,7455.1,0],0,[],"STAND",[]]
		],
		[],
		[
			[[8881.46,7465.1,-0.00195694],"MOVE"],
			[[8880.7,7540.69,0],"MOVE"],
			[[8975.17,7550.47,-3.8147e-006],"MOVE"],
			[[8975.85,7452.36,0],"MOVE"],
			[[8882.26,7443.92,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_Soldier_TL_F",[8965.4,7509.9,0],0,[],"STAND",[["arifle_Mk20_GL_MRCO_pointer_F","","acc_pointer_IR","optic_MRCO",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_PlateCarrierIAGL_dgtl",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",2,9],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellOrange",1,1],["SmokeShellPurple",1,1],["Chemlight_green",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1],["1Rnd_SmokePurple_Grenade_shell",1,1]]],[],"H_HelmetIA","G_Shades_Blue",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_Soldier_AA_F",[8970.4,7504.9,0],0,[],"STAND",[]],
			["I_Soldier_AA_F",[8960.4,7504.9,0],0,[],"STAND",[]],
			["I_Soldier_AAA_F",[8975.4,7499.9,0],0,[],"STAND",[["arifle_Mk20_ACO_pointer_F","","acc_pointer_IR","optic_ACO_grn",["30Rnd_556x45_Stanag",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_CombatUniform_tshirt",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_Chestrig_oli",[["30Rnd_556x45_Stanag",4,30],["9Rnd_45ACP_Mag",2,9],["HandGrenade",2,1],["I_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["I_Carryall_oli_AAA",[["Titan_AA",3,1]]],"H_HelmetIA","G_Aviator",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_E_Soldier_AAA_F",[8979.3,7495.4,0],0,[],"STAND",[]]
		],
		[],
		[
			[[8965.37,7509.87,0.00603485],"MOVE"],
			[[8967.97,7578.22,-3.8147e-006],"MOVE"],
			[[8852.62,7567.82,0],"MOVE"],
			[[8858.33,7420.41,0],"MOVE"],
			[[8975.61,7423,0],"MOVE"],
			[[8965.36,7486.55,0.500153],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["I_E_Offroad_01_comms_F",[8895.5,7493.2,68.2],[[0.88,-0.48,-0.01],[0.03,0.04,1]]],
	["I_E_Truck_02_transport_F",[8903.6,7475.8,69.2],[[-0.16,0.99,-0.02],[-0.03,0.01,1]]]
];
_doors = [];
_delete =[];
_pmissBuildings = [
	["Land_Barracks_06_F",[8926.14,7489.95,72.83],[[-0.99,-0.12,0],[0,0,1]],true,{},[1,7]],
	["Land_LampHalogen_F",[8897.21,7458.25,72.1],[[-0.56,0.83,0],[0,0,1]],true],
	["Land_Cargo_Patrol_V1_F",[8900.73,7461.56,71.67],[[-0.21,0.98,0],[0,0,1]],true],
	["CargoNet_01_barrels_F",[8898.43,7472.1,67.38],[[0.98,0.2,0.07],[-0.07,-0.05,1]],false],
	["I_E_CargoNet_01_ammo_F",[8896.4,7471.47,67.51],[[0.97,0.22,0.08],[-0.07,-0.05,1]],false],
	["Land_RepairDepot_01_green_F",[8896.97,7477.83,69.35],[[0.17,-0.99,-0.01],[-0.04,-0.02,1]],true],
	["B_Slingload_01_Fuel_F",[8893.44,7484.67,68.34],[[0.18,-0.98,0.05],[-0.01,0.05,1]],true],
	["Land_WaterTank_02_F",[8892.34,7489.82,68.9],[[-0.98,-0.18,0],[0,0,1]],true],
	["Flag_FIA_F",[8896.5,7504,69.89],[[0,1,0],[0,0,1]],false],
	["Land_PowerGenerator_F",[8918.39,7469.35,68.09],[[-0.21,0.97,0.09],[-0.02,-0.1,1]],false],
	["Land_MedicalTent_01_wdl_generic_inner_F",[8912.34,7467.18,68.57],[[-0.2,0.98,0],[0.02,0,1]],true],
	["Land_LampAirport_F",[8927.44,7467.1,79.71],[[-0.1,0.99,0],[0,0,1]],true],
	//["Land_BagFence_Short_F",[8928.432,7486.477,72.33],[[0.12,-0.99,0],[0,0,1]],false],
	["Land_BagFence_Short_F",[8927.062,7488.892,68.26],[[0.99,0.14,0],[0,0,1]],false],
	["FlexibleTank_01_forest_F",[8917.1,7470.3,67.84],[[0,1,-0.02],[-0.01,0.02,1]],false],
	["FlexibleTank_01_forest_F",[8916.82,7471.41,67.82],[[0,1,-0.01],[-0.02,0.01,1]],false],

	["Land_TableDesk_F",[8932.79,7481.39,72.52],[[-0.12,0.99,0],[0,0,1]],true],
	["Land_PortableGenerator_01_black_F",[8934.68,7476.77,72.49],[[0.99,0.13,0],[0,0,1]],true],
	["Land_TripodScreen_01_large_black_F",[8936.22,7476.58,73.06],[[-0.46,0.89,0],[0,0,1]],true],
	["Land_PCSet_01_keyboard_F",[8932.58,7481.54,72.95],[[0.05,-1,0],[0,0,1]],true],
	["Land_PCSet_01_screen_F",[8932.35,7481.25,73.19],[[-0.36,-0.93,-0.02],[-0.03,-0.01,1]],true],
	["Land_IPPhone_01_black_F",[8933.43,7481.38,72.98],[[0.1,-0.99,0],[0,0,1]],true],
	["Land_WaterCooler_01_new_F",[8932.85,7475.72,72.75],[[0.1,-1,0],[0,0,1]],true],
	["Land_File_research_F",[8933.05,7481.39,72.94],[[0,1,0.01],[0.01,-0.01,1]],true],
	["Land_OfficeChair_01_F",[8932.42,7482.3,72.69],[[-0.88,0.48,0],[0,0,1]],true],
	["MapBoard_altis_F",[8935.68,7482.47,72.98],[[0.59,0.81,-0.01],[0,0,1]],true],

	["Land_AirConditioner_04_F",[8913.23,7474.72,67.71],[[-0.82,0.57,-0.02],[-0.02,0.01,1]],false],
	["WaterPump_01_forest_F",[8917.9,7496.76,68.51],[[0.08,-1,-0.01],[0,-0.01,1]],true],
	//["Land_spp_Mirror_F",[8923.76,7488.8,78.18],[[-0.8,0.6,0],[0,0,1]],false],
	["Land_Communication_F",[8910.19,7483.68,83.87],[[-0.99,-0.12,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",100,true];}],
	["Land_GuardHouse_01_F",[8924.17,7521.64,66.94],[[-0.87,0.49,0],[0,0,1]],true],
	["Land_LampHalogen_F",[8913.31,7501.71,73],[[-0.89,0.45,0],[0,0,1]],true],
	["Land_LampHalogen_F",[8925.73,7529.1,70.58],[[0.87,-0.49,0],[0,0,1]],true],
	["Land_BarGate_F",[8921.2,7530.43,68.62],[[0.47,0.88,0],[0,0,1]],true],
	["Land_Cargo_Patrol_V1_F",[8914.17,7537.31,69.36],[[-0.46,-0.89,0],[0,0,1]],true],
	["Land_LampHalogen_F",[8947.22,7469.67,73.19],[[-0.21,-0.98,0],[0,0,1]],true],
	["Land_Cargo_Patrol_V1_F",[8997.31,7481.08,75.07],[[-0.99,-0.14,0],[0,0,1]],true]
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
	[[8925.14,7493.97,75.5092],5],
	[[8899.6,7482.48,66.9464],5],
	[[8920.82,7487.52,67.3822],5],
	[[8924.83,7493.42,70.8058],2]
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
	[[8914.93,7467.25,67.2154],262.198,20],
	[[8932.09,7513.76,66.5059],181.168,10]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmiss2Objects = [_place,_rad,_nos,_ts,[],[],_vd,_hide];
BRPVP_pmiss2Spawning = false;