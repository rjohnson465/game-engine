// iterate over the preparing limbs to see if an attack should fire
// TODO what about non humanoid attackers or attacks that do not use limbs?

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

var currentPreparingLimbKey = ds_map_find_first(preparingLimbs); // limbKey
for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
	var prepFrame = ds_map_find_value(prepFrames,currentPreparingLimbKey);
	var totalPrepFrames = ds_map_find_value(prepFrameTotals,currentPreparingLimbKey);
	
	// stop preparing, begin attacking
	if prepFrame >= totalPrepFrames-1 {
					
		if attackData.type == AttackTypes.Charge {
			var targetDir = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
			chargePointX = x+lengthdir_x(200,targetDir);
			chargePointY = y+lengthdir_y(200,targetDir);
		}
					
		// find attack data object for this attack to get stamina cost
		var limb = findLimb(id,currentPreparingLimbKey);
		var attackInChain = ds_map_find_value(preparingLimbs,currentPreparingLimbKey);
		var attackData = noone;
		if !isRanged {
			var attackChain = meleeAttacks[attackNumber];
			attackData = attackChain[attackInChain-1];
		} else {
			var attackChain = rangedAttacks[attackNumber];
			attackData = attackChain[attackInChain-1];
		}
		stamina -= attackData.staminaCost;
					
		// update data structures
		ds_map_replace(prepFrames,currentPreparingLimbKey,-1);
		ds_map_replace(prepFrameTotals,currentPreparingLimbKey,0);
		ds_map_delete(preparingLimbs,currentPreparingLimbKey);
		ds_map_replace(attackingLimbs,currentPreparingLimbKey,attackInChain);
					
		// create attack object
		global.owner = id; // passed as param to attackObj
		global.limbKey = currentPreparingLimbKey;
		global.attackData = attackData;
		var attackObj = instance_create_depth(x,y,1,obj_attack);
		
		if attackData.prepSound != noone {
			if audio_emitter_exists(attackPrepSoundEmitter) {
				audio_emitter_gain(attackPrepSoundEmitter, 0);
			}
			if audio_emitter_exists(attackPrepSoundEmitter) {
				audio_emitter_free(attackPrepSoundEmitter); attackPrepSoundEmitter = -1;
			}
		}
					
		hasCalculatedNextAttack = false;
	} else {
		// increment through frames for attack prep
		if isSlowed {
			ds_map_replace(prepFrames,currentPreparingLimbKey,prepFrame+.5);
		} else {
			ds_map_replace(prepFrames,currentPreparingLimbKey,prepFrame+1);
		}
		// if not in proper range, try to get there before attack begins
		if attackData.type == AttackTypes.Charge {
			var minRange = attackData.minRange;
			if distance_to_object(lockOnTarget) < minRange {
				var startDir = (facingDirection+180)%360;
				var chargePrepSpeed =  attackData.chargePrepSpeed > 0 ? attackData.chargePrepSpeed : functionalSpeed;
				moveToNearestFreePoint(startDir,chargePrepSpeed,true,1);
				// TODO -- don't back up into fallzones you egg
				facingDirection = point_direction(x,y,lockOnTarget.x,lockOnTarget.y);
			}
		} else {
			// if preparing a STANDARD melee attack and no attacks are happening with other hand, move back a bit (if you can)
			if ds_map_size(attackingLimbs) == 0 {
				var x1 = x +lengthdir_x(-.5,facingDirection);
				var y1 = y +lengthdir_y(-.5,facingDirection);
		
				if !attackData.isRanged && !place_meeting_layer(x1, y1, obj_solid_parent){
					//moveToNearestFreePoint((facingDirection+180)%360,.5);
				}
			}
		}
	}
	currentPreparingLimbKey = ds_map_find_next(preparingLimbs,currentPreparingLimbKey);
}