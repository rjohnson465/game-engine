if !instance_exists(owner) {
	instance_destroy(id, 1);
	exit;
}
audio_emitter_position(soundEmitter, x, y, depth);

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
