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
diag_log "[SCRIPT] servidor_veiculos.sqf BEGIN";

//VARIAVEIS INICIAIS
_contaVeiculos = 0;
BRPVP_allFlags = [];
BRPVP_sendToHC = [];
_holes = [];
BRPVP_allFlagsDeleted = [];

//SPAWN CONSTRUCTIONS
_ultimoId = -1;
_resultado = "";
_execAll = [];
_tableLinesBuildings = [];
_tableLinesVehicles = [];
_maxSize = 0;

//PLAYERS PATRIMONY CALC
private ["_ymdhCases"];
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
		private ["_result","_compiled"];
		private _space = 100-_cntPC;
		_result = "extDB3" callExtension format ["0:%1:getPatrimony:%2",BRPVP_protocolo,_ymdh];
		_compiled = parseSimpleArray _result select 1;
		if (_compiled isEqualTo "100") then {
			diag_log ("[BRPVP PATRIMONY QUERY FAILED] "+str [_result,_ymdh,_qt]);
		} else {
			private _toAdd = _compiled select [0,_space min count _compiled];
			diag_log ("[BRPVP PATRIMONY QUERY RETURN SIZE] "+str count _result);
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
diag_log "---------------------------------------------------------------------------------------------------------------";
{diag_log str [_x select 1,_x select 5];} forEach _players;
diag_log "---------------------------------------------------------------------------------------------------------------";
_playersId = _players apply {_x select 0};
_vehsClass = BRPVP_tudoA3 apply {if (_x select 0 isEqualTo "FEDIDEX") then {"remove"} else {_x select 3}};
_vehsValor = BRPVP_tudoA3 apply {if (_x select 0 isEqualTo "FEDIDEX") then {"remove"} else {_x select 5}};
_vehsClass = _vehsClass-["remove"];
_vehsValor = _vehsValor-["remove"];

//GET BUILDINGS AND VEHICLES/BOXES FROM DATABASE
private _init = diag_tickTime;
private _onetimeOnly = false;
while {_resultado isNotEqualTo [] && !_onetimeOnly} do {
	while {_resultado isNotEqualTo [] && !_onetimeOnly} do {
		private _size = -1;
		if (BRPVP_useExtDB3) then {
			_resultado = "extDB3" callExtension format ["0:%1:getObjects:%2",BRPVP_protocolo,_ultimoId];
			_size = count _resultado;
			_resultado = parseSimpleArray _resultado select 1;
		} else {
			_onetimeOnly = true;
			_resultado = call BRPVP_hdb_query_getObjects;
			_size = count str _resultado;
		};
		if (_size > _maxSize) then {_maxSize = _size;};
		{
			_ultimoId = _x select 0;
			_carga = _x select 2;
			_modelo = if (BRPVP_usingBrpvpMod) then {(_x select 4) call BRPVP_noModToModConvertion;} else {(_x select 4) call BRPVP_modToNoModConvertion;};
			_owner = _x select 5;
			_trueClassAd = _x select 17;
			_isMotorizedOrBox = _modelo call BRPVP_isMotorized || _modelo isKindOf ["ReammoBox_F",configFile >> "CfgVehicles"];
			if (_modelo isNotEqualTo (_x select 4)) then {
				if (BRPVP_useExtDB3) then {
					"extDB3" callExtension format ["0:%1:updateVehicleClassname:%2:%3",BRPVP_protocolo,_modelo,_ultimoId];
				} else {
					[_ultimoId,[["modelo",_modelo]]] call BRPVP_hdb_query_updateVehicleFieldsById;
				};
				_x set [4,_modelo];
			};
			if (_isMotorizedOrBox) then {
				_virtualGarage = _x select 12;
				if (_virtualGarage isEqualTo 0 && _trueClassAd isEqualTo 0) then {
					_tableLinesVehicles pushBack _x
				} else {
					private _idxPlayer = _playersId find _owner;
					if (_idxPlayer isNotEqualTo -1) then {
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
diag_log ("[BRPVP GET OBJ DB] max call size is "+str _maxSize+" characters!");
diag_log ("[BRPVP GET OBJ DB] time takem is "+str (diag_tickTime-_init)+"!");

//SPAWN BUILDINGS
_countFlag = 0;
_tableLinesBuildings = _tableLinesBuildings apply {
	if ((_x select 4) isKindOf ["FlagCarrier",configFile >> "CfgVehicles"]) then {
		_countFlag = _countFlag+1;
		[0,_x]
	} else {
		[1,_x]
	}
};
_tableLinesBuildings sort true;
_tableLinesBuildings = _tableLinesBuildings apply {_x select 1};
{
	private ["_veiculo","_isSO"];
	
	//CRIA E POSICIONA VEICULO
	_veiculoId = _x select 0;
	_modelo = _x select 4;
	_carga = _x select 2;
	_posicao = _x select 3;
	_owner = _x select 5;
	_comp = _x select 6;
	_amigos = _x select 7;
	_mapa = _x select 8;
	_exec = _x select 9;
	_lastPayment = _x select 11;
	_canBeOutOfFlag = _modelo in ["Land_Carrier_01_base_F","Land_ClutterCutter_medium_F"] || _mapa;
	if (_forEachIndex < _countFlag && _lastPayment call BRPVP_flagExpired) then {
		diag_log ("SERVER START, FLAG EXPIRED! DELETING FLAG: "+str _x);
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_veiculoId];
			"extDB3" callExtension format ["1:%1:setVehicleDelInfo:%2:%3",BRPVP_protocolo,_veiculoId,_veiculoId];
		} else {
			[_veiculoId,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
			[_veiculoId,[["delInfo",_veiculoId]]] call BRPVP_hdb_query_updateVehicleFieldsById;
		};
		BRPVP_allFlagsDeleted pushBack [_veiculoId,_modelo call BRPVP_getFlagRadius,ASLToAGL (_posicao select 0)];
	} else {
		if ([_owner,ASLToAGL (_posicao select 0)] call BRPVP_checkOnFlagStateNoObj isEqualTo 0 && !_canBeOutOfFlag && _forEachIndex >= _countFlag) then {
			diag_log ("SERVER START, FLAG NOT FOUND! DELETING BUILDING: "+str _x);
			if (BRPVP_useExtDB3) then {
				"extDB3" callExtension format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_veiculoId];
			} else {
				[_veiculoId,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
			};
			private _po = ASLToAGL (_posicao select 0);
			{
				_x params ["_id","_rad","_AGL"];
				if (_po distance2D _AGL <= _rad) exitWith {
					if (BRPVP_useExtDB3) then {
						"extDB3" callExtension format ["1:%1:setVehicleDelInfo:%2:%3",BRPVP_protocolo,_id,_veiculoId];
					} else {
						[_veiculoId,[["delInfo",_id]]] call BRPVP_hdb_query_updateVehicleFieldsById;
					};
				};
			} forEach BRPVP_allFlagsDeleted;
		} else {
			if (_modelo isEqualTo "Land_Carrier_01_base_F") then {
				_pASL = _posicao select 0;
				_dir = _posicao select 1;
				_carrier = createVehicle ["Land_Carrier_01_base_F",[0,0,0],[],0,"CAN_COLLIDE"];
				_carrier setVariable ["BIS_carrierParts",_carrier getVariable "BIS_carrierParts",true];
				_carrier setPosASL _pASL;
				_carrier setDir _dir;
				[_carrier] call BIS_fnc_Carrier01PosUpdate;
				_carrier setVariable ["brpvp_carr_own",_owner,true];
				_carrier setVariable ["brpvp_carr_id_bd",_veiculoId,true];
				BRPVP_carrierObjsList pushBack _carrier;
				[_carrier,_pASL] spawn BRPVP_carrierMissFixAndInit;

				//PATRIMONY
				private _idxPlayer = _playersId find _owner;
				if (_idxPlayer isNotEqualTo -1) then {(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+BRPVP_carrierPrice];};
			} else {
				_vPWD = _posicao select 0;
				_vVDU = _posicao select 1;

				//CHECK IF MALICIOUS REPEAT TO HURT SERVER FPS
				private _posTheSame = (nearestObjects [ASLToAGL _vPWD,[],0.125]) select {_x isKindOf _modelo && _x getVariable ["id_bd",-1] isNotEqualTo -1};
				private _posAndAngleTheSame = _posTheSame select {((vectorDir _x vectorCos (_vVDU select 0)) >= 1 || {acos (vectorDir _x vectorCos (_vVDU select 0)) < 2.5}) && ((vectorUp _x vectorCos (_vVDU select 1)) >= 1 || {acos (vectorUp _x vectorCos (_vVDU select 1)) < 2.5})};
				if (_posAndAngleTheSame isEqualTo []) then {
					_isSO = false;
					_isCutter = _modelo isEqualTo "Land_ClutterCutter_medium_F";
					_isPhy = _modelo isKindOf ["ThingX",configFile >> "CfgVehicles"];
					if (_modelo in BRPVP_buildingHaveDoorList) then {
						if (_modelo in BRPVP_buildingHaveDoorListCVL) then {
							_veiculo = _modelo createVehicleLocal BRPVP_spawnVehicleFirstPos;
							BRPVP_allMissionObjectsCVL pushBack _veiculo;
						} else {
							_veiculo = createVehicle [_modelo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
							BRPVP_ownedHouses pushBack _veiculo;
							if !(_modelo in BRPVP_doNotDisableBuildingClass) then {_veiculo enableDynamicSimulation true;};
						};
						_veiculo setVectorDirAndUp _vVDU;
						_veiculo setPosWorld _vPWD;
					} else {
						if (_isCutter) then {
							_veiculo = createVehicle [_modelo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
							_veiculo setVectorDirAndUp _vVDU;
							_veiculo setPosWorld _vPWD;
						} else {
							_isSO = true;
							_veiculo = createSimpleObject [_modelo,AGLToASL BRPVP_spawnVehicleFirstPos,true];
							_veiculo setVectorDirAndUp _vVDU;
							_veiculo setPosWorld _vPWD;
						};
					};

					//SET LAST PAYMENT ON FLAG
					if (_veiculo isKindOf "FlagCarrier") then {
						BRPVP_allFlags pushBack _veiculo;
						_veiculo setVariable ["brpvp_flag_radius",_veiculo call BRPVP_getFlagRadius,true];
						_veiculo setVariable ["brpvp_lastPayment",_lastPayment,true];
					};

					if (_modelo in BRPVP_multiPartObjectsClasses) then {BRPVP_multiPartObjects pushBack _veiculo;};
					if (_isCutter) then {
						_veiculo setVariable ["id_bd",_veiculoId,true];
						_veiculo setVariable ["own",_owner,true];
						_holes pushBack _veiculo;
					} else {
						//VEHICLE OR BUILDING CONFIGURATION
						if (_mapa) then {_veiculo setVariable ["mapa",true,true];};
						_contaVeiculos = _contaVeiculos + 1;
						_veiculo setVariable ["id_bd",_veiculoId,true];
						_veiculo setVariable ["own",_owner,true];
						if (_owner isNotEqualTo -1) then {
							if (_mapa) then {
								_veiculo setVariable ["stp",3,true];
								_veiculo setVariable ["amg",_amigos,true];
							} else {
								_veiculo setVariable ["stp",_comp,true];
								_veiculo setVariable ["amg",_amigos,true];
							};
						};

						//ADICIONA CARGA DO CARRO
						[_veiculo,_carga] call BRPVP_putItemsOnCargo;

						//ADICIONA CASAS
						if (_modelo isEqualTo "Land_Airport_01_hangar_F") then {
							_veiculo animate ["door_2_move",0,true];
							_veiculo animate ["door_3_move",0,true];
						};
						{
							_x params ["_class","_animations"];
							if (_modelo isEqualTo _class) then {
								{_veiculo animateSource _x;} forEach _animations;
							};
						} forEach BRPVP_animateObjsAfterCreate;
						if (!_isSO) then {_veiculo addEventHandler ["HandleDamage",{call BRPVP_buildingHDEH}];};
						
						//PATRIMONY
						private _idxPlayer = _playersId find _owner;
						if (_idxPlayer isNotEqualTo -1) then {
							private _price = _modelo call BRPVP_getConstructionPrice;
							(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_price];
						};
					};
					//EXEC OBJECT CODE
					if (_exec isNotEqualTo "") then {_execAll pushBack [_veiculo,_exec];};
				};
			};
		};
	};
} forEach _tableLinesBuildings;
//EXEC OBJECTS CODE
{
	_x params ["_obj","_txt"];
	_txt = [_txt,"@#$2_points$#@",":"] call BRPVP_stringReplace;
	_obj call compile _txt;

	//VR PAINT PATRIMONY
	private _isVr = typeOf _obj in BRPVP_vrObjectsClasses;
	if (_isVr && _txt find "'] call BRPVP_vrObjectSetTextures;" isNotEqualTo -1) then {
		private _owner = _obj getVariable "own";
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
	if (_idxPlayer isNotEqualTo -1) then {
		if (_valor > -1) then {
			(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valor];
		} else {
			((_x getVariable "brpvp_box_inventory")  call BRPVP_getCargoArrayValor) params ["_valorItem","_valorFlare"];
			(_players select _idxPlayer) set [5,(_players select _idxPlayer select 5)+_valorItem];
			(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valorFlare];
		};
	};
} forEach _holes;


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
				_ultimoId = _id;
				BRPVP_bigFloorsAll pushBack [_id,_posWorld,_holes,_owner];

				//PATRIMONY
				private _idxPlayer = _playersId find _owner;
				if (_idxPlayer isNotEqualTo -1) then {(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_bfPrice];};
			} forEach (parseSimpleArray _resultado select 1);
		};
	};
} else {
	{
		_x params ["_id","_size","_owner","_posWorld","_holes","_color"];
		BRPVP_bigFloorsAll pushBack [_id,_posWorld,_holes,_owner];

		//PATRIMONY
		private _idxPlayer = _playersId find _owner;
		if (_idxPlayer isNotEqualTo -1) then {(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_bfPrice];};
	} forEach call BRPVP_hdb_query_bfGetAll;
};

//CREATE BIG FLOORS
{_x call BRPVP_creatBigFloor200;} forEach BRPVP_bigFloorsAll;

//CALC SUPER BOX STAIR ATTACH ARRAY
private _class = BRPVP_superBoxClass;
private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
private _bigObjFix = -vectorMagnitude (getPosWorld _CVL vectorDiff getPosASL _CVL);
deleteVehicle _CVL;

_class = "Land_Obstacle_Ramp_F";
_CVL = _class createVehicleLocal BRPVP_posicaoFora;
private _bigBoxStairFix = vectorMagnitude (getPosWorld _CVL vectorDiff getPosASL _CVL);
deleteVehicle _CVL;

private _consItemAttach = [0,2.4,_bigObjFix+_bigBoxStairFix+0.075];

//SPAWN ENTITIE VEHICLES AND BOXES
private _paintPrice = "BRPVP_itemPaintVehicle" call BRPVP_itemGetPrice;
_tires = [];
_isToBugObjs = [];
_boxHcEh = [];
_missingNumberWeps = [];
_missingNumberMags = [];
_missingNumberItems = [];
_missingNumberPacks = [];
{
	private ["_veiculo","_isSO"];
	_veiculoId = _x select 0;
	_carga = _x select 2;
	_posicao = _x select 3;
	_modelo = _x select 4;
	_owner = _x select 5;
	_comp = _x select 6;
	_amigos = _x select 7;
	_exec = _x select 9;
	_lock = _x select 10;
	_paint = _x select 13;
	_cover = _x select 14;
	_ammo = _x select 15;
	_life = _x select 16;
	_lifesFix = _x select 18;
	_vPWD = _posicao select 0;
	_vVDU = _posicao select 1;
	_lis = lineIntersectsSurfaces [_vPWD,_vPWD vectorAdd [0,0,-7.25],objNull,objNull,true,1,"GEOM","NONE"];
	_isFloating = _lis isEqualTo [];
	_isWater = surfaceIsWater _vPWD;
	_isTerrain = ASLToATL _vPWD select 2 < 4;
	_isToBug = _isWater && (_isFloating || _isTerrain);
	if (BRPVP_useTireVehiclesOnStart && _modelo call BRPVP_isMotorizedNoTurret && !_isFloating && !_isToBug) then {
		private _veh = _modelo createVehicleLocal (BRPVP_spawnVehicleFirstPos vectorAdd [random 200,random 200,0]);
		_veh setVectorUp [0,0,1];
		private _fix = (getPosWorld _veh select 2)-(getPosASL _veh select 2);
		private _vFix = vectorNormalized (_vVDU select 1) vectorMultiply -_fix;
		private _vFixA = vectorNormalized (_vVDU select 1) vectorMultiply -_fix*0.75;
		private _vFixB = vectorNormalized (_vVDU select 1) vectorMultiply -_fix*1.25;
		private _lis = lineIntersectsSurfaces [_vPWD vectorAdd _vFixA,_vPWD vectorAdd _vFixB,_veh,objNull];
		_posASL = if (_lis isEqualTo []) then {_vPWD vectorAdd _vFix} else {_lis select 0 select 0};
		{deleteVehicle _x;} forEach attachedObjects _veh;
		deleteVehicle _veh;
		_tire = if (_modelo in BRPVP_disableVehUseList) then {"PlasticBarrier_02_yellow_F" createVehicleLocal [0,0,0]} else {"PlasticBarrier_02_grey_F" createVehicleLocal [0,0,0]};
		private _posATL = ASLToATL _posASL;
		_posASL = if (_posATL select 2 < 0) then {ATLToASL ((_posATL select [0,2])+[0])} else {_posASL};
		_tire setPosASL _posASL;
		_tire setVectorDirAndUp [vectorNormalized ((_vVDU select 0) vectorCrossProduct (_vVDU select 1)),_vVDU select 1];
		_tire setVariable ["brpvp_tire_nameCFG",configFile >> "CfgVehicles" >> _modelo];
		_tire setVariable ["brpvp_tire_owner",_owner];
		_tire setVariable ["brpvp_tire_idbd",_veiculoId];
		_tires pushBack _tire;

		//PATRIMONY I
		private _idxPlayer = _playersId find _owner;
		if (_idxPlayer isNotEqualTo -1) then {
			(_carga call BRPVP_getCargoArrayValor) params ["_valorItem","_valorFlare"];
			(_players select _idxPlayer) set [5,(_players select _idxPlayer select 5)+_valorItem];
			(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valorFlare];

			private _idx = _vehsClass find _modelo;
			if (_idx > -1) then {
				private _price = _vehsValor select _idx;
				if (_paint isNotEqualTo []) then {_price = _price+_paintPrice;};
				(_players select _idxPlayer) set [4,(_players select _idxPlayer select 4)+_price];
			};
		};
	} else {
		if (_modelo in BRPVP_autoTurretTypes) then {
			BRPVP_setTurretOperatorAll pushBack [_modelo,_vVDU,_vPWD,_veiculoId,_owner,_comp,_amigos,_exec,0];
			
			//PATRIMONY
			private _idxPlayer = _playersId find _owner;
			if (_idxPlayer isNotEqualTo -1) then {
				_isTurretLvl2 = _exec isEqualTo "_this setVariable ['brpvp_tlevel',2,true];";
				_price = if (_isTurretLvl2) then {"BRP_kitAutoTurretLvl2" call BRPVP_itemGetPrice} else {_modelo call BRPVP_getConstructionPrice};
				(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_price];
			};
		} else {
			if ([_owner,ASLToAGL (_posicao select 0)] call BRPVP_checkOnFlagStateNoObj isEqualTo 0 && _modelo isKindOf ["ReammoBox_F",configFile >> "CfgVehicles"]) then {
				diag_log ("SERVER START, FLAG NOT FOUND! DELETING BOX: "+str _x);
				if (BRPVP_useExtDB3) then {
					"extDB3" callExtension format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_veiculoId];
				} else {
					[_veiculoId,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
				};
				private _po = ASLToAGL (_posicao select 0);
				{
					_x params ["_id","_rad","_AGL"];
					if (_po distance2D _AGL <= _rad) exitWith {
						if (BRPVP_useExtDB3) then {
							"extDB3" callExtension format ["1:%1:setVehicleDelInfo:%2:%3",BRPVP_protocolo,_id,_veiculoId];
						} else {
							[_veiculoId,[["delInfo",_id]]] call BRPVP_hdb_query_updateVehicleFieldsById;
						};
					};
				} forEach BRPVP_allFlagsDeleted;
			} else {
				_isDrone = _modelo in BRPVP_vantVehiclesClass;
				_veiculo = createVehicle [_modelo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];

				//PREPARE SUPER BIG BOX
				private _superObj = _modelo isEqualTo BRPVP_superBoxClass;
				if (_superObj) then {
					private _sustenter = createVehicle [_modelo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
					_sustenter setVectorDirAndUp _vVDU;
					_sustenter setPosWorld _vPWD;
					private _vec = (getPosWorld _sustenter vectorDiff getPosASL _sustenter) vectorMultiply -1;
					_veiculo setMaxLoad BRPVP_superBoxCargoSize;
					_veiculo attachTo [_sustenter,_vec];
					_veiculo setVariable ["brpvp_sustenter_obj",_sustenter,true];
					_sustenter setVariable ["brpvp_real_box",_veiculo,true];
					_sustenter call BRPVP_emptyBox;
					_sustenter hideObjectGlobal true;

					private _stair = createSimpleObject ["Land_Obstacle_Ramp_F",BRPVP_posicaoFora];
					_stair attachTo [_veiculo,_consItemAttach];

					_veiculo setDir 0;
					_veiculo setObjectScale BRPVP_superBoxScale;
				};

				if (_isDrone) then {
					//createVehicleCrew _veiculo;
					if (BRPVP_dronesMakeAllUnarmed) then {
						{
							_veiculo setPylonLoadout [configName _x,""];
						} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _veiculo >> "Components" >> "TransportPylonsComponent" >> "pylons"));
					};
					_veiculo setVariable ["brpvp_auto_first",true,true];
				};
				if (_modelo isEqualTo "B_UAV_05_F") then {
					_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
					{_veiculo animateSource [_x,1,true];} forEach _wingAnimations;
				};
				if (!_superObj) then {
					_veiculo setVectorDirAndUp _vVDU;
					_veiculo setPosWorld _vPWD;
				};

				//VEHICLE OR BUILDING CONFIGURATION
				_contaVeiculos = _contaVeiculos+1;
				_veiculo setVariable ["id_bd",_veiculoId,true];
				_veiculo setVariable ["own",_owner,true];
				if (_owner != -1) then {
					_veiculo setVariable ["stp",_comp,true];
					_veiculo setVariable ["amg",_amigos,true];
				};
				
				//PATRIMONY
				private _idxPlayer = _playersId find _owner;
				if (_idxPlayer isNotEqualTo -1) then {
					(_carga call BRPVP_getCargoArrayValor) params ["_valorItem","_valorFlare"];
					(_players select _idxPlayer) set [5,(_players select _idxPlayer select 5)+_valorItem];
					(_players select _idxPlayer) set [2,(_players select _idxPlayer select 2)+_valorFlare];
				};
				
				if (_veiculo call BRPVP_isMotorizedNoTurret) then {
					_veiculo call BRPVP_setVehServicesToZero;
					_veiculo call BRPVP_veiculoEhReset;

					//VEH RADAR AND THERMAL
					_veiculo call BRPVP_setVehRadarAndThermal;

					//SET AMMO
					[_veiculo,_ammo] call BRPVP_setVehicleAmmo;

					//SET VEHICLE LIFE
					[_veiculo,_life] call BRPVP_setVehicleDamage;
					
					//SET LIFESFIX
					_veiculo setVariable ["brpvp_lifesfix",_lifesFix,true];

					//SET CUSTOM CARGO SIZE
					{
						_x params ["_class","_name","_cargo"];
						if (_class isEqualTo _modelo) exitWith {_veiculo setMaxLoad _cargo;};
					} forEach BRPVP_customCargoVehiclesCfg;

					//PATRIMONY
					if (_idxPlayer isNotEqualTo -1) then {
						private _idx = _vehsClass find _modelo;
						if (_idx > -1) then {
							private _price = _vehsValor select _idx;
							if (_paint isNotEqualTo []) then {_price = _price+_paintPrice;};
							(_players select _idxPlayer) set [4,(_players select _idxPlayer select 4)+_price];
						};
					};
				} else {
					if (_veiculo isKindOf "ReammoBox_F") then {
						BRPVP_ownedHouses pushBack _veiculo;
						_veiculo allowDamage false;
						_veiculo addEventHandler ["HandleDamage",{call BRPVP_buildingHDEH}];
						if (BRPVP_customBaseBoxSizeUse && _modelo isNotEqualTo BRPVP_superBoxClass) then {_veiculo setMaxLoad BRPVP_customBaseBoxSize;};
					};

					//PATRIMONY
					if (_idxPlayer isNotEqualTo -1) then {
						_price = _modelo call BRPVP_getConstructionPrice;
						(_players select _idxPlayer) set [3,(_players select _idxPlayer select 3)+_price];
					};
				};

				//PAINT VEHICLE
				if (_paint isNotEqualTo []) then {
					{_veiculo setObjectTextureGlobal [_forEachIndex,_x];} forEach _paint;
					_veiculo setVariable ["brpvp_paint_enabled",true,true];
				};

				//VEHICLE COVER
				if (_cover isNotEqualTo []) then {[_veiculo,false,_cover,false] remoteExecCall ["BIS_fnc_initVehicle",_veiculo];};

				//EXEC OBJECT CODE
				if (_exec != "") then {_veiculo call compile _exec;};
				
				//ADICIONA CARGA DO CARRO
				//=======================
				
				//CHECK CLASS CASES WITH NO ASSOSSIATED NUMBER
				{
					private _cont = _x;

					//WEAPONS
					private _cWeps = _cont select 1 select 0;
					{
						_x params ["_wep","_qtt"];
						private _wClass = _wep select 0;
						if (_wClass isEqualType "") then {if (BRPVP_ItemsClassToNumberTableA find _wClass isEqualTo -1) then {_missingNumberWeps pushBackUnique _wClass;};};
						private _muzzle = _wep select 1;
						if (_muzzle isEqualType "") then {if (BRPVP_ItemsClassToNumberTableC find _muzzle isEqualTo -1) then {_missingNumberItems pushBackUnique _muzzle;};};
						private _light = _wep select 2;
						if (_light isEqualType "") then {if (BRPVP_ItemsClassToNumberTableC find _light isEqualTo -1) then {_missingNumberItems pushBackUnique _light;};};
						private _optic = _wep select 3;
						if (_optic isEqualType "") then {if (BRPVP_ItemsClassToNumberTableC find _optic isEqualTo -1) then {_missingNumberItems pushBackUnique _optic;};};
						if (_wep select 4 isNotEqualTo []) then {
							private _mag = _wep select 4 select 0;
							if (_mag isEqualType "") then {if (BRPVP_ItemsClassToNumberTableB find _mag isEqualTo -1) then {_missingNumberMags pushBackUnique _mag;};};
						};
						if (_wep select 5 isNotEqualTo []) then {
							private _mag2 = _wep select 5 select 0;
							if (_mag2 isEqualType "") then {if (BRPVP_ItemsClassToNumberTableB find _mag2 isEqualTo -1) then {_missingNumberMags pushBackUnique _mag2;};};
						};
						private _bipod = _wep select 6;
						if (_bipod isEqualType "") then {if (BRPVP_ItemsClassToNumberTableC find _bipod isEqualTo -1) then {_missingNumberItems pushBackUnique _bipod;};};
					} forEach _cWeps;

					//MAGS
					private _cMags = _cont select 1 select 1;
					{
						_x params ["_class","_qtt","_ammo"];
						if (_class isEqualType "" && {BRPVP_ItemsClassToNumberTableB find _class isEqualTo -1}) then {_missingNumberMags pushBackUnique _class;};
					} forEach _cMags;

					//ITEMS
					private _cItems = _cont select 1 select 2 select 0;
					{
						if (_x isEqualType "" && {BRPVP_ItemsClassToNumberTableC find _x isEqualTo -1}) then {_missingNumberItems pushBackUnique _x;};
					} forEach _cItems;

					//BACK PACKS
					private _cPack = _cont select 1 select 3 select 0;
					{
						if (_x isEqualType "" && {BRPVP_ItemsClassToNumberTableD find _x isEqualTo -1}) then {_missingNumberPacks pushBackUnique _x;};
					} forEach _cPack;
				} forEach (_carga select 1);
				[_veiculo,_carga] call BRPVP_putItemsOnCargo;

				//SET VEHICLE LOCK
				if (_lock isNotEqualTo 0) then {_veiculo setVariable ["brpvp_locked",_lock isNotEqualTo 0,true];};

				//CHECK IF WILL BUG
				if (_isToBug) then {_isToBugObjs pushBack _veiculo;};
			};
		};
	};
} forEach _tableLinesVehicles;

//WRITE CLASSES WITHOUT ASSOSSIATED NUMBER TO LOG FILE
diag_log "===================== WEAPONS CLASS WITH NO LOOT NUMBER:";
{diag_log _x;} forEach _missingNumberWeps;
diag_log "===================== MAGAZINES CLASS WITH NO LOOT NUMBER:";
{diag_log _x;} forEach _missingNumberMags;
diag_log "===================== ITEMS CLASS WITH NO LOOT NUMBER:";
{diag_log _x;} forEach _missingNumberItems;
diag_log "===================== BACKPACK CLASS WITH NO LOOT NUMBER:";
{diag_log _x;} forEach _missingNumberPacks;
diag_log "=========================================================";

//DISABLE TIRES SIMULATION
//CHECK IF WILL BUG
_isToBugObjs spawn {
	sleep 50;
	{if (!alive _x && !(_x getVariable ["brpvp_veh_dead_run_ok",false])) then {[_x,objNull] call BRPVP_MPKilled;};} forEach _this;
};
BRPVP_tireAllTiresGlobal = _tires;

//DEL FLAGS IF OVER UNPAID LIMIT
{
	_x params ["_id","_rad","_pos"];
	{
		private _idBd = _x getVariable ["id_bd",-1];
		if (_idBd > -1 && _x call BRPVP_checkOnFlagState isEqualTo 0) then {
			[_x,true] call BRPVP_removeObject;
			if (BRPVP_useExtDB3) then {
				"extDB3" callExtension format ["1:%1:setVehicleDelInfo:%2:%3",BRPVP_protocolo,_id,_idBd];
			} else {
				[_idBd,[["delInfo",_id]]] call BRPVP_hdb_query_updateVehicleFieldsById;
			};
		};
	} forEach nearestObjects [_pos,["Motorcycle","Car","Tank","Air","Ship"],_rad,true];
	{
		private _idBd = _x getVariable ["brpvp_tire_idbd",-1];
		if (_idBd > -1 && _x call BRPVP_checkOnFlagState isEqualTo 0) then {
			if (BRPVP_useExtDB3) then {
				"extDB3" callExtension format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_idBd];
				"extDB3" callExtension format ["1:%1:setVehicleDelInfo:%2:%3",BRPVP_protocolo,_id,_idBd];
			} else {
				[_idBd,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
				[_idBd,[["delInfo",_id]]] call BRPVP_hdb_query_updateVehicleFieldsById;
			};
			deleteVehicle _x;
		};
	} forEach nearestObjects [_pos,["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"],_rad,true];
	BRPVP_tireAllTiresGlobal = BRPVP_tireAllTiresGlobal-[objNull];		
} forEach BRPVP_allFlagsDeleted;

publicVariable "BRPVP_allFlags";

diag_log ("[BRPVP COUNT PATRIMONY PLAYERS] "+str count _players);
_players = _players apply {[_x#0,_x#1,round (_x#2),round (_x#3),round (_x#4),round (_x#5),round (_x#2+_x#3+_x#4+_x#5)]};
_playersRank = _players apply {[_x select 6,_x]};
_playersRank sort false;
diag_log "==============================================================";
{diag_log str _x;} forEach _playersRank;
diag_log "==============================================================";

BRPVP_playersPatrimony = _players;
publicVariable "BRPVP_playersPatrimony";

//SPAWN FRANTA MINES
private _frantas = [];
if (BRPVP_useExtDB3) then {
	private _result = "";
	private _lastId = -1;
	while {_result isNotEqualTo "[1,[]]"} do {
		while {_result isNotEqualTo "[1,[]]"} do {
			_result = "extDB3" callExtension format ["0:%1:getFantaMines:%2",BRPVP_protocolo,_lastId];
			_frantas append (parseSimpleArray _result select 1);
			if (_frantas isNotEqualTo []) then {_lastId = _frantas select (count _frantas-1) select 0;};
		};
	};
} else {
	_frantas = call BRPVP_hdb_query_getFantaMines;
};
reverse _frantas;
private _foId = [];
private _foQt = [];
BRPVP_frantaAllObjs = [];
{
	private _id = _x select 0;
	private _owner = _x select 1;
	private _amg = _x select 2;
	private _pos = _x select 3;
	private _isBase = _x select 4;
	private _inFlag = _pos call BRPVP_checkOnFlagAnyPosObj;
	private _qnOk = true;
	if (_isBase isEqualTo "") then {
		_isBase = _inFlag;
		if (BRPVP_useExtDB3) then {
			"extDB3" callExtension format ["1:%1:updateFantaMineIsBase:%2:%3",BRPVP_protocolo,[0,1] select _isBase,_id];
		} else {
			[_id,[0,1] select _isBase] call BRPVP_hdb_query_updateFantaMineIsBase;
		};
	} else {
		_isBase = _isBase isEqualTo 1;
	};
	if ((_isBase && !_inFlag) || (!_isBase && _inFlag)) then {
		_id call BRPVP_fantaMineRemove;
	} else {
		if (_inFlag) then {
			private _flag = ASLToAGL _pos call BRPVP_nearestFlagInside;
			private _rad = _flag call BRPVP_getFlagRadius;
			private _limit = 0;
			private _mof = (nearestObjects [_flag,["Land_Can_V2_F"],_rad,true] apply {if (_x getVariable ["brpvp_mine_base",false]) then {_x} else {-1};})-[-1];
			{if (_x select 0 isEqualTo _rad) exitWith {_limit = _x select 1;};} forEach BRPVP_fantaMinesTerrainLimit;
			_qnOk = count _mof < _limit
		} else {
			private _idx = _foId find _owner;
			if (_idx isEqualTo -1) then {
				_foId pushBack _owner;
				_foQt pushBack 1;
				_qnOk = 1 <= BRPVP_fantaMinesOutTerrainLimitPerPlayer;
			} else {
				private _qn = (_foQt select _idx)+1;
				_foQt set [_idx,_qn];
				_qnOk = _qn <= BRPVP_fantaMinesOutTerrainLimitPerPlayer;
			};
		};
		if (_qnOk) then {
			private _mine = createVehicle ["Land_Can_V2_F",[0,0,0],[],10,"CAN_COLLIDE"];
			_mine setPosWorld _pos;
			_mine setVectorUp [0,0,1];
			_mine setVariable ["brpvp_mine_base",true,true];
			_mine setVariable ["brpvp_mine_base_owner",_owner,true];
			_mine setVariable ["brpvp_mine_base_friends",_amg,true];
			_mine setVariable ["brpvp_mine_base_id",_id,true];
			_mine setVariable ["brpvp_mine_base_in_flag",_isBase,true];
			_mine enableSimulationGlobal false;
			BRPVP_frantaAllObjs pushBack _mine;
		} else {
			_id call BRPVP_fantaMineRemove;
		};
	};
} forEach _frantas;

//GET SECURITY CAMERAS
private _secCams = [];
if (BRPVP_useExtDB3) then {
	private _result = "";
	private _lastId = -1;
	while {_result isNotEqualTo "[1,[]]"} do {
		while {_result isNotEqualTo "[1,[]]"} do {
			_result = "extDB3" callExtension format ["0:%1:secCamGet:%2",BRPVP_protocolo,_lastId];
			_secCams append (parseSimpleArray _result select 1);
			if (_secCams isNotEqualTo []) then {_lastId = _secCams select (count _secCams-1) select 0;};
		};
	};
} else {
	_secCams = call BRPVP_hdb_query_secCamGet;
};
{
	_x params ["_id","_posASL","_vdu","_own","_amg","_lifeDays"];
	private _flagOk = false;
	{
		private _flag = _x;
		private _rad = _flag call BRPVP_getFlagRadius;
		if (_posASL distance2D _flag <= _rad+BRPVP_secCamBaseExtensionDistance) then {
			private _flagOwn = _flag getVariable ["own",-1];
			private _flagAmg = _flag getVariable ["amg",[[],[],true]];
			private _isFlagOwner = _own isEqualTo _flagOwn;
			private _isFlagFriend = _own in (_flagAmg select 1);
			_flagOk = _isFlagOwner || _isFlagFriend;
		};
		if (_flagOk) exitWith {};
	} forEach nearestObjects [_posASL,["FlagCarrier"],200,true];
	if (_flagOk || _lifeDays <= BRPVP_secCamExistenceLimit) then {
		private _cam = createSimpleObject ["Land_HandyCam_F",_posASL];
		_cam setVectorDirAndUp _vdu;
		_cam setVariable ["brpvp_cam_id",_id,true];
		_cam setVariable ["brpvp_cam_own",_own,true];
		_cam setVariable ["brpvp_cam_amg",_amg,true];
		BRPVP_secCamAll pushBack _cam;
	} else {
		//PPP FEITO
		if (BRPVP_useExtDB3) then {"extDB3" callExtension format ["1:%1:secCamDelete:%2",BRPVP_protocolo,_id];} else {_id call BRPVP_hdb_query_secCamDelete;};
	};
} forEach _secCams;

//SPAWN WEAPON HOLDERS
if (BRPVP_saveGroundItemsForOneRestart) then {
	if (BRPVP_useExtDB3) then {
		_result = "";
		_lastId = -1;
		while {_result isNotEqualTo "[1,[]]"} do {
			_result = "extDB3" callExtension format ["0:%1:whGet:%2",BRPVP_protocolo,_lastId];
			diag_log ("[BRPVP] WH get DB size: "+str count _result);
			{
				_x params ["_id","_pos","_vdu","_gear"];
				_lastId = _id;
				private _wh = createVehicle ["GroundWeaponHolder",[0,0,0],[],100,"CAN_COLLIDE"];
				_wh setPosWorld _pos;
				_wh setVectorDirAndUp _vdu;
				[_wh,_gear] call BRPVP_putItemsOnCargo;
				_wh setVariable ["brpvp_how_old",1,true];
			} forEach (parseSimpleArray _result select 1);
		};
	} else {
		{
			_x params ["_id","_pos","_vdu","_gear"];
			private _wh = createVehicle ["GroundWeaponHolder",[0,0,0],[],100,"CAN_COLLIDE"];
			_wh setPosWorld _pos;
			_wh setVectorDirAndUp _vdu;
			[_wh,_gear] call BRPVP_putItemsOnCargo;
			_wh setVariable ["brpvp_how_old",1,true];
		} forEach call BRPVP_hdb_query_whGet;
	};
};
if (BRPVP_useExtDB3) then {
	"extDB3" callExtension format ["0:%1:whDeleteAll",BRPVP_protocolo];
} else {
	call BRPVP_hdb_query_whDeleteAll;
};

//CREATE SEG CVL
{
	private _CVL = _x;
	private _class = typeOf _CVL;
	private _idx = BRPVP_allMissionObjectsCVLSegClass find _class;
	if (_idx isEqualTo -1) then {
		BRPVP_allMissionObjectsCVLSegClass pushBack _class;
		BRPVP_allMissionObjectsCVLSegObjs pushBack [_CVL];
	} else {
		BRPVP_allMissionObjectsCVLSegObjs select _idx pushBack _CVL;
	};
} forEach BRPVP_allMissionObjectsCVL;

BRPVP_allTurretsInfo = [];
{
	_x params ["_modelo","_vVDU","_vPWD","_veiculoId","_owner","_comp","_amigos","_exec","_damage"];
	if (_veiculoId > -1) then {
		if ([_owner,ASLToAGL _vPWD] call BRPVP_checkOnFlagStateNoObj isEqualTo 0) then {
			if (BRPVP_useExtDB3) then {
				"extDB3" callExtension format ["1:%1:deleteVehicle:%2",BRPVP_protocolo,_veiculoId];
			} else {
				[_veiculoId,[["active",0]]] call BRPVP_hdb_query_updateVehicleFieldsById;
			};
			private _po = ASLToAGL _vPWD;
			{
				_x params ["_id","_rad","_AGL"];
				if (_po distance2D _AGL <= _rad) exitWith {
					if (BRPVP_useExtDB3) then {
						"extDB3" callExtension format ["1:%1:setVehicleDelInfo:%2:%3",BRPVP_protocolo,_id,_veiculoId];
					} else {
						[_veiculoId,[["delInfo",_id]]] call BRPVP_hdb_query_updateVehicleFieldsById;
					};
				};
			} forEach BRPVP_allFlagsDeleted;
		} else {
			BRPVP_allTurretsInfo pushBack _x;
		};
	};
} forEach BRPVP_setTurretOperatorAll;

diag_log ("[SCRIPT] servidor_veiculos.sqf END: "+str round (diag_tickTime-_scriptStart));