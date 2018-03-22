if victim.layer != global.player.layer exit;
draw_set_color(c_white);
draw_set_font(font_damage);
draw_set_halign(fa_left);
var x1 = 0; var y1 = 0;
if victim.type == CombatantTypes.Enemy {
	x1 = victim.x+(victim.sprite_width*.5)+5;
	y1 = victim.y-(victim.sprite_height*.5)-15;
} else if victim.type == CombatantTypes.Player {
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	x1 = 215 + vx;
	y1 = 15 + vy;
}
var text = round(amount);
var scale = 1;
if frame < 11 && isCriticalHit {
	scale = ((-1/11)*frame)+2;
}
if frame > 11 {
	var a = 1 - ((frame-11)/11);
	draw_set_alpha(1-((frame-11)/11));
}
var c2 = isCriticalHit ? c_red : c_purple;
scr_draw_text_outline(x1,y1,text,c_white,c2,scale,scale,0,c_black);
draw_set_alpha(1);

