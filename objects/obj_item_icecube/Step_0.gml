/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	var p = global.player;
	if p.isBurning {
		with p {
			cureCondition(FIRE);
		}
	}
	else {
		ds_map_replace(p.conditionsBuildupMap, FIRE, 0);
		// grant 50% ice resistance for 30 seconds
		ds_list_add(p.temporaryDefenses, [FIRE, 900, 50, 900, itemSprite]);
	}
	isInUse = false;
}