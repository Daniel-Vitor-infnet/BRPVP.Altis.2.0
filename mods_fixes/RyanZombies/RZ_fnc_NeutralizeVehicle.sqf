RZ_fnc_NeutralizeVehicle = {
	private _veh = _this;
	_grp = createGroup civilian;
	_unit = _grp createUnit ["C_Man_1",[0,0,0],[],0,"CAN_COLLIDE"];
	[_grp,_unit,_veh] spawn {
		params ["_grp","_unit","_veh"];
		_unit allowDamage false;
		[_unit,true] remoteExecCall ["hideObjectGlobal",2];
		_unit moveInDriver _veh;
		uiSleep 0.25;
		_veh deleteVehicleCrew _unit;
		uiSleep 0.25;
		deletegroup _grp;
	};
};
