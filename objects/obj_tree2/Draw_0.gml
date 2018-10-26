var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
if !point_in_rectangle(x,y,vx-100,vy-100,vx+vw+100,vy+vh+100) exit; 
draw_sprite(spr_tree1_mask,1,x,y);
if treeAlpha == 1 {
	draw_sprite(spr_tree2,1,x,y); exit;
}
draw_sprite_ext(spr_tree2,1,x,y,1,1,0,c_white,treeAlpha);