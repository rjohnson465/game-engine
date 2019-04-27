if origLayer >= global.player.layer {
	part_emitter_region(system,emitter,x-5,x+5,y-5,y+5,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,particle, -2);
}
