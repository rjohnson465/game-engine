var listsCount = 0;
for (var i = 0; i < 100000; i++) {
	var list = i;
	if (ds_exists(list, ds_type_list)) {
		listsCount++;

		if ds_list_size(list) {
			show_debug_message("List " + string(i) + " exists but is empty");
		}
				
				
		for (var j = 0; j < ds_list_size(list); j++) {
			var val = ds_list_find_value(list, j);
			show_debug_message("list" + string(i) + " at key " + string(j) + ": " + string(val));
		}
	}
}
show_debug_message("Total lists: " + string(listsCount));