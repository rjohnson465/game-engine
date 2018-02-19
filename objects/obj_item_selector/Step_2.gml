if type == SelectorTypes.Select && !isActive && isSelectorInEquippedItems() {
	ui.equipSelector.isActive = true;
	
	var eSelector = ui.equipSelector;
	with ui.moveSelector {
		if isSelectorInInventory {
			var selectedItem = getItemAtSelectorPosition(id);
			// get acceptable slots the equip selector can move in
			eSelector.acceptableEquipmentSlots = getAcceptableEquipmentSlots(selectedItem);
		}
	}
}