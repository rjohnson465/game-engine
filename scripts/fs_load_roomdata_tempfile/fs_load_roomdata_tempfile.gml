/// fs_load_roomdata_tempfile(roomIndex)
/// @param roomIndex
/// if there is no temp room data for the specified roomIndex, return noone

var ri = argument[0];
ri = string(ri);
var rn = room_get_name(ri);

var sd_temp_roomdatas = ds_map_secure_load(TEMP_ROOMDATA_FILENAME);
if !ds_exists(sd_temp_roomdatas, ds_type_map) && !global.gameManager.isLoading return noone;

var sd_temp_roomdata = noone;
var sd_game = ds_map_secure_load(global.gameManager.currentSaveFile); 
var sd_roomdatas = noone; var sd_roomdata = noone;
if sd_game != undefined && ds_exists(sd_game, ds_type_map) sd_roomdatas = ds_map_find_value(sd_game, "RoomData");
if sd_roomdatas != undefined && ds_exists(sd_roomdatas, ds_type_map) sd_roomdata = ds_map_find_value(sd_roomdatas, rn);
var sd_temp_roomdata = ds_map_find_value(sd_temp_roomdatas, rn);

// if we're loading from a save file, use the roomdata in the save file for this room index
if global.gameManager.isLoading {
	sd_temp_roomdata = sd_roomdata;
} 
// if we have some data for this room already in a save file AND
// we haven't written any temp data to for this room yet, use the save file data
else if sd_roomdata != undefined && ds_exists(sd_roomdata,ds_type_map) && sd_temp_roomdata == undefined {
	sd_temp_roomdata = sd_roomdata;
}
// if theres no tempfile data written for this room yet... 
else {

	// get the temp room data for the specific room index
	sd_temp_roomdata = ds_map_find_value(sd_temp_roomdatas, rn);
	if sd_temp_roomdata == undefined || !ds_exists(sd_temp_roomdata, ds_type_map) return noone;
}

// we have the temp room data for the specific room index
return sd_temp_roomdata;

