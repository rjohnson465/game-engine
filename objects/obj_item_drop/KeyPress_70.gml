// loot item
if isBeingLooted {
	addItemToInventory(selectedItem);
	ds_list_delete(items,ds_list_find_index(items,selectedItem));
	if ds_list_size(items) > 0 {
		selectedItem = ds_list_find_value(items,0);
	}
}