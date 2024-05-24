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

player removeAction BRPVP_actionDropItems;
_weaponHolder = createVehicle ["GroundWeaponHolder",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
_weaponHolder addItemCargo ["ItemMap",1];
player removeWeapon "ItemMap";
_helipad = createVehicle ["Land_HelipadEmpty_F",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
[_helipad,"backpack",50] call BRPVP_playSoundAllCli;
[player,_weaponHolder,-2,[1,6.5],{!isNull (player getVariable "brpvp_surrendedBy")}] call BRPVP_transferUnitCargo;
_helipad setDamage 1;
deleteVehicle _helipad;