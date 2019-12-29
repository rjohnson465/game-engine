if status != ExerciseStepStatus.InProgress exit;

if ((gamepad_is_connected(global.gamePadIndex) && gamepad_button_check_pressed(global.gamePadIndex, gp_face1)) || keyboard_check_pressed(ord("F"))) {
	status = ExerciseStepStatus.Completed;
}
