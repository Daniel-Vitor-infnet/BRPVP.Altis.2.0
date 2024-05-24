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

private ["_name"];
BRPVP_actionRunning pushBack 17;
(_this select 3) params ["_obj","_isMyBase"];
BRPVP_sendObjectOwnerNameFromDBReturn = nil;
[_obj getVariable "own",player] remoteExecCall ["BRPVP_sendObjectOwnerNameFromDB",2];
waitUntil {!isNil "BRPVP_sendObjectOwnerNameFromDBReturn"};
_name = BRPVP_sendObjectOwnerNameFromDBReturn;
if (BRPVP_vePlayers || _isMyBase) then {
	[format[localize "str_object_owner_name",_name],-6] call BRPVP_hint;
} else {
	_sounder = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],10,"CAN_COLLIDE"];
	_sounder attachTo [player,[0,0,0]];
	[_sounder,["identifier",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
	_init = time;
	_pos = ASLToAGL getPosASL player;
	waitUntil {time-_init >= 5 || player distance _pos > 5 || !(player call BRPVP_pAlive)};
	_sounder setDamage 1;
	detach _sounder;
	deleteVehicle _sounder;
	if (player distance _pos > 5 || !(player call BRPVP_pAlive)) then {
		[localize "str_identifier_failed",-5,200,0,"erro"] call BRPVP_hint;
	} else {
		[format[localize "str_object_owner_name",_name],-6] call BRPVP_hint;
		[42,1] call BRPVP_sitRemoveItem;
	};
};
sleep 1;
BRPVP_actionRunning = BRPVP_actionRunning-[17];