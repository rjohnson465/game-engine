/// fs_save_roomdata
/// returns a map of all the persistent room data in the game
/// though there should only ever be one room data object at a time

// if there is already some roomdata saved, use that map (so we're only appending to it, rather than creating)
var save_data = ds_map_secure_load(global.gameManager.currentSaveFile);
var sd_roomdatas = noone;
var useLoadedData = true;
if ds_exists(save_data,ds_type_map) {
	var rooms_data = ds_map_find_value(save_data,"RoomData");
	if ds_exists(rooms_data,ds_type_map) {
		sd_roomdatas = rooms_data;
	} else useLoadedData = false;
} else useLoadedData = false;

// this should only be the case if we're in the first room and we've never saved before
if !useLoadedData sd_roomdatas = ds_map_create();

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
		
		ck = ds_map_find_next(persistentElements, ck);
		
		// delete the current entry (if it exists) and replace it 
		if ds_map_find_value(sd_roomdata,el.key) != undefined {
			ds_map_delete(sd_roomdata,el.key);
		}
		
		ds_map_add_map(sd_roomdata,el.key,sd_el_map);
	}
	
	// delete the current entry (if it exists) and replace it 
	if ds_map_find_value(sd_roomdatas,roomIndex) != undefined {
		ds_map_delete(sd_roomdatas,roomIndex);
	}
	
	ds_map_add_map(sd_roomdatas,roomIndex,sd_roomdata);
}

return sd_roomdatas;