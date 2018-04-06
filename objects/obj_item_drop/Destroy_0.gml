part_type_destroy(particle);
part_emitter_destroy(system,emitter);
part_system_destroy(system);
instance_destroy(lightRadius);

// destroy any items you hold still
for (var i = 0; i < ds_list_size(items); i++) {
	var item = ds_list_find_value(items,i);
	instance_destroy(item,1);
}

ds_list_destroy(items);

with obj_room_data {
	if roomIndex == room {
		ds_list_delete(itemDropsData,other.itemDropData);
	}
}