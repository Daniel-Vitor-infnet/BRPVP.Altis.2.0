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

BRPVP_actionRunning pushBack 2;
BRPVP_allowBrpvpHint = false;
_disabledPlayer = _this select 3;
for "_c" from 6 to 1 step -1 do {
	[format [localize "str_finalize_count",_c],0,200,0,"ciclo",true] call BRPVP_hint;
	uiSleep 1;
	if (player distance _disabledPlayer > 5) exitWith {
		[localize "str_finalize_fail"] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		uiSleep 1;
	};
	if (_disabledPlayer getVariable ["dd",0] > 0) exitWith {uiSleep 1;};
	if (_c isEqualTo 1) exitWith {
		if (_disabledPlayer getVariable ["dd",-1] isEqualTo 0) then {_disabledPlayer setVariable ["dd",1,true];};
		uiSleep 1;
	};
};
BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 2);
BRPVP_allowBrpvpHint = true;