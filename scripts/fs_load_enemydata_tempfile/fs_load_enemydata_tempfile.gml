/// fs_load_enemydata_tempfile(roomName)
/// @param roomName
/// if there is no temp room data for the specified roomName, return noone

var rn = argument[0];

var sd_temp_enemydatas = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME); // needs to be destroyed to prevent mem leak
if !ds_exists(sd_temp_enemydatas, ds_type_map) && !global.gameManager.isLoading {
	return noone;
}

var sd_game = ds_map_secure_load(global.gameManager.currentSaveFile); // needs to be destroyed to prevent mem leak
var sd_enemydatas = noone; var sd_enemydata = noone;
if sd_game != undefined && ds_exists(sd_game, ds_type_map) {
	sd_enemydatas = ds_map_find_value(sd_game, "Enemies");
}
if sd_enemydatas != undefined && ds_exists(sd_enemydatas, ds_type_map) {
	sd_enemydata = ds_map_find_value(sd_enemydatas, rn);
}
var sd_temp_enemydata = ds_map_create(); // this is what we're gonna return, and it should be the only ds to live through this shit

// if we're loading from a save file OR
// if we have some data for this room already in a save file AND
// we haven't written any temp data for this room yet, use the save file data
if global.gameManager.isLoading || (sd_enemydata != undefined && ds_exists(sd_enemydata,ds_type_map) && sd_temp_enemydata == undefined) {
	var old_sd_temp_enemydata_map = sd_temp_enemydata;
	sd_temp_enemydata = ds_map_deep_clone(sd_enemydata);
	ds_map_destroy(old_sd_temp_enemydata_map); old_sd_temp_enemydata_map = -1;
} 
// if theres no tempfile data written for this room yet... 
else {

	// get the temp enemy data for the specific room index
	var sd_temp_enemydata_tocopy = ds_map_find_value(sd_temp_enemydatas, rn);
	if sd_temp_enemydata_tocopy == undefined || !ds_exists(sd_temp_enemydata_tocopy, ds_type_map) {
		// mem leaks
		ds_map_destroy(sd_temp_enemydata); sd_temp_enemydata = -1;
		ds_map_destroy(sd_temp_enemydatas); sd_temp_enemydatas = -1;
		return noone;
	}
	
	var old_sd_temp_enemydata_map = sd_temp_enemydata;
	sd_temp_enemydata = ds_map_deep_clone(sd_temp_enemydata_tocopy);
	ds_map_destroy(sd_temp_enemydata_tocopy); sd_temp_enemydata_tocopy = -1; // mem leak
	ds_map_destroy(old_sd_temp_enemydata_map); old_sd_temp_enemydata_map = -1;
}

// prevent memory leaks
ds_map_destroy(sd_temp_enemydatas); sd_temp_enemydatas = -1;
if sd_game != undefined && ds_exists(sd_game, ds_type_map) {
	ds_map_destroy(sd_game); sd_game = -1;
}

// we have the temp room data for the specific room index
return sd_temp_enemydata;

