if !isMouseInMenu {
	
	if  !rightHandItem.isTwoHanded
		&& leftHandItem.type != HandItemTypes.Shield
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