/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var rmap = ds_map_create();
	ds_map_replace(rmap,obj_item_lamplight,1);

	var ll = maybeMakeItemBasic(rmap, .05);
	var gold = makeGold(0,0);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,ll);
	ds_list_add(droppedItems,gold);
	ds_map_destroy(rmap); rmap = -1;
	//ds_map_destroy(tmap);
}

// Inherit the parent event
event_inherited();