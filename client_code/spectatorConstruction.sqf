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
diag_log "[SCRIPT] spectatorConstruction.sqf BEGIN";

BRPVP_specConstruindoItemObj = objNull;
BRPVP_specSetMainVars00 = {
	params ["_data","_construindoAngRotacaoSet","_construindoDirPlyObj","_pegaArray","_h"];
	_data params ["_class","_posW","_vd","_vu"];
	private _newObj = createSimpleObject [_class,[0,0,0],true];
	_newObj setVectorDirAndUp [_vd,_vu];
	_newObj setPosWorld _posW;
	_newObj setVariable ["brpvp_construction_helper",true];
	deleteVehicle BRPVP_specConstruindoItemObj;
	BRPVP_specConstruindoAngRotacaoSet = _construindoAngRotacaoSet;
	BRPVP_specConstruindoDirPlyObj = _construindoDirPlyObj;
	_pegaArray call BRPVP_specSetMainVars01;
	BRPVP_specConstruindoHIntSet = BRPVP_specConstruindoHIntSet+_h;
	BRPVP_specConstruindoItemObj = _newObj;
	{
		_x params ["_classes","_texture","_q"];
		if (typeOf _newObj in _classes) exitWith {
			for "_i" from 0 to _q do {_newObj setObjectMaterial [_forEachIndex,"\a3\data_f\default.rvmat"];};
			for "_i" from 0 to _q do {_newObj setObjectTexture [_forEachIndex,BRPVP_imagePrefix+_texture];};
		};
	} forEach BRPVP_extraTextures;
};
BRPVP_specSetMainVars01 = {
	params ["_type","_data"];
	if (_type isEqualTo 0) then {
		BRPVP_specConstruindoPega set [0,_data];
	} else {
		if (_type isEqualTo 1) then {
			BRPVP_specConstruindoPega set [1,_data];
		} else {
			if (_type isEqualTo 2) then {BRPVP_specConstruindoPega = _data;};
		};
	};
};
BRPVP_specSetMainVars02 = {BRPVP_specBuildingObjCopyDir = _this;};
BRPVP_specSetMainVars03 = {BRPVP_specBuildingObjCopyH = _this;};
BRPVP_specSetMainVars04 = {BRPVP_specConstruindoHIntSet = BRPVP_specConstruindoHIntSet+_this;};
BRPVP_specSetMainVars05 = {BRPVP_specBuildingObjCopyDirExtra = _this;};
BRPVP_specSetMainVars06 = {
	params ["_construindoPega","_construindoHIntSet","_construindoDirPlyObj","_radialPlacementOn"];
	BRPVP_specConstruindoPega = _construindoPega;
	BRPVP_specConstruindoHIntSet = _construindoHIntSet;
	BRPVP_specConstruindoDirPlyObj = _construindoDirPlyObj;
	BRPVP_specRadialPlacementOn = _radialPlacementOn;
};
BRPVP_specSetMainVars07 = {BRPVP_specRadialPlacementDirOn = _this;};
BRPVP_specSetMainVars08 = {BRPVP_specConstruindoAngRotacaoSet = (BRPVP_specConstruindoAngRotacaoSet+_this+360) mod 360;};
BRPVP_specSetMainVars09 = {
	params ["_pp","_bring"];
	BRPVP_specConstruindoItemObj setPosASL (_pp vectorAdd _bring);
};
BRPVP_specSetMainVars10 = {
	params ["_construindoPega","_construindoHIntSet","_construindoDirPlyObj"];
	BRPVP_specConstruindoPega = _construindoPega;
	BRPVP_specConstruindoHIntSet = _construindoHIntSet;
	BRPVP_specConstruindoDirPlyObj = _construindoDirPlyObj;
};
BRPVP_specSetMainVars11 = {
	BRPVP_specConstruindoPega = [-1];
	BRPVP_specConstruindoHIntSet = 0;
};
BRPVP_specSetMainVars12 = {
	BRPVP_specRadialPlacementOn = _this;
};
BRPVP_specSetMainVars13 = {
	params ["_class","_posW","_vd","_vu"];
	private _newObj = createSimpleObject [_class,[0,0,0],true];
	_newObj setVectorDirAndUp [_vd,_vu];
	_newObj setPosWorld _posW;
	BRPVP_specConstruindoItemObj = _newObj;
	{
		_x params ["_classes","_texture","_q"];
		if (typeOf _newObj in _classes) exitWith {
			for "_i" from 0 to _q do {_newObj setObjectMaterial [_forEachIndex,"\a3\data_f\default.rvmat"];};
			for "_i" from 0 to _q do {_newObj setObjectTexture [_forEachIndex,BRPVP_imagePrefix+_texture];};
		};
	} forEach BRPVP_extraTextures;
};
BRPVP_specConstructionCode = {
	params ["_pSpec","_flagHolder","_flagHolderRad","_data",["_oData",[]]];
	if (_oData isNotEqualTo []) then {_oData call BRPVP_specSetMainVars13;};
	BRPVP_specConstruindoPega = _data select 0;
	BRPVP_specBuildingObjCopyDir = _data select 1;
	BRPVP_specConstruindoDirPlyObj = _data select 2;
	BRPVP_specConstruindoAngRotacaoSet = _data select 3;
	BRPVP_specBuildingObjCopyH = _data select 4;
	BRPVP_specConstruindoHIntSet = _data select 5;
	BRPVP_specBuildingObjCopyDirExtra = _data select 6;
	BRPVP_specRadialPlacementOn = _data select 7;
	BRPVP_specRadialPlacementDirOn = _data select 8;
	waitUntil {
		if (!isNull BRPVP_specConstruindoItemObj) then {
			if (BRPVP_specConstruindoPega select 0 >= 0) then {
				private _dist = BRPVP_specConstruindoPega select 0;
				private _refP = BRPVP_specConstruindoPega select 1;
				private _dP = if (BRPVP_specBuildingObjCopyDir isEqualTo -1) then {getDirVisual _pSpec} else {_refP};
				private _refDeltaP = _dP-_refP;
				private _cP = getPosWorldVisual _pSpec;
				BRPVP_specConstruindoPega set [1,_dP];
				BRPVP_specConstruindoDirPlyObj = BRPVP_specConstruindoDirPlyObj+_refDeltaP;
				BRPVP_specConstruindoAngRotacaoSet = BRPVP_specConstruindoAngRotacaoSet+_refDeltaP;
				if (BRPVP_specBuildingObjCopyH isNotEqualTo []) then {BRPVP_specConstruindoHIntSet = (BRPVP_specBuildingObjCopyH select 2)-(_cP select 2);};
				_cP = _cP vectorAdd [_dist*sin BRPVP_specConstruindoDirPlyObj,_dist*cos BRPVP_specConstruindoDirPlyObj,BRPVP_specConstruindoHIntSet];
				BRPVP_specConstruindoItemObj setPosWorld _cP;
				if (BRPVP_specBuildingObjCopyDir isEqualTo -1) then {BRPVP_specConstruindoItemObj setDir BRPVP_specConstruindoAngRotacaoSet;} else {BRPVP_specConstruindoItemObj setDir (BRPVP_specBuildingObjCopyDir+BRPVP_specBuildingObjCopyDirExtra);};
			} else {
				if (BRPVP_specConstruindoHIntSet != 0) then {
					BRPVP_specConstruindoItemObj setPosWorld ((getPosWorld BRPVP_specConstruindoItemObj) vectorAdd [0,0,BRPVP_specConstruindoHIntSet]);
					BRPVP_specConstruindoHIntSet = 0;
				} else {
					if (BRPVP_specBuildingObjCopyH isNotEqualTo []) then {
						private _selfPos = getPosWorld BRPVP_specConstruindoItemObj;
						_selfPos set [2,BRPVP_specBuildingObjCopyH select 2];
						BRPVP_specConstruindoItemObj setPosWorld _selfPos;
					};
				};
				if (BRPVP_specBuildingObjCopyDir isEqualTo -1) then {BRPVP_specConstruindoItemObj setDir BRPVP_specConstruindoAngRotacaoSet;} else {BRPVP_specConstruindoItemObj setDir (BRPVP_specBuildingObjCopyDir+BRPVP_specBuildingObjCopyDirExtra);};
			};
			if (!isNull _flagHolder) then {
				if (BRPVP_specRadialPlacementOn) then {
					BRPVP_specConstruindoItemObj call BRPVP_objCrossLine;
					private _dir = [_flagHolder,BRPVP_specConstruindoItemObj] call BIS_fnc_dirTo;
					private _fp = getPosASL _flagHolder;
					private _op = [(_fp select 0)+_flagHolderRad*0.9*sin _dir,(_fp select 1)+_flagHolderRad*0.9*cos _dir,0];
					private _h = getPosASL BRPVP_specConstruindoItemObj select 2;
					_op set [2,_h];
					BRPVP_specConstruindoItemObj setPosASL _op;
					private _opw = getPosASL BRPVP_specConstruindoItemObj;
					{drawLine3D [ASLToAGL _fp vectorAdd _x,ASLToAGL _opw vectorAdd _x,[1,0,0,1]];} forEach [[0,0,0],[0,0,0.5],[0,0,1],[0,0,1.5],[0,0,2],[0,0,2.5],[0,0,3]];
				};
				if (BRPVP_specRadialPlacementDirOn) then {
					private _dir = [_flagHolder,BRPVP_specConstruindoItemObj] call BIS_fnc_dirTo;
					BRPVP_specConstruindoAngRotacaoSet = _dir;
				};
			};
		};
		!(_pSpec getVariable ["bdg",true]) || !(_pSpec call BRPVP_pAlive) || isNull _pSpec || !BRPVP_spectateOn
	};
	deleteVehicle BRPVP_specConstruindoItemObj;
};

diag_log ("[SCRIPT] spectatorConstruction.sqf END: " + str round (diag_tickTime - _scriptStart));