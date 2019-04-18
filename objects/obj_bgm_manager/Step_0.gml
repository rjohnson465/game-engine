var atLeastOneBossAlive = false;
if bossExists {
	with obj_enemy_parent {
		if isBoss && isAlive {
			atLeastOneBossAlive = true;
		}
	}
}

if bgmPossibilities != noone && (!audio_is_playing(bgmCurrentIndex) || bgmCurrentIndex == -1) && (!bgmAlarmSet || bossExists) {
	
	// if boss room, immediately loop music
	if bossExists && atLeastOneBossAlive {
		alarm[2] = -1;
		startBgm();
		exit;
	}
	
	randomize();
	// play a song again anywhere from 15 seconds to 1 minute later
	var rand = random_range(15*30, 60*30);
	alarm[2] = rand;
	bgmAlarmSet = true;
} 

// if all bosses are dead in the room, stop the boss music
if audio_is_playing(bgmCurrentIndex) && bossExists {
	
	if !atLeastOneBossAlive {
		stopBgm();
	}
}
