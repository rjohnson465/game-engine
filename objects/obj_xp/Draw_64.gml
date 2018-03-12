draw_set_color(c_white);
draw_set_font(font_damage);
draw_set_halign(fa_right);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
var x1 = vw-25; var y1 = vh-25;
var text = "+" + string(amount) + " XP";
var frameCutoff = round(totalFrames*.6);

if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(1-((frame-frameCutoff)/frameCutoff));
}

scr_draw_text_outline(x1,y1,text,c_white,c_silver);
draw_set_alpha(1);

