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

BRPVP_specialForcesRunCode = {
	_place = [];
	_placesTry = [];
	_wc = 0;
	_wcf = 0;
	private _itw = diag_tickTime;
	while {_wc < 50 && _wcf < 5 && count _placesTry < 5} do {
		private _placeTry = [BRPVP_centroMapa,0,BRPVP_centroMapaRadius,20,0,0.25,0,[],[[0,0],[0,0]]] call BIS_fnc_findSafePos;
		private _found = false;
		if (_placeTry isEqualTo [0,0,0]) then {
			_wc = _wc+1;
			_wcf = _wcf+1;
			diag_log "[SPEC FORCES FIND POSITION] [0,0,0]";
		} else {
			_placeTry pushBack 0;
			private _flags = nearestObjects [_placeTry,["FlagCarrier"],500];
			private _units = nearestObjects [_placeTry,["CaManBase"],35];
			private _noPlayers = ({alive _x && _x distance _placeTry < 500} count call BRPVP_playersList) isEqualTo 0;
			private _noMissNear = ({_placeTry distance2D (_x select 0) < (_x select 1)} count call BRPVP_calcMissionsPosRad) isEqualTo 0;
			private _noPlaces = ({_placeTry distance2D (_x select 0) < 50+(_x select 1)} count BRPVP_placesNoMissions) isEqualTo 0;
			private _noFort = if (BRPVP_defendFortRun) then {_placeTry distance BRPVP_defendFortCenter > 350} else {true};
			private _noBuildings = count (_placeTry nearObjects ["Buildings",50]) <= 2;
			diag_log format ["[SPEC FORCES FIND POSITION] %1",[(_flags+_units) isEqualTo [],_noMissNear,_noPlaces,_noPlayers,_noFort,_noBuildings]];
			if ((_flags+_units) isEqualTo [] && _noMissNear && _noPlaces && _noPlayers && _noFort && _noBuildings) then {_found = true;} else {_wc = _wc+1;};
		};
		if (_found) then {_placesTry pushBack _placeTry;};
		uiSleep 0.25;
	};
	if (_placesTry isEqualTo []) exitWith {};
	_place = [];
	_max = -1;
	{
		private _pTry = _x;
		private _mCalc = 0;
		private _count = 0;
		{
			private _dist = _pTry distance2D _x;
			if (_dist <= BRPVP_mapGoodSize) then {
				_mCalc = _mCalc+_dist;
				_count = _count+1;
			};
		} forEach (BRPVP_specialForcesMissionsOn-[objNull]);
		if (_count isEqualTo 0) exitWith {_place = _pTry;};
		if (_mCalc/_count > _max) then {
			_max = _mCalc/_count;
			_place = _pTry;
		};
	} forEach _placesTry;
	diag_log format ["[SPEC FORCES FIND POSITION] Run time: %1",diag_tickTime-_itw];	
	
	_rad = 30;
	_skill = [0.4,0.25];

	_pFix = (AGLToASL _place) vectorDiff (AGLToASL [8021,10178,0]) vectorAdd [0,0,1];
	_pFix2D = _place vectorDiff [8021,10178,0];

	_pmissGroups = [
		[
			WEST,
			"DIAMOND",
			[],
			[
				["CUP_B_USMC_MARSOC_TL",[8007.9,10181.3,0],312,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_TC",[8030.3,10191.8,0],0,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_OC",[8032.3,10191.8,0],0,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_CC",[8013,10189.5,0],0,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_EL",[8015,10189.5,0],0,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_AR",[8028,10167,0],188,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_Marksman",[8026,10167.3,0],188,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_Medic",[8034.9,10180.2,0],73,[],"STAND",[]],
				["CUP_B_USMC_MARSOC",[8035.5,10178.3,0],73,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_EL",[8017.3,10166.2,0],186,[],"STAND",[]],
				["CUP_B_USMC_MARSOC",[8015.3,10166.4,0],186,[],"STAND",[]],
				["CUP_B_USMC_MARSOC",[8006.9,10179.5,0],312,[],"STAND",[]],
				["CUP_B_USMC_MARSOC",[8013.8,10174.5,0],258,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_Medic",[8030.7,10173.5,0],120,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_Marksman",[8026.6,10170.3,0],135,[],"STAND",[]],
				["CUP_B_USMC_MARSOC_Marksman_DA",[8014.1,10180.1,0],281,[],"STAND",[]],
				["CUP_B_USMC_Sniper_M107",[8020.3,10169.9,0],198,[],"STAND",[]],
				["CUP_B_USMC_Sniper_M107",[8023.7,10193,4.3],0,[1],"STAND",[]],
				["CUP_B_USMC_Sniper_M107",[8021,10193.1,4.3],0,[1],"STAND",[]],
				["CUP_B_HIL_Soldier_Unarmed_Res",[8019.4,10177.4,0],0,[1,2,5],"STAND",[]]
			],
			[
				["CUP_B_M2StaticMG_USMC",[8022.8,10165.7,30.7],[[-0.01,-1,0],[0,0,1]],[],[["CUP_B_USMC_Soldier",["turret",[0]],[],[]]]],
				["CUP_B_M2StaticMG_USMC",[8033.4,10183.2,30.7],[[0.87,0.49,0],[0,0,1]],[],[["CUP_B_USMC_Soldier",["turret",[0]],[],[]]]],
				["CUP_B_M2StaticMG_USMC",[8009.8,10185.4,30.7],[[-0.94,0.33,0],[0,0,1]],[],[["CUP_B_USMC_Soldier",["turret",[0]],[],[]]]]
			],
			[]
		]
	];
	_pmissEmptyVehs = [
		["CUP_B_Boxer_Empty_GER_DES",[8029.4,10179.3,31.6],[[0,1,0],[0,0,1]]]
	];
	_pmissBuildings = [
		["Land_Sleeping_bag_F",[8020.91,10174.2,29.64],[[-0.04,1,0],[0,0,1]],true],
		["Land_Razorwire_F",[8011.71,10167.6,30.37],[[0.65,0.76,0],[0,0,1]],true],
		["Land_Razorwire_F",[8007.41,10174.1,30.37],[[0.95,0.3,0],[0,0,1]],true],
		["Land_BagFence_Short_F",[8024.99,10164.6,30.02],[[-0.71,0.71,0],[0,0,1]],true],
		["Land_BagFence_Round_F",[8023.06,10163.8,30.03],[[0.04,1,0],[0,0,1]],true],
		["Land_BagFence_Short_F",[8021.13,10164.8,30.03],[[-0.7,-0.72,0],[0,0,1]],true],
		["Land_CanisterPlastic_F",[8024.9,10165.8,29.96],[[0.99,-0.17,0],[0,0,1]],true],
		["Land_Sacks_heap_F",[8017.49,10184.2,30],[[1,-0.05,0],[0,0,1]],true],
		["Land_CanisterPlastic_F",[8018,10175.1,29.96],[[0.98,0.2,0],[0,0,1]],true],
		["Land_CanisterPlastic_F",[8017.65,10175.6,29.96],[[-0.49,-0.87,0],[0,0,1]],true],
		["Land_Garbage_square5_F",[8021.94,10178.5,29.65],[[-0.16,-0.99,0],[0,0,1]],true],
		["Land_CampingChair_V1_F",[8020.4,10180.7,30.12],[[-0.23,0.97,0],[0,0,1]],true],
		["Land_CampingChair_V1_F",[8018.36,10178.5,30.12],[[-0.98,0.18,0],[0,0,1]],true],
		["Land_Bucket_F",[8024.83,10182.8,29.77],[[-0.92,-0.4,0],[0,0,1]],true],
		["Land_Can_V2_F",[8021.27,10182.8,29.65],[[-0.12,-0.99,0],[0,0,1]],true],
		["Land_MetalWire_F",[8023.36,10180.6,29.61],[[-0.46,-0.89,0],[0,0,1]],true],
		["Land_Axe_F",[8023.52,10178.9,29.64],[[0.42,0.91,0],[0,0,1]],true],
		["Land_TentDome_F",[8020.57,10186.2,30.22],[[-1,-0.05,0],[0,0,1]],true],
		["Land_TentDome_F",[8024.84,10185.6,30.22],[[-0.98,0.19,0],[0,0,1]],true],
		["Land_Sleeping_bag_brown_F",[8024.59,10177.5,29.63],[[-0.98,0.2,0],[0,0,1]],true],
		["Land_Campfire_F",[8020.78,10178.1,29.83],[[-0.5,-0.87,0],[0,0,1]],true,{BRPVP_specialForcesMissionsOn pushBack _this;}],
		["Land_Sleeping_bag_F",[8023.13,10175.3,29.64],[[-0.68,0.74,0],[0,0,1]],true],
		["Land_BakedBeans_F",[8022.03,10183.4,29.66],[[0.99,-0.11,0],[0,0,1]],true],
		["Land_BakedBeans_F",[8022.7,10179,29.67],[[-1,-0.06,0],[0,0,1]],true],
		["Land_BakedBeans_F",[8021.44,10182.8,29.67],[[-0.52,0.86,0],[0,0,1]],true],
		["Land_Can_V1_F",[8021.27,10182.7,29.65],[[-0.95,-0.3,0],[0,0,1]],true],
		["Land_WoodPile_F",[8024.43,10179.5,29.87],[[-0.99,0.13,0],[0,0,1]],true],
		["Land_Camping_Light_F",[8018.88,10179.1,29.73],[[0.02,-1,0],[0,0,1]],true],
		["Land_BagFence_Round_F",[8009.19,10183.5,30.03],[[0.49,0.87,0],[0,0,1]],true],
		["Land_BagFence_Round_F",[8010.68,10186.6,30.03],[[-0.34,-0.94,0],[0,0,1]],true],
		["Land_BagFence_Round_F",[8008.53,10185.7,30.03],[[0.92,-0.4,0],[0,0,1]],true],
		["Land_Gloves_F",[8023.33,10178.8,29.61],[[-0.98,0.19,0],[0,0,1]],true],
		["Land_CerealsBox_F",[8022.16,10183.5,29.76],[[-0.53,-0.85,0],[0,0,1]],true],
		["Land_FMradio_F",[8021.76,10175.1,29.68],[[0.14,-0.99,0],[0,0,1]],true],
		["Land_Canteen_F",[8021.45,10182.9,29.74],[[0.66,0.75,0],[0,0,1]],true],
		["Land_TinContainer_F",[8018.33,10175.2,29.71],[[-1,-0.01,0],[0,0,1]],true],
		["Land_Cargo_Patrol_V1_F",[8022.57,10191.8,34.51],[[0.02,-1,0],[0,0,1]],true,{_this setVariable ["brpvp_spec_miss_destruct",true];_this setVariable ["brpvp_yes_minerva",true,true];},[1]],
		["Land_Razorwire_F",[8034.21,10167.2,30.37],[[-0.69,0.72,0],[0,0,1]],true],
		["Land_Razorwire_F",[8038.13,10173.9,30.36],[[-0.97,0.25,0],[0,0,1]],true],
		["Land_BagFence_Round_F",[8034.14,10185.4,30.02],[[-0.28,-0.96,0],[0,0,1]],true],
		["Land_BagFence_Round_F",[8035.34,10183.4,30.02],[[-0.98,0.22,0],[0,0,1]],true],
		["Land_Basket_F",[8034.11,10182.6,29.94],[[0.68,-0.73,0],[0,0,1]],true],
		["Land_CerealsBox_F",[8033.13,10184.9,29.76],[[0.31,-0.95,0],[0,0,1]],true]
	];
	if !("CUP_B_USMC_MARSOC_TL" call BRPVP_classExists) then {
		_pmissGroups = [
			[
				WEST,
				"DIAMOND",
				[],
				[
					["B_soldier_TL_F",[8007.9,10181.3,0],312,[],"STAND",[]],
					["B_soldier_AA_F",[8030.3,10191.8,0],0,[],"STAND",[]],
					["B_soldier_AA_F",[8032.3,10191.8,0],0,[],"STAND",[]],
					["B_soldier_AT_F",[8013,10189.5,0],0,[],"STAND",[]],
					["B_soldier_AT_F",[8015,10189.5,0],0,[],"STAND",[]],
					["B_soldier_AR_F",[8028,10167,0],188,[],"STAND",[]],
					["B_Sharpshooter_F",[8026,10167.3,0],188,[],"STAND",[]],
					["B_medic_F",[8034.9,10180.2,0],73,[],"STAND",[]],
					["B_soldier_GL_F",[8035.5,10178.3,0],73,[],"STAND",[]],
					["B_soldier_GL_F",[8017.3,10166.2,0],186,[],"STAND",[]],
					["B_soldier_GL_F",[8015.3,10166.4,0],186,[],"STAND",[]],
					["B_HeavyGunner_F",[8006.9,10179.5,0],312,[],"STAND",[]],
					["B_HeavyGunner_F",[8013.8,10174.5,0],258,[],"STAND",[]],
					["B_medic_F",[8030.7,10173.5,0],120,[],"STAND",[]],
					["B_Sharpshooter_F",[8026.6,10170.3,0],135,[],"STAND",[]],
					["B_HeavyGunner_F",[8014.1,10180.1,0],281,[],"STAND",[]],
					["B_T_Sniper_F",[8020.3,10169.9,0],198,[],"STAND",[]],
					["B_T_Sniper_F",[8023.7,10193,4.3],0,[1],"STAND",[]],
					["B_T_Sniper_F",[8021,10193.1,4.3],0,[1],"STAND",[]],
					["B_Protagonist_VR_F",[8019.4,10177.4,0],0,[1,2,5],"STAND",[]]
				],
				[
					["B_HMG_01_high_F",[8022.8,10165.7,30.7],[[-0.01,-1,0],[0,0,1]],[],[["B_soldier_GL_F",["turret",[0]],[],[]]]],
					["B_HMG_01_high_F",[8033.4,10183.2,30.7],[[0.87,0.49,0],[0,0,1]],[],[["B_soldier_GL_F",["turret",[0]],[],[]]]],
					["B_GMG_01_high_F",[8009.8,10185.4,30.7],[[-0.94,0.33,0],[0,0,1]],[],[["B_soldier_GL_F",["turret",[0]],[],[]]]]
				],
				[]
			]
		];
	};
	if !("CUP_B_Boxer_Empty_GER_DES" call BRPVP_classExists) then {
		_pmissEmptyVehs = [
			["B_T_LSV_01_unarmed_CTRG_F",[8029.4,10179.3,32],[[0,1,0],[0,0,1]]]
		];	
	};

	private _ata = [];
	private _nos = [];
	private _vd = [];
	private _allObjs = [];
	private _movFix1 = [];
	private _movFix2 = [];
	private _noLagWait = 0.1;
	private _movFixCode = {
		private _lis = lineIntersectsSurfaces [getPosASL _this vectorAdd [0,0,0.3],getPosASL _this vectorAdd [0,0,-50],_this,objNull,true,1,"GEOM","NONE"];
		if (_lis isNotEqualTo []) then {
			private _ground = _lis select 0 select 2;
			if (isNull _ground) then {
				_movFix1 pushBack [_this,_movFixCodeToGround];
			} else {
				_movFix2 pushBack [[_this,_ground,_ground worldToModel (ASLToAGL getPosASL _this)],_movFixCodeToBellowObj];
			};
		};
	};
	_movFixCodeToGround = {
		private _pos = getPosWorld _this;
		_pos set [2,0];
		if (vectorUp _this isNotEqualTo [0,0,1]) then {_this setVectorUp surfaceNormal _pos;};
		if (_this call BRPVP_isMotorizedNoTurret) then {_this setPosASL (AGLToASL _pos vectorAdd [0,0,0.5]);} else {_this setPosASL AGLToASL _pos;};
	};
	_movFixCodeToBellowObj = {
		params ["_obj","_ground","_relative"];
		_obj setPosASL AGLToASL (_ground modelToWorld _relative);
	};
	{
		_x params ["_class","_pw","_vdu","_complete",["_code",{}],["_flags",[]]];
		private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};
		_obj setVectorDirAndUp _vdu;
		_obj setPosWorld (_pw vectorAdd _pFix);
		_obj call _code;
		if (1 in _flags) then {
			_obj addEventHandler ["HandleDamage",{
				params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
				private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
				private _deltaDam = _dam-_damNow;
				_damNow+_deltaDam*0.25
			}];
		};
		_movFix1 pushBack [_obj,_movFixCodeToGround];
		_nos pushBack _obj;
	} forEach _pmissBuildings;
	{
		_x params ["_class","_pw","_vdu"];
		private _obj = createVehicle [_class,BRPVP_posicaoFora,[],100,"NONE"];
		_obj call BRPVP_emptyBox;
		_obj setVectorDirAndUp _vdu;
		_obj setPosWorld (_pw vectorAdd _pFix);
		_allObjs pushBack _obj;
		_vd pushBack _obj;
		_obj call BRPVP_initPlayerMissionSceneryVehicles;
	} forEach _pmissEmptyVehs;
	{
		_x params ["_side","_formation","_wps","_onFoot","_onVeh","_notUsed"];
		private _grp = createGroup [_side,true];
		private _leader = objNull;
		{
			_x params ["_class","_AGL","_dir","_flags","_notUSed1","_notUSed2"];
			private _u = _grp createUnit [_class,[0,0,0],[],0,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_u setPosASL ((AGLToASL _AGL) vectorAdd _pFix);
			_ata pushBack _u;
			_u setDir _dir;
			if (1 in _flags) then {_u disableAI "PATH";};
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			if (2 in _flags) then {
				_u setVariable ["brpvp_extra_chance",10];
				_u addEventHandler ["Killed",{
					private _pos = getPosASL (_this select 0) vectorAdd [0,0,1.25];
					private _suitCase = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
					_suitCase setPosASL _pos;
					_suitCase setVariable ["mny",round (4000000*BRPVP_missionValueMult),true];
					_this call BRPVP_botDaExp;
				}];
			} else {
				_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			};
			if (5 in _flags) then {_leader = _u;};
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			_allObjs pushBack _u;
		} forEach _onFoot;
		{
			_x params ["_class","_pw","_vdu","_flags","_crew"];
			private _veh = createVehicle [_class,[0,0,0],[],10,"CAN_COLLIDE"];
			_veh setVectorDirAndUp _vdu;
			_veh setPosWorld (_pw vectorAdd _pFix);
			_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
			_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
			{
				_x params ["_class","_roleArray","_notUSed1","_notUSed2"];
				_roleArray params ["_role",["_path",[]]];
				private _u = _grp createUnit [_class,[0,0,0],[],10,"CAN_COLLIDE"];
				[_u] joinSilent _grp;
				_ata pushBack _u;
				_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
				_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
				_u setSkill (_skill select 0);
				_u setSkill ["aimingAccuracy",_skill select 1];
				if (_role isEqualTo "driver") then {_u moveInDriver _veh;};
				if (_role isEqualTo "turret") then {_u moveInTurret [_veh,_path];};
				if (_role isEqualTo "cargo") then {_u moveInCargo _veh;};
				if (_veh isKindOf "StaticWeapon") then {
					private _dir = [[0,0,0],_vdu select 0] call BIS_fnc_dirTo;
					_u doWatch (getPosASL _veh vectorAdd [100*sin _dir,100*cos _dir,3]);
				};
			} forEach _crew;
			if (1 in _flags) then {_veh lock true;};
			if (2 in _flags) then {_veh setVariable ["brpvp_cant_heli_town",true,true];};
			if (4 in _flags) then {_veh setUnloadInCombat [true,false];};
			_allObjs pushBack _veh;
			_vd pushBack _veh;
		} forEach _onVeh;
		if (_wps isNotEqualTo []) then {
			{
				_wp = _grp addWayPoint [_x vectorAdd _pFix2D,0];
				_wp setWayPointType "MOVE";
				_wp setWaypointCompletionRadius 5;
			} forEach _wps;
			_wp = _grp addWayPoint [(_wps select 0) vectorAdd _pFix2D,0];
			_wp setWayPointType "CYCLE";
			_wp setWaypointCompletionRadius 5;
		};
		if (!isNull _leader) then {_grp selectLeader _leader;};
		_grp setFormation _formation;
	} forEach _pmissGroups;

	//RARE LOOT
	{
		_x params ["_posW","_dir","_q"];
		private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
		_box allowDamage false;
		_box setPosASL (_posW vectorAdd _pFix);
		_box setDir _dir;
		[_box,0,1,true,_q] call BRPVP_createCompleteLootBox;
		uiSleep _noLagWait;
	} forEach [
		[[8019.41,10176.2,29.6114],random 360,25],
		[[8023.59,10182.4,29.6066],random 360,25]
	];
	
	publicVariable "BRPVP_specialForcesMissionsOn";

	//FIX HEIGHT
	{_x call _movFixCode;} forEach _allObjs;
	{(_x select 0) call (_x select 1);} forEach _movFix1;
	{(_x select 0) call (_x select 1);} forEach _movFix2;
	_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

	[_ata,_nos,_vd,_place,_rad] spawn {
		params ["_bots","_objs","_vehs","_place","_rad"];
		waitUntil {
			uiSleep 30;
			(({!alive _x || _x distance2D _place > 200} count _bots)/count _bots) >= 0.9;
		};
		{if !(_x getVariable ["brpvp_spec_miss_destruct",false]) then {deleteVehicle _x;};} forEach _objs;
		{
			if (_x isKindOf "StaticWeapon") then {
				deleteVehicle _x;
			} else {
				private _pCount = {_x call BRPVP_isPlayer} count crew _x;
				if (_pCount isEqualTo 0) then {deleteVehicle _x;};
			};
		} forEach _vehs;
		uiSleep 0.25;
		{if (_x getVariable ["brpvp_spec_miss_destruct",false]) then {_x setDamage 1;};} forEach _objs;
		uiSleep 0.25;
		[_place,_rad] call BRPVP_wakeUpObjectsFlying;
		BRPVP_specForceNext = serverTime+1200;
		BRPVP_specialForcesMissionsOn = BRPVP_specialForcesMissionsOn-[objNull];
		publicVariable "BRPVP_specialForcesMissionsOn";
	};
};