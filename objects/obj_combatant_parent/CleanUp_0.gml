audio_stop_sound(walkingSoundIndex); walkingSoundIndex = -1;
audio_stop_sound(walkingInWaterSoundId); walkingInWaterSoundId = -1;

if ds_exists(handItems, ds_type_map) {
	var ck = ds_map_find_first(handItems);
	for (var i = 0; i < ds_map_size(handItems); i++) {
		var item = ds_map_find_value(handItems,ck);
		if item != undefined && item >= 0 && instance_exists(item) {
			instance_destroy(item, 1); item = -1;
		}
		ck = ds_map_find_next(handItems,ck);
	}
	ds_map_destroy(handItems); handItems = -1;
}

if ds_exists(equippedLimbItems, ds_type_map) {
	var ck = ds_map_find_first(equippedLimbItems);
	for (var i = 0; i < ds_map_size(equippedLimbItems); i++) {
		var item = ds_map_find_value(equippedLimbItems,ck);
		if item != undefined && item >= 0 && instance_exists(item) {
			instance_destroy(item, 1); item = -1;
		}
		ck = ds_map_find_next(equippedLimbItems,ck);
	}
	ds_map_destroy(equippedLimbItems); equippedLimbItems = -1;
}

if ds_exists(guessPathPts, ds_type_list) {
	ds_list_destroy(guessPathPts); guessPathPts = -1;
}

if ds_exists(knownSpells, ds_type_map) {
	ds_map_destroy(knownSpells); knownSpells = -1;
}
if ds_exists(defenses, ds_type_map) {
	ds_map_destroy(defenses); defenses = -1;
}
if (personalGrid != undefined && ds_exists(personalGrid, ds_type_grid)) {
	mp_grid_destroy(personalGrid); personalGrid = -1;
}
if path_exists(gridPath) {
	path_delete(gridPath); gridPath = -1;
}
if path_exists(path) {
	path_delete(path); path = -1;
}

if ds_exists(conditionLevels, ds_type_map) {
	ds_map_destroy(conditionLevels); conditionLevels = -1;
}

if ds_exists(conditionPercentages, ds_type_map) {
	ds_map_destroy(conditionPercentages); conditionPercentages = -1;
}

if ds_exists(conditionsBuildupMap, ds_type_map) {
	ds_map_destroy(conditionsBuildupMap); conditionsBuildupMap = -1;
}

if ds_exists(conditionsEmittersMap, ds_type_map) {
	var ck = ds_map_find_first(conditionsEmittersMap);
	for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
		var emitter = ds_map_find_value(conditionsEmittersMap,ck);
		audio_emitter_free(emitter); emitter = -1;
		ck = ds_map_find_next(conditionsEmittersMap,ck);
	}
	ds_map_destroy(conditionsEmittersMap); conditionsEmittersMap = -1;
}

if ds_exists(conditionSoundsMap, ds_type_map) {
	ds_map_destroy(conditionSoundsMap); conditionSoundsMap = -1;
}
if audio_emitter_exists(walkingInWaterEmitter) {
	audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;
}

if audio_emitter_exists(walkingEmitter) {
	audio_emitter_free(walkingEmitter); walkingEmitter = -1;
}

// sprint particles system destroy
if part_system_exists(sprintParticleSystem) && part_emitter_exists(sprintParticleSystem, sprintParticleEmitter) {
	part_emitter_destroy(sprintParticleSystem, sprintParticleEmitter);
	sprintParticleEmitter = -1;
}
if part_system_exists(sprintParticleSystem) {
	part_system_destroy(sprintParticleSystem); sprintParticleSystem = -1;
}
if part_type_exists(sprintParticle) {
	part_type_destroy(sprintParticle); sprintParticle = -1;
}

// attack prep particle system destroy
if part_emitter_exists(appSystem, appEmitter) {
	part_emitter_destroy(appSystem, appEmitter); appEmitter = -1;
}
if part_system_exists(appSystem) {
	part_system_destroy(appSystem); appSystem = -1;
}

if audio_emitter_exists(attackPrepSoundEmitter) {
	audio_emitter_free(attackPrepSoundEmitter); attackPrepSoundEmitter = -1;
}

audio_stop_sound(walkingSoundIndex); walkingSoundIndex = -1;

if ds_exists(eventListeners, ds_type_map) {
	ds_map_destroy(eventListeners); eventListeners = -1;
}