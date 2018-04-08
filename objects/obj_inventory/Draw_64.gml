if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

var leftHandItem = ds_map_find_value(global.player.equippedLimbItems,"l");
var leftHandItem2 = ds_map_find_value(global.player.equippedLimbItems,"l2");
var rightHandItem = ds_map_find_value(global.player.equippedLimbItems,"r");
var rightHandItem2 = ds_map_find_value(global.player.equippedLimbItems,"r2");

// tabs /filters 
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
	if pressedFilter == currentFilter {
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
var filterString = "";
switch filter {
	case InventoryFilters.Melee: {
		filterString = "Melee";
		break;
	}
	case InventoryFilters.Ranged: {
		filterString = "Ranged";
		break;
	}
	case InventoryFilters.Shields: {
		filterString = "Shields";
		break;
	}
	case InventoryFilters.Rings: {
		filterString = "Rings";
		break;
	}
	case InventoryFilters.Head: {
		filterString = "Hats";
		break;
	}
	case InventoryFilters.Other: {
		filterString = "Misc.";
		break;
	}
	case InventoryFilters.None: {
		filterString = "All";
		break;
	}
}
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_text(mean(topLeftX+filtersTotalWidth,topLeftX+width),mean(topLeftY,topLeftY+filtersHeight),filterString);

// scrolling
draw_set_color(c_black);
draw_rectangle(scrollBarTopLeftX,scrollBarTopLeftY,scrollBarBottomRightX,scrollBarBottomRightY,false);
var scrollButtonScale = scrollBarWidth / scrollSpriteWidth;
// scroll button up
if scrollLevel == 0 || isScrollUpPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonUpTopLeftX,scrollButtonUpTopLeftY+(scrollSpriteHeight*scrollButtonScale),scrollButtonScale,-scrollButtonScale,0,c_white,1);
// scroll button down			
if is_undefined(ds_list_find_value(global.player.inventory, 19 + (5*scrollLevel))) || isScrollDownPressed {
	draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,scrollButtonDownTopLeftX,scrollButtonDownTopLeftY,scrollButtonScale,scrollButtonScale,0,c_white,1);
		
// inventory itself
var inventory = global.player.inventory;
// move all inventory items offscreen to start (accounts for not displayed items) -- TODO maybe?
// ALSO filter according to current inventory filter
ds_list_clear(inv);
for (var i = 0; i < ds_list_size(inventory); i++) {
	var el = ds_list_find_value(inventory,i);
	
	//if instance_exists(el) {
		ds_list_add(inv,el);
		el.x1 = -50;
		el.y1 = -50;
	
		// if we're equipping something using the Equip Selector, 
		// automatically only show what is possible to equip
		if ui.equipSelector.isActive && isSelectorInInventory(ui.equipSelector) {
			// get equipment slot the equipSelector is on
			var esx1 = ui.moveSelector.x1; var esy1 = ui.moveSelector.y1;
			var equipmentSlotToFill = noone;
			with obj_equipmentslot {
				if id.x1 == esx1 && id.y1 == esy1 {
					equipmentSlotToFill = id;
				}
			}
		
			var slotId = equipmentSlotToFill.slot;
			if slotId == EquipmentSlots.RightHand1 || slotId == EquipmentSlots.RightHand2 {
				if (el.type == ItemTypes.HandItem && el.isTwoHanded) || el.type != ItemTypes.HandItem {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
			} else if slotId == EquipmentSlots.LeftHand1 || slotId == EquipmentSlots.LeftHand2 {
				if el.subType == HandItemTypes.Shield || el.type != ItemTypes.HandItem {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
			} else if	slotId == EquipmentSlots.LeftRing1 || slotId == EquipmentSlots.LeftRing2
						|| slotId == EquipmentSlots.RightRing1 || slotId == EquipmentSlots.RightRing2 
			{
				if el.type != ItemTypes.Ring {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
			} else if slotId == EquipmentSlots.Head {
				if el.type != ItemTypes.Head {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
			}
		}
	
		switch filter {
			case InventoryFilters.Melee: {
				if el.subType != HandItemTypes.Melee || !object_is_ancestor(el.object_index,obj_hand_item_parent) {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
				break;
			}
			case InventoryFilters.Shields: {
				if el.subType != HandItemTypes.Shield || !object_is_ancestor(el.object_index,obj_hand_item_parent) {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
				break;
			}
			case InventoryFilters.Ranged: {
				if el.subType != HandItemTypes.Ranged || !object_is_ancestor(el.object_index,obj_hand_item_parent) {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
				break;
			}
			case InventoryFilters.Rings: {
				if el.type != ItemTypes.Ring {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
				break;
			}
			case InventoryFilters.Head: {
				if el.type != ItemTypes.Head {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
				break;
			}
			case InventoryFilters.Other: {
				if el.type != ItemTypes.Other {
					var pos = ds_list_find_index(inv,el);
					ds_list_delete(inv,pos);
				}
				break;
			}
		}
	//} else {
		// el does not exist, what?
	//}
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
				
	if !is_undefined(item) /*&& !item.isEquipped*/ {
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

if ds_list_size(inv) == 0 {
	draw_set_font(font_main);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(mean(invTopLeftX,invBottomRightX),mean(invTopLeftY,invBottomRightY),"No items to display with current filters");
}
			
// selected item details box
draw_set_color(c_dkgray);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,false);
			
// show selected inventory item info
if selectedItem {
	showItemInfo(itemDescriptionTopLeftX,itemDescriptionTopLeftY,selectedItem);
} 

// instructions / prompts
var promptsStartX = topLeftX+18;
var promptsY = bottomRightY+25;
var xOffset = 20;
var eq = global.player.equippedItems;
var w = 0;
if gamepad_is_connected(global.player.gamePadIndex) {
	
	var itemAtMoveSelector = getItemAtSelectorPosition(global.ui.moveSelector);
	var a = ds_list_find_index(global.player.equippedItems,getItemAtSelectorPosition(global.ui.moveSelector));
	
	if itemAtMoveSelector != noone && itemAtMoveSelector.isUsable {
		w += drawPrompt("Use Item",Input.F,promptsStartX,promptsY)+xOffset;
	} else {
		if itemAtMoveSelector != noone && itemAtMoveSelector.type == ItemTypes.Other {
		} else if itemAtMoveSelector != noone && !isSelectorInEquippedItems(global.ui.moveSelector) {
			w += drawPrompt("Equip "+itemAtMoveSelector.name,Input.F,promptsStartX,promptsY)+xOffset;
		} else if isSelectorInEquippedItems(global.ui.moveSelector) {
			var s = getSlotAtSelector(global.ui.moveSelector);
			if s {
				var slotName = s.name;
				w += drawPrompt("Equip for "+slotName,Input.F,promptsStartX,promptsY)+xOffset;
			}
		}
	}
	if global.ui.equipSelector.isActive {
		w += drawPrompt("Cancel Equip",Input.Backspace,promptsStartX+w,promptsY)+xOffset;
	} 
	// if item at move selector position is equipped
	else if 
		getItemAtSelectorPosition(global.ui.moveSelector) != noone 
		&& ds_list_find_index(eq,itemAtMoveSelector) != -1
		&& !object_is_ancestor(itemAtMoveSelector.object_index,obj_unarmed_parent) { 
			
		w += drawPrompt("Unequip "+itemAtMoveSelector.name,Input.Backspace,promptsStartX+w,promptsY)+xOffset;
	} 
	
	if global.ui.isShowingExplanations {
		w += drawPrompt("Show Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
	} else {
		w += drawPrompt("Explain Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
	}
	
	// cycle through filters
	//w += drawPrompt("Cycle Filters",[Input.LMB, Input.RMB],promptsStartX+w,promptsY)+xOffset;
	
	w += drawPrompt("Close Menu",Input.Escape,promptsStartX+w,promptsY)+xOffset;
} else {
	w += drawPrompt("View item info",Input.LMB,promptsStartX+w,promptsY)+xOffset;
	w += drawPrompt("Drag items to equip / unequip",Input.Mouse,promptsStartX+w,promptsY)+xOffset;
	w += drawPrompt("Use item",Input.RMB,promptsStartX+w,promptsY)+xOffset;
	w += drawPrompt("Close Menu",Input.Escape,promptsStartX+w,promptsY)+xOffset;
}



		