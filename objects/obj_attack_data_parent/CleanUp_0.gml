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

if trailPart != noone && !is_array(trailPart) && part_type_exists(trailPart) {
	part_type_destroy(trailPart); trailPart = -1;
} else if is_array(trailPart) {
	for (var i = 0; i < array_length_1d(trailPart); i++) {
		var p = trailPart[i];
		if part_type_exists(p) {
			part_type_destroy(p); p = -1;
		}
	}
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

if ds_exists(extraHitsDamages, ds_type_map) {
	ds_map_destroy(extraHitsDamages); extraHitsDamages = -1;
}