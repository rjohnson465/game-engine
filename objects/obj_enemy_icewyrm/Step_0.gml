/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

switch state {
	case CombatantStates.Moving: {
		if !canBurrow || burrowFrame <= 0 {
			path_end();
			speed = 0;
			if instance_exists(lockOnTarget) {
				turnToFacePoint(turnSpeed, lockOnTarget.x, lockOnTarget.y);
			}
			
			isBurrowing = false;
			isInvulnerable = false;
			if alarm[4] <= 0 {
				canBurrow = false;
				randomize();
				var bFrames = random_range(BURROW_FRAMES_FREQ_MIN, BURROW_FRAMES_FREQ_MAX);
				alarm[4] = bFrames;
			}
			
			if !maybeAggro() {
				state = CombatantStates.Idle; break;
			}
			
			break;
		}
		// can only move every x frames, for up to y frames
		if isMoving {
			isBurrowing = true;
			isInvulnerable = true;
		} else {
			isInvulnerable = false;
		}
		burrowFrame--;
		break;
	}
}


if state != CombatantStates.Moving {
	isBurrowing = false;
	isInvulnerable = false;
}