/// moveSelectorInEquippedItemsHelper(slotToMoveToKey)
/// @param slotToMoveToKey
/// must be called by the selector object

var slotToMoveToKey = argument0;

if slotToMoveToKey == noone exit;

var slotToMoveTo = noone;
if slotToMoveToKey != "inventory" {
	
	with obj_equipmentslot {
		if slot == slotToMoveToKey {
			slotToMoveTo = id;
		}
	}
	if slotToMoveTo == noone exit;
	x1 = slotToMoveTo.x1;
	y1 = slotToMoveTo.y1;
} else {
	// make sure there is an element in this slot, if not go to last item in inventory
	var topRightItemExists = false;
	for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
		var item = ds_list_find_value(global.player.inventory,i);
		if	item.x1 == global.inventory.invTopLeftX + (4*global.inventory.slotWidth) 
			&& item.y1 == global.inventory.invTopLeftY {
				topRightItemExists = true;
		}
	}
	if topRightItemExists {
		x1 = global.inventory.invTopLeftX + (4*global.inventory.slotWidth);
		y1 = global.inventory.invTopLeftY;
	} else {
		var lastItemInInventory = ds_list_find_value(global.player.inventory,ds_list_size(global.player.inventory)-1);
		x1 = lastItemInInventory.x1;
		y1 = lastItemInInventory.y1;
	}
}