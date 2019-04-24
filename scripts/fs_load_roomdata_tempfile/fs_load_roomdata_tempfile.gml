/// fs_load_roomdata_tempfile(roomName)
/// @param roomName
/// if there is no temp room data for the specified roomIndex, return noone

var rn = argument[0];

var sd_temp_roomdatas = ds_map_secure_load(TEMP_ROOMDATA_FILENAME); // needs to be destroyed for mem leak
if !ds_exists(sd_temp_roomdatas, ds_type_map) && !global.gameManager.isLoading {
	return noone;
}

var sd_temp_roomdata = noone;
var sd_game = ds_map_secure_load(global.gameManager.currentSaveFile); // needs to be destroyed for mem leak
var sd_roomdatas = noone; var sd_roomdata = noone;
if sd_game != undefined && ds_exists(sd_game, ds_type_map) {
	sd_roomdatas = ds_map_find_value(sd_game, "RoomData");
}
if sd_roomdatas != undefined && ds_exists(sd_roomdatas, ds_type_map) {
	sd_roomdata = ds_map_find_value(sd_roomdatas, rn);
}

var sd_temp_roomdata = ds_map_create(); // this is what we're gonna return, and it should be the only ds to live through this shit

// if we're loading from a save file OR
// if we have some data for this room already in a save file AND
// we haven't written any temp data to for this room yet, use the save file data
if global.gameManager.isLoading || (sd_roomdata != undefined && ds_exists(sd_roomdata,ds_type_map) && sd_temp_roomdata == undefined) {
	sd_temp_roomdata = ds_map_deep_clone(sd_roomdata); // copy, since we're gonna destroy sd_roomdata later
} 
// if theres no tempfile data written for this room yet... 
else {
	// get the temp room data for the specific room index
	var sd_temp_roomdata_tocopy = ds_map_find_value(sd_temp_roomdatas, rn);
	if sd_temp_roomdata_tocopy == undefined || !ds_exists(sd_temp_roomdata_tocopy, ds_type_map) {
		// mem leaks
		ds_map_destroy(sd_temp_roomdata); sd_temp_roomdata = -1;
		ds_map_destroy(sd_temp_roomdatas); sd_temp_roomdatas = -1;
		return noone;
	}
	sd_temp_roomdata = ds_map_deep_clone(sd_temp_roomdata_tocopy);
	ds_map_destroy(sd_temp_roomdata_tocopy); sd_temp_roomdata_tocopy = -1; // mem leak
}

// mem leak prevention
ds_map_destroy(sd_temp_roomdatas); sd_temp_roomdatas = -1;
if sd_game != undefined && ds_exists(sd_game, ds_type_map) {
	ds_map_destroy(sd_game); sd_game = -1;
}

// we have the temp room data for the specific room index
return sd_temp_roomdata;

