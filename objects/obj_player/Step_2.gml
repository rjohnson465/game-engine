event_inherited();

// death
if hp < 1 && isAlive && !isDying {
	isDying = true;
	fallFrame = fallTotalFrames;
	fallScaleFactor = 1;
	hp = 0;
	speed = 0;
	flinchFrame = 0;
	ds_map_clear(preparingLimbs);
	ds_map_clear(attackingLimbs);
	ds_map_clear(recoveringLimbs);
	// create death particles
	global.owner = id;
	randomize();
	var rand = random_range(0,100);
	if ds_map_find_value(conditionPercentages,ICE) > 50 && (rand > 60) {
		global.condition = "IceDeath";
		dyingFrame = dyingTotalFrames;
	} else {
		global.condition = "Death";
	}
	instance_create_depth(x,y,1,obj_condition_particles);
	state = CombatantStates.Idle;
	// cure any and all conditions
	var currentCondition = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
		ds_map_replace(conditionPercentages,currentCondition,0);
		ds_map_replace(conditionLevels,currentCondition,0);
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}
	global.ui.isShowingMenus = false;
	lockOnTarget = noone;
}

if isDying && isAlive {
	if dyingFrame < dyingTotalFrames {
		speed = 0;
		dyingFrame++;
	} else {
		dyingFrame = 0;
		isAlive = false;
		isDying = false;
		instance_create_depth(x,y,1,obj_player_death);
	}
}

if !isAlive {
	speed = 0;
	alpha = 0;
	visible = false;
}
