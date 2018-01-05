if !position_meeting(mouse_x,mouse_y, obj_GUI_element) {
	if leftHandItem && leftHandItem.type == HandItemTypes.Shield && 
		(state == CombatantStates.Idle || state == CombatantStates.Moving) {
		isShielding = true;
		global.owner = id;
		instance_create_depth(x,y,1,obj_shield_parent);
	}
}