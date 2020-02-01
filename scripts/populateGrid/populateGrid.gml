/// populateGrid(layerId)
/// @param layerId

var layerId = argument[0];

var gm = global.gameManager;
var hcells = room_width div gm.cell_width;
var vcells = room_height div gm.cell_height;
var grid = mp_grid_create(0,0,hcells, vcells, gm.cell_width, gm.cell_height);

// only concern yourself with walls / fountains / solids / combatants in your layer
var solids = ds_list_create();
with obj_enemy_obstacle_parent {
	if object_is_ancestor(object_index,obj_combatant_parent) continue;
	if object_is_ancestor(object_index, obj_door) && isOpen continue;
	else {
		if object_index == obj_fountain && origLayer == layerId {
			ds_list_add(solids,id);
		}
		else if abs(depth - layer_get_depth(layerId)) <= 10 {
			ds_list_add(solids,id);
		}
		else if layer == layerId || isObstacleLayerless {
			ds_list_add(solids,id);
		}
	}
}

with obj_fallzone {
	if layer == layerId {
		ds_list_add(solids, id);
	}
}

// add all solids to grid
for (var i = 0; i < ds_list_size(solids); i++) {
	mp_grid_add_instances(grid,ds_list_find_value(solids,i), true); 
}

// now, clear any cells touched by a bridge
with obj_bridge_parent {
	if origLayer == layerId && freesGridCells {
		mp_grid_clear_rectangle(grid, bbox_left, bbox_top, bbox_right, bbox_bottom);
	}
}

ds_list_destroy(solids); solids = -1;

return grid;