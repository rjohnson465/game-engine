// iterate over the recover frames for all limbs to see if an attack is ended
var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
if attackNumber == noone exit;
var isRanged = currentRangedAttack != noone;

if ds_map_size(recoveringLimbs) != 0 {
	var currentRecoveringLimbKey = ds_map_find_first(recoveringLimbs);
	for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
		var recoverFrame = ds_map_find_value(recoverFrames,currentRecoveringLimbKey);
		var recoverFrameTotal = ds_map_find_value(recoverFrameTotals,currentRecoveringLimbKey);
		
		var currentAttack = currentMeleeAttack != noone ? currentMeleeAttack : currentRangedAttack;
		var attacksChainArray = currentMeleeAttack != noone ? meleeAttacks : rangedAttacks;
		var attackChainArray = attacksChainArray[currentAttack];
		var attackInChain = ds_map_find_value(recoveringLimbs,currentRecoveringLimbKey);
		var attackData = noone;
		if attackInChain != undefined {
			attackData = attackChainArray[attackInChain-1];
			var spriteAttackNumber = attackData.spriteAttackNumber;
			var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
		
			var recoverSprite = asset_get_index(attackData.spriteName+"_recover_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
			var recoverSpriteSpeed = sprite_get_speed(recoverSprite);
			var incAmount = recoverSpriteSpeed/30;
		} else exit;
		
		// check if this hand just started recovering attack
		if recoverFrame == -1 {
			prevAttackLimb = currentRecoveringLimbKey;
			ds_map_replace(recoverFrames,currentRecoveringLimbKey,0);
			
			// jumpToNearestFreePoint(true, true);
			
			// maybe play recover sound
			if attackData != noone && attackData.recoverSound != noone && audio_exists(attackData.recoverSound) {
				audio_play_sound_at(attackData.recoverSound, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
			}
			
			if attackData.coolDownFrames != noone && is_array(attackData.coolDownFrames) {
				if isRanged {
					attackFrequencyTotalFramesRanged = attackData.coolDownFrames;
				} else {
					attackFrequencyTotalFramesMelee = attackData.coolDownFrames;
				}
			} else {
				if isRanged {
					attackFrequencyTotalFramesRanged = attackFrequencyTotalFramesRangedDefault;
				} else {
					attackFrequencyTotalFramesMelee = attackFrequencyTotalFramesMeleeDefault;
				}
			}
			
			var recoverSprite = asset_get_index(attackData.spriteName+"_recover_"+string(spriteAttackNumber)+"_"+string(spriteAttackNumberInChain));
			ds_map_replace(recoverFrameTotals,currentRecoveringLimbKey,sprite_get_number(recoverSprite));
		}
		// if at end of recover, we may need to leave attack state (if no other limbs are recovering or preparing or attacking)
		else if recoverFrame >= recoverFrameTotal-1 {
			// no matter what, we need to remove this limb from recoveringLimbs and reset frame values
			ds_map_delete(recoveringLimbs,currentRecoveringLimbKey);
			ds_map_replace(recoverFrames,currentRecoveringLimbKey,-1);
			ds_map_replace(recoverFrameTotals,currentRecoveringLimbKey,0);
		} else {
			if isSlowed {
				ds_map_replace(recoverFrames,currentRecoveringLimbKey,recoverFrame+(.5*incAmount));
			} else {
				// increment frames according to sprite image speed
				ds_map_replace(recoverFrames,currentRecoveringLimbKey,recoverFrame+incAmount);
			}
		}
		currentRecoveringLimbKey = ds_map_find_next(recoveringLimbs,currentRecoveringLimbKey);
	}
}