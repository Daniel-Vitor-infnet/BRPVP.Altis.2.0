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

_motorized = _this select 3;
_canAccess = _motorized call BRPVP_checaAcesso;

//TRY TO USE LOCK PICK IF NEEDED AND EQUIPED
_forceAccess = false;
_allowError = true;
if (!_canAccess && BRPVP_equipedIllegalItem isEqualTo "BRP_vehicleThief") then {
	//CHECK IF ON SAFE AND USER NEAR
	private _safeAndUserNear = false;
	if (BRPVP_safeZone) then {{if ([_x,_motorized] call BRPVP_checaAcessoPlayer) exitWith {_safeAndUserNear = true;};} forEach (_motorized nearEntities [BRPVP_playerModel,200]);};

	_allowError = false;
	if (_safeAndUserNear) then {
		[localize "str_cant_hack_safe_and_user_near",-6] call BRPVP_hint;
	} else {
		_remove = false;
		if (random 1 < BRPVP_lockPickChanceOfSuccess) then {
			_lpObj = BRPVP_equipedIllegalItemPatern select 2;
			if (isNull _lpObj) then {
				BRPVP_equipedIllegalItemPatern set [2,_motorized];
				_lpObj = _motorized;
			};
			if (_motorized isEqualTo _lpObj) then {
				if (BRPVP_equipedIllegalItemPatern select 1 >= 8) then {
					if (BRPVP_equipedIllegalItemPatern select 0 isEqualTo 1) then {
						_forceAccess = true;
						"lock_pick_ok_music" call BRPVP_playSound;
						[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
						_remove = true;
						if (_motorized getVariable ["brpvp_rto_real_vehicle",false] && {_motorized distance2D BRPVP_raidTrainingMapPosition < 400}) then {
							if (BRPVP_hackObjectsOneTimeOnly) then {_motorized setVariable ["brpvp_hacked",true,true];};
						} else {
							if (BRPVP_hackObjectsOneTimeOnly) then {
								_motorized call BRPVP_turnIntoBandit;
								_motorized setVariable ["brpvp_hacked",true,true];
							};
							[_motorized getVariable "own",player getVariable "id_bd",player getVariable "nm",typeOf _motorized,getPosWorld _motorized] remoteExecCall ["BRPVP_logBaseInvasion",2];

							//SET FLAG TO NO CONSTRUCTION
							if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
								private _flag = _motorized call BRPVP_nearestFlagInsideWithAccess;
								if (!isNull _flag) then {
									_flag setVariable ["brpvp_last_intrusion",serverTime,true];
									if (BRPVP_useDiscordEmbedBuilder) then {_flag remoteExecCall ["BRPVP_messageDiscordRaid",2];};
								};
							};
						};
					} else {
						[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
						BRPVP_equipedIllegalItemPatern set [0,(BRPVP_equipedIllegalItemPatern select 0)-1];
						BRPVP_equipedIllegalItemPatern set [1,0];
					};
				} else {
					[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
					BRPVP_equipedIllegalItem = "";
				};
			} else {
				[player,["lock_pick_ok",50]] remoteExecCall ["say3D",BRPVP_allNoServer];
				BRPVP_equipedIllegalItem = "";
			};
		} else {
			[player,["lock_pick_not_ok",100]] remoteExecCall ["say3D",BRPVP_allNoServer];
			_remove = true;
		};
		if (_remove) then {
			[BRPVP_specialItems find BRPVP_equipedIllegalItem,1] call BRPVP_sitRemoveItem;
			BRPVP_equipedIllegalItem = "";
		};
	};
};

if (_canAccess || _forceAccess) then {
	BRPVP_actionRunning pushBack 18;
	_lockState = _motorized getVariable ["brpvp_locked",false];
	_motorized setVariable ["brpvp_locked",!_lockState,true];
	if (!_lockState) then {
		//[format[localize "str_vehicle_locked",getText (configFile >> "CfgVehicles" >> (typeOf _motorized) >> "displayName")],0,200,0,""] call BRPVP_hint;
		[_motorized,["lock_car",160]] remoteExecCall ["say3D",BRPVP_allNoServer];
		["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\veh_locked.paa'/>",0,0.25,1,0,0,75] call BRPVP_fnc_dynamicText;
	} else {
		//[format[localize "str_vehicle_unlocked",getText (configFile >> "CfgVehicles" >> (typeOf _motorized) >> "displayName")],0,200,0,""] call BRPVP_hint;
		[_motorized,["unlock_car",160]] remoteExecCall ["say3D",BRPVP_allNoServer];
		["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\veh_unlocked.paa'/>",0,0.25,1,0,0,75] call BRPVP_fnc_dynamicText;
	};
	if !(_motorized getVariable ["brpvp_slv_lck",false]) then {_motorized setVariable ["brpvp_slv_lck",true,true];};
	sleep 0.25;
	BRPVP_actionRunning = BRPVP_actionRunning-[18];
} else {
	if (_allowError) then {[localize "str_vehicle_lock_no_access"] call BRPVP_hint;};
};