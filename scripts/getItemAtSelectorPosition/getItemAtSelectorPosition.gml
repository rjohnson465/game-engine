/// getItemAtSelectorPosition(selector)
/// @param selector

var selector = argument0;

var selectorX = selector.x1;
var selectorY = selector.y1;

// how many items are offscreen (above the current inventory scroll position)
var inv = global.player.inventory;
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