if bgmPossibilities != noone && !audio_is_playing(bgmCurrent) && !bgmAlarmSet {
	randomize();
	// play a song again anywhere from 15 seconds to 1 minute later
	var rand = random_range(15*30, 60*30);
	alarm[2] = rand;
	bgmAlarmSet = true;
} 