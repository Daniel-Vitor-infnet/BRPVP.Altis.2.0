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

private _place = _this select 0;
private _rad = _this select 1;
private _skill = _this select 2;

private _pFix = [0,0,0];
private _pFix2D = [0,0,0];

BRPVP_pmissEndCheckObjects = [];

private _pmissGroups = [
	[
		INDEPENDENT,
		[],
		[
			["I_Officer_Parade_Veteran_F",[21965.2,21048.4,6.5],115,[],"STAND",[[],[],[],["U_C_FormalSuit_01_blue_F",[]],[],[],"","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21962.3,21046.7,8.7],114,[],"STAND",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21964.9,21051.2,6.4],122,[],"STAND",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21965.1,21042.8,9.1],167,[],"STAND",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21969.2,21040.6,7.8],210,[],"STAND",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_Soldier_F",[21958.4,21011.5,0.6],220,[],"CROUCH",[["srifle_DMR_06_hunter_F","","","",["10Rnd_Mk14_762x51_Mag",10],[],""],["launch_MRAWS_olive_rail_F","","","",["MRAWS_HEAT_F",1],[],""],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["10Rnd_Mk14_762x51_Mag",2,10]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["10Rnd_Mk14_762x51_Mag",10,10]]],["B_AssaultPack_dgtl",[["MRAWS_HEAT_F",2,1]]],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21963.2,21020.2,12.5],126,[],"CROUCH",[["LMG_Zafir_F","","","",["150Rnd_762x54_Box",150],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1]]],["V_PlateCarrierIA2_dgtl",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["150Rnd_762x54_Box",1,150]]],[],"H_CrewHelmetHeli_I","G_Balaclava_TI_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]]
		],
		[
			["I_G_HMG_02_high_F",[21984.2,21024,30.8],[[-0.48,0.88,0],[0,0,1]],[],[["I_G_Soldier_F",["turret",[0]],[],[["arifle_TRG21_F","","","",["30Rnd_556x45_Stanag",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["30Rnd_556x45_Stanag",1,30],["MiniGrenade",1,1]]],["V_Chestrig_oli",[["30Rnd_556x45_Stanag",4,30],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1]]],[],"H_Bandanna_blu","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]]],
			["I_G_HMG_02_high_F",[21941.5,21044.4,26.3],[[0.89,-0.45,0],[0,0,1]],[],[["I_G_Soldier_F",["turret",[0]],[],[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_545x39_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_545x39_Mag_F",6,30]]],[],"H_Shemag_olive","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]]],
			["I_C_Offroad_02_AT_F",[21988.7,21031.1,30.6],[[0.85,0.52,0.01],[-0.01,0,1]],[],[["I_G_Soldier_F",["turret",[0]],[]]]],
			["I_HMG_02_high_F",[21989.6,21030.5,35.7],[[-0.95,-0.3,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]]],
			["I_G_HMG_02_F",[21947.9,21056,25.9],[[-0.59,-0.81,0],[0,0,1]],[],[["I_G_Soldier_F",["turret",[0]],[]]]]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_GMG_01_high_F",[21963.5,21019.8,28.5],[[-0.67,-0.74,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_G_Story_Protagonist_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",3,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]]]],
			["I_GMG_01_high_F",[21965.7,21017.7,28.5],[[-0.68,-0.73,0],[0,0,1]],[],[["I_soldier_F",["turret",[0]],[],[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_G_Story_Protagonist_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",3,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]]]]
		]
	],
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_G_HMG_02_high_F",[21960.5,21013,21.2],[[-0.69,-0.72,0],[0,0,1]],[],[["I_G_Soldier_F",["turret",[0]],[],[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]]],
			["I_G_HMG_02_high_F",[21958.3,21013,21.2],[[-0.69,-0.72,0],[0,0,1]],[],[["I_G_Soldier_F",["turret",[0]],[],[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]]]
		]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_Soldier_F",[21949.4,21040.9,2.2],123,[],"CROUCH",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21952.3,21036.8,3.5],101,[],"CROUCH",[["srifle_DMR_06_hunter_F","","","",["10Rnd_Mk14_762x51_Mag",10],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["10Rnd_Mk14_762x51_Mag",2,10]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["10Rnd_Mk14_762x51_Mag",10,10]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21959.7,21032.4,4.8],132,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21965.8,21029.9,5.9],182,[],"CROUCH",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_545x39_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_545x39_Mag_F",6,30]]],[],"H_Shemag_olive","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21941.9,21042.3,1.5],108,[],"CROUCH",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_545x39_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_545x39_Mag_F",6,30]]],[],"H_Shemag_olive","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21964.8,21030.1,5.8],168,[],"CROUCH",[["srifle_DMR_06_hunter_F","","","",["10Rnd_Mk14_762x51_Mag",10],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["10Rnd_Mk14_762x51_Mag",2,10]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["10Rnd_Mk14_762x51_Mag",10,10]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21962.7,21019.9,3.2],182,[],"CROUCH",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_545x39_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_545x39_Mag_F",6,30]]],[],"H_Shemag_olive","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21965.9,21016.7,3.2],236,[],"CROUCH",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_545x39_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_545x39_Mag_F",6,30]]],[],"H_Shemag_olive","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21975.5,21017.7,5.7],319,[],"CROUCH",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_545x39_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_545x39_Mag_F",6,30]]],[],"H_Shemag_olive","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_soldier_F",[21965.9,21031.9,14.1],123,[],"CROUCH",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21967.8,21028.2,14.8],210,[],"STAND" ,[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21983.6,21023.7,05.4],272,[],"CROUCH",[["arifle_RPK12_F","","acc_pointer_IR","optic_Holosight_blk_F",["75rnd_762x39_AK12_Mag_F",75],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["HandGrenade",5,1],["75rnd_762x39_AK12_Mag_F",3,75]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21983.1,21038.3,05.3],223,[],"CROUCH",[["arifle_RPK12_F","","acc_pointer_IR","optic_Holosight_blk_F",["75rnd_762x39_AK12_Mag_F",75],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["HandGrenade",5,1],["75rnd_762x39_AK12_Mag_F",3,75]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21967.2,21024.6,15.0],226,[],"CROUCH",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_Soldier_F",[21966.5,21047.7,1.5],224,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21958.9,21041.1,6.6],281,[],"CROUCH",[["arifle_CTARS_ghex_F","","","optic_Aco_smg",["100Rnd_580x42_ghex_Mag_F",100],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["100Rnd_580x42_ghex_Mag_F",1,100]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21943,21045.6,5.2],40,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21947.3,21054,4.9],45,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21958,21047.4,5.6],118,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_Soldier_F",[21987.3,21026.3,0.8],323,[],"STAND",[["LMG_Zafir_F","","","",["150Rnd_762x54_Box",150],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1]]],["V_PlateCarrierIA2_dgtl",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["150Rnd_762x54_Box",1,150]]],[],"H_CrewHelmetHeli_I","G_Balaclava_TI_blk_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_INDEP"]]],
			["I_G_Soldier_F",[21975.2,21028.1,9.4],339,[],"CROUCH",[["srifle_DMR_06_hunter_F","","","",["10Rnd_Mk14_762x51_Mag",10],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["10Rnd_Mk14_762x51_Mag",2,10]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["10Rnd_Mk14_762x51_Mag",10,10]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21976.1,21028.5,8.4],342,[],"CROUCH",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21978.5,21029.2,5.5],294,[],"CROUCH",[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_545x39_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",4,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_545x39_Mag_F",6,30]]],[],"H_Shemag_olive","G_Shades_Green",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21985.4,21030,0.9],313,[],"STAND",[["srifle_DMR_06_hunter_F","","","optic_DMS_weathered_F",["10Rnd_Mk14_762x51_Mag",10],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["10Rnd_Mk14_762x51_Mag",2,10]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["10Rnd_Mk14_762x51_Mag",10,10]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21988.1,21035.6,0.8],298,[],"CROUCH",[["arifle_CTARS_ghex_F","","","optic_Aco_smg",["100Rnd_580x42_ghex_Mag_F",100],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["100Rnd_580x42_ghex_Mag_F",1,100]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21976.1,21038.5,0.9],321,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21977.1,21039.4,1],314,[],"CROUCH",[["srifle_DMR_06_hunter_F","","","",["10Rnd_Mk14_762x51_Mag",10],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["10Rnd_Mk14_762x51_Mag",2,10]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["10Rnd_Mk14_762x51_Mag",10,10]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21973.3,21023.7,10.3],12,[],"CROUCH",[["srifle_DMR_06_hunter_F","","","",["10Rnd_Mk14_762x51_Mag",10],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["10Rnd_Mk14_762x51_Mag",2,10]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["10Rnd_Mk14_762x51_Mag",10,10]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21969.6,21027.2,10.3],355,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_CarrierRigKBT_01_Olive_F",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_officer_F",[21970.1,21045.5,6.2],297,[],"STAND",[["arifle_ARX_blk_F","muzzle_snds_65_TI_blk_F","acc_flashlight","optic_Arco_blk_F",["30Rnd_65x39_caseless_green",30],["10Rnd_50BW_Mag_F",10],""],[],[],["U_BG_leader",[["FirstAidKit",1],["30Rnd_65x39_caseless_green",3,30]]],["V_Chestrig_oli",[["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellRed",1,1],["SmokeShellBlue",1,1],["Chemlight_blue",2,1],["10Rnd_50BW_Mag_F",2,10]]],[],"H_Beret_blk","G_Balaclava_lowprofile",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21973.1,21045.9,6],290,[],"STAND",[["arifle_CTAR_blk_F","","","optic_Aco",["30Rnd_580x42_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_580x42_Mag_F",2,30]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_580x42_Mag_F",4,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21970.2,21042.6,6.2],290,[],"STAND",[["arifle_AKM_F","","","",["30Rnd_762x39_Mag_F",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["MiniGrenade",1,1],["30Rnd_762x39_Mag_F",1,30]]],["V_Chestrig_oli",[["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["30Rnd_762x39_Mag_F",3,30]]],[],"H_Shemag_olive","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_soldier_F",[21974.3,21039.5,5.5],200,[],"CROUCH",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_C_FormalSuit_01_black_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",1,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30],["HandGrenade",5,1]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[],
		[
			["I_G_Sharpshooter_F",[21869.8,20993,9.5],118,[],"CROUCH",[["srifle_GM6_F","","","optic_LRPS",["5Rnd_127x108_Mag",5],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_G_Story_Protagonist_F",[["FirstAidKit",1]]],["V_PlateCarrier1_blk",[["5Rnd_127x108_APDS_Mag",7,5]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
			["I_G_Sharpshooter_F",[22047.3,20909,0],306,[],"PRONE",[["srifle_GM6_ghex_F","","","optic_tws",["5Rnd_127x108_Mag",5],[],""],["launch_O_Vorona_green_F","","","",["Vorona_HEAT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_FullGhillie_tna_F",[["FirstAidKit",2],["MineDetector",1],["HandGrenade",2,1]]],["V_PlateCarrierGL_tna_F",[["5Rnd_127x108_APDS_Mag",8,5],["30Rnd_9x21_Mag",1,30]]],["B_Bergen_tna_F",[["Medikit",1],["Vorona_HEAT",3,1],["SmokeShellBlue",2,1],["DemoCharge_Remote_Mag",1,1]]],"H_HelmetO_ViperSP_ghex_F","G_Balaclava_TI_G_tna_F",["Laserdesignator_03","","","",[],[],""],["ItemMap","I_UavTerminal","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Sharpshooter_F",[21916.2,21158.6,0],167,[],"CROUCH",[["srifle_GM6_ghex_F","","","optic_tws",["5Rnd_127x108_Mag",5],[],""],["launch_O_Vorona_green_F","","","",["Vorona_HEAT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_FullGhillie_tna_F",[["FirstAidKit",2],["MineDetector",1],["HandGrenade",2,1]]],["V_PlateCarrierGL_tna_F",[["5Rnd_127x108_APDS_Mag",8,5],["30Rnd_9x21_Mag",1,30]]],["B_Bergen_tna_F",[["Medikit",1],["Vorona_HEAT",3,1],["SmokeShellBlue",2,1],["DemoCharge_Remote_Mag",1,1]]],"H_HelmetO_ViperSP_ghex_F","G_Balaclava_TI_G_tna_F",["Laserdesignator_03","","","",[],[],""],["ItemMap","I_UavTerminal","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Sharpshooter_F",[21821.7,21041.8,6.2],126,[],"CROUCH",[["srifle_DMR_06_camo_khs_F","","","optic_KHS_old",["20Rnd_762x51_Mag",20],[],""],[],[],["U_IG_leader",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["SmokeShell",1,1],["SmokeShellGreen",1,1],["HandGrenade",1,1]]],["V_BandollierB_oli",[["20Rnd_762x51_Mag",6,20],["Chemlight_blue",2,1]]],[],"H_Booniehat_oli","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Sharpshooter_F",[21797.2,20972.4,7.4],95,[],"CROUCH",[["MMG_02_black_F","muzzle_snds_338_black","","optic_tws_mg",["130Rnd_338_Mag",130],[],"bipod_01_F_blk"],["launch_O_Vorona_green_F","","","",["Vorona_HEAT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_FullGhillie_tna_F",[["FirstAidKit",2],["MineDetector",1],["HandGrenade",2,1]]],["V_PlateCarrierGL_tna_F",[["130Rnd_338_Mag",2,130]]],["B_Bergen_tna_F",[["Medikit",1],["Vorona_HEAT",3,1],["SmokeShellBlue",2,1],["DemoCharge_Remote_Mag",1,1],["130Rnd_338_Mag",1,130]]],"H_HelmetO_ViperSP_ghex_F","G_Balaclava_TI_G_tna_F",["Laserdesignator_03","","","",[],[],""],["ItemMap","I_UavTerminal","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[[21943.2,21080.7,0],[21846.5,20966,0]],
		[
			["I_G_Soldier_TL_F",[21902.4,21010.3,0],185,[1],"STAND",[["arifle_Mk20_GL_ACO_F","","","optic_ACO_grn",["30Rnd_556x45_Stanag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_IG_leader",[["FirstAidKit",1],["30Rnd_556x45_Stanag",3,30]]],["V_TacVest_blk",[["30Rnd_556x45_Stanag_Tracer_Yellow",2,30],["9Rnd_45ACP_Mag",1,9],["HandGrenade",1,1],["MiniGrenade",1,1],["1Rnd_HE_Grenade_shell",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeRed_Grenade_shell",1,1],["1Rnd_SmokeBlue_Grenade_shell",1,1]]],[],"H_Watchcap_khk","G_Bandanna_tan",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_AR_F",[21897.8,21015.7,0],185,[1],"STAND",[["LMG_Mk200_BI_F","","","",["200Rnd_65x39_cased_Box",200],[],"bipod_03_F_blk"],[],[],["U_IG_Guerilla2_1",[["FirstAidKit",1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",1,1]]],["V_TacVest_blk",[["200Rnd_65x39_cased_Box",2,200]]],[],"H_Booniehat_khk","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_F",[21907.8,21014.8,0],185,[1],"STAND",[["arifle_TRG21_F","","","",["30Rnd_556x45_Stanag",30],[],""],[],[],["U_IG_Guerilla1_1",[["FirstAidKit",1],["30Rnd_556x45_Stanag",1,30],["MiniGrenade",1,1]]],["V_Chestrig_oli",[["30Rnd_556x45_Stanag",4,30],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_blue",2,1]]],[],"H_Watchcap_camo","G_Bandanna_shades",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["I_G_Soldier_LAT2_F",[21893.3,21021.1,0],185,[1],"STAND",[["arifle_TRG21_F","","","",["30Rnd_556x45_Stanag",30],[],""],["launch_MRAWS_olive_rail_F","","","",["MRAWS_HEAT_F",1],[],""],[],["U_IG_Guerrilla_6_1",[["FirstAidKit",1],["30Rnd_556x45_Stanag",1,30],["SmokeShell",1,1],["Chemlight_blue",1,1]]],["V_TacVest_blk",[["30Rnd_556x45_Stanag",4,30],["SmokeShellGreen",1,1],["Chemlight_blue",1,1]]],["G_FieldPack_LAT2",[["MRAWS_HEAT_F",2,1],["MRAWS_HE_F",1,1]]],"H_ShemagOpen_tan","G_Shades_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[]
	],
	[
		INDEPENDENT,
		[[21931.2,20990.7,0],[21892.8,20921.3,0]],
		[
			["I_Soldier_TL_F",[21890.4,20923.1,1.9],0,[1],"STAND",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_G_Story_Protagonist_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",3,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
			["I_Soldier_AR_F",[21895.4,20918.1,0.2],0,[1],"STAND",[["arifle_RPK12_F","","acc_pointer_IR","optic_Holosight_blk_F",["75rnd_762x39_AK12_Mag_F",75],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_G_Story_Protagonist_F",[["FirstAidKit",1],["75rnd_762x39_AK12_Mag_F",1,75]]],["V_PlateCarrier1_blk",[["75rnd_762x39_AK12_Mag_F",2,75]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
			["I_Soldier_GL_F",[21885.4,20918.1,0.9],0,[1],"STAND",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],[],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_G_Story_Protagonist_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",3,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30]]],[],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]],
			["I_Soldier_LAT_F",[21900.4,20913.1,0],0,[1],"STAND",[["arifle_AK12U_F","","acc_pointer_IR","optic_Holosight_blk_F",["30Rnd_762x39_AK12_Mag_F",30],[],""],["launch_MRAWS_green_F","","","",["MRAWS_HEAT_F",1],[],""],["hgun_ACPC2_F","","","",["9Rnd_45ACP_Mag",9],[],""],["U_I_G_Story_Protagonist_F",[["FirstAidKit",1],["30Rnd_762x39_AK12_Mag_F",3,30]]],["V_PlateCarrier1_blk",[["30Rnd_762x39_AK12_Mag_F",6,30]]],["B_AssaultPack_blk",[["MRAWS_HEAT_F",2,1]]],"H_WirelessEarpiece_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_OPFOR"]]]
		],
		[]
	]
	/*
	[
		INDEPENDENT,
		[],
		[],
		[
			["I_E_UAV_01_F",[21933.8,20984.4,95.7],[[-0.63,-0.78,0],[0,0,1]],[],[["I_UAV_AI_F",["driver"],[]],["I_UAV_AI_F",["turret",[0]],[]]]]
		]
	]
	*/
];
private _pmissBaseTurrets = [
	["I_static_AA_F",[21984.7,21037.6,34.5],[[0.67,0.74,0],[0,0,1]]],
	["I_static_AA_F",[21982.1,21040.1,34.5],[[0.68,0.73,0],[0,0,1]]],
	["I_static_AA_F",[21969.9,21015.1,30.1],[[-0.35,-0.94,0],[0,0,1]]],
	["I_static_AA_F",[21961,21023.7,30.1],[[-0.79,-0.62,0],[0,0,1]]],
	["I_static_AA_F",[21937,21037,30.1],[[-0.46,-0.89,0],[0,0,1]]],
	["I_static_AA_F",[21985.3,20992.4,30.1],[[-0.84,-0.55,0],[0,0,1]]],
	["I_HMG_01_high_F",[21962.7,21036,35.2],[[0.89,-0.45,0],[0,0,1]]],
	["I_HMG_01_high_F",[21960.8,21039.1,30.7],[[-0.89,0.46,0],[0,0,1]]]
];
private _pmissEmptyVehs = [];
private _pmissOtherStuff = [
	["Land_MultiScreenComputer_01_closed_black_F",[21966.7,21046.9,35.34],[[-0.99,-0.14,0],[0,0,1]],[]],
	["HazmatBag_01_F",[21967.5,21046.9,35.66],[[-0.91,-0.41,0],[0,0,1]],[]],
	["HazmatBag_01_F",[21967,21047.3,35.63],[[0.37,0.93,0],[0,0,1]],[]],
	["HazmatBag_01_F",[21967.6,21047.5,35.61],[[0.87,-0.49,0],[0,0,1]],[]]
];
private _doors = [];
private _delete = [];
private _pmissBuildings = [
	/*
	["APERSMineDispenser_Mine_Ammo",[21990.7,20997.5,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21993.8,20996.5,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21995.8,20998.1,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21993.2,20995.1,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21996.2,21001.3,24.69],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21998.8,21000.4,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[22000,21005.4,29.1],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[22003.4,21002,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[22006.5,21005.5,26.92],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21990.4,21001.4,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[22005.1,21008.2,26.92],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21996.6,21003,29.09],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21947.2,20999.8,19.02],[[0,1,-0.02],[-0.01,0.02,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21947.8,20999.3,19.04],[[0,1,-0.02],[-0.01,0.02,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21948.7,20998.3,19.07],[[0,1,-0.02],[-0.01,0.02,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21949.5,20997.4,19.1],[[0,1,-0.02],[-0.01,0.02,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21957.3,20999.3,19.05],[[0,1,-0.06],[0.01,0.06,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21958.3,20999.7,19.01],[[0,1,-0.06],[0.01,0.06,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21948.3,21011,19.09],[[0,1,0.01],[0.02,-0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21947.7,21010.2,19.09],[[0,1,0.01],[0.02,-0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21948.7,21011.4,19.09],[[0,1,0],[0.04,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21945.6,21001.2,19.02],[[0,1,0.01],[-0.01,-0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21946.4,21000.5,19.02],[[0,1,0.01],[-0.01,-0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21947.3,21008.5,19.07],[[0,1,0.01],[0.02,-0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21947.5,21009.4,19.09],[[0,1,0.01],[0.02,-0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21952.3,21015.9,18.94],[[0,1,0.01],[0.07,-0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21959.7,21000.2,18.97],[[0,1,-0.02],[0.01,0.02,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21949.3,21012,19.06],[[0,1,0],[0.04,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21949.9,21012.7,19.03],[[0,1,0],[0.04,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21950.8,21013.8,18.99],[[0,1,0],[0.04,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21951.2,21014.4,18.97],[[0,1,0],[0.04,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21951.9,21015.4,18.96],[[0,1,0.04],[0.04,-0.04,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21964.2,21001,19.08],[[0,1,-0.01],[0,0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21985.9,21008.3,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21961.1,21000.5,18.97],[[0,1,-0.01],[0,0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21986.8,21003.8,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21963,21001,18.96],[[0,1,-0.01],[0,0.01,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21982.1,21014.1,24.65],[[0,1,0],[0,0,1]],true],
	["APERSMineDispenser_Mine_Ammo",[21982.3,21010.8,24.65],[[0,1,0],[0,0,1]],true],
	*/
	["Land_BackAlley_01_l_gate_F",[21966.7,21037,35.17],[[0.4,0.91,0],[0,0,1]],true,{_doors pushBack _this;[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_BackAlley_01_l_gate_F",[21963.8,21042.3,35.09],[[-0.87,0.49,0],[0,0,1]],true,{_doors pushBack _this;[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_Wall_IndCnc_4_F",[21967.5,21042.3,34.7457],[[0.465,0.872345,0],[0,0,1]],true,{_delete pushBack _this;[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_BackAlley_01_l_gate_F",[21948.4,21052.4,35.3],[[-0.47,-0.88,0],[0,0,1]],true,{_this setVariable ["bis_disabled_door_1",1,true];[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_BackAlley_01_l_gate_F",[21970.6,21019.9,26.31],[[-0.67,-0.74,0],[0,0,1]],true,{_this setVariable ["bis_disabled_door_1",1,true];[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_BackAlley_01_l_gate_F",[21999.2,21004.8,30.72],[[-0.83,-0.55,0],[0,0,1]],true,{_this setVariable ["bis_disabled_door_1",1,true];[_this,false] remoteExecCall ["allowDamage",0];}],
	//SIMPLE OBJECTS
	["Land_BackAlley_01_l_1m_F",[21945.3,21029.3,26.53],[[-0.43,-0.9,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21978.5,20997.8,26.36],[[-0.83,-0.55,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21982.4,21000.3,31.27],[[-0.83,-0.56,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21986.2,21002.8,35.19],[[-0.83,-0.55,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21980.9,21002.5,31.06],[[-0.83,-0.55,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21977.1,21000.1,26.35],[[-0.84,-0.55,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21984.7,21005.1,35.2],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21945.1,21034.6,31.03],[[-0.46,-0.89,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21947.4,21033.3,30.94],[[-0.47,-0.88,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21947.1,21038.7,35.27],[[-0.48,-0.87,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21949.6,21037.4,35.23],[[-0.47,-0.88,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21946.4,21059.9,28.56],[[-0.89,0.46,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21942.9,21030.6,26.58],[[-0.46,-0.89,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[21993.6,20994.8,26.36],[[0.54,-0.84,0],[0,0,1]],false],
	["Land_BackAlley_01_l_1m_F",[22007.4,21003.8,28.56],[[0.51,-0.86,0],[0,0,1]],false],
	["Land_BagFence_Corner_F",[21957,21012.5,19.88],[[-0.67,-0.75,0],[0,0,1]],false],
	["Land_BagFence_Corner_F",[21959.5,21010.3,19.91],[[0.68,-0.73,0],[0,0,1]],false],
	["Land_BagFence_Round_F",[21957.9,21011,19.91],[[0.66,0.75,0],[0,0,1]],false],
	["Land_BagFence_Round_F",[21982.9,21023.8,33.94],[[0.98,-0.18,0],[0,0,1]],false],
	["Land_BagFence_Round_F",[21964,21019.5,31.75],[[-0.77,0.64,0],[0,0,1]],false],
	["Land_BagFence_Round_F",[21982.7,21037.9,33.98],[[0.67,0.74,0],[0,0,1]],false],
	["Land_BagFence_Round_F",[21987.3,21035.9,29.54],[[0.84,-0.54,0],[0,0,1]],false],
	["Land_BagFence_Long_F",[21947.4,21047.1,29.47],[[0.89,-0.46,0],[0,0,1]],false],
	["Land_BagFence_Long_F",[21965.2,21028.9,24.96],[[-0.14,-0.99,0],[0,0,1]],false],
	["Land_BagFence_Long_F",[21975.3,21029.3,29.41],[[0.78,-0.63,0],[0,0,1]],false],
	["Land_BagFence_Long_F",[21975.2,21043.4,35.03],[[-0.28,0.96,0],[0,0,1]],false],
	["Land_BagFence_Long_F",[21973.3,21042.7,35.65],[[-0.42,0.91,0],[0,0,1]],false],
	["Land_BagFence_Long_F",[21975.1,21043.4,35.66],[[-0.28,0.96,0],[0,0,1]],false],
	["Land_BagFence_Long_F",[21973.3,21042.7,35.05],[[0.42,-0.91,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_half_F",[21943.2,21044.1,25.05],[[-0.87,0.49,0],[0,0,1]],false],
	["Land_CncWall4_F",[21943,21052.3,25.83],[[0.9,-0.44,0],[0,0,1]],false],
	["Land_CncWall4_F",[21969.3,21038.3,35.23],[[0.92,-0.38,0],[0,0,1]],false],
	["Land_CncWall4_F",[21963.3,21038.2,35.15],[[-0.45,-0.89,0],[0,0,1]],false],
	["Land_CncWall4_F",[22000.3,20999.7,26.03],[[-0.56,0.83,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21939.1,21045.1,25.92],[[0.89,-0.46,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21946.1,21054.2,30.42],[[-0.87,0.5,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21975.6,21019.9,34.83],[[0.87,0.49,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21965.3,21030,34.89],[[0.58,0.82,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21965.4,21051.8,35.26],[[-0.48,-0.88,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21977.1,21045.6,30.37],[[-0.45,-0.89,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21962.1,21038.2,30.4],[[0.88,-0.48,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21975.8,21046.3,30.37],[[-0.45,-0.89,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21968,21050.5,35.27],[[-0.45,-0.89,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[22001.4,21003.3,30.46],[[0.54,-0.84,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21991.1,21032.7,29.68],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21990.3,21033.9,29.69],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21991.7,21031.8,29.68],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21990.6,21033.3,35.29],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_F",[21992.5,21030.4,35.29],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_BagFence_End_F",[21953,21036.4,25.02],[[0.9,-0.43,0],[0,0,1]],false],
	["Land_BagFence_End_F",[21950.1,21040.5,25.02],[[-0.87,0.5,0],[0,0,1]],false],
	["Land_BagFence_End_F",[21958,21041.4,29.43],[[0.87,-0.48,0],[0,0,1]],false],
	["Land_Razorwire_F",[21958.9,21025.8,25.5],[[0.93,0.37,0],[0,0,1]],false],
	["Land_Razorwire_F",[21950.6,21027.1,25.45],[[-0.48,-0.88,0],[0,0,1]],false],
	["Land_Razorwire_F",[21938.1,21034,25.52],[[-0.5,-0.87,0],[0,0,1]],false],
	["Land_Razorwire_F",[21952.9,21031.3,29.96],[[-0.47,-0.88,0],[0,0,1]],false],
	["Land_Razorwire_F",[21954.9,21035.4,34.4],[[-0.45,-0.89,0],[0,0,1]],false],
	["Land_Razorwire_F",[21940,21037.9,30.07],[[-0.47,-0.88,0],[0,0,1]],false],
	["Land_Razorwire_F",[21942.4,21042.4,34.25],[[-0.45,-0.89,0],[0,0,1]],false],
	["Land_Razorwire_F",[21982.1,20993.2,25.5],[[-0.84,-0.55,0],[0,0,1]],false],
	["Land_Razorwire_F",[21986.2,20995.8,29.98],[[-0.83,-0.55,0],[0,0,1]],false],
	["Land_Razorwire_F",[21971.9,21013.4,25.43],[[-0.39,-0.92,0],[0,0,1]],false],
	["Land_Razorwire_F",[21978.4,21007.8,29.93],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_Razorwire_F",[21961.2,21028.2,29.99],[[-0.47,-0.88,0],[0,0,1]],false],
	["Land_Razorwire_F",[21974.2,21015.4,30.01],[[-0.83,-0.55,0],[0,0,1]],false],
	["Land_Razorwire_F",[21974.4,21005.3,25.47],[[-0.82,-0.57,0],[0,0,1]],false],
	["Land_Razorwire_F",[21982.2,21010.4,34.39],[[-0.83,-0.56,0],[0,0,1]],false],
	["Land_Razorwire_F",[21990.3,20998.6,34.23],[[-0.83,-0.56,0],[0,0,1]],false],
	["Land_Razorwire_F",[21987.4,21043.4,29.84],[[-0.66,-0.76,0],[0,0,1]],false],
	["Land_Razorwire_F",[21993.9,21050.3,29.05],[[-0.66,-0.75,-0.02],[-0.02,-0.01,1]],false],
	["Land_Shoot_House_Wall_Stand_F",[21981.3,21043.4,35.75],[[0.68,0.74,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Stand_F",[21974.3,21047.7,35.7],[[0.48,0.88,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Stand_F",[21988.1,21037.2,35.75],[[0.68,0.73,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Stand_F",[21965.7,21052.3,30.82],[[-0.48,-0.88,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Stand_F",[21977.1,21046.2,35.7],[[0.48,0.88,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Stand_F",[21996.6,21024.9,35.73],[[-0.84,-0.54,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Stand_F",[21999.7,21005.1,35.23],[[-0.84,-0.55,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Long_F",[21971.8,21049,30.8],[[0.47,0.88,0],[0,0,1]],false],
	["Land_Shoot_House_Wall_Long_F",[21994.45,21028.15,30.78],[[0.853618,0.552341,0],[0,0,1]],false],
	//["Land_Sign_MinesTall_Greek_F",[21994.8,21003.8,29.63],[[0.87,-0.49,0],[0,0,1]],false],
	//["Land_Sign_MinesTall_Greek_F",[21973.7,21021.7,25.2],[[0.87,-0.49,0],[0,0,1]],false],
	["Land_HBarrierWall4_F",[21980,21017.8,34.5],[[-0.87,-0.5,0],[0,0,1]],false],
	["GalleryDioramaUnit_01_Astra_F",[21967.2,21047.4,34.63],[[0.88,-0.48,0],[0,0,1]],false],
	["GalleryFrame_02_large_rectangle_F",[21965.2,21043.6,35.78],[[-0.47,-0.88,0],[0,0,1]],false],
	["Land_Statue_03_F",[21963.7,21050.4,35.32],[[-0.87,0.5,0],[0,0,1]],false],
	["Land_Statue_03_F",[21962.6,21048.4,35.32],[[-0.87,0.5,0],[0,0,1]],false],
	["Land_HBarrierWall4_F",[21962.8,21033.5,34.46],[[-0.51,-0.86,0],[0,0,1]],false],
	["Land_HBarrierWall4_F",[21984.8,21040.5,29.86],[[0.71,0.7,0],[0,0,1]],false],
	["Land_BagFence_Short_F",[21976.3,21040.2,29.55],[[-0.79,0.61,0],[0,0,1]],false]
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
	_x params ["_class","_pw","_vdu",["_flags",[]]];
	private _obj = createSimpleObject [_class,[0,0,0]];
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_nos pushBack _obj;
	uiSleep 0.001;
} forEach _pmissOtherStuff;

private _capitain = "I_Officer_Parade_Veteran_F";
{
	_x params ["_side","_wps","_onFoot","_onVeh"];
	private _grp = createGroup [_side,true];
	{
		_x params ["_class","_AGL","_dir","_flags","_stance","_gear"];
		if (random 1 <= BRPVP_pmissAiPerc || _class isEqualTo _capitain) then {
			private _u = _grp createUnit [_class,_AGL vectorAdd _pFix2D,[],0,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u setDir _dir;
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			if (_class isEqualTo _capitain) then {
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
			if (primaryWeapon _u isEqualTo "" || _wps isNotEqualTo []) then {
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
			if !(1 in _flags) then {
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
	[[21944.5,21052.7,33.7],207.4,20],
	[[21998.0,21003.5,29.4],328.3,10],
	[[21987.3,21003.5,33.8],147.0,05],
	[[21958.0,21033.1,29.3],303.0,05],
	[[21952.9,21047.2,29.3],211.7,05],
	[[21987.5,20992.7,24.8],330.9,05],
	[[21967.0,21021.0,19.6],133.0,05]	
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];
private _cfg = [_place,175,+BRPVP_pmissActualAiUnits,10,"str_pmiss_hotel_cant_open",[_delete,{{deleteVehicle _x;} forEach _this;}]];
{_x setVariable ["brpvp_mbots2",_cfg,true];} forEach _doors;

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,[],{true}];
BRPVP_pmissSpawning = false;