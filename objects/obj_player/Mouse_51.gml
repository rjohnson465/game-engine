var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {

	// if using a 2h ranged weapon, holding right allows for aiming
	if rightHandItem.type == HandItemTypes.Ranged && rightHandItem.isTwoHanded {
		if	ds_map_find_value(recoverFrames,"r") == ds_map_find_value(recoverFrameTotals,"r")
			|| ds_map_find_value(recoveringLimbs,"r") == undefined
			{
			isShielding = false; 
			ds_map_replace(preparingLimbs,"r",1);
			state = CombatantStates.Attacking;
		}
	}
}