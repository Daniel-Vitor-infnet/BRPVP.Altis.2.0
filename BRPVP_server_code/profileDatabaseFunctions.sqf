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

BRPVP_hdb_tables_versions  = createHashMapFromArray [
	["BRPVP_pfl_hdb_tb_vault",1],
	["BRPVP_pfl_hdb_tb_veiculos",1],
	["BRPVP_pfl_hdb_tb_classAdItem",1],
	["BRPVP_pfl_hdb_tb_classAdVehicle",1],
	["BRPVP_pfl_hdb_tb_insurances",1],
	["BRPVP_pfl_hdb_tb_turretKills",1],
	["BRPVP_pfl_hdb_tb_fantaMines",1],
	["BRPVP_pfl_hdb_tb_used_names",1],
	["BRPVP_pfl_hdb_tb_marks",1],
	["BRPVP_pfl_hdb_tb_pastFriends",1],
	["BRPVP_pfl_hdb_tb_godModeHouse",1],
	["BRPVP_pfl_hdb_tb_bigFloors",1],
	["BRPVP_pfl_hdb_tb_xpTasting",1],
	["BRPVP_pfl_hdb_tb_secCams",1],
	["BRPVP_pfl_hdb_tb_players",1],
	["BRPVP_pfl_hdb_tb_playersConvertId",1],
	["BRPVP_pfl_hdb_tb_weaponHolders",1]
];

BRPVP_hdb_tables_minId = 0;
BRPVP_hdb_tables_maxId = 1000000;
BRPVP_hdb_getAllTables = {
	private _loadedMap = if (BRPVP_loadedMap isEqualTo "altis") then {""} else {"_"+BRPVP_loadedMap};
	private _code = '
		xxxxx = profileNamespace getVariable ["xxxxx'+_loadedMap+'",-1];
		xxxxx_version = profileNamespace getVariable ["xxxxx_version'+_loadedMap+'",-1];
		private _inexistent = xxxxx isEqualTo -1;
		private _wrongVersion = xxxxx_version isNotEqualTo (BRPVP_hdb_tables_versions get "xxxxx");
		if (_inexistent || _wrongVersion) then {
			xxxxx = createHashMap;
			xxxxx_version = BRPVP_hdb_tables_versions get "xxxxx";
			profileNamespace setVariable ["xxxxx'+_loadedMap+'",xxxxx];
			profileNamespace setVariable ["xxxxx_version'+_loadedMap+'",xxxxx_version];
		};
	';
	{call compile ([_code,"xxxxx",_x] call BRPVP_stringReplace);} forEach BRPVP_hdb_tables_versions;

	//CRIA NO INICIO TABELA DE VEICULOS EM GARAGEM VIRTUAL
	BRPVP_pfl_hdb_temp_virtualGarage = createHashMap;
	{if (_y select 19 isEqualTo 1 && _y select 14 isEqualTo 1) then {BRPVP_pfl_hdb_temp_virtualGarage set [_x,_y];};} forEach BRPVP_pfl_hdb_tb_veiculos;
};

BRPVP_hdb_saveAllTables = {
	private _loadedMap = if (BRPVP_loadedMap isEqualTo "altis") then {""} else {"_"+BRPVP_loadedMap};
	private _code = '
		profileNameSpace setVariable ["xxxxx'+_loadedMap+'",xxxxx];
		profileNameSpace setVariable ["xxxxx_version'+_loadedMap+'",xxxxx_version];
		saveProfileNameSpace
	';
	{call compile ([_code,"xxxxx",_x] call BRPVP_stringReplace);} forEach BRPVP_hdb_tables_versions;
};

BRPVP_hdb_resetDatabase = {
	private _loadedMap = if (BRPVP_loadedMap isEqualTo "altis") then {""} else {"_"+BRPVP_loadedMap};
	private _code = '
		xxxxx = createHashMap;
		xxxxx_version = BRPVP_hdb_tables_versions get "xxxxx";
		profileNamespace setVariable ["xxxxx'+_loadedMap+'",xxxxx];
		profileNamespace setVariable ["xxxxx_version'+_loadedMap+'",xxxxx_version];
	';
	{call compile ([_code,"xxxxx",_x] call BRPVP_stringReplace);} forEach BRPVP_hdb_tables_versions;
};

//EXTRUCTURES
BRPVP_pfl_hdb_tb_veiculos_extructure = ["inventario","posicao","modelo","owner","comp","amigos","mapa","exec","lastPayment","lock","paint","cover","ammo","life","active","delInfo","trueClassAd","originalOwner","lifesFix","virtualGarage"];
BRPVP_pfl_hdb_tb_insurances_extructure = ["vehicleId","vehicleClass","vehicleOwner","insuranceState","uses","sequence"];
BRPVP_pfl_hdb_tb_godModeHouse_extructure = ["houseClass","posWorld","own","stp","amg"];
BRPVP_pfl_hdb_tb_players_extructure = ["nome","exp","steamKey","inventario","backpack","posicao","saude","modelo","armaNaMao","amigos","vivo","comp_padrao","money","specialItems","money_bank","remoteControlUses","lastPveHack","config","weapon4","access","access2","access2Last","perks","secCamConnections","headItems","creationDate","hhBalance","headPrice","vaults","vgMult","clone","extraBank","forceCityRespawn","forceSpotLimit","id"];

//SAVE WHILE ON ESC
BRPVP_pfl_hdb_saveProfileName = false;
0 spawn {
	waitUntil {
		waitUntil {BRPVP_pfl_hdb_saveProfileName};
		BRPVP_pfl_hdb_saveProfileName = false;
		if (!isNil "BRPVP_serverBelezinha" && !isNil "BRPVP_serverPlayerPrimeiroSokOk" && {BRPVP_serverBelezinha && BRPVP_serverPlayerPrimeiroSokOk}) then {
			call BRPVP_hdb_saveAllTables;
			call BRPVP_saveSimpleObjectsOnDb;
			call BRPVP_salvaEmMassaEsc;
			call BRPVP_salvaEstadoVida;
			profileNamespace setVariable ["BRPVP_SVP_atomicBombHiddenBigFloors",BRPVP_atomicBombHiddenBigFloors];
			if (BRPVP_saveGroundItemsForOneRestart) then {call BRPVP_saveWeaponHoldersOnDB;};
			uiSleep 0.25;
			saveProfileNameSpace;
			playSound "achou_loot";
			["Database Saved!",-2] call BRPVP_hint;
		};
		false
	};
};


//==============
//QUERIES: VAULT OK
//==============

//[createVault]
//INSERT INTO vault (steamKey,inventario,comp,amigos,idx,vaultTip,fill) VALUES(?,?,?,?,?,"(???)",0)
//[steamKey,inventario,comp,amigos,idx,vaultTip,fill]
BRPVP_hdb_query_createVault = {
	params ["_uid","_idx"];
	private _lins = BRPVP_pfl_hdb_tb_vault getOrDefault [_uid,-1];
	if (_lins isEqualTo -1) then {
		BRPVP_pfl_hdb_tb_vault set [_uid,createHashMap];
		_lins = BRPVP_pfl_hdb_tb_vault getOrDefault [_uid,-1];
	};
	//[inventario,tip,fill]
	_lins set [_idx,[[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],"(???)",0]];
};

//[getPlayerVault]
//SELECT inventario,comp,idx FROM vault WHERE steamKey = ? AND idx = ?
BRPVP_hdb_query_getPlayerVault = {
	params ["_uid","_idx"];
	private _found = "[1,[]]";
	private _lins = BRPVP_pfl_hdb_tb_vault getOrDefault [_uid,-1];
	if (_lins isNotEqualTo -1) then {
		private _lin = _lins getOrDefault [_idx,-1];
		if (_lin isNotEqualTo -1) then {_found = str [1,[[_lin select 0,3,_idx]]];};
	};
	_found
};

//[saveVault]
//UPDATE vault SET inventario = ?,comp = ?, fill = ? WHERE steamKey = ? AND idx = ?
//[inventario,fill]
BRPVP_hdb_query_saveVault = {
	params ["_uid","_idx","_data"];
	private _lins = BRPVP_pfl_hdb_tb_vault getOrDefault [_uid,-1];
	private _result = "not_found";
	if (_lins isNotEqualTo -1) then {
		private _lin = _lins getOrDefault [_idx,-1];
		if (_lin isNotEqualTo -1) then {
			_lin set [0,_data select 0];
			_lin set [2,_data select 1];
			_result = "updated";
		};
	};
	_result
};

//[getPlayerVaultTips]
//SELECT idx, vaultTip, fill FROM vault WHERE steamKey = ? ORDER BY idx ASC;
BRPVP_hdb_query_getPlayerVaultTips = {
	private _uid = _this;
	private _found = [1,[]];
	private _lins = BRPVP_pfl_hdb_tb_vault getOrDefault [_uid,-1];
	if (_lins isNotEqualTo -1) then {
		private _result = [];
		{_result pushBack [_x,_y select 1,_y select 2];} forEach _lins;
		_result sort true;
		_found = [1,_result];
	};
	_found
};

//[playerVaultTipSave]
//UPDATE vault SET vaultTip = ? WHERE steamKey = ? AND idx = ?
//[vaultTip]
BRPVP_hdb_query_playerVaultTipSave = {
	params ["_uid","_idx","_data"];
	private _lins = BRPVP_pfl_hdb_tb_vault getOrDefault [_uid,-1];
	if (_lins isNotEqualTo -1) then {
		private _lin = _lins getOrDefault [_idx,-1];
		if (_lin isNotEqualTo -1) then {_lin set [1,_data select 0];};
	};
};

//================
//QUERIES: OBJECTS TESTAR MAIS
//================

//[createVehicle]
//INSERT INTO veiculos (inventario,posicao,modelo,owner,comp,amigos,mapa,exec,lastPayment,`lock`,paint,cover,ammo,life,active,delInfo,trueClassAd,originalOwner,lifesFix) VALUES(?,?,?,?,?,?,?,?,?,0,"[]","[]",?,?,1,-1,0,?,0)
//[inventario,posicao,modelo,owner,comp,amigos,mapa,exec,lastPayment,lock,paint,cover,ammo,life,active,delInfo,trueClassAd,originalOwner,lifesFix,virtualGarage]
BRPVP_hdb_query_createVehicle = {
	private _data = _this;
	private _lid = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random(BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_veiculos get _try}) exitWith {_lid = _try;};
	};
	BRPVP_pfl_hdb_tb_veiculos set [_lid,_data];
	_lid
};

//[saveVehicle]
//UPDATE veiculos SET inventario = ?,posicao = ?,modelo = ?,owner = ?,comp = ?,amigos = ?,mapa = ?,`lock` = ?,lastPayment = ?,ammo = ?,life = ?,lifesFix = ? WHERE id = ?
//[inventario,posicao,modelo,owner,comp,amigos,mapa,lock,lastPayment,ammo,life,lifesFix]
BRPVP_hdb_query_saveVehicle_placement = ["inventario","posicao","modelo","owner","comp","amigos","mapa","lock","lastPayment","ammo","life","lifesFix"] apply {BRPVP_pfl_hdb_tb_veiculos_extructure find _x;};
BRPVP_hdb_query_saveVehicle = {
	params ["_lid","_data"];
	private _result = "not_found";
	private _lin = BRPVP_pfl_hdb_tb_veiculos getOrDefault [_lid,-1];
	if (_lin isNotEqualTo -1) then {
		{_lin set [_x,_data select _forEachIndex];} forEach BRPVP_hdb_query_saveVehicle_placement;
		_result = "updated";
	};
	_result
};

//[saveVehicleAmg]
//[saveVehicleLock]
//[saveVehicleExec]
//[deleteVehicle]
//[putVirtualGarageMark]
//[classAdRemoveVehicleMark]
//[classAdMarkVehicle]
//[saveVehiclePaint]
//[saveFlagPayment]
//[updateLifesFix]
//[updateVehicleClassname]
//[tireVehUpdateSpatial]
//[setVehicleDelInfo]
//[addFlagWall]
//[removeFlagWall]
//[putVirtualGarageMark]
BRPVP_hdb_query_updateVehicleFieldsById = {
	params ["_lid","_fieldsData"];
	private _result = "not_found";
	private _lin = BRPVP_pfl_hdb_tb_veiculos getOrDefault [_lid,-1];
	if (_lin isNotEqualTo -1) then {
		{_lin set [BRPVP_pfl_hdb_tb_veiculos_extructure find (_x select 0),_x select 1];} forEach _fieldsData;

		//ATUALIZA TABELA DE GARAGEM VIRTUAL
		if (["virtualGarage",1] in _fieldsData) then {BRPVP_pfl_hdb_temp_virtualGarage set [_lid,_lin];};
		if (["virtualGarage",0] in _fieldsData) then {BRPVP_pfl_hdb_temp_virtualGarage deleteAt _lid;};
		_result = "updated";
	};
	_result
};

//[getObject]
//SELECT id,0 AS vago,inventario,posicao,modelo,owner,comp,amigos,mapa,exec,`lock`,lastPayment,virtualGarage,paint,cover,ammo,life,(SELECT players.amigos FROM players WHERE players.id=veiculos.owner) AS pAmg,lifesFix FROM veiculos WHERE id = ?
//[vago,inventario,posicao,modelo,owner,comp,amigos,mapa,exec,lock,lastPayment,virtualGarage,paint,cover,ammo,life,players.amigos,lifesFix]
BRPVP_hdb_query_getObject = {
	private _lid = _this;
	private _result = [];
	private _lin = BRPVP_pfl_hdb_tb_veiculos getOrDefault [_lid,-1];
	if (_lin isNotEqualTo -1) then {
		//COLOCAR VALOR DE players.amigos EM _lin select 5
		_result = [[_lid,0,_lin select 0,_lin select 1,_lin select 2,_lin select 3,_lin select 4,_lin select 5,_lin select 6,_lin select 7,_lin select 9,_lin select 8,_lin select 19,_lin select 10,_lin select 11,_lin select 12,_lin select 13,_lin select 5,_lin select 18]];
	};
	str [1,_result]
};

//[getObjects]
//SELECT * FROM (SELECT id,0 AS vago,inventario,posicao,modelo,owner,comp,amigos,mapa,exec,`lock`,lastPayment,virtualGarage,paint,cover,ammo,life,trueClassAd,lifesFix FROM veiculos WHERE active = 1 ORDER BY id ASC) AS T1 WHERE id > ? LIMIT 1
//[vago,inventario,posicao,modelo,owner,comp,amigos,mapa,exec,lock,lastPayment,virtualGarage,paint,cover,ammo,life,trueClassAd,lifesFix]
BRPVP_hdb_query_getObjects = {
	private _result = [];
	{if (_y select 14 isEqualTo 1) then {_result pushBack [_x,0,_y select 0,_y select 1,_y select 2,_y select 3,_y select 4,_y select 5,_y select 6,_y select 7,_y select 9,_y select 8,_y select 19,_y select 10,_y select 11,_y select 12,_y select 13,_y select 16,_y select 18];};} forEach BRPVP_pfl_hdb_tb_veiculos;
	_result
};

//[reviveDeadBase]
//UPDATE veiculos SET `active` = 1 WHERE delInfo = ?
BRPVP_hdb_query_reviveDeadBase = {
	private _delInfo = _this;
	{if ((_y select 15) isEqualTo _delInfo) then {_y set [14,1];};} forEach BRPVP_pfl_hdb_tb_veiculos;
};

//[reviveDeadBaseDelInfo]
//UPDATE veiculos SET delInfo = -1 WHERE delInfo = ?
BRPVP_hdb_query_reviveDeadBaseDelInfo = {
	private _delInfo = _this;
	{if ((_y select 15) isEqualTo _delInfo) then {_y set [15,-1];};} forEach BRPVP_pfl_hdb_tb_veiculos;
};

//[realVehicleDeleteById]
//DELETE FROM `veiculos` WHERE `id`=?
BRPVP_hdb_query_realVehicleDeleteById = {
	private _lid = _this;
	BRPVP_pfl_hdb_tb_veiculos deleteAt _lid;
};

//=========================
//QUERIES: CLASSAD VEHICLES OK
//=========================

//[classAdAddVehicle]
//INSERT INTO `classAdVehicle` (`vehicleId`,`vehicleClassname`,`vehiclePrice`,`ownerId`,`ownerName`,`ownerXp`,`adName`,`adDesc`,`fakeAd`) VALUES(?,?,?,?,?,?,?,?,?)
//[vehicleId,vehicleClassname,vehiclePrice,ownerId,ownerName,ownerXp,adName,adDesc,fakeAd]
BRPVP_hdb_query_classAdAddVehicle = {
	params ["_vehId","_data"];
	BRPVP_pfl_hdb_tb_classAdVehicle set [_vehId,_data];
};

//[classAdRemoveVehicle]
//DELETE FROM `classAdVehicle` WHERE `vehicleId`=?
BRPVP_hdb_query_classAdRemoveVehicle = {
	private _vehId = _this;
	BRPVP_pfl_hdb_tb_classAdVehicle deleteAt _vehId;
};

//[classAdCheckVehicleState]
//SELECT `fakeAd` FROM `classAdVehicle` WHERE `vehicleId`=?
BRPVP_hdb_query_classAdCheckVehicleState = {
	private _vehId = _this;
	private _result = [];
	private _lin = BRPVP_pfl_hdb_tb_classAdVehicle getOrDefault [_vehId,-1];
	if (_lin isNotEqualTo -1) then {_result = [[_lin select 6]];};
	_result
};

//[classAdVehicleListMy]
//SELECT `id`,`vehicleId`,`vehicleClassname`,`vehiclePrice`,`ownerId`,`ownerName`,`ownerXp`,`adName`,`adDesc`,`fakeAd` FROM `classAdVehicle` WHERE id > ? AND `ownerId` = ? ORDER BY id ASC LIMIT 10
//[id,vehicleId,vehicleClassname,vehiclePrice,ownerId,ownerName,ownerXp,adName,adDesc,fakeAd]
BRPVP_hdb_query_classAdVehicleListMy = {
	private _own = _this;
	private _result = [];
	{
		if (_y select 3 isEqualTo _own) then {
			_result pushBack [-1,_y select 0,_y select 1,_y select 2,_y select 3,_y select 4,_y select 5,_y select 6,_y select 7,_y select 8];
		};
	} forEach BRPVP_pfl_hdb_tb_classAdVehicle;
	_result
};

//[classAdVehicleList]
//SELECT `id`,`vehicleId`,`vehicleClassname`,`vehiclePrice`,`ownerId`,`ownerName`,`ownerXp`,`adName`,`adDesc`,`fakeAd` FROM `classAdVehicle` WHERE `ownerId` <> ? AND id > ? ORDER BY id ASC LIMIT 10
//[id,vehicleId,vehicleClassname,vehiclePrice,ownerId,ownerName,ownerXp,adName,adDesc,fakeAd]
BRPVP_hdb_query_classAdVehicleList = {
	private _own = _this;
	private _result = [];
	{
		if (_y select 3 isNotEqualTo _own) then {
			_result pushBack [-1,_y select 0,_y select 1,_y select 2,_y select 3,_y select 4,_y select 5,_y select 6,_y select 7,_y select 8];
		};
	} forEach BRPVP_pfl_hdb_tb_classAdVehicle;
	_result
};

//==================
//QUERIES: INSURANCE OK
//==================

//[addInsurance]
//INSERT INTO insurances (vehicleId,vehicleClass,vehicleOwner,insuranceState,uses,sequence) VALUES(?,?,?,?,?,?)
//[vehicleId,vehicleClass,vehicleOwner,insuranceState,uses,sequence]
BRPVP_hdb_query_addInsurance = {
	private _data = _this;
	private _lid = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random(BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_insurances get _try}) exitWith {_lid = _try;};
	};
	BRPVP_pfl_hdb_tb_insurances set [_lid,_data];
	_lid
};

//[getInsuranceSequence]
//SELECT `uses` FROM `insurances` WHERE `sequence`=?
BRPVP_hdb_query_getInsuranceSequence = {
	private _seq = _this;
	private _result = [];
	{if (_y select 5 isEqualTo _seq) then {_result pushBack [_y select 4];};} forEach BRPVP_pfl_hdb_tb_insurances;
	_result
};

//[setInsuranceSequence]
//[setInsuranceAsDelivered]
BRPVP_hdb_query_updateInsurancesFieldsById = {
	params ["_lid","_fieldsData"];
	private _lin = BRPVP_pfl_hdb_tb_insurances getOrDefault [_lid,-1];
	private _result = "not_found";
	if (_lin isNotEqualTo -1) then {
		{_lin set [BRPVP_pfl_hdb_tb_insurances_extructure find (_x select 0),_x select 1];} forEach _fieldsData;
		_result = "updated";
	};
	_result
};

//[updateInsuranceOwner]
//[activateInsurance]
BRPVP_hdb_query_updateInsurancesFieldsByVehicleId = {
	params ["_vehId","_fieldsData"];
	{if (_y select 0 isEqualTo _vehId) then {{_y set [BRPVP_pfl_hdb_tb_insurances_extructure find (_x select 0),_x select 1];} forEach _fieldsData;};} forEach BRPVP_pfl_hdb_tb_insurances;
};

//[checkInsurance]
//SELECT `uses` FROM insurances WHERE vehicleId=?
BRPVP_hdb_query_checkInsurance = {
	private _vehId = _this;
	private _result = [];
	{if (_y select 0 isEqualTo _vehId) then {_result pushBack [_y select 4];};} forEach BRPVP_pfl_hdb_tb_insurances;
	_result
};

//[recoverInsurance]
//SELECT vehicleClass,id FROM insurances WHERE vehicleOwner = ? AND insuranceState = 1
BRPVP_hdb_query_recoverInsurance = {
	private _vehOwn = _this;
	private _result = [];
	{if (_y select 2 isEqualTo _vehOwn && _y select 3 isEqualTo 1) then {_result pushBack [_y select 1,_x];};} forEach BRPVP_pfl_hdb_tb_insurances;
	_result
};

//=====================
//QUERIES: TURRET KILLS OK
//=====================

//[addTurretKill]
//INSERT INTO turretKills (playerId,playerName,turretId,turretOwner,flagId,flagOwner) VALUES(?,REPLACE(?,'"','""'),?,?,?,?)
//[creationDate,playerId,playerName,turretId,turretOwner,flagId,flagOwner]
BRPVP_hdb_query_addTurretKill = {
	params ["_fid","_data"];
	private _lins = BRPVP_pfl_hdb_tb_turretKills getOrDefault [_fid,-1];
	if (_lins isEqualTo -1) then {BRPVP_pfl_hdb_tb_turretKills set [_fid,[_data]];} else {_lins append _data;};
};

//[getTurretsKills]
//SELECT playerId, playerName, creationDate FROM turretKills WHERE flagId = ? ORDER BY creationDate DESC LIMIT 25
BRPVP_hdb_query_getTurretsKills = {
	private _fid = _this;
	private _lins = BRPVP_pfl_hdb_tb_turretKills getOrDefault [_fid,-1];
	if (_lins isEqualTo -1) then {
		[]
	} else {
		_lins select [((count _lins-1)-50) max 0,50 min (count _lins)] apply {[_x select 1,_x select 2,_x select 0]}
	};
};

//=====================
//QUERIES: FRANTA MINES OK (QUANDO UM FRANTA MUDA O ESTADO ISBASE ELA SOME NO PROXIMO RESTART)
//=====================

//[addFantaMine]
//INSERT INTO fantaMines (owner,amg,position,isBase) VALUES(?,?,?,?)
//[owner,amg,position,isBase]
BRPVP_hdb_query_addFantaMine = {
	private _data = _this;
	private _lid = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random(BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_fantaMines get _try}) exitWith {_lid = _try;};
	};
	BRPVP_pfl_hdb_tb_fantaMines set [_lid,_data];
	_lid
};

//[getFantaMines]
//SELECT id, owner, amg, position, isBase FROM (SELECT * FROM fantaMines WHERE id > ? ORDER BY id ASC) AS T1 LIMIT 20
BRPVP_hdb_query_getFantaMines = {
	private _result = [];
	{_result pushBack [_x,_y select 0,_y select 1,_y select 2,_y select 3];} forEach BRPVP_pfl_hdb_tb_fantaMines;
	_result
};

//[updateFantaMine]
//UPDATE fantaMines SET amg = ? WHERE owner = ?
BRPVP_hdb_query_updateFantaMine = {
	params ["_fltOwn","_setAmg"];
	private _found = 0;
	{
		if (_y select 0 isEqualTo _fltOwn) then {
			_y set [1,_setAmg];
			_found = _found+1;
		};
	} forEach BRPVP_pfl_hdb_tb_fantaMines;
	format ["updated %1",_found]
};

//[updateFantaMineIsBase]
//UPDATE fantaMines SET isBase = ? WHERE id = ?
BRPVP_hdb_query_updateFantaMineIsBase = {
	params ["_fltId","_setIsBase"];
	private _found = "not_found";
	private _lin = BRPVP_pfl_hdb_tb_fantaMines getOrDefault [_fltId,-1];
	if (_lin isNotEqualTo -1) then {
		_found = "updated";
		_lin set [3,_setIsBase];
	};
	_found
};

//[removeFantaMine]
//DELETE FROM fantaMines WHERE id = ?
BRPVP_hdb_query_removeFantaMine = {
	private _id = _this;
	BRPVP_pfl_hdb_tb_fantaMines deleteAt _id;
};

//==========================
//QUERIES: LOGIN/LOGOFF DATA OK
//==========================

//[recordLogInName]
//INSERT INTO used_names (id,name) VALUES(?,REPLACE(?,'"','""'))
//id[dateName,dateEnd,name]
BRPVP_hdb_query_recordLogInName = {
	params ["_pid","_pname"];
	private _lin = BRPVP_pfl_hdb_tb_used_names getOrDefault [_pid,-1];
	if (_lin isEqualTo -1) then {
		BRPVP_pfl_hdb_tb_used_names set [_pid,[[systemTime select [0,6],[],_pname]]];
	} else {
		_lin set [count _lin,[systemTime select [0,6],[],_pname]];
	};
	"end"
};

//[getPlayerNames]
//SELECT `name`, MAX(`dateName`) AS `last_used` FROM `used_names` WHERE id = ? GROUP BY `name` ORDER BY `last_used` DESC
BRPVP_hdb_query_getPlayerNames = {
	private _pid = _this;
	private _lin = BRPVP_pfl_hdb_tb_used_names getOrDefault [_pid,-1];
	private _return = [];
	if (_lin isNotEqualTo -1) then {
		private _names = [];
		private _dates = [];
		{
			private _name = _x select 2;
			private _idx = _names find _name;
			if (_idx isEqualTo -1) then {
				_names pushBack _name;
				_dates pushBack (_x select 0);
			} else {
				private _order = [_dates select _idx,_x select 0];
				_order sort false;
				_dates set [_idx,_order select 0];
			};
			{_return pushBack [_dates select _forEachIndex,_x]} forEach _names;
			_return sort false;
			_return = _return apply {[_x select 1,_x select 0]};
		} forEach _lin;
	};
	_return
};

//[getSessionMaxDate]
//SELECT CAST(MAX(dateName) AS CHAR) FROM used_names WHERE ISNULL(dateEnd) AND id = ?
BRPVP_hdb_query_getSessionMaxDate = {
	private _pid = _this;
	private _lin = BRPVP_pfl_hdb_tb_used_names getOrDefault [_pid,-1];
	_lin select (count _lin-1) select 0
};

//[updateSessionEnd]
//UPDATE used_names SET dateEnd = CURRENT_TIMESTAMP WHERE ISNULL(dateEnd) AND id = ? AND dateName = REPLACE(?,'@',':')
BRPVP_hdb_query_updateSessionEnd = {
	params ["_pid","_date"];
	private _lin = BRPVP_pfl_hdb_tb_used_names getOrDefault [_pid,-1];
	(_lin select (count _lin-1)) set [1,systemTime select [0,6]];
};

//[getPlayedDays]
//SELECT SUM(1) FROM (SELECT DATE(dateName) AS days FROM used_names WHERE id = (SELECT id FROM players WHERE steamKey=?) GROUP BY days) AS T1;
BRPVP_hdb_query_getPlayedDays = {
};


//==============
//QUERIES: MARKS OK
//==============

//[customMarksAdd]
//INSERT INTO marks (pId,`pos`,`text`) VALUES(?,?,?)
//[pId,pos,text]
BRPVP_hdb_query_customMarksAdd = {
	private _data = _this;
	private _lid = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random(BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_marks get _try}) exitWith {_lid = _try;};
	};
	BRPVP_pfl_hdb_tb_marks set [_lid,_data];
	_lid
};

//[customMarksUpdate]
//UPDATE marks SET `text` = ? WHERE id = ?
BRPVP_hdb_query_customMarksUpdate = {
	params ["_id","_txt"];
	private _mark = BRPVP_pfl_hdb_tb_marks get _id;
	_mark set [2,_txt];
};

//[customMarksDelete]
//DELETE FROM marks WHERE id = ?
BRPVP_hdb_query_customMarksDelete = {
	private _id = _this;
	BRPVP_pfl_hdb_tb_marks deleteAt _id;
};

//[customMarksGet]
//SELECT `id`,`pos`,`text` FROM marks WHERE pId = (SELECT id FROM players WHERE steamKey = ?)
BRPVP_hdb_query_customMarksGet = {
	private _steamKey = _this;
	private _return = [];
	private _pid = BRPVP_pfl_hdb_tb_playersConvertId getOrDefault [_steamKey,-1];
	if (_pid isEqualTo -1) then {{if (_y select 2 isEqualTo _steamKey) exitWith {_pid = _x;};} forEach BRPVP_pfl_hdb_tb_players;};
	if (_pid isNotEqualTo -1) then {{if (_y select 0 isEqualTo _pid) then {_return pushBack [_x,_y select 1,_y select 2];};} forEach BRPVP_pfl_hdb_tb_marks;};
	_return
};

//=====================
//QUERIES: PAST FRIENDS DESATIVADO
//=====================

//[pastFriendsInsert]
//INSERT INTO pastFriends (steamId,dateDay,dateAll,trusted) VALUES(?,DATE(CURRENT_TIMESTAMP),CURRENT_TIMESTAMP,?)
BRPVP_hdb_query_pastFriendsInsert = {
};

//[pastFriendsUpdate]
//UPDATE pastFriends SET dateAll = CURRENT_TIMESTAMP, trusted = ? WHERE id = ?
BRPVP_hdb_query_pastFriendsUpdate = {
};

//[pastFriendsCheck]
//SELECT id FROM pastFriends WHERE steamId=? AND dateDay = DATE(CURRENT_TIMESTAMP);
BRPVP_hdb_query_pastFriendsCheck = {
};

//[pastFriendsGet]
//SELECT trusted FROM pastFriends WHERE steamId = ? AND dateAll > DATE_ADD(CURRENT_TIMESTAMP,INTERVAL ? DAY);
BRPVP_hdb_query_pastFriendsGet = {
};

//======================
//QUERIES: GOD MOD HOUSE OK
//======================

//[addGodModeHouse]
//INSERT INTO `godModeHouse` (`houseClass`,`posWorld`,`own`,`stp`,`amg`) VALUES (?,?,?,?,?)
//[houseClass,posWorld,own,stp,amg]
BRPVP_hdb_query_addGodModeHouse = {
	private _data = _this;
	private _hid = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random(BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_godModeHouse get _try}) exitWith {_hid = _try;};
	};
	BRPVP_pfl_hdb_tb_godModeHouse set [_hid,_data];
	_hid
};

//[saveGodModeHouseAmg]
//UPDATE `godModeHouse` SET `own` = ?, `stp` = ?, `amg` = ? WHERE id = ?
BRPVP_hdb_query_saveGodModeHouseAmg = {
	params ["_hid","_fieldsData"];
	private _result = "not_found";
	private _lin = BRPVP_pfl_hdb_tb_godModeHouse getOrDefault [_hid,-1];
	if (_lin isNotEqualTo -1) then {
		{_lin set [BRPVP_pfl_hdb_tb_godModeHouse_extructure find (_x select 0),_x select 1];} forEach _fieldsData;
		_result = "updated";
	};
	_result
};

//[removeGodModeHouse]
//DELETE FROM `godModeHouse` WHERE `id`=?
BRPVP_hdb_query_removeGodModeHouse = {
	private _id = _this;
	BRPVP_pfl_hdb_tb_godModeHouse deleteAt _lid;
};

//[getGodModeHouses]
//SELECT `id`, `houseClass`, `posWorld`, `own`, `stp`, `amg` FROM `godModeHouse` WHERE `id` > ? ORDER BY `id` ASC LIMIT 10
BRPVP_hdb_query_getGodModeHouses = {
	private _return = [];
	{_return pushBack [_x,_y select 0,_y select 1,_y select 2,_y select 3,_y select 4];} forEach BRPVP_pfl_hdb_tb_godModeHouse;
	_return
};

//=======================
//QUERIES: CLASS AD ITEMS OK
//=======================

//[classAdAddItem]
//INSERT INTO `classAdItem` (`itemCargo`,`itemClassname`,`itemPrice`,`ownerId`,`ownerName`,`ownerXp`,`adName`,`adDesc`) VALUES(?,?,?,?,?,?,?,?)
BRPVP_hdb_query_classAdAddItem = {
	private _data = _this;
	private _cid = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random (BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_classAdItem get _try}) exitWith {_cid = _try;};
	};
	BRPVP_pfl_hdb_tb_classAdItem set [_cid,_data];
};

//[classAdRemoveItemAuto]
//DELETE FROM `classAdItem` WHERE `itemClassname`='alt+i (auto)'
BRPVP_hdb_query_classAdRemoveItemAuto = {
	private _keys = [];
	{
		if (_y select 1 isEqualTo "alt+i (auto)") then {_keys pushBack _x;};
	} forEach BRPVP_pfl_hdb_tb_classAdItem;
	{BRPVP_pfl_hdb_tb_classAdItem deleteAt _x;} forEach _keys;
	count _keys
};

//[classAdRemoveItem]
//DELETE FROM `classAdItem` WHERE `id`=?
BRPVP_hdb_query_classAdRemoveItem = {
	private _cid = _this;
	BRPVP_pfl_hdb_tb_classAdItem deleteAt _cid;
};

//[classAddItemGet]
//SELECT `itemCargo`,REPLACE(`itemClassname`,'"','""') FROM `classAdItem` WHERE id = ?
BRPVP_hdb_query_classAddItemGet = {
	private _cid = _this;
	private _lin = BRPVP_pfl_hdb_tb_classAdItem get _cid;
	[_lin select 0,_lin select 1]
};

//[classAdItemList]
//SELECT `id`,`itemCargo`,REPLACE(`itemClassname`,'"','""'),`itemPrice`,`ownerId`,`ownerName`,`ownerXp`,`adName`,`adDesc` FROM `classAdItem` WHERE `ownerId` <> ? AND id > ? ORDER BY id ASC LIMIT 10
BRPVP_hdb_query_classAdItemList = {
	private _oId = _this;
	private _return = [];
	{	
		if (_y select 3 isNotEqualTo _oId) then {
			_return pushBack [_x,_y select 0,_y select 1,_y select 2,_y select 3,_y select 4,_y select 5,_y select 6,_y select 7];
		};
	} forEach BRPVP_pfl_hdb_tb_classAdItem;
	_return
};

//[classAdItemListMy]
//SELECT `id`,`itemCargo`,REPLACE(`itemClassname`,'"','""'),`itemPrice`,`ownerId`,`ownerName`,`ownerXp`,`adName`,`adDesc` FROM `classAdItem` WHERE id > ? AND `ownerId` = ? ORDER BY id ASC LIMIT 10
BRPVP_hdb_query_classAdItemListMy = {
	private _oId = _this;
	private _return = [];
	{	
		if (_y select 3 isEqualTo _oId) then {
			_return pushBack [_x,_y select 0,_y select 1,_y select 2,_y select 3,_y select 4,_y select 5,_y select 6,_y select 7];
		};
	} forEach BRPVP_pfl_hdb_tb_classAdItem;
	_return
};

//==================
//QUERIES: BIG FLOOR
//==================

//[bfAddNew]
//INSERT INTO `bigFloors` (`size`,`owner`,`posWorld`,`holes`,`color`) VALUES(?,?,?,?,?)
BRPVP_hdb_query_bfAddNew = {
	private _data = _this;
	private _bid = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random (BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_bigFloors get _try}) exitWith {_bid = _try;};
	};
	BRPVP_pfl_hdb_tb_bigFloors set [_bid,_data];
	_bid
};

//[bfRemove]
//DELETE FROM `bigFloors` WHERE `id`=?
BRPVP_hdb_query_bfRemove = {
	private _bid = _this;
	BRPVP_pfl_hdb_tb_bigFloors deleteAt _bid;
	"ok"
};

//[bfGetAll]
//SELECT `id`,`size`,`owner`,`posWorld`,`holes`,`color` FROM `bigFloors` WHERE `id` > ? ORDER BY `id` ASC LIMIT 25
BRPVP_hdb_query_bfGetAll = {
	private _return = [];
	{_return pushBack [_x,_y select 0,_y select 1,_y select 2,_y select 3,_y select 4];} forEach BRPVP_pfl_hdb_tb_bigFloors;
	_return
};

//===================
//QUERIES: XP TASTING OK
//===================

//[tasteXpAddHistoric]
//INSERT INTO `xpTasting` (`playerId`,`playerName`,`abilitieId`,`dateTaste`) VALUES(?,?,?,CURRENT_TIMESTAMP);
//[playerName,abilitieId,dateTaste]
BRPVP_hdb_query_tasteXpAddHistoric = {
	params ["_pid","_data"];
	private _lin = BRPVP_pfl_hdb_tb_xpTasting getOrDefault [_pid,-1];
	if (_lin isEqualTo -1) then {
		BRPVP_pfl_hdb_tb_xpTasting set [_pid,[_data]];
	} else {
		_lin set [count _lin,_data];
	};
};

//[tasteXpGetHistoric]
//SELECT `abilitieId` FROM `xpTasting` WHERE `playerId`=? AND DATEDIFF(CURRENT_TIMESTAMP,`dateTaste`) <= ? GROUP BY `abilitieId`;
BRPVP_hdb_query_tasteXpGetHistoric = {
	params ["_pid","_days"];
	private _now = systemTime select [0,6];
	private _lin = BRPVP_pfl_hdb_tb_xpTasting getOrDefault [_pid,[]];
	(_lin select {[_now,_x select 2] call BRPVP_dateDiff <= _days}) apply {[_x select 1]}
};

//================
//QUERIES: SECCAMS
//================

//[secCamCreate]
//INSERT INTO `secCams` (`posASL`,`vdu`,`own`,`amg`) VALUES(?,?,?,?)
BRPVP_hdb_query_secCamCreate = {
	private _data = _this;
	private _camId = -1;
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random (BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_secCams get _try}) exitWith {_camId = _try;};
	};
	BRPVP_pfl_hdb_tb_secCams set [_camId,_data];
	_camId
};

//[secCamUpdateAmg]
//UPDATE `secCams` SET `amg` = ? WHERE `own` = ?
BRPVP_hdb_query_secCamUpdateAmg = {
	params ["_own","_amg"];
	{if (_y select 2 isEqualTo _own) then {_y set [3,_amg]};} forEach BRPVP_pfl_hdb_tb_secCams;
};

//[secCamDelete]
//DELETE FROM `secCams` WHERE `id`=?
BRPVP_hdb_query_secCamDelete = {
	private _camId = _this;
	BRPVP_pfl_hdb_tb_secCams deleteAt _camId;
};

//[secCamGet]
//SELECT `id`, `posASL`, `vdu`, `own`, `amg`, DATEDIFF(CURRENT_TIMESTAMP,`creationDate`) FROM (SELECT * FROM `secCams` WHERE id > ? ORDER BY id ASC) AS T1 LIMIT 20
BRPVP_hdb_query_secCamGet = {
	private _return = [];
	{_return pushBack [_x,_y select 0,_y select 1,_y select 2,_y select 3];} forEach BRPVP_pfl_hdb_tb_secCams;
	_return
};

//[secCamGetConnections]
//SELECT `secCamConnections` FROM `players` WHERE `steamKey` = ?
BRPVP_hdb_query_secCamGetConnections = {
	private _steamKey = _this;
	private _pid = BRPVP_pfl_hdb_tb_playersConvertId getOrDefault [_steamKey,-1];
	if (_pid isEqualTo -1) then {{if (_y select 2 isEqualTo _steamKey) exitWith {_pid = _x;};} forEach BRPVP_pfl_hdb_tb_players;};
	if (_pid isEqualTo -1) then {[]} else {(BRPVP_pfl_hdb_tb_players get _pid) select 23};
};

//[secCamSaveConnections]
//UPDATE `players` SET `secCamConnections` = ? WHERE `id` = ?
BRPVP_hdb_query_secCamSaveConnections = {
	params ["_pid","_scs"];
	private _lin = BRPVP_pfl_hdb_tb_players get _pid;
	_lin set [23,_scs];
};

//================
//QUERIES: PLAYERS TESTAR MAIS
//================

//[createPlayer]
//INSERT INTO players (nome,exp,steamKey,inventario,backpack,posicao,saude,modelo,armaNaMao,amigos,vivo,comp_padrao,money,specialItems,money_bank,remoteControlUses,lastPveHack,config,weapon4,access,access2,access2Last,perks,secCamConnections,headItems) VALUES(REPLACE(?,'"','""'),?,?,?,?,?,?,?,?,?,?,1,?,?,?,0,"[0,0,0,0,0,0]","[0,0,0,0,0,0,0,0]","[]",DATE_ADD(CURRENT_TIMESTAMP,INTERVAL -1 DAY),10,DATE_ADD(CURRENT_TIMESTAMP,INTERVAL -1 DAY),"[]","[]","[3,[['brpvp_main_container',[[],[],[[],[]],[[],[]]]]]]")
//["steamKey","nome","inventario","backpack","specialItems","posicao","saude","modelo","armaNaMao","amigos","vivo","exp","creationDate","ultimaAtualizacao","comp_padrao","money","money_bank","hhBalance","headPrice","remoteControlUses","lastPveHack","config","weapon4","access","access2","access2Last","vaults","vgMult","clone","perks","extraBank","forceCityRespawn","forceSpotLimit","secCamConnections","headItems"]
//(nome,exp,steamKey,inventario,backpack,posicao,saude,modelo,armaNaMao,amigos,vivo,comp_padrao,money,specialItems,money_bank,remoteControlUses,lastPveHack,config,weapon4,access,access2,access2Last,perks,secCamConnections,headItems)
//SQL1_INPUTS = 9,10,1,2,3,4,5,6,7,8,11,12,13,14
/*
//34 linhas
[
	nome, //0
	exp, //1
	steamKey, //2
	inventario, //3
	backpack, //4
	posicao, //5
	saude, //6
	modelo, //7
	armaNaMao, //8
	amigos, //9
	vivo, //10
	comp_padrao = 1,
	money, //11
	specialItems, //12
	money_bank, //13
	remoteControlUses = 0,
	lastPveHack = [0,0,0,0,0,0],
	config = [0,0,0,0,0,0,0,0],
	weapon4 = [],
	access = DATE_ADD(CURRENT_TIMESTAMP,INTERVAL -1 DAY),
	access2 = 10,
	access2Last = DATE_ADD(CURRENT_TIMESTAMP,INTERVAL -1 DAY),
	perks = [],
	secCamConnections = [],
	headItems = [3,[['brpvp_main_container',[[],[],[[],[]],[[],[]]]]]],
	creationDate = systemTime select [0,6],
	hhBalance = 0,
	headPrice = 0,
	vaults = 0,
	vgMult = 1,
	clone = "",
	extraBank = 0,
	forceCityRespawn = 0,
	forceSpotLimit = 0,
	id
]
*/
BRPVP_hdb_query_createPlayer = {
	private _data = _this;
	private ["_pid"];
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random(BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_players get _try}) exitWith {_pid = _try;};
	};
	if (_pid isNotEqualTo -1) then {
		private _dataFull = [_data select 0,_data select 1,_data select 2,_data select 3,_data select 4,_data select 5,_data select 6,_data select 7,_data select 8,_data select 9,_data select 10,1,_data select 11,_data select 12,_data select 13,0,[0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[],[0,0,0,0,0,0],10,[0,0,0,0,0,0],[],[],[3,[['brpvp_main_container',[[],[],[[],[]],[[],[]]]]]],systemTime select [0,6],0,0,0,1,"",0,0,0,_pid];
		BRPVP_pfl_hdb_tb_players set [_pid,_dataFull];
		BRPVP_pfl_hdb_tb_playersConvertId set [_dataFull select 2,_pid];
	};
	_pid
};

//[changePlayerBankMoneyAdd]
//[updatePlayerPerks]
//[savePlayerVgMult]
//[savePlayerVaults]
//[changePlayerBankMoney]
//[savePlayerName]
//[saveClone]
//[savePlayerAmg]
//[savePlayerComp]
//[savePlayerHeadItems]
//[updateLastPveHackDate]
BRPVP_hdb_query_updatePlayersFieldsById = {
	params ["_pid","_fieldsData"];
	private _result = "not_found";
	private _lin = BRPVP_pfl_hdb_tb_players getOrDefault [_pid,-1];
	if (_lin isNotEqualTo -1) then {
		{_lin set [BRPVP_pfl_hdb_tb_players_extructure find (_x select 0),_x select 1];} forEach _fieldsData;
		_result = "updated";
	};
	_result
};

//[getPlayerHeadItems]
BRPVP_hdb_query_getPlayersFieldsById = {
	params ["_pid","_fields"];
	private _result = [];
	private _lin = BRPVP_pfl_hdb_tb_players getOrDefault [_pid,-1];
	if (_lin isNotEqualTo -1) then {{_result pushBack (_lin select (BRPVP_pfl_hdb_tb_players_extructure find _x));} forEach _fields;};
	_result
};

//[getObjectOwnerName] CONSULTA AINDA NAO FOI CONVERTIDA
//SELECT nome FROM players WHERE id = ? 
BRPVP_hdb_query_getObjectOwnerName = {
	private _pid = _this;
	private _result = "name_not_found";
	private _lin = BRPVP_pfl_hdb_tb_players getOrDefault [_pid,-1];
	if (_lin isNotEqualTo -1) then {_result = _lin select 0;};
	_result
};
//[playerSetLife]
//[savePlayer]
BRPVP_hdb_query_updatePlayersFieldsBySid = {
	params ["_sid","_fieldsData"];
	private _result = "not_found";
	private _pid = BRPVP_pfl_hdb_tb_playersConvertId getOrDefault [_sid,-1];
	if (_pid isEqualTo -1) then {{if (_y select 2 isEqualTo _sid) exitWith {_pid = _x;};} forEach BRPVP_pfl_hdb_tb_players;};

	private _lin = BRPVP_pfl_hdb_tb_players getOrDefault [_pid,-1];
	if (_lin isNotEqualTo -1) then {
		{_lin set [BRPVP_pfl_hdb_tb_players_extructure find (_x select 0),_x select 1];} forEach _fieldsData;
		_result = "updated";
	};
	_result
};

//[getExtraBank]
//[checkIfPlayerOnDb]
//[getPlayer]
//[getPlayerNextLifeVals]
//[getForceCityRespawn]
//[getForceSpotLimit]
//[getLastPveHackDate]
BRPVP_hdb_query_getPlayerFieldsBySid = {
	params ["_sid","_fields"];
	private _result = [];
	private _pid = BRPVP_pfl_hdb_tb_playersConvertId getOrDefault [_sid,-1];
	if (_pid isEqualTo -1) then {{if (_y select 2 isEqualTo _sid) exitWith {_pid = _x;};} forEach BRPVP_pfl_hdb_tb_players;};

	private _lin = BRPVP_pfl_hdb_tb_players getOrDefault [_pid,-1];
	if (_lin isNotEqualTo -1) then {{_result pushBack (_lin select (BRPVP_pfl_hdb_tb_players_extructure find _x));} forEach _fields;};
	_result
};

//===========================
//QUERIES: SAVE WEAPONHOLDERS OK
//===========================

//[whAdd]
//INSERT INTO weaponHolders (`pos`,`vdu`,`gear`) VALUES(?,?,?)
BRPVP_hdb_query_whAdd = {
	private _data = _this;
	private ["_wid"];
	private _try = 0;
	while {true} do {
		_try = BRPVP_hdb_tables_minId+floor random(BRPVP_hdb_tables_maxId-BRPVP_hdb_tables_minId);
		if (isNil {BRPVP_pfl_hdb_tb_weaponHolders get _try}) exitWith {_wid = _try;};
	};
	if (_wid isNotEqualTo -1) then {BRPVP_pfl_hdb_tb_weaponHolders set [_wid,_data];};
	_wid
};

//[whDeleteAll]
//DELETE FROM weaponHolders
BRPVP_hdb_query_whDeleteAll = {
	BRPVP_pfl_hdb_tb_weaponHolders = createHashMap;
};

//[whGet]
//SELECT id, pos, vdu, gear FROM (SELECT * FROM weaponHolders WHERE id > ? ORDER BY id ASC) AS T1 LIMIT 1
BRPVP_hdb_query_whGet = {
	private _result = [];
	{_result pushBack [_x,_y select 0,_y select 1,_y select 2];} forEach BRPVP_pfl_hdb_tb_weaponHolders;
	_result
};

//===========================
//QUERIES: GET VIRTUAL GARAGE OK
//===========================

//[getVirtualGarageObjects]
//var1 = SELECT SUM(1) FROM insurances WHERE insurances.vehicleId=veiculos.id AND insuranceState=0
//SELECT id,modelo,paint,cover,ammo,life,exec,NOT ISNULL(var1) AS secured FROM veiculos WHERE owner = ? AND virtualGarage = 1 AND active = 1 ORDER BY id ASC
BRPVP_hdb_query_getVirtualGarageObjects = {
	private _owner = _this;
	private _return = [];
	{
		if (_y select 3 isEqualTo _owner && {_y select 14 isEqualTo 1 && _y select 19 isEqualTo 1}) then {
			private _secured = false;
			private _vehId = _x;
			{if (_y select 0 isEqualTo _vehId && _y select 3 isEqualTo 0) exitWith {_secured = true;};} forEach BRPVP_pfl_hdb_tb_insurances;
			_return pushBack [_x,_y select 2,_y select 10,_y select 11,_y select 12,_y select 13,_y select 7,_secured];
		};
	} forEach BRPVP_pfl_hdb_temp_virtualGarage;
	_return
};

//==================
//QUERIES: PATRIMONY OK
//==================

//[getPatrimony]
//SELECT id,nome,ROUND((money+money_bank)/1000000,2) AS allMoney,specialItems FROM players WHERE DATE_FORMAT(`ultimaAtualizacao`,'%Y%m%d%H') = ? AND RIGHT(steamKey,4) <> "_ADM";
BRPVP_hdb_query_getPatrimony = {
	private _result = [];
	private _steamKey = "";
	private _steamKeyEnd = "";
	private _allMoney = 0;
	{
		_steamKey = _y select 2;
		_steamKeyEnd = _steamKey select [count _steamKey-4,4];
		if (_steamKeyEnd isNotEqualTo "_ADM") then {
			_allMoney = ((_y select 12)+(_y select 14))/1000000;
			_allMoney = (round (_allMoney*100))/100;
			_result pushBack [_x,_y select 0,_allMoney,_y select 13];
		};
	} forEach BRPVP_pfl_hdb_tb_players;
	_result
};