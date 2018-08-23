/// @description canSeeLockOnTarget
// returns true if there are no walls between lockOnTarget and invoking combatant instance

// find the best potential target if none exists and set it to lockOnTarget
var target = noone;
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
						lockOnTarget = target;
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
if !instance_exists(lockOnTarget) lockOnTarget = noone;
if lockOnTarget == noone return false;

var instance = id;
if argument_count == 1 {
	instance = argument[0];
}
var wallsBetweenTarget = script_execute(scr_collision_line_list_layer,instance.x,instance.y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
if wallsBetweenTarget == noone && layer == lockOnTarget.layer {
	return true;
} else {
	if wallsBetweenTarget != noone {
		ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
	}
	return false;
}