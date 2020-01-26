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
	ds_map_replace(rmap2,ItemRarities.Normal,35);
	ds_map_replace(rmap2,ItemRarities.Fine,65);
	ds_map_replace(rmap2,ItemRarities.Masterwork,5);
	ds_map_replace(rmap2,ItemRarities.Legendary,0);
	var item1 = maybeMakeItem(100,rmap); //randomly generated item
	var item2 = maybeMakeItem(100,rmap2); //randomly generated item

	var gold = makeGold(100,250);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2, gold);
	
	ds_map_destroy(rmap); rmap = -1;
	ds_map_destroy(rmap2); rmap2 = -1;
	
	// kill all ravers
	with obj_enemy_ravebot_minion {
		hp = 0;
	}
	
}

// Inherit the parent event
event_inherited();