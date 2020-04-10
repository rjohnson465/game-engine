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
	var item1 = maybeMakeItem(10,rmap); //randomly generated item
	var item2 = maybeMakeItem(1,rmap); //randomly generated item
	var pmap = ds_map_create();
	ds_map_add(pmap, obj_item_antidote, 5);
	ds_map_add(pmap, obj_item_rubberducky, 5);
	ds_map_add(pmap, obj_item_icecube, 5);
	ds_map_add(pmap, obj_item_jalapeno, 5);
	ds_map_add(pmap, obj_item_blessing, 5);
	ds_map_add(pmap, obj_item_spearmint_elixir, 3);
	ds_map_add(pmap, obj_item_club_soda, 3);
	ds_map_add(pmap, obj_item_razorade, 3);
	var item3 = maybeMakeItemBasic(pmap, .1);
	
	var pmap2 = ds_map_create();
	ds_map_add(pmap2, obj_item_scroll_of_knowledge, 5);
	var scroll = maybeMakeItemBasic(pmap2, .05);
	
	var gold = makeGold(0,25);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1, item2, item3, scroll);
	//ds_list_add(droppedItems,item2);
	ds_list_add(droppedItems,gold);
	
	// drop carrots if rudolph quest not done and no carrots exist
	if variable_instance_exists(id, "eventKey") && eventKey == "icfb" {
		var nearestCarrots = instance_nearest(x, y, obj_item_carrots);
		var quest = instance_nearest(x, y, obj_quest_reindeerlove);
		
		if (!instance_exists(quest) || quest.currentQuestStepIndex == 0) && !instance_exists(nearestCarrots) {
			ds_list_add(droppedItemsMandatory, instance_create_depth(x, y, 1, obj_item_carrots));
		}
	}
	
	ds_map_destroy(rmap); rmap = -1;
	//ds_map_destroy(tmap); tmap = -1;
	
	
	
	ds_map_destroy(pmap); pmap = -1;
	ds_map_destroy(pmap2); pmap2 = -1;
}

// Inherit the parent event
event_inherited();