draw_set_alpha(1);
draw_set_font(font_big);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
var vw = view_get_wport(view_camera[0]);
var vh = view_get_hport(view_camera[0]);
var x1 = vw/2; // half the viewport width
var y1 = vh/2;
var frameCutoff = round(totalFrames*.6);

if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(1-((frame-frameCutoff)/frameCutoff));
}

if fade != noone && instance_exists(fade) {
	var a = fade.alpha;
	a = (-a) + 1;
	draw_set_alpha(a);
}

scr_draw_text_outline(x1,y1,message,c_silver,c_white,1,1,0,c_black);
draw_set_alpha(1);