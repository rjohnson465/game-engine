// re-spawn all enemies in all maps
// TODO - do not respawn bosses? MAYBE?

var rd = instance_nearest(x,y,obj_room_data);

with rd {
	fs_save_enemydata_tempfile();
}

var sd_temp_enemies_rooms = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME);
var rn = ds_map_find_first(sd_temp_enemies_rooms);
for (var i = 0; i < ds_map_size(sd_temp_enemies_rooms); i++) {
	var sd_temp_enemies_room = ds_map_find_value(sd_temp_enemies_rooms, rn);
	
	var ek = ds_map_find_first(sd_temp_enemies_room); // enemy key
	for (var j = 0; j < ds_map_size(sd_temp_enemies_room); j++) {
		var sd_temp_enemy = ds_map_find_value(sd_temp_enemies_room, ek);
		
		var postX = ds_map_find_value(sd_temp_enemy, "PostX");
		var postY = ds_map_find_value(sd_temp_enemy, "PostY");
		var postZ = ds_map_find_value(sd_temp_enemy, "PostZ");
		var fdStart = ds_map_find_value(sd_temp_enemy, "FacingDirectionStart");
		var hpMax = ds_map_find_value(sd_temp_enemy, "MaxHp");
		
		ds_map_replace(sd_temp_enemy,"CurrentX",postX);
		ds_map_replace(sd_temp_enemy,"CurrentY",postY);
		ds_map_replace(sd_temp_enemy,"TempPostX",postX);
		ds_map_replace(sd_temp_enemy,"TempPostY",postX);
		ds_map_replace(sd_temp_enemy,"FacingDirection",fdStart);
		ds_map_replace(sd_temp_enemy,"Hp",hpMax);
		ds_map_replace(sd_temp_enemy,"IsAlive",true);
		
		ek = ds_map_find_next(sd_temp_enemies_room, ek);
	}
	
	rn = ds_map_find_next(sd_temp_enemies_rooms, rn);
}

ds_map_secure_save(sd_temp_enemies_rooms, TEMP_ENEMYDATA_FILENAME);

// force save for room data object
with rd {
	event_perform(ev_create, 0);
}

// force room restart event for all enemies
with obj_enemy_parent {
	event_perform(ev_other, ev_room_start);
}

ds_map_destroy(sd_temp_enemies_rooms); sd_temp_enemies_rooms = -1;