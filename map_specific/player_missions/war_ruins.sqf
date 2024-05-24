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

//PARAMS
_place = _this select 0;
_rad = _this select 1;
_skill = _this select 2;

_pFix = [0,0,0];
_pFix2D = [0,0,0];

BRPVP_pmissEndCheckObjects = [];

//MISSION
_pmissGroups = [
	[
		WEST,
		[],
		[],
		[
			["B_Plane_CAS_01_dynamicLoadout_F",[27157,24907.1,27.2],[[-0.65,-0.76,0],[0,0,1]],[],[["B_Fighter_Pilot_F",["driver"],[],[]]]]
		],
		[
			[[4901.64,21955.3,300],"MOVE"],
			[[4901.64,21955.3,300],"MOVE"],
			[[4901.64,21955.3,300],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[4855.9,21926.3,353.2],[[-0.66,-0.75,0.03],[0.01,0.03,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[4856.5,21930.8,352.4],[[0.92,0.4,-0.02],[0.01,0.03,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_LSV_01_armed_F",[4966.8,21845.9,331.8],[[1,0.04,-0.01],[0.01,-0.09,1]],[4],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_MRAP_01_gmg_F",[4969.7,21839,331.6],[[0.98,0.18,0.01],[0.01,-0.15,0.99]],[4],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
		[
		WEST,
		[],
		[
			["B_officer_F",[4889.1,21982.7,20.7],14,[1,2],"STAND",[]],
			["B_officer_F",[4888,21987.1,22],85,[1,2],"STAND",[]],
			["B_ghillie_ard_F",[4893.1,21989.2,22.5],0,[1],"STAND",[]],
			["B_ghillie_ard_F",[4886.1,21988.1,22.4],0,[1],"STAND",[]],
			["B_Officer_Parade_Veteran_F",[4891.3,21983.1,20.6],298,[1],"STAND",[[],[],[],["U_B_ParadeUniform_01_US_decorated_F",[]],[],[],"H_HeadBandage_bloody_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]]]
		],
		[
			["B_HMG_01_high_F",[4893.2,21977.9,347.9],[[-0.01,-1,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_G_Offroad_01_armed_F",[4862.1,21910.2,339.2],[[-0.72,-0.63,-0.3],[-0.04,-0.4,0.92]],[4],[["B_G_Soldier_F",["turret",[0]],[],[]]]],
			["B_G_Offroad_01_armed_F",[4830.7,21933.7,340.2],[[-0.98,-0.21,-0.08],[-0.04,-0.16,0.99]],[4],[["B_G_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_recon_M_F",[4852.7,21999.7,7.3],340,[],"STAND",[]]
		],
		[
			["B_HMG_01_high_F",[4886.4,21998.3,345.9],[[0.95,0.3,-0.01],[0.01,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[4870,21997.4,344.3],[[-0.01,0.99,0.11],[-0.02,-0.11,0.99]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[4875,21999,345.6],[[0,1,0.06],[-0.09,-0.06,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_SAM_System_03_F",[4843.1,22007.7,341],[[0,1,0],[0,0,1]],[],[["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_lsh_F",[4870.4,21917.5,14.5],210,[1],"STAND",[]]
		],
		[],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_F",[4878.2,21929.5,348.4],[[-0.92,-0.39,-0.04],[-0.03,-0.04,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[4881.7,21923,348.7],[[-0.88,0.47,-0.02],[-0.06,-0.07,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[4869.7,21932.9,348.6],[[-0.5,-0.86,-0.11],[-0.09,-0.07,0.99]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[4890.2,21926.7,348.9],[[0.17,0.99,0.02],[-0.02,-0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[4875.9,21919.4,353],[[0.12,-0.99,0.05],[-0.04,0.04,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[4886.1,21913,354.8],[[-0.16,-0.98,0.07],[-0.1,0.09,0.99]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[4899.8,21922.5,353.7],[[0.85,-0.44,-0.3],[0.26,-0.14,0.95]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_G_HMG_02_high_F",[4889.8,21936.7,349],[[-0.49,-0.87,0.02],[0.07,-0.01,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_static_AA_F",[4893,21940.6,355.8],[[0.12,-0.99,0.04],[-0.07,0.04,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
		["B_AFV_Wheeled_01_up_cannon_F",[4898,21826.3,330.9],[[-0.97,0.26,0.01],[0.02,0.05,1]],[],[["B_T_Crew_F",["driver"],[],[]],["B_T_Crew_F",["turret",[0]],[],[]],["B_T_Crew_F",["turret",[0,0]],[],[]]]]
		],
		[
			[[4899.63,21828.3,0.115204],"MOVE"],
			[[4569.83,21861.1,3.05176e-005],"MOVE"],
			[[4617.75,21664.1,-3.05176e-005],"MOVE"],
			[[4577.35,21867.2,-3.05176e-005],"MOVE"],
			[[4887.79,21834.8,3.05176e-005],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["I_Heli_light_03_dynamicLoadout_F",[4830.3,21966.3,339.3],[[-0.23,-0.97,0.11],[-0.04,0.13,0.99]],[],[["B_Helipilot_F",["driver"],[],[]],["B_Helipilot_F",["turret",[0]],[],[]],["B_Helipilot_F",["cargo",[1]],[],[]],["B_Helipilot_F",["cargo",[2]],[],[]]]]
		],
		[
			[[4830.39,21966.2,0.00765991],"MOVE"],
			[[4540.5,22138.5,321.953],"MOVE"],
			[[4645.98,21610.7,321.953],"MOVE"],
			[[5207.4,21683.6,321.953],"MOVE"],
			[[5079.75,22183.8,321.953],"MOVE"],
			[[4602.34,22142.4,311.106],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[4940.3,21923.5,0],134,[],"STAND",[]],
			["B_Soldier_F",[4935.8,21924.2,0],134,[],"STAND",[]],
			["B_soldier_LAT_F",[4934.9,21929.9,0],134,[],"STAND",[]],
			["B_Soldier_TL_F",[4932.1,21928.1,0],134,[],"STAND",[]],
			["B_soldier_AR_F",[4939.4,21928.2,0],134,[],"STAND",[]]
		],
		[],
		[
			[[4940.28,21923.5,0.0093689],"MOVE"],
			[[4949.81,21831,0],"MOVE"],
			[[4915.5,21901.1,0],"MOVE"],
			[[4938.16,21919.7,0.000152588],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[],
		[
			["B_G_HMG_02_high_F",[4915.2,21926.4,345.6],[[0.38,-0.92,-0.06],[0.25,0.04,0.97]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[4855.8,21869.8,340.4],[[0.54,0.84,-0.01],[0,0.02,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_F",[4850.3,21873.6,337.5],[[0.43,0.9,-0.03],[0.02,0.03,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_high_F",[4839.5,21892.8,338.4],[[-0.79,-0.61,0.06],[0.08,-0.01,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_HMG_01_F",[4804.8,21976.8,345.1],[[0.44,-0.9,-0.03],[0.01,-0.03,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_G_HMG_02_high_F",[4802,21929.5,336.5],[[0.54,-0.84,-0.03],[-0.06,-0.07,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_static_AT_F",[4794.5,21902.9,332.8],[[-0.56,-0.82,-0.06],[0.02,-0.09,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[4915,21947,0],69,[],"STAND",[]],
			["B_soldier_AA_F",[4912.2,21940.6,0],69,[],"STAND",[]],
			["B_soldier_AA_F",[4908.6,21949.9,0],69,[],"STAND",[]],
			["B_soldier_AAA_F",[4910.4,21945.4,0],69,[],"STAND",[]]
		],
		[],
		[
			[[4915.02,21947,0.00921631],"MOVE"],
			[[4844.52,21965.8,-0.00012207],"MOVE"],
			[[4920.12,21951.2,0.000335693],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[4952.7,21990.6,0],57,[],"STAND",[]],
			["B_soldier_AR_F",[4950.4,21984.1,0],57,[],"STAND",[]],
			["B_HeavyGunner_F",[4949.1,21990.1,0],57,[],"STAND",[]],
			["B_soldier_AAR_F",[4948.1,21983.8,0],57,[],"STAND",[]],
			["B_soldier_LAT_F",[4947,21987.8,0],57,[],"STAND",[]]
		],
		[],
		[
			[[4952.74,21990.6,0.0244446],"MOVE"],
			[[5064.79,21996.1,0],"MOVE"],
			[[4957.17,21982.2,0.00125122],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_TL_F",[4887.6,21878.8,0],239,[],"STAND",[]],
			["B_soldier_UAV_F",[4889.3,21885.6,0],239,[],"STAND",[]]
		],
		[
			["B_UGV_01_rcws_F",[4883.8,21884.9,336.1],[[-0.48,0.88,-0.03],[-0.06,0.01,1]],[],[["B_UAV_AI",["driver"],[],[]],["B_UAV_AI",["turret",[0]],[],[]]]]
		],
		[
			[[4887.62,21878.8,0.00128174],"MOVE"],
			[[4819.48,21930.2,0],"MOVE"],
			[[4875.66,21882.2,0],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_Soldier_SL_F",[4837,21912,0],175,[],"STAND",[]],
			["B_soldier_AR_F",[4834.7,21915.1,0],175,[],"STAND",[]],
			["B_HeavyGunner_F",[4838.5,21914.2,0],175,[],"STAND",[]],
			["B_soldier_AAR_F",[4833,21912.5,0],175,[],"STAND",[]]
		],
		[],
		[
			[[4837.01,21912,0.00326538],"MOVE"],
			[[4750.36,21878,0],"MOVE"],
			[[4830.01,21922.3,-0.000244141],"CYCLE"]
		]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_ard_F",[4798.1,21846.7,0],139,[1],"STAND",[]]
		],
		[
			["B_HMG_01_high_F",[4795.2,21845.3,324.2],[[-0.92,-0.38,-0.11],[-0.1,-0.06,0.99]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_G_HMG_02_high_F",[4843.1,21977.6,339.1],[[-0.35,-0.94,0.04],[-0.01,0.05,1]],[],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]],
			["B_APC_Tracked_01_AA_F",[4851.3,21986.5,339.7],[[1,0.03,-0.05],[0.05,0.02,1]],[4],[["B_crew_F",["turret",[0]],[],[]],["B_crew_F",["turret",[0,0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[
			["B_ghillie_ard_F",[4867.6,21947,18.3],112,[1],"STAND",[]]
		],
		[
			["B_HMG_01_high_F",[4867.1,21949.2,363.5],[[0.36,0.93,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]],
			["B_HMG_01_high_F",[4865.2,21946.2,363.5],[[-0.4,-0.92,0],[0,0,1]],[],[["B_Soldier_F",["turret",[0]],[],[]]]]
		],
		[]
	],
	[
		WEST,
		[],
		[],
		[
			["B_G_Offroad_01_AT_F",[4931.3,21893.2,341.8],[[0.82,-0.55,-0.17],[0.15,-0.08,0.99]],[4],[["B_Soldier_unarmed_F",["turret",[0]],[],[]]]]
		],
		[]
	]
];
_pmissBaseTurrets = [];
_pmissEmptyVehs = [
	["B_LSV_01_unarmed_F",[4798.9,21918.2,335.7],[[-0.4,-0.89,-0.19],[-0.04,-0.19,0.98]]],
	["B_Truck_01_flatbed_F",[4893.3,21866.8,337.2],[[0,1,0.03],[-0.03,-0.03,1]]],
	["B_G_Quadbike_01_F",[4887.4,21872.9,335.9],[[0,1,-0.03],[-0.06,0.03,1]]],
	["B_G_Offroad_01_repair_F",[4884,21872.1,335.9],[[0,1,-0.04],[-0.05,0.04,1]]],
	["I_E_Offroad_01_comms_F",[4879.2,21874.3,335.5],[[0,1,-0.04],[-0.11,0.04,0.99]]],
	["B_MRAP_01_F",[4791.3,21916.2,335.2],[[-0.35,-0.92,-0.15],[-0.09,-0.13,0.99]]],
	["B_APC_Tracked_01_CRV_F",[4900.4,21868,337],[[0,1,0.02],[0.04,-0.02,1]]]
];
_doors = [];
_delete = [];
_pmissBuildingsEh = [];
_pmissBuildings = [
	["Land_Castle_01_tower_F",[4866.44,21947.4,353.946],[[-0.91165,0.410965,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_Sign_WarningMilAreaSmall_F",[4784.2,21839.1,319.66],[[0.9,0.42,0.07],[-0.07,-0.03,1]],true],
	["Land_LampStreet_F",[4756.73,21820.7,319.84],[[-0.47,0.88,0],[0,0,1]],true],
	["Land_LampStreet_F",[4777.71,21832.8,323.91],[[-0.69,0.73,0],[0,0,1]],true],
	["Land_LampStreet_F",[4732.62,21812.8,315.65],[[-0.41,0.91,0],[0,0,1]],true],
	["Land_SignM_WarningMilitaryArea_english_F",[4782.08,21851,320.02],[[0.92,0.38,0.05],[-0.04,-0.02,1]],true],
	["Land_SignM_WarningMilitaryArea_english_F",[4785.07,21841.3,319.84],[[0.92,0.38,0.08],[-0.07,-0.04,1]],true],
	["Land_Sign_WarningMilAreaSmall_F",[4779.41,21851.3,319.8],[[0.9,0.41,0.13],[-0.11,-0.09,0.99]],true],
	["Land_PortableLight_double_F",[4787.47,21855.2,320.54],[[0.93,0.36,0],[0,0,1]],true],
	["Land_PortableLight_double_F",[4791.44,21845,320.49],[[0.89,0.46,0],[0,0,1]],true],
	["RoadBarrier_F",[4789.25,21843.1,319.72],[[-0.92,-0.38,-0.09],[-0.08,-0.04,1]],false],
	["RoadBarrier_F",[4784.36,21853.4,319.68],[[-0.87,-0.49,-0.05],[-0.05,-0.03,1]],false],
	["Land_BagBunker_Tower_F",[4797.17,21845.3,322.12],[[0.91,0.41,0.11],[-0.1,-0.06,0.99]],true],
	["Land_CncBarrier_F",[4796.26,21840.3,319.96],[[0.43,-0.9,-0.01],[-0.08,-0.04,1]],false],
	["Land_CncBarrier_F",[4786.65,21860.8,320.26],[[-0.39,0.92,0.05],[-0.09,-0.09,0.99]],false],
	["Land_CncBarrier_F",[4786.32,21854.1,319.66],[[-0.9,-0.43,-0.1],[-0.09,-0.04,0.99]],false],
	["Land_CncBarrier_F",[4793.79,21840.1,319.77],[[-0.38,-0.92,-0.07],[-0.08,-0.04,1]],false],
	["Land_CncBarrier_F",[4791.99,21841.8,319.7],[[-0.9,-0.43,-0.09],[-0.08,-0.04,1]],false],
	["Land_CncBarrier_F",[4785.15,21856.5,319.73],[[-0.9,-0.42,-0.12],[-0.09,-0.09,0.99]],false],
	["Land_CncBarrier_F",[4790.82,21844.1,319.71],[[-0.9,-0.42,-0.09],[-0.08,-0.04,1]],false],
	["Land_CncBarrier_F",[4785.01,21859,319.94],[[-0.94,0.33,-0.06],[-0.09,-0.09,0.99]],false],
	["Campfire_burning_F",[4788.73,21911.1,332.83],[[0,0.99,0.13],[-0.04,-0.13,0.99]],true],
	["Land_LampSolar_F",[4777.25,21920.5,335.21],[[-0.72,-0.69,0],[0,0,1]],true],
	["Land_LampStreet_F",[4875.76,21829.5,333.26],[[0.15,0.99,0],[0,0,1]],true],
	["Land_LampStreet_F",[4828.08,21850.5,329.49],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_F",[4850.27,21841.5,331.11],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_F",[4806.03,21849.5,327.12],[[-0.41,0.91,0],[0,0,1]],true],
	["Land_BagFence_Round_F",[4838.93,21892.2,337.38],[[0.83,0.55,-0.05],[0.07,-0.02,1]],false],
	["Land_BagFence_Round_F",[4802.56,21929.1,335.21],[[-0.46,0.89,0.07],[-0.11,-0.13,0.99]],false],
	["Land_CzechHedgehog_01_new_F",[4983.68,21838.9,330],[[0,0.99,0.12],[-0.01,-0.12,0.99]],false],
	["Land_CzechHedgehog_01_new_F",[4986.02,21837.5,329.86],[[0,0.99,0.12],[-0.01,-0.12,0.99]],false],
	["Land_LampStreet_F",[4946.44,21823.4,334.81],[[0,1,0],[0,0,1]],true],
	["Land_CzechHedgehog_01_new_F",[4988.62,21839.9,330.16],[[0,1,0],[0.04,0,1]],false],
	["Land_LampStreet_F",[4897.6,21819.5,335.31],[[0,1,0],[0,0,1]],true],
	["Land_LampStreet_F",[4922.57,21818.8,335.73],[[0,1,0],[0,0,1]],true],
	["Land_CzechHedgehog_01_new_F",[4988.44,21846.3,330.37],[[0,1,0.03],[0.02,-0.03,1]],false],
	["Land_Sign_WarningMilAreaSmall_F",[4811.72,21908.7,333.43],[[0.16,0.99,0],[0,0,1]],true],
	["Land_CzechHedgehog_01_new_F",[4985.81,21845.9,330.39],[[0,1,0.03],[0.01,-0.03,1]],false],
	["Land_LampSolar_F",[4923.44,21851.1,334.79],[[-0.7,-0.71,0],[0,0,1]],true],
	["Land_HBarrierTower_F",[4855.42,21870,338.67],[[0.48,0.88,-0.01],[0,0.02,1]],false],
	["Land_CzechHedgehog_01_new_F",[4980.98,21846.9,330.47],[[0,1,0.06],[-0.01,-0.06,1]],false],
	["PortableHelipadLight_01_yellow_F",[4828.63,21959.8,338.59],[[0.3,0.95,0.03],[-0.08,-0.01,1]],true],
	["Land_CzechHedgehog_01_new_F",[4984.61,21848.1,330.55],[[0,0.99,0.12],[0.01,-0.12,0.99]],false],
	["Land_PortableLight_02_quad_sand_F",[4975.03,21833.1,328.89],[[-0.63,0.78,0],[0,0,1]],true],
	["Land_SignM_WarningMilitaryArea_english_F",[4980.33,21850.2,331.07],[[-1,-0.07,0],[0,0,1]],true],
	["Land_LampSolar_F",[4814,21951.2,341.98],[[-0.66,0.75,0],[0,0,1]],true],
	["SatelliteAntenna_01_Small_Sand_F",[4973.08,21837.3,329.21],[[0.95,0.31,0.06],[0,-0.17,0.98]],false],
	["Land_BagFence_Round_F",[4805.18,21976.3,343.78],[[-0.45,0.89,0],[0,0,1]],false],
	["Land_CzechHedgehog_01_new_F",[4973.25,21831.2,328.5],[[0,1,0.06],[0.11,-0.06,0.99]],false],
	["PortableHelipadLight_01_yellow_F",[4826.67,21972.1,337.54],[[-0.28,-0.96,0.02],[-0.02,0.03,1]],true],
	["Land_Sign_WarningMilAreaSmall_F",[4980.61,21848.3,330.82],[[-1,-0.08,0],[0,0,1]],true],
	["PortableHelipadLight_01_yellow_F",[4823.18,21961.5,338.05],[[0.3,0.95,-0.05],[-0.08,0.08,0.99]],true],
	["Land_CzechHedgehog_01_new_F",[4969.67,21825.6,328.46],[[0,1,0.02],[0.1,-0.02,1]],false],
	["Land_CzechHedgehog_01_new_F",[4962.48,21827.8,329.05],[[0,1,0.01],[0.04,-0.01,1]],false],
	["Land_CzechHedgehog_01_new_F",[4970.83,21830.7,328.64],[[0.37,0.93,0.04],[0.06,-0.07,1]],false],
	["Land_CzechHedgehog_01_new_F",[4972.49,21827.7,328.35],[[0,1,0.07],[0.06,-0.07,1]],false],
	["Land_CzechHedgehog_01_new_F",[4967.52,21828.5,328.74],[[0,1,0.02],[0.1,-0.02,1]],false],
	["Land_CzechHedgehog_01_new_F",[4971.55,21833.2,328.82],[[0,0.99,0.12],[0.04,-0.12,0.99]],false],
	["Land_LampSolar_F",[4878.28,21897.3,338.13],[[-0.63,0.77,0],[0,0,1]],true],
	["Land_CzechHedgehog_01_new_F",[4969.52,21828.4,328.57],[[0.37,0.93,0.01],[0.08,-0.04,1]],false],
	["Land_PortableLight_02_single_sand_F",[4894.08,21879.3,335.1],[[-0.88,-0.47,0],[0,0,1]],true],
	["Land_LampSolar_F",[4843.04,21922.6,342.5],[[-0.66,0.75,0],[0,0,1]],true],
	["Campfire_burning_F",[4905.37,21874.5,334.99],[[0,1,0.02],[0.04,-0.02,1]],true],
	["Land_CzechHedgehog_01_new_F",[4964.96,21825.1,328.91],[[0,1,0.02],[0.05,-0.02,1]],false],
	["Land_CzechHedgehog_01_new_F",[4967.5,21824.9,328.65],[[0.01,0.99,0.14],[0.1,-0.14,0.99]],false],
	["Land_CzechHedgehog_01_new_F",[4971.5,21825.9,328.31],[[0.01,1,0.02],[0.08,-0.02,1]],false],
	["Land_CzechHedgehog_01_new_F",[4965.57,21828.1,328.92],[[0,1,0.02],[0.1,-0.02,1]],false],
	["PortableHelipadLight_01_yellow_F",[4833.84,21958.1,339.02],[[0.3,0.95,-0.06],[-0.05,0.07,1]],true],
	["Land_SignM_WarningMilitaryArea_english_F",[4978.63,21835,329.34],[[-1,-0.05,0],[0,0,1]],true],
	["O_CargoNet_01_ammo_F",[4903.19,21883.7,335.9],[[0,1,0.06],[-0.07,-0.06,1]],false],
	["Land_Sign_WarningMilAreaSmall_F",[4979.81,21838.2,329.96],[[-0.99,-0.1,0],[0,0,1]],true],
	["B_CargoNet_01_ammo_F",[4902.32,21882,335.75],[[0,1,0.06],[-0.07,-0.06,1]],false],
	["Land_DieselGroundPowerUnit_01_F",[4963.18,21838.5,329.87],[[0,0.99,0.13],[-0.01,-0.13,0.99]],false],
	["Land_Razorwire_F",[4975.44,21836.9,329.38],[[0.85,-0.52,-0.09],[0,-0.17,0.98]],false],
	["I_CargoNet_01_ammo_F",[4901.35,21883.7,335.78],[[0,1,0.06],[-0.07,-0.06,1]],false],
	["Land_GuardTower_02_F",[4871.16,21919,355.06],[[-0.42,-0.91,0],[0,0,1]],true,{_pmissBuildingsEh pushBack _this;}],
	["CargoNet_01_barrels_F",[4899.63,21884.1,335.39],[[-0.96,0.29,-0.05],[-0.06,-0.06,1]],false],
	["PortableHelipadLight_01_yellow_F",[4831.62,21970.6,337.76],[[0.31,0.95,-0.01],[-0.06,0.03,1]],true],
	["CamoNet_OPFOR_big_F",[4964.67,21840.9,331.37],[[-1,-0.01,0.01],[0.01,-0.08,1]],true],
	["CargoNet_01_barrels_F",[4899.45,21883.1,336.37],[[-0.87,0.5,-0.02],[-0.04,-0.04,1]],false],
	["PortableHelipadLight_01_yellow_F",[4837.37,21968.8,338.09],[[0.31,0.95,-0.09],[0.01,0.1,1]],true],
	["CargoNet_01_barrels_F",[4896.85,21879.7,335.37],[[-0.97,0.07,-0.24],[0.26,0.29,-0.92]],false],
	["Land_FoodSacks_01_large_brown_idap_F",[4959.27,21855.5,331.06],[[0,0.99,0.17],[0.01,-0.17,0.99]],false],
	["CargoNet_01_barrels_F",[4897.55,21883,335.25],[[-0.97,0.24,-0.03],[-0.03,-0.02,1]],false],
	["Land_FoodSacks_01_large_white_idap_F",[4961.7,21855.7,331.07],[[0,0.99,0.17],[0.01,-0.17,0.99]],false],
	["CargoNet_01_barrels_F",[4898,21884.6,335.37],[[-0.95,0.3,-0.02],[-0.06,-0.12,0.99]],false],
	["Land_WaterBottle_01_stack_F",[4961.76,21852.9,330.94],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_Razorwire_F",[4863.59,21924.1,344.12],[[0.98,-0.06,0.16],[-0.17,-0.34,0.92]],false],
	["CargoNet_01_barrels_F",[4899.26,21882.6,335.31],[[-0.94,0.35,-0.03],[-0.04,-0.03,1]],false],
	["Land_PaperBox_01_open_boxes_F",[4957.79,21857.8,331.66],[[0,0.99,0.17],[0.03,-0.17,0.98]],false],
	["Land_HelipadSquare_F",[4830.23,21965.1,337.95],[[-0.31,-0.95,0.1],[-0.05,0.12,0.99]],true],
	["Land_Razorwire_F",[4866.4,21918.4,342.03],[[0.57,-0.78,-0.27],[-0.17,-0.43,0.88]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4955.88,21853.8,330.55],[[-0.99,0.15,-0.03],[-0.04,-0.08,1]],false],
	["Land_LampSolar_F",[4864.85,21903.2,338.8],[[-0.63,0.77,0],[0,0,1]],true],
	["Land_PaperBox_01_small_closed_white_med_F",[4958.86,21853.4,330.99],[[-0.93,0.36,0.04],[0.01,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_white_med_F",[4958.61,21853.5,330.59],[[-0.93,0.36,0.04],[0.01,-0.08,1]],false],
	["Land_LampSolar_F",[4841.59,21994.6,340.74],[[-0.9,-0.43,0],[0,0,1]],true],
	["Land_BagFence_Round_F",[4867.18,21950,362.31],[[-0.5,-0.86,0],[0,0,1]],false],
	["Land_PaperBox_01_small_closed_white_med_F",[4959.42,21853.3,330.98],[[-0.89,0.45,0.05],[0.01,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_white_med_F",[4960.11,21853.2,330.96],[[-0.93,0.36,0.04],[0.01,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_white_med_F",[4959.74,21853.4,331.39],[[-0.87,-0.5,-0.03],[0.01,-0.08,1]],false],
	["Land_LampSolar_F",[4915.38,21919.2,347.86],[[-0.37,-0.93,0],[0,0,1]],true],
	["Land_PaperBox_01_small_closed_white_med_F",[4959.06,21853.3,331.39],[[-0.87,-0.49,-0.03],[0.01,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4956.58,21853.7,331.4],[[-0.99,0.15,-0.03],[-0.04,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4956.97,21853.7,331.83],[[-0.99,0.16,-0.03],[-0.04,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4956.26,21853.8,330.98],[[-0.99,0.15,-0.03],[-0.04,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4957.92,21853.6,330.6],[[-0.99,0.15,0.02],[0.01,-0.08,1]],false],
	["Land_Communication_F",[4886.3,21932.7,363.89],[[-0.44,-0.9,0],[0,0,1]],true,{_this setVariable ["brpvp_dome_radius",125,true];}],
	["Land_PaperBox_01_small_closed_white_med_F",[4959.77,21853.3,330.56],[[-0.93,0.36,0.04],[0.01,-0.08,1]],false],
	["Land_LampSolar_F",[4874.63,21931.5,351.17],[[-0.73,0.68,0],[0,0,1]],true],
	["Land_PaperBox_01_small_closed_white_med_F",[4960.32,21853.3,330.55],[[-0.89,0.46,0.05],[0.01,-0.08,1]],false],
	["Land_LampSolar_F",[4884.47,21936.6,358.24],[[0.68,0.73,0],[0,0,1]],true],
	["Land_Camping_Light_F",[4891.78,21982.4,358.87],[[0,1,0],[0,0,1]],true],
	["Land_PaperBox_01_small_closed_brown_food_F",[4957.29,21853.7,331.43],[[-0.99,0.15,-0.03],[-0.05,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4957.26,21853.7,330.61],[[-0.99,0.15,-0.03],[-0.04,-0.08,1]],false],
	["Land_MoneyBills_01_stack_F",[4889.24,21983.5,358.76],[[0,1,0],[0,0,1]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4956.55,21853.7,330.58],[[-0.99,0.15,-0.03],[-0.04,-0.08,1]],false],
	["Land_PaperBox_01_small_closed_brown_food_F",[4957.65,21853.7,331.02],[[-0.99,0.15,0.01],[0,-0.08,1]],false],
	["Land_MoneyBills_01_bunch_F",[4889.06,21984.1,358.73],[[0,1,0],[0,0,1]],false],
	["Land_LampSolar_F",[4896.1,21964.2,343.95],[[0.17,-0.98,0],[0,0,1]],true],
	["Land_PaperBox_01_small_closed_brown_food_F",[4956.93,21853.7,331],[[-0.99,0.14,-0.03],[-0.04,-0.08,1]],false],
	["Land_MoneyBills_01_roll_F",[4888.53,21984,358.75],[[0,1,0],[0,0,1]],false],
	["Land_PaperBox_01_small_closed_white_med_F",[4959.16,21853.4,330.58],[[-0.89,0.46,0.05],[0.01,-0.08,1]],false],
	["Land_MoneyBills_01_roll_F",[4888.96,21983.9,358.75],[[0,1,0],[0,0,1]],false],
	["Land_PortableLight_02_single_sand_F",[4955.16,21854.5,330.92],[[-0.97,-0.23,0],[0,0,1]],true],
	["Land_MoneyBills_01_roll_F",[4888.67,21984.3,358.75],[[0,1,0],[0,0,1]],false],
	["Land_PortableLight_02_quad_sand_F",[4972.87,21856,331.26],[[0.3,-0.95,0],[0,0,1]],true],
	["Land_CanisterFuel_F",[4966.95,21841.2,329.59],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_CanisterFuel_Red_F",[4966.67,21841.4,329.61],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_ControlTower_01_F",[4889.1,21984.7,353.9],[[-0.09,1,0],[0,0,1]],true,{[_this,false] remoteExecCall ["allowDamage",0];}],
	["Land_CanisterFuel_Red_F",[4966.28,21841.1,329.58],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_CanisterFuel_Red_F",[4966.87,21840.9,329.56],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_Money_F",[4888.49,21983.8,358.76],[[-1,0.08,0],[0,0,1]],false],
	["Land_Money_F",[4889.16,21984.3,358.76],[[-0.98,0.22,0],[0,0,1]],false],
	["Land_CanOpener_F",[4969.92,21843.3,330.37],[[0,1,0.09],[0.01,-0.09,1]],false],
	["Land_Money_F",[4888.68,21983.5,358.77],[[-0.7,-0.71,0],[0.02,-0.02,1]],false],
	["Land_TacticalBacon_F",[4969.86,21843.5,330.42],[[0.01,1,0.09],[0.01,-0.09,1]],false],
	["Land_Money_F",[4889.21,21983.8,358.76],[[-0.99,-0.1,0],[0,0,1]],false],
	["Land_TacticalBacon_F",[4969.84,21843.6,330.43],[[0.04,0.99,0.09],[0.01,-0.09,1]],false],
	["Land_Money_F",[4888.79,21984,358.76],[[0.26,-0.97,0],[0,0,1]],false],
	["Land_Tableware_01_spoon_F",[4970.01,21843.5,330.39],[[0,1,0.09],[0.01,-0.09,1]],false],
	["Land_Money_F",[4888.41,21984.2,358.76],[[-0.72,0.69,0],[0,0,1]],false],
	["Land_Money_F",[4888.93,21983.7,358.77],[[0,1,0],[-0.02,0,1]],false],
	["Land_BakedBeans_F",[4969.84,21843.2,330.41],[[0,1,0.09],[0.01,-0.09,1]],false],
	["Land_Money_F",[4888.94,21984.2,358.79],[[-0.79,-0.62,-0.01],[-0.09,0.1,0.99]],false],
	["Land_BakedBeans_F",[4969.77,21842.1,330.31],[[0.1,0.99,0.09],[0.01,-0.09,1]],false],
	["Land_Tableware_01_cup_F",[4970.14,21842.5,330.35],[[0.01,1,0.09],[0.01,-0.09,1]],false],
	["Land_Tableware_01_cup_F",[4970.08,21843.4,330.42],[[0,1,0.09],[0.01,-0.09,1]],false],
	["Box_I_E_UAV_06_F",[4888.37,21982.4,358.83],[[0,1,0],[0,0,1]],false],
	["Land_Can_Rusty_F",[4970.12,21842.8,330.37],[[0.32,-0.94,-0.09],[0.01,-0.09,1]],false],
	["Box_O_UAV_06_F",[4888.16,21983.2,358.83],[[0,1,0],[0,0,1]],false],
	["Land_Can_V2_F",[4970.22,21842.8,330.36],[[0.47,-0.88,-0.08],[0.01,-0.09,1]],false],
	["Box_O_UAV_06_F",[4888.68,21982.9,358.83],[[0,1,0],[0,0,1]],false],
	["Land_Tableware_01_knife_F",[4969.97,21843.6,330.39],[[0,1,0.09],[0.01,-0.09,1]],false],
	["Land_Canteen_F",[4969.81,21841.5,330.25],[[-0.1,-0.19,0.98],[0.02,-0.98,-0.19]],false],
	["Campfire_burning_F",[4974.03,21842.7,329.66],[[0,1,0.09],[-0.01,-0.09,1]],true],
	["Land_Compass_F",[4970.24,21841.8,330.23],[[-0.73,0.68,0.07],[0.01,-0.09,1]],false],
	["Land_CarBattery_02_F",[4969.69,21841.8,329.42],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_LampSolar_F",[4875.62,21994.4,340.96],[[-0.55,0.83,0],[0,0,1]],true],
	["Land_CarBattery_02_F",[4970.11,21841.8,329.42],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_LampSolar_F",[4866.46,21999.7,347.43],[[-1,-0.08,0],[0,0,1]],true],
	["Land_BatteryPack_01_battery_sand_F",[4970,21843.8,330.47],[[0,1,0.09],[0.01,-0.09,1]],false],
	["Land_BatteryPack_01_battery_sand_F",[4970.16,21843.8,330.46],[[0,1,0.09],[0.01,-0.09,1]],false],
	["OmniDirectionalAntenna_01_sand_F",[4969.44,21851.3,332.19],[[0,1,0.05],[0.02,-0.05,1]],false],
	["Land_PortableDesk_01_sand_F",[4969.91,21842.7,329.87],[[1,0.04,-0.01],[0.01,-0.09,1]],false],
	["Land_Laptop_03_sand_F",[4969.69,21843.8,330.57],[[0.62,-0.78,-0.08],[0.01,-0.09,1]],false],
	["Land_Router_01_sand_F",[4970.15,21842.2,330.37],[[-0.99,-0.13,0],[0.01,-0.09,1]],false],
	["Land_BatteryPack_01_open_sand_F",[4970.01,21843.4,329.74],[[0,1,0.09],[0,-0.09,1]],false],
	["Land_PortableGenerator_01_sand_F",[4965.74,21844.5,329.96],[[-0.02,1,0.08],[0.01,-0.08,1]],false],
	["Land_MultiScreenComputer_01_closed_sand_F",[4969.89,21842.5,330.55],[[-0.84,0.53,0.05],[0.01,-0.09,1]],false],
	["Newspaper_01_F",[4969.77,21843,330.36],[[0.64,-0.77,-0.07],[0.01,-0.09,1]],false],
	["Land_Photos_V1_F",[4970.11,21843.1,330.35],[[-0.85,-0.53,-0.02],[0.01,-0.05,1]],false],
	["Land_Pallet_MilBoxes_F",[4964.8,21841.8,329.82],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_Pallet_MilBoxes_F",[4964.74,21843.3,329.95],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_Pallet_MilBoxes_F",[4963.1,21841.8,329.84],[[0,0.99,0.1],[-0.01,-0.1,0.99]],false],
	["Land_DeskChair_01_black_F",[4968.03,21843.3,329.69],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_DeskChair_01_olive_F",[4967.18,21842.3,329.62],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_DeskChair_01_sand_F",[4967.94,21841.3,329.53],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_BoreSighter_01_F",[4969.9,21841.8,330.27],[[-0.41,-0.43,-0.81],[-0.48,-0.65,0.59]],false],
	["Land_Camping_Light_F",[4967.2,21842.3,329.95],[[0,1,0.1],[0.01,-0.1,1]],true],
	["Land_BarGate_F",[4978.9,21843.2,333.77],[[-1,-0.01,0.02],[0.03,-0.05,1]],true],
	["Land_PaperBox_01_small_stacked_F",[4959.54,21857.9,331.72],[[0,0.99,0.17],[0.01,-0.17,0.99]],false],
	["Land_PaperBox_01_small_stacked_F",[4961.32,21857.9,331.7],[[0,0.99,0.17],[0.01,-0.17,0.99]],false],
	["Land_PaperBox_01_small_stacked_F",[4963.05,21857.7,331.6],[[0,0.99,0.11],[0.07,-0.11,0.99]],false],
	["Land_MedicalTent_01_CSAT_brownhex_generic_inner_F",[4959.57,21855.7,331.99],[[-0.99,0.13,0.03],[0.01,-0.17,0.99]],true],
	["Land_SignM_WarningMilAreaSmall_english_F",[4965.82,21857,331.68],[[-1,0.05,0],[0,0,1]],true],
	["Land_SignM_WarningMilAreaSmall_english_F",[4974.51,21868.6,331.6],[[-1,0.06,0],[0,0,1]],true],
	["B_CargoNet_01_ammo_F",[4962.82,21844,330.4],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_TankEngine_01_F",[4958.82,21843.3,330.24],[[0,0.99,0.1],[-0.01,-0.1,0.99]],false],
	["Land_TankEngine_01_F",[4959.88,21840.9,330],[[0.1,-0.99,-0.1],[-0.01,-0.1,0.99]],false],
	["Land_TankEngine_01_used_F",[4960.96,21843.7,330.31],[[0,1,0.08],[0.01,-0.08,1]],false],
	["Land_Razorwire_F",[4976.13,21852,330.81],[[-0.95,-0.3,-0.09],[-0.05,-0.13,0.99]],false],
	["Land_Razorwire_F",[4975.34,21859.5,331.36],[[0.98,-0.2,0.04],[-0.05,-0.04,1]],false],
	["Land_Razorwire_F",[4976.72,21867.5,331.26],[[0.98,-0.2,-0.04],[0.05,0.05,1]],false]
];

private _ata = [];
private _nos = [];
private _ts = [];
private _vd = [];
private _hide = [];
private _noLagWait = 0.1;
{
	_x params ["_pw","_rad"];
	{
		private _isHide = _x in _hide;
		private _noClass = typeOf _x isEqualTo "";
		private _isBuilding = _x isKindOf "Building";
		private _isWall = _x isKindOf "Wall";
		private _isFurniture = _x isKindOf "Furniture_base_F";
		if (!_isHide && (_noClass || _isBuilding || _isWall || _isFurniture)) then {
			_x hideObject true;
			[_x,false] remoteExecCall ["allowDamage",0];
			[_x,true] remoteExecCall ["hideObjectGlobal",2];
			_hide pushBack _x;
		};
	} forEach nearestObjects [ASLToAGL _pw,[],_rad,true];
	uiSleep _noLagWait;
} forEach [
	[[4866.44,21947.4,353.946],02]
];

//GOD MOD BUILDINGS: CLASSNAME IN ARRAY
{
	{[_x,false] remoteExecCall ["allowDamage",2];} forEach nearestObjects [_place,[_x],_rad,true];
} forEach [];

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
					_suitCase setVariable ["mny",round (7500000*BRPVP_missionValueMult),true];
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
				//_u disableAI "FSM";
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
	_x params ["_posW","_dir","_q","_vu"];
	private _box = createVehicle ["Box_NATO_Equip_F",[0,0,0],[],15,"NONE"];
	_box allowDamage false;
	_box setPosASL (_posW vectorAdd _pFix);
	_box setDir _dir;
	_box setVectorUp _vu;
	[_box,0,1,true,_q] call BRPVP_createCompleteLootBox;
	uiSleep _noLagWait;
} forEach [
	[[4890.51,21982.6,358.754],267,40,[0,0,1]],
	[[4957.34,21855.7,330.668],188,15,[0.07,-0.18,0.98]],
	[[4888.33,21921.4,347.174],178,15,[0,0,1]],
	[[4865.48,21947.8,361.886],267,50,[0,0,1]]
];
_ata remoteExecCall ["BRPVP_updateAIUnitsArray",2];

BRPVP_pmissObjects = [_place,_rad,_nos,_ts,[],[],_vd,_hide,{true}];
BRPVP_pmissSpawning = false;