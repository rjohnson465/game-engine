if !ui.isShowingMenus || ui.currentMenu != OPTIONS exit;

var p = global.player;
var pad = p.gamePadIndex;

draw_set_font(font_main);
draw_set_halign(fa_center); draw_set_valign(fa_center);

switch subMenu {
	
	case SMMAIN: {
		
		var sh = string_height("s");
		var startY = MENUS_TOPLEFT_Y+ui.menusHandleHeight+ui.menuTabsHeight+sh;
		for (var i = 0; i < array_length_1d(options); i++) {
			
			var str = options[i];
			var sh = string_height(str); var sw = string_width(str);
			
			if selectedOption == noone && gamepad_is_connected(global.gamePadIndex) {
				selectedOption = str;
			} else if !gamepad_is_connected(global.gamePadIndex) {
				selectedOption = noone;
			}
			
			var xx = MENUS_TOPLEFT_X+(width/2); var yy = startY+(i*sh);
			var x1 = xx-(.5*sw); var y1 = yy-(.5*sh);
			var x2 = xx+(.5*sw); var y2 = yy+(.5*sh);
			
			if mouseOverGuiRect(x1,y1,x2,y2) || selectedOption == str {
				draw_set_color(c_white);
			} else draw_set_color(c_ltgray);
			
			draw_text(xx,yy,str);
			
			// click handler for main options
			if mouseOverGuiRect(x1,y1,x2,y2) && mouse_check_button_pressed(mb_left) {
				switch str {
					case SAVEEXIT: {
						global.ui.isShowingMenus = false;
						global.fadeDuration = 60;
						global.owner = id;
						fade = instance_create_depth(x,y,-1000000,obj_fade);
						break;
					}
				}
			}
		}
		if gamepad_is_connected(global.gamePadIndex) {
			if gamepad_button_check_pressed(global.gamePadIndex, gp_face1) && selectedOption != noone {
				switch selectedOption {
					case SAVEEXIT: {
						global.ui.isShowingMenus = false;
						global.fadeDuration = 60;
						global.owner = id;
						fade = instance_create_depth(x,y,-1000000,obj_fade);
						break;
					}
				}
			}
		}
	} // end case SMMAIN
}