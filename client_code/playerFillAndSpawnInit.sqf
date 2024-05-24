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

diag_log "[BRPVP FILE] nascimento_player.sqf INITIATED";

//BLACK SCREEN
cutText [localize "str_please_wait","BLACK FADED",100];

//REMOVE BLINDNESS
if (BRPVP_blindHandle isNotEqualTo -1) then {
	BRPVP_blindHandle ppEffectEnable false;
	ppEffectDestroy BRPVP_blindHandle;
	BRPVP_blindHandle = -1;
	player setVariable ["brpvp_blind",false,true];
};

//REMOVE ATOMIC BOMB DEATH POROJECTILE
if (player getVariable ["brpvp_atomic_bomb_death",false]) then {player setVariable ["brpvp_atomic_bomb_death",false];};

//DISABLE DAMAGE
player allowDamage false;

//PRIVATE VARS
private ["_tempofora"];

//RESETA VOLUME
0 fadeSound 1;

//CLICK MAPA
BRPVP_onMapSingleClick = BRPVP_padMapaClique;

//X SECONDS UNIT MOVEMENT CHECK
_init = time;

//CHECK PLAYER STATE IN DATA BASE
BRPVP_checaExistenciaPlayerBdRetorno = nil;
[player,player getVariable "id"] remoteExecCall ["BRPVP_checaExistenciaPlayerBd",2];
waitUntil {!isNil "BRPVP_checaExistenciaPlayerBdRetorno"};

256 cutText ["","PLAIN",1];

_allDeadMen = entities [["Box_T_East_Wps_F"],[]];

//ACHA CORPOS DO PLAYER
_ultimo = 0;
_lastCorpseSearched = objNull;
{
	if ((player getVariable "id") isEqualTo (_x getVariable ["brpvp_owner_id","0"]) && _x getVariable ["hrm",-1] != -1) then {
		BRPVP_meuAllDead pushBack _x;
		private _newLast = _x getVariable ["hrm",0];
		if (_newLast > _ultimo) then {
			_ultimo = _newLast;
			_lastCorpseSearched = _x;
		};
	};
} forEach _allDeadMen;
_syncTimeNow = call BRPVP_getSyncTime;
_tempofora = _syncTimeNow-_ultimo;

//DELETA CORPOS EM EXCESSO
while {count BRPVP_meuAllDead > BRPVP_maxPlayerDeadBodyCount} do {
	_maisAntigo = 100000000;
	_idcDel = 0;
	{
		_ant = _x getVariable ["hrm",0];
		if (_ant < _maisAntigo) then {
			_maisAntigo = _ant;
			_idcDel = _forEachIndex;
		};
	} forEach BRPVP_meuAllDead;
	deleteVehicle (BRPVP_meuAllDead select _idcDel);
	BRPVP_meuAllDead deleteAt _idcDel;
};

//SET CAPTIVE STATE
if (BRPVP_playerIsCaptive) then {
	player setCaptive true;
};

//DESTROY LOGIN CAN
if (!isNull BRPVP_loginCam) then {
	BRPVP_loginCam cameraEffect ["TERMINATE","BACK"];
	camDestroy BRPVP_loginCam;
};

private _armaNaMaoNasce = "not_found";
//EXECUTA SE O PLAYER E ANTIGO E ESTA VIVO NO BANCO DE DADOS OU EM CASO DE REANIMACAO
if (BRPVP_checaExistenciaPlayerBdRetorno isEqualTo "no_bd_e_vivo") then {
	openMap [false,false];
	private ["_resultadoCompilado","_armaNaMao"];

	//GET PLAYER DATA FROM BODY (REVIVE) OR DATA BASE
	cutText [localize "str_please_wait","BLACK FADED",10];
	
	//PEGA PLAYER NO BD
	BRPVP_pegaPlayerBdRetorno = nil;
	[player,player getVariable "id"] remoteExecCall ["BRPVP_pegaPlayerBd",2];
	waitUntil {!isNil "BRPVP_pegaPlayerBdRetorno"};

	//COMPILA INFORMACOES DO PLAYER VIVO
	_resultadoCompilado = parseSimpleArray BRPVP_pegaPlayerBdRetorno;
	_resultadoCompilado = _resultadoCompilado select 1;
	
	//PELA PLAYER (DEIXA ELE PELADO)
	false call BRPVP_escolheModaPlayer;
	
	//PLAYER WEAPON 4
	private _weapon4 = _resultadoCompilado select 0 select 17;
	if (_weapon4 isNotEqualTo [] && count _weapon4 isNotEqualTo 2) then {_weapon4 = [_weapon4,[]];};
	player setVariable ["brpvp_weapon_4",_weapon4,true];
	
	//NUMBER OF VAULTS
	_vaults = _resultadoCompilado select 0 select 18;
	if (_vaults isEqualTo -1) then {BRPVP_vaultNumber = BRPVP_vaultNumberCfg;} else {BRPVP_vaultNumber = _vaults;};
	player setVariable ["brpvp_vaults",[_vaults,BRPVP_vaultNumber],true];

	//VIRTUAL GARAGE MULTIPLIER
	_vgMult = _resultadoCompilado select 0 select 19;
	player setVariable ["brpvp_vg_mult",_vgMult,true];

	//MY CLONE
	_clone = _resultadoCompilado select 0 select 20;
	_clone = if (_clone call BRPVP_classExists || _clone in BRPVP_cloneCustomNames) then {_clone} else {""};
	player setVariable ["brpvp_my_clone",_clone,true];

	//PERKS
	_activePerks = _resultadoCompilado select 0 select 21;
	player setVariable ["brpvp_active_perks",_activePerks,true];

	//PLAYER CONFIG
	_config = _resultadoCompilado select 0 select 16;
	player setVariable ["brpvp_player_config",_config,[clientOwner,2]];
	_config call BRPVP_applyPlayerConfig;

	//MONEY
	_money = _resultadoCompilado select 0 select 10;
	player setVariable ["mny",_money,true];

	//SPECIAL ITEMS
	_sit = _resultadoCompilado select 0 select 11;
	player setVariable ["sit",_sit call BRPVP_sitConvert,true];

	//MONEY BANK
	_moneyBank = _resultadoCompilado select 0 select 12;
	player setVariable ["brpvp_mny_bank",_moneyBank,true];
	
	//HEAD HUNTER SERVICES BALANCE
	_hhBalance = _resultadoCompilado select 0 select 13;
	player setVariable ["brpvp_hh_balance",_hhBalance,true];

	//HEAD PRICE
	_headPrice = _resultadoCompilado select 0 select 14;
	player setVariable ["brpvp_head_price",_headPrice,true];

	//REMOTE CONTROL USES
	_rcUses = _resultadoCompilado select 0 select 15;
	player setVariable ["brpvp_rc_uses",_rcUses,true];

	//CAPACETE E OCULOS
	_modelo = _resultadoCompilado select 0 select 4;
	if (_modelo select 1 != "") then {player addHeadGear (_modelo select 1);};
	if (_modelo select 2 != "") then {player addGoggles (_modelo select 2);};
	
	//COMPARTILHAMENTO PADRAO
	player setVariable ["stp",_resultadoCompilado select 0 select 9,true];
	
	//ID DO BANCO DE DADOS
	_id_bd = _resultadoCompilado select 0 select 8;
	player setVariable ["id_bd",_id_bd,true];
	[_id_bd,player getVariable "nm"] remoteExecCall ["BRPVP_salvaNomePeloIdBd",2];

	//SET AS PVE BANDIT IF IN LIST
	if (_id_bd in BRPVP_pveBanditObjListId) then {
		BRPVP_pveBanditObjList = BRPVP_pveBanditObjList apply {if (isNull _x || _x getVariable ["dd",-1] > 0) then {-1} else {_x};};
		BRPVP_pveBanditObjList = BRPVP_pveBanditObjList-[-1];
		BRPVP_pveBanditObjList pushBack player;
		publicVariable "BRPVP_pveBanditObjList";
		["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\bandit.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.36},1000000,0,0,3098] call BRPVP_fnc_dynamicText;
		player setVariable ["brpvp_no_veh_time",serverTime];
	};

	//ZOMBIE BLOOD BAG IF VALID
	if (_id_bd in BRPVP_zombieBloodBagActive) then {
		player setVariable ["brpvp_z_blood_bag_on",true,true];
		["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\anti_zombie_on.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.17},1000000,0,0,3195] call BRPVP_fnc_dynamicText;
	};

	//CLIMB ABILITY IF VALID
	if (_id_bd in BRPVP_climbActivePlayers) then {BRPVP_climbOn = true;};

	//ASSIGNED PLAYER E (ARMAS + ASSIGNED)
	_inventario = _resultadoCompilado select 0 select 0;
	
	//ASSIGNED PLAYER
	{if (_x iskindOf ["Binocular",configFile >> "CfgWeapons"]) then {player addWeapon _x;} else {player linkItem _x;};} forEach (_inventario select 0);

	//ADICIONA VEST PARA RECEBER MAGAZINES DAS ARMAS
	player addBackpack "B_Carryall_oli";
	
	//ARMA PRIMARIA
	_wep = _inventario select 1 select 0;
	if (_wep != "") then {
		{player addMagazine _x;} forEach (_inventario select 1 select 2);
		player addWeapon _wep;
		{if (_x != "") then {player addPrimaryWeaponItem _x;};} forEach (_inventario select 1 select 1);
	};
	
	//ARMA SECUNDARIA
	_wep = _inventario select 2 select 0;
	if (_wep != "") then {
		{player addMagazine _x;} forEach (_inventario select 2 select 2);
		player addWeapon _wep;
		{if (_x != "") then {player addSecondaryWeaponItem _x;};} forEach (_inventario select 2 select 1);
	};
	
	//ARMA TERCIARIA
	_wep = _inventario select 3 select 0;
	if (_wep != "") then {
		{player addMagazine _x;} forEach (_inventario select 3 select 2);
		player addWeapon _wep;
		{if (_x != "") then {player addHandGunItem _x;};} forEach (_inventario select 3 select 1);
	};
	
	//REMOVE VEST UTILIZADA PARA RECEBER MAGAZINES DAS ARMAS
	removeBackpack player;

	//PLAYER TERRAINS
	if (count _inventario > 4) then {player setVariable ["owt",_inventario select 4,true];};

	//BACKPACK
	_backpack = _resultadoCompilado select 0 select 1;
	if ((_backpack select 0) select 0 != "") then {
		player addBackpack ((_backpack select 0) select 0);
		_BpObjeto = backpackContainer player;
		clearWeaponCargoGlobal _BpObjeto;
		clearItemCargoglobal _BpObjeto;
		clearMagazineCargoGlobal _BpObjeto;
		{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 0 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 0 select 1 select 0 select 0);
		{_BpObjeto addItemCargoGlobal [_x,_backpack select 0 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 0 select 1 select 1 select 0);
		
		//TEMPORARIO
		_c = _backpack select 0 select 1 select 2;
		_antigo = false;
		if (count _c == 2) then {
			if (count (_c select 1) == 0) then {
				_antigo = true;
			} else {
				if (typeName (_c select 1 select 0) == "SCALAR") then {
					_antigo = true;
				};
			};
		};
		if (!_antigo) then {
			{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 0 select 1 select 2);
		} else {
			{if !(_x in BRPVP_bannedMagazines) then {_BpObjeto addMagazineCargoGlobal [_x,_backpack select 0 select 1 select 2 select 1 select _forEachIndex];};} forEach (_backpack select 0 select 1 select 2 select 0);
		};
	};
	
	//VEST
	if ((_backpack select 1) select 0 != "") then {
		player addVest ((_backpack select 1) select 0);
		_BpObjeto = vestContainer player;
		clearWeaponCargoGlobal _BpObjeto;
		clearItemCargoglobal _BpObjeto;
		clearMagazineCargoGlobal _BpObjeto;
		{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 1 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 1 select 1 select 0 select 0);
		{_BpObjeto addItemCargoGlobal [_x,_backpack select 1 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 1 select 1 select 1 select 0);

		//TEMPORARIO
		_c = _backpack select 1 select 1 select 2;
		_antigo = false;
		if (count _c isEqualTo 2) then {
			if (count (_c select 1) isEqualTo 0) then {
				_antigo = true;
			} else {
				if (typeName (_c select 1 select 0) == "SCALAR") then {
					_antigo = true;
				};
			};
		};
		if (!_antigo) then {
			{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 1 select 1 select 2);
		} else {
			{if !(_x in BRPVP_bannedMagazines) then {_BpObjeto addMagazineCargoGlobal [_x,_backpack select 1 select 1 select 2 select 1 select _forEachIndex];};} forEach (_backpack select 1 select 1 select 2 select 0);
		};
	};
	
	//UNIFORME
	if ((_backpack select 2) select 0 != "") then {
		player forceAddUniform ((_backpack select 2) select 0); //TESTE TESTE TESTE
		_BpObjeto = uniformContainer player;
		clearWeaponCargoGlobal _BpObjeto;
		clearItemCargoglobal _BpObjeto;
		clearMagazineCargoGlobal _BpObjeto;
		{_BpObjeto addWeaponCargoGlobal [_x,_backpack select 2 select 1 select 0 select 1 select _forEachIndex];} forEach (_backpack select 2 select 1 select 0 select 0);
		{_BpObjeto addItemCargoGlobal [_x,_backpack select 2 select 1 select 1 select 1 select _forEachIndex];} forEach (_backpack select 2 select 1 select 1 select 0);

		//TEMPORARIO
		_c = _backpack select 2 select 1 select 2;
		_antigo = false;
		if (count _c isEqualTo 2) then {
			if (count (_c select 1) isEqualTo 0) then {
				_antigo = true;
			} else {
				if (typeName (_c select 1 select 0) == "SCALAR") then {
					_antigo = true;
				};
			};
		};
		if (!_antigo) then {
			{_BpObjeto addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_backpack select 2 select 1 select 2);
		} else {
			{if !(_x in BRPVP_bannedMagazines) then {_BpObjeto addMagazineCargoGlobal [_x,_backpack select 2 select 1 select 2 select 1 select _forEachIndex];};} forEach (_backpack select 2 select 1 select 2 select 0);
		};
	};

	//ARMA NA MAO
	_armaNaMao = _resultadoCompilado select 0 select 5;
	_armaNaMaoNasce = _armaNaMao;

	//POSICAO
	_posicao = _resultadoCompilado select 0 select 2;
	_posS = _posicao select 1;
	player setDir (_posicao select 0);
	waitUntil {time - _init >= 3};

	//SET TO BLIND IF BLIND
	BRPVP_blindPlayersIdClientAskReturn = nil;
	[clientOwner,player getVariable "id_bd"] remoteExecCall ["BRPVP_blindPlayersIdClientAsk",2];
	waitUntil {!isNil "BRPVP_blindPlayersIdClientAskReturn"};
	if (BRPVP_blindPlayersIdClientAskReturn) then {
		private _priority = 1500;
		while {BRPVP_blindHandle = ppEffectCreate ["ColorCorrections",_priority];BRPVP_blindHandle < 0} do {_priority = _priority+1;};
		BRPVP_blindHandle ppEffectEnable true;
		BRPVP_blindHandle ppEffectAdjust [0.05,1,0,[0,0,0,0],[1,1,1,1],[0.299,0.587,0.114,1],[-1,-1,0,0,0,0,0]];
		BRPVP_blindHandle ppEffectCommit 0;
		player setVariable ["brpvp_blind",true,true];
		uiSleep 0.001;
	};

	//SET PLAYER INITIAL POS 1
	call BRPVP_connectSmartTvs;
	player setDir (_posicao select 0);
	player setPosWorld _posS;
	uiSleep 0.001;
	[player,""] remoteExecCall ["switchMove",0];
	[player,player getVariable ["brpvp_invisible",false]] remoteExecCall ["hideObjectGlobal",2];

	//SAUDE
	_saude = _resultadoCompilado select 0 select 3;
	
	//AMIGOS
	_amigos = _resultadoCompilado select 0 select 6;
	player setVariable ["amg",_amigos,true];
	if (isNil "BRPVP_pastFriendsUpdateWithAmg") then {
		BRPVP_pastFriendsUpdateWithAmg = true;
		_pastFriends = player getVariable ["brpvp_past_friends",[]];
		_pastFriends append _amigos;
		_pastFriends = _pastFriends arrayIntersect _pastFriends;
		player setVariable ["brpvp_past_friends",_pastFriends,true];
	};

	//EXPERIENCIA
	_experiencia = _resultadoCompilado select 0 select 7;
	if (count _experiencia isEqualTo 25) then {_experiencia = _experiencia+[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];};
	player setVariable ["exp",_experiencia,true];

	//REVELA AO PLAYER OBJETOS POR PERTO
	{player reveal _x;} forEach (player nearObjects 35);

	//DAMAGE
	player setDamage ((_saude select 2) min 0.85);
	player allowDamage true;
	{player setHitIndex [_forEachIndex,_x min 0.85,false];} forEach (_saude select 0 select 1);
	player allowDamage false;
	BRPVP_alimentacao = _saude select 1 select 0;
	player setVariable ["sud",[round BRPVP_alimentacao,100],true];

	//LOGA INFORMACOES DO PLAYER
	diag_log "--------------------------------------------------------------------------------------------";
	diag_log "---- [SPAWN: PLAYER ON DB AND ALIVE]";
	diag_log ("---- model = " + str _modelo);
	diag_log ("---- gear = " + str _inventario);
	diag_log ("---- backpack = " + str _backpack);
	diag_log ("---- health = " + str _saude);
	diag_log ("---- weapon in hand = " + str _armaNaMao);
	diag_log ("---- trust = " + str _amigos);
	diag_log ("---- experience = " + str _experiencia);
	diag_log "--------------------------------------------------------------------------------------------";

	//MENSAGEM ABOUT PLAYER MENU
	cutText ["","PLAIN",1];
	[localize "str_player_menu",5] call BRPVP_hint;

	//LIGA MODO ADMIN CASO SEJA UM ADMIN
	if (BRPVP_isAdminOrModerator) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};
	"tema" call BRPVP_playSound;

	//ADD HEAD ITEMS IF HAVE IT
	BRPVP_playerHeadItemsServerReturn = nil;
	[_id_bd,clientOwner] remoteExecCall ["BRPVP_playerHeadItemsServerGet",2];
	waitUntil {!isNil "BRPVP_playerHeadItemsServerReturn"};
	if (BRPVP_playerHeadItemsServerReturn isNotEqualto [3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]]) then {
		private _wh = createVehicle ["GroundWeaponHolder",BRPVP_posicaoFora,[],100,"CAN_COLLIDE"];
		[_wh,BRPVP_playerHeadItemsServerReturn] call BRPVP_putItemsOnCargo;
		private _onVeh = !isNull objectParent player;
		_wh call BRPVP_boxOnHeadKeyPress;
	};
};

//PARA NOVAS VIDAS, COLOCA PLAYER CAINDO DE PARAQUEDAS
if (BRPVP_checaExistenciaPlayerBdRetorno in ["nao_ta_no_bd","no_bd_e_morto"]) then {
	openMap [true,false];
	private ["_id_bd"];
	
	//ALGUMAS VARIAVEIS
	_experiencia = +BRPVP_experienciaZerada;
	_amigos = [];
	_wep4 = [];
	
	//EXECUTA SE O PLAYER JA ESTA NO BANCO DE DADOS MAS ESTA MORTO
	_clone = "";
	if (BRPVP_checaExistenciaPlayerBdRetorno isEqualTo "no_bd_e_morto") then {
		BRPVP_pegaValoresContinuaRetorno = nil;
		[player,player getVariable "id"] remoteExecCall ["BRPVP_pegaValoresContinua",2];
		waitUntil {!isNil "BRPVP_pegaValoresContinuaRetorno"};
		_resultadoCompilado = parseSimpleArray BRPVP_pegaValoresContinuaRetorno;
		_resultadoCompilado = _resultadoCompilado select 1;
		_amigos = _resultadoCompilado select 0 select 0;
		_experiencia = _resultadoCompilado select 0 select 1;
		if (count _experiencia isEqualTo 25) then {_experiencia = _experiencia+[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];};
		_id_bd = _resultadoCompilado select 0 select 2;
		player setVariable ["stp",_resultadoCompilado select 0 select 3,true];
		player setVariable ["sit",(_resultadoCompilado select 0 select 5) call BRPVP_sitConvert,true];
		player setVariable ["brpvp_mny_bank",_resultadoCompilado select 0 select 6,true];
		player setVariable ["brpvp_hh_balance",_resultadoCompilado select 0 select 7,true];
		player setVariable ["brpvp_head_price",_resultadoCompilado select 0 select 8,true];
		player setVariable ["brpvp_rc_uses",_resultadoCompilado select 0 select 9,true];
		player setVariable ["mny",0,true];
		_clone = _resultadoCompilado select 0 select 13;
		_clone = if (_clone call BRPVP_classExists || _clone in BRPVP_cloneCustomNames) then {_clone} else {""};
		player setVariable ["brpvp_my_clone",_clone,true];
		
		_activePerks = _resultadoCompilado select 0 select 14;
		player setVariable ["brpvp_active_perks",_activePerks,true];
		
		_vaults = _resultadoCompilado select 0 select 11;
		if (_vaults isEqualTo -1) then {BRPVP_vaultNumber = BRPVP_vaultNumberCfg;} else {BRPVP_vaultNumber = _vaults;};
		player setVariable ["brpvp_vaults",[_vaults,BRPVP_vaultNumber],true];

		_vgMult = _resultadoCompilado select 0 select 12;
		player setVariable ["brpvp_vg_mult",_vgMult,true];

		diag_log "--------------------------------------------------------------------------------------------";
		diag_log "---- [SPAWN: PLAYER ON DB AND DEAD]";
		diag_log ("---- VALUES TO MANTAIN: " + str _resultadoCompilado + ".");
		diag_log "--------------------------------------------------------------------------------------------";

		//PLAYER CONFIG
		_config = _resultadoCompilado select 0 select 10;
		player setVariable ["brpvp_player_config",_config,[clientOwner,2]];
		_config call BRPVP_applyPlayerConfig;

		//SET AS PVE BANDIT IF IN LIST
		if (_id_bd in BRPVP_pveBanditObjListId) then {
			BRPVP_pveBanditObjList = BRPVP_pveBanditObjList apply {if (isNull _x || _x getVariable ["dd",-1] > 0) then {-1} else {_x};};
			BRPVP_pveBanditObjList = BRPVP_pveBanditObjList-[-1];
			BRPVP_pveBanditObjList pushBack player;
			publicVariable "BRPVP_pveBanditObjList";
			["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\bandit.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.36},1000000,0,0,3098] call BRPVP_fnc_dynamicText;
			player setVariable ["brpvp_no_veh_time",serverTime];
		};
		
		//BORN WITH ITEMS YOU DIED
		if (BRPVP_bornWithDeadItemsThisRound) then {
			BRPVP_myBodyDeadItems params ["_ulw","_w4","_uli"];
			_uli set [0,_ulw select 0];
			_uli set [1,_ulw select 1];
			_wep4 = _w4;
			player setUnitLoadout _uli;
		};		
	};
	
	//EXECUTA SE E A PRIMEIRA VEZ DO PLAYER
	if (BRPVP_checaExistenciaPlayerBdRetorno isEqualTo "nao_ta_no_bd") then {
		BRPVP_incluiPlayerNoBdRetorno = nil;
		call BRPVP_incluiPlayerBd;
		diag_log "--------------------------------------------------------------------------------------------";
		diag_log "---- [SPAWN: PLAYER NOT IN DB]";
		diag_log ("---- CREATING PLAYER ON DB");
		diag_log "--------------------------------------------------------------------------------------------";
		waitUntil {!isNil "BRPVP_incluiPlayerNoBdRetorno"};
		_id_bd = BRPVP_incluiPlayerNoBdRetorno;
		player setVariable ["mny",BRPVP_startingMoney,true];
		player setVariable ["brpvp_mny_bank",BRPVP_startingMoneyOnBank,true];
		player setVariable ["sit",[],true];
		player setVariable ["stp",1,true];
		player setVariable ["brpvp_hh_balance",0,true];
		player setVariable ["brpvp_head_price",0,true];
		player setVariable ["brpvp_rc_uses",0,true];
		player setVariable ["brpvp_my_clone","",true];
		player setVariable ["brpvp_active_perks",[],true];

		BRPVP_vaultNumber = BRPVP_vaultNumberCfg;
		player setVariable ["brpvp_vaults",[-1,BRPVP_vaultNumber],true];

		player setVariable ["brpvp_vg_mult",1,true];

		//PLAYER CONFIG
		_config = [0,0,0,0,0,0,0,0];
		player setVariable ["brpvp_player_config",_config,[clientOwner,2]];
		_config call BRPVP_applyPlayerConfig;

		//ADD RANDOM ALT+I ITEMS
		for "_i" from 1 to BRPVP_foodPlayerStart do {[selectRandom BRPVP_foodClassArray,1] call BRPVP_sitAddItem;};
		private _specialItemsPlayerStart = ["BRP_boxThief","BRP_vehicleThief","BRP_doorThief","BRP_hackTool","BRP_identifier","BRP_remoteControl","BRP_zombieSpawn","Mag_BRPVP_z_blood_bag","Mag_BRPVP_scanner_200","Mag_BRPVP_fuel_gallon","Mag_BRPVP_veh_ownerity","BRPVP_hulk_pills","BRPVP_drone_finder","BRPVP_baseBomb","BRPVP_personalTracer","BRPVP_houseGodMode","BRPVP_antiBaseBomb","BRPVP_turnInBandit","BRPVP_baseTest","BRPVP_noGrass","BRPVP_itemPaintVehicle","BRPVP_itemClimb","BRPVP_playerLaunch","BRPVP_baseMine","BRPVP_baseMineDefuse","BRPVP_vehicleAmmo","BRPVP_turretUpgrade","BRPVP_xrayItem","BRPVP_itemMagnet","BRPVP_newsPaper","BRPVP_uberPack","BRPVP_atmFix","BRPVP_boxeItem","BRPVP_selfRevive","BRPVP_bodyChange","BRPVP_vehicleTorque","BRPVP_possession","BRPVP_possessionStrong","BRPVP_possessionPlayer","BRPVP_uberAttack","BRPVP_secCam","BRPVP_trench","BRPVP_baseBoxUpgrade"];
		for "_i" from 1 to BRPVP_randomSpecialItemsPlayerStart do {[selectRandom _specialItemsPlayerStart,1] call BRPVP_sitAddItem;};
		private _constructionItems = ["BRP_kitLight","BRP_kitCamuflagem","BRP_kitAreia","BRP_kitCidade","BRP_kitStone","BRP_kitCasebres","BRP_kitConcreto","BRP_kitPedras","BRP_kitTorres","BRP_kitEspecial","BRP_kitTableChair","BRP_kitBeach","BRP_kitReligious","BRP_kitStuffo1","BRP_kitStuffo2","BRP_kitLamp","BRP_kitRecreation","BRP_kitMilitarSign","BRP_kitFuelStorage","BRP_kitWrecks","BRP_kitSmallHouse","BRP_kitAverageHouse","BRP_kitAntennaA","BRP_kitAntennaB","BRP_kitMovement","BRP_kitRespawnA","BRP_kitRespawnB","BRP_kitHelipad","BRP_kitAutoTurret","BRP_kitFlags25","BRP_kitFlags50","BRP_kitFlags100","BRP_kitFlags200","BRP_kitBigHouse","BRP_kitGiantHouse","BRP_kitContainers","BRP_kitTrees","BRP_kitGates","BRP_kitSmallLights","BRP_kitBunkers","BRP_kitAutoTurretLvl2"];
		for "_i" from 1 to BRPVP_randomConstructionItemsPlayerStart do {[selectRandom _constructionItems,1] call BRPVP_sitAddItem;};
		private _farmCraftItems = ["BRPVP_equip_axe","BRPVP_equip_shovel","BRPVP_equip_cutter","BRPVP_equip_pickaxe","BRPVP_farm_limestone","BRPVP_farm_clay","BRPVP_farm_coal","BRPVP_farm_stone","BRPVP_farm_iron","BRPVP_farm_leaves","BRPVP_farm_cotton","BRPVP_farm_wood","BRPVP_farm_latex","BRPVP_farm_sand","BRPVP_farm_metal_trash","BRPVP_farm_eletronic_trash","BRPVP_craft_cement","BRPVP_craft_brick","BRPVP_craft_circuits","BRPVP_craft_steel_plate","BRPVP_craft_steel_rebar","BRPVP_craft_wooden_board","BRPVP_craft_reinforced_concrete","BRPVP_craft_fabric","BRPVP_craft_wooden_wall","BRPVP_craft_brick_wall","BRPVP_craft_steel_wall","BRPVP_craft_stone_x10","BRPVP_craft_rubber","BRPVP_craft_foundations","BRPVP_craft_steel_structure","BRPVP_material_seam_kit","BRPVP_material_bolt_nail"];
		for "_i" from 1 to BRPVP_randomFarmCraftItemsPlayerStart do {[selectRandom _farmCraftItems,1] call BRPVP_sitAddItem;};

		if (BRPVP_showTutorialFlag) then {true call BRPVP_showTutorial;};
	};

	//PLAYER WEAPON 4
	player setVariable ["brpvp_weapon_4",_wep4,true];

	//ID DO BANCO DE DADOS
	player setVariable ["id_bd",_id_bd,true];

	[_id_bd,player getVariable "nm"] remoteExecCall ["BRPVP_salvaNomePeloIdBd",2];

	//ALIMENTACAO E HIDRATACAO
	BRPVP_alimentacao = 100;
	player setVariable ["sud",[round BRPVP_alimentacao,100],true];
	
	//EXPERIENCIA
	player setVariable ["exp",_experiencia,true];

	//AMIGOS
	player setVariable ["amg",_amigos,true];
	if (isNil "BRPVP_pastFriendsUpdateWithAmg") then {
		BRPVP_pastFriendsUpdateWithAmg = true;
		_pastFriends = player getVariable ["brpvp_past_friends",[]];
		_pastFriends append _amigos;
		_pastFriends = _pastFriends arrayIntersect _pastFriends;
		player setVariable ["brpvp_past_friends",_pastFriends,true];
	};

	_tipSom = ASLToAGL [0,0,0] nearestObject "#soundonvehicle";

	//SET BASE RESPAWN TIMES
	BRPVP_thisLifeBaseSpawns = call BRPVP_findMySpawns;
	if (isNull _lastCorpseSearched) then {
		{_x setVariable ["brpvp_spawn_time",-BRPVP_baseRespawnDelay];} forEach BRPVP_thisLifeBaseSpawns;
	} else {
		{
			if (_x distance2D _lastCorpseSearched < 200) then {
				_x setVariable ["brpvp_spawn_time",_ultimo];
			} else {
				_x setVariable ["brpvp_spawn_time",-BRPVP_baseRespawnDelay];
			};
		} forEach BRPVP_thisLifeBaseSpawns;
	};

	//PUT CLONE GEAR ON PLAYER
	if (!BRPVP_bornWithDeadItemsThisRound) then {
		if (_clone isEqualTo "") then {
			//ESCOLHE VESTIMENTA DO PLAYER
			true call BRPVP_escolheModaPlayer;
		} else {
			private _idx = BRPVP_cloneCustomNames find _clone;
			if (_idx isEqualTo -1) then {player setUnitLoadout getUnitLoadout _clone;} else {player setUnitLoadout (BRPVP_cloneCustomData select _idx);};
		};
	};

	if ((BRPVP_useRandomRespawnWhenSuicide && _id_bd in BRPVP_randomSpawnPlayers) || BRPVP_useRandomRespawnAllways) then {
		private ["_randPos"];
		cutText [localize "str_spawn_random_ground","BLACK FADED",10];
		_init = time;
		
		//GET RANDOM RESPAWN SET
		BRPVP_randomRespawnSaveGetReturn = nil;
		[player,player getVariable ["id_bd",-1]] remoteExecCall ["BRPVP_randomRespawnSaveGet",2];
		waitUntil {!isNil "BRPVP_randomRespawnSaveGetReturn"};

		BRPVP_randomRespawnPlaces = if (BRPVP_wasBotKill) then {+BRPVP_randomRespawnSaveGetReturn select 1} else {+BRPVP_randomRespawnSaveGetReturn select 0};
		BRPVP_randomRespawnPlacesShow = true;
		sleep (3-(time-_init));
		player linkItem "ItemMap";
		cutText ["","PLAIN"];
		BRPVP_onMapSingleClick = BRPVP_randomBornClick;
		BRPVP_posicaoDeNascimento = nil;
		openMap true;
		waitUntil {openMap true;visibleMap};
		mapAnimAdd [0,0.65,BRPVP_centroMapa];
		mapAnimCommit;
		[localize "str_select_random_place",6,20] call BRPVP_hint;
		waitUntil {
			if (!visibleMap) then {cutText [localize "str_select_random_place","BLACK FADED"];} else {cutText ["","PLAIN"];};
			!isNil "BRPVP_posicaoDeNascimento"
		};
		BRPVP_randomRespawnPlaces = [];
		BRPVP_randomRespawnPlacesShow = false;
		BRPVP_randomSpawnPlayers = BRPVP_randomSpawnPlayers-[_id_bd];
		publicVariable "BRPVP_randomSpawnPlayers";
		
		//RECORD NEXT RANDOM RESPAWN SET
		0 spawn {
			_places = [];
			_count = 0;
			while {count _places < BRPVP_useRandomRespawnPlacesToChoose} do {
				_ok = false;
				_mult = (1-0.1*floor (_count/50)) max 0;
				_randPos = BRPVP_randomRespawnSquare apply {(_x select 0)+random ((_x select 1)-(_x select 0))};
				_randPos pushBack 0;
				if (!surfaceIsWater _randPos) then {
					_nearFlag = count (_randPos nearObjects ["FlagCarrier",200+150*_mult]) > 0;
					_nearMan = count (_randPos nearEntities ["CAManBase",200*_mult]) > 0;
					_nearOther = {_randPos distance2D _x < BRPVP_useRandomRespawnPlacesDistance*_mult} count _places > 0;
					if !(_nearFlag || _nearMan || _nearOther) then {
						_best = _randPos findEmptyPosition [0,35,BRPVP_playerModel];
						if !(_best isEqualTo []) then {
							_lis = lineIntersectsSurfaces [AGLToASL _best vectorAdd [0,0,0.25],AGLToASL _best vectorAdd [0,0,10]];
							if (_lis isEqualTo []) then {
								_ok = true;
								_count = 0;
								_places pushBack _best;
							};
						};
					};
				};
				if (!_ok) then {_count = _count+1;};
			};
			_placesBK = [];
			_count = 0;
			while {count _placesBK < BRPVP_useRandomRespawnPlacesToChooseBotKill} do {
				_ok = false;
				_mult = (1-0.1*floor (_count/50)) max 0;
				_randPos = BRPVP_randomRespawnSquare apply {(_x select 0)+random ((_x select 1)-(_x select 0))};
				_randPos pushBack 0;
				if (!surfaceIsWater _randPos) then {
					_nearFlag = count (_randPos nearObjects ["FlagCarrier",200+150*_mult]) > 0;
					_nearMan = count (_randPos nearEntities ["CAManBase",200*_mult]) > 0;
					_nearOther = {_randPos distance2D _x < BRPVP_useRandomRespawnPlacesDistanceBotKill*_mult} count _placesBK > 0;
					if !(_nearFlag || _nearMan || _nearOther) then {
						_best = _randPos findEmptyPosition [0,35,BRPVP_playerModel];
						if !(_best isEqualTo []) then {
							_lis = lineIntersectsSurfaces [AGLToASL _best vectorAdd [0,0,0.25],AGLToASL _best vectorAdd [0,0,10]];
							if (_lis isEqualTo []) then {
								_ok = true;
								_count = 0;
								_placesBK pushBack _best;
							};
						};
					};
				};
				if (!_ok) then {_count = _count+1;};
			};
			[player getVariable ["id_bd",-1],_places,_placesBK] remoteExecCall ["BRPVP_randomRespawnSaveRecord",2];
		};
	} else {
		//ESCOLHE LOCAL DE SPAWN PARTE 1
		cutText [localize "str_spawn_generating","BLACK FADED",10];
		sleep 3;
		[localize "str_select_spawn",10] call BRPVP_hint;
		
		//ESCOLHE LOCAL DE SPAWN PARTE 2
		BRPVP_posicaoDeNascimento = nil;
		BRPVP_onMapSingleClick = BRPVP_nascMapaClique;
		BRPVP_temposLocais = [];
		_paramDist = BRPVP_distanceToRespawnWaitZero;
		_paramTime = BRPVP_afterDieMaxSpawnCounterInSeconds;
		if (BRPVP_lastKillIsPlayer) then {
			_paramDist = BRPVP_distanceToRespawnWaitZeroIfPlayerKill;
			_paramTime = BRPVP_afterDieMaxSpawnCounterInSecondsIfPlayerKill;
		};
		{
			_cnt = _x select 0;
			_raio = _x select 1;
			_distMin = 1000000;
			{
				if (!isNull _x) then {
					_deadTime = _syncTimeNow-(_x getVariable "hrm");
					_oldBodyFactor = (_deadTime min 300)/600;
					_dist = _x distance2D _cnt;
					_distMin = _distMin min (_dist+_oldBodyFactor*_paramDist);
				};
			} forEach BRPVP_meuAllDead;
			_inPVPArea = false;
			{if (_cnt distance (_x select 0) <= _x select 1) exitWith {_inPVPArea = true;};} forEach (BRPVP_PVPAreas+BRPVP_fastSpawnPlacesFugitive);
			_calcDist = if (_inPVPArea) then {(_paramDist-20*_paramDist/_paramTime) max 0} else {_distMin};
			_wait = (1-(_calcDist min _paramDist)/_paramDist)*((_paramTime-_tempofora) max 0);
			BRPVP_temposLocais pushBack [_cnt,round (time+_wait),round _wait];
		} forEach BRPVP_respawnPlaces;
		diag_log ("[BRPVP time away] = "+str _tempofora+".");

		_ini = -2;
		_ini2 = -40;
		_lang = localize "str_language_using";
		player linkItem "ItemMap";
		cutText ["","PLAIN"];
		openMap true;
		waitUntil {openMap true;visibleMap};
		mapAnimAdd [0,0.65,BRPVP_centroMapa];
		mapAnimCommit;
		waitUntil {
			if (!visibleMap) then {cutText [localize "str_spawn_closed_map_msg","BLACK FADED"];} else {cutText ["","PLAIN"];};
			if (time-_ini >= 1) then {
				_ini = time;
				{_x set [2,((_x select 2)-1) max -1];} forEach BRPVP_temposLocais;
			};
			if (time-_ini2 > 35) then {
				_ini2 = time;
				if (_lang isEqualTo "Chinesesimp") then {"chinese_click_orange" call BRPVP_playSound;};
				if (_lang isEqualTo "russian") then {"russian_click_orange" call BRPVP_playSound;};
				if (_lang isEqualTo "portuguese") then {"portuguese_click_orange" call BRPVP_playSound;};
				if (_lang isEqualTo "english") then {"english_click_orange" call BRPVP_playSound;};
			};
			!isNil "BRPVP_posicaoDeNascimento"
		};
		BRPVP_temposLocais = [];
	};
	//deleteVehicle _tipSom;
	
	//CRIA VAR COM POSICAO DE NASCIMENTO ESCOLHIDA
	_posType = BRPVP_posicaoDeNascimento select 0;
	
	if (_posType isEqualTo "air") then {
		_posNasc = BRPVP_posicaoDeNascimento select 1;
		_posNasc = [(_posNasc select 0)-100+random 200,(_posNasc select 1)-100+random 200,1100];

		//INICIA SALTO DE PARAQUEDAS
		BRPVP_onMapSingleClick = BRPVP_padMapaClique;
		call BRPVP_connectSmartTvs;
		BRPVP_allowSecondJump = false;
		isNil {
			player action ["SwitchWeapon",player,player,100];
			player playMoveNow "halofreefall_non";
			player setPos _posNasc;
		};
		//sleep 0.001;
		//[player,"halofreefall_non"] remoteExecCall ["switchMove",0];
		[player,player getVariable ["brpvp_invisible",false]] remoteExecCall ["hideObjectGlobal",2];

		_pd = player getVariable ["pd",BRPVP_centroMapa];
		player setDir ([player,_pd] call BIS_fnc_dirTo);
		openMap false;
		[localize "str_spawn_tips",10] call BRPVP_hint;
		
		//INICIA VIDA
		if (isNil "BRPVP_jaNasceuUma") then {BRPVP_jaNasceuUma = true;};
		
		//LIGA MODO ADMIN CASO SEJA UM ADMIN
		if (BRPVP_isAdminOrModerator) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};

		//MONITORA QUEDA E SPAWNA QUADRICICLO
		[player,_clone] spawn {
			params ["_player","_clone"];

			//PUT ITEMS ON PLAYER
			if (!BRPVP_bornWithDeadItemsThisRound) then {
				if (_clone isEqualTo "") then {
					if (BRPVP_bornWithItems) then {
						_player addBackpack selectRandom ["B_AssaultPack_blk","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_dgtl"];
						_player addVest "V_Press_F";
						_aP = selectRandom ["hgun_Pistol_heavy_01_F"];
						_mP = selectRandom getArray (configFile >> "CfgWeapons" >> _aP >> "magazines");
						_player addMagazine _mP;
						_player addMagazine _mP;
						_player addMagazine _mP;
						_player addMagazine _mP;
						_player addMagazine _mP;
						_player addWeapon _aP;
						_player linkItem "NVGoggles";
						_player addWeapon "Binocular";
						_player addItem "FirstAidKit";
					};
				} else {
					if (BRPVP_bornWithItems) then {if (hmd _player isEqualTo "") then {_player linkItem "NVGoggles";};};
				};
			};

			//ESPERA CHEGAR NO CHAO OU MORRER NA QUEDA
			waitUntil {getPos _player select 2 < 1 || !(_player call BRPVP_pAlive)};
			if (!isNull objectParent _player) then {moveOut _player;};
			waitUntil {getPos _player select 2 < 0.2};
			if (_player isEqualTo player) then {cutText ["","PLAIN"];};

			//SPAWNA QUADRICICLO
			if (_player call BRPVP_pAlive) then {
				private _pos = getPosATL _player;
				_pos set [0,(_pos select 0) + 2 + (random 5)];
				_pos set [1,(_pos select 1) + 2 + (random 5)];
				_pos set [2,0];
				private _best = _pos findEmptyPosition [0,35,BRPVP_veiculoTemporarioNascimento];
				if (_best isNotEqualTo []) then {
					private _bicicleta = createVehicle [BRPVP_veiculoTemporarioNascimento,_best,[],0,"CAN_COLLIDE"];
					_bicicleta remoteExecCall ["BRPVP_veiculoEhReset",2];
					clearWeaponCargoGlobal _bicicleta;
					clearMagazineCargoGlobal _bicicleta;
					clearITemCargoGlobal _bicicleta;
					clearBackpackCargoGlobal _bicicleta;
					_player setVariable ["qdcl",_bicicleta];
					_bicicleta setVariable ["tmp",0,true];
					[format [localize "str_quad_time",BRPVP_tempoDeVeiculoTemporarioNascimento],5] call BRPVP_hint;
				};
				[localize "str_player_menu",5] call BRPVP_hint;
				
			};
			BRPVP_allowSecondJump = true;
		};
		if (BRPVP_bornFearSoundRunTimes > 0) then {
			BRPVP_bornFearSoundRunTimes = BRPVP_bornFearSoundRunTimes-1;
			selectRandom ["intro_parachute_1","intro_parachute_2"] call BRPVP_playSound;
		};
	};
	if (_posType isEqualTo "ground") then {
		_posNasc = BRPVP_posicaoDeNascimento select 1;
		BRPVP_onMapSingleClick = BRPVP_padMapaClique;
		
		//SET PLAYER INITIAL POS 3
		call BRPVP_connectSmartTvs;
		player setPosASL AGLToASL _posNasc;
		sleep 0.001;
		[player,""] remoteExecCall ["switchMove",0];
		[player,player getVariable ["brpvp_invisible",false]] remoteExecCall ["hideObjectGlobal",2];
		
		_pd = player getVariable ["pd",BRPVP_centroMapa];
		player setDir ([player,_pd] call BIS_fnc_dirTo);
		openMap false;
		
		//INICIA VIDA
		if (isNil "BRPVP_jaNasceuUma") then {BRPVP_jaNasceuUma = true;};
		
		//LIGA MODO ADMIN CASO SEJA UM ADMIN
		if (BRPVP_isAdminOrModerator) then {BRPVP_onMapSingleClick = BRPVP_adminMapaClique;} else {BRPVP_onMapSingleClick = BRPVP_padMapaClique;};
		
		//ADD INITIAL LOOT
		if (!BRPVP_bornWithDeadItemsThisRound) then {
			if (_clone isEqualTo "") then {
				if (BRPVP_bornWithItems) then {
					player addBackpack selectRandom ["B_AssaultPack_blk","B_AssaultPack_khk","B_AssaultPack_rgr","B_AssaultPack_sgg","B_AssaultPack_dgtl"];
					player addVest "V_Press_F";
					_aP = selectRandom ["hgun_Pistol_heavy_01_F"];
					_mP = selectRandom getArray (configFile >> "CfgWeapons" >> _aP >> "magazines");
					player addMagazine _mP;
					player addMagazine _mP;
					player addMagazine _mP;
					player addMagazine _mP;
					player addMagazine _mP;
					player addWeapon _aP;
					player linkItem "NVGoggles";
					player addWeapon "Binocular";
					player addItem "FirstAidKit";
				};
			} else {
				if (BRPVP_bornWithItems) then {if (hmd player isEqualTo "") then {player linkItem "NVGoggles";};};
			};
		};

		//SPAWN QUADBIKE
		_onBase = ({player distance2D _x <= _x call BRPVP_getFlagRadius} count nearestObjects [_posNasc,["FlagCarrier"],200,true]) > 0;
		if (!_onBase) then {
			private _pos = getPosATL player;
			_pos set [0,(_pos select 0) + 2 + (random 5)];
			_pos set [1,(_pos select 1) + 2 + (random 5)];
			_pos set [2,0];
			private _best = _pos findEmptyPosition [0,35,BRPVP_veiculoTemporarioNascimento];
			if (_best isNotEqualTo []) then {
				private _bicicleta = createVehicle [BRPVP_veiculoTemporarioNascimento,_best,[],0,"CAN_COLLIDE"];
				_bicicleta remoteExecCall ["BRPVP_veiculoEhReset",2];
				clearWeaponCargoGlobal _bicicleta;
				clearMagazineCargoGlobal _bicicleta;
				clearITemCargoGlobal _bicicleta;
				clearBackpackCargoGlobal _bicicleta;
				player setVariable ["qdcl",_bicicleta];
				_bicicleta setVariable ["tmp",0,true];
				[format [localize "str_quad_time",BRPVP_tempoDeVeiculoTemporarioNascimento],5] call BRPVP_hint;
			};
			[localize "str_player_menu",5] call BRPVP_hint;
		};
		"tema" call BRPVP_playSound;
	};
};

//FAZ PLAYER SEGURAR A ARMA CORRETA
if (isNull objectParent player && isTouchingGround player) then {
	if (_armaNaMaoNasce isEqualTo "not_found") then {
		if (primaryWeapon player isNotEqualTo "") then {
			player selectWeapon primaryWeapon player;
		} else {
			if (handgunWeapon player isNotEqualTo "") then {
				player selectWeapon handgunWeapon player;
			} else {
				player action ["SwitchWeapon",player,player,100];
			};
		};
	} else {
		if (_armaNaMaoNasce isEqualTo "") then {
			player action ["SwitchWeapon",player,player,100];
		} else {
			player selectWeapon _armaNaMaoNasce;
		};
	};
};

player setVariable ["dd",-1,true];
BRPVP_aliveStartTime = diag_tickTime;

BRPVP_atualizaDebugPlayerIcon = selectRandom BRPVP_playersFaces;
player setVariable ["brpvp_player_count_icon",BRPVP_atualizaDebugPlayerIcon,true];

//CALC INITIAL PERKS
if (isNil "BRPVP_xpFirstRunOk") then {
	BRPVP_getMyXpTastingHistoricReturn = nil;
	[clientOwner,player getVariable "id_bd",BRPVP_tastingAbilitiesRenewDays] remoteExecCall ["BRPVP_getMyXpTastingHistoric",2];
	waitUntil {!isNil "BRPVP_getMyXpTastingHistoricReturn"};
	BRPVP_tastingAbilitiesDenied = BRPVP_getMyXpTastingHistoricReturn apply {_x select 0};
	{if !(_x select 7 select 0) then {BRPVP_tastingAbilitiesDenied pushBackUnique (_x select 4)};} forEach BRPVP_xpPerks;

	call BRPVP_xpSetPerksOnStart;
	if (player getVariable ["brpvp_max_in_bank",-1] isEqualTo -1) then {player setVariable ["brpvp_max_in_bank",BRPVP_totalMoneyInBank,true];};
	BRPVP_xpFirstRunOk = true;
} else {
	BRPVP_auraConfig call BRPVP_auraCreateLights;
};

//FIX AMG IF NEEDED
if (!BRPVP_achaMeuStuffRodou) then {
	BRPVP_achaMeuStuffRodou = true;
	["BRPVP_fixAmgIfNeeded",BRPVP_fixAmgIfNeeded] call BRPVP_execFast;

	//FIX TURRET ARRAY ON ALL MACHINES IF NEEDED
	private _id = player getVariable "id_bd";
	private _amg = player getVariable ["amg",[]];
	private _tIds = [];
	{if (_x select 4 isEqualTo _id && {_x select 6 select 0 isNotEqualTo _amg}) then {_tIds pushBack (_x select 3);};} forEach BRPVP_allTurretsInfo;
	if (_tIds isNotEqualTo []) then {[_tIds,_amg] remoteExecCall ["BRPVP_turretsAddRemoveFriendFix",0];};
};

//RESET ZOMBIE DEATH VAR
player setVariable ["brpvp_zombie_kill",false];

//SET PLAYER AS OWNER OF HINSELF
player setVariable ["own",player getVariable "id_bd",true];

//LIGA DEBUG
call BRPVP_atualizaDebug;

//CALC FLAGS
call BRPVP_findMyFlags;

//RESET RYAN ZOMBIES TIMER
BRPVP_rZedsCfgLastSpawnTime = diag_tickTime;

//SPAWN OK
player setVariable ["sok",true,true];
call BRPVP_atualizaDebug;

//UPDATE AMIGOS
true remoteExecCall ["BRPVP_PUSV",0];

//UNBLOCK KEYBOARD
BRPVP_keyBlocked = false;

BRPVP_disabledDamage = 0;
setPlayerRespawnTime 1000;

player enableStamina false;

//PLAYER TRAITS
player setUnitTrait ["engineer",false];
player setUnitTrait ["explosiveSpecialist",true];
player setUnitTrait ["medic",true];
player setUnitTrait ["UAVHacker",true];

//TURN OFF PLAYER GOD MODE
player allowDamage true;
player setCaptive false;

//PLAYER RATING
//player addRating (-10000-rating player);

//REDUCE SWAY
player setCustomAimCoef 0.2;

//FEDIDEX MENU
BRPVP_actionFedidex = player addAction ["<t color='#AAAAFF'>Fedidex Express</t>",{49 call BRPVP_iniciaMenuExtra;},"",1.5,false,true,"","isNull objectParent player"];

//SET AVERAGE HEALTH
BRPVP_averageDamage = getAllHitPointsDamage player;
{if (_x > 0.8) then {BRPVP_averageDamage select 2 set [_forEachIndex,0.8];};} forEach (BRPVP_averageDamage select 2);
BRPVP_averageDamageGeneral = damage player;

//RECORD USED NAME
if (isNil "BRPVP_recordedNameOk") then {
	BRPVP_recordedNameOk = true;
	[player getVariable "id_bd",player getVariable "nm"] remoteExecCall ["BRPVP_recordUsedName",2];
};

//IS NEWER PLAYER
_okKills = (player getVariable "exp") select 0 < BRPVP_newerKillsToLeave;
_okPlayDays = player getVariable ["brpvp_days_played",1] < BRPVP_newerDaysPlayedToLeave;
_okXP = BRPVP_xpLastTotal <= BRPVP_newerXPToLeave;
if (_okKills && _okPlayDays && _okXP) then {player setVariable ["brpvp_is_newer",true,true];};

//CLOSE CVL DOORS YOU HAVE NOT ACCESS
call BRPVP_checkAllCVLDoors;

//WATERMARK ON
["<img align='left' size='1.5' shadow='0' image='"+BRPVP_imagePrefixNoMod+"watermark.paa' />",{safeZoneX+0.020},{safeZoneY+0.025},1000000,0,0,3090] call BRPVP_fnc_dynamicText;

call BRPVP_baseBombCalcVisibleLinesFar;
call BRPVP_baseBombCalcVisibleLinesSemiFar;
call BRPVP_baseBombCalcVisibleLines;

//SPECIAL CLIMB ACTION
if (BRPVP_specialClimbOn) then {
	if (BRPVP_pathClimbAction isNotEqualTo -1) then {player removeAction BRPVP_pathClimbAction;};
	BRPVP_pathClimbAction = player addAction ["<t color='#FF6000'>"+localize "str_special_climb_action"+"</t>",{call BRPVP_pathClimbActionCode;},objNull,2,false,true,"","!BRPVP_pathClimbTrying && !BRPVP_pathClimbOn && isNull objectParent _originalTarget"];
};

if (BRPVP_infantryDay) then {
	0 spawn {
		waitUntil {getPos player select 2 < 0.25 || !(player call BRPVP_pAlive)};
		if (player call BRPVP_pAlive) then {
			"march" call BRPVP_playSound;
			["<img size='5' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\infantry_day.paa' /><br /><t>"+localize "str_infantry_day"+"</t>",0,0,4,0.25,0,56472] call BRPVP_fnc_dynamicText;
		};
	};
};

if !(getPlayerUID player in BRPVP_openingPlayers) then {
	BRPVP_openingPlayers pushBack getPlayerUID player;
	publicVariable "BRPVP_openingPlayers";
	0 spawn {
		"opening" call BRPVP_playSound;
		
		//INIT
		(findDisplay 46) ctrlCreate ["RscStructuredText",7219832];
		(findDisplay 46 displayCtrl 7219832) ctrlSetPosition [safeZoneX,safeZoneY+safeZoneH-0.45,0.6,0.45];
		(findDisplay 46 displayCtrl 7219832) ctrlSetBackgroundColor [1,1,1,0];
		(findDisplay 46 displayCtrl 7219832) ctrlSetStructuredText parseText ("<t shadow='0' align='center'><img shadow='0' size='8.5' image='"+BRPVP_imagePrefix+"BRP_imagens\opening\brpvp_opening_init.paa'/></t>");
		(findDisplay 46 displayCtrl 7219832) ctrlCommit 0;
		
		//MID
		(findDisplay 46) ctrlCreate ["RscStructuredText",7219835];
		(findDisplay 46 displayCtrl 7219835) ctrlSetPosition [safeZoneX,safeZoneY+safeZoneH-0.45,0.6,0.45];
		(findDisplay 46 displayCtrl 7219835) ctrlSetBackgroundColor [1,1,1,0];
		(findDisplay 46 displayCtrl 7219835) ctrlSetStructuredText parseText ("<t shadow='0' align='center'><img shadow='0' size='8.5' image='"+BRPVP_imagePrefix+"BRP_imagens\opening\brpvp_opening_mid.paa'/></t>");
		(findDisplay 46 displayCtrl 7219835) ctrlSetFade 1;
		(findDisplay 46 displayCtrl 7219835) ctrlCommit 0;
		(findDisplay 46 displayCtrl 7219835) ctrlSetFade 0;
		(findDisplay 46 displayCtrl 7219835) ctrlCommit 4;
		sleep 4;

		//END
		(findDisplay 46) ctrlCreate ["RscStructuredText",7219837];
		(findDisplay 46 displayCtrl 7219837) ctrlSetPosition [safeZoneX,safeZoneY+safeZoneH-0.45,0.6,0.45];
		(findDisplay 46 displayCtrl 7219837) ctrlSetBackgroundColor [1,1,1,0];
		(findDisplay 46 displayCtrl 7219837) ctrlSetStructuredText parseText ("<t shadow='0' align='center'><img shadow='0' size='8.5' image='"+BRPVP_imagePrefix+"BRP_imagens\opening\brpvp_opening_end.paa'/></t>");
		(findDisplay 46 displayCtrl 7219837) ctrlSetFade 1;
		(findDisplay 46 displayCtrl 7219837) ctrlCommit 0;
		(findDisplay 46 displayCtrl 7219837) ctrlSetFade 0;
		(findDisplay 46 displayCtrl 7219837) ctrlCommit 4;
		sleep 6;

		//DELETE CONTROLS
		ctrlDelete (findDisplay 46 displayCtrl 7219832);
		ctrlDelete (findDisplay 46 displayCtrl 7219835);
		ctrlDelete (findDisplay 46 displayCtrl 7219837);
	};
};

//GET ACCESS STATUS
if (isNil "BRPVP_getPlayerAccessFromServer") then {
	if (BRPVP_usePaydAccess) then {
		_idBd = player getVariable "id_bd";
		
		//PEGA DIAS CORRIDOS
		[player,_idBd] remoteExecCall ["BRPVP_getPlayerAccess",2];
		waitUntil {!isNil "BRPVP_getPlayerAccessFromServer"};

		if (BRPVP_getPlayerAccessFromServer > 0) then {
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\access_clock.paa'/><br/>"+format ["Dias *corridos* restantes: %1",BRPVP_getPlayerAccessFromServer],0,0.25,5,0,0,9432] call BRPVP_fnc_dynamicText;
		
			//PEGAS DIAS DE USO
			[player,_idBd,false] remoteExecCall ["BRPVP_getPlayerAccess2",2];
			waitUntil {!isNil "BRPVP_getPlayerAccess2FromServer"};

		} else {
			//PEGAS DIAS DE USO
			[player,_idBd,true] remoteExecCall ["BRPVP_getPlayerAccess2",2];
			waitUntil {!isNil "BRPVP_getPlayerAccess2FromServer"};

			if (BRPVP_getPlayerAccess2FromServer > 0) then {
				["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\access_clock.paa'/><br/>"+format ["Dias *de uso* restantes: %1",BRPVP_getPlayerAccess2FromServer],0,0.25,5,0,0,9432] call BRPVP_fnc_dynamicText;
			} else {
				BRPVP_hint = {};
				BRPVP_hintHistoricShow = [];
				BRPVP_walkDisabled = true;
				5 cutText ["","PLAIN"];
				10 cutText ["","PLAIN DOWN"];
				player allowDamage false;
				player setVariable ["brpvp_zombie_can_see",false,true];
				player setCaptive true;
				[player,true] remoteExecCall ["hideObjectGlobal",2];
				["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\access_clock.paa'/><br/>Você não tem dias de jogo!",0,0.25,3,0,0,9432] call BRPVP_fnc_dynamicText;
				"erro" call BRPVP_playSound;
				sleep 4;
				["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\brpvpid.paa'/><br/>"+format ["Seu BRPVP-ID é: %1",_idBd],0,0.25,59,0,0,9432] call BRPVP_fnc_dynamicText;
				0 spawn BRPVP_linksShowAccess;
			};
		};
		player setVariable ["brpvp_access_days",[BRPVP_getPlayerAccessFromServer,BRPVP_getPlayerAccess2FromServer],true];
	};
};

diag_log "[BRPVP FILE] nascimento_player.sqf END REACHED";