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

private _insuCenter = [15094.4,16735.5,18.3384];
{
	private _center = AGLToASL (_x select 0);
	private _fix = _center vectorDiff _insuCenter;
	{
		_x params ["_class","_pw","_vdu","_complete",["_code",{}]];
		private _obj = if (_complete) then {_class createVehicleLocal [0,0,0]} else {createSimpleObject [_class,[0,0,0],true]};
		private _pos = _pw vectorAdd _fix;
		_pos set [2,0];
		_obj setVectorDirAndUp _vdu;
		_obj setPosASL AGLToASL _pos;
		_obj call _code;
	} forEach [
		["Land_Sign_WarningNoWeapon_F",[15088.3,16727.3,19.5],[[0.71,0.71,0],[0,0,1]],false],
		["Land_ConcreteWall_02_m_2m_F",[15079.4,16736.7,19.37],[[-0.71,-0.71,0],[0,0,1]],false],
		["Land_ConcreteWall_02_m_2m_F",[15083.5,16732.6,19.37],[[-0.71,-0.71,0],[0,0,1]],false],
		["Land_ConcreteWall_02_m_4m_F",[15088.4,16727.7,19.37],[[0.71,0.71,0],[0,0,1]],false],
		["Land_ConcreteWall_02_m_4m_F",[15081.5,16734.6,19.37],[[-0.71,-0.71,0],[0,0,1]],false],
		["Land_HelipadSquare_F",[15084.6,16761.4,17.91],[[0.71,0.71,0],[0,0,1]],false],
		["Land_HelipadSquare_F",[15071.1,16748,17.91],[[0.71,0.71,0],[0,0,1]],false],
		["Land_ConcreteWall_02_m_8m_F",[15086.9,16745.9,19.37],[[-0.71,0.71,0],[0,0,1]],false],
		["Land_ConcreteWall_02_m_8m_F",[15081.2,16740.3,19.37],[[-0.71,0.71,0],[0,0,1]],false],
		["Land_HelipadSquare_F",[15104.9,16714.4,17.94],[[0.71,0.71,0.01],[-0.01,-0.01,1]],false],
		["Land_HelipadSquare_F",[15118.4,16727.7,17.99],[[0.71,0.71,-0.02],[0.03,0,1]],false],
		["Land_ConcreteWall_02_m_8m_F",[15109.4,16734.6,19.37],[[-0.71,0.71,0],[0,0,1]],false],
		["Land_ConcreteWall_02_m_8m_F",[15103.8,16729,19.37],[[-0.71,0.71,0],[0,0,1]],false],
		["Land_Shed_Small_F",[15101,16743.1,20.59],[[0.71,-0.71,0],[0,0,1]],false],
		["Land_HelipadSquare_F",[15106.4,16762.9,17.91],[[-0.71,-0.71,0.01],[0,0.01,1]],false],
		["Land_HelipadSquare_F",[15119.7,16749.4,17.45],[[-0.71,-0.71,0.02],[0.06,-0.03,1]],false],
		["Land_ConcreteWall_02_m_8m_F",[15092.5,16751.6,19.37],[[-0.71,0.71,0],[0,0,1]],false]
	];
} forEach BRPVP_insurancePlaces;

if (isServer) then {
	{
		private _center = AGLToASL (_x select 0);
		private _fix = _center vectorDiff _insuCenter;
		{
			_x params ["_class","_pw","_vdu","_complete",["_code",{}]];
			private _obj = if (_complete) then {_class createVehicle [0,0,0]} else {createSimpleObject [_class,[0,0,0]]};
			private _pos = _pw vectorAdd _fix;
			_pos set [2,0];
			_obj setVectorDirAndUp _vdu;
			_obj setPosASL AGLToASL _pos;
			_obj call _code;
		} forEach [
			["Land_Wreck_Slammer_F",[15095.3,16747.1,19.92],[[0.71,0.71,0],[0,0,1]],false],
			["Land_Wreck_MBT_04_F",[15100.2,16741.2,19.64],[[0.71,0.71,0],[0,0,1]],false],
			["Land_Wreck_Hunter_F",[15105.4,16736.8,20.33],[[0.71,0.71,0],[0,0,1]],false],
			["Land_GuardHouse_01_F",[15094,16726.2,19.62],[[-0.71,0.71,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
			["Land_LampDecor_F",[15089.8,16727,20.79],[[-0.71,0.71,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
			["Land_LampDecor_F",[15078.9,16737.4,20.64],[[0.71,-0.71,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
			["Land_PipeFence_01_m_gate_v2_F",[15085.6,16730.5,18.87],[[0.71,0.71,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
			["Land_PipeFence_01_m_gate_v1_F",[15090.5,16725.6,19.02],[[0.71,0.71,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}]
		];

		//TRADER
		private _pos = [15094.8,16730.8,0.1] vectorAdd _fix;
		_pos set [2,0];
		private _trader = createAgent ["O_V_Soldier_hex_F",_pos,[],0,"CAN_COLLIDE"];
		private _lis = lineIntersectsSurfaces [eyePos _trader,eyePos _trader vectorAdd [0,0,-10],_trader,objNull,true,1,"GEOM","NONE"];
		if (_lis isNotEqualTo []) then {_trader setPosASL (_lis select 0 select 0);};
		_trader setDir 320;
		[_trader,false] remoteExecCall ["allowDamage",0];
		_trader setCaptive true;
		_trader disableAI "ALL";
		_trader removeWeapon primaryWeapon _trader;
		_trader removeWeapon handgunWeapon _trader;
		[_trader,""] remoteExecCall ["switchMove",0];
		_trader enableSimulationGlobal false;
		_code = {
			_this addAction [localize "str_insurance_action_trader",{call BRPVP_insuranceTraderMenu;},[],1.49,false];
			_this addAction [localize "str_insurance_action_trader_drone",{call BRPVP_insuranceTraderMenuDrone;},[],1.49,false];
			_this addAction [localize "str_insurance_action_receive",{call BRPVP_insuranceGetVehicle;},[],1.49,false];
		};
		[_trader,_code] remoteExecCall ["call",BRPVP_allNoServer,true];
	} forEach BRPVP_insurancePlaces;
};