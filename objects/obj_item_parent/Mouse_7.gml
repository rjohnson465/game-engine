var itemIsBeingLooted = false;
var dropItem = noone; //var itemPos = -1;
with obj_item_drop {
	if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
		itemIsBeingLooted = true;
		dropItem = id;
		//itemPos = ds_list_find_index(items,other.id);
	}
}

if itemIsBeingLooted {
	lootItem(id, dropItem);
	/*audio_play_sound(soundGrab,1,0);
	addItemToInventory(id);
	ds_list_delete(dropItem.items,itemPos);
	if ds_list_size(dropItem.items) > 0 {
		dropItem.selectedItem = ds_list_find_value(dropItem.items,0);
	} else {
		dropItem.alarm[0] = 3;
	}*/
}