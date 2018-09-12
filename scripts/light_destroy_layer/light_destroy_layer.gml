/// light_destroy_layer(floorNum, lightObj*)
/// @param floorNum
/// @param *lightObj

/// remove a light from a given layer's lights map
var floorNum = argument[0];
var lightObj = id;
if argument_count > 1 {
	lightObj = argument[1];
}

var layerMap = ds_map_find_value(global._light_layers,floorNum);
var lightsList = ds_map_find_value(layerMap,"_lights");
var index = ds_list_find_index(lightsList, lightObj);
if index != -1 {
	ds_list_delete(lightsList, index);
}