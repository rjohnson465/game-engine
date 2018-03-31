roomIndex = room;

// initialize fountains
fountainsData = ds_list_create();
with obj_fountain {
	global.fountain = id;
	var fd = instance_create_depth(x,y,1,obj_fountain_data);
	fountainData = fd;
	ds_list_add(other.fountainsData,fd);
}

//fountainsData = fountainsDataTemp;

// initialize enemies
enemiesData = ds_list_create();
with obj_enemy_parent {
	global.enemy = id;
	var enemyData = instance_create_depth(x,y,1,obj_enemy_data);
	ds_list_add(other.enemiesData,enemyData);
}

// set all fountains
for (var i = 0; i < ds_list_size(fountainsData); i++) {
	var fountainData = ds_list_find_value(fountainsData,i);
	var fountain = findPersistentRoomElement(obj_fountain,fountainData.postX,fountainData.postY);
		
	if fountainData.isDoneFilling {
		fountain.isDoneFilling = false;
		fountain.isRunning = true;
	}
	fountain.fountainData = fountainData;
}
	
// set all enemies 
for (var i = 0; i < ds_list_size(enemiesData); i++) {
	var enemyData = ds_list_find_value(enemiesData,i);
	var enemy = findPersistentRoomElement(obj_enemy_parent,enemyData.postX,enemyData.postY);
		
	enemy.hp = enemyData.hp;
	enemy.x = enemyData.currentX;
	enemy.y = enemyData.currentY;
	enemy.layer = enemyData.currentZ;
	enemy.isAlive = enemyData.isAlive;
	enemy.tempPostX = enemyData.tempPostX;
	enemy.tempPostY = enemyData.tempPostY;
	enemy.enemyData = enemyData;
	var a = 3;
}


//enemiesData = enemiesDataTemp;

//ds_list_destroy(fountainsDataTemp);
//ds_list_destroy(enemiesDataTemp);