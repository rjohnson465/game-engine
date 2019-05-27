var canLoot = false;
with obj_item_drop {
	if distance_to_object(obj_player) < 20 && layer == global.player.layer {
		canLoot = true;
	}
}
if distance_to_object(obj_player) < 20 && global.player.isAlive && !global.isTrading && !global.canLoot && !canLoot && !global.isLooting && !global.isWishing && !global.ui.isShowingMenus &&!isInteractingWithPlayer && !isInConversation && layer == global.player.layer {
	drawPrompt("Talk with " + name, Input.F);
}

if isInteractingWithPlayer && !isInConversation && !showBuySell {
	var vx = camera_get_view_x(view_camera[0]);
	var vy = camera_get_view_y(view_camera[0]);
	
	// figure out how big the NPC conversation UI must be, based on conversations NPC has 
	var conversationsNumber = ds_list_size(conversations);
	draw_set_font(font_main); 
	var sh = string_height("s");
	var cHeight = sh * conversationsNumber;
	var paddingBetweenOptions = 5;
	var paddingHeight = (conversationsNumber - 1) * paddingBetweenOptions;
	var totalHeight = cHeight + menusHandleHeight + paddingHeight;
	
	// width is 200, or the longest conversation name width
	var totalWidth = 200;
	for (var i = 0; i < ds_list_size(conversations); i++) {
		var c = ds_list_find_value(conversations, i);
		var sw = string_width(c.name);
		if sw > totalWidth - 10 {
			totalWidth = sw + 10;
		}
	}
	
	// conversations box is centered on NPC
	var startX = x - vx - (.5*totalWidth); var startY = y - vy - (.5*totalHeight);
	var endX = startX + totalWidth; var endY = startY + totalHeight + 10; // 10px padding
	
	// entire menu
	draw_set_color(c_gray); draw_set_alpha(.95);
	draw_rectangle(startX, startY, endX, endY, 0);
	draw_set_alpha(1);
	
	// draw handle with NPC name
	draw_set_color(C_HANDLES);
	draw_rectangle(startX, startY, endX, startY + menusHandleHeight, 0);
	draw_set_color(c_white);
	draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(startX, endX), mean(startY, startY + menusHandleHeight), name);
	
	// close button
	if !gamepad_is_connected(global.player.gamePadIndex) {
		var closeButtonWidth = sprite_get_width(spr_close_button);
		var x1 = endX-closeButtonWidth; var y1 = startY;
		var x2 = x1 + closeButtonWidth; var y2 = y1 + closeButtonWidth;
		if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button(mb_left) {
			draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_black,1);	
		} else if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
			draw_sprite_ext(spr_close_button,1,x1,y1,1,1,0,c_gray,1);
		} else {
			draw_sprite(spr_close_button,1,x1,y1);
		}
		
		if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button_released(mb_left) {
			audio_play_sound(snd_ui_click1,1,0);
			isInteractingWithPlayer = false;
			global.isInteractingWithNpc = false;
			showBuySell = false;
		}
	}	
	
	// draw all conversations
	var conversationsStartX = mean(startX, endX);
	var conversationsStartY = startY + menusHandleHeight + (.5*sh) + 5;
	for (var i = 0; i < ds_list_size(conversations); i++) {
		var c = ds_list_find_value(conversations,i);
		draw_set_font(font_main); draw_set_halign(fa_center); draw_set_valign(fa_center);
		
		var sh = string_height(c.name); var sw = string_width(c.name);
		var xx = conversationsStartX; var yy = conversationsStartY+(i*sh) + (i*paddingBetweenOptions); 
		var textColor = noone;
		if mouseOverGuiRect(startX,yy-(.5*sh),endX,yy+(.5*sh)) || (selectedConversation == c && gamepad_is_connected(global.gamePadIndex)) {
			textColor = c_white;
			if selectedConversation != c {
				audio_play_sound(snd_ui_option_change,1,0);
			}
			selectedConversation = c;
			if mouse_check_button_released(mb_left) {
				startConversation(c);
			}
		} else {
			textColor = c_ltgray;
		}
		
		if selectedConversation == c {
			// draw highlight
			draw_set_color(C_HIGHLIGHT); draw_set_alpha(global.gameManager.selectedItemFilterAlpha);
			draw_rectangle(startX, yy-(.5*sh), endX, yy+(.5*sh), 0);
		}
		
		draw_set_color(textColor); draw_set_alpha(1);
		draw_text(xx,yy,c.name);
	}

	// give whole thing a border
	draw_set_color(c_black);
	draw_rectangle(startX-1, startY, endX, endY, 1);
	
	
	// prompts
	var promptsStartX = startX+18;
	var promptsY = endY+25;
	var xOffset = 20;
	var w = 0;
	if gamepad_is_connected(global.player.gamePadIndex) {
		w += drawPrompt("Select", Input.F,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
}