var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
if attackNumber == noone exit;
var isRanged = currentRangedAttack != noone;

// find attack data object
var attackData = noone;
var attackChain = isRanged ? rangedAttacks[attackNumber] : meleeAttacks[attackNumber];
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
			
			// maybe play a mid-attack sound
			if attackData.attackSoundMid != noone && attackData.attackSoundMidFrame != noone {
				if attackObj.image_index == attackData.attackSoundMidFrame {
					audio_play_sound_at(attackData.attackSoundMid, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
				}
			}
			
			if attackData.type == AttackTypes.Charge {
				var chargeDir = point_direction(x,y,chargePointX,chargePointY);
				turnToFacePoint(turnSpeed,chargePointX,chargePointY);
				var chargeSpeed = attackData.chargeSpeed > 0 ? attackData.chargeSpeed : 2*functionalSpeed;
				if isSlowed && attackData.chargeSpeed > 0 {
					chargeSpeed = chargeSpeed * slowedSpeedModifier;
				}
				moveToNearestFreePoint(chargeDir,chargeSpeed,true);
			}
		} else {
			// if there's no attack object for this attack, have a fail safe to start recovery process for this limb
			// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
			var attackInChain = ds_map_find_value(attackingLimbs,limb);
			ds_map_replace(recoveringLimbs,limb,attackInChain);
		
			// set recoverFrames to -1
			ds_map_replace(recoverFrames,limb,-1);
		
			// remove limbKey from attackingLimbs map
			ds_map_delete(attackingLimbs,limb);
		
			prevAttackHand = limb;
		}
		limb = ds_map_find_next(attackingLimbs, limb);
	}
}