// prevent memory leaks
if instance_exists(owner) {
	if owner.object_index == obj_fountain {
		part_type_destroy(particle);
		part_emitter_destroy(system,emitter);
		part_system_destroy(system);
	}
}