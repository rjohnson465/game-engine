var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}
if distance_to_object(obj_player) < 20 && global.player.isAlive && layer == global.player.layer && !isInConvo {
	if !isBeingLooted {
		drawPrompt("Loot Items",Input.F);
	}
}

draw_set_font(font_main); 

// loot ui
if isBeingLooted && ds_exists(items,ds_type_list) && ds_list_size(items) != 0 {

	draw_set_color(c_gray);
	draw_rectangle(topLeftX,topLeftY,bottomRightX,bottomRightY,0);
	
	// handle
	draw_set_color(C_HANDLES);
	draw_rectangle(topLeftX,topLeftY,bottomRightX,topLeftY+handleHeight,0);
	draw_set_color(c_white); draw_set_valign(fa_center); draw_set_halign(fa_center);
	var s = !instance_exists(selectedItem) ? "Loot Items" : selectedItem.name;
	if instance_exists(selectedItem) {
		// draw item name in color according to item rarity
		switch selectedItem.rarity {
			case ItemRarities.Normal: {
				draw_set_color(c_white); break;
			}
			case ItemRarities.Fine: {
				draw_set_color(c_aqua); break;
			}
			case ItemRarities.Masterwork: {
				draw_set_color(c_fuchsia); break;
			}
			case ItemRarities.Legendary: {
				draw_set_color(c_lime); break;
			}
		}
	}
	var ns = 1; // name scale
	if string_width(s) > width-2 {
		ns = (width-2)/string_width(s);
	}
	draw_text_transformed(mean(topLeftX,bottomRightX),mean(topLeftY,topLeftY+handleHeight),s,ns,1,0);
	
	var row = 1; var col = 1;
	var init_x = lootTopLeftX; var init_y = lootTopLeftY;
	//var selectedItemX = 0; var selectedItemY = 0;
	// show 20 items at a time;
	for (var i = 0; i < 10; i++) {
		row = floor(i / 5)+1;
		col = (i mod 5)+1;
		var x1 = init_x+((col-1)*slotWidth);
		var y1 = init_y+((row-1)*slotHeight);
		var index = i + (5*scrollLevel);
		var item = ds_list_find_value(items,index);
				
		if !is_undefined(item) {
			item.x1 = x1;
			item.y1 = y1;
					
			// draw slot darker if mouse over and its the nearest one to mouse
			if position_meeting(mouse_x,mouse_y,item) {
				draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.25);
			} else if selectedItem == item {
				draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.75);
			}
			else draw_sprite(spr_item_slot,1,x1,y1);
			drawItem(item,x1,y1);
		} 
	}
	
	// draw selector over selected item
	if selectedItem != noone && instance_exists(selectedItem) {
		var x1 = selectedItem.x1; var y1 = selectedItem.y1;
		draw_set_color(c_white);
		draw_rectangle(x1,y1,x1+slotWidth,y1+slotHeight,1);
	
		var topMidPointX = mean(x1,x1+slotWidth);
		draw_triangle(topMidPointX-5,y1,topMidPointX+5,y1,topMidPointX,y1+5,false);
		draw_triangle(topMidPointX-5,y1+slotHeight,topMidPointX+5,y1+slotHeight,topMidPointX,y1+slotHeight-5,false);
	
		var sideMidPoint = mean(y1,y1+global.inventory.slotHeight);
		draw_triangle(x1,sideMidPoint-5,x1,sideMidPoint+5,x1+5,sideMidPoint,false);
		draw_triangle(x1+slotWidth,sideMidPoint-5,x1+slotWidth,sideMidPoint+5,x1+slotWidth-5,sideMidPoint,false);
	}
	
	// prompts
	var promptsY = bottomRightY + 10; var promptsX = topLeftX+10; var w = 0;
	var selectedItemString = instance_exists(selectedItem) ? selectedItem.name : "Item";
	if gamepad_is_connected(global.player.gamePadIndex) {
		w += drawPrompt("Loot "+selectedItemString,Input.F,promptsX+w,promptsY);
		//w += drawPrompt("Close",Input.Escape,promptsX+w,promptsY);
	} else {
		w += drawPrompt("Loot "+selectedItemString,[Input.LMB,Input.F],promptsX+w,promptsY);
	}
}