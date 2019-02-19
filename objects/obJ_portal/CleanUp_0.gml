if part_emitter_exists(system, emitter) { 
	part_emitter_destroy(system, emitter); emitter = -1;
	part_system_destroy(system); system = -1;
}
if part_type_exists(part) {
	part_type_destroy(part); part = -1;
}
if audio_emitter_exists(audioEmitter) {
	audio_emitter_free(audioEmitter); audioEmitter = -1;
}

audio_stop_sound(portalSoundIndex); portalSoundIndex = -1;