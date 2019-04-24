/// fs_save_enemydata_tempfile()

/// write all persistent enemy data to a temporary file
/// this file gets integrated with actual savefile upon an explicit save
/// must be called from obj_roomdata
var sd_enemydata = enemiesData;
var sd_enemydata_copy = ds_map_deep_clone(sd_enemydata); // use this, or else sd_enemydata will be destroyed, ruining obj_room_data.enemiesData
// add / replace the sd_enemydata map at the correct key of the temporary enemy data map file
var sd_temp_enemydata = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME);
if sd_temp_enemydata != undefined && ds_exists(sd_temp_enemydata, ds_type_map) {
	var mapToDelete = ds_map_find_value(sd_temp_enemydata, roomName);
	// must manually detroy the map to destroy submaps
	if mapToDelete != undefined && ds_exists(mapToDelete, ds_type_map) {
		ds_map_destroy(mapToDelete); mapToDelete = -1;
	}
	ds_map_delete(sd_temp_enemydata, roomName);
	ds_map_add_map(sd_temp_enemydata, roomName, sd_enemydata_copy);
}
else {
	sd_temp_enemydata = ds_map_create();
	ds_map_add_map(sd_temp_enemydata, roomName, sd_enemydata_copy);
}
ds_map_secure_save(sd_temp_enemydata, TEMP_ENEMYDATA_FILENAME);

ds_map_destroy(sd_temp_enemydata); sd_temp_enemydata = -1;
ds_map_destroy(sd_enemydata_copy); sd_enemydata_copy = -1;