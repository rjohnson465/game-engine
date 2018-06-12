/// fs_save_roomdata
/// returns a map of all the fountain data in the game
//var sd_fountains = ds_map_create();
var sd_roomdatas = ds_map_create();

// save all persistent room elements
with obj_room_data {
	var sd_roomdata = ds_map_create();
	
	var ck = ds_map_find_first(persistentElements);
	for (var i = 0; i < ds_map_size(persistentElements); i++) {
	
		var el = ds_map_find_value(persistentElements, ck);
		var sd_el_map = ds_map_create();
		
		// get the object index name -- used to instantiate data object on load
		var ky  = object_get_name(el.object_index);
		
		ds_map_replace(sd_el_map, "ObjectIndexName", ky);
		
		// el is guaranteed to have postX / postY
		ds_map_replace(sd_el_map, "PostX", el.postX);
		ds_map_replace(sd_el_map, "PostY", el.postY);
		
		// save all properties of el
		ds_map_add_map(sd_el_map, "Properties", el.properties);
		/*var ckk = ds_map_find_first(properties);
		for (var j = 0; j < ds_map_size(properties); j++) {
			
			var val = ds_map_find_value(properties, ckk);
			
			ckk = ds_map_find_next(properties, ckk);
		}*/
		
		ck = ds_map_find_next(persistentElements, ck);
		ds_map_add_map(sd_roomdata,el.key,sd_el_map);
	}
	ds_map_add_map(sd_roomdatas,roomIndex,sd_roomdata);
}

return sd_roomdatas;