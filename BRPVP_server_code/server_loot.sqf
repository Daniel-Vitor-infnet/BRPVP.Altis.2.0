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

scriptName "BRPVP LOOT MONITOR";

BRPVP_lootActive = [];
BRPVP_lootActiveAdd = {
	params ["_obj","_repeat"];
	if (_obj getVariable ["brpvp_loot_repeat",-1] isEqualto -1) then {_obj setVariable ["brpvp_loot_repeat",_repeat,false];};
	if (_obj getVariable ["ml_lock_until",0] isEqualTo 0) then {_obj setVariable ["ml_lock_until",time+60,false];};
	BRPVP_lootActive pushBack _obj;
};
private _ini = time;
BRPVP_serverLootCheck = {
	diag_log ("[BRPVP ACTIVE LOOT] count BRPVP_lootActive = "+str count BRPVP_lootActive+".");
	_lootActive_remove = [];
	{
		_build = _x;
		if (_t > _build getVariable "ml_lock_until") then {
			_noNearPlayers = _build nearEntities [BRPVP_playerModel,250] isEqualTo [];
			_waited = _build getVariable ["ml_wtd",false];
			if (_waited) then {
				_build setVariable ["ml_lock_until",-1,true];
				_build setVariable ["ml_wtd",false,false];
				_lootActive_remove pushBack _forEachIndex;
			} else {
				if (_noNearPlayers) then {
					_repeat = _build getVariable "brpvp_loot_repeat";
					_dirSeed = round getDir _build;
					_allBPos = count (_build buildingPos -1);
					_step = 1;
					_used = 0;
					for "_i" from 0 to (_repeat-1) do {
						_holder = objNull;
						_takes = 0;
						_bPosIdx = (_dirSeed+_i*_step) mod _allBPos;
						{
							_takes = _x getVariable ["ml_takes",-1];
							if (_takes > -1) exitWith {_holder = _x;};
						} forEach (_build buildingPos _bPosIdx nearObjects ["groundWeaponHolder",1]);
						if (_takes > 0 || isNull _holder) then {_used = _used+1;};
						if (!isNull _holder) then {deleteVehicle _holder;};
					};
					if (_used/_repeat < 0.5) then {
						_build setVariable ["ml_lock_until",-1,true];
						_build setVariable ["ml_wtd",false,false];
						_lootActive_remove pushBack _forEachIndex;
					} else {
						_build setVariable ["ml_lock_until",_t+BRPVP_renewLootTime,false];
						_build setVariable ["ml_wtd",true,false];
					};
				};
			};
		};
	} forEach BRPVP_lootActive;
	reverse _lootActive_remove;
	{BRPVP_lootActive deleteAt _x;} forEach _lootActive_remove;
};
waitUntil {
	_t = time;
	if (_t-_ini > 60) then {
		_ini = _t;
		isNil {call BRPVP_serverLootCheck;};
	};
	false
};