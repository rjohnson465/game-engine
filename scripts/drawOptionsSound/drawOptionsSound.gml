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
for (var i = 0; i < array_length_1d(soundOptionsArr); i++) {
			
	var str = soundOptionsArr[i];
	if is_array(str) {
		str = str[0];
	}
	var sh = string_height(str); var sw = string_width(str);
	
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
	
	// handle bgm sound case
	if str == OPT_S_BGM {
		
		var labelWidth = string_width(str);
		var curBgmGain = ds_map_find_value(optionsMapSound, OPT_S_BGM);
		if is_undefined(curBgmGain) {
			curBgmGain = global.bgmManager.bgmEmitterGain;
			ds_map_replace(optionsMapSound, OPT_S_BGM, curBgmGain);
		} else {
			// initialize bgmgain here from saved state? 
			//global.bgmManager.bgmEmitterGain = curBgmGain;
			//audio_emitter_gain(global.bgmManager.bgmEmitter, curBgmGain);
		}
		var curBgmGainPercent = curBgmGain * 100;
		
		if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
			draw_set_color(c_white);
			selectedOption = str;
		} else draw_set_color(c_ltgray);
		draw_text(xx + labelWidth + 5, yy, ": " + string(round(curBgmGainPercent)) + "%");
		
		bottomY = yy;
		
		// draw percentage bar
		var percBarW = 250; var percBarH = 5;
		var percBarY1 = yy + sh;
		var percBarY2 = percBarY1 + percBarH;
		var percBarX1 = xx - (.5 * percBarW);
		var percBarX2 = xx + (.5 * percBarW);
		
		if selectedOption == str {
			draw_set_color(c_white);
		} else draw_set_color(c_ltgray);
		draw_rectangle(percBarX1, percBarY1, percBarX2, percBarY2, false);
		
		// calculate current planchette position along bar
		var percInPixels = curBgmGain * percBarW;
		var planchetteW = 2;
		var planchetteH = 6;
		var planchetteX = percBarX1 + percInPixels;
		var planchetteX1 = planchetteX - (.5 * planchetteW);
		var planchetteX2 = planchetteX + (.5 * planchetteH);
		var planchetteY1 = percBarY1 - (.5 * planchetteH);
		var planchetteY2 = percBarY1 + (.5 * planchetteH);
		
		if mouseOverGuiRect(planchetteX1, planchetteY1, planchetteX2, planchetteY2) && mouse_check_button(mb_left) {
			draw_set_color(c_aqua);
			ds_map_replace(planchettesDraggingMap, OPT_S_BGM, true);
		}
		else if selectedOption == str || mouseOverGuiRect(planchetteX1, planchetteY1, planchetteX2, planchetteY2) {
			selectedOption = str;
			draw_set_color(c_orange);
		} else {
			draw_set_color(c_dkgray);
		}
		draw_rectangle(planchetteX1, planchetteY1, planchetteX2, planchetteY2, false);
		
		// m/k dragging handling
		if ds_map_find_value(planchettesDraggingMap, OPT_S_BGM) {
			var vx = camera_get_view_x(view_camera[0]); var vy = camera_get_view_y(view_camera[0]);
			// get percent value for current mouse x value
			var mx = mouse_x - vx; var my = mouse_y - vy;
			var nextBgmGain = curBgmGain;
			if mx < percBarX1 {
				nextBgmGain = 0;
			} else if mx > percBarX2 {
				nextBgmGain = 1;
			} else {
				var percMouse = (mx - percBarX1) / percBarW;
				nextBgmGain = percMouse;
			}
			
			// update sound in options map, and current bgm emitter gain
			ds_map_replace(optionsMapSound, OPT_S_BGM, nextBgmGain);
			global.bgmManager.bgmEmitterGain = nextBgmGain;
			audio_emitter_gain(global.bgmManager.bgmEmitter, nextBgmGain);
			
			if mouse_check_button_released(mb_left) {
				ds_map_replace(planchettesDraggingMap, OPT_S_BGM, false);
			}
		}
		
		// add a line to the drawn list, since this setting takes 2 lines
		addLine = true;
	}
	
}

// controller option toggling
if gamepad_is_connected(p) && selectedOption != noone {
	
	// toggle bgm sound
	if selectedOption == OPT_S_BGM {
		var curBgmGain = ds_map_find_value(optionsMapSound, OPT_S_BGM);
		
		if gamepad_button_check_pressed(p, gp_padr) {
			audio_play_sound(snd_ui_tab1,1,0);
			var nextBgmGain = curBgmGain + .1;
			if nextBgmGain > 1 nextBgmGain = 1;
			ds_map_replace(optionsMapSound, OPT_S_BGM, nextBgmGain);
			global.bgmManager.bgmEmitterGain = nextBgmGain;
			audio_emitter_gain(global.bgmManager.bgmEmitter, nextBgmGain);
		}
	
		if gamepad_button_check_pressed(p, gp_padl) {
			audio_play_sound(snd_ui_tab1,1,0);
			var nextBgmGain = curBgmGain - .1;
			if nextBgmGain < 0 nextBgmGain = 0;
			ds_map_replace(optionsMapSound, OPT_S_BGM, nextBgmGain);
			global.bgmManager.bgmEmitterGain = nextBgmGain;
			audio_emitter_gain(global.bgmManager.bgmEmitter, nextBgmGain);
		}
	}
}

return bottomY + sh;