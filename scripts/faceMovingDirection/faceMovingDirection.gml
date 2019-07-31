// faceMovingDirection()

// either face the lockOnTarget if in sight, or face the direction you're moving

//var ppx = path_get_x(path,path_positionprevious); var ppy = path_get_y(path,path_positionprevious);
//var px = path_get_x(path,path_position); var py = path_get_y(path, path_position);

var pathNextX = path_get_x(path_index,path_position+.01);
var pathNextY = path_get_y(path_index,path_position+.01);


if lockOnTarget != noone && substate != CombatantMoveSubstates.ReturningToPost {
	var wallsBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
	
	var includesActualWall = false;
	if ds_exists(wallsBetweenTarget, ds_type_list) {
		for (var i = 0; i < ds_list_size(wallsBetweenTarget); i++) {
			var w = ds_list_find_value(wallsBetweenTarget, i);
			if w.object_index != obj_wall_nocast_nointerrupt {
				includesActualWall = true;
			}
		}
	}
	
	if wallsBetweenTarget == noone || !includesActualWall {
		turnToFacePoint(turnSpeed,lockOnTarget.x,lockOnTarget.y);
	} else {
		
		if path_position < .9 {
			
			
			var tx = x + lengthdir_x(5, direction);
			var ty = y + lengthdir_y(5, direction);
			 turnToFacePoint(turnSpeed,tx,ty); 
			 
			
			/*
			functionalSpeed = normalSpeed*slowedSpeedModifier;
			facingDirection = direction;
			*/
		}
		// 
		 
		// turnToFacePoint(turnSpeed,pathNextX,pathNextY);
	}
	if wallsBetweenTarget != noone {
		ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
	}
} else {
	// turnToFacePoint(turnSpeed,pathNextX,pathNextY);
	
	functionalSpeed = normalSpeed*slowedSpeedModifier;
	facingDirection = direction; ///???
}