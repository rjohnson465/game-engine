/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


if room == rm_boss_lighteater {
	
	if y < 75 {
		instance_destroy(id, 1);
	}
	
	if isInConversation {
		if distance_to_object(obj_player) < 50 {
			path_end();
		}
	}
	
	facingDirection = direction;
	
}