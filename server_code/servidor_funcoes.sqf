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

_scriptStart = diag_tickTime;
diag_log "[SCRIPT] servidor_funcoes.sqf BEGIN";

BRPVP_missionStartEndExplodeLocalMines = {
	_this remoteExecCall ["triggerAmmo",owner _this];
};
BRPVP_fortDefendSpawnZombieHC = {
	private _zombies = [_this,selectRandom [0,1,1]] call BRPVP_spawnZombiesServerFromClientInFront;
	private _code = {BRPVP_fortDefendZombieAll append _this;};
	[_zombies,_code] remoteExecCall ["call",2];
};
BRPVP_eventsInitiateFromServer = {
	private _pos = BRPVP_eventsData select _this select 0;
	private _rad = BRPVP_eventsData select _this select 1;
	private _mines = nearestObjects [_pos,BRPVP_zombieDistractAmmo,_rad];
	if (_mines isNotEqualTo []) then {
		_mines spawn {
			private _mines = _this;
			{
				private _mine = _x;
				_mine remoteExecCall ["triggerAmmo",owner _mine];
				uiSleep random 0.25;
			} forEach _mines;
		};
	};
	_objs = call compile preprocessFileLineNumbers (BRPVP_eventsObjsSQF select _this);
	[_this,_objs] remoteExec [BRPVP_eventsDataCodeOn select _this,2];
};
BRPVP_updateAIUnitsArray = {
	BRPVP_missBotsEm = BRPVP_missBotsEm-[objNull];
	BRPVP_missBotsEm append _this;
	publicVariable "BRPVP_missBotsEm";
};
BRPVP_AIRemoveNull = {
	BRPVP_missBotsEm = BRPVP_missBotsEm-[objNull];
};
BRPVP_fortDefendAddReward = {
	BRPVP_fortDefendRewardCycleSum = BRPVP_fortDefendRewardCycleSum+_this;
};
BRPVP_botKillLoot = {
	private ["_aI","_iI"];
	_aI = assignedItems _this;
	{
		if (_x in _aI) then {_this unassignItem _x;};
		_iI = items _this;
		if (_x in _iI) then {_this removeItems _x;};
	} forEach BRPVP_botKillRemove;
};

diag_log ("[SCRIPT] servidor_funcoes.sqf END: " + str round (diag_tickTime - _scriptStart));