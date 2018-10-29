// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
if combatantsHit {
	for (var i = 0; i < ds_list_size(combatantsHit); i++) {
		var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
		ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
	}
}

if !hasSetAlarm {
	alarm[0] = 15;
	visible = 0;
	speed = 0;
	hasSetAlarm = true;
}