if global.ui.grabbedItem {
	if global.ui.grabbedItem.equipmentSlotBeforeDrag != slot {
		equipItemVerbose(global.ui.grabbedItem, id);
	}
}

item = getItemInEquipmentSlot(slot);
global.equippedItemsManager.selectedItem = item;