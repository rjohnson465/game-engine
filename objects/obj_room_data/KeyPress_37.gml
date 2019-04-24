/// @description Insert description here
// You can write your code in this editor

// leaky af
respawnEnemies();

// No memeory leak
// fs_save_roomdata_tempfile();

// No mem leak
// fs_save_enemydata_tempfile();

var mapsCount = 0;
for (var i = 0; i < 300; i++) {
	var map = i;
	if (ds_exists(map, ds_type_map)) {
		mapsCount++;
		var ck = ds_map_find_first(map);
		for (var j = 0; j < ds_map_size(map); j++) {
			var val = ds_map_find_value(map, ck);
			show_debug_message("map" + string(i) + " at key " + string(j) + ": " + string(val));
			ck = ds_map_find_next(map, ck);
		}
	}
}

show_debug_message("Total maps: " + string(mapsCount));