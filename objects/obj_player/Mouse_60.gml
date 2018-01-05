if !position_meeting(mouse_x,mouse_y, obj_GUI_element) {
	if state != CombatantStates.Attacking {
		var maybePrev = ds_map_find_previous(knownSpells,currentSpell);
		if is_undefined(maybePrev) {
			currentSpell = ds_map_find_last(knownSpells);
		} else currentSpell = maybePrev;
	}
}