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

_place = _this select 0;
_rad = _this select 1;
_skill = _this select 2;

_pFix = [0,0,0];
_pFix2D = [0,0,0];

BRPVP_pmissEndCheckObjects = [];

_pmissGroups = [
	/*
	[
		WEST,
		[],
		[],
		[
			["B_SAM_System_01_F",[13492.1,12201.8,7.5],[[-1,-0.01,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	*/
	[
		WEST,
		[],
		[],
		[
			//B ["B_T_APC_Tracked_01_AA_F",[13571.1,12115.7,18.2],[[-0.99,0.08,-0.11],[-0.11,0.11,0.99]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_T_APC_Tracked_01_AA_F",[13663.3,12327.8,15.1],[[0.99,0.12,0],[-0.02,0.12,0.99]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_T_APC_Tracked_01_AA_F",[13415.4,11883.3,17.4],[[0.68,0.73,0.07],[-0.15,0.05,0.99]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_T_Boat_Armed_01_minigun_F",[12775.8,11612.8,2.4],[[0,1,0.01],[0,-0.01,1]],[],[["B_T_Soldier_F",["driver"],[],[]],["B_T_Soldier_F",["turret",[0]],[],[]],["B_T_Soldier_F",["turret",[1]],[],[]]]]
		],
		[
			[[12775.8,11612.9,0.219786],"MOVE"],
			[[13418.3,12812.2,0.0220283],"MOVE"],
			[[14276.5,12298.9,-0.0265118],"MOVE"],
			[[13568.4,11240.3,-0.109589],"MOVE"],
			[[13130.3,11443.6,0.0035385],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_T_Boat_Armed_01_minigun_F",[14225.2,12497.8,2.4],[[0,1,0],[0,0,1]],[],[["B_T_Soldier_F",["driver"],[],[]],["B_T_Soldier_F",["turret",[0]],[],[]],["B_T_Soldier_F",["turret",[1]],[],[]]]]
		],
		[
			[[14225.3,12497.8,0.239575],"MOVE"],
			[[13346.9,12834.7,0.0141001],"MOVE"],
			[[12662.4,11639.2,-0.022517],"MOVE"],
			[[13544.4,11372.6,1.12382],"CYCLE"],
			[[14023.4,12166.4,-0.0433596],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_T_MBT_01_TUSK_F",[13467.6,12069.4,17],[[0,1,0],[0.07,0,1]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			//B ["B_T_MBT_01_TUSK_F",[13570.4,12058.2,14.7],[[0.13,-0.99,-0.09],[-0.2,-0.12,0.97]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_T_APC_Wheeled_01_cannon_F",[13503.5,12019.3,14.2],[[0.47,-0.86,-0.17],[0.07,-0.16,0.99]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			//["B_T_Mortar_01_F",[13510.6,12183.3,6.5],[[-0.27,-0.96,0],[0,0,1]],[],[["B_T_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[13502.4,12183.4,6.7],[[-0.05,-1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_T_Mortar_01_F",[13492.8,12221.3,6.5],[[0,1,0],[0,0,1]],[],[["B_T_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			//B ["B_T_APC_Wheeled_01_cannon_F",[13665.3,12222.8,15.5],[[0.92,-0.2,-0.33],[0.32,-0.06,0.95]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	/*
	[
		WEST,
		[],
		[],
		[
			["B_Radar_System_01_F",[13574.4,12088.8,18.6],[[-0.99,0.08,0.09],[0.09,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	*/
	[
		WEST,
		[],
		[],
		[
			["B_SAM_System_03_F",[13572.5,12080.8,19.4],[[-0.97,0.23,0.09],[0.07,-0.1,0.99]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	/*
	[
		WEST,
		[],
		[],
		[
			["B_Radar_System_01_F",[13588.3,12206.8,18.3],[[0.91,-0.41,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	*/
	/*
	[
		WEST,
		[],
		[],
		[
			["B_SAM_System_03_F",[13592.7,12216.6,19.1],[[0.9,-0.43,0.01],[0.01,0.04,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	*/
	[
		WEST,
		[],
		[],
		[
			["B_AAA_System_01_F",[13320.9,11785.4,50.7],[[-0.81,0.58,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	/*
	[
		WEST,
		[],
		[],
		[
			["B_AAA_System_01_F",[13645.8,12294.6,48],[[0.96,-0.3,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	*/
	[
		WEST,
		[],
		[],
		[
			["B_SAM_System_01_F",[13443.4,12100.5,31.4],[[0,1,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_ghillie_tna_F",[13339,11809.8,2.8],0,[],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_ghillie_tna_F",[13610,12288.8,0],0,[],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13585.3,12319.8,28.4],[[-0.99,-0.16,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13588.7,12328.4,28.3],[[0.32,0.95,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			//B ["B_HMG_01_high_F",[13727.8,12334.9,36.8],[[0.5,-0.87,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[13723,12339.3,38.7],[[0,1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13719.9,12332.7,36.7],[[-0.86,-0.51,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_Sniper_F",[13567.7,12096.5,3.2],206,[],"STAND",[]]
		],
		[
			//["B_HMG_01_high_F",[13599.4,12063.5,31.8],[[-0.99,0.16,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[13604.9,12068.1,33.8],[[-0.71,0.71,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_HMG_01_high_F",[13608.7,12062.4,31.8],[[0.63,-0.78,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_T_LSV_01_AT_F",[13601.6,12046.5,13.3],[[0.77,-0.63,-0.11],[0.01,-0.16,0.99]],[],[["B_T_Soldier_F",["turret",[0]],[],[]],["B_T_Soldier_F",["turret",[1]],[],[]]]],
			["B_HMG_01_high_F",[13568.4,12104.6,21],[[-0.74,0.68,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_ghillie_tna_F",[13524.8,12233.8,11.2],162,[],"STAND",[]],
			["B_T_ghillie_tna_F",[13518.4,12241.3,12.4],0,[],"STAND",[]]
		],
		[
			["B_HMG_01_high_F",[13518.4,12233.2,18.4],[[-0.91,-0.42,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13597.5,12167,27.4],[[-0.3,0.95,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13434.1,11858.3,34.9],[[-0.93,-0.35,-0.1],[-0.1,-0.04,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_HMG_01_high_F",[13445,11865,34.9],[[0.65,0.76,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_T_APC_Wheeled_01_cannon_F",[13441.5,11892.4,15.8],[[0.05,-1,-0.04],[0.06,-0.03,1]],[1,2,4],[["B_T_Crew_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			//B ["B_HMG_01_high_F",[13315.2,11873.9,29.3],[[0.93,0.36,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13310.3,11867.1,29.3],[[-0.35,-0.94,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_ghillie_tna_F",[13479.8,11955,4.5],195,[],"STAND",[]]
		],
		[
			//B ["B_T_MRAP_01_hmg_F",[13472.1,11962,15],[[-0.55,-0.81,-0.21],[-0.33,-0.02,0.94]],[],[["B_T_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_T_ghillie_tna_F",[13417.1,11990.5,3.8],198,[],"STAND",[]]
		],
		[
			["B_T_LSV_01_AT_F",[13426.4,11992.1,8.3],[[-0.01,-1,0.05],[-0.26,0.05,0.97]],[],[["B_T_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["O_Heli_Attack_02_dynamicLoadout_black_F",[13502,12156.7,3.4+1.3],[[0,1,-0.06],[-0.12,0.06,0.99]],[],[["B_Helipilot_F",["driver"],[],[]],["B_Helipilot_F",["turret",[0]],[],[]]]]
		],
		[
			[[13502.3,12156.6,0.00407553],"MOVE"],
			[[14443.9,12365.2,482.577],"MOVE"],
			[[12681,11499.5,444.881],"MOVE"],
			[[13758.1,13025.2,537.076],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_T_ghillie_tna_F",[13575.9,12198,3.7],235,[],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_AAA_System_01_F",[13613.7,12144.3,38.6],[[-1,0.06,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["O_Heli_Attack_02_dynamicLoadout_F",[13503.6,12201.4,7.7+1.3],[[0,1,0],[0,0,1]],[],[["B_Helipilot_F",["driver"],[],[]],["B_Helipilot_F",["turret",[0]],[],[]]]]
		],
		[
			[[13503.6,12201.5,4.88605],"MOVE"],
			[[14521.3,11695.7,703.68],"MOVE"],
			[[12609.1,12368.6,478.274],"MOVE"],
			[[14023.7,11148.1,613.002],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Soldier_SL_F",[13529.9,12179.8,0],0,[],"STAND",[]],
			["B_HeavyGunner_F",[13524.9,12174.8,0],0,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			//B ["B_soldier_M_F",[13519.9,12169.8,0],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[13525.5,12168.9,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[13530.2,12167.7,0],0,[],"STAND",[["arifle_MX_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetB_light_desert","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13529.9,12179.8,0.00258017],"MOVE"],
			[[13555.3,12242.5,-7.15256e-005],"MOVE"],
			[[13582.2,12177,0],"MOVE"],
			[[13543.1,12083.8,0],"MOVE"],
			[[13493.1,12104.7,9.53674e-007],"MOVE"],
			[[13522.4,12163,0.5],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Soldier_SL_F",[13528.2,12088.9,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			//B ["B_soldier_AR_F",[13533.2,12083.9,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_GL_F",[13523.2,12083.9,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AT_F",[13518.2,12078.9,0],0,[],"STAND",[["arifle_MXC_Holo_pointer_F","","acc_pointer_IR","optic_Holosight",["30Rnd_65x39_caseless_mag",30],[],""],["launch_B_Titan_short_F","","","",["Titan_AT",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_mcamo_AT",[["Titan_AT",2,1]]],"H_HelmetB_light_desert","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_medic_F",[13548.2,12068.9,0],0,[],"STAND",[]]
		],
		[],
		[
			[[13528.2,12088.9,0.000901222],"MOVE"],
			[[13501.2,12107.9,-0.000171661],"MOVE"],
			[[13519.7,12190.1,0],"MOVE"],
			[[13561,12197,0],"MOVE"],
			[[13537,12087.8,-9.53674e-007],"MOVE"],
			[[13482.1,12084.5,0],"MOVE"],
			[[13428.3,12008.1,0],"MOVE"],
			[[13465.9,11953.8,9.53674e-007],"MOVE"],
			[[13521.1,12015.2,0],"MOVE"],
			[[13526.8,12076.6,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_GL_F",[13469.5,12095.1,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Soldier_F",[13474.5,12090.1,0],0,[],"STAND",[]]
		],
		[],
		[
			[[13469.5,12095.1,0.0112419],"MOVE"],
			[[13600.4,12248.4,1.33514e-005],"MOVE"],
			[[13431,11918,2.67029e-005],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Soldier_TL_F",[13427.7,11898.1,0],0,[],"STAND",[["arifle_MX_GL_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			//B ["B_soldier_AR_F",[13432.7,11893.1,0],0,[],"STAND",[]],
			["B_Soldier_GL_F",[13422.7,11893.1,0],0,[],"STAND",[["arifle_MX_GL_ACO_F","","","optic_Aco",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["1Rnd_HE_Grenade_shell",5,1],["HandGrenade",2,1],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_HelmetSpecB_blk","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_LAT_F",[13428.1,11891.8,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13427.7,11898.1,0.0030508],"MOVE"],
			[[13415.8,11948.1,0.000296593],"MOVE"],
			[[13463.9,11904.1,4.95911e-005],"MOVE"],
			[[13433.7,11839.8,-0.000101089],"MOVE"],
			[[13365.5,11869.8,0.00021553],"MOVE"],
			[[13379.6,11925.1,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Soldier_SL_F",[13424.4,11885.9,0],0,[],"STAND",[["arifle_MX_Hamr_pointer_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierGL_rgr",[["30Rnd_65x39_caseless_mag",1,30],["30Rnd_65x39_caseless_mag_Tracer",2,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_desert","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			//B ["B_soldier_M_F",[13434.4,11875.9,0],0,[],"STAND",[]],
			["B_Soldier_A_F",[13409.4,11870.9,0],0,[],"STAND",[]],
			["B_medic_F",[13444.4,11865.9,0],0,[],"STAND",[["arifle_MX_pointer_F","","acc_pointer_IR","",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrierSpec_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_Medic",[["Medikit",1],["FirstAidKit",10]]],"H_HelmetB_light_desert","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13424.4,11885.9,0.00217724],"MOVE"],
			[[13391.8,11934.4,4.76837e-006],"MOVE"],
			[[13432.3,11968,1.04904e-005],"MOVE"],
			[[13481.5,11900.5,0],"MOVE"],
			[[13376.3,11768.7,0.000221252],"MOVE"],
			[[13293.2,11809.5,1.90735e-006],"MOVE"],
			[[13353.5,11905.7,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_sniper_F",[13277.5,11821.7,0],0,[],"STAND",[]],
			["B_spotter_F",[13282.5,11816.7,0],0,[],"STAND",[]]
		],
		[],
		[
			[[13277.5,11821.7,0.0100079],"MOVE"],
			[[13397.5,11765.5,0.000101089],"MOVE"],
			[[13477.1,11881.4,0.000271797],"MOVE"],
			[[13353.2,11928.6,5.91278e-005],"MOVE"],
			[[13277.5,11821.6,0.5],"MOVE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_recon_TL_F",[13617.3,12076.1,0],0,[],"STAND",[]],
			//B ["B_recon_M_F",[13622.3,12071.1,0],0,[],"STAND",[["arifle_MXM_DMS_LP_BI_snds_F","muzzle_snds_H","acc_pointer_IR","optic_DMS",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_Booniehat_mcamo","G_Tactical_Black",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_recon_medic_F",[13612.3,12071.1,0],0,[],"STAND",[["arifle_MXC_ACO_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_ReconMedic",[["Medikit",1],["FirstAidKit",5],["SmokeShellRed",1,1],["SmokeShellBlue",1,1],["SmokeShellOrange",1,1]]],"H_HelmetB_light","G_Tactical_Clear",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_recon_F",[13618.2,12069.4,0],0,[],"STAND",[["arifle_MX_ACO_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_Watchcap_camo","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13617.3,12076.1,0.000977516],"MOVE"],
			[[13602.8,12097.7,-0.000101089],"MOVE"],
			[[13555.3,12092.6,2.47955e-005],"MOVE"],
			[[13481.2,12011,0],"MOVE"],
			[[13523.2,11992,-4.76837e-007],"MOVE"],
			[[13581.5,12039.4,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Soldier_SL_F",[13653.5,12217.2,0],0,[],"STAND",[]],
			//B ["B_soldier_AR_F",[13658.5,12212.2,0],0,[],"STAND",[["arifle_MX_SW_pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_mag",100],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["100Rnd_65x39_caseless_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_M_F",[13663.5,12207.2,0],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_AT_F",[13643.5,12207.2,0],0,[],"STAND",[]]
		],
		[],
		[
			[[13653.5,12217.2,-0.00436211],"MOVE"],
			[[13697.8,12271.8,0],"MOVE"],
			[[13563.8,12303.5,0],"MOVE"],
			[[13531.7,12206,0],"MOVE"],
			[[13641.2,12164.8,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Officer_Parade_F",[13472.6,12036,16.0745],0,[1],"STAND",[[],[],[],["U_B_ParadeUniform_01_US_F",[]],[],[],"H_ParadeDressCap_01_US_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Officer_Parade_F",[13471.1,11989.5,15.3456],0,[1],"STAND",[[],[],[],["U_B_ParadeUniform_01_US_F",[]],[],[],"H_ParadeDressCap_01_US_F","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[
			["B_sniper_F",[13745.5,12329.6,0],0,[],"STAND",[]],
			["B_spotter_F",[13750.5,12324.6,0],0,[],"STAND",[]]
		],
		[],
		[
			[[13745.5,12329.6,-0.018569],"MOVE"],
			[[13712.5,12294.4,4.1008e-005],"MOVE"],
			[[13665.1,12361.4,0.000138283],"MOVE"],
			[[13761,12377.6,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Soldier_SL_F",[13714,12358.6,0],0,[],"STAND",[]],
			["B_HeavyGunner_F",[13709,12353.6,0],0,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_M_F",[13704,12348.6,0],0,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Sharpshooter_F",[13729,12343.6,0],0,[],"STAND",[["srifle_DMR_03_tan_AMS_LP_F","","acc_pointer_IR","optic_AMS_snd",["20Rnd_762x51_Mag",20],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["20Rnd_762x51_Mag",6,20],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Tactical_Clear",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13714,12358.6,0.020092],"MOVE"],
			[[13758,12361.4,0],"MOVE"],
			[[13741.3,12383.8,0],"MOVE"],
			[[13633.5,12383.1,0],"MOVE"],
			[[13636.3,12334.1,0],"MOVE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_diver_TL_F",[13432.7,12251.6,1.3],0,[],"STAND",[]],
			//B ["B_diver_F",[13427.7,12246.6,1.3],0,[],"STAND",[]],
			["B_diver_F",[13442.7,12241.6,1.2],0,[],"STAND",[]]
		],
		[
			//B ["B_T_APC_Tracked_01_AA_F",[13424.9,12231.3,4],[[-1,0.03,-0.01],[-0.01,0,1]],[1,2],[["B_T_Crew_F",["turret",[0]],[],[]]]],
			["B_T_MRAP_01_gmg_F",[13472.5,12158.1,4.2],[[0.88,-0.47,0],[0,0,1]],[1,2],[["B_T_Soldier_F",["turret",[0]],[],[]]]]
		],
		[
			[[13432.7,12251.6,1.25222],"MOVE"],
			[[13426.3,12304.4,1.14852],"MOVE"],
			[[13428.3,12236.6,1.37996],"MOVE"],
			[[13514.8,12232,1.19029],"MOVE"],
			[[13443.3,12250.8,0.0586465],"CYCLE"]
		]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["B_T_MBT_01_arty_F",[13536.4,12134.2,12.6],[[-0.14,-0.99,0.07],[-0.19,0.1,0.98]]],
	["B_T_Boat_Armed_01_minigun_F",[13438.1,12269,2.3],[[0,1,0.06],[0,-0.06,1]]],
	//["B_T_Truck_01_box_F",[13514.1,12116.7,13.4],[[0.9,-0.08,-0.42],[0.21,-0.78,0.59]]],
	["B_T_Truck_01_fuel_F",[13510.7,12117.9,10.3],[[0.22,0.96,-0.16],[-0.1,0.18,0.98]]],
	["B_T_Truck_01_covered_F",[13484.3,12238,3.3],[[-1,0.01,-0.01],[-0.01,0,1]]],
	["B_T_Truck_01_medical_F",[13496.9,12237.6,3.3],[[1,-0.05,-0.01],[0.01,0,1]]],
	["B_T_LSV_01_unarmed_F",[13584.9,12135.8,14.6],[[-0.97,0.21,0.1],[0.04,-0.25,0.97]]],
	["B_T_Truck_01_ammo_F",[13513.1,12105.4,12.2],[[0.98,-0.17,0.09],[-0.08,0.07,0.99]]],
	["B_T_Truck_01_fuel_F",[13425.8,12280.1,3.1],[[0.01,-1,0.01],[0,0.01,1]]],
	["B_Boat_Transport_01_F",[13449.7,12223.4,1.1],[[1,0,0.04],[-0.04,-0.01,1]]]
];
_doors = [];
_delete = [];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["Land_LightHouse_F",[13248.5,11713.7,32.56],[[0,1,0],[0,0,1]],true],
	["Land_Communication_F",[13317.4,11823.3,35.83],[[0,1,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",250,true];}],
	["Land_Cargo_Tower_V1_No1_F",[13310.3,11872.4,22.7],[[-0.79,0.62,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_SM_01_reservoirTower_F",[13321.2,11785.4,36.09],[[0,1,0],[0,0,1]],true],
	["Land_HBarrier_01_tower_green_F",[13339.2,11810.3,23.39],[[-1,-0.06,0],[0,0,1]],false],
	//["Land_Sea_Wall_F",[13407.3,12123.7,-2.12],[[-0.62,-0.78,0],[0,0,1]],false],
	//["Land_Sea_Wall_F",[13390,12152.7,-2.45],[[0.97,0.26,0],[0,0,1]],false],
	["Submarine_01_F",[13409.8,12310.5,0.26],[[-0.01,-1,0],[-0.01,0,1]],false],
	["Land_Cargo_House_V1_F",[13430.5,11876.9,15.76],[[0.61,-0.79,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[13424.5,11872.5,16.6],[[0.65,-0.76,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Patrol_V4_F",[13416.3,11991.9,9.31],[[0.44,0.9,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Pier_F",[13430.2,12246.4,-3.4],[[1,0,0],[0,0,1]],false],
	["Land_LampAirport_F",[13434,12265.2,13.64],[[-1,0.01,0],[0,0,1]],true],
	["Land_WarehouseShelter_01_F",[13434.1,12279.5,3.77],[[1,0,0],[0,0,1]],false],
	["Land_Destroyer_01_Boat_Rack_01_F",[13431.8,12279.5,0.72],[[0,1,0],[0,0,1]],false],
	["Land_Destroyer_01_Boat_Rack_01_F",[13431.7,12270.8,0.73],[[0,1,0],[0,0,1]],false],
	["Land_Pier_F",[13430.1,12288,-3.37],[[1,0,0],[0,0,1]],false],
	["Land_Cargo_House_V1_F",[13429.9,12291.4,1.94],[[1,0.01,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[13430,12304.1,1.94],[[1,0,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_No1_F",[13440.4,11861.4,28.28],[[-0.97,0.25,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampAirport_F",[13453,11978.5,25.34],[[0,1,0],[0,0,1]],true],
	["Land_LampAirport_F",[13458,12050.4,24.77],[[0,1,0],[0,0,1]],true],
	["Land_ReservoirTower_F",[13443.4,12100.5,17.33],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampAirport_F",[13463.8,12119,16.11],[[0,1,0],[0,0,1]],true],
	["Land_RepairDepot_01_green_F",[13459.8,12228.2,3.62],[[-1,0.03,0],[0,0,1]],true],
	["Land_WarehouseShelter_01_F",[13445.9,12227.3,4.04],[[0.01,-1,0],[0,0,1]],false],
	["Land_Destroyer_01_Boat_Rack_01_F",[13449.6,12229.1,0.68],[[0,1,0],[0,0,1]],false],
	["Land_Destroyer_01_Boat_Rack_01_F",[13442.4,12230,0.68],[[0,1,0],[0,0,1]],false],
	["Land_Pier_F",[13456.2,12235.6,-3.43],[[0,1,0],[0,0,1]],false],
	["Land_MobileCrane_01_hook_F",[13442.1,12247.6,24.39],[[0,1,0],[0,0,1]],false],
	["Land_Pier_F",[13456,12246.1,-3.39],[[0,-1,0],[0,0,1]],false],
	["Land_dp_bigTank_F",[13468,12246.4,4.16],[[0.75,-0.66,0],[0,0,1]],true],
	["Submarine_01_F",[13444.9,12329.7,0.61],[[0,1,0],[0.01,0,1]],false],
	["Land_Cargo_Patrol_V4_F",[13479,11956.7,18.7],[[0.27,0.96,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampAirport_F",[13475.1,12013.2,24.78],[[0,1,0],[0,0,1]],true],

	["Land_StorageTank_01_small_F",[13471.2,11988.7,24.50],[[0,1,0],[0,0,1]],true,{_this setVariable ["brpvp_c4_to_destroy",2,true];_this setVariable ["brpvp_c4_money",8000000,true];_this setVariable ["brpvp_c4_radio",50,true];_this call BRPVP_pmissAddExplodeIcon;BRPVP_pmissEndCheckObjects pushBack _this;}],
	["Land_StorageTank_01_small_F",[13472.6,12035.6,22.88],[[0,1,0],[0,0,1]],true,{_this setVariable ["brpvp_c4_to_destroy",2,true];_this setVariable ["brpvp_c4_money",8000000,true];_this setVariable ["brpvp_c4_radio",50,true];_this call BRPVP_pmissAddExplodeIcon;BRPVP_pmissEndCheckObjects pushBack _this;}],
	//["Land_Target_Concrete_Support_01_F",[13467.8,11973.2,14.25],[[-0.95,0.3,0],[0,0,-1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],
	//["Land_Target_Concrete_Support_01_F",[13469.2,11972.9,14.27],[[0.99,-0.16,0],[0,0,-1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],
	//["Land_Target_Concrete_Support_01_F",[13467.9,12020.4,13.88],[[0.95,-0.31,0],[0,0,-1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],
	//["Land_Target_Concrete_Support_01_F",[13466.6,12020.9,13.88],[[-0.9,0.45,0],[0,0,-1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],
	//["Land_Target_Concrete_Support_01_F",[13467.8,11973.2,13.25],[[-0.95,0.3,0],[0,0,1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],
	//["Land_Target_Concrete_Support_01_F",[13469.2,11972.9,13.27],[[0.99,-0.16,0],[0,0,1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],
	//["Land_Target_Concrete_Support_01_F",[13467.9,12020.4,12.88],[[0.95,-0.31,0],[0,0,1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],
	//["Land_Target_Concrete_Support_01_F",[13466.6,12020.9,12.88],[[-0.9,0.45,0],[0,0,1]],false,{_this setVariable ["brpvp_allow_sjump",false,true];}],

	["Land_PierConcrete_01_16m_F",[13488.8,12149.6,-3.3],[[0.88,-0.47,0],[0,0,1]],false],
	["Land_Cargo_Patrol_V1_F",[13477.7,12134.8,6.08],[[0.4,-0.92,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_PierConcrete_01_16m_F",[13474.7,12157.1,-3.32],[[-0.88,0.47,0],[0,0,1]],false],
	["Land_SewerCover_02_F",[13478.9,12231,1.21],[[0,1,0],[0,0,1]],false],
	["Land_SewerCover_02_F",[13485,12231.2,1.21],[[0,1,0],[0,0,1]],false],
	["Land_FuelStation_Feed_F",[13479.3,12226.7,2.2],[[0,1,0],[0,0,1]],true],
	["Land_FuelStation_Feed_F",[13483.2,12226.7,2.2],[[0,1,0],[0,0,1]],true],
	["Land_Pier_F",[13487,12235.5,-3.47],[[0,1,0],[0,0,1]],false],
	["Land_fs_roof_F",[13481.4,12226.7,3.59],[[0,1,0],[0,0,1]],true],
	//["Land_DPP_01_waterCooler_F",[13523.7,12027.2,13.67],[[-0.39,-0.92,0],[0,0,1]],false],
	//["Land_SCF_01_crystallizerTowers_F",[13527.4,12040.8,26.14],[[-0.93,0.37,0],[0,0,1]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13514.2,12089.7,12.3],[[0.2,0.98,-0.03],[-0.19,0.07,0.98]],true],
	["Land_Communication_F",[13514.8,12065.9,29.27],[[0,1,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",250,true];}],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13502.9,12092.6,10.79],[[0.21,0.98,0],[-0.04,0.01,1]],true],
	//["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13514.9,12139.6,5.64],[[-0.14,-0.98,0.11],[-0.15,0.13,0.98]],false],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13528.5,12138.4,8.85],[[0.2,0.97,-0.1],[-0.19,0.14,0.97]],true],
	["Land_AirConditioner_04_F",[13509.7,12142.9,3.61],[[-0.58,-0.81,-0.03],[-0.15,0.06,0.99]],false],
	//["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13516.9,12157.6,4.57],[[-0.03,-1,0.04],[-0.12,0.04,0.99]],false],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13528.6,12157.2,7.48],[[0,1,0],[-0.34,0,0.94]],true],
	["Land_HelipadRescue_F",[13502,12157.3,1.26],[[-0.99,0.03,-0.12],[-0.12,0.05,0.99]],false],
	["Land_Airport_02_terminal_F",[13500.6,12202.1,3.01],[[-1,0,0],[0,0,1]],false],
	["WaterPump_01_forest_F",[13525.3,12183.7,5.65],[[0,1,0],[-0.28,0,0.96]],false],
	["Land_ControlTower_01_F",[13521,12237.3,11.88],[[0.01,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampAirport_F",[13513.4,12239.6,14.88],[[0,1,0],[0,0,1]],true],
	["Land_Sea_Wall_F",[13500.2,12249.8,-2.12],[[0,1,0],[0,0,1]],false],
	//["Land_SCF_01_clarifier_F",[13531,12009.8,15.97],[[0.88,-0.48,0],[0,0,1]],false],
	["Land_SCF_01_condenser_F",[13543.3,12055,17.88],[[0.93,-0.38,0],[0,0,1]],false],
	["Land_SCF_01_crystallizerTowers_F",[13537.2,12036.7,25.11],[[-0.93,0.38,0],[0,0,1]],true],
	["Land_LampAirport_F",[13535.3,12058.8,25.8],[[0,1,0],[0,0,1]],true],
	["Land_Cargo_House_V1_F",[13531.1,12113.4,13.76],[[1,-0.08,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[13530.1,12103.5,13.91],[[1,-0.08,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13542.1,12157.3,12.84],[[0,1,0.02],[-0.3,-0.02,0.95]],true],
	["Land_AirConditioner_03_F",[13530.5,12150.9,7.32],[[0.01,-1,0],[-0.4,0,0.92]],false],
	["Land_AirConditioner_03_F",[13547.7,12153.6,13.31],[[0.98,-0.01,0.19],[-0.19,-0.02,0.98]],false],
	["Land_Cargo_House_V1_F",[13558.5,12157.6,15.95],[[1,-0.08,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[13559.2,12166.3,16.23],[[1,-0.08,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_MedicalTent_01_NATO_tropic_generic_closed_F",[13542.6,12185.8,11.89],[[-0.05,-1,0.03],[-0.35,0.04,0.94]],true],
	["Land_MedicalTent_01_NATO_tropic_generic_outer_F",[13532.3,12186.2,8.27],[[0,1,-0.03],[-0.29,0.03,0.96]],true],
	["Land_Cargo_HQ_V1_F",[13571,12100.9,20.12],[[0.1,1,0],[0,0,1]],true],
	["O_CargoNet_01_ammo_F",[13564.3,12105,16.71],[[0,1,-0.05],[-0.08,0.05,1]],false],
	["CargoNet_01_barrels_F",[13564.2,12107.4,16.24],[[0,1,-0.07],[-0.09,0.07,0.99]],false],
	["Land_LampAirport_F",[13584.1,12117.1,27.34],[[0,1,0],[0,0,1]],true],
	["WaterPump_01_forest_F",[13585.4,12142.2,15.12],[[0,0.97,0.23],[0.06,-0.23,0.97]],false],
	["Land_TankEngine_01_used_F",[13584.4,12131.5,12.76],[[1,-0.07,-0.07],[0.06,-0.05,1]],false],
	["Land_AirConditioner_04_F",[13586.6,12149,15.71],[[-0.87,-0.47,-0.12],[-0.01,-0.22,0.98]],false],
	["Land_WaterTank_02_F",[13568.7,12178.3,17.37],[[1,-0.06,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_House_V1_F",[13560.1,12174.5,15.34],[[1,-0.08,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["CamoNet_BLUFOR_open_F",[13567.8,12199.3,16.23],[[0.1,1,0],[0.02,0,1]],true],
	["Land_Cargo_House_V1_F",[13560.6,12182.6,15.33],[[1,-0.08,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LampAirport_F",[13561.4,12217.5,28.73],[[0,1,0],[0,0,1]],true],
	["Land_Cargo_Tower_V1_No1_F",[13604.5,12066.4,25.18],[[0.14,0.99,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13593.8,12145.5,15.72],[[-1,0.03,0.04],[0.03,-0.22,0.97]],true],
	["CamoNet_BLUFOR_open_F",[13593.2,12132.5,12.86],[[1,0.02,-0.02],[0.02,-0.09,1]],true],
	["Land_ReservoirTower_F",[13614.1,12144.4,23.81],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13616.2,12178.5,18.55],[[0.92,-0.39,0.04],[-0.02,0.04,1]],true],
	["Land_ControlTower_02_F",[13597.3,12162.1,26.85],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["C_IDAP_CargoNet_01_supplies_F",[13597.7,12170.8,17.54],[[0,1,-0.01],[-0.04,0.01,1]],false],
	["CargoNet_01_barrels_F",[13601.5,12170.8,17.46],[[0,1,0.01],[-0.07,-0.01,1]],false],
	["Land_LampAirport_F",[13614.6,12167.5,29.94],[[0,1,0],[0,0,1]],true],
	["CamoNet_BLUFOR_open_F",[13600.9,12187.1,16.91],[[0.9,0.44,-0.08],[0.03,0.12,0.99]],true],
	["Land_Communication_F",[13607.2,12230,30.42],[[0,1,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",250,true];}],
	["Land_Cargo_Tower_V1_No1_F",[13590.3,12321.7,21.7],[[0.79,-0.61,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_MedicalTent_01_NATO_tropic_generic_inner_F",[13621.3,12195.8,16.36],[[0.92,-0.39,0.03],[0,0.06,1]],true],
	["Land_i_Barracks_V1_F",[13628.1,12223.2,13.31],[[0.87,-0.49,0],[0,0,1]],true],
	//["Land_i_Barracks_V1_F",[13628.5,12256.8,16.07],[[-0.48,-0.88,0],[0,0,1]],false],
	["Land_SM_01_reservoirTower_F",[13645.1,12294.9,33.39],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_LightHouse_F",[13671.2,12357.5,23.11],[[0,1,0],[0,0,1]],true],
	["Land_Cargo_Tower_V1_No1_F",[13723.4,12337.8,30.15],[[0,1,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}]
];

private _ata = [];
private _nos = [];
private _ts = [];
private _vd = [];
private _hide = [];
private _noLagWait = 0.1;
{
	_x params ["_class","_pw","_vdu","_complete",["_code",{}]];
	private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};

	//DELETE STUFF ARROUND
	private _bb = boundingBoxReal _obj;
	private _rad = 7.5+((_bb select 0) distance2D (_bb select 1))/2;
	{
		private _o = _x;
		_noOwner = (_o getVariable ["own",-1]) isEqualTo -1;
		if ({str _o find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {
			[_o,false] remoteExecCall ["allowDamage",0];
			[_o,true] remoteExecCall ["hideObjectGlobal",2];
			_hide pushBack _o;
		};
	} forEach nearestObjects [ASLToAGL _pw,[],_rad];
	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_obj call _code;
	_nos pushBack _obj;
	uiSleep _noLagWait;
	if (_complete && isDamageAllowed _obj) then {_obj setVariable ["brpvp_yes_minerva",true,true];};
} forEach _pmissBuildings;
{
	_x addEventHandler ["HandleDamage",{
		params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
		private _damNow = if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};
		private _deltaDam = _dam-_damNow;
		_damNow+_deltaDam*0.25
	}];
} forEach _pmissBuildingsEh;
{
	_x params ["_class","_posW","_vdu"];
	private _hmg = createVehicle [_class,[0,0,0],[],0,"CAN_COLLIDE"];
	_hmg setVectorDirAndUp _vdu;
	_hmg setposWorld _posW;
	_hmg setVariable ["own",-2,true];
	_hmg setVariable ["stp",4,true];
	_hmg setVariable ["amg",[[],[],false],true];
	_hmg remoteExecCall ["BRPVP_setTurretOperator",2];
	_hmg setVariable ["brpvp_dead_delete",true,2];
	_ts pushBack _hmg;
	uiSleep _noLagWait;
} forEach _pmissBaseTurrets;
{
	_x params ["_class","_pw","_vdu",["_flags",[]]];
	//private _obj = createSimpleObject [_class,[0,0,0]];
	private _obj = createVehicle [_class,BRPVP_posicaoFora,[],100,"NONE"];
	_obj call BRPVP_emptyBox;

	//DELETE STUFF ARROUND
	private _bb = boundingBoxReal _obj;
	private _rad = 7.5+((_bb select 0) distance2D (_bb select 1))/2;
	{
		private _o = _x;
		_noOwner = (_o getVariable ["own",-1]) isEqualTo -1;
		if ({str _o find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {
			[_o,false] remoteExecCall ["allowDamage",0];
			[_o,true] remoteExecCall ["hideObjectGlobal",2];
			_hide pushBack _o;
		};
	} forEach nearestObjects [ASLToAGL _pw,[],_rad];

	_obj setVectorDirAndUp _vdu;
	_obj setPosWorld (_pw vectorAdd _pFix);
	_vd pushBack _obj;
	_obj call BRPVP_initPlayerMissionSceneryVehicles;
	uiSleep _noLagWait;
} forEach _pmissEmptyVehs;

{
	_x params ["_side","_wps","_onFoot","_onVeh","_wps2"];
	private _grp = createGroup [_side,true];
	{
		_x params ["_class","_AGL","_dir","_flags","_stance","_gear"];
		if (random 1 <= BRPVP_pmissAiPerc || 2 in _flags) then {
			private _u = _grp createUnit [_class,_AGL vectorAdd _pFix2D,[],0,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u setDir _dir;
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			if (2 in _flags) then {
				_u setVariable ["brpvp_can_ulfanize",false,2];
				_u setVariable ["brpvp_extra_chance",10];
				_u addEventHandler ["Killed",{
					private _pos = getPosASL (_this select 0) vectorAdd [0,0,1.25];
					private _suitCase = createVehicle ["Land_Suitcase_F",[0,0,0],[],0,"CAN_COLLIDE"];
					_suitCase setPosASL _pos;
					_suitCase setVariable ["mny",round (12500000*BRPVP_missionValueMult),true];
					_this call BRPVP_botDaExp;
				}];
			} else {
				_u setVariable ["brpvp_extra_chance",2];
				_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			};
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			BRPVP_pmissActualAiUnits pushBack _u;
			if (_gear isNotEqualTo []) then {_u setUnitLoadout _gear;};
			if (primaryWeapon _u isEqualTo "" || _wps isNotEqualTo [] || _wps2 isNotEqualTo []) then {
				_u setUnitPos _stance;
			} else {
				private _anim = if (_stance isEqualTo "STAND") then {
					selectRandom ["STAND","STAND_IA","WATCH","WATCH1","WATCH2"]
				} else {
					if (_stance isEqualTo "CROUCH") then {
						selectRandom ["KNEEL","KNEEL","SIT_LOW"]
					} else {
						if (_stance isEqualTo "PRONE") then {"LEAN"} else {"STAND_IA"};
					};
				};
				[_u,_anim] call BIS_fnc_ambientAnimCombat;
			};
			if (1 in _flags) then {
				_u disableAI "PATH";
				_u disableAI "FSM";
			};
			uiSleep _noLagWait;
		};
	} forEach _onFoot;
	{
		_x params ["_class","_pw","_vdu","_flags","_crew"];
		private _st = if (3 in _flags) then {"FLY"} else {"CAN_COLLIDE"};
		private _veh = createVehicle [_class,[0,0,0],[],10,_st];

		//DELETE STUFF ARROUND
		private _bb = boundingBoxReal _veh;
		private _rad = 7.5+((_bb select 0) distance2D (_bb select 1))/2;
		{
			private _o = _x;
			_noOwner = (_o getVariable ["own",-1]) isEqualTo -1;
			if ({str _o find _x > -1} count BRPVP_removeFromMap > 0 && _noOwner) then {
				[_o,false] remoteExecCall ["allowDamage",0];
				[_o,true] remoteExecCall ["hideObjectGlobal",2];
				_hide pushBack _o;
			};
		} forEach nearestObjects [ASLToAGL _pw,[],_rad];

		_veh setVectorDirAndUp _vdu;
		_veh setPosWorld (_pw vectorAdd _pFix);
		_veh addEventHandler ["GetIn",{_this call BRPVP_carroBotGetIn;}];
		if (_veh isKindOf "StaticWeapon") then {
			_veh addEventHandler ["HandleDamage",{
				params ["_veh","_part","_dam","_source","_proj","_hitIndex","_instigator","_hitPoint"];
				private _sameSide = side _instigator isEqualTo side _veh;
				if (_sameSide) then {if (_part isEqualTo "") then {damage _veh} else {_veh getHit _part};} else {_dam};
			}];
		} else {
			_veh remoteExecCall ["BRPVP_veiculoEhReset",2];
		};
		{
			_x params ["_class","_roleArray","_flags",["_gear",[]]];
			_roleArray params ["_role",["_path",[]]];
			private _u = _grp createUnit [_class,[0,0,0],[],10,"CAN_COLLIDE"];
			[_u] joinSilent _grp;
			_ata pushBack _u;
			_u addEventHandler ["Killed",{_this call BRPVP_botDaExp;}];
			_u addEventHandler ["HandleDamage",{_this call BRPVP_hdeh}];
			_u setSkill (_skill select 0);
			_u setSkill ["aimingAccuracy",_skill select 1];
			if (_gear isNotEqualTo []) then {_u setUnitLoadout _gear;};
			if (_role isEqualTo "driver") then {_u moveInDriver _veh;};
			if (_role isEqualTo "turret") then {_u moveInTurret [_veh,_path];};
			if (_role isEqualTo "cargo") then {_u moveInCargo _veh;};
			if (1 in _flags) then {_u disableAI "PATH";};
			if (_veh isKindOf "StaticWeapon") then {
				private _dir = [[0,0,0],_vdu select 0] call BIS_fnc_dirTo;
				_u doWatch (getPosASL _veh vectorAdd [100*sin _dir,100*cos _dir,3]);
				BRPVP_pmissActualAiUnits pushBack _u;
			};
		} forEach _crew;
		if (1 in _flags) then {_veh lock true;};
		if (2 in _flags) then {_veh setVariable ["brpvp_cant_heli_town",true,true];};
		if (4 in _flags) then {_veh setUnloadInCombat [true,false];};
		_vd pushBack _veh;
		uiSleep _noLagWait;
	} forEach _onVeh;
	if (count units _grp > 0) then {
		if (_wps isNotEqualTo []) then {
			{
				_wp = _grp addWayPoint [_x vectorAdd _pFix2D,0];
				_wp setWayPointType "MOVE";
				_wp setWaypointCompletionRadius 5;
			} forEach _wps;
			_wp = _grp addWayPoint [(_wps select 0) vectorAdd _pFix2D,0];
			_wp setWayPointType "CYCLE";
			_wp setWaypointCompletionRadius 5;
		} else {
			if (_wps2 isNotEqualTo []) then {
				{
					_wp = _grp addWayPoint [(_x select 0) vectorAdd _pFix2D,0];
					_wp setWayPointType (_x select 1);
					_wp setWaypointCompletionRadius 5;
				} forEach _wps2;
			};
		};
	};
	uiSleep _noLagWait;
} forEach _pmissGroups;

//RARE LOOT
{
	_x params ["_posW","_dir","_q"];
	private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
	_box allowDamage false;
	_box setPosWorld (_posW vectorAdd _pFix);
	_box setDir _dir;
	[_box,0,1,true,_q] call BRPVP_createCompleteLootBox;
	uiSleep _noLagWait;
} forEach [
	[[13465.5,12012.9,12.3124],random 360,45],
	[[13275.3,11769.7,18.7717],random 360,35],
	[[13614.8,12246.7,15.4903],random 360,35]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,_hide,{{isObjectHidden _x || isNull _x} count _this isEqualTo count _this}];
BRPVP_pmissSpawning = false;