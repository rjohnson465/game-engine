/// ds_map_find_key(map, val)
/// @param map
/// @param val
/// return the key of the map that stores that value
/// pre-req -- there must be only one key in this map that has that value

var map = argument[0];
var val = argument[1];

var k = noone;
var ck = ds_map_find_first(map);
for (var i = 0; i < ds_map_size(map); i++) {
	var v = ds_map_find_value(map,ck);
	if v == val {
		k = ck;
		break;
	}
	ck = ds_map_find_next(map,ck);
}

return k;