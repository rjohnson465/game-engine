/*var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

var playerLayer = global.player.layer;
var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));
var diff = pLayerNum - real(floorNum);
if diff == 1 {
	light_init(1024, 768, 1024, color, 0.35, 40);
	//color = make_colour_rgb(1*255, 0.2*255, 0.2 * 255);
	light_draw(vx,vy, true, true, blur);
}*/


if( !surface_exists(surface_canvas_1) ){
    surface_canvas_1 = surface_create(room_width,room_height);
}

surface_set_target(surface_canvas_1);

var l = layer_tilemap_get_id(layer_get_id("tiles_floor_"+string(floorNum)));
draw_tilemap(l,0,0);

surface_reset_target();

shader_set(sh_saturation);

var playerLayer = global.player.layer;
var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));
var diff = pLayerNum - real(floorNum);

shade = diff*(-.1);

shader_set_uniform_f(uPOSITION,shade);
draw_surface(surface_canvas_1,0,0);
shader_reset();
//surface_free(surface_canvas_1);

