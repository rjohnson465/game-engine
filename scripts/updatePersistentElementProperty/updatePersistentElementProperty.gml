/// updatePersistentElementProperty(element, property, value)
/// @param element
/// @param property
/// @param value

var el = argument0;
var prop = argument1;
var val = argument2;

var rd = instance_nearest(x,y,obj_room_data);

// update the entry in the roomdata object
var data_map = ds_map_find_value(rd.persistentElements, el.key);
var propsMap = ds_map_find_value(data_map, "Properties");
ds_map_replace(propsMap, prop, val);