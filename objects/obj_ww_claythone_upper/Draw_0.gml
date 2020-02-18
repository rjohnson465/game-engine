var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
if !point_in_rectangle(x,y,vx-500,vy-500,vx+vw+500,vy+vh+500) exit; 
shader_reset();

draw_sprite_ext(spr_ww_claythrone_back,1,x,y, image_xscale, image_yscale, image_angle, c_white, 1);