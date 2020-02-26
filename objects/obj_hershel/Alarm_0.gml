var screamSounds = [snd_enemy_golem_roar_1, snd_enemy_golem_roar_2, snd_enemy_golem_roar_3];
randomize();
var sndIndex = round(random_range(0, array_length_1d(screamSounds) -1));
var snd = screamSounds[sndIndex];
audio_play_sound_at(snd, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);

hasSetScreamAlarm = false;