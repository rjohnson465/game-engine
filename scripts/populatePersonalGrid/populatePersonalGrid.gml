/// populatePersonalGrid()

/// for enemies -- repopulates personalGrid with obstacles 

mp_grid_clear_all(personalGrid);
// only concern yourself with walls / fountains / solids / combatants in your layer
var solids = ds_list_create();
var myLayer = layer;
var idd = id;
with obj_enemy_obstacle_parent {
	if object_is_ancestor(object_index,obj_combatant_parent) continue;
	else {
		if layer == myLayer {
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
ds_list_destroy(combatants);
ds_list_destroy(solids);