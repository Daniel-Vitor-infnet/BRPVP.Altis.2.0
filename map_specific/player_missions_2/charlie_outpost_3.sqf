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
		[
			["B_Sharpshooter_F",[27537.6,24576.5,0],224,[],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_HeavyGunner_F",[27579.3,24610.5,0],0,[],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_Boat_Armed_01_minigun_F",[27634,24499.9,2.4],[[-0.95,0.3,-0.01],[-0.01,-0.02,1]],[],[["B_Soldier_F",["driver"],[],[]],["B_Soldier_F",["turret",[0]],[],[]],["B_Soldier_F",["turret",[1]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_MRAP_01_gmg_F",[27564.1,24593.8,9.2],[[-0.75,-0.66,-0.1],[-0.02,-0.13,0.99]],[4],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_APC_Wheeled_01_cannon_F",[27618.1,24576.7,5.9],[[0.21,0.98,0],[0,0,1]],[1,2,4],[["B_crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_support_MG_F",[27648.1,24589.6,0.6],208,[1],"STAND",[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag_Sand",3,30]]],["V_PlateCarrierL_CTRG",[["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_support_MG_F",[27658,24585.2,1.1],299,[1],"STAND",[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag_Sand",3,30]]],["V_PlateCarrierL_CTRG",[["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_support_MG_F",[27658.8,24587.3,5.2],254,[1],"STAND",[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag_Sand",3,30]]],["V_PlateCarrierL_CTRG",[["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_support_MG_F",[27645.6,24590.3,4.7],113,[1],"STAND",[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag_Sand",3,30]]],["V_PlateCarrierL_CTRG",[["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_support_MG_F",[27656,24593,5],179,[1],"STAND",[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag_Sand",3,30]]],["V_PlateCarrierL_CTRG",[["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_support_MG_F",[27658.6,24589,5.2],282,[1],"STAND",[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag_Sand",3,30]]],["V_PlateCarrierL_CTRG",[["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_support_MG_F",[27649.8,24585,0.8],249,[1],"STAND",[["arifle_SPAR_01_GL_snd_F","muzzle_snds_m_snd_F","acc_pointer_IR","optic_ERCO_snd_F",["30Rnd_556x45_Stanag_Sand",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_O_R_Gorka_01_black_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_556x45_Stanag_Sand",3,30]]],["V_PlateCarrierL_CTRG",[["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_02","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Officer_Parade_Veteran_F",[27653.3,24591.2,4.8],101,[1,2],"STAND",[]]
		],
		[
			["B_GMG_01_high_F",[27653.7,24592.2,14.6],[[0,1,0.02],[0.01,-0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[27644.6,24584.2,14.7],[[-0.96,-0.26,0.01],[0.01,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[27657.4,24581.4,13.9],[[0,1,-0.01],[0.01,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[27647.1,24590.3,14],[[-0.89,0.46,0.01],[0.01,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[27646.021,24588.28,6.3],[[-0.18,-0.98,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[27646.021,24588.28,10.4],[[0.99,-0.15,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_sard_F",[27546.2,24557.9,14.7],90,[1],"STAND",[]],
			["B_ghillie_sard_F",[27537.7,24558.5,14.6],282,[1],"STAND",[["srifle_LRR_F","","","optic_Nightstalker",["7Rnd_408_Mag",7],[],""],[],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_sard",[["FirstAidKit",1],["SmokeShell",1,1],["7Rnd_408_Mag",3,7]]],["V_Chestrig_rgr",[["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"H_HelmetO_ViperSP_ghex_F","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_sard_F",[27677.3,24502.1,16],0,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_LSV_01_armed_F",[27642.9,24619.1,9.7],[[-0.44,0.89,0.08],[0.02,-0.08,1]],[],[["B_Soldier_F",["driver"],[],[]],["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_HeavyGunner_F",[27555.4,24564.6,0.4],111,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[27662.7,24622.1,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AR_F",[27667.7,24617.1,0],0,[],"STAND",[]],
			["B_Soldier_GL_F",[27657.7,24617.1,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[27672.7,24612.1,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AAT_F",[27681.4,24613.6,0],0,[],"STAND",[]]
		],
		[],
		[
			[[27662.7,24622.1,-0.0032773],"MOVE"],
			[[27628.2,24661.2,0],"MOVE"],
			[[27533.1,24607.4,0],"MOVE"],
			[[27574.1,24569.9,0],"MOVE"],
			[[27620.9,24597.9,2.38419e-007],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[27623.2,24640.8,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AR_F",[27628.2,24635.8,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_HeavyGunner_F",[27618.2,24635.8,0],0,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AAR_F",[27633.2,24630.8,0],0,[],"STAND",[]],
			["B_soldier_M_F",[27613.2,24630.8,0],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Sharpshooter_F",[27638.2,24625.8,0],0,[],"STAND",[]],
			["B_soldier_LAT_F",[27608.2,24625.8,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[27643.2,24620.8,0],0,[],"STAND",[]],
			["B_soldier_AAA_F",[27607,24632.7,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Carryall_mcamo_AAA",[["Titan_AA",3,1]]],"H_HelmetB_light","G_Combat",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[27623.2,24640.8,-0.00293636],"MOVE"],
			[[27495.7,24589.6,0],"MOVE"],
			[[27535.3,24548.2,4.29153e-006],"MOVE"],
			[[27611.8,24586.4,5.72205e-006],"MOVE"],
			[[27662.2,24609.3,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_ard_F",[27595.6,24477.9,2.4],0,[1],"STAND",[]]
		],
		[
			["B_HMG_01_high_F",[27592.1,24479,4],[[0,1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["B_Boat_Transport_01_F",[27559.1,24540.4,3.2],[[-0.6,0.8,0.08],[0.14,0,0.99]]],
	["B_Boat_Transport_01_F",[27560.8,24544.8,3.4],[[0.63,-0.77,-0.1],[-0.03,-0.15,0.99]]],
	["B_Truck_01_fuel_F",[27554.7,24556,5.3],[[0.8,0.59,0.01],[0.04,-0.07,1]]],
	["B_SDV_01_F",[27564.6,24540,3.3],[[-0.63,0.77,0.12],[0.07,-0.09,0.99]]],
	["B_LSV_01_unarmed_F",[27587.6,24571.5,5.5],[[-0.55,0.83,-0.01],[-0.01,0.01,1]]],
	["B_Boat_Armed_01_minigun_F",[27630.9,24564.5,2.5],[[0.97,-0.25,0.01],[-0.01,0,1]]],
	["B_Boat_Armed_01_minigun_F",[27587.1,24549.4,2.5],[[0.85,0.52,0.01],[-0.01,-0.01,1]]],
	["B_SDV_01_F",[27668.1,24499.3,0.4],[[0.36,-0.93,-0.04],[0,-0.05,1]]],
	["C_Offroad_01_comms_F",[27648.8,24577.1,5.3],[[-0.26,-0.96,-0.04],[-0.02,-0.04,1]]],
	["C_Offroad_01_comms_F",[27652.2,24576.1,5.3],[[-0.26,-0.96,-0.04],[-0.01,-0.04,1]]]
];
_doors = [];
_delete =[];
_pmissBuildings = [
	["Land_Barracks_06_F",[27643.8,24587,9.67],[[-0.23,-0.97,0],[0,0,1]],true,{},[1,7]],
	["Land_BagBunker_Small_F",[27538.2,24577,5.95],[[0.71,0.7,0.04],[-0.01,-0.04,1]],false],
	["Land_GuardHouse_01_F",[27557.2,24568.4,5.26],[[0.65,-0.76,0],[0,0,1]],true],
	["CamoNet_OPFOR_big_F",[27559,24544.1,5.23],[[-0.61,0.79,0],[0,0,1]],true],
	["Land_Airport_01_controlTower_F",[27542.7,24557.6,14.65],[[-0.65,0.76,0],[0,0,1]],true],
	["Land_BarGate_01_open_F",[27543.2,24575.1,8.95],[[-0.74,-0.67,0],[0,0,1]],true],
	["Land_LampAirport_F",[27560,24572.1,16.61],[[0.64,-0.77,0],[0,0,1]],true],
	["Land_PierWooden_02_hut_F",[27594,24477.3,-15.21],[[-0.21,-0.98,0],[0,0,1]],false],
	["Land_Cargo_House_V3_F",[27575.5,24560.9,4.17],[[-0.52,0.85,0],[0,0,1]],true],
	["Land_Cargo_House_V3_F",[27582.7,24565.4,4.16],[[-0.51,0.86,0],[0,0,1]],true],
	["Land_Pier_addon",[27585.3,24553.9,0.98],[[0.53,-0.85,0],[0,0,1]],false],
	["FlexibleTank_01_forest_F",[27593.8,24574.3,3.98],[[0,1,0],[0,0,1]],false],
	["FlexibleTank_01_forest_F",[27594.4,24572.9,3.99],[[0,1,0],[0,0,1]],false],
	["Land_PowerGenerator_F",[27593.1,24573,4.27],[[0.53,-0.85,0],[0,0,1]],false],
	["Land_Cargo_House_V3_F",[27581.3,24588,5.35],[[-0.2,0.98,0],[0,0,1]],true],
	["Land_Cargo_House_V3_F",[27591.1,24591.7,4.38],[[-0.2,0.98,0],[0,0,1]],true],
	["Land_WaterTower_01_F",[27577.1,24595.1,10.85],[[-0.5,0.86,0],[0,0,1]],true],
	["Land_BagBunker_Small_F",[27579.6,24610.1,8.27],[[0.28,-0.96,-0.03],[-0.01,-0.04,1]],false],
	["Land_BuoyBig_F",[27613.3,24408.9,1.51],[[0,1,0],[-0.01,0,1]],false],
	["Land_Cargo_House_V3_F",[27602.2,24592.8,4.12],[[-0.2,0.98,0],[0,0,1]],true],
	["Land_LampAirport_F",[27609.7,24594.4,16.35],[[0.29,0.96,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_generic_inner_F",[27617.4,24611.3,6.76],[[0.12,0.97,0.22],[-0.01,-0.22,0.98]],true],
	["Land_AirConditioner_04_F",[27619.7,24604,4.81],[[0.54,-0.84,-0.06],[-0.01,-0.07,1]],false],
	["Land_WarehouseShelter_01_F",[27653.7,24555.1,6.35],[[-0.92,-0.38,0],[0,0,1]],true],
	["Land_fs_roof_F",[27632.8,24567.4,5.93],[[0.24,0.97,0],[0,0,1]],true],
	["Land_fs_feed_F",[27634.2,24566.8,4.62],[[0.26,0.96,0],[0,0,1]],true],
	["Land_fs_feed_F",[27630.9,24567.8,4.62],[[0.26,0.96,0],[0,0,1]],true],
	["Land_Destroyer_01_Boat_Rack_01_F",[27656.4,24553.1,2.99],[[0.31,-0.91,0],[0,0,1]],false],

	["Land_TableDesk_F",[27654.2,24590.3,9.16+0.2],[[-0.97,0.22,0],[0,0,1]],true],
	["Land_OfficeCabinet_01_F",[27653.6,24593.6,9.54+0.2],[[-0.97,0.24,0],[0,0,1]],true],
	["Land_IPPhone_01_sand_F",[27654.4,24590.9,9.61+0.2],[[0.97,-0.24,0],[0,0,1]],true],
	["Land_WaterCooler_01_new_F",[27653.5,24593,9.49+0.2],[[-0.97,0.25,0],[0,0,1]],true],
	["Land_File_research_F",[27654.2,24590.5,9.58+0.2],[[0.01,1,-0.01],[0.01,0.01,1]],true],
	["Land_OfficeChair_01_F",[27653.1,24590.1,9.43+0.2],[[-0.83,-0.56,0],[0,0,1]],true],
	["MapBoard_altis_F",[27659.8,24591.8,9.72+0.2],[[0.97,0.25,-0.01],[0.01,0,1]],true],
	["Land_Laptop_03_black_F",[27654.1,24589.8,9.74+0.2],[[0.71,-0.71,-0.01],[0,-0.01,1]],true],
	["Land_PortableLongRangeRadio_F",[27654.4,24590,9.59+0.2],[[0,1,-0.01],[0.01,0.01,1]],true],

	["Land_LampAirport_F",[27659.6,24579.2,15.82],[[0.29,0.96,0],[0,0,1]],true],
	["Land_SewerCover_03_F",[27636.2,24570.4,3.5],[[0,1,0],[0,0,1]],false],
	["Land_SewerCover_01_F",[27631.6,24571.5,3.5],[[-0.98,0.22,0],[0,0,1]],false],
	["Land_MedicalTent_01_NATO_generic_inner_F",[27630.7,24609.2,6.99],[[0.16,0.97,0.17],[-0.05,-0.16,0.99]],true],
	["Land_ControlTower_01_F",[27681.1,24499.1,11.1],[[-0.36,0.93,0],[0,0,1]],true],
	["Land_Pier_addon",[27670.5,24505,0.88],[[-0.93,-0.37,0],[0,0,1]],false],
	["Land_WarehouseShelter_01_F",[27664.9,24527,6.41],[[-0.92,-0.38,0],[0,0,1]],true],
	["Land_LampAirport_F",[27678.2,24520.6,15.97],[[0.95,0.31,0],[0,0,1]],true],
	["Land_Destroyer_01_Boat_Rack_01_F",[27665.2,24530.1,2.99],[[0.38,-0.92,0],[0,0,1]],false],
	["Land_dp_smallTank_F",[27667.8,24545.7,8.3],[[0,1,0],[0,0,1]],true]
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
	[[27651.6,24582.6,3.82770],10],
	[[27604.9,24589.3,3.37922],05],
	[[27591.5,24587.7,3.58171],05],
	[[27537.6,24554.7,3.90732],10],
	[[27577.9,24593.1,6.20448],05],
	[[27629.9,24617.0,6.68247],20],
	[[27551.7,24566.7,4.14154],05]
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
	[[27630.7,24609.7,5.69125],190.014,20],
	[[27615.1,24612.9,5.75216],105.958,10]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmiss2Objects = [_place,_rad,_nos,_ts,[],[],_vd,_hide];
BRPVP_pmiss2Spawning = false;