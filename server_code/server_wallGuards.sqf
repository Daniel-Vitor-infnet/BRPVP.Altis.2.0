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

_units = [];
{
	for "_i1" from 1 to 1 do {
		_grp = createGroup [BLUFOR,true];
		_spawn = [_x,5,random 360] call BIS_fnc_relPos findEmptyPosition [0,30,"B_Soldier_F"];
		_squad = selectRandom BRPVP_missionWestGroups;
		for "_i2" from 1 to 3 do {
			_unit = _grp createUnit [selectRandom _squad,_spawn,[],5,"NONE"];
			[_unit] joinSilent _grp;
			_unit setSkill (BRPVP_AISkill select 8 select 0);
			_unit setSkill ["aimingAccuracy",BRPVP_AISkill select 8 select 1];
			_unit addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_unit addEventHandler ["Killed",{
				if (random 1 < 0.5) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (100000*BRPVP_missionValueMult),true];};
				call BRPVP_botDaExp;
			}];
			_units pushBack _unit;
		};
		_heading = random 360;
		_pos1 = [_x,20,_heading] call BIS_fnc_relPos;
		_pos2 = [_x,20,_heading+180] call BIS_fnc_relPos;
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
} forEach [
	[17277.4,17911.4,0],
	[17033.5,17470.5,0],
	[16627.6,16744.3,0],
	[16234.8,16038.0,0],
	[16375.7,16290.8,0]
];

//CHG
_units remoteExecCall ["BRPVP_updateAIUnitsArray",2];