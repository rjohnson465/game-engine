if part_type_exists(particle) {
	part_type_destroy(particle); particle = -1;
}
if part_type_exists(particle2) {
	part_type_destroy(particle2); particle2 = -1;
}
if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system, emitter); emitter = -1;
}
if part_system_exists(system) && part_emitter_exists(system, emitter2) {
	part_emitter_destroy(system, emitter2); emitter2 = -1;
}
if part_system_exists(system) {
	part_system_destroy(system); system = -1;
}