ds_list_clear(combatantsHit);
with obj_combatant_parent {
	var ind = ds_list_find_index(beenHitWith, other);
	if ind != -1 {
		ds_list_delete(beenHitWith,ind);
	}
}
alarm[2] = attackData.refreshCombatantsHit;