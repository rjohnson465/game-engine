/// performSelectorEnterPressed()

/// Equip / Enter equip mode for selectors

if !isActive || !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

// if item equipped items, enter "Equip Mode"
var item = getItemAtSelectorPosition(id);
//if item == noone || item == undefined exit;
switch type {
	// if selector type and hovering over an equipped item, activate the equip selector object
	case SelectorTypes.Select: {
		if isSelectorInEquippedItems() || isSelectorInInventory() && item.type != ItemTypes.Other {
			isActive = false;
			var item = getItemAtSelectorPosition(id);
			if item != noone {
				audio_play_sound(item.soundGrab,1,0);
			}
			//global.inventory.scrollLevel = 0;
			// find Equip selector and activate it (in End Step event)
		} else if item.type == ItemTypes.Other && item.isUsable {
			useItem(item);
		}
		break;
	}
	case SelectorTypes.Equip: {
		var moveSelector = ui.moveSelector;
		var equipSelector = id;
		var selectedEquipmentSlot = noone;
		var item = getItemAtSelectorPosition(equipSelector);
		
		// equipselector is in inventory
		if array_length_1d(ui.equipSelector.acceptableEquipmentSlots) == 0 {		
			with obj_equipmentslot {
				if x1 == moveSelector.x1 && y1 == moveSelector.y1 {
					selectedEquipmentSlot = id;
				}
			}
			if item != noone {
				audio_play_sound(item.soundDrop,1,0);
				equipItemVerbose(getItemAtSelectorPosition(id),selectedEquipmentSlot);
			}
		
		}
		// equipSelector is in equipped items
		else {
			with obj_equipmentslot {
				if x1 == equipSelector.x1 && y1 == equipSelector.y1 {
					selectedEquipmentSlot = id;
				}
			}
			item = getItemAtSelectorPosition(moveSelector);
			if item != noone {
				audio_play_sound(item.soundDrop,1,0);
				equipItemVerbose(getItemAtSelectorPosition(moveSelector),selectedEquipmentSlot);
				acceptableEquipmentSlots = [];
			}
		}
		moveSelector.isActive = true;
		equipSelector.isActive = false;
		
		break;
	}
	case SelectorTypes.Imbue: {
	}
}


if global.ui.equipSelector.isActive {
	global.inventory.scrollLevel = 0;
}