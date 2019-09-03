// confirm file deletion
if isConfirmingDestroySaveFile && alarm[1] < 1 {

	var menusHandleHeight = 30; //??
	var pad = global.gamePadIndex;

	draw_set_alpha(1);
	draw_set_color(c_gray);
	var x1 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)-100+5; var x2 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)+100-5;
	var y1 = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)-50; var y2 = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)+100;
	draw_rectangle(x1,y1,x2,y2,0);
	draw_set_color(C_HANDLES);
	draw_rectangle(x1,y1,x2,y1+menusHandleHeight,0);
	draw_set_color(c_black);
	draw_rectangle(x1,y1,x2,y2,1);
	draw_set_halign(fa_center); draw_set_color(c_white); draw_set_font(font_main); draw_set_valign(fa_center);
	draw_text(mean(x1,x2),mean(y1,y1+menusHandleHeight),"Confirm Delete File"); 
	draw_set_valign(fa_top);
	var fName = newGameName == "" ? selectedFile : newGameName;
	var confirmString = newGameName == fName ? "Overwrite previous save file: " + string(fName) + "? This cannot be undone." :
										"Really delete file: " + string(fName) + "? This cannot be undone.";
	if fName == newGameName fName += ".sav";
	draw_text_ext(mean(x1,x2),mean(y1,y1+menusHandleHeight)+25,confirmString,-1,x2-x1);
	
	// yes and no buttons
	draw_set_halign(fa_left);
	var textColor = noone;
	var buttonColor = noone;
	
	// Yes button
	var s = "Yes";
	var x1 = x1+5; var y1 = y2-string_height("s")-5;
	var x2 = x1 + string_width(s)+10; var y2 = y1 + string_height(s);
	if mouseOverGuiRect(x1, y1, x2, y2) || (gamepad_is_connected(pad) && confirmDestroyOption == "Y") {
		textColor = c_white;
		buttonColor = c_green;
	} else {
		textColor = c_ltgray;
		buttonColor = c_gray;
		if confirmDestroyOption != "N" && !gamepad_is_connected(pad) {
			confirmDestroyOption = noone;
		}
	}
	
	// draw normal gray button, then overlay the real color
	draw_set_color(c_gray);
	draw_rectangle(x1, y1, x2, y2, false);
	
	draw_set_color(buttonColor);
	draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, true);

	draw_set_color(textColor);
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(x1, x2),mean(y1, y2),s);

	
	if mouseOverGuiRect(x1,y1,x2,y2) {
		if confirmDestroyOption != "Y" audio_play_sound(snd_ui_option_change,1,0);
		confirmDestroyOption = "Y";
		if mouse_check_button_pressed(mb_left) {
			audio_play_sound(snd_shield_hit_metal, 1, 0);
			file_delete(fName);
			alarm[1] = 2;
			isConfirmingDestroyItem = false;
			if state == TitleScreenState.New {
				maybeStartNewGame();
			}
			
			selectedFile = noone;
		}
	}
	
	// No button
	var s = "No";
	var x1 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)+100-5-15-string_width("No"); 
	var x2 = x1 + string_width(s) + 10; 
	if mouseOverGuiRect(x1, y1, x2, y2) || (gamepad_is_connected(pad) && confirmDestroyOption == "N") {
		textColor = c_white;
		buttonColor = c_red;
	} else {
		textColor = c_ltgray;
		buttonColor = c_gray;
		if confirmDestroyOption != "Y" && !gamepad_is_connected(pad) {
			confirmDestroyOption = noone;
		}
	}
	// draw normal gray button, then overlay the real color
	draw_set_color(c_gray);
	draw_rectangle(x1, y1, x2, y2, false);
	
	draw_set_color(buttonColor);
	draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, true);

	draw_set_color(textColor);
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(x1, x2),mean(y1, y2),s);
	
	if mouseOverGuiRect(x1,y1,x2,y2) {
		if confirmDestroyOption != "N" audio_play_sound(snd_ui_option_change,1,0);
		confirmDestroyOption = "N";
		if mouse_check_button_pressed(mb_left) {
			isConfirmingDestroySaveFile = false;
			audio_play_sound(snd_ui_tab1,1,0);
		}
	} 
	
	
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
				audio_play_sound(snd_shield_hit_metal, 1, 0);
				file_delete(fName);
				alarm[1] = 2;
				isConfirmingDestroyItem = false;
				if state == TitleScreenState.New {
					maybeStartNewGame();
				}
			}
			else audio_play_sound(snd_ui_tab1,1,0);
			selectedFile = noone;
			isConfirmingDestroySaveFile = false;
		}
		
		if gamepad_button_check_pressed(pad, gp_face2) {
			isConfirmingDestroySaveFile = false;
			audio_play_sound(snd_ui_tab1,1,0);
		}
	}
}