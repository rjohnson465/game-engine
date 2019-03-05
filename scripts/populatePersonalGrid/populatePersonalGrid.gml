/// populatePersonalGrid()

var floorNum = getLayerFloorNumber(layer);
personalGrid = ds_map_find_value(global.grids, floorNum);

/// for enemies -- repopulates personalGrid with obstacles 
/*
mp_grid_clear_all(personalGrid);
// only concern yourself with walls / fountains / solids / combatants in your layer
var solids = ds_list_create();
var myLayer = layer;
var idd = id;
with obj_enemy_obstacle_parent {
	if object_is_ancestor(object_index,obj_combatant_parent) continue;
	if object_is_ancestor(object_index, obj_door) && isOpen continue;
	else {
		if object_index == obj_fountain && origLayer == myLayer {
			ds_list_add(solids,id);
		}
		else if abs(depth - layer_get_depth(myLayer)) <= 10 {
			ds_list_add(solids,id);
		}
		else if layer == myLayer || isObstacleLayerless {
			ds_list_add(solids,id);
		}
	}
}

with obj_fallzone {
	if layer == myLayer {
		ds_list_add(solids, id);
	}
}

for (var i = 0; i < ds_list_size(solids); i++) {
	mp_grid_add_instances(personalGrid,ds_list_find_value(solids,i),1);
}

ds_list_destroy(solids); solids = -1;