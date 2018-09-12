/// getPersistentElementData(*el)
/// @param *el

var el = id;
if argument_count > 0 {
	el = argument[0];
}

var rd = instance_nearest(x, y, obj_room_data);

var data_map = ds_map_find_value(rd.persistentElements, el.key);
return data_map;