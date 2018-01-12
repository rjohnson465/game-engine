// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
for (var i = 0; i < ds_list_size(combatantsHit); i++) {
	var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
	ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
}

//if weapon && weapon.type == HandItemTypes.Melee {
if isMelee {	
	var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber));
	if owner.type != CombatantTypes.Player {
		var recoverSprite = asset_get_index("spr_"+owner.spriteString+attackItemSprite+"_recover_"+string(attackNumber)+"_"+string(owner.attackNumberInChain));
	}
	var attackInChain = ds_map_find_value(owner.attackingHands,handSide);
	//ds_map_delete(owner.attackingHands,handSide);
	ds_map_replace(owner.recoverFrameTotals,handSide,sprite_get_number(recoverSprite));
	owner.recoverAnimationTotalFrames = sprite_get_number(recoverSprite);
	owner.recoverAnimationFrame = 0;
	ds_map_replace(owner.recoverFrames,handSide,0);
	
	ds_map_add(owner.recoveringHands,handSide,attackInChain);
	owner.isAttacking = false;
	owner.isRecovering = true;

	instance_destroy(id, false);
}