/*// create the persistent room data object for this sconce (if one does not exist)
if data == noone || !instance_exists(data) {
	global.el = id;
	var dd = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
	with obj_room_data {
		if string(roomIndex) == string(room) {
			ds_map_replace(persistentElements, fs_generate_key(global.el), dd);
		}
	}
	ds_map_replace(dd.properties, "isLit", isLit);
}*/

event_inherited();

// if data.properties is empty, you need to set the properties this persistent element remembers
if ds_map_size(data.properties) == 0 {
	ds_map_replace(data.properties, "isLit", isLit);
}


// set properties of this sconce from the data object
with obj_persistent_environment_data_parent {
	if key == other.key {
		other.postX = postX;
		other.postY = postY;
		var isL = ds_map_find_value(properties, "isLit");
		other.isLit = isL;
		if other.isLit {
			global.owner = other.id;
			global.makeLightOnCreate = true;
			other.lightRadius = instance_create_depth(x,y,depth,obj_light_radius);
			with other.lightRadius {
				var floorNum = getLayerFloorNumber(layer);
				light_set_alpha(calculateLightRadiusAlphaLayer(floorNum));
			}
		}
		other.data = id;
	}
}