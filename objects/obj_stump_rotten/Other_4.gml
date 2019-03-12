
event_inherited();
isFallen = ds_map_find_value(properties, "isFallen");
if isFallen {
	global.bridgeSpriteIndex = spr_stump_rotten_fallen;
	instance_change(obj_bridge_parent, 1);
	light_destroy_caster_layer(getLayerFloorNumber(origLayer));
	// populateGrids();
} 
