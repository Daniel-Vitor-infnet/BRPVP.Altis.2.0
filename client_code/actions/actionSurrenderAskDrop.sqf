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

BRPVP_actionRunning pushBack 12;
if (!isNull BRPVP_surrended) then {
	_msg = ["<img shadow='0' size='6' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\drop_items.paa'/>",0,0,3,0,0,7757];
	_msg remoteExecCall ["BRPVP_fnc_dynamicText",BRPVP_surrended];
	sleep 0.5;
	playSound3D [BRPVP_playSound3dPrefix+"BRP_sons\time_is_up.ogg",player,false,getPosASL player,1,1,200];
	sleep 2.5;
};
BRPVP_actionRunning = BRPVP_actionRunning-[12];