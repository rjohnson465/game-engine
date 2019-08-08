event_inherited();

if !isOpen {
	isOpen = ds_map_find_value(properties, "IsOpen");
}

if isOpen {
	sprite_index = spr_ww_snowtunnel_open;
}