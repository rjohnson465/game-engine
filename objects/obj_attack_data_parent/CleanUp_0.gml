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

if part_type_exists(attackPart) {
	part_type_destroy(attackPart); attackPart = -1;
}

if is_array(beamHitParticlesArr) && array_length_1d(beamHitParticlesArr) > 0 {
	for (var i = 0; i < array_length_1d(beamHitParticlesArr); i ++) {
		var partArr = beamHitParticlesArr[i];
		var pt = partArr[0];
		if part_type_exists(pt) {
			part_type_destroy(pt); pt = -1; //mem leak
		}
	}
}

/*
// handle this in linger zone object, when it dies
if ds_exists(lingerZoneDamages, ds_type_map) {
	ds_map_destroy(lingerZoneDamages); lingerZoneDamages = -1;
}