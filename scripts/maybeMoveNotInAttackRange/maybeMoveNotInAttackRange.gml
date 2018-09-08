if lockOnTarget == noone || (currentMeleeAttack == noone && currentRangedAttack == noone) {
	if maybeAggro() {
		return true;
	} else {
		substate = CombatantMoveSubstates.ReturningToPost;
		return true;
	}
	exit;
}
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
	(distance_to_object(lockOnTarget) > rangedRangeArray[currentRangedAttack]) 
		|| wallsBetweenTarget != noone || alliesBetweenTarget != noone || enemyObstaclesBetweenTarget != noone || (layer != lockOnTarget.layer) || !canSeeLockOnTarget() : 
	(distance_to_object(lockOnTarget) > meleeRangeArray[currentMeleeAttack]) || (layer != lockOnTarget.layer) || !canSeeLockOnTarget();

if wallsBetweenTarget != noone && ds_exists(wallsBetweenTarget, ds_type_list) {
	ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
}
if alliesBetweenTarget != noone && ds_exists(alliesBetweenTarget, ds_type_list) {
	ds_list_destroy(alliesBetweenTarget); alliesBetweenTarget = -1;
}
if enemyObstaclesBetweenTarget != noone && ds_exists(enemyObstaclesBetweenTarget, ds_type_list) {
	ds_list_destroy(enemyObstaclesBetweenTarget); enemyObstaclesBetweenTarget = -1;
}

if pred && !isFlinching {
	// first, check if can't see lockOnTarget anymore
	// if so, initiate a path (ONCE) that will update every 15 frames with a new point (where the lockOnTarget is) 
	if layer == lockOnTarget.layer && !canSeeLockOnTarget() {
		if distance_to_point(tempTargetX,tempTargetY) < 10 && ds_list_size(guessPathPts) > 0 {
			
			var pt = ds_list_find_value(guessPathPts,0);
			tempTargetX = pt[0]; tempTargetY = pt[1];
			ds_list_delete(guessPathPts,0);
		}
		if tempTargetX == noone {
			alarm[7] = 15;
			tempTargetX = lockOnTarget.x; tempTargetY = lockOnTarget.y;
		}
		populatePersonalGrid();
		var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,tempTargetX,tempTargetY,true);
		if isGridPathAvailable {
			var xx = path_get_x(gridPath,.1);
			var yy = path_get_y(gridPath,.1);
			mp_potential_path(path,xx,yy,functionalSpeed,1,0);
			path_start(path,functionalSpeed,path_action_stop,false);
		} else if mp_potential_path(path,tempTargetX,tempTargetY,normalSpeed,4,false) {
			mp_potential_path(path,tempTargetX,tempTargetY,normalSpeed,4,false);
			path_start(path,functionalSpeed,path_action_stop,false);
		}
		return true; 
	} else if layer == lockOnTarget.layer && canSeeLockOnTarget() && alarm[7] > -1 {
		alarm[7] = -1;
		ds_list_clear(guessPathPts);
	}
	tempTargetX = noone; tempTargetY = noone;
	// Movement for AI combatants not in attack range
	if layer == lockOnTarget.layer && mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,.5,false) {
		mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,.5,false);
		path_start(path,functionalSpeed,path_action_stop,false);
	}
	// if can't find potential path directly to player, find grid path to player and potential path steps on it
	else 
	if layer == lockOnTarget.layer {
		populatePersonalGrid();
		var isGridPathAvailable = mp_grid_path(personalGrid,gridPath,x,y,lockOnTarget.x,lockOnTarget.y,true);
		if isGridPathAvailable {
			var xx = path_get_x(gridPath,.1);
			var yy = path_get_y(gridPath,.1);
			mp_potential_path(path,xx,yy,functionalSpeed,1,0);
			path_start(path,functionalSpeed,path_action_stop,false);
		} else if mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,4,false) {
			mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,4,false);
			path_start(path,functionalSpeed,path_action_stop,false);
		}
		else {
			if postZ == layer {
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
		}
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
// do not enter Attack / Move In Attack Range state if we can't even see our target
if !canSeeLockOnTarget() return true;
return false;