//prepareLayerShader();
if !isFallen {
	draw_sprite_ext(spr_stump_rotten_standing,1,x,y,xscale,yscale,angle,c_white,1);
} else {
	if sprite_index == spr_stump_rotten_falling {
		draw_sprite_ext(sprite_index,image_index,x,y,xscale,yscale,angle,c_white,1);
		if image_index >= sprite_get_number(sprite_index) - 1 {
			sprite_index = noone;
			audio_play_sound_at(snd_crunchy_thud,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			global.bridgeSpriteIndex = spr_stump_rotten_fallen;
			instance_change(obj_bridge_parent, 1);
			//instance_change(obj_stump_rotten_fallen, 1);
		}
	} else {
		draw_sprite_ext(spr_stump_rotten_fallen,1,x,y,xscale,yscale,angle,c_white,1);
	}
}
shader_reset();