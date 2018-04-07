if global.fountainGui.currentSubMenu != NAMEPRICE {
	draw_set_alpha(.2);
} else {
	draw_set_alpha(1);
}

draw_set_halign(fa_center); draw_set_valign(fa_center); draw_set_color(c_white);
draw_text(mean(topLeftX,topLeftX+width),mean(MENUS_TOPLEFT_Y+menusHandleHeight,MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight),"Name Price");

// named price box
var x1 = topLeftX+1 var y1 = topLeftY+1+subMenuTitleHeight;
var x2 = topLeftX+1+(width-1); var y2 = topLeftY+1+subMenuTitleHeight+25;
draw_set_color(c_black);
draw_rectangle(x1,y1,x2,y2,0);
draw_set_color(c_white);
draw_rectangle(x1,y1,x2,y2,1);
draw_text(mean(x1,x2),mean(y1,y2),string(namedPrice));

draw_set_valign(fa_top);
// options
for (var i = 0; i < ds_list_size(allPriceIncrements); i++) {
	var str = ds_list_find_value(allPriceIncrements,i);
	if selectedPriceIncrease == str {
		draw_set_alpha(1);
	} else {
		draw_set_alpha(.5);
	}
	draw_text(mean(x1,x2),y2+(25*i),str);
}

// likeliness of it working
odds = namedPrice >= guaranteedPrice ? 100 : 0;
draw_text(mean(x1,x2),y2+((ds_list_size(allPriceIncrements)+1)*25),"Odds of it working: " + string(odds) + "%" );


/*
// basically show the inventory, filtered for only socketed items
// SCROLL BAR 2 (for select gem menu)
draw_set_color(c_black);
draw_rectangle(scrollBarTopLeftX,scrollBarTopLeftY,scrollBarBottomRightX,scrollBarBottomRightY,false);
var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
// scroll button up
if scrollLevel == 0 || isScrollUpPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_white,1);
// scroll button down			
if is_undefined(ds_list_find_value(global.player.inventory, 9 + (5*scrollLevel))) || isScrollDownPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_white,1);
		
		
// inventory itself
var inventory = global.player.inventory;
// move all inventory items offscreen to start (accounts for not displayed items) 
// ALSO filter -- ONLY SOCKETED ITEMS
ds_list_clear(inv);
for (var i = 0; i < ds_list_size(inventory); i++) {
	var el = ds_list_find_value(inventory,i);
	ds_list_add(inv,el);
	//el.x1 = -50;
	//el.y1 = -50;
	
	if !object_is_ancestor(el.object_index, obj_gem_parent) {
		var pos = ds_list_find_index(inv,el);
		ds_list_delete(inv,pos);
	}
}
	
var row = 1; var col = 1;
// row 1, col 1 = ???
var init_x = invTopLeftX; var init_y = invTopLeftY;
var selectedItemX = 0; var selectedItemY = 0;
// show 20 items at a time;
for (var i = 0; i < 20; i++) {
	row = floor(i / 5)+1;
	col = (i mod 5)+1;
	var x1 = init_x+((col-1)*slotWidth);
	var y1 = init_y+((row-1)*slotHeight);
	var index = i + (5*scrollLevel);
	var item = ds_list_find_value(inv,index);
				
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
		
// selected item details box
draw_set_color(c_dkgray);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,false);
			
// show selected inventory item info
if selectedItem {
	showItemInfo(itemDescriptionTopLeftX,itemDescriptionTopLeftY,selectedItem);
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

show_debug_message(selectedItem.x1);