/// drawOptionsDisplay(startY)
/// @param startY
// must be called from options obj
// return bottomY 

var p = global.gamePadIndex;
var sh = string_height("s");

var booleanDisplayOptions = [
	OPT_D_ENEMYPOISE,
	OPT_D_PLAYERPOISE,
	OPT_D_TUTORIALS,
	OPT_D_SMALLHEALTHBARS,
	OPT_D_DAMAGENUMBERS,
	OPT_D_FULLSCREEN
];

if !gamepad_is_connected(p) {
	selectedOption = noone;
}

var startY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight+sh;
if argument_count > 0 {
	startY = argument[0];
}

var bottomY = startY;
for (var i = 0; i < array_length_1d(displayOptionsArr); i++) {
			
	var str = displayOptionsArr[i];
	if is_array(str) {
		str = str[0];
	}
	var sh = string_height(str); var sw = string_width(str);
	var optVal = ds_map_find_value(optionsMapDisplay, str);
	
	if str == OPT_D_FULLSCREEN && window_get_fullscreen() && !optVal {
		optVal = true;
		ds_map_replace(optionsMapDisplay,OPT_D_FULLSCREEN,optVal)
	}
	if str == OPT_D_FULLSCREEN && !window_get_fullscreen() && optVal {
		optVal = false;
		ds_map_replace(optionsMapDisplay,OPT_D_FULLSCREEN,optVal)
	}
	
	// make sure selected option is in the possible options for this submenu
	//if !arrayIncludes(currentOptionsArr, selectedOption) {
	//	selectedOption = noone;
	//}
	if selectedOption == noone && gamepad_is_connected(p) {
		selectedOption = str;
	} else if !gamepad_is_connected(p) {
		selectedOption = noone;
	}
			
	var xx = MENUS_TOPLEFT_X+(width/2); var yy = startY+(i*sh);
	var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
	var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
			
	if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
		draw_set_color(c_white);
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
	
	// if option is boolean, this is a radio button
	if arrayIncludes(booleanDisplayOptions, str) {
		draw_set_color(c_white);
		var xx = x1 + sw + 15; 
		draw_circle(xx, yy, 5, 0);
		draw_set_color(c_black);
		draw_circle(xx, yy, 5, 1);
		
		// if the option is currently true, the radio is checked
		if optVal {
			draw_set_color(c_orange);
			draw_circle(xx,yy,3,0);
		}
	}
	
	if mouseOverGuiRect(x1, y1, x2, y2) {
		selectedOption = str;
	}
	
	bottomY = yy;
	
	// click handler for displayOptions
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) {
		audio_play_sound(snd_ui_tab1,1,0);
		// if its a boolean option, just toggle it
		if arrayIncludes(booleanDisplayOptions, selectedOption) {
			var oldValue = ds_map_find_value(optionsMapDisplay, selectedOption);
			var newValue = !oldValue;
			ds_map_replace(optionsMapDisplay,selectedOption,newValue);
			
			// if its the fullscreen option, change fullscreen
			if selectedOption == OPT_D_FULLSCREEN {
				window_set_fullscreen(newValue);
			}
		}
		// otherwise, more specific action may be needed...
		else {
			switch selectedOption {
				default: {
					break;
				}
			}
		}
	} 
	
}

// controller option toggling
if gamepad_is_connected(p) {
	if gamepad_button_check_pressed(p, gp_face1) && selectedOption != noone {
		audio_play_sound(snd_ui_tab1,1,0);
		// if its a boolean option, just toggle it
		if arrayIncludes(booleanDisplayOptions, selectedOption) {
			var oldValue = ds_map_find_value(optionsMapDisplay, selectedOption);
			var newValue = !oldValue;
			ds_map_replace(optionsMapDisplay,selectedOption,newValue);
			
			// if its the fullscreen option, change fullscreen
			if selectedOption == OPT_D_FULLSCREEN {
				window_set_fullscreen(newValue);
			}
		}
		// otherwise, more specific action may be needed...
		else {
			switch selectedOption {
				default: {
					break;
				}
			}
		}
	}
}

return bottomY + sh;