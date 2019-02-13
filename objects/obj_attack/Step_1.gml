life --;
// special case - 2h club on 3rd attack create dust particles from hitting the ground
if (weapon != noone && weapon.weaponType == BLUNT2H && attackNumber == 3) {
	
	if image_index != 7 exit;
	
	var xo = weapon.dustXOffset; var yo = weapon.dustYOffset;
	var ofd = owner.facingDirection;
	var sx = owner.x + xo; var sy = owner.y + yo;
	var cx = owner.x; var cy = owner.y;
	var radians = (pi/180) * ofd;
	var cs = cos(radians);
	var sn = sin(radians);
	var nx = (cs * (sx - cx)) + (sn * (sy - cy)) + cx;
	var ny = (cs * (sy - cy)) - (sn * (sx - cx)) + cy;
	
	xx = nx;
	yy = ny;
	global.damageType = "Ground";
	global.x1 = xx;
	global.y1 = yy;
	global.particleDirection = 0;
	global.hitParticlesLayer = layer;
	global.victim = noone;
	instance_create_depth(x,y,1,obj_hit_particles);
	audio_play_sound(snd_crunchy_thud,1,0);
}

// special case -- sconces light arrows / bolts on fire
with obj_sconce {
	if origLayer == other.layer && isLit && distance_to_object(other) < 2 &&
		!other.isOnFire && other.weapon != noone && (other.weapon.weaponType == BOW || other.weapon.weaponType == CROSSBOW) {
		
		audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,25,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		other.isOnFire = true;
		ds_map_replace(other.additionalDamages,FIRE,[1,5]);
		with other {
			updateWeaponParticles(id);
		}
	}
}

// general ranged particles algorithm
for (var i = 0; i < array_length_1d(weaponParticles); i++) {
	var part = weaponParticles[i];
	if part != noone && part != undefined && part_type_exists(part) {
		var num = weaponParticlesNums[i];
		var x1 = bbox_left + lengthdir_x(1,facingDirection); var x2 = bbox_right + lengthdir_x(1,facingDirection);
		var y1 = bbox_top + lengthdir_y(1,facingDirection); var y2 = bbox_bottom + lengthdir_y(2,facingDirection);
	
		part_emitter_region(system, emitter, x1,x2,y1,y2,ps_shape_line,ps_distr_linear);
		part_emitter_burst(system, emitter, part, 2);
	}
}

