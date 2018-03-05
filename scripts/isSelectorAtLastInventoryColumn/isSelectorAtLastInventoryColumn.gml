/// isSelectorAtLastInventoryColumn()
// must be called by an instance of selector

var lastShownItemInInventory = ds_list_find_value(global.inventory.inv,ds_list_size(global.inventory.inv)-1);
if lastShownItemInInventory != undefined && lastShownItemInInventory != noone {
	return	x1 == global.inventory.invTopLeftX+(4*global.inventory.slotWidth)
		|| (lastShownItemInInventory.x1 == x1 && lastShownItemInInventory.y1 == y1)
		|| (x1 > lastShownItemInInventory.x1 && isSelectorInInventory());
} return isSelectorInInventory();

