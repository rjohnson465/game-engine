/// fs_save_roomdata_tempfile()

/// write all persistent room data to a temporary file
/// this file gets integrated with actual savefile upon an explicit save
/// must be called from obj_roomdata

// var sd_roomdata = persistentElements;
var sd_roomdata_copy = ds_map_deep_clone(persistentElements); // use this, or else sd_roomdata will be destroyed, ruining obj_room_data.persistentElements
// add / replace the sd_roomdata map at the correct key of the temporary room data map file
var sd_temp_roomdata = ds_map_secure_load(TEMP_ROOMDATA_FILENAME);
if sd_temp_roomdata != undefined && ds_exists(sd_temp_roomdata, ds_type_map) {
	var mapToDelete = ds_map_find_value(sd_temp_roomdata, roomName);
	// must manually destroy the mapToDelete to clear submaps
	if mapToDelete != undefined && ds_exists(mapToDelete, ds_type_map) {
		ds_map_destroy(mapToDelete); mapToDelete = -1;
	}
	ds_map_delete(sd_temp_roomdata, roomName);
	ds_map_add_map(sd_temp_roomdata, roomName, sd_roomdata_copy);
}
else {
	sd_temp_roomdata = ds_map_create();
	ds_map_add_map(sd_temp_roomdata, roomName, sd_roomdata_copy);
}
ds_map_secure_save(sd_temp_roomdata, TEMP_ROOMDATA_FILENAME);

ds_map_destroy(sd_temp_roomdata); sd_temp_roomdata = -1;
ds_map_destroy(sd_roomdata_copy); sd_roomdata_copy = -1;

