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

//FARM CODE
BRPVP_farmingActionOn = false;
BRPVP_farmDo = {
	if (!BRPVP_farmingActionOn) then {
		private ["_result"];
		_farmLine = [];
		_lis = lineIntersectsSurfaces [eyePos player,eyePos player vectorAdd (getCameraViewDirection player vectorMultiply 2.5),player];
		_lookingAt = if (_lis isEqualTo []) then {objNull} else {_lis select 0 select 2};
		{
			_result = call (_x select 3);
			if (_result select 0) exitWith {_farmLine = +_x;};
		} forEach BRPVP_farms;
		if (_farmline isEqualTo []) then {
			[localize "str_nothing_to_farm",-4] call BRPVP_hint;
			"erro" call BRPVP_playSound;
		} else {
			if !(_result select 3 isEqualTo []) then {
				_farmLine set [0,_result select 3 select 0];
				_farmLine set [1,_result select 3 select 1];
			};
			_obj = _result select 1;
			_equipment = _farmLine select 2;
			_qIn = (BRPVP_specialItems find _equipment) call BRPVP_sitCountItem;
			if (_qIn > 0 || _equipment isEqualTo "") then {
				if (true || currentWeapon player isEqualTo "") then {
					_chance = +(_result select 2);
					_chance sort false;
					_uPrice = _result select 4;
					_priceMax = (_chance select 0)*_uPrice;
					_mny = player getVariable ["mny",0];
					_haveCost = _uPrice > 0;
					if (_mny >= _priceMax || !_haveCost) then {
						BRPVP_farmingActionOn = true;
						private _qiMult = if (count _farmLine < 6) then {1} else {round (_farmLine select 5)};
						_qItems = _qiMult*selectRandom _chance;
						if (_haveCost) then {
							_price = _qItems*_uPrice;
							player setVariable ["mny",_mny-_price,true];
							"negocio" call BRPVP_playSound;
							call BRPVP_atualizaDebug;
						};
						if (_equipment isNotEqualTo "") then {
							_bulletsRemove = ceil (_qItems/2);
							[BRPVP_specialItems find _equipment,_bulletsRemove min _qIn] call BRPVP_sitRemoveItem;
						};
						[_farmLine,_obj,_qItems,_result select 5] spawn {
							_equipment = _this select 0 select 2;
							_snd = if (_equipment isEqualTo "") then {"digging"} else {_equipment};
							_sounder = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],10,"CAN_COLLIDE"];
							_sounder attachTo [player,[0,0,0]];
							[_sounder,[_snd,250]] remoteExecCall ["say3D",BRPVP_allNoServer];
							_pos = ASLToAGL getPosASL player;
							_init = time;
							_initSnd = time;
							_qItems = _this select 2;
							_wait = BRPVP_farmAndCraftTime;
							_waitSnd = 5;
							{if (_equipment isEqualTo (_x select 0)) exitWith {_waitSnd = _x select 1;};} forEach BRPVP_farmEquipTimes;
							waitUntil {
								_posNow = ASLToAGL getPosASL player;
								if (time-_initSnd > _waitSnd) then {
									[_sounder,[_snd,250]] remoteExecCall ["say3D",BRPVP_allNoServer];
									_initSnd = time;
								};
								(false && currentWeapon player != "") || _pos distance _posNow > 3 || !(player call BRPVP_pAlive) || time-_init > _wait
							};
							_sounder setDamage 1;
							detach _sounder;
							deleteVehicle _sounder;
							if ((true || currentWeapon player isEqualTo "") && _pos distance (ASLToAGL getPosASL player) <= 3 && player call BRPVP_pAlive) then {
								_rewardClass = _this select 0 select 0;
								_rewardChance = _this select 0 select 1;
								_sum = 0;
								{_sum = _sum+_x;} forEach _rewardChance;
								_selected = [];
								for "_i" from 1 to _qItems do {
									_rnd = random _sum;
									_sum = 0;
									{
										_sum = _sum+_x;
										if (_sum > _rnd) exitWith {_selected pushBack (_rewardClass select _forEachIndex);};
									} forEach _rewardChance;
								};							
								_selected call BRPVP_sitAddItemList;
								if !(random 1 < BRPVP_farmDoubleChance) then {
									_obj = _this select 1;
									_obj hideObject true;
									[_obj,true] remoteExecCall ["hideObjectGlobal",2];
									_delay = _this select 3;
									if (_delay > -1) then {[_obj,_delay] remoteExecCall ["BRPVP_farmObjShowTime",2];};
								};
								private _ecTxt = "";
								if (_equipment isNotEqualTo "") then {
									private _idx = BRPVP_specialItems find _equipment;
									private _eName = BRPVP_specialItemsNames select _idx;
									private _eQttNow = _idx call BRPVP_sitCountItem;
									_ecTxt = format [" (%1 X %2)",_eName,_eQttNow];
								};
								private _itemsTxt = [];
								private _itemsQtt = [];
								{
									_x params ["_name","_pic"];
									private _newTxt = format ["<img color='#FFFFFF' size='1.5' image='%1'/><t color='#DD4040'> %2",BRPVP_imagePrefix+_pic,_name];
									private _idx = _itemsTxt find _newTxt;
									if (_idx isEqualTo -1) then {
										_itemsTxt pushBack _newTxt;
										_itemsQtt pushBack 1;
									} else {
										_itemsQtt set [_idx,(_itemsQtt select _idx)+1];
									};
								} forEach (_selected apply {[BRPVP_specialItemsNames select (BRPVP_specialItems find _x),BRPVP_specialItemsImages select (BRPVP_specialItems find _x)]});
								private _txt = "";
								{_txt = format ["%1<br />%2 (X%3)</t>",_txt,_x,_itemsQtt select _forEachIndex];} forEach _itemsTxt;
								[format [localize "str_farm_reward",_ecTxt+_txt],-6] call BRPVP_hint;
								"BRPVP_farming_ok" call BRPVP_playSound;
								[["farm_craft",1]] call BRPVP_mudaExp;
							} else {
								"BRPVP_farming_fail" call BRPVP_playSound;
							};
							BRPVP_farmingActionOn = false;
						};
					} else {
						[localize "str_bury_money_need_wallet_money",-6] call BRPVP_hint;
					};
				} else {
					"erro" call BRPVP_playSound;
					[localize "str_cant_farm_weapon",-6] call BRPVP_hint;
				};
			} else {
				_name = BRPVP_specialItemsNames select (BRPVP_specialItems find _equipment);
				_objType = _farmLine select 4;
				[format [localize "str_farm_you_need_equip",_name,_objType],-5] call BRPVP_hint;
			};
		};
	};
};

//FARM CHECKS
BRPVP_checkIfSand = {
	_pATL = getPosATL player;
	[surfaceType _pATL in _this && _pATL select 2 <= 0.25,objNull,BRPVP_farmRewardNumberItems,[],0,-1]
};
BRPVP_checkIfObjIs = {
	private ["_names","_chance","_canBaseItem"];
	if (_this select 0 isEqualType "") then {
		_names = _this;
		_chance = BRPVP_farmRewardNumberItems;
		_canBaseItem = false;
	} else {
		if (_this select 0 isEqualType {}) then {
			_names = _this;
			_chance = BRPVP_farmRewardNumberItems;
			_canBaseItem = true;
		} else {
			_names = _this select 0;
			_chance = _this select 1;
			_canBaseItem = false;
		};
	};
	_obj = _lookingAt;
	if (isNull _obj || {_obj getVariable ["id_bd",-1] > -1 && !_canBaseItem}) then {
		[false,objNull,_chance]
	} else {
		_str = str _obj;
		_is = false;
		{
			private _check = _x;
			if (_check isEqualType "" && {_str find _check > -1}) exitWith {_is = true;};
			if (_check isEqualType {} && {_obj call _check}) exitWith {_is = true;};
		} forEach _names;
		[_is,_obj,_chance,[],0,-1]
	};
};
BRPVP_checkIfObjIsStone = {
	_obj = _lookingAt;
	if (isNull _obj || {_obj getVariable ["id_bd",-1] > -1}) then {
		[false,objNull,BRPVP_farmRewardNumberItems]
	} else {
		_str = str _obj;
		_is = false;
		_chance = [];
		{
			if (_str find (_x select 0) > -1) exitWith {
				_is = true;
				_chance = _x select 1;
			};
		} forEach BRPVP_farmCustomCfg;
		_mine = [];
		_money = 0;
		_delay = -1;
		{
			if (player distance2D (_x select 1) < _x select 2) exitWith {
				_mine = [_x select 3,_x select 4];
				_money = _x select 5;
			};
		} forEach BRPVP_farmSpecialAreasOre;
		if (_mine isEqualTo [] && {player distance2D (_x select 0) < _x select 1} count BRPVP_farmPrivateMines > 0) then {
			_mine = BRPVP_privateMineOres;
			_money = BRPVP_farmPrivateItemPrice;
			_delay = 600;
		};
		[_is,_obj,_chance,_mine,_money,_delay]
	};
};
BRPVP_farmEquipTimes = [
	["",5.7],
	["BRPVP_equip_axe",7.2],
	["BRPVP_equip_pickaxe",5.6],
	["BRPVP_equip_cutter",9],
	["BRPVP_equip_shovel",7.5]
];
BRPVP_farmMaterial = [
	"BRPVP_material_seam_kit",
	"BRPVP_material_welder",
	"BRPVP_material_bolt_nail"	
];

//CRAFT CODE
BRPVP_craftDo = {
	if (!BRPVP_craftingActionOn) then {
		if (true || currentWeapon player isEqualTo "") then {
			BRPVP_menuVar1 = _this;
			BRPVP_menuVar2 = "";
			122 call BRPVP_iniciaMenuExtra;
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_cant_craft_weapon",-6] call BRPVP_hint;
		};
	};
};

//CRAFTS
BRPVP_craftingActionOn = false;
BRPVP_craftMachines = [
	"Land_WoodenCounter_01_F"
];
BRPVP_craftMachinesNiceName = [
	localize "str_brpvp_machines_workbench_displayname"
];