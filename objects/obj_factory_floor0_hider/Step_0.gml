var pFloorNum = getLayerFloorNumber(global.player.layer);
var lay = layer_get_id("tiles_ground_floor_0");
if pFloorNum != 0 {
	layer_set_visible(lay, false);
} else {
	layer_set_visible(lay, true);
}