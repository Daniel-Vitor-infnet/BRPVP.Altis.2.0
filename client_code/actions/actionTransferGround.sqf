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
_from = _this select 3;
if (_from getVariable ["brpvp_to_magus",false]) then {
	"erro" call BRPVP_playSound;
} else {
	if (_from call BRPVP_checaAcesso) then {
		//BLOCK IF MISSION BOX AND CANT OPEN
		(_from getVariable ["brpvp_mbots",[[0,0,0],0,[]]]) params ["_pos","_rad","_ais"];
		_dead = {!alive _x || _x distance _pos > _rad} count _ais;
		if (_dead >= round (BRPVP_killPercToLiberateBox*count _ais) || BRPVP_vePlayers) then {
			if (_from isKindOf "CaManBase") then {
				private _nearPlayers = ((player nearEntities [BRPVP_playerModel,500]) apply {_x getVariable ["brpvp_machine_id",-1]})-[-1];
				_from setVariable ["brpvp_ttg_used",true,_nearPlayers];
				[_from,objNull,ASLToATL getPosASL player] remoteExecCall ["BRPVP_transferUnitCargoB",_from];
			} else {
				[_from,ASLToATL getPosASL player] remoteExecCall ["BRPVP_localMoveItemsToGround",_from];
			};
			if (_from call BRPVP_isMotorized) then {
				_ftxt = getText (configFile >> "CfgVehicles" >> (typeOf _from) >> "displayName");
				[format [localize "str_trans_ok",_ftxt,localize "str_weapon_holder_ok_name"],-4] call BRPVP_hint;
			} else {
				[format [localize "str_trans_ok2",localize "str_weapon_holder_ok_name"],-4] call BRPVP_hint;
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_lock_box_message",-4] call BRPVP_hint;
		};
	} else {
		[localize "str_trans_cant",-4,12,128,"erro"] call BRPVP_hint;
	};
};
sleep 1;
BRPVP_actionRunning = BRPVP_actionRunning-[5];