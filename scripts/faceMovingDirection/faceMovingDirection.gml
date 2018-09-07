// either face the lockOnTarget if in sight, or face the direction you're moving
movingDir = point_direction(prevX,prevY,x,y);
var mx = x+lengthdir_x(10,movingDir); var my = y+lengthdir_y(10,movingDir);
if (prevX == x && prevY == y && lockOnTarget == noone) exit;
if lockOnTarget != noone {
	var wallsBetweenTarget = scr_collision_line_list_layer(x,y,lockOnTarget.x,lockOnTarget.y,obj_wall_parent,true,true);
	if wallsBetweenTarget == noone {
		turnToFacePoint(turnSpeed,lockOnTarget.x,lockOnTarget.y);
	} else {
		turnToFacePoint(turnSpeed,mx,my);
	}
	if wallsBetweenTarget != noone {
		ds_list_destroy(wallsBetweenTarget); wallsBetweenTarget = -1;
	}
} else {
	turnToFacePoint(turnSpeed,mx,my);
}