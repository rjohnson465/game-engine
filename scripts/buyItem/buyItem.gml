/// buyItem(item)
/// @param item
/// called by an instance of obj_vendor_items

var item = argument[0];

var gp = getGoldCount();

if gp >= item.value {
	audio_play_sound(snd_item_coins,1,0);
	alert("Purchased " + item.name + " for " + string(item.value) + " gold",c_yellow);
	var oldCount = item.count;
	//item.count = 1;
	if item.isStackable {
		var item2 = instance_create_depth(x,y,1,item.object_index);
		item2.count = 1;
		addItemToInventory(item2);
	} else {
		addItemToInventory(item);
	}
	if !item.isStackable || (item.isStackable && item.count == 1) {
		var pos = ds_list_find_index(items,item);
		ds_list_delete(items,pos);
		if (item.isStackable && item.count == 1) {
			instance_destroy(item);
		}
	} else {
		item.count = oldCount;
		item.count--;
	}
	var maybeNextSelectedItem = ds_list_find_value(inv,0);
	if maybeNextSelectedItem != noone && maybeNextSelectedItem != undefined && instance_exists(maybeNextSelectedItem) {
		selectedItem = maybeNextSelectedItem;
	} else {
		selectedItem = noone;
	}
} else {
	alert("You do not have enough gold", c_red);
}
isConfirming = false;
isAcceptingConfirmInput = false;