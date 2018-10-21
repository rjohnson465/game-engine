var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
if !point_in_rectangle(x,y,vx-100,vy-100,vx+vw+100,vy+vh+100) exit; 

gpu_set_blendmode(bm_add);
for(var c = 0;c < 360;c += 15){
	draw_sprite_ext(sprite_index,1,x+lengthdir_x(glowAmount,c),y+lengthdir_y(glowAmount,c),1,1,image_angle,c_silver,.15);
}
gpu_set_blendmode(bm_normal)
draw_sprite_ext(sprite_index,1,x,y,1,1,image_angle,c_white,1);