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

//GENERAL CONFIG
_fortCenter = BRPVP_defendFortCenter;
BRPVP_playersIntoTheFort = [];
_rewardCycleTime = 30;
BRPVP_fortDefendRewardCycleSum = 0;
_rewardCount = 0;
_masterRoundCycle = 6;
_masterRoundPause = 30;
_gameWinPause = 300;
_noActivityTimeToEnd = 300;
_noActivityEndDone = true;
_lastActivity = -_noActivityTimeToEnd;
_pCount = 0;
_wave = 1;
_smokes = [];
_smokeOn = false;

//ZOMBIES CONFIG
_zombiesSpawn = +BRPVP_defendFortSpawns;
_spawnPointIndex = 0;
_zombieCycle = 2;
_zombieCut = 1/3;
BRPVP_fortDefendZombieAll = [];

//AI CONFIG
_AISpawn = +BRPVP_defendFortSpawns;
for "_i" from 1 to round (count _AISpawn/2) do {_AISpawn pushBack (_AISpawn deleteAt 0);};
_AIClasses = ["I_C_Soldier_Bandit_4_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_1_F"];
_AISide = INDEPENDENT;
_AICycle = 30;
_AIPerCycle = [3,4];
_AICut = 1/3;
_AIAll = [];
_AIGroupsAll = [];

//WAVES CONFIG
private ["_zombieMaxPerPlayer","_AIMaxPerPlayer","_zombieReward","_AIReward","_zombiePower","_inPercent"];
_waveConfig = [
	{
		_zombieMaxPerPlayer = 5*1.25^8;
		_AIMaxPerPlayer = 1*1.2^8;
		_zombieReward = BRPVP_defendFortZombieReward*1.25^8;
		_AIReward = BRPVP_defendFortAIReward*1.3^8;
		_zombiePower = [4];
		_inPercent = 0.4;
	},
	{
		_zombieMaxPerPlayer = 5*1.25^9;
		_AIMaxPerPlayer = 1*1.2^9;
		_zombieReward = BRPVP_defendFortZombieReward*1.25^9;
		_AIReward = BRPVP_defendFortAIReward*1.3^9;
		_zombiePower = [4,5];
		_inPercent = 0.35;
	},
	{
		_zombieMaxPerPlayer = 5*1.25^10;
		_AIMaxPerPlayer = 1*1.2^10;
		_zombieReward = BRPVP_defendFortZombieReward*1.25^10;
		_AIReward = BRPVP_defendFortAIReward*1.3^10;
		_zombiePower = [5];
		_inPercent = 0.3;
	}
];
call selectRandom _waveConfig;

//LOOP
_init0 = 0;
_initA = 0;
_initB = 0;
_initC = 0;
_initD = 0;
waitUntil {
	_time = time;
	_delta0 = _time-_init0;
	if (_delta0 > 1) then {
		_init0 = _time;
		if (_time-_initA > 5) then {
			_initA = _time;
			_playersIntoTheFort = _fortCenter nearEntities [BRPVP_playerModel,150];
			_playersIntoTheFort = _playersIntoTheFort apply {if (_x getVariable ["brpvp_ve_players",false]) then {-1} else {_x}};
			BRPVP_playersIntoTheFort = _playersIntoTheFort-[-1];
			publicVariableServer "BRPVP_playersIntoTheFort"; 
			_pCount = count BRPVP_playersIntoTheFort min 2;
		};
		if (BRPVP_playersIntoTheFort isEqualTo []) then {
			if (!_noActivityEndDone) then {
				if (_time-_lastActivity > _noActivityTimeToEnd) then {
					_noActivityEndDone = true;
					{if (alive _x) then {_x setVariable ["brpvp_zdel",true,true];};} forEach BRPVP_fortDefendZombieAll;
					{
						if (!isNull _x) then {
							_bomb = createVehicle ["B_20mm",_x modelToWorld [0,0,0],[],0,"CAN_COLLIDE"];
							_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
							_bomb setVelocity [0,0,-100];
							deleteVehicle _x;
							sleep random 0.1;
						};
					} forEach _AIAll;
					BRPVP_fortDefendRewardCycleSum = 0;
					
					//RESET TO WAVE 1
					call selectRandom _waveConfig;
					
					//DELETE SMOKE
					{{deleteVehicle _x;} forEach (_x nearObjects 0);} forEach _smokes;
					_smokeOn = false;
					_smokes = [];
				} else {
					_initB = _initB+_delta0;
					_initC = _initC+_delta0;
					_initD = _initD+_delta0;
				};
			};
		} else {
			if (!_smokeOn) then {
				{
					_smoke = "#particlesource" createVehicle _x;
					_smoke setParticleClass "HouseDestrSmokeLongSmall";
					_smokes pushBack _smoke;
				} forEach BRPVP_defendFortSpawns;
				_smokeOn = true;
			};
			_lastActivity = _time;
			if (_noActivityEndDone) then {
				_noActivityEndDone = false;
				_initB = -100;
				_initC = -100;
				_initD = time;
			};
			if (_time-_initB > _zombieCycle) then {
				if (_initB isEqualTo -100) then {
					{
						[
							_wave,
							{
								"fight" call BRPVP_playSound;
								["<img size='2.0' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\mission\defend_mission_fight.paa' /><br />"+format [localize "str_fdefend_wave_start",_this],0,0.1,3,1,1,4927] call BRPVP_fnc_dynamicText;
							}
						] remoteExecCall ["call",_x];
					} forEach BRPVP_playersIntoTheFort;
				};
				_initB = _time;
				_zombieMax = round (_zombieMaxPerPlayer*_pCount^_zombieCut);
				BRPVP_fortDefendZombieAll = BRPVP_fortDefendZombieAll-[objNull];
				_zombieCount = count BRPVP_fortDefendZombieAll;
				_zombieGap = _zombieMax-_zombieCount;
				if (_zombieGap > 0) then {
					_spawnPointIndex = floor random count _zombiesSpawn;
					_spawnPoint = _zombiesSpawn select _spawnPointIndex;
					_amountZ = _zombieGap min (round (_inPercent*_zombieMax/10) max 1);
					[_spawnPoint,_amountZ,5,_zombiePower,BRPVP_playersIntoTheFort,false,true,_zombieReward] remoteExecCall ["BRPVP_fortDefendSpawnZombieHC",2];
					waitUntil {count BRPVP_fortDefendZombieAll > _zombieCount};
				};
			};
			if (_time-_initC > _AICycle) then {
				_initC = _time;
				_AIMax = round (_AIMaxPerPlayer*_pCount^_AICut);
				_AICount = {alive _x} count _AIAll;
				_AIGap = _AIMax-_AICount;
				if (_AIGap > 0) then {
					_grp = createGroup [_AISide,true];
					_AIGroupsAll pushBack _grp;
					_spawnPos = _AISpawn select _spawnPointIndex;
					_amountAI = _AIGap min (round (_inPercent*_AIMax) max 1);
					for "_i" from 1 to _amountAI do {
						_unit = _grp createUnit [selectRandom _AIClasses,_spawnPos,[],3,"NONE"];
						[_unit] joinSilent _grp;
						_unit setVariable ["brpvp_add_reward",_AIReward];
						_unit addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
						_unit addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
						_unit setSkill 0.35;
						_unit setSkill ["aimingAccuracy",0.15];
						_AIAll pushBack _unit;
					};
					{_grp reveal [_x,1.5]} forEach BRPVP_playersIntoTheFort;
					_wp = _grp addWayPoint [_fortCenter,0];
					_wp setWaypointType "MOVE";
					_wp setWayPointCompletionRadius 50;
				};
				{if !(alive _x || isNull _x) then {deleteVehicle _x;};} forEach _AIAll;
				{if (count units _x isEqualTo 0) then {deleteGroup _x;};} forEach _AIGroupsAll;
				_AIAll = _AIAll-[objNull];
				_AIGroupsAll = _AIGroupsAll-[grpNull];
			};
			if (_time-_initD > _rewardCycleTime) then {
				private ["_image","_sound","_txt"];
				_initD = _time;
				_rewardCount = _rewardCount+1;
				if (_rewardCount isEqualTo _masterRoundCycle) then {
					_image = "defend_mission_time.paa";
					if (_wave isEqualto 10) then {
						_sound = "fanfare";
						_txt = "<br/><t>"+format [localize "str_fort_defend_lvl_completed",_wave]+"</t>";
						_txt = _txt+"<br/><t size='2.0' color='#FF0000'>"+localize "str_fort_defend_win"+"</t>";
					} else {
						_sound = "round_end";
						_txt = "<br/><t>"+format [localize "str_fort_defend_lvl_completed",_wave]+"</t>";
					};
				} else {
					_image = "defend_mission.paa";
					_sound = "round_reward";
					_txt = "";
				};
				_rewardPerplayer = BRPVP_fortDefendRewardCycleSum/sqrt(count BRPVP_playersIntoTheFort);
				_rewardPerPlayer = _rewardPerPlayer*BRPVP_missionValueMult;
				_rewardPerplayer = (ceil _rewardPerplayer/100)*100;
				{
					[
						[_rewardPerplayer,_image,_sound,_txt],
						{
							params ["_valor","_img","_snd","_txt"];
							_snd call BRPVP_playSound;
							["<img size='2.0' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\mission\"+_img+"' /><br/><t>+ $"+str _valor+"</t>"+_txt,0,0.1,3,1,1,4927] call BRPVP_fnc_dynamicText;
							player setVariable ["mny",(player getVariable ["mny",0])+_valor];
							call BRPVP_atualizaDebug;
						}
					] remoteExecCall ["call",_x];
				} forEach BRPVP_playersIntoTheFort;
				BRPVP_fortDefendRewardCycleSum = 0;
				if (_rewardCount isEqualTo _masterRoundCycle) then {
					_init = time;
					{if (alive _x) then {_x setVariable ["brpvp_zdel",true,true];};} forEach BRPVP_fortDefendZombieAll;
					sleep 0.5;
					{
						if (!isNull _x) then {
							_bomb = createVehicle ["B_20mm",_x modelToWorld [0,0,0],[],0,"CAN_COLLIDE"];
							_bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
							_bomb setVelocity [0,0,-100];
							deleteVehicle _x;
							sleep random 0.2;
						};
					} forEach _AIAll;
					_cleanTime = time-_init;
					_rewardCount = 0;

					//PREPARE NEXT WAVE OR END
					if (_wave isEqualto 10) then {
						//RESET TO WAVE 1
						_wave = 1;
						call selectRandom _waveConfig;
						sleep (_gameWinPause-_cleanTime);
					} else {
						//NEXT WAVE
						_wave = _wave+1;
						call selectRandom _waveConfig;
						sleep (_masterRoundPause-_cleanTime);
					};
					_initB = -100;
					_initC = -100;
					_initD = time;
				};
			};
		};
	};
	false
};