depth = -1; // just above the top layer
color = make_colour_rgb(0.2*255, 0.2*255, 0.2 * 255) // The darker the color, the darker the shadow.
//color = c_gray;
var w = camera_get_view_width(view_camera[0]);
var h = camera_get_view_height(view_camera[1]);
light_init(w, h, w, color, 0.35, 40)
blur = 0.4
light_set_ambient_color(make_colour_rgb(128, 128, 128));
