/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,85);
	ds_map_replace(rmap,ItemRarities.Fine,12);
	ds_map_replace(rmap,ItemRarities.Masterwork,3);
	ds_map_replace(rmap,ItemRarities.Legendary,0);

	var item1 = maybeMakeItem(0,rmap); //randomly generated item
	var map2 = ds_map_create();
	ds_map_add(map2, obj_item_jalapeno, 5);
	var item2 = maybeMakeItemBasic(map2, .05);
	var gold = makeGold(0,0);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	ds_map_destroy(map2); map2 = -1;
}

// Inherit the parent event
event_inherited();