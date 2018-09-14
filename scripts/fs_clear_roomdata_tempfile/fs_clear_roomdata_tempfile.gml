/// fs_clear_roomdata_tempfile

/// clear the temp roomdata
var tempRoomData = ds_map_secure_load(TEMP_ROOMDATA_FILENAME);
if tempRoomData != undefined && ds_exists(tempRoomData, ds_type_map) {
	ds_map_clear(tempRoomData);
}
ds_map_secure_save(tempRoomData,TEMP_ROOMDATA_FILENAME);

if tempRoomData != undefined && ds_exists(tempRoomData, ds_type_map) {
	ds_map_destroy(tempRoomData); tempRoomData = -1;
}