if !isMouseInMenu {
	if leftHandItem && leftHandItem.type == HandItemTypes.Shield && 
		(state == CombatantStates.Idle || state == CombatantStates.Moving) {
		isShielding = true;
		global.owner = id;
		instance_create_depth(x,y,1,obj_shield_parent);
	}
}