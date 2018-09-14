/// angleBetween(ang1,ang2,angleToCheck)
/// @param ang1
/// @param ang2
/// @param angleToCheck

// Check if an angle lies between two angles

var a = argument0;
var b = argument1;
var n = argument2;

	n = (360 + (n % 360)) % 360;
	a = (3600000 + a) % 360;
	b = (3600000 + b) % 360;

	if (a < b)
		return a <= n && n <= b;
	return a <= n || n <= b;
