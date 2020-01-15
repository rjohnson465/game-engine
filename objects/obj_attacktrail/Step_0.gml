facingDirection = owner.facingDirection;
image_angle = facingDirection;
if !hasSetAlarm && part_type_exists(particle) {
	// if origLayer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;

		var num = 4;
		if attackData.trailPartNum != noone {
			num = attackData.trailPartNum;
		}

		// randomly spawn num particles somewhere in the collision mask of sprite_index
		for (var i = 0; i < num; i++) {
			var xx = -50; var yy = -50;
			var pm = false;
			do {
				randomize();
				xx = random_range(x1,x2); yy = random_range(y1,y2);
				var parti = instance_create_depth(xx,yy,1,obj_attack_zone_part);
				var pm = place_meeting(x,y,parti);
				instance_destroy(parti,1);
			} until (pm)
			part_emitter_region(system,emitter,xx,xx,yy,yy,ps_shape_ellipse,ps_distr_gaussian);
			part_emitter_burst(system,emitter,particle, 1);
		}
		
	//}
}