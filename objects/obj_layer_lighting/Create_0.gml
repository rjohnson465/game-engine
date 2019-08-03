floorNum = global.floorNum;
depth = layer_get_depth(layer_get_name("instances_floor_"+string(floorNum)))-1;

with obj_layer_lighting {
	if floorNum == other.floorNum && id != other.id {
		instance_destroy(id,1);
	}
}

isActive = false;
var gll = global._light_layers;
var lightLayerMap = ds_map_find_value(global._light_layers,floorNum);
lightColor = ds_map_find_value(lightLayerMap, "_light_color");

var p = global.player; 
var pLayer = p.layer;
var pLayerName = layer_get_name(pLayer);
var pFloorNum = real(string_copy(pLayerName,string_length(pLayerName),1));
// darken the lighting of this layer, if player is above and the natural amb light color isnt dark
var luma = getLumaForColor(lightColor);
if floorNum < pFloorNum && luma >= 128 {
	var r = color_get_red(lightColor);
	var g = color_get_green(lightColor);
	var b = color_get_blue(lightColor);
	var shade_factor = .25;
	var newR = r * (1 - shade_factor);
	var newG = g * (1 - shade_factor);
	var newB = b * (1 - shade_factor);
	var newColor = make_color_rgb(newR, newG, newB);
	lightColor = newColor;
}

