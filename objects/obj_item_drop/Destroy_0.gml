part_type_destroy(particle);
part_emitter_destroy(system,emitter);
part_system_destroy(system);
instance_destroy(lightRadius);

// destroy any items you hold still 
if ds_exists(items,ds_type_list) {
	for (var i = 0; i < ds_list_size(items); i++) {
		var item = ds_list_find_value(items,i);
		instance_destroy(item,1);
	}
	ds_list_destroy(items); items = -1;
}
global.canLoot = false;
