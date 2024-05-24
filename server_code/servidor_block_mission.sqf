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

if (isNil "BRPVP_blockPlacesSelected") then {
	BRPVP_blockPlacesSelected = [];
	BRPVP_blockPlacesSelectedBots = [];
	BRPVP_blockPlacesSelectedObjs = [];
	BRPVP_blockPlacesSelectedPvpAreas = [];
	publicVariable "BRPVP_blockPlacesSelected";
};
_itemBoxs = [
	"Box_GEN_Equip_F", //itens de policia
	"Box_IND_Ammo_F", //munição comum
	"Box_T_East_Ammo_F", //munição comum
	"Box_NATO_WpsLaunch_F", //launchers (tem titan)
	"Box_NATO_Wps_F", //armas medias
	"Box_IDAP_Uniforms_F", //uniformes ONG
	"Box_T_East_Wps_F", //armas estranhas
	"C_T_supplyCrate_F", //armas fodas, items fodas, tws
	"Box_Syndicate_Wps_F" //armas milicia 
];
_newAditions = [];
while {count BRPVP_blockPlacesSelected < BRPVP_numberOfRoadBlocks && count BRPVP_blockPlaces > 0} do {
	private ["_element"];
	//TRY 1
	_tryIdx1 = floor random count BRPVP_blockPlaces;
	_tryPos1 = BRPVP_blockPlaces select _tryIdx1 select 0;
	_min1 = 1000000;
	{_min1 = _min1 min (_tryPos1 distance (_x select 0));} forEach BRPVP_blockPlacesSelected;
	
	//TRY 2
	_tryIdx2 = floor random count BRPVP_blockPlaces;
	_tryPos2 = BRPVP_blockPlaces select _tryIdx2 select 0;
	_min2 = 1000000;
	{_min2 = _min2 min (_tryPos2 distance (_x select 0));} forEach BRPVP_blockPlacesSelected;

	//TRY 3
	_tryIdx3 = floor random count BRPVP_blockPlaces;
	_tryPos3 = BRPVP_blockPlaces select _tryIdx3 select 0;
	_min3 = 1000000;
	{_min3 = _min3 min (_tryPos3 distance (_x select 0));} forEach BRPVP_blockPlacesSelected;
	
	//GET BETTER OF TREE
	if (_min1 >= _min2 && _min1 >= _min3) then {
		_element = BRPVP_blockPlaces deleteAt _tryIdx1;
	} else {
		if (_min2 >= _min1 && _min2 >= _min3) then {
			_element = BRPVP_blockPlaces deleteAt _tryIdx2;
		} else {
			_element = BRPVP_blockPlaces deleteAt _tryIdx2;
		};
	};
	if ((_element select 0) nearObjects ["FlagCarrier",500] isEqualTo []) then {
		BRPVP_blockPlacesSelected pushBack _element;
		_newAditions pushBack (_element+[count BRPVP_blockPlacesSelected-1]);
	};
};
uiSleep BRPVP_simpleMissSpawnWait;
{
	_x params ["_pos0","_dir","_blockIdx"];
	_blockObjs = [];

	//BAGS
	{
		_x params ["_dist","_angle"];
		_bagN = createVehicle ["Land_BagFence_Long_F",_pos0 getPos [_dist,_dir+_angle],[],0,"CAN_COLLIDE"];
		_bagN setDir ((_dir-4+random 8)+selectRandom [0,180]);
		_blockObjs pushBack _bagN;
	} forEach [[1.5,90],[1.5,-90],[4.5,90],[4.5,-90],[7.5,90],[7.5,-90]];

	//BARRIER
	_bar0 = createVehicle ["RoadBarrier_F",_pos0 getPos [5,_dir],[],0,"CAN_COLLIDE"];
	_bar1 = createVehicle ["RoadBarrier_F",_pos0 getPos [5,_dir+180],[],0,"CAN_COLLIDE"];
	_bar0 setDir ((_dir-5+random 10)+selectRandom [0,180]);
	_bar1 setDir ((_dir-5+random 10)+selectRandom [0,180]);
	_blockObjs append [_bar0,_bar1];
	uiSleep BRPVP_simpleMissSpawnWait;
	
	//HMG
	_grpHmg = createGroup [BLUFOR,true];
	{
		_x params ["_turret","_a1","_a2"];
		_return = [[random 100,0,0],0,_turret,_grpHmg] call BIS_fnc_spawnVehicle;
		_hmg = _return select 0;
		_hmg setVariable ["brpvp_can_disable",true,2];
		_hmg setPosASL AGLToASL ((_pos0 getPos [7+random 1,_dir+_a1]) getPos [2,_dir+_a2]);
		_hmg setDir (_dir+_a2-10+random 20);
		_hmg remoteExecCall ["BRPVP_veiculoEhReset",2];
		_blockObjs pushBack _hmg;
		_unit = _return select 1 select 0;
		_unit addEventHandler ["Killed",{call BRPVP_botDaExp;}];
		_unit addEventHandler ["HandleDamage",{if (side (_this select 3) isEqualTo BLUFOR) then {call BRPVP_hdeh;0} else {call BRPVP_hdeh};}];
		_unit removeWeapon primaryWeapon _unit;
		BRPVP_roadBlockBots pushBack _unit;
		uiSleep BRPVP_simpleMissSpawnWait;
	} forEach [["B_T_Static_AT_F",90,0],["B_HMG_01_high_F",-90,0],["B_HMG_01_high_F",90,180],["B_T_Static_AT_F",-90,180]];

	//AI ON FOOT
	_squadAll = selectRandom BRPVP_missionWestGroups;
	_squad1 = (_squadAll call BIS_fnc_arrayShuffle) select [0,4];
	_squad2 = (_squadAll call BIS_fnc_arrayShuffle) select [0,4];
	_blockBots = [];
	{
		_x params ["_squad","_dist"];
		_wpAllPos = [];
		{
			_wpPos = _pos0 getPos _x;
			_best = _wpPos findEmptyPosition [0,15,"C_man_polo_1_F"];
			_wpAllPos pushBack (if (_best isEqualTo []) then {_wpPos} else {_best});
		} forEach [[_dist,_dir],[_dist,_dir+90],[_dist,_dir+180],[_dist,_dir+270]];
		_spawnPos = _wpAllPos select (count _wpAllPos - 1);
		_grpFoot = createGroup [BLUFOR,true];
		{
			_unit = _grpFoot createUnit [_x,_spawnPos,[],8,"NONE"];
			[_unit] joinSilent _grpFoot;
			_unit addEventHandler ["Killed",{call BRPVP_botDaExp;}];
			_unit addEventHandler [
				"HandleDamage",
				{
					if (side (_this select 3) isEqualTo BLUFOR) then {
						call BRPVP_hdeh;
						0
					} else {
						call BRPVP_hdeh
					};					
				}
			];
			BRPVP_roadBlockBots pushBack _unit;
			_blockBots pushBack _unit;
		} forEach _squad;

		//CREATE WAYPOINTS
		{
			_wp = _grpFoot addWayPoint [_x,0];
			_wp setWayPointType "MOVE";
			_wp setWaypointCompletionRadius 5;
		} forEach _wpAllPos;
		_wp = _grpFoot addWayPoint [_wpAllPos select 0,0];
		_wp setWayPointType "CYCLE";
		_wp setWaypointCompletionRadius 5;
		reverse _wpAllPos;
		uiSleep BRPVP_simpleMissSpawnWait;
	} forEach [[_squad1,25],[_squad2,50]];
	BRPVP_blockPlacesSelectedBots set [_blockIdx,_blockBots];

	//ITEM BOX
	_itemBoxsTemp = +_itemBoxs;
	for "_n" from 0 to 1 do {
		_itemBox = _itemBoxsTemp deleteAt (floor random count _itemBoxsTemp);
		_box = createVehicle [_itemBox,_pos0,[],5,"NONE"];
		_box setVariable ["brpvp_del_when_empty",true,true];
		_box allowDamage false;
		[_box,round (BRPVP_blockMoneyForLoot*BRPVP_missionValueMult),selectRandom BRPVP_blockMoneyForLootTry,true,BRPVP_blockSpecialLootQtt,1] call BRPVP_createCompleteLootBox;
		uiSleep BRPVP_simpleMissSpawnWait;
	};
	
	//CREATE MONEY BOX
	_box = createVehicle ["Box_IND_Wps_F",_pos0,[],5,"NONE"];
	_box setVariable ["brpvp_del_when_empty",true,true];
	_box allowDamage false;
	_box setDir random 360;
	
	//CLEAN MONEY BOX
	clearMagazineCargoGlobal _box;
	clearWeaponCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;
	
	//PUT MONEY IN MONEY BOX
	{_box addMagazineCargoGlobal [_x,1];} forEach (round (BRPVP_blockFlareMoney*BRPVP_missionValueMult) call BRPVP_itemMoneyCreate);
	BRPVP_blockPlacesSelectedObjs set [_blockIdx,_blockObjs];

	//CREATE PVP ZONE IF IN PVE
	private _inPve = {_pos0 distance (_x select 0) < _x select 1} count BRPVP_pveMainAreas > 0;
	private _inPvp = {_pos0 distance (_x select 0) < _x select 1} count BRPVP_PVPAreas > 0;
	if (_inPve && !_inPvp) then {
		private _key = "ROADBLOCK_MISS_PVP_"+str round random 1000000;
		[_pos0,500,{"PVP"},_key] remoteEXecCall ["BRPVP_addPvpArea",2];
		[_pos0,500,_key,12] remoteExecCall ["BRPVP_addNewPosCheckLayer",0];
		BRPVP_blockPlacesSelectedPvpAreas set [_blockIdx,_key];
	} else {
		BRPVP_blockPlacesSelectedPvpAreas set [_blockIdx,""];
	};
} forEach _newAditions;
if (_newAditions isNotEqualTo []) then {
	publicVariable "BRPVP_roadBlockBots";
	publicVariable "BRPVP_blockPlacesSelected";
	BRPVP_smallMissionsAIObjs append BRPVP_roadBlockBots;
};