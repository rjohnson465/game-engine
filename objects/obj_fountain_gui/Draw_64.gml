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
		
		var midW = mean(MENUS_TOPLEFT_X,MENUS_BOTTOMRIGHT_X); var midH = mean(MENUS_TOPLEFT_Y,MENUS_BOTTOMRIGHT_Y);
		
		/*
		// click zones
		for (var i = 0; i < ds_list_size(menuOptions); i++) {
			draw_set_color(c_red);
			var opt = ds_list_find_value(menuOptions,i);
			var w = string_width(opt); var h = string_height(opt);
			var yy = midH+((i)*25);
			var x1 = midW-(.5*w); var y1 = yy-(.5*h);
			var x2 = midW+w; var y2 = yy+h;
			draw_rectangle(x1,y1,x2,y2,1);
		}*/
		
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