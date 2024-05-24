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

//FORT DEFEND MISSION REMOVE STUFF
{
	_obj = _x;
	_noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
	if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {_x hideObjectGlobal true;};
} forEach nearestObjects [BRPVP_defendFortCenter,[],35,true];

//TRAVEL AID HANGARS
{
	_x params ["_class","_pos","_vdu"];
	_obj = createVehicle [_class,[0,0,0],[],0,"CAN_COLLIDE"];
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld _pos;
} forEach [
	["Land_Airport_01_hangar_F",[21527.072,19064.801,25.182],[[-0.442814,-0.896614,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[19597.33,14891.804,20.158],[[-0.595358,0.803461,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[10808.628,9225.917,42.413],[[-0.994298,-0.106639,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[7429.398,11241,17.062],[[-0.644043,-0.764989,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[2689.821,9987.108,17.836],[[-0.584471,-0.811415,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[10002.005,17090.994,88.313],[[-0.545376,-0.838192,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[13608.941,20496.014,38.542],[[-0.108806,-0.994063,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[5188.813,20117.344,243.177],[[0.314556,-0.949239,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[20215.164,8187.555,44.623],[[0.816744,-0.577,0],[0,0,1]]],
	["Land_Airport_01_hangar_F",[27308.502,22025.25,35.331],[[0.785625,-0.618703,0],[0,0,1]]]
];