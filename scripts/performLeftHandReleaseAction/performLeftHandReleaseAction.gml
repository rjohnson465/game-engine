var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {
	if  !rightHandItem.isTwoHanded
		&& leftHandItem.subType != HandItemTypes.Shield
		&& stamina > 0 
		&& (state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		{
			// if recovering left hand weapon or if left hand not in use at all
			var isLeftHandInUse = 
				ds_map_find_value(recoveringLimbs,"l") != undefined 
				|| ds_map_find_value(attackingLimbs,"l") != undefined;
			
			
			// idea: have a will attack again map <limb><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isLeftHandInUse {
				ds_map_replace(attackAgain,"l",true);
			} else if ds_map_find_value(preparingLimbs,"l") == undefined {
				ds_map_replace(preparingLimbs,"l",1);
			}
			state = CombatantStates.Attacking;
	}
	// shields can only be in left hand
	else if leftHandItem && leftHandItem.subType == HandItemTypes.Shield {
		isShielding = false;
	}
}