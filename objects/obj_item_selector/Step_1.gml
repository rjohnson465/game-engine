if !global.ui.isShowingMenus exit;

if isActive && isSelectorInInventory() && getItemAtSelectorPosition(id) == noone {
	var invv = global.inventory.inv;
	if ds_list_size(invv) == 0 {
		x1 = global.inventory.invTopLeftX; y1 = global.inventory.invTopLeftY;
	} else {
		var lastEl = ds_list_find_value(invv,ds_list_size(invv)-1);
		x1 = lastEl.x1; y1 = lastEl.y1;
	}
}

if isActive && !isSelectorInEquippedItems() {
	inv.selectedItem = getItemAtSelectorPosition(id);
}

if isActive && isSelectorInEquippedItems() {
	eq.selectedItem = getItemAtSelectorPosition(id);
}