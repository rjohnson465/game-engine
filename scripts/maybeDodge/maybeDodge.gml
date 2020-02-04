/// @description maybeDodge()



// if we've not yet calculated if we'll dodge during this Move state, calculate that now
// this is calculated only once per move state
if !hasCalculatedWillDodge {
	randomize();
	var rand = random_range(1,100);
	willDodge = rand <= agility ? true : false;
	hasCalculatedWillDodge = true;
}

if dodgeFrequencyFrame > 0 {
	dodgeFrequencyFrame--;
	exit;
}

if lockOnTarget == noone || !lockOnTarget || !object_is_ancestor(lockOnTarget.object_index, obj_combatant_parent) exit;

// If we're close to our lockOnTarget and they're preparing attack and we've decided to dodge during this Move state,
// decide exactly what frame in the lockOnTarget's attack prep to dodge on
// TODO should combatants also pay attention to other enemies around them, other than just their lockOnTarget?
// melee dodges
var isMeleeAttack = false;
// attackHand is the hand that is currently preparing but will finish preparation sooner
var prepFrameL = ds_map_find_value(lockOnTarget.prepFrames,"l") == undefined ? 0 : ds_map_find_value(lockOnTarget.prepFrames,"l");
var prepFrameLTotal = ds_map_find_value(lockOnTarget.prepFrameTotals,"l") == undefined ? 0 : ds_map_find_value(lockOnTarget.prepFrameTotals,"l");
var prepFrameR = ds_map_find_value(lockOnTarget.prepFrames,"r") == undefined ? 0 : ds_map_find_value(lockOnTarget.prepFrames,"r");
var prepFrameRTotal = ds_map_find_value(lockOnTarget.prepFrameTotals,"r") == undefined ? 0 : ds_map_find_value(lockOnTarget.prepFrameTotals,"r");
var attackHand = 
	prepFrameL / prepFrameLTotal >= 
	prepFrameR / prepFrameRTotal ? "l" : "r";
var nearestAttackObj = instance_nearest(x,y,obj_attack);
if prepFrameL == -1 && prepFrameR == -1 && distance_to_object(nearestAttackObj) > 200 exit;
if prepFrameL == -1 attackHand = "r";
else attackHand = "l";

if lockOnTarget.type == CombatantTypes.Player {
	//isMeleeAttack = attackHand == "l" ? lockOnTarget.leftHandItem.subType == HandItemTypes.Melee : lockOnTarget.rightHandItem.subType == HandItemTypes.Melee;
	var lItem = ds_map_find_value(lockOnTarget.equippedLimbItems,"l");
	var rItem = ds_map_find_value(lockOnTarget.equippedLimbItems,"r");
	isMeleeAttack = attackHand == "l" ? lItem.subType == HandItemTypes.Melee : rItem.subType == HandItemTypes.Melee;
	// still might be some ranged attack nearby you should care about more
	var attackObj = instance_nearest(x,y,obj_attack);
	if attackObj != noone {
		if attackObj.owner == lockOnTarget {
			isMeleeAttack = false;
		}
	}
} else {
	isMeleeAttack = lockOnTarget.currentMeleeAttack != noone;
}

var range = 45; // the range at which to start attempting dodge. default is 45 pixels.
// if dodging a player's melee attack, range is based on the melee weapon the player is using
if lockOnTarget.type == CombatantTypes.Player && isMeleeAttack {
	//var weapon = attackObj.limbKey == "l" ? lockOnTarget.leftHandItem : lockOnTarget.rightHandItem;
	var weapon = ds_map_find_value(lockOnTarget.equippedLimbItems,attackHand);
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
	range = getRangeForAttackIndex(lockOnTarget.currentMeleeAttack, true) /*lockOnTarget.meleeRangeArray[lockOnTarget.currentMeleeAttack]*/ + 10; // 10px padding
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
	var nextFrameTestNum = (agility / 100) - (percentDonePreparingAttack + percentageChangeEachFrame);
	var isNextFrameTooFar =  nextFrameTestNum <= percentageChangeEachFrame*2;
	if  isNextFrameTooFar {
		shouldDodgeOnThisFrame = true;
	}
	var willDodgeOnThisFrame = willDodge && shouldDodgeOnThisFrame;
				
	if willDodgeOnThisFrame && !isFrozen {
		if totalDodgeFrames == -1 {
			 // this combatant can't dodge, but maybe they can become wary?
			if state != CombatantStates.Wary {
				return maybeBecomeWary();
			} else return false;

		}
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
		hasCalculatedWillDodge = false;
		hasCalculatedWillShield = false;
		dodgeDirection = (facingDirection+180)%360;
		path_end();
		stamina -= 15;
		state = CombatantStates.Dodging;
		return true;
		//break;
	}
}
				
// ranged dodges
// if within range of a ranged attack object (projectile), time dodge based on agility 
// MAYBE if combatant can see the projectile
else if distance_to_object(obj_attack) < 200 - agility && willDodge {
	
	if totalDodgeFrames == -1 {
		/*if state != CombatantStates.Wary {
			return maybeBecomeWary();
		} else return false;*/
		exit;
	}
	
	// if we can't see the projectile, we still might be able to dodge it if we're agile enough
	if !scr_is_facing(id,attackObj) {
		randomize();
		var rand = random_range(0,100);
		if rand >= agility {
			exit;
		}
	}
	if attackObj.isMelee exit;
	var attackObjOwnerIndex = noone;
	with attackObj.owner {
		attackObjOwnerIndex = object_index;
	}
	var isEnemyAttack = object_is_ancestor(attackObjOwnerIndex,lockOnTargetType);
	if stamina > 0 && !isFrozen && isEnemyAttack {
		facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
		hasCalculatedWillDodge = false;
		hasCalculatedWillShield = false;
		randomize();
		var rand = floor(random_range(1.01,2.99));
		dodgeDirection = rand == 1 ? (attackObj.owner.facingDirection+90)%360 : (attackObj.owner.facingDirection - 90 + 360)%360;
		path_end();
		stamina -= 15;
		state = CombatantStates.Dodging;
		return true;
		//break;
	}
}