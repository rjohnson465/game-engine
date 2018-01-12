if !isMouseInMenu {

	// if using a 2h ranged weapon, holding right allows for aiming
	if rightHandItem.type == HandItemTypes.Ranged && rightHandItem.isTwoHanded {
		if	ds_map_find_value(recoverFrames,"r") == ds_map_find_value(recoverFrameTotals,"r")
			|| ds_map_find_value(recoverFrames,"r") == -1
			{
			isShielding = false; 
			ds_map_replace(preparingHands,"r",1);
			state = CombatantStates.Attacking;
		}
	}
}