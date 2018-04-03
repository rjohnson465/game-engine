/// moveSelectorInEquippedItems(direction)
/// @param direction up | down | left | right
/// Must be called with the selector object

if global.ui.currentMenu != INVENTORY exit;

var dir = argument0;

var eq = global.equippedItemsManager;
var inv = global.inventory;

// find equipmentSlot the selector is in
var currentSlot = noone;
var selectorX = x1;
var selectorY = y1;
with obj_equipmentslot {
	if x1 == selectorX && y1 == selectorY {
		currentSlot = id;
	}
}
if currentSlot == noone exit;

var slotToMoveTo = noone;
switch dir {
	case "up": {
		var slotToMoveToKey = currentSlot.up;
		// ensure this value is supported by the constraining array, if one exists
		if array_length_1d(acceptableEquipmentSlots) > 0 {
			while !arrayIncludes(acceptableEquipmentSlots,slotToMoveToKey) && slotToMoveToKey != noone {
				var s = getEquipmentSlotObject(slotToMoveToKey);
				slotToMoveToKey = s.up;
			}
		}
		if slotToMoveToKey != noone {
			moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		}
		break;
	}
	case "down": {
		var slotToMoveToKey = currentSlot.down;
		// ensure this value is supported by the constraining array, if one exists
		if array_length_1d(acceptableEquipmentSlots) > 0 {
			while !arrayIncludes(acceptableEquipmentSlots,slotToMoveToKey) && slotToMoveToKey != noone {
				var s = getEquipmentSlotObject(slotToMoveToKey);
				slotToMoveToKey = s.down;
			}
		}
		if slotToMoveToKey != noone {
			moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		}
		break;
	}
	case "left": {
		var slotToMoveToKey = currentSlot.left;
		// ensure this value is supported by the constraining array, if one exists
		if array_length_1d(acceptableEquipmentSlots) > 0 {
			while !arrayIncludes(acceptableEquipmentSlots,slotToMoveToKey) && slotToMoveToKey != noone && slotToMoveToKey != "inventory" {
				var s = getEquipmentSlotObject(slotToMoveToKey);
				slotToMoveToKey = s.left;
			}
		}
		if slotToMoveToKey != noone && (slotToMoveToKey != "inventory" || array_length_1d(acceptableEquipmentSlots) == 0) {
			moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		}
		break;
	}
	case "right": {
		var slotToMoveToKey = currentSlot.right;
		// ensure this value is supported by the constraining array, if one exists
		if array_length_1d(acceptableEquipmentSlots) > 0 {
			while !arrayIncludes(acceptableEquipmentSlots,slotToMoveToKey) && slotToMoveToKey != noone {
				var s = getEquipmentSlotObject(slotToMoveToKey);
				slotToMoveToKey = s.right;
			}
		}
		if slotToMoveToKey != noone {
			moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		}
		break;
	}
}