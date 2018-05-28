/// sellItem(item)
/// @param item
/// called by instance of obj_player_items

var item = argument[0];

// unequip item (if equipped)
if item.equipmentSlot != noone {
	unequipItem(item);
}

// remove item from player inventory
var inv = global.player.inventory;
var pos = ds_list_find_index(inv,item);
if item.count == 1 {
	ds_list_delete(inv,pos);
} else {
	item.count--;
}

// get gold, alert
addItemToInventory(makeGold(item.value,item.value));
alert("Sold " + item.name + " for " + string(item.value) + " gold",c_yellow);

// add item to vendor's items
if !item.isStackable {
	item.owner = obj_vendor_items.owner;
	ds_list_add(obj_vendor_items.items,item);
} else {
	var vitemStack = noone;
	for (var i = 0; i < ds_list_size(obj_vendor_items.items); i++) {
		var vi = ds_list_find_value(obj_vendor_items.items,i);
		if vi.object_index == item.object_index {
			vitemStack = vi; break;
		}
	}
	if vitemStack != noone {
		vitemStack.count++;
		//item.count--;
	} else {
		item.owner = obj_vendor_items.owner;
		ds_list_add(obj_vendor_items.items,item);
	}
}

// remove confirm dialog box
isConfirming = false;
isAcceptingConfirmInput = false;