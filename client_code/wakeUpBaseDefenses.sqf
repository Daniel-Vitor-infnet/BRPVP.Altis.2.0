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

BDW_initA = -100;
BDW_initABool = true;
BDW_initBBool = true;
BDW_allFlagsNearA = [];
BDW_allFlagsNearB = [];
BDW_wakeUpFlags = [];
BDW_lastAdd = [];
BDW_lastRemove = [];
BDW_forceUpdate = false;
BRPVP_sleepRounds = false;
BRPVP_sleepRoundsSet = {
	if (_this isEqualTo "add_not_ready") then {
		BDW_wakeUpFlags = BDW_wakeUpFlags-BDW_lastAdd;
		BRPVP_sleepRounds = false;
	} else {
		if (_this isEqualTo "remove_not_ready") then {
			BDW_wakeUpFlags = BDW_wakeUpFlags+BDW_lastRemove;
			BRPVP_sleepRounds = false;
		} else {
			if (_this isEqualTo "force_update") then {BDW_forceUpdate = true;} else {BRPVP_sleepRounds = _this;};
		};
	};
};
BRPVP_wakeUpBaseDefenses = {
	if (!BRPVP_sleepRounds && BDW_initBBool) then {
		_wakeUpFlagsNow = [];
		if (player getVariable ["sok",false] && !isObjectHidden player) then {
			if (time-BDW_initA > 5 || BDW_forceUpdate) then {
				if (BDW_initABool || BDW_forceUpdate) then {
					private _allFlags = (BRPVP_allFlags arrayIntersect BRPVP_allFlags)-[objNull];
					BDW_allFlagsNearA = [];
					{if (player distance _x < 5000) then {BDW_allFlagsNearA pushBack _x;};} forEach _allFlags;
				};
				BDW_initABool = !BDW_initABool;
			};
			if (time-BDW_initA > 5 || BDW_forceUpdate) then {
				BDW_allFlagsNearB = [];
				{if (player distance _x < 2500) then {BDW_allFlagsNearB pushBack _x;};} forEach BDW_allFlagsNearA;
				BDW_initA = time;
			};
			{
				private _dist = player distance _x;
				private _isOn = _x in BDW_wakeUpFlags;
				if (_isOn && _dist <= 1000) then { //200+750+50
					private _rad = _x call BRPVP_getFlagRadius;
					private _extraRad = if ([player,_x] call BRPVP_checaAcessoRemotoFlag) then {5} else {750};
					if (_dist <= _rad+_extraRad) then {_wakeUpFlagsNow pushBack _x};
				} else {
					if (!_isOn && _dist <= 750) then { //200+500+50
						private _rad = _x call BRPVP_getFlagRadius;
						private _friend = [player,_x] call BRPVP_checaAcessoRemotoFlag;
						private _extraRad = if (_friend) then {
							_x setVariable ["brpvp_flag_act_def_time",time+60];
							5
						} else {
							_x setVariable ["brpvp_flag_act_def_time",time+BRPVP_turretSpawnMinTime];
							500
						};
						if (_dist <= _rad+_extraRad) then {_wakeUpFlagsNow pushBack _x};
					};
				};
			} forEach BDW_allFlagsNearB;
			_wakeUpFlagsNow = _wakeUpFlagsNow apply {if (isObjectHidden _x) then {-1} else {_x};};
			_wakeUpFlagsNow = _wakeUpFlagsNow-[-1];
			{if (time <= _x getVariable ["brpvp_flag_act_def_time",0]) then {_wakeUpFlagsNow pushBackUnique _x;};} forEach BDW_wakeUpFlags;
		};
		private _add = _wakeUpFlagsNow-BDW_wakeUpFlags;
		private _remove = BDW_wakeUpFlags-(_wakeUpFlagsNow+[objNull]);
		private _changed = false;
		BDW_lastAdd = [];
		BDW_lastRemove = [];
		if (_add isNotEqualTo []) then {
			private _addT = [];
			private _interAdd = [];
			{
				private _flag = _x;
				private _fRad = _flag call BRPVP_getFlagRadius;
				{
					private _ti = _x;
					private _inFlag = (_ti select 2) distance2D _flag <= _fRad;
					if (_inFlag) then {
						private _isActBef = {(_ti select 2) distance2D (getPosWorld _x) <= _x call BRPVP_getFlagRadius} count BDW_wakeUpFlags > 0;
						if (!_isActBef) then {_addT pushBackUnique _ti;};
					};
				} forEach BRPVP_allTurretsInfo;
				{_interAdd pushBackUnique _x;} forEach (_flag call BRPVP_getIntersectFlags);
			} forEach _add;
			_addT = _addT apply {[player distance (_x select 2),_x]};
			_addT sort true;
			_addT = _addT apply {_x select 1};
			_interAdd = _interAdd apply {_x getVariable "id_bd";};
			if (_addT isNotEqualTo []) then {
				[clientOwner,_interAdd,_addT] remoteExecCall ["BRPVP_turretInitiateDefenses",2];
				BRPVP_aTurretHelpSpecialCycle = 20;
				BRPVP_sleepRounds = true;
			};
			_changed = true;
			BDW_wakeUpFlags = BDW_wakeUpFlags+_add;
			BDW_lastAdd = _add;
		} else {
			if (_remove isNotEqualTo []) then {
				private _removeT = [];
				private _removeId = [];
				private _interRemove = [];
				{
					private _flag = _x;
					private _fRad = _flag call BRPVP_getFlagRadius;
					{
						private _ti = _x;
						private _inFlag = (_ti select 2) distance2D _flag <= _fRad;
						if (_inFlag) then {
							private _onNewPool = {(_ti select 2) distance2D (getPosWorld _x) <= _x call BRPVP_getFlagRadius} count _wakeUpFlagsNow > 0;						
							if (!_onNewPool) then {_removeT pushBackUnique _ti;};
						};
					} forEach BRPVP_allTurretsInfo;
					{_interRemove pushBackUnique _x;} forEach (_flag call BRPVP_getIntersectFlags);
				} forEach _remove;
				_removeT = _removeT apply {[player distance (_x select 2),_x]};
				_removeT sort false;
				_removeT = _removeT apply {_x select 1};
				_interRemoveId = _interRemove apply {_x getVariable "id_bd";};
				_removeId = _removeT apply {_x select 3};
				if (_removeT isNotEqualTo []) then {
					[clientOwner,_interRemove,_interRemoveId,_removeT,_removeId] remoteExecCall ["BRPVP_turretStopDefenses",2];
					BRPVP_sleepRounds = true;
				};
				_changed = true;
				BDW_wakeUpFlags = BDW_wakeUpFlags-_remove;
				BDW_lastRemove = _remove;
			};
		};
		if (_changed) then {player setVariable ["brpvp_wakeUpFlags",BDW_wakeUpFlags,2];};
		BDW_forceUpdate = false;
	};
	BDW_initBBool = !BDW_initBBool;
};
addMissionEventHandler ["EachFrame",{call BRPVP_wakeUpBaseDefenses;}];