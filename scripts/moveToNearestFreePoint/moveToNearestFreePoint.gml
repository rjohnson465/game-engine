/// moveToNearestFreePoint(direction,speed)
/// @param direction
/// @param speed

var d = argument[0];
var sp = argument[1];
var oldX = x;
var oldY = y;
if !place_meeting_layer(x+lengthdir_x(sp,d),y+lengthdir_y(sp,d),obj_solid_parent) {
	x = x+lengthdir_x(sp,d); 
	y = y+lengthdir_y(sp,d);
}
else {
	var dir = d;
	var possibleAngles = ds_list_create();
	dir = (dir + 5.625)%360; 
	while dir != d
	{
		if !place_meeting_layer(x+lengthdir_x(sp,dir),y+lengthdir_y(sp,dir),obj_solid_parent) {
			
			x = x+lengthdir_x(sp,dir); 
			y = y+lengthdir_y(sp,dir); 
			if place_meeting_layer(x,y,obj_solid_parent) || abs(angle_difference(d,dir) > 100) {
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
		//show_debug_message(sp);
		x = x+lengthdir_x(sp,dir); 
		y = y+lengthdir_y(sp,dir);
		direction = point_direction(oldX,oldY,x,y);
	}
}
