/// drawNewGameScreen()

var vw = view_get_wport(view_camera[0]);
draw_set_color(c_ltgray); draw_set_font(font_big);
draw_text(vw/2,400,"Provide filename");
var pad = global.gamePadIndex;
			
// entering text with a controller
if global.gamePadIndex != noone {
	
				
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
	var xOffset = 20;
	var w = 0;

	w += drawPrompt("Change character",Input.PadUD,promptsStartX+w)+xOffset;
	w += drawPrompt("Move cursor",Input.PadLR,promptsStartX+w)+xOffset;
	w += drawPrompt("Delete",Input.Backspace,promptsStartX+w)+xOffset;
	w += drawPrompt("Accept",Input.F,promptsStartX+w)+xOffset;
	w += drawPrompt("Back",Input.Escape,promptsStartX+w)+xOffset;
				
	if gamepad_button_check_pressed(pad, gp_padu) && !isConfirmingDestroySaveFile {
		var char = string_char_at(newGameName,cursorPos); 
		audio_play_sound(snd_ui_option_change,1,0);
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
				
	if gamepad_button_check_pressed(pad, gp_padd) && !isConfirmingDestroySaveFile {
		var char = string_char_at(newGameName,cursorPos); 
		audio_play_sound(snd_ui_option_change,1,0);
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
				
	if gamepad_button_check_pressed(pad, gp_padr) && !isConfirmingDestroySaveFile {
		audio_play_sound(snd_ui_tab1,1,0);
		cursorPos += 1;
		if cursorPos > string_length(newGameName) {
			newGameName = string_insert("a",newGameName,cursorPos);
		}
		if cursorPos > string_length(newGameName) cursorPos = string_length(newGameName);
	}
				
	if gamepad_button_check_pressed(pad, gp_padl) && !isConfirmingDestroySaveFile {
		audio_play_sound(snd_ui_tab1,1,0);
		cursorPos -= 1;
		if cursorPos < 1 cursorPos = 1;
	}
				
	// backspace
	if gamepad_button_check_pressed(pad, gp_face3) && !isConfirmingDestroySaveFile {
		audio_play_sound(snd_ui_tab2,1,0);
		if string_length(newGameName) > 1 {
			newGameName = string_delete(newGameName, cursorPos, 1);
			cursorPos -= 1;
			if cursorPos < 1 cursorPos = 1;
		}
	}
				
	draw_set_color(c_ltgray); draw_set_font(font_big); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(vw/2,450,newGameName);
				
	// start game with this save name (but make sure we're not overriding internal use files)
	if gamepad_button_check_pressed(pad, gp_face1) && newGameName != TEMP_ENEMYDATA_FILENAME && newGameName != TEMP_ROOMDATA_FILENAME && !isConfirmingDestroySaveFile {
		maybeStartNewGame();		
	}
				
	// return to main menu
	if gamepad_button_check_pressed(pad, gp_face2) && !isConfirmingDestroySaveFile {
		audio_play_sound(snd_ui_tab1,1,0);
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
	if keyboard_check_pressed(vk_backspace) && !isConfirmingDestroySaveFile {
		audio_play_sound(snd_ui_tab2,1,0);
		newGameName = string_delete(newGameName, cursorPos-1, 1);
		cursorPos-=1; 
		if cursorPos < 1 cursorPos = 1;
	}
				
	if (keyboard_string != "") && !isConfirmingDestroySaveFile {
			var t = keyboard_string;
			audio_play_sound(snd_ui_tab1,1,0);
			newGameName = string_insert(t, newGameName, cursorPos)
			cursorPos += string_length(t)
			keyboard_string = ""
	} else if isConfirmingDestroySaveFile {
		// keyboard_string = newGameName;
	}
				
	draw_set_color(c_ltgray); draw_set_font(font_big); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(vw/2,450,newGameName);
				
	// allow for confirmation
	if string_length(newGameName) > 0 {
		if keyboard_check_pressed(vk_enter) && !isConfirmingDestroySaveFile {
			maybeStartNewGame();
		}
	}
	
	// m/k prompts
	
	var promptsStartX = 350;
	var xOffset = 20;
	var w = 0;

	w += drawPrompt("Type your name", noone ,promptsStartX+w)+xOffset;
	w += drawPrompt("Accept",Input.Enter,promptsStartX+w)+xOffset;
				
	// back button
	var str = "Back";
			
	var sw = string_width(str); var sh = string_height(str);
	var xx = vw/2; var yy = 500;
	var x1 = xx-(.5*sw)-5; var y1 = yy-(.5*sh)-5;
	var x2 = xx+(.5*sw) + 5; var y2 = yy+(.5*sh) + 5;
	
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	
	draw_set_color(c_gray);
	draw_rectangle(x1, y1, x2, y2, 0);
			
	if (mouseOverGuiRect(x1,y1,x2,y2) || (gamepad_is_connected(pad) && selectedOption == str)) && !isConfirmingDestroySaveFile {
		if selectedOption != str {
			audio_play_sound(snd_ui_option_change,1,0);
			selectedOption = str;
		}
		
		// if mousing over back button, show selection highlight
		draw_set_color(c_orange);
		draw_set_alpha(selectedItemFilterAlpha);
		draw_rectangle(x1, y1, x2, y2, 0);
		draw_set_alpha(1);
		
		draw_set_color(c_white);
		if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) && !isConfirmingDestroySaveFile {
			audio_play_sound(snd_ui_tab1,1,0);
			newGameName = "";
			cursorPos = 1;
			state = TitleScreenState.Options;
		}
	} else {
		if !gamepad_is_connected(pad) {
			selectedOption = noone;
		}
		draw_set_color(c_ltgray);
	}
		
	// back button text
	draw_text(xx,yy,str);
	
	// back button outline
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, 1);
}