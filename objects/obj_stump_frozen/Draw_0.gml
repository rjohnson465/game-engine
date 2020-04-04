//prepareLayerShader();
if !isFallen {
	draw_sprite_ext(spr_stump_frozen_standing,1,x,y,xscale,yscale,angle,c_white,1);
} else {
	if sprite_index == spr_stump_frozen_falling {
		draw_sprite_ext(sprite_index,image_index,x,y,xscale,yscale,angle,c_white,1);
		if image_index >= sprite_get_number(sprite_index) - 1 {
			// sprite_index = noone;
			audio_play_sound_at(snd_crunchy_thud,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			global.bridgeSpriteIndex = spr_stump_frozen_fallen;
			global.bridgeAngle = image_angle;
			
			global.damageType = ICE;
			
			var ofd = image_angle;
			var sx = x+100; var sy = y;
			var cx = x; var cy = y;
			var radians = (pi/180) * ofd;
			var cs = cos(radians);
			var sn = sin(radians);
			var nx = (cs * (sx - cx)) + (sn * (sy - cy)) + cx;
			var ny = (cs * (sy - cy)) - (sn * (sx - cx)) + cy;
			
			global.x1 = nx;
			global.y1 = ny;
			global.particleDirection = 0;
			global.hitParticlesLayer = origLayer;
			global.victim = noone;
			instance_create_depth(x,y,1,obj_hit_particles);
			instance_change(obj_bridge_parent, 1);

		}
	} else {
		draw_sprite_ext(spr_stump_frozen_fallen,1,x,y,xscale,yscale,angle,c_white,1);
	}
}

shader_reset();