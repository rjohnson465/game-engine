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
	
	// data_map could be undefined if this is a new object since last save
	// use the instance properties map, and add it to the rd object 
	if data_map == undefined {
		data_map = ds_map_create();
		
		with el {
			// hp and maxHp init values must be recorded here, otherwise they're always 35 
			// since thats the default base enemy class values, and persistentProperties map is 
			// populated at the end of the Create Event of the base enemy class
			ds_map_replace(data_map, "Hp", hp);
			ds_map_replace(data_map, "MaxHp", maxHp); 
			ds_map_replace(data_map, "IsBoss", isBoss);
		}
		
		ds_map_add_map(rd.enemiesData, el.key, data_map);
	}
	
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
	
	// data_map could be undefined if this is a new object since last save
	// use the instance properties map, and add it to the rd object 
	if data_map == undefined {
		data_map = ds_map_create();
		
		with el {
			ds_map_replace(data_map, "ObjectIndexName", object_get_name(object_index));
			ds_map_replace(data_map, "PostX", postX);
			ds_map_replace(data_map, "PostY", postY);
			ds_map_add_map(data_map, "Properties", properties);
		}
		
		ds_map_add_map(rd.persistentElements, el.key, data_map);
	}
	
	var propsMap = ds_map_find_value(data_map, "Properties");
	ds_map_replace(propsMap, prop, val);
}