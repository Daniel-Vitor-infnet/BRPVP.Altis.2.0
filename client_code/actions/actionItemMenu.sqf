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

BRPVP_actionRunning pushBack 7;
BRPVP_stuff = _this select 3;
_ok = 22 call BRPVP_iniciaMenuExtra;
if (_ok) then {
	waitUntil {!BRPVP_menuExtraLigado};
};
BRPVP_actionRunning = BRPVP_actionRunning - [7];