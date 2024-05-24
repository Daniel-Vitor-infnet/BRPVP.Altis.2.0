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

BRPVP_corruptMissSpawn = {
	_rnd = (BRPVP_mapaRodando select 21 select 1) call BIS_fnc_selectRandom;
	_center = _rnd select 0;
	_radius = _rnd select 1;
	if (count _this isEqualTo 3) then {
		_center = _this;
		_radius = 10;
	};
	_clues = [
		"Land_HandyCam_F",
		"Land_Compass_F",
		"Land_Photos_V1_F",
		"Land_Map_unfolded_F",
		"Land_File2_F",
		"Land_MobilePhone_smart_F",
		"Land_BottlePlastic_V1_F",
		"Land_Can_Dented_F",
		"Land_Notepad_F",
		"Land_Can_V2_F"
	];
	_spwPosAll = [
		[(BRPVP_mapaDimensoes select 0)/2,0,0],
		[BRPVP_mapaDimensoes select 0,0,0],
		[0,(BRPVP_mapaDimensoes select 1)/2,0],
		[0,BRPVP_mapaDimensoes select 1,0],
		BRPVP_mapaDimensoes+[0],
		[BRPVP_mapaDimensoes select 0,(BRPVP_mapaDimensoes select 1)/2,0],
		[(BRPVP_mapaDimensoes select 0)/2,BRPVP_mapaDimensoes select 1,0]
	];
	_spwPosAll = _spwPosAll apply {
		_v1 = vectorNormalized (_x vectorDiff _center);
		_onLand = 0;
		for "_i" from 0 to 19 do {
			_p = _center vectorAdd (_v1 vectorMultiply (_i*50));
			_onLand = _onLand+(if (!surfaceIsWater _p) then {1} else {0});
		};
		[_onLand,_x]
	};
	_spwPosAll sort false;
	_spwPos = ([_spwPosAll,3.5] call LOL_fnc_selectRandomFator) select 1;
	_grp = createGroup [CIVILIAN,true];
	_bMan = _grp createUnit ["C_Nikos_aged",BRPVP_spawnAIFirstPos,[],0,"NONE"];
	[_bMan] joinSilent _grp;
	_bMan addEventHandler ["HandleDamage",{
		params ["_unit","_part","_damage","_ofensor"];
		if (_ofensor isEqualTo _unit || isNull _ofensor) then {_damage = if (_part isEqualTo "") then {damage _unit} else {_unit getHit _part};};
		_damage
	}];
	_bMan addEventHandler ["Killed",{
		params ["_unit","_ofensor"];
		_suitCase = createVehicle ["Land_Suitcase_F",getPos _unit,[],2,"NONE"];
		_suitCase setVariable ["mny",round ((BRPVP_mapaRodando select 21 select 4)*BRPVP_missionValueMult),true];
		_unit setVariable ["sc",_suitCase];
		_unit setVariable ["dd",1,true];
	}];
	_bMan addRating -20000;
	{_bMan removeMagazine _x;} forEach  magazines _bMan;
	{_bMan removeWeapon _x;} forEach weapons _bMan;
	{_bMan removeItem _x;} forEach items _bMan;
	removeAllAssignedItems _bMan;
	removeBackpackGlobal _bMan;
	_bMan setDamage 0.8;
	{_bMan setHit [_x,0.8];} forEach ["body","spine1","spine2","spine3"];
	{_bMan setHit [_x,0.9];} forEach ["face_hub","neck","head","arms","hands"];
	_bMan setSkill 0.3;
	_bMan addWeapon "hgun_ACPC2_F";
	_bMan addMagazine "9Rnd_45ACP_Mag";
	_bMan addMagazine "9Rnd_45ACP_Mag";
	_bMan addMagazine "9Rnd_45ACP_Mag";
	_bMan addBackpack "B_Parachute";
	_plane = createVehicle ["C_Plane_Civil_01_F",_spwPos vectorAdd [0,0,1250],[],100,"FLY"];
	_plane setVariable ["brpvp_no_clean",true,true];
	_bMan moveInDriver _plane;
	_bMan setVariable ["sc",0];
	_paraPos = [_center vectorAdd [0,0,50],_radius*0.5+random (_radius*0.5),random 360] call BIS_fnc_relPos;
	_wp = _grp addWayPoint [_paraPos,0];
	_wp setWayPointCompletionRadius 100;
	waitUntil {_plane distanceSqr _paraPos < 1000000};
	_plane setDamage 0.5;
	waitUntil {currentWayPoint _grp isEqualTo 2 || !canMove _plane};
	moveOut _bMan;
	sleep 0.25;
	_plane setDamage 1;
	sleep 0.75;
	_plane setVariable ["dir",getDir _plane,true];
	_plane setVariable ["brpvp_jump_pos",getPosWorld _bMan,true];
	_plane setVariable ["bm",_bMan,false];
	BRPVP_corruptMissIcon pushBack _plane;
	publicVariable "BRPVP_corruptMissIcon";
	_idc = (count BRPVP_corruptMissIcon)-1;
	[["str_plane_fall",[]],8,25] remoteExecCall ["BRPVP_hint",0];
	diag_log "[BRPVP MISS PLANE] Civil Plane Crash mission started!";
	_grp allowFleeing 0;
	waitUntil {vehicle _bMan isEqualTo _bMan};
	_plane setVariable ["dir",[_bMan,_plane] call BIS_fnc_dirTo,true];
	waitUntil {getPos _bMan select 2 < 1};
	sleep (60+random 20);
	if (alive _bMan) then {_bMan setDamage 1;};
};