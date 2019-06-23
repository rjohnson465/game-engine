/// respawnEnemies(onlyBosses)
/// @param onlyBosses*
// re-spawn all enemies in all maps
// TODO - do not respawn bosses? MAYBE?

// we need to activate all the enemy objects in the room for a moment to respawn them
// they may later be deactivated by the deactivation loop run in game manager
// instance_activate_object(obj_enemy_parent);

var onlyRespawnBosses = false;
if argument_count > 0 {
	onlyRespawnBosses = argument[0];
}

var rd = instance_nearest(x,y,obj_room_data);

with rd {
	fs_save_enemydata_tempfile();
}

var sd_temp_enemies_rooms = ds_map_secure_load(TEMP_ENEMYDATA_FILENAME);

var rn = ds_map_find_first(sd_temp_enemies_rooms);
for (var i = 0; i < ds_map_size(sd_temp_enemies_rooms); i++) {
	var sd_temp_enemies_room = ds_map_find_value(sd_temp_enemies_rooms, rn);
	
	var currentRoomName = room_get_name(room)
	
	// bosses can only ever be respawned from their rooms
	if onlyRespawnBosses && rn != currentRoomName {
		rn = ds_map_find_next(sd_temp_enemies_rooms, rn);
		continue;
	}
	
	var ek = ds_map_find_first(sd_temp_enemies_room); // enemy key
	for (var j = 0; j < ds_map_size(sd_temp_enemies_room); j++) {
		var sd_temp_enemy = ds_map_find_value(sd_temp_enemies_room, ek);
		
		var postX = ds_map_find_value(sd_temp_enemy, "PostX");
		var postY = ds_map_find_value(sd_temp_enemy, "PostY");
		
		var enemyObj = findPersistentRoomElement(obj_enemy_parent, real(postX), real(postY));
		
		var ib = ds_map_find_value(sd_temp_enemy, "IsBoss");
		// if this data does not correspond with a boss in the room,
		// and we are only supposed to respawn bosses, continue
		if !ib && onlyRespawnBosses && enemyObj != noone {
			continue;
		}
		// do not normally respawn bosses
		if ib && !onlyRespawnBosses {
			continue;
		}
		
		
		var postZ = ds_map_find_value(sd_temp_enemy, "PostZ");
		var fdStart = ds_map_find_value(sd_temp_enemy, "FacingDirectionStart");
		var hpMax = ds_map_find_value(sd_temp_enemy, "MaxHp");
		var doesEnemyRespawn = ds_map_find_value(sd_temp_enemy, "DoesEnemyRespawn");
		
		ds_map_replace(sd_temp_enemy,"CurrentX",postX);
		ds_map_replace(sd_temp_enemy,"CurrentY",postY);
		ds_map_replace(sd_temp_enemy,"CurrentZ",postZ);
		ds_map_replace(sd_temp_enemy,"TempPostX",postX);
		ds_map_replace(sd_temp_enemy,"TempPostY",postX);
		//var enemy = findPersistentRoomElement(obj_enemy_parent,postX,postY);
		ds_map_replace(sd_temp_enemy,"FacingDirection",fdStart);
		ds_map_replace(sd_temp_enemy,"Hp",hpMax);
		
		// only set an enemy to be alive if it respawns. If it does not, make sure it stays dead
		if doesEnemyRespawn == undefined || doesEnemyRespawn > 0 {
			ds_map_replace(sd_temp_enemy,"IsAlive",true);
		} else {
			ds_map_replace(sd_temp_enemy,"IsAlive",false);
		}
		
		ek = ds_map_find_next(sd_temp_enemies_room, ek);
	}
	
	rn = ds_map_find_next(sd_temp_enemies_rooms, rn);
}

ds_map_secure_save(sd_temp_enemies_rooms, TEMP_ENEMYDATA_FILENAME);


// force save for room data object
// Something leaks a single map here
with rd {
	fs_save_enemydata_tempfile();
	
	var oldEnemiesData = enemiesData;
	// replace enemiesData in room data object with updated data 
	// load_enemydata_tempfile should return a map of maps
	var newEnemiesData = ds_map_deep_clone(ds_map_find_value(sd_temp_enemies_rooms, room_get_name(room)));//fs_load_enemydata_tempfile(roomName);
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
	
}


// force room restart event for all enemies (?)
with obj_enemy_parent {
	if onlyRespawnBosses && !isBoss {
		continue;
	}
	state = CombatantStates.Idle;
	path_end(); 
	lockOnTarget = noone;
	onAlert = false;
	facingDirection = postDir;
	jumpFrame = 0; wasJustHit = false;
	showHp = false;
	
	// reset poise
	poiseCurrent = poiseMax;
	
	event_perform(ev_other, ev_room_start);

	//persistentElementUpdateProperties(id);

}

ds_map_destroy(sd_temp_enemies_rooms); sd_temp_enemies_rooms = -1;
