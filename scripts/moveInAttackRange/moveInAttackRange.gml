path_end();
stupidityFrame = 100 - aggressiveness;
					
if attackFrequencyFrame == -1 {
	randomize();
	attackFrequencyFrame = round(random_range(attackFrequencyTotalFrames[0],attackFrequencyTotalFrames[1]));
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