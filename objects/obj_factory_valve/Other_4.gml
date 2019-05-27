event_inherited();

isActive = ds_map_find_value(properties, "IsActive");

with obj_factory_pipe {
	if arrayIncludes(other.associatedPipeKeys, pKey) {
		valve = other;
	}
}