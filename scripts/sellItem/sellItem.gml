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
ds_list_delete(inv,pos);

// get gold, alert
addItemToInventory(makeGold(item.value,item.value));
alert("Sold " + item.name + " for " + string(item.value) + " gold",c_yellow);

isConfirming = false;
isAcceptingConfirmInput = false;