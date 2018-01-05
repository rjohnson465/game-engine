if !position_meeting(mouse_x,mouse_y, obj_GUI_element) {
	if state != CombatantStates.Attacking {
		var maybeNext = ds_map_find_next(knownSpells,currentSpell);
		if is_undefined(maybeNext) {
			currentSpell = ds_map_find_first(knownSpells);
		} else currentSpell = maybeNext;
	}
}