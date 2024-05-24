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
BRPVP_allowBrpvpHint = true;
BRPVP_specOnMeMachinesNoMe = [];
BRPVP_specOnMeMachines = [clientOwner];
BRPVP_noModToModConvertion = {
	private _class = _this;
	private _classConverted = _class;
	{
		_x params ["_noModClass","_modClass"];
		if (_class isEqualTo _noModClass) exitWith {_classConverted = _modClass;};
	} forEach BRPVP_modNoModRelation;
	_classConverted
};
BRPVP_modToNoModConvertion = {
	private _class = _this;
	private _classConverted = _class;
	{
		_x params ["_noModClass","_modClass"];
		if (_class isEqualTo _modClass) exitWith {_classConverted = _noModClass;};
	} forEach BRPVP_modNoModRelation;
	_classConverted
};
BRPVP_execFast = {
	params ["_nome","_script",["_wait",true],["_vars",-1]];
	if (_wait) then {BRPVP_fsmTerminou = false;};
	[_nome,_script,_vars] execFSM "execucaoPrioritaria.fsm";
	if (_wait) then {waitUntil {BRPVP_fsmTerminou};};
};
BRPVP_classExists = {
	_ic1 = isClass (configFile >> "CfgVehicles" >> _this);
	_ic2 = isClass (configFile >> "CfgMagazines" >> _this);
	_ic3 = isClass (configFile >> "CfgWeapons" >> _this);	
	_ic4 = isClass (configFile >> "CfgGlasses" >> _this);
	_ic5 = _this in BRPVP_specialItems;
	_ic6 = _this isNotEqualTo "BRPVP_mammothAmmo" || {isClass (configFile >> "CfgVehicles" >> "HTNK")};
	_ic1 || _ic2 || _ic3 || _ic4 || (_ic5 && _ic6)
};
BRPVP_stringReplaceParamsArray = ["_str","_sub","_rplc"];
BRPVP_stringReplace = {
	params BRPVP_stringReplaceParamsArray;
	if (_sub isEqualTo _rplc) exitWith {_str};
	private _cntSub = count _sub;
	private _sIdx = 0;
	private _idx = -1;
	while {
		private _idxStringSearch = (_str select [_sIdx,count _str-_sIdx]) find _sub;
		_idx = [_idxStringSearch+_sIdx,-1] select (_idxStringSearch isEqualTo -1);
		_idx isNotEqualto -1
	} do {
		_str = format ["%1%2%3",_str select [0,_idx],_rplc,_str select [_idx+_cntSub,count _str-(_idx+_cntSub)]];
		_sIdx = _idx+count _rplc;
	};
	_str
};

BRPVP_multiPartBuildingsMain = [
	"Land_Carrier_01_base_F",
	"Land_Destroyer_01_base_F"
];
BRPVP_multiPartBuildingsParts = [
	//AIRCRAFT CARRIER
	"Land_Carrier_01_hull_08_2_F",
	"Land_Carrier_01_hull_09_2_F",
	"Land_Carrier_01_hull_03_1_F",
	"Land_Carrier_01_hull_04_1_F",
	"Land_Carrier_01_hull_05_1_F",
	"Land_Carrier_01_hull_06_1_F",
	"Land_Carrier_01_hull_07_1_F",
	"Land_Carrier_01_hull_08_1_F",
	"Land_Carrier_01_hull_09_1_F",
	"Land_Carrier_01_island_01_F",
	"Land_Carrier_01_island_02_F",
	"Land_Carrier_01_island_03_F",
	"Land_Carrier_01_hull_01_F",
	"Land_Carrier_01_hull_02_F",
	"Land_Carrier_01_hull_03_2_F",
	"Land_Carrier_01_hull_04_2_F",
	"Land_Carrier_01_hull_05_2_F",
	"Land_Carrier_01_hull_06_2_F",
	"Land_Carrier_01_hull_07_2_F",
	//DESTROYER
	"Land_Destroyer_01_hull_05_F",
	"Land_Destroyer_01_hull_01_F",
	"Land_Destroyer_01_hull_02_F",
	"Land_Destroyer_01_interior_02_F",
	"Land_Destroyer_01_interior_03_F",
	"Land_Destroyer_01_hull_03_F",
	"Land_Destroyer_01_hull_04_F",
	"Land_Destroyer_01_interior_04_F",
	"Land_Destroyer_01_hull_01_F",
	"Land_Destroyer_01_hull_02_F",
	"Land_Destroyer_01_interior_02_F",
	"Land_Destroyer_01_interior_03_F",
	"Land_Destroyer_01_hull_03_F",
	"Land_Destroyer_01_hull_04_F",
	"Land_Destroyer_01_interior_04_F",
	"Land_Destroyer_01_hull_05_F",
	//AIRPORT
	"Land_Airport_left_F",
	"Land_Airport_center_F",
	"Land_Airport_right_F",
	//HOSPITAL
	"Land_Hospital_side1_F",
	"Land_Hospital_main_F",
	"Land_Hospital_side2_F",
	//HOTEL
	"Land_GH_MainBuilding_left_F",
	"Land_GH_MainBuilding_middle_F",
	"Land_GH_MainBuilding_right_F"
];

BRPVP_extraGodModeHouse = [
	//AIRCRAFT CARRIER
	"Land_Carrier_01_hull_08_2_F",
	"Land_Carrier_01_hull_09_2_F",
	"Land_Carrier_01_hull_03_1_F",
	"Land_Carrier_01_hull_04_1_F",
	"Land_Carrier_01_hull_05_1_F",
	"Land_Carrier_01_hull_06_1_F",
	"Land_Carrier_01_hull_07_1_F",
	"Land_Carrier_01_hull_08_1_F",
	"Land_Carrier_01_hull_09_1_F",
	"Land_Carrier_01_island_01_F",
	"Land_Carrier_01_island_02_F",
	"Land_Carrier_01_island_03_F",
	"Land_Carrier_01_hull_01_F",
	"Land_Carrier_01_hull_02_F",
	"Land_Carrier_01_hull_03_2_F",
	"Land_Carrier_01_hull_04_2_F",
	"Land_Carrier_01_hull_05_2_F",
	"Land_Carrier_01_hull_06_2_F",
	"Land_Carrier_01_hull_07_2_F",
	//DESTROYER
	"Land_Destroyer_01_hull_05_F",
	"Land_Destroyer_01_hull_01_F",
	"Land_Destroyer_01_hull_02_F",
	"Land_Destroyer_01_interior_02_F",
	"Land_Destroyer_01_interior_03_F",
	"Land_Destroyer_01_hull_03_F",
	"Land_Destroyer_01_hull_04_F",
	"Land_Destroyer_01_interior_04_F",
	"Land_Destroyer_01_hull_01_F",
	"Land_Destroyer_01_hull_02_F",
	"Land_Destroyer_01_interior_02_F",
	"Land_Destroyer_01_interior_03_F",
	"Land_Destroyer_01_hull_03_F",
	"Land_Destroyer_01_hull_04_F",
	"Land_Destroyer_01_interior_04_F",
	"Land_Destroyer_01_hull_05_F"
];
BRPVP_VantAiUnits = ["B_UAV_AI","O_UAV_AI","I_UAV_AI","C_UAV_AI"];