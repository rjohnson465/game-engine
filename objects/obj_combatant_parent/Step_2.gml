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


/*
// functional speed is a function of the direction we're moving to 
if instance_exists(lockOnTarget) && lockOnTarget != noone {
	var dirToTarget = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
	var diff = abs(dirToTarget-facingDirection);
	// worst case is 180, as diff approaches 180, speed turns to 0
	var currentModifier = functionalSpeed / normalSpeed;
	var diffMod = 1-(diff/180);
	functionalSpeed = normalSpeed * currentModifier * diffMod;
} else {
	functionalSpeed = normalSpeed;
}

