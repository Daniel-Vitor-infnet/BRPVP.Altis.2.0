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

BRPVP_sellStage = 3;
_box = BRPVP_sellReceptacle;
_array = _box call BRPVP_getCargoArrayNoNumber;
_gear = [_array select 0,[[],[]],_array select 3,_array select 2];
_magazines = _array select 1;
_zeroAt = [[],[],[],[]];
_okItems = [];
_totalPrice = 0;
{
	_groupOfItems = _x;
	_groupOfItemsIndex = _forEachIndex;
	{
		private _item = _x;
		private _idx = BRPVP_mercadoItensClass find _item;
		private _base = if (_idx > -1) then {BRPVP_mercadoItens select _idx select 4} else {_item call BRPVP_getGenericPrice};
		private _price = _base*BRPVP_sellPricesMultiplier;
		private _amount = _groupOfItems select 1 select _forEachIndex;
		_totalPrice = _totalPrice+_amount*_price;
		_okItems pushBack [_item,round _price];
		(_zeroAt select _groupOfItemsIndex) pushBack _forEachIndex;
	} forEach (_groupOfItems select 0);
} forEach _gear;
{
	private _toDel = _x;
	private _classes = _gear select _forEachIndex select 0;
	private _amounts = _gear select _forEachIndex select 1;
	_toDel sort false;
	{
		_classes deleteAt _x;
		_amounts deleteAt _x;
	} forEach _toDel;
	_gear set [_forEachIndex,[_classes,_amounts]];
} forEach _zeroAt;

_delAt = [];
{
	private _item = _x select 0;
	private _qItems = _x select 1;
	private _idx = BRPVP_mercadoItensClass find _item;
	private _base = if (_idx > -1) then {BRPVP_mercadoItens select _idx select 4} else {_item call BRPVP_getGenericPrice};
	private _price = _base*_qItems*BRPVP_sellPricesMultiplier;
	_delAt pushBack _forEachIndex;
	_totalPrice = _totalPrice+_price;
	_okItems pushBack [_item,round _price];
} forEach _magazines;
_delAt sort false;
{_magazines deleteAt _x;} forEach _delAt;
_gear set [1,_magazines];

_remain = 0;
{_remain = _remain+(_gear select 0 select 1 select _forEachIndex);} forEach (_gear select 0 select 0);
{_remain = _remain+(_gear select 2 select 1 select _forEachIndex);} forEach (_gear select 2 select 0);
{_remain = _remain+(_gear select 3 select 1 select _forEachIndex);} forEach (_gear select 3 select 0);
{_remain = _remain+1;} forEach (_gear select 1);
_remainTxt = if (_remain > 0) then {format [localize "str_coll_remain",_remain]} else {""};

_totalPrice = round _totalPrice;
[format [localize "str_coll_sell_ok",_totalPrice call BRPVP_formatNumber,_remainTxt],(3.5+_remain*10) min 10,20,155] call BRPVP_hint;
[player,_totalPrice] call BRPVP_qjsAdicClassObjeto;

//COLLECTORS TRADERS LOG
[player,_totalPrice,count _okItems,"collectors"] remoteExecCall ["BRPVP_addTraderLog",2];
[["vendeu",_totalPrice]] call BRPVP_mudaExp;

{
	detach _x;
	deleteVehicle _x;
} forEach (attachedObjects _box);
deleteVehicle _box;

BRPVP_sellStage = 4;