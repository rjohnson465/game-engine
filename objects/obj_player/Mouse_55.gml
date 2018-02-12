var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {
	
	if currentSpell != noone && stamina > 0 && state != CombatantStates.Attacking {
	
		if	//currentSpell.type == SpellTypes.Martial 
			//&& 
			((rightHandItem.totalCharges > 0 && rightHandItem.charges > 0)  || (leftHandItem.totalCharges > 0 && leftHandItem.charges > 0))
		{
			currentUsingSpell = currentSpell;
			state = CombatantStates.Attacking;
		}
	}
}