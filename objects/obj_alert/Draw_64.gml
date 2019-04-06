if !isVisible exit;
draw_set_alpha(1);
draw_set_font(font_main);
draw_set_color(color);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
var vw = view_get_wport(view_camera[0]);
var x1 = vw/2; // half the viewport width
var startingY = (global.player.lockOnTarget != noone && !global.player.lockOnTarget.isBoss) ? 85 : 25;
var cumHeight = 0;
with obj_alert {
	if id != other.id && alertNumber < other.alertNumber && isVisible {
		cumHeight += alertHeight + 15; // 15px padding
	}
}
//var y1 = startingY+((alertNumber-1)*50); // dependent on alertNumber
var y1 = startingY + cumHeight;
var frameCutoff = round(totalFrames*.6);

if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(1-((frame-frameCutoff)/frameCutoff));
}

scr_draw_text_outline(x1,y1,message,color,color,1,1,0,c_black);
draw_set_alpha(1);