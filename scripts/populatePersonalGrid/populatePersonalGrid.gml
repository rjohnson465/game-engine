/// populatePersonalGrid()

/// for enemies -- repopulates personalGrid with obstacles 

mp_grid_clear_all(personalGrid);
var solids = ds_list_create();
// if on stairs, only concern yourself with "stair blockers"
if place_meeting_layer(x,y,obj_enemy_stairs) {
	with obj_stair_wall {
		if layer == other.layer {
			ds_list_add(solids,id);
		}
	}
	//if !isDescendingStairs {
		with obj_stair_wall_top {
			if layer == other.layer {
				ds_list_add(solids,id);
			}
		}
	//}
	for (var i = 0; i < ds_list_size(solids); i++) {
		mp_grid_add_instances(personalGrid,ds_list_find_value(solids,i),true);
	}
} else {
	// only concern yourself with walls / fountains / solids / combatants in your layer
	
	var myLayer = layer;
	var idd = id;
	with obj_enemy_obstacle_parent {
		if object_is_ancestor(object_index,obj_combatant_parent) continue;
		else {
			if object_index == obj_fountain && origLayer == myLayer {
				ds_list_add(solids,id);
			} else if layer == myLayer {
				ds_list_add(solids,id);
			}
		}
	}
	for (var i = 0; i < ds_list_size(solids); i++) {
		mp_grid_add_instances(personalGrid,ds_list_find_value(solids,i),true);
	}
	
	var combatants = script_execute(scr_get_ids_region,obj_combatant_parent,0,0,room_width,room_height);
	for (var i = 0; i < ds_list_size(combatants); i++) {
		var ci = ds_list_find_value(combatants,i);
		if ci != id && ci != global.player.id && ci.solid {
			mp_grid_add_instances(personalGrid,ds_list_find_value(combatants,i),true);
		} 
	}
	ds_list_destroy(combatants); combatants = -1;
	ds_list_destroy(solids); solids = -1;
}