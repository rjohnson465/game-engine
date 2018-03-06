/// place_meeting_layer(x,y,obj)
/// @param x
/// @param y
/// @param obj

/// Only consider it a place_meeting if the obj has the same depth as the invoking instance

var xx = argument0;
var yy = argument1;
var obj = argument2;

var objLayer = obj.layer;
var invokingInstanceLayer = layer;

// get all touching objects
var r = (bbox_right-bbox_left);
var touchingInstances = scr_collision_circle_list(xx,yy,r,obj,true,true);
var touchingInstanceIsOnSameLayer = false;
var offendingInstance = noone;
for (var i = 0; i < ds_list_size(touchingInstances); i++) {
	var inst = ds_list_find_value(touchingInstances,i);
	show_debug_message("Touching: " + object_get_name(inst.object_index) + " layer: " + string(inst.layer));
	
	if inst.layer == layer && inst != id && place_meeting(xx,yy,inst) {
		touchingInstanceIsOnSameLayer = true;
		offendingInstance = inst;
	}
}

var pred = false;
show_debug_message("Place meeting: " + string(place_meeting(xx,yy,obj)));
show_debug_message("Instance on Same Layer: " + string(touchingInstanceIsOnSameLayer));
if offendingInstance != noone {
	show_debug_message("Offending instance: " + object_get_name(offendingInstance.object_index) + " layer: " + string(offendingInstance.layer));
}
if place_meeting(xx,yy,obj) && touchingInstanceIsOnSameLayer {
	pred = true;
} else pred = false;
return pred;