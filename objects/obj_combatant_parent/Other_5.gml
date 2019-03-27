if global.gameEnding exit;
audio_stop_sound(walkingSoundIndex); walkingSoundIndex = -1;
audio_stop_sound(walkingInWaterSoundId); walkingInWaterSoundId = -1;
//ds_grid_destroy(personalGrid);
// memory leak stuff
if type == CombatantTypes.Enemy {
	if path != 0 path_delete(path);
	if gridPath != 0 path_delete(gridPath);
	mp_grid_destroy(personalGrid);
}