BRPVP_shipHelpObjects = [];
{
	_x params ["_class","_array2","_exec"];
	_array2 params ["_posWorld","_vdu"];
	private _obj = createSimpleObject [_class,_posWorld,true];
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld _posWorld;
	if (_exec isNotEqualTo "") then {_obj call compile _exec;};
	BRPVP_shipHelpObjects pushBack _obj;
} forEach [
	["Land_Pier_F",[[15860.31,12485.708,-2.318],[[0.0472414,0.998883,0],[0,0,1]]],""],
	["Land_Pier_F",[[15818.65,12487.679,-2.318],[[0.0472414,0.998883,0],[0,0,1]]],""],
	["Land_Pier_F",[[14755.358,12698.07,-2.324],[[0.365173,0.93094,0],[0,0,1]]],""],
	["Land_Pier_F",[[14716.535,12713.292,-2.324],[[0.365173,0.93094,0],[0,0,1]]],""],
	["Land_Pier_F",[[15860.309,12494.697,-2.32],[[-0.0472418,-0.998883,0],[0,0,1]]],""],
	["Land_Pier_F",[[15818.66,12496.666,-2.32],[[-0.0472418,-0.998883,0],[0,0,1]]],""],
	["Land_Pier_F",[[14755.865,12699.843,-2.322],[[-0.353211,-0.935544,0],[0,0,1]]],""],
	["Land_Pier_F",[[14716.851,12714.573,-2.322],[[-0.353211,-0.935544,0],[0,0,1]]],""]
];

BRPVP_shipHelpOnNoShipVehicle = {{_x hideObject false;} forEach BRPVP_shipHelpObjects;};
BRPVP_shipHelpOnShipVehicle = {{_x hideObject true;} forEach BRPVP_shipHelpObjects;};
