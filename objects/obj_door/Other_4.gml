
event_inherited();
isOpen = ds_map_find_value(properties, "isOpen");
if isOpen {
	
	// clear grid cells this object used to occupy
	var grid = ds_map_find_value(global.grids, getLayerFloorNumber(layer));
	mp_grid_clear_rectangle(grid, bbox_left, bbox_top, bbox_right, bbox_bottom);
	
	sprite_index = noone;
	light_destroy_caster_layer(getLayerFloorNumber(layer));
	
} 
