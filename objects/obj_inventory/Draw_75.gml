if isConfirmingDestroyItem {
	draw_set_alpha(1);
	draw_set_color(c_gray);
	var x1 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)-100; var x2 = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X)+100;
	var y1 = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)-50; var y2 = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)+100;
	draw_rectangle(x1,y1,x2,y2,0);
	draw_set_color(C_HANDLES);
	draw_rectangle(x1,y1,x2,y1+ui.menusHandleHeight,0);
	draw_set_color(c_black);
	draw_rectangle(x1,y1,x2,y2,1);
	draw_set_halign(fa_center); draw_set_color(c_white); draw_set_font(font_main); draw_set_valign(fa_center);
	draw_text(mean(x1,x2),mean(y1,y1+ui.menusHandleHeight),"Confirm Destroy");
	draw_set_valign(fa_top);
	draw_text_ext(mean(x1,x2),mean(y1,y1+ui.menusHandleHeight)+25,"Really destroy " + selectedItem.name + "?",-1,x2-x1);
	
	// yes and no buttons
	draw_set_halign(fa_left);
	if confirmDestroyOption == "Y" {
		draw_set_color(c_white)
	} else draw_set_color(c_ltgray);
	var xx = x1+5; var yy = y2-string_height("s")-5;
	var xxx = xx + string_width("Yes"); var yyy = yy + string_height("Yes");
	draw_text(xx,yy,"Yes");
	if mouseOverGuiRect(xx,yy,xxx,yyy) {
		if confirmDestroyOption != "Y" audio_play_sound(snd_ui_option_change,1,0);
		confirmDestroyOption = "Y";
		if mouse_check_button_pressed(mb_left) {
			destroyItem(selectedItem); 
			isConfirmingDestroyItem = false;
		}
	}
	
	if confirmDestroyOption == "N" {
		draw_set_color(c_white)
	} else draw_set_color(c_ltgray);
	var xx = x2-5-string_width("No"); var yy = y2-string_height("s")-5;
	var xxx = xx + string_width("No"); var yyy = yy + string_height("No");
	draw_text(xx,yy,"No");
	if mouseOverGuiRect(xx,yy,xxx,yyy) {
		if confirmDestroyOption != "N" audio_play_sound(snd_ui_option_change,1,0);
		confirmDestroyOption = "N";
		if mouse_check_button_pressed(mb_left) {
			isConfirmingDestroyItem = false;
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
			if confirmDestroyOption == "Y" destroyItem(selectedItem);
			else audio_play_sound(snd_ui_tab1,1,0);
			isConfirmingDestroyItem = false;
		}
		
		if gamepad_button_check_pressed(pad, gp_face2) {
			isConfirmingDestroyItem = false;
			audio_play_sound(snd_ui_tab1,1,0);
		}
	}
}