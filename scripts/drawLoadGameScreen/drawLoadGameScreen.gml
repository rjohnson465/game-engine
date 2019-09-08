/// drawGameLoadScreen()

var vw = view_get_wport(view_camera[0]);
draw_set_font(font_main);
var pad = global.gamePadIndex;
			
// load box
draw_set_color(c_gray);
draw_set_alpha(.5);
draw_rectangle(loadBoxTopLeftX, loadBoxTopLeftY, loadBoxBottomRightX, loadBoxBottomRightY, 0);

// outline
draw_set_alpha(1);
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
var hasSetSelectedFile = false;
while fileName != ""
{
	// do not show the internal use temp enemydata / roomdata files
	while (fileName == TEMP_ENEMYDATA_FILENAME || fileName == TEMP_ROOMDATA_FILENAME) {
		fileName = file_find_next();
	}
	if fileName != "" && fileName != pointer_null {
		var sw = string_width(fileName); var sh = string_height(fileName);
		var xx = vw/2; var yy = startY+(i*sh);
		if yy > loadBoxBottomRightY-sh break;
				
		if (selectedFile == noone || selectedFile == "") && gamepad_is_connected(global.gamePadIndex) {
			selectedFile = fileName;
		} 
		/*else if !gamepad_is_connected(pad) {
			selectedFile = noone;
		}*/
				
		ds_list_add(shownFiles,fileName);
		// var x1 = xx-(.5*sw); 
		var x1 = loadBoxTopLeftX + 1;
		var y1 = yy-(.5*sh);
		// var x2 = xx+(.5*sw); 
		var x2 = scrollBarTopLeftX - 1;
		var y2 = yy+(.5*sh);
				
		if ((gamepad_is_connected(pad) && fileName == selectedFile) || mouseOverGuiRect(x1,y1,x2,y2)) && !isConfirmingDestroySaveFile {
			if fileName != selectedFile {
				audio_play_sound(snd_ui_option_change,1,0);
			}
			selectedFile = fileName;
			hasSetSelectedFile = true;
			draw_set_color(c_white);
			if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) && !isConfirmingDestroySaveFile {
				// load this game
				currentSaveFile = fileName;
				file_find_close();
				global.fadeDuration = 60;
				global.owner = id;
				fade = instance_create_depth(x,y,-100000,obj_fade);
				audio_play_sound(snd_shield_hit_metal,1,0);
				
			}
			if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_right) && !isConfirmingDestroySaveFile {
				// delete this game
				audio_play_sound(snd_ui_click1, 1, 0);
				alarm[1] = 2;
				isConfirmingDestroySaveFile = true;
			}
		} else {
			draw_set_color(c_ltgray);
			/* if !gamepad_is_connected(pad) && !isConfirmingDestroySaveFile && selectedFile == noone {
				selectedFile = noone;
			} */
		}
		
		// draw flickering highlight for selected file, if one exists
		if selectedFile != "" && selectedFile != noone && selectedFile == fileName && hasSetSelectedFile {
			draw_set_alpha(selectedItemFilterAlpha);
			var textCol = draw_get_color();
			draw_set_color(C_HIGHLIGHT);
			draw_rectangle(x1, y1, x2, y2, 0);
			draw_set_color(textCol);
			draw_set_alpha(1);
		}
		
		draw_text(vw/2,yy,fileName);
		fileName = file_find_next();
		i += 1;
	} else fileName = "";
}

if !hasSetSelectedFile && !isConfirmingDestroySaveFile {
	selectedFile = noone;
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
	w += drawPrompt("Delete file",Input.Backspace,promptsStartX+w)+xOffset;
	w += drawPrompt("Back",Input.Escape,promptsStartX+w)+xOffset;
				
				
	if gamepad_button_check_pressed(pad, gp_padu) && !isConfirmingDestroySaveFile && ds_list_size(shownFiles) > 0 {
		audio_play_sound(snd_ui_option_change,1,0);
		var f = file_find_first(working_directory + "*.sav",fa_directory);
		var prev = noone;
		while f != selectedFile {
			if f != TEMP_ENEMYDATA_FILENAME && f != TEMP_ROOMDATA_FILENAME {
				prev = f;
			}
			f = file_find_next();
			if f == TEMP_ENEMYDATA_FILENAME || f == TEMP_ROOMDATA_FILENAME {
				f = file_find_next();
			}
		}
		if prev != noone && prev != "" {
			selectedFile = prev;
			if ds_list_find_index(shownFiles,selectedFile) == -1 {
				scrollLevel--;
			}
		}
	}
				
	if gamepad_button_check_pressed(pad, gp_padd) && !isConfirmingDestroySaveFile && ds_list_size(shownFiles) > 0 {
		audio_play_sound(snd_ui_option_change,1,0);
		var f = file_find_first(working_directory + "*.sav",fa_directory);
		var next = noone;
		var pos = 0;
		while f != selectedFile {
			f = file_find_next();
			pos += 1;
		}
		f = file_find_first(working_directory + "*.sav",fa_directory);
		var j = 0;
		while j <= pos || next == TEMP_ENEMYDATA_FILENAME || next == TEMP_ROOMDATA_FILENAME {
			next = file_find_next();
			j++;
		}

		if next != "" && next != noone {
			selectedFile = next;
			if ds_list_find_index(shownFiles,selectedFile) == -1 {
				scrollLevel++;
			}
		}
	}
				
	// load selected game
	if gamepad_button_check_pressed(pad, gp_face1) && !isConfirmingDestroySaveFile 
		&& alarm[1] <= 0 && selectedFile != noone && selectedFile != pointer_null 
		&& selectedFile != undefined 
		&& ds_list_size(shownFiles) > 0 {
		// load this game
		currentSaveFile = selectedFile;
		file_find_close();
		global.fadeDuration = 60;
		global.owner = id;
		fade = instance_create_depth(x,y,-100000,obj_fade);
		audio_play_sound(snd_shield_hit_metal,1,0);
	}
	
	// delete selected game
	if gamepad_button_check_pressed(pad, gp_face3) && !isConfirmingDestroySaveFile
		&& selectedFile != noone && selectedFile != pointer_null && selectedFile != undefined 
		&& ds_list_size(shownFiles) > 0 {
		// delete this game
		audio_play_sound(snd_ui_click1, 1, 0);
		isConfirmingDestroySaveFile = true;
		alarm[1] = 1;
	}
				
	// go back
	if gamepad_button_check_pressed(pad, gp_face2) && !instance_exists(fade) && !isConfirmingDestroySaveFile {
		audio_play_sound(snd_ui_tab1,1,0);
		state = TitleScreenState.Options;
	}
				
} 
// if no controller, draw a back button
else {
	
	// m/k prompts
	var promptsStartX = 350;
	var promptsY = 500;
	var xOffset = 20;
	var w = 0;

	w += drawPrompt("Select file",Input.Mouse,promptsStartX+w)+xOffset;
	w += drawPrompt("Load",Input.LMB,promptsStartX+w)+xOffset;
	w += drawPrompt("Delete file",Input.RMB,promptsStartX+w)+xOffset;
	
	// back button
	var str = "Back";
			
	var sw = string_width(str); var sh = string_height(str);
	var xx = vw/2; var yy = 500;
	var x1 = xx-(.5*sw)-5; var y1 = yy-(.5*sh)-5;
	var x2 = xx+(.5*sw) + 5; var y2 = yy+(.5*sh) + 5;
	
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	
	draw_set_color(c_gray);
	draw_rectangle(x1, y1, x2, y2, 0);
			
	if (mouseOverGuiRect(x1,y1,x2,y2) || (gamepad_is_connected(pad) && selectedOption == str)) && !instance_exists(fade) && !isConfirmingDestroySaveFile {
		if selectedOption != str {
			audio_play_sound(snd_ui_option_change,1,0);
			selectedOption = str;
		}
		
		// if mousing over back button, show selection highlight
		draw_set_color(C_HIGHLIGHT);
		draw_set_alpha(selectedItemFilterAlpha);
		draw_rectangle(x1, y1, x2, y2, 0);
		draw_set_alpha(1);
		
		draw_set_color(c_white);
		if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) {
			audio_play_sound(snd_ui_tab1,1,0);
			newGameName = "";
			cursorPos = 1;
			state = TitleScreenState.Options;
		}
	} else {
		draw_set_color(c_ltgray);
		if !gamepad_is_connected(pad) {
			selectedOption = noone;
		}
	}
			
	draw_text(xx,yy,str);
	
	// back button outline
	draw_set_color(c_black);
	draw_rectangle(x1, y1, x2, y2, 1);
}

file_find_close();
ds_list_destroy(shownFiles); shownFiles = -1;