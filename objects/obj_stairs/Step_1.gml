var fn = getLayerFloorNumber(layer);
var pfn = getLayerFloorNumber(global.player.layer);

if pfn == floorUp || pfn == floorDown {
	layer = layer_get_id("instances_floor_"+string(pfn));
	part_system_depth(system, layer_get_depth(layer)-1);
}
if fn > pfn exit;
var sw = sprite_width; var sh = sprite_height;
var x1 = x-(.5*sw); var y1 = y - (.5*sh);
var x2 = x1 + sw; var y2 = y1 + sh;
part_emitter_region(system, emitter, x1,x2,y1,y2,ps_shape_rectangle,ps_distr_gaussian);
// 32x32 is 10, so map 1024 to 10
part_emitter_burst(system, emitter, part, 5);