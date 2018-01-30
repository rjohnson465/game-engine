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
		&& ds_map_find_value(owner.attackAgain,handSide) 
		&& asset_get_index(prepString) != -1
		{
		var attackInChain = ds_map_find_value(owner.attackingHands,handSide);
		ds_map_replace(owner.preparingHands,handSide,attackInChain+1);
		ds_map_delete(owner.attackingHands,handSide);
		ds_map_replace(owner.attackAgain,handSide,false);
	}
	// if not attack again
	else {
		var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber));
		if owner.type != CombatantTypes.Player {
			var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber)+"_"+string(owner.attackNumberInChain));
		}
		var attackInChain = ds_map_find_value(owner.attackingHands,handSide);
		ds_map_replace(owner.recoverFrameTotals,handSide,sprite_get_number(recoverSprite));
		ds_map_replace(owner.recoverFrames,handSide,-1);
	
		ds_map_replace(owner.recoveringHands,handSide,attackInChain);
		owner.prevAttackHand = handSide;
	}

	instance_destroy(id, false);
}