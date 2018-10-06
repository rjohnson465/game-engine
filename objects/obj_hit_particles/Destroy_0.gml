if !instance_exists(type) || (instance_exists(type) && !object_is_ancestor(type.object_index, obj_attack_data_parent)) {
	part_type_destroy(particle);
}

part_emitter_destroy(system,emitter);
part_system_destroy(system);

if type == "LevelUp" {
	part_type_destroy(particle2);
	part_type_destroy(particle3);
	part_type_destroy(particle4);
}