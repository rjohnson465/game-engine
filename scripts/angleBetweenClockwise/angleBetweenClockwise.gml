/// nBetween(ang1,ang2,nbCheck)
/// @param ang1
/// @param ang2
/// @param nbCheck

// Check if an n lies between two ns

var from = argument0;
var to = argument1;
var angle = argument2;

angle %= 360;

// will we have to cross 0 to go from from to to?
// to be moving clockwise is to decrease angle


// accept all values from from - 0, then accept all values from 360 to to
	
// is angle between from and 360?
var isInFirstCheck = angle <= from && angle >= 0;
if isInFirstCheck return true;
	
var isInSecondCheck = angle <= 360 && angle >= to;
return isInSecondCheck;
