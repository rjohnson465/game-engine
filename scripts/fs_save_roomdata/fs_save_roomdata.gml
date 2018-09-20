/// fs_save_roomdata
/// returns a map of all the persistent room data in the game
/// though there should only ever be one room data object at a time

// if there is already some roomdata saved, use that map (so we're only appending to it, rather than creating)
var save_data = ds_map_secure_load(global.gameManager.currentSaveFile); // Need to destroy this to prevent mem leak
var sd_roomdatas = noone;
if ds_exists(save_data, ds_type_map) {
	var rooms_data = ds_map_find_value(save_data,"RoomData");
	if rooms_data != undefined && ds_exists(rooms_data,ds_type_map) {
		sd_roomdatas = ds_map_deep_clone(rooms_data);
		ds_map_destroy(rooms_data); rooms_data = -1; // mem leak
	} 
} 

if !ds_exists(sd_roomdatas, ds_type_map) sd_roomdatas = ds_map_create();

// force a save of the temp roomdata
var rd = instance_nearest(x, y, obj_room_data);
with rd {
	fs_save_roomdata_tempfile();
}

if save_data != undefined && ds_exists(save_data, ds_type_map) {
	ds_map_destroy(save_data); save_data = -1;
}

var garbageKeys = ds_list_create();
var crn = ds_map_find_first(sd_roomdatas); 
for (var i = 0 ; i < ds_map_size(sd_roomdatas); i++) {
	if asset_get_index(crn) == -1 {
		ds_list_add(garbageKeys, crn);
	}
	crn = ds_map_find_next(sd_roomdatas, crn);
}
for (var i = 0; i < ds_list_size(garbageKeys); i++) {
	var rn = ds_list_find_value(garbageKeys, i);
	ds_map_delete(sd_roomdatas, rn);
}
ds_list_destroy(garbageKeys); garbageKeys = -1;

// integrate the temp room data contents with the saved room data contents
// iterate through temp room contents and replace each entry in saved room data contents with it
var sd_temp_roomdatas = ds_map_secure_load(TEMP_ROOMDATA_FILENAME); // Need to destroy this to prevent memory leak
var cri = ds_map_find_first(sd_temp_roomdatas); // current room index
for (var i = 0 ; i < ds_map_size(sd_temp_roomdatas); i++) {
	var sd_temp_room_data = ds_map_find_value(sd_temp_roomdatas, cri);
	
	ds_map_delete(sd_roomdatas, cri);
	var sd_temp_room_data_copy = ds_map_deep_clone(sd_temp_room_data); // need to clone, sd_temp_room_data will be destroyed later
	ds_map_add_map(sd_roomdatas, cri, sd_temp_room_data_copy);
	
	cri = ds_map_find_next(sd_temp_roomdatas, cri);
}

// sd_roomdatas should be the only ds that survives this shit
ds_map_destroy(sd_temp_roomdatas); sd_temp_roomdatas = -1;

return sd_roomdatas;