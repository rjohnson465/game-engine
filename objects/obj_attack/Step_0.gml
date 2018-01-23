if isSpell {
	if spell.spriteName == "magicmissile" {
		if distance_to_object(owner.lockOnTargetType) < 1000 {
			var target = instance_nearest(x,y,owner.lockOnTargetType);
			var r = distance_to_object(target);
			if (r > 10 && target.state != CombatantStates.Dodging) {
				var theta = point_direction(x,y,target.x,target.y);
				theta = (theta/180) * pi;
				var drad = (direction/180) * pi;
				var x1 = speed * cos(drad);
				var y1 = speed * sin(drad);
				var accelerationalStrength = 10000/(r*r);
				var ax = accelerationalStrength * cos(theta);
				var ay = accelerationalStrength * sin(theta);
				var xn = x1 + ax;
				var yn = y1 + ay;
				var xs = x1 + ax/10;
				var ys = y1 + ax/10;
				//speed = sqrt((xs*xs) + (ys*ys));
				if xn < 0 {
					direction = ((arctan(yn / xn) / pi)*180) + 180;
				} else if xn > 0 {
					direction = ((arctan(yn / xn) / pi)*180);
				} else if xn == 0 && yn > 0 {
					direction = 90;
				} else if xn == 0 && yn < 0 {
					direction = 270;
				}
				facingDirection = direction;
				if speed > 30 speed = 30;
			}
		}
	}
	image_angle = facingDirection;
} else {
	//if !weapon || (weapon && weapon.type == HandItemTypes.Melee) {
	if isMelee {
		image_angle = owner.facingDirection;
		x = owner.x;
		y = owner.y;
	}

	if	owner.state == CombatantStates.Staggering 
		//|| owner.isPreparingAttack 
		//|| owner.isRecovering
	{
		//if !weapon || weapon.type != HandItemTypes.Ranged {
		if isMelee || isSpell {
			instance_destroy(id, false);
		}
	}
}

