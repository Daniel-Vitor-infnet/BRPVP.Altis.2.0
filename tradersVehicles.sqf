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

//["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_01_box_F","Truck Box",80000,1]
//[trader type,category,sub-category,vehicle classname,vehicle name (not used),price,mission key index (optional)]
//
//===== trader type =====
//"ADMIN" for Black Market vehicle.
//"FEDIDEX" for Fedidex Vehicles (the line must be added at the top of the list).
//"CIVIL"/"CIV-MIL"/"MILITAR" for Normal Unarmed Vehicle Shop vehicles.
//"BOATS" for Boat Shop vehicles.
//"AIRPORT" for Plane Shop vehicles.
//
//===== category =====
//When adding new vehicles, just copy a category from another vehicle
//or use a string like "Super Good Vehicles" instead of using localized "...".
//
//===== sub-category =====
//When adding new vehicles, just copy a sub-category from another vehicle
//or use a string like "Super Good Planes" instead of using localized "...".
//
//===== vehicle name (not used) =====
//Just for our easy reference, not used by BRPVP.
//
//===== mission key index (optional) =====
//Just add this last number if you want the vehicle
//to appears on the White Key Vehicle Mission.
//The number determines the type of the vehicle you is adding:
//
//	1 - QILIN, STRIDER, HUNTER AND LIKE
//	2 - NYX, GORGON AND LIKE
//	3 - MEDIUM TANKS
//	4 - LOW ARMED HELIS
//	5 - HEAVY TANKS
//	6 - HIGH ARMED HELIS
//	7 - JETS
//	8 - ATTACK DRONES
//	9 - ARTILLERY
//
BRPVP_tudoA3 = [
	//FEDIDEX EXPRESS
	["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Kart_01_F","Kart",7500],
	["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Quadbike_01_F","Quadbike",12500],
	["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Hatchback_01_F","Hatchback",30000],
	["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Offroad_02_unarmed_F","MB 4WD",35000],
	["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_Van_02_transport_F","Van Transport",45000],
	["FEDIDEX",localize "str_land_civil",localize "str_city_cars","C_SUV_01_F","SUV",40000],
	["FEDIDEX",localize "str_land_civil",localize "str_city_cars","CUP_C_Bus_City_CIV","Ikarus 553",200000],
	["FEDIDEX",localize "str_land_civil",localize "str_maintenance","C_Van_01_fuel_F","Truck Fuel",75000],
	["FEDIDEX",localize "str_land_civil",localize "str_maintenance","C_Offroad_01_repair_F","Offroad (Services)",75000],
	["FEDIDEX",localize "str_land_militar",localize "str_mrap","B_MRAP_01_F","Hunter",200000],
	["FEDIDEX",localize "str_land_militar",localize "str_mrap","O_MRAP_02_F","Ifrit",200000],
	["FEDIDEX",localize "str_land_militar",localize "str_mrap","I_MRAP_03_F","Strider",200000],
	["FEDIDEX",localize "str_land_militar",localize "str_maintenance","B_Truck_01_ammo_F","HEMTT Ammo",200000],
	["FEDIDEX",localize "str_boats",localize "str_civilian","C_Scooter_Transport_01_F","Water Scooter",125000],
	["FEDIDEX",localize "str_helicopters",localize "str_civil","C_Heli_Light_01_civil_F","M-900 I",250000],

	//VAN
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_01_transport_F","Truck Transport",60000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_01_box_F","Truck Box",80000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_02_transport_F","Van Transport",90000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Van_01_fuel_F","Truck Fuel",150000],

	//HATCH BACK & SUV
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Hatchback_01_F","Hatchback",60000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_SUV_01_F","SUV",80000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Hatchback_01_sport_F","Hatchback (Esporte)",100000],

	//KART & QUAD
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Kart_01_F","Kart",15000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Quadbike_01_F","Quadbike",25000],

	//HEAVY TRUCKS
	["CIVIL",localize "str_land_civil",localize "str_city_cars","C_Truck_02_box_F","Civil Repair Truck",150000],

	//OFFROAD
	["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_stripped_F","Offroad Stripped",60000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_01_F","Offroad",70000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_02_unarmed_F","MB 4WD",70000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_01_covered_F","Offroad (Covered)",100000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_01_comms_F","Offroad (Comms)",125000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","C_Tractor_01_F","Tractor",125000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","C_Offroad_01_repair_F","Offroad (Services)",150000],
	["CIV-MIL",localize "str_land_civil",localize "str_offroad","I_G_Offroad_01_armed_F","I Offroad (Armed)",150000],

	//OFFROAD APEX
	["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_black_F","MB 4WD (Black)",60000],
	["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_blue_F","MB 4WD (Blue)",60000],
	["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_green_F","MB 4WD (Green)",60000],
	["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_orange_F","MB 4WD (Orange)",60000],
	["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_red_F","MB 4WD (Red)",60000],
	["CIVIL",localize "str_land_apex",localize "str_civil","C_Offroad_02_unarmed_white_F","MB 4WD (White)",60000],
	["CIVIL",localize "str_land_apex",localize "str_civil","I_C_Van_01_transport_brown_F","Truck (Brown)",70000],
	["CIVIL",localize "str_land_apex",localize "str_civil","I_C_Van_01_transport_olive_F","Truck (Olive)",70000],
	["CIVIL",localize "str_land_apex",localize "str_civil","I_C_Offroad_02_unarmed_brown_F","MB 4WD (Brown)",60000],
	["CIVIL",localize "str_land_apex",localize "str_civil","I_C_Offroad_02_unarmed_olive_F","MB 4WD (Olive)",60000],

	//INFANTRY TRANSPORT TRUCK AND UTILITARY TRUCKS
	["CIV-MIL",localize "str_land_militar",localize "str_truck","B_Truck_01_transport_F","HEMTT Transport",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","I_Truck_02_transport_F","Zamak Transport",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","O_Truck_03_transport_F","Tempest Transport",250000],

	["MILITAR",localize "str_land_militar",localize "str_truck","B_Truck_01_covered_F","HEMTT Transport (Covered)",250000],
	["MILITAR",localize "str_land_militar",localize "str_truck","I_Truck_02_covered_F","Zamak Transport (Covered)",250000],
	["MILITAR",localize "str_land_militar",localize "str_truck","O_Truck_03_covered_F","Tempest Transport (Covered)",250000],

	["MILITAR",localize "str_land_militar",localize "str_truck","B_Truck_01_fuel_F","HEMTT Fuel",300000],
	["MILITAR",localize "str_land_militar",localize "str_truck","O_Truck_02_fuel_F","Zamak Fuel",300000],
	["MILITAR",localize "str_land_militar",localize "str_truck","O_Truck_03_fuel_F","Tempest Fuel",300000],

	["MILITAR",localize "str_land_militar",localize "str_truck","B_Truck_01_ammo_F","HEMTT Ammo",400000],
	["MILITAR",localize "str_land_militar",localize "str_truck","I_Truck_02_ammo_F","Zamak Ammo",400000],
	["MILITAR",localize "str_land_militar",localize "str_truck","O_Truck_03_ammo_F","Tempest Ammo",400000],

	["MILITAR",localize "str_land_militar",localize "str_truck","B_Truck_01_repair_F","HEMTT Repair",300000],
	["MILITAR",localize "str_land_militar",localize "str_truck","O_Truck_03_repair_F","Tempest Repair",300000],

	//MRAP
	["CIV-MIL",localize "str_land_militar",localize "str_mrap","B_MRAP_01_F","Hunter",350000],
	["CIV-MIL",localize "str_land_militar",localize "str_mrap","O_MRAP_02_F","Ifrit",350000],
	["CIV-MIL",localize "str_land_militar",localize "str_mrap","I_MRAP_03_F","Strider",350000],
	["ADMIN",localize "str_land_militar",localize "str_mrap","B_MRAP_01_hmg_F","Hunter HMG",700000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","O_MRAP_02_hmg_F","Ifrit HMG",700000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","I_MRAP_03_hmg_F","Strider HMG",700000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","B_MRAP_01_gmg_F","Hunter GMG",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","O_MRAP_02_gmg_F","Ifrit GMG",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","I_MRAP_03_gmg_F","Strider GMG",800000,1],

	//PROWLER AND QILIN
	["MILITAR",localize "str_land_militar",localize "str_light_armed","B_T_LSV_01_unarmed_F","Prowler Unarmed 1",200000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","B_LSV_01_unarmed_F","Prowler Unarmed 2",200000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","B_CTRG_LSV_01_light_F","Prowler Unarmed 3",200000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","B_LSV_01_unarmed_black_F","Prowler Unarmed 4",200000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","O_T_LSV_02_unarmed_F","Qilin (Unarmed)",200000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","O_LSV_02_unarmed_F","Qilin (Unarmed)",200000],
	["ADMIN",localize "str_land_militar",localize "str_light_armed","B_T_LSV_01_armed_F","Prowler HMG 1",400000,1],
	["ADMIN",localize "str_land_militar",localize "str_light_armed","B_LSV_01_armed_F","Prowler HMG 2",400000,1],
	["ADMIN",localize "str_land_militar",localize "str_light_armed","O_T_LSV_02_armed_F","Qilin (Minigun)",400000,1],
	["ADMIN",localize "str_land_militar",localize "str_light_armed","B_T_LSV_01_AT_F","Prowler AT 1",1000000,1],
	["ADMIN",localize "str_land_militar",localize "str_light_armed","B_LSV_01_AT_F","Prowler AT 2",1000000,1],
	["ADMIN",localize "str_land_militar",localize "str_light_armed","O_T_LSV_02_AT_F","Qilin (AT)",1000000,1],

	//NYX
	["ADMIN",localize "str_land_militar",localize "str_nyx_model","I_LT_01_scout_F","AWC 303 Nyx (Recon)",1000000,2],
	["ADMIN",localize "str_land_militar",localize "str_nyx_model","I_LT_01_cannon_F","AWC 304 Nyx (Autocannon)",1200000,2],
	["ADMIN",localize "str_land_militar",localize "str_nyx_model","I_LT_01_AA_F","AWC 302 Nyx (AA)",1600000,2],
	["ADMIN",localize "str_land_militar",localize "str_nyx_model","I_LT_01_AT_F","AWC 301 Nyx (AT)",1600000,2],

	//APCS WHEELED
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","B_APC_Wheeled_01_cannon_F","AMV-7 Marshall",1500000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","O_APC_Wheeled_02_rcws_F","MSE-3 Marid",1500000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","B_AFV_Wheeled_01_up_cannon_F","Rhino MGS",2500000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","I_APC_Wheeled_03_cannon_F","AFV-4 Gorgon",2500000,2],

	//VANT
	["MILITAR",localize "str_land_militar","VANT","O_UGV_01_F","UAV APC Unarmed",250000],
	["MILITAR",localize "str_land_militar","VANT","O_UGV_01_rcws_F","UAV APC Armed",500000],

	//TANKS
	["ADMIN",localize "str_land_militar",localize "str_tanks","B_APC_Tracked_01_CRV_F","Bobcat",3500000,3], //HMG
	["ADMIN",localize "str_land_militar",localize "str_tanks","B_APC_Tracked_01_rcws_F","Panther",3500000,3], //HMG + GMG
	["ADMIN",localize "str_land_militar",localize "str_tanks","I_APC_tracked_03_cannon_F","FV-720 Mora",4000000,3], //CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","B_APC_Tracked_01_AA_F","Cheetah AA",4500000,3], //DOUBLE CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","O_APC_Tracked_02_AA_F","Tigris AA",4500000,3], //DOUBLE CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","O_APC_Tracked_02_cannon_F","Kamysh",5000000,3], //MULTIPLE WEAPONS INCLUDING AT

	["ADMIN",localize "str_land_militar",localize "str_tanks","O_MBT_02_cannon_F","T-100 Varsuk",5000000,5], //BIG CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","I_MBT_03_cannon_F","Kuma",4000000,5], //BIG CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","B_MBT_01_cannon_F","M2A1 Slammer",5000000,5], //BIG CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","B_MBT_01_TUSK_F","Slammer UP",6000000,5], //BIG CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","O_MBT_04_command_F","T-140K Angara",6000000,5], //BIG CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","O_MBT_02_railgun_F","T-100X Futurat",8000000,5], //BIG RAILGUN CANNON

	//ADMIN ARTILLERY
	["ADMIN",localize "str_land_militar",localize "str_arty","I_E_Truck_02_MRL_F","Zamak MRL",10000000,9],
	["ADMIN",localize "str_land_militar",localize "str_arty","B_MBT_01_arty_F","M4 Scorcher",12000000,9],
	["ADMIN",localize "str_land_militar",localize "str_arty","O_MBT_02_arty_F","2S9 Sochor",12000000,9],
	["ADMIN",localize "str_land_militar",localize "str_arty","B_MBT_01_mlrs_F","M5 Sandstorm MLRS",15000000,9],

	//AIRPORT TRADER
	["AIRPORT",localize "str_planes",localize "str_civil","I_C_Plane_Civil_01_F","Caesar BTT",500000],
	["AIRPORT",localize "str_planes",localize "str_civil","C_Plane_Civil_01_F","Caesar BTT",500000],
	["AIRPORT",localize "str_planes",localize "str_civil","C_Plane_Civil_01_racing_F","Caesar BTT (Racing)",600000],
	["AIRPORT",localize "str_planes",localize "str_militar","B_T_VTOL_01_vehicle_F","V-44 X Blackfish (Vehicle Transport)",3500000],
	["ADMIN",localize "str_planes",localize "str_militar","B_T_VTOL_01_armed_F","V-44 X Blackfish (Armed)",5000000,7],

	["ADMIN",localize "str_planes",localize "str_militar","O_T_VTOL_02_infantry_dynamicLoadout_F","Y-32 Xi'an (Infantry Transport)",6000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","I_Plane_Fighter_03_dynamicLoadout_F","A-143 Buzzard (CAS)",6000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","O_Plane_CAS_02_dynamicLoadout_F","To-199 Neophron (CAS)",7000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","I_Plane_Fighter_04_F","A-149 Gryphon",8500000,7],
	["ADMIN",localize "str_planes",localize "str_militar","B_Plane_CAS_01_dynamicLoadout_F","A-164 Wipeout (CAS)",10000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","B_Plane_Fighter_01_F","Black Wasp",12000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","O_Plane_Fighter_02_F","To-201 Shikra",14000000,7],
	["ADMIN",localize "str_planes","VANT","O_UAV_02_dynamicLoadout_F","K40 Ababil-3",round(8000000*BRPVP_dronesPriceMultiply),8],
	["ADMIN",localize "str_planes","VANT","O_T_UAV_04_CAS_F","KH-3A Fenghuang",round(6500000*BRPVP_dronesPriceMultiply),8],
	["ADMIN",localize "str_planes","VANT","B_UAV_05_F","UAV Sentinel",round(6000000*BRPVP_dronesPriceMultiply),8],

	//CIVIL HELIS
	["AIRPORT",localize "str_helicopters",localize "str_civil","C_Heli_light_01_stripped_F","M-900 (Stripped)",300000],
	["AIRPORT",localize "str_helicopters",localize "str_civil","C_Heli_Light_01_civil_F","M-900 I",350000],
	["AIRPORT",localize "str_helicopters",localize "str_civil","I_C_Heli_Light_01_civil_F","M-900 II",350000],
	["AIRPORT",localize "str_helicopters",localize "str_civil","B_Heli_Light_01_stripped_F","MH-9 Hummingbird (Stripped)",450000],
	["AIRPORT",localize "str_helicopters",localize "str_civil","B_Heli_Light_01_F","MH-9 Hummingbird",500000],

	//MILITAR ATTACK HELIS
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","B_Heli_Attack_01_dynamicLoadout_F","AH-99 Blackfoot",7000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","O_Heli_Attack_02_dynamicLoadout_F","Mi-48 Kajman",8000000],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","O_Heli_Attack_02_dynamicLoadout_black_F","Mi-48 Kajman (Black)",8000000,6],

	//MILITAR TRANSPORT HELIS
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_Heli_Transport_03_unarmed_F","CH-67 Huron (Unarmed)",1500000], //UNARMED
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","B_Heli_Transport_03_unarmed_green_F","CH-67 Huron (Unarmed)",1500000], //UNARMED
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","I_Heli_Transport_02_F","CH-49 Mohawk",1500000], //UNARMED
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","O_Heli_Transport_04_covered_black_F","Mi-280 Taru (Transport, Black)",1500000], //UNARMED
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","O_Heli_Light_02_unarmed_F","PO-30 Orca (Unarmed)",1500000], //UNARMED
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","I_Heli_light_03_unarmed_F","WY-55 Hellcat (Unarmed)",1500000], //UNARMED

	//MILITAR LIGHT HELIS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","B_Heli_Transport_03_F","CH-67 Huron (Green)",2500000,4], //ARMED: 2 MACHINEGUNS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","B_Heli_Transport_01_F","UH-80 Ghost Hawk",2500000,4], //ARMED: 2 MACHINEGUNS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","B_Heli_Transport_01_camo_F","UH-80 Ghost Hawk (Camo)",2500000,4], //ARMED: 2 MACHINEGUNS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","B_CTRG_Heli_Transport_01_sand_F","UH-80 Ghost Hawk (Sand)",2500000,4], //ARMED: 2 MACHINEGUNS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","B_CTRG_Heli_Transport_01_tropic_F","UH-80 Ghost Hawk (Tropic)",2500000,4], //ARMED: 2 MACHINEGUNS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","O_Heli_Light_02_dynamicLoadout_F","PO-30 Orca",3000000,4], //ARMED: 1 MACHINEGUN 1 SMALLROCKETS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","B_Heli_Light_01_dynamicLoadout_F","AH-9 Pawnee",3500000,4], //ARMED: 2 MACHINEGUNS 2 SMALLROCKETS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","I_Heli_light_03_dynamicLoadout_F","WY-55 Hellcat",4000000,4], //ARMED: 2 MACHINEGUNS 2 SMALLROCKETS

	//UAV
	["AIRPORT",localize "str_helicopters","VANT","O_UAV_01_F","UAV Quadmotor",350000],
	["AIRPORT",localize "str_helicopters","VANT","O_UAV_06_F","UAV Octamotor Cargo",200000],
	["ADMIN",localize "str_helicopters","VANT","B_T_UAV_03_dynamicLoadout_F","Falcon",round(10000000*BRPVP_dronesPriceMultiply),8],

	//CIVIL BOATS
	["BOATS",localize "str_boats",localize "str_civilian","C_Scooter_Transport_01_F","Water Scooter",200000],
	["BOATS",localize "str_boats",localize "str_civilian","C_Rubberboat","Rescue Boat I",150000],
	["BOATS",localize "str_boats",localize "str_civilian","C_Boat_Transport_02_F","RHIB I",260000],
	["BOATS",localize "str_boats",localize "str_civilian","C_Boat_Civil_01_F","Motorboat",400000],
	["BOATS",localize "str_boats",localize "str_civilian","C_Boat_Civil_01_rescue_F","Motorboat (Rescue)",450000],
	["BOATS",localize "str_boats",localize "str_civilian","C_Boat_Civil_01_police_F","Motorboat (Police)",500000],

	//MILITAR BOATS
	["BOATS",localize "str_boats",localize "str_militar","O_Lifeboat","Rescue Boat II",150000],
	["BOATS",localize "str_boats",localize "str_militar","O_Boat_Transport_01_F","Assault Boat I",160000],
	["BOATS",localize "str_boats",localize "str_militar","O_G_Boat_Transport_01_F","Assault Boat II",160000],
	["BOATS",localize "str_boats",localize "str_militar","I_Boat_Transport_01_F","Assault Boat III",160000],
	["BOATS",localize "str_boats",localize "str_militar","I_C_Boat_Transport_02_F","RHIB II",300000],
	["BOATS",localize "str_boats",localize "str_militar","B_SDV_01_F","Submersible",800000],
	["BOATS",localize "str_boats",localize "str_militar","O_SDV_01_F","Submersible",800000],
	["BOATS",localize "str_boats",localize "str_militar","I_SDV_01_F","Submersible",800000],
	["BOATS",localize "str_boats",localize "str_militar","O_T_Boat_Armed_01_hmg_F","Speedboat HMG",1200000],

	//CUP MILITAR BOATS		
	["BOATS",localize "str_boats",localize "str_militar","CUP_B_RHIB2Turret_HIL","RHIB (Mk19)",1500000],
	["BOATS",localize "str_boats",localize "str_militar","CUP_B_ZUBR_CDF","Zubr-Class LCAC",5000000],
	["BOATS",localize "str_boats",localize "str_militar","CUP_I_Frigate_AAF","MEKO 200 Frigate",30000000],

	//CUP CIVIL LAND VEHICLES
	["CIVIL",localize "str_land_civil",localize "str_city_cars","CUP_O_Volha_SLA","GAZ-24 ""Volga"" (Militia)",60000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","CUP_C_Bus_City_CIV","Ikarus 553",250000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","CUP_C_Ikarus_Chernarus","Ikarus 260",350000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","CUP_O_TT650_CHDKZ","TT650",85000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","CUP_C_TT650_TK_CIV","TT650 CIV",85000],
	["CIVIL",localize "str_land_civil",localize "str_city_cars","CUP_B_M1030_USA","M1030",100000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","CUP_B_Tractor_CDF","Towing Tractor",100000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","CUP_O_Tractor_Old_CHDKZ","Towing Tractor",100000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","CUP_I_Hilux_armored_unarmed_NAPA","Hilux Full Armor Mode",120000],
	["CIVIL",localize "str_land_civil",localize "str_offroad","B_GEN_Offroad_01_gen_F","GEN Offroad",150000],

	//CUP PLANES CIVIL
	["AIRPORT",localize "str_planes",localize "str_civil","CUP_I_Plane_ION","Motor Plane",500000],
	["AIRPORT",localize "str_planes",localize "str_civil","CUP_C_Cessna_172_CIV","Cessna 172 (Red)",500000],
	["AIRPORT",localize "str_planes",localize "str_civil","CUP_C_Cessna_172_CIV_GREEN","Cessna 172 (Green)",500000],
	["AIRPORT",localize "str_planes",localize "str_civil","CUP_C_Cessna_172_CIV_BLUE","Cessna 172 (Blue)",500000],
	["AIRPORT",localize "str_planes",localize "str_civil","CUP_I_CESSNA_T41_ARMED_ION","T-41 Mescalero (Armed)",600000],
	["AIRPORT",localize "str_planes",localize "str_civil","CUP_O_C47_SLA","Li-2",750000],
	["AIRPORT",localize "str_planes",localize "str_militar","CUP_O_AN2_TK","Antonov An-2",750000],
	["AIRPORT",localize "str_planes",localize "str_militar","CUP_C_AN2_CIV","Antonov An-2",750000],
	["AIRPORT",localize "str_planes",localize "str_militar","CUP_C_AN2_AIRTAK_TK_CIV","Antonov An-2",750000],
	["AIRPORT",localize "str_planes",localize "str_militar","CUP_C_C47_CIV","C-47 Skytrain",1000000],
	["AIRPORT",localize "str_planes",localize "str_militar","CUP_B_C130J_USMC","C-130J",3500000],

	//CUP UNARMED VEHICLES
	["MILITAR",localize "str_land_militar",localize "str_light_armed","CUP_B_TowingTractor_CZ","Towing Tractor",200000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","CUP_B_S1203_Ambulance_CDF","Škoda S1203 (Ambulance)",200000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","CUP_B_HMMWV_Unarmed_USMC","HMMWV (Unarmed)",300000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","CUP_B_UAZ_Unarmed_ACR","UAZ-469",300000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","CUP_B_UAZ_Open_ACR","UAZ-469 (Open)",300000],
	["MILITAR",localize "str_land_militar",localize "str_light_armed","CUP_B_LR_Transport_CZ_D","Land Rover 110",300000],

	//CUP LIGHT ARMED
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_O_M113_TKA","M113",500000,1], //HMG, ARMORED
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_I_SUV_Armored_ION","Armored SUV",600000,1], //MINIGUM
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_Dingo_GL_GER_Des","Dingo 2 (GL) (Desert)",600000,1], //GL
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_I_RG31_Mk19_ION","RG-31 Mk.19",600000,1], //GL
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_Dingo_GER_Des","Dingo 2 (MG) (Desert)",600000,1], //HMG
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_O_BTR80_CAMO_RU","BTR-80 (Camo)",700000,1], //HMG1 + HMG2 HEAVY
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_Hilux_armored_SPG9_BLU_G_F","Hilux Armored (SPG-9)",700000,1], //GL
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_HMMWV_M2_GPK_ACR","HMMWV M1151 M2",800000,1], //0.50
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_HMMWV_DSHKM_GPK_ACR","HMMWV M1114 DSHKM",800000,1], //DSHKM
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_HMMWV_AGS_GPK_ACR","HMMWV M1114 AGS",800000,1], //GL
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_Hilux_armored_zu23_BLU_G_F","Hilux Armored (ZU-23-2)",850000,1], //AA
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_Jackal2_GMG_GB_D","Jackal GMG",850000,1], //HMG + GMG
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_BAF_Coyote_GMG_D","Coyote GMG",850000,1], //HMG + GMG
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_Mastiff_GMG_GB_D","Mastiff GMG",850000,1], //HMG + GMG
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_O_GAZ_Vodnik_AGS_RU","GAZ-3937 Vodnik (AGS-30/PKM)",850000,1], //HMG + GL
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_O_UAZ_SPG9_RU","UAZ-469 (SPG-9)",1000000,1], //STRONG LAUNCHER
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_HMMWV_TOW_USMC","HMMWV (TOW)",1200000,1], //GUIDED ROCKET
	["ADMIN",localize "str_land_militar",localize "str_light_armed","CUP_B_UAZ_METIS_CDF","UAZ-469 (Metis-M)",1200000,1], //GUIDED ROCKET

	//CUP WHELEED APC
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","CUP_B_BRDM2_ATGM_CDF","BRDM-2 (ATGM)",1350000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","CUP_B_LAV25M240_green","LAV-25A1 (M240) (Olive)",1650000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","CUP_B_Boxer_HMG_GER_DES","GTK Boxer (Desert, HMG)",1800000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","CUP_O_GAZ_Vodnik_BPPU_RU","GAZ-3937 Vodnik (BPPU)",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","CUP_B_AAV_USMC","AAVP7/A1",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","CUP_O_T34_TKA","T-34-85M",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","CUP_B_M1128_MGS_Desert","M1128 MGS (Desert)",2500000,2],

	//CUP ARTILLERY
	["MILITAR",localize "str_land_militar",localize "str_arty","CUP_B_BM21_CDF","BM-21",2500000],

	//CUP MILITAR TRANSPORT HELIS
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","CUP_I_SA330_Puma_HC2_RACS","SA-330 Puma HC2",1200000], //UNARMED
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","CUP_B_CH53E_USMC","CH-53E Super Stallion",1800000], //UNARMED

	//CUP LIGHT HELIS
	["AIRPORT",localize "str_helicopters",localize "str_light_helicopters","CUP_B_UH60S_USN","MH-60S Seahawk (M3M)",2500000,4], //ARMED: 2 HMG
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","CUP_B_UH1Y_Gunship_Dynamic_USMC","UH-1Y Venom (Gunship)",3000000,4], //ARMED: 2 PILLOW + 2 MINIGUN
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","CUP_B_UH1D_armed_GER_KSK","UH-1D (Armed)",3000000,4], //ARMED: 2 PILLOW + 2 HMG
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","CUP_B_Mi171Sh_ACR","Mi 171 (Rockets)",3500000,4], //ARMED: 200 SMALL ROCKETS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","CUP_O_Mi8_RU","Mi-8MTV3",3500000,4], //ARMED: MANY SMALL ROCKETS + MANY HMG
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","CUP_O_Ka50_DL_RU","Ka-50 Black Shark",3500000,4], //ARMED: EXPLO BULLET + 4 PILOWS (ROCKETS, IGLA)
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","CUP_B_Mi35_Dynamic_CZ","Mi 35",4000000,4], //ARMED: 8 GUIDED ROCKETS + SMALL ROCKETS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","CUP_B_Mi35_Dynamic_CZ_Tiger","Mi 35 Tiger",4000000,4], //ARMED: 8 GUIDED ROCKETS + SMALL ROCKETS

	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_L39_CZ","L39ZA (Green)",3000000,4], //SIMPLE SLOW JET - 4 PILOWS
	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_L39_CZ_GREY","L39ZA (Gray)",3000000,4], //SIMPLE SLOW JET - 4 PILOWS

	//CUP TANKS
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_Ural_ZU23_CDF","Ural (ZU-23)",2500000,3], //ZU-23 ANTI AIR
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_O_BMP2_RU","BMP-2",2750000,3], //EXPLOSIVE BULLET + HMG + GUIDED ROCKET
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_O_BMP3_RU","BMP-3",2750000,3], //3 HMG + EXPLOSIVE BULLET + CANNON
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_I_M163_AAF","M163A1 VADS",3000000,3], //MINIGUN ANTI AIR
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_O_T55_CHDKZ","T-55",3200000,3], //CANNON 2 AMMO + HMG
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_MCV80_GB_D","MCV-80 Warrior",3500000,3], //HMG + 30MM HE + APDS
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_FV510_GB_D","FV510 Warrior",3500000,3], //HMG + 30MM HE + APDS
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_O_2S6M_RU","2S6M Tunguska-M",4500000,3], //DOUBLE CANNON + 8 GUIDED ROCKETS

	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_Challenger2_2CD_BAF","FV4034 Challenger 2 (Two-Color Desert)",4000000,5], //BIG CANNON + ?
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_Leopard2A6DST_GER","Leopard 2A6 (Desert)",4000000,5], //BIG CANNON + HMG
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_ZSU23_CDF","ZSU-23-4",4500000,5], //ANTI AIR 4 CANNONS
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_O_T90_RU","T-90A",4500000,5], //CANNON 3 AMMO TYPE + HMG (2 VORONAS TO KILL)
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_M1A1_DES_US_Army","M1A1 Abrams (Desert)",4500000,5], //MG + APDS CANNOM
	["ADMIN",localize "str_land_militar",localize "str_tanks","CUP_B_M1A2_TUSK_MG_US_Army","M1A2 Abrams TUSK (Woodland)",4500000,5], //2 X MG + APDS CANNOM

	//CUP ATTACK HELIS
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","CUP_O_Ka50_DL_RU","Ka-50 Black Shark",6500000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","CUP_O_Ka50_DL_SLA","Ka-50 Black Shark",6500000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","CUP_O_Ka52_RU","Ka-52",6500000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","CUP_B_AH1Z_Dynamic_USMC","AH-1Z",6500000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","CUP_B_AH1_DL_BAF","AH1",7000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","CUP_B_Mi24_D_Dynamic_CDF","Mi-24D",8000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","CUP_B_AH64D_DL_USA","AH-64D",8000000,6],

	//CUP ATTACK DRONES
	["ADMIN",localize "str_planes","VANT","CUP_B_USMC_DYN_MQ9","MQ-9 Reaper",round(12000000*BRPVP_dronesPriceMultiply),8],

	//CUP JETS
	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_Su25_Dyn_CDF","Su-25 Frogfoot",7000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_JAS39_HIL","A-149 Gryphon",8000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_F35B_USMC","F-35B Lightning II",8000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_AV8B_DYN_USMC","AV-8B Harrier II",8500000,7],
	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_A10_DYN_USA","A-10A Thunderbolt II",10000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","CUP_B_SU34_CDF","Su-34",12000000,7],

	//RHS MRAP
	//RHS USAF
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_M1220_M153_M2_usarmy_wd","M1220 (CROWS/M2)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_M1220_M153_MK19_usarmy_wd","M1220 (CROWS/Mk19)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_M1220_M2_usarmy_wd","M1220 (O-GPK/M2)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_M1220_MK19_usarmy_wd","M1220 (O-GPK/Mk19)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_m1240a1_m2_uik_usarmy_wd","M1240A1 (O-GPK/M2)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_m1240a1_m240_uik_usarmy_wd","M1240A1 (O-GPK/M240)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_m1240a1_mk19_uik_usarmy_wd","M1240A1 (O-GPK/Mk19)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_m1240a1_m2_uik_usarmy_d","M1240A1 (O-GPK/M2)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_m1240a1_m240_uik_usarmy_d","M1240A1 (O-GPK/M240)",800000,1],
	["ADMIN",localize "str_land_militar",localize "str_mrap","rhsusf_m1240a1_mk19_uik_usarmy_d","M1240A1 (O-GPK/Mk19)",800000,1],

	//RHS TANKS
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t15_tv","T-15",3500000,3], //NAO MATA OUTRO TANK
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_sprut_vdv","2S25",4000000,3], //MAIS OU MENOS
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_zsu234_aa","ZSU-23-4",4500000,3], //ANTI AIR
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t72ba_tv","T-72B (obr. 1984g.)",4500000,3], //ANTI AIR
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t80um","T-80UM",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t80bvk","T-80BVK",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t72be_tv","T-72B3 (obr. 2016g.)",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t90_tv","T-90 (obr. 1992g.)",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t90sab_tv","T-90SA (obr. 2016g.)",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhs_t14_tv","T-14",6000000,5],
	//RHS USAF
	["ADMIN",localize "str_land_militar",localize "str_tanks","RHS_M2A2_wd","M2A2ODS",3500000,3],
	["ADMIN",localize "str_land_militar",localize "str_tanks","RHS_M2A2_BUSKI_WD","M2A2ODS (BUSK I)",4000000,3],
	["ADMIN",localize "str_land_militar",localize "str_tanks","RHS_M6_wd","M6A2",4500000,3],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhsusf_m1a1aim_tuski_d","M1A1AIM (TUSK I)",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhsusf_m1a1aim_tuski_wd","M1A1AIM (TUSK I)",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhsusf_m1a2sep1tuskid_usarmy","M1A2SEPv1 (TUSK I)",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhsusf_m1a2sep1tuskiwd_usarmy","M1A2SEPv1 (TUSK I)",5000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhsusf_m1a2sep1tuskiid_usarmy","M1A2SEPv1 (TUSK II)",6000000,5],
	["ADMIN",localize "str_land_militar",localize "str_tanks","rhsusf_m1a2sep1tuskiiwd_usarmy","M1A2SEPv1 (TUSK II)",6000000,5],

	//RHS CIVIL HELIS
	//RHS USAF
	["AIRPORT",localize "str_helicopters",localize "str_civil","RHS_MELB_MH6M","MH-6M Little Bird",600000],

	//RHS LIGHT HELIS
	//RHS USAF
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","RHS_UH60M_d","UH-60M",2500000,4], //2 MACHINEGUNS
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","RHS_MELB_AH6M","AH-6M Little Bird",2500000,4], //2 SMALL ROCKETS LOW AMMO COUNT
	["ADMIN",localize "str_helicopters",localize "str_light_helicopters","RHS_UH1Y_d","UH-1Y (MG)",3500000,4], //2 MACHINES GUNS - 2 SMALL ROCKETS LOW AMMO COUNT

	//RHS MILITAR TRANSPORT HELIS
	//RHS USAF
	["AIRPORT",localize "str_helicopters",localize "str_transport_helicopters","rhsusf_CH53E_USMC_GAU21_D","CH-53E (GAU-21)",1750000], //UNARMED

	//RHS ATTACK HELIS
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_Mi24P_vdv","Mi-24P",6000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_Mi24V_vdv","Mi-24V",6000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_Mi24V_vvs","Mi-24V",6000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_Ka52_vvsc","Ka-52",7000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_Ka52_vvs","Ka-52",7000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","rhs_mi28n_vvsc","Mi-28N",8000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","rhs_mi28n_vvs","Mi-28N",8000000,6],
	//RHS USAF
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_AH1Z","AH-1Z",7000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_AH64D","AH-64D",8000000,6],
	["ADMIN",localize "str_helicopters",localize "str_attack_helis","RHS_AH64DGrey","AH-64D (OIF Grey)",8000000,6],

	//RHS JETS
	["ADMIN",localize "str_planes",localize "str_militar","RHS_Su25SM_vvsc","Su-25",7500000,7],
	["ADMIN",localize "str_planes",localize "str_militar","RHS_Su25SM_vvs","Su-25",7500000,7],
	["ADMIN",localize "str_planes",localize "str_militar","RHS_TU95MS_vvs_old","Tu-95MS6 Bear",50000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","rhs_mig29s_vmf","MiG-29S",10000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","rhs_mig29sm_vvsc","MiG-29SM",10000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","rhs_mig29s_vvs","MiG-29S",10000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","RHS_T50_vvs_blueonblue","T-50 obr. 2013 (055)",12000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","RHS_T50_vvs_054","T-50 obr. 2012 (054)",12000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","RHS_T50_vvs_052","T-50 obr. 2011 (052)",12000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","RHS_T50_vvs_generic_ext","T-50 obr. 2011 (external pylons)",12000000,7],
	//RHS USAF
	["ADMIN",localize "str_planes",localize "str_militar","RHS_A10","A-10A",10000000,7],
	["ADMIN",localize "str_planes",localize "str_militar","rhsusf_f22","F-22A",12000000,7],

	//RHS PLANES CIVIL
	//RHS USAF
	["AIRPORT",localize "str_planes",localize "str_militar","RHS_C130J","C-130J",3500000],

	//RHS APC
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhs_btr60_msv","BTR-60PB",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhs_btr70_msv","BTR-70",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhs_btr80_msv","BTR-80",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhs_btr80a_msv","BTR-80A",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhs_pts_vmf","PTS-M",1000000],
	//RHS USAF
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhsusf_stryker_m1126_mk19_d","M1126 (Mk19)",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhsusf_stryker_m1126_m2_d","M1126 (M2)",2000000,2],
	["ADMIN",localize "str_land_militar",localize "str_wheeled_apc","rhsusf_stryker_m1134_d","M1134",2500000,2],

	//RHS TRUCK
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_kamaz5350_open_vdv","KamAZ-5350 (Open)",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_gaz66o_vdv","GAZ-66 (Open)",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_kraz255b1_flatbed_vdv","KrAZ-255B1 (Flatbed)",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_zil131_flatbed_cover_vdv","ZiL-131 (Flatbed)",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_gaz66_ap2_vdv","GAZ-66-AP-2",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_gaz66_vdv","GAZ-66",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_kamaz5350_vdv","KamAZ-5350",250000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","RHS_Ural_Ammo_VDV_01","Ural-4320 (Ammo)",400000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","RHS_Ural_Fuel_VDV_01","Ural-4320 (Fuel)",300000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","RHS_Ural_Repair_VDV_01","Ural-4320 (Repair)",300000],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","rhs_gaz66_zu23_msv","GAZ-66 (Flatbed)",1500000,2],
	["CIV-MIL",localize "str_land_militar",localize "str_truck","RHS_Ural_Zu23_MSV_01","Ural-4320 (ZU-23-2)",1500000,2],

	//RHS ARTY
	//RHS USAF
	["ADMIN",localize "str_land_militar",localize "str_arty","rhsusf_M142_usarmy_D","M142 HIMARS",12000000,9],
	["ADMIN",localize "str_land_militar",localize "str_arty","rhsusf_M142_usarmy_WD","M142 HIMARS",12000000,9],
	["ADMIN",localize "str_land_militar",localize "str_arty","rhsusf_m109d_usarmy","M109A6",12000000,9],
	["ADMIN",localize "str_land_militar",localize "str_arty","rhsusf_m109_usarmy","M109A6",12000000,9],
	["ADMIN",localize "str_land_militar",localize "str_arty","rhs_9k79_B","9P129-1M (9M79B)",50000000,9],

	//X-66 MAMMOTH
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Green","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Ghex","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_SLA","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Desert","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Nato","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Nato_Pacific","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_us_woodland","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_us_desert","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Gdi","X-66 Mammoth",100000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Snow","X-66 Mammoth",125000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_us_snow","X-66 Mammoth",125000000,9],
	["ADMIN",localize "str_land_militar",localize "str_tanks","HTNK_Grey","X-66 Mammoth",125000000,9]
];