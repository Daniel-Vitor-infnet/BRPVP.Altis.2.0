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

//START TURRETS FUNCTIONS
BRPVP_jetBombDo = [];
BRPVP_uberAttackMonitor = {};
call compile preprocessFileLineNumbers "hc_code\turrets.sqf";

//VARS
BRPVP_missionWestGroupsCUP = [];
if ("CUP_B_CZ_SpecOps_DES" call BRPVP_classExists) then {
	//[OTHER UNITS,GL,MG,AT,AA]
	private _missionWestGroupsCUPType = [
		[4,1,1,0,0],
		[4,0,0,1,1],
		[4,2,0,0,0],
		[4,0,2,0,0],
		[4,0,0,2,0],
		[4,0,0,0,2],
		[4,1,0,1,0],
		[4,1,0,0,1],
		[4,0,1,1,0],
		[4,0,1,0,1],
		[6,0,0,0,0],
		[2,1,1,1,1],
		[2,1,1,1,1],
		[0,2,2,1,1],
		[0,1,1,2,2]
	];
	private _missionWestGroupsCUPBase = [
		[["CUP_B_CZ_SpecOps_DES","CUP_B_CZ_SpecOps_Exp_DES","CUP_B_CZ_SpecOps_Recon_DES","CUP_B_CZ_SpecOps_Scout_DES","CUP_B_CZ_SpecOps_TL_DES"],["CUP_B_CZ_SpecOps_GL_DES"],["CUP_B_CZ_SpecOps_MG_DES"],[],[]],
		[["CUP_B_CZ_SpecOps_WDL","CUP_B_CZ_SpecOps_Exp_WDL","CUP_B_CZ_SpecOps_Recon_WDL","CUP_B_CZ_SpecOps_Scout_WDL","CUP_B_CZ_SpecOps_TL_WDL"],["CUP_B_CZ_SpecOps_GL_WDL"],["CUP_B_CZ_SpecOps_MG_WDL","CUP_B_CZ_SpecOps_MG_WDL"],[],[]],
		[["CUP_B_CZ_Soldier_ARPG_WDL","CUP_B_CZ_Sniper_WDL","CUP_B_CZ_Engineer_WDL","CUP_B_CZ_ExplosiveSpecialist_WDL","CUP_B_CZ_Soldier_WDL","CUP_B_CZ_Soldier_Unarmed_WDL","CUP_B_CZ_Soldier_Light_WDL","CUP_B_CZ_Soldier_AR_WDL","CUP_B_CZ_Soldier_SL_WDL","CUP_B_CZ_Soldier_Marksman_WDL","CUP_B_CZ_Medic_WDL","CUP_B_CZ_Spotter_WDL","CUP_B_CZ_Officer_WDL","CUP_B_CZ_Soldier_backpack_WDL","CUP_B_CZ_Soldier_805_WDL","CUP_B_CZ_Soldier_RPG_WDL"],["CUP_B_CZ_Soldier_805_GL_WDL"],["CUP_B_CZ_Soldier_MG_WDL","CUP_B_CZ_Soldier_AMG_WDL"],["CUP_B_CZ_Soldier_AT_WDL"],[]],
		[["CUP_B_CZ_Soldier_ARPG_DES","CUP_B_CZ_Sniper_DES","CUP_B_CZ_Engineer_DES","CUP_B_CZ_ExplosiveSpecialist_DES","CUP_B_CZ_Soldier_DES","CUP_B_CZ_Soldier_AR_DES","CUP_B_CZ_Soldier_Unarmed_DES","CUP_B_CZ_Soldier_Light_DES","CUP_B_CZ_Soldier_SL_DES","CUP_B_CZ_Soldier_Marksman_DES","CUP_B_CZ_Medic_DES","CUP_B_CZ_Spotter_DES","CUP_B_CZ_Officer_DES","CUP_B_CZ_Soldier_Backpack_DES","CUP_B_CZ_Soldier_805_DES","CUP_B_CZ_Soldier_RPG_DES"],["CUP_B_CZ_Soldier_805_GL_DES"],["CUP_B_CZ_Soldier_MG_DES","CUP_B_CZ_Soldier_AMG_DES"],["CUP_B_CZ_Soldier_AT_DES"],[]],
		[["CUP_B_BAF_Soldier_AsstAA_MTP","CUP_B_BAF_Soldier_AsstAT_MTP","CUP_B_BAF_Soldier_AsstAutoRifleman_MTP","CUP_B_BAF_Soldier_AsstGunnerArty_MTP","CUP_B_BAF_Soldier_AsstGunnerHMG_MTP","CUP_B_BAF_Soldier_Marksman_MTP","CUP_B_BAF_Soldier_SharpShooter_MTP","CUP_B_BAF_Soldier_Medic_MTP","CUP_B_BAF_Soldier_Engineer_MTP","CUP_B_BAF_Soldier_Repair_MTP","CUP_B_BAF_Soldier_Explosive_MTP","CUP_B_BAF_Soldier_Mine_MTP","CUP_B_BAF_Soldier_Rifleman_MTP","CUP_B_BAF_Soldier_RiflemanAT_MTP","CUP_B_BAF_Soldier_RiflemanLAT_MTP","CUP_B_BAF_Soldier_RiflemanLite_MTP","CUP_B_BAF_Soldier_AutoRifleman_MTP","CUP_B_BAF_Soldier_DeckCrew_MTP","CUP_B_BAF_Soldier_GunnerArty_MTP","CUP_B_BAF_Soldier_GunnerGMG_MTP","CUP_B_BAF_Soldier_GunnerHMG_MTP","CUP_B_BAF_Soldier_TeamLeader_MTP","CUP_B_BAF_Soldier_SquadLeader_MTP","CUP_B_BAF_Soldier_Diver_MTP","CUP_B_BAF_Spotter_MTP","CUP_B_BAF_Soldier_Officer_MTP","CUP_B_BAF_Soldier_Paratrooper_MTP","CUP_B_BAF_Soldier_AmmoBearer_MTP","CUP_B_BAF_Sniper_AS50_TWS_MTP","CUP_B_BAF_Sniper_AS50_MTP","CUP_B_BAF_Sniper_MTP","CUP_B_BAF_Spotter_L85TWS_MTP"],["CUP_B_BAF_Soldier_Grenadier_MTP"],["CUP_B_BAF_Soldier_HeavyGunner_MTP","CUP_B_BAF_Soldier_AsstGunnerGMG_MTP"],["CUP_B_BAF_Soldier_AT_MTP"],["CUP_B_BAF_Soldier_AA_MTP"]],
		[["CUP_B_BAF_Soldier_AsstAA_DDPM","CUP_B_BAF_Soldier_AsstAT_DDPM","CUP_B_BAF_Soldier_AsstAutoRifleman_DDPM","CUP_B_BAF_Soldier_AsstGunnerArty_DDPM","CUP_B_BAF_Soldier_AsstGunnerHMG_DDPM","CUP_B_BAF_Soldier_Marksman_DDPM","CUP_B_BAF_Soldier_SharpShooter_DDPM","CUP_B_BAF_Soldier_Medic_DDPM","CUP_B_BAF_Soldier_Diver_DDPM","CUP_B_BAF_Soldier_Engineer_DDPM","CUP_B_BAF_Soldier_Mine_DDPM","CUP_B_BAF_Soldier_Rifleman_DDPM","CUP_B_BAF_Soldier_RiflemanAT_DDPM","CUP_B_BAF_Soldier_RiflemanLAT_DDPM","CUP_B_BAF_Soldier_AutoRifleman_DDPM","CUP_B_BAF_Soldier_GunnerArty_DDPM","CUP_B_BAF_Soldier_TeamLeader_DDPM","CUP_B_BAF_Soldier_SquadLeader_DDPM","CUP_B_BAF_Spotter_DDPM","CUP_B_BAF_Soldier_Officer_DDPM","CUP_B_BAF_Soldier_Helipilot_DDPM","CUP_B_BAF_Sniper_AS50_TWS_DDPM","CUP_B_BAF_Sniper_AS50_DDPM","CUP_B_BAF_Sniper_DDPM","CUP_B_BAF_Spotter_L85TWS_DDPM"],["CUP_B_BAF_Soldier_Grenadier_DDPM"],["CUP_B_BAF_Soldier_HeavyGunner_DDPM"],["CUP_B_BAF_Soldier_AT_DDPM"],["CUP_B_BAF_Soldier_AA_DDPM"]],
		[["CUP_B_BAF_Soldier_AsstAutoRifleman_DPM","CUP_B_BAF_Soldier_AsstGunnerArty_DPM","CUP_B_BAF_Soldier_AsstGunnerGMG_DPM","CUP_B_BAF_Soldier_Marksman_DPM","CUP_B_BAF_Soldier_SharpShooter_DPM","CUP_B_BAF_Soldier_Medic_DPM","CUP_B_BAF_Soldier_Engineer_DPM","CUP_B_BAF_Soldier_Mine_DPM","CUP_B_BAF_Soldier_Rifleman_DPM","CUP_B_BAF_Soldier_RiflemanAT_DPM","CUP_B_BAF_Soldier_RiflemanLAT_DPM","CUP_B_BAF_Soldier_AutoRifleman_DPM","CUP_B_BAF_Soldier_TeamLeader_DPM","CUP_B_BAF_Soldier_RangeMaster_DPM","CUP_B_BAF_Soldier_SquadLeader_DPM","CUP_B_BAF_Spotter_DPM","CUP_B_BAF_Soldier_Officer_DPM","CUP_B_BAF_Soldier_Helipilot_DPM","CUP_B_BAF_Sniper_AS50_TWS_DPM","CUP_B_BAF_Sniper_AS50_DPM","CUP_B_BAF_Sniper_DPM","CUP_B_BAF_Spotter_L85TWS_DPM","CUP_B_BAF_Soldier_Crew_DPM","CUP_B_BAF_Soldier_Helicrew_DPM"],["CUP_B_BAF_Soldier_Grenadier_DPM"],[],["CUP_B_BAF_Soldier_AT_DPM"],["CUP_B_BAF_Soldier_AA_DPM"]],
		[["CUP_B_GER_BW_Fleck_Soldier_MG","CUP_B_GER_BW_Fleck_Soldier_AAA","CUP_B_GER_BW_Fleck_Soldier_AAT","CUP_B_GER_BW_Fleck_Soldier_Marksman","CUP_B_GER_BW_Fleck_Soldier_Scout","CUP_B_GER_Fleck_TankCommander","CUP_B_GER_BW_Fleck_Soldier_Engineer","CUP_B_GER_BW_Fleck_Soldier","CUP_B_GER_BW_Fleck_Soldier_TL","CUP_B_GER_BW_Fleck_Soldier_MG3","CUP_B_GER_BW_Fleck_Medic","CUP_B_GER_BW_Fleck_Soldier_Ammo","CUP_B_GER_BW_Fleck_Soldier_Sniper","CUP_B_GER_Fleck_Crew"],["CUP_B_GER_BW_Fleck_Soldier_GL"],["CUP_B_BAF_Soldier_HeavyGunner_DPM"],["CUP_B_GER_BW_Fleck_Soldier_AT","CUP_B_GER_BW_Fleck_Soldier_PZF_AT"],["CUP_B_GER_BW_Fleck_Soldier_AA"]],
		[["CUP_B_GER_BW_Soldier_AAA","CUP_B_GER_BW_Soldier_AAT","CUP_B_GER_BW_Soldier_Marksman","CUP_B_GER_BW_Soldier_Scout","CUP_B_GER_TankCommander","CUP_B_GER_BW_Soldier_Engineer","CUP_B_GER_BW_Soldier","CUP_B_GER_BW_Medic","CUP_B_GER_BW_Soldier_Ammo","CUP_B_GER_BW_Soldier_Sniper","CUP_B_GER_Crew","CUP_B_GER_BW_Soldier_TL"],["CUP_B_GER_BW_Soldier_GL"],["CUP_B_GER_BW_Soldier_MG","CUP_B_GER_BW_Soldier_MG3"],["CUP_B_GER_BW_Soldier_AT","CUP_B_GER_BW_Soldier_PZF_AT"],["CUP_B_GER_BW_Soldier_AA"]],
		[["CUP_B_GER_Soldier_Ammo","CUP_B_GER_Operator_EXP","CUP_B_GER_Operator_Medic","CUP_B_GER_Operator","CUP_B_GER_Operator_TL","CUP_B_GER_Soldier_AAA","CUP_B_GER_Soldier_AAT","CUP_B_GER_Soldier_Engineer","CUP_B_GER_Soldier_Engineer","CUP_B_GER_Medic","CUP_B_GER_Soldier","CUP_B_GER_Soldier_Scout","CUP_B_GER_Soldier_Sniper","CUP_B_GER_Soldier_TL"],["CUP_B_GER_Operator_GL","CUP_B_GER_Soldier_GL"],["CUP_B_GER_Soldier_MG","CUP_B_GER_Soldier_MG3"],["CUP_B_GER_Soldier_AT"],["CUP_B_GER_Soldier_AA"]],
		[["CUP_B_GER_Fleck_Soldier_Ammo","CUP_B_GER_Fleck_Operator_EXP","CUP_B_GER_Fleck_Operator_Medic","CUP_B_GER_Fleck_Operator","CUP_B_GER_Fleck_Operator_TL","CUP_B_GER_Fleck_Soldier_AAA","CUP_B_GER_Fleck_Soldier_AAT","CUP_B_GER_Fleck_Soldier_Engineer","CUP_B_GER_Fleck_Medic","CUP_B_GER_Fleck_Soldier","CUP_B_GER_Fleck_Soldier_Scout","CUP_B_GER_Fleck_Soldier_Sniper","CUP_B_GER_Fleck_Soldier_TL"],["CUP_B_GER_Fleck_Operator_GL","CUP_B_GER_Fleck_Soldier_GL"],["CUP_B_GER_Fleck_Soldier_MG","CUP_B_GER_Fleck_Soldier_MG3"],["CUP_B_GER_Fleck_Soldier_AT"],["CUP_B_GER_Fleck_Soldier_AA"]]
	];
	BRPVP_missionWestGroupsCUP = _missionWestGroupsCUPBase apply {
		_x params ["_ou","_gl","_mg","_at","_aa"];
		selectRandom _missionWestGroupsCUPType params ["_ouQ","_glQ","_mgQ","_atQ","_aaQ"];
		if (_gl isEqualTo []) then {_gl = _ou;};
		if (_mg isEqualTo []) then {_mg = _ou;};
		if (_at isEqualTo []) then {_at = _ou;};
		if (_aa isEqualTo []) then {_aa = _ou;};
		private _group = [];
		for "_i" from 1 to _ouQ do {_group pushBack selectRandom _ou;};
		for "_i" from 1 to _glQ do {_group pushBack selectRandom _gl;};
		for "_i" from 1 to _mgQ do {_group pushBack selectRandom _mg;};
		for "_i" from 1 to _atQ do {_group pushBack selectRandom _at;};
		for "_i" from 1 to _aaQ do {_group pushBack selectRandom _aa;};
		_group
	};
};

BRPVP_missionWestGroupsRHS = [];
private _rhsRussia = "rhs_vdv_mflora_sergeant" call BRPVP_classExists;
private _rhsUsa = "rhsusf_army_ocp_teamleader" call BRPVP_classExists;
if (_rhsRussia || _rhsUsa) then {
	//[OTHER UNITS,GL,MG,AT,AA]
	private _missionWestGroupsRHSType = [
		[4,1,1,0,0],
		[4,0,0,1,1],
		[4,2,0,0,0],
		[4,0,2,0,0],
		[4,0,0,2,0],
		[4,0,0,0,2],
		[4,1,0,1,0],
		[4,1,0,0,1],
		[4,0,1,1,0],
		[4,0,1,0,1],
		[6,0,0,0,0],
		[2,1,1,1,1],
		[2,1,1,1,1],
		[0,2,2,1,1],
		[0,1,1,2,2]
	];
	private _missionWestGroupsRHSBase = [];
	if (_rhsRussia) then {
		private _unitsRussia = [
			//OPFOR
			[["rhs_msv_emr_RShG2","rhs_msv_emr_LAT","rhs_msv_emr_rifleman","rhs_msv_emr_officer_armored","rhs_msv_emr_officer","rhs_msv_emr_medic","rhs_msv_emr_marksman","rhs_msv_emr_machinegunner_assistant","rhs_msv_emr_grenadier_rpg","rhs_msv_emr_engineer","rhs_msv_emr_driver_armored","rhs_msv_emr_driver"],["rhs_msv_emr_sergeant","rhs_msv_emr_grenadier","rhs_msv_emr_junior_sergeant","rhs_msv_emr_efreitor"],["rhs_msv_emr_machinegunner","rhs_msv_emr_arifleman","rhs_msv_emr_arifleman_rpk"],["rhs_msv_emr_at"],["rhs_msv_emr_aa"]],
			[["rhs_msv_RShG2","rhs_msv_LAT","rhs_msv_rifleman","rhs_msv_officer_armored","rhs_msv_officer","rhs_msv_medic","rhs_msv_marksman","rhs_msv_machinegunner_assistant","rhs_msv_strelok_rpg_assist","rhs_msv_grenadier_rpg","rhs_msv_engineer","rhs_msv_efreitor","rhs_msv_driver_armored","rhs_msv_driver"],["rhs_msv_sergeant","rhs_msv_grenadier","rhs_msv_junior_sergeant"],["rhs_msv_arifleman","rhs_msv_arifleman_rpk","rhs_msv_machinegunner"],["rhs_msv_at"],["rhs_msv_aa"]],
			[["rhs_vdv_des_sergeant","rhs_vdv_des_RShG2","rhs_vdv_des_LAT","rhs_vdv_des_rifleman_lite","rhs_vdv_des_rifleman_asval","rhs_vdv_des_rifleman","rhs_vdv_des_officer","rhs_vdv_des_medic","rhs_vdv_des_marksman","rhs_vdv_des_marksman_asval","rhs_vdv_des_machinegunner_assistant","rhs_vdv_des_junior_sergeant","rhs_vdv_des_strelok_rpg_assist","rhs_vdv_des_grenadier_rpg","rhs_vdv_des_engineer","rhs_vdv_des_efreitor"],["rhs_vdv_des_grenadier"],["rhs_vdv_des_machinegunner","rhs_vdv_des_arifleman","rhs_vdv_des_arifleman_rpk"],["rhs_vdv_des_at"],["rhs_vdv_des_aa"]],
			[["rhs_vdv_mflora_sergeant","rhs_vdv_mflora_RShG2","rhs_vdv_mflora_LAT","rhs_vdv_mflora_rifleman_lite","rhs_vdv_mflora_rifleman","rhs_vdv_mflora_officer","rhs_vdv_mflora_medic","rhs_vdv_mflora_marksman","rhs_vdv_mflora_machinegunner_assistant","rhs_vdv_mflora_junior_sergeant","rhs_vdv_mflora_strelok_rpg_assist","rhs_vdv_mflora_grenadier_rpg","rhs_vdv_mflora_engineer","rhs_vdv_mflora_efreitor","rhs_vdv_mflora_driver_armored","rhs_vdv_mflora_driver"],["rhs_vdv_mflora_grenadier"],["rhs_vdv_mflora_machinegunner","rhs_vdv_mflora_arifleman_rpk"],["rhs_vdv_mflora_at"],["rhs_vdv_mflora_aa"]],
			[["rhs_vdv_recon_sergeant","rhs_vdv_recon_rifleman_scout","rhs_vdv_recon_rifleman_scout_akm","rhs_vdv_recon_rifleman_lat","rhs_vdv_recon_rifleman_l","rhs_vdv_recon_rifleman_asval","rhs_vdv_recon_rifleman_akms","rhs_vdv_recon_rifleman_ak103","rhs_vdv_recon_rifleman","rhs_vdv_recon_officer","rhs_vdv_recon_medic","rhs_vdv_recon_marksman_vss","rhs_vdv_recon_marksman_asval","rhs_vdv_recon_marksman","rhs_vdv_recon_machinegunner_assistant","rhs_vdv_recon_efreitor"],["rhs_vdv_recon_grenadier_scout","rhs_vdv_recon_grenadier"],["rhs_vdv_recon_arifleman_rpk_scout","rhs_vdv_recon_arifleman_scout","rhs_vdv_recon_arifleman","rhs_vdv_recon_arifleman_rpk"],[],[]],
			[["rhs_vmf_recon_sergeant","rhs_vmf_recon_rifleman_scout","rhs_vmf_recon_rifleman_scout_akm","rhs_vmf_recon_rifleman_lat","rhs_vmf_recon_rifleman_l","rhs_vmf_recon_rifleman_asval","rhs_vmf_recon_rifleman_akms","rhs_vmf_recon_rifleman","rhs_vmf_recon_officer","rhs_vmf_recon_medic","rhs_vmf_recon_marksman_vss","rhs_vmf_recon_marksman","rhs_vmf_recon_efreitor"],["rhs_vmf_recon_grenadier_scout","rhs_vmf_recon_grenadier"],["rhs_vmf_recon_arifleman_scout","rhs_vmf_recon_arifleman"],[],[]]
		];
		_missionWestGroupsRHSBase append _unitsRussia;
	};
	if (_rhsUsa) then {
		private _unitsUsa = [
			//BLUFOR
			[["rhsusf_army_ocp_teamleader","rhsusf_army_ocp_squadleader","rhsusf_army_ocp_sniper_m24sws","rhsusf_army_ocp_sniper_m107","rhsusf_army_ocp_sniper","rhsusf_army_ocp_rifleman_m4","rhsusf_army_ocp_rifleman_m16","rhsusf_army_ocp_riflemanat","rhsusf_army_ocp_riflemanl","rhsusf_army_ocp_rifleman","rhsusf_army_ocp_officer","rhsusf_army_ocp_marksman","rhsusf_army_ocp_machinegunnera","rhsusf_army_ocp_explosives","rhsusf_army_ocp_engineer","rhsusf_army_ocp_driver_armored","rhsusf_army_ocp_driver","rhsusf_army_ocp_combatcrewman","rhsusf_army_ocp_crewman","rhsusf_army_ocp_medic","rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_rifleman_m590","rhsusf_army_ocp_autoriflemana","rhsusf_army_ocp_rifleman_10th","rhsusf_army_ocp_rifleman_1stcav"],["rhsusf_army_ocp_jfo","rhsusf_army_ocp_grenadier","rhsusf_army_ocp_fso"],["rhsusf_army_ocp_machinegunner"],["rhsusf_army_ocp_maaws","rhsusf_army_ocp_javelin"],["rhsusf_army_ocp_aa"]],
			[["rhsusf_army_ucp_teamleader","rhsusf_army_ucp_squadleader","rhsusf_army_ucp_sniper_m24sws","rhsusf_army_ucp_sniper_m107","rhsusf_army_ucp_sniper","rhsusf_army_ucp_rifleman_m4","rhsusf_army_ucp_rifleman_m16","rhsusf_army_ucp_riflemanat","rhsusf_army_ucp_riflemanl","rhsusf_army_ucp_rifleman","rhsusf_army_ucp_officer","rhsusf_army_ucp_marksman","rhsusf_army_ucp_machinegunnera","rhsusf_army_ucp_explosives","rhsusf_army_ucp_engineer","rhsusf_army_ucp_driver_armored","rhsusf_army_ucp_driver","rhsusf_army_ucp_medic","rhsusf_army_ucp_rifleman_m590","rhsusf_army_ucp_autoriflemana","rhsusf_army_ucp_rifleman_82nd","rhsusf_army_ucp_rifleman_1stcav","rhsusf_army_ucp_rifleman_10th","rhsusf_army_ucp_rifleman_101st"],["rhsusf_army_ucp_jfo","rhsusf_army_ucp_grenadier","rhsusf_army_ucp_fso"],["rhsusf_army_ucp_machinegunner","rhsusf_army_ucp_autorifleman"],["rhsusf_army_ucp_maaws","rhsusf_army_ucp_javelin"],["rhsusf_army_ucp_aa"]],
			[["rhsusf_socom_marsoc_teamleader","rhsusf_socom_marsoc_teamchief","rhsusf_socom_marsoc_sniper_m107","rhsusf_socom_marsoc_spotter","rhsusf_socom_marsoc_sniper","rhsusf_socom_marsoc_sarc","rhsusf_socom_marsoc_cso_mk17","rhsusf_socom_marsoc_cso_mk17_light","rhsusf_socom_marsoc_cso_light","rhsusf_socom_marsoc_cso_cqb","rhsusf_socom_marsoc_cso_breacher","rhsusf_socom_marsoc_cso","rhsusf_socom_marsoc_cso_mechanic","rhsusf_socom_marsoc_marksman","rhsusf_socom_marsoc_jtac","rhsusf_socom_marsoc_jfo","rhsusf_socom_marsoc_cso_eod","rhsusf_socom_marsoc_elementleader"],["rhsusf_socom_marsoc_cso_grenadier","rhsusf_socom_marsoc_elementleader"],[],[],[]],
			[["rhsusf_usmc_marpat_d_squadleader","rhsusf_usmc_marpat_d_sniper_m107","rhsusf_usmc_marpat_d_spotter","rhsusf_usmc_marpat_d_sniper","rhsusf_usmc_marpat_d_sniper_m110","rhsusf_usmc_marpat_d_rifleman_law","rhsusf_usmc_marpat_d_rifleman_m4","rhsusf_usmc_marpat_d_rifleman","rhsusf_usmc_marpat_d_riflemanat","rhsusf_usmc_marpat_d_rifleman_light","rhsusf_usmc_marpat_d_officer","rhsusf_usmc_marpat_d_machinegunner_ass","rhsusf_usmc_marpat_d_jfo","rhsusf_usmc_marpat_d_gunner","rhsusf_usmc_marpat_d_fso","rhsusf_usmc_marpat_d_explosives","rhsusf_usmc_marpat_d_driver","rhsusf_usmc_marpat_d_marksman","rhsusf_usmc_marpat_d_combatcrewman","rhsusf_usmc_marpat_d_engineer","rhsusf_usmc_marpat_d_rifleman_m590","rhsusf_usmc_marpat_d_autorifleman_m249_ass","rhsusf_usmc_marpat_d_autorifleman"],["rhsusf_usmc_marpat_d_teamleader","rhsusf_usmc_marpat_d_grenadier_m32","rhsusf_usmc_marpat_d_grenadier"],["rhsusf_usmc_marpat_d_machinegunner","rhsusf_usmc_marpat_d_autorifleman_m249"],["rhsusf_usmc_marpat_d_javelin","rhsusf_usmc_marpat_d_smaw"],["rhsusf_usmc_marpat_d_javelin"]],
			[["rhsusf_usmc_marpat_wd_squadleader","rhsusf_usmc_marpat_wd_sniper_M107","rhsusf_usmc_marpat_wd_spotter","rhsusf_usmc_marpat_wd_sniper","rhsusf_usmc_marpat_wd_sniper_m110","rhsusf_usmc_marpat_wd_rifleman_law","rhsusf_usmc_marpat_wd_rifleman_m4","rhsusf_usmc_marpat_wd_rifleman","rhsusf_usmc_marpat_wd_riflemanat","rhsusf_usmc_marpat_wd_rifleman_light","rhsusf_usmc_marpat_wd_officer","rhsusf_usmc_marpat_wd_machinegunner_ass","rhsusf_usmc_marpat_wd_gunner","rhsusf_usmc_marpat_wd_fso","rhsusf_usmc_marpat_wd_explosives","rhsusf_usmc_marpat_wd_driver","rhsusf_usmc_marpat_wd_marksman","rhsusf_usmc_marpat_wd_combatcrewman","rhsusf_usmc_marpat_wd_engineer","rhsusf_usmc_marpat_wd_rifleman_m590","rhsusf_usmc_marpat_wd_autorifleman_m249_ass","rhsusf_usmc_marpat_wd_autorifleman"],["rhsusf_usmc_marpat_wd_teamleader","rhsusf_usmc_marpat_wd_jfo","rhsusf_usmc_marpat_wd_grenadier_m32","rhsusf_usmc_marpat_wd_grenadier"],["rhsusf_usmc_marpat_wd_machinegunner","rhsusf_usmc_marpat_wd_autorifleman_m249"],["rhsusf_usmc_marpat_wd_javelin","rhsusf_usmc_marpat_wd_smaw"],["rhsusf_usmc_marpat_wd_stinger"]]
		];
		_missionWestGroupsRHSBase append _unitsUsa;
	};
	BRPVP_missionWestGroupsRHS = _missionWestGroupsRHSBase apply {
		_x params ["_ou","_gl","_mg","_at","_aa"];
		selectRandom _missionWestGroupsRHSType params ["_ouQ","_glQ","_mgQ","_atQ","_aaQ"];
		if (_gl isEqualTo []) then {_gl = _ou;};
		if (_mg isEqualTo []) then {_mg = _ou;};
		if (_at isEqualTo []) then {_at = _ou;};
		if (_aa isEqualTo []) then {_aa = _ou;};
		private _group = [];
		for "_i" from 1 to _ouQ do {_group pushBack selectRandom _ou;};
		for "_i" from 1 to _glQ do {_group pushBack selectRandom _gl;};
		for "_i" from 1 to _mgQ do {_group pushBack selectRandom _mg;};
		for "_i" from 1 to _atQ do {_group pushBack selectRandom _at;};
		for "_i" from 1 to _aaQ do {_group pushBack selectRandom _aa;};
		_group
	};
};

BRPVP_missionWestGroupsVanila = [
	["B_HeavyGunner_F","B_soldier_SL_F","B_soldier_LAT_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F"],
	["B_HeavyGunner_F","B_soldier_AR_F","B_soldier_GL_F","B_soldier_M_F","B_soldier_AT_F","B_soldier_AAT_F"],
	["B_HeavyGunner_F","B_soldier_M_F","B_soldier_GL_F","B_soldier_LAT_F","B_medic_F","B_soldier_AT_F"],
	["B_HeavyGunner_F","B_recon_M_F","B_recon_medic_F","B_recon_LAT_F","B_recon_JTAC_F","B_recon_exp_F"],
	["B_HeavyGunner_F","B_T_soldier_SL_F","B_T_soldier_LAT_F","B_T_soldier_M_F","B_T_soldier_TL_F","B_T_soldier_AR_F"],
	["B_HeavyGunner_F","B_T_soldier_GL_F","B_T_soldier_M_F","B_T_soldier_AT_F","B_T_soldier_AAT_F","B_T_soldier_A_F"],
	["B_T_recon_M_F","B_T_recon_medic_F","B_T_recon_LAT_F","B_T_recon_JTAC_F","B_T_recon_exp_F","B_T_spotter_F"],
	["B_T_recon_TL_F","B_T_recon_M_F","B_T_recon_medic_F","B_T_recon_F","B_spotter_F","B_T_spotter_F"],
	["B_G_medic_F","B_T_soldier_AR_F","B_T_soldier_GL_F","B_T_soldier_LAT_F","B_soldier_AAA_F","B_soldier_AAT_F"],
	["B_G_medic_F","B_T_soldier_AT_F","B_T_soldier_AT_F","B_T_soldier_AAT_F","B_spotter_F","B_soldier_AAA_F"],
	["B_G_medic_F","B_T_soldier_AA_F","B_T_soldier_AA_F","B_T_soldier_AAA_F","B_spotter_F","B_soldier_AAT_F"],
	["B_recon_TL_F","B_recon_M_F","B_recon_medic_F","B_recon_LAT_F","B_recon_JTAC_F","B_recon_exp_F"],
	["B_Sharpshooter_F","B_soldier_GL_F","B_soldier_LAT_F","B_spotter_F","B_soldier_AAA_F","B_soldier_AAT_F"],
	["B_Sharpshooter_F","B_Soldier_TL_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AAT_F","B_soldier_AAT_F"],
	["B_Sharpshooter_F","B_Soldier_TL_F","B_soldier_AA_F","B_soldier_AA_F","B_spotter_F","B_soldier_AAA_F"],
	["B_T_Sniper_F","B_recon_TL_F","B_recon_medic_F","B_recon_F","B_spotter_F","B_soldier_AAA_F"],
	["B_T_Sniper_F","B_soldier_GL_F","B_recon_M_F","B_spotter_F","B_Soldier_TL_F","B_soldier_AT_F"],
	["B_T_Sniper_F","B_recon_M_F","B_recon_F","B_spotter_F","B_soldier_AT_F","B_soldier_AA_F"]
];
BRPVP_missionWestGroups = BRPVP_missionWestGroupsVanila+BRPVP_missionWestGroupsCUP+BRPVP_missionWestGroupsRHS;

BRPVP_distPlayerParaDanBot = 1000;
BRPVP_distPlayerParaDanBotTimer = 5;
BRPVP_nextMissionCasesCfg = [1,2,3,4,5,6,7,8,9,10];
BRPVP_nextMissionCases = +BRPVP_nextMissionCasesCfg;
BRPVP_nextMission = selectRandom BRPVP_nextMissionCases;
BRPVP_smallMissionsAIObjs = [];

//=========
//FUNCTIONS
//=========

BRPVP_initPlayerMissionSceneryVehicles = {
	_this setVariable ["brpvp_fedidex",true,true];
	_this call BRPVP_setVehServicesToZero;
	_this remoteExecCall ["BRPVP_veiculoEhReset",2];
};
BRPVP_fixZeroWayPoint = {
	private _foundCnt = 0;
	{
		if (side _x in [WEST,INDEPENDENT]) then {
			if (waypointPosition [_x,1] select [0,2] isEqualTo [0,0]) then {
				if (count wayPoints _x > 1) then {
					deleteWaypoint [_x,1];
					[_x,[_x,1]] remoteExecCall ["setCurrentWaypoint",_x];
					_foundCnt = _foundCnt+1;
				};
			};
		};
	} forEach allGroups;
	if (_foundCnt > 0) then {diag_log format ["[BRPVP ZERO WAYPOINT] FOUND AND FIXED %1 ZERO WAYPOINTS.",_foundCnt];};
};

//UBER ATTACK
BRPVP_moveBombAiJetPack = {
	params ["_ai","_tgt","_aiP","_tgtP","_init","_dist","_tm","_isS","_ctn"];
	private _setup = 1;
	if (diag_tickTime-_init >= _setup) then {
		if (_ai getVariable ["brpvp_tai_dead",false]) then {
			true
		} else {
			private _initS = _ai getVariable "brpvp_init_jet_sound";
			if (diag_tickTime-_initS >= 6.25) then {
				_ai setVariable ["brpvp_init_jet_sound",diag_tickTime];
				[_ai,["uber_pack",2000]] remoteExecCall ["say3D",BRPVP_allNoServer];
			};
			private _dtt = diag_tickTime-_setup;
			private _pAiNow = getPosASL _ai;
			private _pTgtNow = if (isNull _tgt) then {
				_ai getVariable ["brpvp_ltgt",_tgtP]
			} else {
				if (_isS) then {
					_ai setVariable ["brpvp_ltgt",getPosASL _tgt];
					getPosASL _tgt
				} else {
					_ai setVariable ["brpvp_ltgt",getPosASL _tgt vectorAdd _ctn];
					getPosASL _tgt vectorAdd _ctn
				};
			};
			private _elapsed = (_dtt-_init) min _tm;
			private _itv = (_elapsed/_tm)^1.5;
			private _maxMag = 60 min vectorMagnitude (_pTgtNow vectorDiff _tgtP vectorMultiply 0.6);
			private _tgtFix = vectorNormalized (_pTgtNow vectorDiff _tgtP) vectorMultiply _maxMag;
			private _tgtFixed = _tgtP vectorAdd _tgtFix;
			private _jPos = (_aiP vectorMultiply (1-_itv)) vectorAdd (_tgtFixed vectorMultiply _itv);
			private _jAGL = ASLToAGL (_jPos vectorAdd [0,0,(-2*abs(_itv-0.5)+1)^0.75*50]);
			private _hFix = (_jAGL select 2) max 0;
			if (_hFix > 50) then {_hFix = 50+sqrt(_hFix-50);};
			_jPos set [2,_hFix];
			_jPos = AGLToASL _jPos;
			private _toRun = _jPos vectorDiff _pAiNow;
			private _le = _ai getVariable "brpvp_jet_attack_error";
			private _en = vectorMagnitude _toRun;
			private _frameVec = if (_le isEqualTo 0) then {_toRun} else {_toRun vectorMultiply (_en^2/_le)};
			_ai setVariable ["brpvp_jet_attack_error",_en];
			_ai setVelocity _frameVec;
			if (_itv > 0.2 && !(_ai checkAIFeature "TARGET")) then {
				_ai enableAI "TARGET";
				_ai enableAI "MOVE";
				_ai enableAI "PATH";
				if (!isNull _tgt) then {_ai doWatch ASLToAGL getPosASL _tgt;};
			};
			if (_elapsed >= _tm-2.2) then {
				private _uAlarmOk = _ai getVariable "brpvp_jetat_alarm_ok";
				if (!_uAlarmOk) then {
					[_ai,["upack_alarm",500]] remoteExecCall ["say3D",BRPVP_allNoServer];
					_ai setVariable ["brpvp_jetat_alarm_ok",true];
				};
			};
			_dtt-_init > 1.2*_tm || _ai distance ASLToAGL _tgtFixed < 1
		};
	} else {
		_ai getVariable ["brpvp_tai_dead",false]
	};
};
BRPVP_doUberAttack = {
	params ["_ai","_tgt"];
	if (_ai getVariable "brpvp_uber_attack") then {
		_ai setVariable ["brpvp_uber_attack",false,true];
		if !(_ai getVariable ["brpvp_tai_dead",false]) then {
			_ai setVariable ["brpvp_uattack_group_to_return",group _ai];
			private _aloneGrp = createGroup [side _ai,true];
			[_ai] joinSilent _aloneGrp;
			_ai disableAI "FSM";
			_ai disableAI "TARGET";
			_ai disableAI "MOVE";
			_ai disableAI "PATH";
			_ai setUnitPos "UP";
			_ai setDir ([_ai,_tgt] call BIS_fnc_dirTo);
			_ai doWatch ASLToAGL getPosASL _tgt;
			[_ai,""] remoteExecCall ["switchMove",0];
			_ai setVariable ["brpvp_jet_attack_error",0];
			_ai setVariable ["brpvp_init_jet_sound",0];
			_ai setVariable ["brpvp_jetat_alarm_ok",false];
			_ai setVariable ["brpvp_no_possession",true,true];
			[_ai,_ai getVariable "brpvp_uber_attack_tank"] remoteExec ["BRPVP_jetAttackSmoke",BRPVP_allNoServer];
			[_ai,["uber_pack_init",2500]] remoteExecCall ["say3D",BRPVP_allNoServer];
			[_ai,_tgt] spawn {
				params ["_ai","_tgt"];
				uiSleep 1.25;
				if !(_ai getVariable ["brpvp_tai_dead",false]) then {if (alive _tgt) then {remoteExecCall ["BRPVP_jetAttackAlert",_tgt];};};
			};
			private _isS = random 1 < BRPVP_uberAttackSuicidePercentage;
			private _div = if (_isS) then {17.5} else {25};
			private _ctn = selectRandom [[50,0,0],[-50,0,0],[0,50,0],[0,-50,0],[40,40,0],[-40,40,0],[40,-40,0],[-40,-40,0]];
			_ctn set [2,selectRandom [0,0,0,0,0,0,0,0,0,0]];
			BRPVP_jetBombDo pushBack [_ai,_tgt,getPosASL _ai,getPosASL _tgt,diag_tickTime,_tgt distance _ai,(_tgt distance _ai)/_div,_isS,_ctn];
		};
	};
};
BRPVP_uberAttackAddAi = {
	private _bot = _this;
	private _tank = "Land_GasTank_01_khaki_F" createVehicle [0,0,0];
	_tank attachTo [_bot,[0,-0.325,-0.15],"spine3",true];
	_tank setVectorUp [0,-0.125,-1];
	_bot setVariable ["brpvp_uber_attack",true,true];
	_bot setVariable ["brpvp_uber_attack_tank",_tank,true];
	private _kehId = _bot addEventHandler ["Killed",{
		private _tank = (_this select 0) getVariable ["brpvp_uber_attack_tank",objNull];
		if (!isNull _tank) then {
			if (!isNull attachedTo _tank) then {detach _tank;};
			("APERSTripMine_Wire_Ammo" createVehicle (_tank modelToWorld [0,0,0])) setDamage 1;
			deleteVehicle _tank;
		};
		(_this select 0) removeEventHandler ["Killed",_thisEventHandler];
		(_this select 0) setVariable ["brpvp_uber_attack_killedeh",-1];
	}];
	_bot setVariable ["brpvp_uber_attack_killedeh",_kehId];
};
BRPVP_uberAttackMonitor = {
	private _jbdDel = [];
	{if (_x call BRPVP_moveBombAiJetPack) then {_jbdDel pushBack _forEachIndex;};} forEach BRPVP_jetBombDo;
	_jbdDel sort false;
	{
		private _params = BRPVP_jetBombDo deleteAt _x;
		private _ai = _params select 0;
		if !(_ai getVariable ["brpvp_tai_dead",false]) then {
			private _tgt = _params select 1;
			private _isS = _params select 7;
			if (_isS && _tgt distance _ai < 15 && _tgt call BRPVP_pAlive) then {
				private _tank = _ai getVariable "brpvp_uber_attack_tank";
				detach _tank;
				deleteVehicle _tank;
				if (getPos _ai select 2 > 3) then {("APERSTripMine_Wire_Ammo" createVehicle (_tank modelToWorld [0,0,0])) setDamage 1;} else {["Sh_105mm_HEAT_MP",_ai modelToWorld [0,0,0],200] call BRPVP_trowBomb;};
				_ai setHit ["head",1,true,_tgt];
			} else {
				_ai enableAI "FSM";
				_ai enableAI "TARGET";
				_ai enableAI "MOVE";
				_ai enableAI "PATH";
				_ai setUnitPos "AUTO";
				[_ai,_tgt] spawn {
					params ["_ai","_tgt"];
					private _init = diag_tickTime;
					private _delta = 0;
					waitUntil {
						_delta = diag_tickTime-_init;
						_ai setVelocity [0,0,-7.5 max (0 min (velocity _ai select 2)-(_delta min 7.5))];
						_delta > 10 || getPos _ai select 2 < 1 || _ai getVariable ["brpvp_tai_dead",false]
					};
					_this spawn {
						params ["_ai","_tgt"];
						private _init = time;
						waitUntil {
							uiSleep 5;
							private _noKnowEnemy = ({_ai knowsAbout _x > 1.5} count (_ai nearEntities [BRPVP_playerModel,250])) isEqualTo 0;
							time-_init > 300 || _noKnowEnemy
						};
						private _backGroup = _ai getVariable "brpvp_uattack_group_to_return";
						if (!isNull _backGroup) then {[_ai] joinSilent _backGroup;};
					};
					if !(_ai getVariable ["brpvp_tai_dead",false]) then {
						//WAY POINTS
						private _wp1 = group _ai addWayPoint [ASLToAGL getPosASL _tgt,0];
						_wp1 setWaypointType "MOVE";
						private _wp2 = group _ai addWayPoint [ASLToAGL getPosASL _ai,0];
						_wp2 setWaypointType "MOVE";
						private _wp3 = group _ai addWayPoint [ASLToAGL getPosASL _tgt,0];
						_wp2 setWaypointType "CYCLE";

						_ai setVariable ["brpvp_no_possession",false,true];
						uiSleep ((35-_delta) max 0);
						_ai setVariable ["brpvp_uber_attack",true,true];
					};
				};
			};
		};
	} forEach _jbdDel;
};

BRPVP_sBotFired = {
	params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];
	private _xShot = _unit getVariable ["brpvp_xtra_shot",false];
	if (!_xShot) then {
		_unit setVariable ["brpvp_xtra_shot",true];
		[_unit,_weapon,_muzzle] spawn {
			params ["_unit","_weapon","_muzzle"];
			private _onHunt = _unit getVariable ["brpvp_ulfan_hunting",false];
			private _cadence = 25;
			private _shotsToFire = 15;
			private _bigFireChance = [0.25,0.75] select _onHunt;
			private _randWait = [4,0] select _onHunt;
			if (random 1 < _bigFireChance) then {_cadence = 30;_shotsToFire = 30;};
			private _fired = 0;
			private _lastState = 0;
			waitUntil {
				private _perFrame = _cadence/diag_fps;
				_fired = (_fired+_perFrame) min _shotsToFire;
				private _floorFired = floor _fired;
				if (_floorFired > _lastState) then {
					for "_i" from _lastState to _floorFired do {
						_unit forceWeaponFire [_weapon,"fullAuto"];
						_unit setAmmo [_weapon,200];
						_unit setWeaponReloadingTime [_unit,_muzzle,0];
					};
					_lastState = _floorFired;
				};
				_fired isEqualTo _shotsToFire
			};
			uiSleep (5+random _randWait);
			_unit setVariable ["brpvp_xtra_shot",false];
		};
	};
};

//MINERVA AI UNIT
BRPVP_aiWithMinervaFired = {
	params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];
	//diag_log str ["MINERVA AI",_ammo,_projectile isKindOF "RocketBase",_projectile isKindOf "MissileBase"];
	if (_projectile isKindOF "RocketBase" || _projectile isKindOf "MissileBase") then {
		[_projectile,getPosWorld _projectile] remoteExec ["BRPVP_drawMissileLaser",call BRPVP_playersList];
		[_projectile,_unit,getPosWorld _projectile,_magazine,time] spawn BRPVP_aiMinervaShotCode;
	};
};
BRPVP_aiMinervaShotCode = {
	params ["_minervaShotObj","_bot","_lastMiPos","_magazine","_init"];
	waitUntil {private _isNull = isNull _minervaShotObj;if (_isNull) then {true} else {_lastMiPos = getPosWorld _minervaShotObj;false};};
	private _lastMiPosAGL = ASLToAGL _lastMiPos;
	private _bombMinRad = 5;
	private _thick = 5;
	private _bombFinalRad = 20;
	private _bombs = 20;
	if (_bot distance _lastMiPosAGL > _bombFinalRad*1.25 && _lastMiPosAGL select 2 <= 7.5) then {
		for "_i" from 1 to _bombs do {
			private _perc = sqrt(_i/_bombs);
			private _radLimMax = _bombMinRad+(_bombFinalRad-_bombMinRad)*_perc;
			private _radLimMin = (_radLimMax-_thick) max 0;
			private _rad = _radLimMin+random _thick;
			private _angle = random 360;
			private _pos = _lastMiPosAGL vectorAdd [_rad*sin _angle,_rad*cos _angle,0.1];
			private _bomb = selectRandom ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo","ATMine_Range_Ammo"];
			[_bomb,_pos,_bot,_bot] remoteExecCall ["BRPVP_explodeBombServerMBot",2];
		};
	};
	private _delta = time-_init;
	if (_delta < BRPVP_aiWithLauncherHaveMinervaRearmTime) then {
		uiSleep (BRPVP_aiWithLauncherHaveMinervaRearmTime-_delta);
		if (alive _bot) then {_bot addMagazine _magazine;};
	};
};

BRPVP_addAIonCleanProcess = [];
BRPVP_botDaExp = {
	((_this select 0) getVariable ["brpvp_keh_params",_this]) params ["_bot","_matador","_instigator","_useEffects"];
	_bot setVariable ["dd",1,true];
	_veh = objNull;
	_isMoto = _matador call BRPVP_isMotorized;
	if (_isMoto) then {
		_veh = _matador;
		_matador = if (isNull _instigator) then {effectiveCommander _matador} else {_instigator};
	};

	//RECORD VEHICLE KILL
	if (!isNull _instigator && !isNull _veh) then {
		if (_instigator call BRPVP_isPlayer) then {[["mounted_kills",1]] remoteExecCall ["BRPVP_mudaExp",_instigator];};
	} else {
		if (isNull _instigator && _isMoto) then {
			_driver = driver _veh;
			if (!isNull _driver && _driver call BRPVP_isPlayer) then {[["mounted_kills",1]] remoteExecCall ["BRPVP_mudaExp",_driver];};
		};
	};

	//GIVE EXPERIENCE
	if (_matador call BRPVP_isPlayer) then {
		[["matou_bot",1]] remoteExecCall ["BRPVP_mudaExpPedidoServidor",_matador];
		_addReward = _bot getVariable ["brpvp_add_reward",-1];
		//FUTURE
		if (_addReward > -1) then {_addReward remoteExecCall ["BRPVP_fortDefendAddReward",2]};
	};

	//REMOVE WEAPONS AND MAGAZINES IF DENIED
	//if (primaryWeapon _bot in BRPVP_deniedItems) then {_bot removeWeapon primaryWeapon _bot;};
	//if (secondaryWeapon _bot in BRPVP_deniedItems) then {_bot removeWeapon secondaryWeapon _bot;};
	//{if (_x in BRPVP_AIMagazinesRemove) then {_bot removeMagazine _x;};} forEach magazines _bot;
	//{if (_x in BRPVP_AIMagazinesRemove) then {_bot removeItem _x;};} forEach items _bot;

	//ADD BOT TO CLEAN PROCESS
	if !(_bot getVariable ["brpvp_aitiz",false]) then {
		private _gIdx = -1;
		{
			private _mBot = _x select 0;
			private _dTime = diag_tickTime-(_mBot getVariable ["brpvp_ai_dead_time_original",0]);
			if (_mBot distance _bot < 100 && _dTime < BRPVP_AIGroupDeadTimeBodies) exitWith {_gIdx = _forEachIndex;};
		} forEach BRPVP_addAIonCleanProcess;
		if (_gIdx isEqualTo -1) then {
			_bot setVariable ["brpvp_ai_dead_time_original",diag_tickTime,2];
			_bot setVariable ["brpvp_ai_dead_time",diag_tickTime,2];
			BRPVP_addAIonCleanProcess pushBack [_bot];
		} else {
			private _refTimeCount = count (BRPVP_addAIonCleanProcess select _gIdx);
			private _refTime = (BRPVP_addAIonCleanProcess select _gIdx select 0) getVariable ["brpvp_ai_dead_time",0];
			(BRPVP_addAIonCleanProcess select _gIdx select 0) setVariable ["brpvp_ai_dead_time",(_refTime*_refTimeCount+diag_tickTime)/(_refTimeCount+1),2];
			(BRPVP_addAIonCleanProcess select _gIdx) pushBack _bot;
		};
	};

	//ADD SPECIAL ITEMS
	_extraChance = _bot getVariable ["brpvp_extra_chance",1];
	_spcItems = _extraChance call BRPVP_createRandomBlueTankItems;
	if !(_spcItems isEqualTo []) then {
		_veh = objectParent _bot;
		_pos = if (isNull _veh) then {[_bot,1,getDir _bot+selectRandom [90,-90]] call BIS_fnc_relPos} else {[_bot,5,getDir _veh+selectRandom [90,-90]] call BIS_fnc_relPos};
		_pos = [_pos select 0,_pos select 1,(ASLToAGL getPosASL _bot select 2)+1];
		[_pos,_spcItems] call BRPVP_spcItemsLootCreate;
	};

	//PUT FOOD ON BOT
	if (random 1 < BRPVP_foodAiUnitChance) then {
		private _items = _bot getVariable ["brpvp_alt_i_items",[]];
		_items pushBack [BRPVP_specialItems find (selectRandom BRPVP_foodClassArray),selectRandom [1,1,1,1,2]];
		_bot setVariable ["brpvp_alt_i_items",_items,true];
	};

	//PUT MONEY IF ULFAN
	if (_bot getVariable ["brpvp_is_ulfan",false]) then {
		_bot spawn {
			uiSleep 1.25;
			if (!isNull _this) then {
				private _suitCase = createVehicle ["Land_Suitcase_F",BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
				private _mult = [0.5,1] select (_this getVariable ["brpvp_path_on",true]);
				_suitCase setPosASL (getPosASL _this vectorAdd [0,0,1.25]);
				_suitCase setVariable ["mny",round (_mult*BRPVP_ulfanSoldierMoneyReward*BRPVP_missionValueMult),true];
			};
		};
	};

	//PUT MONEY IF MINERVA AI
	if (_bot getVariable ["brpvp_minerva_ai_unit",false]) then {
		_bot spawn {
			uiSleep 1.25;
			if (!isNull _this) then {
				private _suitCase = createVehicle ["Land_Suitcase_F",BRPVP_posicaoFora,[],0,"CAN_COLLIDE"];
				private _mult = [0.5,1] select (_this getVariable ["brpvp_path_on",true]);
				_suitCase setPosASL (getPosASL _this vectorAdd [0,0,1.25]);
				_suitCase setVariable ["mny",round (_mult*BRPVP_aiWithLauncherHaveMinervaReward*BRPVP_missionValueMult),true];
			};
		};
	};
};
BRPVP_sBotHuntPlayer = {
	params ["_ai","_instigator"];
	private _originalGrp = group _ai;
	private _gAlone = createGroup [side _ai,true];
	[_ai] joinSilent _gAlone;
	private _pAGL = ASLToAGL getPosASL _instigator;
	private _bests = [];
	for "_i" from 1 to 3 do {
		private _try = _pAGL findEmptyPosition [0,35,"C_Hatchback_01_F"];
		if (_try isNotEqualTo []) then {_bests pushBack [_try distance2D _pAGL,_try];};
	};
	_bests sort false;
	private _best = if (_bests isEqualTo []) then {_pAGL} else {_bests select 0 select 1};
	[_ai,BRPVP_ulfanSoldierSpeedHunt] remoteExecCall ["setAnimSpeedCoef",0];
	private _init = diag_tickTime;
	private _distRef = _ai distance2D _instigator;
	private _wp = _gAlone addWayPoint [_best,0];
	_wp setWaypointCompletionRadius 10;
	_wp setWayPointType "MOVE";
	_wp setWayPointSpeed "FAST";
	_ai remoteExecCall ["BRPVP_sBotAddHuntEffect",BRPVP_allNoServer];
	waitUntil {
		uiSleep 2.5;
		private _distNow = _ai distance2D _instigator;
		private _continue = alive _instigator && alive _ai && _distNow < _distRef+250 && diag_tickTime-_init < 600;
		if (_continue) then {
			private _pNow = ASLToAGL getPosASL _instigator;
			if (_pNow distance2D _pAGL > 50) then {
				private _bests = [];
				for "_i" from 1 to 2 do {
					private _try = _pNow findEmptyPosition [0,35,"C_Hatchback_01_F"];
					if (_try isNotEqualTo []) then {_bests pushBack [_try distance2D _pNow,_try];};
				};
				_bests sort false;
				_best = if (_bests isEqualTo []) then {_pNow} else {_bests select 0 select 1};
				{deleteWayPoint _x;} forEach wayPoints _gAlone;
				uiSleep 0.001;
				_wp = _gAlone addWayPoint [_best,0];
				_wp setWaypointCompletionRadius 10;
				_wp setWayPointType "MOVE";
				_wp setWayPointSpeed "FAST";
				_pAGL = +_pNow;
			};
		};
		!_continue
	};
	_ai remoteExecCall ["BRPVP_sBotRemoveHuntEffect",BRPVP_allNoServer];
	if (alive _ai) then {
		_ai setVariable ["brpvp_ulfan_hunting",false];
		[_ai,BRPVP_ulfanSoldierSpeed] remoteExecCall ["setAnimSpeedCoef",0];
		if (units _originalGrp select {alive _x} isNotEqualTo []) then {
			{deleteWayPoint _x;} forEach wayPoints _gAlone;
			[_ai] joinSilent _originalGrp;
		};
	};
};
BRPVP_hdEhUlfan = {
	private _instigator = _this select 6;
	if ((_ai getVariable ["brpvp_is_ulfan",false]) && {_instigator call BRPVP_isPlayer}) then {
		private _part = _this select 1;
		private _dam = _this select 2;
		private _lastShotTime = _ai getVariable "brpvp_lst";
		if (diag_tickTime-_lastShotTime > 0.02) then {
			_ai setVariable ["brpvp_no_head_hit",1];
			_ai setVariable ["brpvp_lst",diag_tickTime];
			_ai setVariable ["brpvp_wrong_player",_instigator];
			[_ai,diag_tickTime] spawn {
				params ["_ai","_tickTime"];
				waitUntil {diag_tickTime-_tickTime > 0.02};
				private _hitInfo = _ai getVariable "brpvp_no_head_hit";
				if (_hitInfo isEqualTo 1) then {
					private _p = _ai getVariable "brpvp_wrong_player";
					if (!isNull _p) then {
						private _lastInfoTime = _p getVariable ["brpvp_last_info_time_1",-30];
						if (diag_tickTime-_lastInfoTime > 30) then {
							_p setVariable ["brpvp_last_info_time_1",diag_tickTime];
							[format ["<img shadow='0' size='2' image='"+BRPVP_imagePrefix+"BRP_imagens\head_shot.paa'/><br /><t>%1",localize "str_lars_shot_head"+"</t>"],0,0,2.5,0,0,39214] remoteExecCall ["BRPVP_fnc_dynamicText",_p];
						};
						_ai setVariable ["brpvp_no_head_hit",0];
						_ai setVariable ["brpvp_wrong_player",objNull];
					};
				};
			};
		};
		if (_part isEqualTo "" && {!(_ai getVariable ["brpvp_ulfan_hunting",false]) && random 1 < BRPVP_ulfanSoldierHuntChance && _ai checkAIFeature "PATH"}) then {
			_ai setVariable ["brpvp_ulfan_hunting",true];
			[_ai,_instigator] spawn BRPVP_sBotHuntPlayer;
		};
		if (_part isEqualTo "head" && _dam > 0.25) then {
			_ai setVariable ["brpvp_no_head_hit",2];
			_ai setVariable ["brpvp_wrong_player",objNull];
		};
	};
};
BRPVP_scriptKillAIToZed = {
	params ["_ai","_ofender"];

	if (!(_ai getVariable ["brpvp_is_ulfan",false]) && !(_ai getVariable ["brpvp_minerva_ai_unit",false])) then {
		_ai setVariable ["brpvp_tiz",true];

		//BRPVP_hdEhZombie
		_ai setVariable ["brpvp_path_on",_ai checkAIFeature "PATH"];
		_ai setVariable ["brpvp_tai_dead",true];
		_ai setVariable ["brpvp_on_punch",true];
		_ai setVariable ["brpvp_after_damage",0];
		_ai setVariable ["brpvp_to_zed_death_time",diag_tickTime];

		call BRPVP_aiDeadUsualCode;

		//STRUGLE AND TURN INTO ZOMBIE
		_ai removeItems "FirstAidKit";
		_ai removeItems "MediKit";
		_ai setVariable ["brpvp_aitiz",true,true];
		if (!isNull objectParent _ai) then {
			unassignVehicle _ai;
			[_ai] allowGetIn false;
			moveOut _ai;
		};

		//SET AI INCONSCIOUS
		_ai setUnconscious true;
		[_ai,[selectRandom ["disabled12","disabled13"],350,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];

		[_ai,_ofender] spawn BRPVP_deadAiToZedCode;
	} else {
		_ai setVariable ["brpvp_tiz",false];

		//BRPVP_hdEhNormal
		if (_ai getVariable ["brpvp_is_ulfan",false]) then {[_ai,1] remoteExecCall ["setAnimSpeedCoef",0];};
		_ai setVariable ["brpvp_path_on",_ai checkAIFeature "PATH"];
		_ai setVariable ["brpvp_tai_dead",true];
		_ai setVariable ["brpvp_on_punch",true];

		call BRPVP_aiDeadUsualCode;
		
		_ai setDamage 1
	};
};
BRPVP_hdehAtomicBombDesintegration = {
	params ["_ai","_ofender"];

	//GIVE MONEY
	private _crew = [];
	private _veh = objectParent _ofender;
	if (isNull _veh) then {_crew = [_ofender]-[objNull];} else {{if (_x call BRPVP_pAlive && _x getVariable ["sok",false]) then {_crew pushBack _x;};} forEach crew _veh;};
	private _countCrew = count _crew;
	if (_countCrew > 0) then {
		private _giveMoney = 100*round (BRPVP_killAIReward*BRPVP_missionValueMult/100);
		{[_x,round (_giveMoney/(sqrt _countCrew)),"mny","negocio",random 0.5] remoteExec ["BRPVP_qjsAdicClassObjeto",_x];} forEach _crew;
	};

	//GIVE EXPERIENCE
	if (_ofender call BRPVP_isPlayer) then {
		[["matou_ai",1]] remoteExecCall ["BRPVP_mudaExpPedidoServidor",_ofender];
		private _addReward = _ai getVariable ["brpvp_add_reward",-1];
		if (_addReward > -1) then {_addReward remoteExecCall ["BRPVP_fortDefendAddReward",2]};
	};

	//ADD SPECIAL ITEMS
	private _extraChance = _ai getVariable ["brpvp_extra_chance",1];
	private _spcItems = _extraChance call BRPVP_createRandomBlueTankItems;
	if (_spcItems isNotEqualTo []) then {
		private _side = [5,1.25] select (isNull objectParent _ai);
		_pos = [_ai,_side,getDir _ai+selectRandom [90,-90]] call BIS_fnc_relPos;
		[[_pos select 0,_pos select 1,(ASLToAGL getPosASL _ai select 2)+1],_spcItems] call BRPVP_spcItemsLootCreate;
	};

	//DELETE BOT
	private _toDel = _ai getVariable ["brpvp_del_on_clean",objNull];
	private _car = objectParent _ai;
	if (!isNull _toDel && {_ai distance _toDel < 15}) then {deleteVehicle _toDel;};
	if (isNull _car) then {deleteVehicle _ai;} else {[_car,_ai] remoteExecCall ["deleteVehicleCrew",_car];};
};
BRPVP_hdEh = {
	private _ai = _this select 0;
	private _tiz = _ai getVariable ["brpvp_tiz",-1];
	if (_tiz isEqualTo -1) then {
		if (random 1 < BRPVP_turnAiIntoZombiesAfterDiePercentage && !(_ai getVariable ["brpvp_is_ulfan",false]) && !(_ai getVariable ["brpvp_minerva_ai_unit",false])) then {
			_ai setVariable ["brpvp_tiz",true];
			call BRPVP_hdEhZombie;
		} else {
			_ai setVariable ["brpvp_tiz",false];
			call BRPVP_hdEhUlfan;
			call BRPVP_hdEhNormal;
		};
	} else {
		if (_tiz) then {
			call BRPVP_hdEhZombie;
		} else {
			call BRPVP_hdEhUlfan;
			call BRPVP_hdEhNormal;
		};
	};
};
BRPVP_aiDeadUsualCode = {
	if (isNull objectParent _ai) then {
		_ai setVelocity [0,0,0];
		_ai disableAI "TARGET";
		_ai disableAI "AUTOTARGET";
		_ai disableAI "MOVE";
		_ai disableAI "PATH";
		_ai disableAI "FSM";
	};

	{_ai setHit [_x,0.8]} forEach ["body","spine1","spine2","spine3"];
	{_ai setHit [_x,0.9]} forEach ["face_hub","neck","head","arms","hands"];

	//REMOVE WEAPONS AND MAGAZINES IF DENIED
	if (primaryWeapon _ai in BRPVP_deniedItems) then {_ai removeWeapon primaryWeapon _ai;};
	if (secondaryWeapon _ai in BRPVP_deniedItems) then {_ai removeWeapon secondaryWeapon _ai;};
	{if (_x in BRPVP_AIMagazinesRemove) then {_ai removeMagazine _x;};} forEach magazines _ai;
	{if (_x in BRPVP_AIMagazinesRemove) then {_ai removeItem _x;};} forEach items _ai;

	//REMOVE BINOCULAR AND HANDGUN WEAPON IS TO ZOMBIE
	if (_ai getVariable ["brpvp_tiz",false]) then {
		private _bn = binocular _ai;
		private _hg = handgunWeapon _ai;
		if (_bn isNotEqualTo "") then {_ai removeWeapon _bn;};
		if (_hg isNotEqualTo "") then {_ai removeWeapon _hg;};
	};

	//REMOVE AND SAVE WEAPON ON HOLDER
	private _wps = [];
	{
		_x params ["_weapon","_qMags"];
		if (_weapon isNotEqualTo "") then {
			private _magLoaded = (weaponsItems _ai) select {(_x select 0) isEqualTo _weapon} select 0 select 4;
			private _magtoUse = if (_magLoaded isEqualTo []) then {selectRandom getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")} else {_magLoaded select 0};
			if (_weapon isEqualTo "GX_M82A2000_Weapon") then {_qMags = 1;};
			_wps pushBack [_weapon,_magtoUse,_qMags];
		};
	} forEach [[primaryWeapon _ai,selectRandom [2,3,4]],[secondaryWeapon _ai,selectRandom [1,2]]];
	if (_wps isNotEqualTo []) then {
		//POSITIONE EMPTY WEAPON HOLDER
		private _wh = objNull;
		private _asl = getPosASL _ai;
		{
			private _obj = _x select 2;
			if ({_obj isKindOf _x} count ["Motorcycle","Air","LandVehicle","Ship","CaManBase","WeaponHolder"] isEqualTo 0 && {str _obj find _x isNotEqualTo -1} count BRPVP_treesAndBushs isEqualTo 0) exitWith {
				private _dPos = _x select 0;
				if (vectorMagnitude (_dPos vectorDiff _asl) > 7.5) then {
					_wh = createVehicle ["WeaponHolderSimulated",ASLToAGL _asl,[],0,"NONE"];
				} else {
					_wh = createVehicle ["GroundWeaponHolder",ASLToAGL _asl,[],0,"NONE"];
					_wh setPosASL _dPos;
				};
				_wh setVectorUp (_x select 1);
			};
		} forEach lineIntersectsSurfaces [_asl vectorAdd [0,0,0.25],AGLToASL ((_asl select [0,2])+[-0.25]),vehicle _ai,objNull,true,-1,"GEOM","NONE"];
		if (isNull _wh) then {_wh = createVehicle ["WeaponHolderSimulated",ASLToAGL _asl,[],0,"NONE"];};
		
		//PUT WEAPONS AND MAG ON WEAPON HOLDER
		{
			_x params ["_w","_m","_q"];
			_wh addMagazineCargoGlobal [_m,_q];
			_wh addWeaponCargoGlobal [_w,1];
			_ai removeWeapon _w;
			{_ai removeMagazines _x;} forEach getArray (configFile >> "CfgWeapons" >> _w >> "magazines");
		} forEach _wps;
	};

	//GIVE MONEY
	private _crew = [];
	private _veh = objectParent _ofender;
	if (isNull _veh) then {_crew = [_ofender]-[objNull];} else {{if (_x call BRPVP_pAlive && _x getVariable ["sok",false]) then {_crew pushBack _x;};} forEach crew _veh;};
	private _countCrew = count _crew;
	if (_countCrew > 0) then {
		private _giveMoney = 100*round (BRPVP_killAIReward*BRPVP_missionValueMult/100);
		{[_x,round (_giveMoney/(sqrt _countCrew)),"mny","negocio",random 0.5] remoteExec ["BRPVP_qjsAdicClassObjeto",_x];} forEach _crew;
	};
};
BRPVP_hdehZombie = {
	private _dam = call BRPVP_aiCalcDamage;
	private _ai = _this select 0;
	private _part = _this select 1;
	private _critical = _part in ["","body","spine1","spine2","spine3","head"];
	private _taiDead = _ai getVariable ["brpvp_tai_dead",false];
	if (_taiDead) exitWith {
		private _toZedDeathTime = _ai getVariable "brpvp_to_zed_death_time";
		if (diag_tickTime-_toZedDeathTime > 0.02 && _part isEqualTo "") then {
			private _ofender = _this select 3;
			private _instigator = _this select 6;
			private _ofender = if (isNull _instigator) then {effectiveCommander _ofender} else {_instigator};
			private _delta = (_dam-damage _ai) max 0;
			private _afterDam = (_ai getVariable "brpvp_after_damage")+_delta;
			_ai setVariable ["brpvp_after_damage",_afterDam];
			if (_afterDam >= 0.5) then {_ai setHit ["head",1,true,_ofender];};
		};
		if (_critical) then {_dam min BRPVP_aiDamLim} else {_dam min 0.9};
	};
	if (_dam >= BRPVP_aiDamLim && _critical && !_taiDead) exitWith {
		_ai setVariable ["brpvp_path_on",_ai checkAIFeature "PATH"];
		_ai setVariable ["brpvp_tai_dead",true];
		_ai setVariable ["brpvp_on_punch",true];
		_ai setVariable ["brpvp_after_damage",0];
		_ai setVariable ["brpvp_to_zed_death_time",diag_tickTime];

		private _ofender = _this select 3;
		private _instigator = _this select 6;
		private _ofender = if (isNull _instigator) then {effectiveCommander _ofender} else {_instigator};

		call BRPVP_aiDeadUsualCode;

		//STRUGLE AND TURN INTO ZOMBIE
		_ai removeItems "FirstAidKit";
		_ai removeItems "MediKit";
		_ai setVariable ["brpvp_aitiz",true,true];
		if (!isNull objectParent _ai) then {
			unassignVehicle _ai;
			[_ai] allowGetIn false;
			moveOut _ai;
		};

		//SET AI INCONSCIOUS
		_ai setUnconscious true;
		[_ai,[selectRandom ["disabled12","disabled13"],350,0.9+random 0.2]] remoteExecCall ["say3D",BRPVP_allNoServer];

		[_ai,_ofender] spawn BRPVP_deadAiToZedCode;
		_dam min BRPVP_aiDamLim
	};
	if (_critical) then {_dam min BRPVP_aiDamLim} else {_dam min 0.9};
};
BRPVP_deadAiToZedCode = {
	params ["_ai","_ofender"];

	//INTO ZOMBIE SOUNDS
	_ai spawn {
		private _ai = _this;
		private _roams = ["into_zed_01","into_zed_02","into_zed_03","into_zed_04","into_zed_05","into_zed_06","into_zed_07","into_zed_08"];
		private _voicer = createVehicle ["Land_HelipadEmpty_F",ASLToAGL getPosASL _ai,[],0,"CAN_COLLIDE"];
		private _init = 0;
		private _dlt = 0;
		waitUntil {
			if (diag_tickTime-_init > _dlt) then {
				[_voicer,[selectRandom _roams,60]] remoteExecCall ["say3D",BRPVP_allNoServer];
				_dlt = selectRandom [5,7,9];
				_init = diag_tickTime;
			};
			!alive _ai
		};
		deleteVehicle _voicer;
	};

	waitUntil {isNull objectParent _ai || !alive _ai};
	if (!alive _ai) exitWith {};
	private _init = diag_tickTime;
	if (getPos _ai select 2 > 1) then {waitUntil {getPos _ai select 2 < 0.25 || diag_tickTime-_init > 15 || !alive _ai};};
	if (!alive _ai) exitWith {};

	//CREATE AND SET AGENT
	private _agnt = createAgent [selectRandom BRPVP_zombiesClasses,BRPVP_spawnAIFirstPos,[],100,"NONE"];
	_agnt setVariable ["ifz",1];
	_agnt setVariable ["brpvp_no_possession",true,true];
	[_agnt,true] remoteExecCall ["hideObjectGlobal",2];
	[_agnt,face _ai] remoteExecCall ["setFace",0];
	{_agnt setHit [_x,0.8]} forEach ["body","spine1","spine2","spine3"];
	{_agnt setHit [_x,0.9]} forEach ["face_hub","neck","head","arms","hands"];
	_agnt setUnitLoadout getUnitLoadout _ai;
	_agnt addEventHandler ["HandleDamage",{private _part = _this select 1;if (_part in ["body","spine1","spine2","spine3"]) then {0.8} else {if (_part in ["face_hub","neck","head","arms","hands"]) then {0.9} else {0};};}];
	_agnt disableAI "FSM";
	uiSleep 0.5;
	if (!alive _ai) exitWith {deleteVehicle _agnt;};
	_agnt setPosASL (getPosASL _ai vectorAdd [selectRandom [1.25,-1.25],selectRandom [1.25,-1.25],0]);

	//DISABLE AGENT X AI COLLISION
	_agnt disableCollisionWith _ai;
	_ai disableCollisionWith _agnt;

	private _extra = 15-(diag_tickTime-_init);
	_init = diag_tickTime;
	waitUntil {!alive _ai || diag_tickTime-_init > _extra || animationState _ai isEqualTo "unconsciousrevivedefault"};
	if (!alive _ai) exitWith {deleteVehicle _agnt;};
	uiSleep 0.25;

	//MOAM
	private _iMoan = diag_tickTime;
	private _stopMoan = {!alive _ai || diag_tickTime-_iMoan > 80};
	for "_i" from 1 to 2 do {
		_ai setUnconscious false;
		uiSleep 0.001;
		_ai playMoveNow "UnconsciousOutProne";
		private _init = diag_tickTime;
		waitUntil {animationState _ai isEqualTo "amovppnemstpsnonwnondnon" || call _stopMoan || diag_tickTime-_init > 10};
		if (call _stopMoan) then {break;};
		uiSleep 0.001;
		_init = diag_tickTime;
		private _h = 1.5+random 0.15;
		_ai setUnitPos "UP";
		waitUntil {(eyePos _ai select 2)-(getPosASL _ai select 2) > _h || diag_tickTime-_init > 5 || call _stopMoan};
		if (call _stopMoan) then {break;};
		_init = diag_tickTime;
		_ai setUnconscious true;
		waitUntil {animationState _ai isEqualTo "unconsciousrevivedefault" || call _stopMoan || diag_tickTime-_init > 10};
		if (call _stopMoan) then {break;};
	};
	if (alive _ai && diag_tickTime-_iMoan > 80) exitWith {
		_ai setDamage 1;
		deleteVehicle _agnt;
	};
	if (!alive _ai) exitWith {deleteVehicle _agnt;};

	//GET UP AI
	_ai setUnconscious false;
	uiSleep 0.001;
	_ai playMoveNow "UnconsciousOutProne";
	_init = diag_tickTime;
	waitUntil {!alive _ai || diag_tickTime-_init > 8 || animationState player isEqualTo "amovppnemstpsnonwnondnon"};
	if (!alive _ai) exitWith {deleteVehicle _agnt;};
	_ai setUnitPos "UP";
	uiSleep 0.001;
	_init = diag_tickTime;
	_init2 = diag_tickTime;
	waitUntil {
		if (diag_tickTime-_init2 > 0.25) then {
			_init2 = diag_tickTime;
			_ai setUnitPos "UP";
		};
		!alive _ai || animationState _ai isEqualTo "amovpercmstpsnonwnondnon" || unitPos _ai isEqualTo "Middle" || stance _ai isEqualTo "CROUCH" || diag_tickTime-_init > 1.25
	};
	if (!alive _ai) exitWith {deleteVehicle _agnt;};

	//INIT ZOMBIE
	private _nua =  (nearestObjects [_agnt,[BRPVP_playerModel,"SoldierWB","SoldierGB"],300]) select {(_x getVariable ["ifz",-1]) isEqualTo -1 && alive _x && !(_x getVariable ["brpvp_tai_dead",false])};
	private _toAttack = if (_nua isEqualTo []) then {objNull} else {selectRandom (_nua select [0,2])};
	if (isNull _toAttack) then {
		deleteVehicle _agnt;
		_ai setVariable ["brpvp_aitiz",false,true];
		_ai setHit ["head",1,true,_ofender];
	} else {
		[_agnt,_toAttack] remoteExecCall ["BRPVP_spawnZombiesServerFromDeadAI",2];

		//CHANGE AI TO AGENT
		_agnt setVectorDirAndUp [vectorDir _ai,vectorUp _ai];
		[_agnt,""] remoteExecCall ["switchMove",0];
		_agnt setPosASL getPosASL _ai;
		[_ai,_agnt] remoteExec ["BRPVP_exchangeUnitVisual",0];
		_agnt removeAllEventHandlers "HandleDamage";

		//DELETE AI
		uiSleep 0.5;
		_ai setHit ["head",1,true,_ofender];
		uiSleep 0.5;
		_ai removeAllEventHandlers "HandleDamage";
		_ai removeAllEventHandlers "Killed";
		uiSleep 0.001;
		deleteVehicle _ai;
	};
};
BRPVP_hdehNormal = {
	private _dam = call BRPVP_aiCalcDamage;
	private _ai = _this select 0;
	private _part = _this select 1;
	private _critical = _part in ["","body","spine1","spine2","spine3","head"];
	private _taiDead = _ai getVariable ["brpvp_tai_dead",false];
	if (_taiDead) exitWith {_dam};
	if (_dam >= BRPVP_aiDamLim && _critical && !_taiDead) exitWith {
		if (_ai getVariable ["brpvp_is_ulfan",false]) then {[_ai,1] remoteExecCall ["setAnimSpeedCoef",0];};
		_ai setVariable ["brpvp_path_on",_ai checkAIFeature "PATH"];
		_ai setVariable ["brpvp_tai_dead",true];
		_ai setVariable ["brpvp_on_punch",true];

		private _ofender = _this select 3;
		private _instigator = _this select 6;
		private _ofender = if (isNull _instigator) then {effectiveCommander _ofender} else {_instigator};

		call BRPVP_aiDeadUsualCode;

		_dam
	};
	if (_critical) then {_dam min BRPVP_aiDamLim} else {_dam min 0.9};
};
BRPVP_aiCalcDamage = {
	params ["_unit","_part","_damage","_ofensor","_projectile","_hitIndex","_instigator","_hitPoint"];
	private _simuOn = simulationEnabled _unit;
	if (!_simuOn || (isNull _instigator && {!isNull _ofensor && _ofensor call BRPVP_isPlayer && _projectile isEqualTo ""})) then {
		_damage = if (_part isEqualTo "") then {damage _unit} else {_unit getHit _part};
		if (!_simuOn && _part isEqualTo "" && alive _unit) then {
			private _calcOfensor = if (isNull _instigator) then {effectiveCommander _ofensor} else {_instigator};
			if (typeOf _calcOfensor isEqualTo "O_UAV_AI") then {_calcOfensor = vehicle _calcOfensor call BRPVP_getUAVPlayer;};
			if (_calcOfensor call BRPVP_isPlayer) then {
				private _timeLast = _calcOfensor getVariable ["brpvp_last_nosimu_msg",0];
				if (time-_timeLast > 2) then {
					remoteExecCall ["BRPVP_aiNoSimuMsg",_calcOfensor];
					_calcOfensor setVariable ["brpvp_last_nosimu_msg",time];
				};
			};
		};
	} else {
		private _calcOfensor = if (isNull _instigator) then {effectiveCommander _ofensor} else {_instigator};
		if (typeOf _calcOfensor isNotEqualTo "O_UAV_AI" && !isNull _calcOfensor) then {
			if (_calcOfensor call BRPVP_isPlayer) then {
				//CHECK IF CONTROLED AI TO SET UNCAPTIVE
				private _poss = _calcOfensor getVariable ["brpvp_possessed",-1];
				if (_poss isNotEqualTo -1 && _part isEqualTo "") then {
					private _newPoss = _poss+1;
					_calcOfensor setVariable ["brpvp_possessed",_newPoss];
					if (_newPoss isEqualTo 2) then {
						{BRPVP_possCaptive = false;} remoteExecCall ["BRPVP_possRemovePlayerCaptive",_calcOfensor];
						"bush_reveal" remoteExecCall ["playSound",_calcOfensor];
						_calcOfensor spawn {uiSleep 1;{if (leader _x distance _this < 500) then {[_x,[_this,4]] remoteExecCall ["reveal",leader _x];};} forEach allGroups;};
					};
				};
				//PLAYER FROM BASE
				(_unit getVariable ["brpvp_ai_token_hdeh",[0,1]]) params ["_tk","_mult"];
				_tkNow = diag_tickTime;
				if (_tkNow-_tk > 0.01) then {
					_mult = 1;
					if (!BRPVP_raidServerIsRaidDay) then {
						_uInBase = [_unit,BRPVP_noRaidDayBaseExtension] call BRPVP_checkOnFlagStateExtraRadius > 0;
						_oInBase = [_calcOfensor,BRPVP_noRaidDayBaseExtension] call BRPVP_checkOnFlagStateExtraRadius > 0;
						if !((_uInBase && _oInBase) || !(_uInBase || _oInBase)) then {
							if (_calcOfensor call BRPVP_isPLayer) then {[_oInBase,true] remoteExecCall ["BRPVP_cantHurtFromBaseMsg",_calcOfensor];};
							_mult = 0;
						};
					};
					_unit setVariable ["brpvp_ai_token_hdeh",[_tkNow,_mult]];
				};
				//REGISTER PLAYER HEAD SHOT ON BOT
				if (_part isEqualTo "head") then {
					_damOld = _unit getHit "head";
					_delta = _damage-_damOld;
					if (_damOld < 0.9 && _delta >= 0.9) then {[["deu_tiro_cabeca_bot",1]] remoteExecCall ["BRPVP_mudaExpPedidoServidor",_calcOfensor];};
				};
				private _ulfanMult = [1,if (_part isEqualTo "head") then {1/BRPVP_ulfanSoldierExtraLife} else {0}] select (_unit getVariable ["brpvp_is_ulfan",false]);
				private _minervaAiMult = [1,1/BRPVP_aiWithLauncherHaveMinervaHealth] select (_unit getVariable ["brpvp_minerva_ai_unit",false]);
				_mult = _mult*_ulfanMult*_minervaAiMult;
				_damageNow = if (_part isEqualTo "") then {damage _unit} else {_unit getHit _part};
				_damage = _damageNow+(_damage-_damageNow)*_mult;
			} else {
				_damage = [_damage,_unit,_calcOfensor,_part] call BRPVP_botDano;
			};
		};
	};
	_damage
};
BRPVP_botDano = {
	params ["_dano","_unid","_atacante","_part"];
	private _ucdp = _unid getVariable ["ucdp",-BRPVP_distPlayerParaDanBotTimer];
	private _damageNow = if (_part isEqualTo "") then {damage _unid} else {_unid getHit _part};
	if (time-_ucdp > BRPVP_distPlayerParaDanBotTimer) then {
		private _nearPlayers = _unid nearEntities [BRPVP_playerModel,BRPVP_distPlayerParaDanBot];
		private _danoMlt = 0;
		if (_nearPlayers isEqualTo []) then {{if (_x distance _unid < BRPVP_distPlayerParaDanBot) exitWith {_danoMlt = 1;};} forEach BRPVP_playerVehicles;} else {_danoMlt = 1;};
		{
			_x setVariable ["ucdp",time];
			_x setVariable ["dnm",_danoMlt];
		} forEach (_unid nearEntities [["SoldierWB","SoldierGB"],75]);
		_damageNow+(_dano-_damageNow)*_danoMlt;
	} else {
		private _mult = _unid getVariable "dnm";
		if (side _unid isEqualTo side _atacante) then {_mult = 0;};
		_damageNow+(_dano-_damageNow)*_mult;
	};
};
BRPVP_carroBotGetIn = {
	_unid = _this select 2;
	if (_unid call BRPVP_isPlayer) then {
		[["str_temporary_vehicle",[]],0] remoteExecCall ["BRPVP_hint",_unid];
	};
};
BRPVP_rolaMotorista = {
	_unid = _this select 0;
	_avh = assignedVehicleRole _unid;
	if (count _avh > 0) then {
		if (_avh select 0 == "DRIVER") then {
			_veiculo = assignedVehicle _unid;
			{
				_avh = assignedVehicleRole _x;
				if (count _avh > 0) then {
					_ocupacao = _avh select 0;
					if (_ocupacao == "Cargo") exitWith {_x assignAsDriver _veiculo;};
				};
			} forEach units group _unid;
		};
	};
};
BRPVP_addLootSv = {
	params ["_holder","_itemsAll",["_failHolder",objNull]];
	_failedItems = [];
	if (!isNull _holder) then {
		{
			_isM = isClass (configFile >> "CfgMagazines" >> _x);
			if (_isM) then {
				_holder addMagazineCargoGlobal [_x,1];
			} else {
				_isW = isClass (configFile >> "CfgWeapons" >> _x);
				if (_isW) then {
					_isItem = _x isKindOf ["ItemCore",configFile >> "CfgWeapons"];
					_isBino = _x isKindOf ["Binocular",configFile >> "CfgWeapons"];
					_isMiDe = _x iskindOf ["MineDetector",configFile >> "CfgWeapons"];
					if (_isItem || _isBino || _isMiDe) then {_holder addItemCargoGlobal [_x,1];} else {_holder addWeaponCargoGlobal [_x,1];};
				} else {
					_isV = isClass (configFile >> "CfgVehicles" >> _x);
					if (_isV) then {
						_holder addBackpackCargoGlobal [_x,1];
					} else {
						_isG = isClass (configFile >> "CfgGlasses" >> _x);
						if (_isG) then {_holder addItemCargoGlobal [_x,1];};
					};
				};
			};
		} forEach _itemsAll;
	};
	if (count _itemsAll isEqualTo 0 && !isNull _failHolder) then {deleteVehicle _failHolder;};
	(count _failedItems > 0)
};
//CRUZAMENTOS DE RUAS
if (isNil "BRPVP_ruas") then {BRPVP_ruas = BRPVP_centroMapa nearRoads 20000;};
BRPVP_isecs = [];
_minDist = (BRPVP_mapaRodando select 10)^2;
{
	_rua = _x;
	if (count roadsConnectedTo _x > 2) then {
		_sozinha = true;
		{
			if (_rua distanceSqr _x < _minDist) exitWith {
				_sozinha = false;
			};
		} forEach BRPVP_isecs;
		if (_sozinha) then {BRPVP_isecs = BRPVP_isecs + [position _x];};
	};
} forEach BRPVP_ruas;
BRPVP_gruposDeInfantaria = [];
{
	{
		_unitsCfg = "true" configClasses _x;
		_groupInfo = [];
		{
			_model = getText (_x >> "vehicle");
			_rank = getText (_x >> "rank");
			_groupInfo append [[_model,_rank]];
		} forEach _unitsCfg;
		BRPVP_gruposDeInfantaria append [_groupInfo];
		diag_log ("INFANTRY GROUPS FOR PATROL " + str [_groupInfo]);
	} forEach ("true" configClasses _x);
} forEach BRPVP_patrolAIGroups;
//START BRAVO MISSION FNC
BRPVP_bravoRunHC = {
	private ["_hintEmMassa"];
	if (BRPVP_criaMissaoDePredioEspera isEqualTo BRPVP_criaMissaoDePredioIdc) then {
		[] spawn BRPVP_criaMissaoDePredio;
		_hintEmMassa = [["str_bravo_started",[]],6.5,15,167];
	} else {
		_hintEmMassa = [["str_bravo_cant_start",[]],6,15,167];
	};
	_hintEmMassa remoteExecCall ["BRPVP_hint",_this];
};

//INIT CODE

if (isServer) then {
	//EVENTS
	BRPVP_eventsDataCodeIsOn = [];
	{BRPVP_eventsDataCodeIsOn pushBack 0;} forEach BRPVP_eventsData;
	publicVariable "BRPVP_eventsDataCodeIsOn";
	{call compileFinal preprocessFileLineNumbers _x;} forEach BRPVP_eventsDataSQF;

	//START RANDOM EVENT MISSION
	if (BRPVP_eventsDataStartRandomAtBegin) then {
		_idx = floor random count BRPVP_eventsDataCodeOn;
		_idx remoteExec ["BRPVP_eventsInitiateFromServer",2];
	};
};

//BIG WALL AI UNITS
if (BRPVP_lestWestWallSegments isNotEqualTo []) then {call compile preprocessFileLineNumbers "server_code\server_wallGuards.sqf";};

//REVOLTERS
call compile preprocessFileLineNumbers "server_code\servidor_revoltosos.sqf";

//HOLE MISSION
BRPVP_holeMissionInfo = [];
publicVariable "BRPVP_holeMissionInfo";
call compile preprocessFileLineNumbers "server_code\server_holeMission.sqf";

//ZOMBIES
call compile preprocessFileLineNumbers "zombieMotherBrain.sqf";

//ON FOOT ROAMING AI GROUPS
call compile preprocessFileLineNumbers "server_code\servidor_bots_ape.sqf";

//VEHICLE (WHITE KEY) MISSIONS
BRPVP_vehicleMissionIcons = [];
publicVariable "BRPVP_vehicleMissionIcons";
call compile preprocessFileLineNumbers "server_code\server_vehicleMission.sqf";

//CONVOYS
BRPVP_konvoyCompositions = [];
publicVariable "BRPVP_konvoyCompositions";
call compile preprocessFileLineNumbers "server_code\server_convoyMission.sqf";

//BOMB MISSION
BRPVP_bombMissionObjs = [];
publicVariable "BRPVP_bombMissionObjs";
BRPVP_bombMissionBuildings = nearestObjects [BRPVP_centroMapa,BRPVP_bombMissionClasses,BRPVP_centroMapaRadius];
BRPVP_bombMissionBuildings = BRPVP_bombMissionBuildings apply {
	_obj = _x;
	_inSafe = false;
	{if (_obj distance (_x select 0) < (_x select 1)+200) exitWith {_inSafe = true;};} forEach BRPVP_safeZonesOtherMethod;
	_isBaseObj = (_obj getVariable ["id_bd",-1]) > -1;
	_inBase = _obj call BRPVP_checkOnFlagState > 0;
	if (_inSafe || _isBaseObj || _inBase) then {-1} else {_x};
};
BRPVP_bombMissionBuildings = BRPVP_bombMissionBuildings-[-1];
BRPVP_bombMissionUnits = [];
BRPVP_bombMissionCode = compileFinal preprocessFileLineNumbers "server_code\server_bombMission.sqf";

//BRAVO MISSION
BRPVP_missPrediosEm = [];
publicVariable "BRPVP_missPrediosEm";
BRPVP_criaMissaoDePredioIdc = 1;
call compile preprocessFileLineNumbers "server_code\server_bravoPointMission.sqf";

//SIEGE MISSION
call compile preprocessFileLineNumbers "server_code\server_siegeMission.sqf";
BRPVP_closedCityWalls = [];
BRPVP_closedCityRunning = [];
BRPVP_closedCityObjs = [];
BRPVP_closedCityAI = [];
BRPVP_closedCityTime = [];
{
	BRPVP_closedCityWalls pushBack [];
	BRPVP_closedCityRunning pushBack 0;
	BRPVP_closedCityObjs pushBack [];
	BRPVP_closedCityAI pushBack [];
	BRPVP_closedCityTime pushBack -600;
} forEach BRPVP_locaisImportantes;
BRPVP_towas = ["Land_Cargo_Patrol_V3_F"];
BRPVP_closedCityRunning call BRPVP_processSiegeIcons;
publicVariable "BRPVP_closedCityRunning";

//ROAD BLOCK MISSIONS
BRPVP_roadBlockRenew = compile preprocessFileLineNumbers "server_code\servidor_block_mission.sqf";
call BRPVP_roadBlockRenew;

//FORT DEFEND MISSION
if (BRPVP_defendFortRun && BRPVP_isZombieDay) then {execVM "server_code\servidor_defend_mission.sqf";};

//TRANSPORT MISSION
BRPVP_transActives = [];
publicVariable "BRPVP_transActives";
BRPVP_transCount = 1;
BRPVP_transMissionCode = compileFinal preprocessFileLineNumbers "server_code\server_transportMission.sqf";

//SUNKEN SUBMARINE MISSION
BRPVP_waterMissionSubs = [];
publicVariable "BRPVP_waterMissionSubs";
BRPVP_waterMissionRunning = [];
BRPVP_waterMissionCode = compileFinal preprocessFileLineNumbers "server_code\server_waterMission.sqf";

//CORRUPT MISSION
BRPVP_corruptMissIcon = [];
publicVariable "BRPVP_corruptMissIcon";
call compile preprocessFileLineNumbers "server_code\server_corruptMission.sqf";

//CARRIER MISSION
call compile preprocessFileLineNumbers "server_code\server_carrierMission.sqf";

//PLAYER MISSIONS
BRPVP_pmissIcons = [];
publicVariable "BRPVP_pmissIcons";

//PLAYER MISSIONS
BRPVP_pmiss2Icons = [];
publicVariable "BRPVP_pmiss2Icons";

//WEAK AI AROUND
call compile preprocessFileLineNumbers "server_code\server_weakAiAround.sqf";

//RAID TRAINING MISSION
call compile preprocessFileLineNumbers "server_code\server_raidTraining.sqf";

//GOOD PETER (ANTI-LAZARUS) HUNT
call compile preprocessFileLineNumbers "server_code\server_peterHunt.sqf";

//LAZARUS HUNT
call compile preprocessFileLineNumbers "server_code\server_lazarusHunt.sqf";

0 spawn {
	uiSleep 1200;
	if (!isNil "BRPVP_raidTrainingRunCode") then {if (BRPVP_raidTrainingMissionFlagSize isEqualTo -1) then {[[50,100,200],50] call BRPVP_raidTrainingRunCode;};};
	if (random 1 > 0.5) then {
		uiSleep 1200;
		call BRPVP_larsCreateMission;
		uiSleep 1200;
		call BRPVP_peterCreateMission;
	} else {
		uiSleep 1200;
		call BRPVP_peterCreateMission;
		uiSleep 1200;
		call BRPVP_larsCreateMission;
	};
};

//AI ATTACK BASE EXEC CODE
if (BRPVP_aiAttackBaseEnabled) then {call compile preprocessFileLineNumbers "server_code\server_aiAttackBase.sqf";};

//SPECIAL FORCES MISSION BY MASKE
call compile preprocessFileLineNumbers "server_code\server_specialForces.sqf";

//HAUNTED HOUSE BY MASKE AND DONNOVAN
call compile preprocessFileLineNumbers "map_specific\haunt_house.sqf";

//RADIOACTIVE AREA AI UNITS
call compile preprocessFileLineNumbers "server_code\server_radioUnits.sqf";

//LOOP
BRPVP_aiSimuCode = {
	if (BRPVP_aiSimuOn) then {
		private _init = diag_tickTime;
		private _allAiVehs = [objNull];
		private _aiSimuCodeLast = [BRPVP_posicaoFora,[],false];
		private _gChange = [];
		private _habGrpAi = [];
		private _habGrp = [];
		private _disGrpAi = [];
		private _disGrp = [];
		private _notSameCount = 0;
		private _sameCount = 0;
		call BRPVP_playersListWithVars params ["_players","_playersOthers","_allIds","_sPairs"];
		{
			private _ai = _x;
			private _token = _ai getVariable ["brpvp_fso_token",floor random 5];
			private _habilitedIds = _ai getVariable ["brpvp_habilited_ids",[]];
			private _veh = objectParent _ai;
			private _lastCase = _ai getVariable ["brpvp_last_case",0];
			private _wakeUp = false;
			private _inView = [];
			private _same = _ai distance (_aiSimuCodeLast select 0) < BRPVP_aiSimuEqualDist && _veh in _allAiVehs;
			if (_same) then {
				_inView = _aiSimuCodeLast select 1;
				_wakeUp = _aiSimuCodeLast select 2;
				_sameCount = _sameCount+1;
			} else {
				{
					private _dist = _x distance _ai;
					if (_dist < _x getVariable "brpvp_vd") then {_inView pushBackUnique (_x getVariable "brpvp_machine_id")};
					if (_dist < (_x getVariable ["brpvp_ai_simu_dist",BRPVP_aiSimuDist]) min (_x getVariable "brpvp_vd")) then {_wakeUp = true;};
				} forEach _players;
				{
					private _dist = _x distance _ai;
					if (_dist < _x getVariable "brpvp_vd") then {_inView pushBackUnique (_x getVariable "brpvp_machine_id");};
					if (_dist < (_x getVariable ["brpvp_ai_simu_dist",BRPVP_aiSimuDist]) min (_x getVariable "brpvp_vd")) then {_wakeUp = true;};
				} forEach _playersOthers;
				{
					_x params ["_sr","_sd"];
					if (_sd distance _ai < _sr getVariable "brpvp_vd") then {_inView pushBackUnique (_sr getVariable "brpvp_machine_id");};
				} forEach _sPairs;
				_inView = _inView-[-1];
				_aiSimuCodeLast = [ASLToAGL getPosASL _ai,_inView,_wakeUp];
				_notSameCount = _notSameCount+1;
			};
			_allAiVehs pushBackUnique _veh;
			if (_veh getVariable ["brpvp_can_disable",false] || (isNull _veh && serverTime-(_ai getVariable ["brpvp_out_veh_time",-100]) > 35)) then {
				if (_wakeUp) then {
					if (_token isEqualTo 0) then {_inView = _allIds;};
					if (_lastCase in [0,2]) then {
						_ai call BRPVP_enableAi;
						[_ai,true] remoteExecCall ["enableSimulation",_ai];
						if (!isNull _veh) then {[_veh,true] remoteExecCall ["enableSimulation",_veh];};
					};
					_habAdd = _inView-_habilitedIds;
					if (_habAdd isNotEqualTo []) then {
						if (_same) then {
							private _idx = _habGrp find _habAdd;
							if (_idx isEqualTo -1) then {_habGrp pushBack _habAdd;_habGrpAi pushBack [[_ai,_veh,true]];} else {_habGrpAi select _idx pushBack [_ai,_veh,true];};
						} else {
							[[_ai,_veh,true]] remoteExecCall ["BRPVP_enableSimulation",_habAdd];
						};
					};
					_habRemove = _habilitedIds-_inView;
					if (_habRemove isNotEqualTo []) then {
						if (_same) then {
							private _idx = _disGrp find _habRemove;
							if (_idx isEqualTo -1) then {_disGrp pushBack _habRemove;_disGrpAi pushBack [[_ai,_veh,false]];} else {_disGrpAi select _idx pushBack [_ai,_veh,false];};
						} else {
							[[_ai,_veh,false]] remoteExecCall ["BRPVP_enableSimulation",_habRemove];
						};
					};
					_ai setVariable ["brpvp_habilited_ids",_inView];
					_ai setVariable ["brpvp_last_case",1];
				} else {
					if (_lastCase in [0,3]) then {
						_gChange pushBack [_ai,_veh,false,false];
						_ai call BRPVP_disableAi;
						_ai setVariable ["brpvp_habilited_ids",[]];
						_ai setVariable ["brpvp_last_case",2];
					};
					if (_lastCase in [1]) then {
						_gChange pushBack [_ai,_veh,true,false];
						_ai setVariable ["brpvp_habilited_ids",_allIds];
						_ai setVariable ["brpvp_last_case",3];
					};
				};
			} else {
				if (_lastCase in [0,1,2]) then {
					_gChange pushBack [_ai,_veh,true,false];
					_ai call BRPVP_enableAi;
					_ai setVariable ["brpvp_habilited_ids",_allIds];
				};
				_ai setVariable ["brpvp_last_case",3];
			};
			_ai setVariable ["brpvp_fso_token",(_token+1) mod 5];
		} forEach (((BRPVP_roadBlockBots+BRPVP_missBotsEm+BRPVP_noShowBots)-[objNull]) select {local _x});
		{_x remoteExecCall ["BRPVP_enableSimulation",_habGrp select _forEachIndex];} forEach _habGrpAi;
		{_x remoteExecCall ["BRPVP_enableSimulation",_disGrp select _forEachIndex];} forEach _disGrpAi;
		_gChange remoteExecCall ["BRPVP_enableSimulationGlobal",2];
		_lastAiSimuState = true;
		BRPVP_aiSimuCodeRunTime = [count _allIds,count _players,_notSameCount+_sameCount,_notSameCount,diag_tickTime-_init];
	} else {
		if (_lastAiSimuState) then {
			private _gChange = [];
			{
				private _ai = _x;
				private _veh = objectParent _ai;
				_gChange pushBack [_ai,_veh,true,false];
			} forEach (((BRPVP_roadBlockBots+BRPVP_missBotsEm+BRPVP_noShowBots)-[objNull]) select {local _x});
			_gChange remoteExecCall ["BRPVP_enableSimulationGlobal",2];
			_lastAiSimuState = false;
		};
	};
};
BRPVP_nextMissionSetNew = {
	BRPVP_nextMissionCases = BRPVP_nextMissionCases-[_this];
	if (BRPVP_nextMissionCases isEqualTo []) then {BRPVP_nextMissionCases = +BRPVP_nextMissionCasesCfg;};
	BRPVP_nextMission = selectRandom BRPVP_nextMissionCases;
};
if (BRPVP_aiAttackBaseEnabled) then {
	BRPVP_aiAttackBaseHelis = (BRPVP_aiAttackBaseHelis apply {if (_x call BRPVP_classExists) then {_x} else {-1};})-[-1];
	BRPVP_aiAttackBaseCycleLast = diag_tickTime;
	BRPVP_aiAttackBaseFlags = [];
	BRPVP_aiAttackBaseDenied = [];
	BRPVP_aiAttackBaseData = [];
	BRPVP_aiAttackBase = {
		{
			private _flag = _x;
			private _fIdx = _forEachIndex;
			if (isNull _flag) then {
				private _id = BRPVP_aiAttackBaseData select _fIdx select 3;
				{
					private _newF = _x;
					if ((_newF getVariable "id_bd") isEqualTo _id) exitWith {BRPVP_aiAttackBaseFlags set [_fIdx,_newF];};
				} forEach (BRPVP_allFlags-[objNull]);
			};
		} forEach BRPVP_aiAttackBaseFlags;
		private _canAttack = [];
		{
			private _flag = _x;
			private _fId = _flag getVariable "id_bd";
			if !(_fId in BRPVP_aiAttackBaseDenied) then {
				private _fRad = _flag call BRPVP_getFlagRadius;
				private _qp = ((_flag nearEntities [BRPVP_playerModel,_fRad+75]) apply {if (_x getVariable ["sok",false] && [_x,_flag] call BRPVP_checaAcessoRemotoFlag) then {_x} else {-1};})-[-1]; //,true]
				private _cqp = count _qp;
				if (_cqp isEqualTo 0) then {
					private _i = BRPVP_aiAttackBaseFlags find _flag;
					if (_i isNotEqualTo -1) then {
						private _eptTime = BRPVP_aiAttackBaseData select _i select 1;
						if (_eptTime isEqualTo -1) then {
							(BRPVP_aiAttackBaseData select _i) set [1,diag_tickTime];
						} else {
							if (diag_tickTime-_eptTime > BRPVP_aiAttackBaseEptLim) then {
								BRPVP_aiAttackBaseFlags deleteAt _i;
								BRPVP_aiAttackBaseData deleteAt _i;
							};
						};
					};
				} else {
					private _i = BRPVP_aiAttackBaseFlags find _flag;
					if (_i isEqualTo -1) then {
						BRPVP_aiAttackBaseFlags pushBack _flag;
						BRPVP_aiAttackBaseData pushBack [diag_tickTime,-1,_cqp,_flag getVariable "id_bd",_qp];
					} else {
						(BRPVP_aiAttackBaseData select _i) set [2,(BRPVP_aiAttackBaseData select _i select 2)+_cqp];
						(BRPVP_aiAttackBaseData select _i) set [1,-1];
						private _tb = diag_tickTime-(BRPVP_aiAttackBaseData select _i select 0);
						private _qpt = BRPVP_aiAttackBaseData select _i select 2;
						private _qpts = round (_qpt/BRPVP_aiAttackBaseFactor);
						if (_tb > BRPVP_aiAttackBaseAttLim) then {_canAttack pushBack [_qpts,_tb,_qpt,_i,getPosASL _flag,_qp,_flag getVariable "id_bd",_fRad];};
					};
				};
			};
		} forEach (BRPVP_allFlags-[objNull]);
		if (diag_tickTime-BRPVP_aiAttackBaseCycleLast > BRPVP_aiAttackBaseCycle) then {
			BRPVP_aiAttackBaseCycleLast = diag_tickTime;
			if (_canAttack isNotEqualTo []) then {
				_canAttack sort false;
				private _bta = selectRandom (_canAttack select [0,2]);
				_bta params ["_pops","_tb","_pop","_ib","_pASL","_players","_fid","_fRad"];
				BRPVP_aiAttackBaseDenied pushBack _fid;
				BRPVP_aiAttackBaseFlags deleteAt _ib;
				BRPVP_aiAttackBaseData deleteAt _ib;
				[_pop,_pASL,_players,_fRad] spawn BRPVP_aiAttackBaseExec;
			};
		};
	};
};
BRPVP_setNewAiUnitOutOfAiArray = {
	private _bot = _this;
	_bot setVariable ["brpvp_ai",true,true];
	if (BRPVP_forceTracersToAllAiUnits) then {[_bot,["FiredMan",{call BRPVP_forcedTracerOnAiUnit;}]] remoteExecCall ["addEventHandler",BRPVP_allNoServer,true];};
	if (BRPVP_sixthSenseAiImmunePerc > 0) then {if (random 1 <= BRPVP_sixthSenseAiImmunePerc) then {_bot setVariable ["brpvp_ss_immune_mult",0,true];} else {if (random 1 < BRPVP_sixthSenseAiFeelObserverPerc) then {_bot setVariable ["brpvp_ss_reverse_view",true,true];};};};
	_bot enableStamina false;
};

0 spawn {
	scriptName "MISSIONS & AI LOOP";

	_sFpsArray = [];
	for "_i" from 1 to 100 do {_sFpsArray pushBack diag_fps;};
	_init = diag_tickTime-1;
	_tError = 0;	
	BRPVP_vehMissionCycleRandom = BRPVP_vehMissionCycleRandom min BRPVP_vehMissionCycle;
	_contaA = 0;
	_contaB = 0;
	_contaC = -50;
	_contaD = 5;
	_contaE = 0;
	_contaF = 0;
	_contaG = 1140;
	_contaH = 0;
	_loopsA = 30;
	_loopsB = 10;
	_loopsC = 10;
	_loopsD = 5;
	_loopsE = 2;
	_loopsF = 300;
	_loopsG = 1200;
	_loopsH = if (BRPVP_vehMissionEnable) then {BRPVP_vehMissionCycle-((floor random BRPVP_vehMissionCycleRandom)+1)} else {-1};
	BRPVP_aiSimuCodeRunTime = [-1,-1,-1,-1,-1];
	BRPVP_waterMissionNext = 0;
	BRPVP_transMissionNext = 0;
	BRPVP_holeMissionNext = 0;
	BRPVP_bombMissionNext = 0;
	BRPVP_siegeMissionNext = 0;
	BRPVP_bravoPointNext = 0;
	BRPVP_specForceNext = 0;
	BRPVP_carrierMissionNext = serverTime+(BRPVP_carrierMissDelayTime+floor random BRPVP_carrierMissRandomTime);
	BRPVP_pmissActualAiUnits = [];
	BRPVP_pmissObjects = [];
	BRPVP_pmissObjectsToDel = [];
	BRPVP_pmissEndCheckObjects = []; //ONLY IN PMISS, NEED TO IMPLEMENT IN PMISS2
	BRPVP_pmissSpawning = false;
	BRPVP_pmiss2ActualAiUnits = [];
	BRPVP_pmiss2Objects = [];
	BRPVP_pmiss2ObjectsToDel = [];
	BRPVP_pmiss2Spawning = false;
	_renewedBlock = [];
	_lastAiSimuState = true;
	_pcrashIni = time;
	_pcrashQt = BRPVP_mapaRodando select 21 select 2;
	_pcrashTm = BRPVP_mapaRodando select 21 select 3;
	_convoyOn = BRPVP_mapaRodando select 20 select 0;
	_convoyQt = BRPVP_mapaRodando select 20 select 1;
	_siegeOn =  BRPVP_mapaRodando select 19 select 0;
	_siegeQt =  BRPVP_mapaRodando select 19 select 1;
	_bravoPointOn = BRPVP_mapaRodando select 11 select 0;
	_bravoPointQt = BRPVP_mapaRodando select 11 select 3;
	_botRoadAmount = BRPVP_mapaRodando select 6 select 1;
	_botRoadSizes = BRPVP_mapaRodando select 6 select 2;
	_botRoadNextSize = selectRandom _botRoadSizes;
	_botRoadDeadCount = 0;
	_lastAllAiUnits = [];
	BRPVP_serverOrHcLoopCode = {
		if (_contaA isEqualTo _loopsA) then {
			_contaA = 0;

			//CLEAN AI
			_AIToDelete = [];
			{
				private _mainBot = _x select 0;
				private _deadTime = diag_tickTime-(_mainBot getVariable ["brpvp_ai_dead_time",0]);
				if (_deadTime > BRPVP_AIDeadTimeToDeletionElegible) then {
					if (_deadTime > BRPVP_deadAiForceDeletionTime) then {
						_AIToDelete pushBack _x;
					} else {
						private _pNear = false;
						private _posAGL = ASLToAGL getPosASL _mainBot;
						private _nearEntities = _posAGL nearEntities [BRPVP_playerModel,800];
						if (_nearEntities isEqualTo []) then {
							{if (_posAGL distance _x < 800 && _x call BRPVP_isPlayer) exitWith {_pNear = true;};} forEach BRPVP_playerVehicles;
						} else {
							{if (_x getVariable "sok") exitWith {_pNear = true;};} count _nearEntities;
						};
						if (!_pNear) then {_AIToDelete pushBack _x;};
					};
				};
			} forEach BRPVP_addAIonCleanProcess;
			BRPVP_addAIonCleanProcess = BRPVP_addAIonCleanProcess-_AIToDelete;
			{
				private _gAI = _x;
				{
					private _toDel = _x getVariable ["brpvp_del_on_clean",objNull];
					private _car = objectParent _x;
					if (!isNull _toDel && {_x distance _toDel < 15}) then {deleteVehicle _toDel;};
					if (isNull _car) then {deleteVehicle _x;} else {[_car,_x] remoteExecCall ["deleteVehicleCrew",_car];};
				} forEach _gAI;
			} forEach _AIToDelete;
			if (count _AIToDelete > 0) then {remoteExecCall ["BRPVP_AIRemoveNull",2];};

			//DELETE ZOMBIE LOOT
			_deleted = [];
			{
				if (time-(_x getVariable "brpvp_zombie_loot_time") > 300) then {
					_deleted pushBack _x;
					deleteVehicle _x;
				};
			} forEach BRPVP_zombieLootWH;
			if !(_deleted isEqualTo []) then {BRPVP_zombieLootWH = BRPVP_zombieLootWH-_deleted;};

			//FIX BUGGED AI WAYPOINTS
			//_iBwp = diag_tickTime;
			//call BRPVP_fixZeroWayPoint;
			//diag_log format ["BUGGED WP SEARCH AND FIX TIME (MILISECONDS): %1",1000*(diag_tickTime-_iBwp)];
		};
		if (_contaB isEqualTo _loopsB) then {
			_contaB = 0;

			diag_log ("[BRPVP AI SIMU CODE TIME #PLAYERS,#PLAYERS_EFFECTIVE,#BOTS,#BOTS_EFFECTIVE,TIME_TAKEN] "+str BRPVP_aiSimuCodeRunTime);
		};
		//START MISSIONS
		if (_contaC isEqualTo _loopsC) then {
			_contaC = 0;
			BRPVP_smallMissionsAIObjs = BRPVP_smallMissionsAIObjs-[objNull];

			if (count BRPVP_smallMissionsAIObjs <= BRPVP_maxAiOnSmallMissions) then {
				private _run = false;
				
				//TRANSPORT MISSION START: 1
				if (BRPVP_nextMission isEqualTo 1) exitWith {
					if (count BRPVP_transActives < BRPVP_transAmount && serverTime > BRPVP_transMissionNext) then {
						BRPVP_transMissionNext = serverTime+BRPVP_missionSleepTime;
						call BRPVP_transMissionCode;
						[["str_trans_mission_started",[]],-6] remoteExecCall ["BRPVP_hint",0];
					};
					1 call BRPVP_nextMissionSetNew;
				};

				//START HOLE MISSION: 2
				if (BRPVP_nextMission isEqualTo 2) exitWith {
					if (count BRPVP_holeMissionInfo < BRPVP_holeMissionNumber && serverTime > BRPVP_holeMissionNext) then {
						BRPVP_holeMissionNext = serverTime+BRPVP_missionSleepTime;
						call BRPVP_holeMissionMainCode;
					};
					2 call BRPVP_nextMissionSetNew;
				};

				//BOMB MISSION START: 3
				if (BRPVP_nextMission isEqualTo 3) exitWith {
					if (count BRPVP_bombMissionObjs < BRPVP_bombMissionAmount) then {
						if (serverTime > BRPVP_bombMissionNext) then {
							BRPVP_bombMissionUnits = BRPVP_bombMissionUnits apply {if (alive _x) then {_x} else {objNull}};
							BRPVP_bombMissionUnits = BRPVP_bombMissionUnits - [objNull];
							if (count BRPVP_bombMissionUnits < BRPVP_bombMissionAmount*15) then {
								BRPVP_bombMissionNext = serverTime+BRPVP_missionSleepTime;
								call BRPVP_bombMissionCode;
								[["str_bomb_mission_started",[]],-6] remoteExecCall ["BRPVP_hint",0];
							};
						};
					};
					3 call BRPVP_nextMissionSetNew;
				};

				//SIEGE MISSION START: 4
				if (BRPVP_nextMission isEqualTo 4) exitWith {
					if (_siegeOn) then {
						_siegeQtNow = {_x isEqualTo 1 || _x isEqualTo 2} count BRPVP_closedCityRunning;
						if (_siegeQtNow < _siegeQt) then {
							if (serverTime > BRPVP_siegeMissionNext) then {
								BRPVP_siegeMissionNext = serverTime+BRPVP_missionSleepTime;
								0 spawn BRPVP_besiegedMission;
							};
						};
					};
					4 call BRPVP_nextMissionSetNew;
				};

				//BRAVO POINT: 5
				if (BRPVP_nextMission isEqualTo 5) exitWith {
					if (_bravoPointOn && _bravoPointQt > 0) then {
						_qtMiss = count BRPVP_missPrediosEm;
						if (_qtMiss < _bravoPointQt) then {
							if (serverTime > BRPVP_bravoPointNext) then {
								BRPVP_bravoPointNext = serverTime+BRPVP_missionSleepTime;
								0 spawn BRPVP_criaMissaoDePredio;
							};
						};
					};
					5 call BRPVP_nextMissionSetNew;
				};

				//RENEW BLOCK MISSION IF NEEDED: 6
				if (BRPVP_nextMission isEqualTo 6) exitWith {
					if (_renewedBlock isNotEqualTo []) then {
						call BRPVP_roadBlockRenew;
						[BRPVP_roadBlockBots,BRPVP_blockPlacesSelected] remoteExecCall ["BRPVP_updateBlockInfo",BRPVP_allNoServer];
						_renewedBlock = [];
					};
					6 call BRPVP_nextMissionSetNew;
				};

				//PUT MORE ROAD BOTS IF NEEDED: 7
				if (BRPVP_nextMission isEqualTo 7) exitWith {
					{
						if (!alive _x) then {
							_botRoadDeadCount = _botRoadDeadCount+1;
							BRPVP_spawnOnRoadBotsObjs set [_forEachIndex,-1];
						};
					} forEach BRPVP_spawnOnRoadBotsObjs;
					BRPVP_spawnOnRoadBotsObjs = BRPVP_spawnOnRoadBotsObjs-[-1];
					while {_botRoadDeadCount >= _botRoadNextSize} do {
						[1,[_botRoadNextSize]] call BRPVP_spawnOnRoadBots;
						_botRoadDeadCount = _botRoadDeadCount-_botRoadNextSize;
						_botRoadNextSize = selectRandom _botRoadSizes;
					};
					7 call BRPVP_nextMissionSetNew;
				};

				//START CARRIER MISSION: 8
				if (BRPVP_nextMission isEqualTo 8) exitWith {
					if (serverTime > BRPVP_carrierMissionNext) then {
						BRPVP_carrierMissionNext = serverTime+360000;
						0 spawn BRPVP_carrierMissMainCode;
					};
					8 call BRPVP_nextMissionSetNew;
				};

				//WATER MISSION START: 9
				if (BRPVP_nextMission isEqualTo 9) exitWith {
					if (count BRPVP_waterMissionRunning < BRPVP_waterMissionAmount) then {
						if (serverTime > BRPVP_waterMissionNext) then {
							BRPVP_waterMissionNext = serverTime+BRPVP_missionSleepTime;
							call BRPVP_waterMissionCode;
							[["str_water_mission_started",[call BRPVP_worldName]],-5] remoteExecCall ["BRPVP_hint",0];
						};
					};
					9 call BRPVP_nextMissionSetNew;
				};

				//SPECIAL FORCES MISSION START: 10
				if (BRPVP_nextMission isEqualTo 10) exitWith {
					if (count BRPVP_specialForcesMissionsOn < BRPVP_specialForcesMissionsNumber) then {
						if (serverTime > BRPVP_specForceNext) then {
							BRPVP_specForceNext = serverTime+1200;
							call BRPVP_specialForcesRunCode;
						};
					};
					10 call BRPVP_nextMissionSetNew;
				};
			};
		};
		//5 SECONDS LOOP
		if (_contaD isEqualTo _loopsD) then {
			_contaD = 0;

			//SAVE DAMAGED VEH IF DIED
			call BRPVP_saveDeadVehDataBefore;

			//GET NEW AI UNITS
			private _aiUnitsNow = (BRPVP_roadBlockBots+BRPVP_missBotsEm+BRPVP_noShowBots)-[objNull];
			private _newAiUnits = _aiUnitsNow-_lastAllAiUnits;
			_lastAllAiUnits = +_aiUnitsNow;
			{
				private _bot = _x;
				_bot setVariable ["brpvp_ai",true,true];

				//ADD CIGARS
				if (BRPVP_iCigsRunning) then {
					if (random 1 < BRPVP_iCigsAIUseCigsChance) then {
						private _items = [];
						for "_i" from 1 to selectRandom [1,1,2] do {_items pushBack selectRandom BRPVP_iCigsAIObjects;};
						if (goggles _bot isNotEqualTo "") then {removeGoggles _bot;};
						_bot addGoggles selectRandom BRPVP_iCigsAIUse;
						private _failedItems = [];
						{
							if (isClass (configFile >> "CfgMagazines" >> _x)) then {
								[_bot,_x] call BRPVP_addLootHelperMag;
							} else {
								if (isClass (configFile >> "CfgGlasses" >> _x)) then {[_bot,_x] call BRPVP_addLootHelperItem;};
							};
						} forEach _items;
					};
				};
				if (BRPVP_uberAttackUse) then {
					if (_bot checkAIFeature "PATH" && isNull objectParent _bot && !(_bot in BRPVP_noShowBots)) then {
						if (random 1 < BRPVP_uberAttackPercentage) then {_bot remoteExecCall ["BRPVP_uberAttackAddAi",_bot];};
					};
				};
				if (BRPVP_forceTracersToAllAiUnits) then {[_bot,["FiredMan",{call BRPVP_forcedTracerOnAiUnit;}]] remoteExecCall ["addEventHandler",BRPVP_allNoServer,true];};
				if (BRPVP_sixthSenseAiImmunePerc > 0) then {if (random 1 <= BRPVP_sixthSenseAiImmunePerc) then {_bot setVariable ["brpvp_ss_immune_mult",0,true];} else {if (random 1 < BRPVP_sixthSenseAiFeelObserverPerc) then {_bot setVariable ["brpvp_ss_reverse_view",true,true];};};};

				//SET AS ULFAN
				if (random 1 <= BRPVP_ulfanSoldierPercentage && isNull objectParent _bot && !(_bot getVariable ["brpvp_uber_attack",false]) && _bot getVariable ["brpvp_can_ulfanize",true]) then {
					_bot enableStamina false;
					_bot setUnitLoadout selectRandom BRPVP_ulfanSoldierLoadouts;
					_bot remoteExecCall ["BRPVP_sBotAllUnitsObjsAdd",0];
					_bot setVariable ["brpvp_is_ulfan",true,true];
					_bot setVariable ["brpvp_ss_immune_mult",0,true];
					_bot setVariable ["brpvp_no_possession",true,true];
					_bot setVariable ["brpvp_lst",0];
					_bot setVariable ["brpvp_no_head_hit",0];
					_bot setVariable ["brpvp_wrong_player",objNull];
					[_bot,BRPVP_ulfanSoldierSpeed] remoteExecCall ["setAnimSpeedCoef",0];
					[_bot,["Fired",{call BRPVP_sBotFired;}]] remoteExecCall ["addEventHandler",_bot];
					[_bot,["aimingAccuracy",BRPVP_ulfanSoldierSkill select 0]] remoteExecCall ["setSkill",_bot];
					[_bot,BRPVP_ulfanSoldierSkill select 1] remoteExecCall ["setSkill",_bot];
				};

				//MINERVA AI
				private _canMinerv = _bot getVariable ["brpvp_can_ulfanize",true] && !(_bot getVariable ["brpvp_is_ulfan",false]) && !(_bot getVariable ["brpvp_uber_attack",false]) && _bot checkAIFeature "PATH" && isNull objectParent _bot && !(_bot in BRPVP_noShowBots);
				if (_bot call BRPVP_aiWithLauncherHaveMinervaCheck && _canMinerv) then {
					_bot remoteExecCall ["BRPVP_minervaBotAllUnitsObjsAdd",0];
					_bot setVariable ["brpvp_minerva_ai_unit",true,true];
					private _aItems = _bot getVariable ["brpvp_alt_i_items",[]];
					_aItems pushBack ["BRPVP_minervaShot",selectRandom [1,2]];
					_bot setVariable ["brpvp_alt_i_items",_aItems,true];
					[_bot,1] remoteExecCall ["setSkill",_bot];
					_bot setUnitLoadout selectRandom BRPVP_aiWithLauncherHaveMinervaLoadout;
					[_bot,["Fired",{call BRPVP_aiWithMinervaFired;}]] remoteExecCall ["addEventHandler",_bot];
				};

				//STAMINA OFF FOR ALL AI UNITS
				_bot enableStamina false;
			} forEach _newAiUnits;

			//PLASMA SNIPER AI UNITS
			if (BRPVP_GX_M82A2000_SpawnTimes isNotEqualTo []) then {
				private _newAiUnitsNoVeh = _newAiUnits select {isNull objectParent _x && !(_x getVariable ["brpvp_is_ulfan",false])};
				private _plasmaDel = [];
				{
					if (serverTime > _x && _newAiUnitsNoVeh isNotEqualTo []) then {
						private _bot = _newAiUnitsNoVeh deleteAt floor random count _newAiUnitsNoVeh;
						if !(primaryWeapon _bot in ["GX_M82A2000_Weapon",""]) then {
							_bot remoteExecCall ["BRPVP_addPlasmaRifle",_bot];
							_plasmaDel pushBack _forEachIndex;
						};
					};
				} forEach BRPVP_GX_M82A2000_SpawnTimes;
				_plasmaDel sort false;
				{BRPVP_GX_M82A2000_SpawnTimes deleteAt _x;} forEach _plasmaDel;
			};
		};
		//START KONVOY MISSION
		if (_contaG isEqualTo _loopsG) then {
			_contaG = 0;
			if (_convoyOn) then {
				_kvyDelIdc = [];
				{
					_compositionsOk = {alive _x && {canMove _x}} count (_x select 0);
					if (_compositionsOk isEqualTo 0) then {
						_kvyDelIdc pushBack _forEachIndex;
					};
				} forEach BRPVP_konvoyCompositions;
				_kvyDelIdc sort false;
				{BRPVP_konvoyCompositions deleteAt _x;} forEach _kvyDelIdc;
				if (count BRPVP_konvoyCompositions < _convoyQt) then {
					call BRPVP_convoyMission;
				};
			};
		};
		//VEHICLE MISSION START
		if (_contaH isEqualTo _loopsH) then {
			if (_contaH isEqualTo BRPVP_vehMissionCycle) then {
				_contaH = 0;
				_loopsH = if (BRPVP_remainingSeconds >= BRPVP_vehMissionCycle) then {
					BRPVP_vehMissionCycle-((floor random BRPVP_vehMissionCycleRandom)+1)
				} else {
					BRPVP_vehMissionCycle
				};
			} else {
				private _startOk = call BRPVP_vehicleMissionCode;
				_loopsH = if (_startOk) then {BRPVP_vehMissionCycle} else {BRPVP_vehMissionCycle min 120};
			};
		};
		if (_contaE isEqualTo _loopsE) then {
			_contaE = 0;

			//DISABLE OR ENABLE AI UNITS
			call BRPVP_aiSimuCode;
		};
		if (_contaF isEqualTo _loopsF) then {
			_contaF = 0;

			//SPAWN PLAYER MISSION
			if (!BRPVP_pmissSpawning) then {
				if (BRPVP_pmissData isNotEqualTo [] && BRPVP_pmissMaxPerRestart > 0) then {
					if ({alive _x} count BRPVP_pmissActualAiUnits <= 5) then {
						private _miss = if (BRPVP_pmissOrder) then {BRPVP_pmissData deleteAt 0} else {BRPVP_pmissData deleteAt floor random count BRPVP_pmissData};
						_miss params ["_script","_img","_rad","_iconPosAll","_places","_sche","_name","_skill","_author"];
						private _idx = floor random count _iconPosAll;
						private _iPos = _iconPosAll select _idx;
						private _place = _places select _idx;
						if (BRPVP_pmissObjects isNotEqualTo []) then {BRPVP_pmissObjectsToDel pushBack [time,+BRPVP_pmissObjects,+BRPVP_pmissActualAiUnits,BRPVP_pmissEndCheckObjects];};
						BRPVP_pmissActualAiUnits = [];
						BRPVP_pmissObjects = [];
						private _mines = nearestObjects [_place,BRPVP_zombieDistractAmmo,_rad];
						if (_mines isNotEqualTo []) then {_mines spawn {{_x remoteExecCall ["BRPVP_missionStartEndExplodeLocalMines",2];uiSleep random 0.25;} forEach _this;};};
						if (_sche isEqualTo "scheduled") then {
							BRPVP_pmissSpawning = true;
							[_place,_rad,_skill] spawn compile preprocessFileLineNumbers _script;
						} else {
							isNil {[_place,_rad,_skill] spawn compile preprocessFileLineNumbers _script;};
							BRPVP_pmissSpawning = false;
						};
						BRPVP_pmissIcons = [[_iPos,_img,_name,_author]];
						publicVariable "BRPVP_pmissIcons";
						BRPVP_pmissMaxPerRestart = BRPVP_pmissMaxPerRestart-1;
					};
				} else {
					if (BRPVP_pmissActualAiUnits isNotEqualTo []) then {
						if ({alive _x} count BRPVP_pmissActualAiUnits <= 5) then {
							BRPVP_pmissObjectsToDel pushBack [time,+BRPVP_pmissObjects,+BRPVP_pmissActualAiUnits,BRPVP_pmissEndCheckObjects];
							BRPVP_pmissActualAiUnits = [];
							BRPVP_pmissObjects = [];
							BRPVP_pmissIcons = [];
							publicVariable "BRPVP_pmissIcons";
						};
					};
				};
			};

			//DELETE PLAYER MISSION OBJECTS
			if (!BRPVP_pmissSpawning) then {
				{
					_x params ["_init","_objs","_ais","_endO"];
					if (time-_init > 1200) then {
						private _pos = _objs select 0;
						private _rad = _objs select 1;
						private _ves = _objs select 6;
						private _bui = _objs select 2;
						private _cod = _objs select 8;
						if ({_x distance _pos < 1000} count call BRPVP_playersList isEqualTo 0 && _endO call _cod) then {
							{
								private _idOk = (_x getVariable ["id_bd",-1]) isEqualTo -1;
								private _ownOk = (_x getVariable ["own","no_own"]) isEqualTo "no_own";
								if (_idOk && _ownOk) then {deleteVehicle _x;};
							} forEach nearestObjects [_pos,["ThingX"],_rad];
							{
								if (_x getVariable ["ml_takes",-1] isEqualTo -1) then {deleteVehicle _x;};
							} forEach nearestObjects [_pos,["WeaponHolderSimulated","GroundWeaponHolder"],_rad];
							{
								private _veh = objectParent _x;
								_x removeAllEventHandlers "HandleDamage";
								_x removeAllEventHandlers "Killed";
								if (isNull _veh) then {
									deleteVehicle _x;
								} else {
									if (local _veh) then {
										_veh deleteVehicleCrew _x;
									} else {
										[_veh,_x] remoteExecCall ["deleteVehicleCrew",_veh];
									};
								};
							} forEach _ais;
							{deleteVehicle _x;} forEach _bui;
							{if (_x getVariable ["brpvp_yes_minerva",false]) then {deleteVehicle _x;};} forEach ((nearestObjects [_pos,["Building","Wall"],_rad,true])-_bui);
							{
								if (isNull (_x getVariable "brpvp_operator")) then {
									deleteVehicle _x;
								} else {
									_x remoteExecCall ["BRPVP_destroyTurret",2];
									_x setPosWorld BRPVP_posicaoFora;
								};
							} forEach (_objs select 3);
							{
								private _partsClass = _x getVariable "BIS_carrierParts";
								private _os = _partsClass apply {_x select 0};
								deleteVehicle _x;
								{deleteVehicle _x;} forEach _os;
							} forEach ((_objs select 4)+(_objs select 5));
							[_pos,_rad,_ves,_bui] spawn {
								params ["_pos","_rad","_ves","_bui"];
								{
									private _crew = crew _x;
									private _haveP = {_x call BRPVP_isPlayer} count _crew > 0;
									if (!_haveP) then {
										_x removeAllEventHandlers "HandleDamage";
										_x removeAllEventHandlers "Killed";
										_x removeAllEventHandlers "GetIn";
										deleteVehicle _x;
										_crew spawn {
											uiSleep 0.1;
											{deleteVehicle _x;} forEach _this;
										};
									};
								} forEach _ves;
								
								waitUntil {
									uiSleep 1;
									{!isNull _x} count _bui isEqualTo 0
								};
								[_pos,_rad] call BRPVP_wakeUpObjectsFlying;
							};
							{
								[_x,true] remoteExecCall ["allowDamage",0];
								[_x,false] remoteExecCall ["hideObjectGlobal",2];
							} forEach (_objs select 7);

							private _mines = nearestObjects [_pos,BRPVP_zombieDistractAmmo,_rad];
							if (_mines isNotEqualTo []) then {_mines spawn {{_x remoteExecCall ["BRPVP_missionStartEndExplodeLocalMines",2];uiSleep random 0.25;} forEach _this;};};

							BRPVP_pmissObjectsToDel set [_forEachIndex,[]];
						};
					};
				} forEach BRPVP_pmissObjectsToDel;
				BRPVP_pmissObjectsToDel = BRPVP_pmissObjectsToDel-[[]];
			};

			//SPAWN PLAYER MISSION 2
			if (!BRPVP_pmiss2Spawning) then {
				if (BRPVP_pmiss2Data isNotEqualTo [] && BRPVP_pmiss2MaxPerRestart > 0) then {
					if ({alive _x} count BRPVP_pmiss2ActualAiUnits <= 5) then {
						private _miss = if (BRPVP_pmiss2Order) then {BRPVP_pmiss2Data deleteAt 0} else {BRPVP_pmiss2Data deleteAt floor random count BRPVP_pmiss2Data};
						_miss params ["_script","_img","_rad","_iconPosAll","_places","_sche","_name","_skill","_author"];
						private _idx = floor random count _iconPosAll;
						private _iPos = _iconPosAll select _idx;
						private _place = _places select _idx;
						if (BRPVP_pmiss2Objects isNotEqualTo []) then {BRPVP_pmiss2ObjectsToDel pushBack [time,+BRPVP_pmiss2Objects,+BRPVP_pmiss2ActualAiUnits];};
						BRPVP_pmiss2ActualAiUnits = [];
						BRPVP_pmiss2Objects = [];
						private _mines = nearestObjects [_place,BRPVP_zombieDistractAmmo,_rad];
						if (_mines isNotEqualTo []) then {_mines spawn {{_x remoteExecCall ["BRPVP_missionStartEndExplodeLocalMines",2];uiSleep random 0.25;} forEach _this;};};
						if (_sche isEqualTo "scheduled") then {
							BRPVP_pmiss2Spawning = true;
							[_place,_rad,_skill] spawn compile preprocessFileLineNumbers _script;
						} else {
							isNil {[_place,_rad,_skill] spawn compile preprocessFileLineNumbers _script;};
							BRPVP_pmiss2Spawning = false;
						};
						BRPVP_pmiss2Icons = [[_iPos,_img,_name,_author]];
						publicVariable "BRPVP_pmiss2Icons";
						BRPVP_pmiss2MaxPerRestart = BRPVP_pmiss2MaxPerRestart-1;
					};
				} else {
					if (BRPVP_pmiss2ActualAiUnits isNotEqualTo []) then {
						if ({alive _x} count BRPVP_pmiss2ActualAiUnits <= 5) then {
							BRPVP_pmiss2ObjectsToDel pushBack [time,+BRPVP_pmiss2Objects,+BRPVP_pmiss2ActualAiUnits];
							BRPVP_pmiss2ActualAiUnits = [];
							BRPVP_pmiss2Objects = [];
							BRPVP_pmiss2Icons = [];
							publicVariable "BRPVP_pmiss2Icons";
						};
					};
				};
			};

			//DELETE PLAYER MISSION 2 OBJECTS
			if (!BRPVP_pmiss2Spawning) then {
				{
					_x params ["_init","_objs","_ais"];
					if (time-_init > 1200) then {
						private _pos = _objs select 0;
						private _rad = _objs select 1;
						private _ves = _objs select 6;
						private _bui = _objs select 2;
						if ({_x distance _pos < 1000} count call BRPVP_playersList isEqualTo 0) then {
							{
								private _idOk = (_x getVariable ["id_bd",-1]) isEqualTo -1;
								private _ownOk = (_x getVariable ["own","no_own"]) isEqualTo "no_own";
								if (_idOk && _ownOk) then {deleteVehicle _x;};
							} forEach nearestObjects [_pos,["ThingX"],_rad];
							{
								if (_x getVariable ["ml_takes",-1] isEqualTo -1) then {deleteVehicle _x;};
							} forEach nearestObjects [_pos,["WeaponHolderSimulated","GroundWeaponHolder"],_rad];
							{
								private _veh = objectParent _x;
								_x removeAllEventHandlers "HandleDamage";
								_x removeAllEventHandlers "Killed";
								if (isNull _veh) then {
									deleteVehicle _x;
								} else {
									if (local _veh) then {
										_veh deleteVehicleCrew _x;
									} else {
										[_veh,_x] remoteExecCall ["deleteVehicleCrew",_veh];
									};
								};
							} forEach _ais;
							{deleteVehicle _x;} forEach _bui;
							{if (_x getVariable ["brpvp_yes_minerva",false]) then {deleteVehicle _x;};} forEach ((nearestObjects [_pos,["Building","Wall"],_rad,true])-_bui);
							{
								if (isNull (_x getVariable "brpvp_operator")) then {
									deleteVehicle _x;
								} else {
									_x remoteExecCall ["BRPVP_destroyTurret",2];
									_x setPosWorld BRPVP_posicaoFora;
								};
							} forEach (_objs select 3);
							{
								private _partsClass = _x getVariable "BIS_carrierParts";
								private _os = _partsClass apply {_x select 0};
								deleteVehicle _x;
								{deleteVehicle _x;} forEach _os;
							} forEach ((_objs select 4)+(_objs select 5));
							[_pos,_rad,_ves,_bui] spawn {
								params ["_pos","_rad","_ves","_bui"];
								{
									private _crew = crew _x;
									private _haveP = {_x call BRPVP_isPlayer} count _crew > 0;
									if (!_haveP) then {
										_x removeAllEventHandlers "HandleDamage";
										_x removeAllEventHandlers "Killed";
										_x removeAllEventHandlers "GetIn";
										deleteVehicle _x;
										_crew spawn {
											uiSleep 0.1;
											{deleteVehicle _x;} forEach _this;
										};
									};
								} forEach _ves;
								
								waitUntil {
									uiSleep 1;
									{!isNull _x} count _bui isEqualTo 0
								};
								[_pos,_rad] call BRPVP_wakeUpObjectsFlying;
							};
							{
								[_x,true] remoteExecCall ["allowDamage",0];
								[_x,false] remoteExecCall ["hideObjectGlobal",2];
							} forEach (_objs select 7);

							private _mines = nearestObjects [_pos,BRPVP_zombieDistractAmmo,_rad];
							if (_mines isNotEqualTo []) then {_mines spawn {{_x remoteExecCall ["BRPVP_missionStartEndExplodeLocalMines",2];uiSleep random 0.25;} forEach _this;};};

							BRPVP_pmiss2ObjectsToDel set [_forEachIndex,[]];
						};
					};
				} forEach BRPVP_pmiss2ObjectsToDel;
				BRPVP_pmiss2ObjectsToDel = BRPVP_pmiss2ObjectsToDel-[[]];
			};

			//END CIVIL PLANE CRASH MISSION
			_changed = false;
			{
				if (!isNull _x) then {
					_bm = _x getVariable "bm";
					_sc = _bm getVariable "sc";
					if (_sc isEqualTo objNull) then {
						BRPVP_corruptMissIcon set [_forEachIndex,objNull];
						_changed = true;
					};
				};
			} forEach BRPVP_corruptMissIcon;
			if (_changed) then {publicVariable "BRPVP_corruptMissIcon";};

			//CIVIL PLANE CRASH MISSION START
			if (_pcrashQt > 0) then {
				_tm = time-_pcrashIni;
				if (_tm >= _pcrashTm*60) then {
					_pcrashIni = time;
					_pcrashQt = _pcrashQt-1;
					[] spawn BRPVP_corruptMissSpawn;
				};
			};

			//END HOLE MISSION
			_del = [];
			{
				_holes = _x select 2;
				if ({isNull _x} count _holes > 0) then {
					deleteMarker ("HOLE_MISS_"+str (_x select 3));
					_del pushBack _forEachIndex;
				};
			} forEach BRPVP_holeMissionInfo;
			if (_del isNotEqualTo []) then {
				_del sort false;
				{BRPVP_holeMissionInfo deleteAt _x;} forEach _del;
				publicVariable "BRPVP_holeMissionInfo";
				BRPVP_holeMissionNext = serverTime+BRPVP_missionSleepTime;
			};

			//END ROAD BLOCK MISSION
			_renewedBlockAdd = [];
			{
				_center = _x select 0;
				_bots = BRPVP_blockPlacesSelectedBots select _forEachIndex;
				if ({alive _x && _center distance _x < 400} count _bots isEqualTo 0) then {
					BRPVP_roadBlockBots = BRPVP_roadBlockBots-_bots;
					_renewedBlockAdd pushBack _forEachIndex;
				};
			} forEach BRPVP_blockPlacesSelected;
			if (_renewedBlockAdd isNotEqualTo []) then {
				_renewedBlockAdd sort false;
				{
					private _center = BRPVP_blockPlacesSelected select _x select 0;
					private _key = BRPVP_blockPlacesSelectedPvpAreas deleteAt _x;
					if (_key isNotEqualTo "") then {
						_key remoteEXecCall ["BRPVP_removePvpArea",2];
						_key remoteExecCall ["BRPVP_removePosCheckLayer",0];
					};
					BRPVP_blockPlacesSelected deleteAt _x;
					BRPVP_blockPlacesSelectedBots deleteAt _x;
					{deleteVehicle _x;} forEach (BRPVP_blockPlacesSelectedObjs deleteAt _x);
				} forEach _renewedBlockAdd;
				[BRPVP_roadBlockBots,BRPVP_blockPlacesSelected] remoteExecCall ["BRPVP_updateBlockInfo",BRPVP_allNoServer];
			};
			_renewedBlock append _renewedBlockAdd;

			//SIEGE MISSION END
			_terminatedSiege = false;
			{
				if (_x isEqualTo 2) then {
					_idc = _forEachIndex;
					_ais = BRPVP_closedCityAI select _idc;
					_lPos = BRPVP_locaisImportantes select _idc select 0;
					_lRad = BRPVP_locaisImportantes select _idc select 1;
					_aisOk = {alive _x && _x distance _lPos < _lRad+100} count _ais;
					if (_aisOk <= 2) then {
						BRPVP_closedCityRunning set [_forEachIndex,3];
						_lName = BRPVP_locaisImportantes select _idc select 2;
						_terminatedSiege = true;
						[["str_siege_end",[_lName]],5,15,0,"batida"] remoteExecCall ["BRPVP_hint",0];
						{deleteVehicle _x;} forEach (BRPVP_closedCityWalls select _idc);
						{if !(typeOf _x in BRPVP_towas) then {deleteVehicle _x;};} forEach (BRPVP_closedCityObjs select _idc);
					};
				};
			} forEach BRPVP_closedCityRunning;
			if (_terminatedSiege) then {
				BRPVP_closedCityRunning remoteExecCall ["BRPVP_closedCityRunningSet",0];
				BRPVP_siegeMissionNext = serverTime+BRPVP_missionSleepTime;
			};

			//END BRAVO POINT MISSION
			_buFim = [];
			{
				_bu = _x;
				_vivoQt = {alive _x && _x distance _bu < 300} count (_bu getVariable ["msbs",[]]);
				if (_vivoQt <= 2) then {
					_buFim pushBack _bu;
					[_bu,true] remoteExecCall ["allowDamage",0,true];
				};
			} forEach BRPVP_missPrediosEm;
			if (count _buFim > 0) then {
				BRPVP_missPrediosEm = BRPVP_missPrediosEm-_buFim;
				publicVariable "BRPVP_missPrediosEm";
				BRPVP_bravoPointNext = serverTime+BRPVP_missionSleepTime;
			};

			//REFUEL ALL AI VEHICLES
			{
				if (_x getVariable ["id_bd",-1] isEqualTo -1 && !(_x getVariable ["brpvp_fedidex",false]) && !(_x getVariable ["brpvp_no_refuel",false])) then {
					if ({alive _x && _x getVariable ["id_bd",-1] isEqualTo -1} count crew _x > 0) then {[_x,1] remoteExecCall ["setFuel",_x];};
				};
			} forEach entities [["Motorcycle","Tank","Car","Air","Ship"],[]];

			//SAVE SIMPLE OBJECTS ON DB
			call BRPVP_saveSimpleObjectsOnDb;

			//MAKE AI ATTACK BASES
			if (BRPVP_aiAttackBaseEnabled) then {call BRPVP_aiAttackBase;};
		};
		_contaA = _contaA+1;
		_contaB = _contaB+1;
		_contaC = _contaC+1;
		_contaD = _contaD+1;
		_contaE = _contaE+1;
		_contaF = _contaF+1;
		_contaG = _contaG+1;
		_contaH = _contaH+1;
	};

	//EXEC LOOP
	waitUntil {
		private _t = diag_tickTime;
		private _delta = _t-_init;
		_sFpsArray deleteAt 0;
		_sFpsArray pushBack diag_fps;
		if (_delta >= 1-_tError) then {
			_init = _t;
			_tError = _tError+(_delta-1);
			call BRPVP_serverOrHcLoopCode;
		};
		false
	};
};

//PLACES TO AVOID MISSIONS
_blackTradersPlaces = BRPVP_blackTradersPlaces apply {[_x select 0,50,_x select 2]};
_classAdTradersNoBuild = BRPVP_classAdTraders apply {[_x select 0,100,"Class Ad"]};
_playerMissions = [];
{private _miss = _x;_playerMissions append ((_miss select 3) apply {[_x,_miss select 2]});} forEach (BRPVP_pmissData+BRPVP_pmiss2Data);
BRPVP_placesNoMissions = BRPVP_mercadoresPos+BRPVP_buyersPos+BRPVP_vehicleTradersPos+BRPVP_travelingAidPlaces+BRPVP_dismantleAreas+BRPVP_thiefAreas+BRPVP_eventsData+BRPVP_insurancePlaces+_blackTradersPlaces+BRPVP_farmPrivateMines+_playerMissions+_classAdTradersNoBuild;

//LIBERATE CLIENTS
sleep 2;
BRPVP_ServerMissionsOk = true;
publicVariable "BRPVP_ServerMissionsOk";
BRPVP_HC1ClientOk = true;
publicVariable "BRPVP_HC1ClientOk";
