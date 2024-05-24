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

BRPVP_actionRunning pushBack 9;
BRPVP_connectionOn = true;
_antenna = _this select 3 select 0;
_force = _this select 3 select 1;
(_force + [_antenna,3]) call BRPVP_radarAdd;
_distance = (str (_force select 0)) + " meters";
_errorPercentage = (str round (100 * (_force select 1))) + " %";
_cycle = (str (_force select 2)) + " secs";
[format [localize "str_radar_info",_distance,_errorPercentage,_cycle],6,15,6774] call BRPVP_hint;
waitUntil {[player,_antenna] call PDTH_distance2BoxQuad  > 10000 || isNull _antenna || !BRPVP_connectionOn};
[localize "str_radar_deactived",6,15,6774] call BRPVP_hint;
3 call BRPVP_radarRemove;
BRPVP_actionRunning = BRPVP_actionRunning - [9];
