event_inherited();

if copyOf != noone {
	copyOf.durability = durability;
	copyOf.charges = charges;
}

if durability <= 0 {
	durability = 0;
	if ds_list_find_index(global.player.equippedItems,id) != -1 {
		unequipItem(id);
	}
}