/// turnToFacePoint(turnSpeed,pointX,pointY,tolerance*)
/// @param turnSpeed
/// @param pointX
/// @param pointY
/// @param tolerance*

var turnSpeed = argument[0];
var pointX = argument[1];
var pointY = argument[2];
var tolerance = 5;

if argument_count == 4 {
	tolerance = argument[3];
}

/*var goalAngle = point_direction(x,y,pointX,pointY);

var diff = angle_difference(goalAngle, facingDirection); //The difference between the turret angle and direction to player
facingDirection += clamp(diff, -turnSpeed, turnSpeed);*/

var pdir = point_direction(x,y,pointX,pointY);
var dif = angle_difference(pdir, facingDirection);
facingDirection += median(-turnSpeed, dif, turnSpeed);
facingDirection = (facingDirection+360)%360;
if id != global.player && !isFloating {
	var turnDelta = abs(previousFacingDirection-facingDirection);
	turningSpeedModifier = 1-(turnDelta/turnSpeed);
	functionalSpeed = normalSpeed*slowedSpeedModifier*turningSpeedModifier;
	
	if (functionalSpeed > normalSpeed || functionalSpeed < 0) functionalSpeed = normalSpeed;
	//show_debug_message(functionalSpeed);
}