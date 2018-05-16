// only draw if not player's layer
if isPlayerLayer exit;

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
var pDepth = layer_get_depth(global.player.layer);
var fDepth = layer_get_depth(layer_get_id("tiles_floor_"+string(floorNum)));

var diff = fDepth-pDepth;
shade = (-.05/100)*diff;

shader_set_uniform_f(uPOSITION,shade);
draw_surface(surface_canvas_1,0,0);
shader_reset();

