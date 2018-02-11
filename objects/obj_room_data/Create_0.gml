roomIndex = room;

// initialize fountains
var fountainsDataTemp = ds_list_create();
with obj_fountain {
	global.fountain = id;
	var fountainData = instance_create_depth(x,y,1,obj_fountain_data);
	ds_list_add(fountainsDataTemp,fountainData);
}

fountainsData = fountainsDataTemp;

// initialize enemies
var enemiesDataTemp = ds_list_create();
with obj_enemy_parent {
	global.enemy = id;
	var enemyData = instance_create_depth(x,y,1,obj_enemy_data);
	ds_list_add(enemiesDataTemp,enemyData);
}

enemiesData = enemiesDataTemp;