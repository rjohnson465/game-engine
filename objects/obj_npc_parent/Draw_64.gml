/*var canLoot = false;
with obj_item_drop {
	if distance_to_object(obj_player) < 20 && layer == global.player.layer {
		canLoot = true;
	}
}
if distance_to_object(obj_player) < 20 && global.player.isAlive && !global.canLoot && !canLoot && !global.isLooting && !global.isWishing && !global.ui.isShowingMenus &&!isInteractingWithPlayer && !isInConversation && layer == global.player.layer {
	drawPrompt("Talk with " + name, Input.F);
}

if isInteractingWithPlayer && !isInConversation && !showBuySell {
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
	
	draw_text((MENUS_BOTTOMRIGHT_X+MENUS_TOPLEFT_X)/2,((MENUS_TOPLEFT_Y+menusHandleHeight)+MENUS_TOPLEFT_Y)/2,name);
	
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
		
		if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button_released(mb_left) {
			isInteractingWithPlayer = false;
			global.isInteractingWithNpc = false;
			showBuySell = false;
		}
	}	
	
	// draw all conversations
	if true {
		if !gamepad_is_connected(global.player.gamePadIndex) {
			selectedConversation = noone;
		}
		for (var i = 0; i < ds_list_size(conversations); i++) {
			var c = ds_list_find_value(conversations,i);
			draw_set_font(font_main); draw_set_halign(fa_center); 
		
			var sh = string_height(c.name); var sw = string_width(c.name);
			var xx = conversationsStartX; var yy = conversationsStartY+(i*sh)+5;
			if !gamepad_is_connected(global.player.gamePadIndex) && point_in_rectangle(mouse_x,mouse_y,vx+(xx-(.5*sw)),vy+(yy-(.5*sh)),vx+(xx+(.5*sw)),vy+(yy+(.5*sh))) || selectedConversation == c {
				draw_set_color(c_white);
				selectedConversation = c;
			} else {
				draw_set_color(c_ltgray);
			}
			draw_text(xx,yy,c.name);
		}
	}
	
	
	// prompts
	var promptsStartX = MENUS_TOPLEFT_X+18;
	var promptsY = MENUS_BOTTOMRIGHT_Y+25;
	var xOffset = 20;
	var w = 0;
	if gamepad_is_connected(global.player.gamePadIndex) {
		w += drawPrompt("Select", Input.F,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
}
