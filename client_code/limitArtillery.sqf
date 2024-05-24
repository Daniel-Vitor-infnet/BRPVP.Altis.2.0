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

BRPVP_artySetTartet = {
	params ["_displayOrControl","_button","_xPos","_yPos","_shift","_ctrl","_alt"];
	if (_button isEqualTo 0) then {BRPVP_artyTargetPos = _displayOrControl ctrlMapScreenToWorld getMousePosition;};
};
disableSerialization;
private ["_ctrl","_ctrlMap"];
waitUntil {
	waitUntil {
		_objectParent = objectParent player;
		!isNull _objectParent && {typeOf _objectParent in (BRPVP_artilleryLimit select 0)}
	};
	waitUntil {
		_display = displayNull;
		{if (!isNull (_x displayCtrl 510)) exitWith {_display = _x;};} forEach allDisplays;
		_ctrl = _display displayCtrl 510;
		_ctrlMap = _display displayCtrl 500;
		!isNull _ctrl || isNull objectParent player;
	};
	if (!isNull _ctrlMap) then {
		BRPVP_artyMapOn = true;
		_ctrlMap ctrlAddEventHandler ["Draw",{call BRPVP_mapDrawEH;}];
		_ctrlMap ctrlAddEventHandler ["MouseButtonUp",{call BRPVP_artySetTartet;}];
		
		//OPEN MAP ON SPECTATORS
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
			private _mouse = _ctrlMap ctrlMapScreenToWorld getMousePosition;
			private _mapPos = _ctrlMap ctrlMapScreenToWorld [0.5,0.5];
			private _scale = ctrlMapScale _ctrlMap;
			["open",[0,_scale,_mapPos],_mouse] remoteExecCall ["BRPVP_specMapShow",BRPVP_specOnMeMachinesNoMe];
		};
	};
	private _init = diag_tickTime;
	while {!isnull _ctrl} do {
		BRPVP_mapMouseMovementAny = _ctrlMap ctrlMapScreenToWorld getMousePosition;
		BRPVP_specMapPosAny = _ctrlMap ctrlMapScreenToWorld [0.5,0.5];
		BRPVP_specMapScaleAny = ctrlMapScale _ctrlMap;
		_limit = (BRPVP_artilleryLimit select 1) select ((BRPVP_artilleryLimit select 0) find typeOf objectParent player);
		if (lbCurSel _ctrl > _limit) then {
			"erro" call BRPVP_playSound;
			_ctrl lbSetCurSel _limit
		};

		//SPEC SEND ARTY MAP POSITION
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
			{
				private _mouse = _ctrlMap ctrlMapScreenToWorld getMousePosition;
				private _mapPos = _ctrlMap ctrlMapScreenToWorld [0.5,0.5];
				private _scale = ctrlMapScale _ctrlMap;
				["open",[0,_scale,_mapPos],_mouse] remoteExecCall ["BRPVP_specMapShow",_x];
			} forEach BRPVP_specAddArtyMap;
			BRPVP_specAddArtyMap = [];
			if (diag_tickTime-_init >= 0.5) then {
				_init = diag_tickTime;
				private _mouse = _ctrlMap ctrlMapScreenToWorld getMousePosition;
				private _mapPos = _ctrlMap ctrlMapScreenToWorld [0.5,0.5];
				private _scale = ctrlMapScale _ctrlMap;
				[_mouse,[0.5,_scale,_mapPos]] remoteExecCall ["BRPVP_specMapAnime",BRPVP_specOnMeMachinesNoMe];
			};
		};

		sleep 0.001;
	};
	//CLOSE MAP ON SPECTATORS
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
		private _mouse = _ctrlMap ctrlMapScreenToWorld getMousePosition;
		private _mapPos = _ctrlMap ctrlMapScreenToWorld [0.5,0.5];
		private _scale = ctrlMapScale _ctrlMap;
		["close",[0,_scale,_mapPos],_mouse] remoteExecCall ["BRPVP_specMapShow",BRPVP_specOnMeMachinesNoMe];
	};

	BRPVP_artyMapOn = false;
	BRPVP_artyTargetPos = [];
	false
};