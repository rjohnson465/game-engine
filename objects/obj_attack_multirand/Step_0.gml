if !hasSetAlarm && !is_array(particle) && part_type_exists(particle) {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,0);
		part_emitter_burst(system,emitter,particle, 2);
		if particle2 {
			part_emitter_burst(system,emitter,particle2, 2);
		}
	}
} 

else if !hasSetAlarm && is_array(particle) {
	var x1 = bbox_left; var x2 = bbox_right;
	var y1 = bbox_top; var y2 = bbox_bottom;
	part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,0);
	
	for (var i = 0; i < array_length_1d(particle); i++) {
		var entry = particle[i];
		var p = entry[0];
		var pNum = entry[1];
		if part_type_exists(p) && is_real(pNum) {
			part_emitter_burst(system,emitter,p, pNum);
		}
	}
}