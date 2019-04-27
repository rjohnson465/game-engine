if ds_exists(damages, ds_type_map) {
	ds_map_destroy(damages); damages = -1;
}

if ds_exists(conditionsChances, ds_type_map) {
	ds_map_destroy(conditionsChances); conditionsChances = -1;
}

if part_type_exists(part1) {
	part_type_destroy(part1); part1 = -1;
}

if part_type_exists(part2) {
	part_type_destroy(part2); part2 = -1;
}

if part_type_exists(prepPart1) {
	part_type_destroy(prepPart1); prepPart1 = -1;
}