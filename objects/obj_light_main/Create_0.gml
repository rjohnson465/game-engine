ds_map_destroy(global._light_layers); global._light_layers = -1;
global._light_layers = ds_map_create();
depth = -1; // just above the top layer
var color = make_colour_rgb(0.05*255, 0.05*255, 0.10 * 255) // The darker the color, the darker the shadow.
var layers = layer_get_all();
var lightForLayers = getLightingForRoom(room);

for (var i = 0; i < array_length_1d(lightForLayers); i++) {
	var lNum = i+1;
	var l = layer_get_id("instances_floor_"+string(lNum));
	color = lightForLayers[lNum-1];
	var w = camera_get_view_width(view_camera[0]);
	var h = camera_get_view_height(view_camera[1]);
	light_init_layer(w, h, w, color, 0.35, 40, lNum)
}


