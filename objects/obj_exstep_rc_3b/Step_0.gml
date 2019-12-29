if status != ExerciseStepStatus.InProgress exit;

if global.player.y > 1920 && global.player.x < 930 {
	status = ExerciseStepStatus.Completed;
}

