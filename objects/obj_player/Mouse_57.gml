if !isMouseInMenu {

	if rightHandItem.type == HandItemTypes.Ranged && rightHandItem.isTwoHanded {
		isReadyToFire = false;
		isPreparingAttack = false;
		prepAnimationFrame = 0;
		currentAttackingHand = noone;
		state = CombatantStates.Idle;
	}
	else if  //rightHandItem.type == HandItemTypes.Melee && 
		stamina > 0 &&
		(state == CombatantStates.Idle || state == CombatantStates.Moving) {
			isShielding = false;
			currentAttackingHand = "r";
			state = CombatantStates.Attacking;
	}
}

