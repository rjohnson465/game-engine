/// inventoryContainsItem(item, *count)
/// returns false if the item is not in inventory
/// @param item
/// @param *count how many of the item the inventory must contain

var item = argument[0];
var count = 1;
if argument_count >= 2 {
	count = argument[1];
}
var p = global.player;

if item == noone || item == undefined || !instance_exists(item) exit;

var inv = p.inventory;

for (var i = 0; i < ds_list_size(inv); i++) {
	var it = ds_list_find_value(inv, i);
	if it.object_index == item {
		if count == 1 {
			return true;
		}
		else if it.isStackable {
			if it.count >= count {
				return true;
			}
		}
	}
}

return false;