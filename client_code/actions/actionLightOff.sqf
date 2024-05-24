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

_lamp = _this select 3;
if (netId _lamp isEqualTo "0:0") then {
	if (typeOf _lamp in BRPVP_buildingHaveDoorListCVL) then {
		[typeOf _lamp,_lamp getVariable ["id_bd",-1],false] remoteExecCall ["BRPVP_saveLightStateDbsimpleObjectCVL",0];
	} else {
		//DO NOTHING IF LAMP IS LOCAL SIMPLE OBJECT
	};
} else {
	if (isSimpleObject _lamp) then {
		//DO NOTHING IF LAMP IS SIMPLE OBJECT
	} else {
		[_lamp,_lamp getVariable ["id_bd",-1],false] remoteExecCall ["BRPVP_saveLightStateDbsimpleObject",2];
	};
};