/// startBgm()

// must be called by obj_game_manager

bgmPossibilities = getBgmForRoom(room);
if bgmPossibilities != noone {
	
	
	// special: if this is a boss room, make sure the boss is alive before playing its theme
	bossExists = false;
	var bossAlive = false;
	with obj_enemy_parent {
		if isBoss {
			other.bossExists = true;
			if isAlive {
				bossAlive = true;
			}
		}
	}
	
	// if this is a boss room but the boss is dead, keep playing the same old song
	if (bossExists && !bossAlive) {
		exit;
	}
	
	// if there is no living boss in the room and we were just playing some song
	// that carried over from the previous room and it just ended, do NOT try to pick a song
	// from bgmPossibilities -- the only song in there will be the boss theme, which 
	// should only play if the boss is alive
	if bossExists && !bossAlive && bgmCurrent == noone {
		exit;
	}
	
	// loop the song, iff this is an active boss room
	var loops = false;
	if bossExists && bossAlive {
		loops = true;
	}
	
	// decide which song to start, if a new one should start at all
	// the the new playlist for this room contains the currently playing song, do not start a new song,
	// just keep playing the old one
	if !bgmAlarmSet && arrayIncludes(bgmPossibilities, bgmCurrent) {
		exit;
	}
	// if not, pick a new one randomly
	else {
		// remember to stop the old song
		stopBgm();
		
		// make sure the new pick has not been played yet
		// if index is the size of the possibilities array, this means we have played everything
		// clear the playedTracks and pick one at random
		var attemptedTracks = ds_list_create();
		// these variables make it easier to debug
		var atTracksLength = 0;
		var possLength = array_length_1d(bgmPossibilities);
		while atTracksLength != possLength && bgmCurrent == noone {
			randomize();
			var rand = round(random_range(0,array_length_1d(bgmPossibilities)-1));
			var proposedBgm = bgmPossibilities[rand];
			
			// if we have not attempted this track yet, add it to attemptedTracks
			if ds_list_find_index(attemptedTracks, proposedBgm) == -1 {
				ds_list_add(attemptedTracks, proposedBgm);
				atTracksLength++;
			}
			
			// now check if we've already played this proposedTrack in the cycle
			if ds_list_find_index(playedTracks, proposedBgm) == -1 {
				// if playedTracks does not contain the proposedBgm, it means we haven't played this song
				// yet in this cycle, so feel free to play it
				bgmCurrent = proposedBgm;
			}
			// if playedTracks does contain proposedBgm, we must keep going in search of a new song
			else {
			}
		}
		ds_list_destroy(attemptedTracks); attemptedTracks = -1;
		
		// if after all that we still don't have a new bgm, it's because we've played everything we could
		// thus, restart the cycle (clear playedTracks) and pick a bgm at random 
		if bgmCurrent == noone || (bossExists && bossAlive) {
			ds_list_clear(playedTracks);
			randomize();
			var rand = random_range(0,array_length_1d(bgmPossibilities)-1);
			bgmCurrent = bgmPossibilities[rand];
		}
		
		bgmCurrentIndex = audio_play_sound_on(bgmEmitter, bgmCurrent, loops, 1);
		audio_emitter_gain(bgmEmitter, bgmEmitterGain);
	}	
	
} else {
	// if there are absolutely no possible songs for this room, stop bgm
	stopBgm();
}