/// scr_tony_runaway
/// runs at the end of tony's intro in the Lamplight Factory

with obj_npc_tony {
	path_end();
	var grid = ds_map_find_value(global.grids, 4);
	
	mp_grid_path(grid, path, x, y, 800, 60, true);
	path_start(path, 12, path_action_stop, false);
}