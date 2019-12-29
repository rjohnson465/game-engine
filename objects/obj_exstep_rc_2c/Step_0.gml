if status != ExerciseStepStatus.InProgress exit;

if global.player.lockOnTarget == exercise.enemy {
	status = ExerciseStepStatus.Completed;
}

// do not let enemy die in this step
if exercise.enemy {
	with exercise.enemy {
		hpRegen = 100;
	}
}


