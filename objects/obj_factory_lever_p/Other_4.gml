event_inherited();

isActive = ds_map_find_value(properties, "IsActive");

with obj_factory_cb_purple {
	if arrayIncludes(other.associatedBeltKeys, cbKey) {
		lever = other;
	}
}