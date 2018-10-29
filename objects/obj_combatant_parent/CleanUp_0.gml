
ds_map_destroy(knownSpells); knownSpells = -1;
ds_map_destroy(defenses); defenses = -1;
mp_grid_destroy(personalGrid); personalGrid = -1;
if path_exists(gridPath) {
	path_delete(gridPath); gridPath = -1;
}
if path_exists(path) {
	path_delete(path); path = -1;
}


var ck = ds_map_find_first(conditionsEmittersMap);
for (var i = 0; i < ds_map_size(conditionsEmittersMap); i++) {
	var emitter = ds_map_find_value(conditionsEmittersMap,ck);
	audio_emitter_free(emitter); emitter = -1;
	ck = ds_map_find_next(conditionsEmittersMap,ck);
}
ds_map_destroy(conditionsEmittersMap); conditionsEmittersMap = -1;
audio_emitter_free(walkingInWaterEmitter); walkingInWaterEmitter = -1;
audio_emitter_free(walkingEmitter); walkingEmitter = -1;

if part_emitter_exists(sprintParticleSystem, sprintParticleEmitter) {
	part_emitter_destroy(sprintParticleSystem, sprintParticleEmitter);
	sprintParticle = -1;
}
if part_system_exists(sprintParticleSystem) {
	part_system_destroy(sprintParticleSystem); sprintParticleSystem = -1;
}
if part_type_exists(sprintParticle) {
	part_type_destroy(sprintParticle); sprintParticle = -1;
}
if audio_emitter_exists(attackPrepSoundEmitter) {
	audio_emitter_free(attackPrepSoundEmitter); attackPrepSoundEmitter = -1;
}