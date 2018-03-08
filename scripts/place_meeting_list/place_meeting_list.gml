/// place_meeting_list(x,y,list)

/// @param x
/// @param y
/// @param list

// check if there is a collision at x/y with any instance in a list
var xx = argument0;
var yy = argument1;
var list = argument2;

for (var i = 0; i < ds_list_size(list); i++) {
	if place_meeting(xx,yy,ds_list_find_value(list,i)) {
		return true;
	}
}
return false;