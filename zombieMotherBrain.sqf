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

ZB_zombieSoundsScream = ["zombie_snd_1","zombie_snd_2","zombie_snd_3","zombie_snd_4","zombie_snd_5","zombie_snd_6","zombie_snd_7","zombie_snd_8","zombie_snd_9","zombie_snd_10","zombie_snd_11","zombie_snd_12","zombie_snd_14","zombie_snd_15","zombie_snd_16","zombie_snd_17","zombie_snd_18","zombie_snd_19","zombie_snd_20","zombie_snd_21","zombie_snd_22","zombie_snd_23","zombie_snd_24","zombie_snd_25","zombie_snd_26","zombie_snd_27","zombie_snd_28","zombie_snd_29","zombie_snd_30","zombie_snd_31","zombie_snd_32","zombie_snd_33","zombie_snd_34","zombie_snd_35","zombie_snd_36","zombie_snd_37","zombie_snd_38","zombie_snd_39","zombie_snd_40","zombie_snd_41","zombie_snd_42","zombie_snd_43","zombie_snd_44","zombie_snd_45","zombie_snd_46","zombie_snd_47","zombie_snd_48","zombie_snd_49","zombie_snd_50","zombie_snd_51","zombie_snd_52","zombie_snd_53","zombie_snd_54","zombie_snd_55","zombie_snd_56","zombie_snd_57","zombie_snd_58","zombie_snd_59","zombie_snd_60","zombie_snd_61","zombie_snd_62","zombie_snd_63"];
ZB_zombieSoundsScream = ZB_zombieSoundsScream+ZB_zombieSoundsScream;

ZB_agnts = [];
ZB_time = time;
ZB_zombieSoundsScreamIdx = 0;
ZB_zombieSoundsScreamCount = count ZB_zombieSoundsScream;
ZB_nearPlayers = [];
ZB_zedHelpZedPercentage = 0.5;
ZB_getZedDistToVehOk = {
	params ["_zed","_veh"];
	if (_zed distance _veh > 10) then {
		false
	} else {
		private _pos = [];
		private _eye = eyePos _zed;
		private _com = AGLToASL (_veh modelToWorld getCenterOfMass _veh);
		{if (_x select 2 isEqualTo _veh) exitWith {_pos = ASLToAGL (_x select 0);};} forEAch lineIntersectsSurfaces [_eye,_com,_zed,objNull,true,-1];
		if (_pos isEqualTo []) then {false} else {_pos distance ASLToAGL _eye < 3};
	};
};
ZB_applyForceZombie = {
	params ["_veh","_zed"];
	private _com = _veh worldToModel ((_veh modelToWorld getCenterOfMass _veh) vectorAdd [0,0,10]);
	private _d = [_veh modelToWorld _com,_zed] call BIS_fnc_dirTo;
	private _de = _d-getDir _veh;
	private _a = BRPVP_applyForceSize;
	private _b = BRPVP_applyForceSize/2;
	private _mass = getMass _veh;
	private _mult = (_mass/1190)*(1+(0.1*(_mass-1190)/(50650-1190)));
	private _mag = ((_a*_b)/sqrt((_a*sin _de)^2+(_b*cos _de)^2))*_mult;
	private _df = _d+180;
	private _force = [_mag*sin _df,_mag*cos _df,0];
	_veh addForce [_force,_com];
};
ZB_zombieMoveToArray1 = ["_agnt","_pos"];
ZB_zombieMoveTo = {
	params ZB_zombieMoveToArray1;
	private _noDistract = isNull (_agnt getVariable ["brpvp_my_distract_object",objNull]);
	if (_noDistract) then {
		_agnt setVariable ["brpvp_destination",_pos];
		_agnt moveTo _pos;
	};
};
ZB_zombieMoveToInHouseArray1 = ["_agnt","_posOriginal","_rad"];
ZB_zombieMoveToInHouse = {
	params ZB_zombieMoveToInHouseArray1;
	private _noDistract = isNull (_agnt getVariable ["brpvp_my_distract_object",objNull]);
	if (_noDistract) then {
		private _best = _posOriginal findEmptyPosition [0,_rad,BRPVP_zombieMotherClass];
		private _pos = if (_best isEqualTo []) then {_posOriginal} else {_best};
		private _bui = _uTarget getVariable ["bui",objNull];
		_agnt setVariable ["brpvp_destination",ASLToAGL getPosASL _bui];
		_agnt moveTo _pos;
	};
};
ZB_zombieMoveToInHouseOff = {
	params ZB_zombieMoveToInHouseArray1;
	private _noDistract = isNull (_agnt getVariable ["brpvp_my_distract_object",objNull]);
	if (_noDistract) then {
		_agnt setVariable ["brpvp_destination",ASLToAGL getPosASL (_uTarget getVariable "bui")];
		_agnt moveTo ((_pos select [0,2])+100);
	};
};
ZB_addAgentFinalizeGroup = {
	params ["_agnts","_target"];
	{[_x,_target] call ZB_addAgentFinalize;} forEach _agnts;
};
ZB_addAgentFinalizeArray1 = ["_agnt","_target"];
ZB_addAgentFinalize = {
	params ZB_addAgentFinalizeArray1;
	_agnt setCombatMode "BLUE";
	_agnt setBehaviour "CARELESS";
	_agnt disableAI "ALL";
	_agnt enableAI "MOVE";
	_agnt enableAI "ANIM";
	_agnt enableAI "TEAMSWITCH";
	_agnt enableAI "PATH";

	//FIGHT AI OR AI + PLAYERS?
	if (_agnt getVariable ["brpvp_fightAI",true]) then {
		[_agnt,-20000-rating _agnt] remoteExecCall ["addRating",0];
		_agnt setVariable ["brpvp_tgt_class",[BRPVP_playerModel,"SoldierWB","SoldierGB"]];
		_agnt setVariable ["brpvp_extra_jump",selectRandom BRPVP_extraJumpPlayerAi];
	} else {
		_agnt setVariable ["brpvp_tgt_class",[BRPVP_playerModel]];
		_agnt setVariable ["brpvp_extra_jump",selectRandom BRPVP_extraJumpPlayer];
	};

	//IS MOBIUS?
	private _isMobius = _agnt getVariable ["brpvp_mobius",false];
	if (_isMobius) then {
		_agnt forceSpeed (_agnt getSpeed "SLOW");
		_agnt setVariable ["brpvp_extra_jump",0];
	};

	//ZOMBIE STYLE
	private _oldStyle = _agnt getVariable ["brpvp_zeds_old_style",selectRandom BRPVP_defaultZombieStyle];
	if (_oldStyle isEqualTo 1) then {
		_agnt setVariable ["brpvp_zed_see_lim",60];
		_agnt setVariable ["brpvp_zed_see_eng",150];
		_agnt setVariable ["brpvp_zed_see_recalc",200];
	} else {
		if (_oldStyle isEqualTo 2) then {
			_agnt setVariable ["brpvp_zed_see_lim",200];
			_agnt setVariable ["brpvp_zed_see_eng",200];
			_agnt setVariable ["brpvp_zed_see_recalc",200];
		};
	};

	//KNEELING OR NORMAL?
	_agnt setVariable ["knl",!_isMobius && random 1 < BRPVP_kneelingJumpZombiesPercentage,true];
	_agnt call BRPVP_setZombieWalkMode;

	_agnt setVariable ["dmg",0];
	_agnt addEventHandler ["HandleDamage",{call BRPVP_zombieHDEH;}];
	_agnt setVariable ["brpvp_free_jump_schema",selectRandom [[35,30],[30,25],[25,20]]];
	_agnt setVariable ["jpg",false,true];

	if (isNull _target) then {
		//SET ACTION 2
		_agnt setVariable ["brpvp_agntsAct",2];
		_agnt setVariable ["brpvp_agntsArg_ini",time];
		_agnt setVariable ["brpvp_agntsArg_fim",ZB_time];
		_agnt setVariable ["brpvp_agntsTarget",objNull];

		//ADD TO BRAIN
		_agnt setVariable ["brpvp_destination",ASLToAGL getPosASL _agnt];
		ZB_agnts pushBack _agnt;
	} else {
		//SET ACTION 1
		_agnt setVariable ["brpvp_agntsAct",1];
		_agnt setVariable ["brpvp_agntsArg_fim",ZB_time];
		_agnt setVariable ["brpvp_agntsTarget",_target,[clientOwner,_target getVariable ["brpvp_machine_id",-1]]-[-1]];
	
		//SET INITIAL POS
		private _pAGL = ASLToAGL getPosASL _target;
		if (_target getVariable ["brpvp_error_zed",false]) then {
			private _error = 8+random 4;
			private _angle = [_uTarget,_agnt] call BIS_fnc_dirTo;
			_pAGL = _pAGL vectorAdd [_error*sin _angle,_error*cos _angle,0];
		};
		
		//ADD TO BRAIN AND DO INITIAL ZOMBIE MOVE!
		ZB_agnts pushBack _agnt;
		private _inHouse = !isNull (_target getVariable ["bui",objNull]);
		if (_inHouse) then {private _uTarget = _target;[_agnt,_pAGL,30] call ZB_zombieMoveToInHouse;} else {[_agnt,_pAGL] call ZB_zombieMoveTo;};
	};
};
ZB_friendShotZedHelpArray1 = ["_agnts","_target","_distChance"];
ZB_friendShotZedHelp = {
	params ZB_friendShotZedHelpArray1;
	{
		private _agnt = _x;
		if (_agnt getVariable ["brpvp_agntsAct",-1] isEqualTo 2) then {
			if (random 1 < ZB_zedHelpZedPercentage && random 1 < _distChance) then {
				//SET ACTION 1
				_agnt setVariable ["brpvp_agntsAct",1];
				_agnt setVariable ["brpvp_agntsArg_fim",ZB_time];
				_agnt setVariable ["brpvp_agntsTarget",_target,[clientOwner,_target getVariable ["brpvp_machine_id",-1]]-[-1]];

				//ADD TO BRAIN AND DO INITIAL ZOMBIE MOVE!
				private _pAGL = ASLToAGL getPosASL _target;
				private _inHouse = !isNull (_target getVariable ["bui",objNull]);
				if (_inHouse) then {[_agnt,_pAGL,30] call ZB_zombieMoveToInHouse;} else {[_agnt,_pAGL] call ZB_zombieMoveTo;};
			};
		};		
	} forEach (_agnts arrayIntersect ZB_agnts);
};
ZB_setZombieNewDestine = {
	ZB_agnts deleteAt (ZB_agnts find _agnt);
	if (isNull _this) then {
		call ZB_agntRemoveAndDelete;
	} else {
		_agnt setVariable ["brpvp_agntsTarget",objNull,[clientOwner,_uTarget getVariable ["brpvp_machine_id",-1]]-[-1]];
		_agnt removeAllEventHandlers "HandleDamage";
		[_agnt,_this] remoteExecCall ["BRPVP_setZombieOwner",2];
	};
};
ZB_searchForATargetBTS = {
	[_agnt,objNull] call ZB_addAgentFinalize;
};
ZB_searchForATargetMustSee = {
	private _target = objNull;
	private _onFoot = _agnt nearEntities [_agnt getVariable "brpvp_tgt_class",30];
	private _playerOnVeh = BRPVP_playerVehicles select {_x distanceSqr _agnt <= 900};
	{
		private _dist = _x distance _agnt;
		if (_x call BRPVP_zombieCanSee && [_agnt,_x] call ZB_canSeeUnitTarget) exitWith {_target = _x;};
	} forEach (_onFoot+_playerOnVeh);
	_target
};
ZB_zedCanSeeBush = {
	private _b = _t getVariable ["brpvp_server_bush",objNull];
	!isNull _b && {((_vA+[[0,0,0]]) select 0 select 2 isEqualTo _b) || ((_vB+[[0,0,0]]) select 0 select 2 isEqualTo _b)}
};
ZB_canSeeUnitTarget = {
	params ["_a","_t"];
	if (_dist > _a getVariable ["brpvp_zed_see_lim",30] || _t getVariable ["brpvp_error_zed",false]) then {
		false
	} else {
		private _vA = lineIntersectsSurfaces [eyePos _a vectorAdd [0,0,0.5],eyePos _t vectorAdd [0,0,0.5],_a,vehicle _t,true,1,"VIEW","NONE",true];
		if (_vA isEqualTo []) then {true} else {lineIntersectsSurfaces [eyePos _a,eyePos _t,_a,vehicle _t,true,1,"VIEW","NONE",true] isEqualTo []};
	};
};
ZB_canSeeUnitTargetEngaged = {
	params ["_a","_t"];
	if (_dist > _a getVariable ["brpvp_zed_see_lim_eng",75] || _t getVariable ["brpvp_error_zed",false]) then {
		false
	} else {
		private _vA = lineIntersectsSurfaces [eyePos _a vectorAdd [0,0,0.5],eyePos _t vectorAdd [0,0,0.5],_a,vehicle _t,true,1,"VIEW","NONE",true];
		if (_vA isEqualTo []) then {true} else {lineIntersectsSurfaces [eyePos _a,eyePos _t,_a,vehicle _t,true,1,"VIEW","NONE",true] isEqualTo []};
	};
};
ZB_canSeeUnitTargetRecalcPath = {
	params ["_a","_t"];
	if (_dist > _a getVariable ["brpvp_zed_see_lim_recalc",100] || _t getVariable ["brpvp_error_zed",false]) then {
		false
	} else {
		private _vA = lineIntersectsSurfaces [eyePos _a vectorAdd [0,0,0.5],eyePos _t vectorAdd [0,0,0.5],_a,vehicle _t,true,1,"VIEW","NONE",true];
		if (_vA isEqualTo []) then {true} else {lineIntersectsSurfaces [eyePos _a,eyePos _t,_a,vehicle _t,true,1,"VIEW","NONE",true] isEqualTo []};
	};
};
ZB_walkerPlaySound = {
	_agnt setVariable ["brpvp_agntsArg_fim",ZB_time+10+random 10+_countAgnts*0.2];
	if (ZB_zombieSoundsScreamIdx isEqualTo 0) then {ZB_zombieSoundsScream = ZB_zombieSoundsScream call BIS_fnc_arrayShuffle;};
	[_agnt,[ZB_zombieSoundsScream select ZB_zombieSoundsScreamIdx,400,0.975+random 0.05]] remoteExecCall ["say3D",[-2,ZB_nearPlayers] select hasInterface];
	ZB_zombieSoundsScreamIdx = (ZB_zombieSoundsScreamIdx+1) mod ZB_zombieSoundsScreamCount;
};
ZB_noTargetOnZedLimit = {
	private _onFoot = _agnt nearEntities [_agnt getVariable "brpvp_tgt_class",200];
	private _playerOnVeh = BRPVP_playerVehicles select {_x distanceSqr _agnt < 40000};
	(_onFoot+_playerOnVeh) isEqualTo []
};
ZB_agntRemoveAndDelete = {
	ZB_agnts deleteAt (ZB_agnts find _agnt);
	_agnt removeAllEventHandlers "HandleDamage";
	{
		if (typeOf _x isEqualTo "Land_GasTank_01_khaki_F") then {
			detach _x;
			deleteVehicle _x;
		};
	} forEach attachedObjects _agnt;
	deleteVehicle _agnt;
};
ZB_findOrWait = {
	private _newTarget = call ZB_searchForATargetMustSee;
	if (isNull _newTarget) then {
		if (call ZB_noTargetOnZedLimit) then {
			call ZB_agntRemoveAndDelete;
		} else {
			_agnt setVariable ["brpvp_agntsAct",2];
			_agnt setVariable ["brpvp_agntsArg_ini",time];
			_agnt setVariable ["brpvp_agntsTarget",objNull,[clientOwner,_uTarget getVariable ["brpvp_machine_id",-1]]-[-1]];
		};
	} else {
		_newTarget call ZB_setZombieNewDestine;
	};
};
ZB_moveTypesCode = {
	private _posTarget = ASLToAGL getPosASL _uTarget;
	if (_errorOn) then {
		private _error = 8+random 4;
		private _angle = [_uTarget,_agnt] call BIS_fnc_dirTo;
		_posTarget = _posTarget vectorAdd [_error*sin _angle,_error*cos _angle,0];
	};
	private _inHouse = !isNull (_uTarget getVariable ["bui",objNull]);
	if (_inHouse) then {[_agnt,_posTarget,30] call ZB_zombieMoveToInHouse;} else {[_agnt,_posTarget] call ZB_zombieMoveTo;};
};
ZB_walkerAcao1 = {
	private _isJumping = _agnt getVariable "jpg";
	if (!_isJumping) then {
		private _dist = _agnt distance _uTarget;
		if (_dist > 200) then {
			if (_moveToCompleted) then {call ZB_findOrWait;};
		} else {
			private _fim = _agnt getVariable "brpvp_agntsArg_fim";
			if (_fim-ZB_time < 0) then {call ZB_walkerPlaySound;};
			if (alive _uTarget && _uTarget call BRPVP_zombieCanSee) then {
				if (_moveToCompleted) then {
					private _canSee = [_agnt,_utarget] call ZB_canSeeUnitTargetEngaged;
					if (_canSee) then {
						private _canHitVeh = if (_tInVeh) then {[_agnt,_tVeh] call ZB_getZedDistToVehOk} else {false};
						//CAN ATTACK?
						if (_dist < 3 || _canHitVeh) then {
							if (_agnt getVariable "knl") then {_agnt setUnitPos "UP";};
							_agnt moveTo ASLToAGL getposASL _agnt;
							_agnt setVariable ["brpvp_agntsAct",3];
							_agnt setVariable ["brpvp_agntsArg_ini",0];
							_agnt setVariable ["brpvp_agntsArg_dano",false];
						} else {
							private _extraJump = _agnt getVariable "brpvp_extra_jump";
							private _dist2D = _agnt distance2D _uTarget;
							//CAN JUMP?
							if (_dist2D > 15 && _dist2D < 30 && _extraJump > 0) then {
								private _errorOn = _uTarget getVariable ["brpvp_error_zed",false];
								_dist2D = [_dist2D,_dist2D*(1.15+random 0.35)] select _errorOn;
								_agnt setVariable ["brpvp_extra_jump",_extraJump-1];
								_agnt setVariable ["jpg",true,true];
								if ((ASLToAGL getPosASL _uTarget) select 2 < 0.5) then {
									[_agnt,_uTarget,-2,_dist2D/2,_dist2D] call BRPVP_zombieJump;
								} else {
									private _bui = _uTarget getVariable ["bui",objNull];
									if (isNull _bui) then {_bui = _uTarget;};
									_bb = boundingBoxReal _bui;
									_h = (_bui modelToWorld [0,0,(_bb select 1 select 2)]) select 2;
									[_agnt,_uTarget,-1,_h+10,_dist2D*2,true] call BRPVP_zombieJump;
								};
							} else {
								private _expDest = _agnt getVariable ["brpvp_destination",ASLToAGL getPosASL _agnt];
								private _bui = _uTarget getVariable ["bui",objNull];
								private _tgtOrBuiPos = if (isNull _bui) then {_uTarget} else {ASLToAGL getPosASL _bui};
								if (_tgtOrBuiPos distance _expDest > 3) then {
									call ZB_moveTypesCode;
								} else {
									private _chance = if (diag_fps > 30) then {if (_dist < 25) then {0.75} else {if (_dist < 50) then {0.5} else {if (_dist < 75) then {0.25} else {0.125};};};} else {0.25};
									if (random 1 < _chance) then {
										private _angle = random 360;
										_agnt doWatch ASLtoAGL ((eyePos _agnt) vectorAdd [10*sin _angle,10*cos _angle,-1.5+random 11.5]);
									};
								};
							};
						};
					} else {
						call ZB_findOrWait;
					};
				} else {
					//CAN ATTACK PASSING BY?
					if (_dist < 3) then {
						if (_agnt getVariable "knl") then {_agnt setUnitPos "UP";};
						_agnt moveTo ASLToAGL getposASL _agnt;
						_agnt setVariable ["brpvp_agntsAct",3];
						_agnt setVariable ["brpvp_agntsArg_ini",0];
						_agnt setVariable ["brpvp_agntsArg_dano",false];
					} else {
						if (random 1 < 0.2) then {
							private _expDest = _agnt getVariable ["brpvp_destination",ASLToAGL getPosASL _agnt];
							if (_expDest distance2D _uTarget > 15) then {
								private _canSee = [_agnt,_utarget] call ZB_canSeeUnitTargetRecalcPath;
								if (_canSee) then {
									private _errorOn = _uTarget getVariable ["brpvp_error_zed",false];
									call ZB_moveTypesCode;
								};
							}
						};
					};
				};
			} else {
				call ZB_findOrWait;
			};
		};
	};
};
ZB_walkerAcao2 = {
	private _ini = _agnt getVariable "brpvp_agntsArg_ini";
	private _fim = _agnt getVariable "brpvp_agntsArg_fim";
	if (random 1 < 0.5) then {
		private _newTarget = call ZB_searchForATargetMustSee;
		if (isNull _newTarget) then {
			if (call ZB_noTargetOnZedLimit) then {call ZB_agntRemoveAndDelete;};
		} else {
			_newTarget call ZB_setZombieNewDestine;
		};
	} else {
		if (random 1 < 0.25) then {
			private _angle = random 360;
			_agnt doWatch ASLtoAGL (eyePos _agnt vectorAdd [10*sin _angle,10*cos _angle,-1.5+random 11.5]);
		};
	};
	if (_fim-ZB_time < 0) then {call ZB_walkerPlaySound;};
};
ZB_walkerAcao3 = {
	private _ini = _agnt getVariable "brpvp_agntsArg_ini";
	private _dano = _agnt getVariable "brpvp_agntsArg_dano";
	if (ZB_time-_ini > 2) then {
		if (!(_agnt getVariable "jpg") && lifeState _agnt isNotEqualTo "INCAPACITATED" && stance _agnt in ["STAND","CROUCH"]) then {
			_dist = _uTarget distance _agnt;
			_canHitVeh = [false,[_agnt,_tVeh] call ZB_getZedDistToVehOk] select _tInVeh;
			if (!(_uTarget getVariable ["brpvp_aitiz",false]) && (_dist < 3 || _canHitVeh) && {[_agnt,_utarget] call ZB_canSeeUnitTarget && _uTarget getVariable ["dd",-1] < 1}) then {
				_agnt setDir ([_agnt,vehicle _uTarget] call BIS_fnc_dirTo);
				[_agnt,"AwopPercMstpSgthWnonDnon_throw"] remoteExecCall ["switchMove",0];
				if (_agnt getVariable ["brpvp_mobius",false]) then {
					[_agnt,["mobius_attack",300]] remoteExecCall ["say3D",[-2,ZB_nearPlayers] select hasInterface];
				} else {
					if (_canHitVeh) then {
						_ms = selectRandom ["monster_01","monster_02","monster_03","monster_04"];
						[_agnt,[_ms,200]] remoteExecCall ["say3D",[-2,ZB_nearPlayers] select hasInterface];
					} else {
						[_agnt,["zombie_snd_13",200]] remoteExecCall ["say3D",[-2,ZB_nearPlayers] select hasInterface];
					};
				};
				_agnt setVariable ["brpvp_agntsArg_ini",ZB_time-0.25+random 0.5];
				_agnt setVariable ["brpvp_agntsArg_dano",true];
			} else {
				_agnt call BRPVP_setZombieWalkMode;
				_agnt setVariable ["brpvp_agntsAct",1];
				_agnt setVariable ["brpvp_agntsArg_fim",ZB_time+random 1.5];
				if (_uTarget getVariable ["brpvp_aitiz",false]) then {_agnt setVariable ["brpvp_agntsTarget",objNull,[clientOwner,_uTarget getVariable ["brpvp_machine_id",-1]]-[-1]];};
			};
		} else {
			_agnt setVariable ["brpvp_agntsArg_ini",ZB_time-1];
		};
	} else {
		if (_dano) then {
			if (ZB_time-_ini > 0.25) then {
				private _noDamage = diag_tickTime-(_agnt getVariable ["brpvp_my_puncher",0]) < 2.5 && random 1 < 0.85;
				_agnt doWatch ASLToAGL eyePos vehicle _uTarget;
				_agnt setVariable ["brpvp_agntsArg_dano",false];
				_dist = _uTarget distance _agnt;
				_canHitVeh = [false,[_agnt,_tVeh] call ZB_getZedDistToVehOk] select _tInVeh;
				_ani = animationState _agnt;
				_aniOk = (_ani == "AwopPercMstpSgthWnonDnon_throw" || _ani == "AwopPercMstpSgthWnonDnon_end") && lifeState _agnt isNotEqualTo "INCAPACITATED";
				if ((_dist < 3 || _canHitVeh) && {[_agnt,_utarget] call ZB_canSeeUnitTarget && _uTarget getVariable ["dd",-1] < 1 && _aniOk}) then {
					if !(_uTarget getVariable ["god",false] || _uTarget getVariable ["brpvp_god_admin",false] || _agnt getVariable "jpg") then {
						if (_canHitVeh) then {
							[_tVeh,_agnt] call ZB_applyForceZombie;
							[_tVeh,0.0165+random 0.0165] remoteExecCall ["BRPVP_processZombieHitVeh",_tVeh];
						} else {
							if !(_uTarget getVariable ["brpvp_peter",false] || _uTarget getVariable ["brpvp_lars",false] || _noDamage) then {
								[_uTarget,(0.02+random 0.02)*(_agnt getVariable "ifz"),_agnt] remoteExecCall ["BRPVP_processZombieHit",_uTarget];
							};
						};
					};
					if (_agnt getVariable ["brpvp_mobius",false]) then {
						_agnt setVariable ["klr",objNull,true];
						_agnt setUnconscious true;
						["Sh_105mm_HEAT_MP",_agnt modelToWorld [0,0,0],200] call BRPVP_trowBomb;
						{if (typeOf _x isEqualTo "Land_GasTank_01_khaki_F") then {detach _x;deleteVehicle _x;};} forEach attachedObjects _agnt;
					} else {
						if (_canHitVeh) then {
							[_agnt,["delivered",200]] remoteExecCall ["say3D",[-2,ZB_nearPlayers] select hasInterface];
						} else {
							if (_noDamage) then {[_agnt,["missing_punch",150]] remoteExecCall ["say3D",[-2,ZB_nearPlayers] select hasInterface];} else {[_agnt,["destroy",150]] remoteExecCall ["say3D",[-2,ZB_nearPlayers] select hasInterface];};
						};
					};
				};
			};
		};
	};
};
ZB_deadOrDelZedsLast = 0;
ZB_deadOrDelZeds = {
	//REMOVE FROM BRAIN
	ZB_agnts deleteAt (ZB_agnts find _agnt);

	if (_agnt getVariable ["brpvp_zdel",false]) then {
		{if (typeOf _x isEqualTo "Land_GasTank_01_khaki_F") then {detach _x;deleteVehicle _x;};} forEach attachedObjects _agnt;
		deleteVehicle _agnt;
	} else {
		//GIVE MONEY
		private _mult = _agnt getVariable ["ifz",1];
		private _killer = _agnt getVariable ["klr",objNull];
		if (_killer call BRPVP_isPlayer) then {
			_mult remoteExecCall ["BRPVP_giveZombieMoneyLocal",_killer];
			[["zumbi",1]] remoteExecCall ["BRPVP_mudaExp",_killer];
		};

		//SEND FRIENDS TO TARGET
		if (time-ZB_deadOrDelZedsLast > 0.5) then {
			if (alive _killer) then {
				ZB_deadOrDelZedsLast = time;
				private _nearZeds = _agnt nearEntities [BRPVP_zombieMotherClass,10];
				private _zedsHere = _nearZeds arrayIntersect ZB_agnts;
				private _zedsNotHere = _nearZeds-_zedsHere;
				private _dist = _killer distance _agnt;
				private _distChance = if (_dist <= 75) then {1} else {if (_dist <= 250) then {1-(_dist-75)/175} else {0};};
				{
					private _aFound = _x;
					if (_aFound getVariable ["brpvp_agntsAct",-1] isEqualTo 2) then {
						if (random 1 < ZB_zedHelpZedPercentage && random 1 < _distChance) then {
							//SET ACTION 1
							_aFound setVariable ["brpvp_agntsAct",1];
							_aFound setVariable ["brpvp_agntsArg_fim",ZB_time];
							_aFound setVariable ["brpvp_agntsTarget",_killer,[clientOwner,_killer getVariable ["brpvp_machine_id",-1]]-[-1]];

							//ADD TO BRAIN AND DO INITIAL ZOMBIE MOVE!
							private _pAGL = ASLToAGL getPosASL _killer;
							private _inHouse = !isNull (_killer getVariable ["bui",objNull]);
							if (_inHouse) then {[_aFound,_pAGL,30] call ZB_zombieMoveToInHouse;} else {[_aFound,_pAGL] call ZB_zombieMoveTo;};
						};
					};
				} forEach _zedsHere;
				[_zedsNotHere,_killer,_distChance] remoteExecCall ["ZB_friendShotZedHelp",0];
			};
		};

		//DELETE BODY
		_agnt spawn {
			uiSleep 1;
			private _po = _this modelToWorldVisual (_this selectionPosition "head");
			private _count = 0;
			waitUntil {
				uiSleep 0.2;
				private _pn = _this modelToWorldVisual (_this selectionPosition "head");
				if (_pn distance _po < 0.125) then {_count = _count+1;} else {_count = 0;};
				_po = _pn;
				_count isEqualTo 2
			};
			uiSleep 1;
			deleteVehicle _this;
		};
	};
};

addMissionEventHandler ["EachFrame",{call ZB_mainThread}];
ZB_initMove = 0;
ZB_initWait = 0;
ZB_initAttack = 0;
ZB_initAttackB = 0;
ZB_mainThread = {
	ZB_time = time;
	private _zeds1 = [];
	private _zeds2 = [];
	private _zeds3 = [];
	{
		private _agnt = _x;
		if (lifeState _agnt in ["INCAPACITATED","DEAD"] || _agnt getVariable ["brpvp_zdel",false]) then {
			call ZB_deadOrDelZeds;
		} else {
			if (_agnt getVariable "brpvp_agntsAct" isEqualTo 1) exitWith {_zeds1 pushBack _agnt;};
			if (_agnt getVariable "brpvp_agntsAct" isEqualTo 2) exitWith {_zeds2 pushBack _agnt;};
			if (_agnt getVariable "brpvp_agntsAct" isEqualTo 3) exitWith {_zeds3 pushBack _agnt;};
		};
	} forEach ZB_agnts;
	_zeds1 call ZB_mainThreadMove;
	_zeds2 call ZB_mainThreadWait;
	_zeds3 call ZB_mainThreadAttack;
};
ZB_mainThreadMove = {
	if (ZB_time-ZB_initMove > 1) then {
		ZB_initMove = ZB_time;

		//GET NEAR PLAYERS
		if (hasInterface) then {
			private _nearPlayers = (player nearEntities [BRPVP_playerModel,600])+(BRPVP_playerVehicles select {_x distanceSqr player < 360000});
			private _find = BRPVP_specOnMeMachinesNoMe+(_nearPlayers apply {_x getVariable ["brpvp_machine_id",-1]});
			ZB_nearPlayers = (_find arrayIntersect _find)-[-1];
		};

		private _countAgnts = count ZB_agnts;
		{
			private _agnt = _x;
			private _uTarget = _agnt getVariable ["brpvp_agntsTarget",objNull];
			if (isNull _uTarget) then {
				call ZB_findOrWait;
			} else {
				private _moveToCompleted = moveToCompleted _agnt || moveToFailed _agnt;
				private _tVeh = objectParent _uTarget;
				private _tInVeh = !isNull _tVeh;
				call ZB_walkerAcao1;
			};
		} forEach _this;
	};
};
ZB_mainThreadWait = {
	if (ZB_time-ZB_initWait > 2) then {
		ZB_initWait = ZB_time;
		{
			private _agnt = _x;
			call ZB_walkerAcao2;
		} forEach _this;
	};
};
ZB_mainThreadAttack = {
	if (ZB_time-ZB_initAttack > 0.125) then {
		ZB_initAttack = ZB_time;
		{
			if (isNull (_x getVariable ["brpvp_agntsTarget",objNull])) then {
				if (ZB_time-ZB_initAttackB > 1) then {
					ZB_initAttackB = ZB_time;
					private _agnt = _x;
					private _uTarget = _agnt getVariable ["brpvp_agntsTarget",objNull];
					call ZB_findOrWait;
				};
			} else {
				private _ini = _x getVariable "brpvp_agntsArg_ini";
				if (ZB_time-_ini > 2 || (_x getVariable "brpvp_agntsArg_dano") && ZB_time-_ini > 0.25) then {
					private _agnt = _x;				
					private _uTarget = _agnt getVariable ["brpvp_agntsTarget",objNull];
					private _tVeh = objectParent _uTarget;
					private _tInVeh = !isNull _tVeh;
					call ZB_walkerAcao3;
				};
			};
		} forEach _this;
	};
};
