/// scr_tony_runaway
/// runs at the end of tony's intro in the Lamplight Factory

global.playerDoNothing = true;

with obj_npc_tony {
	path_end();
	var portal = instance_nearest(x, y, obj_portal);
	var grid = ds_map_find_value(global.grids, 4);
	
	var p = mp_grid_path(grid, path, x, y, 800, 60, true);
	path_start(path, 6, path_action_stop, false);
}