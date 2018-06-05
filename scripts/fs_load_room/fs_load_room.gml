/// fs_load_room(filename)
/// @param *filename

var filename = "Game.sav";
if argument_count == 1 {
	filename = argument[0];
}

var save_data = ds_map_secure_load(filename);

var roomName = ds_map_find_value(save_data,"Room");
return asset_get_index(roomName);