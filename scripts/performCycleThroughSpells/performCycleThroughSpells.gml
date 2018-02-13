/// performCycleThroughSpells(dir)
/// @param dir up | down

var dir = argument0;

if dir == "up" {
	
	if !isMouseInMenu {
		if state != CombatantStates.Attacking {
			var maybePrev = ds_map_find_previous(knownSpells,currentSpell);
			if is_undefined(maybePrev) {
				currentSpell = ds_map_find_last(knownSpells);
			} else currentSpell = maybePrev;
		}
	}

} else {
	if !isMouseInMenu {
		if state != CombatantStates.Attacking {
			var maybeNext = ds_map_find_next(knownSpells,currentSpell);
			if is_undefined(maybeNext) {
				currentSpell = ds_map_find_first(knownSpells);
			} else currentSpell = maybeNext;
		}
	}
}