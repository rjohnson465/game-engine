/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	var p = global.player;
	if p.isPoisoned {
		with p {
			cureCondition(POISON);
		}
	}
	else {
		ds_map_replace(p.conditionsBuildupMap, POISON, 0);
		// grant 50% poison resistance for 30 seconds
		ds_list_add(p.temporaryDefenses, [POISON, 900, 50, 900, itemSprite]);
	}
	isInUse = false;
}