var itemIsBeingLooted = false;
var dropItem = noone; 
with obj_item_drop {
	if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
		itemIsBeingLooted = true;
		dropItem = id;
	}
}

with obj_item_drop_persistent {
	if isBeingLooted && ds_list_find_index(items,other.id) != -1 {
		itemIsBeingLooted = true;
		dropItem = id;
	}
}

if itemIsBeingLooted {
	lootItem(id, dropItem);
	if dropItem.object_index == obj_item_drop_persistent {
		with dropItem {
			updatePersistentElementProperty(id,"isLooted",true);
		}
	}
}