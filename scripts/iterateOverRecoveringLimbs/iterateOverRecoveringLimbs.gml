// iterate over the recover frames for all limbs to see if an attack is ended
var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
if attackNumber == noone exit;
var isRanged = currentRangedAttack != noone;

if ds_map_size(recoveringLimbs) != 0 {
	var currentRecoveringLimbKey = ds_map_find_first(recoveringLimbs);
	for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
		var recoverFrame = ds_map_find_value(recoverFrames,currentRecoveringLimbKey);
		var recoverFrameTotal = ds_map_find_value(recoverFrameTotals,currentRecoveringLimbKey);
				
		// check if this hand just started recovering attack
		if recoverFrame == -1 {
			prevAttackLimb = currentRecoveringLimbKey;
			ds_map_replace(recoverFrames,currentRecoveringLimbKey,0);
						
			var currentAttack = currentMeleeAttack != noone ? currentMeleeAttack : currentRangedAttack;
			var attacksChainArray = currentMeleeAttack != noone ? meleeAttacks : rangedAttacks;
			var attackChainArray = attacksChainArray[currentAttack-1];
			var attackInChain = ds_map_find_value(recoveringLimbs,currentRecoveringLimbKey);
			var attackData = attackChainArray[attackInChain-1];
			var spriteAttackNumber = attackData.spriteAttackNumber;
			var spriteAttackNumberInChain = attackData.spriteAttackNumberInChain;
						
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
				ds_map_replace(recoverFrames,currentRecoveringLimbKey,recoverFrame+.5);
			} else {
				ds_map_replace(recoverFrames,currentRecoveringLimbKey,recoverFrame+1);
			}
		}
		//show_debug_message("recover: " + string(ds_map_find_value(recoverFrames,currentRecoveringLimbKey)));
		currentRecoveringLimbKey = ds_map_find_next(recoveringLimbs,currentRecoveringLimbKey);
	}
}