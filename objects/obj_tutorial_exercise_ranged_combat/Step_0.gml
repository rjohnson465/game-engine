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

if enemy2 == noone {
	with obj_enemy_parent {
		if variable_instance_exists(id, "eKey") && eKey == other.enemyKey2 {
			other.enemy2 = id;
		}
	}
}

if enemy3 == noone {
	with obj_enemy_parent {
		if variable_instance_exists(id, "eKey") && eKey == other.enemyKey3 {
			other.enemy3 = id;
		}
	}
}

if !hasDroppedTrees && isActive {
	fallenTree1 = instance_create_layer(960, 1056, global.player.layer, obj_falling_tree);
	fallenTree1.image_angle = -90;
	fallenTree2 = instance_create_layer(832, 1152, global.player.layer, obj_falling_tree);
	fallenTree2.image_angle = 90;
	hasDroppedTrees = true;
}

// when this is finished, destroy the trees
/*
if isFinished && hasDroppedTrees {
	instance_destroy(fallenTree1, true);
	instance_destroy(fallenTree2, true);
}*/

if isActive && instance_number(obj_player_death) > 0 {
	instance_destroy(fallenTree1, true);
	instance_destroy(fallenTree2, true);
	hasDroppedTrees = false;
}