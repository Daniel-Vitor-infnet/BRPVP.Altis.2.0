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

BRPVP_actionRunning pushBack 3;
_car = _this select 3 select 0;
[_car,15] call BRPVP_enableVehOnInteraction;
BRPVP_checkCraneFinished = false;
((_this select 3)+[player,clientOwner]) remoteExecCall ["BRPVP_desviraVeiculo",2];
_init = time;
waitUntil {BRPVP_checkCraneFinished};
sleep 1;
if (alive _car) then {if !(_car getVariable ["slv",false]) then {_car setVariable ["slv",true,true]};};
BRPVP_actionRunning deleteAt (BRPVP_actionRunning find 3);