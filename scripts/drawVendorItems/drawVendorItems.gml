var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if !ds_exists(items,ds_type_list) || items == noone || items == undefined exit;

draw_set_color(c_gray); draw_set_alpha(.5);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_TOPLEFT_X+width,MENUS_BOTTOMRIGHT_Y,0);

draw_set_color(c_black); draw_set_alpha(1);
draw_rectangle(invTopLeftX,invTopLeftY,MENUS_TOPLEFT_X+width,MENUS_BOTTOMRIGHT_Y,1);

draw_set_color(C_HANDLES); draw_set_alpha(1);
draw_rectangle(MENUS_TOPLEFT_X,MENUS_TOPLEFT_Y,MENUS_TOPLEFT_X+width,MENUS_TOPLEFT_Y+menusHandleHeight,0);
draw_set_halign(fa_center); draw_set_valign(fa_center); draw_set_color(c_white); draw_set_font(font_main);
draw_text(mean(MENUS_TOPLEFT_X,MENUS_TOPLEFT_X+width),mean(MENUS_TOPLEFT_Y,MENUS_TOPLEFT_Y+menusHandleHeight),owner.name + "'s Items");

// close button
if !gamepad_is_connected(global.player.gamePadIndex) {
	var closeButtonWidth = sprite_get_width(spr_close_button);
	var x1 = MENUS_TOPLEFT_X+width-closeButtonWidth; var y1 = MENUS_TOPLEFT_Y;
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
		owner.isInteractingWithPlayer = false;
		global.isInteractingWithNpc = false;
		owner.showBuySell = false;
		global.isTrading = false;
	}
}	

var playerItemsObj = obj_player_items;
if	!isActive && gamepad_is_connected(global.player.gamePadIndex) ||
	(playerItemsObj.isConfirming || isConfirming)
{
	draw_set_alpha(.5);
}
else draw_set_alpha(1);
	
// filters background
draw_set_color(c_black);
draw_rectangle(topLeftX,topLeftY,topLeftX+width,topLeftY+filtersHeight,false);

var currentFilter = ds_map_find_first(filterSprites);
var filtersTotalWidth = 0;
var filterOffset = 0; // for gamepad inventory
if gamepad_is_connected(global.player.gamePadIndex) {
	filterOffset = 1;
	var scale = filtersWidth / sprite_get_width(spr_prompt_xbox_lb);
	draw_set_color(c_dkgray);
	draw_rectangle(topLeftX,topLeftY,topLeftX+filtersWidth,topLeftY+filtersWidth,0);
	draw_sprite_ext(spr_prompt_xbox_lb,1,topLeftX,topLeftY,scale,scale,0,c_white,1);
}
for (var i = 0; i < ds_map_size(filterSprites); i++) {
	var spr = ds_map_find_value(filterSprites,currentFilter);
	//if pressedFilter == currentFilter {
	var x1 = topLeftX+((i+filterOffset)*filtersWidth); var y1 = topLeftY;
	var x2 = x1+filtersWidth; var y2 = y1+filtersHeight;
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button_released(mb_left) {
		audio_play_sound(snd_ui_tab2,1,0);
		filter = currentFilter;
		selectedItem = noone;
	}
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) && mouse_check_button(mb_left) {
		draw_sprite_ext(spr,1,topLeftX+((i+filterOffset)*filtersWidth),topLeftY,1,1,0,c_dkgray,.95);
	}
	else if filter == currentFilter {
		draw_sprite(spr,1,topLeftX+((i+filterOffset)*filtersWidth),topLeftY);
	} else {
		draw_sprite_ext(spr,1,topLeftX+((i+filterOffset)*filtersWidth),topLeftY,1,1,0,c_gray,.75);
	}
	filtersTotalWidth += filtersWidth;
	currentFilter = ds_map_find_next(filterSprites,currentFilter);
}	

/// filter string
if gamepad_is_connected(global.player.gamePadIndex) {
	filterOffset = 2;
	var scale = filtersWidth / sprite_get_width(spr_prompt_xbox_rb);
	draw_set_color(c_dkgray);
	draw_rectangle(topLeftX+(filtersTotalWidth+filtersWidth),topLeftY,topLeftX+(filtersTotalWidth+filtersWidth)+filtersWidth,topLeftY+filtersWidth,0);
	draw_sprite_ext(spr_prompt_xbox_rb,1,topLeftX+(filtersTotalWidth+filtersWidth),topLeftY,scale,scale,0,c_white,1);
}
filtersTotalWidth += (filtersWidth*filterOffset);
var filterString = getInvFilterName(filter);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_text(mean(topLeftX+filtersTotalWidth,topLeftX+width),mean(topLeftY,topLeftY+filtersHeight),filterString);
	
// scroll bar
draw_set_color(c_black);
draw_rectangle(scrollBarTopLeftX,scrollBarTopLeftY,scrollBarBottomRightX,scrollBarBottomRightY,false);
var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
// scroll button up
var sux1 = scrollBarTopLeftX; var suy1 = scrollBarTopLeftY;
var sux2 = sux1+scrollBarWidth; var suy2 = suy1 + scrollBarWidth;
var isScrollUpPressed = point_in_rectangle(mouse_x,mouse_y,vx+sux1,vy+suy1,vx+sux2,vy+suy2) && mouse_check_button_pressed(mb_left);

var sdx1 = scrollBarBottomRightX-scrollBarWidth; var sdy1 = scrollBarBottomRightY-scrollBarWidth;
var sdx2 = scrollBarBottomRightX; var sdy2 = scrollBarBottomRightY;
var isScrollDownPressed = point_in_rectangle(mouse_x,mouse_y,vx+sdx1,vy+sdy1,vx+sdx2,vy+sdy2) && mouse_check_button_pressed(mb_left);
if scrollLevel == 0 || isScrollUpPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_gray,.75);
	if scrollLevel != 0 {
		audio_play_sound(snd_ui_click1,1,0);
		scrollLevel--;
	}
} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_white,1);
// scroll button down			
if ds_exists(inv,ds_type_list) && is_undefined(ds_list_find_value(inv, 20 + (5*scrollLevel))) || isScrollDownPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_gray,.75);
	if !is_undefined(ds_list_find_value(inv, 20 + (5*scrollLevel))) {
		audio_play_sound(snd_ui_click1,1,0);
		scrollLevel++;
	}
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
var inventory = items;
// move all inventory items offscreen to start (accounts for not displayed items) 
// ALSO filter -- ONLY SOCKETED ITEMS
ds_list_clear(inv);
for (var i = 0; i < ds_list_size(inventory); i++) {
	var el = ds_list_find_value(inventory,i);
	ds_list_add(inv,el);
	el.x1 = -500;
	el.y1 = -500;
}

filterInvItems(inventory, filter);

for (var i = 0; i < ds_list_size(inv); i++) {
	var el = ds_list_find_value(inv,i);
	el.x1 = -50;
	el.y1 = -50;
	
}
	
var row = 1; var col = 1;
var init_x = invTopLeftX; var init_y = invTopLeftY;
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
} else {
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_set_color(c_white);
	draw_text(
		mean(itemDescriptionTopLeftX, itemDescriptionBottomRightX),
		mean(itemDescriptionTopLeftY, itemDescriptionBottomRightY),
		"No item selected"
	);
}
if ds_list_size(inv) == 0 {
	draw_set_font(font_main);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_set_color(c_white);
	draw_text(mean(invTopLeftX,invBottomRightX),mean(invTopLeftY,invBottomRightY),"No " + getFilterString(filter) + " to display");
}

// draw selector over selected item
if selectedItem != noone && selectedItem != undefined && instance_exists(selectedItem) && (isActive || !gamepad_is_connected(global.player.gamePadIndex)) {
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

