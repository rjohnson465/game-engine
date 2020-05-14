/// scr_abominiongate_roomstart

instance_activate_object(obj_enemy_abominion);

with obj_enemy_abominion {
	event_perform(ev_other, ev_room_start);
	if variable_instance_exists(id, "eventKey") && arrayIncludes(other.eventKeys, eventKey) && hp <= 0 {
		other.enemiesLeft--;
	}
}

if enemiesLeft == 0 {
	// clear grid cells this object used to occupy
	var grid = ds_map_find_value(global.grids, getLayerFloorNumber(layer));
	mp_grid_clear_rectangle(grid, bbox_left, bbox_top, bbox_right, bbox_bottom);
	isUntraversable = false;
}
