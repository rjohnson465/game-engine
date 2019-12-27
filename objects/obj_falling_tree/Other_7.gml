if sprite_index != spr_stump_rotten_fallen {
	audio_play_sound(snd_crunchy_thud, 1, 0);
	global.isPopulatingGrids = true;
}

sprite_index = spr_stump_rotten_fallen;