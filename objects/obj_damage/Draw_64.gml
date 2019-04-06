if victim.layer != global.player.layer || (!victim.showHp && victim.type != CombatantTypes.Player) exit;
// boss enemies draw their damage above their health bar at the bottom of the screen
if victim.type == CombatantTypes.Enemy && victim.isBoss exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
draw_set_color(c_white);
draw_set_font(font_damage);
draw_set_halign(fa_left);
var x1 = 0; var y1 = 0;
var spw = sprite_get_bbox_right(sprite_index)-sprite_get_bbox_left(sprite_index); 
var sph = sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index);
if victim.type == CombatantTypes.Enemy {
	x1 = (victim.x-vx)+(spw*.5)+5;
	y1 = (victim.y-vy)-(sph*.5)-15;
} else if victim.type == CombatantTypes.Player {
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	x1 = 215; //+ vx;
	y1 = 15; //+ vy;
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

