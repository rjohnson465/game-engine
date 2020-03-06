/// destroyItem(item, doAlert*)
/// @param item
/// @param doAlert*

var item = argument[0];

var doAlert = true;
if argument_count > 1 {
	doAlert = argument[1];
}

if !instance_exists(item) exit;

if doAlert {
	alert(item.name + " destroyed",c_yellow);
}

if item.equipmentSlot != noone {
	unequipItem(item);
}
if item.isStackable && item.count > 1 {
	item.count--;
} else {
	/*
	var itemType = getItemFilterType(item);
	var currentItemTypeCount = ds_map_find_value(global.player.inventoryCapacityMap, itemType);
	ds_map_replace(global.player.inventoryCapacityMap, itemType, currentItemTypeCount - 1);
	*/
	var pos = ds_list_find_index(global.player.inventory,item);
	ds_list_delete(global.player.inventory,pos);
	if item != undefined && item >= 0 && instance_exists(item) {
		instance_destroy(item, 1); item = -1;
	}
}

if doAlert {
	audio_play_sound(snd_shield_hit_metal,1,0);
}