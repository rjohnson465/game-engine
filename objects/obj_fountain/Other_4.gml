
// re-renter room and fountain has been actived before
//fountainData = findPersistentRoomElementData(obj_fountain_data,id);
/*
if data == noone || !instance_exists(data) {
	global.el = id;
	var fd = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
	with obj_room_data {
		if string(roomIndex) == string(room) {
			ds_map_replace(persistentElements, fs_generate_key(global.el), fd);
		}
	}
	ds_map_replace(fd.properties, "isDoneFilling", isDoneFilling);
}*/

event_inherited();

// if data.properties is empty, you need to set the properties this persistent element remembers
if ds_map_size(data.properties) == 0 {
	ds_map_replace(data.properties, "isDoneFilling", isDoneFilling);
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
	var lr = noone;
	with obj_light_radius {
		if owner == other.id {
			lr = id;
		}
	}
	if lr == noone {
		global.owner = id;
		global.makeLightOnCreate = true;
		instance_create_depth(x,y,1,obj_light_radius);
	}
}

if isRunning {
	audio_emitter_gain(fountainRunningSoundEmitter,1);
	//audio_play_sound_at(snd_fountain_running,x,y,depth,50,250,1,1,1);
}

