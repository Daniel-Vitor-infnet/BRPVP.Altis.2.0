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

//CREATE PVP ZONE IF IN PVE
private _inPve = {_place distance (_x select 0) < _x select 1} count BRPVP_pveMainAreas > 0;
private _inPvp = {_place distance (_x select 0) < _x select 1} count BRPVP_PVPAreas > 0;
private _key = "CHARLIEFINAL_MISS_PVP_"+str round random 1000000;
if (_inPve && !_inPvp) then {
	[_place,500,{"PVP"},_key] remoteEXecCall ["BRPVP_addPvpArea",2];
	[_place,500,_key,12] remoteExecCall ["BRPVP_addNewPosCheckLayer",0];
};

//MISSION
_pmissGroups = [
	[
		WEST,
		[],
		[],
		[
			["B_T_LSV_01_armed_F",[15404.2,16038.3,6.6],[[-0.87,0.49,-0.01],[0,0,1]],[4],[["B_T_Soldier_F",["turret",[0]],[],[]],["B_T_Soldier_F",["turret",[0,0]],[],[]]]],
			["B_T_APC_Tracked_01_AA_F",[15351.5,16064.6,7.1],[[-0.25,0.97,-0.01],[0,0,1]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]],
			["B_T_APC_Wheeled_01_cannon_F",[15391.4,16114.4,6.6],[[0.97,-0.24,0],[0,0,1]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[15371.1,16060.2,6.6],[[0.82,-0.57,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[15332.4,16056.6,4.4],284,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[15535.1,16100.3,3.9],256,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[15267.8,16236.7,48.2],198,[1],"STAND",[["srifle_LRR_camo_F","","","optic_LRPS",["7Rnd_408_Mag",7],[],""],["launch_O_Vorona_green_F","","","",[],[],""],["hgun_P07_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_FullGhillie_lsh",[["FirstAidKit",1],["7Rnd_408_Mag",2,7],["SmokeShell",1,1]]],["V_Chestrig_rgr",[["7Rnd_408_Mag",3,7],["16Rnd_9x21_Mag",2,16],["ClaymoreDirectionalMine_Remote_Mag",1,1],["APERSTripMine_Wire_Mag",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",2,1]]],[],"","",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Officer_Parade_F",[15323.6,16089.5,4.8],349,[1,2],"STAND",[]],
			["B_T_soldier_M_F",[15321.3,16094.4,4.8],117,[1],"STAND",[["arifle_SPAR_03_blk_F","","acc_pointer_IR","optic_AMS",["20Rnd_762x51_Mag",20],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",1,20],["11Rnd_45ACP_Mag",1,11]]],["V_PlateCarrier2_blk",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",2,20],["11Rnd_45ACP_Mag",2,11]]],[],"H_HeadSet_black_F","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_soldier_M_F",[15324.9,16096.2,4.8],145,[1],"STAND",[["arifle_SPAR_03_blk_F","","acc_pointer_IR","optic_AMS",["20Rnd_762x51_Mag",20],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",1,20],["11Rnd_45ACP_Mag",1,11]]],["V_PlateCarrier2_blk",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",2,20],["11Rnd_45ACP_Mag",2,11]]],[],"H_HeadSet_black_F","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_soldier_M_F",[15326.3,16096.2,0.7],175,[1],"STAND",[["arifle_SPAR_03_blk_F","","acc_pointer_IR","optic_AMS",["20Rnd_762x51_Mag",20],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",1,20],["11Rnd_45ACP_Mag",1,11]]],["V_PlateCarrier2_blk",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",2,20],["11Rnd_45ACP_Mag",2,11]]],[],"H_HeadSet_black_F","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_soldier_M_F",[15320.9,16091,4.8],41,[1],"STAND",[["arifle_SPAR_03_blk_F","","acc_pointer_IR","optic_AMS",["20Rnd_762x51_Mag",20],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",1,20],["11Rnd_45ACP_Mag",1,11]]],["V_PlateCarrier2_blk",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",2,20],["11Rnd_45ACP_Mag",2,11]]],["B_RadioBag_01_black_F",[]],"H_HeadSet_black_F","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_soldier_M_F",[15328,16085.8,0.7],93,[1],"STAND",[["arifle_SPAR_03_blk_F","","acc_pointer_IR","optic_AMS",["20Rnd_762x51_Mag",20],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",1,20],["11Rnd_45ACP_Mag",1,11]]],["V_PlateCarrier2_blk",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",2,20],["11Rnd_45ACP_Mag",2,11]]],[],"H_HeadSet_black_F","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_T_soldier_M_F",[15327.9,16084,4.8],1,[1],"STAND",[["arifle_SPAR_03_blk_F","","acc_pointer_IR","optic_AMS",["20Rnd_762x51_Mag",20],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_B_GEN_Commander_F",[["FirstAidKit",1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",1,20],["11Rnd_45ACP_Mag",1,11]]],["V_PlateCarrier2_blk",[["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["20Rnd_762x51_Mag",2,20],["11Rnd_45ACP_Mag",2,11]]],[],"H_HeadSet_black_F","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["B_static_AT_F",[15321.3,16094.5,14.1],[[-0.81,0.58,0],[0.01,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[15321.9,16091.9,14.2],[[-0.86,-0.52,0.02],[0.01,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[15329.4,16083.9,10.7],[[-0.25,0.97,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[15333.7,16085.8,14.3],[[0.96,0.27,0],[0,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[15328.6,16083.9,6.6],[[0.96,0.27,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_soldier_M_F",[15316.4,16118.1,4.4],283,[1],"STAND",[["arifle_MXM_khk_F","","acc_pointer_IR","optic_SOS_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],"bipod_01_F_khk"],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_tna_F",[["30Rnd_65x39_caseless_khaki_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_RadioBag_01_eaf_F",[]],"H_HelmetB_tna_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[15391.5,16130.4,23.5],[[0.6,0.8,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[15382.6,16125.8,23.6],[[-0.51,-0.86,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[15381,16134.2,23.6],[[-0.85,0.52,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[15396.7,16101.9,6],[[0,1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[15344.3,16019.8,23.6],[[-0.82,0.57,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[15345.7,16011.2,23.6],[[0.16,-0.99,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[15350.9,16021.6,23.6],[[-0.43,0.9,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_Heli_Attack_01_dynamicLoadout_F",[15354,16105.2,6.2],[[-0.96,-0.28,0.05],[0.04,0.02,1]],[],[["B_Helipilot_F",["driver"],[],[]],["B_Helipilot_F",["turret",[0]],[],[]]]]
		],
		[
			[[15354,16105.3,0.00255966],"MOVE"],
			[[14717,15898.9,176.021],"MOVE"],
			[[15794.6,16773.5,170.174],"MOVE"],
			[[14847.8,15857.6,186.232],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_AAA_System_01_F",[15442.2,16071,29.6],[[-0.95,-0.3,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	/*
	[
		WEST,
		[],
		[],
		[
			["B_Radar_System_01_F",[15362.8,16067,7.2],[[-0.28,0.96,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	*/
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[15373.1,16104,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_HeavyGunner_F",[15367.7,16098.3,0],0,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_M_F",[15363.1,16094,0],0,[],"STAND",[]],
			["B_soldier_LAT_F",[15377.2,16100,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[15381.7,16096.7,0],0,[],"STAND",[["arifle_MX_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetB_light_desert","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[15373.1,16104,0.00170231],"MOVE"],
			[[15408.9,16114.7,6.67572e-006],"MOVE"],
			[[15391.7,16165.3,-8.10623e-005],"MOVE"],
			[[15282.1,16144.3,0.000415802],"MOVE"],
			[[15331.6,15984.1,-4.12464e-005],"MOVE"],
			[[15434.9,16022.5,-3.71933e-005],"MOVE"],
			[[15412.4,16103.9,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_GL_F",[15367.4,16159.9,0],0,[],"STAND",[]],
			["B_Soldier_F",[15372.4,16154.9,0],0,[],"STAND",[]],
			["B_T_Soldier_AA_F",[15371.6,16147.7,0],0,[],"STAND",[["arifle_MXC_khk_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],["launch_B_Titan_tna_F","","","",["Titan_AA",1],[],""],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_tna_F",[["30Rnd_65x39_caseless_khaki_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Kitbag_rgr_BTAA_F",[["Titan_AA",2,1]]],"H_HelmetB_Light_tna_F","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]]
		],
		[],
		[
			[[15367.4,16159.9,0.00143909],"MOVE"],
			[[15257,16123.3,-7.29561e-005],"MOVE"],
			[[15300,15970.6,0.000213623],"MOVE"],
			[[15439.1,16019.3,-1.43051e-006],"MOVE"],
			[[15393.9,16168,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[15370.8,16117.8,0],0,[],"STAND",[]],
			["B_soldier_AR_F",[15375.8,16112.8,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_GL_F",[15365.8,16112.8,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[15380.8,16107.8,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[15370.8,16117.8,0.0015707],"MOVE"],
			[[15414.1,16109.1,0],"MOVE"],
			[[15431.1,16010.5,4.76837e-007],"MOVE"],
			[[15325.4,15966.7,2.86102e-005],"MOVE"],
			[[15282.5,16135.9,0.000261784],"MOVE"],
			[[15393.6,16159.1,6.24657e-005],"MOVE"],
			[[15409.8,16121.4,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[15332.6,16158.2,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[15327.6,16153.2,0],0,[],"STAND",[]],
			["B_soldier_M_F",[15342.6,16148.2,0],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_TL_F",[15322.6,16148.2,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_A_F",[15317.6,16143.2,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",9,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_mcamo_Ammo",[["FirstAidKit",4],["30Rnd_65x39_caseless_mag",6,30],["100Rnd_65x39_caseless_mag",1,100],["NLAW_F",1,1],["HandGrenade",2,1],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",3,1],["3Rnd_HE_Grenade_shell",1,3],["10Rnd_338_Mag",2,10],["20Rnd_762x51_Mag",2,20]]],"H_HelmetB_grass","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[15352.6,16138.2,0],0,[],"STAND",[["arifle_MX_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetB_light_desert","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[15332.6,16158.2,-0.0079217],"MOVE"],
			[[15266.5,16133.1,-0.000164986],"MOVE"],
			[[15316.1,15955.8,9.05991e-006],"MOVE"],
			[[15436.1,16013.4,1.43051e-006],"MOVE"],
			[[15386,16165.8,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_recon_TL_F",[15383.7,16006.5,0],0,[],"STAND",[]],
			["B_recon_M_F",[15388.7,16001.5,0],0,[],"STAND",[]],
			["B_recon_medic_F",[15378.7,16001.5,0],0,[],"STAND",[]],
			["B_recon_LAT_F",[15373.7,15996.5,0],0,[],"STAND",[["arifle_MX_ACO_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_ReconLAT",[["NLAW_F",2,1]]],"H_HelmetB_plain_mcamo","G_Tactical_Clear",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_T_Soldier_AA_F",[15394,15996.5,0],0,[],"STAND",[]]
		],
		[],
		[
			[[15383.7,16006.5,0.0017128],"MOVE"],
			[[15302.7,16004.9,4.76837e-007],"MOVE"],
			[[15250.9,16201.8,0],"MOVE"],
			[[15421.8,16160,0],"MOVE"],
			[[15469.9,16006.5,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_GL_F",[15271.7,15998.1,0],0,[],"STAND",[]],
			["B_Soldier_F",[15276.7,15993.1,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_T_Soldier_AT_F",[15273.1,15984,0],0,[],"STAND",[["arifle_MXC_khk_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],["launch_B_Titan_short_tna_F","","","",["Titan_AT",1],[],""],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_tna_F",[["30Rnd_65x39_caseless_khaki_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_Kitbag_rgr_BTAT_F",[["Titan_AT",2,1],["Titan_AP",1,1]]],"H_HelmetB_Light_tna_F","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]]
		],
		[],
		[
			[[15271.7,15998.1,-1.09673e-005],"MOVE"],
			[[15213.7,16182.9,9.53674e-007],"MOVE"],
			[[15416.8,16199.7,-9.53674e-007],"MOVE"],
			[[15472.6,16022.2,0],"MOVE"],
			[[15287,15960.2,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_T_AFV_Wheeled_01_up_cannon_F",[14977.8,16243.6,20.3],[[0.7,-0.71,0.02],[-0.01,0.01,1]],[],[["B_T_Crew_F",["driver"],[],[]],["B_T_Crew_F",["turret",[0]],[],[]],["B_T_Crew_F",["turret",[0,0]],[],[]]]]
		],
		[
			[[14977.8,16243.6,0],"MOVE"],
			[[15035.8,16190.3,0],"MOVE"],
			[[15706,16265.9,0],"MOVE"],
			[[15686.7,16535.6,0],"MOVE"],
			[[15175.2,16527.2,0],"MOVE"],
			[[14938.8,16286.2,0],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["B_T_Truck_01_flatbed_F",[15378.5,16022.3,7.1],[[0.95,0.31,0],[0,0,1]]],
	["B_T_Truck_01_fuel_F",[15398.4,16026.6,6.3],[[0.29,-0.96,-0.01],[0.01,0,1]]],
	["B_T_LSV_01_AT_F",[15408.8,16057.5,6.2],[[0.94,0.34,-0.01],[0.01,0,1]]],
	["B_T_MRAP_01_F",[15394.1,16024.7,6.6],[[-0.29,0.96,0],[0,0,1]]],
	["B_T_MRAP_01_F",[15390,16023.4,6.6],[[-0.29,0.96,0.01],[0,-0.01,1]]],
	["C_Offroad_01_comms_F",[15338.3,16090.9,6],[[0.96,0.27,-0.02],[0.02,0.01,1]]],
	["C_Offroad_01_comms_F",[15337.2,16094.2,6],[[0.96,0.27,-0.02],[0.01,0.01,1]]],
	["B_Radar_System_01_F",[15362.8,16067,7.2],[[-0.28,0.96,0],[0,0,1]]]
];
_doors = [];
_delete =[];
_pmissBuildings = [
	["Land_Hangar_F",[15359.8,16044.5,10.36-0.98],[[-0.96,-0.28,0],[0,0,1]],true,{},[1,7]],
	["Land_Barracks_06_F",[15331.9,16083.1,9.92],[[0.97,0.26,0],[0,0,1]],true,{},[1,7]],
	["Land_Communication_F",[15372.2,16078,20.78],[[0.96,0.27,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",150,true];}],
	["Land_Stone_8m_F",[15327,16059.2,5.42-0.6],[[0.97,0.26,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15325,16066.7,5.34-0.6],[[0.97,0.26,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15323,16074.3,5.29-0.6],[[0.97,0.26,0],[0,0,1]],true],
	["Land_LampAirport_F",[15328,16066.2,16.64],[[-0.96,-0.27,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15315.7,16101.1,5.41-0.6],[[0.97,0.26,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15318.8,16089.9,5.34-0.6],[[0.97,0.26,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15313.7,16108.8,5.52-0.6],[[0.97,0.26,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15320.9,16082.2,5.32-0.6],[[0.96,0.27,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15316.8,16097.4,5.37-0.6],[[0.97,0.26,0],[0,0,1]],true],
	
	["Land_PortableDesk_01_olive_F",[15377.4,16036.6,5.62],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_TableDesk_F",[15324.2,16090.6,9.6],[[0.27,-0.96,0],[0,0,1]],true],
	["Land_IPPhone_01_black_F",[15324.7,16090.9,10.06],[[0.96,0.27,0],[0,0,1]],true],
	["Land_Laptop_device_F",[15324.1,16090.6,10.18],[[0.07,-1,-0.01],[0,-0.01,1]],true],
	["MapBoard_altis_F",[15320.1,16094.8,10.17],[[-0.89,0.46,0],[0,0,1]],true],
	["Land_OfficeCabinet_01_F",[15321.5,16088.7,9.98],[[0.23,-0.97,0],[0,0,1]],true],
	["Land_OfficeChair_01_F",[15324.9,16089.8,9.87],[[0.73,-0.68,0],[0,0,1]],true],
	["Land_File_research_F",[15323.6,16090.7,10.02],[[0.96,0.27,0],[0,-0.01,1]],true],
	
	["Land_Stone_8m_F",[15314.3,16121.5,5.34-0.6],[[0.28,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15322,16123.7,5.56-0.6],[[0.28,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15329.7,16125.9,5.26-0.6],[[0.29,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15311.5,16116.6,5.61-0.6],[[0.96,0.27,0],[0,0,1]],true],
	["Land_Cargo_Patrol_V1_F",[15316.9,16116.8,9.26],[[0.93,-0.36,0],[0,0,1]],true],
	["Land_LampAirport_F",[15316.7,16112.2,16.84],[[-0.96,-0.27,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15346.6,15863.8,5.24-0.6],[[1,-0.03,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15344.3,16010.9,5.35-0.6],[[0.95,0.31,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15345.5,16007.4,5.23-0.6],[[0.95,0.32,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15341.9,16018.5,5.3-0.6],[[0.95,0.31,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15350.7,16005,5.28-0.6],[[-0.3,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15358.3,16007.3,5.44-0.6],[[-0.3,0.95,0],[0,0,1]],true],
	["Land_LampAirport_F",[15354.7,16007.7,16.49],[[-0.96,-0.27,0],[0,0,1]],true],
	["Land_Cargo_Tower_V1_No1_F",[15349.2,16016.6,16.92],[[-0.96,-0.29,0],[0,0,1]],true],
	["Land_Cargo_Patrol_V1_F",[15333.1,16058.7,9.26],[[0.97,0.24,0],[0,0,1]],true],
	["Land_HelipadRescue_F",[15353.8,16105.3,4.31],[[0.26,-0.96,0.01],[0.04,0.02,1]],true],
	["Land_Stone_8m_F",[15337.5,16128.1,5.35-0.6],[[0.26,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15359.9,16134.3,5.28-0.6],[[0.26,-0.97,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15352.9,16132.3,5.31-0.6],[[0.27,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15345.1,16130.2,5.4-0.6],[[0.26,-0.96,0],[0,0,1]],true],
	["Land_AirConditioner_03_F",[15347.6,16117.3,4.65],[[0.13,-0.99,0],[-0.03,0,1]],false,{BRPVP_pmiss2CharlieFinalHangar = _this;}],
	["Land_AirConditioner_03_F",[15336.8,16114.4,4.81],[[0.13,-0.99,0.01],[0.01,0.01,1]],false],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[15349.7,16124.2,5.6],[[0.25,-0.97,0.01],[-0.01,0.01,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[15338.9,16121.4,5.57],[[0.26,-0.97,0],[0.03,0.01,1]],true],
	["Land_RepairDepot_01_green_F",[15365.2,16013.6,6.71],[[0.96,0.29,0.01],[-0.01,-0.01,1]],true],
	["Land_Stone_8m_F",[15372.4,16011.9,5.58-0.6],[[-0.3,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15386.9,16016.5,5.57-0.6],[[-0.31,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15380,16014.3,5.6-0.6],[[-0.3,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15365.2,16009.6,5.5-0.6],[[-0.31,0.95,0],[0,0,1]],true],
	["WaterPump_01_forest_F",[15384.3,16018.8,5.45],[[-0.73,-0.68,0.01],[0.01,0,1]],false],
	["B_Slingload_01_Fuel_F",[15378.4,16016.4,5.71],[[-0.95,-0.3,0],[0,-0.01,1]],true],
	["Land_MobileRadar_01_generator_F",[15371.9,16014.3,5.96],[[-0.96,-0.29,0],[0,0,1]],false],
	//["Land_CampingChair_V2_F",[15377.1,16039.4,5.48],[[-0.29,0.96,0],[0,0,1]],true],
	//["PowerCable_01_Roll_F",[15375.8,16036.3,5.07],[[-0.29,0.96,0],[0,0,1]],false],
	//["Land_Router_01_olive_F",[15376.9,16036.4,6.19],[[0.28,-0.96,0],[0,0,1]],false],
	//["Land_TripodScreen_01_dual_v1_F",[15379.4,16036.3,5.78],[[-0.65,0.76,0],[0,0,1]],false],
	//["Land_TripodScreen_01_dual_v2_F",[15375.9,16035.1,5.82],[[0.27,0.96,0],[0,0,1]],false],
	//["Land_PortableGenerator_01_F",[15380.5,16036,5.35],[[0.95,0.3,0],[0,0,1]],false],
	//["Land_MobileLandingPlatform_01_F",[15366.4,16034.8,5.15],[[-0.29,0.96,0],[0,0,1]],false],
	//["Land_MRL_Magazine_01_F",[15370.8,16036.4,5.35],[[-0.29,0.96,0],[0,0,1]],false],
	//["CargoNet_01_barrels_F",[15382.3,16037.2,5.5],[[-0.29,0.96,0],[0,0,1]],false],
	//["I_E_CargoNet_01_ammo_F",[15381.7,16039.8,5.8],[[-0.29,0.96,0],[0,0,1]],false],
	//["Land_BatteryPack_01_closed_olive_F",[15378.2,16036.9,5.12],[[-0.29,0.96,0],[0,0,1]],false],
	//["Land_ExtensionCord_F",[15380,16037.3,5.05],[[-0.29,0.96,0],[0,0,1]],false],
	//["Land_DeckTractor_01_F",[15368.7,16058.8,5.64],[[0.72,-0.69,0],[0,0,1]],false],
	//["Land_DieselGroundPowerUnit_01_F",[15374,16062.2,5.82],[[0.96,0.27,0],[0,0,1]],false],
	//["Land_PortableServer_01_olive_F",[15376.8,16036.4,5.15],[[0.29,-0.96,0],[0,0,1]],false],
	//["Land_PortableServer_01_olive_F",[15376.8,16036.3,5.49],[[0.29,-0.96,0],[0,0,1]],false],

	["Land_CampingChair_V2_F",[15378.3,16038.7,5.48],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_CampingChair_V2_F",[15376,16039.1,5.48],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_CampingChair_V2_F",[15375.1,16038.8,5.48],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_CampingChair_V2_F",[15378.1,16039.7,5.48],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_IPPhone_01_olive_F",[15378.2,16036.9,6.32],[[0.32,-0.95,0],[0,0,1]],true],
	["Land_TripodScreen_01_large_F",[15377.8,16035.2,6.02],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_Missle_Trolley_02_F",[15372.7,16037,5.91],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_Bomb_Trolley_01_F",[15374.3,16037.5,5.91],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_File_research_F",[15377.4,16036.7,6.29],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_JetEngineStarter_01_F",[15362.7,16057.8,5.55],[[-0.98,-0.22,0],[0,0,1]],true],

	["Land_Stone_8m_F",[15375.3,16138.5,5.28-0.6],[[0.27,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15367.5,16136.4,5.28-0.6],[[0.26,-0.97,0],[0,0,1]],true],
	["Land_LampAirport_F",[15382.8,16138.4,16.42],[[-0.96,-0.27,0],[0,0,1]],true],
	["Land_AirConditioner_03_F",[15370,16123.3,4.54],[[0.15,-0.99,0],[0,0,1]],false],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[15372.1,16130.3,5.38],[[0.26,-0.96,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[15361.3,16127.3,5.38],[[0.27,-0.96,0],[0,0,1]],true],
	["Land_Cargo_Tower_V1_No1_F",[15385.8,16131.2,16.91],[[-0.96,-0.29,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15383.1,16140.8,5.28-0.6],[[0.27,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15386.3,16141.8,4.9-0.6],[[0.27,-0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15394.5,16019,5.67-0.6],[[-0.3,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15402.1,16021.3,5.65-0.6],[[-0.3,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15409,16023.6,5.57-0.6],[[-0.31,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15416.6,16026,5.64-0.6],[[-0.3,0.95,0],[0,0,1]],true],
	["Land_LampAirport_F",[15417.8,16028,16.78],[[-0.96,-0.27,0],[0,0,1]],true],
	["SatelliteAntenna_01_Olive_F",[15411.8,16040.1,5.33],[[-0.83,-0.56,0.01],[0.01,0,1]],false],
	["Land_TankEngine_01_used_F",[15417.7,16039.4,5.12],[[0.95,0.33,-0.01],[0,0.01,1]],false],
	["WaterPump_01_forest_F",[15419.6,16033.9,5.47],[[0,1,0.01],[0,-0.01,1]],false],
	["Land_PortableGenerator_01_F",[15417.6,16035.8,4.79],[[0,1,0],[0,0,1]],false],
	["Land_AirConditioner_04_F",[15406.5,16047.5,4.91],[[-0.52,-0.85,0.01],[0.01,0.01,1]],false],
	["FlexibleTank_01_forest_F",[15415.2,16039.6,4.92],[[0,1,0],[0,0,1]],false],
	["FlexibleTank_01_forest_F",[15416.2,16040.6,4.91],[[0,1,-0.01],[0,0.01,1]],false],
	["CamoNet_wdl_open_F",[15419.9,16036.5,6.1],[[0.94,0.33,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_open_F",[15414.2,16047.1,5.74],[[0.96,0.29,-0.01],[0,0.01,1]],true],
	["Land_PowerGenerator_F",[15415.3,16041.2,5.19],[[-0.75,-0.66,0.01],[0,0.01,1]],false],
	["Land_Stone_8m_F",[15416.2,16064.7,5.52-0.6],[[0.95,0.31,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15411.5,16079.2,5.58-0.6],[[0.95,0.3,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15413.9,16071.6,5.58-0.6],[[0.95,0.3,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15418.5,16057.6,5.57-0.6],[[0.95,0.3,0],[0,0,1]],true],
	["Land_AirConditioner_03_F",[15401,16070.6,4.78],[[-0.98,-0.18,0],[0,0.01,1]],false],
	["Land_MedicalTent_01_NATO_tropic_generic_outer_F",[15411.1,16057.8,5.66],[[0.96,0.29,-0.01],[0.01,0,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[15404.7,16079.5,5.68],[[-0.95,-0.3,-0.01],[-0.01,-0.01,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[15408,16068.8,5.67],[[-0.96,-0.3,0],[0,0.01,1]],true],
	["Land_Stone_8m_F",[15404.5,16101.3,5.37-0.6],[[-0.95,-0.31,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15409.1,16086.8,5.58-0.6],[[-0.95,-0.3,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15406.7,16094.4,5.5-0.6],[[-0.95,-0.3,0],[0,0,1]],true],
	["Land_LampAirport_F",[15404.9,16094,16.65],[[-0.96,-0.27,0],[0,0,1]],true],
	["Land_AirConditioner_03_F",[15397.6,16081.6,4.76],[[-0.96,-0.29,-0.01],[-0.01,0,1]],false],
	["CargoNet_01_barrels_F",[15403.3,16086.4,4.82],[[0,1,0],[-0.01,0,1]],false],
	["B_CargoNet_01_ammo_F",[15401.8,16088.4,5.09],[[0,1,-0.01],[-0.01,0.01,1]],false],
	["B_CargoNet_01_ammo_F",[15400.4,16086.2,5.09],[[0,1,0],[-0.01,0,1]],false],
	["Land_BarGate_F",[15400.9,16109.6,8.16],[[0.95,0.3,0],[0,0,1]],true],
	["Land_GuardHouse_01_F",[15398,16099.8,5.31],[[-0.29,0.96,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15391.4,16139.3,4.96-0.6],[[-0.95,-0.32,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15397.8,16120,5.05-0.6],[[-0.95,-0.31,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15392.9,16134.9,5.02-0.6],[[-0.95,-0.32,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15395.4,16127.4,5.01-0.6],[[-0.95,-0.31,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15423.1,16043.2,5.59-0.6],[[0.95,0.32,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15426.4,16033.4,5.7-0.6],[[0.95,0.32,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15423.4,16028.3,5.6-0.6],[[-0.32,0.95,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15425.3,16036.6,5.69-0.6],[[0.95,0.32,0],[0,0,1]],true],
	["Land_Stone_8m_F",[15420.9,16050,5.65-0.6],[[0.95,0.3,0],[0,0,1]],true],
	["Land_SM_01_reservoirTower_F",[15443.6,16071.3,14.88],[[0.27,-0.96,0],[0,0,1]],true]
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
	[[15421.4,16010.7,4.36982],15],
	[[15355.7,15985.8,4.49622],15],
	[[15381.5,15994.7,4.71236],15],
	[[15354.4,16120.3,17.2933],55],
	[[15376.6,16047.4,17.2320],55],
	[[15365.5,16083.8,17.2626],55]
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
				_suitCase setVariable ["mny",round (8000000*BRPVP_missionValueMult),true];
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
	[[15361.2,16128.8,4.00798],165.213,20],
	[[15372.2,16130.8,4.00816],166.126,20],
	[[15349.9,16124.8,4.22224],165.634,10],
	[[15338.9,16122.2,4.19568],164.970,10]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmiss2Objects = [_place,_rad,_nos,_ts,[],[],_vd,_hide];

//SPECIAL CHARLIE FINAL
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
	_vehObj setVectorUp [0,0,1];
	_vehObj setDir 75.1445;
	_vehObj setPosASL [15362.2,16045.4,5.1];
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
		{alive _x} count BRPVP_pmiss2ActualAiUnits <= 5;
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
		(!isNull _joiner && {_joiner getVariable ["sok",false]}) || !alive _vehObj || isNull BRPVP_pmiss2CharlieFinalHangar
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
		if (isNull BRPVP_pmiss2CharlieFinalHangar) then {deleteVehicle _vehObj;};
	};
};

//REMOVE PVP AREA IF IN PVE
if (_inPve && !_inPvp) then {
	_key spawn {
		private _key = _this;
		uiSleep 600;
		_key remoteEXecCall ["BRPVP_removePvpArea",2];
		_key remoteExecCall ["BRPVP_removePosCheckLayer",0];
	};
};

BRPVP_pmiss2Spawning = false;