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

//MISSOENS BRAVO POINT
BRPVP_criaMissaoDePredioEspera = BRPVP_criaMissaoDePredioIdc;
BRPVP_criaMissaoDePredio = {
	if (BRPVP_criaMissaoDePredioEspera != BRPVP_criaMissaoDePredioIdc) exitWith {};
	BRPVP_criaMissaoDePredioEspera = BRPVP_criaMissaoDePredioIdc + 1;
	
	//CLASSE DOS PREDIOS ONDE PODE TER MISSAO
	private _class = BRPVP_mapaRodando select 11 select 1;

	//SETA TIPO DE SPAWN DO PREDIO
	private _cSDentro = BRPVP_mapaRodando select 11 select 2;

	//PEGA PREDIOS
	if (isNil "BRPVP_bravoMissObjs") then {
		BRPVP_bravoMissObjs = [];
		{
			private _buClass = _x;
			private _objs = BRPVP_centroMapa nearObjects [_buClass,20000];
			{
				private _obj = _x;
				private _notInRadioArea = {_obj distance (_x select 0) <= (_x select 1)+30} count BRPVP_radioAreas isEqualTo 0;
				private _notInWater = !surfaceIsWater getPosWorld _obj;
				private _noDbId = _obj getVariable ["id_bd",-1] isEqualTo -1;
				private _notInSafezone = {(_x select 0) distanceSqr _obj <= (_x select 1)} count BRPVP_safeZonesOtherMethodQuad isEqualTo 0;
				if (typeOf _obj isEqualTo _buClass && _notInRadioArea && _notInWater && _noDbId && _notInSafezone) then {BRPVP_bravoMissObjs pushBack _obj;};
			} forEach _objs;
		} forEach _class;
	};
		
	//ESCOLHE PREDIO E PEGA POSICOES INTERNAS
	private _opcoes = [];
	private _siegeLocals = [];
	{if (_x in [1,2]) then {_siegeLocals pushBack (BRPVP_locaisImportantes select _forEachIndex);};} forEach BRPVP_closedCityRunning;
	BRPVP_bravoMissObjs = BRPVP_bravoMissObjs-[objNull];
	{
		private _bu = _x;
		if (_bu getVariable ["msi",-1] isEqualTo -1) then {
			private _onSiege = false;
			{
				private _pos = _x select 0;
				private _rad = _x select 1;
				if (_pos distance _bu < _rad*1.125) exitWith {_onSiege = true;};
			} forEach _siegeLocals;
			if (!_onSiege) then {
				private _onflag = false;
				{if (_bu distance2D _x < _x call BRPVP_getFlagRadius) exitWith {_onflag = true;};} forEach BRPVP_allFlags;
				if (!_onflag) then {_opcoes pushBack _bu;};
			};
		};
	} forEach BRPVP_bravoMissObjs;
	_opcoes = _opcoes - BRPVP_missPrediosEm;
	_opcoes = _opcoes - [objNull];
	if (count _opcoes isEqualTo 0) exitWith {diag_log "[BRPVP MISSBU] NO FREE BUILDINGS FOR MISSION!";};
	diag_log "[BRPVP MISSBU] FOUND BUILDING FOR MISSION!";
	private _missBu = objNull;
	private _tempClass = +_class;
	while {isNull _missBu} do {
		private _classWanted = _tempClass call BIS_fnc_selectRandom;
		private _tempArr = [];
		_tempClass = _tempClass - [_classWanted];
		{if (typeOf _x isEqualTo _classWanted) then {_tempArr pushBack _x;};} forEach _opcoes;
		if (count _tempArr > 0) then {_missBu = _tempArr call BIS_fnc_selectRandom;};
	};
	_missBu setVariable ["msi",BRPVP_criaMissaoDePredioIdc,true];
	[_missBu,false] remoteExecCall ["allowDamage",0,true];
	private _sirene = nearestObject [_missBu,"Land_Loudspeakers_F"];
	if (isNull _sirene) then {_sirene = _missBu;};
	if (!isNull _sirene) then {[_sirene,"sirene",1250] remoteExecCall ["BRPVP_tocaSom",0];};
	sleep 35;
	private _buAllPos = _missBu buildingPos -1;

	//CRIA PREMIO
	private _moneyBoxValor = BRPVP_mapaRodando select 11 select 4;
	private _moneyBoxNumber = BRPVP_mapaRodando select 11 select 5;
	private _itemBoxValor = BRPVP_mapaRodando select 11 select 6;
	private _itemBoxNumber = BRPVP_mapaRodando select 11 select 7;
	private _caixas = [];

	//CREATE MONEY BOX
	for "_i" from 1 to _moneyBoxNumber do {
		//CRIA CAIXA
		private _caixa = createVehicle ["Box_IND_Wps_F",[_missBu,5] call BRPVP_emVoltaBB,[],0,"NONE"];
		_caixa allowDamage false;
		_caixa setDir random 360;
		_caixas pushBack _caixa;

		//ESVAZIA CAIXA
		clearMagazineCargoGlobal _caixa;
		clearWeaponCargoGlobal _caixa;
		clearItemCargoGlobal _caixa;
		clearBackpackCargoGlobal _caixa;
		
		//COLOCA PREMIO NA CAIXA
		{_caixa addMagazineCargoGlobal [_x,1];} forEach (round (_moneyBoxValor*BRPVP_missionValueMult) call BRPVP_itemMoneyCreate);
	};

	//CREATE ITEM BOX
	for "_i" from 1 to _itemBoxNumber do {
		//CRIA CAIXA
		private _caixa = createVehicle ["Box_IND_Wps_F",[_missBu,5] call BRPVP_emVoltaBB,[],0,"NONE"];
		_caixa allowDamage false;
		_caixa setDir random 360;
		_caixas pushBack _caixa;
		[_caixa,_itemBoxValor,selectRandom [2,3,4,5],true,5,1] call BRPVP_createCompleteLootBox;
	};

	//COLOCA BOTS
	private _grp = createGroup [WEST,true];
	private _uLado = selectRandom BRPVP_missionWestGroups;
	private _missBotsEm = [];
	for "_j" from 1 to 6 do {
		private _esp = _uLado select ((_j-1) mod (count _uLado));
		private _unidade = _grp createUnit [_esp,[_missBu,3] call BRPVP_emVoltaBB,[],0,"NONE"];
		[_unidade] joinSilent _grp;
		_missBotsEm pushBack _unidade;
		_unidade setSkill (BRPVP_AISkill select 0 select 0);
		_unidade setSkill ["aimingAccuracy",BRPVP_AISkill select 0 select 1];
		_unidade addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
		_unidade addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
		uiSleep BRPVP_simpleMissSpawnWait;
	};
	_missBu setVariable ["msbs",_missBotsEm,false];

	//CHG
	remoteExecCall ["BRPVP_AIRemoveNull",2];
	_missBotsEm remoteExecCall ["BRPVP_updateAIUnitsArray",2];
	BRPVP_smallMissionsAIObjs append _missBotsEm;

	BRPVP_missPrediosEm pushBack _missBu;
	publicVariable "BRPVP_missPrediosEm";
	BRPVP_criaMissaoDePredioIdc = BRPVP_criaMissaoDePredioIdc + 1;
	
	//CRIA WAYPOINT PARA BOT PERMANECER NO LOCAL
	private _wp = _grp addWaypoint [_missBu,0];
	_wp setWaypointCompletionRadius 65;
	_wp setWayPointType "LOITER";

	//PUT IN COMBAT
	_grp setBehaviour "COMBAT";
	_grp setCombatMode "YELLOW";

	//SET BOTS TO VERIFY WHEN OPENING THE BOX
	{_x setVariable ["brpvp_mbots",[ASLToAGL getPosASL _missBu,350,_missBotsEm],true];} forEach _caixas;
	
	//SET BOXES TO DELETE WHEN EMPTY
	{_x setVariable ["brpvp_del_when_empty",true,true];} forEach _caixas;
};