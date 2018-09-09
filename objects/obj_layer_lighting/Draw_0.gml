var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

var p = global.player; 
var pLayer = p.layer;
var pLayerName = layer_get_name(pLayer);
var pFloorNum = real(string_copy(pLayerName,string_length(pLayerName),1));
if floorNum <= pFloorNum {
	isActive = true;
	light_draw_layer(vx,vy, 1, true, .4, floorNum)
} else isActive = false;

