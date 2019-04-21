if !instance_exists(owner) exit;
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
	alarm[0] = 1;
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