/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if status != ExerciseStepStatus.InProgress exit;

var ui = global.ui;
draw_set_alpha(1);
draw_set_color(c_gray);
var x1 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)-200+5; var x2 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)+200-5;
var y1 = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)-50; var y2 = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)+100;
draw_rectangle(x1,y1,x2,y2,0);
draw_set_color(C_HANDLES);
draw_rectangle(x1,y1,x2,y1+ui.menusHandleHeight,0);
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,1);
draw_set_halign(fa_center); draw_set_color(c_white); draw_set_font(font_main); draw_set_valign(fa_center);
draw_text(mean(x1,x2),mean(y1,y1+ui.menusHandleHeight),"Tutorials"); 
draw_set_valign(fa_top);
draw_text_ext(mean(x1,x2),mean(y1,y1+ui.menusHandleHeight)+25,"Welcome to Unfairytale! Do you want to turn on tutorials? (Highly recommended if you've never played before). This choice cannot be changed!",-1,x2-x1);
	
// yes and no buttons
draw_set_halign(fa_left);
var textColor = noone;
var buttonColor = noone;
	
var s = "Yes";
var x1 = x1+5; var y1 = y2-string_height("s")-5;
var x2 = x1 + string_width(s)+10; var y2 = y1 + string_height(s);
if mouseOverGuiRect(x1, y1, x2, y2) || confirmDestroyOption == "Y" {
	textColor = c_white;
	buttonColor = c_green;
} else {
	textColor = c_ltgray;
	buttonColor = c_gray;
	if confirmDestroyOption != "N" && !gamepad_is_connected(pad) {
		confirmDestroyOption = noone;
	}
}
	
draw_set_color(buttonColor);
draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, true);

draw_set_color(textColor);
draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_text(mean(x1, x2),mean(y1, y2),s);

	
if mouseOverGuiRect(x1,y1,x2,y2) {
	if confirmDestroyOption != "Y" audio_play_sound(snd_ui_option_change,1,0);
	confirmDestroyOption = "Y";
	if mouse_check_button_pressed(mb_left) {
		status = ExerciseStepStatus.Completed;
		global.isTrading = false;
	}
}
	
// No button
var s = "No";
var x1 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)+100-5-15-string_width("No"); 
var x2 = x1 + string_width(s) + 10; 
if mouseOverGuiRect(x1, y1, x2, y2) || confirmDestroyOption == "N" {
	textColor = c_white;
	buttonColor = c_red;
} else {
	textColor = c_ltgray;
	buttonColor = c_gray;
	if confirmDestroyOption != "Y" && !gamepad_is_connected(pad) {
		confirmDestroyOption = noone;
	}
}
draw_set_color(buttonColor);
draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, true);

draw_set_color(textColor);
draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_text(mean(x1, x2),mean(y1, y2),s);
	
if mouseOverGuiRect(x1,y1,x2,y2) {
	if confirmDestroyOption != "N" audio_play_sound(snd_ui_option_change,1,0);
	confirmDestroyOption = "N";
	if mouse_check_button_pressed(mb_left) {
		status = ExerciseStepStatus.Completed;
		global.isTrading = false;
		scr_tutorials_destroy_all();
		audio_play_sound(snd_ui_tab1,1,0);
	}
} 


var pad = global.gamePadIndex;
if gamepad_is_connected(pad) {
	var h_point = gamepad_axis_value(pad, gp_axislh);
	var v_point = gamepad_axis_value(pad, gp_axislv);
	var pdir = noone;
	if (h_point != 0 || v_point != 0) {
		pdir = point_direction(0, 0, h_point, v_point);
	} else {
		joystickInputFrame = joystickInputTotalFrames;
	}
		
	var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;
	if gamepad_button_check_pressed(pad, gp_padl) || gamepad_button_check_pressed(pad, gp_padr) || (pdir != noone && acceptingJoystickInput) {
		confirmDestroyOption = confirmDestroyOption == "Y" ? "N" : "Y";
		audio_play_sound(snd_ui_option_change,1,0);
		joystickInputFrame = 0;
	}
		
	if gamepad_button_check_pressed(pad, gp_face1) {
		if confirmDestroyOption == "Y" {
			global.isTrading = false;
			status = ExerciseStepStatus.Completed;
		}
		else {
			status = ExerciseStepStatus.Completed;
			scr_tutorials_destroy_all();
			audio_play_sound(snd_ui_tab1,1,0);
			global.isTrading = false;
		}
	}
		
}
