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

_suitCase = _this select 3;
[player,_suitCase] remoteExecCall ["BRPVP_getSuitCase",2];
if (_suitCase isEqualType objNull && {!isNull _suitCase && typeOf _suitCase isEqualTo "Land_Suitcase_F"}) then {[["maleta",1]] call BRPVP_mudaExp;};
"negocio" call BRPVP_playSound;

//REVEAL IF POSSESSING
private _mny = _suitCase getVariable ["mny",1000000];
if (_mny >= 1000000 && player getVariable ["brpvp_possessing_other",false]) then {BRPVP_possBadAction = time;};

sleep 0.25;
deleteVehicle _suitCase;