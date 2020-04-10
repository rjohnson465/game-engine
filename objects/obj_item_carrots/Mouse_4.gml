/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
//event_inherited();

if ds_list_find_index(global.player.inventory,id) != -1 {
	with obj_inventory {
		selectedItem = other.id;
	}
	if global.ui.moveSelector.isActive {
		global.ui.moveSelector.x1 = x1;
		global.ui.moveSelector.y1 = y1;
	}
} 

