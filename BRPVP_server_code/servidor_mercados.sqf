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
diag_log "[SCRIPT] servidor_mercados.sqf BEGIN";

//TRADER MAN CREATION
_allTraders = [];
_createTraderMan = {
	private ["_m"];
	_m = createAgent ["C_man_sport_1_F_afro",_this,[],12,"CAN_COLLIDE"];
	_m setPosASL AGLToASL _this;
	_m allowDamage false;
	_m setCaptive true;
	_m disableAI "ALL";
	_m enableSimulation false;
	_allTraders pushBack _m;
	_m
};
_createTraderMan2 = {
	private ["_m"];
	_m = createAgent ["C_Man_ConstructionWorker_01_Blue_F",_this,[],12,"CAN_COLLIDE"];
	if !(goggles _m isEqualTo "") then {removeGoggles _m;};
	_m setPosASL AGLToASL _this;
	_m allowDamage false;
	_m setCaptive true;
	_m disableAI "ALL";
	_m enableSimulation false;
	_allTraders pushBack _m;
	_m
};
_createTraderMan3 = {
	params ["_local","_dir"];
	private ["_m"];
	_m = createAgent ["C_man_polo_5_F",_local,[],12,"CAN_COLLIDE"];
	_m setPosASL AGLToASL _local;
	_m setDir _dir;
	_m allowDamage false;
	_m setCaptive true;
	_m disableAI "ALL";
	_allTraders pushBack _m;
	_m
};

//ARRAY COM OS MERCADORES
BRPVP_mercadorObjs = [];

//INICIA COLOCACAO DOS MERCADOS E MERCADORES
_objIgnora = [];
{
	private ["_trrDaVez","_mMainObj"];
	_pos = _x select 0;
	_angle = _x select 1;

	//CRIAR O MERCADOR
	_mercador = _pos call _createTraderMan;
	_mercador setVariable ["mcdr",_forEachIndex mod 20,true];
	_mercador setDir _angle;

	//CREATE ANTIZOMBIE STRUCTURE
	_pos set [2,0];
	_azs = createVehicle [BRPVP_antiZombieStructuresServerCreated call BIS_fnc_SelectRandom,_pos,[],0,"NONE"];
	_azs setDir random 360;
	_azs setVectorUp [0,0,1];
	_azs setVariable ["azs",true,true];
	_azs allowDamage false;

	//ADICIONA MERCADOR NO ARRAY DE MERCADORES
	BRPVP_mercadorObjs pushBack _mercador;
} forEach BRPVP_terrPosArray;
publicVariable "BRPVP_mercadorObjs";

//LOCAIS MERCADORES
BRPVP_mercadoresPos = [];
{
	BRPVP_mercadoresPos pushBack [position _x,50,BRPVP_mercadoresEstoque select ((_x getVariable ["mcdr",-1]) mod (count BRPVP_mercadoresEstoque)) select 1,2];
} forEach BRPVP_mercadorObjs;
publicVariable "BRPVP_mercadoresPos";

//AID TRADERS
{
	_pos = _x select 0;
	_angle = _x select 1;

	//CRIAR O MERCADOR
	_mercador = _pos call _createTraderMan;
	_mercador setVariable ["mcdr",20,true];
	_mercador setVariable ["brpvp_price_level",BRPVP_travelingAidPriceLevel,true];
	_mercador setVariable ["brpvp_item_filter",2,true];
	_mercador setDir _angle;
} forEach BRPVP_travelingAidTraders;

//MERCADOS VEICULOS
BRPVP_vendaveObjs = [];
{
	_x params ["_local","_vndv",["_bigObjs",[]]];
	_contato =  createVehicle ["Land_PhoneBooth_01_F",_local,[],0,"CAN_COLLIDE"];
	_contato allowDamage false;
	_contato setVariable ["vndv",_vndv,true];
	_contato setVariable ["vndv_deployType","x_on_ground",true];
	_contato setVariable ["vndv_big",_bigObjs,true];
	BRPVP_vendaveObjs pushBack _contato;
	_local set [2,0];
	_azs = createVehicle ["Land_Calvary_01_V1_F",[_contato,6,getDir _contato] call BIS_fnc_relPos,[],0,"NONE"];
	_azs setVectorUp [0,0,1];
	_azs setVariable ["azs",true,true];
	_azs allowDamage false;
} forEach (BRPVP_mapaRodando select 16);
publicVariable "BRPVP_vendaveObjs";

//VEHICLE TRADERS POSITIONS
BRPVP_vehicleTradersPos = [];
{BRPVP_vehicleTradersPos pushBack [position _x,50,"",7];} forEach BRPVP_vendaveObjs;
publicVariable "BRPVP_vehicleTradersPos";

//LOCAL TO PLAYER SELL ITEMS
BRPVP_buyersObjs = [];
{
	_idx = BRPVP_sellTerrainPlaces select 1 select _forEachIndex;
	_pt = _x select 0;
	_ang = _x select 1;
	_t = _pt call _createTraderMan;
	_t setDir _ang;
	_t setVariable ["bbx",[[-15,-15,-15],[15,15,15]],true];
	_t setVariable ["bidx",_idx,true];
	BRPVP_buyersObjs pushBack _t;
	_pt set [2,0];
	_azs = createVehicle [BRPVP_antiZombieStructuresServerCreated call BIS_fnc_SelectRandom,_pt,[],0,"NONE"];
	_azs setDir random 360;
	_azs setVectorUp [0,0,1];
	_azs setVariable ["azs",true,true];
	_azs allowDamage false;
} forEach (BRPVP_sellTerrainPlaces select 0);
publicVariable "BRPVP_buyersObjs";

//BUYERS POSITIONS
BRPVP_buyersPos = [];
{BRPVP_buyersPos pushBack [position _x,80,"",3];} forEach BRPVP_buyersObjs;
publicVariable "BRPVP_buyersPos";

//DISMANTLE TRADER
BRPVP_dismantleManObjs = [];
{
	_x params ["_pos","_dir"];
	_dismantleMan = _pos call _createTraderMan;
	_dismantleMan setDir _dir;
	BRPVP_dismantleManObjs pushBack _dismantleMan;
	[
		_dismantleMan,
		{_this addAction ["<t color='#F06040'>"+localize "str_psellveh_action"+"</t>",{113 call BRPVP_iniciaMenuExtra;},objNull,1.49,false,true,""];}
	] remoteExecCall ["call",BRPVP_allNoServer,true];
} forEach BRPVP_dismantleAreasTrader;
publicVariable "BRPVP_dismantleManObjs";

//THIEF TRADER
BRPVP_thiefAreasManObjs = [];
{
	_pos = _x select 0;
	_dir = _x select 1;
	_thiefMan = _pos call _createTraderMan;
	_thiefMan setVariable ["brpvp_thief_guy",true,true];
	_thiefMan setDir _dir;
	BRPVP_thiefAreasManObjs pushBack _thiefMan;
} forEach BRPVP_thiefAreasTrader;
publicVariable "BRPVP_thiefAreasManObjs";

//PRIVATE MINES
{
	_pos = _x select 0;
	_rad = _x select 1;
	_dir = _x select 2;
	_man = _pos call _createTraderMan2;
	_man setDir _dir;
	[
		_man,
		{_this addAction ["<t color='#D0D020'>"+localize "str_master_miner_action"+"</t>",{125 call BRPVP_iniciaMenuExtra;},objNull,1.5,true,true,"","_target distanceSqr _this < 36"];}
	] remoteExecCall ["call",BRPVP_allNoServer,true];
} forEach BRPVP_farmPrivateMines;

//BLACK TRADERS
BRPVP_blackTradersObjs = [];
{
	_x params ["_local","_dir","_name","_type"];
	_building = createVehicle ["Land_Chapel_Small_V1_F",_local,[],0,"CAN_COLLIDE"];
	_building setVariable ["brpvp_can_loot",false,true];
	_contato = [_building buildingPos 0,(getDir _building)-90] call _createTraderMan3;
	_contato setVariable ["vndv",_type,true];
	_contato setVariable ["nm",_name,true];
	_contato setVariable ["vndv_deployType","x_on_ground",true];
	_contato setVariable ["vndv_no_insurance",true,true];
	{createVehicle ["Land_JumpTarget_F",_building getPos _x,[],0,"CAN_COLLIDE"];} forEach [[22,0],[22,120],[22,240]];
	BRPVP_blackTradersObjs pushBack _contato;
} forEach BRPVP_blackTradersPlaces;
publicVariable "BRPVP_blackTradersObjs";

//CLASS AD STORE
{
	private _man = _x call _createTraderMan3;
	_man setVariable ["nm","Arlex",true];
	[
		_man,
		{
			_this addAction ["<t>"+localize "str_class_ad_trader"+"</t>",{175 call BRPVP_iniciaMenuExtra;},objNull,2.500,true,true,"","_target distanceSqr _this < 36"];
			_this addAction ["<t>"+localize "str_class_ad_sell_items"+"</t>",{if (!isNull (player getVariable ["brpvp_box_carry",objNull])) then {180 call BRPVP_iniciaMenuExtra;} else {[localize "str_ca_need_items_on_head"] call BRPVP_hint;};},objNull,2.499,true,true,"","_target distanceSqr _this < 36"];
			_this addAction ["<t>"+localize "str_class_ad_sell_alti"+"</t>",{BRPVP_menuVar2 = -1;190 call BRPVP_iniciaMenuExtra;},objNull,2.498,true,true,"","_target distanceSqr _this < 36"];
		}
	] remoteExecCall ["call",BRPVP_allNoServer,true];
	//REMOVE STUFF AROUND
	{
		private _obj = _x;
		private _noOwner = (_obj getVariable ["own",-1]) isEqualTo -1;
		if ({str _obj find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {_x hideObjectGlobal true;};
	} forEach nearestTerrainObjects [_x select 0,[],120,false];
} forEach BRPVP_classAdTraders;

//PUBLIC CRAFTS
BRPVP_publicBenchs = [];
for "_i" from 1 to BRPVP_numberOfPublicCraftWorkbenchs do {
	_pos = [];
	_found = false;
	_count = 0;
	while {!_found && _count <= 100} do {
		_pos = [BRPVP_centroMapa,0,BRPVP_centroMapaRadius,10,0,0.2,0] call BIS_fnc_findSafePos;
		_xOk = _pos select 0 > 350 && _pos select 0 < (BRPVP_mapaDimensoes select 0)-350;
		_yOk = _pos select 1 > 350 && _pos select 1 < (BRPVP_mapaDimensoes select 1)-350;
		if (count _pos isEqualTo 2 && !isOnRoad _pos && _xOk && _yOk) then {
			_pos pushBack 0;
			_flags = nearestObjects [_pos,["FlagCarrier"],250,true];
			if (_flags isEqualTo []) then {_found = true;};
		};
		_count = _count+1;
	};
	_bench = createVehicle ["Land_WoodenCounter_01_F",[0,0,0],[],100,"NONE"];
	_bench setPosASL AGLToASL _pos;
	_bench setDir random 360;
	_bench setVectorUp surfaceNormal _pos;
	_bench enableSimulationGlobal false;
	_bench setVariable ["brpvp_map",true,true];
	BRPVP_publicBenchs pushBack _bench;
};
publicVariable "BRPVP_publicBenchs";

_allTraders spawn {
	sleep 15;
	{_x enableSimulationGlobal false;} forEach _this;
};

diag_log ("[SCRIPT] servidor_mercados.sqf END: " + str round (diag_tickTime - _scriptStart));