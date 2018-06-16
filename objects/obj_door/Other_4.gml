if data == noone || !instance_exists(data) {
	global.el = id;
	var dd = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
	with obj_room_data {
		if string(roomIndex) == string(room) {
			ds_map_replace(persistentElements, fs_generate_key(global.el), dd);
		}
	}
	ds_map_replace(dd.properties, "isOpen", isOpen);
}

with obj_persistent_environment_data_parent {
	if key == other.key {
		other.postX = postX;
		other.postY = postY;
		var isO = ds_map_find_value(properties, "isOpen");
		other.isOpen = isO;
		if other.isOpen {
			other.sprite_index = noone;
		}
		other.data = id;
	}
}