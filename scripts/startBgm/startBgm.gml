/// startBgm()

// must be called by obj_game_manager

/*
bgmPossibilities = getBgmForRoom(room);
if bgmPossibilities != noone {
	randomize();
	var rand = random_range(0,array_length_1d(bgmPossibilities)-1);
	bgmCurrent = bgmPossibilities[rand];
	audio_play_sound_on(bgmEmitter, bgmCurrent, 0, 1);
	audio_emitter_gain(bgmEmitter, bgmEmitterGain);
}

*/

bgmPossibilities = getBgmForRoom(room);
if bgmPossibilities  != noone {
	randomize();
	var rand = random_range(0,array_length_1d(bgmPossibilities)-1);
	
	// stop old bgm
	if bgmCurrentIndex >= 0 {
		audio_stop_sound(bgmCurrentIndex);
	}
	
	
	bgmCurrent = bgmPossibilities[rand];
	bgmCurrentIndex = audio_play_sound_on(bgmEmitter, bgmCurrent, 0, 1);
	// audio_emitter_falloff(bgmEmitter, audio_falloff_none,1,1);
	audio_emitter_gain(bgmEmitter, bgmEmitterGain);
}