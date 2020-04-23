event_inherited();

if !isFed {
	isFed = ds_map_find_value(properties, "IsFed");
}

if isFed == undefined {
	isFed = false;
}