// faceMovingDirection()

// either face the lockOnTarget if in sight, or face the direction you're moving

//var ppx = path_get_x(path,path_positionprevious); var ppy = path_get_y(path,path_positionprevious);
//var px = path_get_x(path,path_position); var py = path_get_y(path, path_position);

var pathNextX = path_get_x(path_index,path_position+.01);
var pathNextY = path_get_y(path_index,path_position+.01);
var pDir = point_direction(x,y,pathNextX,pathNextY);
if lockOnTarget != noone && substate != CombatantMoveSubstates.ReturningToPost {
	var wallsBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
	if wallsBetweenTarget == noone {
		turnToFacePoint(turnSpeed,lockOnTarget.x,lockOnTarget.y);
	} else {
		//facingDirection = direction;
		turnToFacePoint(turnSpeed,pathNextX,pathNextY);
	}
	if wallsBetweenTarget != noone {
		ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
	}
} else {
	turnToFacePoint(turnSpeed,pathNextX,pathNextY);
}