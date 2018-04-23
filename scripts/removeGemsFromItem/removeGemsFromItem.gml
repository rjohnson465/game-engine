/// removeGemsFromItem(item)
/// @param item

var item = argument[0];

if	!object_is_ancestor(item.object_index,obj_hand_item_parent) && 
	!object_is_ancestor(item.object_index,obj_hat_parent) {
		alert("Cannot break down items of this type", c_red); exit;
}

if item.numberOfSockets == 0 {
	alert(string(item.name) + " does not have any sockets",c_red); exit;
}

if ds_list_size(item.socketedGems) == 0 {
	alert(string(item.name) + " does not have any socketed gems", c_red); exit;
}

var origSize = ds_list_size(item.socketedGems);

for (var i = 0; i < origSize; i++) {
	var gem = ds_list_find_value(item.socketedGems,0);
	
	// remove elemental / phys bonuses
	insertGemIntoItem(gem,item,1);
	
	// return gem to inventory
	addItemToInventory(gem);
}

//updateItemName(item);