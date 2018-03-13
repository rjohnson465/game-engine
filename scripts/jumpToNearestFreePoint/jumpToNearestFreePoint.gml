/// jumpToNearestFreePoint(*isEnemy)
/// @param *isEnemy

var isEnemy = false;
if argument_count == 1 {
	isEnemy = argument[0];
}

var obstacleType = obj_solid_parent;
if isEnemy {
	obstacleType = obj_enemy_obstacle_parent;
}

// get all obstacles to avoid
var obstacles = ds_list_create();
with obstacleType {
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
while place_meeting_list(xx,yy,obstacles) {
	dir = (dir + 10)%360;
	xx = x+lengthdir_x(distanceToTry,dir);
	yy = y+lengthdir_y(distanceToTry,dir);
	if dir == 0 {
		distanceToTry += 10;
	}
}
x = xx;
y = yy;
ds_list_destroy(obstacles);