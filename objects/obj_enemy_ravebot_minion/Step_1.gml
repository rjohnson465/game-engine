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
	var gold = makeGold(0,0);
	ds_list_clear(droppedItems);
	// ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1; 
	// only drop health and xp if killed by player
	if !showHp {
		xpReward = 0;
		chanceToDropHealthOrb = 0;
	}
	
}

// Inherit the parent event
event_inherited();

