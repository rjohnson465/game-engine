// prevent memory leaks
if part_type_exists(particle) {
	part_type_destroy(particle);
}
if part_type_exists(particle) {
	part_type_destroy(particle2);
}
if (array_length_1d(particles) > 0) {
	for (var i = 0; i < array_length_1d(particles); i++) {
		var part = particles[i];
		if part_type_exists(part) {
			part_type_destroy(part);
		}
	}
}
part_emitter_destroy(system,emitter);
part_system_destroy(system);