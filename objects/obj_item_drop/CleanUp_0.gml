if part_system_exists(system) && part_emitter_exists(system, emitter) {
	part_emitter_destroy(system, emitter);
}
if part_system_exists(system) {
	part_system_destroy(system);
}
if part_type_exists(particle) {
	part_type_destroy(particle);
}

if lightRadius != noone && lightRadius != undefined && lightRadius > 0 && instance_exists(lightRadius) {
	instance_destroy(lightRadius, 1); lightRadius = -1;
}

// destroy any items you hold still 
if ds_exists(items,ds_type_list) {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		instance_destroy(item,1);
	}
	ds_list_destroy(items); items = -1;
}
global.canLoot = false;
