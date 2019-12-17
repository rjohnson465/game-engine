var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

var p = global.player; 
var pLayer = p.layer;
var pLayerName = layer_get_name(pLayer);
var pFloorNum = real(string_copy(pLayerName,string_length(pLayerName),1));

// this may be dumb af...
if room == rm_factory && abs(floorNum - pFloorNum) > 1 {
	isActive = false;
	exit;
}

var d = depth;
var pDepth = layer_get_depth(pLayer);

if floorNum <= pFloorNum {
	isActive = true;
	light_draw_layer(vx,vy, 1, true, 1, floorNum);
} else isActive = false;

