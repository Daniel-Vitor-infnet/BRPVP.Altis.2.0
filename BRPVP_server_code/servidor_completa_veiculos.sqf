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
diag_log "[SCRIPT] servidor_completa_veiculos.sqf BEGIN";

//PEGA CONFIGURACOES DO MAPA
_quantiaCarrosParaNascer = BRPVP_mapaRodando select 4;
_contaTudo = 0;

//VEHICLES
_veiculosC = [
	"C_Quadbike_01_F",
	"C_Quadbike_01_F",
	"C_Quadbike_01_F",
	"C_Quadbike_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_F",
	"C_Hatchback_01_F",
	"C_SUV_01_F",
	"C_SUV_01_F",
	"C_SUV_01_F",
	"C_SUV_01_F",
	//CUP
	"CUP_O_Volha_SLA",
	"CUP_B_M1030_USA",
	"CUP_O_TT650_CHDKZ",
	"CUP_B_Tractor_CDF",
	"CUP_O_Tractor_Old_CHDKZ",
	"CUP_I_Hilux_armored_unarmed_NAPA",
	"CUP_B_TowingTractor_CZ",
	"CUP_B_S1203_Ambulance_CDF",
	"CUP_B_HMMWV_Unarmed_USMC",
	"CUP_B_UAZ_Unarmed_ACR",
	"CUP_B_UAZ_Open_ACR",
	"CUP_B_LR_Transport_CZ_D",

	"O_LSV_02_unarmed_F",
	"O_LSV_02_unarmed_F",
	//CUP
	"CUP_O_M113_TKA","M113",
	"CUP_I_SUV_Armored_ION",

	"O_G_Van_02_transport_F",
	"O_G_Van_02_transport_F",
	"C_Van_01_fuel_F",
	"C_Van_01_fuel_F",
	"C_Offroad_01_repair_F",
	"C_Offroad_01_repair_F",

	"B_MRAP_01_F",
	"O_MRAP_02_F",
	"I_MRAP_03_F",

	"B_MRAP_01_hmg_F",
    "O_MRAP_02_hmg_F",
    "I_MRAP_03_hmg_F",
	//CUP
	"CUP_B_HMMWV_M2_GPK_ACR",
	"CUP_B_HMMWV_DSHKM_GPK_ACR",
	"CUP_B_HMMWV_AGS_GPK_ACR",

	"I_G_Offroad_01_armed_F",
	"I_G_Offroad_01_armed_F",
	//CUP
	"CUP_B_Hilux_armored_SPG9_BLU_G_F",
	"CUP_B_Hilux_armored_SPG9_BLU_G_F"
];
_veiculosH = [
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_Light_01_civil_F",
	"C_Heli_light_01_stripped_F",
	"C_Heli_light_01_stripped_F",
	"I_Heli_light_03_unarmed_F",
	"O_Heli_Light_02_unarmed_F",
	"B_Heli_Transport_03_unarmed_F",
	"B_Heli_Transport_03_unarmed_green_F",
	//CUP
	"CUP_I_SA330_Puma_HC2_RACS",
	"CUP_I_SA330_Puma_HC2_RACS",
	"CUP_I_SA330_Puma_HC2_RACS",
	"CUP_I_SA330_Puma_HC2_RACS",
	"CUP_I_SA330_Puma_HC2_RACS",
	"CUP_B_CH53E_USMC",
	"CUP_B_CH53E_USMC",
	"CUP_B_CH53E_USMC",
	"CUP_B_CH53E_USMC",
	"CUP_B_CH53E_USMC",
	"CUP_B_UH60S_USN",
	"CUP_B_UH60S_USN",
	"CUP_B_UH60S_USN",
	"CUP_B_UH60S_USN",
	"CUP_B_UH60S_USN"
];

//REMOVE NOT AVALIABLE CLASSES
_veiculosC = (_veiculosC apply {if (_x call BRPVP_classExists) then {_x} else {-1};})-[-1];
_veiculosH = (_veiculosH apply {if (_x call BRPVP_classExists) then {_x} else {-1};})-[-1];

//COMPLETA A QUANTIA DE CARROS
if (_quantiaCarrosParaNascer > 0) then {
	for "_i" from 1 to _quantiaCarrosParaNascer do {
		private ["_vId"];
		
		//ESCOLHE RUA DE SPAWN
		_ruaDaVez = [BRPVP_ruas,[],[],150,-1,2] call BRPVP_achaCentroPrincipal;

		//SORTEIA CARRO
		_qual = selectRandom _veiculosC;
		_so = sizeOf _qual;
		
		//ACHA POSICAO DO CARRO
		_dir = ((getDir _ruaDaVez) + 90) - 10 + (random 20) + ((round random 1)* 180);
		_posRua = getPos _ruaDaVez;
		_pos = [_posRua,_posRua,3,5,20,30,4,4,_so/2,true,3,15,["Building","Air","LandVehicle"],["a3\plants_f\Tree\","a3\rocks_f\"],0,false] call BRPVP_achaLocal;
		_pos set [2,0];
		
		//CRIA CARRO
		_veiculo = createVehicle [_qual,BRPVP_spawnVehicleFirstPos,[],100,"NONE"];
		_veiculo call BRPVP_setVehServicesToZero;

		//SET CUSTOM CARGO SIZE
		{
			_x params ["_class","_name","_cargo"];
			if (_class isEqualTo _qual) exitWith {_veiculo setMaxLoad _cargo;};
		} forEach BRPVP_customCargoVehiclesCfg;

		//VEH RADAR AND THERMAL
		_veiculo call BRPVP_setVehRadarAndThermal;

		//SET POS
		_veiculo setPosASL AGLToASL _pos;
		_veiculo setDir _dir;
		_veiculo setVectorUp surfaceNormal position _veiculo;
		_contaTudo = _contaTudo + 1;
		
		//ESVAZIA VEICULO
		clearWeaponCargoGlobal _veiculo;
		clearMagazineCargoGlobal _veiculo;
		clearItemCargoGlobal _veiculo;
		clearBackpackCargoGlobal _veiculo;
		
		//REMOVE TURRET ON WHEELED APCS
		if ((typeOf _veiculo) in BRPVP_classRemoveTurret) then {_veiculo animate ["HideTurret",1];};

		//COLOCA EH NO CARRO E BOTA ELE NO ARRAY DE CARROS
		_veiculo setVariable ["brpvp_fedidex",true,true];
		_veiculo call BRPVP_veiculoEhReset;

		BRPVP_sendToHC pushBack _veiculo;
	};
};

//VARIAVEIS DO MAPA PARA SPAWN DE HELI
_quantiaHelisParaNascer = BRPVP_mapaRodando select 5 select 0;
_consHeliQttMeta = BRPVP_mapaRodando select 5 select 2;
_totalHelis = _quantiaHelisParaNascer + _consHeliQttMeta;

//COMPLETA A QUANTIA DE HELICOPTEROS
if (_totalHelis > 0) then {
	private ["_hId"];

	//ACHA HANGARES OU CONSTRUCOES PARA HELI
	_consHeliObjs = [];
	_consHeli = BRPVP_mapaRodando select 5 select 1;
	{
		_obj = _x;
		if ({_x distanceSqr _obj < 250000} count _consHeliObjs isEqualTo 0) then {_consHeliObjs pushBack _obj;};
	} forEach (nearestObjects [BRPVP_centroMapa,_consHeli,20000] call BIS_fnc_arrayShuffle);

	//VARIAVEIS INICIAIS
	_pos = [0,0,0];
	_dir = 0;

	//SPAWNA HELIS
	_idx = 0;
	for "_i" from 1 to _totalHelis do {
		//SORTEIA HELI
		_qual = selectRandom _veiculosH;
		_so = sizeOf _qual;

		//PEGA POSICAO PERTO DA CONSTRUCAO DE HELIS (NORMALMENTE HANGARES)
		_pos = [0,0,0];
		_ocorrido = "nada";
		if (_consHeliQttMeta > 0) then {
			_consHeliQttMeta = _consHeliQttMeta - 1;
			if (count _consHeliObjs > 0) then {
				_centro = getPosATL (_consHeliObjs select (_idx mod count _consHeliObjs));
				_idx = _idx + 1;
				_pos = [_centro,[0,0,0],35,15,135,200,10,10,_so/2,true,999,12,["Building","Air","LandVehicle"],["a3\plants_f\Tree\","a3\rocks_f\"],0,false] call BRPVP_achaLocal;
				_dir = random 360;
				if (str _pos isEqualTo "[0,0,0]") then {
					_ocorrido = "fail";
					diag_log "[BRPVP ALERT] NOT ABLE TO SPAWN HELI ON AIRPORT!";
				} else {
					_pos set [2,0];
					_ocorrido = "spawn_aero";
				};
			} else {
				_ocorrido = "fail";
			};
		};
		
		//ACHA POSICAO MODELO PADRAO
		if (_ocorrido isEqualTo "nada") then {
			_ocorrido = "spawn_normal";
			
			//ESCOLHE RUA DE SPAWN
			_ruaDaVez = [BRPVP_ruas,[],[],150,-1,5] call BRPVP_achaCentroPrincipal;
			
			//ACHA POSICAO DO HELI
			_dir = (getDir _ruaDaVez + 90) - 10 + (random 20) + ((round random 1)* 180);
			_posRua = getPos _ruaDaVez;
			_pos = [_posRua,_posRua,15,50,150,150,10,10,_so/2,false,999,12,["Building","Air","LandVehicle"],["a3\plants_f\Tree\","a3\rocks_f\"],0,false] call BRPVP_achaLocal;
			_pos set [2,0];
		};
		
		//CRIA HELI E SALVA NO BD
		if (_ocorrido != "fail") then {
			//CRIA HELI
			_heli = createVehicle [_qual,BRPVP_spawnVehicleFirstPos,[],100,"NONE"];
			_heli call BRPVP_setVehServicesToZero;

			//SET CUSTOM CARGO SIZE
			{
				_x params ["_class","_name","_cargo"];
				if (_class isEqualTo _qual) exitWith {_heli setMaxLoad _cargo;};
			} forEach BRPVP_customCargoVehiclesCfg;

			//VEH RADAR AND THERMAL
			_heli call BRPVP_setVehRadarAndThermal;

			//SET POS
			_heli setPosASL AGLToASL _pos;
			_heli setDir _dir;
			_heli setVectorUp surfaceNormal position _heli;
			_contaTudo = _contaTudo + 1;
			
			//ESVAZIA VEICULO
			clearWeaponCargoGlobal _heli;
			clearMagazineCargoGlobal _heli;
			clearItemCargoGlobal _heli;
			clearBackpackCargoGlobal _heli;

			//CRIA EH DO HELI E BOTA ELE NO ARRAY DE HELIS
			_heli setVariable ["brpvp_fedidex",true,true];
			_heli call BRPVP_veiculoEhReset;

			BRPVP_sendToHC pushBack _heli;
		};
	};
};

diag_log ("[SCRIPT] servidor_completa_veiculos.sqf END: " + str round (diag_tickTime - _scriptStart));