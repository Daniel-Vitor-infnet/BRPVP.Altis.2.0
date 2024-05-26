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
///------------------------Clássicos
    ["ADMIN",localize "staff",localize "classicos","EM_Police_CrownVic","CrownVic",0],
	["ADMIN",localize "staff",localize "classicos","EM_Police_Charger","Charger",0],
	["ADMIN",localize "staff",localize "classicos","EM_Police_Explorer","Explorer",0],
	["ADMIN",localize "staff",localize "classicos","EM_Police_Taurus","Taurus",0],
///------------------------Esportivos
    ["ADMIN",localize "staff",localize "esportivos","EM_Police_BMWM5","M5",0],
	["ADMIN",localize "staff",localize "esportivos","EM_Police_BMWX6","X6",0],
	["ADMIN",localize "staff",localize "esportivos","EM_Police_Civic","Civic",0],
	["ADMIN",localize "staff",localize "esportivos","EM_Malibu","Malibu",0],
///------------------------Pesados	
	["ADMIN",localize "staff",localize "pesados","EM_Police_Savana","Savana",0],
	["ADMIN",localize "staff",localize "pesados","EM_Police_Raptor","Raptor",0],
	["ADMIN",localize "staff",localize "pesados","EM_Police_F550_SWAT","F550",0],
	["ADMIN",localize "staff",localize "pesados","EM_Police_Insurgent","Insurgent",0],
///------------------------Descaracterizados
    ["ADMIN",localize "staff",localize "descaracterizados","EM_Police_Raptor_UM","Raptor",0],
	["ADMIN",localize "staff",localize "descaracterizados","EM_Police_Explorer_UM","Explorer",0],
	["ADMIN",localize "staff",localize "descaracterizados","EM_Police_Taurus_UM","Taurus",0],
	["ADMIN",localize "staff",localize "descaracterizados","EM_Police_BMWX6_UM","X6",0],
	["ADMIN",localize "staff",localize "descaracterizados","EM_Malibu_UM","X6",0],
///------------------------Helicópteros
	["ADMIN",localize "staff",localize "helicoptero","EM_Police_EC635","EC635",0]
];