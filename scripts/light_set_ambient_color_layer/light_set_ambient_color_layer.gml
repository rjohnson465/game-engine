///light_set_color(ambient_color, layerNum)
/*
Sets the ambient color, this also controls the brightness.
ambient_color: Color to make the shadows.
*/

var layerNum = argument1;
var color = argument0;

var map = ds_map_find_value(global._light_layers, layerNum);
ds_map_replace(map,"_light_color",color);
//global._light_color = argument0