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

//WALL ARROUND FLAGS OPTIONS
BRPVP_wallAroundOptions = [
	//[CLASS,SIZE,ROTATION,HSHIFT,TERRAIN_FIT,ENTRANCE (#OBJECTS),half tickness]
	["Land_Wall_IndCnc_4_F",5.75,0,0,true,0,1],
	["Land_CncWall4_F",5.25,0,0,true,0,1],
	["Land_Canal_WallSmall_10m_F",9,0,4,true,0,1],
	["Land_Pier_Box_F",19,0,25,false,0,10],
	["Land_Canal_Dutch_01_15m_F",15,0,10,false,0,8]
];
BRPVP_wallAroundPrice = 5000000;
BRPVP_wallAroundRemoveGain = 3500000;
BRPVP_wallAroundOptionsSelected = 0;

//VANT VEHICLES
BRPVP_vantVehiclesClass = ["O_UAV_01_F","O_UAV_06_F","O_UGV_01_F","O_UGV_01_rcws_F","O_UAV_02_dynamicLoadout_F","B_UAV_05_F","B_T_UAV_03_dynamicLoadout_F","O_T_UAV_04_CAS_F","CUP_B_USMC_DYN_MQ9"];
BRPVP_vantVehiclesClassAttack = ["O_UAV_02_dynamicLoadout_F","B_UAV_05_F","B_T_UAV_03_dynamicLoadout_F","O_T_UAV_04_CAS_F","CUP_B_USMC_DYN_MQ9"];
BRPVP_vantVehiclesClassPlane = ["O_UAV_02_dynamicLoadout_F","O_T_UAV_04_CAS_F","B_UAV_05_F","CUP_B_USMC_DYN_MQ9"];
BRPVP_pylonTurretWeapons = ["PylonMissile_1Rnd_LG_scalpel","PylonRack_3Rnd_LG_scalpel","PylonRack_4Rnd_LG_scalpel","PylonMissile_Missile_AGM_02_x2","PylonMissile_Bomb_GBU12_x1","PylonMissile_Missile_HARM_INT_x1","PylonRack_Bomb_SDB_x4"];

//OTHER CONFIGURATIONS
BRPVP_massSaveCycle = 60;
BRPVP_servidorQPS = 0;
BRPVP_playerModel = "C_man_polo_1_F"; //THIS IS THE MODEL THAT PLAYERS USE. IT CANT BE USED BY AI OR NPCS.

//INFANTRY DAY VEHICLES
BRPVP_disableVehUseListCfg = [
	//DRONES
	"B_T_UAV_03_dynamicLoadout_F",
	"O_UAV_02_dynamicLoadout_F",
	"B_UAV_05_F",
	"O_T_UAV_04_CAS_F",
	//CUP DRONES
	"CUP_B_USMC_DYN_MQ9",
	//ARTY
	"B_MBT_01_arty_F",
	"O_MBT_02_arty_F",
	"B_MBT_01_mlrs_F",
	"I_E_Truck_02_MRL_F",
	//CUP ARTY
	"CUP_B_BM21_CDF",
	"CUP_B_RM70_CZ",
	//JETS
	"O_T_VTOL_02_infantry_dynamicLoadout_F",
	"I_Plane_Fighter_03_dynamicLoadout_F",
	"O_Plane_CAS_02_dynamicLoadout_F",
	"I_Plane_Fighter_04_F",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_F",
	"O_Plane_Fighter_02_F",
	//JETS CUP
	"CUP_B_Su25_Dyn_CDF",
	"CUP_B_JAS39_HIL",
	"CUP_B_F35B_USMC",
	"CUP_B_AV8B_DYN_USMC",
	"CUP_B_A10_DYN_USA",
	"CUP_B_SU34_CDF",
	//TANKS
	"B_APC_Tracked_01_rcws_F",
	"I_APC_tracked_03_cannon_F",
	"B_APC_Tracked_01_AA_F",
	"O_APC_Tracked_02_AA_F",
	"O_APC_Tracked_02_cannon_F",
	"O_MBT_02_cannon_F",
	"I_MBT_03_cannon_F",
	"B_MBT_01_cannon_F",
	"B_MBT_01_TUSK_F",
	"O_MBT_04_command_F",
	"O_MBT_02_railgun_F",
	//TANKS CUP 1
	"CUP_B_Challenger2_2CD_BAF",
	"CUP_B_Leopard2A6DST_GER",
	"CUP_B_ZSU23_CDF",
	"CUP_O_T90_RU",
	"CUP_B_M1A1_DES_US_Army",
	"CUP_B_M1A2_TUSK_MG_US_Army",
	//TANKS CUP 2
	"CUP_B_Ural_ZU23_CDF",
	"CUP_O_BMP2_RU",
	"CUP_O_BMP3_RU",
	"CUP_I_M163_AAF",
	"CUP_O_T55_CHDKZ",
	"CUP_B_MCV80_GB_D",
	"CUP_B_FV510_GB_D",
	"CUP_O_2S6M_RU",
	//ATTACK HELIS
	"B_Heli_Attack_01_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_black_F",
	//ATTACK HELIS CUP
	"CUP_O_Ka52_RU",
	"CUP_B_AH1Z_Dynamic_USMC",
	"CUP_B_AH1_DL_BAF",
	"CUP_B_Mi24_D_Dynamic_CDF",
	"CUP_B_AH64D_DL_USA",
	"CUP_B_Mi35_Dynamic_CZ_Tiger",
	//APC
	//"B_APC_Wheeled_01_cannon_F",
	//"O_APC_Wheeled_02_rcws_F",
	"B_AFV_Wheeled_01_up_cannon_F",
	"I_APC_Wheeled_03_cannon_F",
	//APC CUP
	//"CUP_B_BRDM2_ATGM_CDF",
	//"CUP_B_LAV25M240_green",
	//"CUP_B_Boxer_HMG_GER_DES",
	//"CUP_O_GAZ_Vodnik_BPPU_RU",
	//"CUP_B_AAV_USMC",
	//"CUP_O_T34_TKA",
	//"CUP_B_M1128_MGS_Desert",
	//CUP FRIGATE
	"CUP_I_Frigate_AAF",
	//RHS TANKS
	"rhs_zsu234_aa",
	"rhs_t72ba_tv",
	"rhs_t80um",
	"rhs_t80bvk",
	"rhs_t72be_tv",
	"rhs_t90_tv",
	"rhs_t90sab_tv",
	"rhs_t14_tv",
	"RHS_M2A2_wd",
	"RHS_M2A2_BUSKI_WD",
	"RHS_M6_wd",
	"rhsusf_m1a1aim_tuski_d",
	"rhsusf_m1a1aim_tuski_wd",
	"rhsusf_m1a2sep1tuskid_usarmy",
	"rhsusf_m1a2sep1tuskiwd_usarmy",
	"rhsusf_m1a2sep1tuskiid_usarmy",
	"rhsusf_m1a2sep1tuskiiwd_usarmy",
	//RHS ATTACK HELIS
	"RHS_Mi24P_vdv",
	"RHS_Mi24V_vdv",
	"RHS_Mi24V_vvs",
	"RHS_Ka52_vvsc",
	"RHS_Ka52_vvs",
	"rhs_mi28n_vvsc",
	"rhs_mi28n_vvs",
	"RHS_AH1Z",
	"RHS_AH64D",
	"RHS_AH64DGrey",
	//RHS JETS
	"RHS_Su25SM_vvsc",
	"RHS_Su25SM_vvs",
	"RHS_TU95MS_vvs_old",
	"rhs_mig29s_vmf",
	"rhs_mig29sm_vvsc",
	"rhs_mig29s_vvs",
	"RHS_T50_vvs_blueonblue",
	"RHS_T50_vvs_054",
	"RHS_T50_vvs_052",
	"RHS_T50_vvs_generic_ext",
	"RHS_A10",
	"rhsusf_f22",
	//X-66 MAMMOTH TANKS
	"HTNK",
	"HTNK_Green",
	"HTNK_Ghex",
	"HTNK_SLA",
	"HTNK_Desert",
	"HTNK_Nato",
	"HTNK_Nato_Pacific",
	"HTNK_us_woodland",
	"HTNK_us_desert",
	"HTNK_Gdi",
	"HTNK_Snow",
	"HTNK_us_snow",
	"HTNK_Grey",
	"HELPER"
]; //LIST OF VEHICLES TO DISABLE ON BRPVP_disableVehUseDays