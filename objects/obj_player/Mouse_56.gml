if !isMouseInMenu {
	
	if  !rightHandItem.isTwoHanded
		&& leftHandItem.type != HandItemTypes.Shield
		&& stamina > 0 
		&& (state != CombatantStates.Dodging || state == CombatantStates.Staggering) {
			// if recovering left hand weapon or if left hand not in use at all
			var isLeftHandInUse = 
				ds_map_find_value(preparingHands,"l") != undefined 
				|| ds_map_find_value(recoveringHands,"l") != undefined 
				|| ds_map_find_value(attackingHands,"l") != undefined;
			
			if	ds_map_find_value(recoveringHands,"l") 
				|| !isLeftHandInUse
			{
				//isShielding = false;
				// if continuing an attack combo with the same hand, set the proper attack chain num in map
				
				// TODO -- this allows for immediate follow-up if player clicks same mouse button during recovery
				// must find a way to make it wait until previous hand is done
				// idea: have a will attack again map <handSide><boolean> kvp's -- in Step event, at end of recover,
				// check the will attack again map. If it will attack again and there's enough stamina, do it
				if ds_map_find_value(recoveringHands,"l") {
					var attackInChain = ds_map_find_value(recoveringHands,"l") + 1;
					ds_map_replace(preparingHands,"l", attackInChain);
				} else {
					ds_map_replace(preparingHands,"l",1);
				}
				state = CombatantStates.Attacking;
			}
	}
	// shields can only be in left hand
	else if leftHandItem && leftHandItem.type == HandItemTypes.Shield {
		isShielding = false;
	}
}