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

BRPVP_actionRunning append [7,16];
_obj = _this select 3;
_isFlagProtected = _obj call BRPVP_checkIfFlagProtected;
if (!_isFlagProtected) then {
	[_obj,true] call BRPVP_removeObject;
	waitUntil {isNull _obj};
};
sleep 1;
BRPVP_actionRunning = BRPVP_actionRunning - [7,16];