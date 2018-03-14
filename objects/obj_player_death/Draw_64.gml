var_time_var+=0.04;

var_mouse_pos_x = mouse_x - camera_get_view_x(0);
var_mouse_pos_y = mouse_y - camera_get_view_y(0);

var fade = noone;
with obj_fade {
	if owner == other.id {
		fade = id;
	}
}

shader_set(shd_greyscale);
    shader_set_uniform_f(uni_time, var_time_var);
    shader_set_uniform_f(uni_mouse_pos, var_mouse_pos_x, var_mouse_pos_y);
    shader_set_uniform_f(uni_resolution, var_resolution_x, var_resolution_y);
    shader_set_uniform_f(uni_greyscale_fade, var_greyscale_fade);
    if full_screen_effect {
		
		draw_surface(surf,0,0);
	}
shader_reset();


// saturated surface
surface_set_target(surf2);

var alpha = textFadeFrame/textFadeTotalFrames;

if fade != noone {
	var fadePercent = fade.frame / fade.fadeDuration;
	alpha = (-2*(fadePercent))+1;
}

draw_set_alpha(alpha);
draw_set_font(font_big);
draw_set_halign(fa_center);
var vw = camera_get_view_width(view_camera[0]);
var vh = camera_get_view_height(view_camera[0]);
scr_draw_text_outline(vw/2,vh/2,"You have died",c_red,c_red);

// Revive at fountain
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
draw_rectangle(x1,y1,x2,y2,false);
draw_set_halign(fa_center);
scr_draw_text_outline(s1x,s1y,s1,c_white,c_white);

// Use revive orb
var s2 = "Use revive orb";
var y3 = y1 + 50; var y4 = y2+50;
if selectedOption == ReviveOptions.Orb {
	draw_set_color(c_gray);
} else draw_set_color(c_dkgray);
draw_rectangle(x1,y3,x2,y4,false);
scr_draw_text_outline(s1x,s1y+50,s2,c_white,c_white);

draw_set_alpha(1);

surface_reset_target();

shader_set(shd_greyscale);
    shader_set_uniform_f(uni_time, var_time_var);
    shader_set_uniform_f(uni_mouse_pos, var_mouse_pos_x, var_mouse_pos_y);
    shader_set_uniform_f(uni_resolution, var_resolution_x, var_resolution_y);
    shader_set_uniform_f(uni_greyscale_fade, 0);
    if full_screen_effect {
		
		draw_surface(surf2,0,0);
	}
shader_reset();