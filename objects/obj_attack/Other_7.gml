// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
if combatantsHit {
	for (var i = 0; i < ds_list_size(combatantsHit); i++) {
		var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
		ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
	}
}

if isMelee {	
	
	// make player attack again immediately at the end of an attack if attacking again 
	// only if another attack exists in chain
	var prepString = "spr_"+owner.spriteString+attackItemSprite+"_prep_"+string(attackNumber+1);
	if	owner.type == CombatantTypes.Player 
		&& ds_map_find_value(owner.attackAgain,limbKey) 
		&& asset_get_index(prepString) != -1
		{
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
	/*if weapon != noone && weapon.weaponType == BLUNT2H && attackNumber == 3 {
		alarm[0] = 25;
		hasSetAlarm = true;
	}
	else*/ instance_destroy(id, true);
}