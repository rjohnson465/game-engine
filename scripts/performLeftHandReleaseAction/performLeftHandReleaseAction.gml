var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {

	if leftHandItem.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded {
		
		ds_map_delete(preparingLimbs,"l");
		ds_map_replace(prepFrames,"l",-1);
		ds_map_replace(prepFrameTotals,"l",0);
		ds_map_delete(attackingLimbs,"l");
		
		isReadyToFire = false;
		ds_map_delete(recoveringLimbs,"l");
		state = CombatantStates.Idle;
	}
	else if
		stamina > 0 &&
		(state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		&& !isPhasing {
			isShielding = false;
			// if recovering left hand weapon or if left hand not in use at all
			var isLeftHandInUse = 
				ds_map_find_value(recoveringLimbs,"l") != undefined 
				|| ds_map_find_value(attackingLimbs,"l") != undefined;
			
			// idea: have a will attack again map <handSide><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isLeftHandInUse {
				ds_map_replace(attackAgain,"l",true);
			} else if ds_map_find_value(preparingLimbs,"l") == undefined {
				ds_map_replace(preparingLimbs,"l",1);
			}
			state = CombatantStates.Attacking;
	}
}

