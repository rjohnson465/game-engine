var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// only draw big screen if not at FOUNTAIN menu option 
if currentMenu != FOUNTAIN {

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
}

switch currentMenu {
	case FOUNTAIN: {
		
		// draw small menu with just enough space to show all fountain options
		draw_set_font(font_main);
		var sh = string_height("s");
		
		var optionsHeight = ds_list_size(menuOptions) * sh;
		var paddingBetweenOptions = 5;
		var paddingHeight = (ds_list_size(menuOptions) - 1) * paddingBetweenOptions;
		var totalHeight = optionsHeight + menusHandleHeight + paddingHeight;
		var totalWidth = 200;
		for (var i = 0; i < ds_list_size(menuOptions); i++) {
			var sw = string_width(ds_list_find_value(menuOptions, i));
			if sw > totalWidth {
				totalWidth = sw;
			}
		}
		
		// draw menu box 
		var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
		var sx = fountain.x - vx - (.5*totalWidth); var sy = fountain.y - vy - (.5*totalHeight);
		var ex = fountain.x - vx + (.5*totalWidth); var ey = fountain.y - vy + (.5*totalHeight) + 10; // 10px padding
		draw_set_color(c_gray); draw_set_alpha(.95);
		draw_rectangle(sx, sy, ex, ey, 0);
		// draw handle
		draw_set_color(C_HANDLES); draw_set_alpha(1);
		draw_rectangle(sx, sy, ex, sy + menusHandleHeight, 0);
		// draw current menu name
		draw_set_halign(fa_center); draw_set_valign(fa_center); draw_set_color(c_white);
		draw_text(mean(sx, ex), mean(sy, sy + menusHandleHeight), currentMenu);
		
		// close button
		if !gamepad_is_connected(global.player.gamePadIndex) {
			var closeButtonWidth = sprite_get_width(spr_close_button);
			var x1 = ex-closeButtonWidth; var y1 = sy;
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
		
		// options start coordinates
		var midW = mean(sx, ex); 
		var midH = sy + menusHandleHeight + (.5*sh) + 5;
		
		// draw all options
		for (var i = 0; i < ds_list_size(menuOptions); i++) {
			// if selected or hovered over, draw it white
			var option = ds_list_find_value(menuOptions,i);
			
			draw_set_halign(fa_center); draw_set_valign(fa_center); draw_set_font(font_main);
			var sh = string_height(option); var sw = string_width(option);
			
			var xx = midW; var yy = midH+(i*sh) + (i * paddingBetweenOptions);
			var x1 = xx-(sw/2); var y1 = yy-(sh/2);
			var x2 = xx+(sw/2); var y2 = yy+(sh/2) + paddingBetweenOptions;
			var textColor = noone;
			
			// click on option?
			if mouseOverGuiRect(sx, y1, ex, y2) && mouse_check_button_released(mb_left) && currentMenu == FOUNTAIN {
				audio_play_sound(snd_ui_click1, 1, 0);
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
			else if mouseOverGuiRect(sx, y1, ex, y2) || selectedOption == option {
				if selectedOption != option {
					audio_play_sound(snd_ui_option_change,1,0);
				}
				selectedOption = option;
				textColor = c_white;
			} else {
				textColor = c_ltgray;
			}
			
			if selectedOption == option {
				// draw highlight
				draw_set_color(C_HIGHLIGHT); draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
				draw_rectangle(sx, y1, ex, y2, 0);
			}
			
			// draw option
			draw_set_color(textColor); draw_set_alpha(1);
			draw_text(xx,yy,option);
		}
		
		// give whole thing a border
		draw_set_color(c_black);
		draw_rectangle(sx, sy, ex, ey, 1);
		
		// prompts
		var promptsStartX = sx+18;
		var promptsY = ey+25;
		var xOffset = 20;
		var w = 0;
		if gamepad_is_connected(global.player.gamePadIndex) {
			w += drawPrompt("Select", Input.F,promptsStartX+w,promptsY)+xOffset;
			w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
		}
		
		break;
	}
}