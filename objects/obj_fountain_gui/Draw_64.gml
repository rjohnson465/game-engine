var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// big menu screen
draw_set_color(c_gray);
draw_set_alpha(.75);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_BOTTOMRIGHT_Y,0);
draw_set_alpha(1);
	
// current menu title handle
draw_set_color(C_HANDLES);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+menusHandleHeight,false);
	
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(font_main);
	
draw_text((MENUS_BOTTOMRIGHT_X+MENUS_TOPLEFT_X)/2,((MENUS_TOPLEFT_Y+menusHandleHeight)+MENUS_TOPLEFT_Y)/2,currentMenu);

// close button
if !gamepad_is_connected(global.player.gamePadIndex) {
	var closeButtonWidth = sprite_get_width(spr_close_button);
	var x1 = MENUS_BOTTOMRIGHT_X-closeButtonWidth; var y1 = MENUS_TOPLEFT_Y;
	var x2 = x1 + closeButtonWidth; var y2 = y1 + closeButtonWidth;
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button(mb_left) {
		draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_black,1);	
	} else if mouseOverGuiRect(x1,y1,x2,y2) {
		draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_gray,1);
	} else {
		draw_sprite(spr_close_button,1,x1,y1);
	}
		
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) {
		if !hasSetAlarm {
			audio_play_sound(snd_ui_click1,1,0);
			alarm[0] = 1;
			hasSetAlarm = true;
		}
	}
}

switch currentMenu {
	case FOUNTAIN: {
		
		var midW = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X); var midH = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y);
		
		// draw all options
		for (var i = 0; i < ds_list_size(menuOptions); i++) {
			// if selected or hovered over, draw it white
			var option = ds_list_find_value(menuOptions,i);
			
			draw_set_halign(fa_center); draw_set_valign(fa_center); draw_set_font(font_main);
			var sh = string_height(option); var sw = string_width(option);
			
			var xx = midW; var yy = midH+(i*sh);
			var x1 = xx-(sw/2); var y1 = yy-(sh/2);
			var x2 = xx+(sw/2); var y2 = yy+(sh/2);
			
			// click on option?
			if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_released(mb_left) && currentMenu == FOUNTAIN {
				switch option {
					case INSERTGEM: {
						startInsertGemMenu(); break;
					}
					case BREAKDOWNITEM: {
						startBreakDownItemMenu(); break;
					}
					case REPAIRITEM: {
						startRepairItemMenu(); break;
					}
					case LEAVEFOUNTAIN: {
						leaveFountain(); break;
					}
				}
			}
			// mouse hover / select this option?
			else if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == option {
				if selectedOption != option {
					audio_play_sound(snd_ui_option_change,1,0);
				}
				selectedOption = option;
				draw_set_color(c_white);
			} else {
				draw_set_color(c_ltgray);
			}
			
			// draw option
			draw_text(xx,yy,option);
		}
		
		/*
		draw_set_color(c_white);
		// draw options
		if selectedOption == INSERTGEM {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH,INSERTGEM);
			
		if selectedOption == BREAKDOWNITEM {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH+25,BREAKDOWNITEM);
		draw_set_alpha(1);
		
		if selectedOption == REPAIRITEM {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH+50,REPAIRITEM);
		draw_set_alpha(1);
		
		if selectedOption == LEAVEFOUNTAIN {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH+75,LEAVEFOUNTAIN);
		draw_set_alpha(1);*/
		
		// prompts
		var promptsStartX = MENUS_TOPLEFT_X+18;
		var promptsY = MENUS_BOTTOMRIGHT_Y+25;
		var xOffset = 20;
		var w = 0;
		if gamepad_is_connected(global.player.gamePadIndex) {
			w += drawPrompt("Select", Input.F,promptsStartX+w,promptsY)+xOffset;
			w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
		}
		
		break;
	}
}