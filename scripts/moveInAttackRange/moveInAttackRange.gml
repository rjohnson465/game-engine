path_end();

if currentRangedAttack == noone && currentMeleeAttack == noone {
	maybeAggro(); exit;
}
var attackNumber = currentMeleeAttack == noone ? currentRangedAttack : currentMeleeAttack;
var isRanged = currentRangedAttack != noone;

// find attack data object
var attackData = noone;
var attackChain = isRanged ? rangedAttacks[attackNumber] : meleeAttacks[attackNumber];
if attackNumberInChain == noone {
	attackData = attackChain[0];
} else {
	attackData = attackChain[attackNumberInChain-1];
}

// TODO do not commit to a charge attack if there are obstacles between target
					
if attackFrequencyFrame < 0 {
	randomize();
	var isRanged = currentMeleeAttack == noone ? true : false;
	if isRanged {
		attackFrequencyFrame = round(random_range(attackFrequencyTotalFramesRanged[0],attackFrequencyTotalFramesRanged[1]));
	} else {
		attackFrequencyFrame = round(random_range(attackFrequencyTotalFramesMelee[0],attackFrequencyTotalFramesMelee[1]));
	}
} else if attackFrequencyFrame == 0 {
	// check if should enter attack state every x frames (some number between ranges specified in attackFrequencyTotalFrames)
	randomize();
	var rand = random_range(1,100);
	if rand <= aggressiveness {
		if !isFrozen && !isShielding {
			hasCalculatedWillDodge = false;
			isStrafing = false;
			if attackData.prepSound != noone {
				if audio_emitter_exists(attackPrepSoundEmitter) { 
					audio_emitter_free(attackPrepSoundEmitter); attackPrepSoundEmitter = -1;
				}
				
				attackPrepSoundEmitter = audio_emitter_create();
				audio_emitter_falloff(attackPrepSoundEmitter, 50, AUDIO_MAX_FALLOFF_DIST, .1);
				audio_emitter_gain(attackPrepSoundEmitter, 1);
				audio_play_sound_on(attackPrepSoundEmitter,attackData.prepSound,0,1);
			}
			
			// prep sounds vocals
			if array_length_1d(attackData.prepSoundsVocals) > 0 {
				randomize();
				var rand = floor(random_range(0, array_length_1d(attackData.prepSoundsVocals)));
				var prepSoundVocal = attackData.prepSoundsVocals[rand];
				
				if (!audio_emitter_exists(attackPrepSoundEmitter)) {
					attackPrepSoundEmitter = audio_emitter_create();
					audio_emitter_falloff(attackPrepSoundEmitter, 50, AUDIO_MAX_FALLOFF_DIST, .1);
					audio_emitter_gain(attackPrepSoundEmitter, 1);
				}
				audio_emitter_gain(attackPrepSoundEmitter, 1);
				audio_play_sound_on(attackPrepSoundEmitter,prepSoundVocal,0,1);
			}
			
			state = CombatantStates.Attacking;
		}
	}
	attackFrequencyFrame--;
} else {
	if currentMeleeAttack != noone {
		// strafe (maybe) and wait
		if strafeFrame == -1 {
			randomize();
			strafeFrame = round(random_range(strafeTotalFrames[0],strafeTotalFrames[1]));
			// check and see if will strafe this period
			randomize();
			var rand = random_range(1,100);
			if rand <= 75 {
				isStrafing = true;
				strafeAngle = point_direction(lockOnTarget.x,lockOnTarget.y,x,y);
				strafeDirection = rand < 37 ? "l" : "r";
			} else isStrafing = false;
		} else {
			if isStrafing {
				var dist = distance_to_object(lockOnTarget);
				var targetRadius = point_distance(x,y,lockOnTarget.x,lockOnTarget.y)-distance_to_object(lockOnTarget);
				var orbit = targetRadius+distance_to_object(lockOnTarget);
				if dist <= getRangeForAttackIndex(currentMeleeAttack,true) /*meleeRangeArray[currentMeleeAttack]*/ {
					strafeAroundPoint(lockOnTarget.x,lockOnTarget.y,functionalSpeed*.3,orbit);
				} 
			}
			strafeFrame--;
		}
	}
	else path_end();
	attackFrequencyFrame--;
}