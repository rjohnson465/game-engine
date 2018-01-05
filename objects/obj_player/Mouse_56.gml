if !isMouseInMenu {
	
	if  !rightHandItem.isTwoHanded
		&& stamina > 0 
		&& (state == CombatantStates.Idle || state == CombatantStates.Moving) {
			isShielding = false;
			currentAttackingHand = "l";
			state = CombatantStates.Attacking;
	}
	// shields can only be in left hand
	else if leftHandItem && leftHandItem.type == HandItemTypes.Shield {
		isShielding = false;
	}
}