// get the average luma value for all lighting colors in layers above
var floorsAbove = ds_list_create(); // list of floorNums above
var avgColor = c_gray; var cumSum = 0; var n = 0;
with obj_layer_lighting {
	if floorNum > other.floorNum && isActive {
		avgColor = merge_color(avgColor, lightColor, .5);
	}
}
var luma = getLumaForColor(avgColor);
if luma < 128 exit; // let the lighting take care of shading

// only draw if not player's layer
if isPlayerLayer exit;

if( !surface_exists(surface_canvas_1) ){
    surface_canvas_1 = surface_create(room_width,room_height);
}

var l = layer_tilemap_get_id(layer_get_id("tiles_floor_"+string(floorNum)));
var le = layer_tilemap_get_id(layer_get_id("tiles_environment_floor_"+string(floorNum)));
draw_tilemap(l,0,0);
draw_tilemap(le,0,0);

surface_set_target(surface_canvas_1);

var l = layer_tilemap_get_id(layer_get_id("tiles_floor_"+string(floorNum)));
var le = layer_tilemap_get_id(layer_get_id("tiles_environment_floor_"+string(floorNum)));
draw_tilemap(l,0,0);
draw_tilemap(le,0,0);

surface_reset_target();

shader_set(sh_saturation);

var playerLayer = global.player.layer;
/*var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));
var pDepth = layer_get_depth(global.player.layer);
var fDepth = layer_get_depth(layer_get_id("tiles_floor_"+string(floorNum)));*/
var playerFloorNum = getLayerFloorNumber(playerLayer);
var diff = (playerFloorNum - floorNum)*200;

// 200 depth per layer diff
//var diff = fDepth-pDepth;
shade = (-.05/200)*diff;

shader_set_uniform_f(uPOSITION,shade);
draw_surface(surface_canvas_1,0,0);
shader_reset();