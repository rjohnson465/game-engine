/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,75);
	ds_map_replace(rmap,ItemRarities.Fine,15);
	ds_map_replace(rmap,ItemRarities.Masterwork,10);
	ds_map_replace(rmap,ItemRarities.Legendary,0);

	var item1 = maybeMakeItem(.25,rmap); //randomly generated item
	
	//
	var item2 = noone;
	randomize();
	if random_range(0, 1) < .1 {
		item2 = makeGemPieces(obj_gempieces_aquamarine, GRAINS);
	}
	
	var pmap2 = ds_map_create();
	ds_map_add(pmap2, obj_item_scroll_of_knowledge, 5);
	var scroll = maybeMakeItemBasic(pmap2, .1);
	
	var pmap3 = ds_map_create();
	ds_map_add(pmap3, obj_item_ancient_coin, 5);
	var coin = maybeMakeItemBasic(pmap3, .15);
	
	var gold = makeGold(75,100);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2, scroll, coin);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	
	ds_map_destroy(pmap2); pmap2 = -1;
	ds_map_destroy(pmap3); pmap3 = -1;
}

// Inherit the parent event
event_inherited();