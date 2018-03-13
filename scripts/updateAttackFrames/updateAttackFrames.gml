var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
if attackNumber == noone exit;
var isRanged = currentRangedAttack != noone;

// find attack data object
var attackData = noone;
var attackChain = isRanged ? rangedAttacks[attackNumber-1] : meleeAttacks[attackNumber-1];
if attackNumberInChain == noone {
	attackData = attackChain[0];
} else {
	attackData = attackChain[attackNumberInChain-1];
}

// update attackFrames values
if ds_map_size(attackingLimbs) != 0 {
	var limb = ds_map_find_first(attackingLimbs);
	for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
		var attackObj = noone;
		with obj_attack {
			if owner = other.id && limbKey == limb {
				attackObj = id;
			}
		}
		if attackObj != noone {
			ds_map_replace(attackFrames,limb,attackObj.image_index);
			if attackData.type == AttackTypes.Charge {
				var chargeDir = point_direction(x,y,chargePointX,chargePointY);
				turnToFacePoint(turnSpeed,chargePointX,chargePointY);
				moveToNearestFreePoint(chargeDir,2*functionalSpeed,true);
			}
		}
		limb = ds_map_find_next(attackingLimbs, limb);
	}
}