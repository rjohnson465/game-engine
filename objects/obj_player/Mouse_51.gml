if !isMouseInMenu {

	// if using a 2h ranged weapon, holding right allows for aiming
	if rightHandItem.type == HandItemTypes.Ranged && rightHandItem.isTwoHanded {
		isShielding = false; 
		currentAttackingHand = "r";
		state = CombatantStates.Attacking;
	}
}