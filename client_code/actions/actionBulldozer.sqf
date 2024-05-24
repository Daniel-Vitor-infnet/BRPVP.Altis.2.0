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

BRPVP_actionRunning pushBack 8;
_price = if (BRPVP_vePlayers) then {0} else {_this select 3 select 0};
_money = player getVariable "mny";
if (_money >= _price) then {
	_ruins = _this select 3 select 1;

	//REMOVE CARRY HELI ACTION IF HELI EXPLODED AND GET CLEANED WITH DRIVER INSIDE
	if (_ruins call BRPVP_isMotorized) then {
		private _crew = crew _ruins;
		if (_crew isNotEqualTo []) then {
			_ruins remoteExecCall ["BRPVP_removeActionBeforeVehDel",_crew select {!(_x getVariable ["brpvp_ai",false])}];
		};
	};

	playSound3D [BRPVP_playSound3dPrefix+"BRP_sons\bulldozer.ogg",_ruins,false,getPosASL _ruins,1,1,800];
	sleep 2.6;
	_ruins remoteExecCall ["BRPVP_removeRuins",_ruins];
	sleep 0.25;
	if (isNull _ruins) then {
		player setVariable ["mny",_money-_price,true];
		if (_price > 0) then {"negocio" call BRPVP_playSound;};
	} else {
		"erro" call BRPVP_playSound;
	};
} else {
	"erro" call BRPVP_playSound;
	[localize "str_no_money",0] call BRPVP_hint;
};
BRPVP_actionRunning = BRPVP_actionRunning-[8];

