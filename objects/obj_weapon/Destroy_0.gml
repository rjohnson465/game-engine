part_emitter_destroy(system1, emitter1); emitter1 = -1;
part_emitter_destroy(system2, emitter2); emitter2 = -1;
part_emitter_destroy(system3, emitter3); emitter3 = -1;
part_system_destroy(system1); system1 = -1;
part_system_destroy(system2); system2 = -1;
part_system_destroy(system3); system3 = -1;
if part_type_exists(particle1) {
	part_type_destroy(particle1); particle1 = -1;
}
if part_type_exists(particle2) {
	part_type_destroy(particle2); particle2 = -1;
}
if part_type_exists(particle3) {
	part_type_destroy(particle3); particle3 = -1;
}