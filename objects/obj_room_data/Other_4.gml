if room == roomIndex {
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
}