if !is_string(type) && (!instance_exists(type) || (instance_exists(type) && !object_is_ancestor(type.object_index, obj_attack_data_parent))) {
	part_type_destroy(particle);
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

if type == "LevelUp" {
	part_type_destroy(particle2);
	part_type_destroy(particle3);
	part_type_destroy(particle4);
}