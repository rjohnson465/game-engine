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
if bgmPossibilities != noone {
	randomize();
	var rand = random_range(0,array_length_1d(bgmPossibilities)-1);
	
	stopBgm();
	
	// special: if this is a boss room, make sure the boss is alive before playing its theme
	bossExists = false;
	var bossAlive = true;
	with obj_enemy_parent {
		if isBoss {
			other.bossExists = true;
			if isAlive {
				bossAlive = true;
			}
		}
	}
	
	if (bossExists && !bossAlive) exit;
	
	bgmCurrent = bgmPossibilities[rand];
	bgmCurrentIndex = audio_play_sound_on(bgmEmitter, bgmCurrent, 0, 1);
	audio_emitter_gain(bgmEmitter, bgmEmitterGain);
}