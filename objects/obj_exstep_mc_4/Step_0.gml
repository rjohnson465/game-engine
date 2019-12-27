if status != ExerciseStepStatus.InProgress exit;

// increment dodgesPerformed when player dodges
with global.player {
	if dodgeFrame == 1 {
		other.dodgesPerformed++;
	}
}

if dodgesPerformed >= 3 {
	status = ExerciseStepStatus.Completed;
}

// do not allow the enemy to be killed during this step 
if exercise.enemy {
	with exercise.enemy {
		hp = 1000;
		maxHp = 1000;
	}
}
