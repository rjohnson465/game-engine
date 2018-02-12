/// moveSelectorInEquippedItems(direction)
/// @param direction up | down | left | right
/// Must be called with the selector object

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
		moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		break;
	}
	case "down": {
		var slotToMoveToKey = currentSlot.down;
		moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		break;
	}
	case "left": {
		var slotToMoveToKey = currentSlot.left;
		moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		break;
	}
	case "right": {
		var slotToMoveToKey = currentSlot.right;
		moveSelectorInEquippedItemsHelper(slotToMoveToKey);
		break;
	}
}