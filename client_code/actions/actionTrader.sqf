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

(_this select 3) params ["_merchant","_merchantIndex","_precoMult",["_itemFilter",0],["_deployMode","default"],["_menu",115]];
_position = position player;
if (_position select 2 > 1) exitWith {
	"erro" call BRPVP_playSound;
	[localize "str_trader_on_ground",0] call BRPVP_hint;
};
if (vehicle player != player) exitWith {
	"erro" call BRPVP_playSound;
	[localize "str_trader_on_foot",0] call BRPVP_hint;
};
if (typeName _merchantIndex == "SCALAR") then {
	_merchantTypesAmount = count BRPVP_mercadoresEstoque;
	_merchantIndex = _merchantIndex mod _merchantTypesAmount;
	BRPVP_merchantItems = BRPVP_mercadoresEstoque select _merchantIndex select 0;
} else {
	BRPVP_merchantItems = _merchantIndex;
};
BRPVP_marketPrecoMult = _precoMult;
BRPVP_marketItemFilter = _itemFilter;
BRPVP_marketDeployMode = _deployMode;
BRPVP_compraPrecoTotal = 0;
BRPVP_compraItensTotal = [];
BRPVP_compraItensPrecos = [];
_menuOpenOk = _menu call BRPVP_iniciaMenuExtra;
if (_menuOpenOk) then {
	BRPVP_actionRunning pushBack 0;
	waitUntil {!(player call BRPVP_pAlive) || player distanceSqr _merchant > 400 || !BRPVP_menuExtraLigado};
	if (BRPVP_menuExtraLigado) then {
		BRPVP_menuExtraLigado = false;
		call BRPVP_atualizaDebug;
	};
	BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 0);
} else {
	"erro" call BRPVP_playSound;
};