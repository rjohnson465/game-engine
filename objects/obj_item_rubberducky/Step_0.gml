/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	var p = global.player;
	if p.isShocked {
		with p {
			cureCondition(LIGHTNING);
		}
	}
	else {
		// grant 50% lightning resistance for 30 seconds
		ds_list_add(p.temporaryDefenses, [LIGHTNING, 900, 50, 900, itemSprite]);
	}
	isInUse = false;
}