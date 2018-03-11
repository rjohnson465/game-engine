/// place_meeting_layer(x,y,obj,*additionObjectsToConsider)
/// @param x
/// @param y
/// @param obj
/// @param *additionalObjectsToConsider

/// Only consider it a place_meeting if the obj has the same depth as the invoking instance

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
	//show_debug_message("Touching: " + object_get_name(inst.object_index) + " layer: " + string(inst.layer));
	if inst.layer == layer && inst != id && place_meeting(xx,yy,inst) {
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
//show_debug_message("Place meeting: " + string(place_meeting(xx,yy,obj)));
//show_debug_message("Instance on Same Layer: " + string(touchingInstanceIsOnSameLayer));

// if either object is standing on a stairs object they might have different layers but could still collide, do not allow this
/*var isEitherObjectOnStairs = false;
var idd = id;
if instance_nearest(x,y,obj_stairs) != noone {
	if idd.object_index != obj_stairs && obj.object_index != obj_stairs {
		with obj_stairs {
			if place_meeting(obj.x,obj.y,id) && objLayer == layer {
				show_debug_message("Object " + object_get_name(obj.object_index) + " is on the stairs");
				isEitherObjectOnStairs = true;
			}
			if place_meeting(xx,yy,id) && invokingInstanceLayer == layer {
				show_debug_message("Object " + object_get_name(idd.object_index) + " is on the stairs");
				isEitherObjectOnStairs = true;
			}
		}
	}
}*/



if ((place_meeting(xx,yy,obj) && touchingInstanceIsOnSameLayer) || touchingAdditionalObjects) {
	pred = true;
	ds_list_destroy(touchingInstances);
} else {
	ds_list_destroy(touchingInstances);
	pred = false;
}
return pred;