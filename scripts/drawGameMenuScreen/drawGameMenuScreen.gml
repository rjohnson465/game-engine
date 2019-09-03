// drawGameMenuScreen()

var vw = view_get_wport(view_camera[0]);

if gamepad_is_connected(global.gamePadIndex) {
	var pad = global.gamePadIndex;
	if joystickInputFrame < joystickInputTotalFrames {
		joystickInputFrame++;
	}
				
	if selectedOption == "" || selectedOption == noone {
		selectedOption = "New Game";
	}
				
	var h_point = gamepad_axis_value(pad, gp_axislh);
	var v_point = gamepad_axis_value(pad, gp_axislv);
	var pdir = noone;
	if (h_point != 0 || v_point != 0) {
		pdir = point_direction(0, 0, h_point, v_point);
	} else {
		joystickInputFrame = joystickInputTotalFrames;
	}
	
	var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;
	
	var isJoystickUp = angleBetween(225,315,pdir);
				
	if gamepad_button_check_pressed(pad, gp_padd) || gamepad_button_check_pressed(pad, gp_padu) || ((angleBetween(45,135,pdir) || angleBetween(225,315,pdir)) && pdir != noone && acceptingJoystickInput) {
		// selectedOption = selectedOption == "New Game" ? "Load Game" : "New Game";
		var pos = 0;
		for (var i = 0; i < array_length_1d(options); i++) {
			var option = options[i];
			if option == selectedOption {
				pos = i;
			}
		}
		var incAmount = 1;
		if gamepad_button_check_pressed(pad, gp_padu) || (pdir > 0 && !isJoystickUp) {
			incAmount = -1;
		}
		var newPos = pos + incAmount;
		if (newPos >= array_length_1d(options)) {
			newPos = 0;
		}
		if newPos < 0 {
			newPos = array_length_1d(options) - 1;
		}
		selectedOption = options[newPos];
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
				
	if gamepad_button_check_pressed(pad, gp_face1) && !instance_exists(fade) {
		audio_play_sound(snd_ui_tab1,1,0);
		switch selectedOption {
			case "New Game": {
				state = TitleScreenState.New;
				break;
			}
			case "Load Game": {
				state = TitleScreenState.Load;
				break;
			}
			case "Exit": {
				global.gameEnding = true;
				game_end();
				break;
			}
		}
	}
				
} 
			
for (var i = 0; i < array_length_1d(options); i++) {
	var str = options[i];
				
	draw_set_color(c_ltgray);
				
	var sw = string_width(str); var sh = string_height(str);
	var xx = vw/2; var yy = 400+(i*sh);
				
	var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
	var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
				
	if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
		if selectedOption != str {
			audio_play_sound(snd_ui_option_change,1,0);
			selectedOption = str;
		}
		draw_set_color(c_white);	
		// option was clicked
		if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) && !instance_exists(fade) {
			audio_play_sound(snd_ui_tab1,1,0);
			switch str {
				case "New Game": {
					state = TitleScreenState.New; break;
				}
				case "Load Game": {
					state = TitleScreenState.Load; break;
				}
				case "Exit": {
					global.gameEnding = true;
					game_end();
					break;
				}
			}
		}
	} 
				
	draw_text(xx,yy, str);
}