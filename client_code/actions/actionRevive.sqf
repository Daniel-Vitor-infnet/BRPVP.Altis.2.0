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

BRPVP_allowBrpvpHint = false;
BRPVP_actionRunning pushBack 2;
_disabledPlayer = _this select 3;
for "_c" from 6 to 1 step -1 do {
	[format [localize "str_revive_in",_c],0,200,0,"ciclo",true] call BRPVP_hint;
	uiSleep 1;
	if (player distance _disabledPlayer > 5) exitWith {
		[localize "str_revive_canceled"] call BRPVP_hint;
		"erro" call BRPVP_playSound;
		uiSleep 1;
	};
	if (_disabledPlayer getVariable ["dd",0] > 0) exitWith {
		[localize "str_revive_died"] call BRPVP_hint;
		uiSleep 1;
	};
	if (_c isEqualTo 1) exitWith {
		if (_disabledPlayer getVariable ["dd",-1] isEqualTo 0) then {
			_disabledPlayer setVariable ["dd",2,true];
			[localize "str_revive_ok"] call BRPVP_hint;
		} else {
			[localize "str_revive_died"] call BRPVP_hint;
		};
		uiSleep 1;
	};
};
BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 2);
BRPVP_allowBrpvpHint = true;