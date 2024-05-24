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

_position = position player;
if (_position select 2 > 1) exitWith {
	"erro" call BRPVP_playSound;
	[localize "str_trader_on_ground",0] call BRPVP_hint;
};
if (vehicle player != player) exitWith {
	"erro" call BRPVP_playSound;
	[localize "str_trader_on_foot",0] call BRPVP_hint;
};
_trader = _this select 3 select 0;
BRPVP_vendaveAtivos = [
	_this select 3 select 1,
	_this select 3 select 2,
	if (count (_this select 3) > 3) then {_this select 3 select 3} else {"default"},
	_this select 3 select 0
];
BRPVP_vendaveNoInsurance = if (count (_this select 3) > 4) then {_this select 3 select 4} else {false};
BRPVP_vendaveBackMenu = if (count (_this select 3) > 5) then {_this select 3 select 5} else {-1};
_menuOpenOk = 13 call BRPVP_iniciaMenuExtra;
if (_menuOpenOk) then {
	BRPVP_actionRunning pushBack 1;
	waitUntil {!(player call BRPVP_pAlive) || player distanceSqr _trader > 400 || !BRPVP_menuExtraLigado};
	if (BRPVP_menuExtraLigado) then {
		BRPVP_menuExtraLigado = false;
		call BRPVP_atualizaDebug;
	};
	BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 1);
} else {
	"erro" call BRPVP_playSound;
};