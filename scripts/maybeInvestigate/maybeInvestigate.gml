/// maybeInvestigate()
/// what a combatant does when he reaches an investigation point (a point where he heard some noise)

investigatingFrame++;

// wander around this point
if alarm[6] == -1 alarm[6] = 30;

if isInvestigatingMoving {
	moveToNearestFreePoint(investigatingDirection,functionalSpeed*.5,1);
	//faceMovingDirection();
	//var x1 = x+lengthdir_x(5,investigatingDirection); var y1 = y+lengthdir_y(5,investigatingDirection);
	//turnToFacePoint(turnSpeed,x1,y1);
	facingDirection = direction;
}
