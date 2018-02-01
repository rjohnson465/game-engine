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

var goalAngle = point_direction(x,y,pointX,pointY);

var diff = angle_difference(goalAngle, facingDirection); //The difference between the turret angle and direction to player
facingDirection += clamp(diff, -turnSpeed, turnSpeed);