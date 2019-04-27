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