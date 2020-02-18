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
	/*var tmap = ds_map_create();
	ds_map_replace(tmap,ItemTypes.Ring,0);
	ds_map_replace(tmap,ItemTypes.HandItem,0);
	ds_map_replace(tmap,ItemTypes.Head,0);
	ds_map_replace(tmap,ItemTypes.Other,1);*/
	var item1 = maybeMakeItem(0,rmap); //randomly generated item
	var gold = makeGold(0,0);
	
	var pmap3 = ds_map_create();
	ds_map_add(pmap3, obj_item_ancient_coin, 5);
	var coin = maybeMakeItemBasic(pmap3, .025);
	
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold, coin);
	ds_map_destroy(rmap); rmap = -1;
	
	ds_map_destroy(pmap3); pmap3 = -1;
	//ds_map_destroy(tmap);
}

// Inherit the parent event
event_inherited();