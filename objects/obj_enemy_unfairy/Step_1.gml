/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,90);
	ds_map_replace(rmap,ItemRarities.Fine,9);
	ds_map_replace(rmap,ItemRarities.Masterwork,1);
	ds_map_replace(rmap,ItemRarities.Legendary,0);
	/*var tmap = ds_map_create();
	ds_map_replace(tmap,ItemTypes.Ring,0);
	ds_map_replace(tmap,ItemTypes.HandItem,0);
	ds_map_replace(tmap,ItemTypes.Head,0);
	ds_map_replace(tmap,ItemTypes.Other,1);*/
	var item1 = maybeMakeItem(25,rmap); //randomly generated item
	var item2 = maybeMakeItem(10,rmap); //randomly generated item
	//var item2 = maybeMakeItem(100,rmap,tmap); //randomly generated item
	var gold = makeGold(0,25);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2);
	//ds_list_add(droppedItems,item2);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	//ds_map_destroy(tmap); tmap = -1;
}

// Inherit the parent event
event_inherited();