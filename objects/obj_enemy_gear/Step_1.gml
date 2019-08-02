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
	var item1 = maybeMakeItem(10,rmap); //randomly generated item
	var gold = makeGold(10,20);
	
	var pmap2 = ds_map_create();
	ds_map_add(pmap2, obj_item_scroll_of_knowledge, 5);
	var scroll = maybeMakeItemBasic(pmap2, .07);
	
	// ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, scroll, gold);
	ds_map_destroy(rmap); rmap = -1;
	ds_map_destroy(pmap2); pmap2 = -1;
}

// Inherit the parent event
event_inherited();