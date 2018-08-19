/// getLimbSpriteIndex(state)
/// @param state prep | attack | recover
/// gets the sprite index for a limb
/// must be called by a limb object instance

var state = argument0;

var map = noone;
switch state {
	case "prep": {
		map = owner.preparingLimbs;
		break;
	}
	case "attack": {
		map = owner.attackingLimbs;
		break;
	}
	case "recover": {
		map = owner.recoveringLimbs;
		break;
	}
}

var attackNumber = noone;
if owner.type == CombatantTypes.Player {
	attackNumber = ds_map_find_value(map,limbKey);
} else {
	attackNumber = owner.currentMeleeAttack != noone? owner.currentMeleeAttack : owner.currentRangedAttack;
}

if owner.type == CombatantTypes.Player {
	var s = spriteString+"_"+state+"_"+string(attackNumber)
	return asset_get_index(s);
} else {
	var attackChainsArray = owner.currentMeleeAttack != noone? owner.meleeAttacks : owner.rangedAttacks;
	var attackChainArray = attackChainsArray[attackNumber];
	var attackNumberInChain = ds_map_find_value(map,limbKey);
	var attackData = attackChainArray[attackNumberInChain-1];
		
	var spriteAttackNumber = attackData.spriteAttackNumber;
	var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
		
	return asset_get_index(spriteString+"_"+state+"_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
}
return noone;