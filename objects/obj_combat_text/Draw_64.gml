draw_set_color(c_white);
draw_set_font(font_damage);
draw_set_halign(fa_center);
var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);
var x1 = 0; var y1 = 0;
x1 = combatant.x-vx;
y1 = (combatant.y-vy) - (.5*combatant.sprite_height)-25;
var frameCutoff = round(totalFrames*.6);
if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(1-((frame-frameCutoff)/frameCutoff));
}
scr_draw_text_outline(x1,y1,text,c_white,c_purple,c_black);
draw_set_alpha(1);

