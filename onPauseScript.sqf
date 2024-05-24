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

if ((player getVariable ["dd",-1]) isEqualTo 0) then {player setVariable ["dd",1,true];};
player setVariable ["brpvp_on_esc",true,[clientOwner,2]];

//SAVE EACH 5 SECONDS WHILE IN ESC
missionNameSpace setVariable ["BRPVP_pfl_hdb_saveProfileName",true];
_this spawn {
	private _init = time;
	waitUntil {
		if (time-_init > 5) then {
			_init = time;
			missionNameSpace setVariable ["BRPVP_pfl_hdb_saveProfileName",true];
		};
		isNull (_this select 0)
	};
};

waitUntil {isNull (_this select 0)};
waitUntil {!isNull findDisplay 46};
player setVariable ["brpvp_on_esc",false,[clientOwner,2]];