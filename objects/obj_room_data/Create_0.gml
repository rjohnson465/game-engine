roomIndex = string(room);

// this stores fountains, doors, chests, etc... 
// kvp -> <key, data_obj>
persistentElements = ds_map_create();

with obj_persistent_environment_data_parent {
	if roomIndex == other.roomIndex {
		ds_map_replace(other.persistentElements, key, id);
	}
}