if global.gameManager.isLoading exit;

// when room ends, update the save file with the room data (all the data objects are gonna be destroyed!)

// only update a temporary file -- the save file will only be update on explicit save
fs_save_roomdata_tempfile();

fs_save_enemydata_tempfile();