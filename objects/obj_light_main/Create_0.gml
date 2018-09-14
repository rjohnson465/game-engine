ds_map_destroy(global._light_layers); global._light_layers = -1;
global._light_layers = ds_map_create();
depth = -1; // just above the top layer
color = make_colour_rgb(0.05*255, 0.05*255, 0.10 * 255) // The darker the color, the darker the shadow.
var layers = layer_get_all();
for (var i = 0; i < array_length_1d(layers); i++) {
	var l = layers[i];
	var lName = layer_get_name(l);
	var substr = string_copy(lName,0,9);
	if substr == "instances" {
		var lNum = real(string_copy(lName,string_length(lName),1));
		//color = make_colour_rgb(0.05*255, 0.1*255, 0.1 * 255) // The darker the color, the darker the shadow.
		color = c_dkgray;
		var w = camera_get_view_width(view_camera[0]);
		var h = camera_get_view_height(view_camera[1]);
		light_init_layer(w, h, w, color, 0.35, 40, lNum)
		blur = 0.4
	}
}

