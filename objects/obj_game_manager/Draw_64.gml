if room == game_menu {

	// game title
	var vw = view_get_wport(view_camera[0]);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_set_font(font_big);
	draw_text(vw/2,50,"GAME TITLE");

	switch state {
		case TitleScreenState.Options: {
			
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
			
			draw_text(vw/2,400,"Provide filename");
			if global.gamePadIndex != noone {
				
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

