/// fs_save_enemies
/// returns a map of all the persistent enemy data in the game
/// though there should only ever be one room data object at a time

// if there is already some enemydata saved, use that map (so we're only appending to it, rather than creating)
var save_data = ds_map_secure_load(global.gameManager.currentSaveFile); // Need to destroy this to prevent mem leak
var sd_enemydatas = noone;
if ds_exists(save_data,ds_type_map) {
	var enemies_data = ds_map_find_value(save_data,"Enemies");
	if enemies_data != undefined && ds_exists(enemies_data,ds_type_map) {
		sd_enemydatas = ds_map_deep_clone(enemies_data);
		ds_map_destroy(enemies_data); enemies_data = -1; // mem leak
	} 
} 

if !ds_exists(sd_enemydatas, ds_type_map) sd_enemydatas = ds_map_create();

// force a save of the temp enemydata
var rd = instance_nearest(x, y, obj_room_data);
with rd {
	fs_save_enemydata_tempfile();
}

if save_data != undefined && ds_exists(save_data, ds_type_map) {
	ds_map_destroy(save_data); save_data = -1;
}

// integrate the temp enemy data contents with the saved enemy data contents
// iterate through temp enemy contents and replace each entry in saved enemy data contents with it
var sd_temp_enemydatas = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME); // Need to destroy this to prevent a memory leak
var cri = ds_map_find_first(sd_temp_enemydatas); // current room index
for (var i = 0 ; i < ds_map_size(sd_temp_enemydatas); i++) {
	var sd_temp_enemy_data = ds_map_find_value(sd_temp_enemydatas, cri);
	
	ds_map_delete(sd_enemydatas, cri);
	var sd_temp_enemy_data_copy = ds_map_deep_clone(sd_temp_enemy_data);
	ds_map_add_map(sd_enemydatas, cri, sd_temp_enemy_data_copy);
	
	//ds_map_destroy(sd_temp_enemy_data); sd_temp_enemy_data = -1;
	
	cri = ds_map_find_next(sd_temp_enemydatas, cri);
}

// sd_enemydatas should be the only ds to survive this shit
ds_map_destroy(sd_temp_enemydatas); sd_temp_enemydatas = -1;

return sd_enemydatas;