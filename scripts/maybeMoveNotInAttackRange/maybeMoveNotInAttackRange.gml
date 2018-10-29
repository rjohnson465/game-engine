if lockOnTarget == noone || (currentMeleeAttack == noone && currentRangedAttack == noone) {
	if maybeAggro() {
		return true;
	} else {
		path_end(); lockOnTarget = noone;
		substate = CombatantMoveSubstates.ReturningToPost;
		return true;
	}
	exit;
}
// move to lockOnTarget until in range for chosen attack
var wallsBetweenTarget = script_execute(scr_collision_line_list_layer,x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
//var allyType = object_is_ancestor(object_index,obj_enemy_parent) ? obj_enemy_parent : obj_goodguy_parent;
//var alliesBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,allyType,true,true);
var fallzonesBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_fallzone,true,true);
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
	if ds_list_size(enemyObstaclesBetweenTarget) == 0 {
		ds_list_destroy(enemyObstaclesBetweenTarget); enemyObstaclesBetweenTarget = -1;
	}
}


// if predicate is true, you need to keep moving
var pred = currentMeleeAttack == noone ? 
	// predicate for ranged attacks -- check that we're in range and there are no walls between us and target
	(array_length_1d(rangedAttacks) > 0 && distance_to_object(lockOnTarget) > getRangeForAttackIndex(currentRangedAttack,false)) 
		|| wallsBetweenTarget != noone /*|| alliesBetweenTarget != noone*/ || enemyObstaclesBetweenTarget >= 0 || (layer != lockOnTarget.layer) || !canSeeLockOnTarget() : 
	((array_length_1d(meleeAttacks) > 0 && distance_to_object(lockOnTarget) > getRangeForAttackIndex(currentMeleeAttack, true)) || fallzonesBetweenTarget != noone ) 
	|| (layer != lockOnTarget.layer) || !canSeeLockOnTarget();

if currentMeleeAttack == noone && array_length_1d(rangedAttacks) == 0 pred = true; // if we have no possible ranged attack and no melee attack chose, you have to get closer!

if wallsBetweenTarget != noone && ds_exists(wallsBetweenTarget, ds_type_list) {
	ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
}
if fallzonesBetweenTarget != noone && ds_exists(fallzonesBetweenTarget, ds_type_list) {
	ds_list_destroy(fallzonesBetweenTarget); fallzonesBetweenTarget = -1;
}
if enemyObstaclesBetweenTarget != noone && ds_exists(enemyObstaclesBetweenTarget, ds_type_list) {
	ds_list_destroy(enemyObstaclesBetweenTarget); enemyObstaclesBetweenTarget = -1;
}

var shouldRecalc = alarm[9] == 0 || path_index == -1;

if pred && !isFlinching {
	/*
	if distance_to_object(lockOnTarget) > 75 && currentMeleeAttack != noone {
		attackFrequencyFrame = 0;
	}*/
	// remember how long its been since last attack, even if not in range
	// this way player must deal with an attack every x frames (approx), not just every x frames
	// enemy is in range (which they could cheese easily by breaking range regularly)
	if attackFrequencyFrame < 0 {
		randomize();
		var isRanged = currentMeleeAttack == noone ? true : false;
		if isRanged {
			attackFrequencyFrame = round(random_range(attackFrequencyTotalFramesRanged[0],attackFrequencyTotalFramesRanged[1]));
		} else {
			attackFrequencyFrame = round(random_range(attackFrequencyTotalFramesMelee[0],attackFrequencyTotalFramesMelee[1]));
		}
	}
	if attackFrequencyFrame > 1 {
		attackFrequencyFrame--;
	}
	
	// first, check if can't see lockOnTarget anymore
	// if so, initiate a path (ONCE) that will update every 15 frames with a new point (where the lockOnTarget is) 
	if layer == lockOnTarget.layer && !canSeeLockOnTarget() {
		calcPathToUnseenTarget();
		return true; 
	} else if layer == lockOnTarget.layer && canSeeLockOnTarget() && alarm[7] > -1 {
		alarm[7] = -1;
		ds_list_clear(guessPathPts);
	}
	
	tempTargetX = noone; tempTargetY = noone; turnSpeed = normalTurnSpeed;
	// Movement for AI combatants not in attack range
	if layer == lockOnTarget.layer && mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,.5,false) {
		mp_potential_path(path,lockOnTarget.x,lockOnTarget.y,normalSpeed,.5,false);
		path_start(path,functionalSpeed,path_action_stop,false);
	}
	
	// if can't find potential path directly to player, find grid path to player and potential path steps on it
	else if layer == lockOnTarget.layer {
		calcPathToSeenTarget();
		return true;
	} // end canSeeLockOnTarget / chase routine
	
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
	
	// not on post layer, not on lockOnTarget layer, return to tempPost
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
if !pred return false;