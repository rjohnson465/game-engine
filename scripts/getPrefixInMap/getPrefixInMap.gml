/// getPrefixInMap(prefixesList,prefixesMap)
/// @param prefixesList
/// @param prefixesMap

var list = argument[0];
var map = argument[1];

var pre = noone;
for (var i = 0; i < ds_list_size(list); i++) {
	var prefix = ds_list_find_value(list,i);
	if ds_map_find_key(map,prefix) != noone {
		pre = prefix;
	}
}
return pre;
