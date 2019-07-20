event_inherited();

summonFrame -= 1;

if summonFrame <= 0 && state != "Eat" {
	// if there are already minions do not summon
	var rbmAlive = false;
	with obj_enemy_ravebot_minion {
		if isAlive {
			rbmAlive = true;
		}
	}
	if rbmAlive {
		randomize()
		summonFrame = random_range(SUMMON_FREQ_MIN, SUMMON_FREQ_MAX);
		exit;
	}
	if state == CombatantStates.Moving || state == CombatantStates.Idle {
		state = "Eat"; // placeholder unique state
		sprite_index = spr_enemy_ravebot_summon;
	}
}

if state == "Eat" {
	part_emitter_region(summonPartSystem, summonPartEmitter, x-50, x+50, y-50, y+50, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(summonPartSystem, summonPartEmitter, summonParticle1, 6);
	part_emitter_burst(summonPartSystem, summonPartEmitter, summonParticle2, 6);
	
	turnToFacePoint(turnSpeed, global.player.x, global.player.y);
	
	// can be staggered out
}