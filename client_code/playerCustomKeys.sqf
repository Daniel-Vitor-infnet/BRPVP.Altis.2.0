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

_scriptStart = diag_tickTime;
diag_log "[SCRIPT] playerCustomKeys.sqf BEGIN";

//VARS
BRPVP_lastPushedTime = 0;
BRPVP_remoteControlTime = 0;
BRPVP_bFlyFixMouse = {BRPVP_bFlyFixV = (BRPVP_bFlyFixV-(_this select 2)*0.0065) max -0.8 min 0.8;};
BRPVP_lastTimeChangedObject01 = 0;
BRPVP_lastTimeChangedObject02 = 0;
BRPVP_canJump = true;
BRPVP_buryMoneyActionOn = false;
BRPVP_planeBreakOn = false;
BRPVP_planeBreakTime = 0;
BRPVP_jumpStopRunning = false;
BRPVP_climbMidJumpTime = 0;
BRPVP_carryUsedObjs = [];
BRPVP_carryUsedLastTime = 0;
BRPVP_parachuteLastTime = 0;
BRPVP_parachuteAllLost = [objNull,objNull,objNull];
BRPVP_constantRunSadEnd = false;
BRPVP_nitroFlyWPressed = false;
BRPVP_skyDiveVelocity = [0.025*1.05,-0.004/1.05];
BRPVP_skyDiveUp = [0.00725*1.05,0.01925*1.05];
BRPVP_isJesusRun = false;
BRPVP_doubleOneWeaponTime = 0;
BRPVP_baseFlyKeyPressTime = 0;
BRPVP_mineDetectorKeyPressTime = 0;
BRPVP_lockUnlockKeyPressTime = 0;
BRPVP_selectBotTargetForTurretTime = 0;
BRPVP_colorMarkKeyPressTime = 0;
BRPVP_superRunLastPressTime = 0;
BRPVP_superRunPressCount = 0;
BRPVP_vehRattleLast = 0;
BRPVP_rattleArray = ["rattle_01","rattle_02","rattle_03","rattle_04","rattle_02","rattle_01","rattle_04","rattle_03","rattle_02","rattle_04","rattle_01","rattle_03"];
BRPVP_rattleIdx = 0;

//FUNCTIONS
BRPVP_sabotageSounds = {
	params ["_veh","_sndParams"];
	if (isNull objectParent player || {cameraView isEqualTo "EXTERNAL"}) then {
		_veh say3D _sndParams;
	} else {
		playSound3D [getMissionPath format ["BRP_sons\%1.ogg",_sndParams select 0],_veh];
		playSound3D [getMissionPath format ["BRP_sons\%1.ogg",_sndParams select 0],_veh];
	};
};
BRPVP_pushPerson = {
	params ["_displayorcontrol","_button","_xPos","_yPos","_shift","_ctrl","_alt"];
	private _isExecAnim = BRPVP_playerIsHealing || animationState player in ["amovpercmstpsraswrfldnon_amovpercmstpsnonwnondnon","amovpercmstpsnonwnondnon_exercisekneebendb","amovpercmstpsraswrfldnon_amovpknlmstpsraswrfldnon","ainvpknlmstpslaywrfldnon_medic","ainvpknlmstpslaywrfldnon_medicdummyend"];
	if (_button isEqualTo 0 && isNull findDisplay 602 && !visibleMap && !_isExecAnim) then {
		private _interval = diag_tickTime-BRPVP_lastPushedTime;
		if (currentWeapon player isEqualTo "" && {!isNull findDisplay 46 && _interval > 0.65 && lifeState player in ["HEALTHY","INJURED"] && animationState player find "unconscious" isNotEqualTo 0}) then {
			if (position player select 2 > 0.25) then {player setVelocity (velocity player vectorMultiply 0.6);};
			private _dir = getDir player;
			private _result = [[1000,objNull]];
			private _noA = (player nearObjects ["CaManBase",1])-[player];
			private _noB = (player nearObjects ["CaManBase",2])-[player];
			private _noC = (player nearObjects ["CaManBase",3])-[player];
			_noC = _noC-_noB;
			_noB = _noB-_noA;
			_noA = _noA apply {[[0,1] select (incapacitatedState _x isEqualTo "UNCONSCIOUS"),_x]};
			_noB = _noB apply {[[0,1] select (incapacitatedState _x isEqualTo "UNCONSCIOUS"),_x]};
			_noC = _noC apply {[[0,1] select (incapacitatedState _x isEqualTo "UNCONSCIOUS"),_x]};
			_noA sort true;
			_noB sort true;
			_noC sort true;
			_noA = _noA apply {_x select 1};
			_noB = _noB apply {_x select 1};
			_noC = _noC apply {_x select 1};
			{
				_x params ["_objs","_lim"];
				{
					private _lis = lineIntersectsSurfaces [getPosASL player vectorAdd [0,0,1],getPosASL _x vectorAdd [0,0,1],player,_x,true,1,"GEOM","NONE"];
					private _dt = [player,_x] call BIS_fnc_dirTo;
					private _diff = abs(_dt-_dir);
					_diff = if (_diff > 180) then {_diff-180} else {_diff};
					if (_diff < _lim && (_lis select {!((_x select 2) isKindOf "CaManBase")}) isEqualTo []) then {_result pushBack [_diff,_x];};
				} forEach _objs;
			} forEach [
				[_noA,50],
				[_noB,45],
				[_noC,40]
			];
			_result sort true;
			private _co = _result select 0 select 1;
			_result deleteAt (count _result-1);
			if (BRPVP_boxeItemOn && _result isEqualTo []) then {
				private _vec = (getCameraViewDirection player) vectorMultiply 3.5;
				private _posCam = eyePos player;
				private _lis = lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,1,"GEOM","NONE"];
				_co = if (_lis isEqualTo []) then {objNull} else {_lis select 0 select 2};
				//if (!isNull _co && {_co call BRPVP_isMotorizedNoTurret && alive _co}) then {_co} else {objNull};
				if (_co isKindOf "CAManBase") then {_co = objectParent _co;};
				_co = if (!isNull _co && {_co call BRPVP_isMotorized && alive _co}) then {_co} else {objNull};
				private _sp = stance player;
				private _canPunch = _co getVariable ["brpvp_can_punch",true];
				if (!isNull _co && _canPunch && _sp in ["STAND","CROUCH"] && !BRPVP_safeZone) then {
					BRPVP_lastPushedTime = diag_tickTime;
					[player,"AwopPercMstpSgthWnonDnon_end"] remoteExecCall ["switchMove",0];
					[player,["upper_cut_2",200,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					[_co,player] remoteExec ["BRPVP_applyForceLocal",2];
				} else {
					if (_sp in ["STAND","CROUCH"]) then {
						BRPVP_lastPushedTime = diag_tickTime;
						[player,"AwopPercMstpSgthWnonDnon_end"] remoteExecCall ["switchMove",0];
					};
				};
			} else {
				private _cos = if (BRPVP_boxeItemOn) then {_result apply {_x select 1}} else {[_co]};
				private _sp = stance player;
				private _punchOk = false;
				if (BRPVP_boxeItemOn) then {[player,["upper_cut_2",200,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];} else {[player,["punch1",165,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];};
				{
					private _co = _x;
					private _isPVE = _co getVariable ["brpvp_pve_inside",0] > 0 && _co getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0;
					private _isCoGod = _co getVariable ["god",false] || _co getVariable ["brpvp_god_admin",false];
					private _isPlayer = _co call BRPVP_isPlayer;
					private _canPunch = _co getVariable ["brpvp_can_punch",true] && animationState _co isNotEqualTo "amovpercmstpsnonwnondnon_exercisekneebendb";
					if (!isNull _co && {_canPunch && simulationEnabled _co && _sp in ["STAND","CROUCH"] && (!_isPlayer || (_isPlayer && !BRPVP_safeZone))}) then {
						BRPVP_lastPushedTime = diag_tickTime;
						private _dirTo = [player,_co] call BIS_fnc_dirTo;

						//PUNCH EFFECT
						if (_isPVE || _isCoGod) then {
							if (BRPVP_boxeItemOn) then {[_co,[1.5*sin _dirTo,1.5*cos _dirTo,5],[],player] remoteExecCall ["BRPVP_makeUnitFall",_co];} else {[_co,[0,0,0],[],player] remoteExecCall ["BRPVP_makeUnitFall",_co];};
						} else {
							if (BRPVP_boxeItemOn) then {[_co,[1.5*sin _dirTo,1.5*cos _dirTo,5],[_co,1,player],player] remoteExecCall ["BRPVP_makeUnitFall",_co];} else {[_co,[0,0,0],[_co,0.25,player],player] remoteExecCall ["BRPVP_makeUnitFall",_co];};
						};
						_punchOk = true;
					};
				} forEach _cos;
				if (_punchOk) then {
					[player,"AwopPercMstpSgthWnonDnon_end"] remoteExecCall ["switchMove",0];
				} else {
					if (_sp in ["STAND","CROUCH"]) then {
						BRPVP_lastPushedTime = diag_tickTime;
						[player,"AwopPercMstpSgthWnonDnon_end"] remoteExecCall ["switchMove",0];
					};
				};
			};
		};
	};
};
BRPVP_menuCode = {
	if (_key isEqualTo 0x11 && _XXX) then {
		if (BRPVP_menuOpcoesSel >= 0) then {
			BRPVP_menuOpcoesSel = (BRPVP_menuOpcoesSel-1) mod count BRPVP_menuOpcoes;
			if (BRPVP_menuOpcoesSel isEqualTo -1) then {BRPVP_menuOpcoesSel = ((count BRPVP_menuOpcoes)-1);};
			call BRPVP_atualizaDebugMenu;
			call BRPVP_menuOptionCode;
			"hint" call BRPVP_playSound;
		};
	};
	if (_key isEqualTo 0x1F && _XXX) then {
		if (BRPVP_menuOpcoesSel >= 0) then {
			BRPVP_menuOpcoesSel = (BRPVP_menuOpcoesSel+1) mod count BRPVP_menuOpcoes;
			call BRPVP_atualizaDebugMenu;
			call BRPVP_menuOptionCode;
			"hint" call BRPVP_playSound;
		};
	};
	if (_key isEqualTo 0x39 && _XXX) then {
		if (call BRPVP_menuForceExit) then {
			"erro" call BRPVP_playSound;
			BRPVP_menuExtraLigado = false;
			hintSilent "";
			call BRPVP_atualizaDebug;
		} else {
			private ["_destino"];
			private _mTxtArray = BRPVP_menuPos select BRPVP_menuIdc select 0;
			private _newTxt = BRPVP_menuOpcoes select BRPVP_menuOpcoesSel;
			{_newTxt = [_newTxt,_x,""] call BRPVP_stringReplace;} forEach BRPVP_menuAutoSelectStringsToIgnore;
			private _irb = _newTxt find "@memory_remove_back@";
			if (_irb isNotEqualTo -1) then {_newTxt = _newTxt select [_irb+20,count _newTxt-(_irb+20)];};
			private _ira = _newTxt find "@memory_remove_after@";
			if (_ira isNotEqualTo -1) then {_newTxt = _newTxt select [0,_ira-1];};
			private _sameIdx = _mTxtArray find _newTxt;
			if (_sameIdx isEqualTo -1) then {
				_mTxtArray deleteAt 0;
				_mTxtArray pushBack _newTxt;
			} else {
				_mTxtArray = _mTxtArray-[_newTxt];
				_mTxtArray pushBack _newTxt;
			};
			BRPVP_menuPos set [BRPVP_menuIdc,[_mTxtArray,BRPVP_menuOpcoesSel]];
			if (BRPVP_menuTipo isEqualTo 0) then {
				call BRPVP_menuCodigo;
				if (BRPVP_menuDestino isEqualType []) then {
					_destino = BRPVP_menuDestino select BRPVP_menuOpcoesSel;
					_destino spawn BRPVP_menuMuda;
				} else {
					if (BRPVP_menuDestino >= 0) then {BRPVP_menuDestino spawn BRPVP_menuMuda;};
				};
			} else {
				if (BRPVP_menuTipo isEqualTo 2) then {
					(BRPVP_menuExecutaParam select BRPVP_menuOpcoesSel) call BRPVP_menuExecutaFuncao;
				};
			};
		};
	};
	if (_key isEqualTo 0x1E && _XXX) then {
		if (BRPVP_menuVoltar isEqualType 0) then {BRPVP_menuVoltar spawn BRPVP_menuMuda;} else {call BRPVP_menuVoltar;};
	};
};
BRPVP_baseFlyCode = {
	//BASE CONSTRUCTION FLY
	if (player getVariable ["sok",false] && isNull objectParent player && (player call BRPVP_pAlive)) then {
		//ON OR OFF
		if (_key isEqualTo 0x02 && _SXX) then {
			_retorno = true;
			if (time-BRPVP_baseFlyKeyPressTime > 0.25) then {
				BRPVP_baseFlyKeyPressTime = time;
				if (BRPVP_flyOnOffAdmin) then {
					"erro" call BRPVP_playSound;
				} else {
					_canContinue = BRPVP_flyOnOff || {[player,0] call BRPVP_insideFlagWithAccessExtraRadius && player call BRPVP_pAlive && (ASLToAGL getPosASL player) select 2 <= BRPVP_maxBuildHeight-2 && (animationState player find "halofreefall_") isEqualTo -1 && !(BRPVP_construindoItem isKindOf "FlagCarrier") && !(call BRPVP_checkForRaidState)};
					if (_canContinue) then {
						BRPVP_flyOnOff = !BRPVP_flyOnOff;
						if (BRPVP_flyOnOff) then {
							player setUnitFreefallHeight (BRPVP_maxBuildHeight+75);
							[localize "str_build_fly_on",-5] call BRPVP_hint;
							private _h = getPos player select 2;
							if (_h < 1) then {player setPosASL (getPosASL player vectorAdd [0,0,1.2-_h]);};
							player setVariable ["brpvp_no_colision_cam_base",true];
							0 spawn {
								waitUntil {
									waitUntil {!([player,0] call BRPVP_insideFlagWithAccessExtraRadius) || !(player call BRPVP_pAlive) || !BRPVP_flyOnOff || call BRPVP_checkForRaidState};
									if ((!([player,0] call BRPVP_insideFlagWithAccessExtraRadius) || call BRPVP_checkForRaidState) && player call BRPVP_pAlive && BRPVP_flyOnOff) then {
										private _count = 5;
										private _init = diag_tickTime;
										"upack_alarm" call BRPVP_playSound;
										["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\out_of_flag.paa'/><br/><t>"+str _count+"</t>",0,0,1,0,0,7457] call BRPVP_fnc_dynamicText;
										waitUntil {
											if (diag_tickTime-_init > 1) then {
												_count = _count-1;
												_init = diag_tickTime;
												["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\out_of_flag.paa'/><br/><t>"+str _count+"</t>",0,0,1,0,0,7457] call BRPVP_fnc_dynamicText;
											};
											_count isEqualTo 0 || [player,0] call BRPVP_insideFlagWithAccessExtraRadius || !([player,200] call BRPVP_insideFlagWithAccessExtraRadius) || !(player call BRPVP_pAlive) || !BRPVP_flyOnOff || !(call BRPVP_checkForRaidState)
										};
										["",0,0,0,0,0,7457] call BRPVP_fnc_dynamicText;
									};
									!([player,0] call BRPVP_insideFlagWithAccessExtraRadius) || !(player call BRPVP_pAlive) || !BRPVP_flyOnOff || call BRPVP_checkForRaidState
								};
								if (BRPVP_flyOnOff) then {
									BRPVP_flyOnOff = false;
									
									//RESET FLY
									BRPVP_flyAcell = false;
									BRPVP_flyA1 = false;
									BRPVP_flyA2 = false;
									BRPVP_flyB1 = false;
									BRPVP_flyB2 = false;
									BRPVP_flyC1 = false;
									BRPVP_flyC2 = false;
									
									[localize "str_build_fly_off",-5] call BRPVP_hint;
									player setVariable ["brpvp_no_colision_cam_base",false];

									player setUnitFreefallHeight 100;
								};
							};
						} else {
							//RESET FLY
							BRPVP_flyAcell = false;
							BRPVP_flyA1 = false;
							BRPVP_flyA2 = false;
							BRPVP_flyB1 = false;
							BRPVP_flyB2 = false;
							BRPVP_flyC1 = false;
							BRPVP_flyC2 = false;

							[localize "str_build_fly_off",-5] call BRPVP_hint;
							player setVariable ["brpvp_no_colision_cam_base",false];

							player setUnitFreefallHeight 100;
						};
					} else {
						"erro" call BRPVP_playSound;
					};
				};
			};
		};
		if (BRPVP_flyOnOff || BRPVP_flyOnOffAdmin) then {
			//ACELL
			if (_SXX) then {
				_retorno = true;
				if (!BRPVP_flyAcell) then {BRPVP_flyAcell = true;};
			};
			//FOWARD
			if (_key isEqualTo 0x11) then {
				_retorno = true;
				if (!BRPVP_flyA1) then {BRPVP_flyA1 = true;};
			};
			//BACKWARD
			if (_key isEqualTo 0x1F) then {
				_retorno = true;
				if (!BRPVP_flyA2) then {BRPVP_flyA2 = true;};
			};
			//UP
			if (_key isEqualTo 0x03) then {
				_retorno = true;
				if (!BRPVP_flyB1) then {BRPVP_flyB1 = true;};
			};
			//DOWN
			if (_key isEqualTo 0x04) then {
				_retorno = true;
				if (!BRPVP_flyB2) then {BRPVP_flyB2 = true;};
			};
			//RIGHT
			if (_key isEqualTo 0x20) then {
				_retorno = true;
				if (!BRPVP_flyC1) then {BRPVP_flyC1 = true;};
			};
			//LEFT
			if (_key isEqualTo 0x1E) then {
				_retorno = true;
				if (!BRPVP_flyC2) then {BRPVP_flyC2 = true;};
			};
		};
	};
};
BRPVP_lastConsObj1 = [];
BRPVP_lastConsObj2 = [];
BRPVP_consCode = {
	//USE TELEPORT
	if (_key isEqualTo 0xCF && _XXX) then {
		_retorno = true;
		private _co = cursorObject;
		private _isRai = typeOf _co isEqualTo "Land_RaiStone_01_F";
		private _isDb = _co getVariable ["id_bd",-1] > -1;
		if (_isRai && _isDb) then {["","","",_co] call BRPVP_teleUseCode;} else {"erro" call BRPVP_playSound;};
	};
	//CHANGE OBJECT -1
	if (_key isEqualTo 0x10 && _XXX) then {
		_retorno = true;
		if (time-BRPVP_lastTimeChangedObject01 > 0.15) then {
			BRPVP_lastTimeChangedObject01 = time;
			_conta = count BRPVP_construindoItens;
			BRPVP_construindoItemIdc = BRPVP_construindoItemIdc-1;
			if (BRPVP_construindoItemIdc isEqualTo -1) then {BRPVP_construindoItemIdc = (_conta-1);};
			BRPVP_construindoItem = BRPVP_construindoItens select BRPVP_construindoItemIdc;
			[] spawn BRPVP_consSpawnItem;
			"hint" call BRPVP_playSound;
		};
	};
	//CHANGE OBJECT +1
	if (_key isEqualTo 0x12 && _XXX) then {
		_retorno = true;
		if (time-BRPVP_lastTimeChangedObject02 > 0.15) then {
			BRPVP_lastTimeChangedObject02 = time;
			_conta = count BRPVP_construindoItens;
			BRPVP_construindoItemIdc = (BRPVP_construindoItemIdc+1) mod _conta;
			BRPVP_construindoItem = BRPVP_construindoItens select BRPVP_construindoItemIdc;
			[] spawn BRPVP_consSpawnItem;
			"hint" call BRPVP_playSound;
		};
	};
	//MUDA ANG
	if (_key isEqualTo 0x2D && _XXX) then {
		_retorno = true;
		_conta = count BRPVP_construindoAngsRotacao;
		BRPVP_construindoAngRotacaoIdc = (BRPVP_construindoAngRotacaoIdc+1) mod _conta;
		BRPVP_construindoAngRotacao = BRPVP_construindoAngsRotacao select BRPVP_construindoAngRotacaoIdc;
		call BRPVP_atualizaDebugMenu;
	};
	//RODA Z+ RODA Z-
	if ((_key isEqualTo 0x2E || _key isEqualTo 0x2C) && _XXX) then {
		_retorno = true;
		if (BRPVP_buildingObjCopyDir isEqualTo -1) then {
			_dAng = BRPVP_construindoAngRotacao;
			if (_key isEqualTo 0x2C) then {_dAng = -_dAng;};
			BRPVP_construindoAngRotacaoSet = (BRPVP_construindoAngRotacaoSet+_dAng+360) mod 360;
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_dAng remoteExecCall ["BRPVP_specSetMainVars08",BRPVP_specOnMeMachinesNoMe];};
		};
	};
	//SETA INTENSIDADE H
	if (_key isEqualTo 0x2F && _XXX) then {
		_retorno = true;
		_conta = count BRPVP_construindoHInts;
		BRPVP_construindoHIntIdc = (BRPVP_construindoHIntIdc+1) mod _conta;
		BRPVP_construindoHInt = BRPVP_construindoHInts select BRPVP_construindoHIntIdc;
		call BRPVP_atualizaDebugMenu;
	};
	//MOVE H + MOVE H -
	if ((_key isEqualTo 0x13 || _key isEqualTo 0x21) && _XXX) then {
		_retorno = true;
		if (BRPVP_buildingObjCopyH isEqualTo []) then {
			_h = BRPVP_construindoHInt;
			if (_key isEqualTo 0x21) then {_h = -_h;};
			BRPVP_construindoHIntSet = BRPVP_construindoHIntSet+_h;
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_h remoteExecCall ["BRPVP_specSetMainVars04",BRPVP_specOnMeMachinesNoMe];};
		};
	};
	//BRING NEAR OR MOVE FAR INTENSITY
	if (_key isEqualTo 0x30 && _XXX) then {
		_retorno = true;
		BRPVP_buildingBringDistIdx = (BRPVP_buildingBringDistIdx+1) mod count BRPVP_buildingBringDists;
		BRPVP_buildingBringDist = BRPVP_buildingBringDists select BRPVP_buildingBringDistIdx;
		call BRPVP_atualizaDebugMenu;
	};
	//BRING NEAR OR MOVE FAR
	if ((_key isEqualTo 0x14 || _key isEqualTo 0x22) && _XXX) then {
		_retorno = true;
		_d = BRPVP_buildingBringDist;
		if (_key isEqualTo 0x22) then {_d = -_d;};
		_bring_0 = getPosASL BRPVP_construindoItemObj vectorDiff getPosASL player;
		_bring_0 set [2,0];
		_mag = vectorMagnitude _bring_0;
		_newMag = if (_d < 0) then {(_mag+_d) max 3} else {_mag+_d};
		if (_mag isEqualTo 0) then {
			"erro" call BRPVP_playSound;
		} else {
			if ((_d < 0 && _mag > 3) || _d > 0) then {
				_bring = _bring_0 vectorMultiply (_newMag/_mag);
				if (BRPVP_construindoPega select 0 >= 0) then {
					_bring = _bring vectorDiff _bring_0;
					_h = _bring select 2;
					_bring set [2,0];
					_magDist = if (_d > 0) then {vectorMagnitude _bring} else {-vectorMagnitude _bring};
					BRPVP_construindoPega set [0,(BRPVP_construindoPega select 0)+_magDist];
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[0,BRPVP_construindoPega select 0] remoteExecCall ["BRPVP_specSetMainVars01",BRPVP_specOnMeMachinesNoMe];};
					BRPVP_construindoHIntSet = BRPVP_construindoHIntSet+_h;
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_h remoteExecCall ["BRPVP_specSetMainVars04",BRPVP_specOnMeMachinesNoMe];};
				} else {
					_pp = getPosASL player;
					_pp set [2,getPosASL BRPVP_construindoItemObj select 2];
					BRPVP_construindoItemObj setPosASL (_pp vectorAdd _bring);
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[_pp,_bring] remoteExecCall ["BRPVP_specSetMainVars09",BRPVP_specOnMeMachinesNoMe];};
				};
			} else {
				"erro" call BRPVP_playSound;
			};
		};
	};
	//COPY OBJECT DIR
	if (_key isEqualTo 0x16 && _XXX) then {
		_retorno = true;
		_wasOn = BRPVP_buildingObjCopyDir isNotEqualTo -1;
		_co = cursorObject;
		BRPVP_buildingObjCopyDirExtra = BRPVP_buildingObjCopyDirExtra+90;
		if (isNull _co || _co isEqualTo BRPVP_construindoItemObj) then {BRPVP_buildingObjCopyDir = -1;} else {BRPVP_buildingObjCopyDir = getDir _co;};
		if (BRPVP_buildingObjCopyDir isEqualTo -1) then {
			BRPVP_construindoAngRotacaoSet = getDir BRPVP_construindoItemObj;
			BRPVP_buildingObjCopyDirExtra = 270;
			BRPVP_construindoPega set [1,getDir player];
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[1,BRPVP_construindoPega select 1] remoteExecCall ["BRPVP_specSetMainVars01",BRPVP_specOnMeMachinesNoMe];};
			if (_wasOn) then {"buttom_off" call BRPVP_playSound;} else {"erro" call BRPVP_playSound;};
		} else {
			if (!_wasOn) then {"buttom_on" call BRPVP_playSound;};
		};
	};
	//COPY OBJECT HEIGHT
	if (_key isEqualTo 0x24 && _XXX) then {
		_retorno = true;
		_wasOn = BRPVP_buildingObjCopyH isNotEqualTo [];
		_co = cursorObject;
		if (isNull _co || _co isEqualTo BRPVP_construindoItemObj) then {BRPVP_buildingObjCopyH = [];} else {BRPVP_buildingObjCopyH = getPosWorld _co;};
		if (BRPVP_buildingObjCopyH isEqualTo []) then {if (_wasOn) then {"buttom_off" call BRPVP_playSound;} else {"erro" call BRPVP_playSound;};} else {if (!_wasOn) then {"buttom_on" call BRPVP_playSound;};};
	};
	//PEGA & SOLTA
	if (_key isEqualTo 0x39 && _XXX) then {
		_retorno = true;
		//CODE CCYUIO
		if (BRPVP_construindoPega select 0 isEqualTo -1) then {
			private _pP = (getPosworld player) select 2;
			private _oP = (getPosWorld BRPVP_construindoItemObj) select 2;
			private _construindoHIntSet = _oP-_pP;
			BRPVP_construindoPega = [player distance2D BRPVP_construindoItemObj,getDir player];
			BRPVP_construindoHIntSet = _construindoHIntSet;
			BRPVP_construindoDirPlyObj = [player,BRPVP_construindoItemObj] call BIS_fnc_dirTo;
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[BRPVP_construindoPega,BRPVP_construindoHIntSet,BRPVP_construindoDirPlyObj] remoteExecCall ["BRPVP_specSetMainVars10",BRPVP_specOnMeMachinesNoMe];};
			["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\grab_on.paa'/>",0,0.75,36000,0,0,54369] call BRPVP_fnc_dynamicText;
		} else {
			if (BRPVP_radialPlacementOn) then {
				"erro" call BRPVP_playSound;
			} else {
				BRPVP_construindoPega = [-1];
				BRPVP_construindoHIntSet = 0;
				if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {remoteExecCall ["BRPVP_specSetMainVars11",BRPVP_specOnMeMachinesNoMe];};
				["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\grab_off.paa'/>",0,0.75,36000,0,0,54369] call BRPVP_fnc_dynamicText;
			};
		};
	};
	//KEY Y
	if (_key isEqualTo 0x15 && _XXX) then {
		_retorno = true;
		//CODE CCYUIO
		if (BRPVP_construindoPega select 0 isEqualTo -1) then {
			private _pP = (getPosworld player) select 2;
			private _oP = (getPosWorld BRPVP_construindoItemObj) select 2;
			private _construindoHIntSet = _oP-_pP;
			BRPVP_construindoPega = [player distance2D BRPVP_construindoItemObj,getDir player];
			BRPVP_construindoHIntSet = _construindoHIntSet;
			BRPVP_construindoDirPlyObj = [player,BRPVP_construindoItemObj] call BIS_fnc_dirTo;
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[BRPVP_construindoPega,BRPVP_construindoHIntSet,BRPVP_construindoDirPlyObj,!BRPVP_radialPlacementOn] remoteExecCall ["BRPVP_specSetMainVars06",BRPVP_specOnMeMachinesNoMe];};
		} else {
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {!BRPVP_radialPlacementOn remoteExecCall ["BRPVP_specSetMainVars12",BRPVP_specOnMeMachinesNoMe];};
		};
		BRPVP_radialPlacementOn = !BRPVP_radialPlacementOn;
		call BRPVP_atualizaDebugMenu;
	};
	//KEY H 
	if (_key isEqualTo 0x23 && _XXX) then {
		_retorno = true;
		BRPVP_radialPlacementDirOn = !BRPVP_radialPlacementDirOn;
		if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {BRPVP_radialPlacementDirOn remoteExecCall ["BRPVP_specSetMainVars07",BRPVP_specOnMeMachinesNoMe];};
		call BRPVP_atualizaDebugMenu;
	};
	//CANCELA CONSTRUCAO
	if (_key isEqualTo 0xD3 && _XXX) then {
		_retorno = true;
		call BRPVP_cancelaConstrucao;
	};
	//CONCLUI POSITIVO
	if (_key isEqualTo 0x1C && _XXX) then {
		private ["_vComplete","_isSO","_vdu","_estadoCons","_actualRespawnSpots","_flagOk"];
		BRPVP_construindoConcluindoPositivo = true;
		_retorno = true;

		private _attachToArray = [];
		if (BRPVP_consItemAttach isNotEqualTo []) then {
			deleteVehicle (BRPVP_consItemAttach select 0);
			_attachToArray = (BRPVP_consItemAttach select 1);
			BRPVP_consItemAttach = [];
		};

		//BUILD PRICE
		_ok = true;
		_removeBuildingPrice = 0;
		if (BRPVP_consBuildingCost > 0) then {
			_mny = player getVariable ["mny",0];
			if (_mny >= BRPVP_consBuildingCost) then {
				_removeBuildingPrice = BRPVP_consBuildingCost;
			} else {
				"erro" call BRPVP_playSound;
				[format [localize "str_mny_need_x_in_wallet",BRPVP_consBuildingCost],-4.5] call BRPVP_hint;
				_ok = false;
			};
		};
		if (!_ok) exitWith {};

		//IS OBJECT MOVE?
		_isBox = BRPVP_consMovObj iskindOf "ReammoBox_F";
		_isStatic = BRPVP_consMovObj isKindOf "StaticWeapon";
		_isCreating = isNull BRPVP_consMovObj || !(BRPVP_consMovObj call BRPVP_isCompleteBox || _isStatic || netId BRPVP_consMovObj isEqualTo "0:0");
		_deleteOld = !isNull BRPVP_consMovObj && !(BRPVP_consMovObj call BRPVP_isCompleteBox || _isStatic || netId BRPVP_consMovObj isEqualTo "0:0");

		//SET FLAG RADIUS TO PRESERVE CODE
		private _isFlag = BRPVP_construindoItemObj isKindOf "FlagCarrier";
		if (_isFlag && _isCreating) then {BRPVP_construindoItemObj setVariable ["brpvp_flag_radius",BRPVP_construindoItemObj call BRPVP_getFlagRadius];};

		//CHECK IF ABOVE MAX HEGHT
		_bbr = 0 boundingBoxReal BRPVP_construindoItemObj;
		_bbrP1 = _bbr select 0;
		_bbrP2 = _bbr select 1;
		_bbrHMin = (_bbrP1 select 2) min (_bbrP2 select 2);
		_foot = _bbrP1 vectorAdd _bbrP2 vectorMultiply 0.5;
		_foot set [2,_bbrHMin];
		_h = (BRPVP_construindoItemObj modelToWorld _foot) select 2;
		if (_h > BRPVP_maxBuildHeight && !BRPVP_vePlayers) exitWith {[format [localize "str_cons_too_high",ceil _h,round BRPVP_maxBuildHeight],-6.5] call BRPVP_hint;};

		//CHECK IF MALICIOUS REPEAT TO HURT SERVER FPS
		private _posTheSame = (nearestObjects [BRPVP_construindoItemObj,[],0.25]) select {_x isKindOf BRPVP_construindoItemObjClass && _x getVariable ["id_bd",-1] isNotEqualTo -1};
		private _posAndAngleTheSame = _posTheSame select {((vectorDir _x vectorCos vectorDir BRPVP_construindoItemObj) >= 1 || {acos (vectorDir _x vectorCos vectorDir BRPVP_construindoItemObj) < 5}) && ((vectorDir _x vectorCos vectorDir BRPVP_construindoItemObj) >= 1 || {acos (vectorUp _x vectorCos vectorUp BRPVP_construindoItemObj) < 5})};
		if (_posAndAngleTheSame isNotEqualTo []) exitWith {"erro" call BRPVP_playSound;};

		//CHECK IF ON GROUND
		_groundOk = false;
		_grounded = [];
		if (BRPVP_construindoItemObjClass in BRPVP_iBelieveICanFlyObjects || BRPVP_vePlayers || !BRPVP_constructionObjectsMustBeGrounded) then {
			_groundOk = true;
		} else {
			_h = ASLToAGL getPosWorld BRPVP_construindoItemObj select 2;
			_bbox = boundingBoxReal BRPVP_construindoItemObj;
			_bbH = abs ((_bbox select 0 select 2)-(_bbox select 1 select 2));
			if (_h > _bbH/2+0.25) then {
				{
					if (typeOf _x isKindOf ["Building",configFile >> "CfgVehicles"]) then {
						_grounded append ([BRPVP_construindoItemObj,_x] call BRPVP_objGroundyOnOther);
					};
				} forEach (nearestObjects [BRPVP_construindoItemObj,[],50]-[BRPVP_construindoItemObj]);
				_grounded = _grounded arrayIntersect _grounded;
				_grounded sort true;
				_groundOk = _grounded isEqualTo [0,1,2,3];
			} else {
				_groundOk = true;
			};
		};
		if !(_groundOk) exitWith {
			"erro" call BRPVP_playSound;
			[format [localize "str_cons_cant_not_grounded",count _grounded],-6] call BRPVP_hint;
		};

		//CHECK IF MILITAR BUILDINGS NEAR IF CONSTRUCTING FLAG
		_flagRad = BRPVP_construindoItemObj getVariable ["brpvp_flag_radius",0];
		_deniedBuildingsNear = false;
		if (_isFlag && !BRPVP_vePlayers) then {
			_objs = nearestObjects [BRPVP_construindoItemObj,BRPVP_cantBuildNearBuildings,BRPVP_cantBuildNearDistance,true];
			_deniedBuildingsNear = {_x getVariable ["id_bd",-1] isEqualTo -1} count _objs > BRPVP_cantBuildNearLimit;
		};
		if (_deniedBuildingsNear) exitWith {[format [localize "str_cons_cant_militar",BRPVP_cantBuildNearDistance],4,12,854,"erro"] call BRPVP_hint;};

		//CHECK IF FLAG COMBINATION IS ALLOWED
		if (!_deleteOld && _isFlag && {!([player,BRPVP_construindoItemObj] call BRPVP_checkIfNewFlagAllowed) && !BRPVP_vePlayers}) exitWith {[localize "str_cons_cant_comb_flags",6,12,854,"erro"] call BRPVP_hint;};

		//CHECK IF DENIED BY ENEMY FLAG (FIO)
		if (BRPVP_construindoItemObj call BRPVP_checkIfFlagDenied && !BRPVP_vePlayers) exitWith {[localize "str_cons_cant_enemy_flag",4,12,854,"erro"] call BRPVP_hint;};

		//CHECK IF FLAG NEAR MISSION
		if (_isFlag && {{BRPVP_construindoItemObj distance2D _x < 300+_flagRad} count BRPVP_missionsPos > 0 && !BRPVP_vePlayers}) exitWith {[localize "str_cant_flag_near_miss",-6,12,854,"erro"] call BRPVP_hint;};

		//CHECK IF NEAR LAND
		_ok = true;
		if (BRPVP_waterBasesLimitUse && _isFlag && !BRPVP_vePlayers) then {
			_ok = [getPosWorld BRPVP_construindoItemObj,BRPVP_waterBasesLimitDistance] call BRPVP_checkIfLandNear;
		};
		if (!_ok) exitWith {[format [localize "str_flag_no_near_land",BRPVP_waterBasesLimitDistance],-5] call BRPVP_hint;};

		//CHECK IF FLAG NEAR (FIO)
		_ok = true;
		if (_isFlag && BRPVP_flagsMinimumDistance > 0 && !BRPVP_vePlayers) then {
			{
				private _rad = _x getVariable ["brpvp_flag_radius",0];
				if (_x distance BRPVP_construindoItemObj < _flagRad+_rad+BRPVP_flagsMinimumDistance) exitWith {_ok = false;};
			} forEach (nearestObjects [BRPVP_construindoItemObj,["FlagCarrier"],BRPVP_flagsMinimumDistance+_flagRad+200,true]-[BRPVP_consMovObj]);
		};
		if (!_ok) exitWith {[format [localize "str_flag_near",BRPVP_flagsMinimumDistance],-5] call BRPVP_hint;};

		//CHECK IF FLAG IN OTHER FLAG AREA (FIO)
		_flagOk = true;
		if (_isFlag && !BRPVP_vePlayers) then {
			_mult = 1-BRPVP_flagsAreasIntersectionAllowed;
			{
				if (!isObjectHidden _x) then {
					if (BRPVP_construindoItemObj distance2D _x <= (_x getVariable ["brpvp_flag_radius",0])*_mult+_flagRad*_mult) exitWith {_flagOk = false;};
				};
			} forEach (nearestObjects [BRPVP_construindoItemObj,["FlagCarrier"],400,true]-[BRPVP_consMovObj]);
		};
		if (!_flagOk) exitWith {[localize "str_cons_cant_flag_2x",4,12,854,"erro"] call BRPVP_hint;};

		//CHECK IF BUILDING OUT OF FLAG AREA AND CONSTRUCT OUT OF FLAG NOT ALLOWED (FIO)		
		_flagOk = false;
		if (!_isFlag) then {
			{
				if ([player,_x] call BRPVP_checaAcessoRemotoFlag && BRPVP_construindoItemObj distance2D _x <= _x getVariable ["brpvp_flag_radius",0]) exitWith {
					_flagOk = true;
				};
			} forEach nearestObjects [BRPVP_construindoItemObj,["FlagCarrier"],200,true];
		};
		if (!_isFlag && {!_flagOk && !BRPVP_vePlayers && !BRPVP_allowBuildingsAwayFromFlags}) exitWith {[localize "str_cons_cant_flag",4,12,854,"erro"] call BRPVP_hint;};

		//CAN'T BUILD IF FLAG RECEIVED A RECENT RAID ACTION (FIO)
		_recentRaidAction = false;
		_lraTimeA = 0;
		_lraTimeB = 0;
		if (BRPVP_raidNoConstructionOnBaseIfRaidStarted && !BRPVP_vePlayers) then {
			_flags = [];
			{
				_rad = _x getVariable ["brpvp_flag_radius",0];
				_dist = _x distance2D BRPVP_construindoItemObj;
				if (_dist < _rad) then {_flags pushBack _x;};
			} forEach nearestObjects [BRPVP_construindoItemObj,["FlagCarrier"],200,true];
			{
				_lra = _x getVariable ["brpvp_last_intrusion",-BRPVP_raidNoConstructionOnBaseIfRaidStartedTime];
				_recentRaidAction = serverTime-_lra < BRPVP_raidNoConstructionOnBaseIfRaidStartedTime;
				if (_recentRaidAction) exitWith {
					_lraTimeA = (BRPVP_raidNoConstructionOnBaseIfRaidStartedTime-(serverTime-_lra))/60;
					_lraTimeB = (BRPVP_raidNoConstructionOnBaseIfRaidStartedTime/60)-_lraTimeA;
					_lraTimeA = ceil _lraTimeA;
					_lraTimeB = floor _lraTimeB;
				};
			} forEach _flags;
		};
		if (_recentRaidAction) exitWith {[format [localize "str_cons_cant_recent_raid",_lraTimeB,_lraTimeA],-6] call BRPVP_hint;};

		//CHECK IF IS RESPAWN SPOT AND IF CAN BUILD
		_isRespawnSpot = BRPVP_construindoItemObjClass in (BRP_kitRespawnA+BRP_kitRespawnB);
		if (_isRespawnSpot && _isCreating && !BRPVP_vePlayers && {count (call BRPVP_findMySpawns-[BRPVP_consMovObj,BRPVP_construindoItemObj]) >= BRPVP_personalSpawnCountLimit}) exitWith {[localize "str_resp_cant_set",4,12,6374,"erro"] call BRPVP_hint;};

		//CHECK IF CONSTRUCTING FLAG IN NO-BUILD AREA
		_objInNoBuildArea = false;
		if (_isFlag && !BRPVP_vePlayers) then {
			_objPos = ASLToAGL getPosASL BRPVP_construindoItemObj;
			{
				_x params ["_places","_extraRadius"];
				if ({_objPos distance2D (_x select 0) < (_x select 1)+_extraRadius+_flagRad} count _places > 0) exitWith {_objInNoBuildArea = true;};
			} forEach BRPVP_placesExtraNobuildArea;
		};
		if (_objInNoBuildArea) exitWith {[localize "str_cons_cant_nobuild_area",-4,12,854,"erro"] call BRPVP_hint;};

		//CHECK IF TURRET FLAG LIMIT REACHED IF TURRET (FIO)
		if (_isCreating && BRPVP_construindoItemObjClass in BRP_kitAutoTurret && {[BRPVP_construindoItemObj,0] call BRPVP_turretsOnFlagLimitReached && !BRPVP_vePlayers}) exitWith {[localize "str_turret_limit_reached",-5] call BRPVP_hint;};
		
		//CHECK IF TURRET FLAG LIMIT REACHED IF FLAG (FIO)
		_turretLimitExceeded = false;
		if (_isFlag && !BRPVP_vePlayers) then {
			_limit = 0;
			{if (_flagRad isEqualTo (_x select 0)) exitWith {_limit = _x select 1;};} forEach BRPVP_turretTerrainLimit;
			if (count nearestObjects [BRPVP_construindoItemObj,BRP_kitAutoTurret,_flagRad,true] > _limit) then {_turretLimitExceeded = true;};
		};
		if (_turretLimitExceeded) exitWith {[localize "str_cant_build_turret_limit",-6] call BRPVP_hint;};

		//CHECK IF TOO MUCH ALIGNED GATES NEAR IF GATE
		if (BRPVP_construindoItemObj call BRPVP_findAlignedGates > BRPVP_maxAlignedGates && !BRPVP_vePlayers) exitWith {[format [localize "str_cant_build_gate_limit",BRPVP_maxAlignedGates],-6] call BRPVP_hint;};

		//CHECK IF TOO MANY GATES ON FLAG (FIO)
		_gatesOk = true;
		_error = -1;
		if (BRPVP_construindoItemObjClass in BRPVP_kitGroupsGates && !BRPVP_vePlayers) then {
			_flags = [];
			{
				_rad = _x getVariable ["brpvp_flag_radius",0];
				_dist = _x distance2D BRPVP_construindoItemObj;
				if (_dist < _rad) then {
					_limit = -1;
					{if (_x select 0 isEqualTo _rad) exitWith {_limit = _x select 1;};} forEach BRPVP_gateTerrainLimit;
					_flags pushBack [_x,_rad,_limit];
				};
			} forEach nearestObjects [BRPVP_construindoItemObj,["FlagCarrier"],400,true];
			{
				_x params ["_flag","_rad","_limit"];
				_gates = 1+count nearestObjects [_flag,BRPVP_kitGroupsGates,_rad,true];
				if (_gates > _limit) exitWith {
					_gatesOk = false;
					_error = _limit;
				};
			} forEach _flags;
		};
		if (!_gatesOk) exitWith {[format [localize "str_gate_limit_cant",_error],-5] call BRPVP_hint;};

		//CHECK IF FLAG IS NEAR ENEMY FLAG (FIO)
		_eNear = false;
		if (_isFlag) then {_eNear = [BRPVP_construindoItemObj,BRPVP_flagsMinimumDistanceEnemy] call BRPVP_checkIfEnemyFlagExtraRadius;};
		if (_eNear && !BRPVP_vePlayers) exitWith {[format[localize "str_cant_enemy_flag_near",BRPVP_flagsMinimumDistanceEnemy],-8] call BRPVP_hint;};

		if (_isCreating) then {
			//CREATE FINAL OBJECT (GLOBAL) AND DELETE TEMPORARY ONE (LOCAL)
			BRPVP_construindoItemObj removeAllEventHandlers "HandleDamage";
			_posA = getPosASL BRPVP_construindoItemObj;
			_posW = getPosWorld BRPVP_construindoItemObj;
			_vdu = [vectorDir BRPVP_construindoItemObj,vectorUp BRPVP_construindoItemObj];
			if (BRPVP_construindoItemObjClass in BRPVP_buildingHaveDoorList) then {
				_vComplete = createVehicle [BRPVP_construindoItemObjClass,BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
				_vComplete addEventHAndler ["HandleDamage",{0}];
				_isSO = false;
			} else {
				_vComplete = createSimpleObject [BRPVP_construindoItemObjClass,AGLToASL BRPVP_posicaoFora];
				_isSO = true;
			};
			deleteVehicle BRPVP_construindoItemObj;
			BRPVP_construindoItemObj = _vComplete;

			//SET FLAG RADIUS TO PRESERVE CODE
			if (_isFlag && _isCreating) then {BRPVP_construindoItemObj setVariable ["brpvp_flag_radius",BRPVP_construindoItemObj call BRPVP_getFlagRadius,true];};

			_hasSet = false;
			if (typeOf BRPVP_construindoItemObj isEqualTo BRPVP_superBoxClass) then {
				private _attachHelper = createSimpleObject ["Land_Obstacle_Ramp_F",BRPVP_posicaoFora];
				private _sustenter = BRPVP_superBoxClass createVehicle BRPVP_posicaoFora;
				_sustenter hideObject true;
				private _sH = vectorMagnitude (getPosWorld _sustenter vectorDiff getPosASL _sustenter);
				[_posW,_vdu,_attachHelper,_sustenter,BRPVP_construindoItemObj] remoteExecCall ["BRPVP_bigBoxVisualHelp",BRPVP_allNoServer];
				BRPVP_construindoItemObj setVariable ["brpvp_sustenter_obj",_sustenter,true];
				[BRPVP_construindoItemObj,BRPVP_superBoxCargoSize] remoteExecCall ["setMaxLoad",2];
				_sustenter setVectorDirAndUp _vdu;
				_sustenter setPosASL _posW;
				BRPVP_construindoItemObj attachTo [_sustenter,[0,0,-_sH]];
				_sustenter hideObject true;
				[_sustenter,true] remoteExecCall ["hideObjectGlobal",2];
				//BRPVP_construindoItemObj spawn {_this setDir 0;_this setObjectScale BRPVP_superBoxScale;};
				_attachHelper attachTo [BRPVP_construindoItemObj,_attachToArray];
				_sustenter setVariable ["brpvp_real_box",BRPVP_construindoItemObj,true];
				_sustenter call BRPVP_emptyBox;
			} else {
				BRPVP_construindoItemObj setVectorDirAndUp _vdu;
				BRPVP_construindoItemObj setPosWorld _posW;
			};

			//TRY TO MOUNT HOTEL
			if (BRPVP_construindoItemObjClass in ["Land_GH_MainBuilding_left_F","Land_GH_MainBuilding_right_F"]) then {BRPVP_construindoItemObj call BRPVP_alignByCenterObjHotel;};

			//TRY TO MOUNT HOSPITAL
			if (BRPVP_construindoItemObjClass in ["Land_Hospital_side1_F","Land_Hospital_side2_F"]) then {BRPVP_construindoItemObj call BRPVP_alignByCenterObjHospital;};

			//TRY TO MOUNT AIRPORT
			if (BRPVP_construindoItemObjClass in ["Land_Airport_left_F","Land_Airport_right_F"]) then {BRPVP_construindoItemObj call BRPVP_alignByCenterObjAirport;};

			//FLAG CODE
			if (_isFlag && !_deleteOld) then {
				[BRPVP_construindoItemObj,{BRPVP_allFlags pushBack _this;}] remoteExecCall ["call",0];
				BRPVP_myStuffOthers pushBackUnique BRPVP_construindoItemObj;

				//UPDATE VISUALIZATION OF PLAYER FLAG BUILDINGS
				private _myFlagsSeeBuildingsOnMap = [];
				{_myFlagsSeeBuildingsOnMap append (_x select 2);} forEach BRPVP_myFlagsSeeBuildingsOnMap;
				_add = [];
				{if (_x getVariable ["id_bd",-1] != -1 && _x call BRPVP_isBaseMapDraw) then {_add pushBack _x;};} forEach ((nearestObjects [BRPVP_construindoItemObj,[],_flagRad,true])-_myFlagsSeeBuildingsOnMap);
				BRPVP_myFlagsSeeBuildingsOnMap pushBack [BRPVP_construindoItemObj,_flagRad,_add];

				//SET FLAG LAST PAY
				BRPVP_construindoItemObj setVariable ["brpvp_lastPayment",BRPVP_sessionTimeStamp,true];
			};

			//SET LAMP STATE
			_exec = "";
			if (BRPVP_construindoItemObjClass in BRP_kitLamp) then {
				BRPVP_construindoItemObj setDamage 0.9;
				_exec = "_this setDamage 0.9;";
			};

			//CREATE TURRETER FOR TURRETS
			if (BRPVP_construindoItemObjClass in BRP_kitAutoTurret) then {
				if (BRPVP_construindoItemRetira isEqualTo 112) then {
					BRPVP_construindoItemObj setVariable ["brpvp_tlevel",2,true];
					_exec = "_this setVariable ['brpvp_tlevel',2,true];";
					BRPVP_construindoItemObj setVariable ["brpvp_exec",_exec,2];
					BRPVP_construindoItemObj setVariable ["brpvp_tupdated",true,2];
				} else {
					BRPVP_construindoItemObj setVariable ["brpvp_exec","",2];
				};
			};

			//REMOVE VEGETATION IF Land_GarbageBin_02_F
			if (BRPVP_construindoItemObjClass isEqualTo "Land_GarbageBin_02_F") then {
				_exec = "_this call BRPVP_areaCleanerExec;";
				BRPVP_construindoItemObj call BRPVP_areaCleanerExec;
			};

			//REMOVE NEAREST TREE IF SHOVEL
			if (BRPVP_construindoItemObjClass isEqualTo "Land_Shovel_F") then {
				_exec = "_this call BRPVP_removeNearestTree;";
				BRPVP_construindoItemObj call BRPVP_removeNearestTree;
			};

			BRPVP_construindo = false;
			player setVariable ["bdg",false,true];
			//call BRPVP_atualizaDebugMenu;
			BRPVP_construindoItemIdc = 0;
			BRPVP_construindoItemObj setVariable ["id_bd",1,true]; //TEMP id_bd UNTIL MYSQL RETURN THE REAL id_bd
			if (_deleteOld) then {
				BRPVP_construindoItemObj setVariable ["own",BRPVP_consMovObj getVariable ["own",-1],true];
				BRPVP_construindoItemObj setVariable ["stp",BRPVP_consMovObj getVariable ["stp",1],true];
				BRPVP_construindoItemObj setVariable ["amg",BRPVP_consMovObj getVariable ["amg",[[],[],true]],true];
				//TELEPORT
				_teleId = BRPVP_consMovObj getVariable ["brpvp_tele_destine_id",-1];
				if !(_teleId isEqualTo -1) then {BRPVP_construindoItemObj setVariable ["brpvp_tele_destine_id",_teleId,true];};

				//BASE SIGN
				_signTxt = BRPVP_consMovObj getVariable ["brpvp_sign_txt",""];
				if !(_signTxt isEqualTo "") then {BRPVP_construindoItemObj setVariable ["brpvp_sign_txt",_signTxt,true];};

				//FLAG
				if (_isFlag) then {
					[BRPVP_construindoItemObj,{BRPVP_allFlags pushBack _this;}] remoteExecCall ["call",0];
					BRPVP_construindoItemObj setVariable ["brpvp_lastPayment",BRPVP_consMovObj getVariable "brpvp_lastPayment",true];
					//BRPVP_construindoItemObj setVariable ["brpvp_flag_radius",BRPVP_construindoItemObj call BRPVP_getFlagRadius,true];

					//UPDATE MAP DRAW PLAYERS STUFF
					//private _flagPlayers = (BRPVP_construindoItemObj getVariable ["amg",[[],[],true]]) select 1;
					//private _mIds = [];
					//{
					//	private _idbd = _x getVariable ["id_bd",-1];
					//	if (_idbd isNotEqualTo -1 && _idbd in _flagPlayers) then {_mIds pushBack (_x getVariable ["brpvp_machine_id",-1]);};
					//} forEach call BRPVP_playersList;
					//_mIds = _mIds-[-1];
					//if (_mIds isNotEqualTo []) then {remoteExecCall ["BRPVP_findMyFlags",_mIds];};
				};

				//ANTI MISSILE DOME
				_domeRad = BRPVP_consMovObj getVariable ["brpvp_dome_radius",-1];
				if !(_domeRad isEqualTo -1) then {BRPVP_construindoItemObj setVariable ["brpvp_dome_radius",_domeRad,true];};

				//BOX (IF USING BRPVP MOD)
				if (_isBox) then {[BRPVP_construindoItemObj,BRPVP_consMovObj call BRPVP_getCargoArray] call BRPVP_putItemsOnCargo;};
			} else {
				_dstp = if (_isFlag) then {3} else {player getVariable "dstp"};
				BRPVP_construindoItemObj setVariable ["own",player getVariable "id_bd",true];
				BRPVP_construindoItemObj setVariable ["stp",_dstp,true];
				BRPVP_construindoItemObj setVariable ["amg",[player getVariable ["amg",[]],[],true],true];
				if (BRPVP_construindoItemObjClass isEqualTo "Land_Communication_F") then {
					BRPVP_construindoItemObj setVariable ["brpvp_dome_radius",200,true];
					_exec = "_this setVariable ['brpvp_dome_radius',200,true];";
				};

				//if (_isFlag) then {BRPVP_construindoItemObj setVariable ["brpvp_flag_radius",BRPVP_construindoItemObj call BRPVP_getFlagRadius,true];};

				//REMOVE ITEMS IF BOX
				if (BRPVP_construindoItemObjClass in BRP_kitFuelStorage || BRPVP_construindoItemObjClass isEqualTo BRPVP_superBoxClass) then {
					clearWeaponCargoGlobal BRPVP_construindoItemObj;
					clearMagazineCargoGlobal BRPVP_construindoItemObj;
					clearItemCargoGlobal BRPVP_construindoItemObj;
					clearBackpackCargoGlobal BRPVP_construindoItemObj;
				};
			};

			//ADD BUILDING TO DATABASE ON SERVER
			private _sustenter = BRPVP_construindoItemObj getVariable ["brpvp_sustenter_obj",objNull];
			private _posObj = [_sustenter,BRPVP_construindoItemObj] select isNull _sustenter;
			_estadoCons = [
				BRPVP_construindoItemObj call BRPVP_getCargoArray,
				[getPosWorld _posObj,[vectorDir _posObj,vectorUp _posObj]],
				BRPVP_construindoItemObjClass,
				BRPVP_construindoItemObj getVariable "own",
				BRPVP_construindoItemObj getVariable "stp",
				BRPVP_construindoItemObj getVariable ["amg",[[],[],true]],
				_exec,
				if (_isFlag) then {BRPVP_sessionTimeStamp} else {[0,0,0,0,0,0]},
				[],
				[0,[[],[]]]
			];
			_forceID = if (_deleteOld) then {BRPVP_consMovObj getVariable "id_bd"} else {-1};
			[BRPVP_construindoIsMapObject,BRPVP_construindoItemObj,_estadoCons,_isSO,_forceID] remoteExecCall ["BRPVP_adicionaConstrucaoBd",2];

			//ANIMATION FIX
			{
				_X params ["_class","_animations"];
				if (BRPVP_construindoItemObjClass isEqualTo _class) then {
					{BRPVP_construindoItemObj animateSource _x;} forEach _animations;
				};
			} forEach BRPVP_animateObjsAfterCreate;
		} else {
			//MOVE ORIGINAL OBJECT
			private _isSuperItem = typeOf BRPVP_consMovObj isEqualTo BRPVP_superBoxClass;
			BRPVP_construindoItemObj removeAllEventHandlers "HandleDamage";
			_posA = getPosASL BRPVP_construindoItemObj;
			_posW = getPosWorld BRPVP_construindoItemObj;
			_vdu = [vectorDir BRPVP_construindoItemObj,vectorUp BRPVP_construindoItemObj];
			if (netId BRPVP_consMovObj isEqualTo "0:0") then {
				private _typeOf = typeOf BRPVP_consMovObj;
				if (_typeOf in BRPVP_buildingHaveDoorListCVL) then {
					[_typeOf,BRPVP_consMovObj getVariable "id_bd",_vdu,_posW] remoteExecCall ["BRPVP_moveActionBoxBacksimpleObjectCVL",0];
				} else {
					[_typeOf,BRPVP_consMovObj getVariable "id_bd",_vdu,_posW] remoteExecCall ["BRPVP_moveActionBoxBacksimpleObject",0];
				};
			} else {
				if (_isSuperItem) then {
					private _sustenter = BRPVP_consMovObj getVariable "brpvp_sustenter_obj";
					private _fixH = vectorMagnitude (getPosWorld BRPVP_consMovObj vectorDiff getPosWorld _sustenter);
					[_posW,_vdu,attachedObjects BRPVP_consMovObj select 0] remoteExecCall ["BRPVP_bigBoxVisualHelp",BRPVP_allNoServer];
					[_sustenter,BRPVP_consMovObj,_posW vectorAdd [0,0,_fixH],_vdu] remoteExecCall ["BRPVP_moveActionBoxBackBigBox",_sustenter];
				} else {
					[BRPVP_consMovObj,_vdu,_posW] remoteExecCall ["BRPVP_moveActionBoxBack",2];
				};
				//RESET FMR MAP RECTANGLE
				BRPVP_consMovObj setVariable ["brpvp_fmr_user",[],true];
				//SAVE NEW POSITION TO DATABASE
				if !(BRPVP_consMovObj getVariable ["slv",false]) then {BRPVP_consMovObj setVariable ["slv",true,true];};
				if (BRPVP_construindoItemObjClass in BRP_kitAutoTurret) then {
					BRPVP_consMovObj setVariable ["brpvp_tupdated",true,2];
					BRPVP_consMovObj setVariable ["brpvp_tflag",objNull,true];
				};
			};
			[_posW,BRPVP_consMovObj,BRPVP_construindoItemObj] spawn {
				params ["_posW","_consMovObj","_delete"];
				waitUntil {ASLToAGL _posW distance _consMovObj < 10};
				deleteVehicle _delete;
			};

			BRPVP_construindo = false;
			player setVariable ["bdg",false,true];
			//call BRPVP_atualizaDebugMenu;
			BRPVP_construindoItemIdc = 0;
			player setVariable ["brpvp_moving_obj",[],true];
		};
		
		if (_deleteOld) then {[BRPVP_consMovObj,false] call BRPVP_removeObject;};

		//BACK TO CORRECT MENU
		if (BRPVP_consRepeat isEqualTo []) then {
			if (BRPVP_construindoItemRetira isEqualTo -1) then {
				50 call BRPVP_iniciaMenuExtra;
			} else {
				if (BRPVP_construindoItemRetira isEqualTo -2) then {
					BRPVP_menuExtraLigado = false;
					hintSilent "";
					if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {"" remoteExecCall ["BRPVP_specMenuShow",BRPVP_specOnMeMachinesNoMe];};
				} else {
					35 call BRPVP_iniciaMenuExtra;
				};
			};
			call BRPVP_atualizaDebugMenu;
		};

		//REMOVE BUILDING PRICE
		if (_removeBuildingPrice > 0) then {
			player setVariable ["mny",(player getVariable ["mny",0])-BRPVP_consBuildingCost,true];
			"negocio" call BRPVP_playSound;
			call BRPVP_atualizaDebug;
		};

		//REMOVE ITEM FROM INVENTORY
		[BRPVP_construindoItemRetira,1] call BRPVP_sitRemoveItem;

		if (isNull BRPVP_consMovObj) then {
			//RECORD LAST OBJECT CREATED
			BRPVP_consLastItemUsed = BRPVP_construindoItemObjClass;
			
			//ADD EXPERIENCE
			[["itens_construidos",1]] call BRPVP_mudaExp;
		};

		["",0,0,0,0,0,54369] call BRPVP_fnc_dynamicText;

		BRPVP_lastConsObj2 = BRPVP_lastConsObj1;
		BRPVP_lastConsObj1 = [typeOf BRPVP_construindoItemObj,getPosWorld BRPVP_construindoItemObj,getPosASL BRPVP_construindoItemObj,getDir BRPVP_construindoItemObj,BRPVP_construindoIsMapObject];

		//[
		//	(nearestObjects [BRPVP_construindoItemObj,[],1]) select {typeOf _x isEqualTo typeOf BRPVP_construindoItemObj},
		//	typeOf BRPVP_construindoItemObj,
		//	getPosWorld BRPVP_construindoItemObj,
		//	vectorDir BRPVP_construindoItemObj,
		//	vectorUp BRPVP_construindoItemObj,
		//	BRPVP_construindoIsMapObject
		//] spawn {
		//	params ["_ignore","_class","_pos","_vd","_vu","_map"];
		//	private _obj = objNull;
		//	private _search = [];
		//	private _equal = false;
		//	private _init = diag_tickTime;
		//	private _found = objNull;
		//	waitUntil {
		//		_search = ((nearestObjects [ASLToAGL _pos,[],0.005]) select {typeOf _x isEqualTo _class})-_ignore;
		//		{
		//			private _fObj = _x;
		//			private _pwOk = vectorMagnitude (getPosWorld _fObj vectorDiff _pos) < 0.005;
		//			private _vdOk = vectorMagnitude (vectorDir _fObj vectorDiff _vd) < 0.001;
		//			private _vuOk = vectorMagnitude (vectorUp _fObj vectorDiff _vu) < 0.001;
		//			if (_pwOk && _vdOk && _vuOk) exitWith {
		//				_found = _fObj;
		//				_equal = true
		//			};
		//		} forEach _search;
		//		_equal || diag_tickTime-_init > 5
		//	};
		//	if (!isNull _found) then {
		//		BRPVP_lastConsObj2 = BRPVP_lastConsObj1;
		//		BRPVP_lastConsObj1 = _found;
		//	};
		//};
	};
	call BRPVP_baseFlyCode;
};
BRPVP_checkFly = {
	params ["_newHUsed","_player","_velStart"];
	_backPos = getPosASL player;
	sleep 0.25;
	_notOk = false;
	_lisCheckC = false;
	_velStart set [2,0];
	_pos1 = getPosASLVisual player;
	_time = diag_tickTime;
	sleep 0.001;
	waitUntil {
		_delta = diag_tickTime-_time;
		_time = _time+_delta;
		_pos2 = getPosASLVisual player;
		_change = _pos2 vectorDiff _pos1;
		_vel = (vectorMagnitude _change)/_delta;
		_change set [2,0];
		_sideMove = aCos (_change vectorCos _velStart);
		_notOk = _sideMove > 5 || _vel < 0.125;
		_posCheck = getPos player select 2 < 0.15;
		_lis1 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.15],player,objNull,true,1,"VIEW","NONE",true];
		_lis2 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.15],player,objNull,true,1,"GEOM","NONE",true];
		_lisC1 = lineIntersectsSurfaces [eyePos player,eyepos player vectorAdd [0,0,0.25],player,objNull,true,1,"VIEW","NONE",true];
		_lisC2 = lineIntersectsSurfaces [eyePos player,eyepos player vectorAdd [0,0,0.25],player,objNull,true,1,"GEOM","NONE",true];
		_lisCheck = (count _lis1 > 0 && {(_lis1 select 0 select 2) call BRPVP_isMotorized || (_lis1 select 0 select 2) isKindOf "Building"}) || count _lis2 > 0;
		_lisCheckC = (count _lisC1 > 0 && {(_lisC1 select 0 select 2) call BRPVP_isMotorized || (_lisC1 select 0 select 2) isKindOf "Building"}) || count _lisC2 > 0;
		_end = _posCheck || _lisCheck || _lisCheckC;
		_pos1 = +_pos2;
		if (_posCheck) then {[player,["jump_hit_ground",125]] remoteExecCall ["say3D",BRPVP_allNoServer];};
		_notOk || _end;
	};
	if (_notOk) then {
		[player,(_velStart vectorMultiply -0.2)] remoteExecCall ["setVelocity",0];
		waitUntil {
			_posCheck = getPos player select 2 < 0.15;
			_lis1 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.15],player,objNull,true,1,"VIEW","NONE",true];
			_lis2 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.15],player,objNull,true,1,"GEOM","NONE",true];
			_lisCheck = (count _lis1 > 0 && {(_lis1 select 0 select 2) call BRPVP_isMotorized || (_lis1 select 0 select 2) isKindOf "Building"}) || count _lis2 > 0;
			if (_posCheck) then {[player,["jump_hit_ground",125]] remoteExecCall ["say3D",BRPVP_allNoServer];};
			_posCheck || _lisCheck
		};
	} else {
		if (_lisCheckC) then {
			_vel = velocity player;
			_z = _vel select 2;
			if (_z > 0) then {
				_vel set [2,-_z];
				[player,(_vel vectorMultiply 0.5)] remoteExecCall ["setVelocity",0];
			} else {
				[player,[(_vel select 0)*0.25,(_vel select 1)*0.25,_z]] remoteExecCall ["setVelocity",0];
			};
			waitUntil {
				_posCheck = getPos player select 2 < 0.15;
				_lis1 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.15],player,objNull,true,1,"VIEW","NONE",true];
				_lis2 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.15],player,objNull,true,1,"GEOM","NONE",true];
				_lisCheck = (count _lis1 > 0 && {(_lis1 select 0 select 2) call BRPVP_isMotorized || (_lis1 select 0 select 2) isKindOf "Building"}) || count _lis2 > 0;
				if (_posCheck) then {[player,["jump_hit_ground",125]] remoteExecCall ["say3D",BRPVP_allNoServer];};
				_posCheck || _lisCheck
			};
		};
	};
	sleep 0.25;
	if (_newHUsed) then {player setUnitFreefallHeight 100;};
	BRPVP_canJump = true;
};
BRPVP_nitroFlyStopEngineHandle = scriptNull;
BRPVP_constantRunFootVehicle = {
	private _vCheck = objectParent player;
	if (!isNull _vCheck && (_vCheck isKindOf "Landvehicle" || _vCheck isKindOf "Motorcycle") && BRPVP_nitroFlyFeatureOn) then {
		//VEHICLE FLY NITRO
		if (!BRPVP_nitroFlyOn && !BRPVP_menuExtraLigado && !BRPVP_safeZone) then {
			if (time-BRPVP_nitroFlyCoolDownLastEnd > BRPVP_nitroFlyCoolDown) then {
				private _veh = objectParent player;
				private _mag = vectorMagnitude velocity _veh;
				if (alive _veh && currentPilot _veh isEqualTo player && _mag > 1) then {
					BRPVP_nitroFlyOn = true;
					_veh call BRPVP_setTurretTypes;
					_veh setVariable ["brpvp_fly_nitro",true,true];
					[player,_veh] remoteExec ["BRPVP_vehicleFlyNitroLocalEffect",BRPVP_allNoServer];

					//ATTACH FAKE HELI
					private _aHeli = createVehicle ["O_T_VTOL_02_infantry_F",BRPVP_posicaoFora vectorAdd [0,0,100],[],100,"FLY"];
					private _aAgnt = createAgent ["O_G_Soldier_F",BRPVP_posicaoFora,[],100,"CAN_COLLIDE"];
					[_aHeli,true] remoteExecCall ["hideObjectGlobal",2];
					[_aAgnt,true] remoteExecCall ["hideObjectGlobal",2];
					_aAgnt disableAI "FSM";
					_aAgnt addRating -10000;
					_aAgnt moveInDriver _aHeli;
					_aHeli setObjectScale 0.25;
					_aHeli setVehicleAmmo 0;
					player setVariable ["brpvp_my_car_fly_key",[_aAgnt,_aHeli],2];
					[_aAgnt,_aHeli,_veh] spawn {
						params ["_aAgnt","_aHeli","_veh"];
						waitUntil {(isObjectHidden _aHeli && isObjectHidden _aAgnt) || (isNull _aHeli && isNull  _aAgnt)};
						uiSleep 0.001;
						if (!isNull _aHeli && !isNull _aAgnt) then {_aHeli attachTo [_veh,[0,0,0]];};
					};
					[_veh,_aHeli,_aAgnt] spawn {
						params ["_veh","_aHeli","_aAgnt"];
						private _flyStart = time;
						private _aErrorLim = 180;
						private _massFactor = (getMass _veh)^1.15;
						private _hPower = 1.3;
						private _initForce = 0;
						private _steer = 0.005;

						//SOUND
						private _sounder = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],100,"CAN_COLLIDE"];
						private _initA = diag_tickTime;
						private _vehVolume = 3000;
						_sounder attachTo [_veh,[0,0,4]];
						[_sounder,["uber_pack_init",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
						[_sounder,["uber_pack",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];

						private _vec = velocity _veh;
						private _mag = vectorMagnitude _vec;
						private _accelTime = 8;
						private _vms = (1.25*(_veh getSpeed "FAST")) min 45;
						private _vmsLand = (_veh getSpeed "FAST") min 45;
						private _velMaxAdd = (((_mag*4) max 15 min _vms)/_mag-1) max 0;
						private _vecDirOriginal = [sin getDir _veh,cos getDir _veh,0];
						private _init = diag_tickTime;
						waitUntil {
							false call BRPVP_nitroFlyStabilityJets;
							if (diag_tickTime-_initA >= 7.238) then {
								_initA = diag_tickTime;
								[_sounder,["uber_pack",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
							};

							//CAR STEERING WHEEL
							private _icr = inputAction "CarRight" isNotEqualTo 0;
							private _icl = inputAction "CarLeft" isNotEqualTo 0;
							if (_icr && !_icl) then {
								private _side = vectorNormalized (_vec vectorCrossProduct [0,0,1]);
								_vec = (vectorNormalized (_vec vectorAdd (_side vectorMultiply (_steer*_mag)))) vectorMultiply _mag;
							} else {
								if (!_icr && _icl) then {
									private _side = vectorNormalized ([0,0,1] vectorCrossProduct _vec);
									_vec = (vectorNormalized (_vec vectorAdd (_side vectorMultiply (_steer*_mag)))) vectorMultiply _mag;
								};
							};

							private _angle = acos (vectorUp _veh vectorCos [0,0,1]);
							private _vecDirChange = acos ([sin getDir _veh,cos getDir _veh,0] vectorCos _vecDirOriginal);
							private _perc = (diag_tickTime-_init)/_accelTime;
							private _vecMult = _vec vectorAdd (_vec vectorMultiply (_perc*_velMaxAdd));
							private _zAddMult = (0.5*(_mag min 25)*_perc)^(_hPower);
							_veh setVelocity (_vecMult vectorAdd [0,0,_zAddMult]);
							_perc > 1 || isNull _veh || !alive _veh || !(player call BRPVP_pAlive) || currentPilot _veh isNotEqualTo player || !BRPVP_nitroFlyWPressed
						};

						if (BRPVP_nitroFlyWPressed) then {
							private _velApply = velocity _veh;
							private _velApplyMag = vectorMagnitude _velApply;
							private _vz = _velApply select 2;
							private _initGvt = diag_tickTime;
							private _cruiseTime = if (_vz > 0) then {BRPVP_nitroFlyCruiseTime} else {0};
							private _cruiseDelay = if (_vz > 0) then {_vz/9.8} else {0};
							waitUntil {
								false call BRPVP_nitroFlyStabilityJets;
								if (diag_tickTime-_initA >= 7.238) then {
									_initA = diag_tickTime;
									[_sounder,["uber_pack",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
								};

								//GRAVITY
								private _newVZ = 0;
								if (diag_tickTime-_initGvt <= _cruiseDelay) then {_newVZ = _vz-(9.8*(diag_tickTime-_initGvt));} else {if (diag_tickTime-_initGvt >= _cruiseDelay+_cruiseTime) then {_newVZ = _vz-(9.8*(diag_tickTime-_initGvt-_cruiseTime));};};
								_velApply set [2,_newVZ];
								_velApply = (vectorNormalized _velApply) vectorMultiply _velApplyMag;

								//CAR STEERING WHEEL
								private _icr = inputAction "CarRight" isNotEqualTo 0;
								private _icl = inputAction "CarLeft" isNotEqualTo 0;
								if (_icr && !_icl) then {
									private _side = (vectorNormalized (_velApply vectorCrossProduct [0,0,1])) vectorMultiply (_steer*_velApplyMag);
									_velApply = (vectorNormalized (_velApply vectorAdd _side)) vectorMultiply _velApplyMag;
								} else {
									if (!_icr && _icl) then {
										private _side = (vectorNormalized ([0,0,1] vectorCrossProduct _velApply)) vectorMultiply (_steer*_velApplyMag);
										_velApply = (vectorNormalized (_velApply vectorAdd _side)) vectorMultiply _velApplyMag;
									};
								};
								_veh setVelocity _velApply;

								(ASLToAGL getPosASL _veh select 2 < 75 && (velocity _veh select 2 < 0 || ASLToAGL getPosASL _veh select 2 < 1)) || !BRPVP_nitroFlyWPressed
							};

							if (BRPVP_nitroFlyWPressed) then {
								private _velNowXY = (velocity _veh select [0,2])+[0];
								private _velNowXYMag = vectorMagnitude _velNowXY;
								private _velNowZ = velocity _veh select 2;
								private _isOk = !isNull _veh && alive _veh && player call BRPVP_pAlive && currentPilot _veh isEqualTo player;
								if (_isOk) then {
									//DESCENT SOUND START
									private _sounder = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],100,"CAN_COLLIDE"];
									private _initA = diag_tickTime;
									private _vehVolume = 2500;
									_sounder attachTo [_veh,[0,0,0]];
									[_sounder,["uber_pack",_vehVolume,1.25]] remoteExecCall ["say3D",BRPVP_allNoServer];
									private _hRelease = 3.5;
									private _hStart = ((ASLToAGL getPosASL _veh select 2)-_hRelease) max 0;
									private _magChange = _velNowXYMag-_vmsLand;
									private _maxPerc = 0;
									private _init = diag_tickTime;
									waitUntil {
										false call BRPVP_nitroFlyStabilityJets;
										if (diag_tickTime-_initA >= 7.238) then {
											_initA = diag_tickTime;
											[_sounder,["uber_pack",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
										};

										//CAR STEERING WHEEL
										private _icr = inputAction "CarRight" isNotEqualTo 0;
										private _icl = inputAction "CarLeft" isNotEqualTo 0;
										if (_icr && !_icl) then {
											private _side = vectorNormalized (_velNowXY vectorCrossProduct [0,0,1]);
											_velNowXY = (vectorNormalized (_velNowXY vectorAdd (_side vectorMultiply (_steer*_velNowXYMag)))) vectorMultiply _velNowXYMag;
										} else {
											if (!_icr && _icl) then {
												private _side = vectorNormalized ([0,0,1] vectorCrossProduct _velNowXY);
												_velNowXY = (vectorNormalized (_velNowXY vectorAdd (_side vectorMultiply (_steer*_velNowXYMag)))) vectorMultiply _velNowXYMag;
											};
										};

										private _hNow = ((ASLToAGL getPosASL _veh select 2)-_hRelease) max 0;
										private _delay = diag_tickTime-_init;
										private _percTry = if (_hStart isEqualTo 0) then {1} else {(_hStart-(_hNow min _hStart))/_hStart};
										private _perc = if (_percTry > _maxPerc) then {_percTry} else {_maxPerc};
										private _magMult = (_velNowXYMag-_perc*_magChange)/_velNowXYMag;
										private _zv = (1-_perc)*(_velNowZ-9.8*_delay)+_perc*-7.5;
										private _velSet = [(_velNowXY select 0)*_magMult,(_velNowXY select 1)*_magMult,_zv];
										_veh setVelocity _velSet;
										_perc isEqualTo 1 || isNull _veh || !alive _veh || !(player call BRPVP_pAlive) || currentPilot _veh isNotEqualTo player || !BRPVP_nitroFlyWPressed
									};
								};
							};
						};
						//OFF
						_veh setVariable ["brpvp_fly_nitro",false,true];
						[_veh,["uber_pack_init",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
						[_sounder,_veh] spawn {
							params ["_sounder","_veh"];
							uiSleep 0.75;
							detach _sounder;
							deleteVehicle _sounder;
						};

						if (!BRPVP_nitroFlyWPressed) then {
							private ["_maxVel","_velNowXY","_velNowXYMag","_velNowZ","_hRelease","_hStart","_magChange","_maxPerc","_init"];
							private _jetOn = BRPVP_nitroFlyWPressed || inputAction "CarBack" isNotEqualTo 0;
							private _timeLow = 0;
							private _lastJet = if (BRPVP_nitroFlyWPressed) then {"f"} else {if (inputAction "CarBack" isNotEqualTo 0) then {"b"} else {"n"}}; 
							private _sndClass = "uber_pack";
							private _sndTime = 7.238;
							private _sndStop = 0.75;
							if (!BRPVP_nitroFlyWPressed) then {_sndClass = "uber_pack_reverse";_sndTime = 7.238/2;};
							waitUntil {
								private _jetNow = if (BRPVP_nitroFlyWPressed) then {"f"} else {if (inputAction "CarBack" isNotEqualTo 0) then {"b"} else {"n"}}; 
								if (_jetNow isNotEqualTo _lastJet) then {
									_sndClass = "uber_pack";
									_sndTime = 7.238;
									_sndStop = 0.75;
									if (!BRPVP_nitroFlyWPressed) then {_sndClass = "uber_pack_reverse";_sndTime = 7.238/2;_sndStop = 0.75/2;};
									_initA = 0;
									_lastJet = _jetNow;
								};
								if (_jetOn && !BRPVP_nitroFlyWPressed && inputAction "CarBack" isEqualTo 0) then {
									_jetOn = false;
									_veh setVariable ["brpvp_fly_nitro",false,true];
									[_veh,["uber_pack_init",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									[_sounder,_veh,_sndStop] spawn {
										params ["_sounder","_veh","_sndStop"];
										uiSleep _sndStop;
										detach _sounder;
										deleteVehicle _sounder;
									};
								};
								if (!_jetOn && (BRPVP_nitroFlyWPressed || inputAction "CarBack" isNotEqualTo 0)) then {
									_jetOn = true;
									_sounder = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],100,"CAN_COLLIDE"];
									_initA = diag_tickTime;
									_sounder attachTo [_veh,[0,0,4]];
									[_sounder,["uber_pack_init",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									[_sounder,[_sndClass,_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									_veh setVariable ["brpvp_fly_nitro",true,true];
									[player,_veh] remoteExec ["BRPVP_vehicleFlyNitroLocalEffect",BRPVP_allNoServer];

									_velNowXY = (velocity _veh select [0,2])+[0];
									_velNowXYMag = vectorMagnitude _velNowXY;
									_velNowZ = velocity _veh select 2;
									_hRelease = 3.5;
									_hStart = ((ASLToAGL getPosASL _veh select 2)-_hRelease) max 0;
									_maxVel = if (BRPVP_nitroFlyWPressed) then {40} else {15};
									_magChange = _velNowXYMag-(_vmsLand min _maxVel);
									_maxPerc = 0;
									_init = diag_tickTime;
								};
								if (_jetOn) then {
									true call BRPVP_nitroFlyStabilityJets;
									if (diag_tickTime-_initA >= _sndTime) then {
										_initA = diag_tickTime;
										[_sounder,[_sndClass,_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};

									//CAR STEERING WHEEL
									private _icr = inputAction "CarRight" isNotEqualTo 0;
									private _icl = inputAction "CarLeft" isNotEqualTo 0;
									if (_icr && !_icl) then {
										private _side = vectorNormalized (_velNowXY vectorCrossProduct [0,0,1]);
										_velNowXY = (vectorNormalized (_velNowXY vectorAdd (_side vectorMultiply (_steer*_velNowXYMag)))) vectorMultiply _velNowXYMag;
									} else {
										if (!_icr && _icl) then {
											private _side = vectorNormalized ([0,0,1] vectorCrossProduct _velNowXY);
											_velNowXY = (vectorNormalized (_velNowXY vectorAdd (_side vectorMultiply (_steer*_velNowXYMag)))) vectorMultiply _velNowXYMag;
										};
									};

									//LANDING
									private _hNow = ((ASLToAGL getPosASL _veh select 2)-_hRelease) max 0;
									private _delay = diag_tickTime-_init;
									private _percTry = if (_hStart isEqualTo 0) then {1} else {(_hStart-(_hNow min _hStart))/_hStart};
									private _perc = if (_percTry > _maxPerc) then {_percTry} else {_maxPerc};
									private _vMult = (_velNowXYMag-(sqrt _perc)*_magChange)/_velNowXYMag;
									private _vMultMaxIncrease = 1.5^(1/diag_fps);
									private _magMult = _vMult min _vMultMaxIncrease;
									private _zv = (1-_perc)*(_velNowZ-9.8*_delay)+_perc*-7.5;
									private _velSet = [(_velNowXY select 0)*_magMult,(_velNowXY select 1)*_magMult,_zv];
									_veh setVelocity _velSet;
								};
								_timeLow = if (getPos _veh select 2 < 1.5) then {_timeLow+1/diag_fps} else {0};
								isTouchingGround _veh || getPos _veh select 2 < 0.25 || _timeLow > 7.5
							};
							_veh setVariable ["brpvp_fly_nitro",false,true];
							[_veh,["uber_pack_init",_vehVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
							[_sounder,_veh] spawn {
								params ["_sounder","_veh"];
								uiSleep 0.75;
								detach _sounder;
								deleteVehicle _sounder;
							};
						};
						BRPVP_nitroFlyOn = false;
						_veh call BRPVP_setTurretTypes;

						deleteVehicle _aAgnt;
						if (isNull BRPVP_nitroFlyStopEngineHandle) then {
							_aHeli engineOn false;
							BRPVP_nitroFlyStopEngineHandle = [_veh,_aHeli] spawn {
								params ["_veh","_aHeli"];
								private _init = time;
								waitUntil {time-_init > 8 || !alive _veh};
								deleteVehicle _aHeli;
							};
						} else {
							deleteVehicle _aHeli;
						};
						player setVariable ["brpvp_my_car_fly_key",[],2];

						if (time-_flyStart > 5) then {BRPVP_nitroFlyCoolDownLastEnd = time;};
						0 spawn {
							waitUntil {time-BRPVP_nitroFlyCoolDownLastEnd > BRPVP_nitroFlyCoolDown};
							"hint2" call BRPVP_playSound;
							if (!isNull objectParent player && !BRPVP_safeZone) then {
								["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\fly_car_icon.paa'/>",0,0.25,1,0,0,9256] call BRPVP_fnc_dynamicText;
							};

						};
						private _iFinal = diag_tickTime;
						waitUntil {
							if (!isTouchingGround _veh) then {false call BRPVP_nitroFlyStabilityJets;};
							BRPVP_nitroFlyOn || diag_tickTime-_iFinal > 3
						};
					};
				};
			} else {
				//BRPVP_nitroFlyOn = false;
				//"erro" call BRPVP_playSound;
				//["<img shadow='0' size='3.5' image='"+BRPVP_imagePrefix+"BRP_imagens\fly_car_icon_off.paa'/>",0,0.25,1,0,0,9256] call BRPVP_fnc_dynamicText;
			};
		};
	} else {
		//SUPER RUN CASE ON FOOT
		private _lifeOk = lifeState player isEqualTo "HEALTHY";
		private _maxSrs = [2,100] select _lifeOk;
		private _superRunSpeed = BRPVP_superRunSpeedSelected min _maxSrs;
		private _isWater = surfaceIsWater getPosWorld player;
		private _waterOk = !_isWater || {(ASLToAGL getPosASL player) select 2 > -2.5 && _superRunSpeed >= 4};
		if (!BRPVP_constantRunOn && stance player isNotEqualTo "PRONE" && getPos player select 2 < 0.15 && _waterOk && isNull objectParent player && !BRPVP_menuExtraLigado) then {
			BRPVP_constantRunOn = true;
			BRPVP_constantRunSadEnd = false;
			0 spawn {
				private _chockObj = objNull;
				private _setAnimSpeed = {
					player setAnimSpeedCoef _this;
					[player,_this min 3] remoteExecCall ["setAnimSpeedCoef",-clientOwner];
				};
				private _checkPlayerFront = {
					private _fPos = getPosASLVisual player;
					private _dir = getDir player;
					private _vecUp = [0.25*sin _dir,0.25*cos _dir,0];
					private _vecDown = [0.25*sin _dir,0.25*cos _dir,0];
					private _vecFront = [0.75*sin _dir,0.75*cos _dir,0];
					private _lisFront1 = lineIntersectsSurfaces [_fPos vectorAdd [0,0,1.75],_fPos vectorAdd [0,0,-1.75],player,objNull,true,1,"GEOM","FIRE"];
					private _lisFront2 = lineIntersectsSurfaces [_fPos vectorAdd _vecFront vectorAdd [0,0,1.75],_fPos vectorAdd _vecFront vectorAdd [0,0,-1.75],player,objNull,true,1,"GEOM","FIRE"];
					if (_lisFront1 isNotEqualTo [] && _lisFront2 isNotEqualTo []) then {
						private _dh = (_lisFront2 select 0 select 0 select 2)-(_lisFront1 select 0 select 0 select 2);
						_vecDown set [2,_dh*(0.25/0.75)] 
					};
					private _one = false;
					private _vecMult = [1,2,2,3,3,3];
					private _vecToUse = [_vecDown,_vecDown,_vecDown,_vecUp,_vecUp,_vecUp];
					for "_i" from 0 to 5 do {
						private _vecNow = _vecToUse select _i;
						private _h = 0.25+_i*(1.55/5);
						private _fl1 = _fPos vectorAdd [0,0,_h];
						private _fl2 = _fl1 vectorAdd (_vecNow vectorMultiply (_vecMult select _i));
						private _lis = [_fl1,_fl2,player,objNull,"GEOM","FIRE"] call BRPVP_lis;
						if (_lis isNotEqualTo [] && {!isNull (_lis select 0 select 2)}) exitWith {
							_chockObj = _lis select 0 select 2;
							_one = true;
						};
					};
					private _str = str _chockObj;
					if (_one) then {
						if ({_str find _x > -1} count BRPVP_srunCollisionOk isNotEqualTo 0) then {
							if ({_str find _x > -1} count BRPVP_srunCollisionOff isEqualTo 0 && _speed > 3) then {_chockObj setDamage 1;};
							if ({_str find _x > -1} count BRPVP_srunCollisionSound isNotEqualTo 0) then {[player,["upper_cut",200,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];};
							_speed = 2;
							_speed call _setAnimSpeed;
							"noHit"
						} else {
							private _vec = [1.5*sin _dir,1.5*cos _dir,0];
							private _r = [];
							for "_i" from 0 to 5 do {
								private _h = 0.2+_i*(1.8/5);
								private _fl1 = _fPos vectorAdd [0,0,_h];
								private _fl2 = _fl1 vectorAdd _vec;
								private _lis = [_fl1,_fl2,player,objNull,"GEOM","FIRE"] call BRPVP_lis;
								_r pushBack (if (_lis isEqualTo []) then {false} else {if (isNull (_lis select 0 select 2)) then {false} else {true}});
							};
							private _lh = _r select 0 || _r select 1;
							private _mh = _r select 2 || _r select 3;
							private _hh = _r select 4 || _r select 5;
							if (!_lh && !_mh && !_hh) then {"noHit"} else {if (_lh && !_mh && !_hh || !_lh && !_mh && _hh) then {"halfHit"} else {"fullHit"};};
						};
					} else {
						"noHit"
					};
				};
				private _runChockFall = {
					params ["_p","_hType"];
					[player,["upper_cut",200,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];
					if (_hType isEqualTo "fullHit") then {
						[_p,"afalpercmstpsnonwnondnon"] remoteExecCall ["switchMove",0];
						private _d = getDir player-180;
						private _v = 0.25*vectorMagnitude velocity player;
						[_p,[_v*sin _d,_v*cos _d,1.75]] remoteExecCall ["setVelocity",0];
						_this spawn {
							params ["_p","_hType"];
							uiSleep 0.2;
							_p setUnconscious true;
							private _init = time;
							waitUntil {animationState _p isEqualTo "unconsciousrevivedefault" || !(_p call BRPVP_pAlive) || isNull _p || time-_init > 7.5};
							if (_p call BRPVP_pAlive && !isNull _p) then {
								_p setUnconscious false;
								uiSleep 0.001;
								[_p,"amovppnemstpsnonwnondnon"] remoteExecCall ["playMoveNow",0];
							};
						};
					} else {
						_p setUnconscious true;
						_this spawn {
							params ["_p","_hType"];
							private _init = time;
							waitUntil {(time-_init > 3 && getPos player select 2 < 0.25 && vectorMagnitude velocity player < 0.1) || !(_p call BRPVP_pAlive) || isNull _p};
							if (_p call BRPVP_pAlive && !isNull _p) then {
								_p setUnconscious false;
								uiSleep 0.001;
								[_p,"amovppnemstpsnonwnondnon"] remoteExecCall ["switchMove",0];
							};
						};
					};
					if (_chockObj isKindOf "CaManBase" && simulationEnabled _chockObj) then {
						private _d = getDir _p;
						[_chockObj,[5*sin _d,5*cos _d,3]] remoteExecCall ["playMoveNow",0];
					};
					if (_chockObj call BRPVP_isMotorized) then {[_chockObj,player] remoteExec ["BRPVP_applyForceLocal",2];};
				};
				private _okCode = {
					private _spd = _this;
					private _ok1 = isNull objectParent player && player call BRPVP_pAlive && getPos player select 2 < 7.5;
					private _ok2 = true;
					private _ok3 = !(surfaceIsWater getPosWorld player && getPosASL player select 2 < 0.125 && _spd < 4);
					if (_spd > 2 && isNull objectParent player) then {
						if (_spd <= 3) then {
							if (call _checkPlayerFront isNotEqualTo "noHit") then {_ok2 = false;};
						} else {
							private _hType = call _checkPlayerFront;
							if (_hType isNotEqualTo "noHit") then {
								_ok2 = false;
								BRPVP_constantRunSadEnd = true;
								[player,["zombie_snd_2",300]] remoteExecCall ["say3D",BRPVP_allNoServer];
								[player,_hType] call _runChockFall;
							};
						};
					};
					_ok1 && _ok2 && _ok3
				};
				//INIT RUN
				private _pOk = true;
				private _lifeOk = lifeState player isEqualTo "HEALTHY";
				private _maxSrs = [2,100] select _lifeOk;
				private _superRunSpeed = BRPVP_superRunSpeedSelected min _maxSrs;
				private _extra = BRPVP_superRunInertiaStart*(_superRunSpeed-1);
				private _speed = 1;

				//HURT MESSAGE
				if (!_lifeOk) then {[localize "str_srun_bad_legs",-6] call BRPVP_hint;};

				//WATER WALK
				if (_superRunSpeed >= 4) then {0 spawn BRPVP_waterWalk;};

				[player,"amovpercmevasnonwnondf"] remoteExecCall ["playMoveNow",0];
				uiSleep 0.1;
				player action ["SwitchWeapon",player,player,100];
				if (_extra > 0) then {
					private _init = diag_tickTime;
					private _initStep = diag_tickTime;
					waitUntil {
						private _dlt = diag_tickTime-_init;
						_speed = (1+_dlt/BRPVP_superRunInertiaStart) min _superRunSpeed;
						if (animationState player isNotEqualTo "amovpercmevasnonwnondf") then {for "_i" from 1 to ceil ((BRPVP_superRunInertiaStart*(_superRunSpeed-1)-_dlt)/(0.533/(1+(_superRunSpeed-_speed)/2))) do {player playMove "amovpercmevasnonwnondf";};};
						private _isd = diag_tickTime-_initStep;
						if (_isd >= 0.2) then {
							_initStep = diag_tickTime;
							_speed call _setAnimSpeed;
						};
						_pOk = _speed call _okCode;
						!BRPVP_constantRunOn || _speed isEqualTo _superRunSpeed || !_pOk
					};
					_speed call _setAnimSpeed;
				};
				if (!_pOk) exitWith {
					if (BRPVP_constantRunSadEnd) then {
						[player,1] remoteExecCall ["setAnimSpeedCoef",0];
						waitUntil {getPos player select 2 > 7.5 || speed player < 0.1};
					} else {
						player playMoveNow "amovpercmevasnonwnondf";
						[player,1] remoteExecCall ["setAnimSpeedCoef",0];
					};
					BRPVP_constantRunOn = false;
				};
				//MANTAIN RUN
				private _initStep = diag_tickTime;
				waitUntil {
					if (animationState player isNotEqualTo "amovpercmevasnonwnondf") then {for "_i" from 1 to (30/(0.533/_speed)) do {player playMove "amovpercmevasnonwnondf";};};
					private _isd = diag_tickTime-_initStep;
					if (_isd >= 0.2) then {
						if (_speed isNotEqualTo _superRunSpeed) then {_speed = (_speed+0.125) min _superRunSpeed};
						player setAnimSpeedCoef _speed;
						_initStep = diag_tickTime;
					};
					_pOk = _speed call _okCode;
					!BRPVP_constantRunOn || !_pOk
				};
				if (!_pOk) exitWith {
					if (BRPVP_constantRunSadEnd) then {
						[player,1] remoteExecCall ["setAnimSpeedCoef",0];
						waitUntil {getPos player select 2 > 7.5 || speed player < 0.1};
					} else {
						player playMoveNow "amovpercmevasnonwnondf";
						[player,1] remoteExecCall ["setAnimSpeedCoef",0];
					};
					BRPVP_constantRunOn = false;
				};
				//STOP RUN
				private _extra = BRPVP_superRunInertiaStop*(_speed-1);
				if (_extra > 0) then {
					private _init = diag_tickTime;
					private _initStep = diag_tickTime;
					private _speedEnd = _speed;
					waitUntil {
						private _dlt = diag_tickTime-_init;
						_speedEnd = (_speed-_dlt/BRPVP_superRunInertiaStop) max 1;
						if (animationState player isNotEqualTo "amovpercmevasnonwnondf") then {for "_i" from 1 to ceil ((BRPVP_superRunInertiaStop*(_speed-1)-_dlt)/(0.533/(1+(_speedEnd-1)/2))) do {player playMove "amovpercmevasnonwnondf";};};
						private _isd = diag_tickTime-_initStep;
						if (_isd >= 0.2) then {
							_initStep = diag_tickTime;
							_speedEnd call _setAnimSpeed;
						};
						_pOk = _speedEnd call _okCode;
						private _floorBellow = lineIntersectsSurfaces [getPosASL player vectorAdd [0,0,0.25],getPosASL player vectorAdd [0,0,-125],player,objNull,true,1,"GEOM","NONE"];
						_floorBellow = if (_floorBellow isEqualTo []) then {true} else {!isNull (_floorBellow select 0 select 2)};
						BRPVP_constantRunOn || _speedEnd isEqualTo 1 || (surfaceIsWater getPosWorld player && !_floorBellow) || !_pOk
					};
				};
				player playMoveNow "amovpercmevasnonwnondf";
				[player,1] remoteExecCall ["setAnimSpeedCoef",0];
			};
		};
	};
};
BRPVP_nitroFlyStabilityJets = {
	private _vectorUp = vectorUp _veh;
	private _vectorDir = vectorDir _veh;
	if (diag_tickTime-_initForce > 0.1) then {
		_initForce = diag_tickTime;
		private _vecVel = if (_this) then {(vectorNormalized ((velocity _veh select [0,2])+[0])) vectorAdd [0,0,-0.15]} else {velocity _veh};
		private _landVU = (_vecVel vectorCrossProduct [0,0,1]) vectorCrossProduct _vecVel;

		//FORCE VECTOR YAW (DIR)
		private _vdProjB = _vectorDir vectorCrossProduct _landVU;
		private _vdProj = vectorNormalized (_landVU vectorCrossProduct _vdProjB);
		private _vdSideRef = _landVU vectorCrossProduct _vecVel;
		private _vdSideNow = _vectorUp vectorCrossProduct _vectorDir;
		private _vdProjAngle = acos (_vdProj vectorCos _vdSideRef);
		private _vdAngleError = [90,_vdProjAngle] call BRPVP_angleBetween;;
		private _vdAngleMult = _vdAngleError/5;
		private _fixVD = if (_vdProjAngle >= 90) then {_vdSideNow} else {_vdSideNow vectorMultiply -1};
		private _forceVD = (vectorNormalized _fixVD) vectorMultiply ((_vdAngleMult*_massFactor)/600);
		_veh addForce [_forceVD,(getCenterOfMass _veh) vectorAdd [0,5,0]];
		_veh addForce [_forceVD vectorMultiply -1,(getCenterOfMass _veh) vectorAdd [0,-5,0]];

		//FORCE VECTOR PITCH (IMBICA)
		private _viProjA = _landVU vectorCrossProduct _vecVel;
		private _viProjB = _vectorUp vectorCrossProduct _viProjA;
		private _viProj = vectorNormalized (_viProjA vectorCrossProduct _viProjB);
		private _viProjAngle = acos (_viProj vectorCos _vecVel);
		private _viAngleError = [90,_viProjAngle] call BRPVP_angleBetween;
		private _viAngleMult = _viAngleError/5;
		private _fixVI = if (_viProjAngle >= 90) then {_vectorDir} else {_vectorDir vectorMultiply -1};
		private _forceVI = (vectorNormalized _fixVI) vectorMultiply ((_viAngleMult*_massFactor)/600);
		_veh addForce [_forceVI,(getCenterOfMass _veh) vectorAdd [0,0,5]];
		_veh addForce [_forceVI vectorMultiply -1,(getCenterOfMass _veh) vectorAdd [0,0,-5]];

		//FORCE VECTOR ROLL
		private _roProjB = _vectorUp vectorCrossProduct _vecVel;
		private _roProj = vectorNormalized (_vecVel vectorCrossProduct _roProjB);
		private _roSideRef = _landVU vectorCrossProduct _vecVel;
		private _roSideNow = _vectorUp vectorCrossProduct _vectorDir;
		private _roProjAngle = acos (_roProj vectorCos _roSideRef);
		private _roAngleError = [90,_roProjAngle] call BRPVP_angleBetween;
		private _roAngleMult = _roAngleError/5;
		private _fixRO = if (_roProjAngle >= 90) then {_roSideNow vectorMultiply -1} else {_roSideNow};
		private _forceRO = (vectorNormalized _fixRO) vectorMultiply ((_roAngleMult*_massFactor)/600);
		_veh addForce [_forceRO,(getCenterOfMass _veh) vectorAdd [0,0,-5]];
		_veh addForce [_forceRO vectorMultiply -1,(getCenterOfMass _veh) vectorAdd [0,0,5]];
	};
};
BRPVP_allJumpTypes = {
	_retorno = true;
	if (!BRPVP_isJesusRun && !BRPVP_pathClimbOn && stance player isnotEqualTo "PRONE") then {
		if (BRPVP_perkJump > 0 || BRPVP_climbOn) then {
			private _normalJump = true;
			private _climbOn = BRPVP_perkJump > 2 || BRPVP_climbOn;

			//TRY TO JUMP OVER WALL IF WALL IN FRONT
			if (BRPVP_perkJump > 1 || BRPVP_climbOn) then {
				if (getPos player select 2 < 0.1 || (_climbOn && time-BRPVP_climbMidJumpTime > 1)) then {
					private _brechSize = 1.5;
					private _pDir = getDir player;
					private _pPosASL = getPosASL player;
					private _hPos = -1;
					private _hSize = 0;
					private _overObj = objNull;
					private _found = false;
					private _front = lineIntersectsSurfaces [eyePos player,[eyePos player,5,getDir player] call BIS_fnc_relPos,player,objNull,true,1,"GEOM","NONE"];
					if (_front isNotEqualTo []) then {
						private _normal = (((_front select 0 select 1) select [0,2])+[0]) vectorMultiply -1;
						private _pVecDir = [sin _pDir,cos _pDir,0];
						private _alignAngle = aCos (_normal vectorCos _pVecDir);
						if (_alignAngle < 15) then {
							private _overWallHeight = if (_climbOn) then {if (_front isNotEqualTo [] && {typeOf (_front select 0 select 2) isEqualTo "Land_spp_Tower_F" && {player distance ASLToAGL getPosASL (_front select 0 select 2) < 10}}) then {70} else {15};} else {5};											
							for "_i" from 0 to _overWallHeight step 0.2 do {
								private _p1 = _pPosASL vectorAdd [0,0,_i];
								private _p2 = [(_p1 select 0)+2.5*sin _pDir,(_p1 select 1)+2.5*cos _pDir,_p1 select 2];
								private _lis = lineIntersectsSurfaces [_p1,_p2,player,objNull,true,1,"GEOM","VIEW"];
								if (_lis isEqualTo [] || {isNull (_lis select 0 select 2)}) then {
									_hPos = _i;
									_hsize = _hSize+0.2;
								} else {
									_overObj = _lis select 0 select 2;
									if (_hsize >= _brechSize) exitWith {_found = true;};
									_hPos = -1;
									_hsize = 0;
								};
								if (_found) exitWith {};
							};
							if (!_found && _hsize >= _brechSize) then {_found = true;};
							_hPos = _hPos-_hSize+0.25;
							if (typeOf (_front select 0 select 2) isEqualTo "Land_spp_Tower_F") then {_hPos = _hPos+1;};

							private _top1 = _pPosASL vectorAdd [0,0,_hPos+_brechSize];
							private _top2 = _top1 vectorAdd (_normal vectorMultiply 0.7);
							private _lisTop1 = lineIntersectsSurfaces [_pPosASL,_top1,player,objNull,true,1,"GEOM","NONE"];
							private _lisTop2 = lineIntersectsSurfaces [_pPosASL,_top2,player,objNull,true,1,"GEOM","NONE"];
							private _topOk = _lisTop1 isEqualTo [] && _lisTop2 isEqualTo [];

							if (_topOk && _hPos > 1.2 && _overObj getVariable ["brpvp_allow_sjump",true]) then {
								//player playAction "PlayerCrouch";
								private _p1 = _pPosASL vectorAdd [0,0,0.25];
								private _p2 = _pPosASL vectorAdd [0,0,_hPos+_brechSize];
								private _lis1 = lineIntersectsSurfaces [_p1,_p2,player,objNull,true,1,"GEOM","VIEW"];
								if (_lis1 isEqualTo []) then {
									private _hLim = getUnitFreefallInfo player select 2;
									private _newHUsed = _hLim isEqualTo 100;
									if (_newHUsed) then {player setUnitFreefallHeight 5000;};

									_normalJump = false;
									BRPVP_climbMidJumpTime = time;
									private _velSet = sqrt(22*_hPos);
									private _t = _velSet/10;
									private _mag = 1/_t;
									private _pDirRev = _pDir+180;
									[player,["jump_01",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
									private _vix = if (_hPos <= 3) then {0} else {_mag*sin _pDirRev};
									private _viy = if (_hPos <= 3) then {0} else {_mag*cos _pDirRev};
									[player,[_vix,_viy,_velSet]] remoteExecCall ["setVelocity",0];
									[_newHUsed,_pDir,_hPos,ASLToAGL _p2 select 2 > 95,[_vix,_viy,_velSet],_pPosASL,_normal,_overWallHeight] spawn {
										params ["_newHUsed","_pDir","_hPos","_io100","_tVec","_pPosASL","_normal","_overWallHeight"];
										private _hitCeil = false;
										private _countNoMove = 0;
										private _sideMove = 0;
										private _pos1 = getPosWorld player;
										private _init = diag_tickTime;
										private _gVel = 0;
										sleep 0.001;
										waitUntil {
											//if (_io100) then {player switchMove "";};
											private _pos2 = getPosWorld player;
											private _delta = diag_tickTime-_init;
											_init = _init+_delta;
											private _vel = (_pos2 vectorDiff _pos1) vectorMultiply (1/_delta);
											_gVel = _gVel+9.8*_delta;
											private _tVecNow = _tVec vectorAdd [0,0,-_gVel];
											if (acos (_vel vectorCos _tVecNow) > 20 && vectorMagnitude _vel > 0.5) then {_sideMove = _sideMove+1;} else {_sideMove = 0;};
											if (vectorMagnitude _vel < 0.005) then {_countNoMove = _countNoMove+1;} else {_countNoMove = 0;};
											_hitCeil = _sideMove isEqualTo 5 || _countNoMove isEqualTo 5;
											_pos1 = _pos2;
											private _errorIncrease = ((_pPosASL vectorAdd [0,0,_hPos]) select 2)-(getPosASL player select 2) <= 0;
											_errorIncrease || _vel select 2 < 0 || _hitCeil
										};
										player setVariable ["brpvp_no_colision",true];
										if (_hitCeil) then {
											player setVelocity (_normal vectorMultiply -1 vectorAdd [0,0,-1]);
										} else {
											[player,["jump_wall",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
											private _mPosInit = ASLToAGL getPosASL player;
											private _initMove = diag_tickTime;
											private _error = false;
											waitUntil {
												player setVelocity (_normal vectorMultiply 3.5);
												_error = diag_tickTime-_initMove > (1.5/3.5+0.25);
												isTouchingGround player || ASLtoAGL getPosASL player distance _mPosInit > 1.25 || _error
											};
											if (_error) then {player setVelocity (_normal vectorMultiply -3.5 vectorAdd [0,0,-0.25]);};
										};
										waitUntil {isTouchingGround player};
										if (_newHUsed) then {player setUnitFreefallHeight 100;};
										[player,["jump_hit_ground",150]] remoteExecCall ["say3D",BRPVP_allNoServer];
										//player playAction "PlayerStand";
										uiSleep 1;
										player setVariable ["brpvp_no_colision",false];
									};
								};
							};
						};
					};
				};
			};
			if (_normalJump) then {
				//NORMAL JUMP
				_posCheck = getPos player select 2 < 0.1;
				_lis1 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.15],player,objNull,true,1,"VIEW","NONE",true];
				_lis2 = lineIntersectsSurfaces [getPosASL player,getPosASL player vectorAdd [0,0,-0.1],player,objNull,true,1,"GEOM","NONE",true];
				_lisCheck = (count _lis1 > 0 && {(_lis1 select 0 select 2) call BRPVP_isMotorized || (_lis1 select 0 select 2) isKindOf "Building"}) || count _lis2 > 0;
				if ((_posCheck || _lisCheck) && BRPVP_canJump && !BRPVP_reparingVehicle && !(animationState player isEqualTo "ainvpknlmstpslaywrfldnon_medic")) then {
					_stuck = !_posCheck && _lisCheck;
					_vel = if (_stuck) then {[0,0,0]} else {velocity player};
					_vel set [2,(_vel select 2) max 0 min 2];
					if (vectorMagnitude [_vel select 0,_vel select 1,0] < 2) then {
						_dir = getDir player;
						_vel = if (_stuck) then {[3.5*sin _dir,3.5*cos _dir,_vel select 2]} else {[2*sin _dir,2*cos _dir,_vel select 2]};
					};

					private _hLim = getUnitFreefallInfo player select 2;
					private _newHUsed = _hLim isEqualTo 100;
					if (_newHUsed) then {player setUnitFreefallHeight 5000;};

					if (stance player isEqualTo "STAND") then {
						[player,_vel vectorAdd [0,0,5]] remoteExecCall ["setVelocity",0];
						[player,["jump_player",125]] remoteExecCall ["say3D",BRPVP_allNoServer];
						BRPVP_canJump = false;
						[_newHUsed,player,_vel] spawn BRPVP_checkFly;
					} else {
						if (stance player isEqualTo "CROUCH") then {
							[player,_vel vectorAdd [0,0,4.25]] remoteExecCall ["setVelocity",0];
							[player,["jump_player",125]] remoteExecCall ["say3D",BRPVP_allNoServer];
							BRPVP_canJump = false;
							[_newHUsed,player,_vel] spawn BRPVP_checkFly;
						};
					};
				} else {
					if (!BRPVP_reparingVehicle && !(animationState player isEqualTo "ainvpknlmstpslaywrfldnon_medic") && BRPVP_allowSecondJump) then {
						if (_climbOn) then {
							if (!BRPVP_jumpStopRunning) then {
								private _hLim = getUnitFreefallInfo player select 2;
								private _newHUsed = _hLim isEqualTo 100;
								if (_newHUsed) then {player setUnitFreefallHeight 5000;};

								BRPVP_jumpStopRunning = true;
								[player,["jump_03",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
								private _vel = velocity player vectorMultiply 1.25;
								_vel set [2,2.5];
								[player,_vel] remoteExecCall ["setVelocity",0];
								_newHUsed spawn {
									private _newHUsed = _this;
									uiSleep 0.25;
									waitUntil {getPos player select 2 < 0.125};
									[player,["jump_hit_ground",125]] remoteExecCall ["say3D",BRPVP_allNoServer];
									uiSleep 0.25;
									if (_newHUsed) then {player setUnitFreefallHeight 100;};
									BRPVP_jumpStopRunning = false;
								};
							};
						};
					};
				};
			};
		};
	};
};
BRPVP_planeBreakKeyPressed = {
	_veh = player call BRPVP_controlingUAV;
	if (isNull _veh) then {_veh = objectParent player;};
	if (_veh isKindOf "Plane" || typeOf _veh in BRPVP_vantVehiclesClassPlane) then {
		_retorno = true;
		_pos = getPos _veh;
		if (_pos select 2 < 1.5 && !BRPVP_planeBreakOn && time > BRPVP_planeBreakTime && speed _veh > 36) then {
			"achou_loot" call BRPVP_playSound;
			BRPVP_planeBreakOn = true;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\breaks.paa'/><br/>",0,0,36000,0,0,71] call BRPVP_fnc_dynamicText;
			_veh spawn {
				_veh = _this;
				_init = time;
				_vel = velocity _veh;
				_mag = vectorMagnitude _vel max 35;
				_t = 100/(_mag/2);
				_acell = _mag/_t;
				_tickOld = diag_tickTime;
				sleep 0.001;
				waitUntil {
					if (isEngineOn _veh) then {_veh engineOn false;};
					_tick = diag_tickTime;
					_dt = _tick-_tickOld;
					_v = velocity _veh;
					_vm = vectorMagnitude _v;
					_vn = _v vectorMultiply ((_vm-_dt*_acell)/_vm);
					_veh setVelocity _vn;
					_tickOld = _tick;
					getPos _veh select 2 > 1.5 || !alive _veh || !(player call BRPVP_pAlive) || time-_init > 8 || speed _veh < 9
				};
				["",0,0,0,0,0,71] call BRPVP_fnc_dynamicText;
				BRPVP_planeBreakOn = false;
				BRPVP_planeBreakTime = time+1;
			};
		};
	};
};
BRPVP_planeAccellKeyPressed = {
	_veh = player call BRPVP_controlingUAV;
	if (isNull _veh) then {_veh = objectParent player;};
	if (_veh isKindOf "Plane" || typeOf _veh in BRPVP_vantVehiclesClassPlane) then {
		_retorno = true;
		_pos = getPos _veh;
		if (_pos select 2 < 1.5 && !BRPVP_planeBreakOn && time > BRPVP_planeBreakTime && speed _veh > 30) then {
			"granted" call BRPVP_playSound;
			BRPVP_planeBreakOn = true;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\plane_accell.paa'/><br/>",0,0,36000,0,0,71] call BRPVP_fnc_dynamicText;
			_veh spawn {
				_veh = _this;
				_init = time;
				_acell = 50/2.5;
				_tickOld = diag_tickTime;
				sleep 0.001;
				_veh setVariable ["brpvp_coll_prot",true];
				waitUntil {
					_tick = diag_tickTime;
					_dt = _tick-_tickOld;
					_v = velocity _veh;
					_vm = vectorMagnitude _v;
					_vn = _v vectorMultiply ((_vm+_dt*_acell)/_vm);
					_veh setVelocity _vn;
					_tickOld = _tick;
					!alive _veh || !(player call BRPVP_pAlive) || time-_init > 2.5 || !isEngineOn _veh
				};
				["",0,0,0,0,0,71] call BRPVP_fnc_dynamicText;
				BRPVP_planeBreakOn = false;
				BRPVP_planeBreakTime = time+4;
				sleep 2;
				_veh setVariable ["brpvp_coll_prot",false];
			};
		};
	};
};
BRPVP_customMarkKeyPress = {
	_retorno = true;
	if (BRPVP_adminMsgAction select 0 isEqualTo "off") then {
		BRPVP_adminMsgAction = ["initiated",0];
		private _mPos = getMousePosition;
		private _pts = [];
		{
			_x params ["_id","_pos","_txt"];
			private _pUI = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen _pos;
			private _d = _pUI distance2D _mPos;
			_pts pushBack [_d,[_forEachIndex,_id,_pos,_txt]];
		} forEach BRPVP_myCustomMarks;
		_pts sort true;
		_mpw = (findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld _mPos;
		_param = if (count _pts > 0) then {
			if (_pts select 0 select 0 < 0.05) then {_pts select 0 select 1} else {[-1,-1,_mpw,""]};
		} else {
			[-1,-1,_mpw,""]
		};
		_param spawn {
			params ["_idx","_idMark","_pos","_txt"];
			disableSerialization;
			_display = findDisplay 46 createDisplay "RscDisplayEmpty";
			_display displayAddEventHandler ["KeyUp",{if ((_this select 1) isEqualTo 0x1C) then {BRPVP_adminMsgAction = ["Ok",0];};}];

			_input = _display ctrlCreate ["RscEdit",-1];
			_input ctrlSetPosition [0,0,1,0.065];
			_input ctrlSetBackgroundColor [0.25,0.25,0.25,1];
			_input ctrlSetText _txt;
			_input ctrlCommit 0;
			
			_bOk = _display ctrlCreate ["RscButton",-1];
			_bOk ctrlSetPosition [0,0.1,0.15,0.065];
			_bOk ctrlSetText localize "str_ok";
			_bOk ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Ok",0];}];
			_bOk ctrlCommit 0;
			
			_bCancel = _display ctrlCreate ["RscButton",-1];
			_bCancel ctrlSetPosition [0.175,0.1,0.15,0.065];
			_bCancel ctrlSetText localize "str_menu12_opt2";
			_bCancel ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Cancel",0];}];
			_bCancel ctrlCommit 0;

			if (_idx isEqualTo -1) then {
				BRPVP_myCustomMarks pushBack [-1,_pos,""];
			} else {
				_bDel = _display ctrlCreate ["RscButton",-1];
				_bDel ctrlSetPosition [0.35,0.1,0.15,0.065];
				_bDel ctrlSetText localize "str_delete_mark";
				_bDel ctrlAddEventHandler ["ButtonClick",{BRPVP_adminMsgAction = ["Delete",0];}];
				_bDel ctrlCommit 0;
			};
			
			ctrlSetFocus _input;
			BRPVP_mapDrawTime = 0;
			waitUntil {BRPVP_adminMsgAction select 0 != "initiated" || isNull _display};
			if (_idx isEqualTo -1) then {BRPVP_myCustomMarks deleteAt (count BRPVP_myCustomMarks-1);};
			if (BRPVP_adminMsgAction select 0 isEqualTo "Ok") then {
				_txtNew = ctrlText _input;
				_txtDb = [[_txtNew,"""",""""""] call BRPVP_stringReplace,":","@#$2_points$#@"] call BRPVP_stringReplace;
				BRPVP_markSaveOnDbReturn = nil;
				[player,player getVariable ["id_bd",-1],_idMark,_pos,_txtDb] remoteExecCall ["BRPVP_markSaveOnDb",2];
				if (_idx isEqualTo -1) then {
					waitUntil {!isNil "BRPVP_markSaveOnDbReturn"};
					BRPVP_myCustomMarks pushBack [BRPVP_markSaveOnDbReturn,_pos,_txtNew];
				} else {
					(BRPVP_myCustomMarks select _idx) set [2,_txtNew];
				};
			};
			if (BRPVP_adminMsgAction select 0 isEqualTo "Delete") then {
				_idMark remoteExecCall ["BRPVP_markDeleteOnDB",2];
				BRPVP_myCustomMarks deleteAt _idx;
			};
			if (!isNull _display) then {_display closeDisplay 1;};
			BRPVP_adminMsgAction = ["off",0];
			BRPVP_mapDrawTime = 0;
		};
	} else {
		"erro" call BRPVP_playSound;
	};
};
BRPVP_multiMoveInventory = {
	_retorno = true;
	private _boxVehicle = if (BRPVP_inventoryBoxes select 0 isKindOf "GroundWeaponHolder" || BRPVP_inventoryBoxes select 0 isKindOf "WeaponHolderSimulated") then {BRPVP_inventoryBoxes select 1} else {BRPVP_inventoryBoxes select 0};
	BRPVP_menuVar1 = _boxVehicle;
	BRPVP_menuVar2 = ((BRPVP_inventoryBoxes-[_boxVehicle])+[objNull]) select 0;
	if (isNull BRPVP_menuVar2) then {BRPVP_menuVar2 = ((nearestObjects [player,["WeaponHolderSimulated","GroundWeaponHolder"],2.5])+[objNull]) select 0};
	private _using1 = BRPVP_menuVar1 getVariable ["brpvp_mm_using",objNull];
	private _using2 = BRPVP_menuVar2 getVariable ["brpvp_mm_using",objNull];
	private _using1Ok = isNull BRPVP_menuVar1 || isNull _using1 || {_using1 distance BRPVP_menuVar1 > 8};
	private _using2Ok = isNull BRPVP_menuVar2 || isNull _using2 || {_using2 distance BRPVP_menuVar2 > 8};
	if (_using1Ok  && _using2Ok) then {
		BRPVP_menuVar1 setVariable ["brpvp_mm_using",player,true];
		BRPVP_menuVar2 setVariable ["brpvp_mm_using",player,true];
		BRPVP_menuVar9 = {
			private _using1Ok = isNull BRPVP_menuVar1 || {BRPVP_menuVar1 getVariable ["brpvp_mm_using",objNull] isEqualTo player && player distance BRPVP_menuVar1 <= 7.5};
			private _using2Ok = isNull BRPVP_menuVar2 || {BRPVP_menuVar2 getVariable ["brpvp_mm_using",objNull] isEqualTo player && player distance BRPVP_menuVar2 <= 7.5};
			private _forceExit = !(_using1Ok && _using2Ok);
			if (_forceExit) then {
				private _u1 = BRPVP_menuVar1 getVariable ["brpvp_mm_using",objNull];
				private _u2 = BRPVP_menuVar2 getVariable ["brpvp_mm_using",objNull];
				if (_u1 isEqualTo player) then {BRPVP_menuVar1 setVariable ["brpvp_mm_using",objNull,true];};
				if (_u2 isEqualTo player) then {BRPVP_menuVar2 setVariable ["brpvp_mm_using",objNull,true];};
				BRPVP_menuVar1 = objNull;
				BRPVP_menuVar2 = objNull;
			};
			_forceExit								
		};
		if (isNull findDisplay 602) then {
			207 call BRPVP_iniciaMenuExtra;
		} else {
			(findDisplay 602) closeDisplay 1;
			0 spawn {
				uiSleep 0.001;
				207 call BRPVP_iniciaMenuExtra;
			};
		};
	} else {
		"erro" call BRPVP_playSound;
	};
};
BRPVP_selectBotTargetForTurret = {
	_retorno = true;
	if (time-BRPVP_selectBotTargetForTurretTime > 0.25) then {
		BRPVP_selectBotTargetForTurretTime = time;
		private _tBot = cursorObject call BRPVP_returnBot;
		if (isNull _tBot) then {
			private _posCam = AGLToASL (positionCameraToWorld [0,0,0]);
			private _vec = (getCameraViewDirection player) vectorMultiply 1750;
			{
				private _try = (_x select 2) call BRPVP_returnBot;
				if (!isNull _try) exitWith {_tBot = _try;};
			} forEach lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,vehicle player,objNull];
		};
		if (isNull _tBot) then {
			"erro" call BRPVP_playSound;
		} else {
			BRPVP_tBot = _tBot;
			"engage" call BRPVP_playSound;
			["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\bot_target.paa'/>",0,0,1,0,0,46731] call BRPVP_fnc_dynamicText;
			vehicle _tBot spawn {
				private _init = diag_tickTime;
				waitUntil {
					private _drawCoords = [[_this],2,[1,0,0,1]] call BRPVP_getCubeDrawCoords;
					{{drawLine3D _x;} forEach (_x select 1);} forEach _drawCoords;
					diag_tickTime-_init > 60 || _this isNotEqualTo vehicle BRPVP_tBot || !alive _this
				};
			};
		};
	};
};
BRPVP_cancelTeleport = {
	if ({isNull _x} count BRPVP_teleCancelTravel isEqualTo 0 && (player call BRPVP_pAlive)) then {
		_retorno = true;
		BRPVP_teleCancelTravel params ["_teleDeviceOrigin","_teleDeviceDestine"];
		if (player distanceSqr _teleDeviceDestine <= 36) then {
			_dir = getDir _teleDeviceOrigin;
			_pos = ASLToAGL getPosASL _teleDeviceOrigin;
			_pos = [_pos,1,_dir] call BIS_fnc_relPos;
			BRPVP_teleCancelTravel = [objNull,objNull];
			[player,["teleport",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
			[_pos,_dir] spawn {
				params ["_pos","_dir"];
				uiSleep 0.15;
				if ((player call BRPVP_pAlive)) then {
					player setPosASL AGLToASL _pos;
					player setDir _dir;
				};
			};
		} else {
			"erro" call BRPVP_playSound;
		};
	};
};
BRPVP_updateTirePositionKeyPress = {
	if (isNull objectParent player) then {
		private _found = objNull;
		{if (typeOf _x in ["PlasticBarrier_02_grey_F","PlasticBarrier_02_yellow_F"] && _x getVariable ["brpvp_tire_idbd",-1] > -1) exitWith {_found = _x;};} forEach attachedObjects player;
		if (!isNull _found) then {
			private _pwt = getPosWorld _found;
			private _lis = [_pwt,_pwt vectorAdd [0,0,-3.5],_found,player,"GEOM","FIRE"] call BRPVP_lis;
			if (_lis isEqualTo []) then {
				"erro" call BRPVP_playSound;
			} else {
				private _ground = _lis select 0 select 2;
				if (isNull _ground || !(_ground call BRPVP_isMotorized || _ground isKindOf "CaManBase")) then {
					private _newPos = _lis select 0 select 0;
					private _normal = _lis select 0 select 1;
					private _class = configName (_found getVariable "brpvp_tire_nameCFG");
					private _id = _found getVariable "brpvp_tire_idbd";
					private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
					_CVL setVectorUp [0,0,1];
					private _dh = abs ((getPosWorld _CVL select 2)-(getPosASL _CVL select 2));
					deleteVehicle _CVL;
					private _newPosFix = _newPos vectorAdd (_normal vectorMultiply (_dh*1.05));
					private _d = getDir player-90;
					private _vDir = [sin _d,cos _d,0];
					private _to = typeOf _ground;
					private _fix = [0,0,0.05];
					{if (_x select 0 isEqualTo _to) exitWith {_fix = [0,0,_x select 1];};} forEach BRPVP_tiresFloorHFix;
					_newPos = _newPos vectorAdd _fix;
					detach _found;
					_found setPosASL _newPos;
					_found setVectorUp _normal;
					[_id,format ["[%1,[%2,%3]]",_newPosFix call KK_fnc_positionToString,_vDir,_normal]] remoteExecCall ["BRPVP_tireVehUpdatePos",2];
					[_id,[_newPos,[vectorDir _found,_normal]]] remoteExecCall ["BRPVP_tireUpdateTirePosFromArrayCVL",0];
				} else {
					"erro" call BRPVP_playSound;
				};
			};
			_retorno = true;
		};
	};
};
BRPVP_changeWeapons1A1B = {
	if (time-BRPVP_doubleOneWeaponTime > 0.25) then {
		BRPVP_doubleOneWeaponTime = time;
		if (time-BRPVP_weaponPrivateSlotTime > 0.5) then {
			private _wep1Class = primaryWeapon player;
			private _currWep = currentWeapon player;
			private _wep4 = player getVariable ["brpvp_weapon_4",[]];
			if ((_currWep isNotEqualTo "" && _currWep isEqualTo _wep1Class) || (_wep1Class isEqualTo "" && _wep4 isNotEqualTo [])) then {
				_retorno = true;
				private _wep1 = [];
				private _wep1Zeroings = [];
				{
					if (_x select 0 isEqualTo _wep1Class) exitWith {
						_wep1 = _x;
						{
							private _muzz = if (_x isEqualTo "this") then {_wep1Class} else {_x};
							_wep1Zeroings pushBack [_wep1Class,_muzz,(player currentZeroing [_wep1class,_muzz]) select 1];
						} forEach getArray (configfile >> "CfgWeapons" >> _wep1Class >> "muzzles");
					};
				} forEach weaponsItems player;
				private _save = if (_wep1 isEqualTo []) then {[]} else {[_wep1,_wep1Zeroings]};
				player setVariable ["brpvp_weapon_4",_save,true];
				player removeWeapon _wep1Class;
				if (_wep4 isEqualTo []) then {
					player action ["SwitchWeapon",player,player,100];
				} else {
					_wep4 params ["_wep4Weapon","_wep4Zeroing"];
					private _nPrimary = _wep4Weapon deleteAt 0;										
					private _conts = [uniformContainer player,vestContainer player,backpackContainer player];
					private _mags = _conts apply {magazinesAmmoCargo _x};
					player addWeapon _nPrimary;
					{player removePrimaryWeaponItem _x;} forEach primaryWeaponItems player;
					{
						private _item = if (_x isEqualType "") then {[_x]} else {_x};
						player addWeaponItem [_nPrimary,_item,true];
					} forEach _wep4Weapon;
					private _magsAfter = _conts apply {magazinesAmmoCargo _x};
					{
						private _idx = _forEachIndex;
						{
							private _magsIdx = _mags select _idx;
							_magsIdx deleteAt (_magsIdx find _x);
						} forEach _x;
					} forEach _magsAfter;
					{
						_idx = _forEachIndex;
						{
							_conts select _idx addMagazineAmmoCargo [_x select 0,1,_x select 1];
						} forEach _x;
					} forEach _mags;
					player selectWeapon _nPrimary;
					{player setWeaponZeroing _x;} forEach _wep4Zeroing;
				};
				call BRPVP_atualizaDebug;
			};
		} else {
			"erro" call BRPVP_playSound;
		};
	};
};
BRPVP_boxOnHeadKeyPress = {
	if (!_onVeh && !BRPVP_itemMagnetOn) then {
		_retorno = true;
		if (time-BRPVP_carryUsedLastTime > 0.35) then {
			BRPVP_carryUsedLastTime = time;
			private _obj = _this;
			if (isNull _obj) then {
				private _vec = (getCameraViewDirection player) vectorMultiply 6;
				private _posCam = AGLToASL (positionCameraToWorld [0,0,0]);
				{
					private _typeOf = typeOf (_x select 2);
					if (_typeOf isNotEqualTo "") exitWith {if (_typeOf in ["WeaponHolderSimulated","GroundWeaponHolder"]) then {_obj = _x select 2;};};
				} forEach lineIntersectsSurfaces [_posCam,_posCam vectorAdd _vec,player,objNull,true,3,"VIEW","FIRE"];
			};
			private _acs = !isNull _obj && {_obj call BRPVP_checaAcesso};
			if (BRPVP_carryingBox) then {
				if (isNull _obj) then {
					if (BRPVP_boxCarryAction) then {
						BRPVP_boxCarryAction = false;
						"head_items_on_ground" call BRPVP_playSound;
						BRPVP_carryUsedObjs spawn BRPVP_boxCarryReleaseActionCode;
					};
				} else {
					if (!(_obj getVariable ["brpvp_no_carry",false]) && _acs) then {([_obj]+BRPVP_carryUsedObjs) spawn BRPVP_boxCarryJoinItemsCode;} else {"erro" call BRPVP_playSound;};
				};
			} else {
				if (!isNull _obj && !(_obj getVariable ["brpvp_no_carry",false]) && _acs) then {
					BRPVP_carryingBox = true;
					private _box = createSimpleObject ["A3\Weapons_F\Ammoboxes\Proxy_UsBasicWeaponBox.p3d",[0,0,0]];
					BRPVP_carryUsedObjs = [_obj,_box];
					[_obj,_box] spawn BRPVP_boxCarryActionCode;
				} else {
					"erro" call BRPVP_playSound;
				};
			};
		};
	} else {
		"erro" call BRPVP_playSound;
	};
};
BRPVP_mineDetectorKeyPress = {
	_retorno = true;
	if (time-BRPVP_mineDetectorKeyPressTime > 0.25) then {
		BRPVP_mineDetectorKeyPressTime = time;
		if ("MineDetector" in items player) then {
			BRPVP_mineDetectorOn = !BRPVP_mineDetectorOn;
			if (BRPVP_mineDetectorOn) then {
				["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\mine_detector.paa' />",{safeZoneX+safeZoneW-0.14},{safeZoneY+0.23},1000000,0,0,3096] call BRPVP_fnc_dynamicText;
				[localize "str_mine_detector_on",-4] call BRPVP_hint;
				0 spawn {
					waitUntil {!("MineDetector" in items player) || !BRPVP_mineDetectorOn};
					if (BRPVP_mineDetectorOn) then {
						["",0,0,0,0,0,3096] call BRPVP_fnc_dynamicText;
						BRPVP_mineDetectorOn = false;
					};
				};
			} else {
				["",0,0,0,0,0,3096] call BRPVP_fnc_dynamicText;
				[localize "str_mine_detector_off",-4] call BRPVP_hint;
			};
		} else {
			"erro" call BRPVP_playSound;
			[localize "str_mine_detector_need",-5] call BRPVP_hint;
		};
	};
};
BRPVP_hidraulicKeyPress = {
	_retorno = true;
	if ({player distanceSqr (_x select 0) <= _x select 1} count BRPVP_safeZonesOtherMethodQuad isEqualTo 0) then {
		if (time-BRPVP_hydraulicJackUseTime > 1) then {
			if (!BRPVP_hydraulicJackDoing) then {
				BRPVP_hydraulicJackUseTime = time;
				if (BRPVP_hydraulicJackTime > time) then {
					_p1 = AGLToASL positionCameraToWorld [0,0,0];
					_p2 = _p1 vectorAdd ((getCameraViewDirection player) vectorMultiply 6);
					_lis = lineIntersectsSurfaces [_p1,_p2,player];
					if (_lis isEqualTo [] || !isNull objectParent player) then {
						"erro" call BRPVP_playSound;
					} else {
						_object = _lis select 0 select 2;
						if (_object call BRPVP_isMotorizedNoTurret) then {
							BRPVP_hydraulicJackDoing = true;
							_object spawn {
								_object = _this;
								[_object,15] call BRPVP_enableVehOnInteraction;
								[_object,["hydraulic_jack_set",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
								sleep 2.5;
								_dir = getDir player;
								_vec = if (_object isKindOf "Helicopter") then {[sqrt(2)*sin _dir,sqrt(2)*cos _dir,2]} else {[3*sin _dir,3*cos _dir,3]};
								[_object,["hydraulic_jack",250]] remoteExecCall ["say3D",BRPVP_allNoServer];
								[_object,_vec] remoteExecCall ["setVelocity",0];
								BRPVP_hydraulicJackDoing = false;
							};
						} else {
							"erro" call BRPVP_playSound;
						};
					};
				} else {
					[localize "str_hydrajack_need_one",-5] call BRPVP_hint;
				};
			};
		};
	} else {
		[localize "str_hydrajack_cant_on_safe",-6] call BRPVP_hint;
	};
};
BRPVP_hackPlayerKeyPress = {
	_retorno = true;
	if (cameraView isEqualTo "GUNNER" && currentWeapon player in BRPVP_binocularToIgnoreAsWeapon) then {
		_haveDevice = 41 call BRPVP_sitCountItem > 0;
		if (_haveDevice && (player getVariable ["brpvp_my_hack",[]]) isEqualTo []) then {
			_obj = cursorObject;
			if (!isNull _obj && !(_obj call BRPVP_checkIfSafeZoneProtected) && _obj call BRPVP_isPlayer  && isNull (_obj getVariable ["brpvp_hack_on_me",objNull])) then {
				if (count BRPVP_hackLines isEqualTo 0) then {
					"hackAddLine" call BRPVP_playSound;
					BRPVP_hackLines pushBack [[1,0,0,1],0,time+BRPVP_hackLineTimeWait,_obj,getPosASL _obj];
				} else {
					if (count BRPVP_hackLines isEqualTo 1) then {
						if (_obj isEqualTo (BRPVP_hackLines select 0 select 3)) then {
							if (time > BRPVP_hackLines select 0 select 2) then {
								"hackAddLine" call BRPVP_playSound;
								BRPVP_hackLines pushBack [[0,1,0,1],0,time+BRPVP_hackLineTimeWait,_obj,getPosASL _obj];
							} else {
								"hackWait" call BRPVP_playSound;
							};
						} else {
							BRPVP_hackLines = [];
							"hackFail" call BRPVP_playSound;
						};
					} else {
						if (count BRPVP_hackLines isEqualTo 2) then {
							if (_obj isEqualTo (BRPVP_hackLines select 1 select 3)) then {
								if (time > BRPVP_hackLines select 1 select 2) then {
									"hackAddLine" call BRPVP_playSound;
									BRPVP_hackLines pushBack [[0,0,1,1],0,time+BRPVP_hackLineTimeWait,_obj,getPosASL _obj];
								} else {
									"hackWait" call BRPVP_playSound;
								};
							} else {
								BRPVP_hackLines = [];
								"hackFail" call BRPVP_playSound;
							};
						} else {
							if (count BRPVP_hackLines isEqualTo 3) then {
								if (_obj isEqualTo (BRPVP_hackLines select 2 select 3)) then {
									if (time > BRPVP_hackLines select 2 select 2) then {
										_obj setVariable ["brpvp_hack_on_me",player,true];
										_hackMoney = (_obj getVariable ["brpvp_mny_bank",0])*BRPVP_hackPercentage max 0 min BRPVP_hackMoneyLimit;
										player setVariable ["brpvp_my_hack",[_obj,_obj getVariable ["id_bd",-1],_hackMoney,0,ASLToAGL getPosASL player,_obj getVariable ["nm","???"]]];
										"hackAddCounter" call BRPVP_playSound;
									} else {
										"hackWait" call BRPVP_playSound;
									};
								} else {
									BRPVP_hackLines = [];
									"hackFail" call BRPVP_playSound;
								};
							};
						};
					};			
				};
			} else {
				BRPVP_hackLines = [];
				"hackFail" call BRPVP_playSound;
			};
		};
	};
};
BRPVP_colorMarkKeyPress = {
	if (time-BRPVP_colorMarkKeyPressTime > 0.25) then {
		BRPVP_colorMarkKeyPressTime = time;
		private ["_idc"];
		_retorno = true;
		if (_key isEqualTo 0x3B) then {_idc = 0;};
		if (_key isEqualTo 0x3C) then {_idc = 1;};
		if (_key isEqualTo 0x3D) then {_idc = 2;};
		_setas = player getVariable ["sts",[[],[],[]]];
		if (_setas select _idc isEqualTo []) then {
			if (visibleMap) then {
				_setas set [_idc,(findDisplay 12 displayCtrl 51) ctrlMapScreenToWorld getMousePosition];
				player setVariable ["sts",_setas,true];
			} else {
				_p1 = AGLToASL positionCameraToWorld [0,0,0];
				_viewVec = _p1 vectorFromTo AGLToASL positionCameraToWorld [0,0,1];
				_p2 = _p1 vectorAdd (_viewVec vectorMultiply 4800);
				_UAV = getConnectedUAV player;
				_lis = lineIntersectsSurfaces [_p1,_p2,vehicle player,_UAV,true,1,"GEOM","NONE"];
				if (_lis isEqualTo []) then {
					"erro" call BRPVP_playSound;
				} else {
					_setas set [_idc,ASLToAGL (_lis select 0 select 0)];
					player setVariable ["sts",_setas,true];
				};
			};
		} else {
			_setas set [_idc,[]];
			player setVariable ["sts",_setas,true];
		};
	};
};
BRPVP_mainKeyDownTimes = [];
for "_i" from 1 to 200 do {BRPVP_mainKeyDownTimes append [0,0,0,0,0,0,0,0,0,0]};
BRPVP_mainKeyDown = {
	private _ttInit = diag_tickTime;
	private _retorno = if (BRPVP_isAdminOrModerator) then {_this call BRPVP_adminKeyDown} else {false};
	params ["_controle","_key","_keyShift","_keyCtrl","_keyAlt"];

	private _XXX = !_keyShift && !_keyCtrl && !_keyAlt;
	private _SXX = _keyShift && !_keyCtrl && !_keyAlt;
	private _XCX = !_keyShift && _keyCtrl && !_keyAlt;
	private _XXA = !_keyShift && !_keyCtrl && _keyAlt;
	private _SXA = _keyShift && !_keyCtrl && _keyAlt;
	private _XCA = !_keyShift && _keyCtrl && _keyAlt;

	if !(_key isEqualTo 0x32 && _XXX && BRPVP_inventoryBoxes isNotEqualTo [] && !isNull findDisplay 602) then {
		if (inputAction "showMap" isEqualTo 1) exitWith {
			0 spawn {
				uiSleep 0.001;
				call BRPVP_atualizaDebug;
			};
			false
		};
	};

	if (BRPVP_construindo) then {
		_this call BRPVP_consCode;
	} else {
		if (BRPVP_menuExtraLigado) then {
			if (!BRPVP_menuCustomKeysOff) then {call BRPVP_menuCode;};
			_retorno = !(_key in BRPVP_notBlockedKeys);
		} else {
			if (BRPVP_walkDisabled) then {
				_retorno = !(_key in BRPVP_notBlockedKeys || _key in [0x39,0x9C]);
				//PRESS END TO CANCEL UBER BACK PACK ON MAP
				if (BRPVP_uPackUsing) then {
					if (_key isEqualTo 0xCF && _XXX) then {
						_return = true;
						if (isNil "BRPVP_uPackSelected") then {BRPVP_uPackSelected = [0,0,0];};
					};
				};
				//SELECT ELEVATOR DOOR
				if (BRPVP_usingElevator && _XXX && _key in [0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x00,0x0A]) then {
					_retorno = true;
					if (_key isEqualTo 0x01) then {BRPVP_usingElevatorDoorSelected = -1;};
					if (_key isEqualTo 0x02) then {BRPVP_usingElevatorDoorSelected = 1;};
					if (_key isEqualTo 0x03) then {BRPVP_usingElevatorDoorSelected = 2;};
					if (_key isEqualTo 0x04) then {BRPVP_usingElevatorDoorSelected = 3;};
					if (_key isEqualTo 0x05) then {BRPVP_usingElevatorDoorSelected = 4;};
					if (_key isEqualTo 0x06) then {BRPVP_usingElevatorDoorSelected = 5;};
					if (_key isEqualTo 0x07) then {BRPVP_usingElevatorDoorSelected = 6;};
					if (_key isEqualTo 0x08) then {BRPVP_usingElevatorDoorSelected = 7;};
					if (_key isEqualTo 0x09) then {BRPVP_usingElevatorDoorSelected = 8;};
					if (_key isEqualTo 0x00) then {BRPVP_usingElevatorDoorSelected = 9;};
					if (_key isEqualTo 0x0A) then {BRPVP_usingElevatorDoorSelected = 10;};
				};
			} else {
				if (player getVariable ["sok",false]) then {
					if (player call BRPVP_pAlive) then {
						_onVeh = !isNull objectParent player;
						call BRPVP_baseFlyCode;
						//SABOTAGED CAR BRAKE
						if (inputAction "CarBack" > 0 || inputAction "CarHandBrake" > 0) then {
							private _veh = objectParent player;
							if (!isNull _veh && _veh getVariable ["brpvp_veh_saboted",false]) then {
								_retorno = true;
								if (time-BRPVP_vehRattleLast > 2) then {
									BRPVP_vehRattleLast = time;
									private _tries = _veh getVariable ["brpvp_sabo_tries",0];
									if (_tries isNotEqualTo 0 && (random 1 < BRPVP_vehSabotageFixChanceEachTry || _tries >= BRPVP_vehSabotageFixMaxTries)) then {
										["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\brake_ok.paa'/>",0,0.2,2,0,0,7757] call BRPVP_fnc_dynamicText;
										_veh setVariable ["brpvp_veh_saboted",false,true];
										[_veh,["sabotage_fixed",600]] remoteExecCall ["BRPVP_sabotageSounds",0];
										_veh setVariable ["brpvp_sabo_tries",0];
										_retorno = false;
									} else {
										["<img shadow='0' size='2.5' image='"+BRPVP_imagePrefix+"BRP_imagens\brake_sabotaged.paa'/><br /><t>"+format [localize "str_brake_not_working",round (BRPVP_vehSabotageFixChanceEachTry*100),"%"]+"</t>",0,0.2,2,0,0,7757] call BRPVP_fnc_dynamicText;
										_veh setVariable ["brpvp_sabo_tries",_tries+1];
										[_veh,[BRPVP_rattleArray select BRPVP_rattleIdx,600]] remoteExecCall ["BRPVP_sabotageSounds",0];
										BRPVP_rattleIdx = (BRPVP_rattleIdx+1) mod count BRPVP_rattleArray;
									};
								};
							};
						};
						//REPEAT CONSTRUCTION
						if (_key isEqualTo 0x43 && _XXX) then {
							if (count BRPVP_lastConsObj1 >= 2 && count BRPVP_lastConsObj2 >= 2) then {
								_retorno = true;
								private _notNull = BRPVP_lastConsObj1 isNotEqualTo [] && BRPVP_lastConsObj2 isNotEqualto [];
								private _isSame = (BRPVP_lastConsObj1#0) isEqualTo (BRPVP_lastConsObj2#0);
								private _distOk = vectorMagnitude ((BRPVP_lastConsObj1#1) vectorDiff (BRPVP_lastConsObj2#1)) < 27.5;
								if (_notNull && _isSame && _distOk) then {
									private _itemKitIdx = (BRPVP_lastConsObj1#0) call BRPVP_getConstructionKitIdx;
									if (_itemKitIdx isNotEqualTo -1 && {_itemKitIdx call BRPVP_sitCountItem > 0 || BRPVP_vePlayers}) then {
										private _dV = (BRPVP_lastConsObj1#1) vectorDiff (BRPVP_lastConsObj2#1);
										private _dD = [BRPVP_lastConsObj2#3,BRPVP_lastConsObj1#3] call BRPVP_angleBetweenSignal;
										private _nX = (_dV#0)*cos -_dD - (_dV#1)*sin -_dD;
										private _nY = (_dV#0)*sin -_dD + (_dV#1)*cos -_dD;
										private _hFix = if ((BRPVP_lastConsObj1#0) isKindOf ["StaticWeapon",configFile >> "CfgVehicles"]) then {0.0108843} else {0};
										private _posW = (BRPVP_lastConsObj1#1) vectorAdd [_nX,_nY,_dV#2-_hFix];
										private _posASL = (BRPVP_lastConsObj1#2) vectorAdd [_nX,_nY,_dV#2-_hFix];
										private _dir = (BRPVP_lastConsObj1#3)+_dD;
										private _item = BRPVP_lastConsObj1#0;
										private _param7 = [_item,_posW,_posASL,_dir];
										private _mapa = BRPVP_lastConsObj1#4;
										if (_mapa) then {
											[[_item],"",-1,_mapa,objNull,0,_param7] call BRPVP_construir;
										} else {
											[[_item],"",_item call BRPVP_getConstructionKitIdx,_mapa,objNull,50000,_param7] call BRPVP_construir;
										};
									} else {
										"erro" call BRPVP_playSound;
									};
								} else {
									"erro" call BRPVP_playSound;
								};
							};
						};
						//HOTKEYS
						if (_key in [0x3F,0x40,0x41,0x42] && (_XXX || _SXX)) then {
							_retorno = true;
							private _idx = [0x3F,0x40,0x41,0x42] find _key;
							private _item = BRPVP_itemsHotkeys select _idx;
							[format ["<img size='2.5' align='center' image='"+BRPVP_imagePrefix+"%1'/>",BRPVP_specialItemsImages select (BRPVP_specialItems find _item)],0,0.5,0.5,0,0,34793] call BRPVP_fnc_dynamicText;
							if (_XXX) then {
								private _param = BRPVP_specialItems find _item;
								BRPVP_menuVar1 = BRPVP_specialItemsGroup select (BRPVP_specialItems find _item);
								call BRPVP_useCustomItem;
							} else {
								"hint2" call BRPVP_playSound;								
							};
						};
						//SUPER JUMP BOOST
						if (_key isEqualTo 0x11 && BRPVP_superJumpRunning && BRPVP_superJumpBoost > 0) then {
							_retorno = true;
							private _vel = velocity player;
							private _mag = vectorMagnitude _vel;
							private _vc1 = [0,0,1] vectorCrossProduct _vel;
							private _vc2 = vectorNormalized (_vel vectorCrossProduct _vc1);
							private _newVel = vectorNormalized (_vel vectorAdd (_vc2 vectorMultiply (_mag*0.5))) vectorMultiply _mag;
							player setVelocity _newVel;
							[player,["jump_player",200]] remoteExecCall ["say3D",BRPVP_allNoServer];
							BRPVP_superJumpBoost = BRPVP_superJumpBoost-1;
						};
						//SUPER JUMP BRAKE
						if (_key isEqualTo 0x1F && BRPVP_superJumpRunning) then {
							_retorno = true;
							private _vel = velocity player;
							private _mag = vectorMagnitude _vel;
							private _vc1 = [0,0,1] vectorCrossProduct _vel;
							private _vc2 = vectorNormalized (_vc1 vectorCrossProduct _vel);
							private _newVel = vectorNormalized (_vel vectorAdd (_vc2 vectorMultiply (_mag*0.45))) vectorMultiply _mag;
							player setVelocity _newVel;
						};
						//OPEN MULTI MOVE INVENTORY
						if (_key isEqualTo 0x32 && _XXX && BRPVP_inventoryBoxes isNotEqualTo [] && !isNull findDisplay 602) then {call BRPVP_multiMoveInventory;};
						//CANCEL GET OVER
						if (inputAction "GetOver" > 0) then {_retorno = player call BRPVP_checkOnFlagState isEqualTo 1;};
						//ANTI-DUPE?
						if (_key in actionKeys "gear" && _XXX) then {_retorno = BRPVP_antiWeaponDupeBoolean;};
						//ACCESS ALL NEAR OBJECTS
						if (_key isEqualTo 0x38) then {BRPVP_accessAllNear = time;};
						//PLANE BREAK
						if (_key isEqualTo 0x30 && _XXX) then {call BRPVP_planeBreakKeyPressed;};
						//PLANE ACCELL
						if (_key isEqualTo 0x30 && _SXX) then {call BRPVP_planeAccellKeyPressed;};
						//CONSTANT RUN ON FOOT AND VEHICLE
						if (_key isEqualTo 0x11) then {
							if (!BRPVP_nitroFlyWPressed) then {
								if (diag_tickTime-BRPVP_superRunLastPressTime > 0.35) then {BRPVP_superRunPressCount = 0;};
								BRPVP_superRunLastPressTime = diag_tickTime;
								BRPVP_superRunPressCount = BRPVP_superRunPressCount+1;
								if (BRPVP_constantRunOn) then {BRPVP_constantRunOn = false;};
							};
							BRPVP_nitroFlyWPressed = true;
							if (BRPVP_superRunPressCount isEqualTo 3) then {
								call BRPVP_constantRunFootVehicle;
								BRPVP_superRunPressCount = 0;
							};
						};
						//SELECT BOT FOR TURRET TARGET
						if (_key isEqualTo 0x21 && _SXX) then {call BRPVP_selectBotTargetForTurret;};
						//DEFUSE FANTA MINE: CTRL+ALT+E
						if (_key isEqualTo 0x12 && _XCA) then {
							_retorno = true;
							if (!isNull BRPVP_baseMineDefuse) then {
								if ("BRPVP_baseMineDefuse" call BRPVP_sitCountItem > 0) then {
									private _mId = BRPVP_baseMineDefuse getVariable ["brpvp_mine_base_id",-1];
									if (_mId isNotEqualTo -1) then {_mId remoteExecCall ["BRPVP_fantaMineRemove",2];};
									deleteVehicle BRPVP_baseMineDefuse;
									["BRPVP_baseMineDefuse",1] call BRPVP_sitRemoveItem;
								} else {
									"erro" call BRPVP_playSound;
								};
							};
						};
						//CANCEL TELEPORT TRAVEL
						if (_key isEqualTo 0x0E && _XXX) then {call BRPVP_cancelTeleport;};
						//JUMP
						if (_key isEqualTo 0x39 && _SXX && {isNull objectParent player}) then {call BRPVP_allJumpTypes;};
						//SUPER JUMP
						if (_key isEqualTo 0x39 && _XCX) then {
							_retorno = true;
							private _nearPeter = {alive _x && player distance _x < 350} count BRPVP_peterModel > 0;
							if ((BRPVP_superJumpCount > 0 || _nearPeter) && !BRPVP_superJumpRunning && !BRPVP_possOtherPlayer && stance player isNotEqualTo "PRONE") then {
								private _can = BRPVP_safeZone || ((player getVariable ["brpvp_pve_inside",0] > 0 && BRPVP_pveAllowSuperJump) && player getVariable ["brpvp_in_pvp_zone",0] isEqualTo 0) || _nearPeter;
								if (position player select 2 < 0.15 && player isEqualTo vehicle player && _can) then {
									BRPVP_superJumpRunning = true;
									0 spawn {uiSleep 0.25;if (BRPVP_superJumpRunning) then {BRPVP_superJumpBoost = BRPVP_superJumpBoostCfg;};};
									private _lis = lineIntersectsSurfaces [getPosASL player vectorAdd [0,0,0.5],getPosASL player vectorAdd [0,0,-2],player,objNull,true,1,"GEOM","NONE",true];
									private _normal = if (_lis isEqualTo []) then {[0,0,1]} else {_lis select 0 select 1};
									private _vec = [50,30];
									if (_normal isNotEqualTo [0,0,1]) then {
										private _dir = getDir player;
										private _angle = aCos ([sin _dir,cos _dir,0] vectorCos _normal);
										private _dltAngle = _angle-90;
										private _newAngle = 31+_dltAngle;
										_vec = [58.3*cos _newAngle,58.3* sin _newAngle];
									};
									_vec spawn BRPVP_superJump;
								};
							};
						};
						//PRESS END TO CANCEL UBER BACK PACK
						if (BRPVP_uPackUsing) then {
							if (_key isEqualTo 0xCF && _XXX) then {
								_return = true;
								if (isNil "BRPVP_uPackSelected") then {
									BRPVP_uPackSelected = [0,0,0];
								} else {
									if (BRPVP_uPackSelected isNotEqualTo [0,0,0] && BRPVP_uPackSelected distance2D player > 155) then {
										private _mag = vectorMagnitude ((velocity player select [0,2])+[0]);
										private _pASL = getPosASL player;
										private _dist = _mag*2 min 150;
										BRPVP_uPackSelected = _pASL vectorAdd (vectorNormalized (BRPVP_uPackSelected vectorDiff _pASL) vectorMultiply _dist);
										//[_tank,["uber_pack_init",_jpVolume]] remoteExecCall ["say3D",BRPVP_allNoServer];
									};
								};
							};
						};
						//SKY DIVE
						if (_key isEqualTo 0x11 && _SXX) then {BRPVP_paraParam = BRPVP_skyDiveVelocity;} else {if (_key isEqualTo 0x1F && _SXX) then {BRPVP_paraParam = BRPVP_skyDiveUp;};};
						//ANSWER YES FOR A BODY EXCHANGE CTRL+ALT+W
						if (_key isEqualTo 0x11 && _XCA) then {
							if (BRPVP_bodyChangeInvited && !BRPVP_bodyChangeTrying && !BRPVP_spectateOn && !BRPVP_possOtherPlayer) then {
								private _askerOk = !isNull BRPVP_bodyChangeAsker && BRPVP_bodyChangeAsker call BRPVP_pAlive && BRPVP_bodyChangeAsker getVariable ["sok",false] && isNull objectParent BRPVP_bodyChangeAsker;
								private _meOk = !isNull player && player call BRPVP_pAlive && player getVariable ["sok",false] && isNull objectParent player;
								if (_askerOk && _meOk) then {player setVariable ["brpvp_bodyc_answer","ok",[BRPVP_bodyChangeAskerMid,clientOwner]];} else {"erro" call BRPVP_playSound;};
							} else {
								"erro" call BRPVP_playSound;
							};
							_return = true;
						};						
						//UPDATE TIRE POSITION
						if (_key isEqualTo 0x1C && _XXX) then {
							_retorno = true;
							call BRPVP_updateTirePositionKeyPress;
						};
						//CUSTOM MARK
						if (_key isEqualTo 0x05 && _XCX && visibleMap) then {call BRPVP_customMarkKeyPress;};
						//CARRIER PLACEMENT CANCEL
						if (_key isEqualTo 0x0E && _XXX && BRPVP_carrierUseStatus > 0) then {
							_retorno = true;
							if (!BRPVP_carrierEscPressed) then {"erro" call BRPVP_playSound;};
							BRPVP_carrierEscPressed = true;
						};
						//CARRY ITEM SHORTCUT (SHIFT+E)
						if (_key isEqualTo 0x12 && _SXX && {isNull BRPVP_myUAVNow && isNull objectParent player}) then {objNull call BRPVP_boxOnHeadKeyPress;};
						//CHANGE BETWEEN WEAPONS 1 AND 4
						if (_key isEqualTo 0x02 && _XXX) then {call BRPVP_changeWeapons1A1B;};
						//TURN MINE DETECTOR ON OFF
						if (_key isEqualTo 0x32 && _XXA) then {call BRPVP_mineDetectorKeyPress;};
						//FARM AND CRAFT
						if (_key isEqualTo 0x2E && _XCX) then {
							_retorno = true;
							_obj = cursorObject;
							_isMachine = typeOf _obj in ["Land_DieselGroundPowerUnit_01_F","Land_WoodenCounter_01_F","Land_WoodenPlanks_01_F"];
							_isDb = !((_obj getVariable ["id_bd",-1]) isEqualTo -1);
							_isMap = _obj getVariable ["brpvp_map",false];
							if (_isMachine && (_isDb || _isMap) && _obj distanceSqr player < 64) then {
								//if (_obj call BRPVP_checaAcesso || _isMap) then {_obj call BRPVP_craftDo;} else {[localize "str_no_access",-4] call BRPVP_hint;};
								if (true) then {_obj call BRPVP_craftDo;} else {[localize "str_no_access",-4] call BRPVP_hint;};
							} else {
								call BRPVP_farmDo;
							};
						};
						//PUSH VEHICLE
						if (_key isEqualTo 0x04 && _SXX && !(BRPVP_flyOnOff || BRPVP_flyOnOffAdmin)) then {call BRPVP_hidraulicKeyPress;};
						//REMOTE CONTROL
						if (_key isEqualTo 0x03 && _SXX && !(BRPVP_flyOnOff || BRPVP_flyOnOffAdmin)) then {
							_retorno = true;
							if (time-BRPVP_remoteControlTime > 1) then {
								BRPVP_remoteControlTime = time;
								if (43 call BRPVP_sitCountItem isEqualTo 0) then {[localize "str_remote_control_dont_have",-5] call BRPVP_hint;} else {false call BRPVP_remoteControl;};
							};
						};
						//DIAG_CAPTUREFRAME CLIENT
						if (_key isEqualTo 0x3E && _XCX) then {
							if (productVersion select 4 isEqualTo "Profile") then {
								call compile "diag_captureFrame 1;";
								_retorno = true;
							};
						};
						//DIAG_CAPTUREFRAME SERVER
						if (_key isEqualTo 0x3F && _XCX) then {[] remoteExecCall ["BRPVP_captureFrame",2];};
						//HACK A PLAYER
						if (_key isEqualTo 0x02 && _XXA) then {call BRPVP_hackPlayerKeyPress;};
						//LOCK UNLOCK
						if (_key isEqualTo 0x16 && _XXX) then {
							//if (!isNull BRPVP_motorizedToLockUnlock && !(typeOf BRPVP_motorizedToLockUnlock in BRPVP_vantVehiclesClass)) then {
							if (!isNull BRPVP_motorizedToLockUnlock && time-BRPVP_lockUnlockKeyPressTime > 0.25) then {
								BRPVP_lockUnlockKeyPressTime = time;
								_retorno = true;
								if !(18 in BRPVP_actionRunning) then {[0,0,0,BRPVP_motorizedToLockUnlock] execVM "client_code\actions\actionVehicleLockUnlock.sqf";};
							};
						};
						//REPACK AMMO
						if (_key isEqualTo 0x13 && _XXA && !_onVeh) then {
							_retorno = true;
							if (BRPVP_xpRepackAmmoOk) then {
								if !(BRPVP_ammoRepackRunning || BRPVP_reparingVehicle) then {
									BRPVP_ammoRepackRunning = true;
									0 spawn BRPVP_ammoRepackLocalPlayer;
								} else {
									"erro" call BRPVP_playSound;
								};
							};
						};
						//WEAPON ON BACK
						if (_key isEqualTo 0x23 && _SXX) then {
							_retorno = true;
							if (currentWeapon player isNotEqualTo "") then {player action ["SwitchWeapon",player,player,100];};
						};
						//SPECIAL ITEMS
						if (_key isEqualTo 0x17 && _XXA) then {
							_retorno = true;
							35 call BRPVP_iniciaMenuExtra;
						};
						//PLAYER MENU
						if (_key isEqualTo 0x3C && _XXX) then {
							_retorno = true;
							"achou_loot" call BRPVP_playSound;
							BRPVP_suicidouTrava = 5;
							30 call BRPVP_iniciaMenuExtra;
						};
						//VAULT
						if (_key isEqualTo 0x2F && _XXA) then {
							_retorno = true;
							132 call BRPVP_iniciaMenuExtra;
						};
						//SETAS PARA AMIGOS
						if (_key in [0x3B,0x3C,0x3D] && _SXX) then {call BRPVP_colorMarkKeyPress;};
						//INFORMACOES DO OBJETO NA MIRA
						if (_key isEqualTo 0x0F && _XCX) then {
							_retorno = true;
							_obj = cursorObject;
							if (!isNull _obj) then {
								BRPVP_objetoMarcado = _obj;
								_objClass = typeOf _obj;
								_objPos = ASLToAGL getPosASL _obj;
								_objPos = [(round((_objPos select 0)*100))/100,(round((_objPos select 1)*100))/100,(round((_objPos select 2)*100))/100];
								_objVu = vectorUp _obj;
								_objVu = [round((_objVu select 0)*100)/100,round((_objVu select 1)*100)/100,round((_objVu select 2)*100)/100];
								_objDir = (round ((getDir _obj)*100))/100;
								_arg = [];
								if (_obj getVariable ["brpvp_agntsAct",-1] isEqualTo 1) then {_arg = [_obj getVariable "brpvp_agntsArg_ini1",_obj getVariable "brpvp_agntsArg_ini2",_obj getVariable "brpvp_agntsArg_fim"];};
								if (_obj getVariable ["brpvp_agntsAct",-1] isEqualTo 2) then {_arg = [_obj getVariable "brpvp_agntsArg_ini",_obj getVariable "brpvp_agntsArg_dano"];};
								["ctc: "+_objClass+" | "+"ctp: "+str _objPos+" | "+"ctd: "+str _objDir+" | "+"ctv: "+str _objVu+" | "+"cts: "+str _obj+" | ani: "+animationState _obj+"\n"+str ([configfile >> "CfgVehicles" >> _objClass,true] call BIS_fnc_returnParents)+"\nlocal: "+str local _obj+" | simulation: "+str simulationEnabled _obj+" | moveToCompleted: "+str moveToCompleted _obj+" | moveToFailed: "+str moveToFailed _obj+"\nzombie act: "+str (_obj getVariable ["brpvp_agntsAct",-1])+" | zombie target: "+name (_obj getVariable ["brpvp_agntsTarget",objNull])+"\nzombie arg: "+str _arg,-25] call BRPVP_hint;
							} else {
								BRPVP_objetoMarcado = objNull;
							};
						};
						//INFORMACOES DO PLAYER
						if (_key isEqualTo 0x19 && _XCA) then {
							_retorno = true;
							_pos = ASLToAGL getPosASL player;
							_pos = [(round((_pos select 0)*100))/100,(round((_pos select 1)*100))/100,(round((_pos select 2)*100))/100];
							_class = typeOf player;
							_vu = vectorUp player;
							_vu = [round((_vu select 0)*100)/100,round((_vu select 1)*100)/100,round((_vu select 2)*100)/100];
							_dir = (round ((getDir player)*100))/100;
							["plc: "+_class+" | "+"plp: "+str _pos+"\n"+"pld: "+str _dir+" | "+"plv: "+str _vu,10,2,437] call BRPVP_hint;
							diag_log ("[INFO] Position: "+str _pos+" / Direction: "+str _dir);
						};
						//DEBUG
						if (_key isEqualTo 0xD2 && _XXX) then {
							_retorno = true;
							BRPVP_indiceDebug = (BRPVP_indiceDebug+1) mod (count BRPVP_indiceDebugItens);
							call BRPVP_atualizaDebug;
						};
						//EAR PLUGS
						if (_key isEqualTo 0x3B && _XXX) then {
							_retorno = true;
							if (BRPVP_earPlugs) then {
								1 fadeSound 1;
								BRPVP_earPlugs = false;
								[localize "str_ear_off",0] call BRPVP_hint;
								["",0,0,0,0,0,3091] call BRPVP_fnc_dynamicText;
							} else {
								1 fadeSound 0.1;
								BRPVP_earPlugs = true;
								[localize "str_ear_on",0] call BRPVP_hint;
								["<img align='left' size='1' shadow='0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\mute.paa' />",{safeZoneX+safeZoneW-0.07},{safeZoneY+0.17},1000000,0,0,3091] call BRPVP_fnc_dynamicText;
							};
						};
						//MANY ACTIONS INCLUDING OPEN PARACHUTE
						if (_key isEqualTo 0x39 && _XXX && !BRPVP_menuExtraLigado && !isActionMenuVisible && isNull BRPVP_myUAVNow) then {
							//diag_log str ["TEST SPACE KEY",BRPVP_pathClimbOn,BRPVP_uberAttackPlayerSelectPosition,BRPVP_spectateOn,BRPVP_baseBombStage isEqualTo 1,BRPVP_busCanPressStop,[(isNull (player getVariable ["brpvp_rapel_rope",objNull]) && !(player getVariable ["aur_is_rappelling",false]) && !BRPVP_usedHulkPillsRunning),((isNull (objectParent player) || (typeOf (objectParent player) isEqualTo "Steerable_Parachute_F")) && player call BRPVP_pAlive && BRPVP_maxHeightSinceNoGround >= BRPVP_minHeightParachuteOpenUse)]];
							if (BRPVP_pathClimbOn) then {
								_retorno = true;
								if (diag_tickTime-BRPVP_pathClimbBigJumpLast > 1) then {
									BRPVP_pathClimbBigJumpLast = diag_tickTime;
									BRPVP_pathClimbBigJump = true;
								};
							} else {
								if (BRPVP_uberAttackPlayerSelectPosition) then {
									_retorno = true;
									private _agl = screenToWorld [0.5,0.5];
									if (_agl isEqualTo [0,0,0]) then {
										"erro" call BRPVP_playSound;
									} else {
										private _asl = AGLToASL _agl;
										private _lis = lineIntersectsSurfaces [_asl vectorAdd [0,0,350],_asl vectorAdd [0,0,-10]];
										if (_lis isEqualTo []) then {
											"erro" call BRPVP_playSound;
										} else {
											private _op = _lis select 0 select 0;
											private _h = ASLToAGL _op select 2;
											if (_h > 50) then {
												"erro" call BRPVP_playSound;
											} else {
												private _obj = createSimpleObject ["Sign_Arrow_Large_Cyan_F",_op];
												_obj setVariable ["brpvp_del_on_end",true];
												BRPVP_uberAttackPlayerTarget = _obj;
											};
										};
									};
								} else {
									if (BRPVP_spectateOn) then {
										_retorno = true;
										BRPVP_spectateOn = false;
									} else {
										if (BRPVP_baseBombStage isEqualTo 1) then {
											_retorno = true;
											BRPVP_baseBombStage = 2;
										} else {
											if (BRPVP_busCanPressStop) then {
												_retorno = true;
												BRPVP_busCanPressStop = false;
												"bus_stop_signal" call BRPVP_playSound;
											} else {
												if ((BRPVP_flyOnOff || BRPVP_flyOnOffAdmin) || BRPVP_flyA || BRPVP_flyB || BRPVP_flyC || BRPVP_uPackUsing || BRPVP_uberAttackUsing || BRPVP_pathClimbTrying || BRPVP_pathClimbOn) then {
												} else {
													_rope = player getVariable ["brpvp_rapel_rope",objNull];
													if (isNull _rope && !(player getVariable ["aur_is_rappelling",false]) && !BRPVP_usedHulkPillsRunning) then {
														private _veh = objectParent player;
														private _vehIsParachute = typeOf _veh isEqualTo "Steerable_Parachute_F";
														if ((isNull _veh || _vehIsParachute) && player call BRPVP_pAlive && BRPVP_maxHeightSinceNoGround >= BRPVP_minHeightParachuteOpenUse) then {
															_retorno = true;
															if (_vehIsParachute) then {
																if (diag_tickTime-BRPVP_parachuteLastTime > 3) then {
																	BRPVP_parachuteAllLost pushBack _veh;
																	deleteVehicle (BRPVP_parachuteAllLost deleteAt 0);
																	moveOut player;
																	player action ["SwitchWeapon",player,player,100];
																	player playMoveNow "halofreefall_non";
																} else {
																	"erro" call BRPVP_playSound;
																};
															} else {
																//STORE BACKPACK
																private _backpackName = backPack player;
																private _backPackData = [];
																if (_backpackName isNotEqualTo "") then {_backpackData = backPackContainer player call BRPVP_getCargoArray;};
																//ADD PARACHUTE
																removeBackpack player;
																player addBackpack "B_Parachute";
																player action ["OpenParachute",player];
																BRPVP_parachuteLastTime = diag_tickTime;
																//RE-ADD BACKPACK
																if (_backpackName isNotEqualTo "") then {
																	[player,_backpackName,_backPackData] spawn {
																		params ["_player","_backpackName","_backPackData"];
																		waitUntil {backPack _player isEqualTo "" || getPos player select 2 < 0.125};
																		if (backPack _player isEqualTo "B_Parachute") then {removeBackpack player;};
																		_player addBackpack _backpackName;
																		backpackContainer _player call BRPVP_emptyBox;
																		[backpackContainer _player,_backPackData] call BRPVP_putItemsOnCargo;
																	};
																};
															};
														};
													} else {
														if (BRPVP_usedHulkPillsRunning) then {[localize "str_hulkus_release_box",-6] call BRPVP_hint;};
													};
												};
											};
										};
									};
								};
							};
						};
						//BURY MONEY
						if (_key isEqualTo 0x2E && _XXA) then {
							_retorno = true;
							if (surfaceIsWater getPosWorld player || isOnRoad ASLToAGL getPosASL player || BRPVP_menuExtraLigado || BRPVP_possOtherPlayer) then {
								"erro" call BRPVP_playSound;
							} else {
								if (getPosATL player select 2 > 0.05) then {
									"erro" call BRPVP_playSound;
								} else {
									if (!BRPVP_buryMoneyActionOn) then {
										BRPVP_buryMoneyActionOn = true;
										0 spawn {
											player playMoveNow "AmovPercMstpSnonWnonDnon_exercisekneeBendB";
											player playMove "AmovPercMstpSnonWnonDnon_exercisekneeBendB";
											waitUntil {animationState player isEqualTo "amovpercmstpsnonwnondnon_exercisekneebendb"};
											sleep 0.75;
											if ((player call BRPVP_pAlive)) then {
												player say3D ["digging",200];
												waitUntil {!(animationState player isEqualTo "amovpercmstpsnonwnondnon_exercisekneebendb")};
												if ((player call BRPVP_pAlive) && !BRPVP_menuExtraLigado) then {
													107 call BRPVP_iniciaMenuExtra;
												} else {
													"erro" call BRPVP_playSound;
													BRPVP_buryMoneyActionOn = false;
												};
											};
										};
									};
								};
							};
						};
					} else {
						//INCOSCIENT PLAYER AUTO-KILL
						if (_key isEqualTo 0x39 && _XXX) then {
							_retorno = true;
							if (player getVariable ["dd",-1] isEqualTo 0) then {
								player setVariable ["dd",1,true];
							};
						};
						//INCOSCIENT PLAYER AUTO-REVIVE
						if (_key isEqualTo 0x39 && _XXA) then {
							_retorno = true;
							if (BRPVP_trataseDeAdmin) then {
								if (!BRPVP_autoReviveUsing) then {
									BRPVP_autoReviveUsing = true;
									0 spawn {
										if (player getVariable ["dd",-1] isEqualTo 0) then {player setVariable ["dd",2,true];};
										private _init = diag_tickTime;
										waitUntil {player getVariable ["dd",-1] isEqualTo -1};
										waitUntil {diag_tickTime-_init > 10 || time-BRPVP_newerLastShot < 0.25 || !(player call BRPVP_pAlive)};
										if (player call BRPVP_pAlive) then {if (!BRPVP_playerIsCaptive && captive player && !BRPVP_safeZone) then {player setCaptive false;};};
										BRPVP_autoReviveUsing = false;
									};
								};
							} else {
								if (player getVariable ["dd",-1] isEqualTo 0) then {
									if ("BRPVP_selfRevive" call BRPVP_sitCountItem > 0 && !BRPVP_autoReviveUsing) then {
										BRPVP_autoReviveUsing = true;
										0 spawn {
											"self_revive" call BRPVP_playSound;
											private _sounder = "Land_HelipadEmpty_F" createVehicle BRPVP_posicaoFora;
											_sounder attachTo [player,[0,0,0]];
											[_sounder,["revive_protection",250]] remoteExecCall ["say3D",BRPVP_specOnMeMachines];
											["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\revive_protection.paa'/>"    ,0,0.25,15,2 ,0,983746,true] call BRPVP_fnc_dynamicText;
											["<img shadow='0' size='3' image='"+BRPVP_imagePrefix+"BRP_imagens\revive_protection_end.paa'/>",0,0.25,15,15,0,993746,true] call BRPVP_fnc_dynamicText;
											uiSleep 2;
											if (player getVariable ["dd",-1] isEqualTo 0) then {
												[player,["revive_thunder",750]] remoteExecCall ["say3D",BRPVP_allNoServer];
												player setVariable ["dd",2,true];
												cutText ["","WHITE IN",1];
												["BRPVP_selfRevive",1] call BRPVP_sitRemoveItem;
												private _init = diag_tickTime;
												waitUntil {player getVariable ["dd",-1] isEqualTo -1};
												waitUntil {diag_tickTime-_init > 13 || time-BRPVP_newerLastShot < 0.25 || !(player call BRPVP_pAlive)};
												["",0,0.25,0,0,0,983746,true] call BRPVP_fnc_dynamicText;
												["",0,0.25,0,0,0,993746,true] call BRPVP_fnc_dynamicText;
												detach _sounder;
												deleteVehicle _sounder;
												if (player call BRPVP_pAlive) then {if (!BRPVP_playerIsCaptive && captive player && !BRPVP_safeZone) then {player setCaptive false;};};
											} else {
												"erro" call BRPVP_playSound;
											};
											BRPVP_autoReviveUsing = false;
										};
									} else {
										"erro" call BRPVP_playSound;
									};
								};
							};
						};
					};
				} else {
					if (_key in actionKeys "gear" && _XXX) then {_retorno = true;};
				};
			};
		};
	};
	if (inputAction "tacticalView" isEqualTo 1) then {_retorno = true;};
	BRPVP_mainKeyDownTimes pushBack ((round(((diag_tickTime-_ttInit)*1000)*100))/100);
	BRPVP_mainKeyDownTimes deleteAt 0;
	_retorno
};
BRPVP_adminKeyDown = {
	params ["_controle","_key","_keyShift","_keyCtrl","_keyAlt"];
	private _retorno = false;
	if (BRPVP_usingElevator) exitWith {_retorno = true;};
	if (player call BRPVP_pAlive) then {
		private _XXX = !_keyShift && !_keyCtrl && !_keyAlt;
		//ADMIN MENU
		if (_key isEqualTo 0x3D && _XXX && !BRPVP_menuExtraLigado) then {
			_retorno = true;
			29 call BRPVP_iniciaMenuExtra;
		};
		//DELETE ITEMS ON GROUND
		if (_key isEqualTo 0xD3 && _XXX && !BRPVP_construindo) then {
			_retorno = true;
			_curObj = cursorObject;
			if (typeOf _curObj in ["GroundWeaponHolder","WeaponHolderSimulated"] && {_curObj getVariable ["ml_takes",-1] isEqualTo -1}) then {deleteVehicle _curObj;};
		};
		//ADMIN FLY		
		if !(BRPVP_flyOnOff || BRPVP_flyOnOffAdmin) then {
			if (player getVariable ["sok",false] && isNull objectParent player) then {
				//FLY ON VIEW DIRECTION
				if (_key isEqualTo 0x06 && _XXX) then {
					_retorno = true;
					if (!BRPVP_flyA) then {
						if (!BRPVP_flyB) then {BRPVP_flyRecord = getPosASL player;};
						BRPVP_flyA = true;
					};
				};
				//GO UP
				if (_key isEqualTo 0x05 && _XXX) then {
					_retorno = true;
					if (!BRPVP_flyB) then {
						if (!BRPVP_flyA) then {BRPVP_flyRecord = getPosASL player;};
						BRPVP_flyB = true;
					};
				};
				//FREEZE PLAYER
				if (_key isEqualTo 0x07 && _XXX) then {
					_retorno = true;
					BRPVP_flyC = !BRPVP_flyC;
					if (!BRPVP_flyA && !BRPVP_flyB) then {if (BRPVP_flyC) then {BRPVP_flyRecord = getPosASL player;} else {player setVelocity [0,0,1];};};
				};
				//LIMIT TO 100M
				if (_key isEqualTo 0x08 && _XXX) then {
					_retorno = true;
					if (BRPVP_flyD) then {
						BRPVP_flyD = false;
						["Fly *not* limited to 100 meters!",-4] call BRPVP_hint;
					} else {
						if ((ASLToAGL getPosASL player) select 2 <= 98
						) then {
							BRPVP_flyD = true;
							["Fly limited to 100 meters!",-4] call BRPVP_hint;
						} else {
							["You are above 100m and can't turn this option on!",-4] call BRPVP_hint;
						};
					};
				};
			};
		};
	};
	_retorno
};

[] spawn {
	waitUntil {!isNull findDisplay 46};

	//KEY DOWN AND UP
	(findDisplay 46) displayAddEventHandler ["keyDown",{
		private _key = _this select 1;
		(BRPVP_keyBlocked && !(_key in BRPVP_notBlockedKeys)) || {call BRPVP_mainKeyDown}
	}];
	(findDisplay 46) displayAddEventHandler ["keyUp",{call BRPVP_secKeyUp}];
	BRPVP_secKeyUp = {
		params ["_controle","_key","_keyShift","_keyCtrl","_keyAlt"];
		private _XXX = !_keyShift && !_keyCtrl && !_keyAlt;
		private _SXX = _keyShift && !_keyCtrl && !_keyAlt;
		if (BRPVP_flyOnOff || BRPVP_flyOnOffAdmin) then {
			if (!_SXX || _key in [42,54]) then {BRPVP_flyAcell = false;};
			if (_key isEqualTo 0x11) then {BRPVP_flyA1 = false;};
			if (_key isEqualTo 0x1F) then {BRPVP_flyA2 = false;};
			if (_key isEqualTo 0x03) then {BRPVP_flyB1 = false;};
			if (_key isEqualTo 0x04) then {BRPVP_flyB2 = false;};
			if (_key isEqualTo 0x20) then {BRPVP_flyC1 = false;};
			if (_key isEqualTo 0x1E) then {BRPVP_flyC2 = false;};
		} else {
			if (BRPVP_isAdminOrModerator) then {
				if (_key isEqualTo 0x06 && _XXX) then {
					BRPVP_flyA = false;
					if (!BRPVP_flyB && !BRPVP_flyC) then {player setVelocity [0,0,1];};
				};
				if (_key isEqualTo 0x05 && _XXX) then {
					BRPVP_flyB = false;
					if (!BRPVP_flyA && !BRPVP_flyC) then {player setVelocity [0,0,1];};
				};
			};
		};
		if (_key isEqualTo 0x38) then {BRPVP_accessAllNear = -10;};
		if (_key isEqualTo 0x11) then {BRPVP_nitroFlyWPressed = false;};
		BRPVP_paraParam = [0,0];
		BRPVP_keyBlocked
	};

	//MOUSE DOWN
	(findDisplay 46) displayAddEventHandler ["MouseButtonDown",{
		private _isHorn = inputAction "defaultAction" > 0 && (currentPilot objectParent player isEqualTo player) && !visibleMap && isNull findDisplay 602 && objectParent player isKindOf "LandVehicle";
		if (_isHorn) then {
			if (time-BRPVP_remoteControlTime > 1) then {
				BRPVP_remoteControlTime = time;
				if (43 call BRPVP_sitCountItem > 0) then {true call BRPVP_remoteControl;};
			};
		} else {
			call BRPVP_pushPerson;
		};
	}];

	//STATUS BAR
	(findDisplay 46) ctrlCreate ["RscStructuredText",BRPVP_barControlId];
	(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetPosition [safeZoneX,safeZoneY+safeZoneH-0.19,safeZoneW,0.19];
	(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlSetBackgroundColor [1,1,1,0];
	(findDisplay 46 displayCtrl BRPVP_barControlId) ctrlCommit 0;
};

diag_log ("[SCRIPT] playerCustomKeys.sqf END: "+str round (diag_tickTime-_scriptStart));