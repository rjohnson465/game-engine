/// fs_clear_enemydata_tempfile

/// clear the temp enemy data
var tempdata = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME);
if tempdata != undefined && ds_exists(tempdata, ds_type_map) {
	ds_map_clear(tempdata);
}
ds_map_secure_save(tempdata,TEMP_ENEMYDATA_FILENAME);

if tempdata != undefined && ds_exists(tempdata, ds_type_map) {
	ds_map_destroy(tempdata); tempdata = -1;
}