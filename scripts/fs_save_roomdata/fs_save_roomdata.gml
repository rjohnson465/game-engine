/// fs_save_roomdata
/// returns a map of all the persistent room data in the game
/// though there should only ever be one room data object at a time

// if there is already some roomdata saved, use that map (so we're only appending to it, rather than creating)
var save_data = ds_map_secure_load(global.gameManager.currentSaveFile);
var sd_roomdatas = noone;
//var useLoadedData = true;
if ds_exists(save_data,ds_type_map) {
	var rooms_data = ds_map_find_value(save_data,"RoomData");
	if ds_exists(rooms_data,ds_type_map) {
		sd_roomdatas = rooms_data;
	} //else useLoadedData = false;
} //else useLoadedData = false;

if !ds_exists(sd_roomdatas, ds_type_map) sd_roomdatas = ds_map_create();

// force a save of the temp roomdata
var rd = instance_nearest(x, y, obj_room_data);
with rd {
	fs_save_roomdata_tempfile();
}

// ELSE -- we need to append the temp room data contents with the saved room data contents
// iterate through temp room contents and replace each entry in saved room data contents with it
var sd_temp_roomdatas = ds_map_secure_load(TEMP_ROOMDATA_FILENAME);
var cri = ds_map_find_first(sd_temp_roomdatas); // current room index
for (var i = 0 ; i < ds_map_size(sd_temp_roomdatas); i++) {
	var sd_temp_room_data = ds_map_find_value(sd_temp_roomdatas, cri);
	
	ds_map_delete(sd_roomdatas, cri);
	ds_map_add_map(sd_roomdatas, cri, sd_temp_room_data);
	
	cri = ds_map_find_next(sd_temp_roomdatas, cri);
}

// flush the tempfile data, so new persistent element data starts with the savefile data
fs_clear_roomdata_tempfile();

return sd_roomdatas;