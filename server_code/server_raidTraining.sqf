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

if (BRPVP_raidTrainingMapPosition isNotEqualTo []) then {
	call compile preprocessFileLineNumbers "map_specific\worldBases.sqf";

	private _gSize = getTerrainInfo select 2;
	private _ffPosAsl = AGLToASL BRPVP_raidTrainingMapPosition;
	private _centerVertex = AGLToASL (((_ffPosAsl select [0,2]) apply {_gSize*round (_x/_gSize)})+[0]);
	BRPVP_raidTrainingCodeWait = 0.005;
	BRPVP_raidTrainingCodeRunning = false;
	BRPVP_raidTrainingMaxExtraRad = 50;
	BRPVP_raidTrainingMissionOriginalCenter = _centerVertex;
	BRPVP_raidTrainingMissionBaseFlag = [];
	BRPVP_raidTrainingMissionObjects = [];
	BRPVP_raidTrainingMissionBigFloors = [];	
	BRPVP_raidTrainingMissionFlagSize = -1;
	BRPVP_raidTrainingBuildingHd = {
		params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
		private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
		private _deltaDam = _dam-_damNow;
		_damNow+_deltaDam*0.1
	};
	publicVariable "BRPVP_raidTrainingMissionFlagSize";

	//CALC VANILLA VERTEX FOR ALL FLAGS (200, 100, 50 AND 25 METERS)
	{
		_x params ["_fRad","_code1","_code2"];
		private _steps = ceil (_fRad/_gSize);
		private _raidTrainingMissionOriginalVertexSet = [];
		private _mH = 0;
		private _mHCount = 0;
		for "_ix" from (-2*_steps*_gSize) to (2*_steps*_gSize) step _gSize do {
			for "_iy" from (-2*_steps*_gSize) to (2*_steps*_gSize) step _gSize do {
				private _hNow = AGLToASL [(_centerVertex select 0)+_ix,(_centerVertex select 1)+_iy,0] select 2;
				private _pos = [(_centerVertex select 0)+_ix,(_centerVertex select 1)+_iy,_hNow];
				if (_pos distance2D _centerVertex <= _fRad+(_fRad min BRPVP_raidTrainingMaxExtraRad)) then {
					_raidTrainingMissionOriginalVertexSet pushBack _pos;
					_mH = _mH+_hNow;
					_mHCount = _mHCount+1;
				};
			};
		};
		(_mH/_mHCount) call _code1;
		_raidTrainingMissionOriginalVertexSet call _code2;
	} forEach [
		[200,{BRPVP_raidTrainingMissionOriginalH200 = _this;},{BRPVP_raidTrainingMissionOriginalVertexSet200 = _this;}],
		[100,{BRPVP_raidTrainingMissionOriginalH100 = _this;},{BRPVP_raidTrainingMissionOriginalVertexSet100 = _this;}],
		[50,{BRPVP_raidTrainingMissionOriginalH50 = _this;},{BRPVP_raidTrainingMissionOriginalVertexSet50 = _this;}],
		[25,{BRPVP_raidTrainingMissionOriginalH25 = _this;},{BRPVP_raidTrainingMissionOriginalVertexSet25 = _this;}]
	];

	BRPVP_raidTrainingStopMission = {
		//DELETE OBJECTS
		if (BRPVP_raidTrainingMissionFlagSize isNotEqualTo -1) then {
			private _fRad = _this;
			private _gSize = getTerrainInfo select 2;
			private _raidTrainingMissionObjects = +BRPVP_raidTrainingMissionObjects;
			reverse _raidTrainingMissionObjects;
			{
				if (_x isKindOf "StaticWeapon") then {
					if (isNull (_x getVariable "brpvp_operator")) then {
						deleteVehicle _x;
					} else {
						_x remoteExecCall ["BRPVP_destroyTurret",2];
						_x setPosWorld BRPVP_posicaoFora;
					};
				} else {
					if (_x call BRPVP_isMotorized) then {
						if (_x distance2D BRPVP_raidTrainingMapPosition < 400 && crew _x isEqualTo []) then {
							if (_x getVariable ["brpvp_rto_real_vehicle",false]) then {
								private _id = _x getVariable ["id_bd",-1];
								if (_id isNotEqualTo -1) then {_id remoteExecCall ["BRPVP_raidTrainingRealVehDeleteDb",2];};
							};
							deleteVehicle _x;
						};
					} else {
						deleteVehicle _x;
					};
				};
				if (1/diag_fps <= BRPVP_raidTrainingCodeWait) then {uiSleep BRPVP_raidTrainingCodeWait;} else {if (random 1 < (1/((1/diag_fps)/BRPVP_raidTrainingCodeWait))) then {uiSleep 0.001;};};
			} forEach _raidTrainingMissionObjects;
			BRPVP_raidTrainingMissionObjects = [];
			{
				if (_x getVariable ["brpvp_rto_real_vehicle",false] && crew _x isEqualTo []) then {
					private _id = _x getVariable ["id_bd",-1];
					if (_id isNotEqualTo -1) then {_id remoteExecCall ["BRPVP_raidTrainingRealVehDeleteDb",2];};
					deleteVehicle _x;
				};
			} forEach nearestObjects [BRPVP_raidTrainingMissionOriginalCenter,["Car","Tank","Ship","Air"],400,true];
			{
				if (_x getVariable ["brpvp_rto_real_vehicle",false]) then {
					private _id = _x getVariable ["brpvp_tire_idbd",-1];
					if (_id isNotEqualTo -1) then {
						_id remoteExecCall ["BRPVP_raidTrainingRealVehDeleteDb",2];
						_id remoteExecCall ["BRPVP_tireRemoveTireFromArrayCVL",BRPVP_allNoServer];
					};
				};
			} forEach nearestObjects [BRPVP_raidTrainingMissionOriginalCenter,["PlasticBarrier_02_yellow_F","PlasticBarrier_02_grey_F"],400,true];
			{deleteVehicle _x;} forEach nearestObjects [BRPVP_raidTrainingMissionOriginalCenter,["GroundWeaponHolder","WeaponHolderSimulated","Sign_Arrow_F"],BRPVP_raidTrainingMissionFlagSize+50,true];
			{if (!isObjectHidden _x) then {deleteVehicle _x;};} forEach nearestObjects [BRPVP_raidTrainingMissionOriginalCenter,["Building","Wall","House","Ruins"],BRPVP_raidTrainingMissionFlagSize+_gSize,true];
			{
				private _fId = _x getVariable ["brpvp_mine_base_id",-1];
				if (_fId isNotEqualTo -1) then {
					_fId remoteExecCall ["BRPVP_fantaMineRemove",2];
					deleteVehicle _x;
				};
			} forEach nearestObjects [BRPVP_raidTrainingMissionOriginalCenter,["Land_Can_V2_F"],275,true];
			//REMOVE BIG FLOOR
			remoteExecCall ["BRPVP_removeBigFloorObjectsRaidMission",0];
			{(_x select 0) remoteExecCall ["BRPVP_removeBigFloorEntry",0];} forEach BRPVP_raidTrainingMissionBigFloors;
			BRPVP_raidTrainingMissionBigFloors = [];
			
			remoteExecCall ["BRPVP_raidTrainingBaseBombRemoveLines",0];
			
			//SET TERRAIN TO ORIGINAL
			if (_fRad isNotEqualTo BRPVP_raidTrainingMissionFlagSize) then {
				if (BRPVP_raidTrainingMissionFlagSize isEqualTo 200) then {
					[BRPVP_raidTrainingMissionOriginalVertexSet200,true] remoteExec ["BRPVP_raidTrainingDigTerrain",2];
				} else {
					if (BRPVP_raidTrainingMissionFlagSize isEqualTo 100) then {
						[BRPVP_raidTrainingMissionOriginalVertexSet100,true] remoteExec ["BRPVP_raidTrainingDigTerrain",2];
					} else {
						if (BRPVP_raidTrainingMissionFlagSize isEqualTo 50) then {
							[BRPVP_raidTrainingMissionOriginalVertexSet50,true] remoteExec ["BRPVP_raidTrainingDigTerrain",2];
						} else {
							[BRPVP_raidTrainingMissionOriginalVertexSet25,true] remoteExec ["BRPVP_raidTrainingDigTerrain",2];
						};
					};
				};
			};
		};
	};
	BRPVP_raidTrainingRunCode = {
		params ["_askSizes","_minObjsCount",["_fc",-1],["_minTurretsPerc",0.4],["_minStuffCount",20]];
		if (!BRPVP_raidTrainingCodeRunning) then {
			BRPVP_raidTrainingCodeRunning = true;
			private _baseDataWorld = [];
			private _tRealUsePerc = 0;
			if (_fc isNotEqualTo -1) then {_baseDataWorld = +(BRPVP_raidMissionWorldBases select (_fc mod count BRPVP_raidMissionWorldBases));};
			if (_fc isEqualTo -1) then {
				private _raidMissionWorldBases = [];
				private _stuffClass1 = ["LandVehicle","Air","Ship","Motorcycle","PlasticBarrier_02_yellow_F","PlasticBarrier_02_grey_F","ReammoBox_F"];
				private _stuffClass2 = ["LandVehicle","Air","Ship","Motorcycle","PlasticBarrier_02_yellow_F","PlasticBarrier_02_grey_F","ReammoBox_F","Land_Can_V2_F","Land_ClutterCutter_medium_F"];
				for "_i" from 0 to (count BRPVP_raidMissionWorldBases-1) do {_raidMissionWorldBases pushBack _i;};
				{
					private _flag = BRPVP_raidMissionWorldBases select _x select 0;
					private _rad = BRPVP_raidMissionWorldBases select _x select 1;
					private _tLim = {if ((_x select 0) isEqualTo _rad) exitWith {_x select 1};50} forEach BRPVP_turretTerrainLimit;
					if (_rad in _askSizes) then {
						private _objs = {private _ot = BRPVP_allRaidBasesObjsClassNames select (_x select 0);{_ot isKindOf _x} count _stuffClass2 isEqualTo 0} count (BRPVP_raidMissionWorldBases select _x select 3);
						private _turrets = count (BRPVP_raidMissionWorldBases select _x select 5);
						private _stuffs = {private _ot = BRPVP_allRaidBasesObjsClassNames select (_x select 0);{_ot isKindOf _x} count _stuffClass1 isNotEqualTo 0} count (BRPVP_raidMissionWorldBases select _x select 3);
						_tRealUsePerc = _turrets/_tLim;
						if (_objs >= _minObjsCount && _tRealUsePerc >= _minTurretsPerc && _stuffs >= _minStuffCount) then {_baseDataWorld = +(BRPVP_raidMissionWorldBases select _x);break;};
					};
				} forEach (_raidMissionWorldBases call BIS_fnc_arrayShuffle);
			};
			if (_baseDataWorld isNotEqualTo []) then {
				private _fRad = _baseDataWorld select 1;
				private _gSize = getTerrainInfo select 2;
				private _steps = ceil (_fRad/_gSize);
				private _fPosAsl = _baseDataWorld select 0;
				private _centerVertex = AGLToASL (((_fPosAsl select [0,2]) apply {_gSize*round (_x/_gSize)})+[0]);
				BRPVP_raidTrainingMissionBaseFlag = [_fPosAsl,_fRad];

				//REMOVE OLD BASE
				if (BRPVP_raidTrainingMissionFlagSize isNotEqualTo -1) then {_fRad call BRPVP_raidTrainingStopMission;};

				private ["_raidTrainingMissionOriginalH","_raidTrainingMissionOriginalVertexSet"];
				BRPVP_raidTrainingMissionFlagSize = _fRad;
				publicVariable "BRPVP_raidTrainingMissionFlagSize";
				private _numAi = 15;
				private _numVeh = 10;
				private _maxMoneyBox = BRPVP_raidTrainingMaxMoneyInBoxes select 0;
				private _maxMoneyBase = BRPVP_raidTrainingMaxMoneyInBoxesallBase select 0;
				if (_fRad isEqualTo 200) then {
					_raidTrainingMissionOriginalH = BRPVP_raidTrainingMissionOriginalH200;
					_raidTrainingMissionOriginalVertexSet = BRPVP_raidTrainingMissionOriginalVertexSet200;
				} else {
					if (_fRad isEqualTo 100) then {
						_numAi = 9;
						 _numVeh = 8;
						_maxMoneyBox = BRPVP_raidTrainingMaxMoneyInBoxes select 1;
						_maxMoneyBase = BRPVP_raidTrainingMaxMoneyInBoxesallBase select 1;
						_raidTrainingMissionOriginalH = BRPVP_raidTrainingMissionOriginalH100;
						_raidTrainingMissionOriginalVertexSet = BRPVP_raidTrainingMissionOriginalVertexSet100;
					} else {
						if (_fRad isEqualTo 50) then {
							_numAi = 5;
							 _numVeh = 6;
							_maxMoneyBox = BRPVP_raidTrainingMaxMoneyInBoxes select 2;
							_maxMoneyBase = BRPVP_raidTrainingMaxMoneyInBoxesallBase select 2;
							_raidTrainingMissionOriginalH = BRPVP_raidTrainingMissionOriginalH50;
							_raidTrainingMissionOriginalVertexSet = BRPVP_raidTrainingMissionOriginalVertexSet50;
						} else {
							_numAi = 2;
							 _numVeh = 4;
							_maxMoneyBox = BRPVP_raidTrainingMaxMoneyInBoxes select 3;
							_maxMoneyBase = BRPVP_raidTrainingMaxMoneyInBoxesallBase select 3;
							_raidTrainingMissionOriginalH = BRPVP_raidTrainingMissionOriginalH25;
							_raidTrainingMissionOriginalVertexSet = BRPVP_raidTrainingMissionOriginalVertexSet25;
						};
					};
				};

				private _allVertexs = _baseDataWorld select 4;
				private _newCenterTemp = (BRPVP_raidTrainingMissionOriginalCenter select [0,2])+[0];
				private _moveFixTemp = _newCenterTemp vectorDiff _centerVertex;

				private _mHMin = 1000000;
				private _mHMax = -1000000;
				{
					private _pos = _raidTrainingMissionOriginalVertexSet select _forEachIndex;
					if (_pos distance2D (_fPosAsl vectorAdd _moveFixTemp) > _fRad-1.25*_gSize) then {
						if (_x < _mHMin) then {_mHMin = _x;};
						if (_x > _mHMax) then {_mHMax = _x;};
					};
				} forEach _allVertexs;

				private _hBase = (_mHMax+_mHMin)/2;
				private _hFix = _raidTrainingMissionOriginalH-_hBase;
				private _newCenter = (BRPVP_raidTrainingMissionOriginalCenter select [0,2])+[(_centerVertex select 2)+_hFix];
				private _moveFix = _newCenter vectorDiff _centerVertex;
				private _vSet = [];
				{
					private _hMission = _x select 2;
					private _hBase = (_allVertexs select _forEachIndex)+_hFix;
					private _dist = (_x distance2D BRPVP_raidTrainingMissionOriginalCenter) min (_fRad+(_fRad min BRPVP_raidTrainingMaxExtraRad));
					private _multBase = 1;
					if (_dist > _fRad+_gSize) then {
						_multBase = 1-(((_dist-(_fRad+_gSize))/((_fRad min BRPVP_raidTrainingMaxExtraRad)-_gSize)) min 1);
						_multBase = _multBase^1;
					};
					_vSet pushBack [_x select 0,_x select 1,_hBase*_multBase+_hMission*(1-_multBase)];
				} forEach _raidTrainingMissionOriginalVertexSet;
				[_vSet,true] remoteExec ["BRPVP_raidTrainingDigTerrain",2];

				uiSleep 2.5;

				//BIG FLOORS
				{
					_x params ["_bfId","_pos","_igIdx","_owner"];
					[_bfId,_pos vectorAdd _moveFix,_igIdx,_owner] remoteExecCall ["BRPVP_bigFloorCreateRaidMission",2];
				} forEach (_baseDataWorld select 6);
				BRPVP_raidTrainingMissionBigFloors = _baseDataWorld select 6;

				private _vehicles = [];
				private _buildPosObjs = [];
				private _teleports = [];
				private _allBaseObjs = _baseDataWorld select 3;
				private _allMapObjs = [];
				private _mapIgnore =  _baseDataWorld select 9;
				{
					private _oStr = str _x;
					if (({(_oStr find _x) isNotEqualTo -1} count _mapIgnore) isEqualTo 0) then {
						private _modelo = typeOf _x;
						private _idx = BRPVP_allRaidBasesObjsClassNames find _modelo;
						if (_idx isEqualTo -1 && _modelo isNotEqualTo "") then {
							BRPVP_allRaidBasesObjsClassNames pushBack _modelo;
							_idx = count BRPVP_allRaidBasesObjsClassNames-1;
						};
						private _configName = configName (_x getVariable ["brpvp_tire_nameCFG",configNull]);
						private _idx2 = BRPVP_allRaidBasesObjsClassNames find _configName;
						if (_idx2 isEqualTo -1 && _configName isNotEqualTo "") then {
							BRPVP_allRaidBasesObjsClassNames pushBack _configName;
							_idx2 = count BRPVP_allRaidBasesObjsClassNames-1;
						};
						private _vu = (vectorUp _x) apply {(round (_x*100))/100};
						_vu = if (_vu isEqualTo [0,0,1]) then {1} else {_vu};
						private _sustenter = _x getVariable ["brpvp_sustenter_obj",objNull];
						private _isNullSustenter = isNull _sustenter;
						private _idx3 = BRPVP_allRaidBasesObjsClassNames find typeOf _sustenter;
						if (_idx3 isEqualTo -1 && typeOf _sustenter isNotEqualTo "") then {
							BRPVP_allRaidBasesObjsClassNames pushBack typeOf _sustenter;
							_idx3 = count BRPVP_allRaidBasesObjsClassNames-1;
						};
						private _svu = (vectorUp _sustenter) apply {(round (_x*100))/100};
						_svu = if (_svu isEqualTo [0,0,1]) then {1} else {_svu};
						private _isMotorizedNoTurret = _x call BRPVP_isMotorizedNoTurret;
						private _isBox = _x isKindOf "ReammoBox_F";
						private _line = [
							_idx,
							if (1 in (_baseDataWorld select 8)) then {(AGLToASL ((((getPosWorld _x vectorAdd _moveFix) select [0,2])+[0]) vectorAdd [0,0,vectorMagnitude((getPosWorld _x) vectorDiff (getPosASL _x))])) vectorAdd (_moveFix vectorMultiply -1)} else {getPosWorld _x},
							vectorDir _x,
							if (1 in (_baseDataWorld select 8)) then {1} else {_vu},
							if (typeOf _x isEqualTo "") then {getModelInfo _x select 1} else {0},
							[0,1] select isSimpleObject _x,
							getObjectScale _x,
							[0,1] select _isMotorizedNoTurret,
							[0,1] select _isNullSustenter,
							[[-1,[1,-1] select (_x getVariable ["id_bd",-1] isEqualTo -1)] select _isMotorizedNoTurret,_x getVariable ["id_bd",-1]] select (typeOf _x in BRP_kitEspecial),
							_x getVariable ["brpvp_tele_destine_id",-1],
							_x getVariable ["brpvp_dome_radius",-1],
							[0,getPosASL _x] select _isMotorizedNoTurret,
							if (_isNullSustenter) then {0} else {getPosWorld _sustenter},
							if (_isNullSustenter) then {-1} else {_idx3},
							if (_isNullSustenter) then {0} else {vectorDir _sustenter},
							if (_isNullSustenter) then {0} else {_svu},
							_idx2
						];
						_allMapObjs pushBackUnique _line;
					};
				} forEach nearestTerrainObjects [_fPosAsl,[],_fRad+_gSize,true,true];
				_allBaseObjs = _allMapObjs+_allBaseObjs;

				//POST OBJECTS
				if ((_baseDataWorld select 7) isNotEqualTo []) then {
					private _allPostObjs = [];
					{
						_x params ["_idx","_vdu","_pw","_so"];
						private _line = [
							_idx,
							_pw vectorAdd (_moveFix vectorMultiply -1),
							_vdu select 0,
							_vdu select 1,
							0,
							[0,1] select _so,
							1,
							0,
							1,
							-1,
							-1,
							-1,
							0,
							0,
							-1,
							0,
							0,
							-1
						];
						_allPostObjs pushBackUnique _line;
					} forEach (_baseDataWorld select 7);
					_allBaseObjs = _allBaseObjs+_allPostObjs;
				};

				//STRUCTURE
				BRPVP_allBaseObjsParam = [
					"_class",
					"_objPWL",
					"_objVD",
					"_objVU",
					"_modelPath",
					"_isSimpleObject",
					"_scale",
					"_isMotorizedNoTurret",
					"_isNullSustenter",
					"_o_id_bd",
					"_o_tele_destine_id",
					"_o_dome_radius",
					"_objASL",
					"_sustenterPWL",
					"_sustenterClass",
					"_sustenterVD",
					"_sustenterVU",
					"_vehClass"
				];
				private _removeAfter = [];
				{
					_x params BRPVP_allBaseObjsParam;
					private _ifOk = false;
					_class = [BRPVP_allRaidBasesObjsClassNames select _class,""] select (_class isEqualTo -1);
					_sustenterClass = [BRPVP_allRaidBasesObjsClassNames select _sustenterClass,""] select (_sustenterClass isEqualTo -1);
					_vehClass = [BRPVP_allRaidBasesObjsClassNames select _vehClass,""] select (_vehClass isEqualTo -1);
					_objVU = [_objVU,[0,0,1]] select (_objVU isEqualTo 1);
					if !(_class isKindOf "FlagCarrier" || _class in BRP_kitRespawnA || _class in BRP_kitRespawnB) then {
						private _newPos = _objPWL vectorAdd _moveFix;
						private _vdu = [_objVD,_objVU];
						if (_class isKindOf "Cargo_base_F") then {
						} else {
							if (_class isEqualTo "Land_GasTank_01_blue_F") then {
							} else {
								if (_class isEqualTo "") then {
									private _newObj = createSimpleObject [_modelPath,BRPVP_posicaoFora];
									_newObj setVectorDirAndUp _vdu;
									_newObj setPosWorld _newPos;
									BRPVP_raidTrainingMissionObjects pushBack _newObj;
									_ifOk = true;
								} else {
									if (_class in BRP_kitEspecial) then {
									} else {
										if (_class isKindOf "StaticWeapon") then {
										} else {
											if (_class isKindOf "ReammoBox_F") then {
											} else {
												if (_isSimpleObject isEqualTo 1) then {
													private _newObj = createSimpleObject [_class,BRPVP_posicaoFora];
													_newObj setVectorDirAndUp _vdu;
													_newObj setPosWorld _newPos;
													if (_scale isNotEqualTo 1) then {_newObj setObjectScale _scale;};
													if (BRPVP_kitGroupsCanDestroy find _class isNotEqualTo -1) then {_newObj setVariable ["brpvp_rto",true,true];};
													BRPVP_raidTrainingMissionObjects pushBack _newObj;
													_ifOk = true;
												} else {
													if (_class in ["PlasticBarrier_02_yellow_F","PlasticBarrier_02_grey_F"]) then {
													} else {
														if (_class isEqualTo "Land_ClutterCutter_medium_F") then {
														} else {
															if (_class isEqualTo "Land_Can_V2_F") then {
															} else {
																private _newObj = createVehicle [_class,BRPVP_posicaoFora,[],100,"CAN_COLLIDE"];
																_newObj setVectorDirAndUp _vdu;
																_newObj setPosWorld _newPos;
																_newObj addEventHandler ["HandleDamage",{call BRPVP_raidTrainingBuildingHd;}];
																if ((_newObj buildingPos -1) isNotEqualTo []) then {_buildPosObjs pushBack _newObj;};
																if (_class isEqualTo "Land_Airport_01_hangar_F") then {_newObj animate ["door_2_move",0,true];_newObj animate ["door_3_move",0,true];};
																BRPVP_raidTrainingMissionObjects pushBack _newObj;
																_ifOk = true;

																if (random 1 < 0.7) then {
																	_newObj setVariable ["brpvp_rto",true,true];
																	_newObj setVariable ["own",-2,true];
																	_newObj setVariable ["stp",4,true];
																	_newObj setVariable ["amg",[[],[],false],true];
																};
															};
														};
													};
												};
											};
										};
									};
								};
							};
						};
					};
					if (_ifOk && (1/diag_fps) <= BRPVP_raidTrainingCodeWait) then {uiSleep BRPVP_raidTrainingCodeWait;} else {if (random 1 < (1/((1/diag_fps)/BRPVP_raidTrainingCodeWait))) then {uiSleep 0.001;};};
					if (_ifOk) then {_removeAfter pushBack _x};
				} forEach _allBaseObjs;

				//ABOVE STRUCTURE
				private _boxMoneySum = 0;
				private _boxesDataNormal = [[1500000,1,true,0,1],[2000000,3,true,0,1],[1500000,1,true,2,1],[2000000,3,true,2,1]];
				private _boxesDataLocked = [[1000000,5,true,15,1],[500000,2,true,20,1]];
				private _allBaseObjs = (_allBaseObjs-_removeAfter) call BIS_fnc_arrayShuffle;
				{
					_x params BRPVP_allBaseObjsParam;
					private _ifOk = false;
					_class = [BRPVP_allRaidBasesObjsClassNames select _class,""] select (_class isEqualTo -1);
					_sustenterClass = [BRPVP_allRaidBasesObjsClassNames select _sustenterClass,""] select (_sustenterClass isEqualTo -1);
					_vehClass = [BRPVP_allRaidBasesObjsClassNames select _vehClass,""] select (_vehClass isEqualTo -1);
					_objVU = [_objVU,[0,0,1]] select (_objVU isEqualTo 1);
					if !(_class isKindOf "FlagCarrier" || _class in BRP_kitRespawnA || _class in BRP_kitRespawnB) then {
						private _newPos = _objPWL vectorAdd _moveFix;
						private _vdu = [_objVD,_objVU];
						if (_class isEqualTo "Land_GasTank_01_blue_F") then {
							private _items = [];
							private _extra = selectRandom [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
							for "_i" from 1 to 200 do {
								_items = _extra call BRPVP_createRandomBlueTankItems;
								if (_items isNotEqualTo []) exitWith {};
							};
							if (_items isNotEqualTo []) then {
								private _newObj = [_newPos,_vdu,_items] call BRPVP_spcItemsLootCreateRaidMission;
								_newObj addEventHandler ["HandleDamage",{0}];
								BRPVP_raidTrainingMissionObjects pushBack _newObj;
								_ifOk = true;
							};
						} else {
							if (_class isKindOf "Cargo_base_F") then {
								private _newObj = createSimpleObject [_class,BRPVP_posicaoFora];
								_newObj setVectorDirAndUp _vdu;
								_newObj setPosWorld _newPos;
								BRPVP_raidTrainingMissionObjects pushBack _newObj;
								_ifOk = true;
								//if (random 1 < 0.7) then {
								//	_newObj setVariable ["brpvp_rto",true,true];
								//	_newObj setVariable ["own",-2,true];
								//	_newObj setVariable ["stp",4,true];
								//	_newObj setVariable ["amg",[[],[],false],true];
								//};
							} else {
								if (_class isEqualTo "") then {
								} else {
									if (_class in BRP_kitEspecial && _isNullSustenter isEqualTo 1) then {
										if (_class in ["Sign_Sphere200cm_F","Land_RaiStone_01_F","Land_Communication_F","Land_CashDesk_F"]) then {
											private _newObj = createVehicle [_class,BRPVP_posicaoFora,[],20,"CAN_COLLIDE"];
											_newObj setVectorDirAndUp _vdu;
											_newObj setPosWorld _newPos;
											if (_class isEqualTo "Sign_Sphere200cm_F") then {};
											if (_class isEqualTo "Land_RaiStone_01_F") then {
												if (_o_id_bd isNotEqualTo -1) then {
													if (_o_tele_destine_id isNotEqualTo -1) then {_newObj setVariable ["brpvp_rto_tele_destine_id",_o_tele_destine_id,true];};
													_newObj setVariable ["brpvp_rto_id_bd",_o_id_bd,true];
													_teleports pushBack _newObj;
												};
											};
											if (_class isEqualTo "Land_Communication_F") then {
												if (_o_dome_radius isNotEqualTo -1) then {
													_newObj setVariable ["brpvp_dome_radius",_o_dome_radius,true];
												};
											};
											if (_class isEqualTo "Land_CashDesk_F") then {};
											_newObj setVariable ["brpvp_rto",true,true];
											BRPVP_raidTrainingMissionObjects pushBack _newObj;
											_ifOk = true;
										};
									} else {
										if (_class isKindOf "StaticWeapon") then {
										} else {
											if (_class isKindOf "ReammoBox_F") then {
												private _locked = random 1 < 0.25;
												private _boxData = [selectRandom _boxesDataNormal,selectRandom _boxesDataLocked] select _locked;
												private _newObj = createVehicle [_class,BRPVP_posicaoFora,[],100,"CAN_COLLIDE"];
												_newObj addEventHandler ["HandleDamage",{0}];
												if (_locked) then {[_newObj,10000] remoteExecCall ["setMaxLoad",2];} else {[_newObj,4000] remoteExecCall ["setMaxLoad",2];};
												_newObj setVectorDirAndUp _vdu;
												_newObj setPosWorld _newPos;
												([_newObj]+_boxData) call BRPVP_createCompleteLootBox;
												if (_boxMoneySum < _maxMoneyBase) then {
													{_newObj addMagazineCargoGlobal [_x,1];} forEach (_maxMoneyBox call BRPVP_itemMoneyCreate);
													_boxMoneySum = _boxMoneySum+_maxMoneyBox;
												};
												BRPVP_raidTrainingMissionObjects pushBack _newObj;
												_ifOk = true;

												if (_locked) then {
													_newObj setVariable ["brpvp_rto",true,true];
													_newObj setVariable ["own",-2,true];
													_newObj setVariable ["stp",4,true];
													_newObj setVariable ["amg",[[],[],false],true];
												};
												if !(_isNullSustenter isEqualTo 1) then {
													private _vec = _objPWL vectorDiff _sustenterPWL;
													private _susNew = createVehicle [_sustenterClass,BRPVP_posicaoFora,[],100,"CAN_COLLIDE"];
													_susNew setVectorDirAndUp [_sustenterVD,[_sustenterVU,[0,0,1]] select (_sustenterVU isEqualTo 1)];
													_susNew setPosWorld (getPosWorld _newObj vectorAdd (_vec vectorMultiply -1));
													_susNew hideObject true;
													[_susNew,true] remoteExecCall ["hideObjectGlobal",2];
													_newObj attachTo [_susNew,_susNew vectorWorldToModel _vec];
													_newObj setObjectScale _scale;
												} else {
													_newObj setVariable ["brpvp_del_when_empty",true,true];
												};
											} else {
												if (_isSimpleObject isEqualTo 1) then {
												} else {
													if (_class in ["PlasticBarrier_02_yellow_F","PlasticBarrier_02_grey_F"]) then {
														private _vdan = ([[0,0,0],_vdu select 0] call BIS_fnc_dirTo)-90;
														private _vd = [sin _vdan,cos _vdan,0];
														_vdu set [0,_vd];
														private _newObj = [_vehClass,_newPos,_vdu] call BRPVP_raidTrainingSpawnVeh;
														_vehicles pushBack _newObj;
														BRPVP_raidTrainingMissionObjects pushBack _newObj;
														_ifOk = true;
													} else {
														if (_class isEqualTo "Land_ClutterCutter_medium_F") then {
															//private _newObj = createVehicle [_class,BRPVP_posicaoFora,[],20,"CAN_COLLIDE"];
															//_newObj setVectorDirAndUp _vdu;
															//_newObj setPosWorld _newPos;
															////ADD HOLE MONEY OR BOX
															//BRPVP_raidTrainingMissionObjects pushBack _newObj;
															//_ifOk = true;
														} else {
															if (_class isEqualTo "Land_Can_V2_F") then {
																private _newObj = createVehicle [_class,BRPVP_posicaoFora,[],20,"CAN_COLLIDE"];
																_newObj setVectorDirAndUp _vdu;
																_newObj setPosWorld _newPos;
																_newObj setVariable ["brpvp_mine_base",true,true];
																_newObj setVariable ["brpvp_mine_base_owner",-2,true];
																_newObj setVariable ["brpvp_mine_base_friends",[],true];
																//_newObj setVariable ["brpvp_mine_base_id",0,true];
																//_newObj setVariable ["brpvp_mine_base_in_flag",false,true];
																_newObj enableSimulationGlobal false;
																BRPVP_raidTrainingMissionObjects pushBack _newObj;
																_ifOk = true;
															} else {
															};
														};
													};
												};
											};
										};
									};
								};
							};
						};
					};
					if (_ifOk && (1/diag_fps) <= BRPVP_raidTrainingCodeWait) then {uiSleep BRPVP_raidTrainingCodeWait;} else {if (random 1 < (1/((1/diag_fps)/BRPVP_raidTrainingCodeWait))) then {uiSleep 0.001;};};
				} forEach _allBaseObjs;

				//DELETE CAN'T USE TELEPORTS
				private _telesDel = [];
				private _telesIds = _teleports apply {_x getVariable "brpvp_rto_id_bd"};
				private _telesDestine = (_teleports apply {_x getVariable ["brpvp_rto_tele_destine_id",-1]})-[-1];
				{
					private _id = _x getVariable "brpvp_rto_id_bd";
					private _destine = _x getVariable ["brpvp_rto_tele_destine_id",-1];
					if !(_id in _telesDestine || _destine in _telesIds) then {
						_telesDel pushBack _x;
						deleteVehicle _x;
					};
				} forEach _teleports;
				BRPVP_raidTrainingMissionObjects = BRPVP_raidTrainingMissionObjects-_telesDel;

				//SPAWN BASE TURRETS
				private _allTurrets = (_baseDataWorld select 5) call BIS_fnc_arrayShuffle;
				private _allStatic = [];
				{
					private _ti = _x;
					private _inFlag = (_ti select 2) distance2D _fPosAsl <= _fRad;
					if (_inFlag) then {
						_ti params ["_modeloIdx","_vVDU","_vPWD","_exec"];
						if (_vVDU select 1 isEqualTo 1) then {_vVDU set [1,[0,0,1]];};
						private _hmg = createVehicle [BRPVP_allRaidBasesObjsClassNames select _modeloIdx,BRPVP_spawnVehicleFirstPos,[],20,"CAN_COLLIDE"];
						_hmg setVectorDirAndUp _vVDU;
						_hmg setPosWorld (_vPWD vectorAdd _moveFix);
						if (_exec isEqualTo 1) then {_hmg setVariable ['brpvp_tlevel',2,true];};
						_hmg setVariable ["own",-2,true];
						_hmg setVariable ["stp",4,true];
						_hmg setVariable ["amg",[[],[],false],true];
						_hmg remoteExecCall ["BRPVP_setTurretOperator",2];
						_hmg setVariable ["brpvp_dead_delete",true,2];
						_allStatic pushBack _hmg;
						BRPVP_raidTrainingMissionObjects pushBack _hmg;
						if (1/diag_fps <= BRPVP_raidTrainingCodeWait) then {uiSleep BRPVP_raidTrainingCodeWait;} else {if (random 1 < (1/((1/diag_fps)/BRPVP_raidTrainingCodeWait))) then {uiSleep 0.001;};};
					};
				} forEach _allTurrets;
				(_allStatic select [0,3]) spawn {
					uiSleep 10;
					{
						private _crew = crew _x;
						if (_crew isNotEqualTo []) then {
							private _operator = _crew select 0;
							_operator linkItem "H_HelmetO_ViperSP_hex_F";
						};
					} forEach _this;
				};

				//PUT SOME AI
				_buildPosObjs = _buildPosObjs call BIS_fnc_arrayShuffle;
				for "_i" from 1 to _numAI do {
					if (_buildPosObjs isEqualTo []) exitWith {};
					private _house = _buildPosObjs deleteAt 0;
					private _grupo = createGroup [INDEPENDENT,true];
					private _revoltoso = _grupo createUnit ["C_man_p_beggar_F",BRPVP_spawnAIFirstPos,[],20,"CAN_COLLIDE"];
					[_revoltoso] joinSilent _grupo;
					private _revWep = selectRandom [["arifle_MX_F","30Rnd_65x39_caseless_mag_Tracer",4],["SMG_02_F","30Rnd_9x21_Mag",4],["LMG_Zafir_pointer_F","150Rnd_762x54_Box_Tracer",2],["srifle_EBR_ACO_F","20Rnd_762x51_Mag",3],["hgun_Pistol_heavy_02_F","6Rnd_45ACP_Cylinder",5]];
					_revoltoso addBackpack "B_Carryall_cbr";
					unitBackpack _revoltoso addMagazineCargoGlobal [_revWep select 1,_revWep select 2];
					_revoltoso addWeapon (_revWep select 0);
					_revoltoso addEventHandler ["Killed",{if (random 1 < 0.75) then {(createVehicle ["Land_Suitcase_F",ASLToAGL getPosASL (_this select 0) vectorAdd [0,0,1.25],[],0,"CAN_COLLIDE"]) setVariable ["mny",round (200000*BRPVP_missionValueMult),true];};call BRPVP_botDaExp;}];
					_revoltoso addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
					_revoltoso setPosASL AGLToASL selectRandom (_house buildingPos -1);
					_revoltoso setSkill 0.35;
					_revoltoso setSkill ["aimingAccuracy",0.15];
					_revoltoso setDir random 360;
					_revoltoso setVariable ["brpvp_ai",true,true];
					BRPVP_raidTrainingMissionObjects pushBack _revoltoso;
				};

				//SET TO REAL VEHICLES
				_vehicles = _vehicles apply {[_x call BRPVP_getVehFullPrice,_x]};
				_vehicles sort false;
				_vehicles = _vehicles apply {_x select 1};				
				for "_i" from 1 to _numVeh do {
					if (_vehicles isEqualTo []) exitWith {};
					private _realVeh = _vehicles deleteAt ([_vehicles,3] call LOL_fnc_selectRandomFactorIdxOnly);
					private _isDrone = typeOf _realVeh in BRPVP_vantVehiclesClass;
					if (_isDrone) then {_realVeh setVariable ["brpvp_raid_mission_real_drone",true,true];} else {_realVeh addEventHandler ["GetIn",{call BRPVP_raidTrainingEhToRealVeh;}];};
				};
				{_x setVariable ["brpvp_fedidex",true,true];} forEach _vehicles;
			};
			BRPVP_raidTrainingCodeRunning = false;
		};
	};
	BRPVP_raidTrainingSpawnVeh = {
		params ["_class","_pos","_vdu"];
		private _veh = createVehicle [_class,BRPVP_spawnVehicleFirstPos,[],20,"CAN_COLLIDE"];
		_veh setVariable ["brpvp_time_can_disable",serverTime+5,2];
		_veh allowDamage false;
		_veh setVectorDirAndUp _vdu;
		_veh setPosASL (_pos vectorAdd [0,0,0.25]);

		//SET CUSTOM CARGO SIZE
		{
			_x params ["_veiculo","_name","_cargo"];
			if (_class isEqualTo _veiculo) exitWith {[_veh,_cargo] remoteExecCall ["setMaxLoad",2];};
		} forEach BRPVP_customCargoVehiclesCfg;

		_veh call BRPVP_setVehServicesToZero;
		//_veh call BRPVP_setVehRadarAndThermal;

		//DRONE STUFF
		if (_class isEqualTo "B_UAV_05_F") then {
			private _wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
			{_veh animateSource [_x,1,true];} forEach _wingAnimations;
		};
		if (_class in BRPVP_vantVehiclesClass) then {
			if (BRPVP_dronesMakeAllUnarmed) then {
				{
					_veh setPylonLoadout [configName _x,""];
				} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "pylons"));
			};
			_veh setVariable ["brpvp_auto_first",true,true];
		};

		//CLEAN VEH CARGO
		clearWeaponCargoGlobal _veh;
		clearMagazineCargoGlobal _veh;
		clearItemCargoGlobal _veh;
		clearBackpackCargoGlobal _veh;

		_veh remoteExecCall ["BRPVP_veiculoEhReset",2];

		//MAKE CHEAPER ON TRADER
		_veh setVariable ["brpvp_extra_sell_mult",0.8,true];

		_veh spawn {
			uiSleep 1;
			private _veh = _this;
			private _init = diag_tickTime;
			private _okCount = 0;
			private _limit = diag_fps;
			waitUntil {
				if (vectorMagnitude velocity _veh < 0.01) then {_okCount = _okCount+1;} else {_okCount = 0;};
				_okCount >= _limit || crew _veh isNotEqualTo [] || diag_tickTime-_init > 15
			};
			[_veh,true] remoteExecCall ["allowDamage",0];
		};
		
		_veh
	};
	BRPVP_raidTrainingEhToRealVeh = {
		params ["_veh","_role","_unit","_turret"];
		if (_unit getVariable ["own",-1] isNotEqualTo -1) then {
			if (!isNil "_thisEvent") then {_veh removeEventHandler [_thisEvent,_thisEventHandler];};
			_veh setVariable ["brpvp_rto_real_vehicle",true,true];
			_veh setVariable ["own",_unit getVariable ["own",-1],true];
			_veh setVariable ["stp",_unit getVariable ["stp",1],true];
			_veh setVariable ["amg",[_unit getVariable ["amg",[]],[],true],true];
			_veh setVariable ["brpvp_locked",false,true];
			_veh setVariable ["brpvp_no_insurance",true,true];
			private _estadoCons = [
				_veh call BRPVP_getCargoArray,
				[getPosWorld _veh,[vectorDir _veh,vectorUp _veh]],
				typeOf _veh,
				_veh getVariable "own",
				_veh getVariable "stp",
				_veh getVariable "amg",
				"_this setVariable ['brpvp_no_insurance',true,true];",
				[0,0,0,0,0,0],
				_veh call BRPVP_getVehicleAmmo,
				_veh call BRPVP_getHitpointsDamage,
				0
			];
			[false,_veh,_estadoCons] remoteExecCall ["BRPVP_adicionaConstrucaoBd",2];
			[_veh,["raid_training_real_veh",300]] remoteExecCall ["say3D",BRPVP_allNoServer];
		};
	};
	BRPVP_raidTrainingSpawnMagusVehicle = {
		params ["_tire","_player","_own","_stp","_amg"];
		if !(_tire getVariable ["brpvp_used",false]) then {
			_tire setVariable ["brpvp_used",true];
			_this spawn {
				params ["_tire","_player","_own","_stp","_amg"];
				private _class = _tire getVariable "brpvp_veh_info";
				private _pos = getPosWorld _tire;
				private _vdu = [vectorDir _tire,vectorUp _tire];
				private _realVeh = _tire getVariable ["brpvp_rto_real_vehicle",false];
				deleteVehicle _tire;
				[_player,["raid_training_magus",125]] remoteExecCall ["say3D",BRPVP_allNoServer];

				uiSleep 2.5;

				private _veh = createVehicle [_class,BRPVP_spawnVehicleFirstPos,[],20,"CAN_COLLIDE"];
				_veh setVariable ["brpvp_time_can_disable",serverTime+5,2];
				_veh allowDamage false;
				_veh setVectorDirAndUp _vdu;
				_veh setPosASL (_pos vectorAdd [0,0,0.25]);
				BRPVP_raidTrainingMissionObjects pushBack _veh;

				//SET CUSTOM CARGO SIZE
				{
					_x params ["_veiculo","_name","_cargo"];
					if (_class isEqualTo _veiculo) exitWith {[_veh,_cargo] remoteExecCall ["setMaxLoad",2];};
				} forEach BRPVP_customCargoVehiclesCfg;

				_veh call BRPVP_setVehServicesToZero;
				//_veh call BRPVP_setVehRadarAndThermal;

				//DRONE STUFF
				if (_class isEqualTo "B_UAV_05_F") then {
					private _wingAnimations = ["wing_fold_l_arm","wing_fold_l","wing_fold_cover_l_arm","wing_fold_cover_l","wing_fold_r_arm","wing_fold_r","wing_fold_cover_r_arm","wing_fold_cover_r"];
					{_veh animateSource [_x,1,true];} forEach _wingAnimations;
				};
				if (_class in BRPVP_vantVehiclesClass) then {
					if (BRPVP_dronesMakeAllUnarmed) then {
						{
							_veh setPylonLoadout [configName _x,""];
						} forEach ("true" configClasses (configFile >> "CfgVehicles" >> _class >> "Components" >> "TransportPylonsComponent" >> "pylons"));
					};
					_veh setVariable ["brpvp_auto_first",true,true];
				};

				//CLEAN VEH CARGO
				clearWeaponCargoGlobal _veh;
				clearMagazineCargoGlobal _veh;
				clearItemCargoGlobal _veh;
				clearBackpackCargoGlobal _veh;

				if (_realVeh) then {
					_veh setVariable ["brpvp_rto_real_vehicle",true,true];
					_veh setVariable ["own",_own,true];
					_veh setVariable ["stp",_stp,true];
					_veh setVariable ["amg",[_amg,[],true],true];
					_veh setVariable ["brpvp_locked",true,true];
					_veh setVariable ["brpvp_no_insurance",true,true];
					private _estadoCons = [
						_veh call BRPVP_getCargoArray,
						[getPosWorld _veh,[vectorDir _veh,vectorUp _veh]],
						typeOf _veh,
						_veh getVariable "own",
						_veh getVariable "stp",
						_veh getVariable "amg",
						"_this setVariable ['brpvp_no_insurance',true,true];",
						[0,0,0,0,0,0],
						_veh call BRPVP_getVehicleAmmo,
						_veh call BRPVP_getHitpointsDamage,
						0
					];
					[false,_veh,_estadoCons] remoteExecCall ["BRPVP_adicionaConstrucaoBd",2];
					[_veh,["raid_training_real_veh",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
				} else {
					_veh setVariable ["brpvp_fedidex",true,true];
					_veh remoteExecCall ["BRPVP_veiculoEhReset",2];

					//MAKE CHEAPER ON TRADER
					_veh setVariable ["brpvp_extra_sell_mult",0.65,true];
				};

				private _init = diag_tickTime;
				uiSleep 1;
				waitUntil {vectorMagnitude velocity _veh < 0.01 || crew _veh isNotEqualTo [] || diag_tickTime-_init > 20};
				[_veh,true] remoteExecCall ["allowDamage",0];
			};
		};
	};
	BRPVP_getVehFullPrice = {
		private _veh = _this;
		private _cls = typeOf _veh;
		private _prc = 0;
		{
			private _isFed = (_x select 0) isEqualTo "FEDIDEX";
			private _isCls = (_x select 3) == _cls;
			if (!_isFed && _isCls) exitWith {_prc = _x select 5;};
		} forEach BRPVP_tudoA3;
		_prc
	};
};