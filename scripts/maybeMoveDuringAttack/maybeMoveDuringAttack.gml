// find attack data object
var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
if attackNumber == noone exit;
var isRanged = currentRangedAttack != noone;
var attackData = noone;
var attackChain = isRanged ? rangedAttacks[attackNumber-1] : meleeAttacks[attackNumber-1];
if attackNumberInChain == noone {
	attackData = attackChain[0];
} else {
	attackData = attackChain[attackNumberInChain-1];
}

// move forward while attacking with a melee attack (if not simultaenously preparing another attack)
if ds_map_size(attackingLimbs) != 0 {
	var attackingMelee = currentMeleeAttack != noone;
	if ds_map_size(preparingLimbs) == 0 {
		var x1 = x + lengthdir_x(2,facingDirection);
		var y1 = y + lengthdir_y(2,facingDirection);

		if attackingMelee && attackData.type == AttackTypes.Standard {
			moveToNearestFreePoint(facingDirection,functionalSpeed);
		} else {
			speed = 0;
		}
	} else {
		speed = 0;
	}
}