/// isSelectorAtLastInventoryColumn()
// must be called by an instance of selector

var lastShownItemInInventory = ds_list_find_value(global.inventory.inv,ds_list_size(global.inventory.inv)-1);
if lastShownItemInInventory != undefined && lastShownItemInInventory != noone {
	var pred1 = x1 == global.inventory.invTopLeftX+(4*global.inventory.slotWidth);
	var pred2 = (lastShownItemInInventory.x1 == x1 && lastShownItemInInventory.y1 == y1);
	return pred1 || pred2; 
} return isSelectorInInventory();

