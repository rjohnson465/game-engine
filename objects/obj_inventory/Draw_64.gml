if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

var leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
var leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
var rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
var rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);

// tabs /filters 
// filters background
draw_set_color(c_gray);
draw_rectangle(topLeftX,topLeftY,topLeftX+width,topLeftY+filtersHeight,false);

var currentFilter = ds_map_find_first(filterSprites);
for (var i = 0; i < ds_map_size(filterSprites); i++) {
	var spr = ds_map_find_value(filterSprites,currentFilter);
	if pressedFilter == currentFilter {
		draw_sprite_ext(spr,1,topLeftX+(i*filtersWidth),topLeftY,1,1,0,c_dkgray,.95);
	}
	else if filter == currentFilter {
		draw_sprite(spr,1,topLeftX+(i*filtersWidth),topLeftY);
	} else {
		draw_sprite_ext(spr,1,topLeftX+(i*filtersWidth),topLeftY,1,1,0,c_gray,.75);
	}
	
	currentFilter = ds_map_find_next(filterSprites,currentFilter);
}	

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
// ALSO only display unequipped items in inventory
// ALSO filter according to current inventory filter
var inv = ds_list_create();
for (var i = 0; i < ds_list_size(inventory); i++) {
	var el = ds_list_find_value(inventory,i);
				
	if !el.isEquipped {
		ds_list_add(inv,el);
		el.x1 = -50;
		el.y1 = -50;
	}
	switch filter {
		case InventoryFilters.Melee: {
			if el.type != HandItemTypes.Melee {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Shields: {
			if el.type != HandItemTypes.Shield {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Ranged: {
			if el.type != HandItemTypes.Ranged {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
		case InventoryFilters.Magic: {
			if el.totalCharges == 0 {
				var pos = ds_list_find_index(inv,el);
				ds_list_delete(inv,pos);
			}
			break;
		}
	}
}
	
var row = 1; var col = 1;
// row 1, col 1 = (212,184)
var init_x = invTopLeftX; var init_y = invTopLeftY;
var selectedItemX = 0; var selectedItemY = 0;
// show 15 items at a time;
for (var i = 0; i < 20; i++) {
	row = floor(i / 5)+1;
	col = (i mod 5)+1;
	var x1 = init_x+((col-1)*slotWidth);
	var y1 = init_y+((row-1)*slotHeight);
	var index = i + (5*scrollLevel);
	var item = ds_list_find_value(inv,index);
				
	if !is_undefined(item) && !item.isEquipped {
		item.x1 = x1;
		item.y1 = y1;
					
		// draw slot darker if mouse over and its the nearest one to mouse
		if position_meeting(mouse_x,mouse_y,item) {
			draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.25);
		} else if selectedItem == item {
			draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.75);
		}
		else draw_sprite(spr_item_slot,1,x1,y1);
		draw_sprite(item.itemSprite,1,x1,y1);
	} 
	if selectedItem == item {
		selectedItemX = x1;
		selectedItemY = y1;
	}
}
			
// selected item details box
draw_set_color(c_dkgray);
draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,itemDescriptionBottomRightX,itemDescriptionBottomRightY,false);
			
if selectedItem {
				
	draw_set_color(c_olive);
	var descriptionHandleX2 = itemDescriptionTopLeftX+width
	var descriptionHandleY2 = itemDescriptionTopLeftY+itemDescriptionHandleHeight;
	draw_rectangle(itemDescriptionTopLeftX,itemDescriptionTopLeftY,descriptionHandleX2,descriptionHandleY2,false);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	var s = selectedItem.name;
	if selectedItem.totalCharges != noone {
		if selectedItem.totalCharges > 0 {
			s += " (" + string(selectedItem.charges) + "/" + string(selectedItem.totalCharges) + " charges)";
		}
	}
	draw_text(itemDescriptionTopLeftX+1,(descriptionHandleY2+itemDescriptionTopLeftY)/2.025,s);
				
	// all shields and weapons share many properties, so it makes sense to lump them together when showing properties
	if selectedItem.type == HandItemTypes.Melee || HandItemTypes.Ranged || HandItemTypes.Shield {
		// damage absorption (shield only)
		/*if selectedItem.type == HandItemTypes.Shield {
			var s = "Block: " + string(selectedItem.blockPercentage)+"%";
			draw_text(itemDescriptionCol1X,itemDescriptionColY,s);
		}*/
					
		// auto weapon / shield description 
		var numHands = selectedItem.isTwoHanded ? "2H" : "1H";
		var itemType = "";
		if selectedItem.totalCharges != 0 {
			itemType = "Magical Implement";
		} else if selectedItem.type == HandItemTypes.Ranged {
			itemType = "Ranged Weapon";
		} else if selectedItem.type == HandItemTypes.Shield {
			itemType = "Shield";
		} else {
			itemType = "Melee Weapon";
		}
					
		var autoDescription = numHands + " " + itemType;
		draw_text(itemDescriptionCol1X, itemDescriptionColY+20, autoDescription);
					
		// speed (no shield)
		if selectedItem.type != HandItemTypes.Shield {
			var s = selectedItem.weaponSpeed + " Attack Speed";
			draw_text(itemDescriptionCol1X, itemDescriptionColY+40, s);
		}
					
		// weight
		var s = "Weight: " + string(selectedItem.weight);
		draw_text(itemDescriptionCol1X,itemDescriptionColY+60,s);
		// value 
		var s = "Value: " + string(selectedItem.value);
		draw_text(itemDescriptionCol1X,itemDescriptionColY+80,s);
					
		// damages
		if selectedItem.type == HandItemTypes.Melee || selectedItem.type == HandItemTypes.Ranged {
			for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
				var damageType = global.ALL_DAMAGE_TYPES[i];
				var damageArray = ds_map_find_value(selectedItem.damages,damageType);
				var minDamage = 100000; var maxDamage = 0;
				if damageType == PHYSICAL {
					for (var j = 0; j < array_length_1d(damageArray); j++) {
						var num = damageArray[j];
						if num < minDamage {
							minDamage = num;
						} 
						if num > maxDamage {
							maxDamage = num;
						}
					}
				}
				else {
					minDamage = damageArray[0];
					maxDamage = damageArray[1];
				}
				// draw damage texts in second column
				if minDamage == 0 && maxDamage == 0 {
					draw_text(itemDescriptionCol2X,itemDescriptionColY+(i*20),damageType + ": 0");
				} else {
					draw_text(itemDescriptionCol2X,itemDescriptionColY+(i*20),damageType + ": " + string(minDamage) + "-" + string(maxDamage));
				}
			}
		} else if selectedItem.type == HandItemTypes.Shield {
			for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
				var defenseType = global.ALL_DAMAGE_TYPES[i];
				var blockPercentage = ds_map_find_value(selectedItem.defenses,defenseType);
				// draw damage texts in second column
				draw_text(itemDescriptionCol2X,itemDescriptionColY+(i*20),defenseType + ": " + string(blockPercentage));
			}
		}
		
	}
} // end selected inventory item details
			
/*



		