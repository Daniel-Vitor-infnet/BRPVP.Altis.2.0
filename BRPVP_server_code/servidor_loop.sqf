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

//RESETA COMANDO NO BANCO DE DADOS
if (BRPVP_useExtDB3) then {
	"extDB3" callExtension format ["0:%1:fixSalvarTableA",BRPVP_protocolo];
	"extDB3" callExtension format ["0:%1:fixSalvarTableB",BRPVP_protocolo];
};

BRPVP_serverSimulationStuff = {
	{
		if (isDamageAllowed _x) then {
			if (simulationEnabled _x && {(_x getVariable ["id_bd",-1] isNotEqualTo -1 || _x getVariable ["brpvp_fedidex",false]) && crew _x isEqualTo [] && vectorMagnitude velocity _x < 0.01 && (isTouchingGround _x || {getPos _x select 2 < 0.5}) && isNull ropeAttachedTo _x && isNull attachedTo _x && serverTime > (_x getVariable ["brpvp_time_can_disable",0])}) then {
				if (isEngineOn _x) then {
					[_x,false] remoteExecCall ["engineOn",_x];
					if (_x isKindOf "Helicopter") then {
						_x setVariable ["brpvp_time_can_disable",serverTime+60];
					} else {
						_x setVariable ["brpvp_time_can_disable",serverTime+5];
					};
				} else {
					private _amt = _x getVariable ["brpvp_auto_magus_time",-1];
					private _lp = _x getVariable ["brpvp_auto_magus_last_players",[]];
					private _amtXtr = if (_lp isEqualTo []) then {0} else {BRPVP_useTireAutoMoveToTimeLastVeh-BRPVP_useTireAutoMoveToTime};
					if (_amt > -1 && {serverTime > _amt+_amtXtr && _x getVariable ["own",-1] > -1}) then {
						if (_x call BRPVP_isServiceVehicle || typeOf _x in (BRPVP_artilleryLimit select 0)) then {_x setVariable ["brpvp_auto_magus_time",-1];} else {[_x,vectorUp _x,vectorDir _x,getPos _x select 2,getPosASL _x] remoteExecCall ["BRPVP_tireServerPutVeh",2];};
					} else {
						_x enableSimulationGlobal false;
					};
				};
			};
		} else {
			if (!simulationEnabled _x) then {_x enableSimulationGlobal true;};
		};
	} forEach entities [["Motorcycle","Car","Tank","Air","Ship"],[],false,true];
	if (time > 35) then {
		{
			if !(typeOf _x in BRPVP_doNotDisableBuildingClass) then {
				if (simulationEnabled _x && {vectorMagnitude velocity _x < 0.01 && serverTime > (_x getVariable ["brpvp_time_can_disable",0])}) then {
					_x enableSimulationGlobal false;
				};
			};
		} forEAch BRPVP_ownedHouses;
	};
};

//DEFINE VARIAVEIS
BRPVP_SL_contaA = 0;
BRPVP_SL_contaB = 0;
BRPVP_SL_contaC = 0;
BRPVP_SL_contaD = 0;
BRPVP_SL_contaE = 0;
BRPVP_SL_contaF = 0;
BRPVP_SL_contaG = 0;
BRPVP_SL_contaH = 0;

BRPVP_SL_loopsA = 30;
BRPVP_SL_loopsB = 300;
BRPVP_SL_loopsC = 5;
BRPVP_SL_loopsD = 10;
BRPVP_SL_loopsE = 30;
BRPVP_SL_loopsF = 15;
BRPVP_SL_loopsG = 2;
BRPVP_SL_loopsH = 1;

BRPVP_SL_timedA = false;

BRPVP_playersIntoTheFort = [];
BRPVP_SL_spotedPlayers = [];
BRPVP_SL_spotedPlayersDelMark = [];
BRPVP_spotedPlayersHeadPrice = [];
BRPVP_SL_inicio = time;
BRPVP_SL_end = false;
BRPVP_SL_dayOk = false;
BRPVP_SL_doRestartMsg = {
	private _minLeft = 60-_this;
	if (_minLeft in BRPVP_restartWarnings) then {
		BRPVP_restartWarnings = BRPVP_restartWarnings-[_minLeft];
		[["str_server_restart_in",[_minLeft]],3.5,20] remoteExecCall ["BRPVP_hint",0];
	};
};
BRPVP_atomicBombHiddenBigFloorsLast = +BRPVP_atomicBombHiddenBigFloors;

//MESSAGES
BRPVP_SL_messages = [];
if (BRPVP_useExtDB3) then {
	private _result = "extDB3" callExtension format ["0:%1:getMessages",BRPVP_protocolo];
	BRPVP_SL_messages = parseSimpleArray _result select 1;
};
BRPVP_SL_messagesId = [];
BRPVP_SL_messagesLast = [];
BRPVP_SL_waitMsg = 5;
BRPVP_SL_msgMark = 0;

//PVP AREAS
{
	private ["_mark"];
	
	_mark = createMarker ["PVP_MARK_AA"+str _forEachIndex,_x select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (4/4);
	_mark setMarkerSize [_x select 1,_x select 1];

	_mark = createMarker ["PVP_MARK_AB"+str _forEachIndex,_x select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (3/4);
	_mark setMarkerSize [(_x select 1)+10,(_x select 1)+10];

	_mark = createMarker ["PVP_MARK_AC"+str _forEachIndex,_x select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (2/4);
	_mark setMarkerSize [(_x select 1)+20,(_x select 1)+20];

	_mark = createMarker ["PVP_MARK_AD"+str _forEachIndex,_x select 0];
	_mark setMarkerShape "ELLIPSE";
	_mark setMarkerBrush "Border";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerAlpha (1/4);
	_mark setMarkerSize [(_x select 1)+30,(_x select 1)+30];

	_mark = createMarker ["PVP_MARK_B"+str _forEachIndex,_x select 0];
	_mark setMarkerShape "ICON";
	_mark setMarkerType "mil_dot";
	_mark setMarkerColor "ColorRed";
	_mark setMarkerText call (_x select 2);
} forEach BRPVP_PVPAreas;

BRPVP_SL_sFpsArray = [];
for "_i" from 1 to 50 do {BRPVP_SL_sFpsArray pushBack diag_fps;};

addMissionEventHandler ["EachFrame",{call BRPVP_serverLoopCode;}];
BRPVP_serverLoopCode = {
	_agora = time;
	BRPVP_SL_sFpsArray deleteAt 0;
	BRPVP_SL_sFpsArray pushBack diag_fps;
	if (_agora-BRPVP_SL_inicio >= 1 && !BRPVP_SL_end) then {
		BRPVP_SL_inicio = _agora;

		//MESSAGES
		if (_agora-BRPVP_SL_msgMark > BRPVP_SL_waitMsg) then {
			BRPVP_SL_msgMark = _agora;
			BRPVP_SL_waitMsg = 5;
			{
				_x params ["_id","_msg_start","_msg_end","_msg_interval","_msg_txt","_msg_duration"];
				if (_agora > _msg_start) then {
					if (_agora < _msg_end) then {
						private ["_last"];
						_idx = BRPVP_SL_messagesId find _id;
						if (_idx != -1) then {
							_last = BRPVP_SL_messagesLast select _idx;
						} else {
							_idx = count BRPVP_SL_messagesId;
							BRPVP_SL_messagesId pushBack _id;
							_last = _msg_start-_msg_interval;
							BRPVP_SL_messagesLast pushBack _last;
						};
						_delta = _agora-_last;
						if (_delta >= _msg_interval) then {
							BRPVP_SL_messagesLast set [_idx,_last+_msg_interval];
							[_msg_txt,_msg_duration] remoteExec ["BRPVP_specialMessageShow",BRPVP_allNoServer];
						};
						BRPVP_SL_waitMsg = ((_last+_msg_interval)-_agora) min BRPVP_SL_waitMsg;							
					};
				} else {
					BRPVP_SL_waitMsg = (_msg_start+_msg_interval-_agora) min BRPVP_SL_waitMsg;
				};
			} forEach BRPVP_SL_messages;
		};

		//1 SECOND LOOP
		if (BRPVP_SL_contaH isEqualTo BRPVP_SL_loopsH) then {
			BRPVP_SL_contaH = 0;

			//DELETION SCHEDULE 1 SECOND CYCLE
			_del = [];
			{
				_x params ["_tm","_objs"];
				if (diag_tickTime >= _tm) then {
					{{deleteVehicle _x;} forEach (_x nearObjects 0);} forEach _objs;
					_del pushBack _forEachIndex;
				};
			} forEach BRPVP_deleteAfterTimeObjsSmall;
			_del sort false;
			{BRPVP_deleteAfterTimeObjsSmall deleteAt _x;} forEach _del;

			//SPOT PLAYERS ON MAP
			private _xtraCnt = count BRPVP_SL_spotedPlayersDelMark;
			{
				_x params ["_p","_posCode","_name"];
				BRPVP_SL_spotedPlayersDelMark pushBack _x;
				private _posRand = _p call _posCode;
				private _marker2 = createMarker ["PLAYER_SPOTED_DOT_"+str (_xtraCnt+_forEachIndex),_posRand];
				_marker2 setMarkerShape "Icon";
				_marker2 setMarkerType "mil_dot";
				if (_forEachIndex in BRPVP_spotedPlayersHeadPrice) then {_marker2 setMarkerColor "ColorOrange";} else {_marker2 setMarkerColor "ColorYellow";};
				if (_forEachIndex in BRPVP_spotedPlayersHeadPrice) then {_marker2 setMarkerText _name;} else {_marker2 setMarkerText "$$$";};
			} forEach BRPVP_SL_spotedPlayers;
		};

		//5 SECONDS LOOP
		if (BRPVP_SL_contaC isEqualTo BRPVP_SL_loopsC) then {
			BRPVP_SL_contaC = 0;

			//UPATE PLAYER_IN_VEHICLES ARRAY
			private _playerVehicles = [];
			{if (!isNull objectParent _x) then {_playerVehicles pushBack _x;};} forEach call BRPVP_playersList;
			BRPVP_playerVehicles = _playerVehicles;
			BRPVP_playerVehiclesVehicles = BRPVP_playerVehicles apply {vehicle _x};

			//ATUALIZA FPS DO SERVIDOR NO CLIENTE
			diag_log ("[BRPVP] FPS = "+str BRPVP_servidorQPS+".");

			//DELETION SCHEDULE
			_del = [];
			{
				_x params ["_tm","_objs"];
				if (diag_tickTime >= _tm) then {
					{{deleteVehicle _x;} forEach (_x nearObjects 0);} forEach _objs;
					_del pushBack _forEachIndex;
				};
			} forEach BRPVP_deleteAfterTimeObjs;
			_del sort false;
			{BRPVP_deleteAfterTimeObjs deleteAt _x;} forEach _del;

			//SINALIZE NAKED PLAYERS
			{if (uniform _x isEqualTo "") then {remoteExecCall ["BRPVP_uniformCheck",_x];};} forEach call BRPVP_playersList;
			
			//GET PLAYERS PING
			{
				private _data = getUserInfo _x;
				if !(_data select 7) then {(_data select 10) setVariable ["brpvp_ping",_data select 9 select 0,[2,_data select 1]];};
			} forEach allUsers;
		};

		if (BRPVP_SL_contaA isEqualTo BRPVP_SL_loopsA) then {
			BRPVP_SL_contaA = 0;

			//REMOVE INVASION ICONS IF EXPIRED
			_lpObjDel = [];
			{
				_x params ["_pos","_actTime"];
				_delta = serverTime-_actTime;
				if (_delta >= 900) then {_lpObjDel pushBack _x;};
			} forEach BRPVP_lockPickedBuildings;
			if (count _lpObjDel > 0) then {
				BRPVP_lockPickedBuildings = BRPVP_lockPickedBuildings-_lpObjDel;
				publicVariable "BRPVP_lockPickedBuildings";
			};

			//GET MESSAGES
			BRPVP_SL_messages = [];
			if (BRPVP_useExtDB3) then {
				private _result = "extDB3" callExtension format ["0:%1:getMessages",BRPVP_protocolo];
				BRPVP_SL_messages = parseSimpleArray _result select 1;
			};

			//DELETA QUADRICICLOS ESPIRADOS
			{
				_tmp = _x getVariable ["tmp",-1];
				if (_tmp > -1) then {
					if (_tmp isEqualTo 0) then {
						_x setVariable ["tmp",_agora,true];
						_tmp = _agora;
					};
					if (_agora-_tmp > BRPVP_tempoDeVeiculoTemporarioNascimento && {count crew _x isEqualTo 0}) then {deleteVehicle _x;};
				};
			} forEach entities [[BRPVP_veiculoTemporarioNascimento],[]];

			//LOG PLAYERS FPS
			_playersFPS = [];
			{
				_pFps = _x getVariable ["brpvp_fps",-1];
				if (_x getVariable ["sok",false] && _pFps >= 0) then {
					_playersFPS pushBack [_pFps,_x getVariable ["nm","(no name found)"]];
				};
			} forEach call BRPVP_playersList;
			_avgFpsCnt = count _playersFPS;
			if (_avgFpsCnt > 0) then {
				_playersFPS sort false;
				diag_log "============= PLAYERS FPS BEGIN =============";
				_avgFps = 0;
				{diag_log str _x;_avgFps = _avgFps+(_x select 0);} forEach _playersFPS;
				_avgFps = _avgFps/_avgFpsCnt;
				diag_log ("Number of players: "+str _avgFpsCnt);
				diag_log ("Average FPS: "+str round _avgFps);
				diag_log "============== PLAYERS FPS END ==============";
			};

			//DELETE ZOMBIE LOOT
			{if (time-(_x getVariable "brpvp_zombie_loot_time") > 300) then {deleteVehicle _x;};} forEach BRPVP_zombieLootWH;
			BRPVP_zombieLootWH = BRPVP_zombieLootWH-[objNull];

			//SAVE HIDDEN BIG FLOOR PIECES IF CHANGED
			if (BRPVP_atomicBombHiddenBigFloors isNotEqualTo BRPVP_atomicBombHiddenBigFloorsLast) then {
				BRPVP_atomicBombHiddenBigFloorsLast = +BRPVP_atomicBombHiddenBigFloors;
				profileNamespace setVariable ["BRPVP_SVP_atomicBombHiddenBigFloors",BRPVP_atomicBombHiddenBigFloors];
				saveProfileNamespace;
			};
		};

		//CRIA MISSAO
		if (BRPVP_SL_contaB isEqualTo BRPVP_SL_loopsB) then {
			BRPVP_SL_contaB = 0;
			_hasMissInit = false;

			//CLEAN PLAYERS DEAD BODY BY TIME
			{
				_isPlayerDeadBody = !(_x getVariable ["brpvp_owner_id","0"] isEqualTo "0") && _x getVariable ["hrm",-1] != -1;
				if (_isPlayerDeadBody && {diag_tickTime-(_x getVariable "hrm") > BRPVP_maxPlayerDeadBodyTime}) then {deleteVehicle _x;};
			} forEach entities [["Box_T_East_Wps_F"],[]];

			//SYNC ALL CLIENTS TIME
			BRPVP_syncedTime = diag_tickTime;
			BRPVP_syncedTimeMark = BRPVP_syncedTime;
			publicVariable "BRPVP_syncedTime";

			//REFUEL ALL AI VEHICLES
			{
				if (_x getVariable ["id_bd",-1] isEqualTo -1 && !(_x getVariable ["brpvp_fedidex",false])) then {
					if ({alive _x && _x getVariable ["id_bd",-1] isEqualTo -1} count crew _x > 0) then {
						_x setFuel 1;
						_x setVehicleAmmoDef 1;
					};
				};
			} forEach entities [["LandVehicle","Air","Ship"],[]];

			//SHOW FARM ORE AGAIN
			_del = [];
			{
				if (serverTime > _x select 0) then {
					(_x select 1) hideObjectGlobal false;
					_del pushBack _forEachIndex;
				};
			} forEach BRPVP_farmObjShowList;
			_del sort false;
			{BRPVP_farmObjShowList deleteAt _x;} forEach _del;

			//RECALC KILL MAP
			if (BRPVP_killMapCalculateEachFiveMinutes) then {call BRPVP_killMapCalculate;};

			//RECORD SERVER FPS ON DATABASE
			if (!isNil "BRPVP_HC1ClientOk") then {
				if (BRPVP_useExtDB3) then {
					0 spawn {
						//NOHC_CHECK
						sleep random 2.5;
						_qtPlayers = count call BRPVP_playersList;
						_weekDay = (systemTime select [0,6]) call BRPVP_getWeekDay;
						_serverFps = BRPVP_SL_sFpsArray call BRPVP_arrayToFps;
						_runningHous = serverTime/3600;
						_aiCount = count ((BRPVP_roadBlockBots+BRPVP_missBotsEm+BRPVP_noShowBots)-[objNull]);
						_vehiclesCount = count vehicles;
						_actScripts = diag_activeScripts;
						_allMissEh = diag_allMissionEventHandlers;
						_allMissEhRun = [];
						for "_i" from 1 to (count _allMissEh-1) step 2 do {if (_allMissEh select _i > 0) then {_allMissEhRun pushBack [_allMissEh select (_i-1),_allMissEh select _i];};};
						"extDB3" callExtension format ["1:%1:fpsLogAdd:%2:%3:%4:%5:%6:%7:%8:%9:%10:%11",BRPVP_protocolo,0,_qtPlayers,_weekDay,_serverFps,_runningHous,-1,_aiCount,_vehiclesCount,_actScripts,_allMissEhRun];
					};
				} else {
					//NOTHING IF CLIENTSV
				};
			};

			//DELETE GRASS CUT OBJECT
			{if (serverTime-(_x getVariable "brpvp_cut_time") > BRPVP_grassCutTime) then {deleteVehicle _x;};} forEach BRPVP_grassCutObjs;
			BRPVP_grassCutObjs = BRPVP_grassCutObjs-[objNull];

			//RECALC PLAYERS PATRIMONY
			0 spawn {
				BRPVP_playersPatrimony = call BRPVP_calcPatrimonyOnServerUsingDB;
				publicVariable "BRPVP_playersPatrimony";
			};
		};

		//MASS SAVE
		if (_agora > BRPVP_lastMassSave+BRPVP_massSaveCycle) then {
			BRPVP_lastMassSave = _agora;
			call BRPVP_salvaEmMassa;
		};

		//TERMINATE SERVER WITH BAT FILE
		if (BRPVP_SL_contaD isEqualTo BRPVP_SL_loopsD) then {
			BRPVP_SL_contaD = 0;

			//TURN OFF SERVER
			_salvar = "nada";
			if (BRPVP_useExtDB3) then {_salvar = (call compile ("extDB3" callExtension format ["0:%1:getDbCommand",BRPVP_protocolo])) select 1 select 0 select 0;};
			if (_salvar == "desligar") then {
				0 spawn {
					BRPVP_terminaMissao = true;
					publicVariable "BRPVP_terminaMissao";
					remoteExecCall ["BRPVP_terminaMissaoRun",0];
					remoteExecCall ["BRPVP_saveSimpleObjectsOnDb",2];
					sleep 1;

					private _init = diag_tickTime;
					call BRPVP_salvaEmMassaVeiculosServerOff;
					diag_log format ["[BRPVP RESET SAVE VEH] Save of all vehicles takes %1 seconds!",(round ((diag_tickTime-_init)*10))/10];
					sleep 3;

					profileNamespace setVariable ["BRPVP_SVP_atomicBombHiddenBigFloors",BRPVP_atomicBombHiddenBigFloors];
					if (BRPVP_saveGroundItemsForOneRestart) then {call BRPVP_saveWeaponHoldersOnDB;};
					if (BRPVP_shutdownServerOnRestartTimes) then {BRPVP_serverCommandPassword serverCommand "#shutdown";};
				};
				BRPVP_SL_end = true;
			};

			//CHANGE TIME VELOCITY DAY AND NIGHT
			if (BRPVP_fasterNights) then {
				_speedDown = BRPVP_timeMultiplier/1.6;
				_speedUp = BRPVP_timeMultiplier/0.4;
				if (_speedDown >= 0.1 && _speedUp <= 120) then {
					_dayTime = dayTime;
					if (_dayTime >= 6 && _dayTime <= 18) then {
						if (_speedDown != timeMultiplier) then {setTimeMultiplier _speedDown;};
					} else {
						if (_speedUp != timeMultiplier) then {setTimeMultiplier _speedUp;};
					};
				};
			};

			//GET SPOTED PLAYERS
			BRPVP_SL_spotedPlayers = [];
			BRPVP_spotedPlayersHeadPrice = [];
			{
				if (_x getVariable ["brpvp_player_spoted",0] > 0 && !(_x in BRPVP_playersIntoTheFort) && !isObjectHidden _x) then {
					if ((_x getVariable "brpvp_player_spoted") isEqualTo 2) then {
						BRPVP_spotedPlayersHeadPrice pushBack count BRPVP_SL_spotedPlayers;
						BRPVP_SL_spotedPlayers pushBack [_x,{_this getPos [(random (BRPVP_spotPositionErrorService^2.5))^(1/2.5),random 360]},_x getVariable ["nm","no_name"]];
					} else {
						BRPVP_SL_spotedPlayers pushBack [_x,{_this getPos [(random (BRPVP_spotPositionError^2.5))^(1/2.5),random 360]},_x getVariable ["nm","no_name"]];
					};
				};
			} forEach call BRPVP_playersList;
			{deleteMarker ("PLAYER_SPOTED_DOT_"+str _forEachIndex);} forEach BRPVP_SL_spotedPlayersDelMark;
			BRPVP_SL_spotedPlayersDelMark = [];

			call BRPVP_serverSimulationStuff;
		};

		//SERVER RESTART ON RESTART TIME
		if (BRPVP_SL_contaE isEqualTo BRPVP_SL_loopsE) then {
			BRPVP_SL_contaE = 0;
			_localTime = systemTime select [0,6];
			_localTime params ["_year","_month","_day","_hour","_minute","_secs"];

			_monthTxt = str _month;
			_monthTxt = ("0" select [0,2-count _monthTxt])+_monthTxt;
			_dayTxt = str _day;
			_dayTxt = ("0" select [0,2-count _dayTxt])+_dayTxt;
			_hourTxt = str _hour;
			_hourTxt = ("0" select [0,2-count _hourTxt])+_hourTxt;
			_minuteTxt = str _minute;
			_minuteTxt = ("0" select [0,2-count _minuteTxt])+_minuteTxt;
			BRPVP_dateHourTxt = format ["%1/%2/%3 %4:%5",_year,_monthTxt,_dayTxt,_hourTxt,_minuteTxt];
			publicVariable "BRPVP_dateHourTxt";

			private _remaningHourNum = 24;
			if (BRPVP_restartTimes isNotEqualTo []) then {
				_array = BRPVP_restartTimes apply {if (_x > _hour) then {_x-_hour} else {_x+24-_hour}};
				_array sort true;
				_remaningHourNum = if (_minute isEqualTo 0) then {_array select 0} else {(_array select 0)-1};
				_remaningMinuteNum = if (_minute isEqualTo 0) then {0} else {60-_minute};
				_remaningHour = str _remaningHourNum;
				_remaningMinute = str _remaningMinuteNum;
				if (count _remaningHour isEqualTo 1) then {_remaningHour = "0"+_remaningHour;};
				if (count _remaningMinute isEqualTo 1) then {_remaningMinute = "0"+_remaningMinute;};
				_cronoImage = if (_remaningHourNum > 0) then {"crono.paa"} else {if (_remaningMinuteNum > 30) then {"crono_1h.paa"} else {"crono_30m.paa"};};
				BRPVP_remaningTime = [format ["%1:%2",_remaningHour,_remaningMinute],_cronoImage];
				publicVariable "BRPVP_remaningTime";
				BRPVP_remainingSeconds = (_remaningHourNum*60+_remaningMinuteNum)*60;
				publicVariable "BRPVP_remainingSeconds";
			};

			//SET RAID ON OR OFF
			_weekDay = _localTime call BRPVP_getWeekDay;
			_raidServerIsRaidDay = _weekDay in BRPVP_raidWeekDays && {_hour >= (_x select 0) && _hour < (_x select 1)} count (BRPVP_raidWeekDaysDayHours select _weekDay) > 0;
			if !(_raidServerIsRaidDay isEqualTo BRPVP_raidServerIsRaidDay) then {
				BRPVP_raidServerIsRaidDay = _raidServerIsRaidDay;
				publicVariable "BRPVP_raidServerIsRaidDay";
			};

			if (_remaningHourNum isEqualTo 0) then {
				if (_minute >= 59) then {
					BRPVP_SL_loopsE = 1;
					if (_secs >= 45) then {
						if (!BRPVP_terminaMissao) then {
							0 spawn {
								BRPVP_terminaMissao = true;
								publicVariable "BRPVP_terminaMissao";
								remoteExecCall ["BRPVP_terminaMissaoRun",0];
								remoteExecCall ["BRPVP_saveSimpleObjectsOnDb",2];
								sleep 1;
								
								private _init = diag_tickTime;
								call BRPVP_salvaEmMassaVeiculosServerOff;
								diag_log format ["[BRPVP RESET SAVE VEH] Save of all vehicles takes %1 seconds!",diag_tickTime-_init];
								sleep 2;
								
								_init = diag_tickTime;
								{deleteVehicle _x;} forEach allMissionObjects "";
								diag_log format ["[BRPVP RESET DEL ALL MISS OBJS] Del of all miss objs takes %1 seconds!",diag_tickTime-_init];
								sleep 1;
								
								profileNamespace setVariable ["BRPVP_SVP_atomicBombHiddenBigFloors",BRPVP_atomicBombHiddenBigFloors];
								if (BRPVP_saveGroundItemsForOneRestart) then {call BRPVP_saveWeaponHoldersOnDB;};
								if (BRPVP_shutdownServerOnRestartTimes) then {BRPVP_serverCommandPassword serverCommand BRPVP_serverCommandRestart;};
							};
							BRPVP_SL_end = true;
						};
					} else {
						_minute call BRPVP_SL_doRestartMsg;
					};
				} else {
					if (_minute >= 58) then {
							BRPVP_SL_loopsE = 5;
							_minute call BRPVP_SL_doRestartMsg;
					} else {
						if (_minute >= 29) then {
							BRPVP_SL_loopsE = 20;
							_minute call BRPVP_SL_doRestartMsg;
						};
					};
				};
				if (_minute >= 55 && !BRPVP_SL_timedA) then {
					BRPVP_SL_timedA = true;
					if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {
						-1 remoteExec ["BRPVP_raidTrainingStopMission",2];
					};
				};
			};
		};

		if (BRPVP_SL_contaF isEqualTo BRPVP_SL_loopsF) then {
			BRPVP_SL_contaF = 0;

			//SET DAY BACK TO FULL MOON DAY
			if (BRPVP_fullMoonNights) then {
				if (dayTime >= 12 && !BRPVP_SL_dayOk) then {
					if (random 1 < BRPVP_fullMoonNightsChance) then {
						_date = date;
						setDate [2035,6,10,_date select 3,_date select 4];
					};
					BRPVP_SL_dayOk = true;
				};
				if (dayTime < 12) then {if (BRPVP_SL_dayOk) then {BRPVP_SL_dayOk = false;};};
			};
			
			//UPDATE PVP MARKS
			{("PVP_MARK_B" + str _forEachIndex) setMarkerText call (_x select 2);} forEach BRPVP_PVPAreas;
		};

		//2 SECONDS LOOP
		if (BRPVP_SL_contaG isEqualTo BRPVP_SL_loopsG) then {
			BRPVP_SL_contaG = 0;

			BRPVP_servidorQPS = round (BRPVP_SL_sFpsArray call BRPVP_arrayToFps);
			publicVariable "BRPVP_servidorQPS";
		};

		//ATUALIZA CONTAGEM
		BRPVP_SL_contaA = BRPVP_SL_contaA+1;
		BRPVP_SL_contaB = BRPVP_SL_contaB+1;
		BRPVP_SL_contaC = BRPVP_SL_contaC+1;
		BRPVP_SL_contaD = BRPVP_SL_contaD+1;
		BRPVP_SL_contaE = BRPVP_SL_contaE+1;
		BRPVP_SL_contaF = BRPVP_SL_contaF+1;
		BRPVP_SL_contaG = BRPVP_SL_contaG+1;
		BRPVP_SL_contaH = BRPVP_SL_contaH+1;
	};
};