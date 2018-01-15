
draw_set_color(c_white);
draw_set_font(font_main);
draw_set_halign(fa_left);
var x1 = 0; var y1 = 0;
if victim.type == CombatantTypes.Enemy {
	x1 = victim.x+(victim.sprite_width*.5)+5;
	y1 = victim.y-(victim.sprite_height*.5)-20;
} else if victim.type == CombatantTypes.Player {
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	x1 = 215 + vx;
	y1 = 10 + vy;
}
var text = round(amount);
if frame > 7 {
	draw_set_alpha(1-((frame-11)/11));
}
script_execute(scr_draw_text_outline,x1,y1,text,c_black);
draw_set_alpha(1);

