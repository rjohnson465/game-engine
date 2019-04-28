var listsCount = 0;
for (var i = 0; i < 100000; i++) {
	var list = i;
	if (ds_exists(list, ds_type_list)) {
		listsCount++;

		for (var j = 0; j < ds_list_size(list); j++) {
			var val = ds_list_find_value(list, j);
			 show_debug_message("list" + string(i) + " at key " + string(j) + ": " + string(val));

		}
		if ds_list_size(list) == 0 {
			show_debug_message("list" + string(i) + " exists but is empty");
		}
	}
}
show_debug_message("Total lists: " + string(listsCount));
		


/*var i = 0;
with all {
	var objName = object_get_name(object_index);
	show_debug_message("Obj " + string(i) + objName);
	i++;
}

/*
var mapsCount = 0;
for (var i = 0; i < 100000; i++) {
	var map = i;
	if (ds_exists(map, ds_type_map)) {
		mapsCount++;
		var ck = ds_map_find_first(map);
		for (var j = 0; j < ds_map_size(map); j++) {
			var val = ds_map_find_value(map, ck);
		show_debug_message("map" + string(i) + " at key " + string(ck) + ": " + string(val));
			ck = ds_map_find_next(map, ck);
		}
		if ds_map_size(map) == 0 {
			show_debug_message("map " + string(i) + " exists but is empty");
		}
	}
}
		
		
show_debug_message("total maps: " + string(mapsCount));