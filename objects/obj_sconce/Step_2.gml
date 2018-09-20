// if isLit, make particles
var pFloorNum = getLayerFloorNumber(global.player.layer);
if isLit && (floorNum <= pFloorNum) {
	part_emitter_burst(system, emitter, particle3, 1); // smoke
	part_emitter_burst(system, emitter, particle1, 5); // fire 
	part_emitter_burst(system, emitter, particle2, 4); // cinder
	randomize();
	var rand = random_range(1.3,1.5);
	with lightRadius {
		light_set_scale(rand);
	}
}
