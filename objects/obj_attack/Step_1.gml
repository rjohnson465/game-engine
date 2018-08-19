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
	instance_create_depth(x,y,1,obj_hit_particles);
	audio_play_sound(snd_crunchy_thud,1,0);
}