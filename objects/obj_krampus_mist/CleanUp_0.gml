if part_emitter_exists(system, emitter) {
	part_emitter_destroy(system, emitter); emitter = -1;
	part_system_destroy(system); system = -1;
}

if part_type_exists(partSmoke) {
	part_type_destroy(partSmoke); partSmoke = -1;
}

if part_type_exists(partSnowflake) {
	part_type_destroy(partSnowflake); partSnowflake = -1;
}