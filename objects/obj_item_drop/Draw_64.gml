if distance_to_object(obj_player) < 20 && global.player.isAlive {
	if !isBeingLooted {
		drawPrompt("Loot Items",Input.F);
	}
}

// loot ui
if isBeingLooted && ds_list_size(items) != -1 {

	draw_set_color(c_gray);
	draw_rectangle(topLeftX,topLeftY,bottomRightX,bottomRightY,0);
	
	// handle
	draw_set_color(c_olive);
	draw_rectangle(topLeftX,topLeftY,bottomRightX,topLeftY+handleHeight,0);
	draw_set_color(c_white); draw_set_valign(fa_center); draw_set_halign(fa_center);
	var s = !instance_exists(selectedItem) ? "Loot Items" : selectedItem.name;
	draw_text(mean(topLeftX,bottomRightX),mean(topLeftY,topLeftY+handleHeight),s);
	
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