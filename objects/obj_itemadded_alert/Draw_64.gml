if !isVisible exit;
if !instance_exists(item) exit;
draw_set_alpha(1);

var vw = view_get_wport(view_camera[0]);
var vh = view_get_hport(view_camera[0]);

var boxWidth = 200;

var x1 = vw - boxWidth - 10; // half the viewport width
var startingY = (!global.isLooting) ? vh - 100 : vh - 300;
var cumHeight = 0;
with obj_itemadded_alert {
	if id != other.id && alertNumber < other.alertNumber && isVisible {
		cumHeight -= alertHeight + 15; // 15px padding
	}
}
var y1 = startingY + cumHeight;
var frameCutoff = round(totalFrames*.6);

if frame > frameCutoff {
	var a = 1 - ((frame-frameCutoff)/frameCutoff);
	draw_set_alpha(a);
}

// draw black box 
draw_set_color(c_black);
var x2 = x1 + boxWidth; var y2 = y1 + alertHeight + 10;
draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(c_fuchsia);
draw_rectangle(x1, y1, x2, y2, true);

// draw item sprite
var ix = x1 + 5; var iy = y1 + 5;
draw_sprite(spr_item_slot,1,ix,iy);
draw_sprite(item.itemSprite,1,ix,iy);

// draw item name
var tx = ix + sprite_get_width(spr_item_slot) + 5; var ty = mean(y1, y2);
var maxW = boxWidth - (tx - x1); var in = item.name;
var tw = string_width(in);
var xs = 1;
if (tw > maxW) {
	xs = maxW / tw;
}
draw_set_halign(fa_left); draw_set_valign(fa_center);
draw_set_font(font_main);
draw_text_transformed(tx, ty, in, xs, 1, 0);

// scr_draw_text_outline(x1,y1,message,color,color,1,1,0,c_black);
draw_set_alpha(1);