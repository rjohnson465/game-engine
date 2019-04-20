/// populateGrids()

// whenever a room starts, 1 - num floors grids are generated in global variables stored in global.grids map

// we need to activate all solid environment objects in the room for a moment
// solid environment objects outside view may be deactivated again later in the deactivation loop game manager runs

//instance_activate_object(obj_solid_environment);


// maybe clear the old grids in memory
var gridsMap = global.grids;
var ck = ds_map_find_first(gridsMap);
for (var i = 0; i < ds_map_size(gridsMap); i++) {
	
	// destroy all the old grids
	var grid = ds_map_find_value(gridsMap, ck);
	mp_grid_destroy(grid); grid = -1;
	
	ck = ds_map_find_next(gridsMap, ck);
}

// clear grids maps
ds_map_clear(gridsMap);

// build a grid for each layer in the room
var layers  = layer_get_all();
for (var i = 0; i < array_length_1d(layers); i++;) {
	var layerId = layers[i];
	var layerName = layer_get_name(layerId);
	
	// make sure its an instance layer
	if string_pos("instances_floor_", layerName) != 0 {
		var floorNum = getLayerFloorNumber(layerId);
		var grid = populateGrid(layerId);
		ds_map_replace(gridsMap, floorNum, grid);
	}
}

global.grids = gridsMap;