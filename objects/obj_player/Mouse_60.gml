if !isMouseInMenu {
	if state != CombatantStates.Attacking {
		var maybePrev = ds_map_find_previous(knownSpells,currentSpell);
		if is_undefined(maybePrev) {
			currentSpell = ds_map_find_last(knownSpells);
		} else currentSpell = maybePrev;
	}
}