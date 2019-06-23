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
	var rmap2 = ds_map_create();
	ds_map_replace(rmap2,ItemRarities.Normal,50);
	ds_map_replace(rmap2,ItemRarities.Fine,25);
	ds_map_replace(rmap2,ItemRarities.Masterwork,15);
	ds_map_replace(rmap2,ItemRarities.Legendary,10);
	var item1 = maybeMakeItem(100,rmap); //randomly generated item
	var item2 = maybeMakeItem(75,rmap2); //randomly generated item
	var item3 = maybeMakeItem(75,rmap2); //randomly generated item
	//var item2 = maybeMakeItem(100,rmap,tmap); //randomly generated item
	var gold = makeGold(300,500);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2, item3);
	//ds_list_add(droppedItems,item2);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	ds_map_destroy(rmap2); rmap2 = -1;
	//ds_map_destroy(tmap); tmap = -1;
}

// Inherit the parent event
event_inherited();