/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,15);
	ds_map_replace(rmap,ItemRarities.Fine,2);
	ds_map_replace(rmap,ItemRarities.Masterwork,1);
	ds_map_replace(rmap,ItemRarities.Legendary,0);
	var item1 = maybeMakeItem(25,rmap); //randomly generated item
	var gold = makeGold(5,35);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, gold);
	ds_map_destroy(rmap); rmap = -1;
	
}

// Inherit the parent event
event_inherited();