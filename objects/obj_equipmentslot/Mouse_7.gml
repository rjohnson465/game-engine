if global.ui.grabbedItem {
	var _gi = global.ui.grabbedItem;
	var _esbd = _gi.equipmentSlotBeforeDrag;
	var _slot = slot;
	if global.ui.grabbedItem.equipmentSlotBeforeDrag != slot {
		equipItemVerbose(global.ui.grabbedItem, id);
	}
}


//if item {
global.equippedItemsManager.selectedItem = item;
//}
