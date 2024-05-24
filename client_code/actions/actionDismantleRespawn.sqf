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

_money = player getVariable "mny";
if (BRPVP_raidServerIsRaidDay) then {
	if (_money >= BRPVP_dismantleRespawnPrice) then {
		_obj = _this select 3;
		player setVariable ["mny",_money-BRPVP_dismantleRespawnPrice,true];
		"negocio" call BRPVP_playSound;
		_class = typeOf _obj;
		_id = _obj getVariable ["id_bd",-1];
		if (netId _obj isEqualTo "0:0") then {
			if (_class in BRPVP_buildingHaveDoorListCVL) then {
				[_class,_id] remoteExecCall ["BRPVP_removeObjectSimpleObjectCVL",0];
			} else {
				[_class,_id] remoteExecCall ["BRPVP_removeObjectSimpleObject",0];
			};
		} else {
			[_obj,true] call BRPVP_removeObject;
		};
		waitUntil {isNull _obj};
	} else {
		"erro" call BRPVP_playSound;
		[localize "str_no_money",0] call BRPVP_hint;
	};
} else {
	"erro" call BRPVP_playSound;
	[localize "str_not_raid_day",-6] call BRPVP_hint;
};