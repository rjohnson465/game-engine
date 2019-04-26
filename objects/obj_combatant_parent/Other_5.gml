if global.gameEnding exit;
audio_stop_sound(walkingSoundIndex); walkingSoundIndex = -1;
audio_stop_sound(walkingInWaterSoundId); walkingInWaterSoundId = -1;
//ds_grid_destroy(personalGrid);
// memory leak stuff
if type == CombatantTypes.Enemy {
	if path != 0 {
		path_delete(path);
		path = -1;
	}
	if gridPath != 0 {
		path_delete(gridPath);
		gridPath = -1;
	}
	if personalGrid != undefined && ds_exists(personalGrid, ds_type_grid) {
		mp_grid_destroy(personalGrid); personalGrid = -1;
	}
}