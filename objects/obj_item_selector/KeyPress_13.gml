if !isActive || !ui.isShowingMenus exit;

// if item equipped items, enter "Equip Mode"
switch type {
	// if selector type and hovering over an equipped item, activate the equip selector object
	case SelectorTypes.Select: {
		if isSelectorInEquippedItems() || isSelectorInInventory() {
			isActive = false;
			// find Equip selector and activate it (in End Step event)
		}
		break;
	}
	case SelectorTypes.Equip: {
		var moveSelector = ui.moveSelector;
		var equipSelector = id;
		var selectedEquipmentSlot = noone;
		
		// equipselector is in inventory
		if array_length_1d(ui.equipSelector.acceptableEquipmentSlots) == 0 {		
			with obj_equipmentslot {
				if x1 == moveSelector.x1 && y1 == moveSelector.y1 {
					selectedEquipmentSlot = id;
				}
			}
			equipItemVerbose(getItemAtSelectorPosition(id),selectedEquipmentSlot);
		
		}
		// equipSelector is in equipped items
		else {
			with obj_equipmentslot {
				if x1 == equipSelector.x1 && y1 == equipSelector.y1 {
					selectedEquipmentSlot = id;
				}
			}
			equipItemVerbose(getItemAtSelectorPosition(moveSelector),selectedEquipmentSlot);
			acceptableEquipmentSlots = [];
		}
		moveSelector.isActive = true;
		equipSelector.isActive = false;
		
		break;
	}
	case SelectorTypes.Imbue: {
	}
}