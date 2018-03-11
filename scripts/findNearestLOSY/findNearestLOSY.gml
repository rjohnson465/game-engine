/// findNearestLOSY()

/// for enemies using range who don't have a clean shot
/// move to the nearest free point that has a clean LOS to lockOnTarget

// get all obstacles to avoid
var obstacles = ds_list_create();
with obj_enemy_obstacle_parent {
	if layer == other.layer {
		ds_list_add(obstacles,id);
	}
}

var distanceToTry = 10;
var dir = 10;
// try going distanceToTry pixels out from current place at direction dir
// until the proposed x/y coordinates would not make a collision with an obstacle
var xx = x;
var yy = y;
while place_meeting_list(xx,yy,obstacles) || scr_collision_line_list_layer(xx,yy,lockOnTarget.x,lockOnTarget.y,obj_enemy_obstacle_parent,true,true) != noone {
	dir = (dir + 10)%360;
	xx = x+lengthdir_x(distanceToTry,dir);
	yy = y+lengthdir_y(distanceToTry,dir);
	if dir == 0 {
		distanceToTry += 10;
	}
	if distanceToTry > 200 {
		return noone;
	}
}
return yy;
ds_list_destroy(obstacles);