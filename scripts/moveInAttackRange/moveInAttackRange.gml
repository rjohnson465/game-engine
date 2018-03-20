path_end();

// TODO do not commit to a charge attack if there are obstacles between target
					
if attackFrequencyFrame == -1 {
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
		if !isFrozen {
			hasCalculatedWillDodge = false;
			isStrafing = false;
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
				if dist <= meleeRangeArray[currentMeleeAttack-1] {
					strafeAroundPoint(lockOnTarget.x,lockOnTarget.y,functionalSpeed*.3,orbit);
				} 
			}
			strafeFrame--;
		}
	}
	attackFrequencyFrame--;
}