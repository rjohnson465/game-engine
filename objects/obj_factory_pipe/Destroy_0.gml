if soundIndex != noone {
	audio_stop_sound(soundIndex); soundIndex = noone;
}

if part_emitter_exists(system, emitter) {
	part_emitter_destroy(system, emitter); emitter = -1;
	part_system_destroy(system); system = -1;
}

if part_type_exists(particle) {
	part_type_destroy(particle); particle = -1;
}