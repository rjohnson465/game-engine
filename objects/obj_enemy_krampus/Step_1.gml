/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,ItemRarities.Normal,10);
	ds_map_replace(rmap,ItemRarities.Fine,70);
	ds_map_replace(rmap,ItemRarities.Masterwork,20);
	ds_map_replace(rmap,ItemRarities.Legendary,5);
	var item1 = maybeMakeItem(100,rmap); //randomly generated item
	var item2 = maybeMakeItem(100,rmap); //randomly generated item
	var pmap = ds_map_create();
	//ds_map_add(pmap, obj_item_antidote, 5);
	//ds_map_add(pmap, obj_item_rubberducky, 5);
	//ds_map_add(pmap, obj_item_icecube, 5);
	ds_map_add(pmap, obj_item_jalapeno, 5);
	ds_map_add(pmap, obj_item_blessing, 5);
	ds_map_add(pmap, obj_item_spearmint_elixir, 3);
	ds_map_add(pmap, obj_item_club_soda, 3);
	ds_map_add(pmap, obj_item_razorade, 3);
	var item3 = maybeMakeItemBasic(pmap, 1);
	
	var pmap2 = ds_map_create();
	ds_map_add(pmap2, obj_item_scroll_of_knowledge, 5);
	var scroll = maybeMakeItemBasic(pmap2, 1);
	
	var gold = makeGold(600,800);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2, item3, scroll);
	//ds_list_add(droppedItems,item2);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	//ds_map_destroy(tmap); tmap = -1;
	
	
	
	ds_map_destroy(pmap); pmap = -1;
	ds_map_destroy(pmap2); pmap2 = -1;
	
	// activate all icebridges in room
	with obj_ww_icebridge {
		isActive = true;
		image_xscale = xscale; image_yscale = yscale;
		light_set_alpha(lightAlpha);
	}
	
	// move all kelves 
	with obj_enemy_krampuself {
		x = 10; y = 10;
	}
}

// Inherit the parent event
event_inherited();