RZ_fnc_zombie_engageTarget = {
	params ["_zombie","_target"];
	_zombie setVariable ["RZ_TargetVehType",""];
	if (!isNull _target) then
	{
		if (((getPosATL _target select 2) > 20) AND (_target iskindof "AIR")) exitwith {sleep 2};
		if (animationState _zombie == "UNCONSCIOUS") exitwith {sleep 2};
		if (_zombie distance _target > Ryanzombieslimit) exitwith {sleep 2};
		
		if (!(vehicle _target iskindof "man") && (count crew (vehicle _target) == 0)) exitWith // if target is an empty vehicle
		{
			(vehicle _target) call RZ_fnc_NeutralizeVehicle;
		};

		if (local _zombie) then 
		{
			_zombie domove getposATL _target;
		} else {
			[_zombie, getposATL _target] remoteExecCall ["fnc_RyanZombies_DoMoveLocalized"];
		};
		
		if (surfaceIsWater getposATL _target) then 
		{
			[_zombie, "AmovPercMwlkSnonWnonDf"] remoteExecCall ["fnc_RyanZombies_PlayMoveNow"];
		};
		_zombie dowatch _target;
		
		_feedModuleName = ["Ryanzombiesfeed","Ryanzombiesfeeddemon"] select (_zombie getVariable "RZ_isDemon");
		_jumpModuleName = ["Ryanzombiesjump","Ryanzombiesjumpdemon"] select (_zombie getVariable "RZ_isDemon");
		_throwCarModuleName = ["Ryanzombiescanthrow","Ryanzombiescanthrowdemon"] select (_zombie getVariable "RZ_isDemon");
		_throwTankModuleName = ["Ryanzombiescanthrowtank","Ryanzombiescanthrowtankdemon"] select (_zombie getVariable "RZ_isDemon");

		_exit = false;
		if ((vehicle _target iskindof "man") && [_zombie,_target] call RZ_fnc_zombie_canAttackHuman) then
		{
			[_zombie,_target] call RZ_fnc_zombie_attackHuman;
			
			if((alive _target) OR (isnil _feedModuleName)) then 
			{
				_exit = true;
			};	
		};
		
		if(_exit) exitWith {};
		
		if(isNull _target || !alive _zombie) exitWith {};	
		// although I don't like how messy these conditions look, they allow for rapid target re-acquirement if the old target becomes a null & also quick exit of script upon zombie death

		//BRPVP CODE INIT
		private _pZ = eyePos _zombie;
		private _targetVehicle = vehicle _target;
		private _vec = vectorNormalized (getPosWorld _target vectorDiff _pZ) vectorMultiply 2.5;
		private _lis = lineIntersectsSurfaces [_pZ,_pZ vectorAdd _vec,_zombie];
		private _distOk = !(_lis isEqualTo []) && {_lis select 0 select 2 isEqualTo _target};
		private _run = false;
		//BRPVP CODE END

		if (_distOk) then {
			if (_targetVehicle iskindof "car") exitWith {
				[_zombie,_target,_targetVehicle,"car"] call RZ_fnc_zombie_attackVehicle;
				_run = true;
			};
			if (_targetVehicle iskindof "tank") exitWith {
				[_zombie,_target,_targetVehicle,"tank"] call RZ_fnc_zombie_attackVehicle;
				_run = true;
			};
			if ((_targetVehicle iskindof "air") && ((getPosATL _target select 2) < 1.8)) exitWith {
				[_zombie,_target,_targetVehicle,"air"] call RZ_fnc_zombie_attackVehicle;
				_run = true;
			};
			if (_targetVehicle iskindof "staticweapon") exitWith {
				[_zombie,_target,_targetVehicle,"static"] call RZ_fnc_zombie_attackVehicle;
				_run = true;
			};
			if (_targetVehicle iskindof "ship") exitWith {
				[_zombie,_target,_targetVehicle,"ship"] call RZ_fnc_zombie_attackVehicle;
				_run = true;
			};
		};
		if (_run) exitWith {};

		_zombie call RZ_fnc_zombie_AggressiveSound;

		_interval = (0.5 + ((_zombie distance _target)/50)) min 4;
		sleep _interval;
		
		if(isNull _target || !alive _zombie) exitWith {};				
		
		
		if (!(isnil _jumpModuleName)) then // a 'then' instead of 'exitWith' means zombies can immediately do another below action after performing the last
		{		
			_minimumJumpingDistance = 45;
			if ((_zombie distance _target > _minimumJumpingDistance)  && (alive _target) && (!surfaceIsWater getposATL _zombie) && (random 15 < 1)) then
			{		
				[_zombie,_target] call RZ_fnc_zombie_jumpToTarget; // this function blocks until zombie has landed again
			};	
		};			

		if(isNull _target || !alive _zombie) exitWith {};	
		
		// meaning zombie can immediately throw a car after landing (combos!)
		if (!isnil _throwCarModuleName) then
		{
			_vehicle = nearestObject [_zombie, "car"]; 
			if ((_vehicle iskindof "car") && (random 7 < 1)) then
			{
				[_zombie,_target,_vehicle,"car"] call RZ_fnc_zombie_throwVehicleAtTarget;
			};
		};		
		
		if(isNull _target || !alive _zombie) exitWith {};	
		
		
		if (!isnil _throwTankModuleName) then
		{
			_vehicle = nearestObject [_zombie, "tank"]; 
			if ((_vehicle iskindof "tank") && (random 7 < 1)) then
			{
				[_zombie,_target,_vehicle,"tank"] call RZ_fnc_zombie_throwVehicleAtTarget;
			};
		};		
		
		if(isNull _target || !alive _zombie) exitWith {};		

		if (!alive _target && !(isnil _feedModuleName)) exitWith
		{
			[_zombie,_target] call RZ_fnc_zombie_feedOnTarget;
		};
	};
};	