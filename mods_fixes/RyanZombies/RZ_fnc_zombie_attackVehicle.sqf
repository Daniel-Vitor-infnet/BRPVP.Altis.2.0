RZ_fnc_zombie_attackVehicle = {
	params ["_zombie","_target","_veh","_type"]; 
	_zombie disableAI "MOVE";
	_dir = _zombie getDir _veh;
	_zombie setdir (_zombie getDir _veh);
	[_zombie, "AwopPercMstpSgthWnonDnon_throw"] remoteExecCall ["fnc_RyanZombies_SwitchMove"];
	_pos = getposATL _veh;
	//if (speed _veh < 5) then {_zombie setpos [(_pos select 0) - 4*sin _dir, (_pos select 1) - 4*cos _dir]};
	_attackSound = selectRandom ([_zombie,"attack"] call RZ_fnc_zombie_getZombieSoundArray);
	playsound3d [_attackSound, _zombie, false, getPosASL _zombie, 1, pitch _zombie];
	_target allowfleeing 1;
	_zombie setVariable ["RZ_TargetVehType",_type];
	uiSleep 0.5;
	if ([_zombie,_veh,_type] call RZ_fnc_zombie_canAttackVehicle) then
	{
		//BRPVP CODE INIT
		private _isSimuVeh = _veh getVariable ["id_bd",-1] isNotEqualTo -1 || _veh getVariable ["brpvp_fedidex",false];
		if (_isSimuVeh) then {_veh setVariable ["brpvp_time_can_disable",serverTime+30,2];};
		if (!simulationEnabled _veh) then {[_veh,true] remoteEXecCall ["enableSimulationGlobal",2];};
		//BRPVP CODE END

		_maxDamage = [_zombie,_type] call RZ_fnc_zombie_getMaxVehicleDamage;
		if(_type in ["car","tank"]) then 
		{
			_allHitpointNames = (getAllHitPointsDamage _veh) select 0;
			_amounthitpoints = count _allHitpointNames;
			_exclude = "HitFuel";
			if(_type == "tank") then { _exclude = "HitHull" };
			for "_index" from 0 to (_amounthitpoints - 1) do 
			{
				if (_allHitpointNames select _index != _exclude) then 
				{
					[_veh, [_index, (_veh getHitIndex _index) + random _maxDamage]] remoteExecCall ["fnc_RyanZombies_SetHitIndex"];
				};
			};
		} else {
			_damage = [_zombie,_type] call RZ_fnc_zombie_getMaxVehicleDamage;
			_veh setDamage (damage _veh + _damage);
			if(_type in ["static","ship"]) then 
			{
				_hitSound = selectRandom ([_zombie,"hit"] call RZ_fnc_zombie_getZombieSoundArray);
				playsound3d [_hitSound, _veh, false, getPosASL _veh, 1, pitch _zombie];									
			};	
		};
		if ((getnumber (configfile >> "CfgVehicles" >> typeof _veh >> "armor")) < 90) then 
		{
			if (!canMove _veh) then 
			{
				_aceEnabled = isClass(configFile >> "CfgPatches" >> "ace_medical");
				_aceDamageType = ["vehNormal","vehDemon"] select (_zombie getVariable "RZ_isDemon");
				_normalDamage = [Ryanzombiesdamage/25,0.03] select (_zombie getVariable "RZ_isDemon");	
				{
					if (random 10 < 1) then 
					{
						_scream = selectRandom RZ_HumanScreamArray; 
						[_x, _scream] remoteExecCall ["say3d"];
					};						
					if (_aceEnabled) then 
					{
						[_x,_aceDamageType] execVM "\ryanzombies\acedamage.sqf";
					} else {	
						_x setdamage (damage _x + _normalDamage);
					};
				} foreach crew _veh; 
			};
		};
		_vehicleHit = selectRandom RZ_VehicleHitArray;
		playsound3d [_vehicleHit, _veh, false, getPosASL _veh, 1, 1];
		_vel = velocity _veh;
		_dir = direction _zombie;
		_strength = [_zombie,_type] call RZ_fnc_zombie_getVehicleVelocityStrength;
		_maxZ = [1,2] select (_zombie getVariable "RZ_isDemon");	
		[_veh, [(_vel select 0) + (sin _dir * _strength), (_vel select 1) + (cos _dir * _strength), (_vel select 2) + random _maxZ]] remoteExecCall ["fnc_RyanZombies_Velocity"];
	};
	sleep Ryanzombiesattackspeed;
};