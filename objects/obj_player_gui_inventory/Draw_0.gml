if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

var leftHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand1);
var leftHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.LeftHand2);
var rightHandItem = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand1);
var rightHandItem2 = ds_map_find_value(global.player.equippedItems,EquipmentSlots.RightHand2);

with (ui) {
// tabs /filters TODO
draw_set_color(c_gray);
draw_rectangle(212,154,562,184,false);
// none filter
if inventoryFilter != InventoryFilters.None {
	draw_sprite(spr_filter_none,1,212,154);
} else draw_sprite_ext(spr_filter_none,1,212,154,1,1,0,c_gray,.75);
// melee filter
if inventoryFilter != InventoryFilters.Melee {
	draw_sprite(spr_filter_melee,1,242,154);
} else draw_sprite_ext(spr_filter_melee,1,242,154,1,1,0,c_gray,.75);
// ranged filter
if inventoryFilter != InventoryFilters.Ranged {
	draw_sprite(spr_filter_ranged,1,272,154);
} else draw_sprite_ext(spr_filter_ranged,1,272,154,1,1,0,c_gray,.75);
// shields filter
if inventoryFilter != InventoryFilters.Shields {
	draw_sprite(spr_filter_shields,1,302,154);
} else draw_sprite_ext(spr_filter_shields,1,302,154,1,1,0,c_gray,.75);
// magic filter
if inventoryFilter != InventoryFilters.Magic {
	draw_sprite(spr_filter_magic,1,332,154);
} else draw_sprite_ext(spr_filter_magic,1,332,154,1,1,0,c_gray,.75);
			
// division line
draw_set_color(c_black);
draw_line(562,154,562,634);
			
// scrolling
draw_set_color(c_gray);
draw_rectangle(532,184,562,440,false);
if inventoryScrollLevel == 0 {
	draw_sprite_ext(spr_scrollarrow,1,532,214,1,-1,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,532,214,1,-1,0,c_white,1);
			
if is_undefined(ds_list_find_value(global.player.inventory, 19 + (5*global.ui.inventoryScrollLevel))) {
	draw_sprite_ext(spr_scrollarrow,1,532,410,1,1,0,c_gray,.75);
} else draw_sprite_ext(spr_scrollarrow,1,532,410,1,1,0,c_white,1);
			
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
	switch inventoryFilter {
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
var init_x = 212; var init_y = 184;
var selectedItemX = 0; var selectedItemY = 0;
// show 15 items at a time;
for (var i = 0; i < 20; i++) {
	row = floor(i / 5)+1;
	col = (i mod 5)+1;
	var x1 = init_x+((col-1)*64);
	var y1 = init_y+((row-1)*64);
	var index = i + (5*inventoryScrollLevel);
	var item = ds_list_find_value(inv,index);
				
	if !is_undefined(item) && !item.isEquipped {
		item.x1 = x1;
		item.y1 = y1;
					
		// draw slot darker if mouse over and its the nearest one to mouse
		if position_meeting(mouse_x,mouse_y,item) {
			draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.25);
		} else if inventorySelectedItem == item {
			draw_sprite_ext(spr_item_slot,1,x1,y1,1,1,0,c_gray,.75);
		}
		else draw_sprite(spr_item_slot,1,x1,y1);
		draw_sprite(item.itemSprite,1,x1,y1);
	} 
	if inventorySelectedItem == item {
		selectedItemX = x1;
		selectedItemY = y1;
	}
}
			
// selected item details box
draw_set_color(c_black);
draw_rectangle(212,440,562,634,false);
			
if inventorySelectedItem {
				
	draw_set_color(c_olive);
	draw_rectangle(212,440,562,465,false);
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	var s = inventorySelectedItem.name;
	if inventorySelectedItem.totalCharges != noone {
		if inventorySelectedItem.totalCharges > 0 {
			s += " (" + string(inventorySelectedItem.charges) + "/" + string(inventorySelectedItem.totalCharges) + " charges)";
		}
	}
	draw_text(213,445,s);
				
	// all shields and weapons share many properties, so it makes sense to lump them together when showing properties
	if inventorySelectedItem.type == HandItemTypes.Melee || HandItemTypes.Ranged || HandItemTypes.Shield {
		// physical damage
		if inventorySelectedItem.type != HandItemTypes.Shield {
			var physDamageMin = 10000000; var physDamageMax = 0;
			for (var i = 0; i < array_length_1d(inventorySelectedItem.physicalDamageArray); i++) {
				var num = inventorySelectedItem.physicalDamageArray[i];
				if num < physDamageMin {
					physDamageMin = num;
				}
				if num > physDamageMax {
					physDamageMax = num;
				}
			}
			var s = "Phys. Damage: " + string(physDamageMin) + "-" + string(physDamageMax);
			draw_text(213,470,s);
		}
					
		// damage absorption (shield only)
		if inventorySelectedItem.type == HandItemTypes.Shield {
			var s = "Phys. Damage \nAbsorbtion: " + string(inventorySelectedItem.blockPercentage)+"%";
			draw_text(213,470,s);
		}
					
		// auto weapon / shield description 
		var numHands = inventorySelectedItem.isTwoHanded ? "2H" : "1H";
		var itemType = "";
		if inventorySelectedItem.totalCharges != 0 {
			itemType = "Magical Implement";
		} else if inventorySelectedItem.type == HandItemTypes.Ranged {
			itemType = "Ranged Weapon";
		} else if inventorySelectedItem.type == HandItemTypes.Shield {
			itemType = "Shield";
		} else {
			itemType = "Melee Weapon";
		}
					
		var autoDescription = numHands + " " + itemType;
		draw_text(213, 504, autoDescription);
					
		// speed (no shield)
		if inventorySelectedItem.type != HandItemTypes.Shield {
			var s = inventorySelectedItem.weaponSpeed + " Attack Speed";
			draw_text(213, 538, s);
		}
					
		// weight
		var s = "Weight: " + string(inventorySelectedItem.weight);
		draw_text(213,572,s);
		// value 
		var s = "Value: " + string(inventorySelectedItem.value);
		draw_text(213,605,s);
					
		// elemental bonuses
		draw_text(410,470,"Magic Bonus: " + string(inventorySelectedItem.bonusMagic));	
		draw_text(410,504,"Fire Bonus: " + string(inventorySelectedItem.bonusFire));	
		draw_text(410,538,"Ice Bonus: " + string(inventorySelectedItem.bonusIce));	
		draw_text(410,572,"Poison Bonus: " + string(inventorySelectedItem.bonusPoison));	
		draw_text(410,605,"Lightning Bonus: " + string(inventorySelectedItem.bonusLightning));	
	}
} // end selected inventory item details
			
// equipped items side
draw_set_color(c_gray);
draw_rectangle(562,154,912,184,false);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(737,164,"Equipped Items");
			
// head slot
draw_sprite(spr_item_slot,1,705,204);
// left hand 1
draw_sprite(spr_item_slot,1,570,235);
if leftHandItem != global.player.unarmed {
	draw_sprite(leftHandItem.itemSprite,1,570,235);
}
if rightHandItem.isTwoHanded {
	draw_sprite_ext(rightHandItem.itemSprite,1,570,235,1,1,0,c_black,.75);
}
draw_text(570,225,"1");
// left hand 2
draw_sprite(spr_item_slot,1,635,235);
if rightHandItem != global.player.unarmed {
	draw_sprite(rightHandItem.itemSprite,1,635,235);
}
/*if rightHandItem2.isTwoHanded {
	draw_sprite_ext(rightHandItem2.itemSprite,1,635,235,1,1,0,c_black,.75);
}*/
draw_text(635,225,"1");
// left ring 1 
draw_sprite(spr_item_slot,1,602,300);
// left ring 2
draw_sprite(spr_item_slot,1,602,365);
// right hand 1
draw_sprite(spr_item_slot,1,775,235);
if leftHandItem2 != global.player.unarmed {
	draw_sprite(leftHandItem2.itemSprite,1,775,235);
}
if rightHandItem2.isTwoHanded {
	draw_sprite_ext(rightHandItem2.itemSprite,1,775,235,1,1,0,c_black,.75);
}
draw_text(775,225,"2");
// right hand 2
draw_sprite(spr_item_slot,1,840,235);
if rightHandItem2 != global.player.unarmed {
	draw_sprite(rightHandItem2.itemSprite,1,840,235);
}
draw_text(840,225,"2");
// right ring 1 
draw_sprite(spr_item_slot,1,807,300);
// right ring 2
draw_sprite(spr_item_slot,1,807,365);
}

		