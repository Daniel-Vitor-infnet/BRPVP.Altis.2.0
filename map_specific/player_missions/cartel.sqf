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
		[],
		[
			["I_C_Offroad_02_LMG_F",[23584.3,24072.3,5.6],[[-0.58,-0.82,-0.01],[-0.09,0.05,0.99]],[4],[["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_high_F",[23574.7,24062.5,5.8],[[0.2,-0.98,0],[0,0,1]],[4],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]]
		],
		[]
	],
		[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_7_F",[23311,24326.5,14.5],165,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_7_F",[23314.5,24331.4,14.1],85,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_7_F",[23682.1,24256.3,14.4],85,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_7_F",[23678.4,24251.3,14.2],170,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_C_Offroad_02_AT_F",[23682.3,24284.4,76.4],[[0.91,-0.4,0.08],[-0.09,0,1]],[4],[["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]],
			["I_C_Offroad_02_LMG_F",[23684.4,24236,78.1],[[0.83,-0.56,0.02],[-0.07,-0.07,0.99]],[4],[["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_7_F",[23279,24064,20.2],51,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_C_HMG_02_high_F",[23377.2,24014.8,4.6],[[0.61,0.8,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_7_F",[23567.3,24172.9,0],85,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_1_F",[23273,24185.9,2.6],73,[1],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_AK12_Mag_F",3,30],["HandGrenade",2,1]]],[],"H_Bandanna_sgg","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_6_F",[23573.3,24381.6,0],69,[1],"STAND",[["arifle_AK12_GL_F","","","",["30Rnd_762x39_AK12_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["1Rnd_HE_Grenade_shell",5,1]]],[],"","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_7_F",[23575.9,24377.6,0],53,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_6_F",[23578.3,24372.2,0],69,[1],"STAND",[["arifle_AK12_GL_F","","","",["30Rnd_762x39_AK12_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["1Rnd_HE_Grenade_shell",5,1]]],[],"H_Cap_blk_Syndikat_F","G_Bandanna_tan",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_C_Offroad_02_LMG_F",[23559.5,24381.1,42.7],[[0.71,0.7,0.01],[-0.08,0.07,0.99]],[4],[["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_6_F",[23404.6,24192.8,0],69,[1],"STAND",[["arifle_AK12_GL_F","","","",["30Rnd_762x39_AK12_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["1Rnd_HE_Grenade_shell",5,1]]],[],"H_Bandanna_camo","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_6_F",[23397.1,24186.4,0],105,[1],"STAND",[]]
		],
		[
			["I_C_Offroad_02_AT_F",[23410.4,24186.5,7.8],[[0.96,-0.25,-0.16],[0.14,-0.09,0.99]],[4],[["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_high_F",[23391.3,24191.5,6],[[0,1,-0.04],[-0.05,0.04,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_5_F",[23445.1,24203.7,0],0,[1],"STAND",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],["launch_RPG7_F","","","",["RPG7_F",1],[],""],[],["U_I_C_Soldier_Para_5_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_F",1,30]]],[],["B_Kitbag_cbr_Para_5_F",[["30Rnd_545x39_Mag_F",4,30],["RPG7_F",3,1]]],"H_Bandanna_cbr","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_5_F",[23367.9,24253.6,0],164,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_1_F",[23377.6,24247.6,0],165,[1],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_AK12_Mag_F",3,30],["HandGrenade",2,1]]],[],"","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Camo_F",[23376,24404,4],136,[1,2],"STAND",[[],[],["hgun_Pistol_heavy_02_F","","","",["6Rnd_45ACP_Cylinder",6],[],""],["U_B_GEN_Soldier_F",[["FirstAidKit",1],["6Rnd_45ACP_Cylinder",3,6]]],["V_Rangemaster_belt",[]],[],"H_Beret_CSAT_01_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_1_F",[23361,24399.1,0],0,[1],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_AK12_Mag_F",3,30],["HandGrenade",2,1]]],[],"H_Cap_blk_Syndikat_F","G_Bandanna_aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23382,24396.8,0.7],200,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23380,24400.6,0.5],177,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23370.4,24393.4,1],50,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23374.6,24406.1,0.2],177,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23380.5,24393.4,4.5],358,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_C_HMG_02_high_F",[23374.7,24399.9,20.3],[[0.62,-0.78,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_high_F",[23374.5,24402.2,23.9],[[0.99,-0.14,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]],
			["I_C_Offroad_02_AT_F",[23373.7,24374.6,18.9],[[0.97,-0.23,0],[0,0,1]],[4],[["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Camo_F",[23356,24171.7,4.1],40,[1,2],"STAND",[[],[],["hgun_Pistol_heavy_02_F","","","",["6Rnd_45ACP_Cylinder",6],[],""],["U_B_GEN_Soldier_F",[["FirstAidKit",1],["6Rnd_45ACP_Cylinder",3,6]]],["V_Rangemaster_belt",[]],[],"H_Beret_CSAT_01_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23364.9,24179.4,4.4],233,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23363,24180.6,0.9],109,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23358.4,24177,0.7],75,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23367.2,24169.8,0.9],312,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23354.6,24170.8,0.5],88,[1],"STAND",[["arifle_AK12U_arid_F","","acc_pointer_IR","optic_Holosight_arid_F",["30rnd_762x39_AK12_Arid_Mag_F",30],[],""],[],[],["U_BG_Guerrilla_6_1",[["FirstAidKit",1],["30rnd_762x39_AK12_Arid_Mag_F",2,30]]],["V_CarrierRigKBT_01_Olive_F",[]],[],"","G_Balaclava_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_6_F",[23334.3,24172.8,0],111,[1],"STAND",[["arifle_AK12_GL_F","","","",["30Rnd_762x39_AK12_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["1Rnd_HE_Grenade_shell",5,1]]],[],"","G_Shades_Blue",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_C_Offroad_02_LMG_F",[23373.4,24187.9,6.1],[[0.86,0.51,-0.01],[0.01,0,1]],[4],[["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_high_F",[23360.9,24172.2,6.7],[[0.58,0.82,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_high_F",[23358.4,24171.2,10.2],[[0.51,0.86,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_7_F",[23440,24229.1,7],85,[1],"STAND",[["srifle_DMR_05_tan_f","muzzle_snds_93mmg_tan","acc_pointer_IR","optic_AMS",["10Rnd_93x64_DMR_05_Mag",10],[],"bipod_02_F_tan"],["launch_O_Vorona_brown_F","","","",[],[],""],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_93x64_DMR_05_Mag",2,10]]],["V_Chestrig_khk",[["HandGrenade",2,1],["10Rnd_93x64_DMR_05_Mag",1,10]]],[],"H_Booniehat_khk_hs","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["I_G_Mortar_01_F",[23439.4,24216.3,13.5],[[0.78,-0.63,0],[0,0,1]],[],[["I_G_Soldier_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_high_F",[23444.8,24220.7,14.5],[[0.82,0.57,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]],
			["I_C_HMG_02_high_F",[23434.1,24223.4,14.5],[[-0.97,0.26,0],[0,0,1]],[],[["I_C_Soldier_Para_3_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_Boat_Armed_01_minigun_F",[23457.6,23923,3.3],[[-0.38,-0.93,0],[0,0,1]],[],[["I_soldier_F",["driver"],[],[]],["I_soldier_F",["turret",[0]],[],[]],["I_soldier_F",["turret",[1]],[],[]]]]
		],
		[
			[[23457.6,23923,0.0454715],"MOVE"],
			[[23386.5,23590.8,-15.0698],"MOVE"],
			[[22974.6,23720.1,-0.208114],"MOVE"],
			[[23219.4,23939.2,-0.0346447],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_Heli_light_03_dynamicLoadout_F",[23337.6,24212.6,5.6],[[0,1,0.02],[-0.14,-0.02,0.99]],[],[["I_helipilot_F",["driver"],[],[]],["I_helipilot_F",["turret",[0]],[],[]]]]
		],
		[
			[[23337.8,24212.6,0.000413895],"MOVE"],
			[[23684.8,24407,133.189],"MOVE"],
			[[23087.1,23860.2,149.11],"MOVE"],
			[[23325.6,24754.3,135.598],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_2_F",[23543.3,24108.4,0],0,[],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Para_2_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_TacVest_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["10Rnd_9x21_Mag",2,10],["HandGrenade",2,1]]],[],"","G_Shades_Blue",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_4_F",[23548.3,24103.4,0],0,[],"STAND",[["LMG_03_F","","","",["200Rnd_556x45_Box_F",200],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_9x21_Mag",2,10]]],["V_Chestrig_blk",[["200Rnd_556x45_Box_F",2,200]]],[],"","G_Shades_Blue",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_6_F",[23538.3,24103.4,0],0,[],"STAND",[["arifle_AK12_GL_F","","","",["30Rnd_762x39_AK12_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["1Rnd_HE_Grenade_shell",5,1]]],[],"H_Cap_oli_Syndikat_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_1_F",[23553.3,24098.4,0],0,[],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_AK12_Mag_F",3,30],["HandGrenade",2,1]]],[],"H_Bandanna_cbr","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_7_F",[23533.3,24098.4,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_Mag_F",3,30],["HandGrenade",2,1]]],[],"H_Bandanna_cbr","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_5_F",[23558.3,24093.4,0],0,[],"STAND",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],["launch_RPG7_F","","","",["RPG7_F",1],[],""],[],["U_I_C_Soldier_Para_5_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_F",1,30]]],[],["B_Kitbag_cbr_Para_5_F",[["30Rnd_545x39_Mag_F",4,30],["RPG7_F",3,1]]],"","G_Bandanna_blk",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23528.3,24093.4,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_2_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],[],["B_Kitbag_rgr_Para_8_F",[["ToolKit",1],["30Rnd_762x39_Mag_F",4,30],["DemoCharge_Remote_Mag",3,1],["SatchelCharge_Remote_Mag",1,1]]],"","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_3_F",[23563.3,24088.4,0],0,[],"STAND",[]]
		],
		[],
		[
			[[23543.3,24108.4,0.000276566],"MOVE"],
			[[23443.6,24183,4.76837e-007],"MOVE"],
			[[23542.2,24284.1,-3.8147e-006],"MOVE"],
			[[23416.4,24370.5,-0.000841141],"MOVE"],
			[[23329.7,24250.1,-0.000160694],"MOVE"],
			[[23424.1,24161.5,-0.000279427],"MOVE"],
			[[23538.2,24098.3,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_2_F",[23392.9,24175.3,0],0,[],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Para_2_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_TacVest_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["10Rnd_9x21_Mag",2,10],["HandGrenade",2,1]]],[],"","G_Shades_Blue",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_4_F",[23397.9,24170.3,0],0,[],"STAND",[]],
			["I_C_Soldier_Para_1_F",[23387.9,24170.3,0],0,[],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_AK12_Mag_F",3,30],["HandGrenade",2,1]]],[],"","G_Shades_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_3_F",[23402.9,24165.3,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_3_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],[],["B_Kitbag_rgr_Para_3_F",[["Medikit",1],["FirstAidKit",4],["30Rnd_762x39_Mag_F",4,30]]],"","G_Bandanna_tan",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[
			[[23392.9,24175.3,0.00321627],"MOVE"],
			[[23311.4,24286,-0.00070858],"MOVE"],
			[[23422.6,24405.5,0.000118256],"MOVE"],
			[[23558.3,24341.4,-0.000480652],"MOVE"],
			[[23411,24179.2,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Bandit_4_F",[23609.5,24245.2,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Bandit_4_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],["V_BandollierB_blk",[["30Rnd_762x39_Mag_F",4,30],["MiniGrenade",2,1]]],[],"H_Bandanna_khk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Bandit_3_F",[23614.5,24240.2,0],0,[],"STAND",[["LMG_03_F","","","",["200Rnd_556x45_Box_F",200],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Bandit_3_F",[["FirstAidKit",1],["10Rnd_9x21_Mag",2,10]]],[],["B_FieldPack_cb_Bandit_3_F",[["200Rnd_556x45_Box_F",2,200]]],"","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Bandit_5_F",[23604.5,24240.2,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Bandit_5_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],["V_Chestrig_blk",[["30Rnd_762x39_Mag_F",4,30],["MiniGrenade",2,1]]],[],"H_Bandanna_sand","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Bandit_1_F",[23619.5,24235.2,0],0,[],"STAND",[]]
		],
		[],
		[
			[[23609.5,24245.2,0.00608826],"MOVE"],
			[[23485.5,24186.6,-0.000829697],"MOVE"],
			[[23395.6,24327.3,-0.000511169],"MOVE"],
			[[23468.7,24399.4,0.00022316],"MOVE"],
			[[23586.1,24265.6,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Bandit_4_F",[23243.4,24293.5,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Bandit_4_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],["V_BandollierB_blk",[["30Rnd_762x39_Mag_F",4,30],["MiniGrenade",2,1]]],[],"H_Cap_blk_Syndikat_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Bandit_3_F",[23248.4,24288.5,0],0,[],"STAND",[["LMG_03_F","","","",["200Rnd_556x45_Box_F",200],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Bandit_3_F",[["FirstAidKit",1],["10Rnd_9x21_Mag",2,10]]],[],["B_FieldPack_cb_Bandit_3_F",[["200Rnd_556x45_Box_F",2,200]]],"H_Booniehat_oli","G_Shades_Red",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Bandit_5_F",[23238.4,24288.5,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Bandit_5_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],["V_Chestrig_blk",[["30Rnd_762x39_Mag_F",4,30],["MiniGrenade",2,1]]],[],"H_Bandanna_khk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Bandit_1_F",[23253.4,24283.5,0],0,[],"STAND",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Bandit_1_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_F",1,30]]],[],["B_FieldPack_khk_Bandit_1_F",[["Medikit",1],["FirstAidKit",4],["30Rnd_545x39_Mag_F",4,30]]],"H_Bandanna_sgg","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[
			[[23243.4,24293.5,-0.00341415],"MOVE"],
			[[23571.6,24090.3,3.17097e-005],"MOVE"],
			[[23555.4,24304.6,0],"MOVE"],
			[[23321.5,24296.4,-0.000999451],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_C_Soldier_Para_2_F",[23496.9,24306.7,0],0,[],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Para_2_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_TacVest_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["10Rnd_9x21_Mag",2,10],["HandGrenade",2,1]]],[],"","G_Bandanna_aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_4_F",[23501.9,24301.7,0],0,[],"STAND",[["LMG_03_F","","","",["200Rnd_556x45_Box_F",200],[],""],[],["hgun_Pistol_01_F","","","",["10Rnd_9x21_Mag",10],[],""],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["10Rnd_9x21_Mag",2,10]]],["V_Chestrig_blk",[["200Rnd_556x45_Box_F",2,200]]],[],"H_Booniehat_oli","G_Bandanna_sport",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_6_F",[23491.9,24301.7,0],0,[],"STAND",[["arifle_AK12_GL_F","","","",["30Rnd_762x39_AK12_Mag_F",30],["1Rnd_HE_Grenade_shell",1],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_oli",[["30Rnd_762x39_AK12_Mag_F",3,30],["1Rnd_HE_Grenade_shell",5,1]]],[],"","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_1_F",[23506.9,24296.7,0],0,[],"STAND",[["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_1_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_AK12_Mag_F",3,30],["HandGrenade",2,1]]],[],"H_Bandanna_sand","G_Shades_Blue",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_7_F",[23486.9,24296.7,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_4_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",2,30]]],["V_Chestrig_khk",[["30Rnd_762x39_Mag_F",3,30],["HandGrenade",2,1]]],[],"H_Bandanna_sand","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_5_F",[23511.9,24291.7,0],0,[],"STAND",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],["launch_RPG7_F","","","",["RPG7_F",1],[],""],[],["U_I_C_Soldier_Para_5_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_F",1,30]]],[],["B_Kitbag_cbr_Para_5_F",[["30Rnd_545x39_Mag_F",4,30],["RPG7_F",3,1]]],"","G_Shades_Blue",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_8_F",[23481.9,24291.7,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_2_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],[],["B_Kitbag_rgr_Para_8_F",[["ToolKit",1],["30Rnd_762x39_Mag_F",4,30],["DemoCharge_Remote_Mag",3,1],["SatchelCharge_Remote_Mag",1,1]]],"H_Bandanna_surfer_blk","G_Shades_Blue",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_C_Soldier_Para_3_F",[23516.9,24286.7,0],0,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_I_C_Soldier_Para_3_F",[["FirstAidKit",1],["30Rnd_762x39_Mag_F",1,30]]],[],["B_Kitbag_rgr_Para_3_F",[["Medikit",1],["FirstAidKit",4],["30Rnd_762x39_Mag_F",4,30]]],"H_Bandanna_surfer_blk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[
			[[23496.9,24306.7,-0.00844955],"MOVE"],
			[[23351.9,24278.5,-0.000688553],"MOVE"],
			[[23486.9,24133.9,-0.000113487],"MOVE"],
			[[23659.9,24244,-0.000213623],"MOVE"],
			[[23611,24362.2,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_C_Offroad_02_LMG_F",[23641,24008.7,14.1],[[0,1,-0.03],[0.01,0.03,1]],[],[["I_C_Soldier_Para_1_F",["driver"],[],[]],["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]]
		],
		[
			[[23641,24008.8,2.18629],"MOVE"],
			[[23933.9,24349.2,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_C_Offroad_02_LMG_F",[23659.9,23994.4,14.5],[[0,1,-0.03],[0,0.03,1]],[],[["I_C_Soldier_Para_1_F",["driver"],[],[]],["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]]
		],
		[
			[[23659.9,23994.4,2.18511],"MOVE"],
			[[23858.3,23827,0],"CYCLE"]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_C_Offroad_02_LMG_F",[23381.2,24333.2,16.6],[[-0.15,-0.98,-0.1],[-0.01,-0.1,1]],[],[["I_C_Soldier_Para_1_F",["driver"],[],[]],["I_C_Soldier_Para_1_F",["turret",[0]],[],[]]]]
		],
		[
			[[23381.2,24333.4,-0.00355053],"MOVE"],
			[[23324.6,24253.7,-4.76837e-007],"MOVE"],
			[[23384.2,24365.6,0],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["I_C_Offroad_02_unarmed_F",[23344.5,24194.2,6.2],[[0.63,0.77,0],[0,0,1]]],
	["I_C_Offroad_02_unarmed_F",[23363.3,24187.2,5.6],[[0.63,0.77,-0.01],[0,0.01,1]]],
	["I_C_Offroad_02_unarmed_F",[23360.2,24189.4,5.6],[[0.63,0.77,-0.01],[0.02,0,1]]],
	["I_C_Offroad_02_unarmed_F",[23357.3,24191.7,5.7],[[0.63,0.77,-0.01],[0.02,0,1]]],
	["I_C_Offroad_02_unarmed_F",[23374.7,24382.1,18.4],[[-0.58,0.81,-0.07],[-0.04,0.05,1]]],
	["I_C_Offroad_02_unarmed_F",[23377.8,24385,18.6],[[0.5,-0.86,0.06],[-0.11,0.01,0.99]]],
	["I_C_Van_02_vehicle_F",[23386,24386.4,19.6],[[-0.39,-0.92,-0.06],[-0.15,0,0.99]]],
	["I_C_Van_01_transport_F",[23428.2,24217,6],[[0.8,0.6,0],[0.01,-0.01,1]]],
	["I_C_Van_02_vehicle_F",[23430.7,24213,5.7],[[-0.79,-0.61,-0.01],[-0.01,-0.01,1]]],
	["I_C_Boat_Transport_02_F",[23265.2,24181,1.3],[[0.99,-0.14,0],[0,0,1]]],
	["I_C_Boat_Transport_02_F",[23294.9,24196.8,2.7],[[-0.99,0.15,0],[0,0,1]]],
	["I_C_Boat_Transport_02_F",[23313.1,24137.3,1.3],[[-0.42,-0.91,0],[0,0,1]]],
	["I_C_Boat_Transport_01_F",[23325.4,24141.2,1.2],[[0,1,0],[0,0,1]]]
];
_doors = [];
_delete = [];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["Land_GarageShelter_01_F",[6543.08,22674.9,90.74],[[-1,-0.03,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23227.1,24278.1,6.59],[[0,1,0],[0,0,1]],true],
	["Land_LightHouse_F",[23275.2,24064.8,12.4],[[-0.72,0.69,0],[0,0,1]],true],
	["Land_fs_feed_F",[23274.5,24182,3.37],[[0.13,0.99,0],[0,0,1]],false],
	["Land_WarehouseShelter_01_F",[23268,24183.9,5.38],[[-0.12,-0.99,0],[0,0,1]],false],
	["Land_Destroyer_01_Boat_Rack_01_F",[23263.5,24186.7,1.74],[[0.99,-0.14,0],[0,0,1]],false],
	["Land_LampStreet_small_F",[23269.8,24277.6,5.99],[[0,1,0],[0,0,1]],true],
	["Land_nav_pier_m_F",[23280.4,24184.8,-21.3],[[0.14,0.99,0],[0,0,1]],false],
	["Land_Airport_01_controlTower_F",[23309.6,24331.2,33.96],[[0.81,-0.59,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampStreet_small_F",[23319.6,24149.8,7.3],[[0,1,0],[0,0,1]],true],
	["Land_PierWooden_01_dock_F",[23314.4,24140.2,-16.59],[[-0.44,-0.9,0],[0,0,1]],false],
	["Land_PoleWall_01_6m_F",[23327.9,24160.1,4.35],[[1,-0.05,0],[0,0,1]],false],
	["Land_PicnicTable_01_F",[23336.9,24160.5,4.24],[[0.71,0.7,0],[0,0,1]],false],
	["Land_PicnicTable_01_F",[23339.9,24157.4,4.29],[[0.71,0.7,0],[0,0,1]],false],
	["Land_LampAirport_F",[23335.6,24192.6,16.87],[[0.65,0.76,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23311.4,24257.4,8.1],[[0,1,0],[0,0,1]],true],
	["Land_PierWooden_01_platform_F",[23359.9,24114.4,-17.12],[[0,-1,0],[0,0,1]],false],
	["Land_LampStreet_small_F",[23357.1,24146.6,5.43],[[0,1,0],[0,0,1]],true],
	["Land_PierWooden_01_16m_F",[23359.8,24139,-17.42],[[0,1,0],[0,0,1]],false],
	["Land_PierWooden_01_16m_F",[23359.8,24123.3,-17.42],[[0,1,0],[0,0,1]],false],
	["Land_Hotel_02_F",[23358.7,24174.8,8.4],[[0.76,-0.65,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_GarageShelter_01_F",[23346.3,24192.7,5.88],[[-0.65,-0.76,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23345.1,24237.1,9.7],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23348.5,24262.4,12.85],[[0,1,0],[0,0,1]],true],
	["Land_LampAirport_F",[23350.2,24392.8,30.11],[[0.39,-0.92,0],[0,0,1]],true],
	["Land_PicnicTable_01_F",[23362.8,24403,18.52],[[0.62,-0.79,0],[0,0,1]],false],
	["Land_PierWooden_02_hut_F",[23377.9,24012.7,-14.72],[[-0.69,-0.73,0],[0,0,1]],false],
	["Land_LampAirport_F",[23371.6,24158.4,14.84],[[0.65,0.76,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23371.6,24207.6,8.14],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23372.9,24294,16.63],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23392.3,24341,18.54],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23371.2,24383,19.84],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23374.5,24412.1,21.67],[[0,1,0],[0,0,1]],true],
	["Land_Hotel_02_F",[23377.5,24401,22.01],[[-0.8,-0.6,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampAirport_F",[23392.5,24423.1,30.79],[[0.67,-0.74,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23429.4,24164,8.25],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23411.6,24218.1,7.19],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23406.1,24390.1,22.48],[[0,1,0],[0,0,1]],true],
	["Land_GarageShelter_01_F",[23405.1,24398,21.02],[[0.8,0.59,0],[0,0,1]],true],
	["Land_LampAirport_F",[23441.8,24212.3,16.77],[[0,1,0],[0,0,1]],true],
	["Land_PoliceStation_01_F",[23440,24218.7,11.52],[[0.8,0.59,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampStreet_small_F",[23470.4,24145.8,8.52],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_small_F",[23501.2,24121.5,6.7],[[0,1,0],[0,0,1]],true],
	["Land_IndFnc_9_F",[23544.4,24046.3,2.09],[[-0.58,0.81,0],[0,0,1]],false],
	["Land_LampStreet_small_F",[23546.3,24093.3,6.77],[[0,1,0],[0,0,1]],true],
	["Land_IndFnc_9_F",[23550.8,24050.3,4.39],[[-0.58,0.81,0],[0,0,1]],false],
	["Land_IndFnc_9_F",[23558,24055.4,5.1],[[-0.58,0.81,0],[0,0,1]],false],
	["Land_IndFnc_9_F",[23563.6,24059.3,4.79],[[-0.45,0.89,0],[0,0,1]],false],
	["Land_LampAirport_F",[23563.4,24066.4,15.11],[[0,1,0],[0,0,1]],true],
	["Land_GuardHouse_01_F",[23572.3,24066.5,5.14],[[0.98,0.18,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampStreet_small_F",[23586.9,24066.9,7.11],[[0,1,0],[0,0,1]],true],
	["Land_IndFnc_9_F",[23598.3,24081.1,8.63],[[-0.99,0.17,0],[0,0,1]],false],
	["Land_IndFnc_9_F",[23589.4,24064.9,6.06],[[-0.58,0.81,0],[0,0,1]],false],
	["Land_IndFnc_9_F",[23596.7,24072.5,7.94],[[-0.98,0.22,0],[0,0,1]],false],
	["Land_RoadBarrier_01_F",[23580.3,24061.8,7.72],[[0.24,-0.97,0],[0,0,1]],true],
	["Land_Airport_01_controlTower_F",[23677.2,24256.1,86.4],[[0.81,-0.59,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}]
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
	[[23356.7,24201.0,4.34465],25],
	[[23373.7,24386.4,17.1533],25],
	[[23401.4,24411.3,18.5708],25],
	[[23338.7,24168.9,4.17358],05],
	[[23323.8,24158.3,4.26657],05],
	[[23347.3,24153.2,4.29842],05],
	[[23368.7,24414.3,17.8778],05],
	[[23354.3,24397.9,18.2727],05]
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
					_suitCase setVariable ["mny",round (5000000*BRPVP_missionValueMult),true];
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
	[[23363.2,24180.5,8.51248],221.685,25],
	[[23382.2,24395.2,22.1157],323.644,25]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,_hide,{true}];
BRPVP_pmissSpawning = false;