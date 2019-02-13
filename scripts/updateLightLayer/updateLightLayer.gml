/// updateLightLayer(lightObj, oldLayer, newLayer)
/// @param lightObj
/// @param oldLayer index -- could be noone
/// @param newLayer index

// update where the lightRadus is stored in _light_layers so it is drawn at the right layer

var lightObj = argument0
var oldLayer = argument1
var newLayer = argument2

var lightLayers = global._light_layers;

if oldLayer != noone {
	var oldLayerName = layer_get_name(oldLayer);
	var oldLayerNum = real(string_copy(oldLayerName,string_length(oldLayerName),1));
	var oldMap = ds_map_find_value(global._light_layers, oldLayerNum);
	var oldList = ds_map_find_value(oldMap,"_lights");
	var index = ds_list_find_index(oldList, lightObj);
	ds_list_delete(oldList, index);
}
// oldLayer was not provided, we need to find this light instance ourselves, fuck
else {
	var ck = ds_map_find_first(global._light_layers);
	for (var i = 0; i < ds_map_size(global._light_layers); i++) {
		
		var layerMap = ds_map_find_value(global._light_layers, ck);
		var lightsList = ds_map_find_value(layerMap, "_lights");
		
		var index = noone;
		// see if this lights list contains a lightobj whose owner is lightObj.owner, if so delet this cousin
		for (var j = 0; j < ds_list_size(lightsList); j++) {
			var _light = ds_list_find_value(lightsList, j);
			if !instance_exists(_light) {
				continue;
			}
			if (_light.object_index == obj_light_radius) {
				var owner = _light.owner;
				if owner == lightObj.owner {
					index = j;
				}
			}
		}

		if (index != noone && index >= 0) {
			ds_list_delete(lightsList, index);
		}
			
		ck = ds_map_find_next(global._light_layers, ck);
	}
}
var newLayerName = layer_get_name(newLayer);
var newLayerNum = real(string_copy(newLayerName,string_length(newLayerName),1));
var newMap = ds_map_find_value(global._light_layers, newLayerNum);
if newMap != undefined {
	var newList = ds_map_find_value(newMap, "_lights");
	ds_list_add(newList,lightObj);
}