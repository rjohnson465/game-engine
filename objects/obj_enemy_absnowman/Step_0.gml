if phaseChangeFrame < 0 {
	event_inherited();
}

if hp < (.5*maxHp) && phase == 0 && state != CombatantStates.Attacking && hp > 0 {

	if room == rm_abominable_snowman {
		with global.gameManager.bgmManager {
			startBgm(snd_bgm_absnowman_2, true);
		}
	}
	
	lightRadiusAlpha = .95;
	var lr = noone;
	with obj_light_radius {
		if owner == other {
			lr = id;
		}
	}
	if instance_exists(lr) {
		with lr {
			light_set_alpha(other.lightRadiusAlpha);
		}
	}

	stopAllAttacks();
	state = CombatantStates.AggroMelee;
	audio_emitter_gain(walkingEmitter, 0);
	path_end();
	
	phase = 1;
	phaseChangeFrame = 0;
	functionalSpeed = 10;
	normalSpeed = 10;
	turnSpeed = 10;
	normalTurnSpeed = turnSpeed;
	hpRegen = 1;
	audio_play_sound(snd_magic_ice_shoot, 1, 0);
	audio_play_sound(snd_enemy_troll_death1, 1, 0);
	
	// snowflake
	var snowflake = part_type_create();
	part_type_shape(snowflake, pt_shape_snow);
	part_type_orientation(snowflake,0,0,0,15,1);
	part_type_size(snowflake,.25,0.5,0,0);
	part_type_speed(snowflake,3,6,0,0);
	part_type_direction(snowflake,0,360,0,4);
	part_type_life(snowflake,25,45);
	part_type_alpha3(snowflake,1,.75,.5);
	part_type_color2(snowflake, c_white, c_navy);
	
	var x1 = bbox_left; var x2 = bbox_right;
	var y1 = bbox_top; var y2 = bbox_bottom;
	part_system_depth(sporeSystem, layer_get_depth(layer)-10);
	part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(sporeSystem,sporeEmitter,snowflake, 20);
	
	
	// mem leak
	part_type_destroy(snowflake); snowflake = -1;
	
	// attacks update for phase 2
	attackFrequencyTotalFramesMeleeDefault = [30, 40];
	attackFrequencyTotalFramesRangedDefault = [30, 30];
	
	global.owner = id;
	var sb11 = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_1_melee);
	var sb12 = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_2_melee);

	var sb21 = makeEnemyAttackObj(obj_attack_absnowman_snowball_2_1_melee);

	var swing11 = makeEnemyAttackObj(obj_attack_absnowman_swing_1_1);
	var swing12 = makeEnemyAttackObj(obj_attack_absnowman_swing_1_2);
	var swing21 = makeEnemyAttackObj(obj_attack_absnowman_swing_2_1);
	var fallAttack = makeEnemyAttackObj(obj_attack_absnowman_fall_1_1);

	var slam11 = makeEnemyAttackObj(obj_attack_absnowman_slam_1_1);
	var slam12 = makeEnemyAttackObj(obj_attack_absnowman_slam_1_2)

	var slam21 = makeEnemyAttackObj(obj_attack_absnowman_slam_2_1);

	var charge = makeEnemyAttackObj(obj_attack_absnowman_charge_1_1);
	var charge12 = makeEnemyAttackObj(obj_attack_absnowman_charge_1_2);

	var iceshooter = makeEnemyAttackObj(obj_attack_absnowman_iceshooter_1_1_melee);

	var c0 = [sb11, sb12, sb11];
	var c1 = [sb21, sb11, sb12];
	var c3 = [charge, charge12, charge12];
	// var c8 = [swing11, swing12, slam11];
	var c9 = [slam11, swing12, fallAttack, charge12];
	var c10 = [sb11, sb12, sb21];
	// var c12 = [swing21, iceshooter];
	var c14 = [swing11, swing12, swing21];
	var c15 = [iceshooter];
	meleeAttacks = [c0, c1, c3, c9, c10, c14, c15];
	// meleeAttacks = [c3];
	
	// currently chosen ranged attack
	var sb11r = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_1);
	var sb12r = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_2);
	var sb21r = makeEnemyAttackObj(obj_attack_absnowman_snowball_2_1);
	var iceshooter = makeEnemyAttackObj(obj_attack_absnowman_iceshooter_1_1);
	var charge_r = makeEnemyAttackObj(obj_attack_absnowman_charge_1_1);
	var charge12_r = makeEnemyAttackObj(obj_attack_absnowman_charge_1_2);
	var r3 = [charge_r];
	var r4 = [charge_r, charge12_r, charge12_r];

	var r0 = [sb11r, sb12r, sb11r];
	var r1 = [sb21r, sb11r];
	var r2 = [iceshooter];
	rangedAttacks = [r0, r1, r2, r3, r4];
	
}

if phaseChangeFrame >= 0 && phaseChangeFrame < phaseChangeFrameMax {
	phaseChangeFrame++;
} else if phaseChangeFrame >= phaseChangeFrameMax {
	phaseChangeFrame = noone;
}

// when phase is 1, spore particles
if phase == 1 && phaseChangeFrame < 0 {
	if layer >= global.player.layer {
		part_system_depth(sporeSystem, layer_get_depth(layer)+1);
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(sporeSystem,sporeEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(sporeSystem,sporeEmitter,sporeParticle, 3);
	}
	
	if layer >= global.player.layer {
		part_system_depth(rageSystem, layer_get_depth(layer)-1);
		var x1 = bbox_left - 15; var x2 = bbox_right + 15;
		var y1 = bbox_top - 15; var y2 = bbox_bottom + 15;
		part_emitter_region(rageSystem,rageEmitter,x1,x2,y1,y2,ps_shape_ellipse,ps_distr_gaussian);
		part_emitter_burst(rageSystem,rageEmitter,rageParticle, 7);
	}
}