performCycleThroughSpells("up");
/*var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");

if !isMouseInMenu {
	if state != CombatantStates.Attacking {
		var maybePrev = ds_map_find_previous(knownSpells,currentSpell);
		if is_undefined(maybePrev) {
			currentSpell = ds_map_find_last(knownSpells);
		} else currentSpell = maybePrev;
	}
}