var gll = global._light_layers;

// clear light surfaces
var ck = ds_map_find_first(gll);
for (var i = 0; i < ds_map_size(gll); i++) {
	var lightLayer = ds_map_find_value(gll, ck);
	var lightSurface = ds_map_find_value(lightLayer, "_light_surface");
	
	if surface_exists(lightSurface) {
		surface_free(lightSurface);
	}
	
	var lightMap = ds_map_find_value(lightLayer, "_light_map");
	if surface_exists(lightMap) {
		surface_free(lightMap);
	}
	
	
	ck = ds_map_find_next(gll, ck);
}

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


