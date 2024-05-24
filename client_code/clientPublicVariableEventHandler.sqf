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
diag_log "[SCRIPT] clientPublicVariableEventHandler.sqf BEGIN";

//PVEH FUNCTIONS CLIENT
BRPVP_consAddToMapSeePersonalArray = {
	private _building = _this;
	private _flag = [_building,BRPVP_myStuffOthers] call BRPVP_nearestFlagInsideLimited;
	if (!isNull _flag) then {{if ((_x select 0) isEqualTo _flag) then {(BRPVP_myFlagsSeeBuildingsOnMap select _forEachIndex select 2) pushBack _building;};} forEach BRPVP_myFlagsSeeBuildingsOnMap;};
};
BRPVP_askPlayersToUpdateFriendsClient = {call BRPVP_daUpdateNosAmigos;};
BRPVP_addWalkerIconsClient = {
	BRPVP_walkersObj = BRPVP_walkersObj-[objNull];
	BRPVP_walkersObj append _this;
	["geralshow"] call BRPVP_updateMapIconsAdd;
};
BRPVP_giveMoney = {
	[player,_this select 0,_this select 1] call BRPVP_qjsAdicClassObjeto;
	"negocio" call BRPVP_playSound;
};
BRPVP_moveInClient = {
	_this params ["_unit","_vehicle","_type"];
	if (_type == "Driver") then {_unit moveInDriver _vehicle;};
	if (_type == "Commander") then {_unit moveInCommander _vehicle;};
	if (_type == "Gunner") then {_unit moveInGunner _vehicle;};
	if (_type == "Cargo") then {_unit moveInCargo _vehicle;};
};
BRPVP_ganchoDesviraAdd = {BRPVP_ganchoDesvira pushBack _this;};
BRPVP_ganchoDesviraRemove = {BRPVP_ganchoDesvira = BRPVP_ganchoDesvira-[_this];};
BRPVP_pegaVaultPlayerBdRetorno = {
	private ["_vault","_posVault"];
	(_this select 1 select 0) params ["_inventario","_comp","_idx"];
	diag_log "---------------------------------------------------------------------------------------------";
	diag_log ("---- [VAULT ACTIVATED. IDX = "+str _idx+".VAULT ITEMS ARE:]");
	diag_log ("---- _inventario = "+str _inventario);
	diag_log "---------------------------------------------------------------------------------------------";
	[player,["abrevault",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
	_posPlayer = ASLToAGL getPosASL player;
	_ang = getDir player;
	_posVault = [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,(_posPlayer select 2)+0.5];
	_vault = (BRPVP_vaultClassNames select (_idx mod count BRPVP_vaultClassNames)) createVehicle BRPVP_posicaoFora;
	[_vault,BRPVP_personalVaultCargoSize] remoteExecCall ["setMaxLoad",2];
	_vault allowDamage false;
	_vault setVariable ["bidx",_idx,true];
	_vault setVariable ["stp",0,true];
	_vault setVariable ["own",player getVariable ["id_bd",-1],true];
	_vault setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
	_vault setVariable ["stp",_comp,true];
	_vault setVariable ["brpvp_no_carry",true,true];
	_vault setDir _ang;
	clearWeaponCargoGlobal _vault;
	clearMagazineCargoGlobal _vault;
	clearBackPackCargoGlobal _vault;
	clearItemCargoGlobal _vault;
	if (_inventario select 0 isEqualTo 3) then {
		[_vault,_inventario] call BRPVP_putItemsOnCargo;
	} else {
		[_vault,[_inventario select 0,_inventario select 1,_inventario select 3,_inventario select 2]] call BRPVP_putItemsOnCargo;
	};
	player setVariable ["wh",_vault,true];
	BRPVP_holderVault = _vault;
	[_vault,_posVault] spawn {
		params ["_v","_p"];
		sleep 0.25;
		if (!isNull _v) then {
			_v addEventHandler ["HandleDamage",{
				if !(_this select 4 isEqualTo "") then {
					BRPVP_vaultAcaoTempo = time+2;
					call BRPVP_vaultRecolhe;
				};
				0
			}];
			_v allowDamage true;
			_v setPosASL AGLToASL _p;
		};
	};
};
BRPVP_mudaExpPedidoServidor = {_this call BRPVP_mudaExp;};
BRPVP_PUSV = {call BRPVP_daUpdateNosAmigos;};
BRPVP_tocaSom = {
	_this params ["_obj","_snd","_dist"];
	_obj say3D [_snd,_dist];
};
BRPVP_mudouConfiancaEmVoce = {
	_this params ["_pAction","_action"];
	if (_action) then {[format [localize "str_trust_new",name _pAction],4,15,857] call BRPVP_hint;} else {[format [localize "str_trust_revoked",name _pAction],4,15,857] call BRPVP_hint;};
	call BRPVP_daUpdateNosAmigos;
	BRPVP_tempoUltimaAtuAmigos = time;
};
BRPVP_terminaMissaoRun = {endMission "ServerRestart";};

//PVEH
"BRPVP_mensagemDeKillTxtSend" addPublicVariableEventHandler {(_this select 1) call LOL_fnc_showNotification;};

diag_log ("[SCRIPT] clientPublicVariableEventHandler.sqf END: " + str round (diag_tickTime - _scriptStart));