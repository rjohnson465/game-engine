if part_emitter_exists(system, emitter) { 
	part_emitter_destroy(system, emitter); emitter = -1;
	part_system_destroy(system); system = -1;
}
if part_type_exists(part) {
	part_type_destroy(part); part = -1;
}

if ds_exists(eventListeners, ds_type_map) {
	ds_map_destroy(eventListeners); eventListeners = -1;
}