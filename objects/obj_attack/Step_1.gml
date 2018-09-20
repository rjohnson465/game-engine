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
	instance_create_depth(x,y,1,obj_hit_particles);
	audio_play_sound(snd_crunchy_thud,1,0);
}

// special case -- sconces light arrows / bolts on fire
with obj_sconce {
	if	layer == other.layer && isLit && distance_to_object(other) < 2 &&
		!other.isOnFire && other.weapon != noone && (other.weapon.weaponType == BOW || other.weapon.weaponType == CROSSBOW) {
		
		audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,25,300,1,0,1);
		other.isOnFire = true;
		ds_map_replace(other.additionalDamages,FIRE,[1,5]);
		
	}
}

if isOnFire && !hasSetAlarm {
	// cinder Particle
	var cinder = part_type_create();
	part_type_shape(cinder,pt_shape_flare);
	part_type_size(cinder,0,.1,0,0);
	part_type_color2(cinder,c_orange,c_red);
	part_type_alpha3(cinder,1,.5,0); 
	part_type_speed(cinder,1,2,0,0);
	part_type_direction(cinder,85,95,0,0);
	part_type_blend(cinder,1);
	part_type_life(cinder,25,50);
	particle = cinder;
	
	var arrowWidth = bbox_right - bbox_left;
	// top left of sprite in abs coords (remember the origin is at center)
	var tlx = x-(.5*sprite_width); var tly = y-(.5*sprite_height);
	var xx1 = tlx + bbox_left; var xx2 = tlx + bbox_right;
	var yy1 = tly + bbox_top; var yy2 = tly + bbox_bottom;
	var x1 = bbox_left + lengthdir_x(1,facingDirection); var x2 = bbox_right + lengthdir_x(1,facingDirection);
	var y1 = bbox_top + lengthdir_y(1,facingDirection); var y2 = bbox_bottom + lengthdir_y(2,facingDirection);
	
	part_emitter_region(system, emitter, x1,x2,y1,y2,ps_shape_line,ps_distr_linear);
	part_emitter_burst(system, emitter, particle, 5);
}