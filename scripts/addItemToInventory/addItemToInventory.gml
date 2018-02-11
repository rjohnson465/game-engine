/// addItemToInventory(item)
/// @param item

var item = argument0;

ds_list_add(inventory,item);
if !item.persistent {
	item.persistent = true;
}