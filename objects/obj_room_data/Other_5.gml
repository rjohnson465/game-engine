if global.gameManager.isLoading exit;

// when room ends, update the save file with the room data (all the data objects are gonna be destroyed!)

// only update a temporary file -- the save file will only be update on explicit save
// This should be done during fade's Room End event so we are sure to have all instances activated

/*
fs_save_roomdata_tempfile();
fs_save_enemydata_tempfile();
*/

// delete properties map for each persistent element only after we save to the temp file
with obj_persistent_environment {
	if !is_nan(properties) && ds_exists(properties, ds_type_map) {
		ds_map_destroy(properties); properties = -1;
	}
}
with obj_persistent_environment_nonsolid {
	if !is_nan(properties) && ds_exists(properties, ds_type_map) {
		ds_map_destroy(properties); properties = -1;
	}
}

event_perform(ev_cleanup, 0);

if !is_nan(persistentElements) && ds_exists(persistentElements, ds_type_map) {
	ds_map_destroy(persistentElements); persistentElements = -1;
}
if !is_nan(enemiesData) && ds_exists(enemiesData, ds_type_map) {
	ds_map_destroy(enemiesData); enemiesData = -1;
}