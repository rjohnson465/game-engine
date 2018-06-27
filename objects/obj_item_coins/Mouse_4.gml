/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
//event_inherited();

if ds_list_find_index(global.player.inventory,id) != -1 {
	with obj_inventory {
		selectedItem = other.id;
	}
	if global.ui.moveSelector.isActive {
		global.ui.moveSelector.x1 = x1;
		global.ui.moveSelector.y1 = y1;
	}
} 
/*else {
	var itemIsBeingLooted = false;
	var dropItem = noone; var itemPos = -1;
	with obj_item_drop {
		if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
			itemIsBeingLooted = true;
			dropItem = id;
			itemPos = ds_list_find_index(items,other.id);
		}
	}
	if itemIsBeingLooted {
		addItemToInventory(id);
		ds_list_delete(dropItem.items,itemPos);
	}
}
