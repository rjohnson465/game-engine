/// fs_load_fountains(fountainsDataMap)
/// @param fountainsDataMap
/// creates fountains data objects from save game file

// destroy all current enemy data objs
with obj_fountain_data {
	instance_destroy(id,1);
}

var sd_fountains = argument[0];
var cv = ds_map_find_first(sd_fountains);
for (var i = 0; i < ds_map_size(sd_fountains); i++) {
	
	var sd_fountain = ds_map_find_value(sd_fountains,cv);
	
	var enemyDataObj = instance_create_depth(x,y,1,obj_fountain_data);
	enemyDataObj.key = cv;
	enemyDataObj.postX = ds_map_find_value(sd_fountain,"postX");
	enemyDataObj.postY = ds_map_find_value(sd_fountain,"postY");
	enemyDataObj.isDoneFilling = ds_map_find_value(sd_fountain,"isDoneFilling");

	
	cv = ds_map_find_next(sd_fountains,cv);
}