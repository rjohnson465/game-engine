
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
				if joystickInputFrame < joystickInputTotalFrames {
					joystickInputFrame++;
				}
				
				if selectedOption == "" || selectedOption == noone selectedOption = "New Game";
				
				var h_point = gamepad_axis_value(pad, gp_axislh);
				var v_point = gamepad_axis_value(pad, gp_axislv);
				var pdir = noone;
				if (h_point != 0 || v_point != 0) {
					pdir = point_direction(0, 0, h_point, v_point);
				} else {
					joystickInputFrame = joystickInputTotalFrames;
				}
	
				var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;
				
				if gamepad_button_check_pressed(pad, gp_padd) || gamepad_button_check_pressed(pad, gp_padu) || ((angleBetween(45,135,pdir) || angleBetween(225,315,pdir)) && pdir != noone && acceptingJoystickInput) {
					selectedOption = selectedOption == "New Game" ? "Load Game" : "New Game";
					joystickInputFrame = 0;
				}
				
				if gamepad_button_check_pressed(pad, gp_face1) && !instance_exists(fade) {
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
				
			} else {
				selectedOption = noone;
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
					if mouse_check_button_pressed(mb_left) && !instance_exists(fade) {
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
			draw_rectangle(loadBoxTopLeftX, loadBoxTopLeftY, loadBoxBottomRightX, loadBoxBottomRightY, 1);
			
			var msl = loadFilesGetMaxScrollLevel();
			// allow for scroll
			if mouseOverGuiRect(loadBoxTopLeftX, loadBoxTopLeftY, loadBoxBottomRightX, loadBoxBottomRightY) {
				if mouse_wheel_down() {
					// only scroll if there is a file at this position
					var f = file_find_first(working_directory + "*.sav", fa_directory);
					var i = 0;
					while f != "" {
						if i >= scrollLevel + 1 break;
						f = file_find_next();
						i++;
					}
					if i >= scrollLevel + 1 {
						scrollLevel++;
						if scrollLevel > msl scrollLevel = msl;
					}
				}
				
				if mouse_wheel_up() {
					if scrollLevel > 0 {
						scrollLevel--;
					}
				}
			}
			
			draw_set_color(c_dkgray);
			draw_rectangle(scrollBarTopLeftX, scrollBarTopLeftY, scrollBarBottomRightX, scrollBarBottomRightY, 0);
			
			// scrolling
			draw_set_color(c_black);
			var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
			// scroll button up
			if scrollLevel == 0 {
				draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_gray,.75);
			}
			else draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_white,1);
			
			if (mouseOverGuiRect(scrollButtonUpTopLeftX,scrollButtonUpTopLeftY,scrollButtonUpBottomRightX,scrollButtonUpBottomRightY) && mouse_check_button_pressed(mb_left)) {
				draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_gray,.75);
				if scrollLevel > 0 {
					scrollLevel--;
				}
			}
			
			// scroll button down			
			if scrollLevel == msl {
				draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_gray,.75);
			} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_white,1);
			
			if (mouseOverGuiRect(scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonDownBottomRightX,scrollButtonDownBottomRightY) && mouse_check_button_pressed(mb_left)) {
				// only scroll if there is a file at this position
				var f = file_find_first(working_directory + "*.sav", fa_directory);
				var i = 0;
				while f != "" {
					if i >= scrollLevel + 1 break;
					f = file_find_next();
					i++;
				}
				if i >= scrollLevel + 1 {
					scrollLevel++;
					if scrollLevel > msl scrollLevel = msl;
				}
			}
		
			// draw scroll box
			var percentScrolled = 0;
			if msl > 0 percentScrolled = scrollLevel / msl;

			var scrollBarBoxStartY = scrollBarTopLeftY+scrollBarWidth;
			var scrollBarBoxEndY = scrollBarBottomRightY-(2*scrollBarWidth);
			var scrollBarHeight = scrollBarBoxEndY-scrollBarBoxStartY;

			// how tall should the box be?
			var scrollBarBoxHeight = scrollBarHeight;
			if msl > 0 {
				scrollBarBoxHeight = scrollBarHeight/msl;
			}

			// recalc how much sbheight is
			var scrollBarBoxEndY = scrollBarBottomRightY-scrollBarWidth-scrollBarBoxHeight;
			var scrollBarHeight = scrollBarBoxEndY-scrollBarBoxStartY;

			var yOff = scrollBarHeight*percentScrolled;
			var x1 = scrollBarTopLeftX; var y1 = scrollBarBoxStartY+yOff;
			draw_set_color(c_gray);

			draw_rectangle(x1,y1,x1+scrollBarWidth,y1+scrollBarBoxHeight,0);
			
			// get all save files that can fit, accounting for scroll level
			var fileName = file_find_first(working_directory + "*.sav",fa_directory);
			var j = 0; 
			while j < scrollLevel {
				fileName = file_find_next();
				j++;
			}
			
			// show files we can 
			var shownFiles = ds_list_create();
			var startY = loadBoxTopLeftY+string_height(fileName);
			var i = 0;
			while fileName != ""
			{
				var sw = string_width(fileName); var sh = string_height(fileName);
				var xx = vw/2; var yy = startY+(i*sh);
				if yy > loadBoxBottomRightY-sh break;
				
				if (selectedFile = noone || selectedFile == "") && gamepad_is_connected(global.gamePadIndex) {
					selectedFile = fileName;
				} else {
					selectedFile = noone;
				}
				
				ds_list_add(shownFiles,fileName);
				var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
				var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
				
				if fileName == selectedFile || mouseOverGuiRect(x1,y1,x2,y2) {
					draw_set_color(c_white);
					if mouse_check_button_pressed(mb_left) {
						// load this game
						currentSaveFile = fileName;
						file_find_close();
						global.fadeDuration = 60;
						global.owner = id;
						fade = instance_create_depth(x,y,-100000,obj_fade);
						//loadGame();
					}
				} else draw_set_color(c_ltgray);
			    draw_text(vw/2,yy,fileName);
			    fileName = file_find_next();
			    i += 1;
			}
			
			// controllers scrolling through files
			if gamepad_is_connected(global.gamePadIndex) {
				
				// draw prompts
				var promptsStartX = 350;
				var promptsY = 500;
				var xOffset = 20;
				var w = 0;

				w += drawPrompt("Select file",Input.PadUD,promptsStartX+w)+xOffset;
				w += drawPrompt("Load",Input.F,promptsStartX+w)+xOffset;
				w += drawPrompt("Back",Input.Escape,promptsStartX+w)+xOffset;
				
				var pad = global.gamePadIndex;
				
				if gamepad_button_check_pressed(pad, gp_padu) {
					var f = file_find_first(working_directory + "*.sav",fa_directory);
					var prev = noone;
					while f != selectedFile {
						prev = f;
						f = file_find_next();
					}
					if prev != noone && prev != "" {
						selectedFile = prev;
						if ds_list_find_index(shownFiles,selectedFile) == -1 {
							scrollLevel--;
						}
					}
				}
				
				if gamepad_button_check_pressed(pad, gp_padd) {
					var f = file_find_first(working_directory + "*.sav",fa_directory);
					var next = noone;
					var pos = 0;
					while f != selectedFile {
						f = file_find_next();
						pos += 1;
					}
					f = file_find_first(working_directory + "*.sav",fa_directory);
					var j = 0;
					while j <= pos {
						next = file_find_next();
						j++;
					}
					if next != noone && next != "" {
						selectedFile = next;
						if ds_list_find_index(shownFiles,selectedFile) == -1 {
							scrollLevel++;
						}
					}
				}
				
				// load selected game
				if gamepad_button_check_pressed(pad, gp_face1) {
					// load this game
					currentSaveFile = fileName;
					file_find_close();
					global.fadeDuration = 60;
					global.owner = id;
					fade = instance_create_depth(x,y,-100000,obj_fade);
				}
				
				// go back
				if gamepad_button_check_pressed(pad, gp_face2) && !instance_exists(fade) {
					state = TitleScreenState.Options;
				}
				
			} 
			// if no controller, draw a back button
			else {
				// back button
				var str = "Back";
			
				var sw = string_width(str); var sh = string_height(str);
				var xx = vw/2; var yy = 500;
				var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
				var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
			
				if (mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str) && !instance_exists(fade) {
					draw_set_color(c_white);
					if mouse_check_button_pressed(mb_left) {
						newGameName = "";
						cursorPos = 1;
						state = TitleScreenState.Options;
					}
				} else draw_set_color(c_ltgray);
			
				draw_text(xx,yy,str);
			}

			file_find_close();
			ds_list_destroy(shownFiles);
			break;
		}
		case TitleScreenState.New: {
			
			draw_set_color(c_ltgray); draw_set_font(font_big);
			draw_text(vw/2,400,"Provide filename");
			
			// entering text with a controller
			if global.gamePadIndex != noone {
				var pad = global.gamePadIndex;
				
				if newGameName == "" newGameName = "a";
				
				draw_set_font(font_big);
				// current position indicator
				var currentChar = string_char_at(newGameName,cursorPos-1);
				var cw = string_width(currentChar);
				var substr = string_copy(newGameName,0,cursorPos-1);
				var ssw = string_width(substr); var ssh = string_height(currentChar);
				var ngnx = (vw/2)-(.5*string_width(newGameName));
				var curX = ngnx+ssw;
				draw_line(curX,450+(.5*ssh),curX+cw,450+(.5*ssh));
				
				// draw prompts
				var promptsStartX = 350;
				var promptsY = 500;
				var xOffset = 20;
				var w = 0;

				w += drawPrompt("Change character",Input.PadUD,promptsStartX+w)+xOffset;
				w += drawPrompt("Move cursor",Input.PadLR,promptsStartX+w)+xOffset;
				w += drawPrompt("Delete",Input.Backspace,promptsStartX+w)+xOffset;
				w += drawPrompt("Accept",Input.F,promptsStartX+w)+xOffset;
				w += drawPrompt("Back",Input.Escape,promptsStartX+w)+xOffset;
				
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
				
				// backspace
				if gamepad_button_check_pressed(pad, gp_face3) {
					if string_length(newGameName) > 1 {
						newGameName = string_delete(newGameName, cursorPos, 1);
						cursorPos -= 1;
						if cursorPos < 1 cursorPos = 1;
					}
				}
				
				draw_set_color(c_ltgray); draw_set_font(font_big); draw_set_halign(fa_center); draw_set_valign(fa_center);
				draw_text(vw/2,450,newGameName);
				
				// start game with this save name
				if gamepad_button_check_pressed(pad, gp_face1) {
					global.fadeDuration = 60;
					global.owner = id;
					fade = instance_create_depth(x,y,-100000,obj_fade);
					//newGame();
				}
				
				// return to main menu
				if gamepad_button_check_pressed(pad, gp_face2) {
					newGameName = "";
					cursorPos = 1;
					state = TitleScreenState.Options;
				}
				
			}
			// keyboard input
			else {
				// current position indicator
				var sh = string_height("s");
				var xx = vw/2;
				var currentChar = string_char_at(newGameName,cursorPos-1);
				if (currentChar == noone || currentChar == undefined || currentChar == -1 || currentChar == "") {
					draw_line(xx,450+(.5*sh),xx+20,450+(.5*sh));
				} else {
					var cw = string_width(currentChar);
					var substr = string_copy(newGameName,0,cursorPos);
					var ssw = string_width(substr); var ssh = string_height(substr);
					var ngnx = (vw/2)-(.5*string_width(newGameName));
					var curX = ngnx+ssw;
					draw_line(curX,450+(.5*ssh),curX+20,450+(.5*ssh));
				}
				
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
				
				draw_set_color(c_ltgray); draw_set_font(font_big); draw_set_halign(fa_center); draw_set_valign(fa_center);
				draw_text(vw/2,450,newGameName);
				
				// allow for confirmation
				if string_length(newGameName) > 0 {
					if (keyboard_check_pressed(vk_enter)) {
						global.fadeDuration = 60;
						global.owner = id;
						fade = instance_create_depth(x,y,-100000,obj_fade);
						//newGame();
					}
				}
				
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
			}
			
			break;
		}
	}
	
}

