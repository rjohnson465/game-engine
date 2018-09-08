// if isLit, make particles
if isLit {
	part_emitter_burst(system, emitter, particle1, 3);
	part_emitter_burst(system, emitter, particle2, 5);
	randomize();
	var rand = random_range(1.3,1.5);
	with lightRadius {
		light_set_scale(rand);
	}
}