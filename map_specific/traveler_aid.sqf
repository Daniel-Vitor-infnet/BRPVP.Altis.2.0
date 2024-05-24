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

//TRAVEL AID PLACES
_reference = [13712.8,16707.7,28.4042];
if (isServer) then {
	BRPVP_travelingAidObjsToDel = [];
	BRPVP_travelingAidTraders = [];
	{
		_x params ["_center","_radius","_name"];
		_diference = _center vectorDiff _reference;
		_diference set [2,0];
		{
			_pos = ASLToAGL (_x select 0 select 0);
			_pos = AGLToASL (_pos vectorAdd _diference);
			_vdu = _x select 0 select 1;
			_class = _x select 1;
			_simpleObject = _x select 2;
			_code = _x select 3;
			call _code;
		} forEach [
			[[[13717.3,16684.3,16.6168],[[0.480373,0.877064,0],[0,0,1]]],"Land_Atm_01_F",false,{_posTrader = ASLToAGL _pos;_posTrader set [2,0];BRPVP_travelingAidTraders pushBack [[_posTrader,8,215-90] call BIS_fnc_relPos,215]}]
		];
	} forEach BRPVP_travelingAidPlaces;
};
{
	_x params ["_center","_radius","_name"];
	_diference = _center vectorDiff _reference;
	_diference set [2,0];
	{
		_pos = ASLToAGL (_x select 0 select 0);
		_pos = AGLToASL (_pos vectorAdd _diference);
		_vdu = _x select 0 select 1;
		_class = _x select 1;
		_simpleObject = _x select 2;
		_code = _x select 3;
		_obj = if (_simpleObject) then {createSimpleObject [_class,[0,0,0],true]} else {_class createVehicleLocal [0,0,0]};
		_obj setPosWorld _pos;
		_obj setVectorDirAndUp _vdu;
		_obj allowDamage false;
		_obj call _code;
		if (isServer) then {BRPVP_travelingAidObjsToDel pushBack _obj;};
	} forEach [
		[[[13717,16683.8,17.7349],[[0.53196,0.846769,0],[0,0,1]]],"Land_PartyTent_01_F",true,{_this setVectorUp surfaceNormal getPosWorld _this;}],
		[[[13717.3,16684.3,16.6168],[[0.480373,0.877064,0],[0,0,1]]],"Land_Atm_01_F",false,{_this setVectorUp surfaceNormal getPosWorld _this;}],
		[[[13712.8,16707.7,21.4042],[[-0.545174,-0.838323,0],[0,0,1]]],"Land_SCF_01_storageBin_small_F",false,{}],
		[[[13692.8,16701.8,26.9985],[[0.3122,0.950016,0],[0,0,1]]],"Land_LampAirport_F",false,{}],
		[[[13732.7,16712.7,27.6062],[[-0.469819,-0.882763,0],[0,0,1]]],"Land_LampAirport_F",false,{}],
		[[[13712.4,16683.7,15.6628],[[-0.826991,0.562215,0],[0,0,1]]],"Land_Bench_04_F",true,{}],
		[[[13715.3,16688,15.7318],[[-0.860971,0.508653,0],[0,0,1]]],"Land_Bench_04_F",true,{}],
		[[[13707.6,16741.4,38.0159],[[-0.877427,0.47971,0],[0,0,1]]],"Land_TTowerBig_2_F",false,{}],
		[[[13733,16708.4,17.2663],[[-0.495917,-0.86837,0],[0,0,1]]],"Land_Grave_obelisk_F",false,{}],
		[[AGLToASL ((ASLToAGL [13568.7,20560.5,39.0748]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[-0.833289,0.552838,0],[0,0,1]]],"Land_Tank_rust_F",false,{}],
		[[AGLToASL ((ASLToAGL [13629.3,20518.1,37.9136]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[0.538785,0.842444,0],[0,0,1]]],"Land_LampHarbour_F",false,{}],
		[[AGLToASL ((ASLToAGL [13565.4,20555.3,40.4265]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[0.548308,0.836276,0],[0,0,1]]],"Land_LampHarbour_F",false,{}],
		[[AGLToASL ((ASLToAGL [13636.0,20511.7,35.6111]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[-0.863082,0.505064,0],[0,0,1]]],"WaterPump_01_sand_F",false,{}],
		[[AGLToASL ((ASLToAGL [13636.0,20520.4,37.2710]) vectorAdd [13712.8-13623,16707.7-20571,0]),[[0.840244,-0.542208,0],[0,0,1]]],"Land_FuelStation_02_workshop_F",false,{}]
	];
} forEach BRPVP_travelingAidPlaces;
if (isServer) then {
	0 spawn {
		waitUntil {!isNil "BRPVP_serverBelezinha"};
		{deleteVehicle _x;} forEach BRPVP_travelingAidObjsToDel;
	};
};