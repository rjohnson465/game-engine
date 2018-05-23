/// @description Insert description here
// You can write your code in this editor

// always decide drops on death
if hp < 1 && isAlive && !isDying {
	// items
	var item1 = maybeMakeItem(55,noone); //randomly generated item
	var gold = makeGold(0,3);
	ds_list_clear(droppedItems);
	ds_list_add(droppedItems,item1);
	ds_list_add(droppedItems,gold);
}

// Inherit the parent event
event_inherited();