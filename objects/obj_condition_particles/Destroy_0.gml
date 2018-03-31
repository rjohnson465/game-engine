// prevent memory leaks
part_type_destroy(particle);
if particle2 {
	part_type_destroy(particle2);
}
part_emitter_destroy(system,emitter);
part_system_destroy(system);