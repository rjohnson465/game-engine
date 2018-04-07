// big menu screen
draw_set_color(c_gray);
draw_set_alpha(.75);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_BOTTOMRIGHT_Y,0);
draw_set_alpha(1);
	
// current menu title handle
draw_set_color(c_olive);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_X,MENUS_TOPLEFT_Y+menusHandleHeight,false);
	
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(font_main);
	
draw_text((MENUS_BOTTOMRIGHT_X+MENUS_TOPLEFT_X)/2,((MENUS_TOPLEFT_Y+menusHandleHeight)+MENUS_TOPLEFT_Y)/2,currentMenu);
	
switch currentMenu {
	case FOUNTAIN: {
		// draw options
		if selectedOption == FountainOptions.InsertGem {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X),mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y),INSERTGEM);
			
		if selectedOption == FountainOptions.BreakdownItem {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X),mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y)+25,"Break Down Item");
		draw_set_alpha(1);
		break;
	}
	
	case INSERTGEM: {
		
		// SUB MENU 1 -- select item
		
		draw_set_halign(fa_center);
		draw_text(mean(MENUS_TOPLEFT_X,MENUS_TOPLEFT_X+subMenuWidth),mean(MENUS_TOPLEFT_Y+menusHandleHeight,MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight),"Choose Item");
		
		
		break;
		
			
			
	}
}