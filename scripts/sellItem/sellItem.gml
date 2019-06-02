/// sellItem(item)
/// @param item
/// called by instance of obj_player_items

var item = argument[0];

// unequip item (if equipped)
if item.equipmentSlot != noone {
	unequipItem(item);
}

// remove item from player inventory
var invv = global.player.inventory;
var pos = ds_list_find_index(invv,item);
if item.count == 1 {
	/*
	var itemType = getItemFilterType(item);
	var currentItemTypeCount = ds_map_find_value(global.player.inventoryCapacityMap, itemType);
	ds_map_replace(global.player.inventoryCapacityMap, itemType, currentItemTypeCount - 1);
	*/
	ds_list_delete(invv,pos);
} else {
	item.count--;
}

// get gold, alert
addItemToInventory(makeGold(item.value,item.value));
audio_play_sound(snd_item_coins,1,0);
alert("Sold " + item.name + " for " + string(item.value) + " gold",c_yellow);

item.persistent = true; // so it is remembered between rooms
// add this item to npcData.inventory
var npc = obj_vendor_items.owner;
ds_list_add(npc.npcData.inventory, item);

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
		var item2 = instance_create_depth(x,y,1,item.object_index);
		item2.owner = obj_vendor_items.owner;
		item2.count = 1;
		//item.owner = obj_vendor_items.owner;
		ds_list_add(obj_vendor_items.items,item2);
	}
}

// remove confirm dialog box
isConfirming = false;
isAcceptingConfirmInput = false;

// reset selectedItem for pad input
if gamepad_is_connected(global.gamePadIndex) {
	for (var i = 0; i < ds_list_size(inv); i++) {
		selectedItem = ds_list_find_value(inv,i);
		if selectedItem.x1 > 0 break;
	}
}