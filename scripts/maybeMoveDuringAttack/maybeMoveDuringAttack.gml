// find attack data object
var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
if attackNumber == noone exit;
var isRanged = currentRangedAttack != noone;
var attackData = noone;
var attackChain = isRanged ? rangedAttacks[attackNumber] : meleeAttacks[attackNumber];
if attackNumberInChain == noone {
	attackData = attackChain[0];
} else {
	attackData = attackChain[attackNumberInChain-1];
}

// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
if ds_map_size(attackingLimbs) != 0 {
	var attackingMelee = currentMeleeAttack != noone;
	if ds_map_size(preparingLimbs) == 0 {

		if attackingMelee && attackData.type == AttackTypes.Standard {
			moveToNearestFreePoint(facingDirection,functionalSpeed, type == CombatantTypes.Enemy, type == CombatantTypes.Enemy, 45);
		} else {
			speed = 0;
		}
		
		// MAYBE turn during attack
		if attackData.turnsDuringAttack && attackData.turnSpeedAttack > 0 {
			turnToFacePoint(attackData.turnSpeedAttack, lockOnTarget.x, lockOnTarget.y);
		}
		
	} else {
		speed = 0;
	}
}
