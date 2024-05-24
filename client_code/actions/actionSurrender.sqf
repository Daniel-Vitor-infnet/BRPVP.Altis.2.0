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

BRPVP_actionRunning pushBack 11;
_unit = _this select 3;
BRPVP_surrended = _unit;
_unit setVariable ["brpvp_surrendedBy",player,true];
_hey = ["hey_1.ogg","hey_2.ogg","hey_3.ogg"] call BIS_fnc_selectRandom;
playSound3D [BRPVP_playSound3dPrefix+"BRP_sons\"+_hey,player,false,getPosASL player,1,1,200];
player remoteExec ["BRPVP_clientStillSurrendedCheck",_unit];
_timeOff = 0;
waitUntil {
	sleep 0.25;
	_dirTo = [player,_unit] call BIS_fnc_dirTo;
	_dirPlayer = getDir player;
	_diffDir = abs(_dirTo-_dirPlayer);
	_diffDir = _diffDir min (360-_diffDir);
	_onAin = _diffDir <= 30;
	if !(_onAin) then {_timeOff = _timeOff+0.25;} else {_timeOff = 0;};
	_currentWeapon = currentWeapon player;
	_weaponOnHand = _currentWeapon != "" && !(_currentWeapon in BRPVP_binocularToIgnoreAsWeapon);
	!_weaponOnHand || _timeOff > 2 || player distance _unit > 10 || !(_unit call BRPVP_pAlive) || !(player call BRPVP_pAlive) || !isNull (player getVariable ["brpvp_surrendedBy",objNull]) || isNull (_unit getVariable ["brpvp_surrendedBy",objNull])
};
_unit setVariable ["brpvp_surrendedBy",objNull,true];
BRPVP_surrended = objNull;
BRPVP_actionRunning = BRPVP_actionRunning-[11];