// alarm for mooing
randomize();
var rand = round(random_range(0, array_length_1d(mooSounds) - 1));
var snd = mooSounds[rand];
audio_play_sound_at(snd, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);

alarm[1] = random_range(300, 450);