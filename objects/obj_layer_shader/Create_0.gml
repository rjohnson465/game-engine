//depth = 250;
// floorNum is the floor level tiles this object will draw
// it will shade these tiles darker if the player is on a floor higher than this
floorNum = global.floorNum; 
instance_create_depth(x,y,1,obj_layer_lighting);
pseudoLayer = global.shaderInstanceLayer;
surface_canvas_1 = -1;
surface_canvas_2 = -1;
//layersToShade = ds_list_create();
uPOSITION = shader_get_uniform(sh_saturation, "Position"); // control shader
shade = 0;

blur = 0.4
color = make_colour_rgb(1*255, 1*255, 1 * 255); // The darker the color, the darker the shadow.

isPlayerLayer = false;
var playerLayer = global.player.layer;
var pLayerName = layer_get_name(playerLayer);
var pLayerNum = real(string_char_at(pLayerName,string_length(pLayerName)));
if pLayerNum == floorNum {
	isPlayerLayer = true;
}

//depth = layer_get_depth(layer_get_name("tiles_floor_"+string(floorNum)));