/// getItemAtSelectorPosition(selector)
/// @param selector

var selector = argument0;

var selectorX = selector.x1;
var selectorY = selector.y1;

/*with obj_item_selector {
	selectorX = x1;
	selectorY = y1;
}*/

var inventoryScrollPosition = global.inventory.scrollLevel;
// how many items are offscreen (above the current inventory scroll position)
var inventoryItemOffset = inventoryScrollPosition*5;

var inv = global.player.inventory;
var equippedItems = global.player.equippedItems;
with obj_item_parent {
	// if item exists in inventory OR 
	// item is equipped and selector is in item's equipment slot
	if ds_list_find_index(inv,id) != -1 {
		if x1 == selectorX && y1 = selectorY {
			return id;
		}
		
		if equipmentSlot != noone {
			var eqSlotObj = getEquipmentSlotObject(equipmentSlot);
			if eqSlotObj.x1 == selectorX && eqSlotObj.y1 == selectorY {
				return id;
			}
		}
	}
}
return noone;