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
	/*var tmap = ds_map_create();
	ds_map_replace(tmap,ItemTypes.Ring,0);
	ds_map_replace(tmap,ItemTypes.HandItem,0);
	ds_map_replace(tmap,ItemTypes.Head,0);
	ds_map_replace(tmap,ItemTypes.Other,1);*/
	var item1 = maybeMakeItem(25,rmap); //randomly generated item
	var gold = makeGold(0,18);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	
	// special -- create 3 - 6 spores
	
	randomize();
	var rand = round(random_range(3,6));
	for (var i = 0; i < rand; i++) {
		var spore = instance_create_layer(x+i,y+i,layer,obj_enemy_spore);
		//layer_add_instance(layer, spore);
		//spore.layer = layer;
		with spore {
			populatePersonalGrid();
		}
		part_system_depth(spore.sporeSystem, layer_get_depth(spore.layer)+1);
	}
	
}

// Inherit the parent event
event_inherited();