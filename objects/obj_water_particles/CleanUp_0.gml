part_emitter_destroy(system,emitter); emitter = -1;
part_system_destroy(system); system = -1;
if part_type_exists(part1) {
	part_type_destroy(part1); part1 = -1;
}
if part_type_exists(part2) {
	part_type_destroy(part2); part2 = -1;
}

if owner != undefined && instance_exists(owner) {
	if audio_emitter_get_gain(owner.walkingInWaterEmitter) > 0 {
		audio_emitter_gain(owner.walkingInWaterEmitter,0);
	}
}