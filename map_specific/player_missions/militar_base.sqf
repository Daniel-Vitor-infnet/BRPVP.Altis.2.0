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
	[
		WEST,
		[],
		[],
		[
			["B_APC_Tracked_01_AA_F",[13866.6,17754.7,16.9],[[-0.35,-0.94,0.03],[0.03,0.02,1]],[1,2,4],[["B_crew_F",["turret",[0]],[],[]]]],
			["B_APC_Tracked_01_AA_F",[13865.3,17768.5,16.9],[[0.34,0.94,-0.03],[-0.02,0.04,1]],[1,2,4],[["B_crew_F",["turret",[0]],[],[]]]]
			//["B_MRAP_01_hmg_F",[13893.1,17771.4,16.8],[[-0.94,0.34,0],[-0.01,-0.01,1]],[1,2],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//["B_MRAP_01_hmg_F",[13837.1,17704.4,16.7],[[0.34,0.94,0.01],[-0.02,-0.01,1]],[1,2],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13895.5,17749.3,33.5],[[0.38,-0.93,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_HMG_01_high_F",[13897.8,17755,33.5],[[0.99,0.11,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_F",[13883.8,17760.7,15.2],[[-0.52,0.85,-0.01],[0.01,0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_F",[13883.8,17751.5,15.3],[[-0.52,-0.86,0],[0.01,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13918.5,17816.1,33.7],[[0.97,0.25,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[13912.3,17813,35.6],[[0.34,0.94,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_GMG_01_high_F",[13908.6,17811.1,33.7],[[-0.95,-0.33,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[13917.8,17808.9,33.6],[[0.9,-0.44,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[13912.6,17818.5,33.7],[[-0.14,0.99,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13856.8,17839.3,34.3],[[-0.46,0.89,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_HMG_01_high_F",[13863.5,17836.8,34.3],[[0.92,0.39,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_F",[13873.8,17824.2,16],[[-0.45,-0.89,-0.01],[0,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13770.3,17798.5,34.2],[[-0.48,0.88,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_G_HMG_02_high_F",[13768.3,17792.4,34.2],[[-0.99,-0.1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13780.8,17777.4,19.1],[[0.85,-0.53,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			//B ["B_HeavyGunner_F",[13895.1,17799.1,0.7],173,[1],"STAND",[["SMG_02_F","muzzle_snds_L","acc_flashlight","optic_Hamr",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_C_FormalSuit_01_tshirt_gray_F",[["FirstAidKit",1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_TacVest_blk",[["FirstAidKit",1],["30Rnd_9x21_Mag_SMG_02",6,30],["11Rnd_45ACP_Mag",3,11],["Chemlight_red",2,1],["SmokeShellOrange",1,1]]],[],"H_WirelessEarpiece_F","G_AirPurifyingRespirator_01_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			//B ["B_HeavyGunner_F",[13898.1,17788.9,3.2],116,[1],"STAND",[["SMG_02_F","muzzle_snds_L","acc_flashlight","optic_Hamr",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_C_FormalSuit_01_tshirt_gray_F",[["FirstAidKit",1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_TacVest_blk",[["FirstAidKit",1],["30Rnd_9x21_Mag_SMG_02",6,30],["11Rnd_45ACP_Mag",3,11],["Chemlight_red",2,1],["SmokeShellOrange",1,1]]],[],"H_WirelessEarpiece_F","G_AirPurifyingRespirator_01_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_HeavyGunner_F",[13895.8,17788.1,0.8],326,[1],"STAND",[["SMG_02_F","muzzle_snds_L","acc_flashlight","optic_Hamr",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_C_FormalSuit_01_tshirt_gray_F",[["FirstAidKit",1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_TacVest_blk",[["FirstAidKit",1],["30Rnd_9x21_Mag_SMG_02",6,30],["11Rnd_45ACP_Mag",3,11],["Chemlight_red",2,1],["SmokeShellOrange",1,1]]],[],"H_WirelessEarpiece_F","G_AirPurifyingRespirator_01_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_HeavyGunner_F",[13895.4,17796.7,3.1],11,[1],"STAND",[["SMG_02_F","muzzle_snds_L","acc_flashlight","optic_Hamr",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_C_FormalSuit_01_tshirt_gray_F",[["FirstAidKit",1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_TacVest_blk",[["FirstAidKit",1],["30Rnd_9x21_Mag_SMG_02",6,30],["11Rnd_45ACP_Mag",3,11],["Chemlight_red",2,1],["SmokeShellOrange",1,1]]],[],"H_WirelessEarpiece_F","G_AirPurifyingRespirator_01_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_HeavyGunner_F",[13902.1,17796.4,0.7],199,[1,2],"STAND",[[],[],[],["U_C_Scientist",[["FirstAidKit",1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],[],"H_Construction_earprot_vrana_F","G_RegulatorMask_F",[],["ItemMap","","ItemRadio","ItemCompass","ChemicalDetector_01_watch_F",""]]],
			["B_HeavyGunner_F",[13904.1,17795.7,0.7],199,[1,2],"STAND",[[],[],[],["U_C_Scientist",[["FirstAidKit",1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],[],[],"H_Construction_earprot_vrana_F","G_RegulatorMask_F",[],["ItemMap","","ItemRadio","ItemCompass","ChemicalDetector_01_watch_F",""]]],
			["B_HeavyGunner_F",[13891.9,17789.6,0.9],11,[1],"STAND",[["SMG_02_F","muzzle_snds_L","acc_flashlight","optic_Hamr",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],["hgun_Pistol_heavy_01_green_F","muzzle_snds_acp","acc_flashlight_pistol","optic_MRD_black",["11Rnd_45ACP_Mag",11],[],""],["U_C_FormalSuit_01_tshirt_gray_F",[["FirstAidKit",1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_TacVest_blk",[["FirstAidKit",1],["30Rnd_9x21_Mag_SMG_02",6,30],["11Rnd_45ACP_Mag",3,11],["Chemlight_red",2,1],["SmokeShellOrange",1,1]]],[],"H_WirelessEarpiece_F","G_AirPurifyingRespirator_01_F",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			//["B_Radar_System_01_F",[13832.4,17705.6,16.8],[[0.34,0.94,0.01],[-0.02,-0.01,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_Heli_Light_01_dynamicLoadout_F",[13804.3,17827.3,16.6],[[0.34,0.94,0.02],[0.01,-0.02,1]],[],[["B_Helipilot_F",["driver"],[],[]]]],
			["B_Heli_Light_01_dynamicLoadout_F",[13832.4,17816.5,16.6],[[0.34,0.94,0.03],[0.01,-0.04,1]],[],[["B_Helipilot_F",["driver"],[],[]]]]
		],
		[
			[[13804.2,17827.4,0.000277519],"MOVE"],
			[[13731.1,18234.1,1.90735e-006],"MOVE"],
			[[14294.9,17941.4,1.90735e-006],"MOVE"],
			[[13896.9,17329.4,9.53674e-007],"MOVE"],
			[[13344,17641.6,0],"MOVE"],
			[[13471.1,18014.1,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Patrol_HeavyGunner_F",[13790.4,17849.9,0],262,[],"STAND",[]],
			["B_Patrol_Soldier_M_F",[13793.4,17848.8,0.2],320,[],"STAND",[]]
		],
		[
			["B_G_HMG_02_F",[13793.8,17848.8,21.4],[[-0.53,0.85,0.01],[0.03,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_HMG_01_high_F",[13789.6,17852.7,17.2],[[-0.3,0.95,0.02],[0.04,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[13803.9,17851.6,16.3],[[0.45,0.89,0.06],[0,-0.06,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_HeavyGunner_F",[13773.1,17757.5,0],108,[1],"STAND",[]],
			["B_HeavyGunner_F",[13775.1,17762.8,0],110,[1],"STAND",[]],
			//B ["B_support_GMG_F",[13818,17746.3,0],283,[1],"STAND",[]],
			["B_support_GMG_F",[13816.7,17742.2,0],285,[1],"STAND",[]]
		],
		[
			["B_HMG_01_high_F",[13771.8,17761,16.2],[[0.92,-0.4,-0.02],[0.01,-0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13810.2,17747.3,16],[[-0.94,0.33,0.02],[0.03,0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_static_AT_F",[13823.5,17736.2,15],[[0.78,-0.63,-0.02],[-0.01,-0.04,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_F",[13778.9,17741.7,15.9],[[0.87,-0.48,0.01],[-0.01,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Patrol_HeavyGunner_F",[13843.5,17688.9,0],127,[1],"STAND",[]]
		],
		[
			//B ["B_HMG_01_high_F",[13873.3,17692,33.3],[[0.95,0.31,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13869.3,17684.4,33.3],[[0.35,-0.94,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_GMG_01_high_F",[13864.5,17695,33.3],[[-0.42,0.91,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[13863.4,17686.9,33.3],[[-0.94,-0.34,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_G_HMG_02_F",[13853,17695.6,15],[[0.5,-0.87,-0.02],[0.01,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[13843.2,17676.5,14.6],[[-0.34,-0.94,0.02],[0.04,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13843.2,17665.1,15.3],[[-0.31,-0.95,0],[0.03,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13853.5,17661.5,15.2],[[-0.31,-0.95,-0.01],[0,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[13860.3,17670.6,14.4],[[-0.34,-0.94,-0.02],[-0.01,-0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_F",[13867.4,17693.8,15],[[-0.95,-0.33,0],[-0.01,0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_GMG_01_F",[13840.5,17692,19.6],[[-0.38,-0.93,-0.01],[0.01,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[13836.4,17688.3,15.6],[[-1,-0.1,0.01],[0.01,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[13746.3,17732.4,35.6],[[-0.99,-0.12,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_HMG_01_high_F",[13748.4,17738.3,35.6],[[-0.33,0.94,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[13751.4,17732.5,37.6],[[-0.96,-0.3,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_GMG_01_high_F",[13755.9,17737.3,35.6],[[0.34,0.94,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[13753.8,17728.3,35.7],[[0.31,-0.95,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_AAA_System_01_F",[13871.3,17795.1,23.9],[[0.38,0.93,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			//["B_recon_M_F",[13851.9,17787.6,0],184,[],"STAND",[["arifle_MXM_DMS_LP_BI_snds_F","muzzle_snds_H","acc_pointer_IR","optic_DMS",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_Booniehat_mcamo","G_Tactical_Clear",["Rangefinder","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_recon_LAT_F",[13856.3,17784.1,0],184,[],"STAND",[["arifle_MX_ACO_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_tshirt",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_ReconLAT",[["NLAW_F",2,1]]],"H_HelmetB_plain_mcamo","G_Combat",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_recon_JTAC_F",[13862.3,17783.4,0],184,[],"STAND",[["arifle_MX_GL_Holo_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Holosight",["30Rnd_65x39_caseless_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["B_IR_Grenade",2,1],["1Rnd_HE_Grenade_shell",5,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_Smoke_Grenade_shell",2,1],["1Rnd_SmokeBlue_Grenade_shell",1,1],["1Rnd_SmokeGreen_Grenade_shell",1,1],["1Rnd_SmokeOrange_Grenade_shell",1,1]]],[],"H_Watchcap_camo","G_Combat",["Laserdesignator","","","",["Laserbatteries",1],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			//B ["B_HeavyGunner_F",[13850.3,17779.6,0],284,[],"STAND",[["MMG_02_sand_RCO_LP_F","","acc_pointer_IR","optic_Hamr",["130Rnd_338_Mag",130],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",2,1]]],["V_PlateCarrier1_rgr",[["130Rnd_338_Mag",2,130]]],[],"H_HelmetB","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_soldier_M_F",[13858.6,17777.1,0],284,[],"STAND",[["arifle_MXM_Hamr_LP_BI_F","","acc_pointer_IR","optic_Hamr",["30Rnd_65x39_caseless_mag",30],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["30Rnd_65x39_caseless_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_HelmetB_grass","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			["B_Sharpshooter_F",[13859.6,17788.8,0],284,[],"STAND",[["srifle_DMR_03_tan_AMS_LP_F","","acc_pointer_IR","optic_AMS_snd",["20Rnd_762x51_Mag",20],[],"bipod_01_F_snd"],[],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["20Rnd_762x51_Mag",1,20],["Chemlight_green",1,1]]],["V_PlateCarrier1_rgr",[["20Rnd_762x51_Mag",6,20],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["HandGrenade",2,1]]],[],"H_HelmetB","G_Combat",["Binocular","","","",[],[],""],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13856.3,17784.1,0.00196648],"MOVE"],
			[[13835.9,17620.8,9.53674e-007],"MOVE"],
			[[13984.9,17638.9,-9.53674e-007],"MOVE"],
			[[13972.3,17897.1,9.53674e-007],"MOVE"],
			[[13716.8,17969.3,-1.90735e-006],"MOVE"],
			[[13670,17653.6,47.4156],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//B ["B_recon_TL_F",[13854.4,17708.1,0],275,[],"STAND",[]],
			["B_recon_exp_F",[13859.8,17712.6,0],275,[],"STAND",[]],
			["B_recon_exp_F",[13858.9,17702.6,0],275,[],"STAND",[]],
			["B_recon_F",[13865.2,17717.1,0],275,[],"STAND",[["arifle_MX_ACO_pointer_snds_F","muzzle_snds_H","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],[],["hgun_P07_snds_F","muzzle_snds_L","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam_vest",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_mag",7,30],["16Rnd_9x21_Mag",2,16],["MiniGrenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],[],"H_Watchcap_camo","G_Combat",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]]
		],
		[],
		[
			[[13854.4,17708.1,0.00203228],"MOVE"],
			[[13777.4,17737.8,0],"MOVE"],
			[[13840.8,17759.4,0],"MOVE"],
			[[13881.8,17741.8,0],"MOVE"],
			[[13866,17706,9.53674e-007],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_T_Soldier_AR_F",[13783,17805.9,0],79,[],"STAND",[["arifle_MX_SW_khk_Pointer_F","","acc_pointer_IR","",["100Rnd_65x39_caseless_khaki_mag",100],[],"bipod_01_F_khk"],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_AR_F",[["FirstAidKit",1],["HandGrenade",1,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["V_PlateCarrier2_tna_F",[["100Rnd_65x39_caseless_khaki_mag",5,100],["16Rnd_9x21_Mag",2,16],["Chemlight_green",1,1]]],[],"H_HelmetB_tna_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]],
			//B ["B_T_Soldier_GL_F",[13782,17800.8,0],79,[],"STAND",[]],
			["B_T_Soldier_AA_F",[13788.3,17807.1,0],0,[],"STAND",[]],
			["B_W_Officer_F",[13781.8,17809.1,0],0,[],"STAND",[["arifle_MSBS65_GL_camo_F","muzzle_snds_65_TI_ghex_F","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_msbs_mag",30],["1Rnd_HE_Grenade_shell",1],""],[],["hgun_Pistol_heavy_01_F","","","",["11Rnd_45ACP_Mag",11],[],""],["U_B_CombatUniform_mcam_wdl_f",[["FirstAidKit",1],["Chemlight_green",1,1],["30Rnd_65x39_caseless_msbs_mag",3,30]]],["V_BandollierB_rgr",[["11Rnd_45ACP_Mag",2,11],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1],["1Rnd_HE_Grenade_shell",2,1]]],[],"H_MilCap_wdl","",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["B_HMG_01_high_F",[13853.3,17841.5,16.9],[[0.95,0.31,0.01],[0,-0.05,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			//B ["B_HMG_01_high_F",[13847.4,17843.5,17],[[0.34,0.94,0.05],[0,-0.05,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[13842,17817.2,16.1],[[0.44,0.9,0.01],[0,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[
			[[13783,17805.9,-0.000201225],"MOVE"],
			[[13798.8,17843.5,0],"MOVE"],
			[[13850,17827.3,-9.53674e-007],"MOVE"],
			[[13832.3,17777.5,0],"MOVE"],
			[[13785.8,17795.6,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_T_Support_MG_F",[13848.1,17852.9,0],0,[],"STAND",[["arifle_MXC_khk_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_AR_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_khaki_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_HMG_01_Weapon_grn_F",[]],"H_HelmetB_Light_tna_F","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]],
			//["B_T_Support_AMG_F",[13843.4,17850.6,0],0,[],"STAND",[["arifle_MXC_khk_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_AR_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_khaki_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_HMG_01_support_grn_F",[]],"H_HelmetB_Light_tna_F","G_Tactical_Clear",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]],
			["B_soldier_LAT_F",[13842.5,17845.6,0],0,[],"STAND",[["arifle_MX_ACO_pointer_F","","acc_pointer_IR","optic_Aco",["30Rnd_65x39_caseless_mag",30],[],""],["launch_NLAW_F","","","",["NLAW_F",1],[],""],["hgun_P07_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_CombatUniform_mcam",[["FirstAidKit",1],["30Rnd_65x39_caseless_mag",2,30],["Chemlight_green",1,1]]],["V_PlateCarrier2_rgr",[["30Rnd_65x39_caseless_mag",3,30],["16Rnd_9x21_Mag",2,16],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_AssaultPack_rgr_LAT",[["NLAW_F",2,1]]],"H_HelmetB_sand","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles"]]],
			//B ["B_soldier_AR_F",[13842.3,17856.7,0],0,[],"STAND",[]],
			["B_Soldier_TL_F",[13838.3,17853.4,0],0,[],"STAND",[]],
			["B_Soldier_GL_F",[13837,17848.1,0],0,[],"STAND",[]]
		],
		[],
		[
			[[13843.4,17850.6,0.00130272],"MOVE"],
			[[13926.9,17828.7,-6.67572e-006],"MOVE"],
			[[13870.9,17649.3,0.224011],"MOVE"],
			[[13708.4,17719.8,0],"MOVE"],
			[[13784.8,17887,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_T_Soldier_TL_F",[13872.3,17659.9,0],202,[],"STAND",[]],
			//B ["B_T_Support_GMG_F",[13872.3,17665.1,0],202,[],"STAND",[["arifle_MXC_khk_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_AR_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_khaki_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_GMG_01_Weapon_grn_F",[]],"H_HelmetB_Light_tna_F","G_Tactical_Black",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]],
			["B_T_Support_AMG_F",[13875.9,17664.4,0],202,[],"STAND",[]],
			["B_T_Support_GMG_F",[13868.4,17665.1,0],198,[],"STAND",[["arifle_MXC_khk_Holo_Pointer_F","","acc_pointer_IR","optic_Holosight_khk_F",["30Rnd_65x39_caseless_khaki_mag",30],[],""],[],["hgun_P07_khk_F","","","",["16Rnd_9x21_Mag",16],[],""],["U_B_T_Soldier_AR_F",[["FirstAidKit",1],["30Rnd_65x39_caseless_khaki_mag",2,30],["Chemlight_green",1,1]]],["V_Chestrig_rgr",[["30Rnd_65x39_caseless_khaki_mag",5,30],["16Rnd_9x21_Mag",2,16],["HandGrenade",2,1],["B_IR_Grenade",2,1],["SmokeShell",1,1],["SmokeShellGreen",1,1],["Chemlight_green",1,1]]],["B_GMG_01_Weapon_grn_F",[]],"H_HelmetB_Light_tna_F","G_Combat",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch","NVGoggles_tna_F"]]],
			["B_T_Support_AMG_F",[13872.9,17670.8,0],198,[],"STAND",[]]
		],
		[],
		[
			[[13872.3,17665.1,0.00123405],"MOVE"],
			[[13993.9,17830.7,1.90735e-006],"MOVE"],
			[[13795.9,17931.7,-9.53674e-006],"MOVE"],
			[[13678.3,17697.3,-9.53674e-006],"MOVE"],
			[[13827,17571.8,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_AFV_Wheeled_01_up_cannon_F",[13808.7,17674.5,17],[[-0.29,-0.96,0],[0.05,-0.01,1]],[],[["B_crew_F",["driver"],[],[]],["B_crew_F",["turret",[0]],[],[]],["B_crew_F",["turret",[0,0]],[],[]]]],
			["B_AFV_Wheeled_01_up_cannon_F",[13813.4,17692.5,16.6],[[-0.29,-0.96,0.02],[0.04,0.01,1]],[],[["B_crew_F",["driver"],[],[]],["B_crew_F",["turret",[0]],[],[]],["B_crew_F",["turret",[0,0]],[],[]]]]
		],
		[
			[[13808.8,17674.6,0.000892639],"MOVE"],
			[[14006.9,17336.5,0],"MOVE"],
			[[13415.6,17066.6,0],"MOVE"],
			[[13124.3,17754.6,0],"MOVE"],
			[[14015,18572.3,0],"MOVE"],
			[[14485.6,17672,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			//["B_Officer_Parade_Veteran_F",[13771,17772.3,0.3],19,[1],"STAND",[[],[],["hgun_Pistol_heavy_02_F","","","",["6Rnd_45ACP_Cylinder",6],[],""],["U_B_ParadeUniform_01_US_decorated_F",[]],["V_CarrierRigKBT_01_EAF_F",[]],[],"H_ParadeDressCap_01_US_F","G_Aviator",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]],
			["B_Officer_Parade_Veteran_F",[13771,17772.3,0.3],19,[1,2],"STAND",[]],
			["B_CTRG_Miller_F",[13773,17771.8,0.4],351,[1,2],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_SAM_System_01_F",[13853.6,17731.7,15.6],[[-0.34,-0.94,0.01],[-0.01,0.02,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["O_MRAP_02_F",[13764.7,17752.7,17.4],[[0.34,0.94,-0.03],[0.05,0.01,1]]],
	["O_LSV_02_unarmed_F",[13768.9,17750.1,16.5],[[0.34,0.94,0],[0.05,-0.02,1]]],
	["O_Truck_02_transport_F",[13794.3,17740.9,17],[[0.34,0.94,-0.04],[0.01,0.04,1]]],
	["O_Truck_02_transport_F",[13788.7,17742.9,16.9],[[0.34,0.94,-0.04],[0.01,0.04,1]]],
	["O_MRAP_02_F",[13808.2,17737.4,16.7],[[0.34,0.94,-0.01],[0.01,0,1]]],
	["O_LSV_02_unarmed_F",[13812.1,17734.3,16],[[0.34,0.94,-0.01],[0.01,0,1]]],
	["C_Offroad_01_comms_F",[13860.5,17758.2,15.7],[[-0.35,-0.94,0],[0.01,0,1]]],
	["C_Offroad_01_comms_F",[13857.5,17759.3,15.7],[[-0.35,-0.94,0],[0,0,1]]],
	["C_Offroad_01_comms_F",[13854.4,17760.4,15.7],[[-0.35,-0.94,0.03],[0,0.03,1]]],
	["C_Offroad_01_covered_F",[13891.8,17762.9,15.7],[[-0.94,0.34,0.02],[0.03,0.01,1]]],
	["C_Offroad_01_covered_F",[13893,17766.3,15.7],[[-0.94,0.34,0],[-0.01,-0.03,1]]],
	["B_Heli_Transport_03_F",[13823.7,17794.5,17.6],[[0.34,0.94,0.08],[-0.05,-0.07,1]]],
	["B_Heli_Transport_01_F",[13794.7,17804.3,16.9],[[0.34,0.94,0.02],[0.03,-0.03,1]]],
	["B_Truck_01_mover_F",[13872.9,17752.7,16],[[-0.34,-0.94,0.01],[-0.03,0.02,1]]]
]; 
_doors = [];
_delete = [];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["Land_Communication_F",[13833.6,17773.5,32.19],[[0.33,0.95,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",200,true];}],
	/*
	["Land_CampingChair_V2_F",[13785.4,17725.1,15.31],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13784.5,17725.4,15.29],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13791.1,17723,15.15],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13799.6,17719.9,15.26],[[0.34,0.94,-0.02],[-0.01,0.02,1]],false],
	["Land_CampingChair_V2_F",[13799.3,17719,15.28],[[0.34,0.94,-0.02],[-0.01,0.02,1]],false],
	["Land_CampingChair_V2_F",[13798.9,17718,15.29],[[0.34,0.94,-0.02],[-0.01,0.02,1]],false],
	["Land_CampingChair_V2_F",[13799.8,17717.7,15.31],[[0.34,0.94,-0.02],[-0.01,0.02,1]],false],
	["Land_CampingChair_V2_F",[13791.4,17723.9,15.16],[[0.34,0.94,0.03],[0.01,-0.03,1]],false],
	["Land_CampingChair_V2_F",[13782.7,17726.1,15.19],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13784.2,17724.4,15.26],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13786,17723.8,15.27],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13787.9,17723.1,15.22],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13789.8,17722.4,15.17],[[0.34,0.94,-0.05],[0.02,0.05,1]],false],
	["Land_CampingChair_V2_F",[13786.4,17724.7,15.28],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13783.2,17724.8,15.2],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13785.1,17724.1,15.3],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13787,17723.4,15.25],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13788.9,17722.8,15.19],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13781.7,17726.4,15.14],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13783.6,17725.7,15.24],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13790.7,17722.1,15.17],[[0.34,0.94,-0.05],[0.02,0.05,1]],false],
	["Land_CampingChair_V2_F",[13787.3,17724.4,15.26],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13789.2,17723.7,15.2],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13786.7,17725.6,15.29],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13788.6,17725,15.24],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13787.7,17725.3,15.26],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13788.3,17724,15.23],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13790.2,17723.3,15.17],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13783,17727,15.23],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13784.8,17726.3,15.33],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13785.8,17726,15.32],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13789.5,17724.6,15.21],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13790.5,17724.3,15.18],[[0.34,0.94,0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13782.1,17727.3,15.17],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13783.9,17726.7,15.28],[[0.34,0.94,0.04],[-0.06,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13781.4,17725.5,15.13],[[0.34,0.94,-0.03],[-0.01,0.04,1]],false],
	["Land_CampingChair_V2_F",[13782.3,17725.1,15.15],[[0.34,0.94,-0.03],[-0.01,0.04,1]],false],
	["Land_CampingChair_V2_F",[13784.8,17784.8,14.68],[[-0.36,-0.93,-0.02],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13782.9,17785.5,14.72],[[-0.36,-0.93,-0.02],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13782,17785.8,14.74],[[-0.36,-0.93,-0.02],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13781.3,17784,14.72],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13780.3,17784.3,14.74],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13780.7,17785.3,14.75],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13781,17786.2,14.76],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13782.2,17783.6,14.69],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13784,17782.9,14.65],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13798.9,17779.7,14.55],[[-0.36,-0.93,-0.02],[-0.05,0,1]],false],
	["Land_CampingChair_V2_F",[13799.8,17779.3,14.59],[[-0.36,-0.93,-0.02],[-0.05,0,1]],false],
	["Land_CampingChair_V2_F",[13799.1,17777.5,14.55],[[-0.36,-0.93,-0.02],[-0.05,0,1]],false],
	["Land_CampingChair_V2_F",[13799.5,17778.4,14.57],[[-0.36,-0.93,-0.02],[-0.05,0,1]],false],
	["Land_CampingChair_V2_F",[13798.5,17778.8,14.53],[[-0.36,-0.93,-0.02],[-0.05,0,1]],false],
	["Land_CampingChair_V2_F",[13798.2,17777.8,14.51],[[-0.36,-0.93,-0.02],[-0.05,0,1]],false],
	["Land_CampingChair_V2_F",[13785.9,17782.2,14.58],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13787.8,17781.5,14.51],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13789.6,17780.8,14.44],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13789.4,17783,14.41],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13787.6,17783.7,14.52],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13785.7,17784.4,14.63],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13783.8,17785.1,14.7],[[-0.36,-0.93,-0.02],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13782.5,17784.6,14.7],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13790.3,17782.7,14.35],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13788.5,17783.4,14.46],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13786.7,17784.1,14.58],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13787.2,17782.8,14.51],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13789,17782.1,14.43],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13790,17781.7,14.39],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13788.2,17782.4,14.46],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13786.3,17783.1,14.57],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13784.4,17783.8,14.66],[[-0.36,-0.93,-0.02],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13783.1,17783.3,14.67],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13786.9,17781.8,14.55],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13785,17782.6,14.63],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13785.4,17783.5,14.63],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13783.5,17784.2,14.68],[[-0.36,-0.93,-0.02],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13781.6,17784.9,14.73],[[-0.36,-0.93,-0.01],[0.02,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13788.7,17781.1,14.47],[[-0.36,-0.93,0.05],[0.05,0.03,1]],false],
	["Land_CampingChair_V2_F",[13806.1,17717.5,15],[[0.34,0.94,0],[0.03,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13806.7,17716.3,14.97],[[0.34,0.94,0],[0.03,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13807.1,17717.2,14.97],[[0.34,0.94,0],[0.03,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13805.2,17717.9,15.03],[[0.34,0.94,0],[0.03,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13808.9,17716.5,14.88],[[0.34,0.94,-0.01],[0.05,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13808.2,17714.6,14.91],[[0.34,0.94,-0.04],[0.05,0.02,1]],false],
	["Land_CampingChair_V2_F",[13824.9,17710.7,14.43],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13823,17711.4,14.45],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13821.1,17712,14.48],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13801.7,17717,15.23],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13803.5,17716.3,15.14],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13805.4,17715.7,15.04],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13807.3,17715,14.95],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_CampingChair_V2_F",[13800.7,17717.3,15.28],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13802.6,17716.7,15.19],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13804.5,17716,15.09],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13806.4,17715.3,15],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13801.1,17718.3,15.24],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13802.9,17717.6,15.15],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13804.8,17716.9,15.05],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13819.3,17712.7,14.51],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13800.2,17718.6,15.28],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13802,17717.9,15.19],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13803.9,17717.3,15.1],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13805.8,17716.6,15],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13807.7,17715.9,14.94],[[0.34,0.94,-0.01],[0.05,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13800.5,17719.6,15.24],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13802.4,17718.9,15.15],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13804.2,17718.2,15.06],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13823.3,17709.2,14.45],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13808,17716.8,14.93],[[0.34,0.94,-0.01],[0.05,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13801.4,17719.2,15.2],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13803.3,17718.5,15.1],[[0.34,0.94,-0.04],[0.06,0.02,1]],false],
	["Land_CampingChair_V2_F",[13816.8,17711.5,14.59],[[0.34,0.94,-0.04],[0.04,0.02,1]],false],
	["Land_CampingChair_V2_F",[13825.2,17708.5,14.42],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13820.2,17712.4,14.5],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13808.6,17715.6,14.89],[[0.34,0.94,-0.01],[0.05,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13826.4,17709.1,14.4],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13826.8,17710,14.4],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13826.1,17708.1,14.4],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13817.5,17713.4,14.54],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13825.8,17710.3,14.41],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13824,17711,14.44],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13822.1,17711.7,14.47],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13817.7,17711.2,14.56],[[0.34,0.94,-0.04],[0.04,0.02,1]],false],
	["Land_CampingChair_V2_F",[13819.5,17710.5,14.5],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13821.4,17709.8,14.48],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13818.9,17711.8,14.51],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13825.5,17709.4,14.41],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13818.4,17713.1,14.52],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13818.6,17710.8,14.53],[[0.34,0.94,-0.04],[0.04,0.02,1]],false],
	["Land_CampingChair_V2_F",[13820.5,17710.2,14.49],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13822.3,17709.5,14.46],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13824.2,17708.8,14.43],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13817.1,17712.5,14.55],[[0.34,0.94,-0.04],[0.04,0.02,1]],false],
	["Land_CampingChair_V2_F",[13820.8,17711.1,14.49],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13822.7,17710.4,14.46],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13824.6,17709.8,14.43],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13818,17712.1,14.53],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13819.9,17711.4,14.5],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13821.7,17710.8,14.47],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13823.6,17710.1,14.44],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13803.2,17777,14.56],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13816,17771.5,14.51],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13818.8,17770.3,14.46],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13804.2,17776.6,14.54],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13819.2,17771.2,14.47],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13804.7,17775.3,14.53],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13800,17777.1,14.6],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13800.4,17778.1,14.6],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13816.8,17773.3,14.52],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13817.7,17772.9,14.51],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13818.6,17772.5,14.49],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13819.5,17772.2,14.48],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13820.5,17771.8,14.47],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13821.4,17771.4,14.46],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13822.3,17771.1,14.44],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13823.2,17770.7,14.44],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13824.2,17770.3,14.44],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13825,17770,14.43],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13826,17769.6,14.43],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13825.6,17768.7,14.41],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13825.2,17767.7,14.4],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13824.3,17768.1,14.4],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13824.7,17769,14.42],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13823.8,17769.4,14.42],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13823.4,17768.5,14.4],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13822.5,17768.8,14.41],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13822.9,17769.8,14.42],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13822,17770.1,14.43],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13821.6,17769.2,14.42],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13820.7,17769.6,14.43],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13821,17770.5,14.44],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13820.1,17770.9,14.46],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_CampingChair_V2_F",[13819.7,17769.9,14.45],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13805.6,17775,14.52],[[-0.36,-0.93,-0.01],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13805.1,17776.3,14.53],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13818.2,17771.6,14.48],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13817.8,17770.7,14.48],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13816.9,17771.1,14.49],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13817.3,17772,14.5],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13803.6,17777.9,14.55],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13802.6,17778.3,14.57],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13801.3,17777.7,14.58],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13801,17776.8,14.58],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13801.9,17776.4,14.57],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13802.3,17777.3,14.57],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13816.4,17772.4,14.51],[[-0.37,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13802.8,17776.1,14.56],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13800.8,17779,14.59],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13801.7,17778.6,14.58],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13806.9,17775.6,14.51],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13806,17775.9,14.52],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13804.5,17777.6,14.54],[[-0.36,-0.93,0],[0.01,0,1]],false],
	["Land_CampingChair_V2_F",[13805.4,17777.2,14.53],[[-0.36,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13806.4,17776.9,14.52],[[-0.36,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13807.2,17776.5,14.51],[[-0.36,-0.93,0],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13808.2,17776.2,14.51],[[-0.36,-0.93,-0.01],[-0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13807.8,17775.2,14.5],[[-0.36,-0.93,-0.01],[-0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13807.5,17774.3,14.49],[[-0.36,-0.93,-0.01],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13806.5,17774.6,14.51],[[-0.36,-0.93,-0.01],[0.01,-0.01,1]],false],
	["Land_CampingChair_V2_F",[13803.8,17775.7,14.55],[[-0.36,-0.93,0],[0.01,0,1]],false],
	*/
	//["Box_EAF_Support_F",[13794.6,17760.4,14.37],[[0,1,-0.03],[0,0.03,1]],false],
	//["Box_East_Support_F",[13907.1,17796.8,14.54],[[0,1,-0.02],[0,0.02,1]],false],
	//["Box_NATO_Support_F",[13840.8,17696.8,14.14],[[0,1,0],[0.02,0,1]],false],

	["CamoNet_BLUFOR_open_F",[13785.8,17723,15.93],[[0.34,0.94,0.01],[0.02,-0.02,1]],true],
	["CamoNet_BLUFOR_open_F",[13786.1,17785.4,15.3],[[0.34,0.94,0],[0.05,-0.02,1]],true],
	["CamoNet_BLUFOR_open_F",[13791.8,17742,16.54],[[0.34,0.94,0],[0,0,1]],true],
	["CamoNet_INDP_open_F",[13766.1,17751.3,17.17],[[0.34,0.94,0],[0,0,1]],true],
	["CamoNet_INDP_open_F",[13771.8,17760.9,15.73],[[0.34,0.94,0.01],[0.01,-0.02,1]],true],
	["CamoNet_INDP_open_F",[13803.5,17716.3,15.8],[[0.34,0.94,-0.04],[0.06,0.02,1]],true],
	["CamoNet_INDP_open_F",[13803.9,17778.9,15.21],[[0.34,0.94,0],[0.01,-0.01,1]],true],
	["CamoNet_INDP_open_F",[13809.4,17735.5,16.42],[[0.34,0.94,0],[0,0,1]],true],
	["CamoNet_INDP_open_F",[13813.2,17745.9,15.47],[[0.34,0.94,-0.03],[0.03,0.02,1]],true],
	["CamoNet_INDP_open_F",[13822,17709.4,15.13],[[0.34,0.94,0],[0.01,0,1]],true],
	["CamoNet_OPFOR_open_F",[13821.8,17772.4,15.13],[[0.34,0.94,0.01],[0.01,-0.02,1]],true],
	["CargoNet_01_barrels_F",[13767.4,17730.8,15.5],[[0,1,-0.04],[0.06,0.04,1]],false],
	["CargoNet_01_barrels_F",[13767.4,17732.8,15.42],[[0,1,0.01],[0.01,-0.01,1]],false],
	["CargoNet_01_box_F",[13769.6,17730.9,15.49],[[0,1,0.01],[0.01,-0.01,1]],false],
	["CargoNet_01_box_F",[13769.6,17733,15.5],[[0,1,0.01],[0.01,-0.01,1]],false],
	["CargoPlaftorm_01_green_F",[13870.9,17794.4,17.64],[[-0.36,-0.93,0],[0,0,1]],false],
	["ContainmentArea_03_black_F",[13898.9,17789.1,15.03],[[0.34,0.94,0],[0,0,1]],false],
	["FlexibleTank_01_forest_F",[13760.6,17736.7,15.71],[[0,1,-0.04],[0.11,0.04,0.99]],false],
	["FlexibleTank_01_forest_F",[13760.6,17737.5,15.68],[[0,1,-0.03],[0.11,0.03,0.99]],false],
	["FlexibleTank_01_forest_F",[13761.4,17736.4,15.64],[[0,1,-0.04],[0.11,0.04,0.99]],false],
	["FlexibleTank_01_forest_F",[13761.4,17737.1,15.61],[[0,1,-0.04],[0.11,0.04,0.99]],false],
	["Land_BackAlley_01_l_gate_F",[13815.3,17780.3,15.43],[[0.34,0.94,0],[0,0,1]],false],
	["Land_BagBunker_01_large_green_F",[13848.8,17839.2,15.98],[[-0.35,-0.94,-0.05],[0,-0.05,1]],false],
	["Land_BagFence_01_round_green_F",[13772.8,17760.7,14.96],[[-0.93,0.37,0.02],[0.01,-0.02,1]],false],
	["Land_BagFence_01_round_green_F",[13773.7,17757.2,14.84],[[-0.93,0.37,0.03],[0.01,-0.03,1]],false],
	["Land_BagFence_01_round_green_F",[13775.8,17762.5,14.9],[[-0.95,0.32,0.05],[0.06,0.03,1]],false],
	["Land_BagFence_01_round_green_F",[13809.4,17747.3,14.8],[[0.93,-0.36,-0.02],[0.03,0.02,1]],false],
	["Land_BagFence_01_round_green_F",[13810.6,17744.7,14.82],[[0.95,-0.31,-0.03],[0.03,-0.01,1]],false],
	["Land_BagFence_01_round_green_F",[13812,17748.4,14.7],[[0.93,-0.36,-0.02],[0.03,0.02,1]],false],
	["Land_Cargo_HQ_V1_F",[13776.6,17774.4,18.16],[[-0.35,-0.94,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_F",[13751.5,17734.1,28.98],[[-0.34,-0.94,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_F",[13773.4,17794.2,27.53],[[-0.34,-0.94,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_F",[13858.9,17833.3,27.62],[[-0.94,0.34,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_F",[13867.3,17689.8,26.64],[[0.94,-0.35,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_F",[13892.5,17753,26.89],[[0.35,0.94,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_Cargo_Tower_V1_F",[13914.3,17813.2,27.06],[[-0.94,0.34,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["Land_DeskChair_01_olive_F",[13784.3,17721.4,15.02],[[0.34,0.94,-0.02],[-0.01,0.03,1]],false],
	["Land_DeskChair_01_olive_F",[13785.9,17720.9,15.03],[[0.34,0.94,-0.03],[0.01,0.03,1]],false],
	["Land_DeskChair_01_olive_F",[13785.9,17787.3,14.41],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_DeskChair_01_olive_F",[13787.4,17786.8,14.31],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_DeskChair_01_olive_F",[13801.8,17713.9,15.02],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_DeskChair_01_olive_F",[13803.4,17713.4,14.94],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_DeskChair_01_olive_F",[13803.8,17780.8,14.28],[[-0.36,-0.93,0],[0.01,-0.01,1]],false],
	["Land_DeskChair_01_olive_F",[13805.3,17780.3,14.26],[[-0.36,-0.93,0],[0.01,-0.01,1]],false],
	["Land_DeskChair_01_olive_F",[13819.7,17707.4,14.28],[[0.34,0.94,-0.03],[0.04,0.02,1]],false],
	["Land_DeskChair_01_olive_F",[13821.2,17706.9,14.23],[[0.34,0.94,-0.03],[0.04,0.02,1]],false],
	["Land_DeskChair_01_olive_F",[13821.7,17774.3,14.22],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	["Land_DeskChair_01_olive_F",[13823.2,17773.8,14.2],[[-0.37,-0.93,-0.02],[0,-0.02,1]],false],
	["Land_DragonsTeeth_01_4x2_old_redwhite_F",[13845.1,17670.9,14.23],[[0.94,-0.34,-0.01],[0.01,0.01,1]],false],
	["Land_DragonsTeeth_01_4x2_old_redwhite_F",[13848.8,17681.8,14.34],[[0.94,-0.34,-0.01],[0.01,-0.01,1]],false],
	["Land_DragonsTeeth_01_4x2_old_redwhite_F",[13856,17667.4,14.16],[[0.94,-0.34,-0.01],[0.01,0.01,1]],false],
	["Land_DragonsTeeth_01_4x2_old_redwhite_F",[13859.4,17677.5,14.23],[[0.94,-0.34,-0.01],[0.01,-0.02,1]],false],

	["Land_HBarrier_01_big_4_green_F",[13749.9,17732.9,17.47],[[0.93,-0.36,-0.08],[0.09,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13750.1,17732.9,19.34],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13752.8,17741,17.02],[[0.93,-0.36,-0.05],[0.07,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13753,17740.9,18.78],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13753.4,17728.2,17.21],[[0.34,0.94,-0.03],[0.09,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13753.5,17728.1,18.8],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13755.8,17749,16.67],[[0.93,-0.35,-0.07],[0.08,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13755.9,17748.9,18.63],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13758.7,17757,16.48],[[0.93,-0.35,-0.06],[0.07,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13758.8,17756.9,18.39],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13761.3,17725.3,16.56],[[0.34,0.94,-0.02],[0.08,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13761.6,17725.3,18.66],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13762.7,17768.2,16.26],[[0.93,-0.35,-0.05],[0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13763.6,17770.3,18.33],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13764.6,17757.9,16.11],[[0.34,0.94,-0.04],[0.05,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13764.8,17757.9,17.97],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13765.2,17775.1,16.16],[[0.93,-0.36,-0.05],[0.06,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13765.4,17775.1,18.13],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13768.2,17783.1,15.78],[[0.93,-0.35,-0.07],[0.07,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13768.3,17767.8,17.93],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13768.3,17767.9,15.99],[[0.34,0.94,-0.01],[0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13768.3,17783.1,17.84],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13769.3,17722.3,16.17],[[0.34,0.94,-0.04],[0.04,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13769.6,17722.4,18.17],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13771.1,17791.1,15.95],[[0.93,-0.35,-0.05],[0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13771.1,17791.1,17.96],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13772.7,17755,15.7],[[0.34,0.94,-0.04],[0.07,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13772.8,17754.9,17.68],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13773.9,17748.9,15.86],[[-0.94,0.35,0.04],[0.07,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13773.9,17749,17.9],[[-0.94,0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13774,17799.2,15.93],[[0.93,-0.35,-0.03],[0.04,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13774.1,17799.1,17.81],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13776.3,17764.9,15.6],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13776.4,17765.2,17.53],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13776.9,17807.2,16.01],[[0.94,-0.33,-0.05],[0.05,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777,17807.1,18.1],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777.4,17719.4,15.95],[[0.34,0.94,-0.02],[0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777.4,17719.4,17.95],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777.7,17793.9,15.7],[[0.34,0.94,0.02],[0.01,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777.8,17793.9,17.72],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13778.7,17747.6,15.67],[[-0.94,0.35,-0.01],[0.01,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13778.8,17747.6,17.6],[[-0.94,0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13779.9,17815.3,16.39],[[0.94,-0.33,0],[-0.02,-0.07,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13779.9,17815.3,18.43],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13782.8,17823.3,16.06],[[0.94,-0.33,-0.02],[0,-0.07,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13782.9,17823.4,18.05],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13783.5,17751.5,15.59],[[0.34,0.94,-0.01],[-0.02,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13783.5,17751.5,17.56],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13784.3,17762,15.42],[[0.34,0.94,-0.05],[0.04,0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13784.4,17762,17.36],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.4,17716.5,16.15],[[0.34,0.94,-0.03],[0.01,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.4,17716.5,18.07],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.7,17831.3,16.45],[[0.94,-0.33,-0.02],[0.01,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.8,17791,15.51],[[0.34,0.94,0],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.8,17831.4,18.2],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.9,17790.9,17.37],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13788.7,17839.4,16.31],[[0.94,-0.33,-0.05],[0.06,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13788.8,17839.4,18.27],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13791.6,17748.5,15.62],[[0.34,0.94,-0.01],[0.01,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13791.6,17748.6,17.59],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13792.3,17759.4,17.27],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13792.4,17759.1,15.34],[[0.34,0.94,-0.04],[0.02,0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13793.4,17713.6,16.15],[[0.34,0.94,-0.01],[0.01,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13793.5,17713.6,18.1],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13793.8,17788,17.3],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13793.8,17788.1,15.34],[[0.34,0.94,0.07],[-0.05,-0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13797.3,17763,15.21],[[-0.94,0.35,0],[0.02,0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13797.3,17763,17.13],[[-0.94,0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13799.6,17745.6,15.51],[[0.34,0.94,0.02],[-0.01,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13799.6,17745.6,17.5],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13801.5,17710.6,16.06],[[0.34,0.94,-0.02],[0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13801.6,17710.6,17.87],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13801.9,17785.1,15.17],[[0.34,0.94,-0.05],[0.01,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13801.9,17785.1,17.13],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13803,17760.9,15.13],[[-0.94,0.35,0.02],[0.05,0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13803.1,17761,17.17],[[-0.94,0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13803.8,17847.7,16.42],[[0.33,0.94,0.01],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13803.9,17847.6,18.26],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13804.3,17754.8,15.48],[[0.34,0.94,-0.05],[0.01,0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13804.3,17754.9,17.42],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13807.7,17742.7,15.65],[[0.34,0.94,0.02],[0.01,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13807.8,17742.6,17.59],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13809.5,17707.7,15.76],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13809.6,17707.8,17.78],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13809.9,17782.1,17.28],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13809.9,17782.2,15.14],[[0.34,0.94,-0.06],[0.05,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13811.9,17844.8,16.27],[[0.33,0.94,0.01],[0.03,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13811.9,17844.8,18.19],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13812.3,17751.9,15.42],[[0.34,0.94,-0.03],[0.03,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13812.4,17752,17.36],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13815.7,17739.8,15.41],[[0.34,0.94,0],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13815.8,17739.6,17.32],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13817.6,17704.8,15.41],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13817.6,17704.8,17.39],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13818.6,17733.5,15.2],[[0.94,-0.34,-0.05],[0.06,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13818.8,17733.4,17.01],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13819.3,17735.4,15.25],[[0.94,-0.34,-0.03],[0.02,-0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13819.4,17735.3,16.98],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13819.9,17841.8,17.96],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13819.9,17841.9,16.18],[[0.33,0.94,0.03],[-0.01,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13820.3,17748.9,15.25],[[0.34,0.94,-0.03],[0.03,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13820.5,17749,17.19],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13820.6,17778.3,15.14],[[0.34,0.94,0.03],[-0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13820.6,17778.4,17.05],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13825,17749,16.79],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13825.1,17748.9,15.18],[[0.94,-0.34,0.01],[0,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13825.6,17701.9,15.12],[[0.34,0.94,-0.04],[0.05,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13825.6,17701.9,17.2],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13826.4,17752.4,15.12],[[0.94,-0.34,0.01],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13826.4,17752.4,15.12],[[0.94,-0.34,0.01],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13826.4,17752.4,16.94],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13827.9,17838.8,17.93],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13828,17838.9,16.15],[[0.33,0.94,0.01],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13828.7,17775.4,14.98],[[0.34,0.94,0],[0.04,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13828.8,17775.3,16.94],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13829.1,17760.4,16.97],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13829.3,17760.4,15.07],[[0.94,-0.34,0],[-0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13832.2,17768.4,15.1],[[0.94,-0.34,0.01],[0,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13832.3,17768.5,17.05],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13833.6,17698.9,15.01],[[0.34,0.94,0.02],[-0.03,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13833.6,17699,17.02],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13834.8,17776.6,15.07],[[0.94,-0.34,-0.01],[-0.01,-0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13834.8,17776.6,17.19],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13836,17835.9,17.96],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13836,17836,16.17],[[0.33,0.94,0.01],[-0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13837.6,17784.6,17.2],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13837.7,17784.7,15.12],[[0.94,-0.34,-0.08],[0.07,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13838.6,17771.8,15],[[0.34,0.94,-0.04],[0.05,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13838.6,17771.8,17.08],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13840,17700.4,15.08],[[0.94,-0.34,-0.02],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13840,17700.5,17],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13840.6,17792.6,16.95],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13840.6,17792.7,14.87],[[0.93,-0.33,-0.14],[0.14,-0.02,0.99]],false],
	["Land_HBarrier_01_big_4_green_F",[13843.5,17800.6,17.48],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13843.5,17800.8,15.34],[[0.94,-0.33,-0.04],[0.02,-0.08,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13844,17833,18.22],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13844,17833.1,16.1],[[0.33,0.94,0.06],[-0.01,-0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13846.5,17808.6,17.62],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13846.5,17808.8,15.58],[[0.94,-0.34,-0.03],[0.03,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13849.4,17816.8,15.54],[[0.94,-0.34,-0.01],[-0.01,-0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13849.6,17816.6,17.46],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13850.1,17692.9,14.95],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13850.1,17692.9,16.63],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13851.3,17767.2,14.97],[[0.34,0.94,-0.02],[-0.03,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13851.3,17767.3,16.77],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13852.3,17824.9,15.83],[[0.94,-0.34,0.01],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13852.5,17824.6,17.71],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13855.3,17832.9,15.85],[[0.94,-0.34,0.01],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13855.4,17832.6,17.75],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13857.6,17837.6,18.01],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13857.8,17837.6,16.09],[[-0.35,-0.94,0],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13859.1,17764.3,16.93],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13859.2,17764.1,15.11],[[0.34,0.94,-0.02],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13864.3,17687.4,14.87],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13864.3,17687.5,16.87],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13865.8,17834.6,17.85],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13866,17834.6,15.97],[[-0.35,-0.94,0.01],[0.01,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13867.1,17761.4,16.87],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13867.3,17761.3,15],[[0.34,0.94,0.03],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13870.8,17690.7,15],[[0.94,-0.33,0],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13870.8,17690.8,16.66],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.5,17698.4,16.7],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.6,17698.7,14.96],[[0.94,-0.33,0],[0,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.9,17831.8,16.15],[[-0.35,-0.94,-0.06],[-0.05,-0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.9,17831.8,18.24],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13875.1,17758.5,17.11],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13875.4,17758.4,15.29],[[0.34,0.94,-0.01],[0,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13876.5,17706.5,16.7],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13876.5,17706.8,14.96],[[0.94,-0.33,0],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13879.4,17714.5,16.75],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13879.5,17714.8,15.01],[[0.94,-0.33,-0.01],[0.01,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882,17828.9,16.41],[[-0.35,-0.94,0.01],[0,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882,17828.9,18.33],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882.2,17722.6,16.68],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882.4,17722.9,14.94],[[0.94,-0.33,-0.01],[0,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13883.3,17755.6,17.27],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13883.4,17755.4,15.3],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13885.1,17730.6,16.9],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13885.3,17730.9,15.15],[[0.94,-0.33,0.01],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13888.1,17738.8,17.11],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13888.3,17738.9,15.18],[[0.94,-0.33,0.03],[-0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13889.9,17753.1,15.22],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13889.9,17753.1,15.22],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13890,17753,17.15],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13891.1,17747,17.15],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13891.2,17747,15.15],[[0.94,-0.33,-0.01],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895,17757,15.18],[[0.94,-0.33,-0.02],[0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895.1,17756.7,17.23],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895.4,17823.8,16.19],[[-0.35,-0.94,-0.04],[0.01,-0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895.4,17823.8,17.9],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13897.7,17765,15.2],[[0.94,-0.33,0.02],[-0.03,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13897.8,17765,17.19],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13900.6,17773,17.36],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13900.7,17773,15.35],[[0.94,-0.33,-0.01],[0.02,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.4,17820.9,17.89],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.4,17821,16.08],[[-0.35,-0.94,-0.04],[0,-0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.6,17781,17.32],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.6,17781.1,15.34],[[0.94,-0.33,-0.02],[0.02,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13906.5,17789.1,15.48],[[0.94,-0.33,0.01],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13906.5,17789.1,17.44],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13909.4,17797.1,15.47],[[0.94,-0.33,0.01],[0,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13909.5,17797.1,17.55],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13911.4,17818.1,15.8],[[-0.35,-0.93,-0.07],[0.01,-0.08,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13911.5,17818,17.51],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13912.4,17805.1,17.29],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13912.4,17805.2,15.24],[[0.94,-0.33,0],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13915.3,17813.2,15.39],[[0.94,-0.33,-0.03],[0,-0.08,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13915.4,17813.3,17.29],[[0.94,-0.33,0],[0,0,1]],false],

	/*
	["Land_HBarrier_01_big_4_green_F",[13753.5,17728.1,18.8],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13769.3,17722.3,16.17],[[0.34,0.94,-0.04],[0.04,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13761.6,17725.3,18.66],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13769.6,17722.4,18.17],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13761.3,17725.3,16.56],[[0.34,0.94,-0.02],[0.08,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13753.4,17728.2,17.21],[[0.34,0.94,-0.03],[0.09,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13755.8,17749,16.67],[[0.93,-0.35,-0.07],[0.08,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13758.7,17757,16.48],[[0.93,-0.35,-0.06],[0.07,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13750.1,17732.9,19.34],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13753,17740.9,18.78],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13764.6,17757.9,16.11],[[0.34,0.94,-0.04],[0.05,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13752.8,17741,17.02],[[0.93,-0.36,-0.05],[0.07,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13755.9,17748.9,18.63],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13749.9,17732.9,17.47],[[0.93,-0.36,-0.08],[0.09,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13758.8,17756.9,18.39],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13765.4,17775.1,18.13],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13768.3,17783.1,17.84],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13762.7,17768.2,16.26],[[0.93,-0.35,-0.05],[0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13765.2,17775.1,16.16],[[0.93,-0.36,-0.05],[0.06,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13763.6,17770.3,18.33],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13768.3,17767.9,15.99],[[0.34,0.94,-0.01],[0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13768.2,17783.1,15.78],[[0.93,-0.35,-0.07],[0.07,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13793.5,17713.6,18.1],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.4,17716.5,18.07],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777.4,17719.4,17.95],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.4,17716.5,16.15],[[0.34,0.94,-0.03],[0.01,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13793.4,17713.6,16.15],[[0.34,0.94,-0.01],[0.01,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777.4,17719.4,15.95],[[0.34,0.94,-0.02],[0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13791.6,17748.5,15.62],[[0.34,0.94,-0.01],[0.01,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13783.5,17751.5,15.59],[[0.34,0.94,-0.01],[-0.02,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13773.9,17748.9,15.86],[[-0.94,0.35,0.04],[0.07,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13772.7,17755,15.7],[[0.34,0.94,-0.04],[0.07,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13799.6,17745.6,15.51],[[0.34,0.94,0.02],[-0.01,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13778.7,17747.6,15.67],[[-0.94,0.35,-0.01],[0.01,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13792.4,17759.1,15.34],[[0.34,0.94,-0.04],[0.02,0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13784.3,17762,15.42],[[0.34,0.94,-0.05],[0.04,0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13776.3,17764.9,15.6],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13797.3,17763,15.21],[[-0.94,0.35,0],[0.02,0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13793.8,17788.1,15.34],[[0.34,0.94,0.07],[-0.05,-0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13771.1,17791.1,17.96],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13774.1,17799.1,17.81],[[0.94,-0.35,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13779.9,17815.3,18.43],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13776.9,17807.2,16.01],[[0.94,-0.33,-0.05],[0.05,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13779.9,17815.3,16.39],[[0.94,-0.33,0],[-0.02,-0.07,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13774,17799.2,15.93],[[0.93,-0.35,-0.03],[0.04,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.8,17791,15.51],[[0.34,0.94,0],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13771.1,17791.1,15.95],[[0.93,-0.35,-0.05],[0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777.7,17793.9,15.7],[[0.34,0.94,0.02],[0.01,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13777,17807.1,18.1],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13782.8,17823.3,16.06],[[0.94,-0.33,-0.02],[0,-0.07,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13788.8,17839.4,18.27],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13782.9,17823.4,18.05],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13788.7,17839.4,16.31],[[0.94,-0.33,-0.05],[0.06,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.7,17831.3,16.45],[[0.94,-0.33,-0.02],[0.01,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13785.8,17831.4,18.2],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13817.6,17704.8,17.39],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13809.6,17707.8,17.78],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13817.6,17704.8,15.41],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13825.6,17701.9,17.2],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13809.5,17707.7,15.76],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13801.5,17710.6,16.06],[[0.34,0.94,-0.02],[0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13825.6,17701.9,15.12],[[0.34,0.94,-0.04],[0.05,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13801.6,17710.6,17.87],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13819.3,17735.4,15.25],[[0.94,-0.34,-0.03],[0.02,-0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13815.7,17739.8,15.41],[[0.34,0.94,0],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13825.1,17748.9,15.18],[[0.94,-0.34,0.01],[0,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13820.3,17748.9,15.25],[[0.34,0.94,-0.03],[0.03,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13826.4,17752.4,15.12],[[0.94,-0.34,0.01],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13826.4,17752.4,15.12],[[0.94,-0.34,0.01],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13812.3,17751.9,15.42],[[0.34,0.94,-0.03],[0.03,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13807.7,17742.7,15.65],[[0.34,0.94,0.02],[0.01,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13818.6,17733.5,15.2],[[0.94,-0.34,-0.05],[0.06,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13804.3,17754.8,15.48],[[0.34,0.94,-0.05],[0.01,0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13820.6,17778.3,15.14],[[0.34,0.94,0.03],[-0.05,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13801.9,17785.1,15.17],[[0.34,0.94,-0.05],[0.01,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13828.7,17775.4,14.98],[[0.34,0.94,0],[0.04,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13829.3,17760.4,15.07],[[0.94,-0.34,0],[-0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13809.9,17782.2,15.14],[[0.34,0.94,-0.06],[0.05,0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13803,17760.9,15.13],[[-0.94,0.35,0.02],[0.05,0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13811.9,17844.8,16.27],[[0.33,0.94,0.01],[0.03,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13803.9,17847.6,18.26],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13827.9,17838.8,17.93],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13803.8,17847.7,16.42],[[0.33,0.94,0.01],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13811.9,17844.8,18.19],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13819.9,17841.8,17.96],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13828,17838.9,16.15],[[0.33,0.94,0.01],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13819.9,17841.9,16.18],[[0.33,0.94,0.03],[-0.01,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13833.6,17699,17.02],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13833.6,17698.9,15.01],[[0.34,0.94,0.02],[-0.03,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13850.1,17692.9,16.63],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13850.1,17692.9,14.95],[[0.34,0.94,0],[0.01,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13840,17700.4,15.08],[[0.94,-0.34,-0.02],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13851.3,17767.2,14.97],[[0.34,0.94,-0.02],[-0.03,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13834.8,17776.6,15.07],[[0.94,-0.34,-0.01],[-0.01,-0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13837.7,17784.7,15.12],[[0.94,-0.34,-0.08],[0.07,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13859.2,17764.1,15.11],[[0.34,0.94,-0.02],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13832.2,17768.4,15.1],[[0.94,-0.34,0.01],[0,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13838.6,17771.8,15],[[0.34,0.94,-0.04],[0.05,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13840.6,17792.7,14.87],[[0.93,-0.33,-0.14],[0.14,-0.02,0.99]],false],
	["Land_HBarrier_01_big_4_green_F",[13846.5,17808.8,15.58],[[0.94,-0.34,-0.03],[0.03,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13843.5,17800.8,15.34],[[0.94,-0.33,-0.04],[0.02,-0.08,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13849.4,17816.8,15.54],[[0.94,-0.34,-0.01],[-0.01,-0.05,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13836,17836,16.17],[[0.33,0.94,0.01],[-0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13852.3,17824.9,15.83],[[0.94,-0.34,0.01],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13844,17833,18.22],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13836,17835.9,17.96],[[0.33,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13857.8,17837.6,16.09],[[-0.35,-0.94,0],[0.02,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13857.6,17837.6,18.01],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13844,17833.1,16.1],[[0.33,0.94,0.06],[-0.01,-0.06,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13855.3,17832.9,15.85],[[0.94,-0.34,0.01],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13870.8,17690.7,15],[[0.94,-0.33,0],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.6,17698.7,14.96],[[0.94,-0.33,0],[0,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.5,17698.4,16.7],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13864.3,17687.5,16.87],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13864.3,17687.4,14.87],[[0.34,0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13870.8,17690.8,16.66],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882.4,17722.9,14.94],[[0.94,-0.33,-0.01],[0,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13879.5,17714.8,15.01],[[0.94,-0.33,-0.01],[0.01,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13876.5,17706.8,14.96],[[0.94,-0.33,0],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13879.4,17714.5,16.75],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13876.5,17706.5,16.7],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882.2,17722.6,16.68],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13888.3,17738.9,15.18],[[0.94,-0.33,0.03],[-0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13883.4,17755.4,15.3],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13875.4,17758.4,15.29],[[0.34,0.94,-0.01],[0,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13885.3,17730.9,15.15],[[0.94,-0.33,0.01],[-0.01,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13889.9,17753.1,15.22],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13885.1,17730.6,16.9],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13889.9,17753.1,15.22],[[0.34,0.94,0],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13888.1,17738.8,17.11],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13867.3,17761.3,15],[[0.34,0.94,0.03],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.9,17831.8,16.15],[[-0.35,-0.94,-0.06],[-0.05,-0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13866,17834.6,15.97],[[-0.35,-0.94,0.01],[0.01,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882,17828.9,16.41],[[-0.35,-0.94,0.01],[0,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13865.8,17834.6,17.85],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13873.9,17831.8,18.24],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13882,17828.9,18.33],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895,17757,15.18],[[0.94,-0.33,-0.02],[0.03,0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13891.2,17747,15.15],[[0.94,-0.33,-0.01],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13891.1,17747,17.15],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895.1,17756.7,17.23],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13897.7,17765,15.2],[[0.94,-0.33,0.02],[-0.03,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13906.5,17789.1,17.44],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.6,17781.1,15.34],[[0.94,-0.33,-0.02],[0.02,-0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13897.8,17765,17.19],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13900.6,17773,17.36],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13900.7,17773,15.35],[[0.94,-0.33,-0.01],[0.02,0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13906.5,17789.1,15.48],[[0.94,-0.33,0.01],[-0.02,-0.03,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.6,17781,17.32],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13911.4,17818.1,15.8],[[-0.35,-0.93,-0.07],[0.01,-0.08,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13912.4,17805.2,15.24],[[0.94,-0.33,0],[0,-0.01,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13915.4,17813.3,17.29],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13909.4,17797.1,15.47],[[0.94,-0.33,0.01],[0,0.02,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13909.5,17797.1,17.55],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13911.5,17818,17.51],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13912.4,17805.1,17.29],[[0.94,-0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13915.3,17813.2,15.39],[[0.94,-0.33,-0.03],[0,-0.08,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895.4,17823.8,16.19],[[-0.35,-0.94,-0.04],[0.01,-0.04,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.4,17820.9,17.89],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13895.4,17823.8,17.9],[[-0.35,-0.94,0],[0,0,1]],false],
	["Land_HBarrier_01_big_4_green_F",[13903.4,17821,16.08],[[-0.35,-0.94,-0.04],[0,-0.04,1]],false],
	*/

	["Land_HBarrier_01_big_tower_green_F",[13760.3,17763.8,17.39],[[0.94,-0.35,-0.01],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_big_tower_green_F",[13823.4,17741.7,16.4],[[-0.93,0.38,0.01],[0.02,0,1]],false],
	["Land_HBarrier_01_big_tower_green_F",[13889.5,17828.1,17.52],[[-0.32,-0.95,0],[0,0,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13791.4,17844.5,19.26],[[0.6,-0.8,-0.01],[0.03,0.01,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13797.9,17848.4,19.05],[[-0.33,0.95,0],[0.03,0.01,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13838.4,17696.5,17.38],[[-0.37,-0.93,0],[0,0,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13844.9,17693.1,17.43],[[-0.37,-0.93,-0.01],[0.01,-0.01,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13846.7,17730,14.67],[[-0.95,0.33,0],[0,0,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13847.9,17733.3,14.73],[[-0.95,0.33,0.01],[0,-0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13848.4,17727.1,14.66],[[0.33,0.95,0],[0,0,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13849,17736.6,14.67],[[-0.94,0.33,0.03],[0.04,0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13851.7,17725.9,14.66],[[0.33,0.95,0],[0,0,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13852.2,17738.2,14.56],[[0.33,0.94,0.05],[0,-0.05,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13855,17724.8,14.65],[[0.33,0.95,0],[0,0,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13855.5,17737,14.63],[[0.33,0.95,0.02],[-0.04,-0.01,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13857.8,17726.2,14.67],[[0.95,-0.33,0],[-0.01,-0.01,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13858.8,17735.9,14.74],[[0.33,0.95,0.02],[-0.04,-0.01,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13860.3,17733.3,14.75],[[0.94,-0.33,-0.03],[0.03,-0.01,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13864.1,17793,14.57],[[-0.94,0.33,-0.08],[-0.09,-0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13865.3,17796.3,14.68],[[-0.94,0.33,-0.07],[-0.07,0,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13865.7,17790,14.66],[[0.32,0.94,0.05],[-0.09,-0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13866.4,17799.6,14.78],[[-0.94,0.33,-0.04],[-0.03,0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13869,17788.9,14.88],[[0.33,0.95,0.04],[-0.05,-0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13869.6,17801.1,14.82],[[0.33,0.95,-0.01],[-0.02,0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13872.4,17787.8,15.04],[[0.33,0.95,0.04],[-0.05,-0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13872.9,17800,14.91],[[0.32,0.94,0.05],[-0.07,-0.03,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13875.2,17789.2,15.21],[[0.95,-0.33,-0.01],[0.01,-0.02,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13876.2,17798.9,15.01],[[0.33,0.95,0.03],[0.01,-0.03,1]],false],
	["Land_HBarrier_01_line_3_green_F",[13877.7,17796.2,14.98],[[0.95,-0.33,0],[0.01,0.03,1]],false],
	["Land_HelipadCircle_F",[13794.6,17804.7,14.77],[[0.34,0.94,0.02],[0.03,-0.03,1]],true],
	["Land_HelipadCircle_F",[13823.7,17794.8,14.26],[[0.34,0.94,0.08],[-0.05,-0.07,1]],true],
	["Land_HelipadCivil_F",[13804.5,17827.8,14.83],[[0.34,0.94,0],[0.01,0,1]],true],
	["Land_HelipadCivil_F",[13832.7,17817,14.79],[[0.34,0.94,0.03],[0.01,-0.04,1]],true],
	["Land_Mil_WallBig_Gate_F",[13855.7,17685.7,14.48],[[0.34,0.94,0],[0,0,1]],true],
	["Land_Mil_WallBig_Gate_F",[13856.5,17688,14.47],[[0.34,0.94,0],[0,0,1]],true],
	["Land_PillboxBunker_01_big_F",[13794.8,17847.8,16.25],[[-0.53,0.85,0.01],[0.03,0.01,1]],false],
	["Land_PillboxBunker_01_big_F",[13840.4,17693.3,14.67],[[-0.34,-0.94,-0.01],[0.01,-0.01,1]],false],
	["Land_PipeFence_04_m_gate_l_F",[13858.4,17727.8,14.76],[[0.95,-0.33,0],[0,0,1]],true],
	["Land_PipeFence_04_m_gate_l_F",[13875.8,17790.8,15.25],[[0.95,-0.33,0],[0,0,1]],true],
	["Land_PortableDesk_01_olive_F",[13785.3,17721.9,15.23],[[0.34,0.94,-0.03],[0.01,0.03,1]],false],
	["Land_PortableDesk_01_olive_F",[13786.4,17786.3,14.58],[[-0.36,-0.93,0],[0.05,-0.02,1]],false],
	["Land_PortableDesk_01_olive_F",[13802.9,17714.4,15.16],[[0.34,0.94,-0.05],[0.06,0.03,1]],false],
	["Land_PortableDesk_01_olive_F",[13804.3,17779.8,14.49],[[-0.36,-0.93,0],[0.01,-0.01,1]],false],
	["Land_PortableDesk_01_olive_F",[13820.7,17707.9,14.46],[[0.34,0.94,-0.04],[0.04,0.02,1]],false],
	["Land_PortableDesk_01_olive_F",[13822.1,17773.3,14.42],[[-0.37,-0.93,-0.01],[0.01,-0.02,1]],false],
	/*
	["Land_Razorwire_F",[13752,17737.9,20.58],[[0.92,-0.35,-0.19],[0.18,-0.07,0.98]],false],
	["Land_Razorwire_F",[13754,17744,19.88],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13754.1,17727.9,20.38],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13757,17751.5,20.13],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13758.5,17757,19.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13762.3,17725.1,20.01],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13763.4,17770.3,19.63],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13764.8,17757.8,19.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13766.3,17778,19.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13768.3,17767.8,19.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13768.9,17785.5,19.26],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13770.5,17722.1,19.63],[[-0.36,-0.93,0],[0,0,1]],false],
	["Land_Razorwire_F",[13772.8,17754.9,19.13],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13773.3,17798.1,19.38],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13773.6,17748.9,19.38],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13776.3,17765.3,19.26],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13776.3,17806,19.51],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13778.1,17793.6,19.26],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13778.5,17719.1,19.38],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13778.5,17747.4,19.13],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13779.4,17813.8,19.88],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13781.8,17820.9,19.63],[[0.91,-0.35,0.23],[-0.23,0.03,0.97]],false],
	["Land_Razorwire_F",[13783.3,17751.5,18.63],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13784.3,17762.1,19.01],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13784.5,17828.5,19.63],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13786,17790.8,18.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13786.4,17716.1,19.38],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13786.6,17750.4,18.76],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13787.6,17836.1,19.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13789.5,17840.9,19.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13792.1,17759.4,18.76],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13794.1,17713.4,19.63],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13794.1,17747.6,19.01],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13794.1,17787.9,18.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13797.4,17763,18.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13801.6,17744.8,18.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13801.8,17710.8,19.38],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13802,17785.1,18.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13802.4,17848,19.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13803,17761,18.63],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13804.3,17754.9,18.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13808.9,17742.1,19.01],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13809.4,17707.8,19.26],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13809.9,17781.9,18.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13810.3,17845.3,19.26],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13812.1,17751.8,18.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13816.6,17739.1,18.76],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13817.3,17705,18.88],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13818,17842.5,19.38],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13818.6,17733.4,18.51],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13820,17749.1,18.76],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13820.8,17778.3,18.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13824.9,17702.3,18.76],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13824.9,17748.9,18.26],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13825.5,17839.6,19.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13827.5,17756.4,18.13],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13828.9,17775.3,18.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13830.4,17764,18.26],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13832.3,17699.5,18.63],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13833.1,17771.8,18.63],[[0.96,-0.29,0],[0,0,1]],false],
	["Land_Razorwire_F",[13833.3,17836.6,19.63],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13835.5,17779.4,18.38],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13838.3,17786.9,18.63],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13838.5,17771.8,18.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13839.1,17697.3,18.38],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13839.9,17700.4,18.51],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13841,17794.5,18.38],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13841.1,17833.9,19.76],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13842.8,17696,18.38],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13844,17802,18.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13844.1,17832.9,19.26],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13846.9,17809.5,19.01],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13849.6,17817,18.88],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13850.1,17692.5,18.01],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13851.3,17767.3,18.26],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13852.4,17824.5,18.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13854.8,17830.5,19.26],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13859.4,17764.4,18.38],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13863.5,17835.8,19.26],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13864.1,17687.6,18.13],[[-0.33,-0.95,0],[0,0,1]],false],
	["Land_Razorwire_F",[13867,17761.4,18.26],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13871.1,17691.9,18.13],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13871.1,17832.8,19.76],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13874.1,17699.9,18.13],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13874.6,17758.8,18.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13876.8,17707.1,18.13],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13879.1,17830,19.76],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13879.6,17714.9,18.26],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13881.9,17828.9,20.01],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13882.4,17722.8,18.01],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13882.4,17756.1,18.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13885.3,17730.5,18.38],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13888,17738.3,18.51],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13890.1,17753.1,18.63],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13890.9,17746,18.51],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13895,17823.9,19.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13896.1,17760.6,18.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13899.1,17768.4,18.76],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13902,17776,18.88],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13903,17821,19.51],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13905,17783.8,19.2],[[0.91,-0.33,-0.23],[0.21,-0.12,0.97]],false],
	["Land_Razorwire_F",[13907.6,17791.4,19.01],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13907.8,17819.4,18.88],[[-0.34,-0.94,0],[0,0,1]],false],
	["Land_Razorwire_F",[13910.5,17799.3,19.13],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_Razorwire_F",[13913.4,17807.3,19.01],[[0.89,-0.33,-0.32],[0.31,-0.08,0.95]],false],
	["Land_Razorwire_F",[13915.4,17813.3,19.01],[[0.93,-0.36,0],[0,0,1]],false],
	*/
	["Land_Research_HQ_F",[13897.2,17794,18.17],[[0.33,0.94,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_RoadBarrier_01_F",[13855,17683.8,17.35],[[0.34,0.94,0],[0,0,1]],true],
	["Land_SandbagBarricade_01_hole_F",[13767.4,17760.4,16],[[0.37,0.93,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_hole_F",[13768,17759.1,15.98],[[-0.94,0.35,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_hole_F",[13768.8,17764,15.98],[[-0.37,-0.93,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_hole_F",[13770.1,17764.6,15.93],[[-0.93,0.37,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_hole_F",[13815.3,17743,15.53],[[0.93,-0.36,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_hole_F",[13816.6,17743.6,15.52],[[0.36,0.93,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_hole_F",[13816.7,17746.7,15.48],[[0.94,-0.34,0],[0,0,1]],false],
	["Land_SandbagBarricade_01_hole_F",[13817.3,17745.5,15.49],[[-0.35,-0.94,0],[0,0,1]],false],
	/*
	["MapBoard_altis_F",[13782.8,17720.8,15.77],[[-0.82,-0.57,0.01],[-0.01,0.03,1]],false],
	["MapBoard_altis_F",[13784.7,17720,15.81],[[-0.32,-0.95,0.02],[-0.01,0.03,1]],false],
	["MapBoard_altis_F",[13785.3,17788.9,15.23],[[-0.22,0.98,0.04],[0.05,-0.02,1]],false],
	["MapBoard_altis_F",[13786.5,17719.3,15.82],[[0.23,-0.97,0.03],[0.01,0.03,1]],false],
	["MapBoard_altis_F",[13787.3,17788.2,15.12],[[0.33,0.94,0.05],[0.02,-0.06,1]],false],
	["MapBoard_altis_F",[13789,17787.3,15.04],[[0.83,0.55,0.02],[0.02,-0.06,1]],false],
	["MapBoard_altis_F",[13800.3,17713.4,15.84],[[-0.82,-0.57,0.03],[0.03,0.01,1]],false],
	["MapBoard_altis_F",[13802.2,17712.6,15.78],[[-0.32,-0.95,0.02],[0.03,0.01,1]],false],
	["MapBoard_altis_F",[13803.1,17782.4,15.04],[[-0.22,0.98,0.01],[0.01,-0.01,1]],false],
	["MapBoard_altis_F",[13804,17711.9,15.7],[[0.23,-0.97,0.02],[0.06,0.03,1]],false],
	["MapBoard_altis_F",[13805,17781.7,15.02],[[0.33,0.94,0],[0.01,-0.01,1]],false],
	["MapBoard_altis_F",[13806.8,17780.8,15],[[0.83,0.55,0],[0.01,-0.01,1]],false],
	["MapBoard_altis_F",[13818.2,17706.9,15.11],[[-0.82,-0.56,0.04],[0.04,0.02,1]],false],
	["MapBoard_altis_F",[13820,17706.1,15.05],[[-0.32,-0.95,0.03],[0.04,0.02,1]],false],
	["MapBoard_altis_F",[13821,17775.9,14.93],[[-0.2,0.98,-0.05],[0.01,0.05,1]],false],
	["MapBoard_altis_F",[13821.9,17705.4,14.99],[[0.23,-0.97,0.01],[0.04,0.02,1]],false],
	["MapBoard_altis_F",[13822.9,17775.2,14.96],[[0.35,0.94,0],[0.04,-0.01,1]],false],
	["MapBoard_altis_F",[13824.7,17774.3,14.9],[[0.84,0.54,-0.04],[0.04,0.02,1]],false],
	*/
	["MapBoard_altis_F",[13784.7,17720,15.81],[[-0.32,-0.95,0.02],[-0.01,0.03,1]],false],
	["MapBoard_altis_F",[13787.3,17788.2,15.12],[[0.33,0.94,0.05],[0.02,-0.06,1]],false],
	["MapBoard_altis_F",[13802.2,17712.6,15.78],[[-0.32,-0.95,0.02],[0.03,0.01,1]],false],
	["MapBoard_altis_F",[13820,17706.1,15.05],[[-0.32,-0.95,0.03],[0.04,0.02,1]],false],
	["MapBoard_altis_F",[13805,17781.7,15.02],[[0.33,0.94,0],[0.01,-0.01,1]],false],
	["MapBoard_altis_F",[13822.9,17775.2,14.96],[[0.35,0.94,0],[0.04,-0.01,1]],false],
	["VirtualReammoBox_camonet_F",[13769.4,17727.3,16.28],[[0,1,-0.01],[0.06,0.01,1]],false],
	["VirtualReammoBox_camonet_F",[13772.5,17727.1,16.17],[[0,1,-0.01],[0.03,0.01,1]],false],
	["VirtualReammoBox_F",[13771.8,17732.9,15.55],[[0,1,0.01],[0.06,-0.01,1]],false],
	["VirtualReammoBox_F",[13771.9,17730.6,15.54],[[0,1,0.01],[0.06,-0.01,1]],false],
	["VirtualReammoBox_small_F",[13768.4,17734.3,15.1],[[0,1,0.01],[0.01,-0.01,1]],false],
	["VirtualReammoBox_small_F",[13768.4,17735,15.1],[[0,1,0.01],[0.01,-0.01,1]],false],
	["VirtualReammoBox_small_F",[13770.8,17734.4,15.04],[[0,1,0.01],[0.06,-0.01,1]],false],
	["VirtualReammoBox_small_F",[13771,17735.2,15.03],[[0,1,0.01],[0.06,-0.01,1]],false]
];

private _ata = [];
private _nos = [];
private _ts = [];
private _vd = [];
private _noLagWait = 0.1;
{
	_x params ["_class","_pw","_vdu","_complete",["_code",{}]];
	private _obj = if (_complete) then {createVehicle [_class,[0,0,0],[],20,"CAN_COLLIDE"]} else {createSimpleObject [_class,[0,0,0]]};
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
					_suitCase setVariable ["mny",round (5000000*BRPVP_missionValueMult),true];
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
				_wp setWaypointCompletionRadius 10;
			} forEach _wps;
			_wp = _grp addWayPoint [(_wps select 0) vectorAdd _pFix2D,0];
			_wp setWayPointType "CYCLE";
			_wp setWaypointCompletionRadius 5;
		} else {
			if (_wps2 isNotEqualTo []) then {
				{
					_wp = _grp addWayPoint [(_x select 0) vectorAdd _pFix2D,0];
					_wp setWayPointType (_x select 1);
					_wp setWaypointCompletionRadius 10;
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
	[[13901.6,17791.8,14.9038],18.9007,30],
	[[13772.9,17777.8,14.8877],111.025,30],
	[[13793.3,17848.7,17.7319],329.792,20],
	[[13759.8,17764.1,17.3260],112.306,10],
	[[13823.8,17741.6,16.3247],293.874,10]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];
_cfg = [_place,300,+BRPVP_pmissActualAiUnits,10,"str_pmiss_hotel_cant_open",[_delete,{{deleteVehicle _x;} forEach _this;}]];
{_x setVariable ["brpvp_mbots2",_cfg,true];} forEach _doors;

//SPECIAL MILITAR BASE
private _key = "EXTRA_RADIO_"+str round random 1000000;
[[13897.2,17794,0],15,_key,8,0.5,[],0] remoteExecCall ["BRPVP_radioAreasAddArea",0];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,[],{true}];
BRPVP_pmissSpawning = false;