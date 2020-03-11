// if isLit, make particles

var pFloorNum = getLayerFloorNumber(global.player.layer);
if isLit && (floorNum <= pFloorNum) {
	
	part_emitter_burst(system, emitter1, particle2, -8); // cinder
	part_emitter_burst(system, emitter1, particle3, 1); // smoke
	part_emitter_burst(system, emitter1, particle1, 1); // fire 
	
	part_emitter_burst(system, emitter2, particle2, -8); // cinder
	part_emitter_burst(system, emitter2, particle3, 1); // smoke
	part_emitter_burst(system, emitter2, particle1, 1); // fire 
	
	randomize();
	var rand = random_range(.1,.3);
	with lightRadius {
		light_set_scale(rand);
	}
}
