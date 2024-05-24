RZ_fnc_zombie_canAttackVehicle = {
	params ["_zombie","_vehicle","_vehType"];
	if(!alive _zombie) exitWith { false };
	//_maxAttackDistance = [_zombie,_vehType] call RZ_fnc_zombie_maxAttackDistanceToVehicle;
	//(_zombie distance _vehicle) < _maxAttackDistance

	//BRPVP CODE INIT
	private _pZ = eyePos _zombie;
	private _vec = vectorNormalized (getPosWorld _vehicle vectorDiff _pZ) vectorMultiply 2.5;
	private _lis = lineIntersectsSurfaces [_pZ,_pZ vectorAdd _vec,_zombie];
	private _canAttack = !(_lis isEqualTo []) && {_lis select 0 select 2 isEqualTo _vehicle};
	if (!_canAttack && !(_zombie checkAIFeature "MOVE")) then {_zombie enableAi "MOVE";};
	_canAttack	
	//BRPVP CODE END
};	
