if room == game_menu {

	// game title
	var vw = view_get_wport(view_camera[0]);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_set_font(font_big);
	draw_text(vw/2,50,"GAME TITLE");

	switch state {
		case TitleScreenState.Options: {
			
			if gamepad_is_connected(global.gamePadIndex) {
				var pad = global.gamePadIndex;
				 
				if gamepad_button_check_pressed(pad, gp_padd) || gamepad_button_check_pressed(pad, gp_padu) {
					selectedOption = selectedOption == "New Game" ? "Load Game" : "New Game";
				}
				
				if gamepad_button_check_pressed(pad, gp_face1) {
					switch selectedOption {
						case "New Game": {
							state = TitleScreenState.New;
							break;
						}
						case "Load Game": {
							state = TitleScreenState.Load;
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
					draw_set_color(c_white);	
					// option was clicked
					if mouse_check_button_pressed(mb_left) {
						switch str {
							case "New Game": {
								state = TitleScreenState.New; break;
							}
							case "Load Game": {
								state = TitleScreenState.Load; break;
							}
						}
					}
				}
				
				draw_text(xx,yy, str);
			}
			
			break;
		}
		case TitleScreenState.Load: {
			draw_set_font(font_main);
			
			// load box
			draw_set_color(c_ltgray);
			draw_rectangle(loadBoxTopLeftX, loadBoxTopLeftY, loadBoxBottomRightX, loadBoxBottomRightY, 0);
			
			draw_set_color(c_dkgray);
			draw_rectangle(lbScrollBarTopLeftX, lbScrollBarTopLeftY, lbScrollBarBottomRightX, lbScrollBarBottomRightY, 0);
			
			// get all save files
			var i = 0;
			var fileName = file_find_first(working_directory + "*.sav",fa_directory);

			while fileName != ""
			{
				var sw = string_width(fileName); var sh = string_height(fileName);
				var xx = vw/2; var yy = 400+(i*sh);
				
				var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
				var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
				
				if fileName == selectedFile || mouseOverGuiRect(x1,y1,x2,y2) {
					draw_set_color(c_white);
					//selectedFile = fileName;
					if mouse_check_button_pressed(mb_left) {
						// load this game
						currentSaveFile = fileName;
						with global.player {
							global.playerDoNothing = false;
							event_perform(ev_create, 0);
						}
						loadGame();
					}
				}
			    draw_text(vw/2,400+(i*string_height(fileName)),fileName);
			    fileName = file_find_next();
			    i += 1;
			}

			file_find_close();
			break;
		}
		case TitleScreenState.New: {
			
			draw_set_color(c_ltgray);
			draw_text(vw/2,400,"Provide filename");
			
			// back button
			var str = "Back";
			
			var sw = string_width(str); var sh = string_height(str);
			var xx = vw/2; var yy = 500;
			var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
			var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
			
			if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
				draw_set_color(c_white);
				if mouse_check_button_pressed(mb_left) {
					newGameName = "";
					cursorPos = 1;
					state = TitleScreenState.Options;
				}
			} else draw_set_color(c_ltgray);
			
			draw_text(xx,yy,str);
			
			// entering text with a controller
			if global.gamePadIndex != noone {
				var pad = global.gamePadIndex;
				
				if newGameName == "" newGameName = "a";
				
				var currentChar = string_char_at(newGameName,cursorPos-1);
				var cw = string_width(currentChar);
				var substr = string_copy(newGameName,0,cursorPos-1);
				var ssw = string_width(substr);
				var ngnx = (vw/2)-(.5*string_width(newGameName));
				var curX = ngnx+ssw;
				draw_line(curX,460,curX+cw,460);
				
				if gamepad_button_check_pressed(pad, gp_padu) {
					var char = string_char_at(newGameName,cursorPos); 
					
					var o = ord(char);
					o += 1;
					char = chr(o);
					if o > 126 {
						o = 33;
						char = chr(o);
					}
					newGameName = string_insert(char,newGameName,cursorPos);
					newGameName = string_delete(newGameName, cursorPos+1, 1);
				}
				
				if gamepad_button_check_pressed(pad, gp_padd) {
					var char = string_char_at(newGameName,cursorPos); 
					
					var o = ord(char);
					o -= 1;
					char = chr(o);
					if o < 33 {
						o = 126;
						char = chr(o);
					}
					newGameName = string_insert(char,newGameName,cursorPos);
					newGameName = string_delete(newGameName, cursorPos+1, 1);
				}
				
				if gamepad_button_check_pressed(pad, gp_padr) {
					
					cursorPos += 1;
					if cursorPos > string_length(newGameName) {
						newGameName = string_insert("a",newGameName,cursorPos);
					}
					if cursorPos > string_length(newGameName) cursorPos = string_length(newGameName);
				}
				
				if gamepad_button_check_pressed(pad, gp_padl) {
					cursorPos -= 1;
					if cursorPos < 1 cursorPos = 1;
				}
				
				draw_text(vw/2,450,newGameName);
				
				// start game with this save name
				if gamepad_button_check_pressed(pad, gp_face1) {
					currentSaveFile = newGameName + ".sav";
					with global.player {
						global.playerDoNothing = false;
						event_perform(ev_create, 0);
						global.player.layerToMoveTo = "instances_floor_1";
						x = 300;
						y = 300;
					}
					room_goto(room0);
				}
				
				// return to main menu
				if gamepad_button_check_pressed(pad, gp_face2) {
					newGameName = "";
					cursorPos = 1;
					state = TitleScreenState.Options;
				}
				
			} else {
				
				// allow for user input
				if(keyboard_check_pressed(vk_backspace)) {
				      newGameName = string_delete(newGameName, cursorPos-1, 1);
				      cursorPos-=1; 
					  if cursorPos < 1 cursorPos = 1;
				}
				
				if (keyboard_string != "") {
				      var t = keyboard_string;
				      newGameName = string_insert(t, newGameName, cursorPos)
				      cursorPos += string_length(t)
				      keyboard_string = ""
				}
				
				draw_text(vw/2,450,newGameName);
				
				// allow for confirmation
				if string_length(newGameName) > 0 {
					if (keyboard_check_pressed(vk_enter)) {
						currentSaveFile = newGameName + ".sav";
						with global.player {
							global.playerDoNothing = false;
							event_perform(ev_create, 0);
							global.player.layerToMoveTo = "instances_floor_1";
							x = 300;
							y = 300;
						}
						room_goto(room0);
					}
				}
			}
			
			break;
		}
	}
	
}

