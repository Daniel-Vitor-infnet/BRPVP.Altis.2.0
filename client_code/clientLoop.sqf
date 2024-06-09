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

diag_log "[BRPVP FILE] clientLoop.sqf INITIATED";

//PREPARE ARRAYS THAT ARE NOT IN THE REQUIRED FORMAT
_PVPAreas = BRPVP_PVPAreas apply {[_x select 0,_x select 1,"",12]};
_xpSanctuaries = BRPVP_xpSanctuaryBuildings apply {[ASLToAGL getPosWorld _x,50,"",13]};
_classAdTraders = BRPVP_classAdTraders apply {[_x select 0,100,"",14]};

//DEFINE ARRAY DE POSICOES OTIMIZADO
_posicoesA = BRPVP_locaisDeCura+BRPVP_locaisImportantes+BRPVP_mercadoresPos+BRPVP_buyersPos+BRPVP_vehicleTradersPos+BRPVP_travelingAidPlaces+BRPVP_dismantleAreas+BRPVP_thiefAreas+BRPVP_radioAreas+BRPVP_insurancePlaces+BRPVP_pveMainAreas+BRPVP_zombieSuperSpawnCities+_PVPAreas+_xpSanctuaries+_classAdTraders+BRPVP_specificMapCustomPlaces;

_blackTradersPlaces = BRPVP_blackTradersPlaces apply {[_x select 0,50,_x select 2]};
_classAdTradersNoBuild = BRPVP_classAdTraders apply {[_x select 0,100,"Class Ad"]};
_playerMissions = [];
{
	private _miss = _x;
	_playerMissions append ((_miss select 3) apply {[_x,_miss select 2]});
} forEach (BRPVP_pmissData+BRPVP_pmiss2Data);
BRPVP_placesExtraNobuildArea = [
	[BRPVP_locaisImportantes,BRPVP_noBuildDistInOtherAreas select 0],
	[BRPVP_mercadoresPos,BRPVP_noBuildDistInOtherAreas select 1],
	[BRPVP_buyersPos,BRPVP_noBuildDistInOtherAreas select 2],
	[BRPVP_vehicleTradersPos,BRPVP_noBuildDistInOtherAreas select 3],
	[BRPVP_travelingAidPlaces,BRPVP_noBuildDistInOtherAreas select 4],
	[BRPVP_dismantleAreas,BRPVP_noBuildDistInOtherAreas select 5],
	[BRPVP_thiefAreas,BRPVP_noBuildDistInOtherAreas select 6],
	[BRPVP_eventsData,BRPVP_noBuildDistInOtherAreas select 7],
	[BRPVP_PVPAreas,BRPVP_noBuildDistInOtherAreas select 8],
	[BRPVP_insurancePlaces,BRPVP_noBuildDistInOtherAreas select 9],
	[_blackTradersPlaces,BRPVP_noBuildDistInOtherAreas select 10],
	[BRPVP_farmPrivateMines,BRPVP_noBuildDistInOtherAreas select 11],
	[_playerMissions,BRPVP_noBuildDistInOtherAreas select 12],
	[_classAdTradersNoBuild,BRPVP_noBuildDistInOtherAreas select 13]
];
BRPVP_placesExtraNobuildArea = BRPVP_placesExtraNobuildArea+BRPVP_customNoBuildAreas;
if (BRPVP_raidTrainingMapPosition isEqualTo []) then {
	BRPVP_placesExtraNobuildArea pushBack [[],50];
} else {
	BRPVP_placesExtraNobuildArea pushBack [[[BRPVP_raidTrainingMapPosition,400,"Raid Training"]],100];
};

BRPVP_funcaoMinDistPreCalc = {
	private ["_raioB","_dist","_minDist","_maisPertoDist","_posA","_posB"];
	_posA = _this select 0;
	_minDist = 1000000;
	_maisPertoDist = 1000000;
	{
		_posB = _x select 0;
		_raioB = _x select 1;
		_dist = (_posA distance _posB)-_raioB;
		if (_dist < _minDist && _dist > 0) then {
			_minDist = _dist;
			_maisPertoDist = _dist;
		};
	} forEach (_this select 1);
	_maisPertoDist
};

BRPVP_funcaoMinDistPlayer = {
	private ["_raioB","_dist","_minDist","_maisPertoIdx","_posA","_posB"];
	_posA = _this select 0;
	_minDist = 1000000;
	{
		_posB = _x select 0;
		_raioB = _x select 1;
		_dist = (_posA distance _posB)-_raioB;
		if (_dist < _minDist) then {
			_minDist = _dist;
			_maisPertoIdx = _forEachIndex;
		};
	} forEach (_this select 1);
	_maisPertoIdx
};

BRPVP_posCheckAllLayers = [];
_posicoesARun = +_posicoesA;
while {count _posicoesARun > 0} do {
	_posicoesARunNext = [];
	_posCheckLayer = [];
	{
		_pos = _x select 0;
		_rad = _x select 1;
		_overlap = {_pos distance (_x select 0) <= _rad+(_x select 1)} count _posCheckLayer > 0;
		if (_overlap) then {_posicoesARunNext pushBack _x;} else {_posCheckLayer pushBack (_x select [0,4]);};
	} forEach _posicoesARun;
	_posicoesARun = +_posicoesARunNext;
	BRPVP_posCheckAllLayers pushBack _posCheckLayer;
};

{
	_layerPositions = _x;
	{
		_minDist = [_x select 0,_layerPositions] call BRPVP_funcaoMinDistPreCalc;
		_x pushBack _minDist;
	} forEach _layerPositions;
} forEach BRPVP_posCheckAllLayers;

BRPVP_addNewPosCheckLayer = {
	private _newAddId = -1;
	private _newLayer = false;
	private _pos = _this select 0;
	private _rad = _this select 1;
	_pos set [2,0];
	{
		private _layer = _x;
		private _overlap = {_pos distance (_x select 0) <= _rad+(_x select 1)} count _layer > 0;
		private _pIn = BRPVP_layerNearestCases select _forEachIndex;
		private _noUpdateOk = [ASLToAGL getPosASL vehicle player,_layer+[[_pos,_rad]]] call BRPVP_funcaoMinDistPlayer isEqualTo _pIn;
		private _notStarted = _pIn isEqualTo -1;
		if (!_overlap && (_noUpdateOk || _notStarted)) exitWith {
			_layer pushBack _this;
			_newAddId = _forEachIndex;
		};
	} forEach BRPVP_posCheckAllLayers;
	if (_newAddId isEqualTo -1) then {
		_newAddId = count BRPVP_posCheckAllLayers;
		BRPVP_posCheckAllLayers pushBack [_this];
		BRPVP_layerNearestCases pushBack 0;
		_newLayer = true;
	};
	private _changedLayer = BRPVP_posCheckAllLayers select _newAddId;
	{
		_minDist = [_x select 0,_changedLayer] call BRPVP_funcaoMinDistPreCalc;
		_x set [4,_minDist];
	} forEach _changedLayer;
	if (_newLayer) then {_newAddId spawn BRPVP_inCheckCode;};
};

BRPVP_removePosCheckLayer = { //MAKE V2.0 IN THE FUTURE, THAT REALLY REMOVES THE AREA
	{
		private _layer = _x;
		private _layerId = _forEachIndex;
		private _pIdNow = BRPVP_layerNearestCases select _layerId;
		{
			if (_x select 2 isEqualTo _this) exitWith {
				if (_pIdNow isEqualTo _forEachIndex) then {
					private _center = _x select 0;
					private _rad = _x select 1;
					private _codeIdx = _x select 3;
					if (vehicle player distance _center <= _rad) then {
						_center call (BRPVP_codigoLocais select _codeIdx select 1);
					};
				};
				_x set [3,15];
			};
		} forEach _layer;
	} forEach BRPVP_posCheckAllLayers;
};

BRPVP_inCheckCode = {
	waitUntil {
		waitUntil {player getVariable ["sok",false]};
		private _places = BRPVP_posCheckAllLayers select _this;
		private _pos = ASLToAGL getPosASL vehicle player;
		private _maisPerto = [_pos,_places] call BRPVP_funcaoMinDistPlayer;
		private _placePerto = _places select _maisPerto;
		BRPVP_layerNearestCases set [_this,_maisPerto];
		private _centro = _placePerto select 0;
		private _raio = _placePerto select 1;
		private _inside = _pos distance _centro <= _raio;
		if (_inside) then {
			private _canEnter = call (BRPVP_codigoLocais select (_placePerto select 3) select 2);
			if (_canEnter) then {
				_centro call (BRPVP_codigoLocais select (_placePerto select 3) select 0);
				waitUntil {vehicle player distance _centro > _raio || !(player getVariable ["sok",false])};
				_centro call (BRPVP_codigoLocais select (_placePerto select 3) select 1);
			} else {
				waitUntil {
					_centro call BRPVP_cantEnterMoveOut;
					sleep 0.25;
					_canEnter = call (BRPVP_codigoLocais select (_placePerto select 3) select 2);
					vehicle player distance _centro > _raio || _canEnter
				};
			};
		} else {
			private _dist = _pos distance _centro;
			if (_dist > _raio && _dist < (_placePerto select 4)) then {
				waitUntil {
					_dist = vehicle player distance _centro;
					_dist <= _raio || _dist >= (_placePerto select 4)
				};
			} else {
				private _distMax = _dist-_raio;
				waitUntil {vehicle player distance _pos >= _distMax};
			};
		};
		false
	};
};

//DEFINE CODIGOS QUE RODAM AO ENTRAR E SAIR DE LOCAIS
BRPVP_inBuyersPlace = 0;
BRPVP_safezoneFixAssignedVehicle = -1;
BRPVP_safezoneRefuelAssignedVehicle = -1;
BRPVP_thiefTraderAction = -1;
BRPVP_canStayInSafe = {
	private _veh = vehicle player;
	private _inCombat = {_x getVariable ["cmb",false]} count crew _veh > 0;
	private _deniedVehicle = _veh getVariable ["brpvp_cant_safe",false] || serverTime < _veh getVariable ["brpvp_cant_safe_time",0];
	private _isPlane = _veh isKindOf "Plane";
	private _barrDenied = {typeOf _x in ["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"] && {serverTime < _x getVariable ["brpvp_tire_cantSafeTime",0]}} count attachedObjects player > 0;
	!(_inCombat || _deniedVehicle || _barrDenied) || _isPlane || BRPVP_vePlayers
};
BRPVP_codigoLocais = [
	//HEAL PLACES 00
	[
		{0 spawn BRPVP_curaPlayer;},
		{},
		{true}
	],
	//CITIES 01
	[
		{},
		{},
		{true}
	],
	//ITEM TRADERS 02
	[
		{
			call BRPVP_safeZoneInExtraCode;
			_antenna = + _this;
			_antenna set [2,35];
			[600,0.075,2.5,_antenna,1] call BRPVP_radarAdd;
			[localize "str_radar_local",3.5,12] call BRPVP_hint;
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\trader.paa'/>",0,0,2,0,0,7757] call BRPVP_fnc_dynamicText;
		},
		{
			call BRPVP_safeZoneOutExtraCode;
			_antenna = + _this;
			_antenna set [2,35];
			1 call BRPVP_radarRemove;
		},
		BRPVP_canStayInSafe
	],
	//COLLECTORS 03
	[
		{
			call BRPVP_safeZoneInExtraCode;
			BRPVP_inBuyersPlace = BRPVP_inBuyersPlace+1;
			BRPVP_inBuyersPlace spawn BRPVP_buyersPlace;
			_antenna = +_this;
			_antenna set [2,50];
			[600,0.075,2.5,_antenna,2] call BRPVP_radarAdd;
			[localize "str_radar_local",3.5,12] call BRPVP_hint;
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\collector.paa'/>",0,0,2,0,0,7757] call BRPVP_fnc_dynamicText;
		},
		{
			call BRPVP_safeZoneOutExtraCode;
			BRPVP_inBuyersPlace = BRPVP_inBuyersPlace+1;
			_antenna = +_this;
			_antenna set [2,50];
			2 call BRPVP_radarRemove;
		},
		BRPVP_canStayInSafe
	],
	//TRAVEL AID AREA 04
	[
		{
			call BRPVP_safeZoneInExtraCode;
			BRPVP_safezoneFixAssignedVehicle = player addAction ["<t color='#3398DC'>"+localize "str_aid_fix_veh"+"</t>",{_assigVeh = assignedVehicle player;if (!isNull _assigVeh) then {_assigVeh setDamage 0;"granted" call BRPVP_playSound;[_assigVeh,[0,0,6]] remoteExecCall ["setVelocity",0];sleep (0.6 + random 0.4);[player,["woohoo",200,1 + random 0.4]] remoteExecCall ["say3D",BRPVP_allNoServer];};},objNull,1.49,false,true,"","_assigVeh = assignedVehicle player;!isNull _assigVeh && alive _assigVeh && {(assignedVehicleRole player) select 0 == 'Driver' && {{_x > 0.1} count ((getAllHitPointsDamage _assigVeh+[[],[],[]]) select 2) > 0 && alive _assigVeh && count (_assigVeh nearObjects ['Land_FuelStation_02_workshop_F',25]) > 0 && count (player nearObjects ['Land_FuelStation_02_workshop_F',6.5]) > 0}}"];
			BRPVP_safezoneRefuelAssignedVehicle = player addAction ["<t color='#3398DC'>"+localize "str_aid_refuel_veh"+"</t>",{_assigVeh = assignedVehicle player;if (!isNull _assigVeh) then {_assigVeh setFuel 1;"granted" call BRPVP_playSound;[_assigVeh,[0,0,6]] remoteExecCall ["setVelocity",0];sleep (0.6 + random 0.4);[player,["woohoo",200,1 + random 0.4]] remoteExecCall ["say3D",BRPVP_allNoServer];};},objNull,1.49,false,true,"","_assigVeh = assignedVehicle player;!isNull _assigVeh && alive _assigVeh && {(assignedVehicleRole player) select 0 == 'Driver' && {fuel _assigVeh < 0.99 && alive _assigVeh && count (_assigVeh nearObjects ['Land_Tank_rust_F',25]) > 0 && count (player nearObjects ['Land_Tank_rust_F',6.5]) > 0}}"];
			[localize "str_aid_in",-4] call BRPVP_hint;
		},
		{
			call BRPVP_safeZoneOutExtraCode;
			player removeAction BRPVP_safezoneFixAssignedVehicle;
			player removeAction BRPVP_safezoneRefuelAssignedVehicle;
			[localize "str_aid_out",-4] call BRPVP_hint;
		},
		BRPVP_canStayInSafe
	],
	//DISMANTLE AREA 05
	[
		{
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\dismantle.paa'/>",0,0,2,0,0,7757] call BRPVP_fnc_dynamicText;
			"hint2" call BRPVP_playSound;
		},
		{},
		{true}
	],
	//OBSCURE TRADER 06
	[
		{
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\thief_trader.paa'/>",0,0,2,0,0,7757] call BRPVP_fnc_dynamicText;
			"hint2" call BRPVP_playSound;
			BRPVP_thiefTraderAction = player addAction ["<t color='#FF0000'>"+localize "str_thief_obsc_trader"+"</t>",{BRPVP_itemTraderDiscount = 1;[0,0,0,[player,[13],1,4,"default",9]] execVm "client_code\actions\actionTrader.sqf";},objNull,1.49,false,true,"","cursorObject getVariable ['brpvp_thief_guy',false] && player distanceSqr cursorObject < 16 && BRPVP_xpAllowObscureITems"];
			BRPVP_thiefKillAction = player addAction ["<t color='#FF0000'>"+localize "str_add_kill_funds"+"</t>",{BRPVP_menuVar1 = 0;78 call BRPVP_iniciaMenuExtra;},objNull,1.48,false,true,"","cursorObject getVariable ['brpvp_thief_guy',false] && player distanceSqr cursorObject < 16 && BRPVP_killContractsShowAction"];
			BRPVP_thiefBuyCarrier = player addAction ["<t color='#FF0000'>"+localize "str_act_buy_carrier"+"</t>",{BRPVP_carrierByTrader = true;155 call BRPVP_iniciaMenuExtra;},objNull,1.48,false,true,"","cursorObject getVariable ['brpvp_thief_guy',false] && player distanceSqr cursorObject < 16 && BRPVP_carrierObtainInTrader && BRPVP_xpAllowCarrier"];
		},
		{
			player removeAction BRPVP_thiefTraderAction;
			player removeAction BRPVP_thiefKillAction;
			player removeAction BRPVP_thiefBuyCarrier;
		},
		{true}
	],
	//VEHICLE SHOPS 07
	[	
		{
			call BRPVP_safeZoneInExtraCode;
			_antenna = + _this;
			_antenna set [2,35];
			[600,0.075,2.5,_antenna,1] call BRPVP_radarAdd;
			[localize "str_radar_local",3.5,12] call BRPVP_hint;
			private _img = "shop.paa";
			private _best = 1000000;
			{
				private _pos = _x select 0;
				private _dist = _pos distance2D _this;
				if (_dist < _best) then {
					_best = _dist;
					_img = if (count _x > 3) then {_x select 3} else {"shop.paa"};
				};				
			} forEach (BRPVP_mapaRodando select 16);
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\"+_img+"'/>",0,0,2,0,0,7757] call BRPVP_fnc_dynamicText;
		},
		{
			call BRPVP_safeZoneOutExtraCode;
			_antenna = + _this;
			_antenna set [2,35];
			1 call BRPVP_radarRemove;
		},
		BRPVP_canStayInSafe
	],
	//RADIATION AREAS 08
	[
		{
			private _radioAreasInside = [];
			BRPVP_radioAreasTotalIntensity = 0;
			{
				if (vehicle player distance (_x select 0) <= _x select 1) then {
					_radioAreasInside pushBack [_x select 0,_x select 1,_x select 4];
					BRPVP_radioAreasTotalIntensity = BRPVP_radioAreasTotalIntensity+(_x select 4);
				};
			} forEach BRPVP_radioAreas;
			BRPVP_radioAreasInside = _radioAreasInside;
			if (BRPVP_radioEnterTime isEqualTo -1)then {BRPVP_radioEnterTime = time;};
		},
		{
			private _radioAreasInside = [];
			BRPVP_radioAreasTotalIntensity = 0;
			{
				if (vehicle player distance (_x select 0) <= _x select 1) then {
					_radioAreasInside pushBack [_x select 0,_x select 1,_x select 4];
					BRPVP_radioAreasTotalIntensity = BRPVP_radioAreasTotalIntensity+(_x select 4);
				};
			} forEach BRPVP_radioAreas;
			BRPVP_radioAreasInside = _radioAreasInside;
			if (BRPVP_radioAreasInside isEqualTo [])then {BRPVP_radioEnterTime = -1;};
		},
		{true}
	],
	//INSURANCE TRADERS 09
	[
		{
			call BRPVP_safeZoneInExtraCode;
			_antenna = + _this;
			_antenna set [2,35];
			[600,0.075,2.5,_antenna,1] call BRPVP_radarAdd;
			[localize "str_radar_local",3.5,12] call BRPVP_hint;
			["<img shadow='0' size='3.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\insurance.paa'/>",0,0,2,0,0,7757] call BRPVP_fnc_dynamicText;
		},
		{
			call BRPVP_safeZoneOutExtraCode;
			_antenna = + _this;
			_antenna set [2,35];
			1 call BRPVP_radarRemove;
		},
		BRPVP_canStayInSafe
	],
	//PVE AREAS 10
	[
		{
			_inside = player getVariable ["brpvp_pve_inside",0];
			_insidePVP = player getVariable ["brpvp_in_pvp_zone",0];
			
			//REMOVE FROM PVE VEHICLE IF BANDIT
			if (_inside isEqualTo 0) then {
				if (player call BRPVP_isBanditInGoodVeh) then {
					0 spawn {
						sleep 0.001;
						private _txt = format ["<img align='center' size='2.5' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\bandit.paa'/><br /><t size='1.0' align='center'>%1</t>",localize "str_bandit_will_be_ejected"];
						private _count = 0;
						private _inside = 1;
						private _ibigv = true;
						waitUntil {
							[_txt,0,0,1.5,0,0,8395] call BRPVP_fnc_dynamicText;
							"error2" call BRPVP_playSound;
							sleep 2;
							_inside = player getVariable ["brpvp_pve_inside",0];
							_ibigv = player call BRPVP_isBanditInGoodVeh;
							_count = _count+1;
							_inside isEqualTo 0 || isNull objectParent player || !_ibigv || _count isEqualTo 10
						};
						if !(_inside isEqualTo 0 || isNull objectParent player || !_ibigv) then {moveOut player;};
					};
				};
			};
			
			player setVariable ["brpvp_pve_inside",_inside+1,true];
			if (_inside isEqualTo 0 && _insidePVP isEqualTo 0) then {
				["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\pve.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.29},1000000,0,0,3097] call BRPVP_fnc_dynamicText;
			};
			BRPVP_superJumpCount = BRPVP_superJumpCount+1;
			[] remoteExecCall ["BRPVP_calcPveFriends",BRPVP_allNoServer];
		},
		{
			_inside = player getVariable "brpvp_pve_inside";
			_insidePVP = player getVariable ["brpvp_in_pvp_zone",0];

			player setVariable ["brpvp_pve_inside",_inside-1,true];
			if (_inside-1 isEqualTo 0 && _insidePVP isEqualTo 0) then {
				["",0,0,0,0,0,3097] call BRPVP_fnc_dynamicText;
			};
			
			BRPVP_superJumpCount = BRPVP_superJumpCount-1;
			[] remoteExecCall ["BRPVP_calcPveFriends",BRPVP_allNoServer];
		},
		{true}
	],
	//SUPER SPAWN ZOMBIES 11
	[
		{
			BRPVP_superZombiesOldConfig = [BRPVP_kneelingJumpZombiesPercentage,BRPVP_percentageOfJumpWhenHit,BRPVP_zombieKillRewardBase,BRPVP_zombieMaxLocalPerPlayer,BRPVP_zombieMaxLocal,BRPVP_zombieFactorLimit,BRPVP_zombieCoolDown,BRPVP_zombieSpawnTemplate,BRPVP_defaultZombieStyle];
			BRPVP_kneelingJumpZombiesPercentage = BRPVP_kneelingJumpZombiesPercentageB;
			BRPVP_percentageOfJumpWhenHit = BRPVP_percentageOfJumpWhenHitB;
			BRPVP_zombieKillRewardBase = BRPVP_zombieKillRewardBaseB;
			BRPVP_zombieMaxLocalPerPlayer = BRPVP_zombieMaxLocalPerPlayerB;
			BRPVP_zombieMaxLocal = BRPVP_zombieMaxLocalB;
			BRPVP_zombieFactorLimit = BRPVP_zombieFactorLimitB;
			BRPVP_zombieCoolDown = BRPVP_zombieCoolDownB;
			BRPVP_zombieSpawnTemplate = BRPVP_zombieSpawnTemplateB;
			BRPVP_defaultZombieStyle = BRPVP_defaultZombieStyleB;
			"wolf" call BRPVP_playSound;
			player setVariable ["brpvp_in_infected_city",true,true];
		},
		{
			BRPVP_kneelingJumpZombiesPercentage = BRPVP_superZombiesOldConfig select 0;
			BRPVP_percentageOfJumpWhenHit = BRPVP_superZombiesOldConfig select 1;
			BRPVP_zombieKillRewardBase = BRPVP_superZombiesOldConfig select 2;
			BRPVP_zombieMaxLocalPerPlayer = BRPVP_superZombiesOldConfig select 3;
			BRPVP_zombieMaxLocal = BRPVP_superZombiesOldConfig select 4;
			BRPVP_zombieFactorLimit = BRPVP_superZombiesOldConfig select 5;
			BRPVP_zombieCoolDown = BRPVP_superZombiesOldConfig select 6;
			BRPVP_zombieSpawnTemplate = BRPVP_superZombiesOldConfig select 7;
			BRPVP_defaultZombieStyle = BRPVP_superZombiesOldConfig select 8;
			player setVariable ["brpvp_in_infected_city",false,true];
			BRPVP_zombieFactor = 0;
			ZBL_zombieFactorPercentageLast = 0;
		},
		{true}
	],
	//PVP ZONES 12
	[
		{
			_insidePVE = player getVariable ["brpvp_pve_inside",0];
			_insidePVP = player getVariable ["brpvp_in_pvp_zone",0];
			player setVariable ["brpvp_in_pvp_zone",_insidePVP+1,true];
			if (_insidePVP isEqualTo 0) then {
				["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\pvp.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.29},1000000,0,0,3097] call BRPVP_fnc_dynamicText;
			};
		},
		{
			_insidePVE = player getVariable ["brpvp_pve_inside",0];
			_insidePVP = player getVariable ["brpvp_in_pvp_zone",0];
			player setVariable ["brpvp_in_pvp_zone",_insidePVP-1,true];
			if (_insidePVP isEqualTo 1) then {
				if (_insidePVE > 0) then {
					["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\pve.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.29},1000000,0,0,3097] call BRPVP_fnc_dynamicText;
				} else {
					["",0,0,0,0,0,3097] call BRPVP_fnc_dynamicText;
				};
			};
		},
		{true}
	],
	//XP SANCTUARY 13
	[
		{
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/><br /><t>"+localize "str_xp_press_f2_a"+"</t><br /><t>"+localize "str_xp_press_f2_b"+"</t>",0,0,25,0,0,13856] call BRPVP_fnc_dynamicText;
			"box_upgrade" call BRPVP_playSound;
			_this spawn {
				private _asl1 = AGLToASL _this;
				private _obj = nearestObject _this;
				uiSleep 0.125;
				if (_this distance player <= 50 && !isNull _obj) then {
					waitUntil {
						private _asl2 = if (isNull objectParent player) then {player modelToWorldWorld (player selectionPosition "spine2")} else {getPosWorld objectParent player};
						private _lis = lineIntersectsSurfaces [_asl1,_asl2,_obj,objNull,true,-1,"VIEW","FIRE",true];
						if (_lis isNotEqualTo []) then {
							{
								if ((_x select 2) isEqualTo vehicle player) exitWith {
									_asl2 = (_x select 0);
									_asl2 = _asl2 vectorAdd (vectorNormalized (_asl1 vectorDiff _asl2) vectorMultiply 0.125);
								};
							} forEach _lis;
						};
						private _vec = _asl1 vectorDiff _asl2;
						drawLaser [_asl2,_vec,[0,0,1000],[0,0,10000],0.75,2,vectorMagnitude _vec,false];
						_this distance player > 50
					};
				};
			};
		},
		{
			["",0,0,0,0,0,13856] call BRPVP_fnc_dynamicText;
		},
		{true}
	],
	//CLASSIFIED ADS TRADER 14
	[
		{
			call BRPVP_safeZoneInExtraCode;
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>",0,0,2,0,0,25857] call BRPVP_fnc_dynamicText;
			[localize "str_safezone_in",-4] call BRPVP_hint;
			BRPVP_classAdInside = true;
		},
		{
			call BRPVP_safeZoneOutExtraCode;
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>",0,0,2,0,0,25857] call BRPVP_fnc_dynamicText;
			[localize "str_safezone_out",-4] call BRPVP_hint;
			BRPVP_classAdInside = false;
		},
		{true}
	],
	//REMOVED CUSTOM CHECKS USES THIS CODE FOR IN/OUT 15
	[
		{},
		{},
		{true}
	],
	//SPECIFIC MAP CUSTOM PLACES WITH SAFEZONE 16
	[
		{
			call BRPVP_safeZoneInExtraCode;
			["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"map_specific\icons\saint_conrad.paa'/><br /><t>"+localize "str_saint_conrad_welcome"+"</t>",0,0,5,0,0,128] call BRPVP_fnc_dynamicText;
		},
		{call BRPVP_safeZoneOutExtraCode;},
		{true}
	]
];

//COLOCA ICONES DOS LOCAIS NO MAPA
_pveA = if (BRPVP_pveMakeAllMapPve) then {0} else {0.25};
{
	_pos = _x select 0;
	_raio = _x select 1;
	_nome = _x select 2;
	_tipo = _x select 3;
	if (({_pos distance (_x select 0) < 1} count BRPVP_respawnPlaces) isEqualTo 0) then {
		private _alpha = [0.25,0.25,0.25,0.25,0.25,0,0,0.25,0.325,0.25,_pveA,0,0,0,0.25,0,0.25] select _tipo;
		private _color = [[0,1,0,1],[1,1,1,1],[1,1,0,1],[1,1,0,1],[1,105/255,180/255,1],[0.659,0.549,0.376,1],[1,1,1,1],[1,1,0,1],[0,1,0,1],[1,1,0,1],[0,0,1,1],[1,105/255,180/255,1],[0,0,1,1],[1,1,0,1],[1,1,0,1],[0,0,0,0],[0.8,0.8,1,1]] select _tipo;
		private _group = ["in_out","in_out","trader","trader","trader","trader","trader","trader","in_out","trader","in_out","in_out","in_out","in_out","trader","in_out","in_out"] select _tipo;
		_color set [3,_alpha];
		[_group,toUpper _group+"_AREA",_pos,_color,_raio] call BRPVP_adicionaIconeLocalArea;
	};
} forEach _posicoesA;
{
	_pos = _x select 0;
	_raio = _x select 1;
	["in_out","LOCAIS_RESPAWN_"+str _forEachIndex,_pos,[1,0.5,0,0.25],_raio] call BRPVP_adicionaIconeLocalArea;
} forEach BRPVP_respawnPlaces;
{
	_x params ["_center","_radius","_name","_codeIndex"];
	["trader","DOT_AID_AREA_"+str _forEachIndex,_center,[1,140/255,0,1],(localize "str_aid_title")+" "+_name,"mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
} forEach BRPVP_travelingAidPlaces;
{
	private _pos = _x select 0;
	["trader","INSURANCE_"+str _forEachIndex,_pos,[1,1,0,1],localize "str_insurance_icon","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
} forEach BRPVP_insurancePlaces;
{
	private _name = _x select 0;
	private _pos = _x select 1;
	private _rad = _x select 2;
	["in_out","MINE_"+str _forEachIndex,_pos,[0.75,0.75,0.75,1],_name,"mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
	["in_out","MINE_AREA_"+str _forEachIndex,_pos,[0.65,0.65,0.65,0.25],_rad] call BRPVP_adicionaIconeLocalArea;
} forEach BRPVP_farmSpecialAreasOre;
{
	private _pos = _x select 0;
	private _rad = _x select 1;
	["trader","PMINE_"+str _forEachIndex,_pos,[0.75,0.75,0.75,1],localize "str_private_mine","mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
	["trader","PMINE_AREA_"+str _forEachIndex,_pos,[0.65,0.65,0.65,0.25],_rad] call BRPVP_adicionaIconeLocalArea;
} forEach BRPVP_farmPrivateMines;
if (!BRPVP_pveMakeAllMapPve) then {
	{
		_pos = _x select 0;
		_name = _x select 2;
		["in_out","PVE_DOT_"+str _forEachIndex,_pos,[0,0,1,1],_name,"mil_dot.paa",BRPVP_iSizeMilDot] call BRPVP_adicionaIconeLocal;
	} forEach BRPVP_pveMainAreas;
};
{
	_pos = _x select 0;
	_rad = _x select 1;
	["RESP_CITY_1_"+str _forEachIndex,_pos,"ColorBrown",_rad+50,1.00,"Border"] call BRPVP_addLocalIconsAreaNoObj;
	["RESP_CITY_2_"+str _forEachIndex,_pos,"ColorBrown",_rad+60,0.75,"Border"] call BRPVP_addLocalIconsAreaNoObj;
	["RESP_CITY_3_"+str _forEachIndex,_pos,"ColorBrown",_rad+70,0.50,"Border"] call BRPVP_addLocalIconsAreaNoObj;
	["RESP_CITY_4_"+str _forEachIndex,_pos,"ColorBrown",_rad+80,0.25,"Border"] call BRPVP_addLocalIconsAreaNoObj;
} forEach BRPVP_respawnPlaces;

//MONITORA ENTRADA E SAIDA DOS LOCAIS
BRPVP_busStopAction = -1;
diag_log ("[BRPVP] Number of pos_check_layers is: "+str count BRPVP_posCheckAllLayers);
BRPVP_cantEnterMoveOut = {
	if (player getVariable ["brpvp_no_col_safe_repel",1] isEqualTo 1) then {
		player setVariable ["brpvp_no_col_safe_repel",0];
		player spawn {
			private _player = _this;
			waitUntil {!alive _player || getPos _player select 2 < 0.2 || isTouchingGround _player};
			uiSleep 1.25;
			player setVariable ["brpvp_no_col_safe_repel",1];
		};
	};
	private _veh = objectParent player;
	private _vecFromCenter2D = ((getPosWorld vehicle player) vectorDiff AGLToASL _this) select [0,2];
	if (_vecFromCenter2D isEqualTo [0,0]) then {_vecFromCenter2D = [1,1];};
	private _velocity = (vectorNormalized (_vecFromCenter2D+[0]) vectorMultiply 10) vectorAdd [0,0,5];
	if (isNull _veh) then {[player,_velocity] remoteExecCall ["setVelocity",0];} else {if (local driver _veh) then {[_veh,_velocity] remoteExecCall ["setVelocity",0];};};
	[player,["shazam",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
	[localize "str_szone_cant_enter",-6] call BRPVP_hint;
};
BRPVP_layerNearestCases = BRPVP_posCheckAllLayers apply {-1};
{_forEachIndex spawn BRPVP_inCheckCode;} forEach BRPVP_posCheckAllLayers;
{_x call BRPVP_addNewPosCheckLayer;} forEach BRPVP_extraPosCheckSv;
{_x call BRPVP_radioAreasAddArea;} forEach BRPVP_radioAreasExtra; //ADD EXTRA RADIO PLACES

//MONITOR CENTRAL
0 spawn {
	BRPVP_fpsRecord = diag_fps;
	BRPVP_surrended = objNull;
	BRPVP_surrendedWeaponHolder = objNull;
	BRPVP_actionRunning = [];
	BRPVP_actionRadarCut = -1;
	BRPVP_nearNowLast = [];
	BRPVP_specVarsToSend = [];
	BRPVP_specVarsNearPlayersToSend = [];
	_lastOvercast = overcast;
	_scaseInfec = true;
	_playTimeAcu = 0;
	_vehXpTimeAcu = 0;
	_lastVehXp = objNull;
	_walkLastPos = [0,0,0];
	_walkAcumulated = 0;
	_vehLsLast = [];
	_plyLsLast = [];
	_vehFuelLast = objNull;
	_vehFuelTank = -1;
	_labIsOn = false;
	_labSpoted = [];
	_hSDLimit = 100;
	_averageDamageStep = 1/(3*60/10);
	_lastSign = objNull;
	_baseSignIsOn = false;
	_baseSignCurrTxt = "";
	_sixthSenseCfgLast = [];
	_inicio0_25 = diag_tickTime;
	_inicio0_5 = diag_tickTime;
	_inicio1 = diag_tickTime;
	_inicio2_5 = diag_tickTime;
	_inicio5 = diag_tickTime;
	_inicio10 = diag_tickTime;
	_inicio30 = diag_tickTime;
	_inicioMNY = diag_tickTime;
	_bin1 = false;
	_bin2 = false;
	_cycleMNY = 0;
	_menuOffTime = 0;
	_weatherDebugMachinesOnLast = +BRPVP_weatherDebugMachinesOn;

	//RADIATION
	_radioScreamTick = 0;
	_radioScreamTickMax = 0;
	_radioAreaOn = false;
	_lastRadIntensity = 0;
	_handleRadEffect = -1;
	_priority = 2005;
	while {_handleRadEffect isEqualTo -1} do {
		_handleRadEffect = ppEffectCreate ["FilmGrain",_priority];
		_priority = _priority + 1;
	};
	_handleRadEffect ppEffectAdjust [0.005,1.25,2.01,0.75,1,0];
	_handleRadEffect ppEffectCommit 0;
	_handleRadEffect ppEffectEnable true;
	_handleRadEffect ppEffectEnable false;

	//VODKA
	_lastVodkaIntensity = 0;
	_handleVodkaEffect = -1;
	_priority = 410;
	while {_handleVodkaEffect isEqualTo -1} do {
		_handleVodkaEffect = ppEffectCreate ["DynamicBlur",_priority];
		_priority = _priority + 1;
	};
	_handleVodkaEffect ppEffectAdjust [0.005];
	_handleVodkaEffect ppEffectCommit 0;
	_handleVodkaEffect ppEffectEnable true;
	_handleVodkaEffect ppEffectEnable false;

	//MONITORA EVENTOS
	_noCrosshairDetection = BRP_kitRespawnB+BRP_kitSmallLights+BRP_kitHelipad+BRP_kitCamuflagem+["Land_JumpTarget_F","I_HMG_01_high_F","I_HMG_01_F","I_GMG_01_high_F","I_GMG_01_F","I_static_AT_F","I_static_AA_F","Land_Suitcase_F","Land_Razorwire_F","Land_Obstacle_RunAround_F","RoadBarrier_F","Sign_Sphere200cm_F","Land_QuayConcrete_01_outterCorner_F"];
	_noCrosshairDetectionBig = ["Land_QuayConcrete_01_outterCorner_F"];
	_findAllNearExlude = ["","GroundWeaponHolder","WeaponHolderSimulated","Land_Suitcase_F"];
	_allActionsVars = ["brpvp_act_0","brpvp_act_1","brpvp_act_2_1","brpvp_act_2_2","brpvp_act_3","brpvp_act_5_1","brpvp_act_5_2","brpvp_act_5_3","brpvp_act_5_4","brpvp_act_5_5","brpvp_act_6","brpvp_act_7","brpvp_act_8","brpvp_act_9","brpvp_act_10","brpvp_act_11","brpvp_act_12","brpvp_act_13","brpvp_act_14","brpvp_act_15","brpvp_act_16","brpvp_act_17","brpvp_act_18","brpvp_act_19","brpvp_act_20","brpvp_act_21","brpvp_act_22_1","brpvp_act_22_2","brpvp_act_23A","brpvp_act_23B","brpvp_act_24","brpvp_act_25","brpvp_act_26","brpvp_act_27","brpvp_act_28","brpvp_act_29","brpvp_act_30","brpvp_act_31","brpvp_act_32","brpvp_act_33","brpvp_act_34","brpvp_act_35","brpvp_act_36","brpvp_act_37","brpvp_act_38","brpvp_act_39","brpvp_act_41","brpvp_act_42","brpvp_act_43","brpvp_act_44","brpvp_act_45"];
	_objsLast = [];
	_objsActionsCheckNullA = [];
	_objsActionsCheckNullB = [];
	BRPVP_fradeBigOnRad = [];
	BRPVP_fradeLastNonEmpty = -10;
	BRPVP_baseMineTempCode = {
		if (!BRPVP_vePlayers && isNull BRPVP_baseMineDefuse) then {
			private _nm = player nearEntities ["Land_Can_V2_F",BRPVP_fradeDistance] select {
				private _lis = lineIntersectsSurfaces [eyePos player,getPosWorld _x,player,_x,true,1,"GEOM","NONE",true];
				private _lisOk = _lis isEqualTo [] || {(_lis select 0 select 2) getVariable ["brpvp_fbo_ifm",false]};
				private _isEnemy = !((player getVariable ["id_bd",-1]) in (_x getVariable ["brpvp_mine_base_friends",[]]));
				_lisOk && _x getVariable ["brpvp_mine_base",false] && _isEnemy
			};
			if (_nm isEqualTo []) then {
				BRPVP_fradeLastNonEmpty = -10;

				//EXIT MINES
				{deleteVehicle (_x getVariable "brpvp_fbo");} forEach BRPVP_fradeBigOnRad;
				if (BRPVP_fradeBigOnRad isNotEqualTo []) then {[[],BRPVP_fradeBigOnRad] remoteExecCall ["BRPVP_bigFrantaSpectatorCode",BRPVP_specOnMeMachinesNoMe];};
				BRPVP_fradeBigOnRad = [];
			} else {
				private _mine = _nm select 0;
				if (_mine distance player <= 4) then {
					private _fbo = _mine getVariable ["brpvp_fbo",objNull];
					if (!isNull _fbo) then {
						BRPVP_fradeBigOnRad = BRPVP_fradeBigOnRad-[_fbo];
						deleteVehicle _fbo;
					};
					_mine setVariable ["brpvp_mine_base",false,true];
					BRPVP_baseMineDefuse = _mine;
					_mine spawn {
						_mine = _this;
						[_mine,["base_mine",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
						[_mine,["fuse",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
						["<img shadow='0' align='center' size='5' image='"+BRPVP_imagePrefix+"BRP_imagens\base_mine.paa'/>",0,0,2,0,0,435] call BRPVP_fnc_dynamicText;
						_init = time;
						waitUntil {isNull _mine || time-_init >= BRPVP_fantaMinesExplosionDelay};
						if (isNull _mine) then {
							["<img shadow='0' align='center' size='5' image='"+BRPVP_imagePrefix+"BRP_imagens\base_mine_defuse.paa'/>",0,0,2,0,0,435] call BRPVP_fnc_dynamicText;
							"defuse_win" call BRPVP_playSound;
							sleep 1.5;
							["",0,0,0,0,0,14365] call BRPVP_fnc_dynamicText;
						} else {
							BRPVP_baseMineDefuse = objNull;
							["",0,0,0,0,0,14365] call BRPVP_fnc_dynamicText;
							private _owner = _mine getVariable "brpvp_mine_base_owner";
							private _found = objNull;
							{
								_isSok = _x getVariable ["sok",false];
								_idOk = _x getVariable ["id_bd",-1] isEqualTo _owner;
								if (_isSok && _idOk) exitWith {_found = _x;};
							} forEach call BRPVP_playersList;
							[_mine,_found] remoteExec ["BRPVP_fantaMineExplode",2];
						};
					};
				} else {
					if (BRPVP_fradeOn && diag_tickTime-BRPVP_fradeLastNonEmpty > 3 && _mine distance player <= 11) then {
						if (!BRPVP_menuExtraLigado) then {
							private _mId = _mine getVariable ["brpvp_mine_base_id",0];
							if (_mId isEqualTo 0) then {
								private _mPos = getPosASL _mine;
								_mId = ((_mPos select 0)+(_mPos select 1)+(_mPos select 2))/3;
								_mId = (round _mId) mod 1000;
							};
							["<img shadow='0' align='center' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\base_mine_near.paa'/><br />"+str _mId,0,0,1.5,0,0,435] call BRPVP_fnc_dynamicText;
							"alert" call BRPVP_playSound;
						};
						BRPVP_fradeLastNonEmpty = diag_tickTime;
					};

				};
				if (BRPVP_fradeBigOn) then {
					private _new = _nm-BRPVP_fradeBigOnRad;
					private _leave = BRPVP_fradeBigOnRad-_nm;
					//NEW MINES
					private _sizeMult = BRPVP_fantaMinesBigAlertSize;
					{
						private _fbo = createSimpleObject ["Land_Can_V2_F",getPosASL _x,true];
						private _dh = (getPosWorld _fbo select 2)-(getPosASL _fbo select 2);
						_fbo setObjectScale _sizeMult;
						_fbo setPosWorld (getPosWorld _fbo vectorAdd [0,0,(_sizeMult-1)*_dh]);
						_fbo setVariable ["brpvp_fbo_ifm",true];
						_x setVariable ["brpvp_fbo",_fbo];
					} forEach _new;
					//EXIT MINES
					{deleteVehicle (_x getVariable "brpvp_fbo");} forEach _leave;
					if (_new isNotEqualTo [] || _leave isNotEqualTo []) then {[_new,_leave] remoteExecCall ["BRPVP_bigFrantaSpectatorCode",BRPVP_specOnMeMachinesNoMe];};
					BRPVP_fradeBigOnRad = _nm;
				} else {
					//EXIT MINES
					{deleteVehicle (_x getVariable "brpvp_fbo");} forEach BRPVP_fradeBigOnRad;
					if (BRPVP_fradeBigOnRad isNotEqualTo []) then {[[],BRPVP_fradeBigOnRad] remoteExecCall ["BRPVP_bigFrantaSpectatorCode",BRPVP_specOnMeMachinesNoMe];};
					BRPVP_fradeBigOnRad = [];
				};
			};
		};
	};
	BRPVP_recordUseVehTempCode = {
		private _vehXp = objectParent player;
		if (isNull _vehXp) then {
			[_lastVehXp,_vehXpTimeAcu] call BRPVP_giveXpUseVeh;
			_lastVehXp = objNull;
			_vehXpTimeAcu = 0;
		} else {
			if (_vehXp isEqualTo _lastVehXp || isNull _lastVehXp) then {
				_posLast = _vehXp getVariable ["brpvp_record_pos",[0,0,0]];
				_posNow = getPosWorld _vehXp;
				_dist = vectorMagnitude (_posNow vectorDiff _posLast);
				if (_dist > 35) then {
					_vehXp setVariable ["brpvp_record_pos",_posNow];
					_vehXpTimeAcu = _vehXpTimeAcu+10;
					if (_vehXpTimeAcu >= 60) then {
						[_vehXp,_vehXpTimeAcu] call BRPVP_giveXpUseVeh;
						_vehXpTimeAcu = 0;
					};
				};
				_lastVehXp = _vehXp;
			} else {
				[_lastVehXp,_vehXpTimeAcu] call BRPVP_giveXpUseVeh;
				_lastVehXp = _vehXp;
				_vehXpTimeAcu = 0;
			};
		};
	};
	BRPVP_giveXpUseVeh = {
		params ["_veh","_t"];
		if (_t > 0 && !isNull _veh) then {
			if (_veh isKindOf "LandVehicle") then {[["landvehicle",_t]] call BRPVP_mudaExp};
			if (_veh isKindOf "Helicopter") then {[["helicopter",_t]] call BRPVP_mudaExp};
			if (_veh isKindOf "Plane") then {[["plane",_t]] call BRPVP_mudaExp};
			if (_veh isKindOf "Ship") then {[["ship",_t]] call BRPVP_mudaExp};
		};
	};
	BRPVP_tempRecordPlayedHours = {
		if (player getVariable ["sok",false]) then {
			_playTimeAcu = _playTimeAcu+10;
			if (_playTimeAcu >= 60) then {
				[["hours_played",60/3600]] call BRPVP_mudaExp;
				_playTimeAcu = 0;
			};
		};
	};
	BRPVP_itemsMagneticLoopErrorTime = 0;
	BRPVP_itemsMagneticLoopHandle = scriptNull;
	BRPVP_itemsMagneticLoop = {
		if (BRPVP_itemMagnetOn) then {
			if (BRPVP_magnetBetterAttraction) then {
				private _nearAlivePlayers = player nearEntities [BRPVP_playerModel,5.75];
				if (_nearAlivePlayers isEqualTo [player]) then {
					private _nbx = (nearestObjects [player,["ReammoBox_F"],2])-((player getVariable "brpvp_carry_objs")+BRPVP_inventoryBoxes);
					_nbx = _nbx select {_x call BRPVP_checaAcesso && isNull attachedTo _x && !isObjectHidden _x && _x getVariable ["id_bd",-1] isEqualTo -1 && _x getVariable ["own","no"] isEqualTo "no" && !(_x getVariable ["brpvp_ttg_used",false])};
					if (_nbx isNotEqualTo []) then {
						private _nearPlayers = ((player nearEntities [BRPVP_playerModel,500]) apply {_x getVariable ["brpvp_machine_id",-1]})-[-1];
						{
							(_x getVariable ["brpvp_mbots",[[0,0,0],0,[]]]) params ["_pos","_rad","_ais"];
							private _dead = {!alive _x || _x distance _pos > _rad} count _ais;
							if (_dead >= round (BRPVP_killPercToLiberateBox*count _ais) || BRPVP_vePlayers) then {
								_x setVariable ["brpvp_ttg_used",true,_nearPlayers];
								[_x,ASLToATL getPosASL player] remoteExecCall ["BRPVP_localMoveItemsToGround",_x];
							};
						} forEach _nbx;
					};
				};

				private _nearBodies = (nearestObjects [player,["CaManBase"],2]) select {isNull objectParent _x && _x getVariable ["BRPVP_ai",false] && !alive _x && !(_x getVariable ["brpvp_ttg_used",false])};
				if (_nearBodies isNotEqualTo []) then {
					private _nearPlayers = ((player nearEntities [BRPVP_playerModel,500]) apply {_x getVariable ["brpvp_machine_id",-1]})-[-1];
					{
						_x setVariable ["brpvp_ttg_used",true,_nearPlayers];
						[_x,objNull,ASLToATL getPosASL player] remoteExecCall ["BRPVP_transferUnitCargoB",_x];
					} forEach _nearBodies;
				};
			};
			private _objs = player getVariable "brpvp_carry_objs";
			private _nwh = (nearestObjects [player,["WeaponHolderSimulated","GroundWeaponHolder"],2])-(_objs+BRPVP_inventoryBoxes);
			_nwh = (_nwh apply {if (_x call BRPVP_checaAcesso && isNull attachedTo _x) then {_x} else {-1}})-[-1];
			{if (_x getVariable ["ml_takes",-1] > -1) then {_x setVariable ["ml_takes",-1,true];};} forEach _nwh;
			if (_nwh isNotEqualTo []) then {
				if (BRPVP_itemMagnetAllMass < BRPVP_magnetHolderCargoLimitAllPools) then {
					if (scriptDone BRPVP_itemsMagneticLoopHandle) then {
						BRPVP_itemMagnetCanServerReturn = nil;
						[clientOwner,_nwh] remoteExecCall ["BRPVP_itemMagnetCanServer",2];
						BRPVP_itemsMagneticLoopHandle = [_objs,_nwh] spawn {					
							waitUntil {!isNil "BRPVP_itemMagnetCanServerReturn"};
							params ["_objs","_nwh"];
							if (BRPVP_itemMagnetCanServerReturn isNotEqualTo []) then {
								_objs = _objs apply {[9999-(_x call BRPVP_getContainerMass),_x]};
								_objs sort false;
								_oSpace = _objs apply {_x select 0};
								_objs = _objs apply {_x select 1};
								{
									private _wh = _x;
									private _cost = _wh call BRPVP_getContainerMass;
									private _found = false;
									BRPVP_itemMagnetAllMass = BRPVP_itemMagnetAllMass+_cost;
									{
										if (_cost < _x && (9999-_x)+_cost < BRPVP_magnetHolderCargoLimit) exitWith {
											private _receiver = _objs select _forEachIndex;
											[_receiver,_wh call BRPVP_getCargoArrayMagnet] call BRPVP_putItemsOnCargoMagnet;
											deleteVehicle _wh;
											_found = true;
										};
									} forEach _oSpace;
									if (!_found) then {
										private _whMass = _wh call BRPVP_getContainerMass;
										if (_whMass <= BRPVP_magnetHolderCargoLimit) then {
											player setVariable ["brpvp_carry_objs",(player getVariable "brpvp_carry_objs")+[_wh],[clientOwner,2]];
											_wh attachTo [player,[-0.4+random 0.8,-0.4+random 0.8,0.8+random 1]];
											_objs pushBack _wh;
											_oSpace pushBack (9999-_whMass);
										} else {
											private _splitedWh = [_wh,BRPVP_magnetHolderCargoLimit] call BRPVP_splitCargoArrayMany;
											player setVariable ["brpvp_carry_objs",(player getVariable "brpvp_carry_objs")+_splitedWh,[clientOwner,2]];
											deleteVehicle _wh;
											{
												private _sm = _x call BRPVP_getContainerMass;
												_x attachTo [player,[-0.4+random 0.8,-0.4+random 0.8,0.8+random 1]];
												_objs pushBack _x;
												_oSpace pushBack (9999-_sm);
											} forEach _splitedWh;
										};
									};
									if (BRPVP_itemMagnetAllMass > BRPVP_magnetHolderCargoLimitAllPools) exitWith {};
								} forEach BRPVP_itemMagnetCanServerReturn;
								[player,["magnet",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
								[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\magnet.paa'/><br />%1/%2",ceil BRPVP_itemMagnetAllMass,BRPVP_magnetHolderCargoLimitAllPools],0,0.25,2,0,0,53214] call BRPVP_fnc_dynamicText;
								0 spawn {
									uiSleep 1;
									private _data = player getVariable "brpvp_carry_objs";
									private _dataNew = _data-[objNull];
									if (_dataNew isNotEqualTo _data) then {player setVariable ["brpvp_carry_objs",_dataNew,[clientOwner,2]];};
								};
							};
						};
					};
				} else {
					if (time-BRPVP_itemsMagneticLoopErrorTime > 2) then {
						BRPVP_itemsMagneticLoopErrorTime = time;
						[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\magnet.paa'/><br />%1 %2/%3",localize "str_limit_reached_twop",ceil BRPVP_itemMagnetAllMass,BRPVP_magnetHolderCargoLimitAllPools],0,0.25,2,0,0,53214] call BRPVP_fnc_dynamicText;
						"erro" call BRPVP_playSound;
					};
				};
			};
		};
	};
	BRPVP_c4SpecialDestruction = {
		{
			if (isNull (_x select 0)) then {
				[_x select 1] remoteExecCall ["BRPVP_setC4EffectOnServerOrHC",2];
				BRPVP_c4Monitore set [_forEachIndex,[-1]];
			};
		} forEach BRPVP_c4Monitore;
		BRPVP_c4Monitore = BRPVP_c4Monitore-[[-1]];
	};
	BRPVP_playerBuildingInside = {
		private _pos = getPosWorld player;
		private _result = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,50],player,objNull,false,1,"GEOM","FIRE"];
		if (count _result > 0 && {(_result select 0 select 2) isKindOf "House"}) then {
			_result = lineIntersectsSurfaces [_pos,_pos vectorAdd [0,0,-10],player,objNull,true,1,"GEOM","FIRE"];
			if (count _result > 0 && {(_result select 0 select 2) isKindOf "House"}) then {
				_house = _result select 0 select 2;
				if !(_house isEqualTo BRPVP_playerBuilding) then {
					player setVariable ["bui",_house,true];
					BRPVP_playerBuilding = _house;
				};
			} else {
				if (!isNull BRPVP_playerBuilding) then {player setVariable ["bui",objNull,true];};
				BRPVP_playerBuilding = objNull;
			};
		} else {
			if (!isNull BRPVP_playerBuilding) then {player setVariable ["bui",objNull,true];};
			BRPVP_playerBuilding = objNull;
		};
	};
	BRPVP_sixthSenseObjectsAround = [];
	BRPVP_sixthSenseLoopCode = {
		private _attached = objNull;
		private _maxSize = 0;
		{
			private _size = (boundingBoxReal _x) select 2;
			if (_size > _maxSize) then {_maxSize = _size;_attached = _x;};
		} forEach attachedObjects player;

		private _camPos = AGLToASL (positionCameraToWorld [0,0,0]);
		private _camVec = positionCameraToWorld [0,0,1] vectorDiff positionCameraToWorld [0,0,0];
		private _sixthSenseObjectsFound = [];
		private _sixthSenseObjectsFoundPlayer = [];

		if (BRPVP_vePlayersSixthSense) then {
			{
				private _aiVec = eyePos _x vectorDiff _camPos;
				private _angle = acos (_aiVec vectorCos _camVec);
				if (_angle <= 90) then {
					private _attachedUse = [_attached,(attachedObjects _x+[objNull]) select 0] select isNull _attached;
					if ([vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [AGLToASL (positionCameraToWorld [0,0,0]),eyePos _x] isEqualTo 0 && {[vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [AGLToASL (positionCameraToWorld [0,0,0]),_x modelToWorldWorld (_x selectionPosition "rightleg")] isEqualTo 0 && [vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [AGLToASL (positionCameraToWorld [0,0,0]),_x modelToWorldWorld (_x selectionPosition "leftleg")] isEqualTo 0}) then {if (_x call BRPVP_isPlayer) then {_sixthSenseObjectsFoundPlayer pushBack _x;} else {_sixthSenseObjectsFound pushBack _x;};};
				};
			} forEach BRPVP_sixthSenseObjectsAround;
		} else {
			{
				private _aiVec = eyePos _x vectorDiff _camPos;
				private _angle = acos (_aiVec vectorCos _camVec);
				if (_angle <= 17.5) then {
					private _attachedUse = [_attached,(attachedObjects _x+[objNull]) select 0] select isNull _attached;
					if ([vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [AGLToASL (positionCameraToWorld [0,0,0]),eyePos _x] isEqualTo 0 && {[vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [AGLToASL (positionCameraToWorld [0,0,0]),_x modelToWorldWorld (_x selectionPosition "rightleg")] isEqualTo 0 && [vehicle BRPVP_myPlayerOrSpecOrDrone,"VIEW",_attachedUse] checkVisibility [AGLToASL (positionCameraToWorld [0,0,0]),_x modelToWorldWorld (_x selectionPosition "leftleg")] isEqualTo 0}) then {
						if (_x call BRPVP_isPlayer) then {
							if ((BRPVP_spectateOn && BRPVP_sixthSenseSeePlayerSpec) || (!BRPVP_spectateOn && BRPVP_sixthSenseSeePlayer)) then {_sixthSenseObjectsFoundPlayer pushBack _x;};
						} else {
							_sixthSenseObjectsFound pushBack _x;
						};
					};
				};
			} forEach BRPVP_sixthSenseObjectsAround;
		};
		BRPVP_sixthSenseObjectsFound = _sixthSenseObjectsFound;
		BRPVP_sixthSenseObjectsFoundPlayer = _sixthSenseObjectsFoundPlayer;
	};
	BRPVP_rZedsTryToSpawnOldPlaces = [];
	BRPVP_rZedsTryToSpawn = {
		private _plyPos = getPosATL player;
		private _posOk = _plyPos select 2 < 0.25;
		private _combatOk = time-BRPVP_ultimoCombateTempo >= BRPVP_rZedsCfgNoCombatTime;
		private _nearHousesOk = count (player nearObjects ["House",BRPVP_rZedsCfgMaxHousesArroundDist]) <= BRPVP_rZedsCfgMaxHousesArround;
		if (_posOk && _combatOk && _nearHousesOk) then {
			private _dirtCnt = 0;
			private _cnt = 0;
			_plyPos set [2,0];
			for "_rad" from 1 to BRPVP_rZedsCfgDirtCheckDistance step BRPVP_rZedsCfgDirtCheckStep do {
				private _perimeter = 2*pi*_rad;
				private _pSteps = ceil(_perimeter/25) min 35;
				private _aStep = 360/_pSteps;
				for "_angle" from 0 to 360 step _aStep do {
					private _vec = [_rad*sin _angle,_rad*cos _angle,0];
					if (!isOnRoad ((_plyPos vectorAdd _vec) select [0,2])) then {_dirtCnt = _dirtCnt+1;};
					_cnt = _cnt+1;
				};
			};
			private _dirtOk = _dirtCnt/_cnt >= BRPVP_rZedsCfgDirtCheckPercentage;
			if (_dirtOk) then {
				private _size = [5,7.5] select (random 1 < 0.25);
				private _vel = velocity player;
				private _dir = if (vectorMagnitude _vel < 1) then {getDir player} else {[[0,0,0],_vel] call BIS_fnc_dirTo};
				private _pSpawn = [player,7.5*0.8,_dir] call BIS_fnc_relPos;
				private _frontOk = true;
				private _area = pi*7.5^2;
				for "_i" from 1 to round(_area/8) do {
					private _a = random 360;
					private _r = sqrt(random(7.5^2));
					private _try = AGLToASL (_pSpawn vectorAdd [_r*sin _a,_r*cos _a,0.25]);
					private _lis = lineIntersectsSurfaces [_try vectorAdd [0,0,3],_try];
					if (_lis isNotEqualTo [] || isOnRoad (_try select [0,2])) exitWith {_frontOk = false;};
				};
				if (_frontOk) then {
					[_pSpawn,_size] spawn {
						params ["_pSpawn","_size"];
						private _init = diag_tickTime;
						private _moved = false;
						waitUntil {
							_moved = vectorMagnitude velocity player > 2.5;
							_moved || diag_tickTime-_init > 60
						};
						if (_moved) then {
							[player,[BRPVP_rZedsCfgBoneBreakSeq select BRPVP_rZedsCfgBoneBreakSeqIdx,500,1.05+random 0.1]] remoteExecCall ["say3D",BRPVP_allNoServer];
							BRPVP_rZedsCfgBoneBreakSeqIdx = (BRPVP_rZedsCfgBoneBreakSeqIdx+1) mod BRPVP_rZedsCfgBoneBreakSeqCnt;
							uiSleep 0.25;
							["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\bone_break.paa'/><br /><t>"+localize "str_rzeds_step_in_something"+"</t>",0,0,2,0,0,15734] call BRPVP_fnc_dynamicText;
							(selectRandom ["terror_1","terror_2","terror_3","terror_4"]) call BRPVP_playSound;
							if (_size isEqualTo 7.5) then {_pSpawn remoteExecCall ["BRPVP_rZedsSpawn2",2];} else {_pSpawn remoteExecCall ["BRPVP_rZedsSpawn1",2];};
							BRPVP_rZedsTryToSpawnOldPlaces pushBack [_pSpawn,25];
							private _init = diag_tickTime;
							private _lastFStep = diag_tickTime;
							waitUntil {
								waitUntil {(player distance _pSpawn < 7.5 && getPos player select 2 < 0.25) || (diag_tickTime-_init > 120 && player distance _pSpawn > 125)};
								if (diag_tickTime-_init > 120 && player distance _pSpawn > 125) exitWith {true};
								private _tick = selectRandom [0.30,0.35,0.40,0.45,0.50];
								waitUntil {
									private _aMult = getAnimSpeedCoef player;
									private _vel = vectorMagnitude velocity player;
									if (_vel > 0 && _aMult > 0) then {
										if (diag_tickTime-_lastFStep > (_tick*5/_vel)/_aMult) then {
											[player,[BRPVP_rZedsCfgBoneBreakSeq select BRPVP_rZedsCfgBoneBreakSeqIdx,500,1.05+random 0.1]] remoteExecCall ["say3D",BRPVP_allNoServer];
											BRPVP_rZedsCfgBoneBreakSeqIdx = (BRPVP_rZedsCfgBoneBreakSeqIdx+1) mod BRPVP_rZedsCfgBoneBreakSeqCnt;
											_tick = selectRandom [0.30,0.35,0.40,0.45,0.50];
											_lastFStep = diag_tickTime;
										};
									};
									player distance _pSpawn > 7.5 || getPos player select 2 > 0.25
								};
								diag_tickTime-_init > 120 && player distance _pSpawn > 125
							};
						} else {
							BRPVP_rZedsCfgCoolDown = BRPVP_rZedsCfgCoolDownIfFail;
						};
					};
				} else {
					BRPVP_rZedsCfgCoolDown = BRPVP_rZedsCfgCoolDownIfFail;
				};
			} else {
				BRPVP_rZedsCfgCoolDown = BRPVP_rZedsCfgCoolDownIfFail;
			};
		} else {
			BRPVP_rZedsCfgCoolDown = BRPVP_rZedsCfgCoolDownIfFail;
		};
	};
	BRPVP_autoOpenDoorPerkHistoric = []; //NOT IN USE (CLOSE DOORS AFTER SOME TIME?)
	BRPVP_autoOpenDoorPerkMemoList = createHashMap;
	BRPVP_autoOpenDoorPerkArray1 = ["_pName","_posObj"];
	BRPVP_autoOpenDoorHistoricObj = [];
	BRPVP_autoOpenDoorHistoricDoors = [];
	BRPVP_autoOpenDoorPerkCode = {
		if (isNull objectParent player && player call BRPVP_pAlive) then {
			private _vec = getCameraViewDirection player vectorMultiply 5;
			private _posCam = AGLToASL positionCameraToWorld [0,0,0];
			private _lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,1,"GEOM","VIEW"];
			if (_lis isNotEqualTo []) then {
				private _object = _lis select 0 select 2;
				if (_object getVariable ["brpvp_mbots2",-1] isEqualTo -1) then {
					private _lookHit = _lis select 0 select 0;
					private _memoDoors = if (_object isKindOf "Wall") then {[]} else {(_object selectionNames "Geometry") select {_x select [0,5] isEqualTo "door_" && count _x <= 7}};
					if (_memoDoors isEqualTo []) then {
						if (!(_object in BRPVP_autoOpenDoorPerkHistoric) && !isNull _object && {(_object isKindOf "House" || _object isKindOf "Wall_F") && _object getVariable ["id_bd",-1] isEqualto -1 && _object getVariable ["brpvp_map_god_mode_house_id",-1] isEqualTo -1}) then {
							private _class = typeOf _object;
							if (isClass (configFile >> "CfgVehicles" >> _class >> "AnimationSources")) then {
								private _openList = [];
								{
									private _aName = configName _x;
									if (_aName select [0,5] isEqualTo "Door_" && _aName select [count _aName-13,13] isEqualTo "_sound_source") then {
										if (_object animationSourcePhase _aName isEqualTo 0) then {_openList pushBack _aName;};
									};
								} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _class >> "AnimationSources"));
								if (_openList isNotEqualTo []) then {
									{_object animateSource [_x,1,BRPVP_autoOpenDoorSpeed];} forEach _openList;
									BRPVP_autoOpenDoorPerkHistoric pushBackUnique _object;
								};
							};
						};
					} else {
						private _to = typeOf _object;
						private _dInfo = BRPVP_autoOpenDoorPerkMemoList getOrDefault [_to,-1];
						if (_dInfo isEqualTo -1) then {
							_dInfo = _memoDoors apply {[_x,_object selectionPosition _x]};
							BRPVP_autoOpenDoorPerkMemoList set [_to,_dInfo];
						};
						private _dFound = -1;
						private _maxAngle = 30;
						private _maxDist = 36;
						{
							_x params BRPVP_autoOpenDoorPerkArray1;
							private _pW = _object modelToWorldWorld _posObj;
							private _dist = ASLToAGL _pW distanceSqr player;
							if (_dist < _maxDist) then {
								private _angle = acos (_vec vectorCos (_pW vectorDiff _posCam));
								if (_angle < _maxAngle) then {_maxDist = _dist;_maxAngle = _angle;_dFound = _pName;};
							};
						} forEach _dInfo;
						if (_dFound isNotEqualTo -1) then {
							private _dn = format ["%1%2%3","D",_dFound select [1,6],"_sound_source"];
							if (_object animationSourcePhase _dn isEqualTo 0) then {
								private _idx = BRPVP_autoOpenDoorHistoricObj find _object;
								if (_idx isEqualTo -1) then {
									BRPVP_autoOpenDoorHistoricObj pushBack _object;
									BRPVP_autoOpenDoorHistoricDoors pushBack [_dn];
									_object animateSource [_dn,1,BRPVP_autoOpenDoorSpeed];
								} else {
									if (BRPVP_autoOpenDoorHistoricDoors select _idx find _dn isEqualTo -1) then {
										_object animateSource [_dn,1,BRPVP_autoOpenDoorSpeed];
										BRPVP_autoOpenDoorHistoricDoors select _idx pushBack _dn;
									};
								};
							};
						};
					};
				};
			};
		};
	};
	BRPVP_autoOpenDoorPerkClose = {
		//OLD METHOD (FOR MOD BUILDINGS WITHOUT DEFAULT BUILDINGS FEATURES)
		BRPVP_autoOpenDoorPerkHistoric = BRPVP_autoOpenDoorPerkHistoric select {alive _x};
		{
			private _sizeOf = sizeOf typeOf _x;
			if (_x distance player > _sizeOf/2+50) then {BRPVP_autoOpenDoorPerkHistoric = BRPVP_autoOpenDoorPerkHistoric-[_x]};
		} forEachReversed BRPVP_autoOpenDoorPerkHistoric;

		//NEW METHOD
		private _oNullIdx = BRPVP_autoOpenDoorHistoricObj find objNull;
		while {_oNullIdx isNotEqualTo -1} do {
			BRPVP_autoOpenDoorHistoricObj deleteAt _oNullIdx;
			BRPVP_autoOpenDoorHistoricDoors deleteAt _oNullIdx;
			_oNullIdx = BRPVP_autoOpenDoorHistoricObj find objNull;
		};
		{
			private _sizeOf = sizeOf typeOf _x;
			if (_x distance player > _sizeOf/2+50) then {
				BRPVP_autoOpenDoorHistoricObj deleteAt _forEachIndex;
				BRPVP_autoOpenDoorHistoricDoors deleteAt _forEachIndex;
			};
		} forEachReversed BRPVP_autoOpenDoorHistoricObj;
	};
	BRPVP_drawCrosshairColorIdx = 0;
	BRPVP_drawCrosshair = {
		["<img color='"+(["#333333","#BBBBBB"] select BRPVP_drawCrosshairColorIdx)+"' shadow='0' size='0.175' image='"+BRPVP_imagePrefix+"BRP_imagens\draw_map\mil_dot.paa'/>",0,0.4945,0.6,0,0,32567] call BRPVP_fnc_dynamicText;
		BRPVP_drawCrosshairColorIdx = 1-BRPVP_drawCrosshairColorIdx;
	};
	BRPVP_clientMainLoop = {
		//VARIAVEIS DE EVENTOS
		_agora = diag_tickTime;
		_tempo0_25 = _agora-_inicio0_25 > 0.25;
		_tempo0_5 = _agora-_inicio0_5 > 0.5;
		_tempo1 = _agora-_inicio1 > 1;
		_tempo2_5 = _agora-_inicio2_5 > 2.5;
		_tempo5 = _agora-_inicio5 > 5;
		_tempo10 = _agora-_inicio10 > 10;
		_tempo30 = _agora-_inicio30 > 30;
		_tempoMNY = _agora-_inicioMNY > BRPVP_stayOnlineMoneyRewardInterval;

		//FIX GOD MODE IF ANY MOD IGNORED BRPVP GOD MODE
		if (player getVariable "god" || player getVariable "brpvp_god_admin" || player getVariable "brpvp_extra_protection") then {
			if (BRPVP_godModeLifeState isEqualTo []) then {
				BRPVP_godModeLifeState = [damage player,getAllHitPointsDamage player select 2];
			} else {
				if (damage player > BRPVP_godModeLifeState select 0) then {
					player setDamage (BRPVP_godModeLifeState select 0);
					{player setHitIndex [_forEachIndex,_x,false];} forEach (BRPVP_godModeLifeState select 1);
				};
			};
		} else {
			BRPVP_godModeLifeState = [];
		};

		if (_tempo0_25) then {
			_inicio0_25 = _agora;
			//GET TIRE ON CURSOROBJECT
			private _cursorObject = cursorObject;
			BRPVP_tireCursorObject = [objNull,_cursorObject] select (typeOf _cursorObject in ["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"]);

			//SPEC SEND MAP POSITION
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo [] && {visibleMap || BRPVP_artyMapOn || BRPVP_droneMapOn}) then {
				private _mouse = if (BRPVP_artyMapOn || BRPVP_droneMapOn) then {BRPVP_mapMouseMovementAny} else {findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld getMousePosition};
				private _mapPos = if (BRPVP_artyMapOn || BRPVP_droneMapOn) then {BRPVP_specMapPosAny} else {findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld [0.5,0.5]};
				private _scale = if (BRPVP_artyMapOn || BRPVP_droneMapOn) then {BRPVP_specMapScaleAny} else {ctrlMapScale (findDisplay 12 displayCtrl 51)};
				[_mouse,[0.25,_scale,_mapPos]] remoteExecCall ["BRPVP_specMapAnime",BRPVP_specOnMeMachinesNoMe];
			};

			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
				//SPEC SEND VARS TO MY SPECTATOR
				private _specVarsToSend = [BRPVP_meusAmigosObj,BRPVP_pveFriends,BRPVP_viewDist,BRPVP_viewDistFly,BRPVP_xpLastTotal,BRPVP_nascendoParaQuedas,BRPVP_xrayOn,BRPVP_artyTargetPos,BRPVP_playersMarksEnabled,BRPVP_meuAllDead,BRPVP_radioAreasInside];
				if (_specVarsToSend isNotEqualTo BRPVP_specVarsToSend) then {
					BRPVP_specVarsToSend = _specVarsToSend;
					BRPVP_specVarsToSend remoteExecCall ["BRPVP_specReceiveVars",BRPVP_specOnMeMachinesNoMe];
				};
				player setVariable ["brpvp_fps",diag_fps,BRPVP_specOnMeMachinesNoMe];

				//SPEC SEND BRPVP_nearIdentifiedPlayers
				private _specVarsNearPlayersToSend = [BRPVP_nearIdentifiedPlayers,BRPVP_newersDiscovered];
				if (_specVarsNearPlayersToSend isNotEqualTo BRPVP_specVarsNearPlayersToSend) then {
					BRPVP_specVarsNearPlayersToSend = _specVarsNearPlayersToSend;
					BRPVP_specVarsNearPlayersToSend remoteExecCall ["BRPVP_specReceiveNIP",BRPVP_specOnMeMachinesNoMe];
				};
			};

			//SIXTH SENSE
			if ((BRPVP_spectateOn && BRPVP_sixthSenseOnSpec) || (!BRPVP_spectateOn && BRPVP_sixthSenseOn) || BRPVP_vePlayersSixthSense) then {call BRPVP_sixthSenseLoopCode;};

			//SET MAX HEIGHT SINCE NO GROUND
			private _hNow = getPos player select 2;
			if (_hNow < 0.5) then {BRPVP_maxHeightSinceNoGround = 0;} else {BRPVP_maxHeightSinceNoGround = BRPVP_maxHeightSinceNoGround max _hNow;};

			//DRAW CROSSHAIR
			if (BRPVP_crosshairOn && !visibleMap && isNull findDisplay 602) then {call BRPVP_drawCrosshair;};

			//BASE MINE
			private _fraPInPVE = player getVariable ["brpvp_pve_inside",0] > 0 && player getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0;
			if (!_fraPInPVE || BRPVP_pveFrantaBombExplode) then {call BRPVP_baseMineTempCode;};

			//AUTO OPEN DOOR PERK
			if (BRPVP_autoOpenDoorPerk) then {call BRPVP_autoOpenDoorPerkCode;};
		};
		if (_tempo0_5) then {
			_inicio0_5 = _agora;

			//GET NEAR TIRE INFO
			private _tiresNearTires = [];
			{
				private _lis = lineIntersectsSurfaces [eyePos BRPVP_myPlayerOrSpecOrDrone,getPosWorld _x,BRPVP_myPlayerOrSpecOrDrone,_x];
				if (_lis isEqualTo []) then {_tiresNearTires pushBack _x;};
			} forEach (nearestObjects [BRPVP_myPlayerOrSpecOrDrone,["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"],50]-attachedObjects BRPVP_myPlayerOrSpecOrDrone);
			BRPVP_tiresNearTires = _tiresNearTires;

			//ITEMS MAGNET
			call BRPVP_itemsMagneticLoop;
			
			//GET HOUSE INSIDE
			call BRPVP_playerBuildingInside;

			//ENABLE SKY DIVE
			if (getUnitFreefallInfo player select 1 && isNull objectParent player && player call BRPVP_pAlive) then {
				if (!BRPVP_nascendoParaQuedas) then {
					BRPVP_paraParamH = 10000;
					BRPVP_nascendoParaQuedas = true;
					"skydive" call BRPVP_playSound;
					["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\player_fly.paa'/><br/><t size='0.85'>shift+w <t color='#20D020'>→</t>   <t color='#D02020'>↓</t>      shift+s <t color='#D02020'>←</t>   <t color='#20D020'>↑</t></t>",0,0.25,8,0,0,4537] call BRPVP_fnc_dynamicText;
					0 spawn {
						private _lastOk = 0;
						BRPVP_skyDiveInitTime = time;
						waitUntil {
							private _hnc = player getVariable ["brpvp_halo_no_coll",false];
							private _h = getPos player select 2;
							private _speed = vectorMagnitude velocity vehicle player;
							private _inPara = typeOf objectParent player isEqualTo "Steerable_Parachute_F";
							_lastOk = if (_h <= 30 && _speed <= 25 && _inPara) then {diag_tickTime} else {_lastOk};
							private _okTime = diag_tickTime-_lastOk;
							if (_okTime <= 1.5) then {if !(_hnc) then {player setVariable ["brpvp_halo_no_coll",true];};} else {if (_hnc) then {player setVariable ["brpvp_halo_no_coll",false];};};
							!BRPVP_nascendoParaQuedas && _okTime > 1.5
						};
						player setVariable ["brpvp_halo_no_coll",false];
					};
				};
			} else {
				BRPVP_nascendoParaQuedas = false;
			};

			//SET VISIBLE MINERVA SOLDIERS
			private _minervaBotAllUnitsObjsNearSee = [];
			{
				private _vis = [vehicle BRPVP_myPlayerOrSpecOrDrone,"GEOM",_x] checkVisibility [eyePos BRPVP_myPlayerOrSpecOrDrone,eyePos _x];
				if (_vis > 0.6 && alive _x) then {_minervaBotAllUnitsObjsNearSee pushBack _x;};
			} forEach BRPVP_minervaBotAllUnitsObjsNear;
			BRPVP_minervaBotAllUnitsObjsNearSee = _minervaBotAllUnitsObjsNearSee;

			//SET VISIBLE ULFAN SOLDIERS
			private _sBotAllUnitsObjsNearSee = [];
			{
				private _vis = [vehicle BRPVP_myPlayerOrSpecOrDrone,"GEOM",_x] checkVisibility [eyePos BRPVP_myPlayerOrSpecOrDrone,eyePos _x];
				if (_vis > 0.6 && alive _x) then {_sBotAllUnitsObjsNearSee pushBack _x;};
			} forEach BRPVP_sBotAllUnitsObjsNear;
			BRPVP_sBotAllUnitsObjsNearSee = _sBotAllUnitsObjsNearSee;

			//BASE TEXT SIGNS
			_nearSign = objNull;
			{
				if (typeOf _x isEqualTo BRPVP_baseSignClass && {lineIntersectsSurfaces [eyePos player,getPosWorld _x vectorAdd [0,0,0.5],player,_x] isEqualTo []}) exitWith {_nearSign = _x;};
			} forEach nearestObjects [player,[],3];
			if (!(_nearSign isEqualTo _lastSign) || (isNull _nearSign && isNull _lastSign && _baseSignIsOn)) then {
				if (isNull _nearSign) then {
					["",0,0,0,0,0,57932] call BRPVP_fnc_dynamicText;
					_baseSignIsOn = false;
				} else {
					_txt = _nearSign getVariable ["brpvp_sign_txt",""];
					_baseSignCurrTxt = _txt;
					if (_txt isEqualTo "") then {_txt = "...";};
					["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\text_sign.paa'/><br/><t>"+(_txt call BRPVP_escapeForStructuredText)+"</t>",0,0,36000,0,0,57932] call BRPVP_fnc_dynamicText;
					_baseSignIsOn = true;
				};
				_lastSign = _nearSign;
			} else {
				if (!isNull _nearSign) then {
					_txtNow = _nearSign getVariable ["brpvp_sign_txt",""];
					if !(_txtNow isEqualTo _baseSignCurrTxt) then {
						if (_txtNow isEqualTo "") then {_txtNow = "...";};
						["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\text_sign.paa'/><br/><t>"+(_txtNow call BRPVP_escapeForStructuredText)+"</t>",0,0,36000,0,0,57932] call BRPVP_fnc_dynamicText;
					};
				};
			};

			//BASE DESTROYED LINES
			call BRPVP_baseBombCalcVisibleLines;
		};
		if (_tempo1) then {
			_inicio1 = _agora;

			//AIR VEHICLE PROTECTION
			_veh = objectParent player;
			_drn = BRPVP_myUAVNow;
			if (local _veh && {_veh isKindOf "Air"}) then {_veh call BRPVP_setAirGodMode;};
			if (local _drn && {_drn isKindOf "Air"}) then {_drn call BRPVP_setAirGodMode;};

			//RENOVA TRIGGERS DE TEMPO
			if (BRPVP_countSecs isEqualTo 3600) then {BRPVP_countSecs = 0;} else {BRPVP_countSecs = BRPVP_countSecs+1;};

			//CALC AVERAGE FPS
			BRPVP_fpsRecord = (BRPVP_fpsRecord*7+diag_fps)/8;

			//ATUALIZA DEBUG DE 1 EM 1 SEGUNDO
			true call BRPVP_atualizaDebug;

			//CALCULATE NEAR IDENTIFIED PLAYERS
			if (!BRPVP_spectateOn) then {call BRPVP_nearIdentifiedPlayersLoop;};

			//VODKA SIDE ICON
			_vodkaTime = (BRPVP_vodkaTimeMark-time) max 0;
			_vodkaIntensity = ceil (_vodkaTime/24);
			if (_lastVodkaIntensity != _vodkaIntensity) then {
				if (_vodkaIntensity > 0) then {
					if (_lastVodkaIntensity isEqualTo 0) then {_handleVodkaEffect ppEffectEnable true;};
					_handleVodkaEffect ppEffectAdjust [1.25*_vodkaIntensity/10];
					_handleVodkaEffect ppEffectCommit 1.5;
					_vodkaPerc = str round (100*_vodkaIntensity/10) + "%";
					["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\vodka.paa'/><br/><t align='left' size='0.65'> "+_vodkaPerc+"</t>",{safeZoneX+safeZoneW-0.0765},{safeZoneY+0.35},1000000,0,0,3094] call BRPVP_fnc_dynamicText;
				} else {
					_handleVodkaEffect ppEffectAdjust [0.005];
					_handleVodkaEffect ppEffectCommit 1.5;
					_handleVodkaEffect spawn {
						sleep 1.5;
						if (BRPVP_vodkaTimeMark <= time) then {_this ppEffectEnable false;};
					};
					["",0,0,0,0,0,3094] call BRPVP_fnc_dynamicText;
				};
				_lastVodkaIntensity = _vodkaIntensity;
			};

			//RADIATION
			if (BRPVP_spectateOn) then {
				_totalIntensity = 0;
				{_totalIntensity = _totalIntensity+(_x select 2);} forEach BRPVP_radioAreasInsideSpec;
				_totalIntensity = _totalIntensity min 1;
				_intensityN = ceil (_totalIntensity*3);
				_intensityChanged = _intensityN != _lastRadIntensity;
				_lastRadIntensity = _intensityN;
				if (BRPVP_spectedPlayer getVariable ["dd",-1] <= 0 && _totalIntensity > 0) then {
					if (!_radioAreaOn) then {_handleRadEffect ppEffectEnable true;};
					if (_intensityChanged) then {
						_handleRadEffect ppEffectAdjust [_intensityN*0.2,1.25,2.01,0.75,1,0];
						_handleRadEffect ppEffectCommit 0.75;
					};
					for "_i" from 1 to _intensityN do {selectRandom ["radio1","radio2","radio3","radio4","radio5","radio6","radio7"] call BRPVP_playSound;};
					_radioAreaOn = true;
				} else {
					if (_radioAreaOn) then {
						["",0,0,0,0,0,3093] call BRPVP_fnc_dynamicText;
						_radioScreamTickMax = 0;
						_radioAreaOn = false;
						_handleRadEffect ppEffectAdjust [0.005,1.25,2.01,0.75,1,0];
						_handleRadEffect ppEffectCommit 0.75;
						_handleRadEffect spawn {
							sleep 1;
							if ({vehicle BRPVP_spectedPlayer distance (_x select 0) <= _x select 1} count BRPVP_radioAreas isEqualTo 0) then {_this ppEffectEnable false;};
						};
					};
				};
			} else {
				_totalIntensity = 0;
				{_totalIntensity = _totalIntensity+(_x select 2);} forEach BRPVP_radioAreasInside;
				_totalIntensity = _totalIntensity min 1;
				_intensityN = ceil (_totalIntensity*3);
				_intensityChanged = _intensityN != _lastRadIntensity;
				_lastRadIntensity = _intensityN;
				if (player getVariable ["dd",-1] <= 0 && _totalIntensity > 0) then {
					if (!_radioAreaOn) then {
						["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\radiation.paa' />",{safeZoneX+safeZoneW-0.0765},{safeZoneY+0.29},1000000,0,0,3093] call BRPVP_fnc_dynamicText;
						_handleRadEffect ppEffectEnable true;
					};
					if (_intensityChanged) then {
						_handleRadEffect ppEffectAdjust [_intensityN*0.2,1.25,2.01,0.75,1,0];
						_handleRadEffect ppEffectCommit 0.75;
					};
					for "_i" from 1 to _intensityN do {selectRandom ["radio1","radio2","radio3","radio4","radio5","radio6","radio7"] call BRPVP_playSound;};
					_radioAreaOn = true;
					_maskAttenuation = [1,0.425] select (goggles player in BRPVP_CbrnMasks);
					_suitAttenuation = [1,0.425] select (uniform player in BRPVP_CbrnSuits);
					_fullSuitAttenuation = [1,0.675] select (_maskAttenuation < 1 && _suitAttenuation < 1);
					_vodkaTime = (BRPVP_vodkaTimeMark-time) max 0;
					_vodkaAttenuation = _vodkaTime^0.95/10 max 1;
					_hurt = _fullSuitAttenuation*_suitAttenuation*_maskAttenuation*BRPVP_xpRadioProtection*_totalIntensity*0.035/_vodkaAttenuation;
					_radioGod = player getVariable "brpvp_god_admin";
					if (!_radioGod) then {
						if ((player getVariable ["dd",-1]) isEqualTo -1) then {
							isNil {
								private _hpd = getAllHitPointsDamage player;
								player setDamage ((damage player+_hurt) min 1);
								{player setHitIndex [_forEachIndex,(_x+_hurt) min 1];} forEach (_hpd select 2);
							};
						} else {
							BRPVP_disabledDamage = BRPVP_disabledDamage+_hurt/2;
						};
					};
					_radioScreamTick = _radioScreamTick+1;
					if (_radioScreamTick > _radioScreamTickMax) then {
						_radioScreamTick = 0;
						_radioScreamTickMax = _vodkaAttenuation*(selectRandom [10,15,20])/(_fullSuitAttenuation*_suitAttenuation*_maskAttenuation*BRPVP_xpRadioProtection);
						if (!_radioGod) then {
							_scream = selectRandom ["radioS1","radioS2","radioS3","radioS4","radioS5"];
							[player,[_scream,250]] remoteExecCall ["say3D",BRPVP_allNoServer];
						};
					};
				} else {
					if (_radioAreaOn) then {
						["",0,0,0,0,0,3093] call BRPVP_fnc_dynamicText;
						_radioScreamTickMax = 0;
						_radioAreaOn = false;
						_handleRadEffect ppEffectAdjust [0.005,1.25,2.01,0.75,1,0];
						_handleRadEffect ppEffectCommit 0.75;
						_handleRadEffect spawn {
							sleep 1;
							if ({vehicle player distance (_x select 0) <= _x select 1} count BRPVP_radioAreas isEqualTo 0) then {_this ppEffectEnable false;};
						};
					};
				};
			};

			//HACK A PLAYER
			_myHack = player getVariable ["brpvp_my_hack",[]];
			if (!(_myHack isEqualTo []) && {(_myHack select 3) != BRPVP_hackTimeNoMoveToComplete}) then {
				_myHack params ["_obj","_idBd","_hackMoney","_timeNoMove","_center","_name"];
				_signal = ((BRPVP_hackOnHackMoveLimit - (_center distance player)) max 0)/BRPVP_hackOnHackMoveLimit;
				_newTimeCount = ((_myHack select 3)+_signal*1.15) min BRPVP_hackTimeNoMoveToComplete;
				_myHack set [3,_newTimeCount];
				player setVariable ["brpvp_my_hack",_myHack];
				if (_center distance player > BRPVP_hackOnHackMoveLimit) then {
					_obj setVariable ["brpvp_hack_on_me",objNull,true];
					player setVariable ["brpvp_my_hack",[]];
					BRPVP_hackLines = [];
				} else {
					if (!(_obj call BRPVP_pAlive)) then {
						_newTimeCount = BRPVP_hackTimeNoMoveToComplete;
						_myHack set [3,_newTimeCount];
						player setVariable ["brpvp_my_hack",_myHack];
					};
					if (_newTimeCount isEqualTo BRPVP_hackTimeNoMoveToComplete) then {
						_obj setVariable ["brpvp_hack_on_me",objNull,true];
						[format [localize "str_hack_done_message",_name,_hackMoney call BRPVP_formatNumber],-5] call BRPVP_hint;
						
						//REMOVE ITEM
						[41,1] call BRPVP_sitRemoveItem;

						player setVariable ["mny",(player getVariable "mny")+_hackMoney,true];
						[_hackMoney,_obj,_idBd] remoteExecCall ["BRPVP_serverRemoveHackMoney",2];
						player setVariable ["brpvp_my_hack",[]];
						BRPVP_hackLines = [];
					};
				};
			};

			//MINE DETECTOR
			if (BRPVP_mineDetectorOn) then {
				_nearHolesOk = [];
				{
					if !(_x getVariable ["mny",-1] isEqualTo -1 && _x getVariable ["brpvp_box",""] isEqualTo "") then {_nearHolesOk pushBack _x;};
				} forEach nearestObjects [player,["Land_ClutterCutter_medium_F"],80];
				if (_nearHolesOk isEqualTo []) then {
					if (!isNull BRPVP_mineDetectorObj) then {
						"hackBeep" call BRPVP_playSound;
						BRPVP_mineDetectorObj = objNull;
					};
				} else {
					_newNear = _nearHolesOk select 0;
					if !(BRPVP_mineDetectorObj isEqualTo _newNear) then {
						"hackBeep" call BRPVP_playSound;
						BRPVP_mineDetectorObj = _newNear;
					};
				};
			} else {
				if (!isNull BRPVP_mineDetectorObj) then {
					"hackBeep" call BRPVP_playSound;
					BRPVP_mineDetectorObj = objNull;
				};
			};

			//BULLET TRACERS REMOVE OBJNULL
			BRPVP_firedFlyingBullets = BRPVP_firedFlyingBullets-[[objNull,objNull]];

			//CALC PLAYERS MARKS OBJ ARRAY
			if (!BRPVP_spectateOn) then {
				if (BRPVP_usePlayerIconFriends) then {
					if (BRPVP_usePlayerIconSquad) then {
						BRPVP_playersMarksEnabled = BRPVP_meusAmigosObjAll+(units group player-BRPVP_meusAmigosObjAll);
					} else {
						BRPVP_playersMarksEnabled = BRPVP_meusAmigosObjAll-(units group player-[player]);
					};
				} else {
					if (BRPVP_usePlayerIconSquad) then {
						BRPVP_playersMarksEnabled = units group player;
					} else {
						BRPVP_playersMarksEnabled = [player];
					};
				};
			};

			//HELI EVENT ALARM
			if (!isNull (player getVariable ["brpvp_heve_arrow",objNull])) then {"alarm" call BRPVP_playSound;};
		
			//NEAR MISSION CHECK
			private _missDist = BRPVP_missionsPos apply {_x distance player};
			_missDist sort true;
			if (_missDist isEqualTo []) then {
				if (BRPVP_missionNearDist > -1) then {["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\miss_near_off.paa'/>",0,0,1,0,0,2971] call BRPVP_fnc_dynamicText;};
				BRPVP_missionNearDist = -1;
			} else {
				private _nearest = _missDist select 0;
				if (_nearest <= 500) then {
					if (BRPVP_missionNearDist isEqualTo -1) then {["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\miss_near_on.paa'/>",0,0,1,0,0,2971] call BRPVP_fnc_dynamicText;};
					BRPVP_missionNearDist = _nearest;
				} else {
					if (BRPVP_missionNearDist > -1) then {["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\miss_near_off.paa'/>",0,0,1,0,0,2971] call BRPVP_fnc_dynamicText;};
					BRPVP_missionNearDist = -1;
				};
			};

			//ADD REARM VEHICLE OPTION
			call BRPVP_checkForNearServices;

			//SPEC SEND FPS TO MY SPECTATOR
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {player setVariable ["brpvp_fps",diag_fps,BRPVP_specOnMeMachinesNoMe];};

			//ADD BUS STOP ACTION
			_stops = player nearObjects ["Land_WoodenShelter_01_F",5];
			_stops pushBack objNull;
			_stop = _stops select 0;
			if (!isNull _stop && {player call BRPVP_pAlive && _stop getVariable ["brpvp_bus_stop",false] && !BRPVP_busServiceRunning}) then {
				if (BRPVP_busStopAction isEqualTo -1) then {BRPVP_busStopAction = player addAction ["<t color='#D580CC'>"+localize "str_action_get_a_bus"+"</t>",{call BRPVP_busServiceActionCode;},_stop,1.5,true,true];};
			} else {
				if (BRPVP_busStopAction > -1) then {player removeAction BRPVP_busStopAction;BRPVP_busStopAction = -1;};
			};

			//GET MY BASE STATE
			BRPVP_myBaseState = player call BRPVP_checkOnFlagState;
			if (BRPVP_myBaseState isNotEqualTo (player getVariable "brpvp_my_flag_state")) then {player setVariable ["brpvp_my_flag_state",BRPVP_myBaseState,true];};
			if (!BRPVP_uPackUsing && !BRPVP_uberAttackUsing && !(BRPVP_flyA || BRPVP_flyB || BRPVP_flyC)) then {
				private _isInRaidMiss = BRPVP_raidTrainingMissionRun && {player distance2D BRPVP_raidTrainingMapPosition < BRPVP_raidTrainingMissionFlagSize};
				if (BRPVP_myBaseState isEqualTo 0 && !_isInRaidMiss) then {
					if ((getUnitFreefallInfo player select 2) isNotEqualTo 100) then {player setUnitFreefallHeight 100;};
				} else {
					private _baseHeight = BRPVP_maxBuildHeight+100;
					if ((getUnitFreefallInfo player select 2) isNotEqualTo _baseHeight) then {player setUnitFreefallHeight _baseHeight;};
				};
			};

			//FIX STUCK INSIDE STONE
			if (BRPVP_insideStoneFixCases isNotEqualTo []) then {call BRPVP_insideStoneFix;};

			//SET LAST VEH POSITION TERRAIN OCLUSSION
			if (BRPVP_lastVehicleInPos isNotEqualTo []) then {BRPVP_lastVehicleInTi = terrainIntersectASL [eyePos player,AGLToASL BRPVP_lastVehicleInPos];};

			//AI REVERSE SIXTH SENSE
			if (!BRPVP_vePlayersSixthSense && !BRPVP_spectateOn) then {{if (_x getVariable ["brpvp_ss_reverse_view",false] && {_x distance BRPVP_myPlayerOrSpecOrDrone < BRPVP_sixthSenseAiFeelDistance && _x knowsAbout BRPVP_myPlayerOrSpecOrDrone < 2}) then {_x reveal [BRPVP_myPlayerOrSpecOrDrone,4];};} forEach BRPVP_sixthSenseObjectsFound;};

			//SET TEMP RAIN
			private _pEye = positionCameraToWorld [0,0,0];
			if ([-1,_pEye] call BRPVP_checkOnFlagStateNoObj > 0) then {
				_pEye = AGLToASL _pEye;
				private _rainOk = 0;
				private _rainTotal = 7;
				private _lis = lineIntersectsSurfaces [_pEye,_pEye vectorAdd [0,0,100],vehicle player,objNull,true,-1,"GEOM","NONE"];
				if ({(_x select 2) isKindOf "Building"} count _lis isEqualTo 0) then {_rainOk = _rainOk+1;};
				{
					private _vec = [2.5*sin _x,2.5*cos _x,2.5];
					private _lis = lineIntersectsSurfaces [_pEye,_pEye vectorAdd _vec,vehicle player,objNull,true,-1,"GEOM","NONE"];
					if ({(_x select 2) isKindOf "Building"} count _lis isEqualTo 0) then {
						private _nPos = _pEye vectorAdd _vec;
						private _lis = lineIntersectsSurfaces [_nPos,_nPos vectorAdd [0,0,97.5],vehicle player,objNull,true,-1,"GEOM","NONE"];
						if ({(_x select 2) isKindOf "Building"} count _lis isEqualTo 0) then {_rainOk = _rainOk+1;};
					};
				} forEach [0,60,120,180,240,300];
				private _rainNow = BRPVP_weatherRainOnServer*(_rainOk/_rainTotal);
				if (_rainNow isNotEqualto BRPVP_weatherRainOnServer) then {0.5 setRain _rainNow;};
			};
		};
		if (_tempo2_5) then {
			_inicio2_5 = _agora;

			//SPOT NO-MOVE PLAYERS IN LABRINTY
			call BRPVP_labSpotNoMovePlayers;

			//WALK POINTS
			if (getPos player select 2 < 0.15 && isNull objectParent player) then {
				private _posASL = getPosASL player;
				private _dist = vectorMagnitude (_posASL vectorDiff _walkLastPos);
				if (_dist < 30) then {
					_walkAcumulated = _walkAcumulated+_dist;
					if (_walkAcumulated > 200) then {
						[["andou",round _walkAcumulated]] call BRPVP_mudaExp;
						_walkAcumulated = 0;
					};
				};
				_walkLastPos = +_posASL;
			};

			//SAVE DAMAGED VEH IF DIED
			call BRPVP_saveDeadVehDataBefore;

			//CHECK SPECIAL C4 DESTRUCTION
			call BRPVP_c4SpecialDestruction;
			
			//SET DRAW PATH DELTA
			if (BRPVP_ppathIsOn) then {
				private _v = objectParent player;
				BRPVP_ppathDeltaPos = if (isNull _v) then {10} else {if (_v isKindOf "Air") then {25} else {15};};
			};

			//SIXTH SENSE OBJECTS AROUND
			if (BRPVP_rZedsRunning) then {
				if (BRPVP_vePlayersSixthSense) then {
					BRPVP_sixthSenseObjectsAround = ((BRPVP_myPlayerOrSpecOrDrone nearEntities ["CaManBase",2000]) select {simulationEnabled _x && !isObjectHidden _x && typeOf _x find "RyanZombie" isNotEqualTo 0})-[BRPVP_myPlayerOrSpec];
				} else {
					if ((BRPVP_spectateOn && BRPVP_sixthSenseOnSpec) || (!BRPVP_spectateOn && BRPVP_sixthSenseOn)) then {
						private _sixthSenseRange = [BRPVP_sixthSenseRange,BRPVP_sixthSenseRangeSpec] select BRPVP_spectateOn;
						BRPVP_sixthSenseObjectsAround = ((nearestObjects [BRPVP_myPlayerOrSpecOrDrone,["CaManBase"],_sixthSenseRange]) select {simulationEnabled _x && !isObjectHidden _x && alive _x && ((_x getVariable ["brpvp_ss_immune_mult",1]) isNotEqualTo 0) && typeOf _x find "RyanZombie" isNotEqualTo 0})-[BRPVP_myPlayerOrSpec];
						BRPVP_sixthSenseObjectsAround = BRPVP_sixthSenseObjectsAround select [0,35];
					};
				};
			} else {
				if (BRPVP_vePlayersSixthSense) then {
					BRPVP_sixthSenseObjectsAround = ((BRPVP_myPlayerOrSpecOrDrone nearEntities ["CaManBase",2000]) select {simulationEnabled _x && !isObjectHidden _x})-[BRPVP_myPlayerOrSpec];
				} else {
					if ((BRPVP_spectateOn && BRPVP_sixthSenseOnSpec) || (!BRPVP_spectateOn && BRPVP_sixthSenseOn)) then {
						private _sixthSenseRange = [BRPVP_sixthSenseRange,BRPVP_sixthSenseRangeSpec] select BRPVP_spectateOn;
						BRPVP_sixthSenseObjectsAround = ((nearestObjects [BRPVP_myPlayerOrSpecOrDrone,["CaManBase"],_sixthSenseRange]) select {simulationEnabled _x && !isObjectHidden _x && alive _x && ((_x getVariable ["brpvp_ss_immune_mult",1]) isNotEqualTo 0)})-[BRPVP_myPlayerOrSpec];
						BRPVP_sixthSenseObjectsAround = BRPVP_sixthSenseObjectsAround select [0,35];
					};
				};
			};
			
			//GET ALL FLAGS WITH ACCESS
			BRPVP_myAllFlagInsideWithAccessObjs = call BRPVP_myAllFlagInsideWithAccess;
			BRPVP_myAllFlagInsideWithAccessRaidOn = BRPVP_myAllFlagInsideWithAccessObjs call BRPVP_isFlagsInRaidMode;
			(player getVariable "brpvp_mafiwao") params ["_mafiwaoLast","_raidOnLast"];
			private _flagsChanged = BRPVP_myAllFlagInsideWithAccessObjs-_mafiwaoLast isNotEqualTo [] || _mafiwaoLast-BRPVP_myAllFlagInsideWithAccessObjs isNotEqualTo [];
			private _raidStateChanged = BRPVP_myAllFlagInsideWithAccessRaidOn isNotEqualTo _raidOnLast;
			if (_flagsChanged || _raidStateChanged) then {player setVariable ["brpvp_mafiwao",[BRPVP_myAllFlagInsideWithAccessObjs,BRPVP_myAllFlagInsideWithAccessRaidOn],true];};

			//CALC NEAR MINERVA SOLDIERS
			private _minervaBotAllUnitsObjsNear = [];
			{if (_x distance BRPVP_myPlayerOrSpecOrDrone < BRPVP_aiWithLauncherHaveMinervaIconMaxDist && alive _x) then {_minervaBotAllUnitsObjsNear pushBack _x;};} forEach BRPVP_minervaBotAllUnitsObjs;
			BRPVP_minervaBotAllUnitsObjsNear = _minervaBotAllUnitsObjsNear;

			//CALC NEAR ULFAN SOLDIERS
			private _sBotAllUnitsObjsNear = [];
			{if (_x distance BRPVP_myPlayerOrSpecOrDrone < BRPVP_ulfanSoldier3DIconMaxDistance && alive _x) then {_sBotAllUnitsObjsNear pushBack _x;};} forEach BRPVP_sBotAllUnitsObjs;
			BRPVP_sBotAllUnitsObjsNear = _sBotAllUnitsObjsNear;

			//SPOT MESSAGES - FOR SPOTER AND SPOTED
			private _mySpotType = player getVariable ["brpvp_player_spoted",0];
			if (_mySpotType isEqualTo 2) then {
				//SPOTED BY SPOT SERVICE MESSAGE
				["<img align='center' size='2.8' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa' /><br/><t size='0.8'>"+localize "str_spoted_by_service"+"</t>",0,0,3,0,0,356272] call BRPVP_fnc_dynamicText;
			} else {
				//SPOT SERVICE FOUND FOR ME
				if (serverTime-BRPVP_spotServiceLocalFoundMessage <= 10) then {["<img align='center' size='2.8' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa' /><br/><t size='0.8'>"+localize "str_spot_service_found"+"</t>",0,0,3,0,0,532672] call BRPVP_fnc_dynamicText;};
			};
		};
		if (_tempo5) then {
			_inicio5 = _agora;
			
			//UPATE PLAYER_IN_VEHICLES ARRAY
			_playerVehicles = [];
			{if (!isNull objectParent _x) then {_playerVehicles pushBack _x;};} forEach call BRPVP_playersList;
			BRPVP_playerVehicles = +_playerVehicles;
			BRPVP_playerVehiclesVehicles = BRPVP_playerVehicles apply {vehicle _x};

			//STORE UNIFORM AND VEST
			_ufc = uniformContainer player;
			_vtc = vestContainer player;
			_uniformNew = [uniform player,[getWeaponCargo _ufc,getItemCargo _ufc,if (!isNull _ufc) then {magazinesAmmoCargo _ufc} else {[]}]];
			_vestNew = [vest player,[getWeaponCargo _vtc,getItemCargo _vtc,if (!isNull _vtc) then {magazinesAmmoCargo _vtc} else {[]}]];
			_uniformOld = player getVariable ["brpvp_uniform",[]];
			_vestOld = player getVariable ["brpvp_vest",[]];
			if !(_uniformNew isEqualTo _uniformOld) then {
				player setVariable ["brpvp_uniform",_uniformNew];
				[player,["brpvp_uniform",_uniformNew]] remoteExecCall ["setVariable",2];
			};
			if !(_vestNew isEqualTo _vestOld) then {
				player setVariable ["brpvp_vest",_vestNew];
				[player,["brpvp_vest",_vestNew]] remoteExecCall ["setVariable",2];
			};

			//GET NEAR FREEZE FLOORS
			BRPVP_nearFreezeFloor = count (player nearObjects ["Sign_Sphere200cm_F",200]);

			//HELI EVENT DIRECTION
			if (BRPVP_heliEventObjs isEqualTo [[],[],[]]) then {
				BRPVP_heliEventCenter = [];
			} else {
				BRPVP_heliEventObjs params ["_heHelis","_hePos","_iconData"];
				private _veh = objectParent player;
				private _isPilot = player isEqualTo currentPilot _veh;
				if (_isPilot && !isNull _veh && alive _veh && _veh in _heHelis) then {BRPVP_heliEventCenter = _hePos;} else {BRPVP_heliEventCenter = [];};
			};

			//CONSUME FUEL
			_vehFuel = objectParent player;
			_idx = -1;
			{if (_vehFuel isKindOf _x) exitWith {_idx = _forEachIndex;};} forEach BRPVP_extraFuelConsumeClass;
			if (_idx > -1 && {currentPilot _vehFuel isEqualTo player && isEngineOn _vehFuel}) then {
				if (_vehFuel isEqualTo _vehFuelLast) then {
					private ["_vehFuelTankNew"];
					_vehFuelTankNow = fuel _vehFuel;
					_delta = _vehFuelTankNow-_vehFuelTank;
					_tankTime = if (speed _vehFuel > 30) then {60*(BRPVP_extraFuelConsume select _idx)} else {2*60*(BRPVP_extraFuelConsume select _idx)};
					_tankTimeStep = -5/_tankTime;
					if (_delta < 0) then {
						_vehFuelTankNew = (_vehFuelTank+_tankTimeStep) max 0;
						_vehFuel setFuel _vehFuelTankNew;
						_vehFuelTank = _vehFuelTankNew;
					} else {
						_vehFuelTank = _vehFuelTankNow;
					};
				} else {
					_vehFuelTank = fuel _vehFuel;
					_vehFuelLast = _vehFuel;
				};
			} else {
				_vehFuelLast = objNull;
			};

			//FOOD CONSUME
			_canEatLight = BRPVP_foodEatLightEater && sunOrMoon isEqualTo 1;
			if (player getVariable ["sok",false] && player call BRPVP_pAlive && time > BRPVP_energeticEndTime && !(player getVariable "brpvp_god_admin") && !_canEatLight && !BRPVP_safeZone) then {
				private _cyclesToDie = BRPVP_foodEatCycle/5;
				if (time-BRPVP_ligaModoCombateLastEnd < 125) then {
					BRPVP_represedHungryCycles = (BRPVP_represedHungryCycles+1) min _cyclesToDie;
				} else {
					private _extra = if (BRPVP_alimentacao > 5) then {ceil (BRPVP_represedHungryCycles/(_cyclesToDie/4))} else {0};
					private _stepDown = 100/(BRPVP_foodEatCycle/5);
					BRPVP_alimentacao = (BRPVP_alimentacao-_stepDown-_stepDown*_extra) max 0;
					BRPVP_represedHungryCycles = (BRPVP_represedHungryCycles-_extra) max 0;
					player setVariable ["sud",[round BRPVP_alimentacao,100],[clientOwner,2]];
					if (BRPVP_alimentacao <= 5) then {
						if (BRPVP_alimentacao isEqualTo 0) then {
							player setDamage 0.85;
							[player,["BRPVP_dead_by_starve",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
							player spawn {
								sleep 3;
								if (_this call BRPVP_pAlive) then {
									BRPVP_starvedToDeath = true;
									[objNull,"Larica_F"] call BRPVP_pehKilledFakeHandleDamage;
								};
							};
						} else {
							private _msg = [localize "str_brpvp_you_is_starving","alt+i","<t color='#ff0000'>alt+i</t>"] call BRPVP_stringReplace;
							_msg = [_msg,"[ALT + I]","<t color='#ff0000'>[ALT + I]</t>"] call BRPVP_stringReplace;
							["<img size='1.75' image='"+BRPVP_imagePrefix+"BRP_imagens\food_bad.paa'/><br />"+_msg,0,0,4,0,0,6324] call BRPVP_fnc_dynamicText;
							if (random 1 < 0.75) then {"BRPVP_stomach" call BRPVP_playSound;};
						};
					};
				};
			};

			//CALC MISSIONS POS
			private _missionsPos = [];
			_missionsPos append (BRPVP_missPrediosEm apply {getPos _x});
			_missionsPos append (BRPVP_blockPlacesSelected apply {_x select 0});
			_missionsPos append BRPVP_onSiegeIcons;
			_missionsPos append (BRPVP_bombMissionObjs apply {getPos _x});
			_missionsPos append (BRPVP_holeMissionInfo apply {_x select 0});
			_missionsPos append (BRPVP_vehicleMissionIcons apply {getPos _x});
			_missionsPos append (BRPVP_pmissIcons apply {_x select 0});
			_missionsPos append (BRPVP_pmiss2Icons apply {_x select 0});
			{if (BRPVP_eventsDataCodeIsOn select _forEachIndex isEqualTo 2) then {_missionsPos pushBack (_x select 0);};} forEach BRPVP_eventsData;
			BRPVP_missionsPos = _missionsPos;
		
			//CHECK IF IN NO PICONS PLACE
			_inPicons = false;
			{
				_x params ["_pos","_rad"];
				if (BRPVP_myCenter distance2D _pos < _rad) exitWith {_inPicons = true;};
			} forEach (BRPVP_labNoThirdPerson+BRPVP_fastSpawnPlacesFugitive+(BRPVP_heliEventObjs select 2));
			BRPVP_inPIconsArea = _inPicons;

			//GET NEWER PLAYERS AND REMOVE OLD NEWER DISCOVEREDS
			if (!BRPVP_spectateOn) then {
				_newerPlayers = [];
				{if (_x getVariable ["brpvp_is_newer",false] || _x getVariable ["bdg",false]) then {_newerPlayers pushBack _x;};} forEach call BRPVP_playersList;
				BRPVP_newerPlayers = _newerPlayers;
				BRPVP_newersDiscovered = BRPVP_newerPlayers arrayIntersect BRPVP_newersDiscovered;
				{
					_isOld = time-(_x getVariable ["brpvp_n_discovered_time",time]) > BRPVP_newerDiscoveredTimeToMantain;
					_isAway = _x distanceSqr player > 6250000;
					if (_isOld || _isAway) then {BRPVP_newersDiscovered set [_forEachIndex,-1];};
				} forEach BRPVP_newersDiscovered;
				BRPVP_newersDiscovered = BRPVP_newersDiscovered-[-1];
			};
		
			//CHECK IF AIRCRAFT OR DESTROYER NEAR
			if (nearestObjects [vehicle player,["Land_Carrier_01_base_F"],400] isNotEqualTo []) then {BRPVP_nearBigShips = true;} else {BRPVP_nearBigShips = false;};

			//SHOW SPEC MENU
			if (BRPVP_spectateOn && {diag_tickTime-BRPVP_specMenuShowLast >= 10 && BRPVP_specMenuShowTxt isNotEqualTo ""}) then {hintSilent parseText BRPVP_specMenuShowTxt;};
			
			//GET REAL PING
			if (BRPVP_realPingInit isEqualTo -1) then {
				BRPVP_realPingInit = diag_tickTime;
				clientOwner remoteExecCall ["BRPVP_serverRealPing",2];
			};

			//SPEC SEND PING TO MY SPECTATORS
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
				player setVariable ["brpvp_ping",player getVariable "brpvp_ping",BRPVP_specOnMeMachinesNoMe];
				player setVariable ["brpvp_real_ping",player getVariable "brpvp_real_ping",BRPVP_specOnMeMachinesNoMe];
			};
		
			//SEND SIXTH SENSE TO SPECTATOR
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {
				private _sixthSenseCfgNow = [BRPVP_sixthSensePower,BRPVP_sixthSensePowerPlayer,BRPVP_sixthSenseOn,BRPVP_sixthSenseSeePlayer,BRPVP_sixthSenseRange];
				if (_sixthSenseCfgNow isNotEqualTo _sixthSenseCfgLast) then {
					_sixthSenseCfgNow remoteExecCall ["BRPVP_sixthSenseReceiveSpecVars",BRPVP_specOnMeMachinesNoMe];
					_sixthSenseCfgLast = _sixthSenseCfgNow;
				};
			};

			//BASE DESTROYED LINES SEMIFAR
			call BRPVP_baseBombCalcVisibleLinesSemiFar;

			//DYNAMIC WEATHER DEBUG
			if (BRPVP_useDynamicWeather) then {
				private _nowOvercast = overcast;
				private _delta = _nowOvercast-_lastOvercast;
				if (BRPVP_weatherDegug) then {
					private _oForecast = BRPVP_weatherPredictFortClients select 0;
					systemChat format ["Overcast now is %1%3 and going to %2%3 (Delta: %4%3).",round (overcast*100),round (_oForecast*100),"%",(round (_delta*100*1000))/1000];
					systemChat str ((call BRPVP_playersList select {(_x getVariable ["brpvp_client_overcast",-1]) isNotEqualTo -1}) apply {round ((_x getVariable "brpvp_client_overcast")*100)});
				};
				_lastOvercast = _nowOvercast;
			};

			//INFORM OVERCAST TO SERVER
			if (abs (overcast-(player getVariable "brpvp_client_overcast")) > 0.015 || BRPVP_weatherDebugMachinesOn isNotEqualTo _weatherDebugMachinesOnLast) then {
				_weatherDebugMachinesOnLast = +BRPVP_weatherDebugMachinesOn;
				private _mIds = BRPVP_weatherDebugMachinesOn+[2];
				_mIds pushBackUnique clientOwner;
				player setVariable ["brpvp_client_overcast",overcast,_mIds];
			};

			//REMOVE TIMED OUT TURRETS FROM BRPVP_turretShotOn
			{
				if (_x isNotEqualTo 0 && {diag_tickTime-_x > 30}) then {
					BRPVP_turretShotOn set [_forEachIndex,objNull];
					BRPVP_turretShotOnTime set [_forEachIndex,0];
				};
			} forEach BRPVP_turretShotOnTime;
		};
		if (_tempo10) then {
			private _delta10 = _agora-_inicio10;
			_inicio10 = _agora;
			
			//UPDATE MENU TO AVOID IT DISSAPEARS
			if ((BRPVP_menuExtraLigado && !BRPVP_menuCustomKeysOff) || BRPVP_construindo) then {call BRPVP_atualizaDebugMenu;};
			
			//RECORD FPS
			player setVariable ["brpvp_fps",BRPVP_fpsRecord,true];

			//UPDATE AVERAGE HEALTH
			if (player call BRPVP_pAlive && player getVariable ["sok",false]) then {
				{
					_dAvg = ((BRPVP_averageDamage select 2 select _forEachIndex) + _averageDamageStep) min (_x min 0.8);
					BRPVP_averageDamage select 2 set [_forEachIndex,_dAvg];
				} forEach (getAllHitPointsDamage player select 2);
				BRPVP_averageDamageGeneral = (BRPVP_averageDamageGeneral + _averageDamageStep) min (damage player);
			};
			
			//DELETE ZOMBIE LOOT
			_deleted = [];
			{
				if (time - (_x getVariable "brpvp_zombie_loot_time") > 300) then {
					_deleted pushBack _x;
					deleteVehicle _x;
				};
			} forEach BRPVP_zombieLootWH;
			if !(_deleted isEqualTo []) then {BRPVP_zombieLootWH = BRPVP_zombieLootWH - _deleted;};
			
			//CHECK PLAYER FOR SPOT ON MAP
			if (BRPVP_spotPlayersOnMap) then {
				_headPrice = player getVariable ["brpvp_head_price",0];
				_spotedByHeadPrice = _headPrice > 0;
				if (player call BRPVP_pAlive && (player getVariable ["mny",0] > BRPVP_moneyOnHandToSpot || _spotedByHeadPrice) && {!(player call BRPVP_checkIfSafeZoneProtected || player call BRPVP_checkIfFlagProtected)}) then {
					_spotMode = 1;
					if (_spotedByHeadPrice) then {
						_price = round (BRPVP_headPriceSpotConsumePerMinute/6) min _headPrice;
						player setVariable ["brpvp_head_price",_headPrice-_price,true];
						player setVariable ["brpvp_mny_bank",(player getVariable "brpvp_mny_bank")+0.5*_price,true];
						_spotMode = 2;

						//INFORM SPOTER I AN SPOTED
						private _allMids = BRPVP_spotServiceBackInformationList apply {_x select 0};
						if (_allMids isNotEqualTo []) then {
							private _del = [];
							remoteExecCall ["BRPVP_spotServicePlayerFoundMessage",_allMids];
							{
								_x params ["_mid","_start","_t"];
								if (serverTime > _start+_t) then {_del pushBack _forEachIndex;};
							} forEach BRPVP_spotServiceBackInformationList;
							_del sort false;
							{BRPVP_spotServiceBackInformationList deleteAt _x;} forEach _del;
						};
					};
					_pSpot = player getVariable ["brpvp_player_spoted",0];
					if (_pSpot isNotEqualTo _spotMode) then {
						player setVariable ["brpvp_player_spoted",_spotMode,[clientOwner,2]];
						if (_pSpot isEqualTo 0) then {["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\spotted.paa' />",{safeZoneX+safeZoneW-0.0765},{safeZoneY+0.23},1000000,0,0,3092] call BRPVP_fnc_dynamicText;};
					};
				} else {
					if (player getVariable ["brpvp_player_spoted",0] > 0) then {
						player setVariable ["brpvp_player_spoted",0,[clientOwner,2]];
						["",0,0,0,0,0,3092] call BRPVP_fnc_dynamicText;
					};
					{_x set [1,(_x select 1)+_delta10];} forEach BRPVP_spotServiceBackInformationList;
				};
			};

			//GET MY TIRE VEHICLES
			_po = player getVariable ["id_bd",-1];
			_myTires = [];
			{if (_x getVariable "brpvp_tire_owner" isEqualTo _po) then {_myTires pushBack _x;};} forEach BRPVP_tireAllTiresGlobal;
			BRPVP_myTires = _myTires;
		
			//GIVE RADIATION XP
			if (BRPVP_radioEnterTime isNotEqualTo -1) then {
				private _delta = (time-BRPVP_radioEnterTime)*BRPVP_radioAreasTotalIntensity/BRPVP_radioAreasNormalXpRadio;
				[["radio",round _delta]] call BRPVP_mudaExp;
				if (BRPVP_radioEnterTime isNotEqualTo -1) then {BRPVP_radioEnterTime = time;};
			};

			//RECORD VEHICLE USAGE
			call BRPVP_recordUseVehTempCode;

			//RECORD PLAY TIME
			call BRPVP_tempRecordPlayedHours;

			//COUNT SUITCASES IN INFECTED CITIES
			_cnt = count BRPVP_zombieSuperSpawnCities;
			_lim = floor (_cnt/2);
			{
				_x params ["_pos","_rad","_name","_id","_qsc"];
				_mny = 0;
				{_mny = _mny+(_x getVariable ["mny",0]);} forEach nearestObjects [_pos,["Land_Suitcase_F"],_rad,true];
				_mny = (round (_mny/100000))/10;
				_x set [4,format ["$%1KK",_mny]];
			} forEach (BRPVP_zombieSuperSpawnCities select ([[0,_lim],[_lim,_cnt-_lim]] select _scaseInfec));
			_scaseInfec = !_scaseInfec;

			//CALC MY FRANTA MINES
			call BRPVP_recalcMyFrantaMines;

			//SET FOOD STATE GLOBALLY
			player setVariable ["sud",[BRPVP_alimentacao,100],true];
		
			//SAVE SECURITY CAMERAS CONNECTIONS
			if (BRPVP_secCamBbsMyPlayerSave isNotEqualTo BRPVP_secCamBbsMyPlayerSaveLast) then {
				player remoteExecCall ["BRPVP_secCamSaveConnectionsDb",2];
				BRPVP_secCamBbsMyPlayerSaveLast = +BRPVP_secCamBbsMyPlayerSave;
			};

			//BASE DESTROYED LINES FAR
			call BRPVP_baseBombCalcVisibleLinesFar;

			//RYAN ZOMBIES
			if (BRPVP_rZedsRunning && {diag_tickTime-BRPVP_rZedsCfgLastSpawnTime > BRPVP_rZedsCfgCoolDown}) then {
				private _ok = ZBL_hasAntiZombie isEqualto 0 && player getVariable ["sok",false] && player call BRPVP_zombieCanSee && !BRPVP_safeZone && !BRPVP_construindo && !surfaceIsWater getPosWorld player && !(call BRPVP_playerIsBusyForRyanZeds);
				if (_ok) then {
					BRPVP_rZedsCfgLastSpawnTime = diag_tickTime;
					BRPVP_rZedsCfgCoolDown = selectRandom BRPVP_rZedsCfgCoolDownArray;
					call BRPVP_rZedsTryToSpawn;
				} else {
					BRPVP_rZedsCfgLastSpawnTime = diag_tickTime;
					BRPVP_rZedsCfgCoolDown = (selectRandom BRPVP_rZedsCfgCoolDownArray)/1.75;
				};
			};

			//RELEASE HOUUSE FOR NEW AUTO DOOR OPEN
			if (BRPVP_autoOpenDoorPerk) then {call BRPVP_autoOpenDoorPerkClose;};
		};
		if (_tempo30) then {
			_inicio30 = _agora;

			//CLEAR SPOTED DRONE OPERATOR ARRAY
			{
				if (time-(_x select 0) > BRPVP_spotedDroneOperatorsTime) then {
					BRPVP_spotedDroneOperators set [_forEachIndex,-1];
				};
			} forEach BRPVP_spotedDroneOperators;
			BRPVP_spotedDroneOperators = BRPVP_spotedDroneOperators-[-1];

			//FIX SAFEZONE EXIT PROTECTION MISSMATCH
			if !(player getVariable "brpvp_extra_protection") then {player remoteExecCall ["BRPVP_safezoneProtectionOnExitRemoveObj",0];};
		};
		if (_tempoMNY) then {
			_inicioMNY = _agora;
			if (player getVariable "sok") then {
				_cycleMNY = _cycleMNY + 1;
				if (_cycleMNY isEqualTo BRPVP_stayOnlineMoneyRewardExtraCycle) then {
					_cycleMNY = 0;
					player setVariable ["mny",(player getVariable "mny") + BRPVP_stayOnlineMoneyRewardExtraValor,true];
					[format [localize "str_fidelity_prize2",BRPVP_stayOnlineMoneyRewardExtraValor],0] call BRPVP_hint;
					"granted" call BRPVP_playSound;
				} else {
					player setVariable ["mny",(player getVariable "mny") + BRPVP_stayOnlineMoneyRewardValor,true];
					[format [localize "str_fidelity_prize1",BRPVP_stayOnlineMoneyRewardValor],0] call BRPVP_hint;
					"negocio" call BRPVP_playSound;
				};
				call BRPVP_atualizaDebug;
			};
		};

		//PLAYER DAMAGED
		if (BRPVP_playerDamaged) then {
			call BRPVP_atualizaDebug;
			BRPVP_playerDamaged = false;
		};

		//CONHECIDO FN_SELFACTIONS
		if ((isActionMenuVisible && {!_bin1 && !_bin2}) || (!isActionMenuVisible && time-_menuOffTime > 0.5)) then {
			_menuOffTime = time;
			_objs = [];
			if (!BRPVP_construindo && player call BRPVP_pAlive) then {
				_veh = objectParent player;
				if (isNull _veh) then {
					if (time-BRPVP_accessAllNear < 2) then {
						{if !(typeOf _x in _findAllNearExlude) then {_objs pushBack _x;};} forEach nearestObjects [player,[],6.5];
					} else {
						{if (typeOf _x in _noCrosshairDetection || _x isKindOf "CaManBase") then {_objs pushBack _x;};} forEach (player nearObjects 2.5);
					};
					{_objs pushBackUnique _x;} forEach nearestObjects [player,_noCrosshairDetectionBig,10];
					_objs deleteAt (_objs find player);
					_vec = (getCameraViewDirection player) vectorMultiply 6;
					_posCam = AGLToASL (positionCameraToWorld [0,0,0]);
					_lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,3,"VIEW","FIRE"];
					_found = false;
					{
						_obj = _x select 2;
						_typeOf = typeOf _obj;
						if (_typeOf != "") exitWith {
							_found = true;
							if !(_typeOf in _noCrosshairDetection) then {_objs pushBackUnique _obj;};
						};
					} forEach _lis;
					if (!_found && count _lis > 0) then {_objs pushBackUnique (_lis select 0 select 2);};
				} else {
					_objs pushBack _veh;
				};
			};
			//REMOVE ACTIONS FROM OBJECTS THAT BECAME NULL
			_remove = [];
			{
				if (isNull _x) then {
					{player removeAction _x;} forEach (_objsActionsCheckNullB select _forEachIndex);
					_remove pushBack _forEachIndex;
				};
			} forEach _objsActionsCheckNullA;
			_remove sort true;
			{
				_objsActionsCheckNullA deleteAt _x;
				_objsActionsCheckNullB deleteAt _x;
			} forEach _remove;
			//ADD AND REMOVE INTERACTIONS ON CURRENT OBJECTS
			if !(BRPVP_motorizedToLockUnlock in _objs) then {BRPVP_motorizedToLockUnlock = objNull;};
			{
				_object = _x;
				if (!isNull _object) then {
					private _isTouchingGround = istouchingGround _object || position _object select 2 < 0.25;
					private _velocityMag = vectorMagnitude velocity _object;
					private _objectTypeOf = typeOf _object;
					private _isDrone = _objectTypeOf in BRPVP_vantVehiclesClass;
					private _objectDisplayName = if (_objectTypeOf isEqualTo "") then {str _object} else {getText (configFile >> "CfgVehicles" >> _objectTypeOf >> "displayName") call BRPVP_escapeForStructuredTextFast};
					private _objectHaveAccess = _object call BRPVP_checaAcesso;
					private _isSimpleObject = isSimpleObject _object;
					private _objectDistance = _object distance player;
					private _inVeh = !isNull objectParent player;
					private _isMan = _object isKindOf "CAManBase";
					private _isPlayer = (typeOf _object) isEqualTo BRPVP_playerModel;
					private _objectIsMotorized = _object call BRPVP_isMotorized;
					private _objectIsStaticWeapon = _object isKindOf "StaticWeapon";
					private _objectIsMotorizedNotStatic = _objectIsMotorized && !_objectIsStaticWeapon;
					private _isAlive = _object call BRPVP_pAlive;
					private _ruin = (_object isKindOf "Ruins_F" && (_object getVariable ["id_bd",-1]) > -1) || (_objectIsMotorizedNotStatic && !_isAlive);
					private _isMine = (_object getVariable ["own",-1]) isEqualTo (player getVariable ["id_bd",-1]) && (_object getVariable ["own",-1] > -1);
					private _isDb = _object getVariable ["id_bd",-1] > -1;
					private _isGodModeHouseDb = _object getVariable ["brpvp_map_god_mode_house_id",-1] > -1;
					private _haveOwner = _object getVariable ["own",-1] > -1;
					private _isBox = _object isKindOf "ReammoBox_F";
					private _veryNear = player distanceSqr _object <= 4;
					private _objectIsHolder = _objectTypeOf in ["GroundWeaponHolder","WeaponHolderSimulated"];
					private _isMyBase = BRPVP_myBaseState isEqualTo 2;

					//VENDEDORES ITENS
					_actionVar = "brpvp_act_0";
					_actionId = _object getVariable [_actionVar,-1];
					_mcdrId = _object getVariable ["mcdr",-1];
					if (_mcdrId >= 0 && {!(0 in BRPVP_actionRunning)}) then {
						BRPVP_itemTraderDiscount = _object getVariable ["brpvp_price_level",1];
						_itemFilter = _object getVariable ["brpvp_item_filter",0];
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [localize "str_adda_merchant","client_code\actions\actionTrader.sqf",[_object,_mcdrId,1,_itemFilter]]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//VENDEDORES VEICULOS
					_actionVar = "brpvp_act_1";
					_actionId = _object getVariable [_actionVar,-1];
					_vndv = _object getVariable ["vndv",[]];
					if (count _vndv > 0 && {!(1 in BRPVP_actionRunning)}) then {
						if (_actionId isEqualTo -1) then {
							_deployType = _object getVariable ["vndv_deployType","default"];
							_noInsurance = _object getVariable ["vndv_no_insurance",false];
							_txtAction = if (_object isKindOf "CaManBase") then {"str_black_trader_action"} else {"str_adda_call_sub"}; 
							_object setVariable [_actionVar,player addAction [localize _txtAction,"client_code\actions\actionVehicleTrader.sqf",[_object,_vndv,1,_deployType,_noInsurance,-1]]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//REVIVE OR SUFOCATE PLAYER
					_actionId_1 = _object getVariable ["brpvp_act_2_1",-1];
					_actionId_2 = _object getVariable ["brpvp_act_2_2",-1];
					if (_object getVariable ["dd",-1] isEqualTo 0 && {isNull objectParent _object && !(2 in BRPVP_actionRunning)}) then {
						if (_actionId_1 isEqualTo -1) then {
							_object setVariable ["brpvp_act_2_1",player addAction ["<t color='#00BB00'>"+format [localize "str_adda_revive",_object getVariable ["nm","this player"]]+"</t>","client_code\actions\actionRevive.sqf",_object]];
							_object setVariable ["brpvp_act_2_2",player addAction ["<t color='#BB0000'>"+format [localize "str_adda_kill",_object getVariable ["nm","this player"]]+"</t>","client_code\actions\actionFinalize.sqf",_object]];
						};
					} else {
						if !(_actionId_1 isEqualTo -1) then {
							player removeAction _actionId_1;
							player removeAction _actionId_2;
							_object setVariable ["brpvp_act_2_1",-1,false];
							_object setVariable ["brpvp_act_2_2",-1,false];
						};
					};
					//USE CRANE ON VEHICLE
					_actionVar = "brpvp_act_3";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectIsMotorizedNotStatic && _isAlive && (_isTouchingGround || _velocityMag < 0.001) && !(3 in BRPVP_actionRunning)) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [localize "str_adda_crane","client_code\actions\actionFlipVehicle.sqf",[_object,5,2],1.5,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TRANSFER ITEMS: FROM
					_fromUnit = !_isAlive && _isMan && !(_object getVariable ["brpvp_ttg_used",false]) && {!(_object call BRPVP_isPlayer) || surfaceIsWater getPosWorld _object};
					_fromHolder = _objectIsHolder && _objectHaveAccess;
					_fromVehicle = (_objectIsMotorizedNotStatic || _isBox) && _objectHaveAccess && _isAlive && !_isSimpleObject && !_inVeh;
					_haveFrom = _fromHolder || _fromVehicle;
					_haveFromWithUnit = _haveFrom || _fromUnit;
					//TRANSFER ITEMS: TO RECEPTACLE
					_actionVar = "brpvp_act_5_1";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFrom && {!(5 in BRPVP_actionRunning) && !isNull BRPVP_sellReceptacle && _object != BRPVP_sellReceptacle && _object distance BRPVP_sellReceptacle <= BRPVP_transferDistanceLimit}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+localize "str_adda_trans_to_recep"+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,BRPVP_sellReceptacle],1.49,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TRANSFER ITEMS: TO VAULT
					_actionVar = "brpvp_act_5_2";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFrom && {!(5 in BRPVP_actionRunning) && !isNull BRPVP_holderVault && _object != BRPVP_holderVault && _object distance BRPVP_holderVault <= BRPVP_transferDistanceLimit}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+localize "str_adda_trans_to_vault"+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,BRPVP_holderVault],1.48,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TRANSFER ITEMS: TO ASSIGNED VEHICLE
					_actionVar = "brpvp_act_5_3";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFrom && {!(5 in BRPVP_actionRunning) && !isNull BRPVP_assignedVehicle && alive BRPVP_assignedVehicle && _object != BRPVP_assignedVehicle && BRPVP_assignedVehicle call BRPVP_checkIfCargo && _object distance BRPVP_assignedVehicle <= BRPVP_transferDistanceLimit}) then {
						if (_actionId isEqualTo -1) then {
							_txt = getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_assignedVehicle) >> "displayName") call BRPVP_escapeForStructuredTextFast;
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+format [localize "str_adda_trans_to_obj",_txt]+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,BRPVP_assignedVehicle],1.47,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TRANSFER ITEMS: TO BASE BOX
					_actionVar = "brpvp_act_5_4";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFrom && {!(5 in BRPVP_actionRunning) && !isNull BRPVP_lastBaseBox && _object != BRPVP_lastBaseBox && _object distance BRPVP_lastBaseBox <= BRPVP_transferDistanceLimit}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+localize "str_adda_trans_to_base_box"+"</t>"),"client_code\actions\actionTransfer.sqf",[_object,BRPVP_lastBaseBox],1.48,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TRANSFER ITEMS: TO GROUND
					_actionVar = "brpvp_act_5_5";
					_actionId = _object getVariable [_actionVar,-1];
					if (_haveFromWithUnit && !_objectIsHolder && !(5 in BRPVP_actionRunning)) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFFF00'>"+localize "str_adda_trans_to_ground"+"</t>"),"client_code\actions\actionTransferGround.sqf",_object,1.46,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//GET MONEY FROM BRIEF CASE
					_actionVar = "brpvp_act_6";
					_actionId = _object getVariable [_actionVar,-1];
					_mny = _object getVariable ["mny",0];
					_canGetMny = if (_mny > 0 && _objectTypeOf isEqualTo "Land_Suitcase_F" && _objectHaveAccess) then {
						_lis = lineIntersectsSurfaces [eyePos player,getPosWorld _object,player,_object,true,-1,"GEOM","NONE",true];
						{(_x select 2) isKindOf "Building" && !((_x select 2) isKindOf "CaManBase") && !((_x select 2) isKindOf "WeaponHolder") && !((_x select 2) isKindOf "Ruins")} count _lis isEqualTo 0
					} else {
						false
					};
					if (_canGetMny) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction [("<t color='#FFDD00'>"+format [localize "str_adda_get_money",_mny call BRPVP_formatNumber]+"</t>"),"client_code\actions\actionGetMoney.sqf",_object,1.45,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//MY STUFF MENU
					_actionVar = "brpvp_act_7";
					_actionId = _object getVariable [_actionVar,-1];
					_boo = if (BRPVP_allPlayersOnFlagHaveAccessToAllBase) then {player call BRPVP_checkOnFlagState isEqualTo 2} else {player call BRPVP_playerIsIntoOwnerTerritory};
					_isMyTerritory = _boo && !_objectIsMotorizedNotStatic;
					_iCanMove = _isMyBase && !_objectIsMotorizedNotStatic;
					_canPylonise = isClass (configFile >> "CfgVehicles" >> _objectTypeOf >> "Components" >> "TransportPylonsComponent") && _objectHaveAccess;
					if (!(7 in BRPVP_actionRunning) && _isAlive && ((_iCanMove || _isMine || BRPVP_vePlayers || _isMyTerritory || _object isKindOf "FlagCarrier" || _objectTypeOf isEqualTo BRPVP_baseSignClass || (_objectTypeOf isEqualTo "Land_RaiStone_01_F" && _objectHaveAccess) || ((!_isDrone && _canPylonise) || (_isDrone && _canPylonise && !BRPVP_dronesMakeAllUnarmed))) && _haveOwner && (_isDb || _isGodModeHouseDb) && !_isMan) && !BRPVP_playerIsRemovingObject) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FFCC55'>"+format[localize "str_adda_item_menu",_objectDisplayName]+"</t>","client_code\actions\actionItemMenu.sqf",_object,1.44+(_objectDistance/10000),false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//BULLDOZER
					_actionVar = "brpvp_act_8";
					_actionId = _object getVariable [_actionVar,-1];
					_canClean = !(_object getVariable ["brpvp_no_clean",false]);
					if (_ruin && _canClean && {!(8 in BRPVP_actionRunning)}) then {
						if (_actionId isEqualTo -1) then {
							_price = 100;
							_object setVariable [_actionVar,player addAction ["<t color='#666666'>"+format [localize "str_adda_clean_ruin",_price]+"</t>","client_code\actions\actionBulldozer.sqf",[_price,_object]]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//RADAR SPOTS
					_actionVar = "brpvp_act_9";
					_actionId = _object getVariable [_actionVar,-1];
					_antennaIndex = BRPVP_antennasObjs find _objectTypeOf;
					if (_antennaIndex != -1 && {!(9 in BRPVP_actionRunning)}) then {
						if (_actionId isEqualTo -1) then {
							_force = BRPVP_antennasObjsForce select _antennaIndex;
							_object setVariable [_actionVar,player addAction ["<t color='#4040FF'>"+localize "str_adda_radar_on"+"</t>","client_code\actions\actionRadarSpot.sqf",[_object,_force]]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//DISMANTLE OTHERS RESPAWN
					_actionVar = "brpvp_act_10";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf in (BRP_kitRespawnA+BRP_kitRespawnB) && {!_isMine && _isDb}) then {
						private _eyePos = eyePos player;
						private _vec = getCameraViewDirection player vectorMultiply 0.75;
						private _lis = lineIntersectsSurfaces [_eyePos,_eyePos vectorAdd _vec,vehicle player,objNull,true,1,"VIEW","NONE"];
						private _can = _lis isNotEqualTo [] && {_lis select 0 select 2 isEqualTo _object};
						if (_actionId isEqualTo -1 && _can) then {
							_object setVariable [_actionVar,player addAction ["<t color='#9050FF'>"+format [localize "str_adda_respawn_destroy",BRPVP_dismantleRespawnPrice]+"</t>","client_code\actions\actionDismantleRespawn.sqf",_object,1.2,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TURN LIGHT OFF
					_actionVar = "brpvp_act_11";
					_actionId = _object getVariable [_actionVar,-1];
					_accessLamp = _objectTypeOf in BRP_kitLamp && _objectHaveAccess;
					if (_accessLamp) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#BBFF00'>"+localize "str_adda_light_on"+"</t>","client_code\actions\actionLightOn.sqf",_object]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TURN LIGHT OFF
					_actionVar = "brpvp_act_12";
					_actionId = _object getVariable [_actionVar,-1];
					if (_accessLamp) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#AAEE00'>"+localize "str_adda_light_off"+"</t>","client_code\actions\actionLightOff.sqf",_object]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//LAND VEHICLE TOW
					_actionVar = "brpvp_act_13";
					_actionId = _object getVariable [_actionVar,-1];
					if (!_inVeh && _isAlive && _objectHaveAccess && {!_isSimpleObject && (_object isKindOf "LandVehicle" || _object isKindOf "Helicopter") && !_objectIsStaticWeapon && !(_object getVariable ["brpvp_no_tow",false]) && !(_object in BRPVP_landVehicleOnTow) && {!isNull _x && alive _x} count BRPVP_landVehicleOnTow < BRPVP_towLandNumber}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF88FF'>"+format [localize "str_adda_tow_land",BRPVP_towLandVehiclePrice]+"</t>","client_code\actions\actionTowLandVehicle.sqf",_object]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//LAND VEHICLE TOW CANCEL
					_actionVar = "brpvp_act_14";
					_actionId = _object getVariable [_actionVar,-1];
					if (!_inVeh && _isAlive && _object in BRPVP_landVehicleOnTow) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF88FF'>"+localize "str_adda_tow_end"+"</t>","client_code\actions\actionTowLandVehicleEnd.sqf",_object]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//SURRENDER A PLAYER
					_actionVar = "brpvp_act_15";
					_actionId = _object getVariable [_actionVar,-1];
					_canSurrender = false;
					if (!BRPVP_safeZone && _objectDistance < 3) then {
						if (_object call BRPVP_isPlayer && {!isObjectHidden _object && isNull objectParent _object && !(_object isEqualTo player) && _isAlive && isNull (_object getVariable ["brpvp_surrendedBy",objNull]) && isNull (player getVariable ["brpvp_surrendedBy",objNull])}) then {
							_currentWeapon = currentWeapon player;
							if (_currentWeapon != "" && !(_currentWeapon in BRPVP_binocularToIgnoreAsWeapon)) then {
								_dirTo = [player,_object] call BIS_fnc_dirTo;
								_dirUnit = getDir _object;
								_diffDir = abs(_dirTo-_dirUnit);
								_diffDir = _diffDir min (360-_diffDir);
								_fromBehind = _diffDir <= 25;
								_canSurrender = _fromBehind;
							};
						};
					};
					if (_canSurrender && !(11 in BRPVP_actionRunning)) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#CC0000'>"+localize "str_surr_surrender"+"</t>","client_code\actions\actionSurrender.sqf",_object,1.43,true,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//SURRENDER: ASK DROP ITEMS
					_actionVar = "brpvp_act_16";
					_actionId = _object getVariable [_actionVar,-1];
					if (player isEqualTo (_object getVariable ["brpvp_surrendedBy",objNull]) && !(12 in BRPVP_actionRunning)) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#CCCC00'>"+localize "str_surr_ask_drop"+"</t>","client_code\actions\actionSurrenderAskDrop.sqf","",1.43,true,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//BURN THE HEREGE
					_actionVar = "brpvp_act_17";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf in BRP_kitReligious) then {
						if !(13 in BRPVP_actionRunning) then {
							if (_actionId isEqualTo -1) then {
								_object setVariable [_actionVar,player addAction ["<t color='#884400'>"+localize "str_burn_herege"+" </t><img image='"+BRPVP_imagePrefix+"BRP_imagens\interface\cross.paa'/>","client_code\actions\actionBurnTheHerege.sqf",_object]];
							};
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//ATM MONEY MACHINE
					_actionVar = "brpvp_act_18";
					_actionId = _object getVariable [_actionVar,-1];
					_isPersonalAtm = _objectTypeOf isEqualTo "Land_CashDesk_F";
					if ((_objectTypeOf in BRPVP_atmClasses || _object in BRPVP_atmOldActivated || _isPersonalAtm) && !(14 in BRPVP_actionRunning)) then {
						if (_actionId isEqualTo -1) then {
							_code = {BRPVP_personalAtm = _this select 3;BRPVP_actionRunning pushBack 14;54 call BRPVP_iniciaMenuExtra;};
							_object setVariable [_actionVar,player addAction ["<t color='#FF88FF'>"+localize "str_adda_atm_acs"+" </t></t><img image='"+BRPVP_imagePrefix+"BRP_imagens\interface\atm.paa'/>",_code,_isPersonalAtm]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//EASILY REMOVED STUFF OUT OF FLAG AREAS
					if (BRPVP_buildingAwayFromFlagEasyDestroy && !(_object getVariable ["mapa",false])) then {
						_actionVar = "brpvp_act_20";
						_actionId = _object getVariable [_actionVar,-1];
						_objectIsBuilding = _object call BRPVP_isBuilding;
						_objectIsThingX = _object isKindOf "ThingX";
						_isSimpleObject = isSimpleObject _object;
						_isFlagProtected = _object call BRPVP_checkIfFlagProtected;
						if ((_objectIsBuilding || _objectIsThingX) && {!_isFlagProtected && !(16 in BRPVP_actionRunning) && _isAlive && _isDb}) then {
							if (_actionId isEqualTo -1) then {
								_object setVariable [_actionVar,player addAction ["<t color='#FF55CC'>"+format[localize "str_adda_destroy_unprotected",_objectDisplayName]+"</t>","client_code\actions\actionDestroyUnprotectedBuilding.sqf",_object,1.45,false]];
							};
						} else {
							if !(_actionId isEqualTo -1) then {
								player removeAction _actionId;
								_object setVariable [_actionVar,-1];
							};
						};
					};
					//SEE OBJECT OWNER
					_actionVar = "brpvp_act_21";
					_actionId = _object getVariable [_actionVar,-1];
					if (!(17 in BRPVP_actionRunning) && _object getVariable ["own",-1] >= 0  && !_isMan && !(_object getVariable ["mapa",false]) && (BRPVP_vePlayers || (42 call BRPVP_sitCountItem) > 0 || _isMyBase)) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#55FFCC'>"+format[localize "str_adda_see_owner",_objectDisplayName]+"</t>","client_code\actions\actionSeeObjectOwnerName.sqf",[_object,_isMyBase],1.42,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//LOCK MOTORIZED
					_elegibleToLockUnlock = !(18 in BRPVP_actionRunning) && _isDb && _objectIsMotorizedNotStatic && _object getVariable ["own",-1] isNotEqualTo -1;
					_locked = _object getVariable ["brpvp_locked",false];
					_actionVar = "brpvp_act_22_1";
					_actionId = _object getVariable [_actionVar,-1];
					if (_elegibleToLockUnlock && !_locked) then {
						if (_actionId isEqualTo -1) then {
							BRPVP_motorizedToLockUnlock = _object;
							_object setVariable [_actionVar,player addAction ["<t color='#CC33FF'>"+format[localize "str_adda_vehicle_lock",_objectDisplayName]+"</t>","client_code\actions\actionVehicleLockUnlock.sqf",_object,1.41,false,true,"","false"]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//UNLOCK MOTORIZED
					_actionVar = "brpvp_act_22_2";
					_actionId = _object getVariable [_actionVar,-1];
					if (_elegibleToLockUnlock && _locked) then {
						if (_actionId isEqualTo -1) then {
							BRPVP_motorizedToLockUnlock = _object;
							_object setVariable [_actionVar,player addAction ["<t color='#CC33FF'>"+format[localize "str_adda_vehicle_unlock",_objectDisplayName]+"</t>","client_code\actions\actionVehicleLockUnlock.sqf",_object,1.41,false,true,"","false"]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//FIX AND FULL FIX VEHICLE
					_actionId = _object getVariable ["brpvp_act_23A",-1];
					if (_objectIsMotorizedNotStatic && _isAlive && "ToolKit" in items player && !_inVeh) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable ["brpvp_act_23A",player addAction ["<t color='#FFFFFF'>"+localize "str_repair_vehicle"+"</t>",{if !(BRPVP_reparingVehicle) then {BRPVP_reparingVehicle = true;(_this select 3) spawn BRPVP_fixVehicle;};},_object,2.5,true]];
							_object setVariable ["brpvp_act_23B",player addAction ["<t color='#FFFFFF'>"+localize "str_vehicle_full_fix"+"</t>",{if !(BRPVP_reparingVehicle) then {BRPVP_reparingVehicle = true;(_this select 3) spawn BRPVP_fixVehicleFull;};},_object,2.49,true]];
							private _lpm = _object getVariable ["brpvp_perm_msg",-10];
							if (diag_tickTime-_lpm > 15) then {
								_object setVariable ["brpvp_perm_msg",diag_tickTime];
								private _permDam = format ["%1%2",round ((_object call BRPVP_getLifesFixPermanentDamage)*100),"%"];
								["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\perm_damage.paa'/><br/><t size='0.75'>"+format [localize "str_perm_damage",_permDam]+"</t>",0,0,2.5,0,0,4527] call BRPVP_fnc_dynamicText;
							};
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction (_object getVariable ["brpvp_act_23A",-1]);
							_object setVariable ["brpvp_act_23A",-1];
							player removeAction (_object getVariable ["brpvp_act_23B",-1]);
							_object setVariable ["brpvp_act_23B",-1];
						};
					};
					//ANIMATE HANGAR DOOR
					_actionVar = "brpvp_act_24";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf isEqualTo "Land_Airport_01_hangar_F") then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#6580CC'>"+localize "str_custom_anim_door"+"</t>",BRPVP_hangarDoorControl,_object,1.5,true,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//ADD MONEY TO BOX
					_actionVar = "brpvp_act_25";
					_actionId = _object getVariable [_actionVar,-1];
					if (_isBox && _objectHaveAccess && _isDb && _isAlive) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#208050'>"+format [localize "str_store_money_in",_objectDisplayName]+"</t>",{BRPVP_stuff = _this select 3;87 call BRPVP_iniciaMenuExtra;},_object,1.5,true,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//FLAG CONTROL CENTER
					_actionVar = "brpvp_act_26";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf isEqualTo "Land_CashDesk_F") then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#CCFF88'>"+localize "str_control_center_action"+"</t>",BRPVP_controlCenterStart,_object,1.5,true,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//REMOVE MONEY FROM BOX
					_actionVar = "brpvp_act_27";
					_actionId = _object getVariable [_actionVar,-1];
					if (_isBox && _objectHaveAccess && _isDb && _isAlive && _object call BRPVP_isUnderWater) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#309060'>"+format [localize "str_get_money_out",_objectDisplayName]+"</t>",{BRPVP_stuff = _this select 3;104 call BRPVP_iniciaMenuExtra;},_object,1.5,true,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//DEAD PLAYER GEAR ACTION
					_actionVar = "brpvp_act_28";
					_actionId = _object getVariable [_actionVar,-1];
					if (_isPlayer && !_isAlive && _veryNear) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#35996C'>"+localize "str_player_gear_action"+"</t>",{player action ["Gear",_this select 3];},_object,1.5,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//CARRY DEAD BODY
					_actionVar = "brpvp_act_29";
					_actionId = _object getVariable [_actionVar,-1];
					if (_isPlayer && !_isAlive && _veryNear && !(29 in BRPVP_actionRunning)) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#F04020'>"+localize "str_body_move_action"+"</t>",{call BRPVP_carryBody;},_object,1.5,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//USE TELEPORTER
					_actionVar = "brpvp_act_30";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf isEqualTo "Land_RaiStone_01_F" && (_isDb || _object getVariable ["brpvp_rto",false])) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#804020'>"+localize "str_tele_action"+"</t>",{call BRPVP_teleUseCode;},_object,1.5,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//CHANGE PLANE DIR
					_actionVar = "brpvp_act_31";
					_actionId = _object getVariable [_actionVar,-1];
					if (_object isKindOf "Plane" && _isAlive && _objectHaveAccess && !_inVeh) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#D0A0F0'>"+localize "str_plane_dir_action"+"</t>",{_o = _this select 3;[_o,getDir player-180] remoteExecCall ["setDir",_o];_o setVariable ["slv",true,[clientOwner,2]];player setVehiclePosition [ASLToAGL getPosASL player,[],0,"NONE"];},_object,1.5,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//CHECK VEHICLE VG SLOT
					_actionVar = "brpvp_act_32";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectIsMotorizedNotStatic && _isAlive && _haveOwner) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#A0D0F0'>"+format [localize "str_check_vg_slot",_objectDisplayName]+"</t>",{call BRPVP_checkVehicleVirtualGarageSlot;},_object,1.3,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//BAG SOLDIER OPTIONS
					_actionVar = "brpvp_act_33";
					_actionId = _object getVariable [_actionVar,-1];
					if (_object getVariable ["brpvp_bag_soldier",false]) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#E6C390'>"+localize "str_configure_bag_soldier"+"</t>",{BRPVP_stuff = _this select 3;154 call BRPVP_iniciaMenuExtra;},_object,1.5,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//MOVE BOAT ON GROUND
					_actionVar = "brpvp_act_34";
					_actionId = _object getVariable [_actionVar,-1];
					_posPush = getPosWorld _object;
					_posPush set [2,0];
					_hPush = (ASLToATL AGLToASL _posPush) select 2;
					if (_object isKindOf "Ship" && _isAlive && !_inVeh && _hPush < 2) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#50E050'>"+localize "str_push_boat"+"</t>",{[_this select 3,player] remoteExec ["BRPVP_pushBoat",_this select 3];},_object,1.5,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//PAINT VEHICLE
					_actionVar = "brpvp_act_35";
					_actionId = _object getVariable [_actionVar,-1];
					if (_object getVariable ["brpvp_paint_enabled",false] && {_isAlive && _isMine}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#F04040'>"+localize "str_paint_vehicle_act"+"</t>",{BRPVP_stuff = _this select 3;144 call BRPVP_iniciaMenuExtra;},_object,1.5,false,false]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//HELI RAPEL
					_actionVar = "brpvp_act_36";
					_actionId = _object getVariable [_actionVar,-1];
					if (objectParent player isEqualTo _object && {!(currentPilot _object isEqualTo player) && _object isKindOf "Helicopter" && position _object select 2 > 10 && vectorMagnitude velocity _object < 10}) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#4040F0'>"+localize "str_slingload_player"+"</t>",{call BRPVP_rapel;},_object,1.6,false,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//TIRE VEHICLES
					_actionVar1 = "brpvp_act_37";
					_actionId1 = _object getVariable [_actionVar1,-1];
					_actionVar2 = "brpvp_act_38";
					_actionId2 = _object getVariable [_actionVar2,-1];
					_tireGetFrom = _objectTypeOf in ["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"] && _object getVariable ["brpvp_tire_idbd",-1] > -1;
					_tireMoveTo = _objectIsMotorizedNotStatic && _isDb && _isAlive && (_isMine || BRPVP_vePlayers) && _isTouchingGround;
					if ((_tireGetFrom || (_tireMoveTo && BRPVP_useTireCanMoveToMagus)) && !_inVeh && !(37 in BRPVP_actionRunning)) then {
						if (_actionId1 isEqualTo -1) then {
							if (_tireGetFrom) then {
								private _vehName = getText ((_object getVariable "brpvp_tire_nameCFG") >> "displayName") call BRPVP_escapeForStructuredTextFast;
								_object setVariable [_actionVar1,player addAction ["<t color='#FFA040'>"+format [localize "str_tire_get_vehicle",_vehName]+"</t>",{call BRPVP_tireClientGetVeh;},_object,1.6,true,true]];
								private _tim = (_object getVariable ["brpvp_tire_owner",-1]) isEqualTo (player getVariable "id_bd") || BRPVP_vePlayers;
								if (_tim) then {_object setVariable [_actionVar2,player addAction ["<t color='#FFA040'>"+format [localize "str_tire_move_tire",_vehName]+"</t>",{call BRPVP_tireClientMoveBarrier;},_object,1.599,true,true]];};
							} else {
								_object setVariable [_actionVar1,player addAction ["<t color='#FFA040'>"+localize "str_tire_put_vehicle"+"</t>",{call BRPVP_tireClientPutVeh;},_object,1.6,true,true]];
							};
						};
					} else {
						if !(_actionId1 isEqualTo -1) then {
							player removeAction _actionId1;
							_object setVariable [_actionVar1,-1,false];
						};
						if !(_actionId2 isEqualTo -1) then {
							player removeAction _actionId2;
							_object setVariable [_actionVar2,-1,false];
						};
					};
					//GET SPECIAL ITEMS ON BLUE GAS CANISTER
					_actionVar = "brpvp_act_39";
					_actionId = _object getVariable [_actionVar,-1];
					if (_objectTypeOf isEqualTo BRPVP_spcItemsClass) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF5050'>"+localize "str_get_special_items"+"</t>",{call BRPVP_spcItemsGet;},_object,2,true,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//ACCESS BILL BOARD SMART TV
					_stvCanAccess = _objectTypeOf isEqualTo "Land_Billboard_F" && (_isDb || {(_object getVariable ["id_bd",-1]) <= -10}) && _objectHaveAccess;
					_actionVar = "brpvp_act_41";
					_actionId = _object getVariable [_actionVar,-1];
					if (_stvCanAccess) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF5050'>"+localize "str_use_smart_tv"+"</t>",{call BRPVP_useSmartTv;},_object,2,true,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//ACCESS BILL BOARD SMART TV - SEND DEATH SIGNAL
					_actionVar = "brpvp_act_42";
					_actionId = _object getVariable [_actionVar,-1];
					if (_stvCanAccess) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF5050'>"+localize "str_seccam_death_signal"+"</t>",{call BRPVP_useSmartTvSendDeathSignal;},_object,1.99,true,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//BUILDING ELEVATORS
					_actionVar = "brpvp_act_43";
					_actionId = _object getVariable [_actionVar,-1];
					_useElevator = false;
					_floorOrTop = "floor";
					_elevatorPlaceIn = [];
					_elevatorIdx = -1;
					if (_objectTypeOf in BRPVP_elevatorBuildingsClass) then {
						_elevatorIdx = BRPVP_elevatorBuildingsClass find _objectTypeOf;
						{if (player distance (_object modelToWorld _x) < 1.5) exitWith {_elevatorPlaceIn = _object modelToWorld _x;};} forEach (BRPVP_elevatorBuildingsFloor select _elevatorIdx);
						if (_elevatorPlaceIn isEqualTo []) then {
							{if (player distance (_object modelToWorld _x) < 1.5) exitWith {_elevatorPlaceIn = _object modelToWorld _x;};} forEach (BRPVP_elevatorBuildingsTop select _elevatorIdx);
							if (_elevatorPlaceIn isNotEqualTo []) then {_floorOrTop = "top";_useElevator = true;};
						} else {
							_useElevator = true;
						};
					};
					if (_useElevator) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#5050FF'>"+localize "str_elevator_use"+"</t>",{call BRPVP_useBuildingElevator;},[_object,_elevatorPlaceIn,_floorOrTop,_elevatorIdx,_actionVar],2.5,true,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//CAR SABOTAGE
					_actionVar = "brpvp_act_44";
					_actionId = _object getVariable [_actionVar,-1];
					if ((_object isKindOf "LandVehicle" || _object isKindOf "Motorcycle") && !_inVeh) then {
						if (_actionId isEqualTo -1) then {
							_object setVariable [_actionVar,player addAction ["<t color='#FF5050'>"+format [localize "str_sabotage_vehicle",round (BRPVP_vehSabotagePrice/1000)]+"</t>",{call BRPVP_sabotageVehicle;},_object,1.99,false,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//PAINT VR BLOCK
					_actionVar = "brpvp_act_45";
					_actionId = _object getVariable [_actionVar,-1];
					if (_isDb && {_objectTypeOf in BRPVP_vrObjectsClasses && _objectHaveAccess}) then {
						if (_actionId isEqualTo -1) then {
							private _price = if ((time-(_object getVariable ["brpvp_last_vr_paint_time",-(BRPVP_vrObjectsPaintTasteTime*60*2)]))/60 <= BRPVP_vrObjectsPaintTasteTime) then {0} else {BRPVP_vrObjectsPaintPrice};
							_object setVariable [_actionVar,player addAction ["<t color='#8F8F8F'>"+localize "str_paint_vr_block"+" $ "+str (round (_price/1000))+"K</t>",{BRPVP_menuVar1 = _this#3#0;BRPVP_menuVar3 = _this#3#1;218 call BRPVP_iniciaMenuExtra;},[_object,_price],1.99,false,true]];
						};
					} else {
						if !(_actionId isEqualTo -1) then {
							player removeAction _actionId;
							_object setVariable [_actionVar,-1];
						};
					};
					//REMOVE ACTIONS FOR OBJECTS THAT CAN TURN NULL
					_idx = _objsActionsCheckNullA find _object;
					if (_idx isEqualTo -1) then {
						_objsActionsCheckNullA pushBack _object;
						_idx = count _objsActionsCheckNullA - 1;
					};
					_actions = [];
					{_actions pushBack (_object getVariable [_x,-1]);} forEach _allActionsVars;
					_objsActionsCheckNullB set [_idx,_actions];
				};
			} forEach _objs;

			//REMOVE ACTIONS ON LOST OBJECTS
			{
				_obj = _x;
				if (!isNull _obj) then {
					{
						_actionId = _obj getVariable [_x,-1];
						if (_actionId isNotEqualTo -1) then {
							player removeAction _actionId;
							_obj setVariable [_x,-1];
						};
					} forEach _allActionsVars;
					_idx = _objsActionsCheckNullA find _obj;
					_objsActionsCheckNullA deleteAt _idx;
					_objsActionsCheckNullB deleteAt _idx;
				};
			} forEach (_objsLast-_objs);

			//SET NEW ARRAY OF LAST OBJECTS
			_objsLast = _objs;
			
			//CUT CONNECTION
			if (9 in BRPVP_actionRunning) then {
				if (BRPVP_actionRadarCut < 0) then {
					BRPVP_actionRadarCut = player addAction ["<t color='#8040FF'>"+localize "str_adda_radar_cut"+"</t>",{BRPVP_connectionOn = false;},[]];
				};
			} else {
				if (BRPVP_actionRadarCut != -1) then {
					player removeAction BRPVP_actionRadarCut;
					BRPVP_actionRadarCut = -1;
				};
			};
		};

		_bin1 = !_bin1;
		if (_bin1) then {
			_bin2 = !_bin2;

			//RECORD CAMERA TYPE
			_cameraView = cameraView;
			if (_cameraView isNotEqualTo (player getVariable "cmv")) then {player setVariable ["cmv",_cameraView,true];};
		};
	};
	waitUntil {
		call BRPVP_clientMainLoop;
		false
	};
};

diag_log "[BRPVP FILE] clientLoop.sqf END REACHED";