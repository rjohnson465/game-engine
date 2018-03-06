/// angleBetween(ang1,ang2,angleToCheck)
/// @param ang1
/// @param ang2
/// @param angleToCheck

// Check if an angle lies between two angles

var a = argument0;
var b = argument1;
var n = argument2;

//function angle_between(n, a, b) {
	n = (360 + (n % 360)) % 360;
	a = (3600000 + a) % 360;
	b = (3600000 + b) % 360;

	if (a < b)
		return a <= n && n <= b;
	return a <= n || n <= b;



/*// make the angle from angle1 to angle2 to be <= 180 degrees
var rAngle = ((a2 - a1) % 360 + 360) % 360;
if (rAngle >= 180)
var temp = a1;
a1 = a2;
a2 = temp;

// check if it passes through zero
if (a1 <= a2)
return a3 >= a1 && a3 <= a2;
else
return a3 >= a1 || a3 <= a2;