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
diag_log "[SCRIPT] constructionFunctionsAndVars.sqf BEGIN";

BRPVP_iBelieveICanFlyObjects = [
	//BIG
	"Land_nav_pier_m_F",
	"Land_Pier_F",
	"Land_BC_Court_F",
	//BLOCK VR
	"Land_VR_Block_01_F",
	"Land_VR_Block_02_F",
	"Land_VR_Block_03_F",
	"Land_VR_Block_04_F",
	"Land_VR_Block_05_F",
	//CONCRETE BLOCK
	"BlockConcrete_F",
	//EXTRA OBJECTS
	"Land_VR_Slope_01_F"
];
BRPVP_groundLikeObjects = [
	//BIG
	"Land_nav_pier_m_F",
	"Land_Pier_F",
	"Land_BC_Court_F",
	//BLOCK VR
	"Land_VR_Block_01_F",
	"Land_VR_Block_02_F",
	"Land_VR_Block_03_F",
	"Land_VR_Block_04_F",
	"Land_VR_Block_05_F",
	//CONCRETE BLOCK
	"BlockConcrete_F",
	//SAND OBJECTS
	"Land_BagFence_Long_F",
	"Land_BagFence_Short_F",
	"Land_HBarrier_1_F",
	"Land_HBarrier_3_F",
	"Land_HBarrier_5_F",	
	//WALL AND GATES
	"Land_CncWall1_F",
	"Land_CncWall4_F",
	"Land_ConcreteWall_01_l_gate_F",
	"Land_ConcreteWall_01_m_gate_F",
	"Land_Castle_01_church_a_ruin_F",
	"Land_Stone_4m_F",
	"Land_Stone_8m_F",
	"Land_City2_4m_F",
	"Land_City2_8m_F"
];
BRPVP_groundLikeObjectsBbZFix = [
	//BIG
	[[+2.20,+0.30,+0.00],[-2.10,-0.30,-0.20]],
	[[+0.50,+0.50,+0.00],[-0.50,-4.85,-0.70]],
	[[+0.50,+0.50,+0.00],[-0.50,-0.50,-0.00]],
	//BLOCK VR
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	//CONCRETE BLOCK
	[[+0.60,+0.60,+0.00],[-1.10,-1.10,-0.00]],
	//SAND OBJECTS
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	//WALL AND GATES
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.00],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.20],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.20],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.20],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.20],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.20],[+0.50,+0.50,+0.20]],
	[[-0.50,-0.50,-0.20],[+0.50,+0.50,+0.20]]
];

//TYPE GROUPS
BRPVP_kitGroupsGates = BRP_kitGates;
BRPVP_kitGroupsHouses = BRP_kitTorres+BRP_kitSmallHouse+BRP_kitAverageHouse+BRP_kitBigHouse+BRP_kitGiantHouse+BRP_kitCasebres;
BRPVP_kitGroupsStuff = BRP_kitLight+BRP_kitCamuflagem+BRP_kitAreia+BRP_kitCidade+BRP_kitStone+BRP_kitConcreto+BRP_kitPedras+BRP_kitTableChair+BRP_kitBeach+BRP_kitReligious+BRP_kitStuffo1+BRP_kitStuffo2+BRP_kitLamp+BRP_kitContainers+BRP_kitRecreation+BRP_kitMilitarSign+BRP_kitWrecks+BRP_kitAntennaA+BRP_kitAntennaB+BRP_kitMovement+BRP_kitHelipad+BRP_kitTrees+BRP_kitBunkers;

//CAN DESTROY
BRPVP_kitGroupsCanDestroy = [];
BRPVP_kitGroupsCanDestroyQtt = [];
{
	_x params ["_code","_qtt"];
	_classes = call _code;
	BRPVP_kitGroupsCanDestroy append _classes;
	{BRPVP_kitGroupsCanDestroyQtt pushBack _qtt;} forEach _classes;
} forEach BRPVP_kitGroupsCanDestroyCfg;

BRPVP_buildingObjCopyH = [];
BRPVP_buildingObjCopyDir = -1;
BRPVP_buildingObjCopyDirExtra = 270;
BRPVP_buildingBringDists = [0.01,0.1,0.5,1,2,5];
BRPVP_buildingBringDistIdx = 3;
BRPVP_buildingBringDist = BRPVP_buildingBringDists select BRPVP_buildingBringDistIdx;
BRPVP_construindoAngsRotacao = [45,15,5,1];
BRPVP_construindoAngRotacaoIdc = 2;
BRPVP_construindoAngRotacao = BRPVP_construindoAngsRotacao select BRPVP_construindoAngRotacaoIdc;
BRPVP_construindoHInts = [1.0,0.5,0.25,0.1,0.01,0.002];
BRPVP_construindoHIntIdc = 3;
BRPVP_construindoHInt = BRPVP_construindoHInts select BRPVP_construindoHIntIdc;
BRPVP_buildingItemName = "";
BRPVP_consLastItemUsed = "none";
BRPVP_objCrossLine = {
	private _pw = ASLToAGL getPosWorld _this;
	{
		_x params ["_down","_up"];
		drawLine3D [_pw vectorAdd _down,_pw vectorAdd _up,[0,1,0,1]];
	} forEach [[[0,0,-0.5],[0,0,0.5]],[[0,-0.5,0],[0,0.5,0]],[[-0.5,0,0],[0.5,0,0]]];
};
BRPVP_cancelaConstrucao = {
	private _attArray = [];
	if (BRPVP_consItemAttach isNotEqualTo []) then {
		_attArray = (BRPVP_consItemAttach select 1);
		deleteVehicle (BRPVP_consItemAttach select 0);
		BRPVP_consItemAttach = [];
	};
	player setVariable ["bdg",false,true];
	BRPVP_construindoItemObj removeAllEventHandlers "HandleDamage";
	deleteVehicle BRPVP_construindoItemObj;
	BRPVP_construindoItemObj = objNull;
	BRPVP_construindo = false;
	hintSilent "";
	BRPVP_construindoItemIdc = 0;
	if (BRPVP_consRepeat isEqualTo []) then {
		if (BRPVP_construindoItemRetira isEqualTo -1) then {
			50 call BRPVP_iniciaMenuExtra;
		} else {
			if (BRPVP_construindoItemRetira isEqualTo -2) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {"" remoteExecCall ["BRPVP_specMenuShow",BRPVP_specOnMeMachinesNoMe];};
			} else {
				76 call BRPVP_iniciaMenuExtra;
			};
		};
	};
	if (!isNull BRPVP_consMovObj) then {
		_movData = player getVariable "brpvp_moving_obj";
		if (count _movData isEqualTo 1) then {
			_movData params ["_obj"];
			[_obj,false] remoteExecCall ["hideObjectGlobal",2];
		} else {
			_movData params ["_obj","_posW","_vdu"];
			if (netId _obj isEqualTo "0:0") then {
				if (typeOf _obj in BRPVP_buildingHaveDoorListCVL) then {
					[typeOf _obj,_obj getVariable "id_bd",_vdu,_posW] remoteExecCall ["BRPVP_moveActionBoxBacksimpleObjectCancelCVL",0];
				} else {
					[typeOf _obj,_obj getVariable "id_bd",_vdu,_posW] remoteExecCall ["BRPVP_moveActionBoxBacksimpleObjectCancel",0];
				};
			} else {
				if (typeOf _obj isEqualTo BRPVP_superBoxClass) then {
					private _sustenter = _obj getVariable "brpvp_sustenter_obj";
					private _fixH = vectorMagnitude (getPosWorld _obj vectorDiff getPosWorld _sustenter);
					[_posW,_vdu,attachedObjects _obj select 0] remoteExecCall ["BRPVP_bigBoxVisualHelp",BRPVP_allNoServer];
					[_sustenter,_obj,_posW vectorAdd [0,0,_fixH],_vdu] remoteExecCall ["BRPVP_moveActionBoxBackBigBox",2];
				} else {
					_obj setVectorDirAndUP _vdu;
					_obj setPosWorld _posW;
					if !(_obj getVariable ["slv",false]) then {_obj setVariable ["slv",true,true];};
				};
			};			
		};
		player setVariable ["brpvp_moving_obj",[],true];
	};
	["",0,0,0,0,0,54369] call BRPVP_fnc_dynamicText;
};
BRPVP_construindoItemIdc = 0;
BRPVP_construindoItens = BRP_kitLight;
BRPVP_construindoVecUp = [0,0,1];
BRPVP_construindoItemObj = objNull;
BRPVP_construindoItemObjClass = "none";
BRPVP_buildingClassWithImg = [
	"Land_TTowerSmall_1_F",
	"Land_TTowerSmall_2_F",
	"Land_TTowerBig_1_F",
	"Land_TTowerBig_2_F"
];
BRPVP_buildingClassWithImgPath = [
	"BRP_imagens\items\Land_TTowerSmall_1_F.paa",
	"BRP_imagens\items\Land_TTowerSmall_2_F.paa",
	"BRP_imagens\items\Land_TTowerBig_1_F.paa",
	"BRP_imagens\items\Land_TTowerBig_2_F.paa"
];
if (localize "str_language_using" isEqualTo "portuguese") then {
	BRPVP_construcaoHint = {
		format [
			"<t align='center' color='#FFFFFF'>POSICIONAMENTO:</t><br/>
			<t align='center' color='#FFFFFF'>%6</t><br/>
			<img align='left' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_esquerda.paa'/>
			<img align='right' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_direita.paa'/><br/><br/>
			<t size='0.8' align='left' color='#FFFFFF'>DECISAO:</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla [ENTER]:</t><t size='0.8' align='right' color='#FFFFFF'>concluir</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla [DEL]:</t><t size='0.8' align='right' color='#FFFFFF'>cancelar</t><br/>
			<t size='0.8' align='left' color='#FFFFFF'>ROTACAO: %2</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla C:</t><t size='0.8' align='right' color='#FFFFFF'>rodar +</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla Z:</t><t size='0.8' align='right' color='#FFFFFF'>rodar -</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla X:</t><t size='0.8' align='right' color='#FFFFFF'>intensidade</t><br/>
			<t size='0.8' align='left' color='#FFFFFF'>POSICAO VERTICAL: %4 cm</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla R:</t><t size='0.8' align='right' color='#FFFFFF'>subir objeto</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla F:</t><t size='0.8' align='right' color='#FFFFFF'>descer objeto</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla V:</t><t size='0.8' align='right' color='#FFFFFF'>intensidade</t><br/>
			<t size='0.8' align='left' color='#FFFFFF'>TRAZER PARA PERTO: %7 cm</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla T:</t><t size='0.8' align='right' color='#FFFFFF'>para longe</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla G:</t><t size='0.8' align='right' color='#FFFFFF'>para perto</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla B:</t><t size='0.8' align='right' color='#FFFFFF'>intensidade</t><br/>
			<t size='0.8' align='left' color='#FFFFFF'>POSICIONAMENTO RADIAL:</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla Y:</t><t size='0.8' align='right' color='#FFFFFF'>posição (%8)</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla H:</t><t size='0.8' align='right' color='#FFFFFF'>direção (%9)</t><br/>
			<t size='0.8' align='left' color='#FFFFFF'>COPIA ATRIBUTO DO OBJETO NA MIRA:</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla U:</t><t size='0.8' align='right' color='#FFFFFF'>copia direção</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Tecla J:</t><t size='0.8' align='right' color='#FFFFFF'>copia altura</t><br/>
			<t size='0.8' align='left' color='#FFFFFF'>OUTROS COMANDOS:</t><br/>
			<t size='0.8' align='left' color='#FF3333'>Barra de Espaco:</t><t size='0.8' align='right' color='#FFFFFF'>pegar/soltar</t><br/>
			<t size='0.8' align='left' color='#FF3333'>End:</t><t size='0.8' align='right' color='#FFFFFF'>usar teleport</t><br/>",
			"",
			BRPVP_construindoAngRotacao,
			8,
			BRPVP_construindoHInt*100,
			"",
			BRPVP_buildingItemName,
			BRPVP_buildingBringDist*100,
			if (BRPVP_radialPlacementOn) then {"X"} else {"   "},
			if (BRPVP_radialPlacementDirOn) then {"X"} else {"   "}			
		]
	};
} else {
	if (localize "str_language_using" isEqualTo "russian") then {
		BRPVP_construcaoHint = {
			format [
				"<t align='center' color='#FFFFFF'>ПОЗИЦИОНИРОВАНИЕ:</t><br/>
				<t align='center' color='#FFFFFF'>%6</t><br/>
				<img align='left' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_esquerda.paa'/>
				<img align='right' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_direita.paa'/><br/><br/>
				<t size='0.8' align='left' color='#FFFFFF'>ВЫПОЛНИТЬ:</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка [ENTER]:</t><t size='0.8' align='right' color='#FFFFFF'>выполнить</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка [DEL]:</t><t size='0.8' align='right' color='#FFFFFF'>отменить</t><br/>
				<t size='0.8' align='left' color='#FFFFFF'>ВРАЩЕНИЕ: %2</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка C:</t><t size='0.8' align='right' color='#FFFFFF'>поворот +</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка Z:</t><t size='0.8' align='right' color='#FFFFFF'>Поворот -</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка X:</t><t size='0.8' align='right' color='#FFFFFF'>интенсивность</t><br/>
				<t size='0.8' align='left' color='#FFFFFF'>ВЕРТИКАЛЬНАЯ ПОЗИЦИЯ: %4 см</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка R:</t><t size='0.8' align='right' color='#FFFFFF'>вверх</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка F:</t><t size='0.8' align='right' color='#FFFFFF'>вниз</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка V:</t><t size='0.8' align='right' color='#FFFFFF'>интенсивность</t><br/>
				<t size='0.8' align='left' color='#FFFFFF'>ДАЛЬШЕ/БЛИЖЕ: %7 см</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка T:</t><t size='0.8' align='right' color='#FFFFFF'>дальше</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка G:</t><t size='0.8' align='right' color='#FFFFFF'>ближе</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка B:</t><t size='0.8' align='right' color='#FFFFFF'>интенсивность</t><br/>
				<t size='0.8' align='left' color='#FFFFFF'>РАДИАЛЬНОЕ РАЗМЕЩЕНИЕ:</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка Y:</t><t size='0.8' align='right' color='#FFFFFF'>позиция (%8)</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка H:</t><t size='0.8' align='right' color='#FFFFFF'>направление (%9)</t><br/>
				<t size='0.8' align='left' color='#FFFFFF'>КОПИРОВАТЬ С ЦЕЛЕВОГО ОБЪЕКТА:</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка U:</t><t size='0.8' align='right' color='#FFFFFF'>копировать направление</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Кнопка J:</t><t size='0.8' align='right' color='#FFFFFF'>копировать высоту</t><br/>
				<t size='0.8' align='left' color='#FFFFFF'>РАЗНОЕ:</t><br/>
				<t size='0.8' align='left' color='#FF3333'>Пробел:</t><t size='0.8' align='right' color='#FFFFFF'>схватить/отпустить</t><br/>
				<t size='0.8' align='left' color='#FF3333'>End:</t><t size='0.8' align='right' color='#FFFFFF'>использовать телепорт</t><br/>",
				"",
				BRPVP_construindoAngRotacao,
				8,
				BRPVP_construindoHInt*100,
				"",
				BRPVP_buildingItemName,
				BRPVP_buildingBringDist*100,
				if (BRPVP_radialPlacementOn) then {"X"} else {"   "},
				if (BRPVP_radialPlacementDirOn) then {"X"} else {"   "}			
			]
		};
	} else {
		if (localize "str_language_using" isEqualTo "Chinesesimp") then {
			BRPVP_construcaoHint = {
				format [
					"<t align='center' color='#FFFFFF'>按Q和E切换种类</t><br/>
					<t align='center' color='#FFFFFF'>%6</t><br/>
					<img align='left' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_esquerda.paa'/>
					<img align='right' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_direita.paa'/><br/><br/>
					<t size='0.8' align='left' color='#FFFFFF'>放置键:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key [回车键]:</t><t size='0.8' align='right' color='#FFFFFF'>确定放置</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key [DEL]:</t><t size='0.8' align='right' color='#FFFFFF'>取消放置</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>旋转度数: %2</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key C:</t><t size='0.8' align='right' color='#FFFFFF'>向左旋转</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key Z:</t><t size='0.8' align='right' color='#FFFFFF'>向右旋转</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key X:</t><t size='0.8' align='right' color='#FFFFFF'>增加旋转度数</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>垂直高度: %4 cm</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key R:</t><t size='0.8' align='right' color='#FFFFFF'>垂直向上</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key F:</t><t size='0.8' align='right' color='#FFFFFF'>垂直向下</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key V:</t><t size='0.8' align='right' color='#FFFFFF'>增加垂直高度</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>建筑远近: %7 cm</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key T:</t><t size='0.8' align='right' color='#FFFFFF'>建筑放远</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key G:</t><t size='0.8' align='right' color='#FFFFFF'>建筑拉近</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key B:</t><t size='0.8' align='right' color='#FFFFFF'>增加移动距离</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>径向放置:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key Y:</t><t size='0.8' align='right' color='#FFFFFF'>位置 (%8)</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key H:</t><t size='0.8' align='right' color='#FFFFFF'>方向 (%9)</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>从目标复制方向或高度:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key U:</t><t size='0.8' align='right' color='#FFFFFF'>复制方向</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key J:</t><t size='0.8' align='right' color='#FFFFFF'>复制高度</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>其他命令:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>空格键:</t><t size='0.8' align='right' color='#FFFFFF'>获取/释放</t><br/>
					<t size='0.8' align='left' color='#FF3333'>End:</t><t size='0.8' align='right' color='#FFFFFF'>使用传送</t><br/>",
					"",
					BRPVP_construindoAngRotacao,
					8,
					BRPVP_construindoHInt*100,
					"",
					BRPVP_buildingItemName,
					BRPVP_buildingBringDist*100,
					if (BRPVP_radialPlacementOn) then {"X"} else {"   "},
					if (BRPVP_radialPlacementDirOn) then {"X"} else {"   "}
				]
			};		
		} else {
			BRPVP_construcaoHint = {
				format [
					"<t align='center' color='#FFFFFF'>POSITIONING:</t><br/>
					<t align='center' color='#FFFFFF'>%6</t><br/>
					<img align='left' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_esquerda.paa'/>
					<img align='right' size='2.0' image='"+BRPVP_imagePrefix+"BRP_imagens\interface\seta_direita.paa'/><br/><br/>
					<t size='0.8' align='left' color='#FFFFFF'>DECISION:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key [ENTER]:</t><t size='0.8' align='right' color='#FFFFFF'>conclude</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key [DEL]:</t><t size='0.8' align='right' color='#FFFFFF'>cancel</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>ROTATION: %2</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key C:</t><t size='0.8' align='right' color='#FFFFFF'>rotate +</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key Z:</t><t size='0.8' align='right' color='#FFFFFF'>rotate -</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key X:</t><t size='0.8' align='right' color='#FFFFFF'>intensity</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>VERTICAL POSITION: %4 cm</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key R:</t><t size='0.8' align='right' color='#FFFFFF'>move up</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key F:</t><t size='0.8' align='right' color='#FFFFFF'>move down</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key V:</t><t size='0.8' align='right' color='#FFFFFF'>intensity</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>MOVE FAR/BRING NEAR: %7 cm</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key T:</t><t size='0.8' align='right' color='#FFFFFF'>move far</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key G:</t><t size='0.8' align='right' color='#FFFFFF'>bring near</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key B:</t><t size='0.8' align='right' color='#FFFFFF'>intensity</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>RADIAL PLACEMENT:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key Y:</t><t size='0.8' align='right' color='#FFFFFF'>position (%8)</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key H:</t><t size='0.8' align='right' color='#FFFFFF'>direction (%9)</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>COPY ATTRIBUTE FROM TARGET OBJECT:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key U:</t><t size='0.8' align='right' color='#FFFFFF'>copy direction</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Key J:</t><t size='0.8' align='right' color='#FFFFFF'>copy height</t><br/>
					<t size='0.8' align='left' color='#FFFFFF'>OTHER COMMANDS:</t><br/>
					<t size='0.8' align='left' color='#FF3333'>Space Bar:</t><t size='0.8' align='right' color='#FFFFFF'>get/release</t><br/>
					<t size='0.8' align='left' color='#FF3333'>End:</t><t size='0.8' align='right' color='#FFFFFF'>use teleport</t><br/>",
					"",
					BRPVP_construindoAngRotacao,
					8,
					BRPVP_construindoHInt*100,
					"",
					BRPVP_buildingItemName,
					BRPVP_buildingBringDist*100,
					if (BRPVP_radialPlacementOn) then {"X"} else {"   "},
					if (BRPVP_radialPlacementDirOn) then {"X"} else {"   "}
				]
			};
		};
	};
};
BRPVP_consItemAttach = [];
BRPVP_consSpawnItem = {
	if (BRPVP_consItemAttach isNotEqualTo []) then {
		deleteVehicle (BRPVP_consItemAttach select 0);
		BRPVP_consItemAttach = [];
	};
	private _pegaType = -1;
	private _pegaData = [];
	private _objAntigo = BRPVP_construindoItemObj;
	private _objeto = BRPVP_construindoItem;
	private _construindoItemObj = createSimpleObject [_objeto,BRPVP_posicaoFora,true];
	private _bigObjFix = 0;
	private _dExtra = 0;
	_construindoItemObj setVariable ["brpvp_construction_helper",true];
	if (_objeto isEqualTo BRPVP_superBoxClass) then {
		private _bigBoxStair = createSimpleObject ["Land_Obstacle_Ramp_F" ,BRPVP_posicaoFora,true];
		
		private _class = BRPVP_superBoxClass;
		private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
		_bigObjFix = -vectorMagnitude (getPosWorld _CVL vectorDiff getPosASL _CVL);
		deleteVehicle _CVL;
		
		private _class = "Land_Obstacle_Ramp_F";
		private _CVL = _class createVehicleLocal BRPVP_posicaoFora;
		_bigBoxStairFix = vectorMagnitude (getPosWorld _CVL vectorDiff getPosASL _CVL);
		deleteVehicle _CVL;

		_construindoItemObj setObjectScale BRPVP_superBoxScale;
		_bigBoxStair setObjectScale BRPVP_superBoxScale;
		BRPVP_consItemAttach = [_bigBoxStair,[0,2.4,_bigObjFix+_bigBoxStairFix+0.075]];
		_dExtra = 2.75;
	};

	//SET CUSTOM TEXTURE
	{
		_x params ["_classes","_texture","_q"];
		if (_objeto in _classes) exitWith {
			for "_i" from 0 to _q do {_construindoItemObj setObjectMaterial [_forEachIndex,"\a3\data_f\default.rvmat"];};
			for "_i" from 0 to _q do {_construindoItemObj setObjectTexture [_forEachIndex,BRPVP_imagePrefix+_texture];};
		};
	} forEach BRPVP_extraTextures;

	private _h = ((getPosWorld _construindoItemObj) select 2)-((getPosASL _construindoItemObj) select 2);
	_construindoItemObj setVariable ["own",player getVariable "own"];
	BRPVP_construindoItemObjClass = _objeto;
	_h = _h-BRPVP_buildingsHeightFixLast;
	BRPVP_buildingsHeightFixLast = _h+BRPVP_buildingsHeightFixLast;
	if (isText (configFile >> "CfgVehicles" >> (typeOf _construindoItemObj) >> "displayname")) then {BRPVP_buildingItemName = getText (configFile >> "CfgVehicles" >> (typeOf _construindoItemObj) >> "displayname") call BRPVP_escapeForStructuredTextFast;} else {BRPVP_buildingItemName = "";};
	private _bb = boundingBoxReal _construindoItemObj;
	private _bbXMax = abs ((_bb select 0 select 0)-(_bb select 1 select 0));
	private _bbYMax = abs ((_bb select 0 select 1)-(_bb select 1 select 1));
	private _diagonal = sqrt(_bbXMax^2+_bbYMax^2);
	private _yOff =	_diagonal/2+1.25+_dExtra;
	BRPVP_construindoFrente = _yOff;
	private _yOffDelta = _yOff-BRPVP_buildingDistSafe;
	BRPVP_buildingDistSafe = _yOff;
	if (isNull _objAntigo) then {
		if (isNull BRPVP_consMovObj) then {
			if (BRPVP_consRepeat isEqualTo []) then {
				BRPVP_construindoAngRotacaoSet = getDir player;
				BRPVP_construindoDirPlyObj = getDir player;
				BRPVP_construindoPega = [_yOffDelta,getDir player];
				_pegaType = 2;
				_pegaData = BRPVP_construindoPega;
			} else {
				BRPVP_consRepeat params ["_class","_posW","_posASL","_dir"];
				BRPVP_construindoAngRotacaoSet = _dir;
				BRPVP_construindoDirPlyObj = [player,_posW] call BIS_fnc_dirTo;
				BRPVP_construindoPega = [player distance2D _posW,getDir player];
				BRPVP_construindoHIntSet = (_posASL select 2)-(getPosASL player select 2);
				if (_objeto isEqualTo BRPVP_superBoxClass) then {BRPVP_construindoHIntSet = BRPVP_construindoHIntSet-0.0079298;};
			};
		} else {
			BRPVP_construindoAngRotacaoSet = getDir BRPVP_consMovObj;
			BRPVP_construindoDirPlyObj = [player,BRPVP_consMovObj] call BIS_fnc_dirTo;
			BRPVP_construindoPega = [player distance2D BRPVP_consMovObj,getDir player];
			BRPVP_construindoHIntSet = (getPosASL BRPVP_consMovObj select 2)-(getPosASL player select 2);
			if (_objeto isEqualTo BRPVP_superBoxClass) then {BRPVP_construindoHIntSet = BRPVP_construindoHIntSet-0.0079298;};

			_pegaType = 2;
			_pegaData = BRPVP_construindoPega;
			private _typeOf = typeOf BRPVP_consMovObj;
			private _rad = 10+(sizeOf _typeOf)/2;
			[BRPVP_consMovObj,_rad,15] call BRPVP_enableVehiclesBuildingsChanged;					
			if (BRPVP_consMovObj call BRPVP_isCompleteBox || typeOf BRPVP_consMovObj in BRP_kitAutoTurret || netId BRPVP_consMovObj isEqualTo "0:0") then {
				if (netId BRPVP_consMovObj isEqualTo "0:0") then {
					player setVariable ["brpvp_moving_obj",[BRPVP_consMovObj,getPosWorld BRPVP_consMovObj,[vectorDir BRPVP_consMovObj,vectorUp BRPVP_consMovObj]]];
					if (_typeOf in BRPVP_buildingHaveDoorListCVL) then {
						[player,_typeOf,BRPVP_consMovObj getVariable "id_bd"] remoteExecCall ["BRPVP_setSimpleObjectAwayCVL",0];
					} else {
						[player,_typeOf,BRPVP_consMovObj getVariable "id_bd"] remoteExecCall ["BRPVP_setSimpleObjectAway",0];
					};
				} else {
					player setVariable ["brpvp_moving_obj",[BRPVP_consMovObj,getPosWorld BRPVP_consMovObj,[vectorDir BRPVP_consMovObj,vectorUp BRPVP_consMovObj]],[clientOwner,2]];
					if (_objeto isEqualTo BRPVP_superBoxClass) then {
						private _sustenter = BRPVP_consMovObj getVariable "brpvp_sustenter_obj";
						_sustenter setPosATL [random -250,random -250,0];
					} else {
						BRPVP_consMovObj setPosATL [random -250,random -250,0];
					};
				};
			} else {
				player setVariable ["brpvp_moving_obj",[BRPVP_consMovObj],[clientOwner,2]];
				[BRPVP_consMovObj,true] remoteExecCall ["hideObjectGlobal",2];
			};
		};
	} else {
		_construindoItemObj setVectorDirAndUp [vectorDir _objAntigo,vectorUp _objAntigo];
		_construindoItemObj setPosWorld getPosWorld _objAntigo;
		if (typeOf _construindoItemObj isEqualTo BRPVP_superBoxClass) then {_construindoItemObj setObjectScale BRPVP_superBoxScale;};
		deleteVehicle _objAntigo;
		if (BRPVP_construindoPega select 0 >= 0) then {
			BRPVP_construindoPega set [0,(BRPVP_construindoPega select 0)+_yOffDelta];
			_pegaType = 0;
			_pegaData = BRPVP_construindoPega select 0;
		};
	};
	BRPVP_construindoHIntSet = BRPVP_construindoHIntSet+_h;
	BRPVP_construindoItemObj = _construindoItemObj;
	if (BRPVP_construindoItemObj isKindOf "FlagCarrier") then {BRPVP_construindoItemObj setVariable ["brpvp_flag_radius",BRPVP_construindoItemObj call BRPVP_getFlagRadius];};
	if (BRPVP_specOnMeMachinesNoMe isNotEqualTo [] && BRPVP_consRepeat isEqualTo []) then {
		private _classOrPath = if (typeOf BRPVP_construindoItemObj isEqualTo "") then {getModelInfo BRPVP_construindoItemObj select 1} else {typeOf BRPVP_construindoItemObj};
		[
			[
				_classOrPath,
				getPosWorld BRPVP_construindoItemObj,
				vectorDir BRPVP_construindoItemObj,
				vectorUp BRPVP_construindoItemObj
			],
			BRPVP_construindoAngRotacaoSet,
			BRPVP_construindoDirPlyObj,
			[_pegaType,_pegaData],
			_h
		] remoteExecCall ["BRPVP_specSetMainVars00",BRPVP_specOnMeMachinesNoMe];
	};

	//MANTER ASSIM OU CRIAR BOTAO PARA LIGAR E DESLIGAR COLISAO?
	BRPVP_construindoItemObj disableCollisionWith player;
	player disableCollisionWith BRPVP_construindoItemObj;

	if (BRPVP_consRepeat isEqualTo []) then {call BRPVP_atualizaDebugMenu;};
};
BRPVP_construir = {
	private ["_flagOk"];
	_obj = _this select 0 select 0;

	BRPVP_consRepeat = if (count _this > 6) then {_this select 6} else {[]};
	BRPVP_consBuildingCost = if (count _this > 5) then {_this select 5} else {0};
	BRPVP_consMovObj = if (count _this > 4) then {_this select 4} else {objNull};
	_isCreating = isNull BRPVP_consMovObj;

	//DISCONNECT SMART TV BILL BOARD IF MOVING A CONNECTED ONE
	if (!isNull BRPVP_consMovObj) then {
		if (_obj isEqualTo "Land_Billboard_F") then {
			private _camReal = BRPVP_consMovObj getVariable ["brpvp_bb_camera",objNull];
			if (!isNull _camReal) then {
				private _camFake = BRPVP_consMovObj getVariable ["brpvp_bb_camera_fake",objNull];
				private _camKey = "seccam"+str (BRPVP_consMovObj getVariable "id_bd");
				_camReal cameraEffect ["Terminate","Back",_camKey];
				BRPVP_secCamBbsMy = BRPVP_secCamBbsMy-[[BRPVP_consMovObj,_camReal,_camKey]];
				BRPVP_secCamBbsMyPlayerSave = BRPVP_secCamBbsMyPlayerSave-[[BRPVP_consMovObj getVariable ["id_bd",-1],_camFake getVariable ["brpvp_cam_id",-1]]];
				player setVariable ["brpvp_seccam_connections",BRPVP_secCamBbsMyPlayerSave,2];
				camDestroy _camReal;
			};
			BRPVP_consMovObj setVariable ["brpvp_bb_camera_fake",objNull];
		};
	};

	_isFlag = _obj isKindOf ["FlagCarrier",configFile >> "CfgVehicles"];
	_isCreatingFlag = _isFlag && _isCreating;
	_isMovingFlag = _isFlag && !_isCreating;
	_flagRad = _obj call BRPVP_getFlagRadius;;

	//CHECK IF FLAG NEAR (FIO)
	_ok = true;
	if (_isCreatingFlag && BRPVP_flagsMinimumDisnce > 0 && !BRPVP_vePlayers) then {
		{
			private _rad = _x getVariable ["brpvp_flag_radius",0];
			if (_x distance player < _flagRad+_rad+BRPVP_flagsMinimumDistance) exitWith {_ok = false;};
		} forEach nearestObjects [player,["FlagCarrier"],BRPVP_flagsMinimumDistance+_flagRad+200,true];
	};
	if (!_ok) exitWith {[format [localize "str_flag_near",BRPVP_flagsMinimumDistance],-5] call BRPVP_hint;};

	//CHECK IF FLAG NEAR MISSION
	if (_isFlag && !BRPVP_vePlayers && {{player distance2D _x < 300+_flagRad} count BRPVP_missionsPos > 0}) exitWith {[localize "str_cant_flag_near_miss",-6,12,854,"erro"] call BRPVP_hint;};

	//CHECK IF NEAR LAND
	_ok = true;
	if (BRPVP_waterBasesLimitUse && _isCreatingFlag && !BRPVP_vePlayers) then {
		_ok = [getPosWorld player,BRPVP_waterBasesLimitDistance] call BRPVP_checkIfLandNear;
	};
	if (!_ok) exitWith {[format [localize "str_flag_no_near_land",BRPVP_waterBasesLimitDistance],-5] call BRPVP_hint;};

	//CHECK IF IN ENEMY FLAG (FIO)
	if (player call BRPVP_checkIfFlagDenied && !_isMovingFlag && !BRPVP_vePlayers) exitWith {[localize "str_cons_cant_enemy_flag",4,12,854,"erro"] call BRPVP_hint;};

	//CHECK IF FLAG OK (FLAG NOT IN FLAG AREA) (FIO)
	_flagOk = true;
	if (_isFlag && _isCreating && !BRPVP_vePlayers) then {
		_mult = 1-BRPVP_flagsAreasIntersectionAllowed;
		{
			if (player distance2D _x <= (_x getVariable ["brpvp_flag_radius",0])*_mult+_flagRad*_mult) exitWith {_flagOk = false;};
		} forEach nearestObjects [player,["FlagCarrier"],400,true];
	};
	if (!_flagOk) exitWith {[localize "str_cons_cant_flag_2x",4,12,854,"erro"] call BRPVP_hint;};

	//CHECK IF BUILDING IN FLAG AREA (FIO)
	_flagOk = false;
	if (!_isFlag && _isCreating) then {
		{
			if (_x call BRPVP_checaAcesso && player distance2D _x <= _x getVariable ["brpvp_flag_radius",0]) exitWith {
				_flagOk = true;
			};
		} forEach nearestObjects [player,["FlagCarrier"],200,true];
	};
	if (!_isFlag && _isCreating && {!_flagOk && !BRPVP_vePlayers && !BRPVP_allowBuildingsAwayFromFlags}) exitWith {[localize "str_cons_cant_flag",4,12,854,"erro"] call BRPVP_hint;};

	//CAN'T BUILD IF FLAG RECEIVED A RECENT RAID ACTION (FIO)
	_recentRaidAction = false;
	_lraTimeA = 0;
	_lraTimeB = 0;
	if (BRPVP_raidNoConstructionOnBaseIfRaidStarted && !BRPVP_vePlayers) then {
		_flags = [];
		{
			_rad = _x getVariable ["brpvp_flag_radius",0];
			_dist = _x distance2D player;
			if (_dist < _rad) then {_flags pushBack _x;};
		} forEach nearestObjects [player,["FlagCarrier"],200,true];
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
	
	//CANT BUILD WHILE IN COMBAT MODE
	if (player getVariable ["cmb",false] && !BRPVP_vePlayers) exitWith {[localize "str_cons_cant_combat",4,12,854,"erro"] call BRPVP_hint;};
	
	//CHECK IF CONSTRUCTING FLAG IN NO-BUILD AREA (FIO)
	_objInNoBuildArea = false;
	if (_isCreatingFlag && !BRPVP_vePlayers) then {
		_objPos = ASLToAGL getPosASL player;
		{
			_x params ["_places","_extraRadius"];
			if ({_objPos distance2D (_x select 0) < (_x select 1)+_extraRadius+_flagRad} count _places > 0) exitWith {_objInNoBuildArea = true;};
		} forEach BRPVP_placesExtraNobuildArea;
	};
	if (_objInNoBuildArea) exitWith {[localize "str_cons_cant_nobuild_area",-4,12,854,"erro"] call BRPVP_hint;};

	//CHECK IF HAVE TURRET DANGER LEVEL
	if (BRPVP_autoTurretDangerLevel > 0 && !BRPVP_vePlayers) exitWith {[localize "str_cons_cant_turret",-4.5,12,854,"erro"] call BRPVP_hint;};

	//CHECK FOR BUILDINGS THAT CAN'T CONSTRUCT FLAG NEAR (FIO)
	_deniedBuildingNear = false;
	if (_isCreatingFlag && !BRPVP_vePlayers) then {
		_objs = nearestObjects [player,BRPVP_cantBuildNearBuildings,BRPVP_cantBuildNearDistance];
		_deniedBuildingNear = {_x getVariable ["id_bd",-1] isEqualTo -1} count _objs > BRPVP_cantBuildNearLimit;
	};
	if (_deniedBuildingNear) exitWith {[format [localize "str_cons_cant_militar",BRPVP_cantBuildNearDistance],4,12,854,"erro"] call BRPVP_hint;};

	//CHECK IF TURRET FLAG LIMIT REACHED (FIO)
	if (_this select 0 isEqualTo BRP_kitAutoTurret && {[player,0] call BRPVP_turretsOnFlagLimitReached && !BRPVP_vePlayers}) exitWith {[localize "str_turret_limit_reached",-5] call BRPVP_hint;};

	//CHECK IF FLAG COMBINATION IS ALLOWED
	if (_isCreatingFlag && {!([player,_obj] call BRPVP_checkIfNewFlagAllowed) && !BRPVP_vePlayers}) exitWith {[localize "str_cons_cant_comb_flags",6,12,854,"erro"] call BRPVP_hint;};

	//CHECK IF FLAG IS NEAR ENEMY FLAG (FIO)
	_eNear = false;
	if (_isFlag) then {_eNear = [player,BRPVP_flagsMinimumDistanceEnemy] call BRPVP_checkIfEnemyFlagExtraRadius;};
	if (_eNear && !BRPVP_vePlayers) exitWith {[format[localize "str_cant_enemy_flag_near",BRPVP_flagsMinimumDistanceEnemy],-8] call BRPVP_hint;};

	//SELECT LAST ITEM
	BRPVP_construindoItens = _this select 0;
	private _idx = BRPVP_construindoItens find BRPVP_consLastItemUsed;
	if (_idx > -1) then {BRPVP_construindoItemIdc = _idx;} else {BRPVP_construindoItemIdc = 0;};

	(findDisplay 602) closeDisplay 1;
	BRPVP_construindoConcluindoPositivo = false;
	BRPVP_buildingObjCopyH = [];
	BRPVP_buildingObjCopyDir = -1;
	BRPVP_buildingObjCopyDirExtra = 270;
	BRPVP_buildingsHeightFixLast = 0;
	BRPVP_buildingDistSafe = 0;
	BRPVP_construindoHIntSet = 0;
	BRPVP_construindoPega = [-1];
	BRPVP_construindoVecUp = [0,0,1];
	BRPVP_construindoItemObj = objNull;
	BRPVP_construindoFrente = 10;
	BRPVP_construindoItemRetira = _this select 2;
	BRPVP_construindoIsMapObject = _this select 3;
	BRPVP_construindoAngRotacao = BRPVP_construindoAngsRotacao select BRPVP_construindoAngRotacaoIdc;
	BRPVP_construindoAngRotacaoSet = 0;
	BRPVP_construindoItem = BRPVP_construindoItens select BRPVP_construindoItemIdc;
	BRPVP_radialPlacementOn = false;
	BRPVP_radialPlacementDirOn = false;
	BRPVP_construindo = true;
	player setVariable ["bdg",true,true];
	call BRPVP_consSpawnItem;
	if (BRPVP_consRepeat isEqualTo []) then {call BRPVP_atualizaDebugMenu;};
	_flagHolder = player call BRPVP_nearestFlagInsideWithAccess;
	_flagHolderRad = _flagHolder getVariable ["brpvp_flag_radius",0];
	["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\grab_on.paa'/>",0,0.75,36000,0,0,54369] call BRPVP_fnc_dynamicText;

	if (BRPVP_consRepeat isEqualTo []) then {
		[_isFlag,_flagHolder,_flagHolderRad] spawn {
			params ["_isFlag","_flagHolder","_flagHolderRad"];
			_initA = time;
			_flagOk = true;

			//SPEC VARS
			private _buildingObjCopyDirSpec = BRPVP_buildingObjCopyDir;
			private _buildingObjCopyHSpec = +BRPVP_buildingObjCopyH;
			private _buildingObjCopyDirExtraSpec = BRPVP_buildingObjCopyDirExtra;
			if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {[player,_flagHolder,_flagHolderRad,[BRPVP_construindoPega,BRPVP_buildingObjCopyDir,BRPVP_construindoDirPlyObj,BRPVP_construindoAngRotacaoSet,BRPVP_buildingObjCopyH,BRPVP_construindoHIntSet,BRPVP_buildingObjCopyDirExtra,BRPVP_radialPlacementOn,BRPVP_radialPlacementDirOn]] remoteExec ["BRPVP_specConstructionCode",BRPVP_specOnMeMachinesNoMe];};

			waitUntil {
				_time = time;
				if (!isNull BRPVP_construindoItemObj) then {
					//UPDATE SPECTATORS VARS
					if (BRPVP_buildingObjCopyDir isNotEqualTo _buildingObjCopyDirSpec) then {_buildingObjCopyDirSpec = BRPVP_buildingObjCopyDir;if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_buildingObjCopyDirSpec remoteExecCall ["BRPVP_specSetMainVars02",BRPVP_specOnMeMachinesNoMe];};};
					if (BRPVP_buildingObjCopyH isNotEqualTo _buildingObjCopyHSpec) then {_buildingObjCopyHSpec = +BRPVP_buildingObjCopyH;if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_buildingObjCopyHSpec remoteExecCall ["BRPVP_specSetMainVars03",BRPVP_specOnMeMachinesNoMe];};};
					if (BRPVP_buildingObjCopyDirExtra isNotEqualTo _buildingObjCopyDirExtraSpec) then {_buildingObjCopyDirExtraSpec = BRPVP_buildingObjCopyDirExtra;if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {_buildingObjCopyDirExtraSpec remoteExecCall ["BRPVP_specSetMainVars05",BRPVP_specOnMeMachinesNoMe];};};
					if (BRPVP_specAddBuilding isNotEqualTo []) then {
						[player,_flagHolder,_flagHolderRad,[BRPVP_construindoPega,BRPVP_buildingObjCopyDir,BRPVP_construindoDirPlyObj,BRPVP_construindoAngRotacaoSet,BRPVP_buildingObjCopyH,BRPVP_construindoHIntSet,BRPVP_buildingObjCopyDirExtra,BRPVP_radialPlacementOn,BRPVP_radialPlacementDirOn],[typeOf BRPVP_construindoItemObj,getPosWorld BRPVP_construindoItemObj,vectorDir BRPVP_construindoItemObj,vectorUp BRPVP_construindoItemObj]] remoteExec ["BRPVP_specConstructionCode",BRPVP_specAddBuilding];
						BRPVP_specAddBuilding = [];
					};

					if (BRPVP_construindoPega select 0 >= 0) then {
						_dist = BRPVP_construindoPega select 0;
						_refP = BRPVP_construindoPega select 1;
						_dP = if (BRPVP_buildingObjCopyDir isEqualTo -1) then {getDir player} else {_refP};
						_refDeltaP = _dP-_refP;
						BRPVP_construindoPega set [1,_dP];
						BRPVP_construindoDirPlyObj = BRPVP_construindoDirPlyObj+_refDeltaP;
						BRPVP_construindoAngRotacaoSet = BRPVP_construindoAngRotacaoSet+_refDeltaP;
						_cP = getPosWorld player;
						if (BRPVP_buildingObjCopyH isNotEqualTo []) then {BRPVP_construindoHIntSet = (BRPVP_buildingObjCopyH select 2)-(_cP select 2);};
						_cP = _cP vectorAdd [_dist*sin BRPVP_construindoDirPlyObj,_dist*cos BRPVP_construindoDirPlyObj,BRPVP_construindoHIntSet];
						BRPVP_construindoItemObj setPosWorld _cP;
						if (BRPVP_buildingObjCopyDir isEqualTo -1) then {BRPVP_construindoItemObj setDir BRPVP_construindoAngRotacaoSet;} else {BRPVP_construindoItemObj setDir (BRPVP_buildingObjCopyDir+BRPVP_buildingObjCopyDirExtra);};
						
						if (typeOf BRPVP_construindoItemObj isEqualTo BRPVP_superBoxClass && !BRPVP_construindoConcluindoPositivo) then {BRPVP_construindoItemObj setObjectScale BRPVP_superBoxScale;};
					} else {
						if (BRPVP_construindoHIntSet != 0) then {
							BRPVP_construindoItemObj setPosWorld ((getPosWorld BRPVP_construindoItemObj) vectorAdd [0,0,BRPVP_construindoHIntSet]);
							BRPVP_construindoHIntSet = 0;
						} else {
							if (BRPVP_buildingObjCopyH isNotEqualTo []) then {
								_selfPos = getPosWorld BRPVP_construindoItemObj;
								_selfPos set [2,BRPVP_buildingObjCopyH select 2];
								BRPVP_construindoItemObj setPosWorld _selfPos;
							};
						};
						if (BRPVP_buildingObjCopyDir isEqualTo -1) then {BRPVP_construindoItemObj setDir BRPVP_construindoAngRotacaoSet;} else {BRPVP_construindoItemObj setDir (BRPVP_buildingObjCopyDir+BRPVP_buildingObjCopyDirExtra);};
						
						if (typeOf BRPVP_construindoItemObj isEqualTo BRPVP_superBoxClass && !BRPVP_construindoConcluindoPositivo) then {BRPVP_construindoItemObj setObjectScale BRPVP_superBoxScale;};
					};
					if (!isNull _flagHolder) then {
						if (BRPVP_radialPlacementOn) then {
							BRPVP_construindoItemObj call BRPVP_objCrossLine;
							private _dir = [_flagHolder,BRPVP_construindoItemObj] call BIS_fnc_dirTo;
							private _fp = getPosASL _flagHolder;
							private _op = [(_fp select 0)+_flagHolderRad*0.9*sin _dir,(_fp select 1)+_flagHolderRad*0.9*cos _dir,0];
							private _h = getPosASL BRPVP_construindoItemObj select 2;
							_op set [2,_h];
							BRPVP_construindoItemObj setPosASL _op;
							private _opw = getPosASL BRPVP_construindoItemObj;
							{drawLine3D [ASLToAGL _fp vectorAdd _x,ASLToAGL _opw vectorAdd _x,[1,0,0,1]];} forEach [[0,0,0],[0,0,0.5],[0,0,1],[0,0,1.5],[0,0,2],[0,0,2.5],[0,0,3]];
						};
						if (BRPVP_radialPlacementDirOn) then {
							private _dir = [_flagHolder,BRPVP_construindoItemObj] call BIS_fnc_dirTo;
							BRPVP_construindoAngRotacaoSet = _dir;
						};
					};
					if (typeOf BRPVP_construindoItemObj isEqualTo BRPVP_superBoxClass && !BRPVP_construindoConcluindoPositivo && getObjectScale BRPVP_construindoItemObj isNotEqualTo BRPVP_superBoxScale) then {BRPVP_construindoItemObj setObjectScale BRPVP_superBoxScale;};

					//ATTACH HELPER
					if (BRPVP_consItemAttach isNotEqualTo []) then {
						BRPVP_consItemAttach params ["_helper","_attachArray"];
						_helper attachTo [BRPVP_construindoItemObj,_attachArray];
					};
				};
				if (_time-_initA > 1) then {
					_initA = _time;
					_flagOk = ([player,65] call BRPVP_checkOnFlagStateExtraRadius isEqualTo 2) || _isFlag;
				};
				!BRPVP_construindo || !(player call BRPVP_pAlive) || (player getVariable ["cmb",false] && !BRPVP_vePlayers) || !isNull (player getVariable ["brpvp_surrendedBy",objNull]) || (!_flagOk && !BRPVP_vePlayers) || (BRPVP_autoTurretDangerLevel > 0 && !BRPVP_vePlayers)
			};
			if (BRPVP_construindo) then {call BRPVP_cancelaConstrucao;};
			if (player getVariable ["cmb",false] && !BRPVP_vePlayers) then {
				[localize "str_cons_cant_combat",-4.5,200,0,"erro"] call BRPVP_hint;
			} else {
				if (BRPVP_autoTurretDangerLevel > 0 && !BRPVP_vePlayers) then {
					[localize "str_cons_cant_turret",-4.5,200,0,"erro"] call BRPVP_hint;
				} else {
					if (!_flagOk && !BRPVP_vePlayers) then {"erro" call BRPVP_playSound;};
				};
			};
			if !(player call BRPVP_pAlive) then {
				BRPVP_menuExtraLigado = false;
				hintSilent "";
				if (BRPVP_specOnMeMachinesNoMe isNotEqualTo []) then {"" remoteExecCall ["BRPVP_specMenuShow",BRPVP_specOnMeMachinesNoMe];};
			};
			BRPVP_construindoItem = "";
		};
	} else {
		_initA = time;
		_flagOk = true;
		call {
			_time = time;
			if (!isNull BRPVP_construindoItemObj) then {
				_dist = BRPVP_construindoPega select 0;
				_refP = BRPVP_construindoPega select 1;
				_dP = if (BRPVP_buildingObjCopyDir isEqualTo -1) then {getDir player} else {_refP};
				_refDeltaP = _dP-_refP;
				BRPVP_construindoPega set [1,_dP];
				BRPVP_construindoDirPlyObj = BRPVP_construindoDirPlyObj+_refDeltaP;
				BRPVP_construindoAngRotacaoSet = BRPVP_construindoAngRotacaoSet+_refDeltaP;
				_cP = getPosWorld player;
				if (BRPVP_buildingObjCopyH isNotEqualTo []) then {BRPVP_construindoHIntSet = (BRPVP_buildingObjCopyH select 2)-(_cP select 2);};
				_cP = _cP vectorAdd [_dist*sin BRPVP_construindoDirPlyObj,_dist*cos BRPVP_construindoDirPlyObj,BRPVP_construindoHIntSet];
				BRPVP_construindoItemObj setPosWorld _cP;
				if (BRPVP_buildingObjCopyDir isEqualTo -1) then {BRPVP_construindoItemObj setDir BRPVP_construindoAngRotacaoSet;} else {BRPVP_construindoItemObj setDir (BRPVP_buildingObjCopyDir+BRPVP_buildingObjCopyDirExtra);};
				if (typeOf BRPVP_construindoItemObj isEqualTo BRPVP_superBoxClass && !BRPVP_construindoConcluindoPositivo && getObjectScale BRPVP_construindoItemObj isNotEqualTo BRPVP_superBoxScale) then {BRPVP_construindoItemObj setObjectScale BRPVP_superBoxScale;};

				//ATTACH HELPER
				if (BRPVP_consItemAttach isNotEqualTo []) then {
					BRPVP_consItemAttach params ["_helper","_attachArray"];
					_helper attachTo [BRPVP_construindoItemObj,_attachArray];
				};
			};
			if (_time-_initA > 1) then {
				_initA = _time;
				_flagOk = ([player,65] call BRPVP_checkOnFlagStateExtraRadius isEqualTo 2) || _isFlag;
			};
			private _retorno = false;
			private _key = 0x1C;
			private _XXX = true;
			private _SXX = false;
			private _XCX = false;
			private _XXA = false;
			private _SXA = false;
			private _XCA = false;
			[controlNull,_key,false,false,false] call BRPVP_consCode;
		};
		if (BRPVP_construindo) then {call BRPVP_cancelaConstrucao;};
		if (player getVariable ["cmb",false] && !BRPVP_vePlayers) then {
			[localize "str_cons_cant_combat",-4.5,200,0,"erro"] call BRPVP_hint;
		} else {
			if (BRPVP_autoTurretDangerLevel > 0 && !BRPVP_vePlayers) then {
				[localize "str_cons_cant_turret",-4.5,200,0,"erro"] call BRPVP_hint;
			} else {
				if (!_flagOk && !BRPVP_vePlayers) then {"erro" call BRPVP_playSound;};
			};
		};
		BRPVP_construindoItem = "";
	};
};

diag_log ("[SCRIPT] constructionFunctionsAndVars.sqf END: "+str round (diag_tickTime-_scriptStart));