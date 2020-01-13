if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

if global.player.currentSpell == "aoe" {
	status = ExerciseStepStatus.Completed;
}


