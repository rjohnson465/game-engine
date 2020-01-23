var questNum = instance_number(obj_quest_savingtheholidays);
if questNum > 0 {
	instance_destroy(id, 1); exit;
}
if performCutscene {
	global.isInteractingWithNpc = true;
	var tony = instance_create_layer(5000, 773, layer_get_id("instances_floor_1"), obj_npc_tony);
	tony.isInteractable = false;
	// set tony on his path, faster than player
	// var grid = ds_map_find_value(global.grids, getLayerFloorNumber(global.player.layer));
	// var tpath = mp_grid_path(grid, tony.path, tony.x, tony.y, 4768, 574, true);
	// path_start(tpath, 7, path_action_continue, false);
	var cg = instance_nearest(x, y, obj_npc_casinoguard);
	var tpath = mp_potential_path(tony.path, cg.x, cg.y, 7, 4, 0);
	with tony {
		path_start(path, 7, path_action_stop, true);
	}
	setTonysPath = true;
	
	// set player on tony's path, slightly less fast than tony
	with obj_player {
		var p = mp_potential_path(path, cg.x, cg.y, 4, 4, false);
		path_start(p, 5, path_action_stop, true);
	}
}