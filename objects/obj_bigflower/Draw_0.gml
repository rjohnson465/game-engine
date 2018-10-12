gpu_set_blendmode(bm_add);
for(var c = 0;c < 360;c += 15){
	draw_sprite_ext(sprite_index,1,x+lengthdir_x(glowAmount,c),y+lengthdir_y(glowAmount,c),1,1,image_angle,c_silver,.15);
}
gpu_set_blendmode(bm_normal)
draw_sprite_ext(sprite_index,1,x,y,1,1,image_angle,c_white,1);