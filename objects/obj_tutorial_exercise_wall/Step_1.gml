if !isUntraversable {
	sprite_index = -1;
	x = -1000; y = -1000;
	exit;
} else {
	sprite_index = origSpriteIndex;
	x = postX; y = postY;
}

var fn = getLayerFloorNumber(layer);
var pfn = getLayerFloorNumber(global.player.layer);
if fn > pfn exit;
scale = .1*cos((pi*scaleFrame)/30)+.9;
scaleFrame = (scaleFrame + 1)%60;

light_set_multiscale(lightScaleX*scale, lightScaleY*scale);

// part_emitter_region(system, emitter, bbox_left,bbox_top,bbox_right,bbox_bottom,ps_shape_rectangle,ps_distr_gaussian);
// 32x32 is 10, so map 1024 to 10
part_emitter_burst(system, emitter, part, 1);

