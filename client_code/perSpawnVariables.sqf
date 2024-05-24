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

diag_log "[BRPVP FILE] perSpawnVariables.sqf INITIATED";

BRPVP_represedHungryCycles = 0;
BRPVP_energeticEndTime = 0;
BRPVP_paraParam = [0,0];
BRPVP_vodkaTimeMark = 0;
BRPVP_radarConfigPool = [[0,0,5,[0,0,0]]];
BRPVP_walkDisabled = false;
BRPVP_spectingUnit = objNull;
BRPVP_playerBuilding = objNull;
BRPVP_zombieFactor = 0;
BRPVP_zombieFactorPercentage = 0;
BRPVP_countSecs = 0;
BRPVP_keyBlocked = true;
BRPVP_lastOfensor = objNull;
BRPVP_espectando = false;
BRPVP_earPlugs = false;
BRPVP_shotTime = -1;
BRPVP_safeZone = false;
BRPVP_compraPrecoTotal = 0;
BRPVP_compraItensTotal = [];
BRPVP_compraItensPrecos = [];
BRPVP_mensagemDeKillArray = [0,"?","?",0,objNull];
BRPVP_suicidou = false;
BRPVP_menuExtraLigado = false;
BRPVP_alimentacao = 100;
BRPVP_meuAllDead = [];
BRPVP_dentroDe = [];
BRPVP_indiceDebug = 0;
BRPVP_meusAmigosObj = [];
BRPVP_meusAmigosObjAll = [];
BRPVP_hintHistorico = [];
BRPVP_ultimoDebugDoHint = "";
BRPVP_construindo = false;

diag_log "[BRPVP FILE] perSpawnVariables.sqf END REACHED";