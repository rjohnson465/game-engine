draw_set_font(font_alert);
draw_set_color(color);
draw_set_halign(fa_center);
var vw = view_get_wport(view_camera[0]);
var x1 = vw/2; // half the viewport width
var y1 = 50+((alertNumber-1)*50); // dependent on alertNumber

var frameCutoff = round(totalFrames*.6);

if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(1-((frame-frameCutoff)/frameCutoff));
}

scr_draw_text_outline(x1,y1,message,color,color,1,1,0,c_black);
draw_set_alpha(1);