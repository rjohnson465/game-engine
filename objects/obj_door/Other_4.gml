
event_inherited();
isOpen = ds_map_find_value(properties, "isOpen");
if isOpen {
	sprite_index = noone;
	light_destroy_caster_layer(getLayerFloorNumber(layer));
	populateGrids();
	/*with obj_combatant_parent {
		//populatePersonalGrid();
		
	}*/
} 
