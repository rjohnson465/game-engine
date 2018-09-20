/*
// load in from temporary room data file, not save file
persistentElements = fs_load_roomdata_tempfile(roomName);

// if there is no data for this room saved, we have to build our own 
if persistentElements == noone {
	persistentElements = ds_map_create();
	with obj_persistent_environment {
		var el_map = ds_map_create();
		ds_map_replace(el_map, "ObjectIndexName", object_get_name(object_index));
		ds_map_replace(el_map, "PostX", postX);
		ds_map_replace(el_map, "PostY", postY);
		ds_map_add_map(el_map, "Properties", properties);
		ds_map_add_map(other.persistentElements, key, el_map);
	}
}

// ditto for enemies data
enemiesData = fs_load_enemydata_tempfile(roomName);
if enemiesData == noone {
	enemiesData = ds_map_create();
	with obj_enemy_parent {
		ds_map_add_map(other.enemiesData, key, persistentProperties);
		var map = ds_map_find_value(other.enemiesData, key);
		// hp and maxHp init values must be recorded here, otherwise they're always 35 
		// since thats the default base enemy class values, and persistentProperties map is 
		// populated at the end of the Create Event of the base enemy class
		ds_map_replace(map, "Hp", hp);
		ds_map_replace(map, "MaxHp", maxHp); 
	}
}

// now that all the persistent elements have their data either set or created, ensure their room start event fires after
with obj_persistent_environment {
	event_perform(ev_other,ev_room_start);
}

// ditto for enemies...
with obj_enemy_parent {
	event_perform(ev_other, ev_room_start);
}