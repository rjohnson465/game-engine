var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
var vw = camera_get_view_width(view_camera[0]); var vh = camera_get_view_height(view_camera[0]);
if !point_in_rectangle(x,y,vx-100,vy-100,vx+vw+100,vy+vh+100) exit; 
if image_xscale == 1 && image_yscale == 1 {
	draw_sprite(spr_tree1_mask,1,x,y);
} else {
	draw_sprite_ext(spr_tree1_mask,1,x,y,image_xscale, image_yscale, image_angle, c_white, 1);
}



draw_sprite_ext(spr_tree_fir_decorated,1,x,y,drawScaleX,drawScaleY,image_angle,c_white,treeAlpha);