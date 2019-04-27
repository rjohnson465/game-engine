if part_type_exists(particle) {
	part_type_destroy(particle); particle = -1;
}

if part_type_exists(particle2) {
	part_type_destroy(particle2); particle2 = -1;
}

if part_type_exists(particle3) {
	part_type_destroy(particle3); particle3 = -1
}

if part_type_exists(particle4) {
	part_type_destroy(particle4);
	particle4 = -1;
}


if (array_length_1d(particles) > 0) {
	for (var i = 0; i < array_length_1d(particles); i++) {
		var part = particles[i];
		if part_type_exists(part) {
			part_type_destroy(part); part = -1;
		}
	}
}

if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system,emitter); emitter = -1;
}
if part_system_exists(system) {
part_system_destroy(system); system = -1;
}

if type == "LevelUp" {
	part_type_destroy(particle2);
	part_type_destroy(particle3);
	part_type_destroy(particle4);
}