/// fs_load_enemies(enemyDataMap)
/// @param enemyDataMap
/// populates obj_room_data.enemiesData 

var sd_enemydatas = argument[0];

var rn = room_get_name(room);

// Find the enemydata for the current room in saved file data
var sd_enemydata = ds_map_find_value(sd_enemydatas, rn);
var sd_enemydata_copy = ds_map_deep_clone(sd_enemydata);
// set the temp enemy data at room index to this data
var sd_temp_enemydatas = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME); // Need to destroy this for mem leak
if sd_temp_enemydatas == undefined || !ds_exists(sd_temp_enemydatas, ds_type_map) {
	sd_temp_enemydatas = ds_map_create();
}

// obj_room_data will use that when creating its enemiesData property
ds_map_delete(sd_temp_enemydatas, rn);
ds_map_add_map(sd_temp_enemydatas, rn, sd_enemydata_copy);
ds_map_secure_save(sd_temp_enemydatas, TEMP_ENEMYDATA_FILENAME);

// force obj_room_data create event so "enemiesData" property is reset
with obj_room_data {
	event_perform(ev_create,0);
}

ds_map_destroy(sd_temp_enemydatas); sd_temp_enemydatas = -1;

