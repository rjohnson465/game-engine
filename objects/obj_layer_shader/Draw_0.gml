/*// get the average luma value for all lighting colors in layers above
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

//get layers to shade
var mainTilesLayer = layer_get_id("tiles_floor_"+string(floorNum));
var l = layer_tilemap_get_id(mainTilesLayer);

var layersToShade = ds_list_create();
ds_list_add(layersToShade,l);
var layers = layer_get_all();
for (var i = 0; i < array_length_1d(layers); i++) {
	var lay = layers[i];
	var lname = layer_get_name(lay);
	var layDepth = layer_get_depth(lay);
	var mtlDepth = layer_get_depth(mainTilesLayer);
	var ab = abs(layDepth - mtlDepth);
	if abs(layer_get_depth(lay) - layer_get_depth(mainTilesLayer)) <= 5 {
		var tm = layer_tilemap_get_id(lay);
		if tm != l {
			ds_list_add(layersToShade, tm);
		}
	}
}

//var le = layer_tilemap_get_id(layer_get_id("tiles_environment_floor_"+string(floorNum)));
//draw_tilemap(l,0,0);
//draw_tilemap(le,0,0);
for (var i = 0; i < ds_list_size(layersToShade); i++) {
	var tm = ds_list_find_value(layersToShade, i);
	draw_tilemap(tm, 0, 0);
}

surface_set_target(surface_canvas_1);

//var l = layer_tilemap_get_id(layer_get_id("tiles_floor_"+string(floorNum)));
//var le = layer_tilemap_get_id(layer_get_id("tiles_environment_floor_"+string(floorNum)));
for (var i = 0; i < ds_list_size(layersToShade); i++) {
	var tm = ds_list_find_value(layersToShade, i);
	draw_tilemap(tm, 0, 0);
}
//draw_tilemap(l,0,0);
//draw_tilemap(le,0,0);

surface_reset_target();

shader_set(sh_saturation);

var playerLayer = global.player.layer;
var playerFloorNum = getLayerFloorNumber(playerLayer);
var diff = (playerFloorNum - floorNum)*200;

// 200 depth per layer diff
//var diff = fDepth-pDepth;
shade = (-.05/200)*diff;

shader_set_uniform_f(uPOSITION,shade);
draw_surface(surface_canvas_1,0,0);
shader_reset();

ds_list_destroy(layersToShade); layersToShade = -1;