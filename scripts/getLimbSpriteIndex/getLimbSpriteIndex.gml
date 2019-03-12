/// getLimbSpriteIndex(state, *limbKey)
/// @param state prep | attack | recover
/// @param *limbKey
/// gets the sprite index for a limb
/// must be called by a limb object instance
/// if the calling instance is an obj_weapon_limbless, get the weapon sprite for this attack

if owner.hp <= 0 exit;

var state = argument[0];
var lk = limbKey;
if argument_count > 1 {
	lk = argument[1];
}

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
	attackNumber = ds_map_find_value(map,lk);
} else {
	attackNumber = owner.currentMeleeAttack != noone? owner.currentMeleeAttack : owner.currentRangedAttack;
}

if attackNumber < 0 return noone;

if owner.type == CombatantTypes.Player {
	var s = spriteString+"_"+state+"_"+string(attackNumber)
	return asset_get_index(s);
} else {
	var attackChainsArray = owner.currentMeleeAttack != noone? owner.meleeAttacks : owner.rangedAttacks;
	var attackChainArray = attackChainsArray[attackNumber];
	var attackNumberInChain = ds_map_find_value(map,lk);
	var attackData = attackChainArray[attackNumberInChain-1];
		
	var spriteAttackNumber = attackData.spriteAttackNumber;
	var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
	
	var maybeWeaponLimblessStr = object_index == obj_weapon_limbless ? "w" : "";
		
	return asset_get_index(spriteString+"_"+ maybeWeaponLimblessStr +state+"_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
}
return noone;