/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
// event_inherited();

event_inherited();

isLit = ds_map_find_value(properties, "isLit");
if isLit {
	// ensure there is only ever one light radius object for a sconce
	with obj_light_radius {
		if owner == other {
			light_destroy_layer(getLayerFloorNumber(other.origLayer),id);
			instance_destroy(id,1);
			other.lightRadius = noone;
		}
	}
			
	global.owner = id;
	global.makeLightOnCreate = true;
	lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
	with lightRadius {
		var floorNum = getLayerFloorNumber(other.origLayer);
		light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
	}
} else if isLit != undefined && !isLit {
	extinguishSconce(false);
}