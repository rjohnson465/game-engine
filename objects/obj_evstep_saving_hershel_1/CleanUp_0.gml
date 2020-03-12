/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(ghostsSpawnedList, ds_type_list) {
	
	// if there are any ghost still alive, make sure they aggro
	for (var i = 0; i < ds_list_size(ghostsSpawnedList); i++) {
		var g = ds_list_find_value(ghostsSpawnedList, i);
		if instance_exists(g) {
			g.isAggroed = true;
			g.lockOnTarget = global.player;
			with g {
				maybeAggro();
			}
		}
	}
	
	ds_list_destroy(ghostsSpawnedList); ghostsSpawnedList = -1;
}