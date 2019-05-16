/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,10);
	ds_map_replace(rmap,ItemRarities.Fine,4);
	ds_map_replace(rmap,ItemRarities.Masterwork,2);
	ds_map_replace(rmap,ItemRarities.Legendary,0);
	var item1 = maybeMakeItem(85,rmap); //randomly generated item
	var gold = makeGold(0,25);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	
}

// Inherit the parent event
event_inherited();