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

if (hasInterface) then {
	BRPVP_forceObjectsUpdate = false;
	BRPVP_completeUpdate = false;
	BRPVP_fpsBoostEntitiesCategory = [
		[8,0,[0.000,0.125]],
		[8,1,[0.125,0.250]],
		[8,2,[0.250,0.375]],
		[8,3,[0.375,0.500]],
		[8,4,[0.500,0.625]],
		[8,5,[0.625,0.750]],
		[8,6,[0.750,0.875]],
		[8,7,[0.875,1.000]]
	];
	BRPVP_fpsBoostLastEntities = entities [[BRPVP_zombieMotherClass],[]];
	BRPVP_fpsBoostLastEntitiesQtt = count BRPVP_fpsBoostLastEntities;
	BRPVP_fpsBoostCycleCode = {
		_tm = time;
		if (_tm-_init >= _cycleTime || BRPVP_forceObjectsUpdate) then {
			_init = _tm;
			_count = _count+1;
			private _away = [];
			private _radius = if (BRPVP_completeUpdate) then {1000000} else {viewDistance+((4000-viewDistance) max 0)/7};
			private _posPlayer = getPosWorld BRPVP_myPlayerOrSpecOrDrone;
			{
				_x params ["_cycle","_shift","_range"];
				if ((_count+_shift) mod _cycle isEqualTo 0 || BRPVP_forceObjectsUpdate) then {
					private _doAway = _forEachIndex isEqualTo _awayToken;
					if (_doAway) then {
						if (BRPVP_fpsBoostLastEntitiesQtt > 0) then {call BRPVP_fpsBoostExecCode;};
						BRPVP_fpsBoostLastEntities = entities [[BRPVP_zombieMotherClass],[]];
						BRPVP_fpsBoostLastEntitiesQtt = count BRPVP_fpsBoostLastEntities;
					} else {
						if (BRPVP_fpsBoostLastEntitiesQtt > 0) then {call BRPVP_fpsBoostExecCode;};
					};
				};
			} forEach BRPVP_fpsBoostEntitiesCategory;
			if (_away isNotEqualTo []) then {
				_away spawn {
					private _qtt = count _this;
					private _init = diag_tickTime;
					private _wait = 2.5;
					private _dsblGrps = [];
					{
						private _rng = _x apply {floor (_x*_qtt)};
						private _ents = _this select [_rng select 0,(_rng select 1)-(_rng select 0)];
						_dsblGrps pushBack [diag_tickTime+0.25,_ents];
						{if !(simulationEnabled _x) then {_x enableSimulation true;};} forEach _ents;
						private _slp = (_wait-(diag_tickTime-_init))/(10-_forEachIndex);
						if (_slp > 1/diag_fps) then {uiSleep _slp;};
						call BRPVP_fpsBoostFinishAwayGrp;
					} forEach [[0.0,0.1],[0.1,0.2],[0.2,0.3],[0.3,0.4],[0.4,0.5],[0.5,0.6],[0.6,0.7],[0.7,0.8],[0.8,0.9],[0.9,1.0]];
					if (_dsblGrps isNotEqualTo []) then {waitUntil {call BRPVP_fpsBoostFinishAwayGrp;_dsblGrps isEqualTo []};};
				};
			};
			BRPVP_forceObjectsUpdate = false;
		};
	};
	BRPVP_fpsBoostExecCode = {
		private _rng = _range apply {floor (_x*BRPVP_fpsBoostLastEntitiesQtt)};
		private _entities = BRPVP_fpsBoostLastEntities select [_rng select 0,(_rng select 1)-(_rng select 0)];
		if (_doAway) then {
			_awayToken = (_awayToken+1) mod count BRPVP_fpsBoostEntitiesCategory;
			{if (local _x) then {if !(simulationEnabled _x) then {_x enableSimulation true;};} else {if (_x distance2D _posPlayer > _radius) then {_away pushBack _x;};};} forEach _entities;
		} else {
			{if (local _x) then {if !(simulationEnabled _x) then {_x enableSimulation true;};} else {if (_x distance2D _posPlayer > _radius) then {if (simulationEnabled _x) then {_x enableSimulation false;};} else {if (!simulationEnabled _x) then {_x enableSimulation true;};};};} forEach _entities;
		};
	};
	BRPVP_fpsBoostFinishAwayGrp = {
		private _del = [];
		{if (diag_tickTime >= _x select 0) then {_del pushBack _forEachIndex;{_x enableSimulation false;} forEach (_x select 1);};} forEach _dsblGrps;
		_del sort false;
		{_dsblGrps deleteAt _x;} forEach _del;
	};
	0 spawn {
		private _init = 0;
		private _count = -1;
		private _cycleTime = 0.5;
		private _awayToken = count BRPVP_fpsBoostEntitiesCategory-1;
		waitUntil {!isNil "BRPVP_myPlayerOrSpecOrDrone"};
		waitUntil {call BRPVP_fpsBoostCycleCode;false};
	};
};