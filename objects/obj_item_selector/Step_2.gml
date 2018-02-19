if type == SelectorTypes.Select && !isActive && isSelectorInEquippedItems() {
	ui.equipSelector.isActive = true;
}

if type == SelectorTypes.Select && !isActive && isSelectorInInventory() {
	ui.equipSelector.isActive = true;
	var selectedItem = getItemAtSelectorPosition(id);
	// get acceptable slots the equip selector can move in
	ui.equipSelector.acceptableEquipmentSlots = getAcceptableEquipmentSlots(selectedItem);
			
	// find first acceptable equipment slot
	var firstSlot = getEquipmentSlotObject(ui.equipSelector.acceptableEquipmentSlots[0]);
	ui.equipSelector.x1 = firstSlot.x1;
	ui.equipSelector.y1 = firstSlot.y1;
}