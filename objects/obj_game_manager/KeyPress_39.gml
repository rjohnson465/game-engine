/// @description Insert description here
// You can write your code in this editor

/*
if ds_exists(105, ds_type_map) {
	var a = 105;
	var b = 3;
}*/

// leaky af
//loadGame();

/*
var p = global.player;
p.layerToMoveTo = "instances_floor_1";
room_goto(room);
*/

// debug shit
		var mapsCount = 0;
		for (var i = 0; i < 100000; i++) {
			var map = i;
			if (ds_exists(map, ds_type_map)) {
				mapsCount++;
				var ck = ds_map_find_first(map);
				for (var j = 0; j < ds_map_size(map); j++) {
					var val = ds_map_find_value(map, ck);
					// show_debug_message("map" + string(i) + " at key " + string(ck) + ": " + string(val));
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
		
		var audioEmittersCount = 0;
		for (var i = 0; i < 100000; i++) {
			var emi = i;
			if (audio_emitter_exists(emi)) {
				audioEmittersCount++;
			}
		}
		show_debug_message("Total audio emitters: " + string(audioEmittersCount));
		
		var particlesCount = 0;
		for (var i = 0; i < 100000; i++) {
			var part = i;
			if (part_type_exists(part)) {
				particlesCount++;
			}
		}
	    show_debug_message("Total part types: " + string(particlesCount));
		
		var partSysCount = 0;
		for (var i = 0; i < 100000; i++) {
			var ps = i;
			if (part_system_exists(ps)) {
				partSysCount++;
			}
		}
		show_debug_message("Total part systems: " + string(partSysCount));
		

		var instancesCount = 0;
		with all {
	
			instancesCount++;
		}
		//show_debug_message("Total instances: " + string(instancesCount));

		with all {
			if instancesCount > 1000 {
				var name = object_get_name(object_index);
				show_debug_message(name);
			}
		}


/*with obj_fountain {
	wishAtFountain();
}*/

// No mem leak (maps checked)
// respawnEnemies();

// No memeory leak
// fs_save_roomdata_tempfile();

// No mem leak
// fs_save_enemydata_tempfile();


