//================
//INFORM END STATE
//================
["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\db_save_off.paa'/><br/>Saving...",0,0.25,5,0,0,9945] call BRPVP_fnc_dynamicText;
BRPVP_terminaMissao = true;
publicVariable "BRPVP_terminaMissao";
remoteExecCall ["BRPVP_terminaMissaoRun",-2]; //DISCONNECT OTHER CLIENTS

//=============================
//SAVE PLAYER_SERVER DISCONNECT
//=============================
[player,0,getPlayerUID player] call BRPVP_mehHandleDisconnect; 

//================
//SAVE ALL OBJECTS
//================
private _init = diag_tickTime;
call BRPVP_hdb_saveAllTables;
call BRPVP_saveSimpleObjectsOnDb;
call BRPVP_salvaEmMassaVeiculosServerOff;
profileNamespace setVariable ["BRPVP_SVP_atomicBombHiddenBigFloors",BRPVP_atomicBombHiddenBigFloors];
if (BRPVP_saveGroundItemsForOneRestart) then {call BRPVP_saveWeaponHoldersOnDB;};
_init spawn {
	uiSleep (1-(diag_tickTime-_this));
	["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\db_save.paa'/><br/>Database Saved!",0,0.25,2,0,0,9945] call BRPVP_fnc_dynamicText;
	playSound "weather_news";
	uiSleep 1;
	call BRPVP_terminaMissaoRun;
};
