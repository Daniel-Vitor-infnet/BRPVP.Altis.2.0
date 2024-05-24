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
diag_log "[SCRIPT] playerMenuSystem.sqf BEGIN";

BRPVP_useCustomItem = {
	_ii = _param;
	if (_ii call BRPVP_sitCountItem > 0 || (BRPVP_vePlayers && _ii != -1)) then {
		private _item = BRPVP_specialItems select _ii;
		BRPVP_menuExtraLigado = false;
		hintSilent "";
		if (BRPVP_menuVar1 isEqualTo localize "str_spec_itm_group_cons") then {
			if (BRPVP_raidServerIsRaidDay && BRPVP_raidWeekDaysDisableConstruction && !BRPVP_vePlayers) then {
				"erro" call BRPVP_playSound;
				[localize "str_cant_build_raid_day",-6] call BRPVP_hint;
			} else {
				[call compile _item,"",_ii,false] call BRPVP_construir;
			};
		};
		if (BRPVP_menuVar1 isEqualTo localize "str_spec_itm_group_thief" && !(_item in BRPVP_thiefToEquip)) then {
			if (_item isEqualTo "BRP_hackTool") then {
				[localize "str_hack_how",-8] call BRPVP_hint;
			} else {
				if (_item isEqualTo "BRP_identifier") then {
					[localize "str_identifier_how",-8] call BRPVP_hint;
				} else {
					if (_item isEqualTo "BRP_remoteControl") then {
						[localize "str_remote_control_how",-8] call BRPVP_hint;
					} else {
						if ({player distance (_x select 0) <= _x select 1} count BRPVP_travelingAidPlaces > 0 && false) then {
							"erro" call BRPVP_playSound;
							[localize "str_cant_hack_on_travel_aid",-6] call BRPVP_hint;
						} else {
							_isVehKey = _item isEqualTo "BRP_vehicleThief";
							_flagState = player call BRPVP_checkOnFlagState;
							_vehCan = _isVehKey && _flagState in [0,2];
							if (BRPVP_raidServerIsRaidDay || _vehCan) then {
								if (BRPVP_pveAllowBandit || {player getVariable ["brpvp_pvp_inside",0] > 0 || player getVariable ["brpvp_pve_inside",0] isEqualTo 0}) then {
									BRPVP_equipIllegalItemNumber = BRPVP_equipIllegalItemNumber+1;
									BRPVP_equipedIllegalItem = _item;
									BRPVP_equipedIllegalItemPatern = [selectRandom (BRPVP_specialItemsRemoveTime select _ii),0,objNull];
									[BRPVP_equipIllegalItemNumber,_ii,_item,BRPVP_specialItemsNames select _ii,BRPVP_imagePrefix+(BRPVP_specialItemsImages select _ii)] spawn BRPVP_equipIllegalItem;
								} else {
									[localize "str_bandit_not_allowed",-5,200,0,"erro"] call BRPVP_hint;
								};
							} else {
								"erro" call BRPVP_playSound;
								if (_isVehKey && _flagState isEqualTo 1) then {[localize "str_cant_raid_veh_nrd",-8] call BRPVP_hint;} else {[localize "str_not_raid_day",-6] call BRPVP_hint;};
							};
						};
					};
				};
			};
		};
		if (BRPVP_menuVar1 isEqualTo localize "str_spec_itm_group_food") then {
			if (_item isEqualTo "BRP_vodka") then {
				_vodkaTime = (BRPVP_vodkaTimeMark-time) max 0;
				BRPVP_vodkaTimeMark = time+((_vodkaTime+60-_vodkaTime^0.5) min 240);
				[_ii,1] call BRPVP_sitRemoveItem;
			} else {
				if (_item call (BRPVP_useCodeAll select (BRPVP_useClassAll find _item))) then {
					[_ii,1] call BRPVP_sitRemoveItem;
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				} else {
					"erro" call BRPVP_playSound;
				};
			};
		};
		if (BRPVP_menuVar1 isEqualTo localize "str_spec_itm_group_equip" || _item in BRPVP_thiefToEquip) then {
			_isBB = _item isEqualTo "BRPVP_baseBomb";
			if (_isBB && !BRPVP_raidServerIsRaidDay) then {
				"erro" call BRPVP_playSound;
				[localize "str_not_raid_day",-6] call BRPVP_hint;
			} else {
				_isBBOk = _isBB && (BRPVP_pveAllowBandit || {player getVariable ["brpvp_pve_inside",0] isEqualTo 0});
				if (!_isBB || _isBBOk) then {
					if (_item call (BRPVP_useCodeAll select (BRPVP_useClassAll find _item))) then {
						[_ii,1] call BRPVP_sitRemoveItem;
						BRPVP_menuExtraLigado = false;
						hintSilent "";
					} else {
						"erro" call BRPVP_playSound;
					};
				} else {
					[localize "str_bandit_not_allowed",-5,200,0,"erro"] call BRPVP_hint;
				};
			};
		};
	} else {
		"erro" call BRPVP_playSound;
	};
};

//FUNCOES DAS OPCOES DE MENU
BRPVP_getInsurancePrice = {
	_type = typeOf _this;
	_price = 0;
	{
		_group = _x select 0;
		_class = _x select 3;
		_totalPrice = _x select 5;
		if (_class isEqualTo _type && _group != "FEDIDEX") exitWith {_price = round (_totalPrice*BRPVP_insurancePerc);};
	} forEach BRPVP_tudoA3;
	_price
};
BRPVP_getVGPrice = {
	_price = 0;
	{if (_this call (_x select 0)) exitWith {_price = _x select 6;};} forEach BRPVP_virtualGarageLimit;
	_price
};
if (isNil "BRPVP_useStore") then {BRPVP_useStore = false;};
BRPVP_storeItems = [
	[
		1,
		"10 milhões no banco",
		{
			player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0])+10000000,true];
			"negocio" call BRPVP_playSound;
			call BRPVP_atualizaDebug;
		}
	],
	[
		2,
		"20 milhões no banco",
		{
			player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0])+20000000,true];
			"negocio" call BRPVP_playSound;
			call BRPVP_atualizaDebug;
		}
	],
	[
		3,
		"T-140K Angara Temporario",
		{
			_angara = createVehicle ["O_MBT_04_command_F",BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
			_angara setDir (getDir player+180);
			if ((ASLToAGL getPosASL player) select 2 > 0.5) then {
				_angara setPosASL ([getPosASL player,0.225 * sizeOf "O_MBT_04_command_F",getDir player] call BIS_fnc_relPos);
			} else {
				_angara setPos ([ASLToAGL getPosASL player,0.225 * sizeOf "O_MBT_04_command_F",getDir player] call BIS_fnc_relPos);
			};
			[_angara,["HandleDamage",{call BRPVP_playerServerVehHD;}]] remoteExecCall ["addEventHandler",0,true];
			_angara addMPEventHandler ["MPKilled",{_this call BRPVP_MPKilled;}];
		}
	],
	[
		4,
		"Caixa de Scout Cyrus 9.3",
		{
			_boxData = [[["srifle_DMR_05_hex_F","srifle_DMR_05_tan_f","Rangefinder","srifle_DMR_05_blk_F"],[1,1,2,1]],[["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10],["10Rnd_93x64_DMR_05_Mag",10]],[[],[]],[["optic_LRPS","muzzle_snds_93mmg","bipod_02_F_hex","optic_tws","U_O_T_Sniper_F","G_Balaclava_TI_blk_F","V_PlateCarrierSpec_rgr","U_O_GhillieSuit"],[3,3,3,1,1,2,2,1]]];
			_ang = getDir player;
			_box = "Box_T_NATO_WpsSpecial_F" createVehicle BRPVP_posicaoFora;
			_box setDir _ang;
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearBackPackCargoGlobal _box;
			clearItemCargoGlobal _box;
			_posPlayer = ASLToAGL getPosASL player;
			_box setPosASL AGLToASL [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,(_posPlayer select 2)+0.5];
			{_box addWeaponCargoGlobal [_x,_boxData select 0 select 1 select _forEachIndex];} forEach (_boxData select 0 select 0);
			{_box addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_boxData select 1);
			{_box addBackpackCargoGlobal [_x,_boxData select 2 select 1 select _forEachIndex];} forEach (_boxData select 2 select 0);
			{_box addItemCargoGlobal [_x,_boxData select 3 select 1 select _forEachIndex];} forEach (_boxData select 3 select 0);
			{
				_c = _x select 1;
				clearWeaponCargoGlobal _c;
				clearMagazineCargoGlobal _c;
				clearItemCargoGlobal _c;
				clearBackpackCargoGlobal _c;
			} forEach everyContainer _box;
			["Esta caixa some no restart do servidor! Coloque os itens em local seguro!",8] call BRPVP_hint;
		}
	],
	[
		5,
		"Caixa Nightstalker X5",
		{
			_boxData = [[[],[]],[],[[],[]],[["optic_LRPS","G_Balaclava_TI_blk_F","optic_Nightstalker"],[2,2,5]]];
			_ang = getDir player;
			_box = "Box_T_NATO_WpsSpecial_F" createVehicle BRPVP_posicaoFora;
			_box setDir _ang;
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearBackPackCargoGlobal _box;
			clearItemCargoGlobal _box;
			_posPlayer = ASLToAGL getPosASL player;
			_box setPosASL AGLToASL [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,(_posPlayer select 2)+0.5];
			{_box addWeaponCargoGlobal [_x,_boxData select 0 select 1 select _forEachIndex];} forEach (_boxData select 0 select 0);
			{_box addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_boxData select 1);
			{_box addBackpackCargoGlobal [_x,_boxData select 2 select 1 select _forEachIndex];} forEach (_boxData select 2 select 0);
			{_box addItemCargoGlobal [_x,_boxData select 3 select 1 select _forEachIndex];} forEach (_boxData select 3 select 0);
			{
				_c = _x select 1;
				clearWeaponCargoGlobal _c;
				clearMagazineCargoGlobal _c;
				clearItemCargoGlobal _c;
				clearBackpackCargoGlobal _c;
			} forEach everyContainer _box;
			["Esta caixa some no restart do servidor! Coloque os itens em local seguro!",8] call BRPVP_hint;
		}
	],
	[
		6,
		"Lançador Titan AA e AT",
		{
			_boxData = [[["launch_O_Titan_short_F","launch_O_Titan_F"],[2,2]],[["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1]],[[],[]],[[],[]]];
			_ang = getDir player;
			_box = "Box_T_NATO_WpsSpecial_F" createVehicle BRPVP_posicaoFora;
			_box setDir _ang;
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearBackPackCargoGlobal _box;
			clearItemCargoGlobal _box;
			_posPlayer = ASLToAGL getPosASL player;
			_box setPosASL AGLToASL [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,(_posPlayer select 2)+0.5];
			{_box addWeaponCargoGlobal [_x,_boxData select 0 select 1 select _forEachIndex];} forEach (_boxData select 0 select 0);
			{_box addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_boxData select 1);
			{_box addBackpackCargoGlobal [_x,_boxData select 2 select 1 select _forEachIndex];} forEach (_boxData select 2 select 0);
			{_box addItemCargoGlobal [_x,_boxData select 3 select 1 select _forEachIndex];} forEach (_boxData select 3 select 0);
			{
				_c = _x select 1;
				clearWeaponCargoGlobal _c;
				clearMagazineCargoGlobal _c;
				clearItemCargoGlobal _c;
				clearBackpackCargoGlobal _c;
			} forEach everyContainer _box;
			["Esta caixa some no restart do servidor! Coloque os itens em local seguro!",8] call BRPVP_hint;
		}
	],
	[
		7,
		"Mísseis Titan AA X8",
		{
			_boxData = [[[],[]],[["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AA",1],["Titan_AA",1]],[[],[]],[[],[]]];
			_ang = getDir player;
			_box = "Box_T_NATO_WpsSpecial_F" createVehicle BRPVP_posicaoFora;
			_box setDir _ang;
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearBackPackCargoGlobal _box;
			clearItemCargoGlobal _box;
			_posPlayer = ASLToAGL getPosASL player;
			_box setPosASL AGLToASL [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,(_posPlayer select 2)+0.5];
			{_box addWeaponCargoGlobal [_x,_boxData select 0 select 1 select _forEachIndex];} forEach (_boxData select 0 select 0);
			{_box addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_boxData select 1);
			{_box addBackpackCargoGlobal [_x,_boxData select 2 select 1 select _forEachIndex];} forEach (_boxData select 2 select 0);
			{_box addItemCargoGlobal [_x,_boxData select 3 select 1 select _forEachIndex];} forEach (_boxData select 3 select 0);
			{
				_c = _x select 1;
				clearWeaponCargoGlobal _c;
				clearMagazineCargoGlobal _c;
				clearItemCargoGlobal _c;
				clearBackpackCargoGlobal _c;
			} forEach everyContainer _box;
			["Esta caixa some no restart do servidor! Coloque os itens em local seguro!",8] call BRPVP_hint;
		}
	],
	[
		8,
		"Mísseis Titan AT X8",
		{
			_boxData = [[[],[]],[["Titan_AT",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1],["Titan_AT",1]],[[],[]],[[],[]]];
			_ang = getDir player;
			_box = "Box_T_NATO_WpsSpecial_F" createVehicle BRPVP_posicaoFora;
			_box setDir _ang;
			clearWeaponCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearBackPackCargoGlobal _box;
			clearItemCargoGlobal _box;
			_posPlayer = ASLToAGL getPosASL player;
			_box setPosASL AGLToASL [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,(_posPlayer select 2)+0.5];
			{_box addWeaponCargoGlobal [_x,_boxData select 0 select 1 select _forEachIndex];} forEach (_boxData select 0 select 0);
			{_box addMagazineAmmoCargo [_x select 0,1,_x select 1];} forEach (_boxData select 1);
			{_box addBackpackCargoGlobal [_x,_boxData select 2 select 1 select _forEachIndex];} forEach (_boxData select 2 select 0);
			{_box addItemCargoGlobal [_x,_boxData select 3 select 1 select _forEachIndex];} forEach (_boxData select 3 select 0);
			{
				_c = _x select 1;
				clearWeaponCargoGlobal _c;
				clearMagazineCargoGlobal _c;
				clearItemCargoGlobal _c;
				clearBackpackCargoGlobal _c;
			} forEach everyContainer _box;
			["Esta caixa some no restart do servidor! Coloque os itens em local seguro!",8] call BRPVP_hint;
		}
	]
];
BRPVP_vehicleSellCtrl = 89867;
BRPVP_menuControl1 = 89868;
BRPVP_menuControl2 = 89869;
BRPVP_menuControl3 = 89870;
BRPVP_adminMsgAction = ["off",0];
BRPVP_menuSleep = 0;
BRPVP_menuIdc = -1;
BRPVP_menuIdcSafe = -1;
BRPVP_menuCustomKeysOff = false;
BRPVP_mySquadShares = [];
BRPVP_squadInviteCases = [];
BRPVP_ammoRepackRunning = false;
BRPVP_getVirtualGarageType = {
	private _return = -1;
	if (_this isEqualType "") then {
		{if (_this call (_x select 1)) exitWith {_return = _forEachIndex;};} forEach BRPVP_virtualGarageLimit;
	} else {
		{if (_this call (_x select 0)) exitWith {_return = _forEachIndex;};} forEach BRPVP_virtualGarageLimit;
	};
	_return
};
BRPVP_getLastAfterSlash = {
	private ["_slashIdx"];
	_txt = _this;
	while {_slashIdx = _txt find "\";_slashIdx > -1} do {
		_txt = _txt select [_slashIdx + 1,count _txt - (_slashIdx + 1)];
	};
	_txt
};
BRPVP_equipIllegalItemNumber = 0;
BRPVP_equipIllegalItem = {
	params ["_token","_idx","_class","_name","_image"];
	_init = diag_tickTime;
	"hint2" call BRPVP_playSound;
	_count = 0;
	["<img shadow='0' size='1.1' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\lock_pick_button_no.paa'/> <img shadow='0' size='1.1' image='"+_image+"'/><br/><t shadow='0' size='0.6' color='#FFE300'>"+str (BRPVP_equipedIllegalItemPatern select 0)+" X "+str (10 - _count)+" - "+_name+"</t>",{0},{safezoneY+safezoneH/2.15},1,0,0,9757] call BRPVP_fnc_dynamicText;
	waitUntil {
		_tm = diag_tickTime;
		if (_tm-_init >= BRPVP_hackCycleTime) then {
			_init = _tm;
			_count = (BRPVP_equipedIllegalItemPatern select 1)+1;
			BRPVP_equipedIllegalItemPatern set [1,_count];
			if (_count isEqualTo 8) then {[player,["lock_pick_alarm",100,1/BRPVP_hackCycleTime]] remoteExecCall ["say3D",BRPVP_allNoServer];};
			if (_count >= 8) then {
				["<img shadow='0' size='1.1' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\lock_pick_button.paa'/> <img shadow='0' size='1.1' image='"+_image+"'/><br/><t shadow='0' size='0.6' color='#40FF40'>"+str (BRPVP_equipedIllegalItemPatern select 0)+" X "+str (10 - _count)+" - "+_name+"</t>",{0},{safezoneY+safezoneH/2.15},1,0,0,9757] call BRPVP_fnc_dynamicText;
			} else {
				["<img shadow='0' size='1.1' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\lock_pick_button_no.paa'/> <img shadow='0' size='1.1' image='"+_image+"'/><br/><t shadow='0' size='0.6' color='#FFE300'>"+str (BRPVP_equipedIllegalItemPatern select 0)+" X "+str (10 - _count)+" - "+_name+"</t>",{0},{safezoneY+safezoneH/2.15},1,0,0,9757] call BRPVP_fnc_dynamicText;
			};
		};
		_token != BRPVP_equipIllegalItemNumber || _count isEqualTo 10 || BRPVP_equipedIllegalItem isEqualTo ""
	};
	["",0,0,0,0,0,9757] call BRPVP_fnc_dynamicText;
	if (_token isEqualTo BRPVP_equipIllegalItemNumber) then {BRPVP_equipedIllegalItem = "";};
};
BRPVP_unitSquadState = {
	if ((count units group _this) isEqualTo 1) then {
		"alone"
	} else {
		if ((leader group _this) isEqualTo _this) then {"leader"} else {"group"};
	};
};
BRPVP_menu29SpawnZombies = {
	_spawnTemplate = _this;
	_spawnBuildings = call BRPVP_spawnZombieCalcHouses;
	_dist = 60+random 40;
	_posSpawn = [player,_dist,random 360] call BIS_fnc_relPos;
	"zombie_spawn" call BRPVP_playSound;
	_needDustCloud = count _spawnBuildings < _spawnTemplate select 0;
	if (_needDustCloud) then {
		_ps1 = "#particlesource" createVehicle _posSpawn;
		_ps1 setParticleClass "HouseDestrSmokeLongSmall";
		_ps2 = "#particlesource" createVehicle _posSpawn;
		_ps2 setParticleClass "HouseDestrSmokeLongSmall";
		[4,[_ps1,_ps2]] remoteExecCall ["BRPVP_deleteAfterTime",2];
	};
	[_posSpawn,_spawnTemplate,_spawnBuildings,player] remoteExecCall ["BRPVP_spawnZombiesServerFromClient",2];
};
BRPVP_squadInvite = {
	params ["_inviter","_inviterId","_nameInviter"];
	private _nameP = player getVariable "nm";
	if (count units group player isEqualTo 1) then {
		private _idx = -1;
		{if (_x select 1 isEqualTo _inviterId) exitWith {_idx = _forEachIndex;};} forEach BRPVP_squadInviteCases;
		if (_idx isEqualTo -1) then {BRPVP_squadInviteCases pushBack [time,_inviterId];} else {(BRPVP_squadInviteCases select _idx) set [0,time];};
		[format [localize "str_squad_msg_invite",_nameInviter],-6] call BRPVP_hint;
		[["str_squad_msg_invite_send",[_nameP]],-6] remoteExecCall ["BRPVP_hint",_inviter];
	} else {
		[["str_squad_msg_invite_cant",[_nameP]],-6] remoteExecCall ["BRPVP_hint",_inviter];
	};
};
BRPVP_updateFlagProtection = {remoteExecCall ["BRPVP_findMyFlags",_this];};
BRPVP_attachMeToAPlayer = {
	if (isNull _this) then {
		if (!isNull attachedTo player) then {detach player;};
	} else {
		player attachTo [_this,[0,0,17.5]];
	};
};
BRPVP_auraLightSpec = {
	if (isNull BRPVP_auraLightObjSpec) then {
		private _light = "#lightpoint" createVehicleLocal [0,0,0];
		_light setLightColor [1,1,1];
		_light setLightAmbient [1,1,1];
		_light setLightUseFlare false;
		_light setLightIntensity 20;
		_light setLightDayLight true;
		BRPVP_auraLightObjSpec = _light;
		private _lightLimit = 8000;
		private _lastVeh = [objectParent BRPVP_spectedPlayer,BRPVP_mySpecUAVNow] select isNull objectParent BRPVP_spectedPlayer;
		private _lastVD = viewDistance min _lightLimit;
		if (isNull _lastVeh) then {_light attachTo [BRPVP_spectedPlayer,[0,0,5]];} else {_light attachTo [_lastVeh,[0,0,20]];};
		_light setLightAttenuation [_lastVD,0,0.01,0];
		_lastVeh = str _lastVeh;
		[_light,_lightLimit,_lastVD,_lastVeh] spawn {
			params ["_light","_lightLimit","_lastVD","_lastVeh"];
			waitUntil {
				private _veh = [objectParent BRPVP_spectedPlayer,BRPVP_mySpecUAVNow] select isNull objectParent BRPVP_spectedPlayer;
				if (str _veh isNotEqualTo _lastVeh) then {
					detach _light;
					if (isNull _veh) then {_light attachTo [BRPVP_spectedPlayer,[0,0,5]];} else {_light attachTo [_veh,[0,0,20]];};
					_lastVeh = str _veh;
				};
				private _nVD = viewDistance min _lightLimit;
				if (_nVD isNotEqualTo _lastVD) then {
					_light setLightAttenuation [_nVD,0,0.01,0];
					_lastVD = _nVD;
				};
				isNull BRPVP_auraLightObjSpec
			};
		};
	};
};
BRPVP_spectateFnc = {
	if (!isNull _this && player call BRPVP_pAlive && !BRPVP_xrayOn) then {
		BRPVP_allowBrpvpHint = false;
		BRPVP_menuExtraLigado = false;
		hintSilent "";
		BRPVP_spectateOn = true;
		BRPVP_spectedPlayer = _this;
		call BRPVP_atualizaDebug;
		BRPVP_forceObjectsUpdate = true;
		BRPVP_viewDistBkp = BRPVP_viewDist;
		BRPVP_viewDistFlyBkp = BRPVP_viewDistFly;
		BRPVP_meuAllDeadSpec = [];
		{
			_x params ["_bb","_camReal","_camKey"];
			if !(isNull _bb || isNull _camReal) then {_camReal cameraEffect ["Terminate","Back",_camKey];};
		} forEach BRPVP_secCamBbsMy;
		_this spawn {
			private _spectLeft = false;
			private _sName = _this getVariable ["nm","Bob Larrouse"];
			private _friend = _this;
			private _fPos = getPosASL _friend;
			private _originalEffect = cameraView;
			private _thisId = _friend getVariable "id_bd";
			private _access = true;
			[[clientOwner,player getVariable "id_bd"],"add"] remoteExecCall ["BRPVP_changeSpectOnMe",_friend];
			waitUntil {
				"granted" call BRPVP_playSound;
				player setVariable ["brpvp_specting",_friend,2];
				if (!BRPVP_trataseDeAdmin) then {29483 cutText [format ["<t size='1.5'>%1</t>",localize "str_spec_to_leave"],"PLAIN",1,true,true];};
				private _pAlive = false;
				private _lcmv = "";
				private _cObj = objNull;
				private _initN = diag_tickTime;
				private _loBug = false;
				_access = _friend call BRPVP_checaAcesso || BRPVP_trataseDeAdmin;
				call BRPVP_auraLightSpec;
				waitUntil {
					if (diag_tickTime-_initN > 45) then {
						[format ["<t>"+localize "str_you_are_specting"+"</t>",_sName],0,0.25,2.5,0,0,1028] spawn BIS_fnc_dynamicText;
						_initN = diag_tickTime;
					};
					private _busAgnt = player getVariable ["brpvp_bus_agnt",objNull];
					private _UAVNow = _friend call BRPVP_controlingUAVGetFakeUnitUsing;
					private _cObjNow = if (isNull _busAgnt) then {[_UAVNow,vehicle _friend] select isNull _UAVNow} else {_busAgnt};
					private _cmv = if (isNull _busAgnt) then {_friend getVariable ["cmv","INTERNAL"]} else {"EXTERNAL"};
					if (_cObjNow isNotEqualTo _cObj || _cmv isNotEqualTo _lcmv) then {
						_cObjNow switchCamera _cmv;
						_cObj = _cObjNow;
						_lcmv = _cmv;
					};
					if (!isNull _friend) then {
						_fPos = getPosASL _friend;
						_access = _friend call BRPVP_checaAcesso || BRPVP_trataseDeAdmin
					};
					_pAlive = player call BRPVP_pAlive;
					_loBug = _friend getVariable ["brpvp_logged_off",false];
					_friend action ["NVGogglesOff",_friend];
					!BRPVP_spectateOn ||  !_pAlive || !_access || isNull _friend || _loBug
				};
				deleteVehicle BRPVP_auraLightObjSpec;
				private _stop = true;
				if (BRPVP_spectateOn && player call BRPVP_pAlive && _access && isNull _friend && !_loBug) then {
					private _init = time;
					waitUntil {
						_friend = ((call BRPVP_playersList select {_x getVariable ["id_bd",-1] isEqualTo _thisId})+[objNull]) select 0;
						(!isNull _friend && !(_friend getVariable ["brpvp_logged_off",false])) || time-_init > 1.25 || _friend getVariable ["brpvp_logged_off",false]
					};
					if (isNull _friend || _friend getVariable ["brpvp_logged_off",false]) then {
						_spectLeft = true;
						[localize "str_spec_left",5,10,299] call BRPVP_hint;
					} else {
						BRPVP_spectedPlayer = _friend;
						cutText ["<t size='2.5'>...</t>","BLACK FADED",0.25,true,true];
						"logo_01" call BRPVP_playSound;
						waitUntil {
							private _ok = visibleMap && !isNull _friend && !(_friend getVariable ["brpvp_logged_off",false]);
							private _notOk = isNull _friend || _friend getVariable ["brpvp_logged_off",false];
							_ok || _notOk
						};
						cutText ["","BLACK IN",1];
						if (isNull _friend || _friend getVariable ["brpvp_logged_off",false]) then {
							[localize "str_spec_left",5,10,299] call BRPVP_hint;
							_spectLeft = true;
						} else {
							_stop = false;
						};
					};
				};
				_stop
			};

			//STOP
			if (!_access) then {[localize "str_spec_exposition_end",6,10,299] call BRPVP_hint;};
			
			if (isNull _friend) then {
				private _spctd = call BRPVP_playersList select {_x getVariable ["id_bd",-1] isEqualTo _thisId};
				if (_spctd isNotEqualTo []) then {
					BRPVP_specIRemovedYou = false;
					[[clientOwner,player getVariable "id_bd"],"remove"] remoteExecCall ["BRPVP_changeSpectOnMe",_spctd];
					private _init = diag_tickTime;
					waitUntil {BRPVP_specIRemovedYou || diag_tickTime-_init > 2.5};
				};
			} else {
				BRPVP_specIRemovedYou = false;
				[[clientOwner,player getVariable "id_bd"],"remove"] remoteExecCall ["BRPVP_changeSpectOnMe",_friend];
				private _init = diag_tickTime;
				waitUntil {BRPVP_specIRemovedYou || diag_tickTime-_init > 2.5};
			};			
			
			BRPVP_spectateOn = false;
			BRPVP_spectedPlayer = objNull;
			player setVariable ["brpvp_specting",objNull,2];
			player switchCamera _originalEffect;
			call BRPVP_setSpectedDinaMsgsBack;
			BRPVP_allowBrpvpHint = true;
			BRPVP_specMenuShowTxt = "";
			BRPVP_specMapAnimeLast = [];
			hintSilent "";
			openMap [false,false];

			//RECALC FAKE BUSH
			private _specBush = _friend getVariable ["brpvp_server_bush",objNull];
			if (!isNull _specBush) then {_specBush hideObject false;};
			if (isNull BRPVP_personalBush) then {0 cutRsc ["missionintel2","PLAIN"];} else {BRPVP_personalBushFakeOn = !BRPVP_personalBushFakeOn;};

			//SET SMART TVS TO ORIGINAL SYNCRONIZATION
			{
				_x params ["_bb","_camReal","_camKey"];
				if (!isNull _camReal) then {
					_camReal cameraEffect ["Terminate","Back",_camKey];
					camDestroy _camReal;
				};
			} forEach BRPVP_secCamBbsMySpec;
			BRPVP_secCamBbsMySpec = [];
			{
				_x params ["_bb","_camReal","_camKey"];
				_camReal cameraEffect ["Internal","Back",_camKey];
				_camKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
			} forEach BRPVP_secCamBbsMy;

			//VIEW DISTANCE
			BRPVP_viewDist = BRPVP_viewDistBkp;
			BRPVP_viewDistFly = BRPVP_viewDistFlyBkp;
			BRPVP_viewDistState = 0;

			//ARTY TARGET
			BRPVP_specArtyTargetPos = [];

			BRPVP_specXrayOn = false;
			
			//NEAR PLAYERS ICONS
			BRPVP_nearIdentifiedPlayers = [];
			BRPVP_newersDiscovered = [];

			//RESET SIXTH SENSE SPEC VARS
			BRPVP_sixthSenseRangeSpec = 200;
			BRPVP_sixthSenseSeePlayerSpec = false;
			BRPVP_sixthSensePowerPlayerSpec = 0.025;
			BRPVP_sixthSensePowerSpec = 0.04;
			BRPVP_sixthSenseOnSpec = false;

			//RESET RED TURRETS ON SPECTED
			BRPVP_allTurretsOnMeRedSpec = [];
			BRPVP_allTurretsOnMeRedSeeSpec = [];

			//DELETE SPECTATOR BIG FRANTA ALERTS
			{deleteVehicle (_x getVariable "brpvp_fbo");} forEach BRPVP_bigFrantaSpectatorObjs;

			//DELETE SPECT XP PANEL
			1 call BRPVP_xpSeeInfoCloseSpec;

			//SPECT A RANDOM PLAYER IF ACTUAL LEFT SERVER
			if (_spectLeft) then {
				_fPos spawn {
					uiSleep 0.25;
					private _fPosAGL = ASLToAGL _this;
					private _options = [];
					{
						private _access = _x call BRPVP_checaAcesso || BRPVP_trataseDeAdmin;
						private _sok = _x getVariable ["sok",false];
						if (!isNull _x && _sok && _access && player call BRPVP_pAlive && !BRPVP_xrayOn) then {
							_options pushBack [_x distanceSqr _fPosAGL,_x];
						};
					} forEach (call BRPVP_playersList-[player]);
					_options sort false;
					if (_options isNotEqualTo []) then {(_options select 0 select 1) call BRPVP_spectateFnc;};
				};
			};
		};
	} else {
		"erro" call BRPVP_playSound;
		BRPVP_menuExtraLigado = false;
		hintSilent "";
		call BRPVP_atualizaDebug;
	};
};
BRPVP_actualExposition = {
	_stp = _this getVariable ["stp",-1];
	_return = "erro";
	if (_stp isEqualTo 1) then {
		_return = localize "str_expo_wit";
	} else {
		if (_stp isEqualTo 2) then {
			_return = localize "str_expo_witr";
		} else {
			if (_stp isEqualTo 3) then {
				_return = localize "str_expo_everyone";
			} else {
				if (_stp isEqualTo 4) then {
					_return = localize "str_expo_om";
				};
			};
		};
	};
	_return
};
BRPVP_deixarDeConfiar = {
	params ["_id_bd","_name"];
	_meusAmigosId = player getVariable ["amg",[]];
	_meusAmigosId = _meusAmigosId-[_id_bd];
	[player getVariable "id_bd",_meusAmigosId] remoteExecCall ["BRPVP_amigosAtualizaServidor",2];
	[format [localize "str_trust_you_revoke",_name],5,15] call BRPVP_hint;
	_playerAvisar = objNull;
	{if ((_x getVariable ["id_bd",-1]) isEqualTo _id_bd) exitWith {_playerAvisar = _x;};} forEach call BRPVP_playersList;
	player setVariable ["amg",_meusAmigosId,true];
	
	//UPDATE FANTA MINES
	private _idBd = player getVariable "id_bd";
	private _fantaAmg = _meusAmigosId+[_idBd];
	{
		private _isMine = (_x getVariable ["brpvp_mine_base_owner",-1]) isEqualTo _idBd;
		if (_isMine) then {_x setVariable ["brpvp_mine_base_friends",_fantaAmg,true];};
	} forEach entities [["Land_Can_V2_F"],[]];
	[_idBd,_fantaAmg] remoteExecCall ["BRPVP_updateFantaDb",2];

	//UPDATE SECURITY CAMS
	private _updatedSecCams = [];
	{
		private _isMyCam = (_x getVariable ["brpvp_cam_own",-1]) isEqualTo _idBd;
		if (_isMyCam) then {
			_x setVariable ["brpvp_cam_amg",_meusAmigosId,true];
			_updatedSecCams pushBack _x;
		};
	} forEach BRPVP_secCamAll;
	[_idBd,_meusAmigosId] remoteExecCall ["BRPVP_updateSecCamDb",2];
	private _affected = (call BRPVP_playersList) select {(_x getVariable ["id_bd",-1]) isEqualTo _id_bd};
	if (_affected isNotEqualTo []) then {_updatedSecCams remoteExec ["BRPVP_checkIfSecCamAmgChangeAffect",_affected select 0];};

	[_playerAvisar,player,false,_meusAmigosId] remoteExecCall ["BRPVP_mudouConfiancaEmVoceSV",2];
	call BRPVP_daUpdateNosAmigos;
	call BRPVP_atualizaMeuStuffAmg;
	BRPVP_tempoUltimaAtuAmigos = time;
	0 call BRPVP_menuMuda;
};
BRPVP_confiarEmAlguem = {
	params ["_id_bd","_name","_unit"];
	_meusAmigosId = player getVariable ["amg",[]];
	_meusAmigosId pushBackUnique _id_bd;
	private _bpf = player getVariable ["brpvp_past_friends",[]];
	if (_bpf find _id_bd isEqualTo -1) then {
		_bpf pushBackUnique _id_bd;
		player setVariable ["brpvp_past_friends",_bpf,true];
	};
	[player getVariable "id_bd",_meusAmigosId] remoteExecCall ["BRPVP_amigosAtualizaServidor",2];
	[format [localize "str_trust_you_trust",_name],3.5,15] call BRPVP_hint;
	player setVariable ["amg",_meusAmigosId,true];

	//UPDATE FANTA MINES
	private _idBd = player getVariable "id_bd";
	private _fantaAmg = _meusAmigosId+[_idBd];
	{
		private _isMine = (_x getVariable ["brpvp_mine_base_owner",-1]) isEqualTo _idBd;
		if (_isMine) then {_x setVariable ["brpvp_mine_base_friends",_fantaAmg,true];};
	} forEach entities [["Land_Can_V2_F"],[]];
	[_idBd,_fantaAmg] remoteExecCall ["BRPVP_updateFantaDb",2];

	//UPDATE SECURITY CAMS
	{
		private _isMyCam = (_x getVariable ["brpvp_cam_own",-1]) isEqualTo _idBd;
		if (_isMyCam) then {_x setVariable ["brpvp_cam_amg",_meusAmigosId,true];};
	} forEach BRPVP_secCamAll;
	[_idBd,_meusAmigosId] remoteExecCall ["BRPVP_updateSecCamDb",2];

	[_unit,player,true,_meusAmigosId] remoteExecCall ["BRPVP_mudouConfiancaEmVoceSV",2];
	call BRPVP_daUpdateNosAmigos;
	call BRPVP_atualizaMeuStuffAmg;
	BRPVP_tempoUltimaAtuAmigos = time;
	0 call BRPVP_menuMuda;
};
BRPVP_deixarDeConfiarCustom = {
	_amg = BRPVP_stuff getVariable ["amg",[[],[],true]];
	_tempCst = (BRPVP_stuff getVariable ["stp",-1]) in [1,2];
	_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
	_amg set [1,(_amg select 1)-[_this]];
	if (netId BRPVP_stuff isEqualTo "0:0") then {
		if (typeOf BRPVP_stuff in BRPVP_buildingHaveDoorListCVL) then {
			[[typeOf BRPVP_stuff],[[BRPVP_stuff getVariable ["id_bd",-1]]],_this] remoteExecCall ["BRPVP_deixarDeConfiarCustomCCSimpleObjectCVL",0];
		} else {
			[[typeOf BRPVP_stuff],[[BRPVP_stuff getVariable ["id_bd",-1]]],_this] remoteExecCall ["BRPVP_deixarDeConfiarCustomCCSimpleObject",0];
		};
	} else {
		BRPVP_stuff setVariable ["amg",_amg,true];
		if !(BRPVP_stuff getVariable ["slv_amg",false]) then {BRPVP_stuff setVariable ["slv_amg",true,true];};
		if (typeOf BRPVP_stuff in BRP_kitAutoTurret) then {BRPVP_stuff setVariable ["brpvp_tupdated",true,2];};
	};
	_this spawn {
		sleep 2;
		{if (_x getVariable ["id_bd",-2] isEqualTo _this) exitWith {_x call BRPVP_updateFlagProtection;};} forEach call BRPVP_playersList;
	};
	58 call BRPVP_menuMuda;
};
BRPVP_confiarEmAlguemCustom = {
	_amg = BRPVP_stuff getVariable ["amg",[[],[],true]];
	_tempCst = (BRPVP_stuff getVariable ["stp",-1]) in [1,2];
	_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
	(_amg select 1) pushBackUnique _this;
	if (netId BRPVP_stuff isEqualTo "0:0") then {
		if (typeOf BRPVP_stuff in BRPVP_buildingHaveDoorListCVL) then {
			[[typeOf BRPVP_stuff],[[BRPVP_stuff getVariable ["id_bd",-1]]],_this] remoteExecCall ["BRPVP_confiarEmAlguemCustomCCSimpleObjectCVL",0];
		} else {
			[[typeOf BRPVP_stuff],[[BRPVP_stuff getVariable ["id_bd",-1]]],_this] remoteExecCall ["BRPVP_confiarEmAlguemCustomCCSimpleObject",0];
		};
	} else {
		BRPVP_stuff setVariable ["amg",_amg,true];
		if !(BRPVP_stuff getVariable ["slv_amg",false]) then {BRPVP_stuff setVariable ["slv_amg",true,true];};
		if (typeOf BRPVP_stuff in BRP_kitAutoTurret) then {BRPVP_stuff setVariable ["brpvp_tupdated",true,2];};
	};	
	_this spawn {
		sleep 2;
		{if (_x getVariable ["id_bd",-2] isEqualTo _this) exitWith {_x call BRPVP_updateFlagProtection;};} forEach call BRPVP_playersList;
	};
	58 call BRPVP_menuMuda;
};
BRPVP_deixarDeConfiarCustomCC = {
	private _count = 0;
	private _objsSoClass = [];
	private _objsSoIds = [];
	private _objsSoClassCVL = [];
	private _objsSoIdsCVL = [];
	{
		if (_x call BRPVP_menuVar2 && _x getVariable ["own",-1] isEqualTo BRPVP_menuVar4) then {
			_amg = _x getVariable ["amg",[[],[],true]];
			_tempCst = (_x getVariable ["stp",-1]) in [1,2];
			_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
			_amgNew = +_amg;
			_amgNew set [1,(_amg select 1)-[_this]];
			if (_amgNew isNotEqualTo _amg) then {
				if (netId _x isEqualTo "0:0") then {
					if (typeOf _x in BRPVP_buildingHaveDoorListCVL) then {
						private _class = typeOf _x;
						private _id = _x getVariable ["id_bd",-1];
						private _idx = _objsSoClassCVL find _class;
						if (_idx isEqualTo -1) then {
							_objsSoClassCVL pushBack _class;
							_objsSoIdsCVL pushBack [_id];
						} else {
							(_objsSoIdsCVL select _idx) pushBack _id;
						};
					} else {
						private _class = typeOf _x;
						private _id = _x getVariable ["id_bd",-1];
						private _idx = _objsSoClass find _class;
						if (_idx isEqualTo -1) then {
							_objsSoClass pushBack _class;
							_objsSoIds pushBack [_id];
						} else {
							(_objsSoIds select _idx) pushBack _id;
						};
					};
				} else {
					_x setVariable ["amg",_amgNew,true];
					if !(_x getVariable ["slv_amg",false] || _x getVariable ["slv",false]) then {_x setVariable ["slv_amg",true,true];};
					if (typeOf _x in BRP_kitAutoTurret) then {_x setVariable ["brpvp_tupdated",true,2];};
				};
			};
			_count = _count+1;
		};
	} forEach nearestObjects [BRPVP_stuff,BRPVP_menuVar1,BRPVP_stuff getVariable ["brpvp_flag_radius",0],true];
	[_objsSoClass,_objsSoIds,_this] remoteExecCall ["BRPVP_deixarDeConfiarCustomCCSimpleObject",0];
	[_objsSoClassCVL,_objsSoIdsCVL,_this] remoteExecCall ["BRPVP_deixarDeConfiarCustomCCSimpleObjectCVL",0];
	[format [localize "str_cc_n_objs_changes",_count],-4] call BRPVP_hint;
	_this spawn {
		sleep 2;
		{if (_x getVariable ["id_bd",-2] isEqualTo _this) exitWith {_x call BRPVP_updateFlagProtection;};} forEach call BRPVP_playersList;
	};
	100 call BRPVP_menuMuda;
};
BRPVP_confiarEmAlguemCustomCC = {
	private _count = 0;
	private _objsSoClass = [];
	private _objsSoIds = [];
	private _objsSoClassCVL = [];
	private _objsSoIdsCVL = [];
	{
		if (_x call BRPVP_menuVar2 && _x getVariable ["own",-1] isEqualTo BRPVP_menuVar4) then {
			_amg = _x getVariable ["amg",[[],[],true]];
			_tempCst = (_x getVariable ["stp",-1]) in [1,2];
			_amg = if (count _amg isEqualTo 0 || {_amg select 0 isEqualType 0}) then {[_amg,[],_tempCst]} else {if (count _amg isEqualTo 1) then {_amg+[[],_tempCst]} else {if (count _amg isEqualTo 2) then {_amg+[_tempCst]} else {_amg};};};
			_amgNew = +_amg;
			(_amgNew select 1) pushBackUnique _this;
			if (_amgNew isNotEqualTo _amg) then {
				if (netId _x isEqualTo "0:0") then {
					if (typeOf _x in BRPVP_buildingHaveDoorListCVL) then {
						private _class = typeOf _x;
						private _id = _x getVariable ["id_bd",-1];
						private _idx = _objsSoClassCVL find _class;
						if (_idx isEqualTo -1) then {
							_objsSoClassCVL pushBack _class;
							_objsSoIdsCVL pushBack [_id];
						} else {
							(_objsSoIdsCVL select _idx) pushBack _id;
						};
					} else {
						private _class = typeOf _x;
						private _id = _x getVariable ["id_bd",-1];
						private _idx = _objsSoClass find _class;
						if (_idx isEqualTo -1) then {
							_objsSoClass pushBack _class;
							_objsSoIds pushBack [_id];
						} else {
							(_objsSoIds select _idx) pushBack _id;
						};
					};
				} else {
					_x setVariable ["amg",_amgNew,true];
					if !(_x getVariable ["slv_amg",false] || _x getVariable ["slv",false]) then {_x setVariable ["slv_amg",true,true];};
					if (typeOf _x in BRP_kitAutoTurret) then {_x setVariable ["brpvp_tupdated",true,2];};
				};
			};
			_count = _count+1;
		};
	} forEach nearestObjects [BRPVP_stuff,BRPVP_menuVar1,BRPVP_stuff getVariable ["brpvp_flag_radius",0],true];
	[_objsSoClass,_objsSoIds,_this] remoteExecCall ["BRPVP_confiarEmAlguemCustomCCSimpleObject",0];
	[_objsSoClassCVL,_objsSoIdsCVL,_this] remoteExecCall ["BRPVP_confiarEmAlguemCustomCCSimpleObjectCVL",0];
	[format [localize "str_cc_n_objs_changes",_count],-4] call BRPVP_hint;
	_this spawn {
		sleep 2;
		{if (_x getVariable ["id_bd",-2] isEqualTo _this) exitWith {_x call BRPVP_updateFlagProtection;};} forEach call BRPVP_playersList;
	};
	100 call BRPVP_menuMuda;
};

// FUNCOES DO SISTEMA DE MENU
BRPVP_criaImagemTag = {
	_typeOf = typeOf _this;
	if (isText (configFile >> "CfgVehicles" >> _typeOf >> "picture") && _this call BRPVP_IsMotorized) then {
		(" image='" + getText (configFile >> "CfgVehicles" >> _typeOf >> "picture") + "'")
	} else {
		" image='BRP_marcas\muro.paa'"
	};
};
BRPVP_arrayParaListaHtml = {
	params ["_arr","_sel","_cor"];
	private ["_ajF","_ajI"];
	_itensAcAb = BRPVP_cfgMenuLines;
	_idcFinal = (count _arr)-1;
	_ini = 0;
	_fim = _idcFinal;
	_notFit = count _arr > _itensAcAb*2+1;
	if (_notFit) then {
		_ajF = if (_sel < _itensAcAb) then {_itensAcAb-_sel} else {0};
		_ajI = if (_sel + _itensAcAb > _idcFinal) then {(_sel+_itensAcAb)-_idcFinal} else {0};
		_ini = ((_sel - _itensAcAb) max 0)-_ajI;
		_fim = ((_sel + _itensAcAb) min _idcFinal)+_ajF;
	};
	_txt = if (_notFit && _ini != 0) then {"<t><img size='0.85' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\arrow_up.paa'/></t><br/>"} else {"<t><img size='0.85' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\arrow_nil.paa'/></t><br/>"};
	for "_u" from _ini to _fim do {
		_preFix = "<t size='1.15'>";
		_suFix = "</t><br/>";
		if (_u isEqualTo _sel) then {_preFix = "<t size='1.15' color='"+_cor+"'>";};
		_txt = _txt+_preFix+(((_arr select _u) call BRPVP_escapeForStructuredText) call BRPVP_formatMenuConvert)+_suFix;
	};
	_txt = _txt+(if (_notFit && _fim != _idcFinal) then {"<t><img size='0.85' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\arrow_down.paa'/></t><br/>"} else {"<t><img size='0.85' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\arrow_nil.paa'/></t><br/>"});
	_txt
};
BRPVP_pegaListaPlayersNear = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		_id_bd = _x getVariable ["id_bd",-1];
		BRPVP_menuOpcoes pushBack (str _id_bd+" - "+name _x);
		BRPVP_menuExecutaParam pushBack _x;
	} forEach (_this call BRPVP_pegaListaPlayersNearObjs);
};
BRPVP_pegaListaPlayersNearObjs = {
	private _objs = [];
	private _crew = crew objectParent player;
	{
		_id_bd = _x getVariable ["id_bd",-1];
		if (_x call BRPVP_pAlive && _x getVariable ["sok",false] && _id_bd > -1) then {
			if (_x distance player <= _this || _x in _crew) then {_objs pushBack _x;};
		};
	} forEach (call BRPVP_playersList-[player]);
	_objs
};
BRPVP_getSquadInviteOptions = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	private _delete = [];
	private _xParams1 = ["_tm","_id_bd"];
	{
		_x params _xParams1;
		if (time-_tm < BRPVP_squadInviteExpirationTime) then {
			private _inviter = _id_bd call BRPVP_getPlayerById;
			if (isNull _inviter) then {
				_delete pushBack _forEachIndex;
			} else {
				BRPVP_menuOpcoes pushBack format ["%1 - %2",_id_bd,_inviter getVariable "nm"];
				BRPVP_menuExecutaParam pushBack _id_bd;
			};
		} else {
			_delete pushBack _forEachIndex;
		};
	} forEach BRPVP_squadInviteCases;
	_delete sort false;
	{BRPVP_squadInviteCases deleteAt _x;} forEach _delete;
};
BRPVP_getPlayersForSquad = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		private _player = _x;
		private _id_bd = _player getVariable ["id_bd",-1];
		if (_id_bd isNotEqualTo -1) then {
			private _lastInviteTime = _player getVariable ["brpvp_last_squad_invite_time",-10];
			private _pState = _player call BRPVP_unitSquadState;
			if (_pState isEqualTo "alone" && time-_lastInviteTime > 10) then {
				BRPVP_menuOpcoes pushBack format ["%1 - %2",_id_bd,_player getVariable "nm"];
				BRPVP_menuExecutaParam pushBack _id_bd;
			};
		};
	} forEach (call BRPVP_playersList-[player]);
};
BRPVP_pegaListaPlayers = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (_x call BRPVP_pAlive && _x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+name _x);
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach (call BRPVP_playersList-[player]);
};
BRPVP_pegaListaPlayersOriginalAlive = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (alive _x && _x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+name _x);
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach (call BRPVP_playersList-[player]);
};
BRPVP_pegaListaPlayersBodyChange = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (_x call BRPVP_pAlive && _x getVariable ["sok",false] && !isNull _x && isNull objectParent _x && getPos _x select 2 < 0.25 && _x call BRPVP_checaAcesso) then {
			private _id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+name _x);
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach (call BRPVP_playersList-[player]);
};
BRPVP_pegaListaPlayersHH = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (_x call BRPVP_pAlive && _x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			//if (_id_bd >= 0 && _x getVariable ["brpvp_hh_balance",0] >= BRPVP_headPriceSpotConsumePerMinute/6) then {
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+(_x getVariable ["nm","no_name"]));
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach (call BRPVP_playersList-[player]);
};
BRPVP_pegaListaPlayersAll = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (_x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+name _x);
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach (call BRPVP_playersList-[player]);
};
BRPVP_pegaListaPlayersAllPlayer = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		if (_x getVariable ["sok",false]) then {
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+name _x);
				BRPVP_menuExecutaParam pushBack _x;
			};
		};
	} forEach call BRPVP_playersList;
};
BRPVP_pegaListaPlayerscheckId = {
	BRPVP_menuOpcoes = [];
	BRPVP_menuExecutaParam = [];
	{
		private _id_bd = _x getVariable ["id_bd",-1];
		if (_id_bd >= 0) then {
			BRPVP_menuOpcoes pushBack (str _id_bd+" - "+(_x getVariable ["nm","no_name"]));
			BRPVP_menuExecutaParam pushBack [_id_bd,(_x getVariable ["brpvp_player_mode",""]) in ["admin","moderator"],_x getVariable ["nm","no_name"]];
		};
	} forEach call BRPVP_playersList;
};
BRPVP_menuMuda = {
	BRPVP_menuCustomKeysOff = true;
	private _same = _this isEqualTo BRPVP_menuIdc;
	private _menuIdcAntigo = if (!_same && BRPVP_menuIdc != -1) then {BRPVP_menuIdc} else {BRPVP_menuIdcSafe};
	BRPVP_menuIdc = _this;
	BRPVP_menuForceExit = {false};
	BRPVP_menuOptionCode = {};
	BRPVP_menuPosForce = -1;
	BRPVP_menuCorSelecao = "#FF3333";
	call (BRPVP_menu select _this);
	if (count BRPVP_menuOpcoes isEqualTo 0) exitWith {
		"erro" call BRPVP_playSound;
		call BRPVP_menuVoltar;
		if (_menuIdcAntigo isEqualTo -1) then {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		} else {
			_menuIdcAntigo call BRPVP_menuMuda;
		};
	};
	if (BRPVP_menuPosForce isEqualTo -1) then {
		private _findTxt = -1;
		(BRPVP_menuPos select BRPVP_menuIdc) params ["_mTxtArray","_mPos"];
		_mTxtArray = +_mTxtArray;
		reverse _mTxtArray;
		private _menuOpcoes = BRPVP_menuOpcoes apply {
			private _opt = _x;
			{_opt = [_opt,_x,""] call BRPVP_stringReplace;} forEach BRPVP_menuAutoSelectStringsToIgnore;
			private _irb = _opt find "@memory_remove_back@";
			if (_irb isNotEqualTo -1) then {_opt = _opt select [_irb+20,count _opt-(_irb+20)];};
			private _ira = _opt find "@memory_remove_after@";
			if (_ira isNotEqualTo -1) then {_opt = _opt select [0,_ira-1];};
			_opt
		};
		{
			_findTxt = _menuOpcoes find _x;
			if (_findTxt isNotEqualTo -1) exitWith {};
		} forEach _mTxtArray;
		if (_findTxt isEqualTo -1) then {
			if (_mPos < (count BRPVP_menuOpcoes)-1) then {BRPVP_menuOpcoesSel = _mPos;} else {BRPVP_menuOpcoesSel = (count BRPVP_menuOpcoes)-1;};
		} else {
			BRPVP_menuOpcoesSel = _findTxt;
		};
	} else {
		BRPVP_menuOpcoesSel = BRPVP_menuPosForce;
	};
	if (BRPVP_menuSleep > 0) then {
		hintSilent parseText ("<t align='center' size='1.65'>"+localize "str_please_wait"+"</t>");
		uiSleep BRPVP_menuSleep;
	};
	call BRPVP_atualizaDebugMenu;
	call BRPVP_menuOptionCode;
	BRPVP_menuCustomKeysOff = false;
};
BRPVP_iniciaMenuExtraBlock = false;
BRPVP_iniciaMenuExtra = {
	_id = _this;
	private _mlIdx = (BRPVP_cfgMenuLinesData select 0) find round (100*(getResolution select 5));
	BRPVP_cfgMenuLines = if (_mlIdx isEqualTo -1) then {3} else {BRPVP_cfgMenuLinesData select 1 select _mlIdx};
	if (!BRPVP_menuExtraLigado && !BRPVP_construindo && (!BRPVP_spectateOn && isNull BRPVP_spectingUnit) && !BRPVP_constantRunOn && !BRPVP_uPackUsing && !BRPVP_iniciaMenuExtraBlock) then {
		BRPVP_menuCustomKeysOff = true;
		BRPVP_menuExtraLigado = true;
		BRPVP_menuIdc = -1;
		BRPVP_menuIdcSafe = -1;
		BRPVP_menuSleep = 0;
		_id spawn BRPVP_menuMuda;
		"achou_loot" call BRPVP_playSound;
		if !(_id in [122]) then {
			["<img shadow='0' align='center' size='5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\zombie_icon.paa'/><br/><t shadow='0' align='center'>"+localize "str_menu_on_right"+"</t>",0,0,1000000,0,0,9959] call BRPVP_fnc_dynamicText;
			0 spawn {
				waitUntil {!BRPVP_menuExtraLigado};
				["",0,0,0,0,0,9959] call BRPVP_fnc_dynamicText;
				if (!isNull (findDisplay 46 displayCtrl 97310)) then {
					ctrlDelete (findDisplay 46 displayCtrl 97310);
					ctrlDelete (findDisplay 46 displayCtrl 97311);
					ctrlDelete (findDisplay 46 displayCtrl 97312);
					if (!isNull (findDisplay 46 displayCtrl 97313)) then {ctrlDelete (findDisplay 46 displayCtrl 97313);};
				};
				if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {"" remoteExecCall ["BRPVP_specMenuShow",BRPVP_specOnMeMachinesNoMe];};
			};
		};
		true
	} else {
		if (BRPVP_spectateOn || !isNull BRPVP_spectingUnit) then {
			[localize "str_spec_must_leave",0] call BRPVP_hint;
		} else {
			if (BRPVP_menuExtraLigado) then {[localize "str_menu_must_close",0] call BRPVP_hint;};
		};
		"erro" call BRPVP_playSound;
		false
	};
};
BRPVP_menuHtml = {
	_html = call (BRPVP_menuCabecalhoHtml select BRPVP_menuIdc);
	_html = _html + ([BRPVP_menuOpcoes,BRPVP_menuOpcoesSel,BRPVP_menuCorSelecao] call BRPVP_arrayParaListaHtml);
	if (BRPVP_menuTipoImagem isEqualTo 1) then {_html = _html + "<br/>" + BRPVP_menuImagem;};
	if (BRPVP_menuTipoImagem isEqualTo 2) then {_html = _html + "<br/>" + (BRPVP_menuImagem select BRPVP_menuOpcoesSel);};
	if (BRPVP_menuTipoImagem isEqualTo 3) then {call BRPVP_menuImagem;};
	_html = _html + (call (BRPVP_menuRodapeHtml select BRPVP_menuIdc));
	_html
};

//CABECALHO DO MENU
BRPVP_menuCabecalhoHtml = [
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu01_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu01_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu02_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu02_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu03_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu03_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu04_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu04_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu05_tittle"+"</t><br/><br/><t size='1.15' align='center' color='#FFFFFF'>"+localize "str_menu05_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu06_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu07_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu08_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	//10
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu12_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(BRPVP_menuVar1 call BRPVP_identifyShopType)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(BRPVP_menuVar1 call BRPVP_identifyShopType)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(BRPVP_menuVar1 call BRPVP_identifyShopType)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu17_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu18_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu19_tittle"+"</t><br/><br/>"},
	//20
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu20_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu21_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu22_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + (if (isClass (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff)) then {getText (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "displayName") call BRPVP_escapeForStructuredTextFast} else {str BRPVP_stuff}) + "</t><br/><t align='center' size='1.3' color='#CCCCCC'> "+format [localize "str_menu22_subtittle0",round ((1 - (damage BRPVP_stuff)) * 100)]+"</t><br/><br/><t align='center' size='1.3' color='#FFFFFF'>"+localize "str_menu22_subtittle1"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu23_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + (if (isClass (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff)) then {getText (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "displayName") call BRPVP_escapeForStructuredTextFast} else {str BRPVP_stuff}) + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu23_subtittle0"+" </t><t align='center' size='1.3' color='#77FF77'>" + (BRPVP_stuff call BRPVP_compEstado) + "</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu24_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + (if (isClass (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff)) then {getText (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "displayName") call BRPVP_escapeForStructuredTextFast} else {str BRPVP_stuff}) + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu24_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu25_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + (if (isClass (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff)) then {getText (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "displayName") call BRPVP_escapeForStructuredTextFast} else {str BRPVP_stuff}) + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu25_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu26_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + (if (isClass (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff)) then {getText (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "displayName") call BRPVP_escapeForStructuredTextFast} else {str BRPVP_stuff}) + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu25_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>INSIDE OR REALLY NEAR</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>INSIDE OR IN LESS THAN 10 M</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu29_tittle"+"</t><br/><br/>"},
	//30
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu30_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu31_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu32_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu33_tittle",BRPVP_menuVar1 getVariable ["nm","no_name"]]+"</t><br/><t align='center' size='1.3' color='#FFFFFF'>"+localize "str_menu33_subtittle0"+"</t>"+(if (BRPVP_giveNoRemove) then {"<br/><t size='1.0' color='"+(if (BRPVP_transferType == "mny") then {"#FF6666"} else {"#FFFFFF"})+"'>"+localize "str_debug0_4"+" "+((BRPVP_menuVar1 getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t size='1.0' color='"+(if (BRPVP_transferType == "brpvp_mny_bank") then {"#FF6666"} else {"#FFFFFF"})+"'>"+localize "str_debug0_4_2"+" "+((BRPVP_menuVar1 getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+"</t>"} else {""})+"<br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format [localize "str_menu34_tittle",BRPVP_menuVar2 call BRPVP_formatNumber,name BRPVP_menuVar1]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu35_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu36_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu37_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu38_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu39_tittle"+"</t><br/><br/>"},
	//40
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu40_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu41_tittle"+"</t><br/><t align='center' size='1.15' color='#FF0000'>"+localize "str_menu41_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu42_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu43_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu44_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu45_tittle"+"</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu45_subtittle0"+" </t><t align='center' size='1.3' color='#77FF77'>" + (player call BRPVP_actualExposition) + "</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu46_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu47_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu48_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu49_tittle"+"</t><br/>"+localize "str_menu49_subtittle0"+"<br/><br/>"},
	//50
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu50_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu51_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu52_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu53_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu54_tittle"+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu55_tittle"+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#eeee00'>" + (BRPVP_atmAmount call BRPVP_formatNumber) + " $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu56_tittle"+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#eeee00'>" + (BRPVP_atmAmount call BRPVP_formatNumber) + " $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+BRPVP_confirmTittle+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_hand"+" "+((player getVariable ["mny",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_atm_bank"+" "+((player getVariable ["brpvp_mny_bank",0]) call BRPVP_formatNumber)+" $</t><br/><t align='center' size='1.2' color='#eeee00'>" + (BRPVP_atmAmount call BRPVP_formatNumber) + " $</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu58_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") call BRPVP_escapeForStructuredTextFast]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu59_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") call BRPVP_escapeForStructuredTextFast]+"</t><br/><br/>"},
	//60
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu60_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") call BRPVP_escapeForStructuredTextFast]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format[localize "str_menu61_tittle",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") call BRPVP_escapeForStructuredTextFast]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu62_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu26_tittle"+"</t><br/><img size='3.0' align='center'" + (BRPVP_stuff call BRPVP_criaImagemTag) + "/><br/><t align='center' size='1.3' color='#FFFFFF'>" + (getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName") call BRPVP_escapeForStructuredTextFast) + "</t><br/><br/><t align='center' size='1.3' color='#66CC66'>"+localize "str_menu25_subtittle0"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu64_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu65_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu66_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu67_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu68_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu69_tittle"+"</t><br/><br/>"},
	//70
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu70_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu71_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu72_ztype"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu73_znumber"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu74_zforce"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu75_ztarget"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu35_tittle"+"</t><br/><t align='center' size='1.15' color='#FFD300'>"+BRPVP_menuVar1+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu77_pay_flag"+"</t><br/><t align='center' size='1.15' color='#FFD300'>"+localize "str_price"+" $"+((BRPVP_stuff call BRPVP_flagPayPrice) call BRPVP_formatNumber)+"/"+((BRPVP_stuff call BRPVP_getFlagPayPrice) call BRPVP_formatNumber)+" "+str round (100*(BRPVP_stuff call BRPVP_flagPayPrice)/(BRPVP_stuff call BRPVP_getFlagPayPrice))+" %</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu78_add_kill_funds"+"</t><br/><t align='center' size='1.5' color='#FFD300'>"+localize "str_balance"+((player getVariable "brpvp_hh_balance") call BRPVP_formatNumber)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu79_add_player_kill_funds"+"</t><br/><t align='center' size='1.5' color='#FFD300'>"+localize "str_balance"+((player getVariable "brpvp_hh_balance") call BRPVP_formatNumber)+"</t><br/><br/>"},
	//80
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu80_select_player_to_kill"+"</t><br/><t align='center' size='1.5' color='#FFD300'>"+localize "str_actual_head_price"+"<br/>"+((((BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel) call BRPVP_getPlayerById) getVariable ["brpvp_head_price",0]) call BRPVP_formatNumber)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu81_add_head_reward"+"</t><br/><t align='center' size='1.5' color='#FFD300'>"+localize "str_actual_head_price"+"<br/>"+(((BRPVP_menuVar1 call BRPVP_getPlayerById) getVariable ["brpvp_head_price",0]) call BRPVP_formatNumber)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu82_head_price_rank"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_select_event"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_move_virtual_garage"+"</t><br/><t align='center' size='1.2' color='#66dd66'>"+localize "str_price"+" $ "+(BRPVP_stuff call BRPVP_getVGPrice call BRPVP_formatNumber)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_get_virtual_garage"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_put_vehicle_cover"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_put_money_in_box"+"</t><br/><t align='center' size='1.2' color='#66dd66'> Box Money: $ "+(BRPVP_stuff call BRPVP_getBoxMoney call BRPVP_formatNumber)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_t_invasion_list"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_t_ban_player"+"</t><br/><br/>"},
	//90
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_t_unban_player"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_t_set_distances"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_wall_around_flag"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_set_wall_around_flag"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_admins_online"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_set_wall_around_flag"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+toUpper(localize "str_set_vault_tip")+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_control_center_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_control_center_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_control_center_tittle"+"</t><br/><br/>"},
	//100
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_control_center_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_control_center_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_control_center_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_control_center_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_get_money_in_box"+"</t><br/><t align='center' size='1.2' color='#66dd66'> Box Money: $ "+(BRPVP_stuff call BRPVP_getBoxMoney call BRPVP_formatNumber)+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_my_store_items"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_add_ceil"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_buried_money"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_select_amount"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_copy_loadout"+"</t><br/><br/>"},
	//110
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_give_all_objects"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_insurance"+"</t><br/><t align='center' size='1.5' color='#FFD300'>"+(getText (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "displayName") call BRPVP_escapeForStructuredTextFast)+"</t><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_insurance_get"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_sell_vehicle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_bus_select_location"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_all_or_wep_items"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_buy_wep_items"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_tw_conclude_buy"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(if (BRPVP_stuff getVariable ["brpvp_tele_destine_id",-1] isEqualTo -1) then {localize "str_title_select_destine"} else {format [localize "str_title_actual_destine_is",BRPVP_stuff getVariable "brpvp_tele_destine_id"]})+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_sell_your_gold"+"</t><br/><br/>"},
	//120
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_scan_result"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_gallon_menu"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_craft"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_cc_select_owner"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_craft_helper"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_choose_ore"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_alt_i_give1_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_alt_i_give2_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+(if (BRPVP_stuff getVariable ["brpvp_tele_destine_id",-1] isEqualTo -1) then {localize "str_title_select_destine"} else {format [localize "str_title_actual_destine_is",BRPVP_stuff getVariable "brpvp_tele_destine_id"]})+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format [localize "str_title_select_drone_to_find_op",BRPVP_spotedDroneOperatorsIdx]+"</t><br/><br/>"},
	//130
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_select_pylon"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format [localize "str_title_select_pylon_mag",round (BRPVP_pylonChangePrice/1000)]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_personal_objs"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_see_turret_kills"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_get_special_items"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_menu00_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format [localize "str_title_killed_players",toUpper BRPVP_menuVar2]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+format [localize "str_title_killed_players_case",toUpper BRPVP_menuVar4,toUpper BRPVP_menuVar2]+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_select_killer"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_show_player_type"+"</t><br/><br/>"},
	//140
	{"<t align='center' size='1.5' color='#FFFFFF'>SPAWN WEAPON KITS ON CITY</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SPAWN WEAPON KITS ON CITY</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SPAWN WEAPON KITS ON CITY</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SPAWN WEAPON KITS ON CITY</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_sel_paint_mode"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_sel_texture"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_sel_color"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_sel_skin"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_patrimony_rank"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>OTHER EVENTS</t><br/><br/>"},
	//150
	{"<t align='center' size='1.5' color='#FFFFFF'>LABIRINTY EVENT</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SNIPERS FIGHT EVENT</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>HELI FIGHT EVENT</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>ALLOW INSURANCE?</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_bag_soldier"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_carr_menu"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_vault_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_set_vaults"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_vaults_choose_n"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_vg_mult_set"+"</t><br/><br/>"},
	//160
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_vg_mult_mult"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_xp_see"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_xp_select_player"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SET BORN UNIT CLASS</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SELECT CLASS</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>ENABLE/DISABLE HABILITIE</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_scan_select_obj"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_newers_list"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_xp_select_player"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_turr_target_type"+"</t><br/><br/>"},
	//170
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_select_base_revive"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_class_ad_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_class_ad_confirm"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_class_ad_false_confirm"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_class_ad_remove_false"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_select_action"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_veh_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_veh_confirm"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_veh_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_veh_confirm_remove"+"</t><br/><br/>"},
	//180
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_class_ad_confirm_item"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_item_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_veh_confirm"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_item_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_veh_confirm"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_xp_select_player"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_player_names_last_use"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_dome_radius"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_vg_group_type"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_vg_legal_type"+"</t><br/><br/>"},
	//190
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_alt_i_give1_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_alt_i_give2_tittle"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_distance_to_see_c4_icon"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_select_action"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_veh_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_cad_item_select"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_set_big_floor_h"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_map_icons"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_player_path"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_body_change"+"</t><br/><br/>"},
	//200
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_admin_xp_1"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_admin_xp_2"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_uber_attack"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_ua_lateral_dist"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_select_sec_cam"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_select_sec_cam_explode"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_attach_to_a_player"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+"TRANSFER FROM"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+BRPVP_menuVar10+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+BRPVP_menuVar10+" [CARGO]"+"</t><br/><br/>"},
	//210
	{"<t align='center' size='1.5' color='#FFFFFF'>"+"CHOOSE QUANTITY"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+"TRANSFER TO?"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_heli_select_pilot"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_start_mission"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_hotkeys_key_sel"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+localize "str_title_hotkeys_set_new"+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+toUpper(localize "str_confirm")+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>"+toUpper(localize "str_confirm")+"</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SET MAIN COLOR</t><br/><br/>"},
	{"<t align='center' size='1.5' color='#FFFFFF'>SET DETAIL COLOR</t><br/><br/>"},
	//220
	{"<t align='center' size='1.5' color='#FFFFFF'>SELECT PLAYER</t><br/><br/>"}
];

//CORPO DO MENU
BRPVP_menu = [
	//MENU 0
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = [1,2,3,4,5];
		BRPVP_menuCodigo = {};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [
			localize "str_menu00_opt0",
			localize "str_menu00_opt1",
			localize "str_menu00_opt2",
			localize "str_menu00_opt3",
			localize "str_menu00_opt4"
		];
	},
	
	//MENU 1
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		[player getVariable ["amg",[]],player,false] remoteExecCall ["BRPVP_pegaNomePeloIdBd1",2];
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno;
		BRPVP_menuVoltar = {0 call BRPVP_menuMuda;};
	},
	
	//MENU 2
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_pegaNomePeloIdBd2Retorno = nil;
		[player getVariable ["id_bd",-1],player] remoteExecCall ["BRPVP_pegaNomePeloIdBd2",2];
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd2Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd2Retorno;
		BRPVP_menuVoltar = {0 call BRPVP_menuMuda;};
	},
	
	//MENU 3
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		_amgPlayer = player getVariable ["amg",[]];
		BRPVP_pegaNomePeloIdBd3Retorno = nil;
		[_amgPlayer,player getVariable "id_bd",player] remoteExecCall ["BRPVP_pegaNomePeloIdBd3",2];
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd3Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd3Retorno;
		BRPVP_menuVoltar = {0 call BRPVP_menuMuda;};
	},
	
	//MENU 4
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_amgPlayer = player getVariable ["amg",[]];
		{
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				if !(_id_bd in _amgPlayer) then {
					BRPVP_menuOpcoes pushBack (_x getVariable "nm");
					BRPVP_menuExecutaParam pushBack [_id_bd,_x getVariable "nm",_x];
				};
			};
		} forEach ((call BRPVP_playersList)-[player]);
		BRPVP_menuExecutaFuncao = BRPVP_confiarEmAlguem;
		BRPVP_menuVoltar = {0 call BRPVP_menuMuda;};
	},
	
	//MENU 5
	{
		BRPVP_menuTipo = 2;
		_amgPlayer = player getVariable ["amg",[]];
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		[_amgPlayer,player,true] remoteExecCall ["BRPVP_pegaNomePeloIdBd1",2];
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno select 0;
		BRPVP_menuExecutaParam = [];
		{BRPVP_menuExecutaParam pushBack [BRPVP_pegaNomePeloIdBd1Retorno select 1 select _forEachIndex,_x];} forEach BRPVP_menuOpcoes;
		BRPVP_menuExecutaFuncao = BRPVP_deixarDeConfiar;
		BRPVP_menuVoltar = {0 call BRPVP_menuMuda;};
	},
	
	//MENU 6
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		_experiencia = player getVariable ["exp",BRPVP_experienciaZerada];
		BRPVP_menuImagem = [];
		{BRPVP_menuImagem append ["<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\experiencia.paa'/><t size='2.5' align='center'>" + str _x + " </t>"];} forEach _experiencia;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = BRPVP_expLegenda;
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},
	
	//MENU 7
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 8;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
			BRPVP_menuVar2 = BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
		BRPVP_menuOpcoes = BRPVP_expLegenda;
	},
	
	//MENU 8
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<t size='2.0' color='#FFFF33' align='center'>" + BRPVP_menuVar1 + "</t><br/><img size='2.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\top_10.paa'/>";
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_pegaTop10EstatisticaRetorno = nil;
		[BRPVP_menuVar2,player] remoteExecCall ["BRPVP_pegaTop10Estatistica",2];
		waitUntil {!isNil "BRPVP_pegaTop10EstatisticaRetorno"};
		BRPVP_menuOpcoes = BRPVP_pegaTop10EstatisticaRetorno;
		BRPVP_menuVoltar = {7 call BRPVP_menuMuda;};
	},
	
	//MENU 9
	{
		BRPVP_menuIdcSafe = 9;
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 10;
		BRPVP_menuOpcoes = [];
		BRPVP_menuVal = [];
		{
			BRPVP_menuOpcoes pushBack (BRPVP_mercadoNomes select _x);
			BRPVP_menuVal pushBack _x;
		} forEach BRPVP_merchantItems;
		BRPVP_menuCodigo = {
			BRPVP_mercadorIdc2 = BRPVP_menuVal select BRPVP_menuOpcoesSel;
			BRPVP_menuVar1 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {
			if (count BRPVP_compraItensTotal > 0) then {
				12 call BRPVP_menuMuda;
			} else {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
		};
	},
	
	//MENU 10
	{
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		_precoBase = BRPVP_mercadoPrecos select BRPVP_mercadorIdc2;
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuDestino = 11;
		BRPVP_menuCodigo = {
			BRPVP_mercadorIdc3 = BRPVP_menuParams select BRPVP_menuOpcoesSel;
			BRPVP_menuVar2 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {9 call BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [];
		BRPVP_menuParams = [];
		{
			if (BRPVP_marketItemFilter in (BRPVP_mercadoNomesNomesFilter select BRPVP_mercadorIdc2 select _forEachIndex)) then {
				BRPVP_menuOpcoes pushBack _x;
				BRPVP_menuParams pushBack _forEachIndex;
			};
		} forEach (BRPVP_mercadoNomesNomes select BRPVP_mercadorIdc2);
	},
	
	//MENU 11
	{
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuOpcoes = [];
		BRPVP_menuImagem = [];
		BRPVP_menuMods = [];
		BRPVP_menuVal = [];
		_txt = "<t size='1.3' color='#FFFF33' align='center'>Price: $ %1</t><br/><img size='3' align='center' image='%2'/>%3";
		{
			if (_x select 0 isEqualTo BRPVP_mercadorIdc2 && _x select 1 isEqualTo BRPVP_mercadorIdc3) then {
				private ["_imagem","_nomeBonito"];
				private _haveDlc = true;
				_it = _x select 3;
				_idc = BRPVP_specialItems find _it;
				if (_idc >= 0) then {
					_imagem = BRPVP_imagePrefix+(BRPVP_specialItemsImages select _idc);
					_nomeBonito = BRPVP_specialItemsNames select _idc;
				} else {
					_imagem = BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa";
					_nomeBonito = "ITEM ?";
					_isM = isClass (configFile >> "CfgMagazines" >> _it);
					if (_isM) then {
						_imagem = getText (configFile >> "CfgMagazines" >> _it >> "picture");
						_nomeBonito = getText (configFile >> "CfgMagazines" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
					} else {
						_isW = isClass (configFile >> "CfgWeapons" >> _it);
						if (_isW) then {
							_imagem = getText (configFile >> "CfgWeapons" >> _it >> "picture");
							_nomeBonito = getText (configFile >> "CfgWeapons" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
							private _model = getText (configFile >> "CfgWeapons" >> _it >> "model");
							private _obj = createSimpleObject [_model select [1,count _model-1],[0,0,0],true];
							private _godlc = getObjectDLC _obj;
							_haveDlc = if (isNil "_godlc") then {true} else {_godlc in BRPVP_myDLCList};
							deleteVehicle _obj;
						} else {
							_isV = isClass (configFile >> "CfgVehicles" >> _it);
							if (_isV) then {
								_imagem = getText (configFile >> "CfgVehicles" >> _it >> "picture");
								_nomeBonito = getText (configFile >> "CfgVehicles" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
								private _model = getText (configFile >> "CfgVehicles" >> _it >> "model");
								private _obj = createSimpleObject [_model select [1,count _model-1],[0,0,0],true];
								private _godlc = getObjectDLC _obj;
								_haveDlc = if (isNil "_godlc") then {true} else {_godlc in BRPVP_myDLCList};
								deleteVehicle _obj;
							} else {
								_isG = isClass (configFile >> "CfgGlasses" >> _it);
								if (_isG) then {
									_imagem = getText (configFile >> "CfgGlasses" >> _it >> "picture");
									_nomeBonito = getText (configFile >> "CfgGlasses" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
								};
							};
						};
					};
				};
				_preco = (BRPVP_mercadoPrecos select BRPVP_mercadorIdc2)*(_x select 4)*BRPVP_itemTraderDiscount;
				BRPVP_menuOpcoes pushBack _nomeBonito;
				private _txt3 = if (_haveDlc) then {""} else {"<br/><t size='1.3' color='#FF0000' align='center'>"+localize "str_missing_dlc"+"</t>"};
				BRPVP_menuImagem pushBack format[_txt,(round _preco) call BRPVP_formatNumber,_imagem,_txt3];
				BRPVP_menuVal pushBack [_it,_preco,if (count _x > 5) then {_x select 5} else {1}];
				BRPVP_menuMods pushBack (_it call BRPVP_getItemMod);
			};
		} forEach BRPVP_mercadoItens;
		if (BRPVP_menuVar1 isEqualTo localize "str_mkt_main16" && BRPVP_menuVar2 isEqualTo localize "str_mkt_sub16_6") then {[localize "str_trader_house_only_craft",6] call BRPVP_hint;};
		BRPVP_menuDestino = 11;
		BRPVP_menuCodigo = {(BRPVP_menuVal select BRPVP_menuOpcoesSel) call BRPVP_comprouItem;};
		BRPVP_menuVoltar = {10 call BRPVP_menuMuda;};
	},
	
	//MENU 12
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuOpcoes = [localize "str_menu12_opt0",localize "str_menu12_opt1",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [0,1,2];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {
				31 call BRPVP_menuMuda;
			} else {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				if (_this isEqualTo 1) then {call BRPVP_comprouItemFinaliza;};
			};
		};
		BRPVP_menuVoltar = {9 call BRPVP_menuMuda;};
	},
	
	//MENU 13
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 14;
		BRPVP_menuOpcoes = [];
		{
			private ["_ladoResumo"];
			_alowed = BRPVP_vendaveAtivos select 0;
			_lado = _x select 0;
			_ladoResumo = _alowed call BRPVP_identifyShopType;
			if (!(_ladoResumo in BRPVP_menuOpcoes) && _lado in _alowed) then {
				BRPVP_menuOpcoes pushBack _ladoResumo;
				BRPVP_menuImagem pushBack ("<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\vehtrader.paa'/>");
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_vendaveAtivos select 0;
			BRPVP_menuVar4 = BRPVP_menuImagem select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {
			if (BRPVP_vendaveBackMenu isEqualTo -1) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				BRPVP_vendaveBackMenu call BRPVP_menuMuda;
			};
		};
	},

	//MENU 14
	{
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = BRPVP_menuVar4;
		BRPVP_menuDestino = 15;
		BRPVP_menuOpcoes = [];
		{
			_lado = _x select 0;
			_fac = _x select 1;
			if (!(_fac in BRPVP_menuOpcoes) && _lado in BRPVP_menuVar1) then {
				BRPVP_menuOpcoes append [_fac];
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuCodigo = {BRPVP_menuVar2 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;};
		BRPVP_menuVoltar = {13 call BRPVP_menuMuda;};
	},
	
	//MENU 15
	{
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = BRPVP_menuVar4;
		BRPVP_menuDestino = 16;
		BRPVP_menuOpcoes = [];
		{
			_lado = _x select 0;
			_fac = _x select 1;
			_tipo = _x select 2;
			if (!(_tipo in BRPVP_menuOpcoes) && _lado in BRPVP_menuVar1 && _fac == BRPVP_menuVar2) then {
				BRPVP_menuOpcoes append [_tipo];
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuCodigo = {BRPVP_menuVar3 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;};
		BRPVP_menuVoltar = {14 call BRPVP_menuMuda;};
	},
	
	//MENU 16
	{
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuMods = [];
		BRPVP_menuDestino = -1;
		BRPVP_menuOpcoes = [];
		BRPVP_menuVal = [];
		{
			_x params ["_lado","_fac","_tipo","_classe","_descr","_preco"];
			if (_lado in BRPVP_menuVar1 && _fac == BRPVP_menuVar2 && _tipo == BRPVP_menuVar3) then {
				BRPVP_menuOpcoes pushBack (_descr call BRPVP_escapeForStructuredTextFast);
				BRPVP_menuVal pushBack [_classe,_preco];
				_imagem = getText (configFile >> "CfgVehicles" >> _classe >> "editorPreview");
				_imagemSize = 5;
				if (_imagem isEqualTo "") then {
					_imagem = getText (configFile >> "CfgVehicles" >> _classe >> "picture");
					_imagemSize = 3;
				};
				private _obj = createSimpleObject [_classe,[0,0,0],true];
				private _godlc = getObjectDLC _obj;
				private _haveDlc =  if (isNil "_godlc") then {true} else {_godlc in BRPVP_myDLCList};
				deleteVehicle _obj;
				private _txt3 = if (_haveDlc) then {""} else {"<br/><t size='1.3' color='#FF0000' align='center'>"+localize "str_missing_dlc"+"</t>"};
				BRPVP_menuImagem append ["<t size='1.35' color='#FFFF33' align='center'>"+localize "str_price"+" $ "+(_preco call BRPVP_formatNumber)+"</t><br/><img size='"+str _imagemSize+"' align='center' image='"+_imagem+"'/>"+_txt3];
				BRPVP_menuMods pushBack (_classe call BRPVP_getItemMod);
			};
		} forEach BRPVP_tudoA3;
		BRPVP_menuOptionCode = {
			disableSerialization;
			ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
			_class = BRPVP_menuVal select BRPVP_menuOpcoesSel select 0;
			_ctrl = findDisplay 46 ctrlCreate ["RscStructuredText",BRPVP_vehicleSellCtrl];
			_ctrl ctrlSetBackgroundColor [0,0,0,1];
			_cfgVeh = configFile >> "CfgVehicles" >> _class;
			_armor = if (isNumber (_cfgVeh >> "armor")) then {getNumber (_cfgVeh >> "armor")} else {0};
			_cargo = -1;
			{if (_x select 0 isEqualTo _class) exitWith {_cargo = _x select 2;};} forEach BRPVP_customCargoVehiclesCfg;
			if (_cargo isEqualTo -1) then {_cargo = if (isNumber (_cfgVeh >> "maximumLoad")) then {getNumber (_cfgVeh >> "maximumLoad")} else {0};};
			_isLoadOut = isClass (_cfgVeh >> "Components" >> "TransportPylonsComponent");
			if (_isLoadOut) then {
				_ctrl ctrlSetPosition [0.4,0.46,0.2,0.126];
				_ctrl ctrlSetStructuredText parseText format ["<t align='center'><t color='#0050F0'>%1:</t> <t>%2</t></t><br/><t align='center'><t color='#0050F0'>%3:</t> <t>%4</t></t><br/><t align='center'><t color='#0050F0'>%5:</t> <t>%6</t></t>",localize "str_armor",_armor,localize "str_cargo",_cargo,localize "str_set_loadout",localize "str_yes"];
			} else {
				_ctrl ctrlSetPosition [0.4,0.46,0.2,0.084];
				_ctrl ctrlSetStructuredText parseText format ["<t align='center'><t color='#0050F0'>%1:</t> <t>%2</t></t><br/><t align='center'><t color='#0050F0'>%3:</t> <t>%4</t></t>",localize "str_armor",_armor,localize "str_cargo",_cargo];
			};
			_ctrl ctrlCommit 0;
		};
		BRPVP_menuCodigo = {
			private ["_isBig","_bvPos","_bvTime","_bvDir","_bvCheck"];
			_mult = BRPVP_vendaveAtivos select 1;
			_preco = (BRPVP_menuVal select BRPVP_menuOpcoesSel select 1)*_mult;
			_posS = getPosATL player;
			if (player call BRPVP_qjsValorDoPlayer >= _preco) then {
				_veiculo = BRPVP_menuVal select BRPVP_menuOpcoesSel select 0;
				_deployType = BRPVP_vendaveAtivos select 2;
				_xObj = [];
				_leave = false;
				if (_deployType isEqualTo "x_on_ground") then {
					_traderObj = BRPVP_vendaveAtivos select 3;
					_bigVehData = _traderObj getVariable ["vndv_big",[]];
					_size = "normal";
					{
						_x params ["_class","_sizeUse"];
						if (_veiculo isEqualTo _class) exitWith {_size = _sizeUse;};
					} forEach BRPVP_vehShopBigVehicles;
					_bvPos = [];
					_bvDir = 0;
					_bvTime = 0;
					_bvCheck = [];
					{
						_x params ["_type","_pos","_dir"];
						if (_type isEqualTo _size) exitWith {
							_bvPos = _pos;
							_bvDir = _dir;
							if (_size isEqualTo "big") then {
								_bvTime = 300;
								_bvCheck = [[25,30]];
							} else {
								if (_size isEqualTo "sbig") then {
									_bvTime = 900;
									_bvCheck = [[50,30]];
								};
							};
						};
					} forEach _bigVehData;
					_isBig = _bvPos isNotEqualTo [];
					_pointsArround = [];
					{
						for "_a" from 0 to 360 step (_x select 1) do {
							_pointsArround pushBack ([[0,0,0],_x select 0,_a] call BIS_fnc_relPos);
						};
					} forEach ([[0,360],[2,120],[4,60],[6,30],[8,20]]+_bvCheck);
					private _minWait = 1000000;
					private _xObjObjsToRemove = [];
					private _bPosAll = [];

					{
						private _minWaitX = 0;
						_xToTestAGL = if (_x isEqualType objNull) then {ASLToAGL getPosASL _x} else {_x};
						_xObjObjsToRemove = [];
						{
							_objToTest = _x;
							{
								private _pInB = [_xToTestAGL vectorAdd _x,_objToTest] call PDTH_pointIsInBox;
								private _near10 = _objToTest distance _xToTestAGL < 9;
								if (_pInB || _near10) exitWith {
									private _limit = _objToTest getVariable ["brpvp_parkLimit",0];
									if (serverTime > _limit) then {_xObjObjsToRemove pushBack _objToTest;} else {_minWaitX = _minWaitX max (_limit-serverTime);};
								};
							} forEach _pointsArround;
						} forEach (nearestObjects [_xToTestAGL,["LandVehicle","Air","Ship","PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"],25]);
						if (_minWaitX isEqualTo 0) exitWith {_xObj = _xToTestAGL;};
						_minWait = _minWait min _minWaitX;
					} forEach (if (_isBig) then {[_bvPos]} else {nearestObjects [_posS,["Land_JumpTarget_F"],100]});
					if (_xObj isEqualTo []) then {
						"erro" call BRPVP_playSound;
						[format [localize "str_buy_veh_wait",round _minWait],-6] call BRPVP_hint;
						_leave = true;
					} else {
						{
							_x hideObject true;
							if (typeOf _x in ["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"]) then {
								[["tire",_x getVariable ["brpvp_tire_idbd",-1]],true,true] call BRPVP_removeObject;
							} else {
								[_x,true,true] call BRPVP_removeObject;
							};
						} forEach _xObjObjsToRemove;
					};
				};
				if (_leave) exitWith {};
				_money = player getVariable ["mny",0];
				if (_money < _preco) exitWith {
					"erro" call BRPVP_playSound;
					[localize "str_no_money",0] call BRPVP_hint;
				};
				player setVariable ["mny",(player getVariable ["mny",0])-_preco,true];
				call BRPVP_atualizaDebug;
				"negocio" call BRPVP_playSound;
				"ugranted" call BRPVP_playSound;
				_isDrone = _veiculo in BRPVP_vantVehiclesClass;

				//VEHICLES TRADERS LOG
				[player,_preco,_veiculo,if (_deployType in ["fedidex","fedidex_vg_like"]) then {"vehicles fedidex"} else {"vehicles"}] remoteExecCall ["BRPVP_addTraderLog",2];
				[["comprou",_preco]] call BRPVP_mudaExp;

				if (_deployType in ["default","x_on_ground"]) then {
					private ["_posOk"];
					_vObj = createVehicle [_veiculo,BRPVP_spawnVehicleFirstPos,[],100,"CAN_COLLIDE"];
					_vObj setVariable ["brpvp_time_can_disable",serverTime+5,2];

					//PROTECT
					_vObj setVariable ["brpvp_coll_prot",true];
					_vObj lock true;
					_vObj spawn {
						private _init = diag_tickTime;
						_this allowDamage false;
						waitUntil {
							if (vectorMagnitude velocity _this > 0.125) then {_init = diag_tickTime;};
							diag_tickTime-_init > 2
						};
						_this setVariable ["brpvp_coll_prot",false];
						_this allowDamage true;
						_this lock false;
					};

					//SET CUSTOM CARGO SIZE
					{
						_x params ["_class","_name","_cargo"];
						if (_class isEqualTo _veiculo) exitWith {[_vObj,_cargo] remoteExecCall ["setMaxLoad",2];};
					} forEach BRPVP_customCargoVehiclesCfg;

					_vObj call BRPVP_setVehServicesToZero;
					_vObj call BRPVP_setVehRadarAndThermal;
					_vu = [0,0,1];
					_sizeOf = sizeOf _veiculo;
					if (_deployType isEqualTo "default") then {
						if ((ASLToAGL getPosASL player) select 2 > 0.5) then {
							_posOk = ASLToAGL ([getPosASL player vectorAdd [0,0,0],0.55*_sizeOf,getDir player] call BIS_fnc_relPos);
						} else {
							_posOk = [ASLToAGL getPosASL player vectorAdd [0,0,0],0.55*_sizeOf,getDir player] call BIS_fnc_relPos;
							_vu = surfaceNormal _posOk;
						};
					} else {
						_posOk = _xObj;
						_posOk set [2,0];
					};
					if (_veiculo isEqualTo "B_UAV_05_F") then {
						_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
						{_vObj animateSource [_x,1,true];} forEach _wingAnimations;
					};
					_vObj setPosASL AGLToASL _posOk;
					_vObj setDir (if (_isBig) then {_bvDir} else {[_vObj,player] call BIS_fnc_dirTo});
					_vObj setVectorUp _vu;
					if (_isDrone) then {
						//createVehicleCrew _vObj;
						if (BRPVP_dronesMakeAllUnarmed) then {
							{
								_vObj setPylonLoadout [configName _x,""];
							} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _vObj >> "Components" >> "TransportPylonsComponent" >> "pylons"));
						};
						_vObj setVariable ["brpvp_auto_first",true,true];
					};
					if (_deployType isEqualTo "x_on_ground") then {
						_pLimit = if (_isBig) then {_bvTime} else {120};
						_vObj setVariable ["brpvp_parkLimit",serverTime+_pLimit,true];
					};
					clearWeaponCargoGlobal _vObj;
					clearMagazineCargoGlobal _vObj;
					clearItemCargoGlobal _vObj;
					clearBackpackCargoGlobal _vObj;
					_vObj setVariable ["own",player getVariable "id_bd",true];
					_vObj setVariable ["stp",player getVariable "dstp",true];
					_vObj setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
					_vObj setVariable ["brpvp_locked",true,true];
					_exec = "";
					if (BRPVP_vendaveNoInsurance) then {
						_vObj setVariable ["brpvp_no_insurance",true,true];
						_exec = "_this setVariable ['brpvp_no_insurance',true,true];";
					};
					_estadoCons = [
						_vObj call BRPVP_getCargoArray,
						[getPosWorld _vObj,[vectorDir _vObj,vectorUp _vObj]],
						typeOf _vObj,
						_vObj getVariable "own",
						_vObj getVariable "stp",
						_vObj getVariable ["amg",[[],[],true]],
						_exec,
						[0,0,0,0,0,0],
						_vObj call BRPVP_getVehicleAmmo,
						_vObj call BRPVP_getHitpointsDamage,
						0
					];
					[false,_vObj,_estadoCons] remoteExecCall ["BRPVP_adicionaConstrucaoBd",2];
				};
				if (_deployType isEqualTo "fedidex") then {
					_fedidexPos = AGLToASL getPosASL player;
					_fedidexPos set [2,(_fedidexPos select 2)+1000];
					"fedidex_start" call BRPVP_playSound;
					["<img shadow='0' size='4' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\delivery.paa'/>",0,0,3,0,0,7757] call BRPVP_fnc_dynamicText;
					_fedidexBox = createVehicle ["Box_NATO_AmmoVeh_F",_fedidexPos,[],0,"NONE"];
					_fedidexBox allowDamage false;
					clearWeaponCargoGlobal _fedidexBox;
					clearMagazineCargoGlobal _fedidexBox;
					clearItemCargoGlobal _fedidexBox;
					clearBackpackCargoGlobal _fedidexBox;
					_fedidexBox setVelocity [0,0,-10];
					[_isDrone,_veiculo,_fedidexBox] spawn {
						params ["_isDrone","_veiculo","_fedidexBox"];
						_initFedidex = time;
						waitUntil {position _fedidexBox select 2 < 20};
						_fedidexBox setVelocity [0,0,0];
						waitUntil {position _fedidexBox select 2 < 5};
						_fedidexBox setVelocity [0,0,0];
						waitUntil {position _fedidexBox select 2 < 1.5};
						[_fedidexBox,"delivered",400] call BRPVP_playSoundAllCli;
						sleep 2;
						_spawnPos = getPosASL _fedidexBox;
						deleteVehicle _fedidexBox;
						sleep 0.001;
						_fedidexVeh = createVehicle [_veiculo,BRPVP_spawnVehicleFirstPos,[],0,"CAN_COLLIDE"];
						_fedidexVeh setVariable ["brpvp_time_can_disable",serverTime+5,2];

						//PROTECT
						_fedidexVeh setVariable ["brpvp_coll_prot",true];
						_fedidexVeh lock true;
						_fedidexVeh spawn {
							private _init = diag_tickTime;
							_this allowDamage false;
							waitUntil {
								if (vectorMagnitude velocity _this > 0.125) then {_init = diag_tickTime;};
								diag_tickTime-_init > 2
							};
							_this setVariable ["brpvp_coll_prot",false];
							_this allowDamage true;
							_this lock false;
						};

						//SET CUSTOM CARGO SIZE
						{
							_x params ["_class","_name","_cargo"];
							if (_class isEqualTo _veiculo) exitWith {[_fedidexVeh,_cargo] remoteExecCall ["setMaxLoad",2];};
						} forEach BRPVP_customCargoVehiclesCfg;

						_fedidexVeh call BRPVP_setVehServicesToZero;
						_fedidexVeh call BRPVP_setVehRadarAndThermal;
						_fedidexVeh setPosASL (_spawnPos vectorAdd [0,0,1]);
						_fedidexVeh setDir ([_fedidexVeh,player] call BIS_fnc_dirTo);
						if (ASLToAGL _spawnPos select 2 < 0.5) then {_fedidexVeh setVectorUp surfaceNormal _spawnPos;};
						_fedidexVeh setVariable ["brpvp_fedidex",true,true];
						_fedidexVeh remoteExecCall ["BRPVP_veiculoEhReset",2];
						clearWeaponCargoGlobal _fedidexVeh;
						clearMagazineCargoGlobal _fedidexVeh;
						clearItemCargoGlobal _fedidexVeh;
						clearBackpackCargoGlobal _fedidexVeh;
						"fedidex" call BRPVP_playSound;
						sleep 2.5;
						[format [localize "str_fedidex_time",round (time-_initFedidex)]] call BRPVP_hint;
					};
				};
				if (_deployType isEqualTo "fedidex_vg_like") then {
					_fedidexVeh = createVehicle [_veiculo,BRPVP_spawnVehicleFirstPos,[],0,"CAN_COLLIDE"];
					_fedidexVeh setVariable ["brpvp_time_can_disable",serverTime+5,2];

					//PROTECT
					_fedidexVeh setVariable ["brpvp_coll_prot",true];
					_fedidexVeh lock true;
					_fedidexVeh spawn {
						private _init = diag_tickTime;
						_this allowDamage false;
						waitUntil {
							if (vectorMagnitude velocity _this > 0.125) then {_init = diag_tickTime;};
							diag_tickTime-_init > 2
						};
						_this setVariable ["brpvp_coll_prot",false];
						_this allowDamage true;
						_this lock false;
					};

					//SET CUSTOM CARGO SIZE
					{
						_x params ["_class","_name","_cargo"];
						if (_class isEqualTo _veiculo) exitWith {[_fedidexVeh,_cargo] remoteExecCall ["setMaxLoad",2];};
					} forEach BRPVP_customCargoVehiclesCfg;

					_fedidexVeh call BRPVP_setVehServicesToZero;
					_fedidexVeh call BRPVP_setVehRadarAndThermal;
					_sizeOf = sizeOf _veiculo;
					_vu = [0,0,1];
					_spawnPos = if ((ASLToAGL getPosASL player) select 2 > 0.5) then {
						[getPosASL player vectorAdd [0,0,0],0.55*_sizeOf,getDir player] call BIS_fnc_relPos
					} else {
						private _pos = AGLToASL ([ASLToAGL getPosASL player vectorAdd [0,0,0],0.55*_sizeOf,getDir player] call BIS_fnc_relPos);
						_vu = surfaceNormal _pos;
						_pos
					};
					if (_veiculo isEqualTo "B_UAV_05_F") then {
						_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
						{_fedidexVeh animateSource [_x,1,true];} forEach _wingAnimations;
					};
					if (_isDrone) then {
						//createVehicleCrew _fedidexVeh;
						if (BRPVP_dronesMakeAllUnarmed) then {
							{
								_fedidexVeh setPylonLoadout [configName _x,""];
							} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _fedidexVeh >> "Components" >> "TransportPylonsComponent" >> "pylons"));
						};
						_fedidexVeh setVariable ["brpvp_auto_first",true,true];
					};
					_fedidexVeh setPosASL _spawnPos;
					_fedidexVeh setDir ([_fedidexVeh,player] call BIS_fnc_dirTo);
					_fedidexVeh setVectorUp _vu;
					_fedidexVeh setVariable ["brpvp_fedidex",true,true];
					_fedidexVeh remoteExecCall ["BRPVP_veiculoEhReset",2];
					clearWeaponCargoGlobal _fedidexVeh;
					clearMagazineCargoGlobal _fedidexVeh;
					clearItemCargoGlobal _fedidexVeh;
					clearBackpackCargoGlobal _fedidexVeh;
					"fedidex" call BRPVP_playSound;
				};
			} else {
				[localize "str_no_money",0] call BRPVP_hint;
				"erro" call BRPVP_playSound;
			};
			ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
		BRPVP_menuVoltar = {
			ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
			15 call BRPVP_menuMuda;
		};
	},

	//MENU 17
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		if (BRPVP_trataseDeAdmin) then {
			BRPVP_menuOpcoes = [
				localize "str_menu17_opt0",
				localize "str_menu17_opt1",
				localize "str_menu17_opt2",
				localize "str_menu17_opt3",
				localize "str_menu17_opt4",
				localize "str_attach_to_a_player",
				localize "str_menu17_opt5",
				localize "str_menu17_opt6"
			];
			BRPVP_menuDestino = [18,19,20,21,43,206,32,32];
		} else {
			BRPVP_menuOpcoes = [
				localize "str_menu17_opt0",
				localize "str_menu17_opt1"
			];
			BRPVP_menuDestino = [18,19];
		};
		BRPVP_menuCodigo = {
			if (BRPVP_menuOpcoesSel isEqualTo 6) then {
				BRPVP_giveMoneyEndMenu = 17;
				BRPVP_transferType = "mny";
				BRPVP_negativeValues = true;
				BRPVP_giveNoRemove = true;
				BRPVP_maxDistanceToGiveHandMoneyTemp = 1000000;
				BRPVP_personalAtm = false;
			} else {
				if (BRPVP_menuOpcoesSel isEqualTo 7) then {
					BRPVP_giveMoneyEndMenu = 17;
					BRPVP_transferType = "brpvp_mny_bank";
					BRPVP_negativeValues = true;
					BRPVP_giveNoRemove = true;
					BRPVP_maxDistanceToGiveHandMoneyTemp = 1000000;
					BRPVP_personalAtm = false;
				} else {
					BRPVP_menuVoltar = {17 call BRPVP_menuMuda;};
				};
			};
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 18
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersOriginalAlive;
		BRPVP_menuExecutaFuncao = {
			if (alive _this) then {
				_vip = false;
				_dvr = false;
				_ishigh = false;
				_pv = vehicle _this;
				_setPos = {
					_unit = _this;
					_av = objectParent player;
					if (isNull _av) then {
						_pos = player getPos [1.5,random 360];
						_pos set [2,getPosASL player select 2];
						[_unit,_pos] remoteExecCall ["setPosASL",_unit];
						[format [localize "str_tele_moved",_unit getVariable "nm"],-4] call BRPVP_hint;
						[player getVariable "id_bd",player getVariable "nm","Teleport bring to me",0,_unit getVariable "id_bd",_unit getVariable "nm"] remoteExecCall ["BRPVP_adminAddLog",2];
					} else {
						private _moveInServer = [];
						if (_av emptyPositions "Cargo" > 0) then {
							_moveInServer = [_unit,_av,"Cargo"];
						} else {
							if (_av emptyPositions "Gunner" > 0) then {
								_moveInServer = [_unit,_av,"Gunner"];
							} else {
								if (_av emptyPositions "Commander" > 0) then {
									_moveInServer = [_unit,_av,"Commander"];
								} else {
									if (_av emptyPositions "Driver" > 0) then {
										_moveInServer = [_unit,_av,"Driver"];
									} else {
										if (ASLToAGL getposASL _av select 2 < 2 && speed _av < 2) then {
											_unit setVehiclePosition [ASLToAGL getPosASL player,[],8,"CAN_COLLIDE"];
											[format [localize "str_tele_moved",_unit getVariable "nm"],-4] call BRPVP_hint;
											[player getVariable "id_bd",player getVariable "nm","Teleport bring to me",0,_unit getVariable "id_bd",_unit getVariable "nm"] remoteExecCall ["BRPVP_adminAddLog",2];
										} else {
											[localize "str_tele_no_position",-4] call BRPVP_hint;
										};
									};
								};
							};
						};
						if (count _moveInServer > 0) then {
							_moveInServer remoteExecCall ["BRPVP_moveInServer",2];
							[player getVariable "id_bd",player getVariable "nm","Teleport bring to me",0,_unit getVariable "id_bd",_unit getVariable "nm"] remoteExecCall ["BRPVP_adminAddLog",2];
							[format [localize "str_tele_moved",_unit getVariable "nm"],-4] call BRPVP_hint;
						};
					};
				};
				if (_pv != _this) then {
					_vip = _pv isKindOf "B_Parachute";
					if (driver _pv isEqualTo _this) then {
						_dvr = true;
						if ((getPosATL _pv select 2) > 2) then {
							_ishigh = true;
						};
					};
					if (!_dvr) then {
						_this call _setPos;
					} else {
						if (!_ishigh || _vip) then {
							_this call _setPos;
						} else {
							[localize "str_tele_cant_driver",-4] call BRPVP_hint;
						};
					};
				} else {
					_this call _setPos;
				};
			} else {
				"erro" call BRPVP_playSound;
			};
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 19
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersAll;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this && {_this call BRPVP_pAlive}) then {
				_pv = vehicle _this;
				if (_pv != _this) then {
					if (_pv emptyPositions "Cargo" > 0) then {
						player moveInCargo _pv;
					} else {
						if (_pv emptyPositions "Gunner" > 0) then {
							player moveInGunner _pv;
						} else {
							if (_pv emptyPositions "Commander" > 0) then {
								player moveInCommander _pv;
							} else {
								if (_pv emptyPositions "Driver" > 0) then {
									player moveInDriver _pv;
								} else {
									if (getposATL _pv select 2 < 2 && speed _pv < 2) then {
										player setVehiclePosition [ASLToAGL getPosASL _this,[],5,"NONE"];
									} else {
										[format [localize "str_tele_no_pos_destine",_this getVariable "nm"],5,7.5] call BRPVP_hint;
										player setVehiclePosition [ASLToAGL getPosASL _this,[],15,"NONE"];
									};
								};
							};
						};
					};
				} else {
					player setVehiclePosition [ASLToAGL getPosASL _this,[],2.5,"NONE"];
				};
			} else {
				"erro" call BRPVP_playSound;
			};
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 20
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuForceExit = {
			_true = !isNil "ACE_Medical";
			if (_true) then {["ACE Medical is on. Can't use this option.",0] call BRPVP_hint;};
			_true
		};
		call BRPVP_pegaListaPlayers;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this && {_this call BRPVP_pAlive}) then {
				_this setDamage 0;
			} else {
				"erro" call BRPVP_playSound;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
		};
	},

	//MENU 21
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayers;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this && {_this call BRPVP_pAlive}) then {
				[objNull,"Admin_Kill_F",true] remoteExecCall ["BRPVP_pehKilledFakeHandleDamage",_this];
			} else {
				"erro" call BRPVP_playSound;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
		};
	},

	//MENU 22
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		private ["_acsType","_sf"];
		_typeOf = typeOf BRPVP_stuff;
		_isDrone = _typeOf in BRPVP_vantVehiclesClass;
		_haveDyn = isClass (configFile >> "CfgVehicles" >> _typeOf >> "Components" >> "TransportPylonsComponent");
		_isDynLoadOut = ((!_isDrone && _haveDyn) || (_isDrone && _haveDyn && !BRPVP_dronesMakeAllUnarmed));
		_isMyBase = (player call BRPVP_checkOnFlagState) isEqualTo 2;
		_objectIsMotorizedNotStatic = BRPVP_stuff call BRPVP_isMotorized && !(BRPVP_stuff isKindOf "StaticWeapon");
		_iCanMove = _isMyBase && !_objectIsMotorizedNotStatic;
		if ((BRPVP_stuff getVariable "own") isEqualTo (player getVariable "id_bd")) then {
			_acsType = 4;_sf = "";
		} else {
			_boo = if (BRPVP_allPlayersOnFlagHaveAccessToAllBase) then {player call BRPVP_checkOnFlagState isEqualTo 2} else {player call BRPVP_playerIsIntoOwnerTerritory};
			if (_boo && !(BRPVP_stuff call BRPVP_IsMotorizedNoTurret)) then {
				_acsType = 0;_sf = "adm";
			} else {
				if (_iCanMove) then {
						if (BRPVP_vePlayers) then {_acsType = 4;_sf = "adm";} else {_acsType = 3;_sf = "";};
				} else {
					if (BRPVP_stuff isKindOf "FlagCarrier" || ((_typeOf isEqualTo "Land_RaiStone_01_F" || _typeOf isEqualTo BRPVP_baseSignClass || _isDynLoadout) && BRPVP_stuff call BRPVP_checaAcesso)) then {
						if (BRPVP_vePlayers) then {_acsType = 4;_sf = "adm";} else {_acsType = 1;_sf = "";};
					} else {
						if (_typeOf isEqualTo BRPVP_baseSignClass) then {
							if (BRPVP_vePlayers) then {_acsType = 4;_sf = "adm";} else {_acsType = 2;_sf = "";};
						} else {
							if (BRPVP_vePlayers) then {_acsType = 4;_sf = "adm";} else {_acsType = -1;_sf = "";};
						};
					};
				};
			};
		};
		BRPVP_menuOpcoes = [localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = ["cancel"];
		if (BRPVP_stuff call BRPVP_IsMotorized) then {
			if (_typeOf in BRP_kitAutoTurret) then {
				if (_acsType in [4,0]) then {
					if (isNull (BRPVP_stuff getVariable "brpvp_operator")) then {
						BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf)];
						BRPVP_menuExecutaParam = [23,58,24];
					} else {
						_upgradePrice = round (BRPVP_autoTurretUpgradePrice/1000) call BRPVP_formatNumber;
						_upgrade = format [localize ("str_turret_upgrade"+_sf),_upgradePrice];
						BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_opt5"+_sf),_upgrade,localize ("str_move_obj"+_sf)];
						BRPVP_menuExecutaParam = [23,58,24,63,62,"upgrade","move_obj"];
					};
					if (_typeOf in ["I_HMG_01_high_F","I_HMG_01_F"] && BRPVP_stuff getVariable ["brpvp_tlevel",-1] isEqualTo 2) then {
						BRPVP_menuOpcoes pushBack localize "str_turr_set_target";
						BRPVP_menuExecutaParam pushBack "tstarget";
					};
				} else {
					if (_acsType isEqualTo 3) then {
						BRPVP_menuOpcoes = [localize ("str_move_obj"+_sf)];
						BRPVP_menuExecutaParam = ["move_obj"];
					};
				};
			} else {
				if (_isDynLoadout) then {
					if (_acsType in [4,0]) then {
						BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt2"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_to_vg"+_sf),localize ("str_menu22_see_insurance"+_sf),localize ("str_menu22_pylon_cfg"+_sf),localize ("str_menu22_make_class_ad"+_sf)];
						BRPVP_menuExecutaParam = [23,58,24,25,26,84,"insurance",130,171];
					} else {
						if (_acsType isEqualTo 1) then {
							BRPVP_menuOpcoes = [localize ("str_menu22_pylon_cfg"+_sf)];
							BRPVP_menuExecutaParam = [130];
						};
					};
				} else {
					if (_acsType in [4,0]) then {
						_hasCover = if (isArray (configFile >> "CfgVehicles" >> _typeOf >> "animationList")) then {
							{
								if (_x isEqualType "") then {_x find "showCamonet" != -1 || _x find "showSLAT" != -1} else {false}
							} count getArray (configFile >> "CfgVehicles" >> _typeOf >> "animationList") > 0
						} else {
							false
						};
						if (_hasCover) then {
							BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt2"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_m_customize_cover"+_sf),localize ("str_menu22_to_vg"+_sf),localize ("str_menu22_see_insurance"+_sf),localize ("str_menu22_make_class_ad"+_sf)];
							BRPVP_menuExecutaParam = [23,58,24,25,26,86,84,"insurance",171];
						} else {
							BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt2"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_to_vg"+_sf),localize ("str_menu22_see_insurance"+_sf),localize ("str_menu22_make_class_ad"+_sf)];
							BRPVP_menuExecutaParam = [23,58,24,25,26,84,"insurance",171];
						};
					};
				};
			};
		} else {
			if (BRPVP_stuff getVariable ["mapa",false]) then {
				if (_acsType isEqualTo 4) then {
					BRPVP_menuOpcoes = [localize ("str_menu22_opt1"+_sf),localize ("str_move_obj"+_sf)];
					BRPVP_menuExecutaParam = [26,"move_obj"];
				};
			} else {
				if (isSimpleObject BRPVP_stuff || _typeOf isEqualTo "Land_PierLadder_F") then {
					if (_typeOf isEqualTo BRPVP_baseSignClass) then {
						if (_acsType in [4,0]) then {
							BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_opt5"+_sf),localize ("str_move_obj"+_sf),localize ("str_cons_sign_set_text"+_sf)];
							BRPVP_menuExecutaParam = [23,58,24,26,62,"move_obj","sign_set_txt"];
						} else {
							if (_acsType isEqualTo 1) then {
								BRPVP_menuOpcoes = [localize ("str_cons_sign_set_text"+_sf)];
								BRPVP_menuExecutaParam = ["sign_set_txt"];
							} else {
								if (_acsType isEqualTo 2) then {
									BRPVP_menuOpcoes = [format [localize "str_cons_sign_hack",BRPVP_baseSignHackPrice]];
									BRPVP_menuExecutaParam = ["sign_hack"];
								} else {
									if (_acsType isEqualTo 3) then {
										BRPVP_menuOpcoes = [localize ("str_cons_sign_set_text"+_sf),localize ("str_move_obj"+_sf)];
										BRPVP_menuExecutaParam = ["sign_set_txt","move_obj"];
									};
								};
							};
						};
					} else {
						if (_typeOf isEqualTo "Land_EngineCrane_01_F") then {
							if (_acsType in [4,0]) then {
								BRPVP_menuOpcoes = [localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_opt5"+_sf),localize ("str_menu22_add_ceil"+_sf)];
								BRPVP_menuExecutaParam = [24,26,62,106];
							};
						} else {
							if (_acsType in [4,0]) then {
								BRPVP_menuOpcoes = [localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_opt5"+_sf),localize ("str_move_obj"+_sf)];
								BRPVP_menuExecutaParam = [24,26,62,"move_obj"];
							} else {
								BRPVP_menuOpcoes = [localize ("str_move_obj"+_sf)];
								BRPVP_menuExecutaParam = ["move_obj"];
							};
						};
					};
				} else {
					if (BRPVP_stuff isKindOf "FlagCarrier") then {
						if (_acsType in [4,0]) then {
							BRPVP_menuOpcoes = [localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_mantain_flag"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_opt5"+_sf),localize ("str_move_obj"+_sf),localize ("str_see_turret_kills"+_sf),localize ("str_count_turrets"+_sf)];
							BRPVP_menuExecutaParam = [58,24,77,26,62,"move_obj",133,"count_turrets"];
						} else {
							BRPVP_menuOpcoes = [localize ("str_menu22_mantain_flag"),localize ("str_see_turret_kills"+_sf)];
							BRPVP_menuExecutaParam = [77,133];
						};
					} else {
						if (_typeOf isEqualTo "Land_RaiStone_01_F") then {
							if (_acsType in [4,0]) then {
								BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_opt5"+_sf),localize ("str_tele_see_id"+_sf),localize ("str_tele_configure"+_sf),localize ("str_move_obj"+_sf)];
								BRPVP_menuExecutaParam = [23,58,24,26,62,"tele_id",118,"move_obj"];
							} else {
								if (_acsType isEqualTo 1) then {
									BRPVP_menuOpcoes = [localize ("str_tele_see_id"+_sf),localize ("str_tele_configure"+_sf)];
									BRPVP_menuExecutaParam = ["tele_id",118];
								} else {
									if (_acsType isEqualTo 3) then {
										BRPVP_menuOpcoes = [localize ("str_tele_see_id"+_sf),localize ("str_tele_configure"+_sf),localize ("str_move_obj"+_sf)];
										BRPVP_menuExecutaParam = ["tele_id",118,"move_obj"];
									};
								};
							};
						} else {
							if (BRPVP_stuff getVariable ["brpvp_map_god_mode_house_id",-1] isNotEqualTo -1) then {
								if (_acsType in [4,0]) then {
									BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf)];
									BRPVP_menuExecutaParam = [23,58,24];
								};
							} else {
								if (_acsType in [4,0]) then {
									BRPVP_menuOpcoes = [localize ("str_menu22_opt0"+_sf),localize ("str_menu22_opt4"+_sf),localize ("str_menu22_opt3"+_sf),localize ("str_menu22_opt1"+_sf),localize ("str_menu22_opt5"+_sf),localize ("str_move_obj"+_sf)];
									BRPVP_menuExecutaParam = [23,58,24,26,62,"move_obj"];
									if (_typeOf isEqualTo "Land_Communication_F") then {
										BRPVP_menuOpcoes pushBack localize ("str_dome_radius"+_sf);
										BRPVP_menuExecutaParam pushBack 187;
									};
									if (BRPVP_stuff isKindOf "ReammoBox_F" && !(typeOf BRPVP_stuff in BRPVP_superBoxClass)) then {
										BRPVP_menuOpcoes pushBack format [localize "str_base_box_upgrade"+_sf,(round (BRPVP_customBaseBoxSizeUpgradePrice/1000) call BRPVP_formatNumber)+" K"];
										BRPVP_menuExecutaParam pushBack "box_upgrade";
										
									};
								} else {
									if (_acsType isEqualTo 3) then {
										BRPVP_menuOpcoes = [localize ("str_move_obj"+_sf)];
										BRPVP_menuExecutaParam = ["move_obj"];
									};
								};
							};
						};
					};
				};
			};
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				if (_this isEqualTo "sign_hack") then {
					_mny = player getVariable ["mny",0];
					if (_mny >= BRPVP_baseSignHackPrice) then {
						"negocio" call BRPVP_playSound;
						player setVariable ["mny",_mny-BRPVP_baseSignHackPrice,true];
						call BRPVP_atualizaDebug;
						BRPVP_stuff setVariable ["brpvp_hacked",true,true];
						[localize "str_cons_sign_hacked",-4] call BRPVP_hint;
						22 call BRPVP_menuMuda;
					} else {
						"erro" call BRPVP_playSound;
						[format [localize "str_mny_need_x_in_wallet",BRPVP_baseSignHackPrice],-4.5] call BRPVP_hint;
					};
				} else {
					if (_this isEqualTo "sign_set_txt") then {
						if (BRPVP_adminMsgAction select 0 isEqualTo "off") then {
							BRPVP_adminMsgAction = ["initiated",0];
							_txt = BRPVP_stuff getVariable ["brpvp_sign_txt",""];
							[_txt,BRPVP_stuff] spawn {
								params ["_txt","_stuff"];
								disableSerialization;
								_display = findDisplay 46 createDisplay "RscDisplayEmpty";
								
								_input = _display ctrlCreate ["RscEdit",-1];
								_input ctrlSetPosition [0,0,1,0.065];
								_input ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
								_input ctrlSetText _txt;
								_input ctrlCommit 0;
								
								_bOk = _display ctrlCreate ["RscButton",-1];
								_bOk ctrlSetPosition [0,0.1,0.15,0.065];
								_bOk ctrlSetText localize "str_ok";
								_bOk ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Ok",0];}];
								_bOk ctrlCommit 0;
								
								_bCancel = _display ctrlCreate ["RscButton",-1];
								_bCancel ctrlSetPosition [0.525,0.1,0.15,0.065];
								_bCancel ctrlSetText localize "str_menu12_opt2";
								_bCancel ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Cancel",0];}];
								_bCancel ctrlCommit 0;
								
								ctrlSetFocus _input;
								waitUntil {BRPVP_adminMsgAction select 0 != "initiated" || isNull _display};
								if (BRPVP_adminMsgAction select 0 isEqualTo "Ok") then {
									_txtNew = ctrlText _input;
									_stuff setVariable ["brpvp_sign_txt",_txtNew,true];
									_txtDb = [_txtNew,"'","''"] call BRPVP_stringReplace;
									_txtDb = [_txtDb,"""",""""""] call BRPVP_stringReplace;
									[_stuff getVariable "id_bd",_txtDb] remoteExecCall ["BRPVP_setSignExec",2];
								};
								if (!isNull _display) then {_display closeDisplay 1;};
								BRPVP_adminMsgAction = ["off",0];
							};
							BRPVP_menuExtraLigado = false;
							hintSilent "";
						} else {
							"erro" call BRPVP_playSound;
						};
					} else {
						if (_this isEqualTo "move_obj") then {
							if (BRPVP_raidServerIsRaidDay && BRPVP_raidWeekDaysDisableConstruction && !BRPVP_vePlayers) then {
								"erro" call BRPVP_playSound;
								[localize "str_cant_build_raid_day",-6] call BRPVP_hint;
							} else {
								if (typeOf BRPVP_stuff in BRP_kitAutoTurret && simulationEnabled BRPVP_stuff) then {
									"erro" call BRPVP_playSound;
									[localize "str_cant_move_active_turret",-6] call BRPVP_hint;
								} else {
									BRPVP_menuExtraLigado = false;
									hintSilent "";
									private _class = typeOf BRPVP_stuff;
									if (_class isEqualTo "") then {_class = getModelInfo BRPVP_stuff select 1;};
									[[_class],"",-2,false,BRPVP_stuff] call BRPVP_construir;
									BRPVP_stuff = objNull;
								};
							};
						} else {
							if (_this isEqualTo "insurance") then {
								if (BRPVP_stuff getVariable ["brpvp_no_insurance",false]) then {
									[localize "str_insurance_black_veh_cant",-5] call BRPVP_hint;
								} else {
									0 spawn {
										BRPVP_insuranceCheckExistenceAnswer = nil;
										[player,BRPVP_stuff] remoteExecCall ["BRPVP_insuranceCheckExistence",2];
										waitUntil {!isNil "BRPVP_insuranceCheckExistenceAnswer"};
										if (BRPVP_insuranceCheckExistenceAnswer isEqualTo 0) then {
											[localize "str_insurance_dont_have"] call BRPVP_hint;
										} else {
											private _insuranceTimesLimit = if (BRPVP_stuff isKindOf "Plane") then {BRPVP_insuranceTimesLimitPlane} else {if (BRPVP_stuff isKindOf "Helicopter") then {BRPVP_insuranceTimesLimitHeli} else {BRPVP_insuranceTimesLimit};};
											[format [localize "str_insurance_have",BRPVP_insuranceCheckExistenceAnswer,_insuranceTimesLimit]] call BRPVP_hint;
										};
									};
								};
							} else {
								if (_this isEqualTo "tele_id") then {
									[format [localize "str_tele_the_id_is",BRPVP_stuff getVariable ["id_bd",-1]]] call BRPVP_hint;
								} else {
									if (_this isEqualTo "upgrade") then {
										private _level = BRPVP_stuff getVariable ["brpvp_tlevel",1];
										private _operator = BRPVP_stuff getVariable "brpvp_operator";
										if (isNull _operator || simulationEnabled _operator) then {
											"erro" call BRPVP_playSound;
										} else {
											if (_level isEqualTo 1) then {
												_mny = player getVariable ["mny",0];
												_haveItem = "BRPVP_turretUpgrade" call BRPVP_sitCountItem > 0;
												if (_haveItem) then {
													["BRPVP_turretUpgrade",1] call BRPVP_sitRemoveItem;
													if (_mny >= BRPVP_autoTurretUpgradePrice) then {
														private _exec = "_this setVariable ['brpvp_tlevel',2,true];";
														player setVariable ["mny",_mny-BRPVP_autoTurretUpgradePrice,true];
														"ugranted" call BRPVP_playSound;
														call BRPVP_atualizaDebug;
														BRPVP_stuff setVariable ["brpvp_tlevel",2,true];
														if (typeOf BRPVP_stuff in BRPVP_autoTurretTypesTitan) then {[BRPVP_stuff,0.25] remoteExecCall ["BRPVP_setVehAmmoDef",2];};
														[BRPVP_stuff,"",""] remoteExecCall ["BRPVP_moveActionBoxBackTurret",2];
														[BRPVP_stuff getVariable ["id_bd",-1],_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
														BRPVP_stuff setVariable ["brpvp_tupdated",true,2];
														BRPVP_stuff setVariable ["brpvp_exec",_exec,2];
													} else {
														[format [localize "str_mny_need_x_in_wallet",BRPVP_autoTurretUpgradePrice call BRPVP_formatNumber],-5,200,0,"erro"] call BRPVP_hint;
													};
												} else {
													"erro" call BRPVP_playSound;
													["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\turret_upgrade.paa'/><br/><t color='#FF5050'>"+localize "str_you_need_turr_up_item"+"</t>",0,0.5,5,0,0,9927] call BRPVP_fnc_dynamicText;
												};
											} else {
												if (_level isEqualTo 2) then {[localize "str_cant_is_upgraded",-5,200,0,"erro"] call BRPVP_hint;};
											};
										};
									} else {
										if (_this isEqualTo "tstarget") then {
											169 call BRPVP_menuMuda;
										} else {
											if (_this isEqualTo "count_turrets") then {
												private _fRad = BRPVP_stuff getVariable ["brpvp_flag_radius",0];
												private _qTurrets = [BRPVP_stuff,0,false] call BRPVP_turretsOnFlagLimitReached;
												"granted" call BRPVP_playSound;
												[format ["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\turret_warning_0.paa'/><t size='2.0'> X%1</t>",_qTurrets],0,0.4,3,0,0,17923] call BRPVP_fnc_dynamicText;
											} else {
												if (_this isEqualTo "box_upgrade") then {
													private _obj = BRPVP_stuff;
													if (_obj isKindOf "ReammoBox_F" && (_obj getVariable ["id_bd",-1]) isNotEqualTo -1) then {
														if (_obj getVariable ["brpvp_box_level",1] isEqualTo 2) then {
															"erro" call BRPVP_playSound;
															[localize "str_base_box_max_upgrade_reached",-5] call BRPVP_hint;
														} else {
															private _mny = player getVariable ["mny",0];
															if (_mny < BRPVP_customBaseBoxSizeUpgradePrice) then {
																"erro" call BRPVP_playSound;
																[format [localize "str_mny_need_x_in_wallet",(round (BRPVP_customBaseBoxSizeUpgradePrice/1000) call BRPVP_formatNumber)+" K"],-5] call BRPVP_hint;
															} else {
																player setVariable ["mny",_mny-round BRPVP_customBaseBoxSizeUpgradePrice,true];
																private _exec = "_this setVariable ['brpvp_box_level',2,true];[_this,BRPVP_customBaseBoxSizeUpgrade] remoteExecCall ['setMaxLoad',2];";
																[_obj getVariable "id_bd",_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
																_obj setVariable ["brpvp_box_level",2,true];
																[_obj,BRPVP_customBaseBoxSizeUpgrade] remoteExecCall ["setMaxLoad",2];
																BRPVP_stuff = objNull;
																BRPVP_menuExtraLigado = false;
																hintSilent "";
																["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\box_upgrade.paa'/>",0,0.25,1.5,0,0,473245] call BRPVP_fnc_dynamicText;
																"box_upgrade" call BRPVP_playSound;
															};
														};
													} else {
														"erro" call BRPVP_playSound;
													};
												} else {
													if (_this isEqualTo 130) then {
														if (isNull objectParent player) then {_this call BRPVP_menuMuda;} else {"erro" call BRPVP_playSound;};
													} else {
														if (_this in [84,133,171]) then {_this spawn BRPVP_menuMuda;} else {_this call BRPVP_menuMuda;};
													};
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_stuff = objNull;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 23
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [
			localize "str_menu23_opt0",
			localize "str_menu23_opt1",
			localize "str_menu23_opt2",
			localize "str_menu23_opt3",
			localize "str_menu23_opt4",
			localize "str_menu23_opt0_cst",
			localize "str_menu23_opt1_cst",
			localize "str_menu23_opt2_cst",
			localize "str_menu23_opt4_cst"
		];
		_MPstp = BRPVP_stuff getVariable ["stp",1];
		_MPamg = BRPVP_stuff getVariable ["amg",[[],[],_MPstp in [1,2]]];
		if (count _MPamg isEqualTo 0 || {(_MPamg select 0) isEqualType 0}) then {_MPamg = [_MPamg,[],_MPstp in [1,2]];} else {if (count _MPamg isEqualTo 2 && (_MPamg select 0) isEqualType []) then {_MPamg pushBack (_MPstp in [1,2]);};};
		_MPuseCustom = _MPamg select 2;
		_extra = if (_MPuseCustom) then {if (_MPstp isEqualTo 4) then {4} else {5};} else {0};
		BRPVP_menuPosForce = _MPstp+_extra;
		BRPVP_menuExecutaParam = [[0,false],[1,false],[2,false],[3,false],[4,false],[0,true],[1,true],[2,true],[4,true]];
		BRPVP_menuExecutaFuncao = {
			params ["_newStp","_useCustom"];
			if (netId BRPVP_stuff isEqualTo "0:0") then {
				if (typeOf BRPVP_stuff in BRPVP_buildingHaveDoorListCVL) then {
					[[typeOf BRPVP_stuff],[[BRPVP_stuff getVariable "id_bd"]],_newStp,_useCustom] remoteExecCall ["BRPVP_setObjShareTypeSimpleObjectCVL",0];
				} else {
					[[typeOf BRPVP_stuff],[[BRPVP_stuff getVariable "id_bd"]],_newStp,_useCustom] remoteExecCall ["BRPVP_setObjShareTypeSimpleObject",0];
				};
				call BRPVP_atualizaDebugMenu;
			} else {
				BRPVP_stuff setVariable ["stp",_newStp,true];
				_amg = BRPVP_stuff getVariable ["amg",[[],[],_newStp in [1,2]]];
				if (count _amg isEqualTo 0 || {(_amg select 0) isEqualType 0}) then {_amg = [_amg,[],_usecustom];} else {if (count _amg isEqualTo 2 && (_amg select 0) isEqualType []) then {_amg pushBack _usecustom;} else {_amg set [2,_usecustom];};};
				BRPVP_stuff setVariable ["amg",_amg,true];
				"hint" call BRPVP_playSound;
				if !(BRPVP_stuff getVariable ["slv_amg",false]) then {BRPVP_stuff setVariable ["slv_amg",true,true];};
				if (typeOf BRPVP_stuff in BRP_kitAutoTurret) then {BRPVP_stuff setVariable ["brpvp_tupdated",true,2];};
				call BRPVP_atualizaDebugMenu;
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 24
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersAllPlayer;
		_owner = BRPVP_stuff getVariable ["own",-1];
		_del = -1;
		{if (_x getVariable ["id_bd",-2] isEqualTo _owner) exitWith {_del = _forEachIndex;};} forEach BRPVP_menuExecutaParam;
		if (_del > -1) then {
			BRPVP_menuOpcoes deleteAt _del;
			BRPVP_menuExecutaParam deleteAt _del;
		};
		BRPVP_menuExecutaFuncao = {
			if (isNull _this) then {
				"erro" call BRPVP_playSound;
				22 call BRPVP_menuMuda;
			} else {
				_allow = if (BRPVP_stuff isKindOf "FlagCarrier") then {
					_haveFlag = false;
					_idBd = _this getVariable ["id_bd",-1];
					{if ((_x getVariable "own") isEqualTo _idBd) exitWith {_haveFlag = true;};} forEach BRPVP_allFlags;
					!_haveFlag
				} else {
					true
				};
				if (_allow) then {
					if (netId BRPVP_stuff isEqualTo "0:0") then {
						if (typeOf BRPVP_stuff in BRPVP_buildingHaveDoorListCVL) then {
							[typeOf BRPVP_stuff,BRPVP_stuff getVariable "id_bd",_this,player] remoteExecCall ["BRPVP_mudaDonoPropriedadeSimpleObjectCVL",0];
						} else {
							[typeOf BRPVP_stuff,BRPVP_stuff getVariable "id_bd",_this,player] remoteExecCall ["BRPVP_mudaDonoPropriedadeSimpleObject",0];
						};
					} else {
						[BRPVP_stuff,_this] call BRPVP_mudaDonoPropriedade;
						remoteExecCall ["BRPVP_findMyFlags",_this];
						call BRPVP_findMyFlags;
					};
					"ugranted" call BRPVP_playSound;
					[format [localize "str_props_give_to",getText (configFile >> "CfgVehicles" >> (typeOf BRPVP_stuff) >> "displayName"),_this getVariable ["nm","no_name"]],4,15] call BRPVP_hint;
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				} else {
					"erro" call BRPVP_playSound;
					24 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 25
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				[BRPVP_stuff,objNull] call BRPVP_mudaDonoPropriedade;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				22 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},
	
	//MENU 26
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				if (BRPVP_raidServerIsRaidDay && BRPVP_raidWeekDaysDisableConstruction && !BRPVP_vePlayers) then {
					"erro" call BRPVP_playSound;
					[localize "str_cant_build_raid_day",-6] call BRPVP_hint;
				} else {
					_isFlag = BRPVP_stuff isKindOf "FlagCarrier";
					if (_isFlag && {BRPVP_stuff call BRPVP_flagPayPrice > 0}) then {
						"erro" call BRPVP_playSound;
						[localize "str_remove_cant_need_pay_flag",-6] call BRPVP_hint;
					} else {
						_flagRad = BRPVP_stuff getVariable ["brpvp_flag_radius",0];
						if (_isFlag && {{BRPVP_stuff distance2D _x < 300+_flagRad} count BRPVP_missionsPos > 0}) then {
							"erro" call BRPVP_playSound;
							[localize "str_cant_flag_near_miss",-6] call BRPVP_hint;
						} else {
							private _typeOf = typeOf BRPVP_stuff;
							private _rad = 10+(sizeOf _typeOf)/2;
							[BRPVP_stuff,_rad,5] call BRPVP_enableVehiclesBuildingsChanged;
							if (netId BRPVP_stuff isEqualTo "0:0") then {
								if (typeOf BRPVP_stuff in BRPVP_buildingHaveDoorListCVL) then {
									[typeOf BRPVP_stuff,BRPVP_stuff getVariable "id_bd"] remoteExecCall ["BRPVP_removeObjectSimpleObjectCVL",0];
								} else {
									[typeOf BRPVP_stuff,BRPVP_stuff getVariable "id_bd"] remoteExecCall ["BRPVP_removeObjectSimpleObject",0];
								};
							} else {
								if (BRPVP_stuff call BRPVP_isMotorized) then {{deleteVehicle _x;} forEach attachedObjects BRPVP_stuff;};
								[BRPVP_stuff,true] call BRPVP_removeObject;
							};
							BRPVP_menuExtraLigado = false;
							hintSilent "";
						};
					};
				};
			} else {
				22 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 27
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuOpcoes = [];
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 28
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuOpcoes = [];
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 29
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		if (BRPVP_trataseDeAdmin) then {
			BRPVP_menuOpcoes = [
				format [localize "str_menu29_opt0",if (player getVariable "brpvp_god_admin") then {"X"} else {"   "}],
				localize "str_bi_spectator",
				localize "str_menu29_admin_msg",
				localize "str_simulation_info",
				localize "str_set_born_class",
				format [localize "str_born_died_itens",if (BRPVP_bornWithDeadItems) then {"X"} else {"   "}],
				localize "str_menu29_set_player_vaults",
				localize "str_menu29_vg_mult",
				localize "str_menu29_change_xp",
				localize "str_draw_a_player",
				localize "str_m_ban_player",
				localize "str_m_unban_player",
				localize "str_gear_to_player",
				format [localize "str_menu29_rapid_fire",if (BRPVP_rapidFire) then {"X"} else {"   "}],
				format [localize "str_menu29_opt1",if (BRPVP_vePlayers) then {"X"} else {"   "}],
				format [localize "str_admin_sixth_sense",["   ","X"] select BRPVP_vePlayersSixthSense],
				format [localize "str_menu29_opt2",if (BRPVP_playerIsCaptive) then {"X"} else {"   "}],
				format [localize "str_invisible_to_zeds",if (player getVariable ["brpvp_zombie_can_see",true]) then {"   "} else {"X"}],
				localize "str_menu29_spawn_zombies",
				localize "str_menu29_arsenal",
				localize "str_menu29_opt5",
				localize "str_menu29_opt6",
				localize "str_menu29_opt7",
				localize "str_menu29_opt8",
				localize "str_menu29_opt9",
				localize "str_menu29_opt10",
				localize "str_start_a_mission",
				format [localize "str_menu_weather_debug",if (BRPVP_weatherDegug) then {"X"} else {"   "}],
				localize "str_adm_abilities_on_off",
				format [localize "str_menu29_opt18",if (BRPVP_monitoreGroups) then {"X"} else {"   "}],
				localize "str_menu29_opt19",
				format ["(%1) Admin Flag Fly",["   ","X"] select BRPVP_flyOnOffAdmin],
				format [localize "str_menu29_opt20",if (player getVariable ["brpvp_invisible",false]) then {"X"} else {"   "}],
				format [localize "str_menu29_opt21",5000000 call BRPVP_formatNumber],
				localize "str_event_start_stop",
				localize "str_other_events",
				localize "str_menu_revive_a_base"
			];
			BRPVP_menuImagem = [
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\compass.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>"
			];
			BRPVP_menuExecutaParam = [0,34,26,38,42,44,40,41,46,37,29,30,35,23,1,47,2,24,22,25,5,6,7,8,9,10,48,16,43,18,19,49,20,21,27,39,45];
		} else {
			BRPVP_menuOpcoes = [
				format [localize "str_menu29_opt0",if (player getVariable "brpvp_god_admin") then {"X"} else {"   "}],
				localize "str_bi_spectator",
				localize "str_menu29_admin_msg",
				format [localize "str_menu29_opt2",if (BRPVP_playerIsCaptive) then {"X"} else {"   "}],
				format [localize "str_invisible_to_zeds",if (player getVariable ["brpvp_zombie_can_see",true]) then {"   "} else {"X"}],
				localize "str_menu29_opt7",
				localize "str_menu29_opt8",
				localize "str_menu29_opt9",
				localize "str_menu29_opt10"
			];
			BRPVP_menuImagem = [
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>",
				"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\admin_cfg.paa'/>"
			];
			BRPVP_menuExecutaParam = [0,34,26,2,24,7,8,9,10];
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 49) then {
				call BRPVP_baseFlyCodeAdminOnOff;
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 48) then {213 call BRPVP_menuMuda;};
			if (_this isEqualTo 47) then {
				BRPVP_vePlayersSixthSense = !BRPVP_vePlayersSixthSense;
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 46) then {200 spawn BRPVP_menuMuda;};
			if (_this isEqualTo 45) then {170 spawn BRPVP_menuMuda;};
			if (_this isEqualTo 44) then {
				BRPVP_bornWithDeadItems	= !BRPVP_bornWithDeadItems;
				publicVariable "BRPVP_bornWithDeadItems";
				"hint2" call BRPVP_playSound;
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 43) then {165 spawn BRPVP_menuMuda;};
			if (_this isEqualTo 42) then {163 call BRPVP_menuMuda;};
			if (_this isEqualTo 41) then {159 call BRPVP_menuMuda;};
			if (_this isEqualTo 40) then {157 call BRPVP_menuMuda;};
			if (_this isEqualTo 39) then {149 call BRPVP_menuMuda;};
			if (_this isEqualTo 38) then {
				private _ids = [clientOwner,2];
				remoteExecCall ["BRPVP_contentReport",_ids];
			};
			if (_this isEqualTo 37) then {
				_drawn = 0;
				while {_drawn isEqualTo 0} do {_drawn = selectRandom allPlayers getVariable ["nm",0];};
				_drawn remoteExecCall ["BRPVP_showDrawPlayer",BRPVP_allNoServer];
			};
			if (_this isEqualTo 35) then {109 call BRPVP_menuMuda;};
			if (_this isEqualTo 34) then {
				["Initialize", [player]] call BIS_fnc_EGSpectator;
				0 spawn {
					with uiNamespace do {
						waitUntil {!isNull findDisplay 60492};
						disableSerialization;
						_ctrl = findDisplay 60492 ctrlCreate ["RscStructuredText",-1];
						_ctrl ctrlSetPosition [safezoneX+safezoneW-0.0625,safezoneY,0.0625,0.065];
						_ctrl ctrlSetStructuredText parseText "<img size='1.4' align='center' image='\A3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_exit_ca.paa'/>";
						_ctrl ctrlSetTextColor [0.9,0.9,0.9,1];
						_ctrl ctrlSetBackgroundColor [0.1,0.1,0.1,0.9];
						_ctrl ctrlAddEventHandler ["MouseButtonClick",{["Terminate"] call BIS_fnc_EGSpectator}];
						_ctrl ctrlCommit 0;
					};
				};
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
			if (_this isEqualTo 30) then {90 spawn BRPVP_menuMuda;};
			if (_this isEqualTo 29) then {89 call BRPVP_menuMuda;};
			if (_this isEqualTo 0) then {
				if (player getVariable "brpvp_god_admin") then {
					[localize "str_godmode_off",0] call BRPVP_hint;
					player setVariable ["brpvp_god_admin",false,true];
				} else {
					[localize "str_godmode_on",0] call BRPVP_hint;
					player setVariable ["brpvp_god_admin",true,true];
					{_x setDamage 0;} forEach [player,vehicle player];
				};
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 1) then {
				if (BRPVP_vePlayers) then {
					BRPVP_vePlayers = false;
					player setVariable ["brpvp_ve_players",false,true];
					[localize "str_allsee_off",0] call BRPVP_hint;
					if (visibleMap || visibleGPS) then {BRPVP_mapDrawReset = true;};
					call BRPVP_checkAllCVLDoors;
					call BRPVP_recalcMyFrantaMines;
				} else {
					BRPVP_vePlayers = true;
					player setVariable ["brpvp_ve_players",true,true];
					[localize "str_allsee_on",0] call BRPVP_hint;
					if (visibleMap || visibleGPS) then {BRPVP_mapDrawReset = true;};
					call BRPVP_recalcMyFrantaMines;
				};
				BRPVP_mapDrawPrecisao = -10;
				call BRPVP_daUpdateNosAmigos;
				call BRPVP_findMyFlags;
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 2) then {
				if (!BRPVP_playerIsCaptive) then {
					BRPVP_playerIsCaptive = true;
					player setCaptive true;
				} else {
					BRPVP_playerIsCaptive = false;
					if !(call BRPVP_playerCaptiveState) then {player setCaptive false;};
					
					{if !(_x call BRPVP_isPlayer) then {_x reveal [player,1.5];};} forEach (player nearEntities ["CAManBase",200]);
				};
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 5) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				BRPVP_itemTraderDiscount = 1;
				[0,0,0,[player,[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],0,3]] execVm "client_code\actions\actionTrader.sqf";
			};
			if (_this isEqualTo 6) then {153 call BRPVP_menuMuda;};
			if (_this isEqualTo 7) then {17 call BRPVP_menuMuda;};
			if (_this isEqualTo 8) then {36 call BRPVP_menuMuda;};
			if (_this isEqualTo 9) then {38 call BRPVP_menuMuda;};
			if (_this isEqualTo 10) then {39 call BRPVP_menuMuda;};
			if (_this isEqualTo 16) then {
				if (BRPVP_useDynamicWeather) then {
					BRPVP_weatherDegug = !BRPVP_weatherDegug;
					if (BRPVP_weatherDegug) then {
						["Weather Debug On!",-3.5] call BRPVP_hint;
						BRPVP_weatherDebugMachinesOn pushBackUnique clientOwner;
						publicVariable "BRPVP_weatherDebugMachinesOn";
					} else {
						["Weather Debug Off!",-3.5] call BRPVP_hint;
						BRPVP_weatherDebugMachinesOn = BRPVP_weatherDebugMachinesOn-[clientOwner];
						publicVariable "BRPVP_weatherDebugMachinesOn";
					};
					29 call BRPVP_menuMuda;
				} else {
					"erro" call BRPVP_playSound;
				};
			};
			if (_this isEqualTo 18) then {
				if (BRPVP_monitoreGroups) then {
					BRPVP_monitoreGroups = false;
				} else {
					BRPVP_monitoreGroups = true;
					0 spawn {
						while {BRPVP_monitoreGroups} do {
							_sides = [];
							_sidesCount = [];
							_civSideZeroCount = 0;
							{
								_sideStr = str side _x;
								_sides pushBackUnique _sideStr;
								_idx = _sides find _sideStr;
								if (count _sidesCount >= _idx + 1) then {
									_sidesCount set [_idx,(_sidesCount select _idx) + 1];
								} else {
									_sidesCount set [_idx,1];
								};
								if (side _x isEqualTo CIVILIAN) then {
									_unitsCount = count units _x;
									if (_unitsCount isEqualTo 0) then {
										_civSideZeroCount = _civSideZeroCount + 1;
									};
								};
							} forEach allGroups;
							_agLocal = 0;
							_agServer = 0;
							{if (local _x) then {_agLocal = _agLocal + 1;} else {_agServer = _agServer + 1;};} forEach entities [[BRPVP_zombieMotherClass],[]];
							systemChat (str _sides + " | " + str _sidesCount + " | " + localize "str_menu29_opt18_txt" + " " + str _civSideZeroCount + " | Agt: Loc " + str _agLocal + ", NLoc " + str _agServer);
							sleep 1;
						};
					};
				};
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 19) then {50 call BRPVP_menuMuda;};
			if (_this isEqualTo 20) then {
				_isHidden = player getVariable ["brpvp_invisible",false];
				if (_isHidden) then {
					player setVariable ["brpvp_invisible",false,true];
					[player,false] remoteExecCall ["hideObjectGlobal",2];
					[localize "str_player_is_visible"] call BRPVP_hint;
					BDW_forceUpdate = true;
				} else {
					player setVariable ["brpvp_invisible",true,true];
					[player,true] remoteExecCall ["hideObjectGlobal",2];
					[localize "str_player_is_invisible"] call BRPVP_hint;
				};
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 21) then {
				[player,5000000] call BRPVP_qjsAdicClassObjeto;
				"negocio" call BRPVP_playSound;
			};
			if (_this isEqualTo 22) then {72 call BRPVP_menuMuda;};
			if (_this isEqualTo 23) then {
				BRPVP_rapidFire = !BRPVP_rapidFire;
				"hint" call BRPVP_playSound;
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 24) then {
				if (player getVariable ["brpvp_zombie_can_see",true]) then {
					player setVariable ["brpvp_zombie_can_see",false,true];
				} else {
					player setVariable ["brpvp_zombie_can_see",true,true];
				};
				29 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 25) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				["Open",true] spawn BIS_fnc_arsenal;

				//REAPPLY INVISIBILITY IF REMOVED BY ARMA 3
				if (player getVariable ["brpvp_invisible",false]) then {
					if (!isObjectHidden player) then {player hideObject true;};
					0 spawn {
						waitUntil {!isObjectHidden player};
						sleep 0.001;
						[player,true] remoteExecCall ["hideObjectGlobal",2];
					};
				};
			};
			if (_this isEqualTo 26) then {
				if (BRPVP_adminMsgAction select 0 isEqualTo "off") then {
					BRPVP_adminMsgAction = ["initiated",0];
					0 spawn {
						disableSerialization;
						_display = findDisplay 46 createDisplay "RscDisplayEmpty";
						
						_input = _display ctrlCreate ["RscEdit",-1];
						_input ctrlSetPosition [0,0,1,0.065];
						_input ctrlSetBackgroundColor [0.5,0.5,0.5,0.5];
						_input ctrlCommit 0;
						
						_b10sec = _display ctrlCreate ["RscButton",-1];
						_b10sec ctrlSetPosition [0,0.1,0.15,0.065];
						_b10sec ctrlSetText "Send (10 sec)";
						_b10sec ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Send",10];}];
						_b10sec ctrlCommit 0;
						
						_b15sec = _display ctrlCreate ["RscButton",-1];
						_b15sec ctrlSetPosition [0.175,0.1,0.15,0.065];
						_b15sec ctrlSetText "Send (15 sec)";
						_b15sec ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Send",15];}];
						_b15sec ctrlCommit 0;
						 
						_b20sec = _display ctrlCreate ["RscButton",-1];
						_b20sec ctrlSetPosition [0.350,0.1,0.15,0.065];
						_b20sec ctrlSetText "Send (20 sec)";
						_b20sec ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Send",20];}];
						_b20sec ctrlCommit 0;
						 
						_bCancel = _display ctrlCreate ["RscButton",-1];
						_bCancel ctrlSetPosition [0.525,0.1,0.15,0.065];
						_bCancel ctrlSetText "Cancel";
						_bCancel ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Cancel",0];}];
						_bCancel ctrlCommit 0;
						
						while {!isNull _display} do {
							ctrlSetFocus _input;
							waitUntil {BRPVP_adminMsgAction select 0 != "initiated" || isNull _display};
							if (BRPVP_adminMsgAction select 0 isEqualTo "Send") then {
								_txt = ctrlText _input;
								if (_txt != "") then {
									[
										[_txt,BRPVP_adminMsgAction select 1,"admin_msg"],
										{
											params ["_msg_txt","_msg_duration",["_sound",""]];
											["<img shadow='0' size='1.75' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\msg_skull_red.paa'/><br/><t shadow='0' color='#00C000' size='0.85'>"+_msg_txt+"</t>",{0},{(safezoneY + 0.05) min 0},_msg_duration,0,0,8757] call BRPVP_fnc_dynamicText;
											if (_sound != "") then {_sound call BRPVP_playSound;};
										}
									] remoteExecCall ["call",BRPVP_allNoServer];
									_input ctrlSetText "";
								};
								BRPVP_adminMsgAction = ["initiated",0];
							} else {
								if (!isNull _display) then {_display closeDisplay 1;};
								BRPVP_adminMsgAction = ["off",0];
							};
						};
					};
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				} else {
					"erro" call BRPVP_playSound;
				};
			};
			if (_this isEqualTo 27) then {83 spawn BRPVP_menuMuda;};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 30
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\db_save.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\tutorial.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\rules.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\links.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>",
			"<img size='2.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/> <img size='2.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\icones3d\amigo.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\map_icons.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\brpvpid.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\select_srun.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\double_smoke.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\store.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\crosshair.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\keys.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\path.paa'/>",
			"<img size='2.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/> <img size='2.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/> <img size='2.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\friends.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\squad.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\fast_keys.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\setweather.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\mark.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\novato.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\nature.paa'/>",
			"<img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\patrimony.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\exposition.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\virtual_garage.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\menu_mark_loot.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\viewdistance.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\can_build.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\spectate.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\give_money.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\messed_with_me.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\invaded_my_stuff.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\catalog.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\catalog.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\killmap.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\killmap.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\statistics.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\suicide.paa'/>",
			"<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\id.paa'/>"
		];
		BRPVP_menuOpcoes = [
			localize "str_clisv_save_and_exit",
			localize "str_menu30_opt0",
			localize "str_menu30_see_rules",
			localize "str_links_opt",
			localize "str_menu_see_xp",
			localize "str_show_players_on_off",
			localize "str_show_map_icons_on_off",
			localize "str_see_brpvpid",
			format [localize "str_select_srun",BRPVP_superRunSpeedSelected],
			format [localize "str_double_smoke_speed",[str round (BRPVP_doubleSmokeSpeed*100)+"%","Off"] select (BRPVP_doubleSmokeSpeed isEqualTo 1.25)],
			localize "str_my_store_items",
			format [localize "str_crosshair",["   ","X"] select BRPVP_crosshairOn],
			localize "str_commands",
			localize "str_configure_path",
			localize "str_online_admins_list",
			localize "str_menu30_opt13",
			localize "str_menu30_opt25",
			localize "str_set_hotkeys",
			localize "str_xp_perks_weather_predict",
			localize "str_menu30_show_c4_on_3d",
			localize "str_show_newers",
			format [localize "str_nature_on_off",["   ","X"] select (environmentEnabled select 0)],
			localize "str_menu30_patrimony",
			localize "str_menu30_opt9",
			localize "str_menu30_from_virtual_garage",
			if (BRPVP_showGoodLootOnMap) then {format [localize "str_menu_show_good_loot","X"]} else {format [localize "str_menu_show_good_loot","   "]},
			localize "str_view_distance",
			format [localize "str_see_buildable_area",if (BRPVP_canBuildPointsOn) then {"X"} else {"   "}],
			localize "str_menu30_opt14",
			localize "str_menu30_opt15",
			localize "str_menu30_kill_contracts",
			localize "str_menu30_opt16",
			localize "str_invaded_my_stuff",
			localize "str_menu30_craft_help",
			localize "str_menu30_opt23",
			if (BRPVP_killMapOn) then {format [localize "str_menu30_killmap","X"]} else {format [localize "str_menu30_killmap","   "]},
			localize "str_menu30_kill_list",
			localize "str_menu30_opt12",
			format [localize "str_menu30_opt8",BRPVP_suicidouTrava],
			localize "str_see_player_names"
		];
		BRPVP_menuExecutaParam = [56,22,28,35,44,42,48,36,50,52,37,53,27,49,33,12,25,54,55,47,45,51,43,8,30,39,24,31,13,14,29,15,32,38,23,40,41,11,7,46];

		//REMOVE NOT POSSIBLE OPTIONS DUE TO LANGUAGE (NOT TRANSLATED TUTORIAL) OR OTHER THINGS
		_remove = [];
		if (!BRPVP_showTutorialFlag) then {_remove pushBack 1;};
		if (!BRPVP_rulesRequireAccept) then {_remove pushBack 2;};
		if (BRPVP_allXpOn) then {_remove pushBack 4;};
		if (!BRPVP_doubleSmokeOn) then {_remove pushBack 9;};
		if (!BRPVP_useStore) then {_remove pushBack 10;};
		_remove sort false;
		{
			BRPVP_menuImagem deleteAt _x;
			BRPVP_menuOpcoes deleteAt _x;
			BRPVP_menuExecutaParam deleteAt _x;
		} forEach _remove;

		BRPVP_menuExecutaFuncao = {
			if (player getVariable ["sok",false] && player call BRPVP_pAlive) then {
				if (_this isEqualTo 56) then {
					if (clientOwner isEqualTo 2) then {
						216 call BRPVP_menuMuda;
					} else {
						"erro" call BRPVP_playSound;
						["This option is not for you!",0] call BRPVP_hint;
					};
				};
				if (_this isEqualTo 55) then {
					if (BRPVP_weatherPredict) then {
						BRPVP_weatherPredictFortClients call BRPVP_weatherPerkMessage;
					} else {
						"erro" call BRPVP_playSound;
						["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\setweather.paa'/><br/>"+format [localize "str_perk_weather_predict","?","?","?"],0,0.45,5,0,0,2517] call BRPVP_fnc_dynamicText;
					};
				};
				if (_this isEqualTo 54) then {214 call BRPVP_menuMuda;};
				if (_this isEqualTo 53) then {
					BRPVP_crosshairOn = !BRPVP_crosshairOn;
					private _cfg = player getVariable "brpvp_player_config";
					_cfg set [5,BRPVP_crosshairOn];
					player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 52) then {
					BRPVP_doubleSmokeSpeed = (BRPVP_doubleSmokeSpeed+0.25) mod 1.5;
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 51) then {
					if (environmentEnabled select 0) then {enableEnvironment false;} else {enableEnvironment true;};
					private _cfg = player getVariable "brpvp_player_config";
					_cfg set [4,environmentEnabled select 0];
					player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 50) then {
					private _alternatives = BRPVP_superRunSpeedsArray select {_x <= BRPVP_superRunSpeed};
					private _idxNow = _alternatives find BRPVP_superRunSpeedSelected;
					if (_idxNow isEqualTo -1) then {_idxNow = 0;};
					BRPVP_superRunSpeedSelected = _alternatives select ((_idxNow+1) mod count _alternatives);
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 49) then {198 call BRPVP_menuMuda;};
				if (_this isEqualTo 48) then {197 call BRPVP_menuMuda;};
				if (_this isEqualTo 47) then {192 call BRPVP_menuMuda;};
				if (_this isEqualTo 46) then {185 call BRPVP_menuMuda;};
				if (_this isEqualTo 45) then {167 call BRPVP_menuMuda;};
				if (_this isEqualTo 44) then {161 call BRPVP_menuMuda;};
				if (_this isEqualTo 43) then {148 call BRPVP_menuMuda;};
				if (_this isEqualTo 42) then {139 call BRPVP_menuMuda;};
				if (_this isEqualTo 41) then {135 call BRPVP_menuMuda;};
				if (_this isEqualTo 40) then {
					if (BRPVP_killMapOn) then {
						{deleteMarkerLocal ("KILLMAP1_"+str _forEachIndex);} forEach BRPVP_killMapTable;
						{deleteMarkerLocal ("KILLMAP2_"+str _forEachIndex);} forEach BRPVP_killMapTable;
						//{deleteMarkerLocal ("POSKILL_"+str _forEachIndex);} forEach BRPVP_killMapKillPos;
						BRPVP_killMapOn = false;
					} else {
						{
							if (_x select 2 > 0.05) then {
								private _alpha1 = _x select 2;
								if (_alpha1 <= 0.585) then {
									private _alpha2 = 1-((1-_alpha1*0.5)^2-0.5)/0.5;
									private _args1 = ["KILLMAP1_"+str _forEachIndex,_x select 0,"ColorRed",_x select 1,_alpha2,"Solid","RECTANGLE"];
									_args1 call BRPVP_addLocalIconsAreaNoObj;
								} else {
									private _args1 = ["KILLMAP1_"+str _forEachIndex,_x select 0,"ColorRed",_x select 1,_x select 2,"Solid","RECTANGLE"];
									private _args2 = ["KILLMAP2_"+str _forEachIndex,_x select 0,"ColorRed",_x select 1,_x select 2,"Solid","RECTANGLE"];
									_args1 call BRPVP_addLocalIconsAreaNoObj;
									_args2 call BRPVP_addLocalIconsAreaNoObj;
								};
							};
						} forEach BRPVP_killMapTable;
						openMap true;
						BRPVP_killMapOn = true;
					};
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 39) then {
					if (BRPVP_showGoodLootOnMap) then {
						call BRPVP_showGoodLootOnMapRemove;
					} else {
						call BRPVP_showGoodLootOnMapPut;
						openMap true;
					};
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 38) then {124 call BRPVP_menuMuda;};
				if (_this isEqualTo 37) then {105 spawn BRPVP_menuMuda;};
				if (_this isEqualTo 36) then {[format [localize "str_your_brpvp_id_is",player getVariable "id_bd"],-6] call BRPVP_hint;};
				if (_this isEqualTo 35) then {
					0 spawn BRPVP_linksShow;
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				};
				if (_this isEqualTo 33) then {94 call BRPVP_menuMuda;};
				if (_this isEqualTo 32) then {88 spawn BRPVP_menuMuda;};
				if (_this isEqualTo 31) then {
					if (BRPVP_canBuildPointsOn) then {
						deleteMarkerLocal "BUILDABLE_0";
						{
							_x params ["_places","_extraRadius"];
							_type = _forEachIndex;
							{deleteMarkerLocal ("BUILDABLE_1_"+str _type+"_"+str _forEachIndex);} forEach _places;
						} forEach BRPVP_placesExtraNobuildArea;
						BRPVP_canBuildPointsOn = false;
					} else {
						_sizeHalf = (BRPVP_mapaDimensoes select 0)/2;
						["BUILDABLE_0",[_sizeHalf,_sizeHalf,0],"ColorGreen",_sizeHalf,1,"Solid","RECTANGLE"] call BRPVP_addLocalIconsAreaNoObj;
						{
							_x params ["_places","_extraRadius"];
							_type = _forEachIndex;
							{
								private _pos = _x select 0;
								private _rad = _x select 1;
								private _radFinal = _rad+_extraRadius;
								if (_radFinal > 0) then {["BUILDABLE_1_"+str _type+"_"+str _forEachIndex,_pos,"ColorRed",_radFinal,1] call BRPVP_addLocalIconsAreaNoObj;};
							} forEach _places;
						} forEach BRPVP_placesExtraNobuildArea;
						openMap true;
						BRPVP_canBuildPointsOn = true;
					};
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 30 && isNull BRPVP_vgCheckVehicle) then {
					BRPVP_myVirtualGarageOptions = nil;
					188 spawn BRPVP_menuMuda;
				};
				if (_this isEqualTo 29) then {79 call BRPVP_menuMuda;};
				if (_this isEqualTo 28) then {
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					false spawn BRPVP_seeRules;
				};
				if (_this isEqualTo 22) then {
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					false spawn BRPVP_showTutorial;
				};
				if (_this isEqualTo 24) then {91 call BRPVP_menuMuda;};
				if (_this isEqualTo 7) then {
					BRPVP_suicidouTrava = BRPVP_suicidouTrava-1;
					if (BRPVP_suicidouTrava isEqualTo 0) then {
						if (time-BRPVP_lastSuicideTime > BRPVP_suicideCoolDownTime) then {
							BRPVP_lastSuicideTime = time;
							BRPVP_suicidou = true;
							[["suicidou",1]] call BRPVP_mudaExp;
							BRPVP_diedGun = [handGunWeapon player,handGunItems player,handGunMagazine player];
							[objNull,"Suicide_F"] call BRPVP_pehKilledFakeHandleDamage;
							0 spawn {
								_ini = time;
								waitUntil {(player getVariable "dd") isEqualTo 0 || (time-_ini) > 1};
								player setVariable ["dd",1,true];
							};
							"radarbip" call BRPVP_playSound;
							BRPVP_menuExtraLigado = false;
							hintSilent "";
						} else {
							BRPVP_suicidouTrava = BRPVP_suicidouTrava+1;
							"erro" call BRPVP_playSound;
							[format [localize "str_suicide_need_to_wait",round (300-(time-BRPVP_lastSuicideTime))],-5] call BRPVP_hint;
						};
					} else {
						"radarbip" call BRPVP_playSound;
						30 call BRPVP_menuMuda;
					};
				};
				if (_this isEqualTo 8) then {45 call BRPVP_menuMuda;};
				if (_this isEqualTo 9) then {
					35 call BRPVP_menuMuda;
					[localize "str_scut_special_items",0] call BRPVP_hint;
				};
				if (_this isEqualTo 10) then {6 call BRPVP_menuMuda;};
				if (_this isEqualTo 11) then {7 call BRPVP_menuMuda;};
				if (_this isEqualTo 12) then {0 call BRPVP_menuMuda;};
				if (_this isEqualTo 25) then {64 call BRPVP_menuMuda;};
				if (_this isEqualTo 13) then {44 call BRPVP_menuMuda;};
				if (_this isEqualTo 14) then {
					BRPVP_giveMoneyEndMenu = 30;
					BRPVP_transferType = "mny";
					BRPVP_negativeValues = false;
					BRPVP_giveNoRemove = false;
					BRPVP_maxDistanceToGiveHandMoneyTemp = BRPVP_maxDistanceToGiveHandMoney;
					BRPVP_personalAtm = false;
					32 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 15) then {46 spawn BRPVP_menuMuda;};
				if (_this isEqualTo 16) then {
					[localize "str_scut_3d_marks",10,15,70] call BRPVP_hint;
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 17) then {
					[localize "str_scut_parachute",5,15,70] call BRPVP_hint;
					30 call BRPVP_menuMuda;
				};
				if (_this isEqualTo 18) then {
					[localize "str_scut_fly",10,15,70] call BRPVP_hint;
					30 call BRPVP_menuMuda;				
				};
				if (_this isEqualTo 21) then {48 call BRPVP_menuMuda;};
				if (_this isEqualTo 23) then {52 call BRPVP_menuMuda;};
				if (_this isEqualTo 27) then {
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					0 spawn {
						disableSerialization;

						//PAGE 1
						"hint2" call BRPVP_playSound;
						_txt = if (localize "str_language_using" isEqualTo "russian") then {
							"<t size='1.1'>
								<br/>
								<t color='#FFFF40'>КЛАВИАТУРНЫЕ СОКРАЩЕНИЯ ([ESC] Покинуть данное меню): 1/2</t><br/>
								<t color='#FF4040'>[Alt + v]:</t> Персональный сейф (открыть/закрыть)<br/>
								<t color='#FF4040'>[Alt + i]:</t> Специальные товары (строительные наборы/отмычки)<br/>
								<t color='#FF4040'>[Alt + c]:</t> Похоронить деньги<br/>
								<t color='#FF4040'>[Ctrl + c]:</t> Фарм и Крафт<br/>
								<t color='#FF4040'>Бинокль и [Alt + 1]:</t> Взломать игрока<br/>
								<t color='#FF4040'>[Shift + Space]:</t> Прыжок<br/>
								<t color='#FF4040'>[F1]</t>: Беруши<br/>
								<t color='#FF4040'>[Alt + r]:</t> Перебрать магазины<br/>
								<t color='#FF4040'>[Alt + m]:</t> Схроноискатель (нужен миноискатель)<br/>
								<t color='#FF4040'>[Shift + 2]:</t> Открыть ворота дистанционно<br/>
								<t color='#FF4040'>[u]:</t> Открыть/закрыть технику<br/>
								<t color='#FF4040'>[Shift + h]:</t> Оружие за спину<br/>
								<t color='#FF4040'>[Shift + клик по карте]:</t> Маркер/Направление взгляда при спауне<br/>
								<t color='#FF4040'>[Shift + (F1,F2,F3)]:</t> Маркер<br/>
								<t color='#FF4040'>[Insert]:</t> Показать/скрыть строку статуса<br/>
								<t color='#FF4040'>[b]:</t> Затормозить самолёт<br/>
								<t color='#FF4040'>[Shift + b]:</t> Ускорить самолёт<br/>
								<t color='#FF4040'>[Shift + e]:</t> Взять вещи вблизи/Положить вещи<br/>
								<t color='#FF4040'>[Ctrl + Alt + e]:</t> Подорвать Франта-Мина<br/>
							</t>"
						} else {
							if (localize "str_language_using" isEqualTo "portuguese") then {
								"<t size='1.1'>
									<br/>
									<t color='#FFFF40'>COMANDOS DO TECLADO (ESC PARA SAIR): 1/2</t><br/>
									<t color='#FF4040'>alt + v:</t> Objetos Pessoais<br/>
									<t color='#FF4040'>alt + i:</t> Itens Especiais<br/>
									<t color='#FF4040'>alt + c:</t> Enterrar Dinheiro e Itens<br/>
									<t color='#FF4040'>ctrl + c:</t> Farm and Craft<br/>
									<t color='#FF4040'>binoculos e alt + 1:</t> Hackeia um player<br/>
									<t color='#FF4040'>shift + espaço:</t> Pular<br/>
									<t color='#FF4040'>F1:</t> Tampões de Ouvido<br/>
									<t color='#FF4040'>alt + r:</t> Reempacotar munição<br/>
									<t color='#FF4040'>alt + m:</t> Detector de buraco (requer detector de mina)<br/>
									<t color='#FF4040'>shift + 2:</t> Abrir portão com o controle remoto<br/>
									<t color='#FF4040'>u:</t> Trancar e destrancar veículos privados<br/>
									<t color='#FF4040'>shift + h:</t> Arma nas costas<br/>
									<t color='#FF4040'>shift + click no mapa:</t> Marca de destino/Direção ao Nascer<br/>
									<t color='#FF4040'>shift + (F1,F2,F3):</t> Marca estrategica<br/>
									<t color='#FF4040'>insert:</t> Liga ou desliga barra de status<br/>
									<t color='#FF4040'>b:</t> Freia Jato/Avião na pista<br/>
									<t color='#FF4040'>shift + b:</t> Acelera Jato/Avião na pista<br/>
									<t color='#FF4040'>shift + e:</t> Pega items na mira/Solta items<br/>
									<t color='#FF4040'>ctrl + alt + e:</t> Desarmar mina franta<br/>
								</t>"
							} else {
								if (localize "str_language_using" isEqualTo "Chinesesimp") then {
									"<t size='1.1'>
										<br/>
										<t color='#FFFF40'>键位设置 (ESC 关闭菜单): 1/2</t><br/>
										<t color='#FF4040'>alt + v:</t> 个人保险库（开放和关闭）<br/>
										<t color='#FF4040'>alt + i:</t> 建造基地<br/>
										<t color='#FF4040'>alt + c:</t> 埋钱<br/>
										<t color='#FF4040'>ctrl + c:</t> 挖矿[需要在商人处购买铲子]<br/>
										<t color='#FF4040'>手持望远镜按alt + 1:</t> 黑客技术入侵玩家<br/>
										<t color='#FF4040'>shift + space:</t> 跳跃键<br/>
										<t color='#FF4040'>F1</t>: 耳塞<br/>
										<t color='#FF4040'>alt + r:</t> 重新装填弹药<br/>
										<t color='#FF4040'>alt + m:</t> 扫描地面（需要探雷器）<br/>
										<t color='#FF4040'>shift + 2:</t> 使用遥控器开门<br/>
										<t color='#FF4040'>u:</t> 锁上和解锁私人载具<br/>
										<t color='#FF4040'>shift + h:</t> 收起武器<br/>
										<t color='#FF4040'>shift + 点击地图:</t> 地图标记<br/>
										<t color='#FF4040'>shift + (F1,F2,F3):</t>战略3D标点[你的队友也可以看见]<br/>
										<t color='#FF4040'>insert:</t> 显示或隐藏状态栏<br/>
										<t color='#FF4040'>b:</t> 喷气式飞机紧急制动<br/>
										<t color='#FF4040'>shift + b:</t> 喷气式飞机弹射起飞<br/>
										<t color='#FF4040'>shift + e:</t> 举起地面物品/放下头顶物品<br/>
										<t color='#FF4040'>ctrl + alt + e:</t> 拆除基地地雷<br/>
									</t>"
								} else {
									"<t size='1.1'>
										<br/>
										<t color='#FFFF40'>KEYBOARD COMMANDS (ESC TO LEAVE): 1/2</t><br/>
										<t color='#FF4040'>alt + v:</t> Personal Objects<br/>
										<t color='#FF4040'>alt + i:</t> Special Items<br/>
										<t color='#FF4040'>alt + c:</t> Bury money and items<br/>
										<t color='#FF4040'>ctrl + c:</t> Farm and Craft<br/>
										<t color='#FF4040'>binocular and alt + 1:</t> Hack a player<br/>
										<t color='#FF4040'>shift + space:</t> Jump<br/>
										<t color='#FF4040'>F1</t>: Ear plugs<br/>
										<t color='#FF4040'>alt + r:</t> Repack ammo<br/>
										<t color='#FF4040'>alt + m:</t> Hole detector (need mine detector)<br/>
										<t color='#FF4040'>shift + 2:</t> Open gate with remote control<br/>
										<t color='#FF4040'>u:</t> Lock and unlock private vehicles<br/>
										<t color='#FF4040'>shift + h:</t> Weapon on back<br/>
										<t color='#FF4040'>shift + click on map:</t> Destiny mark/Born Direction<br/>
										<t color='#FF4040'>shift + (F1,F2,F3):</t> Strategic mark<br/>
										<t color='#FF4040'>insert:</t> show or hide status bar<br/>
										<t color='#FF4040'>b:</t> Brake Jet/Plane on ground<br/>
										<t color='#FF4040'>shift + b:</t> Accell Jet/Plane on ground<br/>
										<t color='#FF4040'>shift + e:</t> Get items on sight/Release items<br/>
										<t color='#FF4040'>ctrl + alt + e:</t> Defuse franta mine<br/>
									</t>"
								};
							};
						};
						_display = findDisplay 46 createDisplay "RscDisplayEmpty";
						_text = _display ctrlCreate ["RscStructuredText",-1];
						_text ctrlSetPosition [0,0,1,1];
						_text ctrlSetBackgroundColor [0.25,0.25,0.25,0.9];
						_text ctrlSetStructuredText parseText _txt;
						_text ctrlCommit 0;

						waitUntil {isNull _display};

						//PAGE 2
						"hint2" call BRPVP_playSound;
						_txt = if (localize "str_language_using" isEqualTo "russian") then {
							"<t size='1.1'>
								<br/>
								<t color='#FFFF40'>КЛАВИАТУРНЫЕ СОКРАЩЕНИЯ ([ESC] Покинуть данное меню): 2/2</t><br/>
								<t color='#FF4040'>[1 + (w,a,s,d,2,3)]:</t> Невесомость (при строительстве)<br/>
								<t color='#FF4040'>[backspace]:</t> Немедленно отменить действие телепортации<br/>
								<t color='#FF4040'>[Shift + f] on AI:</t> Сделать базовую турель атакующей ИИ<br/>
								<t color='#FF4040'>[Ctrl + 4]:</t> Информационные Метки (на карте)<br/>
								<t color='#FF4040'>[Shift + www]:</t> Постоянный бег/Нитро-буст<br/>
								<t color='#FF4040'>m on player gear:</t> multi-itens move menu<br/>
								<t color='#FF4040'>F9:</t> Relative Construction (last 2 same objects)<br/>
							</t>"
						} else {
							if (localize "str_language_using" isEqualTo "portuguese") then {
								"<t size='1.1'>
									<br/>
									<t color='#FFFF40'>COMANDOS DO TECLADO (ESC PARA SAIR): 2/2</t><br/>
									<t color='#FF4040'>shift + 1 e (w,a,s,d,2,3):</t> Voar na Base<br/>
									<t color='#FF4040'>backspace:</t> Imediatamente cancela uma ação de teleport<br/>
									<t color='#FF4040'>shift + f no Bot:</t> Faz turreta de base atacar Bot<br/>
									<t color='#FF4040'>ctrl + 4 (no mapa):</t> Marca Informativa<br/>
									<t color='#FF4040'>shift + www:</t> Auto-corrida/Nitro de Veículo<br/>
									<t color='#FF4040'>m no gear do player:</t> menu de movimentação multi-items<br/>
									<t color='#FF4040'>F9:</t> Construção Relativa (últimos 2 objetos iguais)<br/>
								</t>"
							} else {
								if (localize "str_language_using" isEqualTo "Chinesesimp") then {
									"<t size='1.1'>
										<br/>
										<t color='#FFFF40'>键位设置 (ESC 关闭菜单):</t><br/>
										<t color='#FF4040'>shift + 1 激活后按住 (w,a,s,d,2,3): 2/2</t> 基地飞行 <br/>
										<t color='#FF4040'>backspace:</t> 立刻取消远程传送操作<br/>
										<t color='#FF4040'>对Ai按shift + f:</t> 使基地炮塔攻击AI单位<br/>
										<t color='#FF4040'>ctrl + 4 (在地图界面):</t> 标记地图信息<br/>
										<t color='#FF4040'>shift + www:</t> 自动奔跑 / 汽车硝基<br/>
										<t color='#FF4040'>m on player gear:</t> multi-itens move menu<br/>
										<t color='#FF4040'>F9:</t> Relative Construction (last 2 same objects)<br/>
									</t>"
								} else {
									"<t size='1.1'>
										<br/>
										<t color='#FFFF40'>KEYBOARD COMMANDS (ESC TO LEAVE): 2/2</t><br/>
										<t color='#FF4040'>shift + 1 then (w,a,s,d,2,3):</t> Base Fly<br/>
										<t color='#FF4040'>backspace:</t> Immediately cancel a teleport action<br/>
										<t color='#FF4040'>shift + f on AI:</t> Make base turret attack AI Unit<br/>
										<t color='#FF4040'>ctrl + 4 (on map):</t> Informative Mark<br/>
										<t color='#FF4040'>shift + www:</t> Auto-run/Vehicle Nitro<br/>
										<t color='#FF4040'>m on player gear:</t> multi-itens move menu<br/>
										<t color='#FF4040'>F9:</t> Relative Construction (last 2 same objects)<br/>
									</t>"
								};
							};
						};
						_display = findDisplay 46 createDisplay "RscDisplayEmpty";
						_text = _display ctrlCreate ["RscStructuredText",-1];
						_text ctrlSetPosition [0,0,1,1];
						_text ctrlSetBackgroundColor [0.25,0.25,0.25,0.9];
						_text ctrlSetStructuredText parseText _txt;
						_text ctrlCommit 0;
					};
				};
			} else {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 31
	{
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuOpcoes = [];
		BRPVP_menuImagem = [];
		BRPVP_menuVal = [];
		_txt = "<t size='2.0' color='#FFFF33' align='center'>" + localize "str_price" + " $ %1</t><br/><img size='3.0' align='center' image='%2'/>";
		{
			private ["_imagem","_nomeBonito"];
			_it = if (_x isEqualType []) then {_x select 0} else {_x};
			_idc = BRPVP_specialItems find _it;
			if (_idc >= 0) then {
				_imagem = BRPVP_imagePrefix+(BRPVP_specialItemsImages select _idc);
				_nomeBonito = BRPVP_specialItemsNames select _idc;
			} else {
				_imagem = BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa";
				_nomeBonito = "ITEM ?";
				_isM = isClass (configFile >> "CfgMagazines" >> _it);
				if (_isM) then {
					_imagem = getText (configFile >> "CfgMagazines" >> _it >> "picture");
					_nomeBonito = getText (configFile >> "CfgMagazines" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
				} else {
					_isW = isClass (configFile >> "CfgWeapons" >> _it);
					if (_isW) then {
						_imagem = getText (configFile >> "CfgWeapons" >> _it >> "picture");
						_nomeBonito = getText (configFile >> "CfgWeapons" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
					} else {
						_isV = isClass (configFile >> "CfgVehicles" >> _it);
						if (_isV) then {
							_imagem = getText (configFile >> "CfgVehicles" >> _it >> "picture");
							_nomeBonito = getText (configFile >> "CfgVehicles" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
						} else {
							_isG = isClass (configFile >> "CfgGlasses" >> _it);
							if (_isG) then {
								_imagem = getText (configFile >> "CfgGlasses" >> _it >> "picture");
								_nomeBonito = getText (configFile >> "CfgGlasses" >> _it >> "displayName") call BRPVP_escapeForStructuredTextFast;
							};
						};
					};
				};
			};
			_preco = BRPVP_compraItensPrecos select _forEachIndex;
			BRPVP_menuOpcoes pushBack _nomeBonito;
			BRPVP_menuImagem pushBack format[_txt,round _preco,_imagem];
			BRPVP_menuVal pushBack [_forEachIndex,_preco];
		} forEach BRPVP_compraItensTotal;
		BRPVP_menuDestino = 31;
		BRPVP_menuCodigo = {
			_idc = BRPVP_menuVal select BRPVP_menuOpcoesSel select 0;
			_preco = BRPVP_menuVal select BRPVP_menuOpcoesSel select 1;
			BRPVP_compraPrecoTotal = BRPVP_compraPrecoTotal - _preco;
			BRPVP_compraItensTotal deleteAt _idc;
			BRPVP_compraItensPrecos deleteAt _idc;
			"granted" call BRPVP_playSound;
		};
		BRPVP_menuVoltar = {12 call BRPVP_menuMuda;};
	},
	
	//MENU 32
	{
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/> <img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 33;
		BRPVP_maxDistanceToGiveHandMoneyTemp call BRPVP_pegaListaPlayersNear;
		if (BRPVP_giveNoRemove) then {
			_id_bd = player getVariable ["id_bd",-1];
			BRPVP_menuOpcoes pushBack (str _id_bd+" - "+name player);
			BRPVP_menuExecutaParam pushBack player;
		};
		BRPVP_menuExecutaParam = BRPVP_menuExecutaParam apply {_x getVariable ["id_bd",-1]};
		BRPVP_menuCodigo = {
			_id = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_player = objNull;
			{if ((_x getVariable ["id_bd",-2]) isEqualTo _id && _x call BRPVP_isPlayer) exitWith {_player = _x;};} forEach call BRPVP_playersList;
			BRPVP_menuVar1 = _player;
			BRPVP_menuVar2 = 0;
			BRPVP_menuVarRate = 0;
		};
		BRPVP_menuVoltar = {BRPVP_giveMoneyEndMenu call BRPVP_menuMuda;};
	},

	//MENU 33
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/> <img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuForceExit = {
			_true = isNull BRPVP_menuVar1 || !(BRPVP_menuVar1 call BRPVP_isPlayer);
			if (_true) then {[localize "str_player_cant_find",0] call BRPVP_hint;};
			_true
		};
		if (BRPVP_negativeValues) then {
			BRPVP_menuOpcoes = [
				"+ 1000 $",
				"+ 10000 $",
				"+ 100000 $",
				"+ 500000 $",
				"+ 1000000 $",
				"- 1000 $",
				"- 10000 $",
				"- 100000 $",
				"- 500000 $",
				"- 1000000 $",
				localize "str_back_to"+" 0 $",
				localize "str_atm_conclude"
			];
			BRPVP_menuExecutaParam = [1000,10000,100000,500000,1000000,-1000,-10000,-100000,-500000,-1000000,0,"conclude"];
		} else {
			BRPVP_menuOpcoes = [
				"+ 1000 $",
				"+ 10000 $",
				"+ 100000 $",
				"+ 500000 $",
				"+ 1000000 $",
				localize "str_back_to"+" 0 $",
				localize "str_atm_conclude"
			];
			BRPVP_menuExecutaParam = [1000,10000,100000,500000,1000000,0,"conclude"];
		};
		BRPVP_menuExecutaFuncao = {
			_personalAtmRate = if (BRPVP_personalAtm) then {BRPVP_personalAtmRate} else {0};
			if (_this isEqualType 0) then {
				if (_this isEqualTo 0) then {
					BRPVP_menuVar2 = 0;
					BRPVP_menuVar2Rate = 0;
				} else {
					private ["_newAmount"];
					_myMax = if (BRPVP_giveNoRemove) then {1000000000000} else {player getVariable BRPVP_transferType;};
					if (BRPVP_transferType isEqualTo "brpvp_mny_bank") then {
						_pMaxInBank = BRPVP_menuVar1 getVariable ["brpvp_max_in_bank",0];
						_pValInBank = BRPVP_menuVar1 getVariable ["brpvp_mny_bank",0];
						_newAmount = ((BRPVP_menuVar2+_this) min _myMax) min ((_pMaxInBank-_pValInBank) max 0);
					} else {
						_newAmount = (BRPVP_menuVar2+_this) min _myMax;
					};
					_newAmountPlusRate = _newAmount*(1+_personalAtmRate);
					if (_newAmountPlusRate > _myMax) then {
						BRPVP_menuVar2 = round (_myMax/(1+_personalAtmRate));
						BRPVP_menuVar2Rate = _myMax-BRPVP_menuVar2;
					} else {
						BRPVP_menuVar2 = _newAmount;
						BRPVP_menuVar2Rate = _newAmountPlusRate-_newAmount;
					};
				};
				33 call BRPVP_menuMuda;
			} else {
				if (_this isEqualTo "conclude") then {
					_cases = [];
					{
						if (_x call BRPVP_pAlive && _x getVariable ["sok",false] && _x getVariable ["id_bd",-1] >= 0 && _x getVariable "dd" isEqualTo -1 && _x distance player <= BRPVP_maxDistanceToGiveHandMoneyTemp) then {_cases pushBack _x;};
					} forEach ((call BRPVP_playersList)-([[player],[]] select BRPVP_giveNoRemove));
					if (BRPVP_menuVar1 in _cases && BRPVP_menuVar2 isNotEqualTo 0) exitWith {
						_personalAtmRate = if (BRPVP_personalAtm) then {BRPVP_personalAtmRate} else {0};

						private ["_newAmount","_tt"];
						_myMax = if (BRPVP_giveNoRemove) then {1000000000000} else {player getVariable BRPVP_transferType;};
						if (BRPVP_transferType isEqualTo "brpvp_mny_bank") then {
							_pMaxInBank = BRPVP_menuVar1 getVariable ["brpvp_max_in_bank",0];
							_pValInBank = BRPVP_menuVar1 getVariable ["brpvp_mny_bank",0];
							_newAmount = (BRPVP_menuVar2 min _myMax) min ((_pMaxInBank-_pValInBank) max 0);
							_tt = "bank";
						} else {
							_newAmount = BRPVP_menuVar2 min _myMax;
							_tt = "hand";
						};
						_newAmountPlusRate = _newAmount*(1+_personalAtmRate);
						if (_newAmountPlusRate > _myMax) then {
							BRPVP_menuVar2 = round (_myMax/(1+_personalAtmRate));
							BRPVP_menuVar2Rate = _myMax-BRPVP_menuVar2;
						} else {
							BRPVP_menuVar2 = _newAmount;
							BRPVP_menuVar2Rate = _newAmountPlusRate-_newAmount;
						};

						if (!BRPVP_giveNoRemove) then {player setVariable [BRPVP_transferType,_myMax-(BRPVP_menuVar2+BRPVP_menuVar2Rate),true];};
						[BRPVP_menuVar1,BRPVP_menuVar2,BRPVP_transferType] remoteExecCall ["BRPVP_giveMoneySV",2];
						if (BRPVP_isAdminOrModerator) then {[player getVariable "id_bd",player getVariable "nm","Give money "+_tt,BRPVP_menuVar2,BRPVP_menuVar1 getVariable "id_bd",BRPVP_menuVar1 getVariable "nm"] remoteExecCall ["BRPVP_adminAddLog",2];};
						if (BRPVP_menuVar1 isNotEqualTo player) then {"negocio" call BRPVP_playSound;};
						32 call BRPVP_menuMuda;						
					};
					if (BRPVP_menuVar1 in _cases && BRPVP_menuVar2 isEqualTo 0) exitWith {32 call BRPVP_menuMuda;};
					if (!(BRPVP_menuVar1 in _cases) && _cases isNotEqualTo []) exitWith {"erro" call BRPVP_playSound;32 call BRPVP_menuMuda;};
					if (!(BRPVP_menuVar1 in _cases) && _cases isEqualTo []) exitWith {"erro" call BRPVP_playSound;BRPVP_giveMoneyEndMenu call BRPVP_menuMuda;};
				};
			};
		};
		BRPVP_menuVoltar = {
			_cases = [];
			{
				if (_x call BRPVP_pAlive && _x getVariable ["sok",false] && _x getVariable ["id_bd",-1] >= 0 && _x getVariable "dd" isEqualTo -1 && _x distance player <= BRPVP_maxDistanceToGiveHandMoneyTemp) then {_cases pushBack _x;};
			} forEach ((call BRPVP_playersList)-([[player],[]] select BRPVP_giveNoRemove));
			if (BRPVP_menuVar1 in _cases && BRPVP_menuVar2 isNotEqualTo 0) exitWith {34 call BRPVP_menuMuda;};
			if (BRPVP_menuVar1 in _cases && BRPVP_menuVar2 isEqualTo 0) exitWith {32 call BRPVP_menuMuda;};
			if (!(BRPVP_menuVar1 in _cases) && _cases isNotEqualTo []) exitWith {"erro" call BRPVP_playSound;32 call BRPVP_menuMuda;};
			if (!(BRPVP_menuVar1 in _cases) && _cases isEqualTo []) exitWith {"erro" call BRPVP_playSound;BRPVP_giveMoneyEndMenu call BRPVP_menuMuda;};
		};
	},
	
	//MENU 34
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuForceExit = {
			_true = isNull BRPVP_menuVar1 || !(BRPVP_menuVar1 call BRPVP_isPlayer);
			if (_true) then {[localize "str_player_cant_find",0] call BRPVP_hint;};
			_true
		};
		BRPVP_menuOpcoes = [localize "str_menu34_opt0",localize "str_menu34_opt1"];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			_cases = [];
			{
				if (_x call BRPVP_pAlive && _x getVariable ["sok",false] && _x getVariable ["id_bd",-1] >= 0 && _x getVariable "dd" isEqualTo -1 && _x distance player <= BRPVP_maxDistanceToGiveHandMoneyTemp) then {_cases pushBack _x;};
			} forEach ((call BRPVP_playersList)-([[player],[]] select BRPVP_giveNoRemove));
			if (_this isEqualTo 0 && BRPVP_menuVar1 in _cases) then {
				_personalAtmRate = if (BRPVP_personalAtm) then {BRPVP_personalAtmRate} else {0};

				private ["_newAmount","_tt"];
				_myMax = if (BRPVP_giveNoRemove) then {1000000000000} else {player getVariable BRPVP_transferType;};
				if (BRPVP_transferType isEqualTo "brpvp_mny_bank") then {
					_pMaxInBank = BRPVP_menuVar1 getVariable ["brpvp_max_in_bank",0];
					_pValInBank = BRPVP_menuVar1 getVariable ["brpvp_mny_bank",0];
					_newAmount = (BRPVP_menuVar2 min _myMax) min ((_pMaxInBank-_pValInBank) max 0);
					_tt = "bank";
				} else {
					_newAmount = BRPVP_menuVar2 min _myMax;
					_tt = "hand";
				};
				_newAmountPlusRate = _newAmount*(1+_personalAtmRate);
				if (_newAmountPlusRate > _myMax) then {
					BRPVP_menuVar2 = round (_myMax/(1+_personalAtmRate));
					BRPVP_menuVar2Rate = _myMax-BRPVP_menuVar2;
				} else {
					BRPVP_menuVar2 = _newAmount;
					BRPVP_menuVar2Rate = _newAmountPlusRate-_newAmount;
				};

				if (!BRPVP_giveNoRemove) then {player setVariable [BRPVP_transferType,_myMax-(BRPVP_menuVar2+BRPVP_menuVar2Rate),true];};
				[BRPVP_menuVar1,BRPVP_menuVar2,BRPVP_transferType] remoteExecCall ["BRPVP_giveMoneySV",2];
				if (BRPVP_isAdminOrModerator) then {
					[player getVariable "id_bd",player getVariable "nm","Give money "+_tt,BRPVP_menuVar2,BRPVP_menuVar1 getVariable "id_bd",BRPVP_menuVar1 getVariable "nm"] remoteExecCall ["BRPVP_adminAddLog",2];
				} else {
					[player getVariable "id_bd",player getVariable "nm","Give money "+_tt,BRPVP_menuVar2,BRPVP_menuVar1 getVariable "id_bd",BRPVP_menuVar1 getVariable "nm"] remoteExecCall ["BRPVP_playerAddLog",2];
				};
				if (BRPVP_menuVar1 isNotEqualTo player) then {"negocio" call BRPVP_playSound;};
				32 call BRPVP_menuMuda;
			} else {
				if (_this isEqualTo 0) then {"erro" call BRPVP_playSound;};
				if (count _cases > 0) then {32 call BRPVP_menuMuda;} else {BRPVP_giveMoneyEndMenu call BRPVP_menuMuda;};
			};
			
		};
		BRPVP_menuVoltar = {33 call BRPVP_menuMuda;};
	},
	
	//MENU 35
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = BRPVP_specialItemsGroup arrayIntersect BRPVP_specialItemsGroup;
		BRPVP_menuExecutaParam = BRPVP_menuOpcoes apply {76};
		BRPVP_menuOpcoes pushBack localize "str_alt_i_give_item";
		BRPVP_menuExecutaParam pushBack 126;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
			_this call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},
	
	//MENU 36
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\daytime.paa'/>";
		BRPVP_menuOpcoes = [
			"00:00",
			"01:00",
			"02:00",
			"03:00",
			"04:00",
			"05:00",
			"06:00",
			"07:00",
			"08:00",
			"09:00",
			"10:00",
			"11:00",
			"12:00",
			"13:00",
			"14:00",
			"15:00",
			"16:00",
			"17:00",
			"18:00",
			"19:00",
			"20:00",
			"21:00",
			"22:00",
			"23:00"
		];
		BRPVP_menuExecutaParam = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			37 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			29 call BRPVP_menuMuda;
		};
	},
	
	//MENU 37
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [
			str BRPVP_menuVar1 + ":00",
			str BRPVP_menuVar1 + ":05",
			str BRPVP_menuVar1 + ":10",
			str BRPVP_menuVar1 + ":15",
			str BRPVP_menuVar1 + ":20",
			str BRPVP_menuVar1 + ":25",
			str BRPVP_menuVar1 + ":30",
			str BRPVP_menuVar1 + ":35",
			str BRPVP_menuVar1 + ":40",
			str BRPVP_menuVar1 + ":45",
			str BRPVP_menuVar1 + ":50",
			str BRPVP_menuVar1 + ":55"
		];
		BRPVP_menuExecutaParam = [0,5,10,15,20,25,30,35,40,45,50,55];
		BRPVP_menuExecutaFuncao = {
			_date = date;
			_date set [3,BRPVP_menuVar1];
			_date set [4,_this];
			_date remoteExecCall ["BRPVP_setDateSV",2];
			29 call BRPVP_menuMuda;
		};
	},
	
	//MENU 38
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\timemultiplier.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_a_day_in" + " 24h",
			localize "str_a_day_in" + " 12h",
			localize "str_a_day_in" + " 08h",
			localize "str_a_day_in" + " 06h",
			localize "str_a_day_in" + " 04h",
			localize "str_a_day_in" + " 03h",
			localize "str_a_day_in" + " 02h",
			localize "str_a_day_in" + " 01h",
			localize "str_a_day_in" + " 30m"
		];
		BRPVP_menuExecutaParam = [1,2,3,4,6,8,12,24,48];
		BRPVP_menuExecutaFuncao = {
			_this remoteExecCall ["BRPVP_setTimeMultiplierSV",2];
			29 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			29 call BRPVP_menuMuda;
		};
	},
	
	//MENU 39
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\setweather.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_clouds" + " 0%",
			localize "str_clouds" + " 20%",
			localize "str_clouds" + " 40%",
			localize "str_clouds" + " 60% " + localize "str_can_rain",
			localize "str_clouds" + " 80% " + localize "str_can_rain",
			localize "str_clouds" + " 100% " + localize "str_can_rain"
		];
		BRPVP_menuExecutaParam = [0,0.2,0.4,0.6,0.8,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = [_this];
			BRPVP_menuVar2 = [];
			if (BRPVP_menuVar1 select 0 >= 0.6) then {
				40 call BRPVP_menuMuda;
			} else {
				BRPVP_menuVar2 pushBack 0;
				41 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 40
	{
		BRPVP_menuOpcoes = [
			localize "str_rain" + " 0%",
			localize "str_rain" + " 20%",
			localize "str_rain" + " 40%",
			localize "str_rain" + " 60%",
			localize "str_rain" + " 80%",
			localize "str_rain" + " 100%"
		];
		BRPVP_menuExecutaParam = [0,0.2,0.4,0.6,0.8,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 pushBack _this;
			41 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {39 call BRPVP_menuMuda;};
	},
	
	//MENU 41
	{
		BRPVP_menuOpcoes = [
			localize "str_wind" + " 0 " + localize "str_speed_ms",
			localize "str_wind" + " 1 " + localize "str_speed_ms",
			localize "str_wind" + " 3 " + localize "str_speed_ms",
			localize "str_wind" + " 5 " + localize "str_speed_ms",
			localize "str_wind" + " 7 " + localize "str_speed_ms",
			localize "str_wind" + " 10 " + localize "str_speed_ms",
			localize "str_wind" + " 15 " + localize "str_speed_ms",
			localize "str_wind" + " 20 " + localize "str_speed_ms"
		];
		BRPVP_menuExecutaParam = [0,1,3,5,7,10,15,20];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 pushBack [_this,getDir player];
			42 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			if (BRPVP_menuVar1 select 0 >= 0.6) then {
				40 call BRPVP_menuMuda;
			} else {
				39 call BRPVP_menuMuda;
			};
		};
	},
	
	//MENU 42
	{
		BRPVP_menuOpcoes = [
			localize "str_guts" + " 0%",
			localize "str_guts" + " 20%",
			localize "str_guts" + " 40%",
			localize "str_guts" + " 60%",
			localize "str_guts" + " 80%",
			localize "str_guts" + " 100%"
		];
		BRPVP_menuExecutaParam = [0,0.2,0.4,0.6,0.8,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 pushBack _this;
			[BRPVP_menuVar1,BRPVP_menuVar2] remoteExecCall ["BRPVP_setWeatherServer",2];
			29 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {41 call BRPVP_menuMuda;};
	},
	
	//MENU 43
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersOriginalAlive;
		BRPVP_menuOpcoes = [format [localize "str_spectate_limit_vd",["   ","X"] select BRPVP_spectUseMyViewDistance]]+BRPVP_menuOpcoes;
		BRPVP_menuExecutaParam = ["limit_vd"]+BRPVP_menuExecutaParam;
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "limit_vd") then {
				BRPVP_spectUseMyViewDistance = !BRPVP_spectUseMyViewDistance;
				43 call BRPVP_menuMuda;
			} else {
				_this call BRPVP_spectateFnc;
			};
		};
	},

	//MENU 44
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersOriginalAlive;
		_delete = [];
		{if !(_x call BRPVP_checaAcesso) then {_delete pushBack _forEachIndex;};} forEach BRPVP_menuExecutaParam;
		_delete sort false;
		{
			BRPVP_menuOpcoes deleteAt _x;
			BRPVP_menuExecutaParam deleteAt _x;
		} forEach _delete;
		BRPVP_menuOpcoes = [format [localize "str_spectate_limit_vd",["   ","X"] select BRPVP_spectUseMyViewDistance]]+BRPVP_menuOpcoes;
		BRPVP_menuExecutaParam = ["limit_vd"]+BRPVP_menuExecutaParam;
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "limit_vd") then {
				BRPVP_spectUseMyViewDistance = !BRPVP_spectUseMyViewDistance;
				44 call BRPVP_menuMuda;
			} else {
				_this call BRPVP_spectateFnc;
			};
		};
	},

	//MENU 45
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = [
			localize "str_expo_wit",
			localize "str_expo_witr",
			localize "str_expo_everyone",
			localize "str_expo_om"
		];
		BRPVP_menuExecutaParam = [1,2,3,4];
		BRPVP_menuPosForce = (player getVariable ["stp",1])-1;
		BRPVP_menuExecutaFuncao = {
			if (_this != player getVariable ["stp",-1]) then {
				_accessChanged = (call BRPVP_playersList)-[player];
				_accessChanged = _accessChanged apply {[_x,[_x,player] call BRPVP_checaAcessoRemoto]};
				_needToUpdate = [];
				player setVariable ["stp",_this,true];
				{
					_x params ["_unit","_accessBefore"];
					if !(([_unit,player] call BRPVP_checaAcessoRemoto) isEqualTo _accessBefore) then {
						_needToUpdate pushBack _unit;
					};
				} forEach _accessChanged;
				[_needToUpdate,player getVariable ["id","0"],_this] remoteExecCall ["BRPVP_askPlayersToUpdateFriendsServer",2];
				call BRPVP_daUpdateNosAmigos;
				call BRPVP_atualizaDebugMenu;
			};
			"hint" call BRPVP_playSound;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},
	
	//MENU 46
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_askServerForDestructionLogReturn = nil;
		[player,player getVariable "id_bd",BRPVP_vePlayers] remoteExecCall ["BRPVP_askServerForDestructionLog",2];
		waitUntil {!isNil "BRPVP_askServerForDestructionLogReturn"};
		BRPVP_askServerForDestructionLogReturn = (call compile BRPVP_askServerForDestructionLogReturn) select 1;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_row = _x;
			_vehicle = str (_forEachIndex + 1) + " - @memory_remove_back@" + (_row select 4);
			BRPVP_menuOpcoes pushBack _vehicle;
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_askServerForDestructionLogReturn;
		BRPVP_menuExecutaFuncao = {
			_row = BRPVP_askServerForDestructionLogReturn select _this;
			_owner = _row select 0;
			_ownerName = _row select 1;
			_id_bd = _row select 2;
			_okCrew = _row select 3;
			_vehicle = _row select 4;
			_class = _row select 5;
			_date = _row select 6;
			_dateTxt = str (_date select 0) + "/" + str (_date select 1) + "/" + str (_date select 2) + " " + str (_date select 3) + ":" + str (_date select 4);
			_price = -1;
			{
				if (_x select 3 == _class) exitWith {
					_price = (_x select 5) * BRPVP_marketPricesMultiply;
				};
			} forEach BRPVP_tudoA3;
			if (_price isEqualTo -1) then {
				{
					_kitTxt = _x;
					_kitTxtArray = call compile _kitTxt;
					if (_class in _kitTxtArray) exitWith {
						{
							if (_x select 3 == _kitTxt) exitWith {
								_price = (_x select 4) * (BRPVP_mercadoPrecos select (_x select 0));
							};
						} forEach BRPVP_mercadoItens;
					};
				} forEach BRPVP_specialItems;
			};
			_priceTxt = "";
			if (_price != -1) then {
				_priceTxt = "\n" + (localize "str_price") + " > $ " + (_price call BRPVP_formatNumber);
			};
			_ownerData = localize "str_public";
			if (_owner != -1) then {
				_ownerData = str _owner + " - " + _ownerName;
			};
			[format [localize "str_ofenders_show",_dateTxt,_ownerData,_vehicle,_priceTxt,_okCrew],-20] call BRPVP_hint;
			"hint" call BRPVP_playSound;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},
	
	//MENU 47
	{
	},

	//MENU 48
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#AAAAAA";
		_BRPVP_hintHistoricShow = + BRPVP_hintHistoricShow;
		reverse _BRPVP_hintHistoricShow;
		BRPVP_menuOpcoes = _BRPVP_hintHistoricShow;
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 49
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\fedidex.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_menu49_opt0",
			localize "str_menu49_opt1"
		];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			_pm = if (BRPVP_vePlayers) then {0} else {1};
			if (_this isEqualTo 0) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				BRPVP_itemTraderDiscount = 1.15;
				_pm spawn {
					private _pm = _this;
					uiSleep 0.001;
					[0,0,0,[player,[1,2,3,4,7,10],_pm,1,"fedidex"]] execVm "client_code\actions\actionTrader.sqf";
				};
			};
			if (_this isEqualTo 1) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				_pm spawn {
					private _pm = _this;
					uiSleep 0.001;
					[0,0,0,[player,["FEDIDEX"],_pm,"fedidex",false,49]] execVm "client_code\actions\actionVehicleTrader.sqf";
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},
	
	//MENU 50
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 51;
		BRPVP_menuCodigo = {
			BRPVP_menuVar1 = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
		BRPVP_menuOpcoes = BRPVP_buildAdminGroups;
	},
	
	//MENU 51
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 3; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO | 3 - CODE
		BRPVP_menuImagem = {
			if (isNull findDisplay 13838) then {
				createDialog "AdmBuild";
				0 spawn {
					BRPVP_modelRotateAngle = 0;
					_init = time;
					while {!isNull findDisplay 13838} do {
						_vd1 = [sin BRPVP_modelRotateAngle,cos BRPVP_modelRotateAngle,0.5 * sin (BRPVP_modelRotateAngle + 90)];
						_vd2 = [sin (BRPVP_modelRotateAngle + 90),cos (BRPVP_modelRotateAngle + 90),0.5 * sin (BRPVP_modelRotateAngle + 180)];
						_vu = _vd2 vectorCrossProduct _vd1;
						((findDisplay 13838) displayCtrl 83831) ctrlSetModelDirAndUp [_vd1,_vu];
						_time = time;
						_delta = _time - _init;
						_init = _time;
						BRPVP_modelRotateAngle = (BRPVP_modelRotateAngle+360*_delta/4) mod 360;
						sleep 0.001;
					};
				};
			};
			_menuParam = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_isClass = isClass (configFile >> "CfgVehicles" >> _menuParam);
			_newModel = if (_isClass) then {getText (configFile >> "CfgVehicles" >> _menuParam >> "model")} else {_menuParam};
			if (ctrlModel ((findDisplay 13838) displayCtrl 83831) != _newModel) then {
				_object = createSimpleObject [_menuParam,BRPVP_posicaoFora,true];
				_bb = boundingBoxReal _object;
				_sizeOf = (_bb select 0) distance (_bb select 1);
				_sizeOf = _sizeOf max (if (_isClass) then {4} else {15});
				_scale = (1/_sizeOf)^(0.9);
				deleteVehicle _object;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale 0.001;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModel _newModel;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale _scale;
			};
		};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if ((_x select 0) isEqualTo BRPVP_menuVar1) then {
				_class = _x select 1;
				_isBuilding = _class isKindOf ["Building",configFile >> "CfgVehicles"];
				_isWall = _class isKindOf ["Wall",configFile >> "CfgVehicles"];
				_isWreck = _class isKindOf ["Wreck",configFile >> "CfgVehicles"];
				_isStatic = _class isKindOf ["Static",configFile >> "CfgVehicles"];
				_isThing = _class isKindOf ["Thing",configFile >> "CfgVehicles"];
				_isNature = !isClass (configFile >> "CfgVehicles" >> _class);
				if (_isBuilding || _isWall || _isWreck || _isStatic || _isThing || _isNature) then {
					BRPVP_menuOpcoes pushBack (if (_isNature) then {_class call BRPVP_getLastAfterSlash} else {getText (configFile >> "CfgVehicles" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast});
					BRPVP_menuExecutaParam pushBack _class;
				};
			};
		} forEach BRPVP_buildAdminClasses;
		BRPVP_menuExecutaFuncao = {
			closeDialog 13838;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			[[_this],"",-1,true] call BRPVP_construir;
		};
		BRPVP_menuVoltar = {
			closeDialog 13838;
			50 call BRPVP_menuMuda;
		};
	},

	//MENU 52
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if (BRPVP_specialItemsGroup select _forEachIndex isEqualTo localize "str_spec_itm_group_cons") then {
				BRPVP_menuOpcoes pushBack _x;
				BRPVP_menuExecutaParam pushBack _forEachIndex;
			};
		} forEach BRPVP_specialItemsNames;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = BRPVP_specialItems select _this;
			53 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 53
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 3; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO | 3 - CODE
		BRPVP_menuImagem = {
			if (isNull findDisplay 13838) then {
				createDialog "AdmBuild";
				0 spawn {
					BRPVP_modelRotateAngle = 0;
					_init = time;
					while {!isNull findDisplay 13838} do {
						_vd1 = [sin BRPVP_modelRotateAngle,cos BRPVP_modelRotateAngle,0.5 * sin (BRPVP_modelRotateAngle + 90)];
						_vd2 = [sin (BRPVP_modelRotateAngle + 90),cos (BRPVP_modelRotateAngle + 90),0.5 * sin (BRPVP_modelRotateAngle + 180)];
						_vu = _vd2 vectorCrossProduct _vd1;
						((findDisplay 13838) displayCtrl 83831) ctrlSetModelDirAndUp [_vd1,_vu];
						_time = time;
						_delta = _time - _init;
						_init = _time;
						BRPVP_modelRotateAngle = (BRPVP_modelRotateAngle+360*_delta/4) mod 360;
						sleep 0.001;
					};
				};
			};
			_menuParam = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_isClass = isClass (configFile >> "CfgVehicles" >> _menuParam);
			_newModel = if (_isClass) then {getText (configFile >> "CfgVehicles" >> _menuParam >> "model")} else {_menuParam};
			if (ctrlModel ((findDisplay 13838) displayCtrl 83831) != _newModel) then {
				_object = createSimpleObject [_menuParam,BRPVP_posicaoFora,true];
				_bb = boundingBoxReal _object;
				_sizeOf = (_bb select 0) distance (_bb select 1);
				_sizeOf = _sizeOf max (if (_isClass) then {4} else {15});
				_scale = (1/_sizeOf)^(0.9);
				deleteVehicle _object;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale 0.001;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModel _newModel;
				((findDisplay 13838) displayCtrl 83831) ctrlSetModelScale _scale;
			};
		};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_class = _x;
			BRPVP_menuOpcoes pushBack (if (isClass (configFile >> "CfgVehicles" >> _class)) then {getText (configFile >> "CfgVehicles" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast} else {_class call BRPVP_getLastAfterSlash});
			BRPVP_menuExecutaParam pushBack _class;
		} forEach (call compile BRPVP_menuVar1);
		BRPVP_menuExecutaFuncao = {};
		BRPVP_menuVoltar = {
			closeDialog 13838;
			52 call BRPVP_menuMuda;
		};
	},
	
	//MENU 54
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_atmAmount = 0;
		BRPVP_atmAmountRate = 0;
		BRPVP_menuOpcoes = [
			localize "str_atm_deposit",
			localize "str_atm_withdraw",
			localize "str_atm_transfer"
		];
		BRPVP_menuExecutaParam = [0,1,2];
		BRPVP_menuExecutaFuncao = {
			if (player getVariable ["sok",false] && player call BRPVP_pAlive) then {
				if (_this isEqualTo 0) then {55 call BRPVP_menuMuda;};
				if (_this isEqualTo 1) then {56 call BRPVP_menuMuda;};
				if (_this isEqualTo 2) then {
					BRPVP_giveMoneyEndMenu = 54;
					BRPVP_transferType = "brpvp_mny_bank";
					BRPVP_negativeValues = false;
					BRPVP_giveNoRemove = false;
					BRPVP_maxDistanceToGiveHandMoneyTemp = 1000000;
					//BRPVP_personalAtm = true;
					32 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			BRPVP_actionRunning = BRPVP_actionRunning - [14];
		};
	},
	
	//MENU 55
	{
		BRPVP_menuOpcoes = [
			"+ 1000 $",
			"+ 10000 $",
			"+ 100000 $",
			"+ 500000 $",
			"+ 1000000 $",
			localize "str_atm_all",
			localize "str_atm_remove",
			localize "str_atm_conclude"
		];
		BRPVP_menuExecutaParam = [1000,10000,100000,500000,1000000,"all","remove","conclude"];
		BRPVP_menuExecutaFuncao = {
			_personalAtmRate = if (BRPVP_personalAtm) then {BRPVP_personalAtmRate+1} else {1};
			if (player getVariable ["sok",false] && player call BRPVP_pAlive) then {
				if (_this isEqualType 0) then {
					_myVal = player getVariable ["mny",0];
					_newAmount = ((BRPVP_atmAmount+_this) min _myVal min (BRPVP_totalMoneyInBank-(player getVariable ["brpvp_mny_bank",0]))) max 0;
					_newAmountPlusRate = round (_personalAtmRate*_newAmount);
					if (_newAmountPlusRate > _myVal) then {
						BRPVP_atmAmount = round (_myVal/_personalAtmRate);
						BRPVP_atmAmountRate = _myVal-BRPVP_atmAmount;
					} else {
						BRPVP_atmAmount = _newAmount;
						BRPVP_atmAmountRate = _newAmountPlusRate-_newAmount;
					};
					55 call BRPVP_menuMuda;
				} else {
					if (_this isEqualTo "all") then {
						_newAmount = ((player getVariable ["mny",0]) min (BRPVP_totalMoneyInBank-(player getVariable ["brpvp_mny_bank",0]))) max 0;
						BRPVP_atmAmountRate = round (_newAmount*(_personalAtmRate-1));
						BRPVP_atmAmount = _newAmount-BRPVP_atmAmountRate;
					};
					if (_this isEqualTo "remove") then {
						BRPVP_atmAmount = 0;
						BRPVP_atmAmountRate = 0;
					};
					if (_this isEqualTo "conclude") then {
						if (BRPVP_atmAmount > 0) then {
							"negocio" call BRPVP_playSound;
							player setVariable ["brpvp_mny_bank",(player getVariable "brpvp_mny_bank")+BRPVP_atmAmount,true];
							player setVariable ["mny",(player getVariable "mny")-(BRPVP_atmAmount+BRPVP_atmAmountRate),true];
							if (BRPVP_atmAmountRate > 0) then {[format [localize "str_atm_personal_rate",BRPVP_atmAmountRate],-4] call BRPVP_hint;};
						};
						54 call BRPVP_menuMuda;
					} else {
						55 call BRPVP_menuMuda;
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			if (BRPVP_atmAmount > 0) then {
				BRPVP_confirmTittle = localize "str_atm_confirm_deposit";
				57 call BRPVP_menuMuda;
			} else {
				54 call BRPVP_menuMuda;
			};
		};
	},
	
	//MENU 56
	{
		BRPVP_menuOpcoes = [
			"+ 1000 $",
			"+ 10000 $",
			"+ 100000 $",
			"+ 500000 $",
			"+ 1000000 $",
			localize "str_atm_all",
			localize "str_atm_remove",
			localize "str_atm_conclude"
		];
		BRPVP_menuExecutaParam = [1000,10000,100000,500000,1000000,"all","remove","conclude"];
		BRPVP_menuExecutaFuncao = {
			_personalAtmRate = if (BRPVP_personalAtm) then {BRPVP_personalAtmRate+1} else {1};
			if (player getVariable ["sok",false] && player call BRPVP_pAlive) then {
				if (_this isEqualType 0) then {
					_myVal = player getVariable ["brpvp_mny_bank",0];
					_newAmount = (BRPVP_atmAmount+_this) min _myVal;
					_newAmountPlusRate = round (_personalAtmRate*_newAmount);
					if (_newAmountPlusRate > _myVal) then {
						BRPVP_atmAmount = round (_myVal/_personalAtmRate);
						BRPVP_atmAmountRate = _myVal-BRPVP_atmAmount;
					} else {
						BRPVP_atmAmount = _newAmount;
						BRPVP_atmAmountRate = _newAmountPlusRate-_newAmount;
					};
					56 call BRPVP_menuMuda;
				} else {
					if (_this isEqualTo "all") then {
						_newAmount = player getVariable ["brpvp_mny_bank",0];
						BRPVP_atmAmountRate = round (_newAmount*(_personalAtmRate-1));
						BRPVP_atmAmount = _newAmount-BRPVP_atmAmountRate;
					};
					if (_this isEqualTo "remove") then {
						BRPVP_atmAmount = 0;
						BRPVP_atmAmountRate = 0;
					};
					if (_this isEqualTo "conclude") then {
						if (BRPVP_atmAmount > 0) then {
							"negocio" call BRPVP_playSound;
							player setVariable ["brpvp_mny_bank",(player getVariable "brpvp_mny_bank")-(BRPVP_atmAmount+BRPVP_atmAmountRate),true];
							player setVariable ["mny",(player getVariable "mny")+BRPVP_atmAmount,true];
							if (BRPVP_atmAmountRate > 0) then {[format [localize "str_atm_personal_rate",BRPVP_atmAmountRate],-4] call BRPVP_hint;};
						};
						54 call BRPVP_menuMuda;
					} else {
						56 call BRPVP_menuMuda;
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			if (BRPVP_atmAmount > 0) then {
				BRPVP_confirmTittle = localize "str_atm_confirm_withdraw";
				57 call BRPVP_menuMuda;
			} else {
				54 call BRPVP_menuMuda;
			};
		};
	},
	
	//MENU 57
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				if (BRPVP_confirmTittle isEqualTo localize "str_atm_confirm_deposit") then {
					if (BRPVP_atmAmount > 0) then {
						"negocio" call BRPVP_playSound;
						player setVariable ["brpvp_mny_bank",(player getVariable "brpvp_mny_bank")+BRPVP_atmAmount,true];
						player setVariable ["mny",(player getVariable "mny")-(BRPVP_atmAmount+BRPVP_atmAmountRate),true];
						if (BRPVP_atmAmountRate > 0) then {[format [localize "str_atm_personal_rate",BRPVP_atmAmountRate],-4] call BRPVP_hint;};
					};
					54 call BRPVP_menuMuda;
				};
				if (BRPVP_confirmTittle isEqualTo localize "str_atm_confirm_withdraw") then {
					if (BRPVP_atmAmount > 0) then {
						"negocio" call BRPVP_playSound;
						player setVariable ["brpvp_mny_bank",(player getVariable "brpvp_mny_bank")-(BRPVP_atmAmount+BRPVP_atmAmountRate),true];
						player setVariable ["mny",(player getVariable "mny")+BRPVP_atmAmount,true];
						if (BRPVP_atmAmountRate > 0) then {[format [localize "str_atm_personal_rate",BRPVP_atmAmountRate],-4] call BRPVP_hint;};
					};
					54 call BRPVP_menuMuda;
				};
			} else {
				54 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			if (BRPVP_confirmTittle isEqualTo localize "str_atm_confirm_deposit") then {55 call BRPVP_menuMuda;};
			if (BRPVP_confirmTittle isEqualTo localize "str_atm_confirm_withdraw") then {56 call BRPVP_menuMuda;};
		};
	},

	//MENU 58
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = [59,60,61];
		BRPVP_menuCodigo = {};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [
			localize "str_custom_friend_see",
			localize "str_custom_friend_add",
			localize "str_custom_friend_remove"
		];
	},
	
	//MENU 59
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		_amgCustom = (BRPVP_stuff getVariable ["amg",[[],[],true]]) select 1;
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		[_amgCustom,player,false] remoteExecCall ["BRPVP_pegaNomePeloIdBd1",2];
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno;
		BRPVP_menuVoltar = {58 call BRPVP_menuMuda;};
	},

	//MENU 60
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_amgCustom = (BRPVP_stuff getVariable ["amg",[[],[],true]]) select 1;
		{
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				if !(_id_bd in _amgCustom) then {
					BRPVP_menuOpcoes pushBack (_x getVariable "nm");
					BRPVP_menuExecutaParam pushBack _id_bd;
				};
			};
		} forEach ((call BRPVP_playersList)-([[player],[]] select BRPVP_vePlayers));
		BRPVP_menuExecutaFuncao = BRPVP_confiarEmAlguemCustom;
		BRPVP_menuVoltar = {58 call BRPVP_menuMuda;};
	},
	
	//MENU 61
	{
		BRPVP_menuTipo = 2;
		_amgCustom = (BRPVP_stuff getVariable ["amg",[[],[],true]]) select 1;
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		[_amgCustom,player,true] remoteExecCall ["BRPVP_pegaNomePeloIdBd1",2];
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno select 0;
		BRPVP_menuExecutaParam = [];
		{BRPVP_menuExecutaParam pushBack (BRPVP_pegaNomePeloIdBd1Retorno select 1 select _forEachIndex);} forEach BRPVP_menuOpcoes;
		BRPVP_menuExecutaFuncao = BRPVP_deixarDeConfiarCustom;
		BRPVP_menuVoltar = {58 call BRPVP_menuMuda;};
	},

	//MENU 62
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\icones3d\working.paa'/>";
		_class = typeOf BRPVP_stuff;
		_typeOf = if (_class isEqualTo "") then {getModelInfo BRPVP_stuff select 1} else {_class};
		_str = "";
		_kitIndex = -1;
		_priceBasic = 0;
		_extraPrice = 0;
		_removeDelay = 0;
		{
			if (BRPVP_specialItemsGroup select _forEachIndex isEqualTo localize "str_spec_itm_group_cons") then {
				_kit = call compile _x;
				if (_typeOf in _kit) then {
					_str = _x;
					_removeDelay = BRPVP_specialItemsRemoveTime select _forEachIndex;
					_kitIndex = _forEachIndex;
					break
				};
			};
		} forEach BRPVP_specialItems;
		
		//SET IF TURRET LEVEL 2 
		if (BRPVP_stuff getVariable ["brpvp_lvl2",1] isEqualTo 2 && _typeOf in BRP_kitAutoTurret) then {
			_str = "BRP_kitAutoTurretLvl2";
			_removeDelay = BRPVP_specialItemsRemoveTime select 112;
			_kitIndex = 112;
		};
		
		{
			if (_x select 3 isEqualTo _str) exitwith {
				_priceBasic = (_x select 4)*(BRPVP_mercadoPrecos select (_x select 0))*BRPVP_objRemoveOriginalPricePercentage;
				_extraPrice = (_x select 4)*(BRPVP_mercadoPrecos select (_x select 0))*BRPVP_objRemoveOriginalPricePercentageAditionalForFastRemove;
			};
		} forEach BRPVP_mercadoItens;
		BRPVP_menuOpcoes = [
			format [localize "str_building_repack_instant","$ " + str round (_priceBasic+_extraPrice)],
			format [localize "str_building_repack_delayed","$ " + str round _priceBasic]
		];
		BRPVP_menuExecutaParam = [
			[BRPVP_stuff,round (_priceBasic+_extraPrice),2.5,_removeDelay,_kitIndex],
			[BRPVP_stuff,round _priceBasic,2.5+_removeDelay,_removeDelay,_kitIndex]
		];
		BRPVP_menuExecutaFuncao = {
			_isFlag = BRPVP_stuff isKindOf "FlagCarrier";
			if (_isFlag && {BRPVP_stuff call BRPVP_flagPayPrice > 0}) then {
				"erro" call BRPVP_playSound;
				[localize "str_remove_cant_need_pay_flag",-6] call BRPVP_hint;
			} else {
				_flagRad = BRPVP_stuff getVariable ["brpvp_flag_radius",0];
				if (_isFlag && {{BRPVP_stuff distance2D _x < 300+_flagRad} count BRPVP_missionsPos > 0}) then {
					"erro" call BRPVP_playSound;
					[localize "str_cant_flag_near_miss",-6] call BRPVP_hint;
				} else {
					if (BRPVP_raidServerIsRaidDay && BRPVP_raidWeekDaysDisableConstruction && !BRPVP_vePlayers) then {
						"erro" call BRPVP_playSound;
						[localize "str_cant_build_raid_day",-6] call BRPVP_hint;
					} else {
						if (player getVariable "mny" >= _this select 1) then {
							BRPVP_menuExtraLigado = false;
							hintSilent "";
							BRPVP_playerIsRemovingObject = true;
							_this spawn {
								params ["_obj","_priceTotal","_delay","_toSelSound","_kitIndex"];
								_init = time;
								_actualDistance = player distance _obj;
								_removeSound = if (_toSelSound <= 15) then {[["drill_small",100],["drill_small_b",100]]} else {if (_toSelSound <= 25) then {[["pickaxe",250]]} else {[["drilling",400],["drilling_b",400]]};};
								waitUntil {
									[player,selectRandom _removeSound] remoteExecCall ["say3D",BRPVP_allNoServer];
									sleep (1.5+random 1.5);
									time-_init >= _delay || player distance _obj > _actualDistance+10 || !(player call BRPVP_pAlive) || player getVariable ["cmb",false]
								};
								if (player distance _obj > _actualDistance+12 || !(player call BRPVP_pAlive) || player getVariable ["cmb",false]) then {
									[localize "str_building_repack_failed"] call BRPVP_hint;
									BRPVP_playerIsRemovingObject = false;
								} else {
									if (alive _obj && !isNull _obj) then {
										if (_obj isKindOf "StaticWeapon") then {
											_operator = _obj getVariable "brpvp_operator";
											_code = {
												_this setVariable ["brpvp_dead",true,true];
												_this setVariable ["brpvp_dead_delete",true];
												(vehicle _this) setVariable ["brpvp_die_explosion",false];
												BRPVP_autoTurretDied pushBack _this;
											};
											_obj setPosWorld BRPVP_posicaoFora;
											BRPVP_playerIsRemovingObject = false;
											[_operator,_code] remoteExecCall ["call",_operator];
										} else {
											private _typeOf = typeOf _obj;
											private _rad = 10+(sizeOf _typeOf)/2;
											[_obj,_rad,5] call BRPVP_enableVehiclesBuildingsChanged;					
											if (netId _obj isEqualTo "0:0") then {
												if (typeOf _obj in BRPVP_buildingHaveDoorListCVL) then {
													[typeOf _obj,_obj getVariable "id_bd"] remoteExecCall ["BRPVP_removeObjectSimpleObjectCVL",0];
												} else {
													[typeOf _obj,_obj getVariable "id_bd"] remoteExecCall ["BRPVP_removeObjectSimpleObject",0];
												};
											} else {
												if (_obj isKindOf "ReammoBox_F") then {
													private _cargo = _obj call BRPVP_getCargoArray;
													if (_cargo isNotEqualTo [3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]]) then {
														private _wh = createVehicle ["GroundWeaponHolder",getPosATL _obj,[],0,"CAN_COLLIDE"];
														_wh setPosASL getPosASL _obj;
														[_wh,_cargo,true,false] call BRPVP_putItemsOnCargo;
													};
												};
												[_obj,true] call BRPVP_removeObject;
											};
											BRPVP_playerIsRemovingObject = false;
										};
										if (_kitIndex >= 0) then {[_kitIndex,1] call BRPVP_sitAddItem;};
										if (!BRPVP_vePlayers) then {
											_mny = player getVariable "mny";
											player setVariable ["mny",_mny-_priceTotal,true];
											"negocio" call BRPVP_playSound;
											call BRPVP_atualizaDebug;
										};
									} else {
										BRPVP_playerIsRemovingObject = false;
									};
								};
							};
						} else {
							[localize "str_no_money",0,200,0,"erro"] call BRPVP_hint;
						};
					};
				};
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},
	
	//MENU 63
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				BRPVP_stuff remoteExecCall ["BRPVP_destroyTurret",2];
				BRPVP_stuff setPosWorld BRPVP_posicaoFora;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				22 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 64
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		private _state = player call BRPVP_unitSquadState;
		if (_state isEqualTo "alone") then {
			BRPVP_menuOpcoes = [localize "str_squad_invite",localize "str_squad_accept",localize "str_squad_share"];
			BRPVP_menuExecutaParam = [65,66,69];
		} else {
			if (_state isEqualTo "leader") then {
				BRPVP_menuOpcoes = [localize "str_squad_invite",localize "str_squad_remove",localize "str_squad_share",localize "str_squad_members",localize "str_squad_give"];
				BRPVP_menuExecutaParam = [65,67,69,70,71];
			} else {
				BRPVP_menuOpcoes = [localize "str_squad_leave",localize "str_squad_share",localize "str_squad_members"];
				BRPVP_menuExecutaParam = [68,69,70];
			};
		};
		BRPVP_menuExecutaFuncao = {_this call BRPVP_menuMuda;};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 65
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		call BRPVP_getPlayersForSquad;
		BRPVP_menuExecutaFuncao = {
			private _invited = _this call BRPVP_getPlayerById;
			private _inviterOk = (player call BRPVP_unitSquadState) in ["alone","leader"];
			private _invitedOk = (_invited call BRPVP_unitSquadState) isEqualTo "alone";
			if (_inviterOk && _invitedOk) then {
				[player,player getVariable "id_bd",player getVariable "nm"] remoteExecCall ["BRPVP_squadInvite",_invited];
				_invited setVariable ["brpvp_last_squad_invite_time",time];
			} else {
				"erro" call BRPVP_playSound;
			};
			call BRPVP_getPlayersForSquad;
			if (BRPVP_menuOpcoes isEqualTo []) then {64 call BRPVP_menuMuda;} else {65 call BRPVP_menuMuda;};
		};
		BRPVP_menuVoltar = {64 call BRPVP_menuMuda;};
	},

	//MENU 66
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		call BRPVP_getSquadInviteOptions;
		BRPVP_menuExecutaFuncao = {
			_this spawn {
				private _inviter = _this call BRPVP_getPlayerById;
				if (!isNull _inviter) then {
					[player] joinSilent group _inviter;
					waitUntil {(group player) isEqualTo (group _inviter)};
					[format [localize "str_squad_invite_accept_ok",_inviter getVariable "nm"],-5] call BRPVP_hint;
				};
				call BRPVP_getSquadInviteOptions;
				if (BRPVP_menuOpcoes isEqualTo []) then {64 call BRPVP_menuMuda;} else {66 call BRPVP_menuMuda;};
			};
		};
		BRPVP_menuVoltar = {64 call BRPVP_menuMuda;};
	},
	
	//MENU 67
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			private _idBd = _x getVariable "id_bd";
			BRPVP_menuOpcoes pushBack format ["%1 - %2",_idBd,_x getVariable "nm"];
			BRPVP_menuExecutaParam pushBack _idBd;
		} forEach ((units group player)-[player]);
		BRPVP_menuExecutaFuncao = {
			_this spawn {
				private _member = _this call BRPVP_getPlayerById;
				if (!isNull _member && _member in units group player && (player call BRPVP_unitSquadState) isEqualTo "leader") then {
					private _nameRemoved = _member getVariable "nm";
					private _nameLeader = player getVariable "nm";
					[_member] joinSilent grpNull;
					waitUntil {(group player) isNotEqualTo (group _member)};
					[format [localize "str_squad_msg_removed_leader",_nameRemoved]] call BRPVP_hint;
					[["str_squad_msg_removed",[_nameLeader]],-6] remoteExecCall ["BRPVP_hint",_member];
				} else {
					"erro" call BRPVP_playSound;
				};
				private _remain = (units group player)-[player];
				if (_remain isEqualTo []) then {64 call BRPVP_menuMuda;} else {67 call BRPVP_menuMuda;};
			};
		};
		BRPVP_menuVoltar = {64 call BRPVP_menuMuda;};
	},
	
	//MENU 68
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			_this spawn {
				if (_this) then {
					private _myState = player call BRPVP_unitSquadState;
					if (_myState isEqualTo "group") then {
						_leader = leader group player;
						_leaderName = _leader getVariable "nm";
						_lefterName = player getVariable "nm";
						[player] joinSilent grpNull;
						waitUntil {(group player) isNotEqualTo (group _leader)};
						[format [localize "str_squad_msg_left",_leaderName],-6] call BRPVP_hint;
						[["str_squad_msg_left_leader",[_lefterName]],-6] remoteExecCall ["BRPVP_hint",_leader]
					} else {
						if (_myState isEqualTo "leader") then {
							"erro" call BRPVP_playSound;
							[localize "str_squad_give_leader_to",-6] call BRPVP_hint;
						};
					};
				};
				64 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {64 call BRPVP_menuMuda;};
	},

	//MENU 69
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [
			"<t shadow='2' size='1.15' align='center'>"+localize "str_squad_msg_share_0"+"</t>",
			"<t shadow='2' size='1.15' align='center'>"+localize "str_squad_msg_share_1"+"</t>",
			"<t shadow='2' size='1.15' align='center'>"+localize "str_squad_msg_share_2"+"</t>",
			"<t shadow='2' size='1.15' align='center'>"+localize "str_squad_msg_share_3"+"</t>"
		];
		BRPVP_menuOpcoes = [
			format [localize "str_squad_share_opt0",if (0 in BRPVP_mySquadShares) then {"X"} else {"   "}],
			format [localize "str_squad_share_opt1",if (1 in BRPVP_mySquadShares) then {"X"} else {"   "}],
			format [localize "str_squad_share_opt2",if (2 in BRPVP_mySquadShares) then {"X"} else {"   "}],
			format [localize "str_squad_share_opt3",if (3 in BRPVP_mySquadShares) then {"X"} else {"   "}]
		];
		BRPVP_menuExecutaParam = [0,1,2,3];
		BRPVP_menuExecutaFuncao = {
			if (_this in BRPVP_mySquadShares) then {BRPVP_mySquadShares deleteAt (BRPVP_mySquadShares find _this);} else {BRPVP_mySquadShares pushBack _this;};
			player setVariable ["brpvp_my_squad_share",BRPVP_mySquadShares,true];
			69 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {64 call BRPVP_menuMuda;};
	},

	//MENU 70
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuOpcoes = [];
		private _leader = leader group player;
		{
			private _leaderTxt = if (_x isEqualTo _leader) then {" (leader)"} else {""};
			BRPVP_menuOpcoes pushBack format ["%1 - %2%3",_x getVariable "id_bd",_x getVariable "nm",_leaderTxt];
		} forEach units group player;
		BRPVP_menuVoltar = {64 call BRPVP_menuMuda;};
	},

	//MENU 71
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if (_x call BRPVP_isPlayerB) then {
				private _idBd = _x getVariable "id_bd";
				BRPVP_menuOpcoes pushBack format ["%1 - %2",_idBd,_x getVariable "nm"];
				BRPVP_menuExecutaParam pushBack _idBd;
			};
		} forEach ((units group player)-[player]);
		BRPVP_menuExecutaFuncao = {
			_this spawn {
				private _group = group player;
				private _newLeader = _this call BRPVP_getPlayerById;
				if (!isNull _newLeader && _newLeader call BRPVP_isPlayerB && _newLeader in units _group && leader _group isEqualTo player) then {
					_group selectleader _newLeader;
					waitUntil {leader _group isEqualTo _newLeader};
					[format [localize "str_squad_pass_leader",_newLeader getVariable "nm"],-5] call BRPVP_hint;
					[["str_squad_pass",[player getVariable "nm"]],-5] remoteExecCall ["BRPVP_hint",_newLeader];
					64 call BRPVP_menuMuda;
				} else {
					"erro" call BRPVP_playSound;
					private _optionsNow = (units group player)-[player];
					if (_optionsNow isEqualTo []) then {64 call BRPVP_menuMuda;} else {71 call BRPVP_menuMuda;};
				};
			};
		};
		BRPVP_menuVoltar = {64 call BRPVP_menuMuda;};
	},
	
	//MENU 72
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\zombie_icon.paa'/>";
		BRPVP_menuOpcoes = ["Default spawn","Spawn on me"];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			73 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 73
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\zombie_icon.paa'/>";
		if (BRPVP_menuVar1 isEqualTo 0) then {
			BRPVP_menuOpcoes = ["01 zombies","02 zombies","03 zombies","04 zombies","05 zombies","10 zombies"];
			BRPVP_menuExecutaParam = [1,2,3,4,5,10];
		};
		if (BRPVP_menuVar1 isEqualTo 1) then {
			BRPVP_menuOpcoes = ["01 zombies","03 zombies","05 zombies","10 zombies","20 zombies","30 zombies","40 zombies","50 zombies","100 zombies","200 zombies"];
			BRPVP_menuExecutaParam = [1,3,5,10,20,30,40,50,100,200];
		};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 = _this;
			74 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {72 call BRPVP_menuMuda;};
	},

	//MENU 74
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		if (BRPVP_menuVar1 isEqualTo 0) then {BRPVP_menuImagem = "<img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\ok.paa'/> <img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\zombie_icon.paa'/>";};
		if (BRPVP_menuVar1 isEqualTo 1) then {BRPVP_menuImagem = "<img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\zombie_icon.paa'/>";};
		BRPVP_menuOpcoes = ["Level 1","Level 2","Level 3","Level 4","Level 5","Level 10"];
		BRPVP_menuExecutaParam = [[1],[2],[3],[4],[5],[10]];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar3 = _this;
			if (BRPVP_menuVar1 isEqualTo 0) then {
				[BRPVP_menuVar2,BRPVP_menuVar3] spawn BRPVP_menu29SpawnZombies;
				"hint" call BRPVP_playSound;
				29 call BRPVP_menuMuda;
			};
			if (BRPVP_menuVar1 isEqualTo 1) then {75 call BRPVP_menuMuda;};
		};
		BRPVP_menuVoltar = {73 call BRPVP_menuMuda;};
	},

	//MENU 75
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\ok.paa'/> <img size='3.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\zombie_icon.paa'/>";
		BRPVP_menuOpcoes = ["All near Players","Me"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			_victims = if (_this) then {
				_cases = (player nearEntities [BRPVP_playerModel,200]) apply {[_x distance player,_x]};
				if (_cases isEqualTo []) then {_cases pushBack [0,player];};
				_cases sort true;
				_cases = _cases apply {_x select 1};
				if (_cases isEqualTo [player]) then {_cases} else {_cases-[player]};
			} else {
				[player]
			};
			[ASLToAGL getPosASL player,_victims,BRPVP_menuVar2,BRPVP_menuVar3] spawn {
				params ["_ppAGL","_victims","_menuVar2","_menuVar3"];
				private _sNum = 20;
				private _qtt = floor (_menuVar2/_sNum);
				for "_i" from 1 to _qtt do {
					[[_ppAGL,_sNum,2*sqrt(_menuVar2),_menuVar3,_victims]] remoteExecCall ["BRPVP_spawnZombiesServerFromClientInFront",2];
					uiSleep 0.75;
				};
				[[_ppAGL,_menuVar2-_qtt*_sNum,2*sqrt(_menuVar2),_menuVar3,_victims]] remoteExecCall ["BRPVP_spawnZombiesServerFromClientInFront",2];
			};
			"hint" call BRPVP_playSound;
			72 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {74 call BRPVP_menuMuda;};
	},
	
	//MENU 76
	{
		BRPVP_menuTipo = 0;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = 76;
		BRPVP_menuOpcoes = [];
		BRPVP_menuParameters = [];
		_isMyArea = (player call BRPVP_checkOnFlagState) isEqualto 2;
		_menuOpcoes = [];
		_menuParameters = [];
		_menuImagem = [];
		{
			private _idx = BRPVP_specialItems find _x;
			private _name = BRPVP_specialItemsNames select _idx;
			if (BRPVP_specialItemsGroup select _idx isEqualTo BRPVP_menuVar1) then {
				if (_isMyArea || BRPVP_specialItemsFreeOfFlag select _idx || BRPVP_vePlayers) then {
					_q = _idx call BRPVP_sitCountItem;
					if (_q > 0 || BRPVP_vePlayers) then {
						BRPVP_menuOpcoes pushBack ("X"+str _q+"@memory_remove_back@ "+_name);
						BRPVP_menuParameters pushBack _idx;
						BRPVP_menuImagem pushBack ("<img size='5.0' align='center' image='"+BRPVP_imagePrefix+(BRPVP_specialItemsImages select _idx)+"'/>");
					};
				} else {
					_q = _idx call BRPVP_sitCountItem;
					if (_q > 0) then {
						_menuOpcoes pushBack ("(OFF) X"+str _q+"@memory_remove_back@ "+_name);
						_menuParameters pushBack -1;
						_menuImagem pushBack ("<img size='5.0' align='center' image='"+BRPVP_imagePrefix+(BRPVP_specialItemsImages select _idx)+"'/>");
					};
				};
			};
		} forEach BRPVP_specialItemsOrder;
		if (BRPVP_menuVar1 isEqualTo localize "str_spec_itm_group_cons") then {
			BRPVP_menuOpcoes append [format [localize "str_cons_free_sign_name",BRPVP_baseSignPrice]];
			BRPVP_menuParameters append [[[BRPVP_baseSignClass],BRPVP_baseSignPrice]];
			BRPVP_menuImagem append ["<img size='4.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\text_sign.paa'/>"];
		};
		BRPVP_menuOpcoes append _menuOpcoes;
		BRPVP_menuParameters append _menuParameters;
		BRPVP_menuImagem append _menuImagem;
		BRPVP_menuCodigo = {
			_param = BRPVP_menuParameters select BRPVP_menuOpcoesSel;
			if (_param isEqualType []) then {
				if (BRPVP_raidServerIsRaidDay && BRPVP_raidWeekDaysDisableConstruction && !BRPVP_vePlayers) then {
					"erro" call BRPVP_playSound;
					[localize "str_not_raid_day",-6] call BRPVP_hint;
				} else {
					_param params ["_cons","_price"];
					[_cons,"",-2,false,objNull,_price] call BRPVP_construir;
				};
			} else {
				call BRPVP_useCustomItem;
			};
		};
		BRPVP_menuVoltar = {35 call BRPVP_menuMuda;};
	},

	//MENU 77
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\pay_flag.paa'/>";
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				_price = BRPVP_stuff call BRPVP_flagPayPrice;
				if (_price > 0) then {
					_money = player getVariable "mny";
					if (_money >= _price) then {
						"negocio" call BRPVP_playSound;
						player setVariable ["mny",_money-_price,true];
						BRPVP_stuff setVariable ["brpvp_lastPayment",BRPVP_sessionTimeStamp,true];
						BRPVP_stuff setVariable ["brpvp_save_lastPayment",true,true];
						call BRPVP_atualizaDebug;
						22 call BRPVP_menuMuda;
					} else {
						"erro" call BRPVP_playSound;
						[localize "str_no_money",-5] call BRPVP_hint;
					};
				} else {
					22 call BRPVP_menuMuda;
				};
			} else {
				22 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 78
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa'/>";
		_step = BRPVP_headPriceSpotConsumePerMinute/6;
		BRPVP_menuOpcoes = [
			"(+) "+(round _step call BRPVP_formatNumber),
			"(-) "+(round _step call BRPVP_formatNumber),
			localize "str_confirm"
		];
		BRPVP_menuExecutaParam = [_step,-_step,"ok"];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "ok") then {
				if (BRPVP_menuVar1 > 0) then {
					player setVariable ["mny",(player getVariable "mny")-BRPVP_menuVar1,true];
					player setVariable ["brpvp_hh_balance",(player getVariable "brpvp_hh_balance")+BRPVP_menuVar1,true];
					"negocio" call BRPVP_playSound;
					call BRPVP_atualizaDebug;
				};
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				"hint2" call BRPVP_playSound;
				_step = BRPVP_headPriceSpotConsumePerMinute/6;
				_mny = player getVariable "mny";
				BRPVP_menuVar1 = (BRPVP_menuVar1+_this) max 0 min (_step*floor (_mny/_step));
				78 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 79
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_menu_opt_add_funds",
			localize "str_menu_opt_head_rank"
		];
		BRPVP_menuExecutaParam = [80,82];
		BRPVP_menuExecutaFuncao = {_this call BRPVP_menuMuda;};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 80
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa'/>";
		call BRPVP_pegaListaPlayersHH;
		BRPVP_menuExecutaParam = BRPVP_menuExecutaParam apply {_x getVariable ["id_bd",-1]};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo -1) then {
				"erro" call BRPVP_playSound;
				80 call BRPVP_menuMuda;
			} else {
				BRPVP_menuVar1 = _this;
				BRPVP_menuVar2 = 0;
				81 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {79 call BRPVP_menuMuda;};
	},
	
	//MENU 81
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa'/>";
		BRPVP_menuOpcoes = [
			"(+) "+((round (BRPVP_headPriceSpotConsumePerMinute/6)) call BRPVP_formatNumber),
			"(-) "+((round (BRPVP_headPriceSpotConsumePerMinute/6)) call BRPVP_formatNumber),
			localize "str_confirm"
		];
		BRPVP_menuExecutaParam = [BRPVP_headPriceSpotConsumePerMinute/6,-BRPVP_headPriceSpotConsumePerMinute/6,"ok"];
		BRPVP_menuExecutaFuncao = {
			private _pToSpot = BRPVP_menuVar1 call BRPVP_getPlayerById;
			if (_this isEqualTo "ok") then {
				if (BRPVP_menuVar2 > 0) then {
					if (!isNull _pToSpot && _pToSpot getVariable ["sok",false]) then {
						_headPrice = _pToSpot getVariable "brpvp_head_price";
						BRPVP_menuVar2 = (BRPVP_headPriceSpotMaxFundsPerPlayer-_headPrice) max 0 min BRPVP_menuVar2;
						player setVariable ["brpvp_hh_balance",(player getVariable "brpvp_hh_balance")-BRPVP_menuVar2,true];
						_pToSpot setVariable ["brpvp_head_price",_headPrice+BRPVP_menuVar2,true];
						_added = BRPVP_menuVar2 call BRPVP_formatNumber;
						_victimName = _pToSpot getVariable "nm";
						_total = (_pToSpot getVariable "brpvp_head_price") call BRPVP_formatNumber;
						[format [localize "str_add_kill_funds_msg",_added,_victimName,_total],-8] call BRPVP_hint;
						"negocio" call BRPVP_playSound;
						call BRPVP_atualizaDebug;
						[clientOwner,60*BRPVP_menuVar2/BRPVP_headPriceSpotConsumePerMinute] remoteExecCall ["BRPVP_addSpotBackInformation",_pToSpot];
						BRPVP_menuExtraLigado = false;
						hintSilent "";
					} else {
						"erro" call BRPVP_playSound;
						80 call BRPVP_menuMuda;
					};
				} else {
					79 call BRPVP_menuMuda;
				};
			} else {
				_newValue = BRPVP_menuVar2+_this;
				if ((player getVariable "brpvp_hh_balance") >= _newValue) then {
					"hint2" call BRPVP_playSound;
					BRPVP_menuVar2 = _newValue max 0;
					_headPrice = _pToSpot getVariable "brpvp_head_price";
					BRPVP_menuVar2 = (BRPVP_headPriceSpotMaxFundsPerPlayer-_headPrice) max 0 min BRPVP_menuVar2;
					81 call BRPVP_menuMuda;
				} else {
					"erro" call BRPVP_playSound;
				};
			};
		};
		BRPVP_menuVoltar = {80 call BRPVP_menuMuda;};
	},
	
	//MENU 82
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\camera.paa'/>";
		BRPVP_menuOpcoes = [];
		{
			_isSpoter = _x getVariable ["brpvp_hh_balance",0] >= BRPVP_headPriceSpotConsumePerMinute/6;
			_isSpoted = _x getVariable ["brpvp_head_price",0] >= BRPVP_headPriceSpotConsumePerMinute/6;
			if (_x getVariable ["sok",false] && (_isSpoter || _isSpoted)) then {
				BRPVP_menuOpcoes pushBack [_x getVariable "brpvp_head_price",_x getVariable "nm"];
			};
		} forEach call BRPVP_playersList;
		BRPVP_menuOpcoes sort false;
		BRPVP_menuOpcoes = BRPVP_menuOpcoes apply {format ["$%1 - %2",(_x select 0) call BRPVP_formatNumber,_x select 1]};
		BRPVP_menuCodigo = {};
		BRPVP_menuVoltar = {79 call BRPVP_menuMuda;};
	},

	//MENU 83
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuOpcoes = [];
		{BRPVP_menuOpcoes pushBack ((_x select 2)+" ("+(if (BRPVP_eventsDataCodeIsOn select _forEachIndex isEqualTo 2) then {"On"} else {"Off"})+")");} forEach BRPVP_eventsData;
		BRPVP_menuExecutaParam = [];
		{BRPVP_menuExecutaParam pushBack _forEachIndex;} forEach BRPVP_eventsData;
		BRPVP_menuExecutaFuncao = {
			_idx = _this;
			_state = BRPVP_eventsDataCodeIsOn select _idx;
			if (_state isEqualTo 1) then {
				"erro" call BRPVP_playSound;
				["Event already starting or stopping.",-5] call BRPVP_hint;
			} else {
				if (_state isEqualTo 0) then {_idx remoteExec ["BRPVP_eventsInitiateFromServer",2];} else {_idx remoteExecCall [BRPVP_eventsDataCodeOff select _idx,2];};
			};
			BRPVP_menuSleep = 0;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 84
	{
		BRPVP_menuSleep = 0.2;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\virtual_garage.paa'/>";
		BRPVP_myVirtualGarageOptions = nil;
		player remoteExecCall ["BRPVP_getMyVirtualGarage",2];
		waitUntil {!isNil "BRPVP_myVirtualGarageOptions"};
		_garageType = BRPVP_stuff call BRPVP_getVirtualGarageType;
		_mult = (player getVariable ["brpvp_vg_mult",1]) max (player getVariable ["brpvp_xp_vg_x",1]);
		_qVg = if (_mult > 1) then {(BRPVP_virtualGarageLimit select _garageType select 2) max 1} else {BRPVP_virtualGarageLimit select _garageType select 2};
		_limit = _qVg*_mult;
		_places = BRPVP_virtualGarageLimit select _garageType select 4;
		_fastStore = BRPVP_virtualGarageLimit select _garageType select 7;
		_missTime = (BRPVP_stuff getVariable ["brpvp_from_vg_time",0])-serverTime;
		_isOk1 = _missTime <= 0;
		_isOk2 = {(_x select 1) call BRPVP_getVirtualGarageType isEqualTo _garageType} count BRPVP_myVirtualGarageOptions < _limit;
		_isOk3 = _fastStore && ({BRPVP_stuff distance (_x select 0) <= (_x select 1)} count _places > 0 || player call BRPVP_checkOnFlagState isEqualTo 2);
		_isOk4 = isNull objectParent player && !(BRPVP_stuff getVariable ["brpvp_delete_when_possible",false]);
		if (_isOk4) then {
			if (_isOk1 || _isOk3) then {
				if (_isOk2) then {
					BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
					BRPVP_menuExecutaParam = [true,false];
				} else {
					"erro" call BRPVP_playSound;
					[format [localize "str_vg_cant_limit",_limit,BRPVP_virtualGarageLimit select _garageType select 3],-6] call BRPVP_hint;
					BRPVP_menuOpcoes = [localize "str_menu12_opt2"];
					BRPVP_menuExecutaParam = [false];
				};
			} else {
				"erro" call BRPVP_playSound;
				[format [localize "str_vg_cant_time",round (_missTime)],-6] call BRPVP_hint;
				BRPVP_menuOpcoes = [];
				BRPVP_menuExecutaParam = [];
			};
		} else {
				"erro" call BRPVP_playSound;
				BRPVP_menuOpcoes = [];
				BRPVP_menuExecutaParam = [];
		};
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				_id = BRPVP_stuff getVariable ["id_bd",-1];
				if (_id > -1) then {
					_mnyBank = player getVariable ["brpvp_mny_bank",0];
					_price = BRPVP_stuff call BRPVP_getVGPrice;
					if (_mnyBank >= _price) then {
						player setVariable ["brpvp_mny_bank",_mnyBank-_price,true];
						BRPVP_stuff remoteExecCall ["BRPVP_putInVirtualGarage",2];
						"hint2" call BRPVP_playSound;
						"negocio" call BRPVP_playSound;
						call BRPVP_atualizaDebug;
						BRPVP_menuSleep = 0;
						BRPVP_menuExtraLigado = false;
						hintSilent "";
					} else {
						[localize "str_no_money",-5] call BRPVP_hint;
						84 spawn BRPVP_menuMuda;
					};
				} else {
					"erro" call BRPVP_playSound;
					84 spawn BRPVP_menuMuda;
				};
			} else {
				if (_this isEqualTo "limit") then {96 call BRPVP_menuMuda;} else {22 call BRPVP_menuMuda;};
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 85
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\virtual_garage.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_myVirtualGarageOptionsType = [];
		private _codeCheck = if (BRPVP_menuVar1 isEqualTo -1) then {{true}} else {BRPVP_virtualGarageLimit select BRPVP_menuVar1 select 1};
		{
			private _isGroupType = _x select 1 call _codeCheck;
			private _isLegalType = _x select 6 isEqualTo BRPVP_menuVar2;
			if (_isGroupType && _isLegalType) then {BRPVP_myVirtualGarageOptionsType pushBack _x;};
		} forEach BRPVP_myVirtualGarageOptions;
		BRPVP_myVirtualGarageOptionsType = BRPVP_myVirtualGarageOptionsType apply {[-(BRPVP_virtualGarageLimit select ((_x select 1) call BRPVP_getVirtualGarageType) select 6),getText (configFile >> "CfgVehicles" >> (_x select 1) >> "displayName") call BRPVP_escapeForStructuredTextFast,_x]};
		BRPVP_myVirtualGarageOptionsType sort true;
		BRPVP_myVirtualGarageOptionsType = BRPVP_myVirtualGarageOptionsType apply {_x select 2};
		_menuOpcoesOff = [];
		_menuExecutaParamOff = [];
		_menuOpcoesDis = [];
		_menuExecutaParamDis = [];
		{
			_x params ["_id","_class","_paint","_cover","_ammo","_life","_isBM","_secured"];
			_secured = [""," "+localize "str_secured_vehicle_mark"] select _secured;
			_idx = _class call BRPVP_getVirtualGarageType;
			_type = BRPVP_virtualGarageLimit select _idx select 3;
			_areaName = BRPVP_virtualGarageLimit select _idx select 5;
			_ok = true;
			if (!BRPVP_virtualGarageEverywhere) then {
				_ok = player call BRPVP_checkOnFlagState isEqualTo 2;
				if (!_ok) then {{if (player distance (_x select 0) < _x select 1) exitWith {_ok = true;};} forEach (BRPVP_virtualGarageLimit select _idx select 4);};
			};
			if (_class in BRPVP_disableVehUseList) then {
				_menuOpcoesDis pushBack ("("+localize "str_disabled"+") "+str _id+": "+(getText (configFile >> "CfgVehicles" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast)+_secured);
				_menuExecutaParamDis pushBack [_id,_class,3,_areaName,_paint,_cover,_ammo,_life];
			} else {
				if (_ok) then {
					BRPVP_menuOpcoes pushBack (str _id+": "+(getText (configFile >> "CfgVehicles" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast)+_secured);
					BRPVP_menuExecutaParam pushBack [_id,_class,1,_areaName,_paint,_cover,_ammo,_life];
				} else {
					_menuOpcoesOff pushBack ("(OFF) "+str _id+": "+(getText (configFile >> "CfgVehicles" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast)+_secured);
					_menuExecutaParamOff pushBack [_id,_class,2,_areaName,_paint,_cover,_ammo,_life];
				};
			};
		} forEach BRPVP_myVirtualGarageOptionsType;
		BRPVP_menuOpcoes append _menuOpcoesOff;
		BRPVP_menuExecutaParam append _menuExecutaParamOff;
		BRPVP_menuOpcoes append _menuOpcoesDis;
		BRPVP_menuExecutaParam append _menuExecutaParamDis;
		BRPVP_menuExecutaFuncao = {
			params ["_id","_class","_ok","_areaName","_paint","_cover","_ammo","_life"];
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			if (_ok isEqualTo 1) then {
				if (isNull BRPVP_vgCheckVehicle) then {
					BRPVP_vgSpaceCheckFail = false;
					[localize "str_testing_position",-2] call BRPVP_hint;
					[_class,_paint,_cover,_ammo,_life] call BRPVP_virtualGarageSpawnSpaceCheck params ["_testVeh","_drawCoords"];
					BRPVP_vgCheckVehicle = _testVeh;
					[_testVeh,_drawCoords,_id,_class] spawn {
						params ["_testVeh","_drawCoords","_id","_class"];
						"tension" call BRPVP_playSound;
						private _posW = getPosWorld _testVeh;
						private _vDU = [vectorDir _testVeh,vectorUp _testVeh];
						private _init = time;
						waitUntil {
							_testVeh setVectorDirAndUp _vDU;
							_testVeh setPosWorld _posW;
							time-_init > 1 || BRPVP_vgSpaceCheckFail
						};
						_testVeh enableSimulation false;
						if (BRPVP_vgSpaceCheckFail) then {
							deleteVehicle _testVeh;
							"delivered" call BRPVP_playSound;
							[localize "str_vg_get_no_space",-5,200,0,"erro"] call BRPVP_hint;
						} else {
							sleep 1;
							[localize "str_position_ok",-2] call BRPVP_hint;
							sleep 0.5;
							[_id,_class,player,BRPVP_virtualGarageTimeToStore,clientOwner,_posW,_vDU] remoteExecCall ["BRPVP_virtualGarageSpawnVehicle",2];
							waitUntil {
								_ok = false;
								{if (_x getVariable ["id_bd",-2] isEqualTo _id) exitWith {_ok = true;};} forEach nearestObjects [_testVeh,[typeOf _testVeh],10];
								_ok || time-_init > 5
							};
							deleteVehicle _testVeh;
							"hint2" call BRPVP_playSound;
							BRPVP_menuSleep = 0;
						};
					};
				} else {
					"erro" call BRPVP_playSound;
				};
			} else {
				if (_ok isEqualTo 2) then {
					[format [localize "str_vg_area_needed",_areaName],-5] call BRPVP_hint;
					"erro" call BRPVP_playSound;
				} else {
					if (_ok isEqualTo 3) then {
						[localize "str_veh_disabled_day_vg",-6] call BRPVP_hint;
						"erro" call BRPVP_playSound;
					};
				};
			};
		};
		BRPVP_menuVoltar = {189 call BRPVP_menuMuda;};
	},

	//MENU 86
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [
			"<t align='center' size='1.2' color='#66dd66'>"+localize "str_price"+" 0 $</t>",
			"<t align='center' size='1.2' color='#66dd66'>"+localize "str_price"+" "+str BRPVP_coverPrice+" $</t>",
			"<t align='center' size='1.2' color='#66dd66'>"+localize "str_price"+" "+str BRPVP_coverPrice+" $</t>",
			"<t align='center' size='1.2' color='#66dd66'>"+localize "str_price"+" "+str (BRPVP_coverPrice*1.5)+" $</t>"
		];
		_hasCamo = false;
		_hasSLAT = false;
		{
			if (_x isEqualType "") then {
				if (_x find "showCamonet" != -1) then {_hasCamo = true;};
				if (_x find "showSLAT" != -1) then {_hasSLAT = true;};
			};
		} forEach getArray (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "animationList");
		if (_hasCamo && _hasSLAT) then {
			BRPVP_menuOpcoes = [localize "str_cover_no_cover",localize "str_cover_camonet",localize "str_cover_slat",localize "str_cover_camonet_slat"];
			BRPVP_menuExecutaParam = [[0,0,0],[BRPVP_coverPrice,1,0],[BRPVP_coverPrice,0,1],[1.5*BRPVP_coverPrice,1,1]];
		};
		if (_hasCamo && !_hasSLAT) then {
			BRPVP_menuOpcoes = [localize "str_cover_no_cover",localize "str_cover_camonet"];
			BRPVP_menuExecutaParam = [[0,0,0],[BRPVP_coverPrice,1,0]];
		};
		if (!_hasCamo && _hasSLAT) then {
			BRPVP_menuOpcoes = [localize "str_cover_no_cover",localize "str_cover_slat"];
			BRPVP_menuExecutaParam = [[0,0,0],[BRPVP_coverPrice,0,1]];
		};
		BRPVP_menuExecutaFuncao = {
			params ["_price","_camonet","_slat"];
			_ok = if (_price > 0) then {
				_mny = player getVariable "mny";
				if (_mny >= _price) then {
					player setVariable ["mny",_mny-_price,true];
					"negocio" call BRPVP_playSound;
					call BRPVP_atualizaDebug;
					true
				} else {
					"erro" call BRPVP_playSound;
					false
				};
			} else {
				true
			};
			if (_ok) then {
				_animations = [];
				{
					if (_x isEqualType "") then {
						if (_x find "showCamonet" != -1) then {_animations append [_x,_camonet];};
						if (_x find "showSLAT" != -1) then {_animations append [_x,_slat];};
					};
				} forEach getArray (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "animationList");
				[BRPVP_stuff,false,_animations,false] remoteExecCall ["BIS_fnc_initVehicle",BRPVP_stuff];
				[BRPVP_stuff,true] remoteExecCall ["enableSimulationGlobal",2];
				[BRPVP_stuff getVariable ["id_bd",-1],_animations] remoteExecCall ["BRPVP_vehCoverSaveDB",2];
				"hint2" call BRPVP_playSound;
			};
			22 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},
	
	//MENU 87
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\store_money.paa'/>";
		BRPVP_menuOpcoes = (BRPVP_moneyItems select 1) apply {"$ "+(_x call BRPVP_formatNumber)};
		BRPVP_menuExecutaParam = BRPVP_moneyItems select 1;
		BRPVP_menuExecutaFuncao = {
			private _moneyLimit = [BRPVP_moneyItemsStoreLimit,BRPVP_superBoxMoneySize] select (typeOf BRPVP_stuff isEqualTo BRPVP_superBoxClass);
			if (BRPVP_stuff call BRPVP_getBoxMoney <= _moneyLimit-_this) then {
				_mny = player getVariable "mny";
				if (_mny >= _this) then {
					player setVariable ["mny",_mny-_this,true];
					_moneyMags = BRPVP_moneyItems select 0;
					_moneyMagsValor = BRPVP_moneyItems select 1;
					BRPVP_stuff addMagazineCargoGlobal [_moneyMags select (_moneyMagsValor find _this),1];
					"negocio" call BRPVP_playSound;
					if (BRPVP_stuff getVariable ["id_bd",-1] > -1) then {if !(BRPVP_stuff getVariable ["slv",false]) then {BRPVP_stuff setVariable ["slv",true,true];};};
				} else {
					"erro" call BRPVP_playSound;
				};
			} else {
				"erro" call BRPVP_playSound;
			};
			87 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},	

	//MENU 88
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_askServerForInvasionLogReturn = nil;
		[player,player getVariable "id_bd",BRPVP_vePlayers] remoteExecCall ["BRPVP_getInvasionLog",2];
		waitUntil {!isNil "BRPVP_askServerForInvasionLogReturn"};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = BRPVP_askServerForInvasionLogReturn;
		{
			private _isCfg = isClass (configFile >> "CfgVehicles" >> (_x select 2));
			private _name = if (_isCfg) then {getText (configFile >> "CfgVehicles" >> (_x select 2) >> "displayName") call BRPVP_escapeForStructuredTextFast} else {_x select 2};
			BRPVP_menuOpcoes pushBack _name;
		} forEach BRPVP_askServerForInvasionLogReturn;
		BRPVP_menuExecutaFuncao = {
			params ["_invId","_invName","_objClass","_objPos","_date"];
			_dateTxt = str (_date select 0) + "/" + str (_date select 1) + "/" + str (_date select 2) + " " + str (_date select 3) + ":" + str (_date select 4);
			_objPosTxt = str round ((_objPos select 0)/100) + ":" + str round ((_objPos select 1)/100);
			[format [localize "str_invader_log_entry",_dateTxt,str _invId + " - " + _invName,_objPosTxt],-20] call BRPVP_hint;
			"hint" call BRPVP_playSound;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 89
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuOpcoes = (call BRPVP_playersList) apply {str (_x getVariable ["id_bd",-1]) + " - " + ([_x getVariable ["nm","no_name_found"],name _x] select (_x call BRPVP_pAlive))};
		BRPVP_menuExecutaParam = call BRPVP_playersList;
		BRPVP_menuExecutaFuncao = {
			if (!isNull _this) then {
				_id = getPlayerUID _this;
				if (_id isEqualTo "") then {_id = _this getVariable ["id","0"]};
				[
					_this,
					[
						getPlayerUID player,
						player getVariable ["nm","no_name_found"],
						_id,
						[_this getVariable ["nm","no_name_found"],name _this] select alive _this,
						"You is banned.",
						5
					]
				] remoteExecCall ["BRPVP_banPlayer",2];
				[format [localize "str_player_banned",_this getVariable ["nm","no_name_found"]],-5] call BRPVP_hint;
			};
			29 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 90
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_askServerForBanListReturn = nil;
		player remoteExecCall ["BRPVP_getBanList",2];
		waitUntil {!isNil "BRPVP_askServerForBanListReturn"};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = BRPVP_askServerForBanListReturn;
		{
			_dt = _x select 4;
			_dtTxt = str (_dt select 0) + "/" + str (_dt select 1) + "/" + str (_dt select 2);
			_identity = (_x select 2) + " - " + (_x select 3);
			BRPVP_menuOpcoes pushBack (_dtTxt + " - " + _identity);
		} forEach BRPVP_askServerForBanListReturn;
		BRPVP_menuExecutaFuncao = {
			_banId = _this select 5;
			_banId remoteExecCall ["BRPVP_removeBan",2];
			_identity = (_this select 2) + " - " + (_this select 3);
			[format [localize "str_player_ban_removed",_identity],-4.5] call BRPVP_hint;
			29 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 91
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		private _quality = "Unknow";
		{if (_x select 1 select 0 isEqualTo BRPVP_terrainGrid) exitWith {_quality = _x select 0;};} forEach BRPVP_terrainGridConfig;
		BRPVP_menuOpcoes = [
			format [localize "str_on_ground",BRPVP_viewDist],
			format [localize "str_flying",BRPVP_viewDistFly],
			format [localize "str_terrain_quality",_quality],
			format [localize "str_terrain_dynamic",["   ","X"] select BRPVP_useTerrainDynamicResolution]
		];
		BRPVP_menuExecutaParam = [0,1,2,3];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {
				_idx = BRPVP_viewDistList find BRPVP_viewDist;
				_newIdx = if (_idx != -1) then {(_idx+1) mod count BRPVP_viewDistList} else {0};
				BRPVP_viewDist = BRPVP_viewDistList select _newIdx;
				BRPVP_viewObjsDist = BRPVP_viewObjsDistList select _newIdx;
				_cfg = player getVariable "brpvp_player_config";
				_cfg set [0,BRPVP_viewDist];
				player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
			};
			if (_this isEqualTo 1) then {
				_idx = BRPVP_viewDistListFly find BRPVP_viewDistFly;
				_newIdx = if (_idx != -1) then {(_idx+1) mod count BRPVP_viewDistListFly} else {0};
				BRPVP_viewDistFly = BRPVP_viewDistListFly select _newIdx;
				BRPVP_viewObjsDistFly = BRPVP_viewObjsDistListFly select _newIdx;
				_cfg = player getVariable "brpvp_player_config";
				_cfg set [1,BRPVP_viewDistFly];
				player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
			};
			if (_this isEqualTo 2) then {
				private _idx = 0;
				{if (_x select 1 select 0 isEqualTo BRPVP_terrainGrid) exitWith {_idx = _forEachIndex;};} forEach BRPVP_terrainGridConfig;
				private _nIdx = (_idx+1) mod count BRPVP_terrainGridConfig;
				private _cfg = BRPVP_terrainGridConfig select _nIdx select 1;
				if (BRPVP_useTerrainDynamicResolution) then {
					BRPVP_terrainGrid = _cfg select 0;
					BRPVP_terrainGridLook = _cfg select 1;
					BRPVP_terrainGridOnZoom = _cfg select 2;
				} else {
					BRPVP_terrainGrid = _cfg select 0;
					BRPVP_terrainGridLook = _cfg select 0;
					BRPVP_terrainGridOnZoom = _cfg select 0;
				};
				_cfg = player getVariable "brpvp_player_config";
				_cfg set [3,[BRPVP_terrainGridConfig select _nIdx select 0,BRPVP_useTerrainDynamicResolution]];
				player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
			};
			if (_this isEqualTo 3) then {
				BRPVP_useTerrainDynamicResolution = !BRPVP_useTerrainDynamicResolution;
				private _cfg = player getVariable "brpvp_player_config";
				private _cfgTerrain = _cfg select 3;
				if (_cfgTerrain isEqualType "") then {
					_cfgTerrain = [_cfgTerrain,BRPVP_useTerrainDynamicResolution];
				} else {
					_cfgTerrain set [1,BRPVP_useTerrainDynamicResolution];
				};
				_cfg set [3,_cfgTerrain];
				player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
				private _quality = _cfgTerrain select 0;
				private _cfgQuality = BRPVP_terrainGridConfig select 1 select 1;
				{if (_x select 0 isEqualTo _quality) exitWith {_cfgQuality = _x select 1;};} forEach BRPVP_terrainGridConfig;
				if (BRPVP_useTerrainDynamicResolution) then {
					BRPVP_terrainGrid = _cfgQuality select 0;
					BRPVP_terrainGridLook = _cfgQuality select 1;
					BRPVP_terrainGridOnZoom = _cfgQuality select 2;
				} else {
					BRPVP_terrainGrid = _cfgQuality select 0;
					BRPVP_terrainGridLook = _cfgQuality select 0;
					BRPVP_terrainGridOnZoom = _cfgQuality select 0;
				};
			};
			BRPVP_viewDistState = 0;
			91 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 92
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\wall_around.paa'/>";
		if (BRPVP_stuff getVariable ["brpvp_flag_wall_info",[]] isEqualTo []) then {
			BRPVP_menuOpcoes = [format [localize "str_flag_wall_add",BRPVP_wallAroundPrice call BRPVP_formatNumber]];
			BRPVP_menuExecutaParam = [0];
		} else {
			BRPVP_menuOpcoes = [
				format [localize "str_flag_wall_remove",(str round (100*BRPVP_wallAroundRemoveGain/BRPVP_wallAroundPrice))+"%"],
				format [localize "str_flag_wall_change",localize "str_free"]
			];
			BRPVP_menuExecutaParam = [1,2];
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {
				_cfg = BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected;
				BRPVP_menuVar1 = [/*OPENS COUNT*/4,/*OPEN SIZE*/_cfg select 5,/*ROTATE*/0,/*HSHIFT*/_cfg select 3,/*TERRAIN FIT*/_cfg select 4];
				93 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 1) then {
				_mnyBank = player getVariable ["brpvp_mny_bank",0];
				_mnyHand = player getVariable ["mny",0];
				_receiveOnBank = ((BRPVP_totalMoneyInBank-_mnyBank) max 0) min BRPVP_wallAroundRemoveGain;
				_receiveOnHand = BRPVP_wallAroundRemoveGain-_receiveOnBank;
				if (_receiveOnBank > 0) then {player setVariable ["brpvp_mny_bank",_mnyBank+_receiveOnBank,true];};
				if (_receiveOnHand > 0) then {player setVariable ["mny",_mnyHand+_receiveOnHand,true];};
				"negocio" call BRPVP_playSound;
				call BRPVP_atualizaDebug;
				BRPVP_stuff remoteExecCall ["BRPVP_removeWallFlag",2];
				BRPVP_stuff setVariable ["brpvp_flag_wall_info",[],true];
				22 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 2) then {
				_cfg = BRPVP_stuff getVariable "brpvp_flag_wall_info";
				BRPVP_stuff remoteExecCall ["BRPVP_removeWallFlag",2];
				BRPVP_stuff setVariable ["brpvp_flag_wall_info",[],true];
				_class = _cfg select 0;
				{if (_class isEqualTo (_x select 0)) exitWith {BRPVP_wallAroundOptionsSelected = _forEachIndex;};} forEach BRPVP_wallAroundOptions;
				BRPVP_menuVar1 = [/*OPENS COUNT*/_cfg select 5,/*OPEN SIZE*/_cfg select 6,/*ROTATE*/_cfg select 7,/*HSHIFT*/_cfg select 3,/*TERRAIN FIT*/_cfg select 4];
				BRPVP_menuVar2 = _cfg;
				95 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 93
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\wall_around.paa'/>";
		[
			BRPVP_stuff,
			BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0,
			BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 1,
			BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 2,
			BRPVP_menuVar1 select 3,
			BRPVP_menuVar1 select 4,
			BRPVP_menuVar1 select 0,
			BRPVP_menuVar1 select 1,
			BRPVP_menuVar1 select 2
		] call BRPVP_createWallAroundClient;
		BRPVP_menuOpcoes = [
			format [localize "str_wall_type",getText (configFile >> "CfgVehicles" >> (BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0) >> "displayName") call BRPVP_escapeForStructuredTextFast],
			format [localize "str_doors_plus",BRPVP_menuVar1 select 0],
			format [localize "str_doors_minus",BRPVP_menuVar1 select 0],
			format [localize "str_rotate_plus",BRPVP_menuVar1 select 2],
			format [localize "str_rotate_minus",BRPVP_menuVar1 select 2],
			format [localize "str_height_plus",BRPVP_menuVar1 select 3],
			format [localize "str_height_minus",BRPVP_menuVar1 select 3],
			format [localize "str_dsize_plus",BRPVP_menuVar1 select 1],
			format [localize "str_dsize_minus",BRPVP_menuVar1 select 1],
			format [localize "str_fit_terrain",if (BRPVP_menuVar1 select 4) then {"Yes"} else {"No"}],
			format [localize "str_flag_wall_conclude",BRPVP_wallAroundPrice call BRPVP_formatNumber]
		];
		BRPVP_menuExecutaParam = [0,1,2,3,4,5,6,7,8,9,10];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {
				BRPVP_wallAroundOptionsSelected = (BRPVP_wallAroundOptionsSelected + 1) mod count BRPVP_wallAroundOptions;
				_cfg = BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected;
				BRPVP_menuVar1 set [1,_cfg select 5];
				BRPVP_menuVar1 set [3,_cfg select 3];
				BRPVP_menuVar1 set [4,_cfg select 4];
			};
			if (_this isEqualTo 1) then {BRPVP_menuVar1 set [0,((BRPVP_menuVar1 select 0) + 1) min 4];};
			if (_this isEqualTo 2) then {BRPVP_menuVar1 set [0,((BRPVP_menuVar1 select 0) - 1) max 1];};
			if (_this isEqualTo 3) then {BRPVP_menuVar1 set [2,(BRPVP_menuVar1 select 2) + 5];};
			if (_this isEqualTo 4) then {BRPVP_menuVar1 set [2,(BRPVP_menuVar1 select 2) - 5];};
			if (_this isEqualTo 5) then {BRPVP_menuVar1 set [3,(BRPVP_menuVar1 select 3) + 1];};
			if (_this isEqualTo 6) then {BRPVP_menuVar1 set [3,(BRPVP_menuVar1 select 3) - 1];};
			if (_this isEqualTo 7) then {BRPVP_menuVar1 set [1,(BRPVP_menuVar1 select 1) + 1];};
			if (_this isEqualTo 8) then {BRPVP_menuVar1 set [1,(BRPVP_menuVar1 select 1) - 1];};
			if (_this isEqualTo 9) then {BRPVP_menuVar1 set [4,!(BRPVP_menuVar1 select 4)];};
			_wallConfig = [
				BRPVP_stuff,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 1,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 2,
				BRPVP_menuVar1 select 3,
				BRPVP_menuVar1 select 4,
				BRPVP_menuVar1 select 0,
				BRPVP_menuVar1 select 1,
				BRPVP_menuVar1 select 2
			];
			if (_this isEqualTo 10) then {
				_mny = player getVariable "brpvp_mny_bank";
				if (_mny >= BRPVP_wallAroundPrice) then {
					player setVariable ["brpvp_mny_bank",_mny - BRPVP_wallAroundPrice,true];
					"negocio" call BRPVP_playSound;
					call BRPVP_atualizaDebug;
					{deleteVehicle _x;} forEach BRPVP_createWallAroundClientObjs;
					_wallConfig remoteExecCall ["BRPVP_createWallAround",2];
					_wallConfigTxt = format [
						"[%1,'%2',%3,%4,%5,%6,%7,%8,%9] call BRPVP_createWallAround;",
						"_this",
						BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0,
						BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 1,
						BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 2,
						BRPVP_menuVar1 select 3,
						BRPVP_menuVar1 select 4,
						BRPVP_menuVar1 select 0,
						BRPVP_menuVar1 select 1,
						BRPVP_menuVar1 select 2
					];
					[BRPVP_stuff getVariable "id_bd",_wallConfigTxt] remoteExecCall ["BRPVP_addFlagWallDb",2];
					BRPVP_stuff setVariable ["brpvp_flag_wall_info",_wallConfig select [1,8],true];
					22 call BRPVP_menuMuda;
				} else {
					"erro" call BRPVP_playSound;
					[format [localize "str_no_money_bank",BRPVP_wallAroundPrice call BRPVP_formatNumber],-5] call BRPVP_hint;
					93 call BRPVP_menuMuda;
				};
			} else {
				_wallConfig call BRPVP_createWallAroundClient;
				93 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			{deleteVehicle _x;} forEach BRPVP_createWallAroundClientObjs;
			92 call BRPVP_menuMuda;
		};
	},

	//MENU 94
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuOpcoes = [];
		{
			if (_x getVariable ["brpvp_player_mode",""] isEqualTo "admin" && BRPVP_showAdminInfo) then {
				if !(_x getVariable ["brpvp_snOk",false]) then {BRPVP_menuOpcoes pushBack ("Admin: " + (_x getVariable "nm"));};
			} else {
				if (_x getVariable ["brpvp_player_mode",""] isEqualTo "moderator") then {
					BRPVP_menuOpcoes pushBack ("Moderator: " + (_x getVariable "nm"));
				};
			};
		} forEach call BRPVP_playersList;
		if (!BRPVP_showAdminInfo) then {BRPVP_menuOpcoes pushBack localize "str_admin_list_off";};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 95
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\wall_around.paa'/>";
		[
			BRPVP_stuff,
			BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0,
			BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 1,
			BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 2,
			BRPVP_menuVar1 select 3,
			BRPVP_menuVar1 select 4,
			BRPVP_menuVar1 select 0,
			BRPVP_menuVar1 select 1,
			BRPVP_menuVar1 select 2
		] call BRPVP_createWallAroundClient;
		BRPVP_menuOpcoes = [
			format [localize "str_wall_type",getText (configFile >> "CfgVehicles" >> (BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0) >> "displayName") call BRPVP_escapeForStructuredTextFast],
			format [localize "str_doors_plus",BRPVP_menuVar1 select 0],
			format [localize "str_doors_minus",BRPVP_menuVar1 select 0],
			format [localize "str_rotate_plus",BRPVP_menuVar1 select 2],
			format [localize "str_rotate_minus",BRPVP_menuVar1 select 2],
			format [localize "str_height_plus",BRPVP_menuVar1 select 3],
			format [localize "str_height_minus",BRPVP_menuVar1 select 3],
			format [localize "str_dsize_plus",BRPVP_menuVar1 select 1],
			format [localize "str_dsize_minus",BRPVP_menuVar1 select 1],
			format [localize "str_fit_terrain",if (BRPVP_menuVar1 select 4) then {"Yes"} else {"No"}],
			format [localize "str_flag_wall_conclude",localize "str_free"]
		];
		BRPVP_menuExecutaParam = [0,1,2,3,4,5,6,7,8,9,10];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {
				BRPVP_wallAroundOptionsSelected = (BRPVP_wallAroundOptionsSelected + 1) mod count BRPVP_wallAroundOptions;
				_cfg = BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected;
				BRPVP_menuVar1 set [1,_cfg select 5];
				BRPVP_menuVar1 set [3,_cfg select 3];
				BRPVP_menuVar1 set [4,_cfg select 4];
			};
			if (_this isEqualTo 1) then {BRPVP_menuVar1 set [0,((BRPVP_menuVar1 select 0) + 1) min 4];};
			if (_this isEqualTo 2) then {BRPVP_menuVar1 set [0,((BRPVP_menuVar1 select 0) - 1) max 1];};
			if (_this isEqualTo 3) then {BRPVP_menuVar1 set [2,(BRPVP_menuVar1 select 2) + 5];};
			if (_this isEqualTo 4) then {BRPVP_menuVar1 set [2,(BRPVP_menuVar1 select 2) - 5];};
			if (_this isEqualTo 5) then {BRPVP_menuVar1 set [3,(BRPVP_menuVar1 select 3) + 1];};
			if (_this isEqualTo 6) then {BRPVP_menuVar1 set [3,(BRPVP_menuVar1 select 3) - 1];};
			if (_this isEqualTo 7) then {BRPVP_menuVar1 set [1,(BRPVP_menuVar1 select 1) + 1];};
			if (_this isEqualTo 8) then {BRPVP_menuVar1 set [1,(BRPVP_menuVar1 select 1) - 1];};
			if (_this isEqualTo 9) then {BRPVP_menuVar1 set [4,!(BRPVP_menuVar1 select 4)];};
			_wallConfig = [
				BRPVP_stuff,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 1,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 2,
				BRPVP_menuVar1 select 3,
				BRPVP_menuVar1 select 4,
				BRPVP_menuVar1 select 0,
				BRPVP_menuVar1 select 1,
				BRPVP_menuVar1 select 2
			];
			if (_this isEqualTo 10) then {
				{deleteVehicle _x;} forEach BRPVP_createWallAroundClientObjs;
				_wallConfig remoteExecCall ["BRPVP_createWallAround",2];
				_wallConfigTxt = format [
					"[%1,'%2',%3,%4,%5,%6,%7,%8,%9] call BRPVP_createWallAround;",
					"_this",
					BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0,
					BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 1,
					BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 2,
					BRPVP_menuVar1 select 3,
					BRPVP_menuVar1 select 4,
					BRPVP_menuVar1 select 0,
					BRPVP_menuVar1 select 1,
					BRPVP_menuVar1 select 2
				];
				[BRPVP_stuff getVariable "id_bd",_wallConfigTxt] remoteExecCall ["BRPVP_addFlagWallDb",2];
				BRPVP_stuff setVariable ["brpvp_flag_wall_info",_wallConfig select [1,8],true];
				22 call BRPVP_menuMuda;
			} else {
				_wallConfig call BRPVP_createWallAroundClient;
				95 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			{deleteVehicle _x;} forEach BRPVP_createWallAroundClientObjs;
			_wallConfig = [BRPVP_stuff] + BRPVP_menuVar2;
			_wallConfig remoteExecCall ["BRPVP_createWallAround",2];
			_wallConfigTxt = format [
				"[%1,'%2',%3,%4,%5,%6,%7,%8,%9] call BRPVP_createWallAround;",
				"_this",
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 0,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 1,
				BRPVP_wallAroundOptions select BRPVP_wallAroundOptionsSelected select 2,
				BRPVP_menuVar1 select 3,
				BRPVP_menuVar1 select 4,
				BRPVP_menuVar1 select 0,
				BRPVP_menuVar1 select 1,
				BRPVP_menuVar1 select 2
			];
			[BRPVP_stuff getVariable "id_bd",_wallConfigTxt] remoteExecCall ["BRPVP_addFlagWallDb",2];
			BRPVP_stuff setVariable ["brpvp_flag_wall_info",_wallConfig select [1,8],true];
			92 call BRPVP_menuMuda;
		};
	},

	//MENU 96
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\personal_menu.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];

		hintSilent parseText ("<t align='center' size='1.65'>"+localize "str_please_wait"+"</t>");
		BRPVP_receiveVaultsTipsFromServer = nil;
		[player getVariable "id",clientOwner] remoteExecCall ["BRPVP_receiveVaultsTipsFromServerGet",2];
		waitUntil {!isNil "BRPVP_receiveVaultsTipsFromServer"};

		{
			_x params ["_idx","_tip","_fill"];
			BRPVP_menuOpcoes pushBack format ["%1 %2 %3%4",_idx+1,_tip,_fill,"%"];
			BRPVP_menuExecutaParam pushBack [_idx,_tip];
		} forEach BRPVP_receiveVaultsTipsFromServer;
		BRPVP_menuExecutaFuncao = {
			if (BRPVP_adminMsgAction select 0 isEqualTo "off") then {
				BRPVP_adminMsgAction = ["initiated",0];
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				_this spawn {
					params ["_idx","_tip"];
					disableSerialization;
					private _display = findDisplay 46 createDisplay "RscDisplayEmpty";
					_display displayAddEventHandler ["KeyUp",{if ((_this select 1) isEqualTo 0x1C) then {BRPVP_adminMsgAction = ["Ok",0];};}];

					private _input = _display ctrlCreate ["RscEdit",-1];
					_input ctrlSetPosition [0,0,1,0.065];
					_input ctrlSetBackgroundColor [0.25,0.25,0.25,1];
					_input ctrlSetText _tip;
					_input ctrlCommit 0;
					
					private _bOk = _display ctrlCreate ["RscButton",-1];
					_bOk ctrlSetPosition [0,0.1,0.15,0.065];
					_bOk ctrlSetText localize "str_ok";
					_bOk ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Ok",0];}];
					_bOk ctrlCommit 0;
					
					private _bCancel = _display ctrlCreate ["RscButton",-1];
					_bCancel ctrlSetPosition [0.175,0.1,0.15,0.065];
					_bCancel ctrlSetText localize "str_menu12_opt2";
					_bCancel ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Cancel",0];}];
					_bCancel ctrlCommit 0;

					ctrlSetFocus _input;
					BRPVP_mapDrawTime = 0;
					waitUntil {BRPVP_adminMsgAction select 0 != "initiated" || isNull _display};
					if (BRPVP_adminMsgAction select 0 isEqualTo "Ok") then {
						private _txtNew = ctrlText _input;
						private _txtDb = [[_txtNew,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
						[_txtDb select [0,32],player getVariable "id",_idx] remoteExecCall ["BRPVP_vaultTipSaveOnDb",2];
						BRPVP_iniciaMenuExtraBlock = true;

						if (!isNull _display) then {_display closeDisplay 1;};
						BRPVP_adminMsgAction = ["off",0];
						BRPVP_mapDrawTime = 0;

						uiSleep 0.25;
						BRPVP_iniciaMenuExtraBlock = false;
					} else {
						if (!isNull _display) then {_display closeDisplay 1;};
						BRPVP_adminMsgAction = ["off",0];
						BRPVP_mapDrawTime = 0;
					};
					96 call BRPVP_iniciaMenuExtra;
				};
			} else {
				"erro" call BRPVP_playSound;
			};			
		};
		BRPVP_menuVoltar = {132 call BRPVP_menuMuda;};
	},

	//MENU 97
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\control_center.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_menu_opt_cc_turrets",
			localize "str_menu_opt_cc_gates",
			localize "str_menu_opt_cc_houses",
			localize "str_menu_opt_cc_houses_others",
			localize "str_menu_opt_cc_vehicles",
			localize "str_menu_opt_cc_boxes",
			localize "str_menu_opt_cc_special"
		];
		BRPVP_menuExecutaParam = [
			[BRP_kitAutoTurret,							true,	{(_this getVariable ["id_bd",-1] isNotEqualTo -1)																			&& (_this getVariable ["own",-1] isEqualTo (player getVariable "id_bd") || call BRPVP_ccAccTypeCheck)}],
			[BRPVP_kitGroupsGates,						true,	{(_this getVariable ["id_bd",-1] isNotEqualTo -1)																			&& (_this getVariable ["own",-1] isEqualTo (player getVariable "id_bd") || call BRPVP_ccAccTypeCheck)}],
			[[],										true,	{(_this getVariable ["id_bd",-1] isNotEqualTo -1 || _this getVariable ["brpvp_map_god_mode_house_id",-1] isNotEqualTo -1) 	&& (_this getVariable ["own",-1] isEqualTo (player getVariable "id_bd") || call BRPVP_ccAccTypeCheck) && (typeof _this in BRPVP_kitGroupsHouses || _this getVariable ["brpvp_map_god_mode_house_id",-1] isNotEqualTo -1)}],
			[[],										true,	{(_this getVariable ["id_bd",-1] isNotEqualTo -1)																			&& (_this getVariable ["own",-1] isEqualTo (player getVariable "id_bd") || call BRPVP_ccAccTypeCheck) && (typeof _this in BRPVP_kitGroupsStuff)}],
			[["Tank","Car","Motorcycle","Air","Ship"],	true,	{(_this getVariable ["id_bd",-1] isNotEqualTo -1)																			&& (_this getVariable ["own",-1] isEqualTo (player getVariable "id_bd"))}],
			[BRP_kitFuelStorage,						true,	{(_this getVariable ["id_bd",-1] isNotEqualTo -1)																			&& (_this getVariable ["own",-1] isEqualTo (player getVariable "id_bd") || call BRPVP_ccAccTypeCheck)}],
			[[],										true,	{(_this getVariable ["id_bd",-1] isNotEqualTo -1)																			&& (_this getVariable ["own",-1] isEqualTo (player getVariable "id_bd") || call BRPVP_ccAccTypeCheck) && (typeOf _this in BRP_kitEspecial)}]
		];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this select 0;
			BRPVP_menuVar5 = _this select 1;
			BRPVP_menuVar2 = _this select 2;
			98 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 98
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\control_center.paa'/>";
		if (BRPVP_menuVar5) then {
			BRPVP_menuOpcoes = [localize "str_menu22_opt0",localize "str_menu22_opt4",localize "str_menu22_opt3"];
			BRPVP_menuExecutaParam = [99,100,110];
		} else {
			BRPVP_menuOpcoes = [localize "str_menu22_opt3"];
			BRPVP_menuExecutaParam = [110];
		};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar3 = _this;
			123 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {97 spawn BRPVP_menuMuda;};
	},

	//MENU 99
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [
			localize "str_menu23_opt0",
			localize "str_menu23_opt1",
			localize "str_menu23_opt2",
			localize "str_menu23_opt3",
			localize "str_menu23_opt4",
			localize "str_menu23_opt0_cst",
			localize "str_menu23_opt1_cst",
			localize "str_menu23_opt2_cst",
			localize "str_menu23_opt4_cst"
		];
		BRPVP_menuExecutaParam = [[0,false],[1,false],[2,false],[3,false],[4,false],[0,true],[1,true],[2,true],[4,true]];
		BRPVP_menuExecutaFuncao = {
			params ["_newStp","_useCustom"];
			private _count = 0;
			private _objsSoClass = [];
			private _objsSoIds = [];
			private _objsSoClassCVL = [];
			private _objsSoIdsCVL = [];
			{
				if (_x call BRPVP_menuVar2 && _x getVariable ["own",-1] isEqualTo BRPVP_menuVar4) then {
					private _oStp = _x getVariable ["stp",-1];
					private _oCst = _x getVariable ["amg",[[],[],-1]];
					if (count _oCst < 3) then {_oCst = -1;} else {_oCst = _oCst select 2;};
					if (_oStp isNotEqualTo _newStp || _oCst isNotEqualTo _useCustom) then {
						if (netId _x isEqualTo "0:0") then {
							if (typeOf _x in BRPVP_buildingHaveDoorListCVL) then {
								private _class = typeOf _x;
								private _id = _x getVariable "id_bd";
								private _idx = _objsSoClassCVL find _class;
								if (_idx isEqualTo -1) then {
									_objsSoClassCVL pushBack _class;
									_objsSoIdsCVL pushBack [_id];
								} else {
									(_objsSoIdsCVL select _idx) pushBack _id;
								};
							} else {
								private _class = typeOf _x;
								private _id = _x getVariable "id_bd";
								private _idx = _objsSoClass find _class;
								if (_idx isEqualTo -1) then {
									_objsSoClass pushBack _class;
									_objsSoIds pushBack [_id];
								} else {
									(_objsSoIds select _idx) pushBack _id;
								};
							};
						} else {
							_x setVariable ["stp",_newStp,true];
							_amg = _x getVariable ["amg",[[],[],_newStp in [1,2]]];
							if (count _amg isEqualTo 0 || {typeName (_amg select 0) isEqualTo "SCALAR"}) then {_amg = [_amg,[],_useCustom];} else {if (count _amg isEqualTo 2 && typeName (_amg select 0) isEqualTo "ARRAY") then {_amg pushBack _useCustom;} else {_amg set [2,_useCustom];};};
							_x setVariable ["amg",_amg,true];
							if !(_x getVariable ["slv_amg",false] || _x getVariable ["slv",false]) then {_x setVariable ["slv_amg",true,true];};
						};
					};
					_count = _count+1;
				};
			} forEach nearestObjects [BRPVP_stuff,BRPVP_menuVar1,BRPVP_stuff getVariable ["brpvp_flag_radius",0],true];
			[_objsSoClass,_objsSoIds,_newStp,_useCustom] remoteExecCall ["BRPVP_setObjShareTypeSimpleObject",0];
			[_objsSoClassCVL,_objsSoIdsCVL,_newStp,_useCustom] remoteExecCall ["BRPVP_setObjShareTypeSimpleObjectCVL",0];
			"hint" call BRPVP_playSound;
			call BRPVP_atualizaDebugMenu;
			[format [localize "str_cc_n_objs_changes",_count],-4] call BRPVP_hint;
		};
		BRPVP_menuVoltar = {123 spawn BRPVP_menuMuda;};
	},

	//MENU 100
	{
		BRPVP_menuTipo = 0;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuDestino = [101,102,103];
		BRPVP_menuCodigo = {};
		BRPVP_menuVoltar = {123 spawn BRPVP_menuMuda;};
		BRPVP_menuOpcoes = [
			localize "str_custom_friend_see",
			localize "str_custom_friend_add",
			localize "str_custom_friend_remove"
		];
	},

	//MENU 101
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		_amgCustom = [];
		{
			if (_x call BRPVP_menuVar2 && _x getVariable ["own",-1] isEqualTo BRPVP_menuVar4) then {_amgCustom append (_x getVariable ["amg",[0,[]]] select 1);};
		} forEach nearestObjects [BRPVP_stuff,BRPVP_menuVar1,BRPVP_stuff getVariable ["brpvp_flag_radius",0],true];
		_amgCustom arrayIntersect _amgCustom;
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		[_amgCustom,player,false] remoteExecCall ["BRPVP_pegaNomePeloIdBd1",2];
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno;
		BRPVP_menuVoltar = {100 call BRPVP_menuMuda;};
	},
	
	//MENU 102
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_id_bd = _x getVariable ["id_bd",-1];
			if (_id_bd >= 0) then {
				BRPVP_menuOpcoes pushBack (_x getVariable "nm");
				BRPVP_menuExecutaParam pushBack _id_bd;
			};
		} forEach call BRPVP_playersList;
		BRPVP_menuExecutaFuncao = BRPVP_confiarEmAlguemCustomCC;
		BRPVP_menuVoltar = {100 call BRPVP_menuMuda;};
	},
	
	//MENU 103
	{
		BRPVP_menuTipo = 2;
		_amgCustom = [];
		{
			if (_x call BRPVP_menuVar2 && _x getVariable ["own",-1] isEqualTo BRPVP_menuVar4) then {_amgCustom append (_x getVariable ["amg",[0,[]]] select 1);};
		} forEach nearestObjects [BRPVP_stuff,BRPVP_menuVar1,BRPVP_stuff getVariable ["brpvp_flag_radius",0],true];
		_amgCustom arrayIntersect _amgCustom;
		BRPVP_pegaNomePeloIdBd1 = [_amgCustom,player,true];
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		publicVariableServer "BRPVP_pegaNomePeloIdBd1";
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_menuOpcoes = BRPVP_pegaNomePeloIdBd1Retorno select 0;
		BRPVP_menuExecutaParam = BRPVP_pegaNomePeloIdBd1Retorno select 1;
		BRPVP_menuExecutaFuncao = BRPVP_deixarDeConfiarCustomCC;
		BRPVP_menuVoltar = {100 call BRPVP_menuMuda;};
	},

	//MENU 104
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\store_money.paa'/>";
		BRPVP_menuOpcoes = BRPVP_moneyItems select 1 apply {"$"+str _x};
		BRPVP_menuExecutaParam = BRPVP_moneyItems select 0;
		BRPVP_menuExecutaFuncao = {
			_sec = BRPVP_stuff getVariable ["brpvp_box_sec",[objNull,0]];
			if (isNull (_sec select 0) || _sec select 0 isEqualTo player || serverTime-(_sec select 1) > 6) then {
				if (!(_sec select 0 isEqualTo player) || serverTime-(_sec select 1) > 3) then {BRPVP_stuff setVariable ["brpvp_box_sec",[player,serverTime],true];};
				_mags = getMagazineCargo BRPVP_stuff;
				_ok = false;
				{
					if (_x isEqualTo _this) exitWith {
						_mags select 1 set [_forEachIndex,(_mags select 1 select _forEachIndex)-1];
						_ok = true;
					};
				} forEach (_mags select 0);
				if (_ok) then {
					_idx = (BRPVP_moneyItems select 0) find _this;
					_money = BRPVP_moneyItems select 1 select _idx;
					player setVariable ["mny",(player getVariable ["mny",0])+_money,true];
					"negocio" call BRPVP_playSound;
					clearMagazineCargoGlobal BRPVP_stuff;
					{BRPVP_stuff addMagazineCargoGlobal [_x,_mags select 1 select _forEachIndex];} forEach (_mags select 0);
				} else {
					[localize "str_box_no_flare",-4] call BRPVP_hint;
					"erro" call BRPVP_playSound;
				};
			} else {
				"erro" call BRPVP_playSound;
				[localize "str_get_money_cant",-5] call BRPVP_hint;
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},
	//MENU 105
	{
		BRPVP_menuSleep = 1;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\store.paa'/>";
		BRPVP_myStoreItens = nil;
		player remoteExecCall ["BRPVP_getMyStoreItens",2];
		waitUntil {!isNil "BRPVP_myStoreItens"};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_x params ["_id","_item","_checkout"];
			{
				_code = _x select 0;
				if (_item isEqualTo _code) exitWith {
					_name = _x select 1;
					BRPVP_menuOpcoes pushBack _name;
					BRPVP_menuExecutaParam pushBack [_id,_item,_checkout];
				};
			} forEach BRPVP_storeItems;
		} forEach BRPVP_myStoreItens;
		BRPVP_menuExecutaFuncao = {
			params ["_id","_item","_checkout"];
			{
				_code = _x select 0;
				if (_item isEqualTo _code) exitWith {
					_id remoteExecCall ["BRPVP_setStoreItemAsDelivered",2];
					_exec = _x select 2;
					call _exec;
				};
			} forEach BRPVP_storeItems;
			BRPVP_menuSleep = 0;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 106
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\ceil.paa'/>";
		_config = BRPVP_stuff getVariable ["brpvp_ceil_config",[]];
		BRPVP_menuVar1 = if (_config isEqualTo []) then {20} else {_config select 0};
		BRPVP_menuVar2 = if (_config isEqualTo []) then {0} else {_config select 1};
		BRPVP_menuVar3 = if (_config isEqualTo []) then {0} else {if (count _config > 2) then {_config select 2} else {0}};
		BRPVP_menuVar4 = if (_config isEqualTo []) then {0} else {if (count _config > 3) then {_config select 3} else {0}};
		_flag = objNull;
		{if (BRPVP_stuff distance _x <= _x getVariable ["brpvp_flag_radius",0]) exitWith {_flag = _x;};} forEach nearestObjects [BRPVP_stuff,["FlagCarrier"],200,true];
		if (isNull _flag) then {
			BRPVP_menuOpcoes = [];
			BRPVP_menuExecutaParam = [];
			[localize "str_add_ceil_no_near_flag",-5] call BRPVP_hint;
		} else {
			BRPVP_menuVarF = _flag;
			BRPVP_stuff remoteExecCall ["BRPVP_removeCeilObjects",2];
			[BRPVP_menuVarF,BRPVP_menuVar1,BRPVP_menuVar2,BRPVP_menuVar3,BRPVP_menuVar4] call BRPVP_ceilCreateLocal;
			BRPVP_menuOpcoes = [
				localize "str_base_ceil_height"+" +1.00",
				localize "str_base_ceil_height"+" -1.00",
				localize "str_base_ceil_height"+" +0.25",
				localize "str_base_ceil_height"+" -0.25",
				localize "str_base_ceil_hole"+" +5.00",
				localize "str_base_ceil_hole"+" -5.00",
				localize "str_base_ceil_radial"+" +10.00",
				localize "str_base_ceil_radial"+" -10.00",
				localize "str_base_ceil_rotate"+" +5.00",
				localize "str_base_ceil_rotate"+" -5.00",
				localize "str_base_ceil_create",
				localize "str_base_ceil_remove"
			];
			BRPVP_menuExecutaParam = [0,1,2,3,4,5,6,7,8,9,10,11];
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {BRPVP_menuVar1 = (BRPVP_menuVar1+1) min 200;};
			if (_this isEqualTo 1) then {BRPVP_menuVar1 = (BRPVP_menuVar1-1) max 0;};
			if (_this isEqualTo 2) then {BRPVP_menuVar1 = (BRPVP_menuVar1+0.25) min 200;};
			if (_this isEqualTo 3) then {BRPVP_menuVar1 = (BRPVP_menuVar1-0.25) max 0;};
			if (_this isEqualTo 4) then {BRPVP_menuVar2 = (BRPVP_menuVar2+5) min (BRPVP_menuVarF getVariable ["brpvp_flag_radius",0]);};
			if (_this isEqualTo 5) then {BRPVP_menuVar2 = (BRPVP_menuVar2-5) max 0;};
			if (_this isEqualTo 6) then {BRPVP_menuVar3 = (BRPVP_menuVar3+10) min 90;};
			if (_this isEqualTo 7) then {BRPVP_menuVar3 = (BRPVP_menuVar3-10) max 0;};
			if (_this isEqualTo 8) then {BRPVP_menuVar4 = (BRPVP_menuVar4+5) min 360;};
			if (_this isEqualTo 9) then {BRPVP_menuVar4 = (BRPVP_menuVar4-5) max -360;};
			if (_this <= 9) then {
				"ciclo" call BRPVP_playSound;
				[BRPVP_menuVarF,BRPVP_menuVar1,BRPVP_menuVar2,BRPVP_menuVar3,BRPVP_menuVar4] call BRPVP_ceilCreateLocal;
			};
			if (_this isEqualTo 10) then {
				{deleteVehicle _x;} forEach BRPVP_ceilCreateLocalObjs;
				[BRPVP_stuff,BRPVP_menuVar1,BRPVP_menuVar2,BRPVP_menuVar3,BRPVP_menuVar4] remoteExecCall ["BRPVP_ceilCreateServer",2];
				22 call BRPVP_menuMuda;
			};
			if (_this isEqualTo 11) then {
				{deleteVehicle _x;} forEach BRPVP_ceilCreateLocalObjs;
				BRPVP_stuff remoteExecCall ["BRPVP_ceilExecRemove",2];
				22 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			{deleteVehicle _x;} forEach BRPVP_ceilCreateLocalObjs;
			_config = BRPVP_stuff getVariable ["brpvp_ceil_config",[]];
			if !(_config isEqualTo []) then {
				[
					BRPVP_stuff,
					_config select 0,
					_config select 1,
					if (count _config > 2) then {_config select 2} else {0},
					if (count _config > 3) then {_config select 3} else {0}
				] remoteExecCall ["BRPVP_ceilCreateServer",2];
			};
			22 call BRPVP_menuMuda;
		};
	},

	//MENU 107
	{
		BRPVP_menuSleep = 0.5;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\bury_money.paa'/>";
		_near = nearestObjects [player,["Land_ClutterCutter_medium_F"],3.5];
		_nearOk = [];
		{if !((_x getVariable ["mny",-1] isEqualTo -1 && _x getVariable ["brpvp_box",""] isEqualTo "") || _x getVariable ["brpvp_off",false]) then {_nearOk pushBack _x;};} forEach _near;
		BRPVP_menuOpcoes = [localize "str_bury_money_put"];
		BRPVP_menuExecutaParam = ["put money"];
		_box = player getVariable ["brpvp_box_carry",objNull];
		if (!isNull _box) then {
			BRPVP_menuOpcoes pushBack localize "str_bury_box_put";
			BRPVP_menuExecutaParam pushBack "put box";
		};
		_cbox = 0;
		{
			_boxClass = _x getVariable ["brpvp_box",""];
			if (_boxClass isNotEqualTo "") then {
				_cbox = _cbox+1;
				BRPVP_menuOpcoes pushBack format [localize "str_buried_items",_cbox];
				BRPVP_menuExecutaParam pushBack _x;
			};
		} forEach _nearOk;
		{
			_mny = _x getVariable ["mny",-1];
			if (_mny isNotEqualTo -1) then {
				BRPVP_menuOpcoes pushBack (format [localize "str_bury_money_get",_mny call BRPVP_formatNumber]);
				BRPVP_menuExecutaParam pushBack _x;
			};
		} forEach _nearOk;
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "put money") then {
				108 call BRPVP_menuMuda;
			} else {
				if (_this isEqualTo "put box") then {
					_box = player getVariable ["brpvp_box_carry",objNull];
					_model = player getVariable ["brpvp_box_carry_model",objNull];
					if (isNull _box) then {
						"erro" call BRPVP_playSound;
					} else {
						_hole = createVehicle ["Land_ClutterCutter_medium_F",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
						_hole setVariable ["id_bd",1];
						_inventory = _box call BRPVP_getCargoArray;
						_data = [
							[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],
							[(getPosWorld _hole) vectorAdd [-0.5*random 1,-0.5*random 1,-0.1*random 0.2],[vectorDir _hole,vectorUp _hole]],
							typeOf _hole,
							player getVariable ["id_bd",-1],
							1,
							[[],[],true],
							format ["_this setVariable ['brpvp_box','%1',true];_this setVariable ['brpvp_box_inventory',%2,true];",typeOf _box,[str _inventory,"""","'"] call BRPVP_stringReplace],
							[0,0,0,0,0,0]
						];
						_hole setVariable ["brpvp_box",typeOf _box,true];
						_hole setVariable ["brpvp_box_inventory",_inventory,true];
						[_hole,_data] remoteExecCall ["BRPVP_addHoleToDB",2];
						BRPVP_boxCarryAction = false;
						detach _model;
						deleteVehicle _model;
						deleteVehicle _box;
						[localize "str_bury_box_you_stored",-5] call BRPVP_hint;
						BRPVP_carryingBox = false;
						player setVariable ["brpvp_vault_perc",[0,0,"#FFFFFF"],BRPVP_specOnMeMachines];
					};
					107 spawn BRPVP_menuMuda;
				} else {
					if (isNull _this) then {
						"erro" call BRPVP_playSound;
					} else {
						_this setVariable ["brpvp_off",true];
						[_this,player] remoteExecCall ["BRPVP_getHoleMoney",2];
					};
					107 spawn BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_buryMoneyActionOn = false;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 108
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\bury_money.paa'/>";
		BRPVP_menuOpcoes = [
			"$ 250 000",
			"$ 500 000",
			"$ 1 000 000",
			"$ 1 500 000",
			"$ 2 000 000",
			"$ 3 000 000",
			"$ 4 000 000",
			"$ 5 000 000",
			"$ 10 000 000",
			"$ 25 000 000",
			"$ 50 000 000",
			"$ 100 000 000",
			"$ 200 000 000"
		];
		BRPVP_menuExecutaParam = [250000,500000,1000000,1500000,2000000,3000000,4000000,5000000,10000000,25000000,50000000,100000000,200000000];
		BRPVP_menuExecutaFuncao = {
			_mny = player getVariable ["mny",0];
			if (_mny >= _this) then {
				player setVariable ["mny",_mny-_this,true];
				"negocio" call BRPVP_playSound;
				private _pid = player getVariable "id_bd";
				private _nhp = nearestObjects [player,["Land_ClutterCutter_medium_F"],3] select {_x getVariable ["own",-1] isEqualTo _pid && _x getVariable ["mny",-1] isNotEqualTo -1};
				if (_nhp isEqualTo [] || {((_nhp select 0) getVariable "mny")+_this >= 500000000}) then {
					_hole = createVehicle ["Land_ClutterCutter_medium_F",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
					_hole setVariable ["own",_pid,true];
					_hole setVariable ["mny",_this,true];
					_hole setVariable ["id_bd",1];
					_data = [
						[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],
						[(getPosWorld _hole) vectorAdd [-0.5*random 1,-0.5*random 1,-0.1*random 0.2],[vectorDir _hole,vectorUp _hole]],
						typeOf _hole,
						player getVariable ["id_bd",-1],//OWN
						1,//STP
						[[],[],true],//AMG
						format ["_this setVariable ['mny',%1,true]",_this], //EXEC
						[0,0,0,0,0,0]
					];
					[_hole,_data] remoteExecCall ["BRPVP_addHoleToDB",2];
				} else {
					private _hole = _nhp select 0;
					private _hid = _hole getVariable "id_bd";
					private _mny = (_hole getVariable "mny")+_this;
					_hole setVariable ["mny",_mny,true];
					[_hid,format ["_this setVariable ['mny',%1,true]",_mny]] remoteExecCall ["BRPVP_updateTurretExec",2];
				};
				[format [localize "str_bury_money_you_stored_x",_this call BRPVP_formatNumber],-4] call BRPVP_hint;
				107 spawn BRPVP_menuMuda;
			} else {
				"erro" call BRPVP_playSound;
				[localize "str_bury_money_need_wallet_money",-5] call BRPVP_hint;
			};
		};
		BRPVP_menuVoltar = {107 spawn BRPVP_menuMuda;};
	},

	//MENU 109
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/> <img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		call BRPVP_pegaListaPlayersOriginalAlive;
		BRPVP_menuExecutaFuncao = {if (alive _this && _this getVariable ["sok",false]) then {[_this,getUnitLoadout player] remoteExecCall ["BRPVP_setLoadout",_this];} else {"erro" call BRPVP_playSound;};};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 110
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersAllPlayer;
		BRPVP_menuExecutaFuncao = {
			if (isNull _this) then {
				"erro" call BRPVP_playSound;
				110 call BRPVP_menuMuda;
			} else {
				_objs = [];
				_objsSoClass = [];
				_objsSoIds = [];
				_objsSoClassCVL = [];
				_objsSoIdsCVL = [];
				_idNO = _this getVariable ["id_bd",-1];
				_count = 0;
				{
					if (_x call BRPVP_menuVar2 && _x getVariable ["own",-1] isEqualTo BRPVP_menuVar4) then {
						private _objOwn = _x getVariable ["own",-1];
						if (_objOwn isNotEqualTo _idNO) then {
							if (netId _x isEqualTo "0:0") then {
								if (typeOf _x in BRPVP_buildingHaveDoorListCVL) then {
									private _class = typeOf _x;
									private _id = _x getVariable "id_bd";
									private _idx = _objsSoClassCVL find _class;
									if (_idx isEqualTo -1) then {
										_objsSoClassCVL pushBack _class;
										_objsSoIdsCVL pushBack [_id];
									} else {
										(_objsSoIdsCVL select _idx) pushBack _id;
									};
								} else {
									private _class = typeOf _x;
									private _id = _x getVariable "id_bd";
									private _idx = _objsSoClass find _class;
									if (_idx isEqualTo -1) then {
										_objsSoClass pushBack _class;
										_objsSoIds pushBack [_id];
									} else {
										(_objsSoIds select _idx) pushBack _id;
									};
								};
							} else {
								_objs pushBack _x;
							};
						};
						_count = _count+1;
					};
				} forEach nearestObjects [BRPVP_stuff,BRPVP_menuVar1,BRPVP_stuff getVariable ["brpvp_flag_radius",0],true];
				[_objs,_this] call BRPVP_changePropsOwnerMany;
				[_objsSoClass,_objsSoIds,_this,BRPVP_menuVar4] remoteExecCall ["BRPVP_changePropsOwnerManySimpleObject",0];
				[_objsSoClassCVL,_objsSoIdsCVL,_this,BRPVP_menuVar4] remoteExecCall ["BRPVP_changePropsOwnerManySimpleObjectCVL",0];
				[format [localize "str_cc_n_objs_changes",_count],-4] call BRPVP_hint;
				"ugranted" call BRPVP_playSound;
				123 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {123 spawn BRPVP_menuMuda;};
	},

	//MENU 111
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\insurance.paa'/>";
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				0 spawn {
					BRPVP_insuranceCheckExistenceAnswer = nil;
					[player,BRPVP_stuff] remoteExecCall ["BRPVP_insuranceCheckExistence",2];
					waitUntil {!isNil "BRPVP_insuranceCheckExistenceAnswer"};
					if (BRPVP_insuranceCheckExistenceAnswer isEqualTo 0) then {
						if (alive BRPVP_stuff) then {
							_mny = player getVariable ["mny",0];
							_price = BRPVP_stuff call BRPVP_getInsurancePrice;
							if (_mny >= _price) then {
								BRPVP_insuranceAddContractReturn = nil;
								[player,BRPVP_stuff] remoteExecCall ["BRPVP_insuranceAddContract",2];
								waitUntil {!isNil "BRPVP_insuranceAddContractReturn"};
								private _insuranceTimesLimit = if (BRPVP_stuff isKindOf "Plane") then {BRPVP_insuranceTimesLimitPlane} else {if (BRPVP_stuff isKindOf "Helicopter") then {BRPVP_insuranceTimesLimitHeli} else {BRPVP_insuranceTimesLimit};};
								if (BRPVP_insuranceAddContractReturn > _insuranceTimesLimit) then {
									"erro" call BRPVP_playSound;
									[format [localize "str_all_insurances_consumed",_insuranceTimesLimit,_insuranceTimesLimit],-5] call BRPVP_hint;
								} else {
									player setVariable ["mny",_mny-_price,true];
									"negocio" call BRPVP_playSound;
									[format [localize "str_insurance_conclude_ok",BRPVP_insuranceAddContractReturn,_insuranceTimesLimit],-6] call BRPVP_hint;
								};
							} else {
								[localize "str_bury_money_need_wallet_money",-6] call BRPVP_hint;
								"erro" call BRPVP_playSound;
							};
						} else {
							"erro" call BRPVP_playSound;
						};
					} else {
						[localize "str_insurance_already_have",-6] call BRPVP_hint;
					};
				};
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 112
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\insurance.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_insuranceRecoverListAnswer = nil;
		player remoteExecCall ["BRPVP_insuranceRecoverList",2];
		waitUntil {!isNil "BRPVP_insuranceRecoverListAnswer"};
		if (BRPVP_insuranceRecoverListAnswer isEqualTo []) then {
			BRPVP_menuOpcoes = [localize "str_menu12_opt2"];
			BRPVP_menuExecutaParam = [["",-1]];
		} else {
			{
				_x params ["_class","_id"];
				BRPVP_menuOpcoes pushBack (getText (configFile >> "CfgVehicles" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast);
				BRPVP_menuExecutaParam pushBack [_class,_id];
			} forEach BRPVP_insuranceRecoverListAnswer;
		};
		BRPVP_menuExecutaFuncao = {
			params ["_class","_id"];
			if (_id isEqualTo -1) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				_best = (ASLToAGL getPosASL player) findEmptyPosition [30,100,_class];
				if (_best isEqualTo []) then {
					"erro" call BRPVP_playSound;
				} else {
					_veh = createVehicle [_class,BRPVP_spawnVehicleFirstPos,[],100,"NONE"];
					_veh setVariable ["brpvp_time_can_disable",serverTime+5,2];

					//PROTECT
					_veh setVariable ["brpvp_coll_prot",true];
					_veh lock true;
					_veh spawn {
						private _init = diag_tickTime;
						_this allowDamage false;
						waitUntil {
							if (vectorMagnitude velocity _this > 0.125) then {_init = diag_tickTime;};
							diag_tickTime-_init > 2
						};
						_this setVariable ["brpvp_coll_prot",false];
						_this allowDamage true;
						_this lock false;
					};

					//SET CUSTOM CARGO SIZE
					{
						_x params ["_classCheck","_name","_cargo"];
						if (_classCheck isEqualTo _class) exitWith {[_veh,_cargo] remoteExecCall ["setMaxLoad",2];};
					} forEach BRPVP_customCargoVehiclesCfg;

					_veh call BRPVP_setVehServicesToZero;
					_veh call BRPVP_setVehRadarAndThermal;
					_best = _best vectorAdd [0,0,0.5];
					_veh setPosASL AGLToASL _best;
					_veh setVelocity [0,0,0];
					_isDrone = _class in BRPVP_vantVehiclesClass;
					if (_class isEqualTo "B_UAV_05_F") then {
						_wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
						{_veh animateSource [_x,1,true];} forEach _wingAnimations;
					};
					if (_isDrone) then {
						//createVehicleCrew _veh;
						if (BRPVP_dronesMakeAllUnarmed) then {
							{
								_veh setPylonLoadout [configName _x,""];
							} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "pylons"));
						};
						_veh setVariable ["brpvp_auto_first",true,true];
					};
					clearWeaponCargoGlobal _veh;
					clearMagazineCargoGlobal _veh;
					clearItemCargoGlobal _veh;
					clearBackpackCargoGlobal _veh;
					_veh setVariable ["own",player getVariable "id_bd",true];
					_veh setVariable ["stp",player getVariable "dstp",true];
					_veh setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
					_veh setVariable ["brpvp_locked",true,true];
					_state = [
						[3,[["brpvp_main_container",[[],[],[[],[]],[[],[]]]]]],
						[getPosWorld _veh,[vectorDir _veh,vectorUp _veh]],
						typeOf _veh,
						_veh getVariable "own",
						_veh getVariable "stp",
						_veh getVariable ["amg",[[],[],true]],
						"",
						[0,0,0,0,0,0],
						_veh call BRPVP_getVehicleAmmo,
						_veh call BRPVP_getHitpointsDamage,
						0
					];
					[false,_veh,_state] remoteExecCall ["BRPVP_adicionaConstrucaoBd",2];
					_id remoteExecCall ["BRPVP_insuranceSetDelivered",2];
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					"granted" call BRPVP_playSound;
					[_id,_veh] spawn {
						params ["_id","_veh"];
						private _sequence = -1;
						waitUntil {
							_sequence = _veh getVariable ["id_bd",-1];
							_sequence > -1
						};
						[_id,_sequence] remoteExecCall ["BRPVP_insuranceSetSequence",2];
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 113
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\insurance.paa'/>";
		BRPVP_menuOpcoes = [localize "str_opt_see_veh_price",localize "str_psellveh_action"];
		BRPVP_menuExecutaParam = [1,2];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 1) then {
				_price = call BRPVP_getVehicleSellPrice;
				if (_price isEqualTo -1) then {
					"erro" call BRPVP_playSound;
				} else {
					_prcTxt = _price call BRPVP_formatNumber;
					_name = getText (configFile >> "CfgVehicles" >> typeOf (call BRPVP_getSellVehicle) >> "displayName");
					[format [localize "str_this_veh_price_is",_name,_prcTxt],-6.5] call BRPVP_hint;
				};
			};
			if (_this isEqualTo 2) then {
				if (call BRPVP_sellVehicleCode) then {
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 114
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\bus_service.paa'/>";
		_array = [];

		//FIND FROM
		_p1 = ASLToAGL getPosASL player;
		_min = 10000000;
		_startIdx = -1;
		{
			_p2 = _x select 0;
			_dist = _p1 distance2D _p2;
			if (_dist < _min) then {
				_min = _dist;
				_startIdx = _forEachIndex;
			};
		} forEach BRPVP_busServiceStopPoints;
		
		//ROUTE AND PRICE
		{
			_x params ["_name","_param","_endIdx"];
			_dist = player distance _param;
			if (_dist > 100) then {
				//FIND DISTANCE
				_bestWayMin = 0;
				{
					_x params ["_f","_t","_d"];
					if (_f isEqualTo _startIdx && _t isEqualTo _endIdx) exitWith {_bestWayMin = _d;};
				} forEach BRPVP_busServiceDistances;
				
				//SET MENU OPTIONS
				_tm = (_bestWayMin/BRPVP_busServiceMaximumDistPrice) min 1;
				_tm = (10*round (180*_tm/10)) max 10;
				_price = _tm*800*BRPVP_xpBusPriceMult;
				_array pushBack [_bestWayMin,format [localize "str_bus_stop_option",_name,_tm,_price],[_param,_tm,_price]];
			};
		} forEach BRPVP_busServiceStopMenuParam;
		_array sort true;
		BRPVP_menuOpcoes = _array apply {_x select 1};
		BRPVP_menuExecutaParam = _array apply {_x select 2};
		BRPVP_menuExecutaFuncao = {
			_price = _this select 2;
			_mnyBank = player getVariable ["brpvp_mny_bank",0];
			if (_mnyBank >= _price) then {
				"negocio" call BRPVP_playSound;
				player setVariable ["brpvp_mny_bank",_mnyBank-_price,true];
				BRPVP_menuExtraLigado = false;
				hintSilent "";

				//START TRAVEL
				if (player call BRPVP_pAlive) then {
					player allowDamage false;
					[player,true] remoteExecCall ["hideObjectGlobal",2];
					player setVariable ["brpvp_on_bus",true,true];
					_this spawn {
						params ["_param","_tme","_price"];
						//CALC DETAILED PATH
						[localize "str_bus_calc_route",-6] call BRPVP_hint;
						_from = getPosATL ([getPosATL player] call BIS_fnc_nearestRoad);
						_from set [2,0];
						_to = getPosATL ([_param] call BIS_fnc_nearestRoad);
						_to set [2,0];

						BRPVP_calcPathResult1 = nil;
						isNil {
							calculatePath ["C_Quadbike_01_F","CARELESS",_from,_to] addEventHandler [
								"PathCalculated",
								{
									deleteVehicle (_this select 0);
									private _path = [];
									private _pos = BRPVP_posicaoFora select [0,2];
									{
										private _px = _x select [0,2];
										if (_px distance _pos > 25) then {_path pushBack _px;_pos = _px;};
									} forEach (_this select 1);
									private _result = [];
									private _dist = 0;
									for "_i" from 0 to ((count _path)-2) do {
										_result pushBack [_path select _i,_path select (_i+1)];
										_dist = _dist+((_path select _i) distance (_path select (_i+1)));
									};
									BRPVP_calcPathResult1 = [_result,_dist];
								}
							];
						};
						waitUntil {!isNil "BRPVP_calcPathResult1"};
						_bestWayPair = BRPVP_calcPathResult1 select 0;
						_bestWayMin = BRPVP_calcPathResult1 select 1;

						//DO TRAVEL					
						BRPVP_busDestine = _param;
						BRPVP_busStopNow = false;
						_shadowOld = getShadowDistance;
						setShadowDistance 0;
						(_tme/10) spawn {
							BRPVP_busCanPressStop = true;
							for "_i" from 1 to _this do {
								private _init = diag_tickTime;
								[format [localize "str_bus_sec_left",(_this-_i+1)*10],-6] call BRPVP_hint;
								[player,["bus_move",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
								uiSleep (2-((diag_tickTime-_init)-0));
								if (!BRPVP_busCanPressStop && _i < _this) exitWith {BRPVP_busStopNow = true;};
								uiSleep (2-((diag_tickTime-_init)-2));
								if (!BRPVP_busCanPressStop && _i < _this) exitWith {BRPVP_busStopNow = true;};
								uiSleep (2-((diag_tickTime-_init)-4));
								if (!BRPVP_busCanPressStop && _i < _this) exitWith {BRPVP_busStopNow = true;};
								uiSleep (2-((diag_tickTime-_init)-6));
								if (!BRPVP_busCanPressStop && _i < _this) exitWith {BRPVP_busStopNow = true;};
								uiSleep (2-((diag_tickTime-_init)-8));
								if (!BRPVP_busCanPressStop && _i < _this) exitWith {BRPVP_busStopNow = true;};
							};
							[player,["bus_move_fade_out",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
						};
						_vel = _bestWayMin/_tme;
						_dirOld = [_bestWayPair select 0 select 0,_bestWayPair select 0 select 1] call BIS_fnc_dirTo;
						_timeSegSum = 0;
						_moveSum = 0;
						player action ["SwitchWeapon",player,player,100];
						private _bCnt = count _bestWayPair;
						BRPVP_busReData = [player,getPosASL player,getDir player,_bCnt,_bestWayPair,_bestWayMin,_tme,_vel,_dirOld,_timeSegSum,_moveSum];
						if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {BRPVP_busReData remoteExec ["BRPVP_specDoBus",BRPVP_specOnMeMachinesNoMe];};

						//HIDE ATTACHED OBJECTS
						private _attachedObjects = attachedObjects player;
						private _aoBeforeHidden = _attachedObjects apply {isObjectHidden _x};
						{[_x,true] remoteExecCall ["hideObjectGlobal",2];} forEach _attachedObjects;

						{
							BRPVP_busReData = [player,getPosASL player,getDir player,_bCnt-_forEachIndex,_bestWayPair select [_forEachIndex,_bCnt-_forEachIndex],_bestWayMin,_tme,_vel,_dirOld,_timeSegSum,_moveSum];
							_x params ["_start","_end"];
							_start = _start+[1];
							_end = _end+[1];
							private _s2 = if (_forEachIndex+1 <= _bCnt-1) then {(_bestWayPair select (_forEachIndex+1) select 1)+[1]} else {_end vectorAdd (_end vectorDiff _start)};
							private _move = _end distance _start;
							private _timeSeg = _move/_vel;
							private _asl1 = AGLToASL _start;
							private _asl2 = AGLToASL _end;
							private _lis1 = lineIntersectsSurfaces [_asl1 vectorAdd [0,0,50],_asl1 vectorAdd [0,0,-5],player,objNull];
							private _lis2 = lineIntersectsSurfaces [_asl2 vectorAdd [0,0,50],_asl2 vectorAdd [0,0,-5],player,objNull];
							_asl1 = if (_lis1 isEqualTo [] || {str (_lis1 select 0 select 2) find ": bridge_" isEqualTo -1}) then {_asl1} else {(_lis1 select 0 select 0) vectorAdd [0,0,1]};
							_asl2 = if (_lis2 isEqualTo [] || {str (_lis2 select 0 select 2) find ": bridge_" isEqualTo -1}) then {_asl2} else {(_lis2 select 0 select 0) vectorAdd [0,0,1]};
							private _dirNew = [_end,_s2] call BIS_fnc_dirTo;
							private _delta = 0;
							private _init = diag_tickTime;
							private _vda = [sin _dirOld,cos _dirOld,0];
							private _vdd = [sin _dirNew,cos _dirNew,0];
							waitUntil {
								_delta = diag_tickTime-_init;
								private _perc = (_delta/_timeSeg) min 1;
								player setPosASL ((_asl1 vectorMultiply (1-_perc)) vectorAdd (_asl2 vectorMultiply _perc));
								player setVectorDir ((_vda vectorMultiply (1-_perc)) vectorAdd (_vdd vectorMultiply _perc));
								_delta >= _timeSeg;
							};
							_timeSegSum = _timeSegSum+_delta;
							_moveSum = _moveSum+_move;
							_remainDist = _bestWayMin-_moveSum;
							_remainTime = _tme-_timeSegSum;
							if (_remainDist > 0 && _remainTime > 0) then {
								_newVel = _remainDist/_remainTime;
								_vel = _newVel;
							};
							_dirOld = _dirNew;
							if (BRPVP_busStopNow && {[player,350] call BRPVP_checkOnFlagStateExtraRadius isEqualTo 0}) exitWith {_to = getPosATL player;};
						} forEach _bestWayPair;
						
						//FINALIZE
						BRPVP_busReData = nil;
						BRPVP_busCanPressStop = false;
						BRPVP_busDestine = [];
						setShadowDistance _shadowOld;
						_to set [2,1];
						player setVelocity [0,0,0];
						player setPosASL AGLToASL _to;
						{[_x,_aoBeforeHidden select _forEachIndex] remoteExecCall ["hideObjectGlobal",2];} forEach _attachedObjects;
						[player,player getVariable ["brpvp_invisible",false]] remoteExecCall ["hideObjectGlobal",2];
						sleep 0.5;
						player setVariable ["brpvp_zombie_can_see_player",(player getVariable ["brpvp_zombie_can_see_player",0])-1,true];
						player allowDamage true;
						player setVariable ["brpvp_on_bus",false,true];
						BRPVP_busServiceRunning = false;
					};
				} else {
					"erro" call BRPVP_playSound;
				};
			} else {
				[format [localize "str_no_money_bank",_price],-5,200,0,"erro"] call BRPVP_hint;
			};
		};
		BRPVP_menuVoltar = {
			[player,player getVariable ["brpvp_invisible",false]] remoteExecCall ["hideObjectGlobal",2];
			player setVariable ["brpvp_zombie_can_see_player",(player getVariable ["brpvp_zombie_can_see_player",0])-1,true];
			player allowDamage true;
			BRPVP_busServiceRunning = false;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 115
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1;
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuOpcoes = [localize "str_all_items",localize "str_items_for_my_wep"];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {9 call BRPVP_menuMuda;};
			if (_this isEqualTo 1) then {
				_cw = currentWeapon player;
				if (_cw isEqualTo "") then {
					"erro" call BRPVP_playSound;
					[localize "str_no_curr_wep"] call BRPVP_hint;
				} else {
					BRPVP_menuVar1 = _cw;
					BRPVP_wepItemsBuyList = [];
					116 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 116
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2;
		BRPVP_menuImagem = [];
		BRPVP_menuMods = [];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_otherAmmo = [];
		{
			if (_forEachIndex > 0) then {
				_otherAmmo append getArray (configFile >> "CfgWeapons" >> BRPVP_menuVar1 >> _x >> "magazines");
			};
		} forEach getArray (configFile >> "CfgWeapons" >> BRPVP_menuVar1 >> "muzzles");
		{
			_item = _x;
			_idcItem = BRPVP_traderWeaponItemsName find _item;
			if (_idcItem > -1) then {
				_idc0 = BRPVP_traderWeaponItemsIdcs select _idcItem select 0;
				_idc1 = BRPVP_traderWeaponItemsIdcs select _idcItem select 1;
				_price = BRPVP_traderWeaponItemsIdcs select _idcItem select 2;
				if (BRPVP_marketItemFilter in (BRPVP_mercadoNomesNomesFilter select _idc0 select _idc1)) then {
					_menuImagem = BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa";
					_menuOpcoes = _item;
					if (isClass (configFile >> "CfgMagazines" >> _item)) then {
						_menuImagem = getText (configFile >> "CfgMagazines" >> _item >> "picture");
						_menuOpcoes = getText (configFile >> "CfgMagazines" >> _item >> "displayName") call BRPVP_escapeForStructuredTextFast;
					} else {
						if (isClass (configFile >> "CfgWeapons" >> _item)) then {
							_menuImagem = getText (configFile >> "CfgWeapons" >> _item >> "picture");
							_menuOpcoes = getText (configFile >> "CfgWeapons" >> _item >> "displayName") call BRPVP_escapeForStructuredTextFast;
						};
					};
					_price = (BRPVP_mercadoPrecos select _idc0)*_price*BRPVP_itemTraderDiscount;
					BRPVP_menuOpcoes pushBack _menuOpcoes;
					BRPVP_menuImagem pushBack format ["<t size='1.3' color='#FFFF33' align='center'>Price: $ %1</t><br/><img size='3' align='center' image='%2'/>",_price,_menuImagem];
					BRPVP_menuExecutaParam pushBack [_item,_price];
					BRPVP_menuMods pushBack (_item call BRPVP_getItemMod);
				};
			};
		} forEach (getArray (configFile >> "CfgWeapons" >> BRPVP_menuVar1 >> "magazines")+_otherAmmo+(BRPVP_menuVar1 call BRPVP_weaponItems));
		BRPVP_menuExecutaFuncao = {
			params ["_item","_price"];
			if (BRPVP_compraPrecoTotal+_price <= player getVariable ["mny",0]) then {
				"negocio" call BRPVP_playSound;
				BRPVP_wepItemsBuyList pushBack _this;
				BRPVP_compraPrecoTotal = BRPVP_compraPrecoTotal+_price;
				116 call BRPVP_menuMuda;
			} else {
				"erro" call BRPVP_playSound;
			};
		};
		BRPVP_menuVoltar = {
			if (BRPVP_compraPrecoTotal isEqualTo 0) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				117 call BRPVP_menuMuda;
			};
		};
	},

	//MENU 117
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\dinheiro.paa'/>";
		BRPVP_menuOpcoes = [localize "str_menu12_opt1",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			if (_this isEqualTo 0) then {
				_money = player getVariable ["mny",0];
				_price = BRPVP_compraPrecoTotal*BRPVP_marketPrecoMult;
				if (_money < _price) then {
					[format [localize "str_need_more",_price - _money],-5] call BRPVP_hint;
					"erro" call BRPVP_playSound;
				} else {
					player setVariable ["mny",_money-_price,true];
					call BRPVP_atualizaDebug;
					_wh = createVehicle ["GroundWeaponHolder",getPosATL player,[],0,"CAN_COLLIDE"];
					_wh setVariable ["own",player getVariable "id_bd",true];
					_wh setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
					_wh setVariable ["stp",if (BRPVP_marketPrecoMult isEqualTo 0) then {3} else {1},true];
					_onGround = [player,BRPVP_wepItemsBuyList apply {_x select 0},_wh] call BRPVP_addLoot;
					if (_onGround) then {[localize "str_items_ground",4,15] call BRPVP_hint;} else {[localize "str_items_have_all",3,10] call BRPVP_hint;};
					"negocio" call BRPVP_playSound;
					"ugranted" call BRPVP_playSound;

					//ITEM TRADERS LOG
					[player,_price,BRPVP_wepItemsBuyList apply {_x select 0},"items"] remoteExecCall ["BRPVP_addTraderLog",2];
				};
			};
		};
		BRPVP_menuVoltar = {116 call BRPVP_menuMuda;};
	},

	//MENU 118
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\teleporter_cfg.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_flag = BRPVP_stuff call BRPVP_nearestFlagInside;
		_flagOwner = _flag getVariable "own";
		_friendFlags = [];
		{
			_xAmg = (_x getVariable ["amg",[[],[],true]]) select 1;
			_xOwner = _x getVariable "own";
			_ownerOk = _flagOwner in _xAmg || _flagOwner isEqualTo _xOwner;
			_userOk = [player,_x] call BRPVP_checaAcessoRemotoFlag;
			if (_ownerOk && _userOk) then {_friendFlags pushBack [BRPVP_stuff distance2D _x,_x];};
		} forEach BRPVP_allFlags;
		_friendFlags sort true;
		_friendFlags = _friendFlags apply {_x select 1};
		_friendFlags deleteAt (_friendFlags find _flag);
		_friendFlags = [_flag]+_friendFlags;
		{
			_grid = getPosWorld _x call BRPVP_getGridFromPos;
			BRPVP_menuOpcoes pushBack format [localize "str_tele_base_grid",_grid];
			BRPVP_menuExecutaParam pushBack _x;
		} forEach _friendFlags;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			128 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},
	
	//MENU 119
	{},

	//MENU 120
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = BRPVP_menuVar1 apply {("<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\scanner.paa'/><br/><t align='center' size='1.5' color='#FFFF22'>X"+str (_x select 0)+"</t>")};
		BRPVP_menuOpcoes = [localize "str_players",localize "str_disabled_players",localize "str_dead_boxes",localize "str_other_boxes",localize "str_items_on_ground",localize "str_suitcase",localize "str_bots",localize "str_zombies",localize "str_vehicles"];
		BRPVP_menuExecutaParam = +BRPVP_menuVar1;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 = _this;
			166 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			BRPVP_usedScannerRunning = false;
		};
	},

	//MENU 121
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='2.75' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\fuel_gallon.paa'/>";

		private _inPVE = player getVariable ["brpvp_pve_inside",0] isNotEqualTo 0;
		private _inPVP = player getVariable ["brpvp_in_pvp_zone",0] isNotEqualTo 0;
		private _canPlant = !(_inPVP || _inPVE) || _inPVP || BRPVP_fuelGallonCanExplodeOnPVE;

		_nearVehicles = nearestObjects [player,["Motorcycle","Car","Tank","Air","Ship"],15];
		if (_canPlant) then {
			if (_nearVehicles isEqualTo []) then {
				BRPVP_menuOpcoes = [localize "str_mn_plant_gallon"];
				BRPVP_menuExecutaParam = [objNull];
			} else {
				_vehicle = _nearVehicles select 0;
				if (fuel _vehicle >= 0.975) then {
					BRPVP_menuOpcoes = [localize "str_mn_plant_gallon"];
					BRPVP_menuExecutaParam = [objNull];
				} else {
					BRPVP_menuOpcoes = [localize "str_mn_refuel_vehicle",localize "str_mn_plant_gallon"];
					BRPVP_menuExecutaParam = [_vehicle,objNull];
				};
			};
		} else {
			if (_nearVehicles isEqualTo []) then {
				BRPVP_menuOpcoes = [];
				BRPVP_menuExecutaParam = [];
			} else {
				_vehicle = _nearVehicles select 0;
				if (fuel _vehicle >= 0.975) then {
					BRPVP_menuOpcoes = [];
					BRPVP_menuExecutaParam = [];
				} else {
					BRPVP_menuOpcoes = [localize "str_mn_refuel_vehicle"];
					BRPVP_menuExecutaParam = [_vehicle];
				};
			};
		};
		BRPVP_menuExecutaFuncao = {
			if (isNull _this) then {
				player remoteExecCall ["BRPVP_createGallonBomb",2];
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				BRPVP_usedFuelGallonRunning = true;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				_this spawn {
					[player,["fuel_gallon",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
					_init = time;
					_p = player;
					waitUntil {time-_init > 4 || !(_p call BRPVP_pAlive)};
					if (_p call BRPVP_pAlive) then {[_this,1] remoteExecCall ["setFuel",_this];} else {"erro" call BRPVP_playSound;};
					BRPVP_usedFuelGallonRunning = false;
				};
			};
		};
		BRPVP_menuVoltar = {
			["Mag_BRPVP_fuel_gallon",1] call BRPVP_sitAddItem;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 122
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_typeOf = typeOf BRPVP_menuVar1;
		if !(_typeOf in BRPVP_craftMachines) then {_typeOf = BRPVP_menuVar2;};
		{
			if !(_x select 0 in BRPVP_removeFromTrader) then {
				private _name = BRPVP_specialItemsNames select (BRPVP_specialItems find (_x select 0));
				private _img = BRPVP_imagePrefix+(BRPVP_specialItemsImages select (BRPVP_specialItems find (_x select 0)));
				private _data = (_x select 0) call BRPVP_craftCreatePath;
				private _can = _data select 0;
				private _price = (_data select 1)/1000;
				BRPVP_menuOpcoes pushBack (if (_can) then {format ["@green@$ %1 K@tclose@ - @memory_remove_back@%2",_price,_name]} else {format ["@yellow@(OFF)@tclose@ - @memory_remove_back@%1",_name]});
				BRPVP_menuExecutaParam pushBack [_x,if (_can) then {_data select 3} else {[]}];
				BRPVP_menuImagem pushBack format ["<img size='4.0' align='center' image='%1'/>",_img];
			};
		} forEach BRPVP_crafts;
		BRPVP_menuOpcoes pushBack localize "str_menu12_opt2";
		BRPVP_menuExecutaParam pushBack "cancel";
		BRPVP_menuImagem pushBack "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\icones3d\working.paa'/>";
		BRPVP_menuOptionCode = {
			BRPVP_menuVar3 = "option";
			_param = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			if (_param isEqualTo "cancel" || _param isEqualTo "cant") then {
				ctrlDelete (findDisplay 46 displayCtrl BRPVP_menuControl2);
				ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
				//["<img shadow='0' align='center' size='5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\status_bar\zombie_icon.paa'/><br/><t shadow='0' align='center'>"+localize "str_menu_on_right"+"</t>",0,0,99999,0,0,9959] call BRPVP_fnc_dynamicText;
			} else {
				_param = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel select 0;

				//REQUIREMENTS
				_txt = format ["<t color='#EE5555'>%1</t>",localize "str_requirements"];
				_required = _param select 1;
				{
					_name = BRPVP_specialItemsNames select (BRPVP_specialItems find (_x select 0));
					_img = BRPVP_imagePrefix+(BRPVP_specialItemsImages select (BRPVP_specialItems find (_x select 0)));
					_q = _x select 1;
					_missing = (_q-((_x select 0) call BRPVP_sitCountItem)) max 0;
					_missing = if (_missing > 0) then {"("+localize "str_missing"+" "+str _missing+"X)"} else {""};
					_txt = format ["%1<br /><img size='1.25' align='left' image='%4'/> <t size='1' color='#BBBB00'>%2X</t><t size='1'> %3</t> <t size='1' color='#FFFFFF'>%5</t>",_txt,_q,_name,_img,_missing];
				} forEach _required;

				//BASIC REQUIREMENTS
				_result = [];
				_machineUses = BRPVP_craftMachines apply {0};
				_machineUses set [BRPVP_craftMachines find (_param select 2),1];
				while {count _required > 0} do {
					private _toLower = [];
					{
						_x params ["_class","_q"];
						_needLower = [];
						{
							_craft = _x select 0;
							if (_class isEqualTo _craft && !(_craft in BRPVP_craftsNoBaseFrom)) exitWith {
								_needLower = _x select 1;
								_machine = _x select 2;
								_idx = BRPVP_craftMachines find _machine;
								_machineUses set [_idx,(_machineUses select _idx)+_q];
							};
						} forEach BRPVP_crafts;
						if (_needLower isEqualTo []) then {_result pushBack _x;} else {for "_i" from 1 to _q do {_toLower append _needLower;};};
					} forEach _required;
					_required = _toLower;
				};
				_items = [];
				_q = [];
				{
					_x params ["_class","_qItem"];
					_idx = _items find _class;
					if (_idx isEqualTo -1) then {
						_items pushBack _class;
						_q pushBack _qItem;
					} else {
						_q set [_idx,(_q select _idx)+_qItem];
					};
				} forEach _result;
				_result = [];
				{_result pushBack [_q select _forEachIndex,_x];} forEach _items;
				_result sort false;
				_result = _result apply {[_x select 1,_x select 0]};
				_txt = format ["%1<br /><br /><t color='#EE5555'>%2</t>",_txt,localize "str_requirements_base"]; //XML
				{
					_x params ["_class","_q"];
					_name = BRPVP_specialItemsNames select (BRPVP_specialItems find _class);
					_img = BRPVP_imagePrefix+(BRPVP_specialItemsImages select (BRPVP_specialItems find _class));
					_missing = _q-(_class call BRPVP_sitCountItem);
					_missing = if (_missing > 0) then {"("+localize "str_missing"+" "+str _missing+"X)"} else {""};
					_txt = format ["%1<br /><img size='1.25' align='left' image='%4'/> <t size='1' color='#BBBB00'>%2X</t><t size='1'> %3</t> <t size='1' color='#FFFFFF'>%5</t>",_txt,_q,_name,_img,_missing];
				} forEach _result;

				//MACHINE USES
				_txt = format ["%1<br /><br /><t color='#EE5555'>%2</t>",_txt,localize "str_craft_machine_uses"];
				{
					_name = BRPVP_craftMachinesNiceName select _forEachIndex;
					_q = _machineUses select _forEachIndex;
					_txt = format ["%1<br /><t size='1'>%2: </t><t size='1.25' color='#BBBB00'>%3</t>",_txt,_name,_q];
				} forEach BRPVP_craftMachines;

				//SHOW ON SCREEN
				["",0,0,0,0,0,9959] call BRPVP_fnc_dynamicText;
				disableSerialization;
				ctrlDelete (findDisplay 46 displayCtrl BRPVP_menuControl2);
				_ctrl1 = findDisplay 46 ctrlCreate ["RscStructuredText",BRPVP_menuControl2];
				_ctrl1 ctrlSetPosition [0.3,safeZoneY,0.4,0];
				_ctrl1 ctrlCommit 0;
				_ctrl1 ctrlSetPosition [0.3,safeZoneY,0.4,0.05];
				_ctrl1 ctrlSetBackgroundColor [0.25,0.8,0.25,0.8];
				_ctrl1 ctrlSetStructuredText parseText format ["<t align='center'>%1</t>",localize "str_craft_requeriments"];
				_ctrl1 ctrlCommit 0.25;
				ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
				_ctrl2 = findDisplay 46 ctrlCreate ["RscStructuredText",BRPVP_vehicleSellCtrl];
				_ctrl2 ctrlSetPosition [0.3,safeZoneY+0.05,0.4,0];
				_ctrl2 ctrlCommit 0;
				_ctrl2 ctrlSetPosition [0.3,safeZoneY+0.05,0.4,safeZoneH-0.05];
				_ctrl2 ctrlSetBackgroundColor [0,0,0,0.6];
				_ctrl2 ctrlSetStructuredText parseText _txt;
				_ctrl2 ctrlCommit 0.25;
			};
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				ctrlDelete (findDisplay 46 displayCtrl BRPVP_menuControl2);
				ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				if (_this isEqualTo "cant" || !(typeOf BRPVP_menuVar1 in BRPVP_craftMachines)) then {
					if !(typeOf BRPVP_menuVar1 in BRPVP_craftMachines) then {
						[localize "str_craft_helper_only",-6] call BRPVP_hint;
					} else {
						"erro" call BRPVP_playSound;
					};
				} else {
					if (!BRPVP_craftingActionOn) then {
						BRPVP_craftingActionOn = true;
						(_this select 1) spawn {
							BRPVP_menuExtraLigado = false;
							hintSilent "";
							BRPVP_iniciaMenuExtraBlock = true;
							private _cancel = false;
							{
								private _toCraft = _x;
								private _line = [];
								private _mny = player getVariable ["brpvp_mny_bank",0];
								_cancel = false;
								{if (_x select 0 isEqualTo _toCraft) exitWith {_line = _x;};} forEach BRPVP_crafts;
								_line params ["_reward","_cost","_machine"];
								_have = true;
								{if ((_x select 0) call BRPVP_sitCountItem < _x select 1) exitWith {_have = false;};} forEach _cost;
								if (_have && _mny >= 10000) then {
									_machineUseImg = BRPVP_imagePrefix+"BRP_imagens\crafting.paa";
									_machineUseSnd = "Land_WoodenCounter_01_F_SND";
									{
										if ((_x select 0) isEqualTo "BRPVP_farm_coal") exitWith {
											_machineUseImg = BRPVP_imagePrefix+"BRP_imagens\crafting_oven.paa";
											_machineUseSnd = "Land_DieselGroundPowerUnit_01_F_SND";
										};
									} forEach _cost;
									if (_reward isEqualTo "BRPVP_farm_coal") then {
										_machineUseImg = BRPVP_imagePrefix+"BRP_imagens\crafting_oven.paa";
										_machineUseSnd = "Land_DieselGroundPowerUnit_01_F_SND";
									};
									BRPVP_menuVar3 = "craft";
									disableSerialization;
									_ctrl1 = findDisplay 46 displayCtrl BRPVP_menuControl2;
									_ctrl1 ctrlSetPosition [0.3,0,0.4,0];
									_ctrl1 ctrlCommit 0;
									_ctrl1 ctrlSetPosition [0.3,0,0.4,0.05];
									_ctrl1 ctrlSetBackgroundColor [0.25,0.8,0.25,0.8];
									_ctrl1 ctrlSetStructuredText parseText format ["<t align='center'>%1</t>",localize "str_craft_requeriments"];
									_ctrl1 ctrlCommit 0.25;
									_txt = format ["<br/><br/><img size='3' align='center' image='%1'/><br/><br/><t align='center' size='1.65'>%2</t>",_machineUseImg,localize "str_crafting"];
									_ctrl2 = findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl;
									_ctrl2 ctrlSetPosition [0.3,0.05,0.4,0];
									_ctrl2 ctrlCommit 0;
									_ctrl2 ctrlSetPosition [0.3,0.05,0.4,0.5];
									_ctrl2 ctrlSetStructuredText parseText _txt;
									_ctrl2 ctrlCommit 0.25;
									{_x call BRPVP_sitRemoveItem;} forEach _cost;
									_sounder = createVehicle ["Land_HelipadEmpty_F",BRPVP_posicaoFora,[],10,"CAN_COLLIDE"];
									_sounder attachTo [player,[0,0,0]];
									[_sounder,[_machineUseSnd,250]] remoteExecCall ["say3D",BRPVP_allNoServer];
									_pos = ASLToAGL getPosASL player;
									_init = time;
									_delta = BRPVP_farmAndCraftTime;
									waitUntil {
										_posNow = ASLToAGL getPosASL player;
										_pos distance _posNow > 3.5 || !(player call BRPVP_pAlive) || time-_init > _delta
									};
									_sounder setDamage 1;
									detach _sounder;
									deleteVehicle _sounder;
									if (_pos distance (ASLToAGL getPosASL player) <= 3.5 && (player call BRPVP_pAlive)) then {
										[_reward,1] call BRPVP_sitAddItem;
										"BRPVP_farming_ok" call BRPVP_playSound;
										_name = BRPVP_specialItemsNames select (BRPVP_specialItems find _reward);
										_picture = BRPVP_imagePrefix+(BRPVP_specialItemsImages select (BRPVP_specialItems find _reward));
										[format [localize "str_craft_reward","<t color='#DD4040'>"+_name+"</t><br /><img color='#FFFFFF' size='2' image='"+_picture+"'/>"],-5] call BRPVP_hint;
										[["farm_Craft",1]] call BRPVP_mudaExp;
										player setVariable ["brpvp_mny_bank",(player getVariable ["brpvp_mny_bank",0])-10000,true];
										if ((_forEachIndex+1) isEqualTo count _this) then {
											private _init = diag_tickTime;
											waitUntil {diag_tickTime-_init > 2};
										};
									} else {
										{_x call BRPVP_sitAddItem;} forEach _cost;
										"BRPVP_farming_fail" call BRPVP_playSound;
										_cancel = true;
									};
								} else {
									"erro" call BRPVP_playSound;
									_cancel = true;
								};
								if (_cancel) exitWith {};
							} forEach _this;
							BRPVP_iniciaMenuExtraBlock = false;
							if (_cancel) then {
								ctrlDelete (findDisplay 46 displayCtrl BRPVP_menuControl2);
								ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
							} else {
								122 call BRPVP_iniciaMenuExtra;
							};
							BRPVP_craftingActionOn = false;
						};
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			ctrlDelete (findDisplay 46 displayCtrl BRPVP_menuControl2);
			ctrlDelete (findDisplay 46 displayCtrl BRPVP_vehicleSellCtrl);
			BRPVP_iniciaMenuExtraBlock = false;
			if (BRPVP_menuVar2 isEqualTo "") then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				124 call BRPVP_menuMuda;
			};
		};
	},

	//MENU 123
	{
		BRPVP_menuTipo = 2;
		_owners = [];
		_ownersCount = [];
		{
			if (_x call BRPVP_menuVar2) then {
				_own = _x getVariable ["own",-1];
				if (_own > -1) then {
					_idx = _owners find _own;
					if (_idx isEqualTo -1) then {
						_owners pushBack _own;
						_ownersCount pushBack 1;
					} else {
						_ownersCount set [_idx,(_ownersCount select _idx)+1];
					};
				};
			};
		} forEach nearestObjects [BRPVP_stuff,BRPVP_menuVar1,BRPVP_stuff getVariable ["brpvp_flag_radius",0],true];
		BRPVP_pegaNomePeloIdBd1 = [_owners,player,true];
		BRPVP_pegaNomePeloIdBd1Retorno = nil;
		publicVariableServer "BRPVP_pegaNomePeloIdBd1";
		waitUntil {!isNil "BRPVP_pegaNomePeloIdBd1Retorno"};
		BRPVP_pegaNomePeloIdBd1Retorno params ["_tabName","_tabId"];
		_tabNameX = [];
		{
			_idx = _owners find _x;
			_n = _ownersCount select _idx;
			_tabNameX pushBack ((_tabName select _forEachIndex)+": X"+str _n);
		} forEach _tabId;
		BRPVP_menuOpcoes = _tabNameX;
		BRPVP_menuExecutaParam = _tabId;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar4 = _this;
			BRPVP_menuVar3 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {98 call BRPVP_menuMuda;};
	},

	//124
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\catalog.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_brpvp_machines_workbench_displayname"
		];
		BRPVP_menuExecutaParam = [
			"Land_WoodenCounter_01_F"
		];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = player;
			BRPVP_menuVar2 = _this;
			122 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//125
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 2;
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuOpcoes = [];
		BRPVP_menuImagem = [];
		BRPVP_menuExecutaParam = [];
		{
			_dn = BRPVP_specialItemsNames select (BRPVP_specialItems find _x);
			BRPVP_menuOpcoes pushBack _dn;
			BRPVP_menuImagem pushBack format ["<img size='4.0' align='center' image='%1'/>",BRPVP_imagePrefix+(BRPVP_specialItemsImages select (BRPVP_specialItems find _x))];
			BRPVP_menuExecutaParam pushBack [_dn,[[_x],[1]]];
		} forEach ["BRPVP_farm_limestone","BRPVP_farm_clay","BRPVP_farm_coal","BRPVP_farm_stone","BRPVP_farm_iron"];
		BRPVP_menuExecutaFuncao = {
			params ["_dn","_newFarm"];
			[format [localize "str_private_farm_set",_dn],-6] call BRPVP_hint;
			BRPVP_privateMineOres = _newFarm;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//126
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = BRPVP_specialItemsGroup arrayIntersect BRPVP_specialItemsGroup;
		BRPVP_menuExecutaParam = +BRPVP_menuOpcoes;
		BRPVP_menuOpcoes = BRPVP_menuOpcoes apply {format ["%1 %2",localize "str_give",_x]};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			BRPVP_menuVar2 = [];
			BRPVP_menuVar3 = [];
			127 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {35 call BRPVP_menuMuda;};
	},

	//127
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if (BRPVP_specialItemsGroup select _forEachIndex isEqualTo BRPVP_menuVar1) then {
				private _q = if (BRPVP_vePlayers) then {100} else {_forEachIndex call BRPVP_sitCountItem};
				if (_q > 0) then {
					private _idx = BRPVP_menuVar2 find _forEachIndex;
					private _get = if (_idx isEqualTo -1) then {0} else {BRPVP_menuVar3 select _idx};
					BRPVP_menuOpcoes pushBack format ["%1/%2@memory_remove_back@ %3",_get,_q,_x];
					BRPVP_menuExecutaParam pushBack [_forEachIndex,_q];
					BRPVP_menuImagem pushBack ("<img size='4.5' align='center' image='"+BRPVP_imagePrefix+(BRPVP_specialItemsImages select _forEachIndex)+"'/>");
				};
			};
		} forEach BRPVP_specialItemsNames;
		//RESET TO ZERO
		BRPVP_menuOpcoes pushBack localize "str_reset_to_zero";
		BRPVP_menuExecutaParam pushBack "reset";
		BRPVP_menuImagem pushBack "<img size='4.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		//UPDATE NEAR PLAYERS
		BRPVP_menuOpcoes pushBack localize "str_update_near_players";
		BRPVP_menuExecutaParam pushBack "update";
		BRPVP_menuImagem pushBack "<img size='4.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		private _maxDistToGive = if (BRPVP_vePlayers) then {1000000} else {BRPVP_maxDistanceToGiveHandMoney};
		{
			BRPVP_menuOpcoes pushBack format ["%1: %2",localize "str_alt_i_give_item",_x getVariable ["nm","no_name"]];
			BRPVP_menuExecutaParam pushBack _x;
			BRPVP_menuImagem pushBack "<img size='4.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		} forEach (_maxDistToGive call BRPVP_pegaListaPlayersNearObjs);
		BRPVP_menuExecutaFuncao = {
			if !(_this isEqualTo "update") then {
				if (_this isEqualTo "reset") then {
					BRPVP_menuVar2 = [];
					BRPVP_menuVar3 = [];
				} else {
					if (_this isEqualType objNull) then {
						if (_this getVariable ["sok",false] && !(BRPVP_menuVar2 isEqualTo [])) then {
							private _moveLimitsIdx = [];
							private _moveLimitsQtt = [];
							{
								_x params ["_name","_max"];
								private _receiverCount = [_this,_name] call BRPVP_sitCountItemRemote;
								_moveLimitsIdx pushBack (BRPVP_specialItemsNames find _name);
								_moveLimitsQtt pushBack ((_max-_receiverCount) max 0);
							} forEach BRPVP_specialItemsGiveLimit;
							if (!BRPVP_vePlayers) then {
								{
									private _moveWant = BRPVP_menuVar3 select _forEachIndex;
									private _idx = _moveLimitsIdx find _x;
									private _moveReal = if (_idx isEqualTo -1) then {_moveWant} else {_moveWant min (_moveLimitsQtt select _idx)};
									if (_moveReal > 0) then {[_x,_moveReal] call BRPVP_sitRemoveItem;};
								} forEach BRPVP_menuVar2;
							};
							{
								private _moveWant = BRPVP_menuVar3 select _forEachIndex;
								private _idx = _moveLimitsIdx find _x;
								private _moveReal = if (_idx isEqualTo -1) then {_moveWant} else {_moveWant min (_moveLimitsQtt select _idx)};
								if (_moveReal > 0) then {[_x,_moveReal] remoteExecCall ["BRPVP_sitAddItem",_this];};
							} forEach BRPVP_menuVar2;
							BRPVP_menuVar2 = [];
							BRPVP_menuVar3 = [];
							"granted" call BRPVP_playSound;
						} else {
							"erro" call BRPVP_playSound;
						};
					} else {
						_ii = _this select 0;
						_max = _this select 1;
						_idx = BRPVP_menuVar2 find _ii;
						if (_idx isEqualTo -1) then {
							BRPVP_menuVar2 pushBack _ii;
							BRPVP_menuVar3 pushBack 1;
						} else {
							BRPVP_menuVar3 set [_idx,((BRPVP_menuVar3 select _idx)+1) min _max];
						};
					};
				};
			};
			"ciclo" call BRPVP_playSound;
			127 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {126 call BRPVP_menuMuda;};
	},

	//MENU 128
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\teleporter_cfg.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_rad = BRPVP_menuVar1 getVariable ["brpvp_flag_radius",0];
		{
			if (typeOf _x isEqualTo "Land_RaiStone_01_F") then {
				_id = _x getVariable ["id_bd",-1];
				if !(_id isEqualTo -1) then {
					BRPVP_menuOpcoes pushBack ("#"+str _id);
					BRPVP_menuExecutaParam pushBack _id;
				};
			};
		} forEach ((nearestObjects [BRPVP_menuVar1,["Land_RaiStone_01_F"],_rad,true])-[BRPVP_stuff]);
		BRPVP_menuExecutaFuncao = {
			BRPVP_stuff setVariable ["brpvp_tele_destine_id",_this,true];
			[BRPVP_stuff getVariable "id_bd",_this] remoteExecCall ["BRPVP_teleSaveDestineOnBd",2];
			"achou_loot" call BRPVP_playSound;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
		BRPVP_menuVoltar = {118 call BRPVP_menuMuda;};
	},

	//MENU 129
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\drone_finder.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_nearDrones = player nearEntities [BRPVP_vantVehiclesClass,5000] apply {[_x distance player,_x]};
		_nearDrones sort true;
		{
			_x params ["_dist","_drone"];
			if (_dist < 6000) then {
				_name = getText (configFile >> "CfgVehicles" >> typeOf _drone >> "displayName") call BRPVP_escapeForStructuredTextFast;
				BRPVP_menuOpcoes pushBack format ["%1: %2 m",_name,round _dist];
				BRPVP_menuExecutaParam pushBack _drone;
			};
		} forEach _nearDrones;
		BRPVP_menuOpcoes append [localize "str_update_distances",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam append ["update","cancel"];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				["BRPVP_drone_finder",1] call BRPVP_sitAddItem;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				if (_this isEqualTo "update") then {
					"hint2" call BRPVP_playSound;
					129 call BRPVP_menuMuda;
				} else {
					_cont = UAVControl _this;
					_txt = "";
					if (count _cont isEqualTo 2) then {
						_p = _cont select 0;
						if (!isNull _p) then {
							_role = _cont select 1;
							if !(_role isEqualTo "") then {
								_pos = getPosWorld _p;
								_txt = format [localize "str_drone_operator_1_pos",_pos call BRPVP_getGridFromPos];
								[_txt,-8] call BRPVP_hint;
								BRPVP_spotedDroneOperators pushBack [time,_pos,BRPVP_spotedDroneOperatorsIdx];
								BRPVP_spotedDroneOperatorsIdx = BRPVP_spotedDroneOperatorsIdx+1;
							};
						};
					} else {
						if (count _cont isEqualTo 4) then {
							_p1 = _cont select 0;
							_p2 = _cont select 2;
							_pos1 = getPosWorld _p1;
							_pos2 = getPosWorld _p2;
							_txt = format [localize "str_drone_operator_2_pos",_pos1 call BRPVP_getGridFromPos,_pos2 call BRPVP_getGridFromPos];
							[_txt,-8] call BRPVP_hint;
							BRPVP_spotedDroneOperators append [[time,_pos1,BRPVP_spotedDroneOperatorsIdx],[time,_pos2,BRPVP_spotedDroneOperatorsIdx]];
							BRPVP_spotedDroneOperatorsIdx = BRPVP_spotedDroneOperatorsIdx+1;
						};
					};
					if (_txt isEqualTo "") then {
						"erro" call BRPVP_playSound;
						129 call BRPVP_menuMuda;
					} else {
						BRPVP_menuExtraLigado = false;
						hintSilent "";
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			["BRPVP_drone_finder",1] call BRPVP_sitAddItem;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 130
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		_typeOf = typeOf BRPVP_stuff;
		BRPVP_menuImagem = format ["<img size='3.0' align='center' image='%1'/>",getText (configFile >> "CfgVehicles" >> _typeOf >> "picture")];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			BRPVP_menuOpcoes pushBack format [localize "str_pylon_n",_forEachIndex+1];
			BRPVP_menuExecutaParam pushBack (_forEachIndex+1);
		} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _typeOf >> "Components" >> "TransportPylonsComponent" >> "pylons") apply {configName _x});
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			BRPVP_menuVar2 = false;
			131 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 131
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		_typeOf = typeOf BRPVP_stuff;
		BRPVP_menuImagem = format ["<img size='3.0' align='center' image='%1'/>",getText (configFile >> "CfgVehicles" >> _typeOf >> "picture")];
		if (BRPVP_menuVar2) then {
			hintSilent parseText ("<t align='center' size='1.65'>"+localize "str_please_wait"+"</t>");
			sleep 0.5;
		};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_mags = getPylonMagazines BRPVP_stuff;
		_mag = _mags select (BRPVP_menuVar1-1);
		_magCount = BRPVP_stuff ammoOnPylon BRPVP_menuVar1;
		{
			if (_x isEqualTo _mag) then {
				BRPVP_menuOpcoes pushBack ("[X"+str _magCount+"] @memory_remove_back@"+(getText (configFile >> "CfgMagazines" >> _x >> "displayName") call BRPVP_escapeForStructuredTextFast));
				BRPVP_menuExecutaParam pushBack _x;
			} else {
				BRPVP_menuOpcoes pushBack (getText (configFile >> "CfgMagazines" >> _x >> "displayName") call BRPVP_escapeForStructuredTextFast);
				BRPVP_menuExecutaParam pushBack _x;
			};
		} forEach (BRPVP_stuff getCompatiblePylonMagazines BRPVP_menuVar1);
		BRPVP_menuExecutaFuncao = {
			private _haveTurret = [0] in allTurrets BRPVP_stuff;
			if (_haveTurret) then {
				BRPVP_menuVar3 = _this;
				212 call BRPVP_menuMuda;
			} else {
				_mny = player getVariable ["brpvp_mny_bank",0];
				if (_mny >= BRPVP_pylonChangePrice) then {
					player setVariable ["brpvp_mny_bank",_mny-BRPVP_pylonChangePrice,true];
					private _typeOf = typeOf BRPVP_stuff;
					[BRPVP_stuff,[BRPVP_menuVar1,_this]] remoteExecCall ["setPylonLoadout",BRPVP_stuff];
					"negocio" call BRPVP_playSound;
					call BRPVP_atualizaDebug;
					BRPVP_menuVar2 = true;
					130 spawn BRPVP_menuMuda;
				} else {
					"erro" call BRPVP_playSound;
					[format [localize "str_need_x_in_bank",BRPVP_pylonChangePrice],-5] call BRPVP_hint;
					BRPVP_menuVar2 = false;
				};
			};
		};
		BRPVP_menuVoltar = {130 call BRPVP_menuMuda;};
	},

	//MENU 132
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\personal_menu.paa'/>";

		private _placeOk = BRPVP_safeZone || player call BRPVP_checkOnFlagState > 0;
		private _anywere = BRPVP_openPersonalVaultAnywhere;
		private _vaultPrice = if (_placeOk) then {BRPVP_vaultPrice} else {if (_anywere) then {BRPVP_vaultPriceOutPlace} else {BRPVP_vaultPriceOutPlaceNoPerk};};

		_vOpt = if (BRPVP_vaultLigada) then {
			localize "str_personal_vault_act_cls"
		} else {
			BRPVP_vaultNumberRun = BRPVP_vaultNumber max (player getVariable ["brpvp_vaults_xp",0]);
			if (BRPVP_vaultNumberRun <= 1) then {format [localize "str_personal_vault",round (_vaultPrice/1000)]} else {localize "str_personal_vault_select"};
		};
		_shd = player getVariable ["brpvp_personal_shield",objNull];
		_sOpt = if (isNull _shd) then {format [localize "str_personal_shield",round (BRPVP_personalShieldPrice/1000)]} else {localize "str_personal_shield_act_cls"};
		_bsh = BRPVP_personalBush;
		_bOpt = if (isNull _bsh) then {format [localize "str_personal_bush",round (BRPVP_personalBushPrice/1000)]} else {localize "str_personal_bush_act_cls"};
		_twr = player getVariable ["brpvp_personal_tower",objNull];
		_tOpt = if (isNull _twr) then {format [localize "str_personal_tower",round (BRPVP_personalTowerPrice/1000)]} else {localize "str_personal_tower_act_cls"};
		_stv = player getVariable ["brpvp_personal_stv",objNull];
		_tvOpt = if (isNull _stv) then {format [localize "str_personal_stv",round (BRPVP_personalSmartTvPrice/1000)]} else {localize "str_personal_stv_act_cls"};
		BRPVP_menuOpcoes = [_vOpt,_sOpt,_bOpt,_tOpt,_tvOpt,localize "str_set_vault_tip"];
		BRPVP_menuExecutaParam = ["vault","shield","bush","tower","stv","vtip"];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuPos select 132 set [0,["@#","@#","@#","@#","@#","@#","@#","@#","@#","@#"]];
			if (_this isEqualTo "vault") then {
				if (BRPVP_vaultNumberRun <= 1 || BRPVP_vaultLigada) then {
					if (isNull objectParent player) then {
						_tempo = BRPVP_vaultAcaoTempo-time;
						if (_tempo > 0) then {
							[format [localize "str_vault_cant",(round _tempo) max 1],0] call BRPVP_hint;
						} else {
							if (BRPVP_vaultLigada) then {
								if (isNull BRPVP_holderVault) then {
									if (time-BRPVP_vaultAcaoTempo > 3) then {
										_txt = "[BRPVP VAULT OPEN PROBLEM] Vault no open problem ocurred!";
										diag_log _txt;
										[player,_txt] remoteExecCall ["BRPVP_clientLogOnServer",2];
									};
								} else {
									BRPVP_vaultAcaoTempo = time+1;
									call BRPVP_vaultRecolhe;
									BRPVP_menuExtraLigado = false;
									hintSilent "";
								};
							} else {
								if (BRPVP_vaultNumberRun isEqualTo 0) then {
									"erro" call BRPVP_playSound;
								} else {
									//if (BRPVP_safeZone || player call BRPVP_checkOnFlagState > 0 || BRPVP_openPersonalVaultAnywhere) then {
									if (true) then {
										private _placeOk = BRPVP_safeZone || player call BRPVP_checkOnFlagState > 0;
										private _anywere = BRPVP_openPersonalVaultAnywhere;
										private _vaultPrice = if (_placeOk) then {BRPVP_vaultPrice} else {if (_anywere) then {BRPVP_vaultPriceOutPlace} else {BRPVP_vaultPriceOutPlaceNoPerk};};

										_mny = player getVariable ["brpvp_mny_bank",0];
										if (_mny >= _vaultPrice) then {
											"buttom_on" call BRPVP_playSound;
											BRPVP_vaultAcaoTempo = time+1;
											private _ok = 0 call BRPVP_vaultAbre;
											if (_ok) then {
												player setVariable ["brpvp_mny_bank",_mny-_vaultPrice,true];
												call BRPVP_atualizaDebug;
												BRPVP_menuExtraLigado = false;
												hintSilent "";
											};
										} else {
											"erro" call BRPVP_playSound;
											[format [localize "str_need_x_in_bank",_vaultPrice],-5] call BRPVP_hint;
										};
									} else {
										"erro" call BRPVP_playSound;
										[localize "str_cant_open_vault_1",-5] call BRPVP_hint;
									};
								};
							};
						};
					} else {
						"erro" call BRPVP_playSound;
					};
				} else {
					156 spawn BRPVP_menuMuda;
				};
			} else {
				if (_this isEqualTo "shield") then {
					if (time > BRPVP_personalShieldTime) then {
						_objOn = player getVariable ["brpvp_personal_shield",objNull];
						if (isNull _objOn) then {
							if (BRPVP_safeZone) then {
								"erro" call BRPVP_playSound;
							} else {
								_posPlayer = getPosASL player;
								_posPlayer set [2,(_posPlayer select 2)+1];
								_ang = getDir player;
								_posShd = [(_posPlayer select 0)+2*sin _ang,(_posPlayer select 1)+2*cos _ang,_posPlayer select 2];
								_lis = lineIntersectsSurfaces [_posShd,_posShd vectorAdd [0,0,-3.5],objNull,objNull,true,1,"GEOM","NONE"];
								if (_lis isNotEqualTo [] && {!((_lis select 0 select 2) call BRPVP_isMotorized) && !((_lis select 0 select 2) isKindOf "CaManBase")}) then {
									_pos = _lis select 0 select 0;
									_vu = vectorNormalized ((_lis select 0 select 1) vectorAdd [0,0,1.5]);
									_spaceOk = true;
									{
										_h = _x;
										{
											_posCheck = _pos vectorAdd [_x*sin _ang,_x*cos _ang,0] vectorAdd [0,0,_h];
											_vec = _posCheck vectorDiff _posPlayer;
											_vecR = (vectorNormalized (_vec vectorCrossProduct _vu)) vectorMultiply 2;
											_vecL = (vectorNormalized (_vu vectorCrossProduct _vec)) vectorMultiply 2;
											_lisR = lineIntersectsSurfaces [_posPlayer,_posCheck vectorAdd _vecR,player,objNull,true,1,"GEOM","NONE"];
											_lisL = lineIntersectsSurfaces [_posPlayer,_posCheck vectorAdd _vecL,player,objNull,true,1,"GEOM","NONE"];
											_lisM = lineIntersectsSurfaces [_posPlayer,_posCheck,player,objNull,true,1,"GEOM","NONE"];
											if !(_lisR isEqualTo [] && _lisM isEqualTo [] && _lisL isEqualTo []) exitWith {
												_spaceOk = false;
												break
											};
										} forEach [-0.2,0,0.2];
									} forEach [0.8,1,1.25,1.5];
									if (_spaceOk) then {
										_mny = player getVariable ["brpvp_mny_bank",0];
										if (_mny >= BRPVP_personalShieldPrice) then {
											player setVariable ["brpvp_mny_bank",_mny-BRPVP_personalShieldPrice,true];
											call BRPVP_atualizaDebug;
											_shield = createVehicle ["Land_Concrete_SmallWall_4m_F",BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
											_shield setDir getDir player;
											_shield setPosASL (_pos vectorAdd [0,0,0.56]);
											_shield addEventHandler ["HandleDamage",{call BRPVP_personalShieldHDEH;}];
											_shield setVectorUp _vu;
											_params = [_shield,[format ["<t color='#B05050'>%1</t>",localize "str_remove_personal_shield"],{deleteVehicle (_this select 0);},[],2,false,false,"","_target distanceSqr player < 9"]];
											_params remoteExecCall ["addAction",BRPVP_allNoServer,true];
											player setVariable ["brpvp_personal_shield",_shield,[2,clientOwner]];
											[player,["drilling",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
											BRPVP_menuExtraLigado = false;
											hintSilent "";
										} else {
											"erro" call BRPVP_playSound;
											[format [localize "str_need_x_in_bank",BRPVP_personalShieldPrice],-5] call BRPVP_hint;
										};
									} else {
										"erro" call BRPVP_playSound;
									};
								} else {
									"erro" call BRPVP_playSound;
								};
							};
						} else {
							[player,["drilling",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
							deleteVehicle _objOn;
							BRPVP_menuExtraLigado = false;
							hintSilent "";
						};
					} else {
						"erro" call BRPVP_playSound;
						[format [localize "str_personal_shield_wait",round (BRPVP_personalShieldTime-time)],-6] call BRPVP_hint;
					};
				} else {
					if (_this isEqualTo "bush") then {
						if (isNull objectParent player) then {
							if (isNull BRPVP_personalBush) then {
								_mny = player getVariable ["brpvp_mny_bank",0];
								if (_mny >= BRPVP_personalBushPrice) then {
									player setVariable ["brpvp_mny_bank",_mny-BRPVP_personalBushPrice,true];
									call BRPVP_atualizaDebug;
									BRPVP_personalBush = createSimpleObject ["a3\plants_f\bush\b_ficusc1s_f.p3d",BRPVP_posicaoFora];
									BRPVP_personalBush attachTo [player,[1,0.5,0.75]];
									player setVariable ["brpvp_server_bush",BRPVP_personalBush,true];
									player setVariable ["brpvp_error_zed",true,true];
									0 spawn {
										private _initI = diag_tickTime;
										private _vCount = 0;
										private _noExposeTime = 0;
										private _init = diag_tickTime;
										private _zSee = false;
										private _zSeeLast = -10;
										private _turretSaw = false;
										BRPVP_personalBushFakeOn = false;
										waitUntil {
											if (diag_tickTime-_init >= 1) then {
												if (!_turretSaw) then {_turretSaw = BRPVP_autoTurretDangerLevel > 0;}; 
												_init = diag_tickTime;
												private _ai = player nearEntities [["SoldierWB","SoldierGB"],50];
												private _veh = (nearestObjects [player, ["Motorcycle","Air","LandVehicle","Ship"],50] apply {if ({_u = _x;{_u isKindOf _x && alive _u} count ["SoldierWB","SoldierGB"] > 0} count crew _x > 0) then {_x} else {-1};})-[-1];
												_ai = (_ai apply {if (lineIntersectsSurfaces [eyePos _x,eyePos player,_x,player] isEqualTo []) then {_x} else {-1};})-[-1];
												_veh = (_veh apply {if (lineIntersectsSurfaces [getPosWorld _x,eyePos player,_x,player] isEqualTo []) then {_x} else {-1};})-[-1];
												private _dist = (((_ai+[objNull]) select 0) distance player) min (((_veh+[objNull]) select 0) distance player);
												if (_dist < 20) then {
													_noExposeTime = 0;
													["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\bush_view_warning.paa'/>",0,0,1,0,0,923654] call BRPVP_fnc_dynamicText;
													BRPVP_personalBushFired = true;
												} else {
													if (_dist < 50 || _turretSaw) then {
														_noExposeTime = 0;
														if (_turretSaw) then {_vCount = (_vCount+2) min 8;} else {_vCount = _vCount+1;};
														if (_vCount isEqualTo 8) then {
															BRPVP_personalBushFired = true;
															["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\bush_view_warning.paa'/>",0,0,1,0,0,923654] call BRPVP_fnc_dynamicText;
														} else {
															["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\bush_view.paa'/>",0,0,0,0,0,923654] call BRPVP_fnc_dynamicText;
														};
													} else {
														_noExposeTime = _noExposeTime+1;
														if (_noExposeTime >= 10) then {
															_noExposeTime = 0;
															_vCount = (_vCount-1) max 0;
														};
													};
												};
											};
											if (player nearEntities [BRPVP_zombieMotherClass,3] isNotEqualTo []) then {
												if (!_zSee) then {
													_zSee = true;
													_zSeeLast = diag_tickTime;
													player setVariable ["brpvp_error_zed",false,true];
													["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\bush_view_half_warning.paa'/>",0,0,1,0,0,923654] call BRPVP_fnc_dynamicText;
													"bush_reveal" call BRPVP_playSound;
												};
											};
											if (_zSee && diag_tickTime-_zSeeLast >= 10) then {
												_zSee = false;
												player setVariable ["brpvp_error_zed",true,true];
											};
											if (diag_tickTime-_initI > 1) then {
												if (cameraView in ["INTERNAL","GUNNER"] && !BRPVP_spectateOn && isNull BRPVP_myUAVNow && !visibleMap) then {
													if (!BRPVP_personalBushFakeOn) then {
														[0,["missionintel1","PLAIN"]] remoteExecCall ["cutRsc",BRPVP_specOnMeMachines];
														[BRPVP_personalBush,true] remoteExecCall ["hideObject",BRPVP_specOnMeMachines];
														BRPVP_personalBushFakeOn = true;
													};
												} else {
													if (BRPVP_personalBushFakeOn) then {
														[0,["missionintel2","PLAIN"]] remoteExecCall ["cutRsc",BRPVP_specOnMeMachines];
														[BRPVP_personalBush,false] remoteExecCall ["hideObject",BRPVP_specOnMeMachines];
														BRPVP_personalBushFakeOn = false;
													};
												};
											};
											if (!captive player) then {player setCaptive true;};
											isNull BRPVP_personalBush || !alive player || _vCount isEqualTo 8 || !isNull objectParent player
										};
										if (!BRPVP_playerIsCaptive && !BRPVP_safeZone) then {player setCaptive false;};
										[0,["missionintel2","PLAIN"]] remoteExecCall ["cutRsc",BRPVP_specOnMeMachines];
										BRPVP_personalBushFakeOn = false;
										if (!_zSee) then {player setVariable ["brpvp_error_zed",false,true];};
									};
									"granted" call BRPVP_playSound;
									BRPVP_menuExtraLigado = false;
									hintSilent "";
								} else {
									"erro" call BRPVP_playSound;
								};
							} else {
								deleteVehicle BRPVP_personalBush;
								BRPVP_menuExtraLigado = false;
								hintSilent "";
							};
						} else {
							"erro" call BRPVP_playSound;
						};
					} else {
						if (_this isEqualTo "tower") then {
							_objOn = player getVariable ["brpvp_personal_tower",objNull];
							if (isNull _objOn) then {
								if (BRPVP_safeZone) then {
									"erro" call BRPVP_playSound;
								} else {
									_posPlayer = getPosASL player;
									_posPlayer set [2,(_posPlayer select 2)+1.5];
									_ang = getDir player;
									_posTwr = [(_posPlayer select 0)+5*sin _ang,(_posPlayer select 1)+5*cos _ang,_posPlayer select 2];
									_lis = lineIntersectsSurfaces [_posPlayer,_posTwr,player,objNull];
									_ok = true;
									if (_lis isEqualTo []) then {
										{
											for "_i" from 1 to 6 do {
												_a = _i*60;
												_p = [(_posTwr select 0)+5*sin _a,(_posTwr select 1)+5*cos _a,_posTwr select 2] vectorAdd [0,0,_x];
												_lis = lineIntersectsSurfaces [_posTwr,_p,player,objNull];
												if (count _lis > 0) exitWith {_ok = false;};
											};
											if (!_ok) exitWith {};
										} forEach [0,1,2,3,4,5];
									} else {
										_ok = false;
									};
									if (_ok) then {
										_mny = player getVariable ["brpvp_mny_bank",0];
										if (_mny >= BRPVP_personalTowerPrice) then {
											player setVariable ["brpvp_mny_bank",_mny-BRPVP_personalTowerPrice,true];
											call BRPVP_atualizaDebug;
											_pos = [player,5,getDir player] call BIS_fnc_relPos;
											if (ASLToAGL getPosASL player select 2 > 0.1) then {
												_pos set [2,getPosASL player select 2];
												_pos = ASLToAGL _pos;
											};
											_tower = createVehicle ["Land_Cargo_Patrol_V1_F",ASLToATL AGLToASL _pos,[],0,"CAN_COLLIDE"];
											_tower setVariable ["brpvp_can_loot",false,true];
											_tower setVariable ["brpvp_no_lars",true,2];
											_tower setDir (180+getDir player);
											_tower addAction [format ["<t color='#505050'>%1</t>",localize "str_rotate_personal_tower"],{(_this select 0) setDir (30+getDir (_this select 0));},[],2,false,false,"","_target distanceSqr player < 144"];
											_tower allowDamage false;
											player setVariable ["brpvp_personal_tower",_tower,[2,clientOwner]];
											[player,["drilling_b",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
											[localize "str_personal_tower_open",-5] call BRPVP_hint;
											BRPVP_menuExtraLigado = false;
											hintSilent "";
										} else {
											"erro" call BRPVP_playSound;
											[format [localize "str_need_x_in_bank",BRPVP_personalTowerPrice],-5] call BRPVP_hint;
										};
									} else {
										"erro" call BRPVP_playSound;
									};
								};
							} else {
								[player,["drilling_b",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
								private _center = ASLToAGL getPosWorld _objOn;
								deleteVehicle _objOn;
								[localize "str_personal_tower_closed",-5] call BRPVP_hint;
								BRPVP_menuExtraLigado = false;
								hintSilent "";
								_center spawn {
									uiSleep 0.001;
									[_this,10] call BRPVP_wakeUpObjectsFlying;
								};
							};
						} else {
							if (_this isEqualTo "stv") then {
								_objOn = player getVariable ["brpvp_personal_stv",objNull];
								if (isNull _objOn) then {
									private _pp = if (stance player isEqualTo "STAND") then {(getPosASL player vectorAdd eyePos player) vectorMultiply 0.5} else {eyePos player};
									private _pd = getDir player;
									private _ppf = _pp vectorAdd [3*sin _pd,3*cos _pd,0.25];
									private _lis = lineIntersectsSurfaces [_pp,_ppf,player,objNull,true,1,"GEOM","NONE"];
									private _lisBase = lineIntersectsSurfaces [_ppf,_ppf vectorAdd [0,0,-3],player,objNull,true,1,"GEOM","NONE"];
									if (_lis isEqualTo [] && _lisBase isNotEqualTo []) then {
										private _base = ASLToATL (_lisBase select 0 select 0);
										_mny = player getVariable ["brpvp_mny_bank",0];
										if (_mny >= BRPVP_personalSmartTvPrice) then {
											player setVariable ["brpvp_mny_bank",_mny-BRPVP_personalSmartTvPrice,true];
											call BRPVP_atualizaDebug;
											_stv = createVehicle ["Land_Billboard_F",_base vectorAdd [0,0,-0.75],[],0,"CAN_COLLIDE"];
											_stv setDir getDir player;
											_stv setVectorUp [0,0,1];
											_stv setVariable ["id_bd",-(player getVariable "id_bd")-10,true];
											_stv setVariable ["own",player getVariable "id_bd",true];
											_stv setVariable ["amg",[player getVariable "amg",[],true],true];
											_stv allowDamage false;
											private _stvIds = (call BRPVP_playersList apply {_x getVariable ["brpvp_machine_id",-1]}) select {_x >= 0};
											[_stv,true] remoteExecCall ["hideObject",_stvIds-BRPVP_specOnMeMachinesNoMe,true];
											player setVariable ["brpvp_personal_stv",_stv,[2,clientOwner]];
											[localize "str_personal_stv_open",-5] call BRPVP_hint;
											BRPVP_menuExtraLigado = false;
											hintSilent "";
										} else {
											"erro" call BRPVP_playSound;
											[format [localize "str_need_x_in_bank",BRPVP_personalSmartTvPrice],-5] call BRPVP_hint;
										};
									} else {
										"erro" call BRPVP_playSound;
									};
								} else {
									//DISCONNECT SMART TV
									private _camReal = _objOn getVariable ["brpvp_bb_camera",objNull];
									if (!isNull _camReal) then {
										private _camKey = "seccam"+str (_objOn getVariable "id_bd");
										_camReal cameraEffect ["Terminate","Back",_camKey];
										BRPVP_secCamBbsMy = BRPVP_secCamBbsMy-[[_objOn,_camReal,_camKey]];
										camDestroy _camReal;
									};

									_objOn remoteExecCall ["deleteVehicle",0];
									player setVariable ["brpvp_personal_stv",objNull,[2,clientOwner]];
									[localize "str_personal_stv_closed",-5] call BRPVP_hint;
									BRPVP_menuExtraLigado = false;
									hintSilent "";
								};
							} else {
								if (_this isEqualTo "vtip") then {96 spawn BRPVP_menuMuda;};
							};						
						};
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 133
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\turret_warning_2.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		_idBd = BRPVP_stuff getVariable ["id_bd",-1];
		if (_idBd > -1) then {
			BRPVP_getTurretKillsServerAnswer = nil;
			[player,_idBd] remoteExecCall ["BRPVP_getTurretKillsServer",2];
			waitUntil {!isNil "BRPVP_getTurretKillsServerAnswer"};
			{
				_x params ["_pId","_pName","_date"];
				_array = ["%3/%4/%5 %1-%2",_pId,_pName];
				_array append _date;
				BRPVP_menuOpcoes pushBack format _array;
				_array = ["%1/%2/%3 %4:%5"];
				_array append _date;
				BRPVP_menuExecutaParam pushBack format _array;
			} forEach BRPVP_getTurretKillsServerAnswer;
		};
		BRPVP_menuExecutaFuncao = {[_this,-10] call BRPVP_hint;};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 134
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		if (BRPVP_menuVar2) then {
			hintSilent parseText ("<t align='center' size='1.65'>"+localize "str_please_wait"+"</t>");
			sleep 0.5;
			BRPVP_menuVar2 = false;
		};
		_items = BRPVP_menuVar1 getVariable ["brpvp_spc_items",[]];
		if (_items select 0 isEqualType []) then {
			{
				_x params ["_ii","_qtt"];
				BRPVP_menuOpcoes pushBack format ["%1 X%2",BRPVP_specialItemsNames select _ii,_qtt];
				BRPVP_menuImagem pushBack format ["<img size='3.0' align='center' image='%1'/>",BRPVP_imagePrefix+(BRPVP_specialItemsImages select _ii)];
				BRPVP_menuExecutaParam pushBack [_ii,_qtt];
			} forEach _items;
			BRPVP_menuExecutaParam pushBack -1;
		} else {
			{
				_iIdx = BRPVP_specialItems find _x;
				BRPVP_menuOpcoes pushBack (BRPVP_specialItemsNames select _iIdx);
				BRPVP_menuImagem pushBack format ["<img size='3.0' align='center' image='%1'/>",BRPVP_imagePrefix+(BRPVP_specialItemsImages select _iIdx)];
			} forEach _items;
			BRPVP_menuExecutaParam = _items+[-1];
		};
		BRPVP_menuOpcoes pushBack localize "str_menu12_opt2";
		BRPVP_menuImagem pushBack "<img size='3' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/>";
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo -1) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				_items = BRPVP_menuVar1 getVariable ["brpvp_spc_items",[]];
				if (_items isEqualTo []) then {deleteVehicle BRPVP_menuVar1;};
			} else {
				_items = BRPVP_menuVar1 getVariable ["brpvp_spc_items",[]];
				[BRPVP_menuVar1,_this,player] remoteExecCall ["BRPVP_spcItemsAdd",2];
				if (_items isEqualTo [_this]) then {
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				} else {
					BRPVP_menuVar2 = true;
					134 spawn BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			_items = BRPVP_menuVar1 getVariable ["brpvp_spc_items",[]];
			if (_items isEqualTo []) then {deleteVehicle BRPVP_menuVar1;};
		};
	},

	//MENU 135
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefixNoMod+"watermark.paa'/>";
		BRPVP_menuOpcoes = [localize "str_opt_my_list",localize "str_opt_other_player"];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {
				BRPVP_menuVar1 = player getVariable ["id_bd",-1];
				BRPVP_menuVar2 = format ["%1 - %2",BRPVP_menuVar1,player getVariable ["nm","no_name"]];
				BRPVP_menuVar5 = 135;
				136 spawn BRPVP_menuMuda;
			} else {
				if (_this isEqualTo 1) then {138 spawn BRPVP_menuMuda;};
			};
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 136
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0.5;
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefixNoMod+"watermark.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_killedPlayersResumeReturn = nil;
		[clientOwner,BRPVP_menuVar1] remoteExecCall ["BRPVP_killedPlayersResumeGet",2];
		waitUntil {!isNil "BRPVP_killedPlayersResumeReturn"};
		{
			_x params ["_id","_victim","_qtt"];
			BRPVP_menuOpcoes pushBack format ["%1X - @memory_remove_back@%2",_qtt,_victim];
			BRPVP_menuExecutaParam pushBack [_id,_victim];
		} forEach BRPVP_killedPlayersResumeReturn;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar3 = _this select 0;
			BRPVP_menuVar4 = _this select 1;
			137 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {if (BRPVP_menuVar5 isEqualTo 138) then {BRPVP_menuVar5 spawn BRPVP_menuMuda;} else {BRPVP_menuVar5 call BRPVP_menuMuda;};};
	},

	//MENU 137
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0.5;
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefixNoMod+"watermark.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_killedPlayersCaseReturn = nil;
		[clientOwner,BRPVP_menuVar1,BRPVP_menuVar3] remoteExecCall ["BRPVP_killedPlayersCaseGet",2];
		waitUntil {!isNil "BRPVP_killedPlayersCaseReturn"};
		{
			_x params ["_proj","_dist","_date"];
			BRPVP_menuOpcoes pushBack format ["%1 %2",_dist,localize "str_meters"];
			BRPVP_menuExecutaParam pushBack [_proj,_date];
		} forEach BRPVP_killedPlayersCaseReturn;
		BRPVP_menuExecutaFuncao = {
			params ["_proj","_dt"];
			_txtDt = format ["%1/%2/%3",_dt select 0,_dt select 1,_dt select 2];
			[format ["%1\n%2",_txtDt,_proj],-8] call BRPVP_hint;
		};
		BRPVP_menuVoltar = {136 spawn BRPVP_menuMuda;};
	},

	//MENU 138
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0.5;
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefixNoMod+"watermark.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_killedPlayersOthersReturn = nil;
		clientOwner remoteExecCall ["BRPVP_killedPlayersOthersGet",2];
		waitUntil {!isNil "BRPVP_killedPlayersOthersReturn"};
		{
			_x params ["_id","_ofender","_qtt"];
			BRPVP_menuOpcoes pushBack format ["%1X - @memory_remove_back@%2",_qtt,_ofender];
			BRPVP_menuExecutaParam pushBack [_id,_ofender];
		} forEach BRPVP_killedPlayersOthersReturn;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this select 0;
			BRPVP_menuVar2 = _this select 1;
			BRPVP_menuVar5 = 138;
			136 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {135 call BRPVP_menuMuda;};
	},

	//MENU 139
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "<img size='2.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\amigo_color.paa'/> <img size='2.5' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\icones3d\amigo.paa'/>";
		BRPVP_menuOpcoes = [
			format [localize "str_ptype_bandit",if (BRPVP_usePlayerIconBandit) then {"X"} else {"   "}],
			format [localize "str_ptype_squad",if (BRPVP_usePlayerIconSquad) then {"X"} else {"   "}],
			format [localize "str_ptype_friends",if (BRPVP_usePlayerIconFriends) then {"X"} else {"   "}],
			format [localize "str_ptype_pve",if (BRPVP_usePlayerIconPve) then {"X"} else {"   "}]
		];
		BRPVP_menuExecutaParam = [0,1,2,3];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {BRPVP_usePlayerIconBandit = !BRPVP_usePlayerIconBandit;};
			if (_this isEqualTo 1) then {BRPVP_usePlayerIconSquad = !BRPVP_usePlayerIconSquad;};
			if (_this isEqualTo 2) then {BRPVP_usePlayerIconFriends = !BRPVP_usePlayerIconFriends;};
			if (_this isEqualTo 3) then {BRPVP_usePlayerIconPve = !BRPVP_usePlayerIconPve;};
			139 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 140
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = ["Select a City","Disable Fugitive Event"];
		BRPVP_menuExecutaParam = [0,1];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 0) then {
				141 call BRPVP_menuMuda;
			} else {
				{deleteVehicle _x;} forEach BRPVP_citySpawnedWeaponKits;
				BRPVP_citySpawnedWeaponKits = [];
				publicVariable "BRPVP_citySpawnedWeaponKits";
				BRPVP_fastSpawnPlacesFugitive = [];
				publicVariable "BRPVP_fastSpawnPlacesFugitive";
				["Fugitive Events Unconstructed!",-5] call BRPVP_hint;
				140 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {149 call BRPVP_menuMuda;};
	},

	//MENU 141
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_x params ["_pos","_rad","_name"];
			BRPVP_menuOpcoes pushBack _name;
			BRPVP_menuExecutaParam pushBack [_pos,_rad];
		} forEach BRPVP_locaisImportantes;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			142 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {140 call BRPVP_menuMuda;};
	},

	//MENU 142
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = [
			"100% MX GL",
			"100% SPAR-16 GL",
			"50% MX GL / 50% SPAR-16 GL"
		];
		BRPVP_menuExecutaParam = [
			[1,[3,[["brpvp_main_container",[[[["arifle_MX_GL_F","","",54,[0,100],[15,1],""],2]],[[0,10,100],[15,8,1]],[[29,99],[1,2]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]]]]],
			[1,[3,[["brpvp_main_container",[[[["arifle_SPAR_01_GL_blk_F","","",55,[7,150],[15,1],""],2]],[[15,8,1],[7,8,150]],[[29,99],[1,2]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]]]]],
			[0.5,[3,[["brpvp_main_container",[[[["arifle_MX_GL_F","","",54,[0,100],[15,1],""],2]],[[0,10,100],[15,8,1]],[[29,99],[1,2]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]]]],[3,[["brpvp_main_container",[[[["arifle_SPAR_01_GL_blk_F","","",55,[7,150],[15,1],""],2]],[[15,8,1],[7,8,150]],[[29,99],[1,2]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]],["V_Chestrig_blk",[[],[],[[],[]],[[],[]]]]]]]
		];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 = _this;
			143 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {141 call BRPVP_menuMuda;};
	},

	//MENU 143
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = ["5 loots","10 loots","15 loots","20 loots","25 loots","30 loots","35 loots","40 loots","45 loots","50 loots"];
		BRPVP_menuExecutaParam = [5,10,15,20,25,30,35,40,45,50];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 params ["_pos","_rad"];
			_roads = _pos nearRoads _rad;
			for "_i" from 1 to _this do {
				_road = _roads deleteAt (floor random count _roads);
				_wh = createVehicle ["GroundWeaponHolder",getPosATL _road,[],5,"CAN_COLLIDE"];
				BRPVP_citySpawnedWeaponKits pushBack _wh;
				_cargo = if (random 1 < BRPVP_menuVar2 select 0) then {BRPVP_menuVar2 select 1} else {BRPVP_menuVar2 select 2};
				[_wh,_cargo] call BRPVP_putItemsOnCargo;
				if (_roads isEqualTo []) exitWith {};
			};
			publicVariable "BRPVP_citySpawnedWeaponKits";
			"granted" call BRPVP_playSound;
			BRPVP_fastSpawnPlacesFugitive pushBackUnique [_pos,_rad+200];
			publicVariable "BRPVP_fastSpawnPlacesFugitive";
			29 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {142 call BRPVP_menuMuda;};
	},

	//MENU 144
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "<img size='5.0' image='"+BRPVP_imagePrefix+"BRP_imagens\paint_vehicle.paa'/>";
		BRPVP_menuOpcoes = [localize "str_paint_color",localize "str_paint_texture"];
		BRPVP_menuExecutaParam = [145,147];
		BRPVP_menuExecutaFuncao = {_this call BRPVP_menuMuda;};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 145
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = [];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			BRPVP_menuImagem pushBack format ["<img size='12.0' image='%1'/>",_x];
			BRPVP_menuOpcoes pushBack format [localize "str_texture_x",_forEachIndex+1];
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach getObjectTextures BRPVP_stuff;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			146 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {144 call BRPVP_menuMuda;};
	},

	//MENU 146
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0.25;
		BRPVP_menuImagem = [
			"<img size='5.0' image='#(argb,8,8,3)color(1,0,0,1)'/>", //VERMELHO
			"<img size='5.0' image='#(argb,8,8,3)color(0,1,0,1)'/>", //VERDE
			"<img size='5.0' image='#(argb,8,8,3)color(0,0,1,1)'/>", //AZUL
			"<img size='5.0' image='#(argb,8,8,3)color(0,0.4,0.8,1)'/>", //AZUL CEU
			"<img size='5.0' image='#(argb,8,8,3)color(0.8,0.8,0,1)'/>", //AMARELO
			"<img size='5.0' image='#(argb,8,8,3)color(0.8,0.4,0,1)'/>", //LARANJA
			"<img size='5.0' image='#(argb,8,8,3)color(0.6,0.4,0,1)'/>", //MARROM
			"<img size='5.0' image='#(argb,8,8,3)color(0.40,0.34,0.27,1)'/>", //MARROM ESCURO
			"<img size='5.0' image='#(argb,8,8,3)color(0.47,0.53,0.42,1)'/>", //VERDE MILITAR
			"<img size='5.0' image='#(argb,8,8,3)color(0.53,0.47,0.58,1)'/>", //MAGENTA
			"<img size='5.0' image='#(argb,8,8,3)color(0.52,0.56,0.68,1)'/>", //AZUL CINZA
			"<img size='5.0' image='#(argb,8,8,3)color(0.4,0,0.8,1)'/>", //VIOLETA
			"<img size='5.0' image='#(argb,8,8,3)color(0.8,0,0.8,1)'/>", //ROSA
			"<img size='5.0' image='#(argb,8,8,3)color(0.8,0,0.4,1)'/>", //ROXO
			"<img size='5.0' image='#(argb,8,8,3)color(0,0.8,0.8,1)'/>", //CIANO
			"<img size='5.0' image='#(argb,8,8,3)color(0.1,0.1,0.1,1)'/>", //CINZA
			"<img size='5.0' image='#(argb,8,8,3)color(1,1,1,1)'/>", //BRANCO
			"<img size='5.0' image='#(argb,8,8,3)color(0.09,0.09,0.09,1)'/>" //PRETO
		];
		BRPVP_menuOpcoes = call compile localize "str_color_array";
		BRPVP_menuExecutaParam = [
			"#(argb,8,8,3)color(0.3,0.1,0.1,0.65)", //VERMELHO
			"#(argb,8,8,3)color(0.1,0.3,0.1,0.65)", //VERDE
			"#(argb,8,8,3)color(0.1,0.1,0.3,0.65)", //AZUL
			"#(argb,8,8,3)color(0.1,0.2,0.3,0.65)", //AZUL CEU
			"#(argb,8,8,3)color(0.3,0.3,0.1,0.65)", //AMARELO
			"#(argb,8,8,3)color(0.4,0.2,0.1,0.65)", //LARANJA
			"#(argb,8,8,3)color(0.3,0.2,0.1,0.65)", //MARROM
			"#(argb,8,8,3)color(0.20,0.17,0.135,0.63)", //MARROM ESCURO
			"#(argb,8,8,3)color(0.235,0.265,0.21,0.55)", //VERDE MILITAR
			"#(argb,8,8,3)color(0.265,0.235,0.29,0.6)", //MAGENTA
			"#(argb,8,8,3)color(0.26,0.28,0.34,0.44)", //AZUL CINZA
			"#(argb,8,8,3)color(0.2,0.1,0.4,0.65)", //VIOLETA
			"#(argb,8,8,3)color(0.3,0.1,0.3,0.65)", //ROSA
			"#(argb,8,8,3)color(0.4,0.1,0.2,0.65)", //ROXO
			"#(argb,8,8,3)color(0.1,0.3,0.3,0.65)", //CIANO
			"#(argb,8,8,3)color(0.1,0.1,0.1,1)", //CINZA
			"#(argb,8,8,3)color(0.3,0.3,0.3,1)", //BRANCO
			"#(argb,8,8,3)color(0.09,0.09,0.09,1)" //PRETO
		];
		BRPVP_menuExecutaFuncao = {
			BRPVP_stuff setObjectTextureGlobal [BRPVP_menuVar1,_this];
			[BRPVP_stuff getVariable ["id_bd",-1],getObjectTextures BRPVP_stuff] remoteExecCall ["BRPVP_paintVehicleSaveChange",2];
		};
		BRPVP_menuVoltar = {
			if (alive BRPVP_stuff) then {
				145 call BRPVP_menuMuda;
			} else {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
		};
	},

	//MENU 147
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "<img size='5.0' image='"+BRPVP_imagePrefix+"BRP_imagens\paint_vehicle.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			BRPVP_menuOpcoes pushBack (getText (_x >> "displayName") call BRPVP_escapeForStructuredTextFast);
			BRPVP_menuExecutaParam pushBack getArray (_x >> "textures");
		} forEach ("true" configClasses (configFile >> "CfgVehicles" >> typeOf BRPVP_stuff >> "TextureSources"));
		BRPVP_menuExecutaFuncao = {
			{BRPVP_stuff setObjectTextureGlobal [_forEachIndex,_x];} forEach _this;
			[BRPVP_stuff getVariable ["id_bd",-1],getObjectTextures BRPVP_stuff] remoteExecCall ["BRPVP_paintVehicleSaveChange",2];
		};
		BRPVP_menuVoltar = {144 call BRPVP_menuMuda;};
	},

	//MENU 148
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "<img size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\patrimony.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_patrimony_total",
			localize "str_patrimony_money",
			localize "str_patrimony_buildings",
			localize "str_patrimony_vehicles",
			localize "str_patrimony_items"
		];
		BRPVP_menuExecutaParam = [6,2,3,4,5];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			_this spawn BRPVP_showPatrimony;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 149
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = ["Fugitive Event","Labirinty Event","Sniper Fight Event","Heli Fight Event"];
		BRPVP_menuExecutaParam = [140,150,151,152];
		BRPVP_menuExecutaFuncao = {
			_this call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 150
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = [
			"Create 15 X 15 Labirinty",
			"Create 20 X 20 Labirinty",
			"Create 30 X 30 Labirinty",
			"Create 40 X 40 Labirinty",
			"Set Labirinty Player Loadout",
			"Remove 20% of the walls",
			"Open/Close Labirinty",
			"Delete Labirinty"
		];
		BRPVP_menuExecutaParam = [15,20,30,40,"set_loadout","remove_part","open_close","delete"];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualType 0) then {
				[_this,player] remoteExecCall ["BRPVP_createLabirinty",2];
			} else {
				if (_this isEqualTo "delete") then {
					private _pilar = BRPVP_labObjs select 3 select 0;
					private _pilarPos = ASLToAGL getPosASL _pilar;
					private _rad = _pilar getVariable ["brpvp_lab_rad",0];
					{{deleteVehicle _x;} forEach _x;} forEach BRPVP_labObjs;
					{deleteVehicle _x;} forEach nearestObjects [_pilarPos,["Box_T_East_Wps_F","GroundWeaponHolder"],_rad,true];
					BRPVP_labObjs = [[],[],[],[],[]];
					publicVariable "BRPVP_labObjs";
					BRPVP_labNoThirdPerson = [];
					publicVariable "BRPVP_labNoThirdPerson";
				} else {
					if (_this isEqualTo "remove_part") then {
						private _walls = BRPVP_labObjs select 0;
						{if (random 1 < 0.2) then {deleteVehicle _x;};} forEach _walls;
						_walls = _walls-[objNull];
						BRPVP_labObjs set [0,_walls];
						publicVariable "BRPVP_labObjs";
					} else {
						if (_this isEqualTo "open_close") then {
							private _closers = BRPVP_labObjs select 2;
							if (count _closers > 0) then {
								private _isHidden = isObjectHidden (_closers select 0);
								{[_x,!_isHidden] remoteExecCall ["hideObjectGlobal",2];} forEach _closers;
							};
						} else {
							if (_this isEqualTo "set_loadout") then {
								if (BRPVP_labNoThirdPerson isEqualTo []) then {
									"erro" call BRPVP_playSound;
								} else {
									(BRPVP_labNoThirdPerson select 0) params ["_pos","_rad"];
									{
										if (isNull objectParent _x && getPos _x select 2 < 5 && _x distance2D _pos < _rad) then {
											if !(uniform _x isEqualTo "U_C_Journalist") then {_x setUnitLoadout [[],[],[],["U_C_Journalist",[]],[],[],"","",[],["ItemMap","","","","",""]];};
										};
									} forEach call BRPVP_playersList;
								};
							};
						};
					};
				};
			};
			["Action executed!",-4] call BRPVP_hint;
		};
		BRPVP_menuVoltar = {149 call BRPVP_menuMuda;};
	},

	//MENU 151
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = ["Create M320","Create Lynx","Delete Sniper Event"];
		BRPVP_menuExecutaParam = [0,1,"delete"];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualType 0) then {
				_cargos = [
					[3,[["brpvp_main_container",[[[["srifle_LRR_F","","","",[],[],""],6]],[[51,50,7]],[[58,2],[6,6]],[[],[]]]]]],
					[3,[["brpvp_main_container",[[[["srifle_GM6_F","","","",[],[],""],6]],[[80,60,5]],[[58,2],[6,6]],[[],[]]]]]]
				];
				_pos = getPos player;
				_pos set [2,0];
				_p1 = _pos vectorAdd [0,350,0];
				_p2 = _pos vectorAdd [0,-350,0];
				_bu1 = createVehicle ["Land_Offices_01_V1_F",_p1,[],0,"CAN_COLLIDE"];
				_bu1 setVariable ["brpvp_can_loot",false,true];
				_bu2 = createVehicle ["Land_Offices_01_V1_F",_p2,[],0,"CAN_COLLIDE"];
				_bu2 setVariable ["brpvp_can_loot",false,true];
				_bu2 setDir (getDir _bu2+180);
				(BRPVP_snipersFightObjs select 1) append [_bu1,_bu2];
				{
					_x params ["_px","_uniform"];
					_lis = lineIntersectsSurfaces [AGLToASL _px vectorAdd [0,0,60],AGLToASL _px vectorAdd [0,0,-1]];
					_wPos = ASLToAGL (_lis select 0 select 0);
					_wh = createVehicle ["GroundWeaponHolder",_wPos,[],0,"CAN_COLLIDE"];
					[_wh,_cargos select _this] call BRPVP_putItemsOnCargo;
					_wh addItemCargoGlobal [_uniform,6];
					_wh addBackpackCargoGlobal ["C_Bergen_blu",6];
					(BRPVP_snipersFightObjs select 1) pushBack _wh;
				} forEach [[_p1,"U_I_C_Soldier_Bandit_2_F"],[_p2,"U_C_man_sport_3_F"]];
				(BRPVP_snipersFightObjs select 0) pushBack [_pos,350];
				publicVariable "BRPVP_snipersFightObjs";
			} else {
				if (_this isEqualTo "delete") then {
					{
						if (typeOf _x isEqualTo "Land_Offices_01_V1_F") then {
							{
								if (getPosATL _x select 2 > 10) then {deleteVehicle _x;};
							} forEach nearestObjects [_x,["Box_T_East_Wps_F","GroundWeaponHolder"],20,true];
						};
						deleteVehicle _x;
					} forEach (BRPVP_snipersFightObjs select 1);
					BRPVP_snipersFightObjs = [[],[]];
					publicVariable "BRPVP_snipersFightObjs";
				};
			};
			["Action executed!",-4] call BRPVP_hint;
		};
		BRPVP_menuVoltar = {149 call BRPVP_menuMuda;};
	},

	//MENU 152
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = [
			"6X AH-9 Pawnee",
			"8X AH-9 Pawnee",
			"10X AH-9 Pawnee",
			"6X WY-55 Hellcat",
			"8X WY-55 Hellcat",
			"10X WY-55 Hellcat",
			"Unlock Helis",
			"Lock Helis",
			"Arm Helis",
			"Disarm Helis",
			"Remove God Mode",
			"Delete Event"
		];
		BRPVP_menuExecutaParam = [
			["B_Heli_Light_01_armed_F",6,25],
			["B_Heli_Light_01_armed_F",8,30],
			["B_Heli_Light_01_armed_F",10,35],
			["I_Heli_light_03_F",6,25],
			["I_Heli_light_03_F",8,30],
			["I_Heli_light_03_F",10,35],
			"unlock",
			"lock",
			"arm",
			"disarm",
			"nogodmode",
			"delete"
		];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualType []) then {
				if (BRPVP_heliEventObjs isEqualTo [[],[],[]]) then {
					params ["_class","_q","_rad"];
					private _helis = [];
					for "_i" from 1 to _q do {
						_a = _i*(360/_q);
						private _heli = createVehicle [_class,[player,_rad,_a] call BIS_fnc_relPos,[],0,"NONE"];
						[_heli,false] remoteExecCall ["allowDamage",0,true];
						_heli call BRPVP_emptyBox;
						_heli lock true;
						_heli setDir ([player,_heli] call BIS_fnc_dirTo);
						_heli setVehicleAmmo 0;
						_helis pushBack _heli;
					};
					BRPVP_heliEventObjs = [_helis,getPosWorld player,[[getPosWorld player,1000]]];
					publicVariable "BRPVP_heliEventObjs";
					["Action executed!",-4] call BRPVP_hint;
				} else {
					["Delete the current Heli Fight Event first!",-5] call BRPVP_hint;
				};
			} else {
				if (_this isEqualTo "delete") then {
					private _allCrew = [];
					{
						private _crew = crew _x;
						private _pos = getPosWorld _x;
						_pos set [2,0];
						deleteVehicle _x;
						_allCrew pushBack [_crew,_pos];
					} forEach (BRPVP_heliEventObjs select 0);
					_allCrew spawn {
						{
							_x params ["_crew","_pos"];
							waitUntil {{!isNull objectParent _x} count _crew isEqualTo 0};
							{
								[_x,[0,0,0]] remoteExecCall ["setVelocity",_x];
								[_x,[_pos,[],50,"NONE"]] remoteExecCall ["setVehiclePosition",_x];
							} forEach _crew;
						} forEach _this;
					};
					BRPVP_heliEventObjs = [[],[],[]];
					publicVariable "BRPVP_heliEventObjs";				
				} else {
					if (_this isEqualTo "unlock") then {
						{[_x,false] remoteExecCall ["lock",_x];} forEach (BRPVP_heliEventObjs select 0);
					} else {
						if (_this isEqualTo "lock") then {
							{[_x,true] remoteExecCall ["lock",_x];} forEach (BRPVP_heliEventObjs select 0);
						} else {
							if (_this isEqualTo "arm") then {
								{[_x,1] remoteExecCall ["setVehicleAmmo",_x];} forEach (BRPVP_heliEventObjs select 0);
							} else {
								if (_this isEqualTo "disarm") then {
									{[_x,0] remoteExecCall ["setVehicleAmmo",_x];} forEach (BRPVP_heliEventObjs select 0);
								} else {
									if (_this isEqualTo "nogodmode") then {
										{[_x,true] remoteExecCall ["allowDamage",0,true];} forEach (BRPVP_heliEventObjs select 0);
									};
								};
							};
						};
					};
				};
				["Action executed!",-4] call BRPVP_hint;
			};
			152 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {149 call BRPVP_menuMuda;};
	},

	//MENU 153
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = [localize "str_insurance_vehicle",localize "str_no_insurance_vehicle",localize "str_shop_fe"];
		BRPVP_menuExecutaParam = ["insu","noInsu","fedidex"];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			_sides = ["CIVIL","MILITAR","CIV-MIL","AIRPORT","BOATS","UAV","ADMIN","DENIED"];
			if (_this isEqualTo "insu") then {
				[0,0,0,[player,_sides,0,"default",false,153]] execVm "client_code\actions\actionVehicleTrader.sqf";
			} else {
				if (_this isEqualTo "noInsu") then {
					[0,0,0,[player,_sides,0,"default",true,153]] execVm "client_code\actions\actionVehicleTrader.sqf";
				} else {
					if (_this isEqualTo "fedidex") then {
						[0,0,0,[player,_sides,0,"fedidex_vg_like",false,153]] execVm "client_code\actions\actionVehicleTrader.sqf";
					};
				};
			};
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 154
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = "";
		BRPVP_menuOpcoes = [];
		{BRPVP_menuOpcoes pushBack (getText (configFile >> "CfgVehicles" >> _x >> "displayName") call BRPVP_escapeForStructuredTextFast);} forEach BRPVP_bagSoldierClasses;
		BRPVP_menuExecutaParam = +BRPVP_bagSoldierClasses;
		BRPVP_menuOpcoes pushBack localize "str_deactivate";
		BRPVP_menuExecutaParam pushBack "deactivate";
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "deactivate") then {
				deleteVehicle BRPVP_stuff;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				BRPVP_stuff setUnitLoadout getUnitLoadout _this;
				_wep = primaryWeapon BRPVP_stuff;
				if !(_wep isEqualTo "") then {BRPVP_stuff removeWeapon _wep;};
				_wep = secondaryWeapon BRPVP_stuff;
				if !(_wep isEqualTo "") then {BRPVP_stuff removeWeapon _wep;};
				_wep = handGunWeapon BRPVP_stuff;
				if !(_wep isEqualTo "") then {BRPVP_stuff removeWeapon _wep;};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 155
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuSleep = 0;
		BRPVP_menuImagem = [
			format ["<t size='1.5' color='#FFAF00'>$%1</t>",(if (BRPVP_carrierByTrader) then {BRPVP_carrierPrice} else {0}) call BRPVP_formatNumber],
			format ["<t size='1.5' color='#FFAF00'>$%1</t>",(if (BRPVP_carrierByTrader) then {BRPVP_carrierPriceMove} else {0}) call BRPVP_formatNumber],
			format ["<t size='1.5' color='#FFAF00'>$%1</t>",BRPVP_carrierRefund call BRPVP_formatNumber]
		];
		if (BRPVP_carrierByTrader) then {
			BRPVP_menuOpcoes = [localize "str_menu_carr_create",localize "str_menu_carr_move",localize "str_menu_carr_refund"];
			BRPVP_menuExecutaParam = [1,2,3];
		} else {
			BRPVP_menuOpcoes = [localize "str_menu_carr_create",localize "str_menu_carr_move"];
			BRPVP_menuExecutaParam = [1,2];
		};
		BRPVP_menuExecutaFuncao = {
			BRPVP_carrierHaveObj = objNull;
			private _id_bd = player getVariable "id_bd";
			{if ((_x getVariable "brpvp_carr_own") isEqualTo _id_bd) exitWith {BRPVP_carrierHaveObj = _x;};} forEach BRPVP_carrierObjsList;
			if (_this isEqualTo 3) then {
				if (isNull BRPVP_carrierHaveObj) then {
					"erro" call BRPVP_playSound;
				} else {
					BRPVP_carrierHaveObj remoteExecCall ["BRPVP_carrierObjsListRemove",0];
					private _partsClass = BRPVP_carrierHaveObj getVariable "BIS_carrierParts";
					private _objs = _partsClass apply {_x select 0};
					private _id = BRPVP_carrierHaveObj getVariable "brpvp_carr_id_bd";
					deleteVehicle BRPVP_carrierHaveObj;
					{deleteVehicle _x;} forEach _objs;
					player setVariable ["mny",(player getVariable ["mny",0])+BRPVP_carrierRefund,true];
					"negocio" call BRPVP_playSound;
					call BRPVP_atualizaDebug;
					[localize "str_carr_deleted",-6] call BRPVP_hint;
					_id remoteExecCall ["BRPVP_veiculoMorreu",2];
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				};
			} else {
				if (!isNull BRPVP_carrierHaveObj && _this isEqualTo 1) then {
					"erro" call BRPVP_playSound;
					[localize "str_carr_already_have",-6] call BRPVP_hint;
				} else {
					if (_this isEqualTo 2 && isNull BRPVP_carrierHaveObj) exitWith {"erro" call BRPVP_playSound;};
					_price = if (_this isEqualTo 1) then {
						if (BRPVP_carrierByTrader) then {BRPVP_carrierPrice} else {0}
					} else {
						if (_this isEqualTo 2) then {
							if (BRPVP_carrierByTrader) then {BRPVP_carrierPriceMove} else {0}
						};
					};
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					BRPVP_carrierPutPos = [];
					BRPVP_carrierPutDir = -1;
					BRPVP_carrierUseStatus = 1;
					_price spawn {
						_price = _this;
						waitUntil {openMap true;visibleMap};
						_cancel = {
							BRPVP_carrierPutPos = [];
							BRPVP_carrierPutDir = -1;
							BRPVP_carrierUseStatus = 0;
							BRPVP_onMapSingleClick = BRPVP_carrierHoldMapClick;
							openMap false;
							if (!BRPVP_carrierByTrader && !_success) then {["BRPVP_carrier",1] call BRPVP_sitAddItem;};
						};
						[localize "str_carr_msg_select_pos",-8] call BRPVP_hint;
						BRPVP_carrierHoldMapClick = BRPVP_onMapSingleClick;
						BRPVP_onMapSingleClick = BRPVP_carrierMapClickSetPos;
						BRPVP_carrierEscPressed = false;
						private _success = false;
						waitUntil {
							if (!visibleMap) then {openMap true;};
							count BRPVP_carrierPutPos isEqualTo 3 || BRPVP_menuExtraLigado || BRPVP_carrierEscPressed || !(player call BRPVP_pAlive)
						};
						if (BRPVP_menuExtraLigado || BRPVP_carrierEscPressed || !(player call BRPVP_pAlive)) exitWith {call _cancel;};
						[localize "str_carr_msg_select_dir",-8] call BRPVP_hint;
						BRPVP_carrierUseStatus = 2;
						BRPVP_carrierEscPressed = false;
						waitUntil {
							if (!visibleMap) then {openMap true;};
							BRPVP_carrierPutDir != -1 || BRPVP_menuExtraLigado || BRPVP_carrierEscPressed || !(player call BRPVP_pAlive)
						};
						if (BRPVP_menuExtraLigado || BRPVP_carrierEscPressed || !(player call BRPVP_pAlive)) exitWith {call _cancel;};
						private _nearC = nearestObjects [BRPVP_carrierPutPos,["Land_Carrier_01_base_F"],500,true]-[BRPVP_carrierHaveObj];
						private _eFlag = {!([player,_x] call BRPVP_checaAcessoRemotoFlag)} count nearestObjects [BRPVP_carrierPutPos,["Flag_Carrier"],600,true] > 0;
						if (_nearC isEqualTo [] && !_eFlag) then {
							_mny = player getVariable ["mny",0];
							if (_mny >= _price) then {
								player setVariable ["mny",_mny-_price,true];
								[["comprou",_price]] call BRPVP_mudaExp;
								[player,BRPVP_carrierPutPos,BRPVP_carrierPutDir,BRPVP_carrierHaveObj] remoteExecCall ["BRPVP_carrierCreateOrMoveServer",2];
								"negocio" call BRPVP_playSound;
								"ugranted" call BRPVP_playSound;
								_success = true;
								call BRPVP_atualizaDebug;
							} else {
								"erro" call BRPVP_playSound;
								[format [localize "str_mny_need_x_in_wallet",_price call BRPVP_formatNumber],-6] call BRPVP_hint;
							};
						} else {
							"erro" call BRPVP_playSound;
							[localize "str_carr_msg_cant_carr_near",-6] call BRPVP_hint;
						};
						call _cancel;
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			if (!BRPVP_carrierByTrader) then {["BRPVP_carrier",1] call BRPVP_sitAddItem;};
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 156
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\personal_menu.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];

		private _placeOk = BRPVP_safeZone || player call BRPVP_checkOnFlagState > 0;
		private _anywere = BRPVP_openPersonalVaultAnywhere;
		private _vaultPrice = if (_placeOk) then {BRPVP_vaultPrice} else {if (_anywere) then {BRPVP_vaultPriceOutPlace} else {BRPVP_vaultPriceOutPlaceNoPerk};};

		hintSilent parseText ("<t align='center' size='1.65'>"+localize "str_please_wait"+"</t>");
		BRPVP_receiveVaultsTipsFromServer = nil;
		[player getVariable "id",clientOwner] remoteExecCall ["BRPVP_receiveVaultsTipsFromServerGet",2];
		waitUntil {!isNil "BRPVP_receiveVaultsTipsFromServer"};

		for "_i" from 0 to (BRPVP_vaultNumberRun-1) do {
			private _found = false;
			{
				_x params ["_idx","_tip","_fill"];
				if (_idx isEqualTo _i) exitWith {
					BRPVP_menuOpcoes pushBack format ["%1 %2 %3%4 - $%5K",_idx+1,_tip,_fill,"%",round (_vaultPrice/1000)];
					BRPVP_menuExecutaParam pushBack _idx;
					_found = true;
				};
			} forEach BRPVP_receiveVaultsTipsFromServer;
			if (!_found) then {
				BRPVP_menuOpcoes pushBack format ["%1 %2 %3%4 - $%5K",_i+1,"(???)",0,"%",round (_vaultPrice/1000)];
				BRPVP_menuExecutaParam pushBack _i;
			};
		};
		BRPVP_menuExecutaFuncao = {
			if (isNull objectParent player) then {
				_tempo = BRPVP_vaultAcaoTempo-time;
				if (_tempo > 0) then {
					[format [localize "str_vault_cant",(round _tempo) max 1],0] call BRPVP_hint;
				} else {
					if (BRPVP_vaultLigada) then {
						BRPVP_menuExtraLigado = false;
						hintSilent "";
					} else {
						//if (BRPVP_safeZone || player call BRPVP_checkOnFlagState > 0 || BRPVP_openPersonalVaultAnywhere) then {
						if (true) then {
							private _placeOk = BRPVP_safeZone || player call BRPVP_checkOnFlagState > 0;
							private _anywere = BRPVP_openPersonalVaultAnywhere;
							private _vaultPrice = if (_placeOk) then {BRPVP_vaultPrice} else {if (_anywere) then {BRPVP_vaultPriceOutPlace} else {BRPVP_vaultPriceOutPlaceNoPerk};};

							_mny = player getVariable ["brpvp_mny_bank",0];
							if (_mny >= _vaultPrice) then {
								"buttom_on" call BRPVP_playSound;
								BRPVP_vaultAcaoTempo = time+1;
								private _ok = _this call BRPVP_vaultAbre;
								if (_ok) then {
									player setVariable ["brpvp_mny_bank",_mny-_vaultPrice,true];
									call BRPVP_atualizaDebug;
									BRPVP_menuExtraLigado = false;
									hintSilent "";
								};
							} else {
								"erro" call BRPVP_playSound;
								[format [localize "str_need_x_in_bank",_vaultPrice],-5] call BRPVP_hint;
							};
						} else {
							"erro" call BRPVP_playSound;
							[localize "str_cant_open_vault_1",-5] call BRPVP_hint;
							BRPVP_menuExtraLigado = false;
							hintSilent "";
						};
					};
				};
			} else {
				"erro" call BRPVP_playSound;
			};
		};
		BRPVP_menuVoltar = {132 call BRPVP_menuMuda;};
	},

	//MENU 157
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\personal_menu.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			private _id_bd = _x getVariable ["id_bd",-1];
			private _vaults = _x getVariable ["brpvp_vaults",[-1,-1]];
			private _qt = (_vaults select 1) max (_x getVariable ["brpvp_vaults_xp",0]);
			if (_id_bd > -1 && _qt > -1) then {BRPVP_menuOpcoes pushBack [_qt,str _id_bd+" - "+name _x+"@memory_remove_after@ X"+str _qt,[_id_bd,_vaults]];};
		} forEach call BRPVP_playersList;
		BRPVP_menuOpcoes sort false;
		BRPVP_menuExecutaParam = BRPVP_menuOpcoes apply {_x select 2};
		BRPVP_menuOpcoes = BRPVP_menuOpcoes apply {_x select 1};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			158 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 158
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\personal_menu.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuPosForce = if (BRPVP_menuVar1 select 1 select 0 isEqualTo -1) then {0} else {BRPVP_menuVar1 select 1 select 1};
		BRPVP_menuOpcoes = [localize "str_mkt_sub11_0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"];
		BRPVP_menuExecutaParam = [-1,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
		BRPVP_menuExecutaFuncao = {
			private _id = BRPVP_menuVar1 select 0;
			private _player = objNull;
			{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_player = _x;}} forEach call BRPVP_playersList;
			if (isNull _player) then {
				"erro" call BRPVP_playSound;
			} else {
				_player setVariable ["brpvp_vaults",[_this,if (_this isEqualTo -1) then {BRPVP_vaultNumberCfg} else {_this}],true];
				[_player,_id,_this] remoteExecCall ["BRPVP_updateVaultsSV",2];
				"granted" call BRPVP_playSound;
			};
			157 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {157 call BRPVP_menuMuda;};
	},

	//MENU 159
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\virtual_garage.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_id_bd = _x getVariable ["id_bd",-1];
			_vgMult = (_x getVariable ["brpvp_vg_mult",1]) max (_x getVariable ["brpvp_xp_vg_x",1]);
			if (_id_bd > -1 && _vgMult > -1) then {BRPVP_menuOpcoes pushBack [_vgMult,str _id_bd+" - "+name _x+"@memory_remove_after@ X"+str _vgMult,[_id_bd,_vgMult]];};
		} forEach call BRPVP_playersList;
		BRPVP_menuOpcoes sort false;
		BRPVP_menuExecutaParam = BRPVP_menuOpcoes apply {_x select 2};
		BRPVP_menuOpcoes = BRPVP_menuOpcoes apply {_x select 1};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			160 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 160
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\virtual_garage.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = ["1","2","3","4","5","6","7","8","9","10","20","30","40","50"];
		BRPVP_menuExecutaParam = [1,2,3,4,5,6,7,8,9,10,20,30,40,50];
		private _idx = BRPVP_menuExecutaParam find (BRPVP_menuVar1 select 1);
		BRPVP_menuPosForce = if (_idx isEqualTo -1) then {0} else {_idx};
		BRPVP_menuExecutaFuncao = {
			private _id = BRPVP_menuVar1 select 0;
			private _player = objNull;
			{if (_x getVariable ["id_bd",-1] isEqualTo _id) exitWith {_player = _x;}} forEach call BRPVP_playersList;
			if (isNull _player) then {
				"erro" call BRPVP_playSound;
			} else {
				_player setVariable ["brpvp_vg_mult",_this,true];
				[_id,_this] remoteExecCall ["BRPVP_updateVgMultSV",2];
				"granted" call BRPVP_playSound;
			};
			159 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {159 call BRPVP_menuMuda;};
	},

	//MENU 161
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_xp_menu_points",localize "str_xp_menu_habilities",localize "str_xp_menu_see_other",localize "str_xp_menu_see_other_hab"];
		BRPVP_menuExecutaParam = [1,2,3,4];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 4) then {
				168 call BRPVP_menuMuda;
			} else {
				if (_this isEqualTo 3) then {
					162 call BRPVP_menuMuda;
				} else {
					"granted" call BRPVP_playSound;
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					[_this,player,161] spawn BRPVP_xpSeeInfo;
				};
			};
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 162
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		private _myIdbd = player getVariable "id_bd";
		{
			private _p = _x;
			private _pAmg = _p getVariable ["amg",[]];
			private _id_bd = _p getVariable ["id_bd",-1];
			if (_id_bd > -1 && (_myIdbd in _pAmg || BRPVP_vePlayers)) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+(_p getVariable ["nm","no_name"]));
				BRPVP_menuExecutaParam pushBack _id_bd;
			};
		} forEach call BRPVP_playersList;
		BRPVP_menuExecutaFuncao = {
			_found = objNull;
			{if ((_x getVariable ["id_bd",-1]) isEqualTo _this) exitWith {_found = _x;};} forEach call BRPVP_playersList;
			if (isNull _found) then {
				"erro" call BRPVP_playSound;
				162 call BRPVP_menuMuda;
			} else {
				"granted" call BRPVP_playSound;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				[1,_found,162] spawn BRPVP_xpSeeInfo;
			};
		};
		BRPVP_menuVoltar = {161 call BRPVP_menuMuda;};
	},

	//MENU 163
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			_id_bd = _x getVariable ["id_bd",-1];
			_sok = _x getVariable ["sok",false];
			if (_id_bd > -1 && _sok) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+(_x getVariable ["nm","no_name"]));
				BRPVP_menuExecutaParam pushBack _id_bd;
			};
		} forEach call BRPVP_playersList;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			164 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 164
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if (getNumber (configFile >> "CfgVehicles" >> _x >> "scope") isEqualTo 2) then {
				if (_x isKindOf ["CaManBase",configFile >> "CfgVehicles"] && _x find "_F" isEqualTo (count _x-2)) then {
					BRPVP_menuOpcoes pushBack _x;
				};
			};
		} forEach ("true" configClasses (configFile >> "CfgVehicles") apply {configName _x});
		BRPVP_menuOpcoes sort true;
		BRPVP_menuExecutaParam = [""]+BRPVP_cloneCustomNames+BRPVP_menuOpcoes;
		BRPVP_menuOpcoes = ["BRPVP Default"]+BRPVP_cloneCustomNames+BRPVP_menuOpcoes;
		
		private _found = objNull;
		{if ((_x getVariable ["id_bd",-1]) isEqualTo BRPVP_menuVar1) exitWith {_found = _x;};} forEach call BRPVP_playersList;

		private _idx = BRPVP_menuExecutaParam find (_found getVariable ["brpvp_my_clone",""]);
		BRPVP_menuPosForce = if (_idx isEqualTo -1) then {0} else {_idx};
		BRPVP_menuExecutaFuncao = {
			[BRPVP_menuVar1,_this] remoteExecCall ["BRPVP_recordCloneOnDb",2];

			private _found = objNull;
			{if ((_x getVariable ["id_bd",-1]) isEqualTo BRPVP_menuVar1) exitWith {_found = _x;};} forEach call BRPVP_playersList;

			if (!isNull _found) then {_found setVariable ["brpvp_my_clone",_this,true];};
			"granted" call BRPVP_playSound;
			163 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {163 call BRPVP_menuMuda;};
	},

	//MENU 165
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		if (BRPVP_useExtDB3) then {
			hintSilent parseText ("<t align='center' size='1.65'>"+localize "str_please_wait"+"</t>");
			sleep 0.25;
			BRPVP_allHabStates = nil;
			player remoteExecCall ["BRPVP_allHabStatesGetSv",2];
			waitUntil {!isNil "BRPVP_allHabStates";};
			_xpPerks = BRPVP_xpPerks apply {[_x select 0,_x select 1,_x select 2,!(_x select 4 in [39]),_x select 4]};
			{
				_x params ["_id","_state"];
				{if (_x select 4 isEqualTo _id) then {_x set [3,_state];};} forEach _xpPerks;
			} forEach BRPVP_allHabStates;
			{
				_x params ["_name","_xp","_code","_enabled","_id"];
				if (_enabled) then {
					BRPVP_menuOpcoes pushBack ("(X) "+_name);
					BRPVP_menuExecutaParam pushBack [false,_id];
				} else {
					BRPVP_menuOpcoes pushBack ("(   ) "+_name);
					BRPVP_menuExecutaParam pushBack [true,_id];
				};
			} forEach _xpPerks;
		};
		BRPVP_menuExecutaFuncao = {
			params ["_state","_id"];
			private _ids = [_id];
			if (_state) then {{if (_id isEqualTo (_x select 4)) then {_ids append (_x select 5 select 1)};} forEach BRPVP_xpPerks;};
			if (!_state) then {{if (_id in (_x select 5 select 1)) then {_ids pushBack (_x select 4)};} forEach BRPVP_xpPerks;};
			{[_state,_x] remoteExecCall ["BRPVP_enableDisableHabilitie",2];} forEach _ids;
			[localize "str_xp_enable_msg",-6] call BRPVP_hint;
			165 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 166
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\scanner.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_menuVar2 params ["_q","_objs","_code"];
		{
			BRPVP_menuOpcoes pushBack (_x call _code);
			BRPVP_menuExecutaParam pushBack _x;
		} forEach _objs;
		BRPVP_menuExecutaFuncao = {
			private _myPlayerOrUAV = BRPVP_myPlayerOrUAV;
			BRPVP_followAction = _myPlayerOrUAV addAction [format ["<t color='#C04040'>%1</t>",localize "str_scan_stop"],{(_this select 3) removeAction BRPVP_followAction;BRPVP_followAction = -1;},_myPlayerOrUAV,2,false,true,"",""];
			player setVariable ["brpvp_spect_scanner_on",_this,BRPVP_specOnMeMachines];
			player setVariable ["brpvp_spect_scanner_my_drone",_myPlayerOrUAV,true];
			player setVariable ["brpvp_scanner_menu_var_3",BRPVP_menuVar3];
			[BRPVP_menuVar3,_this,player,_myPlayerOrUAV] remoteExec ["BRPVP_doScannerArrowSpectator",BRPVP_specOnMeMachinesNoMe];
			[_this,player,_myPlayerOrUAV,BRPVP_menuVar3] spawn {
				params ["_sObj","_player","_myPlayerOrUAV","_menuVar3"];
				_arrow = createSimpleObject ["Sign_Arrow_Direction_Green_F",[0,0,0],true];
				_isMan = _sObj isKindOf "CaManBase";
				waitUntil {
					_err = (((_myPlayerOrUAV distance _sObj)-0.7*_menuVar3)/(0.5*_menuVar3)) max 0 min 2;
					_pp = getPosASL _myPlayerOrUAV;
					_dir = getDir _myPlayerOrUAV;
					_onFoot = _myPlayerOrUAV isKindOf "CaManBase";
					_front = if (_onFoot) then {if (isNull objectParent _myPlayerOrUAV) then {[(_pp select 0)+2.5*sin _dir,(_pp select 1)+2.5*cos _dir,(_pp select 2)+1]} else {BRPVP_posicaoFora};} else {[(_pp select 0)+5*sin _dir,(_pp select 1)+5*cos _dir,(_pp select 2)+1]};
					_arrow setPosASL _front;
					_oPos = (getPosWorldVisual _sObj) vectorAdd (if (_isMan) then {[0,0,1]} else {[0,0,0]});
					_vecDir = vectorNormalized (_oPos vectorDiff _front);
					_vecUp = _vecDir vectorCrossProduct [0,0,1];
					_eDir = [random (2*_err)-_err,random (2*_err)-_err,random (2*_err)-_err];
					_eUp = [random (2*_err)-_err,random (2*_err)-_err,random (2*_err)-_err];
					_arrow setVectorDirAndUp [_vecDir vectorAdd _eDir,_vecUp vectorAdd _eUp];
					_objNotOk = isNull _sObj || isObjectHidden _sObj || !isNull attachedTo _sObj;
					!(_player call BRPVP_pAlive) || !alive _myPlayerOrUAV || BRPVP_followAction isEqualTo -1 || _objNotOk
				};
				if (BRPVP_followAction > -1) then {
					_myPlayerOrUAV removeAction BRPVP_followAction;
					BRPVP_followAction = -1;
				};
				deleteVehicle _arrow;
				BRPVP_usedScannerRunning = false;
				player setVariable ["brpvp_spect_scanner_on",objNull,BRPVP_specOnMeMachines];
				player setVariable ["brpvp_spect_scanner_my_drone",objNull,true];
			};
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
		BRPVP_menuVoltar = {120 call BRPVP_menuMuda;};
	},

	//MENU 167
	{
		BRPVP_menuSleep = 0;
		BRPVP_menuTipo = 1;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\novato.paa'/>";
		BRPVP_menuCorSelecao = "#AAAAAA";
		BRPVP_menuOpcoes = [];
		{if (_x getVariable ["brpvp_is_newer",false]) then {BRPVP_menuOpcoes pushBack (_x getVariable ["nm","no_name"]);};} forEach call BRPVP_playersList;
		BRPVP_menuVoltar = {30 spawn BRPVP_menuMuda;};
	},

	//MENU 168
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		private _myIdbd = player getVariable "id_bd";
		{
			private _p = _x;
			private _pAmg = _p getVariable ["amg",[]];
			private _id_bd = _p getVariable ["id_bd",-1];
			if (_id_bd > -1 && (_myIdbd in _pAmg || BRPVP_vePlayers)) then {
				BRPVP_menuOpcoes pushBack (str _id_bd+" - "+(_p getVariable ["nm","no_name"]));
				BRPVP_menuExecutaParam pushBack _id_bd;
			};
		} forEach call BRPVP_playersList;
		BRPVP_menuExecutaFuncao = {
			_found = objNull;
			{if ((_x getVariable ["id_bd",-1]) isEqualTo _this) exitWith {_found = _x;};} forEach call BRPVP_playersList;
			if (isNull _found) then {
				"erro" call BRPVP_playSound;
				168 call BRPVP_menuMuda;
			} else {
				"granted" call BRPVP_playSound;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				[2,_found,168,false] spawn BRPVP_xpSeeInfo;
			};
		};
		BRPVP_menuVoltar = {161 call BRPVP_menuMuda;};
	},

	//MENU 169
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\turret_warning_2.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		private _tt = BRPVP_stuff getVariable ["brpvp_all_target",["man","car","armor","harmor","air","plane"]];
		{
			_x params ["_code","_txt"];
			if (_code in _tt) then {
				BRPVP_menuOpcoes pushBack format ["(X) %1",_txt];
				BRPVP_menuExecutaParam pushBack [_code,"remove"];
			} else {
				BRPVP_menuOpcoes pushBack format ["(   ) %1",_txt];
				BRPVP_menuExecutaParam pushBack [_code,"add"];
			};
		} forEach [["man",localize "str_tt_man"],["car",localize "str_tt_car"],["armor",localize "str_tt_armor"],["harmor",localize "str_tt_harmor"],["air",localize "str_tt_air"],["plane",localize "str_tt_plane"]];
		BRPVP_menuExecutaFuncao = {
			params ["_code","_action"];
			private _tt = BRPVP_stuff getVariable ["brpvp_all_target",["man","car","armor","harmor","air","plane"]];
			if (_action isEqualTo "add") then {
				_tt pushBackUnique _code;
				BRPVP_stuff setVariable ["brpvp_all_target",_tt];
			} else {
				_tt = _tt-[_code];
				BRPVP_stuff setVariable ["brpvp_all_target",_tt];
			};
			169 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			private _tt = BRPVP_stuff getVariable ["brpvp_all_target",["man","car","armor","harmor","air","plane"]];
			private _isDefault = (["man","car","armor","harmor","air","plane"]-_tt) isEqualTo [];
			private _exec = "_this setVariable ['brpvp_tlevel',2,true];";
			BRPVP_stuff setVariable ["brpvp_all_target",_tt,true];
			if (!_isDefault) then {
				_exec = format ["_this setVariable ['brpvp_tlevel',2,true];_this setVariable ['brpvp_all_target',%1,true]",[str _tt,"""","'"] call BRPVP_stringReplace];
			};
			[BRPVP_stuff getVariable ["id_bd",-1],_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
			22 call BRPVP_menuMuda;
		};
	},

	//MENU 170
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_getDeadBasesFlagsReturn = nil;
		clientOwner remoteExecCall ["BRPVP_getDeadBasesFlags",2];
		waitUntil {!isNil "BRPVP_getDeadBasesFlagsReturn"};
		{
			_x params ["_id","_position","_oCnt"];
			private _agl = (_position select 0 select [0,2])+[0];
			private _min = 10000000;
			{
				private _dist = _x distance2D _agl;
				if (_dist < _min) then {_min = _dist};
			} forEach (BRPVP_allFlags+BRPVP_revivedFlags);
			private _nfd = if (_min isEqualTo 10000000) then {"..."} else {format ["%1m",round _min]};
			BRPVP_menuOpcoes pushBack format ["%1 - X%2 objects (%3)",(_position select 0 select [0,2]) apply {round _x},_oCnt,_nfd];
			BRPVP_menuExecutaParam pushBack [_id,_position select 0];
		} forEach BRPVP_getDeadBasesFlagsReturn;
		BRPVP_menuExecutaFuncao = {
			(_this select 0) remoteExecCall ["BRPVP_reviveDeadBase",2];
			[localize "str_revive_base_next_restart",-6] call BRPVP_hint;
			"ugranted" call BRPVP_playSound;
			BRPVP_revivedFlags pushBack (_this select 1);
			publicVariable "BRPVP_revivedFlags";
			170 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 171
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0.25;
		BRPVP_classAdVehicleCheckStatusReturn = nil;
		[player,BRPVP_stuff getVariable ["id_bd",-1]] remoteExecCall ["BRPVP_classAdVehicleCheckStatusSv",2];
		waitUntil {!isNil "BRPVP_classAdVehicleCheckStatusReturn"};
		if (BRPVP_classAdVehicleCheckStatusReturn isEqualTo []) then {
			BRPVP_menuOpcoes = [localize "str_option_true_class_ad",localize "str_option_false_class_ad"];
			BRPVP_menuExecutaParam = [1,2];
		} else {
			if (BRPVP_classAdVehicleCheckStatusReturn isEqualTo [[[]]]) then {
				BRPVP_menuOpcoes = [];
				BRPVP_menuExecutaParam = [];
			} else {
				BRPVP_menuOpcoes = [localize "str_option_remove_class_ad"];
				BRPVP_menuExecutaParam = [3];
			};
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 1) then {
				172 call BRPVP_menuMuda;
			} else {
				if (_this isEqualTo 2) then {
					173 call BRPVP_menuMuda;
				} else {
					174 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 172
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				"granted" call BRPVP_playSound;
				[BRPVP_stuff,false] call BRPVP_openVehicleClassAdCreation;
			} else {
				171 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {171 spawn BRPVP_menuMuda;};
	},

	//MENU 173
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				"granted" call BRPVP_playSound;
				[BRPVP_stuff,true] call BRPVP_openVehicleClassAdCreation;
			} else {
				171 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {171 spawn BRPVP_menuMuda;};
	},

	//MENU 174
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				(BRPVP_stuff getVariable ["id_bd",-1]) remoteExecCall ["BRPVP_removeClassAdVehicle",2];
				[localize "str_class_ad_false_removed",-5] call BRPVP_hint;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				22 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 175
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_cat_see_vehicles",localize "str_cat_remove_veh_sell",localize "str_cat_see_items",localize "str_cat_remove_items_sell"];
		BRPVP_menuExecutaParam = [176,178,181,183];
		BRPVP_menuExecutaFuncao = {_this spawn BRPVP_menuMuda;};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 176
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0.5;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_classAdVehicleListReturn = nil;
		player remoteExecCall ["BRPVP_classAdVehicleListSv",2];
		waitUntil {!isNil "BRPVP_classAdVehicleListReturn"};
		{
			private _name = [_x select 7,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			private _fake = _x select 9;
			if (_fake isNotEqualTo []) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_fake select 0)*_i mod count _name;
					private _p2 = (_fake select 0)*10*_i mod count _name;
					private _count = 0;
					while {_name select [_p1,1] isEqualTo (_name select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _name;
						_count = _count+1;
					};
					_name = format ["%1%2%3",_name select [0,_p1],_name select [_p2,1],_name select [_p1+1,count _name-(_p1+1)]];
				};
			};
			BRPVP_menuOpcoes pushBack format ["%1 ($%2)",_name,(_x select 3) call BRPVP_numberSetSufix];
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_classAdVehicleListReturn;
		BRPVP_menuOptionCode = {
			disableSerialization;
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			private _idx = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_display = findDisplay 46;

			private _adName = BRPVP_classAdVehicleListReturn select _idx select 7;
			private _adDescr = BRPVP_classAdVehicleListReturn select _idx select 8;
			private _class = BRPVP_classAdVehicleListReturn select _idx select 2;
			private _fake = BRPVP_classAdVehicleListReturn select _idx select 9;
			_adName = [_adName,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			_adDescr = [_adDescr,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			if (_fake isNotEqualTo []) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_fake select 0)*_i mod count _adName;
					private _p2 = (_fake select 0)*10*_i mod count _adName;
					private _count = 0;
					while {_adName select [_p1,1] isEqualTo (_adName select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adName;
						_count = _count+1;
					};
					_adName = format ["%1%2%3",_adName select [0,_p1],_adName select [_p2,1],_adName select [_p1+1,count _adName-(_p1+1)]];
				};
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_fake select 1)*_i mod count _adDescr;
					private _p2 = (_fake select 1)*10*_i mod count _adDescr;
					private _count = 0;
					while {_adDescr select [_p1,1] isEqualTo (_adDescr select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adDescr;
						_count = _count+1;
					};
					_adDescr = format ["%1%2%3",_adDescr select [0,_p1],_adDescr select [_p2,1],_adDescr select [_p1+1,count _adDescr-(_p1+1)]];
				};
			};

			private _input1 = _display ctrlCreate ["RscText",97310];
			_input1 ctrlSetPosition [0,0,1,0.065];
			_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input1 ctrlSetText _adName;
			_input1 ctrlCommit 0;
			
			private _input2 = _display ctrlCreate ["RscEditMulti",97311];
			_input2 ctrlSetPosition [0,0.1,1,0.26];
			_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input2 ctrlSetText _adDescr;
			_input2 ctrlCommit 0;

			private _input3 = _display ctrlCreate ["RscText",97312];
			_input3 ctrlSetPosition [0,0.395,1,0.065];
			_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input3 ctrlSetText ((BRPVP_classAdVehicleListReturn select _idx select 3) call BRPVP_numberSetSufix);
			_input3 ctrlCommit 0;

			private _input4 = _display ctrlCreate ["RscText",97313];
			_input4 ctrlSetPosition [0,0.495,1,0.065];
			_input4 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input4 ctrlSetText ("Free check: "+getText (configFile >> "CfgVehicles" >> _class >> "displayName"));
			_input4 ctrlCommit 0;
		};
		BRPVP_menuExecutaFuncao = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			BRPVP_menuVar1 = _this;
			177 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			175 call BRPVP_menuMuda;
		};
	},

	//MENU 177
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				private _adData = BRPVP_classAdVehicleListReturn select BRPVP_menuVar1;
				private _price = _adData select 3;
				private _mny = player getVariable ["mny",0];
				if (_mny >= _price) then {
					private _fake = _adData select 9;
					private _vehId = _adData select 1;
					private _found = false;
					player setVariable ["mny",_mny-_price,true];
					if (_fake isEqualTo []) then {
						[_vehId,player] remoteExecCall ["BRPVP_classAdVehicleSpawn",2];
						"granted" call BRPVP_playSound;
					} else {
						"fakeFail" call BRPVP_playSound;
						[format [localize "str_class_ad_false_msg",_adData select 5],8] call BRPVP_hint;
					};
					_vehId remoteExecCall ["BRPVP_removeClassAdVehicle",2];
					{
						if (_x getVariable ["id_bd",-1] isEqualTo (_adData select 4) && _x getVariable ["sok",false]) exitWith {
							 private _params = [
								player getVariable "nm",
								_adData select 7,
								_price,
								_fake isEqualTo []
							 ];
							_params remoteExecCall ["BRPVP_classAdVehicleDone",_x];
							_found = true;
						};
					} forEach call BRPVP_playersList;
					if (!_found) then {[_adData select 4,_price] remoteExecCall ["BRPVP_bankMoneyChange",2];};
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				} else {
					"erro" call BRPVP_playSound;
					[format [localize "str_mny_need_x_in_wallet",_price call BRPVP_numberSetSufix],-4] call BRPVP_hint;
				};
			} else {
				175 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {175 spawn BRPVP_menuMuda;};
	},

	//MENU 178
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0.5;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_classAdVehicleListMyReturn = nil;
		player remoteExecCall ["BRPVP_classAdVehicleListMySv",2];
		waitUntil {!isNil "BRPVP_classAdVehicleListMyReturn"};
		{
			BRPVP_menuOpcoes pushBack format ["%1 (%2)",_x select 7,(_x select 3) call BRPVP_numberSetSufix];
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_classAdVehicleListMyReturn;
		BRPVP_menuOptionCode = {
			disableSerialization;
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			private _idx = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_display = findDisplay 46;

			private _adName = BRPVP_classAdVehicleListMyReturn select _idx select 7;
			private _adDescr = BRPVP_classAdVehicleListMyReturn select _idx select 8;
			private _class = BRPVP_classAdVehicleListMyReturn select _idx select 2;
			private _fake = BRPVP_classAdVehicleListMyReturn select _idx select 9;
			_adName = [_adName,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			_adDescr = [_adDescr,"@#$2_points$#@",":"] call BRPVP_stringReplace;

			private _input1 = _display ctrlCreate ["RscText",97310];
			_input1 ctrlSetPosition [0,0,1,0.065];
			_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input1 ctrlSetText _adName;
			_input1 ctrlCommit 0;
			
			private _input2 = _display ctrlCreate ["RscEditMulti",97311];
			_input2 ctrlSetPosition [0,0.1,1,0.26];
			_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input2 ctrlSetText _adDescr;
			_input2 ctrlCommit 0;

			private _input3 = _display ctrlCreate ["RscText",97312];
			_input3 ctrlSetPosition [0,0.395,1,0.065];
			_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input3 ctrlSetText ((BRPVP_classAdVehicleListMyReturn select _idx select 3) call BRPVP_numberSetSufix);
			_input3 ctrlCommit 0;

			private _input4 = _display ctrlCreate ["RscText",97313];
			_input4 ctrlSetPosition [0,0.490,1,0.065];
			_input4 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input4 ctrlSetText ("Free check: "+getText (configFile >> "CfgVehicles" >> _class >> "displayName"));
			_input4 ctrlCommit 0;
		};
		BRPVP_menuExecutaFuncao = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			BRPVP_menuVar1 = _this;
			179 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			175 call BRPVP_menuMuda;
		};
	},

	//MENU 179
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				private _adData = BRPVP_classAdVehicleListMyReturn select BRPVP_menuVar1;
				private _vehId = _adData select 1;
				private _fake = _adData select 9;
				if (_fake isEqualTo []) then {[_vehId,player] remoteExecCall ["BRPVP_classAdVehicleSpawn",2];};
				_vehId remoteExecCall ["BRPVP_removeClassAdVehicle",2];
				"granted" call BRPVP_playSound;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				175 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {175 spawn BRPVP_menuMuda;};
	},

	//MENU 180
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				"granted" call BRPVP_playSound;
				[BRPVP_stuff,false] call BRPVP_openItemClassAdCreation;
			} else {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 181
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0.5;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_classAdItemListReturn = nil;
		player remoteExecCall ["BRPVP_classAdItemListSv",2];
		waitUntil {!isNil "BRPVP_classAdItemListReturn"};
		{
			if (_x select 2 isEqualTo "alt+i (auto)") then {
				BRPVP_classAdItemListReturn select _forEachIndex set [7,call compile (BRPVP_classAdItemListReturn select _forEachIndex select 7)];
				BRPVP_classAdItemListReturn select _forEachIndex set [8,call compile (BRPVP_classAdItemListReturn select _forEachIndex select 8)];
			};
		} forEach BRPVP_classAdItemListReturn;
		private _classAdItemListReturn = +BRPVP_classAdItemListReturn; //FIX FOR STRANGE BEHAVIOR: BUG IN ARMA 3?
		{
			private _adName = [_x select 7,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			private _priceAd =  _x select 3;
			private _priceCalc = 0;
			if (_x select 2 in ["alt+i","alt+i (auto)"]) then {
				{
					_x params ["_class","_q"];
					if (_class isEqualType "" || {_class > -1}) then {
						_class = if (_class isEqualType 1) then {BRPVP_specialItems select _class} else {_class};
						_priceCalc = _priceCalc+(_class call BRPVP_itemGetPrice)*_q;
					};
				} forEach (_x select 1);
			} else {
				_priceCalc = (_x select 1) call BRPVP_getCargoArrayValor;
				_priceCalc = (_priceCalc select 0)+(_priceCalc select 1);
			};
			private _fakeFactor = _priceAd/_priceCalc;
			private _n1 = _priceAd+33;
			if (_fakeFactor > BRPVP_classAdItemsMultForFalse) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_n1)*_i mod count _adName;
					private _p2 = (_n1)*10*_i mod count _adName;
					private _count = 0;
					while {_adName select [_p1,1] isEqualTo (_adName select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adName;
						_count = _count+1;
					};
					_adName = format ["%1%2%3",_adName select [0,_p1],_adName select [_p2,1],_adName select [_p1+1,count _adName-(_p1+1)]];
				};
			};
			private _discount = if (BRPVP_specialItemsKitPriceMult < 1) then {format [" (%1%2)",100*(1-BRPVP_specialItemsKitPriceMult),"%"]} else {""};
			BRPVP_menuOpcoes pushBack format ["%1 ($%2)@memory_remove_after@%3",_adName,(_x select 3) call BRPVP_numberSetSufix,_discount];
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_classAdItemListReturn;
		BRPVP_classAdItemListReturn = +_classAdItemListReturn; //FIX FOR STRANGE BEHAVIOR: BUG IN ARMA 3?
		BRPVP_menuOptionCode = {
			disableSerialization;
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			private _idx = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_display = findDisplay 46;

			private _priceAd = BRPVP_classAdItemListReturn select _idx select 3;
			private _priceCalc = 0;
			private _discount = if (BRPVP_specialItemsKitPriceMult < 1) then {format [" - %1%2 = %3",100*(1-BRPVP_specialItemsKitPriceMult),"%",round (_priceAd*BRPVP_specialItemsKitPriceMult) call BRPVP_numberSetSufix]} else {""};
			if (BRPVP_classAdItemListReturn select _idx select 2 in ["alt+i","alt+i (auto)"]) then {
				{
					_x params ["_class","_q"];
					if (_class isEqualType "" || {_class > -1}) then {
						_class = if (_class isEqualType 1) then {BRPVP_specialItems select _class} else {_class};
						_priceCalc = _priceCalc+(_class call BRPVP_itemGetPrice)*_q;
					};
				} forEach (BRPVP_classAdItemListReturn select _idx select 1);
			} else {
				_priceCalc = (BRPVP_classAdItemListReturn select _idx select 1) call BRPVP_getCargoArrayValor;
				_priceCalc = (_priceCalc select 0)+(_priceCalc select 1);
			};
			private _fakeFactor = _priceAd/_priceCalc;

			private _adName = BRPVP_classAdItemListReturn select _idx select 7;
			private _adDescr = BRPVP_classAdItemListReturn select _idx select 8;
			_adName = [_adName,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			_adDescr = [_adDescr,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			private _n1 = _priceAd+33;
			private _n2 = _priceCalc+77;
			if (_fakeFactor > BRPVP_classAdItemsMultForFalse) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_n1)*_i mod count _adName;
					private _p2 = (_n1)*10*_i mod count _adName;
					private _count = 0;
					while {_adName select [_p1,1] isEqualTo (_adName select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adName;
						_count = _count+1;
					};
					_adName = format ["%1%2%3",_adName select [0,_p1],_adName select [_p2,1],_adName select [_p1+1,count _adName-(_p1+1)]];
				};
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_n2)*_i mod count _adDescr;
					private _p2 = (_n2)*10*_i mod count _adDescr;
					private _count = 0;
					while {_adDescr select [_p1,1] isEqualTo (_adDescr select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adDescr;
						_count = _count+1;
					};
					_adDescr = format ["%1%2%3",_adDescr select [0,_p1],_adDescr select [_p2,1],_adDescr select [_p1+1,count _adDescr-(_p1+1)]];
				};
			};

			private _input1 = _display ctrlCreate ["RscText",97310];
			_input1 ctrlSetPosition [0,0,1,0.065];
			_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input1 ctrlSetText _adName;
			_input1 ctrlCommit 0;
			
			private _input2 = _display ctrlCreate ["RscEditMulti",97311];
			_input2 ctrlSetPosition [0,0.1,1,0.26];
			_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input2 ctrlSetText _adDescr;
			_input2 ctrlCommit 0;

			private _input3 = _display ctrlCreate ["RscText",97312];
			_input3 ctrlSetPosition [0,0.395,1,0.065];
			_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input3 ctrlSetText format ["%1%2",_priceAd call BRPVP_numberSetSufix,_discount];
			_input3 ctrlCommit 0;
		};
		BRPVP_menuExecutaFuncao = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			BRPVP_menuVar1 = _this;
			182 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			175 call BRPVP_menuMuda;
		};
	},

	//MENU 182
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				private _adData = BRPVP_classAdItemListReturn select BRPVP_menuVar1;
				private _price = _adData select 3;
				private _mny = player getVariable ["mny",0];
				private _priceDiscount = _price*BRPVP_specialItemsKitPriceMult;
				if (_mny >= _priceDiscount) then {
					private _adId = _adData select 0;
					private _found = false;
					player setVariable ["mny",_mny-_priceDiscount,true];
					[_adId,player] remoteExecCall ["BRPVP_classAdItemSpawn",2];
					"granted" call BRPVP_playSound;
					_adId remoteExecCall ["BRPVP_removeClassAdItem",2];
					{
						if (_x getVariable ["id_bd",-1] isEqualTo (_adData select 4) && _x getVariable ["sok",false]) exitWith {
							 private _params = [player getVariable "nm",_adData select 7,_price];
							_params remoteExecCall ["BRPVP_classAdItemDone",_x];
							_found = true;
						};
					} forEach call BRPVP_playersList;
					if (!_found) then {[_adData select 4,_price] remoteExecCall ["BRPVP_bankMoneyChange",2];};
					[localize "str_cad_items_on_ground",-5] call BRPVP_hint;
					private _priceAd = _adData select 3;
					private _priceCalc = 0;
					if (_adData select 2 in ["alt+i","alt+i (auto)"]) then {
						{
							_x params ["_class","_q"];
							if (_class isEqualType "" || {_class > -1}) then {
								_class = if (_class isEqualType 1) then {BRPVP_specialItems select _class} else {_class};
								_priceCalc = _priceCalc+(_class call BRPVP_itemGetPrice)*_q;
							};
						} forEach (_adData select 1);
					} else {
						_priceCalc = (_adData select 1) call BRPVP_getCargoArrayValor;
						_priceCalc = (_priceCalc select 0)+(_priceCalc select 1);
					};					
					private _fakeFactor = _priceAd/_priceCalc;
					if (_fakeFactor > BRPVP_classAdItemsMultForFalse) then {"fakeFail" call BRPVP_playSound;};
					BRPVP_specialItemsKitPriceMult = 1;
					remoteExecCall ["BRPVP_addOneAltiItemsAutoClassAd",2];
					0 spawn {
						//BUG WORKARROUND
						disableUserInput true;
						BRPVP_iniciaMenuExtraBlock = true;
						uiSleep 0.25;
						BRPVP_menuExtraLigado = false;
						hintSilent "";
						BRPVP_iniciaMenuExtraBlock = false;
						disableUserInput false;
					};
				} else {
					"erro" call BRPVP_playSound;
					[format [localize "str_mny_need_x_in_wallet",_priceDiscount call BRPVP_numberSetSufix],-4] call BRPVP_hint;
				};
			} else {
				175 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {175 spawn BRPVP_menuMuda;};
	},

	//MENU 183
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0.5;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		BRPVP_classAdItemListMyReturn = nil;
		player remoteExecCall ["BRPVP_classAdItemListMySv",2];
		waitUntil {!isNil "BRPVP_classAdItemListMyReturn"};
		{
			private _name = [_x select 7,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			BRPVP_menuOpcoes pushBack format ["%1 ($%2)",_name,(_x select 3) call BRPVP_numberSetSufix];
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_classAdItemListMyReturn;
		BRPVP_menuOptionCode = {
			disableSerialization;
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			private _idx = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_display = findDisplay 46;

			private _adName = BRPVP_classAdItemListMyReturn select _idx select 7;
			private _adDescr = BRPVP_classAdItemListMyReturn select _idx select 8;
			_adName = [_adName,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			_adDescr = [_adDescr,"@#$2_points$#@",":"] call BRPVP_stringReplace;

			private _input1 = _display ctrlCreate ["RscText",97310];
			_input1 ctrlSetPosition [0,0,1,0.065];
			_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input1 ctrlSetText _adName;
			_input1 ctrlCommit 0;
			
			private _input2 = _display ctrlCreate ["RscEditMulti",97311];
			_input2 ctrlSetPosition [0,0.1,1,0.26];
			_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input2 ctrlSetText _adDescr;
			_input2 ctrlCommit 0;

			private _input3 = _display ctrlCreate ["RscText",97312];
			_input3 ctrlSetPosition [0,0.395,1,0.065];
			_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input3 ctrlSetText ((BRPVP_classAdItemListMyReturn select _idx select 3) call BRPVP_numberSetSufix);
			_input3 ctrlCommit 0;
		};
		BRPVP_menuExecutaFuncao = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			BRPVP_menuVar1 = _this;
			184 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			175 call BRPVP_menuMuda;
		};
	},

	//MENU 184
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\class_ad.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_confirm",localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = [true,false];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				private _adData = BRPVP_classAdItemListMyReturn select BRPVP_menuVar1;
				private _adId = _adData select 0;
				[_adId,player] remoteExecCall ["BRPVP_classAdItemSpawn",2];
				"granted" call BRPVP_playSound;
				_adId remoteExecCall ["BRPVP_removeClassAdItem",2];
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				[localize "str_cad_items_on_ground",-5] call BRPVP_hint;
			} else {
				175 spawn BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {175 spawn BRPVP_menuMuda;};
	},

	//MENU 185
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\id.paa'/>";
		BRPVP_menuSleep = 0;
		call BRPVP_pegaListaPlayerscheckId;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			186 spawn BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 186
	{
		BRPVP_menuTipo = 1;
		BRPVP_menuSleep = 1;
		BRPVP_menuCorSelecao = "#AAAAAA";
		if (BRPVP_menuVar1 select 1) then {
			BRPVP_menuOpcoes = [format ["%1 - %2",BRPVP_menuVar1 select 2,systemTime call BRPVP_formatData]];
		} else {
			BRPVP_getPlayerNamesReturn = nil;
			[clientOwner,BRPVP_menuVar1 select 0] remoteExecCall ["BRPVP_getPlayerNamesSv",2];
			waitUntil {!isNil "BRPVP_getPlayerNamesReturn"};
			BRPVP_menuOpcoes = BRPVP_getPlayerNamesReturn apply {format ["%1 - %2",_x select 0,(_x select 1) call BRPVP_formatData]};
		};
		BRPVP_menuVoltar = {185 call BRPVP_menuMuda;};
	},

	//MENU 187
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\id.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [
			format ["%1 %2",300,localize "str_meters"],
			format ["%1 %2",250,localize "str_meters"],
			format ["%1 %2",200,localize "str_meters"],
			format ["%1 %2",150,localize "str_meters"],
			format ["%1 %2",100,localize "str_meters"],
			format ["%1 %2 (OFF)",0,localize "str_meters"]
		];
		BRPVP_menuExecutaParam = [300,250,200,150,100,0];
		private _actual = BRPVP_stuff getVariable ["brpvp_dome_radius",200];
		private _find = BRPVP_menuExecutaParam find _actual;
		BRPVP_menuPosForce = if (_find isEqualTo -1) then {2} else {_find};
		BRPVP_menuExecutaFuncao = {
			[BRPVP_stuff getVariable ["id_bd",-1],format ["_this setVariable ['brpvp_dome_radius',%1,true];",_this]] remoteExecCall ["BRPVP_updateTurretExec",2];
			BRPVP_stuff setVariable ["brpvp_dome_radius",_this,true];
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
		BRPVP_menuVoltar = {22 call BRPVP_menuMuda;};
	},

	//MENU 188
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\virtual_garage.paa'/>";
		BRPVP_menuSleep = if (isNil "BRPVP_myVirtualGarageOptions") then {0.25} else {0};
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		if (isNil "BRPVP_myVirtualGarageOptions") then {
			player remoteExecCall ["BRPVP_getMyVirtualGarage",2];
			waitUntil {!isNil "BRPVP_myVirtualGarageOptions"};
		};
		private _virtualGarageLimit = [];
		private _limTotal = 0;
		private _cntTotal = 0;
		private _mult = (player getVariable ["brpvp_vg_mult",1]) max (player getVariable ["brpvp_xp_vg_x",1]);
		{
			private _code = _x select 1;
			private _limit = if (_mult > 1) then {_mult*((_x select 2) max 1)} else {_x select 2};
			private _count = 0;
			{if (_x select 1 call _code) then {_count = _count+1;};} forEach BRPVP_myVirtualGarageOptions;
			_virtualGarageLimit pushBack [_x select 6,_forEachIndex,_x,_count,_limit];
			_limTotal = _limTotal+_limit;
			_cntTotal = _cntTotal+_count;
		} forEach BRPVP_virtualGarageLimit;
		_virtualGarageLimit sort false;
		_virtualGarageLimit = _virtualGarageLimit apply {[_x select 1,_x select 2,_x select 3,_x select 4]};
		BRPVP_menuOpcoes pushBack format ["%1@memory_remove_after@ (%2/%3)",localize "str_vg_all_groups",_cntTotal,_limTotal];
		BRPVP_menuExecutaParam pushBack -1;
		{
			_x params ["_idx","_line","_cnt","_lim"];
			BRPVP_menuOpcoes pushBack format ["%1@memory_remove_after@ (%2/%3)",_line select 3,_cnt,_lim];
			BRPVP_menuExecutaParam pushBack _idx;
		} forEach _virtualGarageLimit;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			189 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 189
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\virtual_garage.paa'/>";
		BRPVP_menuSleep = 0;
		private _code = if (BRPVP_menuVar1 isEqualTo -1) then {{true}} else {BRPVP_virtualGarageLimit select BRPVP_menuVar1 select 1};
		private _lega = 0;
		private _notLega = 0;
		{if (_x select 1 call _code) then {if (_x select 6) then {_notLega = _notLega+1;} else {_lega = _lega+1;};};} forEach BRPVP_myVirtualGarageOptions;
		BRPVP_menuOpcoes = [format ["%1@memory_remove_after@ (%2)",localize "str_legalized",_lega],format ["%1@memory_remove_after@ (%2)",localize "str_black_trader",_notLega]];
		BRPVP_menuExecutaParam = [false,true];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 = _this;
			85 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {188 call BRPVP_menuMuda;};
	},

	//190
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = BRPVP_specialItemsGroup arrayIntersect BRPVP_specialItemsGroup;
		BRPVP_menuExecutaParam = +BRPVP_menuOpcoes;
		if (BRPVP_menuVar2 isEqualTo -1) then {
			BRPVP_menuVar2 = [];
			BRPVP_menuVar3 = [];
		};
		BRPVP_menuOpcoes = BRPVP_menuOpcoes apply {
			private _grp = _x;
			private _cnt = 0;
			{if (BRPVP_specialItemsGroup select _x isEqualTo _grp) then {_cnt = _cnt+(BRPVP_menuVar3 select _forEachIndex);};} forEach BRPVP_menuVar2;
			format ["%1 %2 (%3)",localize "str_give",_grp,_cnt]
		};
		//RESET TO ZERO
		BRPVP_menuOpcoes pushBack localize "str_reset_to_zero";
		BRPVP_menuExecutaParam pushBack "reset";
		//FINALIZE
		BRPVP_menuOpcoes pushBack format ["%1 to %2",localize "str_alt_i_give_item","Arlex"];
		BRPVP_menuExecutaParam pushBack "selected";
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "reset") then {
				BRPVP_menuVar2 = [];
				BRPVP_menuVar3 = [];
				190 call BRPVP_menuMuda;
			} else {
				if (_this isEqualTo "selected") then {
					private _data = [BRPVP_menuVar2,BRPVP_menuVar3];
					if (_data isEqualTo [[],[]]) then {
						"erro" call BRPVP_playSound;
					} else {
						BRPVP_menuExtraLigado = false;
						hintSilent "";
						"granted" call BRPVP_playSound;
						[BRPVP_menuVar2,BRPVP_menuVar3] call BRPVP_openItemAltIClassAdCreation;
					};
				} else {
					BRPVP_menuVar1 = _this;
					191 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//191
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if (BRPVP_specialItemsGroup select _forEachIndex isEqualTo BRPVP_menuVar1) then {
				private _q = _forEachIndex call BRPVP_sitCountItem;
				if (_q > 0) then {
					private _idx = BRPVP_menuVar2 find _forEachIndex;
					private _get = if (_idx isEqualTo -1) then {0} else {BRPVP_menuVar3 select _idx};
					BRPVP_menuOpcoes pushBack format ["%1/%2 %3",_get,_q,_x];
					BRPVP_menuExecutaParam pushBack [_forEachIndex,_q];
					BRPVP_menuImagem pushBack ("<img size='4.5' align='center' image='"+BRPVP_imagePrefix+(BRPVP_specialItemsImages select _forEachIndex)+"'/>");
				};
			};
		} forEach BRPVP_specialItemsNames;
		BRPVP_menuExecutaFuncao = {
			_ii = _this select 0;
			_max = _this select 1;
			_idx = BRPVP_menuVar2 find _ii;
			if (_idx isEqualTo -1) then {
				BRPVP_menuVar2 pushBack _ii;
				BRPVP_menuVar3 pushBack 1;
			} else {
				BRPVP_menuVar3 set [_idx,((BRPVP_menuVar3 select _idx)+1) min _max];
			};
			"ciclo" call BRPVP_playSound;
			191 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {190 call BRPVP_menuMuda;};
	},

	//192
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\mark.paa'/>";
		BRPVP_menuCorSelecao = "#FF3333";
		BRPVP_menuOpcoes = [
			localize "str_off",
			format ["%1 %2",2000 call BRPVP_formatNumber,localize "str_meters"],
			format ["%1 %2",4000 call BRPVP_formatNumber,localize "str_meters"],
			format ["%1 %2",6000 call BRPVP_formatNumber,localize "str_meters"],
			format ["%1 %2",8000 call BRPVP_formatNumber,localize "str_meters"],
			format ["%1 %2",10000 call BRPVP_formatNumber,localize "str_meters"],
			localize "str_all_c4_marks"
		];
		BRPVP_menuExecutaParam = [0,2000,4000,6000,8000,10000,-1];
		BRPVP_menuExecutaFuncao = {
			BRPVP_ctrl4On3dDistance = _this;
			private _cfg = player getVariable "brpvp_player_config";
			_cfg set [2,BRPVP_ctrl4On3dDistance];
			player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
			"hint2" call BRPVP_playSound;
			192 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 193
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\newspaper.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [localize "str_cat_see_vehicles",localize "str_cat_see_items"];
		BRPVP_menuExecutaParam = [194,195];
		BRPVP_menuExecutaFuncao = {_this spawn BRPVP_menuMuda;};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 194
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\newspaper.paa'/>";
		BRPVP_menuSleep = 0.25;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		if (isNil "BRPVP_classAdVehicleListReturn") then {
			player remoteExecCall ["BRPVP_classAdVehicleListSv",2];
			waitUntil {!isNil "BRPVP_classAdVehicleListReturn"};
		};
		{
			private _name = [_x select 7,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			private _fake = _x select 9;
			if (_fake isNotEqualTo []) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_fake select 0)*_i mod count _name;
					private _p2 = (_fake select 0)*10*_i mod count _name;
					private _count = 0;
					while {_name select [_p1,1] isEqualTo (_name select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _name;
						_count = _count+1;
					};
					_name = format ["%1%2%3",_name select [0,_p1],_name select [_p2,1],_name select [_p1+1,count _name-(_p1+1)]];
				};
			};
			BRPVP_menuOpcoes pushBack format ["%1 ($%2)",_name,(_x select 3) call BRPVP_numberSetSufix];
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_classAdVehicleListReturn;
		BRPVP_menuOptionCode = {
			disableSerialization;
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			private _idx = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_display = findDisplay 46;

			private _adName = BRPVP_classAdVehicleListReturn select _idx select 7;
			private _adDescr = BRPVP_classAdVehicleListReturn select _idx select 8;
			private _class = BRPVP_classAdVehicleListReturn select _idx select 2;
			private _fake = BRPVP_classAdVehicleListReturn select _idx select 9;
			_adName = [_adName,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			_adDescr = [_adDescr,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			if (_fake isNotEqualTo []) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_fake select 0)*_i mod count _adName;
					private _p2 = (_fake select 0)*10*_i mod count _adName;
					private _count = 0;
					while {_adName select [_p1,1] isEqualTo (_adName select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adName;
						_count = _count+1;
					};
					_adName = format ["%1%2%3",_adName select [0,_p1],_adName select [_p2,1],_adName select [_p1+1,count _adName-(_p1+1)]];
				};
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_fake select 1)*_i mod count _adDescr;
					private _p2 = (_fake select 1)*10*_i mod count _adDescr;
					private _count = 0;
					while {_adDescr select [_p1,1] isEqualTo (_adDescr select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adDescr;
						_count = _count+1;
					};
					_adDescr = format ["%1%2%3",_adDescr select [0,_p1],_adDescr select [_p2,1],_adDescr select [_p1+1,count _adDescr-(_p1+1)]];
				};
			};

			private _input1 = _display ctrlCreate ["RscText",97310];
			_input1 ctrlSetPosition [0,0,1,0.065];
			_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input1 ctrlSetText _adName;
			_input1 ctrlCommit 0;
			
			private _input2 = _display ctrlCreate ["RscEditMulti",97311];
			_input2 ctrlSetPosition [0,0.1,1,0.26];
			_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input2 ctrlSetText _adDescr;
			_input2 ctrlCommit 0;

			private _input3 = _display ctrlCreate ["RscText",97312];
			_input3 ctrlSetPosition [0,0.395,1,0.065];
			_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input3 ctrlSetText ((BRPVP_classAdVehicleListReturn select _idx select 3) call BRPVP_numberSetSufix);
			_input3 ctrlCommit 0;

			private _input4 = _display ctrlCreate ["RscText",97313];
			_input4 ctrlSetPosition [0,0.495,1,0.065];
			_input4 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input4 ctrlSetText ("Free check: "+getText (configFile >> "CfgVehicles" >> _class >> "displayName"));
			_input4 ctrlCommit 0;
		};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			[localize "str_need_go_classad"] call BRPVP_hint;
		};
		BRPVP_menuVoltar = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
				ctrlDelete (findDisplay 46 displayCtrl 97313);
			};
			193 call BRPVP_menuMuda;
		};
	},

	//MENU 195
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\newspaper.paa'/>";
		BRPVP_menuSleep = 0.25;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		if (isNil "BRPVP_classAdItemListReturn") then {
			player remoteExecCall ["BRPVP_classAdItemListSv",2];
			waitUntil {!isNil "BRPVP_classAdItemListReturn"};
		};
		{
			if (_x select 2 isEqualTo "alt+i (auto)") then {
				BRPVP_classAdItemListReturn select _forEachIndex set [7,call compile (BRPVP_classAdItemListReturn select _forEachIndex select 7)];
				BRPVP_classAdItemListReturn select _forEachIndex set [8,call compile (BRPVP_classAdItemListReturn select _forEachIndex select 8)];
			};
		} forEach BRPVP_classAdItemListReturn;
		private _classAdItemListReturn = +BRPVP_classAdItemListReturn; //FIX FOR STRANGE BEHAVIOR: BUG IN ARMA 3?
		{
			private _adName = [_x select 7,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			private _priceAd =  _x select 3;
			private _priceCalc = 0;
			if (_x select 2 in ["alt+i","alt+i (auto)"]) then {
				{
					_x params ["_class","_q"];
					if (_class isEqualType "" || {_class > -1}) then {
						_class = if (_class isEqualType 1) then {BRPVP_specialItems select _class} else {_class};
						_priceCalc = _priceCalc+(_class call BRPVP_itemGetPrice)*_q;
					};
				} forEach (_x select 1);
			} else {
				_priceCalc = (_x select 1) call BRPVP_getCargoArrayValor;
				_priceCalc = (_priceCalc select 0)+(_priceCalc select 1);
			};
			private _fakeFactor = _priceAd/_priceCalc;
			private _n1 = _priceAd+33;
			if (_fakeFactor > BRPVP_classAdItemsMultForFalse) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_n1)*_i mod count _adName;
					private _p2 = (_n1)*10*_i mod count _adName;
					private _count = 0;
					while {_adName select [_p1,1] isEqualTo (_adName select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adName;
						_count = _count+1;
					};
					_adName = format ["%1%2%3",_adName select [0,_p1],_adName select [_p2,1],_adName select [_p1+1,count _adName-(_p1+1)]];
				};
			};
			private _discount = if (BRPVP_specialItemsKitPriceMult < 1) then {format [" (%1%2)",100*(1-BRPVP_specialItemsKitPriceMult),"%"]} else {""};
			BRPVP_menuOpcoes pushBack format ["%1 ($%2)@memory_remove_after@%3",_adName,(_x select 3) call BRPVP_numberSetSufix,_discount];
			BRPVP_menuExecutaParam pushBack _forEachIndex;
		} forEach BRPVP_classAdItemListReturn;
		BRPVP_classAdItemListReturn = +_classAdItemListReturn; //FIX FOR STRANGE BEHAVIOR: BUG IN ARMA 3?
		BRPVP_menuOptionCode = {
			disableSerialization;
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			private _idx = BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel;
			_display = findDisplay 46;

			private _priceAd = BRPVP_classAdItemListReturn select _idx select 3;
			private _priceCalc = 0;
			private _discount = if (BRPVP_specialItemsKitPriceMult < 1) then {format [" - %1%2 = %3",100*(1-BRPVP_specialItemsKitPriceMult),"%",round (_priceAd*BRPVP_specialItemsKitPriceMult) call BRPVP_numberSetSufix]} else {""};
			if (BRPVP_classAdItemListReturn select _idx select 2 in ["alt+i","alt+i (auto)"]) then {
				{
					_x params ["_class","_q"];
					if (_class isEqualType "" || {_class > -1}) then {
						_class = if (_class isEqualType 1) then {BRPVP_specialItems select _class} else {_class};
						_priceCalc = _priceCalc+(_class call BRPVP_itemGetPrice)*_q;
					};
				} forEach (BRPVP_classAdItemListReturn select _idx select 1);
			} else {
				_priceCalc = (BRPVP_classAdItemListReturn select _idx select 1) call BRPVP_getCargoArrayValor;
				_priceCalc = (_priceCalc select 0)+(_priceCalc select 1);
			};
			private _fakeFactor = _priceAd/_priceCalc;

			private _adName = BRPVP_classAdItemListReturn select _idx select 7;
			private _adDescr = BRPVP_classAdItemListReturn select _idx select 8;
			_adName = [_adName,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			_adDescr = [_adDescr,"@#$2_points$#@",":"] call BRPVP_stringReplace;
			private _n1 = _priceAd+33;
			private _n2 = _priceCalc+77;
			if (_fakeFactor > BRPVP_classAdItemsMultForFalse) then {
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_n1)*_i mod count _adName;
					private _p2 = (_n1)*10*_i mod count _adName;
					private _count = 0;
					while {_adName select [_p1,1] isEqualTo (_adName select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adName;
						_count = _count+1;
					};
					_adName = format ["%1%2%3",_adName select [0,_p1],_adName select [_p2,1],_adName select [_p1+1,count _adName-(_p1+1)]];
				};
				for "_i" from 1 to BRPVP_classAdErrorsInFalseAd do {
					private _p1 = (_n2)*_i mod count _adDescr;
					private _p2 = (_n2)*10*_i mod count _adDescr;
					private _count = 0;
					while {_adDescr select [_p1,1] isEqualTo (_adDescr select [_p2,1]) && _count < 10} do {
						_p2 = (_p2+1) mod count _adDescr;
						_count = _count+1;
					};
					_adDescr = format ["%1%2%3",_adDescr select [0,_p1],_adDescr select [_p2,1],_adDescr select [_p1+1,count _adDescr-(_p1+1)]];
				};
			};

			private _input1 = _display ctrlCreate ["RscText",97310];
			_input1 ctrlSetPosition [0,0,1,0.065];
			_input1 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input1 ctrlSetText _adName;
			_input1 ctrlCommit 0;
			
			private _input2 = _display ctrlCreate ["RscEditMulti",97311];
			_input2 ctrlSetPosition [0,0.1,1,0.26];
			_input2 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input2 ctrlSetText _adDescr;
			_input2 ctrlCommit 0;

			private _input3 = _display ctrlCreate ["RscText",97312];
			_input3 ctrlSetPosition [0,0.395,1,0.065];
			_input3 ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input3 ctrlSetText format ["%1%2",_priceAd call BRPVP_numberSetSufix,_discount];
			_input3 ctrlCommit 0;
		};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			[localize "str_need_go_classad"] call BRPVP_hint;
		};
		BRPVP_menuVoltar = {
			if (!isNull (findDisplay 46 displayCtrl 97310)) then {
				ctrlDelete (findDisplay 46 displayCtrl 97310);
				ctrlDelete (findDisplay 46 displayCtrl 97311);
				ctrlDelete (findDisplay 46 displayCtrl 97312);
			};
			193 call BRPVP_menuMuda;
		};
	},

	//MENU 196
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\big_floor.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [
			format ["+10.0 %1",localize "str_meters"],
			format ["+05.0 %1",localize "str_meters"],
			format ["+01.0 %1",localize "str_meters"],
			format ["+00.2 %1",localize "str_meters"],
			format ["-00.2 %1",localize "str_meters"],
			format ["-01.0 %1",localize "str_meters"],
			format ["-05.0 %1",localize "str_meters"],
			format ["-10.0 %1",localize "str_meters"],
			localize "str_menu12_opt2",
			localize "str_atm_conclude"
		];
		BRPVP_menuExecutaParam = [10,5,1,0.2,-0.2,-1,-5,-10,"cancel","conclude"];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualType 0) then {
				{_x setPosWorld (getPosWorld _x vectorAdd [0,0,_this]);} forEach BRPVP_menuVar2;
				"ciclo" call BRPVP_playSound;
			} else {
				if (_this isEqualTo "cancel") then {
					{deleteVehicle _x;} forEach BRPVP_menuVar2;
					["BRPVP_bigFloor200",1] call BRPVP_sitAddItem;
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				} else {
					if (_this isEqualTo "conclude") then {
						BRPVP_menuVar1 set [2,getPosWorld (BRPVP_menuVar2 select 0) select 2];
						BRPVP_bigFloorCreationOk = false;
						[player,200,player getVariable "id_bd",BRPVP_menuVar1,BRPVP_bigFloorHoles,""] remoteExecCall ["BRPVP_bigFloorCreateAndSaveServer",2];
						BRPVP_menuExtraLigado = false;
						hintSilent "";
						+BRPVP_menuVar2 spawn {
							waitUntil {BRPVP_bigFloorCreationOk};
							uiSleep 0.5;
							{deleteVehicle _x;} forEach _this;
						};
						"granted" call BRPVP_playSound;
					};
				};
			};
		};
		BRPVP_menuVoltar = {
			{deleteVehicle _x;} forEach BRPVP_menuVar2;
			["BRPVP_bigFloor200",1] call BRPVP_sitAddItem;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 197
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\menu\map_icons.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [
			format [localize "str_smi_missions",if (BRPVP_mapShowMissions) then {"X"} else {"   "}],
			format [localize "str_smi_units",if (BRPVP_mapShowUnits) then {"X"} else {"   "}],
			format [localize "str_smi_vehicles",if (BRPVP_mapShowVehicles) then {"X"} else {"   "}],
			format [localize "str_smi_player_stuff",if (BRPVP_mapShowPlayerStuff) then {"X"} else {"   "}],
			format [localize "str_smi_ctrl4_marks",if (BRPVP_mapShowCtrl4Marks) then {"X"} else {"   "}],
			format [localize "str_smi_magus",if (BRPVP_mapShowMagus) then {"X"} else {"   "}],
			format [localize "str_smi_franta_mines",if (BRPVP_mapShowFrantaMines) then {"X"} else {"   "}],
			format [localize "str_smi_traders",if (BRPVP_mapShowTraders) then {"X"} else {"   "}],
			format [localize "str_smi_other_stuff",if (BRPVP_mapShowOtherStuff) then {"X"} else {"   "}]
		];
		BRPVP_menuExecutaParam = [1,4,5,2,8,7,9,6,3];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 1) then {
				BRPVP_mapShowMissions = !BRPVP_mapShowMissions;
			} else {
				if (_this isEqualTo 2) then {
					BRPVP_mapShowPlayerStuff = !BRPVP_mapShowPlayerStuff;
				} else {
					if (_this isEqualTo 3) then {
						BRPVP_mapShowOtherStuff = !BRPVP_mapShowOtherStuff;
					} else {
						if (_this isEqualTo 4) then {
							BRPVP_mapShowUnits = !BRPVP_mapShowUnits;
						} else {
							if (_this isEqualTo 5) then {
								BRPVP_mapShowVehicles = !BRPVP_mapShowVehicles;
							} else {
								if (_this isEqualTo 6) then {
									BRPVP_mapShowTraders = !BRPVP_mapShowTraders;
								} else {
									if (_this isEqualTo 7) then {
										BRPVP_mapShowMagus = !BRPVP_mapShowMagus;
									} else {
										if (_this isEqualTo 8) then {
											BRPVP_mapShowCtrl4Marks = !BRPVP_mapShowCtrl4Marks;
										} else {
											if (_this isEqualTo 9) then {
												BRPVP_mapShowFrantaMines = !BRPVP_mapShowFrantaMines;
											};
										};
									};
								};
							};
						};
					};
				};
			};
			if (visibleMap || visibleGPS) then {BRPVP_fazRadarBip = true;};
			197 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 198
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\path.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [
			format [localize "str_path_on_off",["   ","X"] select BRPVP_ppathIsOn],
			format [localize "str_path_ticks",BRPVP_ppathSize],
			format [localize "str_path_show_map",["   ","X"] select BRPVP_ppathShowMap],
			format [localize "str_path_show_3d",["   ","X"] select BRPVP_ppathShow3D]
		];
		BRPVP_menuExecutaParam = [1,2,3,4];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 1) then {
				BRPVP_ppathIsOn = !BRPVP_ppathIsOn;
				call BRPVP_ppathReset;
				if (BRPVP_ppathIsOn) then {
					//ADD FIRST POINT
					private _np = ASLToAGL getPosASL player;
					private _h = (_np select 2) max 0 min BRPVP_ppathMaxHigh;
					BRPVP_ppathPath pushBack [_np vectorAdd [0,0,0.5],[(1000-_h)/1000,0,_h/1000,1]];
					BRPVP_ppathBoo = true;
				};
			} else {
				if (_this isEqualTo 2) then {
					private _ta = [500,1000,1500,2000,2500,3000,3500,4000,4500,5000];
					private _idx = _ta find BRPVP_ppathSize;
					if (_idx isEqualTo -1) then {
						BRPVP_ppathSize = 500;
					} else {
						if (BRPVP_ppathSize isEqualTo 5000) then {BRPVP_ppathSize = 500;} else {BRPVP_ppathSize = BRPVP_ppathSize+500;};
					};
					private _cMsg = count BRPVP_ppathPath;
					private _y = if (BRPVP_menuExtraLigado) then {0.4} else {0};
					"achou_loot" call BRPVP_playSound;
					["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\path.paa'/><br/>"+str (round (100*_cMsg/BRPVP_ppathSize) min 100)+"%",0,_y,1.5,0,0,467] call BRPVP_fnc_dynamicText;
				} else {
					if (_this isEqualTo 3) then {
						BRPVP_ppathShowMap = !BRPVP_ppathShowMap;
					} else {
						if (_this isEqualTo 4) then {BRPVP_ppathShow3D = !BRPVP_ppathShow3D;};
					};
				};
			};
			198 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 199
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\body_change.paa'/>";
		BRPVP_menuSleep = 0;
		call BRPVP_pegaListaPlayersBodyChange;
		BRPVP_menuOpcoes pushBack localize "str_bodyc_update_list";
		BRPVP_menuExecutaParam pushBack "update";
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "update") then {
				199 call BRPVP_menuMuda;
				"achou_loot" call BRPVP_playSound;
			} else {
				private _playerOk = player call BRPVP_pAlive && player getVariable ["sok",false] && !isNull player && isNull objectParent player && getPos player select 2 < 0.25;
				private _thisOk = _this call BRPVP_pAlive && _this getVariable ["sok",false] && !isNull _this && isNull objectParent _this && getPos _this select 2 < 0.25;
				private _accessOk =  _this call BRPVP_checaAcesso;
				if (_playerOk && _thisOk && _accessOk) then {
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					_this setVariable ["brpvp_bodyc_answer","waiting"];
					[clientOwner,player,player getVariable "nm"] remoteExecCall ["BRPVP_askForBodyExchange",_this];
					_this spawn {
						private _pi = ASLToAGL getPosASL player;
						private _init = diag_tickTime-1;
						private _cnt = 8;
						private _othersOk = false;
						private _decided = false;
						waitUntil {
							if (diag_tickTime-_init >= 1) then {
								_init = diag_tickTime;
								["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\body_change.paa'/><br/><t>"+str _cnt+" "+(localize "str_bodyc_wait_answer")+"</t>",0,0.25,3,0,0,2985775] call BRPVP_fnc_dynamicText;
								_cnt = _cnt-1;
							};
							private _askerOk = !isNull player && player call BRPVP_pAlive && player getVariable ["sok",false] && isNull objectParent player;
							private _inviOk = !isNull _this && _this call BRPVP_pAlive && _this getVariable ["sok",false] && isNull objectParent _this;
							private _moveOk = player distance _pi <= 2.5;
							private _timeOk = _cnt > -1;
							_othersOk = _askerOk && _inviOk && _moveOk && _timeOk;
							_decided = (_this getVariable "brpvp_bodyc_answer") isNotEqualTo "waiting";
							_decided || !_othersOk
						};
						["",0,0,0,0,0,2985775] call BRPVP_fnc_dynamicText;
						if (_decided) then {
							if ((_this getVariable "brpvp_bodyc_answer") isEqualTo "ok") then {
								[player] remoteExec ["BRPVP_changeSoulCodeInviter",_this];
								[_this,getUnitLoadOut player,getUnitLoadOut _this] call BRPVP_changeSoulCodeAsker;
							} else {
								"erro" call BRPVP_playSound;
								["BRPVP_bodyChange",1] call BRPVP_sitAddItem;
								BRPVP_bodyChangeTrying = false;
							};
						} else {
							"erro" call BRPVP_playSound;
							["BRPVP_bodyChange",1] call BRPVP_sitAddItem;
							BRPVP_bodyChangeTrying = false;
						};
					};
				} else {
					"erro" call BRPVP_playSound;
					199 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			["BRPVP_bodyChange",1] call BRPVP_sitAddItem;
			BRPVP_bodyChangeTrying = false;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 200
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		if (BRPVP_adminsStartsWithAllPerks) then {call BRPVP_pegaListaPlayersAll;} else {call BRPVP_pegaListaPlayersAllPlayer;};
		BRPVP_menuOpcoes pushBack localize "str_menu12_opt2";
		BRPVP_menuExecutaParam pushBack "cancel";
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				29 call BRPVP_menuMuda;
			} else {
				if (_this getVariable ["sok",false]) then {
					BRPVP_menuVar1 = _this;
					201 call BRPVP_menuMuda;
				} else {
					"erro" call BRPVP_playSound;
					200 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 201
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\xp_icon.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [
			"+50K XP",
			"+100K XP",
			"+500K XP",
			"+1000K XP",
			"-1000K XP",
			"-500K XP",
			"-100K XP",
			"-50K XP"
		];
		BRPVP_menuExecutaParam = [50000,100000,500000,1000000,-1000000,-500000,-100000,-50000];
		BRPVP_menuExecutaFuncao = {
			if (BRPVP_menuVar1 getVariable ["sok",false]) then {
				"granted" call BRPVP_playSound;
				[["admin",_this]] remoteExecCall ["BRPVP_mudaExp",BRPVP_menuVar1];
				201 call BRPVP_menuMuda;
			} else {
				"erro" call BRPVP_playSound;
				200 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {200 call BRPVP_menuMuda;};
	},

	//MENU 202
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\uber_attack_item.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [
			localize "str_uattack_position",
			localize "str_uattack_normal",
			localize "str_uattack_suicide"
		];
		BRPVP_menuExecutaParam = ["position","normal","suicide"];
		BRPVP_menuExecutaFuncao = {
			player call BRPVP_uberAttackAddPlayer;
			if (_this isEqualTo "position") then {
					player setVariable ["brpvp_ua_iss",false];
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					[0,"str_uattack_instructions_pos"] spawn BRPVP_uberAttackPlayerSelectTarget;
			} else {
				if (_this isEqualTo "normal") then {
					player setVariable ["brpvp_ua_iss",false];
					203 call BRPVP_menuMuda;
				} else {
					player setVariable ["brpvp_ua_iss",true];
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					[0,"str_uattack_instructions"] spawn BRPVP_uberAttackPlayerSelectTarget;
				};
			};
		};
		BRPVP_menuVoltar = {
			private _tank = player getVariable ["brpvp_uber_attack_tank",objNull];
			if (!isNull _tank) then {detach _tank;deleteVehicle _tank;};
			["BRPVP_uberAttack",1] call BRPVP_sitAddItem;
			BRPVP_uberAttackUsing = false;

			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 203
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\uber_attack_item.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [
			format ["%1 %2",050,localize "str_meters"],
			format ["%1 %2",100,localize "str_meters"],
			format ["%1 %2",150,localize "str_meters"],
			format ["%1 %2",200,localize "str_meters"],
			format ["%1 %2",300,localize "str_meters"]
		];
		BRPVP_menuExecutaParam = [50,100,150,200,300];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			[_this,"str_uattack_instructions"] spawn BRPVP_uberAttackPlayerSelectTarget;
		};
		BRPVP_menuVoltar = {202 call BRPVP_menuMuda;};
	},

	//MENU 204
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\sec_cam.paa'/>";
		BRPVP_menuSleep = 0;
		private _pId = player getVariable "id_bd";
		private _menuOpcoesMy = [];
		private _menuOpcoesOthers = [];
		private _menuExecutaParamMy = [];
		private _menuExecutaParamOthers = [];
		{
			private _cam = _x;
			private _camId = _cam getVariable ["brpvp_cam_id",-1];
			private _camOwn = _cam getVariable ["brpvp_cam_own",-1];
			private _camAmg = _cam getVariable ["brpvp_cam_amg",[]];
			private _coords = (getPosWorld _cam select [0,2]) apply {round (_x/100)};
			if (_camOwn isEqualTo _pID || _pId in _camAmg || BRPVP_vePlayers) then {
				if (_camOwn isEqualTo _pID) then {
					_menuOpcoesMy pushBack format ["@green@"+localize "str_csec_cam_name"+"@tclose@ - %2 / %3",_camId,_coords,(_cam distance BRPVP_menuVar1) call BRPVP_numberToDistanceTxt];
					_menuExecutaParamMy pushBack _cam;
				} else {
					_menuOpcoesOthers pushBack format ["@yellow@"+localize "str_csec_cam_name"+"@tclose@ - %2 / %3",_camId,_coords,(_cam distance BRPVP_menuVar1) call BRPVP_numberToDistanceTxt];
					_menuExecutaParamOthers pushBack _cam;
				};
			};
		} forEach (BRPVP_secCamAll-[objNull]);
		BRPVP_menuOpcoes = ["None"]+_menuOpcoesMy+_menuOpcoesOthers;
		BRPVP_menuExecutaParam = [objNull]+_menuExecutaParamMy+_menuExecutaParamOthers;
		BRPVP_menuExecutaFuncao = {
			if (isNull _this) then {
				private _camReal = BRPVP_menuVar1 getVariable ["brpvp_bb_camera",objNull];
				if (!isNull _camReal) then {
					private _camKey = "seccam"+str (BRPVP_menuVar1 getVariable "id_bd");
					private _camFake = BRPVP_menuVar1 getVariable ["brpvp_bb_camera_fake",objNull];
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[BRPVP_menuVar1,_camKey] remoteExecCall ["BRPVP_smartTvToNullSpec",BRPVP_specOnMeMachinesNoMe];};
					_camReal cameraEffect ["Terminate","Back",_camKey];
					BRPVP_secCamBbsMy = BRPVP_secCamBbsMy-[[BRPVP_menuVar1,_camReal,_camKey]];
					BRPVP_secCamBbsMyPlayerSave = BRPVP_secCamBbsMyPlayerSave-[[BRPVP_menuVar1 getVariable ["id_bd",-1],_camFake getVariable ["brpvp_cam_id",-1]]];
					player setVariable ["brpvp_seccam_connections",BRPVP_secCamBbsMyPlayerSave,2];
					camDestroy _camReal;
				};
				BRPVP_menuVar1 setVariable ["brpvp_bb_camera_fake",objNull];
			} else {
				if (isPipEnabled) then {
					private _camKey = "seccam"+str (BRPVP_menuVar1 getVariable "id_bd");
					private _texture = format ["#(argb,512,512,1)r2t(%1,1)",_camKey];
					private _camFakeOld = BRPVP_menuVar1 getVariable ["brpvp_bb_camera_fake",objNull];
					private _camReal = BRPVP_menuVar1 getVariable ["brpvp_bb_camera",objNull];
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_camKey,_this,BRPVP_menuVar1] remoteExecCall ["BRPVP_smartTvSetNewCameraSyncSpec",BRPVP_specOnMeMachinesNoMe];};
					if (getObjectTextures BRPVP_menuVar1 select 0 isNotEqualTo _texture) then {BRPVP_menuVar1 setObjectTexture [0,_texture];};
					if (isNull _camReal) then {
						_camReal = "camera" camCreate (ASLToAGL getPosASL _this vectorAdd (vectorDir _this vectorMultiply -0.2));
						_camReal cameraEffect ["Internal","Back",_camKey];
						_camKey setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
						BRPVP_menuVar1 setVariable ["brpvp_bb_camera",_camReal];
						BRPVP_secCamBbsMy pushBack [BRPVP_menuVar1,_camReal,_camKey];
						BRPVP_secCamBbsMyPlayerSave pushBack [BRPVP_menuVar1 getVariable ["id_bd",-1],_this getVariable ["brpvp_cam_id",-1]];
						player setVariable ["brpvp_seccam_connections",BRPVP_secCamBbsMyPlayerSave,2];
					} else {
						_camReal setPosASL (getPosASL _this vectorAdd (vectorDir _this vectorMultiply -0.2));
						BRPVP_secCamBbsMyPlayerSave = BRPVP_secCamBbsMyPlayerSave-[[BRPVP_menuVar1 getVariable ["id_bd",-1],_camFakeOld getVariable ["brpvp_cam_id",-1]]];
						BRPVP_secCamBbsMyPlayerSave pushBack [BRPVP_menuVar1 getVariable ["id_bd",-1],_this getVariable ["brpvp_cam_id",-1]];
						player setVariable ["brpvp_seccam_connections",BRPVP_secCamBbsMyPlayerSave,2];
					};
					_camReal setVectorDirAndUp [vectorDir _this vectorMultiply -1,vectorUp _this];
					BRPVP_menuVar1 setVariable ["brpvp_bb_camera_fake",_this];
				} else {
					"erro" call BRPVP_playSound;			
					[localize "str_pip_not_enabled",-6] call BRPVP_hint;
					BRPVP_menuVar1 setVariable ["brpvp_bb_camera_fake",objNull];
				};
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 205
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='4.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\sec_cam_destroy.paa'/>";
		BRPVP_menuSleep = 0;
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		private _pId = player getVariable "id_bd";
		private _menuOpcoesMy = [];
		private _menuOpcoesOthers = [];
		private _menuExecutaParamMy = [];
		private _menuExecutaParamOthers = [];
		{
			private _cam = _x;
			private _camId = _cam getVariable ["brpvp_cam_id",-1];
			private _camOwn = _cam getVariable ["brpvp_cam_own",-1];
			private _camAmg = _cam getVariable ["brpvp_cam_amg",[]];
			private _coords = (getPosWorld _cam select [0,2]) apply {round (_x/100)};
			if (_camOwn isEqualTo _pID || BRPVP_vePlayers) then {
				if (_camOwn isEqualTo _pID) then {
					_menuOpcoesMy pushBack format ["@green@"+localize "str_csec_cam_name"+"@tclose@ - %2 / %3",_camId,_coords,(_cam distance BRPVP_menuVar1) call BRPVP_numberToDistanceTxt];
					_menuExecutaParamMy pushBack _cam;
				} else {
					_menuOpcoesOthers pushBack format ["@yellow@"+localize "str_csec_cam_name"+"@tclose@ - %2 / %3",_camId,_coords,(_cam distance BRPVP_menuVar1) call BRPVP_numberToDistanceTxt];
					_menuExecutaParamOthers pushBack _cam;
				};
			};
		} forEach (BRPVP_secCamAll-[objNull]);
		BRPVP_menuOpcoes = _menuOpcoesMy+_menuOpcoesOthers;
		BRPVP_menuExecutaParam = _menuExecutaParamMy+_menuExecutaParamOthers;
		BRPVP_menuExecutaFuncao = {
			if (isNull _this) then {
				"erro" call BRPVP_playSound;
			} else {
				[_this] remoteExecCall ["BRPVP_secCamRemoveArray",0];
				private _bomb = "APERSTripMine_Wire_Ammo" createVehicle ASLToAGL getPosASL _this;
				_bomb setdamage 1;
				(_this getVariable ["brpvp_cam_id",-1]) remoteExecCall ["BRPVP_secCamRemoveDb",2];
				[0.5,[_this]] remoteExec ["BRPVP_disconnectDeathSignalCamera",call BRPVP_playersList];
				[_this,true] remoteExecCall ["hideObjectGlobal",2]; 
				_this spawn {uiSleep 0.5;deleteVehicle _this;};				
				[localize "str_seccam_destroyed",-3] call BRPVP_hint;
				205 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 206
	{
		BRPVP_menuTipo = 2;
		call BRPVP_pegaListaPlayersOriginalAlive;
		BRPVP_menuOpcoes = [localize "str_none"]+BRPVP_menuOpcoes;
		BRPVP_menuExecutaParam = [objNull]+BRPVP_menuExecutaParam;
		BRPVP_menuExecutaFuncao = BRPVP_attachMeToAPlayer;
	},

	//MENU 207
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuSleep = 0;
		BRPVP_menuForceExit = BRPVP_menuVar9;
		BRPVP_menuOpcoes = [
			localize "str_mmi_uniform",
			localize "str_mmi_vest",
			localize "str_mmi_backpack",
			localize "str_mmi_box_vehicle",
			localize "str_mmi_ground"
		];
		BRPVP_menuExecutaParam = [
			[uniformContainer player,localize "str_mmi_tt_uniform"],
			[vestContainer player,localize "str_mmi_tt_vest"],
			[backpackContainer player,localize "str_mmi_tt_backpack"],
			[BRPVP_menuVar1,localize "str_mmi_tt_box_vehicle"],
			[BRPVP_menuVar2,localize "str_mmi_tt_ground"]
		];
		BRPVP_menuExecutaFuncao = {
			params ["_obj","_tittle"];
			if (isNull _obj) then {
				"erro" call BRPVP_playSound;
				207 call BRPVP_menuMuda;
			} else {
				BRPVP_menuVar3 = _obj;
				BRPVP_menuVar10 = _tittle;
				208 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {
			private _u1 = BRPVP_menuVar1 getVariable ["brpvp_mm_using",objNull];
			private _u2 = BRPVP_menuVar2 getVariable ["brpvp_mm_using",objNull];
			if (_u1 isEqualTo player) then {BRPVP_menuVar1 setVariable ["brpvp_mm_using",objNull,true];};
			if (_u2 isEqualTo player) then {BRPVP_menuVar2 setVariable ["brpvp_mm_using",objNull,true];};
			BRPVP_menuVar1 = objNull;
			BRPVP_menuVar2 = objNull;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 208
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = ["<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\menu_cancel.paa'/>"];
		BRPVP_menuSleep = 0;
		BRPVP_menuIdcSafe = 207;
		BRPVP_menuForceExit = BRPVP_menuVar9;
		BRPVP_menuOpcoes = [localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = ["cancel"];
		if (!isNull BRPVP_menuVar3 && (BRPVP_menuVar3 distance player <= 7.5 || BRPVP_menuVar3 isEqualTo backpackContainer player)) then {
			private _cargo = BRPVP_menuVar3 call BRPVP_getCargoArrayNoDb;
			private _data = _cargo select 1;
			{
				if (_forEachIndex isEqualTo 0) then {
					_x params ["_e1","_cArray"];
					_e1 params ["_cClass","_cObj"];
					_cArray params ["_weps","_mags","_items","_backPacks"];
					{
						_x params ["_wepArray","_qtt"];
						private _wName = getText (configFile >> "CfgWeapons" >> _wepArray select 0 >> "displayName") call BRPVP_escapeForStructuredTextFast;
						private _wOptics = if (_wepArray select 3 isEqualTo "") then {""} else {format[" [%1]",getText (configFile >> "CfgWeapons" >> _wepArray select 3 >> "displayName") call BRPVP_escapeForStructuredTextFast]};
						private _wAmmo1 = if (_wepArray select 4 isEqualTo []) then {0} else {_wepArray select 4 select 1};
						private _wAmmo2 = if (_wepArray select 5 isEqualTo []) then {0} else {_wepArray select 5 select 1};
						BRPVP_menuOpcoes pushBack format ["%1%2 X%4",_wName,_wOptics,_wAmmo1+_wAmmo2,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar3,0,_qtt,[_x]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",getText (configFile >> "CfgWeapons" >> _wepArray select 0 >> "picture")];
					} forEach _weps;
					{
						_x params ["_class","_qtt","_ammo"];
						private _mName = getText (configFile >> "CfgMagazines" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast;
						BRPVP_menuOpcoes pushBack format ["%1 X%3",_mName,_ammo,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar3,1,_qtt,[_x]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",getText (configFile >> "CfgMagazines" >> _class >> "picture")];
					} forEach _mags;
					{
						private _class = _x;
						(_class call BRPVP_getItemDisplayNameAndImage) params ["_iName","_image"];
						private _qtt = _items select 1 select _forEachIndex;
						BRPVP_menuOpcoes pushBack format ["%1 X%2",_iName,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar3,2,_qtt,[[_x],[_qtt]]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",_image];
					} forEach (_items select 0);
					{
						private _class = _x;
						(_class call BRPVP_getItemDisplayNameAndImage) params ["_iName","_image"];
						private _qtt = _backPacks select 1 select _forEachIndex;
						BRPVP_menuOpcoes pushBack format ["%1 X%2",_iName,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar3,3,_qtt,[[_x],[_qtt]]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",_image];
					} forEach (_backPacks select 0);
				} else {
					_x params ["_e1","_cArray"];
					_e1 params ["_cClass","_cObj"];
					(_cClass call BRPVP_getItemDisplayNameAndImage) params ["_cName","_image"];
					BRPVP_menuOpcoes pushBack format ["[CARGO] %1",_cName];
					BRPVP_menuExecutaParam pushBack _cObj;
					BRPVP_menuImagem pushBack format ["<img size='5.25' align='center' image='%1'/>",_image];
				};
			} forEach _data;
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				207 call BRPVP_menuMuda;
			} else {
				if (_this isEqualType objNull) then {
					BRPVP_menuVar4 = _this;
					209 call BRPVP_menuMuda;
				} else {
					BRPVP_menuVar5 = _this;
					BRPVP_menuVar6 = 208;
					210 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {207 call BRPVP_menuMuda;};
	},

	//MENU 209
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = ["<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\menu_cancel.paa'/>"];
		BRPVP_menuSleep = 0;
		BRPVP_menuIdcSafe = 208;
		BRPVP_menuForceExit = BRPVP_menuVar9;
		BRPVP_menuOpcoes = [localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = ["cancel"];
		if (!isNull BRPVP_menuVar3 && !isNull BRPVP_menuVar4 && (BRPVP_menuVar3 distance player <= 7.5 || BRPVP_menuVar3 isEqualTo backPackContainer player)) then {
			private _cargo = BRPVP_menuVar4 call BRPVP_getCargoArrayNoDb;
			private _data = _cargo select 1;
			{
				if (_forEachIndex isEqualTo 0) then {
					_x params ["_e1","_cArray"];
					_e1 params ["_cClass","_cObj"];
					_cArray params ["_weps","_mags","_items","_backPacks"];
					{
						_x params ["_wepArray","_qtt"];
						private _wName = getText (configFile >> "CfgWeapons" >> _wepArray select 0 >> "displayName") call BRPVP_escapeForStructuredTextFast;
						private _wOptics = if (_wepArray select 3 isEqualTo "") then {""} else {format[" [%1]",getText (configFile >> "CfgWeapons" >> _wepArray select 3 >> "displayName") call BRPVP_escapeForStructuredTextFast]};
						private _wAmmo1 = if (_wepArray select 4 isEqualTo []) then {0} else {_wepArray select 4 select 1};
						private _wAmmo2 = if (_wepArray select 5 isEqualTo []) then {0} else {_wepArray select 5 select 1};
						BRPVP_menuOpcoes pushBack format ["%1%2 X%4",_wName,_wOptics,_wAmmo1+_wAmmo2,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar4,0,_qtt,[_x]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",getText (configFile >> "CfgWeapons" >> _wepArray select 0 >> "picture")];
					} forEach _weps;
					{
						_x params ["_class","_qtt","_ammo"];
						private _mName = getText (configFile >> "CfgMagazines" >> _class >> "displayName") call BRPVP_escapeForStructuredTextFast;
						BRPVP_menuOpcoes pushBack format ["%1 X%3",_mName,_ammo,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar4,1,_qtt,[_x]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",getText (configFile >> "CfgMagazines" >> _class >> "picture")];
					} forEach _mags;
					{
						private _class = _x;
						(_class call BRPVP_getItemDisplayNameAndImage) params ["_iName","_image"];
						private _qtt = _items select 1 select _forEachIndex;
						BRPVP_menuOpcoes pushBack format ["%1 X%2",_iName,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar4,2,_qtt,[[_x],[_qtt]]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",_image];
					} forEach (_items select 0);
					{
						private _class = _x;
						(_class call BRPVP_getItemDisplayNameAndImage) params ["_iName","_image"];
						private _qtt = _backPacks select 1 select _forEachIndex;
						BRPVP_menuOpcoes pushBack format ["%1 X%2",_iName,_qtt];
						BRPVP_menuExecutaParam pushBack [BRPVP_menuVar4,3,_qtt,[[_x],[_qtt]]];
						BRPVP_menuImagem pushBack format ["<img size='3' align='center' image='%1'/>",_image];
					} forEach (_backPacks select 0);
				};
			} forEach _data;
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				208 call BRPVP_menuMuda;
			} else {
				BRPVP_menuVar5 = _this;
				BRPVP_menuVar6 = 209;
				210 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {208 call BRPVP_menuMuda;};
	},

	//MENU 210
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuSleep = 0;
		BRPVP_menuIdcSafe = BRPVP_menuVar6;
		BRPVP_menuForceExit = BRPVP_menuVar9;
		BRPVP_menuVar5 params ["_obj","_typeIdx","_qtt","_typeArray"];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		if (!isNull BRPVP_menuVar3 && !isNull _obj && (BRPVP_menuVar3 distance player <= 7.5 || BRPVP_menuVar3 isEqualTo backPackContainer player)) then {
			BRPVP_menuOpcoes = [format ["All (%1)",_qtt]];
			BRPVP_menuExecutaParam = [_qtt];
			if (_qtt >= 10) then {
				BRPVP_menuOpcoes pushBack format ["75%1 (%2)","%",round (_qtt*0.75)];
				BRPVP_menuExecutaParam pushBack round (_qtt*0.75);
				BRPVP_menuOpcoes pushBack format ["50%1 (%2)","%",round (_qtt*0.50)];
				BRPVP_menuExecutaParam pushBack round (_qtt*0.50);
				BRPVP_menuOpcoes pushBack format ["25%1 (%2)","%",round (_qtt*0.25)];
				BRPVP_menuExecutaParam pushBack round (_qtt*0.25);
			};
			for "_i" from 1 to _qtt do {BRPVP_menuOpcoes pushBack str _i;BRPVP_menuExecutaParam pushBack _i;};
		};
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar7 = _this;
			211 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {BRPVP_menuVar6 call BRPVP_menuMuda;};
	},

	//MENU 211
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 0; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "";
		BRPVP_menuSleep = 0;
		BRPVP_menuIdcSafe = 210;
		BRPVP_menuForceExit = BRPVP_menuVar9;
		BRPVP_menuOpcoes = [localize "str_menu12_opt2"];
		BRPVP_menuExecutaParam = ["cancel"];
		if (uniformContainer player isNotEqualTo BRPVP_menuVar3) then {
			BRPVP_menuOpcoes pushBack localize "str_mmi_uniform_to";
			BRPVP_menuExecutaParam pushBack uniformContainer player;
		};
		if (vestContainer player isNotEqualTo BRPVP_menuVar3) then {
			BRPVP_menuOpcoes pushBack localize "str_mmi_vest_to";
			BRPVP_menuExecutaParam pushBack vestContainer player;
		};
		if (backPack player isNotEqualTo BRPVP_menuVar3) then {
			BRPVP_menuOpcoes pushBack localize "str_mmi_backpack_to";
			BRPVP_menuExecutaParam pushBack backpackContainer player;
		};
		if (BRPVP_menuVar1 isNotEqualTo BRPVP_menuVar3) then {
			BRPVP_menuOpcoes pushBack localize "str_mmi_box_vehicle_to";
			BRPVP_menuExecutaParam pushBack BRPVP_menuVar1;
		};
		if (BRPVP_menuVar2 isNotEqualTo BRPVP_menuVar3) then {
			BRPVP_menuOpcoes pushBack localize "str_mmi_ground_to";
			BRPVP_menuExecutaParam pushBack "ground";
		};
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				BRPVP_menuVar6 call BRPVP_menuMuda;
			} else {
				BRPVP_menuVar5 params ["_obj","_typeIdx","_qtt","_typeArray"];
				private _toObj = if (_this isEqualTo "ground") then {
					if (isNull BRPVP_menuVar2) then {
						private _holder = createVehicle ["GroundWeaponHolder",ASLToAGL getPosASL player,[],0,"CAN_COLLIDE"];
						_holder setVariable ["brpvp_mm_using",player,true];
						BRPVP_menuVar2 = _holder;
						BRPVP_menuVar2
					} else {
						BRPVP_menuVar2
					};
				} else {
					_this
				};
				private _removeFrom = if (BRPVP_menuVar6 isEqualTo 208) then {BRPVP_menuVar3} else {BRPVP_menuVar4};
				if (isNull _toObj) then {
					"erro" call BRPVP_playSound;
					211 call BRPVP_menuMuda;
				} else {
					if (isNull _removeFrom) then {
						"erro" call BRPVP_playSound;
						207 call BRPVP_menuMuda;
					} else {
						if ((BRPVP_menuVar3 distance player <= 7.5 || BRPVP_menuVar3 isEqualTo backpackContainer player) && (_toObj distance player <= 7.5 || _toObj isEqualTo backpackContainer player)) then {
							if (_typeIdx in [0,1]) then {(_typeArray select 0) set [1,1];} else {(_typeArray select 1) set [0,1];};
							private _toObjFreeSpace = maxLoad _toObj-loadAbs _toObj;
							private _whTemp = createVehicle ["GroundWeaponHolder",BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
							private _cargoArray = [[],[],[[],[]],[[],[]]];
							_cargoArray set [_typeIdx,_typeArray];
							[_whTemp,_cargoArray] call BRPVP_putItemsOnCargoMultItemMove;
							private _whTempLoadOne = loadAbs _whTemp;
							private _qttf = 0;
							deleteVehicle _whTemp;
							for "_i" from BRPVP_menuVar7 to 1 step -1 do {if (_toObjFreeSpace >= _whTempLoadOne*_i) exitWith {_qttf = _i;};};
							if (_qttf > 0) then {
								if (_typeIdx in [0,1]) then {(_typeArray select 0) set [1,_qttf];} else {(_typeArray select 1) set [0,_qttf];};

								//PUT ITEMS ON DESTINE
								[_toObj,_cargoArray] call BRPVP_putItemsOnCargoMultItemMove;

								//REMOVE ITEMS FROM ORIGIM
								if (_typeIdx isEqualTo 0) then {
									_removeFrom addWeaponCargoGlobal [_typeArray select 0 select 0 select 0,-(_typeArray select 0 select 1)];
								} else {
									[_removeFrom,_cargoArray,-1] call BRPVP_putItemsOnCargoMultItemMove;
								};
								if (loadAbs _removeFrom isEqualTo 0) then {207 call BRPVP_menuMuda;} else {BRPVP_menuVar6 call BRPVP_menuMuda;};
							} else {
								"erro" call BRPVP_playSound;
								211 call BRPVP_menuMuda;
							};
						} else {
							"erro" call BRPVP_playSound;
							211 call BRPVP_menuMuda;
						};
					};
				};
			};
		};
		BRPVP_menuVoltar = {BRPVP_menuVar6 call BRPVP_menuMuda;};
	},

	//MENU 212
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		_typeOf = typeOf BRPVP_stuff;
		BRPVP_menuImagem = format ["<img size='3.0' align='center' image='%1'/>",getText (configFile >> "CfgVehicles" >> _typeOf >> "picture")];
		BRPVP_menuOpcoes = [localize "str_heli_main_pilot",localize "str_heli_turret_pilot"];
		BRPVP_menuExecutaParam = ["main","turret"];
		BRPVP_menuExecutaFuncao = {
			_mny = player getVariable ["brpvp_mny_bank",0];
			if (_mny >= BRPVP_pylonChangePrice) then {
				player setVariable ["brpvp_mny_bank",_mny-BRPVP_pylonChangePrice,true];
				if (_this isEqualTo "main") then {
					[BRPVP_stuff,[BRPVP_menuVar1,BRPVP_menuVar3]] remoteExecCall ["setPylonLoadout",BRPVP_stuff];
				} else {
					[BRPVP_stuff,[BRPVP_menuVar1,BRPVP_menuVar3,false,[0]]] remoteExecCall ["setPylonLoadout",BRPVP_stuff];
				};
				"negocio" call BRPVP_playSound;
				call BRPVP_atualizaDebug;
				BRPVP_menuVar2 = true;
				130 spawn BRPVP_menuMuda;
			} else {
				"erro" call BRPVP_playSound;
				[format [localize "str_need_x_in_bank",BRPVP_pylonChangePrice],-5] call BRPVP_hint;
				BRPVP_menuVar2 = false;
			};
		};
		BRPVP_menuVoltar = {130 call BRPVP_menuMuda;};
	},

	//MENU 213
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\compass.paa'/>";
		BRPVP_menuOpcoes = [
			localize "str_start_lars_miss",
			localize "str_start_peter_miss",
			localize "str_menu29_opt12",
			localize "str_menu29_opt13",
			localize "str_menu29_opt14",
			localize "str_menu29_opt15",
			localize "str_mission_bomb_opt",
			localize "str_mission_trans_opt",
			localize "str_water_mission_opt",
			localize "str_vehicle_mission_opt"
		];
		BRPVP_menuExecutaParam = [1,2,3,4,5,6,7,8,9,10];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo 1) then {remoteExecCall ["BRPVP_larsCreateMission",2];};
			if (_this isEqualTo 2) then {remoteExecCall ["BRPVP_peterCreateMission",2];};
			if (_this isEqualTo 3) then {player remoteExec ["BRPVP_bravoRunHC",0];}; //2
			if (_this isEqualTo 4) then {
				_canStart = ({_x isEqualTo 1} count BRPVP_closedCityRunning) isEqualTo 0;
				if (_canStart) then {
					[localize "str_siege_start",-6] call BRPVP_hint;
					remoteExec ["BRPVP_besiegedMission",0]; //2
				} else {
					[localize "str_siege_cant_start",-5] call BRPVP_hint;
				};
			};
			if (_this isEqualTo 5) then {
				remoteExecCall ["BRPVP_convoyMission",2];
				[localize "str_convoy_started",-4] call BRPVP_hint;
			};
			if (_this isEqualTo 6) then {player remoteExecCall ["BRPVP_runCorruptMissSpawn",2];};
			if (_this isEqualTo 7) then {
				[["str_bomb_mission_started",[]],-6] remoteExecCall ["BRPVP_hint",0];
				[] remoteExec ["BRPVP_bombMissionCode",0]; //2
			};
			if (_this isEqualTo 8) then {
				[["str_trans_mission_started",[]],-6] remoteExecCall ["BRPVP_hint",0];
				[] remoteExec ["BRPVP_transMissionCode",0]; //2
			};
			if (_this isEqualTo 9) then {
				[["str_water_mission_started",[call BRPVP_worldName]],-5] remoteExecCall ["BRPVP_hint",0];
				[] remoteExec ["BRPVP_waterMissionCode",0]; //2
			};
			if (_this isEqualTo 10) then {
				remoteExecCall ["BRPVP_vehicleMissionCode",2];
				"achou_loot" call BRPVP_playSound;
			};
			"hint2" call BRPVP_playSound;
		};
		BRPVP_menuVoltar = {29 call BRPVP_menuMuda;};
	},

	//MENU 214
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = BRPVP_itemsHotkeys apply {format ["<img size='3' align='center' image='"+BRPVP_imagePrefix+"%1'/>",BRPVP_specialItemsImages select (BRPVP_specialItems find _x)]};
		BRPVP_menuOpcoes = [[0,"F5"],[1,"F6"],[2,"F7"],[3,"F8"]] apply {format ["%1: %2",_x select 1,BRPVP_specialItemsNames select (BRPVP_specialItems find (BRPVP_itemsHotkeys select (_x select 0)))]};
		BRPVP_menuExecutaParam = [0,1,2,3];
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar1 = _this;
			215 call BRPVP_menuMuda;			
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 215
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = BRPVP_specialItemsforHotkeys apply {format ["<img size='3' align='center' image='"+BRPVP_imagePrefix+"%1'/>",BRPVP_specialItemsImages select (BRPVP_specialItems find _x)]};
		BRPVP_menuOpcoes = BRPVP_specialItemsforHotkeys apply {BRPVP_specialItemsNames select (BRPVP_specialItems find _x)};
		BRPVP_menuExecutaParam = BRPVP_specialItemsforHotkeys;
		BRPVP_menuExecutaFuncao = {
			BRPVP_itemsHotkeys set [BRPVP_menuVar1,_this];
			private _cfg = player getVariable "brpvp_player_config";
			_cfg set [6,BRPVP_itemsHotkeys];
			player setVariable ["brpvp_player_config",_cfg,[clientOwner,2]];
			214 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {214 call BRPVP_menuMuda;};
	},

	//MENU 216
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\db_save.paa'/>";
		BRPVP_menuOpcoes = ["Save","Save & Exit","Reset Database & Exit!","Cancel"];
		BRPVP_menuExecutaParam = ["s","se","rd","c"];
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "s") then {
				["Saving Database...",-2] call BRPVP_hint;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				BRPVP_pfl_hdb_saveProfileName = true;
			};
			if (_this isEqualTo "se") then {
				if (clientOwner isEqualTo 2) then {
					call compile preprocessFileLineNumbers "listenServerSaveAndExit.sqf";
					BRPVP_iniciaMenuExtraBlock = true;
					BRPVP_menuExtraLigado = false;
					hintSilent "";
				} else {
					"erro" call BRPVP_playSound;
					["This option is not for dedicated servers!",0] call BRPVP_hint;
				};
			};
			if (_this isEqualTo "rd") then {
				BRPVP_menuVar1 = 5;
				217 call BRPVP_menuMuda;
			};
			if (_this isEqualTo "c") then {30 call BRPVP_menuMuda;};
		};
		BRPVP_menuVoltar = {30 call BRPVP_menuMuda;};
	},

	//MENU 217
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\db_reset.paa'/>";
		BRPVP_menuOpcoes = [localize "str_menu12_opt2",localize "str_confirm"];
		BRPVP_menuExecutaParam = [false,true];
		BRPVP_menuExecutaFuncao = {
			if (_this) then {
				BRPVP_iniciaMenuExtraBlock = true;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\db_save.paa'/><br/>Database Reseted!",0,0.25,2,0,0,9945] call BRPVP_fnc_dynamicText;
				"ServerRestart" remoteExecCall ["endMission",-clientOwner];
				0 spawn {
					uiSleep 0.75;
					call BRPVP_hdb_resetDatabase;
					call BRPVP_hdb_saveAllTables;
					uiSleep 0.001;
					endMission "ServerRestart";
				};
			} else {
				216 call BRPVP_menuMuda;
			};
		};
		BRPVP_menuVoltar = {216 call BRPVP_menuMuda;};
	},

	//MENU 218
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			BRPVP_menuImagem pushBack format ["<img size='8' align='center' image='%1BRP_imagens\textures\%2.paa'/>",BRPVP_imagePrefix,_x];
			BRPVP_menuOpcoes pushBack format ["#%1 - %2",_forEachIndex+1,BRPVP_vrObjectsColorsNames select _forEachIndex];
			BRPVP_menuExecutaParam pushBack _x;
		} forEach BRPVP_vrObjectsColors;
		BRPVP_menuExecutaFuncao = {
			BRPVP_menuVar2 = _this;
			219 call BRPVP_menuMuda;
		};
		BRPVP_menuVoltar = {
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	},

	//MENU 219
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 2; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = [];
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			BRPVP_menuImagem pushBack format ["<img size='8' align='center' image='%1BRP_imagens\textures\%2.paa'/>",BRPVP_imagePrefix,_x];
			BRPVP_menuOpcoes pushBack format ["#%1 - %2",_forEachIndex+1,BRPVP_vrObjectsColorsNames select _forEachIndex];
			BRPVP_menuExecutaParam pushBack _x;
		} forEach BRPVP_vrObjectsColors;
		BRPVP_menuExecutaFuncao = {
			private _mny = player getVariable "mny";
			if (_mny >= BRPVP_menuVar3) then {
				player setVariable ["mny",_mny-BRPVP_menuVar3,true];
				"negocio" call BRPVP_playSound;
				call BRPVP_atualizaDebug;
				private _exec = format ["[_this,'%1','%2'] call BRPVP_vrObjectSetTextures;",BRPVP_menuVar2,_this];
				[BRPVP_menuVar1 getVariable ["id_bd",-1],_exec] remoteExecCall ["BRPVP_updateTurretExec",2];
				[BRPVP_menuVar1,BRPVP_menuVar2,_this] call BRPVP_vrObjectSetTextures;
				[BRPVP_menuVar1 getVariable "id_bd",typeOf BRPVP_menuVar1,BRPVP_menuVar2,_this] remoteExecCall ["BRPVP_vrObjectSetTexturesOnOthers",-clientOwner];
				BRPVP_menuVar1 setVariable ["brpvp_last_vr_paint_time",time];
				[format [localize "str_vr_paint_taste_free",BRPVP_vrObjectsPaintTasteTime],-6] call BRPVP_hint;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				"erro" call BRPVP_playSound;
			};
		};
		BRPVP_menuVoltar = {218 call BRPVP_menuMuda;};
	},

	//MENU 220
	{
		BRPVP_menuTipo = 2;
		BRPVP_menuTipoImagem = 1; //0 - NENHUMA | 1 - FIXA | 2 - UMA POR OPCAO
		BRPVP_menuImagem = "<img size='3.0' align='center' image='"+BRPVP_imagePrefix+"BRP_imagens\voodoo_doll.paa'/>";
		BRPVP_menuOpcoes = [];
		BRPVP_menuExecutaParam = [];
		{
			if ((time-(_x getVariable ["brpvp_last_voodoo",-BRPVP_voodooCollDown*60]))/60 > BRPVP_voodooCollDown) then {
				if (_x getVariable ["sok",false] && !(_x getVariable ["brpvp_blind",false]) && !(_x getVariable "brpvp_god_admin")) then {
					BRPVP_menuOpcoes pushBack (_x getVariable "nm");
					BRPVP_menuExecutaParam pushBack _x;
				};
			};
		} forEach call BRPVP_playersList;
		BRPVP_menuOpcoes pushBack localize "str_menu12_opt2";
		BRPVP_menuExecutaParam pushBack "cancel";
		BRPVP_menuExecutaFuncao = {
			if (_this isEqualTo "cancel") then {
				["BRPVP_voodooDoll",1] call BRPVP_sitAddItem;
				BRPVP_menuExtraLigado = false;
				hintSilent "";
			} else {
				if (_this getVariable ["sok",false] && !(_this getVariable ["brpvp_blind",false]) && !(_this getVariable "brpvp_god_admin")) then {
					remoteExec ["BRPVP_voodooSetPlayerToBlind",_this];
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					[player,["voodoo_maker",600]] remoteExecCall ["say3D",BRPVP_allNoServer];
				} else {
					220 call BRPVP_menuMuda;
				};
			};
		};
		BRPVP_menuVoltar = {
			["BRPVP_voodooDoll",1] call BRPVP_sitAddItem;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
		};
	}
];

//ROEDAPE DO MENU
_defaultFooter = {"<br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"};
BRPVP_menuRodapeHtml = [
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/><br/><t size='1.25'>MOD: "+(BRPVP_menuMods select BRPVP_menuOpcoesSel)+"</t><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	{"<br/><t size='1.25'>MOD: "+(BRPVP_menuMods select BRPVP_menuOpcoesSel)+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //20
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	{"<br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",round BRPVP_compraPrecoTotal]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/>"+(if (!BRPVP_givenoRemove) then {"<t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player getVariable [BRPVP_transferType,0]) call BRPVP_formatNumber] + "</t><br/>"} else {""})+"<br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/>"+(if (!BRPVP_givenoRemove) then {"<t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player getVariable [BRPVP_transferType,0]) call BRPVP_formatNumber] + "</t><br/>"} else {""})+"<t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_to_give",(round BRPVP_menuVar2) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/>"+(if (!BRPVP_givenoRemove) then {"<t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player getVariable [BRPVP_transferType,0]) call BRPVP_formatNumber] + "</t><br/>"} else {""})+"<t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_to_give",(round BRPVP_menuVar2) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //40
	_defaultFooter,	
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //60
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //70
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	{"<br/><t align='center' size='1.5' color='#FFD300'>"+localize "str_adding_funds"+"<br/>"+(BRPVP_menuVar1 call BRPVP_formatNumber)+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter, //80
	{"<br/><t align='center' size='1.5' color='#FFD300'>"+localize "str_adding_funds"+"<br/>"+(BRPVP_menuVar2 call BRPVP_formatNumber)+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //90
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //100
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,	
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //110
	{"<br/><br/><t align='center' size='1.5' color='#FFD300'>$"+((BRPVP_stuff call BRPVP_getInsurancePrice) call BRPVP_formatNumber)+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	{"<br/><br/><br/><t size='1.25'>MOD: "+(BRPVP_menuMods select BRPVP_menuOpcoesSel)+"</t><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	{"<br/><br/><t size='1.15' color='#FFFF33' align='center'>" + format [localize "str_your_money",(player call BRPVP_qjsValorDoPlayer) call BRPVP_formatNumber] + "</t><br/><t size='1.15' color='#FFFF33' align='center'>"+format [localize "str_menu_foot_total_price",(round BRPVP_compraPrecoTotal) call BRPVP_formatNumber]+"</t><br/><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_navigate"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_navigate_keys"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_select"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_select_key"+"</t><br/><t size='1.15' align='left' color='#FF3333'>"+localize "str_menu_foot_back"+"</t><t size='1.15' align='right' color='#FFFFFF'>"+localize "str_menu_foot_back_key"+"</t>"},
	_defaultFooter,
	_defaultFooter,
	_defaultFooter, //120
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,	
	/*130*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*140*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*150*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*160*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*170*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*180*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*190*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*200*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*210*/_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	_defaultFooter,
	/*220*/_defaultFooter
];

//POSICOES DOS MENUS
BRPVP_menuPos = [];
{BRPVP_menuPos pushBack [["@#","@#","@#","@#","@#","@#","@#","@#","@#","@#"],0];} forEach BRPVP_menu;

diag_log ("[SCRIPT] playerMenuSystem.sqf END: " + str round (diag_tickTime - _scriptStart));