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
diag_log "[SCRIPT] servidor_funcoes_exclusive.sqf BEGIN";

BRPVP_setOwnerForFasterItemTransfer = {
	params ["_boxes","_pMid"];
	{if (local _x) then {_x setOwner _pMid;};} forEach _boxes;
};
BRPVP_setOwnerForFasterItemTransferBackToSv = {
	{if (!local _x) then {_x setOwner 2;};} forEach _this;
};
BRPVP_autoPayFlagsByNearBoxes = {
	private _flagSearchForMoneyInBoxToPayMaxDist = BRPVP_flagSearchForMoneyInBoxToPayMaxDist min 50;
	private _moneyMags = BRPVP_moneyItems select 0;
	private _moneyMagsValor = BRPVP_moneyItems select 1;
	{
		private _flag = _x;
		private _rad = _flag getVariable "brpvp_flag_radius";
		private _boxes = nearestObjects [_flag,["ReammoBox_F"],_flagSearchForMoneyInBoxToPayMaxDist];
		private _price = _flag call BRPVP_flagPayPrice;
		private _minPrice = round ((_flag call BRPVP_getFlagPayPrice)*0.5);
		if (_price >= _minPrice || _price >= 2500000) then {
			private _allMoney = 0;
			private _boxesFullUse = [];
			private _lastBoxUse = [];
			_boxes = _boxes apply {
				private _money = _x call BRPVP_getBoxMoney;
				if (_money > 0) then {
					private _mags = magazinesAmmoCargo _x select {(_x select 0) in _moneyMags};
					_mags = _mags apply {
						private _idx = _moneyMags find (_x select 0);
						private _val = _moneyMagsValor select _idx;
						[_val,_x select 0]
					};
					_mags sort true;
					_allMoney = _allMoney+_money;
					[_money,_mags,_x]
				} else {
					-1
				};
			};
			if (_allMoney >= _price) then {
				_boxes = _boxes-[-1];
				_boxes sort true;
				{
					_x params ["_total","_mags","_box"];
					private _allMags = magazinesAmmoCargo _box;
					private _allMagsJoin = [];
					private _allMagsJoinHelper = [];
					if (_price >= _total) then {
						{if ((_x select 0) in _moneyMags) then {_allMags deleteAt _forEachIndex;};} forEachReversed _allMags;
						{
							private _idx = _allMagsJoinHelper find _x;
							if (_idx isEqualTo -1) then {
								_allMagsJoin pushBack [_x select 0,1,_x select 1];
								_allMagsJoinHelper pushBack _x;
							} else {
								_allMagsJoin select _idx set [1,(_allMagsJoin select _idx select 1)+1];
							};
						} forEach _allMags;
						_boxesFullUse pushBack [_box,_allMagsJoin];
						_price = _price-_total;
					} else {
						private _magsRemove = [];
						private _lastMag = [];
						private _newLastMagValor = 0;
						{
							_x params ["_valor","_class"];
							if (_valor > _price) exitWith {_lastMag = _x;};
							if (_valor <= _price) then {
								_price = _price-_valor;
								_magsRemove pushBack _class;
							};
						} forEach _mags;
						if (_lastMag isNotEqualTo []) then {
							_newLastMagValor = (_lastMag select 0)-_price;
							_magsRemove pushBack (_lastMag select 1);
							_price = 0;
						};
						private _cntMagsRemoved = count _magsRemove;
						{
							private _magRemo = _x;
							{if ((_x select 0) isEqualTo _magRemo) then {_allMags deleteAt _forEachIndex;};} forEachReversed _allMags;
						} forEach _magsRemove;
						{
							private _idx = _allMagsJoinHelper find _x;
							if (_idx isEqualTo -1) then {
								_allMagsJoin pushBack [_x select 0,1,_x select 1];
								_allMagsJoinHelper pushBack _x;
							} else {
								_allMagsJoin select _idx set [1,(_allMagsJoin select _idx select 1)+1];
							};
						} forEach _allMags;
						_lastBoxUse pushBack [_box,_allMagsJoin,_newLastMagValor,_cntMagsRemoved];
					};
				} forEach _boxes;
				if (_price isEqualTo 0) then {
					{
						_x params ["_box","_allMagsJoin"];
						clearMagazineCargoGlobal _box;
						{_box addMagazineAmmoCargo _x;} forEach _allMagsJoin;
						if !(_box getVariable ["slv",false]) then {_box setVariable ["slv",true,true];};
					} forEach _boxesFullUse;
					{
						_x params ["_box","_allMagsJoin","_newLastMagValor","_cntMagsRemoved"];
						clearMagazineCargoGlobal _box;
						{_box addMagazineAmmoCargo _x;} forEach _allMagsJoin;
						if (_newLastMagValor isNotEqualTo 0) then {
							private _mnyArray = _newLastMagValor call BRPVP_itemMoneyCreate;
							private _get = (_cntMagsRemoved min count _mnyArray) max ceil (0.25*count _mnyArray);
							{_box addMagazineCargoGlobal [_x,1];} forEach (_mnyArray select [0,_get]);
						};
						if !(_box getVariable ["slv",false]) then {_box setVariable ["slv",true,true];};
					} forEach _lastBoxUse;
					_flag setVariable ["brpvp_lastPayment",systemTime select [0,6],true];
					if !(_flag getVariable ["slv",false]) then {_flag setVariable ["slv",true,true];};
				};
			};
		};
	} forEach BRPVP_allFlags;
};
BRPVP_calcPatrimonyOnServerUsingDB = {
	private _ymdhCases = [];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getPatrimonyDates:%2",BRPVP_protocolo,-15];
		_ymdhCases = parseSimpleArray _result select 1;
	} else {
		//NOTHING IF CLIENTSV
		_ymdhCases = [];
	};
	private _cntPC = 0;
	private _players = [];
	if (BRPVP_useExtDB3) then {
		{
			_x params ["_ymdh","_qt"];
			private _space = 100-_cntPC;
			private _result = "extDB3" callExtension format ["0:%1:getPatrimony:%2",BRPVP_protocolo,_ymdh];
			private _compiled = parseSimpleArray _result select 1;
			if (_compiled isNotEqualTo "100") then {
				private _toAdd = _compiled select [0,_space min count _compiled];
				_players append _toAdd;
				_cntPC = _cntPC+count _toAdd;
			};
			if (_cntPC >= 100) exitWith {};
		} forEach _ymdhCases;
	} else {
		_players = call BRPVP_hdb_query_getPatrimony;
	};
	private _playersSit = _players apply {_x select 3};
	private _players = _players apply {[_x select 0,_x select 1,/*MONEY*/(_x select 2)*1000000,/*CONSTRUCTIONS*/0,/*VEHICLES*/0,/*ITEMS*/0]};
	{
		private _valor = 0;
		private _items = _x;
		{
			_x params ["_class","_q"];
			if (_class isEqualType "" || {_class > -1}) then {
				_class = if (_class isEqualType 1) then {BRPVP_specialItems select _class} else {_class};
				_valor = _valor+(_class call BRPVP_itemGetPrice)*_q;
			};
		} forEach _items;
		(_players select _forEachIndex) set [5,(_players select _forEachIndex select 5)+_valor];
	} forEach _playersSit;
	private _playersId = _players apply {_x select 0};
	private _vehsClass = (BRPVP_tudoA3 select {_x select 0 isNotEqualTo "FEDIDEX"}) apply {_x select 3};
	private _vehsValor = (BRPVP_tudoA3 select {_x select 0 isNotEqualTo "FEDIDEX"}) apply {_x select 5};

	//GET BUILDINGS AND VEHICLES/BOXES FROM DATABASE
	private _onetimeOnly = false;
	private _ultimoId = -1;
	private _resultado = "";
	private _tableLinesBuildings = [];
	private _tableLinesVehicles = [];
	while {_resultado isNotEqualTo [] && !_onetimeOnly} do {
		while {_resultado isNotEqualTo [] && !_onetimeOnly} do {
			if (BRPVP_useExtDB3) then {
				_resultado = "extDB3" callExtension format ["0:%1:getObjects:%2",BRPVP_protocolo,_ultimoId];
				_resultado = parseSimpleArray _resultado select 1;
			} else {
				_onetimeOnly = true;
				_resultado = call BRPVP_hdb_query_getObjects;
			};
			{
				private _carga = _x select 2;
				private _modelo = _x select 4;
				private _owner = _x select 5;
				private _trueClassAd = _x select 17;
				private _isMotorizedOrBox = _modelo call BRPVP_isMotorized || _modelo isKindOf ["ReammoBox_F",configFile >> "CfgVehicles"];
				_ultimoId = _x select 0;
				if (_isMotorizedOrBox) then {
					private _virtualGarage = _x select 12;
					if (_virtualGarage isEqualTo 0 && _trueClassAd isEqualTo 0) then {
						_tableLinesVehicles pushBack _x
					} else {
						private _idxPlayer = _playersId find _owner;
						if (_idxPlayer > -1) then {
							//VEHICLE VALOR
							private _idx = _vehsClass find _modelo;
							if (_idx > -1) then {
								private _price = _vehsValor select _idx;
								(_players select _idxPlayer) set [4,(_players select _idxPlayer select 4)+_price];
							};
							//VEHICLE ITEMS VALOR
							(_carga call BRPVP_getCargoArrayValor) params ["_valorItem","_valorFlare"];
							(_players select _idxPlayer) set [5,(_players select _idxPlayer select 5)+_valorItem];
							(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valorFlare];
						};
					};
				} else {
					private _mapa = _x select 8;
					private _ok1 = !(_modelo in ["Land_Sea_Wall_F"]);
					private _ok2 = _modelo in BRPVP_getConsPriceHelpTableB || _mapa;
					private _ok3 = _modelo in ["Land_Carrier_01_base_F","Land_ClutterCutter_medium_F"];
					if (_ok1 && (_ok2 || _ok3)) then {_tableLinesBuildings pushBack _x;};
				};
			} forEach _resultado;
		};
	};

	//SPAWN BUILDINGS
	private _execAll = [];
	{
		private ["_veiculo","_isSO"];
		private _modelo = _x select 4;
		private _owner = _x select 5;
		private _exec = _x select 9;
		if (_modelo isEqualTo "Land_Carrier_01_base_F") then {
			private _idxPlayer = _playersId find _owner;
			if (_idxPlayer > -1) then {(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+BRPVP_carrierPrice];};
		} else {
			private _idxPlayer = _playersId find _owner;
			if (_idxPlayer > -1) then {
				private _price = _modelo call BRPVP_getConstructionPrice;
				(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_price];
			};
		};
		//EXEC OBJECT CODE
		if (_exec isNotEqualTo "") then {_execAll pushBack [_exec,_modelo,_owner];};
	} forEach _tableLinesBuildings;

	//VR PAINT PATRIMONY
	{
		_x params ["_txt","_modelo","_owner"];
		if (_modelo in BRPVP_vrObjectsClasses && _txt find "'] call BRPVP_vrObjectSetTextures;" isNotEqualTo -1) then {
			if (_owner isNotEqualTo -1) then {
				private _idxPlayer = _playersId find _owner;
				if (_idxPlayer isNotEqualto -1) then {(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+BRPVP_vrObjectsPaintPrice];};
			};
		};
	} forEach _execAll;
	{
		private _valor = _x getVariable ["mny",-1];
		private _own = _x getVariable ["own",-1];
		private _idxPlayer = _playersId find _own;
		if (_idxPlayer > -1) then {
			if (_valor > -1) then {
				(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valor];
			} else {
				((_x getVariable "brpvp_box_inventory")  call BRPVP_getCargoArrayValor) params ["_valorItem","_valorFlare"];
				(_players select _idxPlayer) set [5,(_players select _idxPlayer select 5)+_valorItem];
				(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valorFlare];
			};
		};
	} forEach (BRPVP_centroMapa nearObjects ["Land_ClutterCutter_medium_F",BRPVP_centroMapaRadius]);

	//GET ALL BIG FLOORS FROM DB
	private _bfPrice = "BRPVP_bigFloor200" call BRPVP_itemGetPrice;
	if (BRPVP_useExtDB3) then {
		private _ultimoId = -1;
		private _resultado = "";
		while {_resultado isNotEqualTo "[1,[]]"} do {
			while {_resultado isNotEqualTo "[1,[]]"} do {
				_resultado = "extDB3" callExtension format ["0:%1:bfGetAll:%2",BRPVP_protocolo,_ultimoId];
				{
					_x params ["_id","_size","_owner","_posWorld","_holes","_color"];
					private _idxPlayer = _playersId find _owner;
					if (_idxPlayer > -1) then {(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_bfPrice];};
					_ultimoId = _id;
				} forEach (parseSimpleArray _resultado select 1);
			};
		};
	} else {
		{
			_x params ["_id","_size","_owner","_posWorld","_holes","_color"];
			private _idxPlayer = _playersId find _owner;
			if (_idxPlayer > -1) then {(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_bfPrice];};
		} forEach call BRPVP_hdb_query_bfGetAll;
	};

	//SPAWN ENTITIE VEHICLES AND BOXES
	private _paintPrice = "BRPVP_itemPaintVehicle" call BRPVP_itemGetPrice;
	{
		private ["_veiculo","_isSO"];
		_carga = _x select 2;
		_modelo = _x select 4;
		_owner = _x select 5;
		_exec = _x select 9;
		_paint = _x select 13;
		_cover = _x select 14;
		if (_modelo call BRPVP_isMotorizedNoTurret) then {
			//PATRIMONY I
			private _idxPlayer = _playersId find _owner;
			if (_idxPlayer > -1) then {
				(_carga call BRPVP_getCargoArrayValor) params ["_valorItem","_valorFlare"];
				(_players select _idxPlayer) set [5,(_players select _idxPlayer select 5)+_valorItem];
				(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valorFlare];

				private _idx = _vehsClass find _modelo;
				if (_idx > -1) then {
					private _price = _vehsValor select _idx;
					if !(_paint isEqualTo []) then {_price = _price+_paintPrice;};
					(_players select _idxPlayer) set [4,(_players select _idxPlayer select 4)+_price];
				};
			};
		} else {
			if (_modelo in BRPVP_autoTurretTypes) then {
				//PATRIMONY
				private _idxPlayer = _playersId find _owner;
				if (_idxPlayer > -1) then {
					private _isTurretLvl2 = _exec isEqualTo "_this setVariable ['brpvp_tlevel',2,true];";
					private _price = if (_isTurretLvl2) then {"BRP_kitAutoTurretLvl2" call BRPVP_itemGetPrice} else {_modelo call BRPVP_getConstructionPrice};
					(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_price];
				};
			} else {
				//PATRIMONY
				private _idxPlayer = _playersId find _owner;
				if (_idxPlayer > -1) then {
					(_carga call BRPVP_getCargoArrayValor) params ["_valorItem","_valorFlare"];
					(_players select _idxPlayer) set [5,(_players select _idxPlayer select 5)+_valorItem];
					(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valorFlare];

					private _price = _modelo call BRPVP_getConstructionPrice;
					(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_price];
				};
			};
		};
	} forEach _tableLinesVehicles;

	_players apply {[_x#0,_x#1,round (_x#2),round (_x#3),round (_x#4),round (_x#5),round (_x#2+_x#3+_x#4+_x#5)]}
};
BRPVP_salvaEstadoVida = {
	{
		private _pid = _x getVariable ["id_bd",-1];
		if (_pid isNotEqualTo -1) then {
			private _dd = _x getVariable ["dd",-1];
			private _isUnco = _dd isEqualTo 0;
			private _isDead = _dd isEqualTo 1;
			if (_isUnco || _isDead) then {[_pid,[["vivo",0]]] call BRPVP_hdb_query_updatePlayersFieldsById;};
		};
	} forEach call BRPVP_playersList;
};
BRPVP_useAntiAtomicBombContinueServer = {
	private _flag = _this;
	private _objs = nearestObjects [_flag,[],_flag getVariable "brpvp_flag_radius",true] select {isObjectHidden _x && _x getVariable ["id_bd",-1] isNotEqualTo -1};
	private _loopWait = 0.075;
	private _toGreen = [];
	{
		private _obj = _x;
		if (!isNull _obj && isObjectHidden _obj) then {
			private _oId = _obj getVariable "id_bd";
			if (netId _obj isEqualTo "0:0") then {
				if (typeOf _obj in BRPVP_buildingHaveDoorListCVL) then {
					[[typeOf _obj],[[_oId]],false] remoteExecCall ["BRPVP_hideGlobalSimpleObjectCVL",0];
				} else {
					[[typeOf _obj],[[_oId]],false] remoteExecCall ["BRPVP_hideGlobalSimpleObject",0];
				};
			} else {
				_obj hideObjectGlobal false;
			};
			[_oId,""] call BRPVP_updateTurretExec;
			_toGreen pushBack _oId;
			if (count _toGreen isEqualTo 5) then {_toGreen remoteExecCall ["BRPVP_baseBombChangeToGreenMany",0];_toGreen = [];};
		};
		if (1/diag_fps <= _loopWait) then {uiSleep _loopWait;} else {if (random 1 < (1/((1/diag_fps)/_loopWait))) then {uiSleep 0.001;};};
	} forEach _objs;
	if (_toGreen isNotEqualTo []) then {_toGreen remoteExecCall ["BRPVP_baseBombChangeToGreenMany",0];};
	remoteExecCall ["BRPVP_baseBombCalcVisibleLines",call BRPVP_playersList select {_x distance _flag < 750}];

	//SET FLAG TO NO CONSTRUCTION
	if (BRPVP_raidNoConstructionOnBaseIfRaidStarted) then {
		if (!isNull _flag) then {if ([_flag] call BRPVP_isFlagsInRaidMode) then {_flag setVariable ["brpvp_last_intrusion",serverTime,true];};};
	};

	_flag setVariable ["brpvp_anti_abomb_in_use",false,true];
};
BRPVP_vaultTipSaveOnDb = {
	params ["_tip","_pid","_idx"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:playerVaultTipSave:%2:%3:%4",BRPVP_protocolo,_tip,_pid,_idx];
	} else {
		[_pid,_idx,[_tip]] call BRPVP_hdb_query_playerVaultTipSave;
	};
};
BRPVP_receiveVaultsTipsFromServerGet = {
	params ["_id","_mId"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getPlayerVaultTips:%2",BRPVP_protocolo,_id];
		BRPVP_receiveVaultsTipsFromServer = parseSimpleArray _result select 1;
	} else {
		private _result = _id call BRPVP_hdb_query_getPlayerVaultTips;
		BRPVP_receiveVaultsTipsFromServer = _result select 1;
	};
	_mId publicVariableClient "BRPVP_receiveVaultsTipsFromServer";
};
BRPVP_playerHeadItemsServerGet = {
	params ["_id","_mId"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getPlayerHeadItems:%2",BRPVP_protocolo,_id];
		BRPVP_playerHeadItemsServerReturn = parseSimpleArray _result select 1 select 0 select 0;
		if (BRPVP_playerHeadItemsServerReturn isEqualTo "") then {BRPVP_playerHeadItemsServerReturn = [3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]];};
	} else {
		private _result = [_id,["headItems"]] call BRPVP_hdb_query_getPlayersFieldsById;
		BRPVP_playerHeadItemsServerReturn = _result select 0;
	};
	_mId publicVariableClient "BRPVP_playerHeadItemsServerReturn";
};
//FIX INITIAL OVERCAST ON JOINING CLIENT IF USING BRPVP DYNAMIC WEATHER
BRPVP_iAskForInitialVarsJoining = 0;
BRPVP_iAskForInitialVarsJoiningLastTime = 0;
BRPVP_iAskForInitialVarsJoiningRemoveFnc = {BRPVP_iAskForInitialVarsJoining = (BRPVP_iAskForInitialVarsJoining-1) max 0;};
BRPVP_askServerForSyncWeatherProcess = {
	private _player = _this;
	BRPVP_iAskForInitialVarsJoining = BRPVP_iAskForInitialVarsJoining+1;
	BRPVP_iAskForInitialVarsJoiningLastTime = diag_tickTime;
	if (BRPVP_iAskForInitialVarsJoining isEqualTo 1) then {
		BRPVP_weatherOvercastJoingPlayerNow = BRPVP_weatherOvercastNow;
		0 setOvercast BRPVP_weatherOvercastJoingPlayerNow;
		owner _player publicVariableClient "BRPVP_weatherOvercastJoingPlayerNow";
		0 spawn {
			private _ended = BRPVP_iAskForInitialVarsJoining isEqualTo 0;
			waitUntil {
				private _oError = abs (overcast-BRPVP_weatherOvercastJoingPlayerNow);
				if (_oError > 0.02) then {0 setOvercast BRPVP_weatherOvercastJoingPlayerNow;};
				_ended = BRPVP_iAskForInitialVarsJoining isEqualTo 0;
				_ended || diag_tickTime-BRPVP_iAskForInitialVarsJoiningLastTime > 5
			};
			BRPVP_iAskForInitialVarsJoining = 0;
			BRPVP_iAskForInitialVarsJoiningLastTime = 0;
			0 setOvercast (BRPVP_weatherPredictFortClients select 0);
		};
	} else {
		owner _player publicVariableClient "BRPVP_weatherOvercastJoingPlayerNow";
	};
};
BRPVP_reduceAndDeleteSv = {
	_this enableSimulationGlobal false;
	_this spawn {
		private _veh = _this;
		uiSleep 2.5;
		_veh remoteExec ["BRPVP_reduceAndDeleteClient",BRPVP_allNoServer];
		uiSleep 1.25;
		_veh setPosATL BRPVP_posicaoFora;
		_veh setDamage [1,false];
		uiSleep 1.25;
		deleteVehicle _veh;
	};
};
BRPVP_blindPlayersIdClientAsk = {
	params ["_mId","_idBd"];
	BRPVP_blindPlayersIdClientAskReturn = _idBd in BRPVP_blindPlayersId;
	_mId publicVariableClient "BRPVP_blindPlayersIdClientAskReturn";
};
BRPVP_blindPlayersIdAdd = {
	BRPVP_blindPlayersId pushBack _this;
};
BRPVP_blindPlayersIdRemove = {
	BRPVP_blindPlayersId = BRPVP_blindPlayersId-[_this];
};
BRPVP_messageDiscordRaid = {//PPP NECESSARIO APENAS COM O MOD QUE CONECTA O ARMA 3 AO DISCORD
	private _flag = _this;
	private _rad = _flag getVariable "brpvp_flag_radius";
	BRPVP_discordMessageFlagsOnRaid = BRPVP_discordMessageFlagsOnRaid-[objNull];
	if (_flag in BRPVP_discordMessageFlagsOnRaid) then {
		private _lastTime = _flag getVariable "brpvp_last_raid_time";
		_flag setVariable ["brpvp_raid_actions",(_flag getVariable "brpvp_raid_actions")+1];
		if (serverTime-_lastTime > 600) then {
			private _owner = _flag getVariable "own";
			private _result = "extDB3" callExtension format ["0:%1:getObjectOwnerName:%2",BRPVP_protocolo,_owner];
			if (_result isEqualTo "[1,[]]") then {
				BRPVP_discordMessageFlagsOnRaid = BRPVP_discordMessageFlagsOnRaid-[_flag];
			} else {
				private _name = parseSimpleArray _result select 1 select 0 select 0;
				private _ppp = {_x distance2D _flag < _rad+300} count call BRPVP_playersList;
				private _grid = mapGridPosition _flag;
				private _actions = _flag getVariable "brpvp_raid_actions";
				["Raid",[_name,format ["%1:%2",_grid select [0,3],_grid select [3,3]],_rad,_ppp,_actions]] call DiscordEmbedBuilder_fnc_buildCfg;
				_flag setVariable ["brpvp_last_raid_time",serverTime];
			};
		};
	} else {
		BRPVP_discordMessageFlagsOnRaid	pushBack _flag;
		_flag setVariable ["brpvp_last_raid_time",serverTime];
		_flag setVariable ["brpvp_raid_actions",1];
		private _owner = _flag getVariable "own";
		private _result = "extDB3" callExtension format ["0:%1:getObjectOwnerName:%2",BRPVP_protocolo,_owner];
		if (_result isEqualTo "[1,[]]") then {
			BRPVP_discordMessageFlagsOnRaid = BRPVP_discordMessageFlagsOnRaid-[_flag];
		} else {
			private _name = parseSimpleArray _result select 1 select 0 select 0;
			private _ppp = {_x distance2D _flag < _rad+300} count call BRPVP_playersList;
			private _grid = mapGridPosition _flag;
			["Raid",[_name,format ["%1:%2",_grid select [0,3],_grid select [3,3]],_rad,_ppp,1]] call DiscordEmbedBuilder_fnc_buildCfg;
			_flag setVariable ["brpvp_last_raid_time",serverTime];
		};
	};
};
BRPVP_grassCutObjsAdd = {
	{_x setVariable ["brpvp_cut_time",serverTime];} forEach _this;
	BRPVP_grassCutObjs append _this;
};
BRPVP_raidTrainingRealVehDeleteDb = {
	private _id = _this;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:realVehicleDeleteById:%2",BRPVP_protocolo,_id];
	} else {
		_id call BRPVP_hdb_query_realVehicleDeleteById;
	};
};
BRPVP_raidTrainingDigTerrain = {
	setTerrainHeight _this;
};
BRPVP_spawnZombiesServerFromDeadAI = {
	params ["_zombie","_toAttack"];
	private _ownerZombie = owner _zombie;
	private _ownerTarget = owner _toAttack;
	private _localityOk = false;
	private _destineId = 0;
	if (_ownerTarget isEqualTo 2 || BRPVP_countZombieLocality mod BRPVP_zombiePercOnServer isEqualTo 0) then {
		_localityOk = local _zombie || {_zombie setOwner 2};
		_destineId = 2;
	} else {
		_localityOk = _ownerZombie isEqualTo _ownerTarget || {_zombie setOwner _ownerTarget};
		_destineId = _ownerZombie;
	};
	if (_localityOk || {_zombie setOwner _destineId}) then {
		_zombie setVariable ["ifz",selectRandom [1,1,2,2,3],true];
		BRPVP_walkersObj = BRPVP_walkersObj-[objNull];
		BRPVP_walkersObj pushBack _zombie;
		[_zombie] remoteExecCall ["BRPVP_addWalkerIconsClient",-2];
		_zombie setVariable ["brpvp_impact_damage",0,true];
		_zombie addEventHandler ["Local",{call BRPVP_zombieBackToServer;}];
		if (_destineId isEqualTo 2) then {
			{_zombie setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
			{_zombie setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
			[_zombie,_toAttack] call ZB_addAgentFinalize;
		} else {
			_zombie remoteExecCall ["BRPVP_zedsSetBloodyCorpse",_destineId];
			[_zombie,_toAttack] remoteExecCall ["ZB_addAgentFinalize",_destineId];
		};
	} else {
		deleteVehicle _zombie;
	};
};
BRPVP_recordUseOfTantingXp = {
	params ["_pId","_pName","_abilitieId"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:tasteXpAddHistoric:%2:%3:%4",BRPVP_protocolo,_pId,_pName,_abilitieId];
	} else {
		[_pId,[_pName,_abilitieId,systemTime select [0,6]]] call BRPVP_hdb_query_tasteXpAddHistoric;
	};
};
BRPVP_getMyXpTastingHistoric = {
	params ["_mId","_pId","_days"];
	private _result = [];
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:tasteXpGetHistoric:%2:%3",BRPVP_protocolo,_pId,_days];
		_result = parseSimpleArray _result select 1;
	} else {
		_result = [_pid,_days] call BRPVP_hdb_query_tasteXpGetHistoric
	};
	BRPVP_getMyXpTastingHistoricReturn = _result;
	_mId publicVariableClient "BRPVP_getMyXpTastingHistoricReturn";
};
BRPVP_joiningPlayerSetOthersCarryBoxScale = {
	private _player = _this;
	{
		private _box = _x getVariable ["brpvp_box_carry_model",objNull];
		if (!isNull _box) then {_player remoteExecCall ["BRPVP_carryBoxSetScaleOnMeAdd",_x]};
	} forEach call BRPVP_playersList;
};
BRPVP_isFlagsFriendRelaxedServer = {
	params ["_player","_flags"];
	private _pId = if (_player isEqualType objNull) then {_player getVariable "id_bd"} else {_player select 1};
	private _pAmg = if (_player isEqualType objNull) then {_player getVariable "amg"} else {_player select 2};
	private _isFriend = [];
	{
		private _flag = _x;
		if (_flag getVariable ["id_bd",-1] isNotEqualTo -1) then {
			private _flagOwn = _flag getVariable "own";
			private _flagRad = _flag getVariable ["brpvp_flag_radius",0];
			
			//IS SET ON THE FLAG?
			private _isFlagOwner = _flagOwn isEqualTo _pId;
			private _isInFlag = if (_player isEqualType objNull) then {[_player,_flag] call BRPVP_checaAcessoRemotoFlag} else {[_pId,_flag] call BRPVP_checaAcessoRemotoFlagNoObj};
			if (_isFlagOwner || _isInFlag) then {
				_isFriend pushBack _flag;
			} else {
				//IF FRIEND OF PLAYERS ON THE FLAG?
				private _fAmg = (_flag getVariable "amg") select 1;
				_fAmg pushBackUnique _flagOwn;
				private _fAmgFoundOnline = [];
				private _okCnt = 0;
				{
					private _pcId = _x getVariable ["id_bd",-1];
					if (_pcId isNotEqualTo -1 && _pcId in _fAmg) then {
						_fAmgFoundOnline pushBack _pcId;
						if (_pId in _x getVariable "amg") then {_okCnt = _okCnt+1;};
					};
				} forEach call BRPVP_playersList;
				private _fAmgRemain = _fAmg-_fAmgFoundOnline;
				if (_fAmgRemain isNotEqualTo []) then {
					private _idsTxt = [[str _fAmgRemain,"[","("] call BRPVP_stringReplace,"]",")"] call BRPVP_stringReplace;
					{
						_x params ["_faId","_faAmg"];
						if (_pId in _faAmg) then {_okCnt = _okCnt+1;};
					} forEach (_idsTxt call BRPVP_getPlayersAmgDataServer);
				};
				if (_okCnt >= 0.5*count _fAmg) then {_isFriend pushBack _flag;};
			};
		};
	} forEach _flags;
	_isFriend
};
BRPVP_getPlayersAmgDataServer = {//PPP FEITO
	private _idsTxt = _this;
	if (BRPVP_useExtDB3) then {
		private _sql = format ["SELECT `id`, `amigos` FROM `players` WHERE `id` IN %1",_idsTxt];
		private _result = "extDB3" callExtension format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
		parseSimpleArray _result select 1
	} else {
		private _result = [];
		private _lin = [];
		private _ids = parseSimpleArray ([[_idsTxt,"(","["] call BRPVP_stringReplace,")","]"] call BRPVP_stringReplace);
		{
			_lin = BRPVP_pfl_hdb_tb_players getOrDefault [_x,[]];
			if (_lin isNotEqualTo []) then {_result pushBack [_x,_y select 9];};
		} forEach _ids;
		_result
	};
};
BRPVP_getPlayersAmgData = {//PPP FEITO
	params ["_player","_idsTxt"];
	if (BRPVP_useExtDB3) then {
		private _sql = format ["SELECT `id`, `amigos` FROM `players` WHERE `id` IN %1",_idsTxt];
		private _result = "extDB3" callExtension format ["0:%1:%2",BRPVP_protocoloRawText,_sql];
		BRPVP_getPlayersAmgDataReturn = parseSimpleArray _result select 1;
	} else {
		private _result = [];
		private _lin = [];
		private _ids = parseSimpleArray ([[_idsTxt,"(","["] call BRPVP_stringReplace,")","]"] call BRPVP_stringReplace);
		{
			_lin = BRPVP_pfl_hdb_tb_players getOrDefault [_x,[]];
			if (_lin isNotEqualTo []) then {_result pushBack [_x,_y select 9];};
		} forEach _ids;
		BRPVP_getPlayersAmgDataReturn = _result;
	};
	(owner _player) publicVariableClient "BRPVP_getPlayersAmgDataReturn";
};
BRPVP_trenchDigServer = {
	params ["_player","_vertex","_hNow","_newH"];
	[_player,["trench",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
	setTerrainHeight [[_vertex+[_hNow+(_newH-_hNow)*0.5]],true];
	uiSleep 0.25;
	setTerrainHeight [[_vertex+[_hNow+(_newH-_hNow)*0.8]],true];
	uiSleep 0.25;
	setTerrainHeight [[_vertex+[_hNow+(_newH-_hNow)*1.0]],true];
};
BRPVP_saveLightStateDbsimpleObject = {
	params ["_lamp","_id","_state"];
	if (_state) then {_lamp setDamage 0;} else {_lamp setDamage 0.9;};
	if (_id isNotEqualTo -1) then {
		private _exec = if (_state) then {"_this setDamage 0;"} else {"_this setDamage 0.9;"};
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:saveVehicleExec:%2:%3",BRPVP_protocolo,_exec,_id];
		} else {
			[_id,[["exec",_exec]]] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
	};
};
BRPVP_getSmartTvConnectionsFromSv = {
	params ["_steamId","_ownerMid"];
	private _result = [];
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:secCamGetConnections:%2",BRPVP_protocolo,_steamId];
		_result = parseSimpleArray _result select 1 select 0 select 0;
	} else {
		_result = _steamId call BRPVP_hdb_query_secCamGetConnections;
	};
	BRPVP_getSmartTvConnectionsFromSvAnswer = _result;
	_ownerMid publicVariableClient "BRPVP_getSmartTvConnectionsFromSvAnswer";
};
BRPVP_secCamSaveConnectionsDb = {
	private _player = _this;
	private _pId = _player getVariable "id_bd";
	private _conn = _player getVariable ["brpvp_seccam_connections",[]];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:secCamSaveConnections:%2:%3",BRPVP_protocolo,_conn,_pId];
	} else {
		[_pId,_conn] call BRPVP_hdb_query_secCamSaveConnections;
	};
};
BRPVP_updateSecCamDb = {
	params ["_id","_amg"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:secCamUpdateAmg:%2:%3",BRPVP_protocolo,_amg,_id];
	} else {
		[_id,_amg] call BRPVP_hdb_query_secCamUpdateAmg;
	};
};
BRPVP_secCamRemoveDb = {
	private _id = _this;
	if (BRPVP_useExtDB3) then {"extDB3" callExtension format ["1:%1:secCamDelete:%2",BRPVP_protocolo,_id];} else {_id call BRPVP_hdb_query_secCamDelete;};
};
BRPVP_secCamAddDb = {
	params ["_cam","_posASL","_vdu","_own","_amg"];
	private _id = -1;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["0:%1:secCamCreate:%2:%3:%4:%5",BRPVP_protocolo,_posASL,_vdu,_own,_amg];
		private _result = "extDB3" callExtension format ["0:%1:secCamGetId:%2:%3:%4:%5",BRPVP_protocolo,_posASL,_vdu,_own,_amg];
		_id = parseSimpleArray _result select 1 select 0 select 0;
	} else {
		_id = [_posASL,_vdu,_own,_amg] call BRPVP_hdb_query_secCamCreate;
	};
	_cam setVariable ["brpvp_cam_id",_id,true];
	_cam remoteExecCall ["BRPVP_secCamAddArray",0];
};
BRPVP_setVehLastPlayers = {
	params ["_id","_vehicle","_action"];
	private _lp = _vehicle getVariable ["brpvp_auto_magus_last_players",[]];
	if (_action isEqualTo "add") then {_lp pushBackUnique _id;} else {_lp = _lp-[_id];};
	_vehicle setVariable ["brpvp_auto_magus_last_players",_lp];
};
BRPVP_vehConsumeLifesFixDb = {
	params ["_idBd","_lifesFix"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:updateLifesFix:%2:%3",BRPVP_protocolo,_lifesFix,_idBd];
	} else {
		[_idBd,[["lifesFix",_lifesFix]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_torqueSetBetter = {
	params ["_player","_veh"];
	if (_veh getVariable ["brpvp_original_mass",-1] isEqualTo -1) then {
		_veh setVariable ["brpvp_original_mass",getMass _veh,true];
		[_veh,0.5*getMass _veh] remoteExecCall ["setMass",0];
		BRPVP_torqueAddResult = true;
	} else {
		BRPVP_torqueAddResult = false;
	};
	(owner _player) publicVariableClient "BRPVP_torqueAddResult";
};
BRPVP_serverRealPing = {
	remoteExecCall ["BRPVP_clientRealPing",_this];
};
BRPVP_setZombieOwnerCreatedServer = {
	params ["_agnts","_target",["_forceSV",false]];
	_oT = owner _target;
	_agntsOnClient = [];
	{
		if (_oT isEqualTo 2 || BRPVP_countZombieLocality mod BRPVP_zombiePercOnServer isEqualTo 0 || _forceSV) then {
			if (local _x || {_x setOwner 2}) then {[_x,_target] call ZB_addAgentFinalize;} else {deleteVehicle _x;};
		} else {
			if (_x setOwner _oT) then {_agntsOnClient pushBack _x;} else {deleteVehicle _x;};
		};
		if !(_oT isEqualTo 2) then {BRPVP_countZombieLocality = BRPVP_countZombieLocality+1;};
	} forEach _agnts;
	if !(_agntsOnClient isEqualTo []) then {[_agntsOnClient,_target] remoteExecCall ["ZB_addAgentFinalizeGroup",_oT];};
};
BRPVP_setZombieOwnerCreatedServerAI = {
	params ["_ais","_target",["_forceSV",false]];
	_oT = owner _target;
	_aisOnClient = [];
	{
		if (_oT isEqualTo 2 || BRPVP_countZombieLocality mod BRPVP_zombiePercOnServer isEqualTo 0 || _forceSV) then {
			[_x,_target] call ZB_addAgentFinalize;
		} else {
			if (group _x setGroupOwner _oT) then {_aisOnClient pushBack _x;} else {deleteVehicle _x;};
		};
		if (_oT isNotEqualTo 2) then {BRPVP_countZombieLocality = BRPVP_countZombieLocality+1;};
	} forEach _ais;
	if (_aisOnClient isNotEqualTo []) then {[_aisOnClient,_target] remoteExecCall ["ZB_addAgentFinalizeGroup",_oT];};
};
BRPVP_insuranceSetSequence = {
	params ["_id","_sequence"];
	private ["_key","_result"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:setInsuranceSequence:%2:%3",BRPVP_protocolo,_sequence,_id];
		_result = "extDB3" callExtension _key;
	} else {
		_key = "[_id,[[""sequence"",_sequence]]] call BRPVP_hdb_query_updateInsurancesFieldsById";
		_result = [_id,[["sequence",_sequence]]] call BRPVP_hdb_query_updateInsurancesFieldsById;
	};
	diag_log ("======== SET INSURANCE SEQUENCE ======");
	diag_log ("======== _key: "+_key+" | _result: "+_result+" ======");
};
BRPVP_itemMagnetOnHold = [];
BRPVP_itemMagnetCanServer = {
	params ["_id","_nwh"];
	private _oh = [];
	BRPVP_itemMagnetOnHold = (BRPVP_itemMagnetOnHold apply {if (serverTime-(_x select 0) > 5) then {-1} else {_oh append (_x select 1);_x};})-[-1];
	BRPVP_itemMagnetCanServerReturn = _nwh-_oh;
	if (BRPVP_itemMagnetCanServerReturn isNotEqualTo []) then {BRPVP_itemMagnetOnHold pushBack [serverTime,BRPVP_itemMagnetCanServerReturn];};
	_id publicVariableClient "BRPVP_itemMagnetCanServerReturn";
	diag_log ("======= [BRPVP CHECK IF CAN USE MAGNET ON ITEM POOLS]: =============");
	diag_log str [_id,count _nwh,count BRPVP_itemMagnetCanServerReturn];
	diag_log ("====================================================================");
};
BRPVP_removeBigFloorFromDb = {
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:bfRemove:%2",BRPVP_protocolo,_this];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "_this call BRPVP_hdb_query_bfRemove";
		_resultado = _this call BRPVP_hdb_query_bfRemove;
	};
	diag_log ("======= [BRPVP BIG FLOOR REMOVED FROM DB]: =========================");
	diag_log str [_key,_resultado];
	diag_log ("====================================================================");
};
BRPVP_bigFloorCreateRaidMission = {
	params ["_id","_pw","_holes","_owner"];
	[_id,_pw,_holes,_owner] remoteExecCall ["BRPVP_creatBigFloor200",0];
	[_id,_pw,_holes,_owner] remoteExecCall ["BRPVP_addNewBigFloorEntry",0];
};
BRPVP_bigFloorCreateAndSaveServer = {
	params ["_p","_size","_owner","_pw","_holes","_color"];
	private _newId = -1;
	if (BRPVP_useExtDB3) then {
		//SAVE FLOOR
		"extDB3" callExtension format ["0:%1:bfAddNew:%2:%3:%4:%5:%6",BRPVP_protocolo,_size,_owner,_pw,_holes,_color];
		//GET NEW FLOOR ID
		private _resultado = "extDB3" callExtension format ["0:%1:bfGetLastId",BRPVP_protocolo];
		_newId = parseSimpleArray _resultado select 1 select 0 select 0;
	} else {
		_newId = [_size,_owner,_pw,_holes,_color] call BRPVP_hdb_query_bfAddNew;
	};
	[_newId,_pw,_holes,_owner] remoteExecCall ["BRPVP_creatBigFloor200",0];
	[_newId,_pw,_holes,_owner] remoteExecCall ["BRPVP_addNewBigFloorEntry",0];
	BRPVP_bigFloorCreationOk = true;
	(owner _p) publicVariableClient "BRPVP_bigFloorCreationOk";

	diag_log ("======= [BRPVP BIG FLOOR CREATED]: =================================");
	diag_log str ["[_newId,_pw,_holes,_owner]",[_newId,_pw,_holes,_owner]];
	diag_log ("====================================================================");
};
BRPVP_classAdAltiRemoveAuto = {
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:classAdRemoveItemAuto",BRPVP_protocolo];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "call BRPVP_hdb_query_classAdRemoveItemAuto;";
		_resultado = call BRPVP_hdb_query_classAdRemoveItemAuto;
	};
	diag_log ("======= [BRPVP ALL TEMPORARY CLASS AD ITEMS REMOVED]:===============");
	diag_log str [_key,_resultado];
	diag_log ("====================================================================");
};
BRPVP_plauncherExplodeBomb = {
	params ["_player","_fix"];
	createVehicle ["HelicopterExploBig",ASLToAGL getPosASL _player vectorAdd _fix,[],0,"CAN_COLLIDE"] setShotParents [_player,_player];
	BRPVP_plauncherExplodeBombOk = true;
	(owner _player) publicVariableClient "BRPVP_plauncherExplodeBombOk";
};
BRPVP_tireVehUpdatePos = {//RESOLVIDO
	params ["_id","_spatialTxt"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:tireVehUpdateSpatial:%2:%3",BRPVP_protocolo,_spatialTxt,_id];
	} else {
		private _posDB = parseSimpleArray _spatialTxt;
		[_id,[["posicao",_posDB]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_getForceSpotLimitSV = {
	params ["_mid","_uid"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getForceSpotLimit:%2",BRPVP_protocolo,_uid];
		_result = parseSimpleArray _result select 1;
		BRPVP_getForceSpotLimitReturn = if (_result isEqualTo []) then {0} else {_result select 0 select 0};
	} else {
		private _result = [_uid,["forceSpotLimit"]] call BRPVP_hdb_query_getPlayerFieldsBySid;
		BRPVP_getForceSpotLimitReturn = if (_result isEqualTo []) then {0} else {_result select 0};
	};
	_mid publicVariableClient "BRPVP_getForceSpotLimitReturn";
};
BRPVP_getForceCityRespawnSV = {
	params ["_mid","_uid"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getForceCityRespawn:%2",BRPVP_protocolo,_uid];
		_result = parseSimpleArray _result select 1;
		BRPVP_getForceCityRespawnReturn = if (_result isEqualTo []) then {false} else {[false,true] select (_result select 0 select 0)};
	} else {
		private _result = [_uid,["forceCityRespawn"]] call BRPVP_hdb_query_getPlayerFieldsBySid;
		BRPVP_getForceCityRespawnReturn = if (_result isEqualTo []) then {false} else {[false,true] select (_result select 0)};
	};
	_mid publicVariableClient "BRPVP_getForceCityRespawnReturn";
};
BRPVP_getExtraBankSV = {
	params ["_mid","_uid"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getExtraBank:%2",BRPVP_protocolo,_uid];
		_result = parseSimpleArray _result select 1;
		BRPVP_getExtraBankReturn = if (_result isEqualTo []) then {0} else {_result select 0 select 0};
	} else {
		private _result = [_uid,["extraBank"]] call BRPVP_hdb_query_getPlayerFieldsBySid;
		BRPVP_getExtraBankReturn = if (_result isEqualTo []) then {0} else {_result select 0};
	};
	_mid publicVariableClient "BRPVP_getExtraBankReturn";
};
BRPVP_getPlayerNamesSv = {
	params ["_co","_id"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getPlayerNames:%2",BRPVP_protocolo,_id];
		BRPVP_getPlayerNamesReturn = parseSimpleArray _result select 1;
	} else {
		BRPVP_getPlayerNamesReturn = _id call BRPVP_hdb_query_getPlayerNames;
	};
	_co publicVariableClient "BRPVP_getPlayerNamesReturn";
};
BRPVP_removeClassAdItem = {
	private _id = _this;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:classAdRemoveItem:%2",BRPVP_protocolo,_id];
	} else {
		_id call BRPVP_hdb_query_classAdRemoveItem;
	};
};
BRPVP_classAdItemSpawn = {//PPP FEITO
	params ["_id","_player"];
	private _result = [];
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:classAddItemGet:%2",BRPVP_protocolo,_id];
		_result = parseSimpleArray _result select 1 select 0;
	} else {
		_result = _id call BRPVP_hdb_query_classAddItemGet;
	};
	_result params ["_cargo","_classname"];
	if (_classname in ["alt+i","alt+i (auto)"]) then {
		_veh = objectParent _player;
		_pos = if (isNull _veh) then {[_player,1,getDir _player+selectRandom [90,-90]] call BIS_fnc_relPos} else {[_player,5,getDir _veh+selectRandom [90,-90]] call BIS_fnc_relPos};
		_pos = [_pos select 0,_pos select 1,(ASLToAGL getPosASL _player select 2)+1];
		_obj = [_pos,_cargo] call BRPVP_spcItemsLootCreate;
		_obj setVariable ["own",_player getVariable ["id_bd",-1],true];
		_obj setVariable ["stp",_player getVariable ["dstp",1],true];
		_obj setVariable ["amg",[_player getVariable ["amg",[]],[],true],true];
	} else {
		private _wh = createVehicle [_classname,[0,0,0],[],100,"CAN_COLLIDE"];
		_wh setPosASL getPosASL _player;
		[_wh,_cargo] call BRPVP_putItemsOnCargo;
		_wh setVariable ["own",_player getVariable ["id_bd",-1],true];
		_wh setVariable ["stp",_player getVariable ["dstp",1],true];
		_wh setVariable ["amg",[_player getVariable ["amg",[]],[],true],true];
	};
};
BRPVP_classAdItemListMySv = {
	private _classAdITemListMyReturn = [];
	private _pId = _this getVariable ["id_bd",-1];
	if (BRPVP_useExtDB3) then {
		private _lastId = -1;
		private _result = [1];
		while {_result isNotEqualTo []} do {
			_result = "extDB3" callExtension format ["0:%1:classAdItemListMy:%2:%3",BRPVP_protocolo,_lastId,_pId];
			_result = parseSimpleArray _result select 1;
			_classAdItemListMyReturn append _result;
			if (_result isNotEqualTo []) then {_lastId = _result select (count _result-1) select 0;};
		};
	} else {
		_classAdITemListMyReturn = _pId call BRPVP_hdb_query_classAdItemListMy;
	};
	BRPVP_classAdITemListMyReturn = _classAdITemListMyReturn;
	(owner _this) publicVariableClient "BRPVP_classAdItemListMyReturn";
};
BRPVP_classAdItemListSv = {
	private _classAdItemListReturn = [];
	private _pId = _this getVariable ["id_bd",-1];
	if (BRPVP_useExtDB3) then {
		private _lastId = -1;
		private _result = [1];
		while {_result isNotEqualTo []} do {
			_result = "extDB3" callExtension format ["0:%1:classAdItemList:%2:%3",BRPVP_protocolo,_pId,_lastId];
			_result = parseSimpleArray _result select 1;
			_classAdItemListReturn append _result;
			if (_result isNotEqualTo []) then {_lastId = _result select (count _result-1) select 0;};
		};
	} else {
		_classAdItemListReturn = _pId call BRPVP_hdb_query_classAdItemList;
	};
	BRPVP_classAdItemListReturn = _classAdItemListReturn;
	(owner _this) publicVariableClient "BRPVP_classAdItemListReturn";
};
BRPVP_addClassAdItem = {
	params ["_itemCargo","_itemClass","_itemPrice","_pId","_pName","_pXp","_adName","_adDescr","_adFake"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:classAdAddItem:%2:%3:%4:%5:%6:%7:%8:%9",BRPVP_protocolo,_itemCargo,_itemClass,_itemPrice,_pId,_pName,_pXp,_adName,_adDescr];
	} else {
		[_itemCargo,_itemClass,_itemPrice,_pId,_pName,_pXp,_adName,_adDescr] call BRPVP_hdb_query_classAdAddItem;
	};
	
};
BRPVP_bankMoneyChange = {
	params ["_idBd","_money"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:changePlayerBankMoneyAdd:%2:%3",BRPVP_protocolo,_money,_idBd];
	} else {
		[_idBd,[["money_bank",_money]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
};
BRPVP_classAdVehicleSpawn = {
	params ["_id","_player"];
	private ["_result"];
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:getObject:%2",BRPVP_protocolo,_id];
	} else {
		_result = _id call BRPVP_hdb_query_getObject;
	};
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["0:%1:classAdRemoveVehicleMark:%2",BRPVP_protocolo,_id];
	} else {
		[_id,[["trueClassAd",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
	[_player,_result] remoteExecCall ["BRPVP_classAdVehicleSpawnHC",2];
};
BRPVP_classAdVehicleListMySv = {
	BRPVP_classAdVehicleListMyReturn = [];
	private _lastId = -1;
	private _result = [1];
	private _pId = _this getVariable ["id_bd",-1];
	private _classAdVehicleListMyReturn = [];
	if (BRPVP_useExtDB3) then {
		while {_result isNotEqualTo []} do {
			_result = "extDB3" callExtension format ["0:%1:classAdVehicleListMy:%2:%3",BRPVP_protocolo,_lastId,_pId];
			_result = parseSimpleArray _result select 1;
			_classAdVehicleListMyReturn append _result;
			if (_result isNotEqualTo []) then {_lastId = _result select (count _result-1) select 0;};
		};
	} else {
		_classAdVehicleListMyReturn = _pId call BRPVP_hdb_query_classAdVehicleListMy;
	};
	BRPVP_classAdVehicleListMyReturn = _classAdVehicleListMyReturn;
	(owner _this) publicVariableClient "BRPVP_classAdVehicleListMyReturn";
};
BRPVP_classAdVehicleListSv = {
	BRPVP_classAdVehicleListReturn = [];
	private _lastId = -1;
	private _result = [1];
	private _pId = _this getVariable ["id_bd",-1];
	private _classAdVehicleListReturn = [];
	if (BRPVP_useExtDB3) then {
		while {_result isNotEqualTo []} do {
			_result = "extDB3" callExtension format ["0:%1:classAdVehicleList:%2:%3",BRPVP_protocolo,_pId,_lastId];
			_result = parseSimpleArray _result select 1;
			_classAdVehicleListReturn append _result;
			if (_result isNotEqualTo []) then {_lastId = _result select (count _result-1) select 0;};
		};
	} else {
		_classAdVehicleListReturn = _pId call BRPVP_hdb_query_classAdVehicleList;
	};
	BRPVP_classAdVehicleListReturn = _classAdVehicleListReturn;
	(owner _this) publicVariableClient "BRPVP_classAdVehicleListReturn";
};
BRPVP_removeClassAdVehicle = {
	private _vehId = _this;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:classAdRemoveVehicle:%2",BRPVP_protocolo,_vehId];
	} else {
		_vehId call BRPVP_hdb_query_classAdRemoveVehicle;
	};
};
BRPVP_addClassAdVehicle = {
	params ["_vehId","_vehClass","_vehPrice","_pId","_pName","_pXp","_adName","_adDescr","_adFake"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:classAdAddVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10",BRPVP_protocolo,_vehId,_vehClass,_vehPrice,_pId,_pName,_pXp,_adName,_adDescr,_adFake];
	} else {
		private _data = [_vehId,_vehClass,_vehPrice,_pId,_pName,_pXp,_adName,_adDescr,_adFake];
		[_vehId,_data] call BRPVP_hdb_query_classAdAddVehicle;
	};
	if (_adFake isEqualTo []) then {
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:classAdMarkVehicle:%2",BRPVP_protocolo,_vehId];
		} else {
			[_vehId,[["trueClassAd",1]]] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
	};
};
BRPVP_classAdVehicleCheckStatusSv = {
	params ["_p","_vehId"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:classAdCheckVehicleState:%2",BRPVP_protocolo,_vehId];
		BRPVP_classAdVehicleCheckStatusReturn = parseSimpleArray _result select 1;
	} else {
		BRPVP_classAdVehicleCheckStatusReturn = _vehId call BRPVP_hdb_query_classAdCheckVehicleState;
	};
	(owner _p) publicVariableClient "BRPVP_classAdVehicleCheckStatusReturn";
};
BRPVP_radioAreasExtra = [];
BRPVP_radioAreasAddArea = {BRPVP_radioAreasExtra pushBack _this;};
BRPVP_radioAreasRemoveArea = {
	private _key = _this;
	private _idx = -1;
	{if (_x select 2 isEqualTo _key) exitWith {_idx = _forEachIndex;};} forEach BRPVP_radioAreasExtra;
	if (_idx isNotEqualTo -1) then {BRPVP_radioAreasExtra deleteAt _idx;};
};
BRPVP_extraPosCheckSv = [];
BRPVP_addNewPosCheckLayer = {BRPVP_extraPosCheckSv pushBack _this;};
BRPVP_removePosCheckLayer = {{if (_x select 2 isEqualTo _this) exitWith {BRPVP_extraPosCheckSv deleteAt _forEachIndex;};} forEach BRPVP_extraPosCheckSv;};
BRPVP_addPvpArea = {
	private ["_mark"];
	private _key = _this select 3;
	BRPVP_PVPAreas pushBack _this;

	_mark = createMarker ["PVP_MARK_AA"+_key,_this select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (4/4);
	_mark setMarkerSize [_this select 1,_this select 1];

	_mark = createMarker ["PVP_MARK_AB"+_key,_this select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (3/4);
	_mark setMarkerSize [(_this select 1)+10,(_this select 1)+10];

	_mark = createMarker ["PVP_MARK_AC"+_key,_this select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (2/4);
	_mark setMarkerSize [(_this select 1)+20,(_this select 1)+20];

	_mark = createMarker ["PVP_MARK_AD"+_key,_this select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (1/4);
	_mark setMarkerSize [(_this select 1)+30,(_this select 1)+30];

	_mark = createMarker ["PVP_MARK_B"+_key,_this select 0];
	_mark setMarkerShape "ICON";
	_mark setMarkerType "mil_dot";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerText call (_this select 2);
};
BRPVP_removePvpArea = {
	deleteMarker ("PVP_MARK_AA"+_this);
	deleteMarker ("PVP_MARK_AB"+_this);
	deleteMarker ("PVP_MARK_AC"+_this);
	deleteMarker ("PVP_MARK_AD"+_this);
	deleteMarker ("PVP_MARK_B"+_this);
	{if (count _x > 3 && {_x select 3 isEqualTo _this}) exitWith {BRPVP_PVPAreas deleteAt _forEachIndex;};} forEach BRPVP_PVPAreas;
};
BRPVP_reviveDeadBase = {
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["0:%1:reviveDeadBase:%2",BRPVP_protocolo,_this];
		"extDB3" callExtension format ["0:%1:reviveDeadBaseDelInfo:%2",BRPVP_protocolo,_this];
		"extDB3" callExtension format ["0:%1:saveFlagPayment:%2:%3",BRPVP_protocolo,BRPVP_sessionTimeStamp,_this];
	} else {
		_this call BRPVP_hdb_query_reviveDeadBase;
		_this call BRPVP_hdb_query_reviveDeadBaseDelInfo;
		[_this,[["lastPayment",BRPVP_sessionTimeStamp]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_getDeadBasesFlags = {
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getDeadBases",BRPVP_protocolo];
		BRPVP_getDeadBasesFlagsReturn = parseSimpleArray _result select 1;
	} else {
		BRPVP_getDeadBasesFlagsReturn = [];
	};
	_this publicVariableClient "BRPVP_getDeadBasesFlagsReturn";
};
BRPVP_playerAddLog = {
	if (BRPVP_useExtDB3) then {
		params ["_playerActionId","_playerActionName","_action","_valor","_playerId","_playerName"];
		private ["_key","_result"];
		_key = format ["1:%1:playerAddLog:%2:%3:%4:%5:%6:%7",BRPVP_protocolo,_playerActionId,_playerActionName,_action,_valor,_playerId,_playerName];
		_result = "extDB3" callExtension _key;
		diag_log ("======== ADD PLAYER LOG: "+_key+" ======");
	} else {
		//NOTHING IF CLIENTSV
	};
};
BRPVP_vehSaveNoCalcData = {//OK
	params ["_id_bd","_estadoCarro"];
	private ["_key","_resultado"];
	if (_id_bd > -1) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14",BRPVP_protocolo,_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,_estadoCarro select 9,_estadoCarro select 10,_estadoCarro select 11,_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _data = [_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,_estadoCarro select 9,_estadoCarro select 10,_estadoCarro select 11];
			_key = "[_id_bd,_data] call BRPVP_hdb_query_saveVehicle";
			_resultado = [_id_bd,_data] call BRPVP_hdb_query_saveVehicle;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATE VEHICLE BEFORE DIE: _key = "+str _key+".");
		diag_log ("[BRPVP] UPDATE VEHICLE BEFORE DIE: _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_serverHideBombedObject = {
	private _obj = _this;
	if (netId _obj isEqualTo "0:0") then {
		if (typeOf _obj in BRPVP_buildingHaveDoorListCVL) then {
			[[typeOf _obj],[[_obj getVariable ["id_bd",-1]]],true] remoteExecCall ["BRPVP_hideGlobalSimpleObjectCVL",0];
		} else {
			[[typeOf _obj],[[_obj getVariable ["id_bd",-1]]],true] remoteExecCall ["BRPVP_hideGlobalSimpleObject",0];
		};
	} else {
		[_obj,true] remoteExecCall ["hideObjectGlobal",2];
	};
	_drawCoords = [[_obj],2,[1,0,0,1]] call BRPVP_getCubeDrawCoords;
	_drawCoords remoteExecCall ["BRPVP_baseBombAddLines",0];
};
BRPVP_forceSubPos = {
	params ["_sub","_subPos"];
	_sub setVectorUp surfaceNormal _subPos;
	_sub setPosATL (_subPos vectorAdd [0,0,10]);
	_sub enableSimulationGlobal false;
};
BRPVP_pmissCreateCarrierCfg = {
	params ["_pFix","_posShip","_vdu","_doorOff"];
	_carrier = createVehicle ["Land_Carrier_01_base_F",[0,0,0],[],0,"CAN_COLLIDE"];
	_carrier setVariable ["bis_carrierparts",_carrier getVariable "bis_carrierparts",true];
	_carrier setPosWorld (_posShip vectorAdd _pFix);
	_carrier setVectorDirAndUp _vdu;
	[_carrier] call BIS_fnc_carrier01PosUpdate;
	[_carrier] remoteExecCall ["BIS_fnc_carrier01Init",BRPVP_allNoServer,true];
	{
		_x params ["_class","_positions"];
		{
			_x params ["_obj","_other"];
			if (typeOf _obj isEqualTo _class) then {_obj setVariable ["brpvp_door_off",_positions,true];};
		} forEach (_carrier getVariable "bis_carrierparts");
	} forEach _doorOff;
	[_carrier,0] remoteExecCall ["setFeatureType",0];
};
BRPVP_pmissCreateDestroyerCfg = {
	params ["_pFix","_posShip","_vdu","_doorOff"];
	_destroyer = createVehicle ["Land_Destroyer_01_base_F",[0,0,0],[],0,"CAN_COLLIDE"];
	_destroyer setVariable ["bis_carrierparts",_destroyer getVariable "bis_carrierparts",true];
	_destroyer setPosWorld (_posShip vectorAdd _pFix);
	_destroyer setVectorDirAndUp _vdu;
	[_destroyer] call BIS_fnc_destroyer01PosUpdate;
	[_destroyer] remoteExecCall ["BIS_fnc_destroyer01Init",BRPVP_allNoServer,true];
	{
		_x params ["_class","_positions"];
		{
			_x params ["_obj","_other"];
			if (typeOf _obj isEqualTo _class) then {_obj setVariable ["brpvp_door_off",_positions,true];};
		} forEach (_destroyer getVariable "bis_carrierparts");
	} forEach _doorOff;
	[_destroyer,0] remoteExecCall ["setFeatureType",0];
};
BRPVP_pmissCreateDestroyer = {
	_pFix = _this;
	_pw = [15334.4,14381.8,0] vectorAdd _pFix;
	_destroyer = createVehicle ["Land_Destroyer_01_base_F",[0,0,0],[],0,"CAN_COLLIDE"];
	_destroyer setVariable ["bis_carrierparts",_destroyer getVariable "bis_carrierparts",true];
	_destroyer setPosWorld _pw;
	_destroyer setVectorDirAndUp [[-0.43,-0.9,0],[0,0,1]];
	[_destroyer] call BIS_fnc_destroyer01PosUpdate;
	[_destroyer] remoteExecCall ["BIS_fnc_destroyer01Init",BRPVP_allNoServer,true];
	{
		_x params ["_class","_positions"];
		{
			_x params ["_obj","_other"];
			if (typeOf _obj isEqualTo _class) then {_obj setVariable ["brpvp_door_off",_positions,true];};
		} forEach (_destroyer getVariable "bis_carrierparts");
	} forEach [["Land_Destroyer_01_interior_02_F",[[1.7,19.7,11.0],[6.6,8.5,19.8],[-6.9,8.5,19.8]]]];
	[_destroyer,0] remoteExecCall ["setFeatureType",0];

	//KEEP DOORS OPEN
	(((_destroyer getVariable "bis_carrierparts") apply {_x select 0})-[objNull]) spawn {
		private _init = diag_tickTime;
		private _bdPart = (_this select {typeOf _x isEqualTo "Land_Destroyer_01_hull_04_F"}) select 0;
		waitUntil {
			{
				private _bui = _x;
				private _sBui = typeOf _bui isEqualTo "Land_Destroyer_01_interior_02_F";
				{
					private _sDoor = _sBui && _x in ["door_1_rotate","door_1_handle_rotate_1","door_3_open","door_4_open"];
					if (!_sDoor) then {if (_x find "door_" isEqualTo 0) then {if (_bui animationPhase _x isEqualTo 0) then {_bui animate [_x,1]};};};
				} forEach animationNames _bui;
			} forEach _this;
			if (diag_tickTime-_init >= 20) then {
				_init = diag_tickTime;
				private _newState = [1,0] select ((_bdPart animationPhase "door_hangar_1_1_open") > 0);
				{_bdPart animate [_x,_newState,2];} forEach ["door_hangar_1_1_open","door_hangar_1_2_open","door_hangar_1_3_open","door_hangar_2_1_open","door_hangar_2_2_open","door_hangar_2_3_open"];
			};
			uiSleep 2.5;
			count (_this select {isNull _x}) isEqualTo count _this
		};
	};
};
BRPVP_setTurretLvl2Explosion = {
	params ["_veh","_instigator","_mPos"];
	private _AT = createVehicle [BRPVP_autoTurretHmgLvl2Rocket,_veh modelToWorld _mPos,[],0,"CAN_COLLIDE"];
	_AT setShotParents [_instigator,_instigator];
	_vel = (vectorNormalized (_veh vectorModelToWorld _mPos)) vectorMultiply -200;
	_AT setVectorDir _vel;
	_AT setVelocity _vel;
};
BRPVP_updatePlayerActivePerks = {
	params ["_id","_perks"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:updatePlayerPerks:%2:%3",BRPVP_protocolo,_perks,_id];
	} else {
		[_id,[["perks",_perks]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
};
BRPVP_enableSimulationGlobalTurret = {
	if (_this isKindOf "StaticWeapon") then {
		private _inpulse = _this getVariable ["brpvp_inpulse",false];
		if (_inpulse) then {
			_this remoteExecCall ["BRPVP_wakeUpSetVelocity",_this];
			_this setVariable ["brpvp_inpulse",false,2];
		};
	};
	_this enableSimulationGlobal true;
};
BRPVP_enableSimulationGlobal = {
	{
		_x params ["_ai","_veh","_enabled","_hidden"];
		_ai enableSimulationGlobal _enabled;
		_ai hideObjectGlobal _hidden;
		if (!isNull _veh) then {
			_veh remoteExecCall ["BRPVP_wakeUpSetVelocity",_veh];
			_veh enableSimulationGlobal _enabled;
			_veh hideObjectGlobal _hidden;
		};
	} forEach _this;
};
BRPVP_veiculoMorreuSimpleObject = {
	if (_this > -1) then {
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_this];
		} else {
			[_this,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
	};
};
BRPVP_salvaVeiculoAmgOnlySql = {
	params ["_id_bd","_carroVivo","_own","_stp","_amg"];
	private ["_key","_resultado"];
	if (_id_bd > -1 && _carroVivo) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicleAmg:%2:%3:%4:%5",BRPVP_protocolo,_own,_stp,_amg,_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			_key = "[_id_bd,[[""owner"",_own],[""comp"",_stp],[""amigos"",_amg]]] call BRPVP_hdb_query_updateVehicleFieldsById";
			_resultado = [_id_bd,[["owner",_own],["comp",_stp],["amigos",_amg]]] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATE SO VEHICLE FRIENDS: _key = "+_key+".");
		diag_log ("[BRPVP] UPDATE SO VEHICLE FRIENDS: _resultado = "+_resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_salvaVeiculoOnlySql = {
	params ["_id_bd","_estadoCarro"];
	private ["_key","_resultado"];
	if (_id_bd > -1) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14",BRPVP_protocolo,_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,_estadoCarro select 9,_estadoCarro select 10,_estadoCarro select 11,_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _data = [_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,_estadoCarro select 9,_estadoCarro select 10,_estadoCarro select 11];
			_key = "[_id_bd,_data] call BRPVP_hdb_query_saveVehicle";
			_resultado = [_id_bd,_data] call BRPVP_hdb_query_saveVehicle;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATE SO VEHICLE: _key = "+_key+".");
		diag_log ("[BRPVP] UPDATE SO VEHICLE: _resultado = "+_resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_updateTurretExec = {
	params ["_id","_exec"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:saveVehicleExec:%2:%3",BRPVP_protocolo,_exec,_id];
	} else {
		[_id,[["exec",_exec]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_saveWeaponHoldersOnDB = {
	if (!BRPVP_useExtDB3) then {call BRPVP_hdb_query_whDeleteAll;};
	{
		if (_x getVariable ["brpvp_how_old",0] isEqualTo 0 && _x getVariable ["ml_takes",-1] isEqualTo -1) then {
			if (BRPVP_useExtDB3) then {
				"extDB3" callExtension format ["1:%1:whAdd:%2:%3:%4",BRPVP_protocolo,getPosWorld _x,[vectorDir _x,vectorUp _x],_x call BRPVP_getCargoArray];
			} else {
				private _data = [getPosWorld _x,[vectorDir _x,vectorUp _x],_x call BRPVP_getCargoArray];
				_data call BRPVP_hdb_query_whAdd;
			};
		};
	} forEach (BRPVP_centroMapa nearObjects ["WeaponHolder",BRPVP_centroMapaRadius]);
};
BRPVP_hintEmMassaFromHC = {
	params ["_cli","_hint"];
	_hint remoteExecCall ["BRPVP_hint",_cli];
};
BRPVP_setTurretOperator = {
	if (_this isEqualType objNull) then {
		_this remoteExecCall ["BRPVP_setTurretOperatorHC",2];
	} else {
		params ["_obj","_vPWD","_vVDU"];
		private _veiculoId = _obj getVariable ["id_bd",-1];
		if (_veiculoId >= 0) then {
			private _modelo = typeOf _obj;
			private _owner = _obj getVariable "own";
			private _comp = _obj getVariable "stp";
			private _amigos = _obj getVariable "amg";
			private _exec = _obj getVariable "brpvp_exec";
			private _add = [_modelo,_vVDU,_vPWD,_veiculoId,_owner,_comp,_amigos,_exec,0];
			_add remoteExecCall ["BRPVP_addNewTurretInfo",0];
		};
		_obj remoteExecCall ["BRPVP_setTurretOperatorHC",2];
	};
};
BRPVP_carrierMissCreate = {
	params ["_pos","_mid"];
	private _carrier = createVehicle ["Land_Carrier_01_base_F",ASLToATL AGLToASL _pos,[],0,"NONE"];
	_carrier setVariable ["BIS_carrierParts",_carrier getVariable "BIS_carrierParts",true];
	_carrier setVectorUp [0,0,1];
	[_carrier] call BIS_fnc_Carrier01PosUpdate;
	BRPVP_carrierMissCreateObj = _carrier;
	[_carrier,AGLToASL _pos] remoteExec ["BRPVP_carrierMissFixAndInit",0];
	[_carrier,0] remoteExecCall ["setFeatureType",0];
	if (_mid isNotEqualTo 2) then {_mid publicVariableClient "BRPVP_carrierMissCreateObj";};
};
BRPVP_markDeleteOnDB = {
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:customMarksDelete:%2",BRPVP_protocolo,_this];
	} else {
		_this call BRPVP_hdb_query_customMarksDelete;
	};
};
BRPVP_markSaveOnDb = {
	params ["_p","_pId","_mId","_pos","_txt"];
	if (_mId isEqualTo -1) then {
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["0:%1:customMarksAdd:%2:%3:%4",BRPVP_protocolo,_pId,_pos,_txt];
			private _result = "extDB3" callExtension format ["0:%1:customMarksGetId:%2:%3:%4",BRPVP_protocolo,_pId,_pos,_txt];
			BRPVP_markSaveOnDbReturn = parseSimpleArray _result select 1 select 0 select 0;
		} else {
			BRPVP_markSaveOnDbReturn = [_pId,_pos,_txt] call BRPVP_hdb_query_customMarksAdd;
		};
		(owner _p) publicVariableClient "BRPVP_markSaveOnDbReturn";
	} else {
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:customMarksUpdate:%2:%3",BRPVP_protocolo,_txt,_mId];
		} else {
			[_mId,_txt] call BRPVP_hdb_query_customMarksUpdate;
		};
	};
};
BRPVP_getCustomMarksSv = {
	params ["_id","_player"];
	if (BRPVP_useExtDB3) then {
		private _resultado = "extDB3" callExtension format ["0:%1:customMarksGet:%2",BRPVP_protocolo,_id];
		BRPVP_myCustomMarks = parseSimpleArray _resultado select 1;
	} else {
		BRPVP_myCustomMarks = _id call BRPVP_hdb_query_customMarksGet;
	};
	(owner _player) publicVariableClient "BRPVP_myCustomMarks";
};
BRPVP_allHabStatesGetSv = {//PPP DESABILITADA
	_key = format ["0:%1:habilitiesGetAll",BRPVP_protocolo];
	_resultado = "extDB3" callExtension _key;
	BRPVP_allHabStates = parseSimpleArray _resultado select 1;
	(owner _this) publicVariableClient "BRPVP_allHabStates";
};
BRPVP_enableDisableHabilitie = {//PPP DESABILITADA
	params ["_state","_id"];
	private _key = format ["0:%1:habilitiesSelect:%2",BRPVP_protocolo,_id];
	private _resultado = "extDB3" callExtension _key;
	if (parseSimpleArray _resultado select 1 isEqualTo []) then {
		_key = format ["0:%1:habilitiesInsert:%2:%3",BRPVP_protocolo,_id,_state];
		"extDB3" callExtension _key;
	} else {
		_key = format ["0:%1:habilitiesUpdate:%2:%3",BRPVP_protocolo,_state,_id];
		"extDB3" callExtension _key;
	};
	_key = format ["0:%1:habilitiesGetAll",BRPVP_protocolo];
	_resultado = "extDB3" callExtension _key;
	BRPVP_habilitiesState = parseSimpleArray _resultado select 1;
};
BRPVP_fantaMineExplodeHit = {
	params ["_mine","_mineNew","_found"];
	createVehicle ["HelicopterExploBig",ASLToAGL getPosASL _mineNew,[],0,"CAN_COLLIDE"] setShotParents [_mine,_found];
	_mineNew hideObjectGlobal true;
	private _mineId = _mine getVariable ["brpvp_mine_base_id",-1];
	if (_mineId isNotEqualTo -1) then {_mineId call BRPVP_fantaMineRemove;};
	_mineNew setPosASL BRPVP_posicaoFora;
	sleep 2.5;
	deleteVehicle _mine;
	deleteVehicle _mineNew;
};
BRPVP_fantaMineExplode = {
	params ["_mine","_found"];
	createVehicle ["HelicopterExploBig",ASLToAGL getPosASL _mine,[],0,"CAN_COLLIDE"] setShotParents [_mine,_found];
	_mine hideObjectGlobal true;
	private _mineId = _mine getVariable ["brpvp_mine_base_id",-1];
	if (_mineId isNotEqualTo -1) then {_mineId call BRPVP_fantaMineRemove;};
	_mine setPosASL BRPVP_posicaoFora;
	sleep 2.5;
	deleteVehicle _mine;
};
BRPVP_fantaMineRemove = {
	private _id = _this;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:removeFantaMine:%2",BRPVP_protocolo,_id];
	} else {
		_id call BRPVP_hdb_query_removeFantaMine;
	};
};
BRPVP_updateFantaDb = {
	params ["_id","_amg"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:updateFantaMine:%2:%3",BRPVP_protocolo,_amg,_id];
	} else {
		[_id,_amg] call BRPVP_hdb_query_updateFantaMine;
	};
};
BRPVP_fantaMineAddDb = {
	params ["_mine","_id","_amg","_posW","_isBase"];
	BRPVP_frantaAllObjs = BRPVP_frantaAllObjs-[objNull];
	BRPVP_frantaAllObjs pushBack _mine;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["0:%1:addFantaMine:%2:%3:%4:%5",BRPVP_protocolo,_id,_amg,_posW,[0,1] select _isBase];
		private _resultado = "extDB3" callExtension format ["0:%1:addFantaMineGetId:%2:%3:%4:%5",BRPVP_protocolo,_id,_amg,_posW,[0,1] select _isBase];
		private _fantaId = parseSimpleArray _resultado select 1 select 0 select 0;
		_mine setVariable ["brpvp_mine_base_id",_fantaId,true];
	} else {
		private _fantaId = [_id,_amg,_posW,[0,1] select _isBase] call BRPVP_hdb_query_addFantaMine;
		_mine setVariable ["brpvp_mine_base_id",_fantaId,true];
	};
};
BRPVP_getPastFriendsSV = {
	params ["_id","_player"];
	if (BRPVP_useExtDB3) then {
		private _resultado = "extDB3" callExtension format ["0:%1:pastFriendsGet:%2:%3",BRPVP_protocolo,_id,-2];
		BRPVP_myPastFriendsAnswer = parseSimpleArray _resultado select 1;
	} else {
		//NOTHING IF CLIENTSV
		BRPVP_myPastFriendsAnswer = [];
	};
	(owner _player) publicVariableClient "BRPVP_myPastFriendsAnswer";
};
BRPVP_recordCloneOnDb = {
	params ["_id","_class"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:saveClone:%2:%3",BRPVP_protocolo,_class,_id];
	} else {
		[_id,[["clone",_class]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
};
BRPVP_getDaysPlayedSV = {
	params ["_id","_player"];
	private ["_statsDaysPlayed"];
	if (BRPVP_useExtDB3) then {
		private _resultado = "extDB3" callExtension format ["0:%1:getPlayedDays:%2",BRPVP_protocolo,_id];
		_statsDaysPlayed = parseSimpleArray _resultado select 1 select 0 select 0;
	} else {
		_statsDaysPlayed = round ((BRPVP_xpLimits select 4)*(BRPVP_xpToBuyAllPerks/1000000));
	};
	BRPVP_statsDaysPlayed = if (_statsDaysPlayed isEqualType "") then {1} else {_statsDaysPlayed};
	(owner _player) publicVariableClient "BRPVP_statsDaysPlayed";
};
BRPVP_updateVgMultSV = {
	params ["_id","_vgMult"];
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:savePlayerVgMult:%2:%3",BRPVP_protocolo,_vgMult,_id];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_id,[[""vgMult"",_vgMult]]] call BRPVP_hdb_query_updatePlayersFieldsById";
		_result = [_id,[["vgMult",_vgMult]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
	diag_log ("[BRPVP] SET VG MULT: _key = " + str _key + ".");
	diag_log ("[BRPVP] SET VG MULT: _resultado = " + str _resultado + ".");
};
BRPVP_updateVaultsSV = {
	params ["_p","_id","_vaults"];
	private ["_key","_resultado"];
	BRPVP_vaultNumber = if (_vaults isEqualTo -1) then {BRPVP_vaultNumberCfg} else {_vaults};
	(owner _p) publicVariableClient "BRPVP_vaultNumber";
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:savePlayerVaults:%2:%3",BRPVP_protocolo,_vaults,_id];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_id,[[""vaults"",_vaults]]] call BRPVP_hdb_query_updatePlayersFieldsById";
		_result = [_id,[["vaults",_vaults]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
	diag_log ("[BRPVP] SET VAULT NUMBER: _key = " + str _key + ".");
	diag_log ("[BRPVP] SET VAULT NUMBER: _resultado = " + str _resultado + ".");
};
BRPVP_carrierUpdateOnDb = {
	params ["_obj","_estadoCarro"];
	private ["_key","_resultado"];
	private _id = _obj getVariable "brpvp_carr_id_bd";
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:saveVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14",BRPVP_protocolo,_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,[],[0,[[],[]]],0,_id];
		_resultado = "extDB3" callExtension _key;
	} else {
		private _data = [_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,[],[0,[[],[]]],0];
		_key = "[_id,_data] call BRPVP_hdb_query_saveVehicle";
		_resultado = [_id,_data] call BRPVP_hdb_query_saveVehicle;
	};
	diag_log ("[BRPVP] UPDATE CARRIER: _key = "+str _key+".");
	diag_log ("[BRPVP] UPDATE CARRIER: _resultado = "+str _resultado+".");
};
BRPVP_carrierAddToDb = {
	params ["_cons","_estadoCons"];
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		//WRITE CARRIER ON DB
		_key = format ["0:%1:createVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13",BRPVP_protocolo,_estadoCons select 0,_estadoCons select 1,_estadoCons select 2,_estadoCons select 3,_estadoCons select 4,_estadoCons select 5,false,_estadoCons select 6,_estadoCons select 7,[],[0,[[],[]]],_estadoCons select 3];
		_resultado = "extDB3" callExtension _key;

		//PEGA ID DO OBJETO
		_key2 = format ["0:%1:getConstructionIdByModelPos:%2:%3",BRPVP_protocolo,_estadoCons select 2,_estadoCons select 1];
		_resultado2 = "extDB3" callExtension _key2;
		_cId = parseSimpleArray _resultado2 select 1 select 0 select 0;
		_cons setVariable ["brpvp_carr_id_bd",_cId,true];
	} else {
		private _data = [_estadoCons select 0,_estadoCons select 1,_estadoCons select 2,_estadoCons select 3,_estadoCons select 4,_estadoCons select 5,false,_estadoCons select 6,_estadoCons select 7,0,[],[],[],[0,[[],[]]],1,-1,0,_estadoCons select 3,0,0];
		_key = "_data call BRPVP_hdb_query_createVehicle";
		_resultado = _data call BRPVP_hdb_query_createVehicle;
		_cons setVariable ["brpvp_carr_id_bd",_resultado,true];
	};
	diag_log "---- [INSERT: ADD CARRIER ON DB]";
	diag_log ("---- _key = "+str _key+".");
	diag_log ("---- _resultado = "+str _resultado+".");
};
BRPVP_carrierCreateOrMoveServer = {
	params ["_p","_pASL","_dir","_obj"];
	_carrier = if (isNull _obj) then {createVehicle ["Land_Carrier_01_base_F",[0,0,0],[],0,"CAN_COLLIDE"]} else {_obj};
	_carrier setPosASL _pASL;
	_carrier setDir _dir;
	[_carrier] call BIS_fnc_Carrier01PosUpdate;
	if (isNull _obj) then {
		_carrier setVariable ["BIS_carrierParts",_carrier getVariable "BIS_carrierParts",true];
		_carrier setVariable ["brpvp_carr_own",_p getVariable "id_bd",true];
		_carrierData = [
			[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],
			[_pASL,_dir],
			"Land_Carrier_01_base_F",
			_p getVariable "id_bd",
			1,
			[[],[],true],
			"",
			[0,0,0,0,0,0]
		];
		[_carrier,_carrierData] call BRPVP_carrierAddToDb;
		[_carrier,0] remoteExecCall ["setFeatureType",0];
	} else {
		_carrierData = [
			[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],
			[_pASL,_dir],
			"Land_Carrier_01_base_F",
			_p getVariable "id_bd",
			1,
			[[],[],true],
			false,
			false,
			[0,0,0,0,0,0]
		];
		[_carrier,_carrierData] call BRPVP_carrierUpdateOnDb;
	};
	_carrier remoteExecCall ["BRPVP_carrierObjsListAdd",0];
	[_carrier,_pASL] remoteExec ["BRPVP_carrierMissFixAndInit",0];
};
BRPVP_tireServerGetVehLast = [];
BRPVP_tireServerGetVeh = {
	params ["_id","_VGTime","_kills","_cantSafeTime","_isRaidTraining","_cliId","_player","_t"];
	private ["_key","_resultado"];
	private _double = false;
	{
		_x params ["_idOld","_sTime","_t"];
		private _max = 5+_t;
		if (serverTime-_sTime > _max) then {BRPVP_tireServerGetVehLast set [_forEachIndex,-1];} else {if (_idOld isEqualTo _id) then {_double = true;};};
	} forEach BRPVP_tireServerGetVehLast;
	BRPVP_tireServerGetVehLast = BRPVP_tireServerGetVehLast-[-1];
	if (!_double) then {
		BRPVP_tireServerGetVehLast pushBack [_id,serverTime,_t];
		_id remoteExecCall ["BRPVP_tireRemoveTireFromArrayCVL",0];
		if (BRPVP_useExtDB3) then {
			_key = format ["0:%1:getObject:%2",BRPVP_protocolo,_id];
			_resultado = "extDB3" callExtension _key;
		} else {
			_key = "_id call BRPVP_hdb_query_getObject";
			_resultado = _id call BRPVP_hdb_query_getObject;
		};
		diag_log "======== GET FROM WORLD MAGUS ================";
		diag_log ("== _key: "+_key);
		diag_log ("== _resultado: "+_resultado);
		diag_log "==============================================";
		[_resultado,_VGTime,_kills,_cantSafeTime,_isRaidTraining,_cliId,_player] remoteExecCall ["BRPVP_tireServerGetVehHC",2];
	};
};
BRPVP_airVehLocal = {
	params ["_veh","_local"];
	if (_local) then {
		_veh call BRPVP_setAirGodMode;
		_veh spawn {
			_veh = _this;
			_init = time;
			waitUntil {
				sleep 0.5;
				_exit = vectorMagnitude velocity _veh < 0.25 || time-_init > 30 || !local _veh;
				if (!_exit) then {_veh call BRPVP_setAirGodMode;};
				_exit
			};
		};
	};
};
BRPVP_randomRespawnSaveRecord = {
	params ["_pId","_pPlaces","_pPlacesBK"];
	private _idx = -1;
	{
		_x params ["_id","_places","_placesBK"];
		if (_pId isEqualTo _id) exitWith {_idx = _forEachIndex;};
	} forEach BRPVP_randomRespawnSave;
	if (_idx isEqualTo -1) then {BRPVP_randomRespawnSave pushBack _this;} else {BRPVP_randomRespawnSave set [_idx,_this];};
};
BRPVP_randomRespawnSaveGet = {
	params ["_player","_pId"];
	private _recorded = +BRPVP_randomRespawnInitial;
	{
		_x params ["_id","_places","_placesBK"];
		if (_id isEqualTo _pId) exitWith {_recorded = [_places,_placesBK];};
	} forEach BRPVP_randomRespawnSave;
	BRPVP_randomRespawnSaveGetReturn = _recorded;
	(owner _player) publicVariableClient "BRPVP_randomRespawnSaveGetReturn";
};
BRPVP_climbActivePlayersAdd = {
	params ["_add","_id"];
	if (_add) then {
		BRPVP_climbActivePlayers pushBackUnique _id;
	} else {
		BRPVP_climbActivePlayers deleteAt (BRPVP_climbActivePlayers find _id);
	};
};
BRPVP_zombieBloodBagActiveAdd = {
	params ["_add","_id"];
	if (_add) then {
		BRPVP_zombieBloodBagActive pushBackUnique _id;
	} else {
		BRPVP_zombieBloodBagActive deleteAt (BRPVP_zombieBloodBagActive find _id);
	};
};
BRPVP_vehCoverSaveDB = {
	params ["_id","_animations"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:saveVehicleCover:%2:%3",BRPVP_protocolo,_animations,_id];
	} else {
		[_id,[["cover",_animations]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_paintVehicleSaveChange = {
	params ["_id","_textures"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:saveVehiclePaint:%2:%3",BRPVP_protocolo,_textures,_id];
	} else {
		[_id,[["paint",_textures]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_getPlayerAccess2 = {//PPP DESABILITADA
	params ["_p","_id","_useDay"];
	_key = format ["0:%1:checkNewAccess2Days:%2",BRPVP_protocolo,_id];
	_result = "extDB3" callExtension _key;
	_days = parseSimpleArray _result select 1 select 0 select 0;
	if !(_days isEqualTo "") then {
		_key = format ["0:%1:useNewAccess2Days:%2:%3",BRPVP_protocolo,_id,_id];
		_result = "extDB3" callExtension _key;

		_key = format ["1:%1:disableAccess2Days:%2",BRPVP_protocolo,_id];
		_result = "extDB3" callExtension _key;
	};
	_key = format ["0:%1:getPlayerAccess2:%2",BRPVP_protocolo,_id];
	_result = "extDB3" callExtension _key;
	(parseSimpleArray _result select 1 select 0) params ["_days","_diff"];
	if (_diff isEqualTo 0) then {
		BRPVP_getPlayerAccess2FromServer = _days+1;
	} else {
		BRPVP_getPlayerAccess2FromServer = _days;
		if (_days > 0 && _useDay) then {
			_key = format ["1:%1:playerAccess2UseADay:%2",BRPVP_protocolo,_id];
			_result = "extDB3" callExtension _key;
		};
	};
	(owner _p) publicVariableClient "BRPVP_getPlayerAccess2FromServer";	
};
BRPVP_getPlayerAccess = {//PPP DESABILITADA
	params ["_p","_id"];
	_key = format ["0:%1:checkNewAccessDays:%2",BRPVP_protocolo,_id];
	_result = "extDB3" callExtension _key;
	_days = parseSimpleArray _result select 1 select 0 select 0;
	if !(_days isEqualTo "") then {
		_key = format ["0:%1:useNewAccessDays:%2:%3",BRPVP_protocolo,_id,_id];
		_result = "extDB3" callExtension _key;

		_key = format ["1:%1:disableAccessDays:%2",BRPVP_protocolo,_id];
		_result = "extDB3" callExtension _key;
	};
	_key = format ["0:%1:getPlayerAccess:%2",BRPVP_protocolo,_id];
	_result = "extDB3" callExtension _key;
	BRPVP_getPlayerAccessFromServer = parseSimpleArray _result select 1 select 0 select 0;
	(owner _p) publicVariableClient "BRPVP_getPlayerAccessFromServer";	
};
BRPVP_addGodModHouseInDb = {
	params ["_class","_pw","_obj","_own","_stp","_amg"];
	private _id = -1;
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["0:%1:addGodModeHouse:%2:%3:%4:%5:%6",BRPVP_protocolo,_class,_pw,_own,_stp,_amg];
		_result = "extDB3" callExtension format ["0:%1:getGodModeHouseId:%2:%3:%4:%5:%6",BRPVP_protocolo,_class,_pw,_own,_stp,_amg];
		_id = parseSimpleArray _result select 1 select 0 select 0;
	} else {
		_id = [_class,_pw,_own,_stp,_amg] call BRPVP_hdb_query_addGodModeHouse
	};
	_obj setVariable ["brpvp_map_god_mode_house_id",_id,true];
};
BRPVP_killedPlayersOthersGet = {
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getKillersList",BRPVP_protocolo];
		BRPVP_killedPlayersOthersReturn = parseSimpleArray _result select 1;
	} else {
		//NOTHING IF CLIENTSV
		BRPVP_killedPlayersOthersReturn = [];
	};
	_this publicVariableClient "BRPVP_killedPlayersOthersReturn";
};
BRPVP_killedPlayersCaseGet = {
	params ["_owner","_id","_vId"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getPlayersIKilledCase:%2:%3",BRPVP_protocolo,_id,_vId];
		BRPVP_killedPlayersCaseReturn = parseSimpleArray _result select 1;
	} else {
		//NOTHING IF CLIENTSV
		BRPVP_killedPlayersCaseReturn = [];
	};
	_owner publicVariableClient "BRPVP_killedPlayersCaseReturn";
};
BRPVP_killedPlayersResumeGet = {
	params ["_owner","_id"];
	if (BRPVP_useExtDB3) then {
		private _result = "extDB3" callExtension format ["0:%1:getPlayersIKilled:%2",BRPVP_protocolo,_id];
		BRPVP_killedPlayersResumeReturn = parseSimpleArray _result select 1;
	} else {
		//NOTHING IF CLIENTSV
		BRPVP_killedPlayersResumeReturn = [];
	};
	_owner publicVariableClient "BRPVP_killedPlayersResumeReturn";
};
BRPVP_killMapCalculate = {
	private _result = [];
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:getForKillMap",BRPVP_protocolo];
		_result = parseSimpleArray _result select 1;
	} else {
		//NOTHING IF CLIENTSV
	};
	private _killMap = _result;
	private _killMap = _killMap-[[[]]];
	_killMap = _killMap apply {
		private _pos = _x select 0;
		_pos set [0,(_pos select 0)-0.5+random 1];
		_pos set [1,(_pos select 1)-0.5+random 1];
		_pos
	};
	private _size = BRPVP_mapaDimensoes select 0;
	private _grid = 50; //INTEGER
	private _step = _size/_grid;
	private _stepHalf = _step/2;
	private _blur = 4; //INTEGER
	private _icons = [];
	private _playerDensityCountArround = {
		private _points = 0;
		{
			private _dist = _x distance2D _pos;
			if (_dist < _step*_blur) then {_points = _points+_step*_blur-_dist;};
		} forEach _i1Segments;
		_points
	};
	private _killMapSegments = [];
	for "_i1" from 1 to _grid do {_killMapSegments pushBack [];};
	{
		private _y = _x select 1;
		if (_y >= 0 && _y <= _size) then {
			private _idx = floor (_y/_step);
			(_killMapSegments select _idx) pushBack _x;
		};
	} forEach _killMap;
	for "_i1" from 0 to (_grid-1) do {
		private _i1Segments = [];
		for "_seg" from (_i1-_blur) to (_i1+_blur) do {
			if (_seg >= 0 && _seg <= (_grid-1)) then {_i1Segments append (_killMapSegments select _seg)};
		};
		for "_i2" from 0 to (_grid-1) do {
			private _pos = [_i2*_step+_stepHalf,_i1*_step+_stepHalf,0];
			_icons pushBack [_pos,call _playerDensityCountArround];
		};
	};
	private _max = 0;
	{if (_x select 1 > _max) then {_max = _x select 1;};} forEach _icons;
	if (_max > 0) then {
		BRPVP_killMapTable = _icons apply {[_x select 0,_stepHalf,(_x select 1)/_max]};
	} else {
		BRPVP_killMapTable = [];
	};
	BRPVP_killMapKillPos = _killMap;
	publicVariable "BRPVP_killMapKillPos";
	publicVariable "BRPVP_killMapTable";
};
BRPVP_spcItemsAdd = {
	params ["_obj","_class","_p"];
	private _items = _obj getVariable ["brpvp_spc_items",[]];
	private _idx = _items find _class;
	if (_idx > -1) then {
		_items deleteAt _idx;
		_obj setVariable ["brpvp_spc_items",_items,true];
		if (_items isEqualTo []) then {deleteVehicle _obj;};
		if (_class isEqualType []) then {[_class select 0,_class select 1,_p,owner _p] call BRPVP_sitAddItemId;} else {[_class,1,_p,owner _p] call BRPVP_sitAddItemId;};
		"achou_loot" remoteExecCall ["BRPVP_playSound",_p];
	} else {
		"erro" remoteExecCall ["BRPVP_playSound",_p];
	};
};
BRPVP_getTurretKillsServer = {
	params ["_player","_flagId"];
	private _result = "";
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:getTurretsKills:%2",BRPVP_protocolo,_flagId];
		BRPVP_getTurretKillsServerAnswer = parseSimpleArray _result select 1;
	} else {
		BRPVP_getTurretKillsServerAnswer = _flagId call BRPVP_hdb_query_getTurretsKills;
	};
	(owner _player) publicVariableClient "BRPVP_getTurretKillsServerAnswer";
};
BRPVP_recordTurretKill = {
	params ["_pId","_pNm","_tId","_tOwn","_fId","_fOwn"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:addTurretKill:%2:%3:%4:%5:%6:%7",BRPVP_protocolo,_pId,_pNm,_tId,_tOwn,_fId,_fOwn];
	} else {
		[_fId,[systemTime select [0,6],_pId,_pNm,_tId,_tOwn,_fId,_fOwn]] call BRPVP_hdb_query_addTurretKill;
	};
};
BRPVP_setSignExec = {
	params ["_id","_txt"];
	_exec = "_this setVariable ['brpvp_sign_txt','"+([_txt,":","@#$2_points$#@"] call BRPVP_stringReplace)+"',true];";
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:updateCeilExec:%2:%3",BRPVP_protocolo,_exec,_id];
	} else {
		[_id,[["exec",_exec]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_clientLogOnServer = {
	params ["_player","_txt"];
	diag_log format ["Player: %1 | Msg: %2",_player getVariable ["nm","no_name"],_txt];
};
BRPVP_getAndSetHalfBanditState = {
	params ["_player","_uid"];
	private ["_key","_result","_date"];
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:getLastPveHackDate:%2",BRPVP_protocolo,_uid];
		_result = "extDB3" callExtension _key;
		_date = parseSimpleArray _result select 1 select 0 select 0;
	} else {
		_key = "[_uid,[""lastPveHack""]] call BRPVP_hdb_query_getPlayerFieldsBySid";
		_result = [_uid,["lastPveHack"]] call BRPVP_hdb_query_getPlayerFieldsBySid;
		_date = _result select 0;
	};
	_delta = ([BRPVP_sessionTimeStamp,_date] call BRPVP_dateDiff) max 0;
	if (_delta <= BRPVP_pveDaysWithNoSuperJumpWhenHack) then {_player setVariable ["brpvp_half_bandit",true,true];};
	diag_log ("======== GET LAST PVE HACK DATE ======");
	diag_log ("======== _key: "+_key+" | _result: "+str _result+" | _delta: "+str _delta+" ======");
};
BRPVP_pveRecordHalfBandit = {
	private ["_key","_result"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:updateLastPveHackDate:%2:%3",BRPVP_protocolo,BRPVP_sessionTimeStamp,_this getVariable "id_bd"];
		_result = "extDB3" callExtension _key;
	} else {
		private _pid = _this getVariable "id_bd";
		_key = "[_pid,[[""lastPveHack"",BRPVP_sessionTimeStamp]]] call BRPVP_hdb_query_updatePlayersFieldsById";
		_result = [_pid,[["lastPveHack",BRPVP_sessionTimeStamp]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
	diag_log ("======== UPDATE HALF BANDIT DATE ======");
	diag_log ("======== _key: "+_key+" | _result: "+_result+" ======");
};
BRPVP_updateInsuranceOwner = {
	params ["_vehId","_newOwnerId"];
	private ["_key","_result"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:updateInsuranceOwner:%2:%3",BRPVP_protocolo,_newOwnerId,_vehId];
		_result = "extDB3" callExtension _key;
	} else {
		_key = "[_vehId,[[""vehicleOwner"",_newOwnerId]]] call BRPVP_hdb_query_updateInsurancesFieldsByVehicleId";
		_result = [_vehId,[["vehicleOwner",_newOwnerId]]] call BRPVP_hdb_query_updateInsurancesFieldsByVehicleId;
	};
	diag_log ("======== UPDATE INSURANCE OWNER ======");
	diag_log ("======== _key: "+_key+" | _result: "+_result+" ======");
};
BRPVP_farmObjShowList = [];
BRPVP_farmObjShowTime = {
	params ["_obj","_delay"];
	BRPVP_farmObjShowList pushBack [serverTime+_delay,_obj];
};
BRPVP_getSuitCase = {
	params ["_p","_s"];
	if (!isNull _s) then {
		_p setVariable ["mny",(_p getVariable ["mny",0])+(_s getVariable ["mny",0]),true];
		_s setVariable ["mny",0];
		deleteVehicle _s;
	};
};
BRPVP_createGallonBomb = {
	_gallon = createVehicle ["Land_MetalBarrel_F",[ASLToAGL getPosASL _this,1.25,getDir _this] call BIS_fnc_relPos,[],0,"CAN_COLLIDE"];
	_gallon addEventHandler ["HandleDamage",{
		_gallon = _this select 0;
		_projectile = _this select 4;
		if !(_projectile isEqualTo "") then {
			createVehicle ["HelicopterExploBig",ASLToAGL getPosASL _gallon,[],0,"CAN_COLLIDE"];
			deleteVehicle _gallon;
		};
	}];
};
BRPVP_teleSaveDestineOnBd = {//PPP FEITO
	params ["_teleId","_destineId"];
	private ["_key","_result"];
	private _exec = "_this setVariable ['brpvp_tele_destine_id',"+str _destineId+",true];";
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:updateCeilExec:%2:%3",BRPVP_protocolo,_exec,_teleId];
		_result = "extDB3" callExtension _key;
	} else {
		_key = "[_teleId,[[""exec"",_exec]]] call BRPVP_hdb_query_updateVehicleFieldsById";
		_result = [_teleId,[["exec",_exec]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
	diag_log ("======== TELE DESTINE UPDATED _key: "+_key+" | _result: "+_result+" ======");
};
BRPVP_insuranceSetDelivered = {
	private ["_key","_result"];
	private _insuranceId = _this;
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:setInsuranceAsDelivered:%2",BRPVP_protocolo,_insuranceId];
		_result = "extDB3" callExtension _key;
	} else {
		_key = "[_insuranceId,[[""insuranceState"",2]]] call BRPVP_hdb_query_updateInsurancesFieldsById";
		_result = [_insuranceId,[["insuranceState",2]]] call BRPVP_hdb_query_updateInsurancesFieldsById;
	};
	diag_log ("======== SET INSURANCE AS DELIVERED ======");
	diag_log ("======== _key: "+_key+" | _result: "+_result+" ======");
};
BRPVP_insuranceRecoverList = {
	private ["_key","_result"];
	private _player = _this;
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:recoverInsurance:%2",BRPVP_protocolo,_player getVariable "id_bd"];
		_result = "extDB3" callExtension _key;
		_result = parseSimpleArray _result select 1;
	} else {
		private _vehOwn = _player getVariable "id_bd";
		_key = "_vehOwn call BRPVP_hdb_query_recoverInsurance";
		_result = _vehOwn call BRPVP_hdb_query_recoverInsurance;
	};
	diag_log ("======== RECOVER INSURANCE ======");
	diag_log ("======== _key: "+_key+" | _result: "+str _result+" ======");
	BRPVP_insuranceRecoverListAnswer = _result;
	(owner _player) publicVariableClient "BRPVP_insuranceRecoverListAnswer";
};
BRPVP_insuranceAddContract = {
	params ["_p","_veh"];
	private ["_key","_result","_data"];
	_vehIdbd = _veh getVariable ["id_bd",-1];
	_vehClass = typeOf _veh;
	_owner = _veh getVariable ["own",-1];
	_state = 0;
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:getInsuranceSequence:%2",BRPVP_protocolo,_vehIdbd];
		_data = parseSimpleArray _result select 1;
	} else {
		_data = _vehIdbd call BRPVP_hdb_query_getInsuranceSequence;
	};
	_uses = if (_data isEqualTo []) then {0} else {_data select 0 select 0};
	BRPVP_insuranceAddContractReturn = _uses+1;
	private _insuranceTimesLimit = if (_veh isKindOf "Plane") then {BRPVP_insuranceTimesLimitPlane} else {if (_veh isKindOf "Helicopter") then {BRPVP_insuranceTimesLimitHeli} else {BRPVP_insuranceTimesLimit};};
	if (BRPVP_insuranceAddContractReturn <= _insuranceTimesLimit) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:addInsurance:%2:%3:%4:%5:%6:%7",BRPVP_protocolo,_vehIdbd,_vehClass,_owner,_state,BRPVP_insuranceAddContractReturn,-1];
			_result = "extDB3" callExtension _key;
		} else {
			private _data = [_vehIdbd,_vehClass,_owner,_state,BRPVP_insuranceAddContractReturn,-1];
			_key = "_data call BRPVP_hdb_query_addInsurance";
			_result = str (_data call BRPVP_hdb_query_addInsurance);
		};
		diag_log ("======== ADD INSURANCE ======");
		diag_log ("======== _key: "+_key+" | _result: "+_result+" | BRPVP_insuranceAddContractReturn: "+str BRPVP_insuranceAddContractReturn+" ======");
	};
	(owner _p) publicVariableClient "BRPVP_insuranceAddContractReturn";
};
BRPVP_insuranceCheckExistence = {
	params ["_player","_veh"];
	private ["_key","_result"];
	if (BRPVP_useExtDB3) then {
		_key = format ["0:%1:checkInsurance:%2",BRPVP_protocolo,_veh getVariable ["id_bd",-1]];
		_result = "extDB3" callExtension _key;
		_result = parseSimpleArray _result select 1;
	} else {
		private _vehId = _veh getVariable ["id_bd",-1];
		_key = "_vehId call BRPVP_hdb_query_checkInsurance";
		_result = _vehId call BRPVP_hdb_query_checkInsurance;
	};
	diag_log ("======== CHECK INSURANCE EXISTENCE ======");
	diag_log ("======== _key: "+_key+" | _result: "+str _result+" ======");
	BRPVP_insuranceCheckExistenceAnswer = if (_result isEqualto []) then {0} else {_result select 0 select 0};
	(owner _player) publicVariableClient "BRPVP_insuranceCheckExistenceAnswer";
};
BRPVP_moveActionBoxBack = {
	params ["_box","_vdu","_posW"];
	_box enableSimulationGlobal true;
	_box setVectorDirAndUp _vdu;
	_box setPosWorld _posW;
	if (typeOf _box in BRP_kitAutoTurret) then {_this remoteExecCall ["BRPVP_moveActionBoxBackTurret",2];};
};
BRPVP_removeObjectServer = {
	params ["_obj","_removeFromDB","_deleteObj"];
	if (_obj isEqualType objNull) then {
		if (_obj call BRPVP_isMotorized) then {
			if (_removeFromDB) then {_obj call BRPVP_veiculoMorreu;};
			if (_deleteObj) then {
				if (_obj isKindOf "StaticWeapon") then {
					private _tId = _obj getVariable ["id_bd",-1];
					_tId remoteExecCall ["BRPVP_removeTurretInfo",0];
				};
				deleteVehicle _obj;
			};
		} else {
			//CEIL REMOVE IF CRANE
			_typeOf = typeOf _obj;
			if (_typeOf isEqualTo "Land_EngineCrane_01_F") then {_obj call BRPVP_removeCeilObjects;};

			//FLAG CEIL AND WALL
			if (_obj isKindOf "FlagCarrier" && false) then { //SET TO NOT RUN
				//CEIL REMOVE IF FLAG
				{
					if (typeOf _x isEqualTo "Land_EngineCrane_01_F") then {
						_ceilObj = _x;
						if !(_ceilObj getVariable ["id_bd",-1] isEqualTo -1) then {
							_flag = objNull;
							{if (_ceilObj distance _x <= _x getVariable ["brpvp_flag_radius",0]) exitWith {_flag = _x;};} forEach nearestObjects [_ceilObj,["FlagCarrier"],200,true];
							if (_obj isEqualTo _flag) then {
								_ceilObj call BRPVP_removeCeilObjects;
								_ceilObj call BRPVP_ceilExecRemove;
							};
						};
					};
				} forEach nearestObjects [_obj,[],_obj getVariable ["brpvp_flag_radius",0],true];

				//REMOVE FLAG WALL IF FLAG
				_obj call BRPVP_removeWallFlag;
			};
			if (_removeFromDB) then {_obj call BRPVP_veiculoMorreu;};
			_obj remoteExecCall ["BRPVP_ownedHousesRemoveRE",0];
			if (_deleteObj) then {
				if (_obj isKindOf "FlagCarrier") then {
					_obj hideObjectGlobal true;
					_obj spawn {
						sleep 2.5;
						_this setPosASL (BRPVP_posicaoFora vectorAdd [-100+random 200,-100+random 200,0]);
						sleep 7.5;
						deleteVehicle _this;
					};
				} else {
					deleteVehicle _obj;
				};
			};
		};
	} else {
		if (_obj isEqualType []) then {
			_obj params ["_type","_id"];
			if (_type isEqualTo "tire") then {
				if (_removeFromDB) then {_id call BRPVP_veiculoMorreu;};
				if (_deleteObj) then {_id remoteExecCall ["BRPVP_tireRemoveTireFromArrayCVL",0];};
			};
		};
	};
};
BRPVP_getHoleMoney = {
	params ["_hole","_player"];
	if (!isNull _hole) then {
		_mny = _hole getVariable ["mny",-1];
		if (_mny isEqualTo -1) then {
			_boxClass = _hole getVariable ["brpvp_box",""];
			if !(_boxClass isEqualTo "") then {
				_box = createVehicle [_boxClass,BRPVP_posicaoFora,[],20,"CAN_COLLIDE"];
				_empty = [[[],[]],[],[[],[]],[[],[]]];
				[_box,_hole getVariable ["brpvp_box_inventory",_empty]] call BRPVP_putItemsOnCargo;
				_pa = getPosASL _box;
				_pw = getPosWorld _box;
				_dh = (_pw select 2)-(_pa select 2);
				if (getPosATL _player select 2 > 0.25) then {
					_box attachTo [_player,[0,1.5,_dh+0.25]];
				} else {
					_box attachTo [_player,_player worldToModel (([_player,1.5,getDir _player] call BIS_fnc_relPos) vectorAdd [0,0,_dh+0.25])];
				};
				detach _box;
				if (_box isKindOf "ReammoBox_F") then {_box setVariable ["brpvp_del_when_empty",true,true];};
			};
		} else {
			_player setVariable ["mny",(_player getVariable ["mny",0])+_mny,true];
			[["str_hole_money_get",[_mny call BRPVP_formatNumber]],-5,200,0,"negocio"] remoteExecCall ["BRPVP_hint",_player];
		};
		if (_hole getVariable ["id_bd",-1] isNotEqualTo -1) then {_hole call BRPVP_removeHoleFromDB;};
		deleteVehicle _hole;
	};
};
BRPVP_removeHoleFromDB = {
	private ["_key","_resultado"];
	private _veiculoId = _this getVariable ["id_bd",-1];
	private _typeOf = typeOf _this;
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_veiculoId];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_veiculoId,[[""active"",0]]] call BRPVP_hdb_query_updateVehicleFieldsById";
		_resultado = [_veiculoId,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
	diag_log "----------------------------------------------------------------------------------";
	diag_log ("HOLE REMOVED FROM DB: "+_typeOf+". POS: "+str getPos _this+".");
	diag_log ("[BRPVP] _key = "+str _key+".");
	diag_log ("[BRPVP] _resultado = "+str _resultado+".");
	diag_log "----------------------------------------------------------------------------------";
};
BRPVP_captureFrame = {
	if (productVersion select 4 isEqualTo "Profile") then {
		call compile "diag_captureFrameToFile 1;";
	};
};
BRPVP_removeCeilObjects = {
	{deleteVehicle _x;} forEach (_this getVariable ["brpvp_ceils",[]]);
	_this setVariable ["brpvp_ceils",[]];
};
BRPVP_ceilExecRemove = {//PPP FEITO
	private ["_key","_result"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:updateCeilExec:%2:%3",BRPVP_protocolo,"",_this getVariable "id_bd"];
		_result = "extDB3" callExtension _key;
	} else {
		private _idBd = _this getVariable "id_bd";
		_key = "[_idBd,[[""exec"",""""]]] call BRPVP_hdb_query_updateVehicleFieldsById";
		_result = [_idBd,[["exec",""]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
	diag_log ("======== REMOVE CEIL EXEC _key: "+_key+" | _result: "+_result+" ======");
	_this setVariable ["brpvp_ceil_config",[],true];
};
BRPVP_ceilCreateServer = {//PPP FORA DE USO NO BRPVP
	params ["_obj","_h","_holeRad",["_radialOpen",0],["_rotation",0]];
	_obj setVariable ["brpvp_ceil_config",[_h,_holeRad,_radialOpen,_rotation],true];
	_flag = objNull;
	{if (_obj distance _x <= _x getVariable ["brpvp_flag_radius",0]) exitWith {_flag = _x;};} forEach nearestObjects [_obj,["FlagCarrier"],200,true];
	if (isNull _flag) then {
		_obj setVariable ["brpvp_ceils",[]];
	} else {
		_flagRad = _flag getVariable ["brpvp_flag_radius",0];
		_blockClass = "Land_Canal_Dutch_01_plate_F";
		_size = 12.8-0.8;
		_sizeHalf = _size/2;
		_q1 = floor ((_flagRad-_holeRad)/_size)-1;
		_center = getPosASL _flag;
		_ceils = [];
		_angFix = -1;
		for "_c" from 1 to _q1 do {
			_rad = _holeRad+_sizeHalf+(_c-1)*_size;
			_rad2 = _rad+_sizeHalf;
			_hipo = sqrt (_sizeHalf^2+_rad2^2);
			_sin = _sizeHalf/_hipo;
			_ang = 2*asin _sin;
			_initQ2 = 1;
			_q2 = ceil (360/_ang);
			_angStep = 360/_q2;
			if (_rad > _flagRad/2) then {
				_initQ2 = if (_radialOpen > 0) then {0} else {1};
				if (_angFix isEqualTo -1) then {_angFix = _ang;};
				_round = if (_radialOpen > 0) then {360-_radialOpen-_angFix} else {360-_radialOpen};
				_q2 = ceil (_round/_ang);
				_angStep = _round/_q2;
			};
			for "_i" from _initQ2 to _q2 do {
				_a = _rotation+_i*_angStep;
				_pos = [_center,_rad,_a] call BIS_fnc_relPos;
				_dir = [_pos,_center] call BIS_fnc_dirTo;
				_pos set [2,(_center select 2)+_h];
				_b1 = createSimpleObject [_blockClass,_pos];
				_b2 = createSimpleObject [_blockClass,_pos];
				_ceils append [_b1,_b2];
				_b1 setDir _dir;
				_b2 setDir _dir;
				_b2 setDir (getDir _b2-90);
				_b2 setVectorUp [0,0,-1];
				_b2 setPosWorld (getPosWorld _b2 vectorAdd [0,0,-1]);
			};
		};
		_obj setVariable ["brpvp_ceils",_ceils];
	};
	_exec = format ["[_this,%1,%2,%3,%4] call BRPVP_ceilCreateServer;",_h,_holeRad,_radialOpen,_rotation];
	_key = format ["1:%1:updateCeilExec:%2:%3",BRPVP_protocolo,_exec,_obj getVariable "id_bd"];
	_result = "extDB3" callExtension _key;
	diag_log ("======== UPDATE CEIL EXEC _key: "+_key+" | _result: "+_result+" ======");
};
BRPVP_setStoreItemAsDelivered = {//PPP FORA DE USO NO BRPVP
	_id = _this;
	_key = format ["1:%1:setStoreItemAsUsed:%2",BRPVP_protocolo,_id];
	_result = "extDB3" callExtension _key;
	diag_log ("======== STORE ITEM ID "+str _id+" WAS DELIVERED ======");
};
BRPVP_getMyStoreItens = {//PPP FORA DE USO NO BRPVP
	_player = _this;
	_key = format ["0:%1:getStoreItems:%2",BRPVP_protocolo,_player getVariable "id_bd"];
	_result = "extDB3" callExtension _key;
	diag_log ("======== PLAYER "+(_player getVariable "nm")+" GET STORE ITENS: "+_result+" ======");
	BRPVP_myStoreItens = parseSimpleArray _result select 1;
	(owner _player) publicVariableClient "BRPVP_myStoreItens";
};
BRPVP_adminAddLog = {
	if (BRPVP_useExtDB3) then {
		params ["_adminId","_adminName","_action","_valor","_playerId","_playerName"];
		_key = format ["1:%1:adminAddLog:%2:%3:%4:%5:%6:%7",BRPVP_protocolo,_adminId,_adminName,_action,_valor,_playerId,_playerName];
		_result = "extDB3" callExtension _key;
		diag_log ("======== ADD ADMIN LOG: "+_key+" ======");
	} else {
		//NOTHING IF CLIENTSV
	};
};
BRPVP_checkForBan = {
	params ["_player","_id"];
	private _result = -1;
	private _owner = owner _player;
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:getBan:%2",BRPVP_protocolo,_id];
		diag_log ("======== LOGIN_EH - IS BANNED?: "+_id+" | "+_result+" ======");
		_result = parseSimpleArray _result select 1;
	} else {
		//NOTHING IF CLIENTSV
		_result = [];
	};
	if (_result isEqualTo []) then {BRPVP_playerNotBaned = true;} else {BRPVP_playerNotBaned = false;};
	_owner publicVariableClient "BRPVP_playerNotBaned";
};
BRPVP_addFlagWallDb = {
	params ["_idBd","_exec"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:addFlagWall:%2:%3",BRPVP_protocolo,_exec,_idBd];
	} else {
		[_idBd,[["exec",_exec]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_removeFlagWallDb = {
	params ["_idBd"];
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format ["1:%1:removeFlagWall:%2",BRPVP_protocolo,_idBd];
	} else {
		[_idBd,[["exec",""]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
};
BRPVP_removeWallFlag = {
	{deleteVehicle _x;} forEach (_this getVariable "brpvp_flag_walls");
	_this setVariable ["brpvp_flag_walls",[]];
	_idBd = _this getVariable "id_bd";
	_idBd call BRPVP_removeFlagWallDb;
};
BRPVP_createWallAround = {
	params ["_flag","_class","_wallLen","_rotateWall","_hShift","_terrainFit","_opensCount","_opensSize","_rotate"];
	_flag setVariable ["brpvp_flag_wall_info",[_class,_wallLen,_rotateWall,_hShift,_terrainFit,_opensCount,_opensSize,_rotate],true];
	_rad = _flag getVariable ["brpvp_flag_radius",0];
	if (_rad isEqualTo 0) exitWith {};
	_idBd = _flag getVariable ["id_bd",-1];
	_segments = _opensCount;
	_opensAngle = _opensCount*_opensSize*2.5;
	_segAngle = (360-_opensAngle)/_segments;
	_radExtra = 0;
	{if (_class isEqualTo (_x select 0)) exitWith {_radExtra = _x select 6;};} forEach BRPVP_wallAroundOptions;
	_wallCount = ceil (_segAngle/(2*asin(_wallLen/(2*_rad))));
	_rad = _rad-_radExtra;
	_angleStep = _segAngle/_wallCount;
	_posZeroASL = AGLToASL BRPVP_posicaoFora;
	_allWalls = [];
	for "_o" from 0 to (_segments-1) do {
		_start = _rotate+_opensSize*2.5/2+_o*(_segAngle+_opensAngle/_opensCount);
		for "_i" from 0 to (_wallCount-1) do {
			_a = _start+_i*_angleStep+_angleStep/2;
			_posPure = _flag getPos [_rad,_a];
			_posPure set [2,(_posPure select 2) max -1];
			_posWall = _posPure vectorAdd [0,0,_hShift];
			_wall = createSimpleObject [_class,_posZeroASL];
			_allWalls pushBack _wall;
			_wall setDir (([_posWall,_flag] call BIS_fnc_dirTo)+_rotateWall);
			if (_terrainFit) then {
				private ["_hNoHoles"];
				_p1 = _flag getPos [_rad,_a-_angleStep/2];
				_p2 = _flag getPos [_rad,_a+_angleStep/2];
				_p1 set [2,(_p1 select 2) max 0];
				_p2 set [2,(_p2 select 2) max 0];
				_h1 = AGLToASL _p1 select 2;
				_h2 = AGLToASL _p2 select 2;
				_hNoHoles = -(abs (_h2-_h1))/2;
				_wall setPosASL AGLToASL (_posWall vectorAdd [0,0,_hNoHoles]);
			} else {
				_h = getPosASL _flag select 2;
				_posWall set [2,_h+_hShift];
				_wall setPosASL _posWall;
			};
		};
	};
	_flag setVariable ["brpvp_flag_walls",_allWalls];
};
BRPVP_deleteAfterTimeObjsSmall = [];
BRPVP_deleteAfterTimeSmall = {
	params ["_wait","_obj"];
	if (_obj isEqualType objNull) then {_obj = [_obj];};
	BRPVP_deleteAfterTimeObjsSmall pushBack [diag_tickTime+_wait,_obj];
};
BRPVP_deleteAfterTimeObjs = [];
BRPVP_deleteAfterTime = {
	params ["_wait","_obj"];
	if (_obj isEqualType objNull) then {_obj = [_obj];};
	BRPVP_deleteAfterTimeObjs pushBack [diag_tickTime+_wait,_obj];
};
BRPVP_killMsgRecordDisabled = {
	if (BRPVP_useExtDB3) then {
		params ["_victimObj","_victimName","_time","_ofensorName","_projectile","_distance","_ofensorObj","_pos"];
		_victimName = str (_victimObj getVariable "id_bd")+" - "+_victimName;
		_ofensorId = _ofensorObj getVariable ["id_bd",-1];
		_ofensorName = if (_ofensorId isEqualTo -1) then {"0 - Bot"} else {str _ofensorId + " - " + _ofensorName};
		_pos2D = [round (_pos select 0),round (_pos select 1)];
		_key = format ["1:%1:addKillDisabledLog:%2:%3:%4:%5:%6",BRPVP_protocolo,_victimName,_pos2D,_ofensorName,_projectile,_distance];
		_result = "extDB3" callExtension _key;
		diag_log ("======== DISABLED LOG: "+_key+" ======");
	} else {
		//NOTHING IF CLIENTSV
	};
};
BRPVP_killMsgRecordKilled = {
	if (BRPVP_useExtDB3) then {
		params ["_victimObj","_victimName","_time","_ofensorName","_projectile","_distance","_ofensorObj"];
		_victimName = str (_victimObj getVariable "id_bd")+" - "+_victimName;
		_ofensorId = _ofensorObj getVariable ["id_bd",-1];
		_ofensorName = if (_ofensorId isEqualTo -1) then {"0 - Bot"} else {str _ofensorId + " - " + _ofensorName};
		_key = format ["1:%1:addKillKilledLog:%2:%3:%4:%5",BRPVP_protocolo,_victimName,_ofensorName,_projectile,_distance];
		_result = "extDB3" callExtension _key;
		diag_log ("======== KILLED LOG: "+_key+" ======");
	} else {
		//NOTHING IF CLIENTSV
	};
};
BRPVP_removeBan = {
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:removeBan:%2",BRPVP_protocolo,_this];
		_result = "extDB3" callExtension _key;
		diag_log ("======== BAN ID "+str _this+" REMOVED. RESULT: "+_result+" ======");
	} else {
		//NOTHING IF CLIENTSV
	};
};
BRPVP_getBanList = {
	private _pName = str (_this getVariable ["id_bd",-1])+" - "+(_this getVariable ["nm","no_name_found"]);
	private _result = -1;
	diag_log ("======== PLAYER "+_pName+" ASKED FOR BAN LIST ========");
	if (BRPVP_useExtDB3) then {
		_result = "extDB3" callExtension format ["0:%1:getBanList",BRPVP_protocolo];
		BRPVP_askServerForBanListReturn = parseSimpleArray _result select 1;
	} else {
		//NOTHING IF CLIENTSV
		BRPVP_askServerForBanListReturn = [];
	};
	(owner _this) publicVariableClient "BRPVP_askServerForBanListReturn";
};
BRPVP_banPlayer = {
	params ["_p","_data"];
	if (!isNull _p) then {
		if (BRPVP_useExtDB3) then {
			_key = format (["1:%1:addBan:%2:%3:%4:%5:%6:%7",BRPVP_protocolo]+_data);
			_result = "extDB3" callExtension _key;
			diag_log ("======== PLAYER BANNED: "+_key+" ======");
			_owner = owner _p;
			if (_owner isNotEqualTo 2) then {"YouIsBanned" remoteExecCall ["endMission",_owner];};
		} else {
			//NOTHING IF CLIENTSV
		};
	};
};
BRPVP_getInvasionLog = {
	params ["_player","_id_bd","_all"];
	if (BRPVP_useExtDB3) then {
		private ["_key"];
		if (_all) then {_key = format ["0:%1:getInvasionLogAll:%2",BRPVP_protocolo,50];} else {_key = format ["0:%1:getInvasionLog:%2:%3",BRPVP_protocolo,_id_bd,50];};
		_resultado = "extDB3" callExtension _key;
		diag_log ("---- [GET INVASION LOG] _key = " + _key + " | _resultado = " + str _resultado);
		BRPVP_askServerForInvasionLogReturn = _resultado;
		BRPVP_askServerForInvasionLogReturn = parseSimpleArray BRPVP_askServerForInvasionLogReturn select 1;
		(owner _player) publicVariableClient "BRPVP_askServerForInvasionLogReturn";
	} else {
		//NOTHING IF CLIENTSV
		BRPVP_askServerForInvasionLogReturn = [];
		(owner _player) publicVariableClient "BRPVP_askServerForInvasionLogReturn";
	};
};
BRPVP_logBaseInvasion = {
	if (BRPVP_useExtDB3) then {
		"extDB3" callExtension format (["1:%1:addInvasionLog:%2:%3:%4:%5:%6",BRPVP_protocolo]+_this);
	} else {
		//NOTHING IF CLIENTSV
	};
};
BRPVP_serverRemoveHackMoney = {
	params ["_hackMoney","_obj","_idBd"];
	//ON OBJ
	if (!isNull _obj) then {
		_obj setVariable ["brpvp_mny_bank",(_obj getVariable "brpvp_mny_bank")-_hackMoney,true];
		if (owner _obj != 2) then {[["str_hack_you_was_hacked",[_hackMoney call BRPVP_formatNumber]],5] remoteExecCall ["BRPVP_hint",_obj];};
	};

	//ON DATABASE
	private ["_key","_result"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:changePlayerBankMoney:%2:%3",BRPVP_protocolo,_hackMoney,_idBd];
		_result = "extDB3" callExtension _key;
	} else {
		private _newBankMoney = (_obj getVariable ["brpvp_mny_bank",0])-_hackMoney;
		_key = "[_idBd,[[""money_bank"",_newBankMoney]]] call BRPVP_hdb_query_updatePlayersFieldsById";
		_result = [_idBd,[["money_bank",_newBankMoney]]] call BRPVP_hdb_query_updatePlayersFieldsById;
	};
	diag_log "======== REMOVE MONEY FROM PLAYER BANK =============";
	diag_log ("== _key: " + _key);
	diag_log ("== _result: " + _result);
	diag_log "====================================================";

	//ON ALL PLAYERS IF OBJ CHANGED
	{
		if (_x getVariable ["id_bd",-1] isEqualTo _idBd && !(_x isEqualTo _obj)) exitWith {
			_x setVariable ["brpvp_mny_bank",(_x getVariable "brpvp_mny_bank")-_hackMoney,true];
			if (owner _x != 2) then {[["str_hack_you_was_hacked",[_hackMoney call BRPVP_formatNumber]],5] remoteExecCall ["BRPVP_hint",_x];};
		};
	} forEach call BRPVP_playersList;
};
BRPVP_virtualGarageSpawnVehicle = {
	params ["_id","_class","_player","_vgTime","_cliId","_posW","_vDU"];
	private ["_key","_resultado"];
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:putVirtualGarageMark:%2:%3",BRPVP_protocolo,0,_id];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_id,[[""virtualGarage"",0]]] call BRPVP_hdb_query_updateVehicleFieldsById";
		_resultado = [_id,[["virtualGarage",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
	diag_log "======== REMOVE FROM VIRTUAL GARAGE ================";
	diag_log ("== _key: "+_key);
	diag_log ("== _resultado: "+_resultado);
	diag_log "====================================================";
	if (BRPVP_useExtDB3) then {
		_resultado = "extDB3" callExtension format ["0:%1:getObject:%2",BRPVP_protocolo,_id];
	} else {
		_resultado = _id call BRPVP_hdb_query_getObject;
	};
	[_resultado,_class,_player,_vgTime,_cliId,_posW,_vDU] remoteExecCall ["BRPVP_virtualGarageSpawnVehicleHC",2];
};
BRPVP_getMyVirtualGarage = {//PPP FEITO
	private _player = _this;
	private _owner = _player getVariable ["id_bd",-1];
	private _myVirtualGarageOptions = [];

	//SPAWN ENTITIE VEHICLES
	if (BRPVP_useExtDB3) then {
		_ultimoId = -1;
		_resultado = "";
		while {_resultado isNotEqualTo "[1,[]]"} do {
			private ["_veiculo","_isSO"];
			_resultado = "extDB3" callExtension format ["0:%1:getVirtualGarageObjects:%2:%3",BRPVP_protocolo,_owner,_ultimoId];
			if (_resultado isNotEqualTo "[1,[]]") then {
				{
					_veiculoId = _x select 0;
					_class = _x select 1;
					_paint = _x select 2;
					_cover = _x select 3;
					_ammo = _x select 4;
					_life = _x select 5;
					_isBM = _x select 6 isEqualTo "_this setVariable ['brpvp_no_insurance',true,true];";
					_secured = _x select 7;
					_ultimoId = _veiculoId;
					_myVirtualGarageOptions pushBack [_veiculoId,_class,_paint,_cover,_ammo,_life,_isBM,_secured];
				} forEach (parseSimpleArray _resultado select 1);
			};
		};
	} else {
		{
			_veiculoId = _x select 0;
			_class = _x select 1;
			_paint = _x select 2;
			_cover = _x select 3;
			_ammo = _x select 4;
			_life = _x select 5;
			_isBM = _x select 6 isEqualTo "_this setVariable ['brpvp_no_insurance',true,true];";
			_secured = _x select 7;
			_myVirtualGarageOptions pushBack [_veiculoId,_class,_paint,_cover,_ammo,_life,_isBM,_secured];
		} forEach (_owner call BRPVP_hdb_query_getVirtualGarageObjects);
	};
	BRPVP_myVirtualGarageOptions = _myVirtualGarageOptions;
	(owner _player) publicVariableClient "BRPVP_myVirtualGarageOptions";
};
BRPVP_putInVirtualGarage = {//PPP FEITO
	_this call BRPVP_salvaVeiculo;
	private ["_key","_resultado"];
	private _id = _this getVariable "id_bd";
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:putVirtualGarageMark:%2:%3",BRPVP_protocolo,1,_id];
		_resultado = "extDB3" callExtension _key;
	} else {
		_key = "[_id,[[""virtualGarage"",1]]] call BRPVP_hdb_query_updateVehicleFieldsById";
		_resultado = [_id,[["virtualGarage",1]]] call BRPVP_hdb_query_updateVehicleFieldsById;
	};
	diag_log "======== PUT IN VIRTUAL GARAGE =====================";
	diag_log ("== _key: " + _key);
	diag_log ("== _resultado: " + _resultado);
	diag_log "====================================================";
	{if (typeOf _x isEqualTo "Land_CUP_Frigate_Ladders") then {deleteVehicle _x;};} forEach attachedObjects _this;
	deleteVehicle _this;
};
BRPVP_sendObjectOwnerNameFromDB = {//PPP FEITO
	params ["_own","_player"];
	private _resultado = "";
	if (BRPVP_useExtDB3) then {
		_resultado = "extDB3" callExtension format ["0:%1:getObjectOwnerName:%2",BRPVP_protocolo,_own];
		if (_resultado isEqualTo "[1,[]]") then {BRPVP_sendObjectOwnerNameFromDBReturn = "no_name";} else {BRPVP_sendObjectOwnerNameFromDBReturn = parseSimpleArray _resultado select 1 select 0 select 0;};
	} else {
		_resultado = _own call BRPVP_hdb_query_getObjectOwnerName;
		if (_resultado isEqualTo "name_not_found") then {BRPVP_sendObjectOwnerNameFromDBReturn = "no_name";} else {BRPVP_sendObjectOwnerNameFromDBReturn = _resultado;};
	};
	(owner _player) publicVariableClient "BRPVP_sendObjectOwnerNameFromDBReturn";
};
BRPVP_salvarPlayerServidor = {
	private _estadoPlayer = _this;
	private _isPoloBlue = (_estadoPlayer select 2 select 2 select 0) isEqualTo "U_C_Poloshirt_blue";
	private _steamIdOk = (_estadoPlayer select 0) isNotEqualTo "0";
	if (_steamIdOk && !_isPoloBlue) then {
		private ["_key","_resultado"];
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:savePlayer:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14:%15:%16:%17:%18:%19:%20",BRPVP_protocolo,_estadoPlayer select 1,_estadoPlayer select 2,_estadoPlayer select 3,_estadoPlayer select 4,_estadoPlayer select 5,_estadoPlayer select 6,_estadoPlayer select 0,_estadoPlayer select 7,_estadoPlayer select 8,_estadoPlayer select 9,_estadoPlayer select 10,_estadoPlayer select 12,_estadoPlayer select 13,_estadoPlayer select 14,_estadoPlayer select 15,_estadoPlayer select 16,_estadoPlayer select 17,_estadoPlayer select 18,_estadoPlayer select 19];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _sid = _estadoPlayer select 0;
			private _data = [["inventario",_estadoPlayer select 1],["backpack",_estadoPlayer select 2],["posicao",_estadoPlayer select 3],["saude",_estadoPlayer select 4],["modelo",_estadoPlayer select 5],["armaNaMao",_estadoPlayer select 6],/*["steamKey",_estadoPlayer select 0],*/["amigos",_estadoPlayer select 7],["vivo",_estadoPlayer select 8],["exp",_estadoPlayer select 9],["comp_padrao",_estadoPlayer select 10],["money",_estadoPlayer select 12],["specialItems",_estadoPlayer select 13],["money_bank",_estadoPlayer select 14],["hhBalance",_estadoPlayer select 15],["headPrice",_estadoPlayer select 16],["remoteControlUses",_estadoPlayer select 17],["config",_estadoPlayer select 18],["weapon4",_estadoPlayer select 19]];
			_key = "[_sid,_data] call BRPVP_hdb_query_updatePlayersFieldsBySid";
			_resultado = [_sid,_data] call BRPVP_hdb_query_updatePlayersFieldsBySid;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- "+(_estadoPlayer select 0);
		diag_log "---- [UPDATE PLAYER ON DB]";
		diag_log ("---- _key = "+_key+".");
		diag_log ("---- _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	} then {
		if (!_steamIdOk) then {
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- "+(_estadoPlayer select 0);
			diag_log "---- [UPDATE PLAYER *FAILED*] NO STEAM ID!";
			diag_log "----------------------------------------------------------------------------------";
		};
		if (_isPoloBlue) then {
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- "+(_estadoPlayer select 0);
			diag_log "---- [UPDATE PLAYER NOT DONE] UNIFORM IS U_C_Poloshirt_blue!";
			diag_log "----------------------------------------------------------------------------------";
		};
	};
};
BRPVP_salvarPlayerVaultServidor = {
	private ["_key","_resultado"];
	private _estadoVault = _this select 0;
	private _vaultIdx = _this select 1;
	if (BRPVP_useExtDB3) then {
		_key = format ["1:%1:saveVault:%2:%3:%4:%5:%6",BRPVP_protocolo,_estadoVault select 0,_estadoVault select 1,_estadoVault select 2,_estadoVault select 3,_vaultIdx];
		_resultado = "extDB3" callExtension _key;
	} else {
		private _uid = _estadoVault select 0;
		private _data = [_estadoVault select 1,_estadoVault select 3];
		_key = "[_uid,_vaultIdx,_data] call BRPVP_hdb_query_saveVault";
		_resultado = [_uid,_vaultIdx,_data] call BRPVP_hdb_query_saveVault;
	};
	diag_log "----------------------------------------------------------------------------------";
	diag_log ("---- PLAYER STEAM_ID: "+(_estadoVault select 0));
	diag_log ("---- [UPDATE VAULT ON DB IDX = "+str _vaultIdx+"]");
	diag_log ("---- _key = "+_key+".");
	diag_log ("---- _resultado = "+str _resultado+".");
	diag_log "----------------------------------------------------------------------------------";
};
BRPVP_pegaEstadoPlayerSv = {
	_player = _this;
	
	//ARMAS (P,S,G)
	_armaPriNome = primaryWeapon _player;
	_armaSecNome = secondaryWeapon _player;
	_armaGunNome = handGunWeapon _player;
	
	//ARMAS ASSIGNED
	_aPI = primaryWeaponItems _player;
	_aSI = secondaryWeaponItems _player;
	_aGI = handGunItems _player;
	
	//CONTAINERS
	_backPackName = backpack _player;
	_vestName = vest _player;
	_uniformName = uniform _player;
	
	//APETRECHOS
	_capacete = headGear _player;
	_oculos = goggles _player;
	
	//SAUDE
	_hpd = getAllHitPointsDamage _player;
	
	//PLAYERS CONTAINERS
	_bpc = backpackContainer _player;
	_vtc = vestContainer _player;
	_ufc = uniformContainer _player;
	
	//PLAYERS CONTAINERS MAGAZINES AMMO
	if (!isNull _bpc) then {_bpc = magazinesAmmoCargo _bpc;} else {_bpc = [];};
	if (!isNull _vtc) then {_vtc = magazinesAmmoCargo _vtc;} else {_vtc = [];};
	if (!isNull _ufc) then {_ufc = magazinesAmmoCargo _ufc;} else {_ufc = [];};
		
	//ESTADO _player
	[
		//ID DO _player
		_player getVariable ["id","0"],
		//ARMAS E ASSIGNED ITEMS
		[
			assignedItems _player,
			[_armaPriNome,_aPI,primaryWeaponMagazine _player],
			[_armaSecNome,_aSI,secondaryWeaponMagazine _player],
			[_armaGunNome,_aGI,handGunMagazine _player],
			_player getVariable ["owt",[]]
		],
		//CONTAINERS (BACKPACK, VEST, UNIFORME)
		[
			[_backpackName,[getWeaponCargo backpackContainer _player,getItemCargo backpackContainer _player,_bpc]],
			[_vestName,[getWeaponCargo vestContainer _player,getItemCargo vestContainer _player,_vtc]],
			[_uniformName,[getWeaponCargo uniformContainer _player,getItemCargo uniformContainer _player,_ufc]]
		],
		//DIRECAO E POSICAO
		[getDir _player,getPosWorld _player],
		//SAUDE
		[[_hpd select 1,_hpd select 2],_player getVariable ["sud",[100,100]],damage _player],
		//MODELO E APETRECHOS
		[typeOf _player,_capacete,_oculos],
		//ARMA NA MAO
		currentWeapon _player,
		//AMIGOS
		_player getVariable ["amg",[]],
		//VIVO OU MORTO
		if (_player call BRPVP_pAlive) then {1} else {0},
		//EXPERIENCIA
		_player getVariable ["exp",BRPVP_experienciaZerada],
		//DEFAULT SHARE TYPE
		_player getVariable ["stp",1],
		//PLAYER ID BD
		_player getVariable ["id_bd",-1],
		//PLAYER MONEY
		_player getVariable ["mny",0],
		//SPECIAL ITEMS
		_player getVariable ["sit",[]],
		//PLAYER MONEY ON BANK
		_player getVariable ["brpvp_mny_bank",0],
		//HEAD HUNTER SERVICES BALANCE
		_player getVariable ["brpvp_hh_balance",0],
		//HEAD PRICE
		_player getVariable ["brpvp_head_price",0],
		//REMOTE CONTROL USES
		_player getVariable ["brpvp_rc_uses",0],
		//PLAYER CONFIG
		_player getVariable ["brpvp_player_config",[1500,2500,0,0,0,0,0,0]],
		//PLAYER WEAPON 4
		_player getVariable ["brpvp_weapon_4",[]]
	]
};
BRPVP_salvaVeiculo = {//OK
	private ["_key","_resultado"];
	private _id_bd = _this getVariable ["id_bd",-1];
	if (_id_bd isNotEqualTo -1) then {
		private _sustenter = _this getVariable ["brpvp_sustenter_obj",objNull];
		private _posObj = [_sustenter,_this] select isNull _sustenter;
		private _estadoCarro = [
			_this call BRPVP_getCargoArray,
			[getPosWorld _posObj,[vectorDir _posObj,vectorUp _posObj]],
			typeOf _this,
			_this getVariable ["own",-1],
			_this getVariable ["stp",1],
			_this getVariable ["amg",[[],[],true]],
			_this getVariable ["mapa",false],
			_this getVariable ["brpvp_locked",false],
			_this getVariable ["brpvp_lastPayment",[0,0,0,0,0,0]],
			_this call BRPVP_getVehicleAmmo,
			_this call BRPVP_getHitpointsDamage,
			_this getVariable ["brpvp_lifesfix",0]
		];
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicle:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11:%12:%13:%14",BRPVP_protocolo,_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,_estadoCarro select 9,_estadoCarro select 10,_estadoCarro select 11,_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _data = [_estadoCarro select 0,_estadoCarro select 1,_estadoCarro select 2,_estadoCarro select 3,_estadoCarro select 4,_estadoCarro select 5,_estadoCarro select 6,if (_estadoCarro select 7) then {1} else {0},_estadoCarro select 8,_estadoCarro select 9,_estadoCarro select 10,_estadoCarro select 11];
			_key = "[_id_bd,_data] call BRPVP_hdb_query_saveVehicle";
			_resultado = [_id_bd,_data] call BRPVP_hdb_query_saveVehicle;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATE VEHICLE: _key = "+str _key+".");
		diag_log ("[BRPVP] UPDATE VEHICLE: _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_salvaGodModeHouseAmg = {
	private _id_bd = _this getVariable ["brpvp_map_god_mode_house_id",-1];
	private _carroVivo = alive _this;
	if (_id_bd isNotEqualTo -1 && _carroVivo) then {
		private ["_key","_resultado"];
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveGodModeHouseAmg:%2:%3:%4:%5",BRPVP_protocolo,_this getVariable ["own",-1],_this getVariable ["stp",1],_this getVariable ["amg",[[],[],true]],_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _own = _this getVariable ["own",-1];
			private _stp = _this getVariable ["stp",1];
			private _amg = _this getVariable ["amg",[[],[],true]];
			private _data = [["own",_own],["stp",_stp],["amg",_amg]];
			_key = "[_id_bd,_data] call BRPVP_hdb_query_saveGodModeHouseAmg";
			_resultado = [_id_bd,_data] call BRPVP_hdb_query_saveGodModeHouseAmg;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATE GOD MODE HOUSE FRIENDS: _key = " + str _key + ".");
		diag_log ("[BRPVP] UPDATE GOD MODE HOUSE FRIENDS: _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_salvaVeiculoAmg = {
	private ["_key","_resultado"];
	private _id_bd = _this getVariable ["id_bd",-1];
	private _carroVivo = alive _this;
	if (_id_bd isNotEqualTo -1 && _carroVivo) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicleAmg:%2:%3:%4:%5",BRPVP_protocolo,_this getVariable ["own",-1],_this getVariable ["stp",1],_this getVariable ["amg",[[],[],true]],_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _fieldsData = [["owner",_this getVariable ["own",-1]],["comp",_this getVariable ["stp",1]],["amigos",_this getVariable ["amg",[[],[],true]]]];
			_key = "[_id_bd,_fieldsData] call BRPVP_hdb_query_updateVehicleFieldsById";
			_resultado = [_id_bd,_fieldsData] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATE VEHICLE FRIENDS: _key = "+str _key+".");
		diag_log ("[BRPVP] UPDATE VEHICLE FRIENDS: _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_saveVehicleLock = {
	private ["_key","_resultado"];
	private _id_bd = _this getVariable ["id_bd",-1];
	private _carroVivo = alive _this;
	if (_id_bd > -1 && _carroVivo) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:saveVehicleLock:%2:%3",BRPVP_protocolo,if(_this getVariable ["brpvp_locked",false]) then {1} else {0},_id_bd];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _fieldsData = [["lock",if(_this getVariable ["brpvp_locked",false]) then {1} else {0}]];
			_key = "[_id_bd,_fieldsData] call BRPVP_hdb_query_updateVehicleFieldsById";
			_resultado = [_id_bd,_fieldsData] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("[BRPVP] UPDATE VEHICLE LOCK: _key = "+str _key+".");
		diag_log ("[BRPVP] UPDATE VEHICLE LOCK: _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_salvaVault = {
	params ["_p","_del"];
	private _v = _p getVariable ["wh",objNull];
	if (!isNull _v) then {
		private _idx = _v getVariable "bidx";
		private _estadoVault = [_p getVariable "id",_v call BRPVP_getCargoArray,1,round(100*load _v)];
		[_estadoVault,_idx] call BRPVP_salvarPlayerVaultServidor;
		diag_log ("[BRPVP VAULT] VAULT MASS/LOGOFF SAVE IDX = "+str _idx+" ("+name _p+"): "+str _estadoVault);
		if (_del) then {deleteVehicle _v;};
	};
};
BRPVP_veiculoMorreu = {
	//REMOVE VEHICLE FROM DATA BASE
	private ["_key","_resultado","_veiculoId","_txt","_pos"];
	if (_this isEqualType objNull) then {
		_veiculoId = _this getVariable ["id_bd",-1];
		if (_veiculoId isEqualTo -1) then {_veiculoId = _this getVariable ["brpvp_carr_id_bd",-1];};
		_txt = typeOf _this;
		_pos = getPosASL _this;
	} else {
		_veiculoID = _this;
		_txt = str _veiculoID;
		_pos = [];
	};
	if (_veiculoId > -1) then {
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_veiculoId];
			_resultado = "extDB3" callExtension _key;
		} else {
			_key = "[_veiculoId,[[""active"",0]]] call BRPVP_hdb_query_updateVehicleFieldsById";
			_resultado = [_veiculoId,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log ("VEHICLE REMOVED FROM DB: "+_txt+". POSICAO: "+str _pos+".");
		diag_log ("[BRPVP] _key = "+str _key+".");
		diag_log ("[BRPVP] _resultado = "+str _resultado+".");
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_veiculoMorreuTurret = {
	params ["_o","_t"];
	(_t getVariable ["id_bd",-1]) remoteExecCall ["BRPVP_removeTurretInfo",0];
	_t call BRPVP_veiculoMorreu;
	deleteVehicle _o;
	deleteVehicle _t;
};
BRPVP_salvaEmMassaPlayers = {
	diag_log "********************* MASS SAVE PLAYERS ************************";
	remoteExecCall ["BRPVP_getPlayerDataAndSendServerToSave",BRPVP_allNoServer];
	diag_log "******************* MASS SAVE END PLAYERS **********************";
};
BRPVP_salvaEmMassaPlayersEsc = {
	diag_log "********************* MASS SAVE PLAYERS ************************";
	{[_x call BRPVP_pegaEstadoPlayerSv,[]] call BRPVP_salvaPlayerVault;} forEach call BRPVP_playersList;
	diag_log "******************* MASS SAVE END PLAYERS **********************";
};


BRPVP_salvaEmMassaVeiculos = {
	diag_log "********************* MASS SAVE VEHICLES ***********************";
	private _contaSLV = 0;
	{
		if (_x getVariable ["slv",false]) then {
			_contaSLV = _contaSLV+1;
			_x call BRPVP_salvaVeiculo;
			if (count crew _x isEqualTo 0) then {_x setVariable ["slv",false,true];};
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				_x call BRPVP_salvaVeiculoAmg;
				_x setVariable ["slv_amg",false,true];
			};
			if (_x getVariable ["brpvp_slv_lck",false]) then {
				_x call BRPVP_saveVehicleLock;
				_x setVariable ["brpvp_slv_lck",false,true];
			};
		};
	} forEach entities [["Motorcycle","Car","Tank","Ship","Air"],[]];
	{
		if (_x getVariable ["slv",false]) then {
			_contaSLV = _contaSLV+1;
			_x call BRPVP_salvaVeiculo;
			_x setVariable ["slv",false,true];
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				_x call BRPVP_salvaVeiculoAmg;
				_x setVariable ["slv_amg",false,true];
			};
		};
	} forEach BRPVP_ownedHouses;
	{
		if (_x getVariable ["slv_amg",false]) then {
			_x call BRPVP_salvaGodModeHouseAmg;
			_x setVariable ["slv_amg",false,true];
		};
	} forEach BRPVP_godModeHouseObjects;
	{
		if (_x getVariable ["slv",false]) then {
			_contaSLV = _contaSLV+1;
			_x call BRPVP_salvaVeiculo;
			_x setVariable ["slv",false,true];
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				_x call BRPVP_salvaVeiculoAmg;
				_x setVariable ["slv_amg",false,true];
			};
		};
	} forEach entities [["StaticWeapon"],[]];
	{
		if (_x getVariable ["brpvp_save_lastPayment",false]) then {
			private ["_key","_resultado"];
			_x setVariable ["brpvp_save_lastPayment",false,true];
			if (BRPVP_useExtDB3) then {
				_key = format ["1:%1:saveFlagPayment:%2:%3",BRPVP_protocolo,_x getVariable "brpvp_lastPayment",_x getVariable "id_bd"];
				_resultado = "extDB3" callExtension _key;
			} else {
				private _flagId = _x getVariable "id_bd";
				private _pDate = _x getVariable "brpvp_lastPayment";
				_key = "[_flagId,[[""lastPayment"",_pDate]]] call BRPVP_hdb_query_updateVehicleFieldsById";
				_resultado = [_flagId,[["lastPayment",_pDate]]] call BRPVP_hdb_query_updateVehicleFieldsById;
			};
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- [SAVE FLAG NEW LAST PAYMENT]";
			diag_log ("---- _key = "+str _key+".");
			diag_log ("---- _resultado = "+str _resultado+".");
			diag_log "----------------------------------------------------------------------------------";
		};
	} forEach BRPVP_allFlags;
	diag_log ("["+str _contaSLV+" VEHICLES SAVED!]");
	diag_log "******************* MASS SAVE END VEHICLES *********************";
};
BRPVP_salvaEmMassaVeiculosServerOff = {
	diag_log "********************* MASS SAVE VEHICLES SERVER OFF ***********************";
	private _start = diag_tickTime;
	private _contaSLV = 0;
	{
		if (alive _x) then {
			if (_x getVariable ["slv",false]) then {
				_contaSLV = _contaSLV+1;
				_x call BRPVP_salvaVeiculo;
			} else {
				if (_x getVariable ["slv_amg",false]) then {
					_x call BRPVP_salvaVeiculoAmg;
				};
				if (_x getVariable ["brpvp_slv_lck",false]) then {
					_x call BRPVP_saveVehicleLock;
				};
			};
			if (_x getVariable ["brpvp_delete_when_possible",false]) then {
				_x setPosATL BRPVP_posicaoFora;
				_x setDamage [1,false];
			};
		} else {
			if !(_x getVariable ["brpvp_veh_dead_run_ok",false]) then {[_x,objNull] call BRPVP_MPKilled;};
		};
	} forEach entities [["Motorcycle","Car","Tank","Ship","Air"],[]];
	{
		if (_x getVariable ["slv",false]) then {
			_contaSLV = _contaSLV+1;
			_x call BRPVP_salvaVeiculo;
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				_x call BRPVP_salvaVeiculoAmg;
			};
		};
	} forEach BRPVP_ownedHouses;
	{
		if (_x getVariable ["slv_amg",false]) then {
			_contaSLV = _contaSLV+1;
			_x call BRPVP_salvaGodModeHouseAmg;
		};
	} forEach BRPVP_godModeHouseObjects;
	{
		if (_x getVariable ["slv",false]) then {
			_contaSLV = _contaSLV+1;
			_x call BRPVP_salvaVeiculo;
		} else {
			if (_x getVariable ["slv_amg",false]) then {
				_x call BRPVP_salvaVeiculoAmg;
			};
		};
	} forEach entities [["StaticWeapon"],[]];
	{
		if (_x getVariable ["brpvp_save_lastPayment",false]) then {
			private ["_key","_resultado"];
			_x setVariable ["brpvp_save_lastPayment",false,true];
			if (BRPVP_useExtDB3) then {
				_key = format ["1:%1:saveFlagPayment:%2:%3",BRPVP_protocolo,_x getVariable "brpvp_lastPayment",_x getVariable "id_bd"];
				_resultado = "extDB3" callExtension _key;
			} else {
				private _flagId = _x getVariable "id_bd";
				private _pDate = _x getVariable "brpvp_lastPayment";
				_key = "[_flagId,[[""lastPayment"",_pDate]]] call BRPVP_hdb_query_updateVehicleFieldsById";
				_resultado = [_flagId,[["lastPayment",_pDate]]] call BRPVP_hdb_query_updateVehicleFieldsById;
			};
			diag_log "----------------------------------------------------------------------------------";
			diag_log "---- [SAVE FLAG NEW LAST PAYMENT]";
			diag_log ("---- _key = "+str _key+".");
			diag_log ("---- _resultado = "+str _resultado+".");
			diag_log "----------------------------------------------------------------------------------";
		};
	} forEach BRPVP_allFlags;
	diag_log ("["+str _contaSLV+" VEHICLES SAVED!]");
	diag_log ("******************* MASS SAVE VEHICLES SERVER OFF END - TIME "+str (diag_tickTime-_start)+" *********************");
};
BRPVP_salvaEmMassa = {
	call BRPVP_salvaEmMassaPlayers;
	call BRPVP_salvaEmMassaVeiculos;
};
BRPVP_salvaEmMassaEsc = {
	call BRPVP_salvaEmMassaPlayersEsc;
	call BRPVP_salvaEmMassaVeiculos;
};
BRPVP_daComoMorto = {
	if (_this select 0 != "0") then {
		private ["_key","_resultado"];
		if (BRPVP_useExtDB3) then {
			_key = format ["1:%1:playerSetLife:%2:%3",BRPVP_protocolo,_this select 0,_this select 1];
			_resultado = "extDB3" callExtension _key;
		} else {
			private _steamKey = _this select 1;
			private _vivo = _this select 0;
			_key = "[_steamKey,[[""vivo"",_vivo]]] call BRPVP_hdb_query_updatePlayersFieldsBySid";
			_resultado = [_steamKey,[["vivo",_vivo]]] call BRPVP_hdb_query_updatePlayersFieldsBySid;
		};
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- " + (_this select 0);
		diag_log ("---- [CHANGE PLAYER LIFE STATE " + str (_this select 1) + "]");
		diag_log ("---- _key = " + _key + ".");
		diag_log ("---- _resultado = " + str _resultado + ".");
		diag_log "----------------------------------------------------------------------------------";
	} then {
		diag_log "----------------------------------------------------------------------------------";
		diag_log "---- " + (_this select 0);
		diag_log "---- [CHANGE PLAYER LIFE STATE " + str (_this select 1) + " *FAILED*]";
		diag_log "---- NO ID!";
		diag_log "----------------------------------------------------------------------------------";
	};
};
BRPVP_veiculoEhReset = {
	_this removeAllMPEventHandlers "MPKilled";
	_this addMPEventHandler ["MPKilled",{_this call BRPVP_MPKilled;}];
	[_this,["HandleDamage",{call BRPVP_playerServerVehHD;}]] remoteExecCall ["addEventHandler",0,true];
	if (_this isKindOf "Motorcycle" || _this isKindOf "Car" || _this isKindOf "Tank") then {[_this,["EpeContactStart",{call BRPVP_epeContactOn;}]] remoteExecCall ["addEventHandler",0,true];};
	if (_this isKindOf "Air") then {
		if (local _this) then {_this call BRPVP_setAirGodMode;} else {_this remoteExecCall ["BRPVP_setAirGodMode",_this];};
		_this addEventHandler ["Local",{call BRPVP_airVehLocal;}];
	};
	//NOHC_CHECK
	//if (!isNil "BRPVP_HC1ClientId") then {
		[_this,["GetOut",{call BRPVP_AIGetOutVehTimerToDisable;}]] remoteExecCall ["addEventHandler",2];
	//};
};

diag_log ("[SCRIPT] servidor_funcoes_exclusive.sqf END: " + str round (diag_tickTime - _scriptStart));