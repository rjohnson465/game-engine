/// @description canSeeLockOnTarget
// returns true if there are no walls between lockOnTarget and invoking combatant instance
// find the best potential target if none exists and set it to lockOnTarget
var target = noone;
var wouldBeLockOnTarget = lockOnTarget;
if !instance_exists(lockOnTarget) || lockOnTarget == noone {
	var totalPossibilities = 0;
	with lockOnTargetType {
		totalPossibilities = instance_count;
	}
	for (var i = 0; i < totalPossibilities; i++) {	
		target = scr_find_nth_closest(x,y,lockOnTargetType,i);
		if target != noone {
			if target.layer == layer {
				var wallsBetweenTarget = scr_collision_line_list_layer(x,y,target.x,target.y,obj_wall_parent,true,true);
				
				// remove nocast walls from wallsBetweenTarget (we can see over those!)
				var wallsToRemove = ds_list_create();
				if wallsBetweenTarget != noone {
					for (var j = 0; j < ds_list_size(wallsBetweenTarget); j++) {
						var w = ds_list_find_value(wallsBetweenTarget, j);
						if (w.object_index == obj_wall_nocast_nointerrupt) {
							ds_list_add(wallsToRemove, w);
						}
					}
				}
				if ds_list_size(wallsToRemove) > 0 {
					for (var j = 0; j < ds_list_size(wallsToRemove); j++) {
						var w = ds_list_find_value(wallsToRemove, j);
						var index = ds_list_find_index(wallsBetweenTarget, w);
						if index >= 0 {
							ds_list_delete(wallsBetweenTarget, index);
						}
					}
				}
				ds_list_destroy(wallsToRemove); wallsToRemove = -1;
				if (wallsBetweenTarget != noone && ds_list_size(wallsBetweenTarget) == 0) {
					ds_list_destroy(wallsBetweenTarget); 
					wallsBetweenTarget = noone;
				}
				
				if wallsBetweenTarget == noone {
					// great, there's no walls between this target, but are we even kinda facing him?
					var dirToTarget = point_direction(x,y,target.x,target.y);
					var fov = onAlert ? sightAngleDelta*1.6 : sightAngleDelta;
					if angleBetween(facingDirection-fov,facingDirection+fov,dirToTarget) {
						if lockOnTarget != noone {
							lockOnTarget = target;
						} 
						wouldBeLockOnTarget = target;
					}
				}
				if wallsBetweenTarget != noone && ds_exists(wallsBetweenTarget, ds_type_list) {
					ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
				}
				break;
			}
		}
	}
}
if !instance_exists(wouldBeLockOnTarget) wouldBeLockOnTarget = noone;
if wouldBeLockOnTarget == noone return false;
if wouldBeLockOnTarget.visible == false return false;
if wouldBeLockOnTarget.layer != layer return false; // can't see boyos on layers that arent yours

var instance = id;
if argument_count == 1 {
	instance = argument[0];
}
var wallsBetweenTarget = script_execute(scr_collision_line_list_layer,instance.x,instance.y,wouldBeLockOnTarget.x,wouldBeLockOnTarget.y,obj_wall_parent,true,true);

// remove nocast walls from wallsBetweenTarget (we can see over those!)
var wallsToRemove = ds_list_create();
if wallsBetweenTarget != noone {
	for (var j = 0; j < ds_list_size(wallsBetweenTarget); j++) {
		var w = ds_list_find_value(wallsBetweenTarget, j);
		if (w.object_index == obj_wall_nocast_nointerrupt || object_is_ancestor(w.object_index, obj_wall_nocast_nointerrupt)) {
			ds_list_add(wallsToRemove, w);
		}
	}
}
if ds_list_size(wallsToRemove) > 0 {
	for (var j = 0; j < ds_list_size(wallsToRemove); j++) {
		var w = ds_list_find_value(wallsToRemove, j);
		var index = ds_list_find_index(wallsBetweenTarget, w);
		if index >= 0 {
			ds_list_delete(wallsBetweenTarget, index);
		}
	}
}
ds_list_destroy(wallsToRemove); wallsToRemove = -1;
if (wallsBetweenTarget != noone && ds_list_size(wallsBetweenTarget) == 0) {
	ds_list_destroy(wallsBetweenTarget); 
	wallsBetweenTarget = noone;
}

// also factor doors and enemy obstacles (if enemy)
var doorsBetweenTarget = scr_collision_line_list_layer(instance.x,instance.y,wouldBeLockOnTarget.x, wouldBeLockOnTarget.y, obj_door,1,1);



var enemyObstacles = noone;
if type == CombatantTypes.Enemy {
	enemyObstacles = scr_collision_line_list_layer(instance.x,instance.y,wouldBeLockOnTarget.x, wouldBeLockOnTarget.y, obj_enemy_blocker,1,1);
}
if wallsBetweenTarget == noone && doorsBetweenTarget == noone && enemyObstacles == noone && layer == wouldBeLockOnTarget.layer {
	return true;
} else {
	if wallsBetweenTarget != noone {
		ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
	}
	if doorsBetweenTarget != noone {
		ds_list_destroy(doorsBetweenTarget); doorsBetweenTarget = -1;
	}
	if enemyObstacles != noone {
		ds_list_destroy(enemyObstacles); enemyObstacles = -1;
	}
	return false;
}