/// startAmb()

// must be called by obj_game_manager

var ambs = getAmbForRoom(room);
if ambs != noone {
	ambCurrent = ambs[0];
	ambCurrent = ambCurrent[0];
	var mainAmbSndIndex = audio_play_sound_on(ambEmitter, ambCurrent, 1, 1);
	ds_list_add(ambSoundIndexes, mainAmbSndIndex);
	
	var ambPeriodicals = ambs[1];
	for (var i = 0; i < array_length_1d(ambPeriodicals); i++) {
		var entry = ambPeriodicals[i];
		var snd = entry[0];
		var freq = entry[1];
		var chance = entry[2];
		var duration = entry[3]; // array of min / max dur
		var fadeInFrames = entry[4];
		var fadeOutFrames = entry[5];
		ds_map_replace(ambPeriodicalsMap, snd, [freq, chance, duration, fadeInFrames, fadeOutFrames]);
		ds_map_replace(ambpFrames, snd, -1);
		var emitter = audio_emitter_create();
		ds_map_replace(ambpEmitters, snd, emitter);
		audio_emitter_gain(emitter, 0);
		var ambSndIndex = audio_play_sound_on(emitter, snd, 1, 1);
		ds_list_add(ambSoundIndexes, ambSndIndex);
	}
}