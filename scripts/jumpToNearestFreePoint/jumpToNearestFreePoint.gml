/// jumpToNearestFreePoint(*isEnemy, *includesFallzones, *distance)
/// @param *isEnemy
/// @param *includesFallzones
/// @param *distance -- if this is specified, just nudge the instance this much in the direction of the nearest free point

var isEnemy = false;
if argument_count > 0 {
	isEnemy = argument[0];
}

var obstacleType = obj_solid_parent;
if isEnemy {
	obstacleType = obj_enemy_obstacle_parent;
}

// get all obstacles to avoid
var obstacles = ds_list_create();
with obstacleType {
	var l = layer;
	if object_is_ancestor(object_index, obj_solid_environment) l = origLayer;
	if l == other.layer && id != other {
		ds_list_add(obstacles,id);
	}
}
// also avoid fallzones
var includesFallzones = false;
if argument_count > 1 {
	includesFallzones = argument[1];
}
if includesFallzones {
	with obj_fallzone {
		if layer == other.layer && id != other {
			ds_list_add(obstacles,id);
		}
	}
}

var dis = noone;
if argument_count > 2 {
	dis = argument[2];
}

var distanceToTry = 10;
var dir = 10;
// try going distanceToTry pixels out from current place at direction dir
// until the proposed x/y coordinates would not make a collision with an obstacle
var xx = x;
var yy = y;
var obstaclesInside = place_meeting_list(xx,yy,obstacles); // this is a boolean, NOT a list!
while obstaclesInside {
	dir = (dir + 10)%360;
	xx = x+lengthdir_x(distanceToTry,dir);
	yy = y+lengthdir_y(distanceToTry,dir);
	if dir == 0 {
		distanceToTry += 10;
	}
	obstaclesInside = place_meeting_list(xx,yy,obstacles);
}

// if distance is specified, just nudge instance dis px in direction of nearest free point
if dis != noone {
	xx = x+lengthdir_x(dis,dir);
	yy = y+lengthdir_y(dis,dir);
}

x = xx;
y = yy;
ds_list_destroy(obstacles); obstacles = -1;
//ds_list_destroy(obstaclesInside); obstaclesInside = -1;