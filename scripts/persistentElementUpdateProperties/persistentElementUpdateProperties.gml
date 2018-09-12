/// persistentElementUpdateProperties(element)
/// @param element

var el = argument0; 

var rd = instance_nearest(x, y, obj_room_data);

var data_map = ds_map_find_value(rd.persistentElements, el.key);
var propsMap = ds_map_find_value(data_map, "Properties");

var ck = ds_map_find_first(propsMap);
for (var i = 0; i < ds_map_size(propsMap); i++) {
	var val = ds_map_find_value(propsMap,ck);
	ds_map_replace(el.properties, ck, val);
	ck = ds_map_find_next(propsMap, ck);
}