
if is_array(particles) && array_length_1d(particles) {
	for (var i = 0; i < array_length_1d(particles); i++) {
		var pArr = particles[i];
		var p = pArr[0];
		if part_type_exists(p) {
			part_type_destroy(p); p = -1;
		}
	}
}

if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system, emitter); emitter = -1;
}

if part_system_exists(system) {
	part_system_destroy(system); system = -1;
}