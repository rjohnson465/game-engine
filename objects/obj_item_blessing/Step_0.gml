/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	var p = global.player;
	if p.isHexed {
		with p {
			cureCondition(MAGIC);
		}
	}
	else {
		// grant 50% magic resistance for 30 seconds
		ds_list_add(p.temporaryDefenses, [MAGIC, 900, 50, 900, itemSprite]);
	}
	isInUse = false;
}