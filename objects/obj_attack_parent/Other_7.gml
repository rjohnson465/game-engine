// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
for (var i = 0; i < ds_list_size(combatantsHit); i++) {
	var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
	ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
}

//if weapon && weapon.type == HandItemTypes.Melee {
if !isRanged && !isSpell {	
	var recoverSprite = asset_get_index("spr_"+owner.spriteString+currentAttackingHandItemSprite+"_recover_"+string(attackNumber));
	if owner.type != CombatantTypes.Player {
		var recoverSprite = asset_get_index("spr_"+owner.spriteString+currentAttackingHandItemSprite+"_recover_"+string(attackNumber)+"_"+string(owner.attackNumberInChain));
	}
	owner.recoverAnimationTotalFrames = sprite_get_number(recoverSprite);
	owner.recoverAnimationFrame = 0;
	owner.isAttacking = false;
	owner.isRecovering = true;

	instance_destroy(id, false);
}