// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
if ds_exists(combatantsHit, ds_type_list) {
	for (var i = 0; i < ds_list_size(combatantsHit); i++) {
		var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
		if instance_exists(combatantHitWithThisAttack) && object_is_ancestor(combatantHitWithThisAttack.object_index, obj_combatant_parent) {
			ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
		}
	}
}

	

//instance_destroy(id, true);
if !hasSetAlarm {
	
	// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
	var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
	ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
	// set recoverFrames to -1
	ds_map_replace(owner.recoverFrames,limbKey,-1);
		
	// remove limbKey from attackingLimbs map
	ds_map_delete(owner.attackingLimbs,limbKey);
		
	owner.prevAttackHand = limbKey;
	
	alarm[0] = 30;
	hasSetAlarm = true;
	image_speed = 0;
	
	if attackData != noone && attackData.hasLightRadius {
		var fNum = getLayerFloorNumber(owner.layer);
		light_destroy_layer(fNum);
	}
	
}