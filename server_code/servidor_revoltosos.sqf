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
diag_log "[SCRIPT] servidor_revoltosos.sqf BEGIN";

_revoltosos = [];
_revWeps = [
	["arifle_MX_F","30Rnd_65x39_caseless_mag_Tracer",4],
	["SMG_02_F","30Rnd_9x21_Mag",4],
	["LMG_Zafir_pointer_F","150Rnd_762x54_Box_Tracer",2],
	["srifle_EBR_ACO_F","20Rnd_762x51_Mag",3],
	["hgun_Pistol_heavy_02_F","6Rnd_45ACP_Cylinder",5]
];
//REVOLTOSOS GENERAL
if (BRPVP_mapaRodando select 7 select 0) then {
	_buildings = [];
	{_buildings append (BRPVP_centroMapa nearObjects [_x,BRPVP_centroMapaRadius]);} forEach BRPVP_revoltersBuildings;
	for "_i" from 1 to (BRPVP_mapaRodando select 7 select 1) do {
		_house = objNull;
		while {isNull _house} do {
			_try = selectRandom _buildings;
			if (_try getVariable ["id_bd",-1] isEqualTo -1) then {_house = _try;};
		};
		_grupo = createGroup [INDEPENDENT,true];
		_revoltoso = _grupo createUnit ["C_man_p_beggar_F",BRPVP_spawnAIFirstPos,[],20,"CAN_COLLIDE"];
		[_revoltoso] joinSilent _grupo;
		_revoltoso addBackpack "B_Carryall_cbr";
		_revBp = unitBackpack _revoltoso;
		_revWep = selectRandom _revWeps;
		_revBp addMagazineCargoGlobal [_revWep select 1,_revWep select 2];
		_revoltoso addWeapon (_revWep select 0);
		_revoltoso addEventHandler ["Killed",{
			if (random 1 < 0.75) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (250000*BRPVP_missionValueMult),true];};
			call BRPVP_botDaExp;
		}];
		_revoltoso addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
		_revoltoso setPos selectRandom (_house buildingPos -1);
		_revoltoso setSkill (BRPVP_AISkill select 4 select 0);
		_revoltoso setSkill ["aimingAccuracy",BRPVP_AISkill select 4 select 1];
		_angulo = random 360;
		_revoltoso setDir _angulo;
		_revoltosos pushBack _revoltoso;
	};
};
//REVOLTOSOS MILITAR
if (BRPVP_mapaRodando select 8 select 0) then {
	_milPlacesBuildings = [];
	_usedIndexs = [];
	for "_i" from 1 to (BRPVP_mapaRodando select 8 select 1) do {
		private ["_buildings"];

		//SELECT MILITAR AREA
		_sum = 0;
		{_sum = _sum + (_x select 2);} forEach BRPVP_militarBuildingsMarker;
		_random = random _sum;
		_index = -1;
		_sumSelect = 0;
		{
			_sumSelect = _sumSelect + (_x select 2);
			if (_sumSelect > _random) exitWith {_index = _forEachIndex;};
		} forEach BRPVP_militarBuildingsMarker;
		_found = _usedIndexs find _index;
		if (_found isEqualTo -1) then {
			_center = BRPVP_militarBuildingsMarker select _index select 0;
			_radius = BRPVP_militarBuildingsMarker select _index select 1;
			_buildings = nearestObjects [_center,BRPVP_cantBuildNearBuildings,_radius,true];
			_usedIndexs pushBack _index;
			_milPlacesBuildings pushBack _buildings;
		} else {
			_buildings = _milPlacesBuildings select _found;
		};
		_house1 = selectRandom _buildings;
		_house2_1 = selectRandom _buildings;
		_house2_2 = selectRandom _buildings;
		_house2 = if (_house2_1 distanceSqr _house1 > _house2_2 distanceSqr _house1) then {_house2_1} else {_house2_2};

		//SPAWN AI
		_grupo = createGroup [INDEPENDENT,true];
		_revoltoso = _grupo createUnit ["C_man_p_beggar_F",ASLToAGL getPosASL _house1,[],10,"NONE"];
		[_revoltoso] joinSilent _grupo;
		removeUniform _revoltoso;
		_uniform = selectRandom ["U_C_man_sport_1_F","U_C_man_sport_2_F","U_C_man_sport_3_F","U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_C_Man_casual_6_F","U_C_Journalist"];
		_revoltoso addUniform _uniform;
		_revoltoso addBackpack selectRandom ["B_Carryall_cbr","B_Carryall_cbr","B_Carryall_cbr","B_Carryall_cbr","B_Messenger_Gray_F","B_Messenger_Coyote_F"];
		_revBp = unitBackpack _revoltoso;
		_revWep = selectRandom _revWeps;
		_revBp addMagazineCargoGlobal [_revWep select 1,_revWep select 2];
		_revoltoso addWeapon (_revWep select 0);
		_revoltoso addEventHandler ["Killed",{
			if (random 1 < 0.5) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (50000*BRPVP_missionValueMult),true];};
			call BRPVP_botDaExp;
		}];
		_revoltoso addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
		_revoltoso setSkill (BRPVP_AISkill select 5 select 0);
		_revoltoso setSkill ["aimingAccuracy",BRPVP_AISkill select 5 select 1];
		_angulo = random 360;
		_revoltoso setDir _angulo;
		
		//SET AI MOVEMENT
		if !(_house2 isEqualTo _house1) then {
			_wp0 = _grupo addWaypoint [ASLToAGL getPosASL _house1,0];
			_wp0 setWaypointCompletionRadius 10;
			_wp0 setWayPointType "MOVE";
			_wp1 = _grupo addWaypoint [ASLToAGL getPosASL _house2,0];
			_wp1 setWaypointCompletionRadius 10;
			_wp1 setWayPointType "MOVE";
			_wp2 = _grupo addWaypoint [ASLToAGL getPosASL _house1,0];
			_wp2 setWaypointCompletionRadius 10;
			_wp2 setWayPointType "CYCLE";
		};
		
		_revoltosos pushBack _revoltoso;
	};
};
//CHG
_revoltosos remoteExecCall ["BRPVP_updateAIUnitsArray",2];

diag_log ("[SCRIPT] servidor_revoltosos.sqf END: "+str round (diag_tickTime-_scriptStart));