// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
for (var i = 0; i < ds_list_size(combatantsHit); i++) {
	var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
	ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
}

//if weapon && weapon.type == HandItemTypes.Melee {
if isMelee {	
	//var s = "spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber);
	
	// make player attack again immediately at the end of an attack if attacking again 
	// only if another attack exists in chain
	// TODO
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
		var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber));
		if owner.type != CombatantTypes.Player {
			var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber)+"_"+string(owner.attackNumberInChain));
		}
		var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		ds_map_replace(owner.recoverFrameTotals,limbKey,sprite_get_number(recoverSprite));
		ds_map_replace(owner.recoverFrames,limbKey,-1);
	
		ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		owner.prevAttackHand = limbKey;
	}

	instance_destroy(id, false);
}