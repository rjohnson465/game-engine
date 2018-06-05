if isLoading {
	// wait until we're at the right room to actually load
	if isReadyToMoveRooms && room == roomToGoTo {
		alert("Loading " + currentSaveFile, c_yellow);
		isLoading = false;
		roomToGoTo = noone;
		isReadyToMoveRooms = false;
		fs_load_game(currentSaveFile);
	}
}