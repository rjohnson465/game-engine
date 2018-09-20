/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,2);
	ds_map_replace(rmap,ItemRarities.Fine,3);
	ds_map_replace(rmap,ItemRarities.Masterwork,3);
	ds_map_replace(rmap,ItemRarities.Legendary,1);
	/*var tmap = ds_map_create();
	ds_map_replace(tmap,ItemTypes.Ring,1);
	ds_map_replace(tmap,ItemTypes.HandItem,0);
	ds_map_replace(tmap,ItemTypes.Head,0);
	ds_map_replace(tmap,ItemTypes.Other,0);*/
	var item1 = maybeMakeItem(100,rmap, [obj_hand_item_foil]); //randomly generated item
	var gold = makeGold(0,25);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	//ds_map_destroy(tmap);
}

// Inherit the parent event
event_inherited();