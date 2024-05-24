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

//BUILDINGS WITH LOOT
BRPVP_lootBuildingsGood = [
	"Land_LightHouse_F",
	"Land_spp_Tower_F",
	"Land_GH_MainBuilding_middle_F",
	"Land_GH_MainBuilding_right_F",
	"Land_GH_MainBuilding_left_F",
	"Land_GH_Gazebo_F",
	"Land_i_Windmill01_F",
	"Land_Hospital_main_F",
	"Land_Hospital_side1_F",
	"Land_Hospital_side2_F",
	"Land_dp_mainFactory_F",
	"Land_Castle_01_tower_F",
	"Land_Medevac_house_V1_F",
	"Land_Medevac_HQ_V1_F",
	"Land_Radar_F",
	"Land_i_Barracks_V1_F",
	"Land_i_Barracks_V2_F",
	"Land_u_Barracks_V2_F",
	"Land_FuelStation_Shed_F",
	"Land_Hangar_F",
	"Land_WIP_F",
	"Land_Offices_01_V1_F",
	"Land_MilOffices_V1_F",
	"Land_Unfinished_Building_01_F", //165
	"Land_Unfinished_Building_02_F",
	"Land_Airport_Tower_F",
	"Land_Research_HQ_F",
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_HQ_V2_F",
	"Land_Cargo_HQ_V3_F",
	"Land_Cargo_Tower_V1_F", //VAI DAR ERRO?
	"Land_Cargo_Tower_V2_F", //VAI DAR ERRO?
	"Land_Cargo_Tower_V3_F", //VAI DAR ERRO?
	"Land_Airport_left_F",
	"Land_Airport_right_F",
	"Land_dp_bigTank_F",
	"Land_i_Shed_Ind_F",
	"Land_Factory_Main_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_Cargo_Patrol_V2_F",
	"Land_Cargo_Patrol_V3_F",
	"Land_Chapel_V2_F",
	"Land_Chapel_V1_F" //116
];
BRPVP_lootBuildingsAverage = [
	"Land_u_Shed_Ind_F",
	"Land_CarService_F",
	"Land_GH_House_1_F",
	"Land_cargo_house_slum_F",
	"Land_FuelStation_Build_F",
	"Land_Chapel_Small_V1_F",
	"Land_Research_house_V1_F",
	"Land_u_Shop_02_V1_F", //140
	"Land_Cargo_House_V1_F", //129
	"Land_Cargo_House_V2_F",
	"Land_Cargo_House_V3_F",
	"Land_i_House_Big_02_V2_F", //128
	"Land_i_House_Big_01_V1_F", //125
	"Land_i_House_Big_01_V3_F", //122
	"Land_i_Stone_HouseBig_V1_F", //113
	"Land_i_Stone_HouseBig_V2_F", //110
	"Land_i_Stone_HouseBig_V3_F", //110
	"Land_i_Garage_V1_F", //167
	"Land_i_House_Big_01_V2_F", //238
	"Land_i_House_Big_02_V1_F", //245
	"Land_i_House_Big_02_V3_F", //162
	"Land_u_House_Big_01_V1_F", //218
	"Land_u_House_Big_02_V1_F" //198
];
BRPVP_lootBuildingsWeak = [
	"Land_GH_House_2_F",
	"Land_d_Windmill01_F",
	"Land_Pier_F",
	"Land_i_Stone_Shed_V1_F", //613
	"Land_u_Addon_02_V1_F", //612
	"Land_i_Stone_Shed_V3_F", //560
	"Land_i_Stone_Shed_V2_F", //567
	"Land_Metal_Shed_F", //442
	"Land_Slum_House01_F", //393
	"Land_Slum_House03_F", //390
	"Land_Slum_House02_F", //388
	"Land_u_Addon_01_V1_F", //258
	"Land_i_Addon_03_V1_F", //249
	"Land_d_Stone_Shed_V1_F", //238
	"Land_i_Addon_02_V1_F", //233
	"Land_Stone_Shed_V1_ruins_F", //203
	"Land_u_House_Small_02_V1_F", //197
	"Land_u_House_Small_01_V1_F", //192
	"Land_i_House_Small_01_V3_F", //173
	"Land_i_House_Small_02_V2_F", //169
	"Land_i_Stone_HouseSmall_V2_F", //157
	"Land_i_House_Small_02_V3_F", //155
	"Land_i_House_Small_01_V2_F", //154
	"Land_i_Stone_HouseSmall_V1_F", //152
	"Land_i_Stone_HouseSmall_V3_F", //151
	"Land_i_Garage_V2_F", //147
	"Land_i_Addon_04_V1_F", //144
	"Land_i_House_Small_01_V1_F", //141
	"Land_i_House_Small_02_V1_F", //115
	"Land_i_House_Small_03_V1_F" //107
];
BRPVP_loot_buildings_class = BRPVP_lootBuildingsWeak+BRPVP_lootBuildingsAverage+BRPVP_lootBuildingsGood;

//BUILDING WITH REPEATED LOOT
BRPVP_lootRepeatClass = [
	"Land_i_House_Big_02_V1_F",
	"Land_i_House_Big_01_V2_F",
	"Land_u_House_Big_01_V1_F",
	"Land_u_House_Big_02_V1_F",
	"Land_u_House_Small_02_V1_F",
	"Land_u_House_Small_01_V1_F",
	"Land_i_House_Small_01_V3_F",
	"Land_i_House_Small_02_V2_F",
	"Land_Unfinished_Building_01_F",
	"Land_i_House_Big_02_V3_F",
	"Land_i_Stone_HouseSmall_V2_F",
	"Land_i_House_Small_02_V3_F",
	"Land_i_House_Small_01_V2_F",
	"Land_i_Stone_HouseSmall_V1_F",
	"Land_i_Stone_HouseSmall_V3_F",
	"Land_i_House_Small_01_V1_F",
	"Land_u_Shop_02_V1_F",
	"Land_i_Shed_Ind_F",
	"Land_i_House_Big_02_V2_F",
	"Land_i_House_Big_01_V1_F",
	"Land_i_House_Big_01_V3_F",
	"Land_i_House_Small_02_V1_F",
	"Land_i_Stone_HouseBig_V1_F",
	"Land_i_Stone_HouseBig_V2_F",
	"Land_i_Stone_HouseBig_V3_F",
	"Land_i_House_Small_03_V1_F",
	"Land_d_Stone_HouseSmall_V1_F",
	"Land_Unfinished_Building_02_F",
	"Land_d_House_Small_01_V1_F",
	"Land_i_Shop_01_V3_F",
	"Land_u_Shop_01_V1_F",
	"Land_d_Stone_HouseBig_V1_F",
	"Land_d_House_Small_02_V1_F",
	"Land_i_Shop_02_V3_F",
	"Land_i_Shop_01_V2_F",
	"Land_i_Shop_02_V2_F",
	"Land_d_House_Big_02_V1_F",
	"Land_Chapel_V1_F",
	"Land_u_Shed_Ind_F",
	"Land_i_Shop_02_V1_F",
	"Land_i_Shop_01_V1_F",
	"Land_CarService_F",
	"Land_i_Barracks_V2_F",
	"Land_Airport_01_hangar_F",
	"Land_Cargo_Tower_V1_F",
	"Land_GH_House_1_F",
	"Land_dp_bigTank_F",
	"Land_d_Shop_01_V1_F",
	"Land_Bridge_Asphalt_PathLod_F",
	"Land_Unfinished_Building_01_ruins_F",
	"Land_GH_House_2_F",
	"Land_Offices_01_V1_F",
	"Land_Bridge_HighWay_PathLod_F",
	"Land_SCF_01_storageBin_small_F",
	"Land_Cargo_HQ_V1_F",
	"Land_MilOffices_V1_F",
	"Land_FuelStation_02_workshop_F",
	"Land_House_Big_01_V1_ruins_F",
	"Land_House_Big_02_V1_ruins_F",
	"Land_Unfinished_Building_02_ruins_F",
	"Land_Chapel_V2_F",
	"Land_Cargo_Tower_V3_F",
	"Land_Research_HQ_F",
	"Land_spp_Tower_F",
	"Land_Addon_04_V1_ruins_F",
	"Land_u_Barracks_V2_F",
	"Land_Factory_Main_F",
	"Land_Hospital_side2_F",
	"Land_Airport_Tower_F",
	"Land_Cargo_HQ_V3_F",
	"Land_SCF_01_condenser_F",
	"Land_Lighthouse_small_F",
	"Land_Bridge_Concrete_PathLod_F",
	"Land_GH_Gazebo_F",
	"Land_Hangar_F",
	"Land_Airport_02_hangar_left_F",
	"Land_Airport_02_hangar_right_F",
	"Land_SCF_01_crystallizer_F",
	"Land_Bridge_01_PathLod_F",
	"Land_Castle_01_tower_F",
	"Land_WIP_F",
	"Land_SCF_01_diffuser_F",
	"Land_LightHouse_F",
	"Land_Crane_F",
	"Land_Shop_02_V1_ruins_F",
	"Land_i_Barracks_V1_F",
	"Land_GH_MainBuilding_middle_F",
	"Land_GH_MainBuilding_right_F",
	"Land_Airport_right_F",
	"Land_Airport_left_F",
	"Land_Warehouse_03_F",
	"Land_GH_MainBuilding_left_F",
	"Land_Airport_01_controlTower_F",
	"Land_Stadium_p9_F",
	"Land_Hospital_main_F",
	"Land_Radar_F",
	"Land_Hospital_side1_F",
	"Land_Stadium_p4_F",
	"Land_Stadium_p5_F"
];
BRPVP_lootRepeatQnt = [3,3,3,3,2,2,2,2,3,3,2,2,2,2,2,2,3,3,3,3,3,2,2,2,2,2,2,2,2,3,3,2,2,3,3,3,3,2,3,3,3,2,7,5,4,2,2,3,3,2,2,6,3,2,3,3,2,2,2,2,2,4,3,2,2,6,2,2,4,3,3,2,3,3,3,7,6,5,3,2,7,4,3,2,2,7,5,4,4,4,4,4,3,3,3,3,2,2,2];
call compile preprocessFileLineNumbers "brpvp_loot_config_all_maps.sqf";