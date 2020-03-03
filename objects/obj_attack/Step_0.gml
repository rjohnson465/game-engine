if !instance_exists(owner) {
	instance_destroy(id, 1);
	exit;
}
audio_emitter_position(soundEmitter, x, y, depth);



if	owner.state == CombatantStates.Staggering 
{
	if isMelee || isSpell {
		instance_destroy(id, 1);
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

// dim nornal light linearly
if attackData != noone && attackData.hasLightRadius && hasSetAlarm {
	var a = other.alarm[0]/15;
	light_set_alpha(a);
}

audio_emitter_position(soundEmitter,x,y,depth);

if isRanged && life <= 0 && !hasSetAlarm {
	alarm[0] = 60;
}

if !hasSetAlarm && part_type_exists(particle) {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		part_emitter_region(system,emitter,x1,x2,y1,y2,ps_shape_ellipse,0);
		
		var n1 = 2;
		if attackData != noone && attackData.part1Num != noone {
			n1 = attackData.part1Num;
		}
		
		part_emitter_burst(system,emitter,particle, n1);
		
		if particle2 {
			var n2 = 2;
			if attackData != noone && attackData.part1Num != noone {
				n2 = attackData.part2Num;
			}
			part_emitter_burst(system,emitter,particle2, n2);
		}
	}
}

// maybe make some attack particles (if attackData has attackPart)
if attackData != noone && part_type_exists(attackData.attackPart) && attackData.attackPartStartFrame > 0 && attackData.attackPartEndFrame > 0 {
	
	if image_index >= attackData.attackPartStartFrame && image_index <= attackData.attackPartEndFrame {
		var bbl = owner.bbox_left; var bbr = owner.bbox_right;
		var bbt = owner.bbox_top; var bbb = owner.bbox_bottom;
	
		// TODO maybe define a more specific burst region
		if (attackData.attackPartBoundingBox != noone) {
		
			// offsets
			var offsets = attackData.attackPartBoundingBox;
			var xo1 = offsets[0]; var yo1 = offsets[1];
			var xo2 = offsets[2]; var yo2 = offsets[3];

			var newTopLeft = rotateAndTranslatePoint(owner.x, owner.y, xo1, yo1, owner.facingDirection);
			var newBottomRight = rotateAndTranslatePoint(owner.x, owner.y, xo2, yo2, owner.facingDirection);
	
			bbl = newTopLeft[0]; var bbt = newTopLeft[1];
			bbr = newBottomRight[0]; var bbb = newBottomRight[1]; 
		
		}
	
		part_emitter_region(system,emitter,bbl, bbr, bbt, bbb, ps_shape_ellipse, ps_distr_gaussian);
		part_emitter_burst(system,emitter,attackData.attackPart, attackData.attackPartNum);
	}
	
}

if attackData != noone && is_array(attackData.attackSoundsDuring) && !hasSetAlarm {
	for (var i = 0; i < array_length_1d(attackData.attackSoundsDuring); i++) {
		var entry = attackData.attackSoundsDuring[i];
		var snd = entry[0];
		var frame = entry[1];
		if image_index == frame {
			audio_play_sound_at(snd, x, y, owner.depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		}
	}
}

if attackData != noone && attackData.resetCombatantsHitFrame > 0 && !hasSetAlarm {
	if image_index == attackData.resetCombatantsHitFrame {
		ds_list_clear(combatantsHit);
		with obj_player {
			var pos = ds_list_find_index(beenHitWith, other);
			if pos != -1 {
				ds_list_delete(beenHitWith, pos);
			}
		}
		hitIndex++;
	}
}

// maybe track targets
if attackData != noone && attackData.tracksTargets {

	if distance_to_object(owner.lockOnTargetType) < attackData.trackingMinDistance {
			
		var target = instance_nearest(x,y,owner.lockOnTargetType);
			
		if ds_exists(combatantsHit,ds_type_list) && ds_list_find_index(combatantsHit,target) != -1 exit;
		if !ds_exists(combatantsHit,ds_type_list) exit;
		if target.layer != owner.layer exit;
		if place_meeting(x,y,target) ds_list_add(combatantsHit,target);
		var r = distance_to_object(target);
		if (r < 25 && target.state == CombatantStates.Dodging) {
			isTracking = false;
		}
		if (r > 10 && isTracking) {
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
	
	image_angle = facingDirection;
	
}