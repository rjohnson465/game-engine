if !isActive || !ui.isShowingMenus exit;

// move selector to next slot on right, if it exists
if !isSelectorAtLastInventoryColumn() && isSelectorInInventory() {
	x1 += slotWidth;
	if isSelectorInInventory() {
		inv.selectedItem = getItemAtSelectorPosition(id);
	}
} else if isSelectorAtLastInventoryColumn() {
	// go to lefthanditem1 slot
	var s = noone;
	with obj_equipmentslot {
		if slot == EquipmentSlots.LeftHand1 {
			s = id;
		}
	}
	if s == noone exit;
	x1 = s.x1;
	y1 = s.y1;
}

else if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("right");
	eq.selectedItem = getItemAtSelectorPosition(id);
}