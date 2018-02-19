if type == CombatantTypes.Player exit;
// death
if hp < 1 && isAlive {
	isDying = true;
	hp = 0;
	speed = 0;
	// cure any and all conditions
	var currentCondition = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
		ds_map_replace(conditionPercentages,currentCondition,0);
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}
	preparingLimbs = ds_map_create();
	attackingLimbs = ds_map_create();
	recoveringLimbs = ds_map_create();
	jumpFrame = 8;
	// create death particles
	global.owner = id;
	global.condition = "Death";
	instance_create_depth(x,y,1,obj_condition_particles);
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
	if type == CombatantTypes.Enemy {
		showHp = false;
		isShowingLightRadius = false;
		lightRadiusColor = c_white;
		//global.owner = id;
		//instance_create_depth(x,y,1,obj_enemy_dead);
		
		//x = -1000;
		//y = -1000;
				
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



if !canSeePlayer(id) && state == CombatantStates.Idle {
	visible = false;
} else visible = true;