
if isActive && !isSelectorInInventory() && !isSelectorInEquippedItems() {
	x1 = global.inventory.invTopLeftX; y1 = global.inventory.invTopLeftY;
}

if type == SelectorTypes.Select && !isActive && isSelectorInEquippedItems() && !ui.equipSelector.isActive {
	global.inventory.scrollLevel = 0;
	ui.equipSelector.isActive = true;
	ui.equipSelector.x1 = global.inventory.invTopLeftX;
	ui.equipSelector.y1 = global.inventory.invTopLeftY;
}

if type == SelectorTypes.Select && !isActive && isSelectorInInventory() && !ui.equipSelector.isActive {
	ui.equipSelector.isActive = true;
	var selectedItem = getItemAtSelectorPosition(id);
	// get acceptable slots the equip selector can move in
	ui.equipSelector.acceptableEquipmentSlots = getAcceptableEquipmentSlots(selectedItem);
			
	// find first acceptable equipment slot
	
	// first, check if any of the slots are free, if so, default to a free one
	var slots = ui.equipSelector.acceptableEquipmentSlots;
	var slot = noone;
	for (var i = 0; i < array_length_1d(slots); i++) {
		var s = slots[i];
		var item = getItemInEquipmentSlot(s);
		if (!instance_exists(item) || item.object_index == obj_hand_item_unarmed) && slot == noone {
			slot = getEquipmentSlotObject(s);
		}
	}
	if slot == noone {
		slot = getEquipmentSlotObject(slots[0]);
	}
	ui.equipSelector.x1 = slot.x1;
	ui.equipSelector.y1 = slot.y1;
}