event_inherited();
selectedItem = ds_list_find_value(items,0);
isLooted = ds_map_find_value(properties, "isLooted");
if isLooted {
	for (var i = 0; i < ds_list_size(items); i++) {
		var it = ds_list_find_value(items, i);
		instance_destroy(it,1);
	}
	ds_list_clear(items);
	x = -1000; y = -1000;
} else {
	for (var i = 0; i < ds_list_size(items); i++) {
		var it = ds_list_find_value(items, i);
		it.itemDropObj = id;
		
		// items in item persistent are created on room start so theres no need for them to persist
		// between rooms
		it.persistent = false;
	}
}
