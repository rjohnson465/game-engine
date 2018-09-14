/// place_meeting_layer(x,y,obj,*additionObjectsToConsider)
/// @param x
/// @param y
/// @param obj
/// @param *additionalObjectsToConsider

/// Only consider it a place_meeting if the obj has the same layer or depth +-5 as the invoking instance

var xx = argument[0];
var yy = argument[1];
var obj = argument[2];

var additionalObjectsToConsider = noone;
if argument_count == 4 {
	additionalObjectsToConsider = argument[3];
}

var objLayer = obj.layer;
var invokingInstanceLayer = layer;

// get all touching objects
var r = (bbox_right-bbox_left);
var touchingInstances = scr_collision_circle_list(xx,yy,r,obj,true,true);
var touchingInstanceIsOnSameLayer = false;
var touchingAdditionalObjects = false;
var offendingInstance = noone;
for (var i = 0; i < ds_list_size(touchingInstances); i++) {
	var inst = ds_list_find_value(touchingInstances,i);
	if (inst.layer == layer || abs(abs(inst.depth)-abs(depth)) <= 5) && inst != id && place_meeting(xx,yy,inst) {
		touchingInstanceIsOnSameLayer = true;
		//offendingInstance = inst;
	}
	// would this collide with any additional objects to consider? 
	// i.e. stairs edge case in which two combatants with different layers may appear on top of each other
	if additionalObjectsToConsider != noone {
		if ds_list_find_index(additionalObjectsToConsider,inst) != -1 && inst != id {
			if place_meeting(xx,yy,inst) {
				touchingAdditionalObjects = true;
				offendingInstance = inst;
			}
		}
	}
}
var pred = false;
if ((place_meeting(xx,yy,obj) && touchingInstanceIsOnSameLayer) || touchingAdditionalObjects) {
	pred = true;
	ds_list_destroy(touchingInstances); touchingInstances = -1;
} else {
	ds_list_destroy(touchingInstances); touchingInstances = -1;
	pred = false;
}

if touchingInstances != undefined && ds_exists(touchingInstances, ds_type_list) {
	ds_list_destroy(touchingInstances); touchingInstances = -1;
}


return pred;