alarm[0] = smokeSteps;
if !isActive || isCoolingDown exit;
var floorNum = getLayerFloorNumber(origLayer);
var pFloorNum = getLayerFloorNumber(global.player.layer);
if floorNum > pFloorNum exit;


randomize();
var rand = random_range(-1, 1);
var pt = noone;
if rand > 0 {
	pt = partSmoke;
}
else {
	pt = partSmoke2;
}
// map 9216 to 1
var area = sprite_width * sprite_height;
var num = (area) / 9216;
if num < 1 {
	num = 1;
}
part_emitter_burst(system, emitter, pt, num);
