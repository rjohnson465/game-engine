draw_set_font(font_alert);
draw_set_color(color);
draw_set_halign(fa_center);
var x1 = 512; // half the viewport width
var y1 = 50+((alertNumber-1)*50); // dependent on alertNumber

var frameCutoff = round(totalFrames*.6);

if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(1-((frame-frameCutoff)/frameCutoff));
}

scr_draw_text_outline(x1,y1,message,color,color,2,2,0,c_black);