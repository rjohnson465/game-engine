/// fs_load_enemies(enemiesDataMap)
/// @param enemiesDataMap
/// creates enemy data objects from save game file

//var sd_enemies = ds_map_find_value(save_data,"Enemies");

// destroy all current enemy data objs
with obj_enemy_data {
	instance_destroy(id,1);
}

var sd_enemies = argument[0];
var cv = ds_map_find_first(sd_enemies);
for (var i = 0; i < ds_map_size(sd_enemies); i++) {
	
	var sd_enemy = ds_map_find_value(sd_enemies,cv);
	
	var enemyDataObj = instance_create_depth(x,y,1,obj_enemy_data);
	enemyDataObj.hp = ds_map_find_value(sd_enemy,"hp");
	if enemyDataObj.hp <= 0 {
		enemyDataObj.isAlive = false;
	} else enemyDataObj.isAlive = true;
	enemyDataObj.key = cv;
	enemyDataObj.maxHp = ds_map_find_value(sd_enemy,"maxHp");
	enemyDataObj.postX = ds_map_find_value(sd_enemy,"postX");
	enemyDataObj.postY = ds_map_find_value(sd_enemy,"postY");
	enemyDataObj.postZ = ds_map_find_value(sd_enemy,"postZ");
	enemyDataObj.tempPostX = ds_map_find_value(sd_enemy,"tempPostX");
	enemyDataObj.tempPostY = ds_map_find_value(sd_enemy,"tempPostY");
	enemyDataObj.currentX = ds_map_find_value(sd_enemy,"currentX");
	enemyDataObj.currentY = ds_map_find_value(sd_enemy,"currentY");
	enemyDataObj.currentZ = ds_map_find_value(sd_enemy,"currentZ");
	enemyDataObj.facingDirection = ds_map_find_value(sd_enemy,"facingDirection");
	
	with obj_enemy_parent {
	if key == cv {
		enemyData = enemyDataObj;
	}
	event_perform(ev_other,ev_room_start);
}
	
	cv = ds_map_find_next(sd_enemies,cv);
}

ds_map_destroy(sd_enemies); sd_enemies = -1;