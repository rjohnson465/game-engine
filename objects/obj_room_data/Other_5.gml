if global.gameManager.isLoading exit;

// when room ends, update the save file with the room data (all the data objects are gonna be destroyed!)

// only update a temporary file -- the save file will only be update on explicit save
fs_save_roomdata_tempfile();
fs_save_enemydata_tempfile();

// delete properties map for each persistent element only after we save to the temp file
with obj_persistent_environment {
	if ds_exists(properties, ds_type_map) {
		ds_map_destroy(properties); properties = -1;
	}
}

event_perform(ev_cleanup, 0);

