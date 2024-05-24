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

if (isNull objectParent player) then {
	_posPlayer = ASLToAGL getposASL player;
	_dirPlayer = getDir player;
	_posBox = [(_posPlayer select 0)+2*sin _dirPlayer,(_posPlayer select 1)+2*cos _dirPlayer,_posPlayer select 2];
	_box = createVehicle ["Box_NATO_Wps_F",_posBox,[],0,"CAN_COLLIDE"];
	_box allowDamage false;
	_box setDir getDir player;
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearBackPackCargoGlobal _box;
	clearItemCargoGlobal _box;
	_box setVariable ["own",player getVariable "id_bd",true];
	_box setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
	_box setVariable ["stp",0,true];
	_arrow = "Sign_Arrow_F" createVehicle BRPVP_posicaoFora;
	_arrow attachTo [_box,[0,0,1]];
	BRPVP_sellReceptacle = _box;
	BRPVP_sellStage = 2;
} else {
	[localize "str_coll_in_veh",0] call BRPVP_hint;
};