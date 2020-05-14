/// drawOptionsMain(startY)
/// @param startY
/// draw the main options menu

// must be called from options obj

var p = global.gamePadIndex;
var sh = string_height("s");

if !gamepad_is_connected(p) {
	selectedOption = noone;
}

var startY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight+sh;
if argument_count > 0 {
	startY = argument[0];
}

var bottomY = startY;

for (var i = 0; i < array_length_1d(navOptionsArr); i++) {
			
	var str = navOptionsArr[i];
	var sh = string_height(str); var sw = string_width(str);
			
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
	var x1 = xx-(.5*sw) - 15; var y1 = yy-(.5*sh) - 15;
	var x2 = xx+(.5*sw) + 15; var y2 = yy+(.5*sh) + 15;
			
	
			
	// draw button around text
	draw_set_color(C_HANDLES);
	draw_rectangle(x1, y1, x2, y2, false);
	// flashing overlay
	if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str { 
		draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
		draw_set_color(c_orange);
		draw_rectangle(x1, y1, x2, y2, false);
	}
	// border
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_rectangle(x1-1, y1-1, x2, y2, true);
	// text
	if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
		draw_set_color(c_white);
		selectedOption = str;
	} else draw_set_color(c_ltgray);
	draw_text(xx,yy,str);
	
	bottomY = yy;
			
	// click handler for main navOptionsArr
	if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) {
		audio_play_sound(snd_ui_tab1,1,0);
		switch str {
			case NAV_SAVEEXIT: {
				// all instances must be activated, so they can be destroyed / cleaned up
				global.activateAll = true;
				global.ui.isShowingMenus = false;
				global.fadeDuration = 60;
				global.owner = id;
				fade = instance_create_depth(x,y,-1000000,obj_fade);
				break;
			}
			case NAV_DISPLAY: {
				subMenu = SM_DISPLAY;
				currentOptionsArr = displayOptionsArr;
				break;
			}
			case NAV_GAMEPLAY: {
				subMenu = SM_GAMEPLAY;
				currentOptionsArr = gameplayOptionsArr;
				break;
			}
		}
	}
}
if gamepad_is_connected(p) {
	if gamepad_button_check_pressed(p, gp_face1) && selectedOption != noone {
		audio_play_sound(snd_ui_tab1,1,0);
		switch selectedOption {
			case NAV_SAVEEXIT: {
				// all instances must be activated, so they can be destroyed / cleaned up
				global.activateAll = true;
				global.ui.isShowingMenus = false;
				global.fadeDuration = 60;
				global.owner = id;
				fade = instance_create_depth(x,y,-1000000,obj_fade);
				break;
			}
			case NAV_DISPLAY: {
				subMenu = SM_DISPLAY;
				currentOptionsArr = displayOptionsArr;
				break;
			}
			case NAV_GAMEPLAY: {
				subMenu = SM_GAMEPLAY;
				currentOptionsArr = gameplayOptionsArr;
				break;
			}
		}
	}
}

return bottomY;