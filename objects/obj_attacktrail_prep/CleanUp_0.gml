if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system,emitter);
}
if part_system_exists(system) {
	part_system_destroy(system); system = -1; emitter = -1;
}
