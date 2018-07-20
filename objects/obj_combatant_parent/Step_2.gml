if layer == global.player.layer {
	with obj_attack {
		if place_meeting_layer(x,y,other.id) {
			with other {
				calculateDamage();
			}
		}
	}
}

// functional speed is a function of the direction we're moving to 
if lockOnTarget != noone {
	var dirToTarget = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
	var diff = abs(dirToTarget-facingDirection);
	// worst case is 180, as diff approaches 180, speed turns to 0
	var currentModifier = functionalSpeed / normalSpeed;
	var diffMod = 1-(diff/180);
	functionalSpeed = normalSpeed * currentModifier * diffMod;
} else {
	functionalSpeed = normalSpeed;
}

