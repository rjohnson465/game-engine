/// @description Insert description here
// You can write your code in this editor

/*
if ds_exists(105, ds_type_map) {
	var a = 105;
	var b = 3;
}*/

/*

var a = fs_load_roomdata_tempfile(room_get_name(room));
if a >= 0 {
	ds_map_destroy(a); a = -1;
}

// maps
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


/*
// audio emitters
var aeCount = 0;
for (var i = 0; i < 10000; i++) {
	var ae = i;
	if (audio_emitter_exists(ae)) {
		aeCount++
	}
}

show_debug_message("Total audio emitters: " + string(aeCount));

*/

/*

// particles
var pCount = 0;
for (var i = 0; i < 10000; i++) {
	var p = i;
	if (part_type_exists(p)) {
		pCount++
	}
}

var psCount = 0;
for (var i = 0; i < 10000; i++) {
	var ps = i;
	if (part_system_exists(ps)) {
		psCount++
	}
}

show_debug_message("Total part types: " + string(pCount));
show_debug_message("Total part systems: " + string(psCount));

*/

// leaky af
//loadGame();



