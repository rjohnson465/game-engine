if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system,emitter); emitter = -1;
}
if part_system_exists(system) {
	part_system_destroy(system); system = -1;
}
if part_type_exists(particle) {
	part_type_destroy(particle); particle = -1;
}

// find and destroy the weapon objects this limb is associated with 
with obj_weapon {
	if limb == other {
		instance_destroy(id, 1);
	}
}