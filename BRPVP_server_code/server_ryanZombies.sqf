private _pos = BRPVP_centroMapa;
private _grp = group (missionNamespace getvariable ["BIS_functions_mainscope",objnull]);

private _module1 = _grp createUnit ["RyanZM_ModuleZombieDeletion",_pos,[],0,"CAN_COLLIDE"];
_module1 setPosWorld AGLToASL _pos;
_module1 setVectorDirAndUp [[0,1,0],[0,0,1]];
_module1 setVariable ['Deletion',3,true];
_module1 setVariable ['Deletion2',1,true];
_module1 setVariable ['DeletionRadius',300,true];
_module1 setVariable ['DeletionDemons',3,true];
_module1 setVariable ['DeletionDemons2',1,true];
_module1 setVariable ['DeletionRadiusDemons',300,true];
_module1 setVariable ['DeletionCheckTime',20,true];
_module1 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];

private _module2 = _grp createUnit ["RyanZM_ModuleAbilities",_pos,[],0,"CAN_COLLIDE"];
_module2 setPosWorld AGLToASL _pos;
_module2 setVectorDirAndUp [[0,1,0],[0,0,1]];
_module2 setVariable ['Roaming',1,true];
_module2 setVariable ['Feeding',1,true];
_module2 setVariable ['Jumping',1,true];
_module2 setVariable ['JumpingDemons',1,true];
_module2 setVariable ['Throwing',3,true];
_module2 setVariable ['ThrowingDemons',3,true];
_module2 setVariable ['ThrowingCarAlarms',1,true];
_module2 setVariable ['ThrowingDistance',100,true];
_module2 setVariable ['ThrowingDistanceDemons',100,true];
_module2 setVariable ['ThrowingTank',5,true];
_module2 setVariable ['ThrowingTankDemons',5,true];
_module2 setVariable ['ThrowingTankDistance',50,true];
_module2 setVariable ['ThrowingTankDistanceDemons',50,true];
_module2 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];

private _module3 = _grp createUnit ["RyanZM_ModuleInfected",_pos,[],0,"CAN_COLLIDE"];
_module3 setPosWorld AGLToASL _pos;
_module3 setVectorDirAndUp [[0,1,0],[0,0,1]];
_module3 setVariable ['InfectedChance',0,true];
_module3 setVariable ['InfectedRate',0.1,true];
_module3 setVariable ['Immunity',"[]",true];
_module3 setVariable ['InfectedSymptoms',1,true];
_module3 setVariable ['InfectedDeath',1,true];
_module3 setVariable ['Antivirus',300,true];
_module3 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];

private _module4 = _grp createUnit ["RyanZM_ModuleMovementSpeed",_pos,[],0,"CAN_COLLIDE"];
_module4 setPosWorld AGLToASL _pos;
_module4 setVectorDirAndUp [[0,1,0],[0,0,1]];
_module4 setVariable ['SlowZombies',0.75,true];
_module4 setVariable ['MediumZombies',0.75,true];
_module4 setVariable ['FastZombies',0.75,true];
_module4 setVariable ['DemonZombies',0.75,true];
_module4 setVariable ['SpiderZombies',0.75,true];
_module4 setVariable ['CrawlerZombies',0.75,true];
_module4 setVariable ['WalkerZombies',0.75,true];
_module4 setVariable ['PlayerZombies',0.75,true];
_module4 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];

private _module5 = _grp createUnit ["RyanZM_ModuleSettings",_pos,[],0,"CAN_COLLIDE"];
_module5 setPosWorld AGLToASL _pos;
_module5 setVectorDirAndUp [[0,1,0],[0,0,1]];
_module5 setVariable ['CivilianAttacks',1,true];
_module5 setVariable ['DeleteBodies',2,true];
_module5 setVariable ['DetectionDistance',200,true];
_module5 setVariable ['ExplodingHeads',1,true];
_module5 setVariable ['GlowingEyes',2,true];
_module5 setVariable ['Headshots',1,true];
_module5 setVariable ['Bleeding',1,true];
_module5 setVariable ['Invincibility',1,true];
_module5 setVariable ['Sounds',1,true];
_module5 setVariable ['JumpingSounds',1,true];
_module5 setVariable ['StartingAnim',1,true];
_module5 setVariable ['ZombieScript',1,true];
_module5 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];

_module1 setvariable ["BIS_fnc_initModules_activate",true];
_module2 setvariable ["BIS_fnc_initModules_activate",true];
_module3 setvariable ["BIS_fnc_initModules_activate",true];
_module4 setvariable ["BIS_fnc_initModules_activate",true];
_module5 setvariable ["BIS_fnc_initModules_activate",true];

//CIVIL AND SOLDIER WALKER AND SLOW + SPIDERS
//10 ZOMBIES
BRPVP_rZedsSpawn1 = {
	private _pos = _this;
	private _grp = group (missionNamespace getvariable ["BIS_functions_mainscope",objnull]);

	private _module = _grp createUnit ["RyanZM_ModuleSpawn",_pos,[],0,"CAN_COLLIDE"];
	_module setPosWorld AGLToASL _pos;
	_module setVectorDirAndUp [[0,1,0],[0,0,1]];
	_module setVariable ['Side',1,true];
	_module setVariable ['Type',12,true];
	_module setVariable ['Type2',14,true];
	_module setVariable ['Type3',9,true];
	_module setVariable ['Type4',"[]",true];
	_module setVariable ['Activation',3,true];
	_module setVariable ['Activation2',1,true];
	_module setVariable ['Activation3',1,true];
	_module setVariable ['ActivationRadius',100,true];
	_module setVariable ['AliveAmount',10,true];
	_module setVariable ['TotalAmount',10,true];
	_module setVariable ['Start',0,true];
	_module setVariable ['Frequency',1,true];
	_module setVariable ['Delay',0.25,true];
	_module setVariable ['Density',5,true];
	_module setVariable ['HordeSize',5,true];
	_module setVariable ['Randomize',1,true];
	_module setvariable ["BIS_fnc_initModules_disableAutoActivation",true];

	private _old = _module nearEntities ["CaManBase",50];
	_module setvariable ["BIS_fnc_initModules_activate",true];

	[_module,_old] spawn {
		params ["_module","_old"];
		private _now = [];
		waitUntil {
			{_old pushBackUnique _x;_now pushBack _x} forEach ((_module nearEntities ["CaManBase",10])-_old);
			count _now >= 10
		};
		deleteVehicle _module;
	};
};

//CIVIL AND SOLDIER WALKER AND SLOW + SPIDERS
//20 ZOMBIES
BRPVP_rZedsSpawn2 = {
	private _pos = _this;
	private _grp = group (missionNamespace getvariable ["BIS_functions_mainscope",objnull]);

	private _module = _grp createUnit ["RyanZM_ModuleSpawn",_pos,[],0,"CAN_COLLIDE"];
	_module setPosWorld AGLToASL _pos;
	_module setVectorDirAndUp [[0,1,0],[0,0,1]];
	_module setVariable ['Side',1,true];
	_module setVariable ['Type',12,true];
	_module setVariable ['Type2',14,true];
	_module setVariable ['Type3',9,true];
	_module setVariable ['Type4',"[]",true];
	_module setVariable ['Activation',3,true];
	_module setVariable ['Activation2',1,true];
	_module setVariable ['Activation3',1,true];
	_module setVariable ['ActivationRadius',100,true];
	_module setVariable ['AliveAmount',20,true];
	_module setVariable ['TotalAmount',20,true];
	_module setVariable ['Start',0,true];
	_module setVariable ['Frequency',1,true];
	_module setVariable ['Delay',0.25,true];
	_module setVariable ['Density',7.5,true];
	_module setVariable ['HordeSize',10,true];
	_module setVariable ['Randomize',1,true];
	_module setvariable ["BIS_fnc_initModules_disableAutoActivation",true];

	private _old = _module nearEntities ["CaManBase",50];
	_module setvariable ["BIS_fnc_initModules_activate",true];

	[_module,_old] spawn {
		params ["_module","_old"];
		private _now = [];
		waitUntil {
			{_old pushBackUnique _x;_now pushBack _x} forEach ((_module nearEntities ["CaManBase",10])-_old);
			count _now >= 20
		};
		deleteVehicle _module;
	};
};
//GIVE MONEY FOR KILLED RYAN ZOMBIE
BRPVP_serverEntityKilled = {
	params ["_unit","_killer","_instigator","_useEffects"];
	if (typeOf _unit find "RyanZombie" isEqualTo 0) then {
		if (!isNull _instigator && _instigator call BRPVP_isPlayer) then {
				private _mult = BRPVP_rZedsCfgKillReward/BRPVP_zombieKillRewardBase;
				_mult remoteExecCall ["BRPVP_giveZombieMoneyLocal",_instigator];
				[["zumbi",1]] remoteExecCall ["BRPVP_mudaExp",_instigator];
				"negocio" remoteExecCall ["BRPVP_playSound",_instigator]
		};
	};
};
addMissionEventHandler ["EntityKilled",{call BRPVP_serverEntityKilled;}];