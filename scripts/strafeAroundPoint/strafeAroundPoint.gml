/// strafeAroundPoint(pointX,pointY,strafeSpeed)
/// @param pointX
/// @param pointY
/// @param strafeSpeed
/// @param strafeOrbit

var pointX = argument[0];
var pointY = argument[1];
var strafeSpeed = argument[2];
var strafeOrbit = argument[3];

isMoving = true;

var angle = point_direction(pointX,pointY,x,y);
angle = strafeDirection == "r" ? angle + strafeSpeed : angle - strafeSpeed;
if angle >= 360 angle -= 360;
									
var xx = lengthdir_x(strafeOrbit,angle) + pointX;
var yy = lengthdir_y(strafeOrbit,angle) + pointY;
									
if !place_meeting_layer(xx,yy,obj_enemy_obstacle_parent) && !place_meeting_layer(xx,yy,obj_fallzone) {
	x = xx;
	y = yy;
	if canStrafe {
		turnToFacePoint(turnSpeed,pointX,pointY);
	} 
	//strafingCombatant.facingDirection = point_direction(x,y,pointX,pointY);
} else {
	strafeDirection = strafeDirection == "l" ? "r" : "l";
}