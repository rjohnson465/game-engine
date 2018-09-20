/// persistentElementUpdateProperties(element)
/// @param element

var el = argument0; 

var rd = instance_nearest(x, y, obj_room_data);
/*if rd == noone || rd.persistentElements == noone || rd.enemiesData == noone {
	return false; exit;
}*/

// enemy...
if object_is_ancestor(el.object_index, obj_enemy_parent) {
	var data_map = ds_map_find_value(rd.enemiesData, el.key);
	if data_map == undefined {
		// there is no enemy found for this key...
		// add entry to rd.enemiesData
		ds_map_add_map(rd.enemiesData, el.key, el.persistentProperties);
		var map = ds_map_find_value(rd.enemiesData, el.key);
		// hp and maxHp init values must be recorded here, otherwise they're always 35 
		// since thats the default base enemy class values, and persistentProperties map is 
		// populated at the end of the Create Event of the base enemy class
		ds_map_replace(map, "Hp", el.hp);
		ds_map_replace(map, "MaxHp", el.maxHp); 
		exit; 
	}
	var ck = ds_map_find_first(data_map);
	for (var i = 0; i < ds_map_size(data_map); i++) {
		var val = ds_map_find_value(data_map,ck);
		ds_map_replace(el.persistentProperties, ck, val);
		ck = ds_map_find_next(data_map, ck);
	}
} 
// sconce, door, fountain, etc...
else {

	var data_map = ds_map_find_value(rd.persistentElements, el.key);
	if data_map == undefined {
		// there is no element foound for this key...
		// add entry to rd.persistentElements
		var el_map = ds_map_create();
		ds_map_replace(el_map, "ObjectIndexName", object_get_name(object_index));
		ds_map_replace(el_map, "PostX", postX);
		ds_map_replace(el_map, "PostY", postY);
		ds_map_add_map(el_map, "Properties", properties);
		ds_map_add_map(other.persistentElements, key, el_map);
		exit; 
	}
	var propsMap = ds_map_find_value(data_map, "Properties");

	var ck = ds_map_find_first(propsMap);
	for (var i = 0; i < ds_map_size(propsMap); i++) {
		var val = ds_map_find_value(propsMap,ck);
		ds_map_replace(el.properties, ck, val);
		ck = ds_map_find_next(propsMap, ck);
	}
}