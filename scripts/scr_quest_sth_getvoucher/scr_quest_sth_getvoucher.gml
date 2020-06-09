/// scr_quest_sth_getvoucher

if !inventoryContainsItem(obj_item_casino_voucher) {
	addItemToInventory(instance_create_depth(x, y, 1, obj_item_casino_voucher), true);
}