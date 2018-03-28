/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

/*
if isInUse {
	global.player.hp = global.player.maxHp;
	global.player.stamina = global.player.maxStamina;
	isInUse = false;
	if count > 1 {
		count--;
	} else {
		instance_destroy(id);
		if ds_list_find_index(global.player.inventory,id) != -1 {
			ds_list_delete(global.player.inventory,ds_list_find_index(global.player.inventory,id));
		}
	}
}