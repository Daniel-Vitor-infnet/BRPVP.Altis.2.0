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

//GLOBAL VARS
BRPVP_randomBoxInMap = [];

//CITIES BOXES
private _maxBoxes = BRPVP_randomBoxCitiesQtt;
private _boxesChance = [1,1,1,2];
private _count = 0;
private _randomBoxInMap = [];
{
	private _pos = _x select 0;
	private _rad = 0.4*(_x select 1) max 65;
	private _bc = selectRandom _boxesChance;
	if (nearestObjects [_pos,["FlagCarrier"],350,true] isEqualTo []) then {
		for "_i" from 1 to _bc do {
			private _placeTry = [_pos,0,_rad,5,0,0.35,0,[],[[0,0],[0,0]]] call BIS_fnc_findSafePos;
			if (_placeTry isNotEqualTo [0,0]) then {
				private _box = createVehicle ["Box_NATO_Equip_F",_placeTry,[],1,"CAN_COLLIDE"];
				_box setVariable ["brpvp_del_when_empty",true,true];
				private _params = [_box,selectRandom [250000,500000],selectRandom [1,2,2,3],true,selectRandom [5,10,15,20],1];
				_params call BRPVP_createCompleteLootBox;
				_randomBoxInMap pushBack _box;
				_count = _count+1;
			};
			if (_count isEqualTo _maxBoxes) exitWith {};
		};
	};
	if (_count isEqualTo _maxBoxes) exitWith {};
} forEach (BRPVP_locaisImportantes call BIS_fnc_arrayShuffle);
BRPVP_randomBoxInMap pushBack _randomBoxInMap;

//MILITAR AREA BOXES
_maxBoxes = BRPVP_randomBoxMilitarAreasQtt;
_boxesChance = [2,2,3];
_count = 0;
_randomBoxInMap = [];
{
	private _pos = _x select 0;
	private _rad = _x select 1;
	private _bc = selectRandom _boxesChance;
	if (nearestObjects [_pos,["FlagCarrier"],350,true] isEqualTo []) then {
		for "_i" from 1 to _bc do {
			private _placeTry = [_pos,0,_rad,5,0,0.35,0,[],[[0,0],[0,0]]] call BIS_fnc_findSafePos;
			if (_placeTry isNotEqualTo [0,0]) then {
				private _box = createVehicle ["Box_NATO_Equip_F",_placeTry,[],1,"CAN_COLLIDE"];
				_box setVariable ["brpvp_del_when_empty",true,true];
				private _params = [_box,selectRandom [250000,500000],selectRandom [1,2,2,3],true,selectRandom [5,10,15,20],1];
				_params call BRPVP_createCompleteLootBox;
				_randomBoxInMap pushBack _box;
				_count = _count+1;
			};
			if (_count isEqualTo _maxBoxes) exitWith {};
		};
	};
	if (_count isEqualTo _maxBoxes) exitWith {};	
} forEach (BRPVP_militarBuildingsMarker call BIS_fnc_arrayShuffle);
BRPVP_randomBoxInMap pushBack _randomBoxInMap;

//CUSTOM PLACES BOXES
_maxBoxes = BRPVP_randomBoxCustomPlacesQtt;
_count = 0;
_randomBoxInMap = [];
{
	private _pos = ASLToAGL _x;
	if (nearestObjects [_pos,["FlagCarrier"],350,true] isEqualTo []) then {
		private _box = createVehicle ["Box_NATO_Equip_F",_pos,[],1,"CAN_COLLIDE"];
		_box setVariable ["brpvp_del_when_empty",true,true];
		private _params = [_box,selectRandom [250000,500000],selectRandom [1,2,2,3],true,selectRandom [5,10,15,20],1];
		_params call BRPVP_createCompleteLootBox;
		_randomBoxInMap pushBack _box;
		_count = _count+1;
	};
	if (_count isEqualTo _maxBoxes) exitWith {};	
} forEach (BRPVP_randomBoxCustomPlaces call BIS_fnc_arrayShuffle);
BRPVP_randomBoxInMap pushBack _randomBoxInMap;

publicVariable "BRPVP_randomBoxInMap";