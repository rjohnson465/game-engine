/// drawOptionsDisplay(startY)
/// @param startY
// must be called from options obj
var p = global.gamePadIndex;
var sh = string_height("s");

var booleanDisplayOptions = [
];

var startY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight+sh;
if argument_count > 0 {
	startY = argument[0];
}

var bottomY = startY;

var addLine = false;
for (var i = 0; i < array_length_1d(gameplayOptionsArr); i++) {
			
	var str = gameplayOptionsArr[i];
	if is_array(str) {
		str = str[0];
	}
	var sh = string_height(str); var sw = string_width(str);
	
	// make sure selected option is in the possible options for this submenu
	//if !arrayIncludes(gameplayOptionsArr, selectedOption) {
	//	selectedOption = noone;
	//}
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
	
	// flash overlay
	if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
		draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
		draw_set_color(c_orange);
		draw_text(xx,yy,str);
		draw_set_alpha(1);
	}
	
	// in addition to text, we must draw some widget to change the option
	
	// handle difficulty case
	if str == OPT_G_DIFFICULTY {
		
		var curDifficulty = ds_map_find_value(optionsMapGameplay, OPT_G_DIFFICULTY);
		
		// draw left arrow
		var xx = x1 + sw + 15; 
		var tw = sh*.5; // triangle width
		
		// left arrow button
		if mouseOverGuiRect(xx, yy-(sh*.5), xx+tw, yy + (sh * .5)) {
			draw_set_color(c_silver);
		} else draw_set_color(c_ltgray);
		draw_rectangle(xx+1, yy-(sh*.5)+1, xx+tw, yy + (sh * .5), false);
		
		// border
		draw_set_color(c_black);
		draw_rectangle(xx, yy-(sh*.5), xx+tw, yy + (sh * .5), true);
		
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
			if selectedOption == str {
				draw_set_color(c_orange);
			}
			else {
				draw_set_color(c_dkgray);
			}
		}
		draw_triangle(xx, yy, xx + tw, yy - (sh * .5), xx + tw, yy + (sh * .5), 0);
		
		var dw = string_width(curDifficulty);
		// draw gray box under current difficulty
		draw_set_color(c_dkgray);
		draw_rectangle(xx+tw, yy- (sh * .5), xx + tw + 5 + dw + 5, yy + (sh * .5), false);
		// draw border around current difficulty
		draw_set_color(c_black);
		draw_rectangle(xx+tw, yy- (sh * .5), xx + tw + 5 + dw + 5, yy + (sh * .5), true);
		
		// draw current difficulty name
		if selectedOption == str {
			draw_set_color(c_white);
		} else draw_set_color(c_ltgray);
		draw_set_halign(fa_left);
		draw_text(xx + tw + 5, yy, curDifficulty);
		
		
		// draw right arrow
		var xx = xx + tw + 5 + dw + 5;
		
		// right arrow button
		if mouseOverGuiRect(xx, yy-(sh*.5), xx+tw, yy + (sh * .5)) {
			draw_set_color(c_silver);
		} else draw_set_color(c_ltgray);
		draw_rectangle(xx, yy-(sh*.5), xx+tw, yy + (sh * .5), false);
		
		// border
		draw_set_color(c_black);
		draw_rectangle(xx-1, yy-(sh*.5)-1, xx+tw, yy + (sh * .5), true);
		
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
			if selectedOption == str {
				draw_set_color(c_orange);
			}
			else {
				draw_set_color(c_dkgray);
			}
		}
		draw_triangle(xx, yy - (sh * .5), xx, yy + (sh * .5), xx + tw, yy, 0);
		
		bottomY = yy;
		
		// draw difficulty flavor text
		var flavorText = ds_map_find_value(difficultyOptionsMap, curDifficulty);
		if selectedOption == str {
			draw_set_color(c_white);
		} else draw_set_color(c_ltgray);
		var xx = MENUS_TOPLEFT_X+(width/2);
		draw_set_halign(fa_center);
		draw_text(xx, yy + sh, flavorText);
		
		// add a line to the drawn list, since this setting takes 2 lines
		addLine = true;
	}
	
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

return bottomY + sh;