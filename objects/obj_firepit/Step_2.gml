// if isLit, make particles

var pFloorNum = getLayerFloorNumber(global.player.layer);
if isLit && (floorNum <= pFloorNum) {
	
	var xx = x+(.5*sprite_width); var yy = y+(.5*sprite_height);
	part_emitter_region(system, emitter, xx-32, xx+32, yy-32, yy+32, ps_shape_diamond, ps_distr_gaussian);
	part_emitter_burst(system, emitter, particle2, -8); // cinder
	part_emitter_burst(system, emitter, particle3, 2); // smoke
	
	part_emitter_region(system, emitter, xx-22, xx+22, yy-22, yy+22, ps_shape_diamond, ps_distr_gaussian);
	part_emitter_burst(system, emitter, particle1, 31); // fire 
	
	randomize();
	var rand = random_range(1.3,1.5);
	with lightRadius {
		light_set_scale(rand);
	}
}
