// death
if hp < 1 && isAlive {
	show_debug_message("heelloo");
	isAlive = false;
	speed = 0;
	// cure any and all conditions
	var currentCondition = ds_map_find_first(conditionPercentages);
	for (var i = 0; i < ds_map_size(conditionPercentages);i++) {
		ds_map_replace(conditionPercentages,currentCondition,0);
		currentCondition = ds_map_find_next(conditionPercentages, currentCondition);
	}
	
	if type == CombatantTypes.Enemy {
		showHp = false;
		isShowingLightRadius = false;
		lightRadiusColor = c_white;
		global.owner = id;
		instance_create_depth(x,y,1,obj_enemy_dead);
		
		x = -1000;
		y = -1000;
				
		enemyData.hp = 0;
				
		var idd = id;
		with obj_light_radius {
			if owner == idd {
				x = -1000;
				y = -1000;
			}
		}
	}
}

if !isAlive {
	x = -1000;
	y = -1000;
}



if !canSeePlayer(id) && state == CombatantStates.Idle {
	visible = false;
} else visible = true;