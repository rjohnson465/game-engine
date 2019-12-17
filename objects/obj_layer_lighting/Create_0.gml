floorNum = global.floorNum;


// your depth is the depth of the layer with "floor_"<floorNum> that is the least deep
var layers = layer_get_all();
var topMostLayer = layer_get_id("instances_floor_"+string(floorNum)); 

var lowestDepth = layer_get_depth(layer_get_name("instances_floor_"+string(floorNum)))-5;
for (var i = 0; i < array_length_1d(layers); i++) {
	var lay = layers[i];
	var layName = layer_get_name(lay);
	if string_pos("floor_" + string(floorNum), layName) {
		if layer_get_depth(lay) < lowestDepth {
			lowestDepth = layer_get_depth(lay) - 5;
			topMostLayer = lay;
		}
	}
}

// depth = layer_get_depth(layer_get_name("instances_floor_"+string(floorNum)))-5;
// depth = layer_get_depth(topMostLayer);
depth = lowestDepth;

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

