/// startAmb()

// must be called by obj_game_manager

var ambs = getAmbForRoom(room);

if is_array(ambs) {
	var p = global.player;
	var pFloorNum = getLayerFloorNumber(p.layer);
	var pfString = string(pFloorNum);
	
	var arrLength = array_length_1d(ambs);
	for (var i = 0; i < arrLength; i++) {
		var arrLayerAllData = ambs[i];
		var arrIntendedLayers = arrLayerAllData[0];
		if arrayIncludes(arrIntendedLayers, pfString) {
			array_copy(ambs, 0, arrLayerAllData, 1, 2);
		}
	}
}

if ambs != noone {
	ambCurrent = ambs[0];
	ambCurrent = ambCurrent[0];
	if audio_is_playing(ambCurrent) exit; // ??
	
	for (var i = 0; i < ds_list_size(ambSoundIndexes); i++) {
		var ambSoundIndex = ds_list_find_value(ambSoundIndexes, i);
		audio_stop_sound(ambSoundIndex);
	}

	ds_list_clear(ambSoundIndexes);
	
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