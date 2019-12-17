/// drawOptionsDisplay()
// must be called from options obj
var p = global.gamePadIndex;
var sh = string_height("s");

var booleanDisplayOptions = [
];

var startY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight+sh;

var addLine = false;
for (var i = 0; i < array_length_1d(currentOptionsArr); i++) {
			
	var str = currentOptionsArr[i];
	var sh = string_height(str); var sw = string_width(str);
	var optVal = ds_map_find_value(optionsMapDisplay, str);
	
	// make sure selected option is in the possible options for this submenu
	if !arrayIncludes(currentOptionsArr, selectedOption) {
		selectedOption = noone;
	}
	if selectedOption == noone && gamepad_is_connected(p) {
		selectedOption = str;
	} else if !gamepad_is_connected(p) {
		selectedOption = noone;
	}
			
	var xx = MENUS_TOPLEFT_X+(width/2); var yy = startY+(i*sh);
	if addLine {
		yy += sh;
	}
	var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
	var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
			
	if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
		draw_set_color(c_white);
		selectedOption = str;
	} else draw_set_color(c_ltgray);
			
	draw_text(xx,yy,str);
	
	// in addition to text, we must draw some widget to change the option
	
	// handle difficulty case
	if str == OPT_G_DIFFICULTY {
		
		var curDifficulty = ds_map_find_value(optionsMapGameplay, OPT_G_DIFFICULTY);
		
		// draw left arrow
		var xx = x1 + sw + 15; 
		var tw = sh*.5; // triangle width
		// click handler for left arrow 
		if mouseOverGuiRect(xx, yy-(sh*.5), xx+tw, yy + (sh * .5)) {
			draw_set_color(c_aqua);
			selectedOption = str;
			if mouse_check_button_released(mb_left) {
				audio_play_sound(snd_ui_tab1,1,0);
				var curIndex = arrayGetIndex(difficultyOptionsArr, curDifficulty);
				var nextIndex = curIndex - 1;
				if nextIndex < 0 {
					nextIndex = array_length_1d(difficultyOptionsArr)-1;
				}
				var newDiff = difficultyOptionsArr[nextIndex];
				ds_map_replace(optionsMapGameplay, OPT_G_DIFFICULTY, newDiff);
			}
		}
		else {
			draw_set_color(c_orange);
		}
		draw_triangle(xx, yy, xx + tw, yy - (sh * .5), xx + tw, yy + (sh * .5), 0);
		
		// draw current difficulty name
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_text(xx + tw + 5, yy, curDifficulty);
		var dw = string_width(curDifficulty);
		
		// draw right arrow
		var xx = xx + tw + 5 + dw + 5;
		// click handler for right arrow 
		if mouseOverGuiRect(xx, yy-(sh*.5), xx+tw, yy + (sh * .5)) {
			
			draw_set_color(c_aqua);
			selectedOption = str;
			if mouse_check_button_released(mb_left) {
				audio_play_sound(snd_ui_tab1,1,0);
				var curIndex = arrayGetIndex(difficultyOptionsArr, curDifficulty);
				var nextIndex = curIndex + 1;
				if array_length_1d(difficultyOptionsArr) - 1 < nextIndex {
					nextIndex = 0;
				}
				var newDiff = difficultyOptionsArr[nextIndex];
				ds_map_replace(optionsMapGameplay, OPT_G_DIFFICULTY, newDiff);
			}
		}
		else {
			draw_set_color(c_orange);
		}
		draw_triangle(xx, yy - (sh * .5), xx, yy + (sh * .5), xx + tw, yy, 0);
		
		
		
		// draw difficulty flavor text
		var flavorText = ds_map_find_value(difficultyOptionsMap, curDifficulty);
		draw_set_color(c_white);
		var xx = MENUS_TOPLEFT_X+(width/2);
		draw_set_halign(fa_center);
		draw_text(xx, yy + sh, flavorText);
		
		// add a line to the drawn list, since this setting takes 2 lines
		addLine = true;
	}
	
	/*
	// click handler for displayOptions
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) {
		switch str {
			case OPT_D_ENEMYPOISE: {
				var oldValue = ds_map_find_value(optionsMapDisplay, OPT_D_ENEMYPOISE);
				var newValue = !oldValue;
				ds_map_replace(optionsMapDisplay,OPT_D_ENEMYPOISE,newValue);
				break;
			}
		}
	} */
	
}

// controller option toggling
if gamepad_is_connected(p) && selectedOption != noone {
	
	// toggle difficulty
	if selectedOption == OPT_G_DIFFICULTY {
		var curDifficulty = ds_map_find_value(optionsMapGameplay, OPT_G_DIFFICULTY);
		if gamepad_button_check_pressed(p, gp_padr) {
			audio_play_sound(snd_ui_tab1,1,0);
			var curIndex = arrayGetIndex(difficultyOptionsArr, curDifficulty);
			var nextIndex = curIndex + 1;
			if array_length_1d(difficultyOptionsArr) - 1 < nextIndex {
				nextIndex = 0;
			}
			var newDiff = difficultyOptionsArr[nextIndex];
			ds_map_replace(optionsMapGameplay, OPT_G_DIFFICULTY, newDiff);
		}
	
		if gamepad_button_check_pressed(p, gp_padl) {
			audio_play_sound(snd_ui_tab1,1,0);
			var curIndex = arrayGetIndex(difficultyOptionsArr, curDifficulty);
			var nextIndex = curIndex - 1;
			if nextIndex < 0 {
				nextIndex = array_length_1d(difficultyOptionsArr)-1;
			}
			var newDiff = difficultyOptionsArr[nextIndex];
			ds_map_replace(optionsMapGameplay, OPT_G_DIFFICULTY, newDiff);
		}
	}
}