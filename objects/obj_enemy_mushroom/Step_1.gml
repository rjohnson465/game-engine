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
	var item1 = maybeMakeItem(100,rmap, [obj_hand_item_foil]); //randomly generated item
	var gold = makeGold(0,25);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	
	// special -- create 3 - 6 spores
	
	randomize();
	var rand = round(random_range(3,6));
	for (var i = 0; i < rand; i++) {
		var spore = instance_create_depth(x,y,layer_get_depth(layer),obj_enemy_spore);
		spore.layer = layer;
		spore.depth = layer_get_depth(layer);
		part_system_depth(spore.sporeSystem, layer_get_depth(spore.layer)+1);
	}
	
}

// Inherit the parent event
event_inherited();