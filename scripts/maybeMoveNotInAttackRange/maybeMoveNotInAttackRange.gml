// move to lockOnTarget until in range for chosen attack
var wallsBetweenTarget = script_execute(scr_collision_line_list_layer,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
var allyType = object_is_ancestor(object_index,obj_enemy_parent) ? obj_enemy_parent : obj_goodguy_parent;
var alliesBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,allyType,true,true);
var enemyObstaclesBetweenTarget = noone; 
if type == CombatantTypes.Enemy {
	enemyObstaclesBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_enemy_obstacle_parent,true,true);
}

if enemyObstaclesBetweenTarget != noone {
	for (var i = 0; i < ds_list_size(enemyObstaclesBetweenTarget); i++) {
		var el = ds_list_find_value(enemyObstaclesBetweenTarget,i);
		// enemies, feel free to not consider your targets "obstacles" you dolts
		if object_is_ancestor(el.object_index,obj_goodguy_parent) {
			ds_list_delete(enemyObstaclesBetweenTarget,i);
		}
	}
	if ds_list_size(enemyObstaclesBetweenTarget) == 0 enemyObstaclesBetweenTarget = noone;
}


// if predicate is true, you need to keep moving
var pred = currentMeleeAttack == noone ? 
	// predicate for ranged attacks -- check that we're in range and there are no walls between us and target
	(distance_to_object(lockOnTarget) > rangedRangeArray[currentRangedAttack-1]) 
		|| wallsBetweenTarget != noone || alliesBetweenTarget != noone || enemyObstaclesBetweenTarget != noone || (layer != lockOnTarget.layer) : 
	(distance_to_object(lockOnTarget) > meleeRangeArray[currentMeleeAttack-1]) || (layer != lockOnTarget.layer);
				
if pred && !isFlinching {
	// Movement for AI combatants not in attack range
	if layer == lockOnTarget.layer && mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,10,false) {
		mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,10,false);
		path_start(path,functionalSpeed,path_action_stop,false);
	} 
	// return to post if no path to target can be found
	else if postZ == layer {
		var a = mp_grid_path(personalGrid,path,x,y,postX,postY,0);
		if a {
			path_start(path,functionalSpeed,path_action_stop,false);
			currentMeleeAttack = noone;
			currentRangedAttack = noone;
			lockOnTarget = noone;
		}
	}
	// not on post layer, not on lockOnTarget layer
	else {
		if mp_grid_path(personalGrid,path,x,y,tempPostX,tempPostY,0) {
			path_start(path,functionalSpeed,path_action_stop,false);
			currentMeleeAttack = noone;
			currentRangedAttack = noone;
			lockOnTarget = noone;
		}
	}
	return true;
}
return false;