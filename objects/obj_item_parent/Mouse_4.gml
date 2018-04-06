var itemIsBeingLooted = false;
var dropItem = noone; var itemPos = -1;
with obj_item_drop {
	if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
		itemIsBeingLooted = true;
		dropItem = id;
		itemPos = ds_list_find_index(items,other.id);
	}
}

if (!global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY) && !itemIsBeingLooted exit;

if type == ItemTypes.HandItem {
	if weaponType == UNARMED exit;
}

// select this item if in inv or equipped items
if x1 >= global.inventory.invTopLeftX && x1 <= global.inventory.invBottomRightX 
	&& y1 >= global.inventory.invTopLeftY && y1 <= global.inventory.invBottomRightY {
		
	var idd = id;
	with obj_inventory {
		selectedItem = idd;
	}
	
	if global.ui.moveSelector.isActive {
		global.ui.moveSelector.x1 = x1;
		global.ui.moveSelector.y1 = y1;
	}
	
} else if ds_list_find_index(global.player.equippedItems,id) != -1 {
	var idd = id;
	with obj_equipped_items_manager {
		selectedItem = idd;
	}
	
	if global.ui.moveSelector.isActive {
		global.ui.moveSelector.x1 = x1;
		global.ui.moveSelector.y1 = y1;
	}
}
// probably being looted?
else {
	if itemIsBeingLooted {
		addItemToInventory(id);
		ds_list_delete(dropItem.items,itemPos);
		if ds_list_size(dropItem.items) > 0 {
			dropItem.selectedItem = ds_list_find_value(dropItem.items,0);
		}
	}
}

mightGrab = true;