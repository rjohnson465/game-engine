roomIndex = string(room);
roomName = room_get_name(room);

// this stores fountains, doors, chests, etc... 
// kvp -> <key, data_obj>
persistentElements = noone;

// load in from temporary room data file, not save file
persistentElements = fs_load_roomdata_tempfile(roomIndex);

// if there is no data for this room saved, we have to build our own 
if persistentElements == noone {
	// create persistent data objects for every persistent element in the room
	persistentElements = ds_map_create();
	// TODO create an entry in persistentElements map for each persistent element in the room
	// NO MORE DATA OBJECTS
	with obj_persistent_environment {
		/*global.el = id;
		var dataObj = instance_create_depth(x,y,1,obj_persistent_environment_data_parent);
		ds_map_replace(other.persistentElements,dataObj.key,dataObj);
		data = dataObj;*/
		var el_map = ds_map_create();
		ds_map_replace(el_map, "ObjectIndexName", object_get_name(object_index));
		ds_map_replace(el_map, "PostX", postX);
		ds_map_replace(el_map, "PostY", postY);
		ds_map_add_map(el_map, "Properties", properties);
		ds_map_add_map(other.persistentElements, key, el_map);
	}
}

// now that all the persistent elements have their data either set or created, ensure their room start event fires after
with obj_persistent_environment {
	event_perform(ev_other,ev_room_start);
}