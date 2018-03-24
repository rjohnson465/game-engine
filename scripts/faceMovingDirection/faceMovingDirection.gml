// either face the lockOnTarget if in sight, or face the direction you're moving
var pathNextX = path_get_point_x(path,2);
var pathNextY = path_get_point_y(path,2);
var pDir = point_direction(x,y,pathNextX,pathNextY);
if lockOnTarget != noone {
	var wallsBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
	if wallsBetweenTarget == noone {
		turnToFacePoint(turnSpeed,lockOnTarget.x,lockOnTarget.y);
	} else {
		facingDirection = direction;
	}
	if wallsBetweenTarget != noone {
		ds_list_destroy(wallsBetweenTarget);
	}
} else {
	facingDirection = direction;
}