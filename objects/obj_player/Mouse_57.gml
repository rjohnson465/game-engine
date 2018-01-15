if !isMouseInMenu {

	if rightHandItem.type == HandItemTypes.Ranged && rightHandItem.isTwoHanded {
		isReadyToFire = false;
		ds_map_delete(preparingHands,"r");
		ds_map_replace(prepFrames,"r",-1);
		ds_map_replace(prepFrameTotals,"r",0);
		ds_map_delete(attackingHands,"r");
		ds_map_delete(recoveringHands,"r");
		state = CombatantStates.Idle;
	}
	else if
		stamina > 0 &&
		(state != CombatantStates.Dodging || state != CombatantStates.Staggering) {
			isShielding = false;
			// if recovering left hand weapon or if left hand not in use at all
			var isRightHandInUse = 
				ds_map_find_value(preparingHands,"r") != undefined 
				//|| ds_map_find_value(recoveringHands,"r") != undefined 
				|| ds_map_find_value(attackingHands,"r") != undefined;
			
			// idea: have a will attack again map <handSide><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isRightHandInUse {
	
				ds_map_replace(attackAgain,"r",true);
			} else {
				ds_map_replace(preparingHands,"r",1);
			}
			state = CombatantStates.Attacking;
	}
}

