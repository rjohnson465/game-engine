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

var pdir = point_direction(x,y,pointX,pointY);
var dif = angle_difference(pdir, facingDirection);
if dif > 1 {
	isTurning = true;
} else isTurning = false;
facingDirection += median(-turnSpeed, dif, turnSpeed);
facingDirection = (facingDirection+360)%360;
if id != global.player && !isFloating {
	var turnDelta = abs(previousFacingDirection-facingDirection);
	turningSpeedModifier = 1-(turnDelta/turnSpeed);
	functionalSpeed = normalSpeed*slowedSpeedModifier*turningSpeedModifier;
	if functionalSpeed < 2 {
		functionalSpeed = 2;
	}
	
	if (functionalSpeed > normalSpeed || functionalSpeed < 0) functionalSpeed = normalSpeed;
	
	if type == CombatantTypes.Enemy {
		with obj_player {
			if place_meeting_layer(x,y,other) {
				moveToNearestFreePoint(pdir,functionalSpeed,0,0);
			}
		}
	}
}