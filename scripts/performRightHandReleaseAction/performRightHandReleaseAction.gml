var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu && !isFrozen {
	if  !leftHandItem.isTwoHanded
		&& rightHandItem.subType != HandItemTypes.Shield
		&& stamina > 0 
		&& (state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		{
			// if recovering left hand weapon or if left hand not in use at all
			var isRightHandInUse = 
				ds_map_find_value(recoveringLimbs,"r") != undefined 
				|| ds_map_find_value(attackingLimbs,"r") != undefined;
			
			
			// have a will attack again map <limb><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isRightHandInUse {
				ds_map_replace(attackAgain,"r",true);
			} else if ds_map_find_value(preparingLimbs,"r") == undefined {
				ds_map_replace(preparingLimbs,"r",1);
			}
			state = CombatantStates.Attacking;
	}
	// shields can only be in right hand
	else if rightHandItem && rightHandItem.subType == HandItemTypes.Shield {
		isShielding = false;
	}
}