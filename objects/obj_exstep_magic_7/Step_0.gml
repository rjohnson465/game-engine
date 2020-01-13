if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

if global.player.currentSpellAttunement == LIGHTNING {
	status = ExerciseStepStatus.Completed;
}


