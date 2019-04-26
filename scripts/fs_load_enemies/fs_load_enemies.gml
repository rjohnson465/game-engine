/// fs_load_enemies(enemyDataMap)
/// @param enemyDataMap
/// populates obj_room_data.enemiesData 

var sd_enemydatas = argument[0];

// set the temp enemy data at all room indexes to this data
var sd_temp_enemydatas = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME); // Need to destroy this for mem leak
if sd_temp_enemydatas == undefined || !ds_exists(sd_temp_enemydatas, ds_type_map) {
	sd_temp_enemydatas = ds_map_create();
}

var crn = ds_map_find_first(sd_enemydatas);
for (var i = 0; i < ds_map_size(sd_enemydatas); i++) {
	// Find the enemydata for the crn in saved file data
	var sd_enemydata = ds_map_find_value(sd_enemydatas, crn);
	var sd_enemydata_copy = ds_map_deep_clone(sd_enemydata);
	
	// obj_room_data will use that when creating its enemiesData property
	var mapToDelete = ds_map_find_value(sd_temp_enemydatas, crn);
	ds_map_delete(sd_temp_enemydatas, crn);
	if mapToDelete != undefined && ds_exists(mapToDelete, ds_type_map) {
		ds_map_destroy(mapToDelete); mapToDelete = -1;
	}
	
	ds_map_add_map(sd_temp_enemydatas, crn, sd_enemydata_copy);
	
}

ds_map_secure_save(sd_temp_enemydatas, TEMP_ENEMYDATA_FILENAME);

// force obj_room_data create event so "enemiesData" property is reset
with obj_room_data {
	
	var oldEnemiesData = enemiesData;
	// replace enemiesData in room data object with updated data 
	// load_enemydata_tempfile should return a map of maps
	var roomName = room_get_name(room);
	var newEnemiesData = fs_load_enemydata_tempfile(roomName);
	enemiesData = newEnemiesData;
	// prevent memory leak -- destroy oldEnemiesData
	ds_map_destroy(oldEnemiesData); oldEnemiesData = -1;
	
	
	// reset each enemy in the room's persistentProperties to the new one
	var ck = ds_map_find_first(newEnemiesData);
	for (var i = 0; i < ds_map_size(newEnemiesData); i++) {
		var propsMap = ds_map_find_value(newEnemiesData, ck)
		with obj_enemy_parent {
			if key == ck {
				var oldPP = persistentProperties;
				persistentProperties = propsMap;
				if ds_exists(oldPP, ds_type_map) {
					ds_map_destroy(oldPP); oldPP = -1;
				}
			}
		}
		ck = ds_map_find_next(newEnemiesData, ck);
	}   
	
	// event_perform(ev_create,0);
} 

ds_map_destroy(sd_temp_enemydatas); sd_temp_enemydatas = -1;

