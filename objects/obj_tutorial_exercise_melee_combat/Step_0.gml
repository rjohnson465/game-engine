/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if enemy == noone {
	with obj_enemy_parent {
		if variable_instance_exists(id, "eKey") && eKey == other.enemyKey {
			other.enemy = id;
		}
	}
}