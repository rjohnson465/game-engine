depth = -1; // just above the top layer
//depth = layer_get_depth(layer_get_id("instances_floor_1")-1);
color = make_colour_rgb(0.05*255, 0.05*255, 0.10 * 255) // The darker the color, the darker the shadow.
//color = c_gray;
//color = C_HANDLES;
var w = camera_get_view_width(view_camera[0]);
var h = camera_get_view_height(view_camera[1]);
light_init(w, h, w, color, 0.35, 30)
blur = 0.4
//light_set_ambient_color(make_colour_rgb(128, 128, 128));
