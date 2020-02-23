// prevent memory leaks
if instance_exists(owner) {
	if owner.object_index == obj_fountain {
		part_type_destroy(particle); particle = -1;
		part_emitter_destroy(system,emitter); emitter = -1;
		part_system_destroy(system); system = -1;
	}
}

// maybe we came from a portal, if so, not all instances need to be activated anymore
global.activateAll = false;
