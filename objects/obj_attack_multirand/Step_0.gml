//image_angle = facingDirection;

if !hasSetAlarm && part_type_exists(particle) {
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