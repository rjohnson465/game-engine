// big menu screen
draw_set_color(c_gray);
draw_set_alpha(.75);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_BOTTOMRIGHT_Y,0);
draw_set_alpha(1);
	
// current menu title handle
draw_set_color(C_HANDLES);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+menusHandleHeight,false);
	
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(font_main);
	
draw_text((MENUS_BOTTOMRIGHT_X+MENUS_TOPLEFT_X)/2,((MENUS_TOPLEFT_Y+menusHandleHeight)+MENUS_TOPLEFT_Y)/2,currentMenu);
	
if !gamepad_is_connected(global.player.gamePadIndex) {
	var closeButtonWidth = sprite_get_width(spr_close_button);
	draw_sprite(spr_close_button,1,MENUS_BOTTOMRIGHT_X-closeButtonWidth,MENUS_TOPLEFT_Y);
}	

switch currentMenu {
	case FOUNTAIN: {
		
		var midW = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X); var midH = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y);
		
		draw_set_color(c_white);
		// draw options
		if selectedOption == INSERTGEM {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH,INSERTGEM);
			
		if selectedOption == BREAKDOWNITEM {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH+25,BREAKDOWNITEM);
		draw_set_alpha(1);
		
		if selectedOption == LEAVEFOUNTAIN {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH+50,LEAVEFOUNTAIN);
		draw_set_alpha(1);
		
		//draw_rectangle(insertGemTopLeftX,insertGemTopLeftY,insertGemBottomRightX,insertGemBottomRightY,0);
		//draw_point(insertGemTopLeftX,insertGemTopLeftY);
		
		break;
	}
}