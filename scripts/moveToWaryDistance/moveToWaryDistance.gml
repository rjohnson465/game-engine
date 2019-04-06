// if not at wary distance, get there
path_end();
if (distance_to_object(lockOnTarget) < waryDistance && !hasReachedWaryDistance) || jumpFrame < jumpTotalFrames {
	// pick direction
	// start with opposite direction of player
	var startDir = (facingDirection+180)%360;
	var dir = (startDir+10)%360;
	var sp = jumpFrame >= jumpTotalFrames ? functionalSpeed*.5 : functionalSpeed*jumpSpeedFactor;
	var xx = x+lengthdir_x(sp,dir);
	var yy = y+lengthdir_y(sp,dir);
	var i = 0;
	while (place_meeting_layer(xx,yy,obj_enemy_obstacle_parent) || place_meeting_layer(xx,yy,obj_fallzone)) && dir != startDir {
		dir = (dir+10)%360;
		xx = x+lengthdir_x(sp,dir);
		yy = y+lengthdir_y(sp,dir);
		i++;
	}
	// possibly don't always turn the same way
	if dir != startDir {
		x += lengthdir_x(sp,dir);
		y += lengthdir_y(sp,dir);
	} else {
		hasCalculatedWillDodge = false;
		state = CombatantStates.Idle;
	}
	turnToFacePoint(turnSpeed,lockOnTarget.x,lockOnTarget.y);
} else {
	hasReachedWaryDistance = true;
}