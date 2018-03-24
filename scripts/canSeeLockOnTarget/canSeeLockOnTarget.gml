/// @description canSeeLockOnTarget

// returns true if there are no walls between lockOnTarget and invoking combatant instance

// find the best potential target if none exists and set it to lockOnTarget
var target = noone;
if lockOnTarget == noone {
	var totalPossibilities = 0;
	with lockOnTargetType {
		totalPossibilities = instance_count;
	}
	for (var i = 0; i < totalPossibilities; i++) {	
		target = scr_find_nth_closest(x,y,lockOnTargetType,i);
		if target != noone {
			if target.layer == layer{
				var wallsBetweenTarget = scr_collision_line_list_layer(x,y,target.x,target.y,obj_wall_parent,true,true);
				if wallsBetweenTarget == noone {
					lockOnTarget = target;
				}
				if wallsBetweenTarget != noone {
					ds_list_destroy(wallsBetweenTarget);
				}
				break;
			}
		}
	}
}

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
		ds_list_destroy(wallsBetweenTarget);
	}
	return false;
}