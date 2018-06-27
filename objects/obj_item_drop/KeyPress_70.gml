// loot item
if isBeingLooted {
	audio_play_sound(selectedItem.soundGrab,1,0);
	addItemToInventory(selectedItem);
	ds_list_delete(items,ds_list_find_index(items,selectedItem));
	if ds_list_size(items) > 0 {
		selectedItem = ds_list_find_value(items,0);
	}
}