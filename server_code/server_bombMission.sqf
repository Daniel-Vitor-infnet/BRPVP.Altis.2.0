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

BRPVP_bombMissionBuildings = BRPVP_bombMissionBuildings apply {if (alive _x && _x call BRPVP_checkOnFlagState isEqualTo 0) then {_x} else {-1}};
BRPVP_bombMissionBuildings = BRPVP_bombMissionBuildings-[-1];
_qgObj = BRPVP_bombMissionBuildings deleteAt floor random count BRPVP_bombMissionBuildings;
{_qgObj animate [_x,0];} forEach animationNames _qgObj;
_qgObj setVariable ["own",-2,true];
_qgObj setVariable ["stp",4,true];
_qgObj setVariable ["amg",[[],[],false],true];
_wrd = getPosWorld _qgObj;
_lis = lineIntersectsSurfaces [_wrd vectorAdd [0,0,30],_wrd];
_top = ASLToAGL (_lis select 0 select 0) vectorAdd [0,0,5];
[_qgObj,false] remoteExecCall ["allowDamage",0,true];
[_qgObj,_top] spawn {
	params ["_obj","_top"];
	_hmgAll = [];
	{
		_x params ["_pos","_dir"];
		_hmg = createVehicle ["I_HMG_01_high_F",_obj modelToWorld _pos,[],0,"CAN_COLLIDE"];
		_hmg setDir (_dir+getDir _obj);
		_hmg setVariable ["own",-2,true];
		_hmg setVariable ["stp",4,true];
		_hmg setVariable ["amg",[[],[],false],true];
		_hmg remoteExecCall ["BRPVP_setTurretOperator",2];
		waitUntil {count crew _hmg > 0};
		_operator = (crew _hmg) select 0;
		_operator setVariable ["brpvp_dead_delete",true,2];
		_hmgAll pushBack _operator;
		uiSleep BRPVP_simpleMissSpawnWait;
	} forEach (BRPVP_bombMissionClassesTurrets select (BRPVP_bombMissionClasses find typeOf _obj));
	waitUntil {{!isNull _x} count _hmgAll isEqualTo 0};
	_obj setVariable ["brpvp_explode_icon",_top,true];
	_so = sizeOf typeOf _obj;
	_obj setVariable ["brpvp_c4_to_destroy",selectRandom [1,2,2,2,3],true];
	_obj setVariable ["brpvp_c4_min_bomb",15,true];
	waitUntil {isObjectHidden _obj};
	BRPVP_bombMissionObjs = BRPVP_bombMissionObjs-[_obj];
	publicVariable "BRPVP_bombMissionObjs";
	_itemBoxs = [
		"Box_GEN_Equip_F",
		"Box_IND_Ammo_F",
		"Box_T_East_Ammo_F",
		"Box_NATO_WpsLaunch_F",
		"Box_NATO_Wps_F",
		"Box_IDAP_Uniforms_F",
		"Box_T_East_Wps_F",
		"C_T_supplyCrate_F",
		"Box_Syndicate_Wps_F"
	];
	sleep 5;
	{
		private _pw = getPosWorld _x;
		private _lis = lineIntersectsSurfaces [_pw,_pw vectorAdd [0,0,-80],_x,objNull];
		if !(_lis isEqualTo []) then {_x setPosASL (_lis select 0 select 0);};
	} forEach nearestObjects [_obj,["WeaponHolderSimulated","GroundWeaponHolder"],_so];
	_angles = [-16,-8,0,8,16,164,172,180,188,196];
	_objAngle = getDir _obj;
	_angles = _angles apply {_objAngle+_x};
	for "_n" from 0 to 1 do {
		_itemBox = _itemBoxs deleteAt (floor random count _itemBoxs);
		_box = createVehicle [_itemBox,_top vectorAdd [0,0,-6.5],[],3,"CAN_COLLIDE"];
		_box allowDamage false;
		[_box,BRPVP_bombMissionMoneyForLoot*BRPVP_missionValueMult,selectRandom BRPVP_bombMissionMoneyForLootTry,true,true] call BRPVP_createCompleteLootBox;
		for "_ci" from 0 to BRPVP_bombMissionSpecialLootQtt do {[_box,0,1,false,true] call BRPVP_createCompleteLootBox;};
		_angle = _angles deleteAt floor random count _angles;
		[_box,[3.5*sin _angle,3.5*cos _angle,2.5]] remoteExecCall ["setVelocity",0];
		_box setVariable ["brpvp_del_when_empty",true,true];
		sleep 0.25;
	};
	for "_n" from 0 to 1 do {
		_suitcase = createVehicle ["Land_Suitcase_F",_top vectorAdd [0,0,-6.5],[],3,"CAN_COLLIDE"];
		_suitcase setVariable ["mny",round ((BRPVP_bombMissionSuitCases select _n)*BRPVP_missionValueMult),true];
		_angle = _angles deleteAt floor random count _angles;
		[_suitcase,[3.5*sin _angle,3.5*cos _angle,2.5]] remoteExecCall ["setVelocity",0];
		sleep 0.25;
	};
	BRPVP_bombMissionNext = serverTime+BRPVP_missionSleepTime;
};
_uniformes = ["U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_C_Man_casual_6_F"];
_caps = ["H_Bandanna_mcamo","H_Bandanna_surfer","H_Hat_blue","H_Hat_tan","H_StrawHat_dark","H_Bandanna_surfer_grn","H_Cap_surfer"];
_oculosTipos = ["G_Diving"];
_weapons = ["arifle_MX_ACO_F","SMG_01_Holo_F","LMG_Mk200_MRCO_F","LMG_Mk200_MRCO_F","hgun_PDW2000_F","LMG_Zafir_pointer_F","LMG_Zafir_pointer_F","hgun_ACPC2_F","hgun_Pistol_heavy_02_Yorris_F","arifle_Katiba_ACO_F","arifle_Mk20C_ACO_F"];
_bags = ["B_Carryall_oli","B_Carryall_oucamo","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo"];
_vests = ["V_TacVest_blk_POLICE","V_PlateCarrier_Kerry","V_PlateCarrierIA2_dgtl","V_PlateCarrier2_rgr"];
_survivors = [];
for "_i1" from 1 to 2 do {
	_grp = createGroup [BLUFOR,true];
	_spawn = (_qgObj getPos [15,random 360]) findEmptyPosition [0,30,"B_Soldier_F"];
	for "_i2" from 1 to 4 do {
		_survivor = _grp createUnit ["B_Soldier_F",_spawn,[],0,"NONE"];
		[_survivor] joinSilent _grp;
		{_survivor removeWeapon _x;} forEach weapons _survivor;
		removeAllAssignedItems _survivor;
		removeBackpackGlobal _survivor;
		removeUniform _survivor;
		removeVest _survivor;
		removeHeadGear _survivor;
		removeGoggles _survivor;
		_moda = floor random (50+1);
		_uniforme = _uniformes select (_moda mod count _uniformes);
		_cap = _caps select (_moda mod count _caps);
		_oculos = _oculosTipos select (_moda mod count _oculosTipos);
		_survivor forceAddUniform _uniforme;
		if (_moda mod 5 != 0) then {_survivor addHeadGear _cap;};
		_survivor setSkill (BRPVP_AISkill select 6 select 0);
		_survivor setSkill ["aimingAccuracy",BRPVP_AISkill select 6 select 1];
		_r = floor random 2;
		if (_r isEqualTo 0) then {
			_survivor addBackpack selectRandom _bags;
			_survivor addVest selectRandom _vests;
		} else {
			_survivor addBackpack selectRandom _bags;
		};
		if (_i1 isEqualTo 1) then {_survivor addMagazine "DemoCharge_Remote_Mag";};
		_survivor addWeapon selectRandom _weapons;
		if (random 1 < 0.4) then {
			_survivor addWeapon "launch_NLAW_F";
			_survivor addMagazine "NLAW_F";
		};
		[_survivor] call BRPVP_fillUnitWeapons;
		_survivor addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
		_survivor addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
		_survivors pushBack _survivor;
	};
	_heading = random 360;
	_pos1 = _qgObj getPos [30,_heading];
	_pos2 = _qgObj getPos [30,_heading+180];
	_pos1FEP = _pos1 findEmptyPosition [0,30,"C_man_1"];
	_pos2FEP = _pos2 findEmptyPosition [0,30,"C_man_1"];
	_pos1 = if (_pos1FEP isEqualTo []) then {_pos1} else {_pos1FEP};
	_pos2 = if (_pos2FEP isEqualTo []) then {_pos2} else {_pos2FEP};
	_wp = _grp addWayPoint [_pos1,0];
	_wp setWaypointCompletionRadius 5;
	_wp setWayPointType "MOVE";
	_wp = _grp addWayPoint [_pos2,0];
	_wp setWaypointCompletionRadius 5;
	_wp setWayPointType "MOVE";
	_wp = _grp addWayPoint [_pos1,0];
	_wp setWaypointCompletionRadius 5;
	_wp setWayPointType "CYCLE";
	uiSleep BRPVP_simpleMissSpawnWait;
};
BRPVP_bombMissionUnits = BRPVP_bombMissionUnits+_survivors;

//CHG
remoteExecCall ["BRPVP_AIRemoveNull",2];
_survivors remoteExecCall ["BRPVP_updateAIUnitsArray",2];
BRPVP_smallMissionsAIObjs append _survivors;

BRPVP_bombMissionObjs pushBack _qgObj;
publicVariable "BRPVP_bombMissionObjs";