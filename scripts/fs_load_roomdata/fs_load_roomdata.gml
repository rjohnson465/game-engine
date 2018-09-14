/// fs_load_roomdata(roomDataMap)
/// @param roomDataMap
/// populates obj_room_data.persistentElements 

var sd_roomdatas = argument[0];
var rn = room_get_name(room);

// Find the roomdata for the current room
var sd_roomdata = ds_map_find_value(sd_roomdatas, rn);
var sd_roomdata_copy = ds_map_deep_clone(sd_roomdata);
// set the temp room data at room index to this data
var sd_temp_roomdatas = ds_map_secure_load(TEMP_ROOMDATA_FILENAME); // Need to delete this for mem leak
if sd_temp_roomdatas == undefined || !ds_exists(sd_temp_roomdatas, ds_type_map) {
	sd_temp_roomdatas = ds_map_create();
}

// obj_room_data will use that when creating its persistentElements property
ds_map_delete(sd_temp_roomdatas, rn);
ds_map_add_map(sd_temp_roomdatas, rn, sd_roomdata_copy);
ds_map_secure_save(sd_temp_roomdatas, TEMP_ROOMDATA_FILENAME);

// force obj_room_data create event so "persistentElements" property is reset
with obj_room_data {
	event_perform(ev_create,0);
}

ds_map_destroy(sd_temp_roomdatas); sd_temp_roomdatas = -1;