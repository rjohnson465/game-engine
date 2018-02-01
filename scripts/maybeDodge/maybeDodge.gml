/// @description maybeDodge()

// If we're close to our lockOnTarget and they're preparing attack and we've decided to dodge during this Move state,
// decide exactly what frame in the lockOnTarget's attack prep to dodge on
// TODO should combatants also pay attention to other enemies around them, other than just their lockOnTarget?
// melee dodges
var isMeleeAttack = false;
// attackHand is the hand that is currently preparing but will finish preparation sooner
var prepFrameL = ds_map_find_value(prepFrames,"l") == undefined ? 0 : ds_map_find_value(prepFrames,"l");
var prepFrameLTotal = ds_map_find_value(prepFrameTotals,"l") == undefined ? 0 : ds_map_find_value(prepFrameTotals,"l");
var prepFrameR = ds_map_find_value(prepFrames,"r") == undefined ? 0 : ds_map_find_value(prepFrames,"r");
var prepFrameRTotal = ds_map_find_value(prepFrameTotals,"r") == undefined ? 0 : ds_map_find_value(prepFrameTotals,"r");
var attackHand = 
	prepFrameL / prepFrameLTotal >= 
	prepFrameR / prepFrameRTotal ? "l" : "r";
if lockOnTarget.type == CombatantTypes.Player {
	isMeleeAttack = attackHand == "l" ? lockOnTarget.leftHandItem.type == HandItemTypes.Melee : lockOnTarget.rightHandItem.type == HandItemTypes.Melee;
} else {
	isMeleeAttack = lockOnTarget.currentMeleeAttack != noone;
}
var attackObj = instance_nearest(x,y,obj_attack);
var range = 45; // the range at which to start attempting dodge. default is 45 pixels.
// if dodging a player's melee attack, range is based on the melee weapon the player is using
if lockOnTarget.type == CombatantTypes.Player && isMeleeAttack {
	var weapon = lockOnTarget.currentAttackingHand == "l" ? lockOnTarget.leftHandItem : lockOnTarget.rightHandItem;
	if weapon.range != 0 {
		range = weapon.range;
	}
}
// AI combatants have every attack range pre-loaded in attack data
else if lockOnTarget.type != CombatantTypes.Player && isMeleeAttack {
	// TODO
}
// if the attack is coming from an Ally or Enemy, base it on their current attack range
else if (lockOnTarget.type == CombatantTypes.Ally || lockOnTarget.type == CombatantTypes.Enemy) && isMeleeAttack {
	range = lockOnTarget.meleeRangeArray[lockOnTarget.currentMeleeAttack-1] + 10; // 10px padding
}
if distance_to_object(lockOnTarget) < range*1.5 && ds_map_size(lockOnTarget.preparingLimbs) != 0 && willDodge && isMeleeAttack {
				
	// the more agile the enemy, the better chance it will dodge when player is almost done preparing attack
	randomize();
					
	// always dodge the furthest along in prep sequence attack if there a multiple preparing hands
	var prepFrame = ds_map_find_value(lockOnTarget.prepFrames,attackHand);
	var prepFrameTotal = ds_map_find_value(lockOnTarget.prepFrameTotals,attackHand);
					
	var percentDonePreparingAttack = prepFrame/prepFrameTotal;
	var percentageChangeEachFrame = 1/prepFrameTotal;
	// if agility - playerPercentDonePreparingAttack is the closest it can possibly be to percentageChangeEachFrame, yes, dodge this frame
	var testNum = (agility / 100) - percentDonePreparingAttack;
	var shouldDodgeOnThisFrame = false;
	var nextFrameTestNum = (agility / 100) - (percentDonePreparingAttack + percentageChangeEachFrame)
	var isNextFrameTooFar =  nextFrameTestNum <= percentageChangeEachFrame*2;
	if  isNextFrameTooFar {
		shouldDodgeOnThisFrame = true;
	}
	var willDodgeOnThisFrame = willDodge && shouldDodgeOnThisFrame;
				
	if willDodgeOnThisFrame && stamina > 0 && !isFrozen {
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
		hasCalculatedWillDodge = false;
		dodgeDirection = (facingDirection+180)%360;
		path_end();
		stamina -= 10;
		state = CombatantStates.Dodging;
		return true;
		//break;
	}
}
				
// ranged dodges TODO
// if within range of a ranged attack object (projectile), time dodge based on agility (and if combatant can see the projectile)
else if distance_to_object(obj_attack) < 200 - agility && script_execute(scr_is_facing,id,attackObj) && willDodge {
	var attackObj = instance_nearest(x,y,obj_attack);
	if attackObj.isMelee exit;
	var attackObjOwnerIndex = noone;
	with attackObj.owner {
		attackObjOwnerIndex = object_index;
	}
	var isEnemyAttack = object_is_ancestor(attackObjOwnerIndex,lockOnTargetType);
	if stamina > 0 && !isFrozen && isEnemyAttack {
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
		hasCalculatedWillDodge = false;
		randomize();
		var rand = floor(random_range(1.01,2.99));
		dodgeDirection = rand == 1 ? (attackObj.owner.facingDirection+90)%360 : (attackObj.owner.facingDirection - 90 + 360)%360;
		path_end();
		stamina -= 10;
		state = CombatantStates.Dodging;
		return true;
		//break;
	}
}