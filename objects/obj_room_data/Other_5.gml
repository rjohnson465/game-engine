if global.gameManager.isLoading exit;

// when room ends, update the save file with the room data (all the data objects are gonna be destroyed!)

// only update a temporary file -- the save file will only be update on explicit save
fs_save_roomdata_tempfile();

/*var sd_roomdatas = fs_save_roomdata();
var sd_everything = ds_map_secure_load(global.gameManager.currentSaveFile);
if ds_exists(sd_everything,ds_type_map) {
	ds_map_delete(sd_everything,"RoomData");
	ds_map_add_map(sd_everything,"RoomData",sd_roomdatas);
} else {
	sd_everything = ds_map_create();
	ds_map_add_map(sd_everything,"RoomData",sd_roomdatas);
}
ds_map_secure_save(sd_everything,global.gameManager.currentSaveFile);
//ds_map_destroy(sd_everything); sd_everything = -1;
//ds_map_destroy(sd_roomdatas); sd_roomdatas = -1;
*/