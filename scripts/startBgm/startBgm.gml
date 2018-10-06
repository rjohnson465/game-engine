/// startBgm()

// must be called by obj_game_manager

bgmPossibilities = getBgmForRoom(room);
if bgmPossibilities != noone {
	randomize();
	var rand = random_range(0,array_length_1d(bgmPossibilities)-1);
	bgmCurrent = bgmPossibilities[rand];
	audio_play_sound_on(bgmEmitter, bgmCurrent, 0, 1);
}