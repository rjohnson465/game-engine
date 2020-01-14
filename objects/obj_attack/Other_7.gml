// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
if ds_exists(combatantsHit, ds_type_list) {
	for (var i = 0; i < ds_list_size(combatantsHit); i++) {
		var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
		if instance_exists(combatantHitWithThisAttack) && object_is_ancestor(combatantHitWithThisAttack.object_index, obj_combatant_parent) {
			ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
		}
	}
}


if isMelee && !hasSetAlarm {	
	
	if owner.fallFrame != 0 {
		// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
		// set recoverFrames to -1
		ds_map_replace(owner.recoverFrames,limbKey,-1);
		
		// remove limbKey from attackingLimbs map
		ds_map_delete(owner.attackingLimbs,limbKey);
		
		owner.prevAttackHand = limbKey;
	}
	
	
	else if	owner.type == CombatantTypes.Player 
		&& ds_map_find_value(owner.attackAgain,limbKey) 
		&& asset_get_index(prepString) != -1
		{
		// make player attack again immediately at the end of an attack if attacking again 
		// only if another attack exists in chain
		var prepString = "spr_"+owner.spriteString+attackItemSprite+"_prep_"+string(attackNumber+1);
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.preparingLimbs,limbKey,attackInChain+1);
		ds_map_delete(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.attackAgain,limbKey,false);
	}
	// if not attack again
	else {
	
		// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
		// set recoverFrames to -1
		ds_map_replace(owner.recoverFrames,limbKey,-1);
		
		// remove limbKey from attackingLimbs map
		ds_map_delete(owner.attackingLimbs,limbKey);
		
		owner.prevAttackHand = limbKey;
	}
	
	// destroy (with delay, for particles)
	if !hasSetAlarm {
		alarm[0] = 30;
		hasSetAlarm = true;
		sprite_index = -1;
	}
	// instance_destroy(id, true);
}