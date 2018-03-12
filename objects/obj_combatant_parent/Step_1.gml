if type == CombatantTypes.Player exit;
// death
if hp < 1 && isAlive && !isDying {
	isDying = true;
	hp = 0;
	speed = 0;
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
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}
}

if isDying && isAlive {
	if dyingFrame < dyingTotalFrames {
		speed = 0;
		dyingFrame++;
	} else {
		dyingFrame = 0;
		isAlive = false;
		isDying = false;
		global.player.xp += xpReward;
	}
}

if !isAlive {
	speed = 0;
	if type == CombatantTypes.Enemy {
		showHp = false;
		isShowingLightRadius = false;
		lightRadiusColor = c_white;
				
		enemyData.hp = 0;
		enemyData.isAlive = false;
				
		var idd = id;
		with obj_light_radius {
			if owner == idd {
				x = -1000;
				y = -1000;
			}
		}
	}
	x = -1000;
	y = -1000;
}
