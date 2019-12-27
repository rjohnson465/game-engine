if instance_number(obj_room_data) > 1 {
	instance_destroy(id, 1);
}
//roomIndex = string(room);
roomName = room_get_name(room);

// this stores fountains, doors, chests, etc... 
// kvp -> <key, data_obj>
persistentElements = noone;
enemiesData = noone;

// load in from temporary room data file, not save file
persistentElements = fs_load_roomdata_tempfile(roomName);

// if there is no data for this room saved, we have to build our own 

// TODO: what if there are new persistent elements / enemies that have been added / removed since last save?
// Need some way to merge those

if persistentElements == noone {
	persistentElements = ds_map_create();
	with obj_persistent_environment {
		var el_map = ds_map_create();
		ds_map_replace(el_map, "ObjectIndexName", object_get_name(object_index));
		ds_map_replace(el_map, "PostX", postX);
		ds_map_replace(el_map, "PostY", postY);
		ds_map_add_map(el_map, "Properties", properties);
		ds_map_add_map(other.persistentElements, key, el_map);
	}
	with obj_persistent_environment_nonsolid {
		var el_map = ds_map_create();
		ds_map_replace(el_map, "ObjectIndexName", object_get_name(object_index));
		ds_map_replace(el_map, "PostX", postX);
		ds_map_replace(el_map, "PostY", postY);
		ds_map_add_map(el_map, "Properties", properties);
		ds_map_add_map(other.persistentElements, key, el_map);
	}
}

// ditto for enemies data
enemiesData = fs_load_enemydata_tempfile(roomName);
if enemiesData == noone {
	enemiesData = ds_map_create();
	with obj_enemy_parent {
		ds_map_add_map(other.enemiesData, key, persistentProperties);
		var map = ds_map_find_value(other.enemiesData, key);
		// hp and maxHp init values must be recorded here, otherwise they're always 35 
		// since thats the default base enemy class values, and persistentProperties map is 
		// populated at the end of the Create Event of the base enemy class
		ds_map_replace(map, "Hp", hp);
		ds_map_replace(map, "MaxHp", maxHp); 
		ds_map_replace(map, "IsBoss", isBoss);
	}
}

// weird edge case -- what if there is enemy data for an enemy that is not there by default?
// i.e. spores that are created upon mushroom death
var garbageKeys = ds_list_create();
if enemiesData != noone {
	var ck = ds_map_find_first(enemiesData);
	for (var i = 0; i < ds_map_size(enemiesData); i++) {
		var enemyData = ds_map_find_value(enemiesData, ck);
		
		// check if there is an actual enemy for this data.
		var enemyObj = noone;
		with obj_enemy_parent {
			if key == ck {
				enemyObj = id;
			}
		}
		
		//  If not, create it
		var enemyIsAlive = ds_map_find_value(enemyData, "IsAlive");
		if enemyObj == noone && enemyIsAlive {
			var enemyLayer = ds_map_find_value(enemyData, "CurrentZ");
			var enemyX = ds_map_find_value(enemyData, "CurrentX");
			var enemyY = ds_map_find_value(enemyData, "CurrentY");
			var enemyObjIndexName = ds_map_find_value(enemyData, "ObjectIndexName");
			var enemyObjIndex = asset_get_index(enemyObjIndexName);
			enemyObj = instance_create_depth(enemyX, enemyY, layer_get_depth(enemyLayer), enemyObjIndex);
			enemyObj.layer = enemyLayer;
			enemyObj.currentZ = enemyLayer;
			enemyObj.postX = ds_map_find_value(enemyData, "PostX");
			enemyObj.postY = ds_map_find_value(enemyData, "PostY");
			enemyObj.key = fs_generate_key(enemyObj);
			
		} else if (enemyObj == noone || !enemyObj.doesEnemyRespawn) && !enemyIsAlive {
			// if the enemy is no longer alive, remove it from the map
			ds_list_add(garbageKeys, ck);
			if enemyObj != noone && instance_exists(enemyObj) {
				instance_destroy(enemyObj, 1);
			}
			
		}
		
		ck = ds_map_find_next(enemiesData, ck);
	}
}

// if the enemy is no longer alive, remove it from the map
for (var i = 0; i < ds_list_size(garbageKeys); i++) {
	var gkey = ds_list_find_value(garbageKeys, i);
	var mapToDelete = ds_map_find_value(enemiesData, gkey);
	ds_map_delete(enemiesData, gkey);
	ds_map_destroy(mapToDelete); mapToDelete = -1;
}

ds_list_destroy(garbageKeys); garbageKeys = -1;



// now that all the persistent elements have their data either set or created, ensure their room start event fires after
with obj_persistent_environment {
	event_perform(ev_other,ev_room_start);
}

with obj_persistent_environment_nonsolid {
	event_perform(ev_other,ev_room_start);
}

// ditto for enemies...
with obj_enemy_parent {
	event_perform(ev_other, ev_room_start);
}

