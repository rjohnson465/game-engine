/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

/*
if enemy == noone {
	with obj_enemy_parent {
		if variable_instance_exists(id, "eKey") && eKey == other.enemyKey {
			other.enemy = id;
		}
	}
}
*/

// move any non-enemy enemies out of the range of this tutorial
if isActive && !isFinished {
	with obj_enemy_parent {
		if id != other.enemy && distance_to_object(other) < 200 {
			status = CombatantStates.Idle;
			x = postX; 
			y = postY;
			lockOnTarget = noone;
		}
	}
}