if gamepad_is_connected(global.player.gamePadIndex) exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var sw = sprite_get_width(sprite_index);
var x2 = x1+sw; var y2 = y1+sw;
if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button(mb_left) {
	draw_sprite_ext(sprite_index,1,x1,y1,1,1,0,c_black,1);
} else if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
	draw_sprite_ext(sprite_index,1,x1,y1,1,1,0,c_gray,1);
} else {
	draw_sprite_ext(sprite_index,1,x1,y1,1,1,0,c_white,.5);
}

if position_meeting(mouse_x,mouse_y,id) {
	draw_set_halign(fa_right); draw_set_font(font_main);
	scr_draw_text_outline(view_get_wport(view_camera[0])-1,50,text,c_white,c_white,1,1,0,c_black);
}