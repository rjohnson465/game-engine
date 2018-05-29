/// loadGame

var save_data = ds_map_secure_load("Game.sav");

// destroy all current enemy data objs
with obj_enemy_data {
	instance_destroy(id,1);
}
// load all enemies
//var sd_enemies = ds_map_find_value(save_data,"EnemiesKey");
var sd_enemies = ds_map_secure_load("Enemies.sav");
var cv = ds_map_find_first(sd_enemies);
for (var i = 0; i < ds_map_size(sd_enemies); i++) {
	
	//var sd_enemy = ds_map_find_value(sd_enemies,cv);
	var sd_enemy = ds_map_secure_load(cv+".sav");
	
	var enemyDataObj = instance_create_depth(x,y,1,obj_enemy_data);
	enemyDataObj.hp = ds_map_find_value(sd_enemy,"hp");
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
	
	cv = ds_map_find_next(sd_enemies,cv);
}

var nextRoomLayer = "instances_floor_1";
var p = global.player;
p.layerToMoveTo = nextRoomLayer;
room_restart();
with obj_weapon {
	refreshParticles = true;
}