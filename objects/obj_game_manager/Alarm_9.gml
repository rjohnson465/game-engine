/// @description Insert description here
// You can write your code in this editor

room_goto(room);

// debug shit
		var mapsCount = 0;
		for (var i = 0; i < 100000; i++) {
			var map = i;
			if (ds_exists(map, ds_type_map)) {
				mapsCount++;
				var ck = ds_map_find_first(map);
				for (var j = 0; j < ds_map_size(map); j++) {
					var val = ds_map_find_value(map, ck);
					//show_debug_message("map" + string(i) + " at key " + string(ck) + ": " + string(val));
					ck = ds_map_find_next(map, ck);
				}
			}
		}
		show_debug_message("Total maps: " + string(mapsCount));

		var listsCount = 0;
		for (var i = 0; i < 100000; i++) {
			var list = i;
			if (ds_exists(list, ds_type_list)) {
				listsCount++;

				for (var j = 0; j < ds_list_size(list); j++) {
					var val = ds_list_find_value(list, j);
					// show_debug_message("list" + string(i) + " at key " + string(j) + ": " + string(val));

				}
			}
		}
		show_debug_message("Total lists: " + string(listsCount));

		var instancesCount = 0;
		with all {
	
			instancesCount++;
		}
		show_debug_message("Total instances: " + string(instancesCount));