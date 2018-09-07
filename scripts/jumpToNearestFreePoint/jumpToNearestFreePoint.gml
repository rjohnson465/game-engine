/// jumpToNearestFreePoint(*isEnemy, *minDir, *maxDir, *factor)
/// @param *isEnemy
/// @param *minDir
/// @param *maxDir
/// @param *factor

var isEnemy = false;
var minDir = 0;
var maxDir = 360;
var factor = 10;
if argument_count > 0 {
	isEnemy = argument[0];
}
if argument_count > 1 minDir = argument[1];
if argument_count > 2 maxDir = argument[2];
if argument_count > 3 factor = argument[3];


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

var distanceToTry = factor;
var dir = minDir;
// try going distanceToTry pixels out from current place at direction dir
// until the proposed x/y coordinates would not make a collision with an obstacle
var xx = x;
var yy = y;
var obstaclesInside = place_meeting_list(xx,yy,obstacles); // this is a boolean, NOT a list!
while obstaclesInside {
	dir = (dir + 10)%360;
	xx = x+lengthdir_x(distanceToTry,dir);
	yy = y+lengthdir_y(distanceToTry,dir);
	if dir >= maxDir || (dir == 0 && maxDir == 360) {
		distanceToTry += factor;
		dir = minDir;
	}
	obstaclesInside = place_meeting_list(xx,yy,obstacles);
}
var _dist = point_distance(x,y,xx,yy);
if _dist > 25 {
	var _a = 3;
}
x = xx;
y = yy;
ds_list_destroy(obstacles); obstacles = -1;
//ds_list_destroy(obstaclesInside); obstaclesInside = -1;