var p = global.player;

audio_emitter_position(bgmEmitter, p.x, p.y, p.depth);

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
	

	// register this bgmCurrent as having been played
	ds_list_add(playedTracks, bgmCurrent);
	// since the song has stopped playing, we can consider out current Bgm to be noone
	bgmCurrent = noone;
	
	randomize();
	// play a song again anywhere from 15 seconds to 1 minute later
	var rand = random_range(BGM_START_MIN*30, BGM_START_MAX*30);
	alarm[2] = rand;
	bgmAlarmSet = true;
} 

// if all bosses are dead in the room, stop the boss music
// IMPORTANT: boss rooms must only have a single boss theme in their bgmPossibilities
if audio_is_playing(bgmCurrentIndex) && (bossExists && bgmCurrent == bgmPossibilities[0]) {
	
	if !atLeastOneBossAlive {
		stopBgm();
	}
}
