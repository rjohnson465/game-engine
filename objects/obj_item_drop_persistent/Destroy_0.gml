if part_type_exists(particle) {
	part_type_destroy(particle); particle = -1;
}
if part_emitter_exists(system, emitter) {
	part_emitter_destroy(system,emitter); emitter = -1;
}
if part_system_exists(system) {
	part_system_destroy(system); system = -1;
}
if instance_exists(lightRadius) {
	instance_destroy(lightRadius); lightRadius = -1;
}

removeFromInteractablesList();
global.player.interactableResetFrame = 5;

// destroy any items you hold still 
if ds_exists(items,ds_type_list) {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		if item != undefined && item >= 0 && instance_exists(item) {
			instance_destroy(item, 1); item = -1;
		}
	}
	ds_list_destroy(items); items = -1;
}
global.canLoot = false;
