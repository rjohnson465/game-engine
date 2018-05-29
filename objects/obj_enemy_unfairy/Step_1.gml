/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,0);
	ds_map_replace(rmap,ItemRarities.Fine,70);
	ds_map_replace(rmap,ItemRarities.Masterwork,20);
	ds_map_replace(rmap,ItemRarities.Legendary,10);
	var item1 = maybeMakeItem(55,rmap); //randomly generated item
	var gold = makeGold(0,3);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap);
}

// Inherit the parent event
event_inherited();