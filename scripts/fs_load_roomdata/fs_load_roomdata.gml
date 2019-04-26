/// fs_load_roomdata(roomDataMap)
/// @param roomDataMap
/// populates obj_room_data.persistentElements 

var sd_roomdatas = argument[0];

// set the temp room data at all room indexes to the save data
var sd_temp_roomdatas = ds_map_secure_load(TEMP_ROOMDATA_FILENAME); // Need to delete this for mem leak
if sd_temp_roomdatas == undefined || !ds_exists(sd_temp_roomdatas, ds_type_map) {
	sd_temp_roomdatas = ds_map_create();
}

var crn = ds_map_find_first(sd_roomdatas); // current room name
for (var i = 0; i < ds_map_size(sd_roomdatas); i++) {
	
	var sd_roomdata = ds_map_find_value(sd_roomdatas, crn);
	var sd_roomdata_copy = ds_map_deep_clone(sd_roomdata);
	
	// obj_room_data will use that when creating its persistentElements property
	var mapToDelete = ds_map_find_value(sd_temp_roomdatas, crn);
	ds_map_delete(sd_temp_roomdatas, crn);
	if mapToDelete != undefined && ds_exists(mapToDelete, ds_type_map) {
		ds_map_destroy(mapToDelete); mapToDelete = -1;
	}
	ds_map_add_map(sd_temp_roomdatas, crn, sd_roomdata_copy);
	
	crn = ds_map_find_next(sd_roomdatas, crn);
}

ds_map_secure_save(sd_temp_roomdatas, TEMP_ROOMDATA_FILENAME);

// force obj_room_data create event so "persistentElements" property is reset
with obj_room_data {
	// This code is leaking one additional map...
	var oldRoomData = persistentElements;
	// replace persistentElements in room data object with updated data s
	// load_roomdata_tempfile should return a map of maps
	var roomName = room_get_name(room);
	var newRoomData = ds_map_deep_clone(ds_map_find_value(sd_temp_roomdatas, roomName));
	persistentElements = newRoomData;
	// prevent memory leak -- destroy oldEnemiesData
	ds_map_destroy(oldRoomData); oldRoomData = -1;
	
	
	// reset each pers ele in the room's persistentProperties to the new one
	var ck = ds_map_find_first(newRoomData);
	for (var i = 0; i < ds_map_size(newRoomData); i++) {
		var propsMap = ds_map_find_value(newRoomData, ck)
		var propsMapProps = ds_map_find_value(propsMap, "Properties");
		with obj_persistent_environment {
			if key == ck {
				var oldP = properties;
				properties = propsMapProps;
				if oldP != undefined && ds_exists(oldP, ds_type_map) {
					ds_map_destroy(oldP); oldP = -1;
				}
			}
		}
		ck = ds_map_find_next(newRoomData, ck);
	}  
	// event_perform(ev_create,0);
}

ds_map_destroy(sd_temp_roomdatas); sd_temp_roomdatas = -1;