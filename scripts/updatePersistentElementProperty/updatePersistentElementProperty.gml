/// updatePersistentElementProperty(element, property, value)
/// @param element
/// @param property
/// @param value

var el = argument0;
var prop = argument1;
var val = argument2;

var rd = instance_nearest(x,y,obj_room_data);

// enemy... 
if object_is_ancestor(el.object_index, obj_enemy_parent) {
	var data_map = ds_map_find_value(rd.enemiesData, el.key);
	if data_map == undefined || !ds_exists(data_map, ds_type_map) || data_map == noone {
		show_debug_message("No data map in Room Data for instance " + string(el) + ". Failed updating property: " + string(prop));
		exit;
	}
	ds_map_replace(data_map,prop,val);
} 
// sconce, fountain, door, etc...
else {

	// update the entry in the roomdata object
	var data_map = ds_map_find_value(rd.persistentElements, el.key);
	var propsMap = ds_map_find_value(data_map, "Properties");
	ds_map_replace(propsMap, prop, val);
}