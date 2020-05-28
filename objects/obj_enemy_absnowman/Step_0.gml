if phaseChangeFrame < 0 {
	event_inherited();
}

if hp < (.5*maxHp) && phase == 0 && state != CombatantStates.Attacking {

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

	var iceblade = makeEnemyAttackObj(obj_attack_absnowman_iceblade_1_1);
	var iceshooter = makeEnemyAttackObj(obj_attack_absnowman_iceshooter_1_1_melee);

	var c0 = [sb11, sb12, sb11];
	var c1 = [sb21, sb11, sb12];
	var c3 = [charge, charge12, charge12];
	var c8 = [swing11, swing12, slam11];
	var c9 = [slam11, swing12, fallAttack];
	var c10 = [sb11, sb12, sb21];
	var c11 = [sb21, fallAttack, charge12];
	var c12 = [swing21, iceshooter];
	var c13 = [iceblade, swing21];
	var c4 = [iceblade, iceblade];
	var c14 = [swing11, swing12, swing21];
	var c15 = [iceshooter];
	meleeAttacks = [c0, c1, c3, c8, c9, c10, c11, c12, c13, c14, c15];
	
	// currently chosen ranged attack
	var sb11r = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_1);
	var sb12r = makeEnemyAttackObj(obj_attack_absnowman_snowball_1_2);
	var sb21r = makeEnemyAttackObj(obj_attack_absnowman_snowball_2_1);
	var iceshooter = makeEnemyAttackObj(obj_attack_absnowman_iceshooter_1_1);

	var r0 = [sb11r, sb12r, sb11r];
	var r1 = [sb21r, sb11r];
	var r2 = [iceshooter];
	rangedAttacks = [r0, r1, r2];
	
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
}