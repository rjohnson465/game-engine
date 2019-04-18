/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	var p = global.player;
	if p.isPoisoned {
		with p {
			cureCondition(FIRE);
		}
	}
	else {
		// grant 50% ice resistance for 30 seconds
		ds_list_add(p.temporaryDefenses, [FIRE, 900, 50]);
	}
	isInUse = false;
}