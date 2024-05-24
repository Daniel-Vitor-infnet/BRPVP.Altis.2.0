RZ_fnc_zombie_throwVehicleAtTarget = {
	params ["_zombie","_target","_veh","_type"];
	_maxThrowingDistance = -1;
	_throwStrength = -1;
	_maxDistanceToCar = -1;
	_maxThrowingDistanceStr = "";
	_throwStrengthStr = "";
	if(_zombie getVariable "RZ_isDemon") then 
	{
		switch (_type) do
		{
			case "tank":
			{ 
				_maxThrowingDistanceStr = "Ryanzombiescanthrowtankdistancedemon"; 
				_throwStrengthStr = "Ryanzombiescanthrowtankdemonstrength";
				_maxDistanceToCar = 8;
			};
			case "car":
			{ 
				_maxThrowingDistanceStr = "Ryanzombiescanthrowdistancedemon"; 
				_throwStrengthStr = "Ryanzombiescanthrowdemonstrength";
				_maxDistanceToCar = 7;
			};
		};	
	} else {
		switch (_type) do
		{
			case "tank":
			{ 
				_maxThrowingDistanceStr = "Ryanzombiescanthrowtankdistance"; 
				_throwStrengthStr = "Ryanzombiescanthrowtankstrength";
				_maxDistanceToCar = 8;
			};
			case "car":
			{ 
				_maxThrowingDistanceStr = "Ryanzombiescanthrowdistance"; 
				_throwStrengthStr = "Ryanzombiescanthrowstrength";
				_maxDistanceToCar = 7;
			};
		};			
	};
	if(!isNil _maxThrowingDistanceStr) then { _maxThrowingDistance = call compile _maxThrowingDistanceStr; };
	if(!isNil _throwStrengthStr) then { _throwStrength = call compile _throwStrengthStr; };
	_exit = false;
	while {(_veh distance _target < _maxThrowingDistance) && (_zombie distance _veh < _zombie distance _target) && (_veh distance _target < _zombie distance _target) && !_exit} do
	{
		if (!alive _zombie) exitWith {};
		_target = _zombie call RZ_fnc_zombie_checkForNewTarget;
		if (isnull _target) exitWith {};

		if (_zombie distance _veh < _maxDistanceToCar) then
		{
			//BRPVP CODE INIT
			private _isSimuVeh = _veh getVariable ["id_bd",-1] isNotEqualTo -1 || _veh getVariable ["brpvp_fedidex",false];
			if (_isSimuVeh) then {_veh setVariable ["brpvp_time_can_disable",serverTime+30,2];};
			if (!simulationEnabled _veh) then {[_veh,true] remoteEXecCall ["enableSimulationGlobal",2];};
			//BRPVP CODE END

			[_zombie, "AwopPercMstpSgthWnonDnon_throw"] remoteExecCall ["fnc_RyanZombies_SwitchMove"];
			_pos = getposATL _veh;
			_dir = _zombie getDir _veh;
			_zombie setDir _dir;
			//_zombie setpos [(_pos select 0) - 4*sin _dir, (_pos select 1) - 4*cos _dir];
			_attackSound = selectRandom ([_zombie,"attack"] call RZ_fnc_zombie_getZombieSoundArray);
			playsound3d [_attackSound, _zombie, false, getPosASL _zombie, 1, pitch _zombie];
			sleep 0.3;
			if (!alive _zombie) exitWith {};
			//_speed = 20 + random 25;
			_speed = 20 + random 10;
			_dir = _veh getDir _target;
			_range = _veh distance _target;
			switch (_throwStrength) do 
			{
				case -1:	{ [_veh, [_speed * (sin _dir), _speed * (cos _dir), 5 * (_range / _speed)]] remoteExecCall ["fnc_RyanZombies_Velocity"]; };
				case 1: 	{ [_veh, [(_speed * (sin _dir))/1.5, (_speed * (cos _dir))/1.5, 3.5 * (_range / _speed)]] remoteExecCall ["fnc_RyanZombies_Velocity"]; };
				case 2: 	{ [_veh, [(_speed * (sin _dir))/2, (_speed * (cos _dir))/2, 2.5 * (_range / _speed)]] remoteExecCall ["fnc_RyanZombies_Velocity"]; };
				case 3: 	{ [_veh, [(_speed * (sin _dir))/3.5, (_speed * (cos _dir))/3.5, (_range / _speed)]] remoteExecCall ["fnc_RyanZombies_Velocity"]; };
				case 4: 	{ [_veh, [(_speed * (sin _dir))*5, (_speed * (cos _dir))*5, (_range / _speed)]] remoteExecCall ["fnc_RyanZombies_Velocity"]; };
			};
			_throwSound = selectRandom RZ_VehicleThrowArray;
			playsound3d [_throwSound, _veh, false, getPosASL _veh, 1, 1];
			_veh setfuel 0; 
			[_veh, _type] remoteExec ["RZ_fnc_vehicleLand"];
			sleep Ryanzombiesattackspeed;
			_exit = true;
		};
		if(_exit) exitWith {};
		if !(local _zombie) then 
		{
			[_zombie, getposATL _veh] remoteExecCall ["fnc_RyanZombies_DoMoveLocalized"];
		} 
		else		
		{
			_zombie domove getposATL _veh;
		};
		_x = (0.5 + ((_zombie distance _veh)/50)) min 4;
		sleep _x;
	};	
};
