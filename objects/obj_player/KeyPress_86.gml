/// @description Insert description here
// You can write your code in this editor

var listCount1 = ds_list_create();
var m1 = ds_map_create();

var nearestFountain = instance_nearest(x,y,obj_fountain);
if lastFountainRoom == noone {
				
	//lastFountain = nearestFountain;
	lastFountainRoom = room_get_name(asset_get_index(nearestFountain.nativeRoom));
	lastFountainX = nearestFountain.spawnX;
	lastFountainY = nearestFountain.spawnY;
	lastFountainZ = nearestFountain.layerName;
				
}
var rm = asset_get_index(lastFountainRoom);
//room = lastFountainRoom;
room_goto(rm);
x = lastFountainX;
y = lastFountainY;
xpTemp = 0;
				
layerToMoveTo = lastFountainZ;
justRevivedAtFountain = true;

/*
var listCount2 = ds_list_create();
var m2 = ds_map_create();

show_debug_message("lists: " + string(listCount1) + ", " + string(listCount2));
show_debug_message("maps:" + string(m1) + ", " + string(m2));

for (var i = listCount1; i < listCount2; i++) {
	var list = i;
	if (ds_exists(list, ds_type_list)) {
		for (var j = 0; j < ds_list_size(list); j++) {
			var val = ds_list_find_value(list, j);
			show_debug_message("list" + string(i) + " at pos " + string(j) + ": " + string(val));
		}
	}
}

for (var i = m1; i < m2; i++) {
	var map = i;
	if (ds_exists(map, ds_type_map)) {
		var ck = ds_map_find_first(map);
		for (var j = 0; j < ds_map_size(map); j++) {
			var val = ds_map_find_value(map, ck);
			show_debug_message("map" + string(i) + " at key " + string(j) + ": " + string(val));
			ck = ds_map_find_next(map, ck);
		}
	}
}

show_debug_message(instance_number(all));

ds_list_destroy(listCount1); listCount1 = -1;
ds_list_destroy(listCount2); listCount2 = -1;
ds_map_destroy(m1); m1 = -1;
ds_map_destroy(m2); m2 = -1;