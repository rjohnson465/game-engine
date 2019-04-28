// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
if ds_exists(combatantsHit, ds_type_list) {
	for (var i = 0; i < ds_list_size(combatantsHit); i++) {
		var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
		if instance_exists(combatantHitWithThisAttack) && object_is_ancestor(combatantHitWithThisAttack.object_index, obj_combatant_parent) {
			ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
		}
	}
}

instance_destroy(id,1);
