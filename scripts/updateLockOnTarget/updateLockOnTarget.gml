// lock on target logic

if global.isWishing exit;
var origTarget = lockOnTarget;
var lockOnInputReceived = keyboard_check_released(vk_control);
var lockOnInputChangeReceived = keyboard_check_released(vk_tab);
if gamepad_is_connected(gamePadIndex) {
	lockOnInputReceived = keyboard_check_released(vk_control)
	|| (gamepad_button_check_released(gamePadIndex,gp_stickr) && !isLockedOn);
}

if lockOnInputReceived || lockOnInputChangeReceived {
	// always refresh lockOnList (enemies could have left radius or entered
	lockOnList = scr_collision_circle_list_layer(x,y,LOCK_ON_DISTANCE,obj_enemy_parent, true, true);
	if (lockOnList == noone) {
		lockOnTarget = noone;
		isLockedOn = false;
	}
	// if already locked on, only look through enemies not yet locked onto, and only if we pressed tab
	if (isLockedOn) {
		if !lockOnInputChangeReceived {
			lockOnTarget = noone; isLockedOn = false; exit;
		}
		var closestInstance = noone;
		var foundClosest = false; var i = 1;
		while !foundClosest && i <= ds_list_size(lockOnList) {
			closestInstance = scr_find_nth_closest_layer(x,y,obj_enemy_parent, i);
			if ds_list_find_index(lockOnListSeen, closestInstance) == -1 {
				foundClosest = true;
			} else {
				closestInstance = noone;
				i++;
			}
		}
		if closestInstance != noone {
			lockOnTarget = closestInstance;
			ds_list_add(lockOnListSeen, closestInstance);
		} else {
			// we've cycled through all targets; begin cycle again
			ds_list_clear(lockOnListSeen);
			var closestInstance = scr_find_nth_closest(x,y,obj_enemy_parent, 1);
			if closestInstance != noone {
				lockOnTarget = closestInstance;
				isLockedOn = true;
				ds_list_add(lockOnListSeen, closestInstance);
			}
		}
	}
	// if not locked on just get the nearest enemy in the list 
	else if (lockOnList != noone){
		var closestInstance = scr_find_nth_closest_layer(x,y,obj_enemy_parent, 1);
		// var closestInstance = ds_list_find_value(lockOnList, 0);
		if closestInstance != noone && closestInstance != undefined {
			lockOnTarget = closestInstance;
			isLockedOn = true;
			ds_list_add(lockOnListSeen, closestInstance);
		}
	}
}
var wallsBetweenLockOnTarget = noone;
var doorsBetweenLockOnTarget = noone;
if lockOnTarget {
	wallsBetweenLockOnTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
	doorsBetweenLockOnTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_door,true,true);
}
// filter out no interrupt walls
var garbageIndices = ds_list_create();
if ds_exists(wallsBetweenLockOnTarget, ds_type_list) {
	for (var i = 0; i < ds_list_size(wallsBetweenLockOnTarget); i++) {
		var w = ds_list_find_value(wallsBetweenLockOnTarget, i);
		if w.object_index == obj_wall_nocast_nointerrupt || object_is_ancestor(w.object_index, obj_wall_nocast_nointerrupt) {
			ds_list_add(garbageIndices, i);
		}
	}
}
for (var i = 0; i < ds_list_size(garbageIndices); i++) {
	var index = ds_list_find_value(garbageIndices, i);
	ds_list_delete(wallsBetweenLockOnTarget, index);
	if ds_list_size(wallsBetweenLockOnTarget) == 0 {
		ds_list_destroy(wallsBetweenLockOnTarget);
		wallsBetweenLockOnTarget = noone;
	}
}
ds_list_destroy(garbageIndices);
// if too far from current lockon target, or esc pressed, or cannot see lockOnTarget no more lock on
var cancelLockOnInputReceived = keyboard_check(vk_escape);
if gamepad_is_connected(gamePadIndex) {
	cancelLockOnInputReceived = keyboard_check(vk_escape) ||
	(gamepad_button_check_released(gamePadIndex,gp_stickr) && !lockOnInputReceived);
}
if	isLockedOn && ((cancelLockOnInputReceived && !global.ui.isShowingMenus) 
	|| distance_to_object(lockOnTarget) > LOCK_ON_DISTANCE
	|| wallsBetweenLockOnTarget != noone 
	|| lockOnTarget.layer != layer) {
	lockOnTarget = noone;
	isLockedOn = false;
}
if wallsBetweenLockOnTarget != noone {
	ds_list_destroy(wallsBetweenLockOnTarget); wallsBetweenLockOnTarget = -1;
}

// lockOnTarget switching with a controller
if isLockedOn && gamepad_is_connected(gamePadIndex) {
	var h_point = gamepad_axis_value(gamePadIndex, gp_axisrh);
	var v_point = gamepad_axis_value(gamePadIndex, gp_axisrv);
	if ((h_point != 0) || (v_point != 0)) {
		var pdir = point_direction(0, 0, h_point, v_point);
		
		// find all enemies in a given radius 
		var possibleTargets = scr_get_ids_region(lockOnTargetType,x-500,y-500,x+500,y+500);
		
		// pick target that is in sight and closest to pdir (angle-wise, not distance-wise)
		var closestAngleDiff = 180;
		for (var i = 0; i < ds_list_size(possibleTargets); i++) {
			var el = ds_list_find_value(possibleTargets,i);
			if el.layer != layer continue;
			var ang = point_direction(lockOnTarget.x,lockOnTarget.y,el.x,el.y);
			var diff = abs(angle_difference(pdir,ang));
			
			var wallsBetweenLockOnTarget = script_execute(scr_collision_line_list_layer,x,y,el.x,el.y,obj_wall_parent,true,true);
			if diff < closestAngleDiff && diff < 90 && wallsBetweenLockOnTarget == noone && doorsBetweenLockOnTarget == noone {
				lockOnTarget = el;
			}
			if wallsBetweenLockOnTarget != noone {
				ds_list_destroy(wallsBetweenLockOnTarget); wallsBetweenLockOnTarget = -1;
			}
		}
		if possibleTargets != noone {
			ds_list_destroy(possibleTargets); possibleTargets = -1;
		}
	}
}

// update the lockOnTarget description with a random one of its possible descriptions
if lockOnTarget != noone && instance_exists(lockOnTarget) && lockOnTarget != origTarget {
	with lockOnTarget {
		randomize();
		var rand = round(random_range(0,array_length_1d(descriptionChoices)-1));
		description = descriptionChoices[rand];
	}
}