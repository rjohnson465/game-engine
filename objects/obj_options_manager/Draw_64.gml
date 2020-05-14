if !ui.isShowingMenus || ui.currentMenu != OPTIONS exit;

draw_set_font(font_main);
draw_set_halign(fa_center); draw_set_valign(fa_center);

var sh = string_height("s");
var yy = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight+sh;
var xx = MENUS_TOPLEFT_X+(width/2)
for (var i = 0; i < array_length_1d(optionsMapOfSubOptsArrays); i++) {
	var entry = optionsMapOfSubOptsArrays[i];
	var optCat = entry[0];
	
	// draw category
	draw_set_color(C_GOLD);
	draw_text(xx, yy, optCat);
	yy += sh + 10;
	
	draw_set_font(font_main);
	switch optCat {
		case SM_DISPLAY: {
			yy = drawOptionsDisplay(yy);
			break;
		}
		case SM_GAMEPLAY: {
			yy = drawOptionsGameplay(yy);
			break;
		}
		case SM_SOUND: {
			yy = drawOptionsSound(yy);
			break;
		}
		case "": {
			yy = drawOptionsMain(yy);
		}
	}
	
	yy += 25;
}




/*
var p = global.gamePadIndex;
// back option toggling
if gamepad_is_connected(p) {
	if gamepad_button_check_pressed(p, gp_face1) && selectedOption == OPT_BACK {
		subMenu = SM_MAIN;
		currentOptionsArr = navOptionsArr;
	}
}
else if selectedOption == OPT_BACK && mouse_check_button_released(mb_left) {
	subMenu = SM_MAIN;
	currentOptionsArr = navOptionsArr;
}