if !position_meeting(mouse_x,mouse_y, obj_GUI_element) {

	// if using a 2h ranged weapon, holding right allows for aiming
	if rightHandItem.type == HandItemTypes.Ranged && rightHandItem.isTwoHanded {
		isShielding = false; 
		currentAttackingHand = "r";
		state = CombatantStates.Attacking;
	}
}