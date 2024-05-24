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

//SIEGE MISSION FUNCTION
BRPVP_besiegedMission = {
	//SELECT SIEGE PLACE
	_lArr = [];
	{
		if (BRPVP_closedCityRunning select _forEachIndex isEqualTo 0) then {
			_lPos = _x select 0;
			_lRad = (((_x select 1) * 0.8) max 200) min 275;
			_safeZoneOverlap = ({(_x select 0) distance _lPos < (_lRad + (_x select 1)) * 1.15} count BRPVP_mercadoresPos) > 0;
			if (!_safeZoneOverlap) then {
				_hasbravo = {_lPos distance _x < _lRad * 1.15} count BRPVP_missPrediosEm > 0;
				if (!_hasBravo) then {
					_inRadioArea = {_lPos distance (_x select 0) <= (_x select 1)+_lRad+30} count BRPVP_radioAreas > 0;
					if (!_inRadioArea) then {
						_pts = 0;
						{_pts = _pts + sqrt(_lPos distance _x);} forEach call BRPVP_playersList;
						_lArr pushBack [_pts^2,_lPos,_lRad,_forEachIndex];
					};
				};
			};
		};
	} forEach BRPVP_locaisImportantes;
	if (count _lArr isEqualTo 0) exitWith {};
	_lArr sort true;
	_local = [_lArr,3] call LOL_fnc_selectRandomFator;
	_lPos = _local select 1;
	_lRad = _local select 2;
	_localIdc = _local select 3;
	BRPVP_closedCityRunning set [_localIdc,1];
	BRPVP_closedCityTime set [_localIdc,time];
	
	//SIEGE BUILDINGS WITH INTERIOR
	_bs = nearestObjects [_lPos,BRPVP_loot_buildings_class,_lRad];

	//GET ROADS AND CROSSROADS
	_rs = _lPos nearRoads _lRad;
	_rsc = [];
	for "_i" from 1 to 3 do {
		if (count _rs > 0) then {
			_tryArray = [selectRandom _rs,selectRandom _rs] apply {
				_try = _x;
				_min = 1000000;
				{_min = _min min (_try distance _x);} forEach _rsc;
				[_min,_try]
			};
			_tryArray sort false;
			_found = _tryArray select 0 select 1;
			_rsc pushBack (_rs deleteAt ( _rs find _found));

		};
	};
	
	//PARA INSERT
	_s = 2 * _lRad/10;
	_onW = 0;
	_onA = 0;
	for "_l" from -5 to 5 do {
		for "_r" from -5 to 5 do {
			_pL = _lPos vectorAdd [_l * _s,_r * _s,0];
			if (_pL distance _lPos <= _lRad) then {
				_onA = _onA + 1;
				if (surfaceIsWater _pL) then {
					_onW = _onW + 1;
				};
			};
		};
	};
	_insPara = _onW/_onA < 0.1;
	_hH = if (_insPara) then {250} else {150};
	
	//SET CHOOPER START AND END POSITION
	_xm = BRPVP_mapaDimensoes select 0;
	_ym = BRPVP_mapaDimensoes select 1;
	_borders = [[0,0,_hH],[_xm/2,0,_hH],[_xm,0,_hH],[_xm,_ym/2,_hH],[_xm,_ym,_hH],[_xm/2,_ym,_hH],[0,_ym,_hH],[0,_ym/2,_hH]];
	_borders = _borders apply {[_x distance _lPos,_x]};
	_borders sort true;
	_start = _borders select 0 select 1;
	_end = _borders select 7 select 1;
	
	//CREATE PILOT
	_grpP = createGroup [WEST,true];
	_pilot = _grpP createUnit [BRPVP_missionWestGroups select 0 select 0,BRPVP_spawnAIFirstPos,[],0,"NONE"];
	[_pilot] joinSilent _grpP;
	_pilot setSkill 0.3;
	_pilot disableAI "TARGET";
	_pilot disableAI "AUTOTARGET";
	_pilot disableAI "AUTOCOMBAT";

	//CREATE CHOPPER
	_dir = [_start,_lPos] call BIS_fnc_dirTo;
	_heli = createVehicle ["B_Heli_Transport_03_F",_start,[],100,"FLY"];
	_heli setPos _start;
	_heli setDir _dir;
	_heli flyInHeight _hH;
	_pilot moveInDriver _heli;
	_pilot assignAsDriver _heli;
	
	//PUT SIEGE SOLDIERS IN CHOOPER CARGO AND SET THEIR OBJECTIVE
	_qp = 3;
	_soldiers = [];
	_grps = [];
	_invsAI = [];
	for "_i" from 1 to _qp do {
		_grp = createGroup [WEST,true];
		_caras = selectRandom BRPVP_missionWestGroups;
		for "_j" from 1 to 4 do {
			_unidade = _grp createUnit [_caras select (_j - 1),BRPVP_spawnAIFirstPos,[],0,"NONE"];
			[_unidade] joinSilent _grp;
			if (_insPara) then {
				_invsAI pushBack [backPack _unidade,backpackItems _unidade];
				removeBackpack _unidade;
			};
			_unidade assignAsCargo _heli;
			_unidade moveInCargo _heli;
			_unidade setSkill (BRPVP_AISkill select 1 select 0);
			_unidade setSkill ["aimingAccuracy",BRPVP_AISkill select 1 select 1];
			_unidade addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_unidade addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			_soldiers pushBack _unidade;
			(BRPVP_closedCityAI select _localIdc) pushBack _unidade;
		};
		_grps pushBack _grp;
		uiSleep BRPVP_simpleMissSpawnWait;
	};
	
	//CHOOPER PATH: INSERTION
	_wp = _grpP addWayPoint [_lpos vectorAdd [0,0,_hH],0];
	_wp setWayPointType "MOVE";
	_wp setWayPointSpeed "FULL";

	waitUntil {_heli distance2D _lPos < 1000 || !canMove _heli};
	if (!canMove _heli) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};

	//CHG
	remoteExecCall ["BRPVP_AIRemoveNull",2];
	(_soldiers+[_pilot]) remoteExecCall ["BRPVP_updateAIUnitsArray",2];
	BRPVP_smallMissionsAIObjs append (_soldiers+[_pilot]);

	[_bs select 0,"sirene",1250] remoteExecCall ["BRPVP_tocaSom",0];

	waitUntil {currentWayPoint _grpP isEqualTo 2 || !canMove _heli};
	if (!canMove _heli) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};
	if (_insPara) then {
		_h = [];
		{_h pushBack (100 + (_forEachIndex * 10) mod 110);} forEach _soldiers;
		[_soldiers,_h,_invsAI] spawn {
			params ["_soldiers","_h","_invsAI"];
			_cnt = count _soldiers;
			_okPara = [];
			_okGround = [];
			waitUntil {
				{
					_unit = _x;
					if !(_unit in _okPara) then {
						if ((getPosATL _unit) select 2 <= _h select _forEachIndex) then {
							_unit addBackpack "B_Parachute";
							_okPara pushBack _unit;
						};
					};
					if !(_unit in _okGround) then {if (vehicle _unit isEqualTo _unit) then {_okGround pushBack _unit;};};
				} forEach _soldiers;
				count _okPara isEqualTo _cnt && count _okGround isEqualTo _cnt
			};
			{
				_backPack = _invsAI select _forEachIndex select 0;
				if (_backPack != "" && alive _x) then {
					_items = _invsAI select _forEachIndex select 1;
					_x addBackPack _backPack;
					[backPackContainer _x,_items] call BRPVP_addLootSv;
				};
			} forEach _soldiers;
		};
		{
			unassignVehicle _x;
			moveOut _x;
			[_x] allowGetIn false;
			_x setDir ([_x,_heli] call BIS_fnc_dirTo);
			sleep (0.3 + random 0.2);
			if (!canMove _heli) exitWith {};
		} forEach _soldiers;
		if (!canMove _heli) exitWith {};
		sleep 2.5;
		
		_wp = _grpP addWayPoint [_end,0];
		_wp setWayPointType "MOVE";
		_wp setWayPointSpeed "FULL";
	} else {
		_wp = _grpP addWayPoint [_lpos,0];
		_wp setWayPointType "TR UNLOAD";
		_wp setWayPointSpeed "FULL";

		waitUntil {currentWayPoint _grpP isEqualTo 3 || !canMove _heli};
		if (!canMove _heli) exitWith {};
		_wp = _grpP addWayPoint [_end,0];
		_wp setWayPointType "MOVE";
		_wp setWayPointSpeed "FULL";
	};
	if (!canMove _heli) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};
	
	//TOWERS
	_twq = count _rsc;
	_towers = [];
	{
		_tw = createVehicle [BRPVP_towas call BIS_fnc_selectRandom,getPosATL _x,[],0,"CAN_COLLIDE"];
		_tw setDir getDir _x;
		(BRPVP_closedCityObjs select _localIdc) pushBack _tw;
		_tw setVariable ["brpvp_yes_minerva",true,true];
		_towers pushBack _tw;
	} forEach _rsc;

	//SELECT PROTECTED BUILDINGS
	_buAllPosN = [];
	_bus = [];
	for "_i" from 1 to _qp do {
		private ["_buAllPos","_bu"];
		_inTower = count _towers > 0;
		if (_inTower) then {
			_twi = (_i - 1) mod count _towers;
			_bu = _towers select _twi;
			_towers deleteAt _twi;
			_buAllPos = _bu buildingPos -1;
		} else {
			if (count _bs > 0) then {
				_bu = _bs select (((_i - 1) + floor random 3) mod count _bs);
				_buAllPos = _bu buildingPos -1;
			} else {
				_fkPos = _lPos vectorAdd [-10 + random 20,-10 + random 20,0];
				_bu = createVehicle ["Land_cargo_house_slum_F",_fkPos,[],0,"NONE"];
				(BRPVP_closedCityObjs select _localIdc) pushBack _bu;
				_buAllPos = [_lPos vectorAdd [-10 + random 20,-10 + random 20,0]];
			};
		};
		_buAllPosN pushBack _buAllPos;
		_bus pushBack ASLToAGL getPosASL _bu;
	};

	//INSERTED SOLDIERS TO POSITION
	{
		_grp = _grps select _forEachIndex;
		_angle = random 360;

		_wp = _grp addWaypoint [_x,0];
		_wp setWaypointCompletionRadius 25;
		_wp setWayPointType "MOVE";

		_wp1 = _grp addWaypoint [[_lPos,_lRad*0.65,_angle] call BIS_fnc_relPos,0];
		_wp1 setWaypointCompletionRadius 25;
		_wp1 setWayPointType "MOVE";

		_wp2 = _grp addWaypoint [[_lPos,_lRad*0.65,_angle+180] call BIS_fnc_relPos,0];
		_wp2 setWaypointCompletionRadius 25;
		_wp2 setWayPointType "MOVE";

		_wp3 = _grp addWaypoint [_x,0];
		_wp3 setWaypointCompletionRadius 25;
		_wp3 setWayPointType "CYCLE";
	} forEach _bus;

	//SIEGE START MESSAGE
	_qtS = count _soldiers;
	_lRadSqr = (_lRad^2) * 0.95;
	_init = time;
	_aliveQt = 0;
	waitUntil {
		_qt = {_x distanceSqr _lPos < _lRadSqr} count _soldiers;
		_aliveQt = {alive _x} count _soldiers;
		_qt >= round (_qtS * 0.8) || time - _init > 240 || _aliveQt < round (_qtS * 0.5)
	};
	_wOpenPerc = if (time - _init > 240) then {0.65} else {0.9};
	if (_aliveQt < round (_qtS * 0.5)) exitWith {BRPVP_closedCityRunning set [_localIdc,3];};
	_lName = BRPVP_locaisImportantes select _localIdc select 2;
	[["str_is_on_siege",[_lName]],5,15,0,"batida"] remoteExecCall ["BRPVP_hint",0];

	//SIEGE WALLS
	_step = 360/((2 * pi * _lRad)/5.8);
	_an = random 360;
	_qs = ceil (0.065 * 360/_step);
	_ae = _an + 360;
	_cnt = 0;
	_ini = time;
	_woa = [];
	_vua = [0,0,1];
	_wp0 = _lPos vectorAdd [_lRad * sin(_an - _step * 0.99),_lRad * cos(_an - _step * 0.99),0];
	_wp1 = _lPos vectorAdd [_lRad * sin(_an),_lRad * cos(_an),0];
	_vu0 = surfaceNormal _wp0;
	_vu1 = surfaceNormal _wp1;
	_err = _step * ((random 0.02) - 0.01);
	_fail = 0;
	_turrs = [];
	_w = objNull;
	[_w,"constructing",1400] remoteExecCall ["BRPVP_tocaSom",0];
	while {_an <= _ae} do {
		_wp2 = _lPos vectorAdd [_lRad * sin(_an + _step + _err),_lRad * cos(_an + _step + _err),0];
		if (_err >= 0) then {
			_err = _err - random (_step * 0.01 + _err);
		} else {
			_err = random (_step * 0.01 - _err) - _err;
		};
		_vu2 = surfaceNormal _wp2;
		_onWater = surfaceIsWater _wp1;
		if (!_onWater) then {
			_i1 = lineIntersectsSurfaces [(ATLToASL _wp0) vectorAdd [0,0,0.5],(ATLToASL _wp2) vectorAdd [0,0,0.5],_w,objNull,true,1,"GEOM","NONE"];
			_i2 = lineIntersectsSurfaces [(ATLToASL _wp2) vectorAdd [0,0,1.5],(ATLToASL _wp0) vectorAdd [0,0,1.5],_w,objNull,true,1,"GEOM","NONE"];
			_i1 append _i2;
			_inportant = false;
			if (count _i1 > 0) then {
				{
					_o = _x select 2;
					if (typeName _o == "OBJECT") then {
						if (_o call BRPVP_isMotorized || _o call BRPVP_isBuilding) exitWith {
							_inportant = true;
						};
					};
					if (_inportant) exitWith {};
				} forEach _i1;
			};
			_onRoad = isOnRoad _wp1;
			if (count _i1 isEqualTo 0 || (count _i1 > 0 && !_inportant)) then {
				if (!_onRoad) then {
					if (random 1 < _wOpenPerc) then {
						_wd = [_wp1,_lPos] call BIS_fnc_dirTo;
						_vu = vectorNormalized ((_vu0 vectorAdd _vu1) vectorAdd _vu2);
						_w = createSimpleObject ["A3\Structures_F\Walls\CncWall4_F.p3d",AGLToASL BRPVP_posicaoFora];
						_w setDir (_wd - 2.5 + random 5);
						_w setPosATL (_wp1 vectorAdd [0,0,0]);
						_w setVectorUp _vu;
						_woa pushBack _w;
					} else {
						_fail = _fail + 1;
					};
				} else {
					if (!isOnRoad _wp0 && !isOnRoad _wp2) then {
						//_turrs pushBack _wp1;
					};
				};
			} else {
				_fail = _fail + 1;
			};
		};
		if (!_onWater) then {
			sleep ((1.5/_qs) * ((_cnt/_qs) * 2));
		};
		if (_cnt isEqualTo _qs) then {
			_cnt = 0;
			[_w,"constructing",1400] remoteExecCall ["BRPVP_tocaSom",0];
		};
		if (!_onWater) then {_cnt = _cnt + 1;};
		_an = _an + _step;
		_wp0 = _wp1;
		_wp1 = _wp2;
		_vu0 = _vu1;
		_vu1 = _vu2;	
	};
	_cntT = 4;
	_wallTurreters = [];
	while {count _turrs > 0 && _cntT > 0} do {
		_it = floor random count _turrs;
		_tp = _turrs deleteAt _it;
		_turr = createVehicle ["T_TURR_F",_tp,[],0.5,"CAN_COLLIDE"];
		_turr setDir ([_lPos,_tp] call BIS_fnc_dirTo);
		_grpt = createGroup [WEST,true];
		_unidade = _grpt createUnit [_caras call BIS_fnc_selectRandom,BRPVP_spawnAIFirstPos,[],0,"NONE"];
		[_unidade] joinSilent _grpt;
		_unidade setSkill 0.25;
		_unidade assignAsGunner _turr;
		_unidade moveInGunner _turr;
		_wallTurreters pushBack _unidade;
		_cntT = _cntT - 1;
	};
	if !(_cnt mod _qs isEqualTo 0) then {
		[_w,"constructing",800] remoteExecCall ["BRPVP_tocaSom",0];
	};
	BRPVP_closedCityWalls set [_localIdc,_woa];
	
	//ROAD OBJECTS
	_objsAll = [
		"Land_HBarrierTower_F",
		"Land_HBarrierWall_corner_F",
		"Land_HBarrierWall_corridor_F",
		"Land_HBarrierWall4_F",
		"Land_Wreck_HMMWV_F",
		"Land_Wreck_BRDM2_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Long_F",
		"Land_BagBunker_Tower_F",
		"Land_ConcretePipe_F"
	];
	_cnt = 0;
	while {_cnt < _twq * 3 && count _rs > 0} do {
		(_rs call LOL_fnc_selectRandomIdx) params ["_r","_i"];
		_rs deleteAt _i;
		_rp = getPosASL _r;
		_objs = nearestObjects [ASLToAGL _rp,["LandVehicle","Air","Ship","Building","House","Wall"],10];
		_oPly = {if (_x getVariable ["id_bd",-1] != -1) then {true} else {false};} count _objs;
		if (_oPly isEqualTo 0) then {
			_rs = _rs - (roadsConnectedTo _r);
			_ob = createSimpleObject [_objsAll select (floor random count _objsAll),_rp];
			_ob setDir ([getPosASL _r,getPosASL ((roadsConnectedTo _r) select 0)] call BIS_fnc_dirTo);
			_ob setVectorUp surfaceNormal getPosATL _ob;
			(BRPVP_closedCityObjs select _localIdc) pushBack _ob;
			_cnt = _cnt + 1;
		};
	};

	//CREATE LOOT
	_moneyBoxValor = (BRPVP_mapaRodando select 19 select 2)/_qp;
	_itemBoxValor = (BRPVP_mapaRodando select 19 select 3)/_qp;
	_allBox = [];
	
	//PUT MONEY BOX
	for "_i" from 1 to _qp do {
		//CREATE BOX
		_lootPos = _bus select (_i - 1);
		_caixa = createVehicle ["Box_IND_Wps_F",[_lootPos,5,random 360] call BIS_fnc_relPos,[],0,"NONE"];
		_caixa allowDamage false;
		_caixa setDir random 360;
		_allBox pushBack _caixa;
		
		//CLEAR BOX
		clearMagazineCargoGlobal _caixa;
		clearWeaponCargoGlobal _caixa;
		clearItemCargoGlobal _caixa;
		clearBackpackCargoGlobal _caixa;
		
		//PUT MONEY
		{_caixa addMagazineCargoGlobal [_x,1];} forEach (round (_moneyBoxValor*BRPVP_missionValueMult) call BRPVP_itemMoneyCreate);
	};

	//PUT ITEM BOXS
	for "_i" from 1 to _qp do {
		//CREATE BOX
		_lootPos = _bus select (_i - 1);
		_caixa = createVehicle ["Box_IND_Wps_F",[_lootPos,5,random 360] call BIS_fnc_relPos,[],0,"NONE"];
		_caixa allowDamage false;
		_caixa setDir random 360;
		_allBox pushBack _caixa;
		[_caixa,_itemBoxValor,selectRandom [4,5,6],true,10,1] call BRPVP_createCompleteLootBox;
	};

	//SET SIEGE STATE TO COMPLETED
	BRPVP_closedCityRunning set [_localIdc,2];
	BRPVP_closedCityRunning remoteExecCall ["BRPVP_closedCityRunningSet",0];

	//SET BOXES TO DELETE WHEN EMPTY
	{_x setVariable ["brpvp_del_when_empty",true,true]} forEach _allBox;

	//SET BOTS TO VERIFY WHEN OPENING THE BOX
	{_x setVariable ["brpvp_mbots",[_lPos,_lRad+100,_soldiers],true];} forEach _allBox;

	//DELETE RETURNED CHOOPER AND PILOT
	_wif = if (_insPara) then {3} else {4};
	waitUntil {currentWayPoint _grpP isEqualTo _wif || !alive _heli || !alive _pilot};
	if (alive _pilot && alive _heli) then {
		deleteVehicle _heli;
		deleteVehicle _pilot;
	};

	diag_log ("[BRPVP SIEGE] City "+str _localIdc+" siege start script finished!");
};