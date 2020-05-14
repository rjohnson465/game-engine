/// scr_abominiongate_check(arr)
/// @param arr

var arr = argument[0];
var victim = arr[0];

if victim.object_index == obj_enemy_abominion && variable_instance_exists(victim, "eventKey") && arrayIncludes(eventKeys, victim.eventKey) {
	enemiesLeft--;
}

if enemiesLeft == 0 {
	// clear grid cells this object used to occupy
	var grid = ds_map_find_value(global.grids, getLayerFloorNumber(layer));
	mp_grid_clear_rectangle(grid, bbox_left, bbox_top, bbox_right, bbox_bottom);
	isUntraversable = false;
}
