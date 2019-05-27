if ds_exists(damages, ds_type_map) {
	ds_map_destroy(damages); damages = -1;
}

if part_emitter_exists(system, emitter) {
	part_emitter_destroy(system, emitter); emitter = -1;
	part_system_destroy(system); system = -1;
}

if part_type_exists(partSmoke) {
	part_type_destroy(partSmoke); partSmoke = -1;
}

if part_type_exists(partSmoke2) {
	part_type_destroy(partSmoke2); partSmoke2 = -1;
}

if part_type_exists(partCinder) {
	part_type_destroy(partCinder); partCinder = -1;
}