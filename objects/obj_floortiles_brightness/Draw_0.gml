if( !surface_exists(surface_canvas_1) ){
    surface_canvas_1 = surface_create(room_width,room_height);
}

/*for (var i = 0; i < ds_list_size(layersToShade); i++) {
	surface_set_target(surface_canvas_1);
	var l = ds_list_find_value(layersToShade,i);
	draw_tilemap(l,0,0);
	surface_reset_target();
	// shade
	surface_set_target(surface_canvas_2);
	shader_set(sh_saturation);
	shader_set_uniform_f(uPOSITION,-.5);
	draw_surface(surface_canvas_1,0,0);
	shader_reset();
	surface_reset_target();
}*/

surface_set_target(surface_canvas_1);

var l = layer_tilemap_get_id(layer_get_id("tiles_floor_"+string(floorNum)));
draw_tilemap(l,0,0);

surface_reset_target();

shader_set(sh_saturation);

var playerLayer = global.player.layer;
var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));
var diff = pLayerNum - real(floorNum);

var shade = 0;
if diff == 1 {
	shade = -.1;
}

shader_set_uniform_f(uPOSITION,shade);
draw_surface(surface_canvas_1,0,0);
shader_reset();


if( !surface_exists(surface_canvas_2) ){
    surface_canvas_2 = surface_create(room_width,room_height);
}