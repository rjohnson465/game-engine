var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

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

// close button
if !gamepad_is_connected(global.player.gamePadIndex) {
	var closeButtonWidth = sprite_get_width(spr_close_button);
	var x1 = MENUS_BOTTOMRIGHT_X-closeButtonWidth; var y1 = MENUS_TOPLEFT_Y;
	var x2 = x1 + closeButtonWidth; var y2 = y1 + closeButtonWidth;
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button(mb_left) {
		draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_black,1);
	} else if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
		draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_gray,1);
	} else {
		draw_sprite(spr_close_button,1,x1,y1);
	}
	//draw_sprite(spr_close_button,1,MENUS_BOTTOMRIGHT_X-closeButtonWidth,MENUS_TOPLEFT_Y);
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
		
		if selectedOption == REPAIRITEM {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH+50,REPAIRITEM);
		draw_set_alpha(1);
		
		if selectedOption == LEAVEFOUNTAIN {
			draw_set_alpha(1);
		} else draw_set_alpha(.5);
		draw_text(midW,midH+75,LEAVEFOUNTAIN);
		draw_set_alpha(1);
		
		// prompts
		var promptsStartX = MENUS_TOPLEFT_X+18;
		var promptsY = MENUS_BOTTOMRIGHT_Y+25;
		var xOffset = 20;
		var w = 0;
		if gamepad_is_connected(global.player.gamePadIndex) {
			w += drawPrompt("Select", Input.F,promptsStartX+w,promptsY)+xOffset;
			w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
		}
		
		break;
	}
}