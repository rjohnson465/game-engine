if ds_map_find_value(owner.attackingLimbs,limbKey) > 0 {
	var attackNumber = noone;
	if owner.type == CombatantTypes.Player {
		attackNumber = ds_map_find_value(owner.attackingLimbs,limbKey);
	} else {
		attackNumber = owner.currentMeleeAttack != noone? owner.currentMeleeAttack : owner.currentRangedAttack;
	}
	image_index = 0;
	
	if owner.type == CombatantTypes.Player {
		sprite_index = asset_get_index(spriteString+"_attack_"+string(attackNumber));
	} else {
		var attackChainsArray = owner.currentMeleeAttack != noone? owner.meleeAttacks : owner.rangedAttacks;
		var attackChainArray = attackChainsArray[attackNumber-1];
		var attackNumberInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
		var attackData = attackChainArray[attackNumberInChain-1];
		
		var spriteAttackNumber = attackData.spriteAttackNumber;
		var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
		
		sprite_index = asset_get_index(spriteString+"_attack_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
	}
} 
else if ds_map_find_value(owner.recoveringLimbs,limbKey) > 0 {
	var attackNumber = noone;
	if owner.type == CombatantTypes.Player {
		attackNumber = ds_map_find_value(owner.recoveringLimbs,limbKey);
	} else {
		attackNumber = owner.currentMeleeAttack != noone? owner.currentMeleeAttack : owner.currentRangedAttack;
	}
	image_index = 0;
	
	if owner.type == CombatantTypes.Player {
		sprite_index = asset_get_index(spriteString+"_recover_"+string(attackNumber));
	} else {
		var attackChainsArray = owner.currentMeleeAttack != noone? owner.meleeAttacks : owner.rangedAttacks;
		var attackChainArray = attackChainsArray[attackNumber-1];
		var attackNumberInChain = ds_map_find_value(owner.recoveringLimbs,limbKey);
		var attackData = attackChainArray[attackNumberInChain-1];
		
		var spriteAttackNumber = attackData.spriteAttackNumber;
		var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
		
		sprite_index = asset_get_index(spriteString+"_recover_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
	}
} 
else {
	var a = spriteString;
	sprite_index = asset_get_index(spriteString);
}