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

if (room == rm_tundra || room == rm_clayfields || room == rm_abominable_lands) && floorNum == 1 {
	if pFloorNum >= 2 {
		lightColor = c_dkgray;
	} else {
		var lightLayerMap = ds_map_find_value(global._light_layers,floorNum);
		lightColor = ds_map_find_value(lightLayerMap, "_light_color");
	}
} 

var d = depth;
var pDepth = layer_get_depth(pLayer);

// some cases in which you should not draw light layer
// if this layer is an "underground" layer, only draw it if player is on that layer
//if room == rm_winter && floorNum == 0 && pFloorNum != 0 {
//	isActive = false; exit;
//}
if room == rm_clayfields && floorNum == 0 && pFloorNum != 0 {
	isActive = false; exit;
}

if floorNum <= pFloorNum {
	isActive = true;
	light_draw_layer(vx,vy, 1, true, 1, floorNum);
} else isActive = false;

