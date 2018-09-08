/// updateLightLayer(lightObj, oldLayer, newLayer)
/// @param lightObj
/// @param oldLayer index
/// @param newLayer index

// update where the lightRadus is stored in _light_layers so it is drawn at the right layer

var lightObj = argument0
var oldLayer = argument1
var newLayer = argument2

var oldLayerName = layer_get_name(oldLayer);
var oldLayerNum = real(string_copy(oldLayerName,string_length(oldLayerName),1));
var oldMap = ds_map_find_value(global._light_layers, oldLayerNum);
var oldList = ds_map_find_value(oldMap,"_lights");
var index = ds_list_find_index(oldList, lightObj);
ds_list_delete(oldList, index);
var newLayerName = layer_get_name(newLayer);
var newLayerNum = real(string_copy(newLayerName,string_length(newLayerName),1));
var newMap = ds_map_find_value(global._light_layers, newLayerNum);
var newList = ds_map_find_value(newMap, "_lights");
ds_list_add(newList,lightObj);