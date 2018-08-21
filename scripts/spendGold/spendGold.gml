/// spendGold(amount)
/// @param amount

var amount = argument[0];

for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var item = ds_list_find_value(global.player.inventory, i);
	if !instance_exists(item) continue;
	if item.object_index == obj_item_coins {
		item.count -= amount;
		if item.count < 0 item.count = 0;
	}
}