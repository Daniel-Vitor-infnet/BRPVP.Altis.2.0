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

//TEMP WEAK AI ALL AROUND
private _uniforms = ["U_NikosBody","U_OrestesBody","U_Rangemaster","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour","U_C_Poloshirt_stripped","U_C_Poloshirt_burgundy","U_C_Man_casual_1_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F"];
private _caps = ["H_Bandanna_mcamo","H_Bandanna_surfer","H_Hat_blue","H_Hat_tan","H_StrawHat_dark","H_Bandanna_surfer_grn","H_Cap_surfer"];
private _weapons = ["arifle_MX_ACO_F","SMG_01_Holo_F","LMG_Mk200_MRCO_F","LMG_Mk200_MRCO_F","hgun_PDW2000_F","LMG_Zafir_pointer_F","hgun_ACPC2_F","hgun_Pistol_heavy_02_Yorris_F","arifle_Katiba_ACO_F","arifle_Mk20C_ACO_F","SMG_01_Holo_F","LMG_Mk200_MRCO_F","hgun_PDW2000_F","hgun_Pistol_heavy_02_Yorris_F","arifle_Mk20C_ACO_F"];
private _bags = ["B_Carryall_oli","B_Carryall_oucamo","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo"];
private _vests = ["V_TacVest_blk_POLICE","V_PlateCarrier_Kerry","V_PlateCarrierIA2_dgtl","V_PlateCarrier2_rgr"];
private _selected = [];
private _tAiPlaces = BRPVP_tAiPlaces select {private _plc = _x;(nearestObjects [_x,["FlagCarrier"],300,true] select {_x getVariable ["id_bd",-1] isNotEqualTo -1}) isEqualTo [] && ({(_x select 0) distance2D _plc <= (_x select 1)} count BRPVP_safeZonesOtherMethod isEqualTo 0)};
for "_i1" from 1 to BRPVP_tAiMaxLocals do {
	private _places = _tAiPlaces-_selected;
	if (_places isEqualTo []) then {
		break
	} else {
		private _plc = selectRandom _places;
		private _grp = createGroup [BLUFOR,true];
		private _spawn = (_plc getPos [30,random 360]) findEmptyPosition [0,100,"C_Quadbike_01_F"];
		_selected pushBack _plc;
		for "_i2" from 1 to selectRandom BRPVP_tAiGroupChance do {
			private _survivor = _grp createUnit ["B_Soldier_F",_spawn,[],0,"NONE"];
			[_survivor] joinSilent _grp;

			//REMOVE GEAR
			removeAllAssignedItems _survivor;
			removeBackpackGlobal _survivor;
			removeUniform _survivor;
			removeVest _survivor;
			removeHeadGear _survivor;
			removeGoggles _survivor;
			{_survivor removeWeapon _x;} forEach weapons _survivor;

			//ADD GEAR
			_survivor forceAddUniform selectRandom _uniforms;
			_survivor addBackpack selectRandom _bags;
			if (random 1 < 0.35) then {_survivor addVest selectRandom _vests;};
			if (random 1 < 0.90) then {_survivor addWeapon selectRandom _weapons;};
			if (random 1 < 0.10) then {_survivor addWeapon "launch_NLAW_F";_survivor addMagazine "NLAW_F";};
			[_survivor] call BRPVP_fillUnitWeapons;

			//SET SKILL AND RATING
			_survivor setSkill 0.5;
			_survivor setSkill ["aimingAccuracy",0.15];
			_survivor allowFleeing 0.5;
			//_survivor setCaptive true;

			//ADD EVENT HANDLERS
			_survivor addEventHandler ["HandleDamage",{call BRPVP_hdEh}];
			_survivor addEventHandler ["Killed",{
				if (random 1 < 0.75) then {
					private _ai = _this select 0;
					private _sp = ASLToAGL getPosASL _ai vectorAdd [0,0,1.25];
					private _sc = createVehicle ["Land_Suitcase_F",_sp,[],1.25,"CAN_COLLIDE"];
					_sc setVariable ["mny",round (selectRandom [50000,50000,75000,100000,125000,200000]*BRPVP_missionValueMult),true];
				};
				call BRPVP_botDaExp;
			}];
			_survivor setVariable ["brpvp_ai",true,true];
			BRPVP_noShowBots pushBack _survivor;
		};
		_heading = random 360;
		_pos1 = _plc getPos [50,_heading];
		_pos2 = _plc getPos [50,_heading+180];
		_pos1FEP = _pos1 findEmptyPosition [0,100,"C_Quadbike_01_F"];
		_pos2FEP = _pos2 findEmptyPosition [0,100,"C_Quadbike_01_F"];
		_pos1 = if (_pos1FEP isEqualTo []) then {_pos1} else {_pos1FEP};
		_pos2 = if (_pos2FEP isEqualTo []) then {_pos2} else {_pos2FEP};
		_wp = _grp addWayPoint [_pos1,0];
		_wp setWaypointCompletionRadius 5;
		_wp setWayPointType "MOVE";
		_wp = _grp addWayPoint [_pos2,0];
		_wp setWaypointCompletionRadius 5;
		_wp setWayPointType "MOVE";
		_wp = _grp addWayPoint [_pos1,0];
		_wp setWaypointCompletionRadius 5;
		_wp setWayPointType "CYCLE";
	};
};
BRPVP_noShowBots = BRPVP_noShowBots-[objNull];
publicVariable "BRPVP_noShowBots";