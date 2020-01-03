draw_set_color(c_white);
draw_set_font(font_damage);
draw_set_halign(fa_center);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var p = global.player;
// var x1 = vw-25; var y1 = vh-25;
var x1 = p.x; var y1 = p.y - 16;
// xp rises as time goes on
var yBonus = (12/15) * frame;
y1 -= yBonus;
x1 -= vx; y1 -= vy;
var text = "+" + string(amount) + " XP";
var frameCutoff = round(totalFrames*.6);

if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(a);
}

scr_draw_text_outline(x1,y1,text,c_white,c_aqua);
draw_set_alpha(1);

