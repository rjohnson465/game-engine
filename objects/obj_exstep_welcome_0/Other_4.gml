with exercise {
	event_inherited();
	isFinished = ds_map_find_value(properties, "isFinished");
	
	if isFinished {
		global.isTrading = false;
	}
}