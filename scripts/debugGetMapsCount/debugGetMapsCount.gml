/// getMapCount(printall*)
/// @param printall*

// debug helper function

var printAll = false;
if argument_count > 0 {
	printAll = argument[0];
}

var mapCount = 0;
for (var i = 0; i < 100000; i++) {
	var map = i;
	if (ds_exists(map, ds_type_map)) {
		mapCount++;
		var ck = ds_map_find_first(map);
		for (var j = 0; j < ds_map_size(map); j++) {
			var val = ds_map_find_value(map, ck);
			if printAll {
				show_debug_message("map" + string(i) + " at key " + string(ck) + ": " + string(val));
			}
			ck = ds_map_find_next(map, ck);
		}
	}
}

return mapCount;