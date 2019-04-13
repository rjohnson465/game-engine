/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	var p = global.player;
	if p.isSlowed || p.isFrozen {
		with p {
			cureCondition(ICE);
		}
	}
	else {
		// TODO, grant 50% ice resistance
	}
	isInUse = false;
}