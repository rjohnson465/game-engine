roomIndex = room;

// initialize fountains
fountainsData = ds_list_create();
with obj_fountain {
	global.fountain = id;
	var fountainData = instance_create_depth(x,y,1,obj_fountain_data);
	ds_list_add(other.fountainsData,fountainData);
}

//fountainsData = fountainsDataTemp;

// initialize enemies
enemiesData = ds_list_create();
with obj_enemy_parent {
	global.enemy = id;
	var enemyData = instance_create_depth(x,y,1,obj_enemy_data);
	ds_list_add(other.enemiesData,enemyData);
}

//enemiesData = enemiesDataTemp;

//ds_list_destroy(fountainsDataTemp);
//ds_list_destroy(enemiesDataTemp);