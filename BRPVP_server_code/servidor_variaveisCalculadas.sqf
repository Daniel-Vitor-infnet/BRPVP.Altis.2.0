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
diag_log "[SCRIPT] servidor_variaveisCalculadas.sqf BEGIN";

//ACHA CIDADES, AEROPORTOS E MARINAS
_locais = [
	[200,nearestLocations [BRPVP_centroMapa,["NameVillage"],20000]],
	[200,nearestLocations [BRPVP_centroMapa,["NameCity"],20000]],
	[500,nearestLocations [BRPVP_centroMapa,["NameCityCapital"],20000]],
	[400,nearestLocations [BRPVP_centroMapa,["Airport"],20000]]
	//[250,nearestLocations [BRPVP_centroMapa,["NameMarine"],20000]]
];

//CRIA ARRAY COM OS LOCAIS
if (isNil "BRPVP_locaisImportantes") then {
	BRPVP_locaisImportantes = [];
	diag_log "BRPVP_locaisImportantes = [";
	{
		_subLocaisRaio = _x select 0;
		_subLocais = _x select 1;
		{
			_local = _x;
			_localPos = locationPosition _local;
			_localPos set [2,0];
			_localNome = text _local;
			if (_localNome == "") then {_localNome = "Aeroporto";};
			_sobrepoem = false;
			{
				if (_localPos distance (_x select 0) < (_subLocaisRaio max (_x select 1))) exitWith {_sobrepoem = true;};
			} forEach BRPVP_locaisImportantes;
			if (!_sobrepoem) then {
				BRPVP_locaisImportantes pushBack [_localPos,_subLocaisRaio,_localNome,1];
				diag_log ("	" + str [_localPos,_subLocaisRaio,_localNome,1]);
			};
		} forEach _subLocais;
	} forEach _locais;
	diag_log "];";
	BRPVP_respawnPlaces = +BRPVP_locaisImportantes;
	_locais = nil;
};

//ZOMBIES SUPER SPAWN PLACES
_locaisImportantes = +BRPVP_locaisImportantes;
_exclude = +BRPVP_cantBeInfectedCity;
_exclude sort false;
{_locaisImportantes deleteAt _x;} forEach _exclude;
_q = count _locaisImportantes;
_qZ = if (BRPVP_isZombieDay) then {BRPVP_zombieNumberOfSuperSpawnCities max 0 min _q} else {0};
BRPVP_zombieSuperSpawnCities = [];
BRPVP_zombieSuperSpawnCitiesIdx = [];
for "_i" from 1 to _qZ do {
	_idx = floor random count _locaisImportantes;
	_e = _locaisImportantes deleteAt _idx;
	_e set [3,11];
	_houses = [];
	{if !(_x buildingPos -1 isEqualTo []) then {_houses pushBack _x;};} forEach nearestObjects [_e select 0,["House"],_e select 1,true];
	_qh = count _houses;
	_qsc = ((round (_qh/5) min 10) max 2) min _qh;
	for "_c" from 1 to _qsc do {
		_house = selectRandom _houses;
		_sPos = getPosWorld _house findEmptyPosition [0,50,"Land_Suitcase_F"];
		_pos = if (_sPos isEqualTo []) then {selectRandom (_house buildingPos -1)} else {_sPos};
		_suitCase = createVehicle ["Land_Suitcase_F",_pos,[],0,"CAN_COLLIDE"];
		_suitCase setVariable ["mny",500000,true];
		_houses = _houses-[_house];
	};
	_e pushBack "";
	BRPVP_zombieSuperSpawnCities pushBack _e;
	BRPVP_zombieSuperSpawnCitiesIdx pushBack _idx;
};

//ACHA LOCAIS DE CURA E CRIA ARRAY
BRPVP_locaisDeCura = [];
{BRPVP_locaisDeCura pushBack [getPosATL _x,16,"",0];} forEach (nearestObjects [BRPVP_centroMapa,BRPVP_mapaRodando select 1,BRPVP_centroMapaRadius,true]);

//ENVIA CLIENTE
publicVariable "BRPVP_locaisImportantes";
publicVariable "BRPVP_respawnPlaces";
publicVariable "BRPVP_locaisDeCura";
publicVariable "BRPVP_zombieSuperSpawnCities";
publicVariable "BRPVP_zombieSuperSpawnCitiesIdx";

diag_log ("[SCRIPT] servidor_variaveisCalculadas.sqf END: " + str round (diag_tickTime - _scriptStart));