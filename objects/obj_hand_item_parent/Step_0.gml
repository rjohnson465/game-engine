event_inherited();

if durability <= 0 {
	durability = 0;
	if ds_list_find_index(global.player.equippedItems,id) != -1 {
		unequipItem(id);
	}
}

if ds_list_size(temporaryDamages) > 0 {
	drainTemporaryDamages(id);
}