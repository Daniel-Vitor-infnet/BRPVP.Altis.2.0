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

BRPVP_actionRunning pushBack 5;
(_this select 3) params ["_from","_to"];
private _magusInvolved = _from getVariable ["brpvp_to_magus",false] || _to getVariable ["brpvp_to_magus",false];
if (!isNull _from && !isNull _to && !_magusInvolved) then {
	if ({_x call BRPVP_invOkToOpen} count [_from,_to] isEqualTo 2) then {
		if (_from call BRPVP_checaAcesso && _to call BRPVP_checaAcesso) then {
			if (_from distance _to > BRPVP_transferDistanceLimit) then {
				[localize "str_trans_far_destination",-4,12,128,"erro"] call BRPVP_hint;
			} else {
				//BLOCK IF MISSION BOX AND CANT OPEN
				(_from getVariable ["brpvp_mbots",[[0,0,0],0,[]]]) params ["_pos","_rad","_ais"];
				_dead = {!alive _x || _x distance _pos > _rad} count _ais;
				if (_dead >= round (BRPVP_killPercToLiberateBox*count _ais) || BRPVP_vePlayers) then {
					[_from,_to,ASLToATL getPosASL player,_to isEqualTo BRPVP_sellReceptacle] remoteExecCall ["BRPVP_transferCargoCargoB",_from];
					_ttxt = getText (configFile >> "CfgVehicles" >> (typeOf _to) >> "displayName");
					if (_from call BRPVP_isMotorized) then {
						_ftxt = getText (configFile >> "CfgVehicles" >> (typeOf _from) >> "displayName");
						[format [localize "str_trans_ok",_ftxt,_ttxt],-4] call BRPVP_hint;
					} else {
						[format [localize "str_trans_ok2",_ttxt],-4] call BRPVP_hint;
					};
				} else {
					"erro" call BRPVP_playSound;
					[localize "str_lock_box_message",-4] call BRPVP_hint;
				};
			};
		} else {
			[localize "str_trans_cant",-4,12,128,"erro"] call BRPVP_hint;
		};
	} else {
		"erro" call BRPVP_playSound;
	};
} else {
	"erro" call BRPVP_playSound;
};
sleep 2;
BRPVP_actionRunning = BRPVP_actionRunning - [5];