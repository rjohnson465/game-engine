draw_set_halign(fa_center); draw_set_valign(fa_center);
draw_set_alpha(1);
draw_set_font(font_main);

draw_set_color(c_black);
draw_rectangle(topLeftX, topLeftY, bottomRightX, bottomRightY, 1);
draw_line(topLeftX, topLeftY+subMenuTitleHeight, bottomRightX, topLeftY+subMenuTitleHeight);

if global.fountainGui.currentSubMenu != CHOOSEITEM {
	draw_set_alpha(.5);
}

draw_set_color(c_white);
if global.fountainGui.currentSubMenu == CHOOSEITEM {
	draw_text(mean(MENUS_TOPLEFT_X,MENUS_TOPLEFT_X+width),mean(MENUS_TOPLEFT_Y+menusHandleHeight,MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight),"Choose Item");
} else {
	draw_text(mean(MENUS_TOPLEFT_X,MENUS_TOPLEFT_X+width),mean(MENUS_TOPLEFT_Y+menusHandleHeight,MENUS_TOPLEFT_Y+menusHandleHeight+subMenuTitleHeight),selectedItem.name);
}

if !gamepad_is_connected(global.player.gamePadIndex) {

	// draw back button
	if !isBackButtonPressed {
		draw_sprite_ext(spr_button_next,1,backButtonTopLeftX+30,backButtonTopLeftY,-1,1,0,c_white,draw_get_alpha());
	} else {
		draw_sprite_ext(spr_button_next,1,backButtonTopLeftX+30,backButtonTopLeftY,-1,1,0,c_gray,draw_get_alpha());
	}

	// draw next button
	if !isNextButtonPressed {
		draw_sprite_ext(spr_button_next,1,nextButtonTopLeftX,nextButtonTopLeftY,1,1,0,c_white,draw_get_alpha());
	} else {
		draw_sprite_ext(spr_button_next,1,nextButtonTopLeftX,nextButtonTopLeftY,1,1,0,c_gray,draw_get_alpha());
	}
}

// SUB MENU 1 -- select item

// basically show the inventory, filtered for only socketed items
// SCROLL BAR 1 (for select item menu)
draw_set_color(c_black);
draw_rectangle(scrollBarTopLeftX,scrollBarTopLeftY,scrollBarBottomRightX,scrollBarBottomRightY,false);
var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
// scroll button up
if scrollLevel == 0 || isScrollUpPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_white,1);
// scroll button down			
if is_undefined(ds_list_find_value(inv, 19 + (5*scrollLevel))) || isScrollDownPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_white,1);
		
		
// draw scroll box
var msl = inventoryGetMaxScrollLevel();
var percentScrolled = 0;
if msl > 0 percentScrolled = scrollLevel / msl;

var scrollBarBoxStartY = scrollBarTopLeftY+scrollBarWidth;
var scrollBarBoxEndY = scrollBarBottomRightY-(2*scrollBarWidth);
var scrollBarHeight = scrollBarBoxEndY-scrollBarBoxStartY;

// how tall should the box be?
var scrollBarBoxHeight = scrollBarHeight;
if msl > 0 {
	scrollBarBoxHeight = scrollBarHeight/msl;
}

// recalc how much sbheight is
var scrollBarBoxEndY = scrollBarBottomRightY-scrollBarWidth-scrollBarBoxHeight;
var scrollBarHeight = scrollBarBoxEndY-scrollBarBoxStartY;

var yOff = scrollBarHeight*percentScrolled;
var x1 = scrollBarTopLeftX; var y1 = scrollBarBoxStartY+yOff;
draw_set_color(c_gray);

draw_rectangle(x1,y1,x1+scrollBarWidth,y1+scrollBarBoxHeight,0);
		
// inventory itself
var inventory = global.player.inventory;
// ALSO filter -- ONLY GEMMED ITEMS
ds_list_clear(inv);
for (var i = 0; i < ds_list_size(inventory); i++) {
	var el = ds_list_find_value(inventory,i);
	ds_list_add(inv,el);
	
	if	(!object_is_ancestor(el.object_index,obj_hand_item_parent) &&
		!object_is_ancestor(el.object_index,obj_hat_parent))
		||
		ds_list_size(el.socketedGems) == 0 
		{
		var pos = ds_list_find_index(inv,el);
		ds_list_delete(inv,pos);
	}
	
}

for (var i = 0; i < ds_list_size(inv); i++) {
	var el = ds_list_find_value(inv,i);
	el.x1 = -50;
	el.y1 = -50;
}
	
var row = 1; var col = 1;
// row 1, col 1 = ???
var init_x = invTopLeftX; var init_y = invTopLeftY;
hoveredItem = noone;
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
			hoveredItem = item;
			draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.25);
		} else if selectedItem == item {
			draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.75);
		}
		else draw_sprite(spr_item_slot,1,x1,y1);
		drawItem(item,x1,y1);
	} 
}

if ds_list_size(inv) == 0 {
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_text(mean(invTopLeftX,invBottomRightX),mean(invTopLeftY,invBottomRightY),"No gemmed items found");
}
		
// selected item details box
draw_set_color(c_dkgray);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,false);
			
// show selected inventory item info
if hoveredItem {
	showItemInfo(itemDescriptionTopLeftX,itemDescriptionTopLeftY,hoveredItem);
} else if selectedItem {
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

// draw prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if global.fountainGui.currentSubMenu == CHOOSEITEM {
	// controller prompts
	if gamepad_is_connected(global.player.gamePadIndex) {
		if selectedItem != noone && selectedItem != undefined {
			w += drawPrompt("Break down " + string(selectedItem.name), Input.F,promptsStartX+w,promptsY)+xOffset;
		}
		w += drawPrompt("Return to menu", Input.Escape, promptsStartX+w,promptsY);
	}
	// m/k prompts
	else {
		w += drawPrompt("Select item to break down", Input.LMB,promptsStartX+w,promptsY)+xOffset;
	}
}

draw_set_color(c_black); draw_set_alpha(1);
draw_rectangle(invTopLeftX,invTopLeftY,MENUS_TOPLEFT_X+width,MENUS_BOTTOMRIGHT_Y,1);