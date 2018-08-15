var itemIsBeingLooted = false;
var dropItem = noone; 
with obj_item_drop {
	if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
		itemIsBeingLooted = true;
		dropItem = id;
	}
}

if itemIsBeingLooted {
	lootItem(id, dropItem);
}