if lever != noone && instance_exists(lever) {
	isActive = lever.isActive;
}

if isActive && soundIndex == noone {
	soundIndex = audio_play_sound_at(snd_conveyer_belt_loop, x,y,depth, 100, AUDIO_MAX_FALLOFF_DIST, 1, 1, 1);
}

if !isActive && soundIndex != noone {
	audio_stop_sound(soundIndex);
	soundIndex = noone;
}