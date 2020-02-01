var pLayer = global.player.layer;
var pFloorNum = getLayerFloorNumber(pLayer);
var fNum = getLayerFloorNumber(origLayer);
if isActive && pFloorNum >= fNum {
	part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_rectangle, ps_distr_gaussian);
	part_emitter_burst(system, emitter, particle, 4);
} else {
	light_set_scale(0);
	// light_set_alpha(0);
}