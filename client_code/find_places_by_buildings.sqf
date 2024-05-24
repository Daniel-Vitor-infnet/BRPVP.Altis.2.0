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
diag_log "[SCRIPT] find_places_by_buildings.sqf BEGIN";

private ["_minToConsider"];
if (isNil "BRPVP_militarBuildingsMarker") then {
	BRPVP_militarBuildingsMarker = [];
	_minToConsider = 3;
	_nearToSame = 100;
	_militarBuildingsGroups = [];
	_militarBuildings = nearestObjects [BRPVP_centroMapa,BRPVP_cantBuildNearBuildings,20000];
	_del = [];
	{if (_x getVariable ["id_bd",-1] != -1) then {_del pushBack _x;};} forEach +_militarBuildings;
	_militarBuildings = _militarBuildings - _del;
	while {count _militarBuildings > 0} do {
		_oldGroup = [];
		_newGroup = [_militarBuildings select 0];
		while {count _newGroup != count _oldGroup} do {
			_newGroupAdd = [];
			{
				_del = [];
				_nearMil = nearestObjects [_x,BRPVP_cantBuildNearBuildings,_nearToSame];
				{if (_x getVariable ["id_bd",-1] != -1) then {_del pushBack _x;};} forEach +_nearMil;
				_nearMil = _nearMil - _del;
				_newGroupAdd append _nearMil;
			} forEach (_newGroup - _oldGroup);
			_oldGroup = +_newGroup;
			_newGroupAdd = _newGroupAdd arrayIntersect _newGroupAdd;
			_newGroup = (_newGroup - _newGroupAdd) + _newGroupAdd;
		};
		_militarBuildingsGroups pushBack _newGroup;
		_militarBuildings = _militarBuildings - _newGroup;
	};
	{
		_group = _x;
		_center = [0,0,0];
		_diameter = -1;
		_count = count _group;
		{
			_buildingA = _x;
			{
				_buildingB = _x;
				_dist = _buildingA distance2D _buildingB;
				if (_dist > _diameter) then {
					_diameter = _dist;
					_center = (getPosWorld _buildingA vectorAdd getPosWorld _buildingB) vectorMultiply 0.5;
				};
			} forEach _group;
		} forEach _group;
		_diameter = if (_count isEqualTo 1) then {10} else {_diameter};
		BRPVP_militarBuildingsMarker pushBack [_center,_diameter/1.85,_count];
	} forEach _militarBuildingsGroups;
	diag_log "==== BRPVP_militarBuildingsMarker ======================";
	{diag_log (str _x + ",");} forEach BRPVP_militarBuildingsMarker;
	diag_log "========================================================";
} else {
	_minToConsider = 1;
};
_index = 0;
{
	_x params ["_center","_radius","_count"];
	if (_count >= _minToConsider) then {
		//CIRCLE
		_marca = createMarkerLocal ["MILAREA_AREA_" + str _index,_center];
		_marca setMarkerShapeLocal "ELLIPSE";
		_marca setMarkerSizeLocal [_radius,_radius];
		_marca setMarkerColorLocal "ColorBlue";
		_marca setMarkerAlphaLocal 0.5;
		//TEXT
		_marca = createMarkerLocal ["MILAREA_TXT_" + str _index,_center];
		_marca setMarkerShapeLocal "Icon";
		_marca setMarkerTypeLocal "mil_dot";
		_marca setMarkerColorLocal "ColorWhite";
		_marca setMarkerTextLocal ("X " + str _count);
		_marca setMarkerAlphaLocal 0.4;
		_index = _index + 1;
	};
} forEach BRPVP_militarBuildingsMarker;

diag_log ("[SCRIPT] find_places_by_buildings.sqf END: " + str round (diag_tickTime - _scriptStart));