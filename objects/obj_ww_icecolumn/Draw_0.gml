var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
if !point_in_rectangle(x,y,vx-500,vy-500,vx+vw+500,vy+vh+500) exit; 
shader_reset();

if getLayerFloorNumber(layer) == 1 {
	draw_sprite(spr_ww_icecolumn_base, 1, x, y);
}

draw_sprite(sprite_index,1,x,y);