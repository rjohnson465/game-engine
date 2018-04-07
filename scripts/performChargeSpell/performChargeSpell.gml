/// performChargeSpell

if global.isWishing exit;

var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {
	
	if currentSpell != noone && stamina > 0 && state != CombatantStates.Attacking {
	
		if	((rightHandItem.totalCharges > 0 && rightHandItem.charges > 0)  || (leftHandItem.totalCharges > 0 && leftHandItem.charges > 0))
		{
			currentUsingSpell = currentSpell;
			state = CombatantStates.Attacking;
		} else if !hasAlertedNoMagicCharges {
			alert("No magic charges",c_red);
			hasAlertedNoMagicCharges = true;
			alarm[1] = 60;
		}
	}
}