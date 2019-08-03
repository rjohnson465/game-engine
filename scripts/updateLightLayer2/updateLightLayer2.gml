/// updateLightLayer2(lightObj) 

// more expensive operation than updateLightLayer()
// searches through all layers in light_layers and finds the current light layer the light obj is in
// if this is not the correct layer, it moves the light obj to the correct list in the propert light_layer

var lightObj = argument0;

var lightObjLayer = lightObj.layer;
var lightObjLayerName = layer_get_name(lightObjLayer);
var loFloorNum = real(string_copy(lightObjLayerName,string_length(lightObjLayerName),1));

var deletedRef = false;
var ck = ds_map_find_first(global._light_layers);
for (var i = 0; i < ds_map_size(global._light_layers); i++) {
	
	var floorIndex = i;
	// factory has 0-indexed floors
	if room == rm_factory {
		floorIndex -= 1;
	}
	
	var map = ds_map_find_value(global._light_layers,floorIndex+1);
	
	
	
	var lightsList = ds_map_find_value(map, "_lights");
	
	// iterate through all lights on this layer
	for (var j = 0; j < ds_list_size(lightsList); j++) {
		var light = ds_list_find_value(lightsList, j);
		if light == lightObj {
			// if the lightObj is in the proper list, exit
			if floorIndex+1 == loFloorNum exit;
			else {
				ds_list_delete(lightsList,j);
				deletedRef = true; break;
			}
		}
	}
	if deletedRef break;
	ck = ds_map_find_next(global._light_layers,ck);
}

// must now place lightObj in proper list
if deletedRef {
	var newMap = ds_map_find_value(global._light_layers, loFloorNum);
	var newList = ds_map_find_value(newMap, "_lights");
	ds_list_add(newList,lightObj);
}