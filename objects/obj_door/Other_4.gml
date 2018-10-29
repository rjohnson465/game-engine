// create the persistent room data object for this door (if one does not exist)
/*if data == noone || !instance_exists(data) {
	global.el = id;
	var dd = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
	with obj_room_data {
		if string(roomIndex) == string(room) {
			ds_map_replace(persistentElements, fs_generate_key(global.el), dd);
		}
	}
	ds_map_replace(dd.properties, "isOpen", isOpen);
}*/

event_inherited();
isOpen = ds_map_find_value(properties, "isOpen");
if isOpen {
	sprite_index = noone;
	light_destroy_caster_layer(getLayerFloorNumber(layer));
} else {
	
}

/*
// if data.properties is empty, you need to set the properties this persistent element remembers
if ds_map_size(data.properties) == 0 {
	ds_map_replace(data.properties, "isOpen", isOpen);
}*/



/*
// set properties of this door from the data object
with obj_persistent_environment_data_parent {
	if key == other.key {
		other.postX = postX;
		other.postY = postY;
		var isO = ds_map_find_value(properties, "isOpen");
		other.isOpen = isO;
		if other.isOpen {
			other.sprite_index = noone;
			//light_destroy_caster();
		}
		other.data = id;
	}
}