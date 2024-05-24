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

_foodCount = 0;
_spawnLoot = {
	params ["_obj","_items"];
	_dirSeed = round getDir _obj;
	_allBPos = count (_obj buildingPos -1);
	_count = 0;
	{
		_foodCount = _foodCount+1;
		_spawnPosIdx = (_dirSeed+_count) mod _allBPos;
		_spawnPos = ASLToATL AGLToASL (_obj buildingPos _spawnPosIdx);
		_holder = createVehicle ["GroundWeaponHolder",_spawnPos,[],0,"CAN_COLLIDE"];
		_holder setPosATL _spawnPos;
		_holder setVariable ["ml_takes",0,true];
		_itemsAllJoined = _x;
		if (_foodCount mod BRPVP_foodCycle isEqualTo 0) then {for "_i" from 1 to selectRandom [1,2] do {_itemsAllJoined pushBack selectRandom BRPVP_foodClassArray;};};
		if (random 1 < 0.05) then {_itemsAllJoined pushBack "Mag_BRPVP_fuel_gallon";};
		if (random 1 < 0.05) then {_itemsAllJoined pushBack "BRPVP_foodEnergyDrink";};
		[_holder,_itemsAllJoined] call BRPVP_addLoot;
		_count = _count + 1;
	} forEach _items;
	BRPVP_lootActiveAdd = [_obj,count _items];
	publicVariableServer "BRPVP_lootActiveAdd";
};
_getLootType = {
	if (BRPVP_lootBuildingsWeak find _this > -1) then {
		3
	} else {
		if (BRPVP_lootBuildingsAverage find _this > -1) then {
			2
		} else {
			if (BRPVP_lootBuildingsGood find _this > -1) then {
				1
			} else {
				0
			};
		};
	};
};
_getLootItems = {
	params ["_typeOf","_lootType"];
	private ["_itemsList","_qnt1","_qnt2","_weps","_chanceWep","_wepsSuper","_chanceWepSuper","_idx"];
	if (_lootType isEqualTo 3) then {
		if (random 1 < 0.2) then {
			_itemsList = BRPVP_lootClassesWeak+BRPVP_lootClassesAverage;
			_qnt2 = selectRandom (BRPVP_lootCasesNumber select 1);
		} else {
			_itemsList = BRPVP_lootClassesWeak;
			_qnt2 = selectRandom (BRPVP_lootCasesNumber select 0);
		};
		_weps = BRPVP_lootClassWeaponsWeak;
		_chanceWep = BRPVP_lootClassWeaponsChance select 0 select 1;
		_wepsSuper = BRPVP_lootClassWeaponsAverage;
		_chanceWepSuper = BRPVP_lootClassWeaponsChance select 0 select 0;
	} else {
		if (_lootType isEqualTo 2) then {
			if (random 1 < 0.2) then {
				_itemsList = BRPVP_lootClassesAverage+BRPVP_lootClassesGood;
				_qnt2 = selectRandom (BRPVP_lootCasesNumber select 2);
			} else {
				_itemsList = BRPVP_lootClassesAverage;	
				_qnt2 = selectRandom (BRPVP_lootCasesNumber select 1);
			};
			_weps = BRPVP_lootClassWeaponsAverage;
			_chanceWep = BRPVP_lootClassWeaponsChance select 1 select 1;
			_wepsSuper = BRPVP_lootClassWeaponsGood;
			_chanceWepSuper = BRPVP_lootClassWeaponsChance select 1 select 0;
		} else {
			if (_lootType isEqualTo 1) then {
				if (random 1 < 0.1) then {
					_itemsList = BRPVP_lootClassesGood+BRPVP_lootClassesAboveGood;
					_qnt2 = selectRandom (BRPVP_lootCasesNumber select 2);
				} else {
					_itemsList = BRPVP_lootClassesGood;
					_qnt2 = selectRandom (BRPVP_lootCasesNumber select 2);
				};
				_weps = BRPVP_lootClassWeaponsGood;
				_chanceWep = BRPVP_lootClassWeaponsChance select 2 select 1;
				_wepsSuper = BRPVP_lootClassWeaponsAboveGood;
				_chanceWepSuper = BRPVP_lootClassWeaponsChance select 2 select 0;
			};
		};
	};
	_idx = BRPVP_lootRepeatClass find _typeOf;
	_qnt1 = if (_idx isEqualTo -1) then {1} else {BRPVP_lootRepeatQnt select _idx};
	_selectedAll = [];
	for "_o" from 1 to _qnt1 do {
		_selected = [];
		for "_i" from 1 to _qnt2 do {_selected pushBack selectRandom _itemsList;};
		_selectedAll pushBack _selected;
	};
	if (random 1 < _chanceWepSuper) then {(_selectedAll select 0) append selectRandom _wepsSuper;} else {if (random 1 < _chanceWep) then {(_selectedAll select 0) append selectRandom _weps;};};
	_selectedAll
};
_ini = time;
waitUntil {
	_time = time;
	if (_time-_ini > 1) then {
		_ini = _time;
		if (isNull objectParent player) then {
			_building = objNull;
			_ePos = eyePos player;
			_front = _ePos vectorAdd (getCameraViewDirection player vectorMultiply BRPVP_distanceToSpawnLoot);
			_result = lineIntersectsSurfaces [_ePos,_front,player,objNull,true,1,"GEOM","NONE"];
			if (count _result > 0 && {(_result select 0 select 2) isKindOf "House"}) then {
				_building = _result select 0 select 2;
			} else {
				_pos = getPosWorld player;
				_result = lineIntersectsSurfaces [_front,_front vectorAdd [0,0,-10],player,objNull,true,1,"GEOM","NONE"];
				if (count _result > 0 && {(_result select 0 select 2) isKindOf "House"}) then {
					_building = _result select 0 select 2;
				} else {
					_result = lineIntersectsSurfaces [_front,_front vectorAdd [0,0,10],player,objNull,false,1,"GEOM","NONE"];
					if (count _result > 0 && {(_result select 0 select 2) isKindOf "House"}) then {_building = _result select 0 select 2;};
				};
			};
			if (!isNull _building && {_building getVariable ["brpvp_can_loot",true] && _building getVariable ["id_bd",-1] isEqualTo -1 && !isSimpleobject _building}) then {
				_bUsed = _building getVariable ["ml_lock_until",-1];
				if (_bUsed isEqualto -1) then {
					_typeOf = typeOf _building;
					_lootType = _typeOf call _getLootType;
					if (_lootType > 0) then {
						_building setVariable ["ml_lock_until",0,true];
						[_building,[_typeOf,_lootType] call _getLootItems] call _spawnLoot;
					};
				};
			};
		};
	};
	false
};