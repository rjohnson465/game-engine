// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
if ds_exists(combatantsHit, ds_type_list) {
	for (var i = 0; i < ds_list_size(combatantsHit); i++) {
		var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
		if instance_exists(combatantHitWithThisAttack) && object_is_ancestor(combatantHitWithThisAttack.object_index, obj_combatant_parent) {
			ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
		}
	}
}

if !hasSetAlarm {
	alarm[0] = 15;
	visible = 0;
	speed = 0;
	
	
	// maybe make a linger zone?
	if attackData.hasLingerZone {
		if audio_exists(attackData.lingerZoneSoundInit) {
			audio_play_sound_at(attackData.lingerZoneSoundInit, x, y, owner.depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		}
		global.attackData = attackData;
		instance_create_layer(x, y, owner.layer, obj_lingerzone);
	}
	
	hasSetAlarm = true;
}

