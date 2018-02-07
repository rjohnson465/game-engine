var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {
	if leftHandItem && leftHandItem.subType == HandItemTypes.Shield && stamina > 0 &&
		(state == CombatantStates.Idle || state == CombatantStates.Moving) {
		isShielding = true;
		global.owner = id;
		instance_create_depth(x,y,1,obj_shield_block);
	}
}