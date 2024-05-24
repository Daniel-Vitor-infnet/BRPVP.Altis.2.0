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
diag_log "[SCRIPT] servidor_PVEH.sqf BEGIN";

//PVEH FUNCTIONS
BRPVP_addHoleToDB = { //PVAR_REMOVED
	params ["_cons","_estadoCons"];
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		private _pos = _estadoCons select 1 select 0 call KK_fnc_positionToString;
		private _vdu = _estadoCons select 1 select 1;
		private _spatialData = format ["[%1,%2]",_pos,_vdu];

		_key = format ["0:%1:createVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13",BRPVP_protocolo,_estadoCons select 0,_spatialData,_estadoCons select 2,_estadoCons select 3,_estadoCons select 4,_estadoCons select 5,false,_estadoCons select 6,_estadoCons select 7,[],[0,[[],[]]],_estadoCons select 3];
		_resultado = "extDB3" callExtension _key;

		//PEGA ID DO OBJETO
		private _key2 = format ["0:%1:getConstructionIdByModelPos:%2:%3",BRPVP_protocolo,_estadoCons select 2,_spatialData];
		private _resultado2 = "extDB3" callExtension _key2;
		private _cId = parseSimpleArray _resultado2 select 1 select 0 select 0;
		_cons setVariable ["id_bd",_cId,true];
	} else {
		private _data = [_estadoCons select 0,_estadoCons select 1,_estadoCons select 2,_estadoCons select 3,_estadoCons select 4,_estadoCons select 5,false,_estadoCons select 6,_estadoCons select 7,0,[],[],[],[0,[[],[]]],1,-1,0,_estadoCons select 3,0,0];
		_key = "_data call BRPVP_hdb_query_createVehicle";
		_resultado = _data call BRPVP_hdb_query_createVehicle;
		_cons setVariable ["id_bd",_resultado,true];
	};
	_cons setOwner 2;
	diag_log "----------------------------------------------------------------------------------";
	diag_log "---- [INSERT: ADD HOLE TO DB]";
	diag_log ("---- _key = "+str _key+".");
	diag_log ("---- _resultado = "+str _resultado+".");
};
BRPVP_lockPickedBuildingsServerAdd = {
	params ["_player","_pos","_actTime"];
	BRPVP_lockPickedBuildings pushBackUnique [_pos,_actTime];
	{
		["<img shadow='0' size='1.65' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\open_lock.paa'/><img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\door_picked.paa'/><img shadow='0' size='1.65' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\open_lock.paa'/>",{0},{(safezoneY + 0.05) min 0},4,0,0,5757] call BRPVP_fnc_dynamicText;
		"invasion_alarm" call BRPVP_playSound;
	} remoteExec ["call",BRPVP_allNoServer];
	publicVariable "BRPVP_lockPickedBuildings";
};
BRPVP_recordUsedName = {
	params ["_idBd","_name"];
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:recordLogInName:%2:%3",BRPVP_protocolo,_idBd,_name];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_idBd,_name] call BRPVP_hdb_query_recordLogInName;";
		_resultado = [_idBd,_name] call BRPVP_hdb_query_recordLogInName;
	};
	diag_log "----------------------------------------------------------------------------------";
	diag_log "---- [RECORD LOGIN NAME ON DB]";
	diag_log ("---- _key = "+_key+".");
	diag_log ("---- _resultado = "+str _resultado+".");
	diag_log "----------------------------------------------------------------------------------";
};
BRPVP_addTraderLog = {
	if (BRPVP_useExtDB3) then {
		params ["_player","_price","_items","_traderType"];
		_id_bd = _player getVariable ["id_bd",-1];
		_name = _player getVariable ["nm","?"];
		_position = (ASLToAGL getPosASL _player) apply {round _x};
		"extDB3" callExtension format ["1:%1:tradersLog:%2:%3:%4:%5:%6:%7",BRPVP_protocolo,_id_bd,_name,_traderType,_price,_items,_position];
	} else {
		//NOTHING IF CLIENTSV
	};
};
BRPVP_zombiePercOnServer = if (BRPVP_zombiePercOnServer isEqualTo 0) then {1000} else {round (1/(BRPVP_zombiePercOnServer min 1))};
BRPVP_countZombieLocality = 0;
BRPVP_setZombieOwner = {
	params ["_agnt","_target"];
	_oA = owner _agnt;
	_oT = owner _target;
	if (_oT isEqualTo 2 || BRPVP_countZombieLocality mod BRPVP_zombiePercOnServer isEqualTo 0) then {
		_localityOk = if (_oA isEqualTo 2) then {true} else {_agnt setOwner 2};
		if (_localityOk) then {[_agnt,_target] call ZB_addAgentFinalize;} else {deleteVehicle _agnt;};
	} else {
		_localityOk = if (_oA isEqualTo _oT) then {true} else {_agnt setOwner _oT};
		if (_localityOk) then {[_agnt,_target] remoteExecCall ["ZB_addAgentFinalize",_oT];} else {deleteVehicle _agnt;};
	};
	if !(_oT isEqualTo 2) then {BRPVP_countZombieLocality = BRPVP_countZombieLocality+1;};
};
BRPVP_zombieBackToServer = {
	params ["_agnt","_isLocal"];
	if (_isLocal) then {if !(_agnt in ZB_agnts) then {call ZB_searchForATargetBTS;};};
};
BRPVP_spawnZombiesServerFromClient = {
	params ["_posSpawn","_spawnTemplate","_nearBuildingsAwayNoPlayers","_player"];
	_amount = _spawnTemplate select 0;	
	_forceArray = _spawnTemplate select 1;
	_spawnRad = 5;
	_spawnInBuildingsAmount = (count _nearBuildingsAwayNoPlayers) min _amount;
	_zombieGroup = [];
	_zombieGroupPos = [];
	for "_u" from 1 to _spawnInBuildingsAmount do {
		_building = _nearBuildingsAwayNoPlayers deleteAt (floor random count _nearBuildingsAwayNoPlayers);
		_buildingPosAll = _building buildingPos -1;
		if (count _buildingPosAll isEqualTo 0) then {_buildingPosAll = [ASLToAGL getPosASL _building];};
		_buildingPos = selectRandom _buildingPosAll;
		_zombie = createAgent [selectRandom BRPVP_zombiesClasses,BRPVP_spawnAIFirstPos,[],10,"NONE"];
		removeUniform _zombie;
		if (random 1 < BRPVP_mobiusZombiesPercentage) then {
			_zombie setVariable ["brpvp_mobius",true,true];
			_zombie setVariable ["brpvp_zeds_old_style",2,true];
			_zombie setVariable ["ifz",BRPVP_mobiusZombiesLife,true];
			_zombie addUniform selectRandom BRPVP_CbrnSuits;
			_zombie addGoggles selectRandom BRPVP_CbrnMasks;

			//GAS TANK
			private _tank = "Land_GasTank_01_khaki_F" createVehicle [0,0,0];
			_tank attachTo [_zombie,[0,-0.2,-0.15],"spine3",true];
			_tank setVectorUp [0,0.125,-1];
		} else {
			private _uniform = selectRandom BRPVP_zombiesUniforms;
			if (_uniform isEqualType "") then {_zombie addUniform _uniform;} else {_zombie addUniform (_uniform select 0);_zombie addHeadGear (_uniform select 1);};
			_zombie setVariable ["ifz",selectRandom _forceArray,true];
		};
		_zombieGroup pushBack _zombie;
		_zombieGroupPos pushBack [_buildingPos,[],0,"NONE"];
	};	
	for "_i" from 1 to (_amount-_spawnInBuildingsAmount) do {
		_zombie = createAgent [selectRandom BRPVP_zombiesClasses,BRPVP_spawnAIFirstPos,[],10,"NONE"];
		removeUniform _zombie;
		if (random 1 < BRPVP_mobiusZombiesPercentage) then {
			_zombie setVariable ["brpvp_mobius",true,true];
			_zombie setVariable ["brpvp_zeds_old_style",2,true];
			_zombie setVariable ["ifz",BRPVP_mobiusZombiesLife,true];
			_zombie addUniform selectRandom BRPVP_CbrnSuits;
			_zombie addGoggles selectRandom BRPVP_CbrnMasks;

			//GAS TANK
			private _tank = "Land_GasTank_01_khaki_F" createVehicle [0,0,0];
			_tank attachTo [_zombie,[0,-0.2,-0.15],"spine3",true];
			_tank setVectorUp [0,0.125,-1];
		} else {
			private _uniform = selectRandom BRPVP_zombiesUniforms;
			if (_uniform isEqualType "") then {_zombie addUniform _uniform;} else {_zombie addUniform (_uniform select 0);_zombie addHeadGear (_uniform select 1);};
			_zombie setVariable ["ifz",selectRandom _forceArray,true];
		};
		_zombieGroup pushBack _zombie;
		_zombieGroupPos pushBack [_posSpawn,[],_spawnRad,"NONE"];
	};
	BRPVP_walkersObj = BRPVP_walkersObj-[objNull];
	BRPVP_walkersObj append _zombieGroup;
	_zombieGroup remoteExecCall ["BRPVP_addWalkerIconsClient",-2];
	{
		_agnt = _x;
		_agnt setVariable ["brpvp_impact_damage",0,true];
		{_agnt setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
		{_agnt setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
		_agnt addEventHandler ["Local",{call BRPVP_zombieBackToServer;}];
		_agnt setDir random 360;
	} forEach _zombieGroup;
	{[_x,"amovppnemstpsnonwnondnon"] remoteExec ["switchMove",0];} forEach _zombieGroup;
	{_x setVehiclePosition (_zombieGroupPos select _forEachIndex);} forEach _zombieGroup;
	{if (goggles _x isNotEqualTo "" && !(_x getVariable ["brpvp_mobius",false])) then {removeGoggles _x;};} forEach _zombieGroup;
	[_zombieGroup,_player] spawn BRPVP_setZombieOwnerCreatedServer;
};
BRPVP_spawnZombiesServerFromClientInFront = {
	params ["_data",["_oldStyle",0]];
	_data params ["_object","_number","_spawnRad","_forceArray","_victimsArray",["_fightAI",true],["_forceDirect",false],["_addReward",-1]];
	_zombieGroup = [];
	_zombieGroupPos = [];
	_posSpawn = if (_object isEqualType []) then {_object} else {ASLToAGL getPosASL _object};
	for "_i" from 1 to _number do {
		_zombie = createAgent [selectRandom BRPVP_zombiesClasses,BRPVP_spawnAIFirstPos,[],20,"NONE"];
		removeUniform _zombie;
		if (random 1 < BRPVP_mobiusZombiesPercentage) then {
			_zombie setVariable ["brpvp_mobius",true,true];
			_zombie setVariable ["brpvp_zeds_old_style",2,true];
			_zombie setVariable ["ifz",BRPVP_mobiusZombiesLife,true];
			_zombie addUniform selectRandom BRPVP_CbrnSuits;
			_zombie addGoggles selectRandom BRPVP_CbrnMasks;

			//GAS TANK
			private _tank = "Land_GasTank_01_khaki_F" createVehicle [0,0,0];
			_tank attachTo [_zombie,[0,-0.2,-0.15],"spine3",true];
			_tank setVectorUp [0,0.125,-1];
		} else {
			private _uniform = selectRandom BRPVP_zombiesUniforms;
			if (_uniform isEqualType "") then {_zombie addUniform _uniform;} else {_zombie addUniform (_uniform select 0);_zombie addHeadGear (_uniform select 1);};
			_zombie setVariable ["ifz",selectRandom _forceArray,true];
			if (_oldStyle > 0) then {_zombie setVariable ["brpvp_zeds_old_style",_oldStyle,true];};
		};
		_zombieGroup pushBack _zombie;
		_zombieGroupPos pushBack [_posSpawn,[],_spawnRad,"NONE"];
	};
	BRPVP_walkersObj = BRPVP_walkersObj-[objNull];
	BRPVP_walkersObj append _zombieGroup;
	_zombieGroup remoteExecCall ["BRPVP_addWalkerIconsClient",-2];
	{
		_agnt = _x;
		_agnt setVariable ["brpvp_impact_damage",0,true];
		{_agnt setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
		{_agnt setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
		_agnt addEventHandler ["Local",{call BRPVP_zombieBackToServer;}];
		_agnt setDir random 360;
		if (!_fightAI) then {_agnt setVariable ["brpvp_fightAI",false,true];};
		if (_addReward > -1) then {_agnt setVariable ["brpvp_add_reward",_addReward,true];};
	} forEach _zombieGroup;
	{if (goggles _x isNotEqualTo "" && !(_x getVariable ["brpvp_mobius",false])) then {removeGoggles _x;};} forEach _zombieGroup;
	{
		[_x,""] remoteExecCall ["switchMove",0];
		_x setVehiclePosition (_zombieGroupPos select _forEachIndex);
	} forEach _zombieGroup;
	_victimsArrayAgnts = _victimsArray apply {[]};
	{
		_v = [_victimsArray,1.25] call LOL_fnc_selectRandomFator;
		_idx = _victimsArray find _v;
		(_victimsArrayAgnts select _idx) pushBack _x;
	} forEach _zombieGroup;
	{
		_agnts = _victimsArrayAgnts select _forEachIndex;
		if !(_agnts isEqualTo []) then {[_agnts,_x] spawn BRPVP_setZombieOwnerCreatedServer;};
	} forEach _victimsArray;
	_zombieGroup
};
BRPVP_askServerForDestructionLog = {
	params ["_player","_id_bd","_all"];
	if (BRPVP_useExtDB3) then {
		private ["_key"];
		if (_all) then {_key = format ["0:%1:getDestructionLogAll",BRPVP_protocolo];} else {_key = format ["0:%1:getDestructionLog:%2",BRPVP_protocolo,_id_bd];};
		_resultado = "extDB3" callExtension _key;
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- [GET DESTRUCTION LOG]";
		diag_log ("---- _key = "+_key+".");
		diag_log ("---- _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
		BRPVP_askServerForDestructionLogReturn = _resultado;
		owner _player publicVariableClient "BRPVP_askServerForDestructionLogReturn";
	} else {
		//NOTHING IF CLIENTSV
		BRPVP_askServerForDestructionLogReturn = "[1,[]]";
		owner _player publicVariableClient "BRPVP_askServerForDestructionLogReturn";
	};
};
BRPVP_askPlayersToUpdateFriendsServer = {
	params ["_playersToUpdate","_playerShareChangedId","_newShareType"];
	private ["_key","_resultado"];
	{true remoteExecCall ["BRPVP_askPlayersToUpdateFriendsClient",_x];} forEach _playersToUpdate;
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:savePlayerComp:%2:%3",BRPVP_protocolo,_newShareType,_playerShareChangedId];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_playerShareChangedId,[[""comp_padrao"",_newShareType]]] call BRPVP_hdb_query_updatePlayersFieldsById";
		_resultado = [_playerShareChangedId,[["comp_padrao",_newShareType]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
	diag_log "----------------------------------------------------------------------------------";
	diag_log "---- [UPDATE PLAYER SELF SHARE TYPE ON DB]";
	diag_log ("---- _key = "+_key+".");
	diag_log ("---- _resultado = "+str _resultado+".");
	diag_log "----------------------------------------------------------------------------------";
};
BRPVP_systemExtra = 1;
BRPVP_iAskForInitialVars = {
	private _player = _this;
	if (owner _player isEqualTo 2) then {
		//SYNC CLIENT TIME
		BRPVP_syncedTime = diag_tickTime;
		BRPVP_syncedTimeMark = BRPVP_syncedTime;
	} else {
		//CHECK ON CLIENT FOR RECEIVE
		(owner _player) publicVariableClient "BRPVP_walkersObj";
		(owner _player) publicVariableClient "BRPVP_allFlags";
		(owner _player) publicVariableClient "BRPVP_baseBombDestroyedLines";
		(owner _player) publicVariableClient "BRPVP_zombieBloodBagActive";
		(owner _player) publicVariableClient "BRPVP_climbActivePlayers";
		(owner _player) publicVariableClient "BRPVP_carrierObjsList";
		(owner _player) publicVariableClient "BRPVP_artySpotInfo";
		(owner _player) publicVariableClient "BRPVP_habilitiesState";
		(owner _player) publicVariableClient "BRPVP_extraPosCheckSv";
		(owner _player) publicVariableClient "BRPVP_radioAreasExtra";
		(owner _player) publicVariableClient "BRPVP_allTurretsInfo";
		(owner _player) publicVariableClient "BRPVP_bigFloorsAll";
		(owner _player) publicVariableClient "BRPVP_atmOldActivated";
		(owner _player) publicVariableClient "BRPVP_frantaAllObjs";
		(owner _player) publicVariableClient "BRPVP_secCamAll";
		(owner _player) publicVariableClient "BRPVP_terrainVertexChanges";
		(owner _player) publicVariableClient "BRPVP_godModeHouseObjects";
		(owner _player) publicVariableClient "BRPVP_safezoneProtectionOnExitObjs";
		(owner _player) publicVariableClient "BRPVP_atomicBombHiddenBigFloors";

		//NO CHECK FOR RECEIVE ON CLIENTS
		(owner _player) publicVariableClient "BRPVP_minervaBotAllUnitsObjs";
		(owner _player) publicVariableClient "BRPVP_sBotAllUnitsObjs";
		(owner _player) publicVariableClient "BRPVP_systemExtra";

		//SYNC CLIENT TIME
		BRPVP_syncedTime = diag_tickTime;
		BRPVP_syncedTimeMark = BRPVP_syncedTime;
		(owner _player) publicVariableClient "BRPVP_syncedTime";
	};
};
BRPVP_setWeatherServer = {
	[["str_change_weather",[]],0] remoteExecCall ["BRPVP_hint",0];
	
	0 setOvercast 0;
	0 setRain 0;
	setWind [0,0,true];
	0 setGusts 0;
	forceWeatherChange;

	0 setOvercast (_this select 0 select 0);
	0 setRain (_this select 1 select 0);
	_wVel = _this select 1 select 1 select 0;
	_wDir = _this select 1 select 1 select 1;
	setWind [_wVel * sin _wDir,_wVel * cos _wDir,true];
	0 setGusts (_this select 0 select 1);
	forceWeatherChange;
};
BRPVP_setTimeMultiplierSV = {
	BRPVP_timeMultiplier = _this;
	setTimeMultiplier BRPVP_timeMultiplier;
	[["str_time_mult_changed",[_this]],3.5,12,768] remoteExecCall ["BRPVP_hint",0];
};
BRPVP_setDateSV = {
	setDate _this;
	[["str_day_time_changed",[_this select 3,_this select 4]],0] remoteExecCall ["BRPVP_hint",0];
};
BRPVP_runCorruptMissSpawn = {
	getPosATL _this remoteExec ["BRPVP_corruptMissSpawn",2];
	[["str_plane_fall_started",[]]] remoteExecCall ["BRPVP_hint",_this];
};
BRPVP_mudouConfiancaEmVoceSV = {
	params ["_pToNotify","_pAction","_action","_amg"];
	if (!isNull _pToNotify) then {[_pAction,_action] remoteExecCall ["BRPVP_mudouConfiancaEmVoce",_pToNotify];};
	_id_bd = _pAction getVariable ["id_bd",-1];
	if (_id_bd != -1) then {
		private ["_key","_resultado"];
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:savePlayerAmg:%2:%3",BRPVP_protocolo,_pAction getVariable ["amg",[]],_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _amg = _pAction getVariable ["amg",[]];
			_key = "[_id_bd,[[""amigos"",_amg]]] call BRPVP_hdb_query_updatePlayersFieldsById";
			_resultado = [_id_bd,[["amigos",_amg]]] call BRPVP_hdb_query_updatePlayersFieldsById;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATED PLAYER FRIENDS: _key = "+str _key+".");
		diag_log ("[BRPVP] UPDATED PLAYER FRIENDS: _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_giveMoneySV = {
	params ["_unit","_money",["_hand_or_bank","mny"]];
	[_money,_hand_or_bank] remoteExecCall ["BRPVP_giveMoney",_unit];
};
BRPVP_moveInServer = {_this remoteExecCall ["BRPVP_moveInClient",_this select 0];};
BRPVP_ownedHousesSolicita = {
	owner _this publicVariableClient "BRPVP_ownedHouses";
};
BRPVP_amigosAtualizaServidor = {//PPP FEITO
	private _id_bd = _this select 0;
	private _amigos = _this select 1;
	private _resultado = "";
	if (BRPVP_useExtDB3) then {
		private _sql = format ["UPDATE players SET amigos = '%1' WHERE id = %2",_amigos,_id_bd];
		_resultado = "extDB3" callExtension format ["1:%1:%2",BRPVP_protocoloRawText,_sql];
	} else {
		_resultado = [_id_bd,[["amigos",_amigos]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
	diag_log ("[BRPVP UPDATE PLAYER FRIENDS] _resultado = "+_resultado+".");
};
BRPVP_pegaTop10Estatistica = {//PPP DESABILITADO
	private _estatistica = _this select 0;
	private _solicitante = _this select 1;
	private _max = _estatistica+1;
	private _minChar = ",";
	private _resultadoCompilado = [];
	if (_estatistica isEqualTo 0) then {_minChar = "[";};
		if (BRPVP_useExtDB3) then {
		private _sql = format ["SELECT exp,CONCAT('""',REPLACE(nome,'""','""""'),'""') FROM players ORDER BY (SUBSTRING_INDEX(SUBSTRING_INDEX(exp,',',%1),'%2',-1)*1) DESC LIMIT 10",_max,_minChar];
		private _resultado = "extDB3" callExtension format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
		_resultadoCompilado = parseSimpleArray _resultado select 1;
	} else {
		//NOTHING IF CLIENT SV
		_resultadoCompilado = [[100,"Bob Larrouse"],[99,"Gili Nicodemus"],[5,"Beb Moreno"]];
	};
	private _tabela = [];
	{_tabela pushBack ((round (_x select 0 select _estatistica) call BRPVP_formatNumber)+" - @memory_remove_back@"+(_x select 1));} forEach _resultadoCompilado;
	BRPVP_pegaTop10EstatisticaRetorno = _tabela;
	owner _solicitante publicVariableClient "BRPVP_pegaTop10EstatisticaRetorno";
};
BRPVP_mudaExpOutroPlayer = {
	private _player = _this select 0;
	_this remoteExecCall ["BRPVP_mudaExpPedidoServidor",_player];
};
BRPVP_salvaNomePeloIdBd = {
	private _id_bd = _this select 0;
	private _nome = _this select 1;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:savePlayerName:%2:%3",BRPVP_protocolo,_nome,_id_bd];
	} else {
		[_id_bd,[["nome",_nome]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
};
BRPVP_pegaNomePeloIdBd1 = {//PPP FEITO
	params ["_id_bd_array","_solicitante","_retorno"];
	private _tabNome = [];
	private _tabIdBd = [];
	if (_id_bd_array isNotEqualTo []) then {
		private _resultadoCompilado = [];
		if (BRPVP_useExtDB3) then {
			private _id_bd_txt = "";
			private _final = (count _id_bd_array)-1;
			{
				_id_bd_txt = _id_bd_txt+str _x;
				if (_forEachIndex < _final) then {_id_bd_txt = _id_bd_txt+",";};
			} forEach _id_bd_array;
			_id_bd_txt = "("+_id_bd_txt+")";

			private _sql = format ["SELECT CONCAT('""',REPLACE(nome,'""','""""'),'""'),id FROM players WHERE id IN %1 ORDER BY nome ASC",_id_bd_txt];
			private _resultado = "extDB3" callExtension format ["0:%1:%2",BRPVP_ProtocoloRawText,_sql];
			_resultadoCompilado = parseSimpleArray _resultado select 1;
		} else {
			{
				private _lin = BRPVP_pfl_hdb_tb_players getOrDefault [_x,-1];
				if (_lin isNotEqualTo -1) then {_resultadoCompilado pushBack [_lin select 0,_x];};
			} forEach _id_bd_array;
			_resultadoCompilado sort true;
		};
		{_tabNome pushBack (_x select 0);} forEach _resultadoCompilado;
		{_tabIdBd pushBack (_x select 1);} forEach _resultadoCompilado;
	};
	if (_retorno) then {BRPVP_pegaNomePeloIdBd1Retorno = [_tabNome,_tabIdBd];} else {BRPVP_pegaNomePeloIdBd1Retorno = _tabNome;};
	owner _solicitante publicVariableClient "BRPVP_pegaNomePeloIdBd1Retorno";
};
BRPVP_pegaNomePeloIdBd2 = {//PPP FEITO
	private _id_bd = _this select 0;
	private _solicitante = _this select 1;
	private _resultado = [];
	if (BRPVP_useExtDB3) then {
		private _sql = format ["SELECT CONCAT('""',REPLACE(nome,'""','""""'),'""') FROM players WHERE amigos LIKE '[%1,%2' OR amigos LIKE '%2,%1,%2' OR amigos LIKE '%2,%1]' OR amigos LIKE '[%1]' ORDER BY nome ASC",_id_bd,"%"];
		_resultado = "extDB3" callExtension format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
		_resultado = parseSimpleArray _resultado select 1;
	} else {
		{if (_id_bd in (_y select 9)) then {_resultado pushBack [_y select 0]};} forEach BRPVP_pfl_hdb_tb_players;
		_resultado sort true;
	};
	private _tabela = [];
	{_tabela pushBack (_x select 0);} forEach _resultado;
	BRPVP_pegaNomePeloIdBd2Retorno = _tabela;
	owner _solicitante publicVariableClient "BRPVP_pegaNomePeloIdBd2Retorno";
};
BRPVP_pegaNomePeloIdBd3 = {//PPP FEITO
	params ["_id_bd_array","_id_bd","_solicitante"];
	private _tabNome = [];
	if (_id_bd_array isNotEqualTo []) then {
		private _resultado = [];
		if (BRPVP_useExtDB3) then {
			private _id_bd_txt = "";
			private _final = (count _id_bd_array)-1;
			{
				_id_bd_txt = _id_bd_txt+str _x;
				if (_forEachIndex < _final) then {_id_bd_txt = _id_bd_txt+",";};
			} forEach _id_bd_array;
			_id_bd_txt = "("+_id_bd_txt+")";

			private _sql = format ["SELECT CONCAT('""',REPLACE(nome,'""','""""'),'""') FROM players WHERE (amigos LIKE '[%1,%3' OR amigos LIKE '%3,%1,%3' OR amigos LIKE '%3,%1]' OR amigos LIKE '[%1]') AND id IN %2 ORDER BY nome ASC",_id_bd,_id_bd_txt,"%"];
			_resultado = "extDB3" callExtension format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
			_resultado = parseSimpleArray _resultado select 1;
		} else {
			{if (_id_bd in (_y select 9) && _x in _id_bd_array) then {_resultado pushBack [_y select 0]};} forEach BRPVP_pfl_hdb_tb_players;
			_resultado sort true;
		};
		{_tabNome = _tabNome+[_x select 0];} forEach _resultado;
	};
	BRPVP_pegaNomePeloIdBd3Retorno = _tabNome;
	owner _solicitante publicVariableClient "BRPVP_pegaNomePeloIdBd3Retorno";
};
BRPVP_adicionaConstrucaoBd = {
	params ["_mapa","_cons","_estadoCons",["_simpleObj",false],["_forceId",-1]];
	if (_forceId isEqualTo -1) then {
		private ["_key","_resultado"];
		if (BRPVP_useExtDB3) then {
			private _pos = _estadoCons select 1 select 0 call KK_fnc_positionToString;
			private _vdu = _estadoCons select 1 select 1;
			private _spatialData = format ["[%1,%2]",_pos,_vdu];

			_key = format ["0:%1:createVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13",BRPVP_protocolo,_estadoCons select 0,_spatialData,_estadoCons select 2,_estadoCons select 3,_estadoCons select 4,_estadoCons select 5,_mapa,_estadoCons select 6,_estadoCons select 7,_estadoCons select 8,_estadoCons select 9,_estadoCons select 3];
			_resultado = "extDB3" callExtension _key;

			//PEGA ID DO OBJETO
			private _key2 = format ["0:%1:getConstructionIdByModelPos:%2:%3",BRPVP_protocolo,_estadoCons select 2,_spatialData];
			private _resultado2 = "extDB3" callExtension _key2;
			private _cId = parseSimpleArray _resultado2 select 1 select 0 select 0;
			_cons setVariable ["id_bd",_cId,true];
		} else {
			private _data = [_estadoCons select 0,_estadoCons select 1,_estadoCons select 2,_estadoCons select 3,_estadoCons select 4,_estadoCons select 5,_mapa,_estadoCons select 6,_estadoCons select 7,0,[],[],_estadoCons select 8,_estadoCons select 9,1,-1,0,_estadoCons select 3,0,0];
			_key = "_data call BRPVP_hdb_query_createVehicle";
			_resultado = _data call BRPVP_hdb_query_createVehicle;
			_cons setVariable ["id_bd",_resultado,true];
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- [INSERT: ADD CONSTRUCTION ON DB]";
		diag_log ("---- _key = "+str _key+".");
		diag_log ("---- _resultado = "+str _resultado+".");
	} else {
		_cons setVariable ["id_bd",_forceId,true];
		_cons setVariable ["slv",true];
	};
	if (_mapa) then {_cons setVariable ["mapa",true,true];};
	if (_simpleObj) then {
		_cons spawn {
			private _cons = _this;
			waitUntil {getPosWorld _cons distance2D BRPVP_posicaoFora > 10 && getPosWorld _cons distance2D [0,0,0] > 1};
			sleep 0.5;
			[_cons call BRPVP_typeOfSo,getPosWorld _cons,[vectorDir _cons,vectorUp _cons],[allVariables _cons,allVariables _cons apply {_cons getVariable _x}]] remoteExecCall ["BRPVP_transformInLocal",0];
			sleep 0.25;
			deleteVehicle _cons;
		};
	} else {
		if (_cons call BRPVP_isMotorized) then {
			if (_cons call BRPVP_isMotorizedNoTurret) then {
				_cons call BRPVP_veiculoEhReset;
			} else {
				[_cons,_estadoCons select 1 select 0,_estadoCons select 1 select 1] call BRPVP_setTurretOperator;
			};
		} else {
			if (typeOf _cons in BRPVP_buildingHaveDoorListCVL) then {
				_cons spawn {
					private _cons = _this;
					waitUntil {getPosWorld _cons distance2D BRPVP_posicaoFora > 10 && getPosWorld _cons distance2D [0,0,0] > 1};
					sleep 0.5;
					[_cons call BRPVP_typeOfSo,getPosWorld _cons,[vectorDir _cons,vectorUp _cons],[allVariables _cons,allVariables _cons apply {_cons getVariable _x}]] remoteExecCall ["BRPVP_transformInLocalCVL",0];
					sleep 0.25;
					deleteVehicle _cons;
				};
			} else {
				_cons setOwner 2;
				if (typeOf _cons isEqualTo BRPVP_superBoxClass) then {_cons spawn {uiSleep 1;[_this,BRPVP_superBoxScale,[],0] call BRPVP_setObjectScale;};};
				_cons addEventHandler ["HandleDamage",{call BRPVP_buildingHDEH}];
				if !(typeOf _cons in BRPVP_doNotDisableBuildingClass) then {_cons enableDynamicSimulation true;};
				if (_cons call BRPVP_isBaseMapDraw) then {
					_cons remoteExecCall ["BRPVP_consAddToMapSeePersonalArray",0];
				};
				_cons remoteExecCall ["BRPVP_ownedHousesAddRE",0];
				if (_cons isKindOf "FlagCarrier") then {
					_cons spawn {
						private _cons = _this;
						waitUntil {getPosWorld _cons distance2D BRPVP_posicaoFora > 10};
						sleep 0.2;
						private _fRad = _cons call BRPVP_getFlagRadius;
						private _nearP = _cons nearEntities [BRPVP_playerModel,_fRad+500+100];
						_nearP = _nearP apply {owner _x};
						//NOHC_CHECK
						_nearP = (_nearP arrayIntersect _nearP)-[2];
						"force_update" remoteExecCall ["BRPVP_sleepRoundsSet",_nearP];
					};
				};
				if (_cons isKindOf "ReammoBox_F" && BRPVP_customBaseBoxSizeUse && (typeOf _cons) isNotEqualTo BRPVP_superBoxClass) then {_cons setMaxLoad BRPVP_customBaseBoxSize;};
				[_cons,0] remoteExecCall ["setFeatureType",0];
			};
		};
	};
};
BRPVP_checaExistenciaPlayerBd = {
	private ["_resultado","_key"];
	private _player = _this select 0;
	private _playerId = _this select 1;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:checkIfPlayerOnDb:%2",BRPVP_protocolo,_playerId];
		_resultado = "extDB3" callExtension _key;
		if (_resultado isEqualTo "[1,[[2]]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_clcmode";};
		if (_resultado isEqualTo "[1,[[1]]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_vivo";};
		if (_resultado isEqualTo "[1,[[0]]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_morto";};
		if (_resultado isEqualTo "[1,[]]") then {BRPVP_checaExistenciaPlayerBdRetorno = "nao_ta_no_bd";};
	} else {
		_key = "[_playerId,[""vivo""]] call BRPVP_hdb_query_getPlayerFieldsBySid";
		_resultado = [_playerId,["vivo"]] call BRPVP_hdb_query_getPlayerFieldsBySid;
		if (_resultado isEqualTo [2]) then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_clcmode";};
		if (_resultado isEqualTo [1]) then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_vivo";};
		if (_resultado isEqualTo [0]) then {BRPVP_checaExistenciaPlayerBdRetorno = "no_bd_e_morto";};
		if (_resultado isEqualTo []) then {BRPVP_checaExistenciaPlayerBdRetorno = "nao_ta_no_bd";};
		_resultado = str _resultado;
	};
	diag_log "----------------------------------------------------------------------------------";		
	diag_log "---- "+_playerId;
	diag_log "---- [SELECT: CHECK IF PLAYER IS ON DB AND IS ALIVE]";
	diag_log ("---- _key = "+_key+".");
	diag_log ("---- _resultado = "+_resultado+".");
	diag_log "----------------------------------------------------------------------------------";	
	owner _player publicVariableClient "BRPVP_checaExistenciaPlayerBdRetorno";
};
BRPVP_incluiPlayerNoBd = {
	private ["_key","_resultado","_resultadoCompilado"];
	private _player = _this select 0;
	private _estadoPLayer = _this select 1;
	private _steamKey = _estadoPLayer select 0;
	if (BRPVP_useExtDB3) then {
		_key = format["0:%1:createPlayer:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15",BRPVP_Protocolo,_steamKey,_estadoPLayer select 1,_estadoPLayer select 2,_estadoPLayer select 3,_estadoPLayer select 4,_estadoPLayer select 5,_estadoPLayer select 6,[],_estadoPLayer select 7,_estadoPLayer select 8,0,_estadoPLayer select 9,_estadoPLayer select 10,_estadoPLayer select 11];
		_resultado = "extDB3" callExtension _key;
	} else {
		private _data = [_estadoPLayer select 7,_estadoPLayer select 8,_steamKey,_estadoPLayer select 1,_estadoPLayer select 2,_estadoPLayer select 3,_estadoPLayer select 4,_estadoPLayer select 5,_estadoPLayer select 6,[],0,_estadoPLayer select 9,_estadoPLayer select 10,_estadoPLayer select 11];
		_key = "_data call BRPVP_hdb_query_createPlayer";
		_resultado = _data call BRPVP_hdb_query_createPlayer;
	};
	diag_log "----------------------------------------------------------------------------------";	
	diag_log "---- "+(_estadoPLayer select 0);
	diag_log "---- [INSERT A NEW PLAYER ON DB]";
	diag_log "---- PLAYER...";
	diag_log ("---- _key = "+_key+".");
	diag_log ("---- _resultado = "+str _resultado+".");

	if (BRPVP_useExtDB3) then {
		_resultado = "extDB3" callExtension format ["0:%1:getIdBdBySteamKey:%2",BRPVP_Protocolo,_steamKey];
		diag_log "---- ID BD...";
		diag_log ("---- _key = "+_key+".");
		diag_log ("---- _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
		_resultadoCompilado = parseSimpleArray _resultado select 1 select 0 select 0;
	} else {
		_resultadoCompilado = _resultado;
	};
	BRPVP_incluiPlayerNoBdRetorno = _resultadoCompilado;
	owner _player publicVariableClient "BRPVP_incluiPlayerNoBdRetorno";
};
BRPVP_salvaPlayer = {_this call BRPVP_salvarPlayerServidor;};
BRPVP_salvaPlayerVault = {
	private _estadoPlayer = _this select 0;
	private _estadoVault = _this select 1;
	if (_estadoPlayer isNotEqualTo []) then {_estadoPlayer call BRPVP_salvarPlayerServidor;};
	if (_estadoVault isNotEqualTo []) then {_estadoVault call BRPVP_salvarPlayerVaultServidor;};
};
BRPVP_pegaValoresContinua = {
	private ["_key","_resultado"];
	private _player = _this select 0;
	private _playerUID = _this select 1;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:getPlayerNextLifeVals:%2",BRPVP_protocolo,_playerUID];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_playerUID,[""amigos"",""exp"",""id"",""comp_padrao"",""money"",""specialItems"",""money_bank"",""hhBalance"",""headPrice"",""remoteControlUses"",""config"",""vaults"",""vgMult"",""clone"",""perks""]] call BRPVP_hdb_query_getPlayerFieldsBySid";
		_resultado = [_playerUID,["amigos","exp","id","comp_padrao","money","specialItems","money_bank","hhBalance","headPrice","remoteControlUses","config","vaults","vgMult","clone","perks"]] call BRPVP_hdb_query_getPlayerFieldsBySid;
		_resultado = str [1,[_resultado]];
	};
	diag_log "----------------------------------------------------------------------------------";
	diag_log "---- PLAYER ON DB AND DEAD: GET VALUES TO MANTAIN";
	diag_log ("---- _key = "+_key+".");
	diag_log ("---- _resultado = "+_resultado+".");
	diag_log "----------------------------------------------------------------------------------";
	BRPVP_pegaValoresContinuaRetorno = _resultado;
	owner _player publicVariableClient "BRPVP_pegaValoresContinuaRetorno";
};
BRPVP_pegaPlayerBd = {
	private ["_key","_resultado"];
	private _player = _this select 0;
	private _pId = _this select 1;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:getPlayer:%2",BRPVP_protocolo,_pId];
		_resultado = "extDB3" callExtension _key;
		BRPVP_pegaPlayerBdRetorno = _resultado;
	} else {
		private _data = ["inventario","backpack","posicao","saude","modelo","armaNaMao","amigos","exp","id","comp_padrao","money","specialItems","money_bank","hhBalance","headPrice","remoteControlUses","config","weapon4","vaults","vgMult","clone","perks"];
		_key = "[_pId,_data] call BRPVP_hdb_query_getPlayerFieldsBySid";
		_resultado = [_pId,_data] call BRPVP_hdb_query_getPlayerFieldsBySid;
		BRPVP_pegaPlayerBdRetorno = str [1,[_resultado]];
	};
	diag_log "----------------------------------------------------------------------------------";
	diag_log "---- "+_pId;
	diag_log "---- [GET PLAYER ON DB]";
	diag_log ("---- _key = "+str _key+".");
	diag_log ("---- _resultado = "+str _resultado+".");
	diag_log "----------------------------------------------------------------------------------";	
	owner _player publicVariableClient "BRPVP_pegaPlayerBdRetorno";
};
BRPVP_pegaVaultPlayerBd = {
	params ["_player","_pId","_vaultIdx"];
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:getPlayerVault:%2:%3",BRPVP_protocolo,_pId,_vaultIdx];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_pId,_vaultIdx] call BRPVP_hdb_query_getPlayerVault";
		_resultado = [_pId,_vaultIdx] call BRPVP_hdb_query_getPlayerVault;
	};
	if (_resultado isEqualTo "[1,[]]") then {
		diag_log ("[BRPVP GET VAULT] Vault with IDX = "+str _vaultIdx+" not found! _resultado = "+str _resultado+".");
		diag_log "[BRPVP GET VAULT] Creating Vault.";
		if (BRPVP_useExtDB3) then {
			_key = format ["0:%1:createVault:%2:%3:%4:%5:%6",BRPVP_Protocolo,_pId,[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],1,[],_vaultIdx];
			_resultado = "extDB3" callExtension _key;
		} else {
			_key = "[_pId,_vaultIdx] call BRPVP_hdb_query_createVault";
			_resultado = [_pId,_vaultIdx] call BRPVP_hdb_query_createVault;
		};
		diag_log ("---- CREATED VAULT OF IDX = "+str _vaultIdx+" FOR PLAYER "+name _player+".");
		diag_log ("---- _key = "+_key+".");
		diag_log ("---- _resultado = "+str _resultado+".");
		if (BRPVP_useExtDB3) then {
			_key = format ["0:%1:getPlayerVault:%2:%3",BRPVP_protocolo,_pId,_vaultIdx];
			_resultado = "extDB3" callExtension _key;
		} else {
			_key = "[_pId,_vaultIdx] call BRPVP_hdb_query_getPlayerVault";
			_resultado = [_pId,_vaultIdx] call BRPVP_hdb_query_getPlayerVault;
		};
	};
	diag_log "----------------------------------------------------------------------------------";
	diag_log "---- "+_pId;
	diag_log ("---- [GET VAULT GEAR IDX = "+str _vaultIdx+"]");
	diag_log ("---- _key = "+str _key+".");
	diag_log ("---- _resultado = "+str _resultado+".");
	diag_log "----------------------------------------------------------------------------------";
	parseSimpleArray _resultado remoteExecCall ["BRPVP_pegaVaultPlayerBdRetorno",_player];
};

diag_log ("[SCRIPT] servidor_PVEH.sqf END: " + str round (diag_tickTime - _scriptStart));