event_inherited();

isLit = ds_map_find_value(properties, "isLit");
if isLit {
	// ensure there is only ever one light radius object for a sconce
	with obj_light_radius {
		if owner == other {
			light_destroy_layer(getLayerFloorNumber(layer),id);
			instance_destroy(id,1);
			other.lightRadius = noone;
		}
	}
			
	global.owner = id;
	global.makeLightOnCreate = true;
	lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
	with lightRadius {
		var floorNum = getLayerFloorNumber(layer);
		light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
	}
}
