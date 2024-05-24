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

waitUntil {player getVariable ["sok",false] && player getVariable ["dd",false] isEqualTo -1};
ZBL_init = time;
ZBL_lastZombieSpawn = 0;
ZBL_tooMuch = false;
ZBL_dispersionCount = 0;
ZBL_zombieFactorPercentageLast = 0;
ZBL_housesNear = 0;
ZBL_maxBreachsNoRotateBool = 0;
ZBL_nearZombsCount = 0;
ZBL_nearPlayersCount = 1;
addMissionEventHandler ["EachFrame",{call BRPVP_ZBL_code;}];
BRPVP_ZBL_code = {
	private _time = time;
	private _deltaTime = _time - ZBL_init;
	if (_deltaTime > 0.5) then {
		ZBL_init = _time;
		private _iic = player getVariable ["brpvp_in_infected_city",false];
		if (_time-ZBL_lastZombieSpawn > BRPVP_zombieCoolDown && player getVariable ["sok",false] && player call BRPVP_zombieCanSee && !BRPVP_safeZone && !BRPVP_construindo && !surfaceIsWater getPosWorld player) then {
			if (ZBL_dispersionCount isEqualTo 0) then {ZBL_housesNear = ((count nearestObjects [player,["House"],60])-1) max 0;};
			if (ZBL_dispersionCount isEqualTo 1) then {ZBL_hasAntiZombie = count ((nearestObjects [player,BRP_kitReligious+[BRPVP_xpSanctuaryClass],100]) select {_x getVariable ["id_bd",-1] isNotEqualTo -1 || _x getVariable ["azs",false]});};
			if (ZBL_dispersionCount isEqualTo 2) then {ZBL_nearPlayersCount = {player distanceSqr _x < 40000} count call BRPVP_playersList;};

			ZBL_nearZombsCount = count (player nearEntities [BRPVP_zombieMotherClass,200]);
			ZBL_tooMuch = ZBL_nearZombsCount >= (BRPVP_zombieMaxLocalPerPlayer*ZBL_nearPlayersCount) min BRPVP_zombieMaxLocal;

			if (ZBL_housesNear > 0 && BRPVP_isZombieDay) then {
				private _stance = stance player;
				private _speedFactor = [1,0.8] select (speed player > 0);
				private _zAxisFactor = 1-((ASLToAGL getPosASL player select 2) min 8)/8;
				private _zeroFactor = [1,-0.03] select (player getVariable ["dd",-1] > -1);
				private _antiZombieFactor = [1,-1.15] select ZBL_hasAntiZombie;
				private _proneFactor = [1,0.5] select (_stance isEqualTo "CROUCH");
				private _proneFactor = _proneFactor min ([1,-0.15] select (_stance isEqualTo "PRONE"));
				private _eyePos = eyePos player vectorAdd [0,0,[-0.15,0] select (_stance isEqualTo "PRONE")];
				private _securityBreachs = 0;
				private _motorized = vehicle player;
				if (_motorized isEqualTo player) then {
					for "_d" from 0 to 5 do {
						private _angle = ZBL_maxBreachsNoRotateBool*(60/2)+_d*60;
						private _destine = [_eyePos,5,_angle] call BIS_fnc_relPos;
						private _result = lineIntersectsSurfaces [_eyePos,_destine,player,objNull,false,1,"FIRE","VIEW"];
						if (_result isEqualTo []) then {
							if (isNull BRPVP_playerBuilding || {!([ASLToAGL _destine,BRPVP_playerBuilding] call PDTH_pointIsInBox)}) then {
								_securityBreachs = _securityBreachs+1;
							} else {
								_destine = [_eyePos,20,_angle] call BIS_fnc_relPos;
								private _result = lineIntersectsSurfaces [_eyePos,_destine,player,objNull,false,1,"FIRE","VIEW"];
								if (_result isEqualTo []) then {
									if !([ASLToAGL _destine,BRPVP_playerBuilding] call PDTH_pointIsInBox) then {_securityBreachs = _securityBreachs+1;};
								} else {
									if !(_result select 0 select 2 isEqualTo BRPVP_playerBuilding) then {
										if !([ASLToAGL (_result select 0 select 0),BRPVP_playerBuilding] call PDTH_pointIsInBox) then {_securityBreachs = _securityBreachs+1;};
									};
								};
							};
						};
					};
				} else {
					_securityBreachs = if (isEngineOn _motorized) then {3.5} else {1.5};
				};
				ZBL_maxBreachsNoRotateBool = 1-ZBL_maxBreachsNoRotateBool;
				private _securityFactor = (_securityBreachs/6-0.25)*2;
				private _cancel = ZBL_tooMuch || player distance BRPVP_defendFortCenter < 125;
				if (!_cancel) then {
					private _factor = _speedFactor min _securityFactor min _zeroFactor min _antiZombieFactor min _zAxisFactor min _proneFactor;
					BRPVP_zombieFactor = ((BRPVP_zombieFactor+_deltaTime*_factor) max 0) min BRPVP_zombieFactorLimit;
				};
				if (BRPVP_zombieFactor >= BRPVP_zombieFactorLimit || (_iic && !_cancel)) then {
					BRPVP_zombieFactor = 0;
					ZBL_zombieFactorPercentageLast = 0;
					ZBL_lastZombieSpawn = time;
					private _spawnTemplate = selectRandom BRPVP_zombieSpawnTemplate;
					private _spawnBuildings = call BRPVP_spawnZombieCalcHouses;
					private _dist = 60+random 40;
					private _posSpawn = player getPos [_dist,random 360];
					private _needDustCloud = count _spawnBuildings < _spawnTemplate select 0;

					//SPAWN SOUND
					if (_iic) then {
						"zombie_spawn" call BRPVP_playSound;
						"zombie_plus" call BRPVP_playSound;
						["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\zombie_up.paa'/>",0,0,1,0,0,7757] call BRPVP_fnc_dynamicText;
					};
					if (BRPVP_showZombieSpawnHint && !_iic) then {"zombie_spawn" call BRPVP_playSound;};
					
					//SPAWN DUST CLOUD
					if (_needDustCloud) then {
						private _ps1 = "#particlesource" createVehicle _posSpawn;
						private _ps2 = "#particlesource" createVehicle _posSpawn;
						private _ps3 = "#particlesource" createVehicle _posSpawn;
						_ps1 setParticleClass "HouseDestrSmokeLongSmall";
						_ps2 setParticleClass "HouseDestrSmokeLongSmall";
						_ps3 setParticleClass "HouseDestrSmokeLongSmall";
						[4,[_ps1,_ps2,_ps3]] remoteExecCall ["BRPVP_deleteAfterTime",2];
					};

					//SPAWN ZOMBIES
					[_posSpawn,_spawnTemplate,_spawnBuildings,player] remoteExecCall ["BRPVP_spawnZombiesServerFromClient",2];
				};
			} else {
				BRPVP_zombieFactor = (BRPVP_zombieFactor-_deltaTime*0.5) max 0;
			};
		} else {
			BRPVP_zombieFactor = (BRPVP_zombieFactor-_deltaTime*0.5) max 0;
		};
		if (BRPVP_showZombieSpawnHint && !_iic) then {
			BRPVP_zombieFactorPercentage = (round((100*BRPVP_zombieFactor/BRPVP_zombieFactorLimit)/25))*25;
			if (BRPVP_zombieFactorPercentage > ZBL_zombieFactorPercentageLast) then {
				"zombie_plus" call BRPVP_playSound;
				["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\zombie_up.paa'/><br /><t>"+format ["%1%2",BRPVP_zombieFactorPercentage,"%"]+"</t>",0,0,1,0,0,7757] call BRPVP_fnc_dynamicText;
			};
			if (BRPVP_zombieFactorPercentage < ZBL_zombieFactorPercentageLast) then {
				"zombie_minus" call BRPVP_playSound;
				["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\zombie_down.paa'/><br /><t>"+format ["%1%2",BRPVP_zombieFactorPercentage,"%"]+"</t>",0,0,1,0,0,7757] call BRPVP_fnc_dynamicText;
			};
		};
		ZBL_zombieFactorPercentageLast = BRPVP_zombieFactorPercentage;
		if (ZBL_dispersionCount isEqualTo 2) then {ZBL_dispersionCount = 0;} else {ZBL_dispersionCount = ZBL_dispersionCount+1;};
	};
};