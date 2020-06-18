/// isItemEquipped(item)
/// @param item

var item = argument[0];

// if this is an instance...
if instance_exists(item) {
	return item.equipmentSlot != noone;
}


// if we just want to know if some object of this object index is equipped (i.e. torch)
if object_exists(item) {
	var p = global.player;
	var isOneEquipped = false;
	for (var i = 0; i < ds_list_size(p.equippedItems); i++) {
		var it = ds_list_find_value(p.equippedItems, i);
		if it.object_index == item {
			isOneEquipped = true;
		}
	}

	return isOneEquipped;
}

return false;