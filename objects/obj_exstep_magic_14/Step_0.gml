if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

if ((gamepad_is_connected(global.gamePadIndex) && gamepad_button_check_pressed(global.gamePadIndex, gp_face1)) || keyboard_check_pressed(ord("F"))) {
	status = ExerciseStepStatus.Completed;
	
	with exercise {
		instance_destroy(enemyBlocker, 1);
		instance_destroy(enemyBlocker2, 1);
		global.isPopulatingGrids = true;
	}
}

