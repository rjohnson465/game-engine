/// moveToNearestFreePoint(direction,speed,*isEnemy)
/// @param direction
/// @param speed
/// @param *isEnemy

/// returns true if the instance can move in that general direction

var d = argument[0];
var sp = argument[1];
var isEnemy = false;
if argument_count == 3 {
	isEnemy = argument[2];
}

d = d mod 360;

var objectsToAvoid = obj_solid_parent;
//var additionalObjects = ds_list_create();
if isEnemy objectsToAvoid = obj_enemy_obstacle_parent;

var oldX = x;
var oldY = y;

if !place_meeting_layer(x+lengthdir_x(sp,d),y+lengthdir_y(sp,d),objectsToAvoid) {
	x = x+lengthdir_x(sp,d); 
	y = y+lengthdir_y(sp,d);
	direction = point_direction(oldX,oldY,x,y);
	return true;
}
else {
	var dir = d;
	var possibleAngles = ds_list_create();
	dir = (dir + 5.625)%360; 
	while dir != d
	{
		if !place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),objectsToAvoid) {
			
			x = x+lengthdir_x(sp,dir); 
			y = y+lengthdir_y(sp,dir); 
			if place_meeting_layer(x,y,objectsToAvoid) || abs(angle_difference(d,dir) > 100) {
				x = oldX;
				y = oldY;
			} else {
				ds_list_add(possibleAngles,dir);
				x = oldX;
				y = oldY;
			}
		}
		dir = (dir + 5.625)%360;
	}
	// find closest possible angle
	var closestAngleDiff = 360;
	for (var i = 0; i < ds_list_size(possibleAngles); i++) {
		var ang = ds_list_find_value(possibleAngles,i);
		var diff = abs(angle_difference(d,ang));
		if diff < closestAngleDiff {
			closestAngleDiff = diff;
			dir = ang;
		}				
	}
	// only move if some angle was ok
	if dir == d exit;
	if dir != d && abs(angle_difference(d,dir)) < 90 {
		// bigger angle diff = slower speed
		var diff = abs(angle_difference(d,dir));
		// linear
		//sp = (-(diff/90)+1)*sp;
		// quadratic
		sp = (1-((diff*diff)/8100))*sp;
		// logarithmic
		//sp = (1/(log10(90))*log10(-(diff-90)))*sp;
		x = x+lengthdir_x(sp,dir); 
		y = y+lengthdir_y(sp,dir);
		direction = point_direction(oldX,oldY,x,y);
		ds_list_destroy(possibleAngles); possibleAngles = -1;
		return true;
	}
	ds_list_destroy(possibleAngles); possibleAngles = -1;
}
//ds_list_destroy(additionalObjects); additionalObjects = -1;

