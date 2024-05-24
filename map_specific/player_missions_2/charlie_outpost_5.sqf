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
			["B_APC_Wheeled_01_cannon_F",[19343.7,9712.2,199.4],[[0.04,-1,-0.04],[0.01,-0.04,1]],[1,2,4],[["B_crew_F",["turret",[0]],[],[]]]],
			["B_LSV_01_armed_F",[19321.2,9684.8,196.2],[[-0.66,0.75,0.02],[-0.04,-0.06,1]],[4],[["B_Soldier_F",["turret",[0]],[],[]],["B_Soldier_F",["driver"],[],[]]]],
			["B_MRAP_01_gmg_F",[19381.1,9681.6,197.3],[[0.5,-0.87,-0.07],[0.09,-0.03,1]],[4],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[19300.7,9730.2,207],[[-0.82,0.57,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[19311.9,9722.9,207],[[0.8,-0.6,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[19303.7,9693.7,196],[[-0.95,-0.3,-0.04],[-0.02,-0.07,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[19396.5,9679.4,195],[[0.99,0.07,-0.11],[0.11,0.01,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_sard_F",[19332.2,9641.4,13.6],218,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_brown_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_sard",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_ghillie_sard_F",[19338.6,9649.9,11.3],55,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_brown_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_sard",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_sard_F",[19389.9,9732.4,12.4],53,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_brown_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_sard",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_ghillie_sard_F",[19383.3,9730.2,12.3],326,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_brown_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_sard",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Officer_Parade_F",[19357.3,9731.7,4.7],74,[1,2],"STAND",[]],
			["B_Soldier_F",[19360,9734.4,4.6],161,[1],"STAND",[["arifle_AK12_GL_arid_F","muzzle_snds_B_arid_F","acc_pointer_IR","optic_Arco_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_HarnessO_brn",[["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_gen_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Soldier_F",[19362.8,9733.1,4.6],230,[1],"STAND",[["arifle_AK12_GL_arid_F","muzzle_snds_B_arid_F","acc_pointer_IR","optic_Arco_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_HarnessO_brn",[["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_gen_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Soldier_F",[19363.4,9729.2,4.6],249,[1],"STAND",[["arifle_AK12_GL_arid_F","muzzle_snds_B_arid_F","acc_pointer_IR","optic_Arco_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_HarnessO_brn",[["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_gen_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Soldier_F",[19350.6,9728.9,4.8],95,[1],"STAND",[["arifle_AK12_GL_arid_F","muzzle_snds_B_arid_F","acc_pointer_IR","optic_Arco_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_HarnessO_brn",[["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_gen_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Soldier_F",[19352.6,9728.8,0.7],194,[1],"STAND",[["arifle_AK12_GL_arid_F","muzzle_snds_B_arid_F","acc_pointer_IR","optic_Arco_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_HarnessO_brn",[["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_gen_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Soldier_F",[19363.2,9728.1,0.6],273,[1],"STAND",[["arifle_AK12_GL_arid_F","muzzle_snds_B_arid_F","acc_pointer_IR","optic_Arco_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_HarnessO_brn",[["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_Beret_gen_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["B_static_AA_F",[19357.4,9733.3,207.3],[[0,1,0.02],[0.01,-0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[19357.6,9723.1,207.3],[[0.07,-1,0.01],[0.01,0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[19350.1,9732.9,207.4],[[-0.67,0.74,0.01],[0.01,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[19350.9,9728.1,199.7],[[0.02,-1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[19350.6,9727.3,203.8],[[1,0.02,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[19343,9697.1,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Tactical_Black",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AR_F",[19348,9692.1,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_GL_F",[19338,9692.1,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[19353,9687.1,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[19343,9697.13,-0.000793457],"MOVE"],
			[[19290.2,9704.63,-0.000106812],"MOVE"],
			[[19293,9785.66,1.52588e-005],"MOVE"],
			[[19395.2,9773.72,3.05176e-005],"MOVE"],
			[[19419.6,9674.01,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[19345.1,9705.6,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_HeavyGunner_F",[19340.1,9700.6,0],0,[],"STAND",[]],
			["B_soldier_M_F",[19335.1,9695.6,0],0,[],"STAND",[]],
			["B_Sharpshooter_F",[19360.1,9690.6,0],0,[],"STAND",[["srifle_DMR_03_tan_AMS_LP_F","","acc_pointer_IR","optic_AMS_snd",["20Rnd_762x51_Mag",20],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["20Rnd_762x51_Mag",6,20],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[19330.1,9690.6,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[19365.1,9685.6,0],0,[],"STAND",[["arifle_MX_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetB_light_desert","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AAR_F",[19355.1,9695.6,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Kitbag_rgr_AAR",[["optic_tws_mg",1],["bipod_01_F_snd",1],["muzzle_snds_338_sand",1],["muzzle_snds_H",1],["100Rnd_65x39_caseless_mag",2,100],["100Rnd_65x39_caseless_mag_Tracer",2,100],["130Rnd_338_Mag",2,130]]],"H_HelmetB_light","G_Combat",["Rangefinder","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[19345.1,9705.62,4.57764e-005],"MOVE"],
			[[19483,9644.51,-1.52588e-005],"MOVE"],
			[[19441.1,9512.15,0],"MOVE"],
			[[19269.4,9674.72,0],"MOVE"],
			[[19312.8,9705.14,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_GL_F",[19364.1,9630.6,0],0,[],"STAND",[]],
			["B_Soldier_F",[19369.1,9625.6,0],0,[],"STAND",[]]
		],
		[],
		[
			[[19364.1,9630.57,-0.00878906],"MOVE"],
			[[19486.2,9672.69,0],"MOVE"],
			[[19390.5,9763.29,-1.52588e-005],"MOVE"],
			[[19273.2,9739.41,0],"MOVE"],
			[[19280.4,9672.71,0],"MOVE"],
			[[19339.1,9657.22,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_recon_TL_F",[19406.9,9643.4,0],0,[],"STAND",[]],
			["B_recon_M_F",[19411.9,9638.4,0],0,[],"STAND",[["arifle_MXM_DMS_LP_BI_snds_F","muzzle_snds_H","acc_pointer_IR","optic_DMS",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_Booniehat_mcamo","G_Combat",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_recon_medic_F",[19401.9,9638.4,0],0,[],"STAND",[]]
		],
		[],
		[
			[[19406.9,9643.38,0.00105286],"MOVE"],
			[[19404.9,9612.09,-0.000320435],"MOVE"],
			[[19328.5,9618.63,-9.15527e-005],"MOVE"],
			[[19277.7,9728.12,0.000183105],"MOVE"],
			[[19405.5,9676.92,0],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["B_Truck_01_box_F",[19322,9713.9,198.8],[[0.06,-1,-0.08],[-0.03,-0.08,1]]],
	["B_Truck_01_transport_F",[19327,9714.3,198.8],[[0,1,0.07],[-0.03,-0.07,1]]],
	["B_Quadbike_01_F",[19334.3,9677.7,195.6],[[0,0.99,0.11],[-0.08,-0.11,0.99]]],
	["B_Quadbike_01_F",[19331.8,9677.6,195.4],[[0,1,0.09],[-0.07,-0.09,0.99]]],
	["B_LSV_01_armed_F",[19344,9676,196.9],[[0,1,0.09],[-0.06,-0.09,0.99]]],
	["B_Quadbike_01_F",[19359.2,9644.5,193.3],[[0,1,0.05],[-0.11,-0.05,0.99]]],
	["B_LSV_01_armed_F",[19338.7,9714.6,199.1],[[0,1,0.04],[-0.01,-0.04,1]]],
	["B_LSV_01_armed_F",[19334.8,9714.4,199.1],[[0,1,0.04],[-0.02,-0.04,1]]],
	["C_Offroad_01_comms_F",[19356.7,9714.8,198.6],[[0,1,0.04],[0,-0.04,1]]],
	["C_Offroad_01_comms_F",[19361.2,9715,198.6],[[0,1,0.04],[0.02,-0.04,1]]]
];
_doors = [];
_delete =[];
_pmissBuildings = [
	["Land_Barracks_06_F",[19349.3,9725.17,203.06],[[0.05,-1,0],[0,0,1]],true,{},[1,7]],
	["Land_LampAirport_F",[19309.8,9691.95,206.88],[[0.95,0.32,0],[0,0,1]],true],
	["Land_RoadBarrier_01_F",[19305.6,9700.05,198.39],[[0.98,0.21,0],[0,0,1]],true],
	["Land_BagBunker_Small_F",[19304.2,9693.68,195.34],[[0.97,0.25,0.03],[-0.02,-0.07,1]],false],
	["Land_LampAirport_F",[19313.8,9732.24,209.02],[[0,1,0],[0,0,1]],true],
	["Land_ControlTower_02_F",[19307.4,9721.79,206.37],[[-0.98,-0.22,0],[0,0,1]],true],
	["Land_ControlTower_01_F",[19334.7,9645.62,198.19],[[-0.04,1,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_generic_outer_F",[19344.2,9674.33,196.1],[[0,1,0.05],[-0.06,-0.05,1]],true],
	["Land_MedicalTent_01_NATO_generic_outer_F",[19332.7,9674.83,195.2],[[0,1,0.04],[-0.06,-0.04,1]],true],
	["Land_WaterTank_02_F",[19321.3,9669.49,195.14],[[0.91,0.41,0],[0,0,1]],true],
	["Land_AirConditioner_03_F",[19348.9,9664.88,194.91],[[0,0.99,0.11],[-0.05,-0.11,0.99]],false],
	["Land_IronPipes_F",[19320.6,9728.38,197.69],[[0,1,-0.02],[-0.03,0.02,1]],false],
	["Land_WoodenPlanks_01_F",[19327.1,9726.48,198],[[0,1,0.01],[-0.03,-0.01,1]],false],
	["Land_ConcreteWell_02_F",[19322.8,9723.32,197.77],[[0,1,0],[0,0,1]],false],
	["Land_LampAirport_F",[19367.6,9622.04,200.87],[[0,1,0],[0,0,1]],true],
	["CamoNet_wdl_open_F",[19372.5,9638.09,194.06],[[0,1,0.04],[-0.08,-0.04,1]],true],
	["CamoNet_wdl_open_F",[19361.2,9642.47,193.22],[[0.56,0.83,0.09],[-0.11,-0.03,0.99]],true],
	["Land_MedicalTent_01_wdl_generic_inner_F",[19362.5,9658.42,195.25],[[0.04,0.99,0.12],[0.01,-0.12,0.99]],true],
	["Land_MedicalTent_01_wdl_generic_inner_F",[19350.8,9658.49,195.09],[[0.01,0.99,0.15],[-0.03,-0.15,0.99]],true],

	["Land_TableDesk_F",[19358.3,9731.14,202.55+0.2],[[-1,-0.05,0],[0,0,1]],true],
	["Land_OfficeCabinet_01_F",[19356.9,9734.28,202.93+0.2],[[-1,-0.04,0],[0,0,1]],true],
	["Land_TripodScreen_01_dual_v2_F",[19371.9,9639.76,193.76+0.2],[[0,1,0.04],[-0.08,-0.04,1]],true],
	["Land_TripodScreen_01_large_black_F",[19373.9,9639.34,194.01+0.2],[[0,1,0.04],[-0.02,-0.04,1]],true],
	["Land_IPPhone_01_black_F",[19358.3,9731.85,203+0.2],[[1,0,0],[0,0,1]],true],
	["Land_OfficeChair_01_F",[19357.4,9730.7,202.82+0.2],[[-0.78,-0.63,0],[0,0,1]],true],
	["MapBoard_altis_F",[19363.3,9734.35,203.11+0.2],[[0.82,0.57,-0.01],[0,0,1]],true],
	["Land_Tablet_02_F",[19358.1,9731.47,203+0.2],[[0,1,0],[0,0,1]],true],
	["Land_Computer_01_black_F",[19358.4,9731.21,203.01+0.2],[[-1,-0.06,0.01],[0.01,0.01,1]],true],
	["Land_Laptop_Intel_Oldman_F",[19358.3,9730.63,203.12+0.2],[[-0.99,0.15,0],[0,0,1]],true],

	["Land_AirConditioner_03_F",[19360.8,9664.63,194.95],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_AirConditioner_03_F",[19378.4,9664.23,194.48],[[-1,0.01,0.05],[0.05,-0.07,1]],false],
	["WaterPump_01_forest_F",[19357.7,9674.67,196.33+0.2],[[0,1,0.08],[0,-0.08,1]],true],
	["I_CargoNet_01_ammo_F",[19355.3,9670.81,195.75],[[0,1,0.08],[-0.02,-0.08,1]],false],
	["B_CargoNet_01_ammo_F",[19353,9670.9,195.74],[[0,1,0.06],[0.01,-0.06,1]],false],
	["FlexibleTank_01_sand_F",[19352.7,9675.24,195.72],[[0,1,0.09],[-0.02,-0.09,1]],false],
	["FlexibleTank_01_sand_F",[19352.7,9673.76,195.6],[[0,1,0.08],[-0.02,-0.08,1]],false],
	["Land_PowerGenerator_F",[19350.7,9674.6,195.9],[[0.06,1,0.08],[-0.02,-0.08,1]],false],
	["Land_Communication_F",[19352.3,9682.71,212.39],[[0,1,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",100,true];}],
	["Land_Barracks_03_F",[19374.8,9704.2,198],[[-0.02,-1,0],[0,0,1]],true],
	["Land_Barracks_03_F",[19375.3,9692.35,197.47],[[-0.02,-1,0],[0,0,1]],true],
	["Land_LampAirport_F",[19375.6,9727.65,209.64],[[0,1,0],[0,0,1]],true],
	["B_Slingload_01_Fuel_F",[19368.2,9725.22,198.75],[[0.02,-1,-0.03],[0.03,-0.03,1]],true],
	["Land_LampAirport_F",[19391.2,9654.78,205.12],[[0,1,0],[0,0,1]],true],
	//["Land_spp_Panel_F",[19385.7,9632.65,193.49],[[0,1,0],[0,0,1]],false],
	["Land_MedicalTent_01_wdl_generic_inner_F",[19385.6,9647.6,194.65],[[-1,-0.09,0.01],[0.01,0,1]],true],
	["Land_MedicalTent_01_wdl_generic_inner_F",[19384.9,9660.09,194.74],[[-1,-0.03,0.05],[0.05,-0.07,1]],true],
	["Land_RoadBarrier_01_F",[19394.3,9672.71,197.07],[[1,0.08,0],[0,0,1]],true],
	["Land_BagBunker_Small_F",[19395.9,9679.54,194.36],[[-0.99,-0.03,0.11],[0.11,0.01,0.99]],false],
	["Land_ControlTower_01_F",[19386,9728.09,204.4],[[-0.04,1,0],[0,0,1]],true]
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
	[[19327.3,9714.59,196.715],20],
	[[19359.8,9708.33,196.782],20],
	[[19342.1,9673.81,194.576],20],
	[[19373.8,9654.81,193.463],20],
	[[19369.5,9677.67,195.303],05]
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
	[[19385.2,9662.26,193.502],185.517,20],
	[[19376.3,9640.00,193.048],271.545,10]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmiss2Objects = [_place,_rad,_nos,_ts,[],[],_vd,_hide];
BRPVP_pmiss2Spawning = false;