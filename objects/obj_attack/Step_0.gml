if isSpell && !hasSetAlarm {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,0);
		part_emitter_burst(system,emitter,particle, 2);
		if particle2 {
			part_emitter_burst(system,emitter,particle2, 2);
		}
	}
	if spell.spriteName == "magicmissile" {
		if distance_to_object(owner.lockOnTargetType) < 1000 {
			
			var target = instance_nearest(x,y,owner.lockOnTargetType);
			
			if ds_exists(combatantsHit,ds_type_list) && ds_list_find_index(combatantsHit,target) != -1 exit;
			if !ds_exists(combatantsHit,ds_type_list) exit;
			if target.layer != owner.layer exit;
			if place_meeting(x,y,target) ds_list_add(combatantsHit,target);
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
	if isMelee {
		image_angle = owner.facingDirection;
		x = owner.x;
		y = owner.y;
	}

	if	owner.state == CombatantStates.Staggering 
	{
		if isMelee || isSpell {
			instance_destroy(id, 1);
		}
	}
}

// dim spell light linearly
if isSpell && hasSetAlarm {
	var idd = id;
	with obj_light_radius {
		if owner == idd {
			light_set_alpha(other.alarm[0]/15);
		}
	}
}

audio_emitter_position(soundEmitter,x,y,depth);

if isRanged && life <= 0 && !hasSetAlarm {
	alarm[0] = 1;
}