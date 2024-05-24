private _units = [];
{
	private _posAGL = _x select 0;
	private _rad = _x select 1;
	private _aiCount = _x select 6;
	for "_i1" from 1 to 1 do {
		private _grp = createGroup [INDEPENDENT,true];
		private _spawn = _posAGL findEmptyPosition [0,_rad*0.5 min 50,"B_Soldier_F"];
		if (_spawn isEqualTo []) then {_spawn = _posAGL;};
		for "_i2" from 1 to _aiCount do {
			private _class = selectRandom ["I_L_Hunter_F","I_L_Criminal_SG_F","I_L_Criminal_SMG_F","I_L_Looter_SG_F","I_L_Looter_Rifle_F","I_L_Looter_SMG_F"];
			private _unit = _grp createUnit [_class,_spawn,[],5,"NONE"];
			[_unit] joinSilent _grp;
			_unit setVariable ["brpvp_can_ulfanize",false,2];
			_unit setSkill 0.35;
			_unit setSkill ["aimingAccuracy",0.15];
			_unit addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_unit addEventHandler ["Killed",{
				if (random 1 < 0.75) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (500000*BRPVP_missionValueMult),true];};
				call BRPVP_botDaExp;
			}];
			if (goggles _unit isNotEqualTo "") then {removeGoggles _unit;};
			_unit addGoggles selectRandom BRPVP_CbrnMasks;
			if (random 1 < 0.75) then {
				private _uCargo = (uniformContainer _unit) call BRPVP_getCargoArray;
				removeUniform _unit;
				_unit addUniform selectRandom BRPVP_CbrnSuits;
				[uniformContainer _unit,_uCargo] call BRPVP_putItemsOnCargo;
				if (random 1 < 0.25) then {removeGoggles _unit;};
			};
			if (random 1 < 0.5) then {
				private _bag = selectRandom ["B_Carryall_oli","B_Carryall_oucamo","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_ocamo"];
				_unit addBackpack _bag;
				_unit addWeapon "launch_NLAW_F";
				_unit addMagazine "NLAW_F";
				_unit addMagazine "NLAW_F";
			} else {
				if (goggles _unit isNotEqualTo "") then {_unit addBackpack "B_SCBA_01_F";};
			};
			if (random 1 < 0.250) then {_unit setVariable ["brpvp_alt_i_items",[[BRPVP_specialItems find "BRPVP_kriptonite",1]],true];};
			if (random 1 < 0.050) then {_unit setVariable ["brpvp_alt_i_items",[[BRPVP_specialItems find "BRPVP_kriptoniteRed",1]],true];};
			if (random 1 < 0.001) then {_unit setVariable ["brpvp_alt_i_items",[[BRPVP_specialItems find "BRPVP_divineFire",1]],true];};
			_units pushBack _unit;
		};
		_heading = random 360;
		_pos1 = [_posAGL,_rad,_heading] call BIS_fnc_relPos;
		_pos2 = [_posAGL,_rad,_heading+180] call BIS_fnc_relPos;
		_pos1FEP = _pos1 findEmptyPosition [0,15,"C_man_1"];
		_pos2FEP = _pos2 findEmptyPosition [0,15,"C_man_1"];
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
} forEach BRPVP_radioAreas;
_units remoteExecCall ["BRPVP_updateAIUnitsArray",2];