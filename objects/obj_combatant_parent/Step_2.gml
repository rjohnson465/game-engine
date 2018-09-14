if layer == global.player.layer && fallFrame >= fallTotalFrames {
	with obj_attack {
		var cpexists = script_execute(scr_collision_point,id,other.id)
		if place_meeting_layer(x,y,other.id) || cpexists || (isRanged && distance_to_object(other.id) < 5) {
			with other {
				calculateDamage();
			}
		}
	}
}
previousFacingDirection = facingDirection;