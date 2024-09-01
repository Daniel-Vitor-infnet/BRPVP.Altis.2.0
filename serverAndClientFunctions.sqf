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

_scriptStart = diag_tickTime;
diag_log "[SCRIPT] serverAndClientFunctions.sqf BEGIN";

//===========================================================================================================
//== SPECIAL CODE BEGIN
//===========================================================================================================

BRPVP_baseFloorPieces = [
	//TOP
	["part_3_B.p3d",[-125,+175,0],+000],
	["part_4_A.p3d",[-075,+175,0],+000],
	["part_1_B.p3d",[-025,+175,0],+000],
	["part_1_A.p3d",[+025,+175,0],+000],
	["part_4_B.p3d",[+075,+175,0],+000],
	["part_3_A.p3d",[+125,+175,0],+000],

	//BOTTOM
	["part_3_B.p3d",[+125,-175,0],+180],
	["part_4_A.p3d",[+075,-175,0],+180],
	["part_1_B.p3d",[+025,-175,0],+180],
	["part_1_A.p3d",[-025,-175,0],+180],
	["part_4_B.p3d",[-075,-175,0],+180],
	["part_3_A.p3d",[-125,-175,0],+180],

	//LEFT
	["part_3_B.p3d",[-175,-125,0],-090],
	["part_4_A.p3d",[-175,-075,0],-090],
	["part_1_B.p3d",[-175,-025,0],-090],
	["part_1_A.p3d",[-175,+025,0],-090],
	["part_4_B.p3d",[-175,+075,0],-090],
	["part_3_A.p3d",[-175,+125,0],-090],

	//RIGHT
	["part_3_B.p3d",[+175,+125,0],+090],
	["part_4_A.p3d",[+175,+075,0],+090],
	["part_1_B.p3d",[+175,+025,0],+090],
	["part_1_A.p3d",[+175,-025,0],+090],
	["part_4_B.p3d",[+175,-075,0],+090],
	["part_3_A.p3d",[+175,-125,0],+090],

	//UNIQUE 1
	["part_2.p3d",[+125,+125,0],+000],
	["part_2.p3d",[-125,+125,0],-090],
	["part_2.p3d",[-125,-125,0],-180],
	["part_2.p3d",[+125,-125,0],-270],

	//UNIQUE 2
	["part_0.p3d",[-075,+125,0],+000],
	["part_0.p3d",[-025,+125,0],+000],
	["part_0.p3d",[+025,+125,0],+000],
	["part_0.p3d",[+075,+125,0],+000],

	["part_0.p3d",[-125,+075,0],+000],
	["part_0.p3d",[-075,+075,0],+000],
	["part_0.p3d",[-025,+075,0],+000],
	["part_0.p3d",[+025,+075,0],+000],
	["part_0.p3d",[+075,+075,0],+000],
	["part_0.p3d",[+125,+075,0],+000],

	["part_0.p3d",[-125,+025,0],+000],
	["part_0.p3d",[-075,+025,0],+000],
	["part_0.p3d",[-025,+025,0],+000],
	["part_0.p3d",[+025,+025,0],+000],
	["part_0.p3d",[+075,+025,0],+000],
	["part_0.p3d",[+125,+025,0],+000],

	["part_0.p3d",[-125,-025,0],+000],
	["part_0.p3d",[-075,-025,0],+000],
	["part_0.p3d",[-025,-025,0],+000],
	["part_0.p3d",[+025,-025,0],+000],
	["part_0.p3d",[+075,-025,0],+000],
	["part_0.p3d",[+125,-025,0],+000],

	["part_0.p3d",[-125,-075,0],+000],
	["part_0.p3d",[-075,-075,0],+000],
	["part_0.p3d",[-025,-075,0],+000],
	["part_0.p3d",[+025,-075,0],+000],
	["part_0.p3d",[+075,-075,0],+000],
	["part_0.p3d",[+125,-075,0],+000],

	["part_0.p3d",[-075,-125,0],+000],
	["part_0.p3d",[-025,-125,0],+000],
	["part_0.p3d",[+025,-125,0],+000],
	["part_0.p3d",[+075,-125,0],+000]
];

//CHANGE IN MAGS 27/02/2023
//"UGL_FlareWhite_F","UGL_FlareYellow_F","UGL_FlareGreen_F","UGL_FlareRed_F"
//BRPVP_ItemsClassToNumberTableB = ["100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","10Rnd_338_Mag","10Rnd_93x64_DMR_05_Mag","11Rnd_45ACP_Mag","130Rnd_338_Mag","150Rnd_556x45_Drum_Mag_F","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer","150Rnd_93x64_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_yellow_Mag","1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","200Rnd_556x45_Box_Tracer_F","200Rnd_556x45_Box_Tracer_Red_F","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","20Rnd_762x51_Mag","30Rnd_545x39_Mag_F","30Rnd_545x39_Mag_Green_F","30Rnd_545x39_Mag_Tracer_F","30Rnd_545x39_Mag_Tracer_Green_F","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_green","30Rnd_556x45_Stanag_red","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","30Rnd_762x39_Mag_F","30Rnd_762x39_Mag_Green_F","30Rnd_762x39_Mag_Tracer_F","30Rnd_762x39_Mag_Tracer_Green_F","30Rnd_9x21_Green_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","6Rnd_45ACP_Cylinder","7Rnd_408_Mag","9Rnd_45ACP_Mag","APERSBoundingMine_Range_Mag","APERSMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","B_IR_Grenade","Chemlight_blue","Chemlight_green","ClaymoreDirectionalMine_Remote_Mag","DemoCharge_Remote_Mag","HandGrenade","MiniGrenade","NLAW_F","RPG32_F","RPG32_HE_F","SatchelCharge_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellPurple","Titan_AA","Titan_AP","Titan_AT","3Rnd_HE_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag","10Rnd_50BW_Mag_F","1Rnd_SmokePurple_Grenade_shell","FlareWhite_F","FlareYellow_F","FlareGreen_F","FlareRed_F","200Rnd_556x45_Box_F","SmokeShellYellow","30Rnd_762x39_AK12_Mag_F","20Rnd_556x45_UW_mag","MRAWS_HE_F","MRAWS_HEAT_F","30Rnd_45ACP_Mag_SMG_01","10Rnd_9x21_Mag","30Rnd_580x42_Mag_F","20Rnd_650x39_Cased_Mag_F","SmokeShellRed","UGL_FlareWhite_F","UGL_FlareGreen_F","Laserbatteries","Vorona_HE","30Rnd_65x39_caseless_khaki_mag","100Rnd_580x42_Mag_F","10Rnd_127x54_Mag","1Rnd_SmokeYellow_Grenade_shell","150Rnd_556x45_Drum_Sand_Mag_Tracer_F","Vorona_HEAT","CUP_7Rnd_45ACP_1911","CUP_10Rnd_9x19_Compact","CUP_17Rnd_9x19_glock17","CUP_15Rnd_9x19_M9","CUP_8Rnd_9x18_Makarov_M","CUP_8Rnd_9x18_MakarovSD_M","CUP_30Rnd_9x19_UZI","CUP_18Rnd_9x19_Phantom","CUP_6Rnd_45ACP_M","CUP_10Rnd_B_765x17_Ball_M","CUP_20Rnd_B_765x17_Ball_M","CUP_50Rnd_B_765x17_Ball_M","CUP_30Rnd_545x39_AK_M","CUP_30Rnd_545x39_AK74M_M","CUP_30Rnd_545x39_AK74_plum_M","CUP_30Rnd_545x39_AK74M_camo_M","CUP_20Rnd_545x39_AKSU_M","CUP_20Rnd_Subsonic_545x39_AKSU_M","CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M","CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M","CUP_60Rnd_545x39_AK74M_M","CUP_60Rnd_TE1_Green_Tracer_545x39_AK74M_M","CUP_30Rnd_762x39_AK47_M","CUP_30Rnd_762x39_AK47_bakelite_M","CUP_30Rnd_762x39_AK103_bakelite_M","CUP_30Rnd_762x39_AK47_TK_M","CUP_20Rnd_762x39_AMD63_M","CUP_10Rnd_762x39_SaigaMk03_M","CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M","CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M","CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M","CUP_30Rnd_556x45_G36","CUP_100Rnd_556x45_BetaCMag","CUP_20Rnd_762x51_CZ805B","CUP_20Rnd_762x51_FNFAL_M","CUP_30Rnd_556x45_G36_camo","CUP_30Rnd_556x45_G36_wdl","CUP_30Rnd_556x45_G36_hex","CUP_100Rnd_556x45_BetaCMag_camo","CUP_100Rnd_556x45_BetaCMag_wdl","CUP_100Rnd_556x45_BetaCMag_hex","CUP_30Rnd_TE1_Red_Tracer_556x45_G36_camo","CUP_30Rnd_TE1_Red_Tracer_556x45_G36_wdl","CUP_30Rnd_TE1_Red_Tracer_556x45_G36_hex","CUP_30Rnd_556x45_XM8","CUP_30Rnd_TE1_Red_Tracer_556x45_XM8","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_camo","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_wdl","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_wdl","CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_hex","CUP_30Rnd_556x45_Stanag_L85","CUP_30Rnd_556x45_Stanag","CUP_30Rnd_556x45_Emag","CUP_30Rnd_556x45_Stanag_Mk16","CUP_30Rnd_556x45_Stanag_Mk16_black","CUP_30Rnd_556x45_Stanag_Mk16_woodland","CUP_20Rnd_556x45_Stanag","CUP_60Rnd_556x45_SureFire","CUP_100Rnd_556x45_BetaCMag_ar15","CUP_30Rnd_Sa58_M","CUP_20Rnd_762x51_B_SCAR","CUP_20Rnd_762x51_B_SCAR_bkl","CUP_20Rnd_762x51_B_SCAR_wdl","CUP_30Rnd_762x51_1_B_SCAR","CUP_30Rnd_762x51_2_B_SCAR","CUP_50Rnd_762x51_B_SCAR","CUP_20Rnd_B_AA12_Pellets","CUP_20Rnd_B_AA12_74Slug","CUP_20Rnd_B_AA12_HE","CUP_8Rnd_B_Beneli_74Slug","CUP_8Rnd_B_Beneli_74Pellets","CUP_8Rnd_B_Saiga12_74Slug_M","CUP_8Rnd_B_Saiga12_74Pellets_M","CUP_100Rnd_TE4_LRT4_Green_Tracer_762x51_Belt_M","CUP_200Rnd_TE4_Red_Tracer_556x45_M249","CUP_100Rnd_TE4_Green_Tracer_556x45_M249","CUP_200Rnd_TE4_Green_Tracer_556x45_L110A1","CUP_30Rnd_TE1_Green_Tracer_556x45_G36","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M","CUP_50Rnd_UK59_762x54R_Tracer","CUP_5Rnd_127x99_as50_M","CUP_5Rnd_86x70_L115A1","CUP_10Rnd_762x51_CZ750","CUP_20Rnd_762x51_DMR","CUP_20Rnd_TE1_Yellow_Tracer_762x51_DMR","CUP_5x_22_LR_17_HMR_M","CUP_10x_303_M","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_ar15","CUP_5Rnd_762x51_M24","CUP_10Rnd_127x99_m107","CUP_20Rnd_762x51_B_M110","CUP_20Rnd_TE1_Yellow_Tracer_762x51_M110","CUP_10Rnd_762x54_SVD_M","CUP_5Rnd_127x108_KSVK_M","CUP_10Rnd_9x39_SP5_VSS_M","CUP_20Rnd_9x39_SP5_VSS_M","CUP_30Rnd_9x39_SP5_VIKHR_M","CUP_MAAWS_HEAT_M","CUP_MAAWS_HEDP_M","CUP_AT13_M","CUP_PG7V_M","CUP_PG7VM_M","CUP_PG7VL_M","CUP_PG7VR_M","CUP_OG7_M","CUP_TBG7V_M","CUP_RPG18_M","CUP_SMAW_HEAA_M","CUP_SMAW_HEDP_M","CUP_1Rnd_HE_GP25_M","CUP_IlumFlareWhite_GP25_M","CUP_IlumFlareRed_GP25_M","CUP_IlumFlareGreen_GP25_M","CUP_FlareWhite_GP25_M","CUP_FlareGreen_GP25_M","CUP_FlareRed_GP25_M","CUP_FlareYellow_GP25_M","CUP_1Rnd_SMOKE_GP25_M","CUP_1Rnd_SMOKERED_GP25_M","CUP_1Rnd_SMOKEGREEN_GP25_M","CUP_1Rnd_SMOKEYELLOW_GP25_M","CUP_Dragon_EP1_M","CUP_NLAW_M","CUP_M136_M","CUP_Javelin_M","CUP_Igla_M","CUP_Stinger_M","CUP_Strela_2_M","CUP_6Rnd_HE_GP25_M","CUP_PTFHE_M","CUP_PTFHC_M","CUP_PTF3IT_M","CUP_APILAS_M","CUP_20Rnd_762x51_L129_M","2Rnd_12Gauge_Pellets","CUP_30Rnd_Subsonic_545x39_AK74M_M","CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_Woodland_M","6Rnd_12Gauge_Pellets","CUP_30Rnd_556x45_AK","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_ar15","CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M","CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_ar15","UGL_FlareRed_F","CUP_30Rnd_TE1_Red_Tracer_556x45_G36","CUP_30Rnd_762x39_AKM_bakelite_desert_M","CUP_20Rnd_762x51_HK417_Camo_Wood","30Rnd_65x39_caseless_msbs_mag","CUP_120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M","CUP_20Rnd_TE1_Yellow_Tracer_762x51_FNFAL_Desert_M","CUP_30Rnd_9x19_MP5","CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M","CUP_30Rnd_9x19_Vityaz","10Rnd_762x54_Mag","CUP_20Rnd_762x51_HK417","CUP_30Rnd_556x45_PMAG_QP","30Rnd_65x39_caseless_khaki_mag_Tracer","CUP_120Rnd_TE4_LRT4_Green_Tracer_762x51_Belt_M","CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_Desert_M","CUP_20Rnd_TE1_Yellow_Tracer_762x51_FNFAL_Woodland_M","CUP_30Rnd_TE1_Green_Tracer_762x51_1_SCAR","CUP_10Rnd_TE1_Green_Tracer_762x51_FNFAL_M","CUP_30Rnd_Sa58_M_TracerR","CUP_30Rnd_TE1_Red_Tracer_762x39_AKM_bakelite_desert_M","CUP_20Rnd_762x51_HK417_Camo_Desert","CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M","CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M","CUP_200Rnd_TE4_Green_Tracer_556x45_M249","UGL_FlareYellow_F","CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M","CUP_30Rnd_9x19AP_Vityaz","30Rnd_556x45_Stanag_Sand_green","CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_M","CUP_30Rnd_TE1_Yellow_Tracer_762x39_bakelite_AK103_M","CUP_1Rnd_SmokeYellow_GP25_M","CUP_30Rnd_TE1_Yellow_Tracer_556x45_G36","CUP_30Rnd_TE1_Green_Tracer_762x39_AK103_bakelite_M","CUP_10Rnd_127x99_M107","CUP_SMAW_NE_M","CUP_5Rnd_762x67_G22","CUP_20Rnd_TE1_Green_Tracer_762x51_M110","CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M","100Rnd_65x39_caseless_khaki_mag","CUP_30Rnd_556x45_CZ805","CUP_20Rnd_TE1_Green_Tracer_762x51_SCAR_wdl","CUP_30Rnd_TE1_Green_Tracer_762x39_AKM_bakelite_desert_M","CUP_M72A6_M","MRAWS_HEAT55_F","75rnd_762x39_AK12_Arid_Mag_F","CUP_1Rnd_SmokeGreen_GP25_M","CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249_Pouch","CUP_30Rnd_556x45_Stanag_Mk16_woodland_Tracer_Yellow","2Rnd_12Gauge_Slug","CUP_20Rnd_TE1_Yellow_Tracer_762x51_SCAR_bkl","CUP_20Rnd_TE1_Green_Tracer_762x51_DMR","75rnd_762x39_AK12_Lush_Mag_F","100Rnd_65x39_caseless_black_mag","50Rnd_570x28_SMG_03","10Rnd_Mk14_762x51_Mag","200Rnd_65x39_cased_Box_Tracer_Red","200Rnd_65x39_cased_Box_Red","75rnd_762x39_AK12_Arid_Mag_Tracer_F","30Rnd_556x45_Stanag_Sand","30Rnd_45ACP_Mag_SMG_01_Tracer_Green","UGL_FlareCIR_F","30Rnd_65x39_caseless_black_mag","30Rnd_65x39_caseless_black_mag_Tracer","200Rnd_556x45_Box_Red_F","30Rnd_556x45_Stanag_Sand_red","30Rnd_556x45_Stanag_Sand_Tracer_Yellow","150Rnd_556x45_Drum_Sand_Mag_F","I_IR_Grenade","30Rnd_65x39_caseless_msbs_mag_Tracer","6Rnd_12Gauge_Slug","75rnd_762x39_AK12_Lush_Mag_Tracer_F","30rnd_762x39_AK12_Arid_Mag_F","30rnd_762x39_AK12_Arid_Mag_Tracer_F","30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow","30Rnd_556x45_Stanag_Sand_Tracer_Green","30Rnd_556x45_Stanag_Sand_Tracer_Red","30Rnd_9x21_Mag_SMG_02_Tracer_Red","Chemlight_red"];

//============================================================
//============================================================
//DON'T CHANGE THOSE ARRAYS, YOU CAN MESS YOUR DATABASE: BEGIN
//============================================================

BRPVP_ItemsClassToNumberTableA = ["arifle_AK12_F","arifle_AK12_GL_F","arifle_AKM_F","arifle_AKS_F","arifle_ARX_ghex_F","arifle_ARX_hex_F","arifle_Katiba_F","arifle_Mk20_GL_F","arifle_Mk20C_F","arifle_MX_F","arifle_MX_GL_F","arifle_MX_GL_khk_F","arifle_MX_khk_F","arifle_MX_SW_F","arifle_MXC_khk_F","arifle_MXM_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_snd_F","arifle_TRG20_F","arifle_TRG21_GL_F","Binocular","hgun_ACPC2_F","hgun_P07_F","hgun_PDW2000_F","hgun_Pistol_heavy_01_F","hgun_Pistol_heavy_02_F","hgun_Rook40_F","launch_B_Titan_F","launch_NLAW_F","launch_RPG32_F","LMG_03_F","LMG_Mk200_F","LMG_Zafir_F","MMG_01_hex_F","Rangefinder","SMG_02_F","srifle_DMR_06_camo_F","srifle_EBR_F","srifle_LRR_camo_F","srifle_LRR_tna_F","MMG_02_black_F","arifle_SDAR_F","srifle_DMR_03_woodland_F","srifle_GM6_camo_F","srifle_DMR_03_multicam_F","srifle_GM6_F","MMG_02_camo_F","srifle_DMR_05_hex_F","srifle_DMR_02_F","MMG_01_tan_F","srifle_DMR_02_sniper_F","srifle_DMR_05_tan_f","Laserdesignator","launch_MRAWS_olive_rail_F","launch_MRAWS_sand_F","hgun_P07_khk_F","arifle_TRG21_F","arifle_MXC_F","SMG_01_F","hgun_Pistol_01_F","srifle_DMR_01_F","srifle_DMR_04_F","srifle_DMR_02_camo_F","launch_O_Vorona_brown_F","srifle_DMR_07_blk_F","srifle_LRR_F","srifle_DMR_03_F","Laserdesignator_01_khk_F","arifle_Mk20_F","arifle_SPAR_02_khk_F","MMG_02_sand_F","arifle_SPAR_03_blk_F","arifle_ARX_blk_F","arifle_SPAR_01_khk_F","Laserdesignator_02_ghex_F","CUP_hgun_Compact","CUP_hgun_Duty","CUP_hgun_Duty_M3X","CUP_hgun_Phantom","CUP_hgun_Phantom_Flashlight_snds","CUP_hgun_Glock17","CUP_hgun_Glock17_blk","CUP_hgun_M9","CUP_hgun_Makarov","CUP_hgun_PMM","CUP_hgun_MicroUzi","CUP_hgun_PB6P9","CUP_hgun_TaurusTracker455","CUP_hgun_TaurusTracker455_gold","CUP_hgun_Colt1911","CUP_smg_MP5SD6","CUP_smg_MP5A5","CUP_smg_MP5A5_flashlight","CUP_smg_bizon","CUP_smg_vityaz_vfg_top_rail","CUP_smg_saiga9","CUP_smg_EVO","CUP_smg_EVO_MRad_Flashlight_Snds","CUP_smg_SA61","CUP_arifle_AS_VAL_top_rail","CUP_arifle_SR3M_Vikhr_VFG_top_rail","CUP_arifle_AKM_GL_top_rail","CUP_arifle_AKMS_GL_top_rail","CUP_arifle_AKS74U_top_rail","CUP_arifle_AK47_GL_top_rail","CUP_arifle_AKS_top_rail","CUP_arifle_AKS_Gold","CUP_arifle_AK74_GL_top_rail","CUP_arifle_AKS74_GL_top_rail","CUP_arifle_AK74M_GL_top_rail","CUP_arifle_AK101_GL_top_rail","CUP_arifle_AK103_GL_top_rail","CUP_arifle_AK107_GL_top_rail","CUP_arifle_AK108_GL_top_rail","CUP_arifle_AK109_GL_top_rail","CUP_arifle_AK102_top_rail","CUP_arifle_AK104_top_rail","CUP_arifle_AK105_top_rail","CUP_arifle_RPK74_top_rail","CUP_arifle_RPK74_45_top_rail","CUP_arifle_SAIGA_MK03_top_rail","CUP_arifle_TYPE_56_2_top_rail","CUP_arifle_CZ805_A1","CUP_arifle_CZ805_GL","CUP_arifle_FNFAL","CUP_arifle_FNFAL_ANPVS4","CUP_arifle_G36A_RIS","CUP_arifle_AG36","CUP_arifle_G36K_RIS","CUP_arifle_G36C","CUP_arifle_MG36","CUP_arifle_HK416_CQB_Wood","CUP_arifle_HK_M27","CUP_arifle_HK_M27_VFG","CUP_arifle_HK416_M203_Black","CUP_arifle_HK417_20","CUP_arifle_HK417_12","CUP_arifle_L85A2","CUP_arifle_L85A2_GL","CUP_arifle_L86A2","CUP_arifle_M16A2","CUP_arifle_M16A2_GL","CUP_arifle_M16A4_Grip","CUP_arifle_M16A4_GL","CUP_arifle_XM16E1","CUP_arifle_M16A1","CUP_arifle_Colt727","CUP_arifle_Colt727_M203","CUP_srifle_Mk12SPR","CUP_arifle_M4A1_GL_carryhandle","CUP_arifle_M4A1_LeupoldMk4CQT_Laser","CUP_arifle_M4A3_camo","CUP_arifle_mk18_black","CUP_arifle_mk18_m203_black","CUP_arifle_SBR_black","CUP_arifle_Sa58P","CUP_arifle_Sa58V","CUP_arifle_Mk16_STD","CUP_arifle_Mk16_STD_EGLM","CUP_arifle_Mk17_CQC","CUP_arifle_Mk17_STD_EGLM","CUP_arifle_XM8_Carbine","CUP_arifle_XM8_Carbine_GL","CUP_lmg_UK59","CUP_lmg_L110A1","CUP_lmg_M240","CUP_lmg_L7A2","CUP_lmg_FNMAG_RIS","CUP_lmg_minimipara","CUP_lmg_minimi_railed","CUP_lmg_m249_para","CUP_lmg_M249","CUP_lmg_m249_para_gl","CUP_lmg_M60E4","CUP_lmg_MG3","CUP_lmg_Mk48_wdl_Aim_Laser","CUP_lmg_PKM","CUP_lmg_Pecheneg","CUP_srifle_CZ750","CUP_srifle_CZ550","CUP_srifle_LeeEnfield_rail","CUP_srifle_M14_DMR","CUP_srifle_M24_blk","CUP_srifle_M24_ghillie","CUP_srifle_M40A3","CUP_srifle_ksvk","CUP_srifle_SVD_top_rail","CUP_srifle_SVD_wdl_ghillie","CUP_srifle_VSSVintorez_top_rail","CUP_srifle_VSSVintorez_VFG_top_rail","CUP_srifle_AS50","CUP_srifle_AWM_wdl","CUP_srifle_G22_wdl","CUP_srifle_L129A1","CUP_srifle_L129A1_HG","CUP_srifle_M107_LeupoldVX3","CUP_srifle_M110","CUP_srifle_M14_CCO","CUP_glaunch_6G30","CUP_launch_BF3_Loaded","CUP_launch_APILAS_Loaded","CUP_srifle_RSASS_Dazzle","CUP_sgun_AA12","sgun_HunterShotgun_01_sawedoff_F","CUP_launch_Javelin","CUP_launch_Metis","CUP_launch_MAAWS","CUP_launch_9K32Strela_Loaded","CUP_launch_M47","CUP_launch_FIM92Stinger_Loaded","CUP_SOFLAM","CUP_arifle_FNFAL_railed","CUP_arifle_M4A1_black","arifle_MSBS65_UBS_sand_F","srifle_DMR_05_blk_F","CUP_srifle_M14","arifle_MXM_khk_F","arifle_SPAR_03_snd_F","CUP_launch_RPG18_Loaded","CUP_launch_RPG7V","CUP_launch_M136_Loaded","CUP_launch_NLAW_Loaded","CUP_launch_Mk153Mod0","launch_Titan_F","CUP_launch_M72A6_Loaded","CUP_launch_Igla_Loaded","srifle_GM6_ghex_F","CUP_srifle_M107_Base","CUP_srifle_M24_wdl","CUP_srifle_SVD_wdl","srifle_DMR_03_tan_F","arifle_RPK12_arid_F","launch_Titan_short_F","arifle_MX_SW_khk_F","launch_O_Titan_F","arifle_RPK12_lush_F","arifle_MX_SW_Black_F","launch_B_Titan_short_F","srifle_DMR_04_Tan_F","launch_MRAWS_olive_F","LMG_Mk200_black_F","srifle_DMR_03_khaki_F","srifle_DMR_06_hunter_F","arifle_SPAR_01_snd_F","launch_MRAWS_green_F","SMG_03C_black","Laserdesignator_03","hgun_Pistol_heavy_01_green_F","launch_O_Titan_short_F","launch_O_Vorona_green_F","arifle_MSBS65_Mark_camo_F","Laserdesignator_02","launch_RPG32_ghex_F","launch_RPG32_camo_F","arifle_MSBS65_UBS_black_F","arifle_AK12U_arid_F","launch_I_Titan_short_F","launch_I_Titan_F","srifle_DMR_07_ghex_F","launch_RPG32_green_F","arifle_MSBS65_UBS_camo_F","launch_MRAWS_sand_rail_F","arifle_MSBS65_UBS_F","arifle_MSBS65_GL_F","launch_MRAWS_green_rail_F","arifle_MSBS65_Mark_sand_F","sgun_HunterShotgun_01_F","arifle_MSBS65_Mark_black_F","srifle_DMR_07_hex_F","arifle_MSBS65_F","arifle_MSBS65_Mark_F","srifle_DMR_06_olive_F","arifle_SPAR_03_khk_F","launch_B_Titan_tna_F","arifle_Katiba_C_F","arifle_MX_Black_F","arifle_MXC_Black_F","arifle_CTARS_blk_F","arifle_CTAR_blk_F","SMG_05_F","CUP_arifle_L85A2_G","CUP_Vector21Nite","CUP_launch_NLAW","CUP_launch_FIM92Stinger","arifle_MSBS65_GL_camo_F","CUP_launch_9K32Strela","CUP_lmg_Mk48_wdl","CUP_launch_M136","CUP_launch_RPG18","rhs_weap_tt33","rhs_weap_savz61_folded","rhs_weap_ak74_gp25","rhs_weap_m70b1","arifle_AK12U_F","CUP_arifle_G36A","CUP_LRTV","CUP_CZ_BREN2_556_11_GL","CUP_launch_HCPF3","CUP_launch_BF3","CUP_srifle_AWM_des","arifle_CTARS_ghex_F","arifle_RPK12_F","launch_B_Titan_short_tna_F","CUP_arifle_CZ805_A2","CUP_hgun_Mk23","CUP_arifle_M4A1_SOMMOD_black","CUP_arifle_M16A4_Base","CUP_srifle_M110_black","CUP_lmg_Mk48","CUP_CZ_BREN2_556_11","CUP_srifle_SVD","CUP_launch_Igla","rhs_weap_pb_6p9","CUP_arifle_G36K_KSK_VFG_hex","rhs_weap_ak103","rhs_weap_ak104_zenitco01","CUP_arifle_G36K_KSK_VFG_camo","arifle_AK12_GL_lush_F","rhs_weap_ak103_2","rhs_weap_m4_mstock","CUP_arifle_AG36_camo","rhs_weap_pkm","rhs_weap_akm_gp25","rhs_weap_t5000","rhs_weap_ak74m","rhs_weap_igla","rhs_weap_svds","rhs_weap_ak103_zenitco01_npz","rhs_weap_pkp","rhs_weap_rpg7","rhs_weap_akm_zenitco01_b33","rhs_weap_rshg2","rhs_weap_6p53","rhs_weap_pp2000_folded","rhs_weap_ak74n_2_gp25","rhs_weap_vss_npz","rhs_weap_rpg18","rhs_weap_ak74mr","rhs_weap_rpg26","rhs_weap_rpk74m_npz","rhs_weap_ak103_gp25","rhs_weap_pya","rhs_weap_svdp_wd","rhs_weap_svdp_wd_npz","rhs_weap_rsp30_red","rhs_weap_rsp30_white","rhs_weap_makarov_pm","rhs_weap_rpg26_used","rhs_weap_rpk74m","rhs_weap_svds_npz"     ,"rhs_weap_vss","rhs_weap_ak104","arifle_Katiba_GL_F","rhs_weap_vss_grip_npz","rhs_weap_rsp30_green","rhs_weap_asval","rhs_weap_ak74mr_gp25","rhs_weap_akm","rhs_weap_ak104_zenitco01_b33","rhs_weap_ak74m_zenitco01_b33","rhs_weap_svdp","rhs_weap_asval_grip","rhs_weap_ak103_zenitco01_folded","rhs_weap_pm63","rhs_weap_ak103_zenitco01_b33","rhs_weap_aks74","rhs_weap_vss_grip","rhs_weap_aks74_gp25","rhs_weap_ak105_zenitco01_b33","rhs_weap_ak74_2","rhs_weap_ak105","rhs_weap_ak74","rhs_weap_ak74m_desert","SMG_03_black","rhs_weap_ak74m_gp25","arifle_AK12_GL_arid_F","rhs_weap_aks74u","rhs_weap_svdp_npz","rhs_weap_ak74m_camo","rhsusf_bino_lrf_Vector21","rhsusf_weap_m9","rhs_weap_m4a1","rhs_weap_asval_folded","rhs_weap_m4a1_mstock","rhs_weap_m72a7_used","rhs_weap_ak74m_folded","rhs_weap_akms","rhs_weap_m16a4_carryhandle","rhs_weap_m4_carryhandle","rhs_weap_m32","rhs_weap_fgm148","rhs_weap_m16a4_carryhandle_M203","rhs_weap_m4","rhs_weap_sr25","rhs_weap_m249_pip_L","rhs_weap_fim92","GX_M82A2000_Weapon","CUP_arifle_HK416_CQB_Desert","CUP_srifle_L129A1_HG_d","CUP_srifle_G22_des","rhs_weap_m16a4","rhs_weap_m24sws_d","rhs_weap_m4a1_m203","rhs_weap_m240B","rhs_weap_smaw_green","rhs_weap_rshg2_used","CUP_launch_FIM92Stinger_Used","CUP_launch_Igla_Used","arifle_MXM_Black_F","arifle_MX_GL_Black_F","CUP_launch_M72A6","rhs_weap_sr25_ec","rhs_weap_mk18_KAC","CUP_smg_MP7","rhs_weap_m4_carryhandle_m203","rhs_weap_M590_8RD","CUP_arifle_HK416_CQB_AG36_Wood","rhs_weap_M107","CUP_launch_PzF3","CUP_arifle_MG36_camo","rhs_weap_mk17_CQC","rhs_weap_ak74_3","rhs_weap_m4_carryhandle_m203S","rhs_weap_m40a5_wd","rhs_weap_M136","rhs_weap_mk17_LB","rhsusf_weap_glock17g4","rhsusf_bino_lerca_1200_tan","rhsusf_bino_lerca_1200_black","rhs_weap_m4a1_blockII_KAC"];
//THE ORIGINAL ENTRY FOR THE ITEMS "UGL_Flare[Color]_F" WAS TRANSFORMED IN "FlareYellow_F" AND NEW "UGL_Flare[Color]_F" ENTRIES WAS ADDED AT THE END
BRPVP_ItemsClassToNumberTableB = ["100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","10Rnd_338_Mag","10Rnd_93x64_DMR_05_Mag","11Rnd_45ACP_Mag","130Rnd_338_Mag","150Rnd_556x45_Drum_Mag_F","150Rnd_556x45_Drum_Mag_Tracer_F","150Rnd_762x54_Box","150Rnd_762x54_Box_Tracer","150Rnd_93x64_Mag","16Rnd_9x21_green_Mag","16Rnd_9x21_Mag","16Rnd_9x21_red_Mag","16Rnd_9x21_yellow_Mag","1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeBlue_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","200Rnd_556x45_Box_Tracer_F","200Rnd_556x45_Box_Tracer_Red_F","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","20Rnd_762x51_Mag","30Rnd_545x39_Mag_F","30Rnd_545x39_Mag_Green_F","30Rnd_545x39_Mag_Tracer_F","30Rnd_545x39_Mag_Tracer_Green_F","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_green","30Rnd_556x45_Stanag_red","30Rnd_556x45_Stanag_Tracer_Green","30Rnd_556x45_Stanag_Tracer_Red","30Rnd_556x45_Stanag_Tracer_Yellow","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","30Rnd_762x39_Mag_F","30Rnd_762x39_Mag_Green_F","30Rnd_762x39_Mag_Tracer_F","30Rnd_762x39_Mag_Tracer_Green_F","30Rnd_9x21_Green_Mag","30Rnd_9x21_Mag","30Rnd_9x21_Mag_SMG_02","30Rnd_9x21_Mag_SMG_02_Tracer_Green","30Rnd_9x21_Mag_SMG_02_Tracer_Yellow","30Rnd_9x21_Red_Mag","30Rnd_9x21_Yellow_Mag","6Rnd_45ACP_Cylinder","7Rnd_408_Mag","9Rnd_45ACP_Mag","APERSBoundingMine_Range_Mag","APERSMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","B_IR_Grenade","Chemlight_blue","Chemlight_green","ClaymoreDirectionalMine_Remote_Mag","DemoCharge_Remote_Mag","HandGrenade","MiniGrenade","NLAW_F","RPG32_F","RPG32_HE_F","SatchelCharge_Remote_Mag","SLAMDirectionalMine_Wire_Mag","SmokeShell","SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellPurple","Titan_AA","Titan_AP","Titan_AT","3Rnd_HE_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag","10Rnd_50BW_Mag_F","1Rnd_SmokePurple_Grenade_shell","FlareWhite_F","FlareYellow_F","FlareGreen_F","FlareRed_F","200Rnd_556x45_Box_F","SmokeShellYellow","30Rnd_762x39_AK12_Mag_F","20Rnd_556x45_UW_mag","MRAWS_HE_F","MRAWS_HEAT_F","30Rnd_45ACP_Mag_SMG_01","10Rnd_9x21_Mag","30Rnd_580x42_Mag_F","20Rnd_650x39_Cased_Mag_F","SmokeShellRed","FlareYellow_F","FlareYellow_F","Laserbatteries","Vorona_HE","30Rnd_65x39_caseless_khaki_mag","100Rnd_580x42_Mag_F","10Rnd_127x54_Mag","1Rnd_SmokeYellow_Grenade_shell","150Rnd_556x45_Drum_Sand_Mag_Tracer_F","Vorona_HEAT","CUP_7Rnd_45ACP_1911","CUP_10Rnd_9x19_Compact","CUP_17Rnd_9x19_glock17","CUP_15Rnd_9x19_M9","CUP_8Rnd_9x18_Makarov_M","CUP_8Rnd_9x18_MakarovSD_M","CUP_30Rnd_9x19_UZI","CUP_18Rnd_9x19_Phantom","CUP_6Rnd_45ACP_M","CUP_10Rnd_B_765x17_Ball_M","CUP_20Rnd_B_765x17_Ball_M","CUP_50Rnd_B_765x17_Ball_M","CUP_30Rnd_545x39_AK_M","CUP_30Rnd_545x39_AK74M_M","CUP_30Rnd_545x39_AK74_plum_M","CUP_30Rnd_545x39_AK74M_camo_M","CUP_20Rnd_545x39_AKSU_M","CUP_20Rnd_Subsonic_545x39_AKSU_M","CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M","CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK74M_M","CUP_60Rnd_545x39_AK74M_M","CUP_60Rnd_TE1_Green_Tracer_545x39_AK74M_M","CUP_30Rnd_762x39_AK47_M","CUP_30Rnd_762x39_AK47_bakelite_M","CUP_30Rnd_762x39_AK103_bakelite_M","CUP_30Rnd_762x39_AK47_TK_M","CUP_20Rnd_762x39_AMD63_M","CUP_10Rnd_762x39_SaigaMk03_M","CUP_40Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M","CUP_75Rnd_TE4_LRT4_Green_Tracer_762x39_RPK_M","CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M","CUP_30Rnd_556x45_G36","CUP_100Rnd_556x45_BetaCMag","CUP_20Rnd_762x51_CZ805B","CUP_20Rnd_762x51_FNFAL_M","CUP_30Rnd_556x45_G36_camo","CUP_30Rnd_556x45_G36_wdl","CUP_30Rnd_556x45_G36_hex","CUP_100Rnd_556x45_BetaCMag_camo","CUP_100Rnd_556x45_BetaCMag_wdl","CUP_100Rnd_556x45_BetaCMag_hex","CUP_30Rnd_TE1_Red_Tracer_556x45_G36_camo","CUP_30Rnd_TE1_Red_Tracer_556x45_G36_wdl","CUP_30Rnd_TE1_Red_Tracer_556x45_G36_hex","CUP_30Rnd_556x45_XM8","CUP_30Rnd_TE1_Red_Tracer_556x45_XM8","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_camo","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_wdl","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_wdl","CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_hex","CUP_30Rnd_556x45_Stanag_L85","CUP_30Rnd_556x45_Stanag","CUP_30Rnd_556x45_Emag","CUP_30Rnd_556x45_Stanag_Mk16","CUP_30Rnd_556x45_Stanag_Mk16_black","CUP_30Rnd_556x45_Stanag_Mk16_woodland","CUP_20Rnd_556x45_Stanag","CUP_60Rnd_556x45_SureFire","CUP_100Rnd_556x45_BetaCMag_ar15","CUP_30Rnd_Sa58_M","CUP_20Rnd_762x51_B_SCAR","CUP_20Rnd_762x51_B_SCAR_bkl","CUP_20Rnd_762x51_B_SCAR_wdl","CUP_30Rnd_762x51_1_B_SCAR","CUP_30Rnd_762x51_2_B_SCAR","CUP_50Rnd_762x51_B_SCAR","CUP_20Rnd_B_AA12_Pellets","CUP_20Rnd_B_AA12_74Slug","CUP_20Rnd_B_AA12_HE","CUP_8Rnd_B_Beneli_74Slug","CUP_8Rnd_B_Beneli_74Pellets","CUP_8Rnd_B_Saiga12_74Slug_M","CUP_8Rnd_B_Saiga12_74Pellets_M","CUP_100Rnd_TE4_LRT4_Green_Tracer_762x51_Belt_M","CUP_200Rnd_TE4_Red_Tracer_556x45_M249","CUP_100Rnd_TE4_Green_Tracer_556x45_M249","CUP_200Rnd_TE4_Green_Tracer_556x45_L110A1","CUP_30Rnd_TE1_Green_Tracer_556x45_G36","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M","CUP_50Rnd_UK59_762x54R_Tracer","CUP_5Rnd_127x99_as50_M","CUP_5Rnd_86x70_L115A1","CUP_10Rnd_762x51_CZ750","CUP_20Rnd_762x51_DMR","CUP_20Rnd_TE1_Yellow_Tracer_762x51_DMR","CUP_5x_22_LR_17_HMR_M","CUP_10x_303_M","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_ar15","CUP_5Rnd_762x51_M24","CUP_10Rnd_127x99_m107","CUP_20Rnd_762x51_B_M110","CUP_20Rnd_TE1_Yellow_Tracer_762x51_M110","CUP_10Rnd_762x54_SVD_M","CUP_5Rnd_127x108_KSVK_M","CUP_10Rnd_9x39_SP5_VSS_M","CUP_20Rnd_9x39_SP5_VSS_M","CUP_30Rnd_9x39_SP5_VIKHR_M","CUP_MAAWS_HEAT_M","CUP_MAAWS_HEDP_M","CUP_AT13_M","CUP_PG7V_M","CUP_PG7VM_M","CUP_PG7VL_M","CUP_PG7VR_M","CUP_OG7_M","CUP_TBG7V_M","CUP_RPG18_M","CUP_SMAW_HEAA_M","CUP_SMAW_HEDP_M","CUP_1Rnd_HE_GP25_M","CUP_IlumFlareWhite_GP25_M","CUP_IlumFlareRed_GP25_M","CUP_IlumFlareGreen_GP25_M","CUP_FlareWhite_GP25_M","CUP_FlareGreen_GP25_M","CUP_FlareRed_GP25_M","CUP_FlareYellow_GP25_M","CUP_1Rnd_SMOKE_GP25_M","CUP_1Rnd_SMOKERED_GP25_M","CUP_1Rnd_SMOKEGREEN_GP25_M","CUP_1Rnd_SMOKEYELLOW_GP25_M","CUP_Dragon_EP1_M","CUP_NLAW_M","CUP_M136_M","CUP_Javelin_M","CUP_Igla_M","CUP_Stinger_M","CUP_Strela_2_M","CUP_6Rnd_HE_GP25_M","CUP_PTFHE_M","CUP_PTFHC_M","CUP_PTF3IT_M","CUP_APILAS_M","CUP_20Rnd_762x51_L129_M","2Rnd_12Gauge_Pellets","CUP_30Rnd_Subsonic_545x39_AK74M_M","CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_Woodland_M","6Rnd_12Gauge_Pellets","CUP_30Rnd_556x45_AK","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_ar15","CUP_100Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M","CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_ar15","FlareYellow_F","CUP_30Rnd_TE1_Red_Tracer_556x45_G36","CUP_30Rnd_762x39_AKM_bakelite_desert_M","CUP_20Rnd_762x51_HK417_Camo_Wood","30Rnd_65x39_caseless_msbs_mag","CUP_120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M","CUP_20Rnd_TE1_Yellow_Tracer_762x51_FNFAL_Desert_M","CUP_30Rnd_9x19_MP5","CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M","CUP_30Rnd_9x19_Vityaz","10Rnd_762x54_Mag","CUP_20Rnd_762x51_HK417","CUP_30Rnd_556x45_PMAG_QP","30Rnd_65x39_caseless_khaki_mag_Tracer","CUP_120Rnd_TE4_LRT4_Green_Tracer_762x51_Belt_M","CUP_20Rnd_TE1_Green_Tracer_762x51_FNFAL_Desert_M","CUP_20Rnd_TE1_Yellow_Tracer_762x51_FNFAL_Woodland_M","CUP_30Rnd_TE1_Green_Tracer_762x51_1_SCAR","CUP_10Rnd_TE1_Green_Tracer_762x51_FNFAL_M","CUP_30Rnd_Sa58_M_TracerR","CUP_30Rnd_TE1_Red_Tracer_762x39_AKM_bakelite_desert_M","CUP_20Rnd_762x51_HK417_Camo_Desert","CUP_30Rnd_TE1_Green_Tracer_762x39_AK47_M","CUP_30Rnd_TE1_Red_Tracer_545x39_AK74M_M","CUP_200Rnd_TE4_Green_Tracer_556x45_M249","FlareYellow_F","CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M","CUP_30Rnd_9x19AP_Vityaz","30Rnd_556x45_Stanag_Sand_green","CUP_30Rnd_TE1_Yellow_Tracer_762x39_AK47_M","CUP_30Rnd_TE1_Yellow_Tracer_762x39_bakelite_AK103_M","CUP_1Rnd_SmokeYellow_GP25_M","CUP_30Rnd_TE1_Yellow_Tracer_556x45_G36","CUP_30Rnd_TE1_Green_Tracer_762x39_AK103_bakelite_M","CUP_10Rnd_127x99_M107","CUP_SMAW_NE_M","CUP_5Rnd_762x67_G22","CUP_20Rnd_TE1_Green_Tracer_762x51_M110","CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M","100Rnd_65x39_caseless_khaki_mag","CUP_30Rnd_556x45_CZ805","CUP_20Rnd_TE1_Green_Tracer_762x51_SCAR_wdl","CUP_30Rnd_TE1_Green_Tracer_762x39_AKM_bakelite_desert_M","CUP_M72A6_M","MRAWS_HEAT55_F","75rnd_762x39_AK12_Arid_Mag_F","CUP_1Rnd_SmokeGreen_GP25_M","CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249_Pouch","CUP_30Rnd_556x45_Stanag_Mk16_woodland_Tracer_Yellow","2Rnd_12Gauge_Slug","CUP_20Rnd_TE1_Yellow_Tracer_762x51_SCAR_bkl","CUP_20Rnd_TE1_Green_Tracer_762x51_DMR","75rnd_762x39_AK12_Lush_Mag_F","100Rnd_65x39_caseless_black_mag","50Rnd_570x28_SMG_03","10Rnd_Mk14_762x51_Mag","200Rnd_65x39_cased_Box_Tracer_Red","200Rnd_65x39_cased_Box_Red","75rnd_762x39_AK12_Arid_Mag_Tracer_F","30Rnd_556x45_Stanag_Sand","30Rnd_45ACP_Mag_SMG_01_Tracer_Green","UGL_FlareCIR_F","30Rnd_65x39_caseless_black_mag","30Rnd_65x39_caseless_black_mag_Tracer","200Rnd_556x45_Box_Red_F","30Rnd_556x45_Stanag_Sand_red","30Rnd_556x45_Stanag_Sand_Tracer_Yellow","150Rnd_556x45_Drum_Sand_Mag_F","I_IR_Grenade","30Rnd_65x39_caseless_msbs_mag_Tracer","6Rnd_12Gauge_Slug","75rnd_762x39_AK12_Lush_Mag_Tracer_F","30rnd_762x39_AK12_Arid_Mag_F","30rnd_762x39_AK12_Arid_Mag_Tracer_F","30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow","30Rnd_556x45_Stanag_Sand_Tracer_Green","30Rnd_556x45_Stanag_Sand_Tracer_Red","30Rnd_9x21_Mag_SMG_02_Tracer_Red","Chemlight_red","UGL_FlareWhite_F","UGL_FlareYellow_F","UGL_FlareGreen_F","UGL_FlareRed_F","CUP_HandGrenade_M67","CUP_1Rnd_HE_M203","CUP_1Rnd_HEDP_M203","CUP_1Rnd_SmokeGreen_M203","CUP_1Rnd_SmokeRed_M203","CUP_1Rnd_Smoke_M203","CUP_1Rnd_StarFlare_White_M203","CUP_1Rnd_StarFlare_Red_M203","CUP_1Rnd_StarFlare_Green_M203","CUP_1Rnd_StarCluster_Green_M203","CUP_HandGrenade_L109A2_HE","Chemlight_yellow","CUP_PipeBomb_M","CUP_HandGrenade_L109A1_HE","CUP_30Rnd_TE1_Yellow_Tracer_556x45_AK","CUP_30Rnd_Subsonic_9x19_MP5","CUP_10Rnd_9x19_Saiga9","CUP_64Rnd_Red_Tracer_9x19_Bizon_M","CUP_30Rnd_Yellow_Tracer_9x19_MP5","CUP_30Rnd_Sa58_desert_M_TracerY","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Red_M","CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag","CUP_1Rnd_StarCluster_White_M203","rhs_mag_30Rnd_556x45_M855A1_EPM_Tracer_Red","rhs_mag_9x19_17","rhs_30Rnd_545x39_7N6M_green_AK","rhs_mag_9k38_rocket","rhs_mag_762x25_8","CUP_30Rnd_Red_Tracer_9x19_MP5","rhsgref_20rnd_765x17_vz61","rhsusf_mag_15Rnd_9x19_FMJ","rhs_30Rnd_545x39_7N6_AK","rhs_mag_30Rnd_556x45_M855A1_Stanag_Pull","rhs_fim92_mag","CUP_120Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag","rhsusf_mine_m14_mag","rhs_30Rnd_762x39mm_89","CUP_20Rnd_TE1_Red_Tracer_762x51_DMR","CUP_200Rnd_TE1_Red_Tracer_556x45_M249_Pouch","CUP_10Rnd_762x51_CZ750_Tracer","CUP_20Rnd_TE1_Red_Tracer_762x51_HK417","CUP_30Rnd_TE1_Green_Tracer_556x45_AK","100Rnd_580x42_ghex_Mag_F","75rnd_762x39_AK12_Mag_F","30Rnd_580x42_Mag_Tracer_F","CUP_64Rnd_Yellow_Tracer_9x19_Bizon_M","100Rnd_580x42_ghex_Mag_Tracer_F","CUP_30Rnd_9x19_EVO","CUP_MineE_M","CUP_120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M","CUP_12Rnd_45ACP_mk23","CUP_64Rnd_Green_Tracer_9x19_Bizon_M","CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Yellow_M","CUP_30Rnd_556x45_Stanag_Mk16_Tracer_Green","CUP_20Rnd_TE1_White_Tracer_762x51_DMR","CUP_30Rnd_556x45_PMAG_QP_Olive","rhs_VG40OP_green","rhs_mag_9x18_8_57N181S","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag","CUP_8Rnd_12Gauge_Pellets_No00_Buck","CUP_8Rnd_12Gauge_Slug","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_hex","CUP_200Rnd_TE4_Yellow_Tracer_556x45_L110A1","rhs_30Rnd_545x39_7N10_plum_AK","rhs_30Rnd_762x39mm_polymer","rhs_mag_an_m14_th3","rhs_mag_30Rnd_556x45_M855_PMAG_Tracer_Red","rhs_10Rnd_762x39mm_tracer","rhs_GRD40_Red","CUP_20Rnd_TE1_White_Tracer_762x51_M110","rhs_ec400_mag","rhs_mag_m18_yellow","rhs_GRD40_White","CUP_30Rnd_TE1_Yellow_Tracer_556x45_G36_hex","CUP_30Rnd_TE1_Yellow_Tracer_545x39_AK_desert_M","CUP_30Rnd_Subsonic_545x39_AK_M","CUP_1Rnd_SmokeRed_GP25_M","CUP_200Rnd_TE4_Green_Tracer_556x45_M249_Pouch","rhs_VOG25","rhs_ec200_sand_mag","rhs_GRD40_Green","30rnd_762x39_AK12_Lush_Mag_F","30rnd_762x39_AK12_Lush_Mag_Tracer_F","CUP_30Rnd_TE1_White_Tracer_545x39_AK_M","CUP_30Rnd_762x51_FNFAL_M","CUP_100Rnd_TE1_Yellow_Tracer_556x45_BetaCMag_wdl","CUP_200Rnd_TE1_Red_Tracer_556x45_M249","CUP_30Rnd_TE1_White_Tracer_545x39_AK74_plum_M","rhs_VG40OP_white","rhs_mine_M19_mag","rhs_mag_30Rnd_556x45_M855A1_Stanag","CUP_FlareWhite_M203","rhs_30Rnd_762x39mm_U","immersion_pops_poppack","rhs_30Rnd_762x39mm","rhs_mag_rgn","rhs_mag_fakel","rhs_mag_rdg2_white","rhs_45Rnd_545X39_7U1_AK","rhs_100Rnd_762x54mmR_green","rhs_45Rnd_545X39_7N6M_AK","rhs_10Rnd_762x54mmR_7N1","rhs_mag_nspd","rhs_30Rnd_762x39mm_bakelite","rhs_30Rnd_545x39_7N10_AK","rhs_30Rnd_545x39_7N10_camo_AK","rhs_30Rnd_545x39_7N10_desert_AK","murshun_cigs_cigpack","RPG7_F","murshun_cigs_matches","rhs_100Rnd_762x54mmR_7BZ3","rhs_rshg2_mag","rhs_ec400_sand_mag","rhs_mine_msk40p_white_mag","rhs_30Rnd_762x39mm_bakelite_U","rhs_rpg7_TBG7V_mag","rhs_18rnd_9x21mm_7N28","rhs_mag_9x19mm_7n31_20","rhs_30Rnd_545x39_7N6M_plum_AK","rhs_10rnd_9x39mm_SP6","rhs_rpg18_mag","rhs_100Rnd_762x54mmR_7N26","rhs_rpg26_mag","rhs_30Rnd_545x39_7N22_AK","rhs_mine_tm62m_mag","rhs_mag_fakels","rhs_rpg7_PG7VL_mag","rhs_mag_mine_ptm1","rhs_30Rnd_762x39mm_bakelite_89","rhs_mine_msk40p_blue_mag","rhs_100Rnd_762x54mmR","rhs_mag_mine_pfm1","rhs_30Rnd_545x39_7N22_camo_AK","rhs_20rnd_9x39mm_SP5","rhs_mag_plamyam","rhs_ec75_mag","rhs_mag_9x19_7n31_17","rhs_10Rnd_762x54mmR_7N14","rhs_rpg7_PG7VM_mag","rhs_mag_rsp30_red","rhs_18rnd_9x21mm_7BT3","rhs_ec200_mag","rhs_mag_rsp30_white","rhs_rpg7_PG7V_mag","rhs_mag_rsp30_green"     ,"rhs_mag_nspn_red","rhs_mag_9x19mm_7n21_20","rhs_20rnd_9x39mm_SP6","rhs_30Rnd_545x39_7N22_desert_AK","rhs_30Rnd_545x39_7N6_green_AK","rhs_rpg7_type69_airburst_mag","rhs_10rnd_9x39mm_SP5","rhs_VG40TB","rhs_VG40SZ","rhs_VG40OP_red","rhs_mag_zarya2","rhs_30Rnd_545x39_7N22_plum_AK","rhs_mine_ozm72_a_mag","rhs_mag_rgd5","rhs_mag_nspn_yellow","rhs_mine_sm320_white_mag","rhs_mine_sm320_green_mag","rhs_mine_msk40p_green_mag","rhs_mine_ozm72_b_mag","rhs_mine_ozm72_c_mag","rhs_rpg7_PG7VR_mag","rhs_5Rnd_338lapua_t5000","rhs_mag_9x19mm_7n21_44","murshun_cigs_lighter","rhs_100Rnd_762x54mmR_7N13","rhs_mine_sm320_red_mag","rhs_rpg7_PG7VS_mag","rhs_mag_nspn_green","rhs_mag_rgo","rhs_30Rnd_545x39_7N6M_AK","rhs_mine_pmn2_mag","rhs_30Rnd_762x39mm_bakelite_tracer","I_E_IR_Grenade","rhs_18rnd_9x21mm_7N29","rhs_mag_rdg2_black","100Rnd_65x39_caseless_black_mag_tracer","rhs_mag_9x19mm_7n31_44","rhs_rpg7_OG7V_mag","rhs_mine_msk40p_red_mag","rhsusf_mag_10Rnd_STD_50BMG_mk211","rhsusf_mag_10Rnd_STD_50BMG_M33","CUP_200Rnd_TE4_Yellow_Tracer_556x45_M249","rhs_mag_an_m8hc","CUP_30Rnd_Green_Tracer_9x19_MP5","rhs_mag_30Rnd_556x45_M855_Stanag_Tracer_Red","rhsusf_20Rnd_762x51_SR25_m118_special_Mag","CUP_100Rnd_TE4_Yellow_Tracer_556x45_M249","CUP_100Rnd_TE4_Red_Tracer_556x45_M249","rhs_m136_mag","rhs_mag_30Rnd_556x45_M196_Stanag_Tracer_Red","rhsusf_50Rnd_762x51_m61_ap","rhsusf_mag_6Rnd_M714_white","rhs_30Rnd_762x39mm_tracer","rhs_mag_30Rnd_556x45_M855_Stanag","rhsusf_mag_6Rnd_M576_Buckshot","rhs_mag_m67","rhsusf_50Rnd_762x51","rhs_fgm148_magazine_AT","rhsusf_mag_6Rnd_M433_HEDP","rhs_mag_M433_HEDP","rhs_mag_30Rnd_556x45_Mk318_Stanag","rhsusf_200rnd_556x45_M855_box","rhsusf_20Rnd_762x51_SR25_m62_Mag","rhs_mag_smaw_HEDP","rhsusf_m112_mag","CUP_30Rnd_556x45_PMAG_QP_Tan","CUP_30Rnd_TE1_Green_Tracer_545x39_AK74_plum_M","CUP_30Rnd_TE1_Yellow_Tracer_556x45_G36_camo","CUP_64Rnd_White_Tracer_9x19_Bizon_M","CUP_30Rnd_TE1_Yellow_Tracer_762x39_AKM_bakelite_desert_M","CUP_30Rnd_TE1_Green_Tracer_556x45_CZ805","CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR_wdl","CUP_20Rnd_Sa58_M_TracerY","rhsusf_5Rnd_762x51_m993_Mag","rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red","rhs_mag_m715_Green","rhs_mag_m661_green","rhs_mag_m18_red","rhs_mag_m18_green","rhs_mag_m18_purple","rhs_mag_M583A1_white","rhsusf_mag_6Rnd_m4009","GX_M82A2000_10Rnd_Plasma_HE_Mag","CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1","CUP_12Rnd_9x18_PMM_M","Titan_MIL_AP","rhsusf_100Rnd_556x45_M855_soft_pouch","CUP_30Rnd_TE1_Yellow_Tracer_762x39_bakelite_AK47_M","TITAN_MIL_KE","30Rnd_45ACP_Mag_SMG_01_Tracer_Red","MAA_MAAWS_HE441_AB250","MAA_MAAWS_GMM_HE","CUP_30Rnd_TE1_Green_Tracer_556x45_G36_hex","CUP_IllumFlareYellow_265_M","MAA_MAAWS_GMM_HEAT","CUP_30Rnd_TE1_Yellow_Tracer_545x39_AK_M","CUP_30Rnd_TE1_Red_Tracer_556x45_AK","MAA_MAAWS_HEDP502","MAA_MAAWS_GMM_MT","KUoooK_MAG_Cluster","LAGO_SCannon_MAG","CUP_20Rnd_TE1_Yellow_Tracer_762x51_HK417","CUP_30Rnd_TE1_Red_Tracer_545x39_AK_desert_M","CUP_30Rnd_TE1_Red_Tracer_762x39_AK47_M","CUP_30Rnd_TE1_Green_Tracer_556x45_XM8","CUP_30Rnd_TE1_Red_Tracer_762x39_AK103_bakelite_M","CUP_30Rnd_545x39_AK74M_desert_M","2Rnd_12Gauge_Dagon_Breath","UAS_BASE_50Beowulf_ARX_10Rnd","UAS_BASE_45ACP_Norman_15Rnd","UAS_BASE_93x64_BT_260Rnd","CUP_30Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M","CUP_200Rnd_TE4_Red_Tracer_556x45_M249_Pouch","CUP_50Rnd_TE1_White_Tracer_762x51_SCAR","CUP_Mine_M","CUP_40Rnd_46x30_MP7","CUP_HandGrenade_RGD5","KA_40mm_M814","UAS_BASE_338_SAPI_10Rnd","UAS_BASE_556_M856A2_150Rnd_SAW","UAS_BASE_762N_M62A1_50Rnd","2Rnd_12Gauge_Shrapnel","CUP_20Rnd_TE1_Red_Tracer_762x51_M110","rhs_mag_30Rnd_556x45_Mk262_Stanag","CUP_100Rnd_TE1_Green_Tracer_556x45_BetaCMag_camo","CUP_45Rnd_Sa58_M","CUP_FlareGreen_M203","rhsusf_8Rnd_00Buck","UAS_BASE_556_M856A2_200Rnd","CUP_30Rnd_TE1_Green_Tracer_556x45_G36_wdl","UAS_BASE_9x19_Pricker_150Rnd","UAS_BASE_762x39_T45M_150Rnd","rhsusf_mag_17Rnd_9x19_FMJ","CUP_64Rnd_9x19_Bizon_M","CUP_30Rnd_TE1_White_Tracer_545x39_AK74M_M","UAS_BASE_556_TUI_30Rnd","UAS_BASE_338_Glasser_10Rnd","UAS_Base_132mm_HE479B_1Rnd","UAS_Base_84mm_GCGM_1Rnd","UAS_Base_84mm_GCGM_WP_1Rnd","UAS_Base_84mm_Toothpick_1Rnd","rhs_30Rnd_545x39_AK_green","rhsusf_m112x4_mag","CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag_hex","rhs_mag_20Rnd_SCAR_762x51_mk316_special","rhs_mag_30Rnd_556x45_M193_Stanag","CUP_30Rnd_556x45_Stanag_Mk16_woodland_Tracer_Green","rhsusf_5Rnd_762x51_m118_special_Mag","rhsusf_5Rnd_762x51_m62_Mag","rhsusf_5Rnd_762x51_AICS_m118_special_Mag","CSW_30rnd_7N6M_FMJ_HSC_mag","CUP_30Rnd_556x45_Stanag_Mk16_Tracer_Yellow","CUP_FlareYellow_M203","CUP_10Rnd_TE1_Yellow_Tracer_762x51_FNFAL_M","rhs_mag_mk84","APERSMineDispenser_Mag","CSW_30rnd_7N10_FMJ_IP_mag","CSW_30rnd_7N39_SAP_TC_mag","rhs_mag_20Rnd_SCAR_762x51_m80_ball","UAS_BASE_762N_M62A1_200Rnd","UAS_BASE_545x39_7T3M_95Rnd","UAS_BASE_762x39_T45M_75Rnd","UAS_BASE_300WinMag_Glasser_20Rnd","UAS_BASE_762N_M62A1_10Rnd","CUP_10Rnd_TE1_Red_Tracer_762x51_FNFAL_M","rhs_45Rnd_545X39_7N10_AK","UAS_Base_132mm_Toothpick_1Rnd","CUP_30Rnd_556x45_Stanag_Mk16_black_Tracer_Red","CUP_30Rnd_556x45_EMAG_Olive"];
BRPVP_ItemsClassToNumberTableC = ["acc_flashlight","acc_pointer_IR","bipod_01_F_blk","bipod_01_F_khk","bipod_01_F_mtp","bipod_01_F_snd","bipod_02_F_blk","bipod_02_F_hex","bipod_02_F_tan","bipod_03_F_oli","FirstAidKit","G_Balaclava_TI_G_blk_F","G_Diving","H_Bandanna_surfer","H_Cap_blk","H_Cap_oli","H_Cap_red","H_Cap_surfer","H_Cap_tan","H_Hat_tan","H_HelmetIA","H_PilotHelmetFighter_O","H_PilotHelmetHeli_O","H_Shemag_olive","H_Watchcap_camo","ItemCompass","ItemGPS","ItemMap","ItemWatch","Medikit","MineDetector","muzzle_snds_338_black","muzzle_snds_338_green","muzzle_snds_338_sand","muzzle_snds_58_blk_F","muzzle_snds_58_wdm_F","muzzle_snds_65_TI_blk_F","muzzle_snds_65_TI_ghex_F","muzzle_snds_65_TI_hex_F","muzzle_snds_93mmg","muzzle_snds_93mmg_tan","muzzle_snds_acp","muzzle_snds_B","muzzle_snds_B_khk_F","muzzle_snds_B_snd_F","muzzle_snds_H","muzzle_snds_H_khk_F","muzzle_snds_H_MG","muzzle_snds_H_MG_blk_F","muzzle_snds_H_SW","muzzle_snds_L","muzzle_snds_M","muzzle_snds_m_khk_F","NVGoggles","optic_Aco","optic_ACO_grn","optic_ACO_grn_smg","optic_Aco_smg","optic_AMS","optic_AMS_khk","optic_AMS_snd","optic_Arco","optic_DMS","optic_Hamr","optic_Holosight","optic_Holosight_smg","optic_KHS_blk","optic_KHS_hex","optic_KHS_old","optic_KHS_tan","optic_LRPS","optic_MRCO","optic_MRD","optic_NVS","optic_SOS","optic_tws_mg","optic_Yorris","ToolKit","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_GhillieSuit","U_O_OfficerUniform_ocamo","U_O_PilotCoveralls","U_O_Protagonist_VR","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_O_T_FullGhillie_tna_F","U_O_T_Sniper_F","U_O_V_Soldier_Viper_F","U_O_V_Soldier_Viper_hex_F","U_O_Wetsuit","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_PlateCarrier_Kerry","V_PlateCarrier1_tna_F","V_PlateCarrier2_rgr","V_PlateCarrierGL_rgr","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierSpec_rgr","V_TacVest_blk","H_Cap_blu","H_Cap_grn","V_Chestrig_oli","V_Chestrig_rgr","H_HelmetB_snakeskin","H_HelmetO_ocamo","H_HelmetLeaderO_ocamo","V_Chestrig_khk","U_C_Man_casual_2_F","U_C_Man_casual_3_F","V_PlateCarrierGL_tna_F","V_RebreatherB","H_HelmetB_Enh_tna_F","optic_Hamr_khk_F","optic_tws","optic_SOS_khk_F","optic_Nightstalker","optic_ERCO_blk_F","optic_LRPS_tna_F","muzzle_snds_m_snd_F","H_HelmetB_TI_tna_F","NVGogglesB_grn_F","G_Balaclava_TI_G_tna_F","U_B_CTRG_Soldier_F","V_PlateCarrierSpec_tna_F","U_I_Wetsuit","V_RebreatherIA","V_RebreatherIR","U_C_Man_casual_6_F","U_C_Man_casual_5_F","G_Bandanna_tan","NVGogglesB_blk_F","V_TacVest_oli","V_TacVest_khk","U_I_C_Soldier_Para_2_F","O_UavTerminal","G_Balaclava_Ti_blk_F","G_Squares_Tinted","muzzle_snds_H_snd_F","U_C_man_sport_1_F","G_Tactical_Black","V_TacVest_gen_F","G_Balaclava_blk","H_HelmetSpecO_ocamo","H_MilCap_gen_F","H_Beret_gen_F","V_PlateCarrier2_tna_F","H_Hat_blue","H_Bandanna_mcamo","G_Spectacles","U_C_man_sport_2_F","NVGogglesB_gry_F","O_NVGoggles_urb_F","H_HelmetO_ViperSP_hex_F","H_HelmetO_ViperSP_ghex_F","H_PASGT_neckprot_blue_press_F","H_HelmetSpecB_paint2","V_EOD_blue_F","V_EOD_coyote_F","V_EOD_olive_F","G_Sport_Blackred","G_Shades_Red","G_Shades_Green","CUP_optic_PSO_1","CUP_optic_PSO_3","CUP_optic_Kobra","CUP_optic_AN_PAS_13c2","CUP_optic_GOSHAWK","CUP_optic_CWS","CUP_optic_AN_PAS_13c1","CUP_optic_NSPU","CUP_optic_PechenegScope","CUP_optic_MAAWS_Scope","CUP_optic_SMAW_Scope","CUP_optic_LeupoldMk4","CUP_optic_HoloBlack","CUP_optic_HoloWdl","CUP_optic_HoloDesert","CUP_optic_Eotech533","CUP_optic_CompM4","CUP_optic_SUSAT","CUP_optic_ACOG","CUP_optic_Leupold_VX3","CUP_optic_AN_PVS_10","CUP_optic_CompM2_Black","CUP_optic_CompM2_Woodland","CUP_optic_CompM2_Woodland2","CUP_optic_CompM2_Desert","CUP_optic_RCO","CUP_optic_RCO_desert","CUP_optic_LeupoldM3LR","CUP_optic_LeupoldMk4_10x40_LRT_Desert","CUP_optic_LeupoldMk4_10x40_LRT_Woodland","CUP_optic_ElcanM145","CUP_optic_LeupoldMk4_CQ_T","CUP_optic_ELCAN_SpecterDR","CUP_optic_LeupoldMk4_MRT_tan","CUP_optic_SB_11_4x20_PM","CUP_optic_ZDDot","CUP_optic_MRad","CUP_optic_TrijiconRx01_desert","CUP_optic_TrijiconRx01_black","CUP_optic_AN_PVS_4","CUP_optic_PSO_1_AK","CUP_optic_ekp_8_02","CUP_optic_PSO_1_1","CUP_optic_MicroT1","CUP_optic_SB_3_12x50_PMII","CUP_optic_Elcan","CUP_optic_ZeissZPoint","CUP_optic_PGO7V","CUP_optic_PGO7V2","CUP_optic_PGO7V3","CUP_optic_NSPU_RPG","CUP_muzzle_PBS4","CUP_muzzle_PB6P9","CUP_muzzle_Bizon","CUP_muzzle_snds_M110","CUP_muzzle_snds_M14","CUP_muzzle_snds_M9","CUP_muzzle_snds_MicroUzi","CUP_muzzle_snds_AWM","CUP_muzzle_snds_G36_black","CUP_muzzle_snds_G36_desert","CUP_muzzle_snds_L85","CUP_muzzle_snds_M16_camo","CUP_muzzle_snds_M16","CUP_muzzle_snds_SCAR_L","CUP_muzzle_mfsup_SCAR_L","CUP_muzzle_snds_SCAR_H","CUP_muzzle_mfsup_SCAR_H","CUP_muzzle_snds_XM8","ItemRadio","bipod_02_F_lush","bipod_02_F_arid","bipod_03_F_blk","CUP_acc_CZ_M3X","U_O_T_Officer_F","H_HelmetB","V_PlateCarrier1_rgr","H_HelmetB_tna_F","H_HelmetB_light_desert","H_HelmetB_grass","H_HelmetB_desert","U_O_R_Gorka_01_black_F","V_TacVest_blk_POLICE","V_CarrierRigKBT_01_Olive_F","NVGoggles_tna_F","G_Sport_Checkered","G_Tactical_Clear","H_Booniehat_mcamo","U_B_T_Soldier_F","U_O_R_Gorka_01_brown_F","U_I_G_resistanceLeader_F","G_Combat","","CUP_optic_LeupoldMk4_10x40_LRT_Desert_pip","CUP_optic_ACOG_PIP","CUP_optic_Elcan_SpecterDR","CUP_optic_Elcan_pip","CUP_optic_ACOG_TA01NSN_Coyote_PIP","CUP_optic_SUSAT_PIP","CUP_optic_ElcanM145_PIP","CUP_optic_LeupoldMk4_10x40_LRT_Woodland_pip","CUP_optic_Elcan_SpecterDR_pip","CUP_optic_SB_11_4x20_PM_pip","CUP_optic_Leupold_VX3_pip","G_Balaclava_TI_blk_F","CUP_acc_Flashlight","CUP_optic_G36DualOptics_PIP","CUP_acc_ANPEQ_2","optic_Arco_ghex_F","CUP_optic_SB_3_12x50_PMII_PIP","optic_LRPS_ghex_F","CUP_optic_LeupoldMk4_25x50_LRT_pip","CUP_Mxx_camo","CUP_SVD_camo_g","CUP_optic_LeupoldMk4_pip","H_MilCap_tna_F","H_HelmetB_Light_tna_F","U_C_Man_casual_1_F","U_C_Man_casual_4_F","G_Shades_Black","H_MilCap_mcamo","H_HelmetB_light","G_Aviator","CUP_optic_LeupoldMk4_MRT_tan_pip","CUP_optic_G36DualOptics","CUP_optic_LeupoldM3LR_pip","H_HelmetSpecB","V_SmershVest_01_F","U_I_FullGhillie_ard","H_Booniehat_tna_F","U_B_GEN_Commander_F","G_Sport_Greenblack","I_UavTerminal","H_HeadSet_black_F","V_PlateCarrier2_blk","H_HelmetSpecB_blk","V_PlateCarrierSpec_blk","U_B_CBRN_Suit_01_Wdl_F","H_HelmetSpecB_wdl","V_PlateCarrier2_wdl","U_B_CombatUniform_mcam","V_PlateCarrierGL_wdl","H_Cap_khaki_specops_UK","NVGoggles_OPFOR","H_HelmetB_sand","V_TacVest_brn","G_Bandanna_beast","NVGoggles_INDEP","H_HelmetB_plain_wdl","V_PlateCarrier1_wdl","H_MilCap_wdl","H_HelmetB_light_wdl","H_CrewHelmetHeli_B","G_Sport_BlackWhite","V_PlateCarrierIA1_dgtl","H_WirelessEarpiece_F","V_PlateCarrierSpec_mtp","H_Beret_Colonel","U_B_FullGhillie_ard","G_Shades_Blue","U_I_ParadeUniform_01_AAF_decorated_F","optic_ico_01_f","G_Sport_Blackyellow","H_HelmetLeaderO_ghex_F","U_B_Protagonist_VR","G_Lady_Blue","U_I_E_Uniform_01_shortsleeve_F","V_PlateCarrierL_CTRG","G_AirPurifyingRespirator_01_F","optic_Holosight_khk_F","H_Construction_earprot_vrana_F","V_PlateCarrierH_CTRG","G_RegulatorMask_F","V_Press_F","H_Beret_CSAT_01_F","H_HelmetHBK_ear_F","V_CarrierRigKBT_01_light_EAF_F","V_CarrierRigKBT_01_heavy_EAF_F","U_B_FullGhillie_lsh","H_ParadeDressCap_01_LDF_F","H_HelmetHBK_chops_F","H_ParadeDressCap_01_US_F","H_HelmetB_light_sand","G_Lowprofile","G_Sport_Red","H_HelmetIA_camo","H_HelmetHBK_F","G_Squares","ChemicalDetector_01_watch_F","U_C_Scientist","V_PlateCarrier2_rgr_noflag_F","H_Cap_grn_Syndikat_F","H_Bandanna_khk","H_HelmetIA_net","H_ParadeDressCap_01_AAF_F","G_B_Diving","U_I_E_ParadeUniform_01_LDF_decorated_F","U_B_PilotCoveralls","H_PilotHelmetFighter_B","U_C_FormalSuit_01_tshirt_gray_F","H_CrewHelmetHeli_I","V_PlateCarrier1_blk","H_Cap_oli_hs","H_Watchcap_blk","H_Watchcap_khk","H_Booniehat_khk_hs","H_Booniehat_oli","H_Beret_grn","H_Cap_blk_CMMG","H_Cap_blk_Raven","H_PilotHelmetHeli_I","H_HelmetCrew_O","H_HelmetCrew_I","V_Rangemaster_belt","H_Bandanna_blu","H_Bandanna_cbr","optic_Arco_blk_F","H_Bandanna_surfer_grn","U_B_CTRG_1","U_B_T_Soldier_AR_F","U_I_HeliPilotCoveralls","U_B_T_FullGhillie_tna_F","H_HelmetCrew_B","H_HeadBandage_bloody_F","U_B_CombatUniform_mcam_vest","U_BG_Guerilla1_1","U_B_T_Soldier_SL_F","U_O_T_Soldier_F","U_BG_Guerrilla_6_1","U_C_Journalist","U_B_CombatUniform_mcam_wdl_f","U_I_CombatUniform","U_BG_Guerilla3_1","U_C_Poloshirt_stripped","U_Rangemaster","U_OrestesBody","V_TacVest_camo","U_B_T_Sniper_F","U_BG_Guerilla2_1","U_B_HeliPilotCoveralls","U_B_GhillieSuit","U_BG_Guerilla2_3","U_BG_leader","U_C_Poor_2","U_NikosBody","U_C_Poloshirt_burgundy","U_C_Poloshirt_salmon","G_Spectacles_Tinted","H_Cap_brn_SPECOPS","H_Watchcap_cbr","H_Cap_tan_specops_US","H_ShemagOpen_tan","H_ShemagOpen_khk","H_Bandanna_gry","H_Booniehat_tan","H_Hat_brown","H_Cap_blk_Syndikat_F","H_Cap_grn_BI","H_StrawHat_dark","U_B_CombatUniform_mcam_tshirt","H_Beret_blk","U_B_ParadeUniform_01_US_decorated_F","U_I_ParadeUniform_01_AAF_F","G_AirPurifyingRespirator_02_olive_F","U_BG_Guerilla2_2","H_Cap_blk_ION","H_Bandanna_camo","H_Bandanna_surfer_blk","H_Booniehat_khk","H_Booniehat_dgtl","H_Hat_camo","H_Bandanna_khk_hs","H_Shemag_olive_hs","H_PilotHelmetHeli_B","U_C_Poloshirt_tricolour","V_HarnessO_brn","G_AirPurifyingRespirator_02_black_F","U_B_CombatUniform_tshirt_mcam_wdL_f","U_B_CombatUniform_vest_mcam_wdl_f","U_C_Poloshirt_redwhite","H_Hat_checker","G_Goggles_VR","V_CarrierRigKBT_01_EAF_F","U_I_C_Soldier_Para_3_F","V_CarrierRigKBT_01_light_Olive_F","H_PASGT_basic_black_F","U_I_C_Soldier_Bandit_2_F","U_C_man_sport_3_F","U_I_C_Soldier_Para_4_F","U_B_GEN_Soldier_F","U_C_IDAP_Man_TeeShorts_F","U_C_IDAP_Man_Tee_F","U_C_IDAP_Man_Jeans_F","U_C_IDAP_Man_casual_F","U_C_IDAP_Man_cargo_F","U_C_IDAP_Man_shorts_F","B_UavTerminal","CUP_acc_LLM","CUP_optic_Elcan_reflex","CUP_V_B_BAF_MTP_Osprey_Mk4_Grenadier","CUP_H_BAF_MTP_Mk6_EMPTY_PRR","CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing","CUP_G_Shades_Black","CUP_V_B_BAF_MTP_Osprey_Mk4_Belt","CUP_NVG_PVS7_Hide","CUP_H_CZ_Helmet04","CUP_V_CZ_NPP2006_vz95","CUP_V_CZ_NPP2006_ok_vz95","CUP_H_BAF_MTP_Mk6_GOGGLES_PRR","CUP_NVG_HMNVS","CUP_acc_ANPEQ_2_camo","CUP_optic_CompM2_low_OD","CUP_acc_Flashlight_MP5","rhs_googles_yellow","H_HelmetB_plain_mcamo","CUP_H_BAF_DDPM_Mk6_EMPTY","CUP_V_B_BAF_DDPM_Osprey_Mk3_Rifleman","CUP_H_BAF_DDPM_Mk6_GLASS_PRR","rhs_acc_dtk1983","rhs_6b23_ML_6sh92_vog","rhsusf_acc_anpeq15_wmx_light","rhsusf_acc_kac_grip","rhsusf_acc_anpeq15A","rhs_acc_ekp1","rhsusf_acc_wmx_bk","rhsusf_acc_RX01_tan","rhsusf_acc_anpvs27","rhsusf_acc_anpeq15side_bk","rhsusf_acc_anpeq15","rhs_6b13_Flora_6sh92_headset_mapcase","rhs_uniform_cu_ocp_101st","CUP_bipod_Harris_1A2_L","CUP_G_Shades_Blue","CUP_acc_Glock17_Flashlight","CUP_optic_AIMM_ZDDOT_BLK","CUP_NVG_PVS15_Hide","CUP_G_ESS_BLK_Scarf_White","CUP_H_CZ_Hat02","CUP_V_CZ_NPP2006_co_vz95","CUP_PMC_Facewrap_Tan","CUP_H_Ger_M92_Cover_Trop_GG","CUP_V_B_GER_PVest_Trop_RFL_LT","CUP_NVG_PVS7","CUP_PMC_Facewrap_Black","CUP_H_Ger_M92_Cover_Trop_GG_CF","CUP_H_BAF_DDPM_Mk6_GOGGLES_PRR","CUP_H_BAF_DDPM_Mk6_NETTING_PRR","CUP_V_B_BAF_DDPM_Osprey_Mk3_AutomaticRifleman","CUP_G_ESS_KHK_Scarf_Face_Tan","CUP_H_CZ_Cap_Headphones_des","CUP_G_White_Scarf_GPS","CUP_H_PMC_Cap_Back_EP_Tan","CUP_V_CPC_Fastbelt_coy","CUP_H_OpsCore_Spray_US_SF","CUP_V_JPC_Fastbelt_coy","CUP_G_WatchGPSCombo","CUP_H_USA_Cap_MARSOC_DEF","CUP_G_Oakleys_Clr","CUP_H_USA_Cap_M81","CUP_muzzle_snds_mk23","CUP_acc_mk23_lam_l","CUP_G_Grn_Scarf_GPS","H_Booniehat_mgrn","CUP_V_CPC_weaponsbelt_coy","CUP_V_CPC_medicalbelt_coy","CUP_optic_LeupoldMk4_25x50_LRT","CUP_acc_ANPEQ_15_Top_Flashlight_Black_L","CUP_optic_Elcan_SpecterDR_RMR_black","CUP_acc_ANPEQ_15_Black","CUP_optic_ACOG2","CUP_muzzle_snds_M110_black","CUP_bipod_VLTOR_Modpod_black","CUP_H_CZ_Cap_khk","CUP_FR_NeckScarf","CUP_H_CZ_Helmet08","CUP_V_CZ_NPP2006_ok_black","CUP_G_ESS_BLK_Scarf_Face_Grn","CUP_H_CZ_Cap_Headphones","CUP_optic_CompM2_low","CUP_H_BAF_DPM_Mk6_NETTING_PRR","CUP_H_BAF_MTP_Mk7_PRR","CUP_V_B_BAF_MTP_Osprey_Mk4_Engineer","CUP_H_BAF_MTP_Mk6_EMPTY","CUP_H_CZ_Helmet02","CUP_V_CZ_NPP2006_des","CUP_G_ESS_RGR","CUP_H_CZ_Booniehat_fold_des","CUP_V_CZ_vest12","H_Cap_tan_Syndikat_F","CUP_H_BAF_DPM_Mk6_GOGGLES_PRR","CUP_V_B_BAF_DPM_Osprey_Mk3_Engineer","CUP_V_B_BAF_DPM_Osprey_Mk3_Rifleman","CUP_H_PMC_PRR_Headset","CUP_H_BAF_DPM_Mk6_EMPTY_PRR","CUP_V_B_BAF_DPM_Osprey_Mk3_Officer","CUP_V_B_BAF_MTP_Osprey_Mk4_Rifleman","CUP_H_BAF_MTP_Mk7","CUP_NVG_PVS15_black","CUP_G_ESS_BLK_Facewrap_Black","CUP_H_OpsCore_Covered_Fleck_SF","CUP_V_B_GER_Armatus_BB_Fleck","CUP_H_Ger_Cap_EP_Grn2","CUP_V_B_GER_Carrier_Vest_2","CUP_H_BAF_MTP_Mk6_NETTING_PRR","CUP_H_Ger_Boonie_Flecktarn","CUP_V_B_GER_Carrier_Vest","CUP_G_PMC_Facewrap_Tropical_Glasses_Dark","CUP_H_Ger_Cap_EP_Tan1","CUP_V_B_GER_Tactical_Fleck","CUP_G_PMC_Facewrap_Tan_Glasses_Dark","CUP_G_Oakleys_Drk","CUP_G_PMC_Facewrap_Black_Glasses_Dark","CUP_H_Ger_M92_Cover_GG","CUP_V_B_GER_PVest_Fleck_RFL_LT","CUP_V_CPC_tlbelt_coy","CUP_H_USA_Cap_Mcam_DEF","rhs_acc_6p9_suppressor","CUP_acc_LLM01_hex_L","CUP_optic_HensoldtZO_low_RDS_hex","rhs_6b23_rifleman","CUP_H_BAF_PARA_PRROVER_BERET","CUP_H_BAF_MTP_Mk6_GLASS_PRR","CUP_V_B_BAF_MTP_Osprey_Mk4_Officer","rhs_6b13_EMR_6sh92_headset_mapcase","rhs_acc_dtk","rhs_acc_pgs64","rhsusf_opscore_fg_pelt","rhsusf_acc_su230_c","rhsusf_acc_rvg_de","CUP_H_LWHv2_MARPAT_cov_fr","CUP_V_B_Eagle_SPC_Patrol","rhsusf_acc_tdstubby_blk","rhs_googles_orange","rhs_optic_maaws","CUP_acc_LLM01_desert_L","CUP_optic_HensoldtZO_low_RDS_desert","H_HelmetB_camo","CUP_G_PMC_Facewrap_Black_Glasses_Ember","CUP_H_Ger_Cap_Tan2","CUP_optic_G36DualOptics_desert","rhsusf_plateframe_teamleader","rhsusf_acc_EOTECH","rhsusf_acc_grip2_wd","rhsusf_acc_anpeq15_bk_light","acc_flashlight_pistol","rhsusf_acc_anpeq15_bk_top","CUP_H_Ger_Cap_EP_Tan2","murshun_cigs_cig0","rhs_radio_R187P1","rhs_6b47_emr_2","rhs_6b45_off","rhs_1PN138","rhs_6b45_rifleman","rhs_acc_dtkakm","rhs_acc_pso1m2","rhs_acc_dtk3","rhs_acc_1p87","rhs_balaclava","rhs_6sh117_rifleman","immersion_pops_pop0","rhs_6b47_emr_1","immersion_cigs_cigar0","rhs_facewear_6m2_1","rhs_6b47_6B50","rhs_6sh117_svd","rhs_6b28","rhs_6b23_digi_medic","rhs_beret_vdv1","rhs_vest_commander","rhs_6sh92_digi","H_Bandanna_sgg","rhs_acc_ekp8_18","rhs_acc_perst3","rhs_acc_perst3_2dp_h","rhs_acc_perst3_2dp_light_h","rhs_acc_uuk","rhs_acc_rakursPM","rhs_acc_perst1ik_ris","rhs_acc_pkas","U_B_CBRN_Suit_01_MTP_F","rhs_acc_perst3_top","optic_DMS_ghex_F","rhs_6b45_mg","rhs_6b45_rifleman_2","U_B_CBRN_Suit_01_Tropic_F","G_AirPurifyingRespirator_02_sand_F","U_C_CBRN_Suit_01_White_F","U_I_CBRN_Suit_01_AAF_F","U_I_E_CBRN_Suit_01_EAF_F","U_C_CBRN_Suit_01_Blue_F","rhs_acc_1p63","rhs_acc_pgo7v","rhs_acc_nita","rhs_acc_dtkrpk","rhs_acc_2dpZenit_ris","rhs_acc_okp7_dovetail","H_Beret_EAF_01_F"     ,"rhs_6b45_grn","U_B_Wetsuit","rhs_acc_pso1m21","V_Pocketed_coyote_F","H_Cap_oli_Syndikat_F","rhs_acc_1p78","rhs_scarf","rhs_acc_perst1ik","rhs_acc_grip_rk2","rhs_acc_okp7_picatinny","rhs_acc_2dpZenit","rhs_acc_1p29","rhs_acc_ekp8_02","rhs_acc_1pn93_2","rhs_acc_harris_swivel","rhs_acc_dh520x56","rhs_acc_pgo7v3","H_Beret_02","optic_Holosight_blk_F","rhs_acc_pgo7v2","rhs_6b28_green_ess","rhs_6b23_digi_6sh92","rhs_6b28_bala","rhs_6b23_digi_6sh92_vog","rhs_6b23_digi_rifleman","rhs_acc_pgs64_74u","rhs_fieldcap","rhs_vest_pistol_holster","rhs_acc_1pn93_1","H_Beret_red","rhs_acc_dtk4short","rhs_acc_grip_rk6","rhs_acc_grip_ffg2","H_Hat_grey","H_Bandanna_sand","H_TurbanO_blk","rhs_6b23","rhs_6b27m_ess","rhs_6b27m_ml","rhs_6sh92","rhs_6b23_medic","rhs_6b27m_ml_ess","rhs_6b27m_ML_ess_bala","CUP_optic_ACOG_TA01NSN_Black_PIP","rhsusf_acc_anpeq15_top","rhsusf_acc_compm4","H_Tank_eaf_F","rhsusf_iotv_ocp_Teamleader","rhsusf_ANPVS_14","rhsusf_patrolcap_ocp","rhsusf_ach_bare_semi_ess","rhs_acc_1pn34","rhsusf_acc_grip3","CUP_H_Ger_Boonie_desert","rhs_acc_pbs1","rhsusf_acc_anpeq16a_top","rhsusf_acc_ACOG_USMC","rhsusf_acc_ACOG2_USMC","rhsusf_ach_helmet_ucp""rhsusf_ach_helmet_headset_ess_ucp","CUP_U_B_CZ_WDL_Kneepads","CUP_U_B_CZ_WDL_Kneepads_Gloves","rhs_uniform_acu_ucp","CUP_H_Beret_HIL","CUP_H_USA_Cap_PUNISHER_DEF","rhsusf_iotv_ucp_Rifleman","rhsusf_iotv_ucp_SAW","CUP_H_CZ_Helmet09","rhsusf_patrolcap_ucp","rhsusf_acc_anpeq16a","immersion_cigs_cigar1","rhs_uniform_vdv_emr_des","rhsusf_acc_LEUPOLDMK4_2","rhsusf_acc_SR25S","rhsusf_acc_premier","rhsusf_acc_harris_bipod","rhsusf_acc_saw_bipod","rhsusf_ach_helmet_ocp","rhsusf_iotv_ocp_Rifleman","rhs_googles_clear","rhsusf_lwh_helmet_marpatwd_ess","rhsusf_spc_light","immersion_cigs_cigar2","U_B_ParadeUniform_01_US_F","murshun_cigs_cig0_nv","CUP_muzzle_snds_M16_coyote","CUP_acc_LLM01_coyote_F","CUP_optic_G33_HWS_TAN","CUP_V_B_GER_Armatus_Trop","CUP_G_PMC_Facewrap_Tan_Glasses_Ember","CUP_bipod_Harris_1A2_L_BLK","CUP_optic_ACOG_TA648_308_RDS_Desert_PIP","rhsusf_acc_m24_muzzlehider_d","rhsusf_acc_LEUPOLDMK4_d","rhsusf_acc_harris_swivel","rhsusf_acc_anpeq15side","rhsusf_acc_ACOG","rhsusf_ach_helmet_headset_ess_ocp","rhsusf_iotv_ocp_Grenadier","rhsusf_ach_helmet_ESS_ocp","rhsusf_ach_helmet_ucp","rhsusf_ach_helmet_headset_ess_ucp","rhsusf_acc_ACOG_MDO","rhs_weap_optic_smaw","rhsusf_lwh_helmet_marpatd","immersion_cigs_cigar3","CUP_G_Oakleys_Embr","CUP_H_USA_Cap_UT_DEF","CUP_V_CPC_communicationsbelt_coy","CUP_H_Ger_M92_Cover_Trop_GG_CB","CUP_V_B_GER_PVest_Trop_MG_LT","CUP_H_CZ_Helmet10","CUP_V_CZ_vest10","CUP_V_B_GER_PVest_Fleck_RFL","CUP_G_PMC_Facewrap_Tropical_Glasses_Ember","CUP_H_BAF_MTP_Mk7_PRR_SCRIM_A","CUP_V_B_GER_PVest_Trop_Med_LT","CUP_H_BAF_DPM_Mk6_GLASS_PRR","CUP_V_B_BAF_DPM_Osprey_Mk3_AutomaticRifleman","CUP_V_B_BAF_DDPM_Osprey_Mk3_Engineer","CUP_H_Ger_Cap_EP_Grn1","CUP_V_CZ_NPP2006_co_des","CUP_V_B_GER_PVest_Trop_Gren","CUP_H_Ger_M92_Cover_GG_CB","CUP_H_OpsCore_Covered_Tropen_SF","CUP_H_Ger_M92_Cover_Trop","CUP_V_B_GER_PVest_Trop_RFL","rhsusf_acc_aac_762sdn6_silencer","rhsusf_acc_eotech_xps3","CUP_U_B_BAF_MTP_UBACSSEAL","rhsusf_acc_ACOG2","CUP_acc_LLM01_od_F","CUP_optic_G33_HWS_OD","rhsusf_acc_M8541_low_wd","rhsusf_acc_M8541_mrds","rhsusf_acc_nt4_black","rhsusf_acc_ELCAN","CUP_optic_Elcan_reflex_pip","rhsusf_acc_su230"];
BRPVP_ItemsClassToNumberTableD = ["B_AssaultPack_dgtl","B_AssaultPack_rgr","B_Bergen_dgtl_F","B_Bergen_hex_F","B_Bergen_mcamo_F","B_Bergen_tna_F","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_oli","B_Carryall_oucamo","B_OutdoorPack_blk","B_OutdoorPack_tan","B_Parachute","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_ViperHarness_blk_F","B_ViperHarness_ghex_F","B_ViperHarness_oli_F","B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F","C_Bergen_blu","C_Bergen_red","G_FieldPack_LAT","B_Kitbag_rgr","B_Kitbag_rgr_AAR","B_Carryall_cbr","B_AssaultPack_sgg","B_AssaultPack_tna_F","B_AssaultPack_blk","B_Carryall_mcamo_AAA","B_AssaultPack_khk","B_Carryall_ocamo","B_ViperLightHarness_ghex_F","B_ViperLightHarness_blk_F","B_ViperHarness_khk_F","B_ViperHarness_hex_F","B_Kitbag_rgr_BTAA_F","C_Bergen_grn","G_FieldPack_Medic","B_AssaultPack_rgr_BTReconMedic","B_Carryall_oli_BTAmmo_F","B_AssaultPack_rgr_ReconMedic","B_AssaultPack_rgr_BTLAT_F","B_Kitbag_rgr_BTAT_F","B_Carryall_wdl_BWAAA_F","B_CombinationUnitRespirator_01_F","B_RadioBag_01_eaf_F","B_OutdoorPack_blu","B_AssaultPack_mcamo_AT","B_AssaultPack_rgr_LAT","B_AssaultPack_rgr_Medic","B_AssaultPack_rgr_ReconExp","I_HMG_01_weapon_F","B_Carryall_mcamo_AAT","B_AssaultPack_mcamo_AA","B_AssaultPack_wdl_BWLAT_F","B_AssaultPack_rgr_ReconLAT","B_Kitbag_rgr_Para_3_F","B_Messenger_Black_F","G_TacticalPack_Eng","B_Carryall_oli_BTAAT_F","CUP_B_ACRPara_m95_Ammo","CUP_B_ACRScout_m95_RPG","CUP_B_Backpack_SpecOps_Fleck","B_GMG_01_weapon_F","I_Fieldpack_oli_LAT2","B_Carryall_oli_BTAAA_F","rhs_medic_bag","I_Fieldpack_oli_Medic","CUP_B_GER_Backpack_AT_Fleck","CUP_B_ACRPara_m95_Explosives","CUP_B_ACRScout_m95_CZ805B","CUP_B_GER_Backpack_AAAssist","CUP_B_GER_Backpack_AT","CUP_B_GER_Backpack_PZF","B_AssaultPack_mcamo_Ammo","CUP_B_USMC_AssaultPack_Medic","CUP_B_Mk19_Tripod_Bag","CUP_B_RPG_Backpack","CUP_B_Predator_RLAT_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_GER_Backpack_Operator_Fleck","CUP_B_GER_Backpack_ATAssist_Fleck","CUP_B_Backpack_SpecOps","RHS_M2_Tripod_Bag","rhs_M252_Bipod_Bag","CUP_B_Predator_Ammo_MTP","RHS_Kord_Tripod_Bag","CUP_B_FR_MOLLE_MG","RHS_M2_Gun_Bag","CUP_B_GER_Backpack_GL","rhs_rk_sht_30_emr_ammo_recon","rhs_rk_sht_30_emr_medic","B_SCBA_01_F","I_Fieldpack_oli_LAT","B_CivilianBackpack_01_Sport_Blue_F"     ,"B_CivilianBackpack_01_Sport_Red_F","B_CivilianBackpack_01_Sport_Green_F","rhs_rk_sht_30_emr_mg","B_Assault_Diver","B_Carryall_eaf_IEAAA_F","B_RadioBag_01_black_F","B_Carryall_eaf_F","I_Carryall_oli_AAA","rhs_rpg_at","B_Kitbag_rgr_BWAAR","B_Fieldpack_green_IEAT_F","I_Fieldpack_oli_AA","I_Carryall_oli_AAT","I_Fieldpack_oli_Ammo","rhs_assault_umbts_medic","rhs_rpg","B_Messenger_Coyote_F","rhsusf_assault_eagleaiii_ucp_ar","rhsusf_assault_eagleaiii_ucp_maaws","rhsusf_assault_eagleaiii_coy_assaultman","CUP_B_GER_Backpack_Engineer","CUP_B_GER_Backpack_Medic","CUP_B_ACRPara_m95_Engineer","rhsusf_falconii_gr","CUP_B_ACRScout_m95_M4","CUP_B_GER_Backpack_MG3","CUP_B_ACRPara_m95_M60","G_FieldPack_LAT2","CUP_B_M252_Bipod_Bag","CUP_B_GER_Backpack_GL_Fleck","G_Carryall_Ammo","CUP_B_GER_Backpack_Operator"];
BRPVP_ItemsClassToNumberTableE = ["B_AssaultPack_dgtl","B_AssaultPack_rgr","B_Bergen_dgtl_F","B_Bergen_hex_F","B_Bergen_mcamo_F","B_Bergen_tna_F","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_oli","B_Carryall_oucamo","B_OutdoorPack_blk","B_OutdoorPack_tan","B_Parachute","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_ViperHarness_blk_F","B_ViperHarness_ghex_F","B_ViperHarness_oli_F","B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F","C_Bergen_blu","C_Bergen_red","G_FieldPack_LAT","B_Kitbag_rgr","B_Kitbag_rgr_AAR","B_Carryall_cbr","B_AssaultPack_sgg","B_AssaultPack_tna_F","B_AssaultPack_blk","B_Carryall_mcamo_AAA","B_AssaultPack_khk","B_Carryall_ocamo","B_ViperLightHarness_ghex_F","B_ViperLightHarness_blk_F","B_ViperHarness_khk_F","B_ViperHarness_hex_F","B_Kitbag_rgr_BTAA_F","C_Bergen_grn","G_FieldPack_Medic","B_AssaultPack_rgr_BTReconMedic","B_Carryall_oli_BTAmmo_F","B_AssaultPack_rgr_ReconMedic","B_AssaultPack_rgr_BTLAT_F","B_Kitbag_rgr_BTAT_F","B_Carryall_wdl_BWAAA_F","B_CombinationUnitRespirator_01_F","B_RadioBag_01_eaf_F","B_OutdoorPack_blu","B_AssaultPack_mcamo_AT","B_AssaultPack_rgr_LAT","B_AssaultPack_rgr_Medic","B_AssaultPack_rgr_ReconExp","I_HMG_01_weapon_F","B_Carryall_mcamo_AAT","B_AssaultPack_mcamo_AA","B_AssaultPack_wdl_BWLAT_F","B_AssaultPack_rgr_ReconLAT","B_Kitbag_rgr_Para_3_F","B_Messenger_Black_F","G_TacticalPack_Eng","U_O_CombatUniform_ocamo","U_O_CombatUniform_oucamo","U_O_FullGhillie_ard","U_O_FullGhillie_lsh","U_O_FullGhillie_sard","U_O_GhillieSuit","U_O_OfficerUniform_ocamo","U_O_PilotCoveralls","U_O_Protagonist_VR","U_O_SpecopsUniform_blk","U_O_SpecopsUniform_ocamo","U_O_T_FullGhillie_tna_F","U_O_T_Sniper_F","U_O_V_Soldier_Viper_F","U_O_V_Soldier_Viper_hex_F","U_O_Wetsuit","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_khk","V_BandollierB_oli","V_BandollierB_rgr","V_Chestrig_blk","V_PlateCarrier_Kerry","V_PlateCarrier1_tna_F","V_PlateCarrier2_rgr","V_PlateCarrierGL_rgr","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl","V_PlateCarrierSpec_rgr","V_TacVest_blk","V_Chestrig_oli","V_Chestrig_rgr","V_Chestrig_khk","U_C_Man_casual_2_F","U_C_Man_casual_3_F","V_PlateCarrierGL_tna_F","V_RebreatherB","U_B_CTRG_Soldier_F","V_PlateCarrierSpec_tna_F","U_I_Wetsuit","V_RebreatherIA","V_RebreatherIR","U_C_Man_casual_6_F","U_C_Man_casual_5_F","V_TacVest_oli","V_TacVest_khk","U_I_C_Soldier_Para_2_F","U_C_man_sport_1_F","V_TacVest_gen_F","V_PlateCarrier2_tna_F","U_C_man_sport_2_F","V_EOD_blue_F","V_EOD_coyote_F","V_EOD_olive_F","U_O_T_Officer_F","V_PlateCarrier1_rgr","U_O_R_Gorka_01_black_F","V_TacVest_blk_POLICE","V_CarrierRigKBT_01_Olive_F","U_B_T_Soldier_F","U_O_R_Gorka_01_brown_F","U_I_G_resistanceLeader_F","U_C_Man_casual_1_F","U_C_Man_casual_4_F","V_SmershVest_01_F","U_I_FullGhillie_ard","U_B_GEN_Commander_F","V_PlateCarrier2_blk","V_PlateCarrierSpec_blk","U_B_CBRN_Suit_01_Wdl_F","V_PlateCarrier2_wdl","U_B_CombatUniform_mcam","V_PlateCarrierGL_wdl","V_TacVest_brn","V_PlateCarrier1_wdl","V_PlateCarrierIA1_dgtl","V_PlateCarrierSpec_mtp","U_B_FullGhillie_ard","U_I_ParadeUniform_01_AAF_decorated_F","U_B_Protagonist_VR","U_I_E_Uniform_01_shortsleeve_F","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_Press_F","V_CarrierRigKBT_01_light_EAF_F","V_CarrierRigKBT_01_heavy_EAF_F","U_B_FullGhillie_lsh","U_C_Scientist","V_PlateCarrier2_rgr_noflag_F","U_I_E_ParadeUniform_01_LDF_decorated_F","U_B_PilotCoveralls","U_C_FormalSuit_01_tshirt_gray_F","V_PlateCarrier1_blk","V_Rangemaster_belt","U_B_CTRG_1","U_B_T_Soldier_AR_F","U_I_HeliPilotCoveralls","U_B_T_FullGhillie_tna_F","U_B_CombatUniform_mcam_vest","U_BG_Guerilla1_1","U_B_T_Soldier_SL_F","U_O_T_Soldier_F","U_BG_Guerrilla_6_1","U_C_Journalist","U_B_CombatUniform_mcam_wdl_f","U_I_CombatUniform","U_BG_Guerilla3_1","U_C_Poloshirt_stripped","U_Rangemaster","U_OrestesBody","V_TacVest_camo","U_B_T_Sniper_F","U_BG_Guerilla2_1","U_B_HeliPilotCoveralls","U_B_GhillieSuit","U_BG_Guerilla2_3","U_BG_leader","U_C_Poor_2","U_NikosBody","U_C_Poloshirt_burgundy","U_C_Poloshirt_salmon","U_B_CombatUniform_mcam_tshirt","U_B_ParadeUniform_01_US_decorated_F","U_I_ParadeUniform_01_AAF_F","U_BG_Guerilla2_2","U_C_Poloshirt_tricolour","V_HarnessO_brn","U_B_CombatUniform_tshirt_mcam_wdL_f","U_B_CombatUniform_vest_mcam_wdl_f","U_C_Poloshirt_redwhite","V_CarrierRigKBT_01_EAF_F","U_I_C_Soldier_Para_3_F","V_CarrierRigKBT_01_light_Olive_F","U_I_C_Soldier_Bandit_2_F","U_C_man_sport_3_F","U_I_C_Soldier_Para_4_F","U_B_GEN_Soldier_F","U_C_IDAP_Man_TeeShorts_F","U_C_IDAP_Man_Tee_F","U_C_IDAP_Man_Jeans_F","U_C_IDAP_Man_casual_F","U_C_IDAP_Man_cargo_F","U_C_IDAP_Man_shorts_F","B_Carryall_oli_BTAAT_F","CUP_V_B_BAF_DDPM_Osprey_Mk3_AutomaticRifleman","CUP_V_B_BAF_DDPM_Osprey_Mk3_Rifleman","CUP_V_B_BAF_DPM_Osprey_Mk3_Engineer","CUP_V_B_BAF_DPM_Osprey_Mk3_Officer","CUP_V_B_BAF_DPM_Osprey_Mk3_Rifleman","CUP_V_B_BAF_MTP_Osprey_Mk4_Belt","CUP_V_B_BAF_MTP_Osprey_Mk4_Engineer","CUP_V_B_BAF_MTP_Osprey_Mk4_Grenadier","CUP_V_B_BAF_MTP_Osprey_Mk4_Officer","CUP_V_B_BAF_MTP_Osprey_Mk4_Rifleman","CUP_V_B_BAF_MTP_Osprey_Mk4_Webbing","CUP_V_B_Eagle_SPC_Patrol","CUP_V_B_GER_Armatus_BB_Fleck","CUP_V_B_GER_Carrier_Vest","CUP_V_B_GER_Carrier_Vest_2","CUP_V_B_GER_PVest_Fleck_RFL_LT","CUP_V_B_GER_PVest_Trop_RFL_LT","CUP_V_B_GER_Tactical_Fleck","CUP_V_CPC_Fastbelt_coy","CUP_V_CPC_medicalbelt_coy","CUP_V_CPC_tlbelt_coy","CUP_V_CPC_weaponsbelt_coy","CUP_V_CZ_NPP2006_co_vz95","CUP_V_CZ_NPP2006_des","CUP_V_CZ_NPP2006_ok_black","CUP_V_CZ_NPP2006_ok_vz95","CUP_V_CZ_NPP2006_vz95","CUP_V_CZ_vest12","CUP_V_JPC_Fastbelt_coy","rhs_uniform_cu_ocp_101st","rhsusf_plateframe_teamleader","CUP_B_ACRPara_m95_Ammo","CUP_B_ACRScout_m95_RPG","CUP_B_Backpack_SpecOps_Fleck","B_GMG_01_weapon_F","I_Fieldpack_oli_LAT2","B_Carryall_oli_BTAAA_F","rhs_medic_bag","I_Fieldpack_oli_Medic","CUP_B_GER_Backpack_AT_Fleck","CUP_B_ACRPara_m95_Explosives","CUP_B_ACRScout_m95_CZ805B","CUP_B_GER_Backpack_AAAssist","CUP_B_GER_Backpack_AT","CUP_B_GER_Backpack_PZF","B_AssaultPack_mcamo_Ammo","CUP_B_USMC_AssaultPack_Medic","CUP_B_Mk19_Tripod_Bag","CUP_B_RPG_Backpack","CUP_B_Predator_RLAT_MTP","CUP_B_Motherlode_Radio_MTP","CUP_B_GER_Backpack_Operator_Fleck","CUP_B_GER_Backpack_ATAssist_Fleck","CUP_B_Backpack_SpecOps","RHS_M2_Tripod_Bag","rhs_M252_Bipod_Bag","CUP_B_Predator_Ammo_MTP","RHS_Kord_Tripod_Bag","CUP_B_FR_MOLLE_MG","RHS_M2_Gun_Bag","CUP_B_GER_Backpack_GL","rhs_rk_sht_30_emr_ammo_recon","rhs_rk_sht_30_emr_medic","B_SCBA_01_F","I_Fieldpack_oli_LAT","B_CivilianBackpack_01_Sport_Blue_F","rhs_vest_commander","U_B_CBRN_Suit_01_MTP_F","U_B_CBRN_Suit_01_Tropic_F","U_C_CBRN_Suit_01_White_F","U_I_CBRN_Suit_01_AAF_F","U_I_E_CBRN_Suit_01_EAF_F","U_C_CBRN_Suit_01_Blue_F"     ,"U_B_Wetsuit","V_Pocketed_coyote_F","rhs_vest_pistol_holster","B_CivilianBackpack_01_Sport_Red_F","B_CivilianBackpack_01_Sport_Green_F","rhs_rk_sht_30_emr_mg","B_Assault_Diver","B_Carryall_eaf_IEAAA_F","B_RadioBag_01_black_F","B_Carryall_eaf_F","I_Carryall_oli_AAA","rhs_rpg_at","B_Kitbag_rgr_BWAAR","B_Fieldpack_green_IEAT_F","I_Fieldpack_oli_AA","I_Carryall_oli_AAT","I_Fieldpack_oli_Ammo","rhs_assault_umbts_medic","rhs_rpg","B_Messenger_Coyote_F","rhs_uniform_acu_ucp","rhs_uniform_vdv_emr_des","U_B_ParadeUniform_01_US_F","rhsusf_falconii_gr","CUP_B_ACRScout_m95_M4","CUP_B_GER_Backpack_MG3","CUP_B_ACRPara_m95_M60","G_FieldPack_LAT2","CUP_B_M252_Bipod_Bag","CUP_B_GER_Backpack_GL_Fleck","G_Carryall_Ammo","CUP_B_GER_Backpack_Operator","CUP_V_CPC_communicationsbelt_coy","CUP_V_B_GER_PVest_Trop_MG_LT","CUP_V_CZ_vest10","CUP_V_B_GER_PVest_Fleck_RFL","CUP_V_B_GER_PVest_Trop_Med_LT","CUP_V_B_BAF_DPM_Osprey_Mk3_AutomaticRifleman","CUP_V_B_BAF_DDPM_Osprey_Mk3_Engineer","CUP_V_CZ_NPP2006_co_des","CUP_V_B_GER_PVest_Trop_Gren","CUP_V_B_GER_PVest_Trop_RFL"];

//==========================================================
//DON'T CHANGE THOSE ARRAYS, YOU CAN MESS YOUR DATABASE: END
//==========================================================
//==========================================================

BRP_kitSmallLights = ["Land_Flush_Light_green_F","Land_Flush_Light_red_F","Land_Flush_Light_yellow_F","Land_runway_edgelight","Land_runway_edgelight_blue_F","Land_PortableHelipadLight_01_F","PortableHelipadLight_01_blue_F","PortableHelipadLight_01_red_F","PortableHelipadLight_01_white_F","PortableHelipadLight_01_green_F","PortableHelipadLight_01_yellow_F","Land_Runway_PAPI"];
BRP_kitGates = ["Land_WoodenWall_02_s_gate_F","Land_WiredFence_01_gate_F","Land_PipeFence_01_m_gate_v2_closed_F","Land_PipeFence_01_m_gate_v1_F","Land_BackAlley_01_l_gate_F","Land_NetFence_02_m_gate_v1_closed_F","Land_Net_Fence_Gate_F","Land_City_Gate_F","Land_Stone_Gate_F","Land_ConcreteWall_01_m_gate_F","Land_ConcreteWall_01_l_gate_F","Land_BarGate_F","Land_RoadBarrier_01_F"];
BRP_kitLight = ["Land_Razorwire_F","Land_Net_Fence_4m_F","Land_Net_Fence_8m_F","Land_Net_Fence_Pole_F","Land_Pipe_fence_4m_F"];
BRP_kitCamuflagem = ["CamoNet_BLUFOR_big_F","CamoNet_BLUFOR_F","CamoNet_BLUFOR_open_F","CamoNet_OPFOR_big_F","CamoNet_OPFOR_F","CamoNet_OPFOR_open_F","CamoNet_INDP_big_F","CamoNet_INDP_F","CamoNet_INDP_open_F"];
BRP_kitAreia = ["Land_BagFence_Long_F","Land_BagFence_Short_F","Land_HBarrier_1_F","Land_HBarrier_3_F","Land_HBarrier_5_F"];
BRP_kitCidade = ["Land_City_4m_F","Land_City2_4m_F","Land_City_8m_F","Land_City_8mD_F","Land_City2_8m_F","Land_City_Pillar_F"];
BRP_kitStone = ["Land_Stone_4m_F","Land_Stone_8m_F","Land_Stone_8mD_F","Land_Stone_Pillar_F"];
BRP_kitCasebres = ["Land_Slum_House01_F","Land_Slum_House02_F","Land_Slum_House03_F","Land_cmp_Shed_F","Land_cargo_house_slum_F","Land_FuelStation_Build_F"];
BRP_kitConcreto = ["Land_CncWall1_F","Land_CncWall4_F","Land_Concrete_SmallWall_4m_F","Land_Concrete_SmallWall_8m_F","Land_Wall_IndCnc_4_F","Land_PipeWall_concretel_8m_F"];
BRP_kitPedras = ["Land_Pier_F","Land_nav_pier_m_F","Land_Pier_Box_F","Land_Mound01_8m_F","Land_Mound02_8m_F","Land_Castle_01_church_a_ruin_F","Land_AirstripPlatform_01_F","Land_PierConcrete_01_16m_F","Land_Breakwater_02_F","Land_QuayConcrete_01_20m_F","Land_QuayConcrete_01_outterCorner_F","Land_Rail_ConcreteRamp_F","Land_AncientPillar_fallen_F"];
BRP_kitTorres = ["Land_GuardTower_01_F","Land_ControlTower_01_F","Land_Cargo_HQ_V1_F","Land_Castle_01_tower_F","Land_Cargo_Tower_V1_F","Land_Cargo_Patrol_V1_F","Land_Airport_01_controlTower_F","Land_Airport_02_controlTower_F","Land_Airport_Tower_F"];
BRP_bandeira = ["bandeira_x_azul","bandeira_x_cinza","bandeira_x_marrom","bandeira_x_verde","bandeira_x_roxa","bandeira_x_vermelha","bandeira_q_azul","bandeira_q_cinza","bandeira_q_marrom","bandeira_q_verde","bandeira_q_roxa","bandeira_q_vermelha"];
BRP_kitEspecial = [BRPVP_superBoxClass,"Land_Billboard_F","Land_WoodenCounter_01_F","Sign_Sphere200cm_F","Land_RaiStone_01_F","Land_GarbageBin_02_F","Land_CashDesk_F","Land_Communication_F"];
BRP_kitAdmin = ["Land_Church_01_V1_F","Land_Offices_01_V1_F","Land_WIP_F","Land_dp_mainFactory_F","Land_i_Barracks_V1_F"];
BRP_kitTableChair = ["Land_WoodenTable_large_F","Land_WoodenTable_small_F","Land_ChairWood_F","Land_Bench_F","Land_Bench_01_F","Land_Bench_02_F","Land_CampingTable_F","Land_CampingTable_small_F","Land_CampingChair_V1_F","Land_CampingChair_V2_F"];
BRP_kitBeach = ["Land_Sunshade_F","Land_Sunshade_01_F","Land_Sunshade_02_F","Land_Sunshade_03_F","Land_Sunshade_04_F","Land_BeachBooth_01_F","Land_LifeguardTower_01_F","Land_TablePlastic_01_F","Land_ChairPlastic_F","Land_Sun_chair_F","Land_Sun_chair_green_F"];
BRP_kitReligious = ["Land_BellTower_01_V1_F","Land_BellTower_02_V1_F","Land_BellTower_02_V2_F","Land_Calvary_01_V1_F","Land_Calvary_02_V1_F","Land_Calvary_02_V2_F","Land_Grave_obelisk_F","Land_Grave_memorial_F","Land_Grave_monument_F"];
BRP_kitStuffo1 = ["Land_Bucket_F","Land_Bucket_clean_F","Land_Bucket_painted_F","Land_BucketNavy_F","Land_Basket_F","Land_cargo_addon02_V1_F","Land_cargo_addon02_V2_F"];
BRP_kitStuffo2 = ["Land_GarbageBin_01_F","RoadCone_F","Land_GarbageBarrel_01_F","Land_WoodenLog_F","TargetP_Inf_F"];
BRP_kitLamp = ["Land_LampStreet_02_triple_F","Land_LampStreet_small_F","Land_LampStreet_F","Land_LampSolar_F","Land_LampDecor_F","Land_LampHalogen_F","Land_LampHarbour_F","Land_LampAirport_F","Land_LampShabby_F"];
BRP_kitContainers = ["Land_Cargo20_red_F","Land_Cargo20_blue_F","Land_Cargo20_light_green_F","Land_Cargo40_red_F","Land_Cargo40_blue_F","Land_Cargo40_light_green_F"];
BRP_kitRecreation = ["Land_PartyTent_01_F","Land_Hedge_01_s_2m_F","Land_Hedge_01_s_4m_F","Land_SlideCastle_F","Land_Carousel_01_F","Land_Swing_01_F","Land_Kiosk_redburger_F","Land_Kiosk_papers_F","Land_Kiosk_gyros_F","Land_Kiosk_blueking_F","Land_TouristShelter_01_F","Land_Slide_F","Land_BC_Basket_F","Land_BC_Court_F","Land_Goal_F","Land_Tribune_F"];
BRP_kitMilitarSign = ["Land_Sign_WarningMilitaryArea_F","Land_Sign_WarningMilAreaSmall_F","Land_Sign_WarningMilitaryVehicles_F","ArrowDesk_L_F","ArrowDesk_R_F","RoadBarrier_F","TapeSign_F"];
BRP_kitFuelStorage = ["C_IDAP_supplyCrate_F","Box_NATO_AmmoVeh_F","Box_East_AmmoVeh_F","Box_IND_AmmoVeh_F","Box_T_East_WpsSpecial_F","C_T_supplyCrate_F","Box_Syndicate_Ammo_F","Box_Syndicate_WpsLaunch_F"];
BRP_kitWrecks = ["Land_HistoricalPlaneWreck_01_F","Land_HistoricalPlaneWreck_03_F","Land_UWreck_MV22_F","Land_Wreck_BMP2_F","Land_Wreck_BRDM2_F","Land_Wreck_Heli_Attack_01_F","Land_Wreck_Heli_Attack_02_F","Land_Wreck_HMMWV_F","Land_Wreck_Hunter_F","Land_Wreck_Skodovka_F","Land_Wreck_Slammer_F","Land_Wreck_Slammer_hull_F","Land_Wreck_Slammer_turret_F","Land_Wreck_T72_hull_F","Land_Scrap_MRAP_01_F","Land_Wreck_Ural_F","Land_Wreck_UAZ_F"];
BRP_kitSmallHouse = ["Land_MetalShelter_01_F","Land_Cargo_House_V1_F","Land_Cargo_House_V3_F","Land_Cargo_House_V2_F","Land_i_Addon_02_V1_F","Land_i_Addon_03_V1_F","Land_i_Addon_03mid_V1_F","Land_i_House_Small_02_V1_F","Land_i_House_Small_02_V2_F","Land_i_House_Small_02_V3_F","Land_GH_House_2_F","Land_i_House_Small_01_V1_F","Land_i_House_Small_01_V2_F","Land_Lighthouse_small_F","Land_i_Windmill01_F","Land_HBarrierTower_F","Land_HBarrierWall_corridor_F","Land_Chapel_Small_V1_F"];
BRP_kitAverageHouse = ["Land_FireEscape_01_short_F","Land_FireEscape_01_tall_F","Land_MetalShelter_02_F","Land_Pier_addon","Land_GH_House_1_F","Land_i_House_Big_01_V1_F","Land_i_House_Big_01_V2_F","Land_i_House_Big_01_V3_F","Land_i_House_Big_02_V1_F","Land_i_House_Big_02_V2_F","Land_i_House_Big_02_V3_F","Land_u_House_Big_01_V1_F","Land_u_House_Big_02_V1_F","Land_i_Shop_01_V1_F","Land_i_Shop_01_V2_F","Land_i_Shop_02_V1_F","Land_i_Shop_02_V2_F","Land_i_Shop_02_V3_F","Land_dp_smallTank_F","Land_Medevac_house_V1_F","Land_GH_MainBuilding_entry_F","Land_Shed_Big_F"];
BRP_kitBigHouse = ["Land_MultistoryBuilding_01_F","Land_ContainerLine_01_F","Land_ContainerLine_02_F","Land_ContainerLine_03_F","Land_FuelStation_01_shop_F","Land_FuelStation_01_workshop_F","Land_Lighthouse_03_red_F","Land_Lighthouse_03_green_F","Land_StorageTank_01_small_F","Land_GarageRow_01_large_F","Land_LightHouse_F","Land_Rail_Bridge_40_F","Land_Dome_Small_F","Land_TentHangar_V1_F","Land_i_Barracks_V1_F","Land_i_Barracks_V2_F","Land_u_Barracks_V2_F","Land_Barracks_01_camo_F","Land_Airport_01_hangar_F","Land_Shop_Town_03_F","Land_Warehouse_03_F","Land_Hospital_main_F","Land_Hospital_side1_F","Land_Hospital_side2_F","Land_GH_MainBuilding_middle_F","Land_GH_MainBuilding_left_F","Land_GH_MainBuilding_right_F","Land_Airport_center_F","Land_Airport_left_F","Land_Airport_right_F","Land_Medevac_HQ_V1_F","Land_i_Shed_Ind_F","Land_Chapel_V1_F","Land_ReservoirTower_F"];
BRP_kitGiantHouse = ["Land_MultistoryBuilding_04_F","Land_MultistoryBuilding_03_F","Land_SCF_01_shed_F","Land_Hangar_F","Land_spp_Tower_F","Land_CementWorks_01_brick_F","Land_Offices_01_V1_F","Land_Airport_02_hangar_left_F","Land_Airport_02_hangar_right_F","Land_WIP_F","Land_Hotel_01_F","Land_Dome_Big_F","Land_MilOffices_V1_F"];
BRP_kitAntennaA = ["Land_TTowerSmall_1_F","Land_TTowerSmall_2_F"];
BRP_kitAntennaB = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];
BRP_kitMovement = ["Land_Canal_Dutch_01_15m_F","Land_Canal_Dutch_01_corner_F","Land_CobblestoneSquare_01_8m_F","Land_GH_Stairs_F","Land_VR_Block_01_F","Land_VR_Block_02_F","Land_VR_Block_03_F","Land_VR_Block_04_F","Land_VR_Block_05_F","Land_VR_Slope_01_F","Land_Pier_small_F","Land_PierLadder_F","Land_Castle_01_step_F","Land_RampConcrete_F","Land_RampConcreteHigh_F","Land_Obstacle_Ramp_F","Land_Obstacle_RunAround_F","Land_Obstacle_Climb_F","Land_Obstacle_Bridge_F","BlockConcrete_F","Land_Razorwire_F","Land_CncShelter_F","Land_Canal_Dutch_01_plate_F"];
BRP_kitRespawnA = ["Land_PhoneBooth_01_F","Land_PhoneBooth_02_F","Land_GarbageContainer_closed_F","Land_FieldToilet_F","Land_WaterBarrel_F","Land_Pallets_stack_F","Land_PaperBox_closed_F"];
BRP_kitRespawnB = ["Land_Laptop_unfolded_F","Land_Ground_sheet_folded_blue_F","Land_Ground_sheet_folded_khaki_F","Land_Ground_sheet_folded_yellow_F","Land_Tyre_F","Land_BarrelEmpty_F","Land_MetalBarrel_empty_F","Land_BarrelEmpty_grey_F","Land_Ketchup_01_F"];
BRP_kitHelipad = ["Land_HelipadCircle_F","Land_HelipadCivil_F","Land_HelipadRescue_F","Land_HelipadSquare_F"];
BRP_kitTrees = ["Land_TreeBin_F","a3\plants_f\Tree\t_BroussonetiaP1s_F.p3d","a3\plants_f\Tree\t_FicusB1s_F.p3d","a3\plants_f\Tree\t_FicusB2s_F.p3d","a3\plants_f\Tree\t_FraxinusAV2s_F.p3d","a3\plants_f\Tree\t_OleaE1s_F.p3d","a3\plants_f\Tree\t_OleaE2s_F.p3d","a3\plants_f\Tree\t_PhoenixC1s_F.p3d","a3\plants_f\Tree\t_PhoenixC3s_F.p3d","a3\plants_f\Tree\t_PinusP3s_F.p3d","a3\plants_f\Tree\t_PinusS1s_F.p3d","a3\plants_f\Tree\t_PinusS2s_b_F.p3d","a3\plants_f\Tree\t_PinusS2s_F.p3d","a3\plants_f\Tree\t_poplar2f_dead_F.p3d","a3\plants_f\Tree\t_PopulusN3s_F.p3d","a3\plants_f\Tree\t_QuercusIR2s_F.p3d","Land_Shovel_F"];
BRP_kitTrees = BRP_kitTrees apply {if (_x find "a3\" isEqualTo 0) then {toLowerANSI _x} else {_x}};
BRP_kitFlags25 = ["Flag_BI_F"];
BRP_kitFlags50 = ["Flag_Green_F"];
BRP_kitFlags100 = ["Flag_Blue_F"];
BRP_kitFlags200 = ["Flag_White_F","Flag_Red_F"];
BRP_kitAutoTurret = BRPVP_autoTurretTypes;
BRP_kitAutoTurretLvl2 = BRPVP_autoTurretTypes;
BRP_kitBunkers = ["Land_Bunker_01_big_F","Land_BagBunker_Small_F","Land_BagBunker_01_large_green_F","Land_BagBunker_Large_F","Land_Bunker_01_HQ_F","Land_Bunker_02_light_double_F","Land_BagBunker_01_small_green_F","Land_PillboxBunker_01_hex_F","Land_Bunker_01_small_F","Land_PillboxBunker_01_big_F","Land_BagBunker_Tower_F","Land_HBarrier_01_tower_green_F","Land_PillboxBunker_01_rectangle_F"];

if (BRPVP_usingBrpvpMod) then {{BRP_kitFuelStorage set [_forEachIndex,_x call BRPVP_noModToModConvertion];} forEach BRP_kitFuelStorage;};

//CREATE CAN DESTROY ARRAY
if (isNil "BRPVP_kitGroupsCanDestroy" && isNil "BRPVP_kitGroupsCanDestroyQtt") then {
	BRPVP_kitGroupsCanDestroy = [];
	BRPVP_kitGroupsCanDestroyQtt = [];
	{
		_x params ["_code","_qtt"];
		private _classes = call _code;
		BRPVP_kitGroupsCanDestroy append _classes;
		{BRPVP_kitGroupsCanDestroyQtt pushBack _qtt;} forEach _classes;
	} forEach BRPVP_kitGroupsCanDestroyCfg;
};

BRPVP_getConsPriceHelpTable = [
	"BRP_kitSmallLights",
	"BRP_kitGates",
	"BRP_kitLight",
	"BRP_kitCamuflagem",
	"BRP_kitAreia",
	"BRP_kitCidade",
	"BRP_kitStone",
	"BRP_kitCasebres",
	"BRP_kitConcreto",
	"BRP_kitPedras",
	"BRP_kitTorres",
	"BRP_bandeira",
	"BRP_kitEspecial",
	"BRP_kitAdmin",
	"BRP_kitTableChair",
	"BRP_kitBeach",
	"BRP_kitReligious",
	"BRP_kitStuffo1",
	"BRP_kitStuffo2",
	"BRP_kitLamp",
	"BRP_kitContainers",
	"BRP_kitRecreation",
	"BRP_kitMilitarSign",
	"BRP_kitFuelStorage",
	"BRP_kitWrecks",
	"BRP_kitSmallHouse",
	"BRP_kitAverageHouse",
	"BRP_kitBigHouse",
	"BRP_kitGiantHouse",
	"BRP_kitAntennaA",
	"BRP_kitAntennaB",
	"BRP_kitMovement",
	"BRP_kitRespawnA",
	"BRP_kitRespawnB",
	"BRP_kitHelipad",
	"BRP_kitTrees",
	"BRP_kitFlags25",
	"BRP_kitFlags50",
	"BRP_kitFlags100",
	"BRP_kitFlags200",
	"BRP_kitAutoTurret",
	"BRP_kitBunkers",
	"BRP_kitAutoTurretLvl2"
];

if (isNil "BRPVP_mercadoItens") then {call compile preprocessFileLineNumbers "tradersItems.sqf";};

//ORDER BY CATEGORY AND PRICE
BRPVP_mercadoItens = BRPVP_mercadoItens apply {[_x select 0,_x select 1, _x select 4,_x]};
BRPVP_mercadoItens sort true;
BRPVP_mercadoItens = BRPVP_mercadoItens apply {_x select 3};

//REMOVE CLASSES THAT DON'T EXISTS
{if !((_x select 3) call BRPVP_classExists) then {BRPVP_mercadoItens set [_forEachIndex,-1];};} forEach BRPVP_mercadoItens;
BRPVP_mercadoItens = BRPVP_mercadoItens-[-1];

BRPVP_getConsPriceHelpTableB = [];
BRPVP_getConsPriceHelpTableC = [];
BRPVP_getConsPriceHelpTableD = [];
{
	private _array = call compile _x;
	BRPVP_getConsPriceHelpTableB append _array;
	BRPVP_getConsPriceHelpTableC append (_array apply {_forEachIndex});
} forEach BRPVP_getConsPriceHelpTable;
{
	private _class = _x;
	private _price = 0;
	{if (_x select 3 isEqualTo _class) exitWith {_price = _x select 4};} forEach BRPVP_mercadoItens;
	BRPVP_getConsPriceHelpTableD pushBack _price;
} forEach BRPVP_getConsPriceHelpTable;

BRPVP_getItemPriceHelpTableA = [];
BRPVP_getItemPriceHelpTableB = [];
{
	BRPVP_getItemPriceHelpTableA pushBack (_x select 3);
	if (count _x isEqualTo 6) then {BRPVP_getItemPriceHelpTableB pushBack ((_x select 4)/(_x select 5));} else {BRPVP_getItemPriceHelpTableB pushBack (_x select 4);};
} forEach BRPVP_mercadoItens;

BRPVP_ultraItems = [
	//LAUNCHERS I
	[
		["launch_Titan_F","launch_O_Titan_F","launch_I_Titan_F","launch_B_Titan_F"],
		["launch_Titan_short_F","launch_O_Titan_short_F","launch_I_Titan_short_F","launch_B_Titan_short_F"],
		//CUP
		"CUP_launch_Igla_Loaded",
		"CUP_launch_Javelin",
		"CUP_launch_M136_Loaded",
		"CUP_launch_M47",
		"CUP_launch_NLAW_Loaded",
		"CUP_launch_FIM92Stinger_Loaded",
		"CUP_launch_9K32Strela_Loaded",
		//RHS
		"rhs_weap_igla"
	],
	//LAUNCHERS II
	[
		["launch_MRAWS_olive_F","launch_MRAWS_olive_rail_F","launch_MRAWS_green_F","launch_MRAWS_green_rail_F","launch_MRAWS_sand_F","launch_MRAWS_sand_rail_F"],
		["launch_RPG32_F","launch_RPG32_ghex_F","launch_RPG32_green_F","launch_RPG32_camo_F"],
		["launch_O_Vorona_brown_F","launch_O_Vorona_green_F"],
		"launch_NLAW_F",
		//CUP
		"CUP_launch_M72A6_Loaded",
		"CUP_launch_MAAWS",
		"CUP_launch_Metis",
		"CUP_launch_RPG18_Loaded",
		"CUP_launch_Mk153Mod0",
		"CUP_launch_RPG7V",
		"CUP_launch_RPG7V_PGO7V",
		//RHS
		"rhs_weap_rpg7",
		"rhs_weap_rpg26",
		"rhs_weap_rshg2",
		"rhs_weap_rpg18"
	],
	//SNIPER RIFLES
	[
		//SNIPER RIFLES
		["srifle_GM6_F","srifle_GM6_camo_F","srifle_GM6_ghex_F"],
		["srifle_LRR_F","srifle_LRR_camo_F","srifle_LRR_tna_F"],
		["srifle_DMR_02_F","srifle_DMR_02_camo_F","srifle_DMR_02_sniper_F"],
		["srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_tan_F","srifle_DMR_03_multicam_F","srifle_DMR_03_woodland_F"],
		["srifle_DMR_04_F","srifle_DMR_04_Tan_F"],
		["srifle_DMR_05_blk_F","srifle_DMR_05_hex_F","srifle_DMR_05_tan_f"],
		["srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_DMR_06_hunter_F"],
		["srifle_DMR_07_blk_F","srifle_DMR_07_hex_F","srifle_DMR_07_ghex_F"],
		["arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_01_GL_snd_F","arifle_SPAR_02_blk_F","arifle_SPAR_02_khk_F","arifle_SPAR_02_snd_F","arifle_SPAR_03_blk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F"],
		"srifle_DMR_01_F",
		"srifle_EBR_F",
		//CUP
		["CUP_srifle_M24_blk","CUP_srifle_M24_ghillie"],
		["CUP_srifle_SVD_top_rail","CUP_srifle_SVD_wdl_ghillie"],
		["CUP_srifle_VSSVintorez_top_rail","CUP_srifle_VSSVintorez_VFG_top_rail"],
		["CUP_srifle_L129A1","CUP_srifle_L129A1_HG"],
		"CUP_srifle_CZ750",
		"CUP_srifle_CZ550",
		"CUP_srifle_LeeEnfield_rail",
		"CUP_srifle_M14_DMR",
		"CUP_srifle_M40A3",
		"CUP_srifle_ksvk",
		"CUP_srifle_AS50",
		"CUP_srifle_AWM_wdl",
		"CUP_srifle_G22_wdl",
		"CUP_srifle_M107_LeupoldVX3",
		"CUP_srifle_M110",
		"CUP_srifle_M14_CCO",
		//RHS
		["rhs_weap_svdp","rhs_weap_svdp_npz","rhs_weap_svdp_wd","rhs_weap_svdp_wd_npz"],
		["rhs_weap_svds","rhs_weap_svds_npz"],
		["rhs_weap_vss","rhs_weap_vss_grip","rhs_weap_vss_grip_npz","rhs_weap_vss_npz"],
		"rhs_weap_t5000"
	],
	//MEDIUM MACHINE GUNS
	[
		["MMG_01_hex_F","MMG_01_tan_F"],
		["MMG_02_camo_F","MMG_02_black_F","MMG_02_sand_F"],
		["arifle_MX_SW_F","arifle_MX_SW_Black_F","arifle_MX_SW_khk_F"],
		["LMG_Mk200_F","LMG_Mk200_black_F","LMG_Mk200_BI_F"],
		"LMG_03_F",
		"LMG_Zafir_F",
		//CUP
		["CUP_lmg_minimipara","CUP_lmg_minimi_railed"],
		["CUP_lmg_m249_para","CUP_lmg_M249","CUP_lmg_m249_para_gl"],
		"CUP_lmg_UK59",
		"CUP_lmg_L110A1",
		"CUP_lmg_M240",
		"CUP_lmg_L7A2",
		"CUP_lmg_FNMAG_RIS",
		"CUP_lmg_M60E4",
		"CUP_lmg_MG3",
		"CUP_lmg_Mk48_wdl_Aim_Laser",
		"CUP_lmg_PKM",
		"CUP_lmg_Pecheneg",
		//RHS
		"rhs_weap_pkm",
		"rhs_weap_rpk74m",
		"rhs_weap_pkp"
	],
	//SUPER NV GOOGLES AND NV GOOGLES HELMETS
	[
		"NVGogglesB_gry_F",
		"O_NVGoggles_urb_F",
		"H_HelmetO_ViperSP_hex_F",
		"H_HelmetO_ViperSP_ghex_F",
		//CUP
		"CUP_SOFLAM"
	],
	//FULL GHILLIES
	[
		"U_O_FullGhillie_ard",
		"U_O_FullGhillie_lsh",
		"U_O_FullGhillie_sard",
		"U_O_T_FullGhillie_tna_F"
	],
	//PROTECTION
	[
		["H_HelmetSpecO_ocamo","H_PASGT_neckprot_blue_press_F","H_HelmetB_Enh_tna_F","H_HelmetSpecB_paint2"],
		["G_Balaclava_TI_G_blk_F","G_Balaclava_TI_G_tna_F"],
		["V_PlateCarrierSpec_blk","V_PlateCarrier2_rgr","V_PlateCarrierGL_rgr","V_PlateCarrierIAGL_dgtl","V_PlateCarrierSpec_rgr"]
	],
	//OTHER RARE ITENS
	[
		["sgun_HunterShotgun_01_F","sgun_HunterShotgun_01_sawedoff_F"],
		["arifle_MSBS65_UBS_sand_F","arifle_MSBS65_UBS_black_F","arifle_MSBS65_UBS_camo_F"],
		["arifle_MSBS65_Mark_black_F","arifle_MSBS65_Mark_sand_F","arifle_MSBS65_Mark_camo_F"],
		["arifle_RPK12_arid_F","arifle_RPK12_lush_F","arifle_RPK12_arid_F"],
		["Laserdesignator","Laserdesignator_02","Laserdesignator_03","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F"],
		["Laserdesignator","Laserdesignator_02","Laserdesignator_03","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F"],
		["Laserdesignator","Laserdesignator_02","Laserdesignator_03","Laserdesignator_01_khk_F","Laserdesignator_02_ghex_F"]
	]
];
BRPVP_rareItemsPlainList = [];
{
	_category = +_x;
	_catIdx = _forEachIndex;
	{
		private _item = _x;
		private _itemIdx = _forEachIndex;
		if (_item isEqualType "") then {
			if !(_item call BRPVP_classExists) then {_category set [_itemIdx,-1];};
		} else {
			{if !(_x call BRPVP_classExists) then {(_category select _itemIdx) set [_forEachIndex,-1];};} forEach _item;
			private _new = (_category select _itemIdx)-[-1];
			if (_new isEqualTo []) then {_category set [_itemIdx,-1];} else {_category set [_itemIdx,_new];};
		};
	} forEach _category;
	_category = _category-[-1];
	BRPVP_ultraItems set [_catIdx,_category];
	BRPVP_rareItemsPlainList append _category;
} forEach BRPVP_ultraItems;

BRPVP_multiPartObjectsClasses = [
	"Land_GH_MainBuilding_left_F",
	"Land_GH_MainBuilding_right_F",
	"Land_Hospital_side1_F",
	"Land_Hospital_side2_F",
	"Land_Airport_left_F",
	"Land_Airport_right_F"
];

BRPVP_crafts = [
	[
		"BRPVP_craft_cement",
		[["BRPVP_farm_limestone",2],["BRPVP_farm_clay",2],["BRPVP_farm_coal",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_brick",
		[["BRPVP_farm_clay",2],["BRPVP_farm_sand",2],["BRPVP_farm_coal",1]],
		"Land_WoodenCounter_01_F"
	],
	/*
	[
		"U_O_FullGhillie_ard",
		[["BRPVP_farm_leaves",10],["BRPVP_craft_rubber",2],["BRPVP_craft_fabric",3],["BRPVP_material_seam_kit",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"U_O_FullGhillie_lsh",
		[["BRPVP_farm_leaves",10],["BRPVP_craft_rubber",2],["BRPVP_craft_fabric",3],["BRPVP_material_seam_kit",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"U_O_FullGhillie_sard",
		[["BRPVP_farm_leaves",10],["BRPVP_craft_rubber",2],["BRPVP_craft_fabric",3],["BRPVP_material_seam_kit",1]],
		"Land_WoodenCounter_01_F"
	],
	*/
	[
		"BRPVP_material_seam_kit",
		[["BRPVP_farm_metal_trash",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_circuits",
		[["BRPVP_farm_eletronic_trash",2],["BRPVP_farm_metal_trash",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_turretUpgrade",
		[["BRPVP_craft_circuits",1],["BRPVP_farm_metal_trash",2],["BRPVP_craft_steel_rebar",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_material_bolt_nail",
		[["BRPVP_farm_metal_trash",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_steel_plate",
		[["BRPVP_farm_iron",3],["BRPVP_farm_coal",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_steel_rebar",
		[["BRPVP_farm_iron",2],["BRPVP_farm_coal",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_wooden_board",
		[["BRPVP_farm_wood",4]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_farm_coal",
		[["BRPVP_farm_wood",3]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_reinforced_concrete",
		[["BRPVP_craft_cement",2],["BRPVP_farm_stone",2],["BRPVP_farm_iron",3],["BRPVP_farm_coal",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_fabric",
		[["BRPVP_farm_cotton",4],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_stone_x10",
		[["BRPVP_farm_stone",10],["BRPVP_farm_coal",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_rubber",
		[["BRPVP_farm_latex",2],["BRPVP_farm_coal",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_wooden_wall",
		[["BRPVP_farm_wood",12],["BRPVP_material_bolt_nail",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_brick_wall",
		[["BRPVP_farm_clay",6],["BRPVP_farm_sand",6],["BRPVP_farm_coal",3],["BRPVP_craft_cement",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_steel_wall",
		[["BRPVP_farm_iron",9],["BRPVP_farm_coal",6]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_foundations",
		[["BRPVP_craft_stone_x10",1],["BRPVP_craft_reinforced_concrete",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_craft_steel_structure",
		[["BRPVP_farm_iron",10],["BRPVP_farm_coal",5]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitConcreto",
		[["BRPVP_craft_reinforced_concrete",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitMovement",
		[["BRPVP_craft_reinforced_concrete",2],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitLight",
		[["BRPVP_craft_steel_rebar",3],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitAreia",
		[["BRPVP_farm_sand",10],["BRPVP_craft_fabric",3]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitCidade",
		[["BRPVP_craft_brick",4]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitStone",
		[["BRPVP_craft_stone_x10",1],["BRPVP_craft_cement",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitPedras",
		[["BRPVP_craft_stone_x10",2],["BRPVP_craft_cement",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitCamuflagem",
		[["BRPVP_craft_fabric",4],["BRPVP_craft_steel_rebar",2],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitHelipad",
		[["BRPVP_craft_stone_x10",1],["BRPVP_craft_cement",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitMilitarSign",
		[["BRPVP_craft_steel_rebar",2],["BRPVP_craft_wooden_board",3]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitTorres",
		[["BRPVP_craft_foundations",1],["BRPVP_craft_steel_structure",1],["BRPVP_craft_steel_plate",2],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitCasebres",
		[["BRPVP_craft_wooden_wall",3],["BRPVP_material_bolt_nail",2],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitSmallHouse",
		[["BRPVP_craft_foundations",1],["BRPVP_craft_steel_wall",1],["BRPVP_craft_brick_wall",1],["BRPVP_craft_wooden_wall",1],["BRPVP_craft_rubber",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitAverageHouse",
		[["BRPVP_craft_foundations",1],["BRPVP_craft_steel_wall",1],["BRPVP_craft_brick_wall",2],["BRPVP_craft_wooden_wall",2],["BRPVP_craft_rubber",2]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitBigHouse",
		[["BRPVP_craft_foundations",2],["BRPVP_craft_steel_wall",2],["BRPVP_craft_brick_wall",3],["BRPVP_craft_wooden_wall",3],["BRPVP_craft_rubber",3]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitGiantHouse",
		[["BRPVP_craft_foundations",2],["BRPVP_craft_steel_wall",2],["BRPVP_craft_brick_wall",4],["BRPVP_craft_wooden_wall",4],["BRPVP_craft_rubber",3]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRPVP_bigFloor200",
		[["BRPVP_craft_foundations",6],["BRPVP_craft_steel_wall",6],["BRPVP_craft_brick_wall",12],["BRPVP_craft_wooden_wall",12],["BRPVP_craft_rubber",9]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitContainers",
		[["BRPVP_craft_steel_plate",6],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitTableChair",
		[["BRPVP_craft_wooden_board",3],["BRPVP_material_bolt_nail",1],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitBeach",
		[["BRPVP_craft_wooden_board",3],["BRPVP_material_bolt_nail",1],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitStuffo1",
		[["BRPVP_craft_wooden_board",3],["BRPVP_material_bolt_nail",1],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitStuffo2",
		[["BRPVP_craft_wooden_board",3],["BRPVP_material_bolt_nail",1],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitRecreation",
		[["BRPVP_craft_cement",2],["BRPVP_craft_wooden_board",2],["BRPVP_material_bolt_nail",1],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	],
	[
		"BRP_kitSmallLights",
		[["BRPVP_craft_cement",1],["BRPVP_craft_rubber",1]],
		"Land_WoodenCounter_01_F"
	]
];
BRPVP_craftsClassPlain = BRPVP_crafts apply {_x select 0};
BRPVP_craftsNoBaseFrom = [
	"BRPVP_farm_coal"
];

//===========================================================================================================
//== SPECIAL CODE END
//===========================================================================================================
BRPVP_meisterSetHitVehicle = {
	params ["_veh","_dam","_array","_player"];
	_veh setDamage (damage _veh+_dam);
	{_veh setHitIndex [_forEachIndex,_x+_dam,true,_player,_player];} forEach _array;
};
BRPVP_ulfanizeAiUnit = {
	private _bot = _this;
	_bot enableStamina false;
	_bot setUnitLoadout selectRandom BRPVP_ulfanSoldierLoadouts;
	_bot remoteExecCall ["BRPVP_sBotAllUnitsObjsAdd",0];
	_bot setVariable ["brpvp_is_ulfan",true,true];
	_bot setVariable ["brpvp_ss_immune_mult",0,true];
	_bot setVariable ["brpvp_no_possession",true,true];
	_bot setVariable ["brpvp_lst",0];
	_bot setVariable ["brpvp_no_head_hit",0];
	_bot setVariable ["brpvp_wrong_player",objNull];
	_bot addEventHandler ["Fired",{call BRPVP_sBotFired;}];
	_bot setSkill ["aimingAccuracy",BRPVP_ulfanSoldierSkill select 0];
	_bot setSkill (BRPVP_ulfanSoldierSkill select 1);
	[_bot,BRPVP_ulfanSoldierSpeed] remoteExecCall ["setAnimSpeedCoef",0];
};
BRPVP_calcFullLights = {
	if (BRPVP_blindHandle isEqualTo -1) then {
		private _priority = 1500;
		while {BRPVP_blindHandle = ppEffectCreate ["ColorCorrections",_priority];BRPVP_blindHandle < 0} do {_priority = _priority+1;};
		BRPVP_blindHandle ppEffectEnable true;
	};

	0 spawn {
		private _frySoundArray = ["fry1","fry2","fry3","fry4","fry5"];
		private _frySoundArrayNow = _frySoundArray call BIS_fnc_arrayShuffle;
		private _lightHurtSoundLast = 0;
		private _lightHurtEyesAcumulated = 0;
		private _lightHurtBodyAcumulated = 0;

		//private _lightHurtEyesMinPerc = 0.7;
		//private _lightHurtBodyMinPerc = 0.85;
		private _lightHurtEyesMinPerc = 2;
		private _lightHurtBodyMinPerc = 2;

		private _lightHurtBlindTime = 1.25;
		private _lightHurtDeadTime = 2.5;
		private _roadToBlind = [0,1] select (player getVariable ["brpvp_blind",false]);

		waitUntil {
			if (BRPVP_atomicBombInitBlind && _roadToBlind < 1) then {_roadToBlind = (_roadToBlind+4/diag_fps) min 1;};

			//LIGHT DAMAGE
			//private _perc = 0;
			//{_perc = _perc+_x;} forEach BRPVP_lightBlindPlayerPerc;
			//_perc = _perc min 1;

			//private _percBodyHurt = 0;
			//{_percBodyHurt = _percBodyHurt+_x;} forEach BRPVP_lightBlindBodyPlayerPerc;
			//_percBodyHurt = _percBodyHurt min 1;

			//call BRPVP_lightHurtEyes;
			//call BRPVP_lightHurtBody;
			//call BRPVP_lightHurtFrySound;

			private _percCam = 0;
			{_percCam = _percCam+_x;} forEach BRPVP_lightBlindCamPerc;
			_percCam = (_percCam^2 min 1)*0.5;

			private _a = 1-_percCam;
			private _b1 = (1-_roadToBlind*(1-0.0625))+_percCam*(0.8-_roadToBlind*0.7);
			private _b2 = 1+0.75*_roadToBlind+_percCam*(1-_roadToBlind);
			private _c1 = _percCam+0.299*(1-_percCam);
			private _c2 = _percCam+0.587*(1-_percCam);
			private _c3 = _percCam+0.114*(1-_percCam);
			private _d1 = 0.25*_roadToBlind;
			private _e1 = -0.75*_roadToBlind;

			BRPVP_blindHandle ppEffectAdjust [_b1,_b2,_e1,[_d1,0,0,_d1],[1,1,1,_a],[_c1,_c2,_c3,_a],[-1,-1,0,0,0,0,0]];
			BRPVP_blindHandle ppEffectCommit 0;

			{
				_x params ["_light","_intensity","_limit","_lowLimit","_attenuation"];
				private _atte = if (_attenuation isEqualTo []) then {[_lowLimit-(1-_intensity)*_lowLimit,0,(20-10*_intensity)/(_limit-_lowLimit),0]} else {_attenuation};
				_light setLightIntensity (sqrt(_intensity)*BRPVP_ABombLightMaxIntensity);
				_light setLightAttenuation _atte;
			} forEach BRPVP_ABombLightObjs;

			BRPVP_lightBlindRunning isEqualTo 0
		};
		if !(player getVariable ["brpvp_blind",false]) then {
			BRPVP_blindHandle ppEffectEnable false;
			ppEffectDestroy BRPVP_blindHandle;
			BRPVP_blindHandle = -1;
		};
		{deleteVehicle (_x select 0);} forEach BRPVP_ABombLightObjs;
		BRPVP_ABombLightObjs = [];
	};
};
BRPVP_flashFlareMeisterArray1 = ["_flare","_posASL","_distPercFlareMult","_init","_obj","_fgMult"];
BRPVP_flashFlareMeister = {
	if (!BRPVP_normalFlareStop) then {
		params BRPVP_flashFlareMeisterArray1;
		private _vel = velocity vehicle _obj;
		private _tm = 0.125+(1/diag_fps)/2;
		private _mult = 1.5;
		_flare setPosASL ((getPosASLVisual _obj vectorAdd [0,0,1.4]) vectorAdd (_vel vectorMultiply _tm));
		if (_obj getVariable ["dd",-1] isEqualTo -1) then {
			_flare setLightColor [0.784,0.537,1];
			_flare setLightAmbient [0.784,0.537,1];
		} else {
			_flare setLightColor [1,0.522,0];
			_flare setLightAmbient [1,0.522,0];
			_mult = 0.75;
		};
		uiSleep 0.1;
		if (!BRPVP_normalFlareStop) then {
			waitUntil {
				if (BRPVP_normalFlareStop) exitWith {true};
				private _delta = diag_tickTime-_init;
				private _perc = (_delta/0.2) min 1;
				_flare setLightFlareSize (_perc*_distPercFlareMult*_mult*_fgMult);
				_flare setLightIntensity (50*_perc);
				_perc isEqualTo 1;
			};
		};
		if (!BRPVP_normalFlareStop) then {
			waitUntil {
				if (BRPVP_normalFlareStop) exitWith {true};
				private _delta = diag_tickTime-_init;
				private _perc = (_delta/0.3) min 2.5;
				_flare setLightFlareSize (((1-_perc) max 0)*_distPercFlareMult*_mult*_fgMult);
				_flare setLightIntensity (50*(1-_perc/2.5));
				_perc isEqualTo 2.5;
			};
		};
	};
};
BRPVP_flashFlareMeisterHouseShock = {
	params BRPVP_flashFlareMeisterArray1;
	private _mult = 1.5;
	_flare setPosASL (getPosASLVisual _obj vectorAdd [0,0,1.4]);
	_flare setLightColor [0.784,0.537,1];
	_flare setLightAmbient [0.784,0.537,1];
	uiSleep 0.1;
	waitUntil {
		private _delta = diag_tickTime-_init;
		private _perc = (_delta/0.4) min 1;
		_flare setLightFlareSize (_perc*_distPercFlareMult*_mult*_fgMult);
		_flare setLightIntensity (150*_perc);
		_perc isEqualTo 1;
	};
	waitUntil {
		private _delta = diag_tickTime-_init;
		private _perc = (_delta/0.6) min 2.5;
		_flare setLightFlareSize (((1-_perc) max 0)*_distPercFlareMult*_mult*_fgMult);
		_flare setLightIntensity (150*(1-_perc/2.5));
		_perc isEqualTo 2.5;
	};
	BRPVP_normalFlareStop = false;
};
BRPVP_normalFlareStop = false;
BRPVP_shinePlayerCode = {
	if (hasInterface) then {
		params ["_obj","_limit","_lowLimit","_lightMult","_lightIntensity","_attenuation"];
		private _shinePlayerCodeIndex = _obj getVariable ["brpvp_shine_index",0];
		_obj setVariable ["brpvp_shine_index",_shinePlayerCodeIndex+1];
		private _shinePlayerCodeIndexNow = _shinePlayerCodeIndex+1;
		private _toRun = {alive _obj && _obj getVariable ["brpvp_is_master",false] && _obj getVariable ["sok",false] && _obj getVariable ["brpvp_shine_index",0] isEqualTo _shinePlayerCodeIndexNow};
		waitUntil {
			private _realLimit = _limit-_lowLimit;
			private _isMe = _obj isEqualTo player;
			waitUntil {
				uiSleep 0.001;
				!call _toRun || {(vectorMagnitude (getPosASLVisual _obj vectorAdd [0,0,1] vectorDiff AGLToASL positionCameraToWorld [0,0,0])-_lowLimit) max 0 < _realLimit}
			};
			if (_isMe) then {_lightMult = _lightMult*0.75;};

			private _light = "#lightpoint" createVehicleLocal [0,0,0];
			_light setPosASL getPosASLVisual _obj;
			_light setLightColor [1,1,1];
			_light setLightAmbient [1,1,1];
			_light setLightUseFlare false;
			_light setLightIntensity 0;
			_light setLightDayLight true;
			_light setLightAttenuation [0,0,200,0];
			_light lightAttachObject [_obj,[0,0,5]];

			private _flare = "#lightpoint" createVehicleLocal [0,0,0];
			_flare setPosASL getPosASLVisual _obj;
			_flare setLightColor [0.784,0.537,1];
			_flare setLightAmbient [0.784,0.537,1];
			_flare setLightIntensity 0;
			_flare setLightDayLight true;
			_flare setLightAttenuation [1,0,1,0];
			_flare setLightUseFlare true;
			_flare setLightFlareMaxDistance _limit;

			private _lightBlindRunningIdx = -1;
			BRPVP_lightBlindRunning = BRPVP_lightBlindRunning+1;
			if (BRPVP_lightBlindRunning isEqualTo 1) then {
				BRPVP_lightBlindRunningIdx = 0;
				_lightBlindRunningIdx = BRPVP_lightBlindRunningIdx;
				BRPVP_atomicBombInitBlind = false;
				BRPVP_atomicBombPlayerIsDeadBy = false;

				BRPVP_lightBlindCamPerc = [0];
				BRPVP_lightBlindPlayerPerc = [0];
				BRPVP_lightBlindBodyPlayerPerc = [0];
				BRPVP_ABombLightObjs = [[_light,_lightIntensity,_limit,_lowLimit,_attenuation]];

				call BRPVP_calcFullLights;
			} else {
				BRPVP_lightBlindRunningIdx = BRPVP_lightBlindRunningIdx+1;
				_lightBlindRunningIdx = BRPVP_lightBlindRunningIdx;
				BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,0];
				BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,0];
				BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,0];
				BRPVP_ABombLightObjs set [_lightBlindRunningIdx,[_light,_lightIntensity,_limit,_lowLimit,_attenuation]];
			};

			private _density = 2;
			private _flareCycleLim = 2;
			private _flareCycle = random _flareCycleLim;
			private _flareInit = diag_tickTime;
			private _minDistLight = 125;

			//START SHINE
			private _eTime = 2.5;
			private _init = diag_tickTime;
			waitUntil {
				private _posASL = getPosASLVisual _obj vectorAdd [0,0,1];
				private _posCam = AGLToASL positionCameraToWorld [0,0,0];
				private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
				private _realDist = (_dist-_lowLimit) max 0;
				private _viewVec = AGLToASL positionCameraToWorld [0,0,1] vectorDiff _posCam;
				private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;

				private _distPerc = (1-(_realDist min _realLimit)/_realLimit)^4;
				private _anglePerc = 1-acos (_viewVec vectorCos _vecToBomb)/180;
				private _timePerc = ((diag_tickTime-_init)/_eTime) min 1;
				private _blockPerc = 1;

				private _isSpec = _obj isEqualTo BRPVP_spectedPlayer;
				private _lowType = (_isMe || _isSpec) && {ASLToAGL _posCam distance _obj < 12};
				private _perc = _timePerc*_blockPerc*(_distPerc+_anglePerc)/2;
				BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,_perc*_lightMult];
				private _nearPerc = ((_minDistLight-_dist) max 0)/_minDistLight;
				(BRPVP_ABombLightObjs select _lightBlindRunningIdx) set [1,_lightIntensity*_timePerc*(_nearPerc^2)*([1,0.35] select _lowType)];
				
				private _fgMult = [1,0.125] select _lowType;
				_flareCycleLim = [2,5] select _lowType;
				private _distPercFlare = _dist/_limit;
				private _distPercFlareMult = ((_timePerc*(_distPercFlare)^(1/2)*_anglePerc)*30) max 5;
				private _bang = _obj getVariable ["brpvp_meister_flare_bang",-1];
				if (_bang isEqualTo -1) then {
					if (diag_tickTime-_flareInit > _flareCycle) then {
						_flareCycle = random _flareCycleLim+0.5;
						_flareInit = diag_tickTime;
						//[_flare,_posASL,_distPercFlareMult,_flareInit,_obj,_fgMult] spawn BRPVP_flashFlareMeister;
					};
				} else {
					BRPVP_normalFlareStop = true;
					[_flare,_posASL,_distPercFlareMult,diag_tickTime,_obj,_bang] spawn BRPVP_flashFlareMeisterHouseShock;
					_flareCycle = random _flareCycleLim+2;
					_obj setVariable ["brpvp_meister_flare_bang",-1];
				};

				_timePerc >= 1
			};

			//MANTAIN
			if (call _toRun) then {
				waitUntil {
					private _posASL = getPosASLVisual _obj vectorAdd [0,0,1];
					private _posCam = AGLToASL positionCameraToWorld [0,0,0];
					private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
					private _realDist = (_dist-_lowLimit) max 0;
					private _viewVec = AGLToASL positionCameraToWorld [0,0,1] vectorDiff _posCam;
					private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;

					private _distPerc = (1-(_realDist min _realLimit)/_realLimit)^4;
					private _anglePerc = 1-acos (_viewVec vectorCos _vecToBomb)/180;
					private _blockPerc = 1;

					private _isSpec = _obj isEqualTo BRPVP_spectedPlayer;
					private _lowType = (_isMe || _isSpec) && {ASLToAGL _posCam distance _obj < 12};
					private _perc = _blockPerc*(_distPerc+_anglePerc)/2;
					BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,_perc*_lightMult];
					private _nearPerc = ((_minDistLight-_dist) max 0)/_minDistLight;
					(BRPVP_ABombLightObjs select _lightBlindRunningIdx) set [1,_lightIntensity*(_nearPerc^2)*([1,0.35] select _lowType)];

					private _fgMult = [1,0.125] select _lowType;
					_flareCycleLim = [2,5] select _lowType;
					private _distPercFlare = _dist/_limit;
					private _distPercFlareMult = (((_distPercFlare)^(1/2)*_anglePerc)*30) max 5;
					private _bang = _obj getVariable ["brpvp_meister_flare_bang",-1];
					if (_bang isEqualTo -1) then {
						if (diag_tickTime-_flareInit > _flareCycle) then {
							_flareCycle = random _flareCycleLim+0.5;
							_flareInit = diag_tickTime;
							[_flare,_posASL,_distPercFlareMult,_flareInit,_obj,_fgMult] spawn BRPVP_flashFlareMeister;
						};
					} else {
						BRPVP_normalFlareStop = true;
						[_flare,_posASL,_distPercFlareMult,diag_tickTime,_obj,_bang] spawn BRPVP_flashFlareMeisterHouseShock;
						_flareCycle = random _flareCycleLim+2;
						_obj setVariable ["brpvp_meister_flare_bang",-1];
					};

					(_realDist > _realLimit) || !call _toRun
				};
			};

			//VANISH
			private _eTime = 2.5;
			private _init = diag_tickTime;
			waitUntil {
				private _posASL = getPosASLVisual _obj vectorAdd [0,0,1];
				private _posCam = AGLToASL positionCameraToWorld [0,0,0];
				private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
				private _realDist = (_dist-_lowLimit) max 0;
				private _viewVec = AGLToASL positionCameraToWorld [0,0,1] vectorDiff _posCam;
				private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;

				private _distPerc = (1-(_realDist min _realLimit)/_realLimit)^4;
				private _anglePerc = 1-acos (_viewVec vectorCos _vecToBomb)/180;
				private _timePerc = ((diag_tickTime-_init)/_eTime) min 1;
				private _blockPerc = 1;

				private _isSpec = _obj isEqualTo BRPVP_spectedPlayer;
				private _lowType = (_isMe || _isSpec) && {ASLToAGL _posCam distance _obj < 12};
				private _perc = (1-_timePerc)*_blockPerc*(_distPerc+_anglePerc)/2;
				BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,_perc*_lightMult];
				private _nearPerc = ((_minDistLight-_dist) max 0)/_minDistLight;
				(BRPVP_ABombLightObjs select _lightBlindRunningIdx) set [1,_lightIntensity*(1-_timePerc)*(_nearPerc^2)*([1,0.35] select _lowType)];

				private _fgMult = [1,0.125] select _lowType;
				_flareCycleLim = [2,5] select _lowType;
				private _distPercFlare = _dist/_limit;
				private _distPercFlareMult = (((1-_timePerc)*(_distPercFlare)^(1/2)*_anglePerc)*30) max 5;
				private _bang = _obj getVariable ["brpvp_meister_flare_bang",-1];
				if (_bang isEqualTo -1) then {
					if (diag_tickTime-_flareInit > _flareCycle) then {
						_flareCycle = random _flareCycleLim+0.5;
						_flareInit = diag_tickTime;
						//[_flare,_posASL,_distPercFlareMult,_flareInit,_obj,_fgMult] spawn BRPVP_flashFlareMeister;
					};
				} else {
					BRPVP_normalFlareStop = true;
					[_flare,_posASL,_distPercFlareMult,diag_tickTime,_obj,_bang] spawn BRPVP_flashFlareMeisterHouseShock;
					_flareCycle = random _flareCycleLim+2;
					_obj setVariable ["brpvp_meister_flare_bang",-1];
				};

				_timePerc >= 1
			};

			deleteVehicle _light;
			deleteVehicle _flare;
			BRPVP_lightBlindRunning = BRPVP_lightBlindRunning-1;

			!call _toRun
		};
	};
};
//PVEH FUNCTIONS SERVER
BRPVP_vrObjectSetTexturesOnOthers = {
	params ["_id","_class","_color1","_color2"];
	{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {[_x,_color1,_color2] call BRPVP_vrObjectSetTextures;};} forEach (allSimpleObjects [_class]);
};
BRPVP_vrObjectSetTextures = {
	params ["_obj","_color1","_color2"];
	_obj setObjectTexture [0,format ["%1BRP_imagens\textures\%2.paa",BRPVP_imagePrefix,_color1]];
	_obj setObjectTexture [1,format ["%1BRP_imagens\textures\%2.paa",BRPVP_imagePrefix,_color2]];
	_obj setVariable ["brpvp_vr_colors",[_color1,_color2]];
};
BRPVP_setTerrainGridClientRun = { //NOHC SERVER
	BRPVP_setTerrainGridClient = _this;
	setTerrainGrid _this;
};
BRPVP_closedCityRunningSet = { //NOHC SERVER
	BRPVP_closedCityRunning = _this;
	_this call BRPVP_processSiegeIcons;
};

BRPVP_minervaBotAllUnitsObjsAdd = {
	BRPVP_minervaBotAllUnitsObjs = BRPVP_minervaBotAllUnitsObjs-[objNull];
	BRPVP_minervaBotAllUnitsObjs pushBackUnique _this;
};
BRPVP_weatherPerkMessage = {
	if (BRPVP_weatherPredict) then {
		params ["_oNew","_willRain","_wind"];
		private _h = [0,0.45] select BRPVP_menuExtraLigado;
		private _clouds = format ["%1%2",5*round (_oNew*100/5),"%"];
		private _rain = [localize "str_no",localize "str_yes"] select _willRain;
		private _wind = str round _wind;
		["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\setweather.paa'/><br/>"+format [localize "str_perk_weather_predict",_clouds,_rain,_wind],0,_h,5,0,0,2517] call BRPVP_fnc_dynamicText;
		"weather_news" call BRPVP_playSound;
	};
};
BRPVP_playSound = {
	_this remoteExecCall ["playSound",BRPVP_specOnMeMachines];
};
BRPVP_objectConsumeInFlames = {
	params ["_obj","_pw","_params",["_endCode",{}]];
	private _emitter = "#particlesource" createVehicleLocal ASLtoAGL _pw;
	private _rand = 1+random 0.5;
	_emitter setParticleClass "ATMineExplosionParticles";
	_emitter setDropInterval (0.02*_rand);
	{_obj say3D _x;} forEach _params;
	[_obj,_emitter,_endCode,_rand] spawn {
		params ["_obj","_emitter","_endCode","_rand"];
		uiSleep (0.3*_rand);
		detach _emitter;
		deleteVehicle _emitter;
		_obj call _endCode;
	};
};
BRPVP_reduceAndDeleteClient = {
	private _veh = _this;
	if (positionCameraToWorld [0,0,0] distance _veh < (0.8*viewDistance)) then {
		private _pos = getPosWorld _veh;
		private _vdu = [vectorDir _veh,vectorUp _veh];
		private _class = typeOf _veh;
		private _textures = getObjectTextures _veh;
		private _vehSO = createSimpleObject [_class,BRPVP_posicaoFora,true];
		_vehSO setPosWorld _pos;
		_vehSO setVectorDirAndUp _vdu;
		{_vehSO setObjectTextureGlobal [_forEachIndex,_x];} forEach _textures;
		uiSleep 0.001;
		_veh hideObject true;
		uiSleep 0.001;
		private _min = 5/(sizeOf _class);
		private _flameOk = false;
		private _asl = getPosASL _vehSO;
		private _init = diag_tickTime;
		waitUntil {
			private _reduce = sqrt((1.25-(diag_tickTime-_init))/1.25) max 0;
			_vehSO setObjectScale _reduce;
			_vehSO setPosASL _asl;
			if (_reduce < _min && !_flameOk) then {
				_flameOk = true;
				[_vehSO,_asl,[["flame",250],["used_vehicle",300]],{hideObject _this;uiSleep 1;deleteVehicle _this;}] call BRPVP_objectConsumeInFlames;
			};
			_reduce isEqualTo 0
		};
	};
};
BRPVP_addPlasmaRifle = {
	private _bot = _this;
	{
		private _weapon = _x;
		if (_weapon isNotEqualTo "") then {
			private _cfgMags = getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines");
			{_bot removeMagazines _x;} forEach _cfgMags;
			_bot removeWeaponGlobal _weapon;
		};
	} forEach [primaryWeapon _bot,secondaryWeapon _bot,handGunWeapon _bot];
	_bot addMagazineGlobal selectRandom ["GX_M82A2000_10Rnd_Plasma_Mag","GX_M82A2000_10Rnd_Plasma_HE_Mag"];
	_bot addWeaponGlobal "GX_M82A2000_Weapon";
	_bot addPrimaryWeaponItem "optic_LRPS";
};
BRPVP_playersList = {allPlayers-entities "HeadlessClient_F"};
BRPVP_getPlayerById = {
	private _player = objNull;
	{if (_x getVariable ["id_bd","no_id"] isEqualTo _this) exitWith {_player = _x;};} forEach call BRPVP_playersList;
	_player
};
BRPVP_spcItemsLootCreateRaidMission = {
	params ["_posWorld","_vdu","_items"];
	private _obj = createVehicle [BRPVP_spcItemsClass,BRPVP_posicaoFora,[],100,"CAN_COLLIDE"];
	_obj setPosWorld _posWorld;
	_obj setVariable ["brpvp_spc_items",_items,true];
	_obj
};
BRPVP_createAtomicBombBlueTankItems = {
	private _posAGL = ASLToAGL _this;
	private _items = [];
	if (random 1 < 0.01) then {
		_items pushBack "BRPVP_divineFire";
	} else {
		if (random 1 < 0.15) then {
			_items pushBack "BRPVP_kriptoniteRed";
		} else {
			_items pushBack "BRPVP_kriptonite";
		};
	};
	[_posAGL,_items] call BRPVP_spcItemsLootCreateAtomicBomb;
};
BRPVP_createRandomBlueTankItems = {
	private _extra = _this;
	private _return = [];
	if (random 1 < BRPVP_baseBombDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_baseBomb";};
	if (random 1 < BRPVP_masterKeyDropChance*sqrt(_extra)) then {_return pushBack selectRandom ["BRP_vehicleThief","BRP_doorThief"];};
	if (random 1 < BRPVP_antiBaseBombDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_antiBaseBomb";};
	if (random 1 < BRPVP_weaponTestLootChance*sqrt(_extra)) then {_return pushBack "BRPVP_bagSoldier";};
	if (random 1 < BRPVP_rearmVehDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_vehicleAmmo";};
	if (random 1 < BRPVP_xrayDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_xrayItem";};
	if (random 1 < BRPVP_upackDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_uberPack";};
	if (random 1 < BRPVP_atmFixDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_atmFix";};
	if (random 1 < BRPVP_selfReviveDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_selfRevive";};
	if (random 1 < BRPVP_plusTorqueDropChance*sqrt(_extra)) then {_return pushBack "BRPVP_vehicleTorque";};
	if (random 1 < BRPVP_possessionDropChance*sqrt(_extra)) then {_return pushBack selectRandom BRPVP_possessionDropChanceArray;};
	if (random 1 < BRPVP_trenchChance*sqrt(_extra)) then {_return pushBack "BRPVP_trench";};
	if (random 1 < BRPVP_baseBoxUpgradeChance*sqrt(_extra)) then {_return pushBack "BRPVP_baseBoxUpgrade";};
	if (random 1 < BRPVP_minervaShotChance) then {_return pushBack "BRPVP_minervaShot";};
	if (random 1 < BRPVP_atomicShotChance) then {_return pushBack "BRPVP_atomicShot";};
	if (random 1 < BRPVP_prideAtomicShotChance) then {_return pushBack "BRPVP_prideAtomicShot";};
	if (random 1 < BRPVP_baseMineChance) then {_return pushBack "BRPVP_baseMine";};
	if (random 1 < BRPVP_playerLaunchSuperChance) then {_return pushBack "BRPVP_playerLaunchSuper";};
	if (random 1 < BRPVP_miraculousEyeDropChance) then {_return pushBack "BRPVP_miraculousEyeDrop";};
	_return
};
BRPVP_vehMissionSelectVehicle = {
	private _total = 0;
	{_total = _total+(_x select 1);} forEach BRPVP_vehMissionCfg;
	private _rnd = random _total;
	private _sum = 0;
	private _type = -1;
	{
		_sum = _sum+(_x select 1);
		if (_sum > _rnd) exitWith {_type = _x select 0};
	} forEach BRPVP_vehMissionCfg;
	private _chance = [];
	{
		if (count _x > 6 && !((_x select 3) in BRPVP_deniedVehiclesVehMission)) then {
			if ((_x select 6) isEqualTo _type) then {_chance pushBack (_x select 3);};
		};
	} forEach BRPVP_tudoA3;
	[selectRandom _chance,""] select (_chance isEqualTo []);
};
BRPVP_sBotAddHuntEffect = {
	private _ulfan = _this;
	private _posATL = getPosATL _ulfan;
	private _emitter1 = "#particlesource" createVehicleLocal _posATL;
	//_emitter1 setParticleClass "ObjectDestructionFire2";
	_emitter1 setParticleClass "AirFireSparks";
	_emitter1 setDropInterval 0.035;
	_emitter1 attachTo [_ulfan,_ulfan selectionPosition "spine2"];
	private _emitter2 = "#particlesource" createVehicleLocal _posATL;
	_emitter2 setParticleClass "ObjectDestructionRefractSmall";
	_emitter2 setDropInterval 0.05;
	_emitter2 attachTo [_ulfan,_ulfan worldToModel (ASLToAGL getPosASL _ulfan)];
	_ulfan setVariable ["brpvp_ueffects",[_emitter1,_emitter2]];
};
BRPVP_sBotRemoveHuntEffect = {
	private _ulfan = _this;
	private _eff = (_ulfan getVariable ["brpvp_ueffects",[]])-[objNull];
	{deleteVehicle _x;} forEach _eff;
};
BRPVP_larsToDieTeleportEffect = {
	private _lars = _this;
	if (positionCameraToWorld [0,0,0] distance _lars < 2000) then {
		private _emitter = "#particlesource" createVehicleLocal [0,0,0];
		_emitter attachTo [_lars,[0,0,0]];
		_emitter setParticleClass "ATMineExplosionParticles";
		_emitter setDropInterval 0.03;
		private _smoke = "#particlesource" createVehicleLocal [0,0,0];
		_smoke attachTo [_lars,[0,0,0]];
		_smoke setParticleClass "ATCloudSmallLight";
		_smoke setDropInterval 0.025;
		private _stones = "#particlesource" createVehicleLocal [0,0,0];
		_stones attachTo [_lars,[0,0,0]];
		_stones setParticleClass "MineStones1";
		_stones setDropInterval 0.015;
		[_emitter,_smoke,_stones] spawn {
			params ["_emitter","_smoke","_stones"];
			uiSleep 0.125;
			deleteVehicle _emitter;
			deleteVehicle _stones;
			uiSleep 0.25;
			deleteVehicle _smoke;
		};
	};
};
BRPVP_larsSmallTeleportEffectPosAGL = {
	private _posAGL = _this;
	if (positionCameraToWorld [0,0,0] distance _posAGL < 2000) then {
		private _emitter = "#particlesource" createVehicleLocal _posAGL;
		_emitter setParticleClass "ATMineExplosionParticles";
		_emitter setDropInterval 0.03;
		private _smoke = "#particlesource" createVehicleLocal _posAGL;
		_smoke setParticleClass "ATCloudSmallLight";
		_smoke setDropInterval 0.025;
		private _stones = "#particlesource" createVehicleLocal _posAGL;
		_stones setParticleClass "MineStones1";
		_stones setDropInterval 0.015;
		[_emitter,_smoke,_stones] spawn {
			params ["_emitter","_smoke","_stones"];
			uiSleep 0.125;
			deleteVehicle _emitter;
			deleteVehicle _stones;
			uiSleep 0.25;
			deleteVehicle _smoke;
		};
	};
};
BRPVP_peterLocoTeleportEffect = {
	private _lars = _this;
	if (positionCameraToWorld [0,0,0] distance _lars < 2000) then {
		private _emitter = "#particlesource" createVehicleLocal [0,0,0];
		_emitter attachTo [_lars,[0,0,0]];
		_emitter setParticleClass "ATMineExplosionParticles";
		_emitter setDropInterval 0.05;
		private _smoke = "#particlesource" createVehicleLocal [0,0,0];
		_smoke attachTo [_lars,[0,0,0]];
		_smoke setParticleClass "ATCloudSmallLight";
		_smoke setDropInterval 0.035;
		[_emitter,_smoke] spawn {
			params ["_emitter","_smoke"];
			uiSleep 0.1;
			deleteVehicle _emitter;
			uiSleep 0.025;
			deleteVehicle _smoke;
		};
	};
};
BRPVP_larsSmallTeleportEffect = {
	private _lars = _this;
	if (positionCameraToWorld [0,0,0] distance _lars < 2000) then {
		uiSleep 0.1;
		private _emitter = "#particlesource" createVehicleLocal [0,0,0];
		_emitter attachTo [_lars,[0,0,0]];
		_emitter setParticleClass "ATMineExplosionParticles";
		_emitter setDropInterval 0.03;
		private _smoke = "#particlesource" createVehicleLocal [0,0,0];
		_smoke attachTo [_lars,[0,0,0]];
		_smoke setParticleClass "ATCloudSmallLight";
		_smoke setDropInterval 0.025;
		private _stones = "#particlesource" createVehicleLocal [0,0,0];
		_stones attachTo [_lars,[0,0,0]];
		_stones setParticleClass "MineStones1";
		_stones setDropInterval 0.015;
		[_emitter,_smoke,_stones] spawn {
			params ["_emitter","_smoke","_stones"];
			uiSleep 0.125;
			deleteVehicle _emitter;
			deleteVehicle _stones;
			uiSleep 0.25;
			deleteVehicle _smoke;
		};
	};
};
BRPVP_sBotAllUnitsObjsAdd = {
	BRPVP_sBotAllUnitsObjs = BRPVP_sBotAllUnitsObjs-[objNull];
	BRPVP_sBotAllUnitsObjs pushBackUnique _this;
};
BRPVP_moveActionBoxBackBigBox = {
	params ["_sustenter","_box","_posW","_vdu"];
	//_sustenter enableSimulationGlobal true;
	//_box enableSimulationGlobal true;
	_sustenter setPosWorld _posW;
	_sustenter setVectorDirAndUp _vdu;
	_box spawn {
		private _box = _this;
		uiSleep 1;
		[_box,BRPVP_superBoxScale,[],0] remoteExecCall ["BRPVP_setObjectScale",_box];
	};
};
BRPVP_getItemMod = {
	private _item = _this;
	private _found = "";
	{
		_x params ["_prefixes","_mod"];
		if ({_item find _x isEqualTo 0} count _prefixes > 0) exitWith {_found = _mod;};
	} forEach BRPVP_modsPrefixes;
	_found
};
BRPVP_getBoxMoney = {
	private _moneyMags = BRPVP_moneyItems select 0;
	private _moneyMagsValor = BRPVP_moneyItems select 1;
	private _total = 0;
	{
		private _idx = _moneyMags find (_x select 0);
		if (_idx isNotEqualTo -1) then {_total = _total+(_moneyMagsValor select _idx);};
	} forEach magazinesAmmoCargo _this;
	_total
};
BRPVP_setHitGlassCVL = {
	params ["_class","_id","_changed"];
	private _obj = objNull;
	{if (_x getVariable "id_bd" isEqualTo _id) exitWith {_obj = _x;};} forEach (_class call BRPVP_getSegSimpleObjectCVL);
	if (!isNull _obj) then {_obj setHit _changed;};
};
BRPVP_animeSourceDoorCVL = {
	params ["_class","_id","_changed"];
	_changed params ["_aName","_newPhase"];
	private _obj = objNull;
	{if (_x getVariable "id_bd" isEqualTo _id) exitWith {_obj = _x;};} forEach (_class call BRPVP_getSegSimpleObjectCVL);
	if (!isNull _obj) then {
		private _pNowLocal = _obj animationPhase _aName;
		private _remoteNow = _obj getVariable ["brpvp_remote_interaction",[]];
		_remoteNow pushBack _aName;
		_obj setVariable ["brpvp_remote_interaction",_remoteNow];
		_obj animateSource [_aName,_newPhase];
		[_obj,_aName,_pNowLocal,_newPhase,abs (_newPhase-_pNowLocal)] spawn {
			params ["_obj","_aName","_pNowLocal","_newPhase","_diffLast"];
			waitUntil {
				uiSleep 0.1;
				private _diff = abs (_newPhase-(_obj animationPhase _aName));
				private _stopCheck = _diff >= _diffLast;
				_diffLast = _diff;
				_stopCheck
			};
			private _remoteNow = _obj getVariable ["brpvp_remote_interaction",[]];
			_remoteNow deleteAt (_remoteNow find _aName);
			_obj setVariable ["brpvp_remote_interaction",_remoteNow];
		};
	};
};
BRPVP_isCompleteBox = {
	typeOf _this isEqualTo BRPVP_superBoxClass || _this isKindoF "ReammoBox_F" && !BRPVP_usingBrpvpMod
};
BRPVP_setObjectScale = {
	params ["_obj","_scale",["_posW",[]],["_dir","none"]];
	if (_dir isNotEqualTo "none") then {_obj setDir _dir;};
	_obj setObjectScale _scale;
	if (_posW isNotEqualTo []) then {_obj setPosWorld _posW;};
};
BRPVP_bigBoxVisualHelp = {
	params ["_posW","_vdu",["_stairs",objNull],["_sustenter",objNull],["_useBox",objNull]];
	_sustenter hideObject true;
	_useBox hideObject true;
	private _visualHelp = createSimpleObject [BRPVP_superBoxClass,_posW,true];
	_stairs hideObject true;
	_visualHelp setVectorDirAndUp _vdu;
	_visualHelp setPosWorld _posW;
	_visualHelp setObjectScale BRPVP_superBoxScale;
	_visualHelp spawn {uiSleep 2;deleteVehicle _this;};
	[_useBox,_stairs] spawn {uiSleep 1.5;{_x hideObject false;} forEach _this;};
};
BRPVP_raidTrainingBaseBombRemoveLines = {
	private _eDel = [];
	{
		private _id = _x select 2;
		if (_id isEqualTo -1) then {_eDel pushBack _forEachIndex;};
	} forEach BRPVP_baseBombDestroyedLines;
	_eDel sort false;
	{BRPVP_baseBombDestroyedLines deleteAt _x;} forEach _eDel;
};
BRPVP_safezoneProtectionOnExitRemoveObj = {
	BRPVP_safezoneProtectionOnExitObjs = BRPVP_safezoneProtectionOnExitObjs-[_this,objNull];
};
BRPVP_safezoneProtectionOnExitAddObj = {
	params ["_player","_extraStart"];
	_player setVariable ["brpvp_extra_protection_start",_extraStart];
	BRPVP_safezoneProtectionOnExitObjs pushBackUnique _player;
	BRPVP_safezoneProtectionOnExitObjs = BRPVP_safezoneProtectionOnExitObjs-[objNull];
};
BRPVP_zedsSetBloodyCorpse = {
	{_this setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
	{_this setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
};
BRPVP_getItemDisplayNameAndImage = {
	private _it = _this;
	private _imagem = BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa";
	private _nomeBonito = "???";
	if (isClass (configFile >> "CfgMagazines" >> _it)) then {
		_imagem = getText (configFile >> "CfgMagazines" >> _it >> "picture");
		_nomeBonito = getText (configFile >> "CfgMagazines" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
	} else {
		if (isClass (configFile >> "CfgWeapons" >> _it)) then {
			_imagem = getText (configFile >> "CfgWeapons" >> _it >> "picture");
			_nomeBonito = getText (configFile >> "CfgWeapons" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
		} else {
			if (isClass (configFile >> "CfgVehicles" >> _it)) then {
				_imagem = getText (configFile >> "CfgVehicles" >> _it >> "picture");
				_nomeBonito = getText (configFile >> "CfgVehicles" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
			} else {
				if (isClass (configFile >> "CfgGlasses" >> _it)) then {
					_imagem = getText (configFile >> "CfgGlasses" >> _it >> "picture");
					_nomeBonito = getText (configFile >> "CfgGlasses" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
				};
			};
		};
	};
	[_nomeBonito,_imagem]
};
BRPVP_forcedTracerOnAiUnit = {
	if (hasInterface) then {
		private _ai = _this select 0;
		private _rd = (_this select 6) getRelDir BRPVP_myPlayerOrSpecOrDrone;
		if (BRPVP_myPlayerOrSpecOrDrone distance _ai < viewDistance+(2500-([_rd/180,(180-(_rd-180))/180] select (_rd > 180))*2500)) then {
			private _ammo = _this select 4;
			if (_ammo isEqualTo (_ai getVariable ["brpvp_tracer_last_ammo","XXX_NONE"]) || {!(_ammo in BRPVP_ammoNoAutoTracer) && getText (configFile >> "CfgAmmo" >> _ammo >> "simulation") in ["shotBullet","shotSubmunitions"]}) then {
				private _tracer = createSimpleObject [BRPVP_tracerModelAI,[0,0,0],true];
				_tracer attachTo [_this select 6,[0,0,0]];
				_tracer setDir 180;
				BRPVP_firedFlyingBullets pushBack [_this select 6,_tracer];
				_ai setVariable ["brpvp_tracer_last_ammo",_ammo];
			};
		};
	};
};
BRPVP_forcedTracerOnPlayer = {
	private _player = _this select 0;
	if (hasInterface && (!(_player getVariable ["brpvp_tracer_on",false]) || BRPVP_vePlayers) && !(_player getVariable "god") && !(_player getVariable "brpvp_extra_protection")) then {
		private _rd = (_this select 6) getRelDir BRPVP_myPlayerOrSpecOrDrone;
		if (BRPVP_myPlayerOrSpecOrDrone distance _player < viewDistance+(2500-([_rd/180,(180-(_rd-180))/180] select (_rd > 180))*2500)) then {
			private _ammo = _this select 4;
			if (_ammo isEqualTo (_player getVariable ["brpvp_tracer_last_ammo","XXX_NONE"]) || {!(_ammo in BRPVP_ammoNoAutoTracer) && getText (configFile >> "CfgAmmo" >> _ammo >> "simulation") in ["shotBullet","shotSubmunitions"]}) then {
				private _tracer = createSimpleObject [BRPVP_tracerModelForced,[0,0,0],true];
				_tracer attachTo [_this select 6,[0,0,0]];
				_tracer setDir 180;
				BRPVP_firedFlyingBullets pushBack [_this select 6,_tracer];
				_player setVariable ["brpvp_tracer_last_ammo",_ammo];
			};
		};
	};
};
BRPVP_tracerOtherPlayers = {
	private _player = _this select 0;
	if (hasInterface && (_player in BRPVP_meusAmigosObj || _player in units group player || BRPVP_vePlayers) && !(_player getVariable "god") && !(_player getVariable "brpvp_extra_protection")) then {
		private _rd = (_this select 6) getRelDir BRPVP_myPlayerOrSpecOrDrone;
		if (BRPVP_myPlayerOrSpecOrDrone distance _player < viewDistance+(2500-([_rd/180,(180-(_rd-180))/180] select (_rd > 180))*2500)) then {
			if (_player getVariable ["brpvp_tracer_on",false]) then {
				private _ammo = _this select 4;
				if (_ammo isEqualTo (_player getVariable ["brpvp_tracer_last_ammo","XXX_NONE"]) || {!(_ammo in BRPVP_ammoNoAutoTracer) && getText (configFile >> "CfgAmmo" >> _ammo >> "simulation") in ["shotBullet","shotSubmunitions"]}) then {
					private _tracer = createSimpleObject [BRPVP_tracerModel,[0,0,0],true];
					_tracer attachTo [_this select 6,[0,0,0]];
					_tracer setDir 180;
					BRPVP_firedFlyingBullets pushBack [_this select 6,_tracer];
					_player setVariable ["brpvp_tracer_last_ammo",_ammo];
				};
			};
		};
	};
};
BRPVP_checkIfTurretFlagIsOnRaidOrPlayerInReach = {
	params ["_t","_tp"];
	if (_t getVariable ["own",-1] > -1) then {
		private _flag = _t getVariable ["brpvp_tflag",objNull];
		if (isNull _flag) then {
			_flag = _t call BRPVP_nearestFlagInside;
			_t setVariable ["brpvp_tflag",_flag];
		};
		if (isNull _flag) then {
			true
		} else {
			private _rad = _flag getVariable "brpvp_flag_radius";
			private _lra = _flag getVariable ["brpvp_last_intrusion",-BRPVP_raidNoConstructionOnBaseIfRaidStartedTime];
			serverTime-_lra < BRPVP_raidNoConstructionOnBaseIfRaidStartedTime || _tp distance2D _flag <= _rad+BRPVP_actualAutoTurretsDist/2
		};
	} else {
		true
	};
};
BRPVP_checkRemoteAccessPlayerObject = {
	params ["_pAccess","_oAcessed"];

	//PLAYER
	private _id_bd = _pAccess getVariable "id_bd";
	private _amg = _pAccess getVariable "amg";

	//OBJECT
	private _oOwn = _oAcessed getVariable ["own",-1];
	private _oAmg = _oAcessed getVariable ["amg",[[],[],true]];
	private _oShareT = _oAcessed getVariable ["stp",1];
	_oAmg = (_oAmg select 0)+([[],_oAmg select 1] select (_oAmg select 2));
	
	private _retorno = false;
	if !(_oShareT isEqualTo 4) then {
		if (_oOwn isEqualTo -1 || _id_bd isEqualTo _oOwn || _oShareT isEqualTo 3) then {
			_retorno = true;
		} else {
			if (_oShareT isNotEqualTo 0) then {
				if (_oShareT isEqualTo 1) then {
					if (_id_bd in _oAmg) then {_retorno = true;};
				} else {
					if (_oShareT isEqualTo 2) then {if (_id_bd in _oAmg && _oOwn in _amg) then {_retorno = true;};};
				};
			};
		};
	};
	_retorno
};
BRPVP_isFlagsFriendRelaxed = {
	params ["_player","_flags"];
	private _pId = if (_player isEqualType objNull) then {_player getVariable "id_bd"} else {_player select 1};
	private _pAmg = if (_player isEqualType objNull) then {_player getVariable "amg"} else {_player select 2};
	private _isFriend = [];
	{
		private _flag = _x;
		if (_flag getVariable ["id_bd",-1] isNotEqualTo -1) then {
			private _flagOwn = _flag getVariable "own";
			private _flagRad = _flag getVariable ["brpvp_flag_radius",0];
			
			//IS SET ON THE FLAG?
			private _isFlagOwner = _flagOwn isEqualTo _pId;
			private _isInFlag = if (_player isEqualType objNull) then {[_player,_flag] call BRPVP_checaAcessoRemotoFlag} else {[_pId,_flag] call BRPVP_checaAcessoRemotoFlagNoObj};
			if (_isFlagOwner || _isInFlag) then {
				_isFriend pushBack _flag;
			} else {
				//IF FRIEND OF PLAYERS ON THE FLAG?
				private _fAmg = (_flag getVariable "amg") select 1;
				_fAmg pushBackUnique _flagOwn;
				private _fAmgFoundOnline = [];
				private _okCnt = 0;
				{
					private _pcId = _x getVariable ["id_bd",-1];
					if (_pcId isNotEqualTo -1 && _pcId in _fAmg) then {
						_fAmgFoundOnline pushBack _pcId;
						if (_pId in _x getVariable "amg") then {_okCnt = _okCnt+1;};
					};
				} forEach call BRPVP_playersList;
				private _fAmgRemain = _fAmg-_fAmgFoundOnline;
				if (_fAmgRemain isNotEqualTo []) then {
					BRPVP_getPlayersAmgDataReturn = nil;
					private _idsTxt = [[str _fAmgRemain,"[","("] call BRPVP_stringReplace,"]",")"] call BRPVP_stringReplace;
					[player,_idsTxt] remoteExecCall ["BRPVP_getPlayersAmgData",2];
					waitUntil {!isNil "BRPVP_getPlayersAmgDataReturn"};
					{
						_x params ["_faId","_faAmg"];
						if (_pId in _faAmg) then {_okCnt = _okCnt+1;};
					} forEach BRPVP_getPlayersAmgDataReturn;
				};
				if (_okCnt >= 0.5*count _fAmg) then {_isFriend pushBack _flag;};
			};
		};
	} forEach _flags;
	_isFriend
};
BRPVP_minervaShotServerAllowDamage = {
	params ["_objs","_state"];
	{_x allowDamage _state;} forEach _objs;
};
BRPVP_evTowerHD = {
	params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
	private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
	private _deltaDam = _dam-_damNow;
	_damNow+_deltaDam*0.25
};
BRPVP_minervaShotDeleteCrate = {
	{{_x setPosWorld BRPVP_posicaoFora;} forEach nearestObjects [_x,["#crater"],1];} forEach _this;
};
BRPVP_godModeHouseAddObj = {
	BRPVP_godModeHouseObjects pushBackUnique _this;
	BRPVP_godModeHouseObjects = BRPVP_godModeHouseObjects-[objNull];
};
BRPVP_isBaseMapDrawClasses = ["Building","Wall"];
BRPVP_isBaseMapDraw = {
	{if (_this isKindOf _x) exitWith {true};false} forEach BRPVP_isBaseMapDrawClasses;
};
BRPVP_terrainVertexChangesAdd = {
	BRPVP_terrainVertexChanges pushBack _this;
};
BRPVP_round = {
	params ["_number","_decimals"];
	(round (_number*10^_decimals))/10^_decimals
};
BRPVP_numberToDistanceTxt = {
	if (_this < 999.5) then {format ["%1m",round _this]} else {format ["%1km",(round (_this/100))/10]};
};
BRPVP_secCamRemoveArray = {
	if (!isNil "BRPVP_secCamAll") then {BRPVP_secCamAll = BRPVP_secCamAll-(_this+[objNull]);};
};
BRPVP_secCamAddArray = {
	if (!isNil "BRPVP_secCamAll") then {
		BRPVP_secCamAll = BRPVP_secCamAll-[objNull];
		BRPVP_secCamAll pushBackUnique _this;
	};
};
BRPVP_processSiegeIcons = {
	_BRPVP_onSiegeIcons = [];
	{if (_x isEqualTo 2) then {_BRPVP_onSiegeIcons pushBack (BRPVP_locaisImportantes select _forEachIndex select 0);};} forEach _this;
	BRPVP_onSiegeIcons = _BRPVP_onSiegeIcons;
};
BRPVP_calcMissionsPosRad = {
	private _missionsPos = [];
	_missionsPos append (BRPVP_missPrediosEm apply {[getPos _x,50]});
	_missionsPos append (BRPVP_blockPlacesSelected apply {[_x select 0,50]});
	_missionsPos append (BRPVP_onSiegeIcons apply {[_x,200]});
	_missionsPos append (BRPVP_bombMissionObjs apply {[getPos _x,50]});
	_missionsPos append (BRPVP_holeMissionInfo apply {[_x select 0,150]});
	_missionsPos append (BRPVP_vehicleMissionIcons apply {[getPos _x,50]});
	_missionsPos append (BRPVP_pmissObjectsToDel apply {[_x select 1 select 0,(_x select 1 select 1)*0.6]});
	_missionsPos append (BRPVP_pmiss2ObjectsToDel apply {[_x select 1 select 0,(_x select 1 select 1)*0.6]});
	{if (BRPVP_eventsDataCodeIsOn select _forEachIndex isEqualTo 2) then {_missionsPos pushBack [_x select 0,200];};} forEach BRPVP_eventsData;
	_missionsPos
};
BRPVP_removeBigFloorObjectsRaidMission = {
	{
		private _isBigFloor = typeOf _x isEqualTo "" && {str _x find ": part_" > -1 && (getModelInfo _x select 1) find "\objects\part_" > -1};
		if (_isBigFloor) then {deleteVehicle _x;};
	} forEach nearestObjects [BRPVP_raidTrainingMapPosition,[],250,true];
};
BRPVP_removeBigFloorObjectsOriginItem = {
	params ["_oAGL","_bfId","_pId"];
	{
		private _o = _x;
		if (typeOf _o isEqualTo "" && {str _o find ": part_" > -1}) then {
			private _bfIdFe = _o getVariable ["brpvp_bf_bfid",-1];
			private _ownerFe = _o getVariable ["brpvp_bf_id",-1];
			if (_bfIdFe isEqualTo _bfId && _ownerFe isEqualTo _pId) then {deleteVehicle _o;};
		};
	} forEach nearestObjects [_oAGL,[],400];

	//SAVE PLAYER FROM FALL
	if (isNull objectParent player) then {
		private _pASL = getPosASL player;
		if (_pASL select 2 > 0) then {
			_pASL spawn {
				uiSleep 0.001;
				private _pASL = _this;
				private _lis = [_pASL,_pASL vectorAdd [0,0,-(_pASL select 2)-1],player,objNull,"GEOM","FIRE"] call BRPVP_lis;
				if (_lis isEqualTo []) then {player setPosASL AGLToASL [_pASL select 0,_pASL select 1,0];} else {player setPosASL (_lis select 0 select 0);};
			};
		};
	};
};
BRPVP_worldName = {
	((toUpper worldName select [0,1])+(toLower worldName select [1,count worldName-1]))
};
BRPVP_enableAI = {
	if (_this checkAIFeature "PATH") then {
		[_this,"ALL"] remoteExecCall ["enableAI",_this];
	} else {
		[_this,"ALL"] remoteExecCall ["enableAI",_this];
		[_this,"PATH"] remoteExecCall ["disableAI",_this];
	};
};
BRPVP_disableAI = {
	if (_this checkAIFeature "PATH") then {
		[_this,"ALL"] remoteExecCall ["disableAI",_this];
		[_this,"PATH"] remoteExecCall ["enableAI",_this];
	} else {
		[_this,"ALL"] remoteExecCall ["disableAI",_this];
	};
};
BRPVP_enableVehOnInteractionNoCheck = {
	params ["_veh","_timeOn"];
	private _isSimuVeh = _veh getVariable ["id_bd",-1] isNotEqualTo -1 || _veh getVariable ["brpvp_fedidex",false];
	if (_isSimuVeh) then {_veh setVariable ["brpvp_time_can_disable",serverTime+_timeOn,2];};
	[_veh,true] remoteEXecCall ["enableSimulationGlobal",2];
};
BRPVP_enableVehOnInteraction = {
	params ["_veh","_timeOn"];
	private _isSimuVeh = _veh getVariable ["id_bd",-1] isNotEqualTo -1 || _veh getVariable ["brpvp_fedidex",false];
	if (_isSimuVeh) then {_veh setVariable ["brpvp_time_can_disable",serverTime+_timeOn,2];};
	if (!simulationEnabled _veh) then {
		[_veh,true] remoteEXecCall ["enableSimulationGlobal",2];
	};
};
BRPVP_getLifesFixPermanentDamage = {
	private _veh = _this;
	private _lifesFix = _this getVariable ["brpvp_lifesfix",0];
	private _totalLife = if (_veh getVariable ["id_bd",-1] > -1) then {BRPVP_vehTotalLifeToFixDb} else {BRPVP_vehTotalLifeToFixNoDb};
	private _return = 0;
	if (_veh isKindOf "LandVehicle") then {
		((_lifesFix/_totalLife) min 1)*BRPVP_vehTotalLifeLimLand
	} else {
		if (_veh isKindOf "Helicopter") then {
			((_lifesFix/_totalLife) min 1)*BRPVP_vehTotalLifeLimHeli
		} else {
			if (_veh isKindOf "Plane") then {
				((_lifesFix/_totalLife) min 1)*BRPVP_vehTotalLifeLimPlane
			} else {
				if (_veh isKindOf "Ship") then {
					((_lifesFix/_totalLife) min 1)*BRPVP_vehTotalLifeLimShip
				} else {
					0
				};
			};
		};
	};
};
BRPVP_uberAttackRemoveAi = {
	private _bot = _this;
	private _kehId = _bot getVariable ["brpvp_uber_attack_killedeh",-1];
	private _tank = _bot getVariable ["brpvp_uber_attack_tank",objNull];
	if (!isNull _tank) then {detach _tank;deleteVehicle _tank;};
	if (_kehId isNotEqualTo -1) then {_bot removeEventHandler ["Killed",_kehId];};
	_bot setVariable ["brpvp_uber_attack",false,true];
};
BRPVP_possSetUnconscious = {
	params ["_unit","_type","_state"];
	if (_type isEqualTo "ai") then {
		if !(_unit getVariable ["brpvp_tai_dead",false]) then {_unit setUnconscious _state;};
	} else {
		if (_type isEqualTo "player") then {if (_unit call BRPVP_pAlive) then {_unit setUnconscious _state;};};
	};
};
BRPVP_checkIfCargo = {getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "maximumLoad") > 0 || getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "transportMaxMagazines") > 0};
BRPVP_desviraVeiculo = {
	params ["_car","_alt","_gSize","_player","_mid"];
	_bb = boundingBoxReal _car;
	_dx = abs((_bb select 0 select 0)-(_bb select 1 select 0));
	_dy = abs((_bb select 0 select 1)-(_bb select 1 select 1));
	_dz = abs((_bb select 0 select 2)-(_bb select 1 select 2));
	_hP = (getPosATL _player) vectorAdd [0,0,_dz+(_dx max _dy)/2+1.5];
	[_hP,_gSize] remoteExecCall  ["BRPVP_ganchoDesviraAdd",0];
	_gancho = createVehicle ["B_static_AA_F",_hP,[],0,"CAN_COLLIDE"];
	_gancho enableSimulation false;
	if (isServer) then {_gancho hideObjectGlobal true;} else {[_gancho,true] remoteExecCall ["hideObjectGlobal",2];};
	if (_car emptyPositions "" > 0) then {
		private _agnt = createAgent ["C_Driver_1_F",[0,0,0],[],20,"NONE"];
		[_agnt] remoteExecCall ["hideObjectGlobal",2];
		_agnt setBehaviour "COMBAT";
		_agnt disableAI "FSM";
		_agnt setCaptive true;
		_agnt allowDamage false;
		[_agnt,_car] spawn {
			params ["_agnt","_car"];
			uiSleep 0.001;
			_agnt moveInAny _car;
			uiSleep 2.5;
			moveOut _agnt;
			deleteVehicle _agnt;
		};
	};
	[_car,_gancho,_hP,_gSize,_alt,_mid] spawn {
		params ["_car","_gancho","_hP","_gSize","_alt","_mid"];
		uiSleep 1.75;
		_cP = getCenterOfMass _car vectorAdd [0,0.2,1];
		_leng = (_gancho modelToWorld [0,0,0]) distance (_car modelToWorld _cP);
		_ropus = ropeCreate [_gancho,[0,0,0],_car,_cP,_leng];
		_ropus allowDamage false;
		[[_ropus,1,-_leng,true]] remoteExecCall ["ropeUnwind",0];
		_ini = time;
		_startAngOk = acos ((vectorUp _car) vectorCos [0,0,1]) < 30;
		waitUntil {
			_ang = acos ((vectorUp _car) vectorCos [0,0,1]);
			(!_startAngOk && _ang < 30) || time-_ini > 0.8*_leng
		};
		[[_ropus,1,_leng,true]] remoteExecCall ["ropeUnwind",0];
		waitUntil {ropeUnwound _ropus || getPos _car select 2 < 0.25};
		_car ropeDetach _ropus;
		sleep 1;
		ropeDestroy _ropus;
		deleteVehicle _gancho;
		[_hP,_gSize] remoteExecCall ["BRPVP_ganchoDesviraRemove",0];
		true remoteExecCall ["BRPVP_checkCraneFinishedSet",_mid];
	};
};
BRPVP_fnc_dynamicTextDataId = [];
BRPVP_fnc_dynamicTextDataArray = [];
BRPVP_fnc_dynamicTextAllIds = [];
BRPVP_fnc_dynamicText = {
	private _tm = _this select 3;
	private _idOriginal = _this select 6;
	private _force = if (count _this > 7) then {_this select 7} else {false};
	private _id = 1;
	private _idIdx = BRPVP_fnc_dynamicTextAllIds find _idOriginal;
	if (_idIdx isEqualTo -1) then {
		BRPVP_fnc_dynamicTextAllIds pushBack _idOriginal;
		_id = count BRPVP_fnc_dynamicTextAllIds;
	} else {
		_id = _idIdx+1;
	};
	_this set [6,_id];
	if (BRPVP_allowBrpvpHint || _force) then {
		private _lMsg = if (_this select 1 isEqualType 0) then {_this} else {(_this select [0,1])+((_this select [1,2]) apply {call _x})+(_this select [3,4])};
		_lMsg spawn BIS_fnc_dynamicText;
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_this remoteExecCall ["BRPVP_fnc_dynamicTextSpec",BRPVP_specOnMeMachinesNoMe];};
		private _idx = BRPVP_fnc_dynamicTextDataId find _id;
		if (_idx isEqualTo -1) then {
			BRPVP_fnc_dynamicTextDataId pushBack _id;
			BRPVP_fnc_dynamicTextDataArray pushBack [serverTime,_tm,_tm,_this];
		} else {
			private _mtn = BRPVP_fnc_dynamicTextDataArray select _idx select 2;
			BRPVP_fnc_dynamicTextDataArray set [_idx,[serverTime,_tm,_tm max _mtn,_this]];
		};
	} else {
		private _idx = BRPVP_fnc_dynamicTextDataId find _id;
		private _mtn = if (_idx isEqualTo -1) then {_tm} else {BRPVP_fnc_dynamicTextDataArray select _idx select 2};
		if (_mtn > 36000) then {
			if (_idx isEqualTo -1) then {
				BRPVP_fnc_dynamicTextDataId pushBack _id;
				BRPVP_fnc_dynamicTextDataArray pushBack [serverTime,_tm,_tm,_this];
			} else {
				BRPVP_fnc_dynamicTextDataArray set [_idx,[serverTime,_tm,_tm max _mtn,_this]];
			};
		};
	};
};
BRPVP_fnc_dynamicTextSpec = {
	if (BRPVP_spectateOn) then {
		BRPVP_setSpectedDinaMsgsIds pushBackUnique (_this select 6);
		private _lMsg = if (_this select 1 isEqualType 0) then {_this} else {(_this select [0,1])+((_this select [1,2]) apply {call _x})+(_this select [3,4])};
		_lMsg spawn BIS_fnc_dynamicText;
	};
};
BRPVP_eventRepositioneObjectsAtEnd = {
	params ["_idx","_objs"];
	private _center = BRPVP_eventsData select _idx select 0;
	private _rad = BRPVP_eventsData select _idx select 1;
	waitUntil {uiSleep 0.25;{!isNull _x} count _objs isEqualTo 0};
	{
		private _pw = getPosASL _x;
		private _lis = lineIntersectsSurfaces [_pw,_pw vectorAdd [0,0,-500],_x,objNull];
		if (_lis isNotEqualTo []) then {
			private _newPw = (_lis select 0 select 0) vectorAdd [0,0,0.125];
			if (vectorMagnitude (_newPw vectorDiff _pw) > 0.5) then {
				if (_x isKindOf "CaManBase") then {
					if (isNull objectParent _x) then {if (alive _x) then {_x setPosASL _newPw;} else {[_x,""] remoteExecCall ["switchMove",0];};};
				} else {
					if (typeOf _x isEqualTo "GroundWeaponHolder" && (_x getVariable ["ml_takes",-1]) isNotEqualTo -1) then {deleteVehicle _x;} else {_x setPosASL _newPw;};
				};
			};
		};
	} forEach nearestObjects [_center,["WeaponHolderSimulated","GroundWeaponHolder","Land_Suitcase_F","CaManBase","ReammoBox_F","ThingX"],_rad];
};
BRPVP_pAlive = {
	(_this getVariable ["dd",[0,-1] select alive _this]) isEqualTo -1
};
BRPVP_exchangeUnitVisual = {
	params ["_from","_to"];
	waitUntil {_from distance _to < 0.25 || isNull _from};
	_to hideObject false;
	_from hideObject true;
};
BRPVP_isServiceVehicle = {getAmmoCargo _this >= 0 || getFuelCargo _this >= 0 || getRepairCargo _this >= 0};
BRPVP_angleBetweenSignal = {
	params ["_angleA","_angleB"];
	private _diff = _angleB-_angleA;
	if (_diff < -180) then {_angleB+360-_angleA} else {if (_diff > 180) then {_angleB-360-_angleA} else {_diff};};
};
BRPVP_applyForceLocal = {
	params ["_veh","_player"];

	//SET VEH LOCAL TO PLAYER IF POSSIBLE
	if (owner _veh isNotEqualTo owner _player) then {if (isNull currentPilot _veh) then {_veh setOwner (owner _player);};};

	if (!simulationEnabled _veh) then {
		_veh enableSimulationGlobal true;
		waitUntil {simulationEnabled _veh};
	};

	//APPLY FORCE
	_veh setVariable ["brpvp_time_can_disable",serverTime+15];
	private _com = _veh worldToModel ((_veh modelToWorld getCenterOfMass _veh) vectorAdd [0,0,10]);
	private _d = [_veh modelToWorld _com,_player] call BIS_fnc_dirTo;
	private _de = _d-getDir _veh;
	private _a = BRPVP_applyForceSize;
	private _b = BRPVP_applyForceSize/2;
	private _mass = getMass _veh;
	private _mult = _mass/500;
	private _mag = ((_a*_b)/sqrt((_a*sin _de)^2+(_b*cos _de)^2))*_mult;
	private _df = _d+180;
	private _force = [_mag*sin _df,_mag*cos _df,0];
	[_veh,[_force,_com]] remoteExecCall ["addForce",_veh];
	[_veh,["delivered",250]] remoteExecCall ["say3D",BRPVP_allNoServer];

	//CHECK IF CONTROLED AI TO SET UNCAPTIVE
	private _bots = crew _veh select {alive _x && _x getVariable ["id_bd",-1] isEqualTo -1 && _x getVariable ["brpvp_can_punch",true]};
	if (_bots isNotEqualTo []) then {_player remoteExecCall ["BRPVP_possessionPunchUncaptive",_bots select 0];};
};
BRPVP_possessionPunchUncaptive = {
	private _player = _this;
	private _poss = _player getVariable ["brpvp_possessed",-1];
	if (_poss isNotEqualTo -1) then {
		_player setVariable ["brpvp_possessed",_poss+1];
		if (_poss+1 >= 2) then {
			{BRPVP_possCaptive = false;} remoteExecCall ["BRPVP_possRemovePlayerCaptive",_player];
			"bush_reveal" remoteExecCall ["playSound",_player];
			_player spawn {uiSleep 1;{if (leader _x distance _this < 500) then {[_x,[_this,4]] remoteExecCall ["reveal",leader _x];};} forEach allGroups;};
		};
	};
};
BRPVP_applyForce = {
	params ["_veh","_zed"];
	if (!simulationEnabled _veh) then {_veh enableSimulationGlobal true;};
	_veh setVariable ["brpvp_time_can_disable",serverTime+10,2];
	private _com = _veh worldToModel ((_veh modelToWorld getCenterOfMass _veh) vectorAdd [0,0,10]);
	private _d = [_veh modelToWorld _com,_zed] call BIS_fnc_dirTo;
	private _de = _d-getDir _veh;
	private _a = BRPVP_applyForceSize;
	private _b = BRPVP_applyForceSize/2;
	private _mass = getMass _veh;
	private _mult = _mass/500;
	private _mag = ((_a*_b)/sqrt((_a*sin _de)^2+(_b*cos _de)^2))*_mult;
	private _df = _d+180;
	private _force = [_mag*sin _df,_mag*cos _df,0];
	[_veh,[_force,_com]] remoteExecCall ["addForce",_veh];
	[_veh,["delivered",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
};
BRPVP_atmOldActivatedAdd = {
	BRPVP_atmOldActivated pushBackUnique _this;
};
BRPVP_checkIfTurretIsFriendByFlag = {
	params ["_t","_p"];
	if (_t getVariable ["own",-1] > -1) then {
		private _flag = _t getVariable ["brpvp_tflag",objNull];
		if (isNull _flag) then {
			_flag = _t call BRPVP_nearestFlagInside;
			_t setVariable ["brpvp_tflag",_flag];
		};
		(_p getVariable ["id_bd",-1]) in (((_flag getVariable ["amg",[[],[],true]]) select 1)+[_flag getVariable ["own",-1]])
	} else {
		false
	};
};
BRPVP_addNewBigFloorEntry = {
	BRPVP_bigFloorsAll pushBack _this;
};
BRPVP_removeBigFloorEntry = {
	private _idx = -1;
	{if (_x select 0 isEqualTo _this) exitWith {_idx = _forEachIndex;};} forEach BRPVP_bigFloorsAll;
	if (_idx > -1) then {BRPVP_bigFloorsAll deleteAt _idx;};
};
BRPVP_bigFloorAddAllHc = {
	{_x call BRPVP_creatBigFloor200;} forEach _this;
};
BRPVP_creatBigFloor200 = {
	params ["_bfId","_pos","_igIdx","_owner"];
	private _objs = [];
	{
		private _pieceInfo = _x;
		if !(_forEachIndex in _igIdx) then {
			private _obj = createSimpleObject [(str missionConfigFile select [0,count str missionConfigFile-15])+"objects\"+(_pieceInfo select 0),[0,0,0],true];
			private _sn = _obj selectionNames "Memory";
			private _posNew = _pos vectorAdd (_pieceInfo select 1);
			_obj setDir (_pieceInfo select 2);
			_obj setPosWorld _posNew;
			if ("brpvp_center" in _sn) then {
				private _posMp = _obj modelToWorldworld (_obj selectionPosition "brpvp_center");
				private _diff = _posNew vectorDiff _posMp;
				_obj setPosWorld (_posNew vectorAdd _diff);
			};
			_objs pushBack _obj;
		};
	} forEach [
		//TOP
		["part_3_B.p3d",[-125,+175,0],+000],
		["part_4_A.p3d",[-075,+175,0],+000],
		["part_1_B.p3d",[-025,+175,0],+000],
		["part_1_A.p3d",[+025,+175,0],+000],
		["part_4_B.p3d",[+075,+175,0],+000],
		["part_3_A.p3d",[+125,+175,0],+000],

		//BOTTOM
		["part_3_B.p3d",[+125,-175,0],+180],
		["part_4_A.p3d",[+075,-175,0],+180],
		["part_1_B.p3d",[+025,-175,0],+180],
		["part_1_A.p3d",[-025,-175,0],+180],
		["part_4_B.p3d",[-075,-175,0],+180],
		["part_3_A.p3d",[-125,-175,0],+180],

		//LEFT
		["part_3_B.p3d",[-175,-125,0],-090],
		["part_4_A.p3d",[-175,-075,0],-090],
		["part_1_B.p3d",[-175,-025,0],-090],
		["part_1_A.p3d",[-175,+025,0],-090],
		["part_4_B.p3d",[-175,+075,0],-090],
		["part_3_A.p3d",[-175,+125,0],-090],

		//RIGHT
		["part_3_B.p3d",[+175,+125,0],+090],
		["part_4_A.p3d",[+175,+075,0],+090],
		["part_1_B.p3d",[+175,+025,0],+090],
		["part_1_A.p3d",[+175,-025,0],+090],
		["part_4_B.p3d",[+175,-075,0],+090],
		["part_3_A.p3d",[+175,-125,0],+090],

		//UNIQUE 1
		["part_2.p3d",[+125,+125,0],+000],
		["part_2.p3d",[-125,+125,0],-090],
		["part_2.p3d",[-125,-125,0],-180],
		["part_2.p3d",[+125,-125,0],-270],

		//UNIQUE 2
		["part_0.p3d",[-075,+125,0],+000],
		["part_0.p3d",[-025,+125,0],+000],
		["part_0.p3d",[+025,+125,0],+000],
		["part_0.p3d",[+075,+125,0],+000],

		["part_0.p3d",[-125,+075,0],+000],
		["part_0.p3d",[-075,+075,0],+000],
		["part_0.p3d",[-025,+075,0],+000],
		["part_0.p3d",[+025,+075,0],+000],
		["part_0.p3d",[+075,+075,0],+000],
		["part_0.p3d",[+125,+075,0],+000],

		["part_0.p3d",[-125,+025,0],+000],
		["part_0.p3d",[-075,+025,0],+000],
		["part_0.p3d",[-025,+025,0],+000],
		["part_0.p3d",[+025,+025,0],+000],
		["part_0.p3d",[+075,+025,0],+000],
		["part_0.p3d",[+125,+025,0],+000],

		["part_0.p3d",[-125,-025,0],+000],
		["part_0.p3d",[-075,-025,0],+000],
		["part_0.p3d",[-025,-025,0],+000],
		["part_0.p3d",[+025,-025,0],+000],
		["part_0.p3d",[+075,-025,0],+000],
		["part_0.p3d",[+125,-025,0],+000],

		["part_0.p3d",[-125,-075,0],+000],
		["part_0.p3d",[-075,-075,0],+000],
		["part_0.p3d",[-025,-075,0],+000],
		["part_0.p3d",[+025,-075,0],+000],
		["part_0.p3d",[+075,-075,0],+000],
		["part_0.p3d",[+125,-075,0],+000],

		["part_0.p3d",[-075,-125,0],+000],
		["part_0.p3d",[-025,-125,0],+000],
		["part_0.p3d",[+025,-125,0],+000],
		["part_0.p3d",[+075,-125,0],+000]
	];
	if (_owner isNotEqualTo -1) then {
		{
			_x setVariable ["brpvp_bf_id",_owner,true];
			_x setVariable ["brpvp_bf_bfid",_bfId,true];
		} forEach _objs;
	};
	_objs
};
BRPVP_lis = {
	params ["_p1","_p2",["_ig1",objNull],["_ig2",objNull],["_lodA","VIEW"],["_lodB","FIRE"]];
	private _lis1 = lineIntersectsSurfaces [_p1,_p2,_ig1,_ig2,true,1,_lodA,"NONE",true];
	private _lis2 = lineIntersectsSurfaces [_p1,_p2,_ig1,_ig2,true,1,_lodB,"NONE",true];
	if (_lis1 isEqualTo []) then {
		_lis2
	} else {
		if (_lis2 isEqualTo []) then {
			_lis1
		} else {
			private _d1 = vectorMagnitude ((_lis1 select 0 select 0) vectorDiff _p1);
			private _d2 = vectorMagnitude ((_lis2 select 0 select 0) vectorDiff _p1);
			if (_d1 <= _d2) then {_lis1} else {_lis2};
		};
	};
};
BRPVP_formatMenuConvert = {
	_string = _this;
	{_string = ([_string]+_x) call BRPVP_stringReplace;} forEach [["@memory_remove_back@",""],["@memory_remove_after@",""],["@yellow@","<t color='#FFFF00'>"],["@red@","<t color='#FF0000'>"],["@green@","<t color='#00FF00'>"],["@orange@","<t color='#FF8000'>"],["@tclose@","</t>"]];
	_string
};
BRPVP_craftCreatePath = {
	private _reqHave = [];
	private _reqMiss = [];
	private _reqMissBasic = [];
	private _price = 0;
	private _evoluted = true;
	{if (_x select 0 isEqualTo _this) exitWith {_reqMiss append (_x select 1);};} forEach BRPVP_crafts;
	private _path = [_this];
	BRPVP_autoCraftMySit = +(player getVariable "sit");
	private _paramsArray = ["_item","_q"];
	while {_reqMiss isNotEqualTo [] && _evoluted} do {
		private _reqMissNew = [];
		{
			_x params _paramsArray;
			private _have = _item call BRPVP_autoCraftSitCountItem;
			private _qUse = _have min _q;
			private _qMiss = _q-_qUse;
			if (_qUse > 0) then {
				_reqHave pushBack [_item,_qUse];
				[_item,_qUse] call BRPVP_autoCraftSitRemoveItem;
			};
			if (_qMiss > 0) then {
				private _found = false;
				{
					if (_x select 0 isEqualTo _item) exitWith {
						_reqMissNew append ((_x select 1) apply {[_x select 0,(_x select 1)*_qMiss]});
						for "_i" from 1 to _qMiss do {_path pushBack _item;};
						_price = _price+_qMiss*10000;
						_found = true;
					};
				} forEach BRPVP_crafts;
				if (!_found) then {_reqMissBasic pushBack [_item,_qMiss];};
			};
		} forEach _reqMiss;
		_evoluted = _reqMissNew isNotEqualTo _reqMiss;
		_reqMiss = _reqMissNew;
	};
	private _reqMissBasicItem = [];
	private _reqMissBasicQtt = [];
	{
		_x params _paramsArray;
		private _idx = _reqMissBasicItem find _item;
		if (_idx isEqualTo -1) then {
			_reqMissBasicItem pushBack _item;
			_reqMissBasicQtt pushBack _q;
		} else {
			_reqMissBasicQtt set [_idx,(_reqMissBasicQtt select _idx)+_q];
		};
	} forEach _reqMissBasic;
	_reqMissBasic = [];
	{_reqMissBasic pushBack [_x,_reqMissBasicQtt select _forEachIndex];} forEach _reqMissBasicItem;
	reverse _path;
	[_reqMissBasic isEqualTo [],_price,_reqMissBasic,_path]
};
BRPVP_autoCraftSitRemoveItem = {
	params ["_class","_q"];
	private _item = BRPVP_specialItems find _class;
	{
		if (_x select 0 isEqualTo _item) exitWith {
			(BRPVP_autoCraftMySit select _forEachIndex) set [1,(BRPVP_autoCraftMySit select _forEachIndex select 1)-_q];
		};
	} forEach BRPVP_autoCraftMySit;
};
BRPVP_autoCraftSitCountItem = {
	private _id = BRPVP_specialItems find _this;
	private _found = 0;
	{if (_x select 0 isEqualTo _id) exitWith {_found = _x select 1;};} forEach BRPVP_autoCraftMySit;
	_found
};
BRPVP_setC4EffectOnServerOrHC = {
	params ["_objs"];
	{
		private _obj = _x;
		if (!isNull _obj) then {
			private _ctd = _obj getVariable "brpvp_c4_to_destroy";
			_obj setVariable ["brpvp_c4_to_destroy",_ctd-1,true];
			if (_ctd-1 isEqualTo 0) then {
				private _minBombs = _obj getVariable  ["brpvp_c4_min_bomb",5];
				private _radioRad = _obj getVariable ["brpvp_c4_radio",0];
				private _pw = getPosWorld _obj;
				private _reward = _obj getVariable ["brpvp_c4_money",0];
				
				[_obj,_pw,_reward,_radioRad,_minBombs] spawn {
					params ["_obj","_pw","_reward","_radioRad","_minBombs"];
					private _init = diag_tickTime;
					
					//PLAY SPECIAL EXPLOSION
					_sound = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],10,"CAN_COLLIDE"];
					_sound allowDamage false;
					_sound setPosWorld _pw;
					[_sound,["c4_destroy",2500]] remoteExecCall ["say3D",BRPVP_allNoServer];

					//MAKE MULTIPLE EXPLOSIONS
					private _bb = boundingBoxReal _obj;
					private _bp1 = _bb select 0;
					private _bp2 = _bb select 1;
					private _sizeX = abs((_bp2 select 0)-(_bp1 select 0));
					private _sizeY = abs((_bp2 select 1)-(_bp1 select 1));
					private _sizeZ = abs((_bp2 select 2)-(_bp1 select 2));
					private _XYSize = _sizeX*_sizeY;
					private _XZSize = _sizeX*_sizeZ;
					private _YZSize = _sizeY*_sizeZ;
					private _sides = [_YZSize,_XZSize,_XYSize];
					private _halfArea = _YZSize+_XZSize+_XYSize;
					private _qtt = ceil (_sizeX*_sizeY*_sizeZ/12^3) max _minBombs min 30;
					for "_i" from 1 to _qtt do {
						private _randVec = [random _sizeX,random _sizeY,random _sizeZ];
						private _random = random _halfArea;
						private _sum = 0;
						{
							_sum = _sum+_x;
							if (_random < _sum) exitWith {_randVec set [_forEachIndex,([_sizeX,_sizeY,_sizeZ] select _forEachIndex)*selectRandom [0,1]];};
						} forEach _sides;
						private _posBomb = ASLToATL AGLToASL (_obj modelToWorld (_bp1 vectorAdd _randVec));
						private _lis = lineIntersectsSurfaces [ATLToASL _posBomb,getPosWorld _obj];
						if (_lis isNotEqualTo []) then {_posBomb = ASLToATL (_lis select 0 select 0);};
						createVehicle ["HelicopterExploBig",_posBomb,[],0,"CAN_COLLIDE"] setPosATL _posBomb;
						uiSleep random 0.25;
					};
					[_obj,true] remoteExecCall ["hideObjectGlobal",2];
					waitUntil {isObjectHidden _obj;};
					uiSleep 0.5;
					
					//CREATE REWARD
					if (_reward > 0) then {
						private _sc = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
						_sc setVariable ["mny",round (_reward*BRPVP_missionValueMult),true];
						_sc setPosASL getPosWorld _obj;
					};
					
					//REPOSITIONE OBJECTS OVER BUILDING
					private _bb = boundingBoxReal _obj;
					private _so = vectorMagnitude ((_bb select 0) vectorDiff (_bb select 1));
					[ASLToAGL _pw,_so*0.75] call BRPVP_wakeUpObjectsFlying;

					//ADD RADIO AREA
					if (_radioRad > 0) then {
						private _key = "EXTRA_RADIO_"+str round random 1000000;
						[ASLToAGL _pw,_radioRad,_key,8,0.5,[],0] remoteExecCall ["BRPVP_radioAreasAddArea",0];
					};

					waitUntil {diag_tickTime-_init > 10};
					_sound setDamage 1;
					detach _sound;
					deleteVehicle _sound;
				};
			};
		};
	} forEach _objs;
};
BRPVP_pmissAddExplodeIcon = {
	_wrd = getPosWorld _this;
	_lis = lineIntersectsSurfaces [_wrd vectorAdd [0,0,50],_wrd];
	if (count _lis > 0) then {
		_top = ASLToAGL (_lis select 0 select 0) vectorAdd [0,0,8];
		_this setVariable ["brpvp_explode_icon",_top,true];
		_this setVariable ["brpvp_explode_icon_smult",0.5,true];

		BRPVP_c4ToExplode = BRPVP_c4ToExplode-[objNull];
		BRPVP_c4ToExplode pushBack _this;
		publicVariable "BRPVP_c4ToExplode";
	};
};
BRPVP_wakeUpObjectsFlying = {
	params ["_posAGL","_so"];
	if (_so isEqualTo 0) then {_so = 25;};
	{
		private _pw = getPosWorld _x;
		private _lis = [_pw vectorAdd [0,0,1.5],_pw vectorAdd [0,0,-300],_x,objNull,"GEOM","FIRE"] call BRPVP_lis;
		if (_lis isNotEqualTo []) then {
			private _pw2 = _lis select 0 select 0;
			if (vectorMagnitude (_pw2 vectorDiff _pw) > 0.5) then {_x setPosASL (_pw2 vectorAdd [0,0,0.15]);};
		};
	} forEach nearestObjects [_posAGL,["WeaponHolderSimulated","GroundWeaponHolder","ReammoBox_F","ThingX"],_so];
	{
		if (!alive _x) then {
			private _pw = getPosASL _x;
			private _lis = [_pw vectorAdd [0,0,1.5],_pw vectorAdd [0,0,-300],_x,objNull,"GEOM","FIRE"] call BRPVP_lis;
			if (_lis isNotEqualTo []) then {
				private _pw2 = _lis select 0 select 0;
				if (vectorMagnitude (_pw2 vectorDiff _pw) > 0.5) then {[_x,_pw2 vectorAdd [0,0,0.025]] remoteExecCall ["setPosASL",0];};
			};
		};
	} forEach nearestObjects [_posAGL,["CaManBase"],_so];
	{
		if (!simulationEnabled _x) then {[_x,true] remoteExecCall ["enableSimulationGlobal",2];};
		_x setVariable ["brpvp_time_can_disable",serverTime+10,2];
	} forEach (_posAGL nearEntities [["Motorcycle","Car","Tank","Air","Ship"],_so]);
};
BRPVP_getCargoArrayMagnet = {
	private _isInv1 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "maximumLoad") > 0;
	private _isInv2 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "transportMaxMagazines") > 0;
	if (alive _this && (_isInv1 || _isInv2)) then {
		private ["_we","_gear","_idx","_magasFinal","_magasSmall","_magasSmallCount","_checkRemove","_armas","_magas","_mochi","_itens","_conts","_weaponsItemsCargo","_weaponsItemsCargoQ","_check"];
		_conts = everyContainer _this;
		_check = [];
		_checkRemove = [];
		_conts = _conts apply {
			if (_x select 1 in _check) then {
				_checkRemove pushBack (_x select 0);
				-1
			} else {
				_check pushBack (_x select 1);
				_x
			};
		};
		_conts = _conts-[-1];
		_gear = [];
		private _paramsArray = ["_name","_c"];
		{
			_x params _paramsArray;
			_magas = magazinesAmmoCargo _c;
			_mochi = getBackpackCargo _c;
			_itens = getItemCargo _c;
			_weaponsItemsCargo = weaponsItemsCargo _c;
			if (_forEachIndex isEqualTo 0) then {
				{
					_idx = (_mochi select 0) find _x;
					if (_idx != -1) then {
						_quantity = _mochi select 1 select _idx;
						if (_quantity isEqualTo 1) then {
							(_mochi select 0) deleteAt _idx;
							(_mochi select 1) deleteAt _idx;
						} else {
							(_mochi select 1) set [_idx,_quantity-1];
						};
					};
				} forEach _checkRemove;
			};
			{
				_feiA = _forEachIndex;
				{
					_feiB = _forEachIndex;
					if (_feiB isEqualTo 0) then {
						_baseWeapon = _x call BIS_fnc_baseWeapon;
						_weaponsItemsCargo select _feiA set [_feiB,_baseWeapon];
					} else {
						if (_x isEqualType [] && !(_x isEqualTo [])) then {
							private ["_i"];
							_weaponsItemsCargo select _feiA set [_feiB,_x];
						};
						if (_x isEqualType "") then {
							private ["_i"];
							_weaponsItemsCargo select _feiA set [_feiB,_x];
						};
					};
				} forEach _x;
			} forEach _weaponsItemsCargo;

			_weaponsItemsCargoQ = [];
			{
				_idx = -1;
				_we = _x;
				{if ((_x select 0) isEqualTo _we) exitWith {_idx = _forEachIndex;};} forEach _weaponsItemsCargoQ;
				if (_idx isEqualTo -1) then {
					_weaponsItemsCargoQ pushBack [_x,1];
				} else {
					(_weaponsItemsCargoQ select _idx) set [1,(_weaponsItemsCargoQ select _idx select 1)+1];
				};
			} forEach _weaponsItemsCargo;

			_magasSmall = [];
			_magasSmallCount = [];
			{
				_idx = _magasSmall find _x;
				if (_idx isEqualTo -1) then {
					_magasSmall pushBack _x;
					_magasSmallCount pushBack 1;
				} else {
					_magasSmallCount set [_idx,(_magasSmallCount select _idx)+1];
				};
			} forEach _magas;
			_magasFinal = [];
			{_magasFinal pushBack [_x select 0,_magasSmallCount select _forEachIndex,_x select 1];} forEach _magasSmall;
			_gear pushBack [_name,[_weaponsItemsCargoQ,_magasFinal,_itens,_mochi]];
		} forEAch ([["brpvp_main_container",_this]]+_conts);
		[3,_gear]
	} else {
		[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]]
	};
};
BRPVP_putItemsOnCargoMagnet = {
	params ["_vehicle","_inventory"];
	private ["_e","_c","_mag"];
	private _fClass = BRPVP_moneyItems select 0;
	private _contsBegin = everyContainer _vehicle apply {_x select 1};
	_conts = [];
	private _paramsArray1 = ["_name","_gear"];
	{
		_x params _paramsArray1;
		_c = if (_forEachIndex isEqualTo 0) then {
			_vehicle
		} else {
			{
				if ((_x select 0) isEqualTo _name) exitWith {
					_return = _x select 1;
					_conts deleteAt _forEachIndex;
					_return
				};
			} forEach _conts;
		};
		private _paramsArray2 = ["_wepData","_q"];
		{
			_x params _paramsArray2;
			_e = [];
			{
				if (_forEachIndex isEqualTo 0) then {
					_e pushBack _x;
				} else {
					if (_x isEqualType []) then {
						if (_x isEqualTo []) then {
							_e pushBack [];
						} else {
							_mag = _x select 0;
							_e pushBack [_mag,_x select 1];
						};
					} else {
						_e pushBack _x;
					};
				};
			} forEach _wepData;
			_c addWeaponWithAttachmentsCargoGlobal [_e,_q];
		} forEach (_gear select 0);
		{
			private _class = _x select 0;
			if (count _x isEqualTo 2) then {_c addMagazineAmmoCargo [_class,1,_x select 1];} else {_c addMagazineAmmoCargo [_class,_x select 1,_x select 2];};
		} forEach (_gear select 1);
		{_c addItemCargoGlobal [_x,_gear select 2 select 1 select _forEachIndex];} forEach (_gear select 2 select 0);
		{_c addBackpackCargoGlobal [_x,_gear select 3 select 1 select _forEachIndex];} forEach (_gear select 3 select 0);
		if (_forEachIndex isEqualTo 0) then {
			_conts = everyContainer _vehicle apply {if ((_x select 1) in _contsBegin) then {-1} else {_x};};
			_conts = _conts-[-1];
			{
				private ["_ci"];
				_ci = _x select 1;
				_ci call BRPVP_emptyBox;
			} forEach _conts;
		};
	} forEach (_inventory select 1);
};
BRPVP_splitCargoArrayMany = {
	params ["_mWh","_limit"];
	private _greater = [_mwh call BRPVP_getCargoArrayMagnet];
	private _iMass = _mWh call BRPVP_getContainerMass;
	private _pow = 0;
	while {_iMass > _limit} do {_iMass = _iMass/2;_pow = _pow+1;};
	for "_i" from 1 to (_pow min 4) do {
		private _newG = [];
		{_newG append (_x call BRPVP_splitCargoArray);} forEach _greater;
		_greater = +_newG;
	};
	private _result = [];	
	{
		private _wh = createVehicle ["GroundWeaponHolder",[0,0,0],[],100,"CAN_COLLIDE"];
		[_wh,_x] call BRPVP_putItemsOnCargoMagnet;
		_result pushBack _wh;
	} forEach _greater;
	_result
};
BRPVP_splitCargoArray = {
	private _array = _this;
	private _a1 = +_array;
	private _a2 = +_array;
	private _cc = (_array select 1) apply {_x select 0};
	_cc = _cc arrayIntersect _cc;
	private _a1I = _cc apply {0};
	private _a2I = _cc apply {0};
	{
		private _cont = _x;
		private _contIdx = _forEachIndex;
		private _contClass = _cont select 0;
		if (_contIdx isEqualTo 0) then {
			call BRPVP_splitCargoArrayA1A2;
		} else {
			private _idx = _cc find _contClass;
			if (_a1I select _idx > 0) then {
				_a1 call BRPVP_splitCargoArrayAX;
				_a1I set [_idx,(_a1I select _idx)-1];
				(_a2 select 1) set [_contIdx,-1];
			} else {
				if (_a2I select _idx > 0) then {
					_a2 call BRPVP_splitCargoArrayAX;
					_a2I set [_idx,(_a2I select _idx)-1];
					(_a1 select 1) set [_contIdx,-1];
				};
			};
		};
	} forEach (_array select 1);
	_a1 set [1,(_a1 select 1)-[-1]];
	_a2 set [1,(_a2 select 1)-[-1]];
	[_a1,_a2]
};
BRPVP_splitCargoArrayA1A2 = {
	private _bo = true;
	//WEAPONS
	_a1 select 1 select _contIdx select 1 set [0,[]];
	_a2 select 1 select _contIdx select 1 set [0,[]];
	private _a1C = 0;
	private _a2C = 0;
	{
		private _wep = _x;
		if (_bo) then {
			_a1C = ceil ((_wep select 1)/2);
			_a2C = (_wep select 1)-_a1C;
		} else {
			_a2C = ceil ((_wep select 1)/2);
			_a1C = (_wep select 1)-_a2C;
		};
		_bo = !_bo;
		(_a1 select 1 select _contIdx select 1 select 0) pushBack [_wep select 0,_a1C];
		if (_a2C > 0) then {(_a2 select 1 select _contIdx select 1 select 0) pushBack [_wep select 0,_a2C];};
	} forEach (_cont select 1 select 0);

	//MAGAZINES
	_a1 select 1 select _contIdx select 1 set [1,[]];
	_a2 select 1 select _contIdx select 1 set [1,[]];
	{
		private _mag = _x;
		if (_bo) then {
			_a1C = ceil ((_mag select 1)/2);
			_a2C = (_mag select 1)-_a1C;
		} else {
			_a2C = ceil ((_mag select 1)/2);
			_a1C = (_mag select 1)-_a2C;
		};		
		_bo = !_bo;
		(_a1 select 1 select _contIdx select 1 select 1) pushBack [_mag select 0,_a1C,_mag select 2];
		if (_a2C > 0) then {(_a2 select 1 select _contIdx select 1 select 1) pushBack [_mag select 0,_a2C,_mag select 2];};
	} forEach (_cont select 1 select 1);

	//DOUBLE 1
	_a1 select 1 select _contIdx select 1 set [2,[[],[]]];
	_a2 select 1 select _contIdx select 1 set [2,[[],[]]];
	{
		private _item = _x;
		private _itemQ = _array select 1 select _contIdx select 1 select 2 select 1 select _forEachIndex;
		if (_bo) then {
			_a1C = ceil (_itemQ/2);
			_a2C = _itemQ-_a1C;
		} else {
			_a2C = ceil (_itemQ/2);
			_a1C = _itemQ-_a2C;
		};
		_bo = !_bo;
		(_a1 select 1 select _contIdx select 1 select 2 select 0) pushBack _item;
		(_a1 select 1 select _contIdx select 1 select 2 select 1) pushBack _a1C;
		if (_item in _cc) then {_a1I set [_cc find _item,_a1C];};
		if (_a2C > 0) then {
			(_a2 select 1 select _contIdx select 1 select 2 select 0) pushBack _item;
			(_a2 select 1 select _contIdx select 1 select 2 select 1) pushBack _a2C;
			if (_item in _cc) then {_a2I set [_cc find _item,_a2C];};
		};
	} forEach (_cont select 1 select 2 select 0);

	//DOUBLE 2
	_a1 select 1 select _contIdx select 1 set [3,[[],[]]];
	_a2 select 1 select _contIdx select 1 set [3,[[],[]]];
	{
		private _item = _x;
		private _itemQ = _array select 1 select _contIdx select 1 select 3 select 1 select _forEachIndex;
		if (_bo) then {
			_a1C = ceil (_itemQ/2);
			_a2C = _itemQ-_a1C;
		} else {
			_a2C = ceil (_itemQ/2);
			_a1C = _itemQ-_a2C;
		};
		_bo = !_bo;
		(_a1 select 1 select _contIdx select 1 select 3 select 0) pushBack _item;
		(_a1 select 1 select _contIdx select 1 select 3 select 1) pushBack _a1C;
		if (_item in _cc) then {_a1I set [_cc find _item,_a1C];};
		if (_a2C > 0) then {
			(_a2 select 1 select _contIdx select 1 select 3 select 0) pushBack _item;
			(_a2 select 1 select _contIdx select 1 select 3 select 1) pushBack _a2C;
			if (_item in _cc) then {_a2I set [_cc find _item,_a2C];};
		};
	} forEach (_cont select 1 select 3 select 0);
};
BRPVP_splitCargoArrayAX = {
	//WEAPONS
	_this select 1 select _contIdx select 1 set [0,[]];
	{(_this select 1 select _contIdx select 1 select 0) pushBack _x;} forEach (_cont select 1 select 0);

	//MAGAZINES
	_this select 1 select _contIdx select 1 set [1,[]];
	{(_this select 1 select _contIdx select 1 select 1) pushBack _x;} forEach (_cont select 1 select 1);

	//DOUBLE 1
	_this select 1 select _contIdx select 1 set [2,[[],[]]];
	{
		private _item = _x;
		private _itemQ = _array select 1 select _contIdx select 1 select 2 select 1 select _forEachIndex;
		(_this select 1 select _contIdx select 1 select 2 select 0) pushBack _item;
		(_this select 1 select _contIdx select 1 select 2 select 1) pushBack _itemQ;
	} forEach (_cont select 1 select 2 select 0);

	//DOUBLE 2
	_this select 1 select _contIdx select 1 set [3,[[],[]]];
	{
		private _item = _x;
		private _itemQ = _array select 1 select _contIdx select 1 select 3 select 1 select _forEachIndex;
		(_this select 1 select _contIdx select 1 select 3 select 0) pushBack _item;
		(_this select 1 select _contIdx select 1 select 3 select 1) pushBack _itemQ;
	} forEach (_cont select 1 select 3 select 0);
};
BRPVP_getContainerMass = {
	private _cont = _this;
	private _massAllNumber = 0;
	private _eCont = [];
	private _eContClass = [];
	{
		_eCont pushBack (_x select 1);
		_eContClass pushBack (_x select 0);
	} forEach everyContainer _cont;
	{
		_x params ["_items","_qts"];
		{
			private ["_cfg"];
			private _item = _x;
			if !(_item in _eContClass) then {
				private _qt = _qts select _forEachIndex;
				if (isClass (configFile >> "CfgWeapons" >> _item)) then {_cfg = "CfgWeapons"};
				if (isClass (configFile >> "CfgVehicles" >> _item)) then {_cfg = "CfgVehicles"};
				if (isClass (configFile >> "CfgMagazines" >> _item)) then {_cfg = "CfgMagazines"};
				if (isClass (configFile >> "CfgGlasses" >> _item)) then {_cfg = "CfgGlasses"};
				private _mass = getNumber (configFile >> _cfg >> _item >> "ItemInfo" >> "mass");
				if (_mass isEqualTo 0) then {_mass = getNumber (configFile >> _cfg >> _item >> "mass");};
				if (_mass isEqualTo 0) then {_mass = getNumber (configFile >> _cfg >> _item >> "WeaponSlotsInfo" >> "mass");};
				_massAllNumber = _massAllNumber+(_mass*_qt);
			};
		} forEach _items;
	} forEach [getItemCargo _cont,getMagazineCargo _cont,getWeaponCargo _cont];
	{_massAllNumber = _massAllNumber+([_eContClass select _forEachIndex,_x] call BRPVP_getInnerContainerMass);} forEach _eCont;
	_massAllNumber
};
BRPVP_getInnerContainerMass = {
	params ["_class","_cont"];
	private _massAllNumber = 0;
	{
		_x params ["_items","_qts"];
		private _mult = if (_forEachIndex isEqualTo 0) then {1} else {2};
		{
			private ["_cfg"];
			private _item = _x;
			private _qt = _qts select _forEachIndex;
			if (isClass (configFile >> "CfgWeapons" >> _item)) then {_cfg = "CfgWeapons"};
			if (isClass (configFile >> "CfgVehicles" >> _item)) then {_cfg = "CfgVehicles"};
			if (isClass (configFile >> "CfgMagazines" >> _item)) then {_cfg = "CfgMagazines"};
			if (isClass (configFile >> "CfgGlasses" >> _item)) then {_cfg = "CfgGlasses"};
			private _mass = getNumber (configFile >> _cfg >> _item >> "ItemInfo" >> "mass");
			if (_mass isEqualTo 0) then {_mass = getNumber (configFile >> _cfg >> _item >> "mass");};
			if (_mass isEqualTo 0) then {_mass = getNumber (configFile >> _cfg >> _item >> "WeaponSlotsInfo" >> "mass");};
			_massAllNumber = _massAllNumber+(_mass*_qt*_mult);
		} forEach _items;
	} forEach [[[_class],[1]],getItemCargo _cont,getMagazineCargo _cont,getWeaponCargo _cont];
	_massAllNumber
};
BRPVP_itemMagnetRecharge = {
	private _objs = _this getVariable "brpvp_carry_objs";
	private _pDir = getDir player;
	{
		private _iDir = _pDir+135+random (360-270);
		private _vec = [0.65*sin _iDir,0.65*cos _iDir,0.6+random 1];
		_x attachTo [player,player vectorWorldToModel _vec];
		_x setDir random 360;
	} forEach _objs;
	[player,["spark",400]] remoteExecCall ["say3D",BRPVP_allNoServer];
};
//BRPVP_itemMagnetOff**Server** BELLOW BRPVP_itemMagnetOff
BRPVP_itemMagnetOff = {
	private _objs = _this getVariable "brpvp_carry_objs";
	_objs = _objs-[objNull];
	private _nObjs = [];
	private _sumMass = 0;
	private _sumWh = [];
	_this setVariable ["brpvp_carry_objs",[],[clientOwner,2]];
	_objs = _objs apply {[_x call BRPVP_getContainerMass,_x]};
	_objs sort true;
	BRPVP_itemMagnetOn = false;
	{
		_sumMass = _sumMass+(_x select 0);
		if (_sumMass <= BRPVP_magnetHolderCargoLimitOnGround) then {
			_sumWh pushBack (_x select 1);
		} else {
			private _one = _sumWh deleteAt 0;
			{[_one,_x call BRPVP_getCargoArrayMagnet] call BRPVP_putItemsOnCargoMagnet;} forEach _sumWh;
			{detach _x;deleteVehicle _x;} forEach _sumWh;
			_nObjs pushBack _one;
			_sumWh = [_x select 1];
			_sumMass = _x select 0;
		};
	} forEach _objs;
	if (count _sumWh > 0) then {
		private _one = _sumWh deleteAt 0;
		{[_one,_x call BRPVP_getCargoArrayMagnet] call BRPVP_putItemsOnCargoMagnet;} forEach _sumWh;
		{detach _x;deleteVehicle _x;} forEach _sumWh;
		_nObjs pushBack _one;
	};
	{
		private _lis = lineIntersectsSurfaces [getPosWorld _x,getPosWorld _x vectorAdd [0,0,-1000],_this,_x,true,-1];
		if (_lis isEqualTo []) then {
			detach _x;
		} else {
			private _found = [];
			private _cases = ["GroundWeaponHolder","WeaponHolderSimulated","CaManBase","LandVehicle","Air","Ship"];
			{
				private _lisLine = _x;
				if ({_lisLine select 2 isKindOf _x} count _cases isEqualTo 0) exitWith {_found = _x select 0;};
			} forEach _lis;
			if (_found isEqualTo []) then {
				private _found = getPosWorld _this;
				_found set [2,0];
				_found = AGLToASL _found;
			};
			_x attachTo [_this,_this worldToModel ASLToAGL (_found vectorAdd [0,0,0.7])];
			detach _x;
		};
		[_this,["magnet",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
		uiSleep 0.001;
	} forEach _nObjs;
	BRPVP_itemMagnetAllMass = 0;
	_this removeAction BRPVP_itemMagnetOnAction1;
	_this removeAction BRPVP_itemMagnetOnAction2;
	BRPVP_itemMagnetOnAction1 = -1;
	BRPVP_itemMagnetOnAction2 = -1;
};
BRPVP_itemMagnetOffServer = {
	private _objs = _this getVariable "brpvp_carry_objs";
	_objs = _objs-[objNull];
	private _nObjs = [];
	private _sumMass = 0;
	private _sumWh = [];
	_this setVariable ["brpvp_carry_objs",[],[clientOwner,2]];
	_objs = _objs apply {[_x call BRPVP_getContainerMass,_x]};
	_objs sort true;
	{
		_sumMass = _sumMass+(_x select 0);
		if (_sumMass <= BRPVP_magnetHolderCargoLimitOnGround) then {
			_sumWh pushBack (_x select 1);
		} else {
			private _one = _sumWh deleteAt 0;
			{[_one,_x call BRPVP_getCargoArrayMagnet] call BRPVP_putItemsOnCargoMagnet;} forEach _sumWh;
			{detach _x;deleteVehicle _x;} forEach _sumWh;
			_nObjs pushBack _one;
			_sumWh = [_x select 1];
			_sumMass = _x select 0;
		};
	} forEach _objs;
	if (count _sumWh > 0) then {
		private _one = _sumWh deleteAt 0;
		{[_one,_x call BRPVP_getCargoArrayMagnet] call BRPVP_putItemsOnCargoMagnet;} forEach _sumWh;
		{detach _x;deleteVehicle _x;} forEach _sumWh;
		_nObjs pushBack _one;
	};
	{
		private _lis = lineIntersectsSurfaces [getPosWorld _x,getPosWorld _x vectorAdd [0,0,-1000],_this,_x,true,-1];
		if (_lis isEqualTo []) then {
			detach _x;
		} else {
			private _found = [];
			private _cases = ["GroundWeaponHolder","WeaponHolderSimulated","CaManBase","LandVehicle","Air","Ship"];
			{
				private _lisLine = _x;
				if ({_lisLine select 2 isKindOf _x} count _cases isEqualTo 0) exitWith {_found = _x select 0;};
			} forEach _lis;
			if (_found isEqualTo []) then {
				private _found = getPosWorld _this;
				_found set [2,0];
				_found = AGLToASL _found;
			};
			_x attachTo [_this,_this worldToModel ASLToAGL (_found vectorAdd [0,0,0.7])];
			detach _x;
		};
		[_this,["magnet",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
		uiSleep 0.001;
	} forEach _nObjs;
};
BRPVP_setHitpointsDamage = {
	params ["_veh","_life"];
	_life params ["_mainDam","_hitDam"];
	_veh setDamage _mainDam;
	if (_hitDam isNotEqualTo []) then {{_veh setHitIndex [_forEachIndex,_x];} forEach (_hitDam select 1);};
};
BRPVP_getHitpointsDamage = {
	private _hpd = getAllHitPointsDamage _this;
	[damage _this,if (count _hpd isEqualTo 3) then {_hpd select [1,2]} else {[[],[]]}]
};
BRPVP_getHitpointsDamageFullLife = {
	private _hpd = getAllHitPointsDamage _this;
	[0,if (count _hpd isEqualTo 3) then {[_hpd select 1,(_hpd select 2) apply {0}]} else {[[],[]]}]
};
BRPVP_formatData = {
	private _year = str (_this select 0);
	private _month = str (_this select 1);
	private _day = str (_this select 2);
	if (count _month isEqualTo 1) then {_month = "0"+_month;};
	if (count _day isEqualTo 1) then {_day = "0"+_day;};
	format ["%1/%2/%3",_year,_month,_day]
};
BRPVP_classAdVehicleSpawnHC = {
	params ["_player","_resultado"];
	_resultadoCompilado = parseSimpleArray _resultado select 1 select 0;
	_modelo = _resultadoCompilado select 4;
	_veiculoId = _resultadoCompilado select 0;
	_carga = _resultadoCompilado select 2;
	_owner = _resultadoCompilado select 5;
	_comp = _resultadoCompilado select 6;
	_amigos = _resultadoCompilado select 7;
	_exec = _resultadoCompilado select 9;
	_lock = _resultadoCompilado select 10;
	_paint = _resultadoCompilado select 13;
	_cover = _resultadoCompilado select 14;
	_ammo = _resultadoCompilado select 15;
	_life = _resultadoCompilado select 16;
	_pAmgDb = _resultadoCompilado select 17;
	_lifesFix = _resultadoCompilado select 18;

	_isDrone = _modelo in BRPVP_vantVehiclesClass;
	_best = (ASLToAGL getPosASL _player) findEmptyPosition [30,100,_modelo];
	_best = _best vectorAdd [0,0,0.5];
	_veiculo = createVehicle [_modelo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
	_veiculo call BRPVP_setVehRadarAndThermal;
	_veiculo setPosASL AGLToASL _best;
	[_veiculo,[0,0,0]] remoteExecCall ["setVelocity",0];
	_veiculo setDir ([_best,_player] call BIS_fnc_dirTo);
	if (_modelo isEqualTo "B_UAV_05_F") then {
		_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
		{_veiculo animateSource [_x,1,true];} forEach _wingAnimations;
	};
	if (_isDrone) then {
		//createVehicleCrew _veiculo;
		if (BRPVP_dronesMakeAllUnarmed) then {
			{
				_veiculo setPylonLoadout [configName _x,""];
			} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _veiculo >> "Components" >> "TransportPylonsComponent" >> "pylons"));
		};
		_veiculo setVariable ["brpvp_auto_first",true,true];
	} else {
		_veiculo setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
	};
	_veiculo setVariable ["id_bd",_veiculoId,true];
	if (_player getVariable ["id_bd",-1] isEqualTo _owner && _owner isNotEqualTo -1) then {
		_veiculo setVariable ["own",_owner,true];
		_veiculo setVariable ["stp",_comp,true];
		_veiculo setVariable ["amg",_amigos,true];
	} else {
		_veiculo setVariable ["own",_player getVariable ["id_bd",-1],true];
		_veiculo setVariable ["stp",_player getVariable ["dstp",1],true];
		_veiculo setVariable ["amg",[_player getVariable ["amg",[]],[],true],true];
	};
	_veiculo remoteExecCall ["BRPVP_veiculoEhReset",2];
	[_veiculo,_carga] call BRPVP_putItemsOnCargo;
	if (_exec != "") then {_veiculo call compile _exec;};
	_veiculo setVariable ["brpvp_locked",true,true];
	_veiculo setVariable ["slv",true];
	//_veiculo setVariable ["brpvp_from_vg_time",serverTime+_vgTime,true];

	//PAINT VEHICLE
	if !(_paint isEqualTo []) then {
		{_veiculo setObjectTextureGlobal [_forEachIndex,_x];} forEach _paint;
		_veiculo setVariable ["brpvp_paint_enabled",true,true];
	};

	//VEHICLE COVER
	if !(_cover isEqualTo []) then {[_veiculo,false,_cover,false] remoteExecCall ["BIS_fnc_initVehicle",_veiculo];};

	//SET VEHICLE LIFE
	[_veiculo,_life] call BRPVP_setVehicleDamage;

	//SET AMMO
	[_veiculo,_ammo] call BRPVP_setVehicleAmmo;

	_veiculo setVariable ["brpvp_time_can_disable",serverTime+5,2];
	_veiculo call BRPVP_setVehServicesToZero;

	_veiculo setVariable ["brpvp_coll_prot",true];
	_veiculo lock true;

	//SET LIFESFIX
	_veiculo setVariable ["brpvp_lifesfix",_lifesFix,true];

	_veiculo spawn {
		private _init = diag_tickTime;
		_this allowDamage false;
		waitUntil {
			if (vectorMagnitude velocity _this > 0.125) then {_init = diag_tickTime;};
			diag_tickTime-_init > 2
		};
		_this setVariable ["brpvp_coll_prot",false];
		_this allowDamage true;
		_this lock false;
	};
};
BRPVP_numberSetSufix = {
	if (_this < 1000) then {
		_this call BRPVP_formatNumber;
	} else {
		if (_this >= 1000 && _this < 1000000) then {
			(round (_this/100)/10 call BRPVP_formatNumber)+"K";
		} else {
			(round (_this/100000)/10 call BRPVP_formatNumber)+"KK";
		};
	};
};
BRPVP_getIntersectFlags = {
	private _mRad = _this getVariable ["brpvp_flag_radius",0];
	private _nearPossible = nearestObjects [_this,["FlagCarrier"],425,true];
	private _intersecs = [];
	{
		private _flag = _x;
		private _fRad = _flag getVariable ["brpvp_flag_radius",0];
		if (_flag distance2D _this < _mRad+_fRad) then {_intersecs pushBack _flag;};
	} forEach _nearPossible;
	_intersecs
};
BRPVP_turretsAddRemoveFriendFix = {
	params ["_tIds","_pAmg"];
	{if (_x select 3 in _tIds) then {BRPVP_allTurretsInfo select _forEachIndex select 6 set [0,_pAmg];};} forEach BRPVP_allTurretsInfo;
};
BRPVP_turretsAddRemoveFriend = {
	params ["_id","_pAmg"];
	{if (_x select 4 isEqualTo _id) then {BRPVP_allTurretsInfo select _forEachIndex select 6 set [0,_pAmg];};} forEach BRPVP_allTurretsInfo;
};
BRPVP_removeAddTurretInfo = {
	BRPVP_turretsActive = BRPVP_turretsActive-[_this];
	private _newIds = [];
	{
		private _p = _x;
		private _pActiveFlags = (_p getVariable ["brpvp_wakeUpFlags",[]])-[objNull];
		private _in = false;
		private _tData = {if ((_x select 3) isEqualTo _this) exitWith {_x};} forEach BRPVP_allTurretsInfo;
		if (!isNil "_tData") then {
			{if ((_tData select 2) distance2D _x <= _x getVariable ["brpvp_flag_radius",0]) exitWith {_newIds pushBack _this};} forEach _pActiveFlags;
		};
	} forEach call BRPVP_playersList;
	BRPVP_turretsActive append _newIds;
};
BRPVP_removeTurretInfo = {
	{if ((_x select 3) isEqualTo _this) exitWith {BRPVP_allTurretsInfo deleteAt _forEachIndex;};} forEach BRPVP_allTurretsInfo;
	if (isServer) then {BRPVP_turretsActive = BRPVP_turretsActive-[_this];};
};
BRPVP_updateTurretInfo = {
	{
		private _new = _x;
		{if ((_x select 3) isEqualTo (_new select 3)) then {BRPVP_allTurretsInfo set [_forEachIndex,_new];};} forEach BRPVP_allTurretsInfo;
	} forEach _this;
};
BRPVP_addNewTurretInfo = {
	BRPVP_allTurretsInfo pushBack _this;
	if (isServer) then {
		private _newIds = [];
		{
			private _p = _x;
			private _pActiveFlags = (_p getVariable ["brpvp_wakeUpFlags",[]])-[objNull];
			private _in = false;
			{if ((_this select 2) distance2D _x <= _x getVariable ["brpvp_flag_radius",0]) exitWith {_newIds pushBack (_this select 3)};} forEach _pActiveFlags;
		} forEach call BRPVP_playersList;
		BRPVP_turretsActive append _newIds;
	};
};
BRPVP_arrayToFps = {
	private _sum = 0;
	{_sum = _sum+_x;} forEach _this;
	(_sum/count _this)
};
BRPVP_runOnHouseChangeModel = {
	params ["_prevObj", "_newObj", "_isRuin"];
	if (_prevObj getVariable ["brpvp_yes_minerva",false]) then {_newObj setVariable ["brpvp_yes_minerva",true,true];};
	if (_isRuin) then {
		{if ([_x,_prevObj] call PDTH_pointIsInBox) then {triggerAmmo _x;};} forEach nearestObjects [_prevObj,BRPVP_zombieDistractAmmo,(sizeOf typeOf _prevObj)/1.75];
		{
			private _wh = _x;
			private _lis = lineIntersectsSurfaces [getPosASL _wh,getPosASL _wh vectorAdd [0,0,-75],_wh,_prevObj,true,-1,"GEOM","NONE",true];
			private _newFloor = _lis select {(_x select 2) isKindOf "Building" || isNull (_x select 2)};
			if (_newFloor isNotEqualTo []) then {
				private _floorPos = _newFloor select 0 select 0;
				_wh setPosASL _floorPos;
			};			
		} forEach nearestObjects [_prevObj,["GroundWeaponHolder"],(sizeOf typeOf _prevObj)/1.75];
	};
};
BRPVP_vehDataToSaveIfVehDie = [];
BRPVP_getVehDataBeforeDie = {
	private ["_id_bd","_estadoCarro"];
	private _veh = _this;
	_id_bd = _veh getVariable ["id_bd",-1];
	if (_id_bd > -1) then {
		_estadoCarro = [
			_veh call BRPVP_getCargoArray,
			[getPosWorld _veh,[vectorDir _veh,vectorUp _veh]],
			typeOf _veh,
			_veh getVariable ["own",-1],
			_veh getVariable ["stp",1],
			_veh getVariable ["amg",[[],[],true]],
			_veh getVariable ["mapa",false],
			_veh getVariable ["brpvp_locked",false],
			_veh getVariable ["brpvp_lastPayment",[0,0,0,0,0,0]],
			_veh call BRPVP_getVehicleAmmo,
			_veh call BRPVP_getHitpointsDamageFullLife, //FULL LIFE
			_veh getVariable ["brpvp_lifesfix",0]
		];
		private _idx = -1;
		{if (_id_bd isEqualTo (_x select 0)) exitWith {_idx = _forEachIndex;};} forEach BRPVP_vehDataToSaveIfVehDie;
		if (_idx isEqualTo -1) then {BRPVP_vehDataToSaveIfVehDie pushBack [_id_bd,time,_veh,_estadoCarro];} else {BRPVP_vehDataToSaveIfVehDie set [_idx,[_id_bd,time,_veh,_estadoCarro]];};
	};
};
BRPVP_saveDeadVehDataBefore = {
	private _aDel = [];
	{
		_x params ["_id","_t","_veh","_data"];
		if (local _veh) then {
			if (alive _veh) then {
				if (time-_t > 30) then {_aDel pushBack _forEachIndex;};
			} else {
				if (!isNull _veh) then {
					[_id,_data] remoteExecCall ["BRPVP_vehSaveNoCalcData",2];
					_aDel pushBack _forEachIndex;
				};
			};
		} else {
			_aDel pushBack _forEachIndex;
		};
	} forEach BRPVP_vehDataToSaveIfVehDie;
	_aDel sort false;
	{BRPVP_vehDataToSaveIfVehDie deleteAt _x;} forEach _aDel;
};
BRPVP_setVehServicesToZero = {
	if (getAmmoCargo _this > 0) then {_this setAmmoCargo 0;};
	if (getFuelCargo _this > 0) then {_this setFuelCargo 0;};
	if (getRepairCargo _this > 0) then {_this setRepairCargo 0;};
};
BRPVP_checkTurretType = {
	params ["_type","_turret"];
	_type in (_turret getVariable ["brpvp_all_target",["man","car","armor","harmor","air","plane"]])
};
BRPVP_wakeUpSetVelocity = {
	private _veh = _this;
	private _pos = getPosWorld _veh;
	private _vel = velocity _veh;
	private _vu = vectorUp _veh;
	[_veh,_pos,_vel,_vu] spawn {
		params ["_veh","_pos","_vel","_vu"];
		private _wm = simulationEnabled _veh && vectorMagnitude velocity _veh > 0.01;
		if (!_wm) then {
			private _init = time;
			waitUntil {
				_wm = simulationEnabled _veh && vectorMagnitude velocity _veh > 0.01;
				_wm || time-_init > 0.5
			};
		};
		if (_wm) then {
			if (_veh isKindOf "StaticWeapon") then {
				private _init = time;
				_veh setPosWorld _pos;
				_veh setVectorUp _vu;
				[_veh,[0,0,0]] remoteExecCall ["setVelocity",0];
				waitUntil {
					_veh setPosWorld _pos;
					_veh setVectorUp _vu;
					_veh setVelocity [0,0,0];
					time-_init > 0.25
				};
			} else {
				_veh setPosWorld _pos;
				_veh setVectorUp _vu;
				[_veh,_vel] remoteExecCall ["setVelocity",0];
			};
		};
	};
};
BRPVP_carrierMissFixAndInit = {
	params ["_carrier","_pASL"];
	_init = time;
	waitUntil {getPosASL _carrier distance _pASL < 5 || time-_init > 10};
	sleep 2;
	_carrier call BRPVP_aircraftFixPositions;
	if (hasInterface) then {
		sleep 2;
		[_carrier] call BIS_fnc_Carrier01Init;
	};
};
BRPVP_aircraftClasses = [
	"Land_Carrier_01_hull_09_2_F",
	"Land_Carrier_01_hull_09_1_F",
	"Land_Carrier_01_hull_08_2_F",
	"Land_Carrier_01_hull_08_1_F",
	"Land_Carrier_01_island_03_F",
	"Land_Carrier_01_island_02_F",
	"Land_Carrier_01_island_01_F",
	"Land_Carrier_01_hull_07_2_F",
	"Land_Carrier_01_hull_07_1_F",
	"Land_Carrier_01_hull_06_2_F",
	"Land_Carrier_01_hull_06_1_F",
	"Land_Carrier_01_base_F",
	"Land_Carrier_01_hull_05_2_F",
	"Land_Carrier_01_hull_05_1_F",
	"Land_Carrier_01_hull_04_2_F",
	"Land_Carrier_01_hull_04_1_F",
	"Land_Carrier_01_hull_03_2_F",
	"Land_Carrier_01_hull_03_1_F",
	"Land_Carrier_01_hull_02_F",
	"Land_Carrier_01_hull_01_F"
];
BRPVP_aircraftReference = [
	[[-24.50047,165.02405,10],360],
	[[24.49953,165.02405,10],360],
	[[-24.50047,120.02406,10],360],
	[[24.49953,120.02406,10],360],
	[[-45.00047,130.02405,30],360],
	[[-30.00047,105.02406,30],360],
	[[-30.00047,105.02406,30],360],
	[[-24.50047,75.02406,10],360],
	[[24.49953,75.02406,10],360],
	[[-24.50047,30.02406,10],360],
	[[24.49953,30.02406,10],360],
	[[-0.00047,0.00146,5],0],
	[[-24.50047,-14.97594,10],360],
	[[24.49953,-14.97594,10],360],
	[[-24.50047,-59.97594,10],360],
	[[24.49953,-59.97594,10],360],
	[[-15.00047,-104.97594,10],360],
	[[14.99953,-104.97594,10],360],
	[[-0.00047,-139.97595,5],360],
	[[-0.00047,-164.97595,5],360]
];
BRPVP_aircraftFixPositions = {
	private _mainPos = getPosWorld _this;
	private _refMainPos = [-0.00047,0.00146,5];
	private _mainDir = getDir _this;
	private _refMainDir = 0;
	private _dirFix = (_mainDir+360)-(_refMainDir+360);
	{
		private _obj = _x;
		(BRPVP_aircraftReference select (BRPVP_aircraftClasses find typeOf _x)) params ["_refOPos","_refODir"];
		private _oPos = getPosWorld _obj;
		private _oDir = getDir _obj;
		private _refDirTo = [_refMainPos,_refOPos] call BIS_fnc_dirTo;
		private _refDist = _refOPos distance2D _refMainPos;
		private _newAngle = _refDirTo+_dirFix;
		private _oZ = _refOPos select 2;
		private _refMainZ = 5;
		private _zDiff = _oZ-_refMainZ;
		_obj setDir (_refODir+_dirFix);
		_obj setPosWorld [(_mainPos select 0)+(sin _newAngle)*_refDist,(_mainPos select 1)+(cos _newAngle)*_refDist,(_mainPos select 2)+_zDiff];
	} forEach nearestObjects [_this,BRPVP_aircraftClasses,300];	
};
BRPVP_dateDiff = {
	params ["_after","_before"];
	(_after call BRPVP_dateTotalDays)-(_before call BRPVP_dateTotalDays)
};
BRPVP_dateTotalDays = {
	private _date = [_this select 0,_this select 1,_this select 2,0,0];
	private _year = _date select 0;
	private _yearBefore = (_year-1) max 0;
	private _qttLeapYears = floor (_yearBefore/4);
	private _qttNormalYears = _yearBefore-_qttLeapYears;
	private _days = _qttNormalYears+_qttLeapYears*(366/365);
	_days = _days+dateToNumber _date;
	round (_days/(1/365))+(_this select 3)/24
};
BRPVP_carryHeliCheckUnload = {
	params ["_heli","_veh"];
	waitUntil {getPos _veh select 2 < 5 || !alive _heli};
	[_veh,false] remoteExecCall ["allowDamage",0];
	sleep 0.2;
	detach _veh;
	_underground = getPosATL _veh select 2 < -0.15;
	if (_underground) then {
		_posHeli = getPosATL _heli;
		_posHeli set [2,(_posHeli select 2)+5];
		_heli setPosATL _posHeli;
		sleep 0.1;
		_posVeh = getPosATL _veh;
		_posVeh set [2,0];
		_veh setPosATL _posVeh;
		_veh setVariable ["slv",true,true];
	} else {
		_veh spawn {
			_veh = _this;
			_count = 0;
			_init = time;
			waitUntil {
				if ((vectorMagnitude velocity _veh) < 0.125) then {_count = _count+1;} else {_count = 0;};
				_count > 5 || time-_init > 10
			};
			_veh setVariable ["slv",true,true];
		};
	};
	if (alive _heli) then {_heli setVariable ["brpvp_carry_heli_veh",objNull,true];};
	sleep 1;
	[_veh,true] remoteExecCall ["allowDamage",0];
};
BRPVP_contentReport = {
	systemChat "=================================";
	diag_log "=================================";

	private _turrets = entities [["StaticWeapon"],[]];
	private _baseTurretUnits = (_turrets apply {_x getVariable ["brpvp_operator",objNull]})-[objNull];
	private _allAiUnits = (BRPVP_roadBlockBots+BRPVP_missBotsEm+BRPVP_noShowBots+_baseTurretUnits)-[objNull];
	
	//AI UNITS
	_ct = 0;_ce = 0;_cd = 0;
	{
		if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
		_ct = _ct+1;
	} forEach _allAiUnits;
	systemChat format ["AI units - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["AI units - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];

	//AI UNITS LOCAL
	_ct = 0;_ce = 0;_cd = 0;
	{
		if (local _x) then {
			if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
			_ct = _ct+1;
		};
	} forEach _allAiUnits;
	systemChat format ["Local AI units - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["Local AI units - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];

	//MISSION BASE TURRETS
	_ct = 0;_ce = 0;_cd = 0;
	_op = 0;
	{
		private _idBd = _x getVariable ["id_bd",-1];
		private _operator = _x getVariable ["brpvp_operator",-1];
		private _haveHasOperator = _operator isEqualType objNull;
		if (_idBd isEqualTo -1 && _haveHasOperator) then {
			if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
			if (!isNull _operator) then {_op = _op+1;};
			_ct = _ct+1;
		};
	} forEach _turrets;
	systemChat format ["Mission Base Turrets - Total: %1 Operators: %4 Simu On: %2 Simu Off: %3",_ct,_ce,_cd,_op];
	diag_log format ["Mission Base Turrets - Total: %1 Operators: %4 Simu On: %2 Simu Off: %3",_ct,_ce,_cd,_op];

	//BASE TURRETS
	_ct = 0;_ce = 0;_cd = 0;
	_op = 0;
	{
		private _idBd = _x getVariable ["id_bd",-1];
		if (_idBd > -1) then {
			private _operator = _x getVariable ["brpvp_operator",objNull];
			if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
			if (!isNull _operator) then {_op = _op+1;};
			_ct = _ct+1;
		};
	} forEach _turrets;
	systemChat format ["Base Turrets - Total: %1 Operators: %4 Simu On: %2 Simu Off: %3",_ct,_ce,_cd,_op];
	diag_log format ["Base Turrets - Total: %1 Operators: %4 Simu On: %2 Simu Off: %3",_ct,_ce,_cd,_op];

	private _vehicles = entities [["Air","Ship","Car","Motorcycle","Tank"],["ParachuteBase"]];
	
	//DATABASE VEHICLES
	_ct = 0;_ce = 0;_cd = 0;
	{
		if (_x getVariable ["id_bd",-1] isNotEqualTo -1) then {
			if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
			_ct = _ct+1;
		};
	} forEach _vehicles;
	systemChat format ["Database Vehicles - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["Database Vehicles - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];

	//FEDIDEX VEHICLES
	_ct = 0;_ce = 0;_cd = 0;
	{
		if (_x getVariable ["brpvp_fedidex",false]) then {
			if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
			_ct = _ct+1;
		};
	} forEach _vehicles;
	systemChat format ["Fedidex Vehicles - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["Fedidex Vehicles - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];

	//BOT VEHICLES
	_ct = 0;_ce = 0;_cd = 0;
	{
		private _fedidex = _x getVariable ["brpvp_fedidex",false];
		private _idBd = _x getVariable ["id_bd",-1];
		if (!_fedidex && _idBd isEqualTo -1) then {
			if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
			_ct = _ct+1;
		};
	} forEach _vehicles;
	systemChat format ["Bot Vehicles - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["Bot Vehicles - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	
	//BASE BOXES
	private _allBaseBoxes = [];
	private _otherBoxes = [];
	_ct = 0;_ce = 0;_cd = 0;
	{
		private _idBd = _x getVariable ["id_bd",-1];
		if (_idBd isEqualTo -1) then {
			_otherBoxes pushBack _x;
		} else {
			if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
			_ct = _ct+1;
			_allBaseBoxes pushBack _x;
		};
	} forEach entities [["ReammoBox_F"],[]];
	systemChat format ["Base Boxes - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["Base Boxes - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];

	//OTHER BOXES
	_ct = 0;_ce = 0;_cd = 0;
	{
		if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
		_ct = _ct+1;
	} forEach _otherBoxes;
	systemChat format ["Other Boxes - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["Other Boxes - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];

	//SYNCED BASE BUILDINGS
	_ct = 0;_ce = 0;_cd = 0;
	{
		if (simulationEnabled _x) then {_ce = _ce+1;} else {_cd = _cd+1;};
		_ct = _ct+1;
	} forEach (BRPVP_ownedHouses-_allBaseBoxes);
	systemChat format ["Synced Base Buildings - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];
	diag_log format ["Synced Base Buildings - Total: %1 Simu On: %2 Simu Off: %3",_ct,_ce,_cd];

	//LOCAL COMPLEX BASE BUILDINGS
	systemChat format ["Local Complex Base Buildings - Total: %1",count BRPVP_allMissionObjectsCVL];
	diag_log format ["Local Complex Base Buildings - Total: %1",count BRPVP_allMissionObjectsCVL];

	//LOCAL SIMPLE BASE BUILDINGS
	_ct = 0;
	{
		private _idBd = _x getVariable ["id_bd",-1];
		if (_idBd > -1) then {_ct = _ct+1;};
	} forEach allSimpleObjects [];
	systemChat format ["Local Simple Base Buildings - Total: %1",_ct];
	diag_log format ["Local Simple Base Buildings - Total: %1",_ct];

	//AIRCRAFT CARRIERS
	if (isNil "BRPVP_carrierObjsList") then {
		systemChat format ["Aircraft Carriers - Total: %1","?"];
		diag_log format ["Aircraft Carriers - Total: %1","?"];
	} else {
		systemChat format ["Aircraft Carriers - Total: %1",count BRPVP_carrierObjsList];
		diag_log format ["Aircraft Carriers - Total: %1",count BRPVP_carrierObjsList];
	};

	systemChat "=================================";
	diag_log "=================================";
};
BRPVP_AIGetOutVehTimerToDisable = {
	params ["_vehicle","_role","_unit","_turret"];
	if !(_unit call BRPVP_isPlayer) then {
		_unit setVariable ["brpvp_out_veh_time",serverTime,0];
	};
};
BRPVP_enableSimulation = {
	private _paramsArray = ["_ai","_veh","_enabled"];
	{
		_x params _paramsArray;
		_ai enableSimulation _enabled;
		_ai hideObject !_enabled;
		if (!isNull _veh) then {
			_veh enableSimulation _enabled;
			_veh hideObject !_enabled;
		};
	} forEach _this;
};
BRPVP_getSegSimpleObjectCVL = {
	private _idx = BRPVP_allMissionObjectsCVLSegClass find _this;
	if (_idx isEqualTo -1) then {[]} else {BRPVP_allMissionObjectsCVLSegObjs select _idx};
};
BRPVP_hackHouseOkSimpleObject = {
	params ["_id","_class","_isWall","_isHouse","_pos","_isCVL"];
	_object = objNull;
	if (_isCVL) then {
		{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_object = _x;};} forEach BRPVP_allMissionObjectsCVL;
	} else {
		{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_object = _x;};} forEach allSimpleObjects [_class];
	};
	if (!isNull _object) then {
		_object setVariable ["brpvp_hacked",true];
		if (_isWall) then {_object setVariable ["brpvp_hacked_time",serverTime];};
		if (_isHouse) then {
			_places = _object getVariable ["brpvp_hacked_places",[]];
			_places pushBack _pos;
			_object setVariable ["brpvp_hacked_places",_places];
		};
	};
};
BRPVP_tireServerPutVeh = {
	params ["_veh","_vu","_vd","_fix","_pASL"];
	(_veh call BRPVP_salvaVeiculoData) remoteExecCall ["BRPVP_salvaVeiculoOnlySql",2];
	_vd = vectorNormalized (_vd vectorCrossProduct _vu);
	_fix = if (_fix < 0 && _fix > -0.75) then {-_fix} else {0};
	_modelo = typeOf _veh;
	_veiculoId = _veh getVariable "id_bd";
	_cantSafeTime = _veh getVariable ["brpvp_cant_safe_time",0];
	_owner = _veh getVariable "own";
	_VGTime = _veh getVariable ["brpvp_from_vg_time",0];
	_kills = _veh getVariable ["brpvp_kills",0];
	_isStillRaidTraining = _veh getVariable ["brpvp_rto_real_vehicle",false] && {_veh distance2D BRPVP_raidTrainingMapPosition < 400};
	deleteVehicle _veh;
	_class = if (_modelo in BRPVP_disableVehUseList) then {"PlasticBarrier_02_yellow_F"} else {"PlasticBarrier_02_grey_F"};
	private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
	_tire = _CVL;
	_tire setPosASL (_pASL vectorAdd [0,0,_fix-0.05]);
	_tire setVectorDirAndUp [_vd,_vu];
	_tire setVariable ["brpvp_tire_nameCFG",configFile >> "CfgVehicles" >> _modelo];
	_tire setVariable ["brpvp_tire_owner",_owner];
	_tire setVariable ["brpvp_tire_idbd",_veiculoId];
	if (_cantSafeTime isNotEqualTo 0) then {_tire setVariable ["brpvp_tire_cantSafeTime",_cantSafeTime];};
	if (_VGTime isNotEqualTo 0) then {_tire setVariable ["brpvp_from_vg_time",_VGTime];};
	if (_kills isNotEqualTo 0) then {_tire setVariable ["brpvp_tire_kills",_kills];};
	if (_isStillRaidTraining) then {_tire setVariable ["brpvp_rto_real_vehicle",true];};
	_vars = [allVariables _tire,allVariables _tire apply {_tire getVariable _x}];
	[_tire call BRPVP_typeOfSo,getPosWorld _tire,[vectorDir _tire,vectorUp _tire],_vars,isObjectHidden _tire] remoteExecCall ["BRPVP_transformInLocalInitTires",0];
	deleteVehicle _tire;
};
BRPVP_tireRemoveTireFromArrayCVL = {
	_obj = objNull;
	{if (_x getVariable ["brpvp_tire_idbd",-1] isEqualTo _this) exitWith {_obj = _x;};} forEach BRPVP_tireAllTiresGlobal;
	if (!isNull _obj) then {
		BRPVP_tireAllTiresGlobal deleteAt (BRPVP_tireAllTiresGlobal find _obj);
		deleteVehicle _obj;
	};
};
BRPVP_tireUpdateTirePosFromArrayCVL = {
	params ["_id","_spatial"];
	private _obj = objNull;
	{if (_x getVariable ["brpvp_tire_idbd",-1] isEqualTo _id) exitWith {_obj = _x;};} forEach BRPVP_tireAllTiresGlobal;
	if (!isNull _obj) then {
		_spatial params ["_posASL","_vdu"];
		_obj setVectorDirAndUP _vdu;
		_obj setPosASL _posASL;
	};
};
BRPVP_saveLightStateDbsimpleObjectCVL = {
	params ["_class","_id","_state"];
	private _lamp = objNull;
	{if (_x getVariable ["id_bd",-2] isEqualTo _id) exitWith {_lamp = _x;};} forEach BRPVP_allMissionObjectsCVL;
	if (_state) then {_lamp setDamage 0;} else {_lamp setDamage 0.9;};
	if (isServer && _id isNotEqualTo -1) then {
		private _exec = if (_state) then {"_this setDamage 0;"} else {"_this setDamage 0.9;"};
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:saveVehicleExec:%2:%3",BRPVP_protocolo,_exec,_id];
		} else {
			[_id,[["exec",_exec]]] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
	};
};
BRPVP_setInitialAnimations = {
	_typeOf = typeOf _this;
	{
		_x params ["_class","_animations"];
		if (_typeOf isEqualTo _class) then {{_this animateSource _x;} forEach _animations;};
	} forEach BRPVP_animateObjsAfterCreate;
};
BRPVP_checkAllCVLDoors = {
	//{_x call BRPVP_closeDoorsIfNoAccess;} forEach BRPVP_allMissionObjectsCVL;
};
BRPVP_closeDoorsIfNoAccess = {
	/*
	_house = _this;
	_typeOf = typeOf _house;
	if (isClass (configFile >> "CfgVehicles" >> _typeOf >> "AnimationSources" >> "Door_1_sound_source")) then {
		if !(_house call BRPVP_checaAcesso) then {
			_filter = "(configName _x) find 'Door_' isEqualTo 0 && (configName _x) find '_sound_source' > -1";
			_speed = [1,true] select (_house distance player > 50);
			{_house animateSource [configName _x,0,_speed];} forEach (_filter configClasses (configFile >> "CfgVehicles" >> _typeOf >> "AnimationSources"));
		};
	};
	*/
};
BRPVP_guardAirVehicleIfClientCrash = {
	params ["_crew","_pEsc","_veh","_isCp"];
	_vehIsOk = _veh getVariable ["id_bd",-1] > -1 && _veh getVariable ["own",-1] > -1;
	diag_log ("PLAYER VAR 'brpvp_on_esc': "+str _pEsc);
	if (_vehIsOk && !_pEsc && _veh isKindOf "Air" && {getPos _veh select 2 > 1 && _isCp}) then {
		private _pos = getPosASL _veh;
		_pos set [2,0];
		_veh remoteExecCall ["BRPVP_putInVirtualGarage",2];
		[_crew,_pos] spawn {
			params ["_crew","_pos"];
			waitUntil {{!isNull objectParent _x} count _crew isEqualTo 0};
			sleep 0.001;
			{
				if (!isNull _x) then {
					[_x,[0,0,0]] remoteExecCall ["setVelocity",_x];
					[_x,[_pos,[],50,"NONE"]] remoteExecCall ["setVehiclePosition",_x];
				};
			} forEach _crew;
		};
	};
};
BRPVP_salvaVeiculoAmgData = {
	_id_bd = _this getVariable ["id_bd",-1];
	_carroVivo = alive _this;
	_own = _this getVariable ["own",-1];
	_stp = _this getVariable ["stp",1];
	_amg = _this getVariable ["amg",[[],[],true]];
	[_id_bd,_carroVivo,_own,_stp,_amg]
};
BRPVP_salvaVeiculoData = {
	private _id_bd = _this getVariable ["id_bd",-1];
	private _estadoCarro = [
		_this call BRPVP_getCargoArray,
		[getPosWorld _this,[vectorDir _this,vectorUp _this]],
		_this call BRPVP_typeOfSo,
		_this getVariable ["own",-1],
		_this getVariable ["stp",1],
		_this getVariable ["amg",[[],[],true]],
		_this getVariable ["mapa",false],
		_this getVariable ["brpvp_locked",false],
		_this getVariable ["brpvp_lastPayment",[0,0,0,0,0,0]],
		_this call BRPVP_getVehicleAmmo,
		_this call BRPVP_getHitpointsDamage,
		_this getVariable ["brpvp_lifesfix",0]
	];
	[_id_bd,_estadoCarro]
};
BRPVP_saveSimpleObjectsOnDb = {
	{
		if (_x getVariable ["slv",false]) then {
			(_x call BRPVP_salvaVeiculoData) remoteExecCall ["BRPVP_salvaVeiculoOnlySql",2];
			_x setVariable ["slv",false];
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				(_x call BRPVP_salvaVeiculoAmgData) remoteExecCall ["BRPVP_salvaVeiculoAmgOnlySql",2];
				_x setVariable ["slv_amg",false];
			};
		};
	} forEach allSimpleObjects [];
	{
		if (_x getVariable ["slv",false]) then {
			(_x call BRPVP_salvaVeiculoData) remoteExecCall ["BRPVP_salvaVeiculoOnlySql",2];
			_x setVariable ["slv",false,true];
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				(_x call BRPVP_salvaVeiculoAmgData) remoteExecCall ["BRPVP_salvaVeiculoAmgOnlySql",2];
				_x setVariable ["slv_amg",false,true];
			};
		};
	} forEach BRPVP_allMissionObjectsCVL;
};
BRPVP_virtualGarageSpawnVehicleHC = {
	params ["_resultado","_class","_player","_vgTime","_cliId","_posW","_vDU"];
	_resultadoCompilado = parseSimpleArray _resultado select 1 select 0;
	_modelo = _resultadoCompilado select 4;
	_veiculoId = _resultadoCompilado select 0;
	_carga = _resultadoCompilado select 2;
	_owner = _resultadoCompilado select 5;
	_comp = _resultadoCompilado select 6;
	_amigos = _resultadoCompilado select 7;
	_exec = _resultadoCompilado select 9;
	_lock = _resultadoCompilado select 10;
	_paint = _resultadoCompilado select 13;
	_cover = _resultadoCompilado select 14;
	_ammo = _resultadoCompilado select 15;
	_life = _resultadoCompilado select 16;
	_pAmgDb = _resultadoCompilado select 17;
	_lifesFix = _resultadoCompilado select 18;
	_isDrone = _class in BRPVP_vantVehiclesClass;
	_veiculo = createVehicle [_class,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
	_veiculo call BRPVP_setVehRadarAndThermal;
	_veiculo setVectorDirAndUp _vDU;
	_veiculo setPosWorld _posW;
	if (_class isEqualTo "B_UAV_05_F") then {
		_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
		{_veiculo animateSource [_x,1,true];} forEach _wingAnimations;
	};
	if (_isDrone) then {
		//createVehicleCrew _veiculo;
		if (BRPVP_dronesMakeAllUnarmed) then {
			{
				_veiculo setPylonLoadout [configName _x,""];
			} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _veiculo >> "Components" >> "TransportPylonsComponent" >> "pylons"));
		};
		_veiculo setVariable ["brpvp_auto_first",true,true];
	} else {
		_veiculo setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
	};

	//SET CUSTOM CARGO SIZE
	{
		_x params ["_classCheck","_name","_cargo"];
		if (_classCheck isEqualTo _class) exitWith {[_veiculo,_cargo] remoteExecCall ["setMaxLoad",2];};
	} forEach BRPVP_customCargoVehiclesCfg;

	_veiculo setVariable ["id_bd",_veiculoId,true];
	_veiculo setVariable ["own",_owner,true];
	_veiculo setVariable ["stp",_comp,true];
	_veiculo remoteExecCall ["BRPVP_veiculoEhReset",2];
	[_veiculo,_carga] call BRPVP_putItemsOnCargo;
	if (_exec != "") then {_veiculo call compile _exec;};
	if !(_lock isEqualTo 0) then {_veiculo setVariable ["brpvp_locked",!(_lock isEqualTo 0),true];};
	_amigos set [0,_player getVariable ["amg",[]]];
	_veiculo setVariable ["amg",_amigos,true];
	_veiculo setVariable ["slv",true];
	_veiculo setVariable ["brpvp_from_vg_time",serverTime+_vgTime,true];

	//PAINT VEHICLE
	if !(_paint isEqualTo []) then {
		{_veiculo setObjectTextureGlobal [_forEachIndex,_x];} forEach _paint;
		_veiculo setVariable ["brpvp_paint_enabled",true,true];
	};

	//VEHICLE COVER
	if !(_cover isEqualTo []) then {[_veiculo,false,_cover,false] remoteExecCall ["BIS_fnc_initVehicle",_veiculo];};

	//SET VEHICLE LIFE
	[_veiculo,_life] call BRPVP_setVehicleDamage;

	//SET AMMO
	[_veiculo,_ammo] call BRPVP_setVehicleAmmo;

	_veiculo setVariable ["brpvp_time_can_disable",serverTime+5,2];
	_veiculo call BRPVP_setVehServicesToZero;

	_veiculo setVariable ["brpvp_coll_prot",true];
	_veiculo lock true;

	//SET LIFESFIX
	_veiculo setVariable ["brpvp_lifesfix",_lifesFix,true];

	_veiculo spawn {
		private _init = diag_tickTime;
		_this allowDamage false;
		waitUntil {
			if (vectorMagnitude velocity _this > 0.125) then {_init = diag_tickTime;};
			diag_tickTime-_init > 2
		};
		_this setVariable ["brpvp_coll_prot",false];
		_this allowDamage true;
		_this lock false;
	};
};
BRPVP_tireServerGetVehHC = {
	params ["_resultado","_VGTime","_kills","_cantSafeTime","_isRaidTraining","_cliId","_player"];
	_resultadoCompilado = parseSimpleArray _resultado select 1 select 0;
	_posicao = _resultadoCompilado select 3;
	_modelo = _resultadoCompilado select 4;
	_veiculoId = _resultadoCompilado select 0;
	_carga = _resultadoCompilado select 2;
	_owner = _resultadoCompilado select 5;
	_comp = _resultadoCompilado select 6;
	_amigos = _resultadoCompilado select 7;
	_exec = _resultadoCompilado select 9;
	_lock = _resultadoCompilado select 10;
	_paint = _resultadoCompilado select 13;
	_cover = _resultadoCompilado select 14;
	_ammo = _resultadoCompilado select 15;
	_life = _resultadoCompilado select 16;
	_pAmgDb = _resultadoCompilado select 17;
	_lifesFix = _resultadoCompilado select 18;
	_vPWD = _posicao select 0;
	_vVDU = _posicao select 1;

	_isDrone = _modelo in BRPVP_vantVehiclesClass;
	_veiculo = createVehicle [_modelo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
	_veiculo call BRPVP_setVehRadarAndThermal;
	_veiculo setVectorDir (_vVDU select 0);
	_veiculo setVectorUp (_vVDU select 1);
	_veiculo setPosWorld _vPWD;
	if (_modelo isEqualTo "B_UAV_05_F") then {
		_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
		{_veiculo animateSource [_x,1,true];} forEach _wingAnimations;
	};
	if (_isDrone) then {
		//createVehicleCrew _veiculo;
		if (BRPVP_dronesMakeAllUnarmed) then {
			{
				_veiculo setPylonLoadout [configName _x,""];
			} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _veiculo >> "Components" >> "TransportPylonsComponent" >> "pylons"));
		};
		_veiculo setVariable ["brpvp_auto_first",true,true];
	} else {
		_veiculo setVariable ["brpvp_auto_magus_time",serverTime+BRPVP_useTireAutoMoveToTime,2];
	};

	//SET CUSTOM CARGO SIZE
	{
		_x params ["_class","_name","_cargo"];
		if (_class isEqualTo _modelo) exitWith {[_veiculo,_cargo] remoteExecCall ["setMaxLoad",2];};
	} forEach BRPVP_customCargoVehiclesCfg;

	_veiculo setVariable ["id_bd",_veiculoId,true];
	_veiculo setVariable ["own",_owner,true];
	_veiculo setVariable ["stp",_comp,true];
	_veiculo remoteExecCall ["BRPVP_veiculoEhReset",2];
	[_veiculo,_carga] call BRPVP_putItemsOnCargo;
	if (_exec != "") then {_veiculo call compile _exec;};
	if !(_lock isEqualTo 0) then {_veiculo setVariable ["brpvp_locked",!(_lock isEqualTo 0),true];};
	_foundOwner = false;
	{
		_amgAP = _x getVariable ["amg",-1];
		_idAP = _x getVariable ["id_bd",-1];
		if (_amgAP isNotEqualTo -1 && _idAP isNotEqualTo -1 && _idAP isEqualTo _owner) exitWith {
			_amigos set [0,_amgAP];
			_foundOwner = true;
		};
	} forEach call BRPVP_playersList;
	if (!_foundOwner) then {_amigos set [0,_pAmgDb];};
	_veiculo setVariable ["amg",_amigos,true];
	_veiculo setVariable ["slv",true];
	if (_VGTime isNotEqualTo 0) then {_veiculo setVariable ["brpvp_from_vg_time",_VGTime,true];};
	if (_kills isNotEqualTo 0) then {_veiculo setVariable ["brpvp_kills",_kills,true];};
	if (_cantSafeTime isNotEqualTo 0) then {_veiculo setVariable ["brpvp_cant_safe_time",_cantSafeTime,true];};

	//PAINT VEHICLE
	if !(_paint isEqualTo []) then {
		{_veiculo setObjectTextureGlobal [_forEachIndex,_x];} forEach _paint;
		_veiculo setVariable ["brpvp_paint_enabled",true,true];
	};

	//VEHICLE COVER
	if !(_cover isEqualTo []) then {[_veiculo,false,_cover,false] remoteExecCall ["BIS_fnc_initVehicle",_veiculo];};

	//SET AMMO
	[_veiculo,_ammo] call BRPVP_setVehicleAmmo;

	//SET VEHICLE LIFE
	[_veiculo,_life] call BRPVP_setVehicleDamage;

	_veiculo setVariable ["brpvp_time_can_disable",serverTime+5,2];
	_veiculo call BRPVP_setVehServicesToZero;

	_veiculo setVariable ["brpvp_coll_prot",true];
	_veiculo lock true;

	//SET LIFESFIX
	_veiculo setVariable ["brpvp_lifesfix",_lifesFix,true];

	//SET RAID TRAINING VEHICLE
	if (_isRaidTraining) then {_veiculo setVariable ["brpvp_rto_real_vehicle",true,true];};

	_veiculo spawn {
		private _init = diag_tickTime;
		_this allowDamage false;
		waitUntil {
			if (vectorMagnitude velocity _this > 0.125) then {_init = diag_tickTime;};
			diag_tickTime-_init > 2
		};
		_this setVariable ["brpvp_coll_prot",false];
		_this allowDamage true;
		_this lock false;
	};
};
BRPVP_allAnimBuildingTypeClassCVL = [];
BRPVP_allAnimBuildingTypeCasesCVL = [];
BRPVP_initialSimpleObjectsToClient = {
	{
		_obj = _x;
		if (_obj getVariable ["id_bd",-1] isNotEqualTo -1) then {
			private _vars = [allVariables _obj,allVariables _obj apply {_obj getVariable _x}];
			[_obj call BRPVP_typeOfSo,getPosWorld _obj,[vectorDir _obj,vectorUp _obj],_vars,isObjectHidden _obj] remoteExecCall ["BRPVP_transformInLocalInit",_this];
		};
	} forEach allSimpleObjects [];
	{
		private ["_doors","_glasses"];
		private _obj = _x;
		private _class = typeOf _obj;
		private _vars = [allVariables _obj,allVariables _obj apply {_obj getVariable _x}];
		private _idx = BRPVP_allAnimBuildingTypeClassCVL find _class;
		if (_idx isEqualTo -1) then {
			private _doorsStore = (("true" configClasses (configFile >> "CfgVehicles" >> _class >> "AnimationSources")) apply {configName _x}) select {_x select [0,5] isEqualTo "Door_" && _x select [count _x-13,13] isEqualTo "_sound_source"};
			private _glassesStore = ((getAllHitPointsDamage _obj+[[],[]]) select 1) select {_x find "glass_" isEqualTo 0};
			BRPVP_allAnimBuildingTypeClassCVL pushBack _class;
			BRPVP_allAnimBuildingTypeCasesCVL pushBack [_doorsStore,_glassesStore];
			_doors = _doorsStore apply {[_x,_obj animationSourcePhase _x]};
			_glasses = _glassesStore apply {[_x,_obj getHit _x]};
		} else {
			_doors = (BRPVP_allAnimBuildingTypeCasesCVL select _idx select 0) apply {[_x,_obj animationSourcePhase _x]};
			_glasses = (BRPVP_allAnimBuildingTypeCasesCVL select _idx select 1) apply {[_x,_obj getHit _x]};
		};
		[_obj call BRPVP_typeOfSo,getPosWorld _obj,[vectorDir _obj,vectorUp _obj],_vars,isObjectHidden _obj,_doors,_glasses] remoteExecCall ["BRPVP_transformInLocalInitCVL",_this];
	} forEach BRPVP_allMissionObjectsCVL;
	{
		private _obj = _x;
		private _vars = [allVariables _obj,allVariables _obj apply {_obj getVariable _x}];
		[_obj call BRPVP_typeOfSo,getPosWorld _obj,[vectorDir _obj,vectorUp _obj],_vars,isObjectHidden _obj] remoteExecCall ["BRPVP_transformInLocalInitTires",_this];
	} forEach BRPVP_tireAllTiresGlobal;
};
BRPVP_hideGlobalSimpleObjectCVL = {
	params ["_classes","_allIds","_hide"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach (_x call BRPVP_getSegSimpleObjectCVL);
	} forEach _classes;
	{
		if (BRPVP_xrayObj isEqualTo _x) then {BRPVP_xrayObj = objNull;};
		_x hideObject _hide;
	} forEach _objs;
};
BRPVP_hideGlobalSimpleObject = {
	params ["_classes","_allIds","_hide"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach allSimpleObjects ([[_x],[]] select (_x isEqualTo ""));
	} forEach _classes;
	{
		if (BRPVP_xrayObj isEqualTo _x) then {BRPVP_xrayObj = objNull;};
		_x hideObject _hide;
	} forEach _objs;
};
BRPVP_typeOfSo = {
	private _to = typeOf _this;
	if (_to isEqualTo "") then {getModelInfo _this select 1} else {_to};
};
BRPVP_atualizaMeuStuffAmgSimpleObjectCVL = {
	params ["_classes","_allIds","_amgPlayer"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach (_x call BRPVP_getSegSimpleObjectCVL);
	} forEach _classes;
	{
		_amg = _x getVariable ["amg",[[],[],true]];
		_tempCst = (_x getVariable ["stp",-1]) in [1,2];
		_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
		_amg set [0,_amgPlayer];
		_x setVariable ["amg",_amg];
		if (!hasInterface) then {_x setVariable ["slv_amg",true];};
	} forEach _objs;
};
BRPVP_atualizaMeuStuffAmgSimpleObject = {
	params ["_classes","_allIds","_amgPlayer"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach allSimpleObjects ([[_x],[]] select (_x isEqualTo ""));
	} forEach _classes;
	{
		_amg = _x getVariable ["amg",[[],[],true]];
		_tempCst = (_x getVariable ["stp",-1]) in [1,2];
		_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
		_amg set [0,_amgPlayer];
		_x setVariable ["amg",_amg];
		if (!hasInterface) then {_x setVariable ["slv_amg",true];};
	} forEach _objs;
};
BRPVP_deixarDeConfiarCustomCCSimpleObjectCVL = {
	params ["_classes","_allIds","_id_bd"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach (_x call BRPVP_getSegSimpleObjectCVL);
	} forEach _classes;
	{
		_amg = _x getVariable ["amg",[[],[],true]];
		_tempCst = (_x getVariable ["stp",-1]) in [1,2];
		_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
		_amg set [1,(_amg select 1)-[_id_bd]];
		_x setVariable ["amg",_amg];
		if (!hasInterface) then {_x setVariable ["slv_amg",true];};
		if (hasInterface) then {_x call BRPVP_closeDoorsIfNoAccess;};
	} forEach _objs;
};
BRPVP_deixarDeConfiarCustomCCSimpleObject = {
	params ["_classes","_allIds","_id_bd"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach allSimpleObjects ([[_x],[]] select (_x isEqualTo ""));
	} forEach _classes;
	{
		_amg = _x getVariable ["amg",[[],[],true]];
		_tempCst = (_x getVariable ["stp",-1]) in [1,2];
		_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
		_amg set [1,(_amg select 1)-[_id_bd]];
		_x setVariable ["amg",_amg];
		if (!hasInterface) then {_x setVariable ["slv_amg",true];};
	} forEach _objs;
};
BRPVP_confiarEmAlguemCustomCCSimpleObjectCVL = {
	params ["_classes","_allIds","_id_bd"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach (_x call BRPVP_getSegSimpleObjectCVL);
	} forEach _classes;
	{
		_amg = _x getVariable ["amg",[[],[],true]];
		_tempCst = (_x getVariable ["stp",-1]) in [1,2];
		_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
		(_amg select 1) pushBackUnique _id_bd;
		_x setVariable ["amg",_amg];
		if (!hasInterface) then {_x setVariable ["slv_amg",true];};
		if (hasInterface) then {_x call BRPVP_closeDoorsIfNoAccess;};
	} forEach _objs;
};
BRPVP_confiarEmAlguemCustomCCSimpleObject = {
	params ["_classes","_allIds","_id_bd"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach allSimpleObjects ([[_x],[]] select (_x isEqualTo ""));
	} forEach _classes;
	{
		_amg = _x getVariable ["amg",[[],[],true]];
		_tempCst = (_x getVariable ["stp",-1]) in [1,2];
		_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
		(_amg select 1) pushBackUnique _id_bd;
		_x setVariable ["amg",_amg];
		if (!hasInterface) then {_x setVariable ["slv_amg",true];};
	} forEach _objs;
};
BRPVP_changePropsOwnerManySimpleObjectCVL = {
	params ["_classes","_allIds","_newOwner","_idGiver"];
	if (!isNull _newOwner) then {
		private _objs = [];
		{
			private _ids = _allIds select _forEachIndex;
			private _count = count _ids;
			private _n = 0;
			{
				if (_x getVariable ["id_bd",-1] in _ids) then {
					_objs pushBack _x;
					_n = _n+1;
					if (_n isEqualTo _count) then {break};
				};
			} forEach (_x call BRPVP_getSegSimpleObjectCVL);
		} forEach _classes;
		{
			_obj = _x;
			_obj setVariable ["own",_newOwner getVariable "id_bd"];
			_amg = _obj getVariable ["amg",[[],[],true]];
			_amgCst = if (count _amg > 1) then {_amg select 1} else {[]};
			_amgCstBoo = if (count _amg > 2) then {_amg select 2} else {true};
			_obj setVariable ["amg",[_newOwner getVariable ["amg",[]],_amgCst,_amgCstBoo]];
			if (!hasInterface) then {_obj setVariable ["slv_amg",true];};
		} forEach _objs;

		//MY UPDATES RELATIVE TO THE OBJECT
		if (player getVariable ["id_bd",-1] isEqualTo _idGiver) then {
			if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
			call BRPVP_findMyFlags;
		};

		//OBJECT RECEIVER UPDATES RELATIVE TO THE OBJECT
		if (local _newOwner) then {
			if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
			call BRPVP_findMyFlags;
		};
	};
};
BRPVP_changePropsOwnerManySimpleObject = {
	params ["_classes","_allIds","_newOwner","_idGiver"];
	if (!isNull _newOwner) then {
		private _objs = [];
		{
			private _ids = _allIds select _forEachIndex;
			private _count = count _ids;
			private _n = 0;
			{
				if (_x getVariable ["id_bd",-1] in _ids) then {
					_objs pushBack _x;
					_n = _n+1;
					if (_n isEqualTo _count) then {break};
				};
			} forEach allSimpleObjects ([[_x],[]] select (_x isEqualTo ""));
		} forEach _classes;
		{
			_obj = _x;
			_obj setVariable ["own",_newOwner getVariable "id_bd"];
			_amg = _obj getVariable ["amg",[[],[],true]];
			_amgCst = if (count _amg > 1) then {_amg select 1} else {[]};
			_amgCstBoo = if (count _amg > 2) then {_amg select 2} else {true};
			_obj setVariable ["amg",[_newOwner getVariable ["amg",[]],_amgCst,_amgCstBoo]];
			if (!hasInterface) then {_obj setVariable ["slv_amg",true];};
		} forEach _objs;

		//MY UPDATES RELATIVE TO THE OBJECT
		if (player getVariable ["id_bd",-1] isEqualTo _idGiver) then {
			if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
			call BRPVP_findMyFlags;
		};

		//OBJECT RECEIVER UPDATES RELATIVE TO THE OBJECT
		if (local _newOwner) then {
			if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
			call BRPVP_findMyFlags;
		};
	};
};
BRPVP_setObjShareTypeSimpleObjectCVL = {
	params ["_classes","_allIds","_newStp","_useCustom"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach (_x call BRPVP_getSegSimpleObjectCVL);
	} forEach _classes;
	{
		_obj = _x;
		_obj setVariable ["stp",_newStp];
		_amg = _obj getVariable ["amg",[[],[],_newStp in [1,2]]];
		if (count _amg isEqualTo 0 || {typeName (_amg select 0) isEqualTo "SCALAR"}) then {
			_amg = [_amg,[],_useCustom];
		} else {
			if (count _amg isEqualTo 2 && typeName (_amg select 0) isEqualTo "ARRAY") then {_amg pushBack _useCustom;} else {_amg set [2,_useCustom];};
		};
		_obj setVariable ["amg",_amg];
		if (!hasInterface) then {_obj setVariable ["slv_amg",true];};
		if (hasInterface) then {_x call BRPVP_closeDoorsIfNoAccess;};
	} forEach _objs;
};
BRPVP_setObjShareTypeSimpleObject = {
	params ["_classes","_allIds","_newStp","_useCustom"];
	private _objs = [];
	{
		private _ids = _allIds select _forEachIndex;
		private _count = count _ids;
		private _n = 0;
		{
			if (_x getVariable ["id_bd",-1] in _ids) then {
				_objs pushBack _x;
				_n = _n+1;
				if (_n isEqualTo _count) then {break};
			};
		} forEach allSimpleObjects ([[_x],[]] select (_x isEqualTo ""));
	} forEach _classes;
	{
		_obj = _x;
		_obj setVariable ["stp",_newStp];
		_amg = _obj getVariable ["amg",[[],[],_newStp in [1,2]]];
		if (count _amg isEqualTo 0 || {typeName (_amg select 0) isEqualTo "SCALAR"}) then {
			_amg = [_amg,[],_useCustom];
		} else {
			if (count _amg isEqualTo 2 && typeName (_amg select 0) isEqualTo "ARRAY") then {_amg pushBack _useCustom;} else {_amg set [2,_useCustom];};
		};
		_obj setVariable ["amg",_amg];
		if (!hasInterface) then {_obj setVariable ["slv_amg",true];};
	} forEach _objs;
};
BRPVP_mudaDonoPropriedadeSimpleObjectCVL = {
	params ["_class","_id","_newOwner","_player"];
	_obj = objNull;
	{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_obj = _x;};} forEach (_class call BRPVP_getSegSimpleObjectCVL);
	if (isNull _newOwner) then {
		_obj setVariable ["own",-1];
		_obj setVariable ["amg",[[],[],true]];
		_obj setVariable ["stp",1];
	} else {
		_obj setVariable ["own",_newOwner getVariable "id_bd"];
		_amg = _obj getVariable ["amg",[[],[],true]];
		_amgCst = if (count _amg > 1) then {_amg select 1} else {[]};
		_amgCstBoo = if (count _amg > 2) then {_amg select 2} else {true};
		_obj setVariable ["amg",[_newOwner getVariable ["amg",[]],_amgCst,_amgCstBoo]];
	};
	if (!hasInterface) then {_obj setVariable ["slv_amg",true];};
	if (hasInterface) then {_x call BRPVP_closeDoorsIfNoAccess;};

	//MY UPDATES RELATIVE TO THE OBJECT
	if ((visibleGPS || visibleMap) && local _player) then {
		BRPVP_mapDrawReset = true;
		call BRPVP_findMyFlags;
	};
	
	//OBJECT RECEIVER UPDATES RELATIVE TO THE OBJECT
	if (local _newOwner) then {
		if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
		[localize "str_props_received",-4] call BRPVP_hint;
		call BRPVP_findMyFlags;
	};
};
BRPVP_mudaDonoPropriedadeSimpleObject = {
	params ["_class","_id","_newOwner","_player"];
	_obj = objNull;
	{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_obj = _x;};} forEach allSimpleObjects ([[_class],[]] select (_class isEqualTo ""));
	if (isNull _newOwner) then {
		_obj setVariable ["own",-1];
		_obj setVariable ["amg",[[],[],true]];
		_obj setVariable ["stp",1];
	} else {
		_obj setVariable ["own",_newOwner getVariable "id_bd"];
		_amg = _obj getVariable ["amg",[[],[],true]];
		_amgCst = if (count _amg > 1) then {_amg select 1} else {[]};
		_amgCstBoo = if (count _amg > 2) then {_amg select 2} else {true};
		_obj setVariable ["amg",[_newOwner getVariable ["amg",[]],_amgCst,_amgCstBoo]];
	};
	if (!hasInterface) then {_obj setVariable ["slv_amg",true];};

	//MY UPDATES RELATIVE TO THE OBJECT
	if ((visibleGPS || visibleMap) && local _player) then {
		BRPVP_mapDrawReset = true;
		call BRPVP_findMyFlags;
	};
	
	//OBJECT RECEIVER UPDATES RELATIVE TO THE OBJECT
	if (local _newOwner) then {
		if (visibleGPS || visibleMap) then {BRPVP_mapDrawReset = true;};
		[localize "str_props_received",-4] call BRPVP_hint;
		call BRPVP_findMyFlags;
	};
};
BRPVP_removeObjectSimpleObjectCVL = {
	params ["_class","_id"];
	private _obj = objNull;
	{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_obj = _x;};} forEach BRPVP_allMissionObjectsCVL;
	if (!hasInterface) then {
		if (_class isEqualTo "Land_GarbageBin_02_F") then {_obj call BRPVP_areaCleanerUndo;};
		if (_class isEqualTo "Land_Shovel_F") then {_obj call BRPVP_removeNearestTreeUndo;};
		_id remoteExecCall ["BRPVP_veiculoMorreuSimpleObject",2];
	};
	BRPVP_allMissionObjectsCVL deleteAt (BRPVP_allMissionObjectsCVL find _obj);
	private _idx = BRPVP_allMissionObjectsCVLSegClass find _class;
	if (_idx isNotEqualTo -1) then {(BRPVP_allMissionObjectsCVLSegObjs select _idx) deleteAt ((BRPVP_allMissionObjectsCVLSegObjs select _idx) find _obj);};
	deleteVehicle _obj;
};
BRPVP_removeObjectSimpleObject = {
	params ["_class","_id"];
	private _obj = objNull;
	{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_obj = _x;};} forEach allSimpleObjects ([[_class],[]] select (_class isEqualTo ""));
	if (!hasInterface) then {
		if (_class isEqualTo "Land_GarbageBin_02_F") then {_obj call BRPVP_areaCleanerUndo;};
		if (_class isEqualTo "Land_Shovel_F") then {_obj call BRPVP_removeNearestTreeUndo;};
		_id remoteExecCall ["BRPVP_veiculoMorreuSimpleObject",2];
	};
	deleteVehicle _obj;
};
BRPVP_transformInLocalInitTires = {
	params ["_class","_posW","_vdu","_vars","_hidden"];
	private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
	_CVL setVectorDirAndUp _vdu;
	_CVL setPosWorld _posW;
	{_CVL setVariable [_x,_vars select 1 select _forEachIndex]} forEach (_vars select 0);
	if (_hidden) then {_CVL hideObject true;};
	BRPVP_tireAllTiresGlobal pushBack _CVL;
	_CVL enableSimulation false;

	//CUSTOM TEXTURE
	{
		_x params ["_classes","_texture","_q"];
		if (_class in _classes) exitWith {
			for "_i" from 0 to _q do {_CVL setObjectMaterial [_i,"\a3\data_f\default.rvmat"];};
			for "_i" from 0 to _q do {_CVL setObjectTexture [_i,BRPVP_imagePrefix+_texture];};
		};
	} forEach BRPVP_extraTextures;
};
BRPVP_transformInLocalInitCVL = {
	params ["_class","_posW","_vdu","_vars","_hidden","_doors","_glasses"];
	private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
	_CVL setVectorDirAndUp _vdu;
	_CVL setPosWorld _posW;
	{_CVL setVariable [_x,_vars select 1 select _forEachIndex]} forEach (_vars select 0);
	if (_hidden) then {_CVL hideObject true;};
	{
		_x params ["_aName","_phase"];
		if (_CVL animationSourcePhase _aName isNotEqualTo _phase) then {_CVL animateSource [_aName,_phase,true];};
	} forEach _doors;
	{
		_x params ["_aName","_damage"];
		if (_CVL getHit _aName isNotEqualTo _damage) then {_CVL setHit [_aName,_damage,false];};
	} forEach _glasses;
	_CVL addEventHandler ["HandleDamage",{call BRPVP_buildingHDEHCVL;}];
	BRPVP_allMissionObjectsCVL pushBack _CVL;
	private _idx = BRPVP_allMissionObjectsCVLSegClass find _class;
	if (_idx isEqualTo -1) then {
		BRPVP_allMissionObjectsCVLSegClass pushBack _class;
		BRPVP_allMissionObjectsCVLSegObjs pushBack [_CVL];
	} else {
		BRPVP_allMissionObjectsCVLSegObjs select _idx pushBack _CVL;
	};

	//CUSTOM TEXTURE
	{
		_x params ["_classes","_texture","_q"];
		if (_class in _classes) exitWith {
			for "_i" from 0 to _q do {_CVL setObjectMaterial [_i,"\a3\data_f\default.rvmat"];};
			for "_i" from 0 to _q do {_CVL setObjectTexture [_i,BRPVP_imagePrefix+_texture];};
		};
	} forEach BRPVP_extraTextures;
};
BRPVP_transformInLocalInit = {
	params ["_class","_posW","_vdu","_vars","_hidden"];
	private _sol = createSimpleObject [_class,AGLToASL BRPVP_posicaoFora,true];
	_sol setVectorDirAndUp _vdu;
	_sol setPosWorld _posW;
	{_sol setVariable [_x,_vars select 1 select _forEachIndex]} forEach (_vars select 0);
	if (_hidden) then {_sol hideObject true;};

	//CUSTOM TEXTURE
	private _vrColors = _sol getVariable ["brpvp_vr_colors",[]];
	if (_vrColors isEqualTo []) then {
		{
			_x params ["_classes","_texture","_q"];
			if (_class in _classes) exitWith {
				for "_i" from 0 to _q do {_sol setObjectMaterial [_i,"\a3\data_f\default.rvmat"];};
				for "_i" from 0 to _q do {_sol setObjectTexture [_i,BRPVP_imagePrefix+_texture];};
			};
		} forEach BRPVP_extraTextures;
	} else {
		[_sol,_vrColors#0,_vrColors#1] call BRPVP_vrObjectSetTextures;
	};
};
BRPVP_transformInLocalCVL = {
	params ["_class","_posW","_vdu","_vars"];
	private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
	_CVL setVectorDirAndUp _vdu;
	_CVL setPosWorld _posW;
	{_CVL setVariable [_x,_vars select 1 select _forEachIndex]} forEach (_vars select 0);
	if (hasInterface) then {if (_CVL call BRPVP_isBaseMapDraw) then {_CVL call BRPVP_consAddToMapSeePersonalArray;};};
	_CVL addEventHandler ["HandleDamage",{call BRPVP_buildingHDEHCVL;}];
	_CVL call BRPVP_setInitialAnimations;
	_CVL setFeatureType 0;
	BRPVP_allMissionObjectsCVL pushBack _CVL;
	private _idx = BRPVP_allMissionObjectsCVLSegClass find _class;
	if (_idx isEqualTo -1) then {
		BRPVP_allMissionObjectsCVLSegClass pushBack _class;
		BRPVP_allMissionObjectsCVLSegObjs pushBack [_CVL];
	} else {
		BRPVP_allMissionObjectsCVLSegObjs select _idx pushBack _CVL;
	};

	//CUSTOM TEXTURE
	{
		_x params ["_classes","_texture","_q"];
		if (_class in _classes) exitWith {
			for "_i" from 0 to _q do {_CVL setObjectMaterial [_i,"\a3\data_f\default.rvmat"];};
			for "_i" from 0 to _q do {_CVL setObjectTexture [_i,BRPVP_imagePrefix+_texture];};
		};
	} forEach BRPVP_extraTextures;
};
BRPVP_transformInLocal = {
	params ["_class","_posW","_vdu","_vars"];
	private _sol = createSimpleObject [_class,AGLToASL BRPVP_posicaoFora,true];
	_sol setVectorDirAndUp _vdu;
	_sol setPosWorld _posW;
	{_sol setVariable [_x,_vars select 1 select _forEachIndex]} forEach (_vars select 0);
	if (hasInterface) then {if (_sol call BRPVP_isBaseMapDraw) then {_sol call BRPVP_consAddToMapSeePersonalArray;};};	
	_sol call BRPVP_setInitialAnimations;
	_sol setFeatureType 0;

	//CUSTOM TEXTURE
	private _vrColors = _sol getVariable ["brpvp_vr_colors",[]];
	if (_vrColors isEqualTo []) then {
		{
			_x params ["_classes","_texture","_q"];
			if (_class in _classes) exitWith {
				for "_i" from 0 to _q do {_sol setObjectMaterial [_i,"\a3\data_f\default.rvmat"];};
				for "_i" from 0 to _q do {_sol setObjectTexture [_i,BRPVP_imagePrefix+_texture];};
			};
		} forEach BRPVP_extraTextures;
	} else {
		[_sol,_vrColors#0,_vrColors#1] call BRPVP_vrObjectSetTextures;
	};
};
BRPVP_moveActionBoxBacksimpleObjectCancelCVL = {
	params ["_class","_id","_vdu","_posW"];
	{
		if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {
			_x setVectorDirAndUp _vdu;
			_x setPosWorld _posW;
		};
	} forEach (_class call BRPVP_getSegSimpleObjectCVL);
};
BRPVP_moveActionBoxBacksimpleObjectCancel = {
	params ["_class","_id","_vdu","_posW"];
	{
		if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {
			_x setVectorDirAndUp _vdu;
			_x setPosWorld _posW;
		};
	} forEach allSimpleObjects ([[_class],[]] select (_class isEqualTo ""));
};
BRPVP_moveActionBoxBacksimpleObjectCVL = {
	params ["_class","_id","_vdu","_posW"];
	{
		if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {
			_x setVectorDirAndUp _vdu;
			_x setPosWorld _posW;
			//RESET FMR MAP RECTANGLE
			_x setVariable ["brpvp_fmr_user",[]];
			//SAVE NEW POSITION TO DATABASE
			if (!hasInterface) then {_x setVariable ["slv",true];};
		};
	} forEach (_class call BRPVP_getSegSimpleObjectCVL);
};
BRPVP_moveActionBoxBacksimpleObject = {
	params ["_class","_id","_vdu","_posW"];
	{
		if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {
			_x setVectorDirAndUp _vdu;
			_x setPosWorld _posW;
			//RESET FMR MAP RECTANGLE
			_x setVariable ["brpvp_fmr_user",[]];
			//SAVE NEW POSITION TO DATABASE
			if (!hasInterface) then {_x setVariable ["slv",true];};
		};
	} forEach allSimpleObjects ([[_class],[]] select (_class isEqualTo ""));
};
BRPVP_setSimpleObjectAwayCVL = {
	params ["_player","_class","_id"];
	{
		if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {
			if (isServer) then {_player setVariable ["brpvp_moving_obj",[_x,getPosWorld _x,[vectorDir _x,vectorUp _x]]];};
			_x setPosATL [random -250,random -250,0];
		};
	} forEach (_class call BRPVP_getSegSimpleObjectCVL);
};
BRPVP_setSimpleObjectAway = {
	params ["_player","_class","_id"];
	{
		if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {
			if (isServer) then {_player setVariable ["brpvp_moving_obj",[_x,getPosWorld _x,[vectorDir _x,vectorUp _x]]];};
			_x setPosATL [random -250,random -250,0];
		};
	} forEach allSimpleObjects ([[_class],[]] select (_class isEqualTo ""));
};
BRPVP_flagExpired = {
	([BRPVP_sessionTimeStamp,_this] call BRPVP_dateDiff) > BRPVP_daysWithoutMantainToFlagDisapears;
};
BRPVP_closeInvIfLookingThisVault = {
	if (_this in BRPVP_inventoryBoxes) then {
		0 spawn {
			_init = time;
			waitUntil {!isNull findDisplay 602 || BRPVP_inventoryBoxes isEqualTo [] || time-_init > 5};
			if (!isNull findDisplay 602) then {(findDisplay 602) closeDisplay 1;};
		};
	};
};
BRPVP_localMoveItemsToGround = {
	params ["_from","_pos"];
	_inv = _from call BRPVP_getCargoArray;
	_flares = [];
	_fClass = BRPVP_moneyItems select 0;
	{if ((_x select 0) in _fClass) then {_flares pushBack (_x select 0);};} forEach magazinesAmmoCargo _from;
	_from call BRPVP_emptyBox;
	{_from addMagazineAmmoCargo [_x,1,1];} forEach _flares;
	_pos = _pos vectorAdd [0,0,0.15];
	[createVehicle ["GroundWeaponHolder",_pos,[],0,"CAN_COLLIDE"],_inv,true] call BRPVP_putItemsOnCargo;
	if (_from getVariable ["brpvp_del_when_empty",false]) then {
		_cargo = magazineCargo _from+weaponCargo _from+itemCargo _from+backPackCargo _from;
		if (_cargo isEqualTo []) then {deleteVehicle _from;};
	};
};
BRPVP_makeUnitFall = {
	params ["_unit","_vec","_damage","_player"];
	private _onPunch = _unit getVariable ["brpvp_on_punch",false];
	if (_onPunch) then {
		if (_damage isNotEqualTo []) then {_damage call BRPVP_processPunchHit;};
	} else {
		_unit setVariable ["brpvp_on_punch",true];
		if (_vec isEqualTo [0,0,0]) then {
			if (_damage isNotEqualTo []) then {_damage call BRPVP_processPunchHit;};
			private _ipa = _unit call BRPVP_isPlayerC && _unit getVariable ["dd",-1] isEqualTo -1;
			if (_ipa) then {
				if (_damage isNotEqualTo []) then {
					private _puncher = _damage select 2;
					private _punchVec = vectorNormalized (getPosASL _unit vectorDiff getPosASL _puncher) vectorMultiply 5 vectorAdd [0,0,1.25];
					_unit setVelocity _punchVec;
				};
				_unit spawn {
					uiSleep 0.75;
					_this setVariable ["brpvp_on_punch",false];
				};
			} else {
				private _iaa = !(_unit call BRPVP_isPlayerC) && _unit getVariable ["ifz",-1] isEqualTo -1 && !(_unit getVariable ["brpvp_tai_dead",false]);
				if (_iaa) then {
					_unit enableAI "ALL";
					_unit setUnconscious true;
					_unit spawn {
						private _unit = _this;
						waitUntil {animationState _unit isEqualTo "unconsciousrevivedefault" || _unit getVariable ["brpvp_tai_dead",false]};
						if !(_unit getVariable ["brpvp_tai_dead",false]) then {
							_unit setUnconscious false;
							[_unit,"UnconsciousOutProne"] remoteExecCall ["switchMove",0];
							uiSleep 1;
							_unit setVariable ["brpvp_on_punch",false];
						};
					};
				} else {
					private _iza = _unit getVariable ["ifz",-1] isNotEqualTo -1 && isNull (_unit getVariable ["klr",objNull]);
					if (_iza) then {
						if (_damage isNotEqualTo []) then {
							private _puncher = _damage select 2;
							private _punchVec = vectorNormalized (getPosASL _unit vectorDiff getPosASL _puncher) vectorMultiply 5 vectorAdd [0,0,1.5];
							_unit setVariable ["brpvp_my_puncher",diag_tickTime];
							_unit disableAI "MOVE";
							_unit setVelocity _punchVec;
						};
						_unit spawn {
							uiSleep 1;
							_this setVariable ["brpvp_on_punch",false];
							_this enableAI "MOVE";
						};
					};
				};
			};
		} else {
			_unit setDamage 0.975;
			if (_unit getVariable ["ifz",-1] isNotEqualTo -1) then {_unit setVariable ["brpvp_my_puncher",diag_tickTime];};
			if (stance _unit in ["STAND","CROUCH"]) then {
				if !(_unit call BRPVP_isPlayerC) then {_unit disableAI "ALL";_unit enableAI "ANIM";};
				[_unit,_vec] remoteExecCall ["setVelocity",0];

				_this spawn {
					params ["_unit","_vec","_damage"];

					uiSleep ((_vec select 2)/9.8);
					waitUntil {getPos _unit select 2 < 0.25};

					if (_damage isNotEqualTo []) then {_damage call BRPVP_processPunchHit;};
					private _ipa = _unit call BRPVP_isPlayerC && _unit getVariable ["dd",-1] isEqualTo -1;
					private _iza = _unit getVariable ["ifz",-1] isNotEqualTo -1 && incapacitatedState _unit isEqualTo "";
					if (_ipa || _iza) then {
						uiSleep 0.75;
						_unit setVariable ["brpvp_on_punch",false];
					} else {
						private _iaa = !(_unit call BRPVP_isPlayerC) && _unit getVariable ["ifz",-1] isEqualTo -1 && !(_unit getVariable ["brpvp_tai_dead",false]);
						if (_iaa) then {
							_unit enableAI "ALL";
							_unit setUnconscious true;
							waitUntil {animationState _unit isEqualTo "unconsciousrevivedefault" || _unit getVariable ["brpvp_tai_dead",false]};
							if !(_unit getVariable ["brpvp_tai_dead",false]) then {
								_unit setUnconscious false;
								[_unit,"UnconsciousOutProne"] remoteExecCall ["switchMove",0];
								uiSleep 1;
								_unit setVariable ["brpvp_on_punch",false];
							};
						};
					};
				};
			} else {
				_this spawn {
					params ["_unit","_vec","_damage"];
					if (_damage isNotEqualTo []) then {_damage call BRPVP_processPunchHit;};
					private _ipa = _unit call BRPVP_isPlayerC && _unit getVariable ["dd",-1] isEqualTo -1;
					private _iza = _unit getVariable ["ifz",-1] isNotEqualTo -1 && incapacitatedState _unit isEqualTo "";
					if (_ipa || _iza) then {
						uiSleep 0.75;
						_unit setVariable ["brpvp_on_punch",false];
					} else {
						private _iaa = !(_unit call BRPVP_isPlayerC) && _unit getVariable ["ifz",-1] isEqualTo -1 && !(_unit getVariable ["brpvp_tai_dead",false]);
						if (_iaa) then {
							_unit enableAI "ALL";
							_unit setUnconscious true;
							waitUntil {animationState _unit isEqualTo "unconsciousrevivedefault" || _unit getVariable ["brpvp_tai_dead",false]};
							if !(_unit getVariable ["brpvp_tai_dead",false]) then {
								_unit setUnconscious false;
								[_unit,"UnconsciousOutProne"] remoteExecCall ["switchMove",0];
								uiSleep 1;
								_unit setVariable ["brpvp_on_punch",false];
							};
						};
					};
				};
			};
		};
	};

	//CHECK IF CONTROLED AI TO SET UNCAPTIVE
	if (alive _unit && _unit getVariable ["id_bd",-1] isEqualTo -1) then {_player remoteExecCall ["BRPVP_possessionPunchUncaptive",_unit];};
};
BRPVP_newerKillerMsg = {
	if (_this iseQualTo 0) then {
		["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\novato.paa'/><br/>-"+localize "str_life",0,0,2,0,0,82573] call BRPVP_fnc_dynamicText;
	} else {
		["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\novato.paa'/><br/>-"+(_this call BRPVP_formatNumber)+"$",0,0,2,0,0,82573] call BRPVP_fnc_dynamicText;
	};
	"error3" call BRPVP_playSound;
};
BRPVP_artySpotInfoAdd = {
	params ["_veh","_dir","_pos"];
	BRPVP_artySpotInfo = BRPVP_artySpotInfo apply {if (serverTime-(_x select 3) > BRPVP_artySpotOnShotTime) then {-1} else {_x};};
	BRPVP_artySpotInfo = BRPVP_artySpotInfo-[-1];
	private _idx = -1;
	{if (_veh isEqualTo (_x select 0)) exitWith {_idx = _forEachIndex;};} forEach BRPVP_artySpotInfo;
	if (_idx isEqualTo -1) then {BRPVP_artySpotInfo pushBack [_veh,_dir,_pos,serverTime];} else {BRPVP_artySpotInfo set [_idx,[_veh,_dir,_pos,serverTime]];};
};
BRPVP_setVehicleDamage = {
	params ["_veh","_life"];
	if (_life select 1 isEqualTo []) then {_life set [1,[[],[]]];};
	_veh setDamage ((_life select 0) min 0.9);
	{_veh setHitIndex [_forEachIndex,_x min 0.9,false];} forEach (_life select 1 select 1);
};
BRPVP_getVehicleAmmo = {
	private _pylons = getPylonMagazines _this;
	private _pylonsQtt = [];
	{
		_qtt = _this ammoOnPylon (_forEachIndex+1);
		_qtt = if (_qtt isEqualTo false) then {0} else {_qtt};
		_pylonsQtt pushBack [_x,_qtt];
	} forEach _pylons;
	private _ammoPart1 = [];
	private _ammoPart2 = [];
	{if ((_x select 0) in _pylons) then {_ammoPart2 pushBack _x;} else {_ammoPart1 pushBack _x;};} forEach magazinesAllTurrets _this;
	_ammoPart2 = _ammoPart2 apply {
		private _idx = _pylonsQtt find [_x select 0,_x select 2];
		if (_idx > -1) then {
			_pylonsQtt set [_idx,-1];
			[_idx,_x]
		} else {
			[0,_x]
		};
	};
	_ammoPart2 sort true;
	_ammoPart2 = _ammoPart2 apply {_x select 1};
	private _ammo = (_ammoPart1+_ammoPart2) apply {_x select [0,3]};
	[fuel _this,_ammo]
};
BRPVP_setVehicleAmmo = {
	params ["_veh","_data"];
	private ["_fuel","_ammo"];
	if (_data in [[],[0]] || {_data select 0 isEqualType []}) then {
		_fuel = 1;
		_ammo = _data;
	} else {
		_fuel = _data select 0;
		_ammo = _data select 1;
	};
	if !(_ammo isEqualTo [0]) then {
		private _pylons = "true" configClasses (configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x};
		private _compat = [];
		{_compat append (_veh getCompatiblePylonMagazines _x);} forEach _pylons;
		_compat = _compat arrayIntersect _compat;
		{_veh setPylonLoadout [_x,""];} forEach _pylons;
		_veh setVehicleAmmo 0;
		{_veh removeMagazineTurret [_x select 0,_x select 1];} forEach magazinesAllTurrets _veh;
		{
			_x params ["_mag","_turr","_ammo"];
			if (_mag in _compat) then {
				private _py = _pylons deleteAt 0;
				_veh setPylonLoadout [_py,_mag,false,_turr-[-1]];
				_veh setAmmoOnPylon [_py,_ammo];
			} else {
				if (_ammo isEqualTo 0) then {
					_veh addMagazineTurret [_mag,_turr,1];
					_veh setMagazineTurretAmmo [_mag,0,_turr];
				} else {
					_veh addMagazineTurret [_mag,_turr,_ammo];
				};
			};
		} forEach _ammo;
		_veh setFuel _fuel;
	};
};
BRPVP_turnOffVehRadar = {
	if (!BRPVP_vehRadarEnabled) then {
		{_this enableVehicleSensor [_x select 0,false];} forEach listVehicleSensors _this;
		{_this enableInfoPanelComponent [_x,"SensorsDisplayComponent",false]} forEach ["left","right"];
		{
			[_this,_x] enableInfoPanelComponent ["left","SensorsDisplayComponent",false];
			[_this,_x] enableInfoPanelComponent ["right","SensorsDisplayComponent",false];
		} forEach allTurrets _this;
	};
};
BRPVP_setVehRadarAndThermal = {
	if (!BRPVP_vehThermalEnabled) then {
		if !(typeOf _this in BRPVP_vehThermalExcludeList) then {
			_this disableTIEquipment true;
		};
	};
};
BRPVP_carrierObjsListRemove = {
	BRPVP_carrierObjsList deleteAt (BRPVP_carrierObjsList find _this);
	BRPVP_carrierObjsList = BRPVP_carrierObjsList-[objNull];
};
BRPVP_carrierObjsListAdd = {
	BRPVP_carrierObjsList pushBackUnique _this;
	BRPVP_carrierObjsList = BRPVP_carrierObjsList-[objNull];
};
BRPVP_bagSoldierDamage = {
	params ["_soldier","_part","_damage","_source","_projectile","_hitIndex","_instigator","_hitPoint"];
	private _tick = _soldier getVariable ["brpvp_tick",-10];
	private _tickNow = diag_tickTime;
	if (_tickNow-_tick > 0.02) then {
		_soldier setVariable ["brpvp_tick",_tickNow];
		_soldier setVariable ["brpvp_key",((_soldier getVariable "brpvp_key")+1) mod 10];
		_soldier setVariable ["brpvp_var",format ["brpvp_dam_%1",_soldier getVariable "brpvp_key"]];
		_soldier setVariable [_soldier getVariable "brpvp_var",0];
		private _ofender = if (isNull _instigator) then {effectiveCommander _source} else {_instigator};
		[_ofender,_soldier,_soldier getVariable "brpvp_var"] spawn {
			params ["_o","_s","_v"];
			sleep 0.02;
			private _dam = _s getVariable _v;
			_dam = (round (_dam*100))/100;
			if (!isNull _o) then {[format [localize "str_bag_soldier_say_dam",_dam],-2] remoteExecCall ["BRPVP_hint",_o];};
			private _pitch = ((2.5*_dam/17.5) min 2.5) max 0.5;
			[_s,["bag_soldier",300,_pitch]] remoteExecCall ["say3D",BRPVP_allNoServer];
		};
	};
	private _damBest = _soldier getVariable (_soldier getVariable "brpvp_var");
	if (_damage > _damBest) then {_soldier setVariable [_soldier getVariable "brpvp_var",_damage];};
	0
};
BRPVP_checaAcessoRemotoFlagNoObj = {
	params ["_objOwn","_flag"];
	private _flagOwn = _flag getVariable ["own",-2];
	private _flagAmg = _flag getVariable ["amg",[[],[],true]];
	_flagAmg = if (count _flagAmg >= 2 && {typeName (_flagAmg select 0) isEqualTo "ARRAY"}) then {_flagAmg select 1} else {[]};
	_objOwn isEqualTo _flagOwn || _objOwn in _flagAmg
};
BRPVP_setAirGodModeForce = {
	params ["_veh","_forceSafe"];
	private _crew = crew _veh;
	private _protected = if (_veh getVariable ["own",-1] isEqualTo -1 || count _crew > 0) then {_forceSafe} else {_veh call BRPVP_checkIfFlagProtected || _forceSafe};
	_protected = _protected || _veh getVariable ["brpvp_veh_godmode",false];
	if (_protected) then {
		if (isDamageAllowed _veh) then {
			_veh allowDamage false;
			[_veh,false] remoteExecCall ["allowDamage",-clientOwner];
			if (!simulationEnabled _veh) then {[_veh,true] remoteExecCall ["enableSimulationGlobal",2];};
		};
	} else {
		if (!isDamageAllowed _veh) then {
			_veh allowDamage true;
			[_veh,true] remoteExecCall ["allowDamage",-clientOwner];
		};
	};
};
BRPVP_setAirGodMode = {
	private _veh = _this;
	private _crew = crew _veh;
	private _protected = if (_veh getVariable ["own",-1] isEqualTo -1 || count _crew > 0) then {_veh call BRPVP_checkIfSafeZoneProtected} else {_veh call BRPVP_checkIfFlagProtected || _veh call BRPVP_checkIfSafeZoneProtected};
	_protected = _protected || _veh getVariable ["brpvp_veh_godmode",false];
	if (_protected) then {
		if (isDamageAllowed _veh) then {
			_veh allowDamage false;
			[_veh,false] remoteExecCall ["allowDamage",-clientOwner];
			if (!simulationEnabled _veh) then {[_veh,true] remoteExecCall ["enableSimulationGlobal",2];};
		};
	} else {
		if (!isDamageAllowed _veh) then {
			_veh allowDamage true;
			[_veh,true] remoteExecCall ["allowDamage",-clientOwner];
		};
	};
};
BRPVP_getGenericPrice = {
	private _item = _this;
	private _price = 0;
	private _rareMult = if (_item in BRPVP_rareItemsPlainList) then {10} else {1};
	if (isClass (configFile >> "CfgVehicles" >> _item)) then {
		_price = 50000;
	} else {
		if (isClass (configFile >> "CfgWeapons" >> _item)) then {
			//HELMETS
			private _isHelm1 = _item isKindOf ["HelmetBase",configFile >> "CfgWeapons"];
			private _isHelm2 = _item isKindOf ["H_HelmetB",configFile >> "CfgWeapons"];
			if (_isHelm1 || _isHelm2) then {
				_price = 40000;
			} else {
				//NV GOGGLES
				private _isNVG = _item isKindOf ["NVGoggles",configFile >> "CfgWeapons"];
				if (_isNVG) then {
					_price = 35000;
				} else {
					//UNIFORMS
					if (_item isKindOf ["Uniform_Base",configFile >> "CfgWeapons"]) then {
						_price = 25000;
					} else {
						//VESTS
						private _isVest1 = _item isKindOf ["Vest_Camo_Base",configFile >> "CfgWeapons"];
						private _isVest2 = _item isKindOf ["Vest_NoCamo_Base",configFile >> "CfgWeapons"];
						if (_isVest1 || _isVest2) then {
							_price = 30000;
						} else {
							//BINOCULAR
							//NVG ARE ALSO BINOCULAR
							private _isBino = _item iskindOf ["Binocular",configFile >> "CfgWeapons"];
							if (_isBino) then {
								_price = 40000;
							} else {
								//WEAPONS
								private _type = getNumber (configFile >> "CfgWeapons" >> _item >> "Type");
								if (_type in [1,2,4]) then {
									if (_type isEqualTo 1) then {
										_price = 65000;
									} else {
										if (_type isEqualTo 2) then {_price = 30000;} else {_price = 150000;};
									};
								} else {
									//ITEM SLOTS (NOT GPS SLOT)
									if (_item in ["ItemCompass","ItemMap","ItemWatch","ItemRadio"]) then {
										_price = 25000;
									} else {
										//GPS SLOT
										private _isGPSSlot1 = _item iskindOf ["UavTerminal_base",configFile >> "CfgWeapons"];
										private _isGPSSlot2 = _item isEqualTo "ItemGPS";
										if (_isGPSSlot1 || _isGPSSlot2) then {
											_price = 40000;
										} else {
											//OTHER
											_price = 30000;
										};
									};
								};											
							};
						};
					};
				};
			};
		} else {
			if (isClass (configFile >> "CfgMagazines" >> _item)) then {
				_price = 3000;
			} else {
				if (isClass (configFile >> "CfgGlasses" >> _item)) then {
					_price = 10000;
				} else {
					private _idx = BRPVP_craftsClassPlain find _item;
					if (_idx > -1) then {
						//BASIC REQUIREMENTS
						private _result = [];
						private _required = BRPVP_crafts select _idx select 1;
						while {count _required > 0} do {
							private _toLower = [];
							{
								_x params ["_class","_q"];
								private _needLower = [];
								{
									private _craft = _x select 0;
									if (_class isEqualTo _craft && !(_craft in BRPVP_craftsNoBaseFrom)) exitWith {_needLower = _x select 1;};
								} forEach BRPVP_crafts;
								if (_needLower isEqualTo []) then {_result pushBack _x;} else {for "_i" from 1 to _q do {_toLower append _needLower;};};
							} forEach _required;
							_required = _toLower;
						};
						{_price = _price+(BRPVP_farmPrivateItemPrice+BRPVP_farmItemPricePlayerWork)*(_x select 1);} forEach _result;
					} else {
						_price = BRPVP_farmPrivateItemPrice+BRPVP_farmItemPricePlayerWork;
					};
				};
			};
		};
	};
	_price*_rareMult
};
BRPVP_createLabirinty = {
	params ["_blocks","_player"];
	{{deleteVehicle _x;} forEach _x;} forEach BRPVP_labObjs;
	private _w1Class = "Land_Wall_IndCnc_4_F";
	private _w2Class = "Land_Wall_IndCnc_4_D_F";
	private _itemPools = [
		[3,[["brpvp_main_container",[[[["arifle_MX_GL_F","","",54,[0,100],[15,1],""],2]],[[0,10,100],[15,8,1]],[[29,99],[1,2]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]]]],
		[3,[["brpvp_main_container",[[[["arifle_SPAR_01_GL_blk_F","","",55,[7,150],[15,1],""],2]],[[15,8,1],[7,8,150]],[[29,99],[1,2]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]]]]
	];
	private _itemPoolsCount = _blocks min 35;
	private _size = 6;
	private _w1Perc = 0.925;
	private _delPerc = 0.6;
	private _noLootBlocks = ceil (_blocks/10);
	private _pPos = ASLToAGL getPosASL _player;
	_pPos set [2,0];
	private _posInit = _pPos vectorAdd [-_size*_blocks/2,-_size*_blocks/2,0];
	private _walls = [];
	private _wHolders = [];
	private _closers = [];
	private _walls2 = [];
	private _blocks2DLoot = (_blocks-_noLootBlocks*2)^2;
	for "_i1" from 0 to _blocks do {
		for "_i2" from 1 to _blocks do {
			private _isCloser = _i1 in [0,_blocks];
			//WALL 1
			private _rndOk = random 1 > _delPerc;
			if (_rndOk || _isCloser) then {
				private _p1 = _posInit vectorAdd [_i1*_size-1,_i2*_size-_size/2,1];
				private _class = if (random 1 < _w1Perc || _isCloser) then {_w1Class} else {_w2Class};
				private _wall = createSimpleObject [_class,AGLToASL _p1];
				_wall setDir 90;
				if (_class isEqualTo _w2Class) then {_wall setPosASL AGLToASL [(_p1 select 0)+0.425*sin 90,(_p1 select 1)+0.425*cos 90,1];};
				if (_rndOk) then {if (_isCloser) then {_walls2 pushBack _wall;} else {_walls pushBack _wall;}} else {_closers pushBack _wall;};
			};
			//WALL 2
			private _p2 = _posInit vectorAdd [_i2*_size-_size/2-1,_i1*_size,1];
			_rndOk = random 1 > _delPerc;
			if (_rndOk || _isCloser) then {
				private _class = if (random 1 < _w1Perc || _isCloser) then {_w1Class} else {_w2Class};
				private _wall = createSimpleObject [_class,AGLToASL _p2];
				if (_class isEqualTo _w2Class) then {_wall setPosASL AGLToASL [(_p2 select 0)+0.425*sin 0,(_p2 select 1)+0.425*cos 0,1];};
				if (_rndOk) then {if (_isCloser) then {_walls2 pushBack _wall;} else {_walls pushBack _wall;}} else {_closers pushBack _wall;};
			};
			//LOOT
			private _i1LootOk = _i1+1 > _noLootBlocks && _i1+1 < (_blocks+1)-_noLootBlocks;
			private _i2LootOk = _i2 > _noLootBlocks && _i2 < (_blocks+1)-_noLootBlocks;
			if (random 1 < _itemPoolsCount/_blocks2DLoot && _i1LootOk && _i2LootOk) then {
				private _wh = createVehicle ["GroundWeaponHolder",_p2 vectorAdd [1,_size/2,-1],[],0,"CAN_COLLIDE"];
				[_wh,selectRandom _itemPools] call BRPVP_putItemsOnCargo;
				_wHolders pushBack _wh;
			};
		};
	};
	private _center = createSimpleObject ["Land_AncientPillar_F",AGLToASL _pPos];
	private _rad = _size*_blocks*sqrt(2)*1.3/2;
	_center setVariable ["brpvp_lab_rad",_rad,true];
	BRPVP_labObjs = [_walls,_wHolders,_closers,[_center],_walls2];
	publicVariable "BRPVP_labObjs";
	BRPVP_labNoThirdPerson = [[_pPos,_rad]];
	publicVariable "BRPVP_labNoThirdPerson";
};
BRPVP_epeContactOn = {
	private _object1 = _this select 0;
	private _antiIsOn = _object1 getVariable ["brpvp_anti_bounce_on",false];
	if (!_antiIsOn) then {
		_object1 setVariable ["brpvp_anti_bounce_on",true];
		_object1 spawn {
			private _last = vectorMagnitude velocity _this;
			private _initCycle = time;
			private _init = time;
			waitUntil {
				private _now = vectorMagnitude velocity _this;
				if (_now-_last > 5) then {
					[_this,[0,0,0]] remoteExecCall ["setVelocity",0];
					_last = 0;
				};
				if (time-_initCycle > 0.05) then {
					_initCycle = time;
					_last = _now;
				};
				time-_init >= 5
			};
			_this setVariable ["brpvp_anti_bounce_on",false];
		};
	};
};
BRPVP_getCargoArrayValor = {
	private _inventory = _this;
	private _fClass = BRPVP_moneyItems select 0;
	private _fValor = BRPVP_moneyItems select 1;
	private _boxValor = 0;
	private _boxValorFlare = 0;
	if (_inventory select 0 isEqualTo 3) then {
		private _paramsArray1 = ["_name","_gear"];
		{
			_x params _paramsArray1;
			_name = if (_name isEqualType 0) then {BRPVP_ItemsClassToNumberTableE select _name} else {_name};
			private _paramsArray2 = ["_wepData","_q"];
			{
				_x params _paramsArray2;
				_e0 = _wepData select 0;
				private _class = if (_e0 isEqualType 1) then {BRPVP_ItemsClassToNumberTableA select _e0} else {_e0};
				_boxValor = _boxValor+((_class call BIS_fnc_baseWeapon) call BRPVP_itemGetPrice)*_q;
			} forEach (_gear select 0);
			{
				private _class = if ((_x select 0) isEqualType 0) then {BRPVP_ItemsClassToNumberTableB select (_x select 0)} else {_x select 0};
				private _q = if (count _x isEqualTo 2) then {1} else {_x select 1};
				private _idx = _fClass find _class;
				if (_idx > -1) then {
					_boxValorFlare = _boxValorFlare+(_fValor select _idx)*_q;
				} else {
					_boxValor = _boxValor+(_class call BRPVP_itemGetPrice)*_q;
				};
			} forEach (_gear select 1);
			{
				private _class = if (_x isEqualType 0) then {BRPVP_ItemsClassToNumberTableC select _x} else {_x};
				private _q = _gear select 2 select 1 select _forEachIndex;
				_boxValor = _boxValor+(_class call BRPVP_itemGetPrice)*_q;
			} forEach (_gear select 2 select 0);
			{
				private _class = if (_x isEqualType 0) then {BRPVP_ItemsClassToNumberTableD select _x} else {_x};
				private _q = _gear select 3 select 1 select _forEachIndex;
				_boxValor = _boxValor+(_class call BRPVP_itemGetPrice)*_q;
			} forEach (_gear select 3 select 0);
		} forEach (_inventory select 1);
	};
	[_boxValor,_boxValorFlare]
};
BRPVP_itemGetPrice = {
	private _price = 0;
	private _idx = BRPVP_getItemPriceHelpTableA find _this;
	if (_idx isEqualTo -1) then {_price = _this call BRPVP_getGenericPrice;} else {_price = BRPVP_getItemPriceHelpTableB select _idx;};
	_price
};
BRPVP_getConstructionPrice = {
	private _idx = BRPVP_getConsPriceHelpTableB find _this;
	if (_idx isEqualTo -1) then {0} else {BRPVP_getConsPriceHelpTableD select (BRPVP_getConsPriceHelpTableC select _idx)};
};
BRPVP_getConstructionKitIdx = {
	private _idx = BRPVP_getConsPriceHelpTableB find _this;
	if (_idx isEqualTo -1) then {
		-1
	} else {
		private _iClass = BRPVP_getConsPriceHelpTable select (BRPVP_getConsPriceHelpTableC select _idx);
		BRPVP_specialItems find _iClass;
	};
};
BRPVP_pushBoat = {
	params ["_veh","_player"];
	[_veh,10] call BRPVP_enableVehOnInteraction;
	_vec = getPosWorld _veh vectorDiff getPosWorld _player;
	_vec set [2,0];
	_vec = vectorNormalized ((vectorNormalized _vec) vectorAdd [0,0,0.5]);
	_pWld = getPosWorld _veh;
	_pWld set [2,(_pWld select 2)+0.5];
	_veh setPosWorld _pWld;
	_veh allowDamage false;
	[_veh,_vec vectorMultiply 8] remoteExecCall ["setVelocity",0];
	sleep 1.5;
	[_veh,[0,0,0]] remoteExecCall ["setVelocity",0];
	sleep 0.2;
	_veh allowDamage true;
	if !(_veh getVariable ["slv",false]) then {_veh setVariable ["slv",true,true];};
};
BRPVP_personalShieldHDEH = {
	_shield = _this select 0;
	_part = _this select 1;
	_damage = _this select 2;
	_projectile = _this select 4;
	if !(_projectile isEqualTo "") then {
		_hurt = _shield getVariable ["brpvp_shurt",0];
		_hurt = _hurt+_damage;
		_shield setVariable ["brpvp_shurt",_hurt];
		if (_hurt >= BRPVP_personalShieldLife*0.13) then {
			deleteVehicle _shield;
			"erro" call BRPVP_playSound;
			BRPVP_personalShieldTime = time+300;
			_txt = "<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\shield.paa'/><br /><t color='#FF0000'>100/100</t>";
			[_txt,0,0,1,0,0,7757] call BRPVP_fnc_dynamicText;
		} else {
			_perc = floor (100*_hurt/(BRPVP_personalShieldLife*0.13));
			_txt = format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\shield.paa'/><br /><t>%1/100</t>",_perc];
			[_txt,0,0,1,0,0,7757] call BRPVP_fnc_dynamicText;
		};
	};
	0
};
BRPVP_isBanditInGoodVeh = {
	private _veh = objectParent _this;
	private _inVeh = !isNull _veh;
	private _isBandit = _this in BRPVP_pveBanditObjList;
	private _haveNoBandit = {_x call BRPVP_isPlayer && !(_x in BRPVP_pveBanditObjList)} count crew _veh > 0;
	_inVeh && _isBandit && _haveNoBandit
};
BRPVP_playerItemsToCargo = {
	params ["_p","_c","_allWeapons"];
	
	//BINOCULAR
	private _bin = binocular _p;
	if (_bin isNotEqualTo "") then {
		_p removeWeaponGlobal _bin;
		_c addItemCargoGlobal [_bin,1];
	};

	//WEAPONS
	private _wRemove = [];
	private _wPlayer = _allWeapons;
	{
		private _class = _x select 0;
		if !(_class isKindOf ["Binocular",configFile >> "CfgWeapons"]) then {
			_c addWeaponWithAttachmentsCargoGlobal [_x,1];
			_wRemove pushBack _class;
		};
	} forEach _wPlayer;
	{_p removeWeaponGlobal _x;} forEach _wRemove;

	//ASSIGNED ITEMS
	private _ait = assignedItems _p;
	_ait deleteAt (_ait find "ItemMap");
	{
		_c addItemCargoGlobal [_x,1];
		private _ib = items _p;
		_p unassignItem _x;
		private _ia = items _p;
		if !(_ia isEqualTo _ib) then {_p removeItem _x;};
	} forEach _ait;
	
	//GOOGLES AND HELMET
	private _g = goggles _p;
	private _h = headGear _p;
	_c addItemCargoGlobal [_g,1];
	_c addItemCargoGlobal [_h,1];
	removeGoggles _p;
	removeHeadGear _p;
	
	//CONTAINERS
	{
		_x params ["_pc","_pcc","_addCode","_finalCode"];
		if (!isNull _pc) then {
			call _addCode;
			_pcd = objNull;

			private _everyContainer = everyContainer _c;
			{if (_x select 0 isEqualTo _pcc) exitWith {_pcd = _x select 1;};} forEach _everyContainer;

			private _notEmpty = loadAbs _pcd isNotEqualTo 0;
			if (_notEmpty) then {_pcd call BRPVP_emptyBox;};

			private _weaponsItemsCargo = weaponsItemsCargo _pc;
			{_pcd addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _weaponsItemsCargo;

			private _magazinesAmmoCargo = magazinesAmmoCargo _pc;
			{_pcd addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach _magazinesAmmoCargo;

			private _ic = getItemCargo _pc;
			{_pcd addItemCargoGlobal [_x,_ic select 1 select _forEachIndex];} forEach (_ic select 0);
			call _finalCode;
		};
	} forEach [
		[vestContainer _p,vest _p,{_c addItemCargoGlobal [_pcc,1];},{removeVest _p;}],
		[backpackContainer _p,backpack _p,{_c addBackpackCargoGlobal [_pcc,1];},{removeBackpack _p;}]
	];
};
BRPVP_playerUniformToCargo = {
	params ["_p","_c"];

	//CONTAINERS
	{
		_x params ["_pc","_pcc","_addCode","_finalCode"];
		if (!isNull _pc) then {
			call _addCode;
			_pcd = objNull;

			private _everyContainer = everyContainer _c;
			{if (_x select 0 isEqualTo _pcc) exitWith {_pcd = _x select 1;};} forEach _everyContainer;

			private _notEmpty = loadAbs _pcd isNotEqualTo 0;
			if (_notEmpty) then {_pcd call BRPVP_emptyBox;};

			private _weaponsItemsCargo = weaponsItemsCargo _pc;
			{_pcd addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _weaponsItemsCargo;

			private _magazinesAmmoCargo = magazinesAmmoCargo _pc;
			{_pcd addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach _magazinesAmmoCargo;

			private _ic = getItemCargo _pc;
			{_pcd addItemCargoGlobal [_x,_ic select 1 select _forEachIndex];} forEach (_ic select 0);
			call _finalCode;
		};
	} forEach [
		[uniformContainer _p,uniform _p,{_c addItemCargoGlobal [_pcc,1];},{(uniformContainer _p) call BRPVP_emptyBox;}]
	];
};
BRPVP_playerItemsToCargoNoUniform = {
	params ["_p","_c"];
	
	//BINOCULAR
	private _bin = binocular _p;
	if !(_bin isEqualTo "") then {
		_p removeWeaponGlobal _bin;
		_c addItemCargoGlobal [_bin,1];
	};

	//WEAPONS
	private _wP = weaponsItems _p;
	private _wC = (weaponsItemsCargo backpackContainer player)+(weaponsItemsCargo vestContainer player)+(weaponsItemsCargo uniformContainer player);
	{_wP deleteAt (_wP find _x);} forEach _wC;
	{
		private _class = _x select 0;
		if !(_class isKindOf ["Binocular",configFile >> "CfgWeapons"]) then {
			_c addWeaponWithAttachmentsCargoGlobal [_x,1];
			_p removeWeaponGlobal _class;
		};
	} forEach _wP;

	//ASSIGNED ITEMS
	private _ait = assignedItems _p;
	_ait deleteAt (_ait find "ItemMap");
	{
		_c addItemCargoGlobal [_x,1];
		private _ib = items _p;
		_p unassignItem _x;
		private _ia = items _p;
		if !(_ia isEqualTo _ib) then {_p removeItem _x;};
	} forEach _ait;
	
	//GOOGLES AND HELMET
	private _g = goggles _p;
	private _h = headGear _p;
	_c addItemCargoGlobal [_g,1];
	_c addItemCargoGlobal [_h,1];
	removeGoggles _p;
	removeHeadGear _p;
	
	//CONTAINERS (NO UNIFORM)
	{
		_x params ["_pc","_pcc","_addCode","_finalCode"];
		if (!isNull _pc) then {
			call _addCode;
			_pcd = objNull;

			private _everyContainer = everyContainer _c;
			{if (_x select 0 isEqualTo _pcc) exitWith {_pcd = _x select 1;};} forEach _everyContainer;

			private _notEmpty = loadAbs _pcd isNotEqualTo 0;
			if (_notEmpty) then {_pcd call BRPVP_emptyBox;};

			private _weaponsItemsCargo = weaponsItemsCargo _pc;
			{_pcd addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _weaponsItemsCargo;

			private _magazinesAmmoCargo = magazinesAmmoCargo _pc;
			{_pcd addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach _magazinesAmmoCargo;

			private _ic = getItemCargo _pc;
			{_pcd addItemCargoGlobal [_x,_ic select 1 select _forEachIndex];} forEach (_ic select 0);
			call _finalCode;
		};
	} forEach [
		[vestContainer _p,vest _p,{_c addItemCargoGlobal [_pcc,1];},{removeVest _p;}],
		[backpackContainer _p,backpack _p,{_c addBackpackCargoGlobal [_pcc,1];},{removeBackpack _p;}]
	];
	
	//UNIFORM ITEMS
	private _pc = uniformContainer _p;

	private _weaponsItemsCargo = weaponsItemsCargo _pc;
	{_c addWeaponWithAttachmentsCargoGlobal [_x,1];} forEach _weaponsItemsCargo;

	private _magazinesAmmoCargo = magazinesAmmoCargo _pc;
	{_c addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach _magazinesAmmoCargo;

	private _ic = getItemCargo _pc;
	{_c addItemCargoGlobal [_x,_ic select 1 select _forEachIndex];} forEach (_ic select 0);
	_pc call BRPVP_emptyBox;
};
BRPVP_getUAVPlayer = {
	private _cont = UAVControl _this;
	private _result = objNull;
	if (count _cont isEqualTo 2) then {
		private _p = _cont select 0;
		if (!isNull _p) then {
			private _role = _cont select 1;
			if !(_role isEqualTo "") then {_result = _p;};
		};
	} else {
		if (count _cont isEqualTo 4) then {_result = _cont select 0;};
	};
	_result
};
BRPVP_controlingUAVGetFakeUnitUsing = {
	private _UAV = getConnectedUAV _this;
	if (isNull _UAV) then {
		objNull
	} else {
		private _ctrl = UAVControl _UAV;
		if (_ctrl isEqualTo [_this,"DRIVER"]) exitWith {driver _UAV};
		if (_ctrl isEqualTo [_this,"GUNNER"]) exitWith {gunner _UAV};
		if (count _ctrl isEqualTo 4) then {
			private _idx = _ctrl find _this;
			if (_idx isEqualTo -1) then {
				objNull
			} else {
				if (_ctrl select (_idx+1) isEqualTo "DRIVER") exitWith {driver _UAV};
				if (_ctrl select (_idx+1) isEqualTo "GUNNER") exitWith {gunner _UAV};
			};
		} else {
			objNull
		};
	};
};
BRPVP_controlingUAV = {
	private _UAV = getConnectedUAV _this;
	if (isNull _UAV) then {
		objNull
	} else {
		private _ctrl = UAVControl _UAV;
		private _isOn = (_ctrl isEqualTo [_this,"DRIVER"] || _ctrl isEqualTo [_this,"GUNNER"]) || (count _ctrl isEqualTo 4 && _this in _ctrl);
		if (_isOn) then {_UAV} else {objNull};
	};
};
BRPVP_removeRuins = {
	private _veh = _this;
	{if (_x getVariable ["brpvp_ai",false]) then {_veh deleteVehicleCrew _x;};} forEach crew _veh;
	{deleteVehicle _x} forEach attachedObjects _veh;
	_veh spawn {sleep 0.25;deleteVehicle _this;};
};
BRPVP_baseBombAddLines = {
	BRPVP_baseBombDestroyedLines append _this;
};
BRPVP_baseBombChangeToGreenMany = {
	{_x call BRPVP_baseBombChangeToGreen;} forEach _this;
};
BRPVP_baseBombChangeToGreen = {
	private _paramsArray = ["_pos","_lines","_id","_color"];
	{
		_x params _paramsArray;
		if (_id isEqualTo _this) then {
			(BRPVP_baseBombDestroyedLines select _forEachIndex) set [1,_lines apply {[_x select 0,_x select 1,[0,1,0,1]]}];
			(BRPVP_baseBombDestroyedLines select _forEachIndex) set [3,"green"];
		};
	} forEach BRPVP_baseBombDestroyedLines;
};
BRPVP_getPlaneVertices = {
	private _bbr = boundingBoxReal _this;
	private _p1 = _bbr select 0;
	private _p2 = _bbr select 1;
	private _p1x = _p1 select 0;
	private _p1y = _p1 select 1;
	private _p2x = _p2 select 0;
	private _p2y = _p2 select 1;
	private _h = ((_p1 select 2) min (_p2 select 2))+1;
	private _points = [
		[_p1x,_p1y,_h],
		[_p1x,_p2y,_h],
		[_p2x,_p1y,_h],
		[_p2x,_p2y,_h],
		[(_p1x+_p2x)/2,_p1y],
		[(_p1x+_p2x)/2,_p2y],
		[_p1x,(_p1y+_p2y)/2],
		[_p2x,(_p1y+_p2y)/2]
	];
	_points apply {_this modelToWorld _x}
};
BRPVP_getCubeVertices = {
	private _bbr = boundingBoxReal _this;
	private _p1 = _bbr select 0;
	private _p2 = _bbr select 1;
	private _p1x = _p1 select 0;
	private _p1y = _p1 select 1;
	private _p1z = _p1 select 2;
	private _p2x = _p2 select 0;
	private _p2y = _p2 select 1;
	private _p2z = _p2 select 2;
	private _points = [
		[_p1x,_p1y,_p1z],
		[_p2x,_p1y,_p1z],
		[_p1x,_p2y,_p1z],
		[_p1x,_p1y,_p2z],
		[_p2x,_p2y,_p2z],
		[_p1x,_p2y,_p2z],
		[_p2x,_p1y,_p2z],
		[_p2x,_p2y,_p1z]
	];
	_points apply {_this modelToWorld _x}
};
BRPVP_getCubeDrawCoords = {
	private _result = [];
	private _shape = _this select 1;
	private _color = _this select 2;
	{
		private _obj = _x;
		private _bbr = boundingBoxReal _obj;
		private _p1 = _bbr select 0;
		private _p2 = _bbr select 1;
		private _p1x = _p1 select 0;
		private _p1y = _p1 select 1;
		private _p1z = _p1 select 2;
		private _p2x = _p2 select 0;
		private _p2y = _p2 select 1;
		private _p2z = _p2 select 2;
		private _points = [
			[_p1x,_p1y,_p1z],
			[_p2x,_p1y,_p1z],
			[_p1x,_p2y,_p1z],
			[_p1x,_p1y,_p2z],
			[_p2x,_p2y,_p2z],
			[_p1x,_p2y,_p2z],
			[_p2x,_p1y,_p2z],
			[_p2x,_p2y,_p1z]
		];
		private _array = [];
		while {count _points > 0} do {
			_pk = _points deleteAt 0;
			_pkw = _obj modelToWorldVisual _pk;
			{
				_pn = _x;
				_sameQ = 0;
				{if ((_pk select _forEachIndex) isEqualTo _x) then {_sameQ = _sameQ+1;};} forEach _pn;
				if (_sameQ >= _shape) then {_array pushBack [_pkw,_obj modelToWorld _pn,_color];};
			} forEach _points;
		};
		_result pushBack [ASLToAGL getPosASL _obj,_array,_obj getVariable ["id_bd",-1],"red"];
	} forEach (_this select 0);
	_result
};
BRPVP_spcItemsLootCreateAtomicBomb = {
	params ["_pos","_spcItems"];
	_obj = createVehicle [BRPVP_spcItemsClass,_pos,[],10,"NONE"];
	_obj setVariable ["brpvp_spc_items",_spcItems,true];
};
BRPVP_spcItemsLootCreate = {
	params ["_pos","_spcItems"];
	_obj = createVehicle [BRPVP_spcItemsClass,[0,0,0],[],0,"CAN_COLLIDE"];
	_obj setPosASL AGLToASL _pos;
	_obj setVariable ["brpvp_spc_items",_spcItems,true];
	_obj
};
BRPVP_getWeekDay = {
	private _date = [_this select 0,_this select 1,_this select 2,0,0];
	private _year = _date select 0;
	private _yearBefore = (_year-1) max 0;
	private _qttLeapYears = floor (_yearBefore/4);
	private _qttNormalYears = _yearBefore-_qttLeapYears;
	private _days = _qttNormalYears+_qttLeapYears*(366/365);
	_days = _days+dateToNumber _date;
	(round (_days/(1/365))) mod 7
};
BRPVP_emptyBox = {
	clearWeaponCargoGlobal _this;
	clearMagazineCargoGlobal _this;
	clearItemCargoGlobal _this;
	clearBackpackCargoGlobal _this;
};

//=================================================
// FLAG STATUS BEGIN
//=================================================
BRPVP_isFlagsInRaidMode = {
	private _flags = _this;
	private _raidOn = false;
	{
		private _lra = _x getVariable ["brpvp_last_intrusion",-BRPVP_raidNoConstructionOnBaseIfRaidStartedTime];
		if (serverTime-_lra < BRPVP_raidNoConstructionOnBaseIfRaidStartedTime) exitWith {_raidOn = true;};
	} forEach _flags;
	_raidOn
};
BRPVP_myAllFlagInsideWithAccess = {
	private _inside = [];
	{
		private _rad = _x getVariable ["brpvp_flag_radius",0];
		if (BRPVP_myPlayerOrUAV distance2D _x <= _rad && {[player,_x] call BRPVP_checaAcessoRemotoFlag}) then {_inside pushBack _x;};
	} forEach nearestObjects [BRPVP_myPlayerOrUAV,["FlagCarrier"],200,true];
	_inside
};
BRPVP_nearestFlagInsideWithAccess = {
	_inside = [];
	{
		_dist = _this distance2D _x;
		if (_dist <= (_x getVariable ["brpvp_flag_radius",0])) then {if ([_this,_x] call BRPVP_checaAcessoRemotoFlag) then {_inside pushBack [_dist,_x];};};
	} forEach nearestObjects [_this,["FlagCarrier"],200,true];
	if (_inside isEqualTo []) then {
		objNull
	} else {
		_inside sort true;
		_inside select 0 select 1
	};
};
BRPVP_flagsInside = {
	params ["_obj","_xRad"];
	private _inside = [];
	{
		private _flag = _x;
		if (_flag getVariable ["id_bd",-1] isNotEqualTo -1) then {
			private _fRad = _flag getVariable ["brpvp_flag_radius",0];
			private _dist = _obj distance2D _flag;
			if (_dist <= _fRad+_xRad) then {_inside pushBack [_dist,_flag];};
		};
	} forEach nearestObjects [_obj,["FlagCarrier"],200+_xRad,true];
	_inside sort true;
	_inside apply {_x select 1}
};
BRPVP_nearestFlagInsideLimited = {
	params ["_obj","_flags"];
	_inside = [];
	{
		if (_x getVariable ["id_bd",-1] isNotEqualTo -1) then {
			_dist = _obj distance2D _x;
			if (_dist <= (_x getVariable ["brpvp_flag_radius",0])) then {_inside pushBack [_dist,_x];};
		};
	} forEach ((nearestObjects [_obj,["FlagCarrier"],200,true]) arrayIntersect _flags);
	if (_inside isEqualTo []) then {
		objNull
	} else {
		_inside sort true;
		_inside select 0 select 1
	};
};
BRPVP_nearestFlagInside = {
	_inside = [];
	{
		if (_x getVariable ["id_bd",-1] isNotEqualTo -1) then {
			_dist = _this distance2D _x;
			if (_dist <= (_x getVariable ["brpvp_flag_radius",0])) then {_inside pushBack [_dist,_x];};
		};
	} forEach nearestObjects [_this,["FlagCarrier"],200,true];
	if (_inside isEqualTo []) then {
		objNull
	} else {
		_inside sort true;
		_inside select 0 select 1
	};
};
BRPVP_checkOnFlagStateNoObj = {
	params ["_owner","_posAGL"];
	private _nearFlags = (nearestObjects [_posAGL,["FlagCarrier"],200,true]) select {_posAGL distance2D _x <= _x getVariable ["brpvp_flag_radius",-1]};
	if ({[_owner,_x] call BRPVP_checaAcessoRemotoFlagNoObj} count _nearFlags > 0) then {2} else {if (count _nearFlags > 0) then {1} else {0};};
};
BRPVP_checkOnFlagAnyPosObj = {
	private _nearFlags = (nearestObjects [_this,["FlagCarrier"],200,true]) select {_this distance2D _x <= _x getVariable ["brpvp_flag_radius",-1]};
	_nearFlags isNotEqualTo []
};
//RETURN: 0 - ITS NOT IN A FLAG; 1 - ITS ON A FLAG BUT NOT PROTECTED; 2 - ITS ON A FLAG AND PROTECTED
BRPVP_checkOnFlagState = {
	if (alive _this) then {
		private _nearFlags = (nearestObjects [_this,["FlagCarrier"],200,true]) select {_this distance2D _x <= _x getVariable ["brpvp_flag_radius",-1]};
		if ({[_this,_x] call BRPVP_checaAcessoRemotoFlag} count _nearFlags > 0) then {2} else {if (count _nearFlags > 0) then {1} else {0};};
	} else {
		0
	};
};
BRPVP_checkOnFlagStateExtraRadius = {
	params ["_obj","_xRad"];
	if (alive _obj) then {
		private _nearFlags = (nearestObjects [_obj,BRP_kitFlags25,25+_xRad,true])+(nearestObjects [_obj,BRP_kitFlags50,50+_xRad,true])+(nearestObjects [_obj,BRP_kitFlags100,100+_xRad,true])+(nearestObjects [_obj,BRP_kitFlags200,200+_xRad,true]);
		if ({[_obj,_x] call BRPVP_checaAcessoRemotoFlag} count _nearFlags > 0) then {2} else {if (count _nearFlags > 0) then {1} else {0};};
	} else {
		0
	};
};
BRPVP_playerIsIntoOwnerTerritory = {
	if (alive _this) then {
		private _idBd = _this getVariable ["id_bd",-1];
		private _nearFlags = (nearestObjects [_this,["FlagCarrier"],200,true]) select {_this distance2D _x <= _x getVariable ["brpvp_flag_radius",-1]};
		{_x getVariable ["own",-2] isEqualTo _idBd} count _nearFlags > 0
	} else {
		false
	};
};
BRPVP_insideFlagWithAccessExtraRadius = {
	params ["_player","_extraRadius"];
	private _insideExtraRadius = false;
	{
		private _haveId = _x getVariable ["id_bd",-1] > -1;
		private _distOk = _player distance2D _x <= (_x getVariable ["brpvp_flag_radius",-_extraRadius])+_extraRadius;
		private _isHidden = isObjectHidden _x;
		if (_haveId && _distOk && !_isHidden && {[_player,_x] call BRPVP_checaAcessoRemotoFlag}) exitWith {_insideExtraRadius = true;};
	} forEach nearestObjects [_player,["FlagCarrier"],200+_extraRadius,true];
	_insideExtraRadius
};
//=================================================
// FLAG STATUS END
//=================================================

BRPVP_getGridFromPos = {
	_px = floor (((_this select 0)+(BRPVP_gridPosDiff select 0))/100);
	_py = floor (((_this select 1)+(BRPVP_gridPosDiff select 1))/100);
	_pxString = str _px;
	_pyString = str _py;
	_cx = count _pxString;
	_cy = count _pyString;
	if (_cx < 3) then {_pxString = ("00" select [0,3-_cx])+_pxString;};
	if (_cy < 3) then {_pyString = ("00" select [0,3-_cy])+_pyString;};
	format ["%1-%2",_pxString,_pyString]
};
BRPVP_checkIfLandNear = {
	params ["_pos","_dist",["_anglesSet",[4,8,16,32]],["_distPart",50]];
	_pos set [2,0];
	if (!surfaceIsWater _pos) exitWith {true};
	_ok = false;
	{
		_step = 360/_x;
		for "_i" from 0 to (_x-1) do {
			_angle = _i*_step;
			_vec = [sin _angle,cos _angle,0];
			_count = floor (_dist/_distPart);
			for "_d" from 1 to _count do {
				_check = _pos vectorAdd (_vec vectorMultiply (_d*_distPart));
				if (!surfaceIsWater _check) exitWith {_ok = true;};
			};
			if (_ok) exitWith {};
			_check = _pos vectorAdd (_vec vectorMultiply _dist);
			if (!surfaceIsWater _check) exitWith {_ok = true;};
		};
		if (_ok) exitWith {};
	} forEach _anglesSet;
	_ok
};
BRPVP_alignByCenterObjAirport = {
	_sideCons = _this;
	_originalCenterObj = objNull;
	{if (typeOf _x isEqualTo "Land_Airport_center_F") exitWith {_originalCenterObj = _x;};} forEach nearestObjects [_sideCons,[],65];
	if (isNull _originalCenterObj) exitWith {};
	_playerCenterPos = getPosWorld _originalCenterObj;
	_playerCenterDir = getDir _originalCenterObj;
	_originalCenterPos = [14600.847,16795.002,20.731];
	_originalLeftPos = [14618.029,16805.637,24.774];
	_originalRightPos = [14590.3,16777.943,24.774];
	_originalCenterDir = 315.035;
	_originalLeftDir = 315.035;
	_originalRightDir = 315.035;
	_originalPlayerDirDiff = (_playerCenterDir+360)-(_originalCenterDir+360);
	if (typeOf _sideCons isEqualTo "Land_Airport_left_F") then {
		_sideCons setVectorUp [0,0,1];
		_sideCons setDir (_originalLeftDir+_originalPlayerDirDiff);
		_dir1 = ([_originalCenterPos,_originalLeftPos] call BIS_fnc_dirTo)+_originalPlayerDirDiff;
		_dist1 = _originalLeftPos distance2D _originalCenterPos;
		_posFound = _playerCenterPos vectorAdd [_dist1*sin _dir1,_dist1*cos _dir1,4.043];
		_sideCons setPosWorld _posFound;
	};
	if (typeOf _sideCons isEqualTo "Land_Airport_right_F") then {
		_sideCons setVectorUp [0,0,1];
		_sideCons setDir (_originalRightDir+_originalPlayerDirDiff);
		_dir1 = ([_originalCenterPos,_originalRightPos] call BIS_fnc_dirTo)+_originalPlayerDirDiff;
		_dist1 = _originalRightPos distance2D _originalCenterPos;
		_posFound = _playerCenterPos vectorAdd [_dist1*sin _dir1,_dist1*cos _dir1,4.043];
		_sideCons setPosWorld _posFound;
	};
};
BRPVP_alignByCenterObjHospital = {
	_sideCons = _this;
	_originalCenterObj = objNull;
	{if (typeOf _x isEqualTo "Land_Hospital_main_F") exitWith {_originalCenterObj = _x;};} forEach nearestObjects [_sideCons,[],65];
	if (isNull _originalCenterObj) exitWith {};
	_playerCenterPos = getPosWorld _originalCenterObj;
	_playerCenterDir = getDir _originalCenterObj;
	_originalCenterPos = [3760.451,12990.057,27.016];
	_originalLeftPos = [3764.662,13022.728,26.901];
	_originalRightPos = [3732.57,12979.607,27.119];
	_originalCenterDir = 359.146;
	_originalLeftDir = 359.146;
	_originalRightDir = 359.146;
	_originalPlayerDirDiff = (_playerCenterDir+360)-(_originalCenterDir+360);
	if (typeOf _sideCons isEqualTo "Land_Hospital_side1_F") then {
		_sideCons setVectorUp [0,0,1];
		_sideCons setDir (_originalLeftDir+_originalPlayerDirDiff);
		_dir1 = ([_originalCenterPos,_originalLeftPos] call BIS_fnc_dirTo)+_originalPlayerDirDiff;
		_dist1 = _originalLeftPos distance2D _originalCenterPos;
		_posFound = _playerCenterPos vectorAdd [_dist1*sin _dir1,_dist1*cos _dir1,-0.11249947];
		_sideCons setPosWorld _posFound;
	};
	if (typeOf _sideCons isEqualTo "Land_Hospital_side2_F") then {
		_sideCons setVectorUp [0,0,1];
		_sideCons setDir (_originalRightDir+_originalPlayerDirDiff);
		_dir1 = ([_originalCenterPos,_originalRightPos] call BIS_fnc_dirTo)+_originalPlayerDirDiff;
		_dist1 = _originalRightPos distance2D _originalCenterPos;
		_posFound = _playerCenterPos vectorAdd [_dist1*sin _dir1,_dist1*cos _dir1,0.088939];
		_sideCons setPosWorld _posFound;
	};
};
BRPVP_alignByCenterObjHotel = {
	_sideCons = _this;
	_originalCenterObj = objNull;
	{if (typeOf _x isEqualTo "Land_GH_MainBuilding_middle_F") exitWith {_originalCenterObj = _x;};} forEach nearestObjects [_sideCons,[],65];
	if (isNull _originalCenterObj) exitWith {};
	_playerCenterPos = getPosWorld _originalCenterObj;
	_playerCenterDir = getDir _originalCenterObj;
	_originalCenterPos = [21972.629,21027.182,28.542];
	_originalLeftPos = [21953.016,21038.268,30.135];
	_originalRightPos = [21985.492,21008.434,30.135];
	_originalCenterDir = 222.573;
	_originalLeftDir = 222.573;
	_originalRightDir = 222.573;
	_originalPlayerDirDiff = (_playerCenterDir+360)-(_originalCenterDir+360);
	if (typeOf _sideCons isEqualTo "Land_GH_MainBuilding_left_F") then {
		_sideCons setVectorUp [0,0,1];
		_sideCons setDir (_originalLeftDir+_originalPlayerDirDiff);
		_dir1 = ([_originalCenterPos,_originalLeftPos] call BIS_fnc_dirTo)+_originalPlayerDirDiff;
		_dist1 = _originalLeftPos distance2D _originalCenterPos;
		_posFound = _playerCenterPos vectorAdd [_dist1*sin _dir1,_dist1*cos _dir1,1.593];
		_sideCons setPosWorld _posFound;
	};
	if (typeOf _sideCons isEqualTo "Land_GH_MainBuilding_right_F") then {
		_sideCons setVectorUp [0,0,1];
		_sideCons setDir (_originalRightDir+_originalPlayerDirDiff);
		_dir1 = ([_originalCenterPos,_originalRightPos] call BIS_fnc_dirTo)+_originalPlayerDirDiff;
		_dist1 = _originalRightPos distance2D _originalCenterPos;
		_posFound = _playerCenterPos vectorAdd [_dist1*sin _dir1,_dist1*cos _dir1,1.593];
		_sideCons setPosWorld _posFound;
	};
};
BRPVP_playersListWithVars = {
	private _list = [];
	private _listOther = [];
	private _allIds = [];
	private _sPairs = [];
	private _camsAdded = [];
	{
		private _pMid = _x getVariable ["brpvp_machine_id",-1];
		private _pVD = _x getVariable ["brpvp_vd",1500];
		if (_pMid isNotEqualTo -1) then {
			_allIds pushBack _pMid;
			_list pushBack _x;
			//SPECTED PLAYER WAKE POINT
			private _spec = _x getVariable ["brpvp_specting",objNull];
			if (!isNull _spec) then {
				_sPairs pushBack [_x,_spec];
			} else {
				//UAV WAKE POINT
				private _UAV = _x getVariable ["brpvp_my_looking_uav",objNull];
				if (!isNull _UAV) then {
					_UAV setVariable ["brpvp_machine_id",_pMid];
					_UAV setVariable ["brpvp_vd",_pVD];
					_listOther pushBack _UAV;
				} else {
					//SECURITY CAM WAKE POINT
					private _fCam = _x getVariable ["brpvp_my_looking_seccam",objNull];
					if (!isNull _fCam) then {
						if !(_fCam in _camsAdded) then {
							_fCam setVariable ["brpvp_machine_id",_pMid];
							_fCam setVariable ["brpvp_vd",BRPVP_secCamViewDistance];
							_listOther pushBack _fCam;
							_camsAdded pushBack _fCam;
						};
					};
				};
			};
		};
	} forEach call BRPVP_playersList;
	_listOther append BRPVP_atomicBombsRunning;
	[_list,_listOther,_allIds,_sPairs]
};
BRPVP_addLocalIconsAreaNoObj = {
		params ["_iName","_iPos","_iColor","_iRad","_alpha",["_iBrush","Solid"],["_iShape","ELLIPSE"]];
		_icon = createMarkerLocal [_iName,_iPos];
		_icon setMarkerShapeLocal _iShape;
		_icon setMarkerBrushLocal _iBrush;
		_icon setMarkerSizeLocal [_iRad,_iRad];
		_icon setMarkerColorLocal _iColor;
		_icon setMarkerAlphaLocal _alpha;
};
BRPVP_invOkToOpen = {
	private ["_obj"];
	_obj = _this getVariable ["brpvp_inv_check_n",objNull];
	isNull _obj || {_obj distanceSqr _this > 64}
};
BRPVP_processPunchHit = {
	params ["_uTarget","_damage","_agnt"];
	if (_uTarget call BRPVP_isPlayerC) then {
		if (_uTarget call BRPVP_isPlayer) then {
			if (_uTarget getVariable ["dd",-1] isEqualTo -1) then {
				private _AHD = getAllHitPointsDamage _uTarget;
				if (count _AHD isEqualTo 3) then {
					BRPVP_lastOfensor = _agnt;
					BRPVP_mensagemDeKillArray = [time,_agnt getVariable ["nm",localize "str_bots"],localize "str_punch","0",_agnt];
					{(_AHD select _forEachIndex) pushBack _x;} forEach ["","",damage _uTarget];
					{
						private _dam = _x+_damage;
						private _parte = _AHD select 1 select _forEachIndex;
						private _hitPoint = _AHD select 0 select _forEachIndex;
						[_uTarget,_parte,_dam,_agnt,"BRPVP_Punch",_forEachIndex,_agnt,_hitPoint] call BRPVP_pehHandleDamage;
						_uTarget setHitIndex [_forEachIndex,_dam,true];
						_uTarget setHitIndex [_forEachIndex,_dam,true,_agnt,_agnt];
					} forEach (_AHD select 2);
					call BRPVP_atualizaDebug;
					if (_uTarget getVariable ["dd",-1] isNotEqualTo -1) then {[_agnt,["drama1",200]] remoteExecCall ["say3D",BRPVP_allNoServer];};
				};
			} else {
				BRPVP_lastOfensor = _agnt;
				BRPVP_mensagemDeKillArray = [time,_agnt getVariable ["nm",localize "str_bots"],localize "str_punch","0",_agnt];
				BRPVP_disabledDamage = BRPVP_disabledDamage+(_damage*0.75);
			};
		};
	} else {
		private _isZombie = _uTarget getVariable ["ifz",-1] isNotEqualTo -1;
		if (_isZombie) then {
			if (random 1 < 0.5 || _damage >= 1) then {[_uTarget,_agnt,"BRPVP_Punch",_uTarget getVariable ["brpvp_mobius",false],false,true,false] spawn BRPVP_zedDeath;};
		} else {
			if (_uTarget getVariable ["brpvp_aitiz",false]) then {
				_uTarget setDamage 1;
			} else {
				[_uTarget,"",damage _uTarget+_damage,_agnt,"BRPVP_Punch",-1,_agnt,""] call BRPVP_hdEh;
				_uTarget setDamage [damage _uTarget+_damage,true,_agnt,_agnt];
			};
		};
	};
};
BRPVP_processZombieHitVeh = {
	params ["_veh","_damage"];
	private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _veh >> "armor") max 100 min 500;
	private _extra = 0.6*(_armor-100)/(500-100);
	{if (random 1 < 0.7-_extra) then {_veh setHitIndex [_forEachIndex,(_x+_damage) min 0.9,true];};} forEach ((getAllHitPointsDamage _veh+[[],[],[]]) select 2);
};
BRPVP_processZombieHit = {
	params ["_uTarget","_damage","_agnt"];
	private _AHD = getAllHitPointsDamage _uTarget+[[],[],[]];
	private _isAlivePlayerOrAi = (_uTarget call BRPVP_isPlayer && _uTarget getVariable ["dd",-1] isEqualTo -1) || !(_uTarget call BRPVP_isPlayer || _uTarget getVariable ["brpvp_tai_dead",false]);
	private _dead = false;
	if (_isAlivePlayerOrAi) then {
		if (_uTarget call BRPVP_isPlayer) then {
			{
				private _hitPoint = _AHD select 0 select _forEachIndex;
				if (_hitPoint in ["hithead","hitbody",""]) then {_dead = (_x+_damage) >= BRPVP_pDamLim;};
				_uTarget setHitIndex [_forEachIndex,(_x+_damage) min BRPVP_pDamLim,true];
			} forEach (_AHD select 2);
			BRPVP_lastOfensor = _agnt;
			call BRPVP_atualizaDebug;
			if (_dead) then {[_agnt,"Zed_Slap_F",true] call BRPVP_pehKilledFakeHandleDamage;};
		} else {
			{
				private _hitPoint = _AHD select 1 select _forEachIndex;
				if (_hitPoint in ["","body","spine1","spine2","spine3","head"]) then {_dead = (_x+_damage) >= BRPVP_aiDamLim;};
				_uTarget setHitIndex [_forEachIndex,(_x+_damage) min BRPVP_aiDamLim,true];
			} forEach (_AHD select 2);
			if (_dead) then {[_uTarget,objNull] call BRPVP_scriptKillAIToZed;};
		};
	};
};
BRPVP_sitAddItem = {
	params ["_iClass","_iQtt"];
	private ["_item","_sit","_added"];
	_item = if (_iClass isEqualType "") then {[BRPVP_specialItems find _iClass,_iQtt]} else {_this};
	_sit = player getVariable ["sit",[]];
	_added = false;
	{
		if ((_x select 0) isEqualTo (_item select 0)) exitWith {
			_added = true;
			_x set [1,(_x select 1)+(_item select 1)];
		};
	} forEach _sit;
	if (!_added) then {
		_sit pushBack _item;
	};
	player setVariable ["sit",_sit,[clientOwner,2]];
};
BRPVP_sitAddItemId = {
	params ["_iClass","_iQtt","_p","_id"];
	private _item = if (_iClass isEqualType "") then {[BRPVP_specialItems find _iClass,_iQtt]} else {_this select [0,2]};
	private _sit = _p getVariable ["sit",[]];
	private _added = false;
	{
		if ((_x select 0) isEqualTo (_item select 0)) exitWith {
			_added = true;
			_x set [1,(_x select 1)+(_item select 1)];
		};
	} forEach _sit;
	if (!_added) then {_sit pushBack _item;};
	_p setVariable ["sit",_sit,[_id,2]];
};
BRPVP_sitAddItemList = {
	private ["_items","_itemsGrp","_item","_q"];
	_items = _this;
	_itemsGrp = [];
	{
		_item = _x;
		_itemN = if (_item isEqualType "") then {BRPVP_specialItems find _item} else {_item};
		if (_itemN > -1) then {
			_q = 0;
			{if (_x isEqualTo _item) then {_q = _q+1;};} forEach _items;
			_itemsGrp pushBack [_itemN,_q];
		};
	} forEach (_items arrayIntersect _items);
	{_x call BRPVP_sitAddItem;} forEach _itemsGrp;
};
BRPVP_sitRemoveItem = {
	params ["_iClass","_iQtt"];
	private ["_item","_sit","_removed","_newQ"];
	_item = if (_iClass isEqualType "") then {[BRPVP_specialItems find _iClass,_iQtt]} else {_this};
	_sit = player getVariable ["sit",[]];
	_removed = false;
	{
		if ((_x select 0) isEqualTo (_item select 0)) exitWith {
			if (_x select 1 >= _item select 1) then {
				_newQ = (_x select 1)-(_item select 1);
				if (_newQ isEqualTo 0) then {_sit deleteAt _forEachIndex;} else {_x set [1,_newQ];};
				player setVariable ["sit",_sit,[clientOwner,2]];
				_removed = true;
			};
		};
	} forEach _sit;
	_removed
};
BRPVP_sitCountItem = {
	private ["_item","_sit","_found"];
	_item = if (_this isEqualType "") then {BRPVP_specialItems find _this} else {_this};
	_sit = player getVariable ["sit",[]];
	_found = 0;
	{if (_x select 0 isEqualTo _item) exitWith {_found = _x select 1;};} forEach _sit;
	_found
};
BRPVP_sitCountItemRemote = {
	params ["_player","_itemOrIndex"];
	private _item = if (_itemOrIndex isEqualType "") then {BRPVP_specialItems find _itemOrIndex} else {_itemOrIndex};
	private _sit = _player getVariable ["sit",[]];
	private _found = 0;
	{if (_x select 0 isEqualTo _item) exitWith {_found = _x select 1;};} forEach _sit;
	_found
};
BRPVP_sitConvert = {
	private ["_sit","_newSit","_idx","_item"];
	_sit = _this;
	if (_sit isEqualTo []) then {
		_sit
	} else {
		if (_sit select 0 isEqualType 0) then {
			_newSit = [];
			{
				_item = _x;
				_newSit pushBack [_item,{_item isEqualTo _x} count _sit];
			} forEach (_sit arrayIntersect _sit);
			_newSit
		} else {
			_sit
		};
	};
};
BRPVP_transferUnitCargoB = {
	params ["_from","_cargo","_player"];
	if (time-(_from getVariable ["brpvp_transfered_time",0]) > 1.5) then {
		_from setVariable ["brpvp_transfered_time",time];
		if (isNull _cargo) then {
			_wh = createVehicle ["GroundWeaponHolder",_player vectorAdd [0,0,0.15],[],0,"CAN_COLLIDE"];
			[_from,_wh] call BRPVP_playerItemsToCargoNoUniform;
		};
	};
};
BRPVP_transferCargoCargoB = {
	params ["_from","_cargo","_player",["_noLimit",false]];
	if (time-(_from getVariable ["brpvp_transfered_time",0]) > 1.5) then {
		_from setVariable ["brpvp_transfered_time",time];
		if (isNull _cargo) then {
			[_from,_cargo,_player,_noLimit] call BRPVP_transferCargoCargoC;
		} else {
			if (local _cargo) then {
				[_from,_cargo,_player,_noLimit] call BRPVP_transferCargoCargoC;
			} else {
				[_from,_cargo,_player,_noLimit] remoteExecCall ["BRPVP_transferCargoCargoC",_cargo];
			};
		};
	};
};
BRPVP_transferCargoCargoC = {
	params ["_from","_cargo","_player",["_noLimit",false]];
	private ["_wh"];
	//GET GEAR INFO
	_weaponItems = weaponsItemsCargo _from;
	_mags = magazinesAmmoCargo _from;
	_bags = backpackCargo _from;
	_items = getItemCargo _from;
	_everyContainer = everyContainer _from;
	_check = [];
	_checkRemove = [];
	_everyContainer = _everyContainer apply {
		if (_x select 1 in _check) then {
			_checkRemove pushBack (_x select 0);
			-1
		} else {
			_check pushBack (_x select 1);
			_x
		};
	};
	_everyContainer = _everyContainer-[-1];
	{
		_idx = _bags find _x;
		if (_idx != -1) then {_bags deleteAt _idx;};
	} forEach _checkRemove;
	{
		_c = _x select 1;
		_weaponItems append weaponsItemsCargo _c;
		_mags append magazinesAmmoCargo _c;
		_is = getItemCargo _c;
		if (count (_is select 0) > 0) then {_items = [(_items select 0)+(_is select 0),(_items select 1)+(_is select 1)];};
	} forEach _everyContainer;
	
	//CLEAR FROM BOX
	clearWeaponCargoGlobal _from;
	clearMagazineCargoGlobal _from;
	clearItemCargoGlobal _from;
	clearBackpackCargoGlobal _from;
	
	//GROUND HOLDER
	_wh = objNull;
	_createHolder = {
		_wh = createVehicle ["GroundWeaponHolder",_player vectorAdd [0,0,0.15],[],0,"CAN_COLLIDE"];
		_wh setPosATL (_player vectorAdd [0,0,0.15]);
	};
	if (isNull _cargo) then {
		_cargo = createVehicle ["GroundWeaponHolder",_player vectorAdd [0,0,0.15],[],0,"CAN_COLLIDE"];
		_cargo setPosATL (_player vectorAdd [0,0,0.15]);
	};
	
	//TRANSFER MAGS
	_moneyItems = [];
	{
		_class = _x select 0;
		if (_class in (BRPVP_moneyItems select 0)) then {
			_moneyItems pushBack _class;
		} else {
			_count = _x select 1;
			if (_cargo canAdd _class || _noLimit) then {
				_cargo addMagazineAmmoCargo [_class,1,_count];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addMagazineAmmoCargo [_class,1,_count];
			};
		};
	} forEach _mags;

	//TRANSFER ITEMS
	{
		for "_q" from 1 to (_items select 1 select _forEachIndex) do {
			if (_cargo canAdd _x || _noLimit) then {
				_cargo addItemCargoGlobal [_x,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addItemCargoGlobal [_x,1];
			};
		};
	} forEach (_items select 0);
	
	//TRANSFER WEAPONS
	{
		if (_cargo canAdd [_x select 0,2] || _noLimit) then {
			_cargo addWeaponWithAttachmentsCargoGlobal [_x,1];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addWeaponWithAttachmentsCargoGlobal [_x,1];
		};
	} forEach _weaponItems;
	
	//TRANSFER BAGS
	_contBegin = everyContainer _cargo;
	if (!isNull _wh) then {_contBegin append everyContainer _wh};
	{
		if (_cargo canAdd _x || _noLimit) then {
			_cargo addBackpackCargoGlobal [_x,1];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addBackpackCargoGlobal [_x,1];
		};
	} forEach _bags;
	_contEnd = everyContainer _cargo;
	if (!isNull _wh) then {_contEnd append everyContainer _wh};
	{
		_c = _x select 1;
		clearWeaponCargoGlobal _c;
		clearMagazineCargoGlobal _c;
		clearItemCargoGlobal _c;
		clearBackpackCargoGlobal _c;
	} forEach (_contEnd-_contBegin);

	//SET CARGOS TO SAVE
	if (_from getVariable ["id_bd",-1] > -1) then {if !(_from getVariable ["slv",false]) then {_from setVariable ["slv",true,true];};};
	if (_cargo getVariable ["id_bd",-1] > -1) then {if !(_cargo getVariable ["slv",false]) then {_cargo setVariable ["slv",true,true];};};

	if (_moneyItems isEqualTo []) then {
		//DELETE BOX IF DEL_ON_EMPTY
		if (_from getVariable ["brpvp_del_when_empty",false]) then {deleteVehicle _from;};
	} else {
		//GIVE FLARES MONEY TO PLAYER
		private _pObj = nearestObjects [_player,[BRPVP_playerModel],5];
		if (_pObj isNotEqualTo []) then {
			_pObj = _pObj select 0;
			private _valor = 0;
			{
				private _mny = (BRPVP_moneyItems select 1) select (BRPVP_moneyItems select 0 find _x);
				_valor = _valor+_mny;
			} forEach _moneyItems;
			player setVariable ["mny",(player getVariable "mny")+_valor,true];
			call BRPVP_atualizaDebug;
			"negocio" call BRPVP_playSound;
		};
	};
};
BRPVP_turnIntoBandit = {
	private _isOnPVE = player getVariable ["brpvp_pve_inside",0] > 0;
	private _isOwner = (_this getVariable ["own",-1]) isEqualTo (player getVariable "id_bd");
	private _haveAccess = _this call BRPVP_checaAcesso;
	if (_isOnPVE && ((!_isOwner && !_haveAccess) || isNull _this)) then {
		if !(player in BRPVP_pveBanditObjList) then {
			BRPVP_pveBanditObjList = BRPVP_pveBanditObjList apply {if (isNull _x || _x getVariable ["dd",-1] > 0) then {-1} else {_x};};
			BRPVP_pveBanditObjList = BRPVP_pveBanditObjList-[-1];
			BRPVP_pveBanditObjList pushBack player;
			publicVariable "BRPVP_pveBanditObjList";
			["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\bandit.paa'/>",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.36},1000000,0,0,3098] call BRPVP_fnc_dynamicText;
			_txt = format ["<img align='center' size='2.5' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\bandit.paa'/><br /><t size='1.0' align='center'>%1</t>",format [localize "str_became_a_bandit",player getVariable ["nm","no_name"]]];
			[_txt,0,0,6,0,0,5394] remoteExecCall ["BRPVP_fnc_dynamicText",BRPVP_allNoServer];
			"achou_loot" remoteExecCall ["playSound",BRPVP_allNoServer];
			player setVariable ["brpvp_no_veh_time",serverTime];
		};
		_idBd = player getVariable ["id_bd",-1];
		if !(_idBd in BRPVP_pveBanditObjListId) then {
			BRPVP_pveBanditObjListId pushBack _idBd;
			publicVariable "BRPVP_pveBanditObjListId";
		};
		player remoteExecCall ["BRPVP_pveRecordHalfBandit",2];
		if !(player getVariable ["brpvp_half_bandit",false]) then {player setVariable ["brpvp_half_bandit",true,true];};
	};
};
BRPVP_getCargoArrayNoDb = {
	//CHECK IF OBJECT HAVE CARGO SPACE
	private _isInv1 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "maximumLoad") > 0;
	private _isInv2 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "transportMaxMagazines") > 0;

	if (alive _this && (_isInv1 || _isInv2)) then {
		private _gear = [];
		private _conts = everyContainer _this select {loadAbs (_x select 1) isNotEqualTo 0};
		private _params = ["_name","_c"];
		{
			_x params _params;
			private _magas = magazinesAmmoCargo _c;
			private _mochi = getBackpackCargo _c;
			private _itens = getItemCargo _c;
			private _weaponsItemsCargo = weaponsItemsCargo _c select {_x select [1,6] isEqualTo ["","","",[],[],""]};

			//REMOVE CONTAINERS ITEMS FROM MAIN
			{
				private _class = _x select 0;
				private _idx = (_mochi select 0) find _class;
				private _array = [];
				if (_idx isEqualTo -1) then {_idx = (_itens select 0) find _class;_array = _itens;} else {_array = _mochi;};
				private _qtt = _array select 1 select _idx;
				if (_qtt isEqualTo 1) then {(_array select 0) deleteAt _idx;(_array select 1) deleteAt _idx;} else {(_array select 1) set [_idx,(_array select 1 select _idx)-1];};
			} forEach _conts;

			//JOIN EQUAL WEAPONS ARRAY
			private _weaponsItemsCargoQ = [];
			{
				private _idx = -1;
				private _we = _x;
				{if ((_x select 0) isEqualTo _we) exitWith {_idx = _forEachIndex;};} forEach _weaponsItemsCargoQ;
				if (_idx isEqualTo -1) then {_weaponsItemsCargoQ pushBack [_x,1];} else {(_weaponsItemsCargoQ select _idx) set [1,(_weaponsItemsCargoQ select _idx select 1)+1];};
			} forEach _weaponsItemsCargo;

			//JOIN EQUAL MAG ARRAYS
			private _magasSmall = [];
			private _magasSmallCount = [];
			{
				private _idx = _magasSmall find _x;
				if (_idx isEqualTo -1) then {
					_magasSmall pushBack _x;
					_magasSmallCount pushBack 1;
				} else {
					_magasSmallCount set [_idx,(_magasSmallCount select _idx)+1];
				};
			} forEach _magas;

			//PUT EQUAL MAGS COUNT IN THE MIDDLE OF THE UNIFIED ARRAY
			private _magasFinal = [];
			{_magasFinal pushBack [_x select 0,_magasSmallCount select _forEachIndex,_x select 1];} forEach _magasSmall;

			//ADD NEW CONTAINER GEAR
			_gear pushBack [[_name,_c],[_weaponsItemsCargoQ,_magasFinal,_itens,_mochi]];
		} forEAch ([["brpvp_main_container",_this]]+_conts);
		[3,_gear]
	} else {
		[3,[[["brpvp_main_container",objNull],[[],[],[[],[]],[[],[]]]]]]
	};
};
BRPVP_putItemsOnCargo = {
	params ["_vehicle","_inventory",["_removeFlare",false],["_clear",true]];
	private ["_e","_c","_mag"];
	private _isEmpty = loadAbs _vehicle isEqualTo 0;
	private _fClass = BRPVP_moneyItems select 0;
	if (!_isEmpty && _clear) then {_vehicle call BRPVP_emptyBox;};
	if (_inventory select 0 isEqualTo 3) then {
		_conts = [];
		{
			_x params ["_name","_gear"];
			_name = if (_name isEqualType 0) then {BRPVP_ItemsClassToNumberTableE select _name} else {_name};
			_c = if (_forEachIndex isEqualTo 0) then {
				_vehicle
			} else {
				{if ((_x select 0) isEqualTo _name) exitWith {(_conts deleteAt _forEachIndex) select 1;};} forEach _conts;
			};
			{
				_x params ["_wepData","_q"];
				_e = [];
				{
					if (_forEachIndex isEqualTo 0) then {
						_e pushBack (if (_x isEqualType 1) then {BRPVP_ItemsClassToNumberTableA select _x} else {_x});
					} else {
						if (_x isEqualType []) then {
							if (_x isEqualTo []) then {
								_e pushBack [];
							} else {
								_mag = _x select 0;
								_e pushBack [if (_mag isEqualType 1) then {BRPVP_ItemsClassToNumberTableB select _mag} else {_mag},_x select 1];
							};
						} else {
							_e pushBack (if (_x isEqualType 1) then {BRPVP_ItemsClassToNumberTableC select _x} else {_x});
						};
					};
				} forEach _wepData;
				_c addWeaponWithAttachmentsCargoGlobal [_e,_q];
			} forEach (_gear select 0);
			{
				private _class = if ((_x select 0) isEqualType 0) then {BRPVP_ItemsClassToNumberTableB select (_x select 0)} else {_x select 0};
				if !(_class in BRPVP_bannedMagazines) then {
					if !(_removeFlare && {_class in _fClass}) then {
						if (count _x isEqualTo 2) then {_c addMagazineAmmoCargo [_class,1,_x select 1];} else {_c addMagazineAmmoCargo [_class,_x select 1,_x select 2];};
					};
				};
			} forEach (_gear select 1);
			{_c addItemCargoGlobal [if (_x isEqualType 0) then {BRPVP_ItemsClassToNumberTableC select _x} else {_x},_gear select 2 select 1 select _forEachIndex];} forEach (_gear select 2 select 0);
			{_c addBackpackCargoGlobal [if (_x isEqualType 0) then {BRPVP_ItemsClassToNumberTableD select _x} else {_x},_gear select 3 select 1 select _forEachIndex];} forEach (_gear select 3 select 0);
			if (_forEachIndex isEqualTo 0) then {
				_conts = everyContainer _vehicle;
				if (_clear) then {{(_x select 1) call BRPVP_emptyBox} forEach _conts;}; //XXX CHECK IF _clear CHECK NEEDED
			};
		} forEach (_inventory select 1);
	} else {
		if ((_inventory select 0 select 0) isEqualTo 2) then {
			{
				_x params ["_wepData","_q"];
				_e = [];
				{
					if (_forEachIndex isEqualTo 0) then {
						_e pushBack (if (_x isEqualType 1) then {BRPVP_ItemsClassToNumberTableA select _x} else {_x});
					} else {
						if (_x isEqualType []) then {
							if (_x isEqualTo []) then {
								_e pushBack [];
							} else {
								_mag = _x select 0;
								_e pushBack [if (_mag isEqualType 1) then {BRPVP_ItemsClassToNumberTableB select _mag} else {_mag},_x select 1];
							};
						} else {
							_e pushBack (if (_x isEqualType 1) then {BRPVP_ItemsClassToNumberTableC select _x} else {_x});
						};
					};
				} forEach _wepData;
				_vehicle addWeaponWithAttachmentsCargoGlobal [_e,_q];
			} forEach (_inventory select 0 select 1);
		} else {
			{_vehicle addWeaponCargoGlobal [if (_x isEqualType 0) then {BRPVP_ItemsClassToNumberTableA select _x} else {_x},_inventory select 0 select 1 select _forEachIndex];} forEach (_inventory select 0 select 0);
		};
		{
			private _class = if ((_x select 0) isEqualType 0) then {BRPVP_ItemsClassToNumberTableB select (_x select 0)} else {_x select 0};
			if !(_removeFlare && {_class in _fClass}) then {
				if (count _x isEqualTo 2) then {_vehicle addMagazineAmmoCargo [_class,1,_x select 1];} else {_vehicle addMagazineAmmoCargo [_class,_x select 1,_x select 2];};
			};
		} forEach (_inventory select 1);
		{_vehicle addItemCargoGlobal [if (_x isEqualType 0) then {BRPVP_ItemsClassToNumberTableC select _x} else {_x},_inventory select 2 select 1 select _forEachIndex];} forEach (_inventory select 2 select 0);
		{_vehicle addBackpackCargoGlobal [if (_x isEqualType 0) then {BRPVP_ItemsClassToNumberTableD select _x} else {_x},_inventory select 3 select 1 select _forEachIndex];} forEach (_inventory select 3 select 0);
		{(_x select 1) call BRPVP_emptyBox;} forEach everyContainer _vehicle;
	};
};
BRPVP_getCargoArray = {
	private _isInv1 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "maximumLoad") > 0;
	private _isInv2 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "transportMaxMagazines") > 0;
	if (alive _this && (_isInv1 || _isInv2)) then {
		private ["_we","_gear","_idx","_magasFinal","_magasSmall","_magasSmallCount","_armas","_magas","_mochi","_itens","_conts","_weaponsItemsCargo","_weaponsItemsCargoQ"];
		_conts = everyContainer _this;
		_gear = [];
		private _paramsArray = ["_name","_c"];
		{
			_x params _paramsArray;
			_magas = magazinesAmmoCargo _c;
			_mochi = getBackpackCargo _c;
			_itens = getItemCargo _c;
			_weaponsItemsCargo = weaponsItemsCargo _c;
			{
				_feiA = _forEachIndex;
				{
					_feiB = _forEachIndex;
					if (_feiB isEqualTo 0) then {
						_baseWeapon = _x call BIS_fnc_baseWeapon;
						private _idx = BRPVP_ItemsClassToNumberTableA find _baseWeapon;
						private _wc = [_idx,_baseWeapon] select (_idx isEqualTo -1);
						_weaponsItemsCargo select _feiA set [_feiB,_wc];
					} else {
						if (_x isEqualType [] && !(_x isEqualTo [])) then {
							private ["_i"];
							_i = BRPVP_ItemsClassToNumberTableB find (_x select 0);
							_weaponsItemsCargo select _feiA set [_feiB,if (_i isEqualTo -1) then {_x} else {[_i,_x select 1]}];
						};
						if (_x isEqualType "") then {
							private ["_i"];
							_i = BRPVP_ItemsClassToNumberTableC find _x;
							_weaponsItemsCargo select _feiA set [_feiB,if (_i isEqualTo -1) then {_x} else {_i}];
						};
					};
				} forEach _x;
			} forEach _weaponsItemsCargo;
			_magas = (_magas apply {if ((_x select 0) in BRPVP_bannedMagazines) then {-1} else {_i = BRPVP_ItemsClassToNumberTableB find (_x select 0); if (_i isEqualTo -1) then {_x} else {[_i,_x select 1]};};})-[-1];
			_itens set [0,(_itens select 0) apply {_i = BRPVP_ItemsClassToNumberTableC find _x; if (_i isEqualTo -1) then {_x} else {_i};}];
			_mochi set [0,(_mochi select 0) apply {_i = BRPVP_ItemsClassToNumberTableD find _x; if (_i isEqualTo -1) then {_x} else {_i};}];

			_weaponsItemsCargoQ = [];
			{
				_idx = -1;
				_we = _x;
				{if ((_x select 0) isEqualTo _we) exitWith {_idx = _forEachIndex;};} forEach _weaponsItemsCargoQ;
				if (_idx isEqualTo -1) then {
					_weaponsItemsCargoQ pushBack [_x,1];
				} else {
					(_weaponsItemsCargoQ select _idx) set [1,(_weaponsItemsCargoQ select _idx select 1)+1];
				};
			} forEach _weaponsItemsCargo;

			_magasSmall = [];
			_magasSmallCount = [];
			{
				_idx = _magasSmall find _x;
				if (_idx isEqualTo -1) then {
					_magasSmall pushBack _x;
					_magasSmallCount pushBack 1;
				} else {
					_magasSmallCount set [_idx,(_magasSmallCount select _idx)+1];
				};
			} forEach _magas;
			_magasFinal = [];
			{_magasFinal pushBack [_x select 0,_magasSmallCount select _forEachIndex,_x select 1];} forEach _magasSmall;
			private _nameNumberIdx = BRPVP_ItemsClassToNumberTableE find _name;
			private _nameNumber = [_nameNumberIdx,_name] select (_nameNumberIdx isEqualTo -1);
			private _gData = [_weaponsItemsCargoQ,_magasFinal,_itens,_mochi];
			if (_gData isNotEqualTo [[],[],[[],[]],[[],[]]] || _forEachIndex isEqualTo 0) then {_gear pushBack [_nameNumber,_gData];};
		} forEAch ([["brpvp_main_container",_this]]+_conts);
		[3,_gear]
	} else {
		[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]]
	};
};
BRPVP_putItemsOnCargoMultItemMove = {
	params ["_vehicle","_gear",["_mult",1]];
	if (_mult isNotEqualTo 1) then {
		_mult = round _mult;
		{_x set [1,(_x select 1)*_mult];} forEach (_gear select 0);
		{_x set [1,(_x select 1)*_mult];} forEach (_gear select 1);
		{_gear select 2 select 1 set [_forEachIndex,_x*_mult];} forEach (_gear select 2 select 1);
		{_gear select 3 select 1 set [_forEachIndex,_x*_mult];} forEach (_gear select 3 select 1);
	};
	{_vehicle addWeaponWithAttachmentsCargoGlobal _x;} forEach (_gear select 0);
	{_vehicle addMagazineAmmoCargo _x;} forEach (_gear select 1);
	{_vehicle addItemCargoGlobal [_x,_gear select 2 select 1 select _forEachIndex];} forEach (_gear select 2 select 0);
	{_vehicle addBackpackCargoGlobal [_x,_gear select 3 select 1 select _forEachIndex];} forEach (_gear select 3 select 0);
};
BRPVP_cargosRemoveItems = {
	params ["_remove","_objs"];
	private ["_cargos","_original","_inside","_cargo"];
	{
		_cargos = if (_x isKindOf "CaManBase") then {[uniformContainer _x,vestContainer _x, backPackContainer _x]} else {[_x]};
		{
			_original = _x call BRPVP_getCargoArrayNoNumber;
			_inside = +_original;
			{
				_cargo = _x;
				if (_forEachIndex isEqualTo 1) then {
					{
						_class = _x select 0;
						_idx = _remove find _class;
						_qIn = _x select 1;
						while {_qIn > 0 && _idx > -1} do {
							_qIn = _qIn-1;
							(_cargo select _forEachIndex) set [1,_qIn];
							_remove deleteAt _idx;
							_idx = _remove find _class;
						};
					} forEach _cargo;
				} else {
					{
						_class = _x;
						_idx = _remove find _class;
						_qIn = _cargo select 1 select _forEachIndex;
						while {_qIn > 0 && _idx > -1} do {
							_qIn = _qIn-1;
							(_cargo select 1) set [_forEachIndex,_qIn];
							_remove deleteAt _idx;
							_idx = _remove find _class;
						};
					} forEach (_cargo select 0);
				};
			} forEach _inside;
			if !(_inside isEqualTo _original) then {[_x,_inside] call BRPVP_putItemsOnCargo;};
		} forEach _cargos;
	} forEach _objs;
};
BRPVP_joinCargos = {
	private ["_result","_cargo","_class"];
	_result = [];
	{
		{
			_cargo = _x;
			if (_forEachIndex != 1) then {
				{
					_class = _x;
					for "_i" from 1 to (_cargo select 1 select _forEachIndex) do {_result pushBack _class;};
				} forEach (_cargo select 0);
			} else {
				{
					_class = _x select 0;
					for "_i" from 1 to (_x select 1) do {_result pushBack _class;};
				} forEach _cargo;
			};
		} forEach _x;
	} forEach _this;
	_result
};
BRPVP_getCargoArrayNoNumber = {
	private ["_idx","_magas","_mochi","_itens","_conts","_weaponsItemsCargo","_check"];
	private _isInv1 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "maximumLoad") > 0;
	private _isInv2 = getNumber (configFile >> "CfgVehicles" >> typeOf _this >> "transportMaxMagazines") > 0;
	if (alive _this && (_isInv1 || _isInv2)) then {
		_armas = [[],[]];
		_magas = magazinesAmmoCargo _this;
		_mochi = getBackpackCargo _this;
		_itens = getItemCargo _this;
		_conts = everyContainer _this;
		_weaponsItemsCargo = weaponsItemsCargo _this;
		_check = [];
		_checkRemove = [];
		_conts = _conts apply {
			if (_x select 1 in _check) then {
				_checkRemove pushBack (_x select 0);
				-1
			} else {
				_check pushBack (_x select 1);
				_x
			};
		};
		_conts = _conts - [-1];
		{
			_idx = (_mochi select 0) find _x;
			if (_idx != -1) then {
				_quantity = _mochi select 1 select _idx;
				if (_quantity isEqualTo 1) then {
					(_mochi select 0) deleteAt _idx;
					(_mochi select 1) deleteAt _idx;
				} else {
					(_mochi select 1) set [_idx,_quantity - 1];
				};
			};
		} forEach _checkRemove;
		{_weaponsItemsCargo append (weaponsItemsCargo (_x select 1));} forEach _conts;
		_isBP = false;
		{
			{
				if (_forEachIndex isEqualTo 0) then {
						_baseWeapon = _x call BIS_fnc_baseWeapon;
						_isBP = _baseWeapon in BRPVP_defaultBipodWeapons;
						_armas = [_armas,_baseWeapon] call BRPVP_adicCargo;
				} else {
					if (_x isEqualType []) then {if (count _x > 0) then {_magas pushBack _x;};};
					if (_x isEqualType "") then {if (_x != "" && {_forEachIndex != 6 || (_forEachIndex isEqualTo 6 && !_isBP)}) then {_itens = [_itens,_x] call BRPVP_adicCargo;};};
				};
			} forEach _x;
		} forEach _weaponsItemsCargo;
		{
			_cont = _x select 1;
			_magas append magazinesAmmoCargo _cont;
			_itensC = getItemCargo _cont;
			{
				_qt = _itensC select 1 select _forEachIndex;
				for "_i" from 1 to _qt do {_itens = [_itens,_x] call BRPVP_adicCargo;};
			} forEach (_itensC select 0);
		} forEach _conts;
		_magasSmall = [];
		_magasSmallCount = [];
		{
			_idx = _magasSmall find _x;
			if (_idx isEqualTo -1) then {
				_magasSmall pushBack _x;
				_magasSmallCount pushBack 1;
			} else {
				_magasSmallCount set [_idx,(_magasSmallCount select _idx)+1];
			};
		} forEach _magas;
		_magasFinal = [];
		{_magasFinal pushBack [_x select 0,_magasSmallCount select _forEachIndex,_x select 1];} forEach _magasSmall;
		[_armas,_magasFinal,_itens,_mochi]
	} else {
		[[[],[]],[],[[],[]],[[],[]]]
	};
};
BRPVP_explosionDeleteSmokeMBot = {
	private _init = time;
	if (random 1 < BRPVP_MinervaCraterPerc) then {
		waitUntil {
			private _cases = (nearestObjects [_this,[],0.5,true]) select {typeOf _x in ["#explosion","#destructioneffects"]};
			if (_cases isNotEqualTo []) then {uiSleep 0.001;{deleteVehicle _x;} forEach _cases;};
			time-_init > 0.25
		};
	} else {
		waitUntil {
			private _cases = (nearestObjects [_this,[],0.5,true]) select {typeOf _x in ["#explosion","#destructioneffects","#crater"]};
			if (_cases isNotEqualTo []) then {
				{if (typeOf _x isEqualTo "#crater") then {deleteVehicle _x;};} forEach _cases;
				uiSleep 0.001;
				{deleteVehicle _x;} forEach (_cases-[objNull]);
			};
			time-_init > 0.25
		};
	};
};
BRPVP_explosionDeleteSmoke = {
	private _init = time;
	waitUntil {
		{deleteVehicle _x;} forEach ((nearestObjects [_this,[],0.5,true]) select {typeOf _x in ["#explosion","#destructioneffects"]});
		time-_init > 0.45
	};
};

BRPVP_explosionDeleteSmokeMinerva = {
	private _objs = [];
	private _init = time;
	if (random 1 < BRPVP_MinervaCraterPerc) then {
		waitUntil {
			{deleteVehicle _x;} forEach ((nearestObjects [_this,[],0.5]) select {typeOf _x isEqualTo "#explosion"});
			time-_init > 0.45
		};
	} else {
		waitUntil {
			{deleteVehicle _x;} forEach ((nearestObjects [_this,[],0.5,true]) select {typeOf _x in ["#explosion","#crater"]});
			time-_init > 0.45
		};
	};
};
BRPVP_explodeBombServerMBot = {
	params ["_class","_pos","_killer","_instigator"];
	private _bomb = createVehicle [_class,_pos,[],0,"CAN_COLLIDE"];
	_bomb setShotParents [_killer,_instigator];
	ASLToAGL getPosWorld _bomb remoteExec ["BRPVP_explosionDeleteSmokeMBot",0];
	triggerAmmo _bomb;
};
BRPVP_explodeBombServer = {
	params ["_class","_pos","_killer","_instigator"];
	private _bomb = createVehicle [_class,_pos,[],0,"CAN_COLLIDE"];
	_bomb setShotParents [_killer,_instigator];
	ASLToAGL getPosWorld _bomb remoteExec ["BRPVP_explosionDeleteSmokeMinerva",0];
	_bomb spawn {uiSleep 0.125;triggerAmmo _this;};
};
BRPVP_trowBomb = {
	params ["_class","_posAGL","_velocity"];
	private _bomb = createVehicle [_class,_posAGL,[],0,"CAN_COLLIDE"];
	_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
	[_bomb,[0,0,-_velocity]] remoteExecCall ["setVelocity",0];
};
BRPVP_weaponItems = {
	private ["_weaponItems","_cfgItems"];
	_weaponItems = [];
	{
		_cfgItems = _x >> "compatibleItems";
		if (isArray _cfgItems) then {
			_weaponItems append getArray _cfgItems;
		} else {
			if (isClass _cfgItems) then {
				{_weaponItems pushBack configName _x;} forEach configProperties [_cfgItems];
			};
		};
	} forEach configProperties [configFile >> "CfgWeapons" >> _this >> "WeaponSlotsInfo","isclass _x"];
	_weaponItems
};
BRPVP_spawnSpecialBox = {
	params ["_class","_pos","_quantity","_valor","_rareTry"];
	private _boxes = [];
	for "_n" from 1 to _quantity do {
		_box = createVehicle [_class,_pos,[],4,"NONE"];
		_boxes pushBack _box;
		[_box,_valor,selectRandom [1,2,3,4],true,false] call BRPVP_createCompleteLootBox;
		for "_i" from 1 to _rareTry do {[_box,0,1,false,true] call BRPVP_createCompleteLootBox;};
		_box spawn BRPVP_monitoreForUnderground;
	};
	_boxes
};
BRPVP_monitoreForUnderground = {
	_count = 0;
	waitUntil {
		_pos1 = ASLToAGL getPosASL _this;
		sleep 0.1;
		_pos2 = ASLToAGL getPosASL _this;
		_dist = _pos1 distance _pos2;
		if (_dist < 0.01) then {_count = _count+1;} else {_count = 0;};
		_count > 30 || getPosATL _this select 2 < -0.2
	};
	_atlPos = getPosATL _this;
	if (_atlPos select 2 < -0.2) then {
		_atlPos set [2,0.5];
		_this setPosATL _atlPos;
	};
};
BRPVP_escapeForStructuredText = {
	_this = [_this,"&","&amp;"] call BRPVP_stringReplace;
	_this = [_this,"<","&lt;"] call BRPVP_stringReplace;
	[_this,">","&gt;"] call BRPVP_stringReplace;
};
BRPVP_escapeForStructuredTextFast = {
	[_this,"&","&amp;"] call BRPVP_stringReplace
};
BRPVP_createCompleteLootBox = {
	params ["_box","_valor","_tries","_clear","_rare",["_chance",BRPVP_rareItemsChance]];
	private ["_idx","_weaponsBefore"];
	_rare = if (_rare isEqualType true) then {[0,1] select _rare} else {_rare};
	//CLEAR BOX
	if (_clear) then {
		clearMagazineCargoGlobal _box;
		clearWeaponCargoGlobal _box;
		clearItemCargoGlobal _box;
		clearBackpackCargoGlobal _box;
		_weaponsBefore = [];
	} else {
		_weaponsBefore = weaponCargo _box;
	};
	//PUT ITENS ON BOX
	if (_valor > 0) then {
		_addExtra = [];
		for "_i" from 1 to selectRandom [0,0,0,0,0,0,0,1,1,1] do {_addExtra pushBack selectRandom BRPVP_rareExtraLootInBoxA;};
		for "_i" from 1 to selectRandom [1,1,1,2,2,2,2,3,3,3] do {_addExtra pushBack selectRandom BRPVP_foodClassArray;};
		for "_i" from 1 to selectRandom [0,0,0,0,0,0,0,1,1,1] do {_addExtra pushBack "BRPVP_foodEnergyDrink";};
		private _itemsAll = [];
		private _itemsOk = +BRPVP_mercadoItensLoot;
		private _typeOk = +BRPVP_lootTypeChance;
		private _itemsOkTemp = [];
		while {
			_typeOkNow = [];
			{if ((_x select 4) > _valor) then {_itemsOk set [_forEachIndex,-1];} else {_typeOkNow pushBackUnique (_x select 0);};} forEach _itemsOk;
			_itemsOk = _itemsOk-[-1];
			{if !((_x select 0) in _typeOkNow) then {_typeOk set [_forEachIndex,-1];};} forEach _typeOk;
			_typeOk = _typeOk-[-1];
			private _sum = 0;
			{_sum = _sum+(_x select 1);} forEach _typeOk;
			private _idxSel = -1;
			if (_sum isEqualTo 0) then {
				_idxSel = (selectRandom _typeOk) select 0;
			} else {
				private _rnd = random _sum;
				private _sumSel = 0;
				{
					_sumSel = _sumSel+(_x select 1);
					if (_sumSel > _rnd) exitWith {_idxSel = _x select 0;};
				} forEach _typeOk;
			};
			_itemsOkTemp = [];
			{if ((_x select 0) isEqualTo _idxSel) then {_itemsOkTemp pushBack _x;};} forEach _itemsOk;
			count _itemsOkTemp > 0
		} do {
			_itemIdc = floor random count _itemsOkTemp;
			_itemPrc = _itemsOkTemp select _itemIdc select 4;
			for "_p" from 1 to _tries do {
				_itemXIdc = floor random count _itemsOkTemp;
				_itemXPrc = _itemsOkTemp select _itemXIdc select 4;
				if (_itemXPrc > _itemPrc) then {
					_itemIdc = _itemXIdc;
					_itemPrc = _itemXPrc;
				};
			};
			_itemsAll pushBack (_itemsOkTemp select _itemIdc select 3);
			_valor = _valor-_itemPrc;
		};
		_itemsAll append _addExtra;
		[_box,_itemsAll] call BRPVP_addLoot;
	};

	//PUT RARE ITEM
	private _hareYes = [];
	for "_i" from 1 to _rare do {
		if (random 1 < _chance) then {
			_total = 0;
			{_total = _total+_x;} forEach BRPVP_missionLootChanceOfRareItems;
			_random = random _total;
			_idx = -1;
			_sum = 0;
			{
				_sum = _sum+_x;
				if (_random <= _sum) exitWith {_idx = _forEachIndex;};
			} forEach BRPVP_missionLootChanceOfRareItems;
			private _item = selectRandom (BRPVP_ultraItems select _idx);
			if (_item isEqualType "") then {_hareYes pushBack _item;} else {_hareYes pushBack selectRandom _item;};
		};
	};
	if !(_hareYes isEqualTo []) then {
		_box setVariable ["brpvp_rare_item",true,true];
		[_box,_hareYes] call BRPVP_addLoot;
	};

	//ADD WEAPONS AMUNITION
	{
		if (isClass (configFile >> "CfgWeapons" >> _x >> "magazines")) then {
			private _mag = selectrandom getArray (configFile >> "CfgWeapons" >> _x >> "magazines");
			if (_mag call BRPVP_classExists) then {_box addMagazineCargoGlobal [_mag,4];};
		};
	} forEach (weaponCargo _box-_weaponsBefore);
};
//INPUT ANGLES MUST BE FROM 0 TO 360
BRPVP_angleBetween = {
	params ["_angleA","_angleB"];
	if (abs(_angleA-_angleB) < 180) then {
		abs(_angleA-_angleB)
	} else {
		_max = _angleA max _angleB;
		_min = _angleA min _angleB;
		_min+360-_max
	};
};
BRPVP_findAlignedGates = {
	_obj = _this;
	_isWall = _obj isKindOf "Wall";
	_haveDoor = isClass (configFile >> "CfgVehicles" >> typeOf _obj >> "AnimationSources") && {isClass (configFile >> "CfgVehicles" >> typeOf _obj >> "AnimationSources" >> "Door_1_sound_source")};
	if (_isWall && _haveDoor) then {
		_dirObj = getDir _obj;
		_angleLimit = 25;
		_found = [_obj];
		_searchNext = [_obj];
		_exclude = [];
		while {count _searchNext > 0} do {
			_foundNew = [];
			{_foundNew = _foundNew + ((((_x nearObjects ["Wall",5])-_found)-_exclude)-_foundNew);} forEach _searchNext;
			_foundNew = _foundNew apply {
				_dirToA = [_obj,_x] call BIS_fnc_dirTo;
				_dirToB = [_x,_obj] call BIS_fnc_dirTo;
				_dirToOk = [_dirToA,_dirObj] call BRPVP_angleBetween < _angleLimit || [_dirToB,_dirObj] call BRPVP_angleBetween < _angleLimit;
				_2dOk = _obj distance2D _x < 0.65;
				_dirA = getDir _x;
				_dirB = (_dirA+180) mod 360;
				_dirOk = [_dirA,_dirObj] call BRPVP_angleBetween < _angleLimit || [_dirB,_dirObj] call BRPVP_angleBetween < _angleLimit;
				_haveDoor = isClass (configFile >> "CfgVehicles" >> typeOf _x >> "AnimationSources") && {isClass (configFile >> "CfgVehicles" >> typeOf _x >> "AnimationSources" >> "Door_1_sound_source")};
				if ((_dirToOk || _2dOk) && _dirOk && _haveDoor) then {_x} else {_exclude pushBack _x;-1};
			};
			_foundNew = _foundNew - [-1];
			_found = _found + _foundNew;
			_searchNext = +_foundNew;
		};
		count _found
	} else {
		0
	};
};
BRPVP_ownedHousesAddRE = {if (!isNil "BRPVP_ownedHouses") then {BRPVP_ownedHouses pushBack _this;};};
BRPVP_ownedHousesRemoveRE = {if (!isNil "BRPVP_ownedHouses") then {BRPVP_ownedHouses = BRPVP_ownedHouses-[_this];};};
BRPVP_setLoadout = {
	params ["_player","_loadout"];
	if (player isEqualTo _player) then {
		player call BRPVP_pelaUnidade;
		player setUnitLoadout _loadout;
	};
};
BRPVP_isUnderWater = {surfaceIsWater getPosWorld _this && (getPosASL _this select 2) < -2};
BRPVP_dressAsSurvivor = {
	private ["_survivor","_uniformes","_caps","_oculosTipos","_moda","_uniforme","_cap","_oculos"];
	_survivor = _this;
	_uniformes = ["U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_C_Man_casual_6_F"];
	_caps = ["H_Bandanna_mcamo","H_Bandanna_surfer","H_Hat_blue","H_Hat_tan","H_StrawHat_dark","H_Bandanna_surfer_grn","H_Cap_surfer"];
	_oculosTipos = ["G_Diving"];
	{_survivor removeWeapon _x;} forEach weapons _survivor;
	removeAllAssignedItems _survivor;
	removeBackpackGlobal _survivor;
	removeUniform _survivor;
	removeVest _survivor;
	removeHeadGear _survivor;
	removeGoggles _survivor;
	_moda = floor random (50 + 1);
	_uniforme = _uniformes select (_moda mod count _uniformes);
	_cap = _caps select (_moda mod count _caps);
	_oculos = _oculosTipos select (_moda mod count _oculosTipos);
	_survivor forceAddUniform _uniforme;
	if (_moda mod 5 != 0) then {_survivor addHeadGear _cap;};
};
BRPVP_specialMessageShow = {
	if !(player getVariable ["id_bd",-1] in BRPVP_playerIdListNoAutomaticMessages) then {
		params ["_txt","_duration"];
		["<img shadow='0' size='1.75' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\msg_skull.paa'/><br/><t shadow='0' color='#00C000' size='0.85'>"+_txt+"</t>",{0},{(safezoneY + 0.05) min 0},_duration,0,0,8757] call BRPVP_fnc_dynamicText;
	};
};
BRPVP_randomNTimes = {
	params ["_total","_chance"];
	_totalChance = 0;
	for "_i" from 1 to _total do {if (random 1 < _chance) then {_totalChance = _totalChance + 1;};};
	_totalChance
};
BRPVP_turretsOnFlagLimitReached = {
	params ["_pos","_fix",["_boo",true]];
	private _reached = false;
	private _count = 0;
	_pos = if (_pos isEqualType objNull) then {ASLToAGL getPosASL _pos} else {_pos};
	{
		private _flag = _x;
		private _rad = _flag getVariable ["brpvp_flag_radius",0];
		if (_pos distance2D _flag <= _rad) then {
			private _limit = 0;
			private _ids = [];
			{if (_rad isEqualTo (_x select 0)) exitWith {_limit = _x select 1;};} forEach BRPVP_turretTerrainLimit;
			{if ((_x select 2) distance2D _flag <= _rad) then {_ids pushBackUnique (_x select 3);};} forEach BRPVP_allTurretsInfo;
			{_ids pushBackUnique (_x getVariable ["id_bd",-1]);} forEach nearestObjects [_flag,BRP_kitAutoTurret,_rad,true];
			_count = count (_ids-[-1]);
			if (_count >= _limit+_fix) then {_reached = true;};
		};
	} forEach nearestObjects [_pos,["FlagCarrier"],200,true];
	[_count-_fix,_reached] select _boo
};
BRPVP_removeDeniedItems = {
	private ["_boxCargo"];
	_boxCargo = weaponCargo _this+magazineCargo _this+backpackCargo _this+itemCargo _this-(BRPVP_deniedItems+BRPVP_AIMagazinesRemove);
	clearWeaponCargoGlobal _this;
	clearMagazineCargoGlobal _this;
	clearItemCargoGlobal _this;
	clearBackpackCargoGlobal _this;
	[_this,_boxCargo] call BRPVP_addLoot;
};
BRPVP_isPlayer = {_this getVariable ["sok",false]};
BRPVP_isPlayerB = {_this getVariable ["id_bd",-1] isNotEqualTo -1 && _this call BRPVP_pAlive};
BRPVP_isPlayerC = {_this getVariable ["id_bd",-1] isNotEqualTo -1};
BRPVP_zombieCanSee = {
	simulationEnabled _this && _this getVariable ["brpvp_zombie_can_see",true] && (_this getVariable ["brpvp_zombie_can_see_player",0]) isEqualTo 0 && (!(_this getVariable ["brpvp_z_blood_bag_on",false]) || {_this getVariable ["brpvp_in_infected_city",false]})
};
BRPVP_removeNearestTree = {
	{
		_obj = _x;
		_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
		if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {[_x,true] remoteExecCall ["hideObjectGlobal",2];};
	} forEach nearestTerrainObjects [_this,[],3,false,true];
};
BRPVP_removeNearestTreeUndo = {
	_near = [];
	{if (typeOf _x isEqualTo "Land_Shovel_F") then {_near pushBack _x;};} forEach nearestTerrainObjects [_this,[],7,false];
	_near = _near - [_this];
	{
		_obj = _x;
		_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
		if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner  && {_x distance _obj < 3} count _near isEqualTo 0) then {[_x,false] remoteExecCall ["hideObjectGlobal",2];};
	} forEach nearestTerrainObjects [_this,[],4,false,true];
};
BRPVP_areaCleanerExec = {
	{
		_obj = _x;
		_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
		if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {[_x,true] remoteExecCall ["hideObjectGlobal",2];};
	} forEach nearestTerrainObjects [_this,[],50,false];
};
BRPVP_areaCleanerUndo = {
	private _near = [];
	{if (typeOf _x isEqualTo "Land_GarbageBin_02_F") then {_near pushBack _x;};} forEach nearestObjects [_this,[],105];
	_near = _near-[_this];
	{
		private _obj = _x;
		private _noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
		if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner && {_x distance _obj < 50} count _near isEqualTo 0) then {[_x,false] remoteExecCall ["hideObjectGlobal",2];};
	} forEach nearestTerrainObjects [_this,[],55,false];
};
BRPVP_flagPayPrice = {
	_age = [BRPVP_sessionTimeStamp,_this getVariable ["brpvp_lastPayment",[0,0,0,0,0,0]]] call BRPVP_dateDiff;
	round ((_age max 0)*(_this call BRPVP_getFlagPayPrice)/BRPVP_daysWithoutMantainToFlagDisapears);
};
BRPVP_getFlagPayPrice = {
	_typeOf = typeOf _this;
	if (_typeOf in BRP_kitFlags25) exitWith {BRPVP_daysWithoutMantainToFlagDisapearsPrice select 0};
	if (_typeOf in BRP_kitFlags50) exitWith {BRPVP_daysWithoutMantainToFlagDisapearsPrice select 1};
	if (_typeOf in BRP_kitFlags100) exitWith {BRPVP_daysWithoutMantainToFlagDisapearsPrice select 2};
	if (_typeOf in BRP_kitFlags200) exitWith {BRPVP_daysWithoutMantainToFlagDisapearsPrice select 3};
	0
};
BRPVP_itemMoneyCreate = {
	private ["_items","_valors","_money"];
	_money = _this;
	_valors = + BRPVP_moneyItems select 1;
	_valors sort false;
	_result = [];
	{
		_item = BRPVP_moneyItems select 0 select ((BRPVP_moneyItems select 1) find _x);
		while {_money >= _x} do {
			_result pushBack _item;
			_money = _money - _x;
		};
	} forEach _valors;
	_result
};
BRPVP_objGroundyOnOther = {
	params ["_obj","_ground"];
	private ["_typeOf","_bb","_bb0","_bb1","_return","_idx","_gBB","_fix"];

	//OBJ BB
	_bb = boundingBoxReal _obj;
	_bb0 = _bb select 0;
	_bb1 = _bb select 1;

	//GROUND BB
	_typeOf = typeOf _ground;
	_idx = BRPVP_groundLikeObjects find _typeOf;
	if (_idx isEqualTo -1) then {
		_fix = [[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.00]];
	} else {
		_fix = BRPVP_groundLikeObjectsBbZFix select _idx;
	};
	_gBB = boundingBoxReal _ground;
	_gBB set [0,(_gBB select 0) vectorAdd (_fix select 0)];
	_gBB set [1,(_gBB select 1) vectorAdd (_fix select 1)];

	//GROUNDED CHECK
	_return = [];
	{
		if ([_obj modelToworld _x,_ground,_gBB] call PDTH_pointIsInBoxCustomBB) then {
			_return pushBack _forEachIndex;
		};
	} forEach [
		[_bb0 select 0,_bb0 select 1,_bb0 select 2],
		[_bb1 select 0,_bb1 select 1,_bb0 select 2],
		[_bb0 select 0,_bb1 select 1,_bb0 select 2],
		[_bb1 select 0,_bb0 select 1,_bb0 select 2]
	];
	_return
};
BRPVP_hangarDoorControl = {
	_object = _this select 3;
	_hasAccess = _object call BRPVP_checaAcesso;

	//ENABLE SIMULATION
	_object setVariable ["brpvp_time_can_disable",serverTime+15,2];
	if (!simulationEnabled _object) then {[_object,true] remoteEXecCall ["enableSimulationGlobal",2];};

	//TRY TO USE LOCK PICK IF HOUSE AND NEEDED AND EQUIPED IN PLAYER
	_forceAccess = false;
	_allowError = true;
	if (!_hasAccess && BRPVP_equipedIllegalItem isEqualTo "BRP_doorThief") then {
		_remove = false;
		_allowError = false;
		if (random 1 < BRPVP_lockPickChanceOfSuccess) then {
			_lpObj = BRPVP_equipedIllegalItemPatern select 2;
			if (isNull _lpObj) then {
				BRPVP_equipedIllegalItemPatern set [2,_object];
				_lpObj = _object;
			};
			if (_object isEqualTo _lpObj) then {
				if (BRPVP_equipedIllegalItemPatern select 1 >= 8) then {
					if (BRPVP_equipedIllegalItemPatern select 0 isEqualTo 1) then {
						_forceAccess = true;
						"lock_pick_ok_music" call BRPVP_playSound;
						[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
						if (BRPVP_hackObjectsOneTimeOnly) then {
							_object setVariable ["brpvp_hacked",true,true];
							_places = _object getVariable ["brpvp_hacked_places",[]];
							_places pushBack getPosASL player;
							_arrow = createSimpleObject ["Sign_Arrow_F",getPosASL player];
							_arrow setVariable ["brpvp_hack_arrow",true,true];
							_object setVariable ["brpvp_hacked_places",_places,true];
						};
						[_object getVariable "own",player getVariable "id_bd",player getVariable "nm",typeOf _object,getPosWorld _object] remoteExecCall ["BRPVP_logBaseInvasion",2];

						//HINT PEOPLE ABOUT THE INVASION
						[player,getPosWorld _lpObj,serverTime] remoteExecCall ["BRPVP_lockPickedBuildingsServerAdd",2];
						_remove = true;
					} else {
						[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
						BRPVP_equipedIllegalItemPatern set [0,(BRPVP_equipedIllegalItemPatern select 0) - 1];
						BRPVP_equipedIllegalItemPatern set [1,0];
					};
				} else {
					[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
					BRPVP_equipedIllegalItem = "";
				};
			} else {
				[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
				BRPVP_equipedIllegalItem = "";
			};
		} else {
			[player,["lock_pick_not_ok",100]] remoteExecCall ["say3D",BRPVP_allNoServer];
			_remove = true;
		};
		
		if (_remove) then {
			[BRPVP_specialItems find BRPVP_equipedIllegalItem,1] call BRPVP_sitRemoveItem;
			BRPVP_equipedIllegalItem = "";
		};
	};

	if (_hasAccess || _forceAccess) then {
		_newState = 1 - round (_object animationPhase "door_2_move");
		_object animate ["door_2_move",_newState,true];
		_object animate ["door_3_move",_newState,true];
	} else {
		if (_allowError) then {"erro" call BRPVP_playSound;};
	};
};
BRPVP_buildingHDEHCVL = {
	private _selection = _this select 1;
	if (_selection find "glass_" isEqualTo 0) then {
		private _object = _this select 0;
		private _damage = _this select 2;
		[typeOf _object,_object getVariable "id_bd",[_selection,_damage]] remoteExecCall ["BRPVP_setHitGlassCVL",-clientOwner];
		_damage
	} else {
		0
	};
};
BRPVP_buildingHDEH = {
	private _object = _this select 0;
	private _selection = _this select 1;
	private _damage = _this select 2;
	if (_selection find "glass_" isEqualTo 0) then {
		_object setVariable ["brpvp_time_can_disable",serverTime+15];
		if (!simulationEnabled _object) then {_object enableSimulationGlobal true;};
		_damage
	} else {
		0
	};
};
BRPVP_checkIfSafeZoneProtected = {
	_in = false;
	{if (_this distanceSqr (_x select 0) <= (_x select 1)) exitWith {_in = true;};} forEach BRPVP_safeZonesOtherMethodQuad;
	_in
};
BRPVP_playerServerVehHD = {
	params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
	_damKey = _veh getVariable ["brpvp_damage_key",0];
	_tickTime = diag_tickTime;
	if (_tickTime-_damKey > 0.02) then {
		_veh setVariable ["brpvp_damage_key",_tickTime];
		if (_veh getVariable ["id_bd",-1] isNotEqualTo -1 || _veh getVariable ["brpvp_fedidex",false]) then {[_veh,10] call BRPVP_enableVehOnInteraction;};
		_crew = crew _veh;
		_isProjL2 = _proj in [BRPVP_autoTurretHmgLvl2Rocket,BRPVP_autoTurretHmgLvl2Penetrator];
		_isTimeL2 = _tickTime-(_veh getVariable ["brpvp_tl2_hit_time",0]) < 0.5;
		_veh setVariable ["brpvp_dam_tl2",_isProjL2 && _isTimeL2];

		//SET .50 TURRET EXPLOSION ON TANK
		if ((typeOf _instigator in ["B_Soldier_VR_F","C_Soldier_VR_F"] && {vehicle _instigator getVariable ["brpvp_tlevel",-1] isEqualTo 2 && _veh getVariable ["brpvp_use_texplode",false] && random 1 < 1/BRPVP_autoTurretHmgBlastEachXShots}) || (_instigator getVariable ["brpvp_lars",false] && random 1 < 0.5 && (!_isProjL2 || {random 1 < 0.2}))) then {
			private _vpos = getPosASL _veh vectorAdd [0,0,0.5];
			private _vec = (vectorNormalized (eyePos _instigator vectorDiff _vpos)) vectorMultiply 10;
			private _lis = lineIntersectsSurfaces [_vpos vectorAdd _vec,_vpos,vehicle _instigator,objNull,true,-1,"GEOM","NONE"];
			private _idx = -1;
			{if ((_x select 2) isEqualTo _veh) exitWith {_idx = _forEachIndex;};} forEach _lis;
			if (_idx isNotEqualTo -1) then {
				_veh setVariable ["brpvp_tl2_hit_time",_tickTime];
				_mPos = _veh worldToModel (ASLToAGL (_lis select _idx select 0));
				[_veh,_instigator,_mPos] remoteExecCall ["BRPVP_setTurretLvl2Explosion",2];
			};
		};

		//CHECK IF PROTECTED
		_protected = if (_veh getVariable ["own",-1] isEqualTo -1 || count _crew > 0) then {_veh call BRPVP_checkIfSafeZoneProtected} else {_veh call BRPVP_checkIfFlagProtected || _veh call BRPVP_checkIfSafeZoneProtected};

		//GET SOURCE
		_fromMoto = _source call BRPVP_isMotorizedNoTurret;
		_classMoto = typeOf _source;
		_source = if (isNull _instigator) then {
			private _ec = effectiveCommander _source;
			if (isNull _ec) then {_source} else {_ec};
		} else {
			_instigator
		};

		//RECORD LAST SOURCE
		_veh setVariable ["brpvp_last_source",[_source,serverTime]];

		//CHECK IF PVE PROTECTED
		_sInPVE = if (_fromMoto) then {
			 {_source distance2D (_x select 0) < _x select 1} count BRPVP_pveMainAreas > 0 && {_source distance2D (_x select 0) < _x select 1} count BRPVP_PVPAreas isEqualTo 0
		} else {
			(_source getVariable ["brpvp_pve_inside",0] > 0 && _source getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0)
		};
		_vInPVE = {_veh distance2D (_x select 0) < _x select 1} count BRPVP_pveMainAreas > 0 && {_veh distance2D (_x select 0) < _x select 1} count BRPVP_PVPAreas isEqualTo 0;
		_vHaveId = _veh getVariable ["id_bd",-1] isNotEqualTo -1;
		_sIsBanditOrAI = (_source in BRPVP_pveBanditObjList && _sInPVE) || _source getVariable ["id_bd",-1] isEqualTo -1;
		_vIsBanditOrAI = {(_x in BRPVP_pveBanditObjList && _vInPVE) || _x getVariable ["id_bd",-1] isEqualTo -1} count _crew > 0;
		_crewMakeProt = !_vIsBanditOrAI && (_crew isNotEqualTo [] || _vHaveId);
		if ((_sInPVE || _vInPVE) && !_sIsBanditOrAI && _crewMakeProt) then {_protected = true;};

		//FROM BASE NO RAID DAY
		if (!isNull _source && isNull (_source getVariable ["brpvp_turret",objNull])) then {
			if (!BRPVP_raidServerIsRaidDay) then {
				_vInBase = [_veh,BRPVP_noRaidDayBaseExtension] call BRPVP_checkOnFlagStateExtraRadius > 0 && ASLToAGL getPosASL _veh select 2 <= BRPVP_maxBuildHeight+75;
				_sInBase = [_source,BRPVP_noRaidDayBaseExtension] call BRPVP_checkOnFlagStateExtraRadius > 0 && ASLToAGL getPosASL _source select 2 <= BRPVP_maxBuildHeight+75;
				if !((_vInBase && _sInBase) || (!_vInBase && !_sInBase)) then {
					if (_source call BRPVP_isPlayer) then {[_sInBase,true] remoteExecCall ["BRPVP_cantHurtFromBaseMsg",_source];};
					private _crewP = [];
					{if (_x call BRPVP_isPlayer) then {_crewP pushBack _x;};} forEach _crew;
					[_vInBase,false] remoteExecCall ["BRPVP_cantHurtFromBaseMsg",_crewP];
					_protected = true;
				};
			};
		};

		//IS TURRET BASE TEST
		_vehSource = vehicle _source;
		_vehSourceId = _vehSource getVariable ["id_bd",-1];
		if (_vehSource isKindOf "StaticWeapon" && _vehSourceId > 0) then {
			if (typeOf _veh in BRPVP_vantVehiclesClass) then {
				private _operators = [];
				{if (_x isEqualType objNull && {!isNull _x}) then {_operators pushBack _x;};} forEach UAVControl _veh;
				{if (_x getVariable ["brpvp_base_test",0] > 0) exitWith {if (_vehSource call BRPVP_checaAcesso) then {_protected = true;};};} forEach _operators;
			} else {
				if ((currentPilot _veh getVariable ["brpvp_base_test",0]) > 0) then {
					if (_vehSource call BRPVP_checaAcesso) then {_protected = true;};
				};
			};
		};

		//VEH MISSION PROTECTED
		if (_veh getVariable ["brpvp_veh_godmode",false]) then {_protected = true;};

		//COLLISION PROTECTED
		_collProtect = _veh isKindOf "LandVehicle" || _veh getVariable ["brpvp_coll_prot",false] || _veh getVariable ["brpvp_coll_prot_time",0] > time;
		if (_collProtect && _proj isEqualTo "") then {_protected = true;};

		//DAMAGE FROM VEH WITH DAMAGE OFF DAY
		_vsUAV = _source call BRPVP_controlingUAV;
		_vs = if (isNull _vsUAV) then {typeOf objectParent _source} else {typeOf _vsUAV};
		_ip = _source call BRPVP_isPlayerC;
		_isTow = if (_crew isEqualTo []) then {false} else {[typeOf (_crew select 0)] isEqualTo ["C_Driver_1_F"]};
		_hp = {_x call BRPVP_isPlayerC} count _crew > 0;
		_vehIsNoDam = typeOf _veh in BRPVP_noDamageVehList;
		if (_vs in BRPVP_noDamageVehList && _ip && (_hp || _crew isEqualTo [] || _isTow)) then {_protected = true;};
		if (_vehIsNoDam && _ip) then {_protected = true;};

		//CHECK IF AI ON DISTANCE PROTECTED AND PROTECT IF FRIRE FROM FRIEND
		_isAIVehicle = {_x getVariable ["id_bd",-1] > -1} count _crew isEqualTo 0 && count _crew > 0 && driver _veh isNotEqualTo "C_Driver_1_F";
		if (!simulationEnabled _veh && _isAIVehicle) then {_protected = true;};
		if (_isAIVehicle && side _source isEqualTo side _veh) then {_protected = true;};

		_veh setVariable ["brpvp_protected",_protected];
		
		//SET ATTACK VEH DAMAGE MULT
		private _vlm = objectParent _source getVariable ["brpvp_kills",0];
		_veh setVariable ["brpvp_vlm_mult",1+(BRPVP_vehLvlMaxMult-1)*(_vlm min BRPVP_vehLvlMaxKills)/BRPVP_vehLvlMaxKills];

		//SET ATTACKED VEH RESISTENCE MULT
		private _vrm = _veh getVariable ["brpvp_kills",0];
		_veh setVariable ["brpvp_vrm_mult",1+(BRPVP_vehLvlMaxMult-1)*(_vrm min BRPVP_vehLvlMaxKills)/BRPVP_vehLvlMaxKills];

		if (alive _veh) then {
			//SAVE GEAR IN ITSELF
			_gearSaveTime = (_veh getVariable ["brpvp_vehicle_gear_die",[0,-1]]) select 0;
			if (time-_gearSaveTime > 2) then {_veh setVariable ["brpvp_vehicle_gear_die",[time,_veh call BRPVP_getCargoArrayNoNumber]];};

			//SAVE VEHICLE IF DIE
			_veh call BRPVP_getVehDataBeforeDie;
		};
		
		//SAVE VEH DAMAGE
		if !(_veh getVariable ["slv",false]) then {_veh setVariable ["slv",true,true];};
	};
	if (_veh getVariable "brpvp_protected") then {
		if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
	} else {
		if (_veh getVariable "brpvp_dam_tl2") then {
			if (_part isEqualTo "") then {
				_dNow = damage _veh;
				_dNow+(_dam-_dNow)*BRPVP_autoTurretHmgLvl2Damage
			} else {
				_dNow = _veh getHit _part;
				_dNow+(_dam-_dNow)*BRPVP_autoTurretHmgLvl2Damage
			};
		} else {
			private _vlmMult = _veh getVariable "brpvp_vlm_mult";
			private _vrmMult = _veh getVariable "brpvp_vrm_mult";
			//str [_vlmMult,_vrmMult] remoteExecCall ["systemChat",allPlayers];
			private _dNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
			if (_veh isKindOf "Air" && !isNull currentPilot _veh) then {
				private _dMult = if (_proj isEqualTo "") then {BRPVP_airVehicleResistenceCollision} else {_vrmMult*BRPVP_airVehicleResistence/_vlmMult};
				_dNow+(_dam-_dNow)/_dMult
			} else {
				_dNow+(_dam-_dNow)*_vlmMult/_vrmMult
			};
		};
	};
};
BRPVP_getFlagRadius = {
	private _typeOf = if (_this isEqualType "") then {_this} else {typeOf _this};
	if (_typeOf in BRP_kitFlags200) exitWith {200};
	if (_typeOf in BRP_kitFlags100) exitWith {100};
	if (_typeOf in BRP_kitFlags50) exitWith {50};
	if (_typeOf in BRP_kitFlags25) exitWith {25};
	0
};
BRPVP_checkIfFlagDenied = {
	private ["_nearFlags"];
	if (isNull _this) then {
		true
	} else {
		_nearFlags = nearestObjects [_this,BRP_kitFlags25,25,true];
		_nearFlags append nearestObjects [_this,BRP_kitFlags50,50,true];
		_nearFlags append nearestObjects [_this,BRP_kitFlags100,100,true];
		_nearFlags append nearestObjects [_this,BRP_kitFlags200,200,true];
		count _nearFlags > 0 && ({[_this,_x] call BRPVP_checaAcessoRemotoFlag} count _nearFlags isEqualTo 0);
	};
};
BRPVP_checkIfEnemyFlagExtraRadius = {
	params ["_obj","_xRad"];
	private ["_nearFlags"];
	if (isNull _obj) then {
		true
	} else {
		_nearFlags = nearestObjects [_obj,BRP_kitFlags25,25+_xRad,true];
		_nearFlags append nearestObjects [_obj,BRP_kitFlags50,50+_xRad,true];
		_nearFlags append nearestObjects [_obj,BRP_kitFlags100,100+_xRad,true];
		_nearFlags append nearestObjects [_obj,BRP_kitFlags200,200+_xRad,true];
		count _nearFlags > 0 && ({!([_obj,_x] call BRPVP_checaAcessoRemotoFlag)} count _nearFlags > 0);
	};
};
BRPVP_checkIfFlagProtectedLast = [0,objNull,false];
BRPVP_checkIfFlagProtected = {
	private ["_result"];
	if (_this isEqualTo (BRPVP_checkIfFlagProtectedLast select 1) && time-(BRPVP_checkIfFlagProtectedLast select 0) < 2) then {
		_result = BRPVP_checkIfFlagProtectedLast select 2;
	} else {
		private ["_nearFlags"];
		_result = if (alive _this && !isNull _this) then {
			_nearFlags = nearestObjects [_this,BRP_kitFlags25,25,true];
			_nearFlags append nearestObjects [_this,BRP_kitFlags50,50,true];
			_nearFlags append nearestObjects [_this,BRP_kitFlags100,100,true];
			_nearFlags append nearestObjects [_this,BRP_kitFlags200,200,true];
			{[_this,_x] call BRPVP_checaAcessoRemotoFlag} count _nearFlags > 0;
		} else {
			false
		};
		BRPVP_checkIfFlagProtectedLast = [time,_this,_result];
	};
	_result
};
BRPVP_removeObject = {
	params ["_objToDel","_removeFromDB",["_deleteObj",true]];
	if (_objToDel isEqualType objNull) then {
		if (_objToDel isKindOf "FlagCarrier") then {
			[_objToDel,{BRPVP_allFlags deleteAt (BRPVP_allFlags find _this);}] remoteExecCall ["call",2];
			[
				_objToDel,
				{
					BRPVP_allFlags deleteAt (BRPVP_allFlags find _this);
					if (_this in BRPVP_myStuffOthers) then {call BRPVP_findMyFlags;};
				}
			] remoteExecCall ["call",BRPVP_allNoServer];
		};
		if (typeOf _objToDel isEqualTo "Land_GarbageBin_02_F") then {_objToDel call BRPVP_areaCleanerUndo;};
		if (typeOf _objToDel isEqualTo "Land_Shovel_F") then {_objToDel call BRPVP_removeNearestTreeUndo;};
		{if (typeOf _x isEqualTo "Land_CUP_Frigate_Ladders") then {deleteVehicle _x;};} forEach attachedObjects _objToDel;
	};
	[_objToDel,_removeFromDB,_deleteObj] remoteExecCall ["BRPVP_removeObjectServer",2];
};
BRPVP_checaAcessoRemotoFlag = {
	params ["_obj","_flag"];
	_objOwn = _obj getVariable ["own",-1];
	_flagOwn = _flag getVariable ["own",-2];
	_flagAmg = (_flag getVariable ["amg",[[],[],true]]) select 1;
	_objOwn in _flagAmg || _objOwn isEqualTo _flagOwn
};
BRPVP_checaAcessoRemoto = {
	params ["_pAccess","_pAcessed"]; // [a player, other player]
	private ["_id_bd","_amg","_oOwn","_oAmg","_oShareT","_retorno"];

	//MINHAS RELACOES
	_id_bd = _pAccess getVariable ["id_bd",-1];
	_amg = _pAccess getVariable ["amg",[]];

	//RELACOES OBJ CHECADO
	_oOwn = _pAcessed getVariable ["own",-1];
	_oAmg = _pAcessed getVariable ["amg",[]];
	_oShareT = _pAcessed getVariable ["stp",1];
	
	_retorno = false;
	if !(_oShareT isEqualTo 4 && !BRPVP_vePlayers) then {
		if (BRPVP_vePlayers || _oOwn isEqualTo -1 || _id_bd isEqualTo _oOwn || _oShareT isEqualTo 3) then {
			_retorno = true;
		} else {
			if (_oShareT != 0) then {
				if (_oShareT isEqualTo 1) then {
					if (_id_bd in _oAmg) then {_retorno = true;};
				} else {
					if (_oShareT isEqualTo 2) then {
						if (_id_bd in _oAmg && _oOwn in _amg) then {_retorno = true;};
					};
				};
			};
		};
	};
	_retorno
};
BRPVP_formatNumber = {
	private ["_txt"];
	_txt = abs _this call BIS_fnc_numberText;
	if (_this < 0) then {"-"+_txt} else {_txt};
};
BRPVP_MPKilled = {
	if (typeOf (_this select 0) isEqualTo "") exitWith {};
	if ((_this select 0) isKindOf "Building") exitWith {};
	if ((_this select 0) call BRPVP_isMotorized) then {
		params ["_v","_p"];
		if (isServer) then {
			if (_v getVariable ["id_bd",-1] isNotEqualTo -1 || _v getVariable ["brpvp_fedidex",false]) then {
				_v setVariable ["brpvp_time_can_disable",serverTime+20];
				if (!simulationEnabled _v) then {_v enableSimulationGlobal true;};
			};
			if (_v getVariable ["id_bd",-1] > -1) then {
				_v call BRPVP_veiculoMorreu;
				_v setVariable ["brpvp_veh_dead_run_ok",true,2];
				if (_v getVariable ["own",-1] > -1) then {
					private ["_key","_result"];
					//SET INSURANCE STATE IF INSURED
					if (BRPVP_useExtDB3) then {
						_key = format ["1:%1:activateInsurance:%2",BRPVP_protocolo,_v getVariable "id_bd"];
						_result = "extDB3" callExtension _key;
					} else {
						private _vehId = _v getVariable "id_bd";
						_key = "[_vehId,[[""insuranceState"",1]]] call BRPVP_hdb_query_updateInsurancesFieldsByVehicleId";
						_result = [_vehId,[["insuranceState",1]]] call BRPVP_hdb_query_updateInsurancesFieldsByVehicleId;
					};
					diag_log ("======== ACTIVATE INSURANCE ======");
					diag_log ("======== _key: "+_key+" | _result: "+_result+" ======");

					if (_v call BRPVP_IsMotorized) then {_v setVariable ["bdc",true,true];};
					private ["_okCrew"];
					_idBd = -1;
					if (isNull _p) then {
						_okCrew = "\nATTACKER UNKNOW";
					} else {
						if (_p call BRPVP_isMotorized) then {
							_okCrew = "\n[ATTACKER VEHICLE NAME] " + getText (configFile >> "CfgVehicles" >> (typeOf _p) >> "displayName");
							_countCargo = 0;
							{
								_role = (assignedVehicleRole _x) select 0;
								if (_role != "CARGO") then {
									_isPlayer = _x call BRPVP_isPlayer;
									_name = if (_isPlayer) then {_x getVariable ["nm","???"]} else {"AI Unit"};
									if (_isPlayer) then {
										_idBd = _x getVariable ["id_bd",-1];
										_okCrew = _okCrew + "\n[ATTACKER VEHICLE " + _role + "] " + str _idBd + " - " + _name;
									} else {
										_okCrew = _okCrew + "\n[ATTACKER VEHICLE " + _role + "] " + _name;
									};
								} else {
									_countCargo = _countCargo + 1;
								};
							} forEach crew _p;
							_idBd = driver _p getVariable ["id_bd",-1];
							if (_countCargo > 0) then {
								_okCrew = _okCrew + "\n[ATTACKER VEHICLE CARGO] X" + str _countCargo + " UNITS";
							};
						} else {
							_isPlayer = _p call BRPVP_isPlayer;
							_name = if (_isPlayer) then {_p getVariable ["nm","???"]} else {"AI Unit"};
							_okCrew = if (_isPlayer) then {_idBd = _p getVariable ["id_bd",-1];"\n[ATTACKER SOLDIER NAME] " + str _idBd + " - " + _name} else {"\n[ATTACKER SOLDIER NAME] " + _name};
						};
					};
					_typeOf = typeOf _v;
					_owner = _v getVariable ["own",-1];
					_vPrettyName = getText (configFile >> "CfgVehicles" >> _typeOf >> "displayName");
					if (BRPVP_useExtDB3) then {
						"extDB3" callExtension format ["1:%1:addDestructionLog:%2:%3:%4:%5:%6:%7",BRPVP_protocolo,_owner,_owner,_idBd,_okCrew,_vPrettyName,_typeOf];
					} else {
						//NOTHING IF CLIENTSV
					};
				};
			};
		};
		if (hasInterface) then {
			if (_p isEqualTo player) then {[["matou_veiculo",1]] call BRPVP_mudaExp;};
			if (BRPVP_stuff isEqualTo _v) then {BRPVP_stuff = objNull;};

			//REMOVE CARRY HELI ACTION IF DRIVER NOT DIE
			if (typeOf _v in BRPVP_carryHelis) then {
				if (driver _v isEqualTo player) then {
					if (BRPVP_carryHeliAction > -1) then {
						player removeAction BRPVP_carryHeliAction;
						BRPVP_carryHeliAction = -1;
					};
				};
			};
		};

		//ADD VEHICLE ITEMS ON GROUND
		if (local _v) then {
			//REMOVE DUKE NUKEM ACTIONS
			if (!isNil "BRPVP_disableNearServiceAction") then {_v call BRPVP_disableNearServiceAction;};

			_gear = (_v getVariable ["brpvp_vehicle_gear_die",[0,[[[],[]],[],[[],[]],[[],[]]]]]) select 1;
			_pos = ASLToAGL getPosASL _v;
			if (_pos select 2 < 0) then {_pos set [2,0];};
			if (_pos select 2 < 10) then {
				_pos set [2,0];
				_wh = createVehicle ["GroundWeaponHolder",_pos,[],0,"CAN_COLLIDE"];
				{_wh addWeaponCargoGlobal [_x,[_gear select 0 select 1 select _forEachIndex,BRPVP_killedVehicleLootSavePercentage select 0] call BRPVP_randomNTimes];} forEach (_gear select 0 select 0);
				{if (random 1 < BRPVP_killedVehicleLootSavePercentage select 1) then {_wh addMagazineAmmoCargo _x;};} forEach (_gear select 1);
				{_wh addItemCargoGlobal [_x,[_gear select 2 select 1 select _forEachIndex,BRPVP_killedVehicleLootSavePercentage select 2] call BRPVP_randomNTimes];} forEach (_gear select 2 select 0);
				{_wh addBackpackCargoGlobal [_x,[_gear select 3 select 1 select _forEachIndex,BRPVP_killedVehicleLootSavePercentage select 3] call BRPVP_randomNTimes];} forEach (_gear select 3 select 0);
				{
					_c = _x select 1;
					clearWeaponCargoGlobal _c;
					clearMagazineCargoGlobal _c;
					clearItemCargoGlobal _c;
					clearBackpackCargoGlobal _c;
				} forEach everyContainer _wh;
			};

			//SET ATTACK VEHICLE LEVEL
			if !(_v isKindOf "StaticWeapon") then {
				(_v getVariable ["brpvp_last_source",[objNull,0]]) params ["_ls","_ht"];
				private _aVeh = objectParent _ls;
				if (_aVeh isNotEqualTo _v) then {
					private _new = serverTime-_ht < 20;
					private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _v >> "armor");
					private _isLand = _v isKindOf "Motorcycle" || _v isKindOf "Car" || _v isKindOf "Tank";
					if (_new && !isNull _aVeh && (!_isLand || {_armor >= 100})) then {
						private _kills = _aVeh getVariable ["brpvp_kills",0];
						_aVeh setVariable ["brpvp_kills",_kills+1,true];
						(_kills+1) remoteExecCall ["BRPVP_vehKillXpMessage",crew _aVeh];
					};
				};
			};

			//REMOVE SMOKE AFTER SOME TIME
			if (_v isKindOf "LandVehicle") then {
				if (random 1 < BRPVP_deadVehicleSmokeChanceToZeroEffects) then {
					_v remoteExec ["BRPVP_explosionDeleteSmoke",0];
				} else {
					_v spawn {
						uiSleep selectRandom BRPVP_deadVehicleSmokeTime;
						if (!isNull _this) then {_this remoteExec ["BRPVP_explosionDeleteSmoke",0];};
					};
				};
			};
		};
	};
};
//ZOMBIE FUNCTION
BRPVP_setZombieWalkMode = {
	_this setUnitPos (["UP","MIDDLE"] select ((_this getVariable "knl") || _this getVariable ["brpvp_mobius",false]));
};
BRPVP_zombieJump = {
	params ["_agnt","_attacker","_explode","_h","_dist",["_thunder",true],["_wait",0.001],["_useLastPos",[]]];
	if (incapacitatedState _agnt isEqualTo "") then {
		private ["_t","_vec","_isVisible"];
		_apWrd = if (_useLastPos isEqualTo []) then {getPosWorld _attacker} else {AGLToASL _useLastPos};
		if (_attacker getVariable ["brpvp_error_zed",false]) then {
			private _dst = 15+random 10;
			private _a = ([_agnt,_attacker] call BIS_fnc_dirTo)+selectRandom [120,-120];
			_apWrd = AGLToASL (ASLToAGL _apWrd vectorAdd [_dst*sin _a,_dst*cos _a,0]);
		};
		//CALC JUMP VELOCITY VECTOR
		_h = _h min 65;
		_hList = [];
		{if (_x <= 65) then {_hList pushBackUnique (_x max 6);};} forEach [_h/2,_h,_h*1.25,_h*1.5];
		{
			_vecX = _apWrd vectorDiff (getPosWorld _agnt);
			_vecXH = _vecX select 2;
			_vecX set [2,0];
			_velY = sqrt(2*9.8*((_x+_vecXH) max 2));
			_t = _velY/9.8;
			_velX = _dist/(2*_t);
			_velX = _velX * 1.25;
			_vecX = (vectorNormalized _vecX) vectorMultiply _velX;
			_vecY = [0,0,_velY];
			_vec = _vecX vectorAdd _vecY;
			//CHECK FREE PATH
			_vCheck = (vectorNormalized _vec) vectorMultiply 20;
			_agntWLD = getPosWorld _agnt;
			_isVisible = count lineIntersectsSurfaces [_agntWLD,_agntWLD vectorAdd _vCheck,_agnt,objNull,false,1,"GEOM","FIRE",true] isEqualTo 0;
			if (_isVisible) exitWith {};
		} forEach _hList;
		if (_isVisible) then {
			_agnt disableAI "MOVE";
			_agnt setDir ([_agnt,ASLToAGL _apWrd] call BIS_fnc_dirTo);
			([_t,_vec] + _this) spawn {
				params ["_t","_vec","_agnt","_attacker","_explode","_h","_dist",["_thunder",true],["_wait",0.001],["_useLastPos",[]]];
				_checkTime = 0.5;
				[_agnt,_vec] remoteExecCall ["setVelocity",0];
				if (_explode > 0) then {
					if (_explode isEqualTo 2) then {[_agnt,["crazy",600,0.9+random 0.15]] remoteExecCall ["say3D",BRPVP_allNoServer];};
					sleep _t;
					if (_explode isEqualTo 1) then {[_agnt,["jumper",600,0.9+random 0.15]] remoteExecCall ["say3D",BRPVP_allNoServer];};
					if (incapacitatedState _agnt isEqualTo "" && _explode isEqualTo 1) then {createVehicle ["HelicopterExploBig",getPosATL _agnt,[],0,"CAN_COLLIDE"];};
					waitUntil {position _agnt select 2 < 1.5};
					if (_explode isEqualTo 2 && incapacitatedState _agnt isEqualTo "") then {["Sh_105mm_HEAT_MP",_agnt modelToWorld [0,0,0],200] call BRPVP_trowBomb;};
					waitUntil {position _agnt select 2 < 0.25};
				} else {
					if (incapacitatedState _agnt isEqualTo "") then {
						if (_explode isEqualTo 0) then {[_agnt,["jumper",600,0.9+random 0.15]] remoteExecCall ["say3D",BRPVP_allNoServer];};
						if (_explode isEqualTo -2) then {[_agnt,["monster",600,0.9+random 0.15]] remoteExecCall ["say3D",BRPVP_allNoServer];};
						if (_explode isEqualTo -1) then {
							private _tp = _t*0.125;
							private _maxH = 17.5;
							private _tClasses = _agnt getVariable "brpvp_tgt_class";
							uiSleep (_tp*5);
							for "_i" from 6 to 10 do {
								if (incapacitatedState _agnt isNotEqualTo "") exitWith {if (_i < 9) then {uiSleep (_tp*(8-(_i-1)));};};
								uiSleep _tp;
								private _aASL = getPosASL _agnt;
								private _h = (ASLToAGL _aASL) select 2;
								if (_h > _maxH && _i isEqualTo 8) exitWith {["B_25mm",_agnt modelToWorld [0,0,0],200] call BRPVP_trowBomb;};
								if (_h <= _maxH) then {
									private _bellow = lineIntersectsSurfaces [_aASL,_aASL vectorAdd [0,0,-(_h+0.5)],_agnt,objNull,true,2,"GEOM","NONE",false];
									private _doExplode = false;
									{
										private _pos = ASLToAGL (_x select 0);
										private _obj = _x select 2;
										if (nearestObjects [_pos,_tClasses,3] isNotEqualTo [] || _obj call BRPVP_isMotorized) exitWith {_doExplode = true;};
									} forEach _bellow;
									if (_doExplode) then {
										["B_25mm",_agnt modelToWorld [0,0,0],200] call BRPVP_trowBomb;
										if (_i < 8) then {uiSleep (_tp*(8-_i));};
										break
									};
								};
							};
						} else {
							uiSleep _t;
						};
						waitUntil {position _agnt select 2 < 0.25};
					};
				};
				[_agnt,["jump_hit_ground",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
				if (incapacitatedState _agnt isEqualTo "") then {
					if (_explode in [0,-2]) then {
						private _aASL = getPosASL _agnt;
						private _tClasses = _agnt getVariable "brpvp_tgt_class";
						private _nearPlayers = nearestObjects [_agnt,_tClasses,2.5];
						private _vehBellow = lineIntersectsSurfaces [_aASL,_aASL vectorAdd [0,0,-1.5],_agnt,objNull,true,2,"GEOM","NONE",false];
						private _doExplode = _nearPlayers isNotEqualTo [] || {(_x select 2) call BRPVP_isMotorized} count _vehBellow > 0;
						if (_doExplode) then {["B_25mm",_agnt modelToWorld [0,0,0],200] call BRPVP_trowBomb;};
					};
					sleep 0.5;
					_agnt enableAI "MOVE";
					sleep 0.001;
					_agnt moveTo ASLToAGL getPosASL _agnt;
				};
				_agnt setVariable ["jpg",false,true];
			};
			true
		} else {
			_agnt setVariable ["jpg",false,true];
			false
		};
	} else {
		_agnt setVariable ["jpg",false,true];
		false
	};
};
BRPVP_addZombieLoot = {
	params ["_asl","_agls","_projectile","_attacker",["_q",1]];
	private _weaponHolder = objNull;
	private _weapon = currentWeapon _attacker;
	if !(_weapon in ["","GX_M82A2000_Weapon"]) then {
		private _mag = currentMagazine _attacker;
		if (_mag isNotEqualTo "") then {
			private _isMissile = _projectile isKindOf "RocketBase" || _projectile isKindOf "MissileBase";
			if (_isMissile) then {
				if (random 1 < 0.1) then {
					call BRPVP_addZombieLootCreateWH;
					_weaponHolder addMagazineCargoGlobal [_mag,selectRandom [1,1,1,2]];
				};
			} else {
				private _count = getNumber (configFile >> "CfgMagazines" >> _mag >> "count");
				private _factor = if (_count <= 10) then {1} else {if (_count <= 30) then {2} else {3}};
				if (_weapon isEqualTo handGunWeapon _attacker) then {_factor = _factor/2;};
				for "_i" from 1 to _q do {
					if (random 1 <= 1/(3*_factor)) then {
						call BRPVP_addZombieLootCreateWH;
						_weaponHolder addMagazineCargoGlobal [_mag,selectRandom [1,1,1,2]];
					};
				};
			};
		};
	};
	{
		_x params ["_chance","_itemList","_quantityList"];
		if (random 1 <= _chance) then {
			call BRPVP_addZombieLootCreateWH;
			private _items = [];
			for "_i" from 1 to (selectRandom (_x select 2)) do {_items pushBack selectRandom (_x select 1);};
			[_weaponHolder,_items] call BRPVP_addLoot;
		};
	} forEach BRPVP_zombieGiveItemsItems;
};
BRPVP_zombieLootWH = [];
BRPVP_addZombieLootCreateWH = {
	if (isNull _weaponHolder) then {
		_class = if (_agls select 2 < 0.25) then {"GroundWeaponHolder"} else {"WeaponHolderSimulated"};
		{if (_x getVariable ["brpvp_zombie_loot_time",-1] > -1) exitWith {_weaponHolder = _x;};} forEach nearestObjects [ASLToAGL _asl,["GroundWeaponHolder","WeaponHolderSimulated"],7];
		if (isNull _weaponHolder) then {
			_atl = ASLToATL _asl;
			_weaponHolder = createVehicle [_class,_atl,[],0,"CAN_COLLIDE"];
			_weaponHolder setPosATL _atl;
			BRPVP_zombieLootWH pushBack _weaponHolder;
		};
		_weaponHolder setVariable ["brpvp_zombie_loot_time",time,true];
	};
};
BRPVP_zedsHitSoundsLast = 0;
BRPVP_zedsHitSounds = +BRPVP_zedsHitSoundsCfg;
BRPVP_zedsHitSoundsCycleNow = 0;
BRPVP_zombieHDEH = {
	params ["_zombie","_part","_damage","_attacker","_projectile","_hitIndex","_instigator","_hitPoint"];
	if (isNull (_zombie getVariable ["klr",objNull])) then {
		_tickTime = diag_tickTime;
		if (_tickTime-(_zombie getVariable ["brpvp_lastHitTime",0]) > 0.02) then {
			_zombie setVariable ["brpvp_lastHitTime",_tickTime];
		
			//CALC VARS
			_attacker = if (isNull _instigator) then {effectiveCommander _attacker} else {_instigator};
			_isBot = !(_attacker call BRPVP_isPlayer) && _attacker isKindOf "CaManBase";
			_explosivePercentage = getNumber (configFile >> "CfgAmmo" >> _projectile >> "explosive");
			_isMobius = _zombie getVariable ["brpvp_mobius",false];
			_zombie setVariable ["brpvp_hit_main_info",[_attacker,_isBot,_explosivePercentage,_isMobius]];

			if (!isNull _attacker && _projectile != "") then {
				//ATTACKED ZOMBIE JUMP
				if (!(_zombie getVariable "jpg") && !_isMobius && (!_isBot || (_isBot && _zombie getVariable ["brpvp_fightAI",true]))) then {
					_d = _zombie distance2D _attacker;
					_dist = _zombie distance _attacker;
					_canJump1 = objectParent _attacker isKindOf "LandVehicle" && _dist > 15 && random 1 < 0.35;
					_canJump2 = _zombie getVariable "knl" && isNull objectParent _attacker && _dist > 30 && random 1 < BRPVP_percentageOfJumpWhenHit;
					if ((_canJump1 || _canJump2) && _attacker call BRPVP_zombieCanSee) then {
						_zombie setVariable ["jpg",true,true];
						[_zombie,_attacker,if (_dist > 95) then {2} else {0},_d/2,_d] remoteExecCall ["BRPVP_zombieJump",_zombie];
					};
				};

				//MOBIUS PUSH BACK
				if (_isMobius && {getPos _zombie select 2 < 0.05}) then {
					private _pz = getPosWorld _zombie;
					private _pa = getPosWorld _attacker;
					_pz set [2,0];
					_pa set [2,0];
					private _vec = vectorNormalized (_pz vectorDiff _pa) vectorMultiply 10;
					private _lp = getPosASL _zombie vectorAdd [0,0,0.5];
					private _lis = lineIntersectsSurfaces [_lp,_lp vectorAdd _vec,_zombie,objNull];
					private _dist = 10;
					if !(_lis isEqualTo []) then {_dist = vectorMagnitude (_lp vectorDiff (_lis select 0 select 0));};
					_dist = _dist-3;
					if (_dist > 0) then {
						_zombie disableAI "MOVE";
						[_zombie,_vec,_dist] spawn {
							params ["_zombie","_vec","_dist"];
							[_zombie,_vec vectorAdd [0,0,_dist/2]] remoteExecCall ["setVelocity",0];
							uiSleep (4*(_dist/2)/9.8);
							_zombie enableAI "MOVE";
						};
					};
					[_zombie,["mobius_damage",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
				};
			};

			//ZED HIT SOUND
			if (time-BRPVP_zedsHitSoundsLast > BRPVP_zedsHitSoundsCycleNow) then {
				BRPVP_zedsHitSoundsLast = time;
				BRPVP_zedsHitSoundsCycleNow = BRPVP_zedsHitSoundsCycleMin+random BRPVP_zedsHitSoundsCycleRandom;
				private _hsChance = [0.5,0.75] select (_damage > 4);
				if (random 1 < _hsChance) then {
					private _hitSound = if (_isMobius) then {selectRandom ["zed_hit_11","zed_hit_13","zed_hit_14","zed_hit_16","zed_hit_17","zed_hit_18"]} else {if (BRPVP_zedsHitSounds isEqualTo []) then {BRPVP_zedsHitSounds = +BRPVP_zedsHitSoundsCfg;selectRandom BRPVP_zedsHitSounds} else {selectRandom BRPVP_zedsHitSounds};};
					[_zombie,[_hitSound,500]] remoteExecCall ["say3D",0];
					BRPVP_zedsHitSounds deleteAt (BRPVP_zedsHitSounds find _hitSound);
				};
			};
		};
		(_zombie getVariable "brpvp_hit_main_info") params ["_attacker","_isBot","_explosivePercentage","_isMobius"];
		if (!isNull _attacker) then {
			if (_projectile isEqualTo "") then {
				if (_part isEqualTo "" && {!isNull objectParent _attacker}) then {
					private _newDam = (_zombie getVariable "brpvp_impact_damage")+_damage;
					_zombie setVariable ["brpvp_impact_damage",_newDam];
					if (_newDam > 0.5) then {
						if (random 1 < BRPVP_zombiesCaughByCarChanceToExplode && !_isMobius) then {["M_Titan_AP",_zombie modelToWorld [0,0,0],100] call BRPVP_trowBomb;};
						[_zombie,_attacker,_projectile,_isMobius,false,true,false] call BRPVP_zedDeath;
					};
				};
			} else {
				if (_hitPoint in ["hithead","hitchest","hitabdomen"]) then {
					private _ifz = _zombie getVariable "ifz";
					private _maxRes = _ifz*BRPVP_zombiesResistence;
					private _isHead = _hitPoint isEqualTo "hithead";
					private _dDam = (_damage-(_zombie getHitPointDamage _hitPoint)) max 0;
					private _dDam = _dDam*(1-_explosivePercentage)+_dDam*_explosivePercentage/BRPVP_zombiesExplosionDamageAttenuation;
					private _aDam = _zombie getVariable "dmg";
					private _newDam = if (_explosivePercentage > 0.5) then {_aDam+_dDam} else {if (_isHead && _explosivePercentage isEqualTo 0 && _dDam > 1) then {if (_isMobius) then {_aDam+7.5*_dDam} else {_maxRes}} else {if (_isMobius) then {_aDam+_dDam} else {_aDam+(_dDam max (0.35*BRPVP_zombiesResistence))}};};
					_zombie setVariable ["dmg",_newDam];
					if (_newDam >= _maxRes) then {[_zombie,_attacker,_projectile,_isMobius,false,true,_isHead] call BRPVP_zedDeath;};
				};
			};
		};
	};
	if (_part in ["body","spine1","spine2","spine3"]) then {0.8} else {if (_part in ["face_hub","neck","head","arms","hands"]) then {0.9} else {0};};
};
BRPVP_zedDeath = {
	params ["_zombie","_attacker","_projectile","_isMobius",["_simpleDel",false],["_loot",true],["_isHead",false]];

	//SIMPLE DEL
	private _aIsPlayer = _attacker call BRPVP_isPlayer;
	if (_simpleDel) exitWith {
		_zombie setVariable ["klr",_attacker];
		_zombie setVariable ["brpvp_zdel",true];
		private _addReward = _zombie getVariable ["brpvp_add_reward",-1];
		if (_addReward > -1 && _aIsPlayer) then {_addReward remoteExecCall ["BRPVP_fortDefendAddReward",2];};
		if (_isMobius) then {{if (typeOf _x isEqualTo "Land_GasTank_01_khaki_F") then {detach _x;deleteVehicle _x;};} forEach attachedObjects _zombie;};
	};

	//DEATH SOUND
	_zombie setVariable ["klr",_attacker];
	
	private _nearPlayers = ((((_zombie nearEntities [BRPVP_playerModel,250])+(BRPVP_playerVehicles select {_x distanceSqr _zombie < 62500})) apply {_x getVariable ["brpvp_machine_id",-1]})+([[],BRPVP_specOnMeMachinesNoMe] select _aIsPlayer))-[-1];
	_nearPlayers = _nearPlayers arrayIntersect _nearPlayers;
	if (_isHead) then {[_zombie,["zed_death",400]] remoteExecCall ["say3D",_nearPlayers];} else {[_zombie,[selectRandom ["zed_death_normal_1","zed_death_normal_2","zed_death_normal_3"],400]] remoteExecCall ["say3D",_nearPlayers];};

	_zombie setUnconscious true;
	if (_loot) then {
		if !(_zombie getVariable ["brpvp_forceDirect",false]) then {
			if (_isMobius) then {
				 [getPosASL _zombie,position _zombie,_projectile,_attacker,BRPVP_mobiusZombiesAmmoRepeat] spawn {
					uiSleep 0.75;
					_this call BRPVP_addZombieLoot;
				 };
			} else {
				[getPosASL _zombie,position _zombie,_projectile,_attacker,2] call BRPVP_addZombieLoot;
			};
		};
	};

	private _addReward = _zombie getVariable ["brpvp_add_reward",-1];
	if (_addReward > -1 && _aIsPlayer) then {_addReward remoteExecCall ["BRPVP_fortDefendAddReward",2];};
	if (_isMobius) then {
		["Sh_105mm_HEAT_MP",_zombie modelToWorld [0,0,0],200] call BRPVP_trowBomb;
		{if (typeOf _x isEqualTo "Land_GasTank_01_khaki_F") then {detach _x;deleteVehicle _x;};} forEach attachedObjects _zombie;
	};
};
if (isNil "BRPVP_tudoA3") then {call compile preprocessFileLineNumbers "tradersVehicles.sqf";};

//SORT BY PRICE
BRPVP_tudoA3 = BRPVP_tudoA3 apply {[if (_x select 0 isEqualTo "FEDIDEX") then {0} else {1},_x select 5,_x]};
BRPVP_tudoA3 sort true;
BRPVP_tudoA3 = BRPVP_tudoA3 apply {_x select 2};

{if !((_x select 3) call BRPVP_classExists) then {BRPVP_tudoA3 set [_forEachIndex,-1];};} forEach BRPVP_tudoA3;
BRPVP_tudoA3 = BRPVP_tudoA3-[-1];
for "_i" from 0 to (count BRPVP_tudoA3-1) do {(BRPVP_tudoA3 select _i) set [4,getText (configFile >> "CfgVehicles" >> (BRPVP_tudoA3 select _i select 3) >> "displayName")];};
{if ((_x select 3) in BRPVP_deniedVehiclesBlackTrader) then {_x set [0,"DENIED"];};} forEach BRPVP_tudoA3;
{_x set [5,(_x select 5)*(BRPVP_marketPricesMultiplyVeh select 0)+(BRPVP_marketPricesMultiplyVeh select 1)];} forEach BRPVP_tudoA3;
BRPVP_showTutorial = {
	waitUntil {!isNull findDisplay 46};
	_handleKeyboard = (findDisplay 46) displayAddEventHandler ["KeyDown",{BRPVP_tutorialPress = BRPVP_tutorialPress + 1;}];
	_handleMouse = (findDisplay 46) displayAddEventHandler ["MouseButtonDown",{BRPVP_tutorialPress = BRPVP_tutorialPress + 1;}];
	BRPVP_tutorialPress = 0;
	_id = 79866;
	findDisplay 46 ctrlCreate ["RscPictureKeepAspect",_id];
	(findDisplay 46 displayCtrl _id) ctrlSetPosition [safezoneX,safezoneY,safezoneW,safezoneH];
	(findDisplay 46 displayCtrl _id) ctrlSetText "BRP_imagens\interface\tutorial_page1.paa";
	(findDisplay 46 displayCtrl _id) ctrlCommit 0;
	_init = -10;
	waitUntil {
		if (getOxygenRemaining player < 0.4) then {player setOxygenRemaining 1;};
		if (time - _init > 2) then {_init = time;cutText ["","BLACK FADED",10];};
		BRPVP_tutorialPress > 0 || !(player call BRPVP_pAlive) || BRPVP_menuExtraLigado
	};
	if (BRPVP_tutorialPress > 0) then {
		(findDisplay 46 displayCtrl _id) ctrlSetText "BRP_imagens\interface\tutorial_page2.paa";
		(findDisplay 46 displayCtrl _id) ctrlCommit 0;
		_init = -10;
		waitUntil {
			if (getOxygenRemaining player < 0.4) then {player setOxygenRemaining 1;};
			if (time - _init > 2) then {_init = time;cutText ["","BLACK FADED",10];};
			BRPVP_tutorialPress > 1 || !(player call BRPVP_pAlive) || BRPVP_menuExtraLigado
		};	
	};
	if (_this) then {cutText ["","BLACK FADED",10];} else {cutText ["","PLAIN",1];};
	(findDisplay 46) displayRemoveEventHandler ["KeyDown",_handleKeyboard];
	(findDisplay 46) displayRemoveEventHandler ["MouseButtonDown",_handleMouse];
	ctrlDelete (findDisplay 46 displayCtrl _id);
};
BRPVP_experienciaZerada = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
BRPVP_playerVehicles = [];
BRPVP_playerVehiclesVehicles = [];

BRPVP_qjsAdicClassObjeto = {
	params ["_receptor","_val",["_hand_or_bank","mny"],["_snd",""],["_wait",0]];
	_receptor setVariable [_hand_or_bank,(_receptor getVariable [_hand_or_bank,0])+_val,true];
	if (hasInterface) then {call BRPVP_atualizaDebug;};
	if (_snd isNotEqualTo "") then {
		if (_wait > 0) then {uiSleep _wait;};
		_snd call BRPVP_playSound;
	};
};
BRPVP_qjsValorDoPlayer = {_this getVariable ["mny",0]};
BRPVP_transferUnitCargo = {
	params ["_from","_cargo",["_token",-2],["_wait",[-1,0]],["_check",{true}],["_onlyMinorItems",false]];
	private ["_wh"];
	_waitChance = _wait select 0;
	_waitTime = (_wait select 1)/6;

	//GET UNIT GEAR INFO
	_weaponItems = weaponsItems _from;
	_mags = magazinesAmmo _from;
	_itemsAssigned = assignedItems _from;
	_uniform = uniform _from;

	//GROUND HOLDER
	_wh = objNull;
	_createHolder = {
		_wh = createVehicle ["GroundWeaponHolder",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
		_wh setVariable ["tuc",_token,true];
	};

	//TRANSFER WEAPONS WITH WEAPON ITEMS AND WEAPON MAGS
	_magsW = [];
	_itemsW = [];
	if (!_onlyMinorItems) then {
		_ac = count _weaponItems;
		if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
		if !(call _check) exitWith {};
		{
			if !((_x select 0) in BRPVP_binocularToIgnoreAsWeapon) then {
				//WEAPON
				_from removeWeaponGlobal (_x select 0);
				_from removeItem (_x select 0);
				_baseWeapon = (_x select 0) call BIS_fnc_baseWeapon;
				_isBP = _baseWeapon in BRPVP_defaultBipodWeapons;
				if (_cargo canAdd [_baseWeapon,2]) then {
					_cargo addWeaponCargoGlobal [_baseWeapon,1];
				} else {
					if (isNull _wh) then {call _createHolder;};
					_wh addWeaponCargoGlobal [_baseWeapon,1];
				};
				
				//GET ITEMS AND MAGS
				{
					if (_forEachIndex > 0) then {
						if (_x isEqualType [] && {count _x > 0}) then {_magsW pushBack _x;};
						if (_x isEqualType "" && {_x != "" && {_forEachIndex != 6 || (_forEachIndex isEqualTo 6 && !_isBP)}}) then {_itemsW pushBack _x;};
					};
				} forEach _x;
			};
			sleep 0.001;
		} forEach _weaponItems;
	};
	_items = items _from;

	//TRANSFER WEAPONS MAGS
	{
		_class = _x select 0;
		_count = _x select 1;
		_from removeMagazineGlobal _class;
		if (_cargo canAdd [_class,2]) then {
			_cargo addMagazineAmmoCargo [_class,1,_count];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addMagazineAmmoCargo [_class,1,_count];
		};
		sleep 0.001;
	} forEach _magsW;

	//TRANSFER WEAPONS ITEMS
	{
		_from removeItem _x;
		if (_cargo canAdd [_x,2]) then {
			_cargo addItemCargoGlobal [_x,1];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addItemCargoGlobal [_x,1];
		};
		sleep 0.001;
	} forEach _itemsW;

	//TRANSFER UNIT MAGS
	_ac = count _mags;
	if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
	if !(call _check) exitWith {};
	{
		_class = _x select 0;
		_count = _x select 1;
		_from removeMagazineGlobal _class;
		if (_cargo canAdd [_class,2]) then {
			_cargo addMagazineAmmoCargo [_class,1,_count];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addMagazineAmmoCargo [_class,1,_count];
		};
		sleep 0.001;
	} forEach _mags;

	//TRANSFER UNIT ASSIGNED ITEMS
	if (!_onlyMinorItems) then {
		_ac = count _itemsAssigned;
		if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
		if !(call _check) exitWith {};
		{
			if (_x in BRPVP_binocularToIgnoreAsWeapon) then {
				_from removeWeapon _x;
			} else {
				_from unlinkItem _x;
			};
			if (_cargo canAdd [_x,2]) then {
				_cargo addItemCargoGlobal [_x,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addItemCargoGlobal [_x,1];
			};
			sleep 0.001;
		} forEach _itemsAssigned;
	};
	
	//TRANSFER UNIT ITEMS
	_ac = count _items;
	if (random 1 < _waitChance && _ac > 0) then {sleep _waitTime;};
	if !(call _check) exitWith {};
	{
		_from removeItem _x;
		if (_cargo canAdd [_x,2]) then {
			_cargo addItemCargoGlobal [_x,1];
		} else {
			if (isNull _wh) then {call _createHolder;};
			_wh addItemCargoGlobal [_x,1];
		};
		sleep 0.001;
	} forEach _items;

	//TRANSFER CONTAINERS
	if (!_onlyMinorItems) then {
		_v = vest _from;
		if (random 1 < _waitChance && _v != "") then {sleep _waitTime;};
		if !(call _check) exitWith {};
		if (_v != "") then {
			if (_cargo canAdd [_v,2]) then {
				_cargo addItemCargoGlobal [_v,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addItemCargoGlobal [_v,1];
			};
			removeVest _from;
		};
		sleep 0.001;
		
		_b = backpack _from;
		if (random 1 < _waitChance && _b != "") then {sleep _waitTime;};
		if !(call _check) exitWith {};
		_contBegin = everyContainer _cargo;
		if (!isNull _wh) then {_contBegin append everyContainer _wh};
		if (_b != "") then {
			if (_cargo canAdd [_b,2]) then {
				_cargo addBackpackCargoGlobal [_b,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addBackpackCargoGlobal [_b,1];
			};
			removeBackpackGlobal _from;
		};
		sleep 0.001;
		
		_contEnd = everyContainer _cargo;
		if (!isNull _wh) then {_contEnd append everyContainer _wh};
		{
			_c = _x select 1;
			clearWeaponCargoGlobal _c;
			clearMagazineCargoGlobal _c;
			clearItemCargoGlobal _c;
			clearBackpackCargoGlobal _c;
			sleep 0.001;
		} forEach (_contEnd - _contBegin);
		sleep 0.001;

		//TRANSFER UNIFORM
		if (surfaceIsWater getPosWorld _from && _from call BRPVP_isPlayer && _uniform isEqualTo "U_O_Wetsuit") then {
			removeUniform _from;
			if (_cargo canAdd [_uniform,2]) then {
				_cargo addItemCargoGlobal [_uniform,1];
			} else {
				if (isNull _wh) then {call _createHolder;};
				_wh addItemCargoGlobal [_uniform,1];
			};
		};
	};

	//SET CARGO TO SAVE
	if (_cargo getVariable ["id_bd",-1] > -1) then {if !(_cargo getVariable ["slv",false]) then {_cargo setVariable ["slv",true,true];};};
};
LOL_fnc_selectRandomIdx = {
	private _idx = floor random count _this;
	[_this select _idx,_idx] 
};
LOL_fnc_selectRandomFator = {
	params ["_array","_factor"];
	_array select floor ((random ((count _array)^(1/_factor)))^_factor)
};
LOL_fnc_selectRandomFactorIdx = {
	params ["_array","_factor"];
	private _idc = floor ((random ((count _array)^(1/_factor)))^_factor);
	[_array select _idc,_idc]
};
LOL_fnc_selectRandomFactorIdxOnly = {
	params ["_array","_factor"];
	floor ((random ((count _array)^(1/_factor)))^_factor)
};
BRPVP_adicCargo = {
	params ["_cargo","_class"];
	private ["_idc"];
	_idc = (_cargo select 0) find _class;
	if (_idc isEqualTo -1) then {
		(_cargo select 0) pushBack _class;
		(_cargo select 1) pushBack 1;
	} else {
		(_cargo select 1) set [_idc,(_cargo select 1 select _idc)+1];
	};
	_cargo
};
BRPVP_addLootHelperItem = {
	params ["_p","_i"];
	private _bpc = backpackContainer _p;
	if (!isNull _bpc && {_bpc canAdd _i}) then {
		_bpc addItemCargoGlobal [_i,1];
	} else {
		private _vc = vestContainer _p;
		if (!isNull _vc && {_vc canAdd _i}) then {
			_vc addItemCargoGlobal [_i,1];
		} else {
			private _uc = uniformContainer _p;
			if (!isNull _uc && {_uc canAdd _i}) then {_uc addItemCargoGlobal [_i,1];} else {_failedItems pushBack _i;};
		};
	};
};
BRPVP_addLootHelperMag = {
	params ["_p","_i"];
	private _bpc = backpackContainer _p;
	if (!isNull _bpc && {_bpc canAdd _i}) then {
		_bpc addMagazineCargoGlobal [_i,1];
	} else {
		private _vc = vestContainer _p;
		if (!isNull _vc && {_vc canAdd _i}) then {
			_vc addMagazineCargoGlobal [_i,1];
		} else {
			private _uc = uniformContainer _p;
			if (!isNull _uc && {_uc canAdd _i}) then {_uc addMagazineCargoGlobal [_i,1];} else {_failedItems pushBack _i;};
		};
	};
};
BRPVP_addLoot = {
	params ["_holder","_itemsAll",["_failHolder",objNull]];
	private _failedItems = [];
	if (_holder isEqualTo player) then {
		//GET BAGS
		private _bags = [];
		{
			if (_x isEqualType "") then {
				private _isBag1 = isClass (configFile >> "CfgVehicles" >> _x);
				private _isBag2 = _x isKindOf ["Vest_Camo_Base",configFile >> "CfgWeapons"];
				private _isBag3 = _x isKindOf ["Vest_NoCamo_Base",configFile >> "CfgWeapons"];
				private _isBag4 = _x isKindOf ["Uniform_Base",configFile >> "CfgWeapons"];
				if (_isBag1 || _isBag2 || _isBag3 || _isBag4) then {
					_bags pushBack _x;
					_itemsAll set [_forEachIndex,-1];
				};
			};
		} forEach _itemsAll;
		
		//GET MAGS
		private _mags = [];
		{
			if (_x isEqualType "") then {
				if (isClass (configFile >> "CfgMagazines" >> _x)) then {
					_mags pushBack _x;
					_itemsAll set [_forEachIndex,-1];
				};
			};
		} forEach _itemsAll;
		
		//PUT BAGS AND MAGS FIRST
		_itemsAll = _itemsAll-[-1];
		_itemsAll = _bags+_mags+_itemsAll;

		{
			private _q = 1;
			private _idc = if (_x isEqualType []) then {
				_q = _x select 1;
				BRPVP_specialItems find (_x select 0)
			} else {
				BRPVP_specialItems find _x
			};
			if (_idc > -1) then {
				[_idc,_q] call BRPVP_sitAddItem;
			} else {
				if (isClass (configFile >> "CfgVehicles" >> _x)) then {
					if (backPack player isEqualTo "") then {player addBackpack _x;} else {_failedItems pushBack _x;};
				} else {
					if (isClass (configFile >> "CfgWeapons" >> _x)) then {
						//HELMETS
						private _isHelm1 = _x isKindOf ["HelmetBase",configFile >> "CfgWeapons"];
						private _isHelm2 = _x isKindOf ["H_HelmetB",configFile >> "CfgWeapons"];
						if (_isHelm1 || _isHelm2) then {
							if (headGear player isEqualTo "") then {player addHeadGear _x;} else {[player,_x] call BRPVP_addLootHelperItem;};
						} else {
							//NV GOGGLES
							private _isNVG = _x isKindOf ["NVGoggles",configFile >> "CfgWeapons"];
							if (_isNVG) then {
								if (hmd player isEqualTo "") then {player linkItem _x;} else {[player,_x] call BRPVP_addLootHelperItem;};
							} else {
								//UNIFORMS
								if (_x isKindOf ["Uniform_Base",configFile >> "CfgWeapons"]) then {
									if (uniform player isEqualTo "") then {player addUniform _x;} else {[player,_x] call BRPVP_addLootHelperItem;};
								} else {
									//VESTS
									private _isVest1 = _x isKindOf ["Vest_Camo_Base",configFile >> "CfgWeapons"];
									private _isVest2 = _x isKindOf ["Vest_NoCamo_Base",configFile >> "CfgWeapons"];
									if (_isVest1 || _isVest2) then {
										if (vest player isEqualTo "") then {player addVest _x;} else {[player,_x] call BRPVP_addLootHelperItem;};
									} else {
										//BINOCULAR
										//NVG ARE ALSO BINOCULAR
										private _isBino = _x iskindOf ["Binocular",configFile >> "CfgWeapons"];
										if (_isBino) then {
											if (binocular player isEqualTo "") then {player addWeapon _x;} else {[player,_x] call BRPVP_addLootHelperItem;};
										} else {
											//WEAPONS
											private _type = getNumber (configFile >> "CfgWeapons" >> _x >> "Type");
											if (_type in [1,2,4]) then {
												private _weapClass = if (_type isEqualTo 1) then {
													primaryWeapon player
												} else {
													if (_type isEqualTo 2) then {handGunWeapon player} else {secondaryWeapon player};
												};
												if (_weapClass isEqualTo "") then {
													player addWeapon _x;
												} else {
													private _bpc = backpackContainer player;
													if (!isNull _bpc && {_bpc canAdd _x}) then {
														_bpc addWeaponCargoGlobal [_x,1];
													} else {
														private _vc = vestContainer player;
														if (!isNull _vc && {_vc canAdd _x}) then {_vc addWeaponCargoGlobal [_x,1];} else {_failedItems pushBack _x;};
													};
												};
											} else {
												//ITEM SLOTS (NOT GPS SLOT)
												if (_x in ["ItemCompass","ItemMap","ItemWatch","ItemRadio"]) then {
													if !(_x in assignedItems player) then {player linkItem _x;} else {[player,_x] call BRPVP_addLootHelperItem;};
												} else {
													//GPS SLOT
													private _isGPSSlot1 = _x iskindOf ["UavTerminal_base",configFile >> "CfgWeapons"];
													private _isGPSSlot2 = _x isEqualTo "ItemGPS";
													if (_isGPSSlot1 || _isGPSSlot2) then {
														private _slotIsUsed = false;
														{
															if (_x isEqualTo "ItemGPS" || _x iskindOf ["UavTerminal_base",configFile >> "CfgWeapons"]) exitWith {
																_slotIsUsed = true;
															};
														} forEach assignedItems player;
														if (_slotIsUsed) then {[player,_x] call BRPVP_addLootHelperItem;} else {player linkItem _x;};
													} else {
														//OTHER
														[player,_x] call BRPVP_addLootHelperItem;
													};
												};
											};											
										};
									};
								};
							};
						};
					} else {
						if (isClass (configFile >> "CfgMagazines" >> _x)) then {
							[player,_x] call BRPVP_addLootHelperMag;
						} else {
							if (isClass (configFile >> "CfgGlasses" >> _x)) then {
								if (goggles player isEqualTo "") then {player addGoggles _x;} else {[player,_x] call BRPVP_addLootHelperItem;};
							};
						};
					};
				};
			};
		} forEach _itemsAll;
		_holder = _failHolder;
		_itemsAll = _failedItems;
	};
	if (!isNull _holder) then {
		private _hItems = _holder getVariable ["brpvp_alt_i_items",[]];
		{
			private _q = 1;
			private _idc = if (_x isEqualType []) then {
				_q = _x select 1;
				BRPVP_specialItems find (_x select 0)
			} else {
				BRPVP_specialItems find _x
			};
			if (_idc > -1) then {
				private _i = -1;
				{if (_x select 0 isEqualTo _idc) exitWith {_i = _forEachIndex;};} forEach _hItems;
				if (_i isEqualTo -1) then {_hItems pushBack [_idc,_q];} else {(_hItems select _i) set [1,(_hItems select _i select 1)+_q];};
			} else {
				if (isClass (configFile >> "CfgMagazines" >> _x)) then {
					_holder addMagazineCargoGlobal [_x,1];
				} else {
					if (isClass (configFile >> "CfgWeapons" >> _x)) then {
						private _type = getNumber (configFile >> "CfgWeapons" >> _x >> "Type");
						if (_type in [1,2,4]) then {_holder addWeaponCargoGlobal [_x,1];} else {_holder addItemCargoGlobal [_x,1];};
					} else {
						if (isClass (configFile >> "CfgVehicles" >> _x)) then {
							_holder addBackpackCargoGlobal [_x,1];
						} else {
							if (isClass (configFile >> "CfgGlasses" >> _x)) then {_holder addItemCargoGlobal [_x,1];};
						};
					};
				};
			};
		} forEach _itemsAll;
		if !(_holder getVariable ["brpvp_alt_i_items",[]] isEqualTo _hITems) then {_holder setVariable ["brpvp_alt_i_items",_hItems,true];};
	};
	if (count _itemsAll isEqualTo 0 && !isNull _failHolder) then {deleteVehicle _failHolder;};
	(count _failedItems > 0)
};
BRPVP_pegaSegsBBChao = {
	_bb = boundingBoxReal _this;
	_p1 = _bb select 0;
	_p2 = _bb select 1;
	_p1x = _p1 select 0;
	_p2x = _p2 select 0;
	_p1y = _p1 select 1;
	_p2y = _p2 select 1;
	_segs = [
		//FLOOR
		[[_p1x,_p1y,0],[_p2x,_p1y,0]],
		[[_p2x,_p1y,0],[_p2x,_p2y,0]],
		[[_p2x,_p2y,0],[_p1x,_p2y,0]],
		[[_p1x,_p2y,0],[_p1x,_p1y,0]]
	];
	_segs
};
BRPVP_emVoltaBB = {
	params ["_obj","_extra"];
	_segs = _obj call BRPVP_pegaSegsBBChao;
	_seg = _segs call BIS_fnc_selectRandom;
	_p1 = _seg select 0;
	_p2 = _seg select 1;
	_p3 = _p1 vectorAdd ((_p2 vectorDiff _p1) vectorMultiply random 1);
	_p3 set [2,0];
	_dist = _p3 distance [0,0,0];
	_mult = (_dist + _extra)/_dist;
	_p4 = _p3 vectorMultiply _mult;
	_retorno = _obj modelToWorld _p4;
	_retorno set [2,0];
	_retorno
};
BRPVP_achaCentroPrincipal = {
	params [
		"_objetos",				//LISTA DE OBJETOS QUE PODEM SER CENTRO PRINCIPAL
		"_tipoPertoClass",		//ARRAY DE CLASSES QUE DEVEM SER VERIFICADOS NAS REDONDEZAS DO CENTRO PRINCIPAL
		"_tipoPertoModel",		//ARRAY COM SUBSTRING DO NOME DOS MODELOS A SEREM PROCURADOS NAS REDONDEZAS
		"_tipoPertoRaio",		//RAIO DA REDONDEZA
		"_polaridade",			//PARA QUANTO MAIS MELHOR USE 1, PARA QUANTO MENOS MELHOR USE -1
		"_insiste",				//NUMERO DE INSISTENCIA EM OBJETOS MELHOR POSICIONADOS
		["_ruasSeNada",true],	//CONTA RUAS NAS REDONDEZAS SE NADA DEFINIDO PARA CONTAR
		["_ladoAmigo",""],		//LADO AMIGO para dar preferencia a proximidade
		["_ladoInimigo",""]		//LADO INIMIGO para dar preferencia a nao-proximidade
	];
	private ["_ladoContar","_pos","_codContaLado","_codContaModel","_codContaClass","_objDaVez","_qtPerto","_codConta","_objDaVezTenta","_qtTop","_distTop","_qtPerto","_distSoma","_qtPertoCod","_distSomaCod"];

	//FUNCOES CONTAR
	_codContaClass = {
		{
			_qtPerto = _qtPerto + count (_objDaVezTenta nearObjects [_x,_tipoPertoRaio]);
		} forEach _tipoPertoClass;
	};
	_codContaModel = {
		{
			private ["_txt"];
			_txt = str _x;
			{
				if (_txt find _x >= 0) exitWith {
					_qtPerto = _qtPerto + 1;
				};
			} forEach _tipoPertoModel;
		} forEach nearestTerrainObjects [_objDaVezTenta,[],_tipoPertoRaio,true];
	};
	_codContaLado = {
		{
			private ["_lado","_lider","_dist"];
			_lado = side _x;
			if (_lado isEqualTo _ladoContar) then {
				_lider = leader _x;
				_dist = _pos distance2D _lider;
				_distSoma = _distSoma + (_dist/100)^2;
			};
		} forEach allGroups;
	};
	
	//CONTAGEM DE AMIGOS INIMIGOS
	if (typeName _ladoAmigo != "STRING") then {
		private ["_qa"];
		_qa = {(side _x) isEqualTo _ladoAmigo} count allGroups;
		if (_qa > 0) then {
			_distTop = 1000000;
			_ladoContar = _ladoAmigo;
			_distSomaCod = {_distSoma < _distTop};	
		} else {
			if (typeName _ladoInimigo != "STRING") then {
				private ["_qi"];
				_qi = {(side _x) isEqualTo _ladoInimigo} count allGroups;
				if (_qi > 0) then {
					_distTop = 0;
					_ladoContar = _ladoInimigo;
					_distSomaCod = {_distSoma > _distTop};
				} else {
					_codContaLado = {};
					_distSomaCod = {true};
				};
			} else {
				_codContaLado = {};
				_distSomaCod = {true};
			};
		};
	} else {
		if (typeName _ladoInimigo != "STRING") then {
			private ["_qi"];
			_qi = {(side _x) isEqualTo _ladoInimigo} count allGroups;
			if (_qi > 0) then {
				_distTop = 0;
				_ladoContar = _ladoInimigo;
				_distSomaCod = {_distSoma > _distTop};
			} else {
				_codContaLado = {};
				_distSomaCod = {true};
			};
		} else {
			_codContaLado = {};
			_distSomaCod = {true};
		};
	};
	
	//FUNCOES CONTAR COMBINADAS
	if (count _tipoPertoClass > 0 && count _tipoPertoModel > 0) then {
		_codConta = {
			call _codContaClass;
			call _codContaModel;
		};
	};
	if (count _tipoPertoClass > 0 && count _tipoPertoModel isEqualTo 0) then {
		_codConta = {call _codContaClass};
	};
	if (count _tipoPertoClass isEqualTo 0 && count _tipoPertoModel > 0) then {
		_codConta = {call _codContaModel;};
	};
	if (count _tipoPertoClass isEqualTo 0 && count _tipoPertoModel isEqualTo 0) then {
		if (_ruasSeNada) then {
			_codConta = {_qtPerto = count ((position _objDaVezTenta) nearRoads _tipoPertoRaio);};
		} else {
			_codConta = {};
		};
	};
	if (_codConta isEqualTo {}) then {
		_qtPertoCod = {true};
	} else {
		if (_polaridade isEqualTo 1) then {
			_qtTop = 0;
			_qtPertoCod = {_qtPerto > _qtTop};
		};
		if (_polaridade isEqualTo -1) then {
			_qtTop = 1000000;
			_qtPertoCod = {_qtPerto < _qtTop};
		};
	};
	
	//PROCURA CENTRO
	_objDaVez = objNull;
	for "_k" from 1 to _insiste do {
		_objDaVezTenta = _objetos call BIS_fnc_selectRandom;
		_qtPerto = 0;
		_distSoma = 0;
		_pos = getPosASL _objDaVezTenta;
		call _codConta;
		call _codContaLado;
		if (call _qtPertoCod) then {
			if (call _distSomaCod) then {
				_qtTop = _qtPerto;
				_distTop = _distSoma;
				_objDaVez = _objDaVezTenta;
			};
		};
	};
	_objDaVez
};
BRPVP_achaLocal = {
	params [
		"_centro",			//1.0 - CENTRO PRIMARIO
		"_resPadrao",		//1.0 - RESULTADO PADRAO CASO NAO ACHE
		"_raioMin",			//2.1 - CENTRO SECUNDARIO: RAIO MINIMO A PARTIR DO CENTRO PRIMARIO
		"_raioMinRand",		//2.1 - CENTRO SECUNDARIO: ADICIONAL RANDOMICO AO RAIO MINIMO (PODE SER 0)
		"_raioMax",			//2.2 - CENTRO SECUNDARIO: RAIO MAXIMO A PARTIR DO CENTRO PRIMARIO
		"_raioMaxRand",		//2.2 - CENTRO SECUNDARIO: ADICIONAL RANDOMICO AO RAIO MAXIMO (PODE SER 0)
		"_stepHor",			//3.0 - MOVIMENTO HORIZONTAL DO CENTRO SECUNDARIO
		"_stepVer",			//3.0 - MOVIMENTO VERTICAL DO CENTRO SECUNDARIO
		"_raioAtrCheck",	//4.0 - RAIO DE CHECK DE ATRIBUTOS (RUA E ELEVACAO) AO REDOR DO CENTRO SECUNDARIO
		"_podeRua",			//4.1 - PERMITIDO RUA NO RAIO _raioAtrCheck? TRUE/FALSE.
		"_stepAtr",			//4.1 - STEP DE CHECK DE RUAS (<= _raioAtrCheck)
		"_maxElev",			//4.2 - MAXIMA ELEVACAO MEDIA PERMITIDA
		"_objClass",		//4.3 - ARRAY DE OBJETOS A SEREM PROCURADOS
		"_objModel",		//4.3 - SUBSTRING DO NOME DO MODELO DO OBJETO A SER PROCURADO
		"_objMaxQt",		//4.3 - QUANTIA MAXIMA DE OBJETOS PERMITIDOS
		"_podeAgua"			//4.4 - PERMITIDO AGUA NO RAIO _raioAtrCheck? TRUE/FALSE.
	];
	private ["_imput","_result","_minDist","_maxDist","_blackList"];
	_origin = if ( _centro isEqualType objNull) then {position _centro} else {_centro};
	_minDist = _raioMin+random _raioMinRand;
	_maxDist = _raioMax+random _raioMaxRand;
	_step = 15;
	_donutsQt = (_maxDist-_minDist)/_step;
	_blackList = [];
	{
		_pos = getPos _x;
		_so = sizeOf typeOf _x;
		_so = _so/1.65;
		_pTL = _pos vectorAdd [-_so,_so,0];
		_pBR = _pos vectorAdd [_so,-_so,0];
		_pTL resize 2;
		_pBR resize 2;
		_blackList pushBack [_pTL,_pBR];
	} forEach nearestObjects [_origin,["LandVehicle","Air","Man","Ship","Building","House"],_maxDist];
	_imput = [
		_origin,
		0,
		0,
		_raioAtrCheck,
		if (_podeAgua) then {1} else {0},
		tan _maxElev,
		0,
		_blackList,
		[_resPadrao,_resPadrao]
	];
	for "_i" from 1 to (ceil _donutsQt) do {
		_imput set [1,_minDist+(_i-1)*_step];
		_imput set [2,if (_i < _donutsQt) then {_minDist+_i*_step} else {_maxDist}];
		_result = _imput call BIS_fnc_findSafePos;
		if !(_result isEqualTo _resPadrao) exitWith {};
	};
	_result
};
BRPVP_pelaUnidade = {
	{_this removeMagazine _x;} forEach  magazines _this;
	{_this removeWeapon _x;} forEach weapons _this;
	{_this removeItem _x;} forEach items _this;
	removeAllAssignedItems _this;
	removeBackpackGlobal _this;
	removeUniform _this;
	removeVest _this;
	removeHeadGear _this;
	removeGoggles _this;
};
BRPVP_getBBMult = {
	params ["_obj","_extraSize"];
	_oBox = boundingBoxReal _obj;
	_p1 = _oBox select 0;
	_p2 = _oBox select 1;
	_p12 = +_p1;
	_p21 = +_p2;
	_p12 set [2,_p2 select 2];
	_p21 set [2,_p1 select 2];
	_pf1 = _p1 vectorAdd ((vectorNormalized (_p1 vectorDiff _p21)) vectorMultiply _extraSize);
	_pf2 = _p2 vectorAdd ((vectorNormalized (_p2 vectorDiff _p12)) vectorMultiply _extraSize);
	[_pf1,_pf2]
};
PDTH_pointIsInBoxHelperArray = ["_pt0","_pt1"];
PDTH_pointIsInBoxHelper = {
	params PDTH_pointIsInBoxHelperArray;
	(_pt0 select 0 <= _pt1 select 0) && (_pt0 select 1 <= _pt1 select 1) && (_pt0 select 2 <= _pt1 select 2)
};
PDTH_pointIsInBoxArray = ["_unit","_obj"];
PDTH_pointIsInBox = {
	params PDTH_pointIsInBoxArray;
	private _posUnit = if (_unit IsEqualType objNull) then {ASLToAGL getPosASL _unit} else {_unit};
	private _uPos = _obj worldToModel _posUnit;
	private _ovb = _obj getVariable ["bbx",[]];
	private _oBox = if (_ovb isEqualTo []) then {boundingBoxReal _obj} else {_ovb};
	([_oBox select 0,_uPos] call PDTH_pointIsInBoxHelper) && ([_uPos,_oBox select 1] call PDTH_pointIsInBoxHelper)
};
PDTH_pointIsInBoxCustomBB = {
	params ["_pos","_obj","_oBox"];
	_pos = _obj worldToModel _pos;
	([_oBox select 0,_pos] call PDTH_pointIsInBoxHelper) && ([_pos,_oBox select 1] call PDTH_pointIsInBoxHelper)
};
PDTH_distance2Box = {
	params ["_unit","_obj"];
	private _oBox = boundingBoxReal _obj;
	private _p0 = _oBox select 0;
	private _p1 = _oBox select 1;
	private _pt = [0,0,0];
	{
		if (_x < _p0 select _forEachIndex) then {
			_pt set [_forEachIndex,(_p0 select _forEachIndex)-_x];
		} else {
			if (_p1 select _forEachIndex < _x) then {_pt set [_forEachIndex,_x-(_p1 select _forEachIndex)];};
		};
	} forEach (_obj worldToModel ASLToAGL getPosWorld _unit);
	vectorMagnitude _pt
};
PDTH_distance2BoxQuad = {
	params ["_unit","_obj"];
	private _uPos = _obj worldToModel (ASLToAGL getPosASL _unit);
	private _oBox = boundingBoxReal _obj;
	private _pt = [0,0,0];
	{
		if (_x < (_oBox select 0 select _forEachIndex)) then {
			_pt set [_forEachIndex,(_oBox select 0 select _forEachIndex)-_x];
		} else {
			if ((_oBox select 1 select _forEachIndex) < _x) then {_pt set [_forEachIndex,_x-(_oBox select 1 select _forEachIndex)];};
		};
	} forEach _uPos;
	_pt distanceSqr [0,0,0]
};
PDTH_distance2BoxPos = {
	params ["_pos","_obj"]; //_pos IN AGL
	private _oBox = boundingBoxReal _obj;
	private _pt = [0,0,0];
	{
		if (_x < (_oBox select 0 select _forEachIndex)) then {
			_pt set [_forEachIndex,(_oBox select 0 select _forEachIndex) - _x];
		} else {
			if ((_oBox select 1 select _forEachIndex) < _x) then {
				_pt set [_forEachIndex,_x - (_oBox select 1 select _forEachIndex)];
			};
		};
	} forEach (_obj worldToModel _pos);
	_pt distance [0,0,0]
};
BRPVP_IsMotorized = {
	if (_this isEqualType "") exitWith {
		private _cfgV = configFile >> "CfgVehicles";
		_this isKindOf ["LandVehicle",_cfgV] || _this isKindOf ["Air",_cfgV] || _this isKindOf ["Ship",_cfgV]
	};
	_this isKindOf "LandVehicle" || _this isKindOf "Air" || _this isKindOf "Ship"
};
BRPVP_IsMotorizedNoTurret = {
	if (_this isEqualType "") exitWith {
		private _cfgV = configFile >> "CfgVehicles";
		(_this isKindOf ["LandVehicle",_cfgV] && !(_this isKindOf ["StaticWeapon",_cfgV])) || {_this isKindOf ["Air",_cfgV] || {_this isKindOf ["Ship",_cfgV]}}
	};
	(_this isKindOf "LandVehicle" && !(_this isKindOf "StaticWeapon")) || {_this isKindOf "Air" || {_this isKindOf "Ship"}}
};
BRPVP_isBuilding = {
	private ["_typeOf"];
	if (_this isEqualType "") then {
		_typeOf = _this;
		_cfgV = configFile >> "CfgVehicles";
		_typeOf isKindOf ["Building",_cfgV]
	} else {
		_this isKindOf "Building"
	};
};
BRPVP_fillUnitWeapons = {
	params ["_unidade",["_qttWeps",[4,4,4]]];
	_mags = magazines _unidade;
	{
		_wep = _x;
		_qtt = _qttWeps select _forEachIndex;
		if (_wep != "") then {
			_magsWep = 0;
			_magsCfg = getArray (configFile >> "CfgWeapons" >> _wep >> "magazines");
			{
				if (_x in _magsCfg) then {_magsWep = _magsWep + 1;};
			} forEach _mags;
			if (_magsWep < _qtt) then {
				_mag = _magsCfg call BIS_fnc_selectRandom;
				for "_m" from 1 to (_qtt - _magsWep) do {
					if (_unidade canAdd _mag) then {
						_unidade addMagazine _mag;
					};
				};
			};
		};
	} forEach [primaryWeapon _unidade,secondaryWeapon _unidade,handGunWeapon _unidade];
};
//KK FUNCTION MODIFIED
BRPVP_floatToString = {
	if (_this < 0) then {
		str ceil _this + (str ((round ((_this - ceil _this)*1000))/1000) select [2])
	} else {
		str floor _this + (str ((round ((_this - floor _this)*1000))/1000) select [1])
	};
};
KK_fnc_positionToString = {
	format [
		"[%1,%2,%3]",
		_this select 0 call BRPVP_floatToString,
		_this select 1 call BRPVP_floatToString,
		_this select 2 call BRPVP_floatToString
	]
};

//==============================================
// BRPVP ATOMIC BOMB BEGIN
//==============================================
BRPVP_nabs = 0.6;
BRPVP_pabs = 0.6;
BRPVP_aabps = 0.9; //EXTRA CHANGE
BRPVP_aasc = 0.5; //EXTRA CHANGE
BRPVP_aarc = 1.75;
BRPVP_setParticleParamsPride = {
	params ["_source","_class","_change"];
	private _aw = wind vectorMultiply 1;

	//HEAD BOMBA ATOMICA
	if (_change isEqualTo "ba_head") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			35, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,60*BRPVP_pabs*BRPVP_aasc] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			0.01675*BRPVP_aarc, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[80*BRPVP_pabs*BRPVP_aabps,110*BRPVP_pabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				[0.4,0.4,0.4,0.250],
				[0.4,0.4,0.4,0.500],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.500],
				[0.4,0.4,0.4,0.300],
				[0.4,0.4,0.4,0.000]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.5,[0.2,0.2,0.2],[0.1,0.1,0.1],20,1,[0,0,0,0],0.2,0.05,360,0]
		_source setParticleRandom [
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[0,0,0], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0.2, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//CAULE BOMBA ATOMICA
	if (_change isEqualTo "ba_caule") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			21, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,50*BRPVP_pabs*BRPVP_aasc] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			0.01*BRPVP_aarc, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[60*BRPVP_pabs*BRPVP_aabps,90*BRPVP_pabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				[0.4,0.4,0.4,0.200],
				[0.4,0.4,0.4,0.500],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.650],
				[0.4,0.4,0.4,0.450],				
				[0.4,0.4,0.4,0.300],
				[0.4,0.4,0.4,0.005]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.5,[0.2,0.2,0.2],[0.1,0.1,0.1],20,1,[0,0,0,0],0.2,0.05,360,0]
		_source setParticleRandom [
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[0,0,0], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0.25, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//CHAO BOMBA
	if (_change isEqualTo "ba_floor") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			17, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity") vectorAdd _aw,
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[45*BRPVP_pabs*BRPVP_aabps,60*BRPVP_pabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				[0.4,0.4,0.4,0.050],
				[0.4,0.4,0.4,0.350],
				[0.4,0.4,0.4,0.500],
				[0.4,0.4,0.4,0.500],
				[0.4,0.4,0.4,0.500],
				[0.4,0.4,0.4,0.500],
				[0.4,0.4,0.4,0.450],
				[0.4,0.4,0.4,0.350],
				[0.4,0.4,0.4,0.250],
				[0.4,0.4,0.4,0.010]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [2,[3,1,3],[7,0.5,7],20,0.3,[0,0,0,0.3],0.2,0.05,360,0]
		_source setParticleRandom [
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//DUST BOMBA ATOMICA
	if (_change isEqualTo "ba_dust") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			2, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity") vectorAdd _aw,
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[45*BRPVP_pabs*BRPVP_aabps,60*BRPVP_pabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				[0.4,0.4,0.4,0.05],
				[0.4,0.4,0.4,0.35],
				[0.4,0.4,0.4,0.34],
				[0.4,0.4,0.4,0.32],
				[0.4,0.4,0.4,0.30],
				[0.4,0.4,0.4,0.30],
				[0.4,0.4,0.4,0.30],
				[0.4,0.4,0.4,0.20],
				[0.4,0.4,0.4,0.10],
				[0.4,0.4,0.4,0.00]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			true //onSurface
		];

		//ORIGINAL [5,[5,1,5],[5,1,5],20,0.3,[0,0,0,0],0,0,0,0]
		_source setParticleRandom [
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//PRIMEIRA EXPLOSAO
	if (_change isEqualTo "ba_explo1") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,0] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[(250/10)*BRPVP_pabs,250*BRPVP_pabs], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.3,[5,6,5],[2,2,2],25,0.4,[0,0,0,0.3],0.2,0.05,1,0]
		_source setParticleRandom [
			0.1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			[1,1,1,0.3], //getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//SEGUNDA EXPLOSAO
	if (_change isEqualTo "ba_explo2") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,0] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[(75/10)*BRPVP_pabs,75*BRPVP_pabs], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.3,[5,6,5],[2,2,2],25,0.4,[0,0,0,0.3],0.2,0.05,1,0]
		_source setParticleRandom [
			0.1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			[1,1,1,0.3], //getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//TERCEIRA EXPLOSAO
	if (_change isEqualTo "ba_explo3") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,0] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[(45/10)*BRPVP_pabs,45*BRPVP_pabs], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.3,[5,6,5],[2,2,2],25,0.4,[0,0,0,0.3],0.2,0.05,1,0]
		_source setParticleRandom [
			0.1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			[1,1,1,0.3], //getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};
};
BRPVP_setParticleParams = {
	params ["_source","_class","_change"];
	private _aw = wind vectorMultiply 1;

	//HEAD BOMBA ATOMICA
	if (_change isEqualTo "ba_head") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			35, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,60*BRPVP_nabs*BRPVP_aasc] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			0.0185*BRPVP_aarc, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[70*BRPVP_nabs*BRPVP_aabps,90*BRPVP_nabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				(([139/255,069/255,019/255] vectorMultiply 0.800) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.200))+[0.250],
				(([139/255,069/255,019/255] vectorMultiply 0.500) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.500))+[0.500],
				(([139/255,069/255,019/255] vectorMultiply 0.300) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.700))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.200) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.800))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.150) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.850))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.100) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.900))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.050) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.950))+[0.750],
				[0.5,0.5,0.5,0.750],
				[0.5,0.5,0.5,0.750],
				[0.5,0.5,0.5,0.750],
				[0.5,0.5,0.5,0.600],
				[0.6,0.6,0.6,0.400],
				[0.8,0.8,0.8,0.000]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.5,[0.2,0.2,0.2],[0.1,0.1,0.1],20,1,[0,0,0,0],0.2,0.05,360,0]
		_source setParticleRandom [
			0,//getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			[0,0,0],//getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[0,0,0], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//CAULE BOMBA ATOMICA
	if (_change isEqualTo "ba_caule") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			20, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,40*BRPVP_nabs*BRPVP_aasc] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			0.01*BRPVP_aarc, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[50*BRPVP_nabs*BRPVP_aabps,70*BRPVP_nabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				(([139/255,069/255,019/255] vectorMultiply 0.800) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.200))+[0.200],
				(([139/255,069/255,019/255] vectorMultiply 0.500) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.500))+[0.500],
				(([139/255,069/255,019/255] vectorMultiply 0.300) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.700))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.200) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.800))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.150) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.850))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.100) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.900))+[0.750],
				(([139/255,069/255,019/255] vectorMultiply 0.050) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.950))+[0.750],
				[0.5,0.5,0.5,0.750],
				[0.6,0.6,0.6,0.400],
				[0.8,0.8,0.8,0.005]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.5,[0.2,0.2,0.2],[0.1,0.1,0.1],20,1,[0,0,0,0],0.2,0.05,360,0]
		_source setParticleRandom [
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[0,0,0], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0.25, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//CHAO BOMBA
	if (_change isEqualTo "ba_floor") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			20, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity") vectorAdd _aw,
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[45*BRPVP_nabs*BRPVP_aabps,60*BRPVP_nabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				(([139/255,069/255,019/255] vectorMultiply 0.800) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.200))+[0.050],
				(([139/255,069/255,019/255] vectorMultiply 0.500) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.500))+[0.350],
				(([139/255,069/255,019/255] vectorMultiply 0.350) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.650))+[0.500],
				(([139/255,069/255,019/255] vectorMultiply 0.350) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.650))+[0.500],
				(([139/255,069/255,019/255] vectorMultiply 0.350) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.650))+[0.500],
				(([139/255,069/255,019/255] vectorMultiply 0.350) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.650))+[0.500],
				(([139/255,069/255,019/255] vectorMultiply 0.350) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.650))+[0.450],
				(([139/255,069/255,019/255] vectorMultiply 0.300) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.700))+[0.350],
				(([139/255,069/255,019/255] vectorMultiply 0.200) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.800))+[0.250],
				(([139/255,069/255,019/255] vectorMultiply 0.000) vectorAdd ([0.5,0.5,0.5] vectorMultiply 1.000))+[0.010]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [2,[3,1,3],[7,0.5,7],20,0.3,[0,0,0,0.3],0.2,0.05,360,0]
		_source setParticleRandom [
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			[0,0,0,0.15], //getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//DUST BOMBA ATOMICA
	if (_change isEqualTo "ba_dust") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			2, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity") vectorAdd _aw,
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[45*BRPVP_nabs*BRPVP_aabps,60*BRPVP_nabs*BRPVP_aabps], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				[0.08,0.067,0.052,0.05],
				[0.60,0.500,0.400,0.35],
				[0.60,0.500,0.400,0.34],
				[0.60,0.500,0.400,0.32],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.20],
				[0.55,0.500,0.450,0.10],
				[0.50,0.500,0.500,0.00]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			true //onSurface
		];

		//ORIGINAL [5,[5,1,5],[5,1,5],20,0.3,[0,0,0,0],0,0,0,0]
		_source setParticleRandom [
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//PRIMEIRA EXPLOSAO
	if (_change isEqualTo "ba_explo1") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,0] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[(250/10)*BRPVP_nabs,250*BRPVP_nabs], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.3,[5,6,5],[2,2,2],25,0.4,[0,0,0,0.3],0.2,0.05,1,0]
		_source setParticleRandom [
			0.1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//SEGUNDA EXPLOSAO
	if (_change isEqualTo "ba_explo2") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,0] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[(75/10)*BRPVP_nabs,75*BRPVP_nabs], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.3,[5,6,5],[2,2,2],25,0.4,[0,0,0,0.3],0.2,0.05,1,0]
		_source setParticleRandom [
			0.1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//TERCEIRA EXPLOSAO
	if (_change isEqualTo "ba_explo3") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,0] vectorAdd _aw, //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[(45/10)*BRPVP_nabs,45*BRPVP_nabs], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.3,[5,6,5],[2,2,2],25,0.4,[0,0,0,0.3],0.2,0.05,1,0]
		_source setParticleRandom [
			0.1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};
};
BRPVP_createAnimatedParticle = {
	params ["_class","_type","_useClass","_pos","_change","_tickIni","_tickEnd","_radIni","_radEnd","_velocityIni","_velocityEnd","_pTime","_curve"];
	private _source = "#particlesource" createVehicleLocal _pos;
	if (_useClass) then {_source setParticleClass _class;};
	if (_type isEqualTo "normal") then {[_source,_class,_change] call BRPVP_setParticleParams;} else {[_source,_class,_change] call BRPVP_setParticleParamsPride;};
	_source setParticleCircle [_radIni,_velocityIni];
	_source setDropInterval _tickIni;
	[_source,_tickIni,_tickEnd,_radIni,_radEnd,_velocityIni,_velocityEnd,_pTime,_curve] spawn {
		params ["_source","_tickIni","_tickEnd","_radIni","_radEnd","_velocityIni","_velocityEnd","_pTime","_curve"];
		private _init = diag_tickTime;
		private _deltaRad = _radEnd-_radIni;
		private _deltaTick = _tickEnd-_tickIni;
		private _deltaVelocity = _velocityEnd vectorDiff _velocityIni;
		waitUntil {
			private _delta = diag_tickTime-_init;
			private _perc = (_delta/_pTime)^_curve;
			private _radNow = _radIni+_perc*_deltaRad;
			private _tickNow = _tickIni+_perc*_deltaTick;
			private _velocityNow = _velocityIni vectorAdd (_deltaVelocity vectorMultiply _perc);
			_source setParticleCircle [_radNow,_velocityNow];
			_source setDropInterval _tickNow;
			_delta > _pTime
		};
		deleteVehicle _source;
	};
};
BRPVP_lightBlock = {
	params ["_helper","_posASL","_posCam","_vecToBomb","_rad","_radSteps","_density"];
	private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
	private _lim = vectorMagnitude _vecToBomb;
	private _radStep = _rad/_radSteps;
	private _vUp = vectorNormalized ((_vecToBomb vectorCrossProduct [0,0,1]) vectorCrossProduct _vecToBomb);
	private _totalPts = 0;
	private _totalDist = 0;
	_helper setPosASL (_posCam vectorAdd _vecToBomb);
	_helper setVectorDirAndUp [vectorNormalized _vecToBomb,_vUp];
	for "_r" from 0 to _rad step _radStep do {
		private _peri = 2*pi*_r+0.01;
		private _pts = ceil (_peri*_density);
		private _aStep = (360/_pts)+0.01;
		for "_a" from 0 to 360 step _aStep do {
			_vPos = _helper modelToWorldWorld [_r*sin _a,0,_r*cos _a];
			private _lis = lineIntersectsSurfaces [_posCam,_vPos,player];
			if (_lis isEqualTo []) then {
				_totalDist = _totalDist+_lim;
			} else {
				private _cDist = vectorMagnitude ((_lis select 0 select 0) vectorDiff _posCam);
				if (_dist < _lim && {_cDist > _dist}) then {_cDist = _lim;};
				_totalDist = _totalDist+_cDist;
			};
			_totalPts = _totalPts+1;
		};
	};
	if (_totalPts == 0) then {diag_log str ["AAAAAAAAAAAAAA_01 _totalPts: ",_totalPts];};
	_totalDist/(_totalPts max 1)
};
BRPVP_blastBlock = {
	params ["_helper","_player","_posASL","_pos","_vecToBomb","_rad","_radSteps","_density"];
	private _dist = vectorMagnitude (_posASL vectorDiff _pos);
	private _lim = vectorMagnitude _vecToBomb;
	private _radStep = _rad/_radSteps;
	private _vUp = vectorNormalized ((_vecToBomb vectorCrossProduct [0,0,1]) vectorCrossProduct _vecToBomb);
	private _totalPts = 0;
	private _totalDist = 0;
	_helper setPosASL (_pos vectorAdd _vecToBomb);
	_helper setVectorDirAndUp [vectorNormalized _vecToBomb,_vUp];
	for "_r" from 0 to (_rad+0.1) step _radStep do {
		private _peri = 2*pi*_r+0.01;
		private _pts = ceil (_peri*_density);
		private _aStep = 360/_pts;
		for "_a" from 0 to (360+0.1) step _aStep do {
			_vPos = _helper modelToWorldWorld [_r*sin _a,0,_r*cos _a];
			private _lis = lineIntersectsSurfaces [_pos,_vPos,_player,objNull,true,1,"GEOM","NONE"];
			if (_lis isEqualTo [] || {isNull (_lis select 0 select 2)}) then {
				_totalDist = _totalDist+_lim;
			} else {
				private _cDist = vectorMagnitude ((_lis select 0 select 0) vectorDiff _pos);
				if (_dist < _lim && {_cDist > _dist}) then {_cDist = _lim;};
				_totalDist = _totalDist+_cDist;
			};
			_totalPts = _totalPts+1;
		};
	};
	_totalDist/_totalPts
};
BRPVP_atomicBombUnitDieFlames = {
	if (positionCameraToWorld [0,0,0] distance (_this select 0) < 3000) then {
		params ["_player","_param"];
		private _emitter = "#particlesource" createVehicleLocal [0,0,0];
		_emitter attachTo [_player,[0,0,0]];
		_emitter setParticleClass "ATMineExplosionParticles";
		_emitter setDropInterval 0.03;
		private _smoke = "#particlesource" createVehicleLocal [0,0,0];
		_smoke attachTo [_player,[0,0,0]];
		_smoke setParticleClass "ATCloudSmallLight";
		_smoke setDropInterval 0.025;
		_player say3D _param;
		[_emitter,_smoke] spawn {
			params ["_emitter","_smoke"];
			uiSleep 0.15;
			detach _emitter;
			deleteVehicle _emitter;
			uiSleep 0.25;
			detach _smoke;
			deleteVehicle _smoke;
		};
	};
};
BRPVP_atomicBombUnitDieFlamesFast = {
	if (positionCameraToWorld [0,0,0] distance (_this select 0) < 3000) then {
		params ["_unit","_param",["_hideAtEnd",false]];
		private _emitter = "#particlesource" createVehicleLocal [0,0,0];
		private _rand = 1+random 0.5;
		_emitter attachTo [_unit,[0,0,0]];
		_emitter setParticleClass "ATMineExplosionParticles";
		_emitter setDropInterval (0.025*_rand);
		_unit say3D _param;
		[_unit,_emitter,_hideAtEnd,_rand] spawn {
			params ["_unit","_emitter","_hideAtEnd","_rand"];
			uiSleep (0.1*_rand);
			detach _emitter;
			deleteVehicle _emitter;
			if (_hideAtEnd) then {_unit hideObject true;};
		};
	};
};
BRPVP_lightHurtEyes = {
	if (_perc >= _lightHurtEyesMinPerc) then {
		_lightHurtEyesAcumulated = _lightHurtEyesAcumulated+1/diag_fps;
		if (_lightHurtEyesAcumulated > _lightHurtBlindTime) then {
			if !(player getVariable "god" || player getVariable "brpvp_god_admin" || player getVariable "brpvp_extra_protection") then {
				if !(player getVariable ["brpvp_blind",false]) then {
					player setVariable ["brpvp_blind",true,true];
					(player getVariable "id_bd") remoteExecCall ["BRPVP_blindPlayersIdAdd",2];
					BRPVP_atomicBombInitBlind = true;
					0 spawn {
						uiSleep 0.25;
						[player,["blind",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
					};
				};
			};
		};
	} else {
		_lightHurtEyesAcumulated = (_lightHurtEyesAcumulated-1/diag_fps) max 0;
	};
};
BRPVP_lightHurtBody = {
	if (_percBodyHurt >= _lightHurtBodyMinPerc) then {
		_lightHurtBodyAcumulated = _lightHurtBodyAcumulated+1/diag_fps;
		if (_lightHurtBodyAcumulated > _lightHurtDeadTime) then {
			if (player call BRPVP_pAlive && !BRPVP_atomicBombPlayerIsDeadBy) then {
				BRPVP_atomicBombPlayerIsDeadBy = true;
				if !(player getVariable "god" || player getVariable "brpvp_god_admin" || player getVariable "brpvp_extra_protection") then {
					private _playerBomb = ((call BRPVP_playersList select {_x getVariable ["id_bd",-1] isEqualTo _playerId})+[_player]) select 0;
					player setVariable ["brpvp_atomic_bomb_death",true];
					player setVariable ["brpvp_atomic_bomb_death_sound",true];
					[_playerBomb,"Atomic_Bomb_Light_F"] call BRPVP_pehKilledFakeHandleDamage;
					[player,["flame",300]] remoteExecCall ["BRPVP_atomicBombUnitDieFlames",BRPVP_allNoServer];
				};
			} else {
				if (player getVariable ["dd",-1] isEqualTo 0) then {BRPVP_disabledDamage = BRPVP_disabledDamage+(1/8)/diag_fps;};
			};
		};
	} else {
		_lightHurtBodyAcumulated = (_lightHurtBodyAcumulated-1/diag_fps) max 0;
	};
};
BRPVP_lightHurtFrySound = {
	if (_perc >= _lightHurtEyesMinPerc || _percBodyHurt >= _lightHurtBodyMinPerc) then {
		if (diag_tickTime-_lightHurtSoundLast >= 0.75) then {
			[player,[_frySoundArrayNow deleteAt 0,350,0.75]] remoteExecCall ["say3D",BRPVP_allNoServer];
			_lightHurtSoundLast = diag_tickTime;
			if (_frySoundArrayNow isEqualTo []) then {_frySoundArrayNow = _frySoundArray call BIS_fnc_arrayShuffle;};
		};
	};
};
BRPVP_lightBlindRunning = 0;
BRPVP_ABombLightMaxIntensity = 50;
BRPVP_lightBlind = {
	if (hasInterface) then {
		params ["_posASL","_limit","_lowLimit","_playerId","_player","_attenuation"];

		private _light = "#lightpoint" createVehicleLocal [0,0,0];
		_light setPosASL _posASL;
		_light setLightColor [1,1,1];
		_light setLightAmbient [1,1,1];
		_light setLightUseFlare false;
		_light setLightIntensity 0;
		_light setLightDayLight true;
		_light setLightAttenuation [_lowLimit,0,200,0];

		private _lightBlindRunningIdx = -1;
		BRPVP_lightBlindRunning = BRPVP_lightBlindRunning+1;
		if (BRPVP_lightBlindRunning isEqualTo 1) then {
			BRPVP_lightBlindRunningIdx = 0;
			_lightBlindRunningIdx = BRPVP_lightBlindRunningIdx;
			BRPVP_atomicBombInitBlind = false;
			BRPVP_atomicBombPlayerIsDeadBy = false;

			BRPVP_lightBlindCamPerc = [0];
			BRPVP_lightBlindPlayerPerc = [0];
			BRPVP_lightBlindBodyPlayerPerc = [0];
			BRPVP_ABombLightObjs = [[_light,0,_limit,_lowLimit,_attenuation]];

			call BRPVP_calcFullLights;
		} else {
			BRPVP_lightBlindRunningIdx = BRPVP_lightBlindRunningIdx+1;
			_lightBlindRunningIdx = BRPVP_lightBlindRunningIdx;
			BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,0];
			BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,0];
			BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,0];
			BRPVP_ABombLightObjs set [_lightBlindRunningIdx,[_light,0,_limit,_lowLimit,_attenuation]];
		};

		private _realLimit = if (_limit-_lowLimit == 0) then {_limit} else {_limit-_lowLimit};
		private _density = 1.5;
		private _helper = createSimpleObject ["Land_Matches_F",[0,0,0],true];
		_helper hideObject true;

		uiSleep 0.5;
		
		//LIGHT BLAST
		private _eTime = 0.75;
		private _init = diag_tickTime;
		if (alive player) then {
			waitUntil {
				private _posCam = AGLToASL positionCameraToWorld [0,0,0];
				private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
				private _realDist = (_dist-_lowLimit) max 0;
				private _viewVec = AGLToASL positionCameraToWorld [0,0,1] vectorDiff _posCam;
				private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;

				private _distPerc = (1-(_realDist min _realLimit)/_realLimit)^3;
				private _anglePerc = (1-acos (_viewVec vectorCos _vecToBomb)/180)^3;
				private _timePerc = (((diag_tickTime-_init)/_eTime) min 1)^(1/1.5);
				//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density] call BRPVP_lightBlock)/25);
				private _blockPerc = 1;

				private _perc = _timePerc*_blockPerc*(_distPerc+_anglePerc)/2;
				BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,_perc];
				(BRPVP_ABombLightObjs select _lightBlindRunningIdx) set [1,_timePerc];
				if (ASLToAGL _posCam distance player < 100) then {
					private _percBodyHurt = sqrt(_timePerc*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				} else {
					private _player = [BRPVP_spectedPlayer,player] select isNull BRPVP_spectedPlayer;
					private _posCam = eyePos _player;
					private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;
					private _distPerc = (1-((vectorMagnitude (_posASL vectorDiff _posCam)-_lowLimit) max 0 min _realLimit)/_realLimit)^3;
					private _anglePerc = (1-acos (eyeDirection _player vectorCos _vecToBomb)/180)^3;
					private _timePerc = (((diag_tickTime-_init)/_eTime) min 1)^(1/1.5);
					//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density/2] call BRPVP_lightBlock)/25);
					private _blockPerc = 1;

					private _perc = _timePerc*_blockPerc*(_distPerc+_anglePerc)/2;
					private _percBodyHurt = sqrt(_timePerc*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				};

				_timePerc >= 1 || !alive player
			};
		};

		//MANTAIN ON EXPLOSION 1
		if (alive player) then {
			_eTime = 1.5;
			_init = diag_tickTime;
			waitUntil {
				private _posCam = AGLToASL positionCameraToWorld [0,0,0];
				private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
				private _realDist = (_dist-_lowLimit) max 0;
				private _viewVec = AGLToASL positionCameraToWorld [0,0,1] vectorDiff _posCam;
				private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;

				private _distPerc = (1-(_realDist min _realLimit)/_realLimit)^3;
				private _anglePerc = (1-acos (_viewVec vectorCos _vecToBomb)/180)^3;
				private _timePerc = ((diag_tickTime-_init)/_eTime) min 1;
				//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density] call BRPVP_lightBlock)/25);
				private _blockPerc = 1;

				private _perc = (1-_timePerc*0)*_blockPerc*(_distPerc+_anglePerc)/2;
				BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,_perc];
				(BRPVP_ABombLightObjs select _lightBlindRunningIdx) set [1,1-_timePerc*0];
				if (ASLToAGL _posCam distance player < 100) then {
					private _percBodyHurt = sqrt((1-_timePerc*0)*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				} else {
					private _player = [BRPVP_spectedPlayer,player] select isNull BRPVP_spectedPlayer;
					private _posCam = eyePos _player;
					private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;
					private _distPerc = (1-((vectorMagnitude (_posASL vectorDiff _posCam)-_lowLimit) max 0 min _realLimit)/_realLimit)^3;
					private _anglePerc = (1-acos (eyeDirection _player vectorCos _vecToBomb)/180)^3;
					private _timePerc = ((diag_tickTime-_init)/_eTime) min 1;
					//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density/2] call BRPVP_lightBlock)/25);
					private _blockPerc = 1;

					private _perc = (1-_timePerc*0)*_blockPerc*(_distPerc+_anglePerc)/2;
					private _percBodyHurt = sqrt((1-_timePerc*0)*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				};

				_timePerc >= 1 || !alive player
			};
		};

		//EXPLOSION 1 ENDING
		if (alive player) then {
			_eTime = 0.5;
			_init = diag_tickTime;
			waitUntil {
				private _posCam = AGLToASL positionCameraToWorld [0,0,0];
				private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
				private _realDist = (_dist-_lowLimit) max 0;
				private _viewVec = AGLToASL positionCameraToWorld [0,0,1] vectorDiff _posCam;
				private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;

				private _distPerc = (1-(_realDist min _realLimit)/_realLimit)^3;
				private _anglePerc = (1-acos (_viewVec vectorCos _vecToBomb)/180)^3;
				private _timePerc = ((diag_tickTime-_init)/_eTime) min 1;
				//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density] call BRPVP_lightBlock)/25);
				private _blockPerc = 1;

				private _perc = (1-_timePerc*0.4)*_blockPerc*(_distPerc+_anglePerc)/2;
				BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,_perc];
				(BRPVP_ABombLightObjs select _lightBlindRunningIdx) set [1,(1-_timePerc*0.4)];
				if (ASLToAGL _posCam distance player < 100) then {
					private _percBodyHurt = sqrt((1-_timePerc*0.4)*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				} else {
					private _player = [BRPVP_spectedPlayer,player] select isNull BRPVP_spectedPlayer;
					private _posCam = eyePos _player;
					private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;
					private _distPerc = (1-((vectorMagnitude (_posASL vectorDiff _posCam)-_lowLimit) max 0 min _realLimit)/_realLimit)^3;
					private _anglePerc = (1-acos (eyeDirection _player vectorCos _vecToBomb)/180)^3;
					private _timePerc = ((diag_tickTime-_init)/_eTime) min 1;
					//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density/2] call BRPVP_lightBlock)/25);
					private _blockPerc = 1;

					private _perc = (1-_timePerc*0.4)*_blockPerc*(_distPerc+_anglePerc)/2;
					private _percBodyHurt = sqrt((1-_timePerc*0.4)*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				};

				_timePerc >= 1 || !alive player
			};
		};

		//VANISH
		if (alive player) then {
			_eTime = 15;
			_init = diag_tickTime;
			waitUntil {
				private _posCam = AGLToASL positionCameraToWorld [0,0,0];
				private _dist = vectorMagnitude (_posASL vectorDiff _posCam);
				private _realDist = (_dist-_lowLimit) max 0;
				private _viewVec = AGLToASL positionCameraToWorld [0,0,1] vectorDiff _posCam;
				private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;

				private _distPerc = (1-(_realDist min _realLimit)/_realLimit)^3;
				private _anglePerc = (1-acos (_viewVec vectorCos _vecToBomb)/180)^3;
				private _timePerc = sqrt(((diag_tickTime-_init)/_eTime) min 1);
				//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density] call BRPVP_lightBlock)/25);
				private _blockPerc = 1;

				private _perc = (0.6-_timePerc*0.6)*_blockPerc*(_distPerc+_anglePerc)/2;
				BRPVP_lightBlindCamPerc set [_lightBlindRunningIdx,_perc];
				(BRPVP_ABombLightObjs select _lightBlindRunningIdx) set [1,(0.6-_timePerc*0.6)];
				if (ASLToAGL _posCam distance player < 100) then {
					private _percBodyHurt = sqrt((0.6-_timePerc*0.6)*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				} else {
					private _player = [BRPVP_spectedPlayer,player] select isNull BRPVP_spectedPlayer;
					private _posCam = eyePos _player;
					private _vecToBomb = vectorNormalized (_posASL vectorDiff _posCam) vectorMultiply 25;
					private _distPerc = (1-((vectorMagnitude (_posASL vectorDiff _posCam)-_lowLimit) max 0 min _realLimit)/_realLimit)^3;
					private _anglePerc = (1-acos (eyeDirection _player vectorCos _vecToBomb)/180)^3;
					private _timePerc = sqrt(((diag_tickTime-_init)/_eTime) min 1);
					//private _blockPerc = sqrt(([_helper,_posASL,_posCam,_vecToBomb,5,1,_density/2] call BRPVP_lightBlock)/25);
					private _blockPerc = 1;

					private _perc = (0.6-_timePerc*0.6)*_blockPerc*(_distPerc+_anglePerc)/2;
					private _percBodyHurt = sqrt((0.6-_timePerc*0.6)*_distPerc)*sqrt(1*_blockPerc);
					BRPVP_lightBlindPlayerPerc set [_lightBlindRunningIdx,_perc];
					BRPVP_lightBlindBodyPlayerPerc set [_lightBlindRunningIdx,_percBodyHurt];
				};

				_timePerc >= 1 || !alive player
			};
		};

		deleteVehicle _helper;
		deleteVehicle _light;
		BRPVP_lightBlindRunning = BRPVP_lightBlindRunning-1;
	};
};
BRPVP_earthQuake = {
	params ["_posAGL","_obj","_quakeReach","_wind"];
	private _init = diag_tickTime;
	private _soundOk = false;
	private _quakeOk = false;
	waitUntil {
		private _step = _quakeReach/4;
		private _sndDist = _quakeReach*3;
		private _delta = diag_tickTime-_init;
		private _playerDistSound = positionCameraToWorld [0,0,0] distance _posAGL;
		private _playerDistQuake = _playerDistSound-240;
		private _soundRun = 300*_delta;
		if (_soundRun >= _playerDistQuake && !_quakeOk) then {
			private _intensity = 4-floor (_playerDistSound/_step);
			if (_intensity > 0) then {
				if (diag_tickTime-BRPVP_lastScriptedQuakeTime > 5) then {
					BRPVP_lastScriptedQuakeTime = diag_tickTime;
					[_intensity] spawn BIS_fnc_earthquake;
				};
			};
			_quakeOk = true;
		};
		if (_soundRun >= _playerDistSound && !_soundOk) then {
			_obj say3D ["atomic_bomb",_sndDist,1.2];
			_soundOk = true;
			[_posAGL,_quakeReach,_wind] spawn {
				params ["_posAGL","_quakeReach","_wind"];
				private _init = diag_tickTime;
				private _thReach = _quakeReach/3;
				waitUntil {
					private _a = [_posAGL,positionCameraToWorld [0,0,0]] call BIS_fnc_dirTo;
					private _d = (((positionCameraToWorld [0,0,0] distance2D _posAGL)-_thReach) max 0)*1.5;
					private _i = sqrt ((1-_d/_quakeReach) max 0);
					private _tn = 1-((diag_tickTime-_init)/0.25) max 0;
					private _t = sqrt _tn;
					private _p = _i*(1-_t);
					private _m = (_p*_wind) min 20;
					private _grassShakeIntensity = 0.075+_i*(_m/20)*0.925;
					private _s = _grassShakeIntensity*2.5*(1-_tn)*sin (time*(720+(1-_tn)*360));
					private _wc = [(_m+_s)*sin _a,(_m+_s)*cos _a,0];
					private _w = (_wc vectorMultiply (1-_t)) vectorAdd (BRPVP_weatherServerWind vectorMultiply _t);
					setWind ((_w select [0,2])+[true]);
					_t isEqualTo 0
				};
				_init = diag_tickTime;
				waitUntil {
					private _a = [_posAGL,positionCameraToWorld [0,0,0]] call BIS_fnc_dirTo;
					private _d = (((positionCameraToWorld [0,0,0] distance2D _posAGL)-_thReach) max 0)*1.5;
					private _i = sqrt ((1-_d/_quakeReach) max 0);
					private _tn = 1-((diag_tickTime-_init)/8) max 0;
					private _t = sqrt _tn;
					private _p = _i*_t;
					private _m = (_p*_wind) min 20;
					private _grassShakeIntensity = 0.075+_i*(_m/20)*0.925;
					private _s = _grassShakeIntensity*2.5*_tn*sin (time*(720+_tn*360));
					private _wc = [(_m+_s)*sin _a,(_m+_s)*cos _a,0];
					private _w = (_wc vectorMultiply _t) vectorAdd (BRPVP_weatherServerWind vectorMultiply (1-_t));
					setWind ((_w select [0,2])+[true]);
					_t isEqualTo 0
				};
			};
		};
		(_soundOk && _quakeOk) || !alive player
	};
	if (_soundOk) then {
		uiSleep 60;
		deleteVehicle _obj;
	};
};
BRPVP_atomicBombSmokeMult = 0.85;
BRPVP_atomicBombSmokeMultPride = 0.7;
BRPVP_atomicBombCodeAllClients = {
	params ["_posASL","_playerId","_player","_type"];
	private _posAGL = ASLToAGL _posASL;
	private _hObj = createSimpleObject ["Land_Matches_F",_posASL,true];
	_hObj allowDamage false;
	_hObj hideObject true;

	if (_type isEqualTo "normal") then {
		private _smokeMult = BRPVP_atomicBombSmokeMult;

		//EXECUTAR SOM, TREMER E CEGAR A LUZ
		[_posAGL,_hObj,3000,45] spawn BRPVP_earthQuake;
		[_posASL,4000,1000,_playerId,_player,[]] spawn BRPVP_lightBlind;

		//Bomba Particulas
		["HeavyBombExp1",_type,false,_posAGL,"ba_explo1",0.05,0.05,25,25,[0,0,0],[0,0,0],1,1] call BRPVP_createAnimatedParticle;
		["BombDust",_type,true,_posAGL vectorAdd [0,0,7.5],"ba_dust",0.01,0.0025,0,100,[0,0,7.5],[0,0,7.5],0.5,1] call BRPVP_createAnimatedParticle;
		["BombDust",_type,true,_posAGL,"ba_dust",0.0015/_smokeMult,0.001/_smokeMult,0*BRPVP_nabs,500*BRPVP_nabs,[0,0,7.5],[0,0,0],3.5,1/2.5] call BRPVP_createAnimatedParticle;
		["HeavyBombExp1",_type,true,_posAGL,"ba_explo2",0.05,0.05,0,0,[0,0,0],[0,0,0],10,1] call BRPVP_createAnimatedParticle;
		["HeavyBombSmk2",_type,true,_posAGL,"ba_head",0.0175/_smokeMult,0.01/_smokeMult,0,175*BRPVP_nabs,[0,0,0],[0,0,0],7.5,1/3] call BRPVP_createAnimatedParticle;
		[_posAGL,_smokeMult,_type] spawn {
			params ["_posAGL","_smokeMult","_type"];
			uiSleep 4;
			["HeavyBombSmk2",_type,true,_posAGL,"ba_caule",0.05/_smokeMult,0.04/_smokeMult,00*BRPVP_nabs,30*BRPVP_nabs,[0,0,0],[0,0,0],18,1] call BRPVP_createAnimatedParticle;
			["HeavyBombSmk2",_type,true,_posAGL,"ba_caule",0.04/_smokeMult,0.03/_smokeMult,30*BRPVP_nabs,60*BRPVP_nabs,[0,0,0],[0,0,0],18,1] call BRPVP_createAnimatedParticle;
			uiSleep 1;
			["HeavyBombSmk3",_type,true,_posAGL,"ba_floor",0.02/_smokeMult,0.01/_smokeMult,40*BRPVP_nabs,180*BRPVP_nabs,[0,0,5],[0,0,0],5,1] call BRPVP_createAnimatedParticle;
			uiSleep 5;
			["HeavyBombExp1",_type,true,_posAGL,"ba_explo3",0.05,0.05,0,0,[0,0,0],[0,0,0],2,1] call BRPVP_createAnimatedParticle;
		};
	} else {
		private _smokeMult = BRPVP_atomicBombSmokeMultPride;

		//RUN SOUND, SHAKE AND BLIND LIGHT
		[_posAGL,_hObj,4500,60] spawn BRPVP_earthQuake;
		[_posASL,6000,1500,_playerId,_player,[]] spawn BRPVP_lightBlind;

		//BOMB PARTICLES
		["HeavyBombExp1",_type,false,_posAGL,"ba_explo1",0.05,0.05,25,25,[0,0,0],[0,0,0],1,1] call BRPVP_createAnimatedParticle;
		["BombDust",_type,true,_posAGL vectorAdd [0,0,7.5],"ba_dust",0.01,0.0025,0,100,[0,0,7.5],[0,0,7.5],0.5,1] call BRPVP_createAnimatedParticle;
		["BombDust",_type,true,_posAGL,"ba_dust",0.0015/_smokeMult,0.001/_smokeMult,0*BRPVP_pabs,600*BRPVP_pabs,[0,0,7.5],[0,0,0],4,1/2.5] call BRPVP_createAnimatedParticle;
		["HeavyBombExp1",_type,true,_posAGL,"ba_explo2",0.05,0.05,0,0,[0,0,0],[0,0,0],10,1] call BRPVP_createAnimatedParticle;
		["HeavyBombSmk2",_type,true,_posAGL,"ba_head",0.01/_smokeMult,0.0075/_smokeMult,0,225*BRPVP_pabs,[0,0,0],[0,0,0],7.5,1/3] call BRPVP_createAnimatedParticle;
		[_posAGL,_smokeMult,_type] spawn {
			params ["_posAGL","_smokeMult","_type"];
			uiSleep 4;
			["HeavyBombSmk2",_type,true,_posAGL,"ba_caule",0.025/_smokeMult,0.020/_smokeMult,00*BRPVP_pabs,45*BRPVP_pabs,[0,0,0],[0,0,0],18,1] call BRPVP_createAnimatedParticle;
			["HeavyBombSmk2",_type,true,_posAGL,"ba_caule",0.020/_smokeMult,0.015/_smokeMult,45*BRPVP_pabs,90*BRPVP_pabs,[0,0,0],[0,0,0],18,1] call BRPVP_createAnimatedParticle;
			uiSleep 1;
			["HeavyBombSmk3",_type,true,_posAGL,"ba_floor",0.005/_smokeMult,0.0025/_smokeMult,50*BRPVP_pabs,270*BRPVP_pabs,[0,0,5],[0,0,0],5,1] call BRPVP_createAnimatedParticle;
			uiSleep 5;
			["HeavyBombExp1",_type,true,_posAGL,"ba_explo3",0.05,0.05,0,0,[0,0,0],[0,0,0],2,1] call BRPVP_createAnimatedParticle;
		};
	};
};
BRPVP_atomicBombHeavyVehDam	= {
	params ["_obj","_player"];
	{
		private _isWheel = (_x find "wheel") isNotEqualTo -1 && {random 1 < 0.6};
		private _isTrack = (_x find "track") isNotEqualTo -1 && {random 1 < 0.6};
		private _isGlass = (_x find "glass") isNotEqualTo -1;
		private _isFuel = (_x find "fuel") isNotEqualTo -1;
		private _dam = [[0.875,0.8] select _isFuel,1] select (_isWheel || _isTrack || _isGlass);
		_obj setHitIndex [_forEachIndex,_dam,false,_player,_player];
	} forEach (getAllHitPointsDamage _obj select 0);
};
BRPVP_atomicBombHeavyVehDamLow	= {
	params ["_obj","_player"];
	{
		private _isWheel = (_x find "wheel") isNotEqualTo -1 && {random 1 < 0.3};
		private _isTrack = (_x find "track") isNotEqualTo -1 && {random 1 < 0.3};
		private _isGlass = (_x find "glass") isNotEqualTo -1 && {random 1 < 0.6};
		private _isFuel = (_x find "fuel") isNotEqualTo -1;
		private _dam = [[0.4,0.2] select _isFuel,1] select (_isWheel || _isTrack || _isGlass);
		_obj setHitIndex [_forEachIndex,_dam,false,_player,_player];
	} forEach (getAllHitPointsDamage _obj select 0);
};
BRPVP_checkAtomicBombCanDamBuildings = {
	{_this find _x isNotEqualTo -1} count BRPVP_atomicBombNoDestroyBuildings isEqualTo 0
};
BRPVP_atomicBombCodeOneTime = {
	params ["_posASL","_playerId","_player","_bombType"];
	private _posAGL = ASLToAGL _posASL;

	//CREATE "KILLER" FOR CORRECT OBJECTS FALL DIRECTION
	private _hObj = "Land_Matches_F" createVehicle _posAGL;
	_hObj setPosASL _posAGL;
	_hObj enableSimulation false;
	_hObj allowDamage false;
	_hObj hideObjectGlobal true;

	//DESTRUCTION
	private _range = 500;  //FULL DESTRUCTION
	private _rangeSqr = _range^2;
	private _extraRange = 500;
	private _baseDestroy = 100;
	private _baseDestroyMin = 25;
	if (_bombType isNotEqualTo "normal") then {
		_range = 750;
		_rangeSqr = _range^2;
		_extraRange = 750;
		_baseDestroy = 150;
		_baseDestroyMin = 40;
	};
	private _movingVehs = _posAGL nearEntities [["Car","Tank","Ship","Air","Motorcycle"],_range+_extraRange+1000] select {(isEngineOn _x || vectorMagnitude velocity _x > 0.125) && isDamageAllowed _x}; //MOVING VEHICLES
	private _housesMap = nearestTerrainObjects [_posAGL,["HOUSE"],_range,false];

	private _initPerf = diag_tickTime;
	private _objs1 = _posAGL nearEntities [BRPVP_zombieMotherClass,_range+_extraRange]; //ZOMBIES
	private _objs2 = _posAGL nearEntities [BRPVP_playerModel,_range+_extraRange] select {_x getVariable ["sok",false]}; //PLAYERS
	private _objs3 = _posAGL nearEntities ["CaManBase",_range+_extraRange] select {_x getVariable ["brpvp_ai",false] && !(_x getVariable ["brpvp_is_ulfan",false]) && !(_x getVariable ["brpvp_minerva_ai_unit",false])}; //BOTS
	private _objs4 = _posAGL nearEntities [["LandVehicle","Ship","Air","Motorcycle"],_range+_extraRange+250] select {!isEngineOn _x && isDamageAllowed _x}; //VEHICLES
	private _objs5 = nearestTerrainObjects [_posAGL,["WALL","TREE"],_range,false] select {alive _x}; //MAP SMALL OBJECTS
	private _objs6 = _housesMap select {typeOf _x isNotEqualTo "" && {_x getVariable ["brpvp_map_god_mode_house_id",-1] isEqualTo -1 && !isObjectHidden _x && isDamageAllowed _x && typeOf _x call BRPVP_checkAtomicBombCanDamBuildings}}; //MAP HOUSE
	private _objs7 = (nearestObjects [_posAGL,["House","Camping_base_F"],_range]-_housesMap) select {typeOf _x isNotEqualTo "" && {_x getVariable ["id_bd",-1] isEqualTo -1 && _x getVariable ["brpvp_map_god_mode_house_id",-1] isEqualTo -1 && !isObjectHidden _x && isDamageAllowed _x}}; //CREATED HOUSES
	private _objs8 = BRPVP_allFlags select {_x distance _posAGL < _range+_extraRange}; //FLAGS
	diag_log str ["BRPVP Perf 1 Test Destruction Atomic Bomb (ms):",(diag_tickTime-_initPerf)*1000];

	private _objsCount = ["BRPVP Atomic Bomb Destruction",["zed",count _objs1],["player",count _objs2],["bot",count _objs3],["vehicle",count _objs4],["map",count _objs5],["map_house",count _objs6],["house",count _objs7],["flag",count _objs8]];

	_initPerf = diag_tickTime;
	_objs1 = _objs1 apply {[_x distanceSqr _posAGL,_x,"zed"]};
	_objs2 = _objs2 apply {[_x distanceSqr _posAGL,_x,"player"]};
	_objs3 = _objs3 apply {[_x distanceSqr _posAGL,_x,"bot"]};
	_objs4 = _objs4 apply {[_x distanceSqr _posAGL,_x,"vehicle"]};
	_objs5 = _objs5 apply {[_x distanceSqr _posAGL,_x,"map"]};
	_objs6 = _objs6 apply {[_x distanceSqr _posAGL,_x,"map_house"]};
	_objs7 = _objs7 apply {[_x distanceSqr _posAGL,_x,"house"]};
	_objs8 = _objs8 apply {[_x distanceSqr _posAGL,_x,"flag"]};
	diag_log str ["BRPVP Perf 2 Test Destruction Atomic Bomb (ms):",(diag_tickTime-_initPerf)*1000];

	_initPerf = diag_tickTime;
	_objs1 append _objs2;
	_objs1 append _objs3;
	_objs1 append _objs4;
	_objs1 append _objs5;
	_objs1 append _objs6;
	_objs1 append _objs7;
	_objs1 append _objs8;
	_objs1 sort true;
	diag_log str ["BRPVP Perf 3 Test Destruction Atomic Bomb (ms):",(diag_tickTime-_initPerf)*1000];
	[_objs1,_movingVehs,_range,_rangeSqr,_extraRange,_playerId,_player,_posAGL,_posASL,_objsCount,_hObj,_baseDestroy,_baseDestroyMin,_bombType] spawn {
		params ["_objs","_movingVehs","_range","_rangeSqr","_extraRange","_playerId","_player","_posAGL","_posASL","_objsCount","_hObj","_baseDestroy","_baseDestroyMin","_bombType"];
		private _init = diag_tickTime;
		private _speed = 300;
		private _percHouse = 0.95;
		private _percHouseToOne = (1-_percHouse) min _percHouse;
		private _percDust = 0.2;
		private _percDustToOne = (1-_percDust) min _percDust;
		private _wait = 75/_speed;
		private _helper = createSimpleObject ["Land_Matches_F",[0,0,0],true];
		_helper hideObject true;
		waitUntil {
			private _delta = diag_tickTime-_init;
			private _reach = (_speed*_delta) min (_range+_extraRange);
			private _percForce = (1-(_reach/_range)) max 0;
			private _percHouseNow = _percHouse+(_percForce*_percHouseToOne*2-_percHouseToOne);
			private _percDustNow = _percDust+(_percForce*_percDustToOne*2-_percDustToOne);
			private _reachSqr = _reach^2;
			private _deleteCount = 0;
			if (isNull _player && _playerId isNotEqualTo -1) then {_player = (call BRPVP_playersList select {_x getVariable ["id_bd",-1] isEqualTo _playerId}+[_player]) select 0;};
			private _paramsArray = ["_dist","_obj","_type"];
			{
				_x params _paramsArray;
				if (_dist > _reachSqr) exitWith {_deleteCount = _forEachIndex;};
				if (!IsNull _obj && alive _obj) then {
					if (_type isEqualTo "map") exitWith {_obj setDamage [1,false,_hObj];};
					if (_type isEqualTo "map_house") exitWith {
						if (random 1 < _percHouseNow) exitWith {
							[_obj,true] remoteExecCall ["hideObjectGlobal",2];
							_obj allowDamage false;
							if (random 1 > _percDustNow) exitWith {
								private _cfg = configFile >> "CfgVehicles" >> typeOf _obj >> "DestructionEffects" >> "Ruin1" >> "type";
								if (isText _cfg) exitWith {
									private _ruinModel = getText _cfg;
									private _ruin = createSimpleObject [_ruinModel select [1,count _ruinModel-1],getPosASL _obj];
									_ruin setDir (getDir _obj-15+random 30);
								};
								private _crater = createSimpleObject ["a3\data_f\krater.p3d", getPosASL _obj];
								_crater setDir random 360;
								if (sizeOf typeOf _obj < 25) exitWith {_crater setObjectScale (1+random 0.25);};
								_crater setObjectScale (1.35+random 0.15);
							};
							private _small = sizeOf typeOf _obj < 25;
							if (_small || random 1 < 0.5) exitWith {
								private _crater = createSimpleObject ["a3\data_f\krater.p3d", getPosASL _obj];
								_crater setDir random 360;
								if (_small) exitWith {_crater setObjectScale (1+random 0.25);};
								_crater setObjectScale (1.35+random 0.15);
							};
							private _cfg = configFile >> "CfgVehicles" >> typeOf _obj >> "DestructionEffects" >> "Ruin1" >> "type";
							if (isText _cfg) exitWith {
								private _ruinModel = getText _cfg;
								private _ruin = createSimpleObject [_ruinModel select [1,count _ruinModel-1],getPosASL _obj];
								_ruin setDir (getDir _obj-15+random 30);
							};
							private _crater = createSimpleObject ["a3\data_f\krater.p3d", getPosASL _obj];
							_crater setDir random 360;
							if (_small) exitWith {_crater setObjectScale (1+random 0.25);};
							_crater setObjectScale (1.35+random 0.15);
						};
					};
					if (_type isEqualTo "house") exitWith {if (random 1 < _percHouseNow) exitWith {_obj setDamage [1,false,_player,_player];};};
					if (_type isEqualTo "bot") exitWith {
						if (_dist < _rangeSqr) exitWith {
							//if (random 1 < 0.5) exitWith {
							if (random 1 < 1) exitWith {
								[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
								[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
							};
							[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
						};
						if (random 1 < 0.5) exitWith {
							if (random 1 < 0.85) exitWith {
								[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
								[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
							};
							[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
						};
						_obj setDamage 0.875;
					};
					if (_type isEqualTo "vehicle") exitWith {
						private _operator = _obj getVariable ["brpvp_operator",objNull];
						if (isNull _operator) exitWith {
							if (_dist < _rangeSqr) exitWith {
								private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _obj >> "armor");
								if (_armor < 450) exitWith {
									{
										if (_x getVariable ["brpvp_ai",false]) exitWith {[_x,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_x];};

										//DRONE AND DRONE PLAYER CODE
										if (typeOf _x in BRPVP_VantAiUnits) exitWith {};

										[_player,"Atomic_Bomb_F"] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_x];
									} forEach (crew _obj select {!(_x getVariable ["god",false] || _x getVariable ["brpvp_god_admin",false] || _x getVariable ["brpvp_extra_protection",false])});
									_obj setDamage [1,false,_player,_player];
									_obj remoteExec ["BRPVP_explosionDeleteSmoke",0];
								};
								[_obj,_player] remoteExecCall ["BRPVP_atomicBombHeavyVehDam",_obj];
							};
							private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _obj >> "armor");
							if (_armor < 200) then {
								{
									if (_x getVariable ["brpvp_ai",false]) then {
										if (random 1 < 0.75) then {_x setDamage 0.875;};
									} else {
										_x setDamage [0.6 max damage _x,false,_player,_player];
									};
								} forEach crew _obj;
								_obj setDamage [0.5 max damage _obj,false,_player,_player];
							} else {
								[_obj,_player] remoteExecCall ["BRPVP_atomicBombHeavyVehDamLow",_obj];
							};
						};
						if (_dist < _rangeSqr) exitWith {
							if (random 1 < 0.75) exitWith {
								if (random 1 < 0.5) then {[_operator,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];};
								[_operator,false,0.25] remoteExec ["BRPVP_manualTurretDie",2];
							};
						};
						if (random 1 < 0.4) exitWith {
							if (random 1 < 0.5) then {[_operator,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];};
							[_operator,false,0.25] remoteExec ["BRPVP_manualTurretDie",2];
						};
					};
					if (_type isEqualTo "player") exitWith {
						if !(_obj getVariable "god" || _obj getVariable "brpvp_god_admin" || _obj getVariable "brpvp_extra_protection") then {
							if (_dist < _rangeSqr) exitWith {
								_obj setVariable ["brpvp_atomic_bomb_death",true,_obj getVariable "brpvp_machine_id"];
								_obj setVariable ["brpvp_atomic_bomb_death_sound",true,_obj getVariable "brpvp_machine_id"];
								[_player,"Atomic_Bomb_F"] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_obj];
								[_obj,["flame",300]] remoteExecCall ["BRPVP_atomicBombUnitDieFlames",BRPVP_allNoServer];
								remoteExecCall ["BRPVP_atualizaDebug",_obj];
							};
							private _pos = eyePos _obj;
							private _vecToBomb = vectorNormalized (_posASL vectorDiff _pos) vectorMultiply 7.5;
							private _distMult = (1-(sqrt(_dist)-_range)/_extraRange) max 0;
							private _damage = (_distMult*sqrt(([_helper,_obj,_posASL,_pos,_vecToBomb,5,4,0.3] call BRPVP_blastBlock)/7.5)) max 0.2;
							private _inside = insideBuilding _obj;
							private _damage = ((1-_inside)*_damage+_inside*0.1) min (BRPVP_pDamLim*0.85);
							private _dNow = (_obj getHitPointDamage "hithead") max (_obj getHitPointDamage "hitbody") max (damage _obj) max _damage;
							_obj setDamage [_dNow,false,_player,_player];
							remoteExecCall ["BRPVP_atualizaDebug",_obj];
						};
					};
					if (_type isEqualTo "zed") exitWith {
						if (_dist < _rangeSqr) exitWith {
							//if (random 1 < 0.75) exitWith {
							//	[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
							//	[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],true,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
							//};
							[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],false,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
						};
						if (random 1 < 0.5) exitWith {
							if (random 1 < 0.85) exitWith {
								[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
								[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],true,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
							};
							[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],false,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
						};
					};
					if (_type isEqualTo "flag") exitWith {
						private _flag = _obj;
						private _rad = _flag getVariable ["brpvp_flag_radius",0];
						if (_rad > 0) then {
							private _d = sqrt (_dist);
							private _count = [round (_baseDestroyMin+(_baseDestroy-_baseDestroyMin)*(1-(_d-_range)/_extraRange)),_baseDestroy] select (_d <= _range);
							private _bigFloor = [": part_0.p3d",": part_1_a.p3d",": part_1_b.p3d",": part_2.p3d",": part_3_a.p3d",": part_3_b.p3d",": part_4_a.p3d",": part_4_b.p3d"];
							private _radRand = 100;
							private _canBlow = nearestObjects [_flag,[],_rad,true] select {((typeOf _x in BRPVP_kitGroupsCanDestroy && _x getVariable ["id_bd",-1] isNotEqualTo -1) || (typeOf _x isEqualTo "" && {str _x select [str _x find ":",14] in _bigFloor})) && !isObjectHidden _x};
							private _canBlowSort = _canBlow apply {[(_x distance _posAGL)-_radRand/2+random _radRand,_x]};
							private _baseBombDestroyedLines = [[0,0,-1]]+BRPVP_baseBombDestroyedLines;
							_count = round (_count min (0.5*count _canBlow));
							_canBlowSort sort true;
							_canBlowSort = ((_canBlowSort select [0,_count]) select {private _oi = (_x select 1) getVariable ["id_bd",-1];(_baseBombDestroyedLines findIf {_oi isEqualTo (_x select 2)}) < 1}) apply {_x select 1};
							if (!alive _player) then {_player = (call BRPVP_playersList select {_x getVariable ["id_bd",-1] isEqualTo _playerId}+[_player]) select 0;};
							[_canBlowSort,_player,_flag,_bombType,_d] call BRPVP_atomicBombBaseDamage;
						};
					};
				};
			} forEach _objs;
			if (_deleteCount > 0) then {_objs deleteRange [0,_deleteCount];};

			private _deleteVeh = [];
			{
				private _obj = _x;
				private _dist = _obj distanceSqr _posAGL;
				if (_dist < _reachSqr) then {
					_deleteVeh pushBack _x;
					if (_dist < _rangeSqr) exitWith {
						private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _obj >> "armor");
						if (_armor < 450) then {
							{
								if (_x getVariable ["brpvp_ai",false]) then {
									[_x,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_x];
								} else {
									[_player,"Atomic_Bomb_F"] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_x];
								};
							} forEach crew _obj;
							_obj setDamage [1,false,_player,_player];
							_obj remoteExec ["BRPVP_explosionDeleteSmoke",0];
						} else {
							[_obj,_player] remoteExecCall ["BRPVP_atomicBombHeavyVehDam",_obj];
						};
					};
					private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _obj >> "armor");
					if (_armor < 200) then {
						{
							if (_x getVariable ["brpvp_ai",false]) then {
								if (random 1 < 0.75) then {_x setDamage 0.875;};
							} else {
								_x setDamage [0.6 max damage _x,false,_player,_player];
							};
						} forEach crew _obj;
						_obj setDamage [0.5 max damage _obj,false,_player,_player];
					} else {
						[_obj,_player] remoteExecCall ["BRPVP_atomicBombHeavyVehDamLow",_obj];
					};
				};
			} forEach _movingVehs;
			_movingVehs = _movingVehs-_deleteVeh;

			uiSleep _wait;
			_reach isEqualTo (_range+_extraRange)
		};

		diag_log str _objsCount;
		deleteVehicle _helper;
		deleteVehicle _hObj;
		remoteExecCall ["BRPVP_AIRemoveNull",2];
	
		//CREATE RADIATION
		private _key1 = "BA_RADIO_"+str round random 1000000;
		private _key2 = "BA_RADIO_"+str round random 1000000;
		[_posAGL,_range*0.25,_key1,8,0.6,[],0] remoteExecCall ["BRPVP_radioAreasAddArea",0];
		uiSleep 1;
		[_posAGL,_range,_key2,8,0.2,[],0] remoteExecCall ["BRPVP_radioAreasAddArea",0];

		//REMOVE RADIATION
		uiSleep 100;
		_key2 remoteExecCall ["BRPVP_radioAreasRemoveArea",0];
		uiSleep 20;
		_key1 remoteExecCall ["BRPVP_radioAreasRemoveArea",0];
	};
};
BRPVP_atomicBombBaseDamage = {
	params ["_toBlow","_player","_flag","_bombType","_d"];

	//CREATE OBJECTS GROUPS
	private _bFloorPieces = [];
	private _toBlowGrpType = [];
	private _toBlowGrp = [];
	{
		private _class = typeOf _x;
		if (_class isEqualTo "") then {
			private _bfid = _x getVariable ["brpvp_bf_bfid",-1];
			if (_bfid isNotEqualTo -1) then {_bFloorPieces pushBack [_bfid,ASLToAGL getPosWorld _x];};
		} else {
			private _idx = _toBlowGrpType find _class;
			if (_idx isEqualTo -1) then {
				_toBlowGrpType pushBack _class;
				_toBlowGrp pushBack [_x];
			} else {
				(_toBlowGrp select _idx) pushBack _x;
			};
		};
	} forEach _toBlow;

	//FILL HIDE REMOTEEXEC PARAMS
	private _re1 = [[],[],true];
	private _re2 = [[],[],true];
	{
		private _objs = _x;
		private _obj = _objs select 0;
		private _class = _toBlowGrpType select _forEachIndex;
		if (netId _obj isEqualTo "0:0") then {
			if (_class in BRPVP_buildingHaveDoorListCVL) then {
				(_re1 select 0) pushBack _class;
				(_re1 select 1) pushBack (_objs apply {_x getVariable ["id_bd",-1]});
			} else {
				(_re2 select 0) pushBack _class;
				(_re2 select 1) pushBack (_objs apply {_x getVariable ["id_bd",-1]});
			};
		} else {
			//HIDE NORMAL OBJECTS
			_objs call BRPVP_hideObjectGlobalTrue;
		};
	} forEach _toBlowGrp;
	
	//HIDE BIGFLOOR PIECES
	_bFloorPieces remoteExecCall ["BRPVP_hideBigFloorPieces",0];

	//HIDE SPECIAL OBJECTS
	_re1 remoteExecCall ["BRPVP_hideGlobalSimpleObjectCVL",0];
	_re2 remoteExecCall ["BRPVP_hideGlobalSimpleObject",0];

	//DRAW RED LINES
	{[_x,2,[1,0,0,1]] call BRPVP_getCubeDrawCoords remoteExecCall ["BRPVP_baseBombAddLines",0];} forEach _toBlowGrp;

	//SET FLAG TO RAID MODE
	if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
		if !([_player,_flag] call BRPVP_checaAcessoRemotoFlag) then {
			_flag setVariable ["brpvp_last_intrusion",serverTime,true];
			if (BRPVP_useDiscordEmbedBuilder) then {_flag call BRPVP_messageDiscordRaid;};
		};
	};

	//DATABASE STUFF
	{
		{
			private _exec = "_this call BRPVP_serverHideBombedObject;";
			private _vrColors = _x getVariable ["brpvp_vr_colors",[]];
			if (_vrColors isNotEqualTo []) then {_exec = _exec+format ["[_this,'%1','%2'] call BRPVP_vrObjectSetTextures;",_vrColors#0,_vrColors#1];};
			[_x getVariable ["id_bd",-1],_exec] call BRPVP_updateTurretExec;
		} forEach _x;
	} forEach _toBlowGrp;
	private _abTxt = ["Pride Atomic Bomb (%1 items %2 meters)","Atomic Bomb (%1 items %2 meters)"] select (_bombType isEqualTo "normal");
	[_flag getVariable "own",_player getVariable "id_bd",_player getVariable "nm",format [_abTxt,count _toBlow,round _d],getPosWorld _flag] call BRPVP_logBaseInvasion;

	//IMEDIATLY ACTIVATE RED LINES ON NEAR PLAYERS (NOT WAIT FOR LOCAL LOOP)
	private _pShowDraw = _flag nearEntities [BRPVP_playerModel,500];
	if (_pShowDraw isNotEqualTo []) then {remoteExecCall ["BRPVP_baseBombCalcVisibleLines",_pShowDraw];};
};
BRPVP_hideBigFloorPieces = {
	if (!isNil "BRPVP_atomicBombHiddenBigFloors") then {
		BRPVP_atomicBombHiddenBigFloors append _this;
		BRPVP_atomicBombHiddenBigFloors = BRPVP_atomicBombHiddenBigFloors arrayIntersect BRPVP_atomicBombHiddenBigFloors; 
		private _paramsArray = ["_bfid","_pos"];
		{
			_x params _paramsArray;
			private _obj = nearestObject _pos;
			if (_obj getVariable ["brpvp_bf_bfid",-1] isEqualTo _bfid) then {_obj hideObject true;};
		} forEach _this;
	};
};
BRPVP_showBigFloorPiecesMany = {
	if (!isNil "BRPVP_atomicBombHiddenBigFloors") then {
		params ["_objsArray","_wait"];
		BRPVP_atomicBombHiddenBigFloors = BRPVP_atomicBombHiddenBigFloors-_objsArray;
		private _paramsArray = ["_bfid","_pos"];
		{
			_x params _paramsArray;
			private _obj = nearestObject _pos;
			if (_obj getVariable ["brpvp_bf_bfid",-1] isEqualTo _bfid) then {_obj hideObject false;};
			if (1/diag_fps <= _wait) then {uiSleep _wait;} else {if (random 1 < (1/((1/diag_fps)/_wait))) then {uiSleep 0.001;};};
		} forEach _objsArray;
	};
};
BRPVP_showBigFloorPieces = {
	if (!isNil "BRPVP_atomicBombHiddenBigFloors") then {
		params ["_bfid","_pos"];
		BRPVP_atomicBombHiddenBigFloors = BRPVP_atomicBombHiddenBigFloors-[_this];
		private _obj = nearestObject _pos;
		if (_obj getVariable ["brpvp_bf_bfid",-1] isEqualTo _bfid) then {_obj hideObject false;};
	};
};
BRPVP_atomicBomberSimulation = {
	//HELPER OBJECT
	private _hObj = createSimpleObject ["Land_Matches_F",_this,true];
	_hObj allowDamage false;
	_hObj setVariable ["brpvp_machine_id",-1];
	_hObj setVariable ["brpvp_vd",2500];
	_hObj setVariable ["brpvp_ai_simu_dist",2500];
	BRPVP_atomicBombsRunning pushBack _hObj;
	uiSleep 20;
	BRPVP_atomicBombsRunning = BRPVP_atomicBombsRunning-[_hObj];
	deleteVehicle _hObj;
};
BRPVP_hideObjectGlobalTrue = {{_x hideObjectGlobal true;} forEach _this;};
BRPVP_spawnAtomicBomb = {
	params ["_posASL","_player",["_wait",2],["_type","normal"]];
	private _playerId = _player getVariable ["id_bd",-1];
	_posASL remoteExec ["BRPVP_atomicBomberSimulation",2];
	uiSleep _wait;
	[_posASL,_playerId,_player,_type] remoteExecCall ["BRPVP_atomicBombCodeAllClients",BRPVP_allNoServer];
	[_posASL,_playerId,_player,_type] remoteExecCall ["BRPVP_atomicBombCodeOneTime",2];
	uiSleep 3;
	for "_i" from 1 to 4 do {ASLToAGL _posASL remoteExecCall ["BRPVP_createAtomicBombBlueTankItems",2];};
};
BRPVP_spawnAtomicBombCountParticles = {
	params ["_posASL","_player",["_wait",2],["_type","normal"]];
	private _playerId = _player getVariable ["id_bd",-1];

	//DELETE ACTUAL PARTICLES
	{deleteVehicle _x;} forEach (8 allObjects 3);

	//SPAWN BOMB
	_posASL remoteExec ["BRPVP_atomicBomberSimulation",2];
	uiSleep _wait;
	[_posASL,_playerId,_player,_type] remoteExecCall ["BRPVP_atomicBombCodeAllClients",BRPVP_allNoServer];
	[_posASL,_playerId,_player,_type] remoteExecCall ["BRPVP_atomicBombCodeOneTime",2];

	//COUNT MAX PARTICLES
	private _max = 0;
	private _sum = 0;
	private _init = diag_tickTime;
	private _count = 0;
	private _lim1 = 250;
	private _lim2 = 500;
	private _lim3 = 750;
	private _lim4 = 1000;
	private _countGood1 = 0;
	private _countGood2 = 0;
	private _countGood3 = 0;
	private _countGood4 = 0;
	private _runTime = 40;
	waitUntil {
		private _particles = count (8 allObjects 3);
		private _delta = diag_tickTime-_init;
		if (_particles > _max) then {_max = _particles;};
		if (_particles <= _lim1) then {_countGood1 = _countGood1+1;};
		if (_particles <= _lim2) then {_countGood2 = _countGood2+1;};
		if (_particles <= _lim3) then {_countGood3 = _countGood3+1;};
		if (_particles <= _lim4) then {_countGood4 = _countGood4+1;};
		_count = _count+1;
		_sum = _sum+_particles;
		systemChat str [_max,_particles,round (_sum/_count),str _lim1+": "+str round (_delta*((_count-_countGood1)/_count)),str _lim2+": "+str round (_delta*((_count-_countGood2)/_count)),str _lim3+": "+str round (_delta*((_count-_countGood3)/_count)),str _lim4+": "+str round (_delta*((_count-_countGood4)/_count))];
		_delta > _runTime
	};
};

//==============================================
// BRPVP ATOMIC BOMB END
//==============================================

//==============================================
// BRPVP PETER BOMB BEGIN
//==============================================
BRPVP_peterSetParticleParams = {
	params ["_source","_class","_change","_abSize"];

	//HEAD BOMBA ATOMICA
	if (_change isEqualTo "ba_head") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			10, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,50*0.25*_abSize], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			if (_abSize >= 0.15) then {0.15} else {0.75}, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[80*_abSize,100*_abSize], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				(([139/255,069/255,019/255] vectorMultiply 0.800) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.200))+[0.250],
				(([139/255,069/255,019/255] vectorMultiply 0.500) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.500))+[0.500],
				(([139/255,069/255,019/255] vectorMultiply 0.300) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.700))+[0.600],
				(([139/255,069/255,019/255] vectorMultiply 0.200) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.800))+[0.600],
				(([139/255,069/255,019/255] vectorMultiply 0.150) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.850))+[0.600],
				(([139/255,069/255,019/255] vectorMultiply 0.100) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.900))+[0.600],
				(([139/255,069/255,019/255] vectorMultiply 0.050) vectorAdd ([0.5,0.5,0.5] vectorMultiply 0.950))+[0.600],
				[0.5,0.5,0.5,0.600],
				[0.5,0.5,0.5,0.600],
				[0.5,0.5,0.5,0.600],
				[0.5,0.5,0.5,0.500],
				[0.6,0.6,0.6,0.300],
				[0.8,0.8,0.8,0.000]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.5,[0.2,0.2,0.2],[0.1,0.1,0.1],20,1,[0,0,0,0],0.2,0.05,360,0]
		_source setParticleRandom [
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0.35, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//DUST BOMBA ATOMICA
	if (_change isEqualTo "ba_dust") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			15*0.75, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[45*1.5*_abSize,60*1.5*_abSize], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				[0.08,0.067,0.052,0.05],
				[0.60,0.500,0.400,0.35],
				[0.60,0.500,0.400,0.34],
				[0.60,0.500,0.400,0.32],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.20],
				[0.55,0.500,0.450,0.10],
				[0.50,0.500,0.500,0.00]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			true //onSurface
		];

		//ORIGINAL [5,[5,1,5],[5,1,5],20,0.3,[0,0,0,0],0,0,0,0]
		_source setParticleRandom [
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//DUST BIG BOMBA ATOMICA
	if (_change isEqualTo "ba_dust_big") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			17.5, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[40*2*_abSize,50*2*_abSize], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			[
				[0.08,0.067,0.052,0.05],
				[0.60,0.500,0.400,0.35],
				[0.60,0.500,0.400,0.34],
				[0.60,0.500,0.400,0.32],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.30],
				[0.60,0.500,0.400,0.20],
				[0.55,0.500,0.450,0.10],
				[0.50,0.500,0.500,0.00]
			], //getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			true //onSurface
		];

		//ORIGINAL [5,[5,1,5],[5,1,5],20,0.3,[0,0,0,0],0,0,0,0]
		_source setParticleRandom [
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			[1,0.2,1], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};

	//EXPLOSAO
	if (_change isEqualTo "ba_explo") then {
		_source setParticleParams [
			[
				getText (configFile >> "CfgCloudlets" >> _class >> "particleShape"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSNtieth"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSIndex"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSFrameCount"),
				getNumber (configFile >> "CfgCloudlets" >> _class >> "particleFSLoop")
			],
			getText (configFile >> "CfgCloudlets" >> _class >> "animationName"),
			getText (configFile >> "CfgCloudlets" >> _class >> "particleType"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "timerPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTime"),
			[0,0,0], //pos3D
			[0,0,0], //getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocity"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocity"),
			1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "weight"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "volume"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rubbing"),
			[200*_abSize/10,200*_abSize], //getArray (configFile >> "CfgCloudlets" >> _class >> "size"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "color"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "animationSpeed"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriod"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensity"),
			getText (configFile >> "CfgCloudlets" >> _class >> "onTimerScript"),
			getText (configFile >> "CfgCloudlets" >> _class >> "beforeDestroyScript"),
			_source, //obj
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angle"),
			false //onSurface
		];

		//ORIGINAL [0.3,[5,6,5],[2,2,2],25,0.4,[0,0,0,0.3],0.2,0.05,1,0]
		_source setParticleRandom [
			0.1, //getNumber (configFile >> "CfgCloudlets" >> _class >> "lifeTimeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "positionVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "moveVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "rotationVelocityVar"),
			0, //getNumber (configFile >> "CfgCloudlets" >> _class >> "sizeVar"),
			getArray (configFile >> "CfgCloudlets" >> _class >> "colorVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionPeriodVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "randomDirectionIntensityVar"),
			getNumber (configFile >> "CfgCloudlets" >> _class >> "angleVar") //OPTIONAL
			//getNumber (configFile >> "CfgCloudlets" >> _class >> "bounceOnSurfaceVar") //OPTIONAL
		];
	};
};
BRPVP_peterCreateAnimatedParticle = {
	params ["_abSize","_class","_type","_useClass","_pos","_change","_tickIni","_tickEnd","_radIni","_radEnd","_velocityIni","_velocityEnd","_pTime","_curve"];
	_radIni = _radIni*_abSize;
	_radEnd = _radEnd*_abSize;
	_velocityIni = _velocityIni vectorMultiply _abSize;
	_velocityEnd = _velocityEnd vectorMultiply _abSize;
	private _source = "#particlesource" createVehicleLocal _pos;
	if (_useClass) then {_source setParticleClass _class;};
	[_source,_class,_change,_abSize] call BRPVP_peterSetParticleParams;
	_source setParticleCircle [_radIni,_velocityIni];
	_source setDropInterval _tickIni;
	[_source,_tickIni,_tickEnd,_radIni,_radEnd,_velocityIni,_velocityEnd,_pTime,_curve] spawn {
		params ["_source","_tickIni","_tickEnd","_radIni","_radEnd","_velocityIni","_velocityEnd","_pTime","_curve"];
		private _init = diag_tickTime;
		private _deltaRad = _radEnd-_radIni;
		private _deltaTick = _tickEnd-_tickIni;
		private _deltaVelocity = _velocityEnd vectorDiff _velocityIni;
		waitUntil {
			private _delta = diag_tickTime-_init;
			private _perc = (_delta/_pTime)^_curve;
			private _radNow = _radIni+_perc*_deltaRad;
			private _tickNow = _tickIni+_perc*_deltaTick;
			private _velocityNow = _velocityIni vectorAdd (_deltaVelocity vectorMultiply _perc);
			_source setParticleCircle [_radNow,_velocityNow];
			_source setDropInterval _tickNow;
			_delta > _pTime
		};
		deleteVehicle _source;
	};
};
BRPVP_peterEarthQuake = {
	params ["_posAGL","_obj","_quakeParams"];
	_quakeParams params ["_speed","_exploSndDist"];
	private _init = diag_tickTime;
	private _soundOk = false;
	private _quakeOk = false;
	waitUntil {
		private _quakeReach = _exploSndDist;
		private _delta = diag_tickTime-_init;
		private _playerDistSound = positionCameraToWorld [0,0,0] distance _posAGL;
		private _playerDistQuake = _playerDistSound-_speed*0.6;
		private _soundRun = _speed*_delta;
		if (_soundRun >= _playerDistQuake && !_quakeOk) then {
			private _intensity = 4-floor (_playerDistSound/(_quakeReach/4));
			if (_intensity > 0) then {
				if (diag_tickTime-BRPVP_lastScriptedQuakeTime > 5) then {
					BRPVP_lastScriptedQuakeTime = diag_tickTime;
					[_intensity] spawn BIS_fnc_earthquake;
				};
			};
			_quakeOk = true;
		};
		if (_soundRun >= _playerDistSound && !_soundOk) then {
			_obj say3D ["peter_bomb",_exploSndDist];
			_soundOk = true;
			[_posAGL,_quakeReach] spawn {
				params ["_posAGL","_quakeReach"];
				private _init = diag_tickTime;
				private _thReach = _quakeReach/3;
				waitUntil {
					private _a = [_posAGL,positionCameraToWorld [0,0,0]] call BIS_fnc_dirTo;
					private _d = (((positionCameraToWorld [0,0,0] distance2D _posAGL)-_thReach) max 0)*1.5;
					private _i = sqrt ((1-_d/_quakeReach) max 0);
					private _tn = 1-((diag_tickTime-_init)/0.25) max 0;
					private _t = sqrt _tn;
					private _p = _i*(1-_t);
					private _m = (_p*35) min 15;
					private _grassShakeIntensity = 0.075+_i*(_m/15)*0.925;
					private _s = _grassShakeIntensity*2*(1-_tn)*sin (time*(720+(1-_tn)*360));
					private _wc = [(_m+_s)*sin _a,(_m+_s)*cos _a,0];
					private _w = (_wc vectorMultiply (1-_t)) vectorAdd (BRPVP_weatherServerWind vectorMultiply _t);
					setWind ((_w select [0,2])+[true]);
					_t isEqualTo 0
				};
				_init = diag_tickTime;
				waitUntil {
					private _a = [_posAGL,positionCameraToWorld [0,0,0]] call BIS_fnc_dirTo;
					private _d = (((positionCameraToWorld [0,0,0] distance2D _posAGL)-_thReach) max 0)*1.5;
					private _i = sqrt ((1-_d/_quakeReach) max 0);
					private _tn = 1-((diag_tickTime-_init)/7) max 0;
					private _t = sqrt _tn;
					private _p = _i*_t;
					private _m = (_p*35) min 15;
					private _grassShakeIntensity = 0.075+_i*(_m/15)*0.925;
					private _s = _grassShakeIntensity*2*_tn*sin (time*(720+_tn*360));
					private _wc = [(_m+_s)*sin _a,(_m+_s)*cos _a,0];
					private _w = (_wc vectorMultiply _t) vectorAdd (BRPVP_weatherServerWind vectorMultiply (1-_t));
					setWind ((_w select [0,2])+[true]);
					_t isEqualTo 0
				};
			};
		};
		(_soundOk && _quakeOk) || !alive player
	};
	if (_soundOk) then {
		uiSleep 25;
		deleteVehicle _obj;
	};
};
BRPVP_peterAtomicBombCodeAllClients = {
	params ["_posASL","_playerId","_player","_effParams"];
	_effParams params ["_lightDist","_lightDistFull","_quakeParams","_abSize"];
	private _posAGL = ASLToAGL _posASL;
	private _hObj = createSimpleObject ["Land_Matches_F",_posASL,true];
	_hObj allowDamage false;
	_hObj hideObject true;

	//RUN SOUND, SHAKE
	[_posAGL,_hObj,_quakeParams] spawn BRPVP_peterEarthQuake;

	private _type = "normal";
	private _smokeMult = 1;
	[_abSize,"HeavyBombExp1",_type,false,_posAGL,"ba_explo",0.01,0.075,0,0,[0,0,0],[0,0,0],2.5,1] call BRPVP_peterCreateAnimatedParticle;
	[_abSize,"BombDust",_type,true,_posAGL,"ba_dust",0.005,0.002,0,750,[0,0,7.5],[0,0,0],4,1/2.5] call BRPVP_peterCreateAnimatedParticle;
	[_abSize,"BombDust",_type,true,_posAGL,"ba_dust_big",0.005,0.0025,0,300,[0,0,7.5],[0,0,0],1.5,1/2.5] call BRPVP_peterCreateAnimatedParticle;
	[_abSize,"HeavyBombSmk2",_type,true,_posAGL,"ba_head",0.01/_smokeMult,0.0075/_smokeMult,0,225,[0,0,0],[0,0,0],10,1/2.25] call BRPVP_peterCreateAnimatedParticle;
};
BRPVP_peterAtomicBombCodeOneTime = {
	params ["_posASL","_playerId","_player","_bombParams"];
	_bombParams params ["_range","_extraRange","_speed"];
	private _posAGL = ASLToAGL _posASL;

	//CREATE "KILLER" FOR CORRECT OBJECTS FALL DIRECTION
	private _hObj = "Land_Matches_F" createVehicle _posAGL;
	_hObj setPosASL _posAGL;
	_hObj enableSimulation false;
	_hObj allowDamage false;
	_hObj hideObjectGlobal true;

	//DESTRUCTION
	private _rangeSqr = _range^2;
	private _housesMap = nearestTerrainObjects [_posAGL,["HOUSE"],_range+_extraRange/2,false];

	private _initPerf = diag_tickTime;
	private _objs1 = _posAGL nearEntities [BRPVP_zombieMotherClass,_range+_extraRange]; //ZOMBIES
	private _objs2 = _posAGL nearEntities [BRPVP_playerModel,_range+_extraRange] select {_x getVariable ["sok",false]}; //PLAYERS
	private _objs3 = _posAGL nearEntities ["CaManBase",_range+_extraRange] select {(_x getVariable ["brpvp_ai",false] || _x getVariable ["brpvp_lars",false]) && !(_x getVariable ["brpvp_is_ulfan",false]) && !(_x getVariable ["brpvp_minerva_ai_unit",false])}; //BOTS
	private _objs4 = _posAGL nearEntities [["LandVehicle","Ship","Air","Motorcycle"],_range+_extraRange] select {isDamageAllowed _x}; //VEHICLES
	private _objs5 = nearestTerrainObjects [_posAGL,["WALL","TREE"],_range+_extraRange/2,false] select {random 1 < 0.75 && {alive _x}}; //MAP SMALL OBJECTS
	private _objs6 = _housesMap select {typeOf _x isNotEqualTo "" && {_x getVariable ["brpvp_map_god_mode_house_id",-1] isEqualTo -1 && !isObjectHidden _x && isDamageAllowed _x && typeOf _x call BRPVP_checkAtomicBombCanDamBuildings}}; //MAP HOUSE
	diag_log str ["BRPVP Perf 1 Test Destruction Peter Bomb (ms):",(diag_tickTime-_initPerf)*1000];

	private _objsCount = ["BRPVP Peter Bomb Destruction",["zed",count _objs1],["player",count _objs2],["bot",count _objs3],["vehicle",count _objs4],["map",count _objs5],["map_house",count _objs6]];

	_initPerf = diag_tickTime;
	_objs1 = _objs1 apply {[_x distanceSqr _posAGL,_x,"zed"]};
	_objs2 = _objs2 apply {[_x distanceSqr _posAGL,_x,"player"]};
	_objs3 = _objs3 apply {[_x distanceSqr _posAGL,_x,"bot"]};
	_objs4 = _objs4 apply {[_x distanceSqr _posAGL,_x,"vehicle"]};
	_objs5 = _objs5 apply {[_x distanceSqr _posAGL,_x,"map"]};
	_objs6 = _objs6 apply {[_x distanceSqr _posAGL,_x,"map_house"]};
	diag_log str ["BRPVP Perf 2 Test Destruction Peter Bomb (ms):",(diag_tickTime-_initPerf)*1000];

	_initPerf = diag_tickTime;
	_objs1 append _objs2;
	_objs1 append _objs3;
	_objs1 append _objs4;
	_objs1 append _objs5;
	_objs1 append _objs6;
	_objs1 sort true;
	diag_log str ["BRPVP Perf 3 Test Destruction Peter Bomb (ms):",(diag_tickTime-_initPerf)*1000];
	[_objs1,_range,_rangeSqr,_extraRange,_playerId,_player,_posAGL,_posASL,_objsCount,_hObj,_speed] spawn {
		params ["_objs","_range","_rangeSqr","_extraRange","_playerId","_player","_posAGL","_posASL","_objsCount","_hObj","_speed"];
		private _init = diag_tickTime;
		private _percHouse = 0.9;
		private _percHouseToOne = (1-_percHouse) min _percHouse;
		private _percDust = 0.25;
		private _percDustToOne = (1-_percDust) min _percDust;
		private _wait = 25/_speed;
		private _helper = createSimpleObject ["Land_Matches_F",[0,0,0],true];
		private _droneRemotePlayers = [];
		_helper hideObject true;
		waitUntil {
			private _delta = diag_tickTime-_init;
			private _reach = (_speed*_delta) min (_range+_extraRange);
			private _percForce = (1-(_reach/(_range+_extraRange/2))) max 0;
			private _percHouseNow = _percHouse+(_percForce*_percHouseToOne*2-_percHouseToOne);
			private _percDustNow = _percDust+(_percForce*_percDustToOne*2-_percDustToOne);
			private _reachSqr = _reach^2;
			private _deleteCount = 0;
			if (isNull _player && _playerId isNotEqualTo -1) then {_player = (call BRPVP_playersList select {_x getVariable ["id_bd",-1] isEqualTo _playerId}+[_player]) select 0;};
			private _paramsArray = ["_dist","_obj","_type"];
			{
				_x params _paramsArray;
				if (_dist > _reachSqr) exitWith {_deleteCount = _forEachIndex;};
				if (!IsNull _obj && alive _obj) then {
					if (_type isEqualTo "map") exitWith {_obj setDamage [1,false,_hObj];};
					if (_type isEqualTo "map_house") exitWith {
						if (random 1 < _percHouseNow) exitWith {
							[_obj,true] remoteExecCall ["hideObjectGlobal",2];
							_obj allowDamage false;
							if (random 1 > _percDustNow) exitWith {
								private _cfg = configFile >> "CfgVehicles" >> typeOf _obj >> "DestructionEffects" >> "Ruin1" >> "type";
								if (isText _cfg) exitWith {
									private _ruinModel = getText _cfg;
									private _ruin = createSimpleObject [_ruinModel select [1,count _ruinModel-1],getPosASL _obj];
									_ruin setDir (getDir _obj-15+random 30);
								};
								private _crater = createSimpleObject ["a3\data_f\krater.p3d", getPosASL _obj];
								_crater setDir random 360;
								if (sizeOf typeOf _obj < 25) exitWith {_crater setObjectScale (1+random 0.25);};
								_crater setObjectScale (1.35+random 0.15);
							};
							private _small = sizeOf typeOf _obj < 25;
							if (_small || random 1 < 0.5) exitWith {
								private _crater = createSimpleObject ["a3\data_f\krater.p3d", getPosASL _obj];
								_crater setDir random 360;
								if (_small) exitWith {_crater setObjectScale (1+random 0.25);};
								_crater setObjectScale (1.35+random 0.15);
							};
							private _cfg = configFile >> "CfgVehicles" >> typeOf _obj >> "DestructionEffects" >> "Ruin1" >> "type";
							if (isText _cfg) exitWith {
								private _ruinModel = getText _cfg;
								private _ruin = createSimpleObject [_ruinModel select [1,count _ruinModel-1],getPosASL _obj];
								_ruin setDir (getDir _obj-15+random 30);
							};
							private _crater = createSimpleObject ["a3\data_f\krater.p3d", getPosASL _obj];
							_crater setDir random 360;
							if (_small) exitWith {_crater setObjectScale (1+random 0.25);};
							_crater setObjectScale (1.35+random 0.15);
						};
					};
					if (_type isEqualTo "bot") exitWith {
						if (_dist < _rangeSqr) exitWith {
							if (_obj getVariable ["brpvp_lars",false]) exitWith {
								private _dam = _obj getHit "head";
								if (_dam < 0.5) then {
									private _newDam = (_dam+0.25) min 0.5;
									[_obj,["flame",350]] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
									[_obj,["head",_newDam,false,_player,_player]] remoteExecCall ["setHit",_obj];
									_obj setVariable ["brpvp_lars_gdam","lars_life_"+str (16*ceil(_newDam*128/16))+".paa",true];
								};
							};
							//if (random 1 < 0.75) exitWith {
							if (random 1 < 1) exitWith {
								[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
								[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
							};
							[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
						};
						if (_obj getVariable ["brpvp_lars",false]) exitWith {
							private _dam = _obj getHit "head";
							if (_dam < 0.5) then {
								private _newDam = (_dam+0.125) min 0.5;
								[_obj,["head",_newDam,false,_player,_player]] remoteExecCall ["setHit",_obj];
								_obj setVariable ["brpvp_lars_gdam","lars_life_"+str (16*ceil(_newDam*128/16))+".paa",true];
							};
						};
						if (random 1 < 0.5) exitWith {
							if (random 1 < 0.5) exitWith {
								[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
								[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
							};
							[_obj,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_obj];
						};
						_obj setDamage 0.875;
					};
					if (_type isEqualTo "vehicle") exitWith {
						private _operator = _obj getVariable ["brpvp_operator",objNull];
						if (isNull _operator) exitWith {
							if (_dist < _rangeSqr) exitWith {
								private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _obj >> "armor");
								if (_armor < 450) exitWith {
									{
										if (_x getVariable ["brpvp_ai",false]) exitWith {[_x,_player] remoteExecCall ["BRPVP_hdehAtomicBombDesintegration",_x];};
										if (typeOf _x in BRPVP_VantAiUnits) exitWith {
											//DRONE AND DRONE PLAYER CODE
											private _dronePlayer = _obj call BRPVP_getUAVPlayer;
											if (_dronePlayer call BRPVP_isPlayer && {!(_dronePlayer in _droneRemotePlayers) && _dronePlayer distanceSqr _hObj > _rangeSqr}) exitWith {
												_droneRemotePlayers pushBack _dronePlayer;
												if (_dronePlayer getVariable ["dd",-1] isEqualTo -1) exitWith {
													if (isNull objectParent _dronePlayer) exitWith {
														_dronePlayer setVariable ["brpvp_atomic_bomb_death",true,_dronePlayer getVariable "brpvp_machine_id"];
														_dronePlayer setVariable ["brpvp_atomic_bomb_death_sound",true,_dronePlayer getVariable "brpvp_machine_id"];
														[_player,"Peter_Bomb_Remote_F"] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_dronePlayer];
														_dronePlayer spawn {
															private _dronePlayer = _this;
															uiSleep 0.1;
															[_dronePlayer,["flame",300]] remoteExecCall ["BRPVP_atomicBombUnitDieFlames",BRPVP_allNoServer];
															remoteExecCall ["BRPVP_atualizaDebug",_dronePlayer];

															//PLAY DEATH SOUND
															private _sounder = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],100,"CAN_COLLIDE"];
															_sounder attachTo [_dronePlayer,[0,0,0]];
															[_sounder,["peter_remote_kill",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
															uiSleep 2.5;
															detach _sounder;
															deleteVehicle _sounder;
														};
													};
													[_player,"Peter_Bomb_Remote_F"] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_dronePlayer];
												};
											};
										};
										[_player,"Peter_Bomb_F"] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_x];
									} forEach (crew _obj select {!(_x getVariable ["god",false] || _x getVariable ["brpvp_god_admin",false] || _x getVariable ["brpvp_extra_protection",false])});
									_obj setDamage [1,false,_player,_player];
									_obj remoteExec ["BRPVP_explosionDeleteSmoke",0];
								};
								[_obj,_player] remoteExecCall ["BRPVP_atomicBombHeavyVehDam",_obj];
							};
							private _armor = getNumber (configFile >> "CfgVehicles" >> typeOf _obj >> "armor");
							if (_armor < 200) then {
								{
									if (_x getVariable ["brpvp_ai",false]) then {
										if (random 1 < 0.75) then {_x setDamage 0.875;};
									} else {
										_x setDamage [0.6 max damage _x,false,_player,_player];
									};
								} forEach crew _obj;
								_obj setDamage [0.5 max damage _obj,false,_player,_player];
							} else {
								[_obj,_player] remoteExecCall ["BRPVP_atomicBombHeavyVehDamLow",_obj];
							};
						};
						if (_dist < _rangeSqr) exitWith {
							if (random 1 < 0.75) exitWith {
								if (random 1 < 0.5) then {[_operator,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];};
								[_operator,false,0.25] remoteExec ["BRPVP_manualTurretDie",2];
							};
						};
						if (random 1 < 0.4) exitWith {
							if (random 1 < 0.5) then {[_operator,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];};
							[_operator,false,0.25] remoteExec ["BRPVP_manualTurretDie",2];
						};
					};
					if (_type isEqualTo "player") exitWith {
						if !(_obj getVariable "god" || _obj getVariable "brpvp_god_admin" || _obj getVariable "brpvp_extra_protection" || _obj in _droneRemotePlayers) then {
							if (_dist < _rangeSqr) exitWith {
								_obj setVariable ["brpvp_atomic_bomb_death",true,_obj getVariable "brpvp_machine_id"];
								_obj setVariable ["brpvp_atomic_bomb_death_sound",true,_obj getVariable "brpvp_machine_id"];
								[_player,"Peter_Bomb_F"] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_obj];
								[_obj,["flame",300]] remoteExecCall ["BRPVP_atomicBombUnitDieFlames",BRPVP_allNoServer];
								remoteExecCall ["BRPVP_atualizaDebug",_obj];
							};
							private _pos = eyePos _obj;
							private _vecToBomb = vectorNormalized (_posASL vectorDiff _pos) vectorMultiply 7.5;
							private _distMult = (1-(sqrt(_dist)-_range)/_extraRange) max 0;
							private _damage = (_distMult*sqrt(([_helper,_obj,_posASL,_pos,_vecToBomb,5,4,0.3] call BRPVP_blastBlock)/7.5)) max 0.2;
							private _inside = insideBuilding _obj;
							private _damage = ((1-_inside)*_damage+_inside*0.25) min (BRPVP_pDamLim*0.85);
							private _dNow = (_obj getHitPointDamage "hithead") max (_obj getHitPointDamage "hitbody") max (damage _obj) max _damage;
							_obj setDamage [_dNow,false,_player,_player];
							remoteExecCall ["BRPVP_atualizaDebug",_obj];
						};
					};
					if (_type isEqualTo "zed") exitWith {
						if (_dist < _rangeSqr) exitWith {
							if (random 1 < 0.75) exitWith {
								[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
								[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],true,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
							};
							[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],false,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
						};
						if (random 1 < 0.5) exitWith {
							if (random 1 < 0.5) exitWith {
								[_obj,["flame",250],true] remoteExecCall ["BRPVP_atomicBombUnitDieFlamesFast",BRPVP_allNoServer];
								[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],true,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
							};
							[_obj,_player,"",_obj getVariable ["brpvp_mobius",false],false,false,false] remoteExecCall ["BRPVP_zedDeath",_obj];
						};
					};
				};
			} forEach _objs;
			if (_deleteCount > 0) then {_objs deleteRange [0,_deleteCount];};

			uiSleep _wait;
			_reach isEqualTo (_range+_extraRange)
		};

		diag_log str _objsCount;
		deleteVehicle _helper;
		deleteVehicle _hObj;
		remoteExecCall ["BRPVP_AIRemoveNull",2];
	};
};
BRPVP_peterSpawnAtomicBomb = {
	params ["_posASL","_player","_tanksNumber","_bombParams","_effParams"];
	private _playerId = _player getVariable ["id_bd",-1];
	[_posASL,_playerId,_player,_effParams] remoteExecCall ["BRPVP_peterAtomicBombCodeAllClients",BRPVP_allNoServer];
	[_posASL,_playerId,_player,_bombParams] remoteExecCall ["BRPVP_peterAtomicBombCodeOneTime",2];
	uiSleep 3;
	for "_i" from 1 to _tanksNumber do {ASLToAGL _posASL remoteExecCall ["BRPVP_createAtomicBombBlueTankItems",2];};
};
BRPVP_peterSpawnAtomicBombCheckParticles = {
	params ["_posASL","_player","_tanksNumber","_bombParams","_effParams"];
	private _playerId = _player getVariable ["id_bd",-1];

	//DELETE ACTUAL PARTICLES
	{deleteVehicle _x;} forEach (8 allObjects 3);

	[_posASL,_playerId,_player,_effParams] remoteExecCall ["BRPVP_peterAtomicBombCodeAllClients",BRPVP_allNoServer];
	[_posASL,_playerId,_player,_bombParams] remoteExecCall ["BRPVP_peterAtomicBombCodeOneTime",2];

	//COUNT MAX PARTICLES
	private _max = 0;
	private _init = diag_tickTime;
	waitUntil {
		private _count = count (8 allObjects 3);
		if (_count > _max) then {_max = _count;};			
		systemChat str _max;
		diag_tickTime-_init > 20
	};
};

//==============================================
// BRPVP PETER BOMB END
//==============================================

diag_log ("[SCRIPT] serverAndClientFunctions.sqf END: " + str round (diag_tickTime - _scriptStart));