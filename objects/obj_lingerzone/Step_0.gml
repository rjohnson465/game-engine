if is_array(lingerZonePartTypes) && !hasSetAlarm {
	for (var i = 0; i < array_length_1d(lingerZonePartTypes); i++) {
		var part = lingerZonePartTypes[i];
		var partNum = 2;
		// entry could be of the form [parttype, partnum]
		if is_array(part) {
			var partArr = part;
			part = partArr[0];
			partNum = partArr[1];
		}
		
		part_emitter_burst(system, emitter, part, partNum);
		
	}
}