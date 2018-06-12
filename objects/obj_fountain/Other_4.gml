
// re-renter room and fountain has been actived before
//fountainData = findPersistentRoomElementData(obj_fountain_data,id);

if data == noone || !instance_exists(data) {
	global.el = id;
	var fd = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
	with obj_room_data {
		if roomIndex == room {
			ds_map_replace(persistentElements, fs_generate_key(global.el), fd);
		}
	}
}

with obj_persistent_environment_data_parent {
	if key == other.key {
		other.postX = postX;
		other.postY = postY;
		var isDF = ds_map_find_value(properties, "isDoneFilling");
		other.isDoneFilling = isDF;
		if isDF {
			other.isRunning = true;
		}
		other.data = id;
	}
}

if isRunning || (global.player.justRevivedAtFountain && distance_to_object(obj_player) < 100) {
	sprite_index = asset_get_index("spr_fountain_full");
	isDoneFilling = true;
	global.owner = id;
	global.makeLightOnCreate = true;
	instance_create_depth(x,y,1,obj_light_radius);
}

