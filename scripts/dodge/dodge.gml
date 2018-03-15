attackNumberInChain = noone;
isShielding = false;
speed = 0;	
image_angle = dodgeDirection;
		
var dodgeSpeed = functionalSpeed*2;
// Do not dodge into fallzones on purpose (if enemy)
if type != CombatantTypes.Player {
	if dodgeFrame == 0 {
		// check every step the dodge in this direction would take us
		// if its into a fallzone, try a different angle
		var dir = dodgeDirection;
		var i = dodgeFrame;
		var possibleAngles = ds_list_create();
		while i < totalDodgeFrames {
			var xx = x+lengthdir_x(dodgeSpeed,dir);
			var yy = y+lengthdir_y(dodgeSpeed,dir);
			if !place_meeting_layer(xx,yy,obj_fallzone) {
				ds_list_add(possibleAngles,dir);
			} 
			i++;
			dir = (dir+10)%360;
		}
		// find closest possible angle to dodgeDirection
		var closestAngleDiff = 360;
		for (var i = 0; i < ds_list_size(possibleAngles); i++) {
			var ang = ds_list_find_value(possibleAngles,i);
			var diff = abs(angle_difference(dodgeDirection,ang));
			if diff < closestAngleDiff {
				closestAngleDiff = diff;
				dir = ang;
			}				
		}
		dodgeDirection = dir;
		ds_list_destroy(possibleAngles);
	}
	moveToNearestFreePoint(dodgeDirection,dodgeSpeed,true);
} else {
	moveToNearestFreePoint(dodgeDirection,dodgeSpeed);
}

dodgeFrame++;