/// @description canSeeLockOnTarget
// returns true if there are no walls between lockOnTarget and invoking combatant instance

// find the best potential target if none exists and set it to lockOnTarget
var target = noone;
var wouldBeLockOnTarget = lockOnTarget;
if !instance_exists(lockOnTarget) || lockOnTarget == noone || lockOnTarget.object_index == obj_temp_lockontarget {
	var totalPossibilities = 0;
	with lockOnTargetType {
		totalPossibilities = instance_count;
	}
	for (var i = 0; i < totalPossibilities; i++) {	
		target = scr_find_nth_closest(x,y,lockOnTargetType,i);
		if target != noone {
			if target.layer == layer {
				var wallsBetweenTarget = scr_collision_line_list_layer(x,y,target.x,target.y,obj_wall_parent,true,true);
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
				if wallsBetweenTarget != noone {
					ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
				}
				break;
			}
		}
	}
}
if !instance_exists(wouldBeLockOnTarget) wouldBeLockOnTarget = noone;
if wouldBeLockOnTarget == noone return false;
var _l1 = wouldBeLockOnTarget.layer;
var _l2 = layer;
if lockOnTarget != noone {
	var _l3 = lockOnTarget.layer;
}
if wouldBeLockOnTarget.layer != layer return false; // can't see boyos on layers that arent yours

var instance = id;
if argument_count == 1 {
	instance = argument[0];
}
var wallsBetweenTarget = script_execute(scr_collision_line_list_layer,instance.x,instance.y,wouldBeLockOnTarget.x,wouldBeLockOnTarget.y,obj_wall_parent,true,true);
// also factor doors and enemy obstacles (if enemy)
var doorsBetweenTarget = scr_collision_line_list_layer(instance.x,instance.y,wouldBeLockOnTarget.x, wouldBeLockOnTarget.y, obj_door,1,1);
var enemyObstacles = noone;
if type == CombatantTypes.Enemy enemyObstacles = scr_collision_line_list_layer(instance.x,instance.y,wouldBeLockOnTarget.x, wouldBeLockOnTarget.y, obj_enemy_blocker,1,1);
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