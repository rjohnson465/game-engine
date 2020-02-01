/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
if isInUse {
	
	if p.isSlowed || p.isFrozen {
		with p {
			cureCondition(ICE);
		}
	}
	else {
		ds_map_replace(p.conditionsBuildupMap, ICE, 0);
		// grant 50% ice resistance for 30 seconds
		ds_list_add(p.temporaryDefenses, [ICE, 900, 50, 900, itemSprite]);
	}
	isInUse = false;
}