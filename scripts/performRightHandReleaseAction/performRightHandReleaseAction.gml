var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {

	if rightHandItem.subType == HandItemTypes.Ranged && rightHandItem.isTwoHanded {
		
		ds_map_delete(preparingLimbs,"r");
		ds_map_replace(prepFrames,"r",-1);
		ds_map_replace(prepFrameTotals,"r",0);
		ds_map_delete(attackingLimbs,"r");
		
		/*if isReadyToFire {
			ds_map_replace(recoveringLimbs,"r",1);
			ds_map_replace(recoverFrames,"r",-1);
		}*/
		isReadyToFire = false;
		ds_map_delete(recoveringLimbs,"r");
		state = CombatantStates.Idle;
	}
	else if
		stamina > 0 &&
		(state != CombatantStates.Dodging && state != CombatantStates.Staggering)
		&& !isPhasing {
			isShielding = false;
			// if recovering left hand weapon or if left hand not in use at all
			var isRightHandInUse = 
				ds_map_find_value(recoveringLimbs,"r") != undefined 
				|| ds_map_find_value(attackingLimbs,"r") != undefined;
			
			// idea: have a will attack again map <handSide><boolean> kvp's -- in Step event, at end of recover,
			// check the will attack again map. If it will attack again and there's enough stamina, do it
			if isRightHandInUse {
	
				ds_map_replace(attackAgain,"r",true);
			} else if ds_map_find_value(preparingLimbs,"r") == undefined {
				ds_map_replace(preparingLimbs,"r",1);
			}
			state = CombatantStates.Attacking;
	}
}
