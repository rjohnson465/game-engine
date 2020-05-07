/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(lingerZoneDamages, ds_type_map) {
	ds_map_destroy(lingerZoneDamages); lingerZoneDamages = -1;
}

if is_array(lingerZonePartTypes) {
	for (var i = 0; i < array_length_1d(lingerZonePartTypes); i++) {
		var part = lingerZonePartTypes[i];
		// entry could be of the form [parttype, partnum]
		if is_array(part) {
			part = part[0];
		}
		if part_type_exists(part) {
			part_type_destroy(part); part = -1;
		}
	}
}