

var alpha = textFadeFrame/textFadeTotalFrames;

if instance_exists(fade) {
	var fadePercent = fade.frame / fade.fadeDuration;
	alpha = (-2*(fadePercent))+1;
}

draw_set_alpha(alpha);
draw_set_font(font_big);
draw_set_halign(fa_center); draw_set_valign(fa_bottom);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
scr_draw_text_outline(vw/2,vh/2,"You have died",c_red,c_red);

// Revive at fountain
draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_set_font(font_main);
var s1 = "Revive at last fountain";
var s1w = string_width(s1);
var s1h = string_height(s1);
var s1x = vw/2; var s1y = (vh/2)+50;
var x1 = s1x-(.5*s1w)-5; var y1 = s1y-(.5*s1h)-5;
var x2 = s1x+(.5*s1w)+5; var y2 = s1y+(.5*s1h)+5;
if selectedOption == ReviveOptions.Fountain {
	draw_set_color(c_gray);
} else draw_set_color(c_dkgray);
reviveAtFountainButtonCoordinates = [x1,y1,x2,y2];
draw_rectangle(x1,y1,x2,y2,false);

var c = mouseOverFountainRevive ? c_white : c_ltgray;
scr_draw_text_outline(s1x,s1y,s1,c,c);

// Use revive orb
if reviveOrbs != noone {
	var s2 = "Use revive orb";

	var y3 = y1 + 50; var y4 = y2+50;
	if selectedOption == ReviveOptions.Orb {
		draw_set_color(c_gray);
	} else draw_set_color(c_dkgray);
	if reviveOrbs == noone {
		draw_set_alpha(alpha*.5);
		draw_set_color(c_maroon);
	}
	reviveWithOrbButtonCoordinates = [x1,y3,x2,y4];
	draw_rectangle(x1,y3,x2,y4,false);
	scr_draw_text_outline(s1x,s1y+50,s2,c_white,c_white);
	if reviveOrbs != noone {
		draw_set_font(font_small);
		scr_draw_text_outline(s1x,s1y+75,string(reviveOrbs.count) + " orb(s) remaining",c_white,c_white);
	} else {
		draw_set_font(font_small);
		scr_draw_text_outline(s1x,s1y+75,"No orb in inventory",c_ltgray,c_ltgray);
	}
}

draw_set_alpha(1);
draw_set_font(font_main);
