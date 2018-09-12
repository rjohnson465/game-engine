/// fs_save_roomdata_tempfile()

/// write all persistent room data to a temporary file
/// this file gets integrated with actual savefile upon an explicit save
/// must be called from obj_roomdata
var sd_roomdata = persistentElements;

// add / replace the sd_roomdata map at the correct key of the temporary room data map file
var sd_temp_roomdata = ds_map_secure_load(TEMP_ROOMDATA_FILENAME);
if sd_temp_roomdata != undefined && ds_exists(sd_temp_roomdata, ds_type_map) {
	ds_map_delete(sd_temp_roomdata, roomName);
	ds_map_add_map(sd_temp_roomdata, roomName, sd_roomdata);
}
else {
	sd_temp_roomdata = ds_map_create(); // TODO can this be safely destroyed later in this function?
	ds_map_add_map(sd_temp_roomdata, roomName, sd_roomdata);
}
ds_map_secure_save(sd_temp_roomdata, TEMP_ROOMDATA_FILENAME);

//ds_map_destroy(sd_roomdata); sd_roomdata = -1;