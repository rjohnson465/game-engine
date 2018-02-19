if !isActive || !ui.isShowingMenus exit;

// if item equipped items, enter "Equip Mode"
switch type {
	// if selector type and hovering over an equipped item, activate the equip selector object
	case SelectorTypes.Select: {
		if isSelectorInEquippedItems() || isSelectorInInventory {
			isActive = false;
			// find Equip selector and activate it (in End Step event)
		}
		break;
	}
	case SelectorTypes.Equip: {
		// this is where the complex equipping happens my dude
		var selectedEquipmentSlot = noone;
		var moveSelector = ui.moveSelector;
		var equipSelector = id;
		with obj_equipmentslot {
			if x1 == moveSelector.x1 && y1 == moveSelector.y1 {
				selectedEquipmentSlot = id;
			}
		}
		equipItemVerbose(getItemAtSelectorPosition(id),selectedEquipmentSlot);
		
		moveSelector.isActive = true;
		equipSelector.isActive = false;
		
		break;
	}
	case SelectorTypes.Imbue: {
	}
}