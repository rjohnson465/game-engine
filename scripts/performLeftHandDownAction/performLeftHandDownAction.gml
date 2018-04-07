var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if global.isWishing exit;

if !isMouseInMenu && !isFrozen && !global.ui.isShowingMenus {

	// if using a 2h ranged weapon, holding left allows for aiming
	if	leftHandItem.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded &&
		(state == CombatantStates.Idle || state == CombatantStates.Moving) {
		if	ds_map_find_value(recoverFrames,"l") == ds_map_find_value(recoverFrameTotals,"l")
			|| ds_map_find_value(recoveringLimbs,"l") == undefined
			{
			isShielding = false; 
			ds_map_replace(preparingLimbs,"l",1);
			state = CombatantStates.Attacking;
		}
	}
}