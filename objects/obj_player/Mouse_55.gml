if !isMouseInMenu {
	
	if currentSpell != noone && stamina > 0 {
	
		if	currentSpell.type == SpellTypes.Martial 
			&& ((rightHandItem.totalCharges > 0 && rightHandItem.charges > 0)  || (leftHandItem.totalCharges > 0 && leftHandItem.charges > 0))
		{
			currentUsingSpell = currentSpell;
			state = CombatantStates.Attacking;
		}
	}
}