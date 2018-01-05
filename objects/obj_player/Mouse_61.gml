if !isMouseInMenu {
	if state != CombatantStates.Attacking {
		var maybeNext = ds_map_find_next(knownSpells,currentSpell);
		if is_undefined(maybeNext) {
			currentSpell = ds_map_find_first(knownSpells);
		} else currentSpell = maybeNext;
	}
}